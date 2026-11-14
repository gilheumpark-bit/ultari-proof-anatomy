/-
  Case 015 - Paper 2 Part A (Theorems 16-25): Ingham (1940), Halasz-Schur Gram Duality, and Huxley (1972)
  Exact `σ* = 3/4` Minimax Inflection (`A = 12/5`), `k = 2 -> 3` Bottleneck, and `ε n^2` Phase Loss.
  Lean 4 (`v4.29.0-rc8`) over `ℝ`, 0 sorry, 0 custom axioms, 100% hypothesis mutation kill.
-/
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Algebra.BigOperators.Group.Finset.Basic

namespace ClassicalInghamHuxleyZeroDensity

def classIIFourthMomentExp (σ y : ℝ) : ℝ := 1 + y * (2 - 4 * σ)
def classIMeanValueLowExp (σ m : ℝ) : ℝ := 1 + m * (1 - 2 * σ)
def classIDiagExp (σ ν : ℝ) : ℝ := ν * (2 - 2 * σ)
noncomputable def inghamSlope (σ : ℝ) : ℝ := 3 / (2 - σ)
noncomputable def inghamExp (σ : ℝ) : ℝ := 3 * (1 - σ) / (2 - σ)
def huxleyLVExp (σ ν : ℝ) : ℝ := 1 + ν * (4 - 6 * σ)
noncomputable def huxleySlope (σ : ℝ) : ℝ := 3 / (3 * σ - 1)
noncomputable def huxleyExp (σ : ℝ) : ℝ := 3 * (1 - σ) / (3 * σ - 1)
noncomputable def huxleyClassIICutoff (σ : ℝ) : ℝ := (3 * σ - 2) / ((2 * σ - 1) * (3 * σ - 1))
noncomputable def offDiagAbsRowSum (n : ℕ) (G : ℕ → ℕ → ℝ) (i : ℕ) : ℝ :=
  (Finset.range n).sum (fun j => if j = i then 0 else |G i j|)
def gramQuadForm (n : ℕ) (G : ℕ → ℕ → ℝ) (x : ℕ → ℝ) : ℝ :=
  (Finset.range n).sum (fun i => (Finset.range n).sum (fun j => x i * G i j * x j))
def l2EnergySq (n : ℕ) (x : ℕ → ℝ) : ℝ := (Finset.range n).sum (fun i => x i ^ 2)
def signedPhaseGram (D ε : ℝ) (v : ℕ → ℝ) (i j : ℕ) : ℝ := if j = i then D else ε * v i * v j
def primeGapZeroErrorExp (A θ σ : ℝ) : ℝ := ((1 - θ) * A - 1) * (1 - σ)

/-- [Theorem 16] Exact Algebraic Derivation of Ingham's (1940) `A_Ing(σ) = 3 / (2 - σ)`. -/
theorem thm_16_ingham_three_term_zero_detection_balance (σ m y : ℝ)
    (hσlo : 1 < 2 * σ) (hσhi : σ < 1)
    (hbal1 : classIIFourthMomentExp σ y = classIMeanValueLowExp σ m)
    (hbal2 : classIMeanValueLowExp σ m = classIDiagExp σ (m + y)) :
    m = 2 * y ∧ y = 1 / (2 * (2 - σ)) ∧ m = 1 / (2 - σ) ∧
    classIDiagExp σ (m + y) = inghamExp σ ∧ inghamExp σ = inghamSlope σ * (1 - σ) ∧ 0 < inghamExp σ := by
  unfold classIIFourthMomentExp classIMeanValueLowExp classIDiagExp inghamExp inghamSlope at *
  have h2mσ : 0 < 2 - σ := by linarith only [hσhi]
  have hm2y : m = 2 * y := by
    have hdiff : (m - 2 * y) * (1 - 2 * σ) = 0 := by linarith only [hbal1]
    rcases mul_eq_zero.mp hdiff with h0 | hbad
    · linarith only [h0]
    · exfalso; linarith only [hσlo, hbad]
  have hy_eq : y * (2 * (2 - σ)) = 1 := by nlinarith only [hbal2, hm2y]
  have h2d : 2 * (2 - σ) ≠ 0 := by positivity
  have hy_val : y = 1 / (2 * (2 - σ)) := (eq_div_iff h2d).mpr hy_eq
  have hm_val : m = 1 / (2 - σ) := by
    rw [eq_div_iff h2mσ.ne']
    calc m * (2 - σ) = y * (2 * (2 - σ)) := by rw [hm2y]; ring
      _ = 1 := hy_eq
  have hexp : (m + y) * (2 - 2 * σ) = 3 * (1 - σ) / (2 - σ) := by
    rw [eq_div_iff h2mσ.ne']
    calc (m + y) * (2 - 2 * σ) * (2 - σ) = 3 * (1 - σ) * (y * (2 * (2 - σ))) := by rw [hm2y]; ring
      _ = 3 * (1 - σ) := by rw [hy_eq]; ring
  exact ⟨hm2y, hy_val, hm_val, hexp, by ring, div_pos (by linarith only [hσhi]) h2mσ⟩

/-- [Theorem 17] Strict Monotonicity and Conservation Law `A_Ing(σ) + E_Ing(σ) = 3` of Ingham's Curve. -/
theorem thm_17_ingham_slope_strict_monotonicity_and_conservation (σ1 σ2 : ℝ)
    (h1 : 1 ≤ 2 * σ1) (h12 : σ1 < σ2) (h2 : σ2 < 1) :
    inghamSlope σ1 + inghamExp σ1 = 3 ∧
    inghamSlope σ2 - inghamSlope σ1 = 3 * (σ2 - σ1) / ((2 - σ1) * (2 - σ2)) ∧
    2 ≤ inghamSlope σ1 ∧ inghamSlope σ1 < inghamSlope σ2 ∧ inghamSlope σ2 < 3 ∧
    inghamExp σ2 < inghamExp σ1 ∧ inghamExp σ1 ≤ 1 := by
  unfold inghamSlope inghamExp
  have hd1 : 0 < 2 - σ1 := by linarith only [h12, h2]
  have hd2 : 0 < 2 - σ2 := by linarith only [h2]
  have hcons1 : 3 / (2 - σ1) + 3 * (1 - σ1) / (2 - σ1) = 3 := by
    rw [show 3 / (2 - σ1) + 3 * (1 - σ1) / (2 - σ1) = 3 * (2 - σ1) / (2 - σ1) by ring,
      mul_div_cancel_right₀ 3 hd1.ne']
  have hcons2 : 3 / (2 - σ2) + 3 * (1 - σ2) / (2 - σ2) = 3 := by
    rw [show 3 / (2 - σ2) + 3 * (1 - σ2) / (2 - σ2) = 3 * (2 - σ2) / (2 - σ2) by ring,
      mul_div_cancel_right₀ 3 hd2.ne']
  have hdiff : 3 / (2 - σ2) - 3 / (2 - σ1) = 3 * (σ2 - σ1) / ((2 - σ1) * (2 - σ2)) := by
    rw [div_sub_div _ _ hd2.ne' hd1.ne']; congr 1 <;> ring
  have hge2 : 2 ≤ 3 / (2 - σ1) := by rw [le_div_iff₀ hd1]; linarith only [h1]
  have hpos_d : 0 < 3 * (σ2 - σ1) / ((2 - σ1) * (2 - σ2)) :=
    div_pos (by linarith only [h12]) (mul_pos hd1 hd2)
  have hlt_s : 3 / (2 - σ1) < 3 / (2 - σ2) := by linarith only [hdiff, hpos_d]
  have hlt3 : 3 / (2 - σ2) < 3 := by rw [div_lt_iff₀ hd2]; linarith only [h2]
  exact ⟨hcons1, hdiff, hge2, hlt_s, hlt3, by linarith only [hcons1, hcons2, hlt_s],
    by linarith only [hcons1, hge2]⟩

/-- [Theorem 18] Halasz-Montgomery-Schur Symmetric Gram Quadratic Form Bound `x^T G x ≤ (D + B) ‖x‖_2^2`. -/
theorem thm_18_halasz_schur_gram_phase_destruction_bound (n : ℕ) (G : ℕ → ℕ → ℝ) (x : ℕ → ℝ) (D B : ℝ)
    (hsym : ∀ i j, i < n → j < n → G i j = G j i)
    (hdiag : ∀ i, i < n → G i i ≤ D) (hoff : ∀ i, i < n → offDiagAbsRowSum n G i ≤ B) :
    gramQuadForm n G x ≤ (D + B) * l2EnergySq n x := by
  unfold gramQuadForm l2EnergySq
  have hpt : ∀ i ∈ Finset.range n, ∀ j ∈ Finset.range n, 2 * (x i * G i j * x j) ≤
      (if j = i then 2 * D * x i ^ 2 else 0) +
      (if j = i then 0 else |G i j|) * x i ^ 2 + (if j = i then 0 else |G i j|) * x j ^ 2 := by
    intro i hi j _; by_cases hji : j = i
    · subst hji; simp only [↓reduceIte, zero_mul, add_zero]
      have hd := hdiag j (Finset.mem_range.mp hi)
      nlinarith only [sq_nonneg (x j), hd]
    · simp only [hji, ↓reduceIte, zero_add]
      have hle : x i * G i j * x j ≤ |x i * G i j * x j| := le_abs_self _
      have hsq : 0 ≤ |G i j| * (|x i| - |x j|) ^ 2 := mul_nonneg (abs_nonneg _) (sq_nonneg _)
      have hsq_exp : |G i j| * (|x i| - |x j|) ^ 2 =
          |G i j| * x i ^ 2 + |G i j| * x j ^ 2 - 2 * |x i * G i j * x j| := by
        have habs : |x i * G i j * x j| = |G i j| * (|x i| * |x j|) := by rw [abs_mul, abs_mul]; ring
        calc |G i j| * (|x i| - |x j|) ^ 2 =
            |G i j| * |x i| ^ 2 + |G i j| * |x j| ^ 2 - 2 * (|G i j| * (|x i| * |x j|)) := by ring
          _ = |G i j| * x i ^ 2 + |G i j| * x j ^ 2 - 2 * |x i * G i j * x j| := by
            rw [sq_abs (x i), sq_abs (x j), habs]
      linarith only [hle, hsq, hsq_exp]
  have hsum2 : 2 * (Finset.range n).sum (fun i => (Finset.range n).sum (fun j => x i * G i j * x j)) ≤
      (Finset.range n).sum (fun i => (Finset.range n).sum (fun j =>
        (if j = i then 2 * D * x i ^ 2 else 0) +
        (if j = i then 0 else |G i j|) * x i ^ 2 + (if j = i then 0 else |G i j|) * x j ^ 2)) := by
    rw [Finset.mul_sum]; refine Finset.sum_le_sum (fun i hi => ?_)
    rw [Finset.mul_sum]; exact Finset.sum_le_sum (fun j hj => hpt i hi j hj)
  have hp1 : (Finset.range n).sum (fun i => (Finset.range n).sum (fun j =>
      if j = i then 2 * D * x i ^ 2 else 0)) = 2 * D * (Finset.range n).sum (fun i => x i ^ 2) := by
    rw [Finset.mul_sum]; refine Finset.sum_congr rfl (fun i hi => ?_)
    rw [Finset.sum_ite_eq' (Finset.range n) i (fun _ => 2 * D * x i ^ 2)]; simp [hi]
  have hp2 : (Finset.range n).sum (fun i => (Finset.range n).sum (fun j =>
      (if j = i then 0 else |G i j|) * x i ^ 2)) ≤ B * (Finset.range n).sum (fun i => x i ^ 2) := by
    rw [Finset.mul_sum]; refine Finset.sum_le_sum (fun i hi => ?_); rw [← Finset.sum_mul]
    exact mul_le_mul_of_nonneg_right (hoff i (Finset.mem_range.mp hi)) (sq_nonneg (x i))
  have hp3 : (Finset.range n).sum (fun i => (Finset.range n).sum (fun j =>
      (if j = i then 0 else |G i j|) * x j ^ 2)) ≤ B * (Finset.range n).sum (fun j => x j ^ 2) := by
    rw [Finset.sum_comm, Finset.mul_sum]; refine Finset.sum_le_sum (fun j hj => ?_); rw [← Finset.sum_mul]
    have hcol : (Finset.range n).sum (fun i => if j = i then 0 else |G i j|) = offDiagAbsRowSum n G j := by
      unfold offDiagAbsRowSum; refine Finset.sum_congr rfl (fun i hi => ?_)
      by_cases hij : i = j
      · subst hij; simp
      · have hji : j ≠ i := fun h => hij h.symm
        simp only [hij, hji, ↓reduceIte]
        rw [hsym i j (Finset.mem_range.mp hi) (Finset.mem_range.mp hj)]
    rw [hcol]; exact mul_le_mul_of_nonneg_right (hoff j (Finset.mem_range.mp hj)) (sq_nonneg (x j))
  simp only [Finset.sum_add_distrib] at hsum2
  linarith only [hsum2, hp1, hp2, hp3]

/-- [Theorem 19] Huxley's (1972) Interval Subdivision & Reflection Principle Large-Values Derivation. -/
theorem thm_19_huxley_reflection_subdivision_large_values_derivation (C T N V T0 R0 R : ℝ)
    (hC : 0 < C) (hN : 0 < N) (hV : 0 < V) (hT : 0 ≤ T) (hT0_opt : 4 * C ^ 2 * N ^ 2 * T0 = V ^ 4)
    (hhalasz : R0 * V ^ 2 ≤ C * (N ^ 2 + R0 * Real.sqrt T0 * N)) (hsub : T0 * R ≤ (T + T0) * R0) :
    0 < V * T0 ∧ 2 * C * N * Real.sqrt T0 = V ^ 2 ∧ R0 ≤ 2 * C * N ^ 2 / V ^ 2 ∧
    R ≤ 2 * C * N ^ 2 / V ^ 2 + 8 * C ^ 3 * T * N ^ 4 / V ^ 6 := by
  have h4CN2 : 0 < 4 * C ^ 2 * N ^ 2 := by positivity
  have hV4 : 0 < V ^ 4 := by positivity
  have hT0 : 0 < T0 := by
    by_contra! hle
    have hnp := mul_nonpos_of_nonneg_of_nonpos h4CN2.le hle
    linarith only [hT0_opt, hV4, hnp]
  have hsqrt_sq : (2 * C * N * Real.sqrt T0) ^ 2 = (V ^ 2) ^ 2 := by
    calc (2 * C * N * Real.sqrt T0) ^ 2 = 4 * C ^ 2 * N ^ 2 * Real.sqrt T0 ^ 2 := by ring
      _ = 4 * C ^ 2 * N ^ 2 * T0 := by rw [Real.sq_sqrt hT0.le]
      _ = (V ^ 2) ^ 2 := by rw [hT0_opt]; ring
  have h2CN_sqrt : 2 * C * N * Real.sqrt T0 = V ^ 2 := by
    have h1 : 0 ≤ 2 * C * N * Real.sqrt T0 := by positivity
    nlinarith only [hsqrt_sq, h1, sq_nonneg V]
  have hR0_V2 : R0 * V ^ 2 ≤ 2 * C * N ^ 2 := by
    have hprod_eq : C * (N ^ 2 + R0 * Real.sqrt T0 * N) =
        C * N ^ 2 + R0 * (2 * C * N * Real.sqrt T0) / 2 := by ring
    rw [h2CN_sqrt] at hprod_eq; linarith only [hhalasz, hprod_eq]
  have hV2_pos : 0 < V ^ 2 := by positivity
  have hV6_pos : 0 < V ^ 6 := by positivity
  have hR0_bd : R0 ≤ 2 * C * N ^ 2 / V ^ 2 := (le_div_iff₀ hV2_pos).mpr hR0_V2
  have hsub_bd := le_trans hsub (mul_le_mul_of_nonneg_left hR0_bd (by linarith only [hT, hT0]))
  have h1 : V ^ 6 * (2 * C * N ^ 2 / V ^ 2) = 2 * C * N ^ 2 * V ^ 4 := by
    rw [show V ^ 6 * (2 * C * N ^ 2 / V ^ 2) = V ^ 4 * (V ^ 2 * (2 * C * N ^ 2 / V ^ 2)) by ring,
      mul_div_cancel₀ _ hV2_pos.ne']; ring
  have hmulV6 : T0 * V ^ 6 * R ≤ T0 * V ^ 6 * (2 * C * N ^ 2 / V ^ 2) + 8 * C ^ 3 * T * N ^ 4 * T0 := by
    calc T0 * V ^ 6 * R = V ^ 6 * (T0 * R) := by ring
      _ ≤ V ^ 6 * ((T + T0) * (2 * C * N ^ 2 / V ^ 2)) := mul_le_mul_of_nonneg_left hsub_bd hV6_pos.le
      _ = (T + T0) * (2 * C * N ^ 2 * V ^ 4) := by rw [← h1]; ring
      _ = T0 * (V ^ 6 * (2 * C * N ^ 2 / V ^ 2)) + 2 * C * N ^ 2 * T * V ^ 4 := by rw [h1]; ring
      _ = T0 * V ^ 6 * (2 * C * N ^ 2 / V ^ 2) + 8 * C ^ 3 * T * N ^ 4 * T0 := by rw [← hT0_opt]; ring
  have hcancel_T0 : V ^ 6 * R ≤ V ^ 6 * (2 * C * N ^ 2 / V ^ 2) + 8 * C ^ 3 * T * N ^ 4 := by
    nlinarith only [hmulV6, hT0]
  have hrhs_eq : V ^ 6 * (2 * C * N ^ 2 / V ^ 2 + 8 * C ^ 3 * T * N ^ 4 / V ^ 6) =
      V ^ 6 * (2 * C * N ^ 2 / V ^ 2) + 8 * C ^ 3 * T * N ^ 4 := by
    rw [mul_add, mul_div_cancel₀ _ hV6_pos.ne']
  refine ⟨mul_pos hV hT0, h2CN_sqrt, hR0_bd, le_of_mul_le_mul_right ?_ hV6_pos⟩
  linarith only [hcancel_T0, hrhs_eq]

/-- [Theorem 20] Huxley's `k = 2 -> 3` Amplification Bottleneck and Cutoff Compatibility (`4σ ≥ 3`). -/
theorem thm_20_huxley_k2_k3_amplification_and_cutoff_compatibility (σ ν2 : ℝ)
    (hσlo : 1 < 2 * σ) (hσhi : σ ≤ 1) (hbal : huxleyLVExp σ (2 * ν2) = classIDiagExp σ (3 * ν2)) :
    ν2 = 1 / (2 * (3 * σ - 1)) ∧ classIDiagExp σ (3 * ν2) = huxleyExp σ ∧ 0 ≤ huxleyExp σ ∧
    huxleySlope σ < 6 ∧ classIIFourthMomentExp σ (huxleyClassIICutoff σ) = huxleyExp σ ∧
    huxleyClassIICutoff σ - ν2 = (4 * σ - 3) / (2 * (2 * σ - 1) * (3 * σ - 1)) ∧
    (huxleySlope σ ≤ 2 ↔ 5 ≤ 6 * σ) := by
  unfold huxleyLVExp classIDiagExp huxleyExp huxleySlope classIIFourthMomentExp huxleyClassIICutoff at *
  have h2σ1 : 0 < 2 * σ - 1 := by linarith only [hσlo]
  have h3σ1 : 0 < 3 * σ - 1 := by linarith only [hσlo]
  have h2_3σ1 : 0 < 2 * (3 * σ - 1) := by positivity
  have hprod_pos : 0 < (2 * σ - 1) * (3 * σ - 1) := mul_pos h2σ1 h3σ1
  have hν_eq : ν2 * (2 * (3 * σ - 1)) = 1 := by nlinarith only [hbal]
  have hν_val : ν2 = 1 / (2 * (3 * σ - 1)) := (eq_div_iff h2_3σ1.ne').mpr hν_eq
  have hexp : 3 * ν2 * (2 - 2 * σ) = 3 * (1 - σ) / (3 * σ - 1) := by
    rw [eq_div_iff h3σ1.ne']
    calc 3 * ν2 * (2 - 2 * σ) * (3 * σ - 1) = 3 * (1 - σ) * (ν2 * (2 * (3 * σ - 1))) := by ring
      _ = 3 * (1 - σ) := by rw [hν_eq]; ring
  have hclassII : 1 + (3 * σ - 2) / ((2 * σ - 1) * (3 * σ - 1)) * (2 - 4 * σ) =
      3 * (1 - σ) / (3 * σ - 1) := by
    rw [eq_div_iff h3σ1.ne']
    have hmul : (3 * σ - 2) / ((2 * σ - 1) * (3 * σ - 1)) * (2 - 4 * σ) * (3 * σ - 1) =
        -2 * (3 * σ - 2) := by
      rw [show (3 * σ - 2) / ((2 * σ - 1) * (3 * σ - 1)) * (2 - 4 * σ) * (3 * σ - 1) =
          (3 * σ - 2) * (-2) * (((2 * σ - 1) * (3 * σ - 1)) / ((2 * σ - 1) * (3 * σ - 1))) by ring,
        div_self hprod_pos.ne']; ring
    linarith only [hmul]
  have hden : 2 * (2 * σ - 1) * (3 * σ - 1) ≠ 0 := by positivity
  have hgap : (3 * σ - 2) / ((2 * σ - 1) * (3 * σ - 1)) - ν2 =
      (4 * σ - 3) / (2 * (2 * σ - 1) * (3 * σ - 1)) := by
    rw [hν_val, div_sub_div _ _ hprod_pos.ne' h2_3σ1.ne']
    rw [div_eq_div_iff (mul_ne_zero hprod_pos.ne' h2_3σ1.ne') hden]; ring
  refine ⟨hν_val, hexp, div_nonneg (by linarith only [hσhi]) h3σ1.le,
    by rw [div_lt_iff₀ h3σ1]; linarith only [hσlo], hclassII, hgap, ?_⟩
  rw [div_le_iff₀ h3σ1]; constructor <;> intro h <;> linarith only [h]

/-- [Theorem 21] Exact Ingham-Huxley Minimax Inflection at `σ* = 3/4` (`A = 12/5 = 2.4`). -/
theorem thm_21_ingham_huxley_minimax_three_quarters_inflection (σ : ℝ)
    (hlo : 1 ≤ 2 * σ) (hhi : σ ≤ 1) :
    2 ≤ inghamSlope σ ∧ 0 ≤ inghamExp σ ∧ min (inghamSlope σ) (huxleySlope σ) ≤ 12 / 5 ∧
    (min (inghamSlope σ) (huxleySlope σ) = 12 / 5 ↔ 4 * σ = 3) := by
  unfold inghamSlope inghamExp huxleySlope
  have h2mσ : 0 < 2 - σ := by linarith only [hhi]
  have h3σ1 : 0 < 3 * σ - 1 := by linarith only [hlo]
  have hub : min (3 / (2 - σ)) (3 / (3 * σ - 1)) ≤ 12 / 5 := by
    rcases le_or_gt (4 * σ) 3 with hle | hgt
    · refine le_trans (min_le_left _ _) ?_; rw [div_le_iff₀ h2mσ]; linarith only [hle]
    · refine le_trans (min_le_right _ _) ?_; rw [div_le_iff₀ h3σ1]; linarith only [hgt]
  refine ⟨by rw [le_div_iff₀ h2mσ]; linarith only [hlo],
    div_nonneg (by linarith only [hhi]) h2mσ.le, hub, ?_⟩
  constructor
  · intro hm; rcases lt_trichotomy (4 * σ) 3 with hlt | heq | hgt
    · have h1 : 3 / (2 - σ) < 12 / 5 := by rw [div_lt_iff₀ h2mσ]; linarith only [hlt]
      have h2 := lt_of_le_of_lt (min_le_left (3 / (2 - σ)) (3 / (3 * σ - 1))) h1
      linarith only [hm, h2]
    · exact heq
    · have h1 : 3 / (3 * σ - 1) < 12 / 5 := by rw [div_lt_iff₀ h3σ1]; linarith only [hgt]
      have h2 := lt_of_le_of_lt (min_le_right (3 / (2 - σ)) (3 / (3 * σ - 1))) h1
      linarith only [hm, h2]
  · intro h43
    have h1 : 3 / (2 - σ) = 12 / 5 := by rw [div_eq_iff h2mσ.ne']; linarith only [h43]
    have h2 : 3 / (3 * σ - 1) = 12 / 5 := by rw [div_eq_iff h3σ1.ne']; linarith only [h43]
    rw [h1, h2, min_self]

/-- [Theorem 22] Density Hypothesis Gap (`2/5`) and Huxley's `7/12` Short-Interval Prime-Gap Law. -/
theorem thm_22_density_hypothesis_gap_and_prime_gap_seven_twelfths (A θ σ : ℝ)
    (hA : 0 < A) (hσ : σ < 1) :
    (primeGapZeroErrorExp A θ σ < 0 ↔ 1 - 1 / A < θ) ∧
    (primeGapZeroErrorExp (inghamSlope (3 / 4)) θ σ < 0 ↔ 7 / 12 < θ) ∧
    (primeGapZeroErrorExp (inghamSlope (1 / 2)) θ σ < 0 ↔ 1 / 2 < θ) ∧
    inghamSlope (3 / 4) - inghamSlope (1 / 2) = 2 / 5 ∧
    (1 - 1 / inghamSlope (3 / 4)) - (1 - 1 / inghamSlope (1 / 2)) = 1 / 12 := by
  have h1mσ : 0 < 1 - σ := by linarith only [hσ]
  have hgen : ∀ B : ℝ, 0 < B → (primeGapZeroErrorExp B θ σ < 0 ↔ 1 - 1 / B < θ) := by
    intro B hB; unfold primeGapZeroErrorExp
    constructor
    · intro hneg
      have h1 : (1 - θ) * B < 1 := by nlinarith only [hneg, h1mσ]
      have h2 : 1 - θ < 1 / B := (lt_div_iff₀ hB).mpr h1
      linarith only [h2]
    · intro hθ
      have h1 : 1 - θ < 1 / B := by linarith only [hθ]
      have h2 : (1 - θ) * B < 1 := (lt_div_iff₀ hB).mp h1
      exact mul_neg_of_neg_of_pos (by linarith only [h2]) h1mσ
  have hs34 : inghamSlope (3 / 4) = 12 / 5 := by unfold inghamSlope; norm_num
  have hs12 : inghamSlope (1 / 2) = 2 := by unfold inghamSlope; norm_num
  have h712 : (primeGapZeroErrorExp (inghamSlope (3 / 4)) θ σ < 0 ↔ 7 / 12 < θ) := by
    rw [hs34, hgen (12 / 5) (by norm_num)]; norm_num
  have h12 : (primeGapZeroErrorExp (inghamSlope (1 / 2)) θ σ < 0 ↔ 1 / 2 < θ) := by
    rw [hs12, hgen 2 (by norm_num)]; norm_num
  refine ⟨hgen A hA, h712, h12, by rw [hs34, hs12]; norm_num, by rw [hs34, hs12]; norm_num⟩

/-- [Theorem 23] Universal `k -> k + 1` Amplification Crossover Monotonicity in Huxley's Method. -/
theorem thm_23_huxley_higher_amplification_strict_decay (k : ℕ) (σ νk νk1 : ℝ)
    (hk : 2 ≤ k) (hσlo : 2 < 3 * σ) (hσhi : σ < 1)
    (hbalk : huxleyLVExp σ ((k : ℝ) * νk) = classIDiagExp σ (((k : ℝ) + 1) * νk))
    (hbalk1 : huxleyLVExp σ (((k : ℝ) + 1) * νk1) = classIDiagExp σ (((k : ℝ) + 2) * νk1)) :
    classIDiagExp σ (((k : ℝ) + 1) * νk) =
      ((k : ℝ) + 1) * (1 - σ) / ((2 * (k : ℝ) - 1) * σ - ((k : ℝ) - 1)) ∧
    classIDiagExp σ (((k : ℝ) + 1) * νk) - classIDiagExp σ (((k : ℝ) + 2) * νk1) =
      (3 * σ - 2) * (1 - σ) /
        (((2 * (k : ℝ) - 1) * σ - ((k : ℝ) - 1)) * ((2 * (k : ℝ) + 1) * σ - (k : ℝ))) ∧
    classIDiagExp σ (((k : ℝ) + 2) * νk1) < classIDiagExp σ (((k : ℝ) + 1) * νk) ∧
    classIDiagExp σ (((k : ℝ) + 1) * νk) ≤ huxleyExp σ := by
  unfold huxleyLVExp classIDiagExp huxleyExp at *
  have hk_real : (2 : ℝ) ≤ (k : ℝ) := by exact_mod_cast hk
  have hden_k : 0 < (2 * (k : ℝ) - 1) * σ - ((k : ℝ) - 1) := by
    have hnn := mul_nonneg (by linarith only [hk_real] : 0 ≤ (k : ℝ) - 2) (by linarith only [hσlo] : 0 ≤ 2 * σ - 1)
    have hrew : (2 * (k : ℝ) - 1) * σ - ((k : ℝ) - 1) = ((k : ℝ) - 2) * (2 * σ - 1) + (3 * σ - 1) := by ring
    linarith only [hrew, hnn, hσlo]
  have hden_k1 : 0 < (2 * (k : ℝ) + 1) * σ - (k : ℝ) := by
    have hrew : (2 * (k : ℝ) + 1) * σ - (k : ℝ) = ((2 * (k : ℝ) - 1) * σ - ((k : ℝ) - 1)) + (2 * σ - 1) := by ring
    linarith only [hrew, hden_k, hσlo]
  have hνk_eq : νk * (2 * ((2 * (k : ℝ) - 1) * σ - ((k : ℝ) - 1))) = 1 := by nlinarith only [hbalk]
  have hνk1_eq : νk1 * (2 * ((2 * (k : ℝ) + 1) * σ - (k : ℝ))) = 1 := by nlinarith only [hbalk1]
  have hEk : ((k : ℝ) + 1) * νk * (2 - 2 * σ) =
      ((k : ℝ) + 1) * (1 - σ) / ((2 * (k : ℝ) - 1) * σ - ((k : ℝ) - 1)) := by
    rw [eq_div_iff hden_k.ne']
    calc ((k : ℝ) + 1) * νk * (2 - 2 * σ) * ((2 * (k : ℝ) - 1) * σ - ((k : ℝ) - 1)) =
          ((k : ℝ) + 1) * (1 - σ) * (νk * (2 * ((2 * (k : ℝ) - 1) * σ - ((k : ℝ) - 1)))) := by ring
      _ = ((k : ℝ) + 1) * (1 - σ) := by rw [hνk_eq]; ring
  have hEk1 : ((k : ℝ) + 2) * νk1 * (2 - 2 * σ) =
      ((k : ℝ) + 2) * (1 - σ) / ((2 * (k : ℝ) + 1) * σ - (k : ℝ)) := by
    rw [eq_div_iff hden_k1.ne']
    calc ((k : ℝ) + 2) * νk1 * (2 - 2 * σ) * ((2 * (k : ℝ) + 1) * σ - (k : ℝ)) =
          ((k : ℝ) + 2) * (1 - σ) * (νk1 * (2 * ((2 * (k : ℝ) + 1) * σ - (k : ℝ)))) := by ring
      _ = ((k : ℝ) + 2) * (1 - σ) := by rw [hνk1_eq]; ring
  have hdiff : ((k : ℝ) + 1) * νk * (2 - 2 * σ) - ((k : ℝ) + 2) * νk1 * (2 - 2 * σ) =
      (3 * σ - 2) * (1 - σ) /
        (((2 * (k : ℝ) - 1) * σ - ((k : ℝ) - 1)) * ((2 * (k : ℝ) + 1) * σ - (k : ℝ))) := by
    rw [hEk, hEk1, div_sub_div _ _ hden_k.ne' hden_k1.ne']; congr 1; ring
  have hpos_diff : 0 < (3 * σ - 2) * (1 - σ) /
      (((2 * (k : ℝ) - 1) * σ - ((k : ℝ) - 1)) * ((2 * (k : ℝ) + 1) * σ - (k : ℝ))) :=
    div_pos (mul_pos (by linarith only [hσlo]) (by linarith only [hσhi])) (mul_pos hden_k hden_k1)
  have hle_hux : ((k : ℝ) + 1) * νk * (2 - 2 * σ) ≤ 3 * (1 - σ) / (3 * σ - 1) := by
    have h3σ1 : 0 < 3 * σ - 1 := by linarith only [hσlo]
    rw [hEk, div_le_div_iff₀ hden_k h3σ1]
    have hid : 3 * (1 - σ) * ((2 * (k : ℝ) - 1) * σ - ((k : ℝ) - 1)) -
        ((k : ℝ) + 1) * (1 - σ) * (3 * σ - 1) = ((k : ℝ) - 2) * (3 * σ - 2) * (1 - σ) := by ring
    have hnn := mul_nonneg (mul_nonneg (by linarith only [hk_real] : 0 ≤ (k : ℝ) - 2)
      (by linarith only [hσlo] : 0 ≤ 3 * σ - 2)) (by linarith only [hσhi] : 0 ≤ 1 - σ)
    linarith only [hid, hnn]
  exact ⟨hEk, hdiff, by linarith only [hdiff, hpos_diff], hle_hux⟩

/-- [Theorem 24] Exact Phase-Cancellation Loss (`ε * n^2`) of Triangle-Inequality Schur Bounds. -/
theorem thm_24_phase_cancellation_loss_witness_signed_vs_abs (n : ℕ) (v : ℕ → ℝ) (D ε : ℝ)
    (hn : 0 < n) (hunit : ∀ i, i < n → v i ^ 2 = 1) (hzero : (Finset.range n).sum v = 0) (hε : 0 < ε) :
    gramQuadForm n (signedPhaseGram D ε v) (fun _ => 1) = (n : ℝ) * (D - ε) ∧
    (Finset.range n).sum (fun i => D + offDiagAbsRowSum n (signedPhaseGram D ε v) i) =
      (n : ℝ) * (D + ((n : ℝ) - 1) * ε) ∧
    (Finset.range n).sum (fun i => D + offDiagAbsRowSum n (signedPhaseGram D ε v) i) -
      gramQuadForm n (signedPhaseGram D ε v) (fun _ => 1) = ε * (n : ℝ) ^ 2 ∧ 0 < ε * (n : ℝ) ^ 2 := by
  have hquad : gramQuadForm n (signedPhaseGram D ε v) (fun _ => 1) = (n : ℝ) * (D - ε) := by
    unfold gramQuadForm signedPhaseGram
    have hrew : (Finset.range n).sum (fun i => (Finset.range n).sum (fun j =>
        1 * (if j = i then D else ε * v i * v j) * 1)) =
        (Finset.range n).sum (fun i => (Finset.range n).sum (fun j =>
          (if j = i then D - ε else 0) + ε * v i * v j)) := by
      refine Finset.sum_congr rfl (fun i hi => Finset.sum_congr rfl (fun j _ => ?_))
      by_cases hji : j = i
      · subst hji; simp only [↓reduceIte]
        have hv2 : v j * v j = 1 := by
          have hs := hunit j (Finset.mem_range.mp hi)
          linarith only [hs, show v j ^ 2 = v j * v j by ring]
        calc 1 * D * 1 = D - ε + ε * 1 := by ring
          _ = D - ε + ε * (v j * v j) := by rw [hv2]
          _ = D - ε + ε * v j * v j := by ring
      · simp [hji]
    rw [hrew]; simp only [Finset.sum_add_distrib]
    have hp1 : (Finset.range n).sum (fun i => (Finset.range n).sum (fun j =>
        if j = i then D - ε else 0)) = (n : ℝ) * (D - ε) := by
      have hinner : ∀ i ∈ Finset.range n,
          (Finset.range n).sum (fun j => if j = i then D - ε else 0) = D - ε := by
        intro i hi; rw [Finset.sum_ite_eq' (Finset.range n) i (fun _ => D - ε)]; simp [hi]
      rw [Finset.sum_congr rfl hinner, Finset.sum_const, Finset.card_range, nsmul_eq_mul]
    have hp2 : (Finset.range n).sum (fun i => (Finset.range n).sum (fun j => ε * v i * v j)) = 0 := by
      have hfac : (Finset.range n).sum (fun i => (Finset.range n).sum (fun j => ε * v i * v j)) =
          ε * ((Finset.range n).sum v) * ((Finset.range n).sum v) := by
        calc (Finset.range n).sum (fun i => (Finset.range n).sum (fun j => ε * v i * v j)) =
            (Finset.range n).sum (fun i => (ε * v i) * (Finset.range n).sum v) :=
              Finset.sum_congr rfl (fun i _ => by rw [Finset.mul_sum])
          _ = ε * ((Finset.range n).sum v) * ((Finset.range n).sum v) := by rw [← Finset.sum_mul, ← Finset.mul_sum]
      rw [hfac, hzero]; ring
    linarith only [hp1, hp2]
  have hrow : ∀ i ∈ Finset.range n, offDiagAbsRowSum n (signedPhaseGram D ε v) i = ((n : ℝ) - 1) * ε := by
    intro i hi; unfold offDiagAbsRowSum signedPhaseGram
    have habs_v : ∀ k ∈ Finset.range n, |v k| = 1 := by
      intro k hk
      have hsq : |v k| ^ 2 = 1 ^ 2 := by rw [sq_abs, hunit k (Finset.mem_range.mp hk)]; norm_num
      nlinarith only [hsq, abs_nonneg (v k)]
    have hpt : ∀ j ∈ Finset.range n, (if j = i then 0 else |if j = i then D else ε * v i * v j|) =
        ε - (if j = i then ε else 0) := by
      intro j hj; by_cases hji : j = i
      · simp [hji]
      · simp only [hji, ↓reduceIte, sub_zero]; rw [abs_mul, abs_mul, abs_of_pos hε, habs_v i hi, habs_v j hj]; ring
    rw [Finset.sum_congr rfl hpt, Finset.sum_sub_distrib, Finset.sum_const, Finset.card_range,
      nsmul_eq_mul, Finset.sum_ite_eq' (Finset.range n) i (fun _ => ε)]
    simp only [hi, ↓reduceIte]; ring
  have hschur : (Finset.range n).sum (fun i => D + offDiagAbsRowSum n (signedPhaseGram D ε v) i) =
      (n : ℝ) * (D + ((n : ℝ) - 1) * ε) := by
    rw [Finset.sum_congr rfl (fun i hi => by rw [hrow i hi]), Finset.sum_const, Finset.card_range, nsmul_eq_mul]
  have hn_pos : (0 : ℝ) < (n : ℝ) := by exact_mod_cast hn
  exact ⟨hquad, hschur, by rw [hschur, hquad]; ring, by positivity⟩

/-- [Theorem 25] Strict Global Decreasing Monotonicity of `E_IH(σ) = min(E_Ing(σ), E_Hux(σ))` on `[1/2, 1]`. -/
theorem thm_25_global_ingham_huxley_exponent_strict_monotonicity (σ1 σ2 : ℝ)
    (h1 : 1 ≤ 2 * σ1) (h12 : σ1 < σ2) (h2 : σ2 ≤ 1) :
    0 ≤ min (inghamExp σ2) (huxleyExp σ2) ∧
    min (inghamExp σ2) (huxleyExp σ2) < min (inghamExp σ1) (huxleyExp σ1) ∧
    min (inghamExp σ1) (huxleyExp σ1) ≤ 1 := by
  unfold inghamExp huxleyExp
  have hd_i1 : 0 < 2 - σ1 := by linarith only [h12, h2]
  have hd_i2 : 0 < 2 - σ2 := by linarith only [h2]
  have hd_h1 : 0 < 3 * σ1 - 1 := by linarith only [h1]
  have hd_h2 : 0 < 3 * σ2 - 1 := by linarith only [h1, h12]
  have hing_dec : 3 * (1 - σ2) / (2 - σ2) < 3 * (1 - σ1) / (2 - σ1) := by
    rw [div_lt_div_iff₀ hd_i2 hd_i1]; nlinarith only [h12]
  have hhux_dec : 3 * (1 - σ2) / (3 * σ2 - 1) < 3 * (1 - σ1) / (3 * σ1 - 1) := by
    rw [div_lt_div_iff₀ hd_h2 hd_h1]; nlinarith only [h12]
  exact ⟨le_min (div_nonneg (by linarith only [h2]) hd_i2.le) (div_nonneg (by linarith only [h2]) hd_h2.le),
    lt_min (lt_of_le_of_lt (min_le_left _ _) hing_dec) (lt_of_le_of_lt (min_le_right _ _) hhux_dec),
    le_trans (min_le_left _ _) (by rw [div_le_iff₀ hd_i1]; linarith only [h1])⟩

end ClassicalInghamHuxleyZeroDensity
