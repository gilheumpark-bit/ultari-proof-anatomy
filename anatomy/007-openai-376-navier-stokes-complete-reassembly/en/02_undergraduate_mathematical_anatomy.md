# 02. Undergraduate Mathematical Anatomy: 4-Stratum Partition of the `1,004` `OAI/` Files and Derivations of the 5 Breakthroughs

## Executive Summary

The `1,004` `OAI/` Lean 4 files (`139,847` lines) in OpenAI `#376` partition cleanly into four strata: (1) `286` files reachable from the 5 `solution_module` targets of the 6 Comparator Challenges (`354` when `RapidForcing/Main` and `PeriodicLattice/Main` are grouped, `66,480` lines), (2) `696` additional files reachable from the unimported master hub [`ForcedComputation/Main.lean`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/ForcedComputation/Main.lean#L1-L33) (`770` total reachable from `ForcedComputation/Main.lean`), (3) `19` files in `Material/` (`7,851` lines) proving Picard-Lindelöf unit-slab trajectory stitching, and (4) `3` files (`639` lines) belonging to the stationary axisymmetric swirl-free Navier-Stokes nonuniqueness paper. Below we present the mathematical derivations of the five quantitative breakthroughs extracted from these unimported modules and the October 6, 2026 revision.

---

## 1. Exact 4-Stratum Partition of All `1,004` `OAI/` Files

| Stratum | Root Entrypoint(s) | Unique Files (Disjoint Addition) | Lines of Code | Core Mathematical Content |
| :--- | :--- | :--- | :--- | :--- |
| **Stratum 1** | 5 `solution_module` roots in `ComparatorChallenges/*.json` (+ `RapidForcing/Main`, `PeriodicLattice/Main`) | `286` (`354`) | `66,480` | The 6 official Comparator Challenge solutions (`sheet_theorem`, `alternating`, `VelocityDetection.main_result`, `balanced_box_routing`, `balanced_three_stack_realization`) |
| **Stratum 2** | [`OAI/MathematicalPhysics/NavierStokes/ForcedComputation/Main.lean`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/ForcedComputation/Main.lean#L1-L33) | `770` (`+696` beyond 286 / `+628` beyond 354) | `64,877` | Master hub importing 30 sub-main modules across all 9 papers: non-zero pressure solenoidal force (`Solenoidal.lean`), 4-shear reciprocal scaling (`ShearFlows/Main.lean`), fixed-particle detector (`FixedParticleMain.lean`), unconditional halting undecidability (`VelocityUnconditional.lean`) |
| **Stratum 3** | `OAI/MathematicalPhysics/NavierStokes/Material/Main.lean` | `19` (`+19`) | `7,851` | Picard-Lindelöf unit-slab ODE trajectory stitching (`exists_globalMaterialFlow`) and base-$b$ even-digit Cantor encoding (`Encoding.lean`) |
| **Stratum 4** | [`HomogeneousDatum.lean`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/HomogeneousDatum.lean#L1-L65), [`FiniteRankGap.lean`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/FiniteRankGap.lean#L1-L60), [`StationaryContraction.lean`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/StationaryContraction.lean#L1-L72) | `3` (`+3`) | `639` | Degree $-1$ axisymmetric swirl-free dipole datum and Banach contraction budgets from *Stationary instability and nonuniqueness for axisymmetric swirl-free Navier-Stokes* |
| **Total** | Full `OAI/` Archive (`0 sorry`, `0 axiom`) | **`1,004` files** (`718` / `650` unimported) | **`139,847` lines** | 100% of files accounted for ([`thm_01_oai_corpus_four_strata_partition`](../proofs/ns376_unimported_solenoidal_and_leray_bounds.lean#L14-L28), [`thm_02_unimported_650_and_line_accounting`](../proofs/ns376_unimported_solenoidal_and_leray_bounds.lean#L30-L46), [`thm_03_challenge_duplication_and_30_submains`](../proofs/ns376_unimported_solenoidal_and_leray_bounds.lean#L48-L60)) |

---

## 2. Breakthrough #1: Non-Zero Pressure Solenoidal Force ($\operatorname{div} f_{\text{sol}} = 0$) and `4.53e7x` Tightening of the Screened Green's Operator

### 2.1 Two-Mode Velocity Ansatz and Exact Pressure Poisson Solution (`PeriodicLattice/Solenoidal.lean`)

On $\mathbb{T}^3 = (\mathbb{R}/\mathbb{Z})^3$, setting
$$\eta(z) = -\frac{\sin(2\pi z)}{2\pi}, \qquad \text{slope}(z) = \eta'(z) = -\cos(2\pi z), \qquad \text{doubleSlope}(z) = 2\text{slope}(z)^2 - 1 = \cos(4\pi z)$$
yields the exact identities ([`Solenoidal.lean:41-56`](../proofs/oai_ref/lean/OAI/Analysis/PeriodicLattice/Solenoidal.lean#L41-L56)):
$$\text{slope}(z)^2 + (2\pi)^2 \eta(z)^2 = 1, \qquad \text{doubleSlope}''(z) = -(4\pi)^2 \text{doubleSlope}(z).$$

For the divergence-free velocity field $u(t,x,y,z) = \big(\text{slope}(z)\,a(t,y),\; \text{slope}(z)\,b(t,y),\; -\eta(z)\,\partial_y b(t,y)\big)$, the divergence of the raw residual $g = \partial_t u - \nu \Delta u + (u\cdot\nabla)u$ decomposes into two vertical harmonics ($k_z = 0$ and $k_z = 2$, [`thm_04_solenoidal_convective_divergence_two_mode_split`](../proofs/ns376_unimported_solenoidal_and_leray_bounds.lean#L62-L72)):
$$\operatorname{div} g(t,y,z) = \partial_y^2 \underbrace{\left(\frac{1}{2}\big(b(t,y)^2 - \overline{b^2}(t)\big)\right)}_{\text{pressureBase}(t,y)} + \text{doubleSlope}(z)\,\underbrace{\big((\partial_y b)^2 - b\,\partial_y^2 b\big)}_{\text{pressureSource}(t,y)}.$$
Applying the 1D screened inverse operator $\mathcal{S}_{4\pi} = (\partial_y^2 - (4\pi)^2)^{-1}$ to define $\text{pressureMode} := \mathcal{S}_{4\pi}(\text{pressureSource})$ and setting $\phi = \text{pressureBase} + \text{doubleSlope}(z)\,\text{pressureMode}$ gives $\Delta \phi = \operatorname{div} g$ identically ([`thm_05_solenoidal_nonzero_pressure_poisson_cancellation`](../proofs/ns376_unimported_solenoidal_and_leray_bounds.lean#L74-L83)). Thus $p := -\phi \neq 0$ and $f_{\text{sol}} := g - \nabla \phi$ satisfy $\operatorname{div} f_{\text{sol}} = 0$ and the full incompressible Navier-Stokes equations ([`Solenoidal.lean:315-366`](../proofs/oai_ref/lean/OAI/Analysis/PeriodicLattice/Solenoidal.lean#L315-L366)).

### 2.2 Recalculating `PeriodicInverse.lean`: From $286,753.3$ to $\frac{1}{16\pi^2} \approx 0.006333$ (`45,282,268x` Tightening)

In [`PeriodicInverse.lean:183,328,340`](../proofs/oai_ref/lean/OAI/Analysis/PeriodicLattice/PeriodicInverse.lean#L183-L345), OpenAI defines $\mathcal{S}_\lambda H = \mathcal{I}_{-\lambda}(\mathcal{I}_\lambda H)$ via $(\mathcal{I}_\lambda H)(t,y) = (1 - e^\lambda)^{-1} \int_0^1 e^{\lambda s} H(t, y-s)\,ds$ ([`thm_06_periodic_inverse_screened_helmholtz_factorization`](../proofs/ns376_unimported_solenoidal_and_leray_bounds.lean#L85-L95)), and bounds $e^{\lambda s} \le e^{|\lambda|}$ pointwise on $[0,1]$. At $\lambda = 4\pi$, this multiplies the bound of $\mathcal{I}_{-4\pi}$ by a spurious factor $e^{|-4\pi|} = e^{4\pi} \approx 286,751.31$ even though $e^{-4\pi s} \le 1$ on $[0,1]$, producing the factor $K_{\text{OpenAI}}(4\pi) = \frac{e^{12\pi}}{(e^{4\pi}-1)^2} \approx 286,753.3131$.

Integrating the positive kernel $e^{\pm \lambda s} > 0$ directly on $[0,1]$ yields
$$\|\mathcal{I}_{\pm \lambda}\|_{L^\infty \to L^\infty} = |1 - e^{\pm \lambda}|^{-1} \int_0^1 e^{\pm \lambda s}\,ds = \frac{|e^{\pm \lambda} - 1|}{|\lambda|\cdot |1 - e^{\pm \lambda}|} = \frac{1}{|\lambda|},$$
so the exact operator norm of $\mathcal{S}_{4\pi}$ is $\|\mathcal{S}_{4\pi}\|_{L^\infty \to L^\infty} = \frac{1}{16\pi^2} \approx 0.006332574$, which is **$16\pi^2 \frac{e^{12\pi}}{(e^{4\pi}-1)^2} \approx \mathbf{45,282,268.18}$ times tighter** than OpenAI's bound ([`thm_07`–`thm_10`](../proofs/ns376_unimported_solenoidal_and_leray_bounds.lean#L97-L162)).

---

## 3. Breakthrough #2: Tightening the October 6, 2026 3D Torus Leray Constant `52` to $Z_3(2) \approx 16.5321$ (`3.145x`)

In [`oct06/build/analysis.tex:187,219-223`](../proofs/oai_ref/tex/Incompressible-Box-Transport-and-Finite-Computation-October-6-2026/build/analysis.tex#L187-L223), OpenAI bounds $\sum_{k \in \mathbb{Z}^3 \setminus \{0\}} |k|_2^{-4} \le \sum_{n=1}^\infty (24n^2+2)n^{-4} \le 26 \times 2 = \mathbf{52}$ ([`thm_11`–`thm_17`](../proofs/ns376_unimported_solenoidal_and_leray_bounds.lean#L164-L250)).
1. **Rational $L^\infty$-shell tightening ([`thm_12_leray_projection_linfty_rational_tightening`](../proofs/ns376_unimported_solenoidal_and_leray_bounds.lean#L178-L188))**: Keeping $24n^2+2$ with $\sum n^{-2} \le \frac{7}{4}$ and $\sum n^{-4} \le \frac{4}{3}$ gives $\frac{134}{3} = 44.\overline{6} < 52$.
2. **Exact $L^\infty$-shell zeta sum ([`thm_13_exact_linfty_shell_zeta_enclosure`](../proofs/ns376_unimported_solenoidal_and_leray_bounds.lean#L190-L202))**: $24\zeta(2) + 2\zeta(4) = 4\pi^2 + \frac{\pi^4}{45} \approx 41.643064$.
3. **5-Stratum Euclidean Cubic-Shell Decomposition ([`thm_14_cubic_shell_five_strata_partition`](../proofs/ns376_unimported_solenoidal_and_leray_bounds.lean#L204-L214), [`thm_15_unit_shell_euclidean_vs_linfty_saving`](../proofs/ns376_unimported_solenoidal_and_leray_bounds.lean#L216-L229), [`thm_17_epstein_zeta_z3_vs_openai_52`](../proofs/ns376_unimported_solenoidal_and_leray_bounds.lean#L240-L250))**: Partitioning $S_n = \{|k|_\infty = n\}$ into `6` face centers ($|k|_2^2 = n^2$), `12` edge centers ($2n^2$), `8` corners ($3n^2$), `24(n-1)` edge interiors ($2n^2+m^2$), and `24n(n-1)` face interiors ($n^2+j^2+m^2$) reduces the $n=1$ shell alone from $26$ to $\frac{89}{9} \approx 9.8889$ (saving $\frac{145}{9} \approx 16.1111$) and yields the 3D Epstein zeta constant $Z_3(2) = \sum_{k \neq 0} |k|_2^{-4} \approx \mathbf{16.532149} < 17 < 52$ (**`3.145x` smaller**).

---

## 4. Breakthroughs #3, #4, and #5: 4-Shear Excursion, Velocity Detector Scales (`157.5x` / `7,560x`), and Cantor Gap ($b\times$)

- **Breakthrough #3 ([`ShearFlows/Affine.lean:40,67`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/ShearFlows/Affine.lean#L40-L82), [`thm_18`–`thm_24`](../proofs/ns376_unimported_solenoidal_and_leray_bounds.lean#L252-L344))**: Because $s$ and $s/\lambda$ ($\lambda > 0$) share the same sign in $[-h,h]$, $|(\lambda^{-1}-1)s| \le (1 - \min(\lambda, \lambda^{-1}))h < h$, tightening the intermediate $x$-excursion at stages $k=2,3$ from $2h$ to $(2 - \min(\lambda, \lambda^{-1}))h < 2h$.
- **Breakthrough #4 ([`VelocityDetectorScales.lean:23,64,78`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/ForcedComputation/Detector/VelocityDetectorScales.lean#L23-L92) & [`DetectorMargins.lean:22`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/ForcedComputation/Detector/DetectorMargins.lean#L17-L27), [`thm_25`–`thm_32`](../proofs/ns376_detector_margins_and_undecidability_chains.lean#L17-L114))**: Under `hL : 0 < L` ($L \ge 1$ in `compact_detector_unconditional`), $q_L = (2\cdot 4^L)^{-2} \le \frac{1}{64}$, so $\text{massBound}(L) \le \frac{1}{15,750,000,000,000}$ (**`157.5x` smaller** than $10^{-11}$) and diffusion loss $\frac{2D}{100(1+D)} < \frac{1}{50}$ (**`3.125x` smaller** than $\frac{1}{16}$), expanding the admissible detector amplification threshold from $H \le 10^9$ to **$H \le 7,559,999,999,984$ (`7,560x` larger)**.
- **Breakthrough #5 ([`Material/Encoding.lean:12,37`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/Material/Encoding.lean#L12-L58), [`thm_41`–`thm_42`](../proofs/ns376_detector_margins_and_undecidability_chains.lean#L219-L245))**: Because `AllowedDigits b ds` restricts digits to even integers ($d' \ge d + 2$), the actual cylinder separation is $\frac{d+2}{b} - \frac{d + (b-2)/(b-1)}{b} = \frac{1}{b-1}$, which is **$b$ times larger** than the single-slot gap $\frac{1}{b(b-1)}$.
