# Case 011: OpenAI `#005` (`Catalan's constant is irrational`) — Forensic Anatomy & Formal Verification

> **한국어 안내서**: [README.ko.md](README.ko.md) | **Parent Repository**: [`ultari-proof-anatomy`](../../README.md)

This case (`011-openai-005-catalan`) provides a complete mathematical and formal-verification anatomy of OpenAI's flagship number-theory family **`#005` (`Catalan's constant is irrational`, September 24, 2026)** across all `9` LaTeX manuscript files (`3,001` lines + `references.bib` `319` lines) and all `981` Lean 4 files (`573,816` lines in `OAI/NumberTheory/Catalan/`, `982` files / `573,829` lines including `ComparatorChallenges/Catalan.lean`), backed by `75` standalone machine-checked Lean 4 theorems (`1,313` lines, `0 sorry`, `432/432` hypothesis mutations caught, `69/75` structural, `12` nonlinear/inductive proofs, `6` universal `∀ k : Nat` inductions, and `RH31` dual-witness verification).

---

## 1. Four-Tier Documentation Index (`en/` & `ko/`)

| Tier | English Document (`en/`) | Korean Document (`ko/`) | Core Scope |
| :---: | :--- | :--- | :--- |
| **Tier 1** | [`en/01_Executive_Summary_and_General_Guide.md`](en/01_Executive_Summary_and_General_Guide.md) | [`ko/01_일반인용_해설서.md`](ko/01_일반인용_해설서.md) | The 5 causal `Why`s ($\zeta(2)$ Taylor-contact cancellation, $-2.29084$ finite-place bound, palindromic Frobenius block factorization & mod-`101` certificate, `508/981 (51.8%)` unreachable `Manuscript*` ledger, and two-sheeted real-place energy & `50`-point Descartes certificate $< -2.290939875$) |
| **Tier 2** | [`en/02_Intermediate_Math_and_Code_Guide.md`](en/02_Intermediate_Math_and_Code_Guide.md) | [`ko/02_중급자용_수학및코드가이드.md`](ko/02_중급자용_수학및코드가이드.md) | `Sections 2–8` mathematical pipeline, `75`-theorem mapping (`thm_01`–`thm_75`), and symbolic solver verification |
| **Tier 3** | [`en/03_Expert_Forensic_and_Mathematical_Physics_Report.md`](en/03_Expert_Forensic_and_Mathematical_Physics_Report.md) | [`ko/03_전문가용_학술및수리물리보고서.md`](ko/03_전문가용_학술및수리물리보고서.md) | `981`-file stratigraphy (`473` active vs `508` unreachable + `7` `ZetaFive` + `14` Terence Tao `PrimeNumberTheoremAnd` `.patch`), `58/58` `oai_ref/` `.tex`/`.lean`/`.patch` `#L` links (`59` total files with `references.bib`), `13` duplicate namespace collisions, `10` active-tree hypothesis/filter defects + `((n N)!)^2 >= 1` prefactor discard, and `28/28` `.bib` citation stratigraphy |
| **Tier 4** | [`en/04_Automated_Verification_and_Parser_Spec.md`](en/04_Automated_Verification_and_Parser_Spec.md) | [`ko/04_자동검증및파서용_명세서.md`](ko/04_자동검증및파서용_명세서.md) | Cryptographic SHA-256 table and one-click reproduction commands |

---

## 2. Verification Artifacts (`proofs/`)

- [`proofs/catalan_rows_two_adic_and_odd_primes.lean`](proofs/catalan_rows_two_adic_and_odd_primes.lean#L1-L439) (`Theorems 1–25`, `439` lines, `144/144` mutations caught, `nonlin: 5`)
- [`proofs/catalan_palindromic_frobenius_and_modular.lean`](proofs/catalan_palindromic_frobenius_and_modular.lean#L1-L443) (`Theorems 26–50`, `443` lines, `153/153` mutations caught, `nonlin: 5`)
- [`proofs/catalan_real_place_energy_and_contradiction.lean`](proofs/catalan_real_place_energy_and_contradiction.lean#L1-L431) (`Theorems 51–75`, `431` lines, `135/135` mutations caught, `nonlin: 2`)
- [`proofs/verify_symbolic_catalan005.py`](proofs/verify_symbolic_catalan005.py#L1-L631) $\to$ [`proofs/symbolic_verification_result.json`](proofs/symbolic_verification_result.json#L1-L226)
- [`proofs/problem_spec.md`](proofs/problem_spec.md#L1-L19) & [`manifest.json`](manifest.json#L1-L524)
