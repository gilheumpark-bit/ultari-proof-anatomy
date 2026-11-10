# [Case 011 / Tier 4 Automated Verification & Parser Spec] OpenAI `#005` (`Catalan's constant is irrational`) SHA-256 Integrity & Reproduction Protocol

> **Target Audience**: Automated verification pipelines (`tools/verify_all.py`, `extra_scan.py`) and reproducibility auditors
> **Parent Index**: [English Main README (`README.md`)](../README.md) | [Executive Summary (`en/01_`)](01_Executive_Summary_and_General_Guide.md) | [Intermediate Guide (`en/02_`)](02_Intermediate_Math_and_Code_Guide.md) | [Expert Forensic Report (`en/03_`)](03_Expert_Forensic_and_Mathematical_Physics_Report.md)

---

## 1. Cryptographic SHA-256 Checksum Table (`proofs/`)

| Artifact Path (`proofs/...`) | SHA-256 Checksum | Role & Verification Gate |
| :--- | :--- | :--- |
| [`proofs/catalan_rows_two_adic_and_odd_primes.lean`](../proofs/catalan_rows_two_adic_and_odd_primes.lean) | `fb088455c9ac422485c62f96e40351be40d57156651d360a53902b784a0f49b7` | `Theorems 1–25` (`439` lines: Chebyshev-Laurent row hierarchy, $\zeta(2)$ contact cancellation, 2-adic quadratic completion, 8-piece odd-prime integral `8609/2`, repaired `OddLowerPairPool` & `FixedCompactRowsAll`, `144/144` mutations caught) |
| [`proofs/catalan_palindromic_frobenius_and_modular.lean`](../proofs/catalan_palindromic_frobenius_and_modular.lean) | `82b57ec2cd3360fea4dbdf6a372c4fee4fff7cca375b9e6096b741c5ef3c7a41` | `Theorems 26–50` (`443` lines: palindromic bases $U_l, Q_i$, transition determinant $2^{-p(p-1)/2}$, shifted reflection $\Pi$ block factorization, Frobenius row/column shifts, $v_p(\Delta_p) = -96p$, `981`-file stratigraphy, mod-`101` certificate & `13` duplicate / `9` binder repairs, `153/153` mutations caught) |
| [`proofs/catalan_real_place_energy_and_contradiction.lean`](../proofs/catalan_real_place_energy_and_contradiction.lean) | `4bf9a97bd02be92904aaf99528d1bb98bf2f80294cdcd64ff05a3e6b0980cc67` | `Theorems 51–75` (`431` lines: two-sheeted Riemann surface jump `6`, scale-`48` real-place log field $E_\kappa$, Haagerup-Chebyshev square completion, derivative degrees `(36,24,13,9)` & `43+7=50`-point Descartes certificate `< -2.290939875`, and global irrationality contradiction, `135/135` mutations caught) |
| [`proofs/verify_symbolic_catalan005.py`](../proofs/verify_symbolic_catalan005.py) | `b12dce5f3b4b3cf2437a24f5bbb457df654637acfbd457d89aa3ece63053ba76` | Deterministic symbolic/numerical verifier (`631` lines; parses `oai_ref/` directly and reproduces `symbolic_verification_result.json` byte-for-byte) |
| [`proofs/symbolic_verification_result.json`](../proofs/symbolic_verification_result.json) | `fb873e26faf086f35f9af70fd07190fed9b68d0e71551c289cb3542a4b559935` | Exact 2-adic quadratic minimum `-2809/4608`, 8-piece odd-prime integral `8609/2`, `48×48` mod-`101` Gaussian elimination certificate (`27, 50, 74`), `50`-point Descartes bracket bound `-2.290939875`, and stratigraphy ratios (`226` lines) |
| [`proofs/problem_spec.md`](../proofs/problem_spec.md) | `c8a6d68226f844b4581809354bdc4402d912d2c60d708d4b8ceb93499ec72289` | Zero-hint (`RH28`) problem specification and 3-pillar subsystem target scope (`19` lines) |

---

## 2. Deterministic One-Click Verification Commands

```bash
# 1. Verify SHA-256 checksums
sha256sum -c proofs/checksums.sha256

# 2. Run Lean 4 kernel check (0 sorry, 75 theorems across 1,313 lines)
~/.elan/bin/lean proofs/catalan_rows_two_adic_and_odd_primes.lean
~/.elan/bin/lean proofs/catalan_palindromic_frobenius_and_modular.lean
~/.elan/bin/lean proofs/catalan_real_place_energy_and_contradiction.lean

# 3. Reproduce symbolic/numerical solver output
python3 -B proofs/verify_symbolic_catalan005.py

# 4. Run full Ultari verification gate (432/432 mutations + Elab MetaM DoF 51/75 + nonlin 12 + oai_ref 57/57 100%)
python3 -B ../../tools/verify_all.py --root .
```
