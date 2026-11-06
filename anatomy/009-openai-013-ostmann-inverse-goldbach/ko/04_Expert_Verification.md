# 전문가 검증: 아티팩트 해시, 재현 명령, 55개 정리 1:1 매핑

## 1. 재현 명령

```bash
# 1. 독립형 Lean 4 커널 검증 (0 sorry, 2개 파일에 걸친 정리 55개 + 재귀 def 2개)
~/.elan/bin/lean proofs/ostmann_twin_engines_and_supply_contraction.lean && \
  ~/.elan/bin/lean proofs/ostmann_tree_transfers_and_permutation_contradiction.lean

# 2. 결정론적 기호(SymPy) 검증
python3 proofs/verify_symbolic_ostmann.py

# 3. 울타리 증명 해부 통합 게이트 (SHA-256 + 가설 변이 시험 + 줄 번호 링크 + 무힌트 명세 검사)
python3 ../../tools/verify_all.py --root .
```

## 2. 아티팩트 SHA-256 체크섬 표

| 아티팩트 파일 | SHA-256 체크섬 |
| :--- | :--- |
| [`proofs/ostmann_twin_engines_and_supply_contraction.lean`](../proofs/ostmann_twin_engines_and_supply_contraction.lean) | `522055ee8bbb20f5b9dc92cecc3546d72e476a75e8cbf5029c19897e3b089aee` |
| [`proofs/ostmann_tree_transfers_and_permutation_contradiction.lean`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean) | `727e3dcb4149aacb3beba1d87793c911002687bd7cc979abd20fb3f38a4d8d61` |
| [`proofs/verify_symbolic_ostmann.py`](../proofs/verify_symbolic_ostmann.py) | `372e75ff2e8e0274aee5d2ba8ae4ffc306c677263f164bc3b4a472590799a24e` |
| [`proofs/symbolic_verification_result.json`](../proofs/symbolic_verification_result.json) | `a4c633c4e291dbfc200f7ea4348f6da9232db260fc796b5f37668a3f87ecca63` |
| [`proofs/problem_spec.md`](../proofs/problem_spec.md) | `e40a539c681476cbc22768c1c14577d27dece9ae0bedb7b13098bf103d137b02` |

## 3. 전체 55개 정리 1:1 매핑 (`0 sorry`, 가설 변이 100% 격추)

### 파일 1: [`proofs/ostmann_twin_engines_and_supply_contraction.lean`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L1-L517)
- **Theorem 1**: [`thm_01_ostmann_directory_inclusion_exclusion_partition`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L20-L43) - `OAI/NumberTheory/Ostmann/` 포함-배제 분할: `3165 + 4175 - 5 = 7335`개 도달 가능 파일(`569,682`줄) + `381`개 고아 파일(`39,517`줄) = `7,716`개 파일(`609,199`줄).
- **Theorem 2**: [`thm_02_shared_intersection_five_files_accounting`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L44-L60) - `Complete ∩ Main` 공유 코어 5개 파일 줄 수 합산(`46 + 2 + 190 + 68 + 66 = 372`줄, 도달 가능 코드의 `< 0.1%`).
- **Theorem 3**: [`thm_03_unreachable_orphan_381_files_accounting`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L61-L84) - 미사용 고아 화석 파일 `381`개의 하위 폴더별 분해(`264 + 86 + 10 + 8 + 7 + 2 + 1 + 1 + 2 = 381`).
- **Theorem 4**: [`thm_04_external_dependency_asymmetry_1_vs_18`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L85-L105) - 외부 `OAI` 임포트 비대칭성: 엔진 A `1`개 대 엔진 B `18`개(`Jacobsthal` `15`개 + `PrimeGaps` `3`개, `Cs = 17, Ccov = 17`).
- **Theorem 5**: [`thm_05_complete_vs_main_logical_bridge_equivalence`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L106-L135) - `Complete.lean` (`inverseGoldbach`)과 `Main.lean` (`Ostmann.main`)의 명제 논리 동치 및 무한 가산항 환원.
- **Theorem 6**: [`thm_06_finite_summand_crt_dirichlet_composite_witness`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L136-L159) - 유한 가산항 CRT + 디리클레 합성수 증인(`s = f_a + b = k_mult * q_a > q_a >= 2`, `FiniteCRT.lean`, 보조정리 2.2).
- **Theorem 7**: [`thm_07_shifted_sieve_modulus_exponent_and_elsholtz_window`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L160-L176) - 이동 체 소수 곱 지수 `10 * j`, `b + 1 = 5`, 엘숄츠 로그 거듭제곱 창 `[-3, 2]` (폭 `5`).
- **Theorem 8**: [`thm_08_collision_stability_reciprocal_penalty_identity`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L177-L188) - 충돌 안정성 다항 항등식 `(p^2 - pa) + pa - 4(pa - a^2) = (2a - p)^2` (`1/\sigma_p + 1/(1-\sigma_p) - 4 = (2\sigma_p-1)^2/(\sigma_p(1-\sigma_p))`).
- **Theorem 9**: [`thm_09_unbalanced_density_penalty_lower_bound_one_half`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L189-L203) - 불균형 밀도 구간 `(1/3, 2/3)` 바깥에서의 벌점 하한 `>= 1/2` (`2(2a - p)^2 - a(p - a) = (p - 3a)(2p - 3a) >= 0`).
- **Theorem 10**: [`thm_10_quadratic_character_parameter_budget`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L204-L224) - 3절 이차 지표 매개변수 예산(`\rho = 3/5`, `T^{8/5}`, 꼬리 `9/10`, `\mu_0 = 10^{-6}`, `\gamma = 10^{-7}`, `K_denom = 50`).
- **Theorem 11**: [`thm_11_cauchy_schwarz_anchor_code_doubling`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L225-L239) - 4절 코시-슈바르츠 지표 인수 배가 `r_{d+1} = 2 r_d` 및 결손 예산 점화식.
- **Theorem 12**: [`thm_12_harmonic_band_mertens_budget_and_sparse_complement`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L240-L261) - 5절 조화 대역 `[1/20, 9/10]` (폭 `17/20 = 85%`), 목표 `3/20 = 15%`, 희소 여집합 `7/10 = 70%`, 문턱값 `17/25 = 68%` 위의 `2%` 메르텐스 여유분.
- **Theorem 13**: [`thm_13_local_transfer_polydisc_contraction_margin`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L262-L281) - 다중원판 블록 노름 `t_0 * R = (17/20)*(103/100) = 1751/2000 < 1900/2000 = 19/20` (여유분 `149/2000`).
- **Theorem 14**: [`thm_14_scalar_block_leading_slope_and_lemma_5_2_contraction`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L282-L302) - 스칼라 블록 주 기울기 `2 * t_0 = 17/10 = 1.7` 대 보조정리 5.2 국소 수축률 `c_loc = 8/5 = 1.6` (여유분 `1/10`).
- **Theorem 15**: [`thm_15_supply_contradiction_exponent_11_125`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L303-L323) - 5절 푸리에 공급 모순 지수 `1 - (8/5)*(17/25) = -11/125 = -0.088 < 0`.
- **Theorem 16**: [`thm_16_montgomery_zero_density_Q7_and_tail_Q_minus_8`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L324-L339) - 몽고메리 영점 밀도 보정 `T = Q^5 \implies Q^2 T = Q^7` (`slope_A = 21`) 및 페롱 꼬리 오차 `Q^2 T^{-2} = Q^{-8}`.
- **Theorem 17**: [`thm_17_zero_density_critical_exponent_crossover_at_sigma_half`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L340-L354) - 임계선 `\sigma = 1/2` 교차 및 `\sigma \in [1/2, 1]`에서의 `3(1 - \sigma) <= 2 - \sigma`.
- **Theorem 18**: [`thm_18_page_exceptional_zero_single_prime_deletion_budget`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L355-L371) - 란다우-페이지 예외 실수 영점 소수 제거 예산(`d_supply <= 1`, `d_sched <= 2`).
- **Theorem 19**: [`thm_19_qrh_003_citation_in_remark_5_4_is_strictly_optional`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L372-L386) - `#003` (`QRH`)으로부터의 완전 독립성: 두 엔진 모두 `OAI.NumberTheory.DirichletL` 임포트 `0`개.
- **Theorem 20**: [`thm_20_engine_a_vs_engine_b_supply_constants_bridge`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L387-L402) - `05-supply.tex`와 `Supply/NonsparseSupply.lean`의 5절 공급 상수 통합 검증.
- **Theorem 51**: [`thm_51_section3_bonami_high_weight_exponent_and_divisor_cap`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L413-L426) - 3절 증폭 모멘트(`lambda = 1/16`, `1 + lambda/3 = 49/48`), 약수 개수 상한 `omega(P) <= 7`, 보나미 고가중치 감쇠 계수 `tau / (8 * mu_0) = 625 >= 20`.
- **Theorem 52**: [`thm_52_section4_anchor_code_one_sided_dichotomy_and_margin`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L434-L449) - 4절 앵커 코드 단측 제곱 지표 이분법(`(±2, 0)` 또는 `(0, ±2)`) 및 단계당 엔트로피 여유분 `6931 - 60 = 6871` (`04-characters.tex:1058`, `Characters/AnchorOneSidedEdge.lean:10`).
- **Theorem 53**: [`thm_53_section6_bipartite_quartet_cycle_and_affine_hs_bound`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L458-L470) - 6절 성분-사중주 이분 다중그래프 순환 존재성(`V_bip <= E_bip`, `cycle_excess >= 1`)을 통한 `b <= 3r/4` 임계치의 기하학적 기원 및 아핀 힐베르트-슈미트 상한 `1 + 2 = 3` (`3/q^2`).
- **Theorem 54**: [`thm_54_section7_five_disjoint_prime_scale_hierarchy`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L479-L491) - 7~8절 5대 쌍별 서로소 이중 로그 소수 스케일 계층(`4 < 5 <= c_spec <= 10 < 40 <= c_bulk <= 60 < 100 = c_top_comp < 500 <= c_giant <= 9000`).
- **Theorem 55**: [`thm_55_section8_progression_table_zero_free_margins`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L498-L515) - 8절 2행 등차수열 스케일 표(`giant` 대 `bulk`)의 엄격한 부등식 사슬 `a_0 - theta > theta > delta' > delta > mu > 0` (`margin_g = 50`, `margin_b = 3`).

### 파일 2: [`proofs/ostmann_tree_transfers_and_permutation_contradiction.lean`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L1-L581)
- **Theorem 21**: [`thm_21_dyadic_tree_leaf_sum_by_induction`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L30-L50) - 모든 자연수 `k`에 대한 구조적 귀납법(`induction k`)으로 증명한 `dyadicSum k = 2^k - 1`.
- **Theorem 22**: [`thm_22_weighted_dyadic_level_sum_by_induction`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L51-L79) - 모든 자연수 `k`에 대한 구조적 귀납법(`induction k`)으로 증명한 `weightedDyadicSum k = k * 2^k - 2 * 2^k + 2`.
- **Theorem 23**: [`thm_23_weighted_dyadic_strict_upper_bound_all_k`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L80-L102) - 모든 `k : Nat`에 대한 정확한 여유 항등식 `k * 2^k - weightedDyadicSum k = 2 * (2^k - 1) = 2 * dyadicSum k`.
- **Theorem 24**: [`thm_24_single_diagram_second_moment_three_pow_r`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L103-L116) - 단일 다이어그램 2차 모멘트 밑 `1 + 2 = 3` (`3^r`) 및 주파수 구간 크기 `2V + 1 <= 3V`.
- **Theorem 25**: [`thm_25_section_7_schedule_scales_and_even_bulk_size`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L117-L131) - 짝수 벌크 크기 `m = 2 * half_m >= 4` 및 제곱근 예비항 흡수 `4m <= m^2`.
- **Theorem 26**: [`thm_26_frequency_budget_exact_closed_form_all_k`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L132-L150) - 모든 `k : Nat`에 대한 주파수 예산 닫힌꼴 결손 항등식 `2^k - S_k = 1` 및 `2 * slack_W = 4 * S_k`.
- **Theorem 27**: [`thm_27_engine_a_vs_engine_b_frequency_rate_unification`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L151-L167) - 엔진 A (`movingFrequencyRate`)와 엔진 B (`frequencyBudget_eq`, 배가 계수 `2 * Bs` 및 `Bz + 16`)의 통합.
- **Theorem 28**: [`thm_28_overlap_graph_component_merge_bound`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L168-L179) - 겹침 그래프 연결 성분 병합 한계 `4(r - t) <= r \implies 4t >= 3r` (`t >= (3/4)r`).
- **Theorem 29**: [`thm_29_bad_arrangement_multinomial_decay_three_quarters`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L180-L193) - 나쁜 순열 다항 감쇠율 `-3/4 = -15/20 = -0.75`.
- **Theorem 30**: [`thm_30_net_contradiction_rate_minus_seven_twentieths`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L194-L212) - 정확한 최종 순 모순율 `2/5 - 3/4 = -7/20 = -0.35 < 0` (`Scales.lean:85-87` `finalRate`).
- **Theorem 31**: [`thm_31_diagonal_good_permutation_rate_and_four_providers`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L213-L231) - 엔진 B의 4-공급자 상수(`Cs = 17, Ccov = 17, Bs = 200, BD_min = 322, C = 19`, 여유분 `65, -66, 67`).
- **Theorem 32**: [`thm_32_scheduled_gap_parameters_and_depth_reserves_engine_a`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L232-L248) - 엔진 A 깊이 문턱값 `4^3 = 64 < 120 <= 125 = 5^3` (`k >= 5`) 및 예비 계수 `896, 20480`.
- **Theorem 33**: [`thm_33_comparison_slot_complexity_bound`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L249-L263) - 비교 슬롯 복잡도 상한 `|D| <= 2` 및 `exp((2 + 1)L) = exp(3L)`.
- **Theorem 34**: [`thm_34_linear_k_log_2_dominates_logarithmic_4_log_k`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L264-L277) - 선형 감쇠 `-(7/20) k \log 2`가 상수·로그 오버헤드를 압도하여 `-(2B + 1)` 이하로 내려감을 증명.
- **Theorem 35**: [`thm_35_final_amplitude_upper_vs_lower_contradiction`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L278-L295) - 최종 뿌리 진폭 상한 `-(2B + 1)rm` 대 하한 `-2Brm`의 정면 모순.
- **Theorem 36**: [`thm_36_engine_a_15_step_conditional_discharge_spine`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L296-L316) - 엔진 A의 9단계 가설 소거 사슬 `15 -> 12 -> 8 -> 7 -> 6 -> 5 -> 3 -> 1 -> 0`.
- **Theorem 37**: [`thm_37_engine_b_jacobsthal_and_prime_gaps_reuse_accounting`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L317-L331) - 전체 저장소 비중(`7,716 / 148,832 = 5.18%`) 및 엔진 B의 외부 `OAI` 임포트 `15 + 3 = 18`개.
- **Theorem 38**: [`thm_38_paper_9_sections_to_lean_subsystem_mapping`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L332-L356) - 프리프린트 줄 수 정산(`6,072`줄 + 루트 `552`줄 = `6,624`줄; `609199 = 100 * 6072 + 1999`).
- **Theorem 39**: [`thm_39_two_stage_analytic_combinatorial_contraction_comparison`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L357-L376) - 1단계(`-11/125 = -44/500`) 대 2단계(`-7/20 = -175/500`) 수축 지수 비교.
- **Theorem 40**: [`thm_40_master_ostmann_inverse_goldbach_synthesis_verdict`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L377-L389) - OpenAI `#013` 마스터 종합 판정.
- **Theorem 41**: [`thm_41_bad_arrangement_requires_majority_unsplit_leaves`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L396-L404) - 중첩 그래프 비분할 잎 과반 정리(`3r < 4t`이면 반드시 `r < 2*t1`이 되어 전체 잎의 절반 초과가 크기 `1`인 비분할 성분에 남아야 함을 증명).
- **Theorem 42**: [`thm_42_deranged_slot_pair_eliminates_bad_arrangements`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L411-L421) - 완전순열 슬롯 쌍에 의한 나쁜 순열 완전 소멸(`t1 = 0`이면 모든 `r >= 1`에서 `2t <= r` 및 `4(r - t) >= 2r > r`이 되어 `badArrangements`가 공집합이 됨을 증명).
- **Theorem 43**: [`thm_43_bad_component_max_size_quarter_bound`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L427-L434) - 나쁜 성분 최대 크기 4배 축소 상한(`a_c <= r - t + 1` 및 `4*a_c <= r + 4`, `ComponentFactorial.lean:34` 대비 4배 정밀화).
- **Theorem 44**: [`thm_44_master_contraction_rate_and_depth_reduction`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L443-L459) - 마스터 수축률 공식 `gamma_20 = 20 - 2*theta_20 - delta_20` (`7 -> 17 -> 19 -> 20`) 및 이진 트리 최소 깊이 단축(`k_min: 7041 -> 5340 -> 2036 -> 1803 -> 1040`, `6,001`단계 단축).
- **Theorem 45**: [`thm_45_supply_contraction_favorable_mass_expansion`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L466-L479) - 5절 푸리에 공급 수축 정밀화(`kappa = 33/20, 17/10`), 쌍합 지수를 음수(`-13 < 0`, `-40 < 0`)로 유지하면서 우호적 소수 역수 질량을 `30/200 L` (`0.15 L`)에서 `44/200 L` (`0.22 L`, `+46.7%`) 및 `46/200 L` (`0.23 L`, `+53.3%`)로 확장.
- **Theorem 46**: [`thm_46_siegel_bound_effective_under_qrh_and_away_branch`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L491-L503) - `#003` QRH (`K_qrh = 8`, `L_sec3_qrh = 39613`) 및 `SiegelBoundProof.lean`의 `¬ hnear` 분기(`K_away = 1600`, `L_sec3_away = 56170`)에서의 3절 유효 상한 증명.
- **Theorem 47**: [`thm_47_tatuzawa_effective_single_exception_and_extended_deletion_budget`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L512-L523) - 타투자와 정리(`denom_no_root = 384002`) 및 확장 소수 제거 예산 `card_D_ext <= 3`을 통한 무조건부 유효 우회(`L >= 15001`에서 잔여 조화 질량 `2*L - 10000*card_D_ext >= 2`).
- **Theorem 48**: [`thm_48_combinatorial_2k_cancellation_in_bulk_exp_margin`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L530-L537) - `eventually_bulk_exp_margin`에서의 `2^k` 인수 약분 및 `k >= 5, L >= 1` 조건에서의 자동 충족(`req_cancelled = 40*k < 125*k <= m_lower`).
- **Theorem 49**: [`thm_49_explicit_effective_loglog_threshold_bottleneck_shift`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L545-L561) - 명시적 유효 로그-로그 문턱값 도출 및 단축(`L_sec3_tat = 87689 < L_eff_ultra = 255983 < L_eff_sharp = 640722 < L_eff_gpt = 4115904`, `log log X_0`를 `3,475,182` 및 `3,859,921`만큼 단축).
- **Theorem 50**: [`thm_50_effective_ostmann_counterexample_bound_master`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L569-L579) - 유효 오스트만 반례 증인 마스터 정리(`PublishedSiegelBound` 분해 파일 `33 - 32 = 1`개 규명 및 `N0 < X_min <= n_wit <= X_max` 구성적 반례 존재 증명).
