# Deep Mathematical Decompilation of the 17.37M-Line Alpöge-Claude RH & GRH Formal Proof (`Part A` + `Part B`)

> **Language**: **English** | [**Korean (`README.md`)**](./README.md)

- **Release & Audit Date**: `2026-11-22`
- **Audited Upstream Archive**: Levent Alpöge & Claude (Anthropic), `175,187` `.lean` files (`17,374,215` lines, `1,030.53 MB`, `1,061,425` total declarations · `1,054,282` unattributed base declarations, `leanprover/lean4:v4.33.1`, pinned `mathlib4` `0df444a3`)

---

## 1. Package Overview (`Part A` Academic Monographs + `Part B` 100.00% AST Formula Atlas)

| Component | Directory / Deliverable | Measured Scale | Description |
| :--- | :--- | :--- | :--- |
| **Part A English Monograph** | [`book/Alpoge_RH_AB_Deep_Decompilation_EN.pdf`](./book/Alpoge_RH_AB_Deep_Decompilation_EN.pdf) (`.html`) | **Print-ready `148`-page A4 PDF** (`19.30 MB`, `4` embedded English figures) | Full mathematical reconstruction of the `4.22M`-line novel proof engine, pinned `Mathlib` boundary semantics, `201` classical import audit, and `152`-page journal paper blueprint |
| **Part A Korean Monograph** | [`book/알푀게_리만가설_신작증명_심층해독단행본_AB.pdf`](./book/알푀게_리만가설_신작증명_심층해독단행본_AB.pdf) (`.html`) | **Print-ready `132`-page A4 PDF** (`19.23 MB`, `4` Korean figures) | Complete Korean academic monograph (`Part A` Volumes `A00`..`A06`) |
| **Part A English Manuscripts** | `part_a_en/A00` .. `A06` (`7` volumes) | **`5,427` lines** · **`1,870` verified exact `.lean:line` pins** (`0` errors, `100.00%` parity with Korean edition) | Unabridged 1-to-1 English edition of Volumes `A00` through `A06` |
| **Part A Korean Manuscripts** | `part_a/A00` .. `A06` (`7` volumes) | **`5,618` lines** · **`1,870` verified exact `.lean:line` pins** (`0` errors) | Korean source volumes `A00` through `A06` |
| **Part B AST Signature Atlas** | `atlas/volumes/B00` .. `B10` + [`B00_Master_Index_And_Hubs.en.md`](./atlas/volumes/B00_Master_Index_And_Hubs.en.md) | **`374,166` lines** · **`30,343` unique modules** · **`308,731 / 308,731` declarations (`100.00%`)** | Complete Lean 4 AST signature, line-range, tactic, and `in_degree` index across `Formalism` (`18,254`), `Pure_Vwin` (`10,832`), `PublishedTheorems` (`1,073`), and `201` direct imports |
| **Part B JSONL Databases** | `atlas/data/*.jsonl` (`4` files) + `atlas_summary.json` | `30,343` module records (`JSONL`) | Lossless machine-queryable AST declaration and dependency ledgers |
| **Standalone Lean 4 Audit Suite** | [`proofs/alpoge_ab_deep_audit.lean`](./proofs/alpoge_ab_deep_audit.lean) | **`1,143` lines** · **`44` zero-sorry theorems** (`30` main + `14` aux, zero user-added axioms) | Pure Lean 4 core verification of critical arithmetic, Cauchy-Schwarz, Legendre, and Behrend identities (`68` verified comment pins) |
| **Build & QA Pipeline** | `scripts/` (`4` scripts) | Deterministic Python 3 (`sys.dont_write_bytecode = True`) | `build_part_b_atlas.py`, `generate_ab_figures.py`, `build_ab_monograph.py`, `verify_ab_project.py` |

---

## 2. Part A Volume-by-Volume Index (`part_a_en/` & `part_a/`)

1. **[`A00_Executive_Preface_And_Master_Map.md`](./part_a_en/A00_Executive_Preface_And_Master_Map.md)** (`89` lines, `2` pins): Four-layer verification separation ledger, quantitative stratification of the `29,067`-module (`300,415`-declaration) novel union, `in_degree` power-law hub concentration, and deterministic tactic profile (`aesop` `0.0033%`).
2. **[`A01_Top_Seal_Mathlib_Boundary_Semantics_And_Upper_Bridge_Audit.md`](./part_a_en/A01_Top_Seal_Mathlib_Boundary_Semantics_And_Upper_Bridge_Audit.md)** (`816` lines, `391` pins): Closed-proposition soundness of `Main.lean` and `Statements.lean`, forensic audit of all `8` metaprogramming files (`allowUnsafeReducibility` across `33` unique files / `37` hits), source-level `Mathlib` zeta ($s=1$ division-by-zero value, $s=0$, trivial zeros) and Dirichlet $L$-series ($N=1$, imprimitive Euler factors at $\operatorname{Re}(s)=0$) proofs, and dissection of the top `43` bridges.
3. **[`A02_Classical_201_Imports_And_PublishedTheorems_Semantic_Equivalence_Audit.md`](./part_a_en/A02_Classical_201_Imports_And_PublishedTheorems_Semantic_Equivalence_Audit.md)** (`1,113` lines, `417` pins): Exhaustive `201 / 201` semantic classification of `EveryCharacterOfLiteratureOfVWin.lean` local imports (`127` Type I, `44` Type II-A, `11` Type II-B, `19` assembly/adapters) and source-equation reconstruction across `PublishedTheorems` (`1,073` files).
4. **[`A03_Formalism_Four_Pillars_Lower_Tactics_And_Core_Hubs_Decompilation.md`](./part_a_en/A03_Formalism_Four_Pillars_Lower_Tactics_And_Core_Hubs_Decompilation.md)** (`1,198` lines, `315` pins): Line-by-line hub decompilation across `LocalToGlobal` (`956K` lines), `SharpRestriction` (`709K` lines), `HermitianCurvature` (`461K` lines), and `PeriodIntegrals` (`452K` lines), reconstructing the triple cancellation that breaks the $\sigma = 2/3$ level-denominator barrier.
5. **[`A04_Formalism_112_Specialized_Subtheories_And_Global_Constant_Closure.md`](./part_a_en/A04_Formalism_112_Specialized_Subtheories_And_Global_Constant_Closure.md)** (`989` lines, `334` pins): Six-cluster reconstruction of all `112` specialized subtheories (`43,521` declarations, led by `RhoDetPrimeEqMuTildeMulChiPow.lean` at `in_degree = 921`) and verification of the acyclic quantifier DAG from `ShapeWin` $(C_{\mathrm{abs}}, C_0, e_D, e_L) = (2, 3, 2, 0)$ through `CoreGm` ($1/2 + 9\varepsilon$) and `landauWindow`.
6. **[`A05_PureVwin_Vandiver_Bypass_Behrend_Tower_And_Formal_Audit_Suite.md`](./part_a_en/A05_PureVwin_Vandiver_Bypass_Behrend_Tower_And_Formal_Audit_Suite.md)** (`1,066` lines, `293` pins): Decompilation of `Pure_Vwin` (`10,832` files, `1.03M` lines, `61,209` declarations), weakened-Vandiver odd/even parity patching, `LiteratureRankNHypothesis` (`56` slots = `50` literature + `6` novel), Behrend-Iwasawa towers, threshold `Ct = 401`, and all `44` standalone Lean 4 audit theorems.
7. **[`A06_Appendix_152p_Journal_Paper_Blueprint_And_Global_Master_Index.md`](./part_a_en/A06_Appendix_152p_Journal_Paper_Blueprint_And_Global_Master_Index.md)** (`156` lines, `118` pins): Section-by-section `152`-page journal paper blueprint, global symbol dictionary, Top 50 novel hubs, `30` main audit theorems, and the `8` classical translation adapters (`A1`..`A8`).

---

## 3. One-Command Reproduction and Integrity Verification

```bash
# 1. Rebuild Part B 30,343-module · 308,731-declaration (100.00%) AST Atlas (KO + EN B00 index)
python3 -B scripts/build_part_b_atlas.py

# 2. Regenerate all 8 measured high-DPI figures (4 Korean + 4 English)
python3 -B scripts/generate_ab_figures.py

# 3. Build both Korean and English Part A HTML & print-ready A4 PDF monographs
python3 -B scripts/build_ab_monograph.py

# 4. Run full QA gate (KO + EN 1,870x2 + 68 .lean:line pins, KO==EN pin parity, HTML checks, MANIFEST, 44 Lean thms)
python3 -B scripts/verify_ab_project.py
```
