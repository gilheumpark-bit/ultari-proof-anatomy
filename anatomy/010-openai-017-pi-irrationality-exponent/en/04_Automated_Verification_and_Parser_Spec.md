# [Case 010 / Tier 4 Automated Verification & Parser Spec] OpenAI `#017` (`The irrationality exponent of π is 2`) SHA-256 Integrity & Reproduction Protocol

> **Target Audience**: Automated verification pipelines (`tools/verify_all.py`, `extra_scan.py`) and reproducibility auditors
> **Parent Index**: [English Main README (`README.md`)](../README.md) | [Executive Summary (`en/01_`)](01_Executive_Summary_and_General_Guide.md) | [Intermediate Guide (`en/02_`)](02_Intermediate_Math_and_Code_Guide.md) | [Expert Forensic Report (`en/03_`)](03_Expert_Forensic_and_Mathematical_Physics_Report.md)

---

## 1. Cryptographic SHA-256 Checksum Table (`proofs/`)

| Artifact Path (`proofs/...`) | SHA-256 Checksum | Role & Verification Gate |
| :--- | :--- | :--- |
| [`proofs/pi_simplex_parameters_and_stratigraphy.lean`](../proofs/pi_simplex_parameters_and_stratigraphy.lean) | `bd5585443f184e1bbf515ee20994d67c76860ee8d99f9018df5be5346339b284` | `Theorems 1–10` (`869`-file stratigraphy, `62/25 -> 2` pivot, `Lemma 4.1` algebra, `75/75` mutations caught) |
| [`proofs/pi_transverse_multiplicity_and_seshadri_blowup.lean`](../proofs/pi_transverse_multiplicity_and_seshadri_blowup.lean) | `94d45723b803e4017865a8401cc8f431a615198c9cd76c75377a71fd130ca67b` | `Theorems 11–20` (`Lemma 2.2` inscribed rectangle vs simplex, Euclidean sandwich, Seshadri blowup, `57/57` mutations caught) |
| [`proofs/pi_laurent_determinant_and_flint_hills.lean`](../proofs/pi_laurent_determinant_and_flint_hills.lean) | `a2617aa7e7f5b49fee4f8b940572ad4981f9aba5d03ae7aca16b8c68dfc1a86e` | `Theorems 21–30` (Gaussian integer clearing, row translation, Cauchy-Schwarz collision, Flint-Hills, `50/50` mutations caught) |
| [`proofs/verify_symbolic_pi017.py`](../proofs/verify_symbolic_pi017.py) | `72695d4a14e5f525ebb9de9dc554b5117d018814fb4426c74010b85f32c8c64e` | Deterministic symbolic/numerical verifier (reproduces `symbolic_verification_result.json` byte-for-byte) |
| [`proofs/symbolic_verification_result.json`](../proofs/symbolic_verification_result.json) | `6e151a8a57b65d0462619e9ec218d325a353a83c2f4dcce7edcf258d2c5b7124` | Exact `Lemma 4.1` witnesses, simplex-vs-rectangle ratios, Flint-Hills partial sums & citation audit JSON |
| [`proofs/problem_spec.md`](../proofs/problem_spec.md) | `18797175209f97641bf4393521304ea71cf12c743eb84977a66a2c925171d145` | Problem specification, 5 causal `Why`s, and `30`-theorem architecture summary |

---

## 2. Deterministic One-Click Verification Commands

```bash
# 1. Verify SHA-256 checksums
sha256sum -c proofs/checksums.sha256

# 2. Run Lean 4 kernel check (v4.29.0-rc8, 0 sorry, 30 theorems)
~/.elan/bin/lean proofs/pi_simplex_parameters_and_stratigraphy.lean
~/.elan/bin/lean proofs/pi_transverse_multiplicity_and_seshadri_blowup.lean
~/.elan/bin/lean proofs/pi_laurent_determinant_and_flint_hills.lean

# 3. Reproduce symbolic/numerical solver output
python3 -B proofs/verify_symbolic_pi017.py

# 4. Run full Ultari verification gate (182/182 mutations + Elab MetaM DoF 30/30 + oai_ref 100% + RH13~RH43)
python3 -B ../../tools/verify_all.py --root .
```
