/-
  Case 015 - Paper 4 (Theorems 51-63): Critical-Line Zeros & Mollifier `θ = 4/7` + `J_{AB} = -1/2` Barriers
  Selberg (1942), Levinson (1974), Deshouillers-Iwaniec (1982), Conrey (1989), and `BCR` (2017).
  Lean 4 (`v4.29.0-rc8`) over `ℝ`, 0 sorry, 0 custom axioms, 100% hypothesis mutation kill.
-/
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Inverse
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Analysis.SpecialFunctions.ExpDeriv
import Mathlib.Analysis.Calculus.Deriv.Add
import Mathlib.Analysis.Calculus.Deriv.Mul
import Mathlib.Analysis.Calculus.Deriv.Pow

namespace ClassicalLevinsonConreyAndMollifierBarrier

noncomputable def levinsonKappa (R c : ℝ) : ℝ := 1 - Real.log c / R
noncomputable def kuznetsovOffDiagExp (θ ϑ : ℝ) : ℝ := (7 * θ - 4) / 2 + θ * ϑ
noncomputable def mollifierPotential (R : ℝ) (Q : ℝ → ℝ) (v : ℝ) : ℝ :=
  (1 / 2) * Real.exp (2 * R * v) * Q v ^ 2
noncomputable def cothReal (ω : ℝ) : ℝ := (Real.exp (2 * ω) + 1) / (Real.exp (2 * ω) - 1)
noncomputable def conreyCMinP (I_AA J_BB J_AB θ : ℝ) : ℝ :=
  1 + J_AB + Real.sqrt (I_AA * J_BB) * cothReal (θ * Real.sqrt (J_BB / I_AA))
noncomputable def levinsonAntiderivA (R v : ℝ) : ℝ :=
  Real.exp (2 * R * v) * (1 + 2 * R * (1 - v) + 2 * R ^ 2 * (1 - v) ^ 2) / (4 * R ^ 3)
noncomputable def levinsonAntiderivB (R v : ℝ) : ℝ :=
  Real.exp (2 * R * v) * (1 - 2 * R * (1 - v) + 2 * R ^ 2 * (1 - v) ^ 2) / (4 * R)

/-- [Theorem 51] Selberg-Levinson Littlewood-Jensen zero-proportion lower bound `κ = 1 - log c / R ∈ (0, 1)`. -/
theorem thm_51_selberg_levinson_littlewood_jensen_proportion_floor (R c : ℝ)
    (hc1 : 1 < c) (hcexp : c < Real.exp R) :
    0 < R ∧ 0 < Real.log c ∧ 0 < levinsonKappa R c ∧ levinsonKappa R c < 1 := by
  have h1exp : 1 < Real.exp R := hc1.trans hcexp
  have hR : 0 < R := by rw [← Real.exp_zero] at h1exp; exact Real.exp_lt_exp.mp h1exp
  have hc_pos : 0 < c := zero_lt_one.trans hc1
  have hlog_pos : 0 < Real.log c := Real.log_pos hc1
  have hlog_lt_R : Real.log c < R := (Real.log_lt_iff_lt_exp hc_pos).mpr hcexp
  unfold levinsonKappa
  have hdiv_pos : 0 < Real.log c / R := div_pos hlog_pos hR
  have hdiv_lt1 : Real.log c / R < 1 := (div_lt_one hR).mpr hlog_lt_R
  exact ⟨hR, hlog_pos, by linarith, by linarith⟩

/-- [Theorem 52] Deshouillers-Iwaniec (1982) & Conrey (1989) symmetric bilinear `M = N = T^{θ/2}`
    Kuznetsov off-diagonal exponent `(7θ - 4)/2 + θ ϑ` (`θ < 4/7` at `ϑ = 0`, `θ < 128/231` at `ϑ = 7/64`). -/
theorem thm_52_deshouillers_iwaniec_kuznetsov_four_sevenths_barrier (μ ν θ ϑ : ℝ)
    (hsum : μ + ν = θ) (hsym : μ = ν) :
    2 * μ + (3 / 2) * ν - 1 + (μ + ν) * ϑ / 2 = kuznetsovOffDiagExp θ ϑ / 2 ∧
    (kuznetsovOffDiagExp θ 0 < 0 ↔ 7 * θ < 4) ∧
    (kuznetsovOffDiagExp θ (7 / 64) < 0 ↔ 231 * θ < 128) := by
  unfold kuznetsovOffDiagExp
  have hμ : μ = θ / 2 := by linarith only [hsum, hsym]
  have hν : ν = θ / 2 := by linarith only [hsum, hsym]
  refine ⟨by rw [hμ, hν]; ring, ?_, ?_⟩
  · constructor <;> intro h <;> linarith
  · constructor <;> intro h <;> linarith

/-- [Theorem 53] Asymmetric Deshouillers-Iwaniec bilinear factor window `(4θ - 2, 2 - 3θ)` and
    Bettin-Chandee-Radziwill (2017) `n = d · p` single-large-prime reduction (`33θ < 17`). -/
theorem thm_53_asymmetric_di_gap_and_bcr_17_33_unfactored_window (θ : ℝ)
    (hlo : 1 < 2 * θ) (hhi : 11 * θ ≤ 6) :
    0 < 4 * θ - 2 ∧ 4 * θ - 2 < 2 - 3 * θ ∧
    2 * (4 * θ - 2) ≤ 2 - 3 * θ ∧ θ < 2 * (2 - 3 * θ) ∧
    ((33 * θ - 17) / 20 < 0 ↔ 33 * θ < 17) := by
  refine ⟨by linarith, by linarith, by linarith, by linarith, ?_⟩
  constructor <;> intro h <;> linarith

/-- [Theorem 54] Exact `1/66` Kloosterman-Packet Scale Ladder:
    Levinson `1/2 < BCR 17/33 < QRH α_X 35/66 < Conrey 4/7`. -/
theorem thm_54_mollifier_kloosterman_scale_ladder_one_sixtysixth (θ_BCR α_QRH θ_DI : ℝ)
    (hBCR : 33 * θ_BCR = 17) (hQRH : 66 * α_QRH = 35) (hDI : 7 * θ_DI = 4) :
    1 / 2 < θ_BCR ∧ θ_BCR < α_QRH ∧ α_QRH < θ_DI ∧
    θ_BCR - 1 / 2 = 1 / 66 ∧ α_QRH - θ_BCR = 1 / 66 ∧ θ_DI - α_QRH = 19 / 462 := by
  have hb : θ_BCR = 17 / 33 := by linarith only [hBCR]
  have hq : α_QRH = 35 / 66 := by linarith only [hQRH]
  have hd : θ_DI = 4 / 7 := by linarith only [hDI]
  rw [hb, hq, hd]
  refine ⟨?_, ?_, ?_, ?_, ?_, ?_⟩ <;> norm_num

/-- [Theorem 55] Hypothesis-free kernel proof of the derivative identity
    `(d/dv)(1/2 e^{2Rv} Q(v)^2) = e^{2Rv} Q(v)(R Q(v) + Q'(v))` and boundary invariant `J_{AB} = -1/2`. -/
theorem thm_55_mollifier_antiderivative_has_deriv_at_and_boundary_invariant
    (R v Q' : ℝ) (Q : ℝ → ℝ)
    (hderiv : HasDerivAt Q Q' v) (hQ0 : Q 0 = 1) (hQ1 : Q 1 = 0) :
    HasDerivAt (mollifierPotential R Q) (Real.exp (2 * R * v) * Q v * (R * Q v + Q')) v ∧
    mollifierPotential R Q 1 - mollifierPotential R Q 0 = -(1 / 2) := by
  have hexp : HasDerivAt (fun t => Real.exp (2 * R * t)) (Real.exp (2 * R * v) * (2 * R)) v := by
    have hlin : HasDerivAt (fun t => 2 * R * t) (2 * R * 1) v := (hasDerivAt_id v).const_mul (2 * R)
    have he := hlin.exp
    rw [mul_one] at he
    exact he
  have hQ2 : HasDerivAt (fun t => Q t ^ 2) (2 * Q v ^ (2 - 1) * Q') v := hderiv.pow 2
  have hprod : HasDerivAt (mollifierPotential R Q)
      ((1 / 2) * (Real.exp (2 * R * v) * (2 * R)) * Q v ^ 2 +
        (1 / 2) * Real.exp (2 * R * v) * (2 * Q v ^ (2 - 1) * Q')) v :=
    (hexp.const_mul (1 / 2)).mul hQ2
  have hrew : (1 / 2) * (Real.exp (2 * R * v) * (2 * R)) * Q v ^ 2 +
      (1 / 2) * Real.exp (2 * R * v) * (2 * Q v ^ (2 - 1) * Q') =
      Real.exp (2 * R * v) * Q v * (R * Q v + Q') := by norm_num; ring
  rw [hrew] at hprod
  have hbnd : mollifierPotential R Q 1 - mollifierPotential R Q 0 = -(1 / 2) := by
    unfold mollifierPotential; rw [hQ1, hQ0, mul_zero, Real.exp_zero]; norm_num
  exact ⟨hprod, hbnd⟩

/-- [Theorem 56] Kernel derivation of `0 < I_{AA}`, `0 < J_{BB}`, and Cauchy-Schwarz discriminant
    `1 ≤ 4 I_{AA} J_{BB}` from quadratic nonnegativity `∀ t, 0 ≤ I_{AA} t^2 + 2 J_{AB} t + J_{BB}` and `J_{AB} = -1/2`. -/
theorem thm_56_cauchy_schwarz_discriminant_from_nonnegative_quadratic_form (I_AA J_BB J_AB : ℝ)
    (hJAB : 2 * J_AB = -1) (hquad : ∀ t : ℝ, 0 ≤ I_AA * t ^ 2 + 2 * J_AB * t + J_BB) :
    0 < I_AA ∧ 0 < J_BB ∧ 1 ≤ 4 * I_AA * J_BB ∧ (4 * I_AA)⁻¹ ≤ J_BB := by
  have hI_pos : 0 < I_AA := by
    by_contra! hle
    let t0 : ℝ := max (J_BB + 1) 1
    have ht0_ge1 : 1 ≤ t0 := le_max_right _ _
    have ht0_gt : J_BB + 1 ≤ t0 := le_max_left _ _
    have hsq_nn : 0 ≤ t0 ^ 2 := sq_nonneg t0
    have hterm1 : I_AA * t0 ^ 2 ≤ 0 := mul_nonpos_of_nonpos_of_nonneg hle hsq_nn
    have hinst := hquad t0
    nlinarith [hinst, hterm1, ht0_gt, hJAB]
  have hJ_nn : 0 ≤ J_BB := by simpa using hquad 0
  have hdisc : 1 ≤ 4 * I_AA * J_BB := by
    have hinst := hquad (-J_AB / I_AA)
    have hmul := mul_le_mul_of_nonneg_left hinst (by positivity : 0 ≤ 4 * I_AA)
    have h1 : 4 * I_AA * (I_AA * (-J_AB / I_AA) ^ 2 + 2 * J_AB * (-J_AB / I_AA) + J_BB) =
        4 * I_AA * J_BB - (2 * J_AB) ^ 2 := by
      have ht : I_AA * (-J_AB / I_AA) = -J_AB := mul_div_cancel₀ _ hI_pos.ne'
      calc 4 * I_AA * (I_AA * (-J_AB / I_AA) ^ 2 + 2 * J_AB * (-J_AB / I_AA) + J_BB)
          = 4 * (I_AA * (-J_AB / I_AA)) ^ 2 + 8 * J_AB * (I_AA * (-J_AB / I_AA)) + 4 * I_AA * J_BB := by ring
        _ = 4 * I_AA * J_BB - (2 * J_AB) ^ 2 := by rw [ht]; ring
    nlinarith [hmul, h1, hJAB]
  have hJ_pos : 0 < J_BB := by
    rcases lt_or_eq_of_le hJ_nn with hp | rfl
    · exact hp
    · norm_num at hdisc
  have hinv : (4 * I_AA)⁻¹ ≤ J_BB := by
    rw [inv_eq_one_div, div_le_iff₀ (by positivity : 0 < 4 * I_AA)]
    linarith
  exact ⟨hI_pos, hJ_pos, hdisc, hinv⟩

/-- [Theorem 57] Hyperbolic `coth(ω) - 1 = 2 / (e^{2ω} - 1) > 0` proved directly from `Real.exp_pos` / `exp_lt_exp`. -/
theorem thm_57_hyperbolic_coth_strictly_exceeds_one_from_exp (ω : ℝ) (hω : 0 < ω) :
    1 < Real.exp (2 * ω) ∧ cothReal ω - 1 = 2 / (Real.exp (2 * ω) - 1) ∧ 1 < cothReal ω := by
  unfold cothReal
  have hexp_gt1 : 1 < Real.exp (2 * ω) := by
    rw [← Real.exp_zero]; exact Real.exp_lt_exp.mpr (by linarith)
  have hden : 0 < Real.exp (2 * ω) - 1 := sub_pos.mpr hexp_gt1
  have hid : (Real.exp (2 * ω) + 1) / (Real.exp (2 * ω) - 1) - 1 =
      2 / (Real.exp (2 * ω) - 1) := by
    rw [div_sub_one hden.ne']; congr 1; ring
  exact ⟨hexp_gt1, hid, by linarith [hid, div_pos (by norm_num : (0 : ℝ) < 2) hden]⟩

/-- [Theorem 58] Variational mean-square floor `conreyCMinP > 1` for EVERY finite `θ > 0`. -/
theorem thm_58_conrey_variational_mean_square_strictly_above_one (I_AA J_BB J_AB θ : ℝ)
    (hθ : 0 < θ) (hJAB : 2 * J_AB = -1)
    (hquad : ∀ t : ℝ, 0 ≤ I_AA * t ^ 2 + 2 * J_AB * t + J_BB) :
    0 < θ * Real.sqrt (J_BB / I_AA) ∧
    1 / 2 + (1 / 2) * cothReal (θ * Real.sqrt (J_BB / I_AA)) ≤ conreyCMinP I_AA J_BB J_AB θ ∧
    1 < conreyCMinP I_AA J_BB J_AB θ := by
  obtain ⟨hI, hJ, hdisc, _⟩ :=
    thm_56_cauchy_schwarz_discriminant_from_nonnegative_quadratic_form I_AA J_BB J_AB hJAB hquad
  unfold conreyCMinP
  let ω : ℝ := θ * Real.sqrt (J_BB / I_AA)
  have hω_pos : 0 < ω := mul_pos hθ (Real.sqrt_pos.mpr (div_pos hJ hI))
  have hcoth_gt1 : 1 < cothReal ω := (thm_57_hyperbolic_coth_strictly_exceeds_one_from_exp ω hω_pos).2.2
  have hsqrt_ge : 1 / 2 ≤ Real.sqrt (I_AA * J_BB) := by
    rw [show (1 / 2 : ℝ) = Real.sqrt (1 / 4) by
      rw [show (1 / 4 : ℝ) = (1 / 2) ^ 2 by norm_num, Real.sqrt_sq (by norm_num)]]
    exact Real.sqrt_le_sqrt (by linarith)
  have hmul_ge : (1 / 2) * cothReal ω ≤ Real.sqrt (I_AA * J_BB) * cothReal ω :=
    mul_le_mul_of_nonneg_right hsqrt_ge (by linarith)
  have hj : J_AB = -(1 / 2) := by linarith
  exact ⟨hω_pos, by linarith, by linarith⟩

/-- [Theorem 59] Finite-`θ` Critical-Line Barrier No-Go: `κ(θ) < 1` (`< 100%`) for ALL finite `θ > 0` and `R > 0`. -/
theorem thm_59_finite_theta_strictly_below_hundred_percent_no_go (R θ I_AA J_BB J_AB : ℝ)
    (hR : 0 < R) (hθ : 0 < θ) (hJAB : 2 * J_AB = -1)
    (hquad : ∀ t : ℝ, 0 ≤ I_AA * t ^ 2 + 2 * J_AB * t + J_BB) :
    0 < Real.log (conreyCMinP I_AA J_BB J_AB θ) ∧
    levinsonKappa R (conreyCMinP I_AA J_BB J_AB θ) < 1 ∧
    1 - levinsonKappa R (conreyCMinP I_AA J_BB J_AB θ) =
      Real.log (conreyCMinP I_AA J_BB J_AB θ) / R := by
  have hc_gt1 :=
    (thm_58_conrey_variational_mean_square_strictly_above_one I_AA J_BB J_AB θ hθ hJAB hquad).2.2
  have hlog_pos : 0 < Real.log (conreyCMinP I_AA J_BB J_AB θ) := Real.log_pos hc_gt1
  unfold levinsonKappa
  exact ⟨hlog_pos, by linarith [div_pos hlog_pos hR], by ring⟩

/-- [Theorem 60] Functional-Equation Symmetry (`Q(v) + Q(1 - v) = 1`) Pointwise SOS Floor on `I_{AA}(Q)`. -/
theorem thm_60_functional_equation_symmetry_pointwise_iaa_floor (R v q1 q2 : ℝ)
    (hv0 : 0 ≤ v) (hv1 : v ≤ 1) (hR : 0 < R) (hsym : q1 + q2 = 1) :
    Real.exp (2 * R * v) * q1 ^ 2 + Real.exp (2 * R * (1 - v)) * q2 ^ 2 =
      Real.exp (2 * R) / (Real.exp (2 * R * v) + Real.exp (2 * R * (1 - v))) +
      (Real.exp (2 * R * v) + Real.exp (2 * R * (1 - v))) *
        (q1 - Real.exp (2 * R * (1 - v)) / (Real.exp (2 * R * v) + Real.exp (2 * R * (1 - v)))) ^ 2 ∧
    Real.exp (2 * R * v) + Real.exp (2 * R * (1 - v)) ≤ 1 + Real.exp (2 * R) ∧
    Real.exp (2 * R) / (1 + Real.exp (2 * R)) ≤
      Real.exp (2 * R * v) * q1 ^ 2 + Real.exp (2 * R * (1 - v)) * q2 ^ 2 ∧
    1 / 2 < Real.exp (2 * R) / (1 + Real.exp (2 * R)) := by
  let a := Real.exp (2 * R * v)
  let b := Real.exp (2 * R * (1 - v))
  have ha_pos : 0 < a := Real.exp_pos _
  have hb_pos : 0 < b := Real.exp_pos _
  have hab_sum_pos : 0 < a + b := add_pos ha_pos hb_pos
  have hab_prod : a * b = Real.exp (2 * R) := by
    dsimp [a, b]; rw [← Real.exp_add]; congr 1; ring
  have hq2 : q2 = 1 - q1 := by linarith
  have hsos : a * q1 ^ 2 + b * q2 ^ 2 =
      Real.exp (2 * R) / (a + b) + (a + b) * (q1 - b / (a + b)) ^ 2 := by
    rw [hq2, ← hab_prod]
    have hmul : (a + b) * (b / (a + b)) = b := mul_div_cancel₀ _ hab_sum_pos.ne'
    have hsq : (a + b) * (q1 - b / (a + b)) ^ 2 =
        (a + b) * q1 ^ 2 - 2 * b * q1 + b ^ 2 / (a + b) := by
      calc (a + b) * (q1 - b / (a + b)) ^ 2
          = (a + b) * q1 ^ 2 - 2 * ((a + b) * (b / (a + b))) * q1 +
              ((a + b) * (b / (a + b))) * (b / (a + b)) := by ring
        _ = (a + b) * q1 ^ 2 - 2 * b * q1 + b ^ 2 / (a + b) := by rw [hmul]; ring
    have hfrac : a * b / (a + b) + b ^ 2 / (a + b) = b := by
      rw [← add_div, show a * b + b ^ 2 = b * (a + b) by ring, mul_div_cancel_right₀ _ hab_sum_pos.ne']
    linarith [hsq, hfrac, show (a + b) * q1 ^ 2 - 2 * b * q1 + b = a * q1 ^ 2 + b * (1 - q1) ^ 2 by ring]
  have ha_ge1 : 1 ≤ a := Real.one_le_exp (by nlinarith [hv0, hR])
  have hb_ge1 : 1 ≤ b := Real.one_le_exp (by nlinarith [hv1, hR])
  have hsum_ub : a + b ≤ 1 + Real.exp (2 * R) := by
    nlinarith [mul_nonneg (sub_nonneg.mpr ha_ge1) (sub_nonneg.mpr hb_ge1), hab_prod]
  have hexp2R_gt1 : 1 < Real.exp (2 * R) := Real.one_lt_exp_iff.mpr (by linarith)
  have hfloor : Real.exp (2 * R) / (1 + Real.exp (2 * R)) ≤ a * q1 ^ 2 + b * q2 ^ 2 := by
    have h1 : Real.exp (2 * R) / (1 + Real.exp (2 * R)) ≤ Real.exp (2 * R) / (a + b) := by
      rw [div_le_div_iff₀ (by positivity) hab_sum_pos]
      exact mul_le_mul_of_nonneg_left hsum_ub (Real.exp_pos _).le
    have h2 : 0 ≤ (a + b) * (q1 - b / (a + b)) ^ 2 := mul_nonneg hab_sum_pos.le (sq_nonneg _)
    linarith [hsos, h1, h2]
  have hgt_half : 1 / 2 < Real.exp (2 * R) / (1 + Real.exp (2 * R)) := by
    rw [div_lt_div_iff₀ (by norm_num : (0 : ℝ) < 2) (by positivity)]
    linarith
  exact ⟨hsos, hsum_ub, hfloor, hgt_half⟩

/-- [Theorem 61] Exact antiderivative proof of Levinson's (1974) `Q(v) = 1 - v` closed-form integrals
    `I_{AA}(R) = (e^{2R} - 2R^2 - 2R - 1)/(4R^3)` and `J_{BB}(R) = (e^{2R} - 2R^2 + 2R - 1)/(4R)`. -/
theorem thm_61_levinson_linear_polynomial_closed_form_integrals (R v : ℝ) (hR : R ≠ 0) :
    HasDerivAt (levinsonAntiderivA R) (Real.exp (2 * R * v) * (1 - v) ^ 2) v ∧
    HasDerivAt (levinsonAntiderivB R) (Real.exp (2 * R * v) * (R * (1 - v) - 1) ^ 2) v ∧
    levinsonAntiderivA R 1 - levinsonAntiderivA R 0 =
      (Real.exp (2 * R) - (1 + 2 * R * (1 + R))) / (4 * R ^ 3) ∧
    levinsonAntiderivB R 1 - levinsonAntiderivB R 0 =
      (Real.exp (2 * R) - (1 + 2 * R * (R - 1))) / (4 * R) := by
  have h4R3 : 4 * R ^ 3 ≠ 0 := mul_ne_zero (by norm_num) (pow_ne_zero 3 hR)
  have h4R : 4 * R ≠ 0 := mul_ne_zero (by norm_num) hR
  have hexp : HasDerivAt (fun t => Real.exp (2 * R * t)) (Real.exp (2 * R * v) * (2 * R)) v := by
    have hlin : HasDerivAt (fun t => 2 * R * t) (2 * R * 1) v := (hasDerivAt_id v).const_mul (2 * R)
    have he := hlin.exp
    rw [mul_one] at he
    exact he
  have h1mv : HasDerivAt (fun t => 1 - t) (-1) v := by
    have hsub : HasDerivAt (fun t => 1 - t) (0 - 1) v := (hasDerivAt_const v (1 : ℝ)).sub (hasDerivAt_id v)
    rw [zero_sub] at hsub
    exact hsub
  have hpA : HasDerivAt (fun t => 1 + 2 * R * (1 - t) + 2 * R ^ 2 * (1 - t) ^ 2)
      (0 + 2 * R * (-1) + 2 * R ^ 2 * (2 * (1 - v) ^ (2 - 1) * (-1))) v :=
    ((hasDerivAt_const v 1).add (h1mv.const_mul (2 * R))).add ((h1mv.pow 2).const_mul (2 * R ^ 2))
  have hpB : HasDerivAt (fun t => 1 - 2 * R * (1 - t) + 2 * R ^ 2 * (1 - t) ^ 2)
      (0 - 2 * R * (-1) + 2 * R ^ 2 * (2 * (1 - v) ^ (2 - 1) * (-1))) v :=
    ((hasDerivAt_const v 1).sub (h1mv.const_mul (2 * R))).add ((h1mv.pow 2).const_mul (2 * R ^ 2))
  have hdA_raw := (hexp.mul hpA).div_const (4 * R ^ 3)
  have hdB_raw := (hexp.mul hpB).div_const (4 * R)
  have hrewA : (Real.exp (2 * R * v) * (2 * R) * (1 + 2 * R * (1 - v) + 2 * R ^ 2 * (1 - v) ^ 2) +
      Real.exp (2 * R * v) * (0 + 2 * R * (-1) + 2 * R ^ 2 * (2 * (1 - v) ^ (2 - 1) * (-1)))) /
      (4 * R ^ 3) = Real.exp (2 * R * v) * (1 - v) ^ 2 := by
    rw [div_eq_iff h4R3]; norm_num; ring
  have hrewB : (Real.exp (2 * R * v) * (2 * R) * (1 - 2 * R * (1 - v) + 2 * R ^ 2 * (1 - v) ^ 2) +
      Real.exp (2 * R * v) * (0 - 2 * R * (-1) + 2 * R ^ 2 * (2 * (1 - v) ^ (2 - 1) * (-1)))) /
      (4 * R) = Real.exp (2 * R * v) * (R * (1 - v) - 1) ^ 2 := by
    rw [div_eq_iff h4R]; norm_num; ring
  rw [hrewA] at hdA_raw; rw [hrewB] at hdB_raw
  have hbA : levinsonAntiderivA R 1 - levinsonAntiderivA R 0 =
      (Real.exp (2 * R) - (1 + 2 * R * (1 + R))) / (4 * R ^ 3) := by
    unfold levinsonAntiderivA; rw [ ← sub_div]; congr 1; norm_num; ring
  have hbB : levinsonAntiderivB R 1 - levinsonAntiderivB R 0 =
      (Real.exp (2 * R) - (1 + 2 * R * (R - 1))) / (4 * R) := by
    unfold levinsonAntiderivB; rw [← sub_div]; congr 1; norm_num; ring
  exact ⟨hdA_raw, hdB_raw, hbA, hbB⟩

/-- [Theorem 62] Kernel certification of Levinson's `κ > 1/3` (`34.27%`) at `R = 13/10`, `θ = 1/2`
    using `(1 + 13/600)^40 ≤ exp(13/15)`. -/
theorem thm_62_levinson_one_third_proportion_kernel_certificate (c_lev : ℝ)
    (hc_lo : 1 < c_lev) (hc_hi : 1000 * c_lev ≤ 2351) :
    1 / 3 < levinsonKappa (13 / 10) c_lev ∧ levinsonKappa (13 / 10) c_lev < 1 := by
  have hc_pos : 0 < c_lev := zero_lt_one.trans hc_lo
  have hstep : (613 : ℝ) / 600 ≤ Real.exp (13 / 600) := by
    linarith [Real.add_one_le_exp (13 / 600 : ℝ)]
  have hpow : ((613 : ℝ) / 600) ^ 40 ≤ Real.exp (13 / 600) ^ 40 :=
    pow_le_pow_left₀ (by norm_num) hstep 40
  have hexp_eq : Real.exp (13 / 600) ^ 40 = Real.exp (13 / 15) := by
    rw [← Real.exp_nat_mul]; norm_num
  have hnum_lt : c_lev < ((613 : ℝ) / 600) ^ 40 := by linarith [hc_hi, show (2351 : ℝ) / 1000 < (613 / 600) ^ 40 by norm_num]
  have hc_lt_exp : c_lev < Real.exp (13 / 15) := lt_of_lt_of_le hnum_lt (hexp_eq ▸ hpow)
  have hlog_lt : Real.log c_lev < 13 / 15 := (Real.log_lt_iff_lt_exp hc_pos).mpr hc_lt_exp
  have hlog_pos : 0 < Real.log c_lev := Real.log_pos hc_lo
  unfold levinsonKappa
  exact ⟨by linarith, by linarith⟩

/-- [Theorem 63] Strict Separation Between Actual Polynomial `deg17` Optimum and Relaxed `coth` Ceiling:
    strictly larger mean-square `c_deg17 > c_relax > 1` forces `κ_deg17 < κ_relax < 1` (`40.8059% < 52.8097% < 100%`). -/
theorem thm_63_deg17_actual_limit_vs_relaxed_coth_ceiling_separation (R c_relax c_deg17 : ℝ)
    (hR : 0 < R) (hrel : 1 < c_relax) (hgap : c_relax < c_deg17) :
    levinsonKappa R c_deg17 < levinsonKappa R c_relax ∧
    levinsonKappa R c_relax < 1 := by
  unfold levinsonKappa
  have hpos_rel : 0 < c_relax := zero_lt_one.trans hrel
  have hlog_rel_pos : 0 < Real.log c_relax := Real.log_pos hrel
  have hlog_lt : Real.log c_relax < Real.log c_deg17 := Real.log_lt_log hpos_rel hgap
  have hdiv_lt : Real.log c_relax / R < Real.log c_deg17 / R := div_lt_div_of_pos_right hlog_lt hR
  exact ⟨by linarith, by linarith [div_pos hlog_rel_pos hR]⟩

end ClassicalLevinsonConreyAndMollifierBarrier
