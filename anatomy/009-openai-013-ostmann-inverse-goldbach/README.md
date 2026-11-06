> **Language**: **English** | [**한국어 (`README.ko.md`)**](./README.ko.md)

# Case 009: OpenAI `#013` Ostmann's Inverse Goldbach Conjecture (`Erdős #431`)

This package dissects OpenAI `#013` (*The additive indecomposability of the primes*, `OAI/NumberTheory/Ostmann/`, `7,716` `.lean` files, `609,199` lines, and `6,072` preprint lines). All findings are cross-referenced 1-to-1 against `proofs/oai_ref/` (`60` upstream files) and verified across `75` standalone Lean 4 theorems (`v4.29.0-rc8`, `0 sorry`, `393/393` hypothesis mutations caught).

## Key Findings

1. **Twin-Engine `7,716`-File Duplication**: We show that `Ostmann/` contains two almost disjoint proof trees (`Complete.lean`: `3,165` files; `Main.lean`: `4,175` files) sharing only `5` files (`372` lines), plus `381` orphaned fossils (`3165 + 4175 - 5 + 381 = 7716`).
2. **Fourier Supply Contraction (`-11/125`) & Squared-Kernel Slope $2t_0$**: We verify the collision penalty $\frac{(2\sigma_p-1)^2}{\sigma_p(1-\sigma_p)} \ge \frac{1}{2}$, the rank-2 transfer kernel discriminant $(a-d)^2+4b^2 \ge 0$ and squared-kernel trace $K^2$ doubling the leading slope $t_0 \mapsto 2t_0$, local contraction $1 - \frac{8}{5}\cdot\frac{17}{25} = -\frac{11}{125} < 0$, strict independence from `#003` (`QRH`), and $+53\%$ prime-mass expansion ($0.15L \to 0.23L$).
3. **Inductive Tree Budget, 4 Core Algebraic Engines & Effective Thresholds**: We prove by `Nat` induction that $\sum_{j=0}^{k-1} j 2^j = (k-2)2^k+2$ gives net rate $\frac{2}{5} - \frac{3}{4} = -\frac{7}{20} < 0$, show that deranged slot pairs ($t_1 = 0$) cut minimum depth $k_{\min}$ from `7041` to `1040`, prove from first principles the Section 3 Common Center congruence cancellation and Bonami 4th moment, Section 6 affine collision factorization and Vandermonde 3-way collision bound, and Section 8 $2\times 2$ Cauchy determinant identity $(b_1-a_2)(b_2-a_1)-(b_1-a_1)(b_2-a_2)=(b_2-b_1)(a_1-a_2) \ge 1 \neq 0$, and eliminate Siegel's ineffectiveness in Section 3 to reduce the explicit counterexample log-log threshold $L_{\mathrm{eff}}$ from `4,115,904` to `640,722` (`255,983`).

## 4-Tier Reader Guide

| Tier | Target Audience | Document | Summary |
| :---: | :--- | :--- | :--- |
| **Tier 1** | **Beginners** | [`en/01_Beginner_Guide.md`](en/01_Beginner_Guide.md) | Plain-language overview of Ostmann's problem, the Twin-Engine duplication, and the 3-step proof. |
| **Tier 2** | **Intermediates** | [`en/02_Intermediate_Guide.md`](en/02_Intermediate_Guide.md) | 1-to-1 declaration tables for `proofs/oai_ref/` (`60` files) and all 75 Lean 4 theorems. |
| **Tier 3** | **Experts** | [`en/03_Advanced_Guide.md`](en/03_Advanced_Guide.md) | Full forensic report covering the 3-generation fossil tree, step-by-step derivations of the 4 algebraic engines, effective thresholds, and 9-section 1:1 audit. |
| **Tier 4** | **Automated Verifiers** | [`en/04_Expert_Verification.md`](en/04_Expert_Verification.md)<br>[`manifest.json`](manifest.json) | SHA-256 checksum table, mutation testing summary (`393/393`), and verification commands. |

## Formal Proofs & One-Command Verification

- [`ostmann_twin_engines_and_supply_contraction.lean`](proofs/ostmann_twin_engines_and_supply_contraction.lean#L1-L517): Theorems 1–20 and 51–55 (`188/188` mutations caught).
- [`ostmann_tree_transfers_and_permutation_contradiction.lean`](proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L1-L564): Theorems 21–50 + 2 `def`s (`181/181` mutations caught).
- [`ostmann_algebraic_engines_and_cauchy_determinant.lean`](proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L1-L420): Theorems 56–75 + `OstmannContractionSystem` (`24/24` mutations caught).
- [`verify_symbolic_ostmann.py`](proofs/verify_symbolic_ostmann.py) & [`symbolic_verification_result.json`](proofs/symbolic_verification_result.json).

```bash
lean proofs/ostmann_twin_engines_and_supply_contraction.lean && lean proofs/ostmann_tree_transfers_and_permutation_contradiction.lean && lean proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean && (cd proofs && python3 verify_symbolic_ostmann.py)
```
