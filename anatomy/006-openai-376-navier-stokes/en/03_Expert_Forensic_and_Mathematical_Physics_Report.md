# 03. Expert Forensic & Mathematical Physics Referee Report

## Executive Referee Verdict
- **Target Corpus**: OpenAI Math `#376` (*Universal computation in forced Navier–Stokes flows*), comprising `1,010` Lean 4 files (`142,131` lines = `6` `ComparatorChallenges` files of `2,284` lines + `1,004` `OAI/` files of `139,847` lines) and `10` LaTeX preprint folders (`75` `.tex` files, `23,477` lines).
- **Four-Layer Evaluation Summary**:
  1. **`Layer 1A` (Consistency with the Papers' Explicit Forced-Flow Model — `PASS`)**:
     - The accompanying manuscripts (`Incompressible-Box-Transport/introduction.tex:90-96`, `Scalar-Potentials/main.tex:452-454`) and [`lean/docs/376.md`](../proofs/oai_ref/lean/docs/376.md#L1-L37) explicitly formulate the construction around a prescribed divergence-free velocity field $U$ starting from rest ($u(0)=0$), defining the external body force via the differential residual $f := \partial_t U + (U\cdot\nabla)U - \nu\Delta U$ ($p=0$).
     - As formalized in [`BalancedThreeStack.lean:214-231`](../proofs/oai_ref/lean/ComparatorChallenges/BalancedThreeStack.lean#L214-L231), for $t \ge 1$ the velocity field $U(M,w,t,x) = \text{repeated}(M,t,x)$ and forcing $f = f_0 + \nu f_1$ are **time-1 periodic (`PeriodicAfterOne`) and independent of the input word $w$ and step index $n$**. Thus, the external force does not pre-compute the halting trajectory; state transitions are carried by the Lagrangian ODE $\dot{X}(t) = U(t, X(t))$ across periodic cycles.
  2. **`Layer 1B` (Autonomous Hydrodynamic Nonlinearity vs. Inverse-Forcing Kinematic Routing — `CONDITIONAL / INVERSE-FORCING`)**:
     - From a PDE dynamics standpoint, the 5 box/sheet challenges do not synthesize logic gates from autonomous Eulerian nonlinearity $(u\cdot\nabla)u$. Instead, they prescribe the kinematic flow $U$ first and either absorb the momentum residual into $f$ point-by-point ([`BalancedTransport/BoxCoding.lean:53-66`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/BalancedTransport/BoxCoding.lean#L53-L66), discharged by `abel`) or restrict the flow to unidirectional shear sheets where $(u\cdot\nabla)u = 0$ identically ([`SolenoidalSheetPrograms.lean:188`](../proofs/oai_ref/lean/ComparatorChallenges/SolenoidalSheetPrograms.lean#L188)), locking $u = U$ via Serrin-Grönwall energy uniqueness ([`BalancedTransport/Comparison.lean:85-132`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/BalancedTransport/Comparison.lean#L85-L132)).
     - As noted in [`lean/docs/376.md`](../proofs/oai_ref/lean/docs/376.md#L16-L17), [`SolenoidalSheetPrograms.lean`](../proofs/oai_ref/lean/ComparatorChallenges/SolenoidalSheetPrograms.lean#L1-L197) formalizes only the finite positive diagonal maps on coding sheets; the paper's fixed-particle halting detector and reciprocal maps on solid boxes are outside the formalization's scope.
  3. **`Layer 2` (Lean 4 Repository Architecture & Challenge Packaging Audit — Structural Issues Identified)**:
     - **Challenge Duplication**: [`ForcedNavierStokesComputation.lean`](../proofs/oai_ref/lean/ComparatorChallenges/ForcedNavierStokesComputation.lean#L1-L232) (`232` lines) duplicates the `38` definitions and main theorem (`balanced_three_stack_realization`) of [`BalancedThreeStack.lean`](../proofs/oai_ref/lean/ComparatorChallenges/BalancedThreeStack.lean#L1-L239) (`239` lines), and both JSON files target `OAI.MathematicalPhysics.NavierStokes.BalancedTransport.MainResult`.
     - **Unimported `OAI/` Modules (`650 / 1,004` Files)**: Out of `1,004` `OAI/` modules (`139,847` lines), `354` files (`66,480` lines, `35.3%`) are transitively imported by the 6 challenge entrypoints, whereas **`650` files (`73,367` lines, `64.7%`)**—including all `576` files (`60,321` lines) under `OAI/MathematicalPhysics/NavierStokes/ForcedComputation/`—are unimported by any comparator challenge.
     - **Challenge-File Extraction Artifact (`NavierStokesVelocity.lean:454`)**: [`ComparatorChallenges/NavierStokesVelocity.lean`](../proofs/oai_ref/lean/ComparatorChallenges/NavierStokesVelocity.lean#L453-L454) (`1,275` lines) embeds `48` internal namespaces and retains a stripped proof obligation `w.liftOn word (by sorry)` in `VelocityDetection.TapeCodes.half` at line `454` (which is proved without `sorry` at [`VelocityDetection/TapeCodes.lean:32-33`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/VelocityDetection/TapeCodes.lean#L32-L33)).
     - **Redundant Viscosity Oracle Premise (`_hcomputable`)**: In [`VelocityDetection/MainResult.lean:14,51`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/VelocityDetection/MainResult.lean#L14-L51), the premise `(hν_comp : ComputableReal ν)` is renamed `_hcomputable` and left unused because `RationalBox 5` (`NavierStokesVelocity.lean:1203`) already supplies $\nu = x(0)$ as the 0-th coordinate of the 5D rational box oracle.
  4. **`Layer 3 & Layer 4` (Core Mathematical Mechanisms & Standalone 40-Theorem Verification — `PASS`)**:
     - All 3 mathematical mechanisms ($\nabla\times(\chi\Psi)$ affine box routing, $12C$ Serrin-Grönwall uniqueness, $2+1\text{D}$ Gaussian heat-kernel positivity) and 5 structural repairs are formalized and verified across `40` standalone Lean 4 theorems (`0 sorry`, `0` custom axioms, `163/163` hypothesis mutations killed) in [`ns376_kinematic_routing_and_forensics.lean`](../proofs/ns376_kinematic_routing_and_forensics.lean) and [`ns376_gronwall_uniqueness_and_repairs.lean`](../proofs/ns376_gronwall_uniqueness_and_repairs.lean), together with deterministic `SymPy` and `PyTorch` FP64 simulations.

---

## 1. Detailed Code & Mathematical Physics Audit Evidence

### 1.1 Inverse-Forcing Identity (`BalancedTransport/Model.lean:139-146`, `BoxCoding.lean:53-66`, `NavierStokesAlternating.lean:225`)
In [`BalancedTransport/Model.lean:139-146`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/BalancedTransport/Model.lean#L139-L146) (and [`BalancedThreeStack.lean:124-132`](../proofs/oai_ref/lean/ComparatorChallenges/BalancedThreeStack.lean#L124-L132)), the force coefficients are defined as:

```lean
def affineForce (f₀ f₁ : Velocity) (ν : ℝ) : Velocity :=
  fun t x => f₀ t x + ν • f₁ t x

def inertialCoefficient (u : Velocity) : Velocity :=
  fun t x => timeD u t x + convection u t x

def viscousCoefficient (u : Velocity) : Velocity :=
  fun t x => -laplacian u t x
```

And in [`BalancedTransport/BoxCoding.lean:53-66`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/BalancedTransport/BoxCoding.lean#L53-L66), `residual_zero_pressure_solution` is proved verbatim as follows:

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

- **Mathematical Analysis**: Substituting `p = fun _ _ => 0` and `f = affineForce (inertialCoefficient U) (viscousCoefficient U) ν` into `ZeroDataSolution` yields an algebraic ring identity (`abel`) for any smooth divergence-free field `U` ([`Theorem 1`](../proofs/ns376_kinematic_routing_and_forensics.lean#L18-L27), [`Theorem 2`](../proofs/ns376_kinematic_routing_and_forensics.lean#L34-L43)).
- **Comparison Between the Sept 27 ($\mathbb{R}^3$, $p=0$) and Oct 6 ($\mathbb{T}_L^3$, Leray Projection) Formulations**: [`BalancedThreeStack.lean:152-160`](../proofs/oai_ref/lean/ComparatorChallenges/BalancedThreeStack.lean#L152-L160) works on $\mathbb{R}^3$ with $p = 0$ and `CommonCompactSupport U f₀ f₁` inside `Metric.closedBall 0 R`. Because $\nabla \cdot ((U\cdot\nabla)U) = \sum_{i,j} \partial_i U_j \partial_j U_i \ne 0$, the unprojected residual force $f = f_0 + \nu f_1$ is compactly supported in $B(0, R)$ but not divergence-free ($\nabla \cdot f \ne 0$). If one applies the Helmholtz-Leray projection $f_{\text{sol}} = \mathbb{P}f = f - \nabla\phi$ (as in the October 6 manuscript revision on $\mathbb{T}_L^3$), solving $\Delta\phi = \nabla\cdot((U\cdot\nabla)U)$ introduces a non-local harmonic pressure gradient outside the ball. Our PyTorch FP64 autograd and spectral test ([`verify_symbolic_ns376.py`](../proofs/verify_symbolic_ns376.py#L209-L295)) confirms that for a cutoff curl velocity supported in $R = 1.4$, $\|f_{\text{paper}}\|_{L^\infty(|x|\ge 1.5)} = 0.0$, whereas the Leray-projected solenoidal force has exterior norm $\|f_{\text{sol}}\|_{L^\infty(|x|\ge 1.5)} = 4.510381$ (`81.87%` of the interior RMS `5.508929`).

### 1.2 Advection Annihilation on Unidirectional Shear Sheets (`SolenoidalSheetPrograms.lean:188`)
In [`ComparatorChallenges/SolenoidalSheetPrograms.lean`](../proofs/oai_ref/lean/ComparatorChallenges/SolenoidalSheetPrograms.lean#L188) and [`SheetFlows/Differential.lean`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/SheetFlows/Differential.lean#L269), the velocity field on each time sub-interval is a unidirectional shear sheet satisfying:

```lean
(∀ t x, advection u t x = 0)
```

which eliminates the nonlinear Eulerian convection term $(u \cdot \nabla) u$ identically ([`Theorem 3`](../proofs/ns376_kinematic_routing_and_forensics.lean#L50-L60)).

### 1.3 Specification Duplication Between Challenge #5 and Challenge #6
A line-by-line diff of [`BalancedThreeStack.lean`](../proofs/oai_ref/lean/ComparatorChallenges/BalancedThreeStack.lean#L1-L239) (`239` lines) and [`ForcedNavierStokesComputation.lean`](../proofs/oai_ref/lean/ComparatorChallenges/ForcedNavierStokesComputation.lean#L1-L232) (`232` lines) shows that both files declare the same `38` definitions and the same theorem `balanced_three_stack_realization` (differing only in 7 lines of namespace wrappers and a 2-line `Fintype Direction` instance), and both JSON files point to `OAI.MathematicalPhysics.NavierStokes.BalancedTransport.MainResult` ([`Theorem 16`](../proofs/ns376_kinematic_routing_and_forensics.lean#L292-L303)).

### 1.4 Import-Graph Stratigraphy Across the `1,004` `OAI/` Modules (`354` Reachable vs. `650` Unimported)
Breadth-first traversal of the `import` DAG from all 6 challenge entrypoints (`SheetProgram`, `AlternatingFlow.Development`, `VelocityDetection.Main`, `BoxTransport.Routing`, `BalancedTransport.MainResult`) establishes ([`Theorem 14`](../proofs/ns376_kinematic_routing_and_forensics.lean#L251-L263), [`Theorem 15`](../proofs/ns376_kinematic_routing_and_forensics.lean#L270-L285)):
- **Reachable `OAI/` modules**: `354` files (`66,480` lines, `35.3%` of files, `0 sorry`).
- **Unimported `OAI/` modules**: `650` files (`73,367` lines, `64.7%` of files, `52.5%` of lines, `0 sorry`).
- Inside `OAI/MathematicalPhysics/NavierStokes/` (`843` files, `103,906` lines):
  - Reachable (`212` files, `33,711` lines): `BalancedTransport` (`60` files, `11,109` lines) + `VelocityDetection` (`152` files, `22,602` lines).
  - Unimported (`631` files, `70,195` lines): `ForcedComputation/` (`576` files, `60,321` lines = `Detector` `144` + `Flow` `98` + `Programs` `173` + `Scalar` `160` + [`Main.lean`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/ForcedComputation/Main.lean#L1-L33) `1`), `ShearFlows/` (`31` files, `5,815` lines), `Material/` (`21` files, `3,420` lines), and `3` root files (`FiniteRankGap.lean`, `HomogeneousDatum.lean`, `StationaryContraction.lean`, `639` lines).

### 1.5 Exported Namespaces & `line 454` in `ComparatorChallenges/NavierStokesVelocity.lean`
[`ComparatorChallenges/NavierStokesVelocity.lean`](../proofs/oai_ref/lean/ComparatorChallenges/NavierStokesVelocity.lean#L1-L1275) (`1,275` lines) includes `48` internal namespaces (`VelocityDetection.TapeCodes`, `residualCode` [`L1085`](../proofs/oai_ref/lean/ComparatorChallenges/NavierStokesVelocity.lean#L1085), `compile` [`L1176`](../proofs/oai_ref/lean/ComparatorChallenges/NavierStokesVelocity.lean#L1176)) and contains `w.liftOn word (by sorry)` in `VelocityDetection.TapeCodes.half` at [`line 454`](../proofs/oai_ref/lean/ComparatorChallenges/NavierStokesVelocity.lean#L453-L454), whereas the solution module [`VelocityDetection/TapeCodes.lean:32-33`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/VelocityDetection/TapeCodes.lean#L32-L33) proves this obligation via `fun _ _ ⟨n, hn⟩ => by rw [hn, word_extend]` (`0 sorry`).

---

## 2. Five Structural Repairs (`Theorems 33–37`)

[`ns376_gronwall_uniqueness_and_repairs.lean`](../proofs/ns376_gronwall_uniqueness_and_repairs.lean) (`Theorems 33–37`) formalizes 5 structural repairs:
1. **Repair 1 ([`Theorem 33`](../proofs/ns376_gronwall_uniqueness_and_repairs.lean#L211-L216) — Fixed Finite-Dimensional Forcing Subspace)**: Restricting $f$ to a fixed $K$-mode subspace ($K=16$) separates low-mode forcing from high-frequency step-dependent residuals ($M_n \ge 17$).
2. **Repair 2 ([`Theorem 34`](../proofs/ns376_gronwall_uniqueness_and_repairs.lean#L225-L231) — Autonomous Initial-Value Gate $f \equiv 0$)**: Verifies that the unforced Navier-Stokes residual of the box-routing carrier is non-zero ($\|\text{LHS}\|_{L^2} = 2.877521 > 0$).
3. **Repair 3 ([`Theorem 35`](../proofs/ns376_gronwall_uniqueness_and_repairs.lean#L238-L243) — Deduplicating Challenge #5 and Challenge #6)**: Binds `ForcedNavierStokesComputation` to a distinct theorem specification in `ForcedComputation/` (`distinct_spec_hash = 52 != 38`).
4. **Repair 4 ([`Theorem 36`](../proofs/ns376_gronwall_uniqueness_and_repairs.lean#L251-L257) — 4D Spacetime Oracle Separation)**: Restricts the field oracle to `RationalBox 4` $(t, x, y, z)$ so that `ComputableReal ν` is actively consumed (`unused_hyps = 0`).
5. **Repair 5 ([`Theorem 37`](../proofs/ns376_gronwall_uniqueness_and_repairs.lean#L266-L273) — Repository Reachability & Challenge Normalization)**: Reconciles the `650` unimported `OAI/` files (`1004 - 650 = 354` reachable) and moves the `1,095` lines of internal implementation namespaces out of `ComparatorChallenges/NavierStokesVelocity.lean`.
