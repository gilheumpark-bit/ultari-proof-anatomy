# Tier 1: Beginner Guide: Universal Computation in Forced Navier–Stokes Flows (#376)

OpenAI #376 (Universal computation in forced Navier–Stokes flows) formalizes how a 3D viscous fluid driven by an external body force $f$ can simulate finite register and stack machines. Auditing all 1,010 Lean 4 files (142,131 lines) and 75 LaTeX files across 45 standalone Lean 4 theorems (v4.29.0-rc8, 0 sorry, 184/184 hypothesis mutations caught) separates the valid mathematical mechanisms inside the disclosed forced-flow setting from packaging and specification gaps at the repository boundary.

This introductory guide is structured so readers without fluid-mechanics or formal-verification backgrounds can understand the modeling boundary, the three verified PDE mechanisms, and the four repository findings in five minutes.

## 1. Two Settings for Fluid Computation and Prior Literature

The incompressible Navier–Stokes equations govern a 3D velocity field $u(t, x)$ and pressure $p(t, x)$ with viscosity $\nu > 0$:

$$\partial_t u + (u \cdot \nabla) u = -\nabla p + \nu \Delta u + f, \qquad \nabla \cdot u = 0.$$

Mathematical physicists distinguish two different questions:
1. Autonomous (Unforced) Fluid Computation: With $f = 0$, can an initial velocity field $u(0, x)$ evolve under its own nonlinear vortex dynamics $(u \cdot \nabla) u$ to simulate logic gates and a Turing machine?
2. Prescribed Carrier (Inverse Forcing) Computation: In the tradition of hydrodynamic computation literature (Cardona–Miranda–Peralta-Salas–Presas 2021–2025; Tao 2016), if we first design a smooth velocity field $U(t, x)$ whose particle paths $\dot{X}(t) = U(t, X(t))$ move boxes like a state machine, and define the external force $f(t, x)$ to balance the PDE for $U$, is $U$ the unique smooth solution starting from rest?

OpenAI #376 explicitly addresses the second setting: forced flows starting from rest $u(0, x) = 0$. Both [docs/376.md:12,14,26](../proofs/oai_ref/lean/docs/376.md#L12-L26) and the manuscript (analysis.tex:36-41, 263-267) openly disclose zero-pressure forcing $f = f_0 + \nu f_1$, unidirectional shear scope, and the distinction between Euclidean $p = 0$ constructions and periodic torus $\mathbb{T}_L^3$ Leray projection ($p = -\phi$). After encoding the input word $w$ during $t \in [0, 1]$, the velocity field $U$ and force $f$ are time-1 periodic (PeriodicAfterOne) and independent of $w$ for all $t \ge 1$.

### Why Choose Inverse Forcing Instead of Autonomous Flow ($f = 0$)?
- The Forward-PDE Barrier (Viscous Diffusion vs. Box Geometry): In an unforced viscous fluid ($\nu > 0$, $f = 0$), viscous dissipation ($\nu \Delta u$) and nonlinear vortex stretching ($(u\cdot\nabla)u$) deform and blur rectangular fluid parcels over time, creating a mathematical barrier against preserving exact Cantor-box coordinates across unboundedly many Turing steps.
- Necessity of the Curl-Potential and Residual Pivot: Because of this barrier, #376 separates symbolic boxes using an odd-digit base $B = 2m+1$, constructs a volume-preserving velocity $U = \nabla\times(\chi\Psi)$ first, and defines the body force $f$ as the PDE residual.
- Concrete Numerical Example: With $m=2$ and $B=5$, stretching one stack coordinate by $s_0 = 5$ while compressing the second by $s_1 = 1/5$ and keeping $s_2 = 1$ preserves the product $5 \times \frac{1}{5} \times 1 = 1$, satisfying incompressibility identically.

## 2. Three Genuine PDE Mechanisms Verified in #376

1. Curl-of-Potential Affine Box Routing ([BoxTransport/Flow.lean](../proofs/oai_ref/lean/OAI/Analysis/BoxTransport/Flow.lean#L114-L225), [BoxTransport/Routing.lean](../proofs/oai_ref/lean/OAI/Analysis/BoxTransport/Routing.lean#L94-L108)):
   - Stretching a 3D box by $s_0(t)$ and $s_1(t)$ horizontally while setting $s_2(t) = (s_0(t) s_1(t))^{-1}$ vertically preserves fluid volume ($\ell_0 + \ell_1 + \ell_2 = 0$).
   - Taking the curl of a cutoff potential $U = \nabla \times (\chi \Psi)$ produces exact affine velocity on the box interior while keeping $\nabla \cdot U = 0$ everywhere ([Theorem 5](../proofs/ns376_kinematic_routing_and_forensics.lean#L81-L91), [Theorem 6](../proofs/ns376_kinematic_routing_and_forensics.lean#L98-L108)).
2. Serrin-Grönwall $L^2$ Energy Uniqueness ([BalancedTransport/Comparison.lean](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/BalancedTransport/Comparison.lean#L85-L132)):
   - Any smooth competitor $(u, p)$ with the same initial data and force $f$ satisfies $\frac{d}{dt}\|u - U\|_{L^2}^2 \le 12 C \|u - U\|_{L^2}^2$.
   - Grönwall's inequality forces $u \equiv U$ and $\nabla p \equiv 0$ ([Theorem 21](../proofs/ns376_gronwall_uniqueness_and_repairs.lean#L27-L32) to [Theorem 26](../proofs/ns376_gronwall_uniqueness_and_repairs.lean#L136-L149)).
3. 2+1D Gaussian Heat-Kernel Detector ([VelocityDetection/MildScalar.lean](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/VelocityDetection/MildScalar.lean#L1-L120)):
   - In NavierStokesVelocity, the velocity takes the $x_3$-independent form $u = (a_1, a_2, w)$.
   - This decouples the vertical component $w$ into a 2D linear advection-diffusion equation solved via the Gaussian heat kernel ([Theorem 27](../proofs/ns376_gronwall_uniqueness_and_repairs.lean#L158-L163) to [Theorem 31](../proofs/ns376_gronwall_uniqueness_and_repairs.lean#L210-L216)).

## 3. Four Modeling-Boundary and Packaging Findings in the Codebase

1. Disclosed Zero-Pressure Inverse Forcing ([BalancedTransport/Model.lean](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/BalancedTransport/Model.lean#L139-L146), [BoxCoding.lean](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/BalancedTransport/BoxCoding.lean#L53-L66)):
   - Consistent with [docs/376.md:26](../proofs/oai_ref/lean/docs/376.md#L26) and analysis.tex:36-41, [BalancedThreeStack.lean:124-132](../proofs/oai_ref/lean/ComparatorChallenges/BalancedThreeStack.lean#L124-L132) and BoxCoding.lean fix pressure $p = 0$ and define the force as $f = (\partial_t U + (U\cdot\nabla)U) - \nu\Delta U$.
   - Substituting these into the PDE yields the ring identity $A = \nu B + (A - \nu B)$, which Lean proves via abel ([Theorem 1](../proofs/ns376_kinematic_routing_and_forensics.lean#L18-L27), [Theorem 2](../proofs/ns376_kinematic_routing_and_forensics.lean#L34-L43)).
2. Disclosed Unidirectional Shear Scope ([SolenoidalSheetPrograms.lean:188](../proofs/oai_ref/lean/ComparatorChallenges/SolenoidalSheetPrograms.lean#L188)):
   - In [NavierStokesAlternating.lean](../proofs/oai_ref/lean/ComparatorChallenges/NavierStokesAlternating.lean#L1-L245) and SolenoidalSheetPrograms.lean, straight transport uses unidirectional shear sheets where $(u \cdot \nabla) u = 0$ identically ([Theorem 3](../proofs/ns376_kinematic_routing_and_forensics.lean#L50-L60)), while fixed-particle detection and solid-box reciprocal maps are explicitly excluded ([docs/376.md:14](../proofs/oai_ref/lean/docs/376.md#L14)).
3. Duplicate Challenge and 650 Unimported Files:
   - [ForcedNavierStokesComputation.lean](../proofs/oai_ref/lean/ComparatorChallenges/ForcedNavierStokesComputation.lean#L1-L232) (232 lines) shares all 38 definitions (37 def and 1 inductive) and 50 helper declarations plus the main theorem among 51 declarations with [BalancedThreeStack.lean](../proofs/oai_ref/lean/ComparatorChallenges/BalancedThreeStack.lean#L1-L239) (239 lines; 7 wrapper lines differ, [Theorem 16](../proofs/ns376_kinematic_routing_and_forensics.lean#L295-L311)).
   - Meanwhile, 650 of the 1,004 OAI/ files (64.7%, including non-zero pressure Solenoidal.lean and all 576 ForcedComputation/ files) are not imported by any of the 6 challenge entrypoints ([Theorem 14](../proofs/ns376_kinematic_routing_and_forensics.lean#L251-L263), [Theorem 15](../proofs/ns376_kinematic_routing_and_forensics.lean#L270-L285)), and VelocityDetection/MainResult.lean:51 leaves the viscosity computability premise unused.
4. Challenge Proof-Stripping Hygiene Artifact vs. Target Placeholder (NavierStokesVelocity.lean:454 vs. L1232/L1270):
   - [ComparatorChallenges/NavierStokesVelocity.lean](../proofs/oai_ref/lean/ComparatorChallenges/NavierStokesVelocity.lean#L1-L1275) (1,275 lines, [Theorem 17](../proofs/ns376_kinematic_routing_and_forensics.lean#L319-L331)) leaves an intentional target placeholder at main_result (lines 1232–1270) and also retains a proof-stripped by sorry inside a Prop quotient-well-definedness argument in def half at line 454 while inlining 48 internal namespaces.
   - Because [VelocityDetection/TapeCodes.lean:32-33](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/VelocityDetection/TapeCodes.lean#L32-L33) and [MainResult.lean:11-55](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/VelocityDetection/MainResult.lean#L11-L55) hold at 0 sorry and Lean 4 Prop proof irrelevance preserves definitional equality (isDefEq) with OAI/ (making line 454 not unsound in the kernel), its presence in an official comparator challenge file exposes a comparator sorry-scanner blind spot on helper def declarations alongside 48-namespace inlining (Gate 2).

## 4. Verification Scope and Five Repair Specifications

1. Independent 45-Theorem Verification: All 45 theorems in [ns376_kinematic_routing_and_forensics.lean](../proofs/ns376_kinematic_routing_and_forensics.lean) and [ns376_gronwall_uniqueness_and_repairs.lean](../proofs/ns376_gronwall_uniqueness_and_repairs.lean) compile with 0 sorry and 0 custom axioms (184/184 hypothesis mutations caught), alongside SymPy symbolic identities and PyTorch FP64 checks in [verify_symbolic_ns376.py](../proofs/verify_symbolic_ns376.py).
2. Five Formal Repair Targets ([Theorem 33](../proofs/ns376_gronwall_uniqueness_and_repairs.lean#L244-L249) to [Theorem 37](../proofs/ns376_gronwall_uniqueness_and_repairs.lean#L299-L306)): These specify fixed finite-dimensional forcing ($K=16$), unforced residual rejection ($f = 0$), Challenge 5 and 6 deduplication, active viscosity oracle consumption, and 100% module reachability without namespace inlining.
