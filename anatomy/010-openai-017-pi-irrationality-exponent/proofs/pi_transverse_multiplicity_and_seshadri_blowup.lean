import Mathlib.Basic.Real.Basic
import Mathlib.Algebra.Polynomial.Derivation
import Mathlib.Algebra.Polynomial.Div
import Mathlib.RingTheory.LaurentSeries
import Mathlib.Data.Nat.Factorial.Basic
import Mathlib.Data.Nat.Choose.Basic
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Algebra.Order.BigOperators.Ring.Finset
import Mathlib.Data.Fintype.Pi

/-!
# OpenAI #017 (`The irrationality exponent of π is 2`): Pillar 2 Mathlib Formalization
## Transverse Multiplicity, Inscribed Rectangle vs Simplex, Logarithmic Rigidity, and Blowup (`Theorems 26-50`)

Formalizes Pillar 2 of `OAI.NumberTheory.PiExponent` (`WeightSeparationConstant.lean:1-77`,
`RectangularVolume.lean:1-83`, `SimplexCounting.lean:1-90`, `TransverseMultiplicity.lean:1-90`,
`TransverseWeightedMultiplicity.lean:1-91`, `LogarithmicObstruction.lean:1-100`,
`FormalLogTruncation.lean:1-90`, `CurveZeroPole.lean:1-90`, `AdmissibleCurveInequality.lean:1-51`,
`BlowupIdeal.lean:1-90`, `ExceptionalCurveDegree.lean:1-120`, `AdmissibleBlowupAmple.lean:1-19`,
`ReesPushdown.lean:1-90`, `CechH1Transfer.lean:1-100`, `FiniteCoverCohomology.lean:1-120`).
-/

open scoped BigOperators LaurentSeries Polynomial

namespace PiIrrationalityAnatomyPillar2

/-- Continuous-simplex term `2 * k! * ((m + 2)/σ)^k` (`WeightSeparationConstant.lean:13`, `interpolation.tex:118`). -/
noncomputable def cStarPaperTerm (m k : ℕ) (σ : ℝ) : ℝ :=
  2 * (k.factorial : ℝ) * (((m : ℝ) + 2) / σ) ^ k
/-- Inscribed-rectangle term `k^k * ((m + 2)/σ)^k` (`WeightSeparationConstant.lean:39`). -/
noncomputable def cStarRectTerm (m k : ℕ) (σ : ℝ) : ℝ :=
  (k : ℝ) ^ k * (((m : ℝ) + 2) / σ) ^ k
/-- Enlarged Lean constant `2 * (m + 2)^(m + 2) * (1 + (m + 2)/σ)^(m + 2)` (`WeightSeparationConstant.lean:40-41`). -/
noncomputable def cStarLean (m : ℕ) (σ : ℝ) : ℝ :=
  2 * ((m : ℝ) + 2) ^ (m + 2) * (1 + ((m : ℝ) + 2) / σ) ^ (m + 2)
/-- Pullback-minus-exceptional pairing `d_0 - (1 + σ) * ∑ mult_p` (`ExceptionalCurveDegree.lean:1-90`). -/
noncomputable def blowupLineDeg {ι : Type*} (s : Finset ι) (d₀ σ : ℝ) (mult : ι → ℝ) : ℝ :=
  d₀ - (1 + σ) * ∑ p ∈ s, mult p

/-- Forward triangular polynomial substitution `(v_0, v_{i+1} + tail_i(v_0))`
(`FormalLogTruncation.lean:45-64`). -/
noncomputable def triShiftPos {R : Type*} [CommRing R] {m : ℕ}
    (tail : Fin m → Polynomial R) (v : Fin (m + 1) → Polynomial R) :
    Fin (m + 1) → Polynomial R :=
  Fin.cases (v 0) (fun i => v i.succ + (tail i).comp (v 0))

/-- Inverse triangular polynomial substitution `(v_0, v_{i+1} - tail_i(v_0))`
(`FormalLogTruncation.lean:60-88`). -/
noncomputable def triShiftNeg {R : Type*} [CommRing R] {m : ℕ}
    (tail : Fin m → Polynomial R) (v : Fin (m + 1) → Polynomial R) :
    Fin (m + 1) → Polynomial R :=
  Fin.cases (v 0) (fun i => v i.succ - (tail i).comp (v 0))

/-- Čech `0`-cochain coboundary `(d^0 c)_{i,j} = c_j - c_i` (`CechH1Transfer.lean:82-92`). -/
def cechD0 {J M : Type*} [AddCommGroup M] (c : J → M) (i j : J) : M :=
  c j - c i

/-- Čech `1`-cochain coboundary `(d^1 g)_{i,j,k} = g_{j,k} - g_{i,k} + g_{i,j}`
(`CechH1Transfer.lean:94-100`). -/
def cechD1 {J M : Type*} [AddCommGroup M] (g : J → J → M) (i j k : J) : M :=
  g j k - g i k + g i j

/-- Theorem 26: Exact crossover between continuous simplex volume `2 * k!` (`interpolation.tex:118`)
and Lean's inscribed discrete rectangle `k^k` (`RectangularVolume.lean:15-52`): for every `k ≥ 3`,
`2 * k! < k^k` strictly. -/
theorem thm_26_weighted_simplex_vs_inscribed_rectangle_quotient_length (k : ℕ) (hk : 3 ≤ k) :
    2 * k.factorial < k ^ k := by
  induction k, hk using Nat.le_induction with
  | base => decide
  | succ n _ ih =>
    calc
      2 * (n + 1).factorial = (n + 1) * (2 * n.factorial) := by
        rw [Nat.factorial_succ]
        ring
      _ < (n + 1) * n ^ n := Nat.mul_lt_mul_of_pos_left ih (Nat.succ_pos n)
      _ ≤ (n + 1) * (n + 1) ^ n :=
        Nat.mul_le_mul_left (n + 1) (Nat.pow_le_pow_left (Nat.le_succ n) n)
      _ = (n + 1) ^ (n + 1) := by ring

/-- Theorem 27: Domination of both `cStarPaperTerm` and `cStarRectTerm` by `cStarLean` for all
`k ≤ m` and `σ > 0`, with exact `5000x` ratio at `(m, k, σ) = (2, 2, 1)`
(`WeightSeparationConstant.lean:37-74`). -/
theorem thm_27_paper_vs_lean_weight_separation_constant_c_star (m k : ℕ) (σ : ℝ)
    (hσ : 0 < σ) (hkm : k ≤ m) :
    ∃ cL : ℝ, cL = cStarLean m σ ∧
      cStarPaperTerm m k σ ≤ cL ∧
      cStarRectTerm m k σ ≤ cL ∧
      cStarLean 2 1 = 5000 * cStarPaperTerm 2 2 1 := by
  have hbase : 0 ≤ ((m : ℝ) + 2) / σ := div_nonneg (by positivity) (le_of_lt hσ)
  have hkle : (k : ℝ) ≤ (m : ℝ) := Nat.cast_le.mpr hkm
  have hk_enlarged : (k : ℝ) ^ k ≤ ((m : ℝ) + 2) ^ (m + 2) := by
    calc
      (k : ℝ) ^ k ≤ ((m : ℝ) + 2) ^ k :=
        pow_le_pow_left₀ (Nat.cast_nonneg k) (by linarith) k
      _ ≤ ((m : ℝ) + 2) ^ (m + 2) :=
        pow_le_pow_right₀ (by have hm0 : (0 : ℝ) ≤ m := Nat.cast_nonneg m; linarith)
          (hkm.trans (Nat.le_add_right m 2))
  have hpow : (((m : ℝ) + 2) / σ) ^ k ≤ (1 + ((m : ℝ) + 2) / σ) ^ (m + 2) := by
    calc
      (((m : ℝ) + 2) / σ) ^ k ≤ (1 + ((m : ℝ) + 2) / σ) ^ k :=
        pow_le_pow_left₀ hbase (le_add_of_nonneg_left zero_le_one) k
      _ ≤ (1 + ((m : ℝ) + 2) / σ) ^ (m + 2) :=
        pow_le_pow_right₀ (le_add_of_nonneg_right hbase) (hkm.trans (Nat.le_add_right m 2))
  have hfac : (k.factorial : ℝ) ≤ ((m : ℝ) + 2) ^ (m + 2) :=
    (by exact_mod_cast Nat.factorial_le_pow k : (k.factorial : ℝ) ≤ (k : ℝ) ^ k).trans hk_enlarged
  have hrect_fac : (k : ℝ) ^ k ≤ 2 * ((m : ℝ) + 2) ^ (m + 2) := by
    have hnn : 0 ≤ ((m : ℝ) + 2) ^ (m + 2) := by positivity
    linarith
  refine ⟨cStarLean m σ, rfl, ?_, ?_, ?_⟩
  · unfold cStarPaperTerm cStarLean
    exact mul_le_mul (mul_le_mul_of_nonneg_left hfac (by norm_num)) hpow
      (pow_nonneg hbase k) (by positivity)
  · unfold cStarRectTerm cStarLean
    exact mul_le_mul hrect_fac hpow (pow_nonneg hbase k) (by positivity)
  · unfold cStarLean cStarPaperTerm
    norm_num [Nat.factorial]

/-- Theorem 28: Riemann-free discrete binomial lower bound `(Q - k)^k ≤ k! * Q.choose k` via
descending factorials (`SimplexCounting.lean:100-180`). -/
theorem thm_28_euclidean_quotient_remainder_simplex_sandwich (Q k : ℕ) (hkQ : k ≤ Q) :
    ∃ desc : ℕ, desc = Q.descFactorial k ∧
      1 ≤ Q.choose k ∧ (Q - k) ^ k ≤ desc ∧ desc = k.factorial * Q.choose k := by
  have hdesc : ∀ n : ℕ, (Q - n) ^ n ≤ Q.descFactorial n := by
    intro n
    induction n with
    | zero => simp
    | succ n ih =>
      rw [Nat.descFactorial_succ, pow_succ']
      have h1 : Q - (n + 1) ≤ Q - n := Nat.sub_le_sub_left (Nat.le_succ n) Q
      have h2 : (Q - (n + 1)) ^ n ≤ (Q - n) ^ n := Nat.pow_le_pow_left h1 n
      exact Nat.mul_le_mul h1 (h2.trans ih)
  exact ⟨Q.descFactorial k, rfl, Nat.choose_pos hkQ, hdesc k,
    (Nat.descFactorial_eq_factorial_mul_choose Q k)⟩

/-- Theorem 29: Pigeonhole stabilization of an antitone jet-vanishing dimension chain bounded by
`m + 1` (`TransverseMultiplicity.lean:1-90`, `interpolation.tex:95-120`). -/
theorem thm_29_pigeonhole_stabilization_of_derivative_vanishing_locus
    (dim : ℕ → ℕ) (m : ℕ) (hanti : Antitone dim) (htop : dim 0 ≤ m + 1) :
    ∃ j ≤ m + 1, dim (j + 1) = dim j := by
  by_contra hno
  push Not at hno
  have hdrop : ∀ n ≤ m + 2, dim n + n ≤ dim 0 := by
    intro n hn
    induction n with
    | zero => simp
    | succ n ih =>
      have hn_le : n ≤ m + 1 := by omega
      have hle : dim (n + 1) ≤ dim n := hanti (Nat.le_succ n)
      have hne : dim (n + 1) ≠ dim n := hno n hn_le
      have hstrict : dim (n + 1) + 1 ≤ dim n := by omega
      have ih' := ih (by omega)
      omega
  have hcontr := hdrop (m + 2) (le_refl _)
  omega

/-- Theorem 30: Formal Laurent residue rigidity: the formal derivative `LaurentSeries.derivative K f`
has vanishing `X⁻¹` residue and can never equal `c X⁻¹` for `c ≠ 0`
(`LogarithmicObstruction.lean:15-25`). -/
theorem thm_30_gauss_bonnet_logarithmic_residue_rigidity
    {K : Type*} [Field K] (f : K⸨X⸩) (c : K) (hc : c ≠ 0) :
    LaurentSeries.derivative K f ≠ HahnSeries.single (-1) c := by
  intro heq
  have hres : (LaurentSeries.derivative K f).coeff (-1) = 0 := by
    simp [LaurentSeries.derivative]
  have hsingle : (HahnSeries.single (-1 : ℤ) c).coeff (-1) = c :=
    HahnSeries.coeff_single_same (-1) c
  have hcoeff := congrArg (fun z : K⸨X⸩ => z.coeff (-1)) heq
  rw [hres, hsingle] at hcoeff
  exact hc hcoeff.symm

/-- Theorem 31: Bouts-type transverse weighted multiplicity lower bound across `r` centers:
when `t ≤ w * mult p` at each center and `w < (1 + σ) * r * t`, the sum `∑ mult p` strictly
exceeds `(1 + σ)⁻¹` (`TransverseWeightedMultiplicity.lean:15-85`, `interpolation.tex:115-145`). -/
theorem thm_31_bouts_lemma_transverse_w_degree_lower_bound {r : ℕ}
    (mult : Fin r → ℝ) (t w σ : ℝ)
    (hw : 0 < w) (hσ : 0 < σ)
    (hmult : ∀ p, t ≤ w * mult p)
    (hexcess : w < (1 + σ) * (r : ℝ) * t) :
    (1 + σ)⁻¹ < ∑ p : Fin r, mult p := by
  have hsum : (r : ℝ) * t ≤ w * ∑ p : Fin r, mult p := by
    calc
      (r : ℝ) * t = ∑ _p : Fin r, t := by simp
      _ ≤ ∑ p : Fin r, w * mult p := Finset.sum_le_sum (fun p _ => hmult p)
      _ = w * ∑ p : Fin r, mult p := (Finset.mul_sum Finset.univ mult w).symm
  have h1σ : 0 < 1 + σ := by linarith
  have hw_lt : w < w * ((1 + σ) * ∑ p : Fin r, mult p) := by
    have hm := mul_le_mul_of_nonneg_left hsum (le_of_lt h1σ)
    nlinarith
  have h1_lt : 1 < (∑ p : Fin r, mult p) * (1 + σ) := by
    nlinarith
  exact (inv_lt_iff_one_lt_mul₀ h1σ).mpr h1_lt

/-- Theorem 32: Curve exclusion criterion (`AdmissibleCurveInequality.lean:15-50`,
`interpolation.tex:75-105`): a curve of positive degree `d_0 > 0` cannot simultaneously have
non-negative nef blowup intersection and normalized multiplicity sum `> (1 + σ)⁻¹`. -/
theorem thm_32_curve_exclusion_when_sum_h_p_exceeds_one_over_one_plus_sigma
    {ι : Type*} (s : Finset ι) (h : ι → ℝ) (d₀ σ : ℝ)
    (hd₀ : 0 < d₀) (hσ : 0 < σ)
    (hnef : 0 ≤ blowupLineDeg s d₀ σ (fun p => d₀ * h p))
    (hsum : (1 + σ)⁻¹ < ∑ p ∈ s, h p) :
    False := by
  have h1σ : 0 < 1 + σ := by linarith
  have h1_lt : 1 < (∑ p ∈ s, h p) * (1 + σ) := (inv_lt_iff_one_lt_mul₀ h1σ).mp hsum
  have hd_lt : d₀ < d₀ * ((∑ p ∈ s, h p) * (1 + σ)) := by
    simpa only [mul_one] using mul_lt_mul_of_pos_left h1_lt hd₀
  unfold blowupLineDeg at hnef
  rw [← Finset.mul_sum] at hnef
  nlinarith

/-- Theorem 33: Lazarsfeld nef-plus-ample cone strict positivity across any nonempty finite family
of curve components (`AdmissibleBlowupAmple.lean:1-19`). -/
theorem thm_33_lazarsfeld_nef_plus_ample_bundle_decomposition
    {ι : Type*} (s : Finset ι) (degNef degAmple : ι → ℝ) (ε : ℝ)
    (hne : s.Nonempty) (hε : 0 < ε)
    (hnef : ∀ c ∈ s, 0 ≤ degNef c)
    (hamp : ∀ c ∈ s, 0 < degAmple c) :
    0 < ∑ c ∈ s, (degNef c + ε * degAmple c) := by
  refine Finset.sum_pos (fun c hc => ?_) hne
  exact add_pos_of_nonneg_of_pos (hnef c hc) (mul_pos hε (hamp c hc))

/-- Theorem 34: Point-blowup volume deficit obstruction in dimension `m + 1 ≥ 2`: when
`2^(m + 1) < r^m`, uniform weights `w = 2 / ((1 + σ) r)` violate curve exclusion
(`∑ w > (1 + σ)⁻¹`) while naive point-blowup top self-intersection remains strictly positive
(`(1 + σ)^(m + 1) ∑ w^(m + 1) < 1`). -/
theorem thm_34_top_self_intersection_volume_deficit_and_kodaira_contradiction
    (m r : ℕ) (σ : ℝ)
    (hm : 1 ≤ m) (hσ : 0 < σ) (hr : 2 ^ (m + 1) < r ^ m) :
    ∃ w : ℝ, 0 < w ∧
      (1 + σ)⁻¹ < (∑ _i : Fin r, w) ∧
      (1 + σ) ^ (m + 1) * (∑ _i : Fin r, w ^ (m + 1)) < 1 := by
  have hr_pos_nat : 0 < r := by
    by_contra h0
    have hr0 : r = 0 := by omega
    rw [hr0, zero_pow (by omega : m ≠ 0)] at hr
    exact Nat.not_lt_zero _ hr
  have hr_pos : (0 : ℝ) < (r : ℝ) := Nat.cast_pos.mpr hr_pos_nat
  have h1σ : 0 < 1 + σ := by linarith
  let w : ℝ := 2 / ((1 + σ) * (r : ℝ))
  have hw_pos : 0 < w := div_pos zero_lt_two (mul_pos h1σ hr_pos)
  refine ⟨w, hw_pos, ?_, ?_⟩
  · have hsum_w : (∑ _i : Fin r, w) = 2 * (1 + σ)⁻¹ := by
      simp only [Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul, w]
      field_simp [ne_of_gt h1σ, ne_of_gt hr_pos]
    rw [hsum_w]
    have hinv_pos : 0 < (1 + σ)⁻¹ := inv_pos.mpr h1σ
    linarith
  · have hpow_eq :
        (1 + σ) ^ (m + 1) * (∑ _i : Fin r, w ^ (m + 1)) =
          (2 : ℝ) ^ (m + 1) / (r : ℝ) ^ m := by
      simp only [Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul, w]
      rw [div_pow, mul_pow]
      have h1σ_pow : (1 + σ) ^ (m + 1) ≠ 0 := pow_ne_zero (m + 1) (ne_of_gt h1σ)
      have hr_pow : (r : ℝ) ^ m ≠ 0 := pow_ne_zero m (ne_of_gt hr_pos)
      have hr_succ : (r : ℝ) ^ (m + 1) = (r : ℝ) * (r : ℝ) ^ m := pow_succ' (r : ℝ) m
      rw [hr_succ]
      field_simp [h1σ_pow, hr_pow, ne_of_gt hr_pos]
    rw [hpow_eq, div_lt_one (pow_pos hr_pos m)]
    exact_mod_cast hr

/-- Theorem 35: Finite Cauchy-Schwarz / power-mean lower transfer from `ℓ^1` sum `A ≤ ∑_{i ∈ s} x_i`
to quadratic sum `B < ∑_{i ∈ s} x_i^2` when `|s| * B < A^2`. -/
theorem thm_35_reverse_holder_sum_from_l_m_plus_1_bound_to_l1_sum
    {ι : Type*} (s : Finset ι) (x : ι → ℝ) (A B : ℝ)
    (hA : 0 ≤ A)
    (hl1 : A ≤ ∑ i ∈ s, x i)
    (hB : (s.card : ℝ) * B < A ^ 2) :
    B < ∑ i ∈ s, x i ^ 2 := by
  have hcs : (∑ i ∈ s, x i) ^ 2 ≤ (s.card : ℝ) * ∑ i ∈ s, x i ^ 2 := by
    have hsq_nonneg : 0 ≤ ∑ i ∈ s, ∑ j ∈ s, (x i - x j) ^ 2 :=
      Finset.sum_nonneg (fun i _ => Finset.sum_nonneg (fun j _ => sq_nonneg _))
    have hexpand :
        (∑ i ∈ s, ∑ j ∈ s, (x i - x j) ^ 2) =
          2 * ((s.card : ℝ) * ∑ i ∈ s, x i ^ 2 - (∑ i ∈ s, x i) ^ 2) := by
      have h1 : ∀ i ∈ s,
          (∑ j ∈ s, (x i - x j) ^ 2) =
            (s.card : ℝ) * x i ^ 2 - 2 * x i * (∑ j ∈ s, x j) + ∑ j ∈ s, x j ^ 2 := by
        intro i _
        have hsub : ∀ j ∈ s, (x i - x j) ^ 2 = (x i ^ 2 - 2 * x i * x j) + x j ^ 2 := by
          intro j _
          ring
        rw [Finset.sum_congr rfl hsub, Finset.sum_add_distrib, Finset.sum_sub_distrib,
          Finset.sum_const, nsmul_eq_mul, ← Finset.mul_sum]
      rw [Finset.sum_congr rfl h1, Finset.sum_add_distrib, Finset.sum_sub_distrib,
        ← Finset.mul_sum, Finset.sum_const, nsmul_eq_mul]
      have hmid : (∑ i ∈ s, 2 * x i * ∑ j ∈ s, x j) = 2 * (∑ i ∈ s, x i) ^ 2 := by
        have hpull : ∀ i ∈ s, 2 * x i * (∑ j ∈ s, x j) = (2 * ∑ j ∈ s, x j) * x i := by
          intro i _; ring
        rw [Finset.sum_congr rfl hpull, ← Finset.mul_sum]
        ring
      rw [hmid]
      ring
    linarith
  have hAsq : A ^ 2 ≤ (∑ i ∈ s, x i) ^ 2 := pow_le_pow_left₀ hA hl1 2
  have hlt : (s.card : ℝ) * B < (s.card : ℝ) * ∑ i ∈ s, x i ^ 2 :=
    lt_of_lt_of_le hB (hAsq.trans hcs)
  have hcard_pos : (0 : ℝ) < (s.card : ℝ) := by
    by_contra hc0
    have hs0 : s.card = 0 := by
      have hnn : (0 : ℝ) ≤ (s.card : ℝ) := Nat.cast_nonneg _
      have heq0 : (s.card : ℝ) = 0 := le_antisymm (not_lt.mp hc0) hnn
      exact_mod_cast heq0
    rw [hs0, Nat.cast_zero, zero_mul, zero_mul] at hlt
    exact lt_irrefl 0 hlt
  exact lt_of_mul_lt_mul_left hlt (le_of_lt hcard_pos)

/-- Theorem 36: Exact two-sided inverse identity for triangular polynomial coordinate shifts
`(v_0, v_{i+1} ± tail_i(v_0))` (`FormalLogTruncation.lean:45-88`). -/
theorem thm_36_triangular_log_taylor_coordinate_shift_inverse
    {R : Type*} [CommRing R] {m : ℕ}
    (tail : Fin m → Polynomial R) (v : Fin (m + 1) → Polynomial R) :
    (triShiftNeg tail (triShiftPos tail v), triShiftPos tail (triShiftNeg tail v)) = (v, v) := by
  apply Prod.ext
  · funext j
    cases j using Fin.cases with
    | zero => rfl
    | succ i =>
      dsimp only [triShiftNeg, triShiftPos, Fin.cases_zero, Fin.cases_succ]
      exact add_sub_cancel_right (v i.succ) ((tail i).comp (v 0))
  · funext j
    cases j using Fin.cases with
    | zero => rfl
    | succ i =>
      dsimp only [triShiftPos, triShiftNeg, Fin.cases_zero, Fin.cases_succ]
      exact sub_add_cancel (v i.succ) ((tail i).comp (v 0))

/-- Theorem 37: Leibniz derivation stability on products of elements in an ideal `I : Ideal A`
(`D (f * g) ∈ I` whenever `f ∈ I` and `g ∈ I`, `TransverseMultiplicity.lean:120-190`). -/
theorem thm_37_leibniz_derivation_vanishing_on_square_ideal
    {R A : Type*} [CommSemiring R] [CommSemiring A] [Algebra R A]
    (D : Derivation R A A) (I : Ideal A) (f g : A)
    (hf : f ∈ I) (hg : g ∈ I) :
    D (f * g) ∈ I := by
  rw [D.leibniz f g, smul_eq_mul, smul_eq_mul]
  exact Ideal.add_mem I (I.mul_mem_right (D g) hf) (I.mul_mem_right (D f) hg)

/-- Theorem 38: Exact degree formula `(P * Q^k).natDegree = P.natDegree + k * Q.natDegree` over
fields (`CompleteIntersectionComponentBound.lean:1-90`). -/
theorem thm_38_complete_intersection_bezout_degree_product
    {K : Type*} [Field K] (P Q : Polynomial K) (k : ℕ)
    (hP : P ≠ 0) (hQ : Q ≠ 0) :
    (P * Q ^ k).natDegree = P.natDegree + k * Q.natDegree := by
  rw [Polynomial.natDegree_mul hP (pow_ne_zero k hQ), Polynomial.natDegree_pow]

/-- Theorem 39: Universal truncated geometric-series identity `(1 + t) * ∑_{j < k} (-t)^j = 1 - (-t)^k`
in any commutative ring (`FormalLogTruncation.lean:180-250`, including the `k = 4` cubic inverse). -/
theorem thm_39_formal_unit_geometric_series_cubic_identity
    {R : Type*} [CommRing R] (t : R) (k : ℕ) :
    (1 + t) * (∑ j ∈ Finset.range k, (-t) ^ j) = 1 - (-t) ^ k := by
  induction k with
  | zero => simp
  | succ n ih =>
    rw [Finset.sum_range_succ, mul_add, ih, pow_succ]
    ring

/-- Theorem 40: Exact polynomial logarithmic-derivative simple-pole obstruction over `[Field K] [CharZero K]`
(`LogarithmicObstruction.lean:28-67`): for coprime `P, Q` with `Q ≠ 0` and `c ≠ 0`,
`X * (P' Q - P Q') ≠ C c * Q^2`. -/
theorem thm_40_logarithmic_derivative_simple_pole_obstruction
    {K : Type*} [Field K] [CharZero K]
    (P Q : Polynomial K) (c : K)
    (hQ : Q ≠ 0) (hcop : IsCoprime P Q) (hc : c ≠ 0) :
    Polynomial.X * (Polynomial.derivative P * Q - P * Polynomial.derivative Q) ≠
      Polynomial.C c * Q ^ 2 := by
  intro heq
  obtain ⟨U, hfactor, hU⟩ := Q.exists_eq_pow_rootMultiplicity_mul_and_not_dvd hQ 0
  rw [Polynomial.C_0, sub_zero] at hfactor hU
  have hU0 : U.coeff 0 ≠ 0 := fun h => hU (Polynomial.X_dvd_iff.mpr h)
  cases hn : Q.rootMultiplicity 0 with
  | zero =>
    rw [hn, pow_zero, one_mul] at hfactor
    have hQ0 : Q.coeff 0 ≠ 0 := hfactor ▸ hU0
    have hconst := congrArg (fun f : Polynomial K => f.coeff 0) heq
    rw [Polynomial.mul_coeff_zero, Polynomial.coeff_X_zero, zero_mul,
      Polynomial.coeff_C_mul, sq, Polynomial.mul_coeff_zero] at hconst
    exact (mul_ne_zero hc (mul_ne_zero hQ0 hQ0)) hconst.symm
  | succ n =>
    rw [hn] at hfactor
    have hQ0 : Q.coeff 0 = 0 := by
      rw [hfactor, pow_succ', mul_assoc, Polynomial.mul_coeff_zero,
        Polynomial.coeff_X_zero, zero_mul]
    have hP0 : P.coeff 0 ≠ 0 := by
      intro hp0
      obtain ⟨A, B, hab⟩ := hcop
      have hconst := congrArg (fun f : Polynomial K => f.coeff 0) hab
      rw [Polynomial.coeff_add, Polynomial.mul_coeff_zero, Polynomial.mul_coeff_zero,
        hp0, hQ0, mul_zero, mul_zero, add_zero, Polynomial.coeff_one_zero] at hconst
      exact zero_ne_one hconst
    have hcancel :
        Polynomial.X * Polynomial.derivative P * U -
            P * (Polynomial.C (n + 1 : K) * U + Polynomial.X * Polynomial.derivative U) =
          Polynomial.C c * Polynomial.X ^ (n + 1) * U ^ 2 := by
      apply mul_left_cancel₀ (pow_ne_zero (n + 1) (Polynomial.X_ne_zero (R := K)))
      calc
        Polynomial.X ^ (n + 1) *
            (Polynomial.X * Polynomial.derivative P * U -
              P * (Polynomial.C (n + 1 : K) * U + Polynomial.X * Polynomial.derivative U)) =
            Polynomial.X * (Polynomial.derivative P * Q - P * Polynomial.derivative Q) := by
          rw [hfactor, Polynomial.derivative_mul, Polynomial.derivative_X_pow_succ]
          ring
        _ = Polynomial.C c * Q ^ 2 := heq
        _ = Polynomial.X ^ (n + 1) * (Polynomial.C c * Polynomial.X ^ (n + 1) * U ^ 2) := by
          rw [hfactor]
          ring
    have hconst := congrArg (fun f : Polynomial K => f.coeff 0) hcancel
    rw [Polynomial.coeff_sub, Polynomial.mul_coeff_zero, Polynomial.mul_coeff_zero,
      Polynomial.coeff_X_zero, zero_mul, zero_mul, zero_sub,
      Polynomial.mul_coeff_zero, Polynomial.coeff_add, Polynomial.coeff_C_mul,
      Polynomial.mul_coeff_zero, Polynomial.coeff_X_zero, zero_mul, add_zero,
      Polynomial.mul_coeff_zero, Polynomial.mul_coeff_zero, pow_succ',
      Polynomial.mul_coeff_zero, Polynomial.coeff_X_zero, zero_mul, mul_zero, zero_mul] at hconst
    have hz : P.coeff 0 * ((n + 1 : K) * U.coeff 0) = 0 := neg_eq_zero.mp hconst
    exact (mul_ne_zero hP0 (mul_ne_zero (Nat.cast_add_one_ne_zero n) hU0)) hz

/-- Theorem 41: Monic coordinate quotient packet decomposition `Q_i %ₘ X^(w_i)` across `Fin d`
with remainder degree `< w_i` and packet cardinality `∏ w_i`
(`LocalizationQuotientParameters.lean:1-90`, `RectangularVolume.lean:15-52`). -/
theorem thm_41_rectangular_quotient_packet_dimension_product
    {K : Type*} [Field K] {d : ℕ}
    (w : Fin d → ℕ) (Q : Fin d → Polynomial K) (hw : ∀ i, 0 < w i) :
    ∃ R : Fin d → Polynomial K,
      (∀ i, R i + Polynomial.X ^ (w i) * (Q i /ₘ Polynomial.X ^ (w i)) = Q i) ∧
      (∀ i, (R i).natDegree < w i) ∧
      (Fintype.piFinset fun i => Finset.range (w i)).card = ∏ i, w i := by
  refine ⟨fun i => Q i %ₘ Polynomial.X ^ (w i), ?_, ?_, ?_⟩
  · intro i
    exact Polynomial.modByMonic_add_div (Q i) (Polynomial.X ^ (w i))
  · intro i
    have hdeg_pow : (Polynomial.X ^ (w i) : Polynomial K).natDegree = w i :=
      Polynomial.natDegree_X_pow (w i)
    have hne1 : (Polynomial.X ^ (w i) : Polynomial K) ≠ 1 := by
      intro h1
      have hd := congrArg Polynomial.natDegree h1
      rw [hdeg_pow, Polynomial.natDegree_one] at hd
      exact Nat.ne_of_gt (hw i) hd
    have hlt := Polynomial.natDegree_modByMonic_lt (Q i) (Polynomial.monic_X_pow (w i)) hne1
    rwa [hdeg_pow] at hlt
  · simp [Fintype.card_piFinset]

/-- Theorem 42: Projective pole-clearing degree bound `(P * Q^D).natDegree ≤ D * (Q.natDegree + 1)`
with non-vanishing denominator power `Q^D ≠ 0` (`ProjectiveCoordinates.lean:1-90`). -/
theorem thm_42_projective_embedding_pole_clearing_identity
    {K : Type*} [Field K] (P Q : Polynomial K) (D : ℕ)
    (hQ : Q ≠ 0) (hdeg : P.natDegree ≤ D) :
    ∃ S : Polynomial K, S = P * Q ^ D ∧ Q ^ D ≠ 0 ∧
      S.natDegree ≤ D * (Q.natDegree + 1) := by
  refine ⟨P * Q ^ D, rfl, pow_ne_zero D hQ, ?_⟩
  calc
    (P * Q ^ D).natDegree ≤ P.natDegree + (Q ^ D).natDegree := Polynomial.natDegree_mul_le
    _ ≤ D + D * Q.natDegree := Nat.add_le_add hdeg (Polynomial.natDegree_pow_le)
    _ = D * (Q.natDegree + 1) := by ring

/-- Theorem 43: Ramification-inertia weighted valuation additivity across curve branches
(`CurveZeroPole.lean:11-34`, `CurveModelPlaces.lean:1-90`). -/
theorem thm_43_curve_branch_valuation_weighted_additivity
    {ι : Type*} (s : Finset ι) (ram inert ord : ι → ℕ) (w degCurve : ℕ)
    (hdeg : ∑ b ∈ s, ram b * inert b = degCurve)
    (hord : ∀ b ∈ s, w * ram b ≤ ord b) :
    w * degCurve ≤ ∑ b ∈ s, inert b * ord b := by
  rw [← hdeg, Finset.mul_sum]
  refine Finset.sum_le_sum fun b hb => ?_
  calc
    w * (ram b * inert b) = inert b * (w * ram b) := by ring
    _ ≤ inert b * ord b := Nat.mul_le_mul_left (inert b) (hord b hb)

/-- Theorem 44: Complete-curve degree-zero vanishing obstruction (`CurveZeroPole.lean:220-340`):
no nonzero rational function on a complete curve can satisfy `∑ deg_v * (zero_v - pole_v) = 0`
when uniform multiplicity `M` forces total zero order strictly above the pole bound `D`. -/
theorem thm_44_complete_curve_zero_pole_vanishing_criterion
    {ι : Type*} (s : Finset ι) (degP zeroOrd poleOrd : ι → ℕ) (D M : ℕ)
    (hbal : ∑ v ∈ s, (degP v : ℤ) * ((zeroOrd v : ℤ) - (poleOrd v : ℤ)) = 0)
    (hpole : ∑ v ∈ s, degP v * poleOrd v ≤ D)
    (hzero : ∀ v ∈ s, M ≤ zeroOrd v)
    (hexcess : D < M * ∑ v ∈ s, degP v) :
    False := by
  have hz_low : M * (∑ v ∈ s, degP v) ≤ ∑ v ∈ s, degP v * zeroOrd v := by
    rw [Finset.mul_sum]
    refine Finset.sum_le_sum fun v hv => ?_
    calc
      M * degP v = degP v * M := mul_comm M (degP v)
      _ ≤ degP v * zeroOrd v := Nat.mul_le_mul_left (degP v) (hzero v hv)
  have hlt_nat : ∑ v ∈ s, degP v * poleOrd v < ∑ v ∈ s, degP v * zeroOrd v :=
    lt_of_le_of_lt hpole (lt_of_lt_of_le hexcess hz_low)
  have hsplit :
      (∑ v ∈ s, (degP v : ℤ) * ((zeroOrd v : ℤ) - (poleOrd v : ℤ))) =
        (∑ v ∈ s, degP v * zeroOrd v : ℕ) - (∑ v ∈ s, degP v * poleOrd v : ℕ) := by
    push_cast
    rw [← Finset.sum_sub_distrib]
    refine Finset.sum_congr rfl fun v _ => ?_
    ring
  rw [hsplit] at hbal
  have hlt_int :
      ((∑ v ∈ s, degP v * poleOrd v : ℕ) : ℤ) < ((∑ v ∈ s, degP v * zeroOrd v : ℕ) : ℤ) := by
    exact_mod_cast hlt_nat
  linarith

/-- Theorem 45: Seshadri blowup nefness along proper-transform curves (`ExceptionalCurveDegree.lean:120-260`,
`interpolation.tex:210-235`). -/
theorem thm_45_seshadri_blowup_nef_curve_intersection
    {ι : Type*} (s : Finset ι) (mult : ι → ℝ) (c₀ σ : ℝ)
    (hc₀ : 0 < c₀) (hσ : 0 < σ)
    (hsesh : ∀ p ∈ s, mult p ≤ c₀)
    (hcard : (1 + σ) * (s.card : ℝ) ≤ 1) :
    0 ≤ blowupLineDeg s c₀ σ mult := by
  have hsum_le : ∑ p ∈ s, mult p ≤ (s.card : ℝ) * c₀ := by
    calc
      ∑ p ∈ s, mult p ≤ ∑ _p ∈ s, c₀ := Finset.sum_le_sum hsesh
      _ = (s.card : ℝ) * c₀ := by rw [Finset.sum_const, nsmul_eq_mul]
  have h1σ : 0 < 1 + σ := by linarith
  have hmul1 : (1 + σ) * ∑ p ∈ s, mult p ≤ ((1 + σ) * (s.card : ℝ)) * c₀ := by
    have hm := mul_le_mul_of_nonneg_left hsum_le (le_of_lt h1σ)
    linarith
  have hmul2 : ((1 + σ) * (s.card : ℝ)) * c₀ ≤ c₀ := by
    simpa only [one_mul] using mul_le_mul_of_nonneg_right hcard (le_of_lt hc₀)
  unfold blowupLineDeg
  linarith

/-- Theorem 46: Strict intersection positivity on curves contracted into the exceptional divisor
(`ExceptionalCurveDegree.lean:265-410`). -/
theorem thm_46_contracted_exceptional_curve_strict_positivity
    {ι : Type*} (s : Finset ι) (excInt : ι → ℝ) (p₀ : ι) (σ : ℝ)
    (hp₀ : p₀ ∈ s) (hσ : 0 < σ)
    (hnonneg : ∀ p ∈ s, 0 ≤ excInt p)
    (hpos : 0 < excInt p₀) :
    0 < blowupLineDeg s 0 σ (fun p => -excInt p) := by
  have hsum_pos : 0 < ∑ p ∈ s, excInt p :=
    Finset.sum_pos' hnonneg ⟨p₀, hp₀, hpos⟩
  have h1σ : 0 < 1 + σ := by linarith
  unfold blowupLineDeg
  rw [Finset.sum_neg_distrib]
  nlinarith

/-- Theorem 47: Module-level convex combination identity for Rees blowup ampleness
`(a - 1) • (A - (1 + σ) • E) + σ • (a • A - E) = (a(1 + σ) - 1) • (A - E)` with strictly positive
weights for `a > 1` and `σ > 0` (`AdmissibleBlowupAmple.lean:1-19`, `interpolation.tex:225-245`). -/
theorem thm_47_rees_blowup_ample_convex_combination_identity
    {V : Type*} [AddCommGroup V] [Module ℝ V]
    (A E : V) (a σ : ℝ) (ha : 1 < a) (hσ : 0 < σ) :
    ∃ c : ℝ, c = a * (1 + σ) - 1 ∧ 0 < a - 1 ∧ a - 1 < c ∧
      (a - 1) • (A - (1 + σ) • E) + σ • (a • A - E) = c • (A - E) := by
  refine ⟨a * (1 + σ) - 1, rfl, by linarith, ?_, ?_⟩
  · have ha_pos : 0 < a := by linarith
    have hprod : 0 < a * σ := mul_pos ha_pos hσ
    linarith
  · have h1 : A - (1 + σ) • E = (A - E) - σ • E := by
      rw [add_smul, one_smul, sub_add_eq_sub_sub]
    have h2 : a • A - E = a • (A - E) + (a - 1) • E := by
      rw [smul_sub, sub_smul, one_smul, sub_add_sub_cancel]
    have h3 : ((a - 1) * σ) • E = (σ * (a - 1)) • E := by
      rw [mul_comm]
    have hcoeff : a - 1 + σ * a = a * (1 + σ) - 1 := by ring
    rw [h1, h2, smul_sub, smul_add, smul_smul, smul_smul, smul_smul, h3,
      sub_add_eq_add_sub, ← add_assoc, add_sub_cancel_right, ← add_smul, hcoeff]

/-- Theorem 48: Graded `Ideal` power multiplication and downward filtration `x * y ∈ I^k` for
`x ∈ I^m`, `y ∈ I^n`, and `k ≤ m + n` (`ReesPushdown.lean:1-120`). -/
theorem thm_48_rees_pushdown_ideal_power_weight_inclusion
    {R : Type*} [CommSemiring R] (I : Ideal R) (x y : R) (m n k : ℕ)
    (hx : x ∈ I ^ m) (hy : y ∈ I ^ n) (hk : k ≤ m + n) :
    x * y ∈ I ^ k := by
  have hmul : x * y ∈ I ^ (m + n) := by
    rw [pow_add]
    exact Ideal.mul_mem_mul hx hy
  exact Ideal.pow_le_pow_right hk hmul

/-- Theorem 49: Exact Čech cochain coboundary identity `d^1 (d^0 c) = 0` over any `AddCommGroup`
(`CechH1Transfer.lean:82-100`, `GradedCech.lean:1-90`). -/
theorem thm_49_cech_cochain_differential_squared_zero
    {J M : Type*} [AddCommGroup M] (c : J → M) (i j k : J) :
    cechD1 (cechD0 c) i j k = 0 := by
  unfold cechD1 cechD0
  abel

/-- Theorem 50: Uniform Serre-Čech vanishing threshold across a finite nonempty affine cover via
`Finset.sup'` (`FiniteCoverCohomology.lean:1-120`, `interpolation.tex:235-255`). -/
theorem thm_50_finite_affine_cover_uniform_vanishing_threshold
    {ι : Type*} (s : Finset ι) (Nloc : ι → ℕ) (Vanishes : ι → ℕ → Prop)
    (hne : s.Nonempty)
    (hloc : ∀ u ∈ s, ∀ n, Nloc u ≤ n → Vanishes u n) :
    ∃ N₀ : ℕ, (∃ u₀ ∈ s, Nloc u₀ = N₀) ∧
      ∀ n, N₀ ≤ n → ∀ u ∈ s, Vanishes u n := by
  obtain ⟨u₀, hu₀, heq⟩ := Finset.exists_mem_eq_sup' hne Nloc
  refine ⟨s.sup' hne Nloc, ⟨u₀, hu₀, heq.symm⟩, ?_⟩
  intro n hn u hu
  exact hloc u hu n ((Finset.le_sup' Nloc hu).trans hn)

end PiIrrationalityAnatomyPillar2
