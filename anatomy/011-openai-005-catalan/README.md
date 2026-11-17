# OpenAI #005 (Catalan's constant is irrational): Forensic Anatomy & Formal Verification

- Language: English | [한국어 (README.ko.md)](./README.ko.md) | Main Index: [ultari-proof-anatomy](../../README.md)

- 한국어 안내서: [README.ko.md](README.ko.md) | Parent Repository: [ultari-proof-anatomy](../../README.md)

This forensic anatomy provides a complete mathematical and formal-verification analysis of OpenAI's flagship number-theory family #005 (Catalan's constant is irrational, September 24, 2026) across all 9 LaTeX manuscript files (3,001 lines + references.bib 319 lines) and all 981 Lean 4 files (573,816 lines in OAI/NumberTheory/Catalan/, 982 files / 573,829 lines including ComparatorChallenges/Catalan.lean), backed by 75 standalone machine-checked Lean 4 theorems (1,336 lines, 0 sorry, 0 axiom, 432/432 hypothesis mutations caught, 69/75 structural, 15 nonlinear/inductive proofs, 6 universal ∀ k : Nat inductions, and dual-witness verification).

## 1. Six-Tier Documentation Index (en/ & ko/)

| Tier | English Document (en/) | Korean Document (ko/) | Core Scope |
| :---: | :--- | :--- | :--- |
| Tier 1 | [en/01_Executive_Summary_and_General_Guide.md](en/01_Executive_Summary_and_General_Guide.md) | [ko/01_일반인용_해설서.md](ko/01_일반인용_해설서.md) | The 5 core causal questions ($\zeta(2)$ Taylor-contact cancellation, $-2.29084$ finite-place bound, palindromic Frobenius block factorization & mod-101 certificate, 508/981 (51.8%) unreachable `Manuscript*` ledger, and two-sheeted real-place energy & 50-point Descartes certificate $< -2.290939875$) |
| Tier 2 | [en/02_Intermediate_Math_and_Code_Guide.md](en/02_Intermediate_Math_and_Code_Guide.md) | [ko/02_중급자용_수학및코드가이드.md](ko/02_중급자용_수학및코드가이드.md) | Sections 2–8 mathematical pipeline, 75-theorem mapping (thm_01–thm_75), and symbolic solver verification |
| Tier 3 | [en/03_Expert_Forensic_and_Mathematical_Physics_Report.md](en/03_Expert_Forensic_and_Mathematical_Physics_Report.md) | [ko/03_전문가용_학술및수리물리보고서.md](ko/03_전문가용_학술및수리물리보고서.md) | 981-file stratigraphy (473 active vs 508 unreachable + 7 ZetaFive + 14 Terence Tao PrimeNumberTheoremAnd patch files), 58/58 oai_ref/ TeX/Lean/patch #L links (59 total files with references.bib), 13 duplicate namespace collisions, 10 active-tree hypothesis/filter defects + ((n N)!)^2 >= 1 prefactor discard, and 28/28 .bib citation stratigraphy |
| Tier 4 | [en/04_Automated_Verification_and_Parser_Spec.md](en/04_Automated_Verification_and_Parser_Spec.md) | [ko/04_자동검증및파서용_명세서.md](ko/04_자동검증및파서용_명세서.md) | Cryptographic SHA-256 table and one-click reproduction commands |
| Tier 5 | [en/05_OPFF_Detailed_Forensic_Referee_Report_PR80.md](en/05_OPFF_Detailed_Forensic_Referee_Report_PR80.md) | [ko/05_OPFF_상세형_포렌식심사보고서_PR80.md](ko/05_OPFF_상세형_포렌식심사보고서_PR80.md) | Standalone OPFF 5-Gate (Part 0–Part 7) forensic referee report (PR #80) & OPFF TIER F verdict |
| Tier 6 | [en/06_OPFF_Basic_Audit_Report_PR80.md](en/06_OPFF_Basic_Audit_Report_PR80.md) | [ko/06_OPFF_기본형_감사리포트_PR80.md](ko/06_OPFF_기본형_감사리포트_PR80.md) | Concise OPFF Basic Audit Summary (PR #80): TL;DR 8-metric scorecard, physical findings, 6-question FAQ & 10-second verification |

## 2. Verification Artifacts (proofs/)

- [proofs/catalan_rows_two_adic_and_odd_primes.lean](proofs/catalan_rows_two_adic_and_odd_primes.lean#L1-L446) (Theorems 1–25, 446 lines, 144/144 mutations caught, nonlin: 7)
- [proofs/catalan_palindromic_frobenius_and_modular.lean](proofs/catalan_palindromic_frobenius_and_modular.lean#L1-L454) (Theorems 26–50, 454 lines, 153/153 mutations caught, nonlin: 6)
- [proofs/catalan_real_place_energy_and_contradiction.lean](proofs/catalan_real_place_energy_and_contradiction.lean#L1-L436) (Theorems 51–75, 436 lines, 135/135 mutations caught, nonlin: 2)
- [proofs/verify_symbolic_catalan005.py](proofs/verify_symbolic_catalan005.py#L1-L495) $\to$ [proofs/symbolic_verification_result.json](proofs/symbolic_verification_result.json#L1-L226)
- [proofs/problem_spec.md](proofs/problem_spec.md#L1-L19) & [manifest.json](manifest.json)

## 3. One-Command Verification

Run the deterministic verifier from this case directory to check SHA-256 hashes, Lean 4 compilation, SymPy reproduction, `#L` links, and all hypothesis mutations:

```bash
python3 ../../tools/verify_all.py --root .
```
