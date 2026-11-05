# 04. Computer Science Empirical Verification: `48` Lean 4 Theorems (`129/129` Hypothesis Mutation Kills) and Symbolic/Numerical Verification

## Verification Summary

- **Lean 4 Formal Verification (`v4.29.0-rc8`)**:
  - [`proofs/ns376_unimported_solenoidal_and_leray_bounds.lean`](../proofs/ns376_unimported_solenoidal_and_leray_bounds.lean): `24` theorems (`thm_01`–`thm_24`), exit code `0`, `0` gaps, `0` custom axioms.
  - [`proofs/ns376_detector_margins_and_undecidability_chains.lean`](../proofs/ns376_detector_margins_and_undecidability_chains.lean): `24` theorems (`thm_25`–`thm_48`), exit code `0`, `0` gaps, `0` custom axioms.
- **Hypothesis Mutation Testing**:
  - `66/66` (`100.0%`) hypotheses killed in `ns376_unimported_solenoidal_and_leray_bounds.lean` and `63/63` (`100.0%`) hypotheses killed in `ns376_detector_margins_and_undecidability_chains.lean` (**`129/129` = `100.0%` total mutation kill rate**).
- **Symbolic & Numerical Verification ([`proofs/verify_symbolic_ns376_complete.py`](../proofs/verify_symbolic_ns376_complete.py) $\to$ [`proofs/symbolic_verification_result.json`](../proofs/symbolic_verification_result.json))**:
  - SymPy exact symbolic checks, 3D cubical shell summation up to $N = 250$ ($125,751,500$ non-zero lattice points), `100,000` random 4-shear excursion trials, and exact rational arithmetic checks all passed (`all_checks_passed: true`, exit code `0`).

---

## 1. Complete Table of the `48` Lean 4 Theorems

### 1.1 Part 1: [`proofs/ns376_unimported_solenoidal_and_leray_bounds.lean`](../proofs/ns376_unimported_solenoidal_and_leray_bounds.lean) (`thm_01`–`thm_24`)

| ID | Theorem Name | Mathematical Statement Verified | Reference Source |
| :--- | :--- | :--- | :--- |
| `thm_01` | `thm_01_solenoidal_vertical_energy_and_double_slope` | $\text{slope}(z)^2 + (2\pi)^2\eta(z)^2 = 1$ and $\text{doubleSlope}(z) = 2\text{slope}(z)^2 - 1$ | [`Solenoidal.lean:19,41`](../proofs/oai_ref/lean/OAI/Analysis/PeriodicLattice/Solenoidal.lean#L19-L45) |
| `thm_02` | `thm_02_velocity_ansatz_divergence_free` | $\nabla \cdot u = 0$ when $\eta'(z) = \text{slope}(z)$ | [`Solenoidal.lean:37`](../proofs/oai_ref/lean/OAI/Analysis/PeriodicLattice/Solenoidal.lean#L37-L40) |
| `thm_03` | `thm_03_double_slope_helmholtz_eigenvalue` | $\text{doubleSlope}''(z) = -(4\pi)^2\text{doubleSlope}(z)$ | [`Solenoidal.lean:46`](../proofs/oai_ref/lean/OAI/Analysis/PeriodicLattice/Solenoidal.lean#L46-L56) |
| `thm_04` | `thm_04_convective_divergence_two_mode_decomposition` | $\operatorname{div} g = \partial_y^2(b^2/2) + \text{doubleSlope}(z)((\partial_y b)^2 - b\partial_y^2 b)$ | [`Solenoidal.lean:58,109,133`](../proofs/oai_ref/lean/OAI/Analysis/PeriodicLattice/Solenoidal.lean#L58-L139) |
| `thm_05` | `thm_05_pressure_poisson_two_mode_cancellation` | $(\partial_y^2 - \lambda^2)M = S \implies \Delta \phi = \operatorname{div} g$ | [`Solenoidal.lean:140,165`](../proofs/oai_ref/lean/OAI/Analysis/PeriodicLattice/Solenoidal.lean#L140-L173) |
| `thm_06` | `thm_06_solenoidal_force_exact_navier_stokes_balance` | $\operatorname{div} f_{\text{sol}} = 0$ and momentum balance with $p = -\phi \neq 0$ | [`Solenoidal.lean:334-373`](../proofs/oai_ref/lean/OAI/Analysis/PeriodicLattice/Solenoidal.lean#L334-L373) |
| `thm_07` | `thm_07_periodic_inverse_sign_aware_pointwise_saving` | Dropping spurious $E = e^{4\pi}$ factor on $[0,1]$ when $\lambda > 0$ | [`PeriodicInverse.lean:183`](../proofs/oai_ref/lean/OAI/Analysis/PeriodicLattice/PeriodicInverse.lean#L183-L210) |
| `thm_08` | `thm_08_exact_green_kernel_integral_cancellation` | Exact cancellation of $(E - 1)$ via positive-kernel integration | [`PeriodicInverse.lean:183,328`](../proofs/oai_ref/lean/OAI/Analysis/PeriodicLattice/PeriodicInverse.lean#L183-L342) |
| `thm_09` | `thm_09_screened_green_operator_45million_tightening` | `4.53e7x` tightening of `screened (4*pi)` over OpenAI's bound | [`PeriodicInverse.lean:340`](../proofs/oai_ref/lean/OAI/Analysis/PeriodicLattice/PeriodicInverse.lean#L340-L342) |
| `thm_10` | `thm_10_symmetric_cosh_green_kernel_sum` | Symmetric $\cosh$ Green's kernel decomposition on $[0,1]$ | [`PeriodicInverse.lean:328`](../proofs/oai_ref/lean/OAI/Analysis/PeriodicLattice/PeriodicInverse.lean#L328-L339) |
| `thm_11` | `thm_11_cubic_shell_cardinality_and_slack` | $(2n+1)^3 - (2n-1)^3 = 24n^2 + 2$ and slack $2(n^2-1) \ge 6$ | [`oct06/build/analysis.tex:219`](../proofs/oai_ref/tex/Incompressible-Box-Transport-and-Finite-Computation-October-6-2026/build/analysis.tex#L219-L220) |
| `thm_12` | `thm_12_leray_projection_linfty_rational_tightening` | Rational $L^\infty$-shell bound $\frac{134}{3} < 52$ (saving $\frac{22}{3}$) | [`oct06/build/analysis.tex:187,220`](../proofs/oai_ref/tex/Incompressible-Box-Transport-and-Finite-Computation-October-6-2026/build/analysis.tex#L187-L220) |
| `thm_13` | `thm_13_exact_linfty_shell_zeta_enclosure` | $24\zeta(2) + 2\zeta(4) = 4\pi^2 + \frac{\pi^4}{45} \in (41.64, 41.65) < \frac{134}{3}$ | [`oct06/build/analysis.tex:219`](../proofs/oai_ref/tex/Incompressible-Box-Transport-and-Finite-Computation-October-6-2026/build/analysis.tex#L219-L220) |
| `thm_14` | `thm_14_cubic_shell_five_strata_partition` | 5-stratum partition $6 + 12 + 8 + 24(n-1) + 24n(n-1) = 24n^2+2$ | [`oct06/build/analysis.tex:219`](../proofs/oai_ref/tex/Incompressible-Box-Transport-and-Finite-Computation-October-6-2026/build/analysis.tex#L219) |
| `thm_15` | `thm_15_unit_shell_euclidean_vs_linfty_saving` | $n=1$ shell Euclidean weight $\frac{89}{9}$ vs $26$ (saving $\frac{145}{9}$) | [`oct06/build/analysis.tex:219`](../proofs/oai_ref/tex/Incompressible-Box-Transport-and-Finite-Computation-October-6-2026/build/analysis.tex#L219) |
| `thm_16` | `thm_16_shell_strata_euclidean_weight_reduction` | Stratum-wise Euclidean vs $L^\infty$ weight reduction on $S_n$ | [`oct06/build/analysis.tex:219`](../proofs/oai_ref/tex/Incompressible-Box-Transport-and-Finite-Computation-October-6-2026/build/analysis.tex#L219) |
| `thm_17` | `thm_17_epstein_zeta_z3_vs_openai_52` | 3D Epstein zeta $Z_3(2) \approx 16.532$ vs `52` (**`3.145x` tighter**) | [`oct06/build/analysis.tex:187`](../proofs/oai_ref/tex/Incompressible-Box-Transport-and-Finite-Computation-October-6-2026/build/analysis.tex#L187) |
| `thm_18` | `thm_18_four_shears_reciprocal_diagonal_identity` | 4-shear factorization of $\operatorname{diag}(\lambda, \lambda^{-1})$ | [`ShearFlows/Affine.lean:24`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/ShearFlows/Affine.lean#L24-L28) |
| `thm_19` | `thm_19_partial_shear_determinant_one` | Area preservation ($\det = 1$) of every fractional shear step | [`ShearFlows/Affine.lean:20,30`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/ShearFlows/Affine.lean#L20-L39) |
| `thm_20` | `thm_20_reciprocal_correction_sharpened_sub_unit` | $|(\lambda^{-1}-1)s| \le (1-\lambda)h < h$ for $0 < \lambda < 1$ | [`ShearFlows/Affine.lean:40`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/ShearFlows/Affine.lean#L40-L52) |
| `thm_21` | `thm_21_reciprocal_correction_sharpened_super_unit` | $|(\lambda^{-1}-1)s| \le (1-\lambda^{-1})h < h$ for $\lambda > 1$ | [`ShearFlows/Affine.lean:40`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/ShearFlows/Affine.lean#L40-L52) |
| `thm_22` | `thm_22_scaling_endpoint_x_excursion_sharpened` | Intermediate $x$-excursion $\le (2 - \min(\lambda, \lambda^{-1}))h < 2h$ | [`ShearFlows/Affine.lean:67`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/ShearFlows/Affine.lean#L67-L82) |
| `thm_23` | `thm_23_convex_segment_excursion_bound` | Convex segment interpolation bound along fractional shears | [`ShearFlows/Affine.lean:53`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/ShearFlows/Affine.lean#L53-L66) |
| `thm_24` | `thm_24_solid_tube_3d_shear_extension_invariance` | 3D solid-tube shear extension $z$-invariance and divergence-freeness | [`ShearFlows/Main.lean:55`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/ShearFlows/Main.lean#L55-L66) |

### 1.2 Part 2: [`proofs/ns376_detector_margins_and_undecidability_chains.lean`](../proofs/ns376_detector_margins_and_undecidability_chains.lean) (`thm_25`–`thm_48`)

| ID | Theorem Name | Mathematical Statement Verified | Reference Source |
| :--- | :--- | :--- | :--- |
| `thm_25` | `thm_25_detector_mass_bound_l0_exact_ratio` | $\text{massBound}(0) = \frac{1}{7.5\times 10^{11}}$ ($7.5\times$ smaller than $10^{-11}$) | [`VelocityDetectorScales.lean:23,78`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/ForcedComputation/Detector/VelocityDetectorScales.lean#L23-L92) |
| `thm_26` | `thm_26_detector_mass_bound_l1_157x_tightening` | $\text{massBound}(1) = \frac{1}{15.75\times 10^{12}}$ (**`157.5x` smaller** than $10^{-11}$) | [`VelocityDetectorScales.lean:23`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/ForcedComputation/Detector/VelocityDetectorScales.lean#L23-L25) & [`VelocityUnconditional.lean:107`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/ForcedComputation/Detector/VelocityUnconditional.lean#L107) |
| `thm_27` | `thm_27_detector_mass_bound_monotone_in_L` | Monotonicity $\text{massBound}(L) \le \text{massBound}(1)$ for $L \ge 1$ | [`VelocityDetectorScales.lean:12-25`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/ForcedComputation/Detector/VelocityDetectorScales.lean#L12-L25) |
| `thm_28` | `thm_28_detector_old_mass_margin_sharpened` | Sharpened `detector_old_mass_margin` at $L \ge 1$ | [`DetectorMargins.lean:17`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/ForcedComputation/Detector/DetectorMargins.lean#L17-L20) |
| `thm_29` | `thm_29_diffusion_loss_exact_supremum_one_fiftieth` | Diffusion loss $\frac{2D}{100(1+D)} < \frac{1}{50}$ (**`3.125x` smaller** than $\frac{1}{16}$) | [`VelocityDetectorScales.lean:64`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/ForcedComputation/Detector/VelocityDetectorScales.lean#L64-L72) |
| `thm_30` | `thm_30_detector_wait_margin_7560x_expansion` | Expansion of $H$ to $7,559,999,999,984$ (**`7,560x` larger**) | [`DetectorMargins.lean:22`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/ForcedComputation/Detector/DetectorMargins.lean#L22-L27) |
| `thm_31` | `thm_31_detector_wait_margin_with_oai_loss_term` | Expansion of $H$ to $6,890,624,999,984$ even with loss term $\frac{1}{16}$ | [`DetectorMargins.lean:22`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/ForcedComputation/Detector/DetectorMargins.lean#L22-L27) |
| `thm_32` | `thm_32_heat_wait_duration_exact_lower_bound` | Exact interval $2 - 2\cdot\text{duration} \in [\frac{99}{50}, 2]$ | [`VelocityDetectorScales.lean:74`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/ForcedComputation/Detector/VelocityDetectorScales.lean#L74-L76) |
| `thm_33` | `thm_33_balanced_three_stack_cycle_step_counts` | Exact 3-stack cycle step counts `2|w|+3`, `2(|w|+1)+2`, `2(|w|+2)+2`, `4` | [`BalancedCycle.lean:160-168`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/ForcedComputation/Programs/BalancedCycle.lean#L160-L168) |
| `thm_34` | `thm_34_three_stack_quadratic_cumulative_work` | Quadratic cumulative step sum $N(2w_0 + N + 5)$ over $N$ transitions | [`BalancedCycle.lean:160-168`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/ForcedComputation/Programs/BalancedCycle.lean#L160-L168) |
| `thm_35` | `thm_35_finite_machine_halting_undecidable_chain` | `Partrec.Code` $\leftrightarrow$ universal machine $\leftrightarrow$ fluid particle event | [`FiniteMachineHaltingDischarge.lean:1-90`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/ForcedComputation/Programs/FiniteMachineHaltingDischarge.lean#L1-L25) |
| `thm_36` | `thm_36_rapid_lattice_torus_halting_equivalence_chain` | 4-tier halting equivalence chain to `RapidTorusEvent` | [`RapidMachineHaltingDischarge.lean:1-90`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/ForcedComputation/Programs/RapidMachineHaltingDischarge.lean#L1-L90) |
| `thm_37` | `thm_37_torus_velocity_unconditional_discharge_chain` | Unconditional torus velocity detector discharge chain | [`VelocityUnconditional.lean:60-67`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/ForcedComputation/Detector/VelocityUnconditional.lean#L60-L67) |
| `thm_38` | `thm_38_plane_velocity_unconditional_discharge_chain` | Unconditional whole-plane velocity detector discharge chain | [`VelocityUnconditional.lean:68-97`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/ForcedComputation/Detector/VelocityUnconditional.lean#L68-L97) |
| `thm_39` | `thm_39_rapid_forcing_scale_exponent_and_slack` | $(n+3)^2 - (n+2)^2 = 2n+5$ and super-exponential scale slack | [`RapidForcing/Scales.lean:73-77`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/RapidForcing/Scales.lean#L73-L77) |
| `thm_40` | `thm_40_rapid_forcing_small_motion_exponent_slack` | Exact exponent slack $(30n + 20)s_n \ge 20s_n$ in `small_motion_exponents` | [`RapidForcing/Scales.lean:87,113`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/RapidForcing/Scales.lean#L87-L120) |
| `thm_41` | `thm_41_cantor_encoding_single_slot_guard_gap` | Single-slot Cantor guard gap $\frac{1}{b(b-1)}$ ($b \ge 4$) | [`Material/Encoding.lean:15,37`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/Material/Encoding.lean#L15-L58) |
| `thm_42` | `thm_42_cantor_encoding_even_digit_b_fold_gap` | Even-digit Cantor cylinder separation $\frac{1}{b-1}$ (**$b$-fold larger**) | [`Material/Encoding.lean:12-16`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/Material/Encoding.lean#L12-L16) |
| `thm_43` | `thm_43_picard_lindelof_slab_stitching_window` | Picard-Lindelöf unit-slab trajectory stitching consistency | [`Material/MaterialFlow.lean:85`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/Material/MaterialFlow.lean#L85-L115) |
| `thm_44` | `thm_44_homogeneous_datum_degree_minus_one_scaling` | Degree $-1$ scaling of axisymmetric swirl-free `homogeneousDatum` | [`HomogeneousDatum.lean:38,59`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/HomogeneousDatum.lean#L38-L65) |
| `thm_45` | `thm_45_finite_rank_moment_matrix_coercivity` | `finite_rank_gap` moment-matrix coercivity transfer inequality | [`FiniteRankGap.lean:32`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/FiniteRankGap.lean#L32-L55) |
| `thm_46` | `thm_46_stationary_contraction_lipschitz_exact_margin` | Exact rational `lipschitz_budget` $\frac{219,422,196}{8,410,000,000} < \frac{27}{1000}$ | [`StationaryContraction.lean:43`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/StationaryContraction.lean#L43-L46) |
| `thm_47` | `thm_47_stationary_contraction_target_error_exact_slack` | Exact rational `correction_budget` slack $\frac{1}{72,500,000}$ | [`StationaryContraction.lean:48`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/StationaryContraction.lean#L48-L50) |
| `thm_48` | `thm_48_stationary_coercivity_and_spectral_gap_margins` | Exact rational `coercivity_budget` slack $\frac{5,931}{437,500}$ | [`StationaryContraction.lean:58,68`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/StationaryContraction.lean#L58-L72) |

---

## 2. Reproducibility Commands

```bash
export PATH="$HOME/.elan/bin:$PATH"
lean proofs/ns376_unimported_solenoidal_and_leray_bounds.lean
lean proofs/ns376_detector_margins_and_undecidability_chains.lean
python3 proofs/verify_symbolic_ns376_complete.py
sha256sum -c proofs/checksums.sha256
```
