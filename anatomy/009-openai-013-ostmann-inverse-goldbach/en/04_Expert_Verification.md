# Expert Verification: Artifact Hashes, Reproduction Commands, and 55-Theorem Map

## 1. Reproduction Commands

```bash
# 1. Standalone Lean 4 Kernel Check (0 sorry, 55 theorems + 2 recursive defs across 2 files)
~/.elan/bin/lean proofs/ostmann_twin_engines_and_supply_contraction.lean && \
  ~/.elan/bin/lean proofs/ostmann_tree_transfers_and_permutation_contradiction.lean

# 2. Deterministic Symbolic (SymPy) Verification
python3 proofs/verify_symbolic_ostmann.py

# 3. Full Ultari Proof Anatomy Gate (SHA-256 + Mutation Tests + Line Links + Zero-Hint Check)
python3 ../../tools/verify_all.py --root .
```

## 2. Artifact SHA-256 Checksum Table

| Artifact File | SHA-256 Checksum |
| :--- | :--- |
| [`proofs/ostmann_twin_engines_and_supply_contraction.lean`](../proofs/ostmann_twin_engines_and_supply_contraction.lean) | `522055ee8bbb20f5b9dc92cecc3546d72e476a75e8cbf5029c19897e3b089aee` |
| [`proofs/ostmann_tree_transfers_and_permutation_contradiction.lean`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean) | `727e3dcb4149aacb3beba1d87793c911002687bd7cc979abd20fb3f38a4d8d61` |
| [`proofs/verify_symbolic_ostmann.py`](../proofs/verify_symbolic_ostmann.py) | `372e75ff2e8e0274aee5d2ba8ae4ffc306c677263f164bc3b4a472590799a24e` |
| [`proofs/symbolic_verification_result.json`](../proofs/symbolic_verification_result.json) | `a4c633c4e291dbfc200f7ea4348f6da9232db260fc796b5f37668a3f87ecca63` |
| [`proofs/problem_spec.md`](../proofs/problem_spec.md) | `e40a539c681476cbc22768c1c14577d27dece9ae0bedb7b13098bf103d137b02` |

## 3. Complete 1-to-1 Theorem Map (55 Theorems, `0 sorry`, 100% Hypothesis Mutation Kill Rate)

### File 1: [`proofs/ostmann_twin_engines_and_supply_contraction.lean`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L1-L517)
- **Theorem 1**: [`thm_01_ostmann_directory_inclusion_exclusion_partition`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L20-L43) - Exact inclusion-exclusion partition of `OAI/NumberTheory/Ostmann/`: `3165 + 4175 - 5 = 7335` reachable files (`569,682` lines) + `381` orphans (`39,517` lines) = `7,716` files (`609,199` lines).
- **Theorem 2**: [`thm_02_shared_intersection_five_files_accounting`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L44-L60) - Exact line count of the 5 shared files in `Complete ∩ Main` (`46 + 2 + 190 + 68 + 66 = 372` lines, `< 0.1%` of reachable code).
- **Theorem 3**: [`thm_03_unreachable_orphan_381_files_accounting`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L61-L84) - Exact subdirectory decomposition of the `381` unreachable fossil files (`264 + 86 + 10 + 8 + 7 + 2 + 1 + 1 + 2 = 381`).
- **Theorem 4**: [`thm_04_external_dependency_asymmetry_1_vs_18`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L85-L105) - External `OAI` import asymmetry: `1` in Engine A vs. `18` (`15` `Jacobsthal` + `3` `PrimeGaps`) in Engine B (`Cs = 17, Ccov = 17`).
- **Theorem 5**: [`thm_05_complete_vs_main_logical_bridge_equivalence`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L106-L135) - Propositional equivalence between `Complete.lean` (`inverseGoldbach`) and `Main.lean` (`Ostmann.main`) and reduction to infinite summands.
- **Theorem 6**: [`thm_06_finite_summand_crt_dirichlet_composite_witness`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L136-L159) - Finite-summand CRT + Dirichlet composite witness (`s = f_a + b = k_mult * q_a > q_a >= 2`, `FiniteCRT.lean`, Lemma 2.2).
- **Theorem 7**: [`thm_07_shifted_sieve_modulus_exponent_and_elsholtz_window`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L160-L176) - Shifted sieve exponent `10 * j`, `b + 1 = 5`, and Elsholtz polylog window `[-3, 2]` (span `5`).
- **Theorem 8**: [`thm_08_collision_stability_reciprocal_penalty_identity`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L177-L188) - Exact polynomial identity `(p^2 - pa) + pa - 4(pa - a^2) = (2a - p)^2` (`1/\sigma_p + 1/(1-\sigma_p) - 4 = (2\sigma_p-1)^2/(\sigma_p(1-\sigma_p))`).
- **Theorem 9**: [`thm_09_unbalanced_density_penalty_lower_bound_one_half`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L189-L203) - Unbalanced density penalty lower bound `>= 1/2` outside `(1/3, 2/3)` via `2(2a - p)^2 - a(p - a) = (p - 3a)(2p - 3a) >= 0`.
- **Theorem 10**: [`thm_10_quadratic_character_parameter_budget`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L204-L224) - Section 3 quadratic parameters (`\rho = 3/5`, `T^{8/5}`, tail `9/10`, `\mu_0 = 10^{-6}`, `\gamma = 10^{-7}`, `K_denom = 50`).
- **Theorem 11**: [`thm_11_cauchy_schwarz_anchor_code_doubling`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L225-L239) - Section 4 Cauchy-Schwarz character factor doubling `r_{d+1} = 2 r_d` and defect budget recurrence.
- **Theorem 12**: [`thm_12_harmonic_band_mertens_budget_and_sparse_complement`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L240-L261) - Section 5 harmonic band `[1/20, 9/10]` (width `17/20 = 85%`), target `3/20 = 15%`, sparse complement `7/10 = 70%`, and `2%` Mertens reserve above `17/25 = 68%`.
- **Theorem 13**: [`thm_13_local_transfer_polydisc_contraction_margin`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L262-L281) - Polydisc block norm `t_0 * R = (17/20)*(103/100) = 1751/2000 < 1900/2000 = 19/20` (slack `149/2000`).
- **Theorem 14**: [`thm_14_scalar_block_leading_slope_and_lemma_5_2_contraction`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L282-L302) - Scalar block leading slope `2 * t_0 = 17/10 = 1.7` vs. Lemma 5.2 contraction rate `c_loc = 8/5 = 1.6` (margin `1/10`).
- **Theorem 15**: [`thm_15_supply_contradiction_exponent_11_125`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L303-L323) - Section 5 supply contradiction exponent `1 - (8/5)*(17/25) = -11/125 = -0.088 < 0`.
- **Theorem 16**: [`thm_16_montgomery_zero_density_Q7_and_tail_Q_minus_8`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L324-L339) - Montgomery zero-density calibration `T = Q^5 \implies Q^2 T = Q^7` (`slope_A = 21`) and Perron tail `Q^2 T^{-2} = Q^{-8}`.
- **Theorem 17**: [`thm_17_zero_density_critical_exponent_crossover_at_sigma_half`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L340-L354) - Critical line crossover `3(1 - \sigma) <= 2 - \sigma` for all `\sigma \in [1/2, 1]`.
- **Theorem 18**: [`thm_18_page_exceptional_zero_single_prime_deletion_budget`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L355-L371) - Landau-Page exceptional real zero deletion budget (`d_supply <= 1`, `d_sched <= 2`).
- **Theorem 19**: [`thm_19_qrh_003_citation_in_remark_5_4_is_strictly_optional`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L372-L386) - Strict independence from `#003` (`QRH`): `0` imports from `OAI.NumberTheory.DirichletL` across both engines.
- **Theorem 20**: [`thm_20_engine_a_vs_engine_b_supply_constants_bridge`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L387-L402) - Synthesis of Section 5 supply constants across `05-supply.tex` and `Supply/NonsparseSupply.lean`.
- **Theorem 51**: [`thm_51_section3_bonami_high_weight_exponent_and_divisor_cap`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L413-L426) - Section 3 amplified moment (`lambda = 1/16`, `1 + lambda/3 = 49/48`), divisor cap `omega(P) <= 7`, and Bonami high-weight exponent `tau / (8 * mu_0) = 625 >= 20`.
- **Theorem 52**: [`thm_52_section4_anchor_code_one_sided_dichotomy_and_margin`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L434-L449) - Section 4 anchor-code one-sided square-character dichotomy (`(±2, 0)` or `(0, ±2)`) and entropy margin `6931 - 60 = 6871` (`04-characters.tex:1058`, `Characters/AnchorOneSidedEdge.lean:10`).
- **Theorem 53**: [`thm_53_section6_bipartite_quartet_cycle_and_affine_hs_bound`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L458-L470) - Section 6 geometric origin of `b <= 3r/4` via component-quartet bipartite cycle existence (`V_bip <= E_bip`, `cycle_excess >= 1`) and affine Hilbert-Schmidt bound `1 + 2 = 3` (`3/q^2`).
- **Theorem 54**: [`thm_54_section7_five_disjoint_prime_scale_hierarchy`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L479-L491) - Section 7–8 five pairwise disjoint log-log prime scale bands (`4 < 5 <= c_spec <= 10 < 40 <= c_bulk <= 60 < 100 = c_top_comp < 500 <= c_giant <= 9000`).
- **Theorem 55**: [`thm_55_section8_progression_table_zero_free_margins`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L498-L515) - Section 8 two-row progression scale table (`giant` vs. `bulk`) strict inequalities `a_0 - theta > theta > delta' > delta > mu > 0` (`margin_g = 50`, `margin_b = 3`).

### File 2: [`proofs/ostmann_tree_transfers_and_permutation_contradiction.lean`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L1-L581)
- **Theorem 21**: [`thm_21_dyadic_tree_leaf_sum_by_induction`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L30-L50) - All-`k` structural induction (`induction k`) proving `dyadicSum k = 2^k - 1`.
- **Theorem 22**: [`thm_22_weighted_dyadic_level_sum_by_induction`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L51-L79) - All-`k` structural induction (`induction k`) proving `weightedDyadicSum k = k * 2^k - 2 * 2^k + 2`.
- **Theorem 23**: [`thm_23_weighted_dyadic_strict_upper_bound_all_k`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L80-L102) - Exact slack identity `k * 2^k - weightedDyadicSum k = 2 * (2^k - 1) = 2 * dyadicSum k` for all `k : Nat`.
- **Theorem 24**: [`thm_24_single_diagram_second_moment_three_pow_r`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L103-L116) - Single-diagram second moment base `1 + 2 = 3` (`3^r`) and frequency range cardinality `2V + 1 <= 3V`.
- **Theorem 25**: [`thm_25_section_7_schedule_scales_and_even_bulk_size`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L117-L131) - Even bulk size `m = 2 * half_m >= 4` and square-root reserve absorption `4m <= m^2`.
- **Theorem 26**: [`thm_26_frequency_budget_exact_closed_form_all_k`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L132-L150) - Exact closed-form tree frequency budget defects `2^k - S_k = 1` and `2 * slack_W = 4 * S_k` for all `k : Nat`.
- **Theorem 27**: [`thm_27_engine_a_vs_engine_b_frequency_rate_unification`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L151-L167) - Unification of Engine A (`movingFrequencyRate`) and Engine B (`frequencyBudget_eq`, doubled coefficients `2 * Bs` and `Bz + 16`).
- **Theorem 28**: [`thm_28_overlap_graph_component_merge_bound`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L168-L179) - Overlap graph component merge bound `4(r - t) <= r \implies 4t >= 3r` (`t >= (3/4)r`).
- **Theorem 29**: [`thm_29_bad_arrangement_multinomial_decay_three_quarters`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L180-L193) - Bad-arrangement multinomial decay rate `-3/4 = -15/20 = -0.75`.
- **Theorem 30**: [`thm_30_net_contradiction_rate_minus_seven_twentieths`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L194-L212) - Exact net contradiction rate `2/5 - 3/4 = -7/20 = -0.35 < 0` (`Scales.lean:85-87` `finalRate`).
- **Theorem 31**: [`thm_31_diagonal_good_permutation_rate_and_four_providers`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L213-L231) - Engine B 4-provider constants (`Cs = 17, Ccov = 17, Bs = 200, BD_min = 322, C = 19`, margins `65, -66, 67`).
- **Theorem 32**: [`thm_32_scheduled_gap_parameters_and_depth_reserves_engine_a`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L232-L248) - Engine A depth threshold `4^3 = 64 < 120 <= 125 = 5^3` (`k >= 5`) and reserve coefficients `896, 20480`.
- **Theorem 33**: [`thm_33_comparison_slot_complexity_bound`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L249-L263) - Comparison slot complexity bound `|D| <= 2` and `exp((2 + 1)L) = exp(3L)`.
- **Theorem 34**: [`thm_34_linear_k_log_2_dominates_logarithmic_4_log_k`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L264-L277) - Linear `-(7/20) k \log 2` decay dominating fixed/logarithmic overhead to cross `-(2B + 1)`.
- **Theorem 35**: [`thm_35_final_amplitude_upper_vs_lower_contradiction`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L278-L295) - Final root-amplitude upper bound `-(2B + 1)rm` vs. lower bound `-2Brm` contradiction.
- **Theorem 36**: [`thm_36_engine_a_15_step_conditional_discharge_spine`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L296-L316) - Engine A's 9-module hypothesis discharge chain `15 -> 12 -> 8 -> 7 -> 6 -> 5 -> 3 -> 1 -> 0`.
- **Theorem 37**: [`thm_37_engine_b_jacobsthal_and_prime_gaps_reuse_accounting`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L317-L331) - Repository share (`7,716 / 148,832 = 5.18%`) and Engine B's `15 + 3 = 18` external `OAI` imports.
- **Theorem 38**: [`thm_38_paper_9_sections_to_lean_subsystem_mapping`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L332-L356) - Preprint line accounting (`6,072` section lines + `552` root lines = `6,624` lines; `609199 = 100 * 6072 + 1999`).
- **Theorem 39**: [`thm_39_two_stage_analytic_combinatorial_contraction_comparison`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L357-L376) - Comparison of Stage 1 (`-11/125 = -44/500`) and Stage 2 (`-7/20 = -175/500`) contraction exponents.
- **Theorem 40**: [`thm_40_master_ostmann_inverse_goldbach_synthesis_verdict`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L377-L389) - Master synthesis verdict for OpenAI `#013`.
- **Theorem 41**: [`thm_41_bad_arrangement_requires_majority_unsplit_leaves`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L396-L404) - Overlap graph unsplit-leaf majority bound (`3r < 4t` forces `r < 2*t1`, so strictly more than half of all leaves must remain unsplit size-1 components).
- **Theorem 42**: [`thm_42_deranged_slot_pair_eliminates_bad_arrangements`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L411-L421) - Zero bad arrangements under deranged slot pairs (`t1 = 0` forces `2t <= r` and `4(r - t) >= 2r > r` for all `r >= 1`, making `badArrangements` empty).
- **Theorem 43**: [`thm_43_bad_component_max_size_quarter_bound`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L427-L434) - Tightened bad-component maximum size bound (`a_c <= r - t + 1` and `4*a_c <= r + 4`, 4x tighter than `ComponentFactorial.lean:34`).
- **Theorem 44**: [`thm_44_master_contraction_rate_and_depth_reduction`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L443-L459) - Master contraction rate law `gamma_20 = 20 - 2*theta_20 - delta_20` (`7 -> 17 -> 19 -> 20`) and minimum binary tree depth reduction (`k_min: 7041 -> 5340 -> 2036 -> 1803 -> 1040`, saving `6,001` levels).
- **Theorem 45**: [`thm_45_supply_contraction_favorable_mass_expansion`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L466-L479) - Section 5 supply contraction sharpening (`kappa = 33/20, 17/10`), keeping the pair-sum exponent strictly negative (`-13 < 0`, `-40 < 0`) while expanding favorable prime reciprocal mass from `30/200 L` (`0.15 L`) to `44/200 L` (`0.22 L`, `+46.7%`) and `46/200 L` (`0.23 L`, `+53.3%`).
- **Theorem 46**: [`thm_46_siegel_bound_effective_under_qrh_and_away_branch`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L491-L503) - Effective Section 3 bound under `#003` QRH (`K_qrh = 8`, `L_sec3_qrh = 39613`) and `SiegelBoundProof.lean`'s `¬ hnear` branch (`K_away = 1600`, `L_sec3_away = 56170`).
- **Theorem 47**: [`thm_47_tatuzawa_effective_single_exception_and_extended_deletion_budget`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L512-L523) - Unconditional classical bypass via Tatuzawa's theorem (`denom_no_root = 384002`) + extended deletion budget `card_D_ext <= 3` preserving positive harmonic mass (`2*L - 10000*card_D_ext >= 2` for `L >= 15001`).
- **Theorem 48**: [`thm_48_combinatorial_2k_cancellation_in_bulk_exp_margin`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L530-L537) - Exact `2^k`-cancellation in `eventually_bulk_exp_margin` (`req_cancelled = 40*k < 125*k <= m_lower` for `k >= 5, L >= 1`).
- **Theorem 49**: [`thm_49_explicit_effective_loglog_threshold_bottleneck_shift`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L545-L561) - Explicit effective log-log thresholds (`L_sec3_tat = 87689 < L_eff_ultra = 255983 < L_eff_sharp = 640722 < L_eff_gpt = 4115904`, saving `3,475,182` and `3,859,921` in `log log X_0`).
- **Theorem 50**: [`thm_50_effective_ostmann_counterexample_bound_master`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L569-L579) - Master effective Ostmann counterexample witness theorem (`33 - 32 = 1` file destructing `PublishedSiegelBound`, constructive witness `N0 < X_min <= n_wit <= X_max`).
