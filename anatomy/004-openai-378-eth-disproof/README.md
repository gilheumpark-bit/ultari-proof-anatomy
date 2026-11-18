# OpenAI #378 Disproof of the Exponential Time Hypothesis (ETH)

- Language: English | [Korean (README.ko.md)](./README.ko.md) | Main Index: [ultari-proof-anatomy](../../README.md)

This study audits the 3,977 Lean 4 files (710,320 lines at upstream `openai/math` commit `4eaee87`, of which 42 key `.lean` modules are archived in `proofs/oai_ref/` and 3,935 upstream `.lean` files lie outside the snapshot) and 4 LaTeX manuscripts of OpenAI #378 (OAI.Algorithms.SubexponentialSAT). All results are verified across 56 standalone Lean 4 theorems (v4.29.0-rc8, 0 sorry, 454/454 hypothesis mutations caught).

## Key Findings

1. 4-Generation Stratigraphy of Unimported Prior-Generation Modules: Only 2,569 files are reachable from [SqrtLogSpace/Final.lean](proofs/oai_ref/lean/OAI/Algorithms/SubexponentialSAT/SqrtLogSpace/Final.lean#L1-L201), while 1,408 files (35.4%, 226,053 lines) are unimported prior-generation modules spanning Gen 1 ($2^{0.9n}$) to Gen 4.
2. 5 Formal Specification Boundary Choices Audited (Class A / Gate 5 vs. Class B Gaps; TIER F on Comparator Spec Conformance): We separate self-disclosed Class A design choices and standard Mathlib 4 proof idioms (Gate 5) from actual Class B specification gaps. Specifically, [lean/docs/378.md:9-11](proofs/oai_ref/lean/docs/378.md#L9-L11) explicitly discloses the canonical input encoding and Engine I scope, [FiniteFallback.lean:276-277](proofs/oai_ref/lean/OAI/Algorithms/SubexponentialSAT/SqrtLogSpace/FiniteFallback.lean#L276-L277) explicitly documents its fixed finite transition table (Class A, contrasting unimported Gen 1 [FixedParameters.lean:568-808](proofs/oai_ref/lean/OAI/Algorithms/SubexponentialSAT/FixedParameters.lean#L568-L808) with active Gen 4 [FiniteFallback.lean:258-299](proofs/oai_ref/lean/OAI/Algorithms/SubexponentialSAT/SqrtLogSpace/FiniteFallback.lean#L258-L299)), and `Filter.atTop` cutoffs ([NativeLargeEntry.lean:48-61](proofs/oai_ref/lean/OAI/Algorithms/SubexponentialSAT/SqrtLogSpace/NativeLargeEntry.lean#L48-L61), $n > 2^{65,535}$ for `>= 1` and $n > 2^{209,951}$ for `>= 2`) plus `omega` slack-constant padding reflect standard Mathlib 4 tactics (Gate 5). The remaining Class B gaps isolate cleanly to: (i) internal [Final.lean:104-148](proofs/oai_ref/lean/OAI/Algorithms/SubexponentialSAT/SqrtLogSpace/Final.lean#L104-L148) (`exact_count_eth`, $n + F.\mathrm{card} + 1$) vs. external [SubexponentialSAT.lean:216](proofs/oai_ref/lean/ComparatorChallenges/SubexponentialSAT.lean#L216) ($L$-only `visitedSpace` forcing unary `encodeNat`, $L \ge n$), and (ii) the non-uniform finite transition table below $n < 2^{33,554,431}$. Asymptotic ETH ($n \to \infty$) is preserved, while the public comparator spec requires revision (`TIER F` on comparator spec conformance).
3. Appendix D Formalization, Classical Literature Audit & Prior-Generation Hybrid Bounds: We formalize Appendix D.4's $2$-adic Hermite decay ($1/32$), audit the 1,552 uncited core proof lines (Sections 3–4: 409 + 774 lines; Appendix D.1–D.3 [quantitative-reduction.tex](proofs/oai_ref/tex/quantitative-reduction.tex#L1-L369): 369 lines), and recombine unimported Gen 2–3 prior-generation modules ([SubexpParameters.lean](proofs/oai_ref/lean/OAI/Algorithms/SubexponentialSAT/SubexpParameters.lean#L51-L115), [IdempotentTernary.lean](proofs/oai_ref/lean/OAI/Algorithms/SubexponentialSAT/SqrtLog/IdempotentTernary.lean#L15-L67)) to compress the exponent constant by $171,835\times$.

## 4-Tier Reader Guide

| Tier | Target Audience | Document | Summary |
| :---: | :--- | :--- | :--- |
| Tier 1 | Beginners | [01_Beginner_Guide.md](en/01_Beginner_Guide.md) | Intuitive guide to the subexponential SAT algorithm, the 4 generations of modules, and the 6-layer repair verdict. |
| Tier 2 | Intermediates | [02_Intermediate_Math_and_Code_Guide.md](en/02_Intermediate_Math_and_Code_Guide.md) | 6-step algebraic recalculation and a 1-to-1 index of all 56 Lean 4 theorems. |
| Tier 3 | Experts | [03_Expert_Complexity_and_Formal_Report.md](en/03_Expert_Complexity_and_Formal_Report.md) | Full referee report covering the 1,408 unimported prior-generation modules, 5 formal specification boundary choices, Appendix D, and Galois-ring solver. |
| Tier 4 | Automated Verifiers | [04_Automated_Verification_and_Manifest.md](en/04_Automated_Verification_and_Manifest.md) & [manifest.json](manifest.json) | SHA-256 checksum table, mutation test logs, and reproduction commands. |

## Formal Proofs & One-Command Verification

- [eth_subexp_interpolation_and_hashes.lean](proofs/eth_subexp_interpolation_and_hashes.lean): Theorems 1–16 (128/128 mutations caught).
- [eth_tensor_contraction_and_circuits.lean](proofs/eth_tensor_contraction_and_circuits.lean): Theorems 17–32 (177/177 mutations caught).
- [eth_five_repairs_and_four_layer_verdict.lean](proofs/eth_five_repairs_and_four_layer_verdict.lean): Theorems 33–56 (149/149 mutations caught).
- [verify_symbolic_eth.py](proofs/verify_symbolic_eth.py), [symbolic_verification_result.json](proofs/symbolic_verification_result.json), and [problem_spec.md](proofs/problem_spec.md).

```bash
python3 ../../tools/verify_all.py --root .
lean proofs/eth_subexp_interpolation_and_hashes.lean && lean proofs/eth_tensor_contraction_and_circuits.lean && lean proofs/eth_five_repairs_and_four_layer_verdict.lean && (cd proofs && python3 verify_symbolic_eth.py)
```
