    linarith

lemma lt_abs_mem_cocompact {a : ℝ} (ha : 0 ≤ a) : {t | a < |t|} ∈ cocompact ℝ := by
  convert Ioi_union_Iio_mem_cocompact ha using 1; ext t
  simp only [mem_ofPred_eq, mem_union, mem_Ioi, mem_Iio, lt_abs, lt_neg]

lemma ZetaInvBound2 :
    ∃ C > 0, ∀ {σ : ℝ} (_ : σ ∈ Ioc 1 2) (t : ℝ) (_ : 3 < |t|),
    1 / ‖ζ (σ + t * I)‖ ≤ C * (σ - 1) ^ (-(3 : ℝ) / 4) * (Real.log |t|) ^ ((1 : ℝ) / 4) := by
  obtain ⟨A, ha, C, hC, h⟩ := ZetaUpperBnd
  obtain ⟨c, hc, h_inv⟩ := ZetaNear1BndExact
  refine ⟨(2 * C) ^ ((1 : ℝ)/ 4) * c ^ ((3 : ℝ)/ 4), by positivity, ?_⟩
  intro σ hσ t t_gt
  obtain ⟨σ_gt, σ_le⟩ := hσ
  have ht' : 3 < |2 * t| := by simp only [abs_mul, Nat.abs_ofNat]; linarith
  have hnezero: ((σ - 1) / c) ^ (-3 / 4 : ℝ) ≠ 0 := by
    have : (σ - 1) / c ≠ 0 := ne_of_gt <| div_pos (by linarith) hc
    contrapose! this
    rwa [Real.rpow_eq_zero (div_nonneg (by linarith) hc.le) (by norm_num)] at this
  calc
    _ ≤ ‖‖ζ σ‖ ^ (3 / 4 : ℝ) * ‖ζ (↑σ + 2 * ↑t * I)‖ ^ (1 / 4 : ℝ)‖ := ?_
    _ ≤ ‖((σ - 1) / c) ^ (-3 / 4 : ℝ) * ‖ζ (↑σ + 2 * ↑t * I)‖ ^ (1 / 4 : ℝ)‖ := ?_
    _ ≤ ‖((σ - 1) / c) ^ (-3 / 4 : ℝ) * C ^ (1 / 4 : ℝ) * (Real.log |2 * t|) ^ (1 / 4 : ℝ)‖ := ?_
    _ ≤ ‖((σ - 1) / c) ^ (-3 / 4 : ℝ) * C ^ (1 / 4 : ℝ) * (Real.log (|t| ^ 2)) ^ (1 / 4 : ℝ)‖ := ?_
    _ = ‖((σ - 1)) ^ (-3 / 4 : ℝ) * c ^ (3 / 4 : ℝ) * (C ^ (1 / 4 : ℝ) * (Real.log (|t| ^ 2)) ^ (1 / 4 : ℝ))‖ := ?_
    _ = ‖((σ - 1)) ^ (-3 / 4 : ℝ) * c ^ (3 / 4 : ℝ) * ((2 * C) ^ (1 / 4 : ℝ) * Real.log |t| ^ (1 / 4 : ℝ))‖ := ?_
    _ = _ := ?_
  · simp only [norm_mul]
    convert ZetaInvBound1 σ_gt using 2
    <;> exact abs_eq_self.mpr <| Real.rpow_nonneg (norm_nonneg _) _
  · have bnd1: ‖ζ σ‖ ^ (3 / 4 : ℝ) ≤ ((σ - 1) / c) ^ (-(3 : ℝ) / 4) := by
      have : ((σ - 1) / c) ^ (-(3 : ℝ) / 4) = (((σ - 1) / c) ^ (-1 : ℝ)) ^ (3 / 4 : ℝ) := by
        rw [← Real.rpow_mul ?_]
        · ring_nf
        · exact div_nonneg (by linarith) hc.le
      rw [this]
      apply Real.rpow_le_rpow (by simp [norm_nonneg]) ?_ (by norm_num)
      convert! h_inv σ ⟨σ_gt, σ_le⟩ using 1; simp [Real.rpow_neg_one, inv_div]
    simp only [norm_mul]
    apply (mul_le_mul_iff_left₀ ?_).mpr
    · convert! bnd1 using 1
      · exact abs_eq_self.mpr <| Real.rpow_nonneg (norm_nonneg _) _
      · exact abs_eq_self.mpr <| Real.rpow_nonneg (div_nonneg (by linarith) hc.le) _
    · apply lt_iff_le_and_ne.mpr ⟨(by simp), ?_⟩
      have : ζ (↑σ + 2 * ↑t * I) ≠ 0 := by
        apply riemannZeta_ne_zero_of_one_le_re (by simp [σ_gt.le])
      symm; exact fun h2 ↦ this (by simpa using h2)
  · replace h := h σ (2 * t) (by simpa using ht') ⟨?_, σ_le⟩
    · have : 0 ≤ Real.log |2 * t| := Real.log_nonneg (by linarith)
      conv => rhs; rw [mul_assoc, ← Real.mul_rpow hC.le this]
      rw [norm_mul, norm_mul]
      conv => rhs; rhs; rw [Real.norm_rpow_of_nonneg <| mul_nonneg hC.le this]
      conv => lhs; rhs; rw [Real.norm_rpow_of_nonneg <| norm_nonneg _]
      apply (mul_le_mul_iff_right₀ ?_).mpr
      · apply Real.rpow_le_rpow (norm_nonneg _) ?_ (by norm_num)
        convert h using 1
        · simp
        · rw [Real.norm_eq_abs, abs_eq_self.mpr <| mul_nonneg hC.le this]
      · simpa only [Real.norm_eq_abs, abs_pos]
    · linarith [(div_nonneg ha.1.le (Real.log_nonneg (by linarith)) : 0 ≤ A / Real.log |2 * t|)]
  · simp only [Real.log_abs, norm_mul]
    apply (mul_le_mul_iff_right₀ ?_).mpr
    · rw [← Real.log_abs, Real.norm_rpow_of_nonneg <| Real.log_nonneg (by linarith)]
      have : 1 ≤ |(|t| ^ 2)| := by
        simp only [_root_.sq_abs, _root_.abs_pow, one_le_sq_iff_one_le_abs]
        linarith
      conv => rhs; rw [← Real.log_abs, Real.norm_rpow_of_nonneg <| Real.log_nonneg this]
      apply Real.rpow_le_rpow (abs_nonneg _) ?_ (by norm_num)
      · rw [Real.norm_eq_abs, abs_eq_self.mpr <| Real.log_nonneg (by linarith)]
        rw [abs_eq_self.mpr <| Real.log_nonneg this, abs_mul, Real.log_abs, Nat.abs_ofNat]
        apply Real.log_le_log (mul_pos (by norm_num) (by linarith)) (by nlinarith)
    · apply mul_pos (abs_pos.mpr hnezero) (abs_pos.mpr ?_)
      have : C ≠ 0 := ne_of_gt hC
      contrapose! this; rwa [Real.rpow_eq_zero (by linarith) (by norm_num)] at this
  · have : (-3 : ℝ) / 4 = -((3 : ℝ)/ 4) := by norm_num
    simp only [norm_mul, mul_eq_mul_right_iff, this, ← mul_assoc]; left; left
    conv => lhs; rw [Real.div_rpow (by linarith) hc.le, Real.rpow_neg hc.le, div_inv_eq_mul, norm_mul]
  · simp only [Real.log_pow, Nat.cast_ofNat, norm_mul, Real.norm_eq_abs]
    congr! 1
    rw [Real.mul_rpow (by norm_num) hC.le, Real.mul_rpow (by norm_num) <|
        Real.log_nonneg (by linarith), abs_mul, abs_mul, ← mul_assoc, mul_comm _ |2 ^ (1 / 4)|]
  · simp only [norm_mul, Real.norm_eq_abs]
    have : (2 * C) ^ ((1 : ℝ)/ 4) * c ^ ((3 : ℝ)/ 4) =
      |(2 * C) ^ ((1 : ℝ)/ 4) * c ^ ((3 : ℝ)/ 4)| := by
      rw [abs_eq_self.mpr (by apply mul_nonneg <;> (apply Real.rpow_nonneg; linarith))]
    rw [this, abs_mul, abs_eq_self.mpr (by apply Real.rpow_nonneg; linarith), abs_eq_self.mpr (by positivity),
      abs_eq_self.mpr (by positivity), abs_eq_self.mpr (by apply Real.rpow_nonneg (Real.log_nonneg (by linarith)))]
    ring_nf

lemma deriv_fun_re {t : ℝ} {f : ℂ → ℂ} (diff : ∀ (σ : ℝ), DifferentiableAt ℂ f (↑σ + ↑t * I)) :
    (deriv fun {σ₂ : ℝ} ↦ f (σ₂ + t * I)) = fun (σ : ℝ) ↦ deriv f (σ + t * I) := by
  ext σ
  have := deriv_comp (h := fun (σ : ℝ) ↦ σ + t * I) (h₂ := f) σ (diff σ) ?_
  · simp only [deriv_add_const', _root_.Erdos970.deriv_ofReal, mul_one] at this
    exact this
  · apply DifferentiableAt.add_const _ <| _root_.Erdos970.Complex.differentiableAt_ofReal σ


lemma Zeta_eq_int_derivZeta {σ₁ σ₂ t : ℝ} (t_ne_zero : t ≠ 0) :
    (∫ σ in σ₁..σ₂, ζ' (σ + t * I)) = ζ (σ₂ + t * I) - ζ (σ₁ + t * I) := by
  have diff : ∀ (σ : ℝ), DifferentiableAt ℂ ζ (σ + t * I) := by
    intro σ
    refine differentiableAt_riemannZeta ?_
    contrapose! t_ne_zero; apply And.right; simpa [Complex.ext_iff] using t_ne_zero
  apply intervalIntegral.integral_deriv_eq_sub'
  · exact deriv_fun_re diff
  · intro s _
    apply DifferentiableAt.comp
    · exact (diff s).restrictScalars ℝ
    · exact DifferentiableAt.add_const (c := t * I) <| _root_.Erdos970.Complex.differentiableAt_ofReal _
  · apply ContinuousOn.comp (g := ζ') ?_ ?_ (mapsTo_image _ _)
    · apply HasDerivAt.continuousOn (f' := deriv <| ζ')
      intro x hx
      apply hasDerivAt_deriv_iff.mpr
      replace hx : x ≠ 1 := by
        contrapose! hx
        simp only [hx, mem_image, Complex.ext_iff, add_re, ofReal_re, mul_re, I_re, mul_zero, ofReal_im,
          I_im, mul_one, sub_self, add_zero, one_re, add_im, mul_im, zero_add, one_im, not_exists,
          not_and]
        exact fun _ _ _ ↦ t_ne_zero
      exact differentiableAt_deriv_riemannZeta hx
    · exact continuous_ofReal.continuousOn.add continuousOn_const

lemma Zeta_diff_Bnd :
    ∃ (A : ℝ) (_ : A ∈ Ioc 0 (1 / 2)) (C : ℝ) (_ : 0 < C), ∀ (σ₁ σ₂ : ℝ) (t : ℝ) (_ : 3 < |t|)
    (_ : 1 - A / Real.log |t| ≤ σ₁) (_ : σ₂ ≤ 2) (_ : σ₁ < σ₂),
    ‖ζ (σ₂ + t * I) - ζ (σ₁ + t * I)‖ ≤  C * Real.log |t| ^ 2 * (σ₂ - σ₁) := by
  obtain ⟨A, hA, C, Cpos, hC⟩ := ZetaDerivUpperBnd
  refine ⟨A, hA, C, Cpos, ?_⟩
  intro σ₁ σ₂ t t_gt σ₁_ge σ₂_le σ₁_lt_σ₂
  have t_ne_zero : t ≠ 0 := by contrapose! t_gt; simp only [t_gt, abs_zero, Nat.ofNat_nonneg]
  rw [← Zeta_eq_int_derivZeta t_ne_zero]
  convert intervalIntegral.norm_integral_le_of_norm_le_const ?_ using 1
  · congr; rw [_root_.abs_of_nonneg (by linarith)]
  · intro σ hσ; rw [uIoc_of_le σ₁_lt_σ₂.le, mem_Ioc] at hσ
    exact hC σ t t_gt ⟨le_trans σ₁_ge hσ.1.le, le_trans hσ.2 σ₂_le⟩

lemma ZetaInvBnd_aux' {t : ℝ} (logt_gt_one : 1 < Real.log |t|) : Real.log |t| < Real.log |t| ^ 9 := by
  nth_rewrite 1 [← Real.rpow_one <| Real.log |t|]
  exact mod_cast Real.rpow_lt_rpow_left_iff (y := 1) (z := 9) logt_gt_one |>.mpr (by norm_num)

lemma ZetaInvBnd_aux {t : ℝ} (logt_gt_one : 1 < Real.log |t|) : Real.log |t| ≤ Real.log |t| ^ 9 :=
    ZetaInvBnd_aux' logt_gt_one |>.le

lemma ZetaInvBnd_aux2 {A C₁ C₂ : ℝ} (Apos : 0 < A) (C₁pos : 0 < C₁) (C₂pos : 0 < C₂)
    (hA : A ≤ 1 / 2 * (C₁ / (C₂ * 2)) ^ (4 : ℝ)) :
    0 < (C₁ * A ^ (3 / 4 : ℝ) - C₂ * 2 * A)⁻¹ := by
  simp only [inv_pos, sub_pos]
  apply div_lt_iff₀ (by positivity) |>.mp
  rw [div_eq_mul_inv, ← Real.rpow_neg (by positivity), mul_assoc]
  apply lt_div_iff₀' (by positivity) |>.mp
  nth_rewrite 1 [← Real.rpow_one A]
  rw [← Real.rpow_add (by positivity)]
  norm_num
  apply Real.rpow_lt_rpow_iff (z := 4) (by positivity) (by positivity) (by positivity) |>.mp
  rw [← Real.rpow_mul (by positivity)]
  norm_num
  apply lt_of_le_of_lt hA
  rw [div_mul_comm, mul_one, Real.rpow_ofNat]
  apply half_lt_self
  positivity

lemma ZetaInvBnd :
    ∃ (A : ℝ) (_ : A ∈ Ioc 0 (1 / 2)) (C : ℝ) (_ : 0 < C), ∀ (σ : ℝ) (t : ℝ) (_ : 3 < |t|)
    (_ : σ ∈ Ico (1 - A / (Real.log |t|) ^ 9) (1 + A / (Real.log |t|) ^ 9)),
    1 / ‖ζ (σ + t * I)‖ ≤ C * (Real.log |t|) ^ (7 : ℝ) := by
  obtain ⟨C', C'pos, hC₁⟩ := ZetaInvBound2
  obtain ⟨A', hA', C₂, C₂pos, hC₂⟩ := Zeta_diff_Bnd
  set C₁ := 1 / C'
  let A := min A' <| (1 / 2 : ℝ) * (C₁ / (C₂ * 2)) ^ (4 : ℝ)
  have Apos : 0 < A := by have := hA'.1; positivity
  have Ale : A ≤ 1 / 2 := by dsimp only [A]; apply min_le_iff.mpr; left; exact hA'.2
  set C := (C₁ * A ^ (3 / 4 : ℝ) - C₂ * 2 * A)⁻¹
  have Cpos : 0 < C := by
    refine ZetaInvBnd_aux2 (by positivity) (by positivity) (by positivity) ?_
    apply min_le_right
  refine ⟨A, ⟨Apos, by linarith [hA'.2]⟩ , C, Cpos, ?_⟩
  intro σ t t_gt hσ
  have logt_gt_one := logt_gt_one t_gt.le
  have σ_ge : 1 - A / Real.log |t| ≤ σ := by
    apply le_trans ?_ hσ.1
    suffices A / Real.log |t| ^ 9 ≤ A / Real.log |t| by linarith
    exact div_le_div₀ Apos.le (by rfl) (by positivity) <| ZetaInvBnd_aux logt_gt_one
  obtain ⟨_, _, neOne⟩ := UpperBnd_aux ⟨Apos, Ale⟩ t_gt σ_ge
  set σ' := 1 + A / Real.log |t| ^ 9
  have σ'_gt : 1 < σ' := by simp only [σ', lt_add_iff_pos_right]; positivity
  have σ'_le : σ' ≤ 2 := by
    simp only [σ']
    suffices A / Real.log |t| ^ 9 < 1 by linarith
    apply div_lt_one (by positivity) |>.mpr
    exact lt_trans₄ (by linarith) logt_gt_one <| ZetaInvBnd_aux' logt_gt_one
  set s := σ + t * I
  set s' := σ' + t * I
  by_cases h0 : ‖ζ s‖ ≠ 0
  swap
  · simp only [ne_eq, not_not] at h0; simp only [h0, div_zero]; positivity
  apply div_le_iff₀ (by positivity) |>.mpr <| div_le_iff₀' (by positivity) |>.mp ?_
  have pos_aux : 0 < (σ' - 1) := by linarith
  calc
    _ ≥ ‖ζ s'‖ - ‖ζ s - ζ s'‖ := ?_
    _ ≥ C₁ * (σ' - 1) ^ ((3 : ℝ)/ 4) * Real.log |t|  ^ ((-1 : ℝ)/ 4) - C₂ * Real.log |t| ^ 2 * (σ' - σ) := ?_
    _ ≥ C₁ * (A / Real.log |t| ^ (9 : ℝ)) ^ ((3 : ℝ)/ 4) * Real.log |t| ^ ((-1 : ℝ)/ 4) - C₂ * Real.log |t| ^ (2 : ℝ) * 2 * A / Real.log |t| ^ (9 : ℝ) := ?_
    _ ≥ C₁ * A ^ ((3 : ℝ)/ 4) * Real.log |t| ^ (-7 : ℝ) - C₂ * 2 * A * Real.log |t| ^ (-7 : ℝ) := ?_
    _ = (C₁ * A ^ ((3 : ℝ)/ 4) - C₂ * 2 * A) * Real.log |t| ^ (-7 : ℝ) := by ring
    _ ≥ _ := ?_
  · apply ge_iff_le.mpr
    convert norm_sub_norm_le (a := ζ s') (b := ζ s' - ζ s) using 1
    · rw [(by simp : ζ s' - ζ s = -(ζ s - ζ s'))]; simp only [norm_neg]
    · simp
  · apply sub_le_sub
    · have := one_div_le ?_ (by positivity) |>.mp <| hC₁ ⟨σ'_gt, σ'_le⟩ t t_gt
      · convert this using 1
        rw [one_div, mul_inv_rev, mul_comm, mul_inv_rev, mul_comm _ C'⁻¹]
        simp only [one_div C', C₁]
        congr <;> (rw [← Real.rpow_neg (by linarith), neg_div]); rw [neg_neg]
      · apply norm_pos_iff.mpr <| riemannZeta_ne_zero_of_one_lt_re (by simp [σ'_gt])
    · rw [(by simp : ζ s - ζ s' = -(ζ s' - ζ s)), norm_neg]
      refine hC₂ σ σ' t t_gt ?_ σ'_le <| by rw [Set.mem_Ico] at hσ; exact hσ.2
      apply le_trans ?_ hσ.1
      rw [tsub_le_iff_right, ← add_sub_right_comm, le_sub_iff_add_le, add_le_add_iff_left]
      exact div_le_div₀ hA'.1.le (by simp [A]) (by positivity) <| ZetaInvBnd_aux logt_gt_one
  · apply sub_le_sub (by simp only [add_sub_cancel_left, σ']; exact_mod_cast le_rfl) ?_
    rw [mul_div_assoc, mul_assoc _ 2 _]
    apply mul_le_mul (by exact_mod_cast le_rfl) ?_ (by linarith [hσ.2]) (by positivity)
    suffices h : σ' + (1 - A / Real.log |t| ^ 9) ≤ (1 + A / Real.log |t| ^ 9) + σ by
      simp only [tsub_le_iff_right]
      convert! le_sub_right_of_add_le h using 1; ring_nf; norm_cast; simp
    exact add_le_add (by linarith) (by linarith [hσ.1])
  · simp_rw [tsub_le_iff_right, div_eq_mul_inv _ (Real.log |t| ^ (9 : ℝ))]
    rw [← Real.rpow_neg (by positivity), Real.mul_rpow (by positivity) (by positivity)]
    rw [← Real.rpow_mul (by positivity)]
    ring_nf
    conv => rhs; lhs; rw [mul_assoc, ← Real.rpow_add (by positivity)]
    rw [(by ring : C₂ * Real.log |t| ^ (2 : ℝ) * A * Real.log |t| ^ (-9 : ℝ) * 2 = C₂ * (Real.log |t| ^ (2 : ℝ) * Real.log |t| ^ (-9 : ℝ) ) * A * 2)]
    rw [← Real.rpow_add (by positivity)]; norm_num; group; exact le_rfl
  · apply div_le_iff₀ (by positivity) |>.mpr
    conv => rw [mul_assoc]; rhs; rhs; rw [mul_comm C, ← mul_assoc, ← Real.rpow_add (by positivity)]
    have := inv_inv C ▸ mul_inv_cancel₀ (a := C⁻¹) (by positivity) |>.symm.le
    simpa [C] using this

lemma ZetaLowerBnd :
    ∃ (A : ℝ) (_ : A ∈ Ioc 0 (1 / 2)) (c : ℝ) (_ : 0 < c),
    ∀ (σ : ℝ)
    (t : ℝ) (_ : 3 < |t|)
    (_ : σ ∈ Ico (1 - A / (Real.log |t|) ^ 9) 1),
    c / (Real.log |t|) ^ (7 : ℝ) ≤ ‖ζ (σ + t * I)‖ := by
  obtain ⟨C₁, C₁pos, hC₁⟩ := ZetaLowerBound3
  obtain ⟨A', hA', C₂, C₂pos, hC₂⟩ := Zeta_diff_Bnd

  let A := min A' ((C₁ / (4 * C₂)) ^ 4)
  have hA : A ∈ Ioc 0 (1 / 2) :=
    ⟨lt_min hA'.1 (by positivity), (min_le_left A' _).trans hA'.2⟩

  let C := C₁ * A ^ ((3:ℝ) /4) - 2 * C₂ * A
  have hc_pos : 0 < C := by
    have:= A.rpow_le_rpow hA.1.le (min_le_right _ _) (inv_pos.mpr four_pos).le
    erw [Real.pow_rpow_inv_natCast (div_pos C₁pos (mul_pos four_pos C₂pos)).le four_ne_zero,
      le_div_iff₀ (mul_pos four_pos C₂pos)] at this
    norm_num [mul_assoc, C, mul_left_comm, C₂pos, hA.1,
      (mul_le_mul_of_nonneg_right this (A.rpow_nonneg hA.1.le _)).trans_lt', ←A.rpow_add]

  refine ⟨A, hA, C, hc_pos, fun σ t L ⟨σ_low_bound, σ_le_one⟩=>?_⟩

  let σ' := 1 + A / Real.log |t| ^  (9 : ℝ)

  have triangular :  ‖ζ (σ + t * I)‖ ≥  ‖ζ (σ' + t * I)‖ -  ‖ζ (σ + t * I) - ζ (σ' + t * I)‖ := by
    apply sub_le_iff_le_add.mpr.comp (sub_sub_self @_ (@_ : ℂ)▸norm_sub_le _ _).trans
      (by rw [add_comm])

  have one_leLogT : 1 ≤ Real.log |t| := (logt_gt_one L.le).le
  have one_half_le_log_pow : 1 / 2 ≤ Real.log |t| ^ 9 :=
    one_half_lt_one.le.trans <| one_le_pow₀ one_leLogT

  have σ'_ge : 1 ≤ σ' := by
    simp_all only [gt_iff_lt, mem_Ioc, Real.log_abs, one_div, and_imp, tsub_le_iff_right,
      lt_inf_iff, div_pos_iff_of_pos_left, Nat.ofNat_pos, mul_pos_iff_of_pos_left, pow_pos,
      and_self, inf_le_iff, true_or, sub_pos, mem_Ico, and_true, ofReal_add, ofReal_one,
      ofReal_div, ge_iff_le, le_add_iff_nonneg_right, A, C, σ']
    apply div_nonneg
    · apply le_min
      · linarith
      · have : (C₁ / (4 * C₂)) ^ 4 = ((C₁ / (4 * C₂)) ^ 2) ^ 2 := by ring
        rw [this]
        apply sq_nonneg
    · positivity

  have right_sub :  -‖ζ (σ + t * I) -  ζ (σ' + t * I)‖ ≥ - C₂ * Real.log |t| ^ 2 * (σ' - σ) := by
    change - C₂ * Real.log |t| ^ 2 * (σ' - σ) ≤ -‖ζ (σ + t * I) -  ζ (σ' + t * I)‖
    have := hC₂ σ σ' t L ?_ ?_ ?_
    · convert! neg_le_neg this using 1
      · ring
      · congr! 1
        have : ζ (↑σ + ↑t * I) - ζ (↑σ' + ↑t * I) =
            - (ζ (↑σ' + ↑t * I) - ζ (↑σ + ↑t * I)) := by ring
        rw [this, norm_neg]
    · have : 1 - A' / Real.log |t| ≤ 1 - A / (Real.log |t|) ^ 9 := by
        gcongr
        · exact hA'.1.le
        · bound
        · bound
      linarith
    · have : σ' ≤ 1 + A := by
        simp_all only [gt_iff_lt, mem_Ioc, Real.log_abs, one_div, and_imp, tsub_le_iff_right,
          lt_inf_iff, div_pos_iff_of_pos_left, Nat.ofNat_pos, mul_pos_iff_of_pos_left, pow_pos,
          and_self, inf_le_iff, true_or, sub_pos, mem_Ico, and_true, ofReal_add, ofReal_one,
          ofReal_div, ge_iff_le, le_add_iff_nonneg_right, add_le_add_iff_left, le_inf_iff,
          σ', A, C]
        have : 1 ≤ Real.log t ^ (9 : ℕ) := by
          bound
        have : 1 ≤ Real.log t ^ (9 : ℝ) := by
          exact_mod_cast this
        refine ⟨?_, ?_⟩
        · rw [← min_div_div_right]
          · rw [min_le_iff]
            left
            bound
          · exact le_trans (zero_le_one) this
        · rw [← min_div_div_right]
          · rw [min_le_iff]
            right
            bound
          · exact le_trans (zero_le_one) this
      · bound [hA.2]
    · linarith

  have right' : -‖ζ (σ + t * I) -  ζ (σ' + t * I)‖   ≥ - C₂ * 2 * A / Real.log |t| ^ 7 := by
    have := (abs t).log_pos (by bound)
    refine right_sub.trans' ((div_le_iff₀ (pow_pos this 7)).2 @?_|>.trans
      (mul_le_mul_of_nonpos_left (sub_le_sub_left σ_low_bound (1+_) )
        (by ·linear_combination C₂*this*(.log |t|))))
    exact (mod_cast (by linear_combination (2 *_* A) *div_self ↑(pow_pos this 09).ne'))

  have left_sub : ‖ζ (σ' + t * I)‖ ≥ C₁ * (σ' - 1) ^ ((3:ℝ) /4) / Real.log |t| ^ 4 := by
    use (hC₁ ⟨lt_add_of_pos_right (1) (by bound[hA.1]),
      add_le_of_le_sub_left ((div_le_iff₀ (by bound)).2 (hA.2.trans (?_)))⟩ t L).trans' ?_
    · norm_num only [one_mul, Real.rpow_ofNat, one_half_le_log_pow]
    · simp_all only [gt_iff_lt, mem_Ioc, lt_inf_iff, div_pos_iff_of_pos_left, Nat.ofNat_pos,
        mul_pos_iff_of_pos_left, pow_pos, and_self, inf_le_iff, true_or, sub_pos, mem_Ico,
        ofReal_add, ofReal_one, ofReal_div, ge_iff_le, le_add_iff_nonneg_right, neg_mul,
        neg_le_neg_iff, add_sub_cancel_left, σ', A, C]
      gcongr
      have :  Real.log |t| ^ ((1 : ℝ) / 4) ≤ Real.log |t| ^ (4 : ℝ) :=
        Real.rpow_le_rpow_of_exponent_le one_leLogT (by norm_num)
      exact_mod_cast this

  have left' : ‖ζ (σ' + t * I)‖ ≥ C₁ * A ^ ((3:ℝ) /4) / Real.log |t| ^ 7 := by
    contrapose! hC₁
    use σ', ⟨lt_add_of_pos_right 1<|by bound[hA'.1],
      add_le_of_le_sub_left ((div_le_iff₀ (by bound)).2 (hA.2.trans ?_))⟩, t, L, hC₁.trans_le ?_
    · norm_num only [one_mul, Real.rpow_ofNat, one_half_le_log_pow]
    · norm_num only [σ', add_sub_cancel_left, A.div_rpow hA.1.le, mul_div, pow_pos, L.trans',
        ←Real.rpow_natCast, ←Real.rpow_mul, le_of_lt, Real.log_pos, refl, div_div, ←Real.rpow_sub]
      rw [Real.div_rpow hA.1.le, ← Real.rpow_mul (by linarith), ← mul_div_assoc, div_div, ← Real.rpow_add (by linarith)]
      · norm_num
      · apply Real.rpow_nonneg (by linarith)
  have ineq : ‖ζ (σ + t * I)‖ ≥ (C₁ * A ^ ((3:ℝ) /4) - C₂ * 2 * A) / Real.log |t| ^ 7 := by
    linear_combination left'+triangular+right'

  rw [mul_comm C₂] at ineq
  exact_mod_cast ineq

lemma ZetaZeroFree :
    ∃ (A : ℝ) (_ : A ∈ Ioc 0 (1 / 2)),
    ∀ (σ : ℝ)
    (t : ℝ) (_ : 3 < |t|)
    (_ : σ ∈ Ico (1 - A / (Real.log |t|) ^ 9) 1),
    ζ (σ + t * I) ≠ 0 := by
  obtain ⟨A, hA, c, hc, h_lower⟩ := ZetaLowerBnd

  refine ⟨A, hA, ?_⟩

  intro σ t ht hσ h_zero

  have := h_lower σ t ht hσ

  rw [h_zero, norm_zero] at this

  have pos_bound : 0 < c / (Real.log |t|) ^ (7 : ℝ) := by
    apply div_pos hc
    apply Real.rpow_pos_of_pos
    apply Real.log_pos
    linarith

  linarith

lemma LogDerivZetaBnd :
    ∃ (A : ℝ) (_ : A ∈ Ioc 0 (1 / 2)) (C : ℝ) (_ : 0 < C), ∀ (σ : ℝ) (t : ℝ) (_ : 3 < |t|)
    (_ : σ ∈ Ico (1 - A / Real.log |t| ^ 9) (1 + A / Real.log |t| ^ 9)), ‖ζ' (σ + t * I) / ζ (σ + t * I)‖ ≤
      C * Real.log |t| ^ 9 := by
  obtain ⟨A, hA, C, hC, h⟩ := ZetaInvBnd
  obtain ⟨A', hA', C', hC', h'⟩ := ZetaDerivUpperBnd
  use min A A', ⟨lt_min hA.1 hA'.1, min_le_of_right_le hA'.2⟩, C * C', mul_pos hC hC'
  intro σ t t_gt ⟨σ_ge, σ_lt⟩
  have logt_gt : (1 : ℝ) < Real.log |t| := logt_gt_one t_gt.le
  have σ_ge' : 1 - A / Real.log |t| ^ 9 ≤ σ := by
    apply le_trans (tsub_le_tsub_left ?_ 1) σ_ge
    apply div_le_div_of_nonneg_right (min_le_left A A')
    exact pow_nonneg (zero_le_one.trans logt_gt.le) _
  have σ_ge'' : 1 - A' / Real.log |t| ≤ σ := by
    apply le_trans (tsub_le_tsub_left ?_ 1) σ_ge
    apply div_le_div₀ hA'.1.le (min_le_right A A') (lt_trans (by norm_num) logt_gt) ?_
    exact le_self_pow₀ logt_gt.le (by norm_num)
  replace h := h σ t t_gt ⟨σ_ge', by calc
    σ < 1 + min A A' / Real.log |t| ^ 9 := σ_lt
    _ ≤ 1 + A / Real.log |t| ^ 9 := by gcongr; simp⟩
  replace h' := h' σ t t_gt ⟨σ_ge'', by
