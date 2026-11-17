# Tier 4 Automated Verification & Parser Spec: OpenAI #017 (The irrationality exponent of π is 2) SHA-256 Integrity & Reproduction Protocol

- Target Audience: Automated verification pipelines (tools/verify_all.py) and reproducibility auditors
- Parent Index: [English Main README (README.md)](../README.md) | [Executive Summary (en/01_)](01_Executive_Summary_and_General_Guide.md) | [Intermediate Guide (en/02_)](02_Intermediate_Math_and_Code_Guide.md) | [Expert Forensic Report (en/03_)](03_Expert_Forensic_and_Mathematical_Physics_Report.md)



## 1. Cryptographic SHA-256 Checksum Table (`proofs/`)

| Artifact Path (`proofs/...`) | SHA-256 Checksum | Role & Verification Gate |
| :--- | :--- | :--- |
| [proofs/pi_simplex_parameters_and_stratigraphy.lean](../proofs/pi_simplex_parameters_and_stratigraphy.lean) | `fa4c73cf1acb7f311a5dae2018c521b69cb2eeb031b65880034e2ecc6362ca1d` | Theorems 1–25 (509 lines: 869-file stratigraphy, 62/25 -> 2 pivot, Lemma 4.1 real/rational algebra, Finset weighted simplex Euclidean sandwich, sSup squeeze, 28/28 mutations caught) |
| [proofs/pi_transverse_multiplicity_and_seshadri_blowup.lean](../proofs/pi_transverse_multiplicity_and_seshadri_blowup.lean) | `2e7c8c2e726ce1180002dc3a2f0f84d37fb1bc8a28c88d83aa567bb12d828313` | Theorems 26–50 (586 lines: Lemma 2.2 inscribed box vs descending-factorial simplex, LaurentSeries.derivative residue rigidity, coprime polynomial log-derivative obstruction, Seshadri blowup, Rees pushdown & Čech complex, 46/46 mutations caught) |
| [proofs/pi_laurent_determinant_and_flint_hills.lean](../proofs/pi_laurent_determinant_and_flint_hills.lean) | `3795672a078f1f74760c2ec9f7723d2ba4915f963b916008cf4e26ffc599d8b9` | Theorems 51–75 (551 lines: GaussianInt matrix clearing, 3-tier LCM stratigraphy log 4 + 4 vs 4 log 2, Cauchy-Schwarz occupancy variance, Matrix.vandermonde factorization, irrational_pi Flint-Hills & dual witness, 46/46 mutations caught) |
| [proofs/verify_symbolic_pi017.py](../proofs/verify_symbolic_pi017.py) | `602809c6314c4c89e605e2a6544e993e2860a4707b34eb4144511490ce01ff4d` | Deterministic symbolic/numerical verifier (534 lines: live-scans 60 oai_ref/ files and 3 .lean modules, reproduces symbolic_verification_result.json byte-for-byte) |
| [proofs/symbolic_verification_result.json](../proofs/symbolic_verification_result.json) | `01470abe37f8962dd8b5e9fe2331d0c3184993848ae371f3d4fd65859bda73a1` | Exact Lemma 4.1 witnesses, simplex-vs-rectangle ratios, 3-tier LCM stratigraphy, Flint-Hills partial sums & citation audit JSON (612 lines) |
| [proofs/problem_spec.md](../proofs/problem_spec.md) | `c8fc826774b0272c90538518cb41e08c54cda8df94a76b7b32ee3b25abf6cb25` | Self-contained problem specification and 3-pillar subsystem target scope (18 lines) |



## 2. Deterministic One-Click Verification Commands

```bash
# 1. Verify SHA-256 checksums
sha256sum -c proofs/checksums.sha256

# 2. Run Lean 4 kernel check (v4.29.0-rc8 + Mathlib 4, 0 sorry, 75 theorems across 1,646 lines)
lean proofs/pi_simplex_parameters_and_stratigraphy.lean
lean proofs/pi_transverse_multiplicity_and_seshadri_blowup.lean
lean proofs/pi_laurent_determinant_and_flint_hills.lean

# 3. Reproduce symbolic/numerical solver output
python3 -B proofs/verify_symbolic_pi017.py

# 4. Run full OPFF automated verification gate (120/120 mutations + Elab MetaM DoF 75/75 + nonlin 44 + oai_ref 60/60 100%)
python3 -B ../../tools/verify_all.py --root .
```
