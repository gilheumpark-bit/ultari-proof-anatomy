#!/usr/bin/env python3
import base64
import html
import pathlib
import re
import subprocess
import markdown

ROOT = pathlib.Path(__file__).resolve().parents[1]
BOOK_DIR = ROOT / "book"
HTML_OUT = BOOK_DIR / "리만가설_1737만줄_완전풀이집.html"
PDF_OUT = BOOK_DIR / "리만가설_1737만줄_완전풀이집.pdf"

CHAPTERS = [
    ("제0부 · 전체 지도", ROOT / "00_한눈에_보는_전체지도.md"),
    ("제1부 · 일반 독자용 비유 풀이", ROOT / "01_수식없이_읽는_비유풀이.md"),
    ("제2부 · 핵심 수리 원리 5막", ROOT / "02_눈으로_만지는_핵심원리_5막.md"),
    ("제3부 · Lean 코드 척추 해부 원장", ROOT / "03_Lean코드_척추_해부원장.md"),
    ("제4부 · 기출 대정리 195선 전수 복원 사전", ROOT / "04_기출대정리_원전복원사전.md"),
    ("제5부 · 전공자용 수론 심층 심사 및 수식 복원서", ROOT / "05_전공자용_수론심층심사및수식복원서.md"),
]

SPINE_DIAGRAM_HTML = """
<div class="spine-box">
  <div class="spine-title">증명 전체 4계단 결합 구조도 (위에서 아래로 역추적)</div>
  <div class="spine-row">
    <div class="spine-node spine-top"><strong>최종 결론 (Main.lean:4-12)</strong><br/>순정 리만 가설(RiemannHypothesis) 및 디리클레 GRH 5대 정리</div>
  </div>
  <div class="spine-arrow">▲ 계단 A : 함수방정식 반사 대칭 (CritLine.lean:11-32)</div>
  <div class="spine-row">
    <div class="spine-node spine-mid"><strong>중간 총괄 정리 (UpperTheory.EveryCharacter)</strong><br/>모든 디리클레 L-함수의 우반평면 Re(s) &gt; 1/2 무영점</div>
  </div>
  <div class="spine-arrow">▲ 계단 B : 기출 195선 + 보형 창문 결합 (EveryCharacterOfLiteratureOfVWin.lean:810-814)</div>
  <div class="spine-split">
    <div class="spine-node spine-sub"><strong>기출 대정리 창고 (약 90%+)</strong><br/>OpenLiteratureStatements<br/>현대 수학 대정리 195개 자급자족 증명</div>
    <div class="spine-node spine-accent"><strong>신작 보형 창문 정리 (핵심 엔진)</strong><br/>UpperTheory.Top.VWin (지수 상한 401)<br/>제곱근 반복 세타 리프트 + 시소 약분</div>
  </div>
  <div class="spine-arrow">▲ 계단 C : 공통 갈루아-보형 다리 (RowSrc.lean:6)</div>
  <div class="spine-row">
    <div class="spine-node spine-bot"><strong>신작 갈루아 봉합 정리 (galoisLocalGlobalStrong_recParameter)</strong><br/>베렌트 등차 회피 타워 + 세타 리프트 갈루아 정합성으로 외부 가정 완전 소거</div>
  </div>
</div>
"""

TEX_SUBS = [
    (r"\\mathcal\{O\}", "𝒪"), (r"\\mathcal\{K\}", "𝒦"), (r"\\mathcal\{G\}", "𝒢"),
    (r"\\mathbb\{Q\}", "ℚ"), (r"\\mathbb\{Z\}", "ℤ"), (r"\\mathbb\{R\}", "ℝ"),
    (r"\\mathbb\{C\}", "ℂ"), (r"\\mathbb\{A\}", "𝔸"), (r"\\mathbb\{F\}", "𝔽"),
    (r"\\mathfrak\{gl\}", "𝔤𝔩"), (r"\\mathfrak\{g\}", "𝔤"),
    (r"\\left\|", "|"), (r"\\right\|", "|"), (r"\\lvert(?![a-zA-Z])", "|"), (r"\\rvert(?![a-zA-Z])", "|"),
    (r"\\(?:bigl|bigr|Bigl|Bigr|left|right)(?![a-zA-Z])", ""),
    (r"\\lfloor(?![a-zA-Z])", "⌊"), (r"\\rfloor(?![a-zA-Z])", "⌋"),
    (r"\\lceil(?![a-zA-Z])", "⌈"), (r"\\rceil(?![a-zA-Z])", "⌉"),
    (r"\\langle(?![a-zA-Z])", "⟨"), (r"\\rangle(?![a-zA-Z])", "⟩"),
    (r"\\\{", "{"), (r"\\\}", "}"), (r"\\!", ""),
    (r"\\bmod(?![a-zA-Z])", " mod "), (r"\\le(?![a-zA-Z])", "≤"), (r"\\ge(?![a-zA-Z])", "≥"),
    (r"\\ll(?![a-zA-Z])", "≪"), (r"\\neq(?![a-zA-Z])", "≠"), (r"\\approx(?![a-zA-Z])", "≈"),
    (r"\\asymp(?![a-zA-Z])", "≍"), (r"\\propto(?![a-zA-Z])", "∝"),
    (r"\\lesssim(?![a-zA-Z])", "≲"), (r"\\sim(?![a-zA-Z])", "∼"),
    (r"\\implies(?![a-zA-Z])", "⟹"), (r"\\Longrightarrow(?![a-zA-Z])", "⟹"),
    (r"\\Longleftrightarrow(?![a-zA-Z])", "⟺"), (r"\\iff(?![a-zA-Z])", "⟺"),
    (r"\\leftrightarrow(?![a-zA-Z])", "↔"), (r"\\longrightarrow(?![a-zA-Z])", "⟶"),
    (r"\\to(?![a-zA-Z])", "→"), (r"\\downarrow(?![a-zA-Z])", "↓"),
    (r"\\infty(?![a-zA-Z])", "∞"), (r"\\inf(?![a-zA-Z])", "inf"),
    (r"\\pm(?![a-zA-Z])", "±"), (r"\\cdot(?![a-zA-Z])", "·"), (r"\\times(?![a-zA-Z])", "×"),
    (r"\\oplus(?![a-zA-Z])", "⊕"), (r"\\cap(?![a-zA-Z])", "∩"), (r"\\vee(?![a-zA-Z])", "∨"),
    (r"\\backslash(?![a-zA-Z])", "∖"), (r"\\partial(?![a-zA-Z])", "∂"),
    (r"\\dots(?![a-zA-Z])", "…"), (r"\\qquad(?![a-zA-Z])", "    "),
    (r"\\quad(?![a-zA-Z])", "  "), (r"\\,", " "), (r"\\;", " "),
    (r"\\Delta(?![a-zA-Z])", "Δ"), (r"\\Lambda(?![a-zA-Z])", "Λ"), (r"\\psi(?![a-zA-Z])", "ψ"),
    (r"\\gamma(?![a-zA-Z])", "γ"), (r"\\delta(?![a-zA-Z])", "δ"), (r"\\zeta(?![a-zA-Z])", "ζ"),
    (r"\\theta(?![a-zA-Z])", "θ"), (r"\\vartheta(?![a-zA-Z])", "ϑ"), (r"\\varphi(?![a-zA-Z])", "φ"),
    (r"\\rho(?![a-zA-Z])", "ρ"), (r"\\sigma(?![a-zA-Z])", "σ"), (r"\\tau(?![a-zA-Z])", "τ"),
    (r"\\mu(?![a-zA-Z])", "μ"), (r"\\nu(?![a-zA-Z])", "ν"), (r"\\omega(?![a-zA-Z])", "ω"),
    (r"\\varepsilon(?![a-zA-Z])", "ε"), (r"\\chi(?![a-zA-Z])", "χ"),
    (r"\\alpha(?![a-zA-Z])", "α"), (r"\\beta(?![a-zA-Z])", "β"), (r"\\pi(?![a-zA-Z])", "π"),
    (r"\\ell(?![a-zA-Z])", "ℓ"), (r"\\det(?![a-zA-Z])", "det "), (r"\\log(?![a-zA-Z])", "log "),
    (r"\\sin(?![a-zA-Z])", "sin"), (r"\\exp(?![a-zA-Z])", "exp"), (r"\\sup(?![a-zA-Z])", "sup "),
    (r"\\mid(?![a-zA-Z])", "∣"), (r"\\in(?![a-zA-Z])", "∈"), (r"\\notin(?![a-zA-Z])", "∉"),
    (r"\\subseteq(?![a-zA-Z])", "⊆"), (r"\\subset(?![a-zA-Z])", "⊂"),
    (r"\\forall(?![a-zA-Z])", "∀"), (r"\\exists(?![a-zA-Z])", "∃"),
    (r"\\neg(?![a-zA-Z])", "¬"), (r"\\land(?![a-zA-Z])", "∧"), (r"\\lor(?![a-zA-Z])", "∨"),
    (r"\\sum(?![a-zA-Z])", "∑"), (r"\\prod(?![a-zA-Z])", "∏"), (r"\\int(?![a-zA-Z])", "∫"),
]

NUM_RE = re.compile(r"^[+-]?[0-9][0-9,.]*%?$")
CENTER_BADGES = {"PASS", "NOT_RUN", "제1막", "제2막", "제3막", "제4막", "제5막"}


def strip_tags(s: str) -> str:
    return html.unescape(re.sub(r"<[^>]+>", "", s)).strip()


def format_tex_expr(expr: str) -> str:
    s = expr.strip()
    s = re.sub(r"\\pmod\s*\{([^}]*)\}", r"(mod \1)", s)
    s = re.sub(r"\\pmod\s*([A-Za-z0-9]+)", r"(mod \1)", s)
    s = re.sub(r"\\bmod\s*\{([^}]*)\}", r" mod \1", s)
    s = re.sub(r"\\equiv(?![a-zA-Z])", "≡", s)
    s = re.sub(r"\\int_([0-9a-zA-Z]+)\^(\\[a-zA-Z]+|[0-9a-zA-Z]+)", r"∫<sub>\1</sub><sup>\2</sup>", s)
    for pat, rep in TEX_SUBS:
        s = re.sub(pat, rep, s)
    for _ in range(4):
        s = re.sub(r"\\(?:operatorname|mathrm|mathsf|text)\{([^{}]+)\}", r"\1", s)
        s = re.sub(r"\\mathbf\{([^{}]+)\}", r"<strong>\1</strong>", s)
        s = re.sub(r"\\(?:overline|bar)\{([^{}]+)\}", r"<span style='text-decoration:overline;'>\1</span>", s)
        s = re.sub(r"\\overset\{([^{}]+)\}\{([^{}]+)\}", r"<span class='overset'><span class='ov-top'>\1</span><span>\2</span></span>", s)
        s = re.sub(r"\\binom\{([^{}]+)\}\{([^{}]+)\}", r"<span class='binom'>(<span class='bstack'><span>\1</span><span>\2</span></span>)</span>", s)
        s = re.sub(r"\\sum_\{([^{}]+)\}\^\{([^{}]+)\}", r"∑<sub>\1</sub><sup>\2</sup>", s)
        s = re.sub(r"\\sum_\{([^{}]+)\}", r"∑<sub>\1</sub>", s)
        s = re.sub(r"\^\{([^{}]+)\}", r"<sup>\1</sup>", s)
        s = re.sub(r"_\{([^{}]+)\}", r"<sub>\1</sub>", s)
        s = re.sub(
            r"\\frac\{([^{}]+)\}\{([^{}]+)\}",
            lambda m: f"<span class='frac'><span class='num'>{m.group(1)}</span><span class='den'>{m.group(2)}</span></span>",
            s,
        )
        s = re.sub(
            r"\\sqrt\{([^{}]+)\}",
            lambda m: f"<span class='sqrt'>√<span class='rad'>{m.group(1)}</span></span>",
            s,
        )
    s = re.sub(r"\^\s*([0-9a-zA-Zα-ωΑ-Ωℓ∨'+*-])", r"<sup>\1</sup>", s)
    s = re.sub(r"_\s*([0-9a-zA-Zα-ωΑ-Ωℓ])", r"<sub>\1</sub>", s)
    s = s.replace("\\|", "‖")
    if "\\" in s:
        raise ValueError(f"Unconverted TeX backslash in math: {s!r}")
    return s


def make_inline_math(expr: str) -> str:
    rendered = format_tex_expr(expr)
    cls = "math-inline math-nowrap" if len(strip_tags(rendered)) <= 26 else "math-inline"
    return f"<span class='{cls}'>{rendered}</span>"


def replace_math_and_mermaid(md_text: str):
    md_text = re.sub(r"```mermaid[\s\S]*?```", SPINE_DIAGRAM_HTML, md_text)
    stash = []

    def save_token(rendered: str) -> str:
        idx = len(stash)
        stash.append(rendered)
        return f"@@MATH_TOKEN_{idx}@@"

    md_text = re.sub(
        r"\$\$([\s\S]+?)\$\$",
        lambda m: save_token(f"<div class='math-block'>{format_tex_expr(m.group(1))}</div>"),
        md_text,
    )
    md_text = re.sub(
        r"(?<!\$)\$(?!\$)([^\n$]+?)\$(?!\$)",
        lambda m: save_token(make_inline_math(m.group(1))),
        md_text,
    )
    return md_text, stash


def format_inline_code_tag(mat) -> str:
    raw = html.unescape(mat.group(1))
    esc = html.escape(raw)
    if len(raw) <= 20 or (len(raw) <= 28 and "/" not in raw and "_" not in raw):
        return f'<code class="code-nowrap">{esc}</code>'
    wrapped = re.sub(r"([/_.])", r"\1<wbr/>", esc)
    wrapped = re.sub(r"([a-z])([A-Z])", r"\1<wbr/>\2", wrapped)
    return f'<code class="code-wrap">{wrapped}</code>'


def format_th_tag(mat) -> str:
    inner = mat.group(1)
    if len(strip_tags(inner)) <= 13:
        return f'<th class="th-nowrap">{inner}</th>'
    return mat.group(0)


def format_td_tag(mat) -> str:
    inner = mat.group(1)
    plain = strip_tags(inner)
    if NUM_RE.match(plain):
        return f'<td class="td-num">{inner}</td>'
    if plain in CENTER_BADGES:
        return f'<td class="td-center">{inner}</td>'
    return mat.group(0)


def postprocess_typography(html_str: str) -> str:
    pre_blocks = []

    def save_pre(mat) -> str:
        idx = len(pre_blocks)
        pre_blocks.append(mat.group(0))
        return f"@@PRE_BLOCK_{idx}@@"

    s = re.sub(r"<pre>[\s\S]*?</pre>", save_pre, html_str)
    s = re.sub(r"<code>([^<]*)</code>", format_inline_code_tag, s)
    s = re.sub(r"<th(?:\s+align=\"[^\"]*\")?>([\s\S]*?)</th>", format_th_tag, s)
    s = re.sub(r"<td(?:\s+align=\"[^\"]*\")?>([\s\S]*?)</td>", format_td_tag, s)
    for idx, blk in enumerate(pre_blocks):
        s = s.replace(f"@@PRE_BLOCK_{idx}@@", blk)
    return s


def inline_images(html_str: str) -> str:
    def repl(mat):
        src = mat.group(1)
        if src.startswith("./figures/"):
            fp = ROOT / src[2:]
            if fp.is_file():
                b64 = base64.b64encode(fp.read_bytes()).decode("ascii")
                return f'src="data:image/png;base64,{b64}"'
        return mat.group(0)

    return re.sub(r'src="([^"]+)"', repl, html_str)


def render_toc_label(badge: str, raw_h1: str) -> str:
    cleaned = re.sub(r"^\d+\.\s*", "", raw_h1.strip())
    prepped, stash = replace_math_and_mermaid(cleaned)
    frag = markdown.markdown(prepped)
    frag = re.sub(r"^<p>|</p>\s*$", "", frag)
    for tidx, val in enumerate(stash):
        frag = frag.replace(f"@@MATH_TOKEN_{tidx}@@", val)
    frag = postprocess_typography(frag)
    return f"<strong>{html.escape(badge)}</strong> · {frag}"


CSS_STYLE = """
@page {
  size: A4;
  margin: 19mm 17mm 21mm 17mm;
  @bottom-center {
    content: counter(page) " / " counter(pages);
    font-family: "NanumSquare Neo", "Noto Sans CJK KR", sans-serif;
    font-size: 8.5pt;
    color: #64748B;
  }
}
* { box-sizing: border-box; }
body { margin: 0; padding: 0; background: #F7F5F0; color: #1A202C; font-family: "NanumMyeongjo", "Noto Serif CJK KR", serif; font-size: 10.5pt; line-height: 1.78; word-break: keep-all; }
.page-shell { max-width: 860px; margin: 0 auto; background: #FFFFFF; padding: 44px 52px; }
@media print { body { background: #FFFFFF; } .page-shell { max-width: none; padding: 0; } }
.cover { padding: 56px 12px 48px 12px; border-bottom: 3px solid #1E293B; margin-bottom: 36px; page-break-after: always; }
.cover-kicker { font-family: "NanumSquare Neo", "Noto Sans CJK KR", sans-serif; font-size: 10pt; font-weight: 700; letter-spacing: 0.08em; color: #9B2C2C; margin-bottom: 14px; }
.cover-title { font-family: "NanumSquare Neo", "Noto Sans CJK KR", sans-serif; font-size: 24pt; font-weight: 800; line-height: 1.32; color: #0F172A; margin: 0 0 16px 0; }
.cover-sub { font-size: 11.8pt; line-height: 1.65; color: #334155; margin-bottom: 32px; }
.cover-meta { background: #F8FAFC; border-left: 4px solid #1F5A73; padding: 16px 20px; font-family: "NanumSquare Neo", "Noto Sans CJK KR", sans-serif; font-size: 9.5pt; line-height: 1.72; color: #1E293B; }
.toc-box { background: #FAF9F6; border: 1px solid #CBD5E1; padding: 24px 30px; margin-bottom: 36px; page-break-after: always; }
.toc-title { font-family: "NanumSquare Neo", "Noto Sans CJK KR", sans-serif; font-size: 14pt; font-weight: 700; margin: 0 0 14px 0; color: #0F172A; }
.toc-list { margin: 0; padding-left: 22px; font-family: "NanumSquare Neo", "Noto Sans CJK KR", sans-serif; font-size: 10pt; line-height: 2.05; }
.toc-list a { color: #1E3A5F; text-decoration: none; }
.chapter { page-break-before: always; padding-top: 4px; }
.chapter:first-of-type { page-break-before: auto; }
.chapter-badge { font-family: "NanumSquare Neo", "Noto Sans CJK KR", sans-serif; font-size: 9pt; font-weight: 700; color: #1F5A73; letter-spacing: 0.05em; margin-bottom: 4px; }
h1, h2, h3 { font-family: "NanumSquare Neo", "Noto Sans CJK KR", sans-serif; color: #0F172A; break-after: avoid; }
h1 { font-size: 17pt; line-height: 1.35; border-bottom: 2px solid #1E293B; padding-bottom: 10px; margin-top: 4px; }
h2 { font-size: 12.8pt; line-height: 1.4; margin-top: 24px; margin-bottom: 10px; color: #1E3A5F; }
h3 { font-size: 10.8pt; margin-top: 18px; margin-bottom: 8px; color: #334155; }
p { margin: 0 0 11px 0; text-align: justify; }
ul, ol { margin: 0 0 13px 0; padding-left: 22px; }
li { margin-bottom: 5px; }
hr { border: none; border-top: 1px solid #E2E8F0; margin: 20px 0; }
blockquote { margin: 14px 0; padding: 11px 16px; background: #F8FAFC; border-left: 4px solid #B83227; font-family: "NanumSquare Neo", "Noto Sans CJK KR", sans-serif; font-size: 9.4pt; line-height: 1.65; color: #1E293B; break-inside: avoid; }
blockquote p { margin: 0; text-align: left; }
blockquote ul { margin: 6px 0 0 0; }
code {
  font-family: "D2Coding ligature", "D2Coding", monospace;
  font-size: 8.7pt;
  background: #F1F5F9;
  color: #0F172A;
  padding: 1px 4px;
  border-radius: 3px;
  word-break: keep-all;
}
code.code-nowrap { white-space: nowrap; }
code.code-wrap { white-space: normal; overflow-wrap: break-word; }
pre {
  background: #0F172A;
  color: #F8FAFC;
  padding: 13px 16px;
  border-radius: 5px;
  overflow-x: auto;
  line-height: 1.5;
  break-inside: avoid;
}
pre code { background: transparent; color: #F8FAFC; padding: 0; font-size: 8.5pt; white-space: pre; }
table {
  width: 100%;
  border-collapse: collapse;
  margin: 13px 0 17px 0;
  font-family: "NanumSquare Neo", "Noto Sans CJK KR", sans-serif;
  font-size: 8.5pt;
  line-height: 1.48;
  font-variant-numeric: tabular-nums;
}
thead { display: table-header-group; }
tr { break-inside: avoid; }
th {
  background: #1E293B;
  color: #FFFFFF;
  font-weight: 700;
  text-align: left;
  padding: 6px 8px;
  border: 1px solid #1E293B;
  word-break: keep-all;
}
th.th-nowrap { white-space: nowrap; }
td {
  padding: 6px 8px;
  border: 1px solid #CBD5E1;
  vertical-align: top;
}
td.td-num { white-space: nowrap; text-align: right; }
td.td-center { white-space: nowrap; text-align: center; font-weight: 700; }
tbody tr:nth-child(even) { background: #FAF9F6; }
img {
  display: block;
  max-width: 100%;
  height: auto;
  margin: 14px auto;
  border: 1px solid #E2E8F0;
  border-radius: 4px;
  break-inside: avoid;
}
.math-block {
  margin: 13px 0;
  padding: 10px 15px;
  background: #FAF9F6;
  border: 1px solid #E2E8F0;
  border-radius: 4px;
  text-align: center;
  font-family: "Cambria Math", "STIX Two Math", "NanumMyeongjo", serif;
  font-size: 11pt;
  break-inside: avoid;
}
.math-inline {
  font-family: "Cambria Math", "STIX Two Math", "NanumMyeongjo", serif;
  font-style: italic;
  padding: 0 1px;
}
.math-nowrap, sup, sub, .frac, .sqrt { white-space: nowrap; }
.frac {
  display: inline-flex;
  flex-direction: column;
  vertical-align: middle;
  text-align: center;
  padding: 0 3px;
  font-style: normal;
}
.frac .num { border-bottom: 1px solid #1A202C; padding: 0 3px 1px 3px; line-height: 1.15; }
.frac .den { padding: 1px 3px 0 3px; line-height: 1.15; }
.binom { display: inline-flex; align-items: center; vertical-align: middle; font-style: normal; padding: 0 2px; }
.bstack { display: inline-flex; flex-direction: column; text-align: center; font-size: 0.82em; line-height: 1.05; padding: 0 1px; }
.overset { display: inline-flex; flex-direction: column; align-items: center; vertical-align: middle; padding: 0 3px; }
.ov-top { font-size: 0.68em; line-height: 1.0; font-style: normal; }
.sqrt .rad { border-top: 1px solid #1A202C; padding-top: 1px; }
.spine-box {
  background: #FAF9F6;
  border: 1px solid #CBD5E1;
  border-radius: 6px;
  padding: 13px 16px;
  margin: 12px 0;
  font-family: "NanumSquare Neo", "Noto Sans CJK KR", sans-serif;
  font-size: 8.8pt;
  text-align: center;
  break-inside: avoid;
}
.spine-title { font-weight: 700; font-size: 9.8pt; margin-bottom: 10px; color: #0F172A; }
.spine-row { display: flex; justify-content: center; }
.spine-split { display: flex; gap: 12px; justify-content: center; }
.spine-node { padding: 8px 13px; border-radius: 5px; line-height: 1.42; width: 100%; }
.spine-top { background: #1E293B; color: #FFFFFF; }
.spine-mid { background: #1F5A73; color: #FFFFFF; }
.spine-sub { background: #E2E8F0; color: #1E293B; flex: 1; }
.spine-accent { background: #FDF2F2; border: 1.5px solid #B83227; color: #742A2A; flex: 1; }
.spine-bot { background: #EDF2F7; border: 1px solid #64748B; color: #1A202C; }
.spine-arrow { font-size: 8.3pt; color: #475569; margin: 5px 0; font-weight: 600; }
"""


def render_chapter(idx: int, badge: str, md_path: pathlib.Path) -> str:
    raw = md_path.read_text(encoding="utf-8")
    prepped, stash = replace_math_and_mermaid(raw)
    body = markdown.markdown(prepped, extensions=["tables", "fenced_code"])
    for tidx, val in enumerate(stash):
        body = body.replace(f"@@MATH_TOKEN_{tidx}@@", val)
    body = postprocess_typography(body)
    body = inline_images(body)
    return f'<section class="chapter" id="chap-{idx}"><div class="chapter-badge">{html.escape(badge)}</div>{body}</section>'


def main():
    BOOK_DIR.mkdir(parents=True, exist_ok=True)
    toc_items = []
    chap_htmls = []
    for idx, (badge, path) in enumerate(CHAPTERS):
        first_h1 = path.read_text(encoding="utf-8").splitlines()[0].lstrip("# ").strip()
        toc_items.append(f'<li><a href="#chap-{idx}">{render_toc_label(badge, first_h1)}</a></li>')
        chap_htmls.append(render_chapter(idx, badge, path))

    full_html = f"""<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<title>리만 가설 1,737만 줄 Lean 증명 완전 풀이집</title>
<style>{CSS_STYLE}</style>
</head>
<body>
<div class="page-shell">
  <header class="cover">
    <div class="cover-kicker">수리 포렌식 및 형식증명 역설계 단행본 · 2026-11-21</div>
    <h1 class="cover-title" style="border:none;font-size:24pt;">리만 가설 1,737만 줄 Lean 증명<br/>한국어 완전 풀이집</h1>
    <div class="cover-sub">Anthropic 레벤트 알푀게(Levent Alpöge)와 Claude의 무주석 형식증명 아카이브(175,187개 파일) 전수 컴파일 검증 및 일반 독자·전공자 계단식 역설계 해설서</div>
    <div class="cover-meta">
      <div><strong>커널 검증 상태</strong> : 공식 leanprover/lean4:v4.33.1 이중 아키텍처(x86_64 · aarch64) 175,187 / 175,187 완주 (에러 0건, PASS)</div>
      <div><strong>의존 공리 검증</strong> : 표준 수학 3공리(propext, Classical.choice, Quot.sound) 외 비표준 공리·sorryAx 0건</div>
      <div><strong>수록 범위</strong> : 전체 지도 · 무수식 비유 풀이 · 제곱근 리프트 대수 유도 · Lean 척추 원장 · 기출 195선 전수 복원 · 전공자용 심층 수리 심사서</div>
    </div>
  </header>
  <nav class="toc-box">
    <h2 class="toc-title">목차</h2>
    <ol class="toc-list">{''.join(toc_items)}</ol>
  </nav>
  {''.join(chap_htmls)}
</div>
</body>
</html>
"""
    HTML_OUT.write_text(full_html, encoding="utf-8")
    cmd = [
        "/usr/bin/google-chrome",
        "--headless",
        "--disable-gpu",
        "--no-pdf-header-footer",
        f"--print-to-pdf={PDF_OUT}",
        f"file://{HTML_OUT}",
    ]
    r = subprocess.run(cmd, capture_output=True, text=True, check=False, timeout=120)
    if r.returncode != 0 or not PDF_OUT.is_file():
        raise RuntimeError(f"Chrome PDF build failed rc={r.returncode}: {r.stderr}")
    print(f"BOOK_OK: HTML={HTML_OUT.stat().st_size}B PDF={PDF_OUT.stat().st_size}B")


if __name__ == "__main__":
    main()
