# 고급 가이드: 쌍둥이 증명 엔진(`Complete.lean` 대 `Main.lean`)의 포렌식 층위학과 전 구간(`∀ k`) 귀납 검증

## 1. `OAI/NumberTheory/Ostmann/` 전체 `7,716`개 파일(`609,199`줄)의 4원 층위 분할

`OAI/NumberTheory/Ostmann/` 내부의 `7,716`개 `.lean` 파일 전체에 대한 `import` 의존성 그래프 전수 분석 결과는 [`thm_01_ostmann_directory_inclusion_exclusion_partition`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L20-L43), [`thm_02_shared_intersection_five_files_accounting`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L44-L60), [`thm_03_unreachable_orphan_381_files_accounting`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L61-L84)에 정확히 형식화되어 있습니다:

| 층위(Stratum) | 파일 수 | 코드 줄 수 | 도달 가능 코드 대비 비중 | 아키텍처 특징 |
| :--- | :---: | :---: | :---: | :--- |
| **엔진 A (`Complete.lean` 원뿔)** | `3,165` | `266,820` | `46.84%` | 하향식 15개 가설 소거 척추(`InverseGoldbach.lean` $\to$ `Complete.lean`); 외부 `OAI` 임포트 `1`개 |
| **엔진 B (`Main.lean` 원뿔)** | `4,175` | `303,234` | `53.23%` | 상향식 `Actual*` 4-공급자 결합기(`ActualFourComparisonConsumer.lean`, `Cs = 17, Ccov = 17`); 외부 `OAI` 임포트 `18`개 |
| **공유 코어 (`Complete ∩ Main`)** | `5` | `372` | `0.0653%` | `Defs.lean` (`46`), `Statement.lean` (`2`), `Endpoint.lean` (`190`), `FiniteCRT.lean` (`68`), `FiniteFactor.lean` (`66`) |
| **도달 가능 합집합 (`Complete ∪ Main`)** | `7,335` | `569,682` | `100.00%` | $3165 + 4175 - 5 = 7335$개 파일; $266820 + 303234 - 372 = 569682$줄 |
| **미사용 고아 화석 (`Orphans`)** | `381` | `39,517` | — | `Arithmetic` (`264`), `Construction` (`86`), `Quadratic` (`10`), `Characters` (`8`), `ZeroDensity` (`7`), `Tree` (`2`), `Preliminaries` (`1`), `QuadraticCenter` (`1`), `All.lean` + `PaperMain.lean` (`2`) |
| **`OAI/NumberTheory/Ostmann/` 총계** | **`7,716`** | **`609,199`** | — | $7335 + 381 = 7716$개 파일; $569682 + 39517 = 609199$줄 |

---

## 2. 엔진 A(`Complete`) 대 엔진 B(`Main`)의 정밀 아키텍처 비교

### 2.1 엔진 A의 9단계 하향식 가설 소거 척추 (`thm_36`)
엔진 A에서 `InverseGoldbach.lean`(`L45–61`)은 `15`개의 명시적 해석·체 가설(`P0 : PublishedProgressionInput`, `hM : MertensEstimate C`, `hS : ShiftedSieveInput`, `hE : ElsholtzSummandBounds`, `hCol : CollisionStabilityInput` 등) 아래에서 조건부 주정리를 선언합니다. 이어지는 9개의 래퍼 모듈이 이 `15`개 가설을 단계별로 소거하여 `0`개로 만듭니다([`thm_36_engine_a_15_step_conditional_discharge_spine`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L296-L316)):
1. `InverseGoldbach.lean`: 미해결 가설 `15`개
2. `ReducedPublishedInputs.lean`: 미해결 가설 `12`개 (`3`개 소거)
3. `MainWithoutPage.lean`: 미해결 가설 `8`개 (`4`개 소거)
4. `MainActualProgression.lean`: 미해결 가설 `7`개 (`1`개 소거)
5. `MainWithoutProgression.lean`: 미해결 가설 `6`개 (`1`개 소거)
6. `MainWithoutAdditiveSieve.lean`: 미해결 가설 `5`개 (`1`개 소거)
7. `MainWithoutSummandSize.lean`: 미해결 가설 `3`개 (`2`개 소거)
8. `MainWithoutSiegel.lean`: 미해결 가설 `1`개 (`2`개 소거)
9. `MainWithoutQuadraticSieve.lean` $\to$ `Complete.lean`: 미해결 가설 `0`개 (`1`개 소거; 합계 $3 + 4 + 1 + 1 + 1 + 2 + 2 + 1 = 15$).

엔진 A의 트리 모순부의 핵심 모듈은 `Construction/ScheduledAnalyticParameters.lean`(`L10–56`, 초기율 `6 * log 2 + 13`, 반복률 `6 * log 2 + 14`, 깊이 문턱값 $k^3 \ge 120 \iff k \ge 5$, [`thm_32_scheduled_gap_parameters_and_depth_reserves_engine_a`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L232-L248)), `Arithmetic/MovingFrequencyBudget.lean`(`L12–120`, `movingCutoffExponent` 및 `movingFrequencyRate` 정의, [`thm_27_engine_a_vs_engine_b_frequency_rate_unification`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L151-L167)), 그리고 `Construction/SelectedScheduledFinalContradiction.lean`(`L12–169`, [`thm_33_comparison_slot_complexity_bound`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L249-L263))입니다.

### 2.2 엔진 B의 상향식 4-공급자 결합기 (`thm_04`, `thm_31`, `thm_37`)
엔진 B에서 `Result.lean`(`L13–23`)과 `Conclusion/ActualNoDecomposition.lean`은 구체적 상수 $C_s = 17, C_{\mathrm{cov}} = 17$을 넣어 `Conclusion/ActualFourComparisonConsumer.lean`(`L14–55`)을 호출합니다([`thm_04_external_dependency_asymmetry_1_vs_18`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L85-L105), [`thm_31_diagonal_good_permutation_rate_and_four_providers`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L213-L231)):
- `ActualSingleComparisonProvider d 17`
- `ActualDiagonalGoodComparisonProvider d`
- `ActualBadCovarianceComparisonProvider d 17`
- `ActualGoodCovarianceComparisonProvider d`

`Conclusion/ActualComparisonObstructionInterface.lean`(`L22–57`) 내부에서 엔진 B는 $B_s = 200$, $B_z \ge 9$, $B_D \ge 200 + C_s + 105 = 322$, $C = C_{\mathrm{cov}} + 2 = 19$, 좋은 공분산 여유분 $65$, 목표 임계값 $\text{finalRate } B_D\, 200\, B_z\, 19\, k < -66$, 대각 좋은 순열 여유분 $67$을 설정합니다([`thm_31_diagonal_good_permutation_rate_and_four_providers`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L213-L231)). 또한 엔진 A와 달리 엔진 B는 지겔-발피시(Siegel-Walfisz) 및 명시적 공식 인프라를 위해 `#021`(`OAI.NumberTheory.Jacobsthal.*`, Erdős `#970`)에서 `15`개 파일, `#026`(`OAI.NumberTheory.PrimeGaps.*`, Problem 344)에서 `3`개 파일을 가져와 재사용합니다([`thm_37_engine_b_jacobsthal_and_prime_gaps_reuse_accounting`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L317-L331)).

### 2.3 왜 `#013`은 `#003`(`QRH`)에 전혀 의존하지 않는가 (`thm_16`~`thm_19`)
논문 `sections/05-supply.tex`의 비고 5.4(`Remark 5.4`, `L751–772`)는 만약 OpenAI `#003`(`\cite{openai2026quasiriemann}`, 영점 부재 영역 $\text{Re}(s) > 7/8$)을 인용하면 예외 영점 제거 없이 곧바로 $O_\phi(Q_b^2 X^{7/8}\log(2Q_b))$ ($1 - 7/8 = 1/8$ 거듭제곱 이득)를 얻는다고 언급합니다. 그러나 실제 본문 증명(`05-supply.tex` 보조정리 5.3, `L466–597`)과 두 Lean 엔진 모두 **`#003`을 단 한 줄도 임포트하지 않습니다**: 고전적인 몽고메리 영점 밀도 추정에서 $T = Q^5$로 잡아 $Q^2 T = Q^7$ (`slope_A = 21`)과 페롱 수평 꼬리 오차 $Q^2 T^{-2} = Q^{-8}$을 얻고([`thm_16_montgomery_zero_density_Q7_and_tail_Q_minus_8`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L324-L339), [`thm_17_zero_density_critical_exponent_crossover_at_sigma_half`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L340-L354)), 란다우-페이지 예외 실수 영점의 법 $q_{\mathrm{ex}}$를 나누는 소수를 $\mathcal{S}$에서 최대 1개(스케줄 집합 $D$에서 최대 2개)만 지워 무조건부로 증명을 완결합니다([`thm_18_page_exceptional_zero_single_prime_deletion_budget`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L355-L371), [`thm_19_qrh_003_citation_in_remark_5_4_is_strictly_optional`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L372-L386)).

---

## 3. 이진 트리 주파수 예산에 대한 전 구간(`∀ k : Nat`) 수학적 귀납법 검증 (`thm_21`~`thm_27`)

`Conclusion/Scales.lean`(`L51–83`) 및 `09-conclusion.tex`(`L355`)에서 트리 층위 $j = 0, \dots, k-1$ ($r_j = 2^j, r = 2^k$)에 걸친 단계별 주파수 간격의 합은 다음과 같습니다:
$$\sum_{j=0}^{k-1} \Delta_j = \sum_{j=0}^{k-1} 2^j \left(B_D + B_z \log z + \frac{2}{5}\log(2^j)\right) m.$$
[`ostmann_tree_transfers_and_permutation_contradiction.lean`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L17-L150)에서 재귀 함수 `dyadicSum`과 `weightedDyadicSum`을 정의하고 모든 자연수 $k \in \mathbb{N}$에 대한 구조적 귀납법(`induction k`)으로 다음을 기계 검증했습니다:
1. [`thm_21_dyadic_tree_leaf_sum_by_induction`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L30-L50):
   $$\text{dyadicSum}(k) = \sum_{j=0}^{k-1} 2^j = 2^k - 1.$$
2. [`thm_22_weighted_dyadic_level_sum_by_induction`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L51-L79):
   $$\text{weightedDyadicSum}(k) = \sum_{j=0}^{k-1} j 2^j = k 2^k - 2\cdot 2^k + 2 = (k - 2)2^k + 2.$$
3. [`thm_23_weighted_dyadic_strict_upper_bound_all_k`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L80-L102) 및 [`thm_26_frequency_budget_exact_closed_form_all_k`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L132-L150):
   $$k 2^k - \text{weightedDyadicSum}(k) = 2(2^k - 1) = 2\,\text{dyadicSum}(k) > 0 \quad (\forall k \ge 1).$$
   양변에 $\frac{2}{5}\log 2$를 곱하면 가중 합 $\frac{2}{5}\sum_{j=0}^{k-1} 2^j \log(2^j) = \frac{2}{5}(r\log r - 2r\log 2 + 2\log 2)$는 $\frac{2}{5}r\log r$보다 엄격히 작습니다. 이 $+\frac{2}{5}\log r$ 주파수 예산 성장률과 나쁜 순열의 $-\frac{3}{4}\log r$ 다항 감쇠율([`thm_28_overlap_graph_component_merge_bound`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L168-L179), [`thm_29_bad_arrangement_multinomial_decay_three_quarters`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L180-L193))을 결합하면 정확한 최종 모순율이 증명됩니다([`thm_30_net_contradiction_rate_minus_seven_twentieths`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L194-L212), [`thm_39_two_stage_analytic_combinatorial_contraction_comparison`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L357-L376), [`thm_40_master_ostmann_inverse_goldbach_synthesis_verdict`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L377-L389)):
   $$\text{finalRate}(k) = -\frac{7}{20}\log(2^k) + B_D + 2B_s + (B_z + 16)\log(k^4) + C \xrightarrow{k \to \infty} -\infty.$$
