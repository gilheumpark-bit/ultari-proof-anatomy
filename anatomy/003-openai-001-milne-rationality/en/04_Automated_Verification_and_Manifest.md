# Level 4: Automated Verification & Parser Specification: Verification Commands and Manifest

This specification provides exact reproduction commands, SHA-256 checksums, scope boundaries, and 1-to-1 line mappings for automated theorem provers, CI pipelines, and AI parsers.



## 1. Verification Commands

Run the following commands from the case root directory to reproduce all 36 Lean 4 kernel proofs (exit 0, 232/232 hypothesis mutations caught), the SymPy + PyTorch FP64 verification suite (Audits 1-7), and SHA-256 checksums:

```bash
# 1. Lean 4 kernel compilation (Theorems 1–16 and Theorems 17–36, exit 0, 0 warnings)
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



## 2. Artifact SHA-256 Checksums

| Relative Path | SHA-256 Checksum | Description |
| :--- | :--- | :--- |
| [proofs/milne_transport_and_filtration.lean](../proofs/milne_transport_and_filtration.lean) | `c17477cbcad1600730d9471a7c4691e5244f271f96b0cefb444649fd245c39b5` | Theorems 1-16 (Part I-III, VI-A), 0 sorry, 101/101 mutations caught |
| [proofs/milne_weil_reduction_and_repairs.lean](../proofs/milne_weil_reduction_and_repairs.lean) | `b84eb920fd468bf7a941f330cc8d9c732cf8d3bc759ce31646e33a81aa9ea874` | Theorems 17-36 (Part IV-V, VI-B, VII), 0 sorry, 131/131 mutations caught |
| [proofs/verify_symbolic_milne.py](../proofs/verify_symbolic_milne.py) | `5f74cd9cb7bed53f814e3711bea590452cdfe8ee0019b7273c422f38160f0140` | SymPy + PyTorch FP64 7-audit verifier (Audits 1-7) |
| [proofs/symbolic_verification_result.json](../proofs/symbolic_verification_result.json) | `068711cf9de4c2004a735e1f627b1d5e02268b851eb6b39f7284221480df6100` | Deterministic JSON output for Audits 1-7 |
| [proofs/problem_spec.md](../proofs/problem_spec.md) | `44f1c4cd6d38162ddc9fdebe061c8b8895fbcf21549e526eeb6f605cbc73cbab` | Forensic repair specification |
| [proofs/oai_001_milne_repair.patch](../proofs/oai_001_milne_repair.patch) | `529cf8b70667a8e48ffd8ae2c9eeea7cabfc341605f5816a72e7716a2df81886` | 234-line unified diff across 6 files (`references.tex` + 5 section files) |



## 3. Scope Notes

1. Boundary Between Formalized Dimension, Slope, Valuation, and Eigenspace Arithmetic and Scheme-Theoretic Cohomology:
   - The 36 theorems in [milne_transport_and_filtration.lean](../proofs/milne_transport_and_filtration.lean) and [milne_weil_reduction_and_repairs.lean](../proofs/milne_weil_reduction_and_repairs.lean) verify the exact integer/rational dimension, rank, slope-duality, Kronecker degree, valuation, and Beauville eigenspace identities over `Int` (232/232 hypothesis mutations caught).
   - The main proof of the rational Hodge conjecture for CM abelian varieties ([OAI26, Theorem 1.1]) is formalized in OpenAI's separate Lean 4 library (`ComparatorChallenges/HodgeConjectureCMAbelianVarieties/Solution.lean`).



## 4. 36 Lean 4 Theorems Line Summary

- [rational_pullback_clearing_multiplier_invariance](../proofs/milne_transport_and_filtration.lean#L26-L44): Theorem 1 (milne_transport_and_filtration.lean:L26-L44)
- [auxiliary_hodge_datum_torus_and_representation_dimensions](../proofs/milne_transport_and_filtration.lean#L53-L74): Theorem 2 (milne_transport_and_filtration.lean:L53-L74)
- [transport_common_rational_similitude_normalization](../proofs/milne_transport_and_filtration.lean#L82-L113): Theorem 3 (milne_transport_and_filtration.lean:L82-L113)
- [base_N_monomial_exponent_injective_2var](../proofs/milne_transport_and_filtration.lean#L118-L150): Theorem 4 (milne_transport_and_filtration.lean:L118-L150)
- [lemma_4_2_eisenstein_valuation_layer_uniqueness](../proofs/milne_transport_and_filtration.lean#L156-L189): Theorem 5 (milne_transport_and_filtration.lean:L156-L189)
- [lagrangian_grassmannian_incidence_and_duality](../proofs/milne_transport_and_filtration.lean#L196-L219): Theorem 6 (milne_transport_and_filtration.lean:L196-L219)
- [defect_supermodularity_and_maximizer_closure](../proofs/milne_transport_and_filtration.lean#L223-L232): Theorem 7 (milne_transport_and_filtration.lean:L223-L232)
- [block_slope_duality_newton_sum_identity](../proofs/milne_transport_and_filtration.lean#L235-L253): Theorem 8 (milne_transport_and_filtration.lean:L235-L253)
- [block_newton_hodge_weak_admissibility_bound](../proofs/milne_transport_and_filtration.lean#L256-L271): Theorem 9 (milne_transport_and_filtration.lean:L256-L271)
- [divisor_filtration_wedge_two_decomposition](../proofs/milne_transport_and_filtration.lean#L276-L313): Theorem 10 (milne_transport_and_filtration.lean:L276-L313)
- [modified_pairing_alternating_from_rosati_symmetry](../proofs/milne_transport_and_filtration.lean#L316-L323): Theorem 11 (milne_transport_and_filtration.lean:L316-L323)
- [modified_pairing_e_bilinear_from_conjugate_cancellation](../proofs/milne_transport_and_filtration.lean#L329-L336): Theorem 12 (milne_transport_and_filtration.lean:L329-L336)
- [modified_pairing_u_similitude_on_eigenspace](../proofs/milne_transport_and_filtration.lean#L341-L350): Theorem 13 (milne_transport_and_filtration.lean:L341-L350)
- [u_stable_b_lagrangian_implies_beta_lagrangian](../proofs/milne_transport_and_filtration.lean#L353-L360): Theorem 14 (milne_transport_and_filtration.lean:L353-L360)
- [hn_defect_symplectic_perp_invariance](../proofs/milne_transport_and_filtration.lean#L368-L376): Theorem 15 (milne_transport_and_filtration.lean:L368-L376)
- [lagrangian_perp_intersection_duality](../proofs/milne_transport_and_filtration.lean#L379-L392): Theorem 16 (milne_transport_and_filtration.lean:L379-L392)
- [weil_pairing_bidegree_saturation_on_conjugate_pair](../proofs/milne_weil_reduction_and_repairs.lean#L25-L37): Theorem 17 (milne_weil_reduction_and_repairs.lean:L25-L37)
- [non_invertible_u_kernel_radical_contradiction](../proofs/milne_weil_reduction_and_repairs.lean#L40-L50): Theorem 18 (milne_weil_reduction_and_repairs.lean:L40-L50)
- [weil_unitary_similitude_group_and_orbit_dimensions](../proofs/milne_weil_reduction_and_repairs.lean#L54-L73): Theorem 19 (milne_weil_reduction_and_repairs.lean:L54-L73)
- [weil_retraction_projector_cohomology_recovery](../proofs/milne_weil_reduction_and_repairs.lean#L79-L94): Theorem 20 (milne_weil_reduction_and_repairs.lean:L79-L94)
- [cm_balanced_idempotent_factor_dimensions](../proofs/milne_weil_reduction_and_repairs.lean#L98-L111): Theorem 21 (milne_weil_reduction_and_repairs.lean:L98-L111)
- [unbalanced_cm_subset_violates_hodge_bidegree](../proofs/milne_weil_reduction_and_repairs.lean#L114-L119): Theorem 22 (milne_weil_reduction_and_repairs.lean:L114-L119)
- [thm_6_2_cm_galois_orbit_partition](../proofs/milne_weil_reduction_and_repairs.lean#L126-L136): Theorem 23 (milne_weil_reduction_and_repairs.lean:L126-L136)
- [prop_4_8_breuil_kisin_rank_and_zero_defect](../proofs/milne_weil_reduction_and_repairs.lean#L144-L155): Theorem 24 (milne_weil_reduction_and_repairs.lean:L144-L155)
- [universal_weil_divisor_polynomial_pure_degree_separation](../proofs/milne_weil_reduction_and_repairs.lean#L158-L167): Theorem 25 (milne_weil_reduction_and_repairs.lean:L158-L167)
- [milne_001_internal_dependency_and_lefschetz_vs_chow_gap](../proofs/milne_weil_reduction_and_repairs.lean#L175-L190): Theorem 26 (milne_weil_reduction_and_repairs.lean:L175-L190)
- [first_factor_projector_retraction_pullback_chain](../proofs/milne_weil_reduction_and_repairs.lean#L198-L207): Theorem 27 (milne_weil_reduction_and_repairs.lean:L198-L207)
- [cor_6_3_frobenius_trace_rational_equality](../proofs/milne_weil_reduction_and_repairs.lean#L215-L235): Theorem 28 (milne_weil_reduction_and_repairs.lean:L215-L235)
- [repair_medium1_pointwise_kz_adlv_bypasses_glx26](../proofs/milne_weil_reduction_and_repairs.lean#L245-L256): Theorem 29 (milne_weil_reduction_and_repairs.lean:L245-L256)
- [repair_medium2_beauville_projector_canonical_cycle_invariance](../proofs/milne_weil_reduction_and_repairs.lean#L259-L270): Theorem 30 (milne_weil_reduction_and_repairs.lean:L259-L270)
- [repair_low1_ramified_dvr_unconditional_lifting_range](../proofs/milne_weil_reduction_and_repairs.lean#L278-L292): Theorem 31 (milne_weil_reduction_and_repairs.lean:L278-L292)
- [repair_low2_sharp_kronecker_bound_attained_3var](../proofs/milne_weil_reduction_and_repairs.lean#L296-L327): Theorem 32 (milne_weil_reduction_and_repairs.lean:L296-L327)
- [repair_low3_rosati_positive_definite_u2_eigenvalues_strictly_positive](../proofs/milne_weil_reduction_and_repairs.lean#L330-L336): Theorem 33 (milne_weil_reduction_and_repairs.lean:L330-L336)
- [lemma_2_1_comparison_isomorphism_and_tate_twist_compatibility](../proofs/milne_weil_reduction_and_repairs.lean#L342-L352): Theorem 34 (milne_weil_reduction_and_repairs.lean:L342-L352)
- [lemma_2_2_lefschetz_pairing_functoriality_and_projection_system](../proofs/milne_weil_reduction_and_repairs.lean#L358-L375): Theorem 35 (milne_weil_reduction_and_repairs.lean:L358-L375)
- [corollary_3_4_cm_transport_first_factor_pullback_recovery](../proofs/milne_weil_reduction_and_repairs.lean#L381-L394): Theorem 36 (milne_weil_reduction_and_repairs.lean:L381-L394)
