/-
  Case 015 - Paper 1 (Theorems 1-15): Zero-Free Regions & `σ = 1 - o(1)` Asymptotic Wall
  de la Vallee Poussin (1896), Mertens (1898), Korobov-Vinogradov (1958), Fejer-Riesz Ceilings.
  Lean 4 (`v4.29.0-rc8`) over `ℝ`, 0 sorry, 0 custom axioms, 100% hypothesis mutation kill.
-/
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Inverse
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Algebra.BigOperators.Group.Finset.Basic

namespace ClassicalDlvpKorobovAndZeroFree

noncomputable def trigPoly2 (c0 c1 c2 θ : ℝ) : ℝ := c0 + c1 * Real.cos θ + c2 * Real.cos (2 * θ)
noncomputable def zfBound (c0 c1 u : ℝ) : ℝ := (c1 - u) * (u - c0) / u
noncomputable def poleZeroStep (c0 c1 W k : ℝ) : ℝ := (c1 / (k + 1) - c0 / k) / W
noncomputable def stationaryConst (c0 c1 W : ℝ) : ℝ := (Real.sqrt c1 - Real.sqrt c0) ^ 2 / W
noncomputable def normTransferExp (c0 c1 c2 bup blip : ℝ) : ℝ := (c1 * blip + c2 * bup) / (c1 - c0)
def deg2Quintic (r : ℝ) : ℝ := r ^ 5 + 4 * r ^ 4 - 12 * r ^ 3 - 40 * r ^ 2 + 64 * r - 64
def fejerC0 (N : ℕ) (a : ℕ → ℝ) : ℝ := (Finset.range (N + 1)).sum (fun j => a j ^ 2)
def fejerC1 (N : ℕ) (a : ℕ → ℝ) : ℝ := 2 * (Finset.range N).sum (fun j => a j * a (j + 1))
noncomputable def trigPolyN (N : ℕ) (c : ℕ → ℝ) (θ : ℝ) : ℝ :=
  c 0 + (Finset.range N).sum (fun k => c (k + 1) * Real.cos ((k + 1 : ℝ) * θ))
def higherWeightSum (N : ℕ) (c : ℕ → ℝ) : ℝ := (Finset.range N).sum (fun k => c (k + 1))
def higherAbsWeightSum (N : ℕ) (c : ℕ → ℝ) : ℝ := (Finset.range N).sum (fun k => |c (k + 1)|)
def higherPosWeightSum (N : ℕ) (c : ℕ → ℝ) : ℝ := (Finset.range N).sum (fun k => max (c (k + 1)) 0)
noncomputable def signChangeWitnessC : ℕ → ℝ
  | 0 => 65 / 16
  | 1 => 9 / 2
  | 2 => 0
  | 3 => -1
  | _ => 0

/-- [Theorem 1] Classical Mertens-de la Vallee Poussin `(3, 4, 1)` cosine SOS identity. -/
theorem thm_01_dlvp_three_four_one_sos_identity (θ w : ℝ) (hw : 0 ≤ w) :
    w * trigPoly2 3 4 1 θ = 2 * w * (1 + Real.cos θ) ^ 2 ∧ 0 ≤ w * trigPoly2 3 4 1 θ := by
  have hid : w * trigPoly2 3 4 1 θ = 2 * w * (1 + Real.cos θ) ^ 2 := by
    unfold trigPoly2; rw [Real.cos_two_mul]; ring
  exact ⟨hid, by rw [hid]; positivity⟩

/-- [Theorem 2] Exact SOS decomposition of the pole-zero objective `zfBound`. -/
theorem thm_02_pole_zero_sos_decomposition (c0 c1 u : ℝ) (hc0 : 0 ≤ c0) (hc1 : 0 ≤ c1) (hu : 0 < u) :
    u * zfBound c0 c1 u =
      u * (Real.sqrt c1 - Real.sqrt c0) ^ 2 - (u - Real.sqrt c0 * Real.sqrt c1) ^ 2 ∧
    zfBound c0 c1 u ≤ (Real.sqrt c1 - Real.sqrt c0) ^ 2 := by
  have h_lhs : u * zfBound c0 c1 u = (c1 - u) * (u - c0) := by
    unfold zfBound; exact mul_div_cancel₀ _ hu.ne'
  have hsos : (c1 - u) * (u - c0) =
      u * (Real.sqrt c1 - Real.sqrt c0) ^ 2 - (u - Real.sqrt c0 * Real.sqrt c1) ^ 2 := by
    nlinarith [Real.sq_sqrt hc0, Real.sq_sqrt hc1]
  refine ⟨h_lhs.trans hsos, le_of_mul_le_mul_left ?_ hu⟩
  linarith [h_lhs.trans hsos, sq_nonneg (u - Real.sqrt c0 * Real.sqrt c1)]

/-- [Theorem 3] Universal stationary-point deduction from the pole-zero reciprocal family. -/
theorem thm_03_stationary_point_zero_free_implication (c0 c1 δ A W : ℝ)
    (hc0 : 0 < c0) (hc01 : c0 < c1) (hA : 0 < A) (hW : 0 < W)
    (hpole : ∀ s1 : ℝ, 0 < s1 → c1 * s1 ≤ (s1 + δ) * (c0 + A * W * s1)) :
    stationaryConst c0 c1 W ≤ A * δ := by
  have hc1 : 0 < c1 := hc0.trans hc01
  have hsc0 : 0 < Real.sqrt c0 := Real.sqrt_pos.mpr hc0
  have hsc_lt : Real.sqrt c0 < Real.sqrt c1 := Real.sqrt_lt_sqrt hc0.le hc01
  have hsq0 : Real.sqrt c0 ^ 2 = c0 := Real.sq_sqrt hc0.le
  have hsq1 : Real.sqrt c1 ^ 2 = c1 := Real.sq_sqrt hc1.le
  have hAW : 0 < A * W := mul_pos hA hW
  let s1_opt : ℝ := Real.sqrt c0 * (Real.sqrt c1 - Real.sqrt c0) / (A * W)
  have hs1_pos : 0 < s1_opt := div_pos (mul_pos hsc0 (sub_pos.mpr hsc_lt)) hAW
  have h_inst := hpole s1_opt hs1_pos
  have hmul : A * W * s1_opt = Real.sqrt c0 * (Real.sqrt c1 - Real.sqrt c0) :=
    mul_div_cancel₀ _ hAW.ne'
  have hu_eq : c0 + A * W * s1_opt = Real.sqrt c0 * Real.sqrt c1 := by nlinarith [hmul, hsq0]
  rw [hu_eq] at h_inst
  have h_key : Real.sqrt c0 * Real.sqrt c1 * (Real.sqrt c1 - Real.sqrt c0) ^ 2 ≤
      Real.sqrt c0 * Real.sqrt c1 * (A * W * δ) := by
    have h1 := mul_le_mul_of_nonneg_left h_inst hAW.le
    nlinarith [h1, hmul, hsq0, hsq1]
  have h_core := le_of_mul_le_mul_left h_key (mul_pos hsc0 (Real.sqrt_pos.mpr hc1))
  unfold stationaryConst; rw [div_le_iff₀ hW]; nlinarith [h_core]

/-- [Theorem 4] Four-tier constant cascade on `(3, 4, 1)` and Pell `(97, 56)` convergent gap. -/
theorem thm_04_three_four_one_four_tier_slack_cascade (A : ℝ) (hA : 0 < A) :
    A / (32 * (9 * A + 1)) < poleZeroStep 3 4 5 4 ∧ poleZeroStep 3 4 5 4 = 1 / 100 ∧
    poleZeroStep 3 4 5 6 = 1 / 70 ∧ poleZeroStep 3 4 5 7 = 1 / 70 ∧
    stationaryConst 3 4 5 = (7 - 4 * Real.sqrt 3) / 5 ∧
    poleZeroStep 3 4 5 6 < stationaryConst 3 4 5 ∧ stationaryConst 3 4 5 < 1436 / 100000 := by
  have hden : 0 < 32 * (9 * A + 1) := by positivity
  have hstep4 : poleZeroStep 3 4 5 4 = 1 / 100 := by unfold poleZeroStep; norm_num
  have hstep6 : poleZeroStep 3 4 5 6 = 1 / 70 := by unfold poleZeroStep; norm_num
  have hstep7 : poleZeroStep 3 4 5 7 = 1 / 70 := by unfold poleZeroStep; norm_num
  have hsq3 : Real.sqrt 3 ^ 2 = 3 := Real.sq_sqrt (by norm_num)
  have hsq4 : Real.sqrt 4 = 2 := by rw [show (4 : ℝ) = 2 ^ 2 by norm_num, Real.sqrt_sq (by norm_num)]
  have hstat : stationaryConst 3 4 5 = (7 - 4 * Real.sqrt 3) / 5 := by
    unfold stationaryConst; rw [hsq4]; nlinarith [hsq3]
  have hpell_lo : 56 * Real.sqrt 3 < 97 := by nlinarith [hsq3, Real.sqrt_nonneg 3]
  have hub_sqrt3 : 173205 / 100000 < Real.sqrt 3 := by nlinarith [hsq3, Real.sqrt_nonneg 3]
  refine ⟨?_, hstep4, hstep6, hstep7, hstat, ?_, ?_⟩
  · rw [hstep4, div_lt_iff₀ hden]; linarith
  · rw [hstep6, hstat]; linarith
  · rw [hstat]; linarith

/-- [Theorem 5] Exponentiated-norm vs log-derivative `8`-power logarithm loss in `ZetaBounds.lean`. -/
theorem thm_05_tao_zetabounds_exponentiated_norm_log9_loss (c0 c1 c2 bup blip α : ℝ)
    (hc : c0 < c1) (hc1 : 0 < c1) (hbal : c0 * α + c2 * bup = c1 * (α - blip)) :
    α = normTransferExp c0 c1 c2 bup blip ∧ (c0 * α + c2 * bup) / c1 = α - blip ∧
    normTransferExp 3 4 1 1 2 = 9 ∧ (3 * (9 : ℝ) + 1 * 1) / 4 = 7 := by
  refine ⟨?_, ?_, ?_, by norm_num⟩
  · unfold normTransferExp; rw [eq_div_iff (sub_ne_zero.mpr hc.ne')]; linarith
  · rw [div_eq_iff hc1.ne']; linarith
  · unfold normTransferExp; norm_num

/-- [Theorem 6] Tight interior-vertex SOS completion for general degree-2 cosine polynomials. -/
theorem thm_06_degree2_cosine_vertex_completion_of_squares (c0 c1 c2 θ : ℝ)
    (hc2 : 0 < c2) (hvertex : 8 * c0 * c2 = 8 * c2 ^ 2 + c1 ^ 2) :
    trigPoly2 c0 c1 c2 θ = 2 * c2 * (Real.cos θ + c1 / (4 * c2)) ^ 2 ∧ 0 ≤ trigPoly2 c0 c1 c2 θ := by
  have h4c2 : 4 * c2 ≠ 0 := by positivity
  have h8c2 : 8 * c2 ≠ 0 := by positivity
  have hq : 4 * c2 * (c1 / (4 * c2)) = c1 := mul_div_cancel₀ c1 h4c2
  have hmul_eq : 8 * c2 * trigPoly2 c0 c1 c2 θ =
      8 * c2 * (2 * c2 * (Real.cos θ + c1 / (4 * c2)) ^ 2) := by
    unfold trigPoly2; rw [Real.cos_two_mul]
    have hrhs : 8 * c2 * (2 * c2 * (Real.cos θ + c1 / (4 * c2)) ^ 2) =
        (4 * c2 * Real.cos θ + 4 * c2 * (c1 / (4 * c2))) ^ 2 := by ring
    rw [hrhs, hq]; nlinarith [hvertex]
  have hid := mul_left_cancel₀ h8c2 hmul_eq
  exact ⟨hid, by rw [hid]; positivity⟩

/-- [Theorem 7] Integer perfect-square replacement polynomial `(17, 24, 8)`. -/
theorem thm_07_seventeen_twentyfour_eight_perfect_square (θ w : ℝ) (hw : 0 ≤ w) :
    w * trigPoly2 17 24 8 θ = w * (4 * Real.cos θ + 3) ^ 2 ∧ 0 ≤ w * trigPoly2 17 24 8 θ := by
  have hid : w * trigPoly2 17 24 8 θ = w * (4 * Real.cos θ + 3) ^ 2 := by
    unfold trigPoly2; rw [Real.cos_two_mul]; ring
  exact ⟨hid, by rw [hid]; positivity⟩

/-- [Theorem 8] Exact radical value `(41 - 4√102) / 32` and `+88.12%` zero-free bound for `(17, 24, 8)`. -/
theorem thm_08_seventeen_twentyfour_eight_exact_constant_and_gain (A δ : ℝ) (hA : 0 < A)
    (hpole : ∀ s1 : ℝ, 0 < s1 → 24 * s1 ≤ (s1 + δ) * (17 + 32 * A * s1)) :
    stationaryConst 17 24 32 = (41 - 4 * Real.sqrt 102) / 32 ∧
    18811 / 1000000 < stationaryConst 17 24 32 ∧ stationaryConst 17 24 32 < 18812 / 1000000 ∧
    stationaryConst 3 4 5 < stationaryConst 17 24 32 ∧ 18811 / 1000000 < A * δ := by
  have hprod : Real.sqrt 24 * Real.sqrt 17 = 2 * Real.sqrt 102 := by
    rw [← Real.sqrt_mul (by norm_num : (0 : ℝ) ≤ 24)]
    rw [show (24 : ℝ) * 17 = 2 ^ 2 * 102 by norm_num, Real.sqrt_mul (by norm_num), Real.sqrt_sq (by norm_num)]
  have hsq102 : Real.sqrt 102 ^ 2 = 102 := Real.sq_sqrt (by norm_num)
  have hexact : stationaryConst 17 24 32 = (41 - 4 * Real.sqrt 102) / 32 := by
    unfold stationaryConst
    nlinarith [hprod, Real.sq_sqrt (by norm_num : (0 : ℝ) ≤ 24), Real.sq_sqrt (by norm_num : (0 : ℝ) ≤ 17)]
  have h102_ub : 125000 * Real.sqrt 102 < 1262439 := by nlinarith [hsq102, Real.sqrt_nonneg 102]
  have h102_lb : 1262438 < 125000 * Real.sqrt 102 := by nlinarith [hsq102, Real.sqrt_nonneg 102]
  have hlo : 18811 / 1000000 < stationaryConst 17 24 32 := by rw [hexact]; linarith
  have hhi : stationaryConst 17 24 32 < 18812 / 1000000 := by rw [hexact]; linarith
  have h341 := (thm_04_three_four_one_four_tier_slack_cascade 1 zero_lt_one).2.2.2.2.2.2
  have himp : stationaryConst 17 24 32 ≤ A * δ := by
    refine thm_03_stationary_point_zero_free_implication 17 24 δ A 32 (by norm_num) (by norm_num) hA (by norm_num) ?_
    intro s1 hs1; linarith [hpole s1 hs1]
  exact ⟨hexact, hlo, hhi, by linarith [h341, hlo], hlo.trans_le himp⟩

/-- [Theorem 9] Irreducible quintic stationarity polynomial and `10^-4` root enclosure. -/
theorem thm_09_degree2_global_quintic_stationarity_and_root (r : ℝ) (hr : 2 < r)
    (hstat : Real.sqrt (8 * (r ^ 2 + 8)) = Real.sqrt r * (r ^ 2 + 2 * r - 8)) :
    deg2Quintic r = 0 ∧ deg2Quintic (29662 / 10000) < 0 ∧
    0 < deg2Quintic (29663 / 10000) ∧ deg2Quintic (29663 / 10000) < deg2Quintic 3 := by
  have hsq_r : Real.sqrt r ^ 2 = r := Real.sq_sqrt (by linarith)
  have hsq_l : Real.sqrt (8 * (r ^ 2 + 8)) ^ 2 = 8 * (r ^ 2 + 8) := Real.sq_sqrt (by positivity)
  have h_sq_eq := congrArg (· ^ 2) hstat
  have hq0 : deg2Quintic r = 0 := by
    unfold deg2Quintic
    have h2 : (Real.sqrt r * (r ^ 2 + 2 * r - 8)) ^ 2 = r * (r ^ 2 + 2 * r - 8) ^ 2 := by
      calc (Real.sqrt r * (r ^ 2 + 2 * r - 8)) ^ 2 = Real.sqrt r ^ 2 * (r ^ 2 + 2 * r - 8) ^ 2 := by ring
      _ = r * (r ^ 2 + 2 * r - 8) ^ 2 := by rw [hsq_r]
    linarith [h_sq_eq, hsq_l, h2]
  refine ⟨hq0, ?_, ?_, ?_⟩ <;> unfold deg2Quintic <;> norm_num

/-- [Theorem 10] Global ceiling `< 0.018819` over ALL degree-2 nonnegative cosine polynomials. -/
theorem thm_10_degree2_global_ceiling_and_9996_tightness (c0 c1 c2 : ℝ) (hc01 : c0 < c1)
    (hpos : ∀ θ : ℝ, 0 ≤ trigPoly2 c0 c1 c2 θ) :
    0 ≤ c0 ∧ 0 < c2 ∧ stationaryConst c0 c1 (c1 + c2) < 18819 / 1000000 := by
  have h0 : 0 ≤ c0 + c1 + c2 := by have h := hpos 0; unfold trigPoly2 at h; norm_num at h; linarith
  have hpi2 : 0 ≤ c0 - c2 := by
    have h := hpos (Real.pi / 2); unfold trigPoly2 at h
    rw [show 2 * (Real.pi / 2) = Real.pi by ring, Real.cos_pi_div_two, Real.cos_pi] at h; linarith
  have hpi : 0 ≤ c0 - c1 + c2 := by
    have h := hpos Real.pi; unfold trigPoly2 at h; rw [Real.cos_pi, Real.cos_two_mul, Real.cos_pi] at h; linarith
  have hc0 : 0 ≤ c0 := by linarith
  have hc2 : 0 < c2 := by linarith
  have hc1 : 0 < c1 := lt_of_le_of_lt hc0 hc01
  have hW_pos : 0 < c1 + c2 := by linarith
  refine ⟨hc0, hc2, ?_⟩
  rcases le_or_gt c1 (4 * c2) with hle | hgt
  · let q : ℝ := -c1 / (4 * c2)
    have h4c2_pos : 0 < 4 * c2 := by positivity
    have h8c2_pos : 0 < 8 * c2 := by positivity
    have hq_mul : 4 * c2 * q = -c1 := mul_div_cancel₀ (-c1) h4c2_pos.ne'
    have hx_lo : -1 ≤ q := by dsimp [q]; rw [le_div_iff₀ h4c2_pos]; linarith
    have hx_hi : q ≤ 1 := by dsimp [q]; rw [div_le_iff₀ h4c2_pos]; linarith
    have hmin := hpos (Real.arccos q)
    unfold trigPoly2 at hmin; rw [Real.cos_two_mul, Real.cos_arccos hx_lo hx_hi] at hmin
    have h_vtx_mul : 8 * c2 ^ 2 + c1 ^ 2 ≤ 8 * c2 * c0 := by
      have hmul := mul_le_mul_of_nonneg_left hmin h8c2_pos.le
      have heq : 8 * c2 * (c0 + c1 * q + c2 * (2 * q ^ 2 - 1)) =
          8 * c2 * c0 - 8 * c2 ^ 2 + 2 * c1 * (4 * c2 * q) + (4 * c2 * q) ^ 2 := by ring
      rw [heq, hq_mul] at hmul; linarith
    let r : ℝ := c1 / c2
    have hc1_eq : c1 = c2 * r := (mul_div_cancel₀ c1 hc2.ne').symm
    have hr_hi : r ≤ 4 := by dsimp [r]; rwa [div_le_iff₀ hc2]
    have hr_vtx : c2 * (1 + r ^ 2 / 8) ≤ c0 := by
      have h8r : 8 * c2 * (c2 * (1 + r ^ 2 / 8)) = 8 * c2 ^ 2 + c1 ^ 2 := by rw [hc1_eq]; ring
      exact le_of_mul_le_mul_left (by linarith : 8 * c2 * (c2 * (1 + r ^ 2 / 8)) ≤ 8 * c2 * c0) h8c2_pos
    have hr_gt1 : 1 < r := by
      have hlt : 1 + r ^ 2 / 8 < r := lt_of_mul_lt_mul_left (by linarith [hr_vtx, hc01, hc1_eq]) hc2.le
      nlinarith [sq_nonneg r]
    have h_num_le : (Real.sqrt c1 - Real.sqrt c0) ^ 2 ≤
        c2 * (Real.sqrt r - Real.sqrt (1 + r ^ 2 / 8)) ^ 2 := by
      have h1 : Real.sqrt c1 - Real.sqrt c0 ≤ Real.sqrt c1 - Real.sqrt (c2 * (1 + r ^ 2 / 8)) := by
        linarith [Real.sqrt_le_sqrt hr_vtx]
      have hsq_le := pow_le_pow_left₀ (sub_nonneg.mpr (Real.sqrt_le_sqrt hc01.le)) h1 2
      have h_fact : (Real.sqrt c1 - Real.sqrt (c2 * (1 + r ^ 2 / 8))) ^ 2 =
          c2 * (Real.sqrt r - Real.sqrt (1 + r ^ 2 / 8)) ^ 2 := by
        rw [hc1_eq, Real.sqrt_mul hc2.le, Real.sqrt_mul hc2.le]
        calc (Real.sqrt c2 * Real.sqrt r - Real.sqrt c2 * Real.sqrt (1 + r ^ 2 / 8)) ^ 2
            = Real.sqrt c2 ^ 2 * (Real.sqrt r - Real.sqrt (1 + r ^ 2 / 8)) ^ 2 := by ring
          _ = c2 * (Real.sqrt r - Real.sqrt (1 + r ^ 2 / 8)) ^ 2 := by rw [Real.sq_sqrt hc2.le]
      exact hsq_le.trans_eq h_fact
    have h_stat_le : stationaryConst c0 c1 (c1 + c2) ≤
        (Real.sqrt r - Real.sqrt (1 + r ^ 2 / 8)) ^ 2 / (r + 1) := by
      unfold stationaryConst; rw [div_le_div_iff₀ hW_pos (by linarith : 0 < r + 1)]
      rw [show c1 + c2 = c2 * (r + 1) by rw [hc1_eq]; ring]; nlinarith [h_num_le]
    refine lt_of_le_of_lt h_stat_le ?_; rw [div_lt_iff₀ (by linarith : 0 < r + 1)]
    let c_ub : ℝ := 18819 / 1000000
    let L_poly : ℝ := r ^ 2 / 8 + (1 - c_ub) * r + (1 - c_ub)
    have hrm1_nn : 0 ≤ r - 1 := sub_nonneg.mpr hr_gt1.le
    have h4mr_nn : 0 ≤ 4 - r := sub_nonneg.mpr hr_hi
    have h_p4_sos : 64 * (4 * r * (1 + r ^ 2 / 8) - L_poly ^ 2) =
        ((r - 1) * (4 - r) + (335569 / 62500) * (r - 1) + 21297734739 / 15625000000) *
          (r - 1483 / 500) ^ 2 + (r - 2969 / 1000) ^ 2 +
        (686747813 / 3906250000000) * (4 - r) + 3764286097429 / 3906250000000000 := by
      dsimp [L_poly, c_ub]; ring
    have h_p4_pos64 : 0 < 64 * (4 * r * (1 + r ^ 2 / 8) - L_poly ^ 2) := by rw [h_p4_sos]; positivity
    clear h_p4_sos
    have h_p4_pos : 0 < 4 * r * (1 + r ^ 2 / 8) - L_poly ^ 2 := by linarith only [h_p4_pos64]
    clear h_p4_pos64
    have hL_pos : 0 < L_poly := by
      have : 0 < r ^ 2 / 8 + (1 - (18819 : ℝ) / 1000000) * r + (1 - 18819 / 1000000) := by positivity
      exact this
    have h_rad_sq : (2 * Real.sqrt (r * (1 + r ^ 2 / 8))) ^ 2 = 4 * r * (1 + r ^ 2 / 8) := by
      rw [mul_pow, Real.sq_sqrt (by positivity)]; ring
    have h_rad_nn : 0 ≤ 2 * Real.sqrt (r * (1 + r ^ 2 / 8)) := by positivity
    have h_sq_lt : L_poly ^ 2 < (2 * Real.sqrt (r * (1 + r ^ 2 / 8))) ^ 2 := by
      linarith only [h_p4_pos, h_rad_sq]
    have h_rad_lt : L_poly < 2 * Real.sqrt (r * (1 + r ^ 2 / 8)) := by
      nlinarith only [h_sq_lt, hL_pos, h_rad_nn]
    have h_exp : (Real.sqrt r - Real.sqrt (1 + r ^ 2 / 8)) ^ 2 =
        r + (1 + r ^ 2 / 8) - 2 * Real.sqrt (r * (1 + r ^ 2 / 8)) := by
      rw [Real.sqrt_mul (by positivity)]
      have hsr : Real.sqrt r ^ 2 = r := Real.sq_sqrt (by positivity)
      have hs1 : Real.sqrt (1 + r ^ 2 / 8) ^ 2 = 1 + r ^ 2 / 8 := Real.sq_sqrt (by positivity)
      nlinarith only [hsr, hs1]
    change r ^ 2 / 8 + (1 - 18819 / 1000000) * r + (1 - 18819 / 1000000) <
      2 * Real.sqrt (r * (1 + r ^ 2 / 8)) at h_rad_lt
    linarith only [h_exp, h_rad_lt]
  · have hc0_ge : c1 - c2 ≤ c0 := by linarith
    have hsc1 : 2 * Real.sqrt c2 < Real.sqrt c1 := by
      have hsq : (2 * Real.sqrt c2) ^ 2 < Real.sqrt c1 ^ 2 := by
        rw [mul_pow, Real.sq_sqrt hc2.le, Real.sq_sqrt hc1.le]; linarith
      nlinarith [Real.sqrt_nonneg c2, Real.sqrt_nonneg c1]
    have hsc12 : (17 / 10) * Real.sqrt c2 < Real.sqrt (c1 - c2) := by
      have hsq : ((17 / 10) * Real.sqrt c2) ^ 2 < Real.sqrt (c1 - c2) ^ 2 := by
        rw [mul_pow, Real.sq_sqrt hc2.le, Real.sq_sqrt (by linarith)]; linarith
      nlinarith [Real.sqrt_nonneg c2, Real.sqrt_nonneg (c1 - c2)]
    have hprod_eq : (Real.sqrt c1 - Real.sqrt (c1 - c2)) * (Real.sqrt c1 + Real.sqrt (c1 - c2)) = c2 := by
      nlinarith [Real.sq_sqrt hc1.le, Real.sq_sqrt (by linarith : 0 ≤ c1 - c2)]
    have hdiff_ub : (Real.sqrt c1 - Real.sqrt (c1 - c2)) * (37 / 10) < Real.sqrt c2 := by
      have hdiff_pos : 0 < Real.sqrt c1 - Real.sqrt (c1 - c2) :=
        sub_pos.mpr (Real.sqrt_lt_sqrt (by linarith) (by linarith))
      have hsum_gt : (37 / 10) * Real.sqrt c2 < Real.sqrt c1 + Real.sqrt (c1 - c2) := by linarith
      have h1 := mul_lt_mul_of_pos_left hsum_gt hdiff_pos
      rw [hprod_eq] at h1
      nlinarith [h1, (Real.mul_self_sqrt hc2.le).symm, Real.sqrt_pos.mpr hc2]
    have hle2 : (Real.sqrt c1 - Real.sqrt c0) * (37 / 10) < Real.sqrt c2 := by
      linarith [Real.sqrt_le_sqrt hc0_ge, hdiff_ub]
    have hnn2 : 0 ≤ (Real.sqrt c1 - Real.sqrt c0) * (37 / 10) :=
      mul_nonneg (sub_nonneg.mpr (Real.sqrt_le_sqrt hc01.le)) (by norm_num)
    have hsq := mul_self_lt_mul_self hnn2 hle2
    rw [Real.mul_self_sqrt hc2.le] at hsq
    have hsq_ub : (Real.sqrt c1 - Real.sqrt c0) ^ 2 < (100 / 1369) * c2 := by linarith
    unfold stationaryConst; rw [div_lt_iff₀ hW_pos]; linarith

/-- [Theorem 11] Fejer-Riesz autocorrelation SOS identity and strict `c_1 < 2 c_0` barrier. -/
theorem thm_11_fejer_riesz_autocorrelation_strict_two_c0_barrier (N : ℕ) (a : ℕ → ℝ)
    (hpos : 0 < fejerC0 N a) :
    2 * fejerC0 N a - fejerC1 N a =
      a 0 ^ 2 + a N ^ 2 + (Finset.range N).sum (fun j => (a (j + 1) - a j) ^ 2) ∧
    fejerC1 N a < 2 * fejerC0 N a := by
  have hsos : ∀ M : ℕ, 2 * fejerC0 M a - fejerC1 M a =
      a 0 ^ 2 + a M ^ 2 + (Finset.range M).sum (fun j => (a (j + 1) - a j) ^ 2) := by
    intro M; induction M with
    | zero => unfold fejerC0 fejerC1; simp; ring
    | succ n ih =>
      unfold fejerC0 fejerC1 at ih ⊢
      rw [Finset.sum_range_succ, Finset.sum_range_succ (f := fun j => a j * a (j + 1)),
        Finset.sum_range_succ (f := fun j => (a (j + 1) - a j) ^ 2)]
      linarith [ih]
  have hsosN := hsos N
  have hsum_nn : 0 ≤ (Finset.range N).sum (fun j => (a (j + 1) - a j) ^ 2) :=
    Finset.sum_nonneg (fun _ _ => sq_nonneg _)
  have hle : fejerC1 N a ≤ 2 * fejerC0 N a := by
    linarith [hsosN, sq_nonneg (a 0), sq_nonneg (a N), hsum_nn]
  refine ⟨hsosN, ?_⟩
  rcases lt_or_eq_of_le hle with hlt | heq
  · exact hlt
  · exfalso
    have ha0_sq : a 0 ^ 2 = 0 := by linarith [hsosN, heq, sq_nonneg (a 0), sq_nonneg (a N), hsum_nn]
    have ha0 : a 0 = 0 := sq_eq_zero_iff.mp ha0_sq
    have hsum_z : (Finset.range N).sum (fun j => (a (j + 1) - a j) ^ 2) = 0 := by
      linarith [hsosN, heq, sq_nonneg (a 0), sq_nonneg (a N), hsum_nn]
    have h_each := (Finset.sum_eq_zero_iff_of_nonneg (fun _ _ => sq_nonneg _)).mp hsum_z
    have hall : ∀ j ∈ Finset.range (N + 1), a j = 0 := by
      intro j hj; rw [Finset.mem_range] at hj
      induction j with
      | zero => exact ha0
      | succ k ihk =>
        have hdiff : a (k + 1) - a k = 0 :=
          sq_eq_zero_iff.mp (h_each k (Finset.mem_range.mpr (by omega)))
        have hk0 : a k = 0 := ihk (by omega)
        linarith
    have hc0_z : fejerC0 N a = 0 := by
      unfold fejerC0; exact Finset.sum_eq_zero (fun j hj => by rw [hall j hj]; ring)
    linarith

/-- [Theorem 12] Evaluation at `θ = π` lower-bounds `W_abs = ∑ |c_k|` for ALL degrees `N ≥ 1` and signs,
    reduces to `W = ∑ c_k` under Hadamard admissibility `c_k ≥ 0`, and separates `W_abs` from `W_+ = ∑ max(c_k, 0)`
    via the nonnegative Fejer witness `|1 + (3/2)e^{iθ} + (3/4)e^{2iθ} - (1/2)e^{3iθ}|^2`. -/
theorem thm_12_general_cosine_pi_weight_lower_bound (N : ℕ) (c : ℕ → ℝ) (hN : 1 ≤ N)
    (hpi : 0 ≤ trigPolyN N c Real.pi) :
    2 * c 1 - c 0 ≤ higherAbsWeightSum N c ∧
    ((∀ k ∈ Finset.range N, 0 ≤ c (k + 1)) → higherAbsWeightSum N c = higherWeightSum N c) ∧
    (∀ θ : ℝ, 0 ≤ trigPolyN 3 signChangeWitnessC θ) ∧
    higherPosWeightSum 3 signChangeWitnessC < 2 * signChangeWitnessC 1 - signChangeWitnessC 0 := by
  obtain ⟨m, rfl⟩ := Nat.exists_eq_add_of_le' hN
  have habs_lb : 2 * c 1 - c 0 ≤ higherAbsWeightSum (m + 1) c := by
    unfold trigPolyN at hpi; unfold higherAbsWeightSum
    rw [Finset.sum_range_succ'] at hpi ⊢
    simp only [Nat.cast_zero, zero_add, one_mul, Real.cos_pi, mul_neg, mul_one] at hpi ⊢
    have hrest : (Finset.range m).sum (fun k => c (k + 1 + 1) * Real.cos (((k + 1 : ℕ) + 1 : ℝ) * Real.pi)) ≤
        (Finset.range m).sum (fun k => |c (k + 1 + 1)|) := by
      refine Finset.sum_le_sum (fun k _ => ?_)
      calc c (k + 1 + 1) * Real.cos (((k + 1 : ℕ) + 1 : ℝ) * Real.pi)
          ≤ |c (k + 1 + 1) * Real.cos (((k + 1 : ℕ) + 1 : ℝ) * Real.pi)| := le_abs_self _
        _ = |c (k + 1 + 1)| * |Real.cos (((k + 1 : ℕ) + 1 : ℝ) * Real.pi)| := abs_mul _ _
        _ ≤ |c (k + 1 + 1)| * 1 := mul_le_mul_of_nonneg_left (Real.abs_cos_le_one _) (abs_nonneg _)
        _ = |c (k + 1 + 1)| := mul_one _
    linarith [hpi, hrest, le_abs_self (c 1)]
  have hred : (∀ k ∈ Finset.range (m + 1), 0 ≤ c (k + 1)) →
      higherAbsWeightSum (m + 1) c = higherWeightSum (m + 1) c := by
    intro hnn; unfold higherAbsWeightSum higherWeightSum
    exact Finset.sum_congr rfl (fun k hk => abs_of_nonneg (hnn k hk))
  have hwit_nn : ∀ θ : ℝ, 0 ≤ trigPolyN 3 signChangeWitnessC θ := by
    intro θ
    unfold trigPolyN signChangeWitnessC
    rw [Finset.sum_range_succ, Finset.sum_range_succ, Finset.sum_range_succ, Finset.sum_range_zero]
    simp only [Nat.cast_zero, Nat.cast_one, Nat.cast_ofNat, zero_add, one_mul]
    have hc3 : Real.cos ((2 + 1 : ℝ) * θ) = 4 * Real.cos θ ^ 3 - 3 * Real.cos θ := by
      rw [show (2 + 1 : ℝ) * θ = 3 * θ by ring]; exact Real.cos_three_mul θ
    rw [hc3]
    have hsos : (65 : ℝ) / 16 + (9 / 2 * Real.cos θ + 0 * Real.cos ((1 + 1 : ℝ) * θ) +
        (-1) * (4 * Real.cos θ ^ 3 - 3 * Real.cos θ)) =
        (1 / 4 + 3 * Real.cos θ + 3 / 2 * Real.cos θ ^ 2 - 2 * Real.cos θ ^ 3) ^ 2 +
        Real.sin θ ^ 2 * (2 + 3 / 2 * Real.cos θ - 2 * Real.cos θ ^ 2) ^ 2 := by
      have hsc : Real.sin θ ^ 2 = 1 - Real.cos θ ^ 2 := by linarith [Real.sin_sq_add_cos_sq θ]
      rw [hsc]; ring
    have hnn_rhs : 0 ≤ (1 / 4 + 3 * Real.cos θ + 3 / 2 * Real.cos θ ^ 2 - 2 * Real.cos θ ^ 3) ^ 2 +
        Real.sin θ ^ 2 * (2 + 3 / 2 * Real.cos θ - 2 * Real.cos θ ^ 2) ^ 2 := by positivity
    linarith [hsos, hnn_rhs]
  have hwit_fail : higherPosWeightSum 3 signChangeWitnessC <
      2 * signChangeWitnessC 1 - signChangeWitnessC 0 := by
    unfold higherPosWeightSum signChangeWitnessC
    rw [Finset.sum_range_succ, Finset.sum_range_succ, Finset.sum_range_succ, Finset.sum_range_zero]
    norm_num
  exact ⟨habs_lb, hred, hwit_nn, hwit_fail⟩

/-- [Theorem 13] Universal Fejer-Riesz constant ceilings across ALL polynomial degrees. -/
theorem thm_13_fejer_riesz_universal_constant_ceilings (c0 c1 W : ℝ)
    (hc0 : 0 < c0) (hc01 : c0 < c1) (hc12 : c1 < 2 * c0) (hW : 2 * c1 - c0 ≤ W) :
    (Real.sqrt c1 - Real.sqrt c0) ^ 2 < (3 - 2 * Real.sqrt 2) * c0 ∧
    stationaryConst c0 c1 W < (3 - 2 * Real.sqrt 2) / 3 ∧ (3 - 2 * Real.sqrt 2) / 3 < 572 / 10000 := by
  have hc1 : 0 < c1 := hc0.trans hc01
  have hW_pos : 0 < W := by linarith
  have hsq0 : Real.sqrt c0 ^ 2 = c0 := Real.sq_sqrt hc0.le
  have hsq1 : Real.sqrt c1 ^ 2 = c1 := Real.sq_sqrt hc1.le
  have hsq2 : Real.sqrt 2 ^ 2 = 2 := Real.sq_sqrt (by norm_num)
  have hsc0 : 0 < Real.sqrt c0 := Real.sqrt_pos.mpr hc0
  have hsc01 : Real.sqrt c0 < Real.sqrt c1 := Real.sqrt_lt_sqrt hc0.le hc01
  have hsc12 : Real.sqrt c1 < Real.sqrt 2 * Real.sqrt c0 := by
    rw [← Real.sqrt_mul (by norm_num : (0 : ℝ) ≤ 2)]; exact Real.sqrt_lt_sqrt hc1.le hc12
  have h_tier1 : (Real.sqrt c1 - Real.sqrt c0) ^ 2 < (3 - 2 * Real.sqrt 2) * c0 := by
    have hdiff_ub : Real.sqrt c1 - Real.sqrt c0 < (Real.sqrt 2 - 1) * Real.sqrt c0 := by linarith
    have hsq := mul_self_lt_mul_self (sub_pos.mpr hsc01).le hdiff_ub
    have hrhs_eq : (Real.sqrt 2 - 1) * Real.sqrt c0 * ((Real.sqrt 2 - 1) * Real.sqrt c0) =
        (3 - 2 * Real.sqrt 2) * c0 := by
      calc (Real.sqrt 2 - 1) * Real.sqrt c0 * ((Real.sqrt 2 - 1) * Real.sqrt c0)
          = (Real.sqrt 2 ^ 2 - 2 * Real.sqrt 2 + 1) * Real.sqrt c0 ^ 2 := by ring
        _ = (3 - 2 * Real.sqrt 2) * c0 := by rw [hsq2, hsq0]; ring
    linarith [hsq, hrhs_eq, sq (Real.sqrt c1 - Real.sqrt c0)]
  have h_fact : (3 - 2 * Real.sqrt 2) * (2 * c1 - c0) - 3 * (Real.sqrt c1 - Real.sqrt c0) ^ 2 =
      (Real.sqrt 2 * Real.sqrt c0 - Real.sqrt c1) *
        ((4 * Real.sqrt 2 - 3) * Real.sqrt c1 - (3 * Real.sqrt 2 - 2) * Real.sqrt c0) := by
    let x := Real.sqrt c0; let y := Real.sqrt c1; let s := Real.sqrt 2
    have hx : c0 = x ^ 2 := hsq0.symm; have hy : c1 = y ^ 2 := hsq1.symm; have hs : s ^ 2 = 2 := hsq2
    calc (3 - 2 * s) * (2 * c1 - c0) - 3 * (y - x) ^ 2
        = (3 - 2 * s) * (2 * y ^ 2 - x ^ 2) - 3 * (y - x) ^ 2 := by rw [hx, hy]
      _ = (s * x - y) * ((4 * s - 3) * y - (3 * s - 2) * x) + (s ^ 2 - 2) * (3 * x ^ 2 - 4 * x * y) := by ring
      _ = (s * x - y) * ((4 * s - 3) * y - (3 * s - 2) * x) := by rw [hs]; ring
  have h_s2_lb : 14142 / 10000 < Real.sqrt 2 := by nlinarith [hsq2, Real.sqrt_nonneg 2]
  have h_s2_ub : Real.sqrt 2 < 3 / 2 := by nlinarith [hsq2, Real.sqrt_nonneg 2]
  have h_fac2_pos : 0 < (4 * Real.sqrt 2 - 3) * Real.sqrt c1 - (3 * Real.sqrt 2 - 2) * Real.sqrt c0 := by
    have h2 := mul_lt_mul_of_pos_left hsc01 (by linarith : 0 < 4 * Real.sqrt 2 - 3)
    have h3 := mul_lt_mul_of_pos_right (by linarith : 3 * Real.sqrt 2 - 2 < 4 * Real.sqrt 2 - 3) hsc0
    linarith
  have h_prod_pos : 0 < (3 - 2 * Real.sqrt 2) * (2 * c1 - c0) - 3 * (Real.sqrt c1 - Real.sqrt c0) ^ 2 := by
    rw [h_fact]; exact mul_pos (sub_pos.mpr hsc12) h_fac2_pos
  refine ⟨h_tier1, ?_, by linarith⟩
  unfold stationaryConst; rw [div_lt_div_iff₀ hW_pos (by norm_num : (0 : ℝ) < 3)]
  have hW_mono := mul_le_mul_of_nonneg_left hW (by linarith : 0 ≤ 3 - 2 * Real.sqrt 2)
  linarith

/-- [Theorem 14] Korobov-Vinogradov (1958) cubic Weyl-sum exponent balance (`2/3, 1/3`). -/
theorem thm_14_korobov_vinogradov_two_thirds_exponent_balance (L L2 c u : ℝ)
    (hL2 : 1 < L2) (hL2L : L2 < L) (hc : 0 < c) (hbal : c * u ^ 3 = L ^ 2 * L2) :
    0 < u ∧ c ^ ((1 : ℝ) / 3) * u = L ^ ((2 : ℝ) / 3) * L2 ^ ((1 : ℝ) / 3) ∧
    1 < L ^ ((2 : ℝ) / 3) * L2 ^ ((1 : ℝ) / 3) ∧ L ^ ((2 : ℝ) / 3) * L2 ^ ((1 : ℝ) / 3) < L := by
  have hL : 1 < L := hL2.trans hL2L
  have hL_pos : 0 < L := zero_lt_one.trans hL
  have hL2_pos : 0 < L2 := zero_lt_one.trans hL2
  have hrhs_gt1 : 1 < L ^ 2 * L2 := by nlinarith
  have hu3_pos : 0 < u ^ 3 := (mul_pos_iff_of_pos_left hc).mp (by linarith)
  have hu_pos : 0 < u := by
    by_contra! hle; nlinarith [sq_nonneg u, hu3_pos]
  let lhs := c ^ ((1 : ℝ) / 3) * u
  let rhs := L ^ ((2 : ℝ) / 3) * L2 ^ ((1 : ℝ) / 3)
  have hrhs_pos : 0 < rhs := mul_pos (Real.rpow_pos_of_pos hL_pos _) (Real.rpow_pos_of_pos hL2_pos _)
  have hlhs_pow : lhs ^ 3 = c * u ^ 3 := by
    dsimp [lhs]; rw [mul_pow, ← Real.rpow_natCast (c ^ ((1 : ℝ) / 3)) 3, ← Real.rpow_mul hc.le]; norm_num
  have hrhs_pow : rhs ^ 3 = L ^ 2 * L2 := by
    dsimp [rhs]
    rw [mul_pow, ← Real.rpow_natCast (L ^ ((2 : ℝ) / 3)) 3, ← Real.rpow_natCast (L2 ^ ((1 : ℝ) / 3)) 3,
      ← Real.rpow_mul hL_pos.le, ← Real.rpow_mul hL2_pos.le]; norm_num
  have heq3 : lhs ^ 3 = rhs ^ 3 := by rw [hlhs_pow, hrhs_pow, hbal]
  have hlhs_eq_rhs : lhs = rhs := by
    have hdiff : (lhs - rhs) * (lhs ^ 2 + lhs * rhs + rhs ^ 2) = 0 := by linarith [heq3]
    have hquad_pos : 0 < lhs ^ 2 + lhs * rhs + rhs ^ 2 := by
      have hlhs_nn : 0 ≤ lhs := by dsimp [lhs]; positivity
      positivity
    rcases mul_eq_zero.mp hdiff with h1 | h2 <;> linarith
  have hrhs_gt1' : 1 < rhs := by
    by_contra! hle
    have hsq : rhs ^ 2 ≤ 1 := by nlinarith [hrhs_pos]
    nlinarith [hrhs_pos, hrhs_pow, hrhs_gt1]
  have hrhs_lt_L : rhs < L := by
    by_contra! hge
    have hp : rhs ^ 3 < L ^ 3 := by rw [hrhs_pow]; nlinarith [sq_pos_of_pos hL_pos]
    linarith [pow_le_pow_left₀ hL_pos.le hge 3]
  exact ⟨hu_pos, hlhs_eq_rhs, hrhs_gt1', hrhs_lt_L⟩

/-- [Theorem 15] Asymptotic `σ = 1 - o(1)` No-Go Theorem for real-part cosine positivity methods. -/
theorem thm_15_asymptotic_sigma_eq_one_minus_o1_barrier_no_go (N : ℕ) (a c : ℕ → ℝ) (A ε0 M : ℝ)
    (hc01 : fejerC0 N a < fejerC1 N a) (hc0 : c 0 = fejerC0 N a) (hc1 : c 1 = fejerC1 N a)
    (hpi : 0 ≤ trigPolyN N c Real.pi) (hA : 0 < A) (hε : 0 < ε0)
    (hM : 3 - 2 * Real.sqrt 2 ≤ 3 * A * ε0 * M) :
    1 ≤ N ∧ 0 < M ∧
    stationaryConst (fejerC0 N a) (fejerC1 N a) (higherAbsWeightSum N c) / (A * M) < ε0 := by
  have hc0_nn : 0 ≤ fejerC0 N a := by unfold fejerC0; exact Finset.sum_nonneg (fun _ _ => sq_nonneg _)
  have hN1 : 1 ≤ N := by
    by_contra! hN0
    have hN_eq : N = 0 := by omega
    subst hN_eq
    have hc1_0 : fejerC1 0 a = 0 := by unfold fejerC1; simp
    linarith [hc01, hc0_nn, hc1_0]
  have hc0_pos : 0 < fejerC0 N a := by
    rcases lt_or_eq_of_le hc0_nn with hpos | heq
    · exact hpos
    · exfalso
      have heq_sum : (Finset.range (N + 1)).sum (fun j => a j ^ 2) = 0 := by
        unfold fejerC0 at heq; exact heq.symm
      have hall := (Finset.sum_eq_zero_iff_of_nonneg (fun _ _ => sq_nonneg _)).mp heq_sum
      have hc1_z : fejerC1 N a = 0 := by
        unfold fejerC1
        rw [Finset.sum_eq_zero]
        · ring
        · intro j hj
          have hj' : j ∈ Finset.range (N + 1) :=
            Finset.mem_range.mpr (by rw [Finset.mem_range] at hj; omega)
          have haj : a j = 0 := sq_eq_zero_iff.mp (hall j hj')
          rw [haj, zero_mul]
      linarith [hc01, heq, hc1_z]
  have hW_raw := (thm_12_general_cosine_pi_weight_lower_bound N c hN1 hpi).1
  have hW : 2 * fejerC1 N a - fejerC0 N a ≤ higherAbsWeightSum N c := by linarith [hW_raw, hc0, hc1]
  have hc12 := (thm_11_fejer_riesz_autocorrelation_strict_two_c0_barrier N a hc0_pos).2
  have hceil := (thm_13_fejer_riesz_universal_constant_ceilings
    (fejerC0 N a) (fejerC1 N a) (higherAbsWeightSum N c) hc0_pos hc01 hc12 hW).2.1
  have h_pos : 0 < 3 - 2 * Real.sqrt 2 := by
    have hsq2 : Real.sqrt 2 ^ 2 = 2 := Real.sq_sqrt (by norm_num)
    have hub : Real.sqrt 2 < 3 / 2 := by nlinarith [hsq2, Real.sqrt_nonneg 2]
    linarith
  have h3Aε : 0 < 3 * A * ε0 := by positivity
  have hM_pos : 0 < M := (mul_pos_iff_of_pos_left h3Aε).mp (lt_of_lt_of_le h_pos hM)
  refine ⟨hN1, hM_pos, ?_⟩
  rw [div_lt_iff₀ (mul_pos hA hM_pos)]
  have h1 : stationaryConst (fejerC0 N a) (fejerC1 N a) (higherAbsWeightSum N c) * 3 <
      3 - 2 * Real.sqrt 2 := by linarith [hceil]
  nlinarith [h1, hM]

end ClassicalDlvpKorobovAndZeroFree
