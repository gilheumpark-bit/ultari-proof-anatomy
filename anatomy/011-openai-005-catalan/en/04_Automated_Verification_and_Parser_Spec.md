# Tier 4 Automated Verification & Parser Spec: OpenAI #005 (Catalan's constant is irrational) SHA-256 Integrity & Reproduction Protocol

- Target Audience: Automated verification pipelines (tools/verify_all.py) and reproducibility auditors
- Parent Index: [English Main README (README.md)](../README.md) | [Executive Summary (en/01_)](01_Executive_Summary_and_General_Guide.md) | [Intermediate Guide (en/02_)](02_Intermediate_Math_and_Code_Guide.md) | [Expert Forensic Report (en/03_)](03_Expert_Forensic_and_Mathematical_Physics_Report.md)



## 1. Cryptographic SHA-256 Checksum Table (`proofs/`)

| Artifact Path (`proofs/...`) | SHA-256 Checksum | Role & Verification Gate |
| :--- | :--- | :--- |
| [proofs/catalan_rows_two_adic_and_odd_primes.lean](../proofs/catalan_rows_two_adic_and_odd_primes.lean) | `194cfca5ed0b19bab3582fc453906b4904d46b5a5a3818813082fe9be590b918` | Theorems 1–25 (446 lines: Chebyshev-Laurent row hierarchy, $\zeta(2)$ contact cancellation, 2-adic quadratic completion, 8-piece odd-prime integral 8609/2, repaired OddLowerPairPool & FixedCompactRowsAll, 144/144 mutations caught) |
| [proofs/catalan_palindromic_frobenius_and_modular.lean](../proofs/catalan_palindromic_frobenius_and_modular.lean) | `c4d28ebdd6a9102acd0496b7467a817a60d98bc41898093ca5b3114c24930354` | Theorems 26–50 (454 lines: palindromic bases $U_l, Q_i$, transition determinants $\det U = 2^{p(p-1)/2}$ and $\det \mathbf{a} = 2^{-p(p-1)/2}$, shifted reflection $\Pi$ block factorization, Frobenius row/column shifts, $v_p(\Delta_p) = -96p$, 981-file stratigraphy, mod-101 certificate & 13 duplicate / 9 binder repairs, 153/153 mutations caught) |
| [proofs/catalan_real_place_energy_and_contradiction.lean](../proofs/catalan_real_place_energy_and_contradiction.lean) | `77b4a4c45c9daecb1764434bd1e20741a6cc40a112fb59eb661fab2ad2bb2432` | Theorems 51–75 (436 lines: two-sheeted Riemann surface jump 6, scale-48 real-place log field $E_\kappa$, Haagerup-Chebyshev square completion, derivative degrees (36,24,13,9) & 43+7=50-point Descartes certificate < -2.290939875, and global irrationality contradiction, 135/135 mutations caught) |
| [proofs/verify_symbolic_catalan005.py](../proofs/verify_symbolic_catalan005.py) | `b555a159da0e934d8c9a3673094ee61acbed535406db50dedcb652ed02958aa0` | Deterministic symbolic/numerical verifier (495 lines; parses oai_ref/ directly and reproduces symbolic_verification_result.json byte-for-byte) |
| [proofs/symbolic_verification_result.json](../proofs/symbolic_verification_result.json) | `fb873e26faf086f35f9af70fd07190fed9b68d0e71551c289cb3542a4b559935` | Exact 2-adic quadratic minimum -2809/4608, 8-piece odd-prime integral 8609/2, 48×48 mod-101 right-inverse / Table 1 certificates (27, 50, 74), 50-point Descartes bracket bound -2.290939875, and stratigraphy ratios (226 lines) |
| [proofs/problem_spec.md](../proofs/problem_spec.md) | `f4bc9f251f2fcf0dd2239fbd55bb83986b68c2b21d2dc598295ac26b69619039` | Zero-hint problem specification and 3-pillar subsystem target scope (19 lines) |



## 2. Deterministic One-Click Verification Commands

```bash
# 1. Verify SHA-256 checksums
sha256sum -c proofs/checksums.sha256

# 2. Run Lean 4 kernel check (0 sorry, 75 theorems across 1,336 lines)
lean proofs/catalan_rows_two_adic_and_odd_primes.lean
lean proofs/catalan_palindromic_frobenius_and_modular.lean
lean proofs/catalan_real_place_energy_and_contradiction.lean

# 3. Reproduce symbolic/numerical solver output
python3 -B proofs/verify_symbolic_catalan005.py

# 4. Run full OPFF verification gate (432/432 mutations + Elab MetaM DoF 51/75 + nonlin 15 + oai_ref 58/58 100% [59 total with references.bib])
python3 -B ../../tools/verify_all.py --root .
```
