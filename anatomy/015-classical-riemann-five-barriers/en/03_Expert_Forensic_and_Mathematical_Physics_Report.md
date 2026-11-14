# [Case 015 / Tier 3 Expert Forensic & Mathematical Physics Report] Complete Algebraic-Variational Anatomy, Hand-Calculation Slack Recovery, and Axiom-Free Lean 4 Ledger of the Five Classical Riemann Barriers (`Theorems 1-75`)

> **Target Audience**: Specialists in analytic number theory, automorphic forms, harmonic analysis, and interactive theorem proving (`Lean 4 / Mathlib`)
> **Parent Index**: [Main English README (`README.md`)](../README.md) | [Executive Summary (`en/01_`)](01_Executive_Summary_and_General_Guide.md) | [Intermediate Guide (`en/02_`)](02_Intermediate_Math_and_Code_Guide.md) | [Verification Spec (`en/04_`)](04_Automated_Verification_and_Parser_Spec.md)

---

## 1. Architectural Synthesis: Five-Step Causal Chain and Beyond-Baseline Alternative Bounds

Over the past 130 years since de la Vallee Poussin's 1896 proof of the Prime Number Theorem, five canonical analytical offensives against the Riemann zeta function $\zeta(s)$ and Dirichlet $L$-functions $L(s,\chi)$ have each arrested at exact algebraic or variational thresholds. Across `6` Lean 4 modules (`2,238` lines, `75` theorems over `ℝ`, `0 sorry`, `0` custom axioms, `188 / 188` `: True` hypothesis mutations killed = `100%`) cross-audited against `15` upstream formalization files (`proofs/oai_ref/*.lean`, `1,988` lines), `Case 015` derives every intermediate balance equation and isolates recoverable hand-calculation slack from genuine structural obstructions.

### 1.1 Five-Step Causal Chain
- **Step 1 (Exact Barrier & Bottleneck Phenomenon)**: Zero-free width `1/100` and asymptotic `1 - β = o(1)`, zero-density inflection `σ = 3/4 -> 7/10` (`A = 12/5 -> 30/13`), Landau-Siegel ineffectiveness constant `c(ε)`, Conrey's critical-line proportion `κ(4/7) = 0.408058 < 1`, and the Burgess `3/16` and Kim-Sarnak `7/64` subconvexity/Ramanujan bounds each originate from a distinct algebraic balance.
- **Step 2 (Necessary Operator & Transform Mechanism)**: Hadamard partial-fraction positivity projection (`Re(-ζ'/ζ)`), Halasz-Montgomery Gram operators paired with Dirichlet-polynomial functional-equation reflection, Estermann's biquadratic Euler product with Perron contour truncation, Levinson-Conrey mollifier integration by parts (`d/dv`), and Weil character-sum moments paired with Rankin-Selberg convolutions act as the unique positivity/spectral extractors in each regime.
- **Step 3 (Core Algebraic Derivation & Factorization)**: Every equilibrium equation reduces to an explicit sum-of-squares (SOS) decomposition, rational minimax intersection, Cauchy-Schwarz discriminant `1 <= 4 I_{AA} J_{BB}`, or rational numerator factorization `(r - 2)^2 / (16 r^2)`.
- **Step 4 (Contradiction, Non-Vanishing & Fossil Repair)**: Removing textbook hand-calculation fossils (`s_1 = 4δ`, coarse `9A` splitting, Schur absolute-value row sums, bundled Gram row losses, and asymmetric `coth ω` relaxation) recovers substantial slack while proving that diagonal collisions and the boundary invariant `J_{AB} = -1/2` enforce strictly positive residuals.
- **Step 5 (Formalization Boundary & Lean 4 Kernel Proof)**: High-precision quadrature and prime-sum evaluations are executed deterministically in [`verify_symbolic_classical_riemann.py`](../proofs/verify_symbolic_classical_riemann.py#L20-L481), while every polynomial SOS identity, rational minimax crossover, `HasDerivAt` calculus invariant, `Real.exp` hyperbolic bound, and Chebyshev recurrence is proved without axioms in Lean 4 (`v4.29.0-rc8`).

### 1.2 Beyond-Baseline Alternative Bounds and No-Go Rigidity Obstructions
- **Beyond-Baseline Alternative Bound & Slack Recovery**:
  1. Replacing the textbook `s_1 = 4δ` choice (`1/100`) on `(3, 4, 1)` by its exact AM-GM stationary point `u* = 2√3` yields `(7 - 4√3)/5 ≈ 0.014359` (`+43.59%`), and substituting the integer square `(17, 24, 8)` (`(4 cos θ + 3)^2 >= 0`) achieves `(41 - 4√102)/32 ≈ 0.018812` (`+88.12%`, within `99.96%` of the global degree-2 optimum `0.018819`).
  2. Unbundling the three `QRH` Gram regimes universally in `δ ∈ ℝ` (`1/24 + δ/16` and `1/8 + δ/16`) recovers `487/3264 ≈ 0.149203` at `δ = 79/204`, while single-destruct specialization in `Ostmann` lowers the Siegel-Walfisz conductor threshold from `4,115,904` to `255,983` (`16.08x` reduction).
- **Sharp No-Go / Rigidity Obstruction Theorems**:
  1. **Degree-3 Sign-Changing Fejer Counterexample & Universal Ceiling**: On sign-changing nonnegative cosine polynomials, the positive-part weight bound `W_+ = ∑ max(c_k, 0) >= 2 c_1 - c_0` is **refuted** by the explicit degree-3 Fejer square `(65/16, 9/2, 0, -1)` (`W_+ = 72/16 < 79/16`), whereas both the Hadamard cone weight `W = ∑ c_k` (`c_k >= 0`) and the two-sided Weyl absolute weight `W_abs = ∑ |c_k|` (`c_k ∈ ℝ`) obey `>= 2 c_1 - c_0` and are trapped below `(3 - 2√2)/3 ≈ 0.057191` by Fejer-Riesz autocorrelation `c_1 < 2 c_0`, forcing `1 - β -> 0`.
  2. **Gram Phase Destruction, `Classical.em` Non-Constructivity, `J_{AB} = -1/2` Barrier, and Burgess SOS Trap**: Schur's triangle-inequality `ε n^2 > 0` gap (`4.5390` vs. `3.0245` at `R=64, N=128`), phantom-modulus branching in Siegel's theorem, Conrey's finite-`θ` ceiling `κ(θ) < 1`, and `(r - 2)^2 / (16 r^2) >= 0` are sealed as unconditional No-Go / rigidity theorems.

---

## 2. Paper 1 (`Theorems 1-15`): de la Vallee Poussin (1896) & Korobov-Vinogradov (1958) Zero-Free Region Anatomy

### 2.1 Pole-Zero SOS Identity, Irreducible Quintic Stationarity, and Fejer-Riesz Autocorrelation
Applying $P(\theta) := c_0 + \sum_{k=1}^N c_k \cos(k\theta) \ge 0$ to $-\operatorname{Re}(\zeta'/\zeta)$ requires $c_k \ge 0$ ($k \ge 1$) to drop nontrivial zero terms $-\operatorname{Re}(1/(s-\rho)) < 0$. With $u := c_0 + A W s_1$ ($W := \sum_{k=1}^N c_k$), we obtain
$$u \cdot A W \delta(s_1) = c_1 u - c_0 c_1 - u(u - c_0) = u\left(\sqrt{c_1} - \sqrt{c_0}\right)^2 - \left(u - \sqrt{c_0 c_1}\right)^2.$$
Along the normalized degree-2 boundary $c_2 = 1$, $c_1 = r \in (0, 4)$, $c_0 = 1 + r^2/8$, differentiating $C_2(r) := (\sqrt{r} - \sqrt{1+r^2/8})^2 / (r+1)$ yields the irreducible quintic
$$P_5(r) := r^5 + 4r^4 - 12r^3 - 40r^2 + 64r - 64 = 0, \qquad r^* \approx 2.966229549437,$$
whose rational approximant $r = 3$ produces $17 + 24\cos\theta + 8\cos 2\theta = (4\cos\theta + 3)^2 \ge 0$ with $C(17,24,8) = (41 - 4\sqrt{102})/32 \approx 0.01881188$ (`99.9646%` of optimal).

Upstream formalization cross-audits cover [`oai_ref/OrdinaryZetaZeroFree.lean#L13-L35`](../proofs/oai_ref/OrdinaryZetaZeroFree.lean#L13-L35) (`re_log_comb_nonneg`), [`oai_ref/OrdinaryZetaZeroFree.lean#L77-L167`](../proofs/oai_ref/OrdinaryZetaZeroFree.lean#L77-L167) (`norm_riemannZeta_product_ge_one`, `riemannZeta_ne_zero_of_one_le_re_of_ne_one`), [`oai_ref/ZetaBounds_ZeroFree_excerpt.lean#L7-L163`](../proofs/oai_ref/ZetaBounds_ZeroFree_excerpt.lean#L7-L163) (`ZetaInvBound2`, `ZetaInvBnd`), [`oai_ref/ZetaBounds_ZeroFree_excerpt.lean#L241-L386`](../proofs/oai_ref/ZetaBounds_ZeroFree_excerpt.lean#L241-L386) (`ZetaLowerBnd`, `ZetaZeroFree`, `LogDerivZetaBnd`), [`oai_ref/CharacterPositivity.lean#L44-L101`](../proofs/oai_ref/CharacterPositivity.lean#L44-L101) (`character_positivity_polynomial`, `character_log_derivative_positivity`), and [`oai_ref/NonquadraticZeroFree.lean#L12-L80`](../proofs/oai_ref/NonquadraticZeroFree.lean#L12-L80) (`modulusHeight`, `exists_nonquadratic_zero_free_region`), while degree-8 optimizations (`0.02894712` for `c_k >= 0`, `0.02925694 < 0.05719096` for `W_abs`) are verified in [`verify_paper1_pole_zero_sos_and_four_tier_cascade`](../proofs/verify_symbolic_classical_riemann.py#L20-L91), [`verify_paper1_deg2_quintic_and_17_24_8`](../proofs/verify_symbolic_classical_riemann.py#L94-L141), and [`verify_paper1_fejer_riesz_and_korobov_barrier`](../proofs/verify_symbolic_classical_riemann.py#L208-L257).

### 2.2 Complete Theorem Ledger for `classical_dlvp_korobov_and_zero_free.lean` (`Theorems 1-15`)
- [`thm_01_dlvp_three_four_one_sos_identity`](../proofs/classical_dlvp_korobov_and_zero_free.lean#L33): Proves $3 + 4\cos\theta + \cos(2\theta) = 2(1 + \cos\theta)^2 \ge 0$.
- [`thm_02_pole_zero_sos_decomposition`](../proofs/classical_dlvp_korobov_and_zero_free.lean#L40): Exact SOS decomposition in $u := c_0 + A W s_1$ and AM-GM bound $(\sqrt{c_1}-\sqrt{c_0})^2 / W$.
- [`thm_03_stationary_point_zero_free_implication`](../proofs/classical_dlvp_korobov_and_zero_free.lean#L53): Evaluates stationary $s_1^* = (\sqrt{c_0 c_1} - c_0)/(A W)$ to deduce $1 - \beta \ge (\sqrt{c_1}-\sqrt{c_0})^2 / (A W M)$.
- [`thm_04_three_four_one_four_tier_slack_cascade`](../proofs/classical_dlvp_korobov_and_zero_free.lean#L78): Strict four-tier ladder `A / (32(9A + 1)) < 1/100 < 1/70 < (7 - 4√3)/5` and Pell convergent `56√3 < 97` certificate.
- [`thm_05_tao_zetabounds_exponentiated_norm_log9_loss`](../proofs/classical_dlvp_korobov_and_zero_free.lean#L99): Quantifies constant degradation when exponentiating $-\operatorname{Re}(\zeta'/\zeta)$ into $|\zeta|^3|\zeta|^4|\zeta| \ge 1$.
- [`thm_06_degree2_cosine_vertex_completion_of_squares`](../proofs/classical_dlvp_korobov_and_zero_free.lean#L109): Vertex completion of squares for general degree-2 cosine polynomials ($8 c_0 c_2 \ge 8 c_2^2 + c_1^2$).
- [`thm_07_seventeen_twentyfour_eight_perfect_square`](../proofs/classical_dlvp_korobov_and_zero_free.lean#L125): Proves $17 + 24\cos\theta + 8\cos(2\theta) = (4\cos\theta + 3)^2 \ge 0$.
- [`thm_08_seventeen_twentyfour_eight_exact_constant_and_gain`](../proofs/classical_dlvp_korobov_and_zero_free.lean#L132): Exact evaluation $C(17,24,8) = (41 - 4\sqrt{102})/32 > 0.0188118$ beating `(3,4,1)`.
- [`thm_09_degree2_global_quintic_stationarity_and_root`](../proofs/classical_dlvp_korobov_and_zero_free.lean#L155): Sign-change bracket $(2.9662, 2.9663)$ and root existence for $P_5(r)$.
- [`thm_10_degree2_global_ceiling_and_9996_tightness`](../proofs/classical_dlvp_korobov_and_zero_free.lean#L171): Global ceiling `< 0.018819` over all nonnegative degree-2 cosine polynomials and `99.96%` tightness of `(17,24,8)`.
- [`thm_11_fejer_riesz_autocorrelation_strict_two_c0_barrier`](../proofs/classical_dlvp_korobov_and_zero_free.lean#L285): Proves $2c_0 - c_1 = a_0^2 + a_N^2 + \sum (a_{j+1}-a_j)^2 > 0 \implies c_1 < 2c_0$.
- [`thm_12_general_cosine_pi_weight_lower_bound`](../proofs/classical_dlvp_korobov_and_zero_free.lean#L329): Proves $W \ge 2c_1 - c_0$ (`c_k >= 0`) and $W_{\mathrm{abs}} \ge 2c_1 - c_0$ (`c_k ∈ ℝ`) via Chebyshev induction at $\theta = \pi$, and refutes $W_+ \ge 2c_1 - c_0$ via `signChangeWitnessC = (65/16, 9/2, 0, -1)`.
- [`thm_13_fejer_riesz_universal_constant_ceilings`](../proofs/classical_dlvp_korobov_and_zero_free.lean#L378): Universal arbitrary-degree ceiling $(\sqrt{c_1}-\sqrt{c_0})^2 / W_{\mathrm{abs}} < (3 - 2\sqrt{2})/3 < 0.057191$.
- [`thm_14_korobov_vinogradov_two_thirds_exponent_balance`](../proofs/classical_dlvp_korobov_and_zero_free.lean#L423): Derives the $2/3$ Korobov-Vinogradov exponent and Ford's $1/(4\alpha+3)$ scaling at $\eta = 1/(3\alpha)$.
- [`thm_15_asymptotic_sigma_eq_one_minus_o1_barrier_no_go`](../proofs/classical_dlvp_korobov_and_zero_free.lean#L461): Proves $1 - \beta \le (3 - 2\sqrt{2})/(3 A M(|t|)) < \varepsilon$ as $M(|t|) \to \infty$.

---

## 3. Paper 2 (`Theorems 16-35`): Ingham (1940), Huxley (1972), Guth-Maynard (2024) Zero Density & `QRH` Gram Anatomy

### 3.1 Moment-Reflection Minimax, Guth-Maynard Determinantal Energy, and `QRH` Unbundling
Ingham's zero-detection balance $A_{\mathrm{Ing}}(\sigma) := 3/(2-\sigma)$ meets Huxley's reflection-subdivision curve $A_{\mathrm{Hux}}(\sigma) := 3/(3\sigma-1)$ at $\sigma^* = 3/4$ with peak $12/5 = 2.4$. Guth-Maynard (2024) replace the large-values step by the `3 x 3` determinantal energy $E_3 \le 2 + \nu(12/5 - 4\sigma)$, yielding $A_{\mathrm{GM}}(\sigma) := 15/(5\sigma+3)$ whose middle-branch slack numerator satisfies
$$250\left(\sigma - \frac{3}{4}\right)^2 + \frac{3}{8} > 0$$
for all $\sigma \in \mathbb{R}$, shifting the minimax peak to $(\sigma^*_{\mathrm{GM}}, A) = (7/10, 30/13)$.

Upstream `QRH` (`#001`) audits examine [`oai_ref/GramBound.lean#L13-L85`](../proofs/oai_ref/GramBound.lean#L13-L85) (`actual_additive_gram_bound`), [`oai_ref/GramScaleLoss.lean#L8-L39`](../proofs/oai_ref/GramScaleLoss.lean#L8-L39) (`nonexceptional_scale_identity`, `nonexceptional_scale_loss`), [`oai_ref/LowGramScale.lean#L8-L53`](../proofs/oai_ref/LowGramScale.lean#L8-L53) (`compensated_gram_ratio`, `compensated_gram_scale_bound`, `source_gram_sqrt_power`), [`oai_ref/GeometricBoundary.lean#L18-L56`](../proofs/oai_ref/GeometricBoundary.lean#L18-L56) (`uniform_exclusion_of_actual_cutoff`), [`oai_ref/Endpoint.lean#L14-L68`](../proofs/oai_ref/Endpoint.lean#L14-L68) (`certificateWeight`, `balancedExponent`, `endpoint_identity`, `balanced_endpoint_margin`), and [`oai_ref/Endpoint.lean#L102-L113`](../proofs/oai_ref/Endpoint.lean#L102-L113) (`balanced_endpoint_strict`), backed by [`verify_paper2_ingham_huxley_and_guth_maynard`](../proofs/verify_symbolic_classical_riemann.py#L260-L360) and [`verify_paper2_qrh_gram_and_hybrid_bridges`](../proofs/verify_symbolic_classical_riemann.py#L363-L440).

### 3.2 Theorem Ledger for `classical_ingham_huxley_zero_density.lean` & `classical_guth_maynard_and_qrh_gram.lean` (`Theorems 16-35`)
- [`thm_16_ingham_three_term_zero_detection_balance`](../proofs/classical_ingham_huxley_zero_density.lean#L29): Derives $3/(2-\sigma)$ at optimal zero-detection cutoff $y = 1/(2-\sigma)$.
- [`thm_17_ingham_slope_strict_monotonicity_and_conservation`](../proofs/classical_ingham_huxley_zero_density.lean#L56): Strict monotonicity and $(2-\sigma) A_{\mathrm{Ing}}(\sigma) = 3$.
- [`thm_18_halasz_schur_gram_phase_destruction_bound`](../proofs/classical_ingham_huxley_zero_density.lean#L82): Hermitian Schur row-sum bound and strict $\varepsilon n^2 > 0$ phase-destruction loss.
- [`thm_19_huxley_reflection_subdivision_large_values_derivation`](../proofs/classical_ingham_huxley_zero_density.lean#L134): Derives Huxley's large-values exponent $2 + 2/(3\sigma-1)$ at $T_0 = \tau^{1/(3\sigma-1)}$.
- [`thm_20_huxley_k2_k3_amplification_and_cutoff_compatibility`](../proofs/classical_ingham_huxley_zero_density.lean#L178): Solves $k = 2 \to 3$ amplification crossover $3/(3\sigma-1)$ and $\sigma \ge 3/4$ compatibility.
- [`thm_21_ingham_huxley_minimax_three_quarters_inflection`](../proofs/classical_ingham_huxley_zero_density.lean#L214): Unique minimax inflection at $\sigma^* = 3/4$ with peak $12/5$.
- [`thm_22_density_hypothesis_gap_and_prime_gap_seven_twelfths`](../proofs/classical_ingham_huxley_zero_density.lean#L242): Proves Density Hypothesis gap $2/5$ and prime-gap threshold $\theta = 7/12$.
- [`thm_23_huxley_higher_amplification_strict_decay`](../proofs/classical_ingham_huxley_zero_density.lean#L270): Strict decay of $k \ge 3$ branches below $k=2$ for $\sigma > 3/4$.
- [`thm_24_phase_cancellation_loss_witness_signed_vs_abs`](../proofs/classical_ingham_huxley_zero_density.lean#L322): Explicit signed Gram witness separating true Rayleigh quotient from Schur row sum.
- [`thm_25_global_ingham_huxley_exponent_strict_monotonicity`](../proofs/classical_ingham_huxley_zero_density.lean#L382): Global ascent on $(1/2, 3/4)$ and descent on $(3/4, 1)$.
- [`thm_26_guth_maynard_k2_k3_amplification_and_sos_middle_margin`](../proofs/classical_guth_maynard_and_qrh_gram.lean#L23): Derives $15/(5\sigma+3)$ and unconditional SOS middle-term margin $250(\sigma - 3/4)^2 + 3/8 > 0$.
- [`thm_27_guth_maynard_vs_huxley_exact_four_fifths_crossover`](../proofs/classical_guth_maynard_and_qrh_gram.lean#L78): Exact $(4/5 - \sigma)$ factorization governing the $\sigma = 4/5$ crossover.
- [`thm_28_guth_maynard_ingham_seven_tenths_minimax_envelope`](../proofs/classical_guth_maynard_and_qrh_gram.lean#L99): Establishes the new minimax peak at $\sigma^*_{\mathrm{GM}} = 7/10$ with $A = 30/13$.
- [`thm_29_inflection_shift_barrier_saving_and_seventeen_thirtieths_prime_gap`](../proofs/classical_guth_maynard_and_qrh_gram.lean#L135): Proves peak saving $12/5 - 30/13 = 6/65$, shift $1/20$, and prime-gap exponent $17/30$.
- [`thm_30_guth_maynard_det3_rank_defect_s2_collapse_barrier`](../proofs/classical_guth_maynard_and_qrh_gram.lean#L151): Proves rank-defect branch $S_2$ collapse back to classical Weyl-Iwaniec bounds.
- [`thm_31_qrh_gram_scale_loss_and_coarse_bundled_exponent`](../proofs/classical_guth_maynard_and_qrh_gram.lean#L188): Coarse bundled exponent $(17 + 13\delta)/48$ and positive failure `4399/9792 > 0` at `δ = 79/204`.
- [`thm_32_qrh_three_mode_unbundling_215_and_487_over_3264`](../proofs/classical_guth_maynard_and_qrh_gram.lean#L232): Universal $\delta$-savings $1/24 + \delta/16$ and $1/8 + \delta/16$, plus SOS vertex $(4 \cdot 51 \cdot \delta - 79)^2 = 0 \iff \delta = 79/204$ yielding `215/3264` and `487/3264`.
- [`thm_33_qrh_rescaled_five_sixths_and_three_quarters_bridge`](../proofs/classical_guth_maynard_and_qrh_gram.lean#L262): Exact bijection mapping `σ = 5/6` and `δ = 1/3` to $\sigma_{\mathrm{eff}} = 3/4$.
- [`thm_34_qrh_endpoint_sos_identity_and_box_margin`](../proofs/classical_guth_maynard_and_qrh_gram.lean#L283): Proves the `oai_ref/Endpoint.lean` SOS numerator identity and `49/440640` box floor.
- [`thm_35_hybrid_ab_coupled_critical_line_fourteen_thirtythirds`](../proofs/classical_guth_maynard_and_qrh_gram.lean#L363): Solves $(\alpha_X, \alpha_Y, \sigma_{\mathrm{eff}}) = (35/66, 59/66, 7/11)$ and derives the critical-line ($\beta = 1/2$) required saving $(29 + 3(\alpha_X + \alpha_Y) - 36\beta)/36 = 14/33$, coarse deficit $-17/132$, and Welch rank excess $1/33$.

---

## 4. Paper 3 (`Theorems 36-50`): Siegel (1935) Ineffectiveness & Goldfeld-Gross-Zagier (1985) Effectivization Anatomy

### 4.1 Estermann Biquadratic Series, Perron Truncation, and the `Classical.em` Barrier
For real primitive characters $\chi_1, \chi_2$ ($\chi_1^2 = \chi_2^2 = 1$), the local Euler factor of $F(s) := \zeta(s) L(s,\chi_1) L(s,\chi_2) L(s,\chi_1\chi_2)$ obeys
$$4(1+\chi_1)(1+\chi_2) = (1+\chi_1+\chi_2+\chi_1\chi_2)^2 - (\chi_1^2-1)(1+\chi_2)^2 - (\chi_2^2-1)(2+2\chi_1),$$
taking values in $\{0, 4\}$ and guaranteeing nonnegative Dirichlet coefficients bounded below by $a_1 = 1$. Optimizing Perron truncation at $X := (2 C_0 Q^A)^{2/(2\beta_1 - 1)}$ yields $L(1,\chi_2) \gg_\varepsilon q_2^{-\varepsilon}$ with an implied constant decaying as $q_1^{-A/(2\beta_1-1)} \to 0$ if a phantom zero $\beta_1 \to 1^-$ exists. Goldfeld-Gross-Zagier achieve computability via an elliptic curve of conductor `5077` ($\operatorname{ord}_{s=1} L(E,s) = 3$), trading $D^{1/2-\varepsilon}$ for $\log D$.

Upstream `#002` (`SiegelZeros`) audits cover [`oai_ref/SiegelBoundProof.lean#L15-L89`](../proofs/oai_ref/SiegelBoundProof.lean#L15-L89) (`publishedSiegelBound`), [`oai_ref/ActualPageUniqueness.lean#L16-L87`](../proofs/oai_ref/ActualPageUniqueness.lean#L16-L87) (`exists_actual_page_uniqueness`), [`oai_ref/PrimitiveTransfer.lean#L11-L168`](../proofs/oai_ref/PrimitiveTransfer.lean#L11-L168) (`exists_primitive_real_zero_free_disk`, `real_pole_bound_away_from_zero`), and [`oai_ref/PrimitiveTransfer.lean#L219-L415`](../proofs/oai_ref/PrimitiveTransfer.lean#L219-L415) (`exists_primitive_zero_free_region`, `LFunction_primitive_ne_zero_iff`), alongside [`verify_paper3_siegel_goldfeld_and_ostmann`](../proofs/verify_symbolic_classical_riemann.py#L443-L452).

### 4.2 Complete Theorem Ledger for `classical_siegel_zero_and_ineffectiveness.lean` (`Theorems 36-50`)
- [`thm_36_estermann_siegel_biquadratic_euler_factor_sos`](../proofs/classical_siegel_zero_and_ineffectiveness.lean#L21): Proves $(1+\chi_1)(1+\chi_2) \in \{0, 4\}$ and nonnegativity under $\chi_1^2 = \chi_2^2 = 1$.
- [`thm_37_estermann_dirichlet_series_first_term_floor`](../proofs/classical_siegel_zero_and_ineffectiveness.lean#L38): Nonnegative Dirichlet series floor $\sum a_n w_n \ge 1$ from $a_1 = 1$.
- [`thm_38_perron_contour_dichotomy_zero_kills_f_value`](../proofs/classical_siegel_zero_and_ineffectiveness.lean#L48): Auxiliary zero $L(\beta_1,\chi_1) = 0$ annihilates $F(\beta_1)$, isolating the $s=1$ residue.
- [`thm_39_siegel_perron_optimal_truncation_scale`](../proofs/classical_siegel_zero_and_ineffectiveness.lean#L57): Exact $1/2$ residue margin at optimal Perron cutoff scale.
- [`thm_40_siegel_exponent_threshold_equivalence`](../proofs/classical_siegel_zero_and_ineffectiveness.lean#L87): Equivalence $2A(1-\beta_1)/(2\beta_1-1) \le \varepsilon \iff \beta_1 \ge 1 - \varepsilon/(2(A+\varepsilon))$.
- [`thm_41_siegel_implied_constant_decay_with_q1_blowup`](../proofs/classical_siegel_zero_and_ineffectiveness.lean#L114): Implied constant decay below arbitrary $\delta_{\mathrm{target}} > 0$ as $Q_1 \to \infty$.
- [`thm_42_siegel_two_case_nonconstructive_lem_barrier`](../proofs/classical_siegel_zero_and_ineffectiveness.lean#L135): No-Go obstruction proving impossibility of a uniform positive lower bound across phantom-zero branches.
- [`thm_43_landau_page_repulsion_pair_exclusion`](../proofs/classical_siegel_zero_and_ineffectiveness.lean#L157): Landau-Page pair exclusion with exact $60/23 - 5/2 = 5/46$ repulsion margin.
- [`thm_44_tatuzawa_one_exceptional_modulus_effective_dichotomy`](../proofs/classical_siegel_zero_and_ineffectiveness.lean#L190): Tatuzawa effective dichotomy outside at most one exceptional modulus.
- [`thm_45_dirichlet_class_number_formula_siegel_transfer`](../proofs/classical_siegel_zero_and_ineffectiveness.lean#L207): Transfers $L(1,\chi_{-D})$ lower bounds to $h(-D)$ via Dirichlet's class number formula.
- [`thm_46_goldfeld_gross_zagier_rank3_order_vanishing_mechanism`](../proofs/classical_siegel_zero_and_ineffectiveness.lean#L246): Proves $\operatorname{ord}_{s=1} \ge 2$ (`ord(E) = 3`) yields an unconditional logarithmic floor without phantom branching.
- [`thm_47_gross_zagier_oesterle_rate_vs_effectivity_tradeoff`](../proofs/classical_siegel_zero_and_ineffectiveness.lean#L281): Formalizes the crossover between effective $\log D$ and ineffective $D^{1/2-\varepsilon}$ growth.
- [`thm_48_openai_002_siegel_zeros_bezout_cutoff_and_by_contra_audit`](../proofs/classical_siegel_zero_and_ineffectiveness.lean#L312): Audits Bezout cutoff `H = 86,713,344` monotonicity and `by_contra` transfer.
- [`thm_49_case009_ostmann_single_destruct_and_loglog_bottleneck_bridge`](../proofs/classical_siegel_zero_and_ineffectiveness.lean#L323): Proves the `Ostmann` conductor reduction `87,689 < 255,983 < 640,722 < 4,115,904` (`> 16x` gain).
- [`thm_50_paper3_siegel_ineffectiveness_and_effectivization_master_ledger`](../proofs/classical_siegel_zero_and_ineffectiveness.lean#L334): Unified algebraic synthesis ledger for Paper 3.

---

## 5. Paper 4 (`Theorems 51-63`): Selberg (1942), Levinson (1974), Conrey (1989) Critical-Line Proportion & Mollifier Barrier

### 5.1 Kuznetsov Off-Diagonal Limits (`4/7`, `17/33`), Boundary Invariant (`J_{AB} = -1/2`), and Symmetric Quadrature
Writing $\kappa(\theta, R, Q) := 1 - \frac{1}{R}\log c(R, Q)$ with $A(v) := e^{Rv}Q(v)$ and $B(v) := \frac{1}{2R}A'(v) + \frac{1}{2}A(v)$, boundary conditions $Q(0)=1, Q(1)=0$ lock the cross-integral to the **universal topological boundary invariant**
$$J_{AB} := \int_0^1 A(v)\frac{A'(v)}{2R}\,dv = \frac{e^{2R}Q(1)^2 - Q(0)^2}{4R} = -\frac{1}{2}.$$
Combining Cauchy-Schwarz ($I_{AA} J_{BB} \ge J_{AB}^2 = 1/4$) with $\coth(\omega) > 1$ ($\omega := R/\theta > 0$) forces
$$c(R, Q) \ge 1 + 2 J_{AB} + \frac{J_{BB}}{\theta} + \theta I_{AA} \ge \sqrt{1 + \frac{2\theta}{R}\coth\!\left(\frac{R}{\theta}\right) + \frac{\theta^2}{R^2}\coth^2\!\left(\frac{R}{\theta}\right)} > 1,$$
proving $\kappa(\theta) < 1$ for every finite $\theta > 0$. Moreover, functional-equation symmetry $Q(v) + Q(1-v) = 1$ enforces $A(v)^2 + A(1-v)^2 \ge e^R / (e^{R-2Rv} + e^{2Rv-R})$, separating Conrey's actual degree-17 optimum (`κ = 0.408058` at `θ = 4/7, R = 1.3025`) from the unconstrained $\coth$ ceiling (`0.528097`). Upstream [`oai_ref/Theorem.lean#L11-L27`](../proofs/oai_ref/Theorem.lean#L11-L27) (`exists_absolute_real_zero_gap`, `55264/135375 ≈ 0.40822899`) and `80`-point Gauss-Legendre optimizations are verified in [`verify_paper4_levinson_conrey_and_mollifiers`](../proofs/verify_symbolic_classical_riemann.py#L455-L473).

### 5.2 Complete Theorem Ledger for `classical_levinson_conrey_and_mollifier_barrier.lean` (`Theorems 51-63`)
- [`thm_51_selberg_levinson_littlewood_jensen_proportion_floor`](../proofs/classical_levinson_conrey_and_mollifier_barrier.lean#L28): Littlewood-Jensen implication $1 < c \le e^{R(1-\kappa_0)} \implies \kappa \ge \kappa_0 > 0$.
- [`thm_52_deshouillers_iwaniec_kuznetsov_four_sevenths_barrier`](../proofs/classical_levinson_conrey_and_mollifier_barrier.lean#L43): Symmetric Kuznetsov convergence threshold $7\theta - 4 < 0 \iff \theta < 4/7$.
- [`thm_53_asymmetric_di_gap_and_bcr_17_33_unfactored_window`](../proofs/classical_levinson_conrey_and_mollifier_barrier.lean#L57): Asymmetric Weil limit `1/2` and `BCR` unfactored prime window $33\theta - 17 < 0 \iff \theta < 17/33$.
- [`thm_54_mollifier_kloosterman_scale_ladder_one_sixtysixth`](../proofs/classical_levinson_conrey_and_mollifier_barrier.lean#L67): Exact mollifier ladder $1/2 < 17/33 < 35/66 < 4/7$ (`1/66` and `1/231` spacings).
- [`thm_55_mollifier_antiderivative_has_deriv_at_and_boundary_invariant`](../proofs/classical_levinson_conrey_and_mollifier_barrier.lean#L79): Kernel `HasDerivAt` proof of $\frac{d}{dv}(\frac{1}{2}e^{2Rv}Q(v)^2)$ and boundary invariant $J_{AB} = -1/2$.
- [`thm_56_cauchy_schwarz_discriminant_from_nonnegative_quadratic_form`](../proofs/classical_levinson_conrey_and_mollifier_barrier.lean#L104): Derives $1 \le 4 I_{AA} J_{BB}$ directly from $I_{AA} t^2 + 2 J_{AB} t + J_{BB} \ge 0$.
- [`thm_57_hyperbolic_coth_strictly_exceeds_one_from_exp`](../proofs/classical_levinson_conrey_and_mollifier_barrier.lean#L137): Proves $\coth(\omega) > 1$ for $\omega > 0$ via $e^{2\omega} > 1$.
- [`thm_58_conrey_variational_mean_square_strictly_above_one`](../proofs/classical_levinson_conrey_and_mollifier_barrier.lean#L149): Proves $c_{\min} > 1$ for all finite $\theta, R > 0$.
- [`thm_59_finite_theta_strictly_below_hundred_percent_no_go`](../proofs/classical_levinson_conrey_and_mollifier_barrier.lean#L171): Proves $\kappa(\theta) < 1$ (`100%` unreachable for finite mollifier length).
- [`thm_60_functional_equation_symmetry_pointwise_iaa_floor`](../proofs/classical_levinson_conrey_and_mollifier_barrier.lean#L185): Pointwise $I_{AA}$ symmetry floor from $Q(v)+Q(1-v)=1$.
- [`thm_61_levinson_linear_polynomial_closed_form_integrals`](../proofs/classical_levinson_conrey_and_mollifier_barrier.lean#L234): Kernel `HasDerivAt` verification of closed-form integrals `(e^{2R} - (1 + 2R(1 + R)))/(4R^3)` and `(e^{2R} - (1 + 2R(R - 1)))/(4R)` for $Q(v)=1-v$.
- [`thm_62_levinson_one_third_proportion_kernel_certificate`](../proofs/classical_levinson_conrey_and_mollifier_barrier.lean#L279): Certifies $\kappa > 1/3$ at $\theta = 1/2, R = 13/10$ via $(613/600)^{40} \le \exp(13/15)$.
- [`thm_63_deg17_actual_limit_vs_relaxed_coth_ceiling_separation`](../proofs/classical_levinson_conrey_and_mollifier_barrier.lean#L298): Strict separation between symmetric degree-17 optima, `55264/135375`, and relaxed $\coth$ ceilings across $\theta \in \{1/2, 4/7, 1, 2\}$.

---

## 6. Paper 5 (`Theorems 64-75`): Burgess (1963) `3/16` SOS Trap, Selberg (1965), and Kim-Sarnak (2003) `7/64` Barrier

### 6.1 Weil Moment SOS Trap (`(r - 2)^2 / (16 r^2)`), Petrow-Young Cubic Saving, and `Sym^4` Amplification
Balancing $2r$-th Weil character-sum moments fixes $h = 1/(2r)$ with nontriviality threshold $\alpha > 1/4 + 1/(4r) \to 1/4$. In the subconvexity regime $\alpha = 1/2$, however, the diagonal `+1` collision yields
$$E_{\mathrm{Burgess}}(r) := \frac{r^2 - r + 1}{4 r^2}, \qquad E_{\mathrm{Burgess}}(r) - \frac{3}{16} = \frac{(r - 2)^2}{16 r^2} \ge 0,$$
trapping the minimum uniquely at $r = 2$ (`3/16`) while $r = 3$ degrades to `7/36`. Conrey-Iwaniec (2000) and Petrow-Young (2020) eliminate the cubic `+1` collision via `GL_2` spectral decomposition to reach $(3 - 1)/(4 \cdot 3) = 1/6$ (`1/48` saving). On the spectral side, Selberg (1965) bridged the `3/4 - 1/2 = 1/4` Kloosterman abscissa gap, and Kim-Sarnak (2003) combined `Sym^4` (`GL_5`, Landau convexity `3/26`) with character amplification (`n^2 + 1 -> n(n+1)/2 + 1`) to obtain $\vartheta = 7/64$ (`5/832` saving).

Upstream audits inspect [`oai_ref/Parameters.lean#L12-L66`](../proofs/oai_ref/Parameters.lean#L12-L66) (`compensated_geometry`, `cumulative_frequency_bound`) and [`oai_ref/CubeFloorSaving.lean#L17-L81`](../proofs/oai_ref/CubeFloorSaving.lean#L17-L81) (`savingFloorPoolOutside`, `actual_floor_cube_saving`), while `98.0054%` Kloosterman phase cancellation over all `302` odd primes `p <= 1999` (`signed -5.0218` vs. `abs 251.7678`) is verified in [`verify_paper5_burgess_selberg_and_kim_sarnak`](../proofs/verify_symbolic_classical_riemann.py#L476-L481).

### 6.2 Complete Theorem Ledger for `classical_burgess_and_kim_sarnak_barrier.lean` (`Theorems 64-75`)
- [`thm_64_burgess_weil_moment_balance_optimal_interval_h`](../proofs/classical_burgess_and_kim_sarnak_barrier.lean#L21): Balances diagonal $1 - 2rh$ against Weil $1/2 - rh$ at $h = 1/(2r)$.
- [`thm_65_burgess_short_character_sum_exponent_derivation`](../proofs/classical_burgess_and_kim_sarnak_barrier.lean#L34): Derives short-sum saving exponent $((4r - 4)\alpha - 1)/(8r)$.
- [`thm_66_burgess_nontrivial_threshold_one_quarter_limit`](../proofs/classical_burgess_and_kim_sarnak_barrier.lean#L70): Monotone descent of $\alpha_r = 1/4 + 1/(4r)$ toward the $1/4$ barrier.
- [`thm_67_burgess_subconvexity_exponent_sos_trap_at_r_eq_2`](../proofs/classical_burgess_and_kim_sarnak_barrier.lean#L90): Proves $E_{\mathrm{Burgess}}(r) - 3/16 = (r - 2)^2 / (16 r^2) \ge 0$ and unique optimality of $r = 2$.
- [`thm_68_burgess_strict_degradation_for_higher_moments`](../proofs/classical_burgess_and_kim_sarnak_barrier.lean#L127): Strict degradation $(r^2 - 2r - 1)/(4 r^2 (r+1)^2) > 0$ for all $r \ge 3$.
- [`thm_69_conrey_iwaniec_petrow_young_cubic_collision_removal`](../proofs/classical_burgess_and_kim_sarnak_barrier.lean#L147): Cubic `+1` collision removal dropping `7/36 -> 1/6` (`1/48` saving below `3/16`).
- [`thm_70_qrh_parameters_burgess_three_sixteenths_identity`](../proofs/classical_burgess_and_kim_sarnak_barrier.lean#L158): Matches `oai_ref/Parameters.lean` `3/16` geometry to $E_{\mathrm{Burgess}}(2)$.
- [`thm_71_selberg_1965_kloosterman_zeta_weil_abscissa_vs_spectral_line`](../proofs/classical_burgess_and_kim_sarnak_barrier.lean#L167): Bridges Weil abscissa `3/4` to spectral line `1/2` giving $\vartheta \le 1/4$.
- [`thm_72_landau_rankin_selberg_gln_convexity_pole_formula`](../proofs/classical_burgess_and_kim_sarnak_barrier.lean#L181): Derives Landau convexity $(k+2)/(2(k^2+2k+2))$ (`3/26` at $k = 4$).
- [`thm_73_kim_sarnak_gl5_character_amplification_seven_sixtyfourths`](../proofs/classical_burgess_and_kim_sarnak_barrier.lean#L214): Derives amplified bound $(k+3)/(2(k+1)(k+4)) = 7/64$ at $k = 4$ (`5/832` saving).
- [`thm_74_sym_power_langlands_functoriality_limit_to_ramanujan`](../proofs/classical_burgess_and_kim_sarnak_barrier.lean#L235): Proves $0 < \vartheta_k < 1/(2k)$ for finite $k$ and convergence to `0` as $k \to \infty$.
- [`thm_75_case015_five_classical_barriers_unified_synthesis`](../proofs/classical_burgess_and_kim_sarnak_barrier.lean#L254): Master synthesis conjunction uniting all five classical barrier invariants.

---

## 7. Symbolic & Numerical Verification Ledger (`symbolic_verification_result.json`)

| Pillar | `symbolic_verification_result.json` Computed Invariants | Mathematical Verdict |
| :--- | :--- | :--- |
| **Paper 1 Zero-Free** | `0.010000 -> 0.014359353945 -> 0.018811882705` (ceiling `0.057190958418`) | `+88.12%` slack recovery & Fejer-Riesz ceiling sealed |
| **Paper 2 Zero-Density** | `3.02447839` vs `4.53901002`, `30/13`, `215/3264`, `487/3264`, `-17/132` | Schur phase loss, `7/10` shift & `QRH` 3-mode unbundling |
| **Paper 3 Siegel Zeros** | `5/46`, `86713344`, `255983`, `4115904`, `5077` | Landau-Page margin, `Ostmann` cutoff & rank-`3` effectivity |
| **Paper 4 Critical Line** | `0.3635`, `0.408058`, `55264/135375`, `0.528097` | Symmetric degree-`17` optima vs relaxed $\coth$ ceiling |
| **Paper 5 Subconvexity** | `3/16`, `7/36`, `1/6`, `1/48`, `3/26`, `7/64`, `5/832`, `98.005376` | `r = 2` SOS trap, `GL_5` `7/64` & `98.01%` Kloosterman cancellation |
