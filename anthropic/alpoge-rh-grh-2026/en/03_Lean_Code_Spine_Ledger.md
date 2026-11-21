# 03. Lean Code Spine Ledger (Line-Pinned Trace from `Main.lean` to the Five-Act Core)

Although the upstream archive (`175,187` files, `17,374,215` lines) ships as a commentless source tree, tracing backward from `src/Main.lean:1-12` separates the entire proof into four clean architectural levels (`PASS`). This ledger maps every spine vertex, metaprogramming file, `VWin` assembler, and `UnusedSlot` identifier to its exact file path and line range.

---

## 1. Top-Level Entry Points: Stock `Mathlib` Definitions and the 5 Headline Theorems (`Level 0 - 1`)

### 1.1 Target Statement File (`src/Statements.lean:1-16`, `16` lines total)
- **Imports**: Single line `import Mathlib` (line `1`). Zero custom axioms or wrapper structures.
- **Four Exported Propositions**:
    - Zeta critical-line predicate (`RiemannZetaZerosOnLine`, lines `3-4`): if $\zeta(s) = 0$ and $s$ is neither a trivial negative even integer $-2(n+1)$ nor the pole $s = 1$, then $\mathrm{Re}(s) = 1/2$.
    - Dirichlet half-plane nonvanishing (`DirichletLNonvanishingRightOfHalf`, lines `6-8`): for every modulus $N > 0$ and Dirichlet character $\chi \bmod N$, if $\mathrm{Re}(s) > 1/2$ and $(\chi \neq 1 \lor s \neq 1)$, then $L(s, \chi) \neq 0$.
    - Dirichlet critical-strip alignment (`DirichletLZerosOnLine`, lines `10-12`): every zero of $L(s, \chi)$ inside $0 < \mathrm{Re}(s) < 1$ satisfies $\mathrm{Re}(s) = 1/2$.
    - Primitive Dirichlet critical-line predicate (`PrimitiveDirichletLZerosOnLine`, lines `14-16`): same critical-strip alignment restricted to primitive characters.

### 1.2 Top-Level Theorem File (`src/Main.lean:1-12`, `12` lines total)
- Line `4`: Stock `Mathlib` Riemann Hypothesis (`theorem riemannHypothesis : RiemannHypothesis := rhOfAll`)
- Line `6`: Explicit zeta critical-line theorem (`theorem riemannZeta_eq_zero_re : RiemannZetaZerosOnLine := rhOfAll`)
- Line `8`: Dirichlet half-plane nonvanishing (`theorem LFunction_ne_zero_of_half_lt_re : DirichletLNonvanishingRightOfHalf := allChi`)
- Line `10`: Dirichlet critical-strip theorem (`theorem LFunction_eq_zero_re : DirichletLZerosOnLine := claimAll.2.1`)
- Line `12`: Primitive Dirichlet critical-line theorem (`theorem LFunction_eq_zero_re_of_isPrimitive : PrimitiveDirichletLZerosOnLine := critAll`)

---

## 2. Functional-Equation Reflection Bridge (`Level 2`)

### 2.1 Kernel Bridge (`src/Supplements/Kernels/MainTheorems.lean:7-16`)
- Line `7`: Master character nonvanishing (`theorem allChi : UpperTheory.EveryCharacter := UpperTheory.FinalTheorems.everyCharacter`)
- Line `9`: Specialization to `RiemannHypothesis` (`theorem rhOfAll : RiemannHypothesis := Formalism.VW.rh_of_every allChi`)
- Lines `11-13`: Reflection across $\mathrm{Re}(s) = 1/2$ (`theorem critAll ... := Formalism.VW.critLine allChi N χ hχ s h0 h1 hz`)

### 2.2 Gamma Nonvanishing & Functional Reflection (`src/Formalism/GammaFactorNonvanishing/CritLine.lean:6-32` · `src/Development/AutomorphicArithmetic/CharacterBoxes/RiemannHypothesisOfEveryCharacter.lean:211-229`)
- **Mathematical Role**: Given nonvanishing on $\mathrm{Re}(s) > 1/2$ (`EveryCharacter`), the completed functional equation $\Lambda(s, \chi^{-1}) = \varepsilon \Lambda(1-s, \chi)$ together with Archimedian gamma nonvanishing (`gammaFactor_ne_zero`, line `6`) reflects any hypothetical zero in $0 < \mathrm{Re}(s) < 1/2$ to $1 - s$ in $\mathrm{Re}(1-s) > 1/2$, yielding an immediate contradiction.
  Specializing to $N = 1$ ($L(s, 1) = \zeta(s)$, `LFunction_modOne_eq`) yields `RiemannHypothesis`.

---

## 3. The Master Bifurcation: `195` Classical Wrappers Joined with `VWin` (`Level 3`)

### 3.1 Master Conclusion Join (`src/Development/AutomorphicArithmetic/CharacterBoxes/MainConclusion.lean:7-14`)
```lean
theorem UpperTheory.FinalTheorems.everyCharacter_of_row
    (h : UpperTheory.GalStar.Row0b fun h rc => UpperTheory.Zero.LLC.IsRecT h rc) :
    UpperTheory.EveryCharacter :=
  UpperTheory.LiteratureTheorems.every_character_of_literature_of_vWin
    ⟨h, UpperTheory.Zero.LLC.recTExists, h⟩ (UpperTheory.One.vwin_of_row h)

theorem UpperTheory.FinalTheorems.everyCharacter : UpperTheory.EveryCharacter :=
  UpperTheory.FinalTheorems.everyCharacter_of_row
    UpperTheory.Gal.Int.galoisLocalGlobalStrong_recParameter
```
- **Three Transitive Dependency Cones ([anatomy_stats.json](../data/anatomy_stats.json))**:
    1. Local Langlands parameter existence (`recTExists`, `src/Development/AutomorphicArithmetic/Foundations/LocalLanglands/LocalCentralUnits/RecTExists.lean:1-6`): `26,673` files / `4,206,972` lines.
    2. Theta-lift Galois local-global compatibility (`galoisLocalGlobalStrong_recParameter`, `src/Development/AutomorphicArithmetic/Foundations/GaloisRepresentations/IntegralStructures/RowSrc.lean:6`): `66,168` files / `7,850,273` lines.
    3. Automorphic window discharge (`vwin_of_row`, `src/Development/AutomorphicArithmetic/AutomorphicVarieties/ModularityArgument/ThresholdArguments/DenseThresholdCases/VwinOfRow.lean:4-5`): `157,604` files / `16,087,324` lines (`146,772` files / `15,057,843` lines [`93.6%`] overlapping `OpenLiteratureStatements` + `10,832` files / `1,029,481` lines [`6.4%`] novel Vandiver layer `Pure_Vwin_Outside_Literature`).

### 3.2 Automorphic Window Interface (`src/Development/AutomorphicArithmetic/CharacterBoxes/EveryCharacter.lean:8-18` · `src/Development/AutomorphicArithmetic/CharacterBoxes/ExistsPageN.lean:12-50`)
- Primitive nonvanishing assembly (`plugWin`, `EveryCharacter.lean` lines `8-11`): combines Green-function bounds (`Green`), the automorphic window (`VWin`), and closed character families at dyadic scale `la := 3 / 2` to deduce `ZeroFreeAll`, then extends to imprimitive characters at line `18` (`imprimitive`).
- Window exponent and auxiliary primes (`VWin`, `ExistsPageN.lean` line `49`): sets `Ct = 401` and $\varepsilon < 1/52$ over prime pairs $(q \equiv 3 \pmod 8,\; d \equiv 7 \pmod{16},\; q \mid d+1)$ (`WinPair`, lines `27-38`) to enforce `VVle E ⌊x^401⌋₊ √(exp(x^ε))`.

---

## 4. Five-Act Core Module Map (`Level 4`)

Short module names appear in the table for readability; full repository paths follow immediately below.

| Act | Core Mathematical Mechanism | Primary Module & Lines | Key Declarations |
| :---: | :--- | :--- | :--- |
| **Act 1** | Smoothed von Mangoldt residual & Landau zero-order identity | `StatementOC.lean:11-51`<br>`DefsOC.lean:12-47` | `Sz`, `Gz`, `OCAvg`, `LandauEq`, `OrderLogDeriv` |
| **Act 2** | Weighted node quadrature & discretization error $O(x\log m / m)$ | `StatementU.lean:9-46`<br>`ZetaNonvanishingGeneralWeights.lean:9-25` | `wavg`, `RiemannSumApprox`, `ZetaNonvanishingGeneralWeights` |
| **Act 3** | $m \ge x^{1-\theta-\varepsilon}$ Chebyshev nonvanishing & iterated lifts | `ZetaNonvanishingChebyshevWeights.lean:9-35`<br>`EveryCharacterOfLiteratureOfVWin.lean:810-814` | `chebNode`, `ChebyshevWeightApproximation`, `ZetaNonvanishingChebyshevWeights` |
| **Act 4** | Rallis seesaw, CM theta norm, projected Poincaré series & Cauchy-Schwarz decay | `FinalThetaLiftAMFKIndep.lean:1-15`<br>`ThetaNormCM.lean:30-40`<br>`ExistsMultTEqPoin.lean:15-109`<br>`GaussSumCharacterAverageBound.lean:21-98` | `final_gaussOp`, `PI.ThetaNormCM`, `exists_multT_eq_poin`, `hermitian_assembly_numeric_bound` |
| **Act 5** | Odd/even parity patching (`GSp_4 · U(3)`), Behrend sieve, cyclotomic tower | `WindowBoundOfLiteratureLevel.lean:25-34`<br>`BehrendSets/Statement.lean:48-81`<br>`RowSrc.lean:6` | `published_hypotheses_from_patching_alt`, `BehrendFree`, `WindowTwo`, `galoisLocalGlobalStrong_recParameter` |

- **Full Paths for Section 4**:
    - Acts 1 to 3 (`Formalism`): `src/Formalism/StatementOC.lean:11-51`, `src/Formalism/DefsOC.lean:12-47`, `src/Formalism/StatementU.lean:9-46`, `src/Formalism/ZetaNonvanishingGeneralWeights.lean:9-25`, `src/Formalism/ZetaNonvanishingChebyshevWeights.lean:9-35`
    - Acts 3 to 4 (theta, Poincaré & Gauss averages): `src/Formalism/ThetaLiftIndependence/FinalThetaLiftAMFKIndep.lean:1-15`, `src/Formalism/PeriodIntegrals/ThetaNormCM.lean:30-40`, `src/Development/AutomorphicArithmetic/ThetaCorrespondence/RealBands/ExistsMultTEqPoin.lean:15-109`,
      `src/Formalism/FlagUnipotentLattices/ConductorCharacterLeakBound.lean:7-58`, `src/Formalism/FlagUnipotentLattices/MinkowskiFactorialBounds/GaussSumCharacterAverageBound.lean:21-98`, `src/Formalism/CharacterColumnKernels/Statement.lean:102-153`,
      `src/Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/ExportStOfPrintsStatement.lean:11-12`, `src/Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/SiegelEisensteinSecondTermHypotheses.lean:69`, `src/Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/EveryCharacterOfLiteratureOfVWin.lean:810-814`
    - Act 5 (parity patching, Behrend & tower): `src/Development/AutomorphicArithmetic/AutomorphicVarieties/ModularityArgument/ThresholdArguments/DenseThresholdCases/WindowBoundOfLiteratureLevel.lean:25-34`,
      `src/Formalism/BehrendSets/Statement.lean:48-81`, `src/Development/AutomorphicArithmetic/Foundations/GaloisRepresentations/IntegralStructures/RowSrc.lean:6`, `src/Development/AutomorphicArithmetic/AutomorphicVarieties/SmallClassNumbers/CorGKOf.lean:10-29`

---

## 5. Exhaustive Audit of All 8 Metaprogramming Files

Across all `175,187` files, only the 8 files below invoke `import Lean` or `CoreM` elaborators; all 8 pass C++ kernel typechecking on both `x86_64` and `aarch64` (`PASS`):

1. Search-denylist registration (`src/BuildAid/D1.lean:1-4` through `src/BuildAid/D5.lean:1-4`, `5` files): registers `nameDenyListExt` entries only.
2. Metavariable assignment tactic (`src/Formalism/LocalToGlobal/IndefiniteReal/HeckeNonvanishing/Imports.lean:1-8`): defines `elab "kexactB "` (verified by the C++ kernel upon declaration addition).
3. Structure projection copier (`src/Formalism/LocalToGlobal/NumberFieldFamilies/OwnStruct.lean:1-66`): defines `elab "kcopy "` calling `Kernel.isDefEq`.
4. Compact-support twin cloner (`src/Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptCopy.lean:68-90`, invoked at `src/Formalism/HermitianCurvature/HermitianCurvatureProofs/CutMainCpt.lean:945`): calls only `addDecl (.defnDecl ...)` and `addDecl (.thmDecl ...)` to clone `21` declarations, with `0` `axiomDecl` calls.

---

## 6. `VWin` (`Ct = 401`) Parity Join, 7-Branch Vandiver Chain & `UnusedSlot` (`2 + 7 = 9`) Split

The assembly modules merging odd/even parity cohomology inside `vwin_of_row` (`157,604`-file cone) and the exact classification of all `UnusedSlot*` identifiers across the archive are pinned below (equation derivations in [05_Specialist_Referee_and_Equation_Audit.md](./05_Specialist_Referee_and_Equation_Audit.md) Chapters 4 and 5):

- **`VWin` Odd/Even Merge and Deep `PsiEven` 7-Branch Patching Chain**:
    - Top-level odd (`minusLen`) / even (`plusLen`) join (`vwin_of_counts` · `point` · `sumOut`): `src/Development/AutomorphicArithmetic/AutomorphicVarieties/HeightAndVanishing/JointWinOfCounts.lean:16-34`,
      `src/Development/AutomorphicArithmetic/AutomorphicVarieties/HeightAndVanishing/PointArith.lean:36-92`, `src/Development/AutomorphicArithmetic/AutomorphicVarieties/HeightAndVanishing/SumOut.lean:50-119`
    - Even parity `PsiEven` definition and 7 branches (`CaseI..CaseZ` · `CountI..CountZ`): `src/Development/AutomorphicArithmetic/AutomorphicVarieties/HeightAndVanishing/DirichletPrimeToLPartMulLPowerPart.lean:104-226`, `src/Development/AutomorphicArithmetic/AutomorphicVarieties/HeightAndVanishing/Counts.lean:40-74`
    - Ferrero-Washington (`FW.ferreroWashington`), `Ct = 401`, Behrend sieve (`Odd.thmBcFree_of`), Stickelberger odd congruence (`Odd a`): `src/Development/AutomorphicArithmetic/AutomorphicVarieties/ModularityArgument/ThresholdArguments/DenseThresholdCases/HVCore.lean:18-24`,
      `src/Development/AutomorphicArithmetic/AutomorphicVarieties/StickelbergerElements/StickelbergerCarrySpecAndWeightOneCoeffOfOdd.lean:5-7`
    - Kato $\mathrm{GL}_2$ + Type-I/II $U(3)$ rigidity (`rigIUE_alt` · `rigII_a_alt`) and cotangent length (`main_holds`): `src/Development/AutomorphicArithmetic/AutomorphicVarieties/ModularityArgument/ThresholdArguments/DenseThresholdCases/LinkedUnlE.lean:43-62`, `src/Development/AutomorphicArithmetic/AutomorphicVarieties/ModularityArgument/ThresholdArguments/DenseThresholdCases/ERigIU.lean:80-110`,
      `src/Development/AutomorphicArithmetic/AutomorphicVarieties/ModularityArgument/ThresholdArguments/DenseThresholdCases/RRRigII.lean:25-100`, `src/Development/AutomorphicArithmetic/AutomorphicVarieties/CommutativeAlgebra/GradedModulesLength/MainCotSpan.lean:32-70`
    - Symplectic $\mathrm{GSp}_4$ image density (`sp4In0_alt` · `SymplecticFourImageDense`) and `CountII · CountIII`: `src/Development/AutomorphicArithmetic/AutomorphicVarieties/ModularityArgument/ThresholdArguments/DenseThresholdCases/Sp4In0.lean:18-19`, `src/Development/AutomorphicArithmetic/AutomorphicVarieties/ModularityArgument/ThresholdArguments/DenseThresholdCases/IsAut4.lean:14-18`,
      `src/Development/AutomorphicArithmetic/AutomorphicVarieties/ModularityArgument/ThresholdArguments/DenseThresholdCases/AdjointLiftingOfCohomology.lean:27-40`
    - Weight-`0` $U(3)$ deformation finiteness (`ThmS6Core_s`), Hida ideal (`THidaU`), root patching (`published_hypotheses_from_patching_alt` · `descWeak`): `src/Development/AutomorphicArithmetic/AutomorphicVarieties/ModularityArgument/ThresholdArguments/DenseThresholdCases/ThmS6CoreS.lean:27-37`, `src/Development/AutomorphicArithmetic/AutomorphicVarieties/ModularityArgument/ThresholdArguments/DenseThresholdCases/THidaU.lean:38-48`,
      `src/Development/AutomorphicArithmetic/AutomorphicVarieties/ModularityArgument/ThresholdArguments/DenseThresholdCases/PublishedHypothesesFromPatching.lean:98-104`, `src/Development/AutomorphicArithmetic/AutomorphicVarieties/ModularityArgument/TraceFormula/SplitRigidity/HasOfSplit.lean:29-30`,
      `src/Development/AutomorphicArithmetic/AutomorphicVarieties/ModularityArgument/ThresholdArguments/DenseThresholdCases/WindowBoundOfLiteratureLevel.lean:25-34`
- **Exhaustive `UnusedSlot` Classification (`2 + 7 = 9` Identifiers, `371` Unique Files, `375` Slot-File Pairs, `2,226` Occurrences)**:
    - **2 Dead `Prop := True` Hypothesis Slots (`14` slot-file pairs)**: Only `UnusedSlot55` (`4` files, `src/Development/AutomorphicArithmetic/Foundations/GaloisRepresentations/TypeConditions/TrivialLocalCondition.lean:89`) and `UnusedSlot72` (`10` files,
      `src/Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/LocalTypeDictionary/DiscreteSpectrumResidualClassification.lean:7`) are inactive dummy hypotheses sealed as `True` (`trivial`).
    - **7 Live Mathematical `namespace` Identifiers (`361` slot-file pairs)**: `UnusedSlot33` (`71` files), `UnusedSlot34` (`37` files), `UnusedSlot35` (`10` files), `UnusedSlot36` (`2` files, `src/Development/AbelianVarietyTheory/BlockTheory/HeightDefect/OrderValuation.lean:7`), `UnusedSlot38` (`5` files, `src/Formalism/SharpRestriction/ValuationFrobeniusEpsilon/GradedCompletionLemmas.lean:8`),
      `UnusedSlot39` (`43` files), and `UnusedSlot80` (`193` files, `src/Formalism/SharpRestriction/LevelLetterCocycles/ExtensionInvariantClause.lean:7`) are **active `namespace` declarations** left over from automated batch renaming, containing live theorems on Wach modules, graded power-series completions, and height-defect valuations.
