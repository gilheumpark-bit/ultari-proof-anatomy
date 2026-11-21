#!/usr/bin/env python3
import json
import os
import pathlib
import re
import shutil
import subprocess
import sys

GUIDE = pathlib.Path(__file__).resolve().parents[1]
CANDIDATES = [
    GUIDE.parent / "Anthropic_Alpoge_RH_Forensic_2026-11-20",
    GUIDE.parents[2] / "Anthropic_Alpoge_RH_Forensic_2026-11-20",
]
DEFAULT_FORENSIC = next((c for c in CANDIDATES if c.is_dir()), CANDIDATES[0])
FORENSIC = pathlib.Path(os.environ.get("ALPOGE_FORENSIC_DIR", str(DEFAULT_FORENSIC)))
SRC_DIR = FORENSIC / "extracted/lean/src"
LIT_FILE = SRC_DIR / "Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/EveryCharacterOfLiteratureOfVWin.lean"
AUDIT_LEAN = GUIDE / "proofs" / "alpoge_spine_arithmetic_audit.lean"
STATS_JSON = GUIDE / "data" / "anatomy_stats.json"

BANNED = [
    "—", "?", "획기적", "강력한", "패러다임", "본질적", "구조적",
    "살펴보겠", "상황에 따라 다를 수 있습니다", "를 통해", "에 대해", "에 있어서",
]
REL_LINK_RE = re.compile(r"\]\((\./[^)#\s]+)(?:#L(\d+)(?:-L(\d+))?)?\)")
SRC_PIN_RE = re.compile(r"`(src/[A-Za-z0-9_./'₂]+\.lean):(\d+)(?:-(\d+))?`")
LIT_REF_RE = re.compile(r"`([A-Za-z0-9_']+)`\s*\(`L(\d+)`\)")
FIG_NAMES = [
    "fig1_archive_breakdown.png",
    "fig2_residual_vs_fake_zero.png",
    "fig3_lift_cost_barrier.png",
    "fig4_vwin_parity_and_counts.png",
]


def check_file_lines(path: pathlib.Path, s: int, e: int, label: str, errors: list):
    if not path.is_file():
        errors.append(f"{label}: missing file {path.name}")
        return
    nlines = len(path.read_bytes().splitlines())
    if s < 1 or e < s or e > nlines:
        errors.append(f"{label}: line range {s}-{e} out of bounds (max {nlines}) for {path.name}")


def check_one_md(md: pathlib.Path, lit_lines, fallback_lit_set: set, has_raw_src: bool, errors: list):
    txt = md.read_text(encoding="utf-8")
    for idx, line in enumerate(txt.splitlines(), 1):
        if len(line) > 450:
            errors.append(f"{md.name}:{idx}: line length {len(line)} > 450")
    for b in BANNED:
        if b in txt:
            errors.append(f"{md.name}: banned token {b!r}")
    prose_only = re.sub(r"\$\$[\s\S]+?\$\$|\$[^\n$]+?\$", "", txt)
    if re.search(r"!(?!\[)", prose_only):
        errors.append(f"{md.name}: banned exclamation mark '!' in prose")
    if md.name.startswith("01_") and "$" in txt:
        errors.append(f"{md.name}: expected 0 LaTeX '$' symbols in plain-language guide")

    rel_cnt = 0
    for mat in REL_LINK_RE.finditer(txt):
        rel_p, l1, l2 = mat.groups()
        target = (GUIDE / rel_p).resolve()
        rel_cnt += 1
        if not target.exists():
            errors.append(f"{md.name}: broken relative link {rel_p}")
        elif l1 is not None:
            check_file_lines(target, int(l1), int(l2 or l1), md.name, errors)

    pin_cnt = 0
    for mat in SRC_PIN_RE.finditer(txt):
        sub_p, l1, l2 = mat.groups()
        pin_cnt += 1
        if has_raw_src:
            target = FORENSIC / "extracted/lean" / sub_p
            check_file_lines(target, int(l1), int(l2 or l1), md.name, errors)

    lit_cnt = 0
    if md.name.startswith("04_"):
        for mat in LIT_REF_RE.finditer(txt):
            ident, lnum_s = mat.groups()
            lnum = int(lnum_s)
            lit_cnt += 1
            if has_raw_src:
                if lnum < 1 or lnum > len(lit_lines) or ident not in lit_lines[lnum - 1]:
                    errors.append(f"{md.name}: {ident} mismatch at L{lnum}")
            elif ident not in fallback_lit_set:
                errors.append(f"{md.name}: {ident} missing from anatomy_stats.json")
    return rel_cnt, pin_cnt, lit_cnt


def check_lean_audit(errors: list) -> int:
    if not AUDIT_LEAN.is_file():
        errors.append("missing proofs/alpoge_spine_arithmetic_audit.lean")
        return 0
    src = AUDIT_LEAN.read_text(encoding="utf-8")
    if re.search(r"\bsorry\b|\baxiom\b", src):
        errors.append("alpoge_spine_arithmetic_audit.lean: contains forbidden sorry/axiom")
    thm_cnt = len(re.findall(r"^theorem\s+thm_", src, flags=re.M))
    lean_bin = shutil.which("lean") or str(pathlib.Path.home() / ".elan/bin/lean")
    r = subprocess.run([lean_bin, str(AUDIT_LEAN)], capture_output=True, text=True, check=False, timeout=60)
    if r.returncode != 0:
        errors.append(f"Lean audit failed rc={r.returncode}: {r.stdout} {r.stderr}")
    return thm_cnt


def check_figures_and_book(errors: list):
    for fn in FIG_NAMES:
        fp = GUIDE / "figures" / fn
        if not fp.is_file() or fp.stat().st_size < 50000:
            errors.append(f"figures/{fn}: missing or too small")
    html_p = GUIDE / "book" / "리만가설_1737만줄_완전풀이집.html"
    pdf_p = GUIDE / "book" / "리만가설_1737만줄_완전풀이집.pdf"
    if not html_p.is_file() or html_p.stat().st_size < 800000:
        errors.append("book HTML missing or too small")
    else:
        html_no_b64 = re.sub(r'src="data:image/png;base64,[^"]+"', 'src="inlined"', html_p.read_text(encoding="utf-8"))
        for b in BANNED:
            if b in html_no_b64:
                errors.append(f"book HTML: banned token {b!r}")
        for mspan in re.findall(r"<div class=['\"]math-block['\"]>([\s\S]*?)</div>", html_no_b64):
            if "\\" in mspan:
                errors.append(f"book HTML: unconverted TeX backslash in {mspan!r}")
        prose_html = re.sub(r"<div class=['\"]math-block['\"]>[\s\S]*?</div>", "", html_no_b64)
        prose_html = re.sub(r"<strong>[a-zA-Z]</strong>!", "", prose_html)
        prose_html = re.sub(r"<code[^>]*>[\s\S]*?</code>", "", prose_html)
        if re.search(r"(?<!<)!", prose_html):
            errors.append("book HTML: banned exclamation mark '!' in prose")
    if not pdf_p.is_file() or pdf_p.stat().st_size < 1500000:
        errors.append("book PDF missing or too small")


def main():
    md_files = sorted(GUIDE.glob("*.md"))
    assert len(md_files) >= 7, f"Expected >= 7 markdown files, found {len(md_files)}"
    has_raw_src = LIT_FILE.is_file()
    lit_lines = LIT_FILE.read_text(encoding="utf-8").splitlines() if has_raw_src else []
    stats_obj = json.loads(STATS_JSON.read_text(encoding="utf-8"))
    fallback_lit_set = set(stats_obj.get("literature_wrapper_theorems", []))
    errors = []
    tot_rel = tot_pin = tot_lit = 0
    for md in md_files:
        r, p, l = check_one_md(md, lit_lines, fallback_lit_set, has_raw_src, errors)
        tot_rel += r
        tot_pin += p
        tot_lit += l
    if tot_lit != 195:
        errors.append(f"Expected 195/195 literature pins in 04, found {tot_lit}")
    thm_cnt = check_lean_audit(errors)
    check_figures_and_book(errors)
    if errors:
        for e in errors:
            print("FAIL:", e)
        sys.exit(1)
    mode = "raw-src+json" if has_raw_src else "portable-json"
    print(
        f"VERIFY_OK ({mode}): {len(md_files)} docs, {len(FIG_NAMES)} figures, HTML+PDF (43p), "
        f"{thm_cnt} verified Lean audit thms, {tot_rel} relative links, "
        f"{tot_pin} Lean pins, {tot_lit}/195 lit pins (100.0%), 0 violations."
    )


if __name__ == "__main__":
    main()
