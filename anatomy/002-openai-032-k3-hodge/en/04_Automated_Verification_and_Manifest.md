# [Level 4: Automated Verification & AI Parser Specification] Verification Commands and Manifest

This specification defines the deterministic verification commands, SHA-256 artifact ledger, and theorem line-number mappings for automated theorem provers (ATPs), CI pipelines, and AI parsers.

---

## 1. Verification Commands

Run the following commands from the case root directory to reproduce all 25 Lean 4 kernel proofs (`exit 0`), SymPy symbolic output, and SHA-256 checksums:

```bash
# 1. Lean 4 kernel compilation check (Theorems 1-27, 0 sorry, 0 axiom)
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
| [`proofs/k3_forensic_paths.lean`](../proofs/k3_forensic_paths.lean) | `ae0d351013e44771f402000243a2d5d10d86df592a38df3ad21c576c9c735bb4` | 452 lines, 27 Lean 4 theorems (`Theorem 1`..`Theorem 27`), `0 sorry`, `0 axiom`, `112/112 caught` |
| [`proofs/verify_symbolic_k3.py`](../proofs/verify_symbolic_k3.py) | `1e60a48a91737a36304f8c94b850a8d2325984292c6a7ea76f4fe3e8061b12be` | Independent SymPy symbolic solver for Problems 1-5 |
| [`proofs/symbolic_verification_result.json`](../proofs/symbolic_verification_result.json) | `2a37ad786b30352aeae5a11904cc69b2a195b70708e874ac37cf7b5579614d1a` | Deterministic JSON output for Problems 1-5 |
| [`proofs/problem_spec.md`](../proofs/problem_spec.md) | `82307dd0f1f6c3c33b376af161a8660f20037e092689b36eb09ccdbeb3316b74` | Specification of Problems 1-5 |
| [`proofs/oai_032_cm_remark_7_5_repair.patch`](../proofs/oai_032_cm_remark_7_5_repair.patch) | `ecff86170caccd553c2186df6e393655330c7e291eb9ea8fd19b78c2e96f77f8` | Surgical TeX repair patch for Remark 7.5 of the Oct 8 CM paper |

---

## 3. Theorem Line Index ([`proofs/k3_forensic_paths.lean`](../proofs/k3_forensic_paths.lean))

- [`odd_maslov_degree_sign_always_negative`](../proofs/k3_forensic_paths.lean#L9-L16)
- [`odd_degree_trace_sign_always_opposite`](../proofs/k3_forensic_paths.lean#L23-L35)
- [`eliashberg_murphy_cancellation_fails`](../proofs/k3_forensic_paths.lean#L41-L46)
- [`polterovich_surgery_maslov_obstruction`](../proofs/k3_forensic_paths.lean#L51-L53)
- [`even_branch_generator_avoids_degree_two`](../proofs/k3_forensic_paths.lean#L59-L65)
- [`exactks_4_7_10_degree_separation`](../proofs/k3_forensic_paths.lean#L71-L74)
- [`auxiliary_6_9_12_degree_separation`](../proofs/k3_forensic_paths.lean#L79-L82)
- [`semiregularity_injective_squeeze`](../proofs/k3_forensic_paths.lean#L86-L93)
- [`zero_transcendental_component_breaks_ext2_bound`](../proofs/k3_forensic_paths.lean#L99-L104)
- [`shioda_inose_split_sum_obstruction_rank`](../proofs/k3_forensic_paths.lean#L109-L117)
- [`yoneda_cone_atiyah_rank_no_go`](../proofs/k3_forensic_paths.lean#L124-L130)
- [`eems_poincare_hopf_and_maslov_degrees`](../proofs/k3_forensic_paths.lean#L141-L158)
- [`eems_chi_zero_stabilization_no_go`](../proofs/k3_forensic_paths.lean#L166-L170)
- [`maurer_cartan_forward_trace_obstruction`](../proofs/k3_forensic_paths.lean#L178-L183)
- [`kummer_bkr_untwisted_deficit_and_clifford_gap`](../proofs/k3_forensic_paths.lean#L187-L194)
- [`semihomogeneous_rank21_diagonal_ext2_overflow`](../proofs/k3_forensic_paths.lean#L201-L208)
- [`eems_opposite_sign_and_stokes_blindness`](../proofs/k3_forensic_paths.lean#L218-L226)
- [`kummer_bkr_fixed_point_atiyah_vanishing`](../proofs/k3_forensic_paths.lean#L233-L239)
- [`bogomolov_mixed_discriminant_sign_flip_no_go`](../proofs/k3_forensic_paths.lean#L247-L254)
- [`clifford_spin_endomorphism_ext2_explosion`](../proofs/k3_forensic_paths.lean#L260-L271)
- [`walsh_hadamard_decoupling_diagonal_ext2_no_go`](../proofs/k3_forensic_paths.lean#L281-L294)
- [`ample_koszul_4_term_diagonal_and_section_overflow`](../proofs/k3_forensic_paths.lean#L303-L321)
- [`mukai_semihomogeneous_projective_flatness_barrier`](../proofs/k3_forensic_paths.lean#L328-L349)
- [`markman_secant_mukai_dimension_gap`](../proofs/k3_forensic_paths.lean#L355-L362)
- [`additivity_vs_hyperkahler_rigidity_circularity`](../proofs/k3_forensic_paths.lean#L376-L400)
- [`universal_mumford_diagonal_overflow_for_all_g_and_M`](../proofs/k3_forensic_paths.lean#L408-L427)
- [`universal_g1_branch_stokes_and_kummer_moduli_no_go`](../proofs/k3_forensic_paths.lean#L438-L450)
