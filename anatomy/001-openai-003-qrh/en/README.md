> **Language**: **English** | [**한국어 (`README.ko.md`)**](../README.ko.md)

# Case 001: OpenAI `#003` Quasi-Riemann Hypothesis ($\text{Re}(s) > 7/8$)

This package audits the `3,414` Lean 4 files of OpenAI `#003` (`lean/OAI/NumberTheory/DirichletL/` and `SiegelZeros/`, including a 1-to-1 declaration-level audit of all `26/26` core reference files and `178/178` declarations). We recover the exact algebraic roots behind its rational proxies and verify `48` standalone Lean 4 theorems (`v4.29.0-rc8`, `0 sorry`, `47/47` hypothesis mutations caught). This analysis examines the rational constants, algebraic roots, and inequality margins inside the Lean formalization and does not alter or dispute the paper's main theorems.

## Key Findings

1. **Exact Stationary Point**: We recover the quadratic root $a^* = \frac{323}{276} - \frac{35\sqrt{16354}}{9384} \approx 0.6933$ behind the rational proxy $\frac{283}{408}$ in `DirichletL/Endpoint.lean`, along with the floor root $a_{\max} = \frac{37}{72}$ (`DirichletL/Detector/CentralExponent.lean`, `DirichletL/PrimeRows/CubeFloorSaving.lean`).
2. **Gram Exponent Slack**: Across `DirichletL/Detector/LowSourceScales.lean`, `DirichletL/Detector/GramScaleLoss.lean`, `DirichletL/Detector/GramBound.lean`, and `DirichletL/Detector/LowGramScale.lean`, we separate the componentwise exponent ($\frac{14+17\delta}{96}$, gap $\frac{215}{3264}$) and bilinear exponent ($\frac{1}{16}+\frac{17\delta}{96}$, gap $\frac{487}{3264}$) from the bundled upper bound ($\frac{3}{16}+\frac{23\delta}{96}$).
3. **Branch Vanishing & Threshold Reduction**: We prove that 6 of 8 non-principal Gauss branches in `DirichletL/Detector/HighRowsTail.lean` vanish for $m \ge 2$ ($z_{\text{re}} \ge \frac{1}{6} \to \frac{1}{12}$), and that $(1 - V)$ cancellation in `DirichletL/Detector/Local.lean` lowers the prime-norm cutoff from $Q \ge 480$ to $Q \ge 112$.

## 4-Tier Reader Guide

| Tier | Target Audience | Document | Summary |
| :---: | :--- | :--- | :--- |
| **Tier 1** | **Beginners** | [`01_Beginner_Guide.md`](./01_Beginner_Guide.md) | Plain-language guide to the Quasi-Riemann Hypothesis and the three thresholds (`0.51`, `0.69`, `0.875`). |
| **Tier 2** | **Intermediates** | [`02_Intermediate_Math_and_Code_Guide.md`](./02_Intermediate_Math_and_Code_Guide.md) | Core algebraic equations and a 1-to-1 index of all 48 Lean 4 theorems and 26 reference files. |
| **Tier 3** | **Experts** | [`03_Expert_Mathematical_and_Formal_Report.md`](./03_Expert_Mathematical_and_Formal_Report.md) | Technical report on the stationary point, Gram exponent slack, and `178/178` declaration-level audit ledger. |
| **Tier 4** | **Automated Verifiers** | [`04_Automated_Verification_and_Manifest.md`](./04_Automated_Verification_and_Manifest.md)<br>[`manifest.json`](../manifest.json) | Verification commands, SHA-256 checksums, and machine-readable theorem manifest. |

## Formal Proofs & One-Command Verification

- [`proofs/qrh_exponent_and_parameter_bounds.lean`](../proofs/qrh_exponent_and_parameter_bounds.lean): Theorems 1–27 (`0 sorry`, `36/36` mutations caught).
- [`proofs/qrh_continuation_and_rescaling.lean`](../proofs/qrh_continuation_and_rescaling.lean): Theorems 28–48 (`0 sorry`, `11/11` mutations caught).
- [`proofs/verify_symbolic_qrh.py`](../proofs/verify_symbolic_qrh.py): Deterministic SymPy verification script reproducing [`proofs/symbolic_verification_result.json`](../proofs/symbolic_verification_result.json).

```bash
lean proofs/qrh_exponent_and_parameter_bounds.lean && lean proofs/qrh_continuation_and_rescaling.lean && (cd proofs && python3 verify_symbolic_qrh.py)
```
