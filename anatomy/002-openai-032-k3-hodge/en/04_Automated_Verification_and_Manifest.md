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
          proofs/problem_spec.md
```

---

## 2. Artifact SHA-256 Ledger

| Relative Path | SHA-256 Checksum | Description |
| :--- | :--- | :--- |
| `proofs/k3_forensic_paths.lean` | `ce3a5174796ac991d5d2039c385d910c76d32de90805b000570e02da7ab042fa` | 452 lines, 27 Lean 4 theorems (`Theorem 1`..`Theorem 27`), `0 sorry`, `0 axiom`, `112/112 caught` |
| `proofs/verify_symbolic_k3.py` | `1e60a48a91737a36304f8c94b850a8d2325984292c6a7ea76f4fe3e8061b12be` | Independent SymPy symbolic solver for Problems 1-5 |
| [`proofs/symbolic_verification_result.json`](../proofs/symbolic_verification_result.json) | `2a37ad786b30352aeae5a11904cc69b2a195b70708e874ac37cf7b5579614d1a` | Deterministic JSON output for Problems 1-5 |
| [`proofs/problem_spec.md`](../proofs/problem_spec.md) | `82307dd0f1f6c3c33b376af161a8660f20037e092689b36eb09ccdbeb3316b74` | Specification of Problems 1-5 |

---

## 3. Theorem Line Index (`proofs/k3_forensic_paths.lean`)

- `odd_maslov_degree_sign_always_negative`
- `odd_degree_trace_sign_always_opposite`
- `eliashberg_murphy_cancellation_fails`
- `polterovich_surgery_maslov_obstruction`
- `even_branch_generator_avoids_degree_two`
- `exactks_4_7_10_degree_separation`
- `auxiliary_6_9_12_degree_separation`
- `semiregularity_injective_squeeze`
- `zero_transcendental_component_breaks_ext2_bound`
- `shioda_inose_split_sum_obstruction_rank`
- `yoneda_cone_atiyah_rank_no_go`
- `eems_poincare_hopf_and_maslov_degrees`
- `eems_chi_zero_stabilization_no_go`
- `maurer_cartan_forward_trace_obstruction`
- `kummer_bkr_untwisted_deficit_and_clifford_gap`
- `semihomogeneous_rank21_diagonal_ext2_overflow`
- `eems_opposite_sign_and_stokes_blindness`
- `kummer_bkr_fixed_point_atiyah_vanishing`
- `bogomolov_mixed_discriminant_sign_flip_no_go`
- `clifford_spin_endomorphism_ext2_explosion`
- `walsh_hadamard_decoupling_diagonal_ext2_no_go`
- `ample_koszul_4_term_diagonal_and_section_overflow`
- `mukai_semihomogeneous_projective_flatness_barrier`
- `markman_secant_mukai_dimension_gap`
- `additivity_vs_hyperkahler_rigidity_circularity`
- `universal_mumford_diagonal_overflow_for_all_g_and_M`
- `universal_g1_branch_stokes_and_kummer_moduli_no_go`
