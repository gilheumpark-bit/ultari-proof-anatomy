# Case 010: OpenAI `#017` (`The irrationality exponent of π is 2`) — Forensic Anatomy & Formal Verification

> **한국어 안내서**: [README.ko.md](README.ko.md) | **Parent Repository**: [`ultari-proof-anatomy`](../../README.md)

This case (`010-openai-017-pi-irrationality-exponent`) provides a complete mathematical and formal-verification anatomy of OpenAI's flagship number-theory family **`#017` (`The irrationality exponent of π is 2`, September 24, 2026)** across its `5` LaTeX manuscript files (`1,591` lines + `references.bib` `269` lines), its `869` Lean 4 files (`94,948` lines in `OAI/NumberTheory/PiExponent/`), and its `42`-page (`45`-section) reasoning trace (`irrationality-exponent-of-pi.pdf`), backed by `75` standalone machine-checked Lean 4 theorems (`1,446` lines, `0 sorry`, `315/315` hypothesis mutations caught, `39` nonlinear/inductive proofs, `4` universal `∀ k : Nat` inductions, and dual-witness verification).

---

## 1. Four-Tier Documentation Index (`en/` & `ko/`)

| Tier | English Document (`en/`) | Korean Document (`ko/`) | Core Scope |
| :---: | :--- | :--- | :--- |
| **Tier 1** | [`en/01_Executive_Summary_and_General_Guide.md`](en/01_Executive_Summary_and_General_Guide.md) | [`ko/01_일반인용_해설서.md`](ko/01_일반인용_해설서.md) | The 5 core causal questions (`62/25 -> 2` pivot, $b \in (1/2, 1-1/\nu)$, Liouville obstruction, `017.md` vs `Main.lean` scope audit, 4 discrete-algebraic substitutions) |
| **Tier 2** | [`en/02_Intermediate_Math_and_Code_Guide.md`](en/02_Intermediate_Math_and_Code_Guide.md) | [`ko/02_중급자용_구조및수식가이드.md`](ko/02_중급자용_구조및수식가이드.md) | `Sections 2–5` mathematical pipeline, `75`-theorem mapping (`thm_01`–`thm_75`), and numerical witnesses |
| **Tier 3** | [`en/03_Expert_Forensic_and_Mathematical_Physics_Report.md`](en/03_Expert_Forensic_and_Mathematical_Physics_Report.md) | [`ko/03_전문가용_수리물리및형식증명심사보고서.md`](ko/03_전문가용_수리물리및형식증명심사보고서.md) | `869`-file stratigraphy, `60` `oai_ref` links, `25` BibTeX DOI checks, and 6 uncited classical pillars |
| **Tier 4** | [`en/04_Automated_Verification_and_Parser_Spec.md`](en/04_Automated_Verification_and_Parser_Spec.md) | [`ko/04_자동검증및파서용_명세서.md`](ko/04_자동검증및파서용_명세서.md) | Cryptographic SHA-256 table and one-click reproduction commands |

---

## 2. Verification Artifacts (`proofs/`)

- [`proofs/pi_simplex_parameters_and_stratigraphy.lean`](proofs/pi_simplex_parameters_and_stratigraphy.lean#L1-L447) (`Theorems 1–25`, `447` lines, `126/126` mutations caught, `nonlin: 13`)
- [`proofs/pi_transverse_multiplicity_and_seshadri_blowup.lean`](proofs/pi_transverse_multiplicity_and_seshadri_blowup.lean#L1-L434) (`Theorems 26–50`, `434` lines, `107/107` mutations caught, `nonlin: 10`)
- [`proofs/pi_laurent_determinant_and_flint_hills.lean`](proofs/pi_laurent_determinant_and_flint_hills.lean#L1-L565) (`Theorems 51–75`, `565` lines, `82/82` mutations caught, `nonlin: 16`)
- [`proofs/verify_symbolic_pi017.py`](proofs/verify_symbolic_pi017.py#L1-L351) $\to$ [`proofs/symbolic_verification_result.json`](proofs/symbolic_verification_result.json#L1-L555)
- [`proofs/problem_spec.md`](proofs/problem_spec.md#L1-L18) & [`manifest.json`](manifest.json#L1-L508)
