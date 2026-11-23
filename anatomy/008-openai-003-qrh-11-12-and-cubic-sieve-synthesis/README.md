# OpenAI #003 23/24 vs. 11/12, Unimported CubicGauss & Trilogy Synthesis

- Language: English | [Korean (README.ko.md)](./README.ko.md) | Main Index: [ultari-proof-anatomy](../../README.md)

This 11/12 and CubicGauss synthesis audit examines the OpenAI #003 QRH ecosystem (`openai/math` commit `4eaee87` / `PR #70` `ca28f20` for files outside `proofs/oai_ref/`: `DirichletL/ShortDraft`, `CubicGauss/`, `paper2.tex`, `AlexKontorovich/quasi-rh`, Baiying Liu `arXiv:2610.12234` (unrefereed preprint), and [Part I (7/8 ShortDraft Audit)](../001-openai-003-qrh/README.md) + [Part II (Referee & Unbundled Gram Audit)](../005-openai-003-qrh-mathematician-referee-audit/README.md)). Note upfront that `#003`'s proved main theorem `SevenEighths.lean` ($\beta = 7/8 = 21/24$, `0 sorry`) already logically implies both $11/12$ and $23/24$ (and `DescentScale.lean` exists in-repo), so our `ElevenTwelfths` (`23/24`) and 30 unimported `CubicGauss` findings are strictly **module-stratigraphy / intermediate-target analyses**, not a claim that `#003` failed to reach $11/12$. All findings are verified across 45 standalone Lean 4 theorems, 11 `def` declarations, and 1 `structure` (`ZSqrt921`) across 3 files (v4.29.0-rc8, 0 sorry, 344/344 hypothesis mutations caught).

## Key Findings

1. Why `ShortDraft` Stops at 23/24 vs. 11/12 (Module-Stratigraphy / Intermediate-Target Analysis): While `#003`'s proved $7/8$ main theorem (`DirichletL/Nonvanishing.lean` in official `4eaee87`; `SevenEighths.lean` in community `PR #70` `ca28f20`, `0 sorry`) already logically implies both $11/12$ and $23/24$, fixing `reserve = 1/20` in `DirichletL/CubicSieve/RankMargins.lean:83-132` (`η ≤ 1/1000` at `ClosedRecursion.lean:120`) locks the isolated `ShortDraft` target at $\vartheta = 1/10 \implies \frac{23}{24}$, whereas `CanonicalDescentScale` (`PR #70` `DescentScale.lean`) unlocks $\frac{11}{12}+\varepsilon$ (`cauchy_const = 768`).
2. Unimported `CubicGauss` & All-$n$ Induction: We audit the unimported 30-file sharp $2/3$ cubic large sieve and prove by `Nat` induction that `sieveIter` has exact closed form $\frac{4\cdot 3^n - 2^{n+1}}{3\cdot 3^n - 2^{n+1}}$; OpenAI's geometric-series majorization (`CubicGauss/LargeSieve.lean:75`) is a valid simplification that still reaches the exact same asymptotic fixed point $\alpha^* = 4/3$.
3. $\mathbb{Z}[\sqrt{921}]$ Ring & Conditional Trilogy Synthesis: We unify Part II and Liu's $\mathbb{Q}(\sqrt{921})$ roots (`arXiv:2610.12234`, unrefereed preprint). Our `0 sorry` Lean 4 theorems (`thm_27`, `thm_40`) separate `CubicGauss`'s positive `LowRows` exponent $53/216 > 0$ from the **formal Path-A zero-energy LP intercept** $\beta = \frac{71}{108} \approx 0.6574$ (requiring hypothetical full cancellation $\Delta_{\mathrm{gram}} = 53/216$ plus Stickelberger pole cancellation $k_\infty = -6$ and Voronoi-Mellin transfer), distinct from the additional $\Delta_{\mathrm{hybrid}} = \frac{14}{33}$ threshold needed for $\beta = \frac{1}{2}$.

## 4-Tier Reader Guide

| Tier | Target Audience | Document | Summary |
| :---: | :--- | :--- | :--- |
| Tier 1 | Beginners | [en/01_Beginner_Guide.md](en/01_Beginner_Guide.md) | Plain-language guide to the 5 ecosystem mysteries and the 10-tier boundary table. |
| Tier 2 | Intermediates | [en/02_Intermediate_Guide.md](en/02_Intermediate_Guide.md) | Core algebraic derivations and a 1-to-1 index of all 45 Lean 4 theorems. |
| Tier 3 | Experts | [en/03_Advanced_Guide.md](en/03_Advanced_Guide.md) | Full synthesis report covering CubicGauss, $\mathbb{Z}[\sqrt{921}]$, Farkas unbundling, and the trilogy bridge. |
| Tier 4 | Automated Verifiers | [en/04_Expert_Verification.md](en/04_Expert_Verification.md)<br>[manifest.json](manifest.json) | SHA-256 checksum table, mutation testing summary, and verification commands. |

## Formal Proofs & One-Command Verification

- [qrh_eleven_twelfths_and_cubic_large_sieve.lean](proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean): Theorems 1–15 + 2 `def`s (115/115 mutations caught).
- [qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean](proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean): Theorems 16–30 + 2 `def`s (125/125 mutations caught).
- [qrh_trilogy_induction_and_algebraic_bridge.lean](proofs/qrh_trilogy_induction_and_algebraic_bridge.lean): Theorems 31–45 + 7 `def`s + 1 `structure` (`ZSqrt921`) (104/104 mutations caught).
- [verify_symbolic_qrh_synthesis.py](proofs/verify_symbolic_qrh_synthesis.py) & [symbolic_verification_result.json](proofs/symbolic_verification_result.json).

```bash
python3 ../../tools/verify_all.py --root .
lean proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean && lean proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean && lean proofs/qrh_trilogy_induction_and_algebraic_bridge.lean && (cd proofs && python3 verify_symbolic_qrh_synthesis.py)
```
