# [Tier 1: Beginner Guide] Universal Computation in Forced Navier–Stokes Flows (`#376`)

OpenAI `#376` (*Universal computation in forced Navier–Stokes flows*) formalizes how a 3D viscous fluid driven by an external force $f$ can simulate finite register and stack machines. Auditing all `1,010` Lean 4 files (`142,131` lines) and `75` LaTeX files separates what is rigorously proved under the forced model from what remains open for unforced fluids.

---

## 1. Two Settings for Fluid Computation: Autonomous vs. Inverse Forcing

The incompressible Navier–Stokes equations govern a 3D velocity field $u(t, x)$ and pressure $p(t, x)$ with viscosity $\nu > 0$:

$$\partial_t u + (u \cdot \nabla) u = -\nabla p + \nu \Delta u + f, \qquad \nabla \cdot u = 0.$$

Mathematical physicists distinguish two different questions:
1. **Autonomous (Unforced) Fluid Computation**: With $f = 0$, can an initial velocity field $u(0, x)$ evolve under its own nonlinear vortex dynamics $(u \cdot \nabla) u$ to simulate logic gates and a Turing machine?
2. **Prescribed Carrier (Inverse Forcing) Computation**: If we first design a smooth velocity field $U(t, x)$ whose particle paths $\dot{X}(t) = U(t, X(t))$ move boxes like a state machine, and then define the external force $f(t, x)$ to balance the PDE for $U$, is $U$ the unique smooth solution starting from rest?

OpenAI `#376` addresses the **second setting**: forced flows starting from rest ($u(0, x) = 0$). After encoding the input word $w$ during $t \in [0, 1]$, the velocity field $U$ and force $f = f_0 + \nu f_1$ are time-1 periodic (`PeriodicAfterOne`) and independent of $w$ for all $t \ge 1$.

### Why Choose Inverse Forcing Instead of Autonomous Flow ($f = 0$)?
- **The Forward-PDE Barrier (Viscous Diffusion vs. Box Geometry)**: In an unforced viscous fluid ($\nu > 0$, $f = 0$), viscous dissipation ($\nu \Delta u$) and nonlinear vortex stretching ($(u\cdot\nabla)u$) deform and blur rectangular fluid parcels over time, which is the core reason why maintaining exact Cantor-box coordinates across unboundedly many Turing steps hits a mathematical barrier.
- **Necessity of the Curl-Potential & Residual Pivot**: Because of this barrier, `#376` separates symbolic boxes using an odd-digit base $B = 2m+1$, constructs a volume-preserving velocity $U = \nabla\times(\chi\Psi)$ first, and defines the body force $f$ as the PDE residual. For instance, with $m=2$ and $B=5$, stretching one stack coordinate by $s_0 = 5$ while compressing the second by $s_1 = 1/5$ and keeping $s_2 = 1$ preserves the product $5 \times \frac{1}{5} \times 1 = 1$, satisfying incompressibility identically.

---

## 2. Three Genuine PDE Mechanisms Verified in `#376`

1. **Curl-of-Potential Affine Box Routing ([`BoxTransport/Flow.lean`](../proofs/oai_ref/lean/OAI/Analysis/BoxTransport/Flow.lean#L114-L225), [`BoxTransport/Routing.lean`](../proofs/oai_ref/lean/OAI/Analysis/BoxTransport/Routing.lean#L94-L108))**:
   - Stretching a 3D box by $s_0(t)$ and $s_1(t)$ horizontally while setting $s_2(t) = (s_0(t) s_1(t))^{-1}$ vertically preserves fluid volume ($\ell_0 + \ell_1 + \ell_2 = 0$).
   - Taking the curl of a cutoff potential $U = \nabla \times (\chi \Psi)$ produces exact affine velocity on the box interior while keeping $\nabla \cdot U = 0$ everywhere ([`Theorem 5`](../proofs/ns376_kinematic_routing_and_forensics.lean#L81-L91), [`Theorem 6`](../proofs/ns376_kinematic_routing_and_forensics.lean#L98-L108)).
2. **Serrin-Grönwall $L^2$ Energy Uniqueness ([`BalancedTransport/Comparison.lean`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/BalancedTransport/Comparison.lean#L85-L132))**:
   - Any smooth competitor $(u, p)$ with the same initial data and force $f$ satisfies $\frac{d}{dt}\|u - U\|_{L^2}^2 \le 12 C \|u - U\|_{L^2}^2$.
   - Grönwall's inequality forces $u \equiv U$ and $\nabla p \equiv 0$ ([`Theorem 21`](../proofs/ns376_gronwall_uniqueness_and_repairs.lean#L27-L32) to [`Theorem 26`](../proofs/ns376_gronwall_uniqueness_and_repairs.lean#L136-L149)).
3. **2+1D Gaussian Heat-Kernel Detector ([`VelocityDetection/MildScalar.lean`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/VelocityDetection/MildScalar.lean#L1-L120))**:
   - In `NavierStokesVelocity`, the velocity takes the $x_3$-independent form $u = (a_1, a_2, w)$.
   - This decouples the vertical component $w$ into a 2D linear advection-diffusion equation solved via the Gaussian heat kernel ([`Theorem 27`](../proofs/ns376_gronwall_uniqueness_and_repairs.lean#L158-L163) to [`Theorem 31`](../proofs/ns376_gronwall_uniqueness_and_repairs.lean#L210-L216)).

---

## 3. Four Structural Findings in the Codebase (`Category A`)

1. **Zero-Pressure Manufactured Forcing ([`BalancedTransport/Model.lean`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/BalancedTransport/Model.lean#L139-L146), [`BoxCoding.lean`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/BalancedTransport/BoxCoding.lean#L53-L66))**:
   - In [`BalancedThreeStack.lean:124-132`](../proofs/oai_ref/lean/ComparatorChallenges/BalancedThreeStack.lean#L124-L132) and `BoxCoding.lean`, pressure is set to $p = 0$ and the force is defined as $f = (\partial_t U + (U\cdot\nabla)U) - \nu\Delta U$.
   - Substituting these into the PDE yields the ring identity $A = \nu B + (A - \nu B)$, which Lean proves in one word via `abel` ([`Theorem 1`](../proofs/ns376_kinematic_routing_and_forensics.lean#L18-L27), [`Theorem 2`](../proofs/ns376_kinematic_routing_and_forensics.lean#L34-L43)).
2. **Vanishing Advection on Shear Segments ([`SolenoidalSheetPrograms.lean:188`](../proofs/oai_ref/lean/ComparatorChallenges/SolenoidalSheetPrograms.lean#L188))**:
   - In [`NavierStokesAlternating.lean`](../proofs/oai_ref/lean/ComparatorChallenges/NavierStokesAlternating.lean#L1-L245) and `SolenoidalSheetPrograms.lean`, straight transport uses unidirectional shear sheets where $(u \cdot \nabla) u = 0$ identically ([`Theorem 3`](../proofs/ns376_kinematic_routing_and_forensics.lean#L50-L60)).
3. **Duplicate Challenge & `650` Unimported Files**:
   - [`ForcedNavierStokesComputation.lean`](../proofs/oai_ref/lean/ComparatorChallenges/ForcedNavierStokesComputation.lean#L1-L232) duplicates all 38 definitions of [`BalancedThreeStack.lean`](../proofs/oai_ref/lean/ComparatorChallenges/BalancedThreeStack.lean#L1-L239) ([`Theorem 16`](../proofs/ns376_kinematic_routing_and_forensics.lean#L295-L311)).
   - Meanwhile, `650` of the `1,004` `OAI/` files (`64.7%`) are not imported by any of the 6 challenge entrypoints ([`Theorem 14`](../proofs/ns376_kinematic_routing_and_forensics.lean#L251-L263), [`Theorem 15`](../proofs/ns376_kinematic_routing_and_forensics.lean#L270-L285)).
4. **Challenge Extractor Artifact (`NavierStokesVelocity.lean:454`)**:
   - [`ComparatorChallenges/NavierStokesVelocity.lean`](../proofs/oai_ref/lean/ComparatorChallenges/NavierStokesVelocity.lean#L1-L1275) (`1,275` lines, [`Theorem 17`](../proofs/ns376_kinematic_routing_and_forensics.lean#L319-L331)) left a stripped `by sorry` inside `def half` at line `454`, whose full proof resides in [`VelocityDetection/TapeCodes.lean:32-33`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/VelocityDetection/TapeCodes.lean#L32-L33).
