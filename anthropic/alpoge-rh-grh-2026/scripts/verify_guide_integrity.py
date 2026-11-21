#!/usr/bin/env python3
from html.parser import HTMLParser
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
REL_LINK_RE = re.compile(r"\]\((\.\.?/[^)#\s]+)(?:#L(\d+)(?:-L(\d+))?)?\)")
ANY_LEAN_PIN_RE = re.compile(r"`((?:src/)?[A-Za-z0-9_./'₂]+\.lean):(\d+)(?:-(\d+))?`")
LIT_REF_RE = re.compile(r"`([A-Za-z0-9_']+)`\s*\(`L(\d+)`\)")
FIG_NAMES = [
    "fig1_archive_breakdown.png",
    "fig2_residual_vs_fake_zero.png",
    "fig3_lift_cost_barrier.png",
    "fig4_vwin_parity_and_counts.png",
    "fig1_archive_breakdown_en.png",
    "fig2_residual_vs_fake_zero_en.png",
    "fig3_lift_cost_barrier_en.png",
    "fig4_vwin_parity_and_counts_en.png",
]
BOOK_SPECS = [
    ("KO", "리만가설_1737만줄_완전풀이집.html", "리만가설_1737만줄_완전풀이집.pdf"),
    ("EN", "Alpoge_RH_17M_Complete_Decompilation_EN.html", "Alpoge_RH_17M_Complete_Decompilation_EN.pdf"),
]


class BookHTMLAuditor(HTMLParser):
    def __init__(self):
        super().__init__(convert_charrefs=True)
        self.stack = []
        self.math_depth = 0
        self.code_depth = 0
        self.cur_math = []
        self.math_texts = []
        self.prose_chunks = []

    def handle_starttag(self, tag, attrs):
        cls_tokens = set(dict(attrs).get("class", "").split())
        is_math = bool(cls_tokens & {"math-block", "math-inline"})
        is_code = tag in {"code", "pre", "style", "script"}
        if is_math:
            if self.math_depth == 0:
                self.cur_math = []
            self.math_depth += 1
        if is_code:
            self.code_depth += 1
        self.stack.append((tag, is_math, is_code))

    def handle_endtag(self, tag):
        if not self.stack:
            return
        _, is_math, is_code = self.stack.pop()
        if is_math:
            self.math_depth -= 1
            if self.math_depth == 0:
                self.math_texts.append("".join(self.cur_math))
                self.cur_math = []
        if is_code:
            self.code_depth -= 1

    def handle_data(self, data):
        if self.math_depth > 0:
            self.cur_math.append(data)
        elif self.code_depth == 0:
            self.prose_chunks.append(data)


def build_lean_suffix_index(src_dir: pathlib.Path) -> dict:
    by_name = {}
    if not src_dir.is_dir():
        return by_name
    for p in src_dir.rglob("*.lean"):
        by_name.setdefault(p.name, []).append(p)
    return by_name


def check_file_lines(path: pathlib.Path, s: int, e: int, label: str, errors: list):
    if not path.is_file():
        errors.append(f"{label}: missing file {path.name}")
        return
    nlines = len(path.read_bytes().splitlines())
    if s < 1 or e < s or e > nlines:
        errors.append(f"{label}: line range {s}-{e} out of bounds (max {nlines}) for {path.name}")


def check_md_delimiters(md_label: str, txt: str, errors: list):
    lines_no_fence = []
    in_fence = False
    for idx, line in enumerate(txt.splitlines(), 1):
        if line.lstrip().startswith("```"):
            in_fence = not in_fence
            lines_no_fence.append("")
            continue
        if in_fence:
            lines_no_fence.append("")
            continue
        if line.count("`") % 2 != 0:
            errors.append(f"{md_label}:{idx}: odd backtick count ({line.count('`')})")
        if re.match(r"^ {1,3}(?:[-*]|\d+\.)\s", line):
            errors.append(f"{md_label}:{idx}: sub-list item must use 4-space indent for Python-Markdown")
        lines_no_fence.append(re.sub(r"`[^`\n]*`", "", line))
    if in_fence:
        errors.append(f"{md_label}: unclosed fenced code block")

    joined = "\n".join(lines_no_fence)
    if joined.count("$$") % 2 != 0:
        errors.append(f"{md_label}: odd display-math '$$' delimiter count")

    def strip_display(mat):
        inner = mat.group(1)
        if "$" in inner:
            errors.append(f"{md_label}: stray '$' inside display math block")
        return "\n" * inner.count("\n")

    inline_only = re.sub(r"\$\$([\s\S]+?)\$\$", strip_display, joined)
    for idx, line in enumerate(inline_only.splitlines(), 1):
        if line.count("$") % 2 != 0:
            errors.append(f"{md_label}:{idx}: odd inline-math '$' delimiter count")


def check_one_md(md: pathlib.Path, lit_lines, fallback_lit_set: set, lean_idx: dict, has_raw_src: bool, errors: list):
    md_label = str(md.relative_to(GUIDE))
    txt = md.read_text(encoding="utf-8")
    for idx, line in enumerate(txt.splitlines(), 1):
        if len(line) > 450:
            errors.append(f"{md_label}:{idx}: line length {len(line)} > 450")
    for b in BANNED:
        if b in txt:
            errors.append(f"{md_label}: banned token {b!r}")
    check_md_delimiters(md_label, txt, errors)

    prose_only = re.sub(r"```[\s\S]*?```|`[^`\n]*`|\$\$[\s\S]+?\$\$|\$[^\n$]+?\$", "", txt)
    if re.search(r"!(?!\[)", prose_only):
        errors.append(f"{md_label}: banned exclamation mark '!' in prose")
    if md.name.startswith("01_") and "$" in txt:
        errors.append(f"{md_label}: expected 0 LaTeX '$' symbols in plain-language guide")

    rel_cnt = 0
    for mat in REL_LINK_RE.finditer(txt):
        rel_p, l1, l2 = mat.groups()
        target = (md.parent / rel_p).resolve()
        rel_cnt += 1
        if not target.exists():
            errors.append(f"{md_label}: broken relative link {rel_p}")
        elif l1 is not None:
            check_file_lines(target, int(l1), int(l2 or l1), md_label, errors)

    pin_cnt = 0
    for mat in ANY_LEAN_PIN_RE.finditer(txt):
        sub_p, l1, l2 = mat.groups()
        s_ln, e_ln = int(l1), int(l2 or l1)
        pin_cnt += 1
        if not has_raw_src:
            continue
        if sub_p.startswith("src/"):
            check_file_lines(FORENSIC / "extracted/lean" / sub_p, s_ln, e_ln, md_label, errors)
        else:
            cands = [p for p in lean_idx.get(pathlib.Path(sub_p).name, []) if str(p).endswith(sub_p)]
            if not cands:
                errors.append(f"{md_label}: unresolved Lean pin {sub_p}:{l1}")
            elif not any(1 <= s_ln <= e_ln <= len(p.read_bytes().splitlines()) for p in cands):
                errors.append(f"{md_label}: line range {s_ln}-{e_ln} out of bounds for {sub_p}")

    lit_cnt = 0
    if md.name.startswith("04_"):
        for mat in LIT_REF_RE.finditer(txt):
            ident, lnum_s = mat.groups()
            lnum = int(lnum_s)
            lit_cnt += 1
            if has_raw_src:
                if lnum < 1 or lnum > len(lit_lines) or ident not in lit_lines[lnum - 1]:
                    errors.append(f"{md_label}: {ident} mismatch at L{lnum}")
            elif ident not in fallback_lit_set:
                errors.append(f"{md_label}: {ident} missing from anatomy_stats.json")
        if lit_cnt != 195:
            errors.append(f"{md_label}: expected 195/195 literature pins, found {lit_cnt}")
    return rel_cnt, pin_cnt, lit_cnt


def check_lean_audit(errors: list) -> int:
    if not AUDIT_LEAN.is_file():
        errors.append("missing proofs/alpoge_spine_arithmetic_audit.lean")
        return 0
    src = AUDIT_LEAN.read_text(encoding="utf-8")
    if re.search(r"\bsorry\b|\baxiom\b|\bunsafe\b|\bimplemented_by\b|\bextern\b", src):
        errors.append("alpoge_spine_arithmetic_audit.lean: contains forbidden sorry/axiom/unsafe")
    thm_cnt = len(re.findall(r"^theorem\s+thm_", src, flags=re.M))
    lean_bin = shutil.which("lean") or str(pathlib.Path.home() / ".elan/bin/lean")
    r = subprocess.run([lean_bin, str(AUDIT_LEAN)], capture_output=True, text=True, check=False, timeout=60)
    if r.returncode != 0:
        errors.append(f"Lean audit failed rc={r.returncode}: {r.stdout} {r.stderr}")
    return thm_cnt


def check_one_book(tag: str, html_name: str, pdf_name: str, errors: list) -> str:
    html_p = GUIDE / "book" / html_name
    pdf_p = GUIDE / "book" / pdf_name
    if not html_p.is_file() or html_p.stat().st_size < 800000:
        errors.append(f"book {tag} HTML missing or too small")
    else:
        html_no_b64 = re.sub(r'src="data:image/png;base64,[^"]+"', 'src="inlined"', html_p.read_text(encoding="utf-8"))
        for b in BANNED:
            if b in html_no_b64:
                errors.append(f"book {tag} HTML: banned token {b!r}")
        auditor = BookHTMLAuditor()
        auditor.feed(html_no_b64)
        if len(auditor.math_texts) < 200:
            errors.append(f"book {tag} HTML: expected >= 200 math spans/blocks, found {len(auditor.math_texts)}")
        for mtxt in auditor.math_texts:
            for bad_tok in ("\\", "{,}", "^", "_", "$"):
                if bad_tok in mtxt:
                    errors.append(f"book {tag} HTML: unconverted math token {bad_tok!r} in {mtxt!r}")
        full_prose = "".join(auditor.prose_chunks)
        if "$" in full_prose:
            errors.append(f"book {tag} HTML: leaked '$' delimiter in prose")
        if "{,}" in full_prose:
            errors.append(f"book {tag} HTML: leaked '{{,}}' token in prose")
        prose_no_fac = re.sub(r"[a-zA-Z]!", "", full_prose)
        if "!" in prose_no_fac:
            errors.append(f"book {tag} HTML: banned exclamation mark '!' in prose")

    page_str = f"{tag}:ok"
    if not pdf_p.is_file() or pdf_p.stat().st_size < 1500000:
        errors.append(f"book {tag} PDF missing or too small")
    elif shutil.which("pdfinfo"):
        r = subprocess.run(["pdfinfo", str(pdf_p)], capture_output=True, text=True, check=False, timeout=30)
        m = re.search(r"^Pages:\s+(\d+)", r.stdout, flags=re.M)
        if r.returncode != 0 or not m:
            errors.append(f"pdfinfo failed on {pdf_p.name}")
        else:
            pages = int(m.group(1))
            page_str = f"{tag}:{pages}p"
            if pages < 30:
                errors.append(f"book {tag} PDF unexpectedly short ({pages} pages)")
    return page_str


def main():
    md_files = sorted(GUIDE.glob("*.md")) + sorted((GUIDE / "en").glob("*.md"))
    assert len(md_files) >= 13, f"Expected >= 13 markdown files (KO+EN), found {len(md_files)}"
    has_raw_src = LIT_FILE.is_file()
    lit_lines = LIT_FILE.read_text(encoding="utf-8").splitlines() if has_raw_src else []
    lean_idx = build_lean_suffix_index(SRC_DIR) if has_raw_src else {}
    stats_obj = json.loads(STATS_JSON.read_text(encoding="utf-8"))
    fallback_lit_set = set(stats_obj.get("literature_wrapper_theorems", []))
    errors = []
    tot_rel = tot_pin = tot_lit = 0
    for md in md_files:
        r, p, l = check_one_md(md, lit_lines, fallback_lit_set, lean_idx, has_raw_src, errors)
        tot_rel += r
        tot_pin += p
        tot_lit += l
    if tot_lit != 390:
        errors.append(f"Expected 390 literature pins across KO+EN 04 dicts, found {tot_lit}")
    thm_cnt = check_lean_audit(errors)
    for fn in FIG_NAMES:
        fp = GUIDE / "figures" / fn
        if not fp.is_file() or fp.stat().st_size < 50000:
            errors.append(f"figures/{fn}: missing or too small")
    page_strs = [check_one_book(tag, h, p, errors) for tag, h, p in BOOK_SPECS]
    if errors:
        for e in errors:
            print("FAIL:", e)
        sys.exit(1)
    mode = "raw-src+json" if has_raw_src else "portable-json"
    print(
        f"VERIFY_OK ({mode}): {len(md_files)} docs, {len(FIG_NAMES)} figures, "
        f"Books({' '.join(page_strs)}), {thm_cnt} Lean audit thms, "
        f"{tot_rel} relative links, {tot_pin} Lean pins, {tot_lit}/390 lit pins (100.0%), 0 violations."
    )


if __name__ == "__main__":
    main()
