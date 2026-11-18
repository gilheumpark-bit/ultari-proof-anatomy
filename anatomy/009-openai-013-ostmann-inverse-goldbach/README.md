# OpenAI #013: Ostmann's Inverse Goldbach Conjecture (Erdős #431)

- Language: English | [한국어 (README.ko.md)](./README.ko.md) | Main Index: [ultari-proof-anatomy](../../README.md)

This forensic audit dissects OpenAI #013 (The additive indecomposability of the primes, `OAI/NumberTheory/Ostmann/`, 7,716 `.lean` files, 609,199 lines, and 6,072 preprint section lines / 6,624 total build lines). All findings are cross-referenced 1-to-1 against `proofs/oai_ref/` (60 upstream files) and verified across 75 standalone Lean 4 theorems (1,517 lines, `v4.29.0-rc8`, `0 sorry`, `0 axiom`, 393/393 hypothesis mutations caught).

## Key Findings

1. Twin-Engine 7,716-File Duplication & Erdos970 Patch Audit: We show that Ostmann/ contains two almost disjoint proof trees (Complete.lean: 3,165 files; Main.lean: 4,175 files) sharing only 5 files (372 lines, 0.065%), plus 381 orphaned fossils (39,517 lines, including All.lean & PaperMain.lean; 3165 + 4175 - 5 + 381 = 7716), alongside +47,394-line Erdos970 upstream patches omitting SiegelZeros/NOTICE.md and replacing 2,253 comment lines with ASCII spaces (0x20).
2. Fourier Supply Contraction (-11/125) & Squared-Kernel Slope $2t_0$: We verify the collision penalty $\frac{(2\sigma_p-1)^2}{\sigma_p(1-\sigma_p)} \ge \frac{1}{2}$, the rank-2 transfer kernel discriminant $(a-d)^2+4b^2 \ge 0$ and squared-kernel trace $K^2$ doubling the leading slope $t_0 \mapsto 2t_0$, local contraction $1 - \frac{8}{5}\cdot\frac{17}{25} = -\frac{11}{125} < 0$, strict independence from #003 (QRH: 0 imports vs. 18 direct / 183 transitive #021 & #026 imports in Engine B), and $+53\%$ prime-mass expansion ($0.15L \to 0.23L$).
3. Inductive Tree Budget, 4 Core Algebraic Engines & Effective Thresholds: We prove by `Nat` induction that $\sum_{j=0}^{k-1} j 2^j = (k-2)2^k+2$ gives net rate $\frac{2}{5} - \frac{3}{4} = -\frac{7}{20} < 0$, show that deranged slot pairs ($t_1 = 0$) cut minimum depth $k_{\min}$ from 7,041 to 1,040, prove from first principles the Section 3 common-center congruence cancellation and Bonami 4th-moment model, Section 6 affine collision factorization and Vandermonde 3-way collision bound, and Section 8 linear-form arithmetic tests, cleared-denominator $2\times 2$ minor non-degeneracy, and Schwartz-Zippel framework (paired with standalone algebraic $2\times 2$ minor/determinant models), and eliminate Siegel's ineffectiveness in Section 3 via Tatuzawa's theorem (384,002) to reduce the explicit counterexample log-log threshold $L_{\mathrm{eff}}$ from 4,115,904 to 640,722 (255,983 ultra-sharp, 16.08x reduction).

## 4-Tier Reader Guide

| Tier | Target Audience | Document | Summary |
| :---: | :--- | :--- | :--- |
| Tier 1 | Beginners | [en/01_Beginner_Guide.md](en/01_Beginner_Guide.md) | Plain-language overview of Ostmann's problem, the Twin-Engine duplication, and the 3-step proof. |
| Tier 2 | Intermediates | [en/02_Intermediate_Guide.md](en/02_Intermediate_Guide.md) | 1-to-1 declaration tables for `proofs/oai_ref/` (60 files) and all 75 Lean 4 theorems. |
| Tier 3 | Experts | [en/03_Advanced_Guide.md](en/03_Advanced_Guide.md) | Full forensic report covering the 3-generation fossil tree, step-by-step derivations of the 4 algebraic engines, effective thresholds, and 9-section 1:1 audit. |
| Tier 4 | Automated Verifiers | [en/04_Expert_Verification.md](en/04_Expert_Verification.md)<br>[manifest.json](manifest.json) | SHA-256 checksum table, mutation testing summary (393/393), and verification commands. |
| Tier 5 (Detailed Audit) | Forensic Referees & Peers | [en/05_OPFF_Detailed_Forensic_Referee_Report_Ostmann013.md](en/05_OPFF_Detailed_Forensic_Referee_Report_Ostmann013.md)<br>[ko/05_OPFF_상세형_포렌식심사보고서_Ostmann013.md](ko/05_OPFF_상세형_포렌식심사보고서_Ostmann013.md) | 7-part Detailed Forensic Referee Report (TIER C: Gate 1·5 PASS / Gate 2·3·4 FAIL, 8-metric scorecard, 3-tier attribution, 6-question FAQ, and formal verdict box). |
| Tier 6 (Basic Summary) | Executive & Quick Review | [en/06_OPFF_Basic_Audit_Report_Ostmann013.md](en/06_OPFF_Basic_Audit_Report_Ostmann013.md)<br>[ko/06_OPFF_기본형_감사리포트_Ostmann013.md](ko/06_OPFF_기본형_감사리포트_Ostmann013.md) | Concise Basic Audit Report (TIER C scorecard, verified physical findings, 6-question FAQ, and 10-second verification commands). |

## Formal Proofs & One-Command Verification

- [ostmann_twin_engines_and_supply_contraction.lean](proofs/ostmann_twin_engines_and_supply_contraction.lean#L1): Theorems 1–20 and 51–55 (188/188 mutations caught).
- [ostmann_tree_transfers_and_permutation_contradiction.lean](proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L1): Theorems 21–50 + 2 recursive `def`s (181/181 mutations caught).
- [ostmann_algebraic_engines_and_cauchy_determinant.lean](proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L1): Theorems 56–75 + 1 recursive `def` + [OstmannContractionSystem](proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L28-L34) (24/24 mutations caught).
- [verify_symbolic_ostmann.py](proofs/verify_symbolic_ostmann.py) & [symbolic_verification_result.json](proofs/symbolic_verification_result.json).

```bash
python3 ../../tools/verify_all.py --root .
lean proofs/ostmann_twin_engines_and_supply_contraction.lean && lean proofs/ostmann_tree_transfers_and_permutation_contradiction.lean && lean proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean && (cd proofs && python3 -B verify_symbolic_ostmann.py)
```
