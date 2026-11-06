# [Tier 1: Beginner Guide] What Mathematicians and Referees Look For in OpenAI `#003`

Checking that a Lean 4 file compiles without syntax errors is only the first step. When an analytic number theorist audits OpenAI `#003` (*Quasi-Riemann Hypothesis at $\beta = 7/8$ and Siegel Zero Exclusion*), five deeper questions arise. This guide explains those five questions and the conditional blueprint toward $\beta = 1/2$ in plain language.

---

## 1. Where Did the Hardcoded Constants Come From?

Opening [`DirichletL/Parameters.lean:6-10`](../proofs/oai_ref/Parameters.lean#L6-L10) reveals three unexplained fractions: $\alpha_X = 17/48$, $\alpha_Y = 23/48$, and $\ell = 1/6$.
Reverse-engineering the proof shows that they are the unique solution to a $3 \times 3$ linear system ([`thm_01_magic_exponents_unique_3x3_system`](../proofs/qrh_mathematician_referee_audit.lean#L16-L23)):
1. **Contour Anchor ($\ell = 1/6 = 8/48$)**: Places the main Mellin contour at $\mathrm{Re}(z) = 1/6$.
2. **Square-Full Shift ($\alpha_X - \ell = 3/16 = 9/48$)**: Forces $\alpha_X = 8/48 + 9/48 = 17/48$.
3. **Cubic Gauss $L^2$-Saving ($(5\alpha_X + \alpha_Y)/12 = 3/16$)**: Forces $\alpha_Y = 23/48$.

Similarly, in [`SiegelZeros/Estimates/GeometricBoundary.lean:26`](../proofs/oai_ref/GeometricBoundary.lean#L26) and [`SiegelZeros/Selection/PivotBounds.lean:63-65`](../proofs/oai_ref/PivotBounds.lean#L63-L65), the integer constants $H = 86,713,344$ and $N_0 = 18,818$ come from the floor bound $\lfloor 96t \rfloor + 1 \le 97t$ ([`thm_21_siegel_zero_magic_constants_86713344_and_18818`](../proofs/qrh_mathematician_referee_audit.lean#L257-L265)). Since $97^2 = 9,409$, the code sets $N_0 = 2 \times 97^2 = 18,818$ and $H = 12 \times 192 \times 37,636 = 86,713,344$.

---

## 2. How Much Margin Was Wasted for Coding Convenience?

1. **Three-Tier Tail Exponent Losses (`181/3264`, `215/3264`, `487/3264`)**:
   - To make `nlinarith` proofs shorter, [`DirichletL/Detector/LowSourceScales.lean:88-98`](../proofs/oai_ref/LowSourceScales.lean#L88-L98) bounds a constant $B$ by $Z^{1/16}$, losing $1/32 = 102/3264$.
   - Next, [`DirichletL/Detector/GramScaleLoss.lean:29`](../proofs/oai_ref/GramScaleLoss.lean#L29) drops $P^{-\delta}$, losing $79/3264$ at the SOS point $\delta_{\mathrm{SOS}} = 79/204$.
   - Combining these with the $1/96$ bundling loss gives a 3-term slack of $215/3264 \approx 0.0659$ ([`thm_04_gram_relaxation_three_tier_exponent_losses`](../proofs/qrh_mathematician_referee_audit.lean#L53-L61)), and adding the $1/12$ divisor bound gives $487/3264 \approx 0.1492$.
2. **Bounding Before Cancelling (`Q >= 480` vs. `Q >= 128`)**:
   - In [`DirichletL/Detector/Local.lean:16-24`](../proofs/oai_ref/Local.lean#L16-L24), the factor $(1-V)$ cancels identically as a polynomial ([`thm_07_marked_factor_one_minus_V_polynomial_cancellation`](../proofs/qrh_mathematician_referee_audit.lean#L96-L103)).
   - Because [`DirichletL/Detector/CorrectionBounds.lean:26, 58`](../proofs/oai_ref/CorrectionBounds.lean#L26) applies the triangle inequality before cancelling $(1-V)$, the prime-norm cutoff is inflated from $Q \ge 128$ to $Q \ge 480$, wasting 30 prime-ideal norms ([`thm_08_correction_bounds_unreduced_480_vs_reduced_128`](../proofs/qrh_mathematician_referee_audit.lean#L107-L116)).
3. **Bézout-to-Siegel-Zero Discharge Chain**:
   - The `hgeometry` premise in [`SiegelZeros/Estimates/GeometricBoundary.lean:18-22`](../proofs/oai_ref/GeometricBoundary.lean#L18-L22) is discharged across [`SiegelZeros/Intersection/IsolatedBezoutFromRegularSelection.lean:346-366`](../proofs/oai_ref/IsolatedBezoutFromRegularSelection.lean#L346-L366), [`SiegelZeros/Structure/ArithmeticCutoffTransport.lean:488-515`](../proofs/oai_ref/ArithmeticCutoffTransport.lean#L488-L515), [`SiegelZeros/Intersection/BezoutBoundary.lean:13-20`](../proofs/oai_ref/BezoutBoundary.lean#L13-L20), and [`SiegelZeros/Conclusions/Theorem.lean:11-20`](../proofs/oai_ref/Theorem.lean#L11-L20) ([`thm_23_siegel_zero_conditional_hgeometry_vs_cubic_independence`](../proofs/qrh_mathematician_referee_audit.lean#L278-L284)).

---

## 3. Why Did the Proof Stop at $\beta = 7/8$, and How Do the Edge Cases Work?

1. **Double Contour Shift**: On the $w = 1$ residue, keeping $\mathrm{Re}(z) = 1/6$ would cross a pole, so the contour shifts left to $\mathrm{Re}(z) = 33/200 < 1/6$, clearing the pole by $29/1200 > 0$ ([`thm_14_double_contour_w_and_z_residue_separation_budget`](../proofs/qrh_mathematician_referee_audit.lean#L178-L186)).
2. **Gram Savings Below $7/8$**: Lowering $\beta$ to $5/6$, $3/4$, or $69/100$ requires off-diagonal cubic Gauss Gram savings of $\Delta_{\mathrm{gram}} = 1/16$, $3/16$, and $111/400$ ([`thm_16_bilinear_gram_cancellation_thresholds_5_6_and_3_4`](../proofs/qrh_mathematician_referee_audit.lean#L199-L206)).
3. **Bad Primes $Q = 3, 4$**: `badPrimeMask` removes $p \mid 6$ so all remaining prime powers $Q \ge 7$ satisfy $Q \equiv 1 \pmod 6$ ([`thm_19_eisenstein_sextic_symbol_requires_Q_ge_7_mod_6_eq_1`](../proofs/qrh_mathematician_referee_audit.lean#L236-L242)).
4. **Quadratic vs. Cubic Characters**: Siegel zeros only occur for real quadratic characters, handled via biquadratic Klein 4-group torus jets ([`thm_22_biquadratic_klein4_torus_jet_exponent_gap`](../proofs/qrh_mathematician_referee_audit.lean#L268-L274)).

---

## 4. Conditional Transfer Blueprint Toward $\beta = 1/2$ (`Category A`)

We separate the unconditional structural advances from the conditional analytic inputs needed to reach the critical line $\beta = 1/2$:

| Regime / Component | Exact Value | Mathematical Status |
| :--- | :---: | :--- |
| **1. Global SOS Saddle $\beta_{\mathrm{SOS}}(0)$** | **$\frac{6843 - 7\sqrt{921}}{7578} \approx 0.874975$** | Unconditional global bound across all $(\delta, y) \in [0, 5/6]\times[0, 1/2]$ (rational witness $\frac{41999}{48000} < \frac{7}{8}$, [`thm_32`](../proofs/qrh_mathematician_referee_audit.lean#L412-L423), [`thm_33`](../proofs/qrh_mathematician_referee_audit.lean#L431-L441)). |
| **2. Local $\delta=0$ Slice Equilibria** | **$\frac{131}{150} \approx 0.8733$ / $\frac{209}{240} \approx 0.8708$** | Local boundary equilibria in [`DirichletL/Detector/CentralExponent.lean:15-81`](../proofs/oai_ref/CentralExponent.lean#L15-L81) and [`DirichletL/Detector/GramBound.lean:56`](../proofs/oai_ref/GramBound.lean#L56) ([`thm_27`](../proofs/qrh_mathematician_referee_audit.lean#L356-L364), [`thm_28`](../proofs/qrh_mathematician_referee_audit.lean#L368-L375), [`thm_34`](../proofs/qrh_mathematician_referee_audit.lean#L444-L451)). |
| **3. Unbundled Tail Floor $\beta_{\mathrm{floor}}$** | **$\frac{4103}{4896} \approx 0.8380$ ($\frac{4069}{4896}$)** | Isolated non-exceptional tail floor after zero-mode subtraction and `thm_04` unbundling. |
| **4. `coordR` Stickelberger Pole Shift** | **$\frac{2}{3} \to \frac{7}{12} \to \frac{1}{2}$** | Factoring out $\psi_{\mathrm{Stick}}\eta^6$ ($k_\infty = -6 \neq 0$) in [`DirichletL/Detector/EulerCoordinates.lean:36`](../proofs/oai_ref/EulerCoordinates.lean#L36) removes the pole at $2/3$ ([`thm_29`](../proofs/qrh_mathematician_referee_audit.lean#L379-L385), [`thm_30`](../proofs/qrh_mathematician_referee_audit.lean#L388-L396)). |
| **5. `HighRows` Cauchy Box (`Path B`)** | **$[0.48, 0.52]$ Open** | Shifting $z_{\mathrm{high}} = 7/20$ in [`DirichletL/Detector/HighRowsCentralTerms.lean:38-114`](../proofs/oai_ref/HighRowsCentralTerms.lean#L38-L114) opens all 9 high-row branches down to $0.48 < 1/2$ ([`thm_31`](../proofs/qrh_mathematician_referee_audit.lean#L400-L408), [`thm_42`](../proofs/qrh_eight_tasks_critical_upgrade.lean#L77-L90)). |
| **6. Conditional Hybrid Saving for $\beta = 1/2$** | **$\Delta_{\mathrm{hybrid}} = \frac{14}{33}$** | Required saving threshold inversion (`beta132 = 66` $\implies$ `d_hyb132 = 56`) at $(35/66, 59/66, 7/11, 7/20)$ ([`thm_35`](../proofs/qrh_mathematician_referee_audit.lean#L454-L461) to [`thm_38`](../proofs/qrh_mathematician_referee_audit.lean#L486-L497)). |
| **7. 8-Task Upgrade & Single-$\zeta(s)$ Bridge** | **$\mathrm{gain}_{\mathrm{amp}} \ge \frac{2}{11}$** | Stage 1 refactors 5 modules ([`thm_39`](../proofs/qrh_eight_tasks_critical_upgrade.lean#L21-L31) to [`thm_43`](../proofs/qrh_eight_tasks_critical_upgrade.lean#L97-L109)), while Stage 2 proves the conditional Voronoi/single-$\zeta(s)$ thresholds ([`thm_44`](../proofs/qrh_eight_tasks_critical_upgrade.lean#L122-L134) to [`thm_46`](../proofs/qrh_eight_tasks_critical_upgrade.lean#L156-L171)). |
