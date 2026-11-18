# Tier 4: Automated Verification Spec: Verification Commands & Manifest

This document provides the verification commands and artifact hashes for automated theorem provers, CI pipelines, and code parsers verifying this repository.



## 1. Verification Commands

Execute the following commands from the case root directory to verify all 48 Lean 4 theorems (exit 0, zero sorry/axiom), reproduce the symbolic JSON output, and check SHA-256 integrity:

```bash
# 1. Verify formal Lean 4 proofs (Theorems 1-27 & Theorems 28-48, must exit with code 0)
lean proofs/qrh_exponent_and_parameter_bounds.lean && lean proofs/qrh_continuation_and_rescaling.lean

# 2. Re-run the symbolic verification script and check output
cd proofs && python3 verify_symbolic_qrh.py && cd ..

# 3. Verify SHA-256 checksums of core artifacts against manifest.json
sha256sum proofs/qrh_exponent_and_parameter_bounds.lean \
          proofs/qrh_continuation_and_rescaling.lean \
          proofs/verify_symbolic_qrh.py \
          proofs/symbolic_verification_result.json \
          proofs/problem_spec.md
```



## 2. Artifact SHA-256 Hash List

| Relative Path | SHA-256 Checksum | Description |
| :--- | :--- | :--- |
| [proofs/qrh_exponent_and_parameter_bounds.lean](../proofs/qrh_exponent_and_parameter_bounds.lean) | `2e98aff37741ab5ae4b67c9e36da3816e09325c40d0abcf462a676e0e2ec6ae1` | 404 lines, 27 Lean 4 theorems (Theorem 1~Theorem 27), 0 sorry, 0 custom axiom. |
| [proofs/qrh_continuation_and_rescaling.lean](../proofs/qrh_continuation_and_rescaling.lean) | `7d64b243421117960431dc4e2ac86e4b3d086fae87af55746673e298976fa1e3` | 469 lines, 21 Lean 4 theorems (Theorem 28~Theorem 48, Tasks 1–4 & 179-decl 1-to-1 audit), 0 sorry, 0 custom axiom. |
| [proofs/verify_symbolic_qrh.py](../proofs/verify_symbolic_qrh.py) | `086704058c0c30ca0ff9e3397a7e3bf2a76663af2255a4f98bd695a97439aab6` | Exact SymPy/Fraction symbolic solver extracting definitions directly from `./proofs/oai_ref/*.lean`. |
| [proofs/symbolic_verification_result.json](../proofs/symbolic_verification_result.json) | `072bdd831bd69aa096ea87eef639a6ac221051371cdbe80ea0ffa1b98c86bd55` | Exact rational/symbolic output dictionary for Problems 1 through 5. |
| [proofs/problem_spec.md](../proofs/problem_spec.md) | `7738b0510123db636cde912e60a856b2055b75ba561ce8dcebf1b3865ee30625` | Problem specification referencing `./oai_ref/*.lean`. |



## 3. Scope Notes

1. Formalized Rational/Integer Theorems vs. Future Complex-Analytic Extensions:
   - The 48 theorems across [proofs/qrh_exponent_and_parameter_bounds.lean](../proofs/qrh_exponent_and_parameter_bounds.lean) (Theorems 1–27) and [proofs/qrh_continuation_and_rescaling.lean](../proofs/qrh_continuation_and_rescaling.lean) (Theorems 28–48) are kernel-verified over `Rat`, `Int`, and `Nat` (covering algebraic parameter budgets, SOS decompositions, $m \ge 2$ Gauss branch vanishing, exact componentwise Gram exponent differences $\frac{215}{3264}$ and $\frac{487}{3264}$, $(w,z)$ contour-shift exponent budgets, universal 2nd/3rd Euler continuation polynomial cancellations, master scale-coupling equations, and the complete 26-file / 179 `def`/`theorem` declaration 1-to-1 formal audit including `instance polynomialComponentPrime_isPrime`, Siegel zero local Bézout cone homogenization, and arithmetic cutoff transport).
   - They do not formalize the continuous complex-analytic Mellin contour integrals for the separated $m=1$ finite terms or Hilbert-space trace-class operator bounds. Do not summarize this formalization as a complete unconditional proof of the full Riemann Hypothesis.
2. JSON Manifest & Upstream Snapshot Provenance:
   - Parse [manifest.json](../manifest.json) for programmatic access to all 48 theorem identifiers, line numbers, verified fractions, and SHA-256 hashes.
   - All 26 core reference Lean files are mirrored locally under `proofs/oai_ref/`. Any upstream repository files referenced by path outside `proofs/oai_ref/` (such as `DirichletL/PrimeRows/FirstTail.lean`, `DirichletL/PrimeRows/CubePrimeThresholds.lean`, `DirichletL/PrincipalMellinResidues.lean`, `DirichletL/PrincipalSignalComparison.lean`, `DirichletL/Hecke/CommonProbe.lean`, `DirichletL/Detector/HighRowsFirstRegion.lean`, `DirichletL/Detector/FirstContinuation.lean`, `DirichletL/Detector/Supremum.lean`, `DirichletL/ParametersFixedSource.lean`, `DirichletL/Energy/CertifiedExistence.lean`, `DirichletL/FinalAssemblyUnconditional.lean`, `SiegelZeros/Main.lean`, `PrimeNumberTheoremAnd/Wiener.lean`, `CONTENTS.md`, and `paper.tex`) are audited against `openai/math` commit `4eaee87` (`oai-math-revised` PR `#70` commit `ca28f20`).

### 3.1 Theorems 1–27 ([proofs/qrh_exponent_and_parameter_bounds.lean](../proofs/qrh_exponent_and_parameter_bounds.lean))
- [coordR_exponent_at_z_034](../proofs/qrh_exponent_and_parameter_bounds.lean#L64-L65): At $x = 51/100$ and $z = 17/50$, proves the `coordR` exponent equals $-11/10$.
- [coordR_squared_exponent_at_z_024](../proofs/qrh_exponent_and_parameter_bounds.lean#L69-L72): At $z = 6/25$, proves the quadratic $R^2$ exponent equals $-1$ at $x = 51/100$ and $-149/125 < -1$ at $x = 51/100 + 16/1000$.
- [gauss_branch_exponent_at_z_017](../proofs/qrh_exponent_and_parameter_bounds.lean#L76-L78): At $x = 51/100$ and $z = 17/100$, proves the finite Gauss branch `(0, 2, 0, 1)` exponent equals $-2/25 \le 1/2 - 51/100$.
- [rational_sos_reference_abscissa](../proofs/qrh_exponent_and_parameter_bounds.lean#L86-L91): Proves the rational SOS reference root $\delta_{\text{ref}} = 79/204$ gives $a_{\text{ref}} = 283/408 \in (0.69, 0.694)$ (`DirichletL/Endpoint.lean`).
- [exact_sos_identity_and_margin_at_79_204](../proofs/qrh_exponent_and_parameter_bounds.lean#L95-L99): Verifies `endpointSOS_LHS = endpointSOS_RHS = 147` and $-\operatorname{balancedExponent}(79/204, 0) = 7/30672 > 49/440640$.
- [sos_polynomial_identity_sample_points](../proofs/qrh_exponent_and_parameter_bounds.lean#L102-L106): Checks the 2D rational SOS polynomial identity across sample points in $[0, 5/6] \times [0, 1/2]$.
- [certified_exponent_margins_by_beta](../proofs/qrh_exponent_and_parameter_bounds.lean#L109-L112): Verifies certified rational exponent margins across $\beta \in \{7/8, 5/6, 3/4, 69/100\}$.
- [floor_source_margin_at_051](../proofs/qrh_exponent_and_parameter_bounds.lean#L119-L120): Proves the floor source margin at $a_{\text{floor}} = 51/100$ equals $-7/1200$ (`DirichletL/Detector/CentralExponent.lean`).
- [floor_source_margin_at_0505](../proofs/qrh_exponent_and_parameter_bounds.lean#L123-L124): Proves the floor source margin at $a_{\text{floor}} = 101/200$ equals $-1/75$.
- [floor_source_margin_at_0501](../proofs/qrh_exponent_and_parameter_bounds.lean#L127-L128): Proves the floor source margin at $a_{\text{floor}} = 501/1000$ equals $-29/1500$.
- [floor_source_margin_at_05001](../proofs/qrh_exponent_and_parameter_bounds.lean#L132-L134): Proves the floor source margin at $a_{\text{floor}} = 5001/10000$ equals $-1241/60000$, widening the saving over $-7/1200$ by $297/20000$.
- [floor_source_margin_root_37_72](../proofs/qrh_exponent_and_parameter_bounds.lean#L138-L139): Proves the exact vanishing root $\eta_{\max} = 1/72$ ($a_{\max} = 37/72$) where `sourceExponent - 3/16 = 0`.
- [nonstrict_gauss_branches_at_05001_and_017](../proofs/qrh_exponent_and_parameter_bounds.lean#L150-L163): Verifies all 9 non-strict finite Gauss-sum branches satisfy $\operatorname{gaussBranchExponent} \le 1/2 - x$ at $z = 17/100, x = 5001/10000$ (`DirichletL/Detector/HighRowsCentralTerms.lean`).
- [parameter_budget_inequality_at_05001](../proofs/qrh_exponent_and_parameter_bounds.lean#L167-L183): Verifies the 17-parameter budget inequality ($6309/400000 \le 1241/60000$) at $\beta = 69/100, r_{\text{ext}} = 17/100, a_{\text{floor}} = 0.5001$ (`DirichletL/PrimeRows/CubeFloorSaving.lean`, `DirichletL/Parameters.lean`).
- [siegel_zeros_constants_ratio_identity](../proofs/qrh_exponent_and_parameter_bounds.lean#L191-L197): Verifies $c_1 = 1/37636$, $C_1 = 192$, $H = 86713344$, and $(C_1/c_1)/H = 1/12$ (`SiegelZeros/Selection/PivotBounds.lean`, `SiegelZeros/Estimates/GeometricBoundary.lean`).
- [complementary_zero_free_widths](../proofs/qrh_exponent_and_parameter_bounds.lean#L200-L210): Proves complementary zero-free widths $1 - \beta \in \{1/8, 1/4, 31/100\}$ for $\beta \in \{7/8, 3/4, 69/100\}$.
- [functional_equation_reflection_and_quotient_thresholds](../proofs/qrh_exponent_and_parameter_bounds.lean#L214-L224): Proves functional-equation reflection ($0.49 \leftrightarrow 0.51$) and quotient ratios $192/480 = 2/5$, $56/112 = 1/2$.
- [exponent_balance_relation_identity](../proofs/qrh_exponent_and_parameter_bounds.lean#L234-L251): Proves the exponent balance identity linking $\alpha_X = 17/48$, $\alpha_Y = 23/48$, $\ell = 1/6$ to $\gamma_{\text{det}} = 3/16$, $c_{\text{signal}} = -11/16$, $d_0 = 13/16$, and $\beta = 7/8$.
- [convergence_boundary_at_one_sixth](../proofs/qrh_exponent_and_parameter_bounds.lean#L258-L268): Proves the $z_{\text{re}} = 1/6$ boundary and the shifted remainder budget $13/16 \cdot (1/6 - 33/200) - 1/1000 = 17/48000$ (`DirichletL/Detector/PrincipalRemainderBounds.lean`, `DirichletL/ParametersHighData.lean`).
- [tail_m_ge_2_exponent_margins](../proofs/qrh_exponent_and_parameter_bounds.lean#L273-L293): Verifies positive margins at $z_{\text{re}} = 9/100 > 1/12$ for surviving $m \ge 2$ geometric-tail branches (`DirichletL/Detector/HighRowsTail.lean`).
- [gauss_valuation_table_indices_m_ge_2](../proofs/qrh_exponent_and_parameter_bounds.lean#L302-L310): Universal $\forall (j < 6, n \le 5, m \ge 2)$ index bounds showing 6 of 8 branches vanish for $m \ge 2$.
- [gauss_sum_linear_exponent_bounds_m1_m2](../proofs/qrh_exponent_and_parameter_bounds.lean#L315-L328): Universal $\forall$ linear Gauss-sum exponent bounds for $a_{\text{bp}} \in [5001, 10000]$, $\epsilon_{\text{bp}} \le 10$, $m_1 \ge 1, m_2 \ge 2$.
- [general_order_m_tail_exponent_bound](../proofs/qrh_exponent_and_parameter_bounds.lean#L332-L336): Universal $\forall (M \ge 1, m \ge M)$ tail bound $5x + 6z_{\text{re}}m \ge 7/2$ under $x \ge 1/2, z_{\text{re}}m \ge 1/6$.
- [componentwise_gram_exponent_differences](../proofs/qrh_exponent_and_parameter_bounds.lean#L342-L358): Proves exact componentwise Gram square-root exponent differences $2021/19584$, $215/3264$ (with $L \le Z^{1/6}$), $1817/19584$, and $487/3264$ (at $L = 1$) (`DirichletL/Detector/LowSourceScales.lean`, `DirichletL/Detector/GramScaleLoss.lean`, `DirichletL/Detector/GramBound.lean`, `DirichletL/Detector/LowGramScale.lean`).
- [sos_certificate_weight_linear_bound](../proofs/qrh_exponent_and_parameter_bounds.lean#L362-L368): Universal $\forall (y_{\text{num}} \ge 0, D > 0)$ linear inequality $51D + 41y_{\text{num}} \le 17(3D + 5y_{\text{num}})$.
- [zero_free_region_union_and_symmetry](../proofs/qrh_exponent_and_parameter_bounds.lean#L372-L378): Universal $\forall$ zero-free region union and reflection-symmetry bounds.
- [stationary_point_quadratic_root_323_276_identity](../proofs/qrh_exponent_and_parameter_bounds.lean#L386-L402): Verifies the quadratic equation $9384\delta^2 - 25160\delta + 8325 = 0$ giving $a^* = 323/276 - 35\sqrt{16354}/9384$ and the negative derivatives at $\delta_{\text{SOS}} = 79/204$.

### 3.2 Theorems 28–48 ([proofs/qrh_continuation_and_rescaling.lean](../proofs/qrh_continuation_and_rescaling.lean))
- [theorem_28_marked_factor_singularity_cancels_identically](../proofs/qrh_continuation_and_rescaling.lean#L66-L77): Universal $\forall (R, V, q_{\text{inv}}, K, W, D : \text{Int})$ polynomial cancellation of the $(1-V)$ factor in `markedFactor` and reduction of the central quotient threshold from $480$ to $112$.
- [theorem_29_all_small_eisenstein_norms_nonvanishing](../proofs/qrh_continuation_and_rescaling.lean#L84-L91): Non-vanishing of Euler denominators across all 21 small Eisenstein prime-power norms in $4 \le Q < 112$.
- [theorem_30_universal_finite_bad_prime_mask_absorption](../proofs/qrh_continuation_and_rescaling.lean#L96-L100): Universal $\forall$ absorption law for finite bad-prime masks $S = S_0 \cup \text{smallPrimeSet}(N)$.
- [theorem_31_second_continuation_exact_polynomial_identity](../proofs/qrh_continuation_and_rescaling.lean#L109-L113): Universal $\forall (R, V, q_{\text{inv}}, K, W, D : \text{Int})$ 5-term cancellation identity for `secondContinuedCorrection`.
- [theorem_32_second_and_third_continuation_convergence_barrier](../proofs/qrh_continuation_and_rescaling.lean#L122-L141): Reduction of the Euler-tail $z_{\text{re}}$ convergence barrier from $97/300$ to $97/600 \approx 0.16167 < 1/6$ ($-(53/50) = -1.06 < -1$ at $z = 1/6$).
- [theorem_33_central_exponent_z0_invariance_at_d0](../proofs/qrh_continuation_and_rescaling.lean#L148-L163): Exact $z_0$-invariance of `sourceExponent` at $d_0 = 13/16$ (coefficient $0$) and $-13/240$ exponent shift ($-49/14400 \to -829/14400$) at $d = 1/2$.
- [theorem_34_universal_z0_shift_improves_subcritical_d](../proofs/qrh_continuation_and_rescaling.lean#L169-L179): Universal $\forall$ improvement of `sourceExponent` for all $d < 1 + \ell - \alpha_X$ when $z_0' < z_0$.
- [theorem_35_master_scale_coupling_identities](../proofs/qrh_continuation_and_rescaling.lean#L189-L203): Master scale-coupling identities for $-11/16$, $3/16$, and $\beta_{\text{crit}}(\alpha_X, \alpha_Y, \ell) = \frac{5}{6} + \frac{\alpha_X + \alpha_Y - 2\ell}{12}$.
- [theorem_36_regime_A_sos_slack_rescaling_and_conductor_split](../proofs/qrh_continuation_and_rescaling.lean#L212-L232): Derivation of $\beta_{\text{crit}} = 128519/146880 < 7/8$ on the active `DirichletL/Detector/LowSourceScales.lean:80-104` path using existing SOS slack vs. $\beta_{\text{crit}} = 7/8$ invariance under simultaneous `DirichletL/Parameters.lean:14` split shifting.
- [theorem_37_regime_B_gram_unbundled_and_diagonal_beta_bounds](../proofs/qrh_continuation_and_rescaling.lean#L239-L252): Proof of $\beta_{\text{crit}} = 5/6, 3/4, 69/100$ under unbundled and diagonal Gram bounds.
- [theorem_38_universal_beta_crit_monotonicity](../proofs/qrh_continuation_and_rescaling.lean#L258-L268): Universal $\forall$ monotonicity of $\beta_{\text{crit}}$ preserving Poisson admissibility.
- [theorem_39_m1_sextic_pole_residue_and_33_200_remainder_saving](../proofs/qrh_continuation_and_rescaling.lean#L274-L284): Exact Mellin pole-shift remainder savings ($-13/9600$, $-17/48000$) across the sextic Gauss pole $z = 1/6$.
- [theorem_40_energy_induction_compatible_below_seven_eighths](../proofs/qrh_continuation_and_rescaling.lean#L289-L298): Compatibility of `DirichletL/Energy/CertifiedExistence.lean:19-48` across all $\beta \in [51/100, 7/8]$.
- [theorem_41_bezout_homogenized_cone_and_degree_bounds](../proofs/qrh_continuation_and_rescaling.lean#L311-L322): Universal $\forall$ local isolated Bézout homogenized cone dimension $h < 5$ and 4-variable box degree bound `4*(N-1) < 4*N` (`SiegelZeros/Intersection/IsolatedBezoutFromRegularSelection.lean`, `SiegelZeros/Structure/ArithmeticCutoffTransport.lean`).
- [theorem_42_arithmetic_cutoff_and_pigeonhole_incompatibility](../proofs/qrh_continuation_and_rescaling.lean#L332-L347): 4-step derivative ideal pigeonhole ($b < 4$), cutoff coefficient `96 = 3 * 32`, and height-3 length incompatibility $32^3 = 32768 > 4^3 = 64$ (`SiegelZeros/Structure/ArithmeticCutoffTransport.lean`).
- [theorem_43_biquadratic_galois_and_pivot_constants](../proofs/qrh_continuation_and_rescaling.lean#L354-L366): Biquadratic field rank $4$, $c_1 = 1/37636$, $C_1 = 192$, $N_0 = 18818$, $H = 86713344$, and greedy pivot weight ratio $(C_1/c_1)/H = 1/12$ (`SiegelZeros/Selection/PivotBounds.lean`, `SiegelZeros/Estimates/GeometricBoundary.lean`, `SiegelZeros/Intersection/BezoutBoundary.lean`, `SiegelZeros/Conclusions/Theorem.lean`).
- [theorem_44_local_compensated_replacement_and_cancellation](../proofs/qrh_continuation_and_rescaling.lean#L375-L384): Universal $\forall (V, W, D, P_{\text{star}}, B, q : \text{Int})$ local defect polynomial identity and ramified compensation cancellation (`DirichletL/Detector/Local.lean`).
- [theorem_45_euler_resummation_and_correction_bounds](../proofs/qrh_continuation_and_rescaling.lean#L392-L403): Resolvent bound $2$ and error multipliers $12$ and $4$ in `unramified_marked_error_bound` (`DirichletL/Detector/Euler.lean`, `DirichletL/Detector/CorrectionBounds.lean`).
- [theorem_46_euler_coordinates_and_unramified_factorization](../proofs/qrh_continuation_and_rescaling.lean#L412-L426): Central contour $Q$-exponents of `coordV`, `coordR`, `coordW`, `coordD`, `coordK` and `3 * 480 = 1440` (`DirichletL/Detector/EulerCoordinates.lean`, `DirichletL/Detector/HighRowsUnramified.lean`, `DirichletL/Detector/HighRowsCentralQuotient.lean`).
- [theorem_47_sextic_gauss_valuation_table_and_high_rows_scalar](../proofs/qrh_continuation_and_rescaling.lean#L434-L441): Universal $\forall (r, m, j, d : \text{Nat})$ mod-6 periodicity and unique index decomposition (`DirichletL/Detector/ScalarTable.lean`, `DirichletL/Detector/HighRowsScalar.lean`, `DirichletL/Detector/HighRowsTail.lean`).
- [theorem_48_high_data_nine_budget_inequalities](../proofs/qrh_continuation_and_rescaling.lean#L449-L467): Simultaneous verification of all 9 budget inequalities in `HighData` (`DirichletL/Parameters.lean`, `DirichletL/ParametersHighData.lean`).
