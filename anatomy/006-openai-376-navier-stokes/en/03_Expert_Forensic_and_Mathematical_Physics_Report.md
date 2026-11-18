# 03. Expert Forensic & Mathematical Physics Referee Report

## Executive Referee Verdict

OpenAI Math #376 (Universal computation in forced Navier–Stokes flows; `openai/math` commit `4eaee87`; companion manuscript bibliography PR: `mathcommunity/oai-math-revised` `PR #76`) is a large-scale formalization corpus comprising 1,010 Lean 4 files (142,131 lines) and 75 LaTeX preprint files (23,477 lines) that embeds finite register and 3-stack machines into 3D forced viscous incompressible flows.
Our comprehensive audit (verified across **45 standalone Lean 4 theorems, 0 sorry, 184/184 hypothesis mutations caught**) confirms that while the 3 internal auxiliary mechanisms (curl-potential affine box routing, $12C$ Serrin-Grönwall $L^2$ uniqueness, and $2+1\text{D}$ Gaussian heat-kernel positivity) are mathematically sound (0 sorry),
the top-level challenge specifications operate within a co-generated zero-pressure inverse-forcing (`p = 0`, `f := res_U`) and unidirectional shear-sheet (`advection = 0`) modeling scope that matches `analysis.tex` and `docs/376.md` (`Class A` disclosed scope, not `Gate 1` or paper–code divergence) yet eliminates pressure projection and nonlinear advection from 3D incompressible fluid dynamics (**`Gate 5: FAIL`**).
At the repository packaging layer (`Class B`), 650 out of 1,004 OAI/ modules (64.7%, 73,367 lines) are unimported by any of the 6 comparator challenges, Challenge #6 shares 38 definitions (37 `def` + 1 `inductive`) among 51 declarations (50 helper declarations and main theorem identical, 7 wrapper/docstring lines differ) with Challenge #5, `VelocityDetection/MainResult.lean:51` leaves `_hcomputable` unused, NavierStokesVelocity.lean:454 retains `(by sorry)` inside helper `def half` across 48 inlined namespaces (distinct from target placeholder `main_result` at `L1232`/`L1270`, while `TapeCodes.lean:32-33` and `MainResult.lean:11-55` are `0 sorry`, preserving `isDefEq` via Lean 4 `Prop` proof irrelevance and exposing a comparator `sorry`-scanner blind spot on helper `def` declarations under `Gate 2 / CP-10`), and 11 / 15 manuscript sections (79.7%) contain zero citations to classical human literature.

### 3-Tier Traffic-Light Scope Summary

| Tier | Audit Category | Verified Mathematical & Forensic Scope in OpenAI #376 | Primary Evidence & Theorems |
| :--- | :--- | :--- | :--- |
| Tier 1 (Green) | Re-Verified (0 sorry) | Curl-potential box routing (Flow.lean#L1-L260), $12C$ Serrin-Grönwall uniqueness (Comparison.lean#L1-L160), $2+1\to 3$-stack encoding & mild scalar contraction (T05–T31) | [BalancedThreeStack.lean](../proofs/oai_ref/lean/ComparatorChallenges/BalancedThreeStack.lean#L1-L220) |
| Tier 2 (Yellow) | Co-Generated Scope (`Gate 5 FAIL` · `Class A` Matched) | ForcedNavierStokes: disclosed residual $f := \partial_t u + (u\cdot\nabla)u + \nabla p - \nu\Delta u$ with $p = 0$ (`docs/376.md:26`, `analysis.tex:36-41`, BoxCoding.lean#L53-L66, Comparison.lean#L1-L137); SolenoidalSheetPrograms: shear advection = 0 (`docs/376.md:12,14`, T01–T04, T33–T34) eliminating 3D nonlinear PDE constraints | [BoxCoding.lean](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/BalancedTransport/BoxCoding.lean#L53-L66), [Comparison.lean](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/BalancedTransport/Comparison.lean#L1-L137) |
| Tier 3 (Red) | Orphans & Spec Defects | 650 / 1,004 (64.7%) unimported OAI/ modules; unused `_hcomputable : ComputableReal ν`; NavierStokesVelocity.lean#L453-L454 challenge namespace-inlining & helper-`def` `sorry`-scanner blind spot (`TapeCodes.lean:32-33` 0 sorry, `isDefEq` preserved, distinct from `main_result` `L1232`/`L1270`); 9 / 22 (40.9%) uncited .bib (T14–T18, T35–T37) | [MainResult.lean](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/VelocityDetection/MainResult.lean#L14-L51) |

### Repository Import Stratigraphy Diagram

```mermaid
flowchart TD
    subgraph Challenges["6 ComparatorChallenges Entrypoints (6 files, 2,284 lines)"]
        C1["#1 SolenoidalSheetPrograms (197L)<br/>Unidirectional shear advection = 0"]
        C2["#2 NavierStokesAlternating (245L)<br/>Alternating shear sheets"]
        C3["#3 NavierStokesVelocity (1,275L)<br/>48 inlined namespaces + L454 stripped Prop proof"]
        C4["#4 BalancedBoxRouting (96L)<br/>Pure kinematic ODE"]
        C5["#5 BalancedThreeStack (239L)<br/>p=0 inverse forcing via abel"]
        C6["#6 ForcedNavierStokesComputation (232L)<br/>38 defs / 51 decls shared with #5 (7 wrapper lines differ)"]
    end

    subgraph Reachable["Tier 1 & 2: Reachable Active Modules (354 files, 66,480 lines, 35.3%)"]
        R1["SheetFlows (26) & AlternatingFlow (41)"]
        R2["VelocityDetection (152 files, 22,602L)<br/>MainResult.lean:51 unused _hcomputable"]
        R3["BoxTransport (7) & BalancedTransport (60)<br/>BoxCoding.lean (abel) + Comparison.lean (12C)"]
    end

    subgraph Orphaned["Tier 3: Unreachable Module Strata (650 files, 73,367 lines, 64.7% Unimported)"]
        O1["ForcedComputation/ (576 files, 60,321L)<br/>Detector(144) + Flow(98) + Programs(173) + Scalar(160)"]
        O2["ShearFlows/ (31 files, 5,815L) & Material/ (21 files, 3,420L)"]
        O3["PeriodicLattice/Solenoidal.lean et al. (22 files)<br/>Non-zero pressure p = -φ Leray projection unimported"]
    end

    C1 --> R1
    C2 --> R1
    C3 --> R2
    C4 --> R3
    C5 --> R3
    C6 -. "Duplicate target pointer" .-> R3
    C6 -.-x|"Disconnected (64.7% orphaned)"| O1
```

### Four-Layer Evaluation Summary
1. Layer 1A (Consistency with the Papers' Explicit Forced-Flow Model - PASS):
   - Building on hydrodynamic computation literature (Cardona–Miranda–Peralta-Salas–Presas 2021–2025; Tao 2016), the accompanying manuscripts (Incompressible-Box-Transport/introduction.tex:90-96, analysis.tex:36-41 Lemma 2.2, analysis.tex:263-267 distinguishing Euclidean $p=0$ from $\mathbb{T}_L^3$ projected pressure $-\phi$, Scalar-Potentials/main.tex:452-454) and [lean/docs/376.md:1,12,14,26](../proofs/oai_ref/lean/docs/376.md#L1-L37) explicitly formulate the construction around a prescribed divergence-free velocity field $U$ starting from rest ($u(0)=0$), defining the external body force via the differential residual $f := \partial_t U + (U\cdot\nabla)U - \nu\Delta U$ ($p=0$).
   - As formalized in [BalancedThreeStack.lean:214-231](../proofs/oai_ref/lean/ComparatorChallenges/BalancedThreeStack.lean#L214-L231), for $t \ge 1$ the velocity field $U(M,w,t,x) = \text{repeated}(M,t,x)$ and forcing $f = f_0 + \nu f_1$ are time-1 periodic (PeriodicAfterOne) and independent of the input word $w$ and step index $n$.
   - Thus, the external force does not pre-compute the halting trajectory; state transitions are carried by the Lagrangian ODE $\dot{X}(t) = U(t, X(t))$ across periodic cycles.
2. Layer 1B (Co-Generated Scope Reduction vs. Autonomous Hydrodynamic Nonlinearity - Gate 5 FAIL / Class A Matched):
   - From a PDE dynamics standpoint, the 5 box/sheet challenges do not synthesize logic gates from autonomous Eulerian nonlinearity $(u\cdot\nabla)u$.
   - Instead, they prescribe the kinematic flow $U$ first and either absorb the momentum residual into $f$ point-by-point ([BalancedTransport/BoxCoding.lean:53-66](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/BalancedTransport/BoxCoding.lean#L53-L66), discharged by abel) or restrict the flow to unidirectional shear sheets where $(u\cdot\nabla)u = 0$ identically
   ([SolenoidalSheetPrograms.lean:188](../proofs/oai_ref/lean/ComparatorChallenges/SolenoidalSheetPrograms.lean#L188)), locking $u = U$ via Serrin-Grönwall energy uniqueness ([BalancedTransport/Comparison.lean:85-132](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/BalancedTransport/Comparison.lean#L85-L132)). Because `analysis.tex:36-41` and [lean/docs/376.md:12,14,26](../proofs/oai_ref/lean/docs/376.md#L12-L26) agree with the challenges, this is a matched `Class A` scope (not paper–code divergence or `Gate 1` failure), yet co-generating both manuscript and challenges without pressure projection or nonlinear advection disqualifies **`Gate 5` (`FAIL`)**.
   - As noted in [lean/docs/376.md](../proofs/oai_ref/lean/docs/376.md#L12-L14), [SolenoidalSheetPrograms.lean](../proofs/oai_ref/lean/ComparatorChallenges/SolenoidalSheetPrograms.lean#L1-L197) formalizes only the finite positive diagonal maps on coding sheets; the paper's fixed-particle halting detector and reciprocal maps on solid boxes are outside the formalization's scope.
3. Layer 2 (Lean 4 Repository Architecture & Challenge Packaging Audit - Packaging & Hygiene Issues Identified):
   - Challenge Duplication: [ForcedNavierStokesComputation.lean](../proofs/oai_ref/lean/ComparatorChallenges/ForcedNavierStokesComputation.lean#L1-L232) (232 lines) shares the same 38 definitions (37 `def` + 1 `inductive`) among 51 declarations (50 helper declarations and main theorem `balanced_three_stack_realization` identical; 7 wrapper, docstring, and `Fintype Direction` lines differ) with [BalancedThreeStack.lean](../proofs/oai_ref/lean/ComparatorChallenges/BalancedThreeStack.lean#L1-L239) (239 lines),
   and both JSON files target OAI.MathematicalPhysics.NavierStokes.BalancedTransport.MainResult.
   - Unimported OAI/ Modules (650 / 1,004 Files): Out of 1,004 OAI/ modules (139,847 lines), 354 files (66,480 lines, 35.3%) are transitively imported by the 6 challenge entrypoints, whereas 650 files (73,367 lines, 64.7%) - including all 576 files (60,321 lines) under OAI/MathematicalPhysics/NavierStokes/ForcedComputation/ and non-zero pressure `PeriodicLattice/Solenoidal.lean` - are unimported by any comparator challenge.
   - Challenge Namespace-Inlining & Comparator Helper-`def` `sorry`-Scanner Blind Spot (NavierStokesVelocity.lean:454 vs. L1232/L1270): Distinct from the intentional target placeholder `main_result` (`L1232`/`L1270`), [ComparatorChallenges/NavierStokesVelocity.lean](../proofs/oai_ref/lean/ComparatorChallenges/NavierStokesVelocity.lean#L453-L454) (1,275 lines) inlines 48 internal namespaces and retains `w.liftOn word (by sorry)` in helper `def half` (`VelocityDetection.TapeCodes.half` at line 454),
   whereas the actual `OAI/` library ([VelocityDetection/TapeCodes.lean:32-33](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/VelocityDetection/TapeCodes.lean#L32-L33) and [VelocityDetection/MainResult.lean:11-55](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/VelocityDetection/MainResult.lean#L11-L55)) is `0 sorry`; under Lean 4 `Prop` proof irrelevance this preserves `isDefEq` with `OAI/` (never kernel-unsound), yet its survival inside an official comparator challenge exposes a comparator `sorry`-scanner blind spot on helper `def` declarations (`Gate 2 / CP-04, CP-10`).
   - Redundant Viscosity Oracle Premise (`_hcomputable`): In [VelocityDetection/MainResult.lean:14,51](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/VelocityDetection/MainResult.lean#L14-L51), the premise `(hν_comp : ComputableReal ν)` is renamed `_hcomputable` and left unused because RationalBox 5 (NavierStokesVelocity.lean:1203) already supplies $\nu = x(0)$ as the 0-th coordinate of the 5D rational box oracle.
4. Layer 3 & Layer 4 (Core Mathematical Mechanisms & Standalone 45-Theorem Verification - PASS):
   - All 3 mathematical mechanisms ($\nabla\times(\chi\Psi)$ affine box routing, $12C$ Serrin-Grönwall uniqueness, $2+1\text{D}$ Gaussian heat-kernel positivity) and 5 structural repairs are formalized and verified across 45 standalone Lean 4 theorems (0 sorry, 0 custom axioms, 184/184 hypothesis mutations killed) in [ns376_kinematic_routing_and_forensics.lean](../proofs/ns376_kinematic_routing_and_forensics.lean) and
   [ns376_gronwall_uniqueness_and_repairs.lean](../proofs/ns376_gronwall_uniqueness_and_repairs.lean), together with deterministic SymPy and PyTorch FP64 simulations.



## 1. Detailed Code & Mathematical Physics Audit Evidence

### 1.1 Inverse-Forcing Identity (BalancedTransport/Model.lean:139-146, BoxCoding.lean:53-66)
In [BalancedTransport/Model.lean:139-146](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/BalancedTransport/Model.lean#L139-L146) (and [BalancedThreeStack.lean:124-132](../proofs/oai_ref/lean/ComparatorChallenges/BalancedThreeStack.lean#L124-L132)), the force coefficients are defined as:

```lean
def affineForce (f₀ f₁ : Velocity) (ν : ℝ) : Velocity :=
  fun t x => f₀ t x + ν • f₁ t x

def inertialCoefficient (u : Velocity) : Velocity :=
  fun t x => timeD u t x + convection u t x

def viscousCoefficient (u : Velocity) : Velocity :=
  fun t x => -laplacian u t x
```

And in [BalancedTransport/BoxCoding.lean:53-66](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/BalancedTransport/BoxCoding.lean#L53-L66), residual_zero_pressure_solution is proved verbatim as follows:

```lean
theorem residual_zero_pressure_solution (ν : ℝ) (U : Velocity)
    (hU : Smooth U) (hzero : ∀ x, U 0 x = 0)
    (hdiv : ∀ t, 0 ≤ t → ∀ x, div U t x = 0) :
    ZeroDataSolution ν (affineForce (inertialCoefficient U) (viscousCoefficient U) ν)
      U (fun _ _ => 0) := by
  refine ⟨hU, contDiffOn_const, hzero, hdiv, ?_⟩
  intro t ht x
  have hp : gradient (fun _ _ => 0) t x = 0 := by
    ext i
    simp [gradient, spaceD]
  rw [hp]
  simp only [affineForce, inertialCoefficient, viscousCoefficient, smul_neg, neg_zero, zero_add]
  abel
```

- Mathematical Analysis: Substituting `p = fun _ _ => 0` and `f = affineForce (inertialCoefficient U) (viscousCoefficient U) ν` into ZeroDataSolution yields an algebraic ring identity (abel) for any smooth divergence-free field U ([Theorem 1](../proofs/ns376_kinematic_routing_and_forensics.lean#L18-L27), [Theorem 2](../proofs/ns376_kinematic_routing_and_forensics.lean#L34-L43)).
- Comparison Between the Sept 27 ($\mathbb{R}^3$, $p=0$) and Oct 6 ($\mathbb{T}_L^3$, Leray Projection) Formulations:
  - [BalancedThreeStack.lean:152-160](../proofs/oai_ref/lean/ComparatorChallenges/BalancedThreeStack.lean#L152-L160) works on $\mathbb{R}^3$ with $p = 0$ and CommonCompactSupport U f₀ f₁ inside Metric.closedBall 0 R.
  - Because $\nabla \cdot ((U\cdot\nabla)U) = \sum_{i,j} \partial_i U_j \partial_j U_i \ne 0$, the unprojected residual force $f = f_0 + \nu f_1$ is compactly supported in $B(0, R)$ but not divergence-free ($\nabla \cdot f \ne 0$).
  - If one applies the Helmholtz-Leray projection $f_{\text{sol}} = \mathbb{P}f = f - \nabla\phi$ (as in the October 6 manuscript revision on $\mathbb{T}_L^3$), solving $\Delta\phi = \nabla\cdot((U\cdot\nabla)U)$ introduces a non-local harmonic pressure gradient outside the ball.
  - Our PyTorch FP64 autograd and spectral test ([verify_symbolic_ns376.py](../proofs/verify_symbolic_ns376.py#L224-L310)) confirms that for a cutoff curl velocity supported in $R = 1.4$, $\|f_{\text{paper}}\|_{L^\infty(|x|\ge 1.5)} = 0.0$, whereas the Leray-projected solenoidal force has exterior norm $\|f_{\text{sol}}\|_{L^\infty(|x|\ge 1.5)} = 4.510381$ (81.87% of the interior RMS 5.508929).

### 1.2 Advection Annihilation on Unidirectional Shear Sheets (SolenoidalSheetPrograms.lean:188)
In [ComparatorChallenges/SolenoidalSheetPrograms.lean](../proofs/oai_ref/lean/ComparatorChallenges/SolenoidalSheetPrograms.lean#L188) and [SheetFlows/Differential.lean](../proofs/oai_ref/lean/OAI/MathematicalPhysics/SheetFlows/Differential.lean#L269), the velocity field on each time sub-interval is a unidirectional shear sheet satisfying:

```lean
(∀ t x, advection u t x = 0)
```

which eliminates the nonlinear Eulerian convection term $(u \cdot \nabla) u$ identically ([Theorem 3](../proofs/ns376_kinematic_routing_and_forensics.lean#L50-L60)).

### 1.3 Specification Duplication Between Challenge #5 and Challenge #6
A line-by-line diff of [BalancedThreeStack.lean](../proofs/oai_ref/lean/ComparatorChallenges/BalancedThreeStack.lean#L1-L239) (239 lines) and [ForcedNavierStokesComputation.lean](../proofs/oai_ref/lean/ComparatorChallenges/ForcedNavierStokesComputation.lean#L1-L232) (232 lines) shows that both files share the same 38 definitions (37 `def` + 1 `inductive`) among 51 declarations (50 helper declarations and the main theorem `balanced_three_stack_realization` are verbatim identical, differing by 7 wrapper, docstring, and 2-line `Fintype Direction` instance lines), and both JSON files point to OAI.MathematicalPhysics.NavierStokes.BalancedTransport.MainResult ([Theorem 16](../proofs/ns376_kinematic_routing_and_forensics.lean#L295-L311)).

### 1.4 Import-Graph Stratigraphy Across the 1,004 OAI/ Modules (354 Reachable vs. 650 Unimported)
Breadth-first traversal of the import DAG from all 6 challenge entrypoints (SheetProgram, AlternatingFlow.Development, VelocityDetection.Main, BoxTransport.Routing, BalancedTransport.MainResult) establishes ([Theorem 14](../proofs/ns376_kinematic_routing_and_forensics.lean#L251-L263), [Theorem 15](../proofs/ns376_kinematic_routing_and_forensics.lean#L270-L285)):
- Reachable OAI/ modules: 354 files (66,480 lines, 35.3% of files, 0 sorry).
- Unimported OAI/ modules: 650 files (73,367 lines, 64.7% of files, 52.5% of lines, 0 sorry).
- Inside OAI/MathematicalPhysics/NavierStokes/ (843 files, 103,906 lines):
  - Reachable (212 files, 33,711 lines): BalancedTransport (60 files, 11,109 lines) + VelocityDetection (152 files, 22,602 lines).
  - Unimported (631 files, 70,195 lines): ForcedComputation/ (576 files, 60,321 lines = Detector 144 + Flow 98 + Programs 173 + Scalar 160 + [ForcedComputation/Main.lean](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/ForcedComputation/Main.lean#L1-L33) 1), ShearFlows/ (31 files, 5,815 lines), Material/ (21 files, 3,420 lines),
   and 3 root files (FiniteRankGap.lean, HomogeneousDatum.lean, StationaryContraction.lean, 639 lines).

### 1.5 Inlined Namespaces & Line 454 Proof Stripping vs. Target Placeholder in ComparatorChallenges/NavierStokesVelocity.lean
[ComparatorChallenges/NavierStokesVelocity.lean](../proofs/oai_ref/lean/ComparatorChallenges/NavierStokesVelocity.lean#L1-L1275) (1,275 lines) inlines 48 internal namespaces (VelocityDetection.TapeCodes, residualCode [L1085](../proofs/oai_ref/lean/ComparatorChallenges/NavierStokesVelocity.lean#L1085), compile [L1176](../proofs/oai_ref/lean/ComparatorChallenges/NavierStokesVelocity.lean#L1176)). Distinct from the intentional challenge target placeholder `main_result` ([L1232](../proofs/oai_ref/lean/ComparatorChallenges/NavierStokesVelocity.lean#L1232)–[L1270](../proofs/oai_ref/lean/ComparatorChallenges/NavierStokesVelocity.lean#L1270)), it contains a stripped `Prop` quotient-well-definedness proof `w.liftOn word (by sorry)` in VelocityDetection.TapeCodes.half at [line 454](../proofs/oai_ref/lean/ComparatorChallenges/NavierStokesVelocity.lean#L453-L454), whereas the actual `OAI/` solution modules ([VelocityDetection/TapeCodes.lean:32-33](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/VelocityDetection/TapeCodes.lean#L32-L33) and [VelocityDetection/MainResult.lean:11-55](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/VelocityDetection/MainResult.lean#L11-L55)) prove both obligations at `0 sorry` (`fun _ _ ⟨n, hn⟩ => by rw [hn, word_extend]`). Because Lean 4 `Prop` proof irrelevance preserves `isDefEq` across the quotient proof obligation, `L454` is a challenge namespace-inlining & proof-stripping hygiene artifact rather than a kernel soundness bug in `OAI/`.

### 1.6 5D Rational-Box Oracle and the Unused `_hcomputable` Premise (VelocityDetection/MainResult.lean:14,51)
In [VelocityDetection/MainResult.lean](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/VelocityDetection/MainResult.lean#L11-L55), the main theorem VelocityDetection.main_result takes a computability premise `(hν_comp : ComputableReal ν)` for the viscosity $\nu$,
but binds it as `_hcomputable` at line 51 (`intro ν hν _hcomputable b N _ _ M w`) and never uses it ([Theorem 18](../proofs/ns376_kinematic_routing_and_forensics.lean#L338-L348), [Theorem 32](../proofs/ns376_gronwall_uniqueness_and_repairs.lean#L225-L235)).
This occurs because Program.Represents ([NavierStokesVelocity.lean:1201-1211](../proofs/oai_ref/lean/ComparatorChallenges/NavierStokesVelocity.lean#L1201-L1211)) supplies a 5D rational box RationalBox 5 $(x_0, x_1, x_2, x_3, x_4) = (\nu, t, X_0, X_1, X_2)$ whose 0-th coordinate x(0) already provides rational approximations of $\nu$.

### 1.7 Classical Human Literature Attribution & Uncited Bibliography Audit
An audit of the main manuscript (preprints/Incompressible-Box-Transport-and-Finite-Computation-October-6-2026/build/, 16 .tex files: `main.tex` 56 lines + 15 `\input` section files 5,808 lines = 5,864 lines, and `references.bib` of 206 lines) reveals two citation gaps that obscure the boundary between classical human theorems and the paper's inverse-forcing construction:

1. 9 / 22 (40.9%) Uncited BibTeX Entries Dropped from the Compiled PDF:
   Of the 22 entries in build/references.bib, 13 are cited in the .tex source (9 human papers and 4 OpenAI companion self-citations), while 9 human entries (40.9%) are never cited via `\cite{...}` in any .tex file and are therefore omitted by BibTeX from the compiled PDF bibliography:

| # | Uncited Key (references.bib Lines) | Full Bibliographic Reference & Verified Link | Corresponding Uncited Passage in `build/*.tex` |
| :---: | :--- | :--- | :--- |
| 1 | Moser1965 (L80-86) | J. Moser, Trans. Amer. Math. Soc. 120 (1965), 286-294. [DOI:10.1090/S0002-9947-1965-0182927-5](https://doi.org/10.1090/S0002-9947-1965-0182927-5) | build/introduction.tex:72-73 explicitly writes "Moser's area correction" without `\cite{Moser1965}`. |
| 2 | Nash1958 (L72-78) | J. Nash, Amer. J. Math. 80(4) (1958), 931-954. [DOI:10.2307/2372841](https://doi.org/10.2307/2372841) | build/initialization.tex:561-574 (Remark 8.9) discusses parabolic advection-diffusion tail estimates without citing Nash1958. |
| 3 | Aronson1968 (L48-54) | D. G. Aronson, Ann. Scuola Norm. Sup. Pisa (3) 22(4) (1968), 607-694. [NUMDAM](https://www.numdam.org/item/ASNSP_1968_3_22_4_607_0/) | build/initialization.tex:565-571 invokes Gaussian diffusion-tail bounds ([HeatKernels.lean](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/VelocityDetection/HeatKernels.lean#L1-L97)) without citing Aronson1968. |
| 4 | EtnyreGhrist2000 (L96-107) | J. Etnyre & R. Ghrist, Nonlinearity 13(2) (2000), 441-458. [DOI:10.1088/0951-7715/13/2/306](https://doi.org/10.1088/0951-7715/13/2/306) | build/introduction.tex:79-88 reviews Beltrami and contact hydrodynamic universality without citing EtnyreGhrist2000. |
| 5 | Tao2016 (L64-70) | T. Tao, J. Amer. Math. Soc. 29(3) (2016), 601-674. [DOI:10.1090/jams/838](https://doi.org/10.1090/jams/838) | build/introduction.tex:79-96 discusses fluid circuit synthesis and Navier-Stokes regularity without citing Tao2016. |
| 6 | CardonaMirandaPeraltaSalas2022 (L56-62) | R. Cardona, E. Miranda & D. Peralta-Salas, IMRN 2022(22), 18092-18109. [DOI:10.1093/imrn/rnab233](https://doi.org/10.1093/imrn/rnab233) | build/introduction.tex:65-80 discusses Moore's conjecture and Euler universality without citing CardonaMirandaPeraltaSalas2022. |
| 7 | CardonaMirandaPeraltaSalasPresas2023 (L122-132) | R. Cardona et al., Adv. Math. 428 (2023), 109142. [DOI:10.1016/j.aim.2023.109142](https://doi.org/10.1016/j.aim.2023.109142) | build/introduction.tex:79-85 reviews Euler flow universality without citing CardonaMirandaPeraltaSalasPresas2023. |
| 8 | Cardona2025Advice (L88-94) | R. Cardona, Rev. Mat. Iberoam. 41(1) (2025), 313-338. [DOI:10.4171/RMI/1506](https://doi.org/10.4171/RMI/1506) | build/introduction.tex:65-89 discusses symbolic-to-hydrodynamic encodings without citing Cardona2025Advice. |
| 9 | CardonaMirandaPeraltaSalas2025FluidComputer (L161-173) | R. Cardona et al., Found. Comput. Math. 25 (2025), 1921-1937. [DOI:10.1007/s10208-025-09699-6](https://doi.org/10.1007/s10208-025-09699-6) | build/introduction.tex:79-89 reviews fluid computer architectures without citing CardonaMirandaPeraltaSalas2025FluidComputer. |

2. 11 / 15 Section Files (4,630 / 5,808 Lines = 79.7%) With Zero Human Citations & Missing Classical Original Works:
   Across the 15 `\input` section files (5,808 lines), 11 section files (geometry.tex, balanced.tex, compilers.tex, routing-conventions.tex, initialization.tex, compact-processors.tex, guarded-history.tex, observer-routing.tex, solid-routing.tex, torus-routing.tex, clocks.tex, totaling 4,630 lines or 79.7%) contain zero human literature citations.
   The following foundational human theorems are proved or used from scratch without attribution:

| Pillar | Manuscript & Lean Location | Theorem / Technique Used Without Attribution | Confirmed Original Human References & Links |
| :---: | :--- | :--- | :--- |
| I. Solenoidal-Gradient Orthogonal Decomposition | build/analysis.tex:16-34, 164-262; [Solenoidal.lean](../proofs/oai_ref/lean/OAI/Analysis/PeriodicLattice/Solenoidal.lean#L1-L421) | Distributional $L^2(\mathbb{R}^3)$ orthogonality $\langle w, \nabla p\rangle = 0$ and $\mathbb{T}_L^3$ projection $Pg = g - \nabla\Delta^{-1}\operatorname{div} g$. | Helmholtz (1858) ([DOI:10.1515/crll.1858.55.25](https://doi.org/10.1515/crll.1858.55.25)); Weyl (1940) ([DOI:10.1215/S0012-7094-40-00725-6](https://doi.org/10.1215/S0012-7094-40-00725-6)); Constantin & Foias (1988); Galdi (2011). |
| II. Whole-Space Energy Uniqueness & Integrating Factor | build/analysis.tex:36-133; [Comparison.lean:20-132](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/BalancedTransport/Comparison.lean#L20-L132) | Radial spatial cutoff $\chi_R$ boundary elimination and integrating-factor uniqueness from $\frac{1}{2}\frac{d}{dt}\|w\|_2^2 + \nu\|\nabla w\|_2^2 \le \|\nabla U\|_\infty \|w\|_2^2$. | Grönwall (1919) ([DOI:10.2307/1967124](https://doi.org/10.2307/1967124)); Prodi (1959) ([DOI:10.1007/BF02410664](https://doi.org/10.1007/BF02410664)); Serrin (1962) ([DOI:10.1007/BF00253344](https://doi.org/10.1007/BF00253344)). |
| III. Volume-Preserving Isotopy via Cut-Off Potentials | build/geometry.tex:26-68; [BoxTransport/Flow.lean:114-225](../proofs/oai_ref/lean/OAI/Analysis/BoxTransport/Flow.lean#L114-L225) | Extending local trace-free affine motions $\dot{c}_i + L_i y$ on disjoint boxes to global divergence-free velocity via $\nabla\times(\chi_i A_i)$. | Krygin (1971) ([DOI:10.1007/BF01076419](https://doi.org/10.1007/BF01076419)); Banyaga (1978) ([DOI:10.1007/BF02566074](https://doi.org/10.1007/BF02566074)). |
| IV. Multi-Stack Decomposition & Odd-Digit Cantor Coding | build/balanced.tex:28-133; [BalancedTransport/Model.lean](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/BalancedTransport/Model.lean#L1-L224) | Splitting a Turing tape into stacks $(L,R,J)$, local inverse determinism, and odd-digit Cantor encoding $\sum d_j B^{-j}$. | Minsky (1961) ([DOI:10.2307/1970290](https://doi.org/10.2307/1970290)); Axelsen & Glück (2011) ([DOI:10.1007/978-3-642-19805-2_4](https://doi.org/10.1007/978-3-642-19805-2_4)); Koiran et al. (1994); Siegelmann & Sontag (1995). |
| V. Effective Smooth Fields & Computable Real Viscosity | build/introduction.tex:126-135; [BalancedThreeStack.lean:175-204](../proofs/oai_ref/lean/ComparatorChallenges/BalancedThreeStack.lean#L175-L204) | Rational-error evaluation of mixed derivatives $\partial_t^h\partial_x^\beta u$ with computable derivative bounds and ComputableReal ν. | Pour-El & Richards (1989) ([DOI:10.1007/978-3-662-21717-7](https://doi.org/10.1007/978-3-662-21717-7)); Weihrauch (2000) ([DOI:10.1007/978-3-642-56999-9](https://doi.org/10.1007/978-3-642-56999-9)). |

3. Why the Citation Audit (9/22 Uncited .bib + 11/15 Unattributed Sections) and the 5 Core Causal Questions Are Essential:
   - Q1: Separating 79.7% Unattributed Classical Reinvention from Top-Level Specification Gaps:
     Large AI-generated mathematical manuscripts frequently reprove classical human theorems (Helmholtz-Weyl decomposition, Grönwall-Prodi-Serrin energy uniqueness, Krygin-Banyaga cutoff potential extension, Minsky multi-stack simulation, Koiran-Siegelmann odd-digit Cantor encoding) from scratch without attribution (4,630 / 5,808 lines = 79.7%).
     Only by isolating these known classical building blocks with their original DOIs first can a referee avoid being distracted by routine (0 sorry) auxiliary lemmas and pinpoint the genuine specification gaps at the top-level ComparatorChallenges boundary
(zero-pressure residual forcing $p \equiv 0$, initial-interval truncation PeriodicAfterOne on $[0,1)$, unidirectional shear advection cancellation $(u\cdot\nabla)u = 0$, and the unused premise `_hcomputable`).
   - Q2: The 5 Core Causal Mechanisms of the #376 Architecture:
     1. Step 1 (The Forward-PDE Barrier): In an unforced viscous fluid ($\nu > 0$, $f \equiv 0$) or under a fixed finite-mode forcing subspace, viscous diffusion ($\nu\Delta u$) and nonlinear vortex stretching ($(u\cdot\nabla)u$) destroy sharp box boundaries over unboundedly many computation steps,
   creating a fundamental barrier against autonomous viscous box transport ([Theorem 33](../proofs/ns376_gronwall_uniqueness_and_repairs.lean#L244-L249)–[Theorem 34](../proofs/ns376_gronwall_uniqueness_and_repairs.lean#L258-L264)).
     2. Step 2 (Necessity of the Curl-Potential & Inverse-Residual Pivot): Multiplying an interior affine velocity $U_{\text{target}} = \dot{c}_i + L_i y$ directly by a cutoff $\chi_i$ fails incompressibility on the transition shell ($\nabla\cdot(\chi_i U_{\text{target}}) = \nabla\chi_i \cdot U_{\text{target}} \ne 0$).
        Taking the curl of a skew-symmetric potential $U = \nabla\times(\chi_i A_i)$ is a mathematical necessity to guarantee $\nabla\cdot U \equiv 0$ globally before defining $f := \partial_t U + (U\cdot\nabla)U - \nu\Delta U$ ([Theorem 5](../proofs/ns376_kinematic_routing_and_forensics.lean#L81-L91)–[Theorem 7](../proofs/ns376_kinematic_routing_and_forensics.lean#L114-L125)):
        $$U_0(t, x) = \partial_1(\chi\Psi_{0,1}) - \partial_2(\chi\Psi_{2,0}) = v_0 + \frac{1}{3}(2\ell_0 - \ell_1 - \ell_2)y_0 = v_0 + \ell_0 y_0.$$
     3. Step 3 (Origin of the Odd-Digit Base $B = 2m+1$ & $12C$ Energy Constant): Restricting digits to odd integers $\{1, 3, \dots, 2m-1\}$ in base $B \ge 2m+1$ is the reason closed symbolic cylinder boxes remain separated by a positive collar margin $\ge B^{-|v|}$ so cutoff supports stay disjoint ([Theorem 9](../proofs/ns376_kinematic_routing_and_forensics.lean#L148-L164)),
   while bounding the 9 entries of $\nabla U$ by $C$ in 3D yields the $2 \times 3 \times 2C = 12C$ Grönwall growth rate ([Theorem 23](../proofs/ns376_gronwall_uniqueness_and_repairs.lean#L64-L97)).
     4. Step 4 (Collision Contradiction & Cause of the 650 Unimported Fossils): Because source and target box families overlap in space, lexicographic parking (centerKey) and third-coordinate altitude separation are required to prevent trajectory collisions ([Theorem 8](../proofs/ns376_kinematic_routing_and_forensics.lean#L132-L142), [Theorem 42](../proofs/ns376_gronwall_uniqueness_and_repairs.lean#L376-L394)).
        Meanwhile, the reason 650 / 1,004 OAI/ modules (64.7%, including the 576-file ForcedComputation/ hub and the non-zero pressure Leray projection in PeriodicLattice/Solenoidal.lean) are orphaned from the 6 challenge entrypoints is that BalancedThreeStack.json and ForcedNavierStokesComputation.json point to the exact same target module BalancedTransport.MainResult
([Theorem 14](../proofs/ns376_kinematic_routing_and_forensics.lean#L251-L263)–[Theorem 16](../proofs/ns376_kinematic_routing_and_forensics.lean#L295-L311)).
     5. Step 5 (Formalization & Abstraction Boundary): Rather than formalizing forward Navier-Stokes PDE existence on $\mathbb{R}^3$, the Lean development fixes the smooth carrier $U$ first and reduces the PDE to an algebraic ring identity (abel on $f = \text{residual}(\nu, U)$) plus a differential energy inequality (Comparison.lean), which defines the exact boundary between the formal proof and classical PDE analysis.



## 2. Five Structural Repairs (Theorems 33–37)

[ns376_gronwall_uniqueness_and_repairs.lean](../proofs/ns376_gronwall_uniqueness_and_repairs.lean) (Theorems 33–37) formalizes 5 structural repairs:
1. Repair 1 ([Theorem 33](../proofs/ns376_gronwall_uniqueness_and_repairs.lean#L244-L249) - Fixed Finite-Dimensional Forcing Subspace): Restricting $f$ to a fixed $K$-mode subspace ($K=16$) separates low-mode forcing from high-frequency step-dependent residuals ($M_n \ge 17$).
2. Repair 2 ([Theorem 34](../proofs/ns376_gronwall_uniqueness_and_repairs.lean#L258-L264) - Autonomous Initial-Value Gate $f \equiv 0$): Verifies that the unforced Navier-Stokes residual of the box-routing carrier is non-zero ($\|\text{LHS}\|_{L^2} = 2.877521 > 0$).
3. Repair 3 ([Theorem 35](../proofs/ns376_gronwall_uniqueness_and_repairs.lean#L271-L276) - Deduplicating Challenge #5 and Challenge #6): Binds ForcedNavierStokesComputation to a distinct theorem specification in ForcedComputation/ (distinct_spec_hash = 52 != 38).
4. Repair 4 ([Theorem 36](../proofs/ns376_gronwall_uniqueness_and_repairs.lean#L284-L290) - 4D Spacetime Oracle Separation): Restricts the field oracle to RationalBox 4 $(t, x, y, z)$ so that ComputableReal ν is actively consumed (unused_hyps = 0).
5. Repair 5 ([Theorem 37](../proofs/ns376_gronwall_uniqueness_and_repairs.lean#L299-L306) - Repository Reachability & Challenge Normalization): Reconciles the 650 unimported OAI/ files (1004 - 650 = 354 reachable) and moves the 1,095 lines of internal implementation namespaces out of ComparatorChallenges/NavierStokesVelocity.lean.



## 3. Module-Family Summary of All 42 Reference Files (894 / 894 Declarations = 100.0%)

To preserve narrative readability, the exhaustive 894-row declaration-by-declaration audit table has been isolated into the machine specification appendix [04_Automated_Verification_and_Parser_Spec.md](04_Automated_Verification_and_Parser_Spec.md) (§4). Below is the 12-family summary across all 42 files (894 items = 100.0%) in proofs/oai_ref/:

| Module Family | Representative Files (proofs/oai_ref/) | Files | Declarations / Items | Mapped Theorems (T01–T45) | Core Mathematical & Forensic Role |
| :--- | :--- | :---: | :---: | :--- | :--- |
| 1. Challenge JSON Specs | [BalancedThreeStack.json](../proofs/oai_ref/lean/ComparatorChallenges/BalancedThreeStack.json#L1-L14), [ForcedNavierStokesComputation.json](../proofs/oai_ref/lean/ComparatorChallenges/ForcedNavierStokesComputation.json#L1-L14) | 6 | 6 | T14, T16, T45 | Confirms duplicate target module pointers in Challenges #5 and #6 |
| 2. Box & Stack Challenges | [BalancedBoxRouting.lean](../proofs/oai_ref/lean/ComparatorChallenges/BalancedBoxRouting.lean#L1-L96), [BalancedThreeStack.lean](../proofs/oai_ref/lean/ComparatorChallenges/BalancedThreeStack.lean#L1-L239) | 3 | 127 | T01, T12, T16, T35, T38 | BalancedBoxRouting pure kinematic `Delivers` (no stack/halting); 3-stack routing & 38-def (51-decl) overlap |
| 3. Shear Sheet Challenges | [NavierStokesAlternating.lean](../proofs/oai_ref/lean/ComparatorChallenges/NavierStokesAlternating.lean#L1-L245), [SolenoidalSheetPrograms.lean](../proofs/oai_ref/lean/ComparatorChallenges/SolenoidalSheetPrograms.lean#L1-L197) | 2 | 100 | T03, T04, T14, T38 | Unidirectional shear sheets with advection u t x = 0 (L188) |
| 4. Velocity Challenge | [NavierStokesVelocity.lean](../proofs/oai_ref/lean/ComparatorChallenges/NavierStokesVelocity.lean#L1-L1275) | 1 | 195 | T11, T17, T18, T20, T27 | 48 inlined internal namespaces; `L454` helper-`def` `Prop` `(by sorry)` (`TapeCodes.lean:32-33` 0 sorry, `isDefEq` preserved; exposes comparator `def`-scanner blind spot; `main_result` target at L1232/L1270) |
| 5. Affine Box Transport | [BoxTransport/Flow.lean](../proofs/oai_ref/lean/OAI/Analysis/BoxTransport/Flow.lean#L1-L720), [Motion.lean](../proofs/oai_ref/lean/OAI/Analysis/BoxTransport/Motion.lean#L1-L652), [Routing.lean](../proofs/oai_ref/lean/OAI/Analysis/BoxTransport/Routing.lean#L1-L188) | 3 | 136 | T05–T08, T19, T39, T42 | Curl potential $U = \nabla\times(\chi\Psi)$ and lexicographic box parking |
| 6. Periodic Lattice & Leray | [PeriodicLattice/Main.lean](../proofs/oai_ref/lean/OAI/Analysis/PeriodicLattice/Main.lean#L1-L107), [Solenoidal.lean](../proofs/oai_ref/lean/OAI/Analysis/PeriodicLattice/Solenoidal.lean#L1-L421) | 2 | 54 | T03, T14, T41 | Periodic solenoidal profile and vertical energy identity |
| 7. Alternating & Rapid Flow | [AlternatingFlow/Main.lean](../proofs/oai_ref/lean/OAI/MathematicalPhysics/AlternatingFlow/Main.lean#L1-L29), [RapidForcing/Main.lean](../proofs/oai_ref/lean/OAI/MathematicalPhysics/RapidForcing/Main.lean#L1-L1) | 3 | 1 | T03, T04, T14, T38 | Time-alternating shear synthesis and rapidly vanishing forcing |
| 8. Balanced Transport & $L^2$ | [BoxCoding.lean](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/BalancedTransport/BoxCoding.lean#L1-L368), [Comparison.lean](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/BalancedTransport/Comparison.lean#L1-L137) | 7 | 122 | T01, T02, T21–T26, T33, T34, T44 | abel residual-forcing identity and $12C$ Serrin-Grönwall uniqueness |
| 9. Orphaned Hub Modules | [Main.lean](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/ForcedComputation/Main.lean#L1-L33), [Main.lean](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/Material/Main.lean#L1-L1) | 5 | 25 | T03, T14, T15, T21, T37, T43 | Root hubs of the 650 unimported OAI/ modules (64.7% orphaned) |
| 10. Heat-Kernel Detection | [HeatKernels.lean](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/VelocityDetection/HeatKernels.lean#L1-L97), [MainResult.lean](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/VelocityDetection/MainResult.lean#L1-L59) | 6 | 71 | T09–T11, T18, T27–T32, T36, T45 | $2+1\text{D}$ passive-scalar Duhamel positivity and unused `_hcomputable` |
| 11. Sheet-Flow Calculus | [Differential.lean](../proofs/oai_ref/lean/OAI/MathematicalPhysics/SheetFlows/Differential.lean#L1-L304), [Routing.lean](../proofs/oai_ref/lean/OAI/MathematicalPhysics/SheetFlows/Routing.lean#L1-L259) | 3 | 56 | T03, T04, T09, T10, T19 | Planar shear-sheet differential operators and register routing |
| 12. Architecture Overview | [lean/docs/376.md](../proofs/oai_ref/lean/docs/376.md#L1-L37) | 1 | 1 | T14, T15, T37, T38 | Official overview and scope omissions |
| Total (100.0%) | Full 894-Row Declaration Ledger: [04_Automated_Verification_and_Parser_Spec.md](04_Automated_Verification_and_Parser_Spec.md) | 42 | 894 | 45 Theorems (T01–T45) | 894 / 894 items mapped 1-to-1 (0 sorry) |



## 4. Beyond-Baseline Alternative Bounds and Sharp Rigidity Obstructions

1. Beyond-Baseline Alternative Bound: Replaces the five packaging and premise discrepancies (including the 5D rational-box oracle and unused `_hcomputable` premise) with five repair specifications (Theorems 33–37) establishing genuine discrete energy transfer bounds.
2. Sharp No-Go / Rigidity Obstruction: Establishes a hydrodynamic No-Go rigidity obstruction proving that finite 4-stage shear truncations decoupled from the non-local pressure Poisson inverse cannot force 3D Navier-Stokes blowup.
