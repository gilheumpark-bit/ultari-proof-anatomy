# 전문가 검증: 아티팩트 해시, 재현 명령, 75개 정리 1:1 매핑

## 1. 재현 명령

```bash
# 1. 독립형 Lean 4 커널 검증 (0 sorry, 3개 파일에 걸친 정리 75개 + 재귀 def 3개 + structure 1개)
~/.elan/bin/lean proofs/ostmann_twin_engines_and_supply_contraction.lean && \
  ~/.elan/bin/lean proofs/ostmann_tree_transfers_and_permutation_contradiction.lean && \
  ~/.elan/bin/lean proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean

# 2. 결정론적 기호(SymPy) 검증
python3 proofs/verify_symbolic_ostmann.py

# 3. 울타리 증명 해부 통합 게이트 (SHA-256 + 가설 변이 시험 + 줄 번호 링크 + 무힌트 명세 검사)
python3 ../../tools/verify_all.py --root .
```

## 2. 아티팩트 SHA-256 체크섬 표

| 아티팩트 파일 | SHA-256 체크섬 |
| :--- | :--- |
| [`proofs/ostmann_twin_engines_and_supply_contraction.lean`](../proofs/ostmann_twin_engines_and_supply_contraction.lean) | `de1dc0ff11a3205dfa16998d300b0bd5195259d34831972941a17d52fd7f1c7d` |
| [`proofs/ostmann_tree_transfers_and_permutation_contradiction.lean`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean) | `5e1cba290f76db87e71940b8fb8bff04dae4f87b74db3f3df7f102f6507e203a` |
| [`proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean) | `20bd47f0bf25d68ed3b04e4d891c00aff497addbf32d491f165aa2acff53e832` |
| [`proofs/verify_symbolic_ostmann.py`](../proofs/verify_symbolic_ostmann.py) | `dd14880ab1aaed9a94e80d5228485264346a8b2230488ead675957ab7b75b47e` |
| [`proofs/symbolic_verification_result.json`](../proofs/symbolic_verification_result.json) | `c6c4fa27af9686d43667e708e00d34dfd3daa789c5a91ad502b03cb3b27208fa` |
| [`proofs/problem_spec.md`](../proofs/problem_spec.md) | `e40a539c681476cbc22768c1c14577d27dece9ae0bedb7b13098bf103d137b02` |

## 3. 전체 75개 정리 1:1 매핑 (`0 sorry`, 가설 변이 100% 격추: `393 / 393`)

### 파일 1: [`proofs/ostmann_twin_engines_and_supply_contraction.lean`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L1-L517) (`25`개 정리)
- **Theorem 1**: [`thm_01_ostmann_directory_inclusion_exclusion_partition`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L20-L43) - `OAI/NumberTheory/Ostmann/` 포함-배제 분할: `3165 + 4175 - 5 = 7335`개 도달 가능 파일(`569,682`줄) + `381`개 고아 파일(`39,517`줄) = `7,716`개 파일(`609,199`줄).
- **Theorem 2**: [`thm_02_shared_intersection_five_files_accounting`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L44-L60) - `Complete ∩ Main` 공유 코어 5개 파일 줄 수 합산(`46 + 2 + 190 + 68 + 66 = 372`줄, 도달 가능 코드의 `< 0.1%`).
- **Theorem 3**: [`thm_03_unreachable_orphan_381_files_accounting`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L61-L84) - 미사용 고아 화석 파일 `381`개의 하위 폴더별 분해(`264 + 86 + 10 + 8 + 7 + 2 + 1 + 1 + 2 = 381`).
- **Theorem 4**: [`thm_04_external_dependency_asymmetry_1_vs_18`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L85-L105) - 외부 `OAI` 임포트 비대칭성: 엔진 A `1`개 대 엔진 B `18`개(`Jacobsthal` `15`개 + `PrimeGaps` `3`개, `Cs = 17, Ccov = 17`).
- **Theorem 5**: [`thm_05_complete_vs_main_logical_bridge_equivalence`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L106-L135) - `Complete.lean` (`inverseGoldbach`)과 `Main.lean` (`Ostmann.main`)의 명제 논리 동치 및 무한 가산항 환원.
- **Theorem 6**: [`thm_06_finite_summand_crt_dirichlet_composite_witness`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L136-L159) - 유한 가산항 CRT + 디리클레 합성수 증인(`s = f_a + b = k_mult * q_a > q_a >= 2`, `FiniteCRT.lean`, 보조정리 2.2).
- **Theorem 7**: [`thm_07_shifted_sieve_modulus_exponent_and_elsholtz_window`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L160-L176) - 이동 체 소수 곱 지수 `10 * j`, `b + 1 = 5`, 엘숄츠 로그 거듭제곱 창 `[-3, 2]` (폭 `5`).
- **Theorem 8**: [`thm_08_collision_stability_reciprocal_penalty_identity`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L177-L188) - 충돌 안정성 다항 항등식 `(p^2 - pa) + pa - 4(pa - a^2) = (2a - p)^2` (`1/\sigma_p + 1/(1-\sigma_p) - 4 = (2\sigma_p-1)^2/(\sigma_p(1-\sigma_p))`).
- **Theorem 9**: [`thm_09_unbalanced_density_penalty_lower_bound_one_half`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L189-L203) - 불균형 밀도 구간 `(1/3, 2/3)` 바깥에서의 벌점 하한 `>= 1/2` (`2(2a - p)^2 - a(p - a) = (p - 3a)(2p - 3a) >= 0`).
- **Theorem 10**: [`thm_10_quadratic_character_parameter_budget`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L204-L224) - 3절 이차 지표 매개변수 예산(`\rho = 3/5`, `T^{8/5}`, 꼬리 `9/10`, `\mu_0 = 10^{-6}`, `\gamma = 10^{-7}`, `K_denom >= 50`).
- **Theorem 11**: [`thm_11_cauchy_schwarz_anchor_code_doubling`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L225-L239) - 4절 코시-슈바르츠 지표 인수 배가 `r_{d+1} = 2 r_d` 및 결손 예산 점화식.
- **Theorem 12**: [`thm_12_harmonic_band_mertens_budget_and_sparse_complement`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L240-L261) - 5절 조화 대역 `[1/20, 9/10]` (폭 `17/20 = 85%`), 목표 `<= 3/20 = 15%`, 희소 여집합 `>= 7/10 = 70%`, 문턱값 `17/25 = 68%` 위의 `2%` 메르텐스 여유분.
- **Theorem 13**: [`thm_13_local_transfer_polydisc_contraction_margin`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L262-L281) - 다중원판 블록 노름 `t_0 * R <= (17/20)*(103/100) = 1751/2000 < 1900/2000 = 19/20` (여유분 `>= 149/2000`).
- **Theorem 14**: [`thm_14_scalar_block_leading_slope_and_lemma_5_2_contraction`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L282-L302) - 스칼라 블록 주 기울기 `2 * t_0 >= 17/10 = 1.7` 대 보조정리 5.2 국소 수축률 `c_loc = 8/5 = 1.6` (여유분 `>= 1/10`).
- **Theorem 15**: [`thm_15_supply_contradiction_exponent_11_125`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L303-L323) - 5절 푸리에 공급 모순 지수 `1 - (8/5)*(H/L) <= -11/125 = -0.088 < 0` (`H >= 17/25 L`).
- **Theorem 16**: [`thm_16_montgomery_zero_density_Q7_and_tail_Q_minus_8`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L324-L339) - 몽고메리 영점 밀도 보정 `T >= Q^5 \implies Q^2 T >= Q^7` (`slope_A >= 21`) 및 페롱 꼬리 오차 `Q^2 T^{-2} <= Q^{-8}`.
- **Theorem 17**: [`thm_17_zero_density_critical_exponent_crossover_at_sigma_half`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L340-L354) - 임계선 `\sigma = 1/2` 교차 및 `\sigma \in [1/2, 1]`에서의 `3(1 - \sigma) <= 2 - \sigma`.
- **Theorem 18**: [`thm_18_page_exceptional_zero_single_prime_deletion_budget`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L355-L371) - 란다우-페이지 예외 실수 영점 소수 제거 예산(`d_supply <= 1`, `d_sched <= 2`).
- **Theorem 19**: [`thm_19_qrh_003_citation_in_remark_5_4_is_strictly_optional`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L372-L386) - `#003` (`QRH`)으로부터의 완전 독립성: 두 엔진 모두 `OAI.NumberTheory.DirichletL` 임포트 `0`개.
- **Theorem 20**: [`thm_20_engine_a_vs_engine_b_supply_constants_bridge`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L387-L412) - `05-supply.tex`와 `Supply/NonsparseSupply.lean`의 5절 공급 상수 통합 검증.
- **Theorem 51**: [`thm_51_section3_bonami_high_weight_exponent_and_divisor_cap`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L413-L433) - 3절 증폭 모멘트(`lambda = 1/16`, `1 + lambda/3 = 49/48`), 약수 개수 상한 `omega(P) <= 7`, 보나미 고가중치 감쇠 계수 `tau / (8 * mu_0) >= 625 >= 20`.
- **Theorem 52**: [`thm_52_section4_anchor_code_one_sided_dichotomy_and_margin`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L434-L457) - 4절 앵커 코드 단측 제곱 지표 이분법(`(±2, 0)` 또는 `(0, ±2)`) 및 단계당 엔트로피 여유분 `>= 6871` (`04-characters.tex:1058`, `Characters/AnchorInteraction.lean:8`).
- **Theorem 53**: [`thm_53_section6_bipartite_quartet_cycle_and_affine_hs_bound`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L458-L478) - 6절 성분-사중주 이분 다중그래프 순환 존재성(`V_bip <= E_bip`, `cycle_excess >= 1`)을 통한 `b <= 3r/4` 임계치의 기하학적 기원 및 아핀 힐베르트-슈미트 상한 `1 + 2 = 3` (`3/q^2`).
- **Theorem 54**: [`thm_54_section7_five_disjoint_prime_scale_hierarchy`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L479-L497) - 7~8절 5대 쌍별 서로소 이중 로그 소수 스케일 계층(`4 < 5 <= c_spec <= 10 < 40 <= c_bulk <= 60 < 100 = c_top_comp < 500 <= c_giant <= 9000`).
- **Theorem 55**: [`thm_55_section8_progression_table_zero_free_margins`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L498-L517) - 8절 2행 등차수열 스케일 표(`giant` 대 `bulk`)의 엄격한 부등식 사슬 `a_0 - theta > theta > delta' > delta > mu > 0` (`margin_g >= 50`, `margin_b >= 3`).

### 파일 2: [`proofs/ostmann_tree_transfers_and_permutation_contradiction.lean`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L1-L564) (`30`개 정리)
- **Theorem 21**: [`thm_21_dyadic_tree_leaf_sum_by_induction`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L30-L50) - 모든 자연수 `k`에 대한 구조적 귀납법(`induction k`)으로 증명한 `dyadicSum k = 2^k - 1`.
- **Theorem 22**: [`thm_22_weighted_dyadic_level_sum_by_induction`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L51-L79) - 모든 자연수 `k`에 대한 구조적 귀납법(`induction k`)으로 증명한 `weightedDyadicSum k = k * 2^k - 2 * 2^k + 2`.
- **Theorem 23**: [`thm_23_weighted_dyadic_strict_upper_bound_all_k`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L80-L102) - 모든 `k : Nat`에 대한 정확한 여유 항등식 `k * 2^k - weightedDyadicSum k = 2 * (2^k - 1) = 2 * dyadicSum k`.
- **Theorem 24**: [`thm_24_single_diagram_second_moment_three_pow_r`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L103-L116) - 단일 다이어그램 2차 모멘트 밑 `1 + 2 = 3` (`3^r`) 및 주파수 구간 크기 `2V + 1 <= 3V`.
- **Theorem 25**: [`thm_25_section_7_schedule_scales_and_even_bulk_size`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L117-L131) - 짝수 벌크 크기 `m = 2 * half_m >= 4` 및 제곱근 예비항 흡수 `4m <= m^2`.
- **Theorem 26**: [`thm_26_frequency_budget_exact_closed_form_all_k`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L132-L150) - 모든 `k : Nat`에 대한 주파수 예산 닫힌꼴 결손 항등식 `2^k - S_k = 1` 및 `2 * slack_W = 4 * S_k`.
- **Theorem 27**: [`thm_27_engine_a_vs_engine_b_frequency_rate_unification`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L151-L167) - 엔진 A (`movingFrequencyRate`)와 엔진 B (`frequencyBudget_eq`, 배가 계수 `2 * Bs` 및 `Bz + 16`)의 통합.
- **Theorem 28**: [`thm_28_overlap_graph_component_merge_bound`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L168-L179) - 겹침 그래프 연결 성분 병합 한계 `4(r - t) <= r \implies 4t >= 3r` (`t >= (3/4)r`).
- **Theorem 29**: [`thm_29_bad_arrangement_multinomial_decay_three_quarters`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L180-L193) - 나쁜 순열 다항 감쇠율 `<= -3/4 = -15/20 = -0.75`.
- **Theorem 30**: [`thm_30_net_contradiction_rate_minus_seven_twentieths`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L194-L212) - 정확한 최종 순 모순율 `2/5 - 3/4 <= -7/20 = -0.35 < 0` (`Scales.lean:85-87` `finalRate`).
- **Theorem 31**: [`thm_31_diagonal_good_permutation_rate_and_four_providers`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L213-L231) - 엔진 B의 4-공급자 상수(`Cs = 17, Ccov = 17, Bs = 200, BD_min = 322, C = 19`, 여유분 `65, -66, >= 67`).
- **Theorem 32**: [`thm_32_scheduled_gap_parameters_and_depth_reserves_engine_a`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L232-L248) - 엔진 A 깊이 문턱값 `4^3 = 64 < 120 <= 125 = 5^3` (`k >= 5`) 및 예비 계수 `896, >= 20480`.
- **Theorem 33**: [`thm_33_comparison_slot_complexity_bound`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L249-L263) - 비교 슬롯 복잡도 상한 `|D| <= 2` 및 `exp((2 + 1)L) = exp(3L)`.
- **Theorem 34**: [`thm_34_linear_k_log_2_dominates_logarithmic_4_log_k`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L264-L277) - 선형 감쇠 `-(7/20) k \log 2`가 상수·로그 오버헤드를 압도하여 `-(2B + 1)` 이하로 내려감을 증명.
- **Theorem 35**: [`thm_35_final_amplitude_upper_vs_lower_contradiction`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L278-L295) - 최종 뿌리 진폭 상한 `-(2B + 1)rm` 대 하한 `-2Brm`의 정면 모순.
- **Theorem 36**: [`thm_36_engine_a_15_step_conditional_discharge_spine`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L296-L309) - 엔진 A의 9단계 가설 소거 사슬 `>= 15 -> 12 -> 8 -> 7 -> 6 -> 5 -> 3 -> 1 -> 0`.
- **Theorem 37**: [`thm_37_engine_b_jacobsthal_and_prime_gaps_reuse_accounting`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L310-L324) - 전체 저장소 비중(`7,716 / 148,832 = 5.18%`) 및 엔진 B의 외부 `OAI` 임포트 `15 + 3 = 18`개.
- **Theorem 38**: [`thm_38_paper_9_sections_to_lean_subsystem_mapping`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L325-L342) - 프리프린트 줄 수 정산(`6,072`줄 + 루트 `>= 552`줄 >= `6,624`줄; `609199 = 100 * 6072 + 1999`).
- **Theorem 39**: [`thm_39_two_stage_analytic_combinatorial_contraction_comparison`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L343-L362) - 1단계(`-11/125 = -44/500`) 대 2단계(`<= -7/20 = -175/500`) 수축 지수 비교.
- **Theorem 40**: [`thm_40_master_ostmann_inverse_goldbach_synthesis_verdict`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L363-L380) - OpenAI `#013` 마스터 종합 판정.
- **Theorem 41**: [`thm_41_bad_arrangement_requires_majority_unsplit_leaves`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L381-L395) - 중첩 그래프 비분할 잎 과반 정리(`3r < 4t`이면 반드시 `r < 2*t1`이 되어 전체 잎의 절반 초과가 크기 `1`인 비분할 성분에 남아야 함을 증명).
- **Theorem 42**: [`thm_42_deranged_slot_pair_eliminates_bad_arrangements`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L396-L411) - 완전순열 슬롯 쌍에 의한 나쁜 순열 완전 소멸(`t1 = 0`이면 모든 `r >= 1`에서 `2t <= r` 및 `4(r - t) >= 2r > r`이 되어 `badArrangements`가 공집합이 됨을 증명).
- **Theorem 43**: [`thm_43_bad_component_max_size_quarter_bound`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L412-L427) - 나쁜 성분 최대 크기 4배 축소 상한(`a_c <= r - t + 1` 및 `4*a_c <= r + 4`, `ComponentFactorial.lean:34` 대비 4배 정밀화).
- **Theorem 44**: [`thm_44_master_contraction_rate_and_depth_reduction`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L428-L450) - 마스터 수축률 공식 `gamma_20 = 20 - 2*theta_20 - delta_20` (`7 -> 17 -> 19 -> 20`) 및 이진 트리 최소 깊이 단축(`k_min: 7041 -> 5340 -> 2036 -> 1803 -> 1040`, `>= 6,001`단계 단축).
- **Theorem 45**: [`thm_45_supply_contraction_favorable_mass_expansion`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L451-L475) - 5절 푸리에 공급 수축 정밀화(`kappa = 33/20, >= 17/10`), 쌍합 지수를 음수(`-13 < 0`, `<= -40 < 0`)로 유지하면서 우호적 소수 역수 질량을 `30/200 L` (`0.15 L`)에서 `44/200 L` (`0.22 L`, `+46.7%`) 및 `46/200 L` (`0.23 L`, `+53.3%`)로 확장.
- **Theorem 46**: [`thm_46_siegel_bound_effective_under_qrh_and_away_branch`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L476-L494) - `#003` QRH (`K_qrh = 8`, `L_sec3_qrh = 39613`) 및 `SiegelBoundProof.lean`의 `¬ hnear` 분기(`K_away >= 1600`, `L_sec3_away = 56170`)에서의 3절 유효 상한 증명.
- **Theorem 47**: [`thm_47_tatuzawa_effective_single_exception_and_extended_deletion_budget`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L495-L512) - 타투자와 정리(`denom_no_root = 384002`) 및 확장 소수 제거 예산 `card_D_ext <= 3`을 통한 무조건부 유효 우회(`L >= 15001`에서 잔여 조화 질량 `2*L - 10000*card_D_ext >= 2`).
- **Theorem 48**: [`thm_48_combinatorial_2k_cancellation_in_bulk_exp_margin`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L513-L527) - `eventually_bulk_exp_margin`에서의 `2^k` 인수 약분 및 `k >= 5, L >= 1` 조건에서의 자동 충족(`req_cancelled = 40*k < 125*k <= m_lower`).
- **Theorem 49**: [`thm_49_explicit_effective_loglog_threshold_bottleneck_shift`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L528-L551) - 명시적 유효 로그-로그 문턱값 도출 및 단축(`L_sec3_tat = 87689 < L_eff_ultra = 255983 < L_eff_sharp = 640722 < L_eff_gpt >= 4115904`, `log log X_0`를 `>= 3,475,182` 및 `>= 3,859,921`만큼 단축).
- **Theorem 50**: [`thm_50_effective_ostmann_counterexample_bound_master`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L552-L564) - 유효 오스트만 반례 증인 마스터 정리(`PublishedSiegelBound` 분해 파일 `33 - 32 = 1`개 규명 및 `N0 < X_min <= n_wit <= X_max` 구성적 반례 존재 증명).

### 파일 3: [`proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L1-L420) (`20`개 정리)
- **Theorem 56**: [`thm_56_common_center_lift_difference_cancellation`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L54-L65) - 공통 중심 합동 이동 항 소거 `(a*n - a*t) - (a*m - a*t) = a*(n - m)` 및 나눗셈 보존(`CommonCenterCongruences.lean:14`).
- **Theorem 57**: [`thm_57_common_center_crt_uniqueness_below_modulus`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L66-L89) - 교집합 소수 곱 `P_inter > |n - m|` 아래에서의 CRT 유일성(`k = 0 \wedge n = m`, `CommonCenterLiftBounds.lean:12`).
- **Theorem 58**: [`thm_58_incidence_second_moment_cauchy_schwarz`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L90-L113) - 3-중심 교차 모멘트의 라그랑주 분산 분해 `3(I1^2 + I2^2 + I3^2) - (I1 + I2 + I3)^2 = (I1 - I2)^2 + (I2 - I3)^2 + (I3 - I1)^2 >= 0` (`CommonCenter.lean:20`).
- **Theorem 59**: [`thm_59_bonami_two_mode_fourth_moment_excess`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L114-L135) - 보나미 2-모드 4차 모멘트 초과 항등식 `(a + b)^4 + (a - b)^4 - 2(a^4 + b^4) = 12*a^2*b^2 = 3*(2*a*b)^2 >= 0` (`03-quadratic.tex:558-594`).
- **Theorem 60**: [`thm_60_heath_brown_bilinear_square_defect`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L136-L152) - 히스-브라운 쌍선형 이차형식 완전제곱 `(u + v)^2 - 4*u*v = (u - v)^2 >= 0` (`03-quadratic.tex:720-780`).
- **Theorem 61**: [`thm_61_balanced_support_variance_quadratic_lower_bound`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L153-L187) - 균형 잉여류 대역(`p <= 3*s <= 2*p`)의 이차 분산 하한 `9*s*(p - s) - 2*p^2 = (3*s - p)*(2*p - 3*s) >= 0` (`BalancedKernelBlocks.lean:11`).
- **Theorem 62**: [`thm_62_rank2_transfer_kernel_characteristic_discriminant`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L188-L205) - 대칭 `2x2` 전달 커널 특성다항식 및 판별식 `(a + d)^2 - 4*(a*d - b^2) = (a - d)^2 + 4*b^2 >= 0` (`05-supply.tex:277` Lemma 5.2).
- **Theorem 63**: [`thm_63_schur_complement_quadratic_contraction`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L206-L223) - 슈어 보수 완전제곱 `(a*x + b*y)^2 + (a*d - b^2)*y^2 >= 0` (`b^2 <= a*d`, `05-supply.tex:310`).
- **Theorem 64**: [`thm_64_square_kernel_trace_and_double_slope`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L224-L242) - 제곱 커널 `K^2`의 대각합 `w^2 + 2*u*v <= 3*w^2` 및 주 감쇠 기울기 배증(`t0 + t0 = 2*t0 = 34 > 32`, `BalancedKernelBlocks.lean:11`).
- **Theorem 65**: [`thm_65_affine_collision_polynomial_factorization`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L243-L259) - 아핀 연산자 충돌 다항 인수분해 `(u1 - u1^2*t) - (u2 - u2^2*t) = (u1 - u2)*(1 - (u1 + u2)*t)` (`06-tree.tex:137-180`).
- **Theorem 66**: [`thm_66_affine_quadratic_three_way_collision_vandermonde`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L260-L276) - 반데르몽드 3중 충돌 선형 인수 차이 `(1 - (u1 + u2)*t) - (1 - (u2 + u3)*t) = (u3 - u1)*t` (`06-tree.tex:181-210`).
- **Theorem 67**: [`thm_67_affine_pair_mobius_numerator_identity`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L277-L290) - 아핀 쌍 뫼비우스 분자 항등식 `(lam*d)*(lam*d - 1) - (lam*d - 1)^2 = lam*d - 1` (`AffinePairAlgebra.lean:10`).
- **Theorem 68**: [`thm_68_reciprocal_twist_involution_phase_cancellation`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L291-L313) - 대합 `sigma^2 = 1` 아래 역수 비틀림 위상 소거 `(-a*sigma)*x - (-a*sigma)*z = (-a*d)*sigma^2 = -a*d` (`AffinePairIdentity.lean:12`).
- **Theorem 69**: [`thm_69_cauchy_2x2_determinant_polynomial_identity`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L314-L331) - 분모 소거 `2x2` 코시 행렬식 항등식 `(b1 - a2)*(b2 - a1) - (b1 - a1)*(b2 - a2) = (b2 - b1)*(a1 - a2)` (`08-arithmetic.tex` `eq:arith-numerator`).
- **Theorem 70**: [`thm_70_cauchy_2x2_determinant_strict_positivity`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L332-L348) - 정렬된 가산항 쌍(`a2 < a1, b1 < b2`)에서 코시 행렬식의 엄격한 양수성(`>= 1`) 및 비소멸(`!= 0`, `08-arithmetic.tex` `eq:arith-internal-tests`).
- **Theorem 71**: [`thm_71_schwartz_zippel_weighted_root_bound`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L349-L367) - 비균등 슈바르츠-지펠 영점 측도 상한 `r*alpha <= D*alpha` (`AccidentalDivisibility.lean:9`).
- **Theorem 72**: [`thm_72_prime_factors_pow2_lower_bound`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L368-L381) - 구조적 귀납법(`induction k`)으로 증명한 서로 다른 소인수 개수 상한 `k + 1 <= 2^k` (`AccidentalDivisibility.lean:9`).
- **Theorem 73**: [`thm_73_bulk_quadratic_congruence_factorization`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L382-L390) - 벌크 이차 합동식 근 분리를 위한 제곱차 인수분해 `(y - d)*(y + d) = y^2 - d^2` (`08-arithmetic.tex` `eq:arith-square-congruence`).
- **Theorem 74**: [`thm_74_universal_ostmann_system_contraction`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L391-L408) - 추상 공리 구조체 `OstmannContractionSystem`의 전역 수축(`<= -18*m`) 및 코시 행렬식 비소멸(`RH31`).
- **Theorem 75**: [`thm_75_countermodel_cauchy_det_vanishes_when_degenerate`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L409-L420) - 퇴화 조건 `a1 = a2`에서의 코시 행렬식 항등 소멸 반례(`¬(det != 0)`) 및 `ostmannEngineBWitness` 검증(`RH31`).
