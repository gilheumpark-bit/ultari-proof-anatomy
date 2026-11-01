# [Tier 2: Intermediate Guide] Core Mathematical Equations & 27 Lean 4 Theorem Index

This guide is designed for STEM students, software engineers, and researchers who want to trace the algebraic equations of Problems 1 through 5 and map them to OpenAI's `#003` reference files (`./proofs/oai_ref/`) and our 27 formal Lean 4 theorems ([`proofs/qrh_exponent_and_parameter_bounds.lean`](../proofs/qrh_exponent_and_parameter_bounds.lean)).

---

## 1. Exponent Balance Relation

In OpenAI `#003`, the zero-free boundary $\beta$ is determined by balancing the square-root Gram matrix scale ($\gamma_{\text{det}} = \frac{3}{16}$) against the principal signal shift ($c_{\text{signal}} = -\frac{11}{16}$):

$$\beta(\alpha_X, \alpha_Y, \ell, \Delta_{\text{Gram}}) = \frac{5}{6} + \frac{\alpha_X + \alpha_Y - 2\ell}{12} - \Delta_{\text{Gram}} = \frac{7}{8} - \Delta_{\text{Gram}}$$

Evaluating at $\Delta_{\text{Gram}} \in \left\{0, \frac{1}{8}, \frac{37}{200}, \frac{73}{200}\right\}$ gives **$\frac{7}{8}(0.875) \to \frac{3}{4}(0.750) \to \frac{69}{100}(0.690) \to \frac{51}{100}(0.510)$** ([`Theorem 18`](../proofs/qrh_exponent_and_parameter_bounds.lean#L234-L250)).

---

## 2. Walkthrough of the 5 Core Mathematical Problems (Problems 1–5)

### Problem 1: Cube Floor Margin Root (`37/72 ≈ 0.513889`)
- **Reference Files**: [`proofs/oai_ref/CentralExponent.lean`](../proofs/oai_ref/CentralExponent.lean), [`proofs/oai_ref/CubeFloorSaving.lean`](../proofs/oai_ref/CubeFloorSaving.lean)
- **Algebraic Formulation**: Parameterizing the floor abscissa as $a_{\text{floor}} = \frac{1}{2} + \eta$ ($q = \eta, R = 1, d = \frac{13}{16}$) reduces the floor margin exponent to a linear function:
  $$B_{\text{floor}}(\eta) = \operatorname{sourceExponent}\left(\frac{1}{2}+\eta, \frac{13}{16}, 1, \eta\right) - \frac{3}{16} = \frac{3}{2}\eta - \frac{1}{48}$$
- **Key Results**:
  - Solving $B_{\text{floor}}(\eta) = 0$ gives $\eta_{\max} = \frac{1}{72}$, or **$a_{\max} = \frac{37}{72} \approx 0.513889$**. Thus the floor parameter must be chosen below $\frac{37}{72}$ (such as $\frac{51}{100} = 0.51$, where the margin is $-\frac{7}{1200}$).
  - Setting $a_{\text{floor}} = \frac{5001}{10000} = 0.5001$ ($\eta = 10^{-4}$) yields $-\frac{1241}{60000}$ (**$3.5457\times$** larger saving than at $0.51$).
- **Formal Proofs**: [`Theorems 8–12`](../proofs/qrh_exponent_and_parameter_bounds.lean#L119-L140)

### Problem 2: Quadratic Irrational Stationary Point vs. Rational SOS Reference Point (`79/204`)
- **Reference File**: [`proofs/oai_ref/Endpoint.lean`](../proofs/oai_ref/Endpoint.lean)
- **Algebraic Formulation**: Along the boundary $y = 0$, the balanced exponent reduces to:
  $$E_{\text{bal}}(\delta, 0) = \frac{1224\delta^2 - 948\delta + 185}{48(138\delta - 185)}$$
  Differentiating with respect to $\delta$ gives the quadratic equation $9384\delta^2 - 25160\delta + 8325 = 0$.
- **Key Results**:
  - **Irrational Stationary Point**:
    $$\delta^*_{\text{true}} = \frac{185}{138} - \frac{35\sqrt{16354}}{4692} \approx 0.3866375622, \quad a^*_{\text{true}} = \frac{1+\delta^*_{\text{true}}}{2} = \frac{323}{276} - \frac{35\sqrt{16354}}{9384} \approx 0.6933187811$$
  - **Rational SOS Reference Point**: To work over `Rat`, OpenAI used the root of $(204\delta - 79)^2 = 0$, namely $\delta_{\text{SOS}} = \frac{79}{204} \approx 0.38725490$ ($a_{\text{SOS}} = \frac{283}{408} \approx 0.69362745$), where $E_{\text{bal}}(\delta_{\text{SOS}}, 0) = -\frac{7}{30672}$ and $\frac{\partial^2 E_{\text{bal}}}{\partial \delta^2}(\delta_{\text{SOS}}, 0) = -\frac{236315300}{608806611} < 0$.
- **Formal Proofs**: [`Theorem 4`](../proofs/qrh_exponent_and_parameter_bounds.lean#L86-L91), [`Theorem 5`](../proofs/qrh_exponent_and_parameter_bounds.lean#L95-L99), [`Theorem 27`](../proofs/qrh_exponent_and_parameter_bounds.lean#L386-L402)

### Problem 3: Componentwise Gram Scale Exponent Differences (`592.35x` / `1341.73x` Margin)
- **Reference Files**: [`proofs/oai_ref/LowSourceScales.lean`](../proofs/oai_ref/LowSourceScales.lean), [`proofs/oai_ref/GramScaleLoss.lean`](../proofs/oai_ref/GramScaleLoss.lean), [`proofs/oai_ref/GramBound.lean`](../proofs/oai_ref/GramBound.lean), [`proofs/oai_ref/LowGramScale.lean`](../proofs/oai_ref/LowGramScale.lean)
- **Algebraic Formulation**: In `GramBound.lean`, the individual terms have square-root $Z$-exponents $\frac{17}{96}$ (zero mode), $\frac{6+17\delta}{96}$ (or $\frac{14+17\delta}{96}$ with $L \le Z^{1/6}$), and $\frac{18}{96}$ (cubic Gauss exceptional mode), compared to the bundled upper bound $\frac{18+23\delta}{96}$ in `LowGramScale.lean`.
- **Key Results**: At $\delta_{\text{SOS}} = \frac{79}{204}$, the exponent difference is $\frac{1817}{19584} \approx 0.09278$ on the exceptional term and **$\frac{215}{3264} \approx 0.06587$** (with $L \le Z^{1/6}$) or **$\frac{487}{3264} \approx 0.14920$** (at $L=1$) on the non-exceptional term—exceeding the baseline SOS margin $\frac{49}{440640}$ by **$\frac{29025}{49} \approx 592.35\times$** (or **$\frac{65745}{49} \approx 1341.73\times$** at $L=1$).
- **Formal Proof**: [`Theorem 24`](../proofs/qrh_exponent_and_parameter_bounds.lean#L342-L358)

### Problem 4: $m \ge 2$ Gauss-Sum Branch Vanishing (`6 of 8` Branches) & $z_{\text{re}} \ge \frac{1}{12}$ Bound
- **Reference Files**: [`proofs/oai_ref/HighRowsTail.lean`](../proofs/oai_ref/HighRowsTail.lean), [`proofs/oai_ref/HighRowsScalar.lean`](../proofs/oai_ref/HighRowsScalar.lean), [`proofs/oai_ref/ScalarTable.lean`](../proofs/oai_ref/ScalarTable.lean), [`proofs/oai_ref/HighRowsCentralTerms.lean`](../proofs/oai_ref/HighRowsCentralTerms.lean)
- **Key Results**: For all $m \ge 2$, `gaussValuationTable_above` forces **6 of the 8** non-principal $(e, l, k)$ branches to vanish identically. The two surviving branches (`02_0` and `10_1`) require only $12z_{\text{re}} \ge 1 \iff \mathbf{z_{\text{re}} \ge \frac{1}{12}}$, relaxing the $m=1$ condition $z_{\text{re}} \ge \frac{1}{6}$ by half.
- **Formal Proofs**: [`Theorems 20–23`](../proofs/qrh_exponent_and_parameter_bounds.lean#L273-L337)

### Problem 5: Principal Remainder $(w, z)$ Contour Shift Budget (`17/48000`)
- **Reference Files**: [`proofs/oai_ref/PrincipalRemainderBounds.lean`](../proofs/oai_ref/PrincipalRemainderBounds.lean), [`proofs/oai_ref/ParametersHighData.lean`](../proofs/oai_ref/ParametersHighData.lean)
- **Key Results**: Shifting the $z$-contour across the sextic zeta pole $z = \frac{1}{6}$ to $z = \frac{33}{200}$ at $e_{\max} = \frac{1}{1000}$ yields $w$-saving $\frac{1063}{48000}$ and $z$-saving $\frac{13}{16}\left(\frac{1}{6} - \frac{33}{200}\right) - \frac{1}{1000} = \mathbf{\frac{17}{48000}}$, matching `principal_budget = 17/48000` in `ParametersHighData.lean:45`.
- **Formal Proof**: [`Theorem 19`](../proofs/qrh_exponent_and_parameter_bounds.lean#L258-L268)

---

## 3. Complete Index of All 27 Lean 4 Theorems ([`proofs/qrh_exponent_and_parameter_bounds.lean`](../proofs/qrh_exponent_and_parameter_bounds.lean))

| Theorem # | Line | Theorem Identifier | Tactic | Mathematical Statement |
| :---: | :---: | :--- | :---: | :--- |
| **Theorem 1** | `L64` | [`coordR_exponent_at_z_034`](../proofs/qrh_exponent_and_parameter_bounds.lean#L64-L65) | `decide +kernel` | At $z=0.34, x=0.51$, `coordR` exponent $= -11/10$ |
| **Theorem 2** | `L69` | [`coordR_squared_exponent_at_z_024`](../proofs/qrh_exponent_and_parameter_bounds.lean#L69-L72) | `decide +kernel` | At $z=0.24$, quadratic `R^2` exponent $= -149/125 < -1$ |
| **Theorem 3** | `L76` | [`gauss_branch_exponent_at_z_017`](../proofs/qrh_exponent_and_parameter_bounds.lean#L76-L78) | `decide +kernel` | At $z=0.17$, Gauss branch exponent $= -2/25 \le -1/100$ |
| **Theorem 4** | `L86` | [`rational_sos_reference_abscissa`](../proofs/qrh_exponent_and_parameter_bounds.lean#L86-L91) | `decide +kernel` | Rational SOS reference point $\delta = 79/204 \implies a = 283/408 \in (0.69, 0.694)$ |
| **Theorem 5** | `L95` | [`exact_sos_identity_and_margin_at_79_204`](../proofs/qrh_exponent_and_parameter_bounds.lean#L95-L99) | `decide +kernel` | SOS identity ($147 = 147$) and margin $7/30672 > 49/440640$ |
| **Theorem 6** | `L102` | [`sos_polynomial_identity_sample_points`](../proofs/qrh_exponent_and_parameter_bounds.lean#L102-L106) | `decide +kernel` | 2D rational sample-point verification of SOS identity |
| **Theorem 7** | `L109` | [`certified_exponent_margins_by_beta`](../proofs/qrh_exponent_and_parameter_bounds.lean#L109-L112) | `decide +kernel` | Certified SOS margins across $\beta \in \{7/8, 5/6, 3/4, 69/100\}$ |
| **Theorem 8** | `L119` | [`floor_source_margin_at_051`](../proofs/qrh_exponent_and_parameter_bounds.lean#L119-L120) | `decide +kernel` | Floor margin at $a_{\text{floor}} = 0.51$ is $-7/1200$ |
| **Theorem 9** | `L123` | [`floor_source_margin_at_0505`](../proofs/qrh_exponent_and_parameter_bounds.lean#L123-L124) | `decide +kernel` | Floor margin at $a_{\text{floor}} = 0.505$ is $-1/75$ |
| **Theorem 10** | `L127` | [`floor_source_margin_at_0501`](../proofs/qrh_exponent_and_parameter_bounds.lean#L127-L128) | `decide +kernel` | Floor margin at $a_{\text{floor}} = 0.501$ is $-29/1500$ |
| **Theorem 11** | `L132` | [`floor_source_margin_at_05001`](../proofs/qrh_exponent_and_parameter_bounds.lean#L132-L134) | `decide +kernel` | Floor margin at $a_{\text{floor}} = 0.5001$ is $-1241/60000$ ($>3\times$ stronger) |
| **Theorem 12** | `L138` | [`floor_source_margin_root_37_72`](../proofs/qrh_exponent_and_parameter_bounds.lean#L138-L139) | `decide +kernel` | Floor margin root $a_{\max} = 37/72$ ($\eta_{\max} = 1/72$) |
| **Theorem 13** | `L150` | [`nonstrict_gauss_branches_at_05001_and_017`](../proofs/qrh_exponent_and_parameter_bounds.lean#L150-L163) | `decide +kernel` | Convergence of all 9 non-strict Gauss branches at $z=0.17, x=0.5001$ |
| **Theorem 14** | `L167` | [`parameter_budget_inequality_at_05001`](../proofs/qrh_exponent_and_parameter_bounds.lean#L167-L183) | `decide +kernel` | 17-parameter budget inequality at $a_{\text{floor}} = 0.5001$ |
| **Theorem 15** | `L191` | [`siegel_zeros_constants_ratio_identity`](../proofs/qrh_exponent_and_parameter_bounds.lean#L191-L197) | `decide +kernel` | `SiegelZeros` constant ratio $(C_1/c_1)/H = 1/12$ |
| **Theorem 16** | `L200` | [`complementary_zero_free_widths`](../proofs/qrh_exponent_and_parameter_bounds.lean#L200-L210) | `decide +kernel` | Complementary widths $1 - \beta$ for $\beta \in \{7/8, 3/4, 69/100\}$ |
| **Theorem 17** | `L214` | [`functional_equation_reflection_and_quotient_thresholds`](../proofs/qrh_exponent_and_parameter_bounds.lean#L214-L224) | `decide +kernel` | Reflection symmetry (`0.49 <-> 0.51`) & quotient ratios at $Q=480, 112$ |
| **Theorem 18** | `L234` | [`exponent_balance_relation_identity`](../proofs/qrh_exponent_and_parameter_bounds.lean#L234-L250) | `decide +kernel` | Exponent balance relation $\beta = 7/8 - \Delta_{\text{Gram}}$ |
| **Theorem 19** | `L258` | [`convergence_boundary_at_one_sixth`](../proofs/qrh_exponent_and_parameter_bounds.lean#L258-L268) | `decide +kernel` | Boundary at $z_{\text{re}} = 1/6$ and `principal_budget = 17/48000` |
| **Theorem 20** | `L273` | [`tail_m_ge_2_exponent_margins`](../proofs/qrh_exponent_and_parameter_bounds.lean#L273-L294) | `decide +kernel` | $m \ge 2$ tail exponent margins ($z_{\text{re}} \ge 1/12$) |
| **Theorem 21** | `L302` | [`gauss_valuation_table_indices_m_ge_2`](../proofs/qrh_exponent_and_parameter_bounds.lean#L302-L310) | `revert; omega` | Valuation table index bounds for $\forall j<6, n\le 5, m \ge 2$ |
| **Theorem 22** | `L315` | [`gauss_sum_linear_exponent_bounds_m1_m2`](../proofs/qrh_exponent_and_parameter_bounds.lean#L315-L329) | `revert; omega` | Linear Gauss exponent bounds over $\forall a_{\text{bp}} \in [5001, 10000], m_1\ge 1, m_2\ge 2$ |
| **Theorem 23** | `L332` | [`general_order_m_tail_exponent_bound`](../proofs/qrh_exponent_and_parameter_bounds.lean#L332-L337) | `revert; omega` | General order-$M$ tail bound $z_{\text{re}} \ge 1/(6M)$ for $\forall M \ge 1, m \ge M$ |
| **Theorem 24** | `L342` | [`componentwise_gram_exponent_differences`](../proofs/qrh_exponent_and_parameter_bounds.lean#L342-L358) | `decide +kernel` | Componentwise Gram exponent differences ($\frac{215}{3264}$, `592.35x` baseline margin) |
| **Theorem 25** | `L362` | [`sos_certificate_weight_linear_bound`](../proofs/qrh_exponent_and_parameter_bounds.lean#L362-L369) | `revert; omega` | SOS weight linear inequality for $\forall y \ge 0, D > 0$ |
| **Theorem 26** | `L372` | [`zero_free_region_union_and_symmetry`](../proofs/qrh_exponent_and_parameter_bounds.lean#L372-L380) | `revert; omega` | Zero-free region union and functional-equation symmetry bounds |
| **Theorem 27** | `L386` | [`stationary_point_quadratic_root_323_276_identity`](../proofs/qrh_exponent_and_parameter_bounds.lean#L386-L402) | `decide +kernel` | Quadratic stationary point $a^* = \frac{323}{276} - \frac{35\sqrt{16354}}{9384}$ & negative second derivative |

---

## 4. Extended Theorems Index for Tasks 1–3 (`Theorems 28–40`, [`proofs/qrh_continuation_and_rescaling.lean`](../proofs/qrh_continuation_and_rescaling.lean))

| Theorem # | Line | Theorem Identifier | Tactic | Mathematical Statement |
| :---: | :---: | :--- | :---: | :--- |
| **Theorem 28** | `L66` | [`theorem_28_marked_factor_singularity_cancels_identically`](../proofs/qrh_continuation_and_rescaling.lean#L66-L77) | `simp; omega` / `decide` | Universal $\forall (R,V,q_{\text{inv}},K,W,D \in \mathbb{Z})$ cancellation of $(1-V)$ in `markedFactor` and threshold drop $480 \to 112$ |
| **Theorem 29** | `L84` | [`theorem_29_all_small_eisenstein_norms_nonvanishing`](../proofs/qrh_continuation_and_rescaling.lean#L84-L91) | `decide +kernel` | Non-vanishing of Euler denominators across all 21 small Eisenstein prime-power norms in $4 \le Q < 112$ |
| **Theorem 30** | `L96` | [`theorem_30_universal_finite_bad_prime_mask_absorption`](../proofs/qrh_continuation_and_rescaling.lean#L96-L100) | `revert; omega` | Universal $\forall Q, N_{\text{cut}} \ge 480$ finite bad-prime mask (`smallPrimeSet`) absorption law |
| **Theorem 31** | `L109` | [`theorem_31_second_continuation_exact_polynomial_identity`](../proofs/qrh_continuation_and_rescaling.lean#L109-L113) | `simp; omega` | Universal $\forall (R,V,q_{\text{inv}},K,W,D \in \mathbb{Z})$ 5-term cancellation identity in `secondContinuedCorrection` |
| **Theorem 32** | `L122` | [`theorem_32_second_and_third_continuation_convergence_barrier`](../proofs/qrh_continuation_and_rescaling.lean#L122-L141) | `decide +kernel` | Euler-tail convergence barrier reduction $97/300 \to 97/600 < 1/6$ (`-(53/50) = -1.06 < -1` at $z = 1/6$) |
| **Theorem 33** | `L148` | [`theorem_33_central_exponent_z0_invariance_at_d0`](../proofs/qrh_continuation_and_rescaling.lean#L148-L163) | `decide +kernel` | Exact $z_0$-invariance of `sourceExponent` at $d_0 = 13/16$ (coefficient $0$) and $16.92\times$ saving at $d = 1/2$ |
| **Theorem 34** | `L169` | [`theorem_34_universal_z0_shift_improves_subcritical_d`](../proofs/qrh_continuation_and_rescaling.lean#L169-L179) | `omega` | Universal $\forall d < d_0, z_{\text{new}} < z_{\text{old}}$ strict improvement of `sourceExponent` |
| **Theorem 35** | `L189` | [`theorem_35_master_scale_coupling_identities`](../proofs/qrh_continuation_and_rescaling.lean#L189-L203) | `decide +kernel` | Master scale-coupling equations for `-11/16`, `3/16`, and $\beta_{\text{crit}} = 5/6 + (\alpha_X + \alpha_Y - 2\ell)/12$ |
| **Theorem 36** | `L212` | [`theorem_36_regime_A_sos_slack_rescaling_and_conductor_split`](../proofs/qrh_continuation_and_rescaling.lean#L212-L232) | `decide +kernel` | Regime A: $\beta_{\text{crit}} = 128519/146880 < 7/8$ on active `LowSourceScales.lean` path vs. $7/8$ split invariance |
| **Theorem 37** | `L239` | [`theorem_37_regime_B_gram_unbundled_and_diagonal_beta_bounds`](../proofs/qrh_continuation_and_rescaling.lean#L239-L252) | `decide +kernel` | Regime B: $\beta_{\text{crit}} = 5/6, 3/4, 69/100$ under unbundled Gram saving (`215/3264`) and diagonal dominance |
| **Theorem 38** | `L258` | [`theorem_38_universal_beta_crit_monotonicity`](../proofs/qrh_continuation_and_rescaling.lean#L258-L268) | `revert; omega` | Universal $\forall \eta > 0$ strict monotonicity of $\beta_{\text{crit}}$ preserving Poisson admissibility |
| **Theorem 39** | `L274` | [`theorem_39_m1_sextic_pole_residue_and_33_200_remainder_saving`](../proofs/qrh_continuation_and_rescaling.lean#L274-L284) | `decide +kernel` | Exact $z = 1/6$ sextic Gauss pole-shift remainder savings (`-13/9600`, `-17/48000`) at $z_{\text{re}} = 33/200$ |
| **Theorem 40** | `L289` | [`theorem_40_energy_induction_compatible_below_seven_eighths`](../proofs/qrh_continuation_and_rescaling.lean#L289-L298) | `decide +kernel` | Full compatibility of `Energy/CertifiedExistence.lean` across all $\beta \in [51/100, 7/8]$ |
