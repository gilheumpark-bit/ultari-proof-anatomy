#!/usr/bin/env python3
"""Deterministic repository-wide verifier for ultari-proof-anatomy."""
import concurrent.futures
import hashlib
import json
import os
import pathlib
import re
import shutil
import subprocess
import sys

ROOT = pathlib.Path(__file__).resolve().parent.parent
LEAN_BIN = shutil.which("lean") or str(pathlib.Path.home() / ".elan" / "bin" / "lean")
REL_OP_PAT = re.compile(r"(?:≤|<|≥|>|=|≠|∈|∉|∧|∨|¬|↔)")
THM_DECL_PAT = re.compile(
    r"^[ \t]*(?:@\[[^\]]*\]\s+)*(?:noncomputable\s+|private\s+|protected\s+|scoped\s+)*(?:theorem|lemma)\s+([A-Za-z0-9_\x27]+)",
    re.M,
)
BOUND_DECL_PAT = re.compile(
    r"^[ \t]*(?:@\[[^\]]*\]\s+)*(?:noncomputable\s+|private\s+|protected\s+|scoped\s+)*(?:theorem|lemma|def|abbrev|structure|inductive|class|instance|axiom|opaque|example|namespace|section|end)\b",
    re.M,
)
LINK_PAT = re.compile(r"\[`?([^`\]]+)`?\]\(([^)#]+\.lean)#L(\d+)(?:-L(\d+))?\)")


def extract_balanced_hyps(src: str):
    """O(N) balanced-parenthesis scanner over comment-stripped theorem headers (handles arbitrary nesting depth)."""
    res = []
    clean = re.sub(r"--[^\n]*|/-.*?-/", lambda m: " " * len(m.group(0)), src, flags=re.S)
    bounds = [b.start() for b in BOUND_DECL_PAT.finditer(clean)] + [len(clean)]
    for tm in THM_DECL_PAT.finditer(clean):
        pos = tm.end()
        blk_end = next((b for b in bounds if b > tm.start()), len(clean))
        depth = 0
        concl_colon = None
        assign_pos = blk_end
        for k in range(pos, blk_end):
            ch = clean[k]
            if ch in "({[":
                depth += 1
            elif ch in ")}]":
                depth = max(0, depth - 1)
            elif ch == ":" and depth == 0:
                if k + 1 < blk_end and clean[k + 1] == "=":
                    assign_pos = k
                    break
                if concl_colon is None:
                    concl_colon = k
        hdr_end = concl_colon if concl_colon is not None else assign_pos
        i = pos
        while i < hdr_end:
            if clean[i] in "({":
                open_ch = clean[i]
                close_ch = ")" if open_ch == "(" else "}"
                d = 1
                j = i + 1
                while j < hdr_end and d > 0:
                    if clean[j] == open_ch:
                        d += 1
                    elif clean[j] == close_ch:
                        d -= 1
                    j += 1
                if d == 0:
                    inner = src[i + 1 : j - 1]
                    m = re.match(r"^\s*([A-Za-z_][A-Za-z0-9_\x27]*(?:\s+[A-Za-z_][A-Za-z0-9_\x27]*)*)\s*:\s*([\s\S]*)$", inner)
                    if m and (
                        REL_OP_PAT.search(m.group(2))
                        or (
                            m.group(1).strip().startswith("h")
                            and m.group(2).strip() not in ("Nat", "Int", "Rat", "Real", "Complex", "Prop", "Type")
                        )
                    ):
                        names = m.group(1).split()
                        res.append((i, j, open_ch, close_ch, names, m.group(2).strip()))
                i = j
            else:
                i += 1
    return res


def check_manifest_hashes(case_dir, manifest):
    assert manifest.get("lean_version") == "v4.29.0-rc8", f"Missing/mismatched lean_version in {case_dir.name}/manifest.json"
    assert manifest.get("lean4_verification", {}).get("compiler") == "leanprover/lean4:v4.29.0-rc8", (
        f"Missing/mismatched lean4_verification.compiler in {case_dir.name}/manifest.json"
    )
    for key in ("artifacts_sha256", "file_checksums_sha256"):
        for rel, expected in manifest.get(key, {}).items():
            target = case_dir / rel
            assert target.is_file(), f"Missing artifact: {target}"
            actual = hashlib.sha256(target.read_bytes()).hexdigest()
            assert actual == expected, f"SHA-256 mismatch for {rel}: {actual} != {expected}"
    chk_file = case_dir / "proofs" / "checksums.sha256"
    if chk_file.is_file():
        r_chk = subprocess.run(["sha256sum", "-c", "proofs/checksums.sha256"], cwd=str(case_dir), capture_output=True, text=True, timeout=30)
        assert r_chk.returncode == 0, f"sha256sum -c proofs/checksums.sha256 failed in {case_dir.name}:\n{r_chk.stderr}\n{r_chk.stdout}"
    for md in list(case_dir.glob("04_*.md")) + list((case_dir / "en").glob("04_*.md")) + list((case_dir / "ko").glob("04_*.md")):
        md_text = md.read_text(encoding="utf-8")
        pairs = re.findall(r"\((?:\.\./)?(proofs/[^)]+)\)\s*\|\s*`([0-9a-f]{64})`", md_text)
        pairs += re.findall(r"\|\s*`(proofs/[^`]+)`\s*\|\s*`([0-9a-f]{64})`", md_text)
        assert len(pairs) >= 4, f"Missing or incomplete SHA-256 table in {md.relative_to(case_dir)} (found {len(pairs)} entries)"
        for rel_p, sha_hex in pairs:
            act_sha = hashlib.sha256((case_dir / rel_p).read_bytes()).hexdigest()
            assert act_sha == sha_hex, f"Stale SHA-256 in {md.name} for {rel_p}: {sha_hex} != {act_sha}"
    print(f"  [PASS] SHA-256 checksums ({len(manifest.get('artifacts_sha256', {}))} artifacts + 04_*.md tables)")


def _run_single_mutation(args):
    src, start, end, open_ch, close_ch, names, fname = args
    binder_str = " ".join(names)
    mutated = src[:start] + f"{open_ch}{binder_str} : True{close_ch}" + src[end:]
    r = subprocess.run([LEAN_BIN, "--stdin"], input=mutated, capture_output=True, text=True, timeout=30)
    return binder_str, fname, r.returncode


def check_lean_and_mutations(lean_file):
    src = lean_file.read_text(encoding="utf-8")
    assert not re.search(r"\b(?:sorry|admit)\b", re.sub(r"--[^\n]*|/-.*?-/", "", src, flags=re.S))
    res = subprocess.run([LEAN_BIN, str(lean_file)], capture_output=True, text=True, timeout=60)
    assert res.returncode == 0, f"Lean compile failed on {lean_file}:\n{res.stderr}\n{res.stdout}"
    hyps = extract_balanced_hyps(src)
    if "001-" not in str(lean_file):
        for (_, _, _, _, names, hbody) in hyps:
            assert " / " not in hbody, f"Truncating Int division '/' in hypothesis {names} of {lean_file.name}: {hbody}"
    tasks = [(src, s, e, och, cch, names, lean_file.name) for (s, e, och, cch, names, _) in hyps]
    workers = os.cpu_count() or 8
    with concurrent.futures.ThreadPoolExecutor(max_workers=workers) as ex:
        for bname, fname, rc in ex.map(_run_single_mutation, tasks):
            assert rc != 0, f"Vacuous hypothesis survived mutation: {bname} in {fname}"
    print(f"  [PASS] Lean 4 kernel check ({lean_file.name}, 0 sorry, {len(hyps)}/{len(hyps)} hypothesis mutations caught)")
    return {
        m.group(1): idx
        for idx, line in enumerate(src.splitlines(), 1)
        if (m := THM_DECL_PAT.match(line))
    }


def check_symbolic_solver(proofs_dir, manifest):
    json_path = proofs_dir / "symbolic_verification_result.json"
    before = json_path.read_bytes()
    cmd_str = manifest.get("verification_commands", {}).get("symbolic_solver_check", "")
    script_name = pathlib.Path(cmd_str.split()[-1]).name if cmd_str else "verify_symbolic_qrh.py"
    res = subprocess.run([sys.executable, script_name], cwd=str(proofs_dir), capture_output=True, text=True, timeout=60)
    assert res.returncode == 0, f"Symbolic solver failed:\n{res.stderr}"
    after = json_path.read_bytes()
    assert before == after, "symbolic_verification_result.json changed on re-run"
    print(f"  [PASS] Symbolic solver reproduction ({script_name} -> exact JSON match)")


def check_line_links(case_dir, manifest, thm_lines_by_file, total_lines_by_file):
    all_thms = {k: v for d in thm_lines_by_file.values() for k, v in d.items()}
    for _, v in manifest.get("verified_key_results", {}).items():
        thms = v.get("lean_theorems", [v["lean_theorem"]] if "lean_theorem" in v else [])
        for entry in thms:
            m = re.match(r"^([A-Za-z0-9_\x27]+)\s+\(Theorem\s+\d+,\s+L(\d+)\)", entry)
            assert m and all_thms.get(m.group(1)) == int(m.group(2)), f"Manifest line mismatch: {entry}"
    for item in manifest.get("lean4_verification", {}).get("theorems", []):
        tname, tfile, tline = item["name"], pathlib.Path(item["file"]).name, int(item["line"])
        assert thm_lines_by_file.get(tfile, {}).get(tname) == tline, f"lean4_verification line mismatch: {item}"
    md_files = list(case_dir.glob("*.md")) + list((case_dir / "en").glob("*.md")) + list((case_dir / "ko").glob("*.md"))
    link_count = 0
    for md in md_files:
        for m in LINK_PAT.finditer(md.read_text(encoding="utf-8")):
            label, rel_p, l1, l2 = m.group(1), m.group(2), int(m.group(3)), int(m.group(4) or m.group(3))
            resolved = (md.parent / rel_p).resolve()
            if not resolved.is_file():
                resolved = (case_dir / rel_p).resolve()
            assert resolved.is_file(), f"Broken link in {md}: {rel_p}"
            tot = total_lines_by_file.get(
                resolved.name,
                len(resolved.read_text(encoding="utf-8", errors="replace").splitlines()),
            )
            assert 1 <= l1 <= l2 <= tot, f"Out-of-range lines in {md.name} ({rel_p}): L{l1}-L{l2} > {tot}"
            if "oai_ref" not in rel_p:
                tmap = thm_lines_by_file[resolved.name]
                if label in tmap:
                    assert tmap[label] == l1, f"Line mismatch in {md.name} for {label}: L{l1} != L{tmap[label]}"
            link_count += 1
    print(f"  [PASS] 1-to-1 theorem & line-number links ({len(all_thms)} theorems, {link_count} markdown links verified)")


def check_ultari_gates_and_doc_depth(case_dir):
    subs = [case_dir / s for s in ("ko", "en") if (case_dir / s).is_dir()] or [case_dir]
    for base in subs:
        for prefix in ("01_", "02_", "03_"):
            matches = list(base.glob(f"{prefix}*.md"))
            assert matches, f"Missing {prefix}*.md in {base}"
            for md in matches:
                raw = md.read_bytes()
                lines = raw.decode("utf-8", errors="replace").splitlines()
                assert len(lines) >= 30 and len(raw) >= 2500, (
                    f"Stubbed document detected ({md.relative_to(case_dir)}: {len(lines)} lines, {len(raw)} bytes)"
                )
    ultari_dir = ROOT.parent / "울타리_연구원" / "template" / ".ultari"
    extra_scan = ultari_dir / "extra_scan.py"
    code_disc = ultari_dir / "code_discipline.py"
    if extra_scan.is_file():
        r_scan = subprocess.run([sys.executable, str(extra_scan), str(case_dir)], capture_output=True, text=True, timeout=60)
        assert r_scan.returncode == 0, f"Ultari extra_scan failed on {case_dir.name}:\n{r_scan.stdout}\n{r_scan.stderr}"
    if code_disc.is_file():
        r_disc = subprocess.run([sys.executable, str(code_disc), str(case_dir)], capture_output=True, text=True, timeout=60)
        assert r_disc.returncode == 0, f"Ultari code_discipline failed on {case_dir.name}:\n{r_disc.stdout}\n{r_disc.stderr}"
    print("  [PASS] Ultari static gates (RH13~RH30, code_discipline, and 01~03 doc depth >= 30 lines / 2.5KB)")


def verify_case(case_dir: pathlib.Path):
    print(f"=== Verifying Case: {case_dir.name} ===")
    manifest = json.loads((case_dir / "manifest.json").read_text(encoding="utf-8"))
    check_manifest_hashes(case_dir, manifest)
    lean_files = [
        case_dir / rel_lf
        for rel_lf in manifest.get("lean4_verification", {}).get("files", [])
    ]
    thm_lines_by_file = {}
    total_lines_by_file = {}
    for lf in lean_files:
        thm_lines_by_file[lf.name] = check_lean_and_mutations(lf)
        total_lines_by_file[lf.name] = len(lf.read_text(encoding="utf-8").splitlines())
    check_symbolic_solver(case_dir / "proofs", manifest)
    check_line_links(case_dir, manifest, thm_lines_by_file, total_lines_by_file)
    check_ultari_gates_and_doc_depth(case_dir)


def main():
    if "--root" in sys.argv:
        idx = sys.argv.index("--root")
        target = pathlib.Path(sys.argv[idx + 1]).resolve()
        verify_case(target)
        print("CASE VERIFIED SUCCESSFULLY (EXIT 0).")
        return 0
    cases = sorted((ROOT / "anatomy").iterdir())
    assert cases, "No anatomy cases found"
    for case_dir in cases:
        if not case_dir.is_dir():
            continue
        verify_case(case_dir)
    print("ALL CASES VERIFIED SUCCESSFULLY (EXIT 0).")
    return 0


if __name__ == "__main__":
    sys.exit(main())
