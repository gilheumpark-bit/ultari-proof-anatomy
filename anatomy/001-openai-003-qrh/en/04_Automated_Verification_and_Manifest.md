# [Tier 4: Automated Verification Spec] Verification Commands & Manifest

This document provides the verification commands and artifact hashes for automated theorem provers, CI pipelines, and code parsers inspecting this package.

---

## 1. Verification Commands

Execute the following commands from the package root directory to verify all 40 Lean 4 theorems (`exit 0`, zero `sorry`/`axiom`), reproduce the symbolic JSON output, and check SHA-256 integrity:

```bash
# 1. Verify formal Lean 4 proofs (Theorems 1-27 & Theorems 28-40, must exit with code 0)
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
| [`proofs/qrh_exponent_and_parameter_bounds.lean`](../proofs/qrh_exponent_and_parameter_bounds.lean) | `abf95211c03d963ad7fc3b15f17e7700d21b8619a65e085d0de6abb0412de331` | 404 lines, 27 Lean 4 theorems (`Theorem 1`~`Theorem 27`), `0` `sorry`, `0` custom `axiom`. |
| [`proofs/qrh_continuation_and_rescaling.lean`](../proofs/qrh_continuation_and_rescaling.lean) | `73b33ec6bbe128261f3c375e7be16cc6d061f938e0d3900b1b939e864bc2670b` | 300 lines, 13 Lean 4 theorems (`Theorem 28`~`Theorem 40`, Tasks 1–3), `0` `sorry`, `0` custom `axiom`. |
| [`proofs/verify_symbolic_qrh.py`](../proofs/verify_symbolic_qrh.py) | `eb6aa899fc90e494cbd1a854dfdae67e3aee5e413c82a48d4452a372ac485e1e` | Exact `SymPy`/`Fraction` symbolic solver extracting definitions directly from `./proofs/oai_ref/*.lean`. |
| [`proofs/symbolic_verification_result.json`](../proofs/symbolic_verification_result.json) | `441dace0d0495b439cf50dcb32d892e2dd0070de65c8f1827db3a66ab2b65761` | Exact rational/symbolic output dictionary for Problems 1 through 5. |
| [`proofs/problem_spec.md`](../proofs/problem_spec.md) | `5ae4e1fb1a972d9438e43e293efbd18a2315343c91d30fc4114273e74914cabf` | Problem specification referencing `./oai_ref/*.lean`. |

---

## 3. Scope Notes

1. **Formalized Rational/Integer Theorems vs. Future Complex-Analytic Extensions**:
   - The 40 theorems across [`proofs/qrh_exponent_and_parameter_bounds.lean`](../proofs/qrh_exponent_and_parameter_bounds.lean) (Theorems 1–27) and [`proofs/qrh_continuation_and_rescaling.lean`](../proofs/qrh_continuation_and_rescaling.lean) (Theorems 28–40) are kernel-verified over `Rat`, `Int`, and `Nat` (covering algebraic parameter budgets, SOS decompositions, $m \ge 2$ Gauss branch vanishing, $592.35\times$ / $1341.73\times$ componentwise Gram exponent differences, $(w,z)$ contour-shift exponent budgets, universal 2nd/3rd Euler continuation polynomial cancellations, and master scale-coupling equations).
   - They do **not** formalize the continuous complex-analytic Mellin contour integrals for the separated $m=1$ finite terms or Hilbert-space trace-class operator bounds. Do not summarize this package as a complete unconditional proof of the full Riemann Hypothesis.
2. **JSON Manifest**:
   - Parse [`manifest.json`](../manifest.json) for programmatic access to all theorem identifiers, line numbers, verified fractions, and SHA-256 hashes.

### 3.6 Section 6 (Anatomy & Completion of Tasks 1–3: Theorems 28–40, [`proofs/qrh_continuation_and_rescaling.lean`](../proofs/qrh_continuation_and_rescaling.lean))
- [`theorem_28_marked_factor_singularity_cancels_identically`](../proofs/qrh_continuation_and_rescaling.lean#L66-L77): Universal `∀ (R V qInv K W D : Int)` polynomial cancellation of the $(1-V)$ factor in `markedFactor` and reduction of the central quotient threshold from $480$ to $112$.
- [`theorem_29_all_small_eisenstein_norms_nonvanishing`](../proofs/qrh_continuation_and_rescaling.lean#L84-L91): Non-vanishing of Euler denominators across all 21 small Eisenstein prime-power norms in $4 \le Q < 112$.
- [`theorem_30_universal_finite_bad_prime_mask_absorption`](../proofs/qrh_continuation_and_rescaling.lean#L96-L100): Universal `∀` absorption law for finite bad-prime masks $S = S_0 \cup \text{smallPrimeSet}(N)$.
- [`theorem_31_second_continuation_exact_polynomial_identity`](../proofs/qrh_continuation_and_rescaling.lean#L109-L113): Universal `∀ (R V qInv K W D : Int)` 5-term cancellation identity for `secondContinuedCorrection`.
- [`theorem_32_second_and_third_continuation_convergence_barrier`](../proofs/qrh_continuation_and_rescaling.lean#L122-L141): Reduction of the Euler-tail $z_{\text{re}}$ convergence barrier from $97/300$ to $97/600 \approx 0.16167 < 1/6$ (`-(53/50) = -1.06 < -1` at $z = 1/6$).
- [`theorem_33_central_exponent_z0_invariance_at_d0`](../proofs/qrh_continuation_and_rescaling.lean#L148-L163): Exact $z_0$-invariance of `sourceExponent` at $d_0 = 13/16$ (coefficient $0$) and $16.92\times$ margin strengthening at $d = 1/2$.
- [`theorem_34_universal_z0_shift_improves_subcritical_d`](../proofs/qrh_continuation_and_rescaling.lean#L169-L179): Universal `∀` improvement of `sourceExponent` for all $d < 1 + \ell - \alpha_X$ when $z_0' < z_0$.
- [`theorem_35_master_scale_coupling_identities`](../proofs/qrh_continuation_and_rescaling.lean#L189-L203): Master scale-coupling identities for `-11/16`, `3/16`, and $\beta_{\text{crit}}(\alpha_X, \alpha_Y, \ell) = \frac{5}{6} + \frac{\alpha_X + \alpha_Y - 2\ell}{12}$.
- [`theorem_36_regime_A_sos_slack_rescaling_and_conductor_split`](../proofs/qrh_continuation_and_rescaling.lean#L212-L232): Derivation of $\beta_{\text{crit}} = 128519/146880 < 7/8$ on the active `LowSourceScales.lean:80-104` path using existing SOS slack vs. $\beta_{\text{crit}} = 7/8$ invariance under simultaneous `Parameters.lean:14` split shifting.
- [`theorem_37_regime_B_gram_unbundled_and_diagonal_beta_bounds`](../proofs/qrh_continuation_and_rescaling.lean#L239-L252): Proof of $\beta_{\text{crit}} = 5/6, 3/4, 69/100$ under unbundled and diagonal Gram bounds.
- [`theorem_38_universal_beta_crit_monotonicity`](../proofs/qrh_continuation_and_rescaling.lean#L258-L268): Universal `∀` monotonicity of $\beta_{\text{crit}}$ preserving Poisson admissibility.
- [`theorem_39_m1_sextic_pole_residue_and_33_200_remainder_saving`](../proofs/qrh_continuation_and_rescaling.lean#L274-L284): Exact Mellin pole-shift remainder savings (`-13/9600`, `-17/48000`) across the sextic Gauss pole $z = 1/6$.
- [`theorem_40_energy_induction_compatible_below_seven_eighths`](../proofs/qrh_continuation_and_rescaling.lean#L289-L298): Compatibility of `Energy/CertifiedExistence.lean:19-48` across all $\beta \in [51/100, 7/8]$.
