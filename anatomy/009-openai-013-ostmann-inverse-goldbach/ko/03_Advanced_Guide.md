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

---

## 4. 3세대 진화 트리, 4대 화석 층위 복원(`381`개 파일), 4가지 내부 형식화 꼼수, 날카로운 돌파구 증명 (`thm_41`~`thm_45`)

### 4.1 3세대 진화 트리와 4대 화석 층위 (`381`개 고립 파일, `39,517`줄)
진입점에서 도달하지 않는 `381`개 화석 파일(`39,517`줄, `66`개 연결 성분, 내부 최대 허브 `Arithmetic/StepwiseQuantitativeInduction.lean` 피호출 `234`회 및 `Construction/SelectedScheduledIteration.lean` 피호출 `71`회)의 의존성 그래프를 역추적하면 **3세대 진화 트리**가 복원됩니다:
- **1A세대 (화석 패리티 원형, `379`개 파일)**: `Construction/SelectedScheduledIteration.lean` $\to$ `Arithmetic/StepwiseQuantitativeInduction.lean` $\to$ `Construction/FinalExponentialContradiction.lean`. 패리티·지표 상쇄($-r \log r$)로 선형 오버헤드 $(6\log 2 + 16)r$를 제압하여 최소 깊이 $k_{\min} = 1040$에서 모순을 완결했으나, 이동 절단(`MovingCutoff`)의 층위 가중치 $j\log 2$를 흡수하지 못해 분리되었습니다.
- **1B세대 (현역 엔진 A, `3,165`개 파일)**: `SelectedScheduledIteration.lean`을 `SelectedScheduledMovingIteration.lean` + `Arithmetic/MovingFrequencyBudget.lean` + `Construction/SelectedScheduledFinalContradiction.lean`으로 교체하여 $+\frac{2}{5}r\log r$ 이동 주파수 예산을 도입하고 $k_{\min} = 5340$에서 종결했습니다.
- **2세대 (현역 엔진 B, `4,175`개 파일)**: 논문 9개 절과 1:1로 대응하는 10개 폴더 구조(`Conclusion/Scales.lean`, `ActualFourComparisonConsumer.lean`)로 재구축하고, 최상위에 `All.lean`과 `PaperMain.lean`(`2`개 루트 화석)을 남겼습니다.

`381`개 화석 파일은 역할에 따라 **4개 지층**으로 나뉩니다:
1. **지층 I (`350`개 파일: `Arithmetic` `264` + `Construction` `86`)**: 1A세대 패리티 모순 엔진 전체(`FinalExponentialContradiction.lean`, `FinalReassignments.lean`, `StepwiseQuantitativeInduction.lean`).
2. **지층 II (`19`개 파일: `Quadratic` `10` + `Characters` `8` + `QuadraticCenter` `1`)**: 초기 4차 모멘트·이중 지표합 원형(`FourthMomentBound.lean`, `PrimeDoubleCharacterSum.lean`).
3. **지층 III (`ZeroDensity/` `7`개 파일)**: 독자 구축하다 중단된 경로 적분 영점 밀도 다리(`ContourIntegralBound.lean`, `ZeroSumBound.lean`, `ExplicitFormulaBridge.lean`). 엔진 B에서는 `#021`(`Jacobsthal`)과 `#026`(`PrimeGaps`)의 외부 모듈 `18`개 호출로 대체되었습니다.
4. **지층 IV (`5`개 파일: `Tree` `2` + `Preliminaries` `1` + 루트 `2`)**: `Tree/SlotPermutationDecomposition.lean`, `Tree/TreeTransferTheorem.lean`, `Preliminaries/PrimeSumsetReduction.lean`, `All.lean`, `PaperMain.lean`.

### 4.2 `7,716`개 파일 전수 선언 스캔 및 4가지 실제 형식화 타협점
`OAI/NumberTheory/Ostmann/` 내부 `7,716`개 파일과 외부 `OAI` 전이 임포트 원뿔 전체(`Complete.lean` `3,165 + 42 = 3,207`개, `Main.lean` `4,175 + 183 = 4,358`개)를 전수 스캔한 결과, `sorry`·`axiom`·`opaque`·`unsafe`는 `0`건이며 모든 핵심 수론·해석 대상(`Nat.Prime`, `DirichletCharacter.LFunction`, `analyticOrderNatAt`, `ArithmeticFunction.vonMangoldt`, `jacobiSym`, `Squarefree`, `SimpleGraph.ConnectedComponent`, `Quotient`)이 표준 Mathlib 정의를 그대로 사용함을 확인했습니다. 동시에 엔진 A, 엔진 B, 그리고 `381`개 화석을 줄 단위로 대조하면 전술 자동화를 위해 상한을 느슨하게 잡은 **4가지 실제 형식화 타협점**이 확인됩니다:
1. **타협점 1 (`Tree/ArrangementGraph.lean:12`, `Conclusion/OverlapComponents.lean:10`: 곱 대칭군 $S_{rm}$ 대 슬롯별 순열군 $(S_r)^m$)**: 두 현역 엔진은 화석 `Construction/FinalReassignments.lean`의 슬롯별 순열군 $(S_r)^m$ 대신 전체 곱 대칭군 `Equiv.Perm (Fin r × Fin m)`($S_{rm}$, 크기 $(rm)!$) 위에서 대칭화합니다. $S_{rm}$에서는 한 잎의 $m$개 슬롯이 모두 같은 잎으로 몰릴 수 있어 크기 $1$인 비분할 성분($a_c = 1$)이 발생하며, 이를 제어하기 위해 다항 계수 상한 $r^{2r}\exp((\frac{5}{4} - \frac{3}{4}\log r)rm)$을 사용했습니다.
2. **타협점 2 (`Tree/ComponentFactorial.lean:35–53`, `Conclusion/ComponentFactorials.lean:21–33`: 성분별 $\log a_i \le \log r$ 일괄 상한)**: 두 엔진 모두 분할 항등식 $\sum_i (a_i - 1) = r - t$를 적용하기 직전에 개별 성분의 로그 인수를 $a_i \le r$ (`Finset.single_le_sum`)에 의해 $\log a_i \le \log r$로 일괄 상한 처리하여, 나쁜 순열 영역($4(r - t) \le r$)에서 가능한 최대 성분 크기 상한 $a_i \le r - t + 1 \le r/4 + 1$ 대비 4배의 여유분을 남겼습니다.
3. **타협점 3 (`Conclusion/Scales.lean:51–73` 닫힌꼴 정의 대 `Arithmetic/MovingFrequencyBudget.lean:51–86` 유한합 귀납법)**: 엔진 A(`MovingFrequencyBudget.lean`)는 `Finset.range k` 위의 유한합으로 이진 트리 합을 정의한 반면, 엔진 B(`Conclusion/Scales.lean:51–53`)는 `sum_dyadic`과 `sum_dyadic_log`를 처음부터 닫힌 공식(`2^k - 1` 및 `(k - 2)2^k \log 2 + 2\log 2`)으로 정의하고 1단계 점화식만 확인했습니다(본 해부의 `thm_21`~`thm_23`에서 구조적 귀납법 `induction k`로 완전 연결).
4. **타협점 4 (`Supply/ContractionConstants.lean:45` 반올림 상수 $\kappa = 8/5$ 및 `Conclusion/ActualComparisonObstructionInterface.lean:22–57` 오버헤드 패딩)**: 국소 파르세발 수축 상수를 $\kappa = 33/20 = 1.65$에서 $8/5 = 1.60$으로 반올림하고 초기·단계 오버헤드를 $B_s = 200, B_D = 322$로 넉넉히 패딩하여, 최소 이진 트리 깊이가 엔진 B 기준 $k_{\min} = 7,041$(엔진 A `5,340`)로 커졌습니다.

### 4.3 화석 복원 및 4대 날카로운 돌파구 증명 (`thm_41`~`thm_45`)
1. **돌파구 1 (중첩 그래프 비분할 잎 과반 정리 및 나쁜 순열 완전 소멸, `thm_41`·`thm_42`)**:
   $r$개 잎 위의 균형 $m$-정칙 중첩 그래프에서 연결 성분 $t = t_1 + t_{\ge 2}$개 중 크기 $1$인 비분할 성분을 $t_1$개, 크기 $2$ 이상인 성분을 $t_{\ge 2}$개라 하면 $2(t - t_1) \le r - t_1 \implies 2t \le r + t_1$입니다. 따라서 나쁜 순열 조건 $3r < 4t$가 성립하려면 반드시 $r < 2t_1$이어야 합니다([`thm_41_bad_arrangement_requires_majority_unsplit_leaves`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L396-L404)). 즉 전체 잎의 절반 초과가 크기 $1$ 성분에 머물러야 합니다. 화석 `Construction/FinalReassignments.lean`의 슬롯별 순열군 $S_r^m$을 복원하여 단 한 쌍의 슬롯이라도 완전순열($\sigma_2(l) \neq \sigma_1(l)$)로 배정하면 $t_1 = 0$이 강제되어, 모든 $r \ge 1$에서 $2t \le r$ 및 $4(r - t) \ge 2r > r$이 성립합니다([`thm_42_deranged_slot_pair_eliminates_bad_arrangements`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L411-L421)). 이로써 **나쁜 순열 집합이 공집합($\text{card}(\text{Bad}) = 0$)이 되어** 다항 계수 근사 없이 나쁜 순열 항이 완전히 사라집니다.
2. **돌파구 2 (나쁜 성분 최대 크기 4배 축소, `thm_43`)**:
   분할 항등식 $a_c + \sum_{c' \neq c} a_{c'} = r$과 나머지 $t - 1$개 성분의 하한 $\sum_{c' \neq c} a_{c'} \ge t - 1$을 나쁜 순열 조건 $4(r - t) \le r$과 결합하면 $a_c \le r - t + 1$ 및 $4a_c \le r + 4$가 성립합니다([`thm_43_bad_component_max_size_quarter_bound`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L427-L434)). 이는 `ComponentFactorial.lean:34`의 자명한 상한 $a_c \le r$을 4배 조인 결과입니다.
3. **돌파구 3 (마스터 수축률 공식 및 이진 트리 최소 깊이 $85\%$ 단축, `thm_44`)**:
   나쁜 병합 임계치 $\theta \in [0, 1/2)$ ($r - t \le \theta r$)와 단계별 절단 지수 $\delta_{\text{step}} > 0$에 대한 순 수축률은
   $$\gamma(\theta, \delta_{\text{step}}) = (1 - \theta) - (\theta + \delta_{\text{step}}) = 1 - 2\theta - \delta_{\text{step}}$$
   입니다([`thm_44_master_contraction_rate_and_depth_reduction`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L443-L459)). GPT 기본값 $(\theta, \delta_{\text{step}}) = (5/20, 3/20)$ ($\gamma = 7/20 = 0.35$, 엔진 B $k_{\min} = 7041$ / 엔진 A $5340$)을 $(1/20, 1/20)$으로 조율하면 $\gamma = 17/20 = 0.85$ ($k_{\min} = 2036$), 완전순열 $t_1 = 0$ $(0, 1/20)$을 적용하면 $\gamma = 19/20 = 0.95$ ($k_{\min} = 1803$), 1A세대 패리티 화석 $(0, 0)$을 복원하면 $\gamma = 20/20 = 1.00$ ($k_{\min} = 1040$, 이진 트리 깊이 `6,001`단계 단축)에 도달합니다.
4. **돌파구 4 (5절 우호적 소수 역수 질량 $+46.7\% \sim +53.3\%$ 확장, `thm_45`)**:
   `Supply/ContractionConstants.lean:45`(`local_strict_norm_numerical`)와 `Supply/CoverageMargin.lean:114`에서 반올림된 국소 파르세발 수축 상수 $\kappa = 8/5 = 32/20$ ($H = 68/100 L$) 대신 무손실 상수 $\kappa = 33/20 = 1.65$ ($H = 61/100 L$) 및 점근 극한 $\kappa = 17/10 = 34/20$ ($H = 60/100 L$)을 적용하면, 스케일된 쌍합 지수 $2000 - \kappa_{20} H_{100}$을 엄격한 음수($-13 < 0$ 및 $-40 < 0$)로 유지하면서 우호적 소수 역수 합 하한을 $30/200 L$($0.15 L$)에서 $44/200 L$($0.22 L$, $+46.7\%$) 및 $46/200 L$($0.23 L$, $+53.3\%$)로 확장합니다([`thm_45_supply_contraction_favorable_mass_expansion`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L466-L479)).
