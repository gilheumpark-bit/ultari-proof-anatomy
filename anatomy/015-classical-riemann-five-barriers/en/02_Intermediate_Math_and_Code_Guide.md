# [Case 015 / Tier 2 Intermediate Math & Code Guide] Algebraic-Variational Derivations and Lean 4 Architecture of the Five Classical Barriers

> **Target Audience**: Graduate students and researchers in analytic number theory, harmonic analysis, and interactive theorem proving
> **Parent Index**: [Main English README (`README.md`)](../README.md) | [Executive Summary (`en/01_`)](01_Executive_Summary_and_General_Guide.md) | [Expert Forensic Report (`en/03_`)](03_Expert_Forensic_and_Mathematical_Physics_Report.md) | [Verification Spec (`en/04_`)](04_Automated_Verification_and_Parser_Spec.md)

## 1. Formalization Discipline: Zero Hardcoded Exponents and `188 / 188` Mutation Hygiene

Formalizing classical analytic number theory bounds is prone to subtle circularity: encoding final literature fractions (`1/100`, `12/5`, `30/13`, `4/7`, `3/16`, `7/64`) as constants or smuggling stationary-point / Cauchy-Schwarz equations as theorem hypotheses. Across all `6` Lean 4 modules (`75` theorems over `ℝ`), `Case 015` enforces three strict invariants:

1. **First-Principles Equilibrium Derivations**: Every exponent is derived from its underlying pole-zero inequality, Class I/II reflection crossover, Perron contour truncation, `HasDerivAt` integration-by-parts identity, or Weil-sum moment balance.
2. **Kernel-Proved Inequalities**: AM-GM stationarity (`u* = √(c_0 c_1)`), Cauchy-Schwarz discriminants (`1 <= 4 I_{AA} J_{BB}`), hyperbolic bounds (`coth ω > 1`), and the `oai_ref/Endpoint.lean` SOS vertex (`δ = 79/204`) are proved inside the Lean kernel rather than assumed as hypotheses.
3. **Exhaustive `: True` Mutation Rejection**: Every propositional hypothesis binder (`188` binders total) is mutated to `: True` by `tools/verify_all.py`, achieving a `188 / 188` (`100%`) compile-rejection rate.

---

## 2. Paper 1 (Theorems 1-15): Zero-Free Slack Recovery vs. the Fejer-Riesz Barrier

### 2.1 Pole-Zero SOS Identity and the Four-Tier `(3, 4, 1)` Cascade
Applying a nonnegative cosine polynomial $P(\theta) = c_0 + \sum_{k=1}^N c_k \cos(k\theta) \ge 0$ to the Hadamard partial-fraction expansion of $-\operatorname{Re}(\zeta'/\zeta)$ requires $c_k \ge 0$ ($k \ge 1$) so that nontrivial zero contributions $-\operatorname{Re}(1/(s-\rho)) < 0$ can be dropped without reversing sign.
Setting $\sigma = 1 + s_1 / M(|t|)$, $1 - \beta = \delta / M(|t|)$, and $u = c_0 + A W s_1$ ($W = \sum_{k=1}^N c_k$), [`thm_02_pole_zero_sos_decomposition`](../proofs/classical_dlvp_korobov_and_zero_free.lean#L40) proves
$$u \cdot A W \delta(s_1) = u\left(\sqrt{c_1} - \sqrt{c_0}\right)^2 - \left(u - \sqrt{c_0 c_1}\right)^2.$$
Evaluating $(c_0, c_1, c_2) = (3, 4, 1)$ across four step choices yields [`thm_04_three_four_one_four_tier_slack_cascade`](../proofs/classical_dlvp_korobov_and_zero_free.lean#L78):

- **Tier 1 (`oai_ref/NonquadraticZeroFree.lean`)**: `K c < 1/32` with `9A` splitting gives `A c < 1/288 ≈ 0.003472`.
- **Tier 2 (Textbook `s_1 = 4δ`)**: `1/100 = 0.010000`.
- **Tier 3 (Optimal integer multiple `s_1 ∈ {6δ, 7δ}`)**: `1/70 ≈ 0.014286` (`+42.86%`, governed by the Pell convergent `97^2 - 3 * 56^2 = 1`).
- **Tier 4 (Exact AM-GM optimum `u* = 2√3`)**: `(7 - 4√3)/5 ≈ 0.014359` (`+43.59%`).

Replacing `(3, 4, 1)` with the `c_1 / c_2 = 3` integer square $17 + 24\cos\theta + 8\cos 2\theta = (4\cos\theta + 3)^2 \ge 0$ yields `(41 - 4√102)/32 ≈ 0.018812` (`+88.12%` over `1/100`, reaching `99.96%` of the irreducible quintic $r^5 + 4r^4 - 12r^3 - 40r^2 + 64r - 64 = 0$ global degree-2 maximum `0.018819`) in [`thm_08_seventeen_twentyfour_eight_exact_constant_and_gain`](../proofs/classical_dlvp_korobov_and_zero_free.lean#L132) and [`thm_10_degree2_global_ceiling_and_9996_tightness`](../proofs/classical_dlvp_korobov_and_zero_free.lean#L171).

### 2.2 Separating `W`, `W_abs`, and the Degree-3 Counterexample to `W_+`
To prove an unconditional ceiling at arbitrary degree $N$, [`thm_12_general_cosine_pi_weight_lower_bound`](../proofs/classical_dlvp_korobov_and_zero_free.lean#L329) distinguishes three weight conventions:

1. **Hadamard zero-dropping cone (`c_k >= 0`)**: $W = \sum_{k=1}^N c_k$ satisfies $W \ge 2 c_1 - c_0$ from evaluation at $\theta = \pi$.
2. **Two-sided Weyl bound (`c_k ∈ ℝ` arbitrary sign)**: Under $|-\operatorname{Re}(\zeta'/\zeta(\sigma + i k t))| \le A M$, the denominator is $W_{\mathrm{abs}} = \sum_{k=1}^N |c_k|$, which satisfies $W_{\mathrm{abs}} \ge 2 c_1 - c_0$ unconditionally and reduces to $W$ when $c_k \ge 0$.
3. **Refutation of `W_+ = ∑ max(c_k, 0)` on sign-changing Fejer polynomials**: The explicit degree-3 Fejer square (`signChangeWitnessC`)
   $$\left|1 + \frac{3}{2}e^{i\theta} + \frac{3}{4}e^{2i\theta} - \frac{1}{2}e^{3i\theta}\right|^2 = \frac{65}{16} + \frac{9}{2}\cos\theta + 0\cos 2\theta - \cos 3\theta \ge 0$$
   is strictly nonnegative for all $\theta \in \mathbb{R}$, yet $W_+ = \frac{9}{2} = \frac{72}{16} < \frac{79}{16} = 2 c_1 - c_0$, whereas $W_{\mathrm{abs}} = \frac{11}{2} = \frac{88}{16} \ge \frac{79}{16}$.

Combining $W_{\mathrm{abs}} \ge 2 c_1 - c_0$ with the Fejer-Riesz autocorrelation identity $2 c_0 - c_1 = a_0^2 + a_N^2 + \sum (a_{j+1} - a_j)^2 > 0$ ([`thm_11_fejer_riesz_autocorrelation_strict_two_c0_barrier`](../proofs/classical_dlvp_korobov_and_zero_free.lean#L285)) locks $(\sqrt{c_1} - \sqrt{c_0})^2 / W_{\mathrm{abs}} < (3 - 2\sqrt{2})/3 \approx 0.057191$ ([`thm_13_fejer_riesz_universal_constant_ceilings`](../proofs/classical_dlvp_korobov_and_zero_free.lean#L378)) and forces $1 - \beta \to 0$ as $M(|t|) \to \infty$ ([`thm_15_asymptotic_sigma_eq_one_minus_o1_barrier_no_go`](../proofs/classical_dlvp_korobov_and_zero_free.lean#L461)).

---

## 3. Paper 2 (Theorems 16-35): Zero-Density Inflection Shift (`3/4 -> 7/10`) & `QRH` Gram Bridges

- **Ingham-Huxley Minimax**: Ingham's 3-term balance $A_{\mathrm{Ing}}(\sigma) = \frac{3}{2-\sigma}$ ([`thm_16_ingham_three_term_zero_detection_balance`](../proofs/classical_ingham_huxley_zero_density.lean#L29)) intersects Huxley's reflection curve $A_{\mathrm{Hux}}(\sigma) = \frac{3}{3\sigma-1}$ ([`thm_20_huxley_k2_k3_amplification_and_cutoff_compatibility`](../proofs/classical_ingham_huxley_zero_density.lean#L178)) at $\sigma^* = \frac{3}{4}$ with peak $\frac{12}{5} = 2.4$ in [`thm_21_ingham_huxley_minimax_three_quarters_inflection`](../proofs/classical_ingham_huxley_zero_density.lean#L214).
- **Guth-Maynard Envelope**: Solving the $k = 2 \to 3$ determinantal energy crossover gives $A_{\mathrm{GM}}(\sigma) = \frac{15}{5\sigma+3}$, whose middle-term positivity is certified unconditionally by the SOS numerator $250(\sigma - 3/4)^2 + 3/8 > 0$ ([`thm_26_guth_maynard_k2_k3_amplification_and_sos_middle_margin`](../proofs/classical_guth_maynard_and_qrh_gram.lean#L23)), shifting the minimax peak to $(\sigma^*_{\mathrm{GM}}, A) = (7/10, 30/13)$ ([`thm_28_guth_maynard_ingham_seven_tenths_minimax_envelope`](../proofs/classical_guth_maynard_and_qrh_gram.lean#L99), saving $\frac{6}{65}$ in [`thm_29_inflection_shift_barrier_saving_and_seventeen_thirtieths_prime_gap`](../proofs/classical_guth_maynard_and_qrh_gram.lean#L135)).
- **Universal `δ`-Unbundling & `β = 1/2` Hybrid Balance**: [`thm_32_qrh_three_mode_unbundling_215_and_487_over_3264`](../proofs/classical_guth_maynard_and_qrh_gram.lean#L232) proves the exact savings $\frac{1}{24} + \frac{\delta}{16}$ and $\frac{1}{8} + \frac{\delta}{16}$ for all $\delta \in \mathbb{R}$ and pins $\delta = \frac{79}{204}$ via $(4 \cdot 51 \cdot \delta - 79)^2 = 0 \iff \delta = \frac{79}{204}$ (`215/3264` and `487/3264`).
- In [`thm_35_hybrid_ab_coupled_critical_line_fourteen_thirtythirds`](../proofs/classical_guth_maynard_and_qrh_gram.lean#L363), the critical-line ($\beta = 1/2$, $\delta = 0$) required saving $\Delta_{\mathrm{hyb}} = \frac{29 + 3(\alpha_X + \alpha_Y) - 36\beta}{36} = \frac{14}{33}$ is derived directly from `(35/66, 59/66, 7/11)`, yielding the `-17/132` coarse deficit (`13/44 - 14/33`) and `1/33` Welch rank excess without back-solved coupling equations.

---

## 4. Paper 3 (Theorems 36-50): Landau-Siegel Ineffectiveness vs. Elliptic Rank-3 Effectivization

1. **Estermann-Siegel 4-Fold Euler Factor SOS**: Under $\chi_1^2 = \chi_2^2 = 1$, [`thm_36_estermann_siegel_biquadratic_euler_factor_sos`](../proofs/classical_siegel_zero_and_ineffectiveness.lean#L21) proves $(1+\chi_1)(1+\chi_2) = (1+\chi_1+\chi_2+\chi_1\chi_2)^2 / 4 \in \{0, 4\}$.
2. **Perron Truncation & `Classical.em` Barrier**: Optimizing $X = (2 C_0 Q^A)^{2/(2\beta_1 - 1)}$ yields $\frac{2A(1-\beta_1)}{2\beta_1 - 1} \le \varepsilon \iff \beta_1 \ge 1 - \frac{\varepsilon}{2(A+\varepsilon)}$ ([`thm_40_siegel_exponent_threshold_equivalence`](../proofs/classical_siegel_zero_and_ineffectiveness.lean#L87)), while [`thm_41_siegel_implied_constant_decay_with_q1_blowup`](../proofs/classical_siegel_zero_and_ineffectiveness.lean#L114) and [`thm_42_siegel_two_case_nonconstructive_lem_barrier`](../proofs/classical_siegel_zero_and_ineffectiveness.lean#L135) formalize why branching on an unknown phantom modulus $q_1$ cannot produce a uniform positive lower bound.
3. **Goldfeld-Gross-Zagier Rate Tradeoff**: Using $\operatorname{ord}_{s=1} L(E, s) = 3$ (`N_E = 5077`) achieves computability at the cost of replacing $D^{1/2-\varepsilon}$ by $\log D$ ([`thm_47_gross_zagier_oesterle_rate_vs_effectivity_tradeoff`](../proofs/classical_siegel_zero_and_ineffectiveness.lean#L281)).

---

## 5. Paper 4 (Theorems 51-63): Mollifier Scale Ladder and the `J_{AB} = -1/2 => κ(θ) < 1` Wall

- **Mollifier Ladder (`1/66` Spacing)**: Symmetric Kuznetsov `7θ - 4 < 0` (`θ < 4/7`, [`thm_52_deshouillers_iwaniec_kuznetsov_four_sevenths_barrier`](../proofs/classical_levinson_conrey_and_mollifier_barrier.lean#L43)) and `BCR` single-prime unfactored `33θ - 17 < 0` (`θ < 17/33`, [`thm_53_asymmetric_di_gap_and_bcr_17_33_unfactored_window`](../proofs/classical_levinson_conrey_and_mollifier_barrier.lean#L57)) bracket the `QRH` hybrid scale `1/2 < 17/33 < 35/66 < 4/7` ([`thm_54_mollifier_kloosterman_scale_ladder_one_sixtysixth`](../proofs/classical_levinson_conrey_and_mollifier_barrier.lean#L67)).
- **Calculus Proof of `κ(θ) < 1`**: [`thm_55_mollifier_antiderivative_has_deriv_at_and_boundary_invariant`](../proofs/classical_levinson_conrey_and_mollifier_barrier.lean#L79) proves `HasDerivAt` of $\frac{1}{2}e^{2Rv}Q(v)^2$ and $J_{AB} = -1/2$, from which [`thm_56_cauchy_schwarz_discriminant_from_nonnegative_quadratic_form`](../proofs/classical_levinson_conrey_and_mollifier_barrier.lean#L104) through [`thm_59_finite_theta_strictly_below_hundred_percent_no_go`](../proofs/classical_levinson_conrey_and_mollifier_barrier.lean#L171) deduce $c_{\min} > 1$ and $\kappa(\theta) < 1$ for all finite $\theta, R > 0$.
- **Kernel Certification of `κ > 1/3`**: [`thm_61_levinson_linear_polynomial_closed_form_integrals`](../proofs/classical_levinson_conrey_and_mollifier_barrier.lean#L234) and [`thm_62_levinson_one_third_proportion_kernel_certificate`](../proofs/classical_levinson_conrey_and_mollifier_barrier.lean#L279) certify Levinson's $\kappa > 1/3$ via $(613/600)^{40} \le \exp(13/15)$.

---

## 6. Paper 5 (Theorems 64-75): Burgess `r = 2` SOS Trap and Kim-Sarnak `7/64` Residual Barrier

- **Burgess `r = 2` SOS Trap**: At $h = 1/(2r)$ ([`thm_64_burgess_weil_moment_balance_optimal_interval_h`](../proofs/classical_burgess_and_kim_sarnak_barrier.lean#L21)), [`thm_67_burgess_subconvexity_exponent_sos_trap_at_r_eq_2`](../proofs/classical_burgess_and_kim_sarnak_barrier.lean#L90) proves $E_{\mathrm{Burgess}}(r) - 3/16 = (r - 2)^2 / (16 r^2) \ge 0$, establishing $r = 2$ as the unique minimum.
- **Petrow-Young Cubic Break**: Eliminating the `+1` diagonal collision at $r = 3$ lowers `7/36` (`> 3/16`) to `1/6` (`3/16 - 1/6 = 1/48` saving, [`thm_69_conrey_iwaniec_petrow_young_cubic_collision_removal`](../proofs/classical_burgess_and_kim_sarnak_barrier.lean#L147)).
- **Kim-Sarnak `7/64` & Functorial Limit**: Character amplification (`n^2 + 1 -> n(n+1)/2 + 1`) improves Landau's `Sym^4` convexity exponent `3/26` ([`thm_72_landau_rankin_selberg_gln_convexity_pole_formula`](../proofs/classical_burgess_and_kim_sarnak_barrier.lean#L181)) to `7/64` (`5/832` saving, [`thm_73_kim_sarnak_gl5_character_amplification_seven_sixtyfourths`](../proofs/classical_burgess_and_kim_sarnak_barrier.lean#L214)), while leaving a strictly positive finite-`k` residual $0 < \vartheta_k < 1/(2k)$ ([`thm_74_sym_power_langlands_functoriality_limit_to_ramanujan`](../proofs/classical_burgess_and_kim_sarnak_barrier.lean#L235)).

---

## 7. 1-to-1 Mapping Between `15` Upstream Reference Files (`oai_ref/*.lean`) and `Case 015` Theorems

| Upstream File (`proofs/oai_ref/`) | Core Declaration & Operator Mechanism | Causal Bottleneck / Slack Mechanism (`Why`) | Corresponding Lean 4 Theorem |
| :--- | :--- | :--- | :--- |
| [`oai_ref/OrdinaryZetaZeroFree.lean`](../proofs/oai_ref/OrdinaryZetaZeroFree.lean#L35-L60) | `re_log_comb_nonneg` (`3+4 cos θ+cos 2θ >= 0`) | Fixing `s_1 = 4δ` sacrifices `+43.59%` AM-GM slack | [`thm_01_dlvp_three_four_one_sos_identity`](../proofs/classical_dlvp_korobov_and_zero_free.lean#L33) |
| [`oai_ref/ZetaBounds_ZeroFree_excerpt.lean`](../proofs/oai_ref/ZetaBounds_ZeroFree_excerpt.lean#L362-L386) | `ZetaZeroFree` & `LogDerivZetaBnd` (`\|ζ\|^3\|ζ\|^4\|ζ\| >= 1`) | Exponentiated norm-product incurs logarithmic loss | [`thm_05_tao_zetabounds_exponentiated_norm_log9_loss`](../proofs/classical_dlvp_korobov_and_zero_free.lean#L99) |
| [`oai_ref/CharacterPositivity.lean`](../proofs/oai_ref/CharacterPositivity.lean#L44-L53) | `character_positivity_polynomial` (`2(1+cos θ)^2`) | Shifting `c_1/c_2 = 4 -> 3` gives `(17,24,8)` square | [`thm_07_seventeen_twentyfour_eight_perfect_square`](../proofs/classical_dlvp_korobov_and_zero_free.lean#L125) |
| [`oai_ref/NonquadraticZeroFree.lean`](../proofs/oai_ref/NonquadraticZeroFree.lean#L80-L120) | `exists_nonquadratic_zero_free_region` (`K c < 1/32`) | Coarse `9A + 1` splitting drops width to `A/(32(9A+1))` | [`thm_04_three_four_one_four_tier_slack_cascade`](../proofs/classical_dlvp_korobov_and_zero_free.lean#L78) |
| [`oai_ref/GramBound.lean`](../proofs/oai_ref/GramBound.lean#L13-L60) | `actual_additive_gram_bound` (additive Gram bound) | Triangle-inequality row sum destroys oscillatory phase | [`thm_18_halasz_schur_gram_phase_destruction_bound`](../proofs/classical_ingham_huxley_zero_density.lean#L82) |
| [`oai_ref/GramScaleLoss.lean`](../proofs/oai_ref/GramScaleLoss.lean#L21-L39) | `nonexceptional_scale_loss` (`(3 + δ)/8` loss) | Bundling all rows at worst scale inflates exponent | [`thm_31_qrh_gram_scale_loss_and_coarse_bundled_exponent`](../proofs/classical_guth_maynard_and_qrh_gram.lean#L188) |
| [`oai_ref/LowGramScale.lean`](../proofs/oai_ref/LowGramScale.lean#L12-L44) | `compensated_gram_scale_bound` (`(1 + δ)/8` saving) | Mode-by-mode square-root unbundling restores margin | [`thm_32_qrh_three_mode_unbundling_215_and_487_over_3264`](../proofs/classical_guth_maynard_and_qrh_gram.lean#L232) |
| [`oai_ref/Endpoint.lean`](../proofs/oai_ref/Endpoint.lean#L58-L102) | `endpoint_identity` & `balanced_endpoint_strict` | `y=0` SOS vertex uniquely pins `δ = 79/204` | [`thm_34_qrh_endpoint_sos_identity_and_box_margin`](../proofs/classical_guth_maynard_and_qrh_gram.lean#L283) |
| [`oai_ref/GeometricBoundary.lean`](../proofs/oai_ref/GeometricBoundary.lean#L18-L50) | `uniform_exclusion_of_actual_cutoff` (`5/6 <-> 3/4`) | Rescaling by `1 - δ` maps `5/6` to `3/4` threshold | [`thm_33_qrh_rescaled_five_sixths_and_three_quarters_bridge`](../proofs/classical_guth_maynard_and_qrh_gram.lean#L262) |
| [`oai_ref/SiegelBoundProof.lean`](../proofs/oai_ref/SiegelBoundProof.lean#L15-L60) | `publishedSiegelBound` (Siegel theorem wrapper) | Phantom modulus `q_1` branch blocks computability | [`thm_42_siegel_two_case_nonconstructive_lem_barrier`](../proofs/classical_siegel_zero_and_ineffectiveness.lean#L135) |
| [`oai_ref/ActualPageUniqueness.lean`](../proofs/oai_ref/ActualPageUniqueness.lean#L16-L65) | `exists_actual_page_uniqueness` (Page repulsion) | Excludes second zero with `5/46` margin, not first | [`thm_43_landau_page_repulsion_pair_exclusion`](../proofs/classical_siegel_zero_and_ineffectiveness.lean#L157) |
| [`oai_ref/PrimitiveTransfer.lean`](../proofs/oai_ref/PrimitiveTransfer.lean#L310-L335) | `exists_primitive_zero_free_region` (level transfer) | Bezout cutoff & `by_contra` transfer non-vanishing | [`thm_48_openai_002_siegel_zeros_bezout_cutoff_and_by_contra_audit`](../proofs/classical_siegel_zero_and_ineffectiveness.lean#L312) |
| [`oai_ref/Theorem.lean`](../proofs/oai_ref/Theorem.lean#L11-L27) | `exists_absolute_real_zero_gap` (`55264/135375`) | Quadratic gap vs Conrey symmetric `17`-deg ceiling | [`thm_63_deg17_actual_limit_vs_relaxed_coth_ceiling_separation`](../proofs/classical_levinson_conrey_and_mollifier_barrier.lean#L298) |
| [`oai_ref/Parameters.lean`](../proofs/oai_ref/Parameters.lean#L12-L49) | `compensated_geometry` (`3/16` Burgess input) | `r=2` diagonal `+1` collision fixes `(r-2)^2/(16r^2)` | [`thm_70_qrh_parameters_burgess_three_sixteenths_identity`](../proofs/classical_burgess_and_kim_sarnak_barrier.lean#L158) |
| [`oai_ref/CubeFloorSaving.lean`](../proofs/oai_ref/CubeFloorSaving.lean#L21-L60) | `actual_floor_cube_saving` (cubic floor saving) | Cubic collision removal (`1/6`) & `GL_5` amplification | [`thm_69_conrey_iwaniec_petrow_young_cubic_collision_removal`](../proofs/classical_burgess_and_kim_sarnak_barrier.lean#L147) |
