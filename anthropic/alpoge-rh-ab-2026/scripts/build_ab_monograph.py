#!/usr/bin/env python3
"""
Build both Korean and English Part A Deep Academic Monographs (HTML + Print-Ready A4 PDF via Headless Chrome).
Includes strict zero-unconverted-TeX enforcement, subscript glyph normalization in code,
ordered-list display-math/code continuity, multi-level TOC, and embedded base64 figures.
"""
import sys

sys.dont_write_bytecode = True

import base64
import html
import pathlib
import re
import subprocess
import markdown

ROOT = pathlib.Path(__file__).resolve().parents[1]
PART_A_KO = ROOT / "part_a"
PART_A_EN = ROOT / "part_a_en"
BOOK_DIR = ROOT / "book"

CHAPTERS_KO = [
    ("제0부 · 총괄 서문 및 해부 지도", PART_A_KO / "A00_총괄서문_및_전체해부지도.md"),
    ("제1부 · 최상위 봉인 · Mathlib 의미론 및 상단 브리지 감사", PART_A_KO / "A01_최상위봉인_Mathlib경계의미론_및_상단브리지감사.md"),
    ("제2부 · 기출 201선 및 PublishedTheorems 동치성 감사", PART_A_KO / "A02_기출201선_및_PublishedTheorems_의미론동치성감사.md"),
    ("제3부 · Formalism 4대 기둥(258만 줄) 하부 허브 심층 복원", PART_A_KO / "A03_Formalism_4대기둥_하부전술및핵심허브_심층복원.md"),
    ("제4부 · Formalism 112개 소이론 및 전역 상수 폐루프 복원", PART_A_KO / "A04_Formalism_112개특수소이론_및_전역상수폐루프복원.md"),
    ("제5부 · Pure_Vwin 반디버 우회 · 베렌트 타워 및 기계 검증 확장", PART_A_KO / "A05_PureVwin_반디버우회_베렌트타워_및_기계검증확장.md"),
    ("제6부 · 인간 단축 논문 청사진 및 전역 참조 총색인", PART_A_KO / "A06_부록_인간단축논문_재구성청사진_및_전역참조총색인.md"),
]

CHAPTERS_EN = [
    ("Volume 0 · Executive Preface & Master Decompilation Map", PART_A_EN / "A00_Executive_Preface_And_Master_Map.md"),
    ("Volume 1 · Top Seal, Mathlib Boundary Semantics & Upper Bridges", PART_A_EN / "A01_Top_Seal_Mathlib_Boundary_Semantics_And_Upper_Bridge_Audit.md"),
    ("Volume 2 · Classical 201 Imports & PublishedTheorems Equivalence Audit", PART_A_EN / "A02_Classical_201_Imports_And_PublishedTheorems_Semantic_Equivalence_Audit.md"),
    ("Volume 3 · Formalism Four Pillars (2.58M Lines) Lower Hubs & Tactics", PART_A_EN / "A03_Formalism_Four_Pillars_Lower_Tactics_And_Core_Hubs_Decompilation.md"),
    ("Volume 4 · Formalism 112 Specialized Subtheories & Global Constant Closure", PART_A_EN / "A04_Formalism_112_Specialized_Subtheories_And_Global_Constant_Closure.md"),
    ("Volume 5 · Pure_Vwin Vandiver Bypass, Behrend Tower & 44-Theorem Suite", PART_A_EN / "A05_PureVwin_Vandiver_Bypass_Behrend_Tower_And_Formal_Audit_Suite.md"),
    ("Volume 6 · 152-Page Journal Paper Blueprint & Global Master Index", PART_A_EN / "A06_Appendix_152p_Journal_Paper_Blueprint_And_Global_Master_Index.md"),
]

CALLIGRAPHIC = {
    "A": "𝒜", "B": "ℬ", "C": "𝒞", "D": "𝒟", "E": "ℰ", "F": "ℱ", "G": "𝒢",
    "H": "ℋ", "I": "ℐ", "J": "𝒥", "K": "𝒦", "L": "ℒ", "M": "ℳ", "N": "𝒩",
    "O": "𝒪", "P": "𝒫", "Q": "𝒬", "R": "ℛ", "S": "𝒮", "T": "𝒯", "U": "𝒰",
    "V": "𝒱", "W": "𝒲", "X": "𝒳", "Y": "𝒴", "Z": "𝒵",
}
BLACKBOARD = {
    "A": "𝔸", "C": "ℂ", "E": "𝔼", "F": "𝔽", "G": "𝔾", "H": "ℍ", "K": "𝕂",
    "L": "𝕃", "N": "ℕ", "P": "ℙ", "Q": "ℚ", "R": "ℝ", "S": "𝕊", "T": "𝕋", "Z": "ℤ",
}
FRAKTUR = {
    "a": "𝔞", "b": "𝔟", "c": "𝔠", "d": "𝔡", "e": "𝔢", "f": "𝔣", "g": "𝔤",
    "h": "𝔥", "i": "𝔦", "k": "𝔨", "l": "𝔩", "m": "𝔪", "n": "𝔫", "o": "𝔬",
    "p": "𝔭", "q": "𝔮", "r": "𝔯", "s": "𝔰", "t": "𝔱", "u": "𝔲", "v": "𝔳",
    "gl": "𝔤𝔩", "sl": "𝔰𝔩", "sp": "𝔰𝔭", "so": "𝔰𝔬", "su": "𝔰𝔲",
    "A": "𝔄", "B": "𝔅", "C": "ℭ", "D": "𝔇", "F": "𝔉", "G": "𝔊", "H": "ℌ",
    "I": "ℑ", "M": "𝔐", "N": "𝔑", "P": "𝔓", "Q": "𝔔", "R": "ℜ", "S": "𝔖", "X": "𝔛",
}

UNICODE_SUB_DIGITS = {
    "₀": "0", "₁": "1", "₂": "2", "₃": "3", "₄": "4",
    "₅": "5", "₆": "6", "₇": "7", "₈": "8", "₉": "9",
}
UNICODE_SUB_RE = re.compile(r"([₀₁₂₃₄₅₆₇₈₉]+)")

TEX_SUBS = [
    (r"\\left\|", "‖"), (r"\\right\|", "‖"), (r"\\\|", "‖"),
    (r"\\lvert(?![a-zA-Z])", "|"), (r"\\rvert(?![a-zA-Z])", "|"), (r"\\middle\|", "|"), (r"\\middle(?![a-zA-Z])", ""),
    (r"\\lVert(?![a-zA-Z])", "‖"), (r"\\rVert(?![a-zA-Z])", "‖"),
    (r"\\(?:bigl|bigr|Bigl|Bigr|biggl|biggr|Biggl|Biggr|big|Big|bigg|Bigg|left|right)(?![a-zA-Z])", ""),
    (r"\\lfloor(?![a-zA-Z])", "⌊"), (r"\\rfloor(?![a-zA-Z])", "⌋"),
    (r"\\lceil(?![a-zA-Z])", "⌈"), (r"\\rceil(?![a-zA-Z])", "⌉"),
    (r"\\llbracket(?![a-zA-Z])", "⟦"), (r"\\rrbracket(?![a-zA-Z])", "⟧"),
    (r"\\langle(?![a-zA-Z])", "⟨"), (r"\\rangle(?![a-zA-Z])", "⟩"),
    (r"\\\{", "@@LBRACE@@"), (r"\\\}", "@@RBRACE@@"), (r"\\#", "#"), (r"\\_", "@@ESC_US@@"), (r"\\%", "%"), (r"\\&", "&"), (r"\\!", ""),
    (r"\\bmod(?![a-zA-Z])", " mod "),
    (r"\\leq(?![a-zA-Z])", "≤"), (r"\\le(?![a-zA-Z])", "≤"),
    (r"\\geq(?![a-zA-Z])", "≥"), (r"\\ge(?![a-zA-Z])", "≥"),
    (r"\\leqslant(?![a-zA-Z])", "≤"), (r"\\geqslant(?![a-zA-Z])", "≥"),
    (r"\\ll(?![a-zA-Z])", "≪"), (r"\\gg(?![a-zA-Z])", "≫"),
    (r"\\neq(?![a-zA-Z])", "≠"), (r"\\ne(?![a-zA-Z])", "≠"),
    (r"\\approx(?![a-zA-Z])", "≈"), (r"\\cong(?![a-zA-Z])", "≅"), (r"\\simeq(?![a-zA-Z])", "≃"),
    (r"\\asymp(?![a-zA-Z])", "≍"), (r"\\propto(?![a-zA-Z])", "∝"),
    (r"\\lesssim(?![a-zA-Z])", "≲"), (r"\\gtrsim(?![a-zA-Z])", "≳"), (r"\\sim(?![a-zA-Z])", "∼"),
    (r"\\equiv(?![a-zA-Z])", "≡"), (r"\\not\\equiv(?![a-zA-Z])", "≢"),
    (r"\\implies(?![a-zA-Z])", "⟹"), (r"\\Longrightarrow(?![a-zA-Z])", "⟹"), (r"\\Rightarrow(?![a-zA-Z])", "⇒"),
    (r"\\Longleftarrow(?![a-zA-Z])", "⟸"), (r"\\Leftarrow(?![a-zA-Z])", "⇐"),
    (r"\\Longleftrightarrow(?![a-zA-Z])", "⟺"), (r"\\Leftrightarrow(?![a-zA-Z])", "⇔"), (r"\\iff(?![a-zA-Z])", "⟺"),
    (r"\\leftrightarrow(?![a-zA-Z])", "↔"),
    (r"\\hookrightarrow(?![a-zA-Z])", "↪"), (r"\\twoheadrightarrow(?![a-zA-Z])", "↠"),
    (r"\\longmapsto(?![a-zA-Z])", "⟼"), (r"\\mapsto(?![a-zA-Z])", "↦"),
    (r"\\longrightarrow(?![a-zA-Z])", "⟶"), (r"\\rightarrow(?![a-zA-Z])", "→"), (r"\\to(?![a-zA-Z])", "→"),
    (r"\\leftarrow(?![a-zA-Z])", "←"), (r"\\gets(?![a-zA-Z])", "←"),
    (r"\\downarrow(?![a-zA-Z])", "↓"), (r"\\uparrow(?![a-zA-Z])", "↑"),
    (r"\\infty(?![a-zA-Z])", "∞"),
    (r"\\pm(?![a-zA-Z])", "±"), (r"\\mp(?![a-zA-Z])", "∓"),
    (r"\\cdot(?![a-zA-Z])", "·"), (r"\\cdots(?![a-zA-Z])", "⋯"), (r"\\ldots(?![a-zA-Z])", "…"), (r"\\dots(?![a-zA-Z])", "…"),
    (r"\\times(?![a-zA-Z])", "×"), (r"\\otimes(?![a-zA-Z])", "⊗"), (r"\\oplus(?![a-zA-Z])", "⊕"),
    (r"\\boxplus(?![a-zA-Z])", "⊞"), (r"\\boxtimes(?![a-zA-Z])", "⊠"),
    (r"\\bigotimes(?![a-zA-Z])", "⨂"), (r"\\bigoplus(?![a-zA-Z])", "⨁"),
    (r"\\sqcup(?![a-zA-Z])", "⊔"), (r"\\bigsqcup(?![a-zA-Z])", "⨆"),
    (r"\\cup(?![a-zA-Z])", "∪"), (r"\\bigcup(?![a-zA-Z])", "⋃"),
    (r"\\cap(?![a-zA-Z])", "∩"), (r"\\bigcap(?![a-zA-Z])", "⋂"),
    (r"\\bigwedge(?![a-zA-Z])", "⋀"), (r"\\bigvee(?![a-zA-Z])", "⋁"),
    (r"\\wedge(?![a-zA-Z])", "∧"), (r"\\vee(?![a-zA-Z])", "∨"),
    (r"\\flat(?![a-zA-Z])", "♭"), (r"\\sharp(?![a-zA-Z])", "♯"), (r"\\natural(?![a-zA-Z])", "♮"),
    (r"\\circ(?![a-zA-Z])", "∘"), (r"\\bullet(?![a-zA-Z])", "•"), (r"\\star(?![a-zA-Z])", "⋆"), (r"\\ast(?![a-zA-Z])", "∗"),
    (r"\\rtimes(?![a-zA-Z])", "⋊"), (r"\\ltimes(?![a-zA-Z])", "⋉"),
    (r"\\triangleleft(?![a-zA-Z])", "⊲"), (r"\\perp(?![a-zA-Z])", "⊥"),
    (r"\\top(?![a-zA-Z])", "⊤"), (r"\\bot(?![a-zA-Z])", "⊥"), (r"\\emptyset(?![a-zA-Z])", "∅"), (r"\\varnothing(?![a-zA-Z])", "∅"),
    (r"\\backslash(?![a-zA-Z])", "∖"), (r"\\setminus(?![a-zA-Z])", "∖"),
    (r"\\partial(?![a-zA-Z])", "∂"), (r"\\nabla(?![a-zA-Z])", "∇"),
    (r"\\qquad(?![a-zA-Z])", "    "), (r"\\quad(?![a-zA-Z])", "  "),
    (r"\\,", " "), (r"\\;", " "), (r"\\:", " "), (r"\\ ", " "),
    (r"\\Gamma(?![a-zA-Z])", "Γ"), (r"\\Delta(?![a-zA-Z])", "Δ"), (r"\\Theta(?![a-zA-Z])", "Θ"),
    (r"\\Lambda(?![a-zA-Z])", "Λ"), (r"\\Xi(?![a-zA-Z])", "Ξ"), (r"\\Pi(?![a-zA-Z])", "Π"),
    (r"\\Sigma(?![a-zA-Z])", "Σ"), (r"\\Upsilon(?![a-zA-Z])", "Υ"), (r"\\Phi(?![a-zA-Z])", "Φ"),
    (r"\\Psi(?![a-zA-Z])", "Ψ"), (r"\\Omega(?![a-zA-Z])", "Ω"),
    (r"\\alpha(?![a-zA-Z])", "α"), (r"\\beta(?![a-zA-Z])", "β"), (r"\\gamma(?![a-zA-Z])", "γ"),
    (r"\\delta(?![a-zA-Z])", "δ"), (r"\\varepsilon(?![a-zA-Z])", "ε"), (r"\\epsilon(?![a-zA-Z])", "ϵ"),
    (r"\\zeta(?![a-zA-Z])", "ζ"), (r"\\eta(?![a-zA-Z])", "η"),
    (r"\\vartheta(?![a-zA-Z])", "ϑ"), (r"\\theta(?![a-zA-Z])", "θ"),
    (r"\\iota(?![a-zA-Z])", "ι"), (r"\\kappa(?![a-zA-Z])", "κ"), (r"\\lambda(?![a-zA-Z])", "λ"),
    (r"\\mu(?![a-zA-Z])", "μ"), (r"\\nu(?![a-zA-Z])", "ν"), (r"\\xi(?![a-zA-Z])", "ξ"),
    (r"\\varpi(?![a-zA-Z])", "ϖ"), (r"\\pi(?![a-zA-Z])", "π"),
    (r"\\varrho(?![a-zA-Z])", "ϱ"), (r"\\rho(?![a-zA-Z])", "ρ"),
    (r"\\varsigma(?![a-zA-Z])", "ς"), (r"\\sigma(?![a-zA-Z])", "σ"),
    (r"\\tau(?![a-zA-Z])", "τ"), (r"\\upsilon(?![a-zA-Z])", "υ"),
    (r"\\varphi(?![a-zA-Z])", "φ"), (r"\\phi(?![a-zA-Z])", "ϕ"),
    (r"\\chi(?![a-zA-Z])", "χ"), (r"\\psi(?![a-zA-Z])", "ψ"), (r"\\omega(?![a-zA-Z])", "ω"),
    (r"\\ell(?![a-zA-Z])", "ℓ"), (r"\\hbar(?![a-zA-Z])", "ℏ"), (r"\\wp(?![a-zA-Z])", "℘"),
    (r"\\Re(?![a-zA-Z])", "Re"), (r"\\Im(?![a-zA-Z])", "Im"),
    (r"\\ker(?![a-zA-Z])", "ker "), (r"\\coker(?![a-zA-Z])", "coker "),
    (r"\\det(?![a-zA-Z])", "det "), (r"\\dim(?![a-zA-Z])", "dim "),
    (r"\\deg(?![a-zA-Z])", "deg "), (r"\\gcd(?![a-zA-Z])", "gcd"), (r"\\lcm(?![a-zA-Z])", "lcm"),
    (r"\\hom(?![a-zA-Z])", "hom"), (r"\\Hom(?![a-zA-Z])", "Hom"), (r"\\End(?![a-zA-Z])", "End"),
    (r"\\Aut(?![a-zA-Z])", "Aut"), (r"\\Gal(?![a-zA-Z])", "Gal"),
    (r"\\log(?![a-zA-Z])", "log "), (r"\\ln(?![a-zA-Z])", "ln "),
    (r"\\sin(?![a-zA-Z])", "sin"), (r"\\cos(?![a-zA-Z])", "cos"), (r"\\tan(?![a-zA-Z])", "tan"),
    (r"\\arg(?![a-zA-Z])", "arg "),
    (r"\\exp(?![a-zA-Z])", "exp"), (r"\\sup(?![a-zA-Z])", "sup "), (r"\\inf(?![a-zA-Z])", "inf "),
    (r"\\limsup(?![a-zA-Z])", "lim sup "), (r"\\liminf(?![a-zA-Z])", "lim inf "), (r"\\lim(?![a-zA-Z])", "lim"),
    (r"\\max(?![a-zA-Z])", "max"), (r"\\min(?![a-zA-Z])", "min"),
    (r"\\not\\mid(?![a-zA-Z])", "∤"), (r"\\mid(?![a-zA-Z])", "∣"), (r"\\nmid(?![a-zA-Z])", "∤"),
    (r"\\in(?![a-zA-Z])", "∈"), (r"\\notin(?![a-zA-Z])", "∉"), (r"\\ni(?![a-zA-Z])", "∋"),
    (r"\\subseteq(?![a-zA-Z])", "⊆"), (r"\\subsetneq(?![a-zA-Z])", "⊊"), (r"\\subset(?![a-zA-Z])", "⊂"),
    (r"\\supseteq(?![a-zA-Z])", "⊇"), (r"\\supset(?![a-zA-Z])", "⊃"),
    (r"\\forall(?![a-zA-Z])", "∀"), (r"\\exists(?![a-zA-Z])", "∃"), (r"\\nexists(?![a-zA-Z])", "∄"),
    (r"\\neg(?![a-zA-Z])", "¬"), (r"\\lnot(?![a-zA-Z])", "¬"),
    (r"\\land(?![a-zA-Z])", "∧"), (r"\\lor(?![a-zA-Z])", "∨"),
    (r"\\vdash(?![a-zA-Z])", "⊢"), (r"\\models(?![a-zA-Z])", "⊨"),
    (r"\\sum(?![a-zA-Z])", "∑"), (r"\\prod(?![a-zA-Z])", "∏"), (r"\\coprod(?![a-zA-Z])", "∐"), (r"\\amalg(?![a-zA-Z])", "∐"),
    (r"\\iiint(?![a-zA-Z])", "∭"), (r"\\iint(?![a-zA-Z])", "∬"), (r"\\oint(?![a-zA-Z])", "∮"), (r"\\int(?![a-zA-Z])", "∫"),
    (r"\\prime(?![a-zA-Z])", "′"),
]

NUM_RE = re.compile(r"^[+-]?[0-9][0-9,.]*%?$")
CENTER_BADGES = {"PASS", "ONGOING", "유형 I", "유형 II", "Type I", "Type II", "Type II-A", "Type II-B"}


def strip_tags(s: str) -> str:
    return html.unescape(re.sub(r"<[^>]+>", "", s)).strip()


def convert_unicode_sub_digits(escaped_html: str) -> str:
    return UNICODE_SUB_RE.sub(
        lambda m: '<sub class="code-sub">' + "".join(UNICODE_SUB_DIGITS[c] for c in m.group(1)) + "</sub>",
        escaped_html,
    )


def format_tex_expr(expr: str, is_block: bool = False) -> str:
    s = expr.strip()

    def render_matrix(mat):
        mtype = mat.group(1)
        body = mat.group(2).strip()
        lbr, rbr = {"pmatrix": ("(", ")"), "bmatrix": ("[", "]"), "vmatrix": ("|", "|"), "Bmatrix": ("{", "}")}.get(mtype, ("(", ")"))
        rows = [
            " &nbsp; ".join(c.strip() for c in row.strip().split("&"))
            for row in body.split("\\\\")
            if row.strip()
        ]
        inner = "<br/>".join(rows)
        return f"<span class='binom'>{lbr}<span class='bstack'>{inner}</span>{rbr}</span>"

    s = re.sub(r"\\begin\{(pmatrix|bmatrix|vmatrix|Bmatrix|matrix)\}([\s\S]*?)\\end\{\1\}", render_matrix, s)
    s = re.sub(r"\\begin\{(?:aligned|align\*?|gather\*?|cases|split)\}", "", s)
    s = re.sub(r"\\end\{(?:aligned|align\*?|gather\*?|cases|split)\}", "", s)
    if is_block:
        s = s.replace("\\\\", "<br/>")
        s = re.sub(r"\s*&\s*", " ", s)
    else:
        s = s.replace("\\\\", " ; ")
        s = re.sub(r"\s*&\s*", " ", s)

    s = s.replace("{,}", ",")

    s = re.sub(r"\\mathcal\{([A-Za-z])\}", lambda m: CALLIGRAPHIC.get(m.group(1), m.group(1)), s)
    s = re.sub(r"\\mathbb\{([A-Za-z])\}", lambda m: BLACKBOARD.get(m.group(1), m.group(1)), s)
    s = re.sub(r"\\mathfrak\{([A-Za-z]+)\}", lambda m: FRAKTUR.get(m.group(1), m.group(1)), s)

    for pat, rep in TEX_SUBS:
        s = re.sub(pat, rep, s)

    for _ in range(7):
        s = re.sub(r"\\pmod\s*\{([^{}]*)\}", r"(mod \1)", s)
        s = re.sub(r"\\pmod\s+([A-Za-z0-9α-ωΑ-Ωℓ]+)", r"(mod \1)", s)
        s = re.sub(r"\\bmod\s*\{([^{}]*)\}", r" mod \1", s)
        s = re.sub(
            r"\\xrightarrow\{([^{}]*)\}",
            r"<span class='overset'><span class='ov-top'>\1</span><span>⟶</span></span>",
            s,
        )
        s = re.sub(
            r"\\xleftarrow\{([^{}]*)\}",
            r"<span class='overset'><span class='ov-top'>\1</span><span>⟵</span></span>",
            s,
        )
        s = re.sub(r"\\(?:operatorname\*?|mathrm|mathsf|mathtt|text|textbf|textit|rm|bf)\{([^{}]*)\}", r"\1", s)
        s = re.sub(r"\\(?:mathbf|boldsymbol)\{([^{}]*)\}", r"<strong>\1</strong>", s)
        s = re.sub(r"\\(?:overline|bar)\{([^{}]*)\}", r"<span style='text-decoration:overline;'>\1</span>", s)
        s = re.sub(r"\\underline\{([^{}]*)\}", r"<span style='text-decoration:underline;'>\1</span>", s)
        s = re.sub(r"\\(?:widetilde|tilde)\{([^{}]*)\}", r"\1̃", s)
        s = re.sub(r"\\(?:widehat|hat)\{([^{}]*)\}", r"\1̂", s)
        s = re.sub(r"\\vec\{([^{}]*)\}", r"\1⃗", s)
        s = re.sub(r"\\dot\{([^{}]*)\}", r"\1̇", s)
        s = re.sub(
            r"\\overset\{([^{}]*)\}\{([^{}]*)\}",
            r"<span class='overset'><span class='ov-top'>\1</span><span>\2</span></span>",
            s,
        )
        s = re.sub(
            r"\\underset\{([^{}]*)\}\{([^{}]*)\}",
            r"<span class='overset'><span>\2</span><span class='ov-top'>\1</span></span>",
            s,
        )
        s = re.sub(
            r"\\binom\{([^{}]*)\}\{([^{}]*)\}",
            r"<span class='binom'>(<span class='bstack'><span>\1</span><span>\2</span></span>)</span>",
            s,
        )
        s = re.sub(r"\\sqrt\[([^\[\]]+)\]\{([^{}]*)\}", r"<sup>\1</sup><span class='sqrt'>√<span class='rad'>\2</span></span>", s)
        s = re.sub(r"\\sqrt\{([^{}]*)\}", r"<span class='sqrt'>√<span class='rad'>\1</span></span>", s)
        s = re.sub(
            r"\\(?:tfrac|dfrac|frac)\{([^{}]*)\}\{([^{}]*)\}",
            lambda m: f"<span class='frac'><span class='num'>{m.group(1)}</span><span class='den'>{m.group(2)}</span></span>",
            s,
        )
        s = re.sub(r"(∑|∏|∫|∬|∭|∮|⨁|⨂|⋃|⋂|⨆)_\{([^{}]*)\}\^\{([^{}]*)\}", r"\1<sub>\2</sub><sup>\3</sup>", s)
        s = re.sub(r"(∑|∏|∫|∬|∭|∮|⨁|⨂|⋃|⋂|⨆)_\{([^{}]*)\}", r"\1<sub>\2</sub>", s)
        s = re.sub(r"\^\{([^{}]*)\}", r"<sup>\1</sup>", s)
        s = re.sub(r"_\{([^{}]*)\}", r"<sub>\1</sub>", s)

    s = re.sub(r"\\tilde\s*([A-Za-zα-ωΑ-Ω])", r"\1̃", s)
    s = re.sub(r"\\hat\s*([A-Za-zα-ωΑ-Ω])", r"\1̂", s)
    s = re.sub(r"\\bar\s*([A-Za-zα-ωΑ-Ω])", r"<span style='text-decoration:overline;'>\1</span>", s)
    s = re.sub(r"\^\s*([0-9a-zA-Zα-ωΑ-Ωℓ∨∧×'+*∗∘♭♯♮′⊥⊤±∓∞−-])", r"<sup>\1</sup>", s)
    s = re.sub(r"_\s*([0-9a-zA-Zα-ωΑ-Ωℓ+*∗∘♭♯♮′⊥⊤±∓∞−-])", r"<sub>\1</sub>", s)
    s = re.sub(r"\\not\s*≡", "≢", s)
    s = re.sub(r"\\not\s*=", "≠", s)
    s = re.sub(r"\\not\s*∣", "∤", s)
    s = re.sub(r"\\not\s*∈", "∉", s)
    s = re.sub(r"\\not\s*⊆", "⊈", s)
    s = re.sub(r"\\not\s*⊂", "⊄", s)
    s = s.replace("@@LBRACE@@", "{").replace("@@RBRACE@@", "}")
    s = s.replace("\\|", "‖")
    if "\\" in s:
        raise ValueError(f"Unconverted TeX backslash in math: {s!r}")
    plain_check = strip_tags(s)
    if "^" in plain_check or "_" in plain_check:
        raise ValueError(f"Unconverted raw '^' or '_' in math: {plain_check!r} (from {expr!r})")
    s = s.replace("@@ESC_US@@", "_")
    return s


def make_inline_math(expr: str) -> str:
    rendered = format_tex_expr(expr, is_block=False)
    cls = "math-inline math-nowrap" if len(strip_tags(rendered)) <= 26 else "math-inline"
    return f"<span class='{cls}'>{rendered}</span>"


def normalize_ordered_lists(md_text: str) -> str:
    """Ensure multi-paragraph / display-math / fenced-code bodies between top-level
    ordered list items r. and (r+1). stay 4-space indented inside <li> without splitting <ol>."""
    lines = md_text.splitlines()
    in_fence = False
    top_items = []
    boundary_lines = set()

    for idx, ln in enumerate(lines):
        st = ln.strip()
        if st.startswith("```"):
            in_fence = not in_fence
            continue
        if in_fence:
            continue
        if re.match(r"^#{1,6}\s+", ln) or st == "---" or ln.startswith("|"):
            boundary_lines.add(idx)
            continue
        m = re.match(r"^(\d+)\.\s+", ln)
        if m:
            top_items.append((idx, int(m.group(1))))

    indent_ranges = []
    next_item_lines = set()
    for k in range(len(top_items) - 1):
        i_a, n_a = top_items[k]
        i_b, n_b = top_items[k + 1]
        if n_b == n_a + 1 and not any(b in boundary_lines for b in range(i_a + 1, i_b)):
            indent_ranges.append((i_a + 1, i_b))
            next_item_lines.add(i_b)

    to_indent = set()
    for lo, hi in indent_ranges:
        for j in range(lo, hi):
            to_indent.add(j)

    out = []
    in_fence = False
    fence_needs_indent = False
    for idx, ln in enumerate(lines):
        if idx in next_item_lines and out and out[-1].strip() != "":
            out.append("")
        st = ln.strip()
        if idx in to_indent:
            if st.startswith("```"):
                if not in_fence:
                    in_fence = True
                    fence_needs_indent = not ln.startswith("    ")
                    out.append("    " + ln.lstrip() if fence_needs_indent else ln)
                else:
                    out.append("    " + ln.lstrip() if fence_needs_indent else ln)
                    in_fence = False
                    fence_needs_indent = False
                continue
            if in_fence:
                out.append(("    " + ln) if (fence_needs_indent and ln != "") else ln)
                continue
            if st == "":
                out.append("")
            elif ln.startswith("    "):
                out.append(ln)
            else:
                out.append("    " + ln.lstrip())
        else:
            if st.startswith("```"):
                in_fence = not in_fence
            out.append(ln)
    return "\n".join(out)


def replace_math(md_text: str):
    md_text = normalize_ordered_lists(md_text)
    code_stash = []

    def save_code(mat):
        idx = len(code_stash)
        code_stash.append(mat.group(0))
        return f"@@CODE_FENCE_{idx}@@"

    md_text = re.sub(r"```[\s\S]*?```", save_code, md_text)

    inline_code_stash = []

    def save_inline_code(mat):
        idx = len(inline_code_stash)
        inline_code_stash.append(mat.group(0))
        return f"@@INLINE_CODE_{idx}@@"

    md_text = re.sub(r"`[^`\n]+`", save_inline_code, md_text)

    norm_lines = []
    raw_lines = md_text.splitlines()
    in_disp = False
    for idx, ln in enumerate(raw_lines):
        st = ln.strip()
        if st == "$$":
            if not in_disp and idx > 0 and raw_lines[idx - 1].strip() != "":
                norm_lines.append("")
            norm_lines.append(ln)
            in_disp = not in_disp
            continue
        prev = raw_lines[idx - 1] if idx > 0 else ""
        if prev.strip() == "$$" and not in_disp and st != "":
            norm_lines.append("")
        m_list = re.match(r"^(\s{0,3})([-*]|\d+\.)\s+(.*)$", ln)
        if m_list and not in_disp:
            prev_is_list_or_cont = bool(re.match(r"^\s*(?:[-*]|\d+\.)\s", prev)) or prev.startswith("   ")
            if idx > 0 and prev.strip() != "" and not prev_is_list_or_cont:
                norm_lines.append("")
                ln = f"{m_list.group(2)} {m_list.group(3)}"
        norm_lines.append(ln)
    md_text = "\n".join(norm_lines)

    math_stash = []

    def save_math(rendered: str) -> str:
        idx = len(math_stash)
        math_stash.append(rendered)
        return f"@@MATH_TOKEN_{idx}@@"

    md_text = re.sub(
        r"(?m)^([ \t]*)\$\$([\s\S]+?)\$\$",
        lambda m: m.group(1) + save_math(f"<div class='math-block'>{format_tex_expr(m.group(2), is_block=True)}</div>"),
        md_text,
    )
    md_text = re.sub(
        r"\$\$([\s\S]+?)\$\$",
        lambda m: save_math(f"<div class='math-block'>{format_tex_expr(m.group(1), is_block=True)}</div>"),
        md_text,
    )
    md_text = re.sub(
        r"(?<!\$)\$(?!\$)([^\n$]+?)\$(?!\$)",
        lambda m: save_math(make_inline_math(m.group(1))),
        md_text,
    )

    for idx, ic in enumerate(inline_code_stash):
        md_text = md_text.replace(f"@@INLINE_CODE_{idx}@@", ic)
    for idx, cf in enumerate(code_stash):
        md_text = md_text.replace(f"@@CODE_FENCE_{idx}@@", cf)

    return md_text, math_stash


def format_inline_code_tag(mat) -> str:
    raw = html.unescape(mat.group(1))
    esc = html.escape(raw)
    if len(raw) <= 20 or (len(raw) <= 28 and "/" not in raw and "_" not in raw):
        return f'<code class="code-nowrap">{convert_unicode_sub_digits(esc)}</code>'
    wrapped = re.sub(r"([/_.])", r"\1<wbr/>", esc)
    wrapped = re.sub(r"([a-z])([A-Z])", r"\1<wbr/>\2", wrapped)
    return f'<code class="code-wrap">{convert_unicode_sub_digits(wrapped)}</code>'


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
        pre_blocks.append(convert_unicode_sub_digits(mat.group(0)))
        return f"@@PRE_BLOCK_{idx}@@"

    s = re.sub(r"<pre>[\s\S]*?</pre>", save_pre, html_str)
    s = re.sub(r"<code>([^<]*)</code>", format_inline_code_tag, s)
    s = re.sub(r"<th(?:\s+align=\"[^\"]*\")?>([\s\S]*?)</th>", format_th_tag, s)
    s = re.sub(r"<td(?:\s+align=\"[^\"]*\")?>([\s\S]*?)</td>", format_td_tag, s)
    for idx, blk in enumerate(pre_blocks):
        s = s.replace(f"@@PRE_BLOCK_{idx}@@", blk)
    return s


def inline_images(html_str: str, base_dir: pathlib.Path) -> str:
    def repl(mat):
        src = mat.group(1)
        if "figures/" in src:
            fp = (base_dir / src).resolve()
            if fp.is_file():
                b64 = base64.b64encode(fp.read_bytes()).decode("ascii")
                return f'src="data:image/png;base64,{b64}"'
        return mat.group(0)

    return re.sub(r'src="([^"]+)"', repl, html_str)


CSS_STYLE_TEMPLATE = """
@page {{
  size: A4; margin: 18mm 16mm 20mm 16mm;
  @bottom-center {{ content: counter(page) " / " counter(pages); font-family: {sans_font}; font-size: 8.5pt; color: #64748B; }}
}}
* {{ box-sizing: border-box; }}
body {{ margin: 0; padding: 0; background: #F7F5F0; color: #1A202C; font-family: {body_font}; font-size: 10.2pt; line-height: 1.72; {word_break_rule} }}
.page-shell {{ max-width: 860px; margin: 0 auto; background: #FFFFFF; padding: 44px 52px; }}
@media print {{ body {{ background: #FFFFFF; }} .page-shell {{ max-width: none; padding: 0; }} }}
.cover {{ padding: 54px 12px 44px 12px; border-bottom: 3px solid #1E293B; margin-bottom: 34px; page-break-after: always; }}
.cover-kicker {{ font-family: {sans_font}; font-size: 9.8pt; font-weight: 700; letter-spacing: 0.08em; color: #9B2C2C; margin-bottom: 14px; }}
.cover-title {{ font-family: {sans_font}; font-size: 22.0pt; font-weight: 800; line-height: 1.32; color: #0F172A; margin: 0 0 16px 0; }}
.cover-sub {{ font-size: 11.0pt; line-height: 1.60; color: #334155; margin-bottom: 28px; }}
.cover-meta {{ background: #F8FAFC; border-left: 4px solid #1F5A73; padding: 15px 18px; font-family: {sans_font}; font-size: 9.2pt; line-height: 1.70; color: #1E293B; }}
.toc-box {{ background: #FAF9F6; border: 1px solid #CBD5E1; padding: 22px 28px; margin-bottom: 34px; page-break-after: always; }}
.toc-title {{ font-family: {sans_font}; font-size: 14pt; font-weight: 700; margin: 0 0 12px 0; color: #0F172A; }}
.toc-list {{ margin: 0; padding-left: 20px; font-family: {sans_font}; font-size: 9.4pt; line-height: 1.82; }}
.toc-sublist {{ margin: 2px 0 8px 0; padding-left: 18px; font-size: 8.6pt; line-height: 1.60; color: #475569; list-style-type: disc; }}
.toc-list a {{ color: #1E3A5F; text-decoration: none; }}
.chapter {{ page-break-before: always; padding-top: 4px; }}
.chapter:first-of-type {{ page-break-before: auto; }}
.chapter-badge {{ font-family: {sans_font}; font-size: 9pt; font-weight: 700; color: #1F5A73; letter-spacing: 0.05em; margin-bottom: 4px; }}
h1, h2, h3, h4 {{ font-family: {sans_font}; color: #0F172A; break-after: avoid; }}
h1 {{ font-size: 16.0pt; line-height: 1.35; border-bottom: 2px solid #1E293B; padding-bottom: 9px; margin-top: 4px; }}
h2 {{ font-size: 12.0pt; line-height: 1.4; margin-top: 22px; margin-bottom: 9px; color: #1E3A5F; border-left: 3.5px solid #1F5A73; padding-left: 8px; }}
h3 {{ font-size: 10.4pt; margin-top: 16px; margin-bottom: 7px; color: #334155; }}
h4 {{ font-size: 9.6pt; margin-top: 12px; margin-bottom: 5px; color: #475569; }}
p {{ margin: 0 0 10px 0; text-align: justify; }}
ul, ol {{ margin: 0 0 12px 0; padding-left: 22px; }}
li {{ margin-bottom: 4px; }}
hr {{ border: none; border-top: 1px solid #E2E8F0; margin: 18px 0; }}
blockquote {{ margin: 12px 0; padding: 10px 15px; background: #F8FAFC; border-left: 4px solid #B83227; font-family: {sans_font}; font-size: 9.2pt; line-height: 1.60; color: #1E293B; break-inside: avoid; }}
blockquote p {{ margin: 0; text-align: left; }}
code {{ font-family: "DejaVu Sans Mono", "DejaVu Math TeX Gyre", "D2Coding ligature", "NanumSquare Neo", monospace; font-size: 8.1pt; background: #F1F5F9; color: #0F172A; padding: 1px 4px; border-radius: 3px; word-break: keep-all; }}
code.code-nowrap {{ white-space: nowrap; }}
code.code-wrap {{ white-space: normal; overflow-wrap: break-word; }}
sub.code-sub {{ font-size: 0.76em; line-height: 0; vertical-align: -0.22em; }}
pre {{ background: #0F172A; color: #F8FAFC; padding: 11px 14px; border-radius: 5px; overflow-x: auto; line-height: 1.45; break-inside: avoid; }}
pre code {{ background: transparent; color: #F8FAFC; padding: 0; font-size: 8.0pt; white-space: pre-wrap; overflow-wrap: anywhere; }}
table {{ width: 100%; border-collapse: collapse; margin: 11px 0 15px 0; font-family: {sans_font}; font-size: 8.1pt; line-height: 1.44; font-variant-numeric: tabular-nums; }}
thead {{ display: table-header-group; }}
tr {{ break-inside: avoid; }}
th {{ background: #1E293B; color: #FFFFFF; font-weight: 700; text-align: left; padding: 5px 7px; border: 1px solid #1E293B; }}
th code {{ background: #334155; color: #F8FAFC; }}
th.th-nowrap {{ white-space: nowrap; }}
td {{ padding: 5px 7px; border: 1px solid #CBD5E1; vertical-align: top; }}
td.td-num {{ white-space: nowrap; text-align: right; }}
td.td-center {{ white-space: nowrap; text-align: center; font-weight: 700; }}
tbody tr:nth-child(even) {{ background: #FAF9F6; }}
img {{ display: block; max-width: 100%; height: auto; margin: 12px auto; border: 1px solid #E2E8F0; border-radius: 4px; break-inside: avoid; }}
.math-block {{ margin: 11px 0; padding: 9px 14px; background: #FAF9F6; border: 1px solid #E2E8F0; border-radius: 4px; text-align: center; font-family: "DejaVu Math TeX Gyre", "DejaVu Serif", "NanumMyeongjo", serif; font-size: 10.4pt; line-height: 1.55; break-inside: avoid; }}
.math-inline {{ font-family: "DejaVu Math TeX Gyre", "DejaVu Serif", "NanumMyeongjo", serif; font-style: italic; padding: 0 1px; }}
.math-nowrap, sup, sub, .frac, .sqrt {{ white-space: nowrap; }}
.frac {{ display: inline-flex; flex-direction: column; vertical-align: middle; text-align: center; padding: 0 3px; font-style: normal; }}
.frac .num {{ border-bottom: 1px solid #1A202C; padding: 0 3px 1px 3px; line-height: 1.15; }}
.frac .den {{ padding: 1px 3px 0 3px; line-height: 1.15; }}
.binom {{ display: inline-flex; align-items: center; vertical-align: middle; font-style: normal; padding: 0 2px; }}
.bstack {{ display: inline-flex; flex-direction: column; text-align: center; font-size: 0.82em; line-height: 1.05; padding: 0 1px; }}
.overset {{ display: inline-flex; flex-direction: column; align-items: center; vertical-align: middle; padding: 0 3px; }}
.ov-top {{ font-size: 0.68em; line-height: 1.0; font-style: normal; }}
.sqrt .rad {{ border-top: 1px solid #1A202C; padding-top: 1px; }}
"""


def render_inline_fragment(txt: str) -> str:
    prepped, stash = replace_math(txt)
    frag = markdown.markdown(prepped)
    frag = re.sub(r"^<p>|</p>\s*$", "", frag)
    for tidx, val in enumerate(stash):
        frag = frag.replace(f"@@MATH_TOKEN_{tidx}@@", val)
    return postprocess_typography(frag)


def render_chapter(idx: int, badge: str, md_path: pathlib.Path):
    raw = md_path.read_text(encoding="utf-8")
    h2_titles = []
    for ln in raw.splitlines():
        if ln.startswith("## "):
            h2_titles.append(ln[3:].strip())
    prepped, stash = replace_math(raw)
    body = markdown.markdown(prepped, extensions=["tables", "fenced_code", "sane_lists"])
    for tidx, val in enumerate(stash):
        body = body.replace(f"@@MATH_TOKEN_{tidx}@@", val)
    body = postprocess_typography(body)
    body = inline_images(body, md_path.parent)
    sec_html = f'<section class="chapter" id="chap-{idx}"><div class="chapter-badge">{html.escape(badge)}</div>{body}</section>'
    return sec_html, h2_titles


def build_edition(
    lang: str,
    chapters: list,
    html_name: str,
    pdf_name: str,
    doc_title: str,
    kicker: str,
    cover_title: str,
    cover_sub: str,
    meta_lines: list,
    toc_heading: str,
):
    toc_items = []
    chap_htmls = []

    for idx, (badge, path) in enumerate(chapters):
        if not path.is_file():
            raise FileNotFoundError(f"Missing Part A volume ({lang}): {path}")
        sec_html, h2_list = render_chapter(idx, badge, path)
        chap_htmls.append(sec_html)
        sub_ul = ""
        if h2_list:
            sub_lis = "".join(
                f"<li>{render_inline_fragment(re.sub(r'^[0-9]+[.][ ]+', '', h2))}</li>" for h2 in h2_list
            )
            sub_ul = f'<ul class="toc-sublist">{sub_lis}</ul>'
        toc_items.append(
            f'<li><a href="#chap-{idx}"><strong>{html.escape(badge)}</strong></a>{sub_ul}</li>'
        )

    if lang == "ko":
        css = CSS_STYLE_TEMPLATE.format(
            body_font='"NanumMyeongjo", "DejaVu Serif", serif',
            sans_font='"NanumSquare Neo", "DejaVu Sans", sans-serif',
            word_break_rule="word-break: keep-all;",
        )
    else:
        css = CSS_STYLE_TEMPLATE.format(
            body_font='"DejaVu Serif", "Liberation Serif", serif',
            sans_font='"DejaVu Sans", "Liberation Sans", sans-serif',
            word_break_rule="word-break: normal;",
        )

    meta_divs = "".join(f"<div>{ln}</div>" for ln in meta_lines)
    full_html = f"""<!DOCTYPE html>
<html lang="{lang}">
<head>
<meta charset="utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<title>{html.escape(doc_title)}</title>
<style>{css}</style>
</head>
<body>
<div class="page-shell">
  <header class="cover">
    <div class="cover-kicker">{html.escape(kicker)}</div>
    <h1 class="cover-title" style="border:none;">{cover_title}</h1>
    <div class="cover-sub">{html.escape(cover_sub)}</div>
    <div class="cover-meta">{meta_divs}</div>
  </header>
  <nav class="toc-box">
    <h2 class="toc-title" style="border:none;padding:0;margin-top:0;">{html.escape(toc_heading)}</h2>
    <ol class="toc-list">{''.join(toc_items)}</ol>
  </nav>
  {''.join(chap_htmls)}
</div>
</body>
</html>
"""

    html_out = BOOK_DIR / html_name
    pdf_out = BOOK_DIR / pdf_name
    html_out.write_text(full_html, encoding="utf-8")

    cmd = [
        "/usr/bin/google-chrome",
        "--headless",
        "--disable-gpu",
        "--no-pdf-header-footer",
        f"--print-to-pdf={pdf_out}",
        f"file://{html_out}",
    ]
    r = subprocess.run(cmd, capture_output=True, text=True, check=False, timeout=180)
    if r.returncode != 0 or not pdf_out.is_file():
        raise RuntimeError(f"Chrome PDF build failed ({lang}) rc={r.returncode}: {r.stderr}")

    pinfo = subprocess.run(["pdfinfo", str(pdf_out)], capture_output=True, text=True, check=False, timeout=30)
    pages = "?"
    for ln in pinfo.stdout.splitlines():
        if ln.startswith("Pages:"):
            pages = ln.split(":", 1)[1].strip()
    print(f"MONOGRAPH_OK [{lang.upper()}]: HTML={html_out.stat().st_size:,}B | PDF={pdf_out.stat().st_size:,}B | PAGES={pages}")


def main():
    BOOK_DIR.mkdir(parents=True, exist_ok=True)

    build_edition(
        lang="ko",
        chapters=CHAPTERS_KO,
        html_name="알푀게_리만가설_신작증명_심층해독단행본_AB.html",
        pdf_name="알푀게_리만가설_신작증명_심층해독단행본_AB.pdf",
        doc_title="알푀게 리만 가설·GRH 1,737만 줄 형식증명 심층 해독 단행본 (Part A-B)",
        kicker="수리 포렌식 및 신작 증명 심층 역설계 학술 단행본 · 2026-11-22",
        cover_title="알푀게 리만 가설 · GRH 형식증명<br/>신작 422만 줄 심층 해독 단행본 (Part A)",
        cover_sub="Mathlib 원문 경계 의미론 감사, 기출 문헌 201개 임포트 동치성 판정, Formalism 116개 소이론 하부 허브 수식 복원, 베렌트 이와사와 타워 반디버 우회 및 Part B 전수 수식 도감(30,343개 모듈 · 308,731개 선언) 통합본",
        meta_lines=[
            "<strong>기계 커널 검증</strong> : lean4:v4.33.1(x86_64 · aarch64) 및 이종 커널(nanoda · con-leche · lean4lean) 175,187개 파일 통과 (PASS)",
            "<strong>Part A 단행본 범위</strong> : Mathlib 경계 의미론 감사 · 기출 201임포트(PublishedTheorems 1,073개) 동치성 감사 · Formalism 4대 기둥 및 112개 소이론(320만 줄) 하부 수식 복원 · Pure_Vwin 반디버 우회(103만 줄) 복원 · 독립 무-sorry Lean 검증 스위트(44개 정리)",
            "<strong>Part B 연동 도감</strong> : 신작 영역 29,067개 파일 + 기출 명세 1,258개 파일 + 상단 척추 = 고유 30,343개 모듈 · 308,731개 선언 전수(100.00%) AST 역컴파일 도감(B00~B10, 37.4만 줄) 연동",
        ],
        toc_heading="전체 목차 (제0부 ~ 제6부)",
    )

    if all(p.is_file() for _, p in CHAPTERS_EN):
        build_edition(
            lang="en",
            chapters=CHAPTERS_EN,
            html_name="Alpoge_RH_AB_Deep_Decompilation_EN.html",
            pdf_name="Alpoge_RH_AB_Deep_Decompilation_EN.pdf",
            doc_title="Deep Mathematical Decompilation of the 17.37M-Line Alpöge-Claude RH & GRH Proof (Part A-B)",
            kicker="MATHEMATICAL FORENSICS & DEEP DECOMPILATION MONOGRAPH · 2026-11-22",
            cover_title="Deep Decompilation of the Alpöge-Claude<br/>4.22M-Line Novel RH &amp; GRH Proof Engine (Part A)",
            cover_sub="Pinned Mathlib Boundary Semantics Audit, 201 Classical Import Equivalence Classification, Formalism 116 Subtheory Hub Equations, Behrend-Iwasawa Vandiver Bypass, and 100.00% AST Formula Atlas (30,343 Modules · 308,731 Declarations)",
            meta_lines=[
                "<strong>Mechanical Kernel Verification</strong> : 175,187 / 175,187 modules verified under lean4:v4.33.1 (x86_64 &amp; aarch64) and independent kernels (nanoda · con-leche · lean4lean) (PASS)",
                "<strong>Part A Monograph Scope</strong> : Pinned Mathlib boundary semantics · 201 classical imports &amp; 1,073 PublishedTheorems equivalence audit · Formalism 4 pillars &amp; 112 subtheories (3.20M lines) hub decompilation · Pure_Vwin Vandiver bypass (1.03M lines) · 44-theorem standalone zero-sorry Lean 4 suite",
                "<strong>Part B Companion Atlas</strong> : 29,067 novel modules + 1,258 classical boundary modules + top spine = 30,343 unique modules · 308,731 / 308,731 declarations (100.00%) AST-indexed across Volumes B00-B10 (373,974 lines)",
            ],
            toc_heading="Complete Contents (Volumes 0 - 6)",
        )


if __name__ == "__main__":
    main()
