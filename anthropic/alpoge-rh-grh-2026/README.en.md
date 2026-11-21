# Anthropic (Levent Alpöge + Claude) 17.37M-Line Lean 4 RH & GRH Proof: Complete Decompilation Suite

> **Language**: [**한국어 (`README.md`)**](./README.md) | **English**

Levent Alpöge and Claude's commentless `175,187`-file (`17,374,215`-line) `Lean 4` archive proving the Riemann Hypothesis (`RiemannHypothesis`) and Generalized Riemann Hypothesis (`GRH`) for Dirichlet $L$-functions was independently compiled from scratch across dual hardware architectures (`x86_64` and `aarch64`) under official `leanprover/lean4:v4.33.1`.
All `175,187` modules compiled with `0` errors, `0` `sorryAx`, and only the three standard axioms `[propext, Classical.choice, Quot.sound]` (`PASS`, receipt in [FINAL_FEDERATED_VERDICT.txt](./data/FINAL_FEDERATED_VERDICT.txt)).
This folder provides a complete 6-volume Korean mathematical decompilation, a `195 / 195` (`100.0%`) literature attribution dictionary, 4 high-DPI figures, a 15-theorem standalone `Lean 4` arithmetic audit, and a typeset 43-page A4 monograph.

---

## Typeset Monograph (Print & Offline Reading)

- **[리만가설_1737만줄_완전풀이집.pdf](./book/리만가설_1737만줄_완전풀이집.pdf)**: 43-page A4 typeset Korean monograph combining cover, TOC, all 6 volumes (`00`~`05`), 4 editorial figures, and full mathematical equations (`PASS`).
- **[리만가설_1737만줄_완전풀이집.html](./book/리만가설_1737만줄_완전풀이집.html)**: Self-contained offline HTML edition (`PASS`).

---

## Six-Volume Decompilation Index

1. **[00_한눈에_보는_전체지도.md](./00_한눈에_보는_전체지도.md)**: Quantitative directory breakdown ([Figure 1](./figures/fig1_archive_breakdown.png)), 6-term plain glossary, and 4-stage backward dependency map from `src/Main.lean:1-12`.
2. **[01_수식없이_읽는_비유풀이.md](./01_수식없이_읽는_비유풀이.md)**: Zero-symbol general-audience exposition with a hand-calculable $X = 10$ prime weight example and 5 intuitive bridges.
3. **[02_눈으로_만지는_핵심원리_5막.md](./02_눈으로_만지는_핵심원리_5막.md)**: Undergraduate-level derivation of the $m \ge X^{1 - \theta - \varepsilon}$ ($\theta = 1/2 \implies m \approx \sqrt{X}$) Chebyshev-theta chain length and $X \le 10,000$ numerical prime lab ([Figure 2](./figures/fig2_residual_vs_fake_zero.png), [Figure 3](./figures/fig3_lift_cost_barrier.png)).
4. **[03_Lean코드_척추_해부원장.md](./03_Lean코드_척추_해부원장.md)**: Line-pinned Lean architectural spine from `Statements.lean` and `Main.lean` down to the 8 metaprogramming files, `VWin` 5-count assemblers, and all 9 refactored `UnusedSlot` types (`375` references).
5. **[04_기출대정리_원전복원사전.md](./04_기출대정리_원전복원사전.md)**: `100.0%` (`195 / 195`) restoration of every `UpperTheory.LiteratureTheorems.*` wrapper in `EveryCharacterOfLiteratureOfVWin.lean` (`34 + 10 + 23 + 52 + 27 + 39 + 10 = 195`) with classical authors and years.
6. **[05_전공자용_수론심층심사및수식복원서.md](./05_전공자용_수론심층심사및수식복원서.md)**: Referee-grade reconstruction of `Scale` ($\varepsilon < 1/52$, `la = 3/2`, Lucas prime `413,718,278,401`), Bargmann-Fock and $\mathfrak{gl}_2$ Yangian RTT positivity $W(\cdot) \ge 0$, Siegel-Weyl $-C m^2 L / k$ loss cancellation, `VWin`(`Ct = 401`) parity split ([Figure 4](./figures/fig4_vwin_parity_and_counts.png)), slack audit, and OpenAI `#003` (`Cases 005 & 008`) cross-audit.

---

## Verification & Build Scripts

- **[alpoge_spine_arithmetic_audit.lean](./proofs/alpoge_spine_arithmetic_audit.lean)**: Standalone `0 sorry` `Lean 4` proof of 15 core exponent, congruence, parity, slack, and cross-audit theorems (`leanprover/lean4:v4.33.1`, zero external imports).
- **[FINAL_FEDERATED_VERDICT.txt](./data/FINAL_FEDERATED_VERDICT.txt)**: Dual-kernel (`x86_64` and `aarch64`) `#print axioms` verification receipt for all 5 top-level RH/GRH theorems.
- **[verify_guide_integrity.py](./scripts/verify_guide_integrity.py)**: Deterministic verifier checking all documents, figures, `195 / 195` literature pins, standalone Lean compilation, and HTML/PDF integrity (`python3 scripts/verify_guide_integrity.py`).
