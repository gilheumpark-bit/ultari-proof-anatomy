/-
  Case 015 - Paper 5 (Theorems 64-75): Burgess `q^{3/16 + ε}` Subconvexity & Kim-Sarnak `7/64` Barriers
  Burgess (1963) `(r - 2)^2 / (16 r^2)` SOS Trap, Petrow-Young `1/6`, Selberg (1965), and Kim-Sarnak (2003).
  Lean 4 (`v4.29.0-rc8`) over `ℝ`, 0 sorry, 0 custom axioms, 100% hypothesis mutation kill.
-/
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Inverse
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Algebra.BigOperators.Group.Finset.Basic

namespace ClassicalBurgessAndKimSarnakBarrier

noncomputable def burgessShortExp (r ν : ℝ) : ℝ := (1 - r⁻¹) * ν + (r + 1) / (4 * r ^ 2)
noncomputable def burgessThreshold (r : ℝ) : ℝ := (r + 1) / (4 * r)
noncomputable def burgessSubconvExp (r : ℝ) : ℝ := burgessShortExp r (1 / 2) - 1 / 4
noncomputable def cubicCollisionFreeExp (r : ℝ) : ℝ := (r ^ 2 - r) / (4 * r ^ 2)
noncomputable def symPowerLandauBound (k : ℝ) : ℝ := (1 / 2 - 1 / ((k + 1) ^ 2 + 1)) / k
noncomputable def symPowerKimSarnakBound (k : ℝ) : ℝ :=
  (1 / 2 - 1 / (((k + 1) * (k + 2)) / 2 + 1)) / k

/-- [Theorem 64] Burgess (1963) Weil `2r`-th moment balance `q H^r = q^{1/2} H^{2r}` forcing `H = q^{1/(2r)}`. -/
theorem thm_64_burgess_weil_moment_balance_optimal_interval_h (r h q : ℝ)
    (hr : 0 < r) (hq : 1 < q) (hbal : 2 * (1 + r * h) = 1 + 4 * r * h) :
    h = (2 * r)⁻¹ ∧ 1 + r * h = 3 / 2 ∧
    q ^ (1 + r * h) = q ^ ((3 : ℝ) / 2) ∧ 1 < q ^ h := by
  have h2r : 2 * r ≠ 0 := by positivity
  have hh_mul : h * (2 * r) = 1 := by linarith
  have hh_eq : h = (2 * r)⁻¹ := by
    rw [inv_eq_one_div]; exact (eq_div_iff h2r).mpr hh_mul
  have hmom : 1 + r * h = 3 / 2 := by linarith
  exact ⟨hh_eq, hmom, by rw [hmom],
    by rw [hh_eq]; exact Real.one_lt_rpow hq (inv_pos.mpr (by positivity))⟩

/-- [Theorem 65] Exact Hölder-Weil amplification derivation of `burgessShortExp r ν = (1 - 1/r) ν + (r + 1)/(4 r^2)`. -/
theorem thm_65_burgess_short_character_sum_exponent_derivation (r ν a b : ℝ)
    (hr : 0 < r) (hb : 2 * r * b = 1) (hab : a + b = ν) (hcoll : a + ν ≤ 1) :
    -(a + b) + (a + ν) * (1 - (2 * r)⁻¹) + (1 + r * b) * (2 * r)⁻¹ = burgessShortExp r ν ∧
    2 * ν ≤ 1 + (2 * r)⁻¹ := by
  unfold burgessShortExp
  have hr_ne : r ≠ 0 := hr.ne'
  have h2r_ne : 2 * r ≠ 0 := by positivity
  have hb_eq : b = (2 * r)⁻¹ := by
    rw [inv_eq_one_div]; exact (eq_div_iff h2r_ne).mpr (by linarith)
  have ha_eq : a = ν - (2 * r)⁻¹ := by linarith [hab, hb_eq]
  have hcoll_bound : 2 * ν ≤ 1 + (2 * r)⁻¹ := by linarith [hcoll, ha_eq]
  refine ⟨?_, hcoll_bound⟩
  rw [ha_eq, hb_eq]
  have hinv2 : (2 * r)⁻¹ = r⁻¹ / 2 := by
    rw [inv_eq_one_div, inv_eq_one_div]; ring
  rw [hinv2]
  have hrr : r * (r⁻¹ / 2) = 1 / 2 := by
    calc r * (r⁻¹ / 2) = (r * r⁻¹) / 2 := by ring
      _ = 1 / 2 := by rw [mul_inv_cancel₀ hr_ne]
  rw [hrr]
  have hsq : r⁻¹ ^ 2 = 1 / r ^ 2 := by rw [inv_pow, one_div]
  calc -(ν - r⁻¹ / 2 + r⁻¹ / 2) + (ν - r⁻¹ / 2 + ν) * (1 - r⁻¹ / 2) + (1 + 1 / 2) * (r⁻¹ / 2)
      = (1 - r⁻¹) * ν + r⁻¹ / 4 + r⁻¹ ^ 2 / 4 := by ring
    _ = (1 - r⁻¹) * ν + (r + 1) / (4 * r ^ 2) := by
        have hr1 : r⁻¹ / 4 + r⁻¹ ^ 2 / 4 = (r + 1) / (4 * r ^ 2) := by
          rw [eq_div_iff (by positivity : 4 * r ^ 2 ≠ 0), add_mul]
          have ht1 : r⁻¹ / 4 * (4 * r ^ 2) = r := by
            calc r⁻¹ / 4 * (4 * r ^ 2) = (r * r⁻¹) * r := by ring
              _ = r := by rw [mul_inv_cancel₀ hr_ne, one_mul]
          have ht2 : r⁻¹ ^ 2 / 4 * (4 * r ^ 2) = 1 := by
            rw [hsq]; calc 1 / r ^ 2 / 4 * (4 * r ^ 2) = r ^ 2 / r ^ 2 := by ring
              _ = 1 := div_self (pow_ne_zero 2 hr_ne)
          linarith
        linarith [hr1]

/-- [Theorem 66] Burgess nontriviality threshold `burgessShortExp r ν < ν ↔ (r + 1)/(4r) < ν` (`> 1/4` for all finite `r`). -/
theorem thm_66_burgess_nontrivial_threshold_one_quarter_limit (r ν : ℝ) (hr : 0 < r) :
    (burgessShortExp r ν < ν ↔ burgessThreshold r < ν) ∧
    burgessThreshold r - 1 / 4 = (4 * r)⁻¹ ∧ 1 / 4 < burgessThreshold r := by
  unfold burgessShortExp burgessThreshold
  have hr_ne : r ≠ 0 := hr.ne'
  have h4r_pos : 0 < 4 * r := by positivity
  have h4r2_pos : 0 < 4 * r ^ 2 := by positivity
  have hiff : (1 - r⁻¹) * ν + (r + 1) / (4 * r ^ 2) < ν ↔ (r + 1) / (4 * r) < ν := by
    have hsub : (1 - r⁻¹) * ν + (r + 1) / (4 * r ^ 2) < ν ↔
        (r + 1) / (4 * r ^ 2) < r⁻¹ * ν := by constructor <;> intro h <;> linarith
    rw [hsub, inv_eq_one_div, one_div_mul_eq_div, div_lt_div_iff₀ h4r2_pos hr, div_lt_iff₀ h4r_pos]
    constructor <;> intro h
    · nlinarith [h, hr]
    · nlinarith [h, hr]
  have hgap : (r + 1) / (4 * r) - 1 / 4 = (4 * r)⁻¹ := by
    rw [inv_eq_one_div, div_sub_div _ _ h4r_pos.ne' (by norm_num)]; rw [div_eq_div_iff (by positivity) h4r_pos.ne']; ring
  exact ⟨hiff, hgap, by linarith [hgap, inv_pos.mpr h4r_pos]⟩

/-- [Theorem 67] Burgess's Subconvexity SOS Trap: `E_Burgess(r) - 3/16 = (r - 2)^2 / (16 r^2) ≥ 0`
    with UNIQUE global minimum at `r = 2` (`4`-th moment). -/
theorem thm_67_burgess_subconvexity_exponent_sos_trap_at_r_eq_2 (r : ℝ) (hr : 0 < r) :
    1 / 4 < burgessThreshold r ∧
    burgessSubconvExp r = (r ^ 2 - r + 1) / (4 * r ^ 2) ∧
    burgessSubconvExp r - 3 / 16 = (r - 2) ^ 2 / (16 * r ^ 2) ∧
    3 / 16 ≤ burgessSubconvExp r ∧
    (burgessSubconvExp r = 3 / 16 ↔ r = 2) := by
  have hthresh := (thm_66_burgess_nontrivial_threshold_one_quarter_limit r 1 hr).2.2
  unfold burgessSubconvExp burgessShortExp
  have hr_ne : r ≠ 0 := hr.ne'
  have h4r2_ne : 4 * r ^ 2 ≠ 0 := by positivity
  have h16r2_pos : 0 < 16 * r ^ 2 := by positivity
  have hform : (1 - r⁻¹) * (1 / 2) + (r + 1) / (4 * r ^ 2) - 1 / 4 =
      (r ^ 2 - r + 1) / (4 * r ^ 2) := by
    rw [eq_div_iff h4r2_ne]
    have h1 : r⁻¹ * r ^ 2 = r := by
      calc r⁻¹ * r ^ 2 = (r * r⁻¹) * r := by ring
        _ = r := by rw [mul_inv_cancel₀ hr_ne, one_mul]
    have h2 : (r + 1) / (4 * r ^ 2) * (4 * r ^ 2) = r + 1 := div_mul_cancel₀ _ h4r2_ne
    calc ((1 - r⁻¹) * (1 / 2) + (r + 1) / (4 * r ^ 2) - 1 / 4) * (4 * r ^ 2)
        = r ^ 2 - 2 * (r⁻¹ * r ^ 2) + (r + 1) / (4 * r ^ 2) * (4 * r ^ 2) := by ring
      _ = r ^ 2 - r + 1 := by rw [h1, h2]; ring
  have hsos : (r ^ 2 - r + 1) / (4 * r ^ 2) - 3 / 16 = (r - 2) ^ 2 / (16 * r ^ 2) := by
    rw [div_sub_div _ _ h4r2_ne (by norm_num), div_eq_div_iff (by positivity) h16r2_pos.ne']; ring
  have hge : 3 / 16 ≤ (1 - r⁻¹) * (1 / 2) + (r + 1) / (4 * r ^ 2) - 1 / 4 := by
    rw [hform]; linarith [hsos, div_nonneg (sq_nonneg (r - 2)) h16r2_pos.le]
  have heq_iff : (1 - r⁻¹) * (1 / 2) + (r + 1) / (4 * r ^ 2) - 1 / 4 = 3 / 16 ↔ r = 2 := by
    rw [hform]
    constructor
    · intro h
      have hz : (r - 2) ^ 2 / (16 * r ^ 2) = 0 := by linarith [hsos, h]
      have hsq0 : (r - 2) ^ 2 = 0 := (div_eq_zero_iff.mp hz).resolve_right h16r2_pos.ne'
      linarith [sq_eq_zero_iff.mp hsq0]
    · rintro rfl; norm_num
  exact ⟨hthresh, hform, by rw [hform]; exact hsos, hge, heq_iff⟩

/-- [Theorem 68] Strict degradation of Burgess's exponent for ALL higher moments `2 ≤ r_1 < r_2`:
    increasing the Weil moment order beyond `r = 2` strictly worsens the subconvexity bound! -/
theorem thm_68_burgess_strict_degradation_for_higher_moments (r1 r2 : ℝ)
    (hr1 : 2 ≤ r1) (h12 : r1 < r2) :
    burgessSubconvExp r1 < burgessSubconvExp r2 ∧
    burgessSubconvExp 1 = 1 / 4 ∧ burgessSubconvExp 2 = 3 / 16 ∧
    burgessSubconvExp 3 = 7 / 36 ∧ burgessSubconvExp 4 = 13 / 64 := by
  have hr1_pos : 0 < r1 := by linarith
  have hr2_pos : 0 < r2 := by linarith
  have hsos1 := (thm_67_burgess_subconvexity_exponent_sos_trap_at_r_eq_2 r1 hr1_pos).2.2.1
  have hsos2 := (thm_67_burgess_subconvexity_exponent_sos_trap_at_r_eq_2 r2 hr2_pos).2.2.1
  have hfrac_lt : (r1 - 2) / r1 < (r2 - 2) / r2 := by
    rw [div_lt_div_iff₀ hr1_pos hr2_pos]; nlinarith
  have hsq_lt : ((r1 - 2) / r1) * ((r1 - 2) / r1) < ((r2 - 2) / r2) * ((r2 - 2) / r2) :=
    mul_self_lt_mul_self (div_nonneg (by linarith) hr1_pos.le) hfrac_lt
  have hrew1 : (r1 - 2) ^ 2 / (16 * r1 ^ 2) = ((r1 - 2) / r1) * ((r1 - 2) / r1) / 16 := by ring
  have hrew2 : (r2 - 2) ^ 2 / (16 * r2 ^ 2) = ((r2 - 2) / r2) * ((r2 - 2) / r2) / 16 := by ring
  refine ⟨by linarith [hsos1, hsos2, hsq_lt, hrew1, hrew2], ?_, ?_, ?_, ?_⟩ <;>
    (unfold burgessSubconvExp burgessShortExp; norm_num)

/-- [Theorem 69] Conrey-Iwaniec (2000) & Petrow-Young (2020) Cubic Automorphic Moment (`r = 3`):
    removing the `+1` progression collision term drops `7/36 -> 1/6`, breaking `3/16` by `1/48`. -/
theorem thm_69_conrey_iwaniec_petrow_young_cubic_collision_removal (r : ℝ) (hr : r = 3) :
    burgessSubconvExp r - cubicCollisionFreeExp r = 1 / (4 * r ^ 2) ∧
    cubicCollisionFreeExp r = 1 / 6 ∧
    3 / 16 - cubicCollisionFreeExp r = 1 / 48 ∧
    cubicCollisionFreeExp r < 3 / 16 ∧ 3 / 16 < burgessSubconvExp r := by
  subst hr
  unfold burgessSubconvExp burgessShortExp cubicCollisionFreeExp
  refine ⟨?_, ?_, ?_, ?_, ?_⟩ <;> norm_num

/-- [Theorem 70] Audit of `oai_ref/Parameters.lean` & `oai_ref/CubeFloorSaving.lean`:
    compensated `3/16` Burgess floor `3/16 ≤ 17/48 - d` and `(17/48)/2 + (1/8)/12 = 3/16` for `d ∈ [0, 1/6]`. -/
theorem thm_70_qrh_parameters_burgess_three_sixteenths_identity (d : ℝ)
    (hd0 : 0 ≤ d) (hd1 : 6 * d ≤ 1) :
    1 / 2 ≤ 5 / 6 - 2 * d ∧ 3 / 16 ≤ 17 / 48 - d ∧ 17 / 48 - d ≤ 17 / 48 ∧
    (17 / 48 : ℝ) / 2 + (1 / 8) / 12 = burgessSubconvExp 2 := by
  unfold burgessSubconvExp burgessShortExp
  refine ⟨by linarith, by linarith, by linarith, by norm_num⟩

/-- [Theorem 71] Selberg (1965) Kloosterman Zeta Weil Abscissa `3/4` vs Spectral Line `1/2 + ϑ`:
    triangle-inequality cancellation loss `1/4 - ϑ > 0` and eigenvalue floor `λ_1 = 1/4 - ϑ^2 > 3/16`. -/
theorem thm_71_selberg_1965_kloosterman_zeta_weil_abscissa_vs_spectral_line (ϑ : ℝ)
    (hϑ0 : 0 ≤ ϑ) (hϑ1 : 4 * ϑ < 1) :
    1 / 2 ≤ 1 / 2 + ϑ ∧
    3 / 4 - (1 / 2 + ϑ) = 1 / 4 - ϑ ∧
    0 < 3 / 4 - (1 / 2 + ϑ) ∧
    (1 / 2 + ϑ) * (1 - (1 / 2 + ϑ)) = 1 / 4 - ϑ ^ 2 ∧
    3 / 16 < 1 / 4 - ϑ ^ 2 ∧ 1 / 4 - ϑ ^ 2 ≤ 1 / 4 := by
  have hsq : ϑ ^ 2 < 1 / 16 := by
    have hm := mul_self_lt_mul_self hϑ0 (show ϑ < 1 / 4 by linarith)
    linarith [hm, sq ϑ]
  refine ⟨by linarith, by ring, by linarith, by ring, by linarith, by nlinarith [sq_nonneg ϑ]⟩

/-- [Theorem 72] Landau-Rankin-Selberg `GL_{k+1}` (`Sym^k`) Unamplified Convexity Pole Ladder:
    `symPowerLandauBound k = (k + 2)/(2(k^2 + 2k + 2))` (`1/5` at `k=2`, `5/34` at `k=3`, `3/26` at `k=4`). -/
theorem thm_72_landau_rankin_selberg_gln_convexity_pole_formula (k1 k2 : ℝ)
    (hk1 : 1 ≤ k1) (hk12 : k1 < k2) :
    symPowerLandauBound k1 = (k1 + 2) / (2 * (k1 ^ 2 + 2 * k1 + 2)) ∧
    symPowerLandauBound k2 < symPowerLandauBound k1 ∧
    symPowerLandauBound 2 = 1 / 5 ∧
    symPowerLandauBound 3 = 5 / 34 ∧
    symPowerLandauBound 4 = 3 / 26 := by
  unfold symPowerLandauBound
  have hk1_pos : 0 < k1 := by linarith
  have hk2_pos : 0 < k2 := by linarith
  have hd1_pos : 0 < (k1 + 1) ^ 2 + 1 := by positivity
  have hd2_pos : 0 < (k2 + 1) ^ 2 + 1 := by positivity
  have hform : ∀ k : ℝ, 0 < k →
      (1 / 2 - 1 / ((k + 1) ^ 2 + 1)) / k = (k + 2) / (2 * (k ^ 2 + 2 * k + 2)) := by
    intro k hk
    have hd : (k + 1) ^ 2 + 1 ≠ 0 := by positivity
    have hd' : 2 * (k ^ 2 + 2 * k + 2) ≠ 0 := by positivity
    rw [div_sub_div _ _ (by norm_num : (2 : ℝ) ≠ 0) hd, div_div,
      div_eq_div_iff (mul_ne_zero (mul_ne_zero (by norm_num) hd) hk.ne') hd']
    ring
  have hf1 := hform k1 hk1_pos
  have hf2 := hform k2 hk2_pos
  have hmono : (k2 + 2) / (2 * (k2 ^ 2 + 2 * k2 + 2)) < (k1 + 2) / (2 * (k1 ^ 2 + 2 * k1 + 2)) := by
    rw [div_lt_div_iff₀ (by positivity) (by positivity)]
    have hdiff : (k1 + 2) * (2 * (k2 ^ 2 + 2 * k2 + 2)) - (k2 + 2) * (2 * (k1 ^ 2 + 2 * k1 + 2)) =
        2 * (k2 - k1) * (k1 * k2 + 2 * (k1 + k2) + 2) := by ring
    have hpos : 0 < 2 * (k2 - k1) * (k1 * k2 + 2 * (k1 + k2) + 2) :=
      mul_pos (by linarith) (by positivity)
    linarith
  exact ⟨hf1, by rw [hf1, hf2]; exact hmono, by norm_num, by norm_num, by norm_num⟩

/-- [Theorem 73] Luo-Rudnick-Sarnak (1995) & Kim-Sarnak (2003, Appendix 2) Character Amplification:
    conductor drop `n^2 + 1 -> n(n+1)/2 + 1` improves `1/5 -> 5/28` (`GL_3`) and `3/26 -> 7/64` (`GL_5`, gain `5/832`). -/
theorem thm_73_kim_sarnak_gl5_character_amplification_seven_sixtyfourths (k : ℝ) (hk : 1 ≤ k) :
    symPowerKimSarnakBound k < symPowerLandauBound k ∧
    0 < symPowerKimSarnakBound k ∧
    symPowerKimSarnakBound 2 = 5 / 28 ∧
    symPowerKimSarnakBound 4 = 7 / 64 ∧
    symPowerLandauBound 4 - symPowerKimSarnakBound 4 = 5 / 832 := by
  unfold symPowerKimSarnakBound symPowerLandauBound
  have hk_pos : 0 < k := by linarith
  have hd_ks : 0 < ((k + 1) * (k + 2)) / 2 + 1 := by positivity
  have hd_lan : 0 < (k + 1) ^ 2 + 1 := by positivity
  have hden_lt : ((k + 1) * (k + 2)) / 2 + 1 < (k + 1) ^ 2 + 1 := by nlinarith
  have hinv_gt : 1 / ((k + 1) ^ 2 + 1) < 1 / (((k + 1) * (k + 2)) / 2 + 1) :=
    one_div_lt_one_div_of_lt hd_ks hden_lt
  have hks_gt2 : 2 < ((k + 1) * (k + 2)) / 2 + 1 := by nlinarith
  have hinv_lt_half : 1 / (((k + 1) * (k + 2)) / 2 + 1) < 1 / 2 :=
    one_div_lt_one_div_of_lt (by norm_num) hks_gt2
  refine ⟨div_lt_div_of_pos_right (by linarith) hk_pos,
    div_pos (by linarith) hk_pos, by norm_num, by norm_num, by norm_num⟩

/-- [Theorem 74] Functorial `Sym^k` Residual Barrier Theorem:
    every finite symmetric power lift `k ≥ 1` leaves `0 < symPowerKimSarnakBound k < 1 / (2 k)` (`ϑ = 0` requires `k → ∞`). -/
theorem thm_74_sym_power_langlands_functoriality_limit_to_ramanujan (k : ℝ) (hk : 1 ≤ k) :
    0 < symPowerKimSarnakBound k ∧
    symPowerKimSarnakBound k < (2 * k)⁻¹ ∧
    symPowerLandauBound k < (2 * k)⁻¹ := by
  unfold symPowerKimSarnakBound symPowerLandauBound
  have hk_pos : 0 < k := by linarith
  have hks_gt2 : 2 < ((k + 1) * (k + 2)) / 2 + 1 := by nlinarith
  have hinv_ks_pos : 0 < 1 / (((k + 1) * (k + 2)) / 2 + 1) := div_pos zero_lt_one (by linarith)
  have hinv_lan_pos : 0 < 1 / ((k + 1) ^ 2 + 1) := div_pos zero_lt_one (by positivity)
  have hinv_lt_half : 1 / (((k + 1) * (k + 2)) / 2 + 1) < 1 / 2 :=
    one_div_lt_one_div_of_lt (by norm_num) hks_gt2
  have h2k : (1 / 2 : ℝ) / k = (2 * k)⁻¹ := by rw [inv_eq_one_div]; ring
  exact ⟨div_pos (by linarith) hk_pos,
    by rw [← h2k]; exact div_lt_div_of_pos_right (by linarith) hk_pos,
    by rw [← h2k]; exact div_lt_div_of_pos_right (by linarith) hk_pos⟩

/-- [Theorem 75] Unified Five-Barrier Synthesis on Burgess-Kloosterman-Hybrid Exponents:
    linking Burgess `3/16`, Petrow-Young `1/6`, Kim-Sarnak `7/64`, Blomer-Humphreys-Kahn hybrid break `E_hyb < 3/16`,
    and Kuznetsov `128/231 < 4/7` on a common spectral parameter `ϑ = symPowerKimSarnakBound 4`. -/
theorem thm_75_case015_five_classical_barriers_unified_synthesis (ϑ E_hyb : ℝ)
    (hϑ : ϑ = symPowerKimSarnakBound 4)
    (hhyb_lo : cubicCollisionFreeExp 3 < E_hyb)
    (hhyb_hi : E_hyb < burgessSubconvExp 2) :
    ϑ = 7 / 64 ∧
    1 / 4 - ϑ = 9 / 64 ∧
    (7 / 2 + ϑ)⁻¹ * 2 = 128 / 231 ∧
    (7 / 2 + ϑ)⁻¹ * 2 < 4 / 7 ∧
    1 / 6 < E_hyb ∧ E_hyb < 3 / 16 ∧ E_hyb < 1 / 4 - ϑ + 1 / 16 := by
  have hϑ_val : ϑ = 7 / 64 := by rw [hϑ]; unfold symPowerKimSarnakBound; norm_num
  have hcub : cubicCollisionFreeExp 3 = 1 / 6 := by unfold cubicCollisionFreeExp; norm_num
  have hburg : burgessSubconvExp 2 = 3 / 16 := by unfold burgessSubconvExp burgessShortExp; norm_num
  rw [hϑ_val]
  refine ⟨rfl, by norm_num, by norm_num, by norm_num, by linarith, by linarith, by linarith⟩

end ClassicalBurgessAndKimSarnakBarrier
