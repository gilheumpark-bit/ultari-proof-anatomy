# Anthropic (Levent Alpöge + Claude) 17.37M-Line Lean 4 RH & GRH Proof: Complete Decompilation & AST Atlas

> **Language**: **English** | [**한국어 (`README.md`)**](./README.md)

Levent Alpöge and Claude's commentless `175,187`-file (`17,374,215`-line) `Lean 4` archive for the Riemann Hypothesis (`RiemannHypothesis`) and Dirichlet `GRH` passed mechanical formal certification across dual CPU architectures (`x86_64` and `aarch64`) under official `leanprover/lean4:v4.33.1` as well as independent external kernels (`nanoda`, `con-leche`, `lean4lean`).
All `175,187` modules verified with `0` errors, `0` `sorryAx`, and only the three standard axioms `[propext, Classical.choice, Quot.sound]` (`PASS`, receipt in [FINAL_FEDERATED_VERDICT.txt](./data/FINAL_FEDERATED_VERDICT.txt); mathematical peer review remains ongoing `ONGOING`).
This unified directory provides:
(1) the **7-Volume Bilingual Deep Mathematical Decompilation Monograph (`Part A`, `part_a_en/` & `part_a/`)** reconstructing the `4.22M`-line novel proof engine, pinned `Mathlib` boundary semantics, `201` classical imports, and `152`-page journal paper blueprint;
(2) the **`100.00%` AST Formula Atlas (`Part B`, `atlas/`)** indexing all `308,731` declarations across `30,343` unique modules;
(3) the **6-Volume Progressive Reader & Specialist Guide (`en/00`..`05` & `00`..`05`)** with `195 / 195` classical literature attributions; and
(4) **`61` standalone zero-`sorry` `Lean 4` audit theorems (`44 + 17`)**.

---

## Typeset Print-Ready A4 Monographs (4 Editions, English & Korean)

- **Part A Deep Decompilation Monograph (English, `148` pages A4)**: **[Alpoge_RH_AB_Deep_Decompilation_EN.pdf](./book/Alpoge_RH_AB_Deep_Decompilation_EN.pdf)** · **[Offline HTML](./book/Alpoge_RH_AB_Deep_Decompilation_EN.html)** (`PASS`)
- **Part A Deep Decompilation Monograph (Korean, `132` pages A4)**: **[알푀게_리만가설_신작증명_심층해독단행본_AB.pdf](./book/알푀게_리만가설_신작증명_심층해독단행본_AB.pdf)** · **[Offline HTML](./book/알푀게_리만가설_신작증명_심층해독단행본_AB.html)** (`PASS`)
- **Six-Volume Progressive Reader Guide (English, `55` pages A4)**: **[Alpoge_RH_17M_Complete_Decompilation_EN.pdf](./book/Alpoge_RH_17M_Complete_Decompilation_EN.pdf)** · **[Offline HTML](./book/Alpoge_RH_17M_Complete_Decompilation_EN.html)** (`PASS`)
- **Six-Volume Progressive Reader Guide (Korean, `53` pages A4)**: **[리만가설_1737만줄_완전풀이집.pdf](./book/리만가설_1737만줄_완전풀이집.pdf)** · **[Offline HTML](./book/리만가설_1737만줄_완전풀이집.html)** (`PASS`)

---

## Part I. Seven-Volume Deep Decompilation (`part_a_en/` & `part_a/`) + 100.00% AST Atlas (`atlas/`)

Every English volume (`5,427` lines total) maintains exact `100.00%` 1-to-1 `.lean:line` pin multiset parity (`1,870` pins) with its Korean counterpart (`5,618` lines total).

1. **Volume 0 · Executive Preface & Master Map**: **[English (`A00`)](./part_a_en/A00_Executive_Preface_And_Master_Map.md)** · [Korean (`A00`)](./part_a/A00_총괄서문_및_전체해부지도.md) (`89` lines, `2` pins)
    - Four-layer verification separation ledger, quantitative stratification of the `29,067`-module (`300,415`-declaration) novel union, `in_degree` power-law hub concentration, and deterministic tactic profile (`aesop` `0.0033%`, [Fig AB-1](./figures/fig_ab_01_archive_stratification_en.png) .. [Fig AB-4](./figures/fig_ab_04_tactic_anatomy_en.png)).
2. **Volume 1 · Top Seal, `Mathlib` Boundary Semantics & Upper Bridges**: **[English (`A01`)](./part_a_en/A01_Top_Seal_Mathlib_Boundary_Semantics_And_Upper_Bridge_Audit.md)** · [Korean (`A01`)](./part_a/A01_최상위봉인_Mathlib경계의미론_및_상단브리지감사.md) (`816` lines, `391` pins)
    - Closed-proposition soundness of `Main.lean` and `Statements.lean`, forensic audit of all `8` metaprogramming files (`allowUnsafeReducibility` across `33` unique files / `37` hits), source-level `Mathlib` zeta ($s=1$ division-by-zero value, $s=0$, trivial zeros) and Dirichlet $L$-series ($N=1$, imprimitive Euler factors at $\mathrm{Re}(s)=0$) proofs, and dissection of the top `43` bridges.
3. **Volume 2 · Classical `201` Imports & `PublishedTheorems` Equivalence Audit**: **[English (`A02`)](./part_a_en/A02_Classical_201_Imports_And_PublishedTheorems_Semantic_Equivalence_Audit.md)** · [Korean (`A02`)](./part_a/A02_기출201선_및_PublishedTheorems_의미론동치성감사.md) (`1,113` lines, `417` pins)
    - Exhaustive `201 / 201` semantic classification of `EveryCharacterOfLiteratureOfVWin.lean` local imports (`127` Type I, `44` Type II-A, `11` Type II-B, `19` assembly/adapters) and source-equation reconstruction across `PublishedTheorems` (`1,073` files).
4. **Volume 3 · `Formalism` Four Pillars (`2.58M` Lines) Lower Hubs & Tactics**: **[English (`A03`)](./part_a_en/A03_Formalism_Four_Pillars_Lower_Tactics_And_Core_Hubs_Decompilation.md)** · [Korean (`A03`)](./part_a/A03_Formalism_4대기둥_하부전술및핵심허브_심층복원.md) (`1,198` lines, `315` pins)
    - Line-by-line hub decompilation across `LocalToGlobal` (`956K` lines), `SharpRestriction` (`709K` lines), `HermitianCurvature` (`461K` lines), and `PeriodIntegrals` (`452K` lines), reconstructing the triple cancellation that breaks the $\sigma = 2/3$ level-denominator barrier.
5. **Volume 4 · `Formalism` `112` Specialized Subtheories & Global Constant Closure**: **[English (`A04`)](./part_a_en/A04_Formalism_112_Specialized_Subtheories_And_Global_Constant_Closure.md)** · [Korean (`A04`)](./part_a/A04_Formalism_112개특수소이론_및_전역상수폐루프복원.md) (`989` lines, `334` pins)
    - Six-cluster reconstruction of all `112` specialized subtheories (`43,521` declarations, led by `RhoDetPrimeEqMuTildeMulChiPow.lean` at `in_degree = 921`) and verification of the acyclic quantifier DAG from `ShapeWin` $(C_{\mathrm{abs}}, C_0, e_D, e_L) = (2, 3, 2, 0)$ through `CoreGm` ($\frac{1}{2} + 9\varepsilon$) and `landauWindow`.
6. **Volume 5 · `Pure_Vwin` Vandiver Bypass, Behrend Tower & 44-Theorem Suite**: **[English (`A05`)](./part_a_en/A05_PureVwin_Vandiver_Bypass_Behrend_Tower_And_Formal_Audit_Suite.md)** · [Korean (`A05`)](./part_a/A05_PureVwin_반디버우회_베렌트타워_및_기계검증확장.md) (`1,066` lines, `293` pins)
    - Decompilation of `Pure_Vwin` (`10,832` files, `1.03M` lines, `61,209` declarations), weakened-Vandiver odd/even parity patching, `LiteratureRankNHypothesis` (`56` slots = `50` literature + `6` novel), Behrend-Iwasawa towers, threshold `Ct = 401`, and all `44` standalone Lean 4 audit theorems.
7. **Volume 6 · `152`-Page Journal Paper Blueprint & Global Master Index**: **[English (`A06`)](./part_a_en/A06_Appendix_152p_Journal_Paper_Blueprint_And_Global_Master_Index.md)** · [Korean (`A06`)](./part_a/A06_부록_인간단축논문_재구성청사진_및_전역참조총색인.md) (`156` lines, `118` pins)
    - Section-by-section `152`-page journal paper blueprint, global symbol dictionary, Top 50 novel hubs, `30` main audit theorems, and the `8` classical translation adapters (`A1`..`A8`).
8. **Part B `100.00%` AST Signature Atlas (`atlas/volumes/B00`..`B10`)**: **[English Master Index (`B00.en`)](./atlas/volumes/B00_Master_Index_And_Hubs.en.md)** · [Korean Master Index (`B00`)](./atlas/volumes/B00_Master_Index_And_Hubs.md)
    - Complete Lean 4 AST signature, line-range, tactic, and `in_degree` index across `30,343` unique modules and `308,731 / 308,731` declarations (`100.00%`, `374,166` lines + 4 lossless JSONL databases and [atlas_summary.json](./atlas/data/atlas_summary.json)).

---

## Part II. Six-Volume Progressive Reader & Specialist Guide (`en/00`..`05` & `00`..`05`)

1. **[00_Executive_Overview_and_Map.md](./en/00_Executive_Overview_and_Map.md)** · [Korean (`00`)](./00_한눈에_보는_전체지도.md) (`All Readers · 3-Minute Map & Glossary`, [Figure 1](./figures/fig1_archive_breakdown_en.png))
2. **[01_Plain_Language_Analogy_Guide.md](./en/01_Plain_Language_Analogy_Guide.md)** · [Korean (`01`)](./01_수식없이_읽는_비유풀이.md) (`General Audience · Zero LaTeX Symbols`, $X = 10$ prime walkthrough & intuitive bridges)
3. **[02_Core_Principles_Five_Acts.md](./en/02_Core_Principles_Five_Acts.md)** · [Korean (`02`)](./02_눈으로_만지는_핵심원리_5막.md) (`Undergraduates & Engineers · Core Algebra + Toy Models`, [Figure 2](./figures/fig2_residual_vs_fake_zero_en.png), [Figure 3](./figures/fig3_lift_cost_barrier_en.png))
4. **[03_Lean_Code_Spine_Ledger.md](./en/03_Lean_Code_Spine_Ledger.md)** · [Korean (`03`)](./03_Lean코드_척추_해부원장.md) (`Formal-Methods Auditors · Line-Pinned Architecture` from `src/Main.lean:1-12` to `UnusedSlot` `2 + 7 = 9`)
5. **[04_Literature_195_Attribution_Dictionary.md](./en/04_Literature_195_Attribution_Dictionary.md)** · [Korean (`04`)](./04_기출대정리_원전복원사전.md) (`195 / 195 Classical Source Attribution Dictionary`, [literature_195_en.json](./data/literature_195_en.json))
6. **[05_Specialist_Referee_and_Equation_Audit.md](./en/05_Specialist_Referee_and_Equation_Audit.md)** · [Korean (`05`)](./05_전공자용_수론심층심사및수식복원서.md) (`Number Theorists & Referees · Deep Summary & OpenAI #003 Cross-Audit`, [Figure 4](./figures/fig4_vwin_parity_and_counts_en.png))

---

## Part III. Standalone Lean 4 Proof Suites (`61` Zero-Sorry Theorems) & QA Pipeline

- **[alpoge_ab_deep_audit.lean](./proofs/alpoge_ab_deep_audit.lean)**: `44` standalone zero-`sorry` `Lean 4` theorems (`30` main + `14` aux, `68` verified comment pins) proving arbitrary-length list Cauchy-Schwarz, strong-induction Legendre identities, Behrend 3-term determinant vanishing, and imprimitive Euler-factor isolation (`PASS`).
- **[alpoge_spine_arithmetic_audit.lean](./proofs/alpoge_spine_arithmetic_audit.lean)**: `17` standalone zero-`sorry` `Lean 4` theorems proving spine exponent, congruence, parity, `plusLen` consolidation, and global chain closure (`PASS`).
- **[verify_ab_project.py](./scripts/verify_ab_project.py)** and **[verify_guide_integrity.py](./scripts/verify_guide_integrity.py)**: Deterministic QA gates verifying all `3,740 + 68` `.lean:line` pins (`KO == EN` parity), `390 / 390` literature pins, all `4` HTML/PDF monographs, `MANIFEST.sha256` (`85` entries), and all `61` Lean theorems (`python3 -B scripts/verify_ab_project.py && python3 -B scripts/verify_guide_integrity.py`).
- **Reproducible Builders**:
    - Part A-B Suite: [build_part_b_atlas.py](./scripts/build_part_b_atlas.py), [generate_ab_figures.py](./scripts/generate_ab_figures.py), [build_ab_monograph.py](./scripts/build_ab_monograph.py).
    - 6-Volume Guide Suite: [extract_proof_anatomy.py](./scripts/extract_proof_anatomy.py), [build_04_dict.py](./scripts/build_04_dict.py), [prime_intuition_lab.py](./scripts/prime_intuition_lab.py), [generate_figures.py](./scripts/generate_figures.py), [build_typeset_book.py](./scripts/build_typeset_book.py).
