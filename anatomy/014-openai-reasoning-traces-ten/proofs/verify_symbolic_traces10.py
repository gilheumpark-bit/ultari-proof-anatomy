#!/usr/bin/env python3
"""Deterministic symbolic & primary-source forensic verifier for Case 014 (OpenAI 10 Reasoning Traces)."""
from fractions import Fraction
import json
import pathlib
import re
import unicodedata
import sympy as sp

PROOFS_DIR = pathlib.Path(__file__).resolve().parent
OAI_REF = PROOFS_DIR / "oai_ref"
GREEK_MAP = {
    "π": "pi", "𝜋": "pi", "μ": "mu", "𝜇": "mu", "λ": "lambda", "𝜆": "lambda",
    "Δ": "delta", "𝛿": "delta", "δ": "delta", "ζ": "zeta", "𝜁": "zeta",
    "α": "alpha", "β": "beta", "γ": "gamma", "ε": "eps", "∞": "infty",
}


def norm_math_text(raw: str) -> str:
    text = raw.replace("ﬀ", "ff").replace("ﬁ", "fi").replace("ﬂ", "fl").replace("ﬃ", "ffi").replace("ﬄ", "ffl")
    for ch, rep in GREEK_MAP.items():
        text = text.replace(ch, f" {rep} ")
    text = re.sub(r"\\(?:mathbb|mathcal|mathbf|mathrm|mathsf|mathfrak|mathscr|emph|textit|textbf)\s*\{([^{}]*)\}", r" \1 ", text)
    text = text.replace("{", "").replace("}", "")
    text = re.sub(r"\\(?:dots|ldots|cdots)\b", " ", text)
    text = re.sub(r"\\['\"`^~=.uvHckbd]\s*([A-Za-z])", r"\1", text)
    for src, dst in (("\\ss", "ss"), ("\\l", "l"), ("\\o", "o"), ("\\O", "O"), ("\\aa", "a"), ("\\AA", "A")):
        text = text.replace(src, dst)
    nfkd = unicodedata.normalize("NFKD", text)
    mapped = "".join(GREEK_MAP.get(c, c) for c in nfkd)
    ascii_only = mapped.encode("ascii", "ignore").decode("ascii")
    return re.sub(r"[^a-z0-9]+", " ", ascii_only.lower()).strip()


def verify_forensic_compiler_template() -> dict:
    """Live audit of leaked mezard-parisi-formula.tex and glyph-mappings.tex in oai_ref/preprints_tex/."""
    mp_tex = (OAI_REF / "preprints_tex" / "mezard-parisi-formula.tex").read_text(encoding="utf-8")
    glyph_tex = (OAI_REF / "preprints_tex" / "glyph-mappings.tex").read_text(encoding="utf-8")
    intro_102 = (OAI_REF / "preprints_tex" / "00-introduction.tex").read_text(encoding="utf-8")
    conseq_102 = (OAI_REF / "preprints_tex" / "07-consequences.tex").read_text(encoding="utf-8")

    cpx_macros = [
        m for m in ("\\UGC", "\\CSP", "\\NP", "\\OPT", "\\SDP")
        if f"\\newcommand{{{m}}}" in mp_tex or f"\\DeclareMathOperator{{{m}}}" in mp_tex
    ]
    cjk_defs = re.findall(r"\\gdef([\u4e00-\u9fff])", mp_tex)
    has_fandol = "FandolFang-Regular.otf" in mp_tex
    has_redaction = "[Administrative details redacted.]" in mp_tex
    has_anti_comp = "computer-assisted proofs are strongly discouraged" in mp_tex
    mezard_gdef_cnt = len(re.findall(r"\\gdef", mp_tex))
    glyph_unicode_cnt = len(re.findall(r"\\pdfglyphtounicode\{", glyph_tex))
    glyph_cjk_cnt = sum(1 for ch in glyph_tex if "\u4e00" <= ch <= "\u9fff")
    ug_cor_demotion = "\\label{cor:raghavendra-consequence}" in conseq_102 and "Theorem~\\ref{thm:ugc}" in intro_102

    assert len(mp_tex.splitlines()) == 211
    assert len(cpx_macros) == 5 and mezard_gdef_cnt == 14 and cjk_defs == ["自", "由"]
    assert has_fandol and has_redaction and has_anti_comp
    assert glyph_unicode_cnt == 38 and glyph_cjk_cnt == 0 and ug_cor_demotion

    return {
        "mezard_tex_lines": len(mp_tex.splitlines()),
        "inherited_complexity_macros": cpx_macros,
        "mezard_active_gdefs": mezard_gdef_cnt,
        "cjk_active_chars": cjk_defs,
        "cjk_codepoints": [ord(c) for c in cjk_defs],
        "fandol_font_loaded": has_fandol,
        "administrative_redaction_present": has_redaction,
        "anti_computer_directive_present": has_anti_comp,
        "preprint_glyph_mappings": glyph_unicode_cnt,
        "preprint_cjk_glyphs": glyph_cjk_cnt,
        "ug102_raghavendra_corollary_demoted": ug_cor_demotion,
    }


def _load_bib_snapshot() -> dict:
    bib_by_fam: dict[str, list[tuple[str, str, str, set[str], set[str]]]] = {}
    tsv = (OAI_REF / "traces_txt" / "primary_bibs_snapshot.tsv").read_text(encoding="utf-8")
    for ln in tsv.splitlines():
        if not ln.strip():
            continue
        fid, bkey, auth, title, dois_s, arx_s = ln.split("\t")
        dois = {x for x in dois_s.split(";") if x}
        arx = {x for x in arx_s.split(";") if x}
        bib_by_fam.setdefault(fid, []).append((bkey, norm_math_text(auth), norm_math_text(title), dois, arx))
    return bib_by_fam


def _match_single_trace_ref(rbody: str, bib_items: list) -> bool:
    r_dois = {d.rstrip(".,;)}") for d in re.findall(r"10\.\d{4,9}/[^\s,}\]]+", rbody.lower())}
    r_arxiv = {
        re.sub(r"v\d+$", "", x)
        for x in re.findall(r"\b\d{4}\.\d{4,5}(?:v\d+)?\b|\b(?:math|cs|quant-ph|cond-mat|hep-th)/\d{7}(?:v\d+)?\b", rbody.lower())
    }
    for _, _, _, bdois, barx in bib_items:
        if (r_dois & bdois) or (r_arxiv & barx):
            return True
    rn = norm_math_text(rbody)
    m_auth = re.search(r"(?<![A-Z])\.\s+(?=[A-Z0-9“\"𝐿𝑈])", rbody)
    tr_auth_raw = rbody[: m_auth.start()] if m_auth else rbody[:60]
    tr_rest = norm_math_text(rbody[m_auth.end() :]) if m_auth else rn
    first_tokens = norm_math_text(re.split(r",\s+|\s+and\s+", tr_auth_raw)[0]).split()
    first_surn = first_tokens[-1] if first_tokens else ""
    for _, ba, bt, bdois, barx in bib_items:
        if (r_dois and bdois and not (r_dois & bdois)) or (r_arxiv and barx and not (r_arxiv & barx)):
            continue
        if not first_surn or first_surn not in ba.split():
            continue
        if ("2 to 2" in rn and "2 to 1" in bt) or ("2 to 1" in rn and "2 to 2" in bt):
            continue
        if bt and len(bt) >= 7 and (tr_rest.startswith(bt) or bt.startswith(tr_rest[: max(20, len(bt))])):
            return True
        bt_words = [w for w in bt.split() if len(w) >= 3]
        if len(bt_words) >= 4:
            head_w = [w for w in tr_rest.split() if len(w) >= 3][: len(bt_words) + 2]
            if sum(1 for w in bt_words if w in head_w) / len(bt_words) >= 0.85:
                return True
    return False


def verify_forensic_ten_traces_and_citations() -> dict:
    """Live audit of all 10 extracted trace .txt files and 332 trace-to-paper citation links."""
    bib_by_fam = _load_bib_snapshot()
    per_trace = {}
    tot_pages, tot_lines, tot_prompts = 0, 0, 0
    tot_tr_refs, tot_ret, tot_drop, tot_bib = 0, 0, 0, 0
    zero_prompt_fams, openai_self_cites_dropped = [], 0

    for tf in sorted((OAI_REF / "traces_txt").glob("*.txt")):
        fid = tf.name.split("_", 1)[0]
        raw = tf.read_text(encoding="utf-8")
        pages = len(re.findall(r"^=== \[PAGE \d+/\d+\] ===$", raw, re.M))
        lines = len(raw.splitlines())
        prompts = len(re.findall(r"(?m)^Original prompt(?:\s*\([^)]*\))?\s*$", raw))
        if prompts == 0:
            zero_prompt_fams.append(fid)
        ref_sec = re.sub(r"\n*=== \[PAGE \d+/\d+\] ===\n+[^\n]+\n+\d+\n+", "\n", raw.split("\nReferences\n")[-1])
        chunks = re.split(r"\n\[(\d+)\]\s+", "\n" + ref_sec)
        ret_cnt, drop_cnt = 0, 0
        for idx in range(1, len(chunks), 2):
            rb = chunks[idx + 1]
            for _ in range(3):
                rb = re.sub(r"(https?://[^\s]+)\n([^\s]+)", r"\1\2", rb)
                rb = re.sub(r"(10\.\d{4,9}/[^\s]+)\n([^\s]+)", r"\1\2", rb)
            rbody = re.sub(r"\s+", " ", rb).strip()
            is_ret = _match_single_trace_ref(rbody, bib_by_fam[fid])
            if rbody.startswith("OpenAI.") and not is_ret:
                openai_self_cites_dropped += 1
            ret_cnt += int(is_ret)
            drop_cnt += int(not is_ret)
        bib_cnt = len(bib_by_fam[fid])
        per_trace[fid] = {
            "pages": pages, "lines": lines, "prompts": prompts,
            "trace_refs": ret_cnt + drop_cnt, "retained": ret_cnt, "dropped": drop_cnt, "paper_bib": bib_cnt,
        }
        tot_pages += pages
        tot_lines += lines
        tot_prompts += prompts
        tot_tr_refs += ret_cnt + drop_cnt
        tot_ret += ret_cnt
        tot_drop += drop_cnt
        tot_bib += bib_cnt

    drop_frac = Fraction(tot_drop, tot_tr_refs)
    assert tot_pages == 202 and tot_lines == 9308 and tot_prompts == 13
    assert zero_prompt_fams == ["017", "287"]
    assert tot_tr_refs == 332 and tot_ret == 102 and tot_drop == 230 and tot_bib == 315
    assert drop_frac == Fraction(115, 166) and openai_self_cites_dropped == 3

    return {
        "total_traces": len(per_trace),
        "total_pages": tot_pages,
        "total_extracted_lines": tot_lines,
        "total_prompt_blocks": tot_prompts,
        "zero_prompt_families": zero_prompt_fams,
        "total_trace_refs": tot_tr_refs,
        "retained_trace_refs": tot_ret,
        "dropped_trace_refs": tot_drop,
        "drop_fraction_exact": f"{drop_frac.numerator}/{drop_frac.denominator}",
        "primary_paper_bib_total": tot_bib,
        "posthoc_added_bib_min": tot_bib - tot_ret,
        "citation_union_total": tot_tr_refs + tot_bib - tot_ret,
        "openai_2026_self_cites_dropped": openai_self_cites_dropped,
        "per_trace": per_trace,
    }


def verify_forensic_lean_challenges_and_oai_refs() -> dict:
    """Live audit of 21 ComparatorChallenges, 4 OAI modules, 10 lean_docs, and upstream_corpus_snapshot.tsv."""
    ch_files = sorted((OAI_REF / "challenges").glob("*.lean"))
    ch_lines = sum(len(p.read_text(encoding="utf-8").splitlines()) for p in ch_files)
    doc_files = sorted((OAI_REF / "lean_docs").glob("*.md"))
    doc_lines = sum(len(p.read_text(encoding="utf-8").splitlines()) for p in doc_files)
    min_uncut_lines = (OAI_REF / "challenges" / "MinUncut.lean").read_text(encoding="utf-8").splitlines()
    masked_blank_lines = sum(1 for ln in min_uncut_lines if ln.strip() == "" and len(ln) > 0)
    masked_bytes = sum(len(ln) for ln in min_uncut_lines if ln.strip() == "" and len(ln) > 0)

    bce_lines = (OAI_REF / "oai_modules" / "BinaryCorrectedElliott.lean").read_text(encoding="utf-8").splitlines()
    open_cnt = sum(1 for ln in bce_lines[5:32] if ln.strip().startswith("open "))
    mt_repeats = sum(1 for ln in bce_lines[5:32] if ln.strip().startswith("open ") and "MeasureTheory" in ln)

    doc_087 = (OAI_REF / "lean_docs" / "087.md").read_text(encoding="utf-8")
    gen_mahler = (OAI_REF / "challenges" / "GeneralMahler.lean").read_text(encoding="utf-8")
    doc_087_contradiction = ("nonsymmetric Mahler conjecture" in doc_087 and "not included" in doc_087) and (
        "theorem general_mahler" in gen_mahler and "general Mahler conjecture" in doc_087
    )

    bce_src = (OAI_REF / "oai_modules" / "BinaryCorrectedElliott.lean").read_text(encoding="utf-8")
    mt_src = (OAI_REF / "oai_modules" / "MainTheorem.lean").read_text(encoding="utf-8")
    cls_src = (OAI_REF / "oai_modules" / "Classification.lean").read_text(encoding="utf-8")
    stub_binders_used_in_oai = all([
        re.search(r"\bhNP\b", bce_src.split(":=", 1)[1]),
        re.search(r"\bhK\b", mt_src.split(":=", 1)[1]),
        re.search(r"\bhK\b", cls_src.split("theorem symmetric_mahler_equality", 1)[1].split(":=", 1)[1]),
    ])

    snap_lines = (OAI_REF / "traces_txt" / "upstream_corpus_snapshot.tsv").read_text(encoding="utf-8").splitlines()
    m_head = re.search(r"total_families=(\d+)", snap_lines[0])
    tot_families = int(m_head.group(1)) if m_head else 0
    snap_rows = {}
    for ln in snap_lines[2:]:
        if ln.strip():
            cols = ln.split("\t")
            snap_rows[cols[0]] = [int(x) for x in cols[1:]]
    tot_row = snap_rows["TOTAL"]

    assert len(ch_files) == 21 and ch_lines == 1949
    assert len(doc_files) == 10 and doc_lines == 211
    assert masked_blank_lines == 22 and masked_bytes == 1401
    assert len(bce_lines) == 56 and open_cnt == 27 and mt_repeats == 7
    assert doc_087_contradiction and stub_binders_used_in_oai
    assert tot_families == 373 and tot_row == [202, 9308, 22, 11, 21, 9929, 2170, 73733]
    assert snap_rows["159"][7] == 15551 and snap_rows["159"][5] == 4774 and snap_rows["159"][6] == 1537

    return {
        "upstream_total_families": tot_families,
        "challenge_file_count": len(ch_files),
        "challenge_total_lines": ch_lines,
        "lean_docs_file_count": len(doc_files),
        "lean_docs_total_lines": doc_lines,
        "family_manuscripts_total": tot_row[2],
        "family_traced_manuscripts": tot_row[3],
        "oai_lean_files_total": tot_row[5],
        "oai_unused_hyps_total": tot_row[6],
        "ap159_preprint_tex_lines": snap_rows["159"][7],
        "minuncut_masked_blank_lines": masked_blank_lines,
        "minuncut_masked_space_bytes": masked_bytes,
        "binary_elliott_lines": len(bce_lines),
        "binary_elliott_open_lines": open_cnt,
        "binary_elliott_measure_theory_repeats": mt_repeats,
        "doc_087_nonsym_contradiction": doc_087_contradiction,
        "oai_proof_term_uses_hNP_and_hK": stub_binders_used_in_oai,
    }


def verify_symbolic_ten_trace_mathematics() -> dict:
    """Exact SymPy rational & polynomial verification of mathematical invariants across the 10 traces."""
    a_sym, b_sym, s_sym, m_sym = sp.symbols("A B s m", real=True)

    # #017 Flint-Hills dyadic exponent 2*mu - 5 at mu = 62/25 vs 5/2, Zeilberger-Zudilin [23] benchmark, and box barrier
    pi_txt = (OAI_REF / "traces_txt" / "017_irrationality-exponent-of-pi.txt").read_text(encoding="utf-8")
    m_zz = re.search(r"Zeilberger and Wadim Zudilin.*?at most (7\.\d+)", pi_txt)
    assert m_zz is not None
    zz_scaled_1e4 = int(Fraction(m_zz.group(1)[:6]) * 10000)
    mu_part1 = sp.Rational(62, 25)
    part1_scaled_1e4 = int(mu_part1 * 10000)
    part2_scaled_1e4 = 2 * 10000
    fh_exp = 2 * mu_part1 - 5
    box_mu_sq_excess = sp.Rational(5, 4) - 1  # 1/a - 1 > 0 => 1 + 1/sqrt(a) > 2

    # #087 dimension-3 symmetric cube 4^3 / 3! vs general simplex (3+1)^4 / (3!)^2
    mahler_cube_3 = sp.Rational(4**3, sp.factorial(3))
    mahler_simplex_3 = sp.Rational(4**4, sp.factorial(3) ** 2)
    cube_3_scaled_36 = int(mahler_cube_3 * 36)
    simplex_3_scaled_36 = int(mahler_simplex_3 * 36)

    # #102 sparse projection beta = k^(-2/3) at k = m^3, beta = m^(-2)
    ug_col = sp.simplify(m_sym**3 * (m_sym ** (-2)) ** 2)
    ug_deg = sp.simplify(m_sym**3 * (m_sym ** (-2)))

    # #197 planar Van Kampen Euler upper bound B <= E/3, W <= (E+1)/2, F <= (E+6)/6 vs E + 2
    e_sym = sp.Symbol("E", real=True)
    euler_defect = sp.simplify((e_sym + 2) - (e_sym / 3 + (e_sym + 1) / 2 + (e_sym + 6) / 6))

    # #221 quartic cavity convexity SOS identity (p = 4): 3 B^4 + A^4 - 4 A B^3
    quartic_diff = sp.expand(a_sym**4 + 3 * b_sym**4 - 4 * a_sym * b_sym**3)
    quartic_sos = sp.expand((a_sym - b_sym) ** 2 * ((a_sym + b_sym) ** 2 + 2 * b_sym**2))

    # #271 infrared shell [s, 2s]: int_s^(2s) w^2 dw / (7 s^2 / 12) = 4 s < 5 s = beta_0
    w_sym = sp.Symbol("w", positive=True)
    heis_mom = sp.integrate(w_sym**2, (w_sym, s_sym, 2 * s_sym))
    heis_ratio = sp.simplify(heis_mom / (sp.Rational(7, 12) * s_sym**2))

    # #287 Dykema-Radulescu compression 1 + (r - 1)/t^2 at r = 3, t = sqrt(2) -> 2
    dr_target = sp.simplify(1 + (sp.Integer(3) - 1) / (sp.sqrt(2) ** 2))

    # #362 Vlasov-Maxwell Glassey-Strauss bootstrap gap 0.496 - 0.410 = 43/500
    vm_gap = sp.Rational(496, 1000) - sp.Rational(410, 1000)

    assert zz_scaled_1e4 == 71032 and part1_scaled_1e4 == 24800 and part2_scaled_1e4 == 20000
    assert fh_exp == sp.Rational(-1, 25) and box_mu_sq_excess == sp.Rational(1, 4)
    assert mahler_cube_3 - mahler_simplex_3 == sp.Rational(32, 9)
    assert cube_3_scaled_36 == 384 and simplex_3_scaled_36 == 256
    assert ug_col == 1 / m_sym and ug_deg == m_sym
    assert euler_defect == sp.Rational(1, 2)
    assert quartic_diff == quartic_sos
    assert heis_ratio == 4 * s_sym and dr_target == 2 and vm_gap == sp.Rational(43, 500)

    return {
        "pi017_zz_benchmark_scaled_1e4": zz_scaled_1e4,
        "pi017_part1_scaled_1e4": part1_scaled_1e4,
        "pi017_part2_scaled_1e4": part2_scaled_1e4,
        "pi017_drop1_scaled_1e4": zz_scaled_1e4 - part1_scaled_1e4,
        "pi017_drop2_scaled_1e4": part1_scaled_1e4 - part2_scaled_1e4,
        "pi017_flint_hills_exponent": str(fh_exp),
        "mahler087_dim3_cube_scaled_36": cube_3_scaled_36,
        "mahler087_dim3_simplex_scaled_36": simplex_3_scaled_36,
        "mahler087_dim3_cube_minus_simplex": str(mahler_cube_3 - mahler_simplex_3),
        "ug102_collision_and_degree": [str(ug_col), str(ug_deg)],
        "kaplansky197_euler_gap": str(euler_defect),
        "mezard221_quartic_sos_verified": quartic_diff == quartic_sos,
        "heisenberg271_infrared_ratio": str(heis_ratio),
        "freegroup287_sqrt2_compression_rank": int(dr_target),
        "vlasov362_bootstrap_gap_exact": str(vm_gap),
    }


def main() -> None:
    payload = {
        "case_id": "014_openai_reasoning_traces_ten",
        "compiler_forensics": verify_forensic_compiler_template(),
        "trace_and_citation_audit": verify_forensic_ten_traces_and_citations(),
        "lean_and_scope_audit": verify_forensic_lean_challenges_and_oai_refs(),
        "symbolic_math_invariants": verify_symbolic_ten_trace_mathematics(),
    }
    out_path = PROOFS_DIR / "symbolic_verification_result.json"
    out_path.write_text(json.dumps(payload, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    print(f"[PASS] Wrote deterministic verification ledger -> {out_path.name}")


if __name__ == "__main__":
    main()
