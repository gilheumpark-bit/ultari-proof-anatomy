# Anthropic (Levent Alpöge + Claude) 17.37M-Line Lean 4 RH & GRH Proof: Complete Decompilation Suite

> **Language**: **English** | [**한국어 (`README.md`)**](./README.md)

Levent Alpöge and Claude's commentless `175,187`-file (`17,374,215`-line) `Lean 4` archive proving the Riemann Hypothesis (`RiemannHypothesis`) and Generalized Riemann Hypothesis (`GRH`) for Dirichlet $L$-functions was independently compiled from scratch across dual hardware architectures (`x86_64` and `aarch64`) under official `leanprover/lean4:v4.33.1`.
All `175,187` modules compiled with `0` errors, `0` `sorryAx`, and only the three standard axioms `[propext, Classical.choice, Quot.sound]` (`PASS`, receipt in [FINAL_FEDERATED_VERDICT.txt](./data/FINAL_FEDERATED_VERDICT.txt)).
This directory provides complete English (`en/`) and Korean (`./`) 6-volume mathematical decompilations, `195 / 195` (`100.0%`) classical literature attribution dictionaries, 8 high-DPI figures, a 15-theorem standalone `Lean 4` arithmetic audit, and typeset A4 monographs in both languages.

---

## Typeset Monographs (Print & Offline Reading)

- **English Edition (`45` pages A4)**: **[Alpoge_RH_17M_Complete_Decompilation_EN.pdf](./book/Alpoge_RH_17M_Complete_Decompilation_EN.pdf)** · **[Offline HTML](./book/Alpoge_RH_17M_Complete_Decompilation_EN.html)** (`PASS`)
- **Korean Edition (`43` pages A4)**: **[리만가설_1737만줄_완전풀이집.pdf](./book/리만가설_1737만줄_완전풀이집.pdf)** · **[Offline HTML](./book/리만가설_1737만줄_완전풀이집.html)** (`PASS`)

---

## Six-Volume English Decompilation Index (`en/`)

1. **[00_Executive_Overview_and_Map.md](./en/00_Executive_Overview_and_Map.md)** (`All Readers · 3-Minute Map & Glossary`)
    - Quantitative directory breakdown ([Figure 1](./figures/fig1_archive_breakdown_en.png)), 6-term physical glossary, and 4-step backward dependency map from `src/Main.lean:1-12`.
2. **[01_Plain_Language_Analogy_Guide.md](./en/01_Plain_Language_Analogy_Guide.md)** (`General Audience · Zero LaTeX Symbols`)
    - Hand-calculable $X = 10$ prime weight walkthrough and five intuitive bridges from tuning forks to Behrend sieves.
3. **[02_Core_Principles_Five_Acts.md](./en/02_Core_Principles_Five_Acts.md)** (`Undergraduates & Engineers · Core Algebra + Prime Lab`)
    - Three-line derivation of $m \ge X^{1 - \theta - \varepsilon}$ ($\theta = 1/2 \implies m \approx \sqrt{X}$) and empirical prime residual lab up to $X = 10,000$ ([Figure 2](./figures/fig2_residual_vs_fake_zero_en.png), [Figure 3](./figures/fig3_lift_cost_barrier_en.png)).
4. **[03_Lean_Code_Spine_Ledger.md](./en/03_Lean_Code_Spine_Ledger.md)** (`Formal-Methods Auditors · Line-Pinned Architecture`)
    - Exact file-and-line trace from `Statements.lean` and `Main.lean` down to the 8 metaprogramming files, `VWin` 5-count assemblers, and the `2 + 7 = 9` `UnusedSlot` classification (`375` slot-file pairs).
5. **[04_Literature_195_Attribution_Dictionary.md](./en/04_Literature_195_Attribution_Dictionary.md)** (`195 / 195 Classical Source Attribution`)
    - Exhaustive `100.0%` (`34 + 10 + 23 + 52 + 27 + 39 + 10 = 195`) line-pinned restoration of every `UpperTheory.LiteratureTheorems.*` wrapper in `EveryCharacterOfLiteratureOfVWin.lean` ([literature_195_en.json](./data/literature_195_en.json)).
6. **[05_Specialist_Referee_and_Equation_Audit.md](./en/05_Specialist_Referee_and_Equation_Audit.md)** (`Number Theorists & Referees · Deep Equations & Cross-Audit`)
    - Reconstructs `Scale` ($\varepsilon < 1/52$, `la = 3/2`, Lucas witness prime `413,718,278,401`), Bargmann-Fock and $\mathfrak{gl}_2$ Yangian RTT positivity $W(\cdot) \ge 0$, Siegel-Weil $-C m^2 L / k$ quadratic loss cancellation, `VWin` (`Ct = 401`) mirror-parity split ([Figure 4](./figures/fig4_vwin_parity_and_counts_en.png)), formalization slacks, and the 1-to-1 OpenAI `#003` (`Cases 005 & 008`) cross-audit.

---

## Verification & Reproducible Build Scripts

- **[alpoge_spine_arithmetic_audit.lean](./proofs/alpoge_spine_arithmetic_audit.lean)**: Standalone `0 sorry` `Lean 4` proof of 15 core exponent, congruence, parity, slack, and cross-audit theorems (`leanprover/lean4:v4.33.1`, zero external imports).
- **[FINAL_FEDERATED_VERDICT.txt](./data/FINAL_FEDERATED_VERDICT.txt)**: Dual-kernel (`x86_64` and `aarch64`) `#print axioms` verification receipt for all 5 top-level RH/GRH theorems.
- **[extract_proof_anatomy.py](./scripts/extract_proof_anatomy.py)** and **[prime_intuition_lab.py](./scripts/prime_intuition_lab.py)**: Static 175,187-file import-cone parser ([anatomy_stats.json](./data/anatomy_stats.json)) and $X \le 10,000$ residual/Behrend lab ([prime_lab_results.json](./data/prime_lab_results.json)).
- **[build_04_dict.py](./scripts/build_04_dict.py)**, **[generate_figures.py](./scripts/generate_figures.py)**, and **[build_typeset_book.py](./scripts/build_typeset_book.py)**: Deterministic generators for both `195 / 195` dictionaries, all 8 figures, and both A4 PDF/HTML monographs (`PASS`).
- **[verify_guide_integrity.py](./scripts/verify_guide_integrity.py)**: Deterministic verifier checking all 14 bilingual documents, 8 figures, `390 / 390` (`195 KO + 195 EN`) literature pins, standalone Lean compilation, and HTML/PDF math typesetting (`python3 scripts/verify_guide_integrity.py`).
