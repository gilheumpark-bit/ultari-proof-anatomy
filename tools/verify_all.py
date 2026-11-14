#!/usr/bin/env python3
"""Deterministic repository-wide verifier for ultari-proof-anatomy."""
import ast
import concurrent.futures
import hashlib
import json
import os
import pathlib
import re
import shutil
import subprocess
import sys

sys.dont_write_bytecode = True
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
LINK_PAT = re.compile(r"\[`?([^`\]]+)`?\]\(([^)#]+\.(?:lean|tex|py|patch))#L(\d+)(?:-L(\d+))?\)")


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


def _lean_env(cwd):
    env = os.environ.copy()
    if not env.get("LEAN_PATH"):
        lps = [str(p) for b in (cwd, pathlib.Path.home() / ".cache" / "qcts_mathlib_v435") for p in [b / ".lake" / "build" / "lib" / "lean", *b.glob(".lake/packages/*/.lake/build/lib/lean")] if p.is_dir()]
        if lps:
            env["LEAN_PATH"] = ":".join(lps)
    return env


def _run_single_mutation(args):
    src, start, end, open_ch, close_ch, names, fname, env = args
    binder_str = " ".join(names)
    mutated = src[:start] + f"{open_ch}{binder_str} : True{close_ch}" + src[end:]
    r = subprocess.run([LEAN_BIN, "--stdin"], input=mutated, env=env, capture_output=True, text=True, timeout=60)
    return binder_str, fname, r.returncode


def check_lean_and_mutations(lean_file):
    src = lean_file.read_text(encoding="utf-8")
    assert not re.search(r"\b(?:sorry|admit)\b", re.sub(r"--[^\n]*|/-.*?-/", "", src, flags=re.S))
    env = _lean_env(lean_file.parent)
    res = subprocess.run([LEAN_BIN, "--stdin"], input=src, cwd=str(lean_file.parent), env=env, capture_output=True, text=True, timeout=60)
    assert res.returncode == 0, f"Lean compile failed on {lean_file}:\n{res.stderr}\n{res.stdout}"
    hyps = extract_balanced_hyps(src)
    for (_, _, _, _, names, hbody) in hyps:
        assert " / " not in hbody, f"Truncating Int division '/' in hypothesis {names} of {lean_file.name}: {hbody}"
        assert not re.match(
            r"^\s*(?:[A-Za-z_][\w']*\s*=\s*(?:[A-Za-z_][\w']*\s*\+\s*)?\d{3,}\s*\*\s*[A-Za-z_][\w']*\s*\+\s*(?:[2-9]\d*|1\d+)\s*$|\d{2,}\s*\*\s*[A-Za-z_][\w']*\s*\+\s*(?:[2-9]\d*|1\d+)\s*=|(?:log|ln|pi|exp)\w*_\d+\s*=\s*\d{3,}\s*$)",
            hbody,
        ), (
            f"Euclidean divmod or transcendental constant-pin smuggling in hypothesis {names} of {lean_file.name}: {hbody}"
        )
    tasks = [(src, s, e, och, cch, names, lean_file.name, env) for (s, e, och, cch, names, _) in hyps]
    workers = os.cpu_count() or 8
    with concurrent.futures.ThreadPoolExecutor(max_workers=workers) as ex:
        for bname, fname, rc in ex.map(_run_single_mutation, tasks):
            assert rc != 0, f"Vacuous hypothesis survived mutation: {bname} in {fname}"
    thms = list(THM_DECL_PAT.finditer(src))
    t_bounds = [m.start() for m in thms] + [len(src)]
    struct_cnt = sum(
        1
        for i, m in enumerate(thms)
        if (blk := src[m.start() : t_bounds[i + 1]])
        and (
            re.search(r"\([^)]*(?:≤|<|≥|>|≠|∨|↔|→|\bTrue\b|\bFalse\b)[^)]*\)", blk.split(":=")[0])
            or re.search(r"[a-zA-Z0-9_)\]]\s*(?:\*|\^)\s*[a-zA-Z_(]", blk)
            or re.search(r"\b(?:induction|cases|rcases|obtain|calc|nlinarith|ring|positivity|exact)\b", blk)
        )
    )
    assert not thms or struct_cnt / len(thms) >= 0.55, (
        f"Excessive literal-plugging theorems in {lean_file.name}: only {struct_cnt}/{len(thms)} structural"
    )
    print(f"  [PASS] Lean 4 kernel check ({lean_file.name}, 0 sorry, {len(hyps)}/{len(hyps)} hypothesis mutations caught, {struct_cnt}/{len(thms)} structural)")
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
    oai_ref_dir = case_dir / "proofs" / "oai_ref"
    ref_files = [p for p in oai_ref_dir.rglob("*") if p.is_file() and p.suffix in (".lean", ".tex", ".patch")] if oai_ref_dir.is_dir() else []
    assert len(ref_files) >= 9, f"Missing or incomplete proofs/oai_ref/ in {case_dir.name} (found {len(ref_files)} reference files, expected >= 9)"
    full_md_blob = "\n".join(md.read_text(encoding="utf-8") for md in md_files)
    uncited_refs = [p.name for p in ref_files if p.name not in full_md_blob]
    assert not uncited_refs, f"Uncited proofs/oai_ref/ files in {case_dir.name}: {uncited_refs[:5]}"
    py_fn_spans = {
        (p.name, n.name): (n.lineno, getattr(n, "end_lineno", n.lineno))
        for p in (case_dir / "proofs").glob("verify_*.py")
        for n in ast.walk(ast.parse(p.read_text(encoding="utf-8", errors="replace")))
        if isinstance(n, ast.FunctionDef)
    }
    link_count = 0
    oai_link_count = 0
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
            if "oai_ref" in rel_p:
                oai_link_count += 1
            elif resolved.suffix == ".lean":
                tmap = thm_lines_by_file[resolved.name]
                if label in tmap:
                    assert tmap[label] == l1, f"Line mismatch in {md.name} for {label}: L{l1} != L{tmap[label]}"
            elif resolved.suffix == ".py" and re.match(r"^verify_[A-Za-z0-9_]+$", label):
                assert (resolved.name, label) in py_fn_spans, f"Ghost verifier function in {md.name}: {label} not in {resolved.name}"
                fn_s, fn_e = py_fn_spans[(resolved.name, label)]
                assert l1 <= fn_e and l2 >= fn_s, f"Line range mismatch in {md.name} for {label}: L{l1}-L{l2} vs AST L{fn_s}-L{fn_e}"
            link_count += 1
    assert oai_link_count >= 50, f"Insufficient oai_ref/#L links in {case_dir.name} (found {oai_link_count}, expected >= 50)"
    print(f"  [PASS] 1-to-1 theorem & line-number links ({len(all_thms)} theorems, {link_count} markdown links, {len(ref_files)} oai_ref files 100% cited)")


def check_doc_depth(case_dir):
    all_mds = list(case_dir.glob("*.md")) + list((case_dir / "en").glob("*.md")) + list((case_dir / "ko").glob("*.md"))
    for md in all_mds:
        txt = md.read_text(encoding="utf-8")
        for bad_ch in ("\x07", "\x08", "\x0b", "\x0c", "\t"):
            assert bad_ch not in txt, f"Corrupted control character {repr(bad_ch)} in {md.relative_to(case_dir)}"
    subs = [case_dir / s for s in ("ko", "en") if (case_dir / s).is_dir()] or [case_dir]
    depth_tiers = (("01_", 45, 2500), ("02_", 75, 4500), ("03_", 115, 8000))
    for base in subs:
        for prefix, min_lines, min_bytes in depth_tiers:
            matches = list(base.glob(f"{prefix}*.md"))
            assert matches, f"Missing {prefix}*.md in {base}"
            for md in matches:
                raw = md.read_bytes()
                lines = raw.decode("utf-8", errors="replace").splitlines()
                assert len(lines) >= min_lines and len(raw) >= min_bytes, (
                    f"Shallow document detected ({md.relative_to(case_dir)}: {len(lines)} lines < {min_lines} or {len(raw)} bytes < {min_bytes})"
                )
    print("  [PASS] Documentation completeness and tiered depth (01>=45L/2.5KB, 02>=75L/4.5KB, 03>=115L/8KB)")


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
    check_doc_depth(case_dir)


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
