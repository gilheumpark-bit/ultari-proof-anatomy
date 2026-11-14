# [Case 010 / Tier 4 Automated Verification & Parser Spec] OpenAI `#017` (`The irrationality exponent of π is 2`) SHA-256 Integrity & Reproduction Protocol

> **Target Audience**: Automated verification pipelines (`tools/verify_all.py`) and reproducibility auditors
> **Parent Index**: [English Main README (`README.md`)](../README.md) | [Executive Summary (`en/01_`)](01_Executive_Summary_and_General_Guide.md) | [Intermediate Guide (`en/02_`)](02_Intermediate_Math_and_Code_Guide.md) | [Expert Forensic Report (`en/03_`)](03_Expert_Forensic_and_Mathematical_Physics_Report.md)

---

## 1. Cryptographic SHA-256 Checksum Table (`proofs/`)

| Artifact Path (`proofs/...`) | SHA-256 Checksum | Role & Verification Gate |
| :--- | :--- | :--- |
| [`proofs/pi_simplex_parameters_and_stratigraphy.lean`](../proofs/pi_simplex_parameters_and_stratigraphy.lean) | `b53f4c754771710f92d0b355516914d3aa5305263f2971d554b2a32a4e6779c3` | `Theorems 1–25` (`509` lines: `869`-file stratigraphy, `62/25 -> 2` pivot, `Lemma 4.1` real/rational algebra, `Finset` weighted simplex Euclidean sandwich, `sSup` squeeze, `28/28` mutations caught) |
| [`proofs/pi_transverse_multiplicity_and_seshadri_blowup.lean`](../proofs/pi_transverse_multiplicity_and_seshadri_blowup.lean) | `5c215fc726921ac6fbc7d9fdf97b6ff057eac982f2fbd7e5cacbe19950fcc3ba` | `Theorems 26–50` (`586` lines: `Lemma 2.2` inscribed box vs descending-factorial simplex, `LaurentSeries.derivative` residue rigidity, coprime polynomial log-derivative obstruction, Seshadri blowup, Rees pushdown & Čech complex, `46/46` mutations caught) |
| [`proofs/pi_laurent_determinant_and_flint_hills.lean`](../proofs/pi_laurent_determinant_and_flint_hills.lean) | `517c79e6ac21f03193f1746ef4542128433199308b7f719c016bde95459aa902` | `Theorems 51–75` (`551` lines: `GaussianInt` matrix clearing, 3-tier LCM stratigraphy `log 4 + 4` vs `4 log 2`, Cauchy-Schwarz occupancy variance, `Matrix.vandermonde` factorization, `irrational_pi` Flint-Hills & dual witness, `46/46` mutations caught) |
| [`proofs/verify_symbolic_pi017.py`](../proofs/verify_symbolic_pi017.py) | `86860a82755dc12927c1f6734b555838103a7321d5e8ce0426d82ca410e8c6d7` | Deterministic symbolic/numerical verifier (`534` lines: live-scans `60` `oai_ref/` files and 3 `.lean` modules, reproduces `symbolic_verification_result.json` byte-for-byte) |
| [`proofs/symbolic_verification_result.json`](../proofs/symbolic_verification_result.json) | `01470abe37f8962dd8b5e9fe2331d0c3184993848ae371f3d4fd65859bda73a1` | Exact `Lemma 4.1` witnesses, simplex-vs-rectangle ratios, 3-tier LCM stratigraphy, Flint-Hills partial sums & citation audit JSON (`612` lines) |
| [`proofs/problem_spec.md`](../proofs/problem_spec.md) | `70e1e27817538d6bc7b9d1aef3964d33057c72e5eaf2c496a0e4d91dd046f2d5` | Self-contained problem specification and 3-pillar subsystem target scope (`18` lines) |

---

## 2. Deterministic One-Click Verification Commands

```bash
# 1. Verify SHA-256 checksums
sha256sum -c proofs/checksums.sha256

# 2. Run Lean 4 kernel check (v4.29.0-rc8 + Mathlib 4, 0 sorry, 75 theorems across 1,646 lines)
~/.elan/bin/lean proofs/pi_simplex_parameters_and_stratigraphy.lean
~/.elan/bin/lean proofs/pi_transverse_multiplicity_and_seshadri_blowup.lean
~/.elan/bin/lean proofs/pi_laurent_determinant_and_flint_hills.lean

# 3. Reproduce symbolic/numerical solver output
python3 -B proofs/verify_symbolic_pi017.py

# 4. Run full Ultari verification gate (120/120 mutations + Elab MetaM DoF 75/75 + nonlin 44 + oai_ref 60/60 100%)
python3 -B ../../tools/verify_all.py --root .
```
