# [Case 010 / Tier 2 Intermediate Math & Code Guide] OpenAI `#017`: Weighted Laurent Determinants, Seshadri Blowup, and 30-Theorem Mapping

> **Target Audience**: Advanced undergraduates, graduate students in mathematics and computer science, and formal verification engineers
> **Parent Index**: [English Main README (`README.md`)](../README.md) | [Executive Summary (`en/01_`)](01_Executive_Summary_and_General_Guide.md) | [Expert Forensic Report (`en/03_`)](03_Expert_Forensic_and_Mathematical_Physics_Report.md) | [Parser Spec (`en/04_`)](04_Automated_Verification_and_Parser_Spec.md)

---

## 1. End-to-End Proof Pipeline (`Sections 2–5` $\leftrightarrow$ `OAI/NumberTheory/PiExponent/`)

OpenAI `#017` proceeds by contradiction: assuming $\mu(\pi) > 2$, there exists $\nu > 2$ with infinitely many reduced rationals $p/q$ satisfying $|\pi - p/q| \le (2q)^{-\nu}$. Selecting a high dimension $m$ and $K = \lfloor C^m \rfloor$ distinct approximation centers, the proof pits an **algebraic-geometric upper bound on weighted zero multiplicities (`Section 2`)** against a **Laurent determinant lower bound (`Section 3`)**.

```mermaid
flowchart TD
    A["Contradiction Hypothesis: infinitely many p/q with |π - p/q| ≤ (2q)^(-ν) for ν > 2"] --> B["Section 4 (Lemma 4.1, Parameters.lean):<br/>Choose b ∈ (1/2, 1-1/ν), θ = 1-δ, A = 1-bδ, B, C"]
    B --> C["Section 3 (Proposition 3.4, DeterminantContradiction.lean):<br/>Form M × M weighted Laurent determinant Δ (|Δ| ≥ 1 in Z[i])"]
    C --> D["Alternative 1 (Insufficient Taylor collisions):<br/>log|Δ|/(M w_*) ≤ E_an - θ(v_0/w_*) < -E_ar (Contradiction)"]
    C --> E["Alternative 2 (Concentrated Taylor collisions):<br/>Σ_{u=1}^K h_{P_u} ≥ c·L - E_ar - E_an > 1"]
    E --> F["Section 2 (Theorem 2.1, WeightSeparation.lean):<br/>Seshadri-Kodaira blowup forces Σ_{u=1}^K h_{P_u} < 1 (Contradiction!)"]
    F --> G["Conclusion (Theorem 1.1, Main.lean):<br/>μ(π) = 2"]
    G --> H["Section 5 (Lemma 5.1, FlintConsequence.lean):<br/>Dyadic Abel summation proves Flint-Hills convergence"]
```

---

## 2. Mathematical Architecture of Sections 2–5 and Lean 4 Code Mapping

### 2.1 `Section 2` (`interpolation.tex` $\leftrightarrow$ `Geometry/`, `LocalAlgebra/`, `Cohomology/`, `Ampleness/`, `Jets/`)
- **Ambient Variety and Weighted Derivations**: On $X = (\mathbb{P}^1)^m \times \mathbb{P}^1$, the proof uses logarithmic derivations $\partial_i = X_i \partial_{X_i}$ ($1 \le i \le m$) and $\partial_0 = Y \partial_Y$, measuring the vanishing of a multihomogeneous section $F \in H^0(X, \mathcal{O}_X(D))$ at centers $P \in \Sigma$ across all monomials with $\sum_{i=1}^m \kappa_i \alpha_i + \lambda \beta < h_P N$ ([`interpolation.tex`](../proofs/oai_ref/tex/sections/interpolation.tex#L18-L89), [`TransverseMultiplicity.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/PiExponent/Jets/TransverseMultiplicity.lean#L1-L120)).
- **Lacunary Weight Separation (`Eq. (2.17)`)**: Enforcing
  $$\kappa_1 \ge C_* \kappa_2, \quad \dots, \quad \kappa_{m-1} \ge C_* \kappa_m, \quad \kappa_m \ge C_* \lambda$$
  forces the derivative vanishing chain $Z = V_0 \supseteq V_1 \supseteq \cdots \supseteq V_{L_0}$ ($L_0 = m+2$) to stabilize at some step $d_r = d_{r+1} \ge 1$, where invariance under $\partial_i - \partial_0$ implies $\frac{dX_i}{X_i} = \frac{dY}{Y}$ on a curve normalization $\widetilde{C}$, contradicting pole-order conservation at $X_i = \infty$ ([`thm_14_pigeonhole_stabilization_of_derivative_vanishing_locus`](../proofs/pi_transverse_multiplicity_and_seshadri_blowup.lean#L81-L91), [`thm_15_gauss_bonnet_logarithmic_residue_rigidity`](../proofs/pi_transverse_multiplicity_and_seshadri_blowup.lean#L98-L105)).
- **Transverse Bézout (`Proposition 2.3`) and Seshadri-Kodaira Blowup (`Steps 4–6`)**: Curve-clustered subsets $\Sigma \setminus Z_0$ contribute at most $\frac{m+1}{1+\sigma}$ across $m+1$ dimension drops ([`thm_16_bouts_lemma_transverse_w_degree_lower_bound`](../proofs/pi_transverse_multiplicity_and_seshadri_blowup.lean#L113-L120), [`thm_17_curve_exclusion_when_sum_h_p_exceeds_one_over_one_plus_sigma`](../proofs/pi_transverse_multiplicity_and_seshadri_blowup.lean#L126-L138)). Blowing up the remaining isolated points $Z_0$ via $\pi : \widetilde{X} \to X$ and decomposing $L_N = K_{\widetilde{X}} + M_N + A + \dots$ yields $H^1(\widetilde{X}, L_N) = 0$ by Kodaira vanishing and $(M_N^{m+1}) \ge 0$ by nefness, establishing
  $$\sum_{P \in \Sigma} h_P < \frac{m+2}{1-\sigma} + \frac{(m+1)!}{(1-\sigma)^{m+1} \gamma^m} \lambda \prod_{i=1}^m \kappa_i$$
  ([`thm_18_lazarsfeld_nef_plus_ample_bundle_decomposition`](../proofs/pi_transverse_multiplicity_and_seshadri_blowup.lean#L149-L159), [`thm_19_top_self_intersection_volume_deficit_and_kodaira_contradiction`](../proofs/pi_transverse_multiplicity_and_seshadri_blowup.lean#L167-L174), [`thm_20_reverse_holder_sum_from_l_m_plus_1_bound_to_l1_sum`](../proofs/pi_transverse_multiplicity_and_seshadri_blowup.lean#L181-L188)).

### 2.2 `Section 3` (`determinant.tex` $\leftrightarrow$ `Polynomials/`, `Approximation/`, `Analysis/`)
- **Weighted Simplex Index Set $\mathcal{A}$ and Determinant $\Delta$**:
  $$\mathcal{A} := \left\{(b_1, \dots, b_m, j) \in \mathbb{Z}_{\ge 0}^m \times \{0, \dots, K-1\} : \sum_{i=1}^m w_i b_i + H j < v_0\right\}, \qquad M := |\mathcal{A}|,$$
  forming the $M \times M$ evaluation matrix $\Delta = \det(L_{u,a})$ at centers $r_{u,i} = 2\pi i p_{u,i}/q_{u,i}$ ([`determinant.tex`](../proofs/oai_ref/tex/sections/determinant.tex#L12-L118), [`SimplexCounting.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/PiExponent/Polynomials/SimplexCounting.lean#L1-L120)).
- **Arithmetic Lower Bound (`Lemma 3.1`) and Row Translation (`Lemma 3.2`)**:
  - Clearing denominators by $\prod_{i=1}^m q_{u,i}^{v_i} d_{v_i}$ ($d_n = \operatorname{lcm}(1, \dots, n)$) places the scaled determinant in $\mathbb{Z}[i] \setminus \{0\}$, giving $\log|\Delta| \ge -M w_* E_{\text{ar}}$ ([`thm_21_gaussian_integer_clearing_and_liouville_obstruction`](../proofs/pi_laurent_determinant_and_flint_hills.lean#L22-L51), [`thm_22_elementary_dyadic_lcm_bound_four_log_two`](../proofs/pi_laurent_determinant_and_flint_hills.lean#L58-L69)).
  - Using $e^{j_a \omega} = e^{2\pi i j_a} = 1$, unit upper-triangular row operations replace the centered basis $A_a$ by the origin monomial basis $P_a$ without changing $\Delta$ ([`thm_23_row_translation_invariance_via_euler_period`](../proofs/pi_laurent_determinant_and_flint_hills.lean#L77-L86)).
- **Cauchy-Schwarz Collision (`Lemma 3.3`) and Two-Alternative Contradiction (`Proposition 3.4`)**:
  - Cauchy-Schwarz across homogenized Taylor degree shells forces $\sum_{a \in \mathcal{B}} n_a^2 \ge \frac{(\eta M)^2}{D_{\mathcal{A}}(H)}$ ([`thm_24_cauchy_schwarz_taylor_collision_degree_lower_bound`](../proofs/pi_laurent_determinant_and_flint_hills.lean#L93-L107)), which in turn forces $\sum_{u=1}^K h_u \ge c \cdot L - E_{\text{ar}} - E_{\text{an}}$ ([`thm_25_two_alternative_determinant_upper_bound_and_contradiction`](../proofs/pi_laurent_determinant_and_flint_hills.lean#L114-L124)).

### 2.3 `Section 4` & `Section 5` (`conclusion.tex`, `series.tex` $\leftrightarrow$ `Approximation/`, `Analysis/`)
- **Why the $b \in (1/2, 1-1/\nu)$ Barrier Is Necessary (`Why 1`–`Why 5` Coupled Derivation)**:
  - **[Why 1 (Barrier)]**: For the rational approximation saving to beat the Cauchy-Schwarz collision exponent, $\nu(A-\theta)-(1-\theta) = (\nu(1-b)-1)\delta > 0$ is required, creating the upper barrier $b < 1-1/\nu$.
  - **[Why 2 (Mechanism & Necessity)]**: Simultaneously, the existence of the projection scale $C \in (A/\theta, 1/A)$ requires $\theta - A^2 = \delta((2b-1) - b^2\delta) > 0$, because $b > 1/2$ is the sole reason the linear $\delta$ term is positive. Together these necessitate $1/2 < 1-1/\nu \iff \nu > 2$.
  - **[Why 3 (Derivation of Row Translation)]**: Because Euler's period $e^{2\pi i j} = 1$ eliminates the center index from the exponential factor, the Taylor shift acts as a unit upper-triangular operator with $\det(P) = \det(A)$.
- **Parameter Selection and Error Budget Splitting (`Section 4`, [`conclusion.tex`](../proofs/oai_ref/tex/sections/conclusion.tex#L12-L155), [`Parameters.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/PiExponent/Approximation/Parameters.lean#L14-L148), [`AdmissibleParameters.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/PiExponent/Approximation/AdmissibleParameters.lean#L1-L120))**: Choosing $b \in (1/2, 1-1/\nu)$ makes $c \cdot L > 2$ for large $m$, while splitting $\varepsilon_0 = \min(g/2, 1/2)$ into three budgets ($< \varepsilon_0/3$ each for initial frequency $F_0$, dimension $m$, and lacunary weights $w_i$ in [`WeightErrorMargin.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/PiExponent/Approximation/WeightErrorMargin.lean#L1-L63) and [`WeightSeparation.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/PiExponent/Approximation/WeightSeparation.lean#L1-L120)) forces $E_{\text{ar}} + E_{\text{an}} < \varepsilon_0 \le 1/2$, contradicting Theorem 2.1 ([`DeterminantContradiction.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/PiExponent/Approximation/DeterminantContradiction.lean#L1-L120), [`Exponent.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/PiExponent/Approximation/Exponent.lean#L1-L120), [`thm_08_three_simultaneous_simplex_growth_ratios`](../proofs/pi_simplex_parameters_and_stratigraphy.lean#L158-L170), [`thm_09_explicit_rational_witness_for_nu_five_halves`](../proofs/pi_simplex_parameters_and_stratigraphy.lean#L177-L188), [`thm_10_three_way_error_budget_splitting_contradiction`](../proofs/pi_simplex_parameters_and_stratigraphy.lean#L196-L208), [`thm_27_explicit_dimension_and_center_count_at_nu_five_halves`](../proofs/pi_laurent_determinant_and_flint_hills.lean#L152-L162)).
- **Flint-Hills and Generalized Series (`Section 5`, [`series.tex`](../proofs/oai_ref/tex/sections/series.tex#L12-L154), [`FlintConsequence.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/PiExponent/Analysis/FlintConsequence.lean#L1-L31), [`FlintSine.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/PiExponent/Analysis/FlintSine.lean#L1-L160))**: Isolating the unique resonant integer $n(q) \in [q\pi - \pi/2, q\pi + \pi/2)$ and applying dyadic partial summation yields $\sum_{n \in [2^k, 2^{k+1})} n^{-a} |\sin n|^{-b} = O(2^{k(\max(1,b) + \varepsilon' - a)})$ ([`thm_28_flint_hills_bad_index_uniqueness_and_residue_injectivity`](../proofs/pi_laurent_determinant_and_flint_hills.lean#L170-L180), [`thm_29_dyadic_partial_summation_exponent_for_flint_hills`](../proofs/pi_laurent_determinant_and_flint_hills.lean#L189-L199), [`thm_30_generalized_sine_series_convergence_threshold_and_gap_audit`](../proofs/pi_laurent_determinant_and_flint_hills.lean#L206-L215)).

---

## 3. Complete Index of All 30 Standalone Lean 4 Theorems (`thm_01` ~ `thm_30`)

| File | Theorem Identifier | Verified Property & Upstream Reference |
| :--- | :--- | :--- |
| [`pi_simplex_parameters_and_stratigraphy.lean`](../proofs/pi_simplex_parameters_and_stratigraphy.lean#L1-L210) | [`thm_01_pi_exponent_869_file_stratigraphy_partition`](../proofs/pi_simplex_parameters_and_stratigraphy.lean#L19-L46) | Exact partition of `869` files (`94,948` lines) across `8` subdirs + `2` root files (`0` dead modules) |
| Same | [`thm_02_unused_hypothesis_14_and_zero_external_imports`](../proofs/pi_simplex_parameters_and_stratigraphy.lean#L51-L62) | Accounting of the `14` unused hypotheses (`4+4+2+2+2`) and `0` external `OAI.*` imports |
| Same | [`thm_03_flint_hills_scope_note_vs_main_lean_audit`](../proofs/pi_simplex_parameters_and_stratigraphy.lean#L70-L78) | Scope discrepancy between `017.md:11` and `Main.lean:29-32` (`flint_hills_summable` proved!) |
| Same | [`thm_04_reasoning_trace_45_sections_62_over_25_to_2_pivot`](../proofs/pi_simplex_parameters_and_stratigraphy.lean#L84-L97) | Reasoning trace Part I (`44` sections, $\mu \le 62/25 = 2.48$) $\to$ Part II (`1` section, $\mu = 2$) |
| Same | [`thm_05_parameter_interval_nonempty_iff_nu_gt_two`](../proofs/pi_simplex_parameters_and_stratigraphy.lean#L107-L114) | Nonemptiness of $b \in (1/2, 1-1/\nu)$ in `Lemma 4.1` iff $\nu > 2$ |
| Same | [`thm_06_approximation_gap_linear_delta_factorization`](../proofs/pi_simplex_parameters_and_stratigraphy.lean#L121-L132) | Exact polynomial factorization of $\nu(A-\theta)-(1-\theta) = (\nu(1-b)-1)\delta > 0$ |
| Same | [`thm_07_quadratic_simplex_window_theta_minus_A_sq`](../proofs/pi_simplex_parameters_and_stratigraphy.lean#L139-L152) | Nonlinear quadratic identity $S\theta - A^2 = \delta((2b-1)S - b^2\delta) > 0$ |
| Same | [`thm_08_three_simultaneous_simplex_growth_ratios`](../proofs/pi_simplex_parameters_and_stratigraphy.lean#L158-L170) | Simultaneous positivity of $B - A$, $S^2 - CB$, and $C\theta - BS$ |
| Same | [`thm_09_explicit_rational_witness_for_nu_five_halves`](../proofs/pi_simplex_parameters_and_stratigraphy.lean#L177-L188) | Explicit rational witness at $\nu = 5/2$ ($b=11/20, \delta=1/10, \theta=9/10, A=189/200, B=379/400, C=211/200$) |
| Same | [`thm_10_three_way_error_budget_splitting_contradiction`](../proofs/pi_simplex_parameters_and_stratigraphy.lean#L196-L208) | Three-way $\varepsilon_0/3$ error budget splitting (`E_init`, `E_dim`, `E_wt`) and $cL > 2$ contradiction |
| [`pi_transverse_multiplicity_and_seshadri_blowup.lean`](../proofs/pi_transverse_multiplicity_and_seshadri_blowup.lean#L1-L190) | [`thm_11_weighted_simplex_vs_inscribed_rectangle_quotient_length`](../proofs/pi_transverse_multiplicity_and_seshadri_blowup.lean#L21-L34) | `Lemma 2.2` continuous simplex ($2k!$) vs Lean inscribed rectangle ($k^k$) and crossover at $k=2$ |
| Same | [`thm_12_paper_vs_lean_weight_separation_constant_c_star`](../proofs/pi_transverse_multiplicity_and_seshadri_blowup.lean#L41-L51) | Comparison of $C_*^{\text{paper}} = 64$ vs $C_*^{\text{Lean}} = 320,000$ (`5,000x` ratio) at $m=2, \sigma=1$ |
| Same | [`thm_13_euclidean_quotient_remainder_simplex_sandwich`](../proofs/pi_transverse_multiplicity_and_seshadri_blowup.lean#L57-L69) | Euclidean quotient-remainder sandwich $b_i = w_i q_i + r_i$ in `SimplexCounting.lean:40` |
| Same | [`thm_14_pigeonhole_stabilization_of_derivative_vanishing_locus`](../proofs/pi_transverse_multiplicity_and_seshadri_blowup.lean#L81-L91) | Pigeonhole stabilization of derivative chain of length $L_0 = m+2$ ($m+3$ levels) |
| Same | [`thm_15_gauss_bonnet_logarithmic_residue_rigidity`](../proofs/pi_transverse_multiplicity_and_seshadri_blowup.lean#L98-L105) | Logarithmic differential rigidity $dX_i/X_i = dY/Y$ and pole-order contradiction at $X_i = \infty$ |
| Same | [`thm_16_bouts_lemma_transverse_w_degree_lower_bound`](../proofs/pi_transverse_multiplicity_and_seshadri_blowup.lean#L113-L120) | Dimension-independent transverse Bézout bound (`Proposition 2.3`) via maximum $B$-coordinate |
| Same | [`thm_17_curve_exclusion_when_sum_h_p_exceeds_one_over_one_plus_sigma`](../proofs/pi_transverse_multiplicity_and_seshadri_blowup.lean#L126-L138) | Exclusion of curves when $(1+\sigma)\sum_{P \in \Sigma'} h_P > \deg_W(C)$ (`Step 3` of `Theorem 2.1`) |
| Same | [`thm_18_lazarsfeld_nef_plus_ample_bundle_decomposition`](../proofs/pi_transverse_multiplicity_and_seshadri_blowup.lean#L149-L159) | Seshadri slack in $L_N = K_{\widetilde{X}} + M_N + A + \dots$ on the blowup $\widetilde{X} \to X$ (`Eq. (2.23)`) |
| Same | [`thm_19_top_self_intersection_volume_deficit_and_kodaira_contradiction`](../proofs/pi_transverse_multiplicity_and_seshadri_blowup.lean#L167-L174) | Top self-intersection $(M_N^{m+1}) \ge 0$ and Kodaira vanishing $H^1(\widetilde{X}, L_N) = 0$ |
| Same | [`thm_20_reverse_holder_sum_from_l_m_plus_1_bound_to_l1_sum`](../proofs/pi_transverse_multiplicity_and_seshadri_blowup.lean#L181-L188) | Synthesis of curve-clustered piece $\Sigma \setminus Z_0$ and $(m+1)$-st power sum on $Z_0$ (`Eq. (2.28)`) |
| [`pi_laurent_determinant_and_flint_hills.lean`](../proofs/pi_laurent_determinant_and_flint_hills.lean#L1-L217) | [`thm_21_gaussian_integer_clearing_and_liouville_obstruction`](../proofs/pi_laurent_determinant_and_flint_hills.lean#L22-L51) | `Lemma 3.1` Gaussian integer norm $a^2+b^2 \ge 1$ and Liouville-number period obstruction |
| Same | [`thm_22_elementary_dyadic_lcm_bound_four_log_two`](../proofs/pi_laurent_determinant_and_flint_hills.lean#L58-L69) | Elementary dyadic $\Lambda_{\text{Lean}} = 4\log 2 \approx 2.773$ vs PNT $\Lambda_{\text{PNT}} \approx 1.732$ |
| Same | [`thm_23_row_translation_invariance_via_euler_period`](../proofs/pi_laurent_determinant_and_flint_hills.lean#L77-L86) | `Lemma 3.2` unit upper-triangular row translation invariance via $e^{2\pi i j} = 1$ |
| Same | [`thm_24_cauchy_schwarz_taylor_collision_degree_lower_bound`](../proofs/pi_laurent_determinant_and_flint_hills.lean#L93-L107) | `Lemma 3.3` nonlinear Cauchy-Schwarz inequality $2(m_1^2+m_2^2) \ge (m_1+m_2)^2$ on Taylor shells |
| Same | [`thm_25_two_alternative_determinant_upper_bound_and_contradiction`](../proofs/pi_laurent_determinant_and_flint_hills.lean#L114-L124) | `Proposition 3.4` elimination of Case 1 and contradiction $cL < 2 < cL$ in Case 2 |
| Same | [`thm_26_asymptotic_cancellation_of_m_factorial_in_log_d_over_m_log_m`](../proofs/pi_laurent_determinant_and_flint_hills.lean#L131-L141) | Asymptotic cancellation of $m(m+1)\log v_0$ in $(m+1)\log M - m\log D_{\mathcal{A}}(H)$ |
| Same | [`thm_27_explicit_dimension_and_center_count_at_nu_five_halves`](../proofs/pi_laurent_determinant_and_flint_hills.lean#L152-L162) | Quantitative thresholds $\varepsilon_0 = 1/160, F_0 = 1201$ and positive drifts at $\nu = 5/2$ |
| Same | [`thm_28_flint_hills_bad_index_uniqueness_and_residue_injectivity`](../proofs/pi_laurent_determinant_and_flint_hills.lean#L170-L180) | `Fin 4` residue grouping constant `16` (`FlintSine.lean:88`) vs paper's $8/\pi \approx 2.546$ |
| Same | [`thm_29_dyadic_partial_summation_exponent_for_flint_hills`](../proofs/pi_laurent_determinant_and_flint_hills.lean#L189-L199) | Dyadic shell decay exponent: reasoning trace Part I ($-1/25$) vs final proof ($-1+\varepsilon$, `18.75x` faster) |
| Same | [`thm_30_generalized_sine_series_convergence_threshold_and_gap_audit`](../proofs/pi_laurent_determinant_and_flint_hills.lean#L206-L215) | `Corollary 5.2` generalized convergence exponent negativity for both $b > 1$ and $b \le 1$ |

---

## 4. Symbolic & Numerical Solver Highlights ([`verify_symbolic_pi017.py`](../proofs/verify_symbolic_pi017.py#L1-L216))

The deterministic output in [`symbolic_verification_result.json`](../proofs/symbolic_verification_result.json#L1-L276) establishes exact rational witnesses across $\nu \to 2^+$:

| Target $\nu$ | $b = \frac{3\nu-2}{4\nu}$ | $\delta$ | Margin $g = \nu(A-\theta)-(1-\theta)$ | Window $\theta - A^2$ | Cutoff $F_0$ | Drift $B/A$ | Proxy $m_{\min}$ ($cL > 2$) |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| `5/2 = 2.50` | `11/20 = 0.55` | `20/121` | `5/242 ≈ 0.02066` | `1/121 ≈ 0.00826` | `727` | `1.002488` | `7,458` |
| `62/25 = 2.48` | `17/31 ≈ 0.5484` | `93/578` | `279/14450 ≈ 0.01931` | `9/1156 ≈ 0.00779` | `772` | `1.002330` | `8,023` |
| `21/10 = 2.10` | `43/84 ≈ 0.5119` | `84/1849` | `21/18490 ≈ 0.00114` | `1/1849 ≈ 0.00054` | `11,095` | `1.000142` | `175,349` |
| `201/100 = 2.01` | `403/804 ≈ 0.5012` | `804/162409` | `201/16240900 ≈ 1.24e-5` | `1/162409 ≈ 6.16e-6` | `974,455` | `1.00000155` | `22,324,406` |

- Computing the partial sums $\sum_{n=1}^N \frac{1}{n^3 \sin^2 n}$ up to $N = 10,000$ confirms that the partial sum stays at $4.807444$ up to $N = 354$, **jumps by $24.598181$ at $n = 355$** (from Zu Chongzhi's famous convergent $355/113 \approx \pi$), and stabilizes at $30.314511$ by $N = 10,000$ ([`symbolic_verification_result.json`](../proofs/symbolic_verification_result.json#L238-L254)).
