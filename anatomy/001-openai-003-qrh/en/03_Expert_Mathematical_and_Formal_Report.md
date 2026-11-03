# [Tier 3: Expert Technical Report] Mathematical Structure & Formal Verification of Exponent and Parameter Bounds in OpenAI `#003`

- **Date**: 2026-10-31
- **Target Repository**: `openai/frontiermath-open-problems` (`problems/number-theory/quasi-riemann-hypothesis/FirstProof2026Problem3`)
- **Primary Formal Proof Artifact**: `proofs/qrh_exponent_and_parameter_bounds.lean` (`SHA-256: d1905fbc63fa2118025daae4afdd1e4d84e27d7ce9312210da3cd7fd920317e1`, 404 lines, 27 `theorem` declarations, `0` `sorry`, `0` custom `axiom`, `lean` `exit 0`)
- **Symbolic Verification Artifact**: [`proofs/symbolic_verification_result.json`](../proofs/symbolic_verification_result.json) (`SHA-256: 441dace0d0495b439cf50dcb32d892e2dd0070de65c8f1827db3a66ab2b65761`)

---

## 1. Executive Summary & Verification Scope

An analysis of OpenAI's `#003` formal proof (`FirstProof2026Problem3`) shows that the rational constants across its parameter files (`CentralExponent.lean`, `CubeFloorSaving.lean`, `Endpoint.lean`, `LowSourceScales.lean`, `GramScaleLoss.lean`, `GramBound.lean`, `HighRowsTail.lean`, `PrincipalRemainderBounds.lean`) are governed by three exact algebraic thresholds:
1. **Cube Floor Margin Root (`37/72 ≈ 0.513889`)**: $a_{\max} = \frac{37}{72}$ ($\eta_{\max} = \frac{1}{72}$), where the linear floor margin $B_{\text{floor}}(\eta) = \frac{3}{2}\eta - \frac{1}{48}$ vanishes identically (`Theorem 12`).
2. **Stationary Point of `balancedExponent` (`0.693319`) & $z_{\text{re}} = \frac{1}{6}$ Convergence Boundary**: The quadratic irrational root $a^* = \frac{323}{276} - \frac{35\sqrt{16354}}{9384} \approx 0.6933187811$ (approximated in `Endpoint.lean` by the rational SOS reference point $a_{\text{ref}} = \frac{283}{408} \approx 0.69362745$, `Theorem 4` and `Theorem 27`) and the $z_{\text{re}} = \frac{1}{6}$ convergence boundary (`Theorem 19`).
3. **Baseline Zero-Free Boundary (`7/8 = 0.875`)**: The baseline zero-free abscissa $\beta_{\text{base}} = \frac{5}{6} + \frac{\alpha_X + \alpha_Y - 2\ell}{12} = \frac{7}{8} = 0.875$ (`Theorem 18`).

We distinguish between the **Formalized Rational & Integer Theorems** proved in this package and **Future Complex-Analytic Extensions**:

| Scope | Description | Status |
| :--- | :--- | :--- |
| **Formalized Rational & Integer Theorems** | Exact rational (`Rat`), integer (`Int`), and natural (`Nat`) parameter budgets (`21` theorems via `decide +kernel` and `6` universally quantified `∀` theorems via `revert; omega`), Sum-of-Squares (SOS) decompositions, stationary-point identities, $m \ge 2$ Gauss valuation table vanishing (`6 of 8` branches), componentwise Gram exponent differences ($\frac{215}{3264}$ and $\frac{487}{3264}$), and $(w, z)$ contour shift exponent budgets (`17/48000`). | **Formally Proved** across 27 theorems in `proofs/qrh_exponent_and_parameter_bounds.lean` (`exit 0`, zero `sorry`) + verified in [`proofs/symbolic_verification_result.json`](../proofs/symbolic_verification_result.json). |
| **Future Complex-Analytic Extensions** | Complex-analytic Mellin residue continuation for the separated finite $m=1$ terms across the 3,414-file `.lean` tree, interval-arithmetic formalization of the finite prime norms $4 \le Q < 480$ in Lean 4, and off-diagonal bilinear phase cancellation for the diagonal `peak_scale` term. | **Open Research Tasks** (`qrh_exponent_and_parameter_bounds.lean` alone does not claim a full complex-analytic proof of the Riemann Hypothesis or $\beta < 7/8$). |

---

## 2. Detailed Mathematical Findings

### 2.1 Cube Floor Margin Root (`37/72 ≈ 0.513889`) & Parameter Budget at `0.5001`
In [`proofs/oai_ref/CentralExponent.lean`](../proofs/oai_ref/CentralExponent.lean) and [`proofs/oai_ref/CubeFloorSaving.lean`](../proofs/oai_ref/CubeFloorSaving.lean), setting $a = \frac{1}{2} + \eta$, $d = \frac{13}{16}$, $R = 1$, $q = \eta$ yields:
$$\operatorname{sourceExponent}\left(\frac{1}{2}+\eta, \frac{13}{16}, 1, \eta\right) - \frac{3}{16} = \frac{3}{2}\eta - \frac{1}{48}$$
- At $\eta = \frac{1}{100}$ ($a_{\text{floor}} = \frac{51}{100} = 0.51$), the floor margin is $-\frac{7}{1200}$ (`Theorem 8`).
- At $\eta = \frac{1}{10000}$ ($a_{\text{floor}} = \frac{5001}{10000} = 0.5001$), the floor margin improves to $-\frac{1241}{60000}$, expanding the absolute saving budget by $\frac{891}{60000} = \frac{297}{20000} \approx 0.01485$ (`Theorem 11`) and satisfying the 17-parameter budget with net used budget $\frac{6309}{400000} \le \frac{1241}{60000}$ (`Theorem 14`).
- At $\eta_{\max} = \frac{1}{72}$ ($a_{\max} = \frac{37}{72} \approx 0.513889$), the floor saving vanishes (`Theorem 12`).

### 2.2 Stationary Point (`0.693319`) vs. Rational SOS Reference Point (`79/204`)
In [`proofs/oai_ref/Endpoint.lean`](../proofs/oai_ref/Endpoint.lean), at $y = 0$:
$$E_{\text{bal}}(\delta, 0) = \frac{1224\delta^2 - 948\delta + 185}{48(138\delta - 185)}$$
Solving $\frac{\partial E_{\text{bal}}}{\partial \delta}(\delta, 0) = 0$ yields $9384\delta^2 - 25160\delta + 8325 = 0$, whose unique root in $[0, 5/6]$ is:
$$\delta^* = \frac{185}{138} - \frac{35\sqrt{16354}}{4692} \approx 0.3866375622 \implies a^* = \frac{1+\delta^*}{2} = \frac{323}{276} - \frac{35\sqrt{16354}}{9384} \approx 0.6933187811$$
To avoid irrational square roots in Lean 4, OpenAI used the rational point $\delta_{\text{SOS}} = \frac{79}{204}$ ($a_{\text{SOS}} = \frac{283}{408} \approx 0.69362745$), where $(4 \cdot 51 \cdot \delta - 79)^2 = 0$, $E_{\text{bal}}\left(\frac{79}{204}, 0\right) = -\frac{7}{30672}$, $\frac{\partial^2 E_{\text{bal}}}{\partial \delta^2}\left(\frac{79}{204}, 0\right) = -\frac{236315300}{608806611} < 0$, and $\frac{\partial E_{\text{bal}}}{\partial y}\left(\frac{79}{204}, 0\right) = -\frac{2933665}{333189936} < 0$ (`Theorem 4`, `Theorem 5`, `Theorem 27`).

### 2.3 Componentwise Gram Scale Exponent Differences (`215/3264` and `487/3264`)
Examining [`proofs/oai_ref/LowSourceScales.lean`](../proofs/oai_ref/LowSourceScales.lean), [`proofs/oai_ref/GramScaleLoss.lean`](../proofs/oai_ref/GramScaleLoss.lean), and [`proofs/oai_ref/GramBound.lean`](../proofs/oai_ref/GramBound.lean) shows four upper-bound relaxations ($\frac{3}{96}$, $\frac{6\delta}{96}$, $\frac{1}{96}$, $\frac{23\delta}{96}$ in the square-root exponent) between the individual energy terms and `lowGramFactor` ($\frac{18+23\delta}{96}$).
At $\delta_{\text{SOS}} = \frac{79}{204}$, the componentwise square-root $Z$-exponent differences are:
- Exceptional cubic Gauss term: **$\frac{1817}{19584} \approx 0.092780$**
- Non-exceptional Poisson term (with $L \le Z^{8/48}$ bound): **$\frac{215}{3264} \approx 0.065870$** (compared to the SOS rational rounding residual $\frac{49}{440640} \approx 0.0001112$, proved in `Theorem 24`)
- Non-exceptional Poisson term (at $L = 1$ pure scale): **$\frac{487}{3264} \approx 0.149203$** (note that the parallel cubic Gauss main term $\frac{18}{96} = \frac{3}{16}$ remains the bottleneck for the total operator norm `‖E - Z‖`)

### 2.4 $m \ge 2$ Gauss Valuation Vanishing (`6 of 8` Branches) & Contour Shift Budget (`17/48000`)
- **$m \ge 2$ Branch Vanishing**: In [`proofs/oai_ref/HighRowsTail.lean`](../proofs/oai_ref/HighRowsTail.lean), `rowInner_base_rational` separates $m = 0, 1$ from the $m \ge 2$ geometric tail. By `gaussValuationTable_above`, **6 of the 8** non-principal $(e, l, k)$ branches vanish identically for all $m \ge 2$ (`Theorem 21`), leaving only `02_0` and `10_1`, whose convergence condition relaxes from $z_{\text{re}} \ge \frac{1}{6}$ to **$z_{\text{re}} \ge \frac{1}{12}$** (`Theorems 20, 22, 23`).
- **Principal Remainder Shift Budget**: Shifting across the sextic zeta pole $z = \frac{1}{6}$ to $z = \frac{33}{200}$ ($e_{\max} = \frac{1}{1000}$) yields $w$-shift saving $\frac{1063}{48000}$ and $z$-shift saving $\frac{13}{16}\left(\frac{1}{6} - \frac{33}{200}\right) - \frac{1}{1000} = \mathbf{\frac{17}{48000}}$, matching `principal_budget = 17/48000` in `ParametersHighData.lean:45` (`Theorem 19`).

---

## 3. Cross-Verification Table: Lean 4 Kernel vs. Symbolic Solver (`verify_symbolic_qrh.py`)

| Problem | Formal Lean 4 Theorem (`qrh_exponent_and_parameter_bounds.lean`) | Symbolic Solver Output ([`symbolic_verification_result.json`](../proofs/symbolic_verification_result.json)) | Status |
| :--- | :--- | :--- | :---: |
| **Problem 1**: Floor margin linear formula & root | `Theorem 12` (`floor_source_margin_root_37_72`, `L138`): `a_max = 37/72` (`eta_max = 1/72`) | `"linear_expression": "3*eta/2 - 1/48"`, `"eta_max": "1/72"`, `"a_max": "37/72"` | **Match** |
| **Problem 2**: Irrational stationary point vs. SOS point `79/204` | `Theorem 4` (`L86`), `Theorem 5` (`L95`), `Theorem 27` (`L386`) | `"a_true": "323/276 - 35*sqrt(16354)/9384"`, `"delta_SOS": "79/204"`, `"a_SOS": "283/408"`, `"balancedExponent_delta_SOS": "-7/30672"` | **Match** |
| **Problem 3**: Componentwise Gram exponent differences at `79/204` | `Theorem 24` (`componentwise_gram_exponent_differences`, `L342`): `1817/19584`, `215/3264` (with $L \le Z^{1/6}$), and `487/3264` (at $L=1$) | `"saving_exceptional": "1817/19584"`, `"saving_nonexceptional_with_L_bound": "215/3264"`, `"saving_nonexceptional": "487/3264"` | **Match** |
| **Problem 4**: $m \ge 2$ branch vanishing & $z_{\text{re}}$ bound | `Theorem 20` (`L273`), `Theorem 21` (`L302`), `Theorem 22` (`L315`), `Theorem 23` (`L332`) | `"num_vanishing_branches": 6`, `"surviving_branches": ["02_0", "10_1"]`, `"z_re_min": "1/12"` | **Match** |
| **Problem 5**: Principal contour shift budget | `Theorem 19` (`convergence_boundary_at_one_sixth`, `L258`): `(13/9600) - 1/1000 = 17/48000` | `"w_shift_saving_at_e_max": "1063/48000"`, `"z_shift_saving_at_e_max": "17/48000"`, `"B_principal": "17/48000"`, `"matches_principal_budget": true` | **Match** |


---

## 7. Completion of Tasks 1–3: Small-Norm Threshold Removal, 2nd/3rd Complex Mellin Continuation, and Master Scale-Coupling Equations (Theorems 28–40)

### 7.1 Task 1: Removal of $4 \le Q < 480$ Threshold & Finite Bad-Prime Mask Absorption (Theorems 28–30)
1. **Call-Graph Verification (`CubePrimeThresholds.lean:13-33`, `FirstTail.lean:81-100`)**:
   - `HighRowsCentralQuotient.lean:9` (`480 ≤ Q`) is only invoked on dyadic pool primes $P \in T_j$ (`CubePrimeBound.lean:105`), where `CubePrimeThresholds.lean:13-33` (`central_pool_good_eventually`) unconditionally discharges `480 ≤ Q` via $Q \ge c Z^{d_{\min} r_{\min}} \to \infty$.
   - Global Euler product tails are handled by `FirstTail.lean:81-100` (`exists_both_source_exclusions`), which absorbs `smallPrimeSet N` into the finite bad-prime mask $S = S_0 \cup \text{smallPrimeSet}(N)$.
2. **Exact $(1 - V)^{-1}$ Cancellation and Threshold Reduction $480 \to 112$ (`theorem_28_marked_factor_singularity_cancels_identically`, `theorem_29_all_small_eisenstein_norms_nonvanishing`, `theorem_30_universal_finite_bad_prime_mask_absorption`)**:
   - Multiplying `continuedCorrection` by $(1 - D)(1 - R)$ identically cancels the $(1 - V)^{-1}$ denominator in `markedFactor` (`theorem_28_marked_factor_singularity_cancels_identically`), reducing the central quotient bound from $480$ to $112$ (`88 < 112`), and all 21 small Eisenstein prime-power norms in $4 \le Q < 112$ have non-vanishing Euler denominators (`theorem_29_all_small_eisenstein_norms_nonvanishing`).

### 7.2 Task 2: $m=1$ Residue Anatomy & 2nd/3rd Euler Continuation (Theorems 31–34, 39)
1. **Second Euler Continuation (`secondContinuedCorrection`) & 5-Term Cancellation (`theorem_31_second_continuation_exact_polynomial_identity`)**:
   - Defining $\text{secondContinuedCorrection}(R, V, W, D, P^*) := (1 - R) \cdot \text{continuedCorrection}(V, W, D, P^*)$ yields
     $$(1 - D)\big(\text{secondContinuedCorrection} - 1\big) = -VW + WD - RW^2 + RVW + (1 - W)(-R q_{\text{inv}} - KV + VD - VWR),$$
     identically cancelling all five first-order terms (`1 - 1`, `-R + R`, `-D + D`, `+WR - WR`, `+RD - RD`).
2. **Lowering the Euler-Tail $z_{\text{re}}$ Barrier & Exact $z_0$-Invariance at $d_0 = 13/16$ (`theorem_32_second_and_third_continuation_convergence_barrier`, `theorem_33_central_exponent_z0_invariance_at_d0`, `theorem_34_universal_z0_shift_improves_subcritical_d`, `theorem_39_m1_sextic_pole_residue_and_33_200_remainder_saving`)**:
   - Peeling off $(1 - R)$ and $(1 - RW^2)$ lowers the Euler-tail absolute convergence barrier at $x_{\text{re}} = 51/100$ from $z_{\text{re}} > 97/300 \approx 0.3233$ (`17/50 = 0.34`) to **$z_{\text{re}} > 97/600 \approx 0.16167 < 1/6$** (`-(53/50) = -1.06 < -1` at $z_{\text{re}} = 1/6$, `theorem_32_second_and_third_continuation_convergence_barrier`).
   - In `CentralExponent.lean:11-14`, the coefficient of $z_0$ in `sourceExponent` is $1 + \ell - \alpha_X - d$, which vanishes identically at $d = d_0 = 13/16$ (`1 + 1/6 - 17/48 - 13/16 = 0`, `theorem_33_central_exponent_z0_invariance_at_d0`). For all $d < 13/16$ (e.g. $d = 1/2$), lowering $z_0$ from $17/50$ to $1/6$ strictly improves the exponent from $-49/14400$ to **$-829/14400$ (an absolute shift of $-780/14400 = -13/240 \approx -0.0542$, `theorem_34_universal_z0_shift_improves_subcritical_d`)**, while the sextic Gauss sum $L(\pi, 6z)$ pole at $z = 1/6$ (`HighRowsCentralTerms.lean:47-53`) leaves the separate Mellin residue term bounded in `theorem_39_m1_sextic_pole_residue_and_33_200_remainder_saving`.

### 7.3 Task 3: Master Scale-Coupling Equations for `3/16` and `-11/16` & Rescaling Anatomy (Theorems 35–40)
1. **Master Coupling Equations (`theorem_35_master_scale_coupling_identities`)**:
   - Across `PrincipalSignalComparison.lean:412` and `LowSourceScales.lean:40-68`:
     $$c_{\text{sig}}(\alpha_X, \ell) = \frac{\alpha_X}{3} + \frac{\ell}{6} - \frac{5}{6}, \quad e_{\text{low}}(\alpha_X, \alpha_Y) = \frac{5\alpha_X + \alpha_Y}{12}, \quad \beta_{\text{crit}}(\alpha_X, \alpha_Y, \ell) = \frac{5}{6} + \frac{\alpha_X + \alpha_Y - 2\ell}{12}.$$
2. **Regime A ($\beta_{\text{crit}} = 128519/146880 < 7/8$ on Active `LowSourceScales.lean` Path vs. `Parameters.lean` Split Invariance, `theorem_36_regime_A_sos_slack_rescaling_and_conductor_split`)**:
   - Shifting $(\alpha_X, \alpha_Y)$ by $\eta = 3/73440$ (`α_X' = 26007/73440`, `α_Y' = 35187/73440`) with fixed split $\ell = 1/6$ preserves the active `LowSourceScales.lean:80-104` Poisson inequality $2\alpha_X' - \alpha_Y' - \ell = 4587/73440 > 0$ across $d \in [0, 1/6]$, keeps the worst-case endpoint exponent $\le -7/440640 < 0$, and lowers $\beta_{\text{crit}}$ to **$\frac{128519}{146880} < \frac{7}{8}$**; whereas simultaneously shifting $\ell' = 1/6 - \eta$ to keep $\alpha_X' - \ell' = 3/16$ in `Parameters.lean:14` leaves $\alpha_X' + \alpha_Y' - 2\ell' = 1/2$ invariant ($\beta_{\text{crit}} = 7/8$).
3. **Regime B ($\beta_{\text{crit}} = 5/6, 3/4, 69/100$ Under Unbundled/Diagonal Gram Bounds, `theorem_37_regime_B_gram_unbundled_and_diagonal_beta_bounds`–`theorem_40_energy_induction_compatible_below_seven_eighths`)**:
   - Combining Theorem 24's unbundled Gram saving ($215/3264$) with $(\alpha_X, \alpha_Y, \ell) = (1/3, 1/3, 1/3)$ achieves **$\beta_{\text{crit}} = 5/6$** with net margin $+79/3264 > 0$; diagonal Gram dominance ($e_{\text{low}} = \alpha_X / 2$) achieves **$\beta_{\text{crit}} = 3/4 = 0.75$** and **$\beta_{\text{crit}} = 69/100 = 0.69$**, with full compatibility in `Energy/CertifiedExistence.lean:19-48` down to $\beta = 51/100$ (`theorem_40_energy_induction_compatible_below_seven_eighths`).
