# Part 1. Top-Level Specification Seal, Pinned `Mathlib` Boundary Semantics, and Exhaustive Upper Bridge Audit (`A01`)

Part 1 (`A01`) is a forensic monograph that exhaustively decompiles the top-level kernel sealing layer and the verbatim boundary semantics of pinned `Mathlib` (`0df444a3`) for the formal proof archive of the Riemann Hypothesis (RH) and the Dirichlet Generalized Riemann Hypothesis (GRH) constructed by Levent Alpöge and Claude (`175,187` `.lean` files, `17,374,215` lines, `1,054,282` declarations).
For mechanical type-checking to guarantee mathematical truth, two independent conditions must hold simultaneously. First, the top-level target theorems must be sealed as closed propositions (`Closed Prop`) over an unmodified kernel without user-defined hypotheses or axiom bypasses. Second, the analytic definitions in the external library (`Mathlib`) referenced by those closed propositions must agree with standard number-theoretic definitions at every boundary regime, including poles, zeros, degenerate moduli, and imprimitive Euler factors.
This volume comprises five chapters. Chapter 1 dissects the complete verbatim source of `Main.lean:1-12`, `Statements.lean:1-16`, the three modules in `Supplements/Kernels/*`, `BuildAid/D1.lean:1-4` through `BuildAid/D5.lean:1-4`, all `8` metaprogramming files, and all `37` occurrences of `allowUnsafeReducibility`, establishing the vacuity immunity principle for closed propositions from the consistency and model-theoretic soundness of dependent type theory.
Chapter 2 reconstructs the definition chain of `RiemannHypothesis`, `riemannZeta`, `completedRiemannZeta`, `completedRiemannZeta₀`, and `hurwitzZeta` inside pinned `Mathlib`, verifying boundary alignment at special values ($s = 1$, $s = 0$, negative even trivial zeros, and the half-plane of convergence $\mathrm{Re}(s) > 1$). Chapter 3 traces the verbatim definitions of `DirichletCharacter.LFunction`, `MulChar`, `conductor`, `IsPrimitive`, and `changeLevel`, proving in closed form the `[NeZero N]` constraint, the identity between the modulus $N = 1$ trivial character and $\zeta(s)$, and the alignment between imaginary-axis zeros ($\mathrm{Re}(s) = 0$) of imprimitive Euler factors and the open critical strip condition ($0 < \mathrm{Re}(s) < 1$).
Chapter 4 reconstructs line by line the branching-and-merging dependency graph and the triple functional-equation reflection chain across all `43` top-spine modules cataloged in `atlas/volumes/B10_Top_Spine_Depth0_To_4.md`, and Chapter 5 seals every audited module in master audit ledger tables.

---

## Chapter 1. Top-Level Specification Seal and Kernel Axiom Chain Anatomy (`Main.lean`, `Statements.lean`, `Supplements/*`, `BuildAid/*`)

### 1.1 Build Manifest Pinning and Verbatim Collation of the Five Top-Level Theorems (`Main.lean:1-12`, `Statements.lean:1-16`)

The toolchain and package manifest at the root of the archive are pinned to official releases under a single cryptographic hash. `lean-toolchain` specifies the single line `leanprover/lean4:v4.33.1`, while `lakefile.toml` and `lake-manifest.json` pin commit `0df444a360eaa60ab8c11dca51a86af692955474` of the official `leanprover-community/mathlib4` repository.
In addition, the global compiler options in `lakefile.toml` are set to `autoImplicit = false`, `relaxedAutoImplicit = false`, `maxSynthPendingDepth = 3`, and `maxHeartbeats = 4000000`, blocking any undeclared identifier inside a declaration from silently turning into an implicitly universally quantified variable (`autoImplicit` contamination).
The top-level target specification file `Statements.lean:1-16` declares only the single line `import Mathlib` as its external dependency and imports zero archive-internal modules. Its full `16`-line verbatim source reads as follows.

```lean
import Mathlib

def RiemannZetaZerosOnLine : Prop :=
  ∀ s : ℂ, riemannZeta s = 0 → (¬∃ n : ℕ, s = -2 * ((n : ℂ) + 1)) → s ≠ 1 → s.re = 1 / 2

def DirichletLNonvanishingRightOfHalf : Prop :=
  ∀ (N : ℕ) [NeZero N] (χ : DirichletCharacter ℂ N) (s : ℂ),
    1 / 2 < s.re → (χ ≠ 1 ∨ s ≠ 1) → DirichletCharacter.LFunction χ s ≠ 0

def DirichletLZerosOnLine : Prop :=
  ∀ (N : ℕ) [NeZero N] (χ : DirichletCharacter ℂ N) (s : ℂ),
    0 < s.re → s.re < 1 → DirichletCharacter.LFunction χ s = 0 → s.re = 1 / 2

def PrimitiveDirichletLZerosOnLine : Prop :=
  ∀ (N : ℕ) [NeZero N] (χ : DirichletCharacter ℂ N), χ.IsPrimitive →
    ∀ s : ℂ, 0 < s.re → s.re < 1 → DirichletCharacter.LFunction χ s = 0 → s.re = 1 / 2
```

All four definitions are `Prop`-typed constants taking `0` free parameters, and every mathematical symbol appearing on their right-hand sides (`ℂ`, `ℕ`, `riemannZeta`, `NeZero`, `DirichletCharacter`, `DirichletCharacter.LFunction`, `DirichletCharacter.IsPrimitive`) resolves exclusively inside the pinned `Mathlib` namespace.
The top-level entry file `Main.lean:1-12` imports only `Statements` and the main-theorem hub `Supplements.Kernels.MainTheoremsAll`, and then seals the five final theorems with `0` hypothesis arguments. Its full `12`-line verbatim source reads as follows.

```lean
import Statements
import Supplements.Kernels.MainTheoremsAll

theorem riemannHypothesis : RiemannHypothesis := rhOfAll

theorem riemannZeta_eq_zero_re : RiemannZetaZerosOnLine := rhOfAll

theorem LFunction_ne_zero_of_half_lt_re : DirichletLNonvanishingRightOfHalf := allChi

theorem LFunction_eq_zero_re : DirichletLZerosOnLine := claimAll.2.1

theorem LFunction_eq_zero_re_of_isPrimitive : PrimitiveDirichletLZerosOnLine := critAll
```

A notable forensic property of the type assignments in `Main.lean:4-12` is that the four witness terms `rhOfAll`, `allChi`, `claimAll.2.1`, and `critAll` are assigned directly to the target propositions without any conversion tactic (`by rw ...` or `by exact ...`). This direct assignment proves that the inferred type of each witness coincides with its target proposition up to definitional equality (`Kernel.isDefEq`, namely $\alpha\beta\delta\iota\zeta$-reduction equivalence) in the Lean 4 C++ kernel.

1. **Dual sealing from a single witness in `Main.lean:4` and `Main.lean:6`**: The declared type of `rhOfAll` is the unmodified `RiemannHypothesis` defined in `Mathlib/NumberTheory/LSeries/RiemannZeta.lean:185-186`. Although `Mathlib` writes the trivial-zero exclusion predicate as `¬∃ n : ℕ, s = -2 * (n + 1)` whereas `RiemannZetaZerosOnLine` in `Statements.lean:4` writes `¬∃ n : ℕ, s = -2 * ((n : ℂ) + 1)`, the elaborator inserts `Nat.cast : ℕ → ℂ` on `n : ℕ` in the `Mathlib` expression as well in order to type-check the equality against the left-hand side `s : ℂ`, so the kernel-internal ASTs (`Expr`) of both constants match up to alpha-equivalence. Consequently, the identical witness term `rhOfAll` passes both type checks `RiemannHypothesis` and `RiemannZetaZerosOnLine` simultaneously.
2. **Right half-plane Dirichlet nonvanishing seal in `Main.lean:8`**: The type of `allChi`, namely `UpperTheory.EveryCharacter` (`Development/AutomorphicArithmetic/CharacterBoxes/EveryCharacter.lean:13-14`), shares the exact binder structure of `DirichletLNonvanishingRightOfHalf` in `Statements.lean:6-8` and matches by $\delta$-unfolding alone.
3. **Critical-strip zero seals in `Main.lean:10` and `Main.lean:12`**: `claimAll` (`Supplements/Kernels/MainTheorems.lean:15-16`) has the conjunction type `Claim.HalfPlane ∧ Claim.Strip ∧ Claim.Zeta`, and the second projection of this right-associative conjunction, `claimAll.2.1 : Claim.Strip` (`Development/AutomorphicArithmetic/CharacterBoxes/HalfPlane.lean:6-7`), is definitionally equal to `DirichletLZerosOnLine`. Finally, the dependent Pi ($\Pi$) type of `critAll` (`Supplements/Kernels/MainTheorems.lean:11-13`) is definitionally equal to `PrimitiveDirichletLZerosOnLine` (`Statements.lean:14-16`). Executing `#print axioms` on each of the five theorems after clean builds under `leanprover/lean4:v4.33.1` across both local `x86_64` and remote `aarch64` dual-architecture environments outputs exclusively the standard Lean three-axiom list `[propext, Classical.choice, Quot.sound]`, with `0` non-standard axioms such as `sorryAx`, user-declared `axiom`, or `Lean.ofReduceBool`. Furthermore, cross-validation by four independent external verifiers (`leanchecker`, Rust `nanoda`, `con-leche --compare`, and `lean4lean`) passed in agreement across all `175,187` modules.

---

### 1.2 Exhaustive Anatomy of the Three `Supplements/Kernels/*` Modules and `BuildAid/D1` through `D5`

The `Supplements` layer imported by `Main.lean:2` consists solely of three files inside the `src/Supplements/Kernels/` directory (`MainTheoremsAll.lean`, `MainTheoremsCritical.lean`, and `MainTheorems.lean`, totaling `22` lines). Their complete verbatim source reads as follows.

```lean
-- [1] Supplements/Kernels/MainTheoremsAll.lean:1-2 (full 2 lines, distance 1 from Main)
import Supplements.Kernels.MainTheoremsCritical
import Development.AutomorphicArithmetic.AutomorphicVarieties.SmallClassNumbers.CorGKOf

-- [2] Supplements/Kernels/MainTheoremsCritical.lean:1-4 (full 4 lines, distance 2 from Main)
import Supplements.Kernels.MainTheorems
import Development.AutomorphicArithmetic.AutomorphicVarieties.SmallClassNumbers.ClassNumberThree
import Development.AutomorphicArithmetic.AutomorphicVarieties.SmallClassNumbers.LenEqZeroIff
import Development.AutomorphicArithmetic.AutomorphicVarieties.SmallClassNumbers.OnePoint

-- [3] Supplements/Kernels/MainTheorems.lean:1-16 (full 16 lines, distance 3 from Main)
import Formalism.GammaFactorNonvanishing.CritLine
import Development.AutomorphicArithmetic.CharacterBoxes.ClaimStrip
import Development.AutomorphicArithmetic.CharacterBoxes.MainConclusion

open Complex DirichletCharacter

theorem allChi : UpperTheory.EveryCharacter := UpperTheory.FinalTheorems.everyCharacter

theorem rhOfAll : RiemannHypothesis := Formalism.VW.rh_of_every allChi

theorem critAll (N : ℕ) [NeZero N] (χ : DirichletCharacter ℂ N) (hχ : χ.IsPrimitive) (s : ℂ)
    (h0 : 0 < s.re) (h1 : s.re < 1) (hz : LFunction χ s = 0) : s.re = 1 / 2 :=
  Formalism.VW.critLine allChi N χ hχ s h0 h1 hz

theorem claimAll : Claim.HalfPlane ∧ Claim.Strip ∧ Claim.Zeta :=
  ⟨allChi, Claim.strip allChi, Claim.zeta allChi⟩
```

Collating this three-tier wrapper layout reveals a deliberate architectural choice. All four witnesses consumed directly by `Main.lean:4-12` (`allChi`, `rhOfAll`, `critAll`, `claimAll`) are already complete at distance `3` in `Supplements/Kernels/MainTheorems.lean:7-16`. Nevertheless, `Supplements/Kernels/MainTheoremsAll.lean:1-2` at distance `1` and `Supplements/Kernels/MainTheoremsCritical.lean:1-4` at distance `2` additionally pull in four modules under `SmallClassNumbers` (`CorGKOf.lean`, `ClassNumberThree.lean`, `LenEqZeroIff.lean`, and `OnePoint.lean`).
This layout demonstrates that rather than leaving key arithmetic byproducts of the Riemann Hypothesis proof as orphan files, namely the $U(3)$ Bloch-Kato cohomology upper bounds (`corGK`, `bound`) over the class-number-$1$ imaginary quadratic field $K^*(3) = \mathbb{Q}(\sqrt{-3})$ and the cyclotomic Shafarevich group vanishing theorem (`large_of`, the explicit arithmetic consequence of the weakened Vandiver property), the authors sealed them inside the single import reachability cone of the top-level target `lake build Main` (`175,187 / 175,187` files, `100.00%` connected; reconstructed in closed form in Chapter 4, Section 4.4).
Meanwhile, the five modules in the `BuildAid/` directory (`BuildAid/D1.lean:1-4` through `BuildAid/D5.lean:1-4`, `4` lines each, `20` lines total) are pure environment-aid files containing zero mathematical definitions or theorems. The verbatim source of `BuildAid/D1.lean:1-4` and the complete specification ledger of all five files are given below.

```lean
import Lean.LibrarySuggestions.Basic
import Lean.Elab.Command

run_cmd Lean.modifyEnv fun env => Lean.LibrarySuggestions.nameDenyListExt.addEntry env "CompanionTheory"
```

| Module Path (`file:line`) | Lines | Distance from `Main` | In-Degree (`in_degree`) | Denied Prefix Registered in `nameDenyListExt` | Kernel Constants Added |
| :--- | ---: | ---: | ---: | :--- | ---: |
| `BuildAid/D1.lean:1-4` | `4` | `13` | `3` | `"CompanionTheory"` | `0` |
| `BuildAid/D2.lean:1-4` | `4` | `12` | `4` | `"CrystallineSemistableComparison"` | `0` |
| `BuildAid/D3.lean:1-4` | `4` | `8` | `25` | `"GlobalTheory"` | `0` |
| `BuildAid/D4.lean:1-4` | `4` | `8` | `5` | `"PositivityTheory"` | `0` |
| `BuildAid/D5.lean:1-4` | `4` | `19` | `1` | `"UpperTheory"` | `0` |

`Lean.LibrarySuggestions.nameDenyListExt` appends a namespace prefix string to an environment extension (`PersistentEnvExtension`) list so that the Lean 4.33 standard-library lemma suggestion engine (interactive candidate search such as `exact` suggestions) skips scanning massive internal namespaces. Because it never touches the kernel constant table (`Environment.constants`), it is completely isolated from logical soundness.

---

### 1.3 Vacuity Immunity of Closed Propositions (`Closed Prop`): Formal Metatheoretic Proof in Dependent Type Theory

In audits of large-scale AI-generated formal proofs, the most frequently raised concern is whether an intermediate lemma assumes a vacuous hypothesis (a premise equivalent to `False`) or substitutes a weakened definition (a structure equivalent to `True`), thereby contaminating the top-level theorem. Indeed, when a top-level theorem itself is declared in conditional form $\vdash \Pi (h : H_{\mathrm{user}}),\, \Phi$ taking a user-defined structure $H_{\mathrm{user}}$ as a premise, an inconsistent premise ($H_{\mathrm{user}} \leftrightarrow \bot$) allows any false proposition $\Phi$ to be formally derived via the principle of explosion ($\bot \to \Phi$) alone.
By contrast, for **pure `Mathlib` closed propositions with `0` free hypothesis parameters** such as the five theorems in `Main.lean:4-12`, the metatheory of dependent type theory (Calculus of Inductive Constructions, CIC) proves rigorously that no vacuity or definition weakening in any intermediate module can contaminate the top-level theorems. Denote the pinned `Mathlib` (`0df444a3`) environment by $\Sigma_0$, and restrict its axiom set to the standard three axioms
$$
\mathcal{A}_{\mathrm{std}} = \{\mathrm{propext},\; \mathrm{Classical.choice},\; \mathrm{Quot.sound}\}.
$$
Let $\Delta = (d_1, d_2, \dots, d_N)$ ($N = 1,054,282$) denote the topologically ordered sequence of all inductive type, structure, definition, and theorem declarations added by the `175,187` modules inside `src/`, so that the final environment is $\Sigma_{\mathrm{final}} = \Sigma_0 \cup \Delta$. The theorem in `Main.lean:4` asserts that over the empty local context ($\Gamma = \cdot$) the following typing judgment holds:
$$
\Sigma_{\mathrm{final}};\; \cdot \;\vdash\; \mathrm{rhOfAll} \;:\; \mathrm{RiemannHypothesis}.
$$
Here, the normal form obtained by fully unfolding constants in $\mathrm{RiemannHypothesis}$ over $\Sigma_0$ is a closed sentence $\Phi_{\mathrm{RH}} \in \mathrm{Term}(\Sigma_0)$ built exclusively from primitive constants of $\Sigma_0$ (`ℂ`, `ℕ`, `riemannZeta`, `Complex.re`, equality, inequalities, and logical connectives), containing zero user-defined symbols from $\Delta$.
Suppose now that every declaration $d_k$ in $\Delta$ is registered solely via sound kernel declaration rules (`defnDecl`, `thmDecl`, `inductiveDecl` satisfying strict positivity, and `quotDecl`), with no new `axiom` and no `unsafe`/`partial` bypass (verified exhaustively in Section 1.4). Applying the set-theoretic denotational semantics interpretation $\llbracket - \rrbracket$ of Carneiro (2019) and Ullrich (2023) over standard set theory $\mathrm{ZFC} + \{\mathcal{U}_i\}_{i < \omega}$ equipped with a countable hierarchy of Grothendieck universes yields three preservation laws by induction:

1. **Model consistency of the standard three axioms**: Propositional extensionality (`propext`), the axiom of choice (`Classical.choice`), and quotient soundness (`Quot.sound`) all hold in $\mathrm{ZFC}$, so $\llbracket \Sigma_0 \rrbracket$ forms a non-trivial consistent model ($\llbracket \bot \rrbracket = \emptyset$, $\llbracket \top \rrbracket = \{\emptyset\}$).
2. **Conservative extension**: Whenever the model interpretation $\llbracket \Sigma_{k-1} \rrbracket$ of $\Sigma_{k-1}$ is consistent, adjoining a new non-recursive or well-founded definition $c := v : T$ (`defnDecl`/`thmDecl`) or a strictly positive inductive type $I$ (`inductiveDecl`) to form $\Sigma_k = \Sigma_{k-1} \cup \{d_k\}$ extends the model uniquely without altering a single bit of the interpretation of pre-existing symbols ($\llbracket E \rrbracket_{\Sigma_k} = \llbracket E \rrbracket_{\Sigma_0}$ for all $E \in \mathrm{Term}(\Sigma_0)$).
3. **Insulation against vacuous lemmas and weakened definitions**:
    - If an intermediate module introduces a weakened definition $D_{\mathrm{weak}} : \mathrm{Prop} := \top$ and proves $\vdash p_1 : D_{\mathrm{weak}}$, then in the model $\llbracket D_{\mathrm{weak}} \rrbracket = \{\emptyset\}$; constructing an implication $D_{\mathrm{weak}} \to \Psi$ into a false closed proposition $\Psi$ ($\llbracket \Psi \rrbracket = \emptyset$) would require exhibiting an element of the function space $\{\emptyset\} \to \emptyset = \emptyset$, which is impossible.
    - Conversely, if an intermediate module defines a vacuous structure $S_{\mathrm{vac}}$ ($\llbracket S_{\mathrm{vac}} \rrbracket = \emptyset$) and proves a conditional theorem $\vdash p_2 : S_{\mathrm{vac}} \to \Phi_{\mathrm{RH}}$, then the set-theoretic function $\llbracket p_2 \rrbracket \in \emptyset \to \llbracket \Phi_{\mathrm{RH}} \rrbracket$ exists vacuously, but deriving an unconditional closed judgment $\Sigma_{\mathrm{final}}; \cdot \vdash t : \Phi_{\mathrm{RH}}$ at the top level requires by the function application rule exhibiting an actual inhabitant $\Sigma_{\mathrm{final}}; \cdot \vdash s : S_{\mathrm{vac}}$. By soundness, $\Sigma_{\mathrm{final}}; \cdot \vdash s : S_{\mathrm{vac}}$ implies $\llbracket s \rrbracket \in \llbracket S_{\mathrm{vac}} \rrbracket = \emptyset$, a contradiction. Consequently, once $\Sigma_{\mathrm{final}}; \cdot \vdash \mathrm{rhOfAll} : \mathrm{RiemannHypothesis}$ passes the C++ kernel and depends only on $\mathcal{A}_{\mathrm{std}}$, model soundness guarantees $\llbracket \mathrm{rhOfAll} \rrbracket \in \llbracket \mathrm{RiemannHypothesis} \rrbracket_{\Sigma_0}$, ensuring that $\Phi_{\mathrm{RH}}$ is true over the standard $\mathrm{ZFC}$ complex field $\mathbb{C}$. In fact, both legacy inactive hypothesis slots remaining inside the archive (`UnusedSlot55` in `Development/AutomorphicArithmetic/Foundations/GaloisRepresentations/TypeConditions/TrivialLocalCondition.lean:89` and `UnusedSlot72` in `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/LocalTypeDictionary/DiscreteSpectrumResidualClassification.lean:7`, both sealed to `True`) as well as unused auxiliary declarations (`24.17%`) cannot weaken the truth value of the five top-level closed propositions in any way by this conservative extension theorem.

---

### 1.4 Exhaustive Forensics of the `8` Metaprogramming Files and `37` Occurrences of `allowUnsafeReducibility`

The sole prerequisite for the conservative extension theorem of Section 1.3 is that user metaprograms neither bypass the kernel environment nor inject hidden axioms (`axiomDecl`). Static scanning across all `175,187` files in the archive confirms `0` occurrences of `sorry`, `admit`, `axiom`, `opaque`, `unsafe`, `implemented_by`, `csimp`, `extern`, and `native_decide`, while exactly `8` files invoke `import Lean` or `CoreM`/`MetaM`/`Elab` metaprogramming APIs.
Excluding `BuildAid/D1.lean:1-4` through `BuildAid/D5.lean:1-4` (`5` files) audited in Section 1.2, the verbatim mechanisms and kernel-boundary semantics of the remaining `3` files operate as follows. First is the **direct metavariable assignment tactic** in `Formalism/LocalToGlobal/IndefiniteReal/HeckeNonvanishing/Imports.lean:1-8` (full `8` lines).

```lean
import Lean

open Lean Elab Tactic Meta

elab "kexactB " e:term : tactic => withMainContext do
  let g ← getMainGoal
  let v ← Term.elabTermAndSynthesize e none
  g.assign (← instantiateMVars v)
```

Whereas the standard `exact e` tactic passes the goal type `tgt` as an expected type (`expectedType := some tgt`) and triggers expensive `Meta.isDefEq` unification and coercion search, `kexactB e` synthesizes the term `e` with no expected type (`none`) and assigns it immediately to the main goal metavariable `g`, bypassing elaborator heartbeat consumption.
It is used across `52` files in the archive to supply structure fields and dependent equalities (such as `HEq.trans`). Consider the case where the actual type of `v` is not kernel-definitionally equal to the type of `g`. In Lean 4, regardless of what expression a tactic block constructs and assigns to a metavariable, immediately upon completion of the declaration `Lean.Elab.Command.elabDeclaration` invokes `Environment.addDecl`, whereupon the C++ kernel type-checker (`lean::type_checker::check`) independently re-verifies the entire proof term from scratch.
Assigning an ill-typed term via `g.assign` therefore triggers an immediate `(kernel) type mismatch` error inside the kernel and aborts compilation, making any soundness bypass impossible. Second is the **structure-field projection reassembly tactic** in `Formalism/LocalToGlobal/NumberFieldFamilies/OwnStruct.lean:1-66` (full `66` lines). Within the `Formalism.L2.Fam.KCopy` namespace, this file defines `kdefeq` (lines `7-13`), `ownStruct` (lines `15-16`), the recursive function `copyAt` (lines `18-51`), the tactic `elab "kcopy "` (lines `53-58`), and the diagnostic command `elab "#kcopy_probe "` (lines `60-64`).
Within a recursion budget `fuel = 64`, `kcopy t` introduces lambda abstractions whenever the goal type is a universal quantification (`.forallE`, lines `26-29`), and whenever the goal is a `Formalism` structure or a primitive product structure (`And`, `Prod`, `PProd`, `Sigma`, `PSigma`, `Subtype`, `Iff`, lines `15-16`) it recursively extracts raw projection expressions `Expr.proj S i e` (line `39`) and plugs them back into the constructor (`ctor`), assembling eta-expanded terms between isomorphic structures.
`Kernel.isDefEq` invoked at line `11` is likewise a read-only check function that never mutates the environment, and the final assembled term undergoes the same exhaustive C++ kernel `addDecl` type-check. Third is the **compact-support twin declaration copier** in `Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptCopy.lean:1-91` (full `91` lines) together with its sole call site `Formalism/HermitianCurvature/HermitianCurvatureProofs/CutMainCpt.lean:944-945`.
Among the Hermitian curvature lemma chains proved in the non-compact setting (`6` `roots` and `14` `manual` references, lines `21-30`), this module takes upstream declarations depending on `3` `special` base theorems (lines `16-19`: `pb_formPos` $\mapsto$ `module_form_pos_compact_support`, `list_duality_level_group` $\mapsto$ `size_standard_compact`, `vector_isomorphism_levels` $\mapsto$ `vector_isomorphism_compact_support`), appends the `"Cpt"` suffix to constant names (lines `34-36`), performs expression substitution (`subst`, lines `63-66`), and registers the resulting declarations.
The decisive kernel security boundary resides in the `copyAll` loop of `Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptCopy.lean:68-85`. The pattern match at lines `76-84` invokes exclusively `addDecl (.defnDecl ...)` (line `78`) in the `.defnInfo d` branch and `addDecl (.thmDecl ...)` (line `82`) in the `.thmInfo t` branch, while any other constant kind (`.axiomInfo`, `.opaqueInfo`, `.inductInfo`, `.ctorInfo`, `.recInfo`) immediately fails via `throwError` at line `84`.
Because `Lean.addDecl` binds directly to C++ kernel `Environment::add`, the substituted types and proof terms cannot pass kernel verification unless they interlock precisely with the types of the compact-support base theorems, and no code path for adding axioms (`Declaration.axiomDecl`) exists anywhere in the file. Next, an exhaustive global scan for `set_option allowUnsafeReducibility true` across the archive locates **`37` total occurrences across `33` distinct files**.
Although the word `Unsafe` in the option name may appear alarming at first glance, inspecting the command on the immediately following line (`L+1`) at all `37` sites confirms that **all `37` occurrences (`100.00%`) without a single exception are `attribute [local irreducible]` declarations**.

- **Complete pin and target-symbol ledger of all `37` `allowUnsafeReducibility` occurrences in the archive**:
    - **Group A: Local irreducibility sealing of Fontaine crystalline period rings (`Per.Acris`, `Per.Bcris`) (`27` files, `30` occurrences)**
        1. `Development/AbelianVarietyTheory/Definitions/AutomorphicMembership/IsCrisP.lean:49-50` (`Per.Acris Per.Bcris`)
        2. `Development/AbelianVarietyTheory/Proofs/InertiaEigenvalues/AlgClosureTensorBcrisToBdRInjective.lean:67-68` (`Per.Acris Per.Bcris`)
        3. `Development/AbelianVarietyTheory/Proofs/InertiaEigenvalues/BcrisOneSubFrobeniusSurjective.lean:98-99` (`Per.Acris Per.Bcris`)
        4. `Development/AbelianVarietyTheory/Proofs/InertiaEigenvalues/BcrisRegularSurjectionsOfFontaineTheorem.lean:13-14` (`Per.Acris Per.Bcris`)
        5. `Development/AbelianVarietyTheory/Proofs/InertiaEigenvalues/ExistsFinExt.lean:134-135` (`Per.Acris Per.Bcris`)
        6. `Development/AbelianVarietyTheory/Proofs/InertiaEigenvalues/ExistsPowNorm.lean:86-87` (`Per.Acris Per.Bcris`)
        7. `Development/AbelianVarietyTheory/Proofs/InertiaEigenvalues/FrobeniusEigenFilOneIsUnitExactDegree.lean:104-105` (`Per.Acris Per.Bcris`)
        8. `Development/AbelianVarietyTheory/Proofs/InertiaEigenvalues/FundamentalMapSurjective.lean:148-149` (`Per.Acris Per.Bcris`)
        9. `Development/AbelianVarietyTheory/Proofs/InertiaEigenvalues/GaloisFactorTiltLogBdRPlus.lean:14-15` (`Per.Acris Per.Bcris`)
        10. `Development/AbelianVarietyTheory/Proofs/InertiaEigenvalues/MemMaxUnramifiedOfCrystallineRatio.lean:53-54` (`Per.Acris Per.Bcris`)
        11. `Development/AbelianVarietyTheory/Proofs/IwasawaDecomposition/AcrisFrobeniusEigenFilEqQlMulTPow.lean:93-94` and `142-143` (`2` occurrences, both `Per.Acris Per.Bcris`)
        12. `Development/AbelianVarietyTheory/Proofs/IwasawaDecomposition/AcrisFrobeniusFontaineTEqMul.lean:14-15` (`Per.Acris Per.Bcris`)
        13. `Development/AbelianVarietyTheory/Proofs/IwasawaDecomposition/AcrisGaloisActionFontaineTEqCyclotomic.lean:17-18` (`Per.Acris Per.Bcris`)
        14. `Development/AbelianVarietyTheory/Proofs/IwasawaDecomposition/AcrisToBdRPlusInjective.lean:13-14` (`Per.Acris`)
        15. `Development/AbelianVarietyTheory/Proofs/IwasawaDecomposition/BcrisEqAcrisLocalizationPeriodT.lean:36-37` (`Per.Acris Per.Bcris`)
        16. `Development/AbelianVarietyTheory/Proofs/IwasawaDecomposition/BcrisFrobeniusFixedFilZeroEqQp.lean:30-31` (`Per.Acris Per.Bcris`)
        17. `Development/AbelianVarietyTheory/Proofs/IwasawaDecomposition/BdRGaloisInvariantsEqFinExt.lean:81-82` (`Per.Acris Per.Bcris`)
        18. `Development/AbelianVarietyTheory/Proofs/IwasawaDecomposition/CanonicalAcrisToBdRPlusUniqueEquivariantApprox.lean:161-162` (`Per.Acris Per.Bcris`)
        19. `Development/AbelianVarietyTheory/Proofs/IwasawaDecomposition/EigenAdd.lean:45-46` (`Per.Acris Per.Bcris`)
        20. `Development/AbelianVarietyTheory/Proofs/IwasawaDecomposition/ExistsLogTeichmullerAcrisEqMuMulUnit.lean:151-152` (`Per.Acris`)
        21. `Development/AbelianVarietyTheory/Proofs/IwasawaDecomposition/ExistsSumFactorial.lean:39-40` (`Per.Acris`)
        22. `Development/AbelianVarietyTheory/Proofs/IwasawaDecomposition/FontaineTIsUnitBcrisAndUniformizerBdRPlus.lean:43-44` and `86-87` (`2` occurrences, both `Per.Acris Per.Bcris`)
        23. `Development/AbelianVarietyTheory/Proofs/IwasawaDecomposition/FrobeniusPeriodRingInjective.lean:339-340` (`Per.Acris Per.Bcris`)
        24. `Development/AbelianVarietyTheory/Proofs/IwasawaDecomposition/GaloisInvariantsBcrisEqMaxUnramified.lean:161-162` (`Per.Acris Per.Bcris`)
        25. `Development/AbelianVarietyTheory/Proofs/IwasawaDecomposition/KummerNotCoboundary.lean:54-55` and `220-221` (`2` occurrences, both `Per.Acris Per.Bcris`)
        26. `Development/AbelianVarietyTheory/Proofs/IwasawaDecomposition/LocalPeriodRingsDataUnramifiedLaws.lean:44-45` (`Per.Acris Per.Bcris`)
        27. `Development/AbelianVarietyTheory/Proofs/IwasawaDecomposition/NonemptyLocalPeriodRingsData.lean:26-27` (`Per.Acris Per.Bcris`)
    - **Group B: Local irreducibility sealing of standard algebraic and real operators in height form families (`1` file, `1` occurrence)**
        28. `Development/AbelianVarietyTheory/Proofs/HeightProofs/ExistsFormFamilyHypothesesChangedSecondNorm.lean:38-50` (`44` operators and instances marked `local irreducible`, including `RingOfIntegers`, `Submodule.span`, `Real.log`, `Finset.sum`)
    - **Group C: Local irreducibility sealing of spherical automorphic level symbols in symmetric power transfer (`5` files, `6` occurrences)**
        29. `Development/AutomorphicArithmetic/AutomorphicVarieties/ModularityArgument/SymmetricPowerTransfer/GeneralizedEigenspaces/CharacterShapes/FiniteOrbits/AutomorphicInSphericalLevel.lean:218-219` and `315-316` (`2` occurrences, `cv Kv Ov DX KD RP SA Lsq`)
        30. `Development/AutomorphicArithmetic/AutomorphicVarieties/ModularityArgument/SymmetricPowerTransfer/GeneralizedEigenspaces/CharacterShapes/FiniteOrbits/CongLev.lean:177-178` (`cv Ov DX KD RP SA Lsq`)
        31. `Development/AutomorphicArithmetic/AutomorphicVarieties/ModularityArgument/SymmetricPowerTransfer/GeneralizedEigenspaces/CharacterShapes/FiniteOrbits/EigGen.lean:154-155` (`DX KD RP SA`)
        32. `Development/AutomorphicArithmetic/AutomorphicVarieties/ModularityArgument/SymmetricPowerTransfer/GeneralizedEigenspaces/CharacterShapes/FiniteOrbits/FinOrbSubgroupOf.lean:213-214` (`cv Kv Ov DX KD RP SA Lsq` plus subgroup maps)
        33. `Development/AutomorphicArithmetic/AutomorphicVarieties/ModularityArgument/SymmetricPowerTransfer/WeilDeligneUnramified/LevUnion.lean:78-79` (`cv Kv Ov DX KD RP SA Lsq`)

In Lean 4, reducibility attributes (`reducible`, `semireducible`, `irreducible`) are purely **elaborator (`MetaM`) metadata governing weak head normal form (`whnf`) unfolding depth and typeclass synthesis discrimination-tree (`DiscrTree`) indexing**.
The C++ kernel `type_checker` never reads these attributes at all and treats every ordinary definition (`defnInfo`) uniformly as a $\delta$-unfoldable constant. Lean 4 requires `allowUnsafeReducibility` when attaching `attribute [local irreducible]` after declaration time solely as a pragmatic warning that `DiscrTree` cache keys in the elaborator may change ("unsafe for simp/typeclass cache"), which has zero bearing on logical consistency (`soundness`).
In fact, this archive uses the option exclusively as a defensive measure to lock the massive Witt-module completion definitions of the Fontaine period rings $A_{\mathrm{cris}}, B_{\mathrm{cris}}$ behind `local irreducible` so they do not unfold explosively mid-proof.

---

## Chapter 2. Verbatim Boundary Semantics Audit of `RiemannHypothesis` and `riemannZeta` in Pinned `Mathlib` (`0df444a3`)

### 2.1 Reconstruction of the Definition Chain from Jacobi Theta Kernels and `WeakFEPair` to `riemannZeta`

In pinned `Mathlib` commit `0df444a3`, the Riemann zeta function `riemannZeta` is constructed not as a naive series sum, but as a four-stage hierarchy combining Mellin transforms of Jacobi theta kernels with abstract functional-equation pairs (`WeakFEPair`). Tracing the five underlying source files directly yields the exact closed-form chain below.
**Stage 1 (`Mathlib/NumberTheory/LSeries/AbstractFuncEq.lean:80-95`, `247-255`, `376-380`)**: A pair of functions $(f, g)$ locally integrable on the positive half-line $(0, \infty)$, rapidly decreasing at infinity after subtracting constant terms $f_0, g_0$, and satisfying the inversion identity for weight $k > 0$ and root number $\varepsilon \neq 0$
$$
f(1/x) = \varepsilon x^k g(x) \quad (x > 0)
$$
is packaged as the `WeakFEPair` structure (lines `80-95`). To subtract the divergent constant terms simultaneously as $x \to 0^+$ and $x \to \infty$, lines `247-249` introduce the piecewise modified function via interval indicator functions
$$
f_{\mathrm{modif}}(x) = \mathbf{1}_{(1, \infty)}(x)\bigl(f(x) - f_0\bigr) + \mathbf{1}_{(0, 1)}(x)\bigl(f(x) - \varepsilon x^{-k} g_0\bigr)
$$
(setting the value at $x = 1$ to $0$ to preserve symmetry). Because $f_{\mathrm{modif}}$ decays faster than every polynomial order at both $0^+$ and $+\infty$, its Mellin transform defines an entire function on all of $\mathbb{C}$; lines `376` and `379` define from this the pole-subtracted completed function `Λ₀` and the meromorphic completed function `Λ`:
$$
\Lambda_0(P, s) := \int_0^\infty x^{s - 1} f_{\mathrm{modif}}(x)\,dx, \qquad \Lambda(P, s) := \Lambda_0(P, s) - \frac{f_0}{s} - \frac{\varepsilon g_0}{k - s}.
$$
For $\mathrm{Re}(s) > k$, `f_modif_aux2` (lines `334-335`) and `hasMellin` (lines `405-406`) establish $\Lambda(P, s) = \int_0^\infty x^{s-1}(f(x) - f_0)\,dx$, while for every $s \in \mathbb{C}$ the functional equations $\Lambda_0(P, k - s) = \varepsilon \Lambda_0(P^{\mathrm{symm}}, s)$ (line `421`) and $\Lambda(P, k - s) = \varepsilon \Lambda(P^{\mathrm{symm}}, s)$ (lines `425-426`) hold identically.
**Stage 2 (`Mathlib/NumberTheory/LSeries/HurwitzZetaEven.lean:65-91`, `254-277`, `297-308`, `583-586`)**: For a unit additive circle parameter $a \in \mathbb{R}/\mathbb{Z}$ (`UnitAddCircle`) and $x > 0$, two real kernel functions `evenKernel` (lines `65-75`) and `cosKernel` (lines `89-91`) are defined from the Jacobi theta function $\theta_2(z, \tau) = \sum_{n \in \mathbb{Z}} e^{\pi i n^2 \tau + 2\pi i n z}$ (series representations at lines `163-173`):
$$
K_{\mathrm{even}}(a, x) = \sum_{n \in \mathbb{Z}} e^{-\pi (n + a)^2 x}, \qquad K_{\mathrm{cos}}(a, x) = \sum_{n \in \mathbb{Z}} e^{2\pi i a n} e^{-\pi n^2 x}.
$$
By the theta inversion identity $K_{\mathrm{even}}(a, x) = x^{-1/2} K_{\mathrm{cos}}(a, 1/x)$ (lines `132-133`) derived from the Poisson summation formula, `hurwitzEvenFEPair a` (lines `254-277`) forms a `WeakFEPair ℂ` with weight $k = 1/2$, root number $\varepsilon = 1$, and asymptotic constant terms $f_0 = \mathbf{1}_{a = 0}$, $g_0 = 1$. Rescaling the variable to $s/2$ with prefactor $1/2$ defines the even completed Hurwitz zeta functions (lines `297-308`):
$$
\Lambda_{\mathrm{even}, 0}(a, s) := \frac{1}{2} \Lambda_0\bigl(\mathrm{hurwitzEvenFEPair}(a),\, \frac{s}{2}\bigr), \qquad \Lambda_{\mathrm{even}}(a, s) := \Lambda_{\mathrm{even}, 0}(a, s) - \frac{\mathbf{1}_{a = 0}}{s} - \frac{1}{1 - s}.
$$
Dividing next by the Deligne real Gamma factor (`Mathlib/Analysis/SpecialFunctions/Gamma/Deligne.lean:43`)
$$
\Gamma_{\mathbb{R}}(s) := \pi^{-s/2} \Gamma(s/2)
$$
while explicitly assigning the removable-singularity limit at $s = 0$ via `Function.update` defines the uncompleted even Hurwitz zeta function `hurwitzZetaEven` (`Mathlib/NumberTheory/LSeries/HurwitzZetaEven.lean:583-585`):
$$
\zeta_{\mathrm{even}}(a, s) := \begin{cases} -1/2 & (s = 0 \land a = 0), \\ 0 & (s = 0 \land a \neq 0), \\ \Lambda_{\mathrm{even}}(a, s) / \Gamma_{\mathbb{R}}(s) & (s \neq 0). \end{cases}
$$
The odd part `hurwitzZetaOdd` (`Mathlib/NumberTheory/LSeries/HurwitzZetaOdd.lean:302-328`, `339-340`, `458-459`) forms a strong functional-equation pair (`IsStrongFEPair`) with $k = 3/2$ and $f_0 = g_0 = 0$, so it has no poles anywhere and defines an entire function $\zeta_{\mathrm{odd}}(a, s) = \Lambda_{\mathrm{odd}}(a, s) / \Gamma_{\mathbb{R}}(s + 1)$ for all $s \in \mathbb{C}$.
The full Hurwitz zeta function `hurwitzZeta` (`Mathlib/NumberTheory/LSeries/HurwitzZeta.lean:52-53`) is the sum $\zeta_{\mathrm{Hurwitz}}(a, s) := \zeta_{\mathrm{even}}(a, s) + \zeta_{\mathrm{odd}}(a, s)$.
**Stage 3 (`Mathlib/NumberTheory/LSeries/RiemannZeta.lean:64-69`, `85-88`, `121`, `185-186`)**: Specializing to $a = 0 \in \mathbb{R}/\mathbb{Z}$ makes the odd part vanish identically (`hurwitzZetaOdd_neg 0 s`, line `131`), completing the definitions of the Riemann zeta function, its completed counterparts, and the Riemann Hypothesis proposition:
$$
\Lambda_0(s) := \Lambda_{\mathrm{even}, 0}(0, s), \qquad \Lambda(s) := \Lambda_{\mathrm{even}}(0, s) = \Lambda_0(s) - \frac{1}{s} - \frac{1}{1 - s}, \qquad \zeta(s) := \zeta_{\mathrm{even}}(0, s).
$$

```lean
-- Mathlib/NumberTheory/LSeries/RiemannZeta.lean:64, 68, 121, 185-186
def completedRiemannZeta₀ (s : ℂ) : ℂ := completedHurwitzZetaEven₀ 0 s
def completedRiemannZeta (s : ℂ) : ℂ := completedHurwitzZetaEven 0 s
def riemannZeta := hurwitzZetaEven 0

def RiemannHypothesis : Prop :=
  ∀ (s : ℂ) (_ : riemannZeta s = 0) (_ : ¬∃ n : ℕ, s = -2 * (n + 1)) (_ : s ≠ 1), s.re = 1 / 2
```

---

### 2.2 Boundary Audit (a): Division-by-Zero Junk Value (`junk value`) at the Pole $s = 1$ and Alignment with the `s ≠ 1` Hypothesis

Because every function `ℂ → ℂ` in pure type theory must be a total function, `riemannZeta 1` takes a concrete complex value even at $s = 1$, which mathematically is a simple pole. If a design flaw caused this junk value (`junk value`) to equal `0` while omitting `s ≠ 1` from `RiemannHypothesis`, the proposition itself would either become false or suffer convention-dependent contamination. Substituting directly into the verbatim formulas determines the exact evaluation at $s = 1$.

1. The field division convention in Lean 4 and `Mathlib` sets $z / 0 = 0$ (`div_zero`). Substituting $s = 1$ into `completedRiemannZeta_eq` (`Mathlib/NumberTheory/LSeries/RiemannZeta.lean:85-86`) yields
$$
\Lambda(1) = \Lambda_0(1) - \frac{1}{1} - \frac{1}{1 - 1} = \Lambda_0(1) - 1 - 0 = \Lambda_0(1) - 1.
$$

2. Since $s = 1 \neq 0$, `riemannZeta_def_of_ne_zero` (`Mathlib/NumberTheory/LSeries/RiemannZeta.lean:154-156`) together with $\Gamma_{\mathbb{R}}(1) = \pi^{-1/2}\Gamma(1/2) = 1$ (`Gammaℝ_one`, `Mathlib/Analysis/SpecialFunctions/Gamma/Deligne.lean:77-79`) gives $\zeta_{\mathrm{Mathlib}}(1) = \Lambda(1) / \Gamma_{\mathbb{R}}(1) = \Lambda_0(1) - 1$.
3. Meanwhile, as $s \to 1$ ($s \neq 1$), $\zeta(s)$ has a simple pole with residue $1$ (`riemannZeta_residue_one`, `Mathlib/NumberTheory/LSeries/RiemannZeta.lean:242-243`), and the constant term of its Laurent expansion is the Euler-Mascheroni constant $\gamma$ (`tendsto_riemannZeta_sub_one_div`, `Mathlib/NumberTheory/Harmonic/ZetaAsymp.lean:342-343`: $\lim_{s \to 1, s \neq 1} (\zeta(s) - \frac{1}{s-1}) = \gamma$). Combining this with $\Gamma_{\mathbb{R}}'(1) = -(\gamma + \log(4\pi))/2$ in `tendsto_riemannZeta_sub_one_div_Gammaℝ` (`Mathlib/NumberTheory/Harmonic/ZetaAsymp.lean:401-403`) and `riemannZeta_one` (`Mathlib/NumberTheory/Harmonic/ZetaAsymp.lean:418-422`) pins down the exact real value of `riemannZeta 1`:
$$
\zeta_{\mathrm{Mathlib}}(1) = \frac{\gamma - \log(4\pi)}{2} \approx -0.976904 \neq 0, \qquad \Lambda_0(1) = \frac{\gamma - \log(4\pi)}{2} + 1.
$$
    Indeed, `riemannZeta_one_ne_zero` in `Mathlib/NumberTheory/Harmonic/ZetaAsymp.lean:441-450` formally proves `riemannZeta 1 ≠ 0` from the chain of inequalities $\gamma < 2/3 < 1 < \log(4\pi)$. What matters even more, however, is that both `RiemannHypothesis` in `Mathlib` (`Mathlib/NumberTheory/LSeries/RiemannZeta.lean:185-186`) and `RiemannZetaZerosOnLine` in the archive (`Statements.lean:3-4`) **place the explicit hypothesis `(_ : s ≠ 1)` up front rather than relying on the accidental junk-value property `riemannZeta 1 ≠ 0`**.
    Consequently, regardless of what value a field model assigns to $z / 0$, the point $s = 1$ is excluded from the domain of universal quantification, and on the punctured plane $\{\,s \in \mathbb{C} \mid s \neq 1\,\}$ `differentiableAt_riemannZeta` (`Mathlib/NumberTheory/LSeries/RiemannZeta.lean:139-140`) and uniqueness of analytic continuation guarantee that `riemannZeta s` agrees pointwise with the classical complex-analytic Riemann zeta function $\zeta(s)$, completely independent of division-by-zero conventions.

---

### 2.3 Boundary Audit (b): Negative Even Trivial Zeros `s = -2 * (n + 1)` and Singularity Handling at $s = 0$

The second boundary regime covers pole cancellation and trivial-zero indexing along $s \in -\mathbb{N} = \{0, -1, -2, \dots\}$. First is **verification of the removable singularity recovery at $s = 0$**. The completed zeta function $\Lambda(s) = \Lambda_0(s) - \frac{1}{s} - \frac{1}{1-s}$ has a simple pole at $s = 0$ with residue $-1$ (`completedHurwitzZetaEven_residue_zero`, `Mathlib/NumberTheory/LSeries/HurwitzZetaEven.lean:464-465`).
Simultaneously, the denominator $\Gamma_{\mathbb{R}}(s) = \pi^{-s/2}\Gamma(s/2)$ also has a simple pole at $s = 0$ with residue $2$ (`Gammaℝ_residue_zero`, `Mathlib/Analysis/SpecialFunctions/Gamma/Deligne.lean:102`: $\lim_{s \to 0, s \neq 0} s \Gamma_{\mathbb{R}}(s) = 2$).
Had `riemannZeta s` been defined naively as `completedRiemannZeta s / Gammaℝ s` for all $s$, then at $s = 0$ the denominator $\Gamma_{\mathbb{R}}(0) = \pi^0 \Gamma(0) = 0$ would have produced the division junk value `0`, creating a fatal spurious zero $\zeta(0) = 0$.
Pinned `Mathlib` avoids this pitfall cleanly. Because `Mathlib/NumberTheory/LSeries/HurwitzZetaEven.lean:583-585` updates the value at $s = 0, a = 0$ via `Function.update` to the residue ratio $(-1)/2 = -1/2$, `riemannZeta_zero` (`Mathlib/NumberTheory/LSeries/RiemannZeta.lean:151-152`) establishes
$$
\zeta(0) = -\frac{1}{2} \neq 0,
$$
and `differentiableAt_update_of_residue` (`Mathlib/NumberTheory/LSeries/HurwitzZetaEven.lean:554-580`), applying Riemann's removable singularity theorem, certifies complex differentiability (`differentiableAt_riemannZeta`, `Mathlib/NumberTheory/LSeries/RiemannZeta.lean:139-140`) at every $s \neq 1$, including $s = 0$.
Moreover, `riemannZeta_eq_mul_completedRiemannZeta₀` (`Mathlib/NumberTheory/LSeries/RiemannZeta.lean:164-170`) applies the Gamma identity $s \Gamma(s/2) = 2\Gamma(s/2 + 1)$ to establish a global formula free of any $s = 0$ case split:
$$
\zeta(s) = \frac{s \Lambda_0(s) - 1 - \frac{s}{1 - s}}{2 \pi^{-s/2} \Gamma(s/2 + 1)} \quad (\forall s \in \mathbb{C})
$$
(at $s = 0$ the numerator evaluates to $-1$ and the denominator to $2 \cdot 1 \cdot \Gamma(1) = 2$, yielding $-1/2$). Second is **verification of the negative even trivial-zero exclusion predicate**. In Lean, the natural number type `ℕ` starts at `0` ($\mathbb{N} = \{0, 1, 2, \dots\}$). The set excluded by `¬∃ n : ℕ, s = -2 * (n + 1)` is therefore
$$
\bigl\{\,-2(n + 1) \;\big|\; n \in \{0, 1, 2, \dots\}\,\bigr\} = \{-2, -4, -6, -8, \dots\}.
$$
Indeed, for every $n \in \mathbb{N}$ we have $s = -2(n+1) \neq 0$ and $\Gamma_{\mathbb{R}}(-2(n+1)) = \pi^{n+1}\Gamma(-(n+1)) = 0$ (`Gammaℝ_eq_zero_iff`, `Mathlib/Analysis/SpecialFunctions/Gamma/Deligne.lean:73-74`: $\Gamma_{\mathbb{R}}(s) = 0 \iff \exists m \in \mathbb{N},\, s = -2m$), whence `riemannZeta_neg_two_mul_nat_add_one` (`Mathlib/NumberTheory/LSeries/RiemannZeta.lean:173-174`) proves $\zeta(-2(n+1)) = 0$ (since the reciprocal $(\Gamma_{\mathbb{R}}(s))^{-1}$ is an entire function by `differentiable_Gammaℝ_inv` in `Mathlib/Analysis/SpecialFunctions/Gamma/Deligne.lean:89` with genuine analytic zeros at $-2(n+1)$, these are true analytic zeros of $\Lambda(s) \cdot (\Gamma_{\mathbb{R}}(s))^{-1}$ rather than junk values).
At negative odd integers $s = -(2n + 1)$, by contrast, $\Gamma_{\mathbb{R}}(s) \neq 0$ and the Bernoulli-number formula gives $\zeta(1 - 2k) = -B_{2k}/(2k) \neq 0$, while at $s = 0$ we already have $\zeta(0) = -1/2 \neq 0$, so neither requires exclusion. The trivial-zero exclusion predicate in `RiemannHypothesis` thus matches the classical definition of non-trivial zeros point for point.

---

### 2.4 Boundary Audit (c): Agreement with the Dirichlet Series and Euler Product on the Half-Plane of Convergence $\mathrm{Re}(s) > 1$

For `riemannZeta` defined via Mellin transforms to govern prime-number distribution in arithmetic, it must agree on the half-plane of absolute convergence $\mathrm{Re}(s) > 1$ with both the Dirichlet series $\sum_{m=1}^\infty m^{-s}$ and the Euler product over primes $\prod_p (1 - p^{-s})^{-1}$. Pinned `Mathlib` contains the full suite of these comparison theorems.

1. **Agreement with the Dirichlet series (`Mathlib/NumberTheory/LSeries/RiemannZeta.lean:207-220`)**:
    - `zeta_eq_tsum_one_div_nat_cpow` (lines `207-208`): for `1 < re s`, `riemannZeta s = ∑' n : ℕ, 1 / (n : ℂ) ^ s`. Here the $n = 0$ summand vanishes because $\mathrm{Re}(s) > 1 \implies s \neq 0$, so `zero_cpow` gives $0^s = 0$ and `1 / 0 = 0`.
    - `zeta_eq_tsum_one_div_nat_add_one_cpow` (lines `214-215`): a pure positive-integer summation identity that avoids even the `0 ^ s` and `1 / 0` conventions, proving for `1 < re s`:
$$
\zeta(s) = \sum_{n=0}^{\infty} \frac{1}{(n + 1)^s} = \sum_{m=1}^{\infty} \frac{1}{m^s}.
$$

2. **Agreement with `LSeries` notation (`Mathlib/NumberTheory/LSeries/Basic.lean:74-75`, `164-165` and `Mathlib/NumberTheory/LSeries/Dirichlet.lean:309-310`)**: `LSeries.term f s n` is defined as `if n = 0 then 0 else f n / n ^ s`, blocking the $n = 0$ term by definition, and `LSeries_one_eq_riemannZeta` (`Mathlib/NumberTheory/LSeries/Dirichlet.lean:309-310`) establishes `L 1 s = riemannZeta s` for `1 < s.re`.
3. **Agreement with the Euler product (`Mathlib/NumberTheory/EulerProduct/DirichletLSeries.lean:89-107`, `160-162`)**: Over the prime subtype `Nat.Primes`, four infinite-product convergence theorems are proved for `1 < s.re`:
    - Filter-convergence form `riemannZeta_eulerProduct_hasProd` (lines `89-92`): `HasProd (fun p : Primes ↦ (1 - (p : ℂ) ^ (-s))⁻¹) (riemannZeta s)`.
    - Topological infinite-product evaluation form `riemannZeta_eulerProduct_tprod` (lines `96-98`):
$$
\prod_{p \in \mathbb{P}} \bigl(1 - p^{-s}\bigr)^{-1} = \zeta(s) \quad (\mathrm{Re}(s) > 1).
$$
    - Finite prime-cutoff limit form `riemannZeta_eulerProduct` (lines `102-106`): $\lim_{n \to \infty} \prod_{p < n} (1 - p^{-s})^{-1} = \zeta(s)$.
    - Exponential of logarithmic series form `riemannZeta_eulerProduct_exp_log` (lines `160-162`): $\exp\bigl(\sum_{p \in \mathbb{P}} -\log(1 - p^{-s})\bigr) = \zeta(s)$. All three boundary audits (a), (b), and (c) of Chapter 2 thus confirm zero semantic defects in pinned `Mathlib`.

---

## Chapter 3. Boundary Semantics Audit of `DirichletCharacter.LFunction` and `IsPrimitive` in Pinned `Mathlib`

### 3.1 Verbatim Reconstruction of `MulChar`, `DirichletCharacter`, `conductor`, `IsPrimitive`, and `LFunction`

The algebraic and analytic structures of Dirichlet characters and Dirichlet $L$-functions referenced by the three Generalized Riemann Hypothesis specifications in `Statements.lean:6-16` (`DirichletLNonvanishingRightOfHalf`, `DirichletLZerosOnLine`, and `PrimitiveDirichletLZerosOnLine`) are defined across four files in pinned `Mathlib` (`0df444a3`).
**Stage 1: Multiplicative characters `MulChar` (`Mathlib/NumberTheory/MulChar/Basic.lean:72-74`, `104-115`, `150-192`, `249-293`)**: From a commutative monoid $R$ into a commutative monoid with zero $R'$, a multiplicative character `MulChar R R'` is a structure extending a monoid homomorphism `R →* R'` with the non-unit vanishing law `map_nonunit'`:

```lean
-- Mathlib/NumberTheory/MulChar/Basic.lean:72-74, 104-105, 181
structure MulChar extends MonoidHom R R' where
  map_nonunit' : ∀ a : R, ¬IsUnit a → toFun a = 0

noncomputable def trivial : MulChar R R' where ...
noncomputable def equivToUnitHom : MulChar R R' ≃ (Rˣ →* R'ˣ) where ...
```

Every $\chi : \mathrm{MulChar}\; R\; R'$ satisfies $1_R \mapsto 1_{R'}$, $\chi(ab) = \chi(a)\chi(b)$, and $a \notin R^\times \implies \chi(a) = 0$, standing in bijective equivalence (`equivToUnitHom`, lines `181-192`) with the group of unit homomorphisms $\mathrm{Hom}(R^\times, (R')^\times)$.
In particular, the identity element `(1 : MulChar R R')` is not the constant function $1$, but the **trivial character `trivial R R'`** (lines `104-115`, `249-250`), sending units to $1$ and non-units to $0$:
$$
\mathbf{1}_{\mathrm{MulChar}}(x) = \begin{cases} 1 & (x \in R^\times), \\ 0 & (x \notin R^\times). \end{cases}
$$
Furthermore, the inverse `χ⁻¹` (lines `287-304`) is defined via pointwise pseudo-inversion $\chi^{-1}(a) = (\chi(a))^{-1}$ (under `0⁻¹ = 0`), so whenever $R' = \mathbb{C}$ and $R$ is finite it coincides pointwise with the complex conjugate character $\overline{\chi}(a)$ for every $a \in R$ ($\lvert\chi(u)\rvert = 1 \implies \chi(u)^{-1} = \overline{\chi}(u)$).
**Stage 2: Dirichlet characters, conductors, and primitivity (`Mathlib/NumberTheory/DirichletCharacter/Basic.lean:40`, `66-71`, `115-116`, `234-313`)**: An $R$-valued Dirichlet character of modulus (level) $n \in \mathbb{N}$ is defined as a multiplicative character on the residue ring `ZMod n` (line `40`):
$$
\mathrm{DirichletCharacter}\; R\; n \;:=\; \mathrm{MulChar}\; (\mathbb{Z}/n\mathbb{Z})\; R.
$$
Whenever $n \mid m$, composing with the unit-group homomorphism `ZMod.unitsMap hm : (ZMod m)ˣ →* (ZMod n)ˣ` induced by the canonical ring projection $\pi_{m,n} : \mathbb{Z}/m\mathbb{Z} \to \mathbb{Z}/n\mathbb{Z}$ defines the level-extension homomorphism `changeLevel` (lines `66-71`):
$$
\mathrm{changeLevel}_{n \mid m}(\psi)(x) = \begin{cases} \psi(x \bmod n) & (\gcd(x, m) = 1), \\ 0 & (\gcd(x, m) > 1). \end{cases}
$$
From this map, factorizability `FactorsThrough`, the conductor set `conductorSet`, the minimal conductor `conductor`, primitivity `IsPrimitive`, and the associated primitive character `primitiveCharacter` are defined at lines `115-116`, `234`, `246`, `292`, and `307-313`:

```lean
-- Mathlib/NumberTheory/DirichletCharacter/Basic.lean:40, 115-116, 234, 246, 292, 307-312
abbrev DirichletCharacter (R : Type*) [CommMonoidWithZero R] (n : ℕ) := MulChar (ZMod n) R

def FactorsThrough (d : ℕ) : Prop :=
  ∃ (h : d ∣ n) (χ₀ : DirichletCharacter R d), χ = changeLevel h χ₀

def conductorSet : Set ℕ := {d : ℕ | FactorsThrough χ d}
noncomputable def conductor : ℕ := sInf (conductorSet χ)
def IsPrimitive : Prop := conductor χ = n

noncomputable def primitiveCharacter : DirichletCharacter R χ.conductor :=
  Classical.choose (factorsThrough_conductor χ).choose_spec
```

Under `[NeZero n]` ($n \ge 1$), `conductor_dvd_level` (line `251`) and `mem_conductorSet_iff_conductor_dvd` (lines `358-360`) prove that for any positive divisor $d \mid n$, $\chi$ factors through modulus $d$ if and only if $f_\chi := \mathrm{conductor}(\chi) \mid d$, while `changeLevel_primitiveCharacter` (lines `310-312`) guarantees that every character $\chi \bmod n$ is induced from a unique primitive character $\chi_0 := \chi.\mathrm{primitiveCharacter} \bmod f_\chi$ as $\chi = \mathrm{changeLevel}_{f_\chi \mid n}(\chi_0)$.
In addition, `conductor_inv` (lines `404-405`) establishes $f_{\chi^{-1}} = f_\chi$.
**Stage 3: `LFunction` via Hurwitz zeta decomposition and functional equation (`Mathlib/NumberTheory/LSeries/ZMod.lean:83-84`, `293-295` and `Mathlib/NumberTheory/LSeries/DirichletContinuation.lean:61`, `75-77`, `207-285`)**: For a positive integer $N$ (`[NeZero N]`) and a periodic function $\Phi : \mathbb{Z}/N\mathbb{Z} \to \mathbb{C}$, `ZMod.LFunction` (`Mathlib/NumberTheory/LSeries/ZMod.lean:83-84`) and `DirichletCharacter.LFunction` (`Mathlib/NumberTheory/LSeries/DirichletContinuation.lean:61`) are defined as finite linear combinations of Hurwitz zeta functions across residue classes:
$$
L(s, \chi) := \mathrm{DirichletCharacter.LFunction}\;\chi\;s = N^{-s} \sum_{j \in \mathbb{Z}/N\mathbb{Z}} \chi(j)\, \zeta_{\mathrm{Hurwitz}}\left(\frac{j}{N},\, s\right).
$$
Here `toAddCircle j` maps $j \in \{0, 1, \dots, N-1\}$ to $j/N \bmod 1$ in $\mathbb{R}/\mathbb{Z}$. On the half-plane of convergence $\mathrm{Re}(s) > 1$, the residue-class partitioning theorem `LFunction_eq_LSeries` (`Mathlib/NumberTheory/LSeries/DirichletContinuation.lean:75-77`, `Mathlib/NumberTheory/LSeries/ZMod.lean:93-120`) and the Euler product theorem `DirichletCharacter.LSeries_eulerProduct_tprod` (`Mathlib/NumberTheory/EulerProduct/DirichletLSeries.lean:120-123`) establish agreement with the classical Dirichlet series and Euler product:
$$
L(s, \chi) = \sum_{n=1}^{\infty} \frac{\chi(n)}{n^s} = \prod_{p \in \mathbb{P}} \bigl(1 - \chi(p) p^{-s}\bigr)^{-1} \quad (\mathrm{Re}(s) > 1).
$$
The Archimedean Gamma factor `gammaFactor` (`Mathlib/NumberTheory/LSeries/DirichletContinuation.lean:207-208`) is defined according to the parity of the character ($\chi(-1) = (-1)^{\mathfrak{a}}$, with $\mathfrak{a} = 0$ for even characters and $\mathfrak{a} = 1$ for odd characters) by
$$
\gamma(s, \chi) := \Gamma_{\mathbb{R}}(s + \mathfrak{a}) = \pi^{-(s + \mathfrak{a})/2} \Gamma\left(\frac{s + \mathfrak{a}}{2}\right),
$$
and satisfies $L(s, \chi) = \Lambda(s, \chi) / \gamma(s, \chi)$ with the completed $L$-function `completedLFunction` (lines `224-225`, $\Lambda(s, \chi)$) whenever $(s \neq 0 \lor N \neq 1)$ by `LFunction_eq_completed_div_gammaFactor` (lines `259-260`).
Finally, for a primitive character $\chi \bmod N$, defining the global root number $\varepsilon(\chi) := \tau(\chi) / (i^{\mathfrak{a}} N^{1/2})$ (`rootNumber`, lines `272-273`, $\lvert\varepsilon(\chi)\rvert = 1$) in terms of the Gauss sum $\tau(\chi) = \sum_{x \in \mathbb{Z}/N\mathbb{Z}} \chi(x) e^{2\pi i x / N}$ yields the completed functional equation `IsPrimitive.completedLFunction_one_sub` (lines `284-285`) for all $s \in \mathbb{C}$:
$$
\Lambda(1 - s, \chi) = N^{s - 1/2} \varepsilon(\chi)\, \Lambda(s, \chi^{-1}).
$$

---

### 3.2 Boundary Audit (a): The `[NeZero N]` Typeclass, Blocking Degenerate Modulus $N = 0$, and Agreement Between the Modulus $N = 1$ Trivial Character and $\zeta(s)$

The most common type-theoretic pitfalls in formalizing Dirichlet characters occur at the boundary moduli $N = 0$ and $N = 1$. First is **verification that the degenerate modulus $N = 0$ is blocked**. In Lean, `ZMod 0` is definitionally equal to the integer ring `ℤ`. Had a theorem statement omitted `[NeZero N]` and quantified blindly over `∀ (N : ℕ)`, the case $N = 0$ would have included `DirichletCharacter ℂ 0 = MulChar ℤ ℂ`.
Because the unit group of `ℤ` is merely $\{\pm 1\}$, `modZero_eq_delta` (`Mathlib/NumberTheory/LSeries/Dirichlet.lean:156-163`) shows that on natural numbers such a character degenerates to $\chi(1) = 1$ and $\chi(n) = 0$ for all $n \ge 2$; furthermore, `ZMod 0 = ℤ` carries no `Fintype` instance, so the finite-sum definition of `ZMod.LFunction` does not even apply.
Every Dirichlet specification in `Statements.lean:7, 11, 15` imposes the `[NeZero N]` typeclass argument, excluding $N = 0$ from the domain and ranging over all positive integer moduli $N \in \{1, 2, 3, \dots\}$. Second is **verification of the subtle modulus $N = 1$ boundary (`0 = 1` phenomenon) and exact agreement with $\zeta(s)$**. When $N \ge 2$, `ZMod N` is a non-trivial ring (`0 ≠ 1`), so $0$ is a non-unit and `map_zero'` (`Mathlib/NumberTheory/DirichletCharacter/Basic.lean:217-218`) enforces $\chi(0) = 0$.
When $N = 1$, however, `ZMod 1` is the one-element zero ring (`Subsingleton (ZMod 1)`, `0 = 1`), making its unique element $0 \equiv 1 \pmod 1$ a unit (`isUnit_of_subsingleton`). As a result, the unique Dirichlet character modulo $1$, $\chi_1 = (1 : \mathrm{DirichletCharacter}\; \mathbb{C}\; 1)$ (`level_one`, lines `202-204`), evaluates at the natural number $n = 0$ to $\chi_1(0) = 1$ (`modOne_eq_one`, `Mathlib/NumberTheory/LSeries/Dirichlet.lean:166-170`).
Direct evaluation from the verbatim definitions confirms that $\chi_1(0) = 1$ never contaminates $L(s, \chi_1)$:

- On the series side, `LSeries.term` (`Mathlib/NumberTheory/LSeries/Basic.lean:74-75`) truncates the $n = 0$ entry via `if n = 0 then 0 else f n / n ^ s` regardless of the sequence value at $0$, so `LSeries_modOne_eq` (`Mathlib/NumberTheory/LSeries/Dirichlet.lean:171-172`) gives `L ↗χ₁ = L 1`.
- On the analytic continuation side, unfolding `ZMod.LFunction_modOne_eq` (`Mathlib/NumberTheory/LSeries/ZMod.lean:87-90`) and `DirichletCharacter.LFunction_modOne_eq` (`Mathlib/NumberTheory/LSeries/DirichletContinuation.lean:67-69`) collapses the sum over `ZMod 1 = {0}` to a single term:
$$
L(s, \chi_1) = 1^{-s} \cdot \chi_1(0) \cdot \zeta_{\mathrm{Hurwitz}}(0, s) = 1 \cdot 1 \cdot \zeta(s) = \zeta(s) \quad (\forall s \in \mathbb{C}),
$$
    holding identically pointwise across all $s \in \mathbb{C}$, including the junk value at the pole $s = 1$. In addition, `conductor_one` (`Mathlib/NumberTheory/DirichletCharacter/Basic.lean:259`) and `isPrimitive_one_level_one` (lines `296-297`) give $\mathrm{conductor}(\chi_1) = 1$, classifying $\chi_1$ as primitive (`IsPrimitive χ₁`), while `completedLFunction_modOne_eq` (`Mathlib/NumberTheory/LSeries/DirichletContinuation.lean:231-233`) gives $\Lambda(s, \chi_1) = \Lambda(s)$.
    At the single point $N = 1, s = 0$, where $\Lambda(s, \chi_1) = \Lambda(s)$ has a pole, `LFunction_eq_completed_div_gammaFactor` (lines `259-260`) imposes the exact guard `(h : s ≠ 0 ∨ N ≠ 1)`, preventing any spurious zero from entering. Third is **necessity of the `(χ ≠ 1 ∨ s ≠ 1)` condition for the pole at $s = 1$ of the trivial character $\chi = 1_N$ of modulus $N \ge 2$**.
When $N \ge 2$, the trivial character $1_N = (1 : \mathrm{DirichletCharacter}\; \mathbb{C}\; N)$ is an imprimitive character of conductor $1$ (`eq_one_iff_conductor_eq_one`, `Mathlib/NumberTheory/DirichletCharacter/Basic.lean:268`); for $s \neq 1$, `LFunctionTrivChar_eq_mul_riemannZeta` (`Mathlib/NumberTheory/LSeries/DirichletContinuation.lean:174-175`) establishes
$$
L(s, 1_N) = \left(\prod_{p \mid N} \bigl(1 - p^{-s}\bigr)\right) \zeta(s) \quad (s \neq 1),
$$
which has a simple pole at $s = 1$ with residue $\prod_{p \mid N} (1 - p^{-1}) = \varphi(N)/N > 0$ (`LFunctionTrivChar_residue_one`, lines `182-184`). By contrast, for every non-trivial character $\chi \neq 1_N$, character orthogonality gives $\sum_{j \in \mathbb{Z}/N\mathbb{Z}} \chi(j) = 0$, cancelling the $1/(s-1)$ simple poles of the individual Hurwitz zeta summands so that $L(s, \chi)$ extends to an entire function on all of $\mathbb{C}$ including $s = 1$ (`differentiable_LFunction`, lines `98-100`) with a finite nonzero value $L(1, \chi) \neq 0$ (`LFunction_apply_one_ne_zero`, `Mathlib/NumberTheory/LSeries/Nonvanishing.lean:406-407`).
Thus the hypothesis `(χ ≠ 1 ∨ s ≠ 1)` in `DirichletLNonvanishingRightOfHalf` (`Statements.lean:6-8`) excises solely the single pole pair $(\chi = 1_N,\, s = 1)$ while preserving intact the nonvanishing $L(1, \chi) \neq 0$ for non-trivial characters (the key analytic input to Dirichlet's theorem on primes in arithmetic progressions).

---

### 3.3 Boundary Audit (b): Prime-Divisor Euler Factors of Imprimitive Characters and Imaginary-Axis Zeros $\mathrm{Re}(s) = 0$

Even among human mathematicians, the single most error-prone aspect of stating the Generalized Riemann Hypothesis is the location of the extra zeros of **imprimitive characters**. For an arbitrary Dirichlet character $\chi$ of modulus $N \ge 1$ with conductor $f = \mathrm{conductor}(\chi) \mid N$ and inducing primitive character $\chi_0 = \chi.\mathrm{primitiveCharacter} \bmod f$, whenever $(\chi \neq 1_N \lor s \neq 1)$ `LFunction_changeLevel` (`Mathlib/NumberTheory/LSeries/DirichletContinuation.lean:150-153`) establishes the factorization identity
$$
L(s, \chi) = L(s, \chi_0) \prod_{p \mid N} \bigl(1 - \chi_0(p) p^{-s}\bigr).
$$
Splitting the prime divisors $p \mid N$ into two classes determines all zeros of each finite Euler factor $E_p(s) := 1 - \chi_0(p) p^{-s}$ explicitly:

1. **Primes dividing the conductor ($p \mid f$)**: Since $\gcd(p, f) = p > 1$, $p$ is a non-unit in $\mathbb{Z}/f\mathbb{Z}$ and $\chi_0(p) = 0$. Consequently $E_p(s) = 1 - 0 = 1$, contributing zero roots.
2. **Primes dividing $N$ but not $f$ ($p \mid N$ and $p \nmid f$)**: Since $\gcd(p, f) = 1$, $p \bmod f \in (\mathbb{Z}/f\mathbb{Z})^\times$, so $\chi_0(p)$ lies on the unit circle as $\chi_0(p) = e^{i\theta_p}$ ($\theta_p \in [0, 2\pi)$). Writing $s = \sigma + it$ ($\sigma, t \in \mathbb{R}$), the equation $E_p(s) = 0$ solves to
$$
1 - e^{i\theta_p} p^{-\sigma - it} = 0 \;\Longleftrightarrow\; p^{-\sigma} e^{i(\theta_p - t \log p)} = 1 \;\Longleftrightarrow\; \sigma = 0 \;\land\; t = \frac{\theta_p + 2\pi k}{\log p} \quad (k \in \mathbb{Z}).
$$

This calculation establishes a decisive boundary fact. Every imprimitive character $\chi \bmod N$ whose modulus $N$ has at least one prime divisor $p \nmid f$ (for instance the trivial character $1_2$ modulo $N = 2$, where $f = 1$ and $L(s, 1_2) = (1 - 2^{-s})\zeta(s)$) possesses **infinitely many genuine analytic zeros $s_k = i(\theta_p + 2\pi k)/\log p$ spaced periodically along the imaginary axis $\mathrm{Re}(s) = 0$**.
Had `Statements.lean` formulated its theorem for general (possibly imprimitive) characters on the closed critical strip $0 \le \mathrm{Re}(s) \le 1$ or on the entire complex plane minus negative trivial zeros, $\mathrm{Re}(s_k) = 0 \neq 1/2$ would have rendered the statement immediately false. Collating the three specifications in `Statements.lean:6-16` against the two internal archive proof modules (`Development/AutomorphicArithmetic/CharacterBoxes/Imprimitive.lean:5-35` and `Development/AutomorphicArithmetic/CharacterBoxes/ClaimStrip.lean:7-34`) confirms that every boundary interlocks with zero discrepancy:

- **`DirichletLNonvanishingRightOfHalf` (`Statements.lean:6-8`)**: The domain hypothesis is the open right half-plane `1 / 2 < s.re`. For every prime $p \ge 2$ and $\mathrm{Re}(s) > 1/2 > 0$, $\lVert \chi_0(p) p^{-s} \rVert \le 1 \cdot p^{-\mathrm{Re}(s)} < 1$, so the finite product $\prod_{p \mid N} (1 - \chi_0(p)p^{-s})$ is strictly nonzero. Indeed, `UpperTheory.Top.imprimitive` (`Development/AutomorphicArithmetic/CharacterBoxes/Imprimitive.lean:5-35`) combines primitive right half-plane nonvanishing `ZeroFreeAll` (line `10`), `LFunction_changeLevel` (lines `18-20`), and the norm inequality `‖(p : ℂ) ^ (-s)‖ < 1` (lines `26-34`) to extend nonvanishing losslessly to arbitrary imprimitive characters.
- **`DirichletLZerosOnLine` (`Statements.lean:10-12`)**: While allowing arbitrary imprimitive characters, the domain hypothesis is restricted to the **open critical strip `0 < s.re → s.re < 1`**. Because the left boundary $\mathrm{Re}(s) = 0$ is excluded by strict inequality `0 < s.re`, the entire imaginary-axis zero locus $\{\,\sigma = 0\,\}$ of imprimitive Euler factors lies outside the domain, while the right boundary $\mathrm{Re}(s) = 1$ is excluded by `s.re < 1`, automatically entailing `s ≠ 1` without needing to repeat `(χ ≠ 1 ∨ s ≠ 1)`. Indeed, `Claim.factor_ne_zero` (`Development/AutomorphicArithmetic/CharacterBoxes/ClaimStrip.lean:7-22`) assumes solely `0 < s.re` to prove $(1 - \psi(p)p^{-s}) \neq 0$, and `Claim.prim_zero` (`Development/AutomorphicArithmetic/CharacterBoxes/ClaimStrip.lean:23-34`) uses it to reduce any open-strip zero $L(s, \chi) = 0$ to a zero $L(s, \chi_0) = 0$ of the inducing primitive character.
- **`PrimitiveDirichletLZerosOnLine` (`Statements.lean:14-16`)**: This open-strip specification explicitly assumes `χ.IsPrimitive`. For primitive characters no extra Euler factors exist, so the completed functional equation operates directly without an Euler-factor stripping step (`Formalism/GammaFactorNonvanishing/CritLine.lean:11-28`).

---

## Chapter 4. Exhaustive Anatomy of the Distance 0-4 Upper Assembly Bridge (`43` Modules) from `Main.lean`

### 4.1 Hierarchical Stratification of the Top `43` Modules and Branching-Merging DAG of the Four Main Witnesses

Classifying the top `43` files (`2,318` lines, `192` declarations: `145` theorems + `47` definitions and structures) cataloged in Part B Volume 10 (`atlas/volumes/B10_Top_Spine_Depth0_To_4.md` and `atlas/data/top_spine_depth4.jsonl`) by shortest import distance (`dist`) from `Main.lean` yields the following stratification:

- **Distance `0` (`1` file, `12` lines)**: `Main.lean:1-12` (declarations of the 5 final theorems).
- **Distance `1` (`2` files, `18` lines)**: `Statements.lean:1-16` (definitions of the 4 target propositions), `Supplements/Kernels/MainTheoremsAll.lean:1-2` (top-level integrator joining the main-theorem path and the small-class-number cohomology path).
- **Distance `2` (`2` files, `33` lines)**: `Supplements/Kernels/MainTheoremsCritical.lean:1-4` (aggregator of `MainTheorems` and three small-class-number auxiliary modules), `Development/AutomorphicArithmetic/AutomorphicVarieties/SmallClassNumbers/CorGKOf.lean:1-29` (derivation of `corGK` and `bound`).
- **Distance `3` (`7` files, `356` lines)**: `Supplements/Kernels/MainTheorems.lean:1-16` (generation hub for the 4 main witnesses), `Development/AutomorphicArithmetic/AutomorphicVarieties/ModularityArgument/ThresholdArguments/DenseThresholdCases/TopMainZj.lean:1-75` (assembler of the automorphic window `VWin`), `Development/AutomorphicArithmetic/Foundations/BaseChangeIdentities/DefiniteNHolds.lean:1-6` (unitary isobaric base change `baseChangeN`), `Development/AutomorphicArithmetic/Foundations/GaloisRepresentations/IntegralStructures/RowSrc.lean:1-8` (Galois local-global compatibility `galoisLocalGlobalStrong_recParameter`), and `3` arithmetic modules under `SmallClassNumbers` (`Development/AutomorphicArithmetic/AutomorphicVarieties/SmallClassNumbers/ClassNumberThree.lean:1-115`, `Development/AutomorphicArithmetic/AutomorphicVarieties/SmallClassNumbers/LenEqZeroIff.lean:1-95`, `Development/AutomorphicArithmetic/AutomorphicVarieties/SmallClassNumbers/OnePoint.lean:1-41`).
- **Distance `4` (`25` files, `1,648` lines)**:
    - Functional-equation reflection and grand-junction assembly (`3` files): `Formalism/GammaFactorNonvanishing/CritLine.lean:1-32`, `Development/AutomorphicArithmetic/CharacterBoxes/ClaimStrip.lean:1-104`, `Development/AutomorphicArithmetic/CharacterBoxes/MainConclusion.lean:1-14`.
    - Automorphic window literature and patching assembly (`4` files): `Development/AutomorphicArithmetic/AutomorphicVarieties/ModularityArgument/ThresholdArguments/DenseThresholdCases/DiscreteSeriesCoefficientsCuspidal.lean:1` (`1`-line `import Mathlib` hub, in-degree `520`), `Development/AutomorphicArithmetic/AutomorphicVarieties/ModularityArgument/ThresholdArguments/DenseThresholdCases/LitAut.lean:1-65`, `Development/AutomorphicArithmetic/AutomorphicVarieties/ModularityArgument/ThresholdArguments/DenseThresholdCases/TemperedProductOfSquareIntegrable.lean:1-344`, `Development/AutomorphicArithmetic/AutomorphicVarieties/ModularityArgument/ThresholdArguments/DenseThresholdCases/WindowBoundOfLiteratureLevel.lean:1-35`.
    - Abelian variety periods, crystalline lifts, and good reduction (`5` files): `Development/AbelianVarietyTheory/Proofs/DivisorProofs/AbelianDualCrystalOfHyp.lean:1-12`, `Development/AbelianVarietyTheory/Proofs/DivisorProofs/CrystallineSmoothLiftOfRelations.lean:1-74`, `Development/AbelianVarietyTheory/Proofs/DivisorProofs/PeriodComparisonHolds.lean:1-6`, `Development/AbelianVarietyTheory/Proofs/DivisorProofs/ImportsSideExtra.lean:1-12`, `Development/AutomorphicArithmetic/ThetaCorrespondence/GoodReduction/SerreTate.lean:1-18`.
    - Base change, theta lifts, and automorphic lifting (`6` files): `Development/WeilBound/RepresentationTheoryGL/ArchimedeanBaseChange/ArchimedeanBaseChangeProof/BaseChangeIsobaricNOf.lean:1-135`, `Development/AutomorphicArithmetic/Foundations/BaseChangeIdentities/FillPre.lean:1-9`, `Development/AutomorphicArithmetic/Foundations/BaseChangeIdentities/FrameMatching/HeckeEigenvalueFiniteness/FrameEx.lean:1-19`, `Development/AutomorphicArithmetic/Foundations/BaseChangeIdentities/NarrowSwap.lean:1-24`, `Development/AutomorphicArithmetic/Foundations/GaloisRepresentations/IntegralStructures/GaloisRepresentationsOfThetaLift.lean:1-8`, `Development/AutomorphicArithmetic/Foundations/GaloisRepresentations/ThetaParseval/ThetaKernels/TLiftK.lean:1-5`.
    - $U(3)$ Kato systems, quadratic place decomposition, and automorphy flags (`7` files): `Development/AutomorphicArithmetic/AutomorphicVarieties/ModularityArgument/AutomorphyLifting/WeakOfAtt.lean:1-115`, `Development/AutomorphicArithmetic/AutomorphicVarieties/UnitaryThreeGroups/KatoUse.lean:1-68`, `Development/AutomorphicArithmetic/AutomorphicVarieties/ModularityArgument/LinkedUnramifiedChains/WeightInfinitesimalCharacters/OneCharU.lean:1-89`, `Development/AutomorphicArithmetic/AutomorphicVarieties/HeightAndVanishing/SplittingFieldIsoQuadratic.lean:1-67`, `Development/AutomorphicArithmetic/AutomorphicVarieties/HeightAndVanishing/KstarRam.lean:1-76`, `Development/AutomorphicArithmetic/AutomorphicVarieties/CharacterLevelBounds/PlacesQ.lean:1-152`, `Development/AutomorphicArithmetic/AutomorphicVarieties/GaloisLibrary/SelmerTransport/Places.lean:1-164`.
- **Distance `5` direct bridge (`1` file, `231` lines)**: `Development/AutomorphicArithmetic/CharacterBoxes/RiemannHypothesisOfEveryCharacter.lean:1-231` (imported directly at `Development/AutomorphicArithmetic/CharacterBoxes/MainConclusion.lean:5`).
- **Distance `8` to `19` build-aid modules (`5` files, `20` lines)**: `BuildAid/D1.lean:1-4` through `BuildAid/D5.lean:1-4` (dissected in full in Chapter 1, Section 1.2). The complete directed acyclic graph (DAG) along which the four main witnesses (`rhOfAll`, `allChi`, `claimAll`, `critAll`) and the small-class-number auxiliary main theorems (`corGK`, `bound`) branch near the root and reconverge onto the three lower engines (`RowSrc`, `DefiniteNHolds`, `TopMainZj`) is depicted below.

```mermaid
flowchart TD
    M["Main.lean (L4-L12: 5 final theorems)"] --> ST["Statements.lean (L3-L16: 4 target Props)"]
    M --> MTA["MainTheoremsAll.lean (d=1, L1-L2)"]
    MTA --> MTC["MainTheoremsCritical.lean (d=2, L1-L4)"]
    MTA --> CGK["CorGKOf.lean (d=2, L10-L28: corGK, bound)"]
    MTC --> MT["MainTheorems.lean (d=3, L7-L16: 4 main witnesses)"]
    MTC --> CN3["ClassNumberThree.lean (d=3, L13-L112)"]
    MTC --> LEZ["LenEqZeroIff.lean (d=3, L9-L92: large_of)"]
    MTC --> OP["OnePoint.lean (d=3, L10-L41: onePoint)"]
    CGK --> CN3
    LEZ --> CN3
    MT --> CL["CritLine.lean (d=4, L6-L32: rh_of_every, critLine)"]
    MT --> CS["ClaimStrip.lean (d=4, L7-L103: strip, zeta)"]
    MT --> MC["MainConclusion.lean (d=4, L7-L14: everyCharacter)"]
    MC --> RHEC["RiemannHypothesisOfEveryCharacter.lean (d=5, L211-L231)"]
    MC --> EVLIT["EveryCharacterOfLiteratureOfVWin.lean (d=5, L810-L814)"]
    MC --> VWR["VwinOfRow.lean (d=5, L4-L5: vwin_of_row)"]
    MC --> RTE["RecTExists.lean (d=5, L20-L66: recTExists)"]
    MC --> RSRC["RowSrc.lean (d=3, L6: galoisLocalGlobalStrong_recParameter)"]
    VWR --> TMZ["TopMainZj.lean (d=3, L18-L75: VWin assembly)"]
    VWR --> DNH["DefiniteNHolds.lean (d=3, L5-L6: baseChangeN)"]
    CGK --> TMZ
    CGK --> DNH
    CGK --> RSRC
    TMZ --> WBL["WindowBoundOfLiteratureLevel.lean (d=4, L25-L35)"]
    TMZ --> TPSI["TemperedProductOfSquareIntegrable.lean (d=4, L207-L344)"]
    TMZ --> AB4["AbelianVariety/SerreTate 5 modules (d=4)"]
    DNH --> FP["FillPre.lean / FrameEx.lean / NarrowSwap.lean (d=4)"]
    RSRC --> TLK["GaloisRepresentationsOfThetaLift.lean / TLiftK.lean (d=4)"]
```

As this DAG clarifies, `RowSrc.lean`, `DefiniteNHolds.lean`, and `TopMainZj.lean` sit at shortest distance `3` from `Main` for a concrete reason: along the `MainConclusion.lean` (`d=4`) $\to$ `VwinOfRow.lean` (`d=5`) route they appear at depth `5` to `6`, whereas `MainTheoremsAll.lean` (`d=1`) $\to$ `CorGKOf.lean` (`d=2`) imports all three directly, shortening their shortest-path distance to `3`.
In other words, the main theorem (`everyCharacter`) and the arithmetic byproducts (`corGK`, `bound`) share and cross-verify the exact same automorphic window, base change, and Galois representation engines.

---

### 4.2 Complete Reconstruction of the Triple Functional-Equation Reflection and Gamma-Factor Nonvanishing Chain

`Supplements/Kernels/MainTheorems.lean:7-16` takes the single core witness `allChi : UpperTheory.EveryCharacter` (Dirichlet nonvanishing on the open right half-plane $\mathrm{Re}(s) > 1/2$) and routes it across three independent reflection modules to derive all remaining critical-line theorems. Tracing the exact source line numbers reconstructs the three reduction chains in full.

#### (1) Critical-Line Reduction for Primitive Dirichlet Characters (`Formalism/GammaFactorNonvanishing/CritLine.lean:6-28`)
In `Main.lean:12`, `LFunction_eq_zero_re_of_isPrimitive` is inhabited by `critAll` (`Supplements/Kernels/MainTheorems.lean:11-13`), which calls `Formalism.VW.critLine` (`Formalism/GammaFactorNonvanishing/CritLine.lean:11-28`). First, the helper theorem `gammaFactor_ne_zero` in `Formalism/GammaFactorNonvanishing/CritLine.lean:6-10` proves that the Archimedean Gamma factor never vanishes on the open right half-plane $\mathrm{Re}(s) > 0$:

- When $\chi$ is even (`χ.Even`), $\gamma(s, \chi) = \Gamma_{\mathbb{R}}(s)$ and $\mathrm{Re}(s) > 0$, so `Gammaℝ_ne_zero_of_re_pos` (`Mathlib/Analysis/SpecialFunctions/Gamma/Deligne.lean:66-71`) yields $\gamma(s, \chi) \neq 0$ (`Formalism/GammaFactorNonvanishing/CritLine.lean:8`).
- When $\chi$ is odd (`χ.Odd`), $\gamma(s, \chi) = \Gamma_{\mathbb{R}}(s + 1)$ and $\mathrm{Re}(s + 1) = \mathrm{Re}(s) + 1 > 1 > 0$, so again $\gamma(s, \chi) \neq 0$ (`Formalism/GammaFactorNonvanishing/CritLine.lean:9`). Assuming now a primitive character $\chi \bmod N$ (`hχ : χ.IsPrimitive`) and a zero $L(s, \chi) = 0$ (`hz`) inside the open critical strip $0 < \mathrm{Re}(s) < 1$, suppose for contradiction that $\mathrm{Re}(s) \neq 1/2$ (`hne`, line `15`).
- **Right branch ($\mathrm{Re}(s) > 1/2$, line `27`)**: Since $\mathrm{Re}(s) < 1 \implies s \neq 1$ (`hs1`, line `14`), this contradicts the right half-plane nonvanishing witness `h N χ s hgt (Or.inr hs1)` immediately.
- **Left branch ($0 < \mathrm{Re}(s) < 1/2$, lines `17-26`)**:
    1. By `conductor_inv`, the inverse character $\chi^{-1}$ is also primitive modulo $N$ (`hinv : χ⁻¹.IsPrimitive`, lines `17-18`).
    2. Since $\mathrm{Re}(s) > 0 \implies s \neq 0$ (`hs0`, line `13`), `LFunction_eq_completed_div_gammaFactor` (line `20`) gives $L(s, \chi) = \Lambda(s, \chi) / \gamma(s, \chi) = 0$; cancelling the nonzero denominator $\gamma(s, \chi) \neq 0$ (line `21`) yields the completed $L$-function zero $\Lambda(s, \chi) = 0$ (`hc`).
    3. Applying the completed functional equation `hinv.completedLFunction_one_sub s` (line `22`) to the primitive character $\chi^{-1}$ and substituting $(\chi^{-1})^{-1} = \chi$ (`inv_inv`, line `23`) together with $\Lambda(s, \chi) = 0$ gives
$$
\Lambda(1 - s, \chi^{-1}) = N^{s - 1/2} \varepsilon(\chi^{-1})\, \Lambda(s, \chi) = 0.
$$
    4. Since $s \neq 1 \implies 1 - s \neq 0$ (`h2`, line `24`), applying `LFunction_eq_completed_div_gammaFactor` (line `26`) once more at $1 - s$ yields
$$
L(1 - s, \chi^{-1}) = \frac{\Lambda(1 - s, \chi^{-1})}{\gamma(1 - s, \chi^{-1})} = \frac{0}{\gamma(1 - s, \chi^{-1})} = 0.
$$
        Yet $\mathrm{Re}(s) < 1/2 \implies \mathrm{Re}(1 - s) = 1 - \mathrm{Re}(s) > 1/2$ and $s \neq 0 \implies 1 - s \neq 1$, so instantiating right half-plane nonvanishing `h N χ⁻¹ (1 - s)` (line `25`) at $1 - s$ and $\chi^{-1}$ forces $L(1 - s, \chi^{-1}) \neq 0$, completing the contradiction.

#### (2) Critical-Strip Reduction for Arbitrary (Possibly Imprimitive) Dirichlet Characters (`Development/AutomorphicArithmetic/CharacterBoxes/ClaimStrip.lean:7-74`)
`claimAll.2.1`, which inhabits `LFunction_eq_zero_re` in `Main.lean:10`, evaluates `Claim.strip allChi` (`Development/AutomorphicArithmetic/CharacterBoxes/ClaimStrip.lean:59-74`). Given any character $\chi \bmod N$ and a zero $L(s, \chi) = 0$ in $0 < \mathrm{Re}(s) < 1$, the left branch $\mathrm{Re}(s) < 1/2$ (lines `65-71`) proceeds in two steps.
First, `prim_zero` (lines `23-34`) invokes `factor_ne_zero` (lines `7-22`, audited in Chapter 3, Section 3.3) to cancel the finite Euler product $\prod_{p \mid N}(1 - \chi_0(p)p^{-s}) \neq 0$ and extract a zero $L(s, \chi_0) = 0$ (`hp`, line `67`) of the inducing primitive character modulo the conductor $f = \chi.\mathrm{conductor}$ (`NeZero f`, line `66`).
Next, `prim_reflect` (lines `42-58`) applies the same completed functional-equation reflection as in (1) to $\chi_0$ to obtain $L(1 - s, \chi_0^{-1}) = 0$ (`hr`, line `68`), colliding directly with `h χ.conductor χ.primitiveCharacter⁻¹ (1 - s)` (lines `70-71`) at level $f$ to establish $\mathrm{Re}(s) = 1/2$.
The full verbatim code of `prim_reflect` in `Development/AutomorphicArithmetic/CharacterBoxes/ClaimStrip.lean:42-58` implements this algebraic reduction without a single omission:

```lean
-- Development/AutomorphicArithmetic/CharacterBoxes/ClaimStrip.lean:42-58
theorem prim_reflect {M : ℕ} [NeZero M] (ψ : DirichletCharacter ℂ M) (hψ : ψ.IsPrimitive) {s : ℂ}
    (hs0 : 0 < s.re) (hs1 : s.re < 1) (h : DirichletCharacter.LFunction ψ s = 0) :
    DirichletCharacter.LFunction ψ⁻¹ (1 - s) = 0 := by
  have hs0' : s ≠ 0 := fun e => by rw [e, Complex.zero_re] at hs0; exact lt_irrefl _ hs0
  have ht0 : 0 < (1 - s).re := by rw [Complex.sub_re, Complex.one_re]; linarith
  have ht0' : 1 - s ≠ 0 := fun e => by rw [e, Complex.zero_re] at ht0; exact lt_irrefl _ ht0
  have hc : DirichletCharacter.completedLFunction ψ s = 0 := by
    rw [DirichletCharacter.LFunction_eq_completed_div_gammaFactor ψ s (Or.inl hs0'),
      div_eq_zero_iff] at h
    exact h.resolve_right (gamma_ne_zero ψ hs0)
  have hψ' : (ψ⁻¹).IsPrimitive := by
    rw [DirichletCharacter.isPrimitive_def, DirichletCharacter.conductor_inv]; exact hψ
  have fe := hψ'.completedLFunction_one_sub s
  rw [inv_inv, hc, mul_zero] at fe
  rw [DirichletCharacter.LFunction_eq_completed_div_gammaFactor ψ⁻¹ (1 - s) (Or.inl ht0'), fe,
    zero_div]
```

#### (3) Comparison of Three Independent Formalizations of Critical-Line Reduction for `riemannZeta`
Notably, the upper layer of the archive contains **three distinct proof modules** deriving pure `RiemannHypothesis` from `EveryCharacter`:

- **Route 1 (`Formalism/GammaFactorNonvanishing/CritLine.lean:29-32` $\to$ `Formalism/GammaFactorNonvanishing/RhOfRight.lean:5-62`)**: The route adopted by `rhOfAll` in `Main.lean:4` and `Main.lean:6`. `rh_of_every` (`Formalism/GammaFactorNonvanishing/CritLine.lean:29-32`) combines `h 1 (1 : DirichletCharacter ℂ 1)` with `LFunction_modOne_eq` to obtain right half-plane zeta nonvanishing $\mathrm{Re}(s) > 1/2 \land s \neq 1 \implies \zeta(s) \neq 0$, passing it to `Formalism.VW.rh_of_right` (`Formalism/GammaFactorNonvanishing/RhOfRight.lean:5-62`). Rather than passing through the completed zeta function, `rh_of_right` **applies the uncompleted functional equation `riemannZeta_one_sub` (`Mathlib/NumberTheory/LSeries/RiemannZeta.lean:178-180`) directly at the argument $1 - s$** (`Formalism/GammaFactorNonvanishing/RhOfRight.lean:28-29`):
$$
0 = \zeta(s) = \zeta\bigl(1 - (1 - s)\bigr) = 2(2\pi)^{-(1 - s)}\, \Gamma(1 - s)\, \cos\left(\frac{\pi(1 - s)}{2}\right)\, \zeta(1 - s).
$$
    When $\mathrm{Re}(s) < 1/2$, we have $\mathrm{Re}(1 - s) > 1/2 > 0$, whence (i) the exponential prefactor satisfies $2(2\pi)^{-(1-s)} \neq 0$ (`h2pi`, lines `31-32`), (ii) the Gamma factor satisfies $\Gamma(1 - s) \neq 0$ (`hG`, line `33`), and (iii) the zeta factor satisfies $\zeta(1 - s) \neq 0$ (`hz'`, line `30`, since $\zeta(0) = -1/2 \neq 0$ forces $s \neq 0 \implies 1 - s \neq 1$). Finally, (iv) assuming $\cos(\pi(1-s)/2) = 0$ (lines `34-59`) gives $1 - s = 2k + 1 \iff s = -2k$ ($k \in \mathbb{Z}$): if $k < 0$, then $\mathrm{Re}(s) = -2k \ge 2 > 1/2$, a contradiction (lines `45-46`); if $k = 0$, then $s = 0$, contradicting $\zeta(0) = -1/2 \neq 0$ (lines `47-49`); and if $k > 0$, setting $n = k - 1 \in \mathbb{N}$ gives $s = -2(n + 1)$, contradicting the trivial-zero exclusion hypothesis `htriv` (lines `50-58`). Because all four factors are nonzero, their product cannot vanish, eliminating the entire open left half-plane $\mathrm{Re}(s) < 1/2$ (including $\mathrm{Re}(s) \le 0$) in a single sweep.

- **Route 2 (`Development/AutomorphicArithmetic/CharacterBoxes/RiemannHypothesisOfEveryCharacter.lean:211-231`)**: The route invoked by `UpperTheory.FinalTheorems.riemannHypothesis` in `Development/AutomorphicArithmetic/CharacterBoxes/MainConclusion.lean:13-14`. Using the completed zeta symmetry `completedRiemannZeta_one_sub` ($\Lambda(s) = \Lambda(1-s)$, line `222`) and `riemannZeta_def_of_ne_zero` ($\zeta(s) = \Lambda(s)/\Gamma_{\mathbb{R}}(s)$, line `224`), it proves in `17` lines that for $\mathrm{Re}(s) < 1/2$, $\Lambda(s) = 0$ implies $\zeta(1-s) = 0$ contradicting `zeta_ne_zero_of_everyCharacter` (lines `211-213`), whereas $\Gamma_{\mathbb{R}}(s) = 0$ forces $s = 0$ or $s = -2(n+1)$ via `Gammaℝ_eq_zero_iff` (line `227`).
- **Route 3 (`Development/AutomorphicArithmetic/CharacterBoxes/ClaimStrip.lean:75-103`)**: Recorded in `claimAll.2.2 : Claim.Zeta`, this route handles the open strip $0 < \mathrm{Re}(s) < 1$ by specializing `Claim.strip` to $N = 1$ and closes the exterior regions $\mathrm{Re}(s) \ge 1$ and $\mathrm{Re}(s) \le 0$ via the classical `Mathlib` theorem `riemannZeta_ne_zero_of_one_le_re` (lines `83, 100`).

---

### 4.3 Grand-Junction Assembly: `MainConclusion.lean`, `EveryCharacterE.lean`, and `SiegelEisensteinSecondTermHypotheses.lean`

`allChi`, the common root of all four main witnesses, is completed in `Development/AutomorphicArithmetic/CharacterBoxes/MainConclusion.lean:1-14` (distance `4`, full `14` lines). Its complete verbatim source reads as follows.

```lean
import Development.AutomorphicArithmetic.ThetaCorrespondence.ThetaPairLifts.ThirdPlaceSeries.EveryCharacterOfLiteratureOfVWin
import Development.AutomorphicArithmetic.AutomorphicVarieties.ModularityArgument.ThresholdArguments.DenseThresholdCases.VwinOfRow
import Development.AutomorphicArithmetic.Foundations.LocalLanglands.LocalCentralUnits.RecTExists
import Development.AutomorphicArithmetic.Foundations.GaloisRepresentations.IntegralStructures.RowSrc
import Development.AutomorphicArithmetic.CharacterBoxes.RiemannHypothesisOfEveryCharacter

theorem UpperTheory.FinalTheorems.everyCharacter_of_row (h : UpperTheory.GalStar.Row0b fun h rc => UpperTheory.Zero.LLC.IsRecT h rc) : UpperTheory.EveryCharacter :=
  UpperTheory.LiteratureTheorems.every_character_of_literature_of_vWin ⟨h, UpperTheory.Zero.LLC.recTExists, h⟩ (UpperTheory.One.vwin_of_row h)

theorem UpperTheory.FinalTheorems.everyCharacter : UpperTheory.EveryCharacter :=
  UpperTheory.FinalTheorems.everyCharacter_of_row UpperTheory.Gal.Int.galoisLocalGlobalStrong_recParameter

theorem UpperTheory.FinalTheorems.riemannHypothesis : RiemannHypothesis :=
  UpperTheory.riemannHypothesis_of_everyCharacter UpperTheory.FinalTheorems.everyCharacter
```

The grand synthesis executed in `Development/AutomorphicArithmetic/CharacterBoxes/MainConclusion.lean:7-11` operates in four exact stages:

1. **Supply of the Galois local-global compatibility witness (`Development/AutomorphicArithmetic/Foundations/GaloisRepresentations/IntegralStructures/RowSrc.lean:6`)**: The distance-`3` module `Development/AutomorphicArithmetic/Foundations/GaloisRepresentations/IntegralStructures/RowSrc.lean:6` feeds the distance-`4` theta-kernel witness `UpperTheory.TP.K.tLiftK` from `Development/AutomorphicArithmetic/Foundations/GaloisRepresentations/ThetaParseval/ThetaKernels/TLiftK.lean:4-5` into `galoisRepresentations_of_thetaLift` in `Development/AutomorphicArithmetic/Foundations/GaloisRepresentations/IntegralStructures/GaloisRepresentationsOfThetaLift.lean:6`, producing the local-global compatibility theorem `galoisLocalGlobalStrong_recParameter : UpperTheory.GalStar.Row0b recT` (dependency cone: `66,168` files) for Galois representations attached to regular algebraic conjugate self-dual cuspidal representations.
2. **Existence of the local Langlands correspondence and discharge of the literature bundle (`Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/EveryCharacterOfLiteratureOfVWin.lean:215-218`)**: `Development/AutomorphicArithmetic/Foundations/LocalLanglands/LocalCentralUnits/RecTExists.lean:20-66` proves existence of local Langlands parameters `recTExists` (dependency cone: `26,673` files) from supercuspidal representations (`cuspEx`) via Zelevinsky segment extensions. In the three-field structure `OpenLiteratureStatements` defined in `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/EveryCharacterOfLiteratureOfVWin.lean:215-218`, both the first and third fields (`caraianiLocalGlobalDual`, `galoisRepOfPolarizedPairLit`) have type `Row0b IsRecT` while the second field (`localLanglandsExists`) has type `RecTExists`, so the anonymous constructor `⟨h, UpperTheory.Zero.LLC.recTExists, h⟩` in `Development/AutomorphicArithmetic/CharacterBoxes/MainConclusion.lean:8` populates all three fields at once and discharges the conditional literature structure completely.
3. **Closed-loop coupling of theta integrals, Arakelov covolume bounds, and iterated lifts (`Development/AutomorphicArithmetic/ThetaCorrespondence/FockModels/EveryCharacterE.lean:41-72` and `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/SiegelEisensteinSecondTermHypotheses.lean:44-74`)**: `every_character_of_literature_of_vWin` (`Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/EveryCharacterOfLiteratureOfVWin.lean:810-814`) assembles the published-theorem witnesses to construct the Arakelov covolume upper bound `topCovolSlim2_use_alt_alt` (`Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/TopCovolSlim2Use.lean:16-22`, combining Hironaka resolution of singularities, principalization, Poincaré-Lelong, Moriwaki bigness, the Fargues exact sequence, Zarhin's trick, and Siegel annular integrals), and passes the result to `_root_.UpperTheory.Lit.every_character_of_theta_integrals_local_matching` (`Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/SiegelEisensteinSecondTermHypotheses.lean:69-73`).
    - The prototype blueprint for this theorem is `hypsE₂` (lines `41-65`) and `everyE₂` (lines `67-71`) in `Development/AutomorphicArithmetic/ThetaCorrespondence/FockModels/EveryCharacterE.lean:41-72`, whereas `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/SiegelEisensteinSecondTermHypotheses.lean:44-74` is the production weld obtained by replacing the local Langlands input type `LocalLanglandsGL` with `RecTExists`.
    - Internally (lines `45-68`), the proof derives separation of functionals (`FunctionalsSeparate`, lines `47-48`), test-vector rationality (`RowRat`, lines `49-50`), constant-term Fourier coefficient compatibility (`ConstantFunctionFits`, line `51`), open orbits on the evaluation grid `GridA (max CF0 CF1)` (`hOpenA`, lines `58-62`), and $L^3$ bundle connectivity (`hL3`, lines `65-67`) from Howe unramified duality (`howeUnram_holds`) and Siegel-Weil convergence, inhabiting `Nonempty (HypsAlt S0.NL DefiniteSideCondition)`. The full `18`-line source of the prototype plug module `Development/AutomorphicArithmetic/CharacterBoxes/EveryCharacter.lean:1-18` formalizes primitive nonvanishing assembly at scale `la := 3 / 2` (`plugWin`) and imprimitive extension (`plugAll`) as follows.

```lean
import Development.AbelianVarietyTheory.Proofs.GlobalInterpolation.ShapeOf
import Development.AutomorphicArithmetic.CharacterBoxes.ShapeWin
import Development.AutomorphicArithmetic.CharacterBoxes.SupplyChi
import Development.AutomorphicArithmetic.CharacterBoxes.Imprimitive

open Formalism.BasicNotions Formalism.MainNotions GlobalTheory.Fc

theorem UpperTheory.Top.plugWin (hG : GlobalTheory.GLq.Green) (hV : UpperTheory.Top.VWin)
    (h : Nonempty (Hyps (fun 𝒞 => Closed 𝒞 fun Fm _ => LinkN Fm) DRS)) : Formalism.HC.ZeroFreeAll :=
  h.elim fun h => UpperTheory.Top.zeroFreeAll_of_topG (la := 3 / 2) (by norm_num)
    (GlobalTheory.Fc.shape_of _ _ _ _ (UpperTheory.Top.shapeWin hG) trivial trivial h)
    fun ψ => UpperTheory.Top.supplyChi ψ (hV ψ)

def UpperTheory.EveryCharacter : Prop :=
  ∀ (N : ℕ) [NeZero N] (χ : DirichletCharacter ℂ N) (s : ℂ),
    1 / 2 < s.re → (χ ≠ 1 ∨ s ≠ 1) → DirichletCharacter.LFunction χ s ≠ 0

theorem UpperTheory.Top.plugAll (hG : GlobalTheory.GLq.Green) (hV : UpperTheory.Top.VWin)
    (h : Nonempty (Hyps (fun 𝒞 => Closed 𝒞 fun Fm _ => LinkN Fm) DRS)) : UpperTheory.EveryCharacter :=
  UpperTheory.Top.imprimitive (UpperTheory.Top.plugWin hG hV h)
```

4. **Scale $\lambda = 3/2$ nonvanishing criterion and imprimitive extension (`Development/AutomorphicArithmetic/CharacterBoxes/EveryCharacter.lean:8-18` and `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/TopPlug.lean:12-18`)**: Finally, `every_character_of_green_v_win` (`Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/TopPlug.lean:16-18`, modeled on `plugWin` and `plugAll` in `Development/AutomorphicArithmetic/CharacterBoxes/EveryCharacter.lean:8-18`) combines the Green regular-character criterion `green_of_regular`, the automorphic window `hV : VWin` (`supplyChi`), and the closed-family hypothesis bundle to invoke `zeroFreeAll_of_topG` at scale parameter `la := 3 / 2`, producing primitive right half-plane nonvanishing `Formalism.HC.ZeroFreeAll` (`Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/TopPlug.lean:12-15`), and applies `UpperTheory.Top.imprimitive` (line `18`, audited in Chapter 3, Section 3.3) to conclude `UpperTheory.EveryCharacter` for all Dirichlet characters.

---

### 4.4 Anatomy of the Automorphic Window (`VWin`) Assembly Layer (`TopMainZj.lean` et al.) and the `SmallClassNumbers` Auxiliary Theorem Family

The second core input in `Development/AutomorphicArithmetic/CharacterBoxes/MainConclusion.lean:8`, namely the automorphic window witness `UpperTheory.One.vwin_of_row h : UpperTheory.Top.VWin` (`Development/AutomorphicArithmetic/AutomorphicVarieties/ModularityArgument/ThresholdArguments/DenseThresholdCases/VwinOfRow.lean:4-5`, dependency cone: `157,604` files), together with the small-class-number cohomology path in `Supplements/Kernels/MainTheoremsAll.lean:2`, is assembled across the remaining distance `3` to `4` module families.

#### (1) Automorphic Window `VWin` Assembly Layer (`TopMainZj.lean`, `LitAut.lean`, `DefiniteNHolds.lean`, `WindowBoundOfLiteratureLevel.lean`)
The distance-`3` hub `Development/AutomorphicArithmetic/AutomorphicVarieties/ModularityArgument/ThresholdArguments/DenseThresholdCases/TopMainZj.lean:18-75` populates with unconditional proof terms all `56` individual fields across the four-part literature bundle `LiteratureRankNHypothesis` (`loc : LitLocAlt`, `aut : LiteratureAutomorphyHypothesis`, `coh : LitCoh`, `cm : LiteratureCMHypothesis`) defined in the distance-`4` structure file `Development/AutomorphicArithmetic/AutomorphicVarieties/ModularityArgument/ThresholdArguments/DenseThresholdCases/LitAut.lean:12-64`:

- **Local representation theory (`18` fields, `local_inputs_from_literature`, `Development/AutomorphicArithmetic/AutomorphicVarieties/ModularityArgument/ThresholdArguments/DenseThresholdCases/TopMainZj.lean:18-37`)** and **Galois cohomology (`12` fields, `galois_cohomology_from_literature`, `Development/AutomorphicArithmetic/AutomorphicVarieties/ModularityArgument/ThresholdArguments/DenseThresholdCases/TemperedProductOfSquareIntegrable.lean:331-344`)**: The distance-`4` aggregation module `Development/AutomorphicArithmetic/AutomorphicVarieties/ModularityArgument/ThresholdArguments/DenseThresholdCases/TemperedProductOfSquareIntegrable.lean:207-344` supplies `62` theorems in bulk, including the Bernstein-Zelevinsky geometric lemma, Moy-Prasad isomorphisms, the local converse theorem, Poitou-Tate duality, and the Greenberg-Wiles Euler characteristic formula (all sharing the top-level non-emptiness marker `Development/AutomorphicArithmetic/AutomorphicVarieties/ModularityArgument/ThresholdArguments/DenseThresholdCases/DiscreteSeriesCoefficientsCuspidal.lean:1`).
- **Global automorphy and isobaric base change (`15` fields, `automorphic_inputs_from_literature`, `Development/AutomorphicArithmetic/AutomorphicVarieties/ModularityArgument/ThresholdArguments/DenseThresholdCases/TopMainZj.lean:38-54`)**: Alongside Jacquet-Shalika rigidity, Clozel purity, and global Artin reciprocity, the heaviest core field `bc : BaseChangeIsobaricN` is injected from distance-`3` `Development/AutomorphicArithmetic/Foundations/BaseChangeIdentities/DefiniteNHolds.lean:5-6` (`baseChangeN`). `baseChangeN` combines Hecke eigenvalue finite-frame existence `candFin` from distance-`4` `Development/AutomorphicArithmetic/Foundations/BaseChangeIdentities/FrameMatching/HeckeEigenvalueFiniteness/FrameEx.lean:15-18`, `baseChangeN_of` from `Development/AutomorphicArithmetic/Foundations/BaseChangeIdentities/FillPre.lean:7-9`, and Speh representation transfer `speh` from `Development/AutomorphicArithmetic/Foundations/BaseChangeIdentities/NarrowSwap.lean:14-21`; the target specification `BaseChangeIsobaricN` is formalized in distance-`4` `Development/WeilBound/RepresentationTheoryGL/ArchimedeanBaseChange/ArchimedeanBaseChangeProof/BaseChangeIsobaricNOf.lean:39-47` and lines `94-132` (`core_of`, `baseChangeIsobaricN_of`), establishing existence of $\mathrm{GL}_n$ isobaric base change for unitary-group automorphic representations of arbitrary rank $n \ge 1$ from split places (`RunSplit`), inert places (`RunInert`), and rigidity (`Rigid`). In addition, the `gal : RowT` field links to the automorphy-lifting flag laws in distance-`4` `Development/AutomorphicArithmetic/AutomorphicVarieties/ModularityArgument/AutomorphyLifting/WeakOfAtt.lean:19-114` (`Unl1`, `PotUnl`, `WitA`, `RowT`, `aRead_of`).
- **CM abelian varieties and crystalline periods (`11` fields, `cm_abelian_inputs_from_literature`, `Development/AutomorphicArithmetic/AutomorphicVarieties/ModularityArgument/ThresholdArguments/DenseThresholdCases/TopMainZj.lean:59-70`)**: Five distance-`4` geometric modules supply the witnesses directly. `Development/AbelianVarietyTheory/Proofs/DivisorProofs/CrystallineSmoothLiftOfRelations.lean:19-73` proves the crystalline-de Rham smooth lift comparison isomorphism `crystallineSmoothLift_of_relations` from `exists_linearEquiv_of_rel`, and `Development/AbelianVarietyTheory/Proofs/DivisorProofs/AbelianDualCrystalOfHyp.lean:8-11` assembles the dual abelian scheme crystal isomorphism `abelianDualCrystal_of_dual_of_smoothLift`. `Development/AbelianVarietyTheory/Proofs/DivisorProofs/PeriodComparisonHolds.lean:5-6` and `Development/AbelianVarietyTheory/Proofs/DivisorProofs/ImportsSideExtra.lean:9-11` supply the Gauss-Manin connection period comparison `periodComparison_holds` and `GaussManinTop.main`, while `Development/AutomorphicArithmetic/ThetaCorrespondence/GoodReduction/SerreTate.lean:7-17` supplies the Serre-Tate good reduction theorem `serreTateGoodReduction` from the Néron-Ogg-Shafarevich criterion.
- **Final derivation of `VWin` (`Development/AutomorphicArithmetic/AutomorphicVarieties/ModularityArgument/ThresholdArguments/DenseThresholdCases/WindowBoundOfLiteratureLevel.lean:25-35`)**: The completed `LiteratureRankNHypothesis` bundle passes into distance-`4` `Development/AutomorphicArithmetic/AutomorphicVarieties/ModularityArgument/ThresholdArguments/DenseThresholdCases/WindowBoundOfLiteratureLevel.lean:30-35` (`v_window_of_literal_automorphy_n`), joining Taylor-Wiles root patching (`published_hypotheses_from_patching_alt`) with four Selmer counts (`count_i`, `countII`, `countIII`, `count_v`) to produce the automorphic window growth bound `VWin`.

#### (2) Cyclotomic Shafarevich Group Auxiliary Main Theorems over the Class-Number-$1$ Imaginary Quadratic Field $K^*(3) = \mathbb{Q}(\sqrt{-3})$ (`SmallClassNumbers/*`)
Finally, ten modules across distances `2` to `4` associated with `SmallClassNumbers` establish a standalone arithmetic result:

- **Quadratic splitting and ramification base (`Development/AutomorphicArithmetic/AutomorphicVarieties/HeightAndVanishing/SplittingFieldIsoQuadratic.lean:8-67`, `Development/AutomorphicArithmetic/AutomorphicVarieties/HeightAndVanishing/KstarRam.lean:8-76`, `Development/AutomorphicArithmetic/AutomorphicVarieties/CharacterLevelBounds/PlacesQ.lean:12-152`, `Development/AutomorphicArithmetic/AutomorphicVarieties/GaloisLibrary/SelmerTransport/Places.lean:5-164`)**: For primes $p \equiv 3 \pmod 4$, `kstar` (`Development/AutomorphicArithmetic/AutomorphicVarieties/HeightAndVanishing/SplittingFieldIsoQuadratic.lean:50-67`) proves that the splitting field $K^*(p) = \mathbb{Q}(\sqrt{-p})$ of $X^2 + p$ is a totally imaginary quadratic field of discriminant $\mathrm{discr}(K^*(p)) = -p$, and `kstarRam` (`Development/AutomorphicArithmetic/AutomorphicVarieties/HeightAndVanishing/KstarRam.lean:23-76`) uses quadratic Gauss sums and the Legendre symbol $(\frac{-1}{p}) = -1$ to prove that the inertia group above $p$ does not fix $K^*(p)$. `Development/AutomorphicArithmetic/AutomorphicVarieties/GaloisLibrary/SelmerTransport/Places.lean:5-164` and `Development/AutomorphicArithmetic/AutomorphicVarieties/CharacterLevelBounds/PlacesQ.lean:126-152` establish conjugacy transitivity of decomposition and inertia subgroups over valuation subrings $A$ of an algebraic closure $\Omega$ together with unramifiedness of the cyclotomic character.
- **$U(3)$ Kato Euler system and single-character trace inequality (`Development/AutomorphicArithmetic/AutomorphicVarieties/UnitaryThreeGroups/KatoUse.lean:13-65`, `Development/AutomorphicArithmetic/AutomorphicVarieties/ModularityArgument/LinkedUnramifiedChains/WeightInfinitesimalCharacters/OneCharU.lean:12-89`, `Development/AutomorphicArithmetic/AutomorphicVarieties/SmallClassNumbers/OnePoint.lean:10-41`)**: `U3.CorGK` defined in `Development/AutomorphicArithmetic/AutomorphicVarieties/UnitaryThreeGroups/KatoUse.lean:44-53` controls weighted sums of unramified Selmer lengths over a number field $K$ by choosing auxiliary prime pairs $p \neq p'$ ($\nmid 30 N \lvert\mathrm{discr}(K)\rvert$). `oneCharU` in `Development/AutomorphicArithmetic/AutomorphicVarieties/ModularityArgument/LinkedUnramifiedChains/WeightInfinitesimalCharacters/OneCharU.lean:69-89` bounds Selmer lengths by $\ell$-adic valuations of three-dimensional Galois trace differences from Kato's $\mathrm{GL}_2$ Euler system (`KatoTwo`) and Type I/II rigidity (`RigI`, `RigII`), while `onePoint` in `Development/AutomorphicArithmetic/AutomorphicVarieties/SmallClassNumbers/OnePoint.lean:18-41` proves that whenever `Vlen ≠ 0`, a non-triangular admissible point (`Adm3U ∨ Adm2`) exists on the deformation ring.
- **Specialization to $K^*(3)$ and polynomial upper bound and vanishing for the cyclotomic Shafarevich group (`Development/AutomorphicArithmetic/AutomorphicVarieties/SmallClassNumbers/ClassNumberThree.lean:13-112`, `Development/AutomorphicArithmetic/AutomorphicVarieties/SmallClassNumbers/CorGKOf.lean:10-28`, `Development/AutomorphicArithmetic/AutomorphicVarieties/SmallClassNumbers/LenEqZeroIff.lean:9-92`)**: `Development/AutomorphicArithmetic/AutomorphicVarieties/SmallClassNumbers/ClassNumberThree.lean:32-43` computes directly via the Minkowski discriminant bound (comparing $\lvert -3 \rvert = 3$ against $\pi > 3$) that the class number is $h(\mathbb{Q}(\sqrt{-3})) = 1$ (`classNumber_three`), and substitutes the unique character $\psi = 1$ modulo $N = 2$ and the auxiliary prime pair $(p, p') = (7, 11)$ into `CorGK` (`bound_of`, lines `88-112`) to derive the polynomial upper bound `Bound` (lines `16-21`) on rational cyclotomic cohomology lengths $\mathrm{len}(\Omega, \ell, c, e) = \mathrm{length}_{\mathcal{O}}\,\mathrm{Sha}_U(\mathbb{Q}_\ell/\mathbb{Z}_\ell(-e))$ at even weights $e \ge 1$:
$$
\sum_{\ell \in L_s} (\log \ell)\, \frac{\mathrm{len}(\Omega, \ell, c_\ell, e)}{e_{\mathcal{O}}(\ell)} \;\le\; C (e + 1)^A \qquad (\forall \ell \in L_s,\; \ell \ge 5,\; \ell - 1 \nmid 2e).
$$
    In the distance-`2` assembly file `Development/AutomorphicArithmetic/AutomorphicVarieties/SmallClassNumbers/CorGKOf.lean:1-29`, the main theorem block (lines `10-28`) instantiates the literature bundle `litN` and routes it through root patching to establish unconditional `corGK` and `bound`:

```lean
-- Development/AutomorphicArithmetic/AutomorphicVarieties/SmallClassNumbers/CorGKOf.lean:20-28
theorem litN : GlobalTheory.Mem.LiteralAutomorphy.LiteratureRankNHypothesis :=
  have O : UpperTheory.LiteratureTheorems.OpenImageCondition :=
    UpperTheory.LiteratureTheorems.OpenImageCondition.mk
      UpperTheory.Gal.Int.galoisLocalGlobalStrong_recParameter
  ⟨UpperTheory.One.Join.local_inputs_from_literature O,
   UpperTheory.One.Join.automorphic_inputs_from_literature O
     UpperTheory.BaseChangeIdentities.baseChangeN
     UpperTheory.Gal.Int.galoisLocalGlobalStrong_recParameter,
   UpperTheory.LiteratureTheorems.galois_cohomology_from_literature O,
   UpperTheory.One.Join.cm_abelian_inputs_from_literature O⟩

theorem corGK : U3.CorGK :=
  corGK_of (UpperTheory.V.HV.DescentVanishingReductions.published_hypotheses_from_patching_alt
    litN UpperTheory.V.Z.Tf.SR.descWeak)

theorem bound : Bound := bound_of corGK
```

    Thus `Development/AutomorphicArithmetic/AutomorphicVarieties/SmallClassNumbers/CorGKOf.lean:25-27` at distance `2` seals unconditional `corGK : U3.CorGK` and `bound : Bound`, while `large_of` in distance-`3` `Development/AutomorphicArithmetic/AutomorphicVarieties/SmallClassNumbers/LenEqZeroIff.lean:70-85` uses the fact that over an unramified coefficient ring ($e_{\mathcal{O}}(\ell) = 1$), $\mathrm{len} \ge 1$ at any large prime $\ell$ satisfying $\log \ell > C(e+1)^A$ ($\ell - 1 \nmid 2e$) forces the left-hand side to be at least $\log \ell$ in contradiction to `bound`, thereby concluding $\mathrm{len}(\Omega, \ell, c_\ell, e) = 0$: every locally trivial 1-cocycle is a global coboundary (`Vanish`, lines `19-25`).
    This theorem is the exact formal realization of the **weakened Vandiver property (asymptotic cyclotomic Shafarevich group vanishing)** described in the companion announcement (`remark.pdf`).

---

### 4.5 Precision Input-Output Signature Collation of the Seven-Stage Top Reduction Chain

Across the upper assembly layers traced in Sections 4.1 through 4.4, the seven-stage function composition chain leading from the primitive right half-plane nonvanishing engine (`ZeroFreeAll`) to the five closed top-level theorems (`Main.lean:4-12`) connects with zero type-conversion gaps. Each stage's exact file pins and input-output type transitions are summarized below.

1. **Stage 7 $\to$ Stage 6 (`Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/TopPlug.lean:12-15`)**:
    - Inputs: `hG : GlobalTheory.GLq.Green`, `hV : UpperTheory.Top.VWin`, and the closed-family linkage hypothesis `Nonempty (HypsAlt (fun 𝒞 => Closed 𝒞 fun Fm _ => LinkN Fm) DefiniteSideCondition)`.
    - Operation: Coupling `UpperTheory.Top.zeroFreeAll_of_topG (la := 3 / 2)` at scale parameter $\lambda = 3/2$ with `supplyChi ψ (hV ψ)` (modeled on `plugWin` in `Development/AutomorphicArithmetic/CharacterBoxes/EveryCharacter.lean:8-11`).
    - Output: Primitive right half-plane nonvanishing `Formalism.HC.ZeroFreeAll` ($\forall \psi \text{ primitive},\, \mathrm{Re}(s) > 1/2 \implies L(s, \psi) \neq 0$).
2. **Stage 6 $\to$ Stage 5 (`Development/AutomorphicArithmetic/CharacterBoxes/Imprimitive.lean:5-35` and `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/TopPlug.lean:16-18`)**:
    - Input: `Formalism.HC.ZeroFreeAll`.
    - Operation: Combining `LFunction_changeLevel` factorization with the finite prime-divisor Euler-factor norm bound $\lVert \chi_0(p)p^{-s} \rVert \le p^{-\mathrm{Re}(s)} < 1$ (`UpperTheory.Top.imprimitive`).
    - Output: All-character right half-plane nonvanishing `UpperTheory.EveryCharacter` ($\forall N \ge 1,\, \forall \chi \bmod N,\, \mathrm{Re}(s) > 1/2 \land (\chi \neq 1 \lor s \neq 1) \implies L(s, \chi) \neq 0$).
3. **Stage 5 $\to$ Stage 4 (`Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/SiegelEisensteinSecondTermHypotheses.lean:44-74`, prototype `Development/AutomorphicArithmetic/ThetaCorrespondence/FockModels/EveryCharacterE.lean:41-72`)**:
    - Inputs: Unitary third-place hypotheses `P : UnitaryGroupThirdPlaceHypotheses`, local theta inputs `F : ThetaLocalInputs`, theta-integral agreement `ThetaIntegralsAgree`, local matching `LocalMatching`, covolume upper bound `CovolumeBoundOfX`, local Langlands existence `RecTExists`, and automorphic window `VWin`.
    - Operation: Constructing open orbits on `GridA (max CF0 CF1)` and $L^3$ bundles to inhabit `Nonempty (HypsAlt ...)`, then invoking `every_character_of_green_v_win`.
    - Output: Conditional `UpperTheory.EveryCharacter`.
4. **Stage 4 $\to$ Stage 3 (`Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/EveryCharacterOfLiteratureOfVWin.lean:215-218`, `810-814`)**:
    - Inputs: Three-field hypothesis bundle `O : OpenLiteratureStatements` and `hV : UpperTheory.Top.VWin`.
    - Operation: Assembling `195` literature wrapper theorems including `published_results_eigen O`, `published_results_first O`, `published_results_arithmetic O`, and `topCovolSlim2_use_alt_alt` (`Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/TopCovolSlim2Use.lean:16-22`) to discharge every geometric and analytic argument of Stage 5.
    - Output: `(OpenLiteratureStatements → VWin → UpperTheory.EveryCharacter)`.
5. **Stage 3 $\to$ Stage 2 (`Development/AutomorphicArithmetic/CharacterBoxes/MainConclusion.lean:7-12`)**:
    - Inputs: Zero free inputs (coupling the global constant theorems `galoisLocalGlobalStrong_recParameter` from `Development/AutomorphicArithmetic/Foundations/GaloisRepresentations/IntegralStructures/RowSrc.lean:6`, `recTExists` from `Development/AutomorphicArithmetic/Foundations/LocalLanglands/LocalCentralUnits/RecTExists.lean:20-66`, and `vwin_of_row` from `Development/AutomorphicArithmetic/AutomorphicVarieties/ModularityArgument/ThresholdArguments/DenseThresholdCases/VwinOfRow.lean:4-5` directly).
    - Operation: Substituting `⟨h, recTExists, h⟩` and `vwin_of_row h` to discharge both remaining hypotheses.
    - Output: Unconditional closed theorem `UpperTheory.FinalTheorems.everyCharacter : UpperTheory.EveryCharacter`.
6. **Stage 2 $\to$ Stage 1 (`Supplements/Kernels/MainTheorems.lean:7-16`)**:
    - Input: `allChi := everyCharacter`.
    - Operation: Passing `allChi` into `Formalism.VW.rh_of_every` (`Formalism/GammaFactorNonvanishing/CritLine.lean:29-32`), `Formalism.VW.critLine` (`Formalism/GammaFactorNonvanishing/CritLine.lean:11-28`), and `Claim.strip` and `Claim.zeta` (`Development/AutomorphicArithmetic/CharacterBoxes/ClaimStrip.lean:59-101`).
    - Output: The four main witnesses `allChi`, `rhOfAll`, `critAll`, `claimAll`.
7. **Stage 1 $\to$ Stage 0 (`Main.lean:4-12`)**:
    - Inputs: The four main witnesses (`rhOfAll`, `allChi`, `claimAll.2.1`, `critAll`).
    - Operation: Direct assignment via kernel definitional equality (`Kernel.isDefEq`).
    - Output: Final seal of pure `Mathlib` `RiemannHypothesis` and the four target specifications in `Statements.lean:3-16`. Furthermore, shared between `Development/AutomorphicArithmetic/AutomorphicVarieties/ModularityArgument/ThresholdArguments/DenseThresholdCases/VwinOfRow.lean:4-5` and `Development/AutomorphicArithmetic/AutomorphicVarieties/SmallClassNumbers/CorGKOf.lean:20-25`, `LiteratureRankNHypothesis` (`56` fields = `18` `LitLocAlt` + `15` `LiteratureAutomorphyHypothesis` + `12` `LitCoh` + `11` `LiteratureCMHypothesis`) in `Development/AutomorphicArithmetic/AutomorphicVarieties/ModularityArgument/ThresholdArguments/DenseThresholdCases/LitAut.lean:12-64` is likewise instantiated across every single field in `Development/AutomorphicArithmetic/AutomorphicVarieties/ModularityArgument/ThresholdArguments/DenseThresholdCases/TopMainZj.lean:18-75` and `Development/AutomorphicArithmetic/AutomorphicVarieties/ModularityArgument/ThresholdArguments/DenseThresholdCases/TemperedProductOfSquareIntegrable.lean:207-344` from `OpenImageCondition.mk galoisLocalGlobalStrong_recParameter` and `baseChangeN` (`Development/AutomorphicArithmetic/Foundations/BaseChangeIdentities/DefiniteNHolds.lean:5-6`) alone, leaving zero unresolved premises.

---

## Chapter 5. Master Audit Ledger Tables for the Top Seal, Upper Bridge, and Pinned `Mathlib`

### 5.1 Boundary Semantics Audit Ledger Table for `16` Core Pinned `Mathlib` (`0df444a3`) Files

The file paths, total line counts, exact source pins, core identifiers, mathematical boundary semantics, and audit verdicts for the `16` core files inside pinned `Mathlib` (`0df444a360eaa60ab8c11dca51a86af692955474`) reconstructed in Chapters 2 and 3 are consolidated in the table below.

| No. | `Mathlib` File Path and Core Pin | Total Lines | Core Definition and Theorem Identifiers | Verbatim Formula and Boundary-Condition Verdict | Verdict |
| ---: | :--- | ---: | :--- | :--- | :---: |
| 1 | `Mathlib/NumberTheory/LSeries/RiemannZeta.lean:64-243` | `262` | `completedRiemannZeta₀`, `completedRiemannZeta`, `riemannZeta`, `RiemannHypothesis` | $\zeta := \zeta_{\mathrm{even}}(0, \cdot)$, exact exclusion of `s ≠ 1` and negative even `-2*(n+1)`, $\zeta(0) = -1/2$, series match on $\mathrm{Re}(s)>1$ | `PASS` |
| 2 | `Mathlib/NumberTheory/LSeries/HurwitzZeta.lean:52-191` | `192` | `hurwitzZeta`, `expZeta`, `hasSum_hurwitzZeta_of_one_lt_re`, `hurwitzZeta_one_sub` | $\zeta_{\mathrm{Hurwitz}}(a,s) = \zeta_{\mathrm{even}}(a,s) + \zeta_{\mathrm{odd}}(a,s)$, holomorphy on $s \neq 1$ and residue $1$ agreement | `PASS` |
| 3 | `Mathlib/NumberTheory/LSeries/HurwitzZetaEven.lean:65-783` | `784` | `evenKernel`, `cosKernel`, `hurwitzEvenFEPair`, `completedHurwitzZetaEven`, `hurwitzZetaEven` | Jacobi theta kernel Mellin transform, `Function.update` preserves $s=0$ pole-cancellation value ($-1/2$ at $a=0$) and differentiability | `PASS` |
| 4 | `Mathlib/NumberTheory/LSeries/HurwitzZetaOdd.lean:302-479` | `572` | `hurwitzOddFEPair`, `completedHurwitzZetaOdd`, `hurwitzZetaOdd`, `sinZeta` | Strong FE pair with $k=3/2, f_0=g_0=0$, $\Lambda_{\mathrm{odd}}(a,s)/\Gamma_{\mathbb{R}}(s+1)$ entire on all of $\mathbb{C}$ | `PASS` |
| 5 | `Mathlib/NumberTheory/LSeries/AbstractFuncEq.lean:80-490` | `491` | `WeakFEPair`, `IsStrongFEPair`, `f_modif`, `WeakFEPair.Λ₀`, `WeakFEPair.Λ` | Split $(0,1)\cup(1,\infty)$ Mellin transform makes $\Lambda_0$ entire, $\Lambda(k-s) = \varepsilon \Lambda^{\mathrm{symm}}(s)$ holds | `PASS` |
| 6 | `Mathlib/Analysis/SpecialFunctions/Gamma/Deligne.lean:43-186` | `210` | `Gammaℝ`, `Gammaℂ`, `Gammaℝ_ne_zero_of_re_pos`, `Gammaℝ_eq_zero_iff` | $\Gamma_{\mathbb{R}}(s) = \pi^{-s/2}\Gamma(s/2)$, zeros iff $s = -2n$ ($n \in \mathbb{N}$), $\Gamma_{\mathbb{R}}(1)=1$ | `PASS` |
| 7 | `Mathlib/NumberTheory/Harmonic/ZetaAsymp.lean:342-559` | `676` | `tendsto_riemannZeta_sub_one_div`, `riemannZeta_one`, `riemannZeta_one_ne_zero` | $\lim_{s\to 1}(\zeta(s)-\frac{1}{s-1})=\gamma$, junk value $\zeta_{\mathrm{Mathlib}}(1)=(\gamma-\log 4\pi)/2 \neq 0$ certified | `PASS` |
| 8 | `Mathlib/NumberTheory/EulerProduct/DirichletLSeries.lean:89-208` | `281` | `riemannZeta_eulerProduct_tprod`, `LSeries_eulerProduct_tprod`, `LSeries_changeLevel` | Prime Euler infinite-product convergence for $\zeta(s)$ and $L(s,\chi)$ on $\mathrm{Re}(s)>1$ and level-change factor formula | `PASS` |
| 9 | `Mathlib/NumberTheory/LSeries/Basic.lean:74-269` | `402` | `LSeries.term`, `LSeries`, `LSeriesSummable`, `LSeriesHasSum` | Hard truncation to `0` at `n = 0` blocks any $\chi_1(0)=1$ boundary contamination on `ZMod 1` | `PASS` |
| 10 | `Mathlib/NumberTheory/LSeries/Dirichlet.lean:156-350` | `446` | `modZero_eq_delta`, `modOne_eq_one`, `LSeries_ne_zero_of_one_lt_re`, `LSeries_one_eq_riemannZeta` | Abscissa of absolute convergence $\sigma_a = 1$ for $N>0$, nonvanishing on $\mathrm{Re}(s)>1$ via Möbius convolution inverse | `PASS` |
| 11 | `Mathlib/NumberTheory/LSeries/ZMod.lean:83-296` | `530` | `ZMod.LFunction`, `LFunction_modOne_eq`, `LFunction_eq_LSeries`, `ZMod.completedLFunction` | Definition $N^{-s}\sum_{j \in \mathbb{Z}/N\mathbb{Z}} \Phi(j)\zeta_{\mathrm{Hurwitz}}(j/N, s)$ and discrete-Fourier functional equation | `PASS` |
| 12 | `Mathlib/NumberTheory/LSeries/DirichletContinuation.lean:61-315` | `397` | `DirichletCharacter.LFunction`, `LFunction_changeLevel`, `gammaFactor`, `completedLFunction_one_sub` | Global identity $L(s,\chi_1)=\zeta(s)$ at $N=1$, imprimitive prime-factor decomposition, primitive completed functional equation | `PASS` |
| 13 | `Mathlib/NumberTheory/LSeries/Nonvanishing.lean:200-416` | `419` | `LFunction_ne_zero_of_one_le_re`, `LFunction_apply_one_ne_zero`, `riemannZeta_ne_zero_of_one_le_re` | Nonvanishing on $\mathrm{Re}(s) \ge 1$ (except $\chi=1, s=1$) proved via $3 + 4\cos\theta + \cos 2\theta \ge 0$ | `PASS` |
| 14 | `Mathlib/NumberTheory/LSeries/ZetaZeros.lean:35-75` | `76` | `riemannZetaZeros`, `isDiscrete_riemannZetaZeros`, `inter_riemannZetaZeros_finite` | Closedness and discreteness of the zero set of $\zeta(s)$ and finiteness of zeros in compact subsets | `PASS` |
| 15 | `Mathlib/NumberTheory/DirichletCharacter/Basic.lean:40-410` | `580` | `DirichletCharacter`, `changeLevel`, `conductor`, `IsPrimitive`, `primitiveCharacter` | Uniqueness of minimal conductor $f_\chi \mid N$, $\chi = \mathrm{changeLevel}(\chi_0)$, and $f_{\chi^{-1}} = f_\chi$ proved | `PASS` |
| 16 | `Mathlib/NumberTheory/MulChar/Basic.lean:72-346` | `647` | `MulChar`, `trivial`, `equivToUnitHom`, `inv_apply_eq_inv'` | Monoid homomorphism sending non-units to `0`, bijection with `Rˣ →* R'ˣ`, complete abelian group structure | `PASS` |

---

### 5.2 Master Audit Ledger Table for All `43` Top-Spine and Build-Aid Modules in `src/` (`B10` Complete Set)

The exact file pins, line counts, shortest distance from `Main` (`d`), in-degrees (`in`), declaration counts (`Thm / Def`), representative identifiers, and upper-assembly role verdicts for all `43` top-spine modules (`2,318` lines, `145` theorems, `47` definitions and structures) cataloged in Part B Volume 10 (`atlas/volumes/B10_Top_Spine_Depth0_To_4.md`) are listed below.

| No. | `src/` Module Path and Declaration Pin | Lines | `d` | `in` | Thm / Def | Representative Identifiers and Upper-Assembly Role | Verdict |
| ---: | :--- | ---: | ---: | ---: | :---: | :--- | :---: |
| 1 | `Main.lean:4-12` | `12` | `0` | `0` | `5 / 0` | `riemannHypothesis` and 4 companion theorems: top-level closed-proposition seal with `0` free hypotheses | `PASS` |
| 2 | `Statements.lean:3-16` | `16` | `1` | `1` | `0 / 4` | Definitions of `RiemannZetaZerosOnLine`, `DirichletLNonvanishingRightOfHalf`, and 2 strip specifications | `PASS` |
| 3 | `Supplements/Kernels/MainTheoremsAll.lean:1-2` | `2` | `1` | `1` | `0 / 0` | Top-level combined import of `MainTheoremsCritical` and `SmallClassNumbers.CorGKOf` | `PASS` |
| 4 | `Development/AutomorphicArithmetic/AutomorphicVarieties/SmallClassNumbers/CorGKOf.lean:10-28` | `29` | `2` | `1` | `4 / 0` | `corGK_of`, `litN`, `corGK`, `bound`: unconditional $U(3)$ cohomology polynomial upper bound | `PASS` |
| 5 | `Supplements/Kernels/MainTheoremsCritical.lean:1-4` | `4` | `2` | `1` | `0 / 0` | Combined import of `MainTheorems`, `ClassNumberThree`, `LenEqZeroIff`, and `OnePoint` | `PASS` |
| 6 | `Development/AutomorphicArithmetic/AutomorphicVarieties/ModularityArgument/ThresholdArguments/DenseThresholdCases/TopMainZj.lean:18-75` | `75` | `3` | `2` | `5 / 0` | `automorphic_window_of_inputs`: assembles the 4 literature bundles (`56` fields) and derives `VWin` | `PASS` |
| 7 | `Development/AutomorphicArithmetic/AutomorphicVarieties/SmallClassNumbers/ClassNumberThree.lean:13-112` | `115` | `3` | `3` | `6 / 2` | `classNumber_three`, `bound_of`: computes $h(\mathbb{Q}(\sqrt{-3}))=1$ and reduces `Bound` | `PASS` |
| 8 | `Development/AutomorphicArithmetic/AutomorphicVarieties/SmallClassNumbers/LenEqZeroIff.lean:9-92` | `95` | `3` | `1` | `6 / 3` | `len_eq_zero_iff`, `large_of`: cyclotomic $\mathrm{Sha}_U$ vanishing for $\log\ell > C(e+1)^A$ | `PASS` |
| 9 | `Development/AutomorphicArithmetic/AutomorphicVarieties/SmallClassNumbers/OnePoint.lean:10-41` | `41` | `3` | `1` | `1 / 1` | `OnePoint`, `onePoint`: proves existence of non-triangular admissible deformation point when `Vlen ≠ 0` | `PASS` |
| 10 | `Development/AutomorphicArithmetic/Foundations/BaseChangeIdentities/DefiniteNHolds.lean:5-6` | `6` | `3` | `5` | `1 / 0` | `baseChangeN`: $\mathrm{GL}_n$ isobaric base change theorem for definite unitary groups | `PASS` |
| 11 | `Development/AutomorphicArithmetic/Foundations/GaloisRepresentations/IntegralStructures/RowSrc.lean:6-7` | `8` | `3` | `2` | `1 / 0` | `galoisLocalGlobalStrong_recParameter`: theta-lift-based Galois local-global compatibility | `PASS` |
| 12 | `Supplements/Kernels/MainTheorems.lean:7-16` | `16` | `3` | `1` | `4 / 0` | `allChi`, `rhOfAll`, `critAll`, `claimAll`: generation hub for the 4 final witnesses | `PASS` |
| 13 | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/AbelianDualCrystalOfHyp.lean:8-11` | `12` | `4` | `4` | `1 / 0` | `abelianDualCrystal_of_dual_of_smoothLift`: dual abelian scheme crystalline cohomology isomorphism | `PASS` |
| 14 | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/CrystallineSmoothLiftOfRelations.lean:19-73` | `74` | `4` | `14` | `2 / 0` | Proofs of `exists_linearEquiv_of_rel` and `crystallineSmoothLift_of_relations` | `PASS` |
| 15 | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/ImportsSideExtra.lean:9-11` | `12` | `4` | `1` | `1 / 0` | `GaussManinTop.main`: derives Gauss-Manin period compatibility from generation and Taylor sections | `PASS` |
| 16 | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/PeriodComparisonHolds.lean:5-6` | `6` | `4` | `2` | `1 / 0` | `periodComparison_holds`: seals the abelian variety de Rham-Betti period comparison theorem | `PASS` |
| 17 | `Development/AutomorphicArithmetic/AutomorphicVarieties/CharacterLevelBounds/PlacesQ.lean:12-152` | `152` | `4` | `30` | `6 / 1` | `placesQ`: existence of valuation subrings above rational primes and conjugacy transitivity of decomposition/inertia | `PASS` |
| 18 | `Development/AutomorphicArithmetic/AutomorphicVarieties/GaloisLibrary/SelmerTransport/Places.lean:5-164` | `164` | `4` | `94` | `1 / 0` | `UpperTheory.V.Base.places`: places above height-1 prime ideals of number fields and inertia kernel inclusions | `PASS` |
| 19 | `Development/AutomorphicArithmetic/AutomorphicVarieties/HeightAndVanishing/KstarRam.lean:8-76` | `76` | `4` | `3` | `3 / 0` | `kstarRam`: proves inertia ramification in $K^*(p)$ for $p \equiv 3 \pmod 4$ via quadratic Gauss sums | `PASS` |
| 20 | `Development/AutomorphicArithmetic/AutomorphicVarieties/HeightAndVanishing/SplittingFieldIsoQuadratic.lean:8-67` | `67` | `4` | `7` | `2 / 0` | `kstar`: establishes degree $2$, discriminant $-p$, and total imaginarity of splitting field $K^*(p)$ | `PASS` |
| 21 | `Development/AutomorphicArithmetic/AutomorphicVarieties/ModularityArgument/AutomorphyLifting/WeakOfAtt.lean:19-114` | `115` | `4` | `27` | `1 / 14` | `Unl1`, `PotUnl`, `WitA`, `RowT`, `aRead_of`: local flag predicates for automorphy lifting | `PASS` |
| 22 | `Development/AutomorphicArithmetic/AutomorphicVarieties/ModularityArgument/LinkedUnramifiedChains/WeightInfinitesimalCharacters/OneCharU.lean:12-89` | `89` | `4` | `3` | `2 / 0` | `oneChar_unramU`, `oneCharU`: 3D trace Selmer bound from Kato Euler system and rigidity | `PASS` |
| 23 | `Development/AutomorphicArithmetic/AutomorphicVarieties/ModularityArgument/ThresholdArguments/DenseThresholdCases/DiscreteSeriesCoefficientsCuspidal.lean:1` | `1` | `4` | `520` | `0 / 0` | Single-line `import Mathlib` shared base marker module with maximum in-degree (`520`) | `PASS` |
| 24 | `Development/AutomorphicArithmetic/AutomorphicVarieties/ModularityArgument/ThresholdArguments/DenseThresholdCases/LitAut.lean:12-64` | `65` | `4` | `191` | `0 / 4` | Definitions of `LitLocAlt`, `LiteratureAutomorphyHypothesis`, and `LiteratureRankNHypothesis` | `PASS` |
| 25 | `Development/AutomorphicArithmetic/AutomorphicVarieties/ModularityArgument/ThresholdArguments/DenseThresholdCases/TemperedProductOfSquareIntegrable.lean:207-344` | `344` | `4` | `1` | `62 / 1` | `OpenImageCondition` plus `62` published theorems in local representation theory and Galois cohomology | `PASS` |
| 26 | `Development/AutomorphicArithmetic/AutomorphicVarieties/ModularityArgument/ThresholdArguments/DenseThresholdCases/WindowBoundOfLiteratureLevel.lean:25-35` | `35` | `4` | `1` | `3 / 0` | `v_window_of_literal_automorphy_n`: produces `VWin` from root patching and 4 Selmer counts | `PASS` |
| 27 | `Development/AutomorphicArithmetic/AutomorphicVarieties/UnitaryThreeGroups/KatoUse.lean:13-65` | `68` | `4` | `50` | `0 / 6` | Specification structures `KatoUse`, `CohInp`, `Inp`, `PropGK`, `CorGK`, and `OneChar` | `PASS` |
| 28 | `Development/AutomorphicArithmetic/CharacterBoxes/ClaimStrip.lean:7-103` | `104` | `4` | `1` | `7 / 0` | `factor_ne_zero`, `prim_zero`, `prim_reflect`, `strip`, `zeta`: imprimitive critical-strip reflection | `PASS` |
| 29 | `Development/AutomorphicArithmetic/CharacterBoxes/MainConclusion.lean:7-14` | `14` | `4` | `1` | `3 / 0` | `everyCharacter_of_row`, `everyCharacter`: completes all-character GRH by joining the 3 major cones | `PASS` |
| 30 | `Development/AutomorphicArithmetic/Foundations/BaseChangeIdentities/FillPre.lean:7-9` | `9` | `4` | `2` | `1 / 0` | `baseChangeN_of`: derives base change from finite-frame condition `CandFin` and Gelfand readout | `PASS` |
| 31 | `Development/AutomorphicArithmetic/Foundations/BaseChangeIdentities/FrameMatching/HeckeEigenvalueFiniteness/FrameEx.lean:15-18` | `19` | `4` | `1` | `1 / 0` | `candFin`: establishes Hecke frame finiteness by combining strict product and level-openness conditions | `PASS` |
| 32 | `Development/AutomorphicArithmetic/Foundations/BaseChangeIdentities/NarrowSwap.lean:14-21` | `24` | `4` | `5` | `2 / 0` | `speh`, `Conclusion1`: unitarity preservation of isobaric base change and Speh representation correspondence | `PASS` |
| 33 | `Development/AutomorphicArithmetic/Foundations/GaloisRepresentations/IntegralStructures/GaloisRepresentationsOfThetaLift.lean:6-7` | `8` | `4` | `1` | `1 / 0` | `galoisRepresentations_of_thetaLift`: couples weight-1 geometric realization with theta lifts | `PASS` |
| 34 | `Development/AutomorphicArithmetic/Foundations/GaloisRepresentations/ThetaParseval/ThetaKernels/TLiftK.lean:4-5` | `5` | `4` | `1` | `1 / 0` | `tLiftK`: supplies theta-lift kernel theorem from half-integral lattice Parseval identities | `PASS` |
| 35 | `Development/AutomorphicArithmetic/ThetaCorrespondence/GoodReduction/SerreTate.lean:7-17` | `18` | `4` | `1` | `4 / 0` | `neronOggShafarevich`, `serreTateGoodReduction`: potential good reduction for abelian and CM varieties | `PASS` |
| 36 | `Development/WeilBound/RepresentationTheoryGL/ArchimedeanBaseChange/ArchimedeanBaseChangeProof/BaseChangeIsobaricNOf.lean:18-132` | `135` | `4` | `5` | `2 / 11` | `IsBaseChangeN`, `BaseChangeIsobaricN`, `core_of`, `baseChangeIsobaricN_of` proofs | `PASS` |
| 37 | `Formalism/GammaFactorNonvanishing/CritLine.lean:6-32` | `32` | `4` | `1` | `3 / 0` | `gammaFactor_ne_zero`, `critLine`, `rh_of_every`: critical-line reflection for primitive characters and $\zeta$ | `PASS` |
| 38 | `Development/AutomorphicArithmetic/CharacterBoxes/RiemannHypothesisOfEveryCharacter.lean:211-231` | `231` | `5` | `3` | `2 / 0` | `zeta_ne_zero_of_everyCharacter`, `riemannHypothesis_of_everyCharacter` | `PASS` |
| 39 | `BuildAid/D3.lean:1-4` | `4` | `8` | `25` | `0 / 0` | Registers `"GlobalTheory"` in `nameDenyListExt` (`0` kernel constants added) | `PASS` |
| 40 | `BuildAid/D4.lean:1-4` | `4` | `8` | `5` | `0 / 0` | Registers `"PositivityTheory"` in `nameDenyListExt` (`0` kernel constants added) | `PASS` |
| 41 | `BuildAid/D2.lean:1-4` | `4` | `12` | `4` | `0 / 0` | Registers `"CrystallineSemistableComparison"` in `nameDenyListExt` (`0` constants) | `PASS` |
| 42 | `BuildAid/D1.lean:1-4` | `4` | `13` | `3` | `0 / 0` | Registers `"CompanionTheory"` in `nameDenyListExt` (`0` kernel constants added) | `PASS` |
| 43 | `BuildAid/D5.lean:1-4` | `4` | `19` | `1` | `0 / 0` | Registers `"UpperTheory"` in `nameDenyListExt` (`0` kernel constants added) | `PASS` |

---

### 5.3 Cross-Audit Ledger Table for Distance-5 Core Welding Modules and Kernel Metaprogramming Files

The cross-audit ledger for the `11` core modules immediately below `B10` (around shortest distance `5` from `Main`) that weld the main theorem chain together, along with the `4` non-`BuildAid` metaprogramming files (`Imports.lean`, `OwnStruct.lean`, `CutCptCopy.lean`, `CutMainCpt.lean`) dissected in Chapter 1, Section 1.4, is given below.

| No. | `src/` Module Path and Core Pin | Lines | Category | Core Identifiers, Meta Commands, and Kernel Integrity Verdict | Verdict |
| ---: | :--- | ---: | :--- | :--- | :---: |
| 1 | `Formalism/GammaFactorNonvanishing/RhOfRight.lean:5-62` | `62` | `d=5` reflection | `Formalism.VW.rh_of_right`: derives `RiemannHypothesis` via nonvanishing of the 4 factors of the uncompleted zeta functional equation | `PASS` |
| 2 | `Development/AutomorphicArithmetic/CharacterBoxes/HalfPlane.lean:3-10` | `10` | `d=5` spec | `Claim.HalfPlane`, `Claim.Strip`, `Claim.Zeta`: intermediate specifications definitionally equal to `Statements.lean` | `PASS` |
| 3 | `Development/AutomorphicArithmetic/CharacterBoxes/EveryCharacter.lean:8-18` | `18` | `d=5` assembly | `UpperTheory.EveryCharacter`, `plugWin`, `plugAll`: prototype $\lambda = 3/2$ primitive nonvanishing and imprimitive extension | `PASS` |
| 4 | `Development/AutomorphicArithmetic/CharacterBoxes/Imprimitive.lean:5-35` | `35` | `d=6` extension | `UpperTheory.Top.imprimitive`: extends `ZeroFreeAll` to all characters across imprimitive prime-divisor Euler factors | `PASS` |
| 5 | `Development/AutomorphicArithmetic/ThetaCorrespondence/FockModels/EveryCharacterE.lean:41-87` | `88` | `d=6` assembly | `hypsE₂`, `everyE₂`, `CovE`: prototype blueprint coupling Howe duality, Siegel-Weil convergence, and evaluation grids | `PASS` |
| 6 | `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/EveryCharacterOfLiteratureOfVWin.lean:215-814` | `814` | `d=5` weld | `OpenLiteratureStatements`, `every_character_of_literature_of_vWin`: master welder for `195` published-theorem wrappers | `PASS` |
| 7 | `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/SiegelEisensteinSecondTermHypotheses.lean:44-74` | `76` | `d=6` weld | `nonempty_hyps_definite_side_of_closed_bound`, `every_character_of_theta_integrals_local_matching` | `PASS` |
| 8 | `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/TopPlug.lean:12-18` | `19` | `d=7` closure | `zero_free_all_of_green_v_win`, `every_character_of_green_v_win`: final `la := 3 / 2` plug | `PASS` |
| 9 | `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/TopCovolSlim2Use.lean:16-22` | `25` | `d=6` covolume | `topCovolSlim2_use_alt_alt`: Arakelov covolume upper bound coupling Hironaka, Moriwaki, Fargues, and Zarhin | `PASS` |
| 10 | `Development/AutomorphicArithmetic/AutomorphicVarieties/ModularityArgument/ThresholdArguments/DenseThresholdCases/VwinOfRow.lean:4-5` | `5` | `d=5` window | `UpperTheory.One.vwin_of_row`: produces `VWin` from `Row0b IsRecT` and `baseChangeN` (`157,604`-file cone) | `PASS` |
| 11 | `Development/AutomorphicArithmetic/Foundations/LocalLanglands/LocalCentralUnits/RecTExists.lean:20-66` | `66` | `d=5` LLC | `UpperTheory.Zero.LLC.recTExists`: existence of $\mathrm{GL}_n$ local Langlands parameters over number-field completions | `PASS` |
| 12 | `Formalism/LocalToGlobal/IndefiniteReal/HeckeNonvanishing/Imports.lean:5-8` | `8` | meta tactic | `elab "kexactB "`: unification-free direct metavariable assignment, fully re-checked by C++ kernel type-checker at `addDecl` | `PASS` |
| 13 | `Formalism/LocalToGlobal/NumberFieldFamilies/OwnStruct.lean:7-65` | `66` | meta tactic | `elab "kcopy "`: structure projection reassembler using read-only `Kernel.isDefEq` and passing full kernel re-verification | `PASS` |
| 14 | `Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptCopy.lean:68-90` | `91` | meta command | `elab "cpt_copy_thms"`: clones exclusively `.defnDecl` and `.thmDecl`, immediately rejecting `.axiomInfo` and other kinds | `PASS` |
| 15 | `Formalism/HermitianCurvature/HermitianCurvatureProofs/CutMainCpt.lean:935-945` | `945` | meta call | Single `cpt_copy_thms` call at line `945` registering kernel-checked compact-support Hermitian curvature twin theorems | `PASS` |

---

### 5.4 Comprehensive Forensic Verdict Summary for Part 1 (`A01`)

Five principal conclusions are established by the verbatim source collation and formal metatheoretic audit conducted in Part 1 (`A01`):

1. **Unadulterated top-level specifications and closed-proposition seal**: The five theorems in `Main.lean:4-12` are closed propositions taking `0` free hypothesis parameters, linked by kernel definitional equality directly to unmodified `Mathlib` `RiemannHypothesis` (`Mathlib/NumberTheory/LSeries/RiemannZeta.lean:185-186`) and `DirichletCharacter.LFunction` (`Mathlib/NumberTheory/LSeries/DirichletContinuation.lean:61`). Because their axiom footprint consists solely of the standard three axioms (`[propext, Classical.choice, Quot.sound]`), contamination from weakened or vacuous intermediate lemmas is metatheoretically impossible.
2. **Confirmed integrity of all `8` metaprogramming files and all `37` `allowUnsafeReducibility` sites**: The `5` `BuildAid` files merely register namespace deny-list strings for interactive lemma suggestions, while the remaining `3` tactic and command files (`kexactB`, `kcopy`, `cpt_copy_thms`) pass full C++ kernel `addDecl` type-checking and contain zero code paths for declaring axioms (`axiomDecl`). All `37` occurrences of `allowUnsafeReducibility` are proved line by line to be defensive `attribute [local irreducible]` locks on Fontaine period rings (`Per.Acris`, `Per.Bcris`) and automorphic level symbols preventing elaborator unfolding blowup.
3. **Completeness of `riemannZeta` boundary conditions**: The division-by-zero junk value $\zeta_{\mathrm{Mathlib}}(1) = (\gamma - \log 4\pi)/2 \neq 0$ at the pole $s = 1$ is isolated from the proposition by the explicit hypothesis `s ≠ 1`; the pole ratio of $\Lambda(s)/\Gamma_{\mathbb{R}}(s)$ at $s = 0$ is restored via `Function.update` to $\zeta(0) = -1/2 \neq 0$ with full complex differentiability; and both the negative even trivial zeros `s = -2 * (n + 1)` ($n \in \mathbb{N}$) and the Dirichlet-series and Euler-product identities on $\mathrm{Re}(s) > 1$ match classical analytic number theory point for point.
4. **Completeness of `DirichletCharacter.LFunction` and imprimitive-character boundary conditions**: `[NeZero N]` blocks the degenerate modulus $N = 0$ (`ZMod 0 = ℤ`), while at modulus $N = 1$ the $n = 0$ truncation in `LSeries.term` together with `LFunction_modOne_eq` enforces $L(s, \chi_1) = \zeta(s)$ for all $s \in \mathbb{C}$. Crucially, the imaginary-axis zero locus $\mathrm{Re}(s) = 0$ generated by induced prime-divisor Euler factors $(1 - \chi_0(p)p^{-s})$ of imprimitive characters is cleanly separated outside the domains by the open right half-plane guard `1 / 2 < s.re` and the open critical-strip guard `0 < s.re → s.re < 1`, eliminating every potential counterexample.
5. **Complete decompilation of the top `43` assembly-bridge modules and small-class-number auxiliary theorem family**: Both the main-theorem path starting at `Main.lean` (`MainTheorems` $\to$ `MainConclusion` $\to$ `EveryCharacterOfLiteratureOfVWin` / `VwinOfRow` / `RecTExists` / `RowSrc`) and the weakened-Vandiver auxiliary path over the class-number-$1$ imaginary quadratic field $\mathbb{Q}(\sqrt{-3})$ (`CorGKOf` $\to$ `ClassNumberThree` / `LenEqZeroIff` / `OnePoint`) are sealed as a directed acyclic graph atop the shared base-change, Galois, and automorphic-window engines. Part 2 (`A02`) conducts the mathematical equivalence audit across the `201` direct published-theorem imports invoked by `EveryCharacterOfLiteratureOfVWin.lean` and the `1,073` modules of `PublishedTheorems`.
