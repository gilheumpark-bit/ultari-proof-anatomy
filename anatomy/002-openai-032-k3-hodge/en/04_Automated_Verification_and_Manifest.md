# [Level 4: Automated Verification & AI Parser Specification] Verification Commands and Manifest

This specification defines the deterministic verification commands, SHA-256 artifact ledger, and theorem line-number mappings for automated theorem provers (ATPs), CI pipelines, and AI parsers.

---

## 1. Verification Commands

Run the following commands from the case root directory to reproduce all 35 Lean 4 kernel proofs (`exit 0`), SymPy symbolic output, and SHA-256 checksums:

```bash
# 1. Lean 4 kernel compilation check (Theorems 1-35, 0 sorry, 0 axiom)
lean proofs/k3_forensic_paths.lean

# 2. Symbolic solver reproduction check
cd proofs && python3 verify_symbolic_k3.py && cd ..

# 3. SHA-256 checksum verification
sha256sum proofs/k3_forensic_paths.lean \
          proofs/verify_symbolic_k3.py \
          proofs/symbolic_verification_result.json \
          proofs/problem_spec.md \
          proofs/oai_032_cm_remark_7_5_repair.patch
```

---

## 2. Artifact SHA-256 Ledger

| Relative Path | SHA-256 Checksum | Description |
| :--- | :--- | :--- |
| [`proofs/k3_forensic_paths.lean`](../proofs/k3_forensic_paths.lean) | `8b57f0fa6e79d0a0d49b6230ac4b52dc21f98bbed167914387b7b2512c908b77` | 614 lines, 35 Lean 4 theorems (`Theorem 1`..`Theorem 35`), `0 sorry`, `0 axiom`, `135/135 caught` |
| [`proofs/verify_symbolic_k3.py`](../proofs/verify_symbolic_k3.py) | `1e60a48a91737a36304f8c94b850a8d2325984292c6a7ea76f4fe3e8061b12be` | Independent SymPy symbolic solver for Problems 1-5 |
| [`proofs/symbolic_verification_result.json`](../proofs/symbolic_verification_result.json) | `2a37ad786b30352aeae5a11904cc69b2a195b70708e874ac37cf7b5579614d1a` | Deterministic JSON output for Problems 1-5 |
| [`proofs/problem_spec.md`](../proofs/problem_spec.md) | `82307dd0f1f6c3c33b376af161a8660f20037e092689b36eb09ccdbeb3316b74` | Specification of Problems 1-5 |
| [`proofs/oai_032_cm_remark_7_5_repair.patch`](../proofs/oai_032_cm_remark_7_5_repair.patch) | `ecff86170caccd553c2186df6e393655330c7e291eb9ea8fd19b78c2e96f77f8` | Surgical TeX repair patch for Remark 7.5 of the Oct 8 CM paper |

---

## 3. Theorem Line Index ([`proofs/k3_forensic_paths.lean`](../proofs/k3_forensic_paths.lean))

- [`odd_maslov_degree_sign_always_negative`](../proofs/k3_forensic_paths.lean#L21-L35)
- [`odd_degree_trace_sign_always_opposite`](../proofs/k3_forensic_paths.lean#L36-L53)
- [`eliashberg_murphy_cancellation_fails`](../proofs/k3_forensic_paths.lean#L54-L63)
- [`polterovich_surgery_maslov_obstruction`](../proofs/k3_forensic_paths.lean#L64-L71)
- [`even_branch_generator_avoids_degree_two`](../proofs/k3_forensic_paths.lean#L72-L83)
- [`exactks_4_7_10_degree_separation`](../proofs/k3_forensic_paths.lean#L84-L91)
- [`auxiliary_6_9_12_degree_separation`](../proofs/k3_forensic_paths.lean#L92-L98)
- [`semiregularity_injective_squeeze`](../proofs/k3_forensic_paths.lean#L99-L111)
- [`zero_transcendental_component_breaks_ext2_bound`](../proofs/k3_forensic_paths.lean#L112-L121)
- [`shioda_inose_split_sum_obstruction_rank`](../proofs/k3_forensic_paths.lean#L122-L136)
- [`yoneda_cone_atiyah_rank_no_go`](../proofs/k3_forensic_paths.lean#L137-L153)
- [`eems_poincare_hopf_and_maslov_degrees`](../proofs/k3_forensic_paths.lean#L154-L178)
- [`eems_chi_zero_stabilization_no_go`](../proofs/k3_forensic_paths.lean#L179-L190)
- [`maurer_cartan_forward_trace_obstruction`](../proofs/k3_forensic_paths.lean#L191-L199)
- [`kummer_bkr_untwisted_deficit_and_clifford_gap`](../proofs/k3_forensic_paths.lean#L200-L213)
- [`semihomogeneous_rank21_diagonal_ext2_overflow`](../proofs/k3_forensic_paths.lean#L214-L230)
- [`eems_opposite_sign_and_stokes_blindness`](../proofs/k3_forensic_paths.lean#L231-L245)
- [`kummer_bkr_fixed_point_atiyah_vanishing`](../proofs/k3_forensic_paths.lean#L246-L259)
- [`bogomolov_mixed_discriminant_sign_flip_no_go`](../proofs/k3_forensic_paths.lean#L260-L272)
- [`clifford_spin_endomorphism_ext2_explosion`](../proofs/k3_forensic_paths.lean#L273-L293)
- [`walsh_hadamard_decoupling_diagonal_ext2_no_go`](../proofs/k3_forensic_paths.lean#L294-L315)
- [`ample_koszul_4_term_diagonal_and_section_overflow`](../proofs/k3_forensic_paths.lean#L316-L340)
- [`mukai_semihomogeneous_projective_flatness_barrier`](../proofs/k3_forensic_paths.lean#L341-L372)
- [`markman_secant_mukai_dimension_gap`](../proofs/k3_forensic_paths.lean#L373-L393)
- [`additivity_vs_hyperkahler_rigidity_circularity`](../proofs/k3_forensic_paths.lean#L394-L426)
- [`universal_mumford_diagonal_overflow_for_all_g_and_M`](../proofs/k3_forensic_paths.lean#L427-L456)
- [`universal_g1_branch_stokes_and_kummer_moduli_no_go`](../proofs/k3_forensic_paths.lean#L457-L480)
- [`clifford_octonion_matrix_generation_and_skew_product`](../proofs/k3_forensic_paths.lean#L481-L498)
- [`kuga_satake_cup_kernel_and_total_h2_dimension`](../proofs/k3_forensic_paths.lean#L499-L518)
- [`split_eightfold_weil_class_and_nilmanifold_dimensions`](../proofs/k3_forensic_paths.lean#L519-L540)
- [`eightfold_a_infinity_virtual_dimension_and_mod4_curvature`](../proofs/k3_forensic_paths.lean#L541-L559)
- [`theta_ring_nine_lines_and_periodic_module_grading`](../proofs/k3_forensic_paths.lean#L560-L575)
- [`mixed_product_graph_coboundary_and_cycle_sign_invariance`](../proofs/k3_forensic_paths.lean#L576-L587)
- [`directed_comparison_and_chain_acyclicity_thresholds`](../proofs/k3_forensic_paths.lean#L588-L603)
- [`cm_remark_7_5_beauville_projector_denominator_invariance`](../proofs/k3_forensic_paths.lean#L604-L612)
