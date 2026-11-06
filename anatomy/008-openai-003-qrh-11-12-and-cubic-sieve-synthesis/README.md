> **Language**: **English** | [**한국어 (`README.ko.md`)**](./README.ko.md)

# Case 008: OpenAI `#003` `23/24` vs. `11/12`, Unimported `CubicGauss` & Trilogy Synthesis

This package synthesizes the full OpenAI `#003` QRH ecosystem (`DirichletL/ShortDraft`, `CubicGauss/`, `paper2.tex`, `AlexKontorovich/quasi-rh`, Baiying Liu `arXiv:2610.12234`, and [`Case 001`](../001-openai-003-qrh/README.md) + [`Case 005`](../005-openai-003-qrh-mathematician-referee-audit/README.md)). All findings are verified across `45` standalone Lean 4 theorems and `7` `def`s (`v4.29.0-rc8`, `0 sorry`, `344/344` hypothesis mutations caught).

## Key Findings

1. **Why `ShortDraft` Stops at `23/24` vs. `11/12`**: Fixing `reserve = 1/20` in `ClosedRecursion.lean` locks $artheta = 1/10 \implies rac{23}{24}$, whereas `CanonicalDescentScale` unlocks $rac{11}{12}+arepsilon$ (`cauchy_const = 768`).
2. **Unimported `CubicGauss` & All-$n$ Induction**: We audit the unimported 30-file sharp $2/3$ cubic large sieve and prove by `Nat` induction that `sieveIter` has exact closed form $rac{4\cdot 3^n - 2^{n+1}}{3\cdot 3^n - 2^{n+1}}$.
3. **$\mathbb{Z}[\sqrt{921}]$ Ring & Trilogy Bridge**: We unify `Case 005` and Liu's $\mathbb{Q}(\sqrt{921})$ roots and link `Case 001`–`005`–`008` down to $eta = rac{71}{108} pprox 0.6574$, separating it from the open $\Delta_{\mathrm{hybrid}} = rac{14}{33}$ threshold needed for $eta = rac{1}{2}$.

## 4-Tier Reader Guide

| Tier | Target Audience | Document | Summary |
| :---: | :--- | :--- | :--- |
| **Tier 1** | **Beginners** | [`en/01_Beginner_Guide.md`](en/01_Beginner_Guide.md) | Plain-language guide to the 5 ecosystem mysteries and the 10-tier boundary table. |
| **Tier 2** | **Intermediates** | [`en/02_Intermediate_Guide.md`](en/02_Intermediate_Guide.md) | Core algebraic derivations and a 1-to-1 index of all 45 Lean 4 theorems. |
| **Tier 3** | **Experts** | [`en/03_Advanced_Guide.md`](en/03_Advanced_Guide.md) | Full synthesis report covering `CubicGauss`, $\mathbb{Z}[\sqrt{921}]$, Farkas unbundling, and the trilogy bridge. |
| **Tier 4** | **Automated Verifiers** | [`en/04_Expert_Verification.md`](en/04_Expert_Verification.md)<br>[`manifest.json`](manifest.json) | SHA-256 checksum table, mutation testing summary, and verification commands. |

## Formal Proofs & One-Command Verification

- [`qrh_eleven_twelfths_and_cubic_large_sieve.lean`](proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L1-L305): Theorems 1–15 (`115/115` mutations caught).
- [`qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean`](proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L1-L313): Theorems 16–30 (`125/125` mutations caught).
- [`qrh_trilogy_induction_and_algebraic_bridge.lean`](proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L1-L356): Theorems 31–45 + 7 `def`s (`104/104` mutations caught).
- [`verify_symbolic_qrh_synthesis.py`](proofs/verify_symbolic_qrh_synthesis.py) & [`symbolic_verification_result.json`](proofs/symbolic_verification_result.json).

```bash
lean proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean && lean proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean && lean proofs/qrh_trilogy_induction_and_algebraic_bridge.lean && (cd proofs && python3 verify_symbolic_qrh_synthesis.py)
```
