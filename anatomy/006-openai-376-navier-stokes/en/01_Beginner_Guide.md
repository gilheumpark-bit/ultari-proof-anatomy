# 01. Beginner Guide: Understanding Universal Computation in Forced Navier-Stokes Flows (`#376`)

## Executive Summary
OpenAI Math corpus **`#376` (*Universal computation in forced Navier–Stokes flows*)** formalizes how fluid trajectories and velocity fields in a **3D viscous incompressible fluid driven by an external body force $f$** can simulate finite register and stack machines (Turing-complete computation).
Auditing all **`1,010` Lean 4 files (`142,131` lines = `6` `ComparatorChallenges` files of `2,284` lines + `1,004` `OAI/` files of `139,847` lines)** alongside the **`10` LaTeX preprint folders (`75` `.tex` files, `23,477` lines)** separates the corpus into two clear parts:

1. **What holds rigorously under the papers' stated model (`Layer 1A` & `Layer 3`)**:
   - Every one of the `1,004` `.lean` files under `lean/OAI/` compiles with `0 sorry` and `0` custom axioms.
   - The external forcing $f(t, x)$ does **not** pre-compute the halting outcome or depend on the step number $n$ after time $t = 1$. After encoding the input word $w$ during $t \in [0, 1]$, the velocity field $U(M, w, t, x) = \text{repeated}(M, t, x)$ and forcing $f = f_0 + \nu f_1$ are **time-1 periodic (`PeriodicAfterOne`, $U(t+1, x) = U(t, x)$) and independent of the input $w$** for all $t \ge 1$. Computation proceeds via the Lagrangian particle ODE $\dot{X}(t) = U(t, X(t))$ transporting solid boxes across cycles.
   - Three core mathematical mechanisms are genuinely formalized:
     1. **Volume-preserving affine box routing** via the curl of a cutoff vector potential $U = \nabla \times (\chi \Psi)$ ([`BoxTransport/Flow.lean`](../proofs/oai_ref/lean/OAI/Analysis/BoxTransport/Flow.lean#L114-L225), [`BoxTransport/Routing.lean`](../proofs/oai_ref/lean/OAI/Analysis/BoxTransport/Routing.lean#L94-L108)),
     2. **Serrin-Grönwall $L^2$ energy uniqueness** ($\frac{d}{dt}\|u - U\|_{L^2}^2 \le 12 C \|u - U\|_{L^2}^2$) against arbitrary smooth competitors in the stated comparison class ([`BalancedTransport/Comparison.lean`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/BalancedTransport/Comparison.lean#L85-L132)), and
     3. **2+1D Gaussian heat-kernel Duhamel positivity** for the vertical velocity component $w$ in [`VelocityDetection/MildScalar.lean`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/VelocityDetection/MildScalar.lean#L1-L120).
2. **Mathematical-physics scope boundaries & repository packaging findings (`Layer 1B` & `Layer 2`)**:
   - **Prescribed kinematic carrier & inverse forcing**: Rather than synthesizing logic gates out of autonomous nonlinear vortex dynamics ($f = 0$), the 5 box/sheet challenges first construct a divergence-free kinematic carrier flow $U(t, x)$ and define the external force point-by-point as the differential residual $f := \partial_t U + (U\cdot\nabla)U - \nu\Delta U$ with $p = 0$ (verified in Lean by the single ring tactic `abel` at [`BoxCoding.lean:53-66`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/BalancedTransport/BoxCoding.lean#L53-L66)), or restrict the flow to unidirectional shear sheets where nonlinear advection vanishes identically (`advection u t x = 0` at [`SolenoidalSheetPrograms.lean:188`](../proofs/oai_ref/lean/ComparatorChallenges/SolenoidalSheetPrograms.lean#L188)).
   - **Duplicated challenge specification & unimported `OAI/` modules**: Challenge #6 ([`ForcedNavierStokesComputation.lean`](../proofs/oai_ref/lean/ComparatorChallenges/ForcedNavierStokesComputation.lean#L1-L232), `232` lines) duplicates the `38` definitions and main theorem (`balanced_three_stack_realization`) of Challenge #5 ([`BalancedThreeStack.lean`](../proofs/oai_ref/lean/ComparatorChallenges/BalancedThreeStack.lean#L1-L239), `239` lines). Furthermore, out of `1,004` `OAI/` modules, **`650` files (`73,367` lines, `64.7%`)**—including all `576` files (`60,321` lines) under `OAI/MathematicalPhysics/NavierStokes/ForcedComputation/`—are not imported by any of the 6 comparator challenges.

---

## 1. Two Formulations of Fluid Computation: Autonomous PDE vs. Inverse Forcing

The incompressible Navier-Stokes equations govern a 3D velocity field $u(t, x)$ and pressure $p(t, x)$ with viscosity $\nu > 0$:

$$\underbrace{\partial_t u}_{\text{acceleration}} + \underbrace{(u \cdot \nabla) u}_{\text{nonlinear advection}} = -\underbrace{\nabla p}_{\text{pressure gradient}} + \underbrace{\nu \Delta u}_{\text{viscous diffusion}} + \underbrace{f}_{\text{external body force}}, \qquad \nabla \cdot u = 0.$$

When asking whether a fluid flow can perform universal computation, mathematical physicists distinguish two settings:
1. **Autonomous / Forward PDE Computation**: With $f = 0$ (or a fixed background force), does an initial velocity field $u(0, x)$ evolve under its own nonlinear vortex stretching $(u \cdot \nabla) u$ to simulate logic gates and a Turing machine?
2. **Prescribed Carrier / Inverse Forcing Computation**: If one first designs a smooth divergence-free velocity field $U(t, x)$ whose particle trajectories $\dot{X}(t) = U(t, X(t))$ route boxes according to machine transitions, and then defines the external body force $f(t, x)$ to balance the momentum equation for $U$, is $U$ the unique smooth Navier-Stokes solution starting from rest?

OpenAI `#376` explicitly addresses the **second setting** (forced Navier-Stokes flows starting from rest $u(0, x) = 0$).

---

## 2. Four Structural Findings in the `#376` Formalization

### Finding 1: Inverse-Forcing Algebraic Identity (`BalancedTransport/Model.lean:139-146`, `BoxCoding.lean:53-66`)
In [`BalancedTransport/Model.lean`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/BalancedTransport/Model.lean#L139-L146) (and [`BalancedThreeStack.lean:124-132`](../proofs/oai_ref/lean/ComparatorChallenges/BalancedThreeStack.lean#L124-L132)) together with [`BalancedTransport/BoxCoding.lean`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/BalancedTransport/BoxCoding.lean#L53-L66), the formalization defines:
1. `inertialCoefficient u := fun t x => timeD u t x + convection u t x` ($f_0 = \partial_t U + (U \cdot \nabla)U$),
2. `viscousCoefficient u := fun t x => -laplacian u t x` ($f_1 = -\Delta U$), and
3. `affineForce f₀ f₁ ν := fun t x => f₀ t x + ν • f₁ t x` ($f = f_0 + \nu f_1$), with pressure `fun _ _ => 0` ($p = 0$).

Substituting $p = 0$ and $f = (\partial_t U + (U\cdot\nabla)U) + \nu(-\Delta U)$ into the momentum equation $\partial_t U + (U\cdot\nabla)U = -\nabla p + \nu \Delta U + f$ turns the PDE into the elementary additive identity $A = \nu B + (A - \nu B)$, which Lean 4 discharges in a single line via `abel` ([`Theorem 1`](../proofs/ns376_kinematic_routing_and_forensics.lean#L18-L27), [`Theorem 2`](../proofs/ns376_kinematic_routing_and_forensics.lean#L34-L43)).

### Finding 2: Vanishing Nonlinear Advection on Straight Shear Segments (`SolenoidalSheetPrograms.lean:188`)
In [`SolenoidalSheetPrograms.lean`](../proofs/oai_ref/lean/ComparatorChallenges/SolenoidalSheetPrograms.lean#L188) and [`NavierStokesAlternating.lean`](../proofs/oai_ref/lean/ComparatorChallenges/NavierStokesAlternating.lean#L1-L245), the velocity field on each straight transport stage is a unidirectional shear sheet (velocity pointing along one coordinate axis while varying only along orthogonal axes). Consequently, the nonlinear convective term $(u \cdot \nabla) u$ vanishes identically (`∀ t x, advection u t x = 0`), reducing the momentum equation on those segments to a linear heat equation ([`Theorem 3`](../proofs/ns376_kinematic_routing_and_forensics.lean#L50-L60)).

### Finding 3: Duplication of Challenge #5 and Challenge #6 & `650` Unimported Modules
Comparing [`BalancedThreeStack.lean`](../proofs/oai_ref/lean/ComparatorChallenges/BalancedThreeStack.lean#L1-L239) (`239` lines) and [`ForcedNavierStokesComputation.lean`](../proofs/oai_ref/lean/ComparatorChallenges/ForcedNavierStokesComputation.lean#L1-L232) (`232` lines) shows that both files declare the exact same `38` definitions and the same theorem `balanced_three_stack_realization`, and both JSON configurations point to `OAI.MathematicalPhysics.NavierStokes.BalancedTransport.MainResult` ([`Theorem 16`](../proofs/ns376_kinematic_routing_and_forensics.lean#L292-L303)). Meanwhile, `650` of the `1,004` `.lean` files under `lean/OAI/` (`64.7%`), including all `576` files in `OAI/MathematicalPhysics/NavierStokes/ForcedComputation/`, are unimported by the 6 challenge entrypoints ([`Theorem 14`](../proofs/ns376_kinematic_routing_and_forensics.lean#L251-L263), [`Theorem 15`](../proofs/ns376_kinematic_routing_and_forensics.lean#L270-L285)).

### Finding 4: Exported Implementation Namespaces in `NavierStokesVelocity.lean` (`line 454`)
[`ComparatorChallenges/NavierStokesVelocity.lean`](../proofs/oai_ref/lean/ComparatorChallenges/NavierStokesVelocity.lean#L1-L1275) is `1,275` lines long—longer than the other 5 challenge files combined (`1,009` lines, [`Theorem 17`](../proofs/ns376_kinematic_routing_and_forensics.lean#L311-L323))—because `48` internal namespaces (`residualCode`, `compile`, `VelocityDetection.TapeCodes`, etc.) were exported into the challenge specification. At line `454`, the challenge extractor replaced the proof argument inside `def half (w : ListBlank (Fin b)) : ℕ := w.liftOn word (by sorry)` with `by sorry`; the complete proof `fun _ _ ⟨n, hn⟩ => by rw [hn, word_extend]` resides in the solution module [`VelocityDetection/TapeCodes.lean:32-33`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/VelocityDetection/TapeCodes.lean#L32-L33).

---

## 3. Three Genuine Mathematical Mechanisms Verified in `#376`

1. **Curl-of-Potential Affine Box Routing ([`BoxTransport/Flow.lean`](../proofs/oai_ref/lean/OAI/Analysis/BoxTransport/Flow.lean#L114-L225), [`BoxTransport/Routing.lean`](../proofs/oai_ref/lean/OAI/Analysis/BoxTransport/Routing.lean#L94-L108))**:
   To stretch a 3D box by $s_0(t)$ and $s_1(t)$ horizontally without changing fluid volume, the vertical scale is set to $s_2(t) = (s_0(t) s_1(t))^{-1}$ so that $\ell_0 + \ell_1 + \ell_2 = 0$. Taking the curl of a cutoff skew-symmetric potential $U = \nabla \times (\chi \Psi)$ guarantees exact affine velocity $v_i + \ell_i y_i$ on the interior plateau ($\chi = 1$) while maintaining $\nabla \cdot U = 0$ globally across the cutoff transition zone ([`Theorem 5`](../proofs/ns376_kinematic_routing_and_forensics.lean#L81-L91), [`Theorem 6`](../proofs/ns376_kinematic_routing_and_forensics.lean#L98-L104)).
2. **Serrin-Grönwall $L^2$ Energy Uniqueness ([`BalancedTransport/Comparison.lean`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/BalancedTransport/Comparison.lean#L85-L132))**:
   For any smooth competitor $(u, p)$ in the comparison class with the same initial data $u(0) = U(0) = 0$ and external force $f$, the difference $w = u - U$ cancels $f$ and satisfies $\frac{d}{dt}\|w(t)\|_{L^2}^2 \le 12 C \|w(t)\|_{L^2}^2$, yielding $u \equiv U$ and $\nabla p \equiv 0$ by Grönwall's inequality ([`Theorem 21`](../proofs/ns376_gronwall_uniqueness_and_repairs.lean#L27-L32)~[`Theorem 26`](../proofs/ns376_gronwall_uniqueness_and_repairs.lean#L103-L112)).
3. **2+1D Gaussian Heat-Kernel Halting Detector ([`VelocityDetection/MildScalar.lean`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/VelocityDetection/MildScalar.lean#L1-L120))**:
   In `NavierStokesVelocity`, the velocity has the $x_3$-independent form $u = (a_1(t,x_1,x_2), a_2(t,x_1,x_2), w(t,x_1,x_2))$, decoupling the vertical component $w$ into a 2D linear passive-scalar advection-diffusion equation solved via the Gaussian heat kernel Duhamel integral ([`Theorem 27`](../proofs/ns376_gronwall_uniqueness_and_repairs.lean#L125-L130)~[`Theorem 31`](../proofs/ns376_gronwall_uniqueness_and_repairs.lean#L177-L183)).
