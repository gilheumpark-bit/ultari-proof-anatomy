# Part II. Direct Imports of 201 Classical Theorems and Semantic Equivalence Audit of PublishedTheorems (1,073 Modules)

- **Target Scope**: Covers `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/EveryCharacterOfLiteratureOfVWin.lean:1-814`, all `201` direct local imports (`12,171` lines), all `1,073` files in the archive-wide `PublishedTheorems` layer (`107,246` lines), and the entire top-level unconditional welding module `Development/AutomorphicArithmetic/CharacterBoxes/MainConclusion.lean:1-14`.
- **Linked Exhaustive Atlas**: Paired one-to-one with Part B Volume 9 (`atlas/volumes/B09_PublishedTheorems_1073_And_201_Imports.md`, `1,258` unique modules, `119,064` lines, `8,243` declarations) and the `atlas/data/published_theorems_and_201_imports.jsonl` database.
- **Core Audit Objective**: Moving beyond the preliminary concordance (`195` entries) that stopped at identifier-level comparison, this audit reverse-translates the actual `Prop` definitions in the underlying `.lean` source files into mathematical formulas and exhaustively distinguishes **Type I propositions** (one-to-one equivalent to the classical original papers) from **Type II specialized propositions** (projected onto archive-specific data structures or sub-loci).

---

## Chapter 1. Quantitative Anatomy of the Classical Literature Elimination Architecture (`EveryCharacterOfLiteratureOfVWin.lean` and `1,073` `PublishedTheorems` Modules)

### 1.1 Two-Stage Hypothesis Elimination Structure of `EveryCharacterOfLiteratureOfVWin.lean` and `MainConclusion.lean`

The formal proof archive of the Riemann Hypothesis by Levent Alpöge and Claude (`175,187` files, `17,374,215` lines) adopts an architecture that eliminates the major classical theorems of modern number theory, algebraic geometry, and automorphic representation theory by reproving them internally over pure `Mathlib` rather than leaving them as external axioms (`axiom`).
The single welding point where this vast literature-elimination effort meets the new zero-elimination engine (`UpperTheory.Top.VWin`) is `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/EveryCharacterOfLiteratureOfVWin.lean:1-814`.
Across the entire archive, this file is imported by only a single upstream module, `Development/AutomorphicArithmetic/CharacterBoxes/MainConclusion.lean:1` (`in_degree = 1`, `out_degree = 201`, shortest distance `5` from `Main`), and its `814` lines partition cleanly into four layers.

1. **Import Header Layer (`L1-208`)**: Consists of `208` `import` statements in total. Excluding the `7` lines of external standard library imports at `L62` (`Mathlib`) and `L138-143` (`6` modules in `Mathlib.Analysis.*` covering complex Liouville theory and derivatives of power, logarithm, and exponential functions), exactly **`201` archive-internal local modules (`12,171` lines)** are directly invoked.
2. **Deferred Literature Record Definition (`L215-218`)**: Declares the `Prop` structure `UpperTheory.LiteratureTheorems.OpenLiteratureStatements` holding three top-level representation-theoretic and Galois specifications in order to prevent circular imports.
3. **Individual Classical Witness Wrappers (`L219-588`)**: Contains `185` numbered `theorem` declarations. Although each theorem formally accepts `(O : OpenLiteratureStatements)` as an argument, an exhaustive inspection of the proof terms reveals that **`177` out of `185` (`176` active classical witnesses plus the inactive slot `siegel_eisenstein_simple_pole : UnusedSlot72 := trivial` at `L505-506`) never reference `O` at all**, returning unconditional theorems (`*_holds`, `PositivityTheory.*`, `GlobalTheory.*`, `CompanionTheory.*`) supplied by the `201` imported modules. Only **`8` theorems** (`L283`, `L285`, `L313`, `L389`, `L421`, `L423`, `L459`, `L461`) belonging to local Langlands existence and the polarized Galois correspondence chain project fields of `O` directly or indirectly.
4. **Nine Higher-Level Hypothesis Bundle Assemblers and the Top-Level Combined Master Theorem (`L589-814`)**: Nine assembly theorems at `L589-809` package the individual classical wrappers into large domain-specific `Prop` structures (`LocalRepresentationTheoryHypothesesAlt` with `19` fields, `GlobalAutomorphicGaloisHypotheses'` with `16` fields, `LitCoh` with `12` fields, `NonEndoscopicHypothesesAlt` with `5` fields, `GeometricGaloisRepCompatibility` with `12` fields, `NLink.Hypotheses₂` with `7` fields, `UnitaryGroupThirdPlaceHypotheses` with `60` fields, `ThetaLocalInputs` with `53` fields, and `PublishedHodgeBundleTheorems` with `28` fields).
Finally, the master theorem `every_character_of_literature_of_vWin` at `L810-813` feeds these hypothesis bundles together with the new window theorem `hV : UpperTheory.Top.VWin` into `every_character_of_theta_integrals_local_matching` from `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/SiegelEisensteinSecondTermHypotheses.lean:69-73`, deriving the right-half-plane zero-free proposition `UpperTheory.EveryCharacter` for all Dirichlet $L$-functions.

```lean
-- Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/EveryCharacterOfLiteratureOfVWin.lean:215-218
structure UpperTheory.LiteratureTheorems.OpenLiteratureStatements : Prop where
  caraianiLocalGlobalDual : _root_.UpperTheory.One.M.Row
  localLanglandsExists : _root_.UpperTheory.Zero.LLC.RecTExists
  galoisRepOfPolarizedPairLit : _root_.UpperTheory.One.M.Row

-- Development/AutomorphicArithmetic/CharacterBoxes/MainConclusion.lean:7-14
theorem UpperTheory.FinalTheorems.everyCharacter_of_row
    (h : UpperTheory.GalStar.Row0b fun h rc => UpperTheory.Zero.LLC.IsRecT h rc) : UpperTheory.EveryCharacter :=
  UpperTheory.LiteratureTheorems.every_character_of_literature_of_vWin
    ⟨h, UpperTheory.Zero.LLC.recTExists, h⟩ (UpperTheory.One.vwin_of_row h)

theorem UpperTheory.FinalTheorems.everyCharacter : UpperTheory.EveryCharacter :=
  UpperTheory.FinalTheorems.everyCharacter_of_row UpperTheory.Gal.Int.galoisLocalGlobalStrong_recParameter

theorem UpperTheory.FinalTheorems.riemannHypothesis : RiemannHypothesis :=
  UpperTheory.riemannHypothesis_of_everyCharacter UpperTheory.FinalTheorems.everyCharacter
```

As shown in the code above, the final closure in which external hypotheses drop to `0` is completed in `Development/AutomorphicArithmetic/CharacterBoxes/MainConclusion.lean:7-14`.
First, in `Development/AutomorphicArithmetic/Foundations/UnitarySphericalFixing/SatakeParameters/RecT.lean:4-6`, `_root_.UpperTheory.One.M.Row` is a definitional alias (`def`) for `UpperTheory.GalStar.Row0b recT`, so the first and third fields of `OpenLiteratureStatements` share the exact same proposition type.
Second, the second field `RecTExists` is filled by the unconditional theorem `UpperTheory.Zero.LLC.recTExists` in `Development/AutomorphicArithmetic/Foundations/LocalLanglands/LocalCentralUnits/RecTExists.lean:20-66`.
Third, the single remaining parameter `h : Row0b recT` is discharged simultaneously by the unconditional theorem `galoisLocalGlobalStrong_recParameter` from `Development/AutomorphicArithmetic/Foundations/GaloisRepresentations/IntegralStructures/RowSrc.lean:6`, proved via the theta-Parseval kernel lift, thereby closing every premise of both `O` and `hV := UpperTheory.One.vwin_of_row h` in one step.
Specializing the proposition in `Development/AutomorphicArithmetic/CharacterBoxes/EveryCharacter.lean:13-14`,

$$
\mathrm{EveryCharacter} \iff \forall N \ge 1,\; \forall \chi \bmod N,\; \forall s \in \mathbb{C},\quad \mathrm{Re}(s) > \frac{1}{2} \implies (\chi \neq 1 \lor s \neq 1) \implies L(s, \chi) \neq 0
$$

to the trivial character modulo $N = 1$ and applying the functional symmetry $\Lambda(s) = \Lambda(1 - s)$ of the completed zeta function together with pole analysis of the gamma factor $\Gamma_{\mathbb{R}}(s)$ in `Development/AutomorphicArithmetic/CharacterBoxes/RiemannHypothesisOfEveryCharacter.lean:211-231` seals the five top-level theorems of `Supplements/Kernels/MainTheorems.lean:7-16` and `Main.lean:4-12` free of any hypotheses.

---

### 1.2 Quantitative Distribution and Citation Hubs Across `1,073` `PublishedTheorems` Files and `201` Direct Imports

Within the archive, the module population directly tied to classical theorem specifications divides into two principal sets. The first consists of the **`1,073` specification and lemma files (`107,246` lines)** whose module path contains the identifier `PublishedTheorems`, and the second consists of the **`201` local imports (`12,171` lines)** directly invoked by `EveryCharacterOfLiteratureOfVWin.lean`. Their intersection comprises `17` modules; adding the central integration module `EveryCharacterOfLiteratureOfVWin.lean` (`814` lines) yields the exact unique module count cataloged in Part B Volume 9 (`B09`),

$$
N_{\mathrm{B09}} = 1{,}073 + 201 - 17 + 1 = 1{,}258\text{ files} \quad (119{,}064\text{ lines, } 5{,}799\text{ theorems, } 2{,}426\text{ definitions and structures})
$$

with zero discrepancy down to a single line. The distribution of the `1,073` `PublishedTheorems` files across top-level namespaces and major subdirectories is summarized in the table below.

| `PublishedTheorems` Top-Level Path and Core Sub-Branches | Files | Code Lines | Theorems | Defs / Structs | Representative Specification Domains |
| :--- | ---: | ---: | ---: | ---: | :--- |
| **`Development.WeilBound.CoreStatements.PublishedTheorems`** | **`540`** | **`48,718`** | **`2,202`** | **`557`** | Nadel vanishing (`197`), Jacquet-Shalika (`73`), Poitou-Tate (`64`), Casselman-Wallach (`63`), global Euler (`42`), smooth vectors (`42`) |
| **`Development.AbelianVarietyTheory.PublishedTheorems`** | **`493`** | **`56,194`** | **`2,744`** | **`1,632`** | Divisors, deformation, Hodge (`Divisors₂` `152`), twisted trace and real groups (`97`), Galois cohomology (`80`), automorphic forms (`52`), Galois geometry (`46`), Siegel-Weil (`18`) |
| **`Development.AutomorphicSpectrum.PublishedTheorems`** | **`23`** | **`1,543`** | **`43`** | **`75`** | Complex GAGA (`Geometry₂` `5`), global Linnik and spectrum (`5`), algebra, metrics, separability, jets (`13`) |
| **`Development.AutomorphicArithmetic.AutomorphicVarieties.*`** | **`13`** | **`685`** | **`0`** | **`73`** | `PublishedTheorems` (`10`), `LocalPublishedTheorems` (`1`), `HeightAndVanishing` (`1`), `MixedUnitPublishedTheorems` (`1`) |
| **`PositivityTheory.PublishedTheorems`** | **`3`** | **`105`** | **`4`** | **`0`** | Idempotent unit killing (`UnitKilling`), tower lemmas (`TowerLemmas`), Weil representation core (`WeilRepresentations`) |
| **`CompanionTheory.EightfoldTheory.VariationTheory.PublishedTheorems`** | **`1`** | **`1`** | **`0`** | **`0`** | Variation theory import bridge (`ImportsAlt.lean`) |
| **`PublishedTheorems` Total** | **`1,073`** | **`107,246`** | **`4,993`** | **`2,337`** | **Archive-wide classical specifications and immediate corollary pool** |

Meanwhile, the architectural breakdown of the `201` local imports (`12,171` lines) directly invoked by `EveryCharacterOfLiteratureOfVWin.lean` consists of `79` modules in `Development.AbelianVarietyTheory.Proofs` (`39.30%`, `5,516` lines), `70` modules in `Development.WeilBound` (`34.83%`: `57` in `CoreStatements` + `12` in `RepresentationTheoryGL` + `1` in `ThetaLifts`, `3,240` lines), `33` modules in `Development.AutomorphicArithmetic` (`16.42%`: `27` in `ThetaCorrespondence` + `4` in `Foundations` + `1` in `AutomorphicVarieties` + `1` in `CharacterBoxes`, `1,511` lines), `8` modules in external foundational trees (`3.98%`: `6` in `CompanionTheory` + `1` in `GroundTheory` + `1` in `DiscreteGroups`, `530` lines), `6` direct imports from `AbelianVarietyTheory.PublishedTheorems` (`2.99%`, `891` lines), and `5` modules in `AutomorphicSpectrum` (`2.49%`, `483` lines).
This division reflects the fact that `PublishedTheorems` directories define the **target specifications (`def ... : Prop`) and immediate corollaries** of classical theorems, whereas `EveryCharacterOfLiteratureOfVWin.lean` imports and welds the **top-level witness theorems (`*_holds`)** from the underlying `Proofs` and `CoreStatements` trees that discharge those specifications.

The table below extracts the top `15` core hub modules ranked by archive-wide citation count (`in_degree`) across the entire `1,258`-module classical boundary population.

| Rank | Module Path Relative to `src/` and Line Count | Citations (`in_degree`) | Distance to `Main` | Core Declarations and Role in the Archive | Equivalence Type |
| :---: | :--- | ---: | :---: | :--- | :---: |
| `1` | `Development/AbelianVarietyTheory/PublishedTheorems/AutomorphicForms₂/ExistsNormLeHeightPow.lean:18-33` (`114` lines) | `2,460` | `7` | `quotHeight`, `IsRapidDecay`, `CuspRapidDecay`, Petersson inner-product integrability | Type II-A |
| `2` | `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/CohomologicalCsdTempered.lean:1` (`1` line) | `2,242` | `6` | Single-line `import Mathlib` refactoring compatibility stub (former hypothesis hub fossil) | Assembly / Adapter |
| `3` | `Development/AbelianVarietyTheory/PublishedTheorems/TwistedTraceFormula/HarishChandraModulesOn.lean:18-45` (`211` lines) | `1,684` | `7` | `HarishChandraModulesOn`, `KFiniteAnalyticUJ`, $U(p,q)$ cover $(\mathfrak{g},K)$-modules | Type II-A |
| `4` | `Development/AbelianVarietyTheory/PublishedTheorems/TwistedTraceFormula/AdmissibleDiscreteSeriesOfHasParam.lean:16-39` (`267` lines) | `1,354` | `7` | `DiscreteSeriesCover`, Blattner cone `InCone`, Vogan inequality `vogan_add_le` | Type II-A |
| `5` | `Development/AbelianVarietyTheory/PublishedTheorems/AutomorphicForms₂/HasDRepIffHasDerivAt.lean:19-112` (`115` lines) | `1,051` | `7` | `IsSmoothModRep`, `sobNorm`, `CasselmanWallach` smooth completion specification | Type II-A |
| `6` | `Development/AbelianVarietyTheory/PublishedTheorems/Divisors₂/GeometricallyConnectedOfIsIsoRestrict.lean:13-126` (`129` lines) | `937` | `6` | Smooth blowup sequence `IsSmoothBlowupSeq` and Hironaka `Principalisation` | Type I |
| `7` | `Development/AbelianVarietyTheory/PublishedTheorems/GaloisGeometry₂/HoweUnram.lean:8-20` (`23` lines) | `885` | `7` | Unramified unitary dual-pair spherical Howe duality `HoweUnram` specification | Type II-A |
| `8` | `Development/AbelianVarietyTheory/PublishedTheorems/Divisors₂/CrysToDRBijective.lean:24-87` (`90` lines) | `859` | `6` | Abelian scheme de Rham cohomology `AbelianDeRham` and crystalline-de Rham bijection `Rigid` | Type I |
| `9` | `Development/AbelianVarietyTheory/PublishedTheorems/AutomorphicForms₂/HarishChandraFinite.lean:39-59` (`145` lines) | `814` | `6` | Finite-dimensionality `HarishChandraFinite` of automorphic forms at fixed level, $K$-type, and Gelfand eigenvalues | Type II-A |
| `10` | `Development/AbelianVarietyTheory/PublishedTheorems/Divisors₂/ExistsCrystalPairing.lean:25-129` (`135` lines) | `812` | `5` | `DualAbelianScheme`, `CrystallineDeRham`, uniqueness of polarized crystal pairing | Type I |
| `11` | `Development/AbelianVarietyTheory/PublishedTheorems/AutomorphicForms₂/WeilRepresentationUnitaryPair.lean:12-16` (`19` lines) | `780` | `6` | Unitary Weil representation `WeilRepresentationUnitaryPair` over `D7` Hermitian pairs $(S,T)$ | Type II-A |
| `12` | `Development/AutomorphicArithmetic/Foundations/LocalLanglands/IsRecTOfIsRec.lean:20-85` (`116` lines) | `775` | `6` | Strengthened local Langlands `LawsT`, `IsRecT`, `RecTExists` on the `GoodCusp` depth-`0` locus | Type II-B |
| `13` | `Development/AbelianVarietyTheory/PublishedTheorems/AutomorphicForms₂/MumfordConstruction.lean:11-22` (`23` lines) | `768` | `14` | Degenerating semi-abelian lattice quotient `MumfordConstruction` over complete local rings | Type I |
| `14` | `Development/AbelianVarietyTheory/PublishedTheorems/AutomorphicForms₂/ExistsUniqueHcharOfFiniteOrder.lean:25-492` (`495` lines) | `740` | `6` | `GlobalArtinReciprocity`, `HeckeLAdicCharacter`, uniqueness of finite-order Hecke characters | Type I |
| `15` | `Development/AbelianVarietyTheory/PublishedTheorems/Divisors₂/AbelianHodgeDeRham.lean:15-30` (`31` lines) | `669` | `6` | Abelian variety Hodge filtration degeneration and complex period comparison `AbelianHodgeDeRham` | Type I |

In particular, the fact that the second most cited module (`2,242` citations), `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/CohomologicalCsdTempered.lean:1`, is a `1`-line empty module (`import Mathlib`) is a forensic clue impossible to detect without reading the source text.
During early scaffolding, `2,242` files imported this module as an unproved hypothesis hub; once the actual theorem specification was factored out to `Development/AbelianVarietyTheory/PublishedTheorems/GaloisGeometry₂/CaraianiTempered.lean:13-18` and its proof completed in `Development/AbelianVarietyTheory/Proofs/SatakeParameters/CohomologicalCsdTemperedOfSegments.lean:16-29`, an `import Mathlib` stub was retained at the original path so as not to break the import graph of `2,242` downstream files.

---

### 1.3 Core Epistemological Distinction: Type I (Paper-Equivalent Propositions) vs. Type II (Archive-Specific Structure and Sub-Locus Propositions)

Inferring from identifiers alone, such as `HarishChandraModules`, `CasselmanWallach`, `HasseNormSt`, or `L2ExtensionLogCanonical`, that the underlying `def ... : Prop` is one-to-one equivalent to the general graduate-textbook theorem leads to serious misinterpretation. In this audit, every mathematical proposition across `PublishedTheorems` and the `201` direct imports is classified strictly into three categories according to its exact source type signature.

- **Type I (General Propositions Equivalent to Original Papers and Textbooks)**: Propositions formulated over standard `Mathlib` categories (`NumberField`, `Scheme.{0}`, `Representation`, `IsNonarchimedeanLocalField`, `Valuation`) without domain restriction, faithfully stating the general theorem of the original paper.
Examples include Bernstein irreducibility of unitary parabolic products (`Development/AbelianVarietyTheory/PublishedTheorems/TwistedTraceFormula/BernsteinUnitaryProductIrreducible.lean:10-16`), Jacquet-Shalika isobaric rigidity (`Development/AbelianVarietyTheory/PublishedTheorems/GaloisCohomology₂/StrongMultiplicityOne.lean:189-203`), abelian variety $[n]$-torsion cardinality $n^{2g}$ (`Development/AbelianVarietyTheory/PublishedTheorems/Landherr₂/DimEqZero.lean:10-11`), the Scholze-Weinstein classification of $p$-divisible groups (`Development/AbelianVarietyTheory/PublishedTheorems/Divisors₂/ScholzeWeinsteinB.lean:13-24`), and Hironaka principalization (`Development/AbelianVarietyTheory/PublishedTheorems/Divisors₂/GeometricallyConnectedOfIsIsoRestrict.lean:118-126`).
- **Type II-A (Specialized Propositions Projected onto Archive-Specific Data Structures)**: Propositions stated not over an arbitrary reductive group $G$ or general Shimura variety, but exclusively over custom records engineered within this archive to execute the $\sqrt{X}$-theta lift and Arakelov volume computations. The source locations and mathematical contents of the five custom data structures governing all Type II-A propositions are as follows.
    1. `D : D7` (`Formalism/LocalRingCardinality/RhoDetPrimeEqMuTildeMulChiPow.lean:76-114`): The global unitary-theta master datum bundling the rank parameters `R : Ranks`, `host : Host R` containing the totally real field `D.host.F` and CM quadratic extension `D.host.E`, the Hermitian space family `sp`, the volume normalization `vol`, the archimedean place bijection `eTau : what₂.Tau ≃ R.Psi`, the Harish-Chandra parameter family `hcW`, the Galois number field `what₂.LL`, and the divisor datum `div`.
    2. `V : HSp D` and `GA D V`, `GQ V` (`Formalism/LocalRingCardinality/DataTheta.lean:489-495`): A nondegenerate Hermitian space `HSpace D.host.E` over `D.host.E` together with its adelic unitary group $U(V)(\mathbb{A}_F)$ (`GA D V`) and rational discrete subgroup $U(V)(F)$ (`GQ V`).
`CuspRapidDecay`, `HarishChandraFinite`, `WeilRepresentationUnitaryPair`, and `SiegelWeilUnitaryConvergent` are all stated specifically for `(D : D7)` and `(V : HSp D)` rather than arbitrary algebraic groups.
    3. `T : GrpData p q` (`Formalism/LocalRingCardinality/DataTheta.lean:93-120`): A topological and measure-group record abstracting the **determinant-square-root double cover** $G$ of the indefinite unitary group $U(p,q)$ (`Formalism.UG.Upq p q`).
It stipulates a covering homomorphism `cov : G →* GL (Ix p q) ℂ` and square-root character `sq : G →* ℂˣ` satisfying $(\mathrm{sq}(x))^2 = \det(\mathrm{cov}(x))$, a bijection (`bij`) assigning a unique $x \in G$ to each $(g, w) \in U(p,q) \times \mathbb{C}^\times$ with $w^2 = \det g$, a topological embedding (`emb`) $x \mapsto (\mathrm{cov}(x), \mathrm{sq}(x))$, and a Lie-algebra exponential lift `expt : Mat p q → G`.
To handle half-integral weight Fock models prior to Kudla's metaplectic splitting, the real representation-theory specifications (`HarishChandraModulesOn`, `DiscreteSeriesCover`) are built over this double cover `GrpData p q` rather than the linear group $U(p,q)$.
    4. `UJset ε` (`Development/AbelianVarietyTheory/PublishedTheorems/TwistedTraceFormula/HarishChandraModulesOn.lean:16-22`): The isometry matrix set $\{g \in M_n(\mathbb{C}) \mid g^* J_\varepsilon g = J_\varepsilon\} \cong U(p,q)$ of the diagonal Hermitian matrix $J_\varepsilon = \mathrm{diag}(\pm 1)$ determined by a sign vector $\varepsilon : \mathrm{Fin}\,n \to \mathrm{Bool}$.
`KFiniteAnalyticUJ` and `CasselmanWallach` are formulated exclusively over `UJset ε` rather than general real reductive groups.
    5. `X : ProvA` (`Formalism/LocalRingCardinality/DataTheta.lean:471-478`): An archimedean representation provider package bundling the covering-group supplier `grp : ∀ p q, GrpData p q` across all signatures $(p,q)$, the dual-pair tensor Fock-model supplier `fock : ∀ p q r s, FockData ...`, and the discrete-series representative supplier `ds : ∀ p q, (Ix p q → ℚ) → DSRep (grp p q)` indexed by rational Harish-Chandra parameters.
- **Type II-B (Sub-Locus and Weakened-Condition Specialized Propositions)**: Propositions that do not rely on archive-specific structures, yet formalize only the proper subset (sub-locus) of a classical theorem actually invoked along the proof path.
Representative instances include `HasseNormSt` (`Development/AbelianVarietyTheory/PublishedTheorems/Landherr₂/ExistsNormTensor.lean:12`), which treats **quadratic extensions $F(\sqrt{\delta})/F$** rather than general cyclic extensions; `IsRecT` (`Development/AutomorphicArithmetic/Foundations/LocalLanglands/IsRecTOfIsRec.lean:20-76`), which imposes fine axioms only on **one-dimensional characters and twists of depth-`0` representations over $\mathbb{Q}_g$ (`GoodCusp`)** rather than arbitrarily ramified supercuspidals; Demailly $L^2$-extension (`Development/AbelianVarietyTheory/PublishedTheorems/Divisors₂/L2ExtensionLogCanonical.lean:32-55`), which requires interpolation only at **finitely many isolated points (`(A.zeroSet s).Finite`)** rather than positive-dimensional log-canonical centers; `GagaSections` (`Development/AutomorphicSpectrum/PublishedTheorems/Geometry₂/GagaSections.lean:10-18`), which requires bijectivity only on **degree-`0` sections of line bundles (`LB.Sec`)** rather than full coherent-sheaf cohomology; and `PrismaticDieudonneHodgeAt` (`Development/AbelianVarietyTheory/PublishedTheorems/Divisors₂/InjectiveOfSmulMemRange.lean:56-58`), which requires full faithfulness only on **morphisms from the constant group $\underline{\mathbb{Q}_p/\mathbb{Z}_p}$ to $\mu_{p^\infty}$** rather than arbitrary $p$-divisible group morphisms.

---

### 1.4 Kernel Truth-Value Invariance vs. Asymmetry of Translation Adapter Lemmas for a Condensed Human Monograph

When Type II-A and Type II-B specializations are identified, the primary mathematical-logical principle to distinguish is the asymmetry between **soundness of the mechanized formal proof** and **black-box citation of the published literature by human mathematicians**.

First, **Type II specializations introduce zero defect whatsoever into the Lean 4 kernel truth value of `Main.lean`.** Inside the formal system, an intermediate classical proposition $P_{\mathrm{arch}}$ is not an externally injected axiom (`axiom`), but an **internal cut formula** linking a theorem $T_{\mathrm{low}} : \vdash P_{\mathrm{arch}}$ proved by downstream modules with an implication $T_{\mathrm{high}} : P_{\mathrm{arch}} \vdash \mathrm{RiemannHypothesis}$ proved by upstream modules. By Modus Ponens,

$$
\frac{\vdash P_{\mathrm{arch}} \qquad P_{\mathrm{arch}} \vdash \mathrm{RiemannHypothesis}}{\vdash \mathrm{RiemannHypothesis}}
$$

not a single archive-internal definition (`D7`, `GrpData`, `GoodCusp`, `UnusedSlot72`, etc.) survives in the type of the final theorem `Main.riemannHypothesis`, which reduces purely to `Mathlib`'s standard `_root_.RiemannHypothesis`.
Even in the extreme case of `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/EveryCharacterOfLiteratureOfVWin.lean:505-506`, where the return type `UnusedSlot72` of `siegel_eisenstein_simple_pole` is defined as `True` and discharged by `trivial`, the kernel verifies that the upstream consumer `every_character_of_theta_integrals_local_matching` deduces `EveryCharacter` without using any information from that slot, preserving the truth value of the final theorem at 100%.

Second, **when human mathematicians write a condensed human-readable monograph of roughly 150 pages by citing published papers as black boxes instead of reading `13.15 million` lines of internal reproof code, a 'Translation Adapter Lemma' must be established for every Type II proposition.** Because a condensed human paper discards the internal proof $\vdash P_{\mathrm{arch}}$ and replaces it with a classical theorem $T_{\mathrm{lit}}$ from the literature, logical completeness requires the bridge implication

$$
T_{\mathrm{lit}} \implies P_{\mathrm{arch}}
$$

to hold. For Type II-B (sub-locus weakening), the general theorem usually implies the special case immediately ($\forall L/F\text{ cyclic} \implies \forall F(\sqrt{\delta})/F\text{ quadratic}$), making the adapter routine. For Type II-A (custom-structure projection), however, three adapter verifications are indispensable.

1. **Nonlinear / Covering-Group Category Compatibility**: Classical theorems on Harish-Chandra modules, Casselman-Wallach globalization, and discrete series are ordinarily stated for connected semisimple matrix Lie groups or reductive groups of Harish-Chandra class (class $\mathcal{H}$).
Applying them to `GrpData p q` requires an adapter lemma verifying that the $\det^{1/2}$ double cover $G = \{(g, w) \in U(p,q) \times \mathbb{C}^\times \mid w^2 = \det g\}$ of $U(p,q)$ is a closed matrix Lie subgroup with finite center (a real algebraic subgroup inside $\mathrm{GL}_{p+q}(\mathbb{C}) \times \mathrm{GL}_1(\mathbb{C})$) satisfying the Harish-Chandra class axioms.
2. **Measure, Height, and Sign Normalization Consistency**: `SiegelWeilUnitaryConvergent` and `RallisInnerProductConvergent` state identities under the archive's custom Tamagawa and lattice-covolume condition `IsCovolOne (ratL B A) μ 𝓨` and sesquilinear conjugation conventions. When citing Kudla-Rallis (`1994`) or Gan-Qiu-Takeda (`2014`), one must verify that Haar measure scalar factors and central-character signs (`χB` vs. `χB⁻¹`) match without discrepancy.
3. **Morphism Domain and Scheme Hypothesis Alignment**: In the Arakelov and toroidal specifications (`ToroidalForFanKS`, `ArDegree`), one must verify that the archive's `Scheme.{0}` universe constraint, the Čech-cocycle line-bundle representation `LB`, and the `IsArithVar` predicate fit squarely within the regular projective arithmetic variety hypotheses of Faltings-Chai (`1990`) and Bost-Gillet-Soulé (`1994`).

To complete the quantitative anatomy of Chapter 1, we next tabulate how `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/EveryCharacterOfLiteratureOfVWin.lean:589-809` assembles the `185` individual classical witnesses into `9` intermediate hypothesis bundles fed into the new zero-elimination engine, together with the exhaustive sub-branch layout of the two major `PublishedTheorems` directories (`540` files in `WeilBound` vs. `493` files in `AbelianVarietyTheory`).

---

### 1.5 Assembly Structure of the `9` Top-Level Hypothesis Bundles and Exhaustive Sub-Branch Anatomy of `PublishedTheorems`

The `9` assembly theorems (`186` through `194`) placed in `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/EveryCharacterOfLiteratureOfVWin.lean:589-809` compress the flat list of `185` classical witnesses into a hierarchical dependency tree.
Specifically, `189` (`literature_nonexistence`) encapsulates the three lower bundles (`186`, `187`, `188`), and `192` (`published_results_eigen`, `60` fields) nests bundles `189`, `190`, and `191` as subfields (`litN`, `toHypothesesX`, `nLink`). Consequently, the master theorem `every_character_of_literature_of_vWin` (`L810-813`) receives all `194` classical theorems at once via just a handful of top-level bundle arguments.

| Assembly Index (`Line Range`) | Assembly Theorem Identifier | Returned Structure Type (`Defining Module`) | Fields | Core Classical Theorems Stored and Downstream Consumer |
| :---: | :--- | :--- | ---: | :--- |
| `186` (`L589-608`) | `literature_local` | `LocalRepresentationTheoryHypothesesAlt` (`Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/LocalRepresentationTheoryHypotheses.lean:13-32`) | `19` | Bernstein-Zelevinsky, Moy-Prasad, `RecTExists`, local converse, Brauer, Green regular characters $\to$ `litN.loc` |
| `187` (`L609-625`) | `literature_automorphy` | `GlobalAutomorphicGaloisHypotheses'` (`Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/LocalRepresentationTheoryHypotheses.lean:33-49`) | `16` | Cuspidal rapid decay, Harish-Chandra finiteness, Jacquet-Shalika, base change, `O.caraianiLocalGlobalDual`, Berger $\to$ `litN.aut` |
| `188` (`L626-638`) | `literature_cohomology` | `LitCoh` (`LocalTypeDictionary` layer definition) | `12` | Poitou-Tate 9-term exact sequence, local and global Tate duality, Euler characteristic, finiteness, Greenberg-Wiles, Bloch-Kato $\to$ `litN.coh` |
| `189` (`L639-644`) | `literature_nonexistence` | `NonEndoscopicHypothesesAlt` (`Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/BernsteinUnitaryProductIrreducible.lean:12-17`) | `5` | `loc` (`186`), `aut` (`187`), `coh` (`188`), `JoinOut` (`5`-item CM/zeta join), Tate functional equation $\to$ `eigen.litN` |
| `190` (`L645-657`) | `published_results_analytic` | `GeometricGaloisRepCompatibility` (`GlobalTheory.NRows`) | `12` | Unitary Weil pair, discrete series classification, cuspidal trace class, Flath factorization, doubling method, Northcott height finiteness $\to$ `eigen.toHypothesesX` |
| `191` (`L658-665`) | `published_results_local` | `NLink.Hypotheses₂` (`GlobalTheory.NLink`) | `7` | Fontaine `Bcris`, global Artin, Bloch-Kato, `3` base-field $K$ local cohomology theorems, Bhatt-Scholze integral lattices $\to$ `eigen.nLink` |
| `192` (`L666-726`) | `published_results_eigen` | `UnitaryGroupThirdPlaceHypotheses` (`Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/BernsteinUnitaryProductIrreducible.lean:22-82`) | `60` | Clozel, Caraiani, Labesse-Shin base change, Tadić unitary dual, Casselman-Wallach, inactive `UnusedSlot72`, and others $\to$ 1st argument of master theorem |
| `193` (`L727-780`) | `published_results_first` | `ThetaLocalInputs` (`GlobalTheory.FunPr`) | `53` | Linnik, CM $j$-invariant, mirabolic, Weyl branching, Rallis inner product, Stone-von Neumann, Howe duality, and others $\to$ 2nd argument of master theorem |
| `194` (`L781-809`) | `published_results_arithmetic` | `PublishedHodgeBundleTheorems` (`GlobalTheory.CovTop`) | `28` | Toroidal compactification, Moriwaki volume, abelian de Rham, semistable reduction, Landherr, Hasse norm, prismatic, GFGA, and others $\to$ `topCovolSlim2` |

Furthermore, an exhaustive tally of the internal sub-branches of the two major directories holding `96.27%` (`1,033` files) of all `1,073` `PublishedTheorems` files, namely `Development.WeilBound.CoreStatements.PublishedTheorems` (`540` files, `19` sub-branches) and `Development.AbelianVarietyTheory.PublishedTheorems` (`493` files, `21` sub-branches), yields the following breakdown.

- **`WeilBound.CoreStatements.PublishedTheorems` (`540` files, `48,718` lines)**: `NadelVanishingPairs` records the largest file count at `197` files (`9,901` lines), followed by `JacquetShalikaRigidity` (`67` files, `12,503` lines - largest by line count), `PoitouTateDuality` (`64` files, `4,738` lines), `CasselmanWallach` (`63` files, `6,874` lines), `SmoothVectorEstimates` (`42` files, `5,734` lines), `GlobalEulerCharacteristic` (`42` files, `3,855` lines), `NefNumerics` (`27` files, `1,332` lines), `PoincareDeRhamDuality` (`14` files, `2,443` lines), `JacquetShalikaBound` (`6` files, `645` lines), `GlobalFiniteness` (`4` files, `316` lines), and `9` compact sub-branches of `1` to `2` files each (`FiniteGLInvariants`, `LanglandsClassification`, `SiegelWeilSchrodinger`, `SegmentRepresentations`, `CuspidalMultiplicityOne`, `HeckeLAdicCharacters`, `ClozelPurity`, `PolarizedGaloisRepresentations`, `PotentialSemistability`, totaling `14` files and `377` lines).
- **`AbelianVarietyTheory.PublishedTheorems` (`493` files, `56,194` lines)**: The arithmetic and algebraic-geometry branch `Divisors₂` (`152` files, `18,694` lines) together with the real-group and twisted-trace branch `TwistedTraceFormula` (`97` files, `13,635` lines) account for over half of the total, followed by `GaloisCohomology₂` (`80` files, `8,023` lines), `AutomorphicForms₂` (`52` files, `4,660` lines), `GaloisGeometry₂` (`46` files, `3,391` lines), `SiegelWeil₂` (`18` files, `1,488` lines), `GlobalTheta` (`8` files, `1,691` lines), `PublishedFoundations` (`8` files, `1,254` lines), `AdelicLattices₂` (`7` files, `1,416` lines), `DiscreteSeriesUnitary₂` (`7` files, `447` lines), and the remaining `11` specialized branches (`SemiabelianTori`, `Landherr₂`, `RelativeAmpleness`, `DefiniteCompactness`, `RosatiTraces`, `AbelianLaws`, `DiscreteSeries₂`, `SemistableReduction₂`, `ThetaCharacteristics`, `BesselIntegrals`, `WeberRayClassFields`, totaling `18` files and `1,495` lines).

This quantitative distribution confirms that the archive was constructed on a dual-layer design rather than accumulating classical specifications haphazardly in a single directory: `AbelianVarietyTheory.PublishedTheorems` houses the **canonical classical specifications (`Prop`) and foundational corollaries**, while `WeilBound.CoreStatements.PublishedTheorems` distributes the **substantive proof engines for Nadel vanishing, Jacquet-Shalika rigidity, Casselman-Wallach globalization, and Poitou-Tate duality**.

---

## Chapter 2. Source Audit of Automorphic Rapid Decay, Finite Volume, and Harish-Chandra $(\mathfrak{g},K)$-Module Specifications

### 2.1 Adelic Unitary Quotient Height, Cuspidal Rapid Decay, and Borel-Harish-Chandra Finite Volume Audit

The single most cited classical specification hub across the entire archive (`in_degree = 2,460`), `Development/AbelianVarietyTheory/PublishedTheorems/AutomorphicForms₂/ExistsNormLeHeightPow.lean:18-111`, formalizes moderate growth and cuspidal rapid decay of adelic unitary automorphic forms over the master datum `D : D7` and Hermitian space `V : HSp D`. The three core definitions at `L18-33` read as follows.

```lean
-- Development/AbelianVarietyTheory/PublishedTheorems/AutomorphicForms₂/ExistsNormLeHeightPow.lean:18-33
def quotHeight (θ : D.what₂.Tau → (Ainf D.host.F ⊗[D.host.F] D.host.E →+* ℂ)) (V : HSp D) (g : GA D V) : NNReal :=
  ⨅ γ : GQ V, height θ V ((γ : GA D V) * g)

def IsRapidDecay (θ : D.what₂.Tau → (Ainf D.host.F ⊗[D.host.F] D.host.E →+* ℂ)) (V : HSp D) (φ : GA D V → ℂ) : Prop :=
  ∀ N : ℕ, ∃ C : ℝ, ∀ g : GA D V, ‖φ g‖ * (quotHeight θ V g : ℝ) ^ N ≤ C

def CuspRapidDecay : Prop :=
  ∀ (D : D7) (θ : D.what₂.Tau → (Ainf D.host.F ⊗[D.host.F] D.host.E →+* ℂ)), IsInfFam θ →
    ∀ (V : HSp D) (e : LieInf V → GA D V), IsExpFam θ V e →
      ∀ φ : GA D V → ℂ, IsAutFun V φ → IsSmoothInf V e φ → IsUnifModerate θ V e φ → IsCuspFun V φ →
        GlobalTheory.CuspDecay.IsRapidDecay θ V φ
```

Reverse-translating these declarations into standard analytic number theory notation yields the following formulation. Fixing an infinite-place embedding family $\theta$ (`IsInfFam θ`) from the infinite adelic tensor algebra $F_\infty \otimes_F E$ of the totally real field $F = \mathrm{D.host.F}$ into $\mathbb{C}$, the quotient height obtained by taking the infimum of the adelic height $\mathrm{ht}_\theta(g) \ge 1$ on $G(\mathbb{A}_F) = U(V)(\mathbb{A}_F)$ (`GA D V`) over left orbits of the rational discrete subgroup $\Gamma = U(V)(F)$ (`GQ V`) is defined by

$$
\mathrm{ht}_{\mathrm{quot}}(\theta, V, g) := \inf_{\gamma \in U(V)(F)} \mathrm{ht}_\theta(\gamma g) \in [1, \infty)
$$

(`one_le_quotHeight`, `L43-44`). By the infimum property, for every $g \in U(V)(\mathbb{A}_F)$ there exists a rational element $\gamma \in U(V)(F)$ satisfying $\mathrm{ht}_\theta(\gamma g) \le 2\,\mathrm{ht}_{\mathrm{quot}}(\theta, V, g)$ (`exists_height_le`, `L46-50`).
Consequently, the product of a left-invariant function $\psi(\gamma g) = \psi(g)$ of moderate growth ($\lvert\psi(g)\rvert \le C\,\mathrm{ht}_\theta(g)^N$) with a rapidly decaying function $\varphi$ ($\sup_g \lvert\varphi(g)\rvert\,\mathrm{ht}_{\mathrm{quot}}(\theta, V, g)^N \le C'_N$) is globally bounded via

$$
\lvert \psi(g) \rvert \cdot \lvert \varphi(g) \rvert = \lvert \psi(\gamma g) \rvert \cdot \lvert \varphi(g) \rvert \le \lvert C \rvert \, 2^N \left( \lvert \varphi(g) \rvert \, \mathrm{ht}_{\mathrm{quot}}(\theta, V, g)^N \right) \le \lvert C \rvert \, 2^N C'_N
$$

(`IsRapidDecay.mul_bounded`, `L56-71`). Furthermore, the strengthened specification `CuspDecayBound` in `Development/AbelianVarietyTheory/PublishedTheorems/TwistedTraceFormula/UnifModGrowthOfIsUnifModerate.lean:17-32` (`in_degree = 522`) states that for every open level subgroup $U \subset U(V)(\mathbb{A}_F)$ and exponents $A, N \in \mathbb{N}$, there exist a finite set $\mathcal{L}$ of Lie-algebra differential words and a constant $C > 0$ dominating the weighted cusp-form norm by a finite linear sum of uniform moderate-growth constants $c(l) = \sup_g \lvert (R(l)\varphi)(g)\rvert\,\mathrm{ht}(g)^{-A}$:

$$
\sup_{g \in U(V)(\mathbb{A}_F)} \lvert \varphi(g) \rvert \cdot \mathrm{ht}_{\mathrm{quot}}(V, g)^N \le C \sum_{l \in \mathcal{L}} \sup_{h \in U(V)(\mathbb{A}_F)} \frac{\lvert (R(l)\varphi)(h) \rvert}{\mathrm{ht}(V, h)^A}
$$

To combine this decay bound with absolute integrability of the Petersson inner product (`integrableOn_star_mul`, `Development/AbelianVarietyTheory/PublishedTheorems/AutomorphicForms₂/ExistsNormLeHeightPow.lean:101-111`), the archive introduces the Borel-Harish-Chandra finite-volume theorem `FiniteVolume₂`, defined in `Development/AbelianVarietyTheory/Definitions/Foundations/CdScaleTieIff.lean:81-85` as

$$
\mathrm{FiniteVolume}_2 \iff \forall (E/F\text{ CM extension}),\; \forall M \in \mathbb{N},\; \forall J \in \mathrm{Herm}_{\mathrm{nd}}(M, E),\; \forall \mu\text{ Haar},\; \forall \mathcal{F}\text{ fundamental domain},\quad \mu(\mathcal{F}) < \infty
$$

Because `FiniteVolume₂` is stated for an arbitrary CM extension $(E/F, \sigma)$ and nondegenerate Hermitian matrix $J$ without reference to `D7`, it is a **general unitary proposition of Type I** (the unitary specialization of Borel-Harish-Chandra `1962`), proved unconditionally in `Development/AbelianVarietyTheory/Proofs/IwasawaDecomposition/FiniteVolumeAdelicUnitaryQuotient.lean:124-186` by combining finiteness of finite-adelic class numbers (`finite_classSet_hermitianUnitary_openLevel`) with finite covolume of real lattice stabilizers (`finite_covolume_latticeStabiliser_unitaryRealPoints`).
By contrast, `CuspRapidDecay` and `CuspDecayBound` are **Type II-A propositions** projected onto `D : D7` and the infinite exponential family `IsExpFam θ V e`, with witnesses supplied in `Development/AbelianVarietyTheory/Proofs/DecoratedLatticeProofs/CuspidalModerateGrowthRapidDecay.lean:20-106` and `Development/AbelianVarietyTheory/Proofs/DecoratedLatticeProofs/CuspFormsRapidDecay.lean:10-11` (while the $\mathrm{GL}_n$ counterpart is proved separately in `Development/AutomorphicSpectrum/Proofs/BlockDecomposition/CuspRapidDecaySiegelGL.lean:21-32`).

---

### 2.2 Real Metaplectic Cover Harish-Chandra $(\mathfrak{g},K)$-Modules and $K$-Finite Real Analyticity Audit

The third most cited hub (`in_degree = 1,684`), `Development/AbelianVarietyTheory/PublishedTheorems/TwistedTraceFormula/HarishChandraModulesOn.lean:18-45`, defines the Harish-Chandra dictionary at archimedean places between unitary representations and algebraic $(\mathfrak{g}, K)$-modules. Lines `L24-45` define `HarishChandraModules` as the conjunction of `HarishChandraModulesOn` and `KFiniteAnalyticUJ`.

```lean
-- Development/AbelianVarietyTheory/PublishedTheorems/TwistedTraceFormula/HarishChandraModulesOn.lean:24-45
def HarishChandraModulesOn {p q : ℕ} (T : GrpData p q) : Prop :=
  (∀ πU : URep T, IrrU πU →
    (∀ x, KFin T πU.π x → Smooth T πU.π x) ∧
    (∃ (M : GKMod p q) (io : M.V →ₗ[ℂ] πU.H), IsHCMod πU M io) ∧
    ∀ (M : GKMod p q) (io : M.V →ₗ[ℂ] πU.H), IsHCMod πU M io → AdmGK M ∧ IrrGK M) ∧
  (∀ π₁ π₂ : URep T, IrrU π₁ → IrrU π₂ →
    ∀ (M₁ M₂ : GKMod p q) (io₁ : M₁.V →ₗ[ℂ] π₁.H) (io₂ : M₂.V →ₗ[ℂ] π₂.H),
      IsHCMod π₁ M₁ io₁ → IsHCMod π₂ M₂ io₂ →
      ∀ e : M₁.V ≃ₗ[ℂ] M₂.V, (∀ Z v, e (M₁.act Z v) = M₂.act Z (e v)) →
      ∃ U : π₁.H ≃ₗᵢ[ℂ] π₂.H, ∀ g x, U (π₁.π g x) = π₂.π g (U x)) ∧
  (∀ (πU : URep T) (M : GKMod p q) (io : M.V →ₗ[ℂ] πU.H), IsHCMod πU M io →
    AdmGK M → IrrGK M → IrrU πU)

def KFiniteAnalyticUJ : Prop :=
  ∀ (n : ℕ) (ε : Fin n → Bool) (H : Type) [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
    [Nontrivial H] (σ : Matrix (Fin n) (Fin n) ℂ → (H →L[ℂ] H)),
    IsURepOn (UJset ε) σ → IsIrredOn (UJset ε) σ →
    ∀ v : H, IsKFin ε σ v → AnalyticOnUJ ε fun g => σ g v
```

Unpacking the three clauses of the signature together with the analyticity clause reconstructs the four classical pillars of Harish-Chandra (`1953`, `1954`).

1. **Smoothness, Admissibility, and Algebraic Irreducibility (`L25-28`)**: For any topologically irreducible unitary Hilbert representation $(\pi_U, \mathcal{H})$ of the double cover `T : GrpData p q` with $p + q \ge 1$, every $K_T$-finite vector for the maximal compact subgroup $K_T = \mathrm{cov}^{-1}(U(p) \times U(q))$ is $C^\infty$-smooth, and the induced module $M$ over the complexified Lie algebra $\mathfrak{g}_{\mathbb{C}} = \mathfrak{gl}_{p+q}(\mathbb{C})$ (`Mat p q`) on the $K_T$-finite subspace is admissible (`AdmGK`, finite multiplicity of each $K_T$-type) and algebraically irreducible (`IrrGK`).
2. **Lifting Infinitesimal Equivalence to Unitary Equivalence (`L29-33`)**: Whenever a $\mathfrak{g}_{\mathbb{C}}$-linear isomorphism $e : M_1 \xrightarrow{\sim} M_2$ exists between the Harish-Chandra modules $M_1, M_2$ of two irreducible unitary representations $\pi_1, \pi_2$, there exists a global isometric unitary equivalence $U : \mathcal{H}_1 \xrightarrow{\sim} \mathcal{H}_2$ intertwining the group actions ($U \circ \pi_1(g) = \pi_2(g) \circ U$).
Because the statement is restricted to unitary representations, the non-unitary Banach pathology in which infinitesimal equivalence fails to lift to global isomorphism is excluded, and Nelson's analytic-vector uniqueness lifts $e$ to a global isometry.
3. **Converse Topological Irreducibility (`L34-35`)**: If an underlying Harish-Chandra module $M$ of a unitary representation $\pi_U$ is admissible and algebraically irreducible, then $\pi_U$ is topologically irreducible.
4. **Real Analyticity of $K$-Finite Orbits (`L37-42`, `L18-23`)**: For any $K$-finite vector $v \in \mathcal{H}_{K\text{-fin}}$ in an irreducible unitary representation $\sigma$ of the indefinite unitary matrix group $U(J_\varepsilon) \subset M_n(\mathbb{C})$, the orbit map $g \mapsto \sigma(g)v$ agrees with the restriction (`AnalyticOnUJ`) of a real-analytic function $F$ defined on an open neighborhood in the ambient Euclidean space $\mathbb{C}^{n \times n} \cong \mathbb{R}^{2n^2}$.
At the bottom of the file (`L166-206`), the genuine double-cover character `sqrtDetRep` ($g \mapsto \mathrm{sq}(g)\cdot \mathrm{id}_{\mathbb{C}}$) and the determinant representation `det_isURepOn` are explicitly constructed to certify non-vacuity of the specification.

In addition, `Development/AbelianVarietyTheory/PublishedTheorems/AutomorphicForms₂/HarishChandraFinite.lean:39-59` (`in_degree = 814`), which governs finite-dimensionality of automorphic forms at fixed level, states that for a fixed open subgroup $U \subset U(V)(\mathbb{A}_F)$, finite-dimensional continuous $K_\tau$-types $(\rho_\tau, W_\tau)$ at each infinite place $\tau$, and a fixed eigenvalue sequence `gelf θ V τ k φ = c τ k • φ` (`k : ℕ`) under the **Gelfand-Casimir invariant differential operators** in the center of the universal enveloping algebra, the subspace spanned by such smooth automorphic forms is finite-dimensional over $\mathbb{C}$.
This is the `D7` unitary specialization (Type II-A) of Theorem 1 of Harish-Chandra (`1968`, *Automorphic Forms on Semisimple Lie Groups*), proved by induction on constant terms in `Development/WeilBound/RepresentationTheoryGL/ConstantTermFiniteness/CuspidalConstantTerms/FiniteOfCuspOfConstTerm.lean:129-133`.

---

### 2.3 Casselman-Wallach Smooth Fréchet Completion and Flath Factorization Audit

Ranked fifth in citation count (`in_degree = 1,051`), `Development/AbelianVarietyTheory/PublishedTheorems/AutomorphicForms₂/HasDRepIffHasDerivAt.lean:19-112` defines `CasselmanWallach`, controlling continuous intertwining operators between local Schwartz test-function spaces and Hilbert representations in the real theta correspondence. Reconstructing `L22-47` and `L98-112` in mathematical notation gives the following structure.

Given a countable family of seminorms $\{p_i\}_{i \in \mathbb{N}}$ (`WithSeminorms p`) on a complete Hausdorff locally convex space $E$, `IsSmoothModRep ε p π dπ` (`L22-31`) asserts that $\pi$ is a continuous representation of $U(J_\varepsilon)$ admitting directional derivatives $d\pi(X)$ for all $X \in \mathfrak{u}(J_\varepsilon)$ and satisfying the moderate-growth Fréchet bound with respect to the squared Hilbert-Schmidt norm $\mathrm{hs}(g) = \sum_{a,b} \lvert g_{ab}\rvert^2$:

$$
\forall i \in \mathbb{N},\; \exists (q\text{ continuous seminorm}),\; \exists N \in \mathbb{N},\quad \forall g \in U(J_\varepsilon),\; \forall v \in E,\quad p_i(\pi(g)v) \le \bigl(1 + \mathrm{hs}(g)\bigr)^N q(v)
$$

Meanwhile, for any finite list of Lie-algebra words $S = [l_1, \dots, l_m]$ ($l_r = [X_{r,1}, \dots, X_{r,k_r}] \subset \mathfrak{u}(J_\varepsilon)$) acting on an irreducible unitary Hilbert representation $(\sigma, \mathcal{H})$, the Sobolev norm `sobNorm σ S w` (`L34-35`) is defined by

$$
\| w \|_{S, \sigma} := \sum_{l \in S} \bigl\| d\sigma(X_{l,1}) \cdots d\sigma(X_{l,k_l}) w \bigr\|_{\mathcal{H}}
$$

`CasselmanWallach : Prop` (`L98-112`) then requires that every $(\mathfrak{u}(J_\varepsilon), K_\varepsilon)$-module homomorphism $T_0 : \mathcal{H}_{K\text{-fin}} \to E$ (`IsGKMap ε σ π dπ T₀`) admits an extension $T$ to the full smooth vector space $\mathcal{H}^\infty = \{w \in \mathcal{H} \mid \mathrm{SmoothVec}(\mathfrak{u}(J_\varepsilon), \sigma, w)\}$ satisfying four properties simultaneously.

1. **$G$-Equivariant Continuous Extension (`L105`)**: $T = T_0$ on $\mathcal{H}_{K\text{-fin}}$, $T(\sigma(g)w) = \pi(g)(Tw)$ for all $g \in U(J_\varepsilon)$ and $w \in \mathcal{H}^\infty$, and each seminorm is dominated via $p_i(Tw) \le C_i \|w\|_{S_i, \sigma}$ (`IsSmoothGMap`).
2. **Uniqueness (`L106-107`)**: Any other continuous $G$-map $T'$ agreeing with $T_0$ on $\mathcal{H}_{K\text{-fin}}$ satisfies $T' = T$ on all of $\mathcal{H}^\infty$ (Sobolev density of $\mathcal{H}_{K\text{-fin}}$ in $\mathcal{H}^\infty$).
3. **Closed Image Property (`L108`)**: The image $T(\mathcal{H}^\infty) \subset E$ of the smooth subspace is closed (`IsClosed`) in the Fréchet space $E$.
4. **Inverse Sobolev Topological Embedding (`L109-111`)**: Whenever $T_0\rvert_{\mathcal{H}_{K\text{-fin}}} \neq 0$ (making $T_0$ injective by irreducibility), for every Lie-word list $S$ there exists a continuous seminorm $q$ on $E$ satisfying the inverse bound for all $w \in \mathcal{H}^\infty$:

    $$
    \| w \|_{S, \sigma} \le q(T w)
    $$

    By the Open Mapping Theorem, $T : \mathcal{H}^\infty \xrightarrow{\sim} T(\mathcal{H}^\infty) \subset E$ is a topological linear isomorphism, capturing the full conclusion of Casselman (`1989`, *Canonical extensions of Harish-Chandra modules*) and Wallach (`1992`, *Real Reductive Groups II*, Chapter 11) without loss over the **Type II-A domain** of irreducible unitary representations of `UJset ε`.
The proof of this specification concludes at `PositivityTheory.CWB.casselmanWallach` in `Development/WeilBound/CoreStatements/PublishedTheorems/CasselmanWallach/FinalB.lean:8`.
In parallel, the adelic admissibility module sharing the basename `FinalB.lean`, `CompanionTheory/RealGroups/UnitaryAdmissibility/ArchimedeanUnitaryDual/FinalB.lean:53-57`, combines Iwasawa-Cartan congruence-lattice decompositions (`stCartanU`) with Hecke-algebra projections (`locPI`) to prove local and real unitary admissibility `UnitaryIrreducibleAdmissible` together with the adelic restricted tensor-product factorization `FlathTensorProduct` (Flath `1979`, Type I).

---

### 2.4 Discrete Series Parameter Exhaustion (`DsExhaust`) and Blattner $K$-Type Cone Audit

Cited `1,354` times, `Development/AbelianVarietyTheory/PublishedTheorems/TwistedTraceFormula/AdmissibleDiscreteSeriesOfHasParam.lean:16-264` together with the two direct imports `CompanionTheory/RealGroups/DiscreteSeries/DiscreteSeriesClassification/KTypesAbove.lean:9-22` and `CompanionTheory/RealGroups/DiscreteSeries/DiscreteSeriesClassification/DiscreteSeriesExhaustion/DsExhaust.lean:14-21` govern the classification and exhaustion of discrete series representations (`DSRep T`) on the double cover `T : GrpData p q`.

In `Development/AbelianVarietyTheory/PublishedTheorems/TwistedTraceFormula/AdmissibleDiscreteSeriesOfHasParam.lean:19-39`, given a regular half-integral Harish-Chandra parameter $\lambda : \mathrm{Ix}(p,q) \to \mathbb{Q}$ (`IsParam lam`), the Blattner minimal $K$-type weight $\Lambda_{\mathrm{Bl}}(\lambda) = \mathrm{blattner}(\lambda)$ and the positive-root cone predicate `InCone lam μ` (`L19-23`) are expressed via a nonnegative integer matrix $m : \mathrm{Ix}(p,q)^2 \to \mathbb{N}$ ($m_{a,b} \neq 0 \implies \lambda_b < \lambda_a$) as

$$
\mu = \Lambda_{\mathrm{Bl}}(\lambda) + \sum_{\lambda_a > \lambda_b} m_{a,b} (e_a - e_b)
$$

`HasTypes R lam` (`L24-28`) states that a discrete series representation $R$ (i) has multiplicity `1` on the highest-weight subspace $\mathrm{hwSub}(\Lambda_{\mathrm{Bl}}(\lambda))$, (ii) acts on the Casimir operator by the scalar $\|\lambda\|^2 - \|\rho_{p+q}\|^2$, and (iii) places every $K$-type highest weight $\mu$ occurring in $R$ inside `InCone lam μ`. In particular, lemma `vogan_add_le` at `L138-175` proves the quadratic Vogan $\Lambda$-norm inequality

$$
\mathrm{vogan}\bigl(\Lambda_{\mathrm{Bl}}(\lambda)\bigr) + \sum_{c \in \mathrm{Ix}(p,q)} \bigl(\mu_c - \Lambda_{\mathrm{Bl}}(\lambda)_c\bigr)^2 \le \mathrm{vogan}(\mu)
$$

by pure algebraic arithmetic (`ring`, `linarith`), deducing uniqueness of the minimal $K$-type and parameter determinacy (`HasTypes.eq_of_hasParam`, `L192-203`). Next, `DiscreteSeriesCover : Prop` (`L35-39`) requires for every $p+q \ge 1$ and `T : GrpData p q` a classification map $D$ from regular parameters to `DSRep T` such that `HasTypes (D lam) lam.1` holds for all $\lambda$ and every discrete series representation $R$ is unitarily equivalent (`UnitEquiv R (D lam)`) to some $D(\lambda)$.
`CompanionTheory/RealGroups/DiscreteSeries/DiscreteSeriesClassification/KTypesAbove.lean:9-20` constructs existence (`discreteSeriesExists`, `discreteSeriesCoverExists`) and the cone property (`kTypesAbove`) via explicit $L^2$-integrability of holomorphic sections, while `CompanionTheory/RealGroups/DiscreteSeries/DiscreteSeriesClassification/DiscreteSeriesExhaustion/DsExhaust.lean:14-21` closes exhaustion (`dsExhaust`) through Casimir shifts and matrix-coefficient decay bounds.

| Audited Specification Identifier | Source Location (Relative to `src/`) | Citations | Classical Reference | Equivalence Class and Key Translation Adapter Checkpoints |
| :--- | :--- | ---: | :--- | :--- |
| `CuspRapidDecay` / `CuspDecayBound` | `Development/AbelianVarietyTheory/PublishedTheorems/AutomorphicForms₂/ExistsNormLeHeightPow.lean:28-33` | `2,460` | Godement, Harish-Chandra (1968), Borel (1974) | **Type II-A**: Projected onto `D7` Hermitian spaces `GA D V`. Verify equivalence between `IsExpFam` differential words and standard Siegel-domain Sobolev norms |
| `FiniteVolume₂` | `Development/AbelianVarietyTheory/Definitions/Foundations/CdScaleTieIff.lean:81-85` | via `2,460` | Borel-Harish-Chandra (1962) | **Type I (Unitary Group)**: Finite Haar volume of nondegenerate Hermitian adelic quotients over arbitrary CM extensions $E/F$. Direct classical specialization |
| `HarishChandraModules` | `Development/AbelianVarietyTheory/PublishedTheorems/TwistedTraceFormula/HarishChandraModulesOn.lean:24-45` | `1,684` | Harish-Chandra (1953, 1954), Nelson (1959) | **Type II-A**: Specialized to irreducible unitary representations of `GrpData p q` ($\det^{1/2}$ double cover) and `UJset ε`. Check finite-center matrix Lie group property of the cover |
| `HarishChandraFinite` | `Development/AbelianVarietyTheory/PublishedTheorems/AutomorphicForms₂/HarishChandraFinite.lean:50-59` | `814` | Harish-Chandra (1968), Theorem 1 | **Type II-A**: Finite-dimensionality at fixed `gelf θ V τ k` eigenvalues over `D7`. Verify generation of $\mathcal{Z}(\mathfrak{g})$ via the Harish-Chandra isomorphism |
| `CasselmanWallach` | `Development/AbelianVarietyTheory/PublishedTheorems/AutomorphicForms₂/HasDRepIffHasDerivAt.lean:98-112` | `1,051` | Casselman (1989), Wallach (1992) | **Type II-A**: Closed image and inverse Sobolev embedding of $\mathcal{H}^\infty$ for irreducible unitary Hilbert representations of `UJset ε`. Special case of the general theorem |
| `DiscreteSeriesCover` | `Development/AbelianVarietyTheory/PublishedTheorems/TwistedTraceFormula/AdmissibleDiscreteSeriesOfHasParam.lean:35-39` | `1,354` | Harish-Chandra (1965-1966), Hecht-Schmid (1975), Herb | **Type II-A**: Rational half-integral parameter Blattner $K$-type classification and exhaustion (`DsExhaust`) on `GrpData p q`. Check Weyl character adapter on the double cover |

---

### 2.5 Discrete Series Formal Degree (`FormalDegreeFormula₂`) and Dixmier-Malliavin Trace-Class Audit

Within the real Lie group pillar, two further specifications fixing normalization constants in spectral expansions and the relative trace formula are the **formal degree formula** for discrete series and the **trace-class property** of cuspidal convolution operators.

First, `FormalDegreeFormula₂` in `Development/AbelianVarietyTheory/Definitions/Foundations/CdScaleTieIff.lean:92-98` together with the direct import `Development/WeilBound/RepresentationTheoryGL/DiscreteSeries/DiscreteSeriesCovers/FdTopB.lean:7-10` (`formalDegreeCompactDual`) asserts that, given a Haar-measure ratio scale `CdScaleIs cd sc` against the compact dual group $U(N)$, the Schur-orthogonality formal degree of a discrete series representation $(\sigma, \mathcal{H})$ attached to a Harish-Chandra parameter $\lambda \in \mathbb{R}^N$ (`IsHCParam lam`) over a sign vector $\varepsilon : \mathrm{Fin}\,N \to \mathrm{Bool}$ (with any nonzero vector $w \neq 0$) equals the explicit Weyl degree product

$$
d_\sigma\bigl(\mathrm{sc}(N, \varepsilon) \cdot \mu_{G_\varepsilon}\bigr) = \mathrm{fdeg}_{\mathrm{HC}}(\lambda) = \prod_{1 \le i < j \le N} \frac{\lvert \lambda_i - \lambda_j \rvert}{j - i}
$$

Here $d_\sigma(\mu)$ on the left-hand side is the formal degree defined by the square-integrable matrix-coefficient orthogonality relation $\int_{G_\varepsilon} \lvert \langle \sigma(g)w, w \rangle \rvert^2\, d\mu(g) = d_\sigma(\mu)^{-1} \|w\|^4$ (`SchurOrthogonalitySquareIntegrable`). This is the `UJset ε` projection (**Type II-A**) of Harish-Chandra (`1966`) and the Gross-Frenkel-Gan compact-dual Euler-Poincaré measure normalization, pinning the archimedean Plancherel density to an exact rational number when lower-bounding the existence of nonzero holomorphic automorphic forms.

Second, inspecting the pairing of `cusp_trace_class_of_literature` and `dixmier_malliavin_factorisation_of_literature` registered at `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/EveryCharacterOfLiteratureOfVWin.lean:341-342` and `L367-368` shows that the archive proves the cuspidal trace-class property along a much shorter analytic route than W. Müller's (`1989`) trace-class theorem for general reductive groups.
Specifically, `Development/AbelianVarietyTheory/Proofs/DivisorProofs/DixmierMalliavinFactorisationFromLibrary.lean:7-9` and `Development/WeilBound/CoreStatements/AbelianHeightsDuality/PublishedTheoremStatements/BridgesMore.lean:47-49` first establish the Dixmier-Malliavin (`1978`, Ann. Sci. ENS 11) factorization theorem (`DixmierMalliavinFactorisation`, **Type I**), asserting that every smooth compactly supported test function $f \in C_c^\infty(G(\mathbb{A}))$ decomposes as a finite sum of convolutions of smooth compactly supported functions:

$$
f = \sum_{j=1}^{r} \alpha_j * \beta_j \qquad \bigl(\alpha_j, \beta_j \in C_c^\infty(G(\mathbb{A}))\bigr)
$$

Next, cuspidal rapid decay (`CuspRapidDecay`) and finite volume (`FiniteVolume₂`) from Section 2.1 imply that each single smooth kernel integral operator $R(\alpha_j)\rvert_{L^2_{\mathrm{cusp}}}$ has a bounded kernel on a finite-measure space and is therefore **Hilbert-Schmidt**; applying the standard functional-analytic theorem that the composition $R(\alpha_j) \circ R(\beta_j)$ of two Hilbert-Schmidt operators is **trace class** (nuclear) completes `cuspTraceClass_of` in just three lines.

---

## Chapter 3. Source Audit of Conjugate Self-Dual Galois-Automorphic Correspondence, Strengthened Langlands, and Jacquet-Shalika Rigidity

### 3.1 The `CohomologicalCsdTempered` Stub (`in_degree = 2,242`) and the Cohomological Temperedness Chain

In Acts III and IV, the global representation-theoretic starting point linking Galois representations with unitary automorphic forms is the Ramanujan-Petersson purity theorem asserting that every finite-place local component of a regular algebraic conjugate self-dual cuspidal (RAECSDC) representation is tempered.
As established in Section 1.2, `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/CohomologicalCsdTempered.lean:1` (`in_degree = 2,242`) is a post-refactoring compatibility stub containing only `import Mathlib`, while the actual mathematical specification and proof reside in `Development/AbelianVarietyTheory/PublishedTheorems/GaloisGeometry₂/CaraianiTempered.lean:13-18` and `Development/AbelianVarietyTheory/Proofs/SatakeParameters/CohomologicalCsdTemperedOfSegments.lean:16-29`.

```lean
-- Development/AbelianVarietyTheory/PublishedTheorems/GaloisGeometry₂/CaraianiTempered.lean:13-18
def CaraianiTempered : Prop :=
  ∀ (L : Type) [Field L] [NumberField L] [IsCMField L] (n : ℕ), 2 ≤ n →
    ∀ π : CuspSub L n, π.IsCsd → GKCoh.IsCohomological π →
      ∀ (y : HeightOneSpectrum (𝓞 L)) (σ : SmIrr (GL (Fin n) (y.adicCompletion L))), π.IsLocComp y σ →
        LocGL.IsTemperedCoeff σ.ρ
```

In the source text, `CaraianiTempered` states that for any CM number field $L$ and degree $n \ge 2$, if a cuspidal automorphic representation $\pi$ (`CuspSub L n`) of $\mathrm{GL}_n(\mathbb{A}_L)$ is conjugate self-dual (`π.IsCsd`, $\pi^\vee \cong \pi^c$) and $(\mathfrak{g}, K_\infty)$-cohomological (`GKCoh.IsCohomological π`), then at **every finite place** $y$, ramified or unramified, its local irreducible component $\sigma \cong \pi_y$ satisfies the matrix-coefficient temperedness bound (`IsTemperedCoeff σ.ρ`).
This is a **Type I proposition** coinciding verbatim with Theorem 1.2 of Caraiani (`2012`, *Local-global compatibility and the action of monodromy on nearby cycles*, Duke Math. J. 161).
Subsequently, `Development/AbelianVarietyTheory/Proofs/SatakeParameters/CohomologicalCsdTemperedOfSegments.lean:16-29` combines this matrix-coefficient temperedness with Jacquet's tempered parabolic decomposition (`TemperedProductOfSquareIntegrable`) and Zelevinsky's classification of essentially square-integrable segments (`EssSquareIntegrableSegments`) to deduce the representation-theoretic decomposition `CohomologicalCsdTempered`: every local component $\pi_y$ is isomorphic to a standard parabolic induced product of unitarizable square-integrable segment representations.

---

### 3.2 Selected-Locus (`GoodCusp`) Local Langlands Correspondence `IsRecT` and the `LlOf.lean` Projection Adapter

The central forensic finding of Chapter 3 is how the archive formalizes and streamlines the $\mathrm{GL}_n$ local Langlands correspondence of Harris-Taylor (`2001`) and Henniart (`2000`).
Opening `Development/AutomorphicArithmetic/Foundations/LocalLanglands/IsRecTOfIsRec.lean:20-85` (`in_degree = 775`) reveals that instead of relying solely on the classical specification `IsRec` demanding full bijectivity and $\varepsilon$-factor preservation across all supercuspidal representations over an arbitrary nonarchimedean local field $k$, the core interface is defined by a hybrid weakened-and-strengthened specification `IsRecT` concentrated on a **good supercuspidal locus `GoodCusp`**.

```lean
-- Development/AutomorphicArithmetic/Foundations/LocalLanglands/IsRecTOfIsRec.lean:20-27, 55-80
def GoodCusp (y : IrrGL k) : Prop :=
  y.1 = 1 ∨ ((∃ (g : ℕ) (_ : Fact g.Prime) (i : ℚ_[g] ≃+* k), Continuous i) ∧
    ∃ (y₀ : IrrGL k) (χ : kˣ →* ℂˣ) (hχ : IsSmoothChar χ),
      GlobalTheory.PRep.fixed y₀.rep (GlobalTheory.SplitWeil.KOne k (Fin y₀.1)) ≠ ⊥ ∧ y = y₀.tw χ hχ)

def Good (x : IrrGL k) : Prop := ∃ s, HasSupport x.rep s ∧ ∀ y ∈ s, GoodCusp y
```

Translating this definition into mathematical formulas exposes a tightly calibrated strategic reduction. An irreducible smooth representation $y \in \mathrm{Irr}(\mathrm{GL}_m(k))$ belongs to `GoodCusp` if and only if it satisfies one of two clauses:

$$
\mathrm{GoodCusp}(y) \iff (m = 1) \;\lor\; \Bigl( k \simeq_{\mathrm{top}} \mathbb{Q}_g \;\land\; \exists y_0, \chi:\; y_0^{1 + g M_m(\mathbb{Z}_g)} \neq 0 \;\land\; y \cong y_0 \otimes (\chi \circ \det) \Bigr)
$$

That is, `GoodCusp` selects only one-dimensional quasicharacters or **character twists of Moy-Prasad depth-`0` representations $y_0$** admitting nonzero fixed vectors under the first congruence subgroup $K_1 = I_m + g M_m(\mathbb{Z}_g)$ (`KOne k`) when the base local field is **topologically isomorphic to an absolutely unramified primeadic field $\mathbb{Q}_g$**. `Good(x)` then designates representations whose supercuspidal support consists exclusively of factors in `GoodCusp`.
Over this locus, the axiom structure `LawsT a ha rc` (`L55-73`) for the Weil-Deligne map $\mathrm{rc} : \mathrm{IrrGL}(E_w) \to \mathrm{WD}(E_w)$ imposes a two-tiered system of conditions.

1. **Global Conditions Across All of $\mathrm{IrrGL}(E_w)$ (`L57-64`)**: Dimension preservation $\dim \mathrm{rc}(x) = n$, compatibility with local Artin reciprocity $\mathrm{rc}(\chi) = \chi \circ a$ for $n=1$, additivity across the Langlands multisegment classification $\mathrm{rc}(L(\Delta_1, \dots, \Delta_r)) = \bigoplus_j \mathrm{rc}(\Delta_j)$, irreducibility of the Weil-Deligne image on supercuspidal inputs (`IsIrrWD`), unramified complex power shifts $\mathrm{rc}(x \otimes \lvert\det\rvert^s) = \mathrm{rc}(x)(s)$, and preservation of central-character absolute values $\prod \lvert \lambda_i(\mathrm{rc}(x)(\sigma)) \rvert = \lvert \omega_x(a(\sigma)) \rvert$.
2. **Fine Conditions Restricted to the `Good` Sub-Locus (`L65-72`)**: Conditional on `Good x`, the specification requires exact character-twist compatibility (`twist`), signed central-character equality $\det \mathrm{rc}(x)(\sigma) = \omega_x(a(\sigma))$ (`central`), contragredient duality $\mathrm{rc}(\pi^\vee) = \mathrm{rc}(\pi)^\vee$ (`dual`), injectivity against `Good y` ($\mathrm{rc}(x) = \mathrm{rc}(y) \implies x = y$, `inj`), tame ramification at depth `0` (`IsTameWD`, `depth`), and the explicit **depth-`0` inertia polynomial formula `TypeLaw`** (`L35-53`).

In `L35-53`, `TypeLaw` stipulates that whenever a cuspidal representation $\tau$ of the finite general linear group $\mathrm{GL}_n(\mathbb{F}_g)$ induced from a Green (`1955`) regular torus character $\theta : \mathbb{F}_{g^n}^\times \to \mathbb{C}^\times$ (`IsRegularChar g n θ`, over `normV w' = g ^ n` with $(g) \notin w'^2$) inflates (`Inflates`) to a depth-`0` representation $\sigma$, the associated Weil-Deligne representation $\mathrm{rc}(\sigma)$ has zero monodromy (`mono0`) and its characteristic polynomial on any tame inertia element $t \in I_{E'}$ (with local Artin image $a'(t) \equiv z \pmod{\mathfrak{p}_{E'}}$) equals the product over Frobenius Galois conjugates:

$$
P_{\mathrm{inert}}\bigl(\mathrm{rc}(\sigma)\rvert_{I_{E'}}(t), X\bigr) = \prod_{j=0}^{n-1} \Bigl( X - \theta\bigl(z^{g^j}\bigr) \Bigr)
$$

(matching Bushnell-Henniart `2006`, *The Local Langlands Conjecture for GL(2)*, and the Silberger-Zink depth-`0` Macdonald correspondence). The rationale for introducing this **Type II-B sub-locus specialization** lies in the exact scope of the archive's zero-elimination engine: the new zero-elimination engine never requires higher wildly ramified supercuspidal representations, needing only Satake and inertia eigenvalue tracking at auxiliary places (`g.Prime`) that split over $\mathbb{Q}$ or have depth `0`.
Consequently, instead of invoking the full Harris-Taylor vanishing-cycles machinery on Shimura varieties, the archive constructs `RecTExists` directly from depth-`0` Deligne-Lusztig and Green character theory in `Development/AutomorphicArithmetic/Foundations/LocalLanglands/LocalCentralUnits/RecTExists.lean:20-66`.
Furthermore, inspecting `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/LlOf.lean:18-21` shows `namespace Old` emptied out and `namespace New` refactored into a pure first-argument projection adapter:

```lean
-- Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/LlOf.lean:18-21
theorem llOf_alt : RecTExists → LocalConverseGL → DepthZeroInduction →
    BrauerDegreeZero → ChevalleyUnits → GlobalArtinReciprocity → LanglandsExhaustionGL → LanglandsMultisegments →
    StandardCosocleGL → ZelevinskyPolynomialRing → GeometricLemma → BernsteinZelevinskyFiniteness → RecTExists :=
  fun h _ _ _ _ _ _ _ _ _ _ _ => h
```

discarding the remaining `11` arguments and returning `h : RecTExists` directly (while the full classical deduction of `LocalLanglandsGL` from depth-`0` induction, Brauer induction, and the local converse theorem remains preserved separately in `Development/AbelianVarietyTheory/Proofs/InertiaEigenvalues/LocalLanglandsOfHyp.lean:22-49`).
When human mathematicians author a 150-page condensed paper, citing the classical theorem `IsRec` of Harris-Taylor (`2001`) and Henniart (`2000`) together with the Bushnell-Henniart depth-`0` inertia formula `DepthZeroTypeInertia` connects seamlessly via the one-line translation adapter `isRecT_of_isRec : DepthZeroTypeInertia → IsRec h rc → IsRecT h rc` in `Development/AutomorphicArithmetic/Foundations/LocalLanglands/IsRecTOfIsRec.lean:106-113`.

---

### 3.3 Polarized Galois Representations and $\ell = p$ Local-Global Compatibility (`PolarizedGaloisRepPublished`, `CaraianiLocalGlobalDual`) Audit

The Galois-representation construction theorems of Clozel-Harris-Taylor (`2008`), Shin (`2011`), Caraiani (`2012`, `2014`), and Barnet-Lamb-Gee-Geraghty-Taylor (`2014`) are formalized at full **Type I** fidelity in `Development/AbelianVarietyTheory/PublishedTheorems/GaloisGeometry₂/PolarizedGaloisRepPublished.lean:20-73` and `Development/AbelianVarietyTheory/PublishedTheorems/GaloisGeometry₂/CaraianiLocalGlobalDual.lean:16-29`.

In the source text, `PolarizedGaloisRepPublished` (`L67-73`) asserts that for any CM number field $E$ (with maximal totally real subfield $F = E^+$), prime $\ell$, field isomorphism $\iota : \overline{\mathbb{Q}}_\ell \xrightarrow{\sim} \mathbb{C}$, degree $a \ge 1$, regular algebraic cuspidal representation $\pi$ (`(CG.mk π).IsRegAlg`), and polarized Hecke character pair $(\pi, \chi)$ (`PolarizedPair π χ`, encoding $\pi^\vee \cong \pi^c \otimes (\chi \circ \mathrm{Nm}_{E/F} \circ \det)$ together with the sign condition), there exist a continuous semisimple Galois representation $r : \mathrm{Gal}(\overline{E}/E) \to \mathrm{GL}_a(\overline{\mathbb{Q}}_\ell)$, an integer weight $\mathrm{wt} \in \mathbb{Z}$, and a Hodge-Tate multiset family $HT : \mathrm{Hom}(E, \overline{\mathbb{Q}}_\ell) \to \mathrm{Multiset}(\mathbb{Z})$ satisfying the six clauses of `GalHyps.Props` (`L36-62`).

1. **Polarized Conjugate Self-Duality (`pol`, `L43-44`)**: With $\mu$ denoting the $\ell$-adic character attached to $\chi$ and $c \in \mathrm{Aut}(\Omega)$ a complex conjugation lift, $r^c \cong r^\vee \otimes \epsilon_{\mathrm{cyc}}^{1-a} \mu\rvert_{G_E}$ (`IsConjDual`).
2. **$\ell \nmid w$ Local-Global Compatibility and Purity (`away`, `pure`, `L46-50`)**: At every finite place $w \nmid \ell$, $\mathrm{WD}(r\rvert_{G_{E_w}}) = \mathrm{rc}(\pi_w \otimes \lvert\det\rvert^{(1-a)/2})$ (`algNorm σ`), and its twist by $\mathrm{wt}/2$ is tempered (`tempered`).
3. **Infinitesimal Character and Hodge-Tate Jump Correspondence (`weights`, `weights_conj`, `L52-56`)**: At each embedding $\tau : E \hookrightarrow \overline{\mathbb{Q}}_\ell$, the Harish-Chandra infinitesimal character multiset $m_\tau \subset \mathbb{C}$ of $\pi_\infty$ and the Hodge-Tate weights $HT(\tau) \subset \mathbb{Z}$ satisfy the classical half-integral shift formulas:

    $$
    HT(\tau) = \left\{ \frac{a - 1}{2} - z \;\middle|\; z \in m_{\iota \circ \tau} \right\}, \qquad HT(\tau \circ c) = \bigl\{ \mathrm{wt} - h \;\big|\; h \in HT(\tau) \bigr\}
    $$

4. **$\ell \mid w$ $p$-adic Hodge Compatibility (`Above`, `L20-35`)**: At every place $w \mid \ell$, the restriction $r\rvert_{D_w}$ is de Rham (`IsdRAt`) with Hodge-Tate jumps equal to $HT(\tau)$ at each induced embedding (`jumps`). Moreover, if $\pi_w$ admits Iwahori-fixed vectors then $r\rvert_{D_w}$ is semistable (`IsSstAt`) with Fontaine Weil-Deligne image `wdAt` equal to `rc (algNorm σ)` (`iwahori`), and if $\pi_w$ is unramified spherical (`IsSpherical`) then $r\rvert_{D_w}$ is crystalline (`IsCrysAt`, `crys`).

Going further, `Development/AbelianVarietyTheory/PublishedTheorems/GaloisGeometry₂/CaraianiLocalGlobalDual.lean:16-29` drops the Iwahori assumption to assert potential semistability (`IsPstAt`) and the Weil-Deligne identity `wdAt P ι Bw h hj (R.comp Dec.subtype) = rc (algNorm σ)` at all places $w \mid \ell$ (Caraiani `2014`, Duke Math. J. 163), while `Development/AbelianVarietyTheory/Proofs/SatakeParameters/LocalGlobalAboveL.lean:20-37` combines Weil-group trace agreement at places $w' \nmid \ell$ with Chebotarev semisimple conjugacy uniqueness (`semisimple_conj_of_trace_equal`) to transfer $\ell \mid w$ compatibility to any polarized Galois representation $r$.
For $n = 1$ algebraic Hecke characters, the corresponding Weil-Deligne identity `AlgebraicCharacterWD` is defined in `Development/AbelianVarietyTheory/PublishedTheorems/GaloisGeometry₂/AlgebraicCharacterWD.lean:14-24` and proved directly in `Development/AutomorphicArithmetic/ThetaCorrespondence/AlgebraicCharacters/AlgebraicCharacterWD.lean:9-33` via local-global Artin commutativity and Hodge-Tate exponent cancellation (`locPow * ∏ τ(a σ)^(-n) = 1`, `L21-27`).

---

### 3.4 Jacquet-Shalika Isobaric Rigidity, Satake Bounds, and Bernstein Unitary Induced Product Irreducibility Audit

The Jacquet-Shalika and Bernstein theorems governing rigidity of the $\mathrm{GL}_n$ automorphic spectrum and irreducibility of local parabolic induction are formalized in the source text as **pure Type I** propositions free of any custom-structure distortion.

First, `JacquetShalikaRigidity` and `JacquetShalikaBound` in `Development/AbelianVarietyTheory/PublishedTheorems/GaloisCohomology₂/StrongMultiplicityOne.lean:189-203` (`in_degree = 463`) declare the following two propositions for cuspidal equivalence classes `CG E m` over a totally complex number field $E$ (`IsTotallyComplex E`).

```lean
-- Development/AbelianVarietyTheory/PublishedTheorems/GaloisCohomology₂/StrongMultiplicityOne.lean:189-203
def JacquetShalikaRigidity : Prop :=
  ∀ (E : Type) [Field E] [NumberField E] [IsTotallyComplex E] (ι κ : Type) [Fintype ι] [Fintype κ]
    (m : ι → ℕ) (m' : κ → ℕ) (π : ∀ i, CG E (m i)) (π' : ∀ j, CG E (m' j)),
    (∀ i, 1 ≤ m i) → (∀ j, 1 ≤ m' j) →
    (∀ᶠ w : HeightOneSpectrum (𝓞 E) in Filter.cofinite, ∃ (B : ι → Multiset ℂˣ) (B' : κ → Multiset ℂˣ),
      (∀ i, (π i).HasSat w (B i)) ∧ (∀ j, (π' j).HasSat w (B' j)) ∧ ∑ i, B i = ∑ j, B' j) →
    ∃ s : ι ≃ κ, ∀ i, (⟨m i, π i⟩ : Σ a, CG E a) = ⟨m' (s i), π' (s i)⟩

def JacquetShalikaBound : Prop :=
  ∀ (E : Type) [Field E] [NumberField E] [IsTotallyComplex E] (a : ℕ) (π : CG E a), π.IsUnitary →
    ∀ (w : HeightOneSpectrum (𝓞 E)) (B : Multiset ℂˣ), π.HasSat w B → ∀ α ∈ B,
      (Ideal.absNorm w.asIdeal : ℝ) ^ (-(1 / 2) : ℝ) < ‖(α : ℂ)‖ ∧ ‖(α : ℂ)‖ < (Ideal.absNorm w.asIdeal : ℝ) ^ (1 / 2 : ℝ)
```

Written in mathematical notation, if the unramified Satake parameter multiset sums of two formal isobaric sums $\boxplus_{i \in \iota} \pi_i$ and $\boxplus_{j \in \kappa} \pi'_j$ coincide at all but finitely many finite places $w$ ($\bigsqcup_{i \in \iota} B_{i,w} = \bigsqcup_{j \in \kappa} B'_{j,w}$), then there exists a bijection $s : \iota \xrightarrow{\sim} \kappa$ matching every degree and cuspidal summand pair $(m_i, \pi_i) = (m'_{s(i)}, \pi'_{s(i)})$, reproducing Theorem 4.4 of Jacquet-Shalika (`1981`, *On Euler products and the classification of automorphic representations II*, Am. J. Math. 103) directly (with single-cuspidal strong multiplicity one `strong_multiplicity_one` and real-power shift uniqueness `unitary` deduced immediately at `L208-244`). Likewise, `JacquetShalikaBound` states that every unramified Satake eigenvalue $\alpha \in B_w$ of a cuspidal representation with unitary central character satisfies the strict inequality

$$
q_w^{-1/2} < \lvert \alpha \rvert < q_w^{1/2} \qquad \bigl(q_w := \mathrm{Nm}(\mathfrak{p}_w)\bigr)
$$

matching Part I, Lemma 2.5 of Jacquet-Shalika (`1981`) (restricting the base field to `IsTotallyComplex E` is a mild domain convention reflecting its use on CM base change). The proof concludes in `Development/WeilBound/CoreStatements/PublishedTheorems/JacquetShalikaRigidity/JacquetShalikaRigidity.lean:10-16` via Rankin-Selberg pole detection (`rsPole`).

Second, `BernsteinUnitaryProductIrreducible` in `Development/AbelianVarietyTheory/PublishedTheorems/TwistedTraceFormula/BernsteinUnitaryProductIrreducible.lean:10-16` (`in_degree = 118`) asserts that for any nonarchimedean local field $k$ and degrees $r, t \in \mathbb{N}$, the normalized parabolic product $\pi_1 \times \pi_2$ (`prod₂ π₁ π₂`) of any two smooth irreducible unitarizable (`IsUnitarisable`) representations $\pi_1$ of $\mathrm{GL}_r(k)$ and $\pi_2$ of $\mathrm{GL}_t(k)$ is irreducible.
This is an exact **Type I** formalization of Theorem 0.2 of Joseph Bernstein (`1984`, *P-invariant distributions on GL(N) and the classification of unitary representations of GL(N)*, Springer LNM 1041), with its witness supplied in `Development/WeilBound/RepresentationTheoryGL/UnitaryDualProof/BernsteinExponentBounds/BernAll.lean:27-28`.
Care should be taken not to confuse this file with `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/BernsteinUnitaryProductIrreducible.lean:12-85`, which shares the same basename but is an assembly module defining the `60`-field third-place hypothesis bundle `UnitaryGroupThirdPlaceHypotheses`.

| Audited Specification Identifier | Source Location (Relative to `src/`) | Citations | Classical Reference | Equivalence Class and Audit Summary |
| :--- | :--- | ---: | :--- | :--- |
| `CaraianiTempered` | `Development/AbelianVarietyTheory/PublishedTheorems/GaloisGeometry₂/CaraianiTempered.lean:13-18` | `5` (stub `2,242`) | Caraiani (2012), Clozel (1991), Shin (2011) | **Type I**: Temperedness at all finite places for CM $n \ge 2$ cohomological conjugate self-dual cuspidal representations. Exact match with the original paper |
| `IsRecT` / `RecTExists` | `Development/AutomorphicArithmetic/Foundations/LocalLanglands/IsRecTOfIsRec.lean:55-81` | `775` | Harris-Taylor (2001), Bushnell-Henniart (2006), Green (1955) | **Type II-B**: Imposes injectivity and the inertia polynomial `TypeLaw` on the $\mathrm{GL}_1$ and $\mathbb{Q}_g$ depth-`0` twist locus `GoodCusp`. Adapter supplied by `isRecT_of_isRec` |
| `PolarizedGaloisRepPublished` | `Development/AbelianVarietyTheory/PublishedTheorems/GaloisGeometry₂/PolarizedGaloisRepPublished.lean:67-73` | via `16` | CHT (2008), Shin (2011), BLGGT (2014) | **Type I**: Complete $\ell$-adic Galois representations, Hodge-Tate jumps, and Iwahori/spherical $p$-adic Hodge compatibility for regular algebraic polarized cuspidal pairs |
| `CaraianiLocalGlobalDual` | `Development/AbelianVarietyTheory/PublishedTheorems/GaloisGeometry₂/CaraianiLocalGlobalDual.lean:16-29` | `16` | Caraiani (2012, 2014) | **Type I**: Potential semistability (`IsPstAt`) and Fontaine `wdAt` agreement at arbitrarily ramified places $w \mid \ell$. Matches the published theorem verbatim |
| `AlgebraicCharacterWD` | `Development/AbelianVarietyTheory/PublishedTheorems/GaloisGeometry₂/AlgebraicCharacterWD.lean:14-24` | `63` | Weil (1956), Serre (1968), Tate (1979) | **Type II-A**: Formalizes local Weil-Deligne compatibility of algebraic Hecke characters over the archive's `LocPrime` and `LocBridge` period-ring bridges |
| `JacquetShalika` | `Development/AbelianVarietyTheory/PublishedTheorems/GaloisCohomology₂/StrongMultiplicityOne.lean:189-203` | `463` | Jacquet-Shalika (1981) | **Type I**: Uniqueness of isobaric decomposition from Satake multiset agreement and the bound $q_w^{-1/2} < \lvert\alpha\rvert < q_w^{1/2}$. Exact match with the original paper |
| `BernsteinUnitaryProductIrreducible` | `Development/AbelianVarietyTheory/PublishedTheorems/TwistedTraceFormula/BernsteinUnitaryProductIrreducible.lean:10-16` | `118` | Bernstein (1984) | **Type I**: Irreducibility of parabolic products of unitary irreducible representations of nonarchimedean $\mathrm{GL}_r(k) \times \mathrm{GL}_t(k)$. Exact match with the original paper |

---

### 3.5 Everywhere-Unramified Base Change (`DefiniteN`) and Globalized Gelfand-Kazhdan Duality Audit

As the concluding audit items of Chapter 3, dissecting entries `022` (`base_change_definite_unitary_group_of_literature`, `L261-262`) and `037` (`gelfand_kazhdan_dual_of_literature`, `L291-292`) of `EveryCharacterOfLiteratureOfVWin.lean` in the source text uncovers two distinctive formulations that cannot be guessed from their identifiers alone.

First, opening `DefiniteN` (the underlying definition of `BaseChangeDefiniteUnitaryGroup`) in `Development/AutomorphicArithmetic/Foundations/BaseChangeIdentities/Narrow.lean:12-35`, which governs standard base change from totally definite unitary groups to $\mathrm{GL}_n(\mathbb{A}_E)$, reveals the following explicit premise:

```lean
-- Development/AutomorphicArithmetic/Foundations/BaseChangeIdentities/Narrow.lean:28-35
def DefiniteN : Prop :=
  ∀ (E : Type) [Field E] [NumberField E] [IsCMField E],
    (∀ w : HeightOneSpectrum (𝓞 E), Algebra.IsUnramifiedAt (𝓞 (maximalRealSubfield E)) w.asIdeal) →
    ∀ n : ℕ, 1 ≤ n → ∀ π : Submodule ℂ (UA E n → ℂ), IsAutRepU π →
      ∃ (c : ℕ) (N : Fin c → ℕ) (h : ∑ i, N i = n) (V : ∀ i, Submodule ℂ (Sm E (N i)))
        (σ : ∀ i (w : HeightOneSpectrum (𝓞 E)), SmIrr (GL (Fin (N i)) (w.adicCompletion E)))
        (m : Fin c → (E →+* ℂ) → Multiset ℂ), IsBaseChangeU π h V σ m
```

Line `L30`, `∀ w, Algebra.IsUnramifiedAt (𝓞 (maximalRealSubfield E)) w.asIdeal`, deserves close attention. The general base-change theorems of Labesse (`2011`) and Shin (`2014`) hold over arbitrary CM extensions $E/F$, where ramified finite places require local Langlands-Shelstad transfer factors and the Fundamental Lemma.
By contrast, when constructing auxiliary CM extensions of class number at least `1`, this archive selects exclusively **CM extensions unramified (`IsUnramifiedAt`) at every finite place over the maximal totally real subfield $E^+$**.
Consequently, every finite place is either split (`IsSplitAt`, `L25`) or unramified inert (`IsUnramInv`, `L22-24`), bypassing ramified endoscopic transfer altogether and closing the lift to an isobaric discrete sum $\boxplus_{i=1}^c V_i$ ($\sum_i N_i = n$, each $V_i$ in the conjugate self-dual discrete spectrum `CsdAsc`) purely via unramified spherical Satake parameter matching `bcParam n α` (**Type II-B sub-locus specialization**).

Second, opening `gelfandKazhdanDual_of_rigidity` in `Development/WeilBound/CoreStatements/TemperedRepresentationTheory/MultiplicityOneRigidity/GelfandKazhdanDualOfRigidity.lean:64-79` reveals that `GelfandKazhdanDual` is formalized not as the $p$-adic local distribution theorem of Gelfand-Kazhdan (`1975`), but **globalized as the isomorphism (`InvTransposeModel π`) between the inverse-transpose space $\pi^\iota = \{\varphi(g^{-T}) \mid \varphi \in \pi\}$ (`dualSubC π`) of a global cuspidal automorphic space $\pi \subset \mathcal{A}_0(\mathrm{GL}_n(\mathbb{A}_E))$ and its contragredient Petersson dual**.
This design enables the archive, without routing again through local Bernstein-Zelevinsky distribution theory, to verify agreement of Satake parameters between $\pi^\iota$ and $\pi^\vee$ at almost all unramified places (`hasSat_dual`, `L69`) and immediately apply Jacquet-Shalika strong multiplicity one (`hJ.strong_multiplicity_one`, `L66`) from Section 3.4 to establish $\pi^\iota \cong \pi^\vee$ globally (used directly in `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/SPairs.lean:11-14` when passing polarized cuspidal pairs into Galois-representation inputs).

Third, `GenericUnitaryDualGL` in `Development/AbelianVarietyTheory/PublishedTheorems/GaloisCohomology₂/IsComplementaryProductOfIsCuspidal.lean:14-33`, which closes the local unitary dual classification, states that over any characteristic-`0` nonarchimedean local field $k$, every smooth irreducible unitarizable generic (`IsGeneric`, admitting a nondegenerate Whittaker model) representation $\pi$ of $\mathrm{GL}_N(k)$ is isomorphic to an irreducible parabolic product (`IsComplementaryProduct π`) of unitary Langlands segments $\delta_i$ and complementary-series pairs $\tau_j \lvert\det\rvert^{\sigma_j} \times \tau_j \lvert\det\rvert^{-\sigma_j}$ with exponents $0 < \sigma_j < 1/2$.
This is a **Type I proposition** matching the classification theorem of M. Tadić (`1986`, Ann. Sci. ENS 19), proved by inductive exponent analysis in `Development/WeilBound/CoreStatements/AutomorphicKernels/UnitaryDualGL/GenericUnitaryDual/GenericUnitaryDualGLHolds.lean:53-107`.

---

## Chapter 4. Source Audit of the Siegel-Weil Formula, Eisenstein Second Term, Regularized Theta Lifts, and Mirabolic Specifications

### 4.1 Weil Absolute-Convergence Range vs. Kudla-Rallis-Ichino Analytic-Continuation Siegel-Weil Formula and Eisenstein Specification Anatomy

Over a unitary dual pair $(U(A), U(B))$, the Siegel-Weil formula identifying the constant term or mean value of a theta integral with a special value of a Siegel Eisenstein series is split inside the archive into two distinct `Prop` definitions according to rank-inequality regimes.
First, the unitary dual-pair pullback specification of the Weil representation itself, `Development/AbelianVarietyTheory/PublishedTheorems/AutomorphicForms₂/WeilRepresentationUnitaryPair.lean:12-16` (`in_degree = 780`), asserts for a master datum `D : D7`, standard additive character $\psi : \mathbb{A}_F / F \to \mathbb{C}^\times$, Hermitian spaces $S, T \in \mathrm{HSp}(D)$, and circle-valued Hecke characters $\chi_S, \chi_T : \mathbb{A}_E^\times / E^\times \to S^1$ whose restrictions to $\mathbb{A}_F^\times$ equal $\eta_{E/F}^{\mathrm{rk}(S)}$ and $\eta_{E/F}^{\mathrm{rk}(T)}$ (`ResEta`) the existence of an adelic Weil action homomorphism $\omega : U(S)(\mathbb{A}_F) \times U(T)(\mathbb{A}_F) \to \mathrm{End}_{\mathbb{C}}(\mathcal{S}(W_{S,T}(\mathbb{A}_F)))$ (`IsWeilDatumO ψ S T χS χT ω`) incorporating Kudla's (`1994`) splitting homomorphisms.

When pairing the doubled Hermitian space $S = A \oplus (-A)$ (`dblSp A`, split Hermitian space of signature $(r_A, r_A)$) with a target space $B$ under this Weil representation, the classical Siegel-Weil convergence threshold is governed by comparing $r_B$ with $2 r_A$ alongside the Witt index $\mathrm{ind}_{\mathrm{Witt}}(B)$.
Placing `Development/AbelianVarietyTheory/PublishedTheorems/TwistedTraceFormula/WeilSiegelFormulaUnitary.lean:56-70` and `Development/AbelianVarietyTheory/PublishedTheorems/SiegelWeil₂/SiegelWeilUnitaryConvergent.lean:18-33` side by side displays this separation directly in code.

```lean
-- Development/AbelianVarietyTheory/PublishedTheorems/TwistedTraceFormula/WeilSiegelFormulaUnitary.lean:56-70
def WeilSiegelFormulaUnitary : Prop :=
  ∀ (D : D7) (A B : HSp D) (m : Measure (GA D B)), m.IsHaarMeasure → 1 ≤ A.rank →
    (Formalism.MainNotions.SchurIrreducible.wittIdx B = 0 ∨ A.rank + Formalism.MainNotions.SchurIrreducible.wittIdx B < B.rank) →
    (∀ (d : ℕ) (ε : Module.Basis (Fin d) D.host.F D.host.E),
      ∃ ν : Seminorm ℂ (WeilM.schA D.host.F (Fin B.rank × Fin A.rank × Fin d)), IsContSeminorm ν ∧
        ∀ φ : WeilM.schA D.host.F (Fin B.rank × Fin A.rank × Fin d),
          absThetaInt B m (φ.1 ∘ coord ε) ≤ ENNReal.ofReal (ν φ)) ∧
    ∀ (ψ : AddChar (AF D.host.F) ℂ) (χ : (AE D)ˣ →* Circle)
      (ω : GA D (dblSp A) × GA D B →* Module.End ℂ (WO (dblSp A) B → ℂ)),
      IsWeilDatumO ψ (dblSp A) B 1 χ ω → ∀ f, IsThetaFunO ψ (dblSp A) B f →
      (∀ g, Integrable (descend (GQ B) fun h => thetaKO ω g h f) (autMeasure B m)) ∧
      (2 * A.rank < B.rank → ∀ ν 𝓖, IsCovolOne (ratL B A) ν 𝓖 →
        LeftInv (siegelQ A) (swSection A B ν 𝓖 ω f) ∧ ∀ g, CosetConv (siegel A) (GQ (dblSp A)) (swSection A B ν 𝓖 ω f) g ∧
          cosetSum (siegel A) (GQ (dblSp A)) (swSection A B ν 𝓖 ω f) g =
            ⨍ q, descend (GQ B) (fun h => thetaKO ω g h f) q ∂autMeasure B m)

-- Development/AbelianVarietyTheory/PublishedTheorems/SiegelWeil₂/SiegelWeilUnitaryConvergent.lean:18-33
def SiegelWeilUnitaryConvergent : Prop :=
  ∀ (D : D7) (ψ : AddChar (AF D.host.F) ℂ) (A B : HSp D), A.rank < B.rank → B.rank ≤ 2 * A.rank →
    A.rank + Formalism.MainNotions.SchurIrreducible.wittIdx B < B.rank →
  ∀ (χB : (AE D)ˣ →* Circle) (ω : GA D (dblSp A) × GA D B →* Module.End ℂ (WO (dblSp A) B → ℂ)),
    IsWeilDatumO ψ (dblSp A) B 1 χB ω →
  ∀ a : GL (Fin A.rank) (AE D), IsMaj A a → HasIwasawa D.sp.cm.sig (dblSp A).gram (Khat A a) →
  ∀ (θ : InfFam D) (sS : RealMat (dblSp A)) (sB : RealMat B), IsInfFam θ →
    (∀ τ, IsCartanInv (gramAt D (dblSp A) τ) (sS τ)) → (∀ τ, IsCartanInv (gramAt D B τ) (sB τ)) →
    (∀ k ∈ Khat A a, ∀ τ, compAt θ τ (Formalism.L2.Theta.mt (dblSp A) k) * sS τ =
      sS τ * compAt θ τ (Formalism.L2.Theta.mt (dblSp A) k)) →
  ∀ (μ : Measure (WO A B)) (𝓨 : Set (WO A B)), IsCovolOne (ratL B A) μ 𝓨 →
  ∀ ν : Measure (GA D B), ν.IsHaarMeasure →
  ∀ f : WO (dblSp A) B → ℂ, IsFockVec ψ θ (dblSp A) B sS sB f →
    (∀ g, Integrable (AutomorphicL2Unitary.descend (GQ B) fun h => thetaKO ω g h f) (autMeasure B ν)) ∧
    Eis.EisValueAt A (flat A a (swSec A B ω μ 𝓨 f) (sZero A B)) (sZero A B) (thetaMean ω ν f)
```

The mathematical division of labor between the two specifications is as follows.

1. **Weil Absolute-Convergence Range (`WeilSiegelFormulaUnitary`, $r_B > 2 r_A$)**: Under Weil's convergence criterion $\mathrm{ind}_{\mathrm{Witt}}(B) = 0$ or $r_A + \mathrm{ind}_{\mathrm{Witt}}(B) < r_B$, the theta kernel $\Theta_\omega(g, h; f)$ is absolutely integrable over $[U(B)] = U(B)(F)\backslash U(B)(\mathbb{A}_F)$ and dominated by a continuous Schwartz seminorm $\nu(\varphi)$ (`L59-62`).
In the strict convergence range $r_B > 2 r_A$, the coset series over the Siegel parabolic quotient $P_{\mathrm{Sieg}}(F)\backslash U(A \oplus -A)(F)$ converges absolutely (`CosetConv`) and equals the normalized mean theta integral pointwise (Weil `1965`):

    $$
    \sum_{\gamma \in P_{\mathrm{Sieg}}(F)\backslash U(A \oplus (-A))(F)} \Phi_f(\gamma g) = \frac{1}{\mathrm{vol}\bigl([U(B)]_\nu\bigr)} \int_{[U(B)]} \Theta_\omega(g, h; f)\, d\nu(h) \qquad (r_B > 2 r_A)
    $$

2. **Ichino Half-Convergent / Analytic-Continuation Range (`SiegelWeilUnitaryConvergent`, $r_A < r_B \le 2 r_A$)**: In this interval, the Siegel Eisenstein series $E(g, s; \Phi_f)$ fails to converge absolutely at the evaluation point $s_0 = \frac{r_B - r_A}{2}$ (`sZero A B`), whereas the theta integral still converges absolutely under Weil's inequality $r_A + \mathrm{ind}_{\mathrm{Witt}}(B) < r_B$.
The source text states that for any archimedean polynomial Fock vector $f$ (`IsFockVec`) aligned with Cartan involutions (`IsCartanInv`), the Eisenstein series attached to the flat section `flat A a (swSec ... f) s₀` admits a holomorphic analytic-continuation value (`Eis.EisValueAt`) at $s = s_0$ equal to the theta mean `thetaMean ω ν f`.
This is the `D7` projection (**Type II-A**) of the half-convergent Siegel-Weil theorem established beyond Kudla-Rallis (`1994`) by Ichino (`2001`, `2004`, *A regularized Siegel-Weil formula for unitary groups*, Math. Z. 247).

Two additional naming discrepancies and refactoring artifacts merit explicit forensic documentation.

- **Inactive Sealing of `SiegelEisensteinSimplePole`**: `Development/AbelianVarietyTheory/PublishedTheorems/SiegelWeil₂/SiegelEisensteinSimplePoleOfDoublingMethod.lean:14-20` declares the specification that the doubling Eisenstein series has at most a simple pole (`EisPoleLE ... 1`) at $s_0 = (b - r_V)/2$ ($b > r_V$).
Because the upstream continuation theorem `SiegelEisensteinContinuation` together with the doubling zeta integral `ResidueKilled.DM` (`Development/WeilBound/RepresentationTheoryGL/EisensteinResidues/AnisotropicGlobalForms/DmOfHyp.lean:13-35`) already internalizes holomorphy and residue control at $s_0$, the slot is sealed as `UnusedSlot72 := trivial` at `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/EveryCharacterOfLiteratureOfVWin.lean:505-506`.
- **Actual Role of `SiegelEisensteinSecondTermHypotheses.lean`**: Judged by its filename alone, `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/SiegelEisensteinSecondTermHypotheses.lean:44-73` (`76` lines) appears to hold hypotheses for the Kudla-Rallis second-term Laurent identity of Siegel Eisenstein series.
Inspecting the entire file reveals instead that it transplants the earlier assembler `hypsE₂` / `everyE₂` from `Development/AutomorphicArithmetic/ThetaCorrespondence/FockModels/EveryCharacterE.lean:41-72` into the third-place `RecTExists` framework, serving as the **top-level definite-side hypothesis nonemptiness and `EveryCharacter` deduction assembler** (`nonempty_hyps_definite_side_of_closed_bound` and `every_character_of_theta_integrals_local_matching`).
Thus the filename is a directory legacy from an earlier exploration of Eisenstein second-term bounds, whereas the active proof closes seesaw inner products and the nonvanishing evaluation grid (`GridA (max CF0 CF1)`) using first-term convergent and half-convergent Siegel-Weil formulas (`SiegelWeilUnitaryConvergent` and `SiegelWeilStd`) alone.

---

### 4.2 Seesaw Identity, Rallis Inner Product Formula (`RallisDM`), and `TheoremKOfMod` Local Matching Audit

The key analytic tool proving nonvanishing ($\neq 0$) of theta lifts $\Theta_{\Phi_i}(f_i)(h) = \int_{[U(A)]} \Theta_\omega(g, h; \Phi_i) \overline{f_i(g)}\, dm(g)$ of cusp forms $f_1, f_2 \in \mathcal{A}_0(U(A))$ is the Rallis inner product formula.
Comparing the specification `Development/AbelianVarietyTheory/PublishedTheorems/TwistedTraceFormula/LowerLiftsZeroOfWittIdxEqZero.lean:41-60` with its proof in `Development/AutomorphicArithmetic/ThetaCorrespondence/FockModels/RallisDM.lean:24-111` reconstructs the seesaw duality argument without omission.

1. **First-Occurrence Convergence Conditions (`Development/AbelianVarietyTheory/PublishedTheorems/TwistedTraceFormula/LowerLiftsZeroOfWittIdxEqZero.lean:42-53`)**: Assume $r_A < r_B \le 2 r_A$, either $B$ is anisotropic ($\mathrm{ind}_{\mathrm{Witt}}(B) = 0$) or $r_A + \mathrm{ind}_{\mathrm{Witt}}(B) < r_B$, and all theta lifts to lower steps of the Witt tower of $B$ vanish (`LowerLiftsZero`).
Under these hypotheses, the theta lifts $\Theta_{\Phi_i}(f_i)$ converge absolutely on $[U(B)]$ and lie in $L^2_{\mathrm{cusp}}([U(B)])$ (`L56-57`).
2. **Unitary Seesaw Fubini Interchange and Central-Character Correction (`Development/AutomorphicArithmetic/ThetaCorrespondence/FockModels/RallisDM.lean:72-108`)**: Along the doubling inclusion $\iota_A : U(A) \times U(-A) \hookrightarrow U(A \oplus (-A))$, the Weil-representation splitting clause `ThetaClause` (`hid`, `L77-83`) yields

    $$
    \Theta_\omega(g_1, h; \Phi_1) \, \overline{\Theta_\omega(g_2, h; \Phi_2)} = \chi_B(\det g_2) \, \Theta_{\omega_d}\bigl(\iota_A(g_1, g_2), h; \delta(\Phi_1, \Phi_2)\bigr)
    $$

    Applying the seesaw Fubini theorem (`seesaw_fubini`, `L72-75`) to the rapidly decaying cusp forms $\overline{f_1}, \overline{f_2}$ against the moderately growing theta kernel on $[U(A)] \times [U(A)] \times [U(B)]$ interchanges the integration order and produces (`hval`, `L99-108`)

    $$
    \frac{1}{\mathrm{vol}([U(B)]_{m_H})} \bigl\langle \Theta_{\Phi_1}(f_1),\, \Theta_{\Phi_2}(f_2) \bigr\rangle_{L^2([U(B)])} = \iint_{[U(A)] \times [U(A)]} \overline{f_1(g_1)}\, f_2(g_2)\, \chi_B(\det g_2)\, \mathcal{M}_{\omega_d}\bigl(\delta(\Phi_1, \Phi_2)\bigr)\bigl(\iota_A(g_1, g_2)\bigr)\, dm(g_1)\, dm(g_2)
    $$

    where $\mathcal{M}_{\omega_d}$ denotes the mean theta integral `thetaMean` over $[U(B)]$. Finally, at `L52-55` and `L109-110`, substituting `SiegelWeilUnitaryConvergent` replaces $\mathcal{M}_{\omega_d}(\delta(\Phi_1, \Phi_2))$ by the degenerate Eisenstein value $E(\iota_A(g_1, g_2), s_0; \Phi_{\delta})$, and invoking the holomorphic evaluation theorem `zetaHolValueAt_of_eisValueAt` from the Piatetski-Shapiro-Rallis doubling zeta integral (`ResidueKilled.DM`) identifies the right-hand side with the doubling zeta special value `ZetaValueAt A χB⁻¹ m ... s₀` proportional to the near-central standard $L$-value (Rallis `1984`, Li `1992`, Gan-Qiu-Takeda `2014`, **Type II-A**).

Paired with this result, `Development/WeilBound/ThetaLifts/Reductions/FiniteClosure/TheoremKOfMod.lean:14-28` (`29` lines) combines the doubling boundary Eisenstein property `EisBL` (`Development/WeilBound/RepresentationTheoryGL/EisensteinSeries/SiegelEisensteinHalfPlane/SchwartzBruhatMajorants/SiegelMultOf.lean:101-114`), the standard Gaussian-section Siegel-Weil normalization `SiegelWeilStd` (`Development/WeilBound/CoreStatements/AutomorphicKernels/SiegelWeilFormula/SiegelWeilStandard/SiegelWeilStd.lean:8-9`), and ramified/unramified spherical Howe duality (`howeInert`, `ramifiedMultiplicityOne`) to deduce agreement of theta integrals between the indefinite and definite rows together with local factor matching `ThetaIntegralsAgree ∧ LocalMatching` (fed directly into `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/EveryCharacterOfLiteratureOfVWin.lean:565-566`).

---

### 4.3 Siegel Mass, Arithmetic Covolume Bound (`TopCovolSlim2Use`), Column-Conjugation Measure, and Mirabolic Specification Audit

The Chowla-Selberg and Siegel mass axis controlling lattice covolumes and height growth between definite unitary groups and indefinite Shimura varieties is implemented along two branches.
The Hermitian lattice genus mass formula itself is proved as `GenusMassAt D 2` for every `D : D7` in `Development/AbelianVarietyTheory/Proofs/GlobalInterpolation/GenusMassAtTwo.lean:7-8` and supplied downstream to `Development/AutomorphicArithmetic/CharacterBoxes/RiemannHypothesisOfEveryCharacter.lean:88`, while the Arakelov self-intersection volume bound for the Hodge bundle on toroidal compactifications is assembled in `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/HodgeBundleWeights/TopCovolSlim2Use.lean:16-22` and its refactored twin `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/TopCovolSlim2Use.lean:16-22`.

In the source text, `topCovolSlim2_use_alt_alt` takes `15` algebraic-geometric and arithmetic-intersection inputs (`ResolutionCharZero`, `PrincipalisationCharZero`, `PoincareLelongInv`, arithmetic Hilbert-Samuel `hsUse_outright`, Moriwaki bigness `moriwakiBig_outright`, Fargues exactness `FarguesExact`, Zarhin's trick `ZarhinStatement`, asymptotic Riemann-Roch `NefRR`, Siegel and fan toroidal compactifications `SiegelToroidalIntegral` and `ToroidalForFanKS`, semi-abelian Lie seminegativity `SemiAbelianLieSeminegative`, two-point separation `PointSeparationPair`, Arakelov degree `ArDegree`, the `28`-field Hodge bundle record `PublishedHodgeBundleTheorems`, and Grothendieck deformation `GrothendieckDeformation`) and routes them through the Fubini-Study Chow height formula (`fubiniStudy_chowHeight_formula`) and small-section injectivity (`small_sections_injective`) to produce the final covolume bound `CovolumeBoundOfX`.

Meanwhile, on the $\mathrm{GL}_k$ side, the source audit of the three foundational modules supporting Fourier-Whittaker expansions and spectral decomposition yields the following findings.

1. **`ColumnConjugationMeasure.lean` (`in_degree = 64`, `407` lines)**: `Development/WeilBound/CoreStatements/PublishedTheorems/JacquetShalikaRigidity/ColumnConjugationMeasure.lean:32-140` is the most cited hub across all of `Development.WeilBound.CoreStatements`.
Over a totally complex number field $E$, it defines the idelic determinant norm `Dt : GA E k → ℝ` on $\mathrm{GL}_k(\mathbb{A}_E)$ (`GA E k`) (`D0`, `L32-40`: `Dt = 1` on rational, unipotent, and compact integral elements, and $\exp(k[E:\mathbb{Q}]t)$ on central shifts), proves the conjugation Jacobian identity (`L46-48`) for column unipotent blocks `blkU x`,

    $$
    \int_{(\mathbb{A}_E)^{j}} F\bigl(g \cdot u_{\mathrm{col}}(x) \cdot g^{-1}\bigr)\, dx = \mathrm{Dt}(g)^{-1} \int_{(\mathbb{A}_E)^{j}} F\bigl(u_{\mathrm{col}}(x)\bigr)\, dx
    $$

    and establishes the $L^2$-Plancherel isometry identities (`U1`, `U2`, `L126-136`: $\langle f, \varphi \rangle_{\beta} = \langle \mathcal{W}_\psi f, \mathcal{W}_\psi \varphi \rangle_{\beta'}$) for the stagewise mirabolic Fourier-coefficient operator `colT ψ m f` in **Type I** generality.
2. **`CuspSp.lean` (`86` lines)**: `Development/WeilBound/CoreStatements/RegularisedThetaMirabolic/KFiniteCuspForms/CuspSp.lean:47-86` lifts every $K$-finite vector in a closed irreducible cuspidal $L^2$-subrepresentation $\mathcal{H} \subset L^2_{\mathrm{cusp}}([\mathrm{GL}_a])$ of $\mathrm{GL}_a(\mathbb{A}_E)$ to a smooth cusp-form representative in `Sm E a` (`exists_cusp_form_of_K_finite`, `L30-40`), constructs the algebraic irreducible cuspidal module `π : CuspSub E a`, and proves the three-part package `CuspidalSpectrumGL` (discrete decomposition, $K$-finite density, and cuspidal boundedness, `L85-86`, **Type I**).
3. **`Mirabolic.lean` (`366` lines) and the Forensic Identity of Finite-Field `CuspidalMirabolic`**: Over an arbitrary field $F$, `GroundTheory/HeightsAndTheta/Theta/FiniteGL/Mirabolic.lean:15-359` constructs the upper-triangular unipotent group $U_n(F)$ (`upperUnipotent`), the mirabolic subgroup $P_n(F)$ with bottom row $(0, \dots, 0, 1)$ (`mirabolic`, `L61-85`), the superdiagonal-sum nondegenerate character $\psi_0(\sum_{i} u_{i,i+1})$ (`genericChar`, `L103-150`), mirabolic compact induction `mirabolicInduced` (`L163-165`), cuspidality as vanishing of proper flag-radical invariants `IsCuspidal` (`L234-236`), and the unipotent-supported delta vector `mirabolicDelta` (`L323-359`).
Notably, opening the underlying definition (`Development/AbelianVarietyTheory/PublishedTheorems/PublishedFoundations/BlockTriangularOfSubOne.lean:215-226`) of `cuspidal_mirabolic_of_literature : CuspidalMirabolic` at `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/EveryCharacterOfLiteratureOfVWin.lean:343-344` reveals that the base field type is specified not as a nonarchimedean local field, but as **`[Field k] [Fintype k]` (a finite field $\mathbb{F}_q$)**:

    $$
    \mathrm{CuspidalMirabolic} \iff \forall \mathbb{F}_q,\; \forall n \in \mathbb{N},\quad \Bigl(\exists \rho \in \mathrm{Irr}_{\mathrm{cusp}}(\mathrm{GL}_{n+1}(\mathbb{F}_q))\Bigr) \;\land\; \Bigl(\forall \psi_0 \neq 1,\; \forall \rho \in \mathrm{Irr}_{\mathrm{cusp}}(\mathrm{GL}_{n+1}(\mathbb{F}_q)),\; \rho\rvert_{P_{n+1}(\mathbb{F}_q)} \simeq \mathrm{Ind}_{U_{n+1}(\mathbb{F}_q)}^{P_{n+1}(\mathbb{F}_q)} \psi_0\Bigr)
    $$

    Whereas the identifier alone might suggest the $p$-adic Bernstein-Zelevinsky (`1976`) Kirillov model, the actual code formalizes S. I. Gelfand's (`1970`) **irreducibility and uniqueness of the mirabolic restriction of cuspidal representations of finite general linear groups** (**Type I**, finite-field formulation), which combines with Moy-Prasad depth-`0` supercuspidal induction to supply unramified and depth-`0` Whittaker nonvanishing.

| Audited Specification Identifier | Source Location (Relative to `src/`) | Citations | Classical Reference | Equivalence Class and Audit Summary |
| :--- | :--- | ---: | :--- | :--- |
| `WeilRepresentationUnitaryPair` | `Development/AbelianVarietyTheory/PublishedTheorems/AutomorphicForms₂/WeilRepresentationUnitaryPair.lean:12-16` | `780` | Kudla (1994), HKS (1996) | **Type II-A**: Existence of the Weil representation over `D7` Hermitian pairs $(S,T)$ and half-integral Hecke characters $(\chi_S,\chi_T)$ |
| `WeilSiegelFormulaUnitary` | `Development/AbelianVarietyTheory/PublishedTheorems/TwistedTraceFormula/WeilSiegelFormulaUnitary.lean:56-70` | `14` | Weil (1965), Kudla-Rallis (1988) | **Type II-A**: Identity between the Siegel coset series and mean theta integral in the absolute-convergence range $r_B > 2r_A$ |
| `SiegelWeilUnitaryConvergent` | `Development/AbelianVarietyTheory/PublishedTheorems/SiegelWeil₂/SiegelWeilUnitaryConvergent.lean:18-33` | `35` | Kudla-Rallis (1994), Ichino (2001, 2004) | **Type II-A**: Agreement with the analytically continued Eisenstein value in the half-convergent range $r_A < r_B \le 2r_A$, $r_A + \mathrm{ind}_{\mathrm{Witt}}(B) < r_B$ |
| `RallisInnerProductConvergent` | `Development/AbelianVarietyTheory/PublishedTheorems/TwistedTraceFormula/LowerLiftsZeroOfWittIdxEqZero.lean:41-60` | `12` | Rallis (1984), Li (1992), GQT (2014) | **Type II-A**: Identity between the theta-lift Petersson inner product and doubling zeta special value under first-occurrence Witt-tower hypotheses |
| `ColumnConjugationMeasure` | `Development/WeilBound/CoreStatements/PublishedTheorems/JacquetShalikaRigidity/ColumnConjugationMeasure.lean:46-49` | `64` | Jacquet-Shalika (1981), Godement-Jacquet | **Type I**: Unipotent column-conjugation Jacobian $\mathrm{Dt}(g)^{-1}$ and Fourier-Whittaker isometry on $\mathrm{GL}_k(\mathbb{A}_E)$ |
| `CuspidalMirabolic` | `Development/AbelianVarietyTheory/PublishedTheorems/PublishedFoundations/BlockTriangularOfSubOne.lean:215-226` | `6` | S. I. Gelfand (1970), Green (1955) | **Type I (Finite Field)**: Existence of cuspidal representations of $\mathrm{GL}_{n+1}(\mathbb{F}_q)$ and mirabolic Kirillov induced isomorphism |

---

### 4.4 Doubling-Method Zeta Integrals (`DmOfHyp`), Unramified Spherical Euler Factors, and `max CF0 CF1` Grid Assembly Audit

The analytic engine driving both the Rallis inner product formula of Section 4.2 and the top-level assembler of Section 1.1 is meromorphic continuation and unramified spherical evaluation of the Piatetski-Shapiro-Rallis (`1987`) doubling-method zeta integral.

First, `ResidueKilled.DM` (the concrete definition of `DoublingMethodLocalZetaIntegrals`) in `Development/WeilBound/RepresentationTheoryGL/EisensteinResidues/AnisotropicGlobalForms/DmOfHyp.lean:13-35` asserts for a Hermitian space $V$ ($\mathrm{rk}(V) > 0$) and degenerate principal-series section $\varphi \in \mathrm{degPS}(V, a, \mu, s_1)$: (i) meromorphic continuation of the flattened Siegel Eisenstein series with finite pole order at every point $s_0$ (`EisContinues ∧ ∀ s₀, ∃ k, EisRegularAt ... k`), (ii) the unfolding basic identity (`BasicIdentity V μ m (flat V a φ s₁ s) f₁ f₂`, `L21`) for cusp forms $f_1, f_2 \in \mathcal{A}_0(U(V))$ on the right half-plane $\mathrm{Re}(s) > \frac{1}{2}\mathrm{rk}(V)$, and (iii) whole-plane meromorphic continuation of the doubling zeta integral itself (`ZetaContinues`, `L22`) (**Type II-A**).
In particular, `dm_of_two` (`L24-35`) deduces `DM` from `CuspRapidDecay` and `SiegelEisensteinContinuation` alone by interchanging integration and analytic continuation via cuspidal rapid decay (`zetaContinues_of_eisRegularAt`).

Second, the theorem evaluating the local zeta integral of `BasicIdentity` at each unramified finite place as the standard Euler $L$-factor is `unramifiedDoublingGL` in `Development/AbelianVarietyTheory/Proofs/DecoratedLatticeProofs/IsCommensuratedKO.lean:125-162`.
Over a nonarchimedean local field $k$ (with residue cardinality $q_k = \mathrm{resCard}(k) > 1$ and uniformizer $\varpi$), the proof uses commensurability (`isCommensurated_KO`) of the maximal compact subgroup $K_0 = \mathrm{GL}_n(\mathcal{O}_k)$ (`KO k (Fin n)`) and spherical series summation over the double-coset length function `cellLen` (`hasSum_sphericalFunction_doublingLength`, `L138-140`) to compute directly at **Type I** generality that, for $\mathrm{Re}(s)$ large enough so that $\lvert q_k^{-(n/2 + s)} \rvert < \delta$, the local integral of a spherical matrix coefficient $\omega(g)$ against the spherical doubling section $\Phi_s(\iota(g, 1))$ equals the local $L$-factor attached to the unramified Satake parameters $\alpha_1, \dots, \alpha_n \in \mathbb{C}^\times$:

$$
\int_{\mathrm{GL}_n(k)} \Phi_s\bigl(\iota(g, 1)\bigr)\, \omega(g)\, d\mu(g) = \prod_{i=1}^{n} \bigl(1 - \alpha_i^{-1} q_k^{-(s + 1/2)}\bigr)^{-1} \cdot \bigl(\text{normalization factor}^{-1}\bigr)
$$

(`prod_one_sub_eq_invNormFactor`, `L104-122`, `L150-161`).

Third, tracing how these theta, doubling, and Arakelov witnesses combine inside `nonempty_hyps_definite_side_of_closed_bound` at `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/SiegelEisensteinSecondTermHypotheses.lean:44-68` clarifies the global constant design of the archive.

1. At `L52-54`, `evaluation_grid_of_join` combines real Howe duality (`howeDualityReal`), unramified Howe separability (`howeUnram_holds`), convergent Siegel-Weil (`siegelWeilUnitaryConvergent`), and Siegel fundamental-domain theta convergence (`twisted_weil_representation_convergence`) to produce the theta-integral grid threshold constant `CF1`.
2. At `L55-56`, `rowFun_at_gridA_alt` combines covering-group discrete series (`discreteSeriesCover`), Harish-Chandra modules (`harishChandraModules`), cuspidal rapid decay (`cuspRapidDecay`), Casselman-Wallach (`casselmanWallach`), and ray class fields (`rayClassFieldSt`) to produce the archimedean functional-analytic threshold constant `CF0`.
3. At `L57-68`, taking the maximum $C_{\max} := \max(\mathrm{CF}_0, \mathrm{CF}_1)$ fixes the common evaluation grid `GridA (max CF0 CF1)`, and feeding it alongside the Arakelov covolume bound `hX : CovolumeBoundOfX` from Section 4.3 and `hL : RecTExists` from Section 3.2 into `linked_bundles_l3_of_open_alt` (`L65-67`) closes the definite-side nonemptiness hypothesis `Nonempty (HypsAlt S0.NL DefiniteSideCondition)` without nonconstructive choice.

---

## Chapter 5. Source Audit of Algebraic Geometry (GAGA, Hironaka, Demailly, Abelian Varieties), $p$-adic Hodge Theory, and Class Field Theory Specifications

### 5.1 Serre GAGA Section Bijectivity, Hironaka Principalization, and Demailly Log-Canonical $L^2$-Extension Audit

To convert analytic automorphic forms on toroidal compactifications of Shimura and unitary moduli varieties into algebraic line-bundle sections and evaluate their Arakelov heights, the archive internally proves three master theorems of complex and algebraic geometry: Serre's GAGA, Hironaka's resolution of singularities, and Ohsawa-Takegoshi / Demailly $L^2$-extension. Inspecting the source text brings out a sharp contrast in generality among the three specifications.

First, opening the most cited hub (`in_degree = 153`) of `Development.AutomorphicSpectrum.PublishedTheorems`, `Development/AutomorphicSpectrum/PublishedTheorems/Geometry₂/GagaSections.lean:10-18`, together with `Development/AbelianVarietyTheory/PublishedTheorems/Divisors₂/SerreHolomorphicSections.lean:15-20`, reveals the **degree-`0` global line-bundle section (`LB.Sec`) version** of Serre's (`1956`, *Géométrie algébrique et géométrie analytique*) theorem.

```lean
-- Development/AutomorphicSpectrum/PublishedTheorems/Geometry₂/GagaSections.lean:10-18
def GagaSections : Prop :=
  ∀ (X : Scheme.{0}) (s : X ⟶ Sp ℂ), IsProper s → Smooth s → ∀ (L : LB X), L.IsLB →
    ∀ h : L.ι → (Sp ℂ ⟶ X) → ℂ,
      (∀ (i : L.ι) (m : ℕ) (B : Set (Fin m → ℂ)) (y : (Fin m → ℂ) → (Sp ℂ ⟶ X)), IsOpen B → IsHolTo B y →
        (∀ b ∈ B, y b ≫ s = 𝟙 _ ∧ ⊤ ≤ y b ⁻¹ᵁ L.U i) → DifferentiableOn ℂ (fun b => h i (y b)) B) →
      (∀ (i j : L.ι) (x : Sp ℂ ⟶ X), x ≫ s = 𝟙 _ → ⊤ ≤ x ⁻¹ᵁ (L.U i ⊓ L.U j) →
        h i x = valAt' x (L.U i ⊓ L.U j) (L.g i j).val * h j x) →
      ∃ σ : L.Sec, ∀ (i : L.ι) (x : Sp ℂ ⟶ X), x ≫ s = 𝟙 _ → ⊤ ≤ x ⁻¹ᵁ L.U i → valAt' x (L.U i) (σ.f i) = h i x
```

Over a proper (`IsProper`, or projective `IsProjOver` in `SerreHolomorphicSections`) smooth scheme $X / \mathrm{Spec}\,\mathbb{C}$ equipped with a line bundle $L$ given by a Čech open cover $\{U_i\}_{i \in \iota}$ and transition functions $g_{ij} \in \mathcal{O}_X^\times(U_i \cap U_j)$, any family of analytic local sections $\{h_i\}$ whose pullbacks along holomorphic maps $y : B \subset \mathbb{C}^m \to X(\mathbb{C})$ are complex-differentiable (`DifferentiableOn ℂ`) and satisfy the cocycle law $h_i(x) = g_{ij}(x) h_j(x)$ arises from a unique algebraic regular section $\sigma \in H^0_{\mathrm{alg}}(X, L)$ (`L.Sec`).
Rather than demanding equivalence of abelian categories of coherent sheaves or higher cohomology isomorphisms $H^q(X^{\mathrm{an}}, \mathcal{F}^{\mathrm{an}}) \cong H^q(X, \mathcal{F})$ ($q \ge 1$), this **Type II-B specialization** extracts exclusively $H^0$ algebraization for line bundles, allowing a concise proof in `Development/AbelianVarietyTheory/Proofs/DivisorProofs/SerreHolomorphicSectionsHolds.lean:14-52` via affine boundary polynomial-growth estimates (`continuous_section_polynomial_growth`) and sheaf gluing.

Second, cited `937` times, Hironaka's principalization specification `Principalisation` in `Development/AbelianVarietyTheory/PublishedTheorems/Divisors₂/GeometricallyConnectedOfIsIsoRestrict.lean:118-126` states that for any smooth projective integral scheme $Y / \mathrm{Spec}\,k$ of dimension $d$ over a characteristic-`0` field $k$ and any nonzero ideal sheaf $I \neq \perp$, there exists a finite sequence of blowups $s : Y' \to Y$ (`IsSmoothBlowupSeq f I.support s`) along smooth closed centers contained in $\mathrm{Supp}(I)$ such that: (i) $s$ is an isomorphism outside $\mathrm{Supp}(I)$ (`IsIso (s ∣_ I.support.compl)`), (ii) the pullback ideal $s^{-1}I \cdot \mathcal{O}_{Y'}$ is an effective Cartier divisor (`EffCartier (I.comap s)`), and (iii) the vanishing ideal of its support has simple normal crossings (`FinalTheorems.Snc`).
This is a **Type I proposition** matching Hironaka (`1964`) and Theorem 3.26 of Kollár (`2007`, *Lectures on Resolution of Singularities*).

Third, `L2ExtensionLogCanonical` in `Development/AbelianVarietyTheory/PublishedTheorems/Divisors₂/L2ExtensionLogCanonical.lean:16-55` (`in_degree = 158`) exhibits one of the sharpest **Type II-B specializations** in the archive. Whereas the general Ohsawa-Takegoshi (`1987`) and Demailly (`2015`) log-canonical $L^2$-extension theorems extend holomorphic sections from arbitrary-dimensional log-canonical centers, lines `L40-55` restrict to a transverse-intersection configuration on a weighted complex-manifold atlas `A : WeightedAtlas n Y ι La` in which the common zero locus $Z(s) = \mathrm{A.zeroSet}(s)$ of $n$ sections $s_1, \dots, s_n \in H^0(Y, L)$ is a **finite set (`(A.zeroSet s).Finite`, a `0`-dimensional set of isolated points)** with nonvanishing Jacobian determinant $J_s(P) = \det(ds(P)) \neq 0$ (`jacAt A s P ≠ 0`) at every $P \in Z(s)$.
Under the logarithmic singularity weight $\psi(y) = n \log \|s(y)\|_L^2 \le 0$ and curvature positivity $\mathrm{Levi}(\varphi_E + \alpha \psi) \ge 0$ ($\alpha \in [1, 1+\delta]$), any prescribed values $f : Z(s) \to \mathbb{C}$ on this finite point set admit an interpolating global holomorphic section $F$ ($F(P) = f(P)$) of the adjoint bundle $K_Y + E$ satisfying the sharp $L^2$ estimate with explicit universal constant $34/\delta$:

$$
\int_Y \frac{2^n}{1 + \bigl(\delta \psi(y)\bigr)^2} \, \| F(y) \|_{K_Y + E}^2 \, e^{-\psi(y)} \, d\mu_A(y) \;\le\; \frac{34}{\delta} \cdot \frac{2^{n+1}\pi^n}{\Gamma(n)} \sum_{P \in Z(s)} \frac{\lvert f(P) \rvert^2}{\lvert J_s(P) \rvert^2} \, e^{-\varphi_E(P) + n \varphi_L(P)}
$$

This formalizes the point-residue $L^2$-interpolation case of Demailly (`2015`, *Extension of holomorphic functions defined on singular subvarieties with nontrivial multiplier ideal sheaves*), tailored to the exact `0`-dimensional point interpolation and explicit constant $34/\delta$ needed when separating small sections at finitely many CM and special points on Shimura varieties (`SmallSectionsInjective`).

---

### 5.2 Abelian Scheme Principal Polarization Unique Section, $[n]$-Torsion Cardinality, De Rham-Crystalline Deformation, and Semistable Reduction Audit

Source verification of the five core specification files forming the algebraic foundation of abelian varieties yields the following results.

1. **Dimension `1` of Principal-Polarization Theta Sections (`Development/AbelianVarietyTheory/PublishedTheorems/AbelianLaws/PrincipalPolarisationOneSection.lean:11-12`)**: For any principally polarized abelian variety `P : PolAV (Spec K)` over an algebraically closed field $K$, the space of global sections of the principal polarization bundle $P.L$ has dimension `1`:

    $$
    \dim_K H^0(P.A,\, P.L) = 1
    $$

    This is a **Type I proposition** matching Mumford (`1970`, *Abelian Varieties*, Section 16 Riemann-Roch and Pfaffian formula $\chi(L) = \sqrt{\deg \phi_L} = 1$), proved in `Development/AbelianVarietyTheory/Proofs/AbelianSchemeLawProofs/PrincipalPolarisationUniqueSection.lean:7-9`.
2. **$[n]$-Torsion Cardinality $n^{2g}$ (`Development/AbelianVarietyTheory/PublishedTheorems/Landherr₂/DimEqZero.lean:10-11`, `Development/AbelianVarietyTheory/Proofs/CoherentCohomologyProofs/AbelianVarietyTorsionCardEqPowProof.lean:18-21`)**: For an abelian scheme $B / \mathrm{Spec}\,k$ of relative dimension $g$ over an algebraically closed field $k$ and an integer $n$ invertible in $k$ ($(n : k) \neq 0$), the cardinality of the $n$-torsion point group is formalized as

    $$
    \# \bigl\{ x \in B(k) \;\big|\; x^n = 1 \bigr\} = n^{2g}
    $$

    (**Type I**, Mumford `1970`, Section 6). The proof derives from acyclicity of the Theorem-of-the-Cube total complex (`CubeTotalComplexAcyclicOfSlicesInductionOnCard`) and the rigidity lemma (`rigidity_holds`).
3. **Relative De Rham Cohomology and Grothendieck-Messing Deformation (`Development/AbelianVarietyTheory/PublishedTheorems/Divisors₂/CrysToDRBijective.lean:24-68`, `Development/AbelianVarietyTheory/PublishedTheorems/Divisors₂/ExistsCrystalPairing.lean:25-129`, `Development/AbelianVarietyTheory/PublishedTheorems/Divisors₂/GrothendieckDeformation.lean:12-16`)**: Cited `859` times, `CrysToDRBijective.lean` defines `AbelianDeRham` for an abelian scheme $A / \mathrm{Spec}\,R$ of relative dimension $g$ over an arbitrary commutative ring $R$ as the conjunction of five clauses: (i) `Free` ($H^1_{\mathrm{dR}}(A/R)$ is a finite projective $R$-module of stalk rank $2g$ at every prime with cup-product isomorphism $\bigwedge^2 H^1_{\mathrm{dR}} \xrightarrow{\sim} H^2_{\mathrm{dR}}$), (ii) `Hodge` (the invariant differential submodule $\omega_A \subset H^1_{\mathrm{dR}}$ is a rank-$g$ direct summand), (iii) `BaseChange` (compatibility with arbitrary ring maps $R \to R'$), (iv) `Rigid` (crystalline lift bijectivity `crysToDR_bijective` across nilpotent divided-power ideals $(I, \kappa)$), and (v) `Duality` (perfect alternating pairing `ψ` and isotropic Hodge filtration under principal polarization `KTriv`).
Built atop this package, `GrothendieckDeformation` (`in_degree = 288`) states in **Type I** generality the equivalence between deformations of abelian schemes and lifts of Hodge filtrations across arbitrary surjective nilpotent divided-power thickenings $(R \twoheadrightarrow R_0, I, \kappa)$ (`GrothendieckMessing.At κ π`, Grothendieck `1970`, Messing `1972`).
4. **$p$-adic Semistable Reduction (`Development/AbelianVarietyTheory/PublishedTheorems/SemistableReduction₂/SemistableReductionSt.lean:15-23`, `Development/AbelianVarietyTheory/Proofs/DegenerationProofs/SemistableReductionPpavPadicField.lean:19-22`)**: Rather than ranging over arbitrary Dedekind domains, the source signature takes **a principally polarized abelian variety `P : Out.PolAV (Sp K)` over a finite extension $K \subset \overline{\mathbb{Q}}_p$ of $\mathbb{Q}_p$** and asserts the existence of a finite extension $K'/K$ and a semi-abelian group scheme (`IsSemiAbelian G`) over $\mathcal{O}_{K'} = \mathrm{integralClosure}(\mathbb{Z}_p, K')$ whose generic fiber $G \times_{\mathcal{O}_{K'}} K' \cong P.A \times_K K'$ is group-scheme pullback isomorphic to $P.A$. This is the $p$-adic principally polarized subcase (**Type II-B**) of Grothendieck's SGA 7 I (`1972`) semistable reduction theorem, proved via Mumford-Raynaud $p$-adic uniformization (`UniformisationConclusion`).

---

### 5.3 Fontaine $B_{\mathrm{cris}}$, Bhatt-Scholze $A_{\inf}$ Lattices, Scholze-Weinstein Classification, and Prismatic Dieudonné Audit

The `4` integral and rational $p$-adic Hodge theory specifications connect directly to modern arithmetic geometry (`1994` to `2023`); source inspection confirms that `3` are full **Type I** theorems while `1` (`PrismaticDieudonneHodge`) is a calibrated **Type II-B** specialization.

1. **Fundamental Exact Sequences of Fontaine's Crystalline Period Ring (`Development/AbelianVarietyTheory/PublishedTheorems/GaloisCohomology₂/OneSubPhiOntoOfFilZero.lean:15-21`, `Development/AbelianVarietyTheory/Proofs/InertiaEigenvalues/FontaineBcrisBasicTheoremsProof.lean:15-23`)**: Over a period-ring core `C : Core l` at prime $\ell$, `FontaineBcris` is defined as the sevenfold conjunction `TensorInj ∧ PhiInj ∧ IotaInj ∧ Fund ∧ PhiSubOneOntoFilZero C ∧ FundOnto ∧ Regular`. Its central clauses `Fund` and `PhiSubOneOntoFilZero` formalize the fundamental exact sequences of Fontaine (`1994`) and Colmez-Fontaine (`2000`),

    $$
    0 \longrightarrow \mathbb{Q}_\ell \longrightarrow B_{\mathrm{cris}}^{\varphi = 1} \cap \mathrm{Fil}^0 B_{\mathrm{dR}} \longrightarrow 0, \qquad 0 \longrightarrow \mathbb{Q}_\ell \longrightarrow \mathrm{Fil}^0 B_{\mathrm{cris}} \xrightarrow{\;\varphi - 1\;} B_{\mathrm{cris}} \longrightarrow 0
    $$

    together with injectivity of $\overline{\mathbb{Q}}_\ell \otimes_{\mathbb{Q}_\ell} B_{\mathrm{cris}} \hookrightarrow B_{\mathrm{dR}}$ (`TensorInj`) and $G_K$-regularity (`Regular`), at full **Type I** generality.
2. **Bhatt-Morrow-Scholze Integral $A_{\inf}$ Lattices (`Development/AbelianVarietyTheory/PublishedTheorems/GaloisCohomology₂/BhattScholzeIntegral.lean:12-30`, `in_degree = 506`)**: For any $G_K$-stable $\mathbb{Z}_\ell$-lattice $L \subset V$ inside a crystalline Galois representation $\rho : G_K \to \mathrm{GL}(V)$ of a finite extension $K/\mathbb{Q}_\ell$, there exist a Breuil-Kisin-Fargues $F$-crystal `E : FCrys l (OL K)` over $\mathcal{O}_K$ and a semilinear comparison map $j : E(P_0) \to W(\mathbb{C}_\ell^\flat) \otimes_{\mathbb{Z}_\ell} L$ (`Realises`), and every $G_K$-equivariant lattice map $f : T \to T'$ lifts to a unique $F$-crystal morphism $u : E \to E'$ (Bhatt-Morrow-Scholze `2018`, Publ. Math. IHÉS 128, **Type I**).
3. **Scholze-Weinstein Linear-Algebraic Classification of $p$-Divisible Groups (`Development/AbelianVarietyTheory/PublishedTheorems/Divisors₂/ScholzeWeinsteinB.lean:13-24`, `in_degree = 454`)**: Over the $p$-adically complete ring of integers $\mathcal{O}_C$ of an algebraically closed complete nonarchimedean field $(C, v)$, the specification formalizes the equivalence of categories between `PDivGroup p O` and linear-algebraic pairs $(T, W)$ (where $T \cong \mathbb{Z}_p^h$ is the Tate module and $W = \ker(\alpha_{G,\mathrm{HT}}) \subset \mathcal{O}_C \otimes_{\mathbb{Z}_p} T$ is a saturated $\mathcal{O}_C$-submodule satisfying $c \cdot x \in W \implies x \in W$), including both full faithfulness via unique morphism lifting (`L17-19`) and essential surjectivity realizing every saturated submodule (`L20-23`) (Scholze-Weinstein `2013`, Ann. of Math. 178, Theorem B, **Type I**).
4. **Prismatic Dieudonné Hodge Exact Sequence and Fargues Exactness (`Development/AbelianVarietyTheory/PublishedTheorems/Divisors₂/InjectiveOfSmulMemRange.lean:23-67`, `Development/AutomorphicArithmetic/ThetaCorrespondence/PrismaticDieudonne/PrismaticDieudonneHodge.lean:19-29`)**: In the source text, `PrismaticDieudonneHodgeAt` packages an additive contravariant functor $M : \mathrm{PDivGroup}(p, \mathcal{O}_C)^{\mathrm{op}} \to \mathrm{Mod}_{A_{\inf}}$ (free of rank $\mathrm{ht}(G)$), Frobenius $\varphi_G$ ($\varphi(\xi) M(G) \subset \mathrm{im}(\varphi_G)$), reduction $r_G : M(G) \twoheadrightarrow D(G)$ modulo the kernel generator $\xi$ of Fontaine's $\theta : A_{\inf} \twoheadrightarrow \mathcal{O}_C$, the Hodge-de Rham exact sequence

    $$
    0 \longrightarrow \omega_G \xrightarrow{\;\iota_G\;} D(G) \xrightarrow{\;\pi_G\;} \mathrm{Lie}(G^\vee) \longrightarrow 0
    $$

    and explicit evaluations on the étale constant group $\underline{\mathbb{Q}_p/\mathbb{Z}_p}$ (`const p O`, $\varphi = \sigma$) and multiplicative group $\mu_{p^\infty}$ (`PDivGroup.mu p O`, $\varphi = \varphi(\xi)\sigma$). At `L56-58`, however, full faithfulness of $M$ is demanded not on arbitrary pairs $(G, H)$ of $p$-divisible groups, but **specifically as bijectivity on $\mathrm{Hom}(\underline{\mathbb{Q}_p/\mathbb{Z}_p}, \mu_{p^\infty})$**.
This **Type II-B specialization** of Anschütz-Le Bras (`2023`, *Prismatic Dieudonné theory*) forms the exact cut needed to classify connected-étale extensions and deduce Laurent Fargues's (`2010`) Harder-Narasimhan filtration exactness for finite flat group schemes, `FarguesExact` (`Development/AutomorphicArithmetic/ThetaCorrespondence/PrismaticDieudonne/PrismaticDieudonneHodge.lean:27-29`).

---

### 5.4 Quadratic Extension Hasse Norm Theorem, Landherr Hermitian Classification, Class Field Theory, and Local Cohomology Audit

Across the number-theoretic and Galois-cohomological pillars as well, direct source comparison uncovers decisive structural facts.

```lean
-- Development/AbelianVarietyTheory/PublishedTheorems/Landherr₂/ExistsNormTensor.lean:12
def HasseNormSt : Prop :=
  (∀ (F : Type) [Field F] [NumberField F] (δ x : F), δ ≠ 0 → x ≠ 0 →
    (∀ σ : F →+* ℝ, ∃ a b : ℝ, σ x = a ^ 2 - σ δ * b ^ 2) →
    (∀ v : IsDedekindDomain.HeightOneSpectrum (𝓞 F), ∃ a b : v.adicCompletion F,
      algebraMap F (v.adicCompletion F) x = a ^ 2 - algebraMap F (v.adicCompletion F) δ * b ^ 2) →
    ∃ a b : F, x = a ^ 2 - δ * b ^ 2)
```

As verified by `Development/AbelianVarietyTheory/PublishedTheorems/Landherr₂/ExistsNormTensor.lean:12`, the specification `HasseNormSt` underlying `hasse_norm_st_of_literature` is not the Hasse norm theorem for cyclic Galois extensions $L/F$ of arbitrary degree, but a **Type II-B proposition** specialized to the **local-global norm principle for quadratic extensions $F(\sqrt{\delta})/F$ of number fields** (if $x = a_v^2 - \delta b_v^2$ holds at every real embedding $\sigma$ and every finite completion $F_v$, then $x = a^2 - \delta b^2$ for global $a, b \in F$, equivalent to the ternary quadratic Hasse-Minkowski theorem for $a^2 - \delta b^2 - x c^2$). The reason is immediate: in the next step, Landherr's (`1936`) theorem `LandherrSt` in `Development/AbelianVarietyTheory/PublishedTheorems/Landherr₂/LandherrStIffLandherr.lean:12` characterizes isometric equivalence ($\gamma^T G \overline{\gamma} = G'$) of nondegenerate Hermitian matrices $G, G' \in M_r(E)$ over a CM field $E$ exclusively by (i) matching signatures at all complex embeddings $\tau$ and (ii) the determinant ratio $\det(G')/\det(G) = z \overline{z}$ being a quadratic norm for $E / E^+$ (deduced directly from `HasseNormSt` in `Development/AbelianVarietyTheory/Proofs/AdelicLatticeProofs/LandherrAndLandherrSt.lean:19-23`, while `LandherrSt` itself is **Type I** as the full classification of CM Hermitian forms).

Finally, cited `740` times, `Development/AbelianVarietyTheory/PublishedTheorems/AutomorphicForms₂/ExistsUniqueHcharOfFiniteOrder.lean:25-79` formalizes `GlobalArtinReciprocity` without restriction as an open quotient homomorphism $\mathrm{art} : \mathbb{A}_E^\times \twoheadrightarrow \mathrm{Gal}(\overline{E}/E)^{\mathrm{ab}}$ with kernel $\ker(\mathrm{art}) = \overline{E^\times \cdot (E_\infty^\times)^\circ}$, inertia image $\mathrm{art}(\mathcal{O}_v^\times) = \mathrm{im}(I_v)$, and uniformizer image equal to geometric Frobenius $\sigma_v^{-1}$ (**Type I**), and defines the Weil-Serre $\ell$-adic Galois character `HeckeLAdicCharacter` attached to an algebraic Hecke character (`IsAlgPos χ n`).
Likewise, `Formalism/GaloisCohomology/LocalTateDualityK.lean:41-62` together with the direct imports `CompanionTheory/AutomorphicTheory/PadicCyclotomicFields/GcohTop.lean:11-14` and `CompanionTheory/AutomorphicTheory/PadicCyclotomicFields/GcohTopEuler.lean:6-7` establish for finite discrete $\mathbb{Z}/\ell^r\mathbb{Z}[G_K]$-modules $M$ over finite extensions $K/\mathbb{Q}_\ell$ cohomology finiteness including vanishing in degrees $n \ge 3$ (`LocalFinitenessK`), cup-product bijectivity against the cyclotomic twist $\mathbb{Z}/\ell^r\mathbb{Z}(1)$ (`cycK`, `LocalTateDualityK`), and Tate's (`1957`) local Euler-Poincaré characteristic formula

$$
\# H^1(G_K, M) = \# H^0(G_K, M) \cdot \# H^2(G_K, M) \cdot (\# M)^{[K : \mathbb{Q}_\ell]}
$$

(`LocalEulerCharK`, `L57-61`) as **pure Type I** theorems without any weakening. Meanwhile, `PoitouTateNormalised` in `Development/AbelianVarietyTheory/PublishedTheorems/GaloisCohomology₂/PoitouTateNormalised.lean:12-29`, governing global cohomology duality for finite discrete $\mathbb{Z}/\ell^r\mathbb{Z}[G_{F,S}]$-modules $M$ over a number field $F$, declares normalized local invariant maps `inv`, the Poitou-Tate 9-term exact sequence (`NineTermExact`), Tate-Shafarevich duality (`ShaDual`), and vanishing in degrees $n \ge 3$, while explicitly inserting **`(l ≠ 2 ∨ IsTotallyComplex F)`** at `L14`. This **Type II-B locus specialization** rules out 2-torsion Galois cohomology error terms at real infinite places, allowing global Euler characteristics and the Greenberg-Wiles Selmer ratio formula (`Development/AutomorphicArithmetic/ThetaCorrespondence/GaloisRepresentations/GreenbergWiles.lean:3-6`) to operate cleanly over odd primes $\ell \ge 3$ or CM number fields.

| Audited Specification Identifier | Source Location (Relative to `src/`) | Citations | Classical Reference | Equivalence Class and Audit Summary |
| :--- | :--- | ---: | :--- | :--- |
| `GagaSections` / `SerreHolomorphicSections` | `Development/AutomorphicSpectrum/PublishedTheorems/Geometry₂/GagaSections.lean:10-18` | `153` | Serre (GAGA, 1956) | **Type II-B**: Specialized to $H^0$ section algebraization bijectivity for line bundles `LB` over smooth proper/projective complex schemes |
| `Principalisation` | `Development/AbelianVarietyTheory/PublishedTheorems/Divisors₂/GeometricallyConnectedOfIsIsoRestrict.lean:118-126` | `937` | Hironaka (1964), Kollár (2007) | **Type I**: Smooth-blowup SNC principalization of ideal sheaves on smooth projective schemes in characteristic `0` |
| `L2ExtensionLogCanonical` | `Development/AbelianVarietyTheory/PublishedTheorems/Divisors₂/L2ExtensionLogCanonical.lean:32-55` | `158` | Ohsawa-Takegoshi (1987), Demailly (2015) | **Type II-B**: Specialized to finitely many isolated point centers `(A.zeroSet s).Finite`, nonvanishing Jacobian, and explicit constant $34/\delta$ |
| `principalPolarisationOneSection` / `AbMulNSt` | `Development/AbelianVarietyTheory/PublishedTheorems/AbelianLaws/PrincipalPolarisationOneSection.lean:11-12` | `3` / `40` | Mumford (1970) | **Type I**: Principal-polarization section dimension `1` and $n$-torsion cardinality $n^{2g}$ for invertible $n$. Textbook theorems verbatim |
| `SemistableReductionSt` | `Development/AbelianVarietyTheory/PublishedTheorems/SemistableReduction₂/SemistableReductionSt.lean:15-23` | `10` | Grothendieck (SGA 7 I, 1972) | **Type II-B**: Existence of semi-abelian integral models for principally polarized abelian varieties over finite $p$-adic extensions $K/\mathbb{Q}_p$ |
| `FontaineBcris` / `BhattScholzeIntegral` | `Development/AbelianVarietyTheory/PublishedTheorems/GaloisCohomology₂/BhattScholzeIntegral.lean:12-30` | `5` / `506` | Fontaine (1994), BMS (2018) | **Type I**: Fundamental exact sequences of $B_{\mathrm{cris}}$ and $A_{\inf}$ Breuil-Kisin-Fargues realizations of crystalline Galois lattices |
| `ScholzeWeinsteinB` / `PrismaticDieudonneHodge` | `Development/AbelianVarietyTheory/PublishedTheorems/Divisors₂/ScholzeWeinsteinB.lean:13-24` | `454` / `3` | Scholze-Weinstein (2013), Anschütz-Le Bras (2023) | `ScholzeWeinsteinB` is **Type I**; prismatic Dieudonné is **Type II-B** requiring full faithfulness on $\mathrm{Hom}(\underline{\mathbb{Q}_p/\mathbb{Z}_p}, \mu_{p^\infty})$ |
| `HasseNormSt` / `LandherrSt` | `Development/AbelianVarietyTheory/PublishedTheorems/Landherr₂/ExistsNormTensor.lean:12` | `33` / `10` | Hasse (1931), Landherr (1936) | `HasseNormSt` is **Type II-B** for quadratic norms $a^2 - \delta b^2$; `LandherrSt` is **Type I** for CM Hermitian form classification |
| `LocalTateDualityK` / `LocalEulerCharK` | `Formalism/GaloisCohomology/LocalTateDualityK.lean:47-62` | `5` / `6` | Tate (1957, 1958), Serre (1964) | **Type I**: Tate cup-product duality and local Euler characteristic formula for $\mathbb{Z}/\ell^r\mathbb{Z}$-modules over finite extensions $K/\mathbb{Q}_\ell$ |

---

### 5.5 Toroidal Compactification (`ToroidalForFanKS`) and Arithmetic Hilbert-Samuel / Arakelov Volume Audit

The concluding pillar of Chapter 5 comprises **toroidal compactification of unitary moduli varieties** and **asymptotic arithmetic Hilbert-Samuel volume theory**, both fed directly into the Arakelov covolume bound (`TopCovolSlim2Use`).

First, cited `528` times, `ToroidalForFanKS` in `Development/AbelianVarietyTheory/PublishedTheorems/Divisors₂/ToroidalCompactificationBis.lean:45-55` formalizes integral toroidal compactifications after Faltings-Chai (`1990`, *Degeneration of Abelian Varieties*) and Kai-Wen Lan (`2013`, *Arithmetic Compactifications of PEL-Type Shimura Varieties*) over a host datum `H : Host E` and signature-$(p,q)$ ($p + q \ge 1$) moduli datum `Dw : Datum H` over a CM field $E$.

```lean
-- Development/AbelianVarietyTheory/PublishedTheorems/Divisors₂/ToroidalCompactificationBis.lean:45-55
def ToroidalForFanKS : Prop :=
  ∀ (E : Type) [Field E] [NumberField E] [IsCMField E] (H : Host E) (Dw : Datum H), 1 ≤ Dw.p + Dw.q →
    ∀ φ : InvFun (𝓞 E), IsPolFan H.bar (min Dw.p Dw.q) φ → NoSelfInt H.bar (min Dw.p Dw.q) φ →
      ∀ (l : Geo.Tor.Level H) (Xo : Moduli Dw l) (c : Coeff l),
        ∃ (Y : Model Xo c (RingHom.id c.F)) (BD : EffCartierData Y.X) (d k : ℕ), 1 ≤ d ∧ 1 ≤ k ∧
          SmoothOfRelativeDimension Dw.dim (genStr Y) ∧ FinalTheorems.Snc (genBdIdeal Y) ∧
          (∀ x ∈ BD.idealSheaf.support, x ∉ abLocus Y.t.G) ∧
          (∀ x ∈ genBd Y, GlobalTheory.MumfordChart.HasChartOf φ Y BD d x) ∧
          ((GlobalTheory.FlagMod.detOm Y).IsLB → GlobalTheory.IsAmpleLB (GlobalTheory.TorRef.polOf Y k BD)) ∧
          GlobalTheory.LogKS.HasLogKS Y.t Y.s (GlobalTheory.LogKS.interior Y)
```

Given a projective invariant polyhedral cone decomposition `φ : InvFun (𝓞 E)` without self-intersection (`NoSelfInt`, with existence supplied by `SiegelToroidalIntegral.exists_fan` at `L56-61`), the signature requires for every level `l` and moduli space `Xo : Moduli Dw l` a compactified model `Y` and effective Cartier boundary divisor `BD` satisfying five geometric properties (**Type II-A**): (i) the generic-fiber structure morphism `genStr Y` is smooth of relative dimension $p q$ (`Dw.dim`), (ii) the boundary ideal `genBdIdeal Y` forms a simple-normal-crossings (`Snc`) divisor, (iii) the boundary support is disjoint from the interior abelian locus `abLocus` and admits Mumford semi-abelian degenerating complete local charts (`HasChartOf φ Y BD d x`) near every boundary point $x \in \mathrm{genBd}(Y)$, (iv) twisting a high tensor power of the Hodge determinant bundle $\omega_Y = \det \Omega^1_{G/Y}$ (`detOm Y`) down by a positive multiple $k \cdot \mathrm{BD}$ of the boundary (`polOf Y k BD`, a perturbed pullback of the minimal Baily-Borel bundle) yields an ample line bundle (`IsAmpleLB`), and (v) the algebraic logarithmic Kodaira-Spencer map is an isomorphism on the interior locus (`HasLogKS`).

Second, governing Arakelov heights and small-section counts on this toroidal model, `Development/AbelianVarietyTheory/PublishedTheorems/Divisors₂/SmallSecTensTriv.lean:65-97` (`in_degree = 257`) formalizes for an arithmetically nef (`L.IsNef D`) Hermitian line bundle $\overline{L} = (L, \|\cdot\|)$ on an integral arithmetic variety $p : X \to \mathrm{Spec}\,\mathcal{O}_k$ of relative dimension $D$ (`IsArithVar p D`) both finiteness of the set of integral small sections $\widehat{H}^0_{\mathrm{small}}(X, \overline{L}^{\otimes m}) := (\mathrm{L.pow}\;m).\mathrm{smallSec}$ (pointwise norm squared at most `1` at all infinite places) and the asymptotic arithmetic Hilbert-Samuel formula (`of_triv`, `L65-69`):

$$
\log \# \widehat{H}^0_{\mathrm{small}}\bigl(X, \overline{L}^{\otimes m}\bigr) = \frac{a}{\Gamma(D + 2)}\, m^{D + 1} + o\bigl(m^{D + 1}\bigr) \qquad (m \to \infty)
$$

where $a \in \mathbb{R}$ is the $(D+1)$-fold Arakelov self-intersection number (`L.IsSelfInter a`) of $\overline{L}$. At `L89-97`, theorem `volNef` divides this asymptotic expansion by $m^{D+1} / \Gamma(D+2)$ and takes `limsup` to deduce that Moriwaki's arithmetic volume $\widehat{\mathrm{vol}}(\overline{L})$ of an arithmetically nef line bundle equals its self-intersection number $a$ (Gillet-Soulé `1992`, Zhang `1995`, Moriwaki `2000`, Yuan `2008`).
Combined with the Poincaré-Lelong current-based intersection calculus (`arCalc_direct`, `cycleHeights_direct`) in `Development/WeilBound/CoreStatements/TemperedRepresentationTheory/ArakelovCycleHeights/CycleHeightFormulas/CycleHeightsDirect.lean:138-147` and Yuan's (`2008`) arithmetic Siu-type volume inequality $\widehat{\mathrm{vol}}(\overline{L} - \overline{M}) \ge (\overline{L}^{D+1}) - (D+1)(\overline{L}^D \cdot \overline{M})$ (`VolGe`) in `Development/AbelianVarietyTheory/Proofs/DivisorProofs/VolGeOfHilbertSamuel.lean:26-86`, this completes the arithmetic-geometric engine producing nonvanishing algebraic automorphic sections on Shimura varieties.

---

## Chapter 6. Complete Classification Ledger of All `201` Direct Imports of `EveryCharacterOfLiteratureOfVWin`

This chapter presents an unabridged, one-to-one classification ledger of **all `201 / 201` archive-internal direct local imports (`100.00%`, `12,171` lines, `690` theorems, `103` definitions and structures)** among the `208` `import` lines of `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/EveryCharacterOfLiteratureOfVWin.lean:1-208`, excluding only the `7` pure `Mathlib` imports (`Mathlib` at `L62` and `6` complex-analysis and special-function modules at `L138-143`).

For every entry, the ledger records the sequential local-import index (`001` through `201`) and exact line number (`L1` through `L208`) inside `EveryCharacterOfLiteratureOfVWin.lean`, the exact file and line-range pin relative to `src/` (pointing to the representative top-level declaration), the file's total line count and archive-wide citation count (`in_degree`), the representative declaration identifier, the corresponding classical reference, and the semantic equivalence class assigned under the criteria of Section 1.3.

| Equivalence Classification Category | Direct Import Modules (out of `201`) | Share | Epistemological Status and Handling Rule in a Condensed Human Paper |
| :--- | ---: | ---: | :--- |
| **Type I** (Paper- and textbook-equivalent general propositions) | `127` | `63.18%` | Formulates the general theorem directly over standard `Mathlib` categories (fields, schemes, representations, cohomology). Direct black-box citation of the original paper applies |
| **Type II-A** (Propositions projected onto archive-specific structures) | `44` | `21.89%` | Stated exclusively over custom unitary and Arakelov structures (`D7`, `HSp D`, `GA D V`, `GrpData p q`). Human citation requires verifying a structure translation adapter lemma |
| **Type II-B** (Sub-locus and weakened-condition propositions) | `11` | `5.47%` | Restricted to the exact sub-locus required along the proof path (quadratic norms, unramified CM `DefiniteN`, depth-`0` `GoodCusp`, `0`-dimensional log-canonical centers, section-level GAGA). Implied by the classical theorem |
| **Assembly / Adapter** (Hypothesis bundles, signature bridges, stubs) | `19` | `9.45%` | Internal wiring modules, refactoring signature adapters, and foundational matrix/topological lemmas packaging classical witnesses into higher hypothesis records |
| **Total** | **`201`** | **`100.00%`** | **Zero omissions and zero duplicates (`001` through `201` exhaustively verified)** |

### 6.1 Group 1: External Foundational Modules in `CompanionTheory`, `GroundTheory`, and `DiscreteGroups` (`8` Modules)

Foundational modules outside the three main `Development` subtrees (together with `DiscreteGroups`) supplying real Lie group discrete series classification and exhaustion, adelic restricted tensor-product admissibility, mirabolic Kirillov models, the local converse theorem, and $p$-adic cyclotomic local Galois cohomology.

| Index (`Import Line`) | Module Path Relative to `src/` and Representative Pin (`Lines` · `Citations`) | Representative Declaration (`Kind`) | Classical Reference and Role | Equivalence Verdict and Source Forensic Summary |
| :--- | :--- | :--- | :--- | :--- |
| `001` (`L1`) | `CompanionTheory/SpectralGeometry/LocalGlobalProofs/AdelicAnalysis/Imports.lean:10-13` (`14` lines · citations `2`) | `siegelWeilUnitaryConvergent` (`theorem`) | Ichino (2004), GQT (2014) | **Type II-A**: Witness for the Hecke-character-twisted unitary convergent Siegel-Weil identity |
| `002` (`L2`) | `CompanionTheory/AutomorphicTheory/PadicCyclotomicFields/GcohTop.lean:13-14` (`15` lines · citations `5`) | `top_locfin` (`theorem`) | Tate (1958), Serre (1964) | **Type I**: Local-field finite torsion module Tate duality and cohomology finiteness witness |
| `003` (`L3`) | `CompanionTheory/AutomorphicTheory/PadicCyclotomicFields/GcohTopEuler.lean:6-7` (`8` lines · citations `6`) | `top_euler` (`theorem`) | Tate (1957), Milne (1986) | **Type I**: Local-field Galois cohomology Euler-Poincaré characteristic formula |
| `004` (`L4`) | `CompanionTheory/RealGroups/DiscreteSeries/DiscreteSeriesClassification/KTypesAbove.lean:21-22` (`23` lines · citations `5`) | `classUsed` (`theorem`) | Harish-Chandra (1966), Knapp (1986) | **Type II-A**: Existence and upper $K$-type cone for discrete series of real $U(p,q)$ and its double cover |
| `005` (`L5`) | `CompanionTheory/RealGroups/DiscreteSeries/DiscreteSeriesClassification/DiscreteSeriesExhaustion/DsExhaust.lean:20-21` (`22` lines · citations `2`) | `discreteSeriesCover` (`theorem`) | Harish-Chandra (1966), Herb (1979) | **Type II-A**: Bijective classification of covering-group discrete series via finite-length exhaustion |
| `006` (`L6`) | `CompanionTheory/RealGroups/UnitaryAdmissibility/ArchimedeanUnitaryDual/FinalB.lean:55-57` (`58` lines · citations `2`) | `flathTensorProduct` (`theorem`) | Harish-Chandra (1953), Flath (1979) | **Type I**: Irreducible unitary admissibility and adelic restricted tensor-product factorization |
| `081` (`L82`) | `Development/DiscreteGroups/GlobalIrreducibility/LConvFinal.lean:22-23` (`24` lines · citations `3`) | `unitAdmGL` (`theorem`) | Henniart (1993), JPSS (1983) | **Type I**: $\mathrm{GL}_n$ local converse theorem via twisted gamma/epsilon factors and unitary admissibility |
| `085` (`L86`) | `GroundTheory/HeightsAndTheta/Theta/FiniteGL/Mirabolic.lean:351-359` (`366` lines · citations `2`) | `mirabolicDelta_ne_zero` (`theorem`) | Gelfand-Kazhdan (1975), BZ (1976) | **Type I**: Mirabolic subgroup induced space, nondegenerate generic character, and flag cuspidality over fields |

### 6.2 Group 2: Direct Specification Modules in `Development.AbelianVarietyTheory.PublishedTheorems` (`6` Modules)

Six specification modules inside `AbelianVarietyTheory.PublishedTheorems` invoked directly by `EveryCharacterOfLiteratureOfVWin.lean` without intermediate witness wrappers, covering Arakelov pullbacks, arithmetic volume, Grothendieck deformation, Caraiani local-global compatibility, Artin ray class characters, and supercuspidal Langlands correspondence.

| Index (`Import Line`) | Module Path Relative to `src/` and Representative Pin (`Lines` · `Citations`) | Representative Declaration (`Kind`) | Classical Reference and Role | Equivalence Verdict and Source Forensic Summary |
| :--- | :--- | :--- | :--- | :--- |
| `007` (`L7`) | `Development/AbelianVarietyTheory/PublishedTheorems/Divisors₂/ResidueDegreeOfIsClosedImmersion.lean:191-195` (`209` lines · citations `80`) | `isSelfInter_shift` (`theorem`) | Bost-Gillet-Soulé (1994), Zhang (1995) | **Type II-A**: Closed-immersion residue degree and Arakelov cycle-height pullback shift formula |
| `008` (`L8`) | `Development/AbelianVarietyTheory/PublishedTheorems/Divisors₂/SmallSecTensTriv.lean:89-97` (`100` lines · citations `257`) | `volNef` (`theorem`) | Moriwaki (2000-2009), Chen (2010) | **Type II-A**: Asymptotic small-section limit and volume continuity for arithmetically nef line bundles |
| `009` (`L9`) | `Development/AbelianVarietyTheory/PublishedTheorems/Divisors₂/GrothendieckDeformation.lean:31-39` (`42` lines · citations `288`) | `_root_.GlobalTheory.Published.GrothendieckDeformation.at_dualNumber` (`theorem`) | Grothendieck (1970), Messing (1972) | **Type I**: Infinitesimal deformation specification for abelian schemes and dual-number crystalline Dieudonné corollary |
| `010` (`L10`) | `Development/AbelianVarietyTheory/PublishedTheorems/GaloisGeometry₂/CaraianiLocalGlobalDual.lean:16-29` (`32` lines · citations `16`) | `CaraianiLocalGlobalDual` (`def`) | Caraiani (2012, 2014) | **Type I**: All-place local-global compatibility specification for conjugate self-dual cohomological cusp forms |
| `011` (`L11`) | `Development/AbelianVarietyTheory/PublishedTheorems/GaloisCohomology₂/ExistsIdealsPrimeToEqSpan.lean:463-481` (`484` lines · citations `13`) | `kills_of_rayPrincipal` (`theorem`) | Artin (1927), Takagi (1920) | **Type I**: Coprime ideal representative selection and Artin character descent to ray class groups |
| `184` (`L191`) | `Development/AbelianVarietyTheory/PublishedTheorems/GaloisCohomology₂/SupercuspidalLanglands.lean:16-21` (`24` lines · citations `4`) | `SupercuspidalLanglands` (`def`) | Harris-Taylor (2001), Henniart (2000) | **Type I**: Bijective local Langlands specification for supercuspidal representations over nonarchimedean local fields |

### 6.3 Group 3: Classical Witness Modules in `Development.AbelianVarietyTheory.Proofs` Across Algebraic Geometry, Representation Theory, and Number Theory (`79` Modules)

The largest single group among the `201` direct imports (`39.30%`, `79` files, `5,516` lines). It encompasses witnesses for abelian schemes, GAGA, toroidal compactification, and Demailly $L^2$-extension (`39` files across `DivisorProofs` and related folders), Hermitian lattices and cuspidal rapid decay (`6` files), Satake parameters and purity (`10` files), Fontaine $B_{\mathrm{cris}}$, Bhatt-Scholze lattices, and depth-`0` local Langlands (`21` files), and Weyl alcoves, global Artin reciprocity, and the geometric lemma (`3` files).

| Index (`Import Line`) | Module Path Relative to `src/` and Representative Pin (`Lines` · `Citations`) | Representative Declaration (`Kind`) | Classical Reference and Role | Equivalence Verdict and Source Forensic Summary |
| :--- | :--- | :--- | :--- | :--- |
| `012` (`L12`) | `Development/AbelianVarietyTheory/Proofs/AbelianSchemeLawProofs/PrincipalPolarisationUniqueSection.lean:7-9` (`10` lines · citations `3`) | `principalPolarisation_unique_section` (`theorem`) | Mumford (1970) | **Type I**: Witness for global-section dimension `1` of principally polarized abelian varieties over algebraically closed fields |
| `013` (`L13`) | `Development/AbelianVarietyTheory/Proofs/AdelicLatticeProofs/HasseNormTheoremQuadraticExtension.lean:13-33` (`34` lines · citations `33`) | `hasseNormSt` (`theorem`) | Hasse (1931) | **Type II-B**: Witness for the local-global norm principle specialized to quadratic extensions of number fields |
| `014` (`L14`) | `Development/AbelianVarietyTheory/Proofs/AdelicLatticeProofs/LandherrAndLandherrSt.lean:19-23` (`24` lines · citations `10`) | `_root_.GlobalTheory.QNorm.landherr_and_landherrSt` (`theorem`) | Landherr (1936), Scharlau (1985) | **Type I**: Deduces classification of CM Hermitian forms from the quadratic Hasse norm theorem |
| `015` (`L15`) | `Development/AbelianVarietyTheory/Proofs/CoherentCohomologyProofs/AbelianVarietyTorsionCardEqPowProof.lean:18-21` (`22` lines · citations `40`) | `_root_.GlobalTheory.abMulN_holds` (`theorem`) | Mumford (1970) | **Type I**: Proves cardinality $n^{2g}$ of the $[n]$-torsion subgroup of an abelian scheme |
| `016` (`L16`) | `Development/AbelianVarietyTheory/Proofs/DecoratedLatticeProofs/ImportsBis.lean:8-12` (`13` lines · citations `182`) | `weilRepresentationUnitaryPair` (`theorem`) | Kudla (1994), HKS (1996) | **Type II-A**: Witness constructing the Weil representation pullback on unitary seesaw dual pairs |
| `017` (`L17`) | `Development/AbelianVarietyTheory/Proofs/DecoratedLatticeProofs/IsCommensuratedKO.lean:125-162` (`163` lines · citations `4`) | `unramifiedDoublingGL` (`theorem`) | Piatetski-Shapiro-Rallis (1987) | **Type II-A**: Evaluates doubling-method local zeta integrals on unramified spherical vectors |
| `018` (`L18`) | `Development/AbelianVarietyTheory/Proofs/DecoratedLatticeProofs/CuspidalModerateGrowthRapidDecay.lean:20-106` (`107` lines · citations `5`) | `cuspDecayBound` (`theorem`) | Harish-Chandra (1968), Borel (1974) | **Type II-A**: Differential-norm rapid-decay bound for `D7` adelic unitary cusp forms |
| `019` (`L19`) | `Development/AbelianVarietyTheory/Proofs/DecoratedLatticeProofs/CuspFormsRapidDecay.lean:10-11` (`11` lines · citations `4`) | `GlobalTheory.RapidDecay.cuspRapidDecay` (`theorem`) | Godement, Harish-Chandra (1968) | **Type II-A**: Quotient-height polynomial rapid-decay witness for `D7` adelic unitary cusp forms |
| `020` (`L20`) | `Development/AbelianVarietyTheory/Proofs/DegenerationProofs/SemistableReductionPpavPadicField.lean:19-22` (`23` lines · citations `10`) | `_root_.GlobalTheory.SS.semistableReductionSt` (`theorem`) | Grothendieck (SGA 7 I, 1972) | **Type II-B**: Semistable reduction witness for principally polarized abelian varieties over finite $p$-adic extensions |
| `021` (`L21`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/ChowFormIntExistsAndChowFormExists.lean:249-251` (`252` lines · citations `10`) | `chowFormExists_holds` (`theorem`) | Chow-van der Waerden (1937), Philippon | **Type I**: Existence of integral and field-valued Chow forms for projective subvarieties |
| `022` (`L22`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/SerreHolomorphicSectionsHolds.lean:53-56` (`56` lines · citations `23`) | `GlobalTheory.AnRead.bijective_valC` (`theorem`) | Serre (GAGA, 1956) | **Type II-B**: Analytic-to-algebraic global section bijectivity witness for line bundles on smooth projective complex schemes |
| `023` (`L23`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/GrothendieckDeformationOfLifting.lean:9-13` (`14` lines · citations `13`) | `grothendieckDeformation_of_lifting` (`theorem`) | Grothendieck, Illusie (1971-1985) | **Type I**: Deduces smoothness of abelian deformations from de Rham cohomology and lifting properties |
| `024` (`L24`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/SemiAbelianHomExtensionHolds.lean:7-9` (`10` lines · citations `40`) | `semiAbelianHomExtension_holds` (`theorem`) | Raynaud, Faltings-Chai (1990) | **Type I**: Unique extension witness for semi-abelian group-scheme homomorphisms over normal bases |
| `025` (`L25`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/KawamataViehwegOfNadelVanishingPair.lean:62-68` (`69` lines · citations `2`) | `kawamataViehweg_of_nadelVanishingPair` (`theorem`) | Kawamata-Viehweg (1982), Nadel (1990) | **Type I**: Deduces Kawamata-Viehweg vanishing from Nadel multiplier-ideal vanishing and Kleiman numerics |
| `026` (`L26`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/JoinOutOfFive.lean:15-17` (`17` lines · citations `2`) | `GlobalTheory.JoinFun.joinOut_of_five` (`theorem`) | Internal literature-join adapter | **Assembly / Adapter**: Combines 5 CM, Siegel-Klingen, and Tate functional-equation witnesses into `JoinOut` |
| `027` (`L27`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/VolGeOfHilbertSamuel.lean:26-86` (`87` lines · citations `2`) | `volGe_of_hilbertSamuel` (`theorem`) | Yuan (2008), Moriwaki (2009) | **Type II-A**: Deduces the arithmetic difference-volume lower bound `VolGe` from arithmetic Hilbert-Samuel |
| `028` (`L28`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/L2ExtensionLogCanonical.lean:13-17` (`18` lines · citations `2`) | `l2ExtensionLogCanonical'` (`theorem`) | Ohsawa-Takegoshi (1987), Demailly (2015) | **Type II-B**: Holomorphic section $L^2$-extension witness over `0`-dimensional isolated log-canonical point centers |
| `029` (`L29`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/LogDerOneHolds.lean:11-79` (`80` lines · citations `2`) | `logDerOne_holds` (`theorem`) | Hadamard, de la Vallée Poussin (1896) | **Type I**: Pole residue of logarithmic derivatives near $s=1$ and unit-circle boundary estimates |
| `030` (`L30`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/GoodChernWeil.lean:10-12` (`13` lines · citations `2`) | `goodChernWeil` (`theorem`) | Chern-Weil, Mumford (1977) | **Type II-A**: Agreement of Chern-Weil curvature representatives on good Hermitian metrized line bundles |
| `031` (`L31`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/MetaplecticRepresentationHolds.lean:17-107` (`108` lines · citations `2`) | `metaplecticRepresentation_holds` (`theorem`) | Weil (1964) | **Type I**: Construction witness for the double-cover metaplectic representation of local and adelic symplectic groups |
| `032` (`L32`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/SemiAbelianLieSeminegativeBis.lean:22-29` (`30` lines · citations `2`) | `semiAbelianLieSeminegative` (`theorem`) | Faltings (1983), Faltings-Chai (1990) | **Type II-A**: Curvature seminegativity of dual Lie-algebra Hodge bundles of semi-abelian schemes |
| `033` (`L33`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/InfinitesimalEquivalenceUnitaryGroupPQ.lean:737-739` (`742` lines · citations `2`) | `gkGlobalisation_holds` (`theorem`) | Harish-Chandra (1953), Clozel (1986) | **Type II-A**: Infinitesimal equivalence for $U(p,q)$ and global cuspidal globalization of local discrete series |
| `034` (`L34`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/HolomorphicDiscreteSeriesHolds.lean:15-42` (`43` lines · citations `2`) | `holomorphicDiscreteSeries_holds` (`theorem`) | Harish-Chandra (1955-1956) | **Type II-A**: Lowest-weight realization witness for holomorphic discrete series on Hermitian symmetric domains |
| `035` (`L35`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/DualAbelianSchemeExistsBiduality.lean:29-34` (`35` lines · citations `16`) | `dualAbelianScheme` (`theorem`) | Grothendieck, Mumford, Raynaud | **Type I**: Existence and biduality of the dual abelian scheme over base schemes |
| `036` (`L36`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/KFiniteVectorsIrreducibleUnitaryUnitaryGroupPQ.lean:76-83` (`86` lines · citations `2`) | `kFiniteVectors_irreducibleUnitary_unitaryGroupPQ` (`theorem`) | Harish-Chandra (1953) | **Type II-A**: Density of $K$-finite vectors in irreducible unitary representations of indefinite unitary groups |
| `037` (`L37`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/DixmierMalliavinFactorisationFromLibrary.lean:7-9` (`10` lines · citations `2`) | `dixmierMalliavinFactorisation_fromLibrary` (`theorem`) | Dixmier-Malliavin (1978) | **Type I**: Finite convolution-sum factorization witness for smooth compactly supported test functions |
| `038` (`L38`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/GeometricLemmaFiltrationHolds.lean:6-8` (`9` lines · citations `7`) | `geometricLemmaFiltration_holds` (`theorem`) | Bernstein-Zelevinsky (1977), Casselman | **Type I**: Bruhat-orbit filtration witness for Jacquet restriction applied after parabolic induction |
| `039` (`L39`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/HeckeTateFE.lean:5-6` (`6` lines · citations `2`) | `GlobalTheory.Top.heckeTateFE` (`theorem`) | Tate (1950) | **Type I**: Analytic continuation and Tate functional equation for Hecke $L$-functions over number fields |
| `040` (`L40`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/LocfinHolds.lean:9-10` (`11` lines · citations `2`) | `locfin_holds` (`theorem`) | Tate, Serre (1964) | **Type I**: Finiteness wrapper witness for local Galois cohomology groups over number-field completions |
| `041` (`L41`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/LoceulerHolds.lean:8-9` (`10` lines · citations `2`) | `loceuler_holds` (`theorem`) | Tate (1957) | **Type I**: Local Galois Euler-Poincaré characteristic formula witness over number-field completions |
| `042` (`L42`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/HcfjHolds.lean:7-8` (`9` lines · citations `3`) | `hcfj_holds` (`theorem`) | Weber (1908), Shimura (1971) | **Type I**: Generation of the Hilbert class field of an imaginary quadratic field by elliptic $j$-invariants |
| `043` (`L43`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/AbelianSchemeHomLiftingNilpotentDividedPowers.lean:19-23` (`24` lines · citations `4`) | `abelianScheme_hom_lifting_nilpotent_dividedPowers` (`theorem`) | Grothendieck, Norman-Oort (1980) | **Type I**: Lifting of abelian-scheme homomorphisms across nilpotent divided-power thickenings |
| `044` (`L44`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/HoweDualityRealHolds.lean:18-48` (`51` lines · citations `2`) | `howeDualityReal_holds` (`theorem`) | Howe (1989) | **Type II-A**: Howe duality witness for archimedean real unitary reductive dual pairs |
| `045` (`L45`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/ExistsMulEquiv.lean:115-129` (`130` lines · citations `2`) | `localTateDuality` (`theorem`) | Tate (1958-1962) | **Type I**: Perfect cup-product local Tate duality in $p$-adic local Galois cohomology |
| `046` (`L46`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/ImportsTailTer.lean:14-22` (`23` lines · citations `2`) | `strongApproxSU` (`theorem`) | Kneser (1965), Platonov (1969) | **Type I**: Adelic strong approximation witness for simply connected special unitary groups $\mathrm{SU}(V)$ |
| `047` (`L47`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/ToroidalCompactificationFanLogKodairaSpencerIso.lean:8-10` (`11` lines · citations `3`) | `toroidalForFanKS` (`theorem`) | Faltings-Chai (1990), Lan (2013) | **Type II-A**: Toroidal boundary and logarithmic Kodaira-Spencer isomorphism over admissible polyhedral fans |
| `048` (`L48`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/ToroidalCompactificationHolds.lean:10-16` (`17` lines · citations `2`) | `toroidalCompactification_holds` (`theorem`) | AMRT (1975), Faltings-Chai (1990) | **Type II-A**: Existence witness for toroidal compactification models of unitary and Siegel moduli |
| `049` (`L49`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/CuspidalMirabolicHolds.lean:7-9` (`10` lines · citations `2`) | `cuspidalMirabolic_holds` (`theorem`) | S. I. Gelfand (1970), Green (1955) | **Type I**: Mirabolic-restriction irreducibility witness for cuspidal representations of finite $\mathrm{GL}_{n+1}(\mathbb{F}_q)$ |
| `050` (`L50`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/SiegelToroidalIntegralHolds.lean:14-16` (`17` lines · citations `2`) | `siegelToroidalIntegral_holds` (`theorem`) | Faltings-Chai (1990) | **Type II-A**: Construction witness for invariant projective polyhedral cone decompositions over CM rings of integers |
| `051` (`L51`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/CmCurveGoodOutsidePrime.lean:47-102` (`103` lines · citations `2`) | `cmCurveGoodOutsidePrime` (`theorem`) | Serre-Tate (1968) | **Type I**: Good reduction outside the conductor and potential good reduction for CM elliptic curves |
| `052` (`L52`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/ArithHilbertSamuelOfPrincipalisation.lean:11-15` (`16` lines · citations `2`) | `arithHilbertSamuel_of_principalisation` (`theorem`) | Gillet-Soulé (1992), Zhang (1995) | **Type I**: Deduces the asymptotic arithmetic Hilbert-Samuel formula from Hironaka principalization |
| `053` (`L53`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/KudlaSplittingSplitUnitary.lean:17-43` (`44` lines · citations `2`) | `kudlaSplittingSplitUnitary` (`theorem`) | Kudla (1994) | **Type II-A**: Metaplectic cover splitting homomorphism witness over split unitary dual pairs |
| `054` (`L54`) | `Development/AbelianVarietyTheory/Proofs/SatakeParameters/ApplyMemTwKerOfNormalizer.lean:775-781` (`782` lines · citations `16`) | `depthZeroJacquetInjective` (`theorem`) | Moy-Prasad (1994-1996) | **Type I**: Injectivity of the Jacquet map from depth-`0` representations into parahoric fixed subspaces |
| `055` (`L55`) | `Development/AbelianVarietyTheory/Proofs/SatakeParameters/AbsPowValEqZpow.lean:35-40` (`40` lines · citations `3`) | `GlobalTheory.TotDisjUnlinked.main` (`theorem`) | Zelevinsky (1980) | **Type I**: Deduces irreducibility of unlinked segment products from disjoint-support irreducibility |
| `056` (`L56`) | `Development/AbelianVarietyTheory/Proofs/SatakeParameters/RegularAlgebraicPurityOfClozel.lean:8-12` (`13` lines · citations `4`) | `regularAlgebraicPurity_of_clozel` (`theorem`) | Clozel (1990), Shin (2011), Caraiani (2012) | **Type I**: Deduces regular algebraic purity by combining Clozel cohomological representations and purity |
| `057` (`L57`) | `Development/AbelianVarietyTheory/Proofs/SatakeParameters/LocalGlobalAboveL.lean:20-37` (`40` lines · citations `3`) | `main` (`theorem`) | Caraiani (2014), BLGGT (2014) | **Type I**: Transfers local-global compatibility above $\ell$ via away-from-$\ell$ trace equality and Chebotarev density |
| `058` (`L58`) | `Development/AbelianVarietyTheory/Proofs/SatakeParameters/HeckeLAdicParameterAboveOfAlgebraicCharacterWD.lean:7-13` (`14` lines · citations `5`) | `heckeLAdicParameterAbove_of_algebraicCharacterWD` (`theorem`) | Weil (1956), Serre (1968), Tate (1979) | **Type II-A**: Deduces parameter compatibility above $\ell$ from algebraic-character Weil-Deligne matching |
| `059` (`L59`) | `Development/AbelianVarietyTheory/Proofs/SatakeParameters/CohomologicalCsdTemperedOfSegments.lean:16-29` (`30` lines · citations `5`) | `cohomologicalCsdTempered_of_caraianiTempered` (`theorem`) | Caraiani (2012), Zelevinsky (1980) | **Type I**: Proves conjugate self-dual temperedness from Caraiani temperedness and segment classification |
| `060` (`L60`) | `Development/AbelianVarietyTheory/Proofs/SatakeParameters/LocalGlobalOfGelfandKazhdan.lean:12-24` (`25` lines · citations `6`) | `galoisRepOfPolarizedCuspidal_iff_pair` (`theorem`) | Gelfand-Kazhdan (1975), CHT (2008) | **Type I**: Identifies polarized-pair and cuspidal Galois correspondence via Gelfand-Kazhdan transpose duality |
| `061` (`L61`) | `Development/AbelianVarietyTheory/Proofs/SatakeParameters/ExistsCount.lean:70-71` (`74` lines · citations `6`) | `htCard` (`theorem`) | Northcott (1949), Schanuel (1979) | **Type I**: Finiteness and explicit cardinality bound for algebraic points of bounded height |
| `062` (`L63`) | `Development/AbelianVarietyTheory/Proofs/SatakeParameters/UnitarySegmentOfCentralUnit.lean:78-101` (`101` lines · citations `2`) | `GlobalTheory.UnitLSeg.main` (`theorem`) | Zelevinsky (1980), Tadić (1986) | **Type I**: Unitarizability of Langlands segment representations with unitary central character |
| `063` (`L64`) | `Development/AbelianVarietyTheory/Proofs/SatakeParameters/LocalComponentTempered.lean:44-56` (`57` lines · citations `2`) | `main` (`theorem`) | Clozel (1991), Shin (2011) | **Type I**: Deduces temperedness of unramified local components from polarized cuspidal Galois representations |
| `064` (`L65`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/GelfandInvariantsDetermineMultiset.lean:27-68` (`69` lines · citations `3`) | `gelfVal_multiset_eq` (`theorem`) | Harish-Chandra (1958), Gelfand | **Type II-A**: Determination of the infinitesimal character multiset by universal-enveloping Gelfand invariants |
| `065` (`L66`) | `Development/AbelianVarietyTheory/Proofs/GlobalInterpolation/WeylModuleSimpleClosedLowestAlcove.lean:33-49` (`50` lines · citations `4`) | `inducedSimpleLowestAlcove` (`theorem`) | Jantzen (1987) | **Type I**: Simplicity of induced Weyl modules at weights in the closure of the lowest alcove |
| `066` (`L67`) | `Development/AbelianVarietyTheory/Proofs/IwasawaDecomposition/GlobalArtinReciprocityHolds.lean:5` (`5` lines · citations `50`) | `GlobalTheory.globalArtinReciprocity_holds` (`theorem`) | Artin (1927), Chevalley (1940) | **Type I**: Global Artin reciprocity witness between idele class groups and maximal abelian Galois groups |
| `067` (`L68`) | `Development/AbelianVarietyTheory/Proofs/InertiaEigenvalues/FontaineBcrisBasicTheoremsProof.lean:21-23` (`24` lines · citations `5`) | `fontaineBcris` (`theorem`) | Fontaine (1982-1994), Colmez-Fontaine (2000) | **Type I**: Proves the fundamental exact sequences of $B_{\mathrm{cris}}$ from algebraic-closure tensor injectivity |
| `068` (`L69`) | `Development/AbelianVarietyTheory/Proofs/InertiaEigenvalues/ChebotarevDegreeOne.lean:66-68` (`71` lines · citations `73`) | `cheb_holds` (`theorem`) | Tschebotareff (1926) | **Type I**: Density of degree-`1` Frobenius primes and finite generating sample witness `Cheb` |
| `069` (`L70`) | `Development/AbelianVarietyTheory/Proofs/InertiaEigenvalues/ExistsContractNeZero.lean:138-142` (`145` lines · citations `15`) | `depthZeroSupport` (`theorem`) | Moy-Prasad (1996), Dat | **Type I**: Preservation of supercuspidal support and first-congruence fixed vectors for depth-`0` irreducibles |
| `070` (`L71`) | `Development/AbelianVarietyTheory/Proofs/InertiaEigenvalues/ImportsTerAlt.lean:14-56` (`59` lines · citations `3`) | `main` (`theorem`) | Moy-Prasad (1996), Bushnell-Henniart | **Type II-B**: Auxiliary theorem controlling wild inertia action on depth-`0` representations |
| `071` (`L72`) | `Development/AbelianVarietyTheory/Proofs/InertiaEigenvalues/BrauerDegreeZero.lean:203-216` (`219` lines · citations `4`) | `brauerDegreeZero` (`theorem`) | Brauer (1947) | **Type I**: Integral linear combination of induced degree-`1` characters for virtual characters of degree `0` |
| `072` (`L73`) | `Development/AbelianVarietyTheory/Proofs/InertiaEigenvalues/ChevalleyUnits.lean:174-182` (`182` lines · citations `49`) | `GlobalTheory.Published.chevalleyUnits'` (`theorem`) | Chevalley (1955-1961), Bruhat-Tits | **Type I**: Generation and Bruhat-Iwahori unit decomposition of reductive groups over nonarchimedean local rings |
| `073` (`L74`) | `Development/AbelianVarietyTheory/Proofs/InertiaEigenvalues/FixedNeBotOfIsSubquotient.lean:64-82` (`85` lines · citations `14`) | `depthZeroInduction` (`theorem`) | Moy-Prasad (1994-1996), Morris | **Type I**: Compact induction of depth-`0` supercuspidal representations from finite parahoric cuspidals |
| `074` (`L75`) | `Development/AbelianVarietyTheory/Proofs/InertiaEigenvalues/LocalLanglandsOfHyp.lean:22-49` (`50` lines · citations `24`) | `localLanglandsGL_of_depthZero_zelevinsky_bernstein` (`theorem`) | Harris-Taylor (2001), Henniart (2000) | **Type I**: Deduces local Langlands for $\mathrm{GL}_n$ from depth-`0`, Zelevinsky, Brauer, and local converse |
| `075` (`L76`) | `Development/AbelianVarietyTheory/Proofs/InertiaEigenvalues/BhattScholzeCoefficientsOfPadicIntLattices.lean:98-165` (`166` lines · citations `5`) | `bhattScholze_coeff` (`theorem`) | Bhatt-Morrow-Scholze (2018), BS (2019) | **Type I**: Extends integral $A_{\inf}$ realizations to crystalline lattices over arbitrary finite coefficient extensions |
| `076` (`L77`) | `Development/AbelianVarietyTheory/Proofs/InertiaEigenvalues/HeckeLAdicCharacterAboveOfPublished.lean:14-23` (`26` lines · citations `4`) | `heckeLAdicCharacterAbove_of_potSemistable` (`theorem`) | Serre (1968), Fontaine | **Type I**: Deduces Hodge-Tate weights above $\ell$ for Hecke characters from potential semistability and de Rham |
| `077` (`L78`) | `Development/AbelianVarietyTheory/Proofs/InertiaEigenvalues/UnramifiedOrthogonalityHolds.lean:7-9` (`10` lines · citations `2`) | `unramifiedOrthogonality_holds` (`theorem`) | Tate (1962), Milne (1986) | **Type I**: Isotropy (self-annihilation) of the unramified cohomology subspace $H^1_{\mathrm{ur}}$ under local Tate pairing |
| `078` (`L79`) | `Development/AbelianVarietyTheory/Proofs/InertiaEigenvalues/BhattScholzeIntegral.lean:14-33` (`34` lines · citations `2`) | `bhattScholzeIntegral` (`theorem`) | Bhatt-Morrow-Scholze (2018) | **Type I**: Breuil-Kisin-Fargues $A_{\inf}$-module realization of $\mathbb{Z}_\ell$-lattices in crystalline Galois representations |
| `079` (`L80`) | `Development/AbelianVarietyTheory/Proofs/InertiaEigenvalues/DeRhamPotentiallySemistable.lean:11-13` (`14` lines · citations `5`) | `deRham_potentiallySemistable` (`theorem`) | Berger (2002), André, Kedlaya, Mebkhout | **Type I**: $p$-adic monodromy theorem witness proving potential semistability of de Rham Galois representations |
| `080` (`L81`) | `Development/AbelianVarietyTheory/Proofs/TwistedOperators/GeometricLemmaOfFiltration.lean:8-13` (`14` lines · citations `15`) | `geometricLemma_of_filtration` (`theorem`) | Bernstein-Zelevinsky (1977) | **Type I**: Deduces the Bernstein-Zelevinsky geometric lemma from finite-length preservation and orbit filtrations |
| `092` (`L93`) | `Development/AbelianVarietyTheory/Proofs/InertiaEigenvalues/LocalLanglandsExtensionInjective.lean:64-67` (`70` lines · citations `3`) | `lpTw_injective` (`theorem`) | Zelevinsky (1980), Rodier (1982) | **Type I**: Injectivity of Langlands parameter extension and preservation of irreducibility under twists |
| `093` (`L94`) | `Development/AbelianVarietyTheory/Proofs/InertiaEigenvalues/LocalLanglandsExtensionCharacterTwist.lean:28-41` (`44` lines · citations `6`) | `hasCentralChar_ofChar` (`theorem`) | Harris-Taylor (2001) | **Type I**: Character-twist commutativity for Weil-Deligne representations and degree-`1` central-character lemma |
| `094` (`L95`) | `Development/AbelianVarietyTheory/Proofs/InertiaEigenvalues/LocalLanglandsExtensionCentralCharacter.lean:16-23` (`24` lines · citations `5`) | `prod_roots_prod_of_monic` (`theorem`) | Harris-Taylor (2001) | **Type I**: Algebraic lemma relating products of monic characteristic-polynomial roots to central characters |
| `095` (`L96`) | `Development/AbelianVarietyTheory/Proofs/InertiaEigenvalues/LocalLanglandsExtensionRankinSelberg.lean:43-50` (`51` lines · citations `3`) | `map_summand_dual` (`theorem`) | JPSS (1983), Shahidi | **Type I**: Preservation of Rankin-Selberg dual summands and exponent shifts across Langlands direct sums |
| `096` (`L97`) | `Development/AbelianVarietyTheory/Proofs/InertiaEigenvalues/SubquotientOfProductOfSupport.lean:13-31` (`32` lines · citations `5`) | `isSubquotient_prodIrr_of_hasSupport` (`theorem`) | Bernstein-Zelevinsky (1977) | **Type I**: Realizes any irreducible representation with given supercuspidal support as a subquotient of the induced product |
| `097` (`L98`) | `Development/AbelianVarietyTheory/Proofs/InertiaEigenvalues/CuspidalEqUnitaryTwist.lean:19-47` (`48` lines · citations `2`) | `main` (`theorem`) | Bernstein-Zelevinsky (1977) | **Type I**: Unitary-twist decomposition of supercuspidal irreducibles via central-character normalization |
| `098` (`L99`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/BlockUnipotentMemUpperUnipotent.lean:31-36` (`37` lines · citations `4`) | `superDiag_mul_unip` (`theorem`) | Foundational matrix-group lemma | **Assembly / Adapter**: Additivity of superdiagonal sums across upper-triangular block unipotent matrices |
| `099` (`L100`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/InvariantIntegralVanishesIwahori.lean:53-71` (`72` lines · citations `2`) | `main` (`theorem`) | Borel (1976), Casselman (1980) | **Type I**: Vanishing criterion for invariant orbital integrals on Iwahori identity-cell indicator functions |
| `100` (`L101`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/ParabolicBlockDecompositionEmbed.lean:44-51` (`52` lines · citations `2`) | `main` (`theorem`) | Foundational algebraic-group lemma | **Assembly / Adapter**: Parabolic Levi and unipotent block-embedding identities for general linear groups over rings |
| `101` (`L102`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/ExistsBoxSubsetOfMemNhdsZero.lean:58-118` (`119` lines · citations `3`) | `one_add_small_near_one` (`theorem`) | Foundational nonarchimedean topology lemma | **Assembly / Adapter**: Adic box containment in neighborhoods of `0` and multiplicative decomposition near `1` |

### 6.4 Group 4: Automorphic Spectrum, Linnik, and CM Modules in `Development.AutomorphicSpectrum` (`5` Modules)

Five modules supplying cuspidal rapid decay on Siegel domains for $\mathrm{GL}_n(\mathbb{A})$, Galois action on CM elliptic $j$-invariants, the parabolic geometric lemma, real analyticity of Harish-Chandra matrix coefficients, and Linnik zero-density integrals.

| Index (`Import Line`) | Module Path Relative to `src/` and Representative Pin (`Lines` · `Citations`) | Representative Declaration (`Kind`) | Classical Reference and Role | Equivalence Verdict and Source Forensic Summary |
| :--- | :--- | :--- | :--- | :--- |
| `112` (`L113`) | `Development/AutomorphicSpectrum/Proofs/BlockDecomposition/CuspRapidDecaySiegelGL.lean:30-32` (`33` lines · citations `23`) | `cuspFormsBoundedGL` (`theorem`) | Godement, Borel-Jacquet (1979) | **Type I**: Proves rapid decay and global boundedness of $\mathrm{GL}_n$ cusp forms on Siegel domains over number fields |
| `113` (`L114`) | `Development/AutomorphicSpectrum/Proofs/GlobalProofs/ComplexMultiplicationJacquetShalika.lean:91-108` (`109` lines · citations `5`) | `complexMultiplicationJ` (`theorem`) | Shimura (1971) | **Type I**: Proves lattice endomorphism-ring structure and Galois action on $j$-invariants of CM elliptic curves |
| `114` (`L115`) | `Development/AutomorphicSpectrum/Proofs/GlobalProofs/GeometricLemma.lean:8-20` (`21` lines · citations `30`) | `geometricLemma` (`theorem`) | Bernstein-Zelevinsky (1977) | **Type I**: Global connecting wrapper for the parabolic induction / Jacquet restriction geometric lemma |
| `115` (`L116`) | `Development/AutomorphicSpectrum/Proofs/GlobalProofs/AdmissibleOfIwasawaDecomposition.lean:172-174` (`177` lines · citations `3`) | `harishChandra_analyticity_density` (`theorem`) | Harish-Chandra (1953-1954) | **Type II-A**: Proves real analyticity of admissible matrix coefficients and Levi density from Iwasawa decomposition |
| `147` (`L154`) | `Development/AutomorphicSpectrum/PublishedTheorems/PublishedGlobalResults/InvLogIntervalIntegrable.lean:135-140` (`143` lines · citations `2`) | `linnik` (`theorem`) | Linnik (1944) | **Type I**: Inverse-logarithm interval integrability and zero-density auxiliary witness for Linnik's theorem |

### 6.5 Group 5: Classical Master Theorem Witnesses, Local Representation Theory, and Theta Lift Modules in `Development.WeilBound` (`70` Modules)

Seventy modules (`57` in `CoreStatements` + `12` in `RepresentationTheoryGL` + `1` in `ThetaLifts`) closing Jacquet-Shalika rigidity, Bernstein irreducibility of unitary parabolic products, Tadić's generic unitary dual, Casselman-Wallach globalization, Hironaka resolution of singularities, the Poitou-Tate 9-term exact sequence, Siegel-Weil normalization, and theta-integral local matching (`TheoremKOfMod`).

| Index (`Import Line`) | Module Path Relative to `src/` and Representative Pin (`Lines` · `Citations`) | Representative Declaration (`Kind`) | Classical Reference and Role | Equivalence Verdict and Source Forensic Summary |
| :--- | :--- | :--- | :--- | :--- |
| `084` (`L85`) | `Development/WeilBound/CoreStatements/AutomorphicKernels/DepthZeroCuspidal/WhittakerSupportTildeOf.lean:231-237` (`240` lines · citations `3`) | `whittaker_support_tilde` (`theorem`) | Bernstein-Zelevinsky (1976), Bushnell-Kutzko | **Type I**: Preservation of Whittaker support under contragredient involution for depth-`0` supercuspidals |
| `086` (`L87`) | `Development/WeilBound/CoreStatements/AutomorphicKernels/DepthZeroCuspidal/IsTateEpsUnramTwist.lean:49-53` (`56` lines · citations `3`) | `TwPow` (`def`) | Tate (1979), Deligne (1973) | **Type I**: Unramified character-twist transformation formula for local Tate epsilon factors |
| `087` (`L88`) | `Development/WeilBound/RepresentationTheoryGL/GaloisPermutationReps/SubquotientEquivalence/CechDescentTests/SubquotientNontrivial.lean:54-80` (`85` lines · citations `2`) | `main` (`theorem`) | Bernstein-Zelevinsky (1977) | **Type I**: Nontriviality of unramified principal-series subquotients of $\mathrm{GL}_m$ over nonarchimedean local fields |
| `088` (`L89`) | `Development/WeilBound/CoreStatements/AutomorphicKernels/DepthZeroCuspidal/IsArtinCond.lean:24-41` (`44` lines · citations `2`) | `IsArtinCond` (`structure`) | Artin (1931), Swan | **Type I**: Axiom structure defining the local Artin conductor exponent of Weil-Deligne representations |
| `089` (`L90`) | `Development/WeilBound/RepresentationTheoryGL/GaloisPermutationReps/SubquotientEquivalence/DepthZeroIntermediateHolds.lean:17-18` (`19` lines · citations `3`) | `depth_zero_count_holds` (`theorem`) | Moy-Prasad (1996) | **Type II-B**: Subquotient equivalence and multiplicity count witness for depth-`0` intermediate parahoric induction |
| `116` (`L117`) | `Development/WeilBound/CoreStatements/HodgeTatePoints/ZarTop.lean:6-8` (`9` lines · citations `2`) | `zarhin` (`theorem`) | Zarhin (1974) | **Type I**: Zarhin's theorem constructing a principal polarization on the fourth-power product with the dual abelian scheme |
| `117` (`L118`) | `Development/WeilBound/CoreStatements/PublishedTheorems/CasselmanWallach/FinalB.lean:8-9` (`10` lines · citations `2`) | `casselmanWallach` (`theorem`) | Casselman (1989), Wallach (1992) | **Type II-A**: Smooth Fréchet completion witness for $(\mathfrak{g},K)$-modules of indefinite unitary groups |
| `118` (`L119`) | `Development/WeilBound/CoreStatements/PublishedTheorems/FiniteGLInvariants/AffineLieInvariants/Imports.lean:6-7` (`7` lines · citations `20`) | `CuspFormAutomorphicBounds.automorphicFormsFiniteGL` (`theorem`) | Harish-Chandra (1968), Borel-Jacquet (1979) | **Type I**: Finite-dimensionality witness for spaces of $\mathrm{GL}_n$ automorphic forms at fixed level and infinitesimal character |
| `119` (`L120`) | `Development/WeilBound/CoreStatements/PublishedTheorems/ClozelPurity/Bridge.lean:6-8` (`9` lines · citations `2`) | `clozelPurity` (`theorem`) | Clozel (1990), Shin (2011), Caraiani (2012) | **Type I**: Unramified Satake purity bridge witness for cohomological cuspidal representations |
| `120` (`L121`) | `Development/WeilBound/CoreStatements/PublishedTheorems/PolarizedGaloisRepresentations/GaloisRepOfPolarizedPairLit.lean:5-6` (`7` lines · citations `4`) | `GaloisRepOfPolarizedPairLit` (`def`) | CHT (2008), Shin (2011), BLGGT (2014) | **Type I**: Specification alias defining existence of Galois representations attached to polarized automorphic pairs |
| `121` (`L122`) | `Development/WeilBound/CoreStatements/PublishedTheorems/GlobalEulerCharacteristic/GlobalEulerCharOfLemmaX.lean:13-15` (`16` lines · citations `2`) | `globalEulerChar_full` (`theorem`) | Tate (1962), Milne (1986) | **Type I**: Proves the global Euler-Poincaré characteristic formula for restricted-ramification Galois cohomology |
| `122` (`L123`) | `Development/WeilBound/CoreStatements/PublishedTheorems/GlobalFiniteness/GlobalFiniteness.lean:10-22` (`23` lines · citations `2`) | `globalFiniteness` (`theorem`) | Tate (1962), Serre (1964) | **Type I**: Proves finiteness of restricted-ramification Galois cohomology groups over $S$-integers of number fields |
| `123` (`L124`) | `Development/WeilBound/CoreStatements/PublishedTheorems/JacquetShalikaRigidity/JacquetShalikaRigidity.lean:15-16` (`17` lines · citations `33`) | `jacquetShalika` (`theorem`) | Jacquet-Shalika (1981) | **Type I**: Proves isobaric strong multiplicity one and Satake bounds via Rankin-Selberg pole detection |
| `124` (`L125`) | `Development/WeilBound/CoreStatements/PublishedTheorems/SmoothVectorEstimates/CuspidalMultiplicityOne.lean:7-8` (`9` lines · citations `5`) | `cuspidalMultiplicityOne` (`theorem`) | Shalika (1974), Piatetski-Shapiro (1979) | **Type I**: $\mathrm{GL}_n$ cuspidal multiplicity one witness via uniqueness of Fourier-Whittaker expansions |
| `125` (`L126`) | `Development/WeilBound/CoreStatements/PublishedTheorems/NefNumerics/NefRiemannRoch/NefLineBundleNumericalTheoremsProof.lean:11-13` (`14` lines · citations `6`) | `nefNumerics_outright` (`theorem`) | Kleiman (1966) | **Type I**: Kleiman intersection-number nonnegativity witness for numerically effective (nef) line bundles |
| `126` (`L127`) | `Development/WeilBound/CoreStatements/PublishedTheorems/PoitouTateDuality/PoitouTateNineTerm/PoitouTateNormalisedHolds.lean:18-20` (`21` lines · citations `2`) | `poitouTateNormalised_holds` (`theorem`) | Poitou (1967), Tate (1962) | **Type I**: Witness for the normalized Poitou-Tate 9-term exact sequence in number-field Galois cohomology |
| `127` (`L128`) | `Development/WeilBound/CoreStatements/AutomorphicKernels/DeligneRibet/DeligneRibetHolds.lean:3-4` (`4` lines · citations `2`) | `PositivityTheory.PfDR.deligneRibet_holds` (`theorem`) | Deligne-Ribet (1980) | **Type I**: Special-value congruences and $p$-adic interpolation witness for partial zeta functions of totally real fields |
| `128` (`L129`) | `Development/WeilBound/CoreStatements/AutomorphicKernels/DualAbelianScheme/AbelianDeRhamDuality/AbelianDeRhamDuality.lean:20-24` (`25` lines · citations `2`) | `abelianDeRham` (`theorem`) | Grothendieck (1966), Oda (1969) | **Type I**: Local freeness, Hodge filtration, and duality witness for relative de Rham cohomology of abelian schemes |
| `129` (`L130`) | `Development/WeilBound/CoreStatements/AutomorphicKernels/LanglandsExhaustion/LanglandsMultisegmentsOfSeg.lean:16-18` (`19` lines · citations `5`) | `langlandsMultisegments_of_seg` (`theorem`) | Zelevinsky (1980), Rodier (1982) | **Type I**: Deduces unique irreducible quotients, exhaustion, and multisegment classification from segments |
| `130` (`L131`) | `Development/WeilBound/CoreStatements/AutomorphicKernels/LanglandsExhaustion/EssSquareIntegrableSegmentsOfSeg.lean:10-19` (`20` lines · citations `3`) | `essSquareIntegrableSegments_of_seg` (`theorem`) | Zelevinsky (1980) | **Type I**: Deduces classification of essentially square-integrable representations from segment representations |
| `131` (`L132`) | `Development/WeilBound/CoreStatements/AutomorphicKernels/GrothendieckRingPolynomial/GrothendieckRingPolynomialOfSeg.lean:8-13` (`14` lines · citations `7`) | `grothendieckRingPolynomial_of_seg` (`theorem`) | Zelevinsky (1980) | **Type I**: Deduces polynomial ring structure of the Grothendieck ring of smooth representations from segments |
| `132` (`L133`) | `Development/WeilBound/CoreStatements/AutomorphicKernels/LocalLanglandsExistence/InstField.lean:83-84` (`87` lines · citations `2`) | `epsFam` (`def`) | Tate (1950, 1979), Deligne (1973) | **Type I**: Self-dual local Tate measure normalization and foundational construction of local epsilon-factor families |
| `133` (`L134`) | `Development/WeilBound/CoreStatements/AutomorphicKernels/LocalLanglandsExistence/ExistsPowEqOneOfValuationEqOne.lean:191-375` (`390` lines · citations `2`) | `main` (`theorem`) | Harris-Taylor (2001), Henniart (2000) | **Type I**: Finite-order root-of-unity bounds on unit-valuation elements and Weil characteristic-polynomial divisibility |
| `134` (`L135`) | `Development/WeilBound/CoreStatements/AutomorphicKernels/LocalLanglandsExistence/ExistsCompletionEquivOfHe.lean:65-93` (`98` lines · citations `3`) | `exists_completionEquiv_of_he` (`theorem`) | Foundational complete local-field lemma | **Assembly / Adapter**: Inverse continuity of isometries and completion isomorphism for inertia-degree-`1` extensions |
| `135` (`L136`) | `Development/WeilBound/CoreStatements/AutomorphicKernels/LocalLanglandsExistence/IsTateMeasMulHighlyRamified.lean:81-85` (`103` lines · citations `2`) | `alphaChar_apply` (`theorem`) | Deligne-Henniart (1981), Jacquet | **Type I**: Local Tate Gauss-sum alpha-character formula under highly ramified character twists |
| `136` (`L137`) | `Development/WeilBound/CoreStatements/AutomorphicKernels/LocalLanglandsExistence/ContinuousOfIsSmoothChar.lean:239-244` (`247` lines · citations `2`) | `isTateMeas_localEpsilon` (`theorem`) | Tate (1950), Deligne (1973) | **Type I**: Continuity of smooth quasicharacters and Tate-measure compatibility of local epsilon factors |
| `137` (`L144`) | `Development/WeilBound/CoreStatements/AutomorphicKernels/NadelVanishing/TopNSI.lean:7-9` (`10` lines · citations `2`) | `nadelVanishingAndNonKltDivisor` (`theorem`) | Nadel (1990), Lazarsfeld (2004) | **Type I**: Nadel multiplier-ideal cohomology vanishing and non-klt divisor cutting witness |
| `138` (`L145`) | `Development/WeilBound/CoreStatements/AutomorphicKernels/NadelVanishing/TopPointSep.lean:6-8` (`9` lines · citations `3`) | `pointSeparationPair` (`theorem`) | Serre (1955), Lazarsfeld (2004) | **Type I**: Two-point-separating global section witness for sufficiently high tensor powers of ample line bundles |
| `139` (`L146`) | `Development/WeilBound/CoreStatements/AutomorphicKernels/SiegelWeilFormula/SiegelWeilStandard/SiegelWeilStd.lean:8-9` (`10` lines · citations `4`) | `siegelWeilStd` (`theorem`) | Ichino (2001-2004), GQT (2014) | **Type II-A**: Doubling Siegel-Weil normalization witness on standard Gaussian-Schwartz sections |
| `140` (`L147`) | `Development/WeilBound/CoreStatements/AutomorphicKernels/UnitaryDualGL/GenericUnitaryDual/GenericUnitaryDualGLHolds.lean:53-107` (`110` lines · citations `7`) | `genericUnitaryDualGL_holds` (`theorem`) | Tadić (1986), Vogan (1986) | **Type I**: Proves Tadić's classification of the generic unitary dual of $\mathrm{GL}_n$ admitting Whittaker models |
| `141` (`L148`) | `Development/WeilBound/CoreStatements/RegularisedThetaMirabolic/KFiniteCuspForms/CuspSp.lean:85-86` (`86` lines · citations `3`) | `RfCs.cuspidalSpectrumGL` (`theorem`) | Gelfand-Piatetski-Shapiro (1963), MW | **Type I**: Smooth $K$-finite representatives and discrete Hilbert decomposition of the $\mathrm{GL}_n$ cuspidal $L^2$-space |
| `142` (`L149`) | `Development/WeilBound/CoreStatements/AbelianHeightsDuality/GelfandKazhdanDuality/GelfandKazhdanDualOfHyp.lean:122-129` (`132` lines · citations `5`) | `gelfandKazhdanDual_of_multiplicityOne` (`theorem`) | Gelfand-Kazhdan (1975) | **Type I**: Deduces globalized Gelfand-Kazhdan transpose duality from Jacquet-Shalika rigidity and multiplicity one |
| `143` (`L150`) | `Development/WeilBound/CoreStatements/AbelianHeightsDuality/PublishedTheoremStatements/BridgesAut.lean:52-55` (`56` lines · citations `2`) | `siegelKlingenDeligneRibet_of` (`theorem`) | Green (1955), Siegel (1937), Klingen (1962) | **Type I**: Bridge combining Green parabolic series and Siegel-Klingen-Deligne-Ribet congruences |
| `144` (`L151`) | `Development/WeilBound/CoreStatements/AbelianHeightsDuality/PublishedTheoremStatements/BridgesGeo.lean:16-18` (`19` lines · citations `2`) | `arDegree_of` (`theorem`) | Faltings (1984), Bost (1996) | **Type II-A**: Deduces the Arakelov degree formula from cycle-height projections and complex Chern degrees |
| `145` (`L152`) | `Development/WeilBound/CoreStatements/AbelianHeightsDuality/PublishedTheoremStatements/BridgesMore.lean:54-56` (`57` lines · citations `6`) | `toroidalChartsForFan_of` (`theorem`) | Müller (1989), Zelevinsky (1980), AMRT | **Type I**: Bridge deriving Dixmier-Malliavin cuspidal trace class, Zelevinsky ring duality, and toroidal charts |
| `146` (`L153`) | `Development/WeilBound/CoreStatements/AbelianHeightsDuality/PublishedTheoremStatements/BridgesRep.lean:15-18` (`19` lines · citations `2`) | `flathFactorisation_of` (`theorem`) | Flath (1979) | **Type I**: Deduces Flath tensor-product factorization from restricted-tensor uniqueness and unitary admissibility |
| `148` (`L155`) | `Development/WeilBound/CoreStatements/AbelianHeightsDuality/PublishedTheoremStatements/ProvedMore.lean:82-84` (`85` lines · citations `6`) | `siegelKlingen_holds` (`theorem`) | Shimura-Taniyama (1961), Borel-Casselman | **Type I**: Aggregates 14 classical witnesses including main CM theorem, Borel-Casselman, partial zeta, and Siegel-Klingen |
| `149` (`L156`) | `Development/WeilBound/CoreStatements/ResolutionCharZero/PlugResK.lean:7-9` (`10` lines · citations `4`) | `resK` (`theorem`) | Hironaka (1964) | **Type I**: Connects characteristic-`0` resolution of singularities to the Arakelov input interface `ResK` |
| `150` (`L157`) | `Development/WeilBound/CoreStatements/ResolutionCharZero/ResolutionCharZero.lean:6-8` (`9` lines · citations `2`) | `resolutionCharZero` (`theorem`) | Hironaka (1964) | **Type I**: Smooth resolution-of-singularities existence witness for algebraic varieties in characteristic `0` |
| `151` (`L158`) | `Development/WeilBound/CoreStatements/ResolutionCharZero/PrincipalisationCharZeroClosed.lean:7-9` (`10` lines · citations `2`) | `principalisationCharZero_closed` (`theorem`) | Hironaka (1964), Bierstone-Milman (1997) | **Type I**: Principalization witness for closed subschemes on smooth schemes in characteristic `0` |
| `152` (`L159`) | `Development/WeilBound/CoreStatements/ResolutionCharZero/PrincipalisationClosed.lean:14-39` (`40` lines · citations `5`) | `principalisation_closed` (`theorem`) | Hironaka (1964), Kollár (2007) | **Type I**: Proves smooth-blowup SNC principalization of ideal sheaves on smooth projective schemes |
| `153` (`L160`) | `Development/WeilBound/CoreStatements/TotallyDisjointProducts/SLGLProductIrreducibility/TdpFill.lean:3-6` (`6` lines · citations `3`) | `PositivityTheory.SlGl.totallyDisjointProductIrreducible_of_parts` (`theorem`) | Bernstein-Zelevinsky (1977), Zelevinsky (1980) | **Type I**: Deduces irreducibility of disjoint-support parabolic products from the geometric lemma and polynomial ring |
| `154` (`L161`) | `Development/WeilBound/CoreStatements/StandardPublishedResults/StandardTheoremStatements/GlobalArtinReciprocity.lean:14-16` (`17` lines · citations `5`) | `heckeLAdicCharacter` (`theorem`) | Artin (1927), Takagi (1920), Weil (1956) | **Type I**: Standard witnesses for global Artin reciprocity, ray class fields, and algebraic Hecke $\ell$-adic characters |
| `155` (`L162`) | `Development/WeilBound/CoreStatements/StandardPublishedResults/StandardTheoremStatements/RealMetaplecticRepresentation.lean:5-7` (`8` lines · citations `2`) | `realMetaplecticRepresentation` (`theorem`) | Weil (1964), Kashiwara-Vergne (1978) | **Type I**: Standard witness for Schrödinger and Fock models of the real metaplectic group |
| `156` (`L163`) | `Development/WeilBound/CoreStatements/StandardPublishedResults/StandardTheoremStatements/GreenRegularCharacters.lean:5-7` (`8` lines · citations `3`) | `greenRegularCharacters` (`theorem`) | Green (1955), Deligne-Lusztig (1976) | **Type I**: Standard irreducibility witness for regular torus Deligne-Lusztig characters of finite $\mathrm{GL}_n(\mathbb{F}_q)$ |
| `157` (`L164`) | `Development/WeilBound/CoreStatements/StandardPublishedResults/StandardTheoremStatements/HermitianHassePrinciple.lean:18-20` (`21` lines · citations `2`) | `stoneVonNeumann` (`theorem`) | Landherr (1936), Weil (1965), Mackey (1949) | **Type I**: Standard witnesses for the Hermitian Hasse principle, rational theta invariance, and Stone-von Neumann |
| `158` (`L165`) | `Development/WeilBound/CoreStatements/StandardPublishedResults/StandardTheoremStatements/SchurOrthogonalitySquareIntegrable.lean:17-19` (`20` lines · citations `2`) | `radfordShufflePolynomial` (`theorem`) | Harish-Chandra, Hecke (1920), Radford (1979) | **Type I**: Witnesses for Schur orthogonality, partial Hecke continuation, local-global Hermitian lattices, and Radford shuffle |
| `159` (`L166`) | `Development/WeilBound/CoreStatements/StandardPublishedResults/StandardTheoremStatements/HeckeLEntireAndNonzeroAtOne.lean:21-23` (`24` lines · citations `2`) | `weylBranching` (`theorem`) | Takagi (1920), Hecke (1920), Weyl (1939) | **Type I**: Witnesses for quadratic class field theory, nonvanishing $L(1,\chi) \neq 0$, and Weyl unitary branching |
| `160` (`L167`) | `Development/WeilBound/CoreStatements/StandardPublishedResults/StandardTheoremStatements/CuspDecaySobolev.lean:11-13` (`14` lines · citations `2`) | `cuspBounded` (`theorem`) | Harish-Chandra (1968), Borel (1974) | **Type II-A**: Standard witnesses for Sobolev pointwise decay and global boundedness of unitary cusp forms |
| `161` (`L168`) | `Development/WeilBound/CoreStatements/StandardPublishedResults/StandardTheoremStatements/HarishChandraModules.lean:12-14` (`15` lines · citations `2`) | `greenCuspidal` (`theorem`) | Harish-Chandra (1953), Green (1955) | **Type II-A**: Witnesses for $U(p,q)$ cover $(\mathfrak{g},K)$-module equivalence and finite $\mathrm{GL}_n(\mathbb{F}_q)$ Green cuspidal characters |
| `162` (`L169`) | `Development/WeilBound/CoreStatements/TemperedRepresentationTheory/ArakelovCycleHeights/CycleHeightFormulas/CycleHeightsDirect.lean:144-147` (`148` lines · citations `2`) | `cycleHeights_direct` (`theorem`) | Gillet-Soulé (1990), Bost-Gillet-Soulé (1994) | **Type II-A**: Direct construction of Arakelov intersection calculus and cycle heights from Poincaré-Lelong and resolution |
| `163` (`L170`) | `Development/WeilBound/CoreStatements/TemperedRepresentationTheory/BernsteinZelevinskyGL/TopAdm.lean:6-8` (`9` lines · citations `41`) | `irreducibleAdmissibleGL_top` (`theorem`) | Bernstein (1974), Jacquet (1975) | **Type I**: Top-level admissibility witness for smooth irreducible representations of nonarchimedean $\mathrm{GL}_n$ |
| `164` (`L171`) | `Development/WeilBound/CoreStatements/TemperedRepresentationTheory/BernsteinZelevinskyGL/TopStd.lean:7-12` (`13` lines · citations `9`) | `standardFunctorsFiniteLength_top` (`theorem`) | Bernstein-Zelevinsky (1977) | **Type I**: Top-level finite-length preservation witness for parabolic induction and Jacquet restriction functors |
| `165` (`L172`) | `Development/WeilBound/CoreStatements/TemperedRepresentationTheory/ChernDegreeComplex/ChernDegreeComplex.lean:19-52` (`53` lines · citations `2`) | `chernDegreeComplex` (`theorem`) | Chern (1946), Griffiths-Harris (1978) | **Type I**: Proves equality between algebraic degree and Chern curvature integral for Hermitian bundles on complex curves |
| `166` (`L173`) | `Development/WeilBound/CoreStatements/TemperedRepresentationTheory/FormalAlgebraisation/Development.lean:17-23` (`24` lines · citations `2`) | `formalAlgebraisation` (`theorem`) | Grothendieck (EGA III, 1961) | **Type I**: Grothendieck formal algebraization (GFGA) for line bundles and sections over formal completions of projective maps |
| `167` (`L174`) | `Development/WeilBound/CoreStatements/TemperedRepresentationTheory/GeometricSplitting/Imports.lean:5-6` (`6` lines · citations `9`) | `PositivityTheory.Geo.geometricLemmaFiltration` (`theorem`) | Bernstein-Zelevinsky (1977) | **Type I**: Import bridge witness for the geometric-splitting Bruhat filtration theorem |
| `168` (`L175`) | `Development/WeilBound/CoreStatements/TemperedRepresentationTheory/MultiplicityOneRigidity/GelfandKazhdanDualOfRigidity.lean:72-79` (`82` lines · citations `8`) | `gelfandKazhdanDual_of_rigidity` (`theorem`) | Gelfand-Kazhdan (1975), Jacquet-Shalika (1981) | **Type I**: Deduces globalized Gelfand-Kazhdan transpose duality directly from Jacquet-Shalika rigidity and boundedness |
| `169` (`L176`) | `Development/WeilBound/CoreStatements/TemperedRepresentationTheory/NefDivisors/NefRR.lean:14-53` (`54` lines · citations `2`) | `nefRR` (`theorem`) | Fujita, Lazarsfeld (2004) | **Type I**: Proves asymptotic Riemann-Roch dimension inequalities for numerically effective (nef) line bundles |
| `170` (`L177`) | `Development/WeilBound/CoreStatements/TemperedRepresentationTheory/PoincareLelong/PoincareLelongInv.lean:19-24` (`25` lines · citations `3`) | `poincareLelongInv` (`theorem`) | Lelong (1957), Demailly | **Type I**: Poincaré-Lelong current equation and inversion witness for meromorphic sections on complex manifolds |
| `171` (`L178`) | `Development/WeilBound/RepresentationTheoryGL/CasimirAlgebra/KugaCoordinates/ClozelCohomological.lean:8-10` (`11` lines · citations `4`) | `clozelCohomological` (`theorem`) | Clozel (1991), Shin (2011) | **Type I**: Constructs cohomological Galois representations via Kuga-Sato coordinates, Whittaker differentials, and cochains |
| `172` (`L179`) | `Development/WeilBound/RepresentationTheoryGL/DiscreteSeries/DiscreteSeriesCovers/FdTopB.lean:9-10` (`11` lines · citations `2`) | `formalDegreeCompactDual` (`theorem`) | Harish-Chandra (1966), Gross-Prasad | **Type II-A**: Proportionality witness between covering-group discrete-series formal degrees and compact-dual Weyl degrees |
| `173` (`L180`) | `Development/WeilBound/RepresentationTheoryGL/EisensteinSeries/SiegelEisensteinContinuation/EisensteinChartSplitting/SiegelEisensteinContinuation.lean:8-11` (`12` lines · citations `2`) | `siegelEisensteinContinuation` (`theorem`) | Langlands (1976), Shimura, Tan (1999) | **Type II-A**: Meromorphic analytic continuation and functional equation of unitary Siegel Eisenstein series |
| `174` (`L181`) | `Development/WeilBound/RepresentationTheoryGL/EisensteinSeries/SiegelEisensteinHalfPlane/SchwartzBruhatMajorants/SiegelMultOf.lean:101-114` (`115` lines · citations `8`) | `eisBL` (`theorem`) | Kudla-Rallis (1990-1994), Lapid-Rallis | **Type II-A**: Doubling boundary Eisenstein witness `EisBL` established via Schwartz-Bruhat majorants |
| `175` (`L182`) | `Development/WeilBound/RepresentationTheoryGL/EisensteinSeries/SiegelEisensteinHalfPlane/IntegralUnitCoefficients/CoefND.lean:24-26` (`29` lines · citations `3`) | `field` (`theorem`) | Kudla-Rallis (1988-1994), Ichino (2004) | **Type II-A**: Agreement of nondegenerate unitary Siegel-Weil Fourier coefficients in the Schrödinger model basis |
| `176` (`L183`) | `Development/WeilBound/RepresentationTheoryGL/EisensteinResidues/AnisotropicGlobalForms/DmOfHyp.lean:24-35` (`36` lines · citations `11`) | `dm_of_two` (`theorem`) | Piatetski-Shapiro-Rallis (1987), LR (2005) | **Type II-A**: Deduces doubling-method zeta integral continuation `DM` from cuspidal rapid decay and Eisenstein continuation |
| `177` (`L184`) | `Development/WeilBound/RepresentationTheoryGL/GenericUnitaryGL/ComplementarySeries/SegmentJacquetSubquotients/SegmentRepresentation.lean:9-13` (`14` lines · citations `15`) | `segmentRepresentation` (`theorem`) | Zelevinsky (1980) | **Type I**: Unique irreducible quotient and Jacquet subquotient structure witness for supercuspidal segments |
| `178` (`L185`) | `Development/WeilBound/RepresentationTheoryGL/GenericUnitaryGL/GenericUnlinkedGL/GenericUnlinkedGLOfSegRep2.lean:11-15` (`16` lines · citations `6`) | `genericUnlinkedGL_of_segRep2` (`theorem`) | Zelevinsky (1980) | **Type I**: Deduces classification of generic representations as pairwise unlinked segment products |
| `179` (`L186`) | `Development/WeilBound/RepresentationTheoryGL/ConstantTermFiniteness/CuspidalConstantTerms/FiniteOfCuspOfConstTerm.lean:129-133` (`136` lines · citations `2`) | `_root_.PositivityTheory.RgHf.harishChandraFinite` (`theorem`) | Harish-Chandra (1968) | **Type II-A**: Proves finite-dimensionality of `D7` unitary automorphic forms by induction on cuspidal constant terms |
| `180` (`L187`) | `Development/WeilBound/RepresentationTheoryGL/UnitaryDualProof/BernsteinExponentBounds/BernAll.lean:27-28` (`29` lines · citations `3`) | `bernsteinUnitaryProductIrreducible` (`theorem`) | Bernstein (1984) | **Type I**: Proves irreducibility of $\mathrm{GL}_r \times \mathrm{GL}_t$ unitary parabolic products via Bernstein exponent bounds |
| `181` (`L188`) | `Development/WeilBound/ThetaLifts/Reductions/FiniteClosure/TheoremKOfMod.lean:26-28` (`29` lines · citations `3`) | `theoremK_head2` (`theorem`) | Kudla-Rallis, HKS (1996), Mínguez (2008) | **Type II-A**: Combines doubling Eisenstein, standard Siegel-Weil, and Howe duality to deduce theta-integral local matching |

### 6.6 Group 6: Automorphic-Galois Assembly, Base Change, and Top-Level Welding Modules in `Development.AutomorphicArithmetic` (`33` Modules)

Thirty-three modules supplying Arthur-Clozel and Labesse-Shin base change, the Rallis inner product formula, prismatic Dieudonné exactness, and Linnik's theorem alongside the `ThirdPlaceSeries` hypothesis structures, the covolume bound (`TopCovolSlim2Use`), and the final deduction of the Riemann Hypothesis (`RiemannHypothesisOfEveryCharacter`).

| Index (`Import Line`) | Module Path Relative to `src/` and Representative Pin (`Lines` · `Citations`) | Representative Declaration (`Kind`) | Classical Reference and Role | Equivalence Verdict and Source Forensic Summary |
| :--- | :--- | :--- | :--- | :--- |
| `082` (`L83`) | `Development/AutomorphicArithmetic/ThetaCorrespondence/AlgebraicCharacters/AlgebraicCharacterWD.lean:9-33` (`33` lines · citations `4`) | `UpperTheory.Lit.CharWD.algebraicCharacterWD` (`theorem`) | Weil (1956), Tate (1979) | **Type II-A**: Proves local Weil-Deligne compatibility for algebraic Hecke characters from Artin reciprocity and de Rham |
| `083` (`L84`) | `Development/AutomorphicArithmetic/ThetaCorrespondence/GaloisRepresentations/BlochKatoLocal.lean:3` (`3` lines · citations `2`) | `UpperTheory.Lit.blochKatoLocal` (`theorem`) | Bloch-Kato (1990) | **Type I**: Compatibility witness for local Bloch-Kato finite cohomology subspaces $H^1_f$ |
| `090` (`L91`) | `Development/AutomorphicArithmetic/ThetaCorrespondence/GaloisRepresentations/GreenbergWiles.lean:3-6` (`6` lines · citations `2`) | `UpperTheory.Lit.greenbergWiles` (`theorem`) | Greenberg, Wiles (1995) | **Type I**: Deduces the Greenberg-Wiles dual Selmer ratio formula from Poitou-Tate duality and Euler characteristics |
| `091` (`L92`) | `Development/AutomorphicArithmetic/ThetaCorrespondence/GaloisRepresentations/HeckeDeRham.lean:3` (`3` lines · citations `3`) | `UpperTheory.Lit.heckeLAdicCharacterDeRham` (`theorem`) | Serre (1968), Fontaine | **Type I**: De Rham property witness at places above $\ell$ for $\ell$-adic Galois characters of algebraic Hecke characters |
| `102` (`L103`) | `Development/AutomorphicArithmetic/ThetaCorrespondence/Linnik.lean:142-155` (`156` lines · citations `2`) | `linnik` (`theorem`) | Linnik (1944) | **Type I**: Proves polynomial bound $p \le C q^L$ for the least prime in an arithmetic progression modulo $q$ |
| `103` (`L104`) | `Development/AutomorphicArithmetic/ThetaCorrespondence/FockModels/GlnTemp.lean:22-48` (`51` lines · citations `2`) | `temperedProduct` (`theorem`) | Jacquet (1977), Waldspurger (2003) | **Type I**: Classification of tempered representations as unitary parabolic products of square-integrable segments |
| `104` (`L105`) | `Development/AutomorphicArithmetic/ThetaCorrespondence/FockModels/RallisDM.lean:24-111` (`115` lines · citations `2`) | `rallis_of_dm` (`theorem`) | Rallis (1984), Li (1992), GQT (2014) | **Type II-A**: Proves the Rallis inner product formula from the doubling method and convergent Siegel-Weil |
| `105` (`L106`) | `Development/AutomorphicArithmetic/ThetaCorrespondence/FockModels/FockAnisoFree.lean:17-21` (`22` lines · citations `5`) | `fockAniso_free` (`theorem`) | Kudla-Rallis (1994), Ichino (2007) | **Type II-A**: Freeness of anisotropic Fock models and extended unitary Siegel-Weil witness |
| `106` (`L107`) | `Development/AutomorphicArithmetic/ThetaCorrespondence/PrismaticDieudonne/PrismaticDieudonneHodge.lean:27-29` (`32` lines · citations `3`) | `farguesExact` (`theorem`) | Anschütz-Le Bras (2023), Fargues (2010) | **Type II-B**: Proves the prismatic Dieudonné Hodge exact sequence and Fargues Harder-Narasimhan filtration exactness |
| `107` (`L108`) | `Development/AutomorphicArithmetic/ThetaCorrespondence/WeilRepresentation/WeilEx.lean:6-7` (`8` lines · citations `2`) | `weilRepresentationExists_pair` (`theorem`) | Weil (1964) | **Type II-A**: Existence wrapper witness for local and global Weil representation pairs |
| `108` (`L109`) | `Development/AutomorphicArithmetic/ThetaCorrespondence/WeilRepresentation/WeilTheta.lean:9-11` (`12` lines · citations `4`) | `weilThetaConvergence` (`theorem`) | Borel-Harish-Chandra (1962), Weil (1965) | **Type II-A**: Unitary Siegel fundamental-domain covering and Weil theta-series convergence witness |
| `109` (`L110`) | `Development/AutomorphicArithmetic/AutomorphicVarieties/AutomorphicForms/TemperedLocalComponents/PSpecC.lean:19-24` (`24` lines · citations `2`) | `UpperTheory.V.Af.cuspSpectrumGL` (`theorem`) | Gelfand-Piatetski-Shapiro (1963), Godement | **Type I**: Package bundling discrete decomposition and central-character-norm boundedness of the $\mathrm{GL}_n$ cuspidal spectrum |
| `110` (`L111`) | `Development/AutomorphicArithmetic/Foundations/BaseChangeIdentities/DefiniteNHolds.lean:5-6` (`6` lines · citations `5`) | `UpperTheory.BaseChangeIdentities.baseChangeN` (`theorem`) | Arthur-Clozel (1989) | **Type II-A**: Isobaric base-change existence witness in the definite unitary-CM setting |
| `111` (`L112`) | `Development/AutomorphicArithmetic/Foundations/BaseChangeIdentities/Narrow.lean:73-75` (`78` lines · citations `9`) | `bridge` (`theorem`) | Labesse (2011), Shin (2014) | **Type II-B**: Deduces `DefiniteN` from isobaric base change over the everywhere-unramified CM locus |
| `182` (`L189`) | `Development/AutomorphicArithmetic/ThetaCorrespondence/FockModels/EveryCharacterE.lean:73-87` (`88` lines · citations `3`) | `CovE` (`structure`) | Alpöge-Claude top-level assembler | **Assembly / Adapter**: Earlier assembler combining theta, Siegel-Weil, local Langlands, covolume bounds, and `VWin` |
| `183` (`L190`) | `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/HodgeBundleWeights/TopCovolSlim2Use.lean:16-22` (`24` lines · citations `2`) | `topCovolSlim2_use_alt` (`theorem`) | Faltings-Chai, Moriwaki, Fargues, Zarhin | **Assembly / Adapter**: Deduces the arithmetic covolume bound from Arakelov Chow heights, Zarhin, Fargues, and Moriwaki volume |
| `185` (`L192`) | `Development/AutomorphicArithmetic/CharacterBoxes/RiemannHypothesisOfEveryCharacter.lean:215-231` (`231` lines · citations `3`) | `UpperTheory.riemannHypothesis_of_everyCharacter` (`theorem`) | Riemann functional equation and Euler-product corollary | **Assembly / Adapter**: Deduces `RiemannHypothesis` from `EveryCharacter` ($\mathrm{Re}(s)>1/2$ zero-freeness) and completed-zeta symmetry |
| `186` (`L193`) | `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/CohomologicalCsdTempered.lean:1` (`1` line · citations `2242`) | *(no declaration: `import Mathlib` stub)* | Refactoring compatibility empty stub (citations `2242`) | **Assembly / Adapter**: Single-line `import Mathlib` stub preserving `2,242` downstream imports of a former hypothesis hub |
| `187` (`L194`) | `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/SiegelEisensteinSecondTermHypotheses.lean:69-73` (`76` lines · citations `1`) | `every_character_of_theta_integrals_local_matching` (`theorem`) | Alpöge-Claude third-place master assembler | **Assembly / Adapter**: Welds the `60`-field and `53`-field hypothesis bundles with `RecTExists` and `VWin` to deduce `EveryCharacter` |
| `188` (`L195`) | `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/TopCovolSlim2Use.lean:16-22` (`25` lines · citations `1`) | `topCovolSlim2_use_alt_alt` (`theorem`) | Faltings-Chai, Moriwaki, Fargues, Zarhin | **Assembly / Adapter**: Third-place refactored assembly theorem producing the covolume bound `CovolumeBoundOfX` |
| `189` (`L196`) | `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/LlOf.lean:18-21` (`25` lines · citations `3`) | `llOf_alt` (`theorem`) | Refactoring signature projection adapter | **Assembly / Adapter**: Compatibility projector returning its first argument `RecTExists` out of `12` local and global inputs |
| `190` (`L197`) | `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/BernsteinUnitaryProductIrreducible.lean:83-84` (`87` lines · citations `7`) | `UnitaryGroupThirdPlaceHypotheses.geometricLemma` (`theorem`) | Alpöge-Claude third-place hypothesis structure | **Assembly / Adapter**: Defines `UnitaryGroupThirdPlaceHypotheses` (`60` fields) and `NonEndoscopicHypothesesAlt` (`5` fields) |
| `191` (`L198`) | `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/LocalRepresentationTheoryHypotheses.lean:33-49` (`52` lines · citations `6`) | `GlobalAutomorphicGaloisHypotheses'` (`structure`) | Alpöge-Claude local and automorphic hypothesis structures | **Assembly / Adapter**: Defines `LocalRepresentationTheoryHypothesesAlt` (`19` fields) and `GlobalAutomorphicGaloisHypotheses'` (`16` fields) |
| `192` (`L199`) | `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/LitCharCrys.lean:9-12` (`12` lines · citations `1`) | `UpperTheory.Lit.heckeLAdicCharacterCrystalline_of_deRham` (`theorem`) | Serre (1968), Fontaine | **Type II-B**: Deduces crystallineness of unramified Hecke Galois characters from de Rham, potential semistability, WD, and `RecTExists` |
| `193` (`L200`) | `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/WeightsConj.lean:81-82` (`85` lines · citations `37`) | `mergeP'_alt` (`theorem`) | CHT (2008), Shin (2011) | **Type II-B**: Conjugate-weight symmetry and polarized cuspidal compatibility lemma for `RecT`-based Galois correspondence |
| `194` (`L201`) | `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/SOfStar.lean:54` (`57` lines · citations `2`) | `ofDual_star_alt` (`theorem`) | CHT (2008), Caraiani (2012) | **Assembly / Adapter**: Extracts `PairUAlt` and `CarUAlt` from the `Row` fields of `OpenLiteratureStatements` |
| `195` (`L202`) | `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/HeckeLAdicParameterAbove.lean:13-22` (`25` lines · citations `6`) | `HeckeLAdicParameterAboveAlt` (`def`) | Serre (1968), Tate (1979) | **Type II-A**: Defines the parameter-matching specification `HeckeLAdicParameterAboveAlt` at places above $\ell$ for algebraic Hecke characters |
| `196` (`L203`) | `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/HeckeLAdicParameterAboveOfAlgebraicCharacterWDAl.lean:10-15` (`17` lines · citations `2`) | `heckeLAdicParameterAbove_of_algebraicCharacterWD_alt` (`theorem`) | Serre (1968), Tate (1979) | **Type II-A**: Deduces the refactored specification `HeckeLAdicParameterAboveAlt` from `AlgebraicCharacterWD` |
| `197` (`L204`) | `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/SPairs.lean:16` (`18` lines · citations `5`) | `carU_of_regular_algebraic_purity` (`theorem`) | Gelfand-Kazhdan (1975), CHT (2008) | **Assembly / Adapter**: Converts `PairUAlt` into `CuspUAlt` via globalized Gelfand-Kazhdan transpose duality |
| `198` (`L205`) | `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/SOneRow.lean:11-12` (`14` lines · citations `2`) | `bridgeStar_alt` (`theorem`) | Gelfand-Kazhdan (1975), Caraiani (2012) | **Assembly / Adapter**: Dual bridge combining the `Row -> CarUAlt` and `PairUAlt -> CuspUAlt` conversions |
| `199` (`L206`) | `Development/AutomorphicArithmetic/Foundations/UnitarySphericalFixing/SatakeParameters/RecT.lean:6` (`6` lines · citations `5`) | `UpperTheory.One.M.Row` (`def`) | Alpöge-Claude top-level interface alias | **Assembly / Adapter**: Defines the `IsRecT`-based Galois / local-Langlands compatibility alias `UpperTheory.One.M.Row` |
| `200` (`L207`) | `Development/AutomorphicArithmetic/Foundations/LocalLanglands/IsRecTOfIsRec.lean:106-113` (`116` lines · citations `775`) | `isRecT_of_isRec` (`theorem`) | Bushnell-Henniart (2006), Green (1955) | **Type II-B**: Defines the `GoodCusp` locus-specialized local Langlands `LawsT` over characters and depth-`0` twists over $\mathbb{Q}_g$ |
| `201` (`L208`) | `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/AlLocalGlobalAboveLPstlocalGlobalAboveL.lean:3` (`3` lines · citations `1`) | `UpperTheory.GalS.CarUAlt.localGlobalAboveL` (`theorem`) | Internal identity type-alias bridge | **Assembly / Adapter**: Three-line compatibility wrapper routing `CarUAlt` local-global compatibility above $\ell$ to `carId` |

### 6.7 Checklist of `8` Core Type II Translation Adapters for Authoring a `150`-Page Condensed Human Monograph

Synthesizing the exhaustive audit across Chapters 1 through 6, `127` (`63.18%`) of the `201` direct local imports are **Type I** modules matching the classical literature one-to-one, `19` (`9.45%`) are internal **Assembly / Adapter** modules, and the remaining **`55` (`27.36%`: `44` Type II-A + `11` Type II-B)** are propositions projected onto archive-specific data structures or restricted to specialized sub-loci.
Furthermore, the intersection between the `201` direct imports and the `1,073`-file `PublishedTheorems` layer consists of `17` modules (`007` through `011`, `117` through `126`, `147`, and `184`), serving as direct junction files that combine target specifications and top-level witnesses in one place.

When human researchers reconstruct a self-contained mathematical paper of roughly `150` pages by citing standard published literature in place of the `13.15 million` lines of internal reproof code, the `8` core translation adapters ($T_{\mathrm{lit}} \implies P_{\mathrm{arch}}$) that must be stated and verified as appendix lemmas are summarized in the table below.

| Index | Target Specialized Proposition Group (`Type`) | Representative Source Pin (Relative to `src/`) | Classical Literature $T_{\mathrm{lit}}$ to Cite | Translation Adapter Lemma to Verify in the Condensed Paper Appendix |
| :---: | :--- | :--- | :--- | :--- |
| `A1` | `GrpData p q` real representation theory (`Type II-A`) | `Development/AbelianVarietyTheory/PublishedTheorems/TwistedTraceFormula/HarishChandraModulesOn.lean:24-45` | Harish-Chandra (1953, 1966), Knapp (1986) | The $\det^{1/2}$ double cover $G \subset \mathrm{GL}_{p+q}(\mathbb{C}) \times \mathbb{C}^\times$ is a closed matrix Lie group with finite center satisfying the Harish-Chandra class axioms |
| `A2` | `UJset ε` Casselman-Wallach (`Type II-A`) | `Development/AbelianVarietyTheory/PublishedTheorems/AutomorphicForms₂/HasDRepIffHasDerivAt.lean:98-112` | Casselman (1989), Wallach (1992) | The `IsSmoothModRep` seminorm growth rate $(1 + \mathrm{hs}(g))^N$ is topologically equivalent to the standard moderate-growth Fréchet representation condition |
| `A3` | `D7` adelic cuspidal rapid decay and finiteness (`Type II-A`) | `Development/AbelianVarietyTheory/PublishedTheorems/AutomorphicForms₂/ExistsNormLeHeightPow.lean:28-33` | Harish-Chandra (1968), Borel (1974) | `IsExpFam` differential-word domination and fixed `gelf` central-operator eigenvalues imply the standard Siegel-domain $(\mathfrak{g},K)$-automorphic form hypotheses |
| `A4` | `GoodCusp` local Langlands `IsRecT` (`Type II-B`) | `Development/AutomorphicArithmetic/Foundations/LocalLanglands/IsRecTOfIsRec.lean:55-81` | Harris-Taylor (2001), Bushnell-Henniart (2006) | The general local Langlands correspondence plus the depth-`0` tame inertia formula satisfy all `12` fields of `LawsT` via `isRecT_of_isRec` (`L106-113`) |
| `A5` | Unramified CM base change `DefiniteN` (`Type II-B`) | `Development/AutomorphicArithmetic/Foundations/BaseChangeIdentities/Narrow.lean:28-35` | Labesse (2011), Shin (2014) | Over everywhere-unramified (`IsUnramifiedAt`) CM extensions, stable base change satisfies the split and inert spherical Satake matching condition `IsBaseChangeU` |
| `A6` | Half-convergent Siegel-Weil and Rallis inner product (`Type II-A`) | `Development/AbelianVarietyTheory/PublishedTheorems/SiegelWeil₂/SiegelWeilUnitaryConvergent.lean:18-33` | Ichino (2001, 2004), GQT (2014) | Under unit lattice covolume `IsCovolOne` and Kudla splitting character $\chi_B$ normalization, the Eisenstein special value and theta-mean scalar match with constant `1` |
| `A7` | Point-center $L^2$-extension and section GAGA (`Type II-B`) | `Development/AbelianVarietyTheory/PublishedTheorems/Divisors₂/L2ExtensionLogCanonical.lean:32-55` | Demailly (2015), Serre (1956) | The `0`-dimensional isolated-point Jacobian residue universal constant is bounded by $34/\delta \cdot 2^{n+1}\pi^n / \Gamma(n)$, and `LB.Sec` is isomorphic to algebraic $H^0$ |
| `A8` | Prismatic Dieudonné and normalized Poitou-Tate (`Type II-B`) | `Development/AbelianVarietyTheory/PublishedTheorems/Divisors₂/InjectiveOfSmulMemRange.lean:23-67` | Anschütz-Le Bras (2023), Poitou-Tate (1967) | Full prismatic Dieudonné equivalence implies bijectivity on $\mathrm{Hom}(\underline{\mathbb{Q}_p/\mathbb{Z}_p}, \mu_{p^\infty})$, and $\ell \neq 2 \lor F$ totally complex eliminates real-place `2`-torsion |
