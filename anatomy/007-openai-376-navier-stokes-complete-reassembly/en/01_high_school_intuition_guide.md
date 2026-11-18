# Tier 1: Beginner Guide: Reassembling the 650 Unimported Modules of OpenAI #376

## 1. Core Summary

In an audit restricted to the 6 official Comparator Challenges of OpenAI #376, those challenge targets imported only 354 of the 1,004 OAI Lean 4 files, leaving 650 files (718 strictly unimported, 73,367 lines) disconnected. In this 650-module reassembly study (referencing upstream openai/math commit 4eaee87 for files outside the local reference subset, alongside companion bibliography PR 76 on oai-math-revised), we reconnect all 1,004 files alongside the October 6, 2026 revision. Module partitions, algebraic identities, rational bounds, and conditional ratio inequalities are verified across 48 standalone Lean 4 theorems (0 sorry, 150/150 hypothesis mutations caught). Transcendental evaluations (Epstein zeta $Z_3(2) \approx 16.532316$, $e^{4\pi}$, and $\pi$ brackets) and symbolic calculus ($1/\lambda$ Green kernel integration) are evaluated externally in Python (verify_symbolic_ns376_complete.py) and supplied to Lean 4 theorems thm_17, thm_09, and thm_13 as explicit hypotheses.

## 2. Why Were 650 (718) Modules Left Unimported?

Think of the OpenAI #376 archive (1,004 files, 139,847 lines) as a full aircraft factory, and the 6 Comparator Challenges as its public showroom:

1. The 5 unique entrypoints in the showroom only pull in 286 files (354 when counting two auxiliary sub-roots), covering direct zero-pressure constructions on $\mathbb{R}^3$ and shear sheets.
2. The remaining 650 files (718 strictly unimported files) sit inside the factory assembly hubs ([ForcedComputation/Main.lean](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/ForcedComputation/Main.lean#L1-L33) and [Material/MaterialFlow.lean](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/Material/MaterialFlow.lean#L81-L115)).
3. OpenAI's scope note (lean/docs/376.md:12,14,26 at openai/math commit 4eaee87) explains why the two halves are separated: zero pressure ($p \equiv 0$) is used for compactly supported $\mathbb{R}^3$ flows and direct shear sheets because, as [analysis.tex:263-267](../proofs/oai_ref/tex/Incompressible-Box-Transport-and-Finite-Computation-October-6-2026/build/analysis.tex#L263-L267) notes, Poisson projection changes the pressure to $p = -\phi$ and supplies no compact-support conclusion on Euclidean space. Likewise, docs/376.md:14 places the fixed-particle halting detector and solid-box reciprocal maps outside the selected sheet-program statement.
4. When we inspect the unimported modules [ShearFlows/Main.lean](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/ShearFlows/Main.lean#L92-L120) and [FixedParticleMain.lean](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/ForcedComputation/Programs/FixedParticleMain.lean#L29-L53), both theorems are proved in full with zero gaps, and reconnecting the 650 modules restores the periodic $\mathbb{T}_L^3$ solenoidal half of the repository.

The four disjoint strata account for 100% of the 1,004 Lean 4 modules (139,847 lines) with zero sorry placeholders:

- Stratum 1 (6 Official Challenge Entrypoints, 286 or 354 files): Public showroom targets with $p \equiv 0$ ending at step-simulation equivalences.
- Stratum 2 (Unimported Master Hub [ForcedComputation/Main.lean](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/ForcedComputation/Main.lean#L1-L33), +696 disjoint files, 770 total): Non-zero pressure $p = -\phi \neq 0$, 4-shear reciprocal maps, fixed-particle halting, and unconditional halting undecidability.
- Stratum 3 (Unimported Material ODE Stitching [Material/MaterialFlow.lean](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/Material/MaterialFlow.lean#L81-L115) and [Material/Encoding.lean](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/Material/Encoding.lean#L12-L58), 19 disjoint files): Picard-Lindelöf unit-slab trajectory stitching and base-$b$ even-digit Cantor encoding.
- Stratum 4 (Stationary Axisymmetric NS Modules [StationaryContraction.lean](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/StationaryContraction.lean#L1-L72), 3 files): Degree $-1$ homogeneous dipole datum, finite-rank moment coercivity, and Banach contraction budgets.

Every unimported module fits into this four-layer dependency map without gaps or circular dependencies.

## 3. Three Key Constructions Found Inside the Unimported Modules

1. Genuine Non-Zero Pressure $p = -\phi \neq 0$ ([PeriodicLattice/Solenoidal.lean](../proofs/oai_ref/lean/OAI/Analysis/PeriodicLattice/Solenoidal.lean#L334-L373)):
   - All 6 showroom challenges used zero pressure ($p \equiv 0$).
   - On the periodic torus $\mathbb{T}^3$, PeriodicLattice/Solenoidal.lean solves the Poisson equation $\Delta \phi = \operatorname{div} g$ and sets $p = -\phi \neq 0$, producing a smooth divergence-free external force ($\operatorname{div} f_{\text{sol}} = 0$).
2. Unconditional Halting Undecidability ([VelocityUnconditional.lean](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/ForcedComputation/Detector/VelocityUnconditional.lean#L16-L149)):
   - The unimported modules connect the fluid simulation directly to Mathlib's Nat.Partrec.Code and ComputablePred.halting_problem 0.
   - This proves unconditionally that no algorithm can decide whether the fluid velocity detector exceeds its halting threshold.
3. Finite-Energy 3D Torus $\mathbb{T}_L^3$ Formulation (October 6, 2026 Revision, [analysis.tex:164-267](../proofs/oai_ref/tex/Incompressible-Box-Transport-and-Finite-Computation-October-6-2026/build/analysis.tex#L164-L267)):
   - To obtain finite kinetic energy on a periodic box, Proposition 2.4 (prop:projection-l2) formulates the Helmholtz-Leray projection on $\mathbb{T}_L^3 = (\mathbb{R}/L\mathbb{Z})^3$ with uniform $H^s$ and $C^r$ bounds.

## 4. Five Tightened Bounds and the Lean 4 vs. Python Trust Boundary

By recalculating slack in five bounds from first principles, we establish the following improvements while keeping the Lean 4 vs. Python trust boundary explicit:

1. Screened Green's Norm ([PeriodicInverse.lean:183,340](../proofs/oai_ref/lean/OAI/Analysis/PeriodicLattice/PeriodicInverse.lean#L183-L345)):
   - OpenAI's pointwise bound yields $\frac{e^{12\pi}}{(e^{4\pi}-1)^2} \approx 286,753.3$.
   - Integrating the positive kernel yields the exact $L^1$ norm $\frac{1}{16\pi^2} \approx 0.006333$ (45,282,268x tighter). In Lean 4, thm_08 proves algebraic $(E-1)$ cancellation and thm_09 proves a compression factor exceeding $4.50 \times 10^7$ given external lower-bound hypotheses for $(4\pi)^2$ and $e^{4\pi}$, while SymPy in Python evaluates the exact integral and float ratio.
2. Three-Dimensional Torus Leray Constant ([analysis.tex:164-224](../proofs/oai_ref/tex/Incompressible-Box-Transport-and-Finite-Computation-October-6-2026/build/analysis.tex#L164-L224), Proposition 2.4, prop:projection-l2):
   - OpenAI's coarse cubic-shell bound gives 52.
   - Lean 4 proves the 5-stratum cubic-shell partition (thm_14), rational $L^\infty$ bound $\frac{134}{3} \lt 52$ (thm_12), $n=1$ Euclidean shell sum $\frac{89}{9}$ vs. 26 (thm_15), and the ratio comparison exceeding $3.14\times$ in thm_17 given the externally supplied scaled constant z3_scaled = 165324. Lean 4 itself does not evaluate the infinite sum $Z_3(2) \approx 16.532316$; Python (verify_symbolic_ns376_complete.py) computes the $N=250$ cubical-shell sum ($16.490619$), Richardson extrapolation ($16.532149$), and analytical tail upper bound ($16.540885 \lt 16.59$, 3.145x tighter than 52).
3. Four-Shear Excursion ([ShearFlows/Affine.lean:40,67](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/ShearFlows/Affine.lean#L40-L82)):
   - OpenAI bounded the correction by $h$ and intermediate excursion by $2h$.
   - Sign preservation of $s$ and $s/\lambda$ tightens the correction to $(1-\min(\lambda,\lambda^{-1}))h \lt h$ and intermediate excursion strictly below $2h$ (thm_20 to thm_22 in Lean 4).
4. Velocity Detector Scales ([VelocityDetectorScales.lean:64,78](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/ForcedComputation/Detector/VelocityDetectorScales.lean#L64-L92) and [DetectorMargins.lean:22](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/ForcedComputation/Detector/DetectorMargins.lean#L17-L27)):
   - OpenAI capped the amplification factor at $H \le 10^9$ by omitting $L \ge 1$ and using diffusion loss $1/16$.
   - Using the actual hypothesis $0 \lt L$ ($L \ge 1$) and exact diffusion supremum $1/50$ expands $H$ to $7,559,999,999,984$ (7,560x larger, proved in Lean 4 thm_26 to thm_30).
5. Even-Digit Cantor Guard Gap ([Material/Encoding.lean:12,37](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/Material/Encoding.lean#L12-L58)):
   - OpenAI used the single-slot bound $\frac{1}{b(b-1)}$.
   - Because allowed digits are restricted to even integers ($d+2$), the actual cylinder separation is $\frac{1}{b-1}$, which is $b$-fold larger for $b \ge 4$ (proved in Lean 4 thm_41 and thm_42).
