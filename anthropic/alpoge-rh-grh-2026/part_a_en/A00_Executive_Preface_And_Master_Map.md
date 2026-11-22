# Volume 0. Executive Preface and Master Part A-B Decompilation Map

## 0.1 Scope and Purpose of the Deep Decompilation Monograph (`Part A`) and 100.00% AST Formula Atlas (`Part B`)

This work delivers a complete mathematical decompilation of the entire novel proof engine and classical-literature interface inside the Riemann Hypothesis (RH) and Dirichlet Generalized Riemann Hypothesis (GRH) formalization archive released by Levent Alpöge and Claude (`175,187` `.lean` files, `17,374,215` lines, `1,061,425` total declarations including attributed and scoped items, `1,054,282` unattributed base declarations).

While an initial forensic pass established mechanical kernel compilation (`100.00%`) and mapped the `97` top-level specification spine files (`11,564` lines), rigorous academic peer review and human journal reconstruction required resolving three deeper problems:

1. Verifying directly against the pinned `Mathlib` (`0df444a3`) source code that the definitions of the Riemann zeta function and Dirichlet $L$-functions admit no semantic loopholes or vacuity at boundary cases ($s = 1$, negative even trivial zeros, modulus $N = 1$, and imprimitive Euler factors).
2. Auditing all `201` direct local imports of the classical-literature assembly hub (`Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/EveryCharacterOfLiteratureOfVWin.lean:1-814`) alongside all `1,073` files in `PublishedTheorems` folders to determine whether each `Prop` statement matches a standard textbook theorem verbatim or projects onto archive-specific structures and restricted loci.
3. Reconstructing the explicit human equations, global constant couplings, and weakened-Vandiver Iwasawa tower mechanisms hidden inside the **novel core proof body (`29,067` unique files, `4,224,608` lines, `300,415` declarations)** beneath the top-level `Statement*` leaves.

This package resolves all three tasks through a dual architecture:

- **Part A (7-Volume Academic Deep Decompilation Monograph, `A00`..`A06`)**: Audits the top-level kernel seal and `Mathlib` boundary semantics (`A01`), classifies all `201` direct literature imports and `1,073` `PublishedTheorems` modules (`A02`), decompiles the lower hubs and custom tactics of the 4 `Formalism` pillars spanning `2.58M` lines (`A03`), reconstructs the remaining `112` specialized `Formalism` subtheories (`623K` lines) and the acyclic global-constant closure (`A04`), dissects the `1.03M`-line `Pure_Vwin` Vandiver bypass and Behrend-Iwasawa tower alongside a standalone `44`-theorem Lean 4 audit suite (`A05`), and provides a section-by-section `152`-page human journal paper blueprint with `8` classical translation adapters (`A06`).
- **Part B (11-Volume 100.00% AST Signature Atlas, `B00`..`B10` + 4 JSONL Databases)**: Our deterministic parser (`scripts/build_part_b_atlas.py`) scans raw `.lean` source bytes - capturing anonymous `instance`, `scoped`, `local`, `@[...]`, and `(priority := ...)` modifiers - across the `29,067`-file novel union (`Formalism` `18,254` + `Pure_Vwin` `10,832`, overlap `19`) and `1,258` literature-boundary files, indexing **all `30,343` unique modules and `308,731 / 308,731` declarations (`100.00%`)** with exact line ranges, type signatures, `in_degree`, shortest `Main.lean` import distance, and tactic sets across `373,974` Markdown lines.

![Archive Stratification and Part A-B Decompilation Scope](../figures/fig_ab_01_archive_stratification_en.png)

---

## 0.2 Four-Layer Verification Status Ledger (As of `2026-11-22`)

To prevent conflating mechanical kernel compilation with human mathematical peer review, we separate the verification state into four distinct layers:

| Verification Layer | Target Population and Scope | Verification Method and Measured Result | Current Verdict |
| :--- | :--- | :--- | :--- |
| **Layer 1: Mechanical Kernel Compilation and Axiom Seal** | All `175,187` `.lean` files (`17,374,215` lines, `1,030.53 MB`) | Clean build under `leanprover/lean4:v4.33.1` on both `x86_64` and `aarch64`; `#print axioms` on all 5 main theorems in `Main.lean:4-12` outputs only the 3 standard Lean axioms (`0` `sorryAx`); cross-checked by independent kernels (`nanoda`, `con-leche`, `con-ron`, `lean4lean`) | **Verified (`PASS`)** |
| **Layer 2: Top-Level Specification and `Mathlib` Boundary Semantics** | `Main.lean`, `Statements.lean`, `Supplements/*`, and pinned `Mathlib` (`0df444a3`) zeta and $L$-series definitions | Unmodified `_root_.RiemannHypothesis` confirmed; Volume 1 (`A01`) audits the $s=1$ division-by-zero value, negative even trivial zeros, $N=1$ modulus, and imprimitive Euler factors directly in `Mathlib` source | **Source Audit Complete (`PASS`)** |
| **Layer 3: Novel Proof Engine (`4.22M` Lines) and Classical Boundary (`1,258` Files)** | `Formalism` (`18,254`) $\cup$ `Pure_Vwin` (`10,832`) $\cup$ `PublishedTheorems` and `201` imports (`1,258`) = `30,343` unique modules (`308,731` declarations) | **Part B** extracts `100.00%` (`308,731 / 308,731`) AST signatures; **Part A** (`A02`..`A06`) reconstructs core high-`in_degree` hubs, global constant DAG, and Vandiver patching equations, backed by `44` standalone Lean 4 theorems | **A+B Decompilation Complete** (leaf tactic files summarized via hub chains) |
| **Layer 4: Lower Classical Re-Proof Cone and Academic Peer Review** | Lower re-formalization of classical algebraic geometry and automorphic representation theory (`144,844` files, `13,030,043` lines, including `24.18%` kernel-unused declarations) | Soundness of `Main.lean` is guaranteed by the Lean kernel, while line-by-line human reading of classical re-proofs is omitted; specialist peer review in analytic number theory and automorphic forms (including CMI criteria) remains underway | **Kernel Passed / Peer Review Ongoing (`ONGOING`)** |

---

## 0.3 Quantitative Ledger: Whole Archive vs. Novel Decompilation Cone

The exact share of the novel proof engine and classical-literature elimination cone within all `175,187` files (`17,374,215` lines) is tabulated below under the unified AST header rule (capturing `@[...]`, `scoped`, `local`, and anonymous `instance` declarations):

| Stratum / Subcone | Unique Files | Source Lines (% of Archive) | Extracted Decls | Theorems (`theorem`/`lemma`) | Defs / Structs / Instances | Corresponding Volumes (`Part A` / `Part B`) |
| :--- | ---: | ---: | ---: | ---: | ---: | :--- |
| **`Formalism.LocalToGlobal`** (Pillar 1) | `5,501` | `955,843` (`5.50%`) | `73,273` | `49,840` | `23,433` | `A03` Ch. 2 / `B01` |
| **`Formalism.SharpRestriction`** (Pillar 2) | `3,093` | `709,436` (`4.08%`) | `54,648` | `33,822` | `20,826` | `A03` Ch. 3 / `B02` |
| **`Formalism.HermitianCurvature`** (Pillar 3) | `1,922` | `460,802` (`2.65%`) | `35,958` | `28,075` | `7,883` | `A03` Ch. 4 / `B03` |
| **`Formalism.PeriodIntegrals`** (Pillar 4) | `4,350` | `451,856` (`2.60%`) | `32,699` | `23,534` | `9,165` | `A03` Ch. 5 / `B04` |
| **`Formalism` `112` Specialized Subtheories** | `3,388` | `622,811` (`3.58%`) | `43,521` | `26,847` | `16,674` | `A04` All / `B05` |
| *Subtotal: Entire `Formalism` Namespace* | *`18,254`* | *`3,200,748` (`18.42%`)* | *`240,099`* | *`162,118`* | *`77,981`* | *`A03` · `A04` / `B01`..`B05`* |
| **`Pure_Vwin`: `AutomorphicVarieties`** | `3,747` | `409,549` (`2.36%`) | `22,661` | `17,762` | `4,899` | `A05` Ch. 3 / `B06` |
| **`Pure_Vwin`: `Foundations` and Hecke** | `1,895` | `198,417` (`1.14%`) | `11,530` | `9,196` | `2,334` | `A05` Ch. 2 / `B07` |
| **`Pure_Vwin`: Abelian, Spectrum, Positivity** | `5,190` | `421,515` (`2.43%`) | `27,018` | `20,783` | `6,235` | `A05` Ch. 4 / `B08` |
| *Subtotal: Novel Union (`Formalism ∪ Pure_Vwin`, minus `19` shared)* | **`29,067`** | **`4,224,608` (`24.32%`)** | **`300,415`** | **`209,793`** | **`90,622`** | *`A03`..`A05` / `B01`..`B08`* |
| **`PublishedTheorems` (`1,073`) $\cup$ `201` Direct Imports** | `1,258` | `119,064` (`0.69%`) | `8,243` | `5,799` | `2,444` | `A02` All / `B09` |
| **Top Spine (`Main` Distance `0`..`4`) and Build Bridges** | `43` | `2,318` (`0.01%`) | `192` | `145` | `47` | `A01` All / `B10` |
| **Part B 100.00% AST Atlas Unique Total** | **`30,343`** | **`4,344,172` (`25.00%`)** | **`308,731`** | **`215,675`** | **`93,056`** | **All (`A01`..`A06` / `B00`..`B10`)** |
| **Lower Classical Re-Proof and Unused Declarations** | `144,844` | `13,030,043` (`75.00%`) | `752,694` | `603,080` | `149,614` | Kernel Verified (`Part B` omitted) |
| **Whole Archive Grand Total** | **`175,187`** | **`17,374,215` (`100.00%`)** | **`1,061,425`** | **`818,755`** | **`242,670`** | **Full Kernel Build Passed** |

![Top 16 Novel Formalism Subtheories by Code Volume and Theorems](../figures/fig_ab_02_formalism_subtheories_en.png)

---

## 0.4 Three Macroscopic Forensic Discoveries from the Full AST Scan

### 1. Extreme Hub Concentration (`in_degree` Power-Law Topology)
The `29,067` novel modules are not flatly dispersed; they funnel into a small set of algebraic and local-arithmetic master hubs. The #1 most-imported module across the entire novel cone is `Formalism/LocalRingCardinality/RhoDetPrimeEqMuTildeMulChiPow.lean` (`in_degree = 921`, `393` lines), which binds the master 7-tuple datum `D7` and dual determinant-character identities; #2 is chart-independent generator power uniqueness `Formalism/SharpRestriction/Divisibility/GeneratorPowers/ThExprUniqOfChartIndep2.lean` (`in_degree = 873`, `41` lines); #3 is adic-completion local tying `Formalism/LocalRingCardinality/AdicCompletionLocal/LocTied.lean` (`in_degree = 776`, `38` lines). Within the classical specification boundary (`B09`), cusp-form rapid decay `Development/AbelianVarietyTheory/PublishedTheorems/AutomorphicForms₂/ExistsNormLeHeightPow.lean` is directly imported by `2,460` modules, the refactoring compatibility stub `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/CohomologicalCsdTempered.lean` by `2,242` modules, and Harish-Chandra module analyticity `Development/AbelianVarietyTheory/PublishedTheorems/TwistedTraceFormula/HarishChandraModulesOn.lean` by `1,684` modules.

![Top 18 Most-Imported Core Hub Modules Across the Novel Cone](../figures/fig_ab_03_top_hubs_indegree_en.png)

### 2. Deterministic Low-Cost Tactic Engineering (`aesop` Used in Only `0.0033%` of Declarations)
Across all `300,415` novel declarations, the automated search tactic `aesop` appears in **only `10` declarations (`0.0033%`)**. Instead, proof scripts rely overwhelmingly on explicit rewriting `rw` (`131,455` declarations, `43.76%`), direct witness closing `exact` (`105,439`, `35.10%`), restricted `simp` normalization (`86,837`, `28.91%`), structural skeleton refinement `refine` (`62,588`, `20.83%`), record destructuring `obtain` (`50,817`, `16.92%`), extensionality `ext` (`29,843`, `9.93%`), polynomial ring identities `ring` (`22,853`, `7.61%`), and Presburger arithmetic `omega` (`19,322`, `6.43%`). To prevent `maxHeartbeats` timeouts across a `17.37M`-line build, the generation pipeline systematically replaced proof search with fine-grained lemma decomposition and explicit `rw` + `exact` witness terms.

![Tactic Usage Distribution Across 300,415 Novel Declarations](../figures/fig_ab_04_tactic_anatomy_en.png)

### 3. Disentangling `EveryCharacterOfLiteratureOfVWin` from `Formalism`
Naive file-level `import` traversal shows `18,223` `Formalism` files inside the transitive dependency cone (`151,286` files) of `EveryCharacterOfLiteratureOfVWin.lean`. Our AST trace explains why: `EveryCharacterOfLiteratureOfVWin.lean` is not a pure list of classical axioms, but the **top-level welder** that imports the conditional main theorem `Development/AutomorphicArithmetic/CharacterBoxes/RiemannHypothesisOfEveryCharacter.lean` (whose `102,080`-file cone includes `17,943` `Formalism` files) alongside `EveryCharacterE.lean` (`17,998` `Formalism` files) and `SiegelEisensteinSecondTermHypotheses.lean` (`18,148` `Formalism` files) and plugs discharged literature witnesses into their hypothesis slots. Consequently, the true novel proof cone is the union `Formalism` (`18,254`) $\cup$ `Pure_Vwin_Outside_Literature` (`10,832`), yielding `29,067` unique modules (`4,224,608` lines).

---

## 0.5 Reader Cross-Reference Map: Part A Monograph to Part B AST Atlas

When reading the mathematical derivations in `Part A`, consult the corresponding `atlas/volumes/` volume below to inspect every declaration signature and line range in any referenced module:

| Monograph Volume (`Part A`) | Core Decompilation Topic | Linked 100.00% AST Atlas Volume (`Part B`) & Audit Code |
| :--- | :--- | :--- |
| **Volume 1 (`A01`)** | `Main.lean` · `Statements.lean` seal, `8` metaprogramming files, pinned `Mathlib` zeta and Dirichlet $L$-series boundary semantics, top `43` bridges | `atlas/volumes/B10_Top_Spine_Depth0_To_4.md` |
| **Volume 2 (`A02`)** | Full `201 / 201` classification of `EveryCharacterOfLiteratureOfVWin` imports and semantic equivalence audit of `1,073` `PublishedTheorems` modules | `atlas/volumes/B09_PublishedTheorems_1073_And_201_Imports.md` |
| **Volume 3 (`A03`)** | Deep hub and tactic decompilation of the 4 `Formalism` pillars (`LocalToGlobal`, `SharpRestriction`, `HermitianCurvature`, `PeriodIntegrals`, `2.58M` lines) | `B01` · `B02` · `B03` · `B04` (`14,866` files, `196,578` declarations) |
| **Volume 4 (`A04`)** | Six-cluster decompilation of the `112` specialized `Formalism` subtheories (`623K` lines), Arakelov product formula, and acyclic global-constant closure | `atlas/volumes/B05_Formalism_Specialized_Subtheories.md` (`3,388` files) |
| **Volume 5 (`A05`)** | `Pure_Vwin` (`1.03M` lines) weakened-Vandiver dual-wing patching, Behrend-Iwasawa tower, threshold `Ct = 401`, and `44`-theorem standalone Lean 4 suite | `B06` · `B07` · `B08` and `proofs/alpoge_ab_deep_audit.lean` |
| **Volume 6 (`A06`)** | `152`-page human journal paper blueprint, global symbol dictionary, Top 50 hubs, `30` main audit theorems, and `8` translation adapters (`A1`..`A8`) | `atlas/volumes/B00_Master_Index_And_Hubs.en.md` |
