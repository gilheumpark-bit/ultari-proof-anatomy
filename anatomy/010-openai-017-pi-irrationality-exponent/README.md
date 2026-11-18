# OpenAI #017 (The irrationality exponent of π is 2) - Forensic Anatomy & Formal Verification

- Language: English | [Korean (README.ko.md)](./README.ko.md) | Main Index: [ultari-proof-anatomy](../../README.md)

This forensic anatomy provides a complete mathematical and formal-verification dissection of OpenAI's flagship number-theory family #017 (The irrationality exponent of π is 2, September 24, 2026, `openai/math` commit `4eaee87`) across its 5 LaTeX manuscript files (1,591 lines + references.bib 269 lines), its 869 Lean 4 files (94,948 lines in OAI/NumberTheory/PiExponent/), and its 42-page (45-section) reasoning trace (irrationality-exponent-of-pi.pdf), backed by 75 standalone Mathlib 4 algebraic and analytic Lean 4 theorems (1,646 lines, 0 sorry, 0 custom axioms, 120/120 hypothesis mutations caught, 44 nonlinear/inductive proofs, and dual-witness verification).

## 1. Six-Tier Documentation Index (en/ & ko/)

| Tier | English Document (en/) | Core Scope |
| :---: | :--- | :--- |
| Tier 1 | [en/01_Executive_Summary_and_General_Guide.md](en/01_Executive_Summary_and_General_Guide.md) | The 5 core causal questions (62/25 -> 2 pivot, $b \in (1/2, 1-1/\nu)$, Liouville obstruction, 017.md vs Main.lean Class C unclaimed discovery, 3-tier LCM constant stratigraphy & 4 discrete-algebraic substitutions) |
| Tier 2 | [en/02_Intermediate_Math_and_Code_Guide.md](en/02_Intermediate_Math_and_Code_Guide.md) | Sections 2–5 mathematical pipeline, 75-theorem Mathlib 4 mapping (thm_01–thm_75), and numerical witnesses |
| Tier 3 | [en/03_Expert_Forensic_and_Mathematical_Physics_Report.md](en/03_Expert_Forensic_and_Mathematical_Physics_Report.md) | 869-file stratigraphy, 60 oai_ref links, 25 BibTeX DOI & non-input `math.GM` (`Carella2022` & `withdrawn v2`) selection asymmetry audit, 9-line `PiExponent.lean` spec check, and 6 uncited classical pillars |
| Tier 4 | [en/04_Automated_Verification_and_Parser_Spec.md](en/04_Automated_Verification_and_Parser_Spec.md) | Cryptographic SHA-256 table and one-click reproduction commands |
| Tier 5 | [Detailed Forensic Referee Report (en/05)](en/05_Detailed_Forensic_Referee_Report_Pi017.md) | 7-part 5-Gate forensic referee report (Part 0–Part 7: 16/23 (69.6%) trace citation drop vs. 3/25 non-input `math.GM` notes, Class C unclaimed `Main.flint_hills_summable` vs. `017.md:11`, 4 adaptations, kernel pass vs. pending peer review, and TIER C verdict) |
| Tier 6 | [Basic Audit Report (en/06)](en/06_Basic_Audit_Report_Pi017.md) | Basic Audit Summary (TIER C): 8-metric TL;DR scorecard, verified physical findings, 6-question FAQ, and 10-second terminal reproduction |

## 2. Verification Artifacts (proofs/)

- [proofs/pi_simplex_parameters_and_stratigraphy.lean](proofs/pi_simplex_parameters_and_stratigraphy.lean#L1-L509) (Theorems 1–25, 509 lines, 28/28 mutations caught, nonlin: 8)
- [proofs/pi_transverse_multiplicity_and_seshadri_blowup.lean](proofs/pi_transverse_multiplicity_and_seshadri_blowup.lean#L1-L586) (Theorems 26–50, 586 lines, 46/46 mutations caught, nonlin: 18)
- [proofs/pi_laurent_determinant_and_flint_hills.lean](proofs/pi_laurent_determinant_and_flint_hills.lean#L1-L551) (Theorems 51–75, 551 lines, 46/46 mutations caught, nonlin: 18)
- [proofs/verify_symbolic_pi017.py](proofs/verify_symbolic_pi017.py#L1-L534) $\to$ [proofs/symbolic_verification_result.json](proofs/symbolic_verification_result.json#L1-L612)
- [proofs/problem_spec.md](proofs/problem_spec.md#L1-L18) & [manifest.json](manifest.json#L1-L523)

## 3. One-Command Verification

Run the deterministic verifier from this case directory to check SHA-256 hashes, Lean 4 compilation, SymPy reproduction, `#L` links, and all hypothesis mutations (auto-resolves `Mathlib 4` via `.lake/` or `LEAN_PATH`):

```bash
python3 ../../tools/verify_all.py --root .
```
