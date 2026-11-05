# 02. Intermediate Math & Code Guide: 6-Challenge Architecture and 3 Core Mathematical Mechanisms

## Executive Summary
The OpenAI `#376` corpus comprises **`10` LaTeX preprint folders (`9` distinct papers + `1` October 6 revision, totaling `75` `.tex` files and `23,477` lines)** and **`1,010` Lean 4 files (`142,131` lines = `1,004` `OAI/` library modules with `0 sorry` and `0` custom axioms + `6` `ComparatorChallenges` files of `2,284` lines)**. This guide maps the preprint series to the Lean 4 modules and derives the differential equations behind the three core mathematical mechanisms.

---

## 0. Complete Mapping of the 10 Preprint Folders to Lean 4 Modules

| # | Preprint Folder (Date) | `.tex` Files / Lines | Core Mathematical / Physical Problem Addressed | Corresponding Lean 4 Modules (`OAI/**`, all `0 sorry`) |
| :---: | :--- | :---: | :--- | :--- |
| **1** | `A-Fixed-Particle-Test-for-Computation-in-a-Forced-Viscous-Flow` (09-27) | `3` / `901` | Fixed-particle halting test (`a_*` entering an open box from rest $u(0)=0$ on $\mathbb{T}^3$ with bounded spatial derivatives via slow clock steps) | `ForcedComputation/Programs/FixedParticleMain.lean`, `TorusSlowMain.lean` |
| **2** | `Computation-under-Rapidly-Vanishing-Navier-Stokes-Forcing` (09-27) | `5` / `1,419` | Computation under $O(t^{-N})$ rapidly decaying velocity and force derivatives (finite total particle travel distance via `addressed`, `alternating`, and `lattice` encodings) | [`RapidForcing/Main.lean`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/RapidForcing/Main.lean#L1) (`55` files), [`PeriodicLattice/Main.lean`](../proofs/oai_ref/lean/OAI/Analysis/PeriodicLattice/Main.lean#L1-L40) (`32` files), [`Material/Main.lean`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/Material/Main.lean#L1) (`21` files) |
| **3** | `Finite-Instructions-and-Solenoidal-Shear-Flows` (09-27) | `1` / `1,012` | Strictly solenoidal forcing ($\nabla \cdot f = 0$) with $p = 0$ via unidirectional shear flows where $(u \cdot \nabla) u \equiv 0$ | [`ShearFlows/Main.lean`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/ShearFlows/Main.lean#L1-L45) (`31` files), `ForcedComputation/Programs/InitializedMain.lean` |
| **4** | `Geometric-Programs-for-Solenoidal-Forcing` (09-27) | `10` / `2,151` | Time-1 periodic solenoidal shear forcing from $t=0$ on $\mathbb{T}^3$ realizing positive diagonal maps on coding sheets (source for [`SolenoidalSheetPrograms.lean`](../proofs/oai_ref/lean/ComparatorChallenges/SolenoidalSheetPrograms.lean#L1-L197)) | [`SheetFlows/SheetProgram.lean`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/SheetFlows/SheetProgram.lean#L1-L65) (`26` files), `ForcedComputation/Programs/PeriodicMain.lean` |
| **5** | `Prefix-Instructions-and-Incompressible-Flows` (09-27) | `11` / `3,202` | Non-bijective prefix instructions via history recorders and vertical divergence compensation (connected to [`NavierStokesAlternating.lean`](../proofs/oai_ref/lean/ComparatorChallenges/NavierStokesAlternating.lean#L1-L245)) | [`AlternatingFlow/Development.lean`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/AlternatingFlow/Development.lean#L1) (`41` files), `ForcedComputation/Programs/PrefixMain.lean` |
| **6** | `Scalar-Potentials-and-Slow-Clocks-for-Forced-Fluid-Computation` (09-27) | `9` / `796` | Three scalar potentials (lift-execute-lower), $O((1+t)^{-1-j})$ slow clocks, and planar Hamiltonian processor (`PlanarProcessor`) | `ForcedComputation/Scalar/ScalarDecayMain.lean` (`160` files), `ForcedComputation/Flow/PlanarProcessorMain.lean` (`98` files) |
| **7** | `Universal-Computation-with-Eventually-Stationary-Navier-Stokes-Forcing` (09-27) | `1` / `1,017` | Eventually stationary forcing ($\partial_t f = 0$ for $t \ge 1$) using the third spatial coordinate as a clock | `ForcedComputation/Programs/StationaryMain.lean`, `ParticleDecisionUnconditional.lean` |
| **8** | `Velocity-Field-Detection-of-Computation-in-Forced-Navier-Stokes-Flows` (09-27) | `3` / `1,343` | Eulerian velocity-field halting detection ($u_3(t, x) > 1/2$ on $\mathbb{T}^3$ and $\mathbb{R}^2 \times \mathbb{T}$, source for [`NavierStokesVelocity.lean`](../proofs/oai_ref/lean/ComparatorChallenges/NavierStokesVelocity.lean#L1-L1275)) | [`VelocityDetection/MainResult.lean`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/VelocityDetection/MainResult.lean#L1-L59) (`152` files), `ForcedComputation/Detector/VelocityUnconditional.lean` (`144` files) |
| **9a** | `Incompressible-Box-Transport-and-Finite-Computation` (09-27) | `16` / `5,772` | 3D solid rational box transport on $\mathbb{R}^3$ via $\nabla \times (\chi \Psi)$ and balanced 3-stack simulation (source for [`BalancedBoxRouting.lean`](../proofs/oai_ref/lean/ComparatorChallenges/BalancedBoxRouting.lean#L1-L96) and [`BalancedThreeStack.lean`](../proofs/oai_ref/lean/ComparatorChallenges/BalancedThreeStack.lean#L1-L239)) | [`BoxTransport/Routing.lean`](../proofs/oai_ref/lean/OAI/Analysis/BoxTransport/Routing.lean#L1-L120) (`7` files), [`BalancedTransport/MainResult.lean`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/BalancedTransport/MainResult.lean#L1-L60) (`60` files) |
| **9b** | `Incompressible-Box-Transport-and-Finite-Computation` (10-06 rev.) | `16` / `5,864` | Adds periodic torus $\mathbb{T}_L^3$ Helmholtz-Leray projection (`Proposition prop:projection-l2`: $Pg = g - \nabla\phi$, pressure $-\phi$) and Sobolev bounds $\|Pg\|_{C^r} \le S_L \|g\|_{H^{r+2}}$ | `BalancedTransport/` and `ForcedComputation/Programs/BalancedMain.lean` |

---

## 1. Architecture of the 6 Comparator Challenges (`ComparatorChallenges/`)

| # | Challenge File (`ComparatorChallenges/`) | Lines | Target Solution Module (`.json`) | Domain & Kinematic / PDE Engine | Nonlinear Term $(u\cdot\nabla)u$ | Pressure $p$ & Forcing $f$ Structure |
| :---: | :--- | :---: | :--- | :--- | :--- | :--- |
| **1** | [`SolenoidalSheetPrograms.lean`](../proofs/oai_ref/lean/ComparatorChallenges/SolenoidalSheetPrograms.lean#L1-L197) | `197` | [`OAI.MathematicalPhysics.SheetFlows.SheetProgram`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/SheetFlows/SheetProgram.lean#L1-L65) | $\mathbb{T}^3$ unidirectional shear sheets | Identically $0$ (`advection u t x = 0`) | $p \equiv 0$, $f := \partial_t u - \nu \Delta u$ (solenoidal shear force) |
| **2** | [`NavierStokesAlternating.lean`](../proofs/oai_ref/lean/ComparatorChallenges/NavierStokesAlternating.lean#L1-L245) | `245` | [`OAI.MathematicalPhysics.AlternatingFlow.Development`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/AlternatingFlow/Development.lean#L1) | $\mathbb{R}^3$ compactly supported alternating shear flow | $0$ on straight shear segments | $p \equiv 0$, `residual ν u := ∂_t u + (u·∇)u - ν Δu` |
| **3** | [`NavierStokesVelocity.lean`](../proofs/oai_ref/lean/ComparatorChallenges/NavierStokesVelocity.lean#L1-L1275) | `1,275` | [`OAI.MathematicalPhysics.NavierStokes.VelocityDetection.Main`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/VelocityDetection/Main.lean#L1-L7) | $\mathbb{T}^3$ & $\mathbb{R}^2 \times \mathbb{T}$ $2+1\text{D}$ triangular passive scalar | Horizontal $(a\cdot\nabla_h)w$ kept, vertical $w\partial_3 w = 0$ | Horizontal inverse residual + vertical Gaussian heat-kernel Duhamel integral |
| **4** | [`BalancedBoxRouting.lean`](../proofs/oai_ref/lean/ComparatorChallenges/BalancedBoxRouting.lean#L1-L96) | `96` | [`OAI.Analysis.BoxTransport.Routing`](../proofs/oai_ref/lean/OAI/Analysis/BoxTransport/Routing.lean#L1-L120) | $\mathbb{R}^3$ affine vector potential curl $\nabla \times (\chi \Psi)$ | Pure divergence-free kinematic ODE (no $\nu$) | No momentum equation (pure box transport ODE) |
| **5** | [`BalancedThreeStack.lean`](../proofs/oai_ref/lean/ComparatorChallenges/BalancedThreeStack.lean#L1-L239) | `239` | [`OAI.MathematicalPhysics.NavierStokes.BalancedTransport.MainResult`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/BalancedTransport/MainResult.lean#L1-L60) | $\mathbb{R}^3$ compactly supported 3-stack machine + box routing | $(U\cdot\nabla)U \ne 0$ (absorbed into $f_0$) | $p \equiv 0$, $f = f_0 + \nu f_1$ (`abel` identity) |
| **6** | [`ForcedNavierStokesComputation.lean`](../proofs/oai_ref/lean/ComparatorChallenges/ForcedNavierStokesComputation.lean#L1-L232) | `232` | [`OAI.MathematicalPhysics.NavierStokes.BalancedTransport.MainResult`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/BalancedTransport/MainResult.lean#L1-L60) | **Identical to #5 (`38` definitions & theorem cloned)** | **Same as #5** | **Same as #5 (`ForcedComputation` 576 files unimported)** |

---

## 2. Core Mathematical Mechanism 1: Moving Affine Vector Potential (`BoxTransport/Routing.lean`)

### 2.1 Problem Setup
To transport all fluid particles inside a moving box $B(t) = \prod_{i=0}^2 [c_i(t) - s_i(t), c_i(t) + s_i(t)] \subset \mathbb{R}^3$ by an affine map, let $y_i = x_i - c_i(t)$ denote relative coordinates, $v_i(t) = \dot{c}_i(t)$ the translation velocity, and $\ell_i(t) = \frac{\dot{s}_i(t)}{s_i(t)} = \frac{d}{dt}\ln s_i(t)$ the logarithmic stretching rate. The desired interior velocity field is:

$$U_{\text{target}, i}(t, x) = v_i(t) + \ell_i(t) (x_i - c_i(t)) = v_i + \ell_i y_i \qquad (i \in \{0, 1, 2\}).$$

### 2.2 Volume-Preserving Condition and Skew-Symmetric Tensor Potential $\Psi_{i,j}$
Incompressibility ($\nabla \cdot U_{\text{target}} = 0$) requires the trace condition ([`Theorem 7`](../proofs/ns376_kinematic_routing_and_forensics.lean#L114-L125)):

$$\nabla \cdot U_{\text{target}} = \ell_0(t) + \ell_1(t) + \ell_2(t) = \frac{d}{dt} \ln\big(s_0(t) s_1(t) s_2(t)\big) = 0 \iff s_2(t) = \frac{1}{s_0(t) s_1(t)}.$$

Multiplying $U_{\text{target}}$ directly by a spatial cutoff $\chi(t, x)$ would violate $\nabla \cdot (\chi U_{\text{target}}) = 0$ on the transition shell where $\nabla \chi \ne 0$. Instead, [`BoxTransport/Flow.lean:114-120, 205-225`](../proofs/oai_ref/lean/OAI/Analysis/BoxTransport/Flow.lean#L114-L225) (with representability proved in [`BoxTransport/Routing.lean:94-108`](../proofs/oai_ref/lean/OAI/Analysis/BoxTransport/Routing.lean#L94-L108)) defines the skew-symmetric potential $\Psi_{i,j}(t, x) = -\Psi_{j,i}(t, x)$ (`potentialComponent` / `movingAffinePotential`):

$$\Psi_{i,j}(t, x) = \frac{1}{2}\big(v_i(t) y_j - v_j(t) y_i\big) + \frac{1}{3}\big(\ell_i(t) - \ell_j(t)\big) y_i y_j,$$

and sets $U_i(t, x) := \partial_{i+1}(\chi \Psi_{i, i+1}) - \partial_{i+2}(\chi \Psi_{i+2, i})$ ($\text{indices} \bmod 3$).
1. **Global Solenoidality ($\nabla \cdot U \equiv 0$, [`Theorem 6`](../proofs/ns376_kinematic_routing_and_forensics.lean#L98-L104))**: By symmetry of mixed partials $\partial_i \partial_j = \partial_j \partial_i$, $\sum_{i=0}^2 \partial_i U_i \equiv 0$ everywhere regardless of $\nabla \chi$.
2. **Interior Plateau Recovery ($\chi \equiv 1$, [`Theorem 5`](../proofs/ns376_kinematic_routing_and_forensics.lean#L81-L91))**: For $i = 0$,
   $$\partial_1 \Psi_{0,1} - \partial_2 \Psi_{2,0} = \left(\frac{1}{2}v_0 + \frac{1}{3}(\ell_0 - \ell_1)y_0\right) + \left(\frac{1}{2}v_0 + \frac{1}{3}(\ell_0 - \ell_2)y_0\right) = v_0 + \frac{1}{3}(2\ell_0 - \ell_1 - \ell_2)y_0 = v_0 + \ell_0 y_0$$
   whenever $\ell_0 + \ell_1 + \ell_2 = 0$.

---

## 3. Core Mathematical Mechanism 2: Serrin-Grönwall $L^2$ Energy Uniqueness (`BalancedTransport/Comparison.lean`)

Given the external body force $f := \partial_t U + (U \cdot \nabla) U - \nu \Delta U$, [`BalancedTransport/Comparison.lean`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/BalancedTransport/Comparison.lean#L20-L132) proves that any competitor solution $(u, p)$ in `ComparisonClass` ($u \in C_t H^2_x \cap C^1_t L^2_x$, bounded $u, \nabla u$ on finite time intervals) starting from $u(0) = U(0) = 0$ satisfies $u \equiv U$ and $\nabla p \equiv 0$:

1. **Forcing Cancellation ([`Theorem 21`](../proofs/ns376_gronwall_uniqueness_and_repairs.lean#L27-L32))**: Subtracting the momentum equations for $(u, p)$ and $(U, 0)$ cancels $f$ identically (`difference_equation`, [`Comparison.lean:20-45`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/BalancedTransport/Comparison.lean#L20-L45)):
   $$\partial_t w + (u \cdot \nabla) w + (w \cdot \nabla) U + \nabla(p - c) - \nu \Delta w = 0, \qquad w := u - U.$$
2. **Energy Pairing & Advection Cancellation ([`Theorem 22`](../proofs/ns376_gronwall_uniqueness_and_repairs.lean#L43-L48), [`Theorem 23`](../proofs/ns376_gronwall_uniqueness_and_repairs.lean#L57-L64))**: Because $\nabla \cdot u = 0$ and $\nabla \cdot w = 0$, the transport pairing $\int w \cdot (u \cdot \nabla) w \, dx = 0$ and pressure pairing $\int w \cdot \nabla(p - c) \, dx = 0$ vanish, while viscous dissipation is non-positive ($-2\nu\|\nabla w\|_{L^2}^2 \le 0$). Bounding $|\partial_j U_i| \le C$ across the 9 components of $\nabla U$ yields ([`Comparison.lean:111-126`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/BalancedTransport/Comparison.lean#L111-L126)):
   $$\frac{d}{dt}\|w(t)\|_{L^2}^2 \le 12 C \|w(t)\|_{L^2}^2.$$
3. **Grönwall Uniqueness & Constant Pressure ([`Theorem 24`](../proofs/ns376_gronwall_uniqueness_and_repairs.lean#L72-L81)~[`Theorem 26`](../proofs/ns376_gronwall_uniqueness_and_repairs.lean#L103-L112))**: Since $\|w(0)\|_{L^2}^2 = 0$, Grönwall's inequality implies $w(t) = 0$ for all $t \ge 0$, and `constant_pressure_of_velocity_eq` ([`Comparison.lean:47-83`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/BalancedTransport/Comparison.lean#L47-L83)) recovers $\nabla p = 0$.

---

## 4. Core Mathematical Mechanism 3: 2+1D Triangular Passive-Scalar Decoupling (`VelocityDetection`)

In [`NavierStokesVelocity.lean`](../proofs/oai_ref/lean/ComparatorChallenges/NavierStokesVelocity.lean#L1-L1275) ([`VelocityDetection/MildScalar.lean`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/VelocityDetection/MildScalar.lean#L1-L120) and [`PeriodicMild.lean`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/VelocityDetection/PeriodicMild.lean#L1-L120)), the 3D velocity field has the $x_3$-independent $2+1\text{D}$ triangular form:

$$u(t, x_1, x_2, x_3) = \big(a_1(t, x_1, x_2),\, a_2(t, x_1, x_2),\, w(t, x_1, x_2)\big).$$

Because $\partial_3 a_1 = \partial_3 a_2 = \partial_3 w = 0$ ([`Theorem 27`](../proofs/ns376_gronwall_uniqueness_and_repairs.lean#L125-L130)~[`Theorem 29`](../proofs/ns376_gronwall_uniqueness_and_repairs.lean#L151-L155)):
- $\nabla \cdot u = \partial_1 a_1 + \partial_2 a_2 + \partial_3 w = \nabla_h \cdot a = 0$ (vertical velocity $w$ decouples from incompressibility),
- $w \partial_3 a_i = 0$ ($w$ exerts zero back-reaction on the horizontal carrier $a$), and
- $w \partial_3 w = 0$, reducing the vertical momentum equation to the 2D linear passive-scalar advection-diffusion equation:
  $$\partial_t w + (a \cdot \nabla_h) w - \nu \Delta_h w = h(t, x_1, x_2).$$

Activating a non-negative bump source $h \ge 0$ only upon machine halting yields a strictly positive vertical velocity signal $w > 1/2$ via the 2D Gaussian heat-kernel Duhamel integral ([`Theorem 30`](../proofs/ns376_gronwall_uniqueness_and_repairs.lean#L164-L170)~[`Theorem 31`](../proofs/ns376_gronwall_uniqueness_and_repairs.lean#L177-L183)).
