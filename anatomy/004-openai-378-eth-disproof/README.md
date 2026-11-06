> **Language**: **English** | [**한국어 (`README.ko.md`)**](./README.ko.md)

# Case 004: OpenAI `#378` Disproof of the Exponential Time Hypothesis (`ETH`)

This package audits the `3,977` Lean 4 files (`710,320` lines) and `4` LaTeX manuscripts of OpenAI `#378` (`OAI.Algorithms.SubexponentialSAT`). All results are verified across `56` standalone Lean 4 theorems (`v4.29.0-rc8`, `0 sorry`, `454/454` hypothesis mutations caught).

## Key Findings

1. **4-Generation Fossil Archaeology**: Only `2,569` files are reachable from [`SqrtLogSpace/Final.lean`](proofs/oai_ref/lean/OAI/Algorithms/SubexponentialSAT/SqrtLogSpace/Final.lean#L1-L201), while `1,408` files (`35.4%`, `226,053` lines) are discarded fossils spanning `Gen 1` ($2^{0.9n}$) to `Gen 4`.
2. **5 Formalization Shortcuts Audited**: We dissect DFA truth-table embedding, the nonconstructive `sparsifySchedule = 0` cutoff ($n \le 2^{65,535}$), unary input padding, slack-constant inflation, and the char-3 (`Lean`) vs. char-0 (`LaTeX`) split.
3. **Appendix D & Fossil Hybrids**: We formalize Appendix D's $2$-adic Hermite decay ($1/32$) and combine discarded `Gen 2–3` fossils ([`SubexpParameters.lean`](proofs/oai_ref/lean/OAI/Algorithms/SubexponentialSAT/SubexpParameters.lean#L51-L115), [`ExponentArithmetic.lean`](proofs/oai_ref/lean/OAI/Algorithms/SubexponentialSAT/ExponentArithmetic.lean#L15-L48)) to compress the polynomial constant by $171,835\times$.

## 4-Tier Reader Guide

| Tier | Target Audience | Document | Summary |
| :---: | :--- | :--- | :--- |
| **Tier 1** | **Beginners** | [`01_Beginner_Guide.md`](en/01_Beginner_Guide.md) | Intuitive guide to the subexponential SAT algorithm, the 4 fossil generations, and the 6-layer repair verdict. |
| **Tier 2** | **Intermediates** | [`02_Intermediate_Math_and_Code_Guide.md`](en/02_Intermediate_Math_and_Code_Guide.md) | 6-step algebraic recalculation and a 1-to-1 index of all 56 Lean 4 theorems. |
| **Tier 3** | **Experts** | [`03_Expert_Complexity_and_Formal_Report.md`](en/03_Expert_Complexity_and_Formal_Report.md) | Full referee report covering the `1,408` fossil files, 5 shortcuts, Appendix D, and Galois-ring solver. |
| **Tier 4** | **Automated Verifiers** | [`04_Automated_Verification_and_Manifest.md`](en/04_Automated_Verification_and_Manifest.md)<br>[`manifest.json`](manifest.json) | SHA-256 checksum table, mutation test logs, and reproduction commands. |

## Formal Proofs & One-Command Verification

- [`eth_subexp_interpolation_and_hashes.lean`](proofs/eth_subexp_interpolation_and_hashes.lean): Theorems 1–16 (`128/128` mutations caught).
- [`eth_tensor_contraction_and_circuits.lean`](proofs/eth_tensor_contraction_and_circuits.lean): Theorems 17–32 (`177/177` mutations caught).
- [`eth_five_repairs_and_four_layer_verdict.lean`](proofs/eth_five_repairs_and_four_layer_verdict.lean): Theorems 33–56 (`149/149` mutations caught).
- [`verify_symbolic_eth.py`](proofs/verify_symbolic_eth.py), [`symbolic_verification_result.json`](proofs/symbolic_verification_result.json), and [`problem_spec.md`](proofs/problem_spec.md).

```bash
lean proofs/eth_subexp_interpolation_and_hashes.lean && lean proofs/eth_tensor_contraction_and_circuits.lean && lean proofs/eth_five_repairs_and_four_layer_verdict.lean && (cd proofs && python3 verify_symbolic_eth.py)
```
