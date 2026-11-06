# [Tier 4: Automated Verification Spec] Verification Commands & Manifest

This document provides the verification commands and artifact hashes for automated theorem provers, CI pipelines, and code parsers inspecting this package.

---

## 1. Verification Commands

Execute the following commands from the package root directory to verify all 48 Lean 4 theorems (`exit 0`, zero `sorry`/`axiom`), reproduce the symbolic JSON output, and check SHA-256 integrity:

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

---

## 2. Artifact SHA-256 Hash List

| Relative Path | SHA-256 Checksum | Description |
| :--- | :--- | :--- |
| [`proofs/qrh_exponent_and_parameter_bounds.lean`](../proofs/qrh_exponent_and_parameter_bounds.lean) | `b04012886b320c1f6e32012638f81d2be0f7ea7c75001f44ce72ab5f8e7cc92c` | 404 lines, 27 Lean 4 theorems (`Theorem 1`~`Theorem 27`), `0` `sorry`, `0` custom `axiom`. |
| [`proofs/qrh_continuation_and_rescaling.lean`](../proofs/qrh_continuation_and_rescaling.lean) | `264ce426ee8cdd45eba29fecc35ece3eb71801a9d11e36560506b9357ae0faf9` | 466 lines, 21 Lean 4 theorems (`Theorem 28`~`Theorem 48`, Tasks 1–4 & 178-decl 1-to-1 audit), `0` `sorry`, `0` custom `axiom`. |
| [`proofs/verify_symbolic_qrh.py`](../proofs/verify_symbolic_qrh.py) | `cf71d7ddd3f56a8846dc6f6d58c179d2a1de1db8c5c5d0ab53ef168752942812` | Exact `SymPy`/`Fraction` symbolic solver extracting definitions directly from `./proofs/oai_ref/*.lean`. |
| [`proofs/symbolic_verification_result.json`](../proofs/symbolic_verification_result.json) | `072bdd831bd69aa096ea87eef639a6ac221051371cdbe80ea0ffa1b98c86bd55` | Exact rational/symbolic output dictionary for Problems 1 through 5. |
| [`proofs/problem_spec.md`](../proofs/problem_spec.md) | `1a57a59bb4bfec2cbd4bfd62316c31a21e6a756155f4b64016ecad09aa78bc58` | Problem specification referencing `./oai_ref/*.lean`. |

---

## 3. Scope Notes

1. **Formalized Rational/Integer Theorems vs. Future Complex-Analytic Extensions**:
   - The 48 theorems across [`proofs/qrh_exponent_and_parameter_bounds.lean`](../proofs/qrh_exponent_and_parameter_bounds.lean) (Theorems 1–27) and [`proofs/qrh_continuation_and_rescaling.lean`](../proofs/qrh_continuation_and_rescaling.lean) (Theorems 28–48) are kernel-verified over `Rat`, `Int`, and `Nat` (covering algebraic parameter budgets, SOS decompositions, $m \ge 2$ Gauss branch vanishing, exact componentwise Gram exponent differences $\frac{215}{3264}$ and $\frac{487}{3264}$, $(w,z)$ contour-shift exponent budgets, universal 2nd/3rd Euler continuation polynomial cancellations, master scale-coupling equations, and the complete 26-file / 178-declaration 1-to-1 formal audit including Siegel zero local Bézout cone homogenization and arithmetic cutoff transport).
   - They do **not** formalize the continuous complex-analytic Mellin contour integrals for the separated $m=1$ finite terms or Hilbert-space trace-class operator bounds. Do not summarize this package as a complete unconditional proof of the full Riemann Hypothesis.
2. **JSON Manifest**:
   - Parse [`manifest.json`](../manifest.json) for programmatic access to all theorem identifiers, line numbers, verified fractions, and SHA-256 hashes.

### 3.6 Section 6 (Anatomy & Completion of Tasks 1–4: Theorems 28–48, [`proofs/qrh_continuation_and_rescaling.lean`](../proofs/qrh_continuation_and_rescaling.lean))
- [`theorem_28_marked_factor_singularity_cancels_identically`](../proofs/qrh_continuation_and_rescaling.lean#L66-L77): Universal `∀ (R V qInv K W D : Int)` polynomial cancellation of the $(1-V)$ factor in `markedFactor` and reduction of the central quotient threshold from $480$ to $112$.
- [`theorem_29_all_small_eisenstein_norms_nonvanishing`](../proofs/qrh_continuation_and_rescaling.lean#L84-L91): Non-vanishing of Euler denominators across all 21 small Eisenstein prime-power norms in $4 \le Q < 112$.
- [`theorem_30_universal_finite_bad_prime_mask_absorption`](../proofs/qrh_continuation_and_rescaling.lean#L96-L100): Universal `∀` absorption law for finite bad-prime masks $S = S_0 \cup \text{smallPrimeSet}(N)$.
- [`theorem_31_second_continuation_exact_polynomial_identity`](../proofs/qrh_continuation_and_rescaling.lean#L109-L113): Universal `∀ (R V qInv K W D : Int)` 5-term cancellation identity for `secondContinuedCorrection`.
- [`theorem_32_second_and_third_continuation_convergence_barrier`](../proofs/qrh_continuation_and_rescaling.lean#L122-L141): Reduction of the Euler-tail $z_{\text{re}}$ convergence barrier from $97/300$ to $97/600 \approx 0.16167 < 1/6$ (`-(53/50) = -1.06 < -1` at $z = 1/6$).
- [`theorem_33_central_exponent_z0_invariance_at_d0`](../proofs/qrh_continuation_and_rescaling.lean#L148-L163): Exact $z_0$-invariance of `sourceExponent` at $d_0 = 13/16$ (coefficient $0$) and $-13/240$ exponent shift ($-49/14400 \to -829/14400$) at $d = 1/2$.
- [`theorem_34_universal_z0_shift_improves_subcritical_d`](../proofs/qrh_continuation_and_rescaling.lean#L169-L179): Universal `∀` improvement of `sourceExponent` for all $d < 1 + \ell - \alpha_X$ when $z_0' < z_0$.
- [`theorem_35_master_scale_coupling_identities`](../proofs/qrh_continuation_and_rescaling.lean#L189-L203): Master scale-coupling identities for `-11/16`, `3/16`, and $\beta_{\text{crit}}(\alpha_X, \alpha_Y, \ell) = \frac{5}{6} + \frac{\alpha_X + \alpha_Y - 2\ell}{12}$.
- [`theorem_36_regime_A_sos_slack_rescaling_and_conductor_split`](../proofs/qrh_continuation_and_rescaling.lean#L212-L232): Derivation of $\beta_{\text{crit}} = 128519/146880 < 7/8$ on the active `DirichletL/Detector/LowSourceScales.lean:80-104` path using existing SOS slack vs. $\beta_{\text{crit}} = 7/8$ invariance under simultaneous `DirichletL/Parameters.lean:14` split shifting.
- [`theorem_37_regime_B_gram_unbundled_and_diagonal_beta_bounds`](../proofs/qrh_continuation_and_rescaling.lean#L239-L252): Proof of $\beta_{\text{crit}} = 5/6, 3/4, 69/100$ under unbundled and diagonal Gram bounds.
- [`theorem_38_universal_beta_crit_monotonicity`](../proofs/qrh_continuation_and_rescaling.lean#L258-L268): Universal `∀` monotonicity of $\beta_{\text{crit}}$ preserving Poisson admissibility.
- [`theorem_39_m1_sextic_pole_residue_and_33_200_remainder_saving`](../proofs/qrh_continuation_and_rescaling.lean#L274-L284): Exact Mellin pole-shift remainder savings (`-13/9600`, `-17/48000`) across the sextic Gauss pole $z = 1/6$.
- [`theorem_40_energy_induction_compatible_below_seven_eighths`](../proofs/qrh_continuation_and_rescaling.lean#L289-L298): Compatibility of `DirichletL/Energy/CertifiedExistence.lean:19-48` across all $\beta \in [51/100, 7/8]$.
- [`theorem_41_bezout_homogenized_cone_and_degree_bounds`](../proofs/qrh_continuation_and_rescaling.lean#L311-L319): Universal `∀` local isolated Bézout homogenized cone dimension `h < 5` and 4-variable box degree bound `4*(N-1) < 4*N` (`SiegelZeros/Intersection/IsolatedBezoutFromRegularSelection.lean`, `SiegelZeros/Structure/ArithmeticCutoffTransport.lean`).
- [`theorem_42_arithmetic_cutoff_and_pigeonhole_incompatibility`](../proofs/qrh_continuation_and_rescaling.lean#L329-L344): 4-step derivative ideal pigeonhole (`b < 4`), cutoff coefficient `96 = 3 * 32`, and height-3 length incompatibility `32^3 = 32768 > 4^3 = 64` (`SiegelZeros/Structure/ArithmeticCutoffTransport.lean`).
- [`theorem_43_biquadratic_galois_and_pivot_constants`](../proofs/qrh_continuation_and_rescaling.lean#L351-L363): Biquadratic field rank `4`, `c₁ = 1/37636`, `C₁ = 192`, `N₀ = 18818`, `H = 86713344`, and greedy pivot weight ratio `(C₁/c₁)/H = 1/12` (`SiegelZeros/Selection/PivotBounds.lean`, `SiegelZeros/Estimates/GeometricBoundary.lean`, `SiegelZeros/Intersection/BezoutBoundary.lean`, `SiegelZeros/Conclusions/Theorem.lean`).
- [`theorem_44_local_compensated_replacement_and_cancellation`](../proofs/qrh_continuation_and_rescaling.lean#L372-L381): Universal `∀ (V W D Pstar B q : Int)` local defect polynomial identity and ramified compensation cancellation (`DirichletL/Detector/Local.lean`).
- [`theorem_45_euler_resummation_and_correction_bounds`](../proofs/qrh_continuation_and_rescaling.lean#L389-L400): Resolvent bound `2` and error multipliers `12` and `4` in `unramified_marked_error_bound` (`DirichletL/Detector/Euler.lean`, `DirichletL/Detector/CorrectionBounds.lean`).
- [`theorem_46_euler_coordinates_and_unramified_factorization`](../proofs/qrh_continuation_and_rescaling.lean#L409-L423): Central contour `Q`-exponents of `coordV, coordR, coordW, coordD, coordK` and `3 * 480 = 1440` (`DirichletL/Detector/EulerCoordinates.lean`, `DirichletL/Detector/HighRowsUnramified.lean`, `DirichletL/Detector/HighRowsCentralQuotient.lean`).
- [`theorem_47_sextic_gauss_valuation_table_and_high_rows_scalar`](../proofs/qrh_continuation_and_rescaling.lean#L431-L438): Universal `∀ (r m j d : Nat)` mod-6 periodicity and unique index decomposition (`DirichletL/Detector/ScalarTable.lean`, `DirichletL/Detector/HighRowsScalar.lean`, `DirichletL/Detector/HighRowsTail.lean`).
- [`theorem_48_high_data_nine_budget_inequalities`](../proofs/qrh_continuation_and_rescaling.lean#L446-L464): Simultaneous verification of all 9 budget inequalities in `HighData` (`DirichletL/Parameters.lean`, `DirichletL/ParametersHighData.lean`).
