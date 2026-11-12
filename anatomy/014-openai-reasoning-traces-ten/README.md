# Case 014: OpenAI `10` Publicly Released Reasoning Traces (`reasoning_traces/` Full-Corpus Forensic Anatomy & Formal Verification Package)

> **한국어 안내**: [README.ko.md](README.ko.md) | **Parent Repository**: [`ultari-proof-anatomy`](../../README.md)

This case (`014-openai-reasoning-traces-ten`) performs a complete primary-source forensic anatomy across **all `10` publicly released reasoning logs (`reasoning_traces/*.pdf`, `202` pages, `9,308` extracted lines)** in OpenAI's official `openai/math` repository (`HEAD` `4eaee87548250b2682affda7d05d947c05554bae`, covering `10 / 373 = 2.68%` of problem families: `#007`, `#017`, `#087`, `#102`, `#159`, `#197`, `#221`, `#271`, `#287`, `#362`), cross-audited against their **`22` family manuscripts** (`11` traced primary manuscripts + `11` untraced sibling manuscripts; `18` formalized in Lean and `4` sibling papers in `#197` & `#271` unformalized), **`10` `lean/docs/*.md` scope files (`211` lines)**, **`21` `ComparatorChallenges/*.lean` files (`1,949` lines)**, and **`9,929` `OAI/` Lean 4 files**, independently verified via **`75` standalone Lean 4 (`v4.29.0-rc8`) theorems** (`1,337` lines, `0 sorry`, `346/346` hypothesis mutations caught = `100%`, `74/75` structural, `19` nonlinear/inductive proofs, dual-witness model checks).

---

## 1. Four-Tier Documentation Index (`en/` & `ko/`)

| Tier | English Guide (`en/`) | Korean Guide (`ko/`) | Core Scope |
| :---: | :--- | :--- | :--- |
| **Tier 1** | [`en/01_Executive_Summary_and_General_Guide.md`](en/01_Executive_Summary_and_General_Guide.md) | [`ko/01_일반인용_해설서.md`](ko/01_일반인용_해설서.md) | Five Core Questions (`Q1-Q5`): retained post-hoc LuaLaTeX trace compiler (`reasoning_traces/mezard-parisi-formula.tex`, unused `"自由"` CJK fallback in `\QuoteGlyphSetup` & `#102` macros), `69.28%` (`230/332`) trace citation attrition & `100%` (`3/3`) companion self-citation drop vs `213` post-hoc additions, multi-part prompt stitching (`#017`, `#287`, `#087`), `22 -> 11 -> 9 -> 7` scope funnel, and `OAI/` `2,170`-vacuous-binder audit |
| **Tier 2** | [`en/02_Intermediate_Math_and_Code_Guide.md`](en/02_Intermediate_Math_and_Code_Guide.md) | [`ko/02_중급자용_수학및코드가이드.md`](ko/02_중급자용_수학및코드가이드.md) | Three-pillar domain mathematical invariants vs corpus conservation theorems across all `10` families (`#007`..`#362`), complete `75`-theorem mapping (`thm_01`..`thm_75`), and live symbolic/forensic verifier walkthrough |
| **Tier 3** | [`en/03_Expert_Forensic_and_Mathematical_Physics_Report.md`](en/03_Expert_Forensic_and_Mathematical_Physics_Report.md) | [`ko/03_전문가용_학술및수리물리보고서.md`](ko/03_전문가용_학술및수리물리보고서.md) | Complete 10-trace referee audit: `211`-line `mezard-parisi-formula.tex` compiler stratigraphy (`L68`, `L76-L79`), `332`-vs-`315` bidirectional citation ledger (`Jaccard 102/545 = 18.72%`) with counter-hypothesis tests, `29/29` `oai_ref/` `#L` index, ten-domain mathematical invariants, three-stage scope funnel, and the `5/5` challenge-stub false-positive vs `2,170` internal `OAI/` vacuous-hypothesis No-Go theorem |
| **Tier 4** | [`en/04_Automated_Verification_and_Parser_Spec.md`](en/04_Automated_Verification_and_Parser_Spec.md) | [`ko/04_자동검증및파서용_명세서.md`](ko/04_자동검증및파서용_명세서.md) | Cryptographic SHA-256 checksum ledger and deterministic one-click reproduction commands |

---

## 2. Verification Artifacts (`proofs/`)

- [`proofs/traces10_compiler_and_citation_drop.lean`](proofs/traces10_compiler_and_citation_drop.lean#L1-L403) (`Theorems 1-25`, `403` lines, `132/132` mutations caught, `nonlin: 3`)
- [`proofs/traces10_algebraic_combinatorial_engines.lean`](proofs/traces10_algebraic_combinatorial_engines.lean#L1-L469) (`Theorems 26-50`, `469` lines, `99/99` mutations caught, `nonlin: 8`)
- [`proofs/traces10_analytic_operator_and_scope_audit.lean`](proofs/traces10_analytic_operator_and_scope_audit.lean#L1-L465) (`Theorems 51-75`, `465` lines, `115/115` mutations caught, `nonlin: 8`)
- [`proofs/verify_symbolic_traces10.py`](proofs/verify_symbolic_traces10.py#L1-L341) $\to$ [`proofs/symbolic_verification_result.json`](proofs/symbolic_verification_result.json)
- [`proofs/problem_spec.md`](proofs/problem_spec.md) & [`manifest.json`](manifest.json)
