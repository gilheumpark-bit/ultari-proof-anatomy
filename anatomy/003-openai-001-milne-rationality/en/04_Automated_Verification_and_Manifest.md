# [Level 4: Automated Verification & Parser Specification]

This specification provides exact reproduction commands, SHA-256 checksums, scope boundaries, and 1-to-1 line mappings for automated theorem provers, CI pipelines, and AI parsers.

---

## 1. Verification Commands

Run the following commands from the package root directory to reproduce all 33 Lean 4 kernel proofs (`exit 0`, `211/211` hypothesis mutations caught), the SymPy + PyTorch verification suite (`Audit 1–7`), and SHA-256 checksums:

```bash
# 1. Lean 4 kernel compilation (Theorems 1–16 and Theorems 17–33, exit 0, 0 warnings)
lean proofs/milne_transport_and_filtration.lean
lean proofs/milne_weil_reduction_and_repairs.lean

# 2. Symbolic & PyTorch solver execution and deterministic JSON check
cd proofs && python3 verify_symbolic_milne.py && cd ..

# 3. SHA-256 checksum verification across all 6 core proof artifacts
sha256sum proofs/milne_transport_and_filtration.lean \
          proofs/milne_weil_reduction_and_repairs.lean \
          proofs/verify_symbolic_milne.py \
          proofs/symbolic_verification_result.json \
          proofs/problem_spec.md \
          proofs/oai_001_milne_repair.patch
```

---

## 2. Artifact SHA-256 Checksums

| Relative Path | SHA-256 Checksum | Description |
| :--- | :--- | :--- |
| [`proofs/milne_transport_and_filtration.lean`](../proofs/milne_transport_and_filtration.lean) | `a97d2b96faa7d0124f0b4e239036509a80c60f0515f771f18a2cccf953542591` | Theorems 1–16 (`Part I–III, VI-A`), `0 sorry`, `101/101` mutations caught |
| [`proofs/milne_weil_reduction_and_repairs.lean`](../proofs/milne_weil_reduction_and_repairs.lean) | `19c47d7ee3025dbb667d9d59eb00513f5c4625e3cfc87740ec0d11997a88a860` | Theorems 17–33 (`Part IV–V, VI-B, VII`), `0 sorry`, `110/110` mutations caught |
| [`proofs/verify_symbolic_milne.py`](../proofs/verify_symbolic_milne.py) | `6e6e313248fc9aa8d2bf65994b912c6037f9bbe0aa4c5111dae9c2b354aa7147` | SymPy + PyTorch PyTorch 7-audit verifier (`Audit 1–7`) |
| [`proofs/symbolic_verification_result.json`](../proofs/symbolic_verification_result.json) | `068711cf9de4c2004a735e1f627b1d5e02268b851eb6b39f7284221480df6100` | Deterministic JSON output for Audits 1–7 |
| [`proofs/problem_spec.md`](../proofs/problem_spec.md) | `935a2f7f40e155f23fe6fad022a2f18b1523aa790d1d3fd794198b1306569a1e` | Forensic repair specification (`PARAMETER_ARITHMETIC_ONLY`) |
| [`proofs/oai_001_milne_repair.patch`](../proofs/oai_001_milne_repair.patch) | `529cf8b70667a8e48ffd8ae2c9eeea7cabfc341605f5816a72e7716a2df81886` | 234-line unified diff across 6 LaTeX sections |

---

## 3. Scope Notes (`PARAMETER_ARITHMETIC_ONLY`)

1. **Boundary Between Category A (Formalized Dimension, Slope, Valuation, and Eigenspace Arithmetic) and Category B (Scheme-Theoretic Cohomology)**:
   - The 33 theorems in [`milne_transport_and_filtration.lean`](../proofs/milne_transport_and_filtration.lean) and [`milne_weil_reduction_and_repairs.lean`](../proofs/milne_weil_reduction_and_repairs.lean) verify the exact integer/rational dimension, rank, slope-duality, Kronecker degree, valuation, and Beauville eigenspace identities (`211/211` hypothesis mutations caught).

---

## 4. 33 Lean 4 Theorems Line Summary

- [`rational_pullback_clearing_multiplier_invariance`](../proofs/milne_transport_and_filtration.lean#L20-L36): Theorem 1 (`milne_transport_and_filtration.lean:L20-L36`)
- [`auxiliary_hodge_datum_torus_and_representation_dimensions`](../proofs/milne_transport_and_filtration.lean#L45-L66): Theorem 2 (`milne_transport_and_filtration.lean:L45-L66`)
- [`transport_common_rational_similitude_normalization`](../proofs/milne_transport_and_filtration.lean#L74-L100): Theorem 3 (`milne_transport_and_filtration.lean:L74-L100`)
- [`base_N_monomial_exponent_injective_2var`](../proofs/milne_transport_and_filtration.lean#L110-L142): Theorem 4 (`milne_transport_and_filtration.lean:L110-L142`)
- [`lemma_4_2_eisenstein_valuation_layer_uniqueness`](../proofs/milne_transport_and_filtration.lean#L148-L181): Theorem 5 (`milne_transport_and_filtration.lean:L148-L181`)
- [`lagrangian_grassmannian_incidence_and_duality`](../proofs/milne_transport_and_filtration.lean#L188-L206): Theorem 6 (`milne_transport_and_filtration.lean:L188-L206`)
- [`defect_supermodularity_and_maximizer_closure`](../proofs/milne_transport_and_filtration.lean#L215-L224): Theorem 7 (`milne_transport_and_filtration.lean:L215-L224`)
- [`block_slope_duality_newton_sum_identity`](../proofs/milne_transport_and_filtration.lean#L227-L245): Theorem 8 (`milne_transport_and_filtration.lean:L227-L245`)
- [`block_newton_hodge_weak_admissibility_bound`](../proofs/milne_transport_and_filtration.lean#L248-L263): Theorem 9 (`milne_transport_and_filtration.lean:L248-L263`)
- [`divisor_filtration_wedge_two_decomposition`](../proofs/milne_transport_and_filtration.lean#L268-L299): Theorem 10 (`milne_transport_and_filtration.lean:L268-L299`)
- [`modified_pairing_alternating_from_rosati_symmetry`](../proofs/milne_transport_and_filtration.lean#L307-L314): Theorem 11 (`milne_transport_and_filtration.lean:L307-L314`)
- [`modified_pairing_e_bilinear_from_conjugate_cancellation`](../proofs/milne_transport_and_filtration.lean#L320-L327): Theorem 12 (`milne_transport_and_filtration.lean:L320-L327`)
- [`modified_pairing_u_similitude_on_eigenspace`](../proofs/milne_transport_and_filtration.lean#L332-L341): Theorem 13 (`milne_transport_and_filtration.lean:L332-L341`)
- [`u_stable_b_lagrangian_implies_beta_lagrangian`](../proofs/milne_transport_and_filtration.lean#L344-L351): Theorem 14 (`milne_transport_and_filtration.lean:L344-L351`)
- [`hn_defect_symplectic_perp_invariance`](../proofs/milne_transport_and_filtration.lean#L359-L367): Theorem 15 (`milne_transport_and_filtration.lean:L359-L367`)
- [`lagrangian_perp_intersection_duality`](../proofs/milne_transport_and_filtration.lean#L370-L381): Theorem 16 (`milne_transport_and_filtration.lean:L370-L381`)
- [`weil_pairing_bidegree_saturation_on_conjugate_pair`](../proofs/milne_weil_reduction_and_repairs.lean#L16-L28): Theorem 17 (`milne_weil_reduction_and_repairs.lean:L16-L28`)
- [`non_invertible_u_kernel_radical_contradiction`](../proofs/milne_weil_reduction_and_repairs.lean#L31-L41): Theorem 18 (`milne_weil_reduction_and_repairs.lean:L31-L41`)
- [`weil_unitary_similitude_group_and_orbit_dimensions`](../proofs/milne_weil_reduction_and_repairs.lean#L45-L62): Theorem 19 (`milne_weil_reduction_and_repairs.lean:L45-L62`)
- [`weil_retraction_projector_cohomology_recovery`](../proofs/milne_weil_reduction_and_repairs.lean#L68-L78): Theorem 20 (`milne_weil_reduction_and_repairs.lean:L68-L78`)
- [`cm_balanced_idempotent_factor_dimensions`](../proofs/milne_weil_reduction_and_repairs.lean#L87-L100): Theorem 21 (`milne_weil_reduction_and_repairs.lean:L87-L100`)
- [`unbalanced_cm_subset_violates_hodge_bidegree`](../proofs/milne_weil_reduction_and_repairs.lean#L103-L108): Theorem 22 (`milne_weil_reduction_and_repairs.lean:L103-L108`)
- [`thm_6_2_cm_galois_orbit_partition`](../proofs/milne_weil_reduction_and_repairs.lean#L115-L125): Theorem 23 (`milne_weil_reduction_and_repairs.lean:L115-L125`)
- [`prop_4_8_breuil_kisin_rank_and_zero_defect`](../proofs/milne_weil_reduction_and_repairs.lean#L133-L144): Theorem 24 (`milne_weil_reduction_and_repairs.lean:L133-L144`)
- [`universal_weil_divisor_polynomial_pure_degree_separation`](../proofs/milne_weil_reduction_and_repairs.lean#L147-L156): Theorem 25 (`milne_weil_reduction_and_repairs.lean:L147-L156`)
- [`milne_001_internal_dependency_and_lefschetz_vs_chow_gap`](../proofs/milne_weil_reduction_and_repairs.lean#L164-L174): Theorem 26 (`milne_weil_reduction_and_repairs.lean:L164-L174`)
- [`first_factor_projector_retraction_pullback_chain`](../proofs/milne_weil_reduction_and_repairs.lean#L187-L196): Theorem 27 (`milne_weil_reduction_and_repairs.lean:L187-L196`)
- [`cor_6_3_frobenius_trace_rational_equality`](../proofs/milne_weil_reduction_and_repairs.lean#L204-L219): Theorem 28 (`milne_weil_reduction_and_repairs.lean:L204-L219`)
- [`repair_medium1_pointwise_kz_adlv_bypasses_glx26`](../proofs/milne_weil_reduction_and_repairs.lean#L234-L245): Theorem 29 (`milne_weil_reduction_and_repairs.lean:L234-L245`)
- [`repair_medium2_beauville_projector_canonical_cycle_invariance`](../proofs/milne_weil_reduction_and_repairs.lean#L248-L259): Theorem 30 (`milne_weil_reduction_and_repairs.lean:L248-L259`)
- [`repair_low1_ramified_dvr_unconditional_lifting_range`](../proofs/milne_weil_reduction_and_repairs.lean#L267-L281): Theorem 31 (`milne_weil_reduction_and_repairs.lean:L267-L281`)
- [`repair_low2_sharp_kronecker_bound_attained_3var`](../proofs/milne_weil_reduction_and_repairs.lean#L285-L314): Theorem 32 (`milne_weil_reduction_and_repairs.lean:L285-L314`)
- [`repair_low3_rosati_positive_definite_u2_eigenvalues_strictly_positive`](../proofs/milne_weil_reduction_and_repairs.lean#L317-L323): Theorem 33 (`milne_weil_reduction_and_repairs.lean:L317-L323`)
