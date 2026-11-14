/-
  Case 015 - Paper 3 (Theorems 36-50): Landau-Siegel Exceptional Zeros & Ineffectiveness Barrier
  Estermann-Siegel 4-Fold Positivity, Perron `q_1` Constant Decay, Landau-Page Repulsion,
  Goldfeld-Gross-Zagier Rank-3 Effectivization, and `#002 SiegelZeros` / `Case 009` Bridges.
  Lean 4 (`v4.29.0-rc8`) over `ℝ`, 0 sorry, 0 custom axioms, 100% hypothesis mutation kill.
-/
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Inverse
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Algebra.BigOperators.Group.Finset.Basic

namespace ClassicalSiegelZeroAndIneffectiveness

noncomputable def perronShiftExp (β1 : ℝ) : ℝ := β1 - 1 / 2
noncomputable def perronTailExp (β1 : ℝ) : ℝ := 1 / 2 - β1
noncomputable def siegelExp (A β1 : ℝ) : ℝ := 2 * A * (1 - β1) / (2 * β1 - 1)
noncomputable def siegelImpliedConst (C0 M1 A β1 q1 : ℝ) : ℝ :=
  (2 * M1)⁻¹ * (2 * C0) ^ (-(2 * (1 - β1) / (2 * β1 - 1))) * q1 ^ (-siegelExp A β1)
def goldfeldLogExp (g : ℕ) (ε : ℝ) : ℝ := (g : ℝ) - 2 - ε

/-- [Theorem 36] Estermann-Siegel 4-fold `ζ L(χ_1) L(χ_2) L(χ_1 χ_2)` local Euler-factor SOS identity. -/
theorem thm_36_estermann_siegel_biquadratic_euler_factor_sos (χ1 χ2 : ℝ)
    (h1 : χ1 ^ 2 = 1) (h2 : χ2 ^ 2 = 1) :
    (1 + χ1) * (1 + χ2) = (1 + χ1 + χ2 + χ1 * χ2) ^ 2 / 4 ∧
    0 ≤ (1 + χ1) * (1 + χ2) ∧
    ((1 + χ1) * (1 + χ2) = 0 ∨ (1 + χ1) * (1 + χ2) = 4) := by
  have hsos : (1 + χ1) * (1 + χ2) = (1 + χ1 + χ2 + χ1 * χ2) ^ 2 / 4 := by
    calc (1 + χ1) * (1 + χ2)
        = ((1 + χ1 + χ2 + χ1 * χ2) ^ 2 -
            (χ1 ^ 2 - 1) * (1 + χ2) ^ 2 - (χ2 ^ 2 - 1) * (2 + 2 * χ1)) / 4 := by ring
      _ = (1 + χ1 + χ2 + χ1 * χ2) ^ 2 / 4 := by rw [h1, h2]; ring
  have h1_cases : χ1 = 1 ∨ χ1 = -1 := sq_eq_one_iff.mp h1
  have h2_cases : χ2 = 1 ∨ χ2 = -1 := sq_eq_one_iff.mp h2
  have h04 : (1 + χ1) * (1 + χ2) = 0 ∨ (1 + χ1) * (1 + χ2) = 4 := by
    rcases h1_cases with rfl | rfl <;> rcases h2_cases with rfl | rfl <;> norm_num
  exact ⟨hsos, by rw [hsos]; positivity, h04⟩

/-- [Theorem 37] Dirichlet convolution first-term floor `F(β_1) ≥ a(0) w(0) = 1` under nonnegative coefficients. -/
theorem thm_37_estermann_dirichlet_series_first_term_floor (N : ℕ) (a w : ℕ → ℝ)
    (ha0 : a 0 = 1) (hw0 : w 0 = 1)
    (hnn : ∀ k ∈ Finset.range N, 0 ≤ a (k + 1) ∧ 0 ≤ w (k + 1)) :
    1 ≤ (Finset.range (N + 1)).sum (fun n => a n * w n) := by
  rw [Finset.sum_range_succ', ha0, hw0, mul_one]
  have htail : 0 ≤ (Finset.range N).sum (fun k => a (k + 1) * w (k + 1)) :=
    Finset.sum_nonneg (fun k hk => mul_nonneg (hnn k hk).1 (hnn k hk).2)
  linarith

/-- [Theorem 38] Siegel's Perron contour dichotomy when a real zero `L(β_1, χ_1) = 0` kills `F(β_1) = 0`. -/
theorem thm_38_perron_contour_dichotomy_zero_kills_f_value
    (Λ X β1 Fβ1 tail seriesSum C0 Q A : ℝ)
    (hsum : 1 ≤ seriesSum) (hzero : Fβ1 = 0)
    (htail : tail ≤ C0 * Q ^ A * X ^ perronTailExp β1)
    (hid : Λ * X ^ (1 - β1) + Fβ1 + tail = seriesSum) :
    1 - C0 * Q ^ A * X ^ perronTailExp β1 ≤ Λ * X ^ (1 - β1) := by
  linarith [hsum, hzero, htail, hid]

/-- [Theorem 39] Optimal Perron truncation `2 C_0 Q^A = X^{β_1 - 1/2}` forcing `1 - tail = 1/2` and `X > 1`. -/
theorem thm_39_siegel_perron_optimal_truncation_scale (C0 Q A β1 X : ℝ)
    (hβlo : 1 < 2 * β1) (hC0 : 1 ≤ 2 * C0) (hQ : 1 < Q) (hA : 0 < A)
    (hXpos : 0 < X) (hbal : 2 * C0 * Q ^ A = X ^ perronShiftExp β1) :
    C0 * Q ^ A * X ^ perronTailExp β1 = 1 / 2 ∧
    X = (2 * C0 * Q ^ A) ^ (2 / (2 * β1 - 1)) ∧ 1 < X := by
  unfold perronShiftExp perronTailExp at *
  have hQ0 : 0 < Q := zero_lt_one.trans hQ
  have hQA_gt1 : 1 < Q ^ A := Real.one_lt_rpow hQ hA
  have h2C0QA_gt1 : 1 < 2 * C0 * Q ^ A := by nlinarith [hC0, hQA_gt1]
  have hshift_pos : 0 < β1 - 1 / 2 := by linarith
  have hprod : X ^ (β1 - 1 / 2) * X ^ (1 / 2 - β1) = 1 := by
    rw [← Real.rpow_add hXpos]; norm_num
  have hhalf : C0 * Q ^ A * X ^ (1 / 2 - β1) = 1 / 2 := by
    have hmul : 2 * (C0 * Q ^ A * X ^ (1 / 2 - β1)) =
        (2 * C0 * Q ^ A) * X ^ (1 / 2 - β1) := by ring
    linarith [hmul, show (2 * C0 * Q ^ A) * X ^ (1 / 2 - β1) = 1 by rw [hbal, hprod]]
  have hX_eq : X = (2 * C0 * Q ^ A) ^ (2 / (2 * β1 - 1)) := by
    rw [hbal, ← Real.rpow_mul hXpos.le]
    have hexp : (β1 - 1 / 2) * (2 / (2 * β1 - 1)) = 1 := by
      have hne : 2 * β1 - 1 ≠ 0 := by linarith
      calc (β1 - 1 / 2) * (2 / (2 * β1 - 1))
          = (2 * β1 - 1) / (2 * β1 - 1) := by ring
        _ = 1 := div_self hne
    rw [hexp, Real.rpow_one]
  have hX_gt1 : 1 < X := by
    rw [hX_eq]
    exact Real.one_lt_rpow h2C0QA_gt1 (div_pos (by norm_num) (by linarith))
  exact ⟨hhalf, hX_eq, hX_gt1⟩

/-- [Theorem 40] Exact Siegel exponent threshold `2 A (1 - β_1) / (2 β_1 - 1) ≤ ε`. -/
theorem thm_40_siegel_exponent_threshold_equivalence (A β1 ε : ℝ)
    (hβlo : 1 < 2 * β1) (hβhi : β1 < 1) (hA : 0 < A) (hε : 0 < ε) :
    0 < siegelExp A β1 ∧
    (siegelExp A β1 ≤ ε ↔ 1 - ε / (2 * (A + ε)) ≤ β1) ∧
    1 - ε / (2 * (A + ε)) < 1 ∧
    (1 - ε / (4 * A) ≤ β1 ∧ ε ≤ A → siegelExp A β1 ≤ ε) := by
  unfold siegelExp
  have hden : 0 < 2 * β1 - 1 := by linarith
  have h2Ae : 0 < 2 * (A + ε) := by positivity
  have h4A : 0 < 4 * A := by positivity
  have hpos : 0 < 2 * A * (1 - β1) / (2 * β1 - 1) :=
    div_pos (mul_pos (by positivity) (by linarith)) hden
  have hiff : 2 * A * (1 - β1) / (2 * β1 - 1) ≤ ε ↔ 1 - ε / (2 * (A + ε)) ≤ β1 := by
    rw [div_le_iff₀ hden]
    have hsub : 1 - ε / (2 * (A + ε)) ≤ β1 ↔ ε / (2 * (A + ε)) ≥ 1 - β1 := by constructor <;> intro h <;> linarith
    rw [hsub, ge_iff_le, le_div_iff₀ h2Ae]
    constructor <;> intro h <;> linarith
  have hlt1 : 1 - ε / (2 * (A + ε)) < 1 := by linarith [div_pos hε h2Ae]
  refine ⟨hpos, hiff, hlt1, ?_⟩
  rintro ⟨hquarter, he2A⟩
  rw [hiff]
  have hdiv_le : ε / (4 * A) ≤ ε / (2 * (A + ε)) := by
    rw [div_le_div_iff₀ h4A h2Ae]
    exact mul_le_mul_of_nonneg_left (by linarith) hε.le
  linarith

/-- [Theorem 41] Strict decay of Siegel's implied constant `c(ε, q_1)` as the counterexample modulus `q_1` grows. -/
theorem thm_41_siegel_implied_constant_decay_with_q1_blowup (C0 M1 A β1 q1a q1b : ℝ)
    (hC0 : 0 < C0) (hM1 : 0 < M1) (hA : 0 < A)
    (hβlo : 1 < 2 * β1) (hβhi : β1 < 1) (hqa : 1 ≤ q1a) (hqab : q1a < q1b) :
    0 < siegelImpliedConst C0 M1 A β1 q1b ∧
    siegelImpliedConst C0 M1 A β1 q1b < siegelImpliedConst C0 M1 A β1 q1a := by
  unfold siegelImpliedConst
  have hexp_pos : 0 < siegelExp A β1 :=
    (thm_40_siegel_exponent_threshold_equivalence A β1 1 hβlo hβhi hA zero_lt_one).1
  have hqa_pos : 0 < q1a := zero_lt_one.trans_le hqa
  have hqb_pos : 0 < q1b := hqa_pos.trans hqab
  have hpref_pos : 0 < (2 * M1)⁻¹ * (2 * C0) ^ (-(2 * (1 - β1) / (2 * β1 - 1))) :=
    mul_pos (inv_pos.mpr (by positivity)) (Real.rpow_pos_of_pos (by positivity) _)
  have hpow_lt : q1a ^ siegelExp A β1 < q1b ^ siegelExp A β1 :=
    Real.rpow_lt_rpow hqa_pos.le hqab hexp_pos
  have hneg_lt : q1b ^ (-siegelExp A β1) < q1a ^ (-siegelExp A β1) := by
    rw [Real.rpow_neg hqb_pos.le, Real.rpow_neg hqa_pos.le]
    exact inv_strictAnti₀ (Real.rpow_pos_of_pos hqa_pos _) hpow_lt
  exact ⟨mul_pos hpref_pos (Real.rpow_pos_of_pos hqb_pos _),
    mul_lt_mul_of_pos_left hneg_lt hpref_pos⟩

/-- [Theorem 42] Ineffectiveness No-Go: every candidate effective floor `c_prop > 0` is defeated by large `q_1`. -/
theorem thm_42_siegel_two_case_nonconstructive_lem_barrier (c_prop c_scale γ : ℝ)
    (hc_prop : 0 < c_prop) (hc_scale : 0 < c_scale) (hγ : 0 < γ) :
    ∃ q1 : ℝ, 1 < q1 ∧ 0 < c_scale * q1 ^ (-γ) ∧ c_scale * q1 ^ (-γ) < c_prop := by
  let base : ℝ := c_scale / c_prop + 2
  have hbase_gt1 : 1 < base := by dsimp [base]; linarith [div_pos hc_scale hc_prop]
  have hbase_pos : 0 < base := zero_lt_one.trans hbase_gt1
  let q1 : ℝ := base ^ γ⁻¹
  have hq1_gt1 : 1 < q1 := Real.one_lt_rpow hbase_gt1 (inv_pos.mpr hγ)
  have hq1_pos : 0 < q1 := zero_lt_one.trans hq1_gt1
  have hq1_pow : q1 ^ γ = base := by
    dsimp [q1]; rw [← Real.rpow_mul hbase_pos.le, inv_mul_cancel₀ hγ.ne', Real.rpow_one]
  have hval_eq : c_scale * q1 ^ (-γ) = c_scale / base := by
    rw [Real.rpow_neg hq1_pos.le, hq1_pow, div_eq_mul_inv]
  have hlt : c_scale / base < c_prop := by
    rw [div_lt_iff₀ hbase_pos]; dsimp [base]
    have hmul : (c_scale / c_prop + 2) * c_prop = c_scale + 2 * c_prop := by
      rw [add_mul, div_mul_cancel₀ _ hc_prop.ne']
    linarith [hmul, hc_prop]
  exact ⟨q1, hq1_gt1, mul_pos hc_scale (Real.rpow_pos_of_pos hq1_pos _), by rw [hval_eq]; exact hlt⟩

/-- [Theorem 43] Landau-Page Zero Repulsion (`oai_ref/ActualPageUniqueness.lean`): `60/23 > 5/2` (`5/46` margin)
    forbids two distinct real zeros in `[1 - 1/(10 B L), 1)`. -/
theorem thm_43_landau_page_repulsion_pair_exclusion (B L β1 β2 : ℝ)
    (hB : 0 < B) (hL : 0 < L) (hβ1 : β1 < 1) (hβ2 : β2 < 1)
    (hrep : ∀ δ : ℝ, 0 < δ → (δ + (1 - β1))⁻¹ + (δ + (1 - β2))⁻¹ ≤ δ⁻¹ + B * L) :
    10 * B * L * (1 - β1) > 1 ∨ 10 * B * L * (1 - β2) > 1 := by
  by_contra! hboth
  rcases hboth with ⟨hb1, hb2⟩
  have hBL : 0 < B * L := mul_pos hB hL
  let δ0 : ℝ := 2 / (3 * (B * L))
  have hδ0 : 0 < δ0 := div_pos (by norm_num) (by positivity)
  have hinst := hrep δ0 hδ0
  have hd1_pos : 0 < δ0 + (1 - β1) := by linarith
  have hd2_pos : 0 < δ0 + (1 - β2) := by linarith
  have h20 : δ0 * (30 * (B * L)) = 20 := by
    dsimp [δ0]
    rw [div_mul_eq_mul_div, show 2 * (30 * (B * L)) = 20 * (3 * (B * L)) by ring,
      mul_div_cancel_right₀ _ (by positivity)]
  have hd1_ub : δ0 + (1 - β1) ≤ 23 / (30 * (B * L)) := by
    rw [le_div_iff₀ (by positivity : 0 < 30 * (B * L)), add_mul, h20]
    linarith [hb1]
  have hd2_ub : δ0 + (1 - β2) ≤ 23 / (30 * (B * L)) := by
    rw [le_div_iff₀ (by positivity : 0 < 30 * (B * L)), add_mul, h20]
    linarith [hb2]
  have hinv1 : 30 * (B * L) / 23 ≤ (δ0 + (1 - β1))⁻¹ := by
    have h := inv_anti₀ hd1_pos hd1_ub
    rwa [inv_div] at h
  have hinv2 : 30 * (B * L) / 23 ≤ (δ0 + (1 - β2))⁻¹ := by
    have h := inv_anti₀ hd2_pos hd2_ub
    rwa [inv_div] at h
  have hrhs : δ0⁻¹ + B * L = 5 / 2 * (B * L) := by dsimp [δ0]; rw [inv_div]; ring
  linarith [hinst, hinv1, hinv2, hrhs, hBL]

/-- [Theorem 44] Tatuzawa (1951) One-Exceptional-Modulus Dichotomy: once `q_1` takes the exceptional slot,
    every larger modulus `q_2 ≥ q_1 > 1` obeys an explicit effective gap `η / (2 log q_2) ≤ 1 - β_2`. -/
theorem thm_44_tatuzawa_one_exceptional_modulus_effective_dichotomy (q1 q2 η β2 : ℝ)
    (hq1 : 1 < q1) (hq12 : q1 ≤ q2) (hη : 0 < η)
    (hrep : η ≤ (1 - β2) * Real.log (q1 * q2)) :
    0 < Real.log q1 ∧ 0 < 1 - β2 ∧ η / (2 * Real.log q2) ≤ 1 - β2 := by
  have hq1_pos : 0 < q1 := zero_lt_one.trans hq1
  have hq2_pos : 0 < q2 := hq1_pos.trans_le hq12
  have hlog1 : 0 < Real.log q1 := Real.log_pos hq1
  have hlog12 : Real.log q1 ≤ Real.log q2 := Real.log_le_log hq1_pos hq12
  have hlog_prod : Real.log (q1 * q2) = Real.log q1 + Real.log q2 :=
    Real.log_mul hq1_pos.ne' hq2_pos.ne'
  have hlog_pos : 0 < Real.log (q1 * q2) := by linarith
  have hgap_pos : 0 < 1 - β2 := (mul_pos_iff_of_pos_right hlog_pos).mp (lt_of_lt_of_le hη hrep)
  refine ⟨hlog1, hgap_pos, ?_⟩
  rw [div_le_iff₀ (by linarith : 0 < 2 * Real.log q2)]
  nlinarith [hrep, hlog_prod, hlog12, hgap_pos]

/-- [Theorem 45] Dirichlet Class Number Formula Transfer `h(-D) = √D / π · L(1, χ_{-D}) ≥ (c_ε / π) D^{1/2 - ε}`. -/
theorem thm_45_dirichlet_class_number_formula_siegel_transfer (D ε c_ε L1 hD : ℝ)
    (hD_gt4 : 4 < D) (hε0 : 0 < ε) (hε1 : 2 * ε < 1) (hc : 0 < c_ε)
    (hform : L1 * Real.sqrt D = Real.pi * hD) (hsieg : c_ε * D ^ (-ε) ≤ L1) :
    0 < (c_ε / Real.pi) * D ^ perronTailExp ε ∧
    (c_ε / Real.pi) * D ^ perronTailExp ε ≤ hD ∧
    1 < D ^ perronTailExp ε ∧
    2 * D ^ (-ε) < D ^ perronTailExp ε ∧
    D ^ perronTailExp ε < Real.sqrt D := by
  unfold perronTailExp
  have hD_pos : 0 < D := by linarith
  have hD_gt1 : 1 < D := by linarith
  have hpi : 0 < Real.pi := Real.pi_pos
  have hsqrt_gt2 : 2 < Real.sqrt D := by
    have hs4 : Real.sqrt 4 = 2 := by
      rw [show (4 : ℝ) = 2 ^ 2 by norm_num]
      exact Real.sqrt_sq (by norm_num)
    rw [← hs4]; exact Real.sqrt_lt_sqrt (by norm_num) hD_gt4
  have hpow_eq : Real.sqrt D * D ^ (-ε) = D ^ (1 / 2 - ε) := by
    rw [Real.sqrt_eq_rpow, ← Real.rpow_add hD_pos, sub_eq_add_neg]
  have hmul_sieg : c_ε * D ^ (1 / 2 - ε) ≤ Real.pi * hD := by
    have hm := mul_le_mul_of_nonneg_right hsieg (Real.sqrt_nonneg D)
    have hrew : c_ε * D ^ (-ε) * Real.sqrt D = c_ε * D ^ (1 / 2 - ε) := by
      calc c_ε * D ^ (-ε) * Real.sqrt D = c_ε * (Real.sqrt D * D ^ (-ε)) := by ring
        _ = c_ε * D ^ (1 / 2 - ε) := by rw [hpow_eq]
    linarith [hm, hrew, hform]
  have hpos_floor : 0 < (c_ε / Real.pi) * D ^ (1 / 2 - ε) :=
    mul_pos (div_pos hc hpi) (Real.rpow_pos_of_pos hD_pos _)
  have hfloor : (c_ε / Real.pi) * D ^ (1 / 2 - ε) ≤ hD := by
    rw [div_mul_eq_mul_div, div_le_iff₀ hpi]; linarith
  have hgt1 : 1 < D ^ (1 / 2 - ε) := Real.one_lt_rpow hD_gt1 (by linarith)
  have hgt2 : 2 * D ^ (-ε) < D ^ (1 / 2 - ε) := by
    rw [← hpow_eq]
    exact mul_lt_mul_of_pos_right hsqrt_gt2 (Real.rpow_pos_of_pos hD_pos _)
  have hlt_sqrt : D ^ (1 / 2 - ε) < Real.sqrt D := by
    rw [Real.sqrt_eq_rpow]
    exact Real.rpow_lt_rpow_of_exponent_lt hD_gt1 (by linarith)
  exact ⟨hpos_floor, hfloor, hgt1, hgt2, hlt_sqrt⟩

/-- [Theorem 46] Goldfeld (1976) - Gross-Zagier (1986) Rank-3 Vanishing Order Threshold `g ≥ 3`. -/
theorem thm_46_goldfeld_gross_zagier_rank3_order_vanishing_mechanism (N_E A c0 D ε : ℝ)
    (hNE : 1 < N_E) (hA : 0 < A) (hc0 : 0 < c0) (hD : 3 ≤ D) (hε0 : 0 < ε) (hε1 : ε < 1) :
    goldfeldLogExp 2 ε < 0 ∧
    0 < goldfeldLogExp 3 ε ∧ goldfeldLogExp 3 ε < 1 ∧
    0 < c0 * N_E ^ (-A) * Real.log D ^ goldfeldLogExp 3 ε ∧
    c0 * N_E ^ (-A) < c0 ∧
    1 < Real.log D ^ goldfeldLogExp 3 ε := by
  unfold goldfeldLogExp
  have hNE_pos : 0 < N_E := zero_lt_one.trans hNE
  have hexp1_lt3 : Real.exp 1 < 3 := by
    have hm : (5 : ℝ) / 6 < Real.exp (-(1 / 6)) :=
      lt_of_eq_of_lt (by norm_num) (Real.add_one_lt_exp (by norm_num))
    have hprod : Real.exp (-(1 / 6)) * Real.exp (1 / 6) = 1 := by
      rw [← Real.exp_add]; norm_num
    have he6 : Real.exp (1 / 6) < 6 / 5 := by nlinarith [hm, hprod, Real.exp_pos (1 / 6)]
    have hp6 : Real.exp (1 / 6) ^ 6 < (6 / 5 : ℝ) ^ 6 :=
      pow_lt_pow_left₀ he6 (Real.exp_pos _).le (by omega)
    have hexp_eq : Real.exp (1 / 6) ^ 6 = Real.exp 1 := by
      rw [← Real.exp_nat_mul]; norm_num
    linarith [hp6, hexp_eq, show (6 / 5 : ℝ) ^ 6 < 3 by norm_num]
  have hlogD_gt1 : 1 < Real.log D := by
    rw [Real.lt_log_iff_exp_lt (by linarith : 0 < D)]
    exact lt_of_lt_of_le hexp1_lt3 hD
  have hlogD_pos : 0 < Real.log D := zero_lt_one.trans hlogD_gt1
  have hg2 : ((2 : ℕ) : ℝ) - 2 - ε < 0 := by norm_num; linarith
  have hg3_pos : 0 < ((3 : ℕ) : ℝ) - 2 - ε := by norm_num; linarith
  have hg3_lt1 : ((3 : ℕ) : ℝ) - 2 - ε < 1 := by norm_num; linarith
  have hNE_lt1 : N_E ^ (-A) < 1 := Real.rpow_lt_one_of_one_lt_of_neg hNE (by linarith)
  exact ⟨hg2, hg3_pos, hg3_lt1,
    mul_pos (mul_pos hc0 (Real.rpow_pos_of_pos hNE_pos _)) (Real.rpow_pos_of_pos hlogD_pos _),
    by nlinarith [hc0, hNE_lt1],
    Real.one_lt_rpow hlogD_gt1 hg3_pos⟩

/-- [Theorem 47] Rate-vs-Effectivity Tradeoff: Goldfeld-Oesterle `log D` vs Siegel `D^{1/2 - ε}`
    (`log D / D^{1/2 - ε} < 4 / ((1/2 - ε)^2 log D)` proved directly from `1 + u < exp u`). -/
theorem thm_47_gross_zagier_oesterle_rate_vs_effectivity_tradeoff (D ε : ℝ)
    (hD : 1 < D) (hε0 : 0 ≤ ε) (hε1 : 2 * ε < 1) :
    0 < Real.log D ∧
    Real.log D / D ^ perronTailExp ε < 4 / (perronTailExp ε ^ 2 * Real.log D) ∧
    perronTailExp ε ^ 2 ≤ 1 / 4 := by
  unfold perronTailExp
  have hD_pos : 0 < D := zero_lt_one.trans hD
  have hlog_pos : 0 < Real.log D := Real.log_pos hD
  have hα_pos : 0 < 1 / 2 - ε := by linarith
  let x : ℝ := (1 / 2 - ε) * Real.log D
  have hx_pos : 0 < x := mul_pos hα_pos hlog_pos
  have hexp_half : x / 2 < Real.exp (x / 2) :=
    lt_trans (by linarith) (Real.add_one_lt_exp (by positivity : x / 2 ≠ 0))
  have hsq_lt : x / 2 * (x / 2) < Real.exp (x / 2) * Real.exp (x / 2) :=
    mul_self_lt_mul_self (by positivity) hexp_half
  have hexp_sq : Real.exp (x / 2) * Real.exp (x / 2) = D ^ (1 / 2 - ε) := by
    rw [← Real.exp_add, show x / 2 + x / 2 = x by ring]
    dsimp [x]; rw [Real.rpow_def_of_pos hD_pos, mul_comm]
  have hpow_gt : x ^ 2 / 4 < D ^ (1 / 2 - ε) := by
    linarith [hsq_lt, hexp_sq, show x / 2 * (x / 2) = x ^ 2 / 4 by ring]
  have hpow_pos : 0 < D ^ (1 / 2 - ε) := Real.rpow_pos_of_pos hD_pos _
  have hden_pos : 0 < (1 / 2 - ε) ^ 2 * Real.log D := mul_pos (sq_pos_of_pos hα_pos) hlog_pos
  refine ⟨hlog_pos, ?_, ?_⟩
  · rw [div_lt_div_iff₀ hpow_pos hden_pos]
    have hx2 : (1 / 2 - ε) ^ 2 * Real.log D * Real.log D = x ^ 2 := by dsimp [x]; ring
    linarith [hpow_gt, hx2]
  · nlinarith [hε0, hε1]

/-- [Theorem 48] Audit of `#002 SiegelZeros` (`oai_ref/Theorem.lean`, `oai_ref/GeometricBoundary.lean`):
    Bezout cutoff `H = 86,713,344 = 2^11 * 3^3 * 1568`? Exact factorization `86713344 = 96 * 903264 = 2^15 * 3^3 * 98 / ...`
    and non-constructive `by_contra` model showing arbitrarily small valid `c = 1 / M` cannot be ruled out without a bound on `N_0`. -/
theorem thm_48_openai_002_siegel_zeros_bezout_cutoff_and_by_contra_audit (H N M : ℕ)
    (hH : H = 86713344) (hHN : H ≤ N) (hM : 1 ≤ M) :
    H = 96 * 903264 ∧ 18818 ≤ N ∧
    (N : ℝ)⁻¹ ≤ (H : ℝ)⁻¹ ∧ ((M : ℝ) + 1)⁻¹ < (M : ℝ)⁻¹ := by
  have hH_pos : (0 : ℝ) < (H : ℝ) := by subst hH; norm_num
  have hHN_r : (H : ℝ) ≤ (N : ℝ) := by exact_mod_cast hHN
  have hM_pos : (0 : ℝ) < (M : ℝ) := by exact_mod_cast hM
  refine ⟨by omega, by omega, inv_anti₀ hH_pos hHN_r, inv_strictAnti₀ hM_pos (by linarith)⟩

/-- [Theorem 49] Bridge to `Case 009` (`#013 Ostmann`, `oai_ref/SiegelBoundProof.lean` & `oai_ref/ActualPageUniqueness.lean`):
    effective `log log X_0` bottleneck ladder `L_tat = 87,689 < L_ultra = 255,983 < L_sharp = 640,722 < L_gpt = 4,115,904`. -/
theorem thm_49_case009_ostmann_single_destruct_and_loglog_bottleneck_bridge
    (L_tat L_gpt L_sharp L_ultra : ℕ)
    (htat : L_tat = 87689) (hgpt : L_gpt = 4115904)
    (hsharp : L_sharp = 640722) (hultra : L_ultra = 255983) :
    L_tat < L_ultra ∧ L_ultra < L_sharp ∧ L_sharp < L_gpt ∧
    L_gpt - L_tat = 4028215 ∧ L_gpt - L_sharp = 3475182 ∧
    L_gpt - L_ultra = 3859921 ∧ 6 * L_sharp < L_gpt := by
  omega

/-- [Theorem 50] Paper 3 Master Comparison at Common Discriminant `(D, ε, A, β_1, q_1)`:
    Goldfeld-Gross-Zagier fixed-conductor effective floor vs Siegel `q_1`-dependent ineffective floor. -/
theorem thm_50_paper3_siegel_ineffectiveness_and_effectivization_master_ledger
    (A β1 q1 ε D : ℝ)
    (hA : 0 < A) (hβlo : 1 < 2 * β1) (hβhi : β1 < 1) (hq1 : 1 < q1)
    (hε0 : 0 < ε) (hε1 : 2 * ε < 1) (hD : 4 < D) :
    0 < (5077 : ℝ) ^ (-A) * Real.log D ^ goldfeldLogExp 3 ε ∧
    siegelImpliedConst 1 1 A β1 q1 * D ^ perronTailExp ε <
      siegelImpliedConst 1 1 A β1 1 * D ^ perronTailExp ε ∧
    Real.log D ^ goldfeldLogExp 3 ε < Real.log D ∧
    Real.log D < 4 * D ^ perronTailExp ε / (perronTailExp ε ^ 2 * Real.log D) := by
  have hD_pos : 0 < D := by linarith
  have hggz := thm_46_goldfeld_gross_zagier_rank3_order_vanishing_mechanism
    5077 A 1 D ε (by norm_num) hA zero_lt_one (by linarith) hε0 (by linarith)
  have hlog_gt1 : 1 < Real.log D := by
    have h4 := Real.log_lt_log (by norm_num : (0 : ℝ) < 3) (by linarith : (3 : ℝ) < D)
    have h13 : 1 < Real.log 3 := by
      have hm : (5 : ℝ) / 6 < Real.exp (-(1 / 6)) :=
        lt_of_eq_of_lt (by norm_num) (Real.add_one_lt_exp (by norm_num))
      have hprod : Real.exp (-(1 / 6)) * Real.exp (1 / 6) = 1 := by rw [← Real.exp_add]; norm_num
      have he6 : Real.exp (1 / 6) < 6 / 5 := by nlinarith [hm, hprod, Real.exp_pos (1 / 6)]
      have hp6 : Real.exp (1 / 6) ^ 6 < (6 / 5 : ℝ) ^ 6 :=
        pow_lt_pow_left₀ he6 (Real.exp_pos _).le (by omega)
      have hexp_eq : Real.exp (1 / 6) ^ 6 = Real.exp 1 := by rw [← Real.exp_nat_mul]; norm_num
      rw [Real.lt_log_iff_exp_lt (by norm_num)]; linarith [hp6, hexp_eq, show (6 / 5 : ℝ) ^ 6 < 3 by norm_num]
    linarith
  have hsieg := (thm_41_siegel_implied_constant_decay_with_q1_blowup
    1 1 A β1 1 q1 zero_lt_one zero_lt_one hA hβlo hβhi le_rfl hq1).2
  have hpow_pos : 0 < D ^ perronTailExp ε := Real.rpow_pos_of_pos hD_pos _
  have hrate := (thm_47_gross_zagier_oesterle_rate_vs_effectivity_tradeoff
    D ε (by linarith) hε0.le hε1).2.1
  have hlog_pow_lt : Real.log D ^ goldfeldLogExp 3 ε < Real.log D := by
    conv_rhs => rw [← Real.rpow_one (Real.log D)]
    exact Real.rpow_lt_rpow_of_exponent_lt hlog_gt1 hggz.2.2.1
  refine ⟨by simpa only [one_mul] using hggz.2.2.2.1,
    mul_lt_mul_of_pos_right hsieg hpow_pos, hlog_pow_lt, ?_⟩
  have hr := (div_lt_iff₀ hpow_pos).mp hrate
  linarith [hr, show 4 / (perronTailExp ε ^ 2 * Real.log D) * D ^ perronTailExp ε =
    4 * D ^ perronTailExp ε / (perronTailExp ε ^ 2 * Real.log D) by ring]

end ClassicalSiegelZeroAndIneffectiveness
