# Volume 3. Deep Decompilation of Lower Tactics and Core Hubs Across the Four Pillars of the New Core `Formalism` (`2,577,937` Lines)

This third volume decompiles into human-readable mathematical equations and theorem chains the lower core hubs and `*Proofs/` tactic bodies of the four pillars of `Formalism` (`LocalToGlobal`, `SharpRestriction`, `HermitianCurvature`, and `PeriodIntegrals`, totaling `14,866` files, `2,577,937` lines, and `196,578` declarations), which form the central axis of the new mathematical engine in the Riemann Hypothesis formal proof archive by Levent Alpöge and Claude, by opening and inspecting the original Lean source files directly.

Preliminary forensic work verified only the `38` top-level `Statement*` specification files of `Formalism` without inspecting the internal implementation of the `2,577,937` lines across the four pillars beneath them. Taking the reference in-degree (`in_degree`) and shortest import distance (`dist`) maps extracted in the Part B full AST atlas (`B01` to `B04`) as a compass, this volume reads line by line the most heavily imported algebraic and analytic hub files of each pillar and reconstructs as closed-form mathematical equations the automorphic multiplicity stacking, iterated Parseval Gram matrix upper bounds, Archimedean regularized truncation twin generator, and triple cancellation formulas (Rallis seesaw, Chowla-Selberg, and Siegel mass) operating inside them.

---

## Chapter 1. Macro Coupling Architecture and Tactic Statistics of the Four `Formalism` Pillars (`14,866` Files · `2,577,937` Lines)

### 1.1 Quantitative Declaration Distribution Across the Four Pillars and Shortest-Distance Spectrum from `Main.lean`

Within the entire `Formalism` namespace (`18,254` files, `3,200,748` lines, and `240,099` declarations), the top four subtrees account for `81.44%` of all files (`14,866`), `80.54%` of all code lines (`2,577,937`), and `81.87%` of all declarations (`196,578`). Exhaustive aggregation by the AST parser (`atlas/data/formalism_18254.jsonl`) yields the per-pillar distribution of files, bytes, declaration kinds, and shortest import distance (`dist`) intervals from `Main.lean` shown in the table below.

| Category (`Formalism` Subdomain) | Unique Files | Lines of Code | Raw Size (`Bytes`) | `theorem` | `lemma` | Theorem Total (`thm+lem`) | `def` | `abbrev` | `structure` | `instance` & Other | Total Decls | `Main` Dist (`dist`) |
| :--- | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| **Pillar 1: `LocalToGlobal`** | `5,501` | `955,843` | `49,605,549` | `48,542` | `1,298` | **`49,840`** | `20,543` | `1,293` | `1,151` | `446` | **`73,273`** | `6` ~ `33` |
| **Pillar 2: `SharpRestriction`** | `3,093` | `709,436` | `37,418,210` | `33,062` | `760` | **`33,822`** | `19,065` | `778` | `650` | `333` | **`54,648`** | `6` ~ `43` |
| **Pillar 3: `HermitianCurvature`** | `1,922` | `460,802` | `24,655,327` | `24,870` | `3,205` | **`28,075`** | `7,475` | `158` | `131` | `119` | **`35,958`** | `7` ~ `25` |
| **Pillar 4: `PeriodIntegrals`** | `4,350` | `451,856` | `21,879,248` | `20,675` | `2,859` | **`23,534`** | `8,368` | `382` | `86` | `329` | **`32,699`** | `6` ~ `31` |
| **Subtotal: Four `Formalism` Pillars** | **`14,866`** | **`2,577,937`** | **`133,558,334`** | **`127,149`** | **`8,122`** | **`135,271`** | **`55,451`** | **`2,611`** | **`2,018`** | **`1,227`** | **`196,578`** | **`6` ~ `43`** |
| **Other `112` Specialized Subtheories (`A04`)** | `3,388` | `622,811` | `32,299,515` | `21,070` | `5,777` | `26,847` | `15,632` | `484` | `305` | `253` | `43,521` | `6` ~ `37` |
| **Total: Entire `Formalism`** | **`18,254`** | **`3,200,748`** | **`165,857,849`** | **`148,219`** | **`13,899`** | **`162,118`** | **`71,083`** | **`3,095`** | **`2,323`** | **`1,480`** | **`240,099`** | **`6` ~ `43`** |

Three architectural characteristics stand out from this quantitative distribution.

1. **Concentration of `structure` density and algebraic interfaces**: Of the `2,018` `structure` declarations across the four pillars, `1,801` (`89.25%`) reside in `LocalToGlobal` (`1,151`) and `SharpRestriction` (`650`). These two pillars serve as the assembly framework for local-to-global compatibility, passing records bundling dozens of arithmetic and automorphic hypothesis fields (`LinksStage.Inputs`, `AllTied`, `FamP`, `LocalSituation.Sit`, `AsmIface.Shd`) as parameters.
2. **Sharp contrast in average lines per file**: `HermitianCurvature` averages `239.75` lines per file (`460,802 / 1,922`) and contains multi-thousand-line continuous analysis and Lie group integration proofs in single files such as `Formalism/HermitianCurvature/HermitianCurvatureProofs/UnipotentCoordinatesMeasurePreserving.lean:1-6929`. Conversely, `PeriodIntegrals` is partitioned most finely at `103.87` lines per file (`451,856 / 4,350`), splitting local volume factor evaluations of the unitary group mass formula into `4,350` atomic modules to eliminate parallel compilation bottlenecks.
3. **Front-line placement at shortest distance `dist = 6` to `7` from `Main.lean`**: All four pillars interlock directly with the outer `Development.*` and `CompanionTheory.*` welding layers at `dist = 6` or `dist = 7`. Rather than acting as deep foundational utility libraries, the four pillars operate directly one step below the top-level Riemann Hypothesis contradiction argument, delivering the main inequalities of the proof engine.

---

### 1.2 Anatomy of Tactic Engineering: Search-Free Deterministic Rewriting and Custom Elaborators

The invocation frequencies (counted per declaration) of the top 14 tactics extracted from the proof bodies of the `196,578` declarations inside the four pillars are tabulated below.

| Tactic (`Tactic`) | `LocalToGlobal` (`73,273` decls) | `SharpRestriction` (`54,648` decls) | `HermitianCurvature` (`35,958` decls) | `PeriodIntegrals` (`32,699` decls) | Four-Pillar Total (`196,578` decls) | Mathematical Role Within the Pillars |
| :--- | ---: | ---: | ---: | ---: | ---: | :--- |
| **`rw` / `erw`** | `31,670` | `20,745` | `15,226` | `14,727` | **`82,368`** | Explicit equational/equivalence substitution, unfolding definitions, and reassociation |
| **`exact`** | `24,732` | `17,814` | `11,461` | `11,505` | **`65,512`** | Direct proof-term closure without backtracking |
| **`simp` / `simpa`** | `18,189` | `11,718` | `12,303` | `10,748` | **`52,958`** | Normalization via restricted `[simp]` lemma sets (`simp only [...]`) |
| **`refine`** | `12,914` | `9,685` | `6,879` | `6,462` | **`35,940`** | Upfront skeleton fixation for multi-conjunction and existential goals |
| **`obtain` / `rcases`** | `12,078` | `10,126` | `5,485` | `5,478` | **`33,167`** | Destructuring fields of large package records (`Inputs`, `FamP`, `Sit`) |
| **`ext` / `funext`** | `9,684` | `5,160` | `4,805` | `5,039` | **`24,688`** | Pointwise extensionality reduction for adelic matrices, operators, and measure functions |
| **`apply`** | `4,860` | `3,653` | `2,198` | `2,597` | **`13,308`** | Backward application of monotonicity, continuity, and measurability implication rules |
| **`ring` / `ring_nf`** | `4,609` | `3,607` | `2,694` | `2,303` | **`13,213`** | Commutative-ring polynomial, exponent-combination, and determinant algebraic identities |
| **`omega`** | `3,202` | `4,675` | `3,009` | `1,852` | **`12,738`** | Presburger arithmetic on lattice degrees and unitary ranks (`Fin (2*r+k+1)`) |
| **`congr`** | `2,943` | `2,021` | `2,249` | `1,274` | **`8,487`** | Congruence reduction of finite sums (`∑`), finite products (`∏`), and integral (`∫`) integrands |
| **`linarith` / `nlinarith`** | `1,402` | `3,319` | `1,652` | `778` | **`7,151`** | Real exponent windows (`eps < 1/52`) and Schur / Cauchy-Schwarz inequalities |
| **`induction`** | `2,137` | `2,248` | `1,217` | `1,229` | **`6,831`** | Induction on $m$-step theta chains, Parseval depth $r$, and Lie derivative words |
| **`calc`** | `1,659` | `1,660` | `1,539` | `1,124` | **`5,982`** | Multi-step inequalities and matrix conjugate-transpose (`gᴴ * J * g`) derivations |
| **`aesop`** | `3` | `2` | `0` | `5` | **`10`** | Near-total exclusion (`0.0051%`, guaranteeing deterministic compilation time) |

Differences in tactic ratios across pillars reflect the mathematical objects handled by each pillar.

- **Concentration of `omega` (`4,675` calls) and `linarith`/`nlinarith` (`3,319` calls) in `SharpRestriction`**: Because Pillar 2 controls the 5-adic level depth $j_0 = \lceil \log_5(n N(m)/m)\rceil_+$, power truncation exponents of Galois deformation rings, and polyhedral lattice-point count upper bounds, it exhibits the highest frequency among the four pillars of the natural-number division/inequality decision procedure `omega` and the real linear arithmetic solver `linarith`.
- **Concentration of `simp`/`simpa` (`34.21%`) and `calc` (`1,539` calls) in `HermitianCurvature`**: Because Pillar 3 expands commutators of Lie differential operator words (`Dw`) and Cauchy-Schwarz inequalities for sesquilinear forms on the pseudo-unitary group $U(p,q)$, it relies heavily on `calc` chains and normalizations of the form `simp only [Matrix.mul_assoc]`.
- **Custom tactic `kexactB` for bypassing elaborator unification delays**: Inside `LocalToGlobal`, where large algebraic records are deeply nested, a dedicated tactic macro is defined in `Formalism/LocalToGlobal/IndefiniteReal/HeckeNonvanishing/Imports.lean:1-8` (`in_degree = 45`, `dist = 7`) to avoid metavariable unification slowdowns in the default Lean 4 `elaborator`.

```lean
-- Source: Formalism/LocalToGlobal/IndefiniteReal/HeckeNonvanishing/Imports.lean:1-8
import Mathlib
open Lean Elab Tactic Meta in
elab "kexactB " t:term : tactic => withMainContext do
  let goal ← getMainGoal
  let e ← elabTerm t none
  goal.assign e
```

`kexactB` elaborates the term `t` independently first with `expectedType` set to `none`, and then assigns it directly to the main goal metavariable via `goal.assign e`. By bypassing expensive higher-order unification between the expected type and the witness term and letting the kernel type checker verify final type equality directly, it keeps compilation times linear across automorphic package gluing files containing hundreds of fields.

---

### 1.3 Cross-Pillar Import Asymmetry Matrix and Unidirectional Analytic Engine Architecture

Exhaustive enumeration of local `import` edges among modules inside the four pillars, the remaining `Formalism` subtheories (`Other`), and the upper welding layers outside `Formalism` (`OutsideFormalism`) reveals a strict directed acyclic hierarchy (DAG). In the table below, rows denote the **importing consumer** and columns denote the **imported supplier**.

| Consumer \ Supplier (`import` direction $\to$) | `LocalToGlobal` | `SharpRestriction` | `PeriodIntegrals` | `HermitianCurvature` | `Formalism` Other (`112` subtheories) |
| :--- | ---: | ---: | ---: | ---: | :--- |
| **`LocalToGlobal` internal files** | (internal coupling) | `743` | `667` | `147` | `1,007` |
| **`SharpRestriction` internal files** | `202` | (internal coupling) | `184` | `104` | `948` |
| **`PeriodIntegrals` internal files** | `266` | `136` | (internal coupling) | `127` | `367` |
| **`HermitianCurvature` internal files** | **`0`** | `15` | `117` | (internal coupling) | `181` |
| **`Formalism` Other (`112` subtheories) files** | `164` | `219` | `91` | `48` | (internal coupling) |
| **Upper layers outside `Formalism` (`Pure_Vwin` & spine)** | `89` | `114` | `42` | `19` | `312` |

Two architectural invariants emerge from this cross-import matrix.

1. **Zero imports (`0`) from `HermitianCurvature` to `LocalToGlobal`**: Pillar 3 `HermitianCurvature` (`1,922` files) imports `LocalToGlobal` zero times. Archimedean infinite-place curvature positivity and differential identities for quantum minors (`QuantumDeterminants`) are completed first at the base as a pure real-analytic and Lie-group engine with zero dependence on global theta lift chain existence or algebraic lattice patching, and then supply sign-definiteness theorems unidirectionally to `LocalToGlobal` (`147` edges), `PeriodIntegrals` (`127` edges), and `SharpRestriction` (`104` edges).
2. **Reciprocal division of labor between `LocalToGlobal` and `SharpRestriction`**: `LocalToGlobal` imports `SharpRestriction` `743` times to consume local Parseval and Schur upper bounds (`ParConsts`, `SchurIrreducible`, `AsmIface`), while the top assembly layer of `SharpRestriction` (`GlobalSchurBounds`, `RamificationFrobenius`) in turn imports automorphic multiplicity constructions from `LocalToGlobal` (`202` edges) and stabilizer volume formulas from `PeriodIntegrals` (`184` edges) to close the final explicit-formula error bound.

Tracking the top-level export gateway files (`dist = 6` to `8`) exported by each pillar across its boundary (to other pillars in `Formalism` and to the upper `Development.*` welding layer) identifies the external interfaces of the four pillars as shown below.

| Pillar | External Export Gateway Module (path relative to `src/`) | Lines | `dist` | External Refs | Key Exported Theorems and Mathematical Objects |
| :--- | :--- | ---: | ---: | ---: | :--- |
| **`LocalToGlobal`** | `Formalism/LocalToGlobal/IndefiniteReal/FinitePlaces/VacExA.lean` | `459` | `6` | `3` | Existence of finite-place parahoric vacuum test vectors (`VacExA`) |
| **`LocalToGlobal`** | `Formalism/LocalToGlobal/IndefiniteReal/LevelTypeEquivalence/UnimodInst.lean` | `292` | `6` | `27` | Unimodular Haar measure instance under level-type equivalence |
| **`LocalToGlobal`** | `Formalism/LocalToGlobal/IndefiniteReal/SmExpSmulContDiff.lean` | `132` | `6` | `6` | Smooth differentiability (`ContDiff`) of Lie group exponential scalar action |
| **`SharpRestriction`** | `Formalism/SharpRestriction/LevelLetterCocycles/SphericalInertData.lean` | `181` | `6` | `95` | Compatibility of Hecke-Galois data at inert spherical places |
| **`SharpRestriction`** | `Formalism/SharpRestriction/LevelLetterCocycles/QuotientImageDivisibility/RkMultVOfNotJump.lean` | `153` | `6` | `7` | Quotient image divisibility rank formula at non-jump places |
| **`SharpRestriction`** | `Formalism/SharpRestriction/CuspSpanNormBounds/GlobAut.lean` | `261` | `7` | `25` | Bridge between global automorphic form spaces and local projected Poincaré generators |
| **`HermitianCurvature`** | `Formalism/HermitianCurvature/WeylElementCommutesLevelOne.lean` | `496` | `7` | `4` | Level-1 Weyl element commutativity and regularized pairing output (`LemmaBDouble`) |
| **`HermitianCurvature`** | `Formalism/HermitianCurvature/FiniteOrderIntersectionInSmooth.lean` | `218` | `8` | `16` | Smooth manifold embedding theorem for intersections of finite-order subgroups |
| **`HermitianCurvature`** | `Formalism/HermitianCurvature/StatementQ.lean` | `1,119` | `10` | `36` | Quantum minor row expansion and zeta commutator adjoint specification (`ZetaComm`) |
| **`PeriodIntegrals`** | `Formalism/PeriodIntegrals/UnitaryGroupMassFormula/ArchimedeanOrbitMeasures/PiDens.lean` | `162` | `6` | `4` | Factorization of Radon-Nikodym chart densities on product spaces (`pi_chart_dens`) |
| **`PeriodIntegrals`** | `Formalism/PeriodIntegrals/OrbitalBoundsConclusion/WittExtensionTheorem.lean` | `144` | `8` | `8` | Witt extension theorem for local Hermitian isometries (`WittExtension`) |
| **`PeriodIntegrals`** | `Formalism/PeriodIntegrals/UnitaryGroupMassFormula/AdelicClassFiniteness/DictAll.lean` | `98` | `10` | `8` | Adelic Hermitian lattice class finiteness (Borel finiteness) dictionary (`DictAll`) |

---

### 1.4 Coupling with the Five Top-Level Specifications (`Statement` · `StatementOC` · `StatementU` · `StatementCM` · `StatementFL`) and Supply Path to `Main.lean`

The five specification files at the top of `Formalism` (`Formalism/Statement.lean`, `Formalism/StatementOC.lean`, `Formalism/StatementU.lean`, `Formalism/StatementCM.lean`, `Formalism/StatementFL.lean`) are **specification leaves** (`out_degree = 0` or `1`) that contain no proof bodies (`theorem`) and declare only analytic target propositions (`def ... : Prop`). Syntactic Lean `import` arrows therefore point from proof files in the four pillars and subtheories into these five `Statement*` files, while logical theorem-supply arrows ascend as the four pillars discharge the hypotheses of those `Prop` targets and propagate upward along `dist = 8 \to 7 \to 6 \to 5` to `Main.lean`.

The table below gives the declaration ledger of all five specification files together with representative downstream proof modules that directly import them and discharge their hypotheses.

| Top-Level Specification Leaf (path relative to `src/`) | Lines | `in_deg` | `dist` | Key Declarations (`line_start`-`line_end`) | Representative Modules Importing and Discharging Hypotheses (path relative to `src/`) |
| :--- | ---: | ---: | ---: | :--- | :--- |
| `Formalism/Statement.lean` | `50` | `2` | `9` | `LamF`(`11-13`), `G`(`21-23`), `LandauStepEps`(`39-45`), `RHofG`(`46-49`) | `Formalism/StatementOC.lean`, `Formalism/ZetaRealNonvanish.lean` |
| `Formalism/StatementOC.lean` | `73` | `6` | `8` | `Gz`(`13-14`), `Gchi`(`20-22`), `OCAvg`(`39-51`), `RiemannHypothesisOfLowerBounds`(`65-72`) | `Formalism/SharpRestriction/RamificationFrobenius/TotientGaloisClasses/ExplicitFormulaErrorOfHostConditions.lean` |
| `Formalism/StatementU.lean` | `47` | `5` | `10` | `Gzbar`(`9-10`), `wavg`(`11-13`), `ZetaLandauBarEps`(`29-33`), `RiemannSumApprox`(`42-46`) | `Formalism/ZetaNonvanishing/ZetaLandau.lean`, `Formalism/ZetaNonvanishing/GzLipschitz.lean` |
| `Formalism/StatementCM.lean` | `45` | `3` | `13` | `IsCMType`(`9-10`), `HalfTypes`(`22-26`), `ForcedSumCM`(`35-40`), `ForcedSumIdentity`(`41-44`) | `Formalism/CMTypeGalois/StatementGroup.lean`, `Formalism/ProductFormula/StatementOCCM.lean` |
| `Formalism/StatementFL.lean` | `44` | `1` | `15` | `famComb`(`17-20`), `FamilyLandauC`(`21-31`), `FamilyLandauCW3`(`32-43`) | `Formalism/LFunctionBounds/Statement.lean` |

The exact source formulas of each of the five specification files and the corresponding theorems supplied by the four pillars are detailed below.

#### (1) `Formalism/Statement.lean:11-50` (`50` lines, `dist = 9`) - Chebyshev-Weighted von Mangoldt Remainder $G(x)$ and Landau Contradiction Specification
The source lines `Formalism/Statement.lean:11-23` define the truncated sum $S(x)$ of the von Mangoldt function $\Lambda(n)$ and its main-term-corrected remainder $G(x)$ as follows:

$$
S(x) := \sum_{n=1}^{\lfloor x \rfloor} \Lambda(n) \max\left(0, \frac{x}{n} - 1\right), \qquad \gamma_F(x) := x\left(\log x - 1 - \gamma\right) + 1, \qquad G(x) := S(x) - \gamma_F(x)
$$

Next, `Formalism/Statement.lean:32-49` declares the Landau positivity contradiction steps `LandauStep` and `LandauStepEps` together with the final target proposition `RHofG` (`Formalism/Statement.lean:46-49`). `RHofG` is the one-sided upper bound contradiction principle stating that if $G(x) \le C x^{\theta + \varepsilon}$ holds for all sufficiently large $x \ge x_0$ for every $\theta \in [1/2, 1)$ and $\varepsilon > 0$, then $\zeta(s) \ne 0$ on the half-plane $\Re(s) > \theta$. Rather than requiring a two-sided complex modulus bound $|G(x)|$, **a real one-sided upper bound $G(x) \le C x^{\theta+\varepsilon}$ suffices**: this asymmetry is the starting point across all four pillars for deducing zero-freeness from the positivity of Hermitian Gram matrices ($0 \le \langle \Theta f, \Theta f \rangle$).

#### (2) `Formalism/StatementOC.lean:11-73` (`73` lines, `dist = 8`) - Dirichlet Character Combined Remainder $G_\chi(x)$ and Weighted Average `OCAvg`
`Formalism/StatementOC.lean:11-22` imports `Formalism.Statement` and declares the twisted sum $S_\chi(x)$ and main-term-corrected remainder $G_\chi(x)$ for a Dirichlet character $\chi$ modulo $q$:

$$
S_\chi(x) := \sum_{n=1}^{\lfloor x \rfloor} \Lambda(n)\chi(n)\max\left(0, \frac{x}{n} - 1\right), \qquad G_\chi(x) := S_\chi(x) + \frac{L'(1, \chi)}{L(1, \chi)}\, x
$$

It then defines `OCStep` (`Formalism/StatementOC.lean:23-30`), the Chebyshev-weighted average version `OCAvgUpper` (`Formalism/StatementOC.lean:52-64`), and `RiemannHypothesisOfLowerBounds` (`Formalism/StatementOC.lean:65-72`). Inside Pillar 2 `SharpRestriction`, the key output hub `Formalism/SharpRestriction/RamificationFrobenius/TotientGaloisClasses/ExplicitFormulaErrorOfHostConditions.lean:2` (`168` lines, `dist = 7`, `in_degree = 10`) imports `Formalism.StatementOC` directly and constructs the combined linear form $\Lambda.\mathrm{Gm}(y)$ (`Formalism/SharpRestriction/RamificationFrobenius/TotientGaloisClasses/ExplicitFormulaErrorOfHostConditions.lean:38`) over a finite primitive-character level $\Lambda : \mathrm{Level}$:

$$
\Lambda.\mathrm{Gm}(y) := G_z(y) + \sum_{\psi \in \Lambda.\mathrm{Nt}} \Lambda.\mathrm{wt}(\psi)\,\Re\left(g_\chi(\psi.\chi, y)\right), \qquad \Lambda.\mathrm{wt}(\psi) := \begin{cases} 1 & (\Lambda.\mathrm{psK} = \mathrm{some}\,\psi) \\ (3\,\Lambda.o + 1)^{-1} & (\text{otherwise}) \end{cases}
$$

Here the weight $(3\,\Lambda.o + 1)^{-1}$ (`Formalism/SharpRestriction/RamificationFrobenius/TotientGaloisClasses/ExplicitFormulaErrorOfHostConditions.lean:36`) is the decisive coefficient enforcing positivity of coset indicator functions over a character subgroup of order $\Lambda.o = |\Xi|$, and theorem `EAtH.explicit_formula_error_of_host_conditions` (`Formalism/SharpRestriction/RamificationFrobenius/TotientGaloisClasses/ExplicitFormulaErrorOfHostConditions.lean:155-165`) in the same file derives the explicit-formula error package `EAtH` from `HostConditions`.

#### (3) `Formalism/StatementU.lean:9-47` (`47` lines, `dist = 10`) - Chebyshev Window Average `wavg` and Mellin-Landau Analytic Continuation
`Formalism/StatementU.lean:9-13` defines the normalized remainder $\bar{G}_z(x) := G_z(x) + x - 1$ and the discrete window average `wavg m x f` of length $m$:

$$
\mathrm{wavg}(m, x, f) := \frac{1}{m}\sum_{j=1}^{m} f\left(\left(1 + \frac{j}{2m}\right) x\right)
$$

The proposition `ZetaLandauBarEps` (`Formalism/StatementU.lean:29-33`) specifies that $\zeta(s) \ne 0$ for $\Re(s) > \theta$ follows from the window-average upper bound $\mathrm{wavg}(m, x, \bar{G}_z) \le C x^{\theta + \varepsilon}$ with $m \ge x^{1 - \theta - \varepsilon}$. This specification is realized in `Formalism/ZetaNonvanishing/ZetaLandau.lean:18-99` (`300` lines, `dist = 11`) via the Mellin transform identity `mellin_HZ` (`Formalism/ZetaNonvanishing/ZetaLandau.lean:75-91`). Specifically, for $H_Z(\varepsilon, C, \theta; x) := \varepsilon G_z(x) + C x^\theta \ge 0$, its Mellin integral $I_Z(s) = \int_1^\infty H_Z(x) x^{-s-1}\,dx$ is proved on $\Re(s) > 1$ to equal

$$
\Phi_Z(\varepsilon, C, \theta; s) = \frac{\varepsilon \, n_Z(s)}{s(s - 1)} + \frac{C}{s - \theta}, \qquad n_Z(s) := -\frac{\zeta_1'(s)}{\zeta_1(s)} - 1 + (1 + \gamma)s
$$

(`PhiZ_eq`, `Formalism/ZetaNonvanishing/ZetaLandau.lean:93-98`), blocking both real and complex zeros via Landau's real-axis singularity theorem for non-negative integrands.

#### (4) `Formalism/StatementCM.lean:9-45` (`45` lines, `dist = 13`) and `Formalism/StatementFL.lean:11-44` (`44` lines, `dist = 15`) - CM Half-Type Partition and Odd-Character Killing Formula
`Formalism/StatementCM.lean:9-44` defines CM types (`IsCMType`, `Formalism/StatementCM.lean:9-10`) selecting exactly one element from each pair $\{a, -a\}$ over the cyclic group $\mathbb{Z}/2n\mathbb{Z}$ of order $2n$, together with the half-family `HalfTypes` (`Formalism/StatementCM.lean:22-26`), and specifies the congruence-class-weighted von Mangoldt sum `ForcedSumCM` (`Formalism/StatementCM.lean:35-40`) forced by automorphic theta lifts. Meanwhile, `Formalism/StatementFL.lean:11-43` defines the character-family linear combination `famComb` (`Formalism/StatementFL.lean:17-20`) with complex coefficients $c_\chi$:

$$
\mathrm{famComb}(\mathrm{chars}, c, y) := G_z(y) + \Re\left(\sum_{\chi \in \mathrm{chars}} c(\chi)\, G_{\chi,\mathbb{C}}(\chi, y)\right)
$$

which is implemented in `Formalism/LFunctionBounds/Statement.lean:11-126` (`127` lines, `dist = 14`) via a probability distribution $\nu$ over triples $S = (s_1, s_2, s_3) \in \mathrm{triples}(l)$ summing to a prime modulus $l$, the sawtooth period identity (`PeriodIdentity`, `Formalism/LFunctionBounds/Statement.lean:44-53`), and `KillingLemma` (`Formalism/LFunctionBounds/Statement.lean:55-59`: $c_W(l, \nu, \chi) = 0$ across a bad odd-character set $BB$ of size $|BB| \le l^{1-\varepsilon}$), which annihilates characters carrying exceptional zeros.

#### (5) Final Welding Chain from the Four Pillars Through `CoreGm.lean` to `Main.lean`
The theorems produced by the four pillars are consolidated into a single core proposition `ChainCore` by theorem `ChainTied.core_of` in Pillar 2's global tying file `Formalism/SharpRestriction/GlobalSchurBounds/TieGlobal.lean:97-124` (`127` lines, `dist = 8`), and feed directly into the main theorem `UpperTheory.Comparison₂.core_gm` (`Development/AutomorphicArithmetic/PrimitiveCosets/CoreGm.lean:12-15`) in the upper welding file `Development/AutomorphicArithmetic/PrimitiveCosets/CoreGm.lean:12-74` (`74` lines) outside `Formalism`:

$$
\mathrm{EAtH}(\Lambda, H, TT, x, \varepsilon, C) \;\wedge\; \mathrm{CoreAtH}(H, TT, e_D, e_L, K, c_{HH}, e_K, \varepsilon, x) \implies \Lambda.\mathrm{Gm}(x) \le x^{\frac{1}{2} + (e_D + e_L + 7)\varepsilon}
$$

The `36` existential witnesses unpacked via `obtain` in the proof body at `Development/AutomorphicArithmetic/PrimitiveCosets/CoreGm.lean:30-31` (`U0, i0, tr, W, i4, i5, Top, i6, m, f, Dd, Cc, Xpp, ell, N, T2, a, w, eT, eP, η, X', θ` together with `13` subsidiary inequalities) are the exact final outputs of the four pillars reconstructed in Chapters 2 through 5 below. Sending $\varepsilon \in (0, 1/52)$ (`Formalism/SharpRestriction/ParConsts.lean:99-100`) to $0$ drives the exponent $\frac{1}{2} + (e_D + e_L + 7)\varepsilon$ to the critical line $\frac{1}{2}$, and `ChebyshevGrowthImpliesZeroFree` at `Formalism/SharpRestriction/RamificationFrobenius/TotientGaloisClasses/ExplicitFormulaErrorOfHostConditions.lean:40-41` establishes the zero-freeness of the Riemann zeta function and all primitive Dirichlet $L$-functions on the half-plane $\Re(s) > 1/2$.

---

## Chapter 2. Deep Anatomy of Pillar 1 `Formalism.LocalToGlobal` (`5,501` Files · `955,843` Lines · `49,840` Theorems)

### 2.1 Hierarchical Decomposition and Functional Division of the `35` Subpackages

Pillar 1 `Formalism.LocalToGlobal` is the largest single subtree in the new proof core of the entire archive (`5,501` files, `955,843` lines, `49,840` theorems and lemmas, and `23,433` definitions, structures, and other declarations). Its mission is to construct iterated theta lifts of length $m \approx \sqrt{x}$ along chains of positive definite and indefinite Hermitian spaces, and to establish absence of common zeros together with shortened evaluations (`ShortValAt`) over projective lattice families, thereby realizing derivative-free Stepanov algebraic multiplicity over $\mathbb{Z}$. The quantitative breakdown and mathematical division of labor across its `35` subpackages are shown below.

| Rank | Subpackage (`Formalism/LocalToGlobal/*`) | Files | Lines of Code | Theorems (`thm+lem`) | Defs/Structs/Other | Dedicated Mathematical Engine and Core Role |
| ---: | :--- | ---: | ---: | ---: | ---: | :--- |
| `1` | **`SiegelLatticeTheory`** | `2,085` | `339,004` | `16,907` | `5,865` | Closed local orbits (`TermLoc`), non-generic cokernel amplification factors (`NGData`), Siegel lattice theta kernels |
| `2` | **`Columns`** | `376` | `95,905` | `5,313` | `2,524` | Adelic matrix column-space decompositions, parabolic subgroup invariance conditions, and basis transitions |
| `3` | **`IndefiniteReal`** | `435` | `78,821` | `4,014` | `3,006` | $m$-step primitive theta links (`LinksStage`), test vectors (`DatumVec`), composite Gram eigenvalues (`PThmB`) |
| `4` | **`TorsionIntegrality`** | `489` | `70,444` | `4,581` | `1,477` | Torsion cokernel order bounds and local-to-global integrality ($p$-adic denominator clearing) |
| `5` | **`GlobalTheory`** | `389` | `69,295` | `3,562` | `1,308` | $\mathrm{GL}_5$ 6-fold cover coupling (`GL5/Statement.lean`) and assembly of primes-in-arithmetic-progressions consequences |
| `6` | **`KernelLattices`** | `162` | `48,309` | `2,778` | `1,421` | Discriminant and slope preservation theorems for idempotent projection kernel lattices (`ker(1-e)`) |
| `7` | **`ProjectiveLattices`** | `325` | `43,028` | `1,865` | `1,606` | Abelian variety projective sections (`FreeBridge`), shortened normalized evaluation (`ThShort`), universal tests (`AllTest`) |
| `8` | **`CharacterGerms`** | `238` | `40,069` | `2,068` | `767` | Local character germ expansions and ramification conductor exponent compatibility |
| `9` | **`Divisibility`** | `96` | `31,447` | `1,687` | `1,091` | Arakelov height divisibility and transfer of Hecke eigenvalue integrality |
| `10` | **`GroupLattices`** | `229` | `31,001` | `1,740` | `812` | Correspondence between adelic compact open subgroup stabilizers and integral lattice equivalence classes |
| `11` | **`InertKernelTheory`** | `149` | `29,697` | `1,555` | `548` | Dimension formulas for parahoric kernel spaces at inert prime places |
| `12` | **`PairingIndexBounds`** | `127` | `17,269` | `945` | `346` | Placewise product upper bounds for Hermitian dual-lattice indices $[L^\vee : L]$ |
| `13` | **`IndefiniteForms`** | `31` | `10,423` | `437` | `567` | Indefinite form trees and logarithmic-mean share inequalities (`HSClaim`) |
| `14` | **`NumberFieldFamilies` & `22` others** | `360` | `50,591` | `2,388` | `2,095` | Number-field family record checking (`OwnStruct`), Bessel-Hermitian theta master bundle (`AllTied`), genus gluing (`GenusGluing`) |
| **Total** | **`LocalToGlobal` Complete (`35` subpackages)** | **`5,501`** | **`955,843`** | **`49,840`** | **`23,433`** | **Total declarations: `73,273` (`Main.lean` shortest distance `dist = 6` ~ `33`)** |

Among the specialized subpackages, the core specification `Formalism/LocalToGlobal/IndefiniteForms/IndefiniteTree/RealCubicMeans/LogMeanShares/LogMeanStatements/HSClaim.lean:7-23` (`24` lines, `in_degree = 208`, `dist = 10`) in `IndefiniteForms` defines the binomial coefficient $R(T, D) := \binom{T-1}{D}$ and share factor $Z(T, D, \delta, d) := 1 - R(T, D)\delta / d$, controlling density loss across indefinite-tree branchings via a closed algebraic expression. Likewise, `Formalism/LocalToGlobal/NumberFieldFamilies/OwnStruct.lean:7-65` (`66` lines, `dist = 9`) in `NumberFieldFamilies` uses the Lean 4 meta functions `kdefeq` and `ownStruct` to verify definitional equality of constructors and projections for structures generated over number-field families by kernel reduction (`Meta.isDefEq`).

---

### 2.2 Direct Source Inspection and Structural/Theorem Anatomy of `15` Top-Referenced Core Hubs

The table below summarizes the source specifications of the top-level hub modules jointly imported across the `5,501` files of `LocalToGlobal`, together with the global coupling modules (`CoreGm.lean`, `TieGlobal.lean`, `HeckeNonVanishing.lean`) that interlock directly with them.

| Hub Module (path relative to `src/`) | Lines | `in_deg` | `dist` | Key Declarations and Mathematical Function |
| :--- | ---: | ---: | ---: | :--- |
| `Formalism/LocalToGlobal/IndefiniteReal/LinksStage.lean` | `315` | `524` | `7` | $m$-step unitary tower `Yc D i`, seesaw pairs `(Vc, Wc)`, master input `Inputs` |
| `Formalism/LocalToGlobal/ProjectiveLattices/AllTest.lean` | `16` | `452` | `8` | Universal verification wrapper `AllTest` across all admissible parameters and test data |
| `Formalism/LocalToGlobal/SiegelLatticeTheory/CokernelGLCounts/NGData.lean` | `128` | `339` | `10` | Non-generic cokernel amplification quotient `a2C = ‖grpC‖^2 / J2of` and count bounds |
| `Formalism/LocalToGlobal/IndefiniteReal/FWExist.lean` | `803` | `275` | `8` | Frame-Witt basis extension `extB`, integral lattice compatibility `lIntegral_topN`, dimension match `tie_of_fwEq` |
| `Formalism/LocalToGlobal/IndefiniteReal/DatumVec.lean` | `214` | `255` | `7` | Adelic pure-tensor test vectors `pureTensorO`, idempotent sums `IsIdemSum`, step vectors `IsDatumStep` |
| `Formalism/LocalToGlobal/IndefiniteReal/ConcretePkgSpec.lean` | `234` | `226` | `8` | `concretePkg_spec` mapping abstract link conditions to the concrete automorphic package `concretePkg` |
| `Formalism/LocalToGlobal/IndefiniteReal/BaseLiftsPackageOfPrimitiveLinks.lean` | `367` | `223` | `7` | Single-step `PThmA`, $m$-fold composite Gram operator `thmBop_of`, `base_lifts_package_of_primitive_links` |
| `Formalism/LocalToGlobal/IndefiniteReal/ZeroPartEigenvalueConvention.lean` | `282` | `217` | `8` | Zero-part eigenvalue phase normalization `Face3`, `Char3`, `characterisation_of_weak` |
| `Formalism/LocalToGlobal/ProjectiveLattices/ThShort.lean` | `355` | `207` | `9` | Shortened normalized evaluation `ShortValAt` on abelian schemes and nonvanishing span `shortNe0_of_t4Span` |
| `Formalism/LocalToGlobal/ProjectiveLattices/FreeBridge.lean` | `120` | `204` | `9` | Equivalence bridges `FDSec_eq` and `noCommonZero_iff` between free-module presentations and projective abelian sections |
| `Formalism/LocalToGlobal/BesselHermitianTheta/AllTied.lean` | `43` | `197` | `7` | Master record `AllTied` bundling 16 Bessel, Hermitian, and theta sub-propositions |
| `Formalism/LocalToGlobal/SiegelLatticeTheory/ClosedLocalOrbits/TermLoc.lean` | `412` | `190` | `9` | Closed local orbit mass data `MassDat`, local term constructor `mkTermLoc`, `recBBTie_of` |
| `Formalism/LocalToGlobal/IndefiniteReal/HeckeNonvanishing/InputsHecke.lean` & related | `18`+`112` | `45` | `7`~`11` | `Imports.lean` (`kexactB`), `isCMExt`, Capelli nilpotent elimination `nonVan` (`HeckeNonVanishing.lean`) |
| `Formalism/SharpRestriction/GlobalSchurBounds/TieGlobal.lean` | `127` | `2` | `8` | Fourfold global/local/arithmetic tying `ChainTied` and `ChainTied.core_of` (repository location cross-verified) |
| `Development/AutomorphicArithmetic/PrimitiveCosets/CoreGm.lean` | `74` | `1` | `5` | Combines `CoreAtH` and `EAtH` to derive $\Lambda.\mathrm{Gm}(x) \le x^{1/2+(e_D+e_L+7)\varepsilon}$ |

The specific algebraic structures and equations extracted from the source code of each hub are detailed below.

#### (1) `LinksStage.lean` (`in_degree = 524`) - Central Switchboard for the $m$-Step Unitary Chain and Seesaw Pairs
`Formalism/LocalToGlobal/IndefiniteReal/LinksStage.lean:31-310` is the single most heavily imported central hub in `LocalToGlobal`.
Over a CM extension $E = D.\mathrm{host}.E$ of a totally real field $F = D.\mathrm{host}.F$, this file arranges the sequence of Hermitian spaces `Yc D i` ($0 \le i < m$) together with the terminal definite space `D.sp.X'` (`SpOK`, `Formalism/LocalToGlobal/IndefiniteReal/LinksStage.lean:240`: `(Yc D (D.R.m - 1)).IsDefinite ∧ D.sp.X'.IsDefinite`).
At each step $i \in \mathrm{Fin}\,m$, a seesaw pair `(Vc D i, Wc D i)` is attached, while `SplitAt` (`Formalism/LocalToGlobal/IndefiniteReal/LinksStage.lean:109-123`) and `IdemAt` (`Formalism/LocalToGlobal/IndefiniteReal/LinksStage.lean:124-125`) impose the existence of orthogonal idempotents $e \in \mathrm{AE}(D)$ over the finite-place set $R.P_g \cup R.Q(t)$.
In particular, the `19`-field master hypothesis structure `Inputs : Prop` defined at `Formalism/LocalToGlobal/IndefiniteReal/LinksStage.lean:290-310` serves as the unified assumption bundle invoked across `524` downstream proof files in `LocalToGlobal`, with field-by-field source specifications tabulated below.

| Field Index and Name (`LinksStage.Inputs`) | Lines | Source Type Specification (`Prop`) | Mathematical Meaning and Upstream Supplier |
| :--- | ---: | :--- | :--- |
| `1. weil` / `2. vac` | `291-292` | `WeilExistsFull D` / `VacExistsO D` | Full adelic Weil representation construction and finite-place vacuum vectors (`Formalism/LocalToGlobal/IndefiniteReal/FinitePlaces/VacExA.lean:1-459`) |
| `3. stepVec` / `4. thPVec` | `293-294` | `StepVecExists D` / `ThPVecExists D` | Existence of step theta test vectors and terminal projection test vectors (`Formalism/LocalToGlobal/IndefiniteReal/DatumVec.lean:185-207`) |
| `5. ptStable` / `6. cartan` | `295-296` | `PtStable D` / `CartanOK D` | Special evaluation-point stabilizer compatibility and infinite-place Cartan involution alignment (`Formalism/LocalToGlobal/IndefiniteReal/LinksStage.lean:95-100`) |
| `7. selfDual` / `8. vecTheta` | `297-298` | `SelfDualOK D` / `VecThetaSD D` | Discriminant preservation for self-dual Hermitian lattices and convergence of self-dual theta series |
| `9. measFD` / `10. measDef` / `11. fund` | `299-301` | `MeasFDExists D` / `FundDomExists D` | Existence of finite fundamental-domain Haar measures and definite-level measures (supplied by `PeriodIntegrals`) |
| `12. sp` / `13. lev` | `302-303` | `SpOK D` / `LevOK D` | Total definiteness of terminal spaces `(Yc D (m-1), X')` and congruence level compatibility (`Formalism/LocalToGlobal/IndefiniteReal/LinksStage.lean:240-246`) |
| `14. hc` / `15. schur` | `304-305` | `HCAll D` / `SchurAll D` | Harish-Chandra discrete-series models and irreducible-representation Schur lemma (`Formalism/SharpRestriction/CuspSpanNormBounds/BridgeCSchur.lean:611-625`) |
| `16. pet` / `17. sm` | `306-307` | `PetAll D` / `SmAll D` | Completeness of the Petersson inner product on cusp spaces and nonvanishing of discrete-series smooth vectors |
| `18. dim` / `19. act` | `308-310` | `DimOK D` / `ActRep D` | Positivity of lowest $K$-type subspace dimension (`0 < dimK`) and compatibility of linear adelic group actions |

#### (2) `DatumVec.lean` (`in_degree = 255`) and `FWExist.lean` (`in_degree = 275`) - Adelic Pure-Tensor Test Vectors and Frame-Witt Compatibility
`Formalism/LocalToGlobal/IndefiniteReal/DatumVec.lean:16-211` constructs the local-global Schwartz-Bruhat test functions $\Phi = \bigotimes'_v \Phi_v$ fed into the $m$-step theta chain.
Over the finite adelic tensor algebra $\mathrm{EAf}(D) := E \otimes_F \mathbb{A}_{F,\mathrm{fin}}$ (`Formalism/LocalToGlobal/IndefiniteReal/DatumVec.lean:16`), the indicator idempotent sum `IsIdemSum e P` (`Formalism/LocalToGlobal/IndefiniteReal/DatumVec.lean:78-82`) of a finite set of places $P$ enforces $e \cdot c_A(D, e) = 0$ together with placewise components $e_v \in \{0, 1\}$.
Subsequently, the step test-vector predicate `IsStepVecOf` (`Formalism/LocalToGlobal/IndefiniteReal/DatumVec.lean:84-97`) and terminal projection test-vector predicate `IsThPVecOf` (`Formalism/LocalToGlobal/IndefiniteReal/DatumVec.lean:109-121`) stipulate that the test vector is given by a pure tensor `pureTensorO` (`Formalism/LocalToGlobal/IndefiniteReal/DatumVec.lean:130-135`) combining a Gaussian Archimedean kernel with finite-place components transforming under the parahoric character $\omega_G \cdot \omega_Q$ (`Formalism/LocalToGlobal/IndefiniteReal/DatumVec.lean:51-73`).

The geometric prerequisites ensuring that these test vectors are well-defined on actual integral lattices are proved in `Formalism/LocalToGlobal/IndefiniteReal/FWExist.lean:19-800` (`803` lines).
`FWExist.lean` constructs the coordinate transition `crd` (`Formalism/LocalToGlobal/IndefiniteReal/FWExist.lean:19-21`) and basis extension `extB` (`Formalism/LocalToGlobal/IndefiniteReal/FWExist.lean:34-38`) linking hyperbolic-plane bases (Witt bases) with definite orthonormal bases (Frame bases), and establishes $\mathcal{O}_E$-integrality of the top lattice together with equality of automorphic-form space dimensions in theorems `lIntegral_topN` (`Formalism/LocalToGlobal/IndefiniteReal/FWExist.lean:773-776`), `FWTie.dimMatch` (`Formalism/LocalToGlobal/IndefiniteReal/FWExist.lean:790-794`), and `tie_of_fwEq` (`Formalism/LocalToGlobal/IndefiniteReal/FWExist.lean:795-800`).

#### (3) `ZeroPartEigenvalueConvention.lean` (`in_degree = 217`), `ConcretePkgSpec.lean` (`in_degree = 226`), and `BaseLiftsPackageOfPrimitiveLinks.lean` (`in_degree = 223`)
These three modules form a three-stage pipeline assembling primitive links (`PrimitiveLinks`) into a single global automorphic package.
1. `Formalism/LocalToGlobal/IndefiniteReal/ZeroPartEigenvalueConvention.lean:29-275` defines the zero-part eigenvalue convention for Hecke operators and the phase factor `phase` (`:232-235`) over boundary data `Face3` (`:29-44`), deriving the full characterization `Char3` (`:243-258`) from `WeakCharacterisation` (`:259-269`) in theorem `characterisation_of_weak` (`:272-275`).
2. `Formalism/LocalToGlobal/IndefiniteReal/BaseLiftsPackageOfPrimitiveLinks.lean:68-196` declares `PThmA` (`:68-70`), stating that the single-step adjoint composition $\theta_{i,t} \circ \theta_{i,t}^*$ acts on the subspace $W_{i,p}$ by a positive scalar $\lambda_{i,t,p,v_0} > 0$, together with `PThmB` (`:71-73`), stating that the $m$-fold composite lift $\Theta_t \circ \Theta_t^*$ acts by the product eigenvalue.
   In particular, for a linear map $T_\zeta := \zeta \cdot T$ between finite-dimensional complex inner-product spaces $E, F$ twisted by a unit complex scalar $\zeta \in \mathbb{C}$ ($\|\zeta\| = 1$), the phase-cancellation lemma `phase_cancel` (`Formalism/LocalToGlobal/IndefiniteReal/BaseLiftsPackageOfPrimitiveLinks.lean:130-161`) proves via `LinearMap.adjoint_smul` and `Complex.mul_conj'` that

   $$
   \left(T_\zeta\right) \circ \left(T_\zeta\right)^* = \left(\zeta\, T\right) \circ \left(\overline{\zeta}\, T^*\right) = |\zeta|^2 \, \left(T \circ T^*\right) = T \circ T^*
   $$

   showing that projective 2-cocycle phase ambiguities of the Weil representation cancel identically in the self-adjoint Gram operator.
   Immediately afterward, theorems `thmAop_of` (`:175-183`), `thmBop_of` (`:184-196`), and the main theorem `base_lifts_package_of_primitive_links` (`:288-348`), taking the 24-row condition record `PrimRows3` (`:199-223`) as input, complete the base-level lift package.
3. `Formalism/LocalToGlobal/IndefiniteReal/ConcretePkgSpec.lean:140-229` (`234` lines, `in_degree = 226`) contains the tactic proofs instantiating this abstract link interface into the concrete automorphic package `concretePkg`.
   - **Unramified-place untwisting theorem `untw` (`Formalism/LocalToGlobal/IndefiniteReal/ConcretePkgSpec.lean:140-153`)**: Substitutes $\mu(w) = A.\mu_0$ (`h.mu_off`) at any place $w$ outside the finite support, applies De Morgan negation pushing (`push Not at hn`, `:147`) to the hypothesis `hW : ¬ R.NonzeroIndexPlace F w` to obtain vanishing of all five local deformation indices (`Iw`, `jw`, `F0`, and those at the conjugate place `conjPl w`), and unfolds `IndefData.Aw` to establish triviality.
   - **Hermitian-Weil norm scaling theorem `ewNorm` (`Formalism/LocalToGlobal/IndefiniteReal/ConcretePkgSpec.lean:154-163`)**: Applies `inner_smul_left`, `inner_smul_right`, and `Real.mul_self_sqrt (nP_pos b).le` to the complex inner product of vectors scaled by $\sqrt{n_P(F, b)}$ to prove the exact scalar pull-out identity:

     $$
     \overline{\left\langle \sqrt{n_P}\,x,\; \sqrt{n_P}\,y \right\rangle_{\mathbb{C}}} = n_P \cdot \overline{\langle x, y \rangle_{\mathbb{C}}}
     $$

   - **Real-place $K$-form basis generation theorem `kForm` (`Formalism/LocalToGlobal/IndefiniteReal/ConcretePkgSpec.lean:164-177`)**: Lifts linear independence of a finite basis over the number field $L = D.\mathrm{what}_2.\mathrm{LL}$ to the complex embedding place `sgAt embLL v`, multiplies by the nonzero unit scalar $(\sqrt{n_P})^{-1} \ne 0$ (`units_smul`), and derives complete basis generation of the complex Hilbert subspace via `Tw.linInd` and `Tw.span_top`.
   - **30-field record `cxLinks` and `concretePkg_spec` (`Formalism/LocalToGlobal/IndefiniteReal/ConcretePkgSpec.lean:178-224`)**: Assembles the three theorems above together with the fields of `hL : ConcreteLinks R F Y C CH` into 30 entries (`stable`, `inBlock`, `ratZ`, ..., `untw`, `passage`, `fun0`), and closes the final specification theorem `concretePkg_spec` (`:218-224`) by the fourfold definitional reflexivity tuple `⟨rfl, rfl, rfl, rfl⟩`.

#### (4) `AllTest.lean` (`in_degree = 452`), `FreeBridge.lean` (`in_degree = 204`), and `ThShort.lean` (`in_degree = 207`) - Projective Lattice Sections and Shortened Evaluation
These are the three core hubs of `ProjectiveLattices` governing theta-function evaluation on projective abelian varieties.
`Formalism/LocalToGlobal/ProjectiveLattices/AllTest.lean:12-15` defines the universal compatibility predicate `AllTest` ranging over all admissible test configurations, unifying the common type signature shared across `452` downstream modules.
`Formalism/LocalToGlobal/ProjectiveLattices/FreeBridge.lean:18-117` constructs the translators `Unf.ofPj` and `Unf.toPj` (`:38-43`) between free $\mathcal{O}_E$-lattice presentations (`Unf`) and projective scheme sections (`Pj`), proving the finite-dimensional holomorphic cuspidal section agreement theorems `FDSec_eq` (`:18-19`), `isHolCusp_iff` (`:20-22`), and `noCommonZero_iff` (`:104-106`), which translates absence of common zeros across evaluation-point sets.
Building on these, `Formalism/LocalToGlobal/ProjectiveLattices/ThShort.lean:244-349` defines the shortened evaluation `ShortValAt` (`:244-262`), multiplying a differential-operator polynomial $P(\nabla)$ on an abelian scheme by the normalization factor $N^{-\deg P}$, and proves theorem `shortNe0_of_t4Span` (`:335-349`), deducing the existence of a nonvanishing evaluation point from dominant-weight spanning hypotheses.

#### (5) `NGData.lean` (`in_degree = 339`), `TermLoc.lean` (`in_degree = 190`), and `AllTied.lean` (`in_degree = 197`)
Governing Siegel lattice orbit counts, `Formalism/LocalToGlobal/SiegelLatticeTheory/CokernelGLCounts/NGData.lean:18-125` introduces the weighted exponential sum `Jw` (`:29-33`), squared sum `J2of` (`:34-38`), group-averaged sum `grpC` (`:39-42`), and the Cauchy-Schwarz amplification ratio

$$
\mathrm{a2C} := \frac{\|\mathrm{grpC}\|^2}{\mathrm{J2of}}
$$

(`Formalism/LocalToGlobal/SiegelLatticeTheory/CokernelGLCounts/NGData.lean:43-45`) to bound degenerate and non-generic Fourier-Jacobi orbit contributions in theorem `counting_bound_of_joint_chain` (`:110-125`).
Meanwhile, `Formalism/LocalToGlobal/SiegelLatticeTheory/ClosedLocalOrbits/TermLoc.lean:334-411` constructs local terms `mkTermLoc` (`:349-381`) from stabilizer mass data `MassDat` (`:334-348`) of closed local orbits and proves recursive Bessel tying relations via `recBBTie_of` (`:400-411`).
The resulting Bessel, Hermitian, and theta components are consolidated into the `10` fields of the master bundle structure `AllTied (D : D7) (X : ThetaX D) (A : TH.ProvA)` at `Formalism/LocalToGlobal/BesselHermitianTheta/AllTied.lean:20-40`, shown below.

| Field Name (`AllTied`) | Lines | Source Type Specification | Mathematical Compatibility Content |
| :--- | ---: | :--- | :--- |
| `T` / `sm` / `ty` | `22-26` | `ThetaTied D X` / `ThetaSmoothnessCondition T` / `TypTied T` | Global theta kernel definition, smoothness condition, and local $K$-type / parahoric type agreement |
| `W` / `unr` / `kf` | `28-31` | `WeilTied D X T` / `WeilUnramifiedCondition W` / `KfinTied W` | Adelic Weil representation coupling, spherical vector invariance at unramified places, and $K$-finiteness preservation |
| `phiUp` / `B` | `33-35` | `PhiYupTied W` / `BesselTied D X T W` | Upward Schwartz-function lifting compatibility and equivalence with Fourier-Bessel period integrals |
| `real` / `prov` | `37-39` | `RealTied D` / `ProvisionCompatibility D A` | Infinite-place real Lie group data (`RealTied`) and compatibility with external arithmetic providers (`ProvA`) |

#### (6) Direct Source Verification of the `HeckeNonvanishing` Lineage and Cross-Path Modules (`TieGlobal.lean`, `CoreGm.lean`)
The exact archive paths and source proof structures of modules whose relative placements required cross-checking are confirmed as follows.
- **`HeckeNonvanishing` lineage and nilpotent-kernel elimination proof**: Alongside `Formalism/LocalToGlobal/IndefiniteReal/HeckeNonvanishing/Imports.lean:1-8` (defining `kexactB`) and `Formalism/LocalToGlobal/IndefiniteReal/HeckeNonvanishing/InputsHecke.lean:13-15` (the CM extension criterion `isCMExt`), the Hecke operator lifting specifications reside in `Formalism/LocalToGlobal/IndefiniteReal/NormalDecomposition/LiftHeckeOperators.lean:23-79` (`liftHeckeOperators`, `eigensystemChoice`, `ZeroEigenvalueCondition`), `Formalism/LocalToGlobal/IndefiniteReal/PrimitivePackageFullHecke.lean:29-52` (`primitivePackageFullHecke`, `primRows3_data`), and `Formalism/LocalToGlobal/IndefiniteReal/NearConstantMultiplicities.lean:50-62` (`passage3_of`, `packageFullHecke`).
  The actual discrete-series Hecke eigenfunction nonvanishing proof driven by Capelli central elements is completed in `CompanionTheory/SpectralGeometry/LocalGlobalProofs/StableLattices/HeckeNonVanishing.lean:15-112` via four linear-algebra lemmas:
  1. `exists_ker` (`:19-33`): Any linear endomorphism $T$ on a finite-dimensional nontrivial $\mathbb{C}$-module satisfying $P(T) = 0$ admits a nonzero eigenvector $\ker(T - \lambda\,\mathrm{id}) \ne \{0\}$ at a root of its minimal polynomial.
  2. `eq_zero_of_nilp` (`:34-48`): If a generalized eigenvector $v$ satisfying $(T - c\,\mathrm{id})^k v = 0$ simultaneously satisfies a semisimple trace condition, then $c = 0$ collapses the action to $T v = 0$.
  3. `exists_nnPlus_ne` (`:49-67`): Extracts a simultaneous generalized eigenspace across a commuting family of Hecke and Capelli operators, guaranteeing the existence of a nonvanishing positive-norm vector.
  4. `nonVan` (`:68-112`): Combines the three lemmas above with `eeV_eq_om` (`:15-18`) to prove that the Hecke-projected component on stable lattices is not identically zero.
- **Exact repository placement of `TieGlobal.lean` and `CoreGm.lean`**: Full path search confirms that `TieGlobal.lean` resides under Pillar 2 at `Formalism/SharpRestriction/GlobalSchurBounds/TieGlobal.lean:1-127`, assembling pointwise tying `TiePts` (`:39-47`), global lift tying `TieGlobal` (`:50-62`), local Schur and formal-degree tying `TieLocal` (`:63-83`), and arithmetic prime-point tying `TieArith` (`:84-96`) into `ChainTied` (`:97-115`) to derive `ChainTied.core_of` (`:116-124`). Meanwhile, `CoreGm.lean` resides outside `Formalism` at `Development/AutomorphicArithmetic/PrimitiveCosets/CoreGm.lean:12-74`, completing the final exponent inequality `UpperTheory.Comparison₂.core_gm` established in Section 1.4.

---

### 2.3 Core Mathematical Reconstruction: $+1$ Automorphic Multiplicity Stacking Along Totally Definite Unitary Chains $U(X_0) \to \dots \to U(X_m)$ ($m \approx \sqrt{x}$) and Derivative-Free Stepanov Evaluation

In classical proofs of the function-field Riemann Hypothesis (the Stepanov-Bombieri method), one constructs an auxiliary polynomial $\Phi$ on a curve $\mathcal{C}/\mathbb{F}_q$ over a finite field and applies Hasse-Schmidt hyperderivatives $D^{(r)}\Phi$ to force high vanishing multiplicity $m$ at Frobenius fixed points. Over $\mathbb{Q}$ and $\mathbb{Z}$, however, no global derivation preserving the Leibniz rule across all primes exists. The core mechanism implemented in `LocalToGlobal` **replaces differential vanishing-order elevation with $m$-fold composition of primitive theta links (`PrimitiveLinks`) along a totally definite unitary group chain of length $m \approx \sqrt{x}$, multiplicatively stacking automorphic spectral multiplicities and Arakelov normalization factors by $+1$ per step**. The exact parameter scales and operator equations reconstructed from the source code proceed in four steps.

#### Step 1: Source Fixation of the Parameter Scale Window `(m, n, k)` (`Formalism/SharpRestriction/InertJacobiLevels/AsmIface.lean:142-144`)
Given an asymptotic scale $x \to \infty$ and a small exponent $\varepsilon \in (0, 1/52)$ (`Formalism/SharpRestriction/ParConsts.lean:99-100`), the lift-chain length $m := D.R.m$, evaluation-dimension parameter $n := D.R.n$, and base unitary rank $k := D.R.k$ are strictly pinned by `Formalism/SharpRestriction/InertJacobiLevels/AsmIface.lean:142-144` to the intervals

$$
\sqrt{x\,\delta_1} \le m \le 2\sqrt{x\,\delta_1}, \qquad x^{2 + 8\varepsilon} \le n \le 2\,x^{2 + 8\varepsilon}, \qquad x^{\frac{9}{2} + 10\varepsilon} \le k \le 2\,x^{\frac{9}{2} + 10\varepsilon}
$$

Here $\delta_1 > 0$ is a fixed density constant, so the chain length $m$ has exact order $\Theta(\sqrt{x})$.

#### Step 2: Unitary Hermitian Chain and Stepwise Rallis Scalar Action (`Formalism/LocalToGlobal/IndefiniteReal/BaseLiftsPackageOfPrimitiveLinks.lean:68-73`)
For a fixed odd rank stride $t := P.t$, consider a sequence of totally definite Hermitian spaces over a totally real field $F$,

$$
X_0 \longrightarrow X_1 \longrightarrow \cdots \longrightarrow X_j \longrightarrow X_{j+1} \longrightarrow \cdots \longrightarrow X_m
$$

(`Formalism/SharpRestriction/Divisibility/FunctionModelRallisFromInputs.lean:577-581`, $\mathrm{rk}_E(X_{j+1}) = \mathrm{rk}_E(X_j) + (t + 1)$, Witt index $\mathrm{wittIdx}(X_j) = 0$) paired with the companion indefinite sequence `Yc D i` (`Formalism/LocalToGlobal/IndefiniteReal/LinksStage.lean:240`). At each link $j \in \{0, \dots, m-1\}$, the Weil representation on the adelic unitary product $U(X_j)(\mathbb{A}_F) \times U(X_{j+1})(\mathbb{A}_F)$ together with a test vector $\Phi_j \in \mathcal{S}(X_j \otimes X_{j+1})(\mathbb{A}_F)$ (`Formalism/LocalToGlobal/IndefiniteReal/DatumVec.lean:84-105`) defines the integral theta lift operator

$$
\theta_{j, t} : \mathcal{A}_{\mathrm{cusp}}\left(U(X_j)\right) \longrightarrow \mathcal{A}_{\mathrm{cusp}}\left(U(X_{j+1})\right), \qquad \left(\theta_{j,t} f\right)(h) := \int_{[U(X_j)]} \Theta_{\Phi_j, \mu_{j+1}}(g, h)\, \overline{f(g)}\, dg
$$

(by total definiteness $\mathrm{wittIdx}(X_j) = 0$, every automorphic form automatically belongs to the cuspidal space `X.cusp V = ⊤` under `ThetaCuspidalityCondition` at `Formalism/SharpRestriction/Divisibility/FunctionModelRallisFromInputs.lean:527-528`). Proposition `PThmA` at `Formalism/LocalToGlobal/IndefiniteReal/BaseLiftsPackageOfPrimitiveLinks.lean:68-70` states that at each step $j$, the adjoint composition $\theta_{j,t} \circ \theta_{j,t}^*$ acts as a positive scalar multiple on the designated local-global Hecke and $K$-type eigenspace $W_{j, p, v_0}$:

$$
\left.\left(\theta_{j, t} \circ \theta_{j, t}^*\right)\right|_{W_{j, p, v_0}} = \lambda_{j, t, p, v_0} \cdot \mathrm{id}_{W_{j, p, v_0}}, \qquad \lambda_{j, t, p, v_0} > 0
$$

#### Step 3: Eigenvalue Stacking of the $m$-Fold Composite Gram Operator (`thmBop_of` and `DetChain`)
Starting from the $0$-th base space, form the global lift operator $\Theta_t := \theta_{m-1, t} \circ \cdots \circ \theta_{1, t} \circ \theta_{0, t}$ by composing $m$ consecutive primitive links. `PThmB` at `Formalism/LocalToGlobal/IndefiniteReal/BaseLiftsPackageOfPrimitiveLinks.lean:71-73`, theorem `prod_lamN` (`:110-125`), and `thmBop_of` (`:184-196`) recursively combine the stepwise scaled-isometry hypotheses with the phase-cancellation lemma `phase_cancel` (`:130-161`) to prove that on every element $e$ of the terminal subspace $E_{p, v_0}$, the composite Gram operator $\Theta_t \circ \Theta_t^*$ acts by the exact product of the $m$ stepwise eigenvalues:

$$
\left(\Theta_t \circ \Theta_t^*\right)(e) = \left(\kappa \prod_{j=0}^{m-1} \lambda_{j, t, p, v_0}\right) e
$$

Moreover, in the general family setting where each step acts as a multi-row block operator $B_j \in \End_{\mathbb{C}}(E)$ rather than a scalar, proposition `DetChain` in `Formalism/ThetaLiftIndependence/Statement.lean:266-277` (`301` lines, `in_degree = 19`, `dist = 9`) establishes that the determinant of the composite Gram matrix $A := \Theta_t \circ \Theta_t^*$ factors as

$$
\det(A) = \kappa^{\dim_{\mathbb{C}} E} \prod_{j=0}^{m-1} \det(B_j)
$$

Each traversal of a link $U(X_j) \to U(X_{j+1})$ stacks one additional factor $\lambda_{j, t, p, v_0}$ arising from central $L$-values and local volume ratios onto the exponent, building a multiplicative amplification $\prod_{j=0}^{m-1} \lambda_j \asymp \Lambda_{\mathrm{gain}}^m$ across $m$ steps.

#### Step 4: Coupling with Derivative-Free Shortened Evaluation `ShortValAt` (`Formalism/LocalToGlobal/ProjectiveLattices/ThShort.lean:244-262`)
Finally, when evaluating the terminal automorphic form $\Theta_t(f_0)$ on $U(X_m)$ along special CM cycles, `ShortValAt` at `Formalism/LocalToGlobal/ProjectiveLattices/ThShort.lean:244-262` multiplies a weight-$a$ harmonic polynomial $P \in \mathrm{harmL}(\Lambda, a)$ on the abelian scheme by the level normalization factor $(N : c.F)^{-\deg P}$ to extract the algebraic value

$$
\mathrm{ShortValAt}(\nabla, w, \Lambda, \beta; P) := N^{-\deg P} \, \mathrm{ev}_{x_0}\left(\beta^{-a}\, D_P(s_w)\right) \in \mathcal{O}_{K_0}\left[\frac{1}{\mathrm{bad}}\right]
$$

Here $P(\nabla)$ acts solely on the geometric Gauss-Manin / Maass-Shimura differential sheaf of bounded finite degree and takes no high-order derivatives in the rational prime $p$ direction. Instead, the $\Theta(\sqrt{x})$-order multiplicity needed to dominate the number of prime evaluation points is supplied entirely by the eigenvalue product $\prod_{j=0}^{m-1} \lambda_j$ of the $m$-step unitary theta chain together with the Arakelov line-bundle degree lower bound. This is the exact Lean 4 realization of derivative-free automorphic Stepanov multiplicity over $\mathbb{Z}$.

The table below consolidates this four-step construction from the base step ($j = 0$) through terminal evaluation ($j = m$), matching spaces, operators, accumulated invariants, and verification modules.

| Chain Step Index | Target Hermitian Space and Group | Applied Operator and Test Vector | Stepwise Eigenvalue and Accumulated Quantity | Dedicated Verification Module and Lines |
| :--- | :--- | :--- | :--- | :--- |
| **Base ($j = 0$)** | $X_0$ ($\mathrm{rk}_E X_0 = k$, totally definite) | Initial irreducible cuspidal subspace $\pi_0 \le \mathcal{A}_{\mathrm{cusp}}(U(X_0))$ | Base link `IsLink X P 0 π_0` and nonzero vector $f_0 \in \pi_0$ | `Formalism/SharpRestriction/Divisibility/FunctionModelRallisFromInputs.lean:507-533` |
| **General Step ($0 \le j < m$)** | $U(X_j) \times U(X_{j+1})$ ($\Delta \mathrm{rk} = t + 1$) | Pure tensor $\Phi_j$ (`IsStepVecOf`) and $\theta_{j, t}$ | Single-step scalar $\lambda_{j, t, p, v_0} > 0$ (`PThmA`, $+1$ multiplicity step) | `Formalism/LocalToGlobal/IndefiniteReal/DatumVec.lean:84-105` |
| **Indefinite Seesaw Pair ($j$)** | `(Vc D j, Wc D j)` and `Yc D j` | Frame-Witt extension `extB` and seesaw map `vth` | Petersson/Bessel period nonvanishing transfer `PerNZ` (`stmt2c`) | `Formalism/LocalToGlobal/IndefiniteReal/LinksStage.lean:109-290` |
| **$m$-Fold Composition ($j = m$)** | Terminal definite space $U(X_m)$ ($m \asymp \sqrt{x}$) | Composite lift $\Theta_t = \theta_{m-1, t} \circ \cdots \circ \theta_{0, t}$ | Product eigenvalue $\kappa \prod_{j=0}^{m-1} \lambda_{j, t, p, v_0}$ (`thmBop_of`) and `DetChain` | `Formalism/LocalToGlobal/IndefiniteReal/BaseLiftsPackageOfPrimitiveLinks.lean:184-348` |
| **Special-Point Evaluation** | Projective abelian scheme $X_o$ and lattice $\Lambda$ | Normalized evaluation `ShortValAt` ($N^{-\deg P}$ scale) | Derivative-free nonzero algebraic ratio $\alpha \ne 0$ (`shortNe0_of_t4Span`) | `Formalism/LocalToGlobal/ProjectiveLattices/ThShort.lean:244-349` |

---

## Chapter 3. Deep Anatomy of Pillar 2 `Formalism.SharpRestriction` (`3,093` Files · `709,436` Lines · `33,822` Theorems)

### 3.1 Hierarchical Decomposition and Functional Wiring of the `13` Subpackages

Pillar 2 `Formalism.SharpRestriction` comprises `3,093` files, `709,436` lines, `33,822` theorems and lemmas, and `20,826` definitions, structures, and other declarations (`54,648` declarations in total).
Whereas Pillar 1 `LocalToGlobal` constructs the $m \approx \sqrt{x}$-step automorphic lift chain upward, Pillar 2 `SharpRestriction` acts as the analytic and $p$-adic controller that confines **the Gram-matrix operator norms of cusp-form spans (`CuspSpanNormBounds` and `GlobalSchurBounds`) and the $p$-adic Galois cocycle and polyhedral height errors (`LevelLetterCocycles` and `ValuationFrobeniusEpsilon`) arising when automorphic forms on higher-rank unitary groups are restricted to smaller subgroups and CM periods** within sharp exponential bounds.

The quantitative metrics and dedicated mathematical domains of its `13` subpackages are shown below.

| Rank | Subpackage (`Formalism/SharpRestriction/*`) | Files | Lines of Code | Theorems (`thm+lem`) | Defs/Structs/Other | Dedicated Mathematical Engine and Core Role |
| ---: | :--- | ---: | ---: | ---: | ---: | :--- |
| `1` | **`GrowthBounds`** | `1,210` | `231,225` | `11,586` | `4,555` | Exponential growth-rate comparisons and main-term vs. error-term separation across parameter windows `(m, n, k, j0)` |
| `2` | **`LevelLetterCocycles`** | `758` | `170,849` | `7,138` | `3,626` | Local Galois cohomology (`LocCoh`), Wach-Herr lattices (`DataNLoc`), inertia characteristic polynomials (`TameType`) |
| `3` | **`CuspSpanNormBounds`** | `399` | `132,978` | `6,418` | `4,749` | Iterated Parseval (`Kk_succ`), projected Poincaré Gram decomposition (`RelevantZeroGramTerms`), C*-Schur bridge |
| `4` | **`Divisibility`** | `274` | `63,162` | `2,670` | `3,220` | Chart-independent generator uniqueness (`ThExprUniqOfChartIndep2`), Schur irreducibility (`SchurIrreducible`), Rallis model |
| `5` | **`GlobalSchurBounds`** | `158` | `48,032` | `2,399` | `2,338` | Unitary formal degrees (`ThickPlacesCorollaryOfAnyTranslate`), genus mass volumes (`GenusMassVolumes`), `TieGlobal` |
| `6` | **`GenusPolyhedralBounds`** | `88` | `27,878` | `1,718` | `600` | Polyhedral truncated sums of lattice points in Hermitian genera and Ehrhart volume upper bounds |
| `7` | **`RamificationFrobenius`** | `42` | `10,366` | `783` | `243` | Ramified Frobenius conjugacy-class distributions and host explicit-formula error (`ExplicitFormulaErrorOfHostConditions`) |
| `8` | **`ValuationFrobeniusEpsilon`** | `39` | `9,947` | `270` | `971` | Gaussian and inert height upper bounds on the rank-3 unitary Galois deformation ring `S3hat` (`UnitaryThreeHeightBounds`) |
| `9` | **`InertJacobiLevels`** | `48` | `6,911` | `398` | `303` | Inert Jacobi level depth $j_0$ and constant assembly interface (`AsmIface`) |
| `10` | **`AdmissibleParameterJoins`** | `51` | `6,068` | `343` | `63` | Non-emptiness proofs for admissible intersections across multi-place prime and level parameters |
| `11` | **`(root)` Top-Level Common Layer** | `10` | `1,005` | `51` | `134` | Global admissible window `FamP` and small-parameter bound $\varepsilon < 1/52$ (`ParConsts`) |
| `12` | **`SmoothDesignExistence`** | `15` | `1,002` | `48` | `23` | Existence constructions for smooth spherical and unitary weighted designs |
| `13` | **`AbelianModels`** | `1` | `13` | `0` | `1` | Base type alias for abelian models |
| **Total** | **`SharpRestriction` Complete (`13` subpackages)** | **`3,093`** | **`709,436`** | **`33,822`** | **`20,826`** | **Total declarations: `54,648` (`Main.lean` shortest distance `dist = 6` ~ `43`)** |

Inspecting `Formalism/SharpRestriction/ValuationFrobeniusEpsilon/UnitaryThreeHeightBounds.lean:29-140` (`982` lines, `dist = 15`) inside `ValuationFrobeniusEpsilon` reveals the precise formulation of the $U(3)$ Galois lifting problem `UnitaryThreeLiftingProblem` (`:29-82`).
After equipping a complete local ring isomorphism $e_S : Q.\widehat{A}.C \simeq V.\widehat{S}_3(l, e, \chi, K, g_1)$ (`:77`) together with an 8-entry symmetry and norm relation position table `posTab` (`:22`), this structure establishes explicit $l$-adic valuation upper bounds on the deformation-module length `V.Vlen l e χ` in both the Gaussian split case (`GaussianCaseHeightBound`, `:119-128`) and the inert case (`InertCaseHeightBound`, `:129-138`):

$$
\begin{aligned}
\text{Gaussian split case:} \quad & \sum_{\chi'' \sim \chi} \mathrm{Vlen}(l, e, \chi'') \le 2\, v_l\left(\mathrm{N}_{\mathbb{Q}(i)/\mathbb{Q}}(\mathrm{NN})\right), \\
& \log \|\mathrm{NN}\|_{\mathbb{C}} \le C_1 \, \deg_{\mathbb{Q}}(\chi)\, \mathrm{cond}(V)^{18}\, e^7 \log p, \\
\text{Inert case:} \quad & \mathrm{Vlen}(l, e, \chi)\,\log l \le C_2 \, |d_K|^6 \, \deg_{\mathbb{Q}}(\chi)\, \mathrm{cond}(V)^{18}\, e^7 \log\log\left(\mathrm{cond}(V)\,l\right)
\end{aligned}
$$

Because the exponents $\mathrm{cond}(V)^{18} e^7$ and the discriminant power $|d_K|^6$ (`bD = 6`, `Formalism/SharpRestriction/ValuationFrobeniusEpsilon/UnitaryThreeHeightBounds.lean:137`) are pinned to explicit polynomial powers, every resulting error constant is absorbed into $x^\varepsilon$ during the subsequent global window assembly.

---

### 3.2 Direct Source Inspection and Equation Decompilation of `12` Top-Referenced Core Hubs

The quantitative metrics and source decompilation of the top 12 most heavily imported core hubs inside `SharpRestriction` are tabulated below.

| Rank | Hub Module (path relative to `src/`) | Lines | `in_deg` | `dist` | Representative Declarations and Core Mathematical Content |
| ---: | :--- | ---: | ---: | ---: | :--- |
| `1` | `Formalism/SharpRestriction/Divisibility/GeneratorPowers/ThExprUniqOfChartIndep2.lean` | `41` | `873` | `9` | `ChartIndepSt2`, `thExprUniq_of_chartIndep2` ($p^k$ lattice-shift coefficient uniqueness) |
| `2` | `Formalism/SharpRestriction/LevelLetterCocycles/LocCoh.lean` | `195` | `654` | `7` | Bloch-Kato crystalline/de Rham cohomology cores `bkACore`, `bkBCore`, `LocalTateTopDegree` |
| `3` | `Formalism/SharpRestriction/LevelLetterCocycles/LocalSituation.lean` | `641` | `627` | `7` | 30-field $p$-adic Galois lifting situation `Sit`, `LocalLiftingUniformConstant` |
| `4` | `Formalism/SharpRestriction/CuspSpanNormBounds/FractionFieldToGenericStalkAlgebraMapEq.lean` | `282` | `400` | `9` | Local split Bessel model `Model`, recursive Parseval identity `Kk_succ` |
| `5` | `Formalism/SharpRestriction/Divisibility/SchurIrreducible.lean` | `617` | `377` | `7` | Blattner parameter `DiscreteSeriesBlattner`, `ArchimedeanRallisLocal` |
| `6` | `Formalism/SharpRestriction/ParConsts.lean` | `103` | `224` | `7` | No-gain criterion `NoGain`, 36-field family `FamP`, admissible range `DFamP` (`eps < 1/52`) |
| `7` | `Formalism/SharpRestriction/CuspSpanNormBounds/RelevantZeroGramTerms.lean` | `573` | `201` | `7` | Projected Poincaré Gram operator `Kmat`, `RelevantZeroGramTerms`, `famNG`, `famG` |
| `8` | `Formalism/SharpRestriction/InertJacobiLevels/AsmIface.lean` | `221` | `191` | `7` | Constant bundle `FC`, 5-adic depth `j0`, numerical window `NumAt`, shadow interface `Shd` |
| `9` | `Formalism/SharpRestriction/GlobalSchurBounds/ThickPlacesCorollaryOfAnyTranslate.lean` | `2,354` | `189` | `7` | `formalDegreeBound_all_unitaryGroups`, `volumeMass_of_unfolding` |
| `10` | `Formalism/SharpRestriction/LevelLetterCocycles/DataNLoc.lean` | `1,260` | `188` | `7` | Wach-Herr $(\varphi, \Gamma)$-lattice `LocLat`, residue lattice `resLat`, Hodge weights `LocHW` |
| `11` | `Formalism/SharpRestriction/GlobalSchurBounds/GeneralLinearActions/GenusMassVolumes.lean` | `399` | `183` | `7` | Hermitian discriminant, Haar, and fundamental-domain measure compatibility `SdW`, `SdR`, `SdHerm`, `IsXbetaMeasure` |
| `12` | `Formalism/SharpRestriction/LevelLetterCocycles/ExistsInertiaCharpolyFactorOfTameType.lean` | `1,739` | `172` | `8` | `brauerNesbitt_matrix`, `heckePol_coeff_mem`, tame inertia characteristic-polynomial factorization |

The source definitions and proof architectures of these 12 hubs are examined in order below.

#### (1) `ThExprUniqOfChartIndep2.lean` (`in_degree = 873`) - Algebraic Identity of the Second Most-Referenced Hub in the New Proof Core
`Formalism/SharpRestriction/Divisibility/GeneratorPowers/ThExprUniqOfChartIndep2.lean:12-40` (`41` lines) is an ultra-compact foundational hub directly imported by `873` modules while containing only one proposition definition `ChartIndepSt2` (`:12-23`) and one theorem `thExprUniq_of_chartIndep2` (`:24-40`).
Mathematically, it encodes uniqueness of prime-power translation decompositions under local coordinate chart changes for abelian-variety theta sections.
Specifically, for a prime $p$ (`hp : Nat.Prime p`) and prime power $p^k$, if residue shift indices satisfy $h_0 \equiv h_0' \pmod{p^k}$ together with

$$
h_0 + d \cdot p^k = h_0' + d' \cdot p^k \quad (0 \le h_0, h_0' < p^k)
$$

then $h_0 = h_0'$ and $d = d'$, proved by combining `ZMod.natCast_eq_natCast_iff'`, `Nat.mod_eq_of_lt`, and `Nat.mul_right_cancel (Nat.pow_pos hp.pos)` (`Formalism/SharpRestriction/Divisibility/GeneratorPowers/ThExprUniqOfChartIndep2.lean:24-40`).
Under `ChartIndepSt2`, the integral coefficients of theta-generator power expansions are uniquely determined independently of the chosen local completion chart, making this theorem the reference anchor invoked by `873` divisibility lemmas across `Divisibility` and `LocalToGlobal`.

#### (2) `LocCoh.lean` (`in_degree = 654`), `LocalSituation.lean` (`in_degree = 627`), `DataNLoc.lean` (`in_degree = 188`), and `ExistsInertiaCharpolyFactorOfTameType.lean` (`in_degree = 172`) - The $p$-Adic Galois Deformation and Tame Inertia Factorization Quartet
These four hubs of `LevelLetterCocycles` control local ramification and Selmer-group dimensions for automorphic Galois representations $\rho_{\pi, \lambda}$.

1. **`LocCoh.lean`**: `Formalism/SharpRestriction/LevelLetterCocycles/LocCoh.lean:21-192` defines for a local-field Galois representation `GRep` (`:36-52`) the de Rham property `IsDR` (`:21-24`), cyclotomic twist `IsTwistRep` (`:60-63`), $H^1$ dual lattice `IsDualLat1` (`:87-90`), and 1-coboundary space `CobO` (`:140-142`), establishing the six cohomological axiom interfaces: Bloch-Kato subgroup cores `bkACore` (`:154-160`) and `bkBCore` (`:161-170`), local Tate top-degree duality `LocalTateTopDegree` (`:171-176`), Tate finiteness `TateFiniteness` (`:182-186`), and de Rham duality `drDualCore` (`:187-192`).
2. **`LocalSituation.lean`**: The large structure `Sit` at `Formalism/SharpRestriction/LevelLetterCocycles/LocalSituation.lean:28-79` bundles into 30 fields the residue characteristic $p$, ramification index, local Galois group $G_K$, inertia group $I_K$, wild inertia subgroup $P_K$, Frobenius elements, and representation matrices, while `LocalLiftingPackage` (`:635-637`) and `LocalLiftingUniformConstant` (`:638-640`) at the bottom guarantee deformation-ring liftings of residual representations within uniform constant bounds.
3. **`DataNLoc.lean`**: `Formalism/SharpRestriction/LevelLetterCocycles/DataNLoc.lean:12-1259` defines Wach-Herr $(\varphi, \Gamma)$-module lattices `LocLat` (`:12-30`) from $p$-adic Hodge theory, the letter alphabet `LetA` (`:52-53`, carrying $(\mathcal{E}, \pi, \varphi, \gamma)$ data), and residue lattices `resLat` (`:76-83`), completing at the bottom the local Hodge-weight structure `LocHW` (`:1227-1237`), Fontaine ring morphisms `LocFon` (`:1238-1240`), and crystalline comparison isomorphisms `LocCmpT` (`:1241-1244`).
4. **`ExistsInertiaCharpolyFactorOfTameType.lean`**: `Formalism/SharpRestriction/LevelLetterCocycles/ExistsInertiaCharpolyFactorOfTameType.lean:15-1738` is the automorphic-Galois bridge transferring Frobenius trace identities at unramified primes into characteristic-polynomial factorizations on inertia at tamely ramified places.
   - First, `ss_of_isSSRep` (`:18-28`) and `brauerNesbitt_matrix` (`:29-56`) prove via Jacobson density and uniqueness of Jordan-Hölder simple factors that if two semisimple matrix representations $\rho_1, \rho_2 : G \to \mathrm{GL}_n(L)$ over a field satisfy $\mathrm{Tr}\,\rho_1(g) = \mathrm{Tr}\,\rho_2(g)$ for every $g \in G$, then their characteristic polynomials agree identically: $\det(X I_n - \rho_1(g)) = \det(X I_n - \rho_2(g))$.
   - Next, `closed_of_adic` (`:73-118`) and `heckePol_coeff_mem` (`:122-140`) exploit topological closedness of the $\mathfrak{m}$-adically complete integer ring $\mathcal{O}_\lambda$ to extend Hecke characteristic-polynomial congruences from a dense set of unramified Frobenius elements continuously to tame inertia generators $\tau \in I_w / P_w$, culminating in linear-factor splitting of tame inertial types in `galois_clause_of_sufficient` (`:1736-1738`).

#### (3) `ParConsts.lean` (`in_degree = 224`) and `AsmIface.lean` (`in_degree = 191`) - Global Parameter Window `FamP` and 5-Adic Level Depth $j_0$
`Formalism/SharpRestriction/ParConsts.lean:19-100` serves as the constitutional ledger governing the asymptotic error budget of the entire archive.
Direct inspection of `FamP (eps : ℝ)` at `Formalism/SharpRestriction/ParConsts.lean:31-98` shows hard-coded integer constants alongside index-invariance (`i, i' : Ix x`) constraints designed to preclude parameter drift or inter-branch mismatch, as summarized below.

| Field Name (`ParConsts.FamP`) | Lines | Source Formula and Fixed Constant Specification | Role in the Asymptotic Error Budget |
| :--- | ---: | :--- | :--- |
| `params_K` / `parT_K` | `33-41` | `parConsts (params x hx i) = PK` (pins a list of `23` real constants) | Forces auxiliary constants to equal $x$-independent constant vectors `PK` and `PT` for all $x > x_1$ and indices $i$ |
| `supp_sat` / `tw_supp` | `57-61` | `resChar w ≤ X'' n → w ∈ supp` and `muAt w ≠ mu0 → w ∈ supp` | Absorbs all prime places up to the threshold scale and all auxiliary-character twist places into the finite support `supp` |
| `h_eq` | `73` | `(D x i).div.h u = DV.hExpl6 (D x i) (L x i) (X x i) Csz u` | Identifies the Arakelov divisor height function equationally with the explicit 6-term height formula `hExpl6` |
| `rho_le` | `79-80` | `G.rhoB (D x i) GK (L x i).sc ≤ x ^ (-2 : ℝ)` | Compresses relative density fluctuation $\rho_B$ below $x^{-2}$, eliminating quadratic error terms |
| `drop_iff` | `83-84` | `p ∈ (L x i).drop ↔ NoGain (Gx x i) GK Cr p ∧ ∀ u, p ≠ A.T` | Restricts the exceptional sieve drop set `drop` to exact no-gain (`NoGain`) primes |
| `fixed` | `86-87` | `Pr1=1, dl1=5, dl2=4, Ce=1, c6=12, dig=3, Cr=1, CnW=10, 12≤eP` | Pins 9 core combinatorial, digit, and degree constants to literal integers, preventing circular constant dependencies |
| `eta_eq` ~ `ep_eq` | `89-97` | Invariance of `etaSz`, `Sc`, `hP`, `bs`, `off`, `kapI`, `ep` across `i, i' : Ix x` | Synchronizes gauges and offsets across distinct family branches `i, i'` at a fixed scale $x$ |
| `DFamP` | `99-100` | `∀ ε : ℝ, 0 < ε → ε < 1 / 52 → FamP ε` | Fixes the admissible open interval $(0, \frac{1}{52})$ for the small parameter |

Paired with `ParConsts.lean`, `Formalism/SharpRestriction/InertJacobiLevels/AsmIface.lean:10-218` defines the constant-list records `PC` (`:10-34`), `PTC` (`:40-48`), and `FC` (`:51-69`), together with the numerical-window verification structure `NumAt` (`:120-145`).
Specifically, `Formalism/SharpRestriction/InertJacobiLevels/AsmIface.lean:139` pins the inert Jacobi level depth $L.j_0$ to the non-negative base-$5$ ceiling logarithm:

$$
j_0 := \left\lceil \frac{\log\left(n \cdot N(m) / m\right)}{\log 5} \right\rceil_+
$$

The choice of base $5$ is directly tied to the $\mathrm{GL}_5$ relative trace formula and 5-ary level pruning architecture treated in Section 3.3.

#### (4) `SchurIrreducible.lean` (`in_degree = 377`), `GenusMassVolumes.lean` (`in_degree = 183`), and `ThickPlacesCorollaryOfAnyTranslate.lean` (`in_degree = 189`)
These three hubs govern Archimedean and global measure normalizations.
- `Formalism/SharpRestriction/Divisibility/SchurIrreducible.lean:20-614` defines lowest $K$-type Blattner parameters `DiscreteSeriesBlattner` (`:74-81`) for discrete series together with lowering/raising operator kernels `lowKer` (`:38-42`) and `raised` (`:43-48`), outputting the local Archimedean Rallis inner-product formula `ArchimedeanRallisLocal` (`:613-614`).
- `Formalism/SharpRestriction/GlobalSchurBounds/GeneralLinearActions/GenusMassVolumes.lean:11-396` defines normalization compatibility `IsCompatible` (`:390-396`) across Weil measures `SdW` (`:353-356`), real-place measures `SdR` (`:357-360`), Hermitian orbit measures `SdHerm` (`:361-364`), and Fourier-Bessel orbit measures `IsXbetaMeasure` (`:365-389`) for nondegenerate Hermitian forms `IsHermND` (`:22-24`) over $E/F$.
- `Formalism/SharpRestriction/GlobalSchurBounds/ThickPlacesCorollaryOfAnyTranslate.lean:17-2353` (`2,354` lines), one of the largest single proof files in Pillar 2, deduces from Weyl-dimension and root-product monotonicity `harishChandraAbs_pos_of_strictAnti` (`:2251-2260`) of Harish-Chandra formal degrees the two-sided polynomial bounds `formalDegreeBound_all_unitaryGroups` (`:2261-2312`) and `familyFormalDegree_all` (`:2317-2321`) across all unitary groups in the chain, and closes the unfolding mass ratio in `volumeMass_of_unfolding` (`:2342-2353`).

#### (5) `FractionFieldToGenericStalkAlgebraMapEq.lean` (`in_degree = 400`) and `RelevantZeroGramTerms.lean` (`in_degree = 201`)
These two hubs compute the Gram-matrix norms of cusp-form spans directly; their internal equation chains are reconstructed in full in Section 3.3 below.

---

### 3.3 Core Mathematical Reconstruction: Iterated Parseval Identity and the $\mathrm{GL}_5$ 6-Fold Metaplectic Cover Relative Trace / Schur Upper-Bound Chain

In analytic number theory, bounding inner-product matrices $\langle P_u, P_{u'} \rangle$ of Poincaré series via classical Kuznetsov-Petersson trace formulas relies on pointwise phase cancellation in individual Kloosterman or Gauss sums (such as the Weil bound $q^{1/2}$). At multiply ramified levels on higher-rank unitary and general linear groups ($\mathrm{GL}_5$ and above), however, degenerate hyperboloid singularities in high-dimensional exponential sums prevent pointwise phase cancellation alone from avoiding exponent loss.

The solution built in `SharpRestriction` **dispenses with sign cancellation in individual Gauss sums altogether, combining iterated Parseval identities over quotient-module cokernels, a relative trace formula on the 6-fold metaplectic cover of $\mathrm{GL}_5$, and a C*-algebraic functional-calculus Schur lemma to compress Hilbert-Schmidt and operator norms of Gram matrices into purely non-negative $L^2$ sums of squares**. The exact four-step equation chain recorded in the source code runs as follows.

#### Step 1: Iterated Parseval Identity Over Cokernel Isomorphism Classes (`Kk_succ`) Replacing Gauss-Sum Cancellation
`Formalism/SharpRestriction/CuspSpanNormBounds/FractionFieldToGenericStalkAlgebraMapEq.lean:42-260` defines over a non-Archimedean local field extension $E/F$ the split model `Model F E` (`:42-47`), subring of integers $R := M.R \subseteq E$ (`:52-60`), additive character $\psi_R : E \to \mathbb{C}^\times$ (`:66-70`), cokernels `M.Cok ZZ` (`:90-92`) of size-$(m+1)$ matrices, and the set of isomorphism classes $\mathrm{Cls}_m(M) := M.\mathrm{Cls}\,m$ (`:143`, with automorphism-group order $|\Aut(c)| = M.\mathrm{nAut}\,c$ at `:145`).

Defining the partial Bessel integral coefficients $\mathrm{BB}(M; w, c) \in \mathbb{C}$ (`:211-214`) with respect to lower- and upper-triangular unipotent matrices $u_{\mathrm{Low}}(x)$ (`:181-183`) and $u_{\mathrm{Up}}(w, y)$ (`:184-187`), theorem `Kk_succ` (`Formalism/SharpRestriction/CuspSpanNormBounds/FractionFieldToGenericStalkAlgebraMapEq.lean:254-256`) proves that the kernel $K_k := M.\mathrm{Kk}$ (`:215-218`) ascending from depth $m$ to depth $m+1$ satisfies the exact Parseval decomposition identity

$$
K_{m+1}(w, w') = \sum_{c \in \mathrm{Cls}_m(M)} \frac{\mathrm{BB}(M; w, c)\,\overline{\mathrm{BB}(M; w', c)}}{|\Aut(c)|}
$$

In particular, along the diagonal $w = w'$,

$$
K_{m+1}(w, w) = \sum_{c \in \mathrm{Cls}_m(M)} \frac{\left|\mathrm{BB}(M; w, c)\right|^2}{|\Aut(c)|} \ge 0
$$

so $L^2$ mass is preserved identically across dimensions $1 \to 2 \to \dots \to r_S + 1$ by orthogonality (Parseval's identity) over the finite abelian cokernel `M.Cok ZZ`, without estimating pointwise cancellation of complex oscillatory terms. Off the diagonal ($w \ne w'$), Cauchy-Schwarz yields $|K_{m+1}(w, w')|^2 \le K_{m+1}(w, w)\,K_{m+1}(w', w')$ immediately.

#### Step 2: Fivefold Cell Decomposition of the Projected Poincaré Gram Matrix `Kmat` (`Formalism/SharpRestriction/CuspSpanNormBounds/RelevantZeroGramTerms.lean:335-524`)
On the cuspidal subspaces `s.Cu u` indexed by word parameters $u, u' \in \mathrm{Word}$, `Formalism/SharpRestriction/CuspSpanNormBounds/RelevantZeroGramTerms.lean:335-377` scales the projected Poincaré Gram operator $K(u, u') := \mathrm{Kmat}(s, u, u') : \mathcal{C}_{u'} \to \mathcal{C}_u$ (`:339-344`) by the normalization constant

$$
c_0(u) := \frac{\mathrm{vol}_N(u)\,\mathrm{vol}_H(u)}{\dim \Pi(u)}, \qquad \dim \Pi(u) := \prod_{\tau} \dim \Pi_U\left(k, u_\tau\right)
$$

(`Formalism/SharpRestriction/CuspSpanNormBounds/RelevantZeroGramTerms.lean:335-337`), expands it as a series $\sum_t a_{u, u'}(t)$ (`KExpansion`, `:345`), and partitions all Bruhat and orbital terms $t \in s.\mathrm{Term}(u, u')$ into five mutually disjoint components (`Formalism/SharpRestriction/CuspSpanNormBounds/RelevantZeroGramTerms.lean:351-376`):

$$
K(u, u') = K_{\mathrm{id}}(u, u') + K_2(u, u') + K_{\mathrm{NG}}(u, u') + K_{\mathrm{G, sc}}(u, u') + K_{\mathrm{G, loop}}(u, u')
$$

The source predicate definitions, controlling theorems, and norm-decay mechanisms for each of the five Gram-matrix cells are contrasted below.

| Gram Matrix Component | Source Definition (`RelevantZeroGramTerms.lean`) | Defining Predicate | Controlling Bound Theorem and Norm-Suppression Mechanism |
| :--- | :--- | :--- | :--- |
| **`1.` $K_{\mathrm{id}}(u, u')$** | `IdCellDiag`(`:372`), `IdCellOff`(`:375`) | $s.\mathrm{isId}(t)$ | Equals $\mathrm{id}_{\mathcal{C}_u}$ on the diagonal $u=u'$ via normalization $c_0(u)$, and $0$ off-diagonal ($u \ne u'$) |
| **`2.` $K_2(u, u')$** | `RelevantZeroGramTerms`(`:351`), `K2`(`:366`) | $s.\mathrm{relevant}(t) \wedge s.\mathrm{Gterm}(t) = 0$ | Eliminated via smooth cutoff `isCutoff_exists` (`:548-557`) and Capelli spectral gap `capW` (`:536-541`) |
| **`3.` $K_{\mathrm{NG}}(u, u')$** | `famNG`(`:353`), `KOf s u u' famNG` | $\neg s.\mathrm{isId}(t) \wedge s.\mathrm{Gterm}(t) \ne 0 \wedge \neg s.\mathrm{generic}(t)$ | Bounded via the Cauchy-Schwarz ratio $\mathrm{a2C} = \|\mathrm{grpC}\|^2 / \mathrm{J2of}$ of `Formalism/LocalToGlobal/SiegelLatticeTheory/CokernelGLCounts/NGData.lean:43-125` |
| **`4.` $K_{\mathrm{G, sc}}(u, u')$** | `scalarP`(`:361`) in `famG`(`:355`), `Kgs`(`:368`) | Diagonal scalar-coupled pairs among generic terms | Directly controlled by iterated Parseval `Kk_succ` of `Formalism/SharpRestriction/CuspSpanNormBounds/FractionFieldToGenericStalkAlgebraMapEq.lean:254-256` |
| **`5.` $K_{\mathrm{G, loop}}(u, u')$** | `loopP`(`:357`) in `famG`(`:355`) | Off-diagonal cross-loop pairs among generic terms | Mean-square $\mathrm{GL}_5$ 6-fold cover relative trace bound and 5-adic depth volume decay $5^{-j_0}$ (`Formalism/SharpRestriction/InertJacobiLevels/AsmIface.lean:139`) |

Written out directly from the source, the three non-identity term sets are:
- **Relevant zero-Gram term set (`:351`)**:
  $$\mathrm{RelevantZeroGramTerms} := \left\{ t \in s.\mathrm{Term}(u, u') \;\mid\; s.\mathrm{relevant}(t) \wedge s.\mathrm{Gterm}(t) = 0 \right\}$$
- **Non-generic nonzero-Gram term set (`:353`)**:
  $$\mathrm{famNG} := \left\{ t \in s.\mathrm{Term}(u, u') \;\mid\; \neg s.\mathrm{isId}(t) \wedge s.\mathrm{Gterm}(t) \ne 0 \wedge \neg s.\mathrm{generic}(t) \right\}$$
- **Generic (big Bruhat cell) term set (`:355`)**:
  $$\mathrm{famG} := \left\{ t \in s.\mathrm{Term}(u, u') \;\mid\; \neg s.\mathrm{isId}(t) \wedge s.\mathrm{Gterm}(t) \ne 0 \wedge s.\mathrm{generic}(t) \right\}$$
  Inside `famG`, where every leading principal minor `leadMinor` (`:235-237`) is invertible, product pairs $(t_1, t_2) \in \mathrm{pairsIn}(\mathrm{famG})$ (`:364`) bifurcate into `scalarP` and `loopP`, forming components 4 and 5 of the table above.

#### Step 3: Coupling with the $\mathrm{GL}_5$ 6-Fold Metaplectic Cover Relative Trace Formula (`GL5/Statement.lean` and `AsmIface.lean`)
The higher-rank group governing mean-square averages over `loopP` and nontrivial orbital averages is $\mathrm{GL}_5$, corresponding to base rank $K = 5$ (`Formalism/HermitianCurvature/HermitianCurvatureProofs/TheoremPIntegralOfPlaces.lean:27`: `(S.mkData Kr hK0 Th e).K = 5`), together with its **6-fold metaplectic cover** coupling.
Inspection of `Formalism/LocalToGlobal/GlobalTheory/GL5/Statement.lean:14-147` (`148` lines, `dist = 9`) shows that over the family `FamP eps`, this module ties together real-place compatibility `TiedRealF` (`:15-17`), frame compatibility `TiedFrameF` (`:28-30`), Weil-Siegel gauge `WeilSiegelGauge` (`:39-44`), standard lattice mass ratios `MassRatioStd` (`:45-50`), Harish-Chandra formal degrees `HCFormalDegree` (`:69-75`), the Landherr-Hasse local-global principle `LandherrHasse` (`:76-81`), and the 5-step link count proposition `LinkCount5` (`:137-140`).
Siegel-Weil and symplectic theta lifts on the 6-fold cover carry 3rd- and 6th-root-of-unity Gauss factors, yet passing to the iterated Parseval sum of squares $|K_{m+1}|^2$ and the positive spectral side of the relative trace formula annihilates the 6th-root-of-unity phases identically via $\zeta_6 \overline{\zeta_6} = 1$, leaving only a pure real volume decay factor $5^{-j_0}$ governed by the 5-adic level depth $j_0 = \lceil \log_5(n N(m)/m)\rceil_+$ (`Formalism/SharpRestriction/InertJacobiLevels/AsmIface.lean:139`).

#### Step 4: C*-Algebraic Functional-Calculus Schur Lemma and Global Norm Closure (`BridgeCSchur.lean` and `MainSup.lean`)
Finally, to prove that composite integral operators on local square-integrable representation spaces collapse to scalars and that the Hilbert-Schmidt norm `hsSqD u u'` (`Formalism/SharpRestriction/CuspSpanNormBounds/RelevantZeroGramTerms.lean:519`) controls the operator norm, `Formalism/SharpRestriction/CuspSpanNormBounds/BridgeCSchur.lean:18-630` (`635` lines, `in_degree = 29`, `dist = 9`) proves the self-adjoint and bounded Schur lemmas `schur_selfAdjoint` (`:18-121`) and `schur_bounded` (`:122-138`) in the C*-algebra of continuous linear operators on a complete Hilbert space directly via continuous functional calculus (`CFC`), without spectral projections.
Substituting this into irreducible square-integrable representations `SqRep` (`:146-152`) of the pseudo-unitary group `UJ ε` yields the Schur orthogonality relation `schur_UJ` (`:611-625`) and discrete-series formal-degree identity `fdeg_of_DS` (`:626-630`):

$$
\int_{U_J(\varepsilon)} \langle \sigma(g) v_1, w_1 \rangle \, \overline{\langle \sigma(g) v_2, w_2 \rangle}\, d\mu(g) = \frac{\langle v_1, v_2 \rangle \, \overline{\langle w_1, w_2 \rangle}}{d(\sigma)}
$$

Combining the formal degree $d(\sigma) = \mathrm{fdegOf}(\mu, \sigma)$ (`Formalism/SharpRestriction/CuspSpanNormBounds/RelevantZeroGramTerms.lean:43-46`) with the uniform polynomial lower bound of `Formalism/SharpRestriction/GlobalSchurBounds/ThickPlacesCorollaryOfAnyTranslate.lean:2261-2312` closes the upper bound for the full projected Gram matrix in `Formalism/SharpRestriction/GlobalSchurBounds/MainSup.lean:249-306` (`chosenProviso_sup`, `tuSize_thr`) and seals the global constant loop through `Formalism/SharpRestriction/GlobalSchurBounds/TieGlobal.lean:116-124` (`ChainTied.core_of`).

The tactic-level deductive mechanisms executed inside the kernel by the two core proof files of Step 4 (`BridgeCSchur.lean` and `ThickPlacesCorollaryOfAnyTranslate.lean`) operate as follows.

1. **Projection-free C*-functional-calculus proof of Schur's lemma in `Formalism/SharpRestriction/CuspSpanNormBounds/BridgeCSchur.lean:18-138`**:
   To show that a bounded self-adjoint operator $T \in (H \to_L H)$ (`IsSelfAdjoint T`) commuting with an irreducible unitary representation $\sigma$ on an infinite-dimensional Hilbert space $H$ is a scalar multiple of the identity, textbook proofs invoke Borel spectral measures (spectral projections).
   Instead, `schur_selfAdjoint` (`Formalism/SharpRestriction/CuspSpanNormBounds/BridgeCSchur.lean:18-121`) bypasses spectral measures using only `Mathlib`'s continuous functional calculus (`cfc : (ℝ → ℝ) → (H →L[ℂ] H) → (H →L[ℂ] H)`).
   - If the real spectrum $\mathrm{spectrum}\,\mathbb{R}\,T$ contained two distinct points $a < b$, one constructs two non-negative continuous cutoff functions $f_1, f_2 : \mathbb{R} \to \mathbb{R}$ with disjoint supports ($f_1(a) > 0$, $f_2(b) > 0$, $f_1 \cdot f_2 = 0$).
   - By uniform polynomial approximation (Weierstrass) and continuity, `cfc f_1 T` and `cfc f_2 T` commute with every $\sigma(g)$, making $\overline{\mathrm{range}(\mathrm{cfc}\,f_1\,T)}$ a closed $\sigma$-invariant subspace that is both nonzero (`cfc f_1 T ≠ 0`) and proper (orthogonal to the range of `cfc f_2 T`), contradicting `IsIrredOn`.
   - Hence the spectrum collapses to a singleton $\{c\}$, and `cfc_id` yields $T = c \cdot \mathrm{id}_H$.
   - Any general bounded intertwining operator $S$ reduces immediately to a complex scalar in `schur_bounded` (`:122-138`) via the Cartesian real-imaginary decomposition $S = \frac{S + S^*}{2} + i\,\frac{S - S^*}{2i}$.
2. **Unitary formal-degree bounds and unfolding volume ratios in `Formalism/SharpRestriction/GlobalSchurBounds/ThickPlacesCorollaryOfAnyTranslate.lean:17-2353`**:
   - At the top of the file (`:17-61`), `finrank_host`, `fDeg_host`, `vInv_host`, `cmField_unramified_massIdentity`, `massIdentity_holds`, and `lVal_pos` combine the relative discriminant of the host CM extension with Dirichlet/Hecke $L$-values $L(M, \eta^M) > 0$ to pin down the unramified local mass identity.
   - Near the bottom (`:2251-2321`), `harishChandraAbs_pos_of_strictAnti` (`:2251-2260`) proves for a strictly decreasing Harish-Chandra parameter sequence $\lambda_0 > \lambda_1 > \dots > \lambda_{n-1}$ that the Weyl denominator product $\prod_{i < j} |\lambda_i - \lambda_j|$ is bounded below positively with minimum spacing at least $1$, lifting this in `formalDegreeBound_all_unitaryGroups` (`:2261-2312`) and `familyFormalDegree_all` (`:2317-2321`) to simultaneous polynomial upper and lower bounds on $d(\sigma)$ across unitary groups of all ranks in the chain.
   - The final theorem `volumeMass_of_unfolding` (`:2342-2353`) combines `VolumeRatio₂` (`:2330-2341`) with the Siegel-Weil unfolding identity to close the global mass constant.

---

## Chapter 4. Deep Anatomy of Pillar 3 `Formalism.HermitianCurvature` (`1,922` Files · `460,802` Lines · `28,075` Theorems)

### 4.1 Internal Dual Stratification (`(root)` Specifications vs. `HermitianCurvatureProofs` Proof Bodies) and `14` Core Hubs

Pillar 3 `Formalism.HermitianCurvature` is a pure Archimedean analysis, differential-geometry, and harmonic-analysis engine containing `1,922` files, `460,802` lines, `28,075` theorems and lemmas, and `7,883` definitions, structures, and other declarations (`35,958` declarations in total).
As established in the cross-import matrix of Section 1.3, this pillar is a self-contained foundational engine with zero imports (`0`) from Pillar 1 `LocalToGlobal`.
Internally, the directory follows a clean two-layer separation between specifications and tactic proof bodies.

| Internal Layer (`Formalism/HermitianCurvature/*`) | Files | Lines of Code | Theorems (`thm+lem`) | Defs/Structs/Other | Avg Lines | Mathematical and Engineering Function |
| :--- | ---: | ---: | ---: | ---: | ---: | :--- |
| **`(root)` Top-Level Specification & Coupling Layer** | `68` | `23,591` | `1,533` | `3,536` | `346.9` | Quantum minor (`StatementQ`), sesquilinear form (`StatementB`), and wave generator (`HerGen`) specifications |
| **`HermitianCurvatureProofs` Proof Bodies** | `1,854` | `437,211` | `26,542` | `4,347` | `235.8` | Phase regularization (`RegularisedPairingViaPhase`), compact-cutoff twin generator (`CutCptCopy`), placewise integration |
| **Total: `HermitianCurvature` Complete** | **`1,922`** | **`460,802`** | **`28,075`** | **`7,883`** | **`239.8`** | **Total declarations: `35,958` (`Main.lean` shortest distance `dist = 7` ~ `25`)** |

The quantitative metrics and source functions of `14` top-referenced hubs, export gateways, and compact-truncation modules extracted from the `B03` AST atlas are listed below.

| Rank | Hub and Output Module (path relative to `src/`) | Lines | `in_deg` | `dist` | Representative Declarations and Mathematical Role |
| ---: | :--- | ---: | ---: | ---: | :--- |
| `1` | `Formalism/HermitianCurvature/StatementQ.lean` | `1,119` | `90` | `10` | Quantum minor row expansion `qminorRow`, zeta commutator `ZetaComm`, `ActualAdjoint` |
| `2` | `Formalism/HermitianCurvature/WeylElementCommutesLevelOne.lean` | `496` | `78` | `7` | Level-1 Weyl element commutativity, Haar uniqueness `HaarUnique`, top export `LemmaBDouble` |
| `3` | `Formalism/HermitianCurvature/HermitianCurvatureProofs/RegularisedPairingViaPhase.lean` | `897` | `70` | `11` | Cartan dilation `aDil_mem_gv`, Lie derivative adjoint `word_adj`, `phase_function_adjoint` |
| `4` | `Formalism/HermitianCurvature/HermitianCurvatureProofs/BetaSesquilinearity.lean` | `1,532` | `66` | `10` | Pseudo-unitary group `GV k r` closure, differential words `Dw`, `assemble_equality_identity` |
| `5` | `Formalism/HermitianCurvature/BesselNonvanishingReduction.lean` | `481` | `60` | `9` | Spectral gap `GapOK`, reproducing kernel `Repro`, regularized kernel `PhiReg`, Bessel nonvanishing reduction |
| `6` | `Formalism/HermitianCurvature/HerGenC.lean` | `80` | `55` | `12` | Compactly supported wave-generator inductive family `HerGenC`, subspace `herKc`, `ThmPActualCpt` |
| `7` | `Formalism/HermitianCurvature/HermitianCurvatureProofs/TheoremPIntegralOfPlaces.lean` | `935` | `32` | `11` | Infinite-place product integral `thmPInt_of_covolume_prod`, `theorem_P_integral_of_places` |
| `8` | `Formalism/HermitianCurvature/StatementB.lean` | `565` | `26` | `8` | Sesquilinear polarization `Polarisation`, seminorm inequality `SeminormIneq`, `LemmaBClosed` |
| `9` | `Formalism/HermitianCurvature/TopDensNonnegOfKappa.lean` | `182` | `12` | `10` | Wave generator `HerGen`, curvature-map positivity `XKappa`, `TopDensNonnegOfKappa` |
| `10` | `Formalism/HermitianCurvature/LatticeHerglotzBound.lean` | `167` | `10` | `13` | Invariant mean `IsMeanInf`, `MeanSplit`, lattice Herglotz bound `LatticeHerglotzBound` |
| `11` | `Formalism/HermitianCurvature/Statement.lean` | `63` | `7` | `11` | Sharp recursion bound `RecursionSharp`, dual size identity `DualSizeIdentity`, `OmNorm` |
| `12` | `Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptCopy.lean` | `91` | `1` | `17` | Metaprogrammed twin-theorem generator `toCopy`, `copyAll`, command `cpt_copy_thms` |
| `13` | `Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptDefs.lean` | `195` | `1` | `18` | Compactly supported fiber, Gram, and curvature integral twin specifications `GLGramCpt`, `GLGermCpt` |
| `14` | `Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptManual.lean` | `551` | `1` | `17` | Manual base proofs `form_csCpt`, `truncated_limit_positivity_holdsCpt`, `glGramCpt` |

The fact that these files share the internal module namespaces `Formalism.FourierDecayAlt` and `Formalism.QuantumDeterminants` (`Formalism/HermitianCurvature/HermitianCurvatureProofs/BetaSesquilinearity.lean:11-13`, `Formalism/HermitianCurvature/TopDensNonnegOfKappa.lean:8-10`) reflects the analytic mission of this pillar directly.
Specifically, its task is to exploit curvature positivity of Hermitian metrics to apply phase-shift regularization and smooth compact cutoffs to divergent Fourier-Bessel integrals over noncompact orbits, extracting non-negative spectral densities (`TopDensNonneg`) in the limit.

Before turning to the metaprogrammed cutoff engine, the internal declaration chains of the top three specification and export hubs (`StatementQ.lean`, `WeylElementCommutesLevelOne.lean`, `StatementB.lean`) are summarized below.

1. **`StatementQ.lean` (`1,119` lines, `in_degree = 90`, `189` declarations)**:
   `Formalism/HermitianCurvature/StatementQ.lean:16-1118` is the most heavily imported hub in Pillar 3, consolidating the algebraic commutation relations of quantum determinant algebras (`QuantumDeterminants`).
   From the row/column deletion index maps `skip1` and `skip2` (`:16-23`), it defines quantum minor row vectors `qminorRow` (`:30-35`) and first-column Laplace expansions `ExpFirstCol` (`:40-44`), sequentially coupling at the bottom the differential commutation relation with the zeta-ratio function `ZetaComm` (`:1080-1092`), true Hilbert-Schmidt adjointness `ActualAdjoint` (`:1093-1107`), module normal-form derivation `NormalFormFromModule` (`:1110-1112`), and level-induction initial condition `ActualStartFromLevels` (`:1116-1118`).
2. **`WeylElementCommutesLevelOne.lean` (`496` lines, `in_degree = 78`, `dist = 7`)**:
   `Formalism/HermitianCurvature/WeylElementCommutesLevelOne.lean:12-495` is the top external export gateway of Pillar 3, sitting at shortest distance `dist = 7` from `Main.lean`.
   Starting from the closed matrix subgroup structure `IsClosedSubgroup` (`:12-18`) and Haar-measure scalar uniqueness and inversion invariance `HaarUnique` and `HaarInvFromUnique` (`:25-34`), it establishes commutativity of opposite Weyl-element conjugation with orbital Jacobians at level 1, and exports at the bottom the crude bound `LemmaBCrude` (`:475-480`), double-level bound `LemmaBDouble` (`:483-487`), and final $\xi$-gauge pairing bound `LemmaBFromXiFromParts` (`:493-495`) to external pillars.
3. **`StatementB.lean` (`565` lines, `in_degree = 26`, `dist = 8`, `110` declarations)**:
   `Formalism/HermitianCurvature/StatementB.lean:14-564` specifies the sesquilinear algebraic axioms satisfied by regularized pairings on noncompact orbits.
   Building on sesquilinearity `IsSesq` (`:14-17`), non-negativity `IsNonneg` (`:18-19`), the seminorm triangle inequality `SeminormIneq` (`:20-23`), and complex four-term polarization `Polarisation` (`:24-27`), it assembles `AdjointnessPolynomialCoefficients` (`:529-535`) and `StepClause` (`:538-549`) into the closed pairing theorems `LemmaBClosed` and `LemmaBClosedFromParts` (`:556-564`).

---

### 4.2 Decompilation of the Archimedean Regularized Cutoff (`CutCpt`) Metaprogrammed Twin Generator

When performing orbital integrations and integrations by parts (`word_adj`) on the noncompact Lie group $G_V(k, r) := \{g \in \mathrm{Mat}_{2r+k+1}(\mathbb{C}) \mid g^{\mathrm{H}} H_{p,k} g = H_{p,k}\}$ (`Formalism/HermitianCurvature/HermitianCurvatureProofs/BetaSesquilinearity.lean:25-36`), rigorously justifying the vanishing of boundary terms at infinity requires **first proving all algebraic and analytic identities on a compactly supported cutoff function space and then transferring them to the original noncompact space via dominated convergence and Fatou limits**.
In human mathematical papers, one routinely writes a single sentence stating that the proof for compactly supported functions proceeds identically; inside a formal proof kernel, however, hundreds of intermediate lemmas would otherwise have to be reproved across two distinct function-space types (`RadSp` versus the compactly supported cutoff space).

`Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptCopy.lean:16-90` (`91` lines) resolves this inside the pure Lean 4 kernel without any extra axioms or `sorry` via an **automated dependency-graph cloner (`CptCopy`)**.
Line-by-line inspection shows that this generator operates in four exact stages.

#### Stage 1: Explicit Separation of Boundary Terminals (`terminal`) and Entry Roots (`roots`) (`Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptCopy.lean:16-33`)
Rather than cloning the entire environment indiscriminately, the generator erects a stop-wall at `17` base declarations (`terminal`) whose proofs genuinely differ between the noncompact space and the compactly supported space.
- **Special name-remapping table `special` (`Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptCopy.lean:16-20`, `3` pairs)**:
  - `pb_formPos` $\mapsto$ `module_form_pos_compact_support`
  - `list_duality_level_group` $\mapsto$ `size_standard_compact`
  - `vector_isomorphism_levels` $\mapsto$ `vector_isomorphism_compact_support`
  These three base theorems are proved directly in dedicated files (`ModuleFormPosCompactSupport.lean`, `SizeStandardCompact.lean`, and `VectorIsomorphismCompactSupport.lean`, imported at `:7-9`).
- **Manual base list `manual` (`Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptCopy.lean:21-27`, `14` declarations)**:
  Comprises the `14` base declarations `ThmPActual`, `SizeStd`, `VIso`, `FormPos`, `standard_pairing_of_heads`, `FormNonneg`, `form_re_nonneg`, `form_cs`, `formNonneg_of`, `posAt_of_cpt`, `integral_three_at_place_of_parts`, `integral_four_at_place_of_parts`, `truncated_limit_positivity_holds`, and `glGram`.
  Their compactly supported counterparts (carrying the `*Cpt` suffix) are proved manually by tactic code in `Formalism/HermitianCurvature/HerGenC.lean:63-79` (`ThmPActualCpt`), `Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptDefs.lean:18-194`, and `Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptManual.lean:12-550`.
- **Entry root list `roots` (`Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptCopy.lean:28-31`, `6` theorems)**:
  Takes the `6` top target theorems `thmBpAt_main4`, `germ_truncation_positive`, `block_growth_bound_of_compact_coef`, `nFTopFormAll_of_ptw`, `top_identity_of_domination_limits`, and `nfPolFormAll_of_top` as starting points.

#### Stage 2: Taint-Propagation (`tainted`) Post-Order Traversal `go` and `toCopy` (`Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptCopy.lean:38-57`)
The function `proposals` (`:38-40`) extracts all referenced constants appearing in both the type (`ci.type`) and proof-term value (`ci.value`) of each constant in the environment.
Starting from `roots`, the recursive walker `go` (`:41-53`) performs depth-first search across downstream `Formalism`-prefixed dependencies, halting whenever it reaches the `terminal` set.
If any child dependency lies in `terminal` or is already marked `tainted`, the current node is inserted into `tainted` and appended to the topological-order array `order` (`:51`).
Conversely, nodes independent of `terminal` (such as pure matrix algebra or `Mathlib` lemmas) are not duplicated and are reused directly as-is.

#### Stage 3: Constant Substituter `subst` and Direct Kernel Submission `copyAll` (`Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptCopy.lean:58-90`)
Following the topological order (`order`), `copyAll` (`:68-85`) forms a suffixed name `n'` by appending `"Cpt"` (`mapName`, `:58-62`) to each tainted node and applies the expression substituter `subst` (`:63-67`) across both types (`d.type`, `t.type`) and proof terms (`d.value`, `t.value`) to replace every tainted constant reference with its `*Cpt` twin.
The decisive safeguard appears at `:78` and `:82` in the kernel submission step.
`copyAll` invokes `addDecl (.defnDecl ...)` and `addDecl (.thmDecl ...)`, **submitting every substituted proof term in full to the Lean 4 kernel type checker**.
If even a single argument type or universe level mismatched between the manual base proofs (`CutCptManual.lean`) and a cloned upper theorem, `addDecl` would trigger an immediate kernel rejection error.
Thus `cpt_copy_thms` (`:87-90`) is soundness-preserving metaprogramming that mechanizes the entire compactly supported twin theorem hierarchy without expanding the trusted computing base (TCB).

#### Stage 4: Cauchy-Schwarz and Truncated-Limit Proofs in the Manual Base File `CutCptManual.lean` (`Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptManual.lean:12-550`)
Inspecting `Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptManual.lean:12-85`, which underpins the cloner, reveals the tactic proof deriving the Cauchy-Schwarz inequality `form_csCpt` (`:25-79`) from the non-negative Hermitian sesquilinear condition `FormNonnegCpt` (`:12-16`: $(p.\mathrm{form}\,x\,x).\mathrm{im} = 0$ and $0 \le (p.\mathrm{form}\,x\,x).\mathrm{re}$ for all finitely supported vectors $x$).
Specifically, expanding $0 \le \Re\,p.\mathrm{form}(x + t y, x + t y)$ at the complex scalar $t := -c \cdot \overline{p.\mathrm{form}(x, y)}$ ($c \in \mathbb{R}$) yields the real quadratic inequality

$$
0 \le \Re\,p.\mathrm{form}(x, x) - 2 c\,\|p.\mathrm{form}(x, y)\|^2 + c^2 \|p.\mathrm{form}(x, y)\|^2\,\Re\,p.\mathrm{form}(y, y)
$$

and splitting into the degenerate case $\Re\,p.\mathrm{form}(y, y) = 0$ and the positive case (substituting $c = (\Re\,p.\mathrm{form}(y, y))^{-1}$) establishes

$$
\|p.\mathrm{form}(x, y)\|^2 \le \Re\,p.\mathrm{form}(x, x) \cdot \Re\,p.\mathrm{form}(y, y)
$$

(`Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptManual.lean:45-79`).
At the bottom of the same file, `posAt_of_cptCpt` (`:443-462`), `truncated_limit_positivity_holdsCpt` (`:463-483`), and `glGramCpt` (`:486-550`) confirm that positivity is preserved under monotone and dominated limits of smooth cutoff sequences.

The complete correspondence ledger of the `11` compactly supported twin specifications in `Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptDefs.lean:18-194` and the `9` manual base theorems in `Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptManual.lean:12-550` is presented below.

| Category | Source Declaration (`*Cpt` Twin Base) | File and Lines (relative to `src/`) | Noncompact Counterpart and Mathematical Role |
| :--- | :--- | :--- | :--- |
| **Twin Spec `1`** | `FibreTopCpt` / `GLFibreCpt` | `Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptDefs.lean:18-45` | Top fiber integral and general-linear fiber compatibility under compactly supported cutoffs |
| **Twin Spec `2`** | `GLGramCpt` / `GLContCpt` | `Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptDefs.lean:54-97` | Positive semidefiniteness and parameter continuity specifications for truncated orbital Gram matrices |
| **Twin Spec `3`** | `GermDataLowAllCpt` / `GLGermCpt` | `Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptDefs.lean:72-164` | Low-order germ expansions near singularities and compact-support boundary vanishing |
| **Twin Spec `4`** | `PStdCpt` / `CurvatureIntegralOfPartsCpt` | `Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptDefs.lean:106-128` | Standard pairing assembly and summation formula for partial curvature integrals |
| **Twin Spec `5`** | `IntegralFourFromComponentsCpt` | `Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptDefs.lean:134-140` | Compact-support convergence specification for four-component decomposed integrals |
| **Twin Spec `6`** | `NFTopFormAllCpt` / `GermDataTopAllCpt` | `Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptDefs.lean:171-194` | Agreement specification between normal-form top pairings and top-order germs |
| **Manual Thm `1`** | `formNonneg_ofCpt` / `form_re_nonnegCpt` | `Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptManual.lean:22-85` | Extraction of diagonal real-part non-negativity $\Re\,p.\mathrm{form}(x, x) \ge 0$ |
| **Manual Thm `2`** | `form_csCpt` | `Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptManual.lean:25-79` | Direct proof of the Cauchy-Schwarz inequality for compactly supported sesquilinear forms |
| **Manual Thm `3`** | `integral_four_at_place_of_partsCpt` | `Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptManual.lean:93-257` | Four-component truncated integral assembly at a single Archimedean place (`165`-line tactic proof) |
| **Manual Thm `4`** | `integral_three_at_place_of_partsCpt` | `Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptManual.lean:265-415` | Three-component truncated integral assembly at a single Archimedean place (`151`-line tactic proof) |
| **Manual Thm `5`** | `standard_pairing_of_headsCpt` | `Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptManual.lean:422-428` | Construction of standard regularized pairings from leading head terms |
| **Manual Thm `6`** | `posAt_of_cptCpt` / `glGramCpt` | `Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptManual.lean:443-550` | Truncated-limit positivity `truncated_limit_positivity_holdsCpt` (`:463-483`) and Gram positive definiteness |

---

### 4.3 Positivity of the Hermitian Metric Curvature Tensor, Quantum Minors (`Dmin`), and Coupling to the Arakelov Global Height Inequality

The central mathematical mechanism proved across Pillar 3 is **combining positivity of the Hermitian metric curvature function $G_f$ defined via quantum minors on the pseudo-unitary symmetric space of signature $(p, q) = (r + k + 1, r)$ with Lie-algebra commutators to obtain non-negativity of the top spectral density (`TopDensNonneg`), and converting this via the lattice Herglotz bound and all-places integration (`theorem_P_integral_of_places`) into a lower bound on the Arakelov twisted height**.
The top summary leaf `Formalism/HermitianCurvature/Statement.lean:7-62` (`63` lines, `dist = 11`) organizes the numerical targets of this pillar into seven propositions: sharp dimension recursion `RecursionSharp` (`:7-15`), box-sum normalization `BoxSumOne` (`:25-32`), dual size identity `DualSizeIdentity` (`:33-39`), main constant `MainConstant` (`:40-47`), leading-minors count `LeadingMinorsCount` (`:48-53`), and oscillatory norm bound `OmNorm` (`:54-62`).
The exact five-stage equation chain reconstructed from the lower source files proceeds as follows.

#### Stage 1: Quantum Minors `Dmin` and Curvature Potential `Gf` on the Pseudo-Unitary Group `GV k r`
Consider the pseudo-unitary group $G_V(k, r) = \{g \in \mathrm{Mat}_{2r+k+1}(\mathbb{C}) \mid g^{\mathrm{H}} H_{p,k} g = H_{p,k}\}$ defined by the signature matrix $H_{p,k}(k, r)$ ($H_{p,k}^2 = I_{2r+k+1}$, `Formalism/HermitianCurvature/HermitianCurvatureProofs/BetaSesquilinearity.lean:20-21`) and its Lie algebra $\mathfrak{g}_V = \{X \mid X^{\mathrm{H}} H_{p,k} + H_{p,k} X = 0\}$ (`Formalism/HermitianCurvature/HermitianCurvatureProofs/BetaSesquilinearity.lean:66-84`, closed under exponentiation via `exp_mem`).
For fixed dual frame vectors $z, z' \in \mathbb{C}^{2r+k+1}$, `Formalism/HermitianCurvature/HermitianCurvatureProofs/TheoremPIntegralOfPlaces.lean:113-138` and `Formalism/HermitianCurvature/StatementQ.lean:30-44` define the $l$-th leading principal minor $D_{\min}(k, r, z, z', g; l) := \det \widehat{Z}_{[l]}(g)$ (`contDiff_Dmin`, `:120-124`) of the Hermitian pairing matrix $\widehat{Z}(z, z'; g) \in \mathrm{Mat}_{r+1}(\mathbb{C})$ (`contDiff_Zhat`, `:113-119`), and construct the curvature function $G_f$ as the difference of squared norms of two adjacent leading minors (`contDiff_Gf`, `Formalism/HermitianCurvature/HermitianCurvatureProofs/TheoremPIntegralOfPlaces.lean:133-138`):

$$
G_f(k, r, z, z'; g) := \left|D_{\min}\left(k, r, z, z', g; l_1\right)\right|^2 - c_{k, r}\,\left|D_{\min}\left(k, r, z, z', g; l_0\right)\right|^2
$$

By the Sylvester-Jacobi determinant identity together with the quantum-determinant zeta commutation relations (`ZetaComm`, `ActualAdjoint`) of `Formalism/HermitianCurvature/StatementQ.lean:1080-1107`, the complex Hessian of the log-minor potential $-\log |D_{\min}|^2$ (the Chern curvature 2-form of the Hermitian line bundle) produces a coboundary-dominated region on the big Bruhat cell where $G_f(g) \ge \varepsilon > 0$.

#### Stage 2: Phase-Regularized Pairing `phase_function_adjoint` and Lie-Word Sesquilinearity
To make oscillatory integrals converge along noncompact directions, `Formalism/HermitianCurvature/HermitianCurvatureProofs/BetaSesquilinearity.lean:96-108` defines the composite word operator `Dw w f` (`:103`) built from left- and right-invariant Lie derivatives `Dx` (`:101`):

$$
\left(D_{(b, X)} f\right)(g) := \left.\frac{d}{dt}\right|_{t=0} \begin{cases} f\left(\exp(-t X)\, g\right) & (b = \mathrm{true}) \\ f\left(g\,\exp(t X)\right) & (b = \mathrm{false}) \end{cases}
$$

On top of this, `Formalism/HermitianCurvature/HermitianCurvatureProofs/RegularisedPairingViaPhase.lean:732-896` proves the integration-by-parts adjoint identity `word_adj` (`:732-780`) for Lie-derivative words together with the phase-commutation adjoint theorem `phase_function_adjoint` (`:838-896`), establishing the regularized sesquilinear form `LemmaBClosed` of `Formalism/HermitianCurvature/StatementB.lean:556-564` and the diagonal/equality identities `assemble_diagonal_identity` and `assemble_equality_identity` of `Formalism/HermitianCurvature/HermitianCurvatureProofs/BetaSesquilinearity.lean:1500-1531`.

Inspecting the tactic bodies of these two core `*Proofs/` files shows that regularized adjointness on the noncompact group is proved through the following analytic steps.

1. **Five-step tactic architecture of `Formalism/HermitianCurvature/HermitianCurvatureProofs/RegularisedPairingViaPhase.lean:838-896` (`phase_function_adjoint`)**:
   - **Securing a 5-order differentiability buffer (`:840-842`, `:871-872`)**: Establishes smoothness class `CkOn (opOrder Θ + 5) (GV k r)`, five orders above the maximal differential order `opOrder Θ` of the operator bundle $\Theta$, via `ckOn_rho` and `ckOn_coef`, ensuring that the chain rule and integration by parts apply without regularity loss across word lengths $|w| + 1 \le \mathrm{opOrder}\,\Theta + 5$ (`len_le_order`, `:805-816`).
   - **Splitting inside and outside the open support `UU` (`:843-857`)**: Case-splits (`by_cases`) the integrand of the left-hand phase pairing `Ph D (opApply Θ F) F' p` at `haar_ae D.haarG`-almost every point into $g \in UU$ and $g \notin UU$. For $g \in UU$, it applies the phase-derivative commutation hypothesis `hcom`; for $g \notin UU$, closure containment of the support of $F'$ (`hsF' (subset_closure ...)`) yields $F'(g) = 0$, annihilating exterior contributions via `hs_zero_right`.
   - **Unfolding the reversed-word formal adjoint (`:858-870`)**: On the right-hand side `Ph D F (opAdj Θ F') p`, the formal adjoint `opAdj` unfolds by reversing each Lie-derivative word `T.word` into `T.word.reverse` and multiplying by the sign $(-1)^{|T.\mathrm{word}|}$.
   - **Separate absolute-integrability verification on both sides (`:873-888`)**: Before interchanging finite sums with Bochner/Lebesgue integration, Hilbert-Schmidt inner-product integrability (`hs_integrable`) is proved separately from the growth hypothesis `hIC` for both the left-hand summands (`hIl`) and the reversed right-hand summands (`hIr`).
   - **Substituting the word-length induction adjoint `word_adj` (`:889-895`)**: Pulls the finite sum outside the integral via `integral_listSum` and applies the unimodular Haar integration-by-parts theorem `word_adj` (`:732-780`) to each monomial $T \in \Theta$, matching the two sides identically:

     $$
     \int_{G_V(k,r)} \left\langle R_w\left(\rho_p F\right)(g),\; T_{\mathrm{adj}} F'(g) \right\rangle_{\mathrm{HS}} d\mu_G(g) = (-1)^{|w|} \int_{G_V(k,r)} \left\langle \rho_p F(g),\; R_{w^{\mathrm{rev}}}\left(T_{\mathrm{adj}} F'\right)(g) \right\rangle_{\mathrm{HS}} d\mu_G(g)
     $$

2. **Limit assembly in `Formalism/HermitianCurvature/HermitianCurvatureProofs/BetaSesquilinearity.lean:1500-1531` (`assemble_diagonal_identity` and `assemble_equality_identity`)**:
   - `assemble_diagonal_identity` (`:1500-1509`) combines Fatou's lemma (`hFa`) with the dominating majorant `diagDom` (`hDD`) over two-dimensional damping parameters $\tau \in \mathrm{Quad}$ to show finiteness of the diagonal integral energy (`ENNReal.ofReal_ne_top`), closing the $\beta_\tau(F, F)$ identity via `core` (`:1407-1491`).
   - `assemble_equality_identity` (`:1510-1531`) uses agreement at the base point $\tau_0 = (1, 1) \in \mathrm{Quad}$ (`:1513`) between the regularizing operator $J_\tau(1, 1) F = J_F F$ (`eJ`, `:1514`) and the sesquilinear pairing $\beta(F, F') = \beta_\tau(1, 1; F, F')$ (`eB`, `:1517-1518`) to transfer the continuous neighborhood upper bound `hC0` on $U_0$ to the unregularized pairing `beta D F F'`.

#### Stage 3: Wave-Slice Inductive Cone `HerGen` and Curvature-Map Positivity `XKappa` $\implies$ `TopDensNonneg`
On the radial section space `RadSp P.k P.r z z' π π'`, `Formalism/HermitianCurvature/TopDensNonnegOfKappa.lean:22-68` constructs the inductive generator family `HerGen` (`:28-42`) ascending across level indices $i \in \mathrm{Fin}(P.r + 1)$ together with its linear spans $K_i := \mathrm{herK}(i)$ (`:43-45`) (with compactly supported twin `HerGenC` and `herKc` in `Formalism/HermitianCurvature/HerGenC.lean:24-41`).
The four inductive constructors of `HerGen` and the six-clause analytic package `HerAnalytic` (`Formalism/HermitianCurvature/TopDensNonnegOfKappa.lean:64-68`) established over them are tabulated below.

| Constructor / Clause | Lines | Source Inductive Rule and Formula Condition | Analytic Preservation Property |
| :--- | ---: | :--- | :--- |
| **`HerGen.jf`** | `29-30` | `JFOK P z z' F → IsRadJF ... F Φ → HerGen 0 Φ` | Level-$0$ base kernel supported inside the positive-curvature locus ($F(g) \ne 0 \implies G_f(g) \ge \varepsilon > 0$) |
| **`HerGen.slice`** | `31-32` | `WordOK ... w → HerGen l.castSucc Φ → HerGen l.succ ((bTl L l w a b).1 Φ)` | Level promotion $l \to l+1$ under admissible differential words $w$ and slice operators `bTl` |
| **`HerGen.waveC`** | `33-36` | `multiplicationOperator Wv (fsv s (c' l)) → HerGen l.castSucc ((Vw ...).1 Φ)` | Closure under complex-power phase multipliers `fsv(±s, c'_l)` in intermediate coordinates $c'_l$ |
| **`HerGen.waveZ`** | `37-41` | `multiplicationOperator Wv (fsv s (zeta ... g)) → HerGen (last r) ((Vw ...).1 Φ)` | Closure under quantum-minor ratio phase twists `zeta(g)` at top level `Fin.last P.r` |
| **`HerAnalytic` (6 clauses)** | `64-68` | `AdjTop ∧ TopDensNonneg ∧ TopTwistDens ∧ StepDens ∧ FormInt ∧ CompositeFormulaLevelZero` | Couples adjointness, top-density non-negativity, phase covariance (`:48-54`), integrability (`:55-63`), and composite formulas |

Next, the core positivity condition `XKappa` at `Formalism/HermitianCurvature/TopDensNonnegOfKappa.lean:98-106` states that the algebra homomorphism $\kappa : (\mathrm{Ty}(P) \to \mathbb{C}) \to \mathrm{Pr}(\mathrm{RadSp})$ satisfies for every positive spectral weight $f(\rho) > 0$, radial section $\Phi$, parameter $c$, and group element $g \in \mathrm{Mx}(k, r)$ the pointwise Hilbert-Schmidt inner-product inequality

$$
0 \le \left\langle \left((\kappa f)\,\Phi\right)(c, g),\; \Phi(c, g) \right\rangle_{\mathrm{HS}}
$$

(`XKappa`, `:104-105`; normal-form fiber version `KappaFibrePos`, `:130-139`).
Because $\kappa$ represents the inverse curvature operator $st.x_i(Y) = \kappa(\rho \mapsto x_0(P, l_0, \rho, Y)^{-1})$ (`:103`) via a positive spectral integral, `TopDensNonnegOfKappa` (`:107-116`) deduces that the top twisted orbital density `topDens` is non-negative across all admissible words (`TopDensNonneg`).
Furthermore, `Formalism/HermitianCurvature/BesselNonvanishingReduction.lean:399-475` combines the reproducing-kernel structure `Repro` (`:399-415`), regularized kernel `PhiReg` (`:416-429`), and quadratic convergence `QuadConv` (`:448-471`) to supply the Archimedean Bessel-period nonvanishing reduction `BesselNonvanishingReduction` (`:474-475`).

#### Stage 4: Lattice Herglotz-Fejér Inequality (`Formalism/HermitianCurvature/LatticeHerglotzBound.lean:90-97`)
The bridge carrying local spectral positivity onto algebraic-integer lattice sums of a CM number field is `Formalism/HermitianCurvature/LatticeHerglotzBound.lean:12-166`.
Inside $V(f) := \mathbb{C}^f$, let $\Lambda := \mathrm{La}$ be a discrete $\mathbb{Z}$-lattice with dual lattice $\Lambda^\vee := \mathrm{dualSet}(\Lambda) = \{\sigma \in \mathbb{C}^f \mid \forall z \in \Lambda, \psi(\sigma \cdot z) = 1\}$ (`:25-26`).
Using a vanishing-at-infinity invariant mean `IsMeanInf Λ LIM` (`:45-48`, amenable mean splitting `MeanSplit`, `:79-89`) to verify that the autocorrelation $A(\sigma)$ of the oscillatory remainder beyond the smooth main term is positive definite on $\Lambda^\vee$ (`PDOn (dualSet La) A`, `:29-32`: $\Re \sum_{\sigma, \sigma'} A(\sigma - \sigma') c_\sigma \overline{c_{\sigma'}} \ge 0$ for all finite sums), proposition `LatticeHerglotzBound` (`Formalism/HermitianCurvature/LatticeHerglotzBound.lean:90-97`) establishes for every non-negative semicontinuous integrable function $N : \mathbb{C}^f \to \mathbb{R}_{\ge 0}$ and every finite subset $S \subset z_0 + \Lambda$ inside a single coset:

$$
\mathrm{covol}(\Lambda) \sum_{z \in S} N(z) \le \sum_{\sigma \in \Lambda^\vee} \left\|\widehat{N}(\sigma) + A(\sigma)\right\|
$$

By Bochner-Herglotz positive definiteness, adding the positive-definite correction $A(\sigma)$ to $\widehat{N}(\sigma)$ preserves the lower bound on the pointwise coset sum on the left-hand side of Poisson summation while making the high-frequency tail on the right-hand side converge absolutely (`LatticeSummable`, `:59-62`) against the majorant $m_L(K, L, \sigma) = \prod_v \min(1, (L_v / \|\sigma_v\|)^K)$ (`mfac` and `mL`, `:16-19`, with integral $\prod_v \frac{\pi x_v^2 K}{K-2}$ in `MajIntegralProd`, `:54-58`).

#### Stage 5: Infinite-Place Product Integration `theorem_P_integral_of_places` and Coupling to the Arakelov Height Inequality
Finally, `Formalism/HermitianCurvature/HermitianCurvatureProofs/TheoremPIntegralOfPlaces.lean:801-932` integrates the placewise curvature and Herglotz bounds multiplicatively across all infinite places $v \in \mathrm{InfinitePlace}\,E$ ($f = [E^+ : \mathbb{Q}]$ complex embeddings) of the CM field $E$ (`thmPInt_of_covolume_prod`, `:801-924`), completing the global theorem `theorem_P_integral_of_places` (`:929-932`) and optimal exponent-threshold theorem `jc_theta_exists_variant` (`:73-90`, constructing a positive parameter by raising $\sup \mathrm{thrSet}$ of the finite threshold set $\mathrm{thrSet}$ to the power $-1/f$).

Through the twisted block-trace identities (`glue_cf`, `form_tr`, `rrform_tr`, `ph_tr`) of `Formalism/HermitianCurvature/HermitianCurvatureProofs/BlockRelationTwistedHeight.lean:175-265`, this Archimedean contribution feeds directly into the Arakelov height hub `Formalism/PairingDivisors/StatementH.lean:30-98` (`139` lines, `in_degree = 484`, `dist = 7`).
Specifically, `HeightCore` at `Formalism/PairingDivisors/StatementH.lean:30-43` and `HeightBoundOfLocalValuations` at `:72-98` combine via the Arakelov product formula for a nonzero algebraic theta evaluation $\alpha$ in a number field $K$ the Archimedean log-norm mean `meanInf` (`:13-15`, supplied by Hermitian line-bundle metrics and Green-function cutoffs) with the non-Archimedean finite-prime valuation sum `WtSum` (`:24-29`, supplied by divisibility and shortened evaluation), yielding the global height inequality:

$$
\frac{1}{[K : \mathbb{Q}]} \sum_{\sigma : K \hookrightarrow \mathbb{C}} \log |\sigma(\alpha)| + \frac{1}{[K : \mathbb{Q}]} \sum_{\mathfrak{p} \nmid \infty} v_{\mathfrak{p}}(\alpha)\,\log \mathrm{N}(\mathfrak{p}) = 0 \implies \sum_{\mathfrak{p} \in \mathcal{P}_{\mathrm{target}}} v_{\mathfrak{p}}(\alpha)\,\log \mathrm{N}(\mathfrak{p}) \le h_{\infty}(\alpha) - h_{\mathrm{forced}}(\alpha)
$$

Curvature positivity and `LatticeHerglotzBound` proved in Pillar 3 `HermitianCurvature` form the analytic support guaranteeing that the infinite-place Arakelov metric term $h_{\infty}(\alpha)$ on the right-hand side suffers no unwanted exponential inflation and that regularized cutoff errors drop with a favorable negative sign (tightening the upper bound).

---

## Chapter 5. Deep Anatomy of Pillar 4 `Formalism.PeriodIntegrals` (`4,350` Files · `451,856` Lines · `23,534` Theorems)

### 5.1 Hierarchical Decomposition of the `9` Direct Subpackages and `UnitaryGroupMassFormula` (`3,615` Files)

Pillar 4 `Formalism.PeriodIntegrals` is the period-integral, stabilizer-mass, and projective-lattice-degree engine comprising `4,350` files, `451,856` lines, `23,534` theorems and lemmas, and `9,165` definitions, structures, and other declarations (`32,699` declarations in total).
This pillar exists to overcome a single mathematical obstruction: **precisely canceling the level-denominator loss barrier that accumulates finite-place projection denominators and auxiliary Hecke-character dependencies across $m$ iterated theta lifts, which would otherwise trap the zero-free region at $\sigma = \frac{2}{3}$, and securing a global integrality lower bound**.

The quantitative breakdown of the `9` direct subpackages of `PeriodIntegrals`, followed by the top `12` submodules inside its central spine `UnitaryGroupMassFormula` (accounting for `95.27%` or `430,489` lines of the pillar), is given in the two tables below.

| Rank | Direct Subpackage (`Formalism/PeriodIntegrals/*`) | Files | Lines of Code | Theorems (`thm+lem`) | Defs/Structs/Other | Dedicated Mathematical Engine and Core Role |
| ---: | :--- | ---: | ---: | ---: | ---: | :--- |
| `1` | **`UnitaryGroupMassFormula`** | `3,615` | `430,489` | `22,869` | `6,922` | Siegel-Weil stabilizer volumes (`InVolumesAtOfSWS`), Archimedean product densities (`PiDens`), mass formula |
| `2` | **`(root)` Top-Level Specifications & Bridges** | `328` | `14,912` | `77` | `2,156` | Capelli infinitesimal character (`DSInfCharCap`), Bessel uniqueness (`BesselMapUniq`), projective lattices (`DivisionRows`) |
| `3` | **`OrbitalBoundsConclusion`** | `380` | `4,309` | `464` | `0` | Global convergence assembly of placewise local orbital-integral upper bounds |
| `4` | **`HermitianGenusExtension`** | `11` | `1,236` | `65` | `21` | Hermitian lattice genus extension and local isometric gluing |
| `5` | **`AdmissibleModel`** | `1` | `405` | `28` | `8` | Basis compatibility proofs for admissible representation models |
| `6` | **`ExplicitFormulaCounts` & `4` others** | `15` | `505` | `31` | `58` | Explicit-formula count aggregation, block shapes (`JointBlockShapes`), nabla spans (`NablaSpans`) |
| **Total** | **`PeriodIntegrals` Complete (`9` subpackages)** | **`4,350`** | **`451,856`** | **`23,534`** | **`9,165`** | **Total declarations: `32,699` (`Main.lean` shortest distance `dist = 6` ~ `31`)** |

| Rank | Core Submodule Inside `UnitaryGroupMassFormula/*` | Files | Lines of Code | Theorems (`thm+lem`) | Defs/Structs/Other | Specific Role Within the Mass Formula |
| ---: | :--- | ---: | ---: | ---: | ---: | :--- |
| `1` | **`StabilizerVolume`** | `155` | `19,855` | `789` | `285` | Stabilizer fundamental-domain volumes from Siegel-Weil inputs (`InVolumesAtOfSWS`, `VolStabFromSWS`) |
| `2` | **`StabilizerOrbitVolume`** | `147` | `19,387` | `779` | `278` | Fiber-integral decomposition of stabilizer-orbit quotients (`FibInfEx`) |
| `3` | **`WeilStabilizerVolume`** | `146` | `18,416` | `739` | `281` | Isotropic tuple volumes under Weil-representation normalized gauges (`VolStabFromSWW`) |
| `4` | **`ArchimedeanOrbitMeasures`** | `153` | `18,102` | `731` | `395` | Infinite-place Radon-Nikodym product chart densities (`PiDens.lean`, `dist = 6` direct export) |
| `5` | **`CountingFormula`** | `113` | `12,999` | `661` | `173` | Automorphism-weighted lattice counting formulas in totally definite unitary genera |
| `6` | **`LatticeIndices`** | `95` | `8,970` | `468` | `162` | Exact identities relating sublattice indices $[L : L']$ to local volume ratios |
| `7` | **`LocalUnitaryOrbits`** | `69` | `8,249` | `389` | `108` | Orbit representatives and Hensel-lifting densities on $\mathfrak{p}$-adic unitary groups |
| `8` | **`ValuationLocalVolumes`** | `84` | `8,031` | `395` | `108` | Final standard lattice volume formulas at finite prime valuations (`VolVFinal.lean`) |
| `9` | **`GelfandTsetlinLowering`** | `37` | `5,613` | `301` | `66` | Gelfand-Tsetlin branching rules and lowering-operator normalizations |
| `10` | **`WeightedLimitGauge`** | `41` | `5,500` | `342` | `133` | Lie-algebra Haar gauge limits (`VolumeLieE.lean`, `in_degree = 40`) |
| `11` | **`FockJointMultiplicity`** | `30` | `5,276` | `326` | `107` | Bargmann-Fock space joint multiplicities and theta-kernel polynomial degrees |
| `12` | **`ExplicitFormula` & remaining subfolders** | `2,545` | `309,991` | `17,149` | `4,826` | Primitive prime-factor Euler product convergence, level splitting (`LevelSplitting`), semidirect volumes (`SemidirectVolume`) |

---

### 5.2 Direct Source Inspection and Equation Anatomy of `13` Top-Referenced Core Hubs

The quantitative metrics and source decompilation summaries of `13` top-referenced hubs and top-level export modules inside `PeriodIntegrals` (from atlas `B04`) are listed below.

| Rank | Hub and Output Module (path relative to `src/`) | Lines | `in_deg` | `dist` | Representative Declarations and Mathematical Function |
| ---: | :--- | ---: | ---: | ---: | :--- |
| `1` | `Formalism/PeriodIntegrals/DSInfCharCap.lean` | `47` | `91` | `7` | Agreement `DSInfCharCap` between Capelli quantum determinants and discrete-series infinitesimal characters |
| `2` | `Formalism/PeriodIntegrals/UnitaryGroupMassFormula/StabilizerVolume/InVolumesAtOfSWS.lean` | `27` | `64` | `9` | Stabilizer-volume derivation theorem `inVolumesAt_of_SWS` from Siegel-Weil input `SWXS` |
| `3` | `Formalism/PeriodIntegrals/QuotInv.lean` | `54` | `54` | `7` | Right-invariant Haar quotient-measure uniqueness `QuotInv` and convolution Young inequality `QuotYoung` |
| `4` | `Formalism/PeriodIntegrals/RhsWLim.lean` | `143` | `39` | `11` | Witt-basis stabilizer ball-volume limit existence `WbDataEx`, `RhsWLim` |
| `5` | `Formalism/PeriodIntegrals/UpqRep.lean` | `381` | `38` | `8` | Pseudo-unitary group `UJ ε` closed embedding `UJEmb`, Cayley transform `IsCayleyU`, `IsDSHpk` |
| `6` | `Formalism/PeriodIntegrals/BesselMapUniq.lean` | `61` | `35` | `7` | One-dimensional uniqueness `BesselMapUniq` of Casselman-Wallach smooth Bessel functionals |
| `7` | `Formalism/PeriodIntegrals/DivisionRowsRationalLattice.lean` | `283` | `32` | `11` | Projective lattice degree lower bound `DegreeKernelLowerBound`, `Conclusion4a`, `division_rows_rational_lattice` |
| `8` | `Formalism/PeriodIntegrals/IsLowUnitH.lean` | `150` | `30` | `8` | Gelfand central operator `gelfandOp`, infinitesimal character `HasInfChar`, lowest $K$-type unit vector `IsLowUnitH` |
| `9` | `Formalism/PeriodIntegrals/VolFromSW.lean` | `137` | `17` | `11` | Siegel-Weil mean identity `SWc1` $\implies$ stabilizer equality `VolStabAt` (`volumesFromSW_of`) |
| `10` | `Formalism/PeriodIntegrals/BesselPeriodGGP.lean` | `122` | `6` | `10` | Gan-Gross-Prasad (GGP) period `BesselPeriodGGP` under `InterlacingCondition` |
| `11` | `Formalism/PeriodIntegrals/TwChrOne.lean` | `248` | `2` | `11` | Character triviality `ChrOkL`, `TwChrOne` on twisted parahoric subgroups $Q$ |
| `12` | `Formalism/PeriodIntegrals/TwNormLat.lean` | `250` | `2` | `14` | Boundedness `Bdd` and normal-form matching `TwNormLat` for twisted norm lattices |
| `13` | `Formalism/PeriodIntegrals/UnitaryGroupMassFormula/ArchimedeanOrbitMeasures/PiDens.lean` | `162` | `4` | `6` | Radon-Nikodym chart-density factorization `pi_chart_dens` on finite products (`dist = 6` shortest export) |

The internal source definitions of these principal hubs are verified below.

1. **`UpqRep.lean` · `IsLowUnitH.lean` · `DSInfCharCap.lean` (Pseudo-Unitary Representations and Capelli Infinitesimal Characters)**:
   For a diagonal matrix $J_m(\varepsilon) = \mathrm{diag}(\pm 1)$ (`:10-12`) specified by a sign vector $\varepsilon : \mathrm{Fin}\,n \to \mathrm{Bool}$, `Formalism/PeriodIntegrals/UpqRep.lean:10-120` proves directly that the pseudo-unitary group $U_J(\varepsilon) = \{g \mid g^{\mathrm{H}} J_m(\varepsilon) g = J_m(\varepsilon)\}$ (`:44-73`) forms a closed topological embedding inside $\mathrm{Mat}_n(\mathbb{C})$ (`isClosed_pseudoUnitary` and `isInducing_coeMatrix`, `:101-120`).
   Over this group, `Formalism/PeriodIntegrals/IsLowUnitH.lean:41-84` defines the $k$-th Gelfand central invariant differential operator built from cyclic matrix-unit contractions,

   $$
   \left(\mathrm{gelfandOp}_{\varepsilon, k} F\right)(g) := \sum_{a : \mathrm{Fin}(k+1) \to \mathrm{Fin}\,n} \left(D_{E_{a_0, a_1}} D_{E_{a_1, a_2}} \cdots D_{E_{a_k, a_0}} F\right)(g)
   $$

   (`Formalism/PeriodIntegrals/IsLowUnitH.lean:41-45`), and formalizes `HasInfChar` (`:66-69`), stating that discrete-series matrix coefficients satisfy the eigen-equations $\mathrm{gelfandOp}_{\varepsilon, k} F = c(k)\,F$ for every $k \ge 0$.
   The top-referenced hub `Formalism/PeriodIntegrals/DSInfCharCap.lean:40-46` then guarantees that the universal-enveloping-algebra Capelli central element (quantum determinant) acts on an irreducible discrete-series representation $\sigma$ by the scalar $c_{\mathrm{Cap}}(\lambda)$, supplying the exact eigenvalue consumed by the Capelli Hecke nonvanishing proof (`CompanionTheory/SpectralGeometry/LocalGlobalProofs/StableLattices/HeckeNonVanishing.lean:68-112`) examined in Section 2.2.

2. **`BesselMapUniq.lean` · `BesselPeriodGGP.lean` (One-Dimensional Uniqueness of Bessel Functionals and GGP Period Factorization)**:
   `Formalism/PeriodIntegrals/BesselMapUniq.lean:38-60` declares the local uniqueness proposition `BesselMapUniq` (`:50-60`: for any two Bessel functionals $L, L_0$, $L_0 \ne 0 \implies \exists c \in \mathbb{C}, L = c \cdot L_0$), expressing that the space of Bessel functionals `IsBesselMapSm` (`:38-47`) continuous with respect to the Casselman-Wallach smooth topology (`IsCWCont`, `:32-37`) has dimension at most $1$.
   By this multiplicity-one property, global Bessel periods factor into Euler products of local Bessel integrals, and `Formalism/PeriodIntegrals/BesselPeriodGGP.lean:27-121` equates the local Archimedean Gan-Gross-Prasad (GGP) Bessel period to the discrete-series formal degree `fdegH` (`:85-88`) under Harish-Chandra parameter interlacing `InterlacingCondition` (`:27-31`), `HalfIntegralDifference` (`:32-34`), and spectral gap `GapBig` (`:37-41`) (`BesselPeriodGGP`, `:105-121`).

3. **`QuotInv.lean` · `RhsWLim.lean` (Right-Invariant Quotient Young Inequality and Witt Ball-Volume Limits)**:
   Over a quotient configuration `QuotientSetting` (`:31-34`) for a closed matrix group $G$ and subgroup $H$, `Formalism/PeriodIntegrals/QuotInv.lean:31-51` (`54` lines, `in_degree = 54`, `dist = 7`) formalizes scalar uniqueness `QuotInv` (`:35-40`) of right-invariant quotient measures together with Young's convolution inequality `QuotYoung` (`:41-51`) between $L^2(H \backslash G)$ functions and $L^1(G)$ convolution kernels:

   $$
   \left\| f *_{G} \varphi \right\|_{L^2(H \backslash G)} \le \|f\|_{L^2(H \backslash G)} \cdot \|\varphi\|_{L^1(G)}
   $$

   Called `54` times across `SharpRestriction` and `HermitianCurvature`, this bound guarantees that convolution against smooth Hecke and test kernels never amplifies orbital $L^2$ norms.
   Meanwhile, `Formalism/PeriodIntegrals/RhsWLim.lean:105-142` (`143` lines, `in_degree = 39`) constructs the normalized volume ratio `WbData` (`:118-132`) between base measure `mBase` (`:105-108`) and radius-$\varepsilon$ ball measure `mBall` (`:111-114`) on isotropic Witt-frame stabilizers inside $U(H_{p,k})$, supplying `RhsWLim` (`:137-142`) for convergence as $\varepsilon \to 0^+$ to the Lie-algebra tangent Jacobian limit.

4. **`PiDens.lean` (Radon-Nikodym Product-Density Proof at the Shortest-Distance `dist = 6` Export Gateway)**:
   Consisting solely of four pure tactic theorems rather than `Prop` specifications, `Formalism/PeriodIntegrals/UnitaryGroupMassFormula/ArchimedeanOrbitMeasures/PiDens.lean:11-161` (`162` lines, `dist = 6`) connects directly into `PublishedHypothesesFromPatching.lean` (`dist = 5`).
   - `lintegral_fin_prod` (`:11-43`) and `lintegral_fintype_prod` (`:44-60`): Prove by Tonelli's theorem and induction on `Fin` that for any finite index type $\iota$ (`Fintype ι`) and $\sigma$-finite measures $\mu_i$, the Lebesgue integral of a product-measurable function $\prod_{i \in \iota} f_i(x_i)$ equals the product of individual integrals $\prod_{i \in \iota} \int^- f_i\,d\mu_i$.
   - `withDensity_pi` (`:61-85`): Deduces extensional equality between the product of density-weighted coordinate measures `Measure.pi (fun i => (μ i).withDensity (f i))` and the product-density weighting `(Measure.pi μ).withDensity (fun x => ∏ i, f i (x i))` of the product measure.
   - `pi_chart_dens` (`:86-161`): Establishes that the product of pushforward-pullback measures induced by finitely many Archimedean place charts coincides identically with the global adelic Archimedean orbit measure, factoring the infinite-place term of the mass formula into a product of placewise integrals.

---

### 5.3 The $\sigma = \frac{2}{3}$ Level-Denominator Loss Barrier in Iterated Lifts: Source Reconstruction of Arakelov Projective-Lattice Degree Descent

Opening the source equations of `Formalism/PeriodIntegrals/DivisionRowsRationalLattice.lean:62-251` (`283` lines, `in_degree = 32`) reveals with complete mathematical clarity why naive iterated theta lifts or classical auxiliary-polynomial constructions hit a zero-free barrier at $\sigma = \frac{2}{3}$, and how the archive breaks past it.

#### (1) Denominator-$n$ Loss Formula at a Single Projection Step (`DegreeKernelLowerBound`)
Consider an Arakelov Hermitian lattice $A : \mathrm{HLat}\,K$ over a number field $K$ (with underlying $\mathcal{O}_K$-lattice $L := A.L$, maximal slope $\mu_{\max}(L) := \mathrm{muMaxL}\,A\,L$, and Arakelov degree $\deg(L) := \mathrm{degL}\,A\,L$) together with a self-adjoint idempotent projection $e \in \End_K(A.V)$ ($e^2 = e$).
When $e$ fails to preserve the integral lattice $L$ on the nose and satisfies only $n \cdot e(L) \subseteq L$ for a positive integer denominator $n \in \mathbb{N}_{>0}$ (`IsProj A e n`, `Formalism/PeriodIntegrals/DivisionRowsRationalLattice.lean:62-65`), a finite torsion quotient arises between the kernel-cut lattice $\mathrm{cut}_e(L) := L \cap \ker(1 - e)$ and the projected image lattice $\mathrm{img}_e(L) := e(L)$.
`ProjectionSandwichLength` (`:74-86`) and `GramDetKernelValuation` (`:192-196`) bound the index loss and Gram-determinant valuation growth at each finite place $w$ by

$$
\mathrm{idx}_w\left(\mathrm{img}_e(L),\, \mathrm{cut}_e(L)\right) \le \min\left(\dim e,\, \dim(1 - e)\right) v_w(n), \qquad v_w\left(\det h|_{\mathrm{cut}_e(L)}\right) \le 2\,\dim(1 - e)\,v_w(n)
$$

Summing across all places, `DegreeKernelLowerBound` (`Formalism/PeriodIntegrals/DivisionRowsRationalLattice.lean:87-89`) records the Arakelov degree lower bound after a single projection:

$$
\deg\left(\mathrm{cut}_e(L)\right) \ge \deg(L) - \dim_K(1 - e) \cdot \left(\mu_{\max}(L) + 2\log n\right)
$$

#### (2) Origin of the $\sigma = \frac{2}{3}$ Barrier Under Naive $m$-Fold Sequential Projections
Suppose that along an $m$-step lift chain $U(X_0) \to U(X_1) \to \dots \to U(X_m)$, one applied Hecke/parahoric projections $e_j$ sequentially at each step $j = 1, \dots, m$, allowing both the denominator penalty $2\log n_j$ and the maximal-slope increment $\Delta \mu_{\max}$ to accumulate step by step.
Because at step $j$ the maximal slope $\mu_{\max}(L_j)$ would itself have grown by the prior denominator losses $\sum_{i < j} O(\log x)$, the cumulative Arakelov height loss (finite-place denominator inflation) across all $m$ steps would incur a quadratic cost $\Omega(m^2 \cdot \mathrm{rk} \cdot \log x)$ (or level-product blowup $\Omega(m^3 \log x)$).
Meanwhile, the main-term cancellation gain from $m$-step multiplicity stacking over a window of width $x / m$ scales linearly in $m$.
Balancing the analytic window remainder $x \cdot m^{-1}$ against a quadratic denominator cost $m^2$ yields

$$
\frac{x}{m} \asymp m^2 \iff m \asymp x^{\frac{1}{3}} \implies \text{error exponent } x^{1 - \frac{1}{3}} = x^{\frac{2}{3}} \quad \left(\sigma = \frac{2}{3}\right)
$$

trapping the exponent at $\frac{2}{3}$ and preventing $m$ from ever reaching $\sqrt{x}$.

#### (3) One-Shot Group-Ring Idempotent Cutting `Conclusion4a` · `Conclusion4b` and $2$-Adic Half-Form Elimination `halfForm_int_host`
Lemma 4 (`Conclusion4a` and `Conclusion4b`) at `Formalism/PeriodIntegrals/DivisionRowsRationalLattice.lean:125-160`, together with `L7` and `division_rows_rational_lattice` at `:230-251`, eliminates this quadratic $m^2$ accumulation at a stroke via a **one-shot telescoping decomposition with respect to group-ring elements $\varepsilon(P) \cdot e_G(T)$ of a finite group $G$**.
Relating a base pair $P_0$ and target pair $P$, `Conclusion4a` (`:136-146`) proves that both the degree and the maximal slope of the cut lattice remain within a fixed multiple of the group constant $\lambda_G := \mathrm{laG}(G)$ from the weighted sum of base pieces, completely independent of $m^2$:

$$
\begin{aligned}
\left|\deg\left(\mathrm{cut}_{\varepsilon(P) e_G(T)}(L)\right) - \sum_{s \in T.S} n_S(P, s)\,\deg\left(\mathrm{cut}_{\varepsilon(P_0) e_S(s)}(L)\right)\right| & \le 10\,\lambda_G\,\mathrm{rk}_T(P_0, P, L), \\
\mu_{\max}\left(\mathrm{cut}_{\varepsilon(P) e_G(T)}(L)\right) & \le \mu_{\max}\left(\mathrm{cut}_{\varepsilon(P_0) e_G(T)}(L)\right) + 10\,\lambda_G
\end{aligned}
$$

Thus the maximal slope $\mu_{\max}$ never grows linearly across the $m$ steps, remaining bounded by the base slope plus the fixed additive constant $10\,\lambda_G$ (`:145`), while the total rank-deviation sum across all places is bounded in `Conclusion4b` (`:158`) by $\sum_w l_w \delta_{\mathrm{rk}}(w) \le 8\,\lambda_G\,\mathrm{rk}_T$.
Moreover, leakage of $2^{-1}$ denominators at each step from half-integrality ($\frac{1}{2}\mathbb{Z}$) of quadratic forms at the prime $2$ is eliminated at the root by theorem `halfForm_int_host` (`Formalism/SharpRestriction/Divisibility/WeightFamilies.lean:220-265`, exploiting `D.host.d % 16 = 7` at `:224`), which uses the host discriminant congruence

$$
d \equiv 7 \pmod{16} \implies d + 1 = 4k, \qquad c := \frac{1 + \sqrt{-d}}{2} \in \mathcal{O}_E, \qquad 1 - c = \overline{c}
$$

to force $\beta(y, y) = \beta(c y + \overline{c} y, y) \in 2\mathbb{Z}$ for every lattice vector $y$.

---

### 5.4 The Triple Cancellation Mechanism and Complete Derivation of the Integrality Lower Bound

Even after blocking algebraic slope accumulation in projective lattices, obtaining the pure integrality lower bound $1 \le \prod_v |\alpha|_v$ from the Arakelov product formula across $m \approx \sqrt{x}$ steps still requires canceling (i) conductor distortion from stepwise auxiliary Hecke characters $\mu_j$, (ii) transcendental oscillations of individual CM abelian periods, and (iii) indeterminacy in fundamental-domain volume ratios of unitary stabilizers.
Pillar 4 `PeriodIntegrals`, coupled with `Divisibility`, `ThetaLiftIndependence`, and `PairingDivisors`, completes this via **three exact cancellation identities**.

#### First Cancellation: Rallis Seesaw Identity (`SeeSaw`) and Independence of Bessel Periods from Auxiliary Hecke Characters $\mu$
`Formalism/SharpRestriction/Divisibility/FunctionModelRallisFromInputs.lean:262-629` (`660` lines) proves the core theorems `stmt2c` (`:305-318`) and `stmt3c` (`:566-628`) propagating nonvanishing periods along lift chains of length $m$.
1. **Doubling Integral and Rallis Inner-Product Formula (`points_of_functionModelRallis`, `:466-472`)**:
   For a Hermitian space pair $(A, B)$ ($\mathrm{rk}\,B = \mathrm{rk}\,A + t'$, $t' = P.t + 1$) and split auxiliary Hecke character pair $(\chi, \chi') = (\mu_{j+1}, \mu_{j+1})$ (`IsAuxiliaryHeckeCharacter`, `:510-511`), combining the Piatetski-Shapiro-Rallis doubling integral `dblInt` (`:332-335`) with the Siegel-Weil special value `SWat` (`:336-340`, at the center $s_0 = t'/2$) factors the Petersson inner product of lifted forms $\mathrm{lift}_3(f_1, \varphi_1)$ and $\mathrm{lift}_3(f_2, \varphi_2)$ in `PointsLemma` (`:417-426`) as

   $$
   \left\langle \theta_{\mu_{j+1}}(f_2, \varphi_2),\; \theta_{\mu_{j+1}}(f_1, \varphi_1) \right\rangle_{\mathrm{Pet}, B} = c_{A, B} \cdot \mathrm{be}(\pi; f_1, f_2) \cdot \frac{L^S\left(\frac{t' + 1}{2}, \pi \times \mu_{j+1}\right)}{d_S\left(\frac{t'}{2}\right)} \cdot \prod_{v \in S} Z_v\left(\frac{t'}{2}; f_1, f_2, \varphi_1, \varphi_2\right)
   $$

   The tactic proof `stmt3c` (`Formalism/SharpRestriction/Divisibility/FunctionModelRallisFromInputs.lean:566-628`) uses this factorization to construct a length-$m$ ($m = D.R.m$) definite automorphic lift chain `DefiniteLiftChain` (`:492-500`) in four steps:
   - **Extracting the base representation and auxiliary characters (`:568`)**: Unpacks from `AuxiliaryCharactersExist` a sequence of auxiliary Hecke characters $\mu : \mathbb{N} \to X.\mathrm{Chr}$ together with a step-$0$ base cuspidal representation $\pi_0 \le X.\mathrm{AF}(X_0)$ (`IsLink X P 0 π0`).
   - **Proving the single-step promotion lemma `step` (`:569-599`)**: For any $j < m$ and current chain representation $\pi_j$, `ChainPeriodExistence` supplies vectors $(f_1, f_2)$ and spherical test functions $(\varphi_1, \varphi_2)$ with `rallisRHS ≠ 0` (`hne`, `:572`). Total definiteness `WittIndexCondition` (`hw`: $\mathrm{wittIdx}(X_{j+1}) = 0$) ensures first via `ThetaCuspidalityCondition` that $X.\mathrm{cusp}(X_{j+1}) = \top$, placing lifted images automatically inside the cuspidal subspace (`:583-586`), and second that the degenerate-vanishing hypothesis `V3` (`0 < wittIdx B → ...`) holds vacuously by `Nat.pos_iff_ne_zero` contradiction (`absurd`, `:587-588`). If $\mathrm{lift}_3(f_2, \varphi_2) = 0$, the left-hand Petersson inner product vanishes by `pet_zero_left` (`:563-564`), contradicting $c > 0$ and `rallisRHS ≠ 0` (`:590-594`); hence `ChainLinkExistence` produces a nonzero next-step representation $\pi_{j+1}$ satisfying `IsLink` $\wedge$ `SumLifts` (`:598-599`).
   - **Constructing the $m$-step chain via `Classical.choose` and `Nat.rec` (`:600-609`)**: Defines the step selector `nx j π` and builds the full sequence of submodules $\mathrm{sq} : \forall j, \mathrm{Submodule}\,\mathbb{C}\,(X.\mathrm{AF}(X_j))$ by natural-number recursion `Nat.rec`.
   - **Inductive verification of chain invariants (`:610-628`)**: Applies `induction j` across all $j \le m$ to establish `IsChain X P μ j (sq j)` (`hsq`) and `SumLifts X P μ j (sq j) (sq (j + 1))` (`hsum`), completing an $m$-step theta chain preserving cuspidality and local type `typeX P j` at every step.
2. **Seesaw Duality and Complete Cancellation of Auxiliary Hecke Characters $\mu$ (`stmt2c`, `TwChrOne`, `EigenSwap`)**:
   In the seesaw pair against the opposite indefinite tower $(Y_{j+1}, Y_j)$, `Conclusion2` (`Unfold ∧ SeeSaw`) at `Formalism/SharpRestriction/Divisibility/FunctionModelRallisFromInputs.lean:262-263` establishes the seesaw identity

   $$
   \left\langle \theta_{X_j \to X_{j+1}, \mu_{j+1}}(\Phi', \varphi'),\; F \right\rangle_{X_{j+1}} = \left\langle \varphi',\; \vartheta_{Y_{j+1} \to Y_j, \mu_{j+1}}(\Phi, F) \right\rangle_{X_j}
   $$

   In the actual proof `stmt2c` (`Formalism/SharpRestriction/Divisibility/FunctionModelRallisFromInputs.lean:305-318`), a top-level period nonvanishing hypothesis `hper : PerNZ X P.t (j + 1) ...` is split (`rcases`) into intermediate steps (`j + 1 < D.R.m`, rewriting via Fourier-Jacobi unfolding `adm2b` + `hU`, `:309-312`) and the top boundary step (`j + 1 = D.R.m`, rewriting via top Bessel seesaw `adm2c` + `hS`, `:313-317`), propagating period nonvanishing `PerNZ X P.t j φ' G` downward to the backward theta lift $G = \vartheta(\Phi, F)$.
   To prevent twisting by $\mu_{j+1}$ at ramified places from contaminating finite-level denominators, `TwChrOne` at `Formalism/PeriodIntegrals/TwChrOne.lean:230-247` proves that the twisted character restricts trivially on the parahoric stabilizer subgroup $Q$ ($\chi_L|_Q \equiv 1$), while `TwNormLat` at `Formalism/PeriodIntegrals/TwNormLat.lean:230-249` proves that normalized lattice norms remain bounded uniformly in the choice of $\mu_{j+1}$.
   Furthermore, `ChainScalar` (`:244-252`), `DetSwap` (`:284-293`), and `EigenSwap` (`:294-300`) in `Formalism/ThetaLiftIndependence/Statement.lean:244-300` apply Gaussian-operator adjoint commutation (`GaussOpAdj`, `:278-283`) to prove that $\mu_{j+1}$-dependent factors cancel identically between numerator and denominator in normalized Bessel period ratios and composite determinant eigenvalues.

#### Second Cancellation: Chowla-Selberg Period Formula (`ChowlaSelbergFamily`) and Class-Group Average Euler-Constant Alignment
The second obstruction consists of the transcendental period factor `cmConst` and ideal-class fluctuations appearing when terminal theta forms are evaluated at CM abelian periods.
`Formalism/SharpRestriction/Divisibility/WeightFamilies.lean:493-506` feeds `ChowlaSelbergFamily` (`:493`) into the global `FamP eps` family to derive the Kudla arithmetic family theorem `KudlaFamilyStatement` (`:506`).
Its exact algebraic-analytic coupling equation is written out in `LimitArith` (`:58-65`) and `HeightBoundOfLocalValuations` (`:72-98`) of `Formalism/PairingDivisors/StatementH.lean:48-98`.
Specifically, dividing the 12th power of a theta evaluation $a \in K^\times$ by the modular discriminant power $\Delta^{\mathrm{wt}_M(k, \kappa)}$ ($v_w(\Delta) = -12\,o(w)$, `:79`), the infinite-place norm of the divisor-free ratio $a^{12} \Delta^{-\mathrm{wt}_M(k, \kappa)}$ is given at `:88-89` by

$$
\left\|\sigma_v\left(a^{12}\,\Delta^{-\mathrm{wt}_M(k, \kappa)}\right)\right\| = \frac{\left(\mathrm{cmConst}(d_F, d, k, \kappa)\, L_v\right)^{12}}{D_c\left(\mathrm{cls}(v)\right)^{\mathrm{wt}_M(k, \kappa)}}, \qquad \mathrm{cmConst} = d_F^{\frac{k-1}{2}} \left(\prod_{\tau} \Gamma(k + \kappa_\tau)\right) \left(\frac{2\pi}{\sqrt{d}}\right)^{|\kappa|}
$$

Although the discriminant period $D_c$ fluctuates across individual ideal classes $c \in \mathrm{Cl}$, averaging across the full class group $\mathrm{Cl}$ invokes the Chowla-Selberg formula (`Formalism/PairingDivisors/StatementH.lean:63-64` and `:92-93`):

$$
\frac{1}{|\mathrm{Cl}|} \sum_{c \in \mathrm{Cl}} \log D_c = 12\log(2\pi) - 6\log d + 6\gamma - 6\,\Sigma_p
$$

Here the $(2\pi)^{12}$ and $(\sqrt{d})^{-12}$ terms cancel face to face against $(2\pi / \sqrt{d})^{12|\kappa|}$ inside $\mathrm{cmConst}^{12}$ in the numerator, while the Euler-Mascheroni term $6\gamma$ and prime-logarithm sum $-6\,\Sigma_p$ lock directly onto the $\gamma + \log(2\pi/l)$ main term of the Dirichlet $L$-function logarithmic-derivative period identity $-\frac{L'}{L}(1, \chi)$ (`Formalism/LFunctionBounds/Statement.lean:50-54`) examined in Section 1.4.
All transcendental period factors thus cancel, leaving only the linear height upper bound $((C_\kappa + 1)(6 + 2 C_n) + 4 + \frac{C_f}{4} + 2 C_N)\,|\Phi|\,b\,(L + \log x)$ of `BBSize` (`Formalism/PairingDivisors/StatementH.lean:120-138`).

#### Third Cancellation: Siegel-Weil Theorem (`VolFromSW`) and Fundamental-Domain Equivolume of Unitary Stabilizers (`VolStabAt`)
The third obstruction is uncontrolled growth or distortion of adelic fundamental-domain volumes $\mu(\mathcal{F}_j)$ across the $m$ unitary groups $U(X_j)$ and their isotropic stabilizer subgroups as the rank grows.
`Formalism/PeriodIntegrals/VolFromSW.lean:24-136` (`137` lines) and `Formalism/PeriodIntegrals/UnitaryGroupMassFormula/StabilizerVolume/InVolumesAtOfSWS.lean:13-26` (`27` lines, `in_degree = 64`) resolve this completely.
1. In the Siegel-Weil convergence range $n + 2 \le M$, the Siegel-Weil mean identity `SWc1` at `Formalism/PeriodIntegrals/VolFromSW.lean:24-47` states that the fundamental-domain average `meanC μ 𝓕 (thetaS ...)` of the theta series over Hermitian matrices $T = \mathrm{gram}_E(X)$ equals the product of the infinite-place density $g_\infty(T)$ and the Euler product $\prod_v g_v(T)$ of finite-place local densities:

   $$
   \frac{1}{\mu(\mathcal{F})} \int_{\mathcal{F}} \sum_{X \in E^{n \times M},\; \mathrm{gram}_E(X) = T} \Phi\left(h^{-1} X\right) d\mu(h) = g_\infty(T) \prod_{v \nmid \infty} g_v(T)
   $$

2. Unfolding the left-hand side via orbit-stabilizer measure compatibility `IsCompatT` (`Formalism/PeriodIntegrals/VolFromSW.lean:83-90`) and placewise fiber decomposition `IsOmT` (`:58-82`), then canceling against the local density product on the right-hand side, yields in the conclusion (`:101`) of `VolStabAt` (`Formalism/PeriodIntegrals/VolFromSW.lean:91-102`) the remarkably clean **stabilizer fundamental-domain equivolume identity**:

   $$
   \mu'\left(\mathcal{F}'\right) = \mu\left(\mathcal{F}\right)
   $$

   Across both nondegenerate tuple stabilizers (`VolStab`, `:103-107`) and isotropic tuple stabilizers (`VolumeIsotropicTuple`, `:108-113`), the subgroup stabilizer fundamental-domain volume $\mu'(\mathcal{F}')$ equals the ambient fundamental-domain volume $\mu(\mathcal{F})$ on the nose (`volumesFromSW_of`, `:133-136`; specialized to chains via `inVolumesAt_of_SWS` at `Formalism/PeriodIntegrals/UnitaryGroupMassFormula/StabilizerVolume/InVolumesAtOfSWS.lean:21-26` and finite-place local volume evaluation `volTypV_holds` at `Formalism/PeriodIntegrals/UnitaryGroupMassFormula/ValuationLocalVolumes/VolVFinal.lean:12-15`).
   Coupled with `volumeMass_of_unfolding` in `Formalism/SharpRestriction/GlobalSchurBounds/ThickPlacesCorollaryOfAnyTranslate.lean:2330-2353`, this pins the entire unitary genus mass ratio to an explicit product of special $L$-values.

#### Final Consequence: Integrality Lower Bound at $m \approx \sqrt{x}$ and Completion of the Four-Pillar Closed Loop
Once all three cancellations are combined, any nonzero algebraic theta-period evaluation $\alpha \in K^\times$ ($\alpha \ne 0$ guaranteed by `stmt3c` and `shortNe0_of_t4Span`) is locally integral outside a controlled finite set of denominator primes, so the Arakelov product formula

$$
\sum_{v \mid \infty} \log \|\alpha\|_v + \sum_{w \nmid \infty} \log \|\alpha\|_w = 0 \iff 1 = \prod_{v \mid \infty} \|\alpha\|_v \cdot \prod_{w \nmid \infty} \|\alpha\|_w
$$

yields the global integrality lower bound $\prod_{w \in \mathcal{P}_{\mathrm{forced}}} \|\alpha\|_w^{-1} \le \prod_{v \mid \infty} \|\alpha\|_v \cdot \prod_{w \in \mathcal{P}_{\mathrm{denom}}} \|\alpha\|_w$.
Because the denominator loss $\prod_{w \in \mathcal{P}_{\mathrm{denom}}} \|\alpha\|_w$ is confined within linear bounds free of the $m^2$ blowup behind the $\sigma = 2/3$ barrier, the chain length $m$ can be pushed all the way to its maximal admissible window $m \asymp \sqrt{x}$ (`Formalism/SharpRestriction/InertJacobiLevels/AsmIface.lean:142`).

---

### 5.5 Anatomy of the 31 Data Fields and Final Tactic Proof at the Four-Pillar Terminal Welding Layer (`TieGlobal.lean` · `CoreGm.lean`)

To close this volume, we reconstruct line by line the tactic bodies of `Formalism/SharpRestriction/GlobalSchurBounds/TieGlobal.lean:15-124` (`127` lines, `dist = 8`), where all outputs of the four pillars dissected across Chapters 2 through 5 converge into a single structure `Dd : Data φ.A Word Top m f`, and `Development/AutomorphicArithmetic/PrimitiveCosets/CoreGm.lean:12-74` (`74` lines, `dist = 5`), which derives the final explicit-formula inequality directly above it.

#### (1) Class-Field-Theory Artin Reciprocity Map `recOf` and the Fourfold Tying Predicate (`Formalism/SharpRestriction/GlobalSchurBounds/TieGlobal.lean:24-95`)
`Formalism/SharpRestriction/GlobalSchurBounds/TieGlobal.lean:24-35` defines via the Artin symbol `H.art u` the multiplicative group homomorphism `recOf H` from the conductor unit group $(\mathbb{Z} / H.\mathrm{condN}\,\mathbb{Z})^\times$ of a host primitive-character level $H : \mathrm{HostRaw}\,\varphi$ into the finite abelian group $E_0 \times \varphi.A$ (where $E_0 = \mathbb{Z}/2\mathbb{Z} \times \mathbb{Z}/2\mathbb{Z}$ is the sign group), packaging it into class-field-theory arithmetic data `arithOf H := cftData H.q H.d (recOf H)` (`:34`).

Above this, a concrete instance `Fm.D x (pt u0)` and `Fm.L x (pt u0)` of the parameter family `Fm : FamP eps` is bound via 1-to-1 equalities to **16 global fields (`TieGlobal`, `:50-62`)** and **15 local and Arakelov fields (`TieLocal`, `:63-83`)** of the abstract chain data `Dd`.

| Category | `Dd` Data Fields (`TieGlobal.lean`) | Lines | Bound Source Pillar Values | Supplying Pillar and Mathematical Identity |
| :--- | :--- | ---: | :--- | :--- |
| **`TiePts`** | `toFrame`, `m`, `f`, `q`, `d`, `u0`, `aT`, `bT` | `39-47` | `(Fm.D x (pt u0)).R` and `host` parameters | `SharpRestriction.InertJacobiLevels` (`Formalism/SharpRestriction/InertJacobiLevels/AsmIface.lean:142-145`) |
| **`TieGlobal` `1`** | `Dd.a`, `Dd.b`, `Dd.b'`, `Dd.k`, `Dd.L` | `53-54` | `(Fm.L x (pt u0)).sc` and `R.k` | `SharpRestriction` scale windows (`k ≈ x^(9/2+10ε)`, `m ≈ √x`) |
| **`TieGlobal` `2`** | `Dd.La`, `Dd.B0`, `Dd.Nc` | `54-55` | `(Fm.L x (pt u0)).La`, `B0`, `Nc` | `HermitianCurvature` lattice covolume and box size (`Formalism/HermitianCurvature/LatticeHerglotzBound.lean:90-97`) |
| **`TieGlobal` `3`** | `Dd.gam`, `Dd.LpL` | `56` | `eulerMascheroniConstant`, `logDerivativeAtOne` | `Formalism/StatementOC.lean:20-22` and Chowla-Selberg `Formalism/PairingDivisors/StatementH.lean:63-64` |
| **`TieGlobal` `4`** | `Dd.v`, `Dd.lg`, `Dd.logGam` | `57-59` | `host.v`, `log(g 0 * g 1)`, `log(GamL)` | Archimedean Gamma factors and host prime-pair log size (`LogGammaLe`) |
| **`TieGlobal` `5`** | `Xpp`, `η`, `X'` | `60-61` | `sc.X'' R.n`, `etaSz`, `sc.X'` | Sieve cutoff $X''(n)$ and thick-set density $\eta_{\mathrm{Sz}}$ (`Formalism/SharpRestriction/ParConsts.lean:89`) |
| **`TieLocal` `1`** | `Dd.d`, `Dd.T`, `Dd.h` | `67-71` | `(div.Nu u).rank`, `(mem u).A.T`, `div.h u` | `LocalToGlobal.Divisibility` kernel rank and 6-term explicit height `hExpl6` (`Formalism/SharpRestriction/ParConsts.lean:73`) |
| **`TieLocal` `2`** | `Dd.muN`, `Dd.muMaxN`, `Dd.muM`, `Dd.muMaxM` | `69-73` | `(div.Nu u).mu`, `muMax`, `(fm u).lat 0` | `PeriodIntegrals` projective-lattice Arakelov mean and maximal slopes (`DivisionRows:136-146`) |
| **`TieLocal` `3`** | `Dd.EeJ u0 u j` (`j : Fin m`) | `74-75` | `∑ w ∈ supp, sz w (E u (j+1) w)` | `LocalToGlobal` $m$-step linkwise local index sums (`LinksStage` and `BaseLiftsPackage`) |
| **`TieLocal` `4`** | `Dd.muCC`, `Dd.muMinCC` | `76-77` | `div.RR.muDual`, `div.RR.muMinDual` | Rallis dual-lattice slope lower bounds (`Formalism/SharpRestriction/Divisibility/FunctionModelRallisFromInputs.lean:417-426`) |
| **`TieLocal` `5`** | `Dd.Fo`, `Dd.Ga`, `Dd.Ta`, `Dd.IO`, `Dd.del` | `78-83` | `Fo`, `Ga`, `∑ sz(tau w)`, `∑ lwP * ramIdx * io`, `delp` | Formal degrees (`ThickPlaces:2261`), ramification indices (`LocCoh` and `DataNLoc`), local volumes (`VolFromSW`) |
| **`TieArith`** | `TT`, `T2`, `a`, `w`, `ell` | `84-94` | `TTn`, `dig`, `wj`, `logDerivativeAtOne χ` | Arithmetic matching of automorphic weights `wj` with primitive Dirichlet character log-derivatives `-L'/L(1, χ)` |

#### (2) The Eight Closing Clauses of `ChainTied` and `ChainTied.core_of` (`Formalism/SharpRestriction/GlobalSchurBounds/TieGlobal.lean:97-124`)
Once the fourfold equalities (`TiePts ∧ TieGlobal ∧ TieLocal ∧ TieArith`, `:104-106`) hold, `ChainTied` (`:97-115`) conjoins the error-exponent bounds `C.eDiv ≤ eD`, `C.eLoss ≤ eL`, and `C.cHH ≤ cHH` (`:107`) with seven core chain theorems proved across the four pillars:

1. **`Ident Dd ...` (`:108`)**: Algebraic identity equating automorphic theta evaluation sums with weighted von Mangoldt and character log-derivative sums (output of `LocalToGlobal` + `PeriodIntegrals` triple cancellation).
2. **`LChain.SizeData₂ Dd C Xpp` (`:109`)**: Scale-window verification confirming that all auxiliary lattice ranks, slopes, and volume variables lie inside admissible windows (`SharpRestriction.GrowthBounds`).
3. **`ErrWindows Dd C Xpp eK K` (`:110`)**: Error upper bound confirming that projected Poincaré Gram norms and Archimedean curvature cutoff errors stay below $x^{(e_D + e_L + 3)\varepsilon}$ (`RelevantZeroGramTerms` + `HermitianCurvature`).
4. **`BNBounds Dd T2` (`:111`)**: Cardinality and Brauer-Nesbitt Galois degree upper bounds on the exceptional ramification/jump set `T2` (`ExistsInertiaCharpolyFactorOfTameType`).
5. **`GrowthInequalityRemainingHyps ...` (`:112`)**: Chebyshev-average transition and host log-derivative boundary hypotheses (`ExplicitFormulaErrorOfHostConditions`).
6. **`CostWindows x ...` (`:113`)**: Budget-balance inequality relating thick-prime selection costs to the density parameter $\eta$.
7. **`RestSize eps x ...` (`:114`)**: Residual-size bound showing that combinatorial contributions from complementary subsets decay below $x^{-\varepsilon}$ relative to the main term.

In just five lines of `obtain` + `exact` tactics, theorem `ChainTied.core_of` (`Formalism/SharpRestriction/GlobalSchurBounds/TieGlobal.lean:116-124`) pairs a `ChainTied` witness with the host class-field-theory witness `hF i0` to return a closed witness of type `ChainCore eD eL K cHH eK CL eps x`.

#### (3) Line-by-Line Reconstruction of the Final Seven-Step Deduction in `Development/AutomorphicArithmetic/PrimitiveCosets/CoreGm.lean:12-74`
We now trace by exact line numbers how `UpperTheory.Comparison₂.core_gm` in `Development/AutomorphicArithmetic/PrimitiveCosets/CoreGm.lean:12-74` derives the final inequality from `hE : EAtH Λ H.toHostRaw TT x eps C` and `hCore : CoreAtH H.toHostRaw TT eD eL K cHH eK eps x` (the host projection of `ChainCore`).

1. **Verifying weight boundedness (`Development/AutomorphicArithmetic/PrimitiveCosets/CoreGm.lean:17-20`)**:
   From $\Lambda.o \ge 0$, establishes the coset-weight modulus bound $|(3\,\Lambda.o + 1)^{-1}| \le 1$ via `positivity` and `inv_le_one_of_one_le₀`.
2. **Selecting thresholds $x_1, x_2, x_3$ and taking their maximum (`Development/AutomorphicArithmetic/PrimitiveCosets/CoreGm.lean:21-29`)**:
   - Extracts the chain-deduction threshold $x_1$ from `Deduction.ch_core` (`:21-22`),
   - Extracts the asymptotic-constant threshold $x_2$ from `large_x_eventually` (`:23`),
   - Extracts from `tendsto_rpow_atTop` the threshold $x_3$ enforcing polynomial absorption $1 + 4\,\Lambda.o \le x^\varepsilon$ (`:24-25`),
   and sets the combined starting point to $\max(x_1, \max(x_2, x_3))$ (`:26`).
3. **Unpacking the 36 four-pillar witnesses (`Development/AutomorphicArithmetic/PrimitiveCosets/CoreGm.lean:30-37`)**:
   Applies `obtain` to unpack from `hCore` all 36 existential witnesses (`U0, i0, tr, W, ..., Dd, Cc, Xpp, ell, N, T2, a, w, eT, eP, η, X', θ` together with `hId`, `hLed`, `hWin`, `hBN`, `hSz`, `hThin`, `hCost`, `hRest`, `hT2`), window inequalities `w1` to `w27`, and constant bounds `c1` to `c17`.
4. **Aligning the error exponent (`Development/AutomorphicArithmetic/PrimitiveCosets/CoreGm.lean:51-54`)**:
   Uses `linarith` (`hExp`) to verify that the combined error constant `CErr Cc` satisfies $\mathrm{CErr}(Cc) \le e_D + e_L + 3$, aligning the upper chain error factor to $x^{(e_D + e_L + 3)\varepsilon}$.
5. **Composing top-box deduction `ch_top` and `ch_core` (`Development/AutomorphicArithmetic/PrimitiveCosets/CoreGm.lean:55-60`)**:
   Composes `Deduction.ch_top` with `hExp` across all covering elements $u \in TT$ to obtain the main inequality `hmain`.
6. **Substituting the linear-combination remainder $\Lambda.\mathrm{Gm}(x)$ (`Development/AutomorphicArithmetic/PrimitiveCosets/CoreGm.lean:61-62`)**:
   Rewrites the abstract linear combination into the concrete zeta and Dirichlet remainder sum $\Lambda.\mathrm{Gm}(x)$ via `gmA_eq` (`:61`), combining it with the exceptional sign-term bound `sigA_le` (`:62`).
7. **Closing via the exponent law `x^ε * x^(1/2 + (eD+eL+6)ε)` (`Development/AutomorphicArithmetic/PrimitiveCosets/CoreGm.lean:63-74`)**:
   Multiplies $x^{\frac{1}{2} + (e_D + e_L + 6)\varepsilon}$ (incorporating the $+3\varepsilon$ Chebyshev-averaging transition) by the constant-absorption bound $1 + 4\,\Lambda.o \le x^\varepsilon$ valid for $x \ge x_3$ (`h2`, `Real.rpow_add`, `:65-69`) to obtain

   $$
   (1 + 4\,\Lambda.o)\,x^{\frac{1}{2} + (e_D + e_L + 6)\varepsilon} \le x^\varepsilon \cdot x^{\frac{1}{2} + (e_D + e_L + 6)\varepsilon} = x^{\frac{1}{2} + (e_D + e_L + 7)\varepsilon}
   $$

   closing the kernel proof on the final line `:74` with a single `linarith`:

   $$
   \Lambda.\mathrm{Gm}(x) \le x^{\frac{1}{2} + (e_D + e_L + 7)\varepsilon}
   $$

---

### 5.6 Five-Step Closed-Loop Equation Summary of the Four Pillars and Complete Index of `58` Directly Inspected Modules

The mathematical operating mechanism of the four `Formalism` pillars (`14,866` files, `2,577,937` lines, and `196,578` declarations) decompiled in this third volume condenses into a five-step chain of equations and inequalities.

1. **Pillar 1 (`LocalToGlobal`) $m$-Step Automorphic Multiplicity Stacking**:
   Over the scale window $\sqrt{x\,\delta_1} \le m \le 2\sqrt{x\,\delta_1}$, the composite Gram operator along the totally definite unitary chain $U(X_0) \to \dots \to U(X_m)$ multiplicatively stacks $+1$ layer of positive scalar eigenvalues per step (`thmBop_of`), producing a nonzero algebraic period ratio $\alpha \ne 0$ under derivative-free shortened evaluation `ShortValAt`:

   $$
   \left(\Theta_t \circ \Theta_t^*\right)(e) = \left(\kappa \prod_{j=0}^{m-1} \lambda_{j, t, p, v_0}\right) e, \qquad \det(A) = \kappa^{\dim_{\mathbb{C}} E} \prod_{j=0}^{m-1} \det(B_j)
   $$

2. **Pillar 2 (`SharpRestriction`) Iterated Parseval and Schur Gram Upper Bounds**:
   Without relying on pointwise phase cancellation of Gauss sums, cokernel isomorphism-class orthogonality (`Kk_succ`), mean-square relative trace bounds on the 6-fold metaplectic cover of $\mathrm{GL}_5$ ($5^{-j_0}$ decay), and the C*-continuous-functional-calculus Schur lemma (`schur_UJ`) control the norm of the projected Poincaré Gram operator $K(u, u')$:

   $$
   K_{r+1}(w, w') = \sum_{c \in \mathrm{Cls}_r(M)} \frac{\mathrm{BB}(M; w, c)\,\overline{\mathrm{BB}(M; w', c)}}{|\Aut(c)|}
   $$

3. **Pillar 3 (`HermitianCurvature`) Archimedean Curvature Positivity and Herglotz Bound**:
   The quantum-minor curvature gap $G_f(g) \ge \varepsilon > 0$ together with the kernel `addDecl`-verified compact-cutoff twin generator (`CutCptCopy`) establishes non-negativity of the top spectral density (`TopDensNonneg`), bounding infinite-place lattice sums by positive-definite-corrected Fourier series:

   $$
   0 \le \left\langle \left((\kappa f)\,\Phi\right)(c, g),\; \Phi(c, g) \right\rangle_{\mathrm{HS}}, \qquad \mathrm{covol}(\Lambda) \sum_{z \in S} N(z) \le \sum_{\sigma \in \Lambda^\vee} \left\|\widehat{N}(\sigma) + A(\sigma)\right\|
   $$

4. **Pillar 4 (`PeriodIntegrals`) Breaking the $\sigma = \frac{2}{3}$ Denominator Barrier and Triple Cancellation**:
   One-shot group-ring idempotent telescoping (`Conclusion4a`), $d \equiv 7 \pmod{16}$ half-form elimination (`halfForm_int_host`), Rallis seesaw $\mu$-independence (`stmt2c` and `TwChrOne`), Chowla-Selberg class-group averaging (`LimitArith`), and Siegel-Weil stabilizer fundamental-domain equivolume $\mu'(\mathcal{F}') = \mu(\mathcal{F})$ (`VolStabAt`) compress quadratic $m^2$ denominator accumulation into a linear error $10\,\lambda_G\,\mathrm{rk}_T$.

5. **Top-Level Welding (`TieGlobal` $\to$ `CoreGm`) and Convergence to the Critical Line $\Re(s) = \frac{1}{2}$**:
   Across the global family $\varepsilon \in (0, 1/52)$, the `36` existential witnesses supplied by the four pillars establish the one-sided explicit-formula upper bound

   $$
   \Lambda.\mathrm{Gm}(x) \le x^{\frac{1}{2} + (e_D + e_L + 7)\varepsilon}
   $$

   which in the limit $\varepsilon \to 0^+$ yields zero-freeness of the Riemann zeta function and all primitive Dirichlet $L$-functions on the half-plane $\Re(s) > \frac{1}{2}$.

Finally, the master cross-reference index below catalogs all `58` representative core hub and proof modules directly inspected and decompiled across the chapters of Volume 3 alongside their Part B full-atlas volumes (`B01` to `B04`).

| Chapter | Source File Path and Full Line Span (relative to `src/`) | Lines | `in_deg` | `dist` | Atlas Role | Decompiled Mathematical Objects and Theorems |
| :--- | :--- | ---: | ---: | ---: | :--- | :--- |
| Ch. 1 | `Formalism/Statement.lean:1-50` | `50` | `2` | `9` | Spec Leaf | Chebyshev-weighted remainder `G(x)` and one-sided Landau reduction `RHofG` |
| Ch. 1 | `Formalism/StatementOC.lean:1-73` | `73` | `6` | `8` | Spec Leaf | Dirichlet character remainder `Gchi(x)` and averaged window `OCAvg` |
| Ch. 1 | `Formalism/StatementU.lean:1-47` | `47` | `5` | `10` | Spec Leaf | Discrete window average `wavg` and Mellin-Landau specification `ZetaLandauBarEps` |
| Ch. 1 | `Formalism/StatementCM.lean:1-45` | `45` | `3` | `13` | Spec Leaf | CM half-types `HalfTypes` and forced congruence-class sum `ForcedSumCM` |
| Ch. 1 | `Formalism/StatementFL.lean:1-44` | `44` | `1` | `15` | Spec Leaf | Odd-character family linear combination `famComb` and `FamilyLandauCW3` |
| Ch. 1 | `Development/AutomorphicArithmetic/PrimitiveCosets/CoreGm.lean:1-74` | `74` | `1` | `5` | Top Weld | `EAtH` + `CoreAtH` combined exponent upper bound `core_gm` (`dist = 5`) |
| Ch. 2 | `Formalism/LocalToGlobal/IndefiniteReal/LinksStage.lean:1-315` | `315` | `524` | `7` | `B01` Hub | $m$-step unitary tower `Yc D i`, seesaw pairs, and 19-field `Inputs` |
| Ch. 2 | `Formalism/LocalToGlobal/ProjectiveLattices/AllTest.lean:1-16` | `16` | `452` | `8` | `B01` Hub | Universal projective-lattice test configuration wrapper `AllTest` |
| Ch. 2 | `Formalism/LocalToGlobal/SiegelLatticeTheory/CokernelGLCounts/NGData.lean:1-128` | `128` | `339` | `10` | `B01` Hub | Non-generic orbit Cauchy-Schwarz amplification ratio `a2C` and count bounds |
| Ch. 2 | `Formalism/LocalToGlobal/IndefiniteReal/FWExist.lean:1-803` | `803` | `275` | `8` | `B01` Hub | Frame-Witt basis extension `extB` and top-lattice integrality |
| Ch. 2 | `Formalism/LocalToGlobal/IndefiniteReal/DatumVec.lean:1-214` | `214` | `255` | `7` | `B01` Hub | Adelic pure-tensor test vectors `pureTensorO` and idempotent sum `IsIdemSum` |
| Ch. 2 | `Formalism/LocalToGlobal/IndefiniteReal/ConcretePkgSpec.lean:1-234` | `234` | `226` | `8` | `B01` Hub | Tactic proofs of 30-field `cxLinks` and concrete package `concretePkg_spec` |
| Ch. 2 | `Formalism/LocalToGlobal/IndefiniteReal/BaseLiftsPackageOfPrimitiveLinks.lean:1-367` | `367` | `223` | `7` | `B01` Hub | Phase cancellation `phase_cancel` and $m$-fold Gram eigenvalue product `thmBop_of` |
| Ch. 2 | `Formalism/LocalToGlobal/IndefiniteReal/ZeroPartEigenvalueConvention.lean:1-282` | `282` | `217` | `8` | `B01` Hub | Zero-part eigenvalue phase normalization `Face3` and `WeakCharacterisation` |
| Ch. 2 | `Formalism/LocalToGlobal/IndefiniteForms/IndefiniteTree/RealCubicMeans/LogMeanShares/LogMeanStatements/HSClaim.lean:1-24` | `24` | `208` | `10` | `B01` Hub | Indefinite-tree branching log-mean share inequality `HSClaimS` |
| Ch. 2 | `Formalism/LocalToGlobal/ProjectiveLattices/ThShort.lean:1-355` | `355` | `207` | `9` | `B01` Hub | Derivative-free shortened evaluation `ShortValAt` and nonvanishing span `shortNe0_of_t4Span` |
| Ch. 2 | `Formalism/LocalToGlobal/ProjectiveLattices/FreeBridge.lean:1-120` | `120` | `204` | `9` | `B01` Hub | Equivalence `noCommonZero_iff` between free-lattice presentations and projective abelian sections |
| Ch. 2 | `Formalism/LocalToGlobal/BesselHermitianTheta/AllTied.lean:1-43` | `43` | `197` | `7` | `B01` Hub | 10-field master Bessel-Hermitian-theta tying record `AllTied` |
| Ch. 2 | `Formalism/LocalToGlobal/SiegelLatticeTheory/ClosedLocalOrbits/TermLoc.lean:1-412` | `412` | `190` | `9` | `B01` Hub | Closed local orbit stabilizer mass `MassDat` and `recBBTie_of` |
| Ch. 2 | `Formalism/LocalToGlobal/IndefiniteReal/FinitePlaces/VacExA.lean:1-459` | `459` | `3` | `6` | `B01` Export | Finite-place parahoric vacuum test-vector existence (`dist = 6`) |
| Ch. 2 | `Formalism/LocalToGlobal/IndefiniteReal/LevelTypeEquivalence/UnimodInst.lean:1-292` | `292` | `27` | `6` | `B01` Export | Unimodular Haar measure instance under level-type equivalence (`dist = 6`) |
| Ch. 2 | `Formalism/LocalToGlobal/IndefiniteReal/HeckeNonvanishing/Imports.lean:1-8` | `8` | `45` | `7` | `B01` Tactic | Custom tactic elaborator `kexactB` bypassing higher-order unification |
| Ch. 2 | `CompanionTheory/SpectralGeometry/LocalGlobalProofs/StableLattices/HeckeNonVanishing.lean:1-112` | `112` | `1` | `8` | Companion Proof | Capelli commuting-operator nilpotent-kernel elimination and Hecke nonvanishing `nonVan` |
| Ch. 3 | `Formalism/SharpRestriction/Divisibility/GeneratorPowers/ThExprUniqOfChartIndep2.lean:1-41` | `41` | `873` | `9` | `B02` Hub | Chart-independent prime-power lattice-shift uniqueness (overall #2 hub) |
| Ch. 3 | `Formalism/SharpRestriction/LevelLetterCocycles/LocCoh.lean:1-195` | `195` | `654` | `7` | `B02` Hub | Bloch-Kato crystalline/de Rham cohomology and local Tate duality |
| Ch. 3 | `Formalism/SharpRestriction/LevelLetterCocycles/LocalSituation.lean:1-641` | `641` | `627` | `7` | `B02` Hub | 30-field $p$-adic Galois lifting situation `Sit` and uniform constant |
| Ch. 3 | `Formalism/SharpRestriction/CuspSpanNormBounds/FractionFieldToGenericStalkAlgebraMapEq.lean:1-282` | `282` | `400` | `9` | `B02` Hub | Cokernel isomorphism-class iterated Parseval identity `Kk_succ` |
| Ch. 3 | `Formalism/SharpRestriction/Divisibility/SchurIrreducible.lean:1-617` | `617` | `377` | `7` | `B02` Hub | Discrete-series Blattner parameters and local Archimedean Rallis formula |
| Ch. 3 | `Formalism/SharpRestriction/ParConsts.lean:1-103` | `103` | `224` | `7` | `B02` Hub | Global parameter window `FamP`, literal fixed constants, and `DFamP` (`eps < 1/52`) |
| Ch. 3 | `Formalism/SharpRestriction/CuspSpanNormBounds/RelevantZeroGramTerms.lean:1-573` | `573` | `201` | `7` | `B02` Hub | Fivefold cell decomposition of projected Poincaré Gram operator `Kmat` |
| Ch. 3 | `Formalism/SharpRestriction/InertJacobiLevels/AsmIface.lean:1-221` | `221` | `191` | `7` | `B02` Hub | Parameter scale window `(m, n, k)` and fixation of 5-adic level depth `j0` |
| Ch. 3 | `Formalism/SharpRestriction/GlobalSchurBounds/ThickPlacesCorollaryOfAnyTranslate.lean:1-2354` | `2,354` | `189` | `7` | `B02` Hub | Polynomial two-sided bounds on formal degrees across all unitary groups and unfolding volume ratios |
| Ch. 3 | `Formalism/SharpRestriction/LevelLetterCocycles/DataNLoc.lean:1-1260` | `1,260` | `188` | `7` | `B02` Hub | Wach-Herr $(\varphi, \Gamma)$-lattice `LocLat` and crystalline comparison `LocCmpT` |
| Ch. 3 | `Formalism/SharpRestriction/GlobalSchurBounds/GeneralLinearActions/GenusMassVolumes.lean:1-399` | `399` | `183` | `7` | `B02` Hub | Compatibility `IsCompatible` of Weil, real-place, and orbital measures on CM Hermitian genera |
| Ch. 3 | `Formalism/SharpRestriction/LevelLetterCocycles/ExistsInertiaCharpolyFactorOfTameType.lean:1-1739` | `1,739` | `172` | `8` | `B02` Hub | Brauer-Nesbitt theorem and tame-inertia characteristic-polynomial factor splitting |
| Ch. 3 | `Formalism/SharpRestriction/CuspSpanNormBounds/BridgeCSchur.lean:1-635` | `635` | `29` | `9` | `B02` Proof | Projection-free Schur lemma `schur_UJ` via continuous functional calculus (`CFC`) |
| Ch. 3 | `Formalism/SharpRestriction/ValuationFrobeniusEpsilon/UnitaryThreeHeightBounds.lean:1-982` | `982` | `2` | `15` | `B02` Proof | Polynomial height bounds in Gaussian and inert cases on $U(3)$ Galois deformation rings |
| Ch. 3 | `Formalism/SharpRestriction/RamificationFrobenius/TotientGaloisClasses/ExplicitFormulaErrorOfHostConditions.lean:1-168` | `168` | `10` | `7` | `B02` Export | Character-group linear combination `Gm(y)` and explicit-formula error `EAtH` |
| Ch. 3 | `Formalism/SharpRestriction/GlobalSchurBounds/TieGlobal.lean:1-127` | `127` | `2` | `8` | `B02` Weld | 31-field global/local tying `ChainTied` and `ChainTied.core_of` |
| Ch. 4 | `Formalism/HermitianCurvature/StatementQ.lean:1-1119` | `1,119` | `90` | `10` | `B03` Hub | Quantum minor row expansion `qminorRow` and zeta commutator `ZetaComm` |
| Ch. 4 | `Formalism/HermitianCurvature/WeylElementCommutesLevelOne.lean:1-496` | `496` | `78` | `7` | `B03` Export | Level-1 Weyl element commutativity and regularized pairing output `LemmaBDouble` |
| Ch. 4 | `Formalism/HermitianCurvature/HermitianCurvatureProofs/RegularisedPairingViaPhase.lean:1-897` | `897` | `70` | `11` | `B03` Proof | Reversed Lie-word integration by parts `word_adj` and `phase_function_adjoint` |
| Ch. 4 | `Formalism/HermitianCurvature/HermitianCurvatureProofs/BetaSesquilinearity.lean:1-1532` | `1,532` | `66` | `10` | `B03` Proof | Pseudo-unitary exponential closure `exp_mem` and diagonal/equality limit assembly |
| Ch. 4 | `Formalism/HermitianCurvature/BesselNonvanishingReduction.lean:1-481` | `481` | `60` | `9` | `B03` Hub | Reproducing kernel `Repro` and Archimedean Bessel nonvanishing reduction |
| Ch. 4 | `Formalism/HermitianCurvature/TopDensNonnegOfKappa.lean:1-182` | `182` | `12` | `10` | `B03` Hub | 4-constructor inductive cone `HerGen` and curvature positivity `XKappa` $\implies$ `TopDensNonneg` |
| Ch. 4 | `Formalism/HermitianCurvature/LatticeHerglotzBound.lean:1-167` | `167` | `10` | `13` | `B03` Hub | Invariant-mean splitting `MeanSplit` and lattice Herglotz-Fejér bound |
| Ch. 4 | `Formalism/HermitianCurvature/HermitianCurvatureProofs/TheoremPIntegralOfPlaces.lean:1-935` | `935` | `32` | `11` | `B03` Proof | Smoothness of quantum-minor curvature `Gf` and infinite-place product integration |
| Ch. 4 | `Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptCopy.lean:1-91` | `91` | `1` | `17` | `B03` Meta | Kernel `addDecl`-verified automated generator of compactly supported twin theorems |
| Ch. 4 | `Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptManual.lean:1-551` | `551` | `1` | `17` | `B03` Proof | Compactly supported Cauchy-Schwarz `form_csCpt` and truncated-limit positivity |
| Ch. 5 | `Formalism/PeriodIntegrals/DSInfCharCap.lean:1-47` | `47` | `91` | `7` | `B04` Hub | Scalar agreement between Capelli quantum determinants and discrete-series infinitesimal characters |
| Ch. 5 | `Formalism/PeriodIntegrals/UnitaryGroupMassFormula/StabilizerVolume/InVolumesAtOfSWS.lean:1-27` | `27` | `64` | `9` | `B04` Hub | Stabilizer-volume derivation `inVolumesAt_of_SWS` from Siegel-Weil hypotheses |
| Ch. 5 | `Formalism/PeriodIntegrals/QuotInv.lean:1-54` | `54` | `54` | `7` | `B04` Hub | Right-invariant quotient-measure uniqueness `QuotInv` and convolution Young bound `QuotYoung` |
| Ch. 5 | `Formalism/PeriodIntegrals/BesselMapUniq.lean:1-61` | `61` | `35` | `7` | `B04` Hub | One-dimensional uniqueness of Casselman-Wallach smooth Bessel functionals |
| Ch. 5 | `Formalism/PeriodIntegrals/DivisionRowsRationalLattice.lean:1-283` | `283` | `32` | `11` | `B04` Hub | Projective lattice degree lower bound `DegreeKernelLowerBound` and telescoping `Conclusion4` |
| Ch. 5 | `Formalism/PeriodIntegrals/VolFromSW.lean:1-137` | `137` | `17` | `11` | `B04` Hub | Siegel-Weil mean identity `SWc1` $\implies$ stabilizer equivolume `VolStabAt` |
| Ch. 5 | `Formalism/PeriodIntegrals/UnitaryGroupMassFormula/ArchimedeanOrbitMeasures/PiDens.lean:1-162` | `162` | `4` | `6` | `B04` Export | Product-measure Radon-Nikodym chart-density factorization `pi_chart_dens` (`dist = 6`) |
| Ch. 5 | `Formalism/SharpRestriction/Divisibility/FunctionModelRallisFromInputs.lean:1-660` | `660` | `2` | `14` | Seesaw Weld | Rallis seesaw `stmt2c` and inductive $m$-step definite lift-chain construction `stmt3c` |
| Ch. 5 | `Formalism/PairingDivisors/StatementH.lean:1-139` | `139` | `484` | `7` | Height Weld | Chowla-Selberg class-group average `LimitArith` and Arakelov height bound `BBSize` |

This completes the mathematical forensic decompilation of how the `14,866` files (`2,577,937` lines, `196,578` declarations) of the four `Formalism` pillars ascend from Lie-group curvature, unitary mass formulas, iterated Parseval identities, and theta multiplicity chains to derive the critical-line exponent $\frac{1}{2}$ for the Riemann Hypothesis and Dirichlet Generalized Riemann Hypothesis with `0` user-defined axioms (relying solely on the three standard built-in axioms) and zero exponent loss.
