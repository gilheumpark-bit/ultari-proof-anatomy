# Expert Verification: Artifact Hashes, Reproduction Commands, and 45-Theorem Map

## 1. Reproduction Commands

```bash
# 1. Standalone Lean 4 Kernel Check (0 sorry, 45 theorems + 11 defs + 1 structure ZSqrt921 across 3 files)
lean proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean && \
  lean proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean && \
  lean proofs/qrh_trilogy_induction_and_algebraic_bridge.lean

# 2. Deterministic Symbolic (SymPy) Verification
python3 proofs/verify_symbolic_qrh_synthesis.py

# 3. Full Proof Anatomy Verification Gate (SHA-256 + 344/344 Mutation Tests + Line Links)
python3 ../../tools/verify_all.py --root .
```

## 2. Artifact SHA-256 Checksum Table

| Artifact File | SHA-256 Checksum |
| :--- | :--- |
| [proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean) | `db8865fae7d724f17f28f803d4df09157767e3068eca7c64b0e70dfaae41a029` |
| [proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean) | `797b362b7cbf5a8d2822cee3c851037e6db47d5347fb755662d56c0457248c0d` |
| [proofs/qrh_trilogy_induction_and_algebraic_bridge.lean](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean) | `95ff96ccc3e90f422a01d8d1be868e9c31d1ab9411c22b24a30661a839987a23` |
| [proofs/verify_symbolic_qrh_synthesis.py](../proofs/verify_symbolic_qrh_synthesis.py) | `3a6c4de3c1f80944ee1da12fc260b742ac73661136dd7a4c076f4c268747b863` |
| [proofs/symbolic_verification_result.json](../proofs/symbolic_verification_result.json) | `d57f4eb4f15a3fb9a9734f4a81dc52416cdb188e71e39d0cf8120b67d83de9c4` |
| [proofs/problem_spec.md](../proofs/problem_spec.md) | `610816b4cdb431bd97d8368e2d4e55753b5f828dedf0357292c2a61915ae7fc4` |

## 3. Complete 1-to-1 Theorem Map (45 Theorems + 11 `def`s + 1 `structure`, 344/344 Mutations Caught)

Note: Upstream paths outside `proofs/oai_ref/` refer to `openai/math` (commit `4eaee87` / `PR #70` `ca28f20`). Proved main theorem `SevenEighths.lean` (`7/8`, `0 sorry`) already logically implies both `11/12` and `23/24`, and `DescentScale.lean` exists in-repo.

### File 1: [proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean) (15 theorems + 2 `def`s: `canonicalReserveScale`, `shortCubeLossScale`)
- Theorem 1: [thm_01_shortdraft_fixed_reserve_and_23_24_exponent](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L25-L38) - Module-stratigraphy finding: hardcoded 1/20 < σ and σ = 1/10 (H = Z^(11/10), Y = Z^(11/60)) lock standalone `ShortDraft` at 137/120 - 11/60 = 23/24 (while `SevenEighths.lean` already implies 11/12 and 23/24).
- Theorem 2: [thm_02_symbolic_sixth_power_cauchy_schwarz_exponent](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L44-L55) - Symbolic sixth-power Cauchy-Schwarz exponent `E_CS(θ) = (11 + 5θ)/12`.
- Theorem 3: [thm_03_kontorovich_epsilon_split_exact_11_12](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L60-L70) - Exact (θ, η) = (6ε/5, ε/2) substitution for target margin ε > 0 yielding (11 + 5θ)/12 + η = 11/12 + ε.
- Theorem 4: [thm_04_canonical_descent_scale_budget_unlocks_arbitrary_theta](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L76-L92) - Symbolic `CanonicalDescentScale` budget `50 ≤ κ * denom_sym` (`DescentScale.lean` in-repo) unlocking arbitrary θ > 0.
- Theorem 5: [thm_05_remainder_exponent_subdominance_and_crossover](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L98-L110) - Subdominance of the Poisson/divisibility remainder `E_rem(θ) = (5 - θ)/6` with gap (1 + 7θ)/12 > 0.
- Theorem 6: [thm_06_sixth_power_fiber_cauchy_constant_768](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L116-L126) - Sixth-power fiber degree 6 times disk constant 128 (`768 = 6 * 128` vs. `384 = 3 * 128`).
- Theorem 7: [thm_07_totient_euler_correction_vs_prime_amplification_tradeoff](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L132-L142) - Local totient density `(N_p - 1)/N_p ∈ [1/2, 1)` and Re(s) > 0 Euler correction convergence.
- Theorem 8: [thm_08_part_one_paper_tex_table_vs_shortdraft_gap](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L148-L161) - Unformalized `paper.tex` Part I margin table (1021/25000, 1/40, 1/1200, 43/300) vs. `ShortDraft` 1/24 gap.
- Theorem 9: [thm_09_cubic_gauss_sieve_step_and_threshold_identities](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L173-L185) - Exact rational identities of `sieveThreshold(α)` and `sieveStep(α)` in `CubicGauss/Recurrence.lean`.
- Theorem 10: [thm_10_cubic_gauss_quadratic_slack_and_attracting_fixed_point](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L190-L209) - Quadratic slack 2(3p - 4q)^2 / (9q(3p - q)) > 0 and unique fixed point `α* = 4/3`.
- Theorem 11: [thm_11_mobius_conjugacy_exact_closed_form_solution](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L214-L232) - Exact Möbius conjugacy `u(sieveStep(α)) = (2/3) * u(α)` for u(α) = (α - 4/3)/(α - 1).
- Theorem 12: [thm_12_nonlinear_vs_linearized_sieve_iterates_comparison](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L237-L254) - Exact comparison of nonlinear iterates (2, 8/5, 28/19, 92/65) vs. `CubicGauss/LargeSieve.lean:75` geometric-series majorization (2, 16/9, 44/27, 124/81), a valid simplification converging to the same asymptotic fixed point `α* = 4/3`.
- Theorem 13: [thm_13_short_four_thirds_and_reciprocity_symmetrization](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L260-L272) - `short_four_thirds` and cubic-reciprocity symmetrization to max(a, b, 2(a+b)/3).
- Theorem 14: [thm_14_scalar_bounds_epsilon_and_mixed_exponents](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L278-L290) - Monomial exponent laws (`mixed_one`, `mixed_two`, `scale_epsilon`) in `CubicGauss/ScalarBounds.lean`.
- Theorem 15: [thm_15_unimported_cubic_gauss_vs_bundled_cubic_gram_gap](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L297-L311) - Unimported 30-file `CubicGauss` (6,252 lines, 0 external imports) vs. bundled `CubicGram`.

### File 2: [proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean) (15 theorems + 2 `def`s: `criticalQuadraticConst`, `farkasWeightedSaving`)
- Theorem 16: [thm_16_shared_critical_quadratic_288_588_185_and_count_2_3](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L24-L42) - Shared critical quadratic `288δ_c^2 - 588δ_c + 185 = 0` (`δ_c = (49 - √921)/48`, `R(δ_c, 1/2) = 2/3`).
- Theorem 17: [thm_17_case005_fixed_scale_saddle_vs_liu_rational_B_r](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L49-L61) - Strict ordering `B_r = 34999/40000 < β_SOS(0) = (6843 - 7√921)/7578 < 41999/48000 < 7/8`.
- Theorem 18: [thm_18_liu_three_face_equalization_in_Q_sqrt_921](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L67-L78) - 3-face scalar equalization in ℚ(√921) (`arXiv:2610.12234`, unrefereed preprint) yielding `ℓ_Liu = (33 + 8√921)/1653` and `B_Liu = (1507 - 2√921)/1653`.
- Theorem 19: [thm_19_exact_gap_between_fixed_scale_saddle_and_liu_optimum](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L85-L97) - Exact gap `β_SOS(0) - B_Liu = (1195√921 - 36189)/4175478 > 0` (`1195^2 * 921 - 36189^2 = 5567304`).
- Theorem 20: [thm_20_liu_gram_gate_parameter_b_new_and_margins](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L103-L118) - Positivity of `0 < b_new < 1/8` and bundled Gram gate y - ℓ - 11b/6 > 0.
- Theorem 21: [thm_21_farkas_dual_weights_and_closure_obstruction](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L124-L139) - Universal (M, ℓ)-cancellation of Farkas weights (`arXiv:2610.12234`, unrefereed preprint) and rationalization `(203 - 3√921)/(219 - 3√921) = B_Liu`.
- Theorem 22: [thm_22_signal_matching_identity_and_face_K_origin](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L145-L156) - Signal-matching identity (11/12 - ℓ/4) - (4 + b)/6 = x/2 + b/12 and origin of `Face_K`.
- Theorem 23: [thm_23_complete_square_uniqueness_at_dc_and_u_half](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L162-L174) - Positivity of `A_c(v)` and disc(v) coefficients proving uniqueness at `(d, u) = (δ_c, 1/2)`.
- Theorem 24: [thm_24_parametric_unbundled_farkas_shift_theorem](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L187-L211) - Parametric Farkas shift theorem `B*(Δ_0, Δ_K, Δ_H) = B_Liu - (w_0 Δ_0 + w_K Δ_K + w_H Δ_H)`.
- Theorem 25: [thm_25_xu_sang_delta0_sixth_moment_breaks_liu_obstruction](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L216-L228) - `w_0 > 2/3` and Xu–Sang (`arXiv:2610.15291`, unrefereed preprint) δ = 0 sixth-moment saving shifting `B_Liu` (`arXiv:2610.12234`, unrefereed preprint) to 8748867/10000000.
- Theorem 26: [thm_26_unbundled_gram_and_stickelberger_shift_breaks_face_H](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L234-L246) - Unbundled Gram + Stickelberger `z_high' = 7/20` LP exponent targets 4103/4896 and 4069/4896.
- Theorem 27: [thm_27_connecting_cubic_gauss_2_3_sieve_to_path_A_71_108](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L252-L264) - Conditional LP/algebraic exponent synthesis connecting `CubicGauss`'s sharp 2/3 large sieve (`R_eff = 7/9`) to Path-A target 71/108 (contingent on constructing the full analytic proof of Stickelberger pole cancellation and Voronoi-Mellin transfer).
- Theorem 28: [thm_28_ten_tier_qrh_boundary_hierarchy](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L268-L284) - Complete 10-tier strict ordering from 1/2 to 23/24.
- Theorem 29: [thm_29_zero_free_strip_width_progression_ratios](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L290-L302) - Zero-free strip width progression (1x → 2x → 3x → 3.89x → 4.05x → 8.22x → 12x).
- Theorem 30: [thm_30_master_qrh_ecosystem_synthesis_verdict](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L308-L321) - Master synthesis verdict across all 4 pillars.

### File 3: [proofs/qrh_trilogy_induction_and_algebraic_bridge.lean](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean) (15 theorems + 7 `def`s + 1 `structure` `ZSqrt921`)
- Theorem 31: [thm_31_sieve_iter_mobius_invariants_by_induction](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L36-L69) - All-n mathematical induction (`induction n`) proving `mobiusNum (sieveIter n) = 2^(n+1)` and `mobiusDen (sieveIter n) = 3^n`.
- Theorem 32: [thm_32_sieve_iter_exact_closed_form_all_n](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L73-L86) - Exact closed-form solution `p_n = 4*3^n - 2^(n+1)` and `q_n = 3*3^n - 2^(n+1)` for all n : Nat.
- Theorem 33: [thm_33_sieve_iter_strictly_beats_openai_sieve_exponent_all_n](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L92-L107) - Universal denominator gap `9*3^n - 3*q_n = 3*2^(n+1)` for all n : Nat.
- Theorem 34: [thm_34_zsqrt921_norm_and_critical_quadratic_root](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L130-L138) - ℤ[√921] ring evaluation of `48δ_c = ⟨49, -1⟩` proving `288*(48δ_c)^2 - 588*48*(48δ_c) + 185*48^2 = ⟨0, 0⟩`.
- Theorem 35: [thm_35_zsqrt921_liu_rationalization_and_case005_gap](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L144-L157) - ℤ[√921] rationalization of `B_Liu` and exact norm `z921Norm ⟨-36189, 1195⟩ = -5567304 < 0`.
- Theorem 36: [thm_36_trilogy_denominator_bridge_3264_and_4896](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L167-L178) - Prime 17 slope bridge (`17 * 96 = 1632 = gcd(3264, 4896)`, Part I denominator = 2 * 1632 = 3264, Part II denominator = 3 * 1632 = 4896).
- Theorem 37: [thm_37_case001_margin_215_3264_drives_case005_4069_4896](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L185-L205) - Exact numerator 215 identity: `7/8 - 4069/4896 = 215/4896 = (2/3) * (215/3264)`.
- Theorem 38: [thm_38_case001_unbundling_breaks_case008_farkas_wall](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L212-L225) - Unbundled Gram saving 18/288 = 1/16 moving past Liu's ℚ(√921) Farkas wall.
- Theorem 39: [thm_39_eisenstein_pole_duality_cubic_gauss_vs_coordR](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L232-L243) - Exact Eisenstein pole duality `α* + β_pole = 4/3 + 2/3 = 2` and `β_pole - 71/108 = 1/108`.
- Theorem 40: [thm_40_cubic_gauss_plus_stickelberger_crosses_two_thirds](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L249-L258) - Conditional algebraic pole-cancellation check (`k_∞ = -6`, `net_pole_order = 1 - 1 = 0`) crossing β = 2/3 (actual attainment of `71/108` remains contingent on constructing the full analytic Stickelberger pole-cancellation and Voronoi-Mellin transfer proof).
- Theorem 41: [thm_41_case001_gauss_branch_vanishing_drives_case005_pole_shift](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L264-L278) - Part I's 6-of-8 Gauss branch vanishing (1/6 → 1/12) matching Part II's algebraic pole-coordinate shift (2/3 → 7/12 → 1/2).
- Theorem 42: [thm_42_gap_between_71_108_and_7_12_equals_3264_over_44064](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L284-L293) - Exact identity `(71/108 - 7/12) * 44064 = 3264` (Part I denominator).
- Theorem 43: [thm_43_eleven_twelfths_to_seven_eighths_bridge](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L299-L309) - Decomposition 14/24 + 8/24 = 11/12 vs. 14/24 + 7/24 = 7/8.
- Theorem 44: [thm_44_six_stage_trilogy_telescoping_decomposition](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L316-L331) - 6-stage telescoping decomposition `1836 + 1836 + 1935 + 7653 + 3264 + 3672 = 20196 = (23/24 - 1/2) * 44064`.
- Theorem 45: [thm_45_grand_trilogy_synthesis_verdict](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L338-L354) - Grand Trilogy Synthesis Verdict across Part I + Part II + Part III.
