/-
  Case 015 - Paper 2 Part B (Theorems 26-35): Guth-Maynard (2024) & QRH Gram Energy Bridges
  `σ*_GM = 7/10 => A = 30/13`, `17/30` Prime Gap, `det_3` Collapse, and `Case 001`/`005` Gram Slacks.
  Lean 4 (`v4.29.0-rc8`) over `ℝ`, 0 sorry, 0 custom axioms, 100% hypothesis mutation kill.
-/
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Algebra.BigOperators.Group.Finset.Basic

namespace ClassicalGuthMaynardAndQrhGram

def gmDiagExp (σ ν : ℝ) : ℝ := ν * (2 - 2 * σ)
noncomputable def gmMidExp (σ ν : ℝ) : ℝ := ν * (18 / 5 - 4 * σ)
noncomputable def gmLVExp (σ ν : ℝ) : ℝ := 1 + ν * (12 / 5 - 4 * σ)
noncomputable def gmSlope (σ : ℝ) : ℝ := 15 / (5 * σ + 3)
noncomputable def gmExp (σ : ℝ) : ℝ := 15 * (1 - σ) / (5 * σ + 3)
noncomputable def gmClassIICutoff (σ : ℝ) : ℝ := 2 * (5 * σ - 3) / ((2 * σ - 1) * (5 * σ + 3))
noncomputable def inghamSlope2 (σ : ℝ) : ℝ := 3 / (2 - σ)
noncomputable def huxleySlope2 (σ : ℝ) : ℝ := 3 / (3 * σ - 1)
def det3 (u v w : ℕ → ℝ) : ℝ :=
  u 0 * (v 1 * w 2 - v 2 * w 1) - u 1 * (v 0 * w 2 - v 2 * w 0) + u 2 * (v 0 * w 1 - v 1 * w 0)

/-- [Theorem 26] Guth-Maynard `A_GM(σ) = 15 / (5σ + 3)` and SOS Middle-Term Margin `250(σ - 3/4)^2 + 3/8`. -/
theorem thm_26_guth_maynard_k2_k3_amplification_and_sos_middle_margin (σ ν2 : ℝ)
    (hσlo : 7 ≤ 10 * σ) (hσhi : 10 * σ ≤ 9) (hbal : gmLVExp σ (2 * ν2) = gmDiagExp σ (3 * ν2)) :
    ν2 = 5 / (2 * (5 * σ + 3)) ∧ 1 ≤ 3 * ν2 ∧ gmDiagExp σ (3 * ν2) = gmExp σ ∧
    gmExp σ = gmSlope σ * (1 - σ) ∧ ν2 ≤ gmClassIICutoff σ ∧
    gmClassIICutoff σ - ν2 = (10 * σ - 7) / (2 * (2 * σ - 1) * (5 * σ + 3)) ∧
    gmExp σ - gmMidExp σ (2 * gmClassIICutoff σ) =
      (250 * (σ - 3 / 4) ^ 2 + 3 / 8) / (5 * (2 * σ - 1) * (5 * σ + 3)) ∧
    0 < gmExp σ - gmMidExp σ (2 * gmClassIICutoff σ) := by
  unfold gmLVExp gmDiagExp gmExp gmSlope gmClassIICutoff gmMidExp at *
  have h2σ1 : 0 < 2 * σ - 1 := by linarith only [hσlo]
  have h5σ3 : 0 < 5 * σ + 3 := by linarith only [hσlo]
  have h2_5σ3 : 0 < 2 * (5 * σ + 3) := by positivity
  have hprod : 0 < (2 * σ - 1) * (5 * σ + 3) := mul_pos h2σ1 h5σ3
  have h5prod : 0 < 5 * (2 * σ - 1) * (5 * σ + 3) := by positivity
  have hν_eq : ν2 * (2 * (5 * σ + 3)) = 5 := by linarith only [hbal]
  have hν_val : ν2 = 5 / (2 * (5 * σ + 3)) := (eq_div_iff h2_5σ3.ne').mpr hν_eq
  have h3ν_ge1 : 1 ≤ 3 * ν2 := by
    rw [hν_val, show 3 * (5 / (2 * (5 * σ + 3))) = 15 / (2 * (5 * σ + 3)) by ring, le_div_iff₀ h2_5σ3]
    linarith only [hσhi]
  have hexp : 3 * ν2 * (2 - 2 * σ) = 15 * (1 - σ) / (5 * σ + 3) := by
    rw [eq_div_iff h5σ3.ne']
    calc 3 * ν2 * (2 - 2 * σ) * (5 * σ + 3) = 3 * (1 - σ) * (ν2 * (2 * (5 * σ + 3))) := by ring
      _ = 15 * (1 - σ) := by rw [hν_eq]; ring
  have hden : 2 * (2 * σ - 1) * (5 * σ + 3) ≠ 0 := by positivity
  have hgap : 2 * (5 * σ - 3) / ((2 * σ - 1) * (5 * σ + 3)) - ν2 =
      (10 * σ - 7) / (2 * (2 * σ - 1) * (5 * σ + 3)) := by
    rw [hν_val, div_sub_div _ _ hprod.ne' h2_5σ3.ne']
    rw [div_eq_div_iff (mul_ne_zero hprod.ne' h2_5σ3.ne') hden]; ring
  have hgap_nn : 0 ≤ (10 * σ - 7) / (2 * (2 * σ - 1) * (5 * σ + 3)) :=
    div_nonneg (by linarith only [hσlo]) (by positivity)
  have hsos : 15 * (1 - σ) / (5 * σ + 3) -
      2 * (2 * (5 * σ - 3) / ((2 * σ - 1) * (5 * σ + 3))) * (18 / 5 - 4 * σ) =
      (250 * (σ - 3 / 4) ^ 2 + 3 / 8) / (5 * (2 * σ - 1) * (5 * σ + 3)) := by
    rw [eq_div_iff h5prod.ne']
    have ht1 : 15 * (1 - σ) / (5 * σ + 3) * (5 * (2 * σ - 1) * (5 * σ + 3)) =
        75 * (1 - σ) * (2 * σ - 1) := by
      calc 15 * (1 - σ) / (5 * σ + 3) * (5 * (2 * σ - 1) * (5 * σ + 3)) =
            5 * (2 * σ - 1) * ((5 * σ + 3) * (15 * (1 - σ) / (5 * σ + 3))) := by ring
        _ = 75 * (1 - σ) * (2 * σ - 1) := by rw [mul_div_cancel₀ _ h5σ3.ne']; ring
    have ht2 : 2 * (2 * (5 * σ - 3) / ((2 * σ - 1) * (5 * σ + 3))) * (18 / 5 - 4 * σ) *
        (5 * (2 * σ - 1) * (5 * σ + 3)) = 4 * (5 * σ - 3) * (18 - 20 * σ) := by
      calc 2 * (2 * (5 * σ - 3) / ((2 * σ - 1) * (5 * σ + 3))) * (18 / 5 - 4 * σ) *
            (5 * (2 * σ - 1) * (5 * σ + 3)) =
            2 * (18 - 20 * σ) * (((2 * σ - 1) * (5 * σ + 3)) *
              (2 * (5 * σ - 3) / ((2 * σ - 1) * (5 * σ + 3)))) := by ring
        _ = 4 * (5 * σ - 3) * (18 - 20 * σ) := by rw [mul_div_cancel₀ _ hprod.ne']; ring
    calc (15 * (1 - σ) / (5 * σ + 3) -
          2 * (2 * (5 * σ - 3) / ((2 * σ - 1) * (5 * σ + 3))) * (18 / 5 - 4 * σ)) *
          (5 * (2 * σ - 1) * (5 * σ + 3)) =
          75 * (1 - σ) * (2 * σ - 1) - 4 * (5 * σ - 3) * (18 - 20 * σ) := by rw [sub_mul, ht1, ht2]
      _ = 250 * (σ - 3 / 4) ^ 2 + 3 / 8 := by ring
  exact ⟨hν_val, h3ν_ge1, hexp, by ring, by linarith only [hgap, hgap_nn], hgap, hsos,
    by rw [hsos]; exact div_pos (by positivity) h5prod⟩

/-- [Theorem 27] Strict Monotonicity of `A_GM(σ)` and Exact `σ = 4/5` Crossover with Huxley. -/
theorem thm_27_guth_maynard_vs_huxley_exact_four_fifths_crossover (σ1 σ2 : ℝ)
    (h1 : 1 < 2 * σ1) (h12 : σ1 < σ2) (h2 : 5 * σ2 ≤ 4) :
    15 / 7 ≤ gmSlope σ2 ∧ gmSlope σ2 < gmSlope σ1 ∧ gmSlope σ1 < 30 / 11 ∧
    huxleySlope2 σ1 - gmSlope σ1 = 6 * (4 - 5 * σ1) / ((3 * σ1 - 1) * (5 * σ1 + 3)) ∧
    gmSlope σ1 < huxleySlope2 σ1 ∧ gmSlope σ2 ≤ huxleySlope2 σ2 := by
  unfold gmSlope huxleySlope2
  have hg1 : 0 < 5 * σ1 + 3 := by linarith only [h1]
  have hg2 : 0 < 5 * σ2 + 3 := by linarith only [h1, h12]
  have hh1 : 0 < 3 * σ1 - 1 := by linarith only [h1]
  have hh2 : 0 < 3 * σ2 - 1 := by linarith only [h1, h12]
  have hdiff1 : 3 / (3 * σ1 - 1) - 15 / (5 * σ1 + 3) =
      6 * (4 - 5 * σ1) / ((3 * σ1 - 1) * (5 * σ1 + 3)) := by
    rw [div_sub_div _ _ hh1.ne' hg1.ne']; congr 1; ring
  have hpos1 : 0 < 6 * (4 - 5 * σ1) / ((3 * σ1 - 1) * (5 * σ1 + 3)) :=
    div_pos (by linarith only [h12, h2]) (mul_pos hh1 hg1)
  exact ⟨by rw [div_le_div_iff₀ (by norm_num : (0 : ℝ) < 7) hg2]; linarith only [h2],
    by rw [div_lt_div_iff₀ hg2 hg1]; linarith only [h12],
    by rw [div_lt_div_iff₀ hg1 (by norm_num : (0 : ℝ) < 11)]; linarith only [h1], hdiff1,
    by linarith only [hdiff1, hpos1], by rw [div_le_div_iff₀ hg2 hh2]; linarith only [h2]⟩

/-- [Theorem 28] Guth-Maynard-Ingham-Huxley Global Minimax Envelope (`σ*_GM = 7/10 => A = 30/13`). -/
theorem thm_28_guth_maynard_ingham_seven_tenths_minimax_envelope (σ : ℝ)
    (hlo : 1 ≤ 2 * σ) (hhi : σ ≤ 1) :
    2 ≤ inghamSlope2 σ ∧ 0 ≤ inghamSlope2 σ * (1 - σ) ∧ min (inghamSlope2 σ) (gmSlope σ) ≤ 30 / 13 ∧
    min (inghamSlope2 σ) (min (gmSlope σ) (huxleySlope2 σ)) ≤ 30 / 13 ∧
    (min (inghamSlope2 σ) (min (gmSlope σ) (huxleySlope2 σ)) = 30 / 13 ↔ 10 * σ = 7) := by
  unfold inghamSlope2 gmSlope huxleySlope2
  have h2mσ : 0 < 2 - σ := by linarith only [hhi]
  have h5σ3 : 0 < 5 * σ + 3 := by linarith only [hlo]
  have h3σ1 : 0 < 3 * σ - 1 := by linarith only [hlo]
  have hub2 : min (3 / (2 - σ)) (15 / (5 * σ + 3)) ≤ 30 / 13 := by
    rcases le_or_gt (10 * σ) 7 with hle | hgt
    · refine le_trans (min_le_left _ _) ?_; rw [div_le_iff₀ h2mσ]; linarith only [hle]
    · refine le_trans (min_le_right _ _) ?_; rw [div_le_iff₀ h5σ3]; linarith only [hgt]
  have hub3 : min (3 / (2 - σ)) (min (15 / (5 * σ + 3)) (3 / (3 * σ - 1))) ≤ 30 / 13 :=
    le_trans (min_le_min_left _ (min_le_left _ _)) hub2
  refine ⟨by rw [le_div_iff₀ h2mσ]; linarith only [hlo],
    mul_nonneg (div_nonneg (by norm_num) h2mσ.le) (by linarith only [hhi]), hub2, hub3, ?_⟩
  constructor
  · intro hm; rcases lt_trichotomy (10 * σ) 7 with hlt | heq | hgt
    · have h1 : 3 / (2 - σ) < 30 / 13 := by rw [div_lt_iff₀ h2mσ]; linarith only [hlt]
      have h2 : min (3 / (2 - σ)) (min (15 / (5 * σ + 3)) (3 / (3 * σ - 1))) < 30 / 13 :=
        lt_of_le_of_lt (min_le_left _ _) h1
      linarith only [hm, h2]
    · exact heq
    · have h1 : 15 / (5 * σ + 3) < 30 / 13 := by rw [div_lt_iff₀ h5σ3]; linarith only [hgt]
      have h2 : min (15 / (5 * σ + 3)) (3 / (3 * σ - 1)) < 30 / 13 := lt_of_le_of_lt (min_le_left _ _) h1
      have h3 : min (3 / (2 - σ)) (min (15 / (5 * σ + 3)) (3 / (3 * σ - 1))) < 30 / 13 :=
        lt_of_le_of_lt (min_le_right _ _) h2
      linarith only [hm, h3]
  · intro h10_7
    have h1 : 3 / (2 - σ) = 30 / 13 := by rw [div_eq_iff h2mσ.ne']; linarith only [h10_7]
    have h2 : 15 / (5 * σ + 3) = 30 / 13 := by rw [div_eq_iff h5σ3.ne']; linarith only [h10_7]
    have h3 : 3 / (3 * σ - 1) = 30 / 11 := by rw [div_eq_iff h3σ1.ne']; linarith only [h10_7]
    rw [h1, h2, h3, min_eq_left (by norm_num : (30 : ℝ) / 13 ≤ 30 / 11), min_self]

/-- [Theorem 29] Inflection Shift (`3/4 -> 7/10`), Saving (`6/65`), and `17/30` Prime-Gap Law. -/
theorem thm_29_inflection_shift_barrier_saving_and_seventeen_thirtieths_prime_gap (σ_IH σ_GM : ℝ)
    (hIH : 4 * σ_IH = 3) (hGM : 10 * σ_GM = 7) :
    σ_IH - σ_GM = 1 / 20 ∧ inghamSlope2 σ_IH = 12 / 5 ∧ gmSlope σ_GM = 30 / 13 ∧
    inghamSlope2 σ_IH - gmSlope σ_GM = 6 / 65 ∧ gmSlope σ_GM - 2 = 4 / 13 ∧
    1 - 1 / gmSlope σ_GM = 17 / 30 ∧ (1 - 1 / inghamSlope2 σ_IH) - (1 - 1 / gmSlope σ_GM) = 1 / 60 := by
  unfold inghamSlope2 gmSlope
  have hs_ih : 3 / (2 - σ_IH) = 12 / 5 := by
    have hd : 2 - σ_IH ≠ 0 := by linarith only [hIH]
    rw [div_eq_iff hd]; linarith only [hIH]
  have hs_gm : 15 / (5 * σ_GM + 3) = 30 / 13 := by
    have hd : 5 * σ_GM + 3 ≠ 0 := by linarith only [hGM]
    rw [div_eq_iff hd]; linarith only [hGM]
  rw [hs_ih, hs_gm]
  refine ⟨by linarith only [hIH, hGM], rfl, rfl, ?_, ?_, ?_, ?_⟩ <;> norm_num

/-- [Theorem 30] `det_3` Rank-Defect `S_2` Collapse (`det_3(u, v, α u + β v) = 0`) and `A_GM - 2 ≥ 1/7`. -/
theorem thm_30_guth_maynard_det3_rank_defect_s2_collapse_barrier (u v w : ℕ → ℝ) (α β σ : ℝ)
    (hdep : ∀ j, j < 3 → w j = α * u j + β * v j) (hσlo : 7 ≤ 10 * σ) (hσhi : 5 * σ ≤ 4) :
    det3 u v w = 0 ∧ gmSlope σ - 2 = (9 - 10 * σ) / (5 * σ + 3) ∧
    gmSlope σ ≤ 30 / 13 ∧ 1 / 7 ≤ gmSlope σ - 2 := by
  unfold det3 gmSlope
  have hdet : u 0 * (v 1 * w 2 - v 2 * w 1) - u 1 * (v 0 * w 2 - v 2 * w 0) +
      u 2 * (v 0 * w 1 - v 1 * w 0) = 0 := by
    rw [hdep 0 (by omega), hdep 1 (by omega), hdep 2 (by omega)]; ring
  have h5σ3 : 0 < 5 * σ + 3 := by linarith only [hσlo]
  have hgap : 15 / (5 * σ + 3) - 2 = (9 - 10 * σ) / (5 * σ + 3) := by
    rw [eq_div_iff h5σ3.ne', sub_mul, div_mul_cancel₀ _ h5σ3.ne']; ring
  exact ⟨hdet, hgap, by rw [div_le_iff₀ h5σ3]; linarith only [hσlo],
    by rw [hgap, div_le_div_iff₀ (by norm_num : (0 : ℝ) < 7) h5σ3]; linarith only [hσhi]⟩

/-! ## Part II: Ultari `Case 001` & `Case 005` QRH Gram Energy Bridges (Theorems 31-35) -/

noncomputable def coarseBundledSqrtExp (αX αY δ : ℝ) : ℝ := (5 * αX + αY) / 12 + (αY / 2) * δ
noncomputable def unbundledKeptLSqrtExp (αX αY ℓ δ : ℝ) : ℝ := (αY - αX + ℓ) / 2 + (αX / 2) * δ
noncomputable def unbundledFullSqrtExp (αX αY δ : ℝ) : ℝ := (αY - αX) / 2 + (αX / 2) * δ
noncomputable def qrhCriticalBeta (αX αY ℓ : ℝ) : ℝ := 5 / 6 + (αX + αY - 2 * ℓ) / 12
noncomputable def qrhDiagCriticalBeta (αX ℓ : ℝ) : ℝ := 5 / 6 + (αX - ℓ) / 6
noncomputable def qrhDenominator (y : ℝ) : ℝ := (37 + 34 * y) / 18
noncomputable def qrhPrimeWeight (y : ℝ) : ℝ := (7 + 18 * y + 8 * y ^ 2) / 9
noncomputable def qrhBalanceDenominator (δ y : ℝ) : ℝ :=
  (5 / 6 - δ) * qrhDenominator y + δ * qrhPrimeWeight y
def qrhCertificateWeight (y : ℝ) : ℝ := 51 + 41 * y
noncomputable def qrhBalancedCutoff (δ y : ℝ) : ℝ :=
  1 + δ * qrhPrimeWeight y / (2 * qrhBalanceDenominator δ y)
noncomputable def qrhBalancedRowCount (δ y : ℝ) : ℝ :=
  1 - 5 / 6 + (5 / 6 - δ) * qrhBalancedCutoff δ y
noncomputable def qrhBalancedExponent (δ y : ℝ) : ℝ :=
  -(1 / 48) + (2 / 3) * δ + δ * (1 / 2 - y) / 6 - (13 / 16) * (1 - qrhBalancedRowCount δ y)
noncomputable def hybridCriticalBeta (αX αY : ℝ) : ℝ := (25 / 3 - 5 * αX - 3 * αY) / 6
noncomputable def hybridRequiredSaving (αX αY β : ℝ) : ℝ := (29 + 3 * (αX + αY) - 36 * β) / 36
noncomputable def welchRankExcess (αX αY : ℝ) : ℝ := (5 * αX + αY) / 12 - αX / 2

/-- [Theorem 31] Exact `oai_ref/GramScaleLoss.lean` & `oai_ref/LowGramScale.lean` Real-Power Losses over `ℝ`. -/
theorem thm_31_qrh_gram_scale_loss_and_coarse_bundled_exponent (M P Y Z δ : ℝ)
    (hM : 1 < M) (hP : 1 < P) (hY : 0 < Y) (hZ : 1 < Z) (hδ : 0 < δ) :
    P * (Y / (M * P)) ^ (-1 + δ) = M ^ (1 - δ) * P ^ (2 - δ) * Y ^ (-1 + δ) ∧
    M ^ (1 - δ) < M ∧ P ^ (2 - δ) < P ^ 2 ∧
    P * (Y / (M * P)) ^ (-1 + δ) < M * (P ^ 2 / Y) * Y ^ δ ∧
    Real.sqrt (Z ^ (17 / 48 : ℝ) * (Z ^ (1 / 8 : ℝ)) ^ (1 / 6 : ℝ) * (Z ^ (23 / 48 : ℝ)) ^ δ) =
      Z ^ (3 / 16 + (23 / 96) * δ) ∧
    Z ^ (3 / 16 : ℝ) <
      Real.sqrt (Z ^ (17 / 48 : ℝ) * (Z ^ (1 / 8 : ℝ)) ^ (1 / 6 : ℝ) * (Z ^ (23 / 48 : ℝ)) ^ δ) := by
  have hm0 : 0 < M := lt_trans zero_lt_one hM
  have hp0 : 0 < P := lt_trans zero_lt_one hP
  have hz0 : 0 < Z := lt_trans zero_lt_one hZ
  have hid : P * (Y / (M * P)) ^ (-1 + δ) = M ^ (1 - δ) * P ^ (2 - δ) * Y ^ (-1 + δ) := by
    rw [Real.div_rpow hY.le (mul_pos hm0 hp0).le, Real.mul_rpow hm0.le hp0.le,
      div_eq_mul_inv, mul_inv_rev, ← Real.rpow_neg hm0.le, ← Real.rpow_neg hp0.le]
    have he : P * P ^ (-(-1 + δ)) = P ^ (2 - δ) := by
      conv_lhs => lhs; rw [← Real.rpow_one P]
      rw [← Real.rpow_add hp0]; congr 1; ring
    calc P * (Y ^ (-1 + δ) * (P ^ (-(-1 + δ)) * M ^ (-(-1 + δ)))) =
          M ^ (1 - δ) * (P * P ^ (-(-1 + δ))) * Y ^ (-1 + δ) := by rw [show -(-1 + δ) = 1 - δ by ring]; ring
      _ = M ^ (1 - δ) * P ^ (2 - δ) * Y ^ (-1 + δ) := by rw [he]
  have hm_lt : M ^ (1 - δ) < M := by
    simpa only [Real.rpow_one] using Real.rpow_lt_rpow_of_exponent_lt hM (show 1 - δ < 1 by linarith only [hδ])
  have hp_lt : P ^ (2 - δ) < P ^ 2 := by
    simpa only [Real.rpow_two] using Real.rpow_lt_rpow_of_exponent_lt hP (show 2 - δ < 2 by linarith only [hδ])
  have hloss_lt : P * (Y / (M * P)) ^ (-1 + δ) < M * (P ^ 2 / Y) * Y ^ δ := by
    rw [hid]
    have hmul_y := mul_lt_mul_of_pos_right
      (mul_lt_mul'' hm_lt hp_lt (Real.rpow_nonneg hm0.le _) (Real.rpow_nonneg hp0.le _))
      (Real.rpow_pos_of_pos hY (-1 + δ))
    have hy_rew : M * P ^ 2 * Y ^ (-1 + δ) = M * (P ^ 2 / Y) * Y ^ δ := by
      rw [Real.rpow_add hY, Real.rpow_neg_one]; ring
    linarith only [hmul_y, hy_rew]
  have hz_sqrt : Real.sqrt (Z ^ (17 / 48 : ℝ) * (Z ^ (1 / 8 : ℝ)) ^ (1 / 6 : ℝ) * (Z ^ (23 / 48 : ℝ)) ^ δ) =
      Z ^ (3 / 16 + (23 / 96) * δ) := by
    have hz_pow : Z ^ (17 / 48 : ℝ) * (Z ^ (1 / 8 : ℝ)) ^ (1 / 6 : ℝ) * (Z ^ (23 / 48 : ℝ)) ^ δ =
        Z ^ (3 / 8 + (23 / 48) * δ : ℝ) := by
      rw [← Real.rpow_mul hz0.le, ← Real.rpow_mul hz0.le, ← Real.rpow_add hz0, ← Real.rpow_add hz0]
      congr 1; ring
    rw [hz_pow, Real.sqrt_eq_rpow, ← Real.rpow_mul hz0.le]; congr 1; ring
  exact ⟨hid, hm_lt, hp_lt, hloss_lt, hz_sqrt,
    by rw [hz_sqrt]; exact Real.rpow_lt_rpow_of_exponent_lt hZ (by linarith only [hδ])⟩

/-- [Theorem 32] Universal `δ`-Parametric Three-Mode Gram Unbundling & `oai_ref/Endpoint.lean` `y = 0` SOS Vertex `79/204`. -/
theorem thm_32_qrh_three_mode_unbundling_215_and_487_over_3264 (αX αY ℓ δ : ℝ)
    (hgauss : 4 * (5 * αX + αY) = 9) (htail : 48 * (2 * αX - αY) = 11)
    (hcond : 16 * (αX - ℓ) = 3) :
    αX = 17 / 48 ∧ αY = 23 / 48 ∧ ℓ = 1 / 6 ∧
    (αX - ℓ) / 2 = 3 / 32 ∧ ((5 * αX + αY) / 6 - ℓ) / 2 = 5 / 48 ∧
    coarseBundledSqrtExp αX αY δ - unbundledKeptLSqrtExp αX αY ℓ δ =
      (2 * αX - αY - ℓ) / 2 + (αY - αX) / 12 + ((αY - αX) / 2) * δ ∧
    coarseBundledSqrtExp αX αY δ - unbundledKeptLSqrtExp αX αY ℓ δ = 1 / 24 + δ / 16 ∧
    coarseBundledSqrtExp αX αY δ - unbundledFullSqrtExp αX αY δ = 1 / 8 + δ / 16 ∧
    ((4 * qrhCertificateWeight 0 * δ - 79) ^ 2 = 0 ↔ δ = 79 / 204) ∧
    coarseBundledSqrtExp αX αY (79 / 204) - unbundledKeptLSqrtExp αX αY ℓ (79 / 204) = 215 / 3264 ∧
    coarseBundledSqrtExp αX αY (79 / 204) - unbundledFullSqrtExp αX αY (79 / 204) = 487 / 3264 := by
  unfold coarseBundledSqrtExp unbundledKeptLSqrtExp unbundledFullSqrtExp qrhCertificateWeight
  have hX : αX = 17 / 48 := by linarith only [hgauss, htail]
  have hY : αY = 23 / 48 := by linarith only [hgauss, htail]
  have hL : ℓ = 1 / 6 := by linarith only [hX, hcond]
  have hid : ((5 * αX + αY) / 12 + αY / 2 * δ) - ((αY - αX + ℓ) / 2 + αX / 2 * δ) =
      (2 * αX - αY - ℓ) / 2 + (αY - αX) / 12 + ((αY - αX) / 2) * δ := by ring
  have hsos_iff : (4 * (51 + 41 * (0 : ℝ)) * δ - 79) ^ 2 = 0 ↔ δ = 79 / 204 := by
    rw [sq_eq_zero_iff]
    constructor <;> intro h <;> linarith only [h]
  refine ⟨hX, hY, hL, ?_, ?_, hid, ?_, ?_, hsos_iff, ?_, ?_⟩
  · rw [hX, hL]; norm_num
  · rw [hX, hY, hL]; norm_num
  · rw [hX, hY, hL]; ring
  · rw [hX, hY]; ring
  · rw [hX, hY, hL]; norm_num
  · rw [hX, hY]; norm_num

/-- [Theorem 33] Rescaled QRH Critical Thresholds (`7/8 -> 5/6 -> 3/4`) and `+79/3264` Margin. -/
theorem thm_33_qrh_rescaled_five_sixths_and_three_quarters_bridge (αX1 αY1 ℓ1 αX2 ℓ2 : ℝ)
    (hg1 : 5 * αX1 + αY1 = 2) (ht1 : 2 * αX1 - αY1 - ℓ1 = 0)
    (hsym1 : αX1 = αY1) (hgap2 : 2 * (ℓ2 - αX2) = 1) :
    αX1 = 1 / 3 ∧ αY1 = 1 / 3 ∧ ℓ1 = 1 / 3 ∧ qrhCriticalBeta αX1 αY1 ℓ1 = 5 / 6 ∧
    (215 : ℝ) / 3264 - (7 / 8 - qrhCriticalBeta αX1 αY1 ℓ1) = 79 / 3264 ∧
    0 < (215 : ℝ) / 3264 - (7 / 8 - qrhCriticalBeta αX1 αY1 ℓ1) ∧
    qrhDiagCriticalBeta αX2 ℓ2 = 3 / 4 ∧
    qrhCriticalBeta αX1 αY1 ℓ1 - qrhDiagCriticalBeta αX2 ℓ2 = 1 / 12 := by
  unfold qrhCriticalBeta qrhDiagCriticalBeta
  have hx1 : αX1 = 1 / 3 := by linarith only [hg1, hsym1]
  have hy1 : αY1 = 1 / 3 := by linarith only [hx1, hsym1]
  have hl1 : ℓ1 = 1 / 3 := by linarith only [ht1, hx1, hy1]
  have hd2 : 5 / 6 + (αX2 - ℓ2) / 6 = 3 / 4 := by linarith only [hgap2]
  rw [hx1, hy1, hl1]
  refine ⟨rfl, rfl, rfl, ?_, ?_, ?_, hd2, ?_⟩
  · norm_num
  · norm_num
  · norm_num
  · linarith only [hd2]

/-- [Theorem 34] Bivariate SOS Certificate & `49 / 440640` Uniform Margin (`oai_ref/Endpoint.lean`). -/
theorem thm_34_qrh_endpoint_sos_identity_and_box_margin (δ y : ℝ)
    (hδ0 : 0 ≤ δ) (hδ1 : 6 * δ ≤ 5) (hy0 : 0 ≤ y) (hy1 : 2 * y ≤ 1) :
    35 / 54 ≤ qrhBalanceDenominator δ y ∧ qrhBalanceDenominator δ y ≤ 5 / 2 ∧
    1 ≤ qrhBalancedCutoff δ y ∧
    10368 * qrhCertificateWeight y * qrhBalanceDenominator δ y * (-qrhBalancedExponent δ y) =
      (3 + 5 * y) * ((4 * qrhCertificateWeight y * δ - 79) ^ 2 + 49) +
      4 * y * (4 * qrhCertificateWeight y * δ *
        ((1 + 3 * y) * (15 + 32 * y) * δ + 9 - 13 * y) + 265 + 3485 * y) ∧
    (49 : ℝ) / 440640 ≤ -qrhBalancedExponent δ y := by
  have hd_lo : 7 / 9 ≤ qrhDenominator y := by unfold qrhDenominator; linarith only [hy0]
  have hd_hi : qrhDenominator y ≤ 3 := by unfold qrhDenominator; linarith only [hy1]
  have hp_lo : 7 / 9 ≤ qrhPrimeWeight y := by unfold qrhPrimeWeight; linarith [hy0, sq_nonneg y]
  have hp_hi : qrhPrimeWeight y ≤ 2 := by
    unfold qrhPrimeWeight
    have ht : 0 ≤ y * (1 - 2 * y) := mul_nonneg hy0 (by linarith only [hy1])
    nlinarith only [ht]
  have ha_nn : 0 ≤ 5 / 6 - δ := by linarith only [hδ1]
  have hb_lo : 35 / 54 ≤ qrhBalanceDenominator δ y := by
    unfold qrhBalanceDenominator
    linarith [mul_le_mul_of_nonneg_left hd_lo ha_nn, mul_le_mul_of_nonneg_left hp_lo hδ0]
  have hb_hi : qrhBalanceDenominator δ y ≤ 5 / 2 := by
    unfold qrhBalanceDenominator
    linarith [mul_le_mul_of_nonneg_left hd_hi ha_nn,
      mul_le_mul_of_nonneg_left (le_trans hp_hi (by norm_num : (2 : ℝ) ≤ 3)) hδ0]
  have hb_pos : 0 < qrhBalanceDenominator δ y := by linarith only [hb_lo]
  have h2b_pos : 0 < 2 * qrhBalanceDenominator δ y := by positivity
  have hcut_ge1 : 1 ≤ qrhBalancedCutoff δ y := by
    unfold qrhBalancedCutoff
    linarith [div_nonneg (mul_nonneg hδ0 (by linarith only [hp_lo])) h2b_pos.le]
  have hsos_id :
      10368 * qrhCertificateWeight y * qrhBalanceDenominator δ y * (-qrhBalancedExponent δ y) =
        (3 + 5 * y) * ((4 * qrhCertificateWeight y * δ - 79) ^ 2 + 49) +
        4 * y * (4 * qrhCertificateWeight y * δ *
          ((1 + 3 * y) * (15 + 32 * y) * δ + 9 - 13 * y) + 265 + 3485 * y) := by
    unfold qrhBalancedExponent qrhBalancedRowCount qrhBalancedCutoff
    have hmul_cut : (2 * qrhBalanceDenominator δ y) *
        (1 + δ * qrhPrimeWeight y / (2 * qrhBalanceDenominator δ y)) =
        2 * qrhBalanceDenominator δ y + δ * qrhPrimeWeight y := by
      rw [mul_add, mul_one, mul_div_cancel₀ _ h2b_pos.ne']
    calc 10368 * qrhCertificateWeight y * qrhBalanceDenominator δ y *
          (-(-(1 / 48) + 2 / 3 * δ + δ * (1 / 2 - y) / 6 -
            13 / 16 * (1 - (1 - 5 / 6 + (5 / 6 - δ) *
              (1 + δ * qrhPrimeWeight y / (2 * qrhBalanceDenominator δ y)))))) =
          5184 * qrhCertificateWeight y *
            ((2 * qrhBalanceDenominator δ y) * (1 / 48 - 2 / 3 * δ - δ * (1 / 2 - y) / 6 +
              13 / 16 * (5 / 6)) - (13 / 16) * (5 / 6 - δ) *
              ((2 * qrhBalanceDenominator δ y) *
                (1 + δ * qrhPrimeWeight y / (2 * qrhBalanceDenominator δ y)))) := by ring
      _ = 5184 * qrhCertificateWeight y *
            ((2 * qrhBalanceDenominator δ y) * (1 / 48 - 2 / 3 * δ - δ * (1 / 2 - y) / 6 +
              13 / 16 * (5 / 6)) - (13 / 16) * (5 / 6 - δ) *
              (2 * qrhBalanceDenominator δ y + δ * qrhPrimeWeight y)) := by rw [hmul_cut]
      _ = (3 + 5 * y) * ((4 * qrhCertificateWeight y * δ - 79) ^ 2 + 49) +
            4 * y * (4 * qrhCertificateWeight y * δ *
              ((1 + 3 * y) * (15 + 32 * y) * δ + 9 - 13 * y) + 265 + 3485 * y) := by
        unfold qrhBalanceDenominator qrhDenominator qrhPrimeWeight qrhCertificateWeight; ring
  have hv_pos : 0 < qrhCertificateWeight y := by unfold qrhCertificateWeight; linarith only [hy0]
  have hinner : 0 ≤ (1 + 3 * y) * (15 + 32 * y) * δ + 9 - 13 * y := by
    have hp : 0 ≤ (1 + 3 * y) * (15 + 32 * y) * δ := by positivity
    linarith only [hp, hy1]
  have hprod_nn : 0 ≤ 4 * qrhCertificateWeight y * δ *
      ((1 + 3 * y) * (15 + 32 * y) * δ + 9 - 13 * y) :=
    mul_nonneg (mul_nonneg (by positivity) hδ0) hinner
  have hrest : 0 ≤ 4 * y * (4 * qrhCertificateWeight y * δ *
      ((1 + 3 * y) * (15 + 32 * y) * δ + 9 - 13 * y) + 265 + 3485 * y) :=
    mul_nonneg (by linarith only [hy0]) (by linarith only [hprod_nn, hy0])
  have hsq : 0 ≤ (3 + 5 * y) * (4 * qrhCertificateWeight y * δ - 79) ^ 2 := by positivity
  have hv_hi : qrhCertificateWeight y ≤ 17 * (3 + 5 * y) := by unfold qrhCertificateWeight; linarith only [hy0]
  have hscaled : 49 * qrhCertificateWeight y ≤
      (176256 * qrhBalanceDenominator δ y * (-qrhBalancedExponent δ y)) * qrhCertificateWeight y := by
    linarith [hsos_id, hrest, hsq, hv_hi]
  have hcancel := le_of_mul_le_mul_right hscaled hv_pos
  have hE_pos : 0 < -qrhBalancedExponent δ y := by
    by_contra! hn
    have hp := mul_nonpos_of_nonneg_of_nonpos (by positivity : 0 ≤ 176256 * qrhBalanceDenominator δ y) hn
    linarith only [hcancel, hp]
  exact ⟨hb_lo, hb_hi, hcut_ge1, hsos_id,
    by linarith [hcancel, mul_le_mul_of_nonneg_right hb_hi hE_pos.le]⟩

/-- [Theorem 35] Hybrid `(A+B)` Critical-Line (`β = 1/2`, `δ = 0`) Scales `(35/66, 59/66, 7/11)` and `Δ_hybrid = 14/33`. -/
theorem thm_35_hybrid_ab_coupled_critical_line_fourteen_thirtythirds (αX αY d0 : ℝ)
    (htail : 6 * (2 * αX - αY) = 1) (hd0 : 6 * (d0 + αX) = 7)
    (hcrit : 2 * hybridCriticalBeta αX αY = 1) :
    αX = 35 / 66 ∧ αY = 59 / 66 ∧ d0 = 7 / 11 ∧
    coarseBundledSqrtExp αX αY 0 = 13 / 44 ∧
    hybridRequiredSaving αX αY (1 / 2) = 14 / 33 ∧
    coarseBundledSqrtExp αX αY 0 - hybridRequiredSaving αX αY (1 / 2) = -17 / 132 ∧
    welchRankExcess αX αY = 1 / 33 ∧
    17 / 33 < αX ∧ αX < 4 / 7 ∧ αX - 17 / 33 = 1 / 66 := by
  unfold hybridCriticalBeta at hcrit
  unfold coarseBundledSqrtExp hybridRequiredSaving welchRankExcess
  have hx : αX = 35 / 66 := by linarith only [htail, hcrit]
  have hy : αY = 59 / 66 := by linarith only [htail, hx]
  have hd : d0 = 7 / 11 := by linarith only [hd0, hx]
  rw [hx, hy, hd]
  refine ⟨rfl, rfl, rfl, ?_, ?_, ?_, ?_, ?_, ?_, ?_⟩ <;> norm_num

end ClassicalGuthMaynardAndQrhGram
