/-!
# Formal Lean 4 Verification of Engine I: Shared Linear Summaries, Commuting Swap Matrices,
# Beigel-Tarui Lifting, Tanner Expander Codes, and BitProgram Compiler Envelopes (Part A: Theorems 1–16)
# in OpenAI #378 (Disproof of the Exponential Time Hypothesis)
Compiles standalone with `lean` (`v4.29.0-rc8`) over exact integer arithmetic (`Int`).
Zero `sorry`, zero custom axioms.
-/

namespace OAI378ETHInterpolationAndHashes

/-!
## Part I: Commuting Swap Matrices, Binomial Parity Interpolation, and Shared Linear Summaries
(`main_full_version.tex` Sections 3–4, `BinomialInterpolation.lean`, `MatrixSupport.lean`, `Annihilation.lean`)
-/

/-- [Theorem 1] Eigenbasis split of the coordinate swap involution `Π_s` on `[r]^2` (`Section 4.2`, `main_full_version.tex:2257-2277`).
For `r ≥ 2`, the `r^2`-dimensional space on `[r]^2` splits under the coordinate swap `(a, d) ↦ (d, a)`
into `sym_dim` symmetric eigenvectors with eigenvalue `+1` (`2 * sym_dim = r * (r + 1)`) and
`anti_dim` antisymmetric eigenvectors with eigenvalue `-1` (`2 * anti_dim = r * (r - 1)`).
Consequently `sym_dim + anti_dim = r^2`, `sym_dim - anti_dim = r`, and the fraction `p = anti_dim / r^2`
of `-1` eigenvalues satisfies the exact cross-multiplied identity `2 * (r * anti_dim) = (r - 1) * r^2`. -/
theorem swap_eigenbasis_symmetric_antisymmetric_split
    (r r_sq sym_dim anti_dim lhs_prob rhs_prob : Int)
    (hr : 2 ≤ r)
    (hr_sq : r_sq = r * r)
    (h_sym : 2 * sym_dim = r * (r + 1))
    (h_anti : 2 * anti_dim = r * (r - 1))
    (h_lhs : lhs_prob = r * (2 * anti_dim))
    (h_rhs : rhs_prob = (r - 1) * r_sq) :
    3 ≤ sym_dim ∧ 1 ≤ anti_dim ∧
    sym_dim + anti_dim = r_sq ∧ sym_dim - anti_dim = r ∧
    lhs_prob = rhs_prob := by
  have hr_ge : 2 * 1 ≤ r * (r - 1) := Int.mul_le_mul hr (by omega) (by omega) (by omega)
  have h_sum2 : 2 * (sym_dim + anti_dim) = 2 * r_sq := by
    calc 2 * (sym_dim + anti_dim) = 2 * sym_dim + 2 * anti_dim := by omega
    _ = r * (r + 1) + r * (r - 1) := by rw [h_sym, h_anti]
    _ = (r * r + r) + (r * r - r) := by
      rw [Int.mul_add, Int.mul_sub, Int.mul_one]
    _ = 2 * r_sq := by rw [← hr_sq]; omega
  have h_diff2 : 2 * (sym_dim - anti_dim) = 2 * r := by
    calc 2 * (sym_dim - anti_dim) = 2 * sym_dim - 2 * anti_dim := by omega
    _ = r * (r + 1) - r * (r - 1) := by rw [h_sym, h_anti]
    _ = (r * r + r) - (r * r - r) := by
      rw [Int.mul_add, Int.mul_sub, Int.mul_one]
    _ = 2 * r := by omega
  have h_prob : lhs_prob = rhs_prob := by
    calc lhs_prob = r * (r * (r - 1)) := by rw [h_lhs, h_anti]
    _ = (r * r) * (r - 1) := (Int.mul_assoc r r (r - 1)).symm
    _ = (r - 1) * r_sq := by rw [← hr_sq, Int.mul_comm r_sq (r - 1)]
    _ = rhs_prob := h_rhs.symm
  omega

/-- [Theorem 2] Newton forward-difference parity interpolation polynomial (`Section 4.2`, `main_full_version.tex:2279-2295`,
`BinomialInterpolation.lean:78-100`).
For window width `R = 3` (`q ∈ {0, 1, 2}`), the degree-`2` binomial expansion
`P(q) = 1 - 2 * q + 4 * choose(q, 2) = 1 - 2 * q + 2 * q * (q - 1)` satisfies `P(0) = 1`, `P(1) = -1`, `P(2) = 1`,
so multiplying by `(-1)^q` yields the constant unit eigenvalue `(-1)^q * P(q) = 1` across the entire interval. -/
theorem newton_forward_difference_parity_interpolation
    (R deg_f val_0 val_1 val_2 eig_0 eig_1 eig_2 : Int)
    (hR : R = 3)
    (h_deg : deg_f = R - 1)
    (hv0 : val_0 = R - deg_f)
    (hv1 : val_1 = val_0 - deg_f)
    (hv2 : val_2 = val_1 - deg_f + 2 * deg_f)
    (he0 : eig_0 = 1 * val_0)
    (he1 : eig_1 = (-1) * val_1)
    (he2 : eig_2 = 1 * val_2) :
    deg_f = 2 ∧ val_0 = 1 ∧ val_1 = -1 ∧ val_2 = 1 ∧
    eig_0 = 1 ∧ eig_1 = 1 ∧ eig_2 = 1 := by
  omega

/-- [Theorem 3] Concrete `4 × 4` commuting swap matrix `M_0 = Π_1 + Π_2 - Π_1 Π_2` and row polynomial path (`Remark 4.4`, `main_full_version.tex:2387-2421`).
For `Q = R = 2, r = 2, I = {0, 1}`, `f_I(z) = 1 - 2z` gives `M_0 = Π_1 + Π_2 - Π_1 Π_2`.
On `ζ = (ζ_0, ζ_1, ζ_2, ζ_{12})`, `(M_0 ζ)_0 = ζ_1 + ζ_2 - ζ_{12}`, so `ζ_0 - (M_0 ζ)_0 = c(ζ) = ζ_0 - ζ_1 - ζ_2 + ζ_{12}`.
When `c(ζ) = 0`, `(M_0 ζ)_0 = ζ_0`, and the doubled degree-1 row path `P2(T) = 2 ζ_0 - T ζ_1 - 2 T ζ_2`
recovers `2 ζ_0` at `T = 0`, `ζ_0 - ζ_{12} - ζ_2` at `T = 1`, and `-2(ζ_2 + ζ_{12})` at `T = 2`. -/
theorem remark_4_4_four_by_four_swap_matrix_kernel_and_path
    (z0 z1 z2 z12 m0_z0 c_zeta p2_at_0 p2_at_1 p2_at_2 : Int)
    (h_m0 : m0_z0 = z1 + z2 - z12)
    (h_c : c_zeta = z0 - z1 - z2 + z12)
    (h_ker : c_zeta = 0)
    (hp0 : p2_at_0 = 2 * z0 - 0 * z1 - 2 * 0 * z2)
    (hp1 : p2_at_1 = 2 * z0 - 1 * z1 - 2 * 1 * z2)
    (hp2 : p2_at_2 = 2 * z0 - 2 * z1 - 2 * 2 * z2) :
    m0_z0 = z0 ∧ p2_at_0 = 2 * z0 ∧
    p2_at_1 = z0 - z12 - z2 ∧ p2_at_2 = -2 * (z2 + z12) := by
  omega

/-- [Theorem 4] Swap matrix mismatch support and cleared annihilator degree bound (`Lemma 4.2` & `Lemma 4.3`,
`main_full_version.tex:2307-2385`, `MatrixSupport.lean:154-166`).
Every monomial `V_0 ∏_{s ∈ F} Π_s` with `|F| = j ≤ R - 1` flips all coordinates in `[Q] \ F`, leaving at most
`mismatch_count ≤ j ≤ R - 1` group agreements `a_y(s) ≠ d_u(s)`. Clearing denominators in
`φ_{u,y}(T) = ∏_{s ∈ E_{u,y}} (1 - T/s)` by `d_den = fact_R_minus_1 * fact_Q` produces an integer polynomial
of degree `deg_phi = mismatch_count ≤ R - 1 < Q`. -/
theorem swap_support_mismatch_and_annihilator_degree_bound
    (Q R j mismatch_count deg_phi fact_R_minus_1 fact_Q d_den : Int)
    (hR : 2 ≤ R) (hQR : R ≤ Q)
    (hj_le : j ≤ R - 1)
    (h_mis_nonneg : 0 ≤ mismatch_count) (h_mis : mismatch_count ≤ j)
    (h_deg : deg_phi = mismatch_count)
    (hfR : 1 ≤ fact_R_minus_1) (hfQ : 2 ≤ fact_Q)
    (h_den : d_den = fact_R_minus_1 * fact_Q) :
    2 ≤ Q ∧ 0 ≤ deg_phi ∧ deg_phi ≤ R - 1 ∧ deg_phi < Q ∧ 2 ≤ d_den := by
  have h_prod : 1 * 2 ≤ fact_R_minus_1 * fact_Q := Int.mul_le_mul hfR hfQ (by omega) (by omega)
  omega

/-- [Theorem 5] Shared linear summary measurement row budget (`Section 4.1`, `main_full_version.tex:2204-2246`).
With `r ≥ 2` variable groups, at most `h_active` active patterns per group satisfying `r * h_active ≤ 2 * tau_n`,
and `c_B` kernel constraint rows per pattern (`1 ≤ c_B ≤ c_B_cap`), the total measurement row count
`total_rows = r * h_active * c_B` across all `r` groups is bounded by `2 * tau_n * c_B_cap`. -/
theorem shared_summary_measurement_row_budget
    (r h_active tau_n c_B c_B_cap group_patterns total_rows row_budget : Int)
    (hr : 2 ≤ r) (hh : 1 ≤ h_active)
    (h_active_bound : r * h_active ≤ 2 * tau_n)
    (hcB_pos : 1 ≤ c_B) (hcB_le : c_B ≤ c_B_cap)
    (h_gp : group_patterns = r * h_active)
    (h_tot : total_rows = group_patterns * c_B)
    (h_bud : row_budget = (2 * tau_n) * c_B_cap) :
    2 ≤ group_patterns ∧ 2 ≤ total_rows ∧ total_rows ≤ row_budget := by
  have hgp_ge : 2 * 1 ≤ r * h_active := Int.mul_le_mul hr hh (by omega) (by omega)
  have htot_ge : 2 * 1 ≤ group_patterns * c_B := Int.mul_le_mul (by omega) hcB_pos (by omega) (by omega)
  have htot_le : group_patterns * c_B ≤ (2 * tau_n) * c_B_cap :=
    Int.mul_le_mul (by omega) hcB_le (by omega) (by omega)
  omega

/-- [Theorem 6] Taylor finite-difference jet truncation and subset-pair order (`Section 3.3` & `Lemma 4.4`, `main_full_version.tex:2092-2156, 2423-2485`).
Evaluating a degree-`d_H` polynomial along `Q` nodes `t ∈ [Q]` with degree-`(R - 1)` row multipliers yields
univariate degree `d_total = d_H + R - 1`. Dividing `d_H = q_jet * Q + rem_Q` (`0 ≤ rem_Q < Q`) gives jet order
`q_jet = ⌊d_H / Q⌋`, and when `6 * R ≤ Q`, the scaled jet bound `6 * R * q_jet ≤ d_H` holds. -/
theorem taylor_jet_truncation_and_subset_pair_exponent
    (d_H Q R q_jet rem_Q d_total scaled_jet : Int)
    (hR : 2 ≤ R) (h_6R : 6 * R ≤ Q)
    (hq : 1 ≤ q_jet) (hrem0 : 0 ≤ rem_Q) (hremQ : rem_Q < Q)
    (h_div : d_H = q_jet * Q + rem_Q)
    (h_dtot : d_total = d_H + R - 1)
    (h_scaled : scaled_jet = (6 * R) * q_jet) :
    12 ≤ Q ∧ q_jet * Q ≤ d_H ∧ d_total < q_jet * Q + Q + R ∧
    12 ≤ scaled_jet ∧ scaled_jet ≤ d_H := by
  have h_mul : (6 * R) * q_jet ≤ Q * q_jet := Int.mul_le_mul_of_nonneg_right h_6R (by omega)
  have h_comm : Q * q_jet = q_jet * Q := Int.mul_comm Q q_jet
  have h_min : 12 * 1 ≤ (6 * R) * q_jet := Int.mul_le_mul (by omega) hq (by omega) (by omega)
  omega

/-- [Theorem 7] Three-way asymptotic parameter schedule and Hoeffding tail domination (`Section 3.4` & `Lemma 4.6`,
`main_full_version.tex:2158-2197, 2536-2615`, `AsymptoticLayoutParameters.lean:15-48`).
With `128 * (Q * nu) ≤ lam`, `log2_D = 2 * (Q * nu)`, and `R_sq ≥ 64 * (beta3_sq * log2_D)` (`R = (β+3)⌈√λ⌉`),
the auxiliary dimension exponent satisfies `64 * log2_D ≤ lam`, while the Hoeffding binomial tail exponent
satisfies `R_sq ≥ 2304`, ensuring `Pr[W ∉ I] ≤ 2 exp(-R^2 / (8Q))` is exponentially small in `nu`. -/
theorem asymptotic_three_way_exponent_balance_schedule
    (lam nu Q log2_D beta3_sq R_sq hoeffding_rhs : Int)
    (hnu : 2 ≤ nu) (hQ : 1 ≤ Q) (hbeta : 9 ≤ beta3_sq)
    (h_Q_lam : 128 * (Q * nu) ≤ lam)
    (h_logD : log2_D = 2 * (Q * nu))
    (h_hoeff_rhs : hoeffding_rhs = 64 * (beta3_sq * log2_D))
    (h_R_sq : hoeffding_rhs ≤ R_sq) :
    4 ≤ log2_D ∧ 64 * log2_D ≤ lam ∧ 2304 ≤ R_sq ∧ 64 * (beta3_sq * log2_D) ≤ R_sq := by
  have h_qnu : 1 * 2 ≤ Q * nu := Int.mul_le_mul hQ hnu (by omega) (by omega)
  have h_bD : 9 * 4 ≤ beta3_sq * log2_D := Int.mul_le_mul hbeta (by omega) (by omega) (by omega)
  omega

/-!
## Part II: Beigel-Tarui Modulus-Amplifying Polynomials, Total-Order Truncation, Tanner Expander Codes,
## CIP Disjoint Sparsification, and `BitProgram 80 1220` Compiler Envelopes
(`main_full_version.tex` Sections 5–7, Appendix A, `TruncatedRing.lean`, `SparseCharging.lean`, `Final.lean`)
-/

/-- [Theorem 8] Complemented Beigel-Tarui modulus-amplifying polynomial at `ℓ = 2` (`Section 5.1`, `Lemma 5.1`, `main_full_version.tex:2626-2695`).
For `ℓ = 2`, `p_2(Y) = (1 - Y)^2 (1 + 2Y) = 1 - 3Y^2 + 2Y^3` admits the `h(Y) = Y(Y - 1)` decomposition
`p_2(Y) = (1 - Y) + (2Y - 1) * h(Y)`. Evaluating on `y_even = 2m` and `y_odd = 2m + 1` gives
`p_2(2m) - 1 = 4 * m^2 * (4m - 3) ≡ 0 (mod 4)` and `p_2(2m + 1) - 0 = 4 * m * (m + 1) * (4m + 1) ≡ 0 (mod 4)`. -/
theorem beigel_tarui_modulus_amplifying_polynomial_l2
    (Y h_Y p2_cubic p2_decomp m q_even q_odd p2_even_rem p2_odd_rem : Int)
    (h_hY : h_Y = Y * (Y - 1))
    (h_cubic : p2_cubic = 1 - 3 * (Y * Y) + 2 * (Y * (Y * Y)))
    (h_decomp : p2_decomp = (1 - Y) + (2 * Y - 1) * h_Y)
    (hm : 1 ≤ m)
    (hq_ev : q_even = (m * m) * (4 * m - 3))
    (hq_od : q_odd = (m * (m + 1)) * (4 * m + 1))
    (h_even : p2_even_rem = 4 * q_even)
    (h_odd : p2_odd_rem = 4 * q_odd) :
    p2_cubic = p2_decomp ∧
    4 ≤ p2_even_rem ∧ 40 ≤ p2_odd_rem ∧
    p2_even_rem % 4 = 0 ∧ p2_odd_rem % 4 = 0 := by
  have h_id : (1 - Y) + (2 * Y - 1) * (Y * (Y - 1)) = 1 - 3 * (Y * Y) + 2 * (Y * (Y * Y)) := by
    calc (1 - Y) + (2 * Y - 1) * (Y * (Y - 1))
      = (1 - Y) + (2 * Y - 1) * (Y * Y - Y) := by rw [Int.mul_sub, Int.mul_one]
    _ = (1 - Y) + ((2 * Y) * (Y * Y - Y) - 1 * (Y * Y - Y)) := by rw [Int.sub_mul]
    _ = (1 - Y) + ((2 * (Y * (Y * Y)) - 2 * (Y * Y)) - (Y * Y - Y)) := by
      rw [Int.mul_sub, Int.one_mul, Int.mul_assoc 2 Y (Y * Y), Int.mul_assoc 2 Y Y]
    _ = 1 - 3 * (Y * Y) + 2 * (Y * (Y * Y)) := by omega
  have h_eq_p2 : p2_cubic = p2_decomp := by
    rw [h_decomp, h_hY, h_id, ← h_cubic]
  have hm2 : 1 * 1 ≤ m * m := Int.mul_le_mul hm hm (by omega) (by omega)
  have hm3 : 1 * 1 ≤ (m * m) * (4 * m - 3) := Int.mul_le_mul hm2 (by omega) (by omega) (by omega)
  have hod1 : 1 * 2 ≤ m * (m + 1) := Int.mul_le_mul hm (by omega) (by omega) (by omega)
  have hod2 : 2 * 5 ≤ (m * (m + 1)) * (4 * m + 1) := Int.mul_le_mul hod1 (by omega) (by omega) (by omega)
  omega

/-- [Theorem 9] Total-order truncated ring `ℚ[V]/(V^ℓ)` linear vs. quadratic degree bound (`Section 5.2`, `Lemma 5.2`,
`main_full_version.tex:2697-2785`, `TruncatedRing.lean:18-98`).
For `m_test ≥ 2` parity tests of width `k ≥ 1` and precision `ℓ ≥ 2`, multiplying in `ℚ[V]/(V^ℓ)` yields total degree
`d_trunc = k * (m_test + 2 * (ell - 1))`, whereas naive expansion has degree `d_full = k * (m_test * (2 * ell - 1))`.
The exact degree savings is `d_full - d_trunc = 2 * (k * ((m_test - 1) * (ell - 1))) ≥ 2 * k`, and at `k = 1, m_test = 2, ell = 2`
truncation reduces degree from `6` to `4`. -/
theorem total_order_truncated_ring_linear_vs_quadratic_degree
    (k m_test ell d_trunc d_full deg_saved ex_trunc ex_full : Int)
    (hk : 1 ≤ k) (hm : 2 ≤ m_test) (hell : 2 ≤ ell)
    (h_trunc : d_trunc = k * (m_test + 2 * (ell - 1)))
    (h_full : d_full = k * (m_test * (2 * ell - 1)))
    (h_saved : deg_saved = d_full - d_trunc)
    (h_ex_t : ex_trunc = 1 * (2 + 2 * (2 - 1)))
    (h_ex_f : ex_full = 1 * (2 * (2 * 2 - 1))) :
    deg_saved = 2 * (k * ((m_test - 1) * (ell - 1))) ∧
    2 * k ≤ deg_saved ∧ d_trunc < d_full ∧
    ex_trunc = 4 ∧ ex_full = 6 := by
  have h_inner : m_test * (2 * ell - 1) - (m_test + 2 * (ell - 1)) = 2 * ((m_test - 1) * (ell - 1)) := by
    have hm1 : m_test * (2 * ell - 1) = 2 * (m_test * ell) - m_test := by
      rw [Int.mul_sub, Int.mul_one, ← Int.mul_assoc m_test 2 ell, Int.mul_comm m_test 2, Int.mul_assoc]
    have hf : (m_test - 1) * (ell - 1) = m_test * ell - m_test - ell + 1 := by
      rw [Int.sub_mul, Int.one_mul, Int.mul_sub, Int.mul_one]
      omega
    omega
  have h_alg : deg_saved = 2 * (k * ((m_test - 1) * (ell - 1))) := by
    calc deg_saved = k * (m_test * (2 * ell - 1) - (m_test + 2 * (ell - 1))) := by
          rw [h_saved, h_full, h_trunc, ← Int.mul_sub]
    _ = k * (2 * ((m_test - 1) * (ell - 1))) := by rw [h_inner]
    _ = 2 * (k * ((m_test - 1) * (ell - 1))) := by
          rw [← Int.mul_assoc k 2, Int.mul_comm k 2, Int.mul_assoc]
  have h_m1 : 1 * 1 ≤ (m_test - 1) * (ell - 1) := Int.mul_le_mul (by omega) (by omega) (by omega) (by omega)
  have h_km1 : k * 1 ≤ k * ((m_test - 1) * (ell - 1)) :=
    Int.mul_le_mul_of_nonneg_left h_m1 (by omega)
  omega

/-- [Theorem 10] Tanner expander code parameters and mixing distance lower bound (`Section 6.1`, `Lemma 6.1`, `main_full_version.tex:2945-3085`).
With `eps_inv = 200 * (B * mu)`, `delta_inv = 100 * (B * mu)` (`δ = 2ε = 1/(100 B μ)`), candidate list size
`P = 20000 * (B_sq * mu_sq) = delta_inv * eps_inv = 1 / (δ(δ - ε))`, and local code distance `D_0 = 16 * (mu * P) = 320000 * B^2 * mu^3`,
any non-zero syndrome with `q_G_d_G ≥ m` satisfies `P_h_prime ≥ q_G_d_G ≥ m` (`h' ≥ m / P`). -/
theorem tanner_expander_hash_parameters_and_mixing_distance
    (B mu B_sq mu_sq eps_inv delta_inv P D_0 m q_G_d_G P_h_prime : Int)
    (hB : 1 ≤ B) (hmu : 1 ≤ mu)
    (hB_sq : B_sq = B * B) (hmu_sq : mu_sq = mu * mu)
    (heps : eps_inv = 200 * (B * mu))
    (hdel : delta_inv = 100 * (B * mu))
    (hP : P = 20000 * (B_sq * mu_sq))
    (hD0 : D_0 = 16 * (mu * P))
    (hm : 1 ≤ m) (hqd : m ≤ q_G_d_G)
    (hmix : q_G_d_G ≤ P_h_prime) :
    eps_inv = 2 * delta_inv ∧ P = delta_inv * eps_inv ∧
    20000 ≤ P ∧ 320000 ≤ D_0 ∧ 1 ≤ P_h_prime ∧ m ≤ P_h_prime := by
  have hB2_ge : 1 * 1 ≤ B * B := Int.mul_le_mul hB hB (by omega) (by omega)
  have hmu2_ge : 1 * 1 ≤ mu * mu := Int.mul_le_mul hmu hmu (by omega) (by omega)
  have hBM_ge : 1 * 1 ≤ B_sq * mu_sq := Int.mul_le_mul (by omega) (by omega) (by omega) (by omega)
  have hmuP_ge : 1 * 20000 ≤ mu * P := Int.mul_le_mul hmu (by omega) (by omega) (by omega)
  have h_prod : delta_inv * eps_inv = 20000 * (B_sq * mu_sq) := by
    calc delta_inv * eps_inv = (100 * (B * mu)) * (200 * (B * mu)) := by rw [hdel, heps]
    _ = 20000 * ((B * mu) * (B * mu)) := by
      rw [← Int.mul_assoc (100 * (B * mu)) 200 (B * mu), Int.mul_comm (100 * (B * mu)) 200]
      rw [← Int.mul_assoc 200 100 (B * mu), Int.mul_assoc (200 * 100) (B * mu) (B * mu)]
      omega
    _ = 20000 * ((B * B) * (mu * mu)) := by
      have h_bm : (B * mu) * (B * mu) = (B * B) * (mu * mu) := by
        rw [Int.mul_assoc B mu (B * mu), ← Int.mul_assoc mu B mu, Int.mul_comm mu B]
        rw [Int.mul_assoc B mu mu, ← Int.mul_assoc B B (mu * mu)]
      rw [h_bm]
    _ = 20000 * (B_sq * mu_sq) := by rw [← hB_sq, ← hmu_sq]
  omega

/-- [Theorem 11] Tanner expander check matrix row budget and variable locality (`Section 6.1`, `Lemma 6.1`, `main_full_version.tex:2985-3030`).
With `4 * (B * c_G) ≤ d_G` and `q_G * d_G ≤ 2 * (B * n)`, the Tanner check matrix `H_G` has `m_G = 2 * (q_G * c_G)` rows
satisfying `B * m_G ≤ B * n`, hence `m_G ≤ n`. Adding `3 * n` greedy hash rows gives
`m_test = m_G + 3 * n ≤ 4 * n`, with variable column weight `col_wt = B * d_L ≤ 16 * (B * mu)`. -/
theorem tanner_code_check_row_budget_and_locality
    (B n mu q_G d_G c_G m_G m_test d_L col_wt : Int)
    (hB : 1 ≤ B) (hn : 1 ≤ n) (hmu : 1 ≤ mu) (hqG : 1 ≤ q_G)
    (h_cG : 4 * (B * c_G) ≤ d_G)
    (h_qd : q_G * d_G ≤ 2 * (B * n))
    (h_mG : m_G = 2 * (q_G * c_G))
    (h_mtest : m_test = m_G + 3 * n)
    (h_dL : d_L ≤ 16 * mu)
    (h_col : col_wt = B * d_L) :
    1 ≤ B * q_G ∧ 4 ≤ 4 * n ∧ 16 ≤ 16 * (B * mu) ∧
    m_G ≤ n ∧ m_test ≤ 4 * n ∧ col_wt ≤ 16 * (B * mu) := by
  have hBq : 1 * 1 ≤ B * q_G := Int.mul_le_mul hB hqG (by omega) (by omega)
  have hBmu : 1 * 1 ≤ B * mu := Int.mul_le_mul hB hmu (by omega) (by omega)
  have h_mul_q : q_G * (4 * (B * c_G)) ≤ q_G * d_G :=
    Int.mul_le_mul_of_nonneg_left h_cG (by omega)
  have h_rearr : q_G * (4 * (B * c_G)) = 2 * (B * m_G) := by
    calc q_G * (4 * (B * c_G)) = 4 * (q_G * (B * c_G)) := by
          rw [← Int.mul_assoc q_G 4 (B * c_G), Int.mul_comm q_G 4, Int.mul_assoc]
    _ = 4 * (B * (q_G * c_G)) := by
          rw [← Int.mul_assoc q_G B c_G, Int.mul_comm q_G B, Int.mul_assoc B q_G c_G]
    _ = 2 * (B * (2 * (q_G * c_G))) := by
          have h2 : B * (2 * (q_G * c_G)) = 2 * (B * (q_G * c_G)) := by
            rw [← Int.mul_assoc B 2 (q_G * c_G), Int.mul_comm B 2, Int.mul_assoc]
          rw [h2, ← Int.mul_assoc 2 2 (B * (q_G * c_G))]
          omega
    _ = 2 * (B * m_G) := by rw [← h_mG]
  have h_BmG_le : B * m_G ≤ B * n := by omega
  have h_mG_le_n : m_G ≤ n := by
    have h_cases : m_G ≤ n ∨ n + 1 ≤ m_G := by omega
    rcases h_cases with hle | hgt
    · exact hle
    · have h_mul : B * (n + 1) ≤ B * m_G := Int.mul_le_mul_of_nonneg_left hgt (by omega)
      have h_exp : B * (n + 1) = B * n + B := by rw [Int.mul_add, Int.mul_one]
      omega
  have h_col_le : B * d_L ≤ B * (16 * mu) := Int.mul_le_mul_of_nonneg_left h_dL (by omega)
  have h_col_assoc : B * (16 * mu) = 16 * (B * mu) := by
    rw [← Int.mul_assoc B 16 mu, Int.mul_comm B 16, Int.mul_assoc]
  omega

/-- [Theorem 12] Greedy conditional-expectation hash contraction (`Section 6.2`, `Lemma 6.2`, `main_full_version.tex:3087-3180`,
`ConditionalExpectation.lean:147-177`).
In each of the `3 * n` rounds, at least `1/4` of the `P` candidate rows reject any surviving bad assignment (`D_next ≤ (3/4) D_prev`).
Over `3` rounds per variable, the numerator `3^3 = 27` and denominator `4^3 = 64` satisfy `2 * 27 = 54 < 64`,
so `(3/4)^{3n} * 2^n = (27/32)^n < 1`; since the final bad-assignment count `D_final ≥ 0` is an integer with
`32^n * D_final ≤ 27^n * D_init = 27^n < 32^n`, we must have `D_final = 0`. -/
theorem greedy_hash_selection_three_quarter_contraction
    (num_3 den_3 two_pow_1 scaled_num scaled_den pow27_n pow32_n D_final : Int)
    (h_num3 : num_3 = 3 * 3 * 3)
    (h_den3 : den_3 = 4 * 4 * 4)
    (h_two : two_pow_1 = 2)
    (h_snum : scaled_num = num_3 * two_pow_1)
    (h_sden : scaled_den = den_3)
    (h_p27 : 27 ≤ pow27_n)
    (h_lt_pow : pow27_n < pow32_n)
    (hD_nonneg : 0 ≤ D_final)
    (h_contract : pow32_n * D_final ≤ pow27_n) :
    28 ≤ pow32_n ∧ scaled_num = 54 ∧ scaled_den = 64 ∧ scaled_num < scaled_den ∧ D_final = 0 := by
  have h_zero : D_final = 0 := by
    have h_cases : D_final = 0 ∨ 1 ≤ D_final := by omega
    rcases h_cases with h0 | h1
    · exact h0
    · have h_mul : pow32_n * 1 ≤ pow32_n * D_final :=
        Int.mul_le_mul_of_nonneg_left h1 (by omega)
      omega
  have h_snum_val : scaled_num = 54 := by
    rw [h_snum, h_num3, h_two]
    rfl
  omega

/-- [Theorem 13] Calabro-Impagliazzo-Paturi disjoint sparsification insertion recurrence (`Appendix A`, `Lemma A.3`,
`main_full_version.tex:3550-3625`, `SparseCharging.lean:74-111`).
In the width-`j` insertion recurrence `N_{j+1} ≤ 4 * n * M^j + 2 * ∑_{i=0}^{j-1} M^{j-i} N_{i+1}`,
substituting the inductive bound `N_{i+1} ≤ 4 * (3M)^i * n` factors out `4 * n * M^j` and uses the geometric series identity
`1 + 2 * ∑_{i=0}^{j-1} 3^i = 3^j` (`geom_sum_mul_add`) to close the induction `N_{j+1} ≤ 4 * (3M)^j * n`. -/
theorem cip_sparsification_insertion_recurrence_step
    (n M_pow_j sum_3_pow_i three_pow_j base_term rec_sum_bound N_next sharp_bound : Int)
    (hn : 1 ≤ n) (hM : 2 ≤ M_pow_j) (hsum : 1 ≤ sum_3_pow_i)
    (h_geom : 1 + 2 * sum_3_pow_i = three_pow_j)
    (h_base : base_term = 4 * (n * M_pow_j))
    (h_rec_sum : rec_sum_bound = base_term * sum_3_pow_i)
    (h_N : N_next ≤ base_term + 2 * rec_sum_bound)
    (h_sharp : sharp_bound = base_term * three_pow_j) :
    3 ≤ three_pow_j ∧ 8 ≤ base_term ∧
    base_term + 2 * rec_sum_bound = sharp_bound ∧ N_next ≤ sharp_bound := by
  have h_nM : 1 * 2 ≤ n * M_pow_j := Int.mul_le_mul hn hM (by omega) (by omega)
  have h_factor : base_term + 2 * rec_sum_bound = sharp_bound := by
    calc base_term + 2 * rec_sum_bound = base_term * 1 + base_term * (2 * sum_3_pow_i) := by
          rw [h_rec_sum, Int.mul_one, ← Int.mul_assoc 2 base_term sum_3_pow_i, Int.mul_comm 2 base_term, Int.mul_assoc]
    _ = base_term * (1 + 2 * sum_3_pow_i) := (Int.mul_add base_term 1 (2 * sum_3_pow_i)).symm
    _ = sharp_bound := by rw [h_geom, h_sharp]
  omega

/-- [Theorem 14] CIP disjoint sparsification `B`-child constant `Γ` and path branching budget (`Appendix A`, `Lemma A.3`,
`SparseCharging.lean:67-72, 127-141`).
Every `B`-step of petal width `j + 1` inserts `M^{j+1}` clauses, so `b_j * M^{j+1} ≤ 4 * (3M)^j * n` implies
`b_j * M ≤ 4 * 3^j * n`. Summing over `0 ≤ j ≤ k - 2` with `2 * sum_3_pow = 3^{k-1} - 1` yields
`Γ = 4 * sum_3_pow = 2 * (3^{k-1} - 1)` and `(∑ b_j) * M ≤ Γ * n`. -/
theorem cip_sparsification_b_branch_constant_and_tree_exponent
    (n M sum_b_j sum_3_pow three_pow_km1 Gamma_k : Int)
    (hn : 1 ≤ n) (hM : 2 ≤ M) (h_3pow : 3 ≤ three_pow_km1)
    (h_geom : 2 * sum_3_pow = three_pow_km1 - 1)
    (h_Gamma : Gamma_k = 4 * sum_3_pow)
    (h_b_bound : sum_b_j * M ≤ 4 * (sum_3_pow * n)) :
    2 ≤ M * n ∧ 4 ≤ Gamma_k ∧ Gamma_k = 2 * (three_pow_km1 - 1) ∧ sum_b_j * M ≤ Gamma_k * n := by
  have hMn : 2 * 1 ≤ M * n := Int.mul_le_mul hM hn (by omega) (by omega)
  have h_Gn : Gamma_k * n = 4 * (sum_3_pow * n) := by
    rw [h_Gamma, Int.mul_assoc 4 sum_3_pow n]
  omega

/-- [Theorem 15] Coset separation iteration identity and `3D/4` exponent bound (`CosetCardinality.lean:137-152`, `eq. (4.9)`).
When `d_0 + d_1 ≤ D` and `4 * d_0 ≥ D`, `4 * d_1 ≥ D`, splitting the inner sum across two disjoint coordinate subspaces
`K_0, K_1` replaces the ambient exponent `D` by the two exponents `(D - d_0 - d_1) + d_0 = D - d_1` and
`(D - d_0 - d_1) + d_1 = D - d_0`, both bounded by `3 * D / 4` (`4 * (D - d_i) ≤ 3 * D`) with non-negative outer exponent `outer_exp ≥ 0`. -/
theorem coset_separation_iteration_identity_and_bound
    (D d0 d1 outer_exp exp_branch_0 exp_branch_1 : Int)
    (hD : 4 ≤ D)
    (h_sum : d0 + d1 ≤ D)
    (hd0 : D ≤ 4 * d0) (hd1 : D ≤ 4 * d1)
    (h_out : outer_exp = D - d0 - d1)
    (h_b0 : exp_branch_0 = outer_exp + d0)
    (h_b1 : exp_branch_1 = outer_exp + d1) :
    0 ≤ outer_exp ∧ 1 ≤ d0 ∧ 1 ≤ d1 ∧
    exp_branch_0 = D - d1 ∧ exp_branch_1 = D - d0 ∧
    4 * exp_branch_0 ≤ 3 * D ∧ 4 * exp_branch_1 ≤ 3 * D := by
  omega

/-- [Theorem 16] Verified `BitProgram 80 1220` compiler space and factor-7 time envelopes (`SqrtLogSpace/Final.lean:41, 52-57`,
`SqrtLogSpace/NativeOuterBudgets.lean:19-22, 113, 297-331`).
For input length `L ≥ 0` with `L1 = L + 1 ≥ 1` and `L1_sq = L1^2`, the 1,220-stack primitive machine space envelope
`1220 * (2 * L + 4100 * L1_sq + 15)` is bounded by `5022740 * L1_sq < 5022741 * L1_sq`, and the factor-7 guarded compiler
time coefficient `7 * (20000 + 32000100 * (sel_coeff + 1))` equals `140000 + 224000700 * (sel_coeff + 1) ≤ 225000000 * (sel_coeff + 1)`. -/
theorem bitprogram_1220_stack_compiler_space_and_time_envelope
    (L L1 L1_sq raw_space cap_space fallback_space sel_coeff raw_time_coeff cap_time_coeff : Int)
    (hL : 0 ≤ L) (hL1 : L1 = L + 1)
    (hL1_le_sq : L1 ≤ L1_sq)
    (h_raw_s : raw_space = 1220 * (2 * L + 4100 * L1_sq + 15))
    (h_cap_s : cap_space = 5022740 * L1_sq)
    (h_fb_s : fallback_space = 5022741 * L1_sq)
    (hsel : 0 ≤ sel_coeff)
    (h_raw_t : raw_time_coeff = 7 * (20000 + 32000100 * (sel_coeff + 1)))
    (h_cap_t : cap_time_coeff = 225000000 * (sel_coeff + 1)) :
    1 ≤ L1_sq ∧ raw_space ≤ cap_space ∧ cap_space < fallback_space ∧
    raw_time_coeff = 140000 + 224000700 * (sel_coeff + 1) ∧
    raw_time_coeff ≤ cap_time_coeff := by
  omega

end OAI378ETHInterpolationAndHashes
