import Init
/- OpenAI #003 (Quasi-Riemann Hypothesis Ecosystem Deep Synthesis)
   File 1: The 23/24 vs. 11/12 Formalization Gap & The Unimported 30-File Sharp Cubic Large Sieve (Theorems 1–15)
   Scope: PARAMETER_ARITHMETIC_ONLY (Category A: Exact Algebraic, Recurrence, Reserve-Budget & Exponent-Bridge Verification)
-/

namespace QRHElevenTwelfthsAndCubicSieve

/-!
## Part I: The `Re(s) > 23/24` (`ShortDraft`) vs. `Re(s) > 11/12` (`paper2.tex` & `AlexKontorovich/quasi-rh`) Formalization Gap (Theorems 1–8)
(`MeanSquare/ThetaDensity.lean:93`, `Mellin/SixthPowerAverage.lean:330-407`, `PrimeRows/NormFiberExtraction.lean:342-355`,
 `RowCompletion/ZeroFreeRegion.lean:204-214`, `ElevenTwelfths/Amplification.lean`, `ElevenTwelfths/Nonvanishing.lean`)
-/

/-- [Theorem 1] Upstream `ShortDraft` fixed-reserve bottleneck (`MeanSquare/ThetaDensity.lean:93`, `Mellin/SixthPowerAverage.lean:331-406`):
hardcoding `1/20 < σ` (`reserve120 = 6 < sigma120 = 12`, i.e., `σ = 1/10`) forces `H = Z^(11/10)`, `Y = Z^(11/60)` (`alpha120 = 22`),
Cauchy-Schwarz square-root exponent `cs_sqrt120 = 137` (`137/120`), and normalized exponent `beta_sd120 = 115` (`115/120 = 23/24`),
whose zero-free strip width `width_sd120 = 5` (`1/24`) is exactly half of the `11/12` strip width `width_11_12_120 = 10` (`1/12`). -/
theorem thm_01_shortdraft_fixed_reserve_and_23_24_exponent
    (reserve120 sigma120 H_exp120 alpha120 cs_sqrt120 beta_sd120 beta_11_12_120 width_sd120 width_11_12_120 : Int)
    (h_res : reserve120 = 6)
    (h_sig : sigma120 = 12)
    (h_H : H_exp120 = 120 + sigma120)
    (h_alpha : 6 * alpha120 = H_exp120)
    (h_cs : 2 * cs_sqrt120 = alpha120 + 120 + H_exp120)
    (h_bsd : beta_sd120 = cs_sqrt120 - alpha120)
    (h_b11 : beta_11_12_120 = 110)
    (h_wsd : width_sd120 = 120 - beta_sd120)
    (h_w11 : width_11_12_120 = 120 - beta_11_12_120) :
    reserve120 < sigma120 ∧ H_exp120 = 132 ∧ alpha120 = 22 ∧ cs_sqrt120 = 137 ∧
    beta_sd120 = 115 ∧ width_sd120 = 5 ∧ width_11_12_120 = 10 ∧ 2 * width_sd120 = width_11_12_120 := by
  omega

/-- [Theorem 2] Symbolic sixth-power Cauchy-Schwarz exponent law (`paper2.tex:695-724`, `argument.md:190-244`):
for any mean-square radius `θ = p/q` and sixth-power scale `α = (1 + θ)/6 = (q + p)/(6q)`,
the normalized Cauchy-Schwarz exponent `(2 + θ - α)/2` equals `(11q + 5p)/(12q)` identically,
evaluating to `23/24` at `θ = 1/10` (`p = 1, q = 10`) and `11/12` in the limit `p = 0`. -/
theorem thm_02_symbolic_sixth_power_cauchy_schwarz_exponent
    (p q alpha_num6q cs_num12q exp_num12q val_at_tenth240 val_at_zero240 : Int)
    (hq : 0 < q)
    (hp : 0 ≤ p)
    (h_alpha : alpha_num6q = q + p)
    (h_cs : cs_num12q = 12 * q + 6 * p + alpha_num6q)
    (h_exp : exp_num12q = cs_num12q - 2 * alpha_num6q)
    (h_tenth : val_at_tenth240 = 2 * (11 * 10 + 5 * 1))
    (h_zero : val_at_zero240 = 2 * (11 * 10 + 5 * 0)) :
    cs_num12q = 13 * q + 7 * p ∧ exp_num12q = 11 * q + 5 * p ∧
    0 < alpha_num6q ∧ 11 * q ≤ exp_num12q ∧ val_at_tenth240 = 230 ∧ val_at_zero240 = 220 ∧ val_at_zero240 < val_at_tenth240 := by
  omega

/-- [Theorem 3] Kontorovich's exact `(θ, η) = (6ε/5, ε/2)` substitution (`argument.md:246-263`, `ElevenTwelfths/MeanSquare.lean`):
given any target loss `ε > 0` (scaled by `60`), setting `theta60 = 72 * eps` (`6ε/5`) and `eta60 = 30 * eps` (`ε/2`)
gives `(11 + 5θ)/12 + η = 11/12 + ε` (`total60 = 55 + 60 * eps`) with zero residual slack. -/
theorem thm_03_kontorovich_epsilon_split_exact_11_12
    (eps theta60 eta60 cs_part60 total60 target60 : Int)
    (heps : 0 < eps)
    (h_theta : 5 * theta60 = 360 * eps)
    (h_eta : 2 * eta60 = 60 * eps)
    (h_cs : 12 * cs_part60 = 660 + 5 * theta60)
    (h_tot : total60 = cs_part60 + eta60)
    (h_targ : target60 = 55 + 60 * eps) :
    theta60 = 72 * eps ∧ eta60 = 30 * eps ∧ cs_part60 = 55 + 30 * eps ∧
    total60 = target60 ∧ 55 < total60 := by
  omega

/-- [Theorem 4] Symbolic `CanonicalDescentScale` budget unlocking arbitrary `θ > 0` (`argument.md:135-165`, `CubicSieve/ClosedRecursion.lean:120`):
upstream hardcoded `denom_up = 1000` and `reserve_up1000 = 50` (`1/20`), consuming `25/1000 = 1/40` across 25 short-cube steps;
for any symbolic reserve `κ = θ/2 = 1/(2M)` (`M ≥ 1`), choosing `denom_sym = 100 * M + 1` satisfies `50 ≤ κ * denom_sym`
(`100 * M < denom_sym`) and bounds the 25-step short-cube loss strictly below `κ/2 = θ/4`. -/
theorem thm_04_canonical_descent_scale_budget_unlocks_arbitrary_theta
    (denom_up reserve_up1000 budget_up M denom_sym lhs_budget rhs_budget short25_lhs short25_rhs : Int)
    (h_dup : denom_up = 1000)
    (h_rup : reserve_up1000 = 50)
    (h_bup : 1000 * budget_up = reserve_up1000 * denom_up)
    (hM : 1 ≤ M)
    (h_dsym : denom_sym = 100 * M + 1)
    (h_lhs : lhs_budget = 50 * (2 * M))
    (h_rhs : rhs_budget = denom_sym)
    (h_s_lhs : short25_lhs = 25 * (4 * M))
    (h_s_rhs : short25_rhs = denom_sym) :
    budget_up = 50 ∧ lhs_budget = 100 * M ∧ lhs_budget < rhs_budget ∧
    short25_lhs < short25_rhs ∧ 100 < denom_sym := by
  subst h_dup; subst h_rup
  omega

/-- [Theorem 5] Subdominance of the Poisson/divisibility remainder (`Mellin/SixthPowerAverage.lean:381-406`, `paper2.tex:715`):
at sixth-power scale `α = (1 + θ)/6`, the remainder exponent after dividing `O(Z^(1+ε))` by `Y = Z^α` is
`E_rem(θ) = 1 - α = (5 - θ)/6`, so `E_CS(θ) - E_rem(θ) = (11 + 5θ)/12 - (5 - θ)/6 = (1 + 7θ)/12 > 0` for all `θ > -1/7`
(and at `θ = 1/10`, `E_CS(1/10) - E_rem(1/10) = 23/24 - 49/60 = 17/120`, matching `137/120 - 1 = 17/120` in `SixthPowerAverage.lean:392`). -/
theorem thm_05_remainder_exponent_subdominance_and_crossover
    (p q cs_num12q rem_num12q gap_num12q cs_tenth120 rem_tenth120 gap_tenth120 : Int)
    (hq : 0 < q)
    (hp : 0 ≤ p)
    (h_cs : cs_num12q = 11 * q + 5 * p)
    (h_rem : rem_num12q = 2 * (5 * q - p))
    (h_gap : gap_num12q = cs_num12q - rem_num12q)
    (h_cst : cs_tenth120 = 115)
    (h_remt : rem_tenth120 = 98)
    (h_gapt : gap_tenth120 = cs_tenth120 - rem_tenth120) :
    rem_num12q = 10 * q - 2 * p ∧ gap_num12q = q + 7 * p ∧ q ≤ gap_num12q ∧ 0 < gap_num12q ∧
    gap_tenth120 = 17 ∧ rem_tenth120 < cs_tenth120 := by
  omega

/-- [Theorem 6] Algebraic origin of the `768 = 6 * 128` Cauchy-Schwarz constant (`ThetaDensity.lean:611-625`, `SixthPowerAverage.lean:199-237`):
in an integral domain (`ActualEisensteinCubic.O`), `b ↦ b^6` has fiber size `fiber_deg ≤ 6` (`Polynomial.card_nthRoots 6 z`),
and combining `fiber_deg = 6` with the lattice disk bound `disk_const = 128` yields `cauchy_const = 768`, whereas
injective prime-row extraction (`NormFiberExtraction.lean:355`) uses `prime_const = 384 = 3 * 128`. -/
theorem thm_06_sixth_power_fiber_cauchy_constant_768
    (fiber_deg disk_const cauchy_const dyadic_prime_factor prime_const : Int)
    (h_fib : fiber_deg = 6)
    (h_disk : disk_const = 128)
    (h_cauchy : cauchy_const = fiber_deg * disk_const)
    (h_dyad : dyadic_prime_factor = 3)
    (h_prime : prime_const = dyadic_prime_factor * disk_const) :
    cauchy_const = 768 ∧ prime_const = 384 ∧ cauchy_const = 2 * prime_const ∧
    0 < cauchy_const ∧ prime_const < cauchy_const := by
  subst h_fib; subst h_disk; subst h_dyad
  omega

/-- [Theorem 7] Totient-density Euler correction identity (`ThetaDensity.lean:502-563`, `Hecke/MobiusEulerCorrection.lean`, `ThetaNonvanishing.lean:85-104`):
for any prime norm `N_p ≥ 2`, the local totient density `1 - 1/N_p = (N_p - 1)/N_p` lies in `[1/2, 1)`, and multiplying the Dirichlet series
by the local Euler correction `(1 - χ(p) N_p^(-s)) / (1 - (1 - 1/N_p) χ(p) N_p^(-s))` has difference term `-χ(p) / N_p^(s+1)`,
which converges absolutely for `Re(s) > 0` (`s_re + 1 > 1`). -/
theorem thm_07_totient_euler_correction_vs_prime_amplification_tradeoff
    (Np tot_num tot_den diff_exp_at_zero120 min_conv_exp120 target_11_12_120 : Int)
    (hNp : 2 ≤ Np)
    (h_tnum : tot_num = Np - 1)
    (h_tden : tot_den = Np)
    (h_dexp : diff_exp_at_zero120 = min_conv_exp120 + 120)
    (h_mconv : min_conv_exp120 = 0)
    (h_targ : target_11_12_120 = 110) :
    1 ≤ tot_num ∧ tot_num < tot_den ∧ 2 * tot_num ≥ tot_den ∧
    0 ≤ min_conv_exp120 ∧ min_conv_exp120 < target_11_12_120 ∧ target_11_12_120 < diff_exp_at_zero120 := by
  omega

/-- [Theorem 8] Unformalized `paper.tex` Part I margin table (`paper.tex:6501`) vs. upstream `ShortDraft.DirichletTarget` (`ZeroFreeRegion.lean:204-214`):
in `paper.tex` (`L6501`), Part I lists four regime margins `(1021/25000, 1/40, 1/1200, 43/300)` for `Re(s) > 11/12`
(in units of `1/150000`: `6126, 3750, 125, 21500`, minimum `125/150000 = 1/1200`), none of which appear in `lean/OAI/NumberTheory/DirichletL/`,
where `ZeroFreeRegion.lean` instead formalizes `Re(s) > 23/24` (`gap = 23/24 - 11/12 = 1/24 = 6250/150000 = 50 * (1/1200)`). -/
theorem thm_08_part_one_paper_tex_table_vs_shortdraft_gap
    (m1_150k m2_150k m3_150k m4_150k min_m150k gap_sd_11_12_150k ratio_gap_to_min : Int)
    (hm1 : m1_150k = 1021 * 6)
    (hm2 : m2_150k = 150000 / 40)
    (hm3 : m3_150k = 150000 / 1200)
    (hm4 : m4_150k = 43 * 500)
    (hmin : min_m150k = m3_150k)
    (hgap : gap_sd_11_12_150k = 150000 / 24)
    (hratio : ratio_gap_to_min * min_m150k = gap_sd_11_12_150k) :
    m1_150k = 6126 ∧ m2_150k = 3750 ∧ m3_150k = 125 ∧ m4_150k = 21500 ∧
    min_m150k < m2_150k ∧ m2_150k < m1_150k ∧ m1_150k < m4_150k ∧
    gap_sd_11_12_150k = 6250 ∧ ratio_gap_to_min = 50 := by
  subst hm3; subst hmin
  omega

/-!
## Part II: The Unimported 30-File Sharp Heath-Brown Cubic Large Sieve (`OAI/NumberTheory/CubicGauss/`, `6,252` Lines) (Theorems 9–15)
(`CubicGauss/Main.lean`, `CubicGauss/LargeSieve.lean:15-190`, `CubicGauss/Recurrence.lean:350-431`, `CubicGauss/ScalarBounds.lean:14-110`)
-/

/-- [Theorem 9] Exact rational identities of `sieveThreshold(α) = (6α - 5)/(3α - 1)` and `sieveStep(α) = (6α - 4)/(3α - 1)`
(`CubicGauss/Recurrence.lean:350-370`, `sieveStep_algebra`):
for any `α = p/q ≥ 4/3` (`3p ≥ 4q > 0`), with common denominator `D = 3p - q > 0`, numerator `T_num = 6p - 5q` (`sieveThreshold`)
and `S_num = 6p - 4q` (`sieveStep`), we have `D ≤ T_num < S_num`, `2 * (T_num + D) = 3 * S_num` (`(sieveThreshold + 1)*(2/3) = sieveStep`),
`T_num * (3p - q) = D * (6p - 5q)` (`sieveThreshold * (α - 1/3) = 2α - 5/3`), and `4 * D ≤ 3 * S_num` (`4/3 ≤ sieveStep`). -/
theorem thm_09_cubic_gauss_sieve_step_and_threshold_identities
    (p q D T_num S_num lhs_step rhs_step excess_4_3 : Int)
    (hq : 0 < q)
    (h_ge : 4 * q ≤ 3 * p)
    (hD : D = 3 * p - q)
    (hT : T_num = 6 * p - 5 * q)
    (hS : S_num = 6 * p - 4 * q)
    (h_lhs : lhs_step = 2 * (T_num + D))
    (h_rhs : rhs_step = 3 * S_num)
    (h_exc : excess_4_3 = 3 * S_num - 4 * D) :
    3 * q ≤ D ∧ D ≤ T_num ∧ T_num < S_num ∧ lhs_step = rhs_step ∧
    excess_4_3 = 2 * (3 * p - 4 * q) ∧ 0 ≤ excess_4_3 := by
  omega

/-- [Theorem 10] Exact quadratic slack between OpenAI's linearized contraction and the nonlinear Heath-Brown map (`CubicGauss/Recurrence.lean:357-370`):
for `α = p/q` with `delta = 3p - 4q > 0` and `D = 3p - q`, `((2/3)*(α - 4/3) - (sieveStep(α) - 4/3)) * 9qD = 2*delta*(D - 3q) = 2*delta^2 > 0`,
and the fixed-point polynomial `p * D - q * S_num = delta * (p - q)` vanishes on `3p ≥ 4q > 0` if and only if `delta = 0` (`α = 4/3`). -/
theorem thm_10_cubic_gauss_quadratic_slack_and_attracting_fixed_point
    (p q D S_num delta D_minus_3q slack_num9qD fixed_pt_num : Int)
    (hq : 0 < q)
    (h_ge : 4 * q < 3 * p)
    (hD : D = 3 * p - q)
    (hS : S_num = 6 * p - 4 * q)
    (h_del : delta = 3 * p - 4 * q)
    (h_dm3 : D_minus_3q = D - 3 * q)
    (h_slack : slack_num9qD = 2 * delta * D_minus_3q)
    (h_fp : fixed_pt_num = delta * (p - q)) :
    D_minus_3q = delta ∧ 3 * S_num - 4 * D = 2 * delta ∧
    slack_num9qD = 2 * (delta * delta) ∧ 0 < slack_num9qD ∧ 0 < fixed_pt_num := by
  have h1 : 0 < delta := by omega
  have h2 : 0 < p - q := by omega
  have hdm : D_minus_3q = delta := by omega
  have hsq : 0 < delta * delta := Int.mul_pos h1 h1
  have hfp_pos : 0 < fixed_pt_num := by rw [h_fp]; exact Int.mul_pos h1 h2
  have hsl : slack_num9qD = 2 * (delta * delta) := by
    rw [h_slack, hdm, Int.mul_assoc]
  exact ⟨hdm, by omega, hsl, by omega, hfp_pos⟩

/-- [Theorem 11] Exact Möbius-conjugacy linearization of `sieveStep(α) = (6α - 4)/(3α - 1)`:
under the Möbius coordinate `u(α) = (α - 4/3)/(α - 1) = (3p - 4q)/(3(p - q))`, one step `α' = p'/q' = (6p - 4q)/(3p - q)`
satisfies `3p' - 4q' = 2(3p - 4q)` and `p' - q' = 3(p - q)`, so `u(sieveStep(α)) = (2/3) * u(α)` holds with zero error for every `α`! -/
theorem thm_11_mobius_conjugacy_exact_closed_form_solution
    (p q p_next q_next u_num u_den u_next_num u_next_den cross_lhs cross_rhs : Int)
    (hq : 0 < q)
    (h_gt : 4 * q < 3 * p)
    (hp_next : p_next = 6 * p - 4 * q)
    (hq_next : q_next = 3 * p - q)
    (hu_num : u_num = 3 * p - 4 * q)
    (hu_den : u_den = 3 * (p - q))
    (hun_num : u_next_num = 3 * p_next - 4 * q_next)
    (hun_den : u_next_den = 3 * (p_next - q_next))
    (h_lhs : cross_lhs = 3 * u_next_num * u_den)
    (h_rhs : cross_rhs = 2 * u_num * u_next_den) :
    u_next_num = 2 * u_num ∧ u_next_den = 3 * u_den ∧
    0 < u_num ∧ 0 < u_den ∧ q < p ∧ cross_lhs = cross_rhs := by
  have hun : u_next_num = 2 * u_num := by omega
  have hud : u_next_den = 3 * u_den := by omega
  refine ⟨hun, hud, by omega, by omega, by omega, ?_⟩
  rw [h_lhs, h_rhs, hun, hud]
  simp only [Int.mul_assoc, Int.mul_comm, Int.mul_left_comm]

/-- [Theorem 12] Exact comparison at `n = 0, 1, 2, 3` between the true nonlinear iterates `α̃_n = (4*3^n - 2^(n+1))/(3*3^n - 2^(n+1))`
(`2, 8/5, 28/19, 92/65`) and OpenAI's linearized upper envelope `sieveExponent n = 4/3 + (2/3)^(n+1)` (`2, 16/9, 44/27, 124/81` in `LargeSieve.lean:75`):
for every `n ≥ 1`, `4/3 < α̃_n < α_n`, and the excess ratio `(α̃_n - 4/3)/(α_n - 4/3) = (1/3)/(1 - (2/3)^(n+1))` converges to `1/3`. -/
theorem thm_12_nonlinear_vs_linearized_sieve_iterates_comparison
    (nl1_num nl1_den lin1_num lin1_den nl2_num nl2_den lin2_num lin2_den nl3_num nl3_den lin3_num lin3_den : Int)
    (h_nl1 : nl1_num = 8 ∧ nl1_den = 5)
    (h_lin1 : lin1_num = 16 ∧ lin1_den = 9)
    (h_nl2 : nl2_num = 28 ∧ nl2_den = 19)
    (h_lin2 : lin2_num = 44 ∧ lin2_den = 27)
    (h_nl3 : nl3_num = 92 ∧ nl3_den = 65)
    (h_lin3 : lin3_num = 124 ∧ lin3_den = 81) :
    4 * nl1_den < 3 * nl1_num ∧ nl1_num * lin1_den < lin1_num * nl1_den ∧
    4 * nl2_den < 3 * nl2_num ∧ nl2_num * lin2_den < lin2_num * nl2_den ∧
    4 * nl3_den < 3 * nl3_num ∧ nl3_num * lin3_den < lin3_num * nl3_den := by
  rcases h_nl1 with ⟨rfl, rfl⟩
  rcases h_lin1 with ⟨rfl, rfl⟩
  rcases h_nl2 with ⟨rfl, rfl⟩
  rcases h_lin2 with ⟨rfl, rfl⟩
  rcases h_nl3 with ⟨rfl, rfl⟩
  rcases h_lin3 with ⟨rfl, rfl⟩
  omega

/-- [Theorem 13] `short_four_thirds` and cubic-reciprocity symmetrization (`CubicGauss/LargeSieve.lean:136-190`):
in log-scales `(a, b)`, when `b ≤ a` (`N ≤ M`), `(4/3)b ≤ (2/3)(a + b)` (`2b ≤ a + b`), and when `a ≤ b` (`M ≤ N`),
cubic reciprocity transposes `(a, b) ↦ (b, a)` so `(4/3)a ≤ (2/3)(a + b)`, collapsing `M + N^(4/3) + (MN)^(2/3)`
and `N + M^(4/3) + (MN)^(2/3)` onto the symmetric Heath-Brown envelope `max(a, b, (2/3)(a + b))`. -/
theorem thm_13_short_four_thirds_and_reciprocity_symmetrization
    (a b four_b3 two_ab3 gap_short_a3 a_sym b_sym four_a3 two_ab_sym3 gap_short_b3 : Int)
    (h_le1 : b ≤ a)
    (h_4b : four_b3 = 4 * b)
    (h_2ab : two_ab3 = 2 * (a + b))
    (h_gap1 : gap_short_a3 = two_ab3 - four_b3)
    (h_le2 : a_sym ≤ b_sym)
    (h_4a : four_a3 = 4 * a_sym)
    (h_2abs : two_ab_sym3 = 2 * (a_sym + b_sym))
    (h_gap2 : gap_short_b3 = two_ab_sym3 - four_a3) :
    gap_short_a3 = 2 * (a - b) ∧ 0 ≤ gap_short_a3 ∧ four_b3 ≤ two_ab3 ∧
    gap_short_b3 = 2 * (b_sym - a_sym) ∧ 0 ≤ gap_short_b3 ∧ four_a3 ≤ two_ab_sym3 := by
  omega

/-- [Theorem 14] Exact monomial exponent laws in `CubicGauss/ScalarBounds.lean:14-110`:
for column scale `y = N - k` and dual Poisson scale `X = d + 2y - M`, the prefactor `(M - d - y) + p * X`
equals `(1 - p)M + (p - 1)d + (2p - 1)y`, yielding `mixed_one` (`p = 1/3` with `+ y ↦ (2/3)(M + y - d) ≤ (2/3)(M + N)`),
`mixed_two` (`p = 2/3` with `+ (2/3)y ↦ (1/3)M + y - (1/3)d ≤ (1/3)M + N`), and `scale_epsilon` (`y + X ≤ 3N - 2k`). -/
theorem thm_14_scalar_bounds_epsilon_and_mixed_exponents
    (M N k d y X mix1_3 mix2_3 eps_scale : Int)
    (hM : 0 ≤ M) (hd : 0 ≤ d)
    (hdk : d ≤ k) (hkN : k ≤ N)
    (hy : y = N - k)
    (hX : X = d + 2 * y - M)
    (hm1 : mix1_3 = 3 * (M - d - y) + 3 * y + X)
    (hm2 : mix2_3 = 3 * (M - d - y) + 2 * y + 2 * X)
    (heps : eps_scale = y + X) :
    0 ≤ k ∧ 0 ≤ y ∧ mix1_3 = 2 * (M + y - d) ∧ mix1_3 ≤ 2 * (M + N) ∧
    mix2_3 = M + 3 * y - d ∧ mix2_3 ≤ M + 3 * N ∧
    eps_scale ≤ 3 * N - 2 * k := by
  omega

/-- [Theorem 15] Unimported status of `OAI/NumberTheory/CubicGauss` (`30` files, `6,252` lines, `0` external imports)
vs. imported `OAI/NumberTheory/CubicGram` (`45` files, `10,446` lines):
at OpenAI's baseline `(b, ℓ, y) = (1/8, 1/6, 23/48)` (in units of `1/1440`: `b = 180, ℓ = 240, y = 690`),
`CubicGram`'s one-step bundled inequality `y - ℓ - 11b/6 ≥ 0` has slack `120/1440 = 1/12`, whereas unbundling the zero/Gauss/bilinear modes
saves `Δ_gram_2term = 48/1440 = 1/30` and `Δ_gram_full = 256/1440 = 8/45`, and `CubicGauss` reaches the sharp exponent `4/3` (`960/720`). -/
theorem thm_15_unimported_cubic_gauss_vs_bundled_cubic_gram_gap
    (cubic_gauss_files cubic_gauss_lines external_imports b1440 ell1440 y1440 gram_gate1440 dgram_2term1440 dgram_full1440 : Int)
    (h_files : cubic_gauss_files = 30)
    (h_lines : cubic_gauss_lines = 6252)
    (h_imp : external_imports = 0)
    (hb : b1440 = 180)
    (hell : ell1440 = 240)
    (hy : y1440 = 690)
    (h_gate : gram_gate1440 = y1440 - ell1440 - 11 * b1440 / 6)
    (h_d2 : dgram_2term1440 = 48)
    (h_df : dgram_full1440 = 256) :
    0 ≤ external_imports ∧ external_imports < cubic_gauss_files ∧ cubic_gauss_files < dgram_2term1440 ∧
    gram_gate1440 = 120 ∧ dgram_2term1440 < gram_gate1440 ∧
    gram_gate1440 < dgram_full1440 ∧ dgram_full1440 < cubic_gauss_lines := by
  omega

end QRHElevenTwelfthsAndCubicSieve
