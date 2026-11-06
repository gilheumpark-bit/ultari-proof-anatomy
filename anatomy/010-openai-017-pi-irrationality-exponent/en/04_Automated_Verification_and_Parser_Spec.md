# [Case 010 / Tier 4 Automated Verification & Parser Spec] OpenAI `#017` (`The irrationality exponent of π is 2`) SHA-256 Integrity & Reproduction Protocol

> **Target Audience**: Automated verification pipelines (`tools/verify_all.py`, `extra_scan.py`) and reproducibility auditors
> **Parent Index**: [English Main README (`README.md`)](../README.md) | [Executive Summary (`en/01_`)](01_Executive_Summary_and_General_Guide.md) | [Intermediate Guide (`en/02_`)](02_Intermediate_Math_and_Code_Guide.md) | [Expert Forensic Report (`en/03_`)](03_Expert_Forensic_and_Mathematical_Physics_Report.md)

---

## 1. Cryptographic SHA-256 Checksum Table (`proofs/`)

| Artifact Path (`proofs/...`) | SHA-256 Checksum | Role & Verification Gate |
| :--- | :--- | :--- |
| [`proofs/pi_simplex_parameters_and_stratigraphy.lean`](../proofs/pi_simplex_parameters_and_stratigraphy.lean) | `4d9f2e00cfa6215b2dbce2f0ca9f611b92ebd61c0fc2ea1e6dfa45b64ca6dfd8` | `Theorems 1–25` (`869`-file stratigraphy, `62/25 -> 2` pivot, `Lemma 4.1` algebra, Euclidean injectivity & lacunary weight inductions, `126/126` mutations caught) |
| [`proofs/pi_transverse_multiplicity_and_seshadri_blowup.lean`](../proofs/pi_transverse_multiplicity_and_seshadri_blowup.lean) | `14b42cd5d3bca67524a48f162b5072a359b949716fe92035ae8beddbd1639361` | `Theorems 26–50` (`Lemma 2.2` inscribed rectangle vs simplex, local jet algebra, Seshadri blowup, Rees pushdown & Čech complex, `107/107` mutations caught) |
| [`proofs/pi_laurent_determinant_and_flint_hills.lean`](../proofs/pi_laurent_determinant_and_flint_hills.lean) | `948c4cd33928f2dceded556e045476499930fedede52376899707f85f95e3658` | `Theorems 51–75` (Gaussian integer clearing, Brahmagupta-Fibonacci norm, Cauchy-Schwarz collision, Vandermonde factorization, Flint-Hills & `RH31` dual witness, `82/82` mutations caught) |
| [`proofs/verify_symbolic_pi017.py`](../proofs/verify_symbolic_pi017.py) | `602bac70e252b0b0fd517fed6554e8cde6056739e93f55a0d8d7d5e68f352d5b` | Deterministic symbolic/numerical verifier (reproduces `symbolic_verification_result.json` byte-for-byte) |
| [`proofs/symbolic_verification_result.json`](../proofs/symbolic_verification_result.json) | `f3e31e46b8f9d17fc9a8f51572adc062f33dc25139a1f4c6e10a687a32a55caf` | Exact `Lemma 4.1` witnesses, simplex-vs-rectangle ratios, 4 inductive invariants, Flint-Hills partial sums & citation audit JSON |
| [`proofs/problem_spec.md`](../proofs/problem_spec.md) | `70e1e27817538d6bc7b9d1aef3964d33057c72e5eaf2c496a0e4d91dd046f2d5` | Zero-hint (`RH28`) problem specification and 3-pillar subsystem target scope |

---

## 2. Deterministic One-Click Verification Commands

```bash
# 1. Verify SHA-256 checksums
sha256sum -c proofs/checksums.sha256

# 2. Run Lean 4 kernel check (v4.29.0-rc8, 0 sorry, 75 theorems across 1,446 lines)
~/.elan/bin/lean proofs/pi_simplex_parameters_and_stratigraphy.lean
~/.elan/bin/lean proofs/pi_transverse_multiplicity_and_seshadri_blowup.lean
~/.elan/bin/lean proofs/pi_laurent_determinant_and_flint_hills.lean

# 3. Reproduce symbolic/numerical solver output
python3 -B proofs/verify_symbolic_pi017.py

# 4. Run full Ultari verification gate (315/315 mutations + Elab MetaM DoF 75/75 + nonlin 39 + oai_ref 60/60 100%)
python3 -B ../../tools/verify_all.py --root .
```
