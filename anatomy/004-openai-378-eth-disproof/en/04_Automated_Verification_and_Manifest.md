# 04. Automated Verification & Machine-Checkable Specification

This specification defines the deterministic reproducibility, SHA-256 checksum integrity, `331/331` Lean 4 hypothesis-mutation kills across `42` formal theorems, `SymPy` + Blackwell GPU tensor verification, clean-room independent blind verification (`24/24` match), and independent adversarial audit (`0` defects) for the OpenAI `#378` (`Disproof of the Exponential Time Hypothesis`) referee audit package.

---

## 1. Artifact SHA-256 Integrity Hash Table

| Artifact Path | SHA-256 Checksum | Lines | Role |
| :--- | :--- | :---: | :--- |
| [`proofs/eth_subexp_interpolation_and_hashes.lean`](../proofs/eth_subexp_interpolation_and_hashes.lean) | `c222d771e83d6ad4f377fe59d7391b4400cebacf44ce618d0a166d78fd1c83f9` | `418` | Part A (`Theorems 1–16`): `Engine I` swap matrix, incidence-pair cancellation, truncated ring, Tanner hashes, `BitProgram 80 1220` (`0 sorry`, `128/128` mutations killed) |
| [`proofs/eth_tensor_contraction_and_circuits.lean`](../proofs/eth_tensor_contraction_and_circuits.lean) | `2a1880ee7b5087953689474706e747552f054adc57bd11cc6a148b1c4a25a90c` | `396` | Part B (`Theorems 17–32`): Appendix D (`Engine II`) tapered $2$-adic Hermite interpolation, `Corollary 1.4` circuit lower bound, scope gap & unused-hypothesis audit (`0 sorry`, `131/131` mutations killed) |
| [`proofs/eth_five_repairs_and_four_layer_verdict.lean`](../proofs/eth_five_repairs_and_four_layer_verdict.lean) | `404727d4deaf236e2596a90f5fbf6d49819dab20349dd308f5d8c0964ab342cf` | `234` | Part C (`Theorems 33–42`): 5 specification-gaming repairs and 4-layer post-repair verdict (`0 sorry`, `72/72` mutations killed) |
| [`proofs/verify_symbolic_eth.py`](../proofs/verify_symbolic_eth.py) | `1a01932c23fd476bcc038f66fe3021b64163ee6ece61757451e038d6229b9b1d` | `479` | `SymPy` symbolic algebra + Blackwell GPU (`FP64`) tensor verifier (`8` audit suites) |
| [`proofs/symbolic_verification_result.json`](../proofs/symbolic_verification_result.json) | `23c89c857f6dc979c4b5e43e47cc01a8bc61d12aba4db562606ecd39ab324fe6` | `159` | Deterministic symbolic & GPU verification receipt JSON |
| [`proofs/problem_spec.md`](../proofs/problem_spec.md) | `ddd0b0609effa210e26c006d52ede5772e4235fc1664582aa6f9db6092d10adf` | `34` | 6-problem (`24` target values) clean-room blind specification |

---

## 2. Automated Verification Gate Commands & Pass Criteria

1. **Lean 4 Kernel & Hypothesis-Mutation Kill Gate (`331/331`)**:
   ```bash
   ~/.elan/bin/lean proofs/eth_subexp_interpolation_and_hashes.lean && ~/.elan/bin/lean proofs/eth_tensor_contraction_and_circuits.lean && ~/.elan/bin/lean proofs/eth_five_repairs_and_four_layer_verdict.lean
   ```
   * Pass criteria: Exit code `0`, `0 sorry`, `0` custom axioms; replacing each of the `331` relational hypotheses across all `42` theorems individually with `: True` causes `331/331` compilation rejections (`100%` killed).
2. **Symbolic (`SymPy`) + Blackwell GPU (`PyTorch FP64`) Deterministic Reproduction**:
   ```bash
   cd proofs && python3 verify_symbolic_eth.py
   ```
   * Pass criteria: Exit code `0`, Blackwell GPU `FP64` $64 \times 64$ commuting swap operator $W_0, M_0$ spectrum, Appendix D tapered Hermite $2$-adic valuation, and 4-layer post-repair verdict (`audit_8`) pass, matching `proofs/symbolic_verification_result.json` byte-for-byte.
3. **Artifact SHA-256 Checksum & Clean-Room Blind Reproduction Gate (`24/24` Match)**:
   ```bash
   sha256sum proofs/eth_subexp_interpolation_and_hashes.lean \
             proofs/eth_tensor_contraction_and_circuits.lean \
             proofs/eth_five_repairs_and_four_layer_verdict.lean \
             proofs/verify_symbolic_eth.py \
             proofs/symbolic_verification_result.json \
             proofs/problem_spec.md
   ```
   * Pass criteria: Exact SHA-256 checksum match across all `6` core artifacts and `24/24` target value match in isolated clean-room blind verification.

---

## 3. `SymPy` / Blackwell GPU Receipt & Clean-Room Independent Blind (`24/24`) Comparison Tables

### 3.1 `proofs/symbolic_verification_result.json` Verification Table

| Audit ID | Verified Metric | Measured Value in `proofs/symbolic_verification_result.json` | Status |
| :--- | :--- | :--- | :--- |
| `audit_1_commuting_swap_matrix_gpu` | $\operatorname{rank}(I_{64} - M_0)$ and max support mismatch at $r=2, Q=3$ ($D=64$) | `10` (`max_group_mismatch_on_M0_support = 1`) | `PASS` |
| `audit_2_beigel_tarui_and_truncated_ring` | Truncated degree $d_{\mathrm{trunc}}$ vs. full degree $d_{\mathrm{full}}$ at $k=2, m_{\mathrm{test}}=4, \ell=3$ | `16` vs `40` (`exact_degree_saved = 24`) | `PASS` |
| `audit_3_tanner_expander_and_greedy_hashes` | Per-variable 3-round greedy hash contraction ratio $(3/4)^3 \cdot 2$ | `27/32` (`P = 20000*B**2*mu**2`) | `PASS` |
| `audit_4_cip_sparsification_recurrence` | Right-branch constant $\Gamma(k) = 2(3^{k-1}-1)$ for $k=3, 4, 5, 6, 7$ | `16`, `52`, `160`, `484`, `1456` | `PASS` |
| `audit_5_appendix_d_cauchy_and_tapered_hermite` | $r=64$ child edge ratio, target ratio, slack, and tapered Hermite series limit | `3/32`, `1/8`, `1/32` (`tapered_series_limit = 6`) | `PASS` |
| `audit_6_mode_partitions_and_circuit_lower_bound` | Per-depth squared log-effort decay ratio and Williams circuit exponent at $A=4$ | `1/32`, `12/49` (`< 1/4 < 1/2`) | `PASS` |
| `audit_7_bitprogram_and_lean_scope_inventory` | `BitProgram` registers/stacks, raw space cap, unformalized LaTeX lines, unused-hypothesis count | `80`, `1220`, `5022740`, `1059` / `5888`, `655` | `PASS` |
| `audit_8_five_repairs_and_four_layer_verdict` | Binary space refutation (`49000 < 1048576`), `4*R ≤ Q` crossover (`24` fail $\to$ `25` pass, slack `4148`), constant `12032411847`, GPU $n=12$ uniform count `2360` | `49000`, `10996584333160`, `24 -> 25`, `4148`, `12032411847`, `2360` | `PASS` |

### 3.2 Clean-Room Independent Blind Test (`24/24` Match) Receipt Summary

| Problem (`problem_spec.md`) | Values Independently Derived from `oai_ref/` by Clean-Room Independent Blind | Match |
| :--- | :--- | :---: |
| **Problem 1 (Gen 1 & Gen 2 Fossils)** | `12803/16384` ($\ell=4096$ leaf coeff), `13315/16384` ($+1/32$ combined), `s = 32`, `k = 32` ($n \ge 2^{2^{32}}$) | `4/4 PASS` |
| **Problem 2 (`Engine I` Swap Matrix)** | $W_0$ spectrum `[27, 27, 9, 1]`, $\operatorname{rank}(I_{64}-M_0) = 10$, max slot mismatch `1` | `3/3 PASS` |
| **Problem 3 (Tanner Expander Hashes)** | $P = 20000$, $D_0 = 320000$, $2n$-round ratio `"9/8"`, $3n$-round ratio `"27/32"` | `4/4 PASS` |
| **Problem 4 (Appendix D `Engine II`)** | Branching $r = 64$, edge contraction `"3/32"`, Hermite series limit `6`, squared log-effort ratio `"1/32"` | `4/4 PASS` |
| **Problem 5 (Reward Hack Cutoffs)** | Minimum $\lambda = 65536$ ($n > 2^{65,535}$) for `sparsifySchedule n >= 1`, fallback padding `28700`, `5022741` | `3/3 PASS` |
| **Problem 6 (4-Layer Verdict & Crossover)** | Binary cap `49000`, repaired cap `10996584333160`, max failing `log2 L = 24`, min passing `25`, slack `4148`, constant `12032411847` | `6/6 PASS` |

---

## 4. `Lean 4` Formal Theorem Specification (`42` Theorems, `331/331` Mutations Killed)

### Part A: [`proofs/eth_subexp_interpolation_and_hashes.lean`](../proofs/eth_subexp_interpolation_and_hashes.lean#L1-L418) (`Theorems 1–16`, `128/128` Mutations Killed)
1. [`swap_eigenbasis_symmetric_antisymmetric_split`](../proofs/eth_subexp_interpolation_and_hashes.lean#L22-L50) (`L22`): Symmetric/antisymmetric eigenspace split of $\Pi_s$ on $[r]^2$ and binomial multiplicity identity.
2. [`newton_forward_difference_parity_interpolation`](../proofs/eth_subexp_interpolation_and_hashes.lean#L58-L71) (`L58`): Unit eigenvalue preservation of Newton forward-difference parity polynomial $f_{\mathcal{I}}(z)$ on $\mathcal{I}$.
3. [`remark_4_4_four_by_four_swap_matrix_kernel_and_path`](../proofs/eth_subexp_interpolation_and_hashes.lean#L77-L89) (`L77`): `Remark 4.4` $4 \times 4$ swap matrix $M_0 = \Pi_1 + \Pi_2 - \Pi_1\Pi_2$ kernel invariance and degree-1 path.
4. [`swap_support_mismatch_and_annihilator_degree_bound`](../proofs/eth_subexp_interpolation_and_hashes.lean#L95-L106) (`L95`): Support group mismatch bound $|E_{u,y}| \le R - 1$ and integer annihilator degree bound.
5. [`shared_summary_measurement_row_budget`](../proofs/eth_subexp_interpolation_and_hashes.lean#L111-L125) (`L111`): Shared linear summary row bound $\sum_{g=1}^r c_{t,g} \le 2\tau n c_{\mathcal{B}}$.
6. [`taylor_jet_truncation_and_subset_pair_exponent`](../proofs/eth_subexp_interpolation_and_hashes.lean#L130-L143) (`L130`): Taylor finite-difference jet truncation order $q = \lfloor d_H/Q\rfloor$ and $6R q \le d_H$ bound.
7. [`asymptotic_three_way_exponent_balance_schedule`](../proofs/eth_subexp_interpolation_and_hashes.lean#L149-L161) (`L149`): Three-way exponent balance schedule $\log_2 D \le \lambda/64$ and Hoeffding tail dominance.
8. [`beigel_tarui_modulus_amplifying_polynomial_l2`](../proofs/eth_subexp_interpolation_and_hashes.lean#L171-L199) (`L171`): $\ell=2$ complementary Beigel-Tarui polynomial $p_2(Y) = 1 - 3Y^2 + 2Y^3$ decomposition and $\bmod 4$ congruence.
9. [`total_order_truncated_ring_linear_vs_quadratic_degree`](../proofs/eth_subexp_interpolation_and_hashes.lean#L205-L232) (`L205`): Linear degree $k(m_{\mathrm{test}}+2(\ell-1))$ in $\mathbb{Q}[V]/(V^\ell)$ vs. quadratic degree savings.
10. [`tanner_expander_hash_parameters_and_mixing_distance`](../proofs/eth_subexp_interpolation_and_hashes.lean#L238-L266) (`L238`): Tanner expander parameters $P = 20000 B^2\mu^2$, $D_0 = 320000 B^2\mu^3$ and minimum distance $h' \ge m/P$.
11. [`tanner_code_check_row_budget_and_locality`](../proofs/eth_subexp_interpolation_and_hashes.lean#L272-L310) (`L272`): Tanner check row budget $m_G = 2 q_G c_G \le n$, total checks $m_{\mathrm{test}} \le 4n$, column weight $\le 16 B\mu$.
12. [`greedy_hash_selection_three_quarter_contraction`](../proofs/eth_subexp_interpolation_and_hashes.lean#L317-L339) (`L317`): $3n$-round greedy conditional-expectation hash contraction $(27/32)^n < 1$ and $D_{\mathrm{final}} = 0$.
13. [`cip_sparsification_insertion_recurrence_step`](../proofs/eth_subexp_interpolation_and_hashes.lean#L346-L363) (`L346`): CIP disjoint sparsification insertion recurrence $N_{j+1} \le 4(3M)^j n$ inductive step.
14. [`cip_sparsification_b_branch_constant_and_tree_exponent`](../proofs/eth_subexp_interpolation_and_hashes.lean#L369-L380) (`L369`): CIP right-branch constant $\Gamma_k = 2(3^{k-1}-1)$ and root-to-leaf $B$-edge bound.
15. [`coset_separation_iteration_identity_and_bound`](../proofs/eth_subexp_interpolation_and_hashes.lean#L385-L398) (`L385`): Disjoint coset separation identity and $3D/4$ geometric shrinkage.
16. [`bitprogram_1220_stack_compiler_space_and_time_envelope`](../proofs/eth_subexp_interpolation_and_hashes.lean#L403-L418) (`L403`): `BitProgram 80 1220` raw space envelope $5022740(L+1)^2$, fallback padding (`28700`, `5022741`), and $7\times$ compiler bound.

### Part B: [`proofs/eth_tensor_contraction_and_circuits.lean`](../proofs/eth_tensor_contraction_and_circuits.lean#L1-L396) (`Theorems 17–32`, `131/131` Mutations Killed)
17. [`appendix_d_collision_packet_packing_and_edge_contraction`](../proofs/eth_tensor_contraction_and_circuits.lean#L22-L36) (`L22`): Appendix D (`Lemma D.3`) $r=64$ collision packet packing and per-child edge contraction $3/32 < 1/8$.
18. [`appendix_d_dyadic_depth_precision_schedule_and_total_wires`](../proofs/eth_tensor_contraction_and_circuits.lean#L43-L55) (`L43`): Appendix D dyadic precision schedule $a_d < 4 u_0$ and $8^{-d}$ wire shrinkage.
19. [`appendix_d_cauchy_2adic_deformation_valuation_invariance`](../proofs/eth_tensor_contraction_and_circuits.lean#L62-L72) (`L62`): Appendix D (`Lemma D.4`) $2$-adic Cauchy deformation valuation invariance for $\alpha = 2^{a+1}$.
20. [`appendix_d_vandermonde_sylvester_2adic_exponent_bound`](../proofs/eth_tensor_contraction_and_circuits.lean#L79-L88) (`L79`): Dyadic distance shell partition identity on $S = \{-2^a, \dots, 2^a-1\}$.
21. [`appendix_d_tapered_hermite_exact_agm_series_sum_six`](../proofs/eth_tensor_contraction_and_circuits.lean#L96-L112) (`L96`): Appendix D (`Lemma D.5`) tapered Hermite series identity $\sum_{j=1}^m j^2 2^{m-j} = 6\cdot 2^m - (m^2+4m+6)$ and limit $6$.
22. [`appendix_d_tapered_vs_untapered_hermite_valuation_gain`](../proofs/eth_tensor_contraction_and_circuits.lean#L118-L136) (`L118`): Tapered loss $6 D_t h$ vs. untapered loss $2 u D_t h$ ($u/3$-fold precision gain).
23. [`appendix_d_hermite_jet_precision_budget_pt`](../proofs/eth_tensor_contraction_and_circuits.lean#L142-L155) (`L142`): Hermite jet reconstruction precision bound $p_t \le 8 D_t h$.
24. [`appendix_d_hardy_ramanujan_mode_partition_exponent`](../proofs/eth_tensor_contraction_and_circuits.lean#L162-L188) (`L162`): Mode order weight bound $\sum k m_k \le 8h$ and Cauchy-Schwarz partition exponent bound.
25. [`appendix_d_recursive_depth_geometric_decay_ratio`](../proofs/eth_tensor_contraction_and_circuits.lean#L195-L219) (`L195`): Per-depth squared log-effort decay ratio $1/32$ and geometric series convergence (`Theorem D.1`).
26. [`appendix_d_dense_incidence_group_wire_compression`](../proofs/eth_tensor_contraction_and_circuits.lean#L226-L246) (`L226`): Arbitrary-density $J = \lceil n^{1/4}\rceil$ group monomial wire compression (`Lemma D.2`).
27. [`appendix_d_fixed_density_vs_arbitrary_density_exponent_gap`](../proofs/eth_tensor_contraction_and_circuits.lean#L253-L272) (`L253`): Three-tier exponent hierarchy across `Engine II` (fixed density), `Engine II` (arbitrary density), and `Engine I` (`Lean`).
28. [`williams_enp_witness_circuit_3sat_gate_reduction`](../proofs/eth_tensor_contraction_and_circuits.lean#L284-L296) (`L284`): `Corollary 1.4` witness circuit $D_n$ gate bound $U_n \le 4s_n$, variables $V \le 5s_n$, 3-CNF clauses $M < 5V$.
29. [`williams_enp_circuit_lower_bound_threshold_contradiction`](../proofs/eth_tensor_contraction_and_circuits.lean#L304-L322) (`L304`): $\mathrm{E}^{\mathrm{NP}}$ circuit lower bound proof via fixed-density solver exponent $< n/4 < n/2$ at $\eta < 1/(12A)$.
30. [`engine_i_cannot_prove_corollary_1_4_without_engine_ii`](../proofs/eth_tensor_contraction_and_circuits.lean#L329-L347) (`L329`): Formal proof that `Engine I` alone fails `Corollary 1.4` due to the $(\log\log n)^2$ factor.
31. [`lean_formalization_scope_gap_and_cutoff_inventory`](../proofs/eth_tensor_contraction_and_circuits.lean#L354-L372) (`L354`): Inventory of `1,059` unformalized lines out of `5,888` and small-input cutoffs ($n=20, 896$).
32. [`oai_subexponential_sat_unused_hypothesis_audit`](../proofs/eth_tensor_contraction_and_circuits.lean#L380-L394) (`L380`): Static hygiene audit (`0 sorry`, `0 axiom`, `655` unused hypotheses) across `3,977` files and `iteration_bound` counterexample.

### Part C: [`proofs/eth_five_repairs_and_four_layer_verdict.lean`](../proofs/eth_five_repairs_and_four_layer_verdict.lean#L1-L234) (`Theorems 33–42`, `72/72` Mutations Killed)
33. [`layer1_unary_vs_binary_encoding_bitlength_gap`](../proofs/eth_five_repairs_and_four_layer_verdict.lean#L20-L30) (`L20`): Layer ① unary encoding ($1,048,586$) vs. standard binary encoding ($69$) bit-length gap at $n=2^{20}$.
34. [`layer1_visited_space_L_only_refuted_and_poly_n_plus_L_repaired`](../proofs/eth_five_repairs_and_four_layer_verdict.lean#L38-L51) (`L38`): Layer ① refutation of `visitedSpace ≤ S*(L+1)^2` ($49,000 < 1,048,576$, True $\to$ False) under binary encoding and $\mathrm{poly}(n+L)$ ($10,996,584,333,160$) repair.
35. [`layer2_engine_i_circuit_lower_bound_loglog_degradation`](../proofs/eth_five_repairs_and_four_layer_verdict.lean#L61-L73) (`L61`): Layer ② circuit lower bound degradation from $\Omega(n\sqrt{\log n})$ to $\Omega(n\sqrt{\log n}/(\log\log n)^2)$ under `Engine I` alone.
36. [`layer2_engine_ii_galois_ring_and_tapered_hermite_repair_certificate`](../proofs/eth_five_repairs_and_four_layer_verdict.lean#L79-L91) (`L79`): Layer ② invertible $2^{-1} = 14 \pmod{27}$ in $\mathbb{Z}/3^t\mathbb{Z}$ and $m=4$ tapered Hermite sum ($58 < 96$) certificate for `Engine II`.
37. [`layer3_asymptotic_layout_guard_fails_at_log2_L_24`](../proofs/eth_five_repairs_and_four_layer_verdict.lean#L101-L119) (`L101`): Layer ③ failure of `LeafParametersProgram.Guard` ($Q=87,381 < 101,012 = 4R$, deficit $13,631$) at $\log_2 L(n) = 24$ ($L=16,777,216$).
38. [`layer3_asymptotic_layout_guard_passes_at_log2_L_25`](../proofs/eth_five_repairs_and_four_layer_verdict.lean#L125-L143) (`L125`): Layer ③ first activation of `Guard` ($4R = 126,924 \le 131,072 = Q$, slack $4,148$) at $\log_2 L(n) = 25$ ($n \ge 2^{33,554,431}$).
39. [`layer3_cost_assembly_explicit_exponent_constant_12032411847`](../proofs/eth_five_repairs_and_four_layer_verdict.lean#L148-L160) (`L148`): Layer ③ explicit evaluation of $\mathrm{exponentConstant}(3,1) = 12,032,411,847$ and outer-doubled constant $24,064,823,694$.
40. [`layer3_uniform_exhaustive_loop_replaces_noncomputable_dfa_and_reject`](../proofs/eth_five_repairs_and_four_layer_verdict.lean#L166-L183) (`L166`): Layer ③ replacement of noncomputable `FiniteFallback` DFA and `HighQueryProgram.reject` (`0` output) by a uniform $2^n$ loop.
41. [`layer4_walsh_and_irreducible_search_constructive_termination_bounds`](../proofs/eth_five_repairs_and_four_layer_verdict.lean#L191-L203) (`L191`): Layer ④ constructive finite termination bounds for `WalshExistence` ($8q^2(r+1)=96\le D$) and `IrreducibleSearch` ($6,561$ checks).
42. [`layer4_repaired_pipeline_preserves_asymptotic_subexponential_eth_disproof`](../proofs/eth_five_repairs_and_four_layer_verdict.lean#L210-L230) (`L210`): Layer ④ preservation of $4\cdot\mathrm{subexp\_exp} \le n$ ($2^{o(n)}$ ETH disproof) for $n \ge N_0(k)$ after all five repairs.
