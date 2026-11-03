# OpenAI `#003` (Quasi-Riemann Hypothesis in Lean 4) Mathematical Analysis & Formal Proofs Package (English Edition)

- **Release Date**: 2026-10-31
- **Target Repository**: `openai/frontiermath-open-problems` (`FirstProof2026Problem3` / Dirichlet & Hecke $L$-Function Quasi-Riemann Hypothesis in Lean 4)
- **Primary Formal & Symbolic Artifacts**:
  - Formal Lean 4 Proofs (40 Theorems, 404+295 lines, `0 sorry`, `0 axiom`): `proofs/qrh_exponent_and_parameter_bounds.lean`, `proofs/qrh_continuation_and_rescaling.lean`
  - Symbolic Verification Script (`SymPy` / Exact Rational Arithmetic): `proofs/verify_symbolic_qrh.py`
  - Symbolic Verification Output Data (JSON): [`proofs/symbolic_verification_result.json`](../proofs/symbolic_verification_result.json)

---

## 4-Tier Reader Guide (Tailored by Background)

This package is structured into 4 self-contained tiers so that **Beginners**, **Intermediates**, **Experts**, and **Automated Verification Systems** can understand and verify the results.

| Tier | Target Audience | Document | Summary of Contents |
| :---: | :--- | :--- | :--- |
| **Tier 1** | **Beginners (General Readers)** | [`01_Beginner_Guide.md`](./01_Beginner_Guide.md) | Plain-language introduction to the Riemann & Quasi-Riemann Hypotheses, why `#003` uses rational approximations and upper-bound relaxations, and what the key thresholds (`0.51 / 0.69 / 0.875`) mean |
| **Tier 2** | **Intermediates (STEM / Engineers)** | [`02_Intermediate_Math_and_Code_Guide.md`](./02_Intermediate_Math_and_Code_Guide.md) | Step-by-step algebraic equations for Problems 1 to 5 and a complete 1-to-1 index of all 40 Lean 4 theorems against OpenAI's `.lean` files |
| **Tier 3** | **Experts (Number Theorists & Formal Verification Researchers)** | [`03_Expert_Mathematical_and_Formal_Report.md`](./03_Expert_Mathematical_and_Formal_Report.md) | Technical report covering the irrational stationary point, exact componentwise Gram exponent differences ($\frac{215}{3264}$ and $\frac{487}{3264}$), $m \ge 2$ Gauss branch vanishing, and the distinction between formalized rational/integer theorems and future complex-analytic extensions |
| **Tier 4** | **AI Parsers & Automated Verification** | [`04_Automated_Verification_and_Manifest.md`](./04_Automated_Verification_and_Manifest.md)<br>[`manifest.json`](../manifest.json) | One-command verification pipeline (`lean`, `python3`, `sha256sum`), SHA-256 hash list, scope notes, and JSON manifest |

---

## One-Command Verification

Run the following command from the package root directory to compile all 40 Lean 4 theorems (`exit 0`) and reproduce the symbolic verification JSON:

```bash
lean ../proofs/qrh_exponent_and_parameter_bounds.lean && (cd ../proofs && python3 verify_symbolic_qrh.py)
```
