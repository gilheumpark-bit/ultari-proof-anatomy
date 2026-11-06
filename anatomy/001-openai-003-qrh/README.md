> **Language**: **English** | [**한국어 (`README.ko.md`)**](./README.ko.md)

# Case 001: OpenAI `#003` Quasi-Riemann Hypothesis ($	ext{Re}(s) > 7/8$)

This package audits the `3,414` Lean 4 files of OpenAI `#003` (`DirichletL/` and `SiegelZeros/`). We recover the exact algebraic roots behind its rational proxies and verify `40` standalone Lean 4 theorems (`v4.29.0-rc8`, `0 sorry`, `22/22` hypothesis mutations caught).

## Key Findings

1. **Exact Stationary Point**: We recover the quadratic root $a^* = rac{323}{276} - rac{35\sqrt{16354}}{9384} pprox 0.6933$ behind the rational proxy $rac{283}{408}$ in `Endpoint.lean`, along with the floor root $a_{\max} = rac{37}{72}$.
2. **Gram Exponent Slack**: We separate the componentwise exponent ($rac{14+17\delta}{96}$, gap $rac{215}{3264}$) and bilinear exponent ($rac{1}{16}+rac{17\delta}{96}$, gap $rac{487}{3264}$) from the bundled upper bound ($rac{3}{16}+rac{23\delta}{96}$).
3. **Branch Vanishing & Threshold Reduction**: We prove that 6 of 8 non-principal Gauss branches vanish for $m \ge 2$ ($z_{	ext{re}} \ge rac{1}{6} 	o rac{1}{12}$), and that $(1 - V)$ cancellation lowers the prime-norm cutoff from $Q \ge 480$ to $Q \ge 112$.

## 4-Tier Reader Guide

| Tier | Target Audience | Document | Summary |
| :---: | :--- | :--- | :--- |
| **Tier 1** | **Beginners** | [`01_Beginner_Guide.md`](./en/01_Beginner_Guide.md) | Plain-language guide to the Quasi-Riemann Hypothesis and the three thresholds (`0.51`, `0.69`, `0.875`). |
| **Tier 2** | **Intermediates** | [`02_Intermediate_Math_and_Code_Guide.md`](./en/02_Intermediate_Math_and_Code_Guide.md) | Core algebraic equations and a 1-to-1 index of all 40 Lean 4 theorems. |
| **Tier 3** | **Experts** | [`03_Expert_Mathematical_and_Formal_Report.md`](./en/03_Expert_Mathematical_and_Formal_Report.md) | Technical report on the stationary point, Gram exponent slack, and `Category A` arithmetic scope. |
| **Tier 4** | **Automated Verifiers** | [`04_Automated_Verification_and_Manifest.md`](./en/04_Automated_Verification_and_Manifest.md)<br>[`manifest.json`](./manifest.json) | Verification commands, SHA-256 checksums, and machine-readable theorem manifest. |

## Formal Proofs & One-Command Verification

- [`proofs/qrh_exponent_and_parameter_bounds.lean`](./proofs/qrh_exponent_and_parameter_bounds.lean): Theorems 1–27 (`0 sorry`).
- [`proofs/qrh_continuation_and_rescaling.lean`](./proofs/qrh_continuation_and_rescaling.lean): Theorems 28–40 (`0 sorry`).
- [`proofs/verify_symbolic_qrh.py`](./proofs/verify_symbolic_qrh.py): Deterministic SymPy verification script reproducing [`proofs/symbolic_verification_result.json`](./proofs/symbolic_verification_result.json).

```bash
lean proofs/qrh_exponent_and_parameter_bounds.lean && lean proofs/qrh_continuation_and_rescaling.lean && (cd proofs && python3 verify_symbolic_qrh.py)
```
