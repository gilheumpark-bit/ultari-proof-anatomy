# 고급 가이드: 쌍둥이 증명 엔진(`Complete.lean` 대 `Main.lean`)의 포렌식 층위학, 전 구간(`∀ k`) 귀납 검증 및 4대 대수 엔진 유도

## 1. `OAI/NumberTheory/Ostmann/` 전체 `7,716`개 파일(`609,199`줄)의 4원 층위 분할

`OAI/NumberTheory/Ostmann/` 내부의 `7,716`개 `.lean` 파일 전체에 대한 `import` 의존성 그래프 전수 분석 결과는 [`thm_01_ostmann_directory_inclusion_exclusion_partition`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L20-L43), [`thm_02_shared_intersection_five_files_accounting`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L44-L60), [`thm_03_unreachable_orphan_381_files_accounting`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L61-L84)에 정확히 형식화되어 있습니다:

| 층위(Stratum) | 파일 수 | 코드 줄 수 | 도달 가능 코드 대비 비중 | 아키텍처 특징 |
| :--- | :---: | :---: | :---: | :--- |
| **엔진 A ([`Complete.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Complete.lean#L1) 원뿔)** | `3,165` | `266,820` | `46.84%` | 하향식 15개 가설 소거 척추([`InverseGoldbach.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/InverseGoldbach.lean#L30) $\to$ [`Complete.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Complete.lean#L11)); 외부 `OAI` 임포트 `1`개 |
| **엔진 B ([`Main.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Main.lean#L1) 원뿔)** | `4,175` | `303,234` | `53.23%` | 상향식 `Actual*` 4-공급자 결합기(`ActualFourComparisonConsumer.lean`, `Cs = 17, Ccov = 17`); 외부 `OAI` 임포트 `18`개 |
| **공유 코어 (`Complete ∩ Main`)** | `5` | `372` | `0.0653%` | [`Defs.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Defs.lean#L1) (`46`), `Statement.lean` (`2`), [`Endpoint.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Endpoint.lean#L1) (`190`), [`FiniteCRT.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/FiniteCRT.lean#L1) (`68`), [`FiniteFactor.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/FiniteFactor.lean#L1) (`66`) |
| **도달 가능 합집합 (`Complete ∪ Main`)** | `7,335` | `569,682` | `100.00%` | $3165 + 4175 - 5 = 7335$개 파일; $266820 + 303234 - 372 = 569682$줄 |
| **미사용 고아 화석 (`Orphans`)** | `381` | `39,517` | - | `Arithmetic` (`264`), `Construction` (`86`), `Quadratic` (`10`), `Characters` (`8`), `ZeroDensity` (`7`), `Tree` (`2`), `Preliminaries` (`1`), `QuadraticCenter` (`1`), [`All.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/All.lean#L1) + [`PaperMain.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/PaperMain.lean#L1) (`2`) |
| **`OAI/NumberTheory/Ostmann/` 총계** | **`7,716`** | **`609,199`** | - | $7335 + 381 = 7716$개 파일; $569682 + 39517 = 609199$줄 |

---

## 2. 엔진 A(`Complete`) 대 엔진 B(`Main`)의 정밀 아키텍처 비교

### 2.1 엔진 A의 9단계 하향식 가설 소거 척추 (`thm_36`)
엔진 A에서 [`InverseGoldbach.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/InverseGoldbach.lean#L30-L30)은 `15`개의 명시적 해석·체 가설(`P0 : PublishedProgressionInput`, `hM : MertensEstimate C`, `hS : ShiftedSieveInput`, `hE : ElsholtzSummandBounds`, `hCol : CollisionStabilityInput` 등) 아래에서 조건부 주정리를 선언합니다. 이어지는 9개의 래퍼 모듈이 이 `15`개 가설을 단계별로 소거하여 `0`개로 만듭니다([`thm_36_engine_a_15_step_conditional_discharge_spine`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L296-L309)):
1. [`InverseGoldbach.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/InverseGoldbach.lean#L30): 미해결 가설 `15`개
2. `ReducedPublishedInputs.lean`: 미해결 가설 `12`개 (`3`개 소거)
3. `MainWithoutPage.lean`: 미해결 가설 `8`개 (`4`개 소거)
4. `MainActualProgression.lean`: 미해결 가설 `7`개 (`1`개 소거)
5. `MainWithoutProgression.lean`: 미해결 가설 `6`개 (`1`개 소거)
6. `MainWithoutAdditiveSieve.lean`: 미해결 가설 `5`개 (`1`개 소거)
7. `MainWithoutSummandSize.lean`: 미해결 가설 `3`개 (`2`개 소거)
8. `MainWithoutSiegel.lean`: 미해결 가설 `1`개 (`2`개 소거)
9. [`MainWithoutQuadraticSieve.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/MainWithoutQuadraticSieve.lean#L14) $\to$ [`Complete.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Complete.lean#L11): 미해결 가설 `0`개 (`1`개 소거; 합계 $3 + 4 + 1 + 1 + 1 + 2 + 2 + 1 = 15$).

엔진 A의 트리 모순부의 핵심 모듈은 [`Construction/ActualTransfer.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Construction/ActualTransfer.lean#L10)(초기율 `6 * log 2 + 13`, 반복률 `6 * log 2 + 14`, 깊이 문턱값 $k^3 \ge 120 \iff k \ge 5$, [`thm_32_scheduled_gap_parameters_and_depth_reserves_engine_a`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L232-L248)), [`Arithmetic/MovingStatisticDecay.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Arithmetic/MovingStatisticDecay.lean#L12)([`thm_27_engine_a_vs_engine_b_frequency_rate_unification`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L151-L167)), 그리고 `Construction/SelectedScheduledFinalContradiction.lean`([`thm_33_comparison_slot_complexity_bound`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L249-L263))입니다.

### 2.2 엔진 B의 상향식 4-공급자 결합기 (`thm_04`, `thm_31`, `thm_37`)
엔진 B에서 `Result.lean`과 `Conclusion/ActualNoDecomposition.lean`은 구체적 상수 $C_s = 17, C_{\mathrm{cov}} = 17$을 넣어 [`Conclusion/ActualComparisonContradiction.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Conclusion/ActualComparisonContradiction.lean#L14)을 호출합니다([`thm_04_external_dependency_asymmetry_1_vs_18`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L85-L105), [`thm_31_diagonal_good_permutation_rate_and_four_providers`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L213-L231)):
- `ActualSingleComparisonProvider d 17`
- `ActualDiagonalGoodComparisonProvider d`
- `ActualBadCovarianceComparisonProvider d 17`
- `ActualGoodCovarianceComparisonProvider d`

엔진 B는 $B_s = 200$, $B_z \ge 9$, $B_D \ge 200 + C_s + 105 = 322$, $C = C_{\mathrm{cov}} + 2 = 19$, 좋은 공분산 여유분 $65$, 목표 임계값 $\text{finalRate } B_D\, 200\, B_z\, 19\, k < -66$, 대각 좋은 순열 여유분 $67$을 설정합니다([`thm_31_diagonal_good_permutation_rate_and_four_providers`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L213-L231)). 또한 엔진 A와 달리 엔진 B는 지겔-발피시(Siegel-Walfisz) 및 명시적 공식 인프라를 위해 `#021`(`OAI.NumberTheory.Jacobsthal.*`, Erdős `#970`)에서 `15`개 파일, `#026`(`OAI.NumberTheory.PrimeGaps.*`, Problem 344)에서 `3`개 파일을 가져와 재사용합니다([`thm_37_engine_b_jacobsthal_and_prime_gaps_reuse_accounting`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L310-L324)).

### 2.3 왜 `#013`은 `#003`(`QRH`)에 전혀 의존하지 않는가 (`thm_16`~`thm_19`)
논문 [`05-supply.tex`](../proofs/oai_ref/tex/sections/05-supply.tex#L751-L772)의 비고 5.4(`Remark 5.4`)는 만약 OpenAI `#003`(`\cite{openai2026quasiriemann}`, 영점 부재 영역 $\text{Re}(s) > 7/8$)을 인용하면 예외 영점 제거 없이 곧바로 $O_\phi(Q_b^2 X^{7/8}\log(2Q_b))$ ($1 - 7/8 = 1/8$ 거듭제곱 이득)를 얻는다고 언급합니다. 그러나 실제 본문 증명([`05-supply.tex`](../proofs/oai_ref/tex/sections/05-supply.tex#L466-L597) 보조정리 5.3)과 두 Lean 엔진([`ZeroDensity/ComplexDensityProof.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/ZeroDensity/ComplexDensityProof.lean#L1) 및 [`Supply/ActualPageUniqueness.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/ZeroDensity/ActualPageUniqueness.lean#L16)) 모두 **`#003`을 단 한 줄도 임포트하지 않습니다**: 고전적인 몽고메리 영점 밀도 추정에서 $T = Q^5$로 잡아 $Q^2 T = Q^7$ (`slope_A = 21`)과 페롱 수평 꼬리 오차 $Q^2 T^{-2} = Q^{-8}$을 얻고([`thm_16_montgomery_zero_density_Q7_and_tail_Q_minus_8`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L324-L339), [`thm_17_zero_density_critical_exponent_crossover_at_sigma_half`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L340-L354)), 란다우-페이지 예외 실수 영점의 법 $q_{\mathrm{ex}}$를 나누는 소수를 $\mathcal{S}$에서 최대 1개(스케줄 집합 $D$에서 최대 2개)만 지워 무조건부로 증명을 완결합니다([`thm_18_page_exceptional_zero_single_prime_deletion_budget`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L355-L371), [`thm_19_qrh_003_citation_in_remark_5_4_is_strictly_optional`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L372-L386)).

---

## 3. 이진 트리 주파수 예산에 대한 전 구간(`∀ k : Nat`) 수학적 귀납법 검증 (`thm_21`~`thm_27`)

[`Conclusion/Scales.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Conclusion/Scales.lean#L51-L83) 및 [`09-conclusion.tex`](../proofs/oai_ref/tex/sections/09-conclusion.tex#L355)에서 트리 층위 $j = 0, \dots, k-1$ ($r_j = 2^j, r = 2^k$)에 걸친 단계별 주파수 간격의 합은 다음과 같습니다:
$$\sum_{j=0}^{k-1} \Delta_j = \sum_{j=0}^{k-1} 2^j \left(B_D + B_z \log z + \frac{2}{5}\log(2^j)\right) m.$$
[`ostmann_tree_transfers_and_permutation_contradiction.lean`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L17-L150)에서 재귀 함수 `dyadicSum`과 `weightedDyadicSum`을 정의하고 모든 자연수 $k \in \mathbb{N}$에 대한 구조적 귀납법(`induction k`)으로 다음을 기계 검증했습니다:
1. [`thm_21_dyadic_tree_leaf_sum_by_induction`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L30-L50):
   $$\text{dyadicSum}(k) = \sum_{j=0}^{k-1} 2^j = 2^k - 1.$$
2. [`thm_22_weighted_dyadic_level_sum_by_induction`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L51-L79):
   $$\text{weightedDyadicSum}(k) = \sum_{j=0}^{k-1} j 2^j = k 2^k - 2\cdot 2^k + 2 = (k - 2)2^k + 2.$$
3. [`thm_23_weighted_dyadic_strict_upper_bound_all_k`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L80-L102) 및 [`thm_26_frequency_budget_exact_closed_form_all_k`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L132-L150):
   $$k 2^k - \text{weightedDyadicSum}(k) = 2(2^k - 1) = 2\,\text{dyadicSum}(k) > 0 \quad (\forall k \ge 1).$$
   양변에 $\frac{2}{5}\log 2$를 곱하면 가중 합 $\frac{2}{5}\sum_{j=0}^{k-1} 2^j \log(2^j) = \frac{2}{5}(r\log r - 2r\log 2 + 2\log 2)$는 $\frac{2}{5}r\log r$보다 엄격히 작습니다. 이 $+\frac{2}{5}\log r$ 주파수 예산 성장률과 나쁜 순열의 $-\frac{3}{4}\log r$ 다항 감쇠율([`thm_28_overlap_graph_component_merge_bound`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L168-L179), [`thm_29_bad_arrangement_multinomial_decay_three_quarters`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L180-L193))을 결합하면 정확한 최종 모순율이 증명됩니다([`thm_30_net_contradiction_rate_minus_seven_twentieths`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L194-L212), [`thm_39_two_stage_analytic_combinatorial_contraction_comparison`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L343-L362), [`thm_40_master_ostmann_inverse_goldbach_synthesis_verdict`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L363-L380)):
   $$\text{finalRate}(k) = -\frac{7}{20}\log(2^k) + B_D + 2B_s + (B_z + 16)\log(k^4) + C \xrightarrow{k \to \infty} -\infty.$$

---

## 4. 3세대 진화 트리, 4대 화석 층위 복원(`381`개 파일), 4가지 내부 형식화 꼼수, 날카로운 돌파구 증명 (`thm_41`~`thm_55`)

### 4.1 3세대 진화 트리와 4대 화석 층위 (`381`개 고립 파일, `39,517`줄)
진입점에서 도달하지 않는 `381`개 화석 파일(`39,517`줄, `66`개 연결 성분, 내부 최대 허브 `Arithmetic/StepwiseQuantitativeInduction.lean` 피호출 `234`회 및 `Construction/SelectedScheduledIteration.lean` 피호출 `71`회)의 의존성 그래프를 역추적하면 **3세대 진화 트리**가 복원됩니다:
- **1A세대 (화석 패리티 원형, `379`개 파일)**: `Construction/SelectedScheduledIteration.lean` $\to$ `Arithmetic/StepwiseQuantitativeInduction.lean` $\to$ `Construction/FinalExponentialContradiction.lean`. 패리티·지표 상쇄($-r \log r$)로 선형 오버헤드 $(6\log 2 + 16)r$를 제압하여 최소 깊이 $k_{\min} = 1040$에서 모순을 완결했으나, 이동 절단(`MovingCutoff`)의 층위 가중치 $j\log 2$를 흡수하지 못해 분리되었습니다.
- **1B세대 (현역 엔진 A, `3,165`개 파일)**: `SelectedScheduledIteration.lean`을 `SelectedScheduledMovingIteration.lean` + `Arithmetic/MovingFrequencyBudget.lean` + `Construction/SelectedScheduledFinalContradiction.lean`으로 교체하여 $+\frac{2}{5}r\log r$ 이동 주파수 예산을 도입하고 $k_{\min} = 5340$에서 종결했습니다.
- **2세대 (현역 엔진 B, `4,175`개 파일)**: 논문 9개 절과 1:1로 대응하는 10개 폴더 구조([`Conclusion/Scales.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Conclusion/Scales.lean#L1), [`Conclusion/ActualComparisonContradiction.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Conclusion/ActualComparisonContradiction.lean#L1))로 재구축하고, 최상위에 [`All.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/All.lean#L1)과 [`PaperMain.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/PaperMain.lean#L1)(`2`개 루트 화석)을 남겼습니다.

`381`개 화석 파일은 역할에 따라 **4개 지층**으로 나뉩니다:
1. **지층 I (`350`개 파일: `Arithmetic` `264` + `Construction` `86`)**: 1A세대 패리티 모순 엔진 전체(`FinalExponentialContradiction.lean`, `FinalReassignments.lean`, `StepwiseQuantitativeInduction.lean`).
2. **지층 II (`19`개 파일: `Quadratic` `10` + `Characters` `8` + `QuadraticCenter` `1`)**: 초기 4차 모멘트·이중 지표합 원형(`FourthMomentBound.lean`, `PrimeDoubleCharacterSum.lean`).
3. **지층 III (`ZeroDensity/` `7`개 파일)**: 독자 구축하다 중단된 경로 적분 영점 밀도 다리(`ContourIntegralBound.lean`, `ZeroSumBound.lean`, `ExplicitFormulaBridge.lean`). 엔진 B에서는 `#021`(`Jacobsthal`)과 `#026`(`PrimeGaps`)의 외부 모듈 `18`개 호출로 대체되었습니다.
4. **지층 IV (`5`개 파일: `Tree` `2` + `Preliminaries` `1` + 루트 `2`)**: `Tree/SlotPermutationDecomposition.lean`, `Tree/TreeTransferTheorem.lean`, `Preliminaries/PrimeSumsetReduction.lean`, [`All.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/All.lean#L1), [`PaperMain.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/PaperMain.lean#L1).

### 4.2 `7,716`개 파일 전수 선언 스캔 및 4가지 실제 형식화 타협점
`OAI/NumberTheory/Ostmann/` 내부 `7,716`개 파일과 외부 `OAI` 전이 임포트 원뿔 전체(`Complete.lean` `3,165 + 42 = 3,207`개, `Main.lean` `4,175 + 183 = 4,358`개)를 전수 스캔한 결과, `sorry`·`axiom`·`opaque`·`unsafe`는 `0`건이며 모든 핵심 수론·해석 대상(`Nat.Prime`, `DirichletCharacter.LFunction`, `analyticOrderNatAt`, `ArithmeticFunction.vonMangoldt`, `jacobiSym`, `Squarefree`, `SimpleGraph.ConnectedComponent`, `Quotient`)이 표준 Mathlib 정의를 그대로 사용함을 확인했습니다. 동시에 엔진 A, 엔진 B, 그리고 `381`개 화석을 줄 단위로 대조하면 전술 자동화를 위해 상한을 느슨하게 잡은 **4가지 실제 형식화 타협점**이 확인됩니다:
1. **타협점 1 (`Tree/ArrangementGraph.lean:12`, `Conclusion/OverlapComponents.lean:10`: 곱 대칭군 $S_{rm}$ 대 슬롯별 순열군 $(S_r)^m$)**: 두 현역 엔진은 화석 `Construction/FinalReassignments.lean`의 슬롯별 순열군 $(S_r)^m$ 대신 전체 곱 대칭군 `Equiv.Perm (Fin r × Fin m)`($S_{rm}$, 크기 $(rm)!$) 위에서 대칭화합니다. $S_{rm}$에서는 한 잎의 $m$개 슬롯이 모두 같은 잎으로 몰릴 수 있어 크기 $1$인 비분할 성분($a_c = 1$)이 발생하며, 이를 제어하기 위해 다항 계수 상한 $r^{2r}\exp((\frac{5}{4} - \frac{3}{4}\log r)rm)$을 사용했습니다.
2. **타협점 2 (`Tree/ComponentFactorial.lean:35–53`, `Conclusion/ComponentFactorials.lean:21–33`: 성분별 $\log a_i \le \log r$ 일괄 상한)**: 두 엔진 모두 분할 항등식 $\sum_i (a_i - 1) = r - t$를 적용하기 직전에 개별 성분의 로그 인수를 $a_i \le r$ (`Finset.single_le_sum`)에 의해 $\log a_i \le \log r$로 일괄 상한 처리하여, 나쁜 순열 영역($4(r - t) \le r$)에서 가능한 최대 성분 크기 상한 $a_i \le r - t + 1 \le r/4 + 1$ 대비 4배의 여유분을 남겼습니다.
3. **타협점 3 ([`Conclusion/Scales.lean:51-73`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Conclusion/Scales.lean#L51-L73) 닫힌꼴 정의 대 `Arithmetic/MovingFrequencyBudget.lean:51–86` 유한합 귀납법)**: 엔진 A(`MovingFrequencyBudget.lean`)는 `Finset.range k` 위의 유한합으로 이진 트리 합을 정의한 반면, 엔진 B([`Conclusion/Scales.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Conclusion/Scales.lean#L51-L53))는 `sum_dyadic`과 `sum_dyadic_log`를 처음부터 닫힌 공식(`2^k - 1` 및 `(k - 2)2^k \log 2 + 2\log 2`)으로 정의하고 1단계 점화식만 확인했습니다(본 해부의 `thm_21`~`thm_23`에서 구조적 귀납법 `induction k`로 완전 연결).
4. **타협점 4 ([`Supply/ContractionConstants.lean:45`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Supply/ContractionConstants.lean#L45) 반올림 상수 $\kappa = 8/5$ 및 오버헤드 패딩)**: 국소 파르세발 수축 상수를 $\kappa = 33/20 = 1.65$에서 $8/5 = 1.60$으로 반올림하고 초기·단계 오버헤드를 $B_s = 200, B_D = 322$로 넉넉히 패딩하여, 최소 이진 트리 깊이가 엔진 B 기준 $k_{\min} = 7,041$(엔진 A `5,340`)로 커졌습니다.

### 4.3 화석 복원 및 5대 날카로운 돌파구 증명 (`thm_41`~`thm_50`)
1. **돌파구 1 (중첩 그래프 비분할 잎 과반 정리 및 나쁜 순열 완전 소멸, `thm_41`·`thm_42`)**:
   $r$개 잎 위의 균형 $m$-정칙 중첩 그래프에서 연결 성분 $t = t_1 + t_{\ge 2}$개 중 크기 $1$인 비분할 성분을 $t_1$개, 크기 $2$ 이상인 성분을 $t_{\ge 2}$개라 하면 $2(t - t_1) \le r - t_1 \implies 2t \le r + t_1$입니다. 따라서 나쁜 순열 조건 $3r < 4t$가 성립하려면 반드시 $r < 2t_1$이어야 합니다([`thm_41_bad_arrangement_requires_majority_unsplit_leaves`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L381-L395)). 즉 전체 잎의 절반 초과가 크기 $1$ 성분에 머물러야 합니다. 화석 `Construction/FinalReassignments.lean`의 슬롯별 순열군 $S_r^m$을 복원하여 단 한 쌍의 슬롯이라도 완전순열($\sigma_2(l) \neq \sigma_1(l)$)로 배정하면 $t_1 = 0$이 강제되어, 모든 $r \ge 1$에서 $2t \le r$ 및 $4(r - t) \ge 2r > r$이 성립합니다([`thm_42_deranged_slot_pair_eliminates_bad_arrangements`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L396-L411)). 이로써 **나쁜 순열 집합이 공집합($\text{card}(\text{Bad}) = 0$)이 되어** 다항 계수 근사 없이 나쁜 순열 항이 완전히 사라집니다.
2. **돌파구 2 (나쁜 성분 최대 크기 4배 축소, `thm_43`)**:
   분할 항등식 $a_c + \sum_{c' \neq c} a_{c'} = r$과 나머지 $t - 1$개 성분의 하한 $\sum_{c' \neq c} a_{c'} \ge t - 1$을 나쁜 순열 조건 $4(r - t) \le r$과 결합하면 $a_c \le r - t + 1$ 및 $4a_c \le r + 4$가 성립합니다([`thm_43_bad_component_max_size_quarter_bound`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L412-L427)). 이는 `ComponentFactorial.lean:34`의 자명한 상한 $a_c \le r$을 4배 조인 결과입니다.
3. **돌파구 3 (마스터 수축률 공식 및 이진 트리 최소 깊이 $85\%$ 단축, `thm_44`)**:
   나쁜 병합 임계치 $\theta \in [0, 1/2)$ ($r - t \le \theta r$)와 단계별 절단 지수 $\delta_{\text{step}} > 0$에 대한 순 수축률은
   $$\gamma(\theta, \delta_{\text{step}}) = (1 - \theta) - (\theta + \delta_{\text{step}}) = 1 - 2\theta - \delta_{\text{step}}$$
   입니다([`thm_44_master_contraction_rate_and_depth_reduction`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L428-L450)). GPT 기본값 $(\theta, \delta_{\text{step}}) = (5/20, 3/20)$ ($\gamma = 7/20 = 0.35$, 엔진 B $k_{\min} = 7041$ / 엔진 A $5340$)을 $(1/20, 1/20)$으로 조율하면 $\gamma = 17/20 = 0.85$ ($k_{\min} = 2036$), 완전순열 $t_1 = 0$ $(0, 1/20)$을 적용하면 $\gamma = 19/20 = 0.95$ ($k_{\min} = 1803$), 1A세대 패리티 화석 $(0, 0)$을 복원하면 $\gamma = 20/20 = 1.00$ ($k_{\min} = 1040$, 이진 트리 깊이 `6,001`단계 단축)에 도달합니다.
4. **돌파구 4 (5절 우호적 소수 역수 질량 $+46.7\% \sim +53.3\%$ 확장, `thm_45`)**:
   [`Supply/ContractionConstants.lean:45`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Supply/ContractionConstants.lean#L45)(`local_strict_norm_numerical`)에서 반올림된 국소 파르세발 수축 상수 $\kappa = 8/5 = 32/20$ ($H = 68/100 L$) 대신 무손실 상수 $\kappa = 33/20 = 1.65$ ($H = 61/100 L$) 및 점근 극한 $\kappa = 17/10 = 34/20$ ($H = 60/100 L$)을 적용하면, 스케일된 쌍합 지수 $2000 - \kappa_{20} H_{100}$을 엄격한 음수($-13 < 0$ 및 $-40 < 0$)로 유지하면서 우호적 소수 역수 합 하한을 $30/200 L$($0.15 L$)에서 $44/200 L$($0.22 L$, $+46.7\%$) 및 $46/200 L$($0.23 L$, $+53.3\%$)로 확장합니다([`thm_45_supply_contraction_favorable_mass_expansion`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L451-L475)).
5. **돌파구 5 (시겔 정리의 비효과성 완전 제거 및 명시적 유효 문턱값 도출, `thm_46`~`thm_50`)**:
   엔진 A에서 `PublishedSiegelBound`가 등장하는 `33`개 파일 중 `32`개는 가설을 단순 전달만 하며 단 `1`개(`ZeroDensity/HadamardPrimeBound.lean:48`, `Quadratic/QuadraticSplitSupply.lean:25`에서 $\varepsilon = 1/200, R = L_{\mathrm{quad}}^{100}$으로 1회 호출)만 이를 분해합니다([`thm_50_effective_ostmann_counterexample_bound_master`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L552-L564)). [`ZeroDensity/SiegelBoundProof.lean:81`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/ZeroDensity/SiegelBoundProof.lean#L81)의 `¬ hnear` 분기($\beta < 1599/1600$)는 이미 유효 상한 $K_{\mathrm{away}} = 1600$ ($L_{\mathrm{sec3, away}} = 56,170$)을 증명하며, `#003` QRH($\beta \le 7/8$) 결합 시 $K_{\mathrm{QRH}} = 8$ ($L_{\mathrm{sec3, QRH}} = 39,613$)이 됩니다([`thm_46_siegel_bound_effective_under_qrh_and_away_branch`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L476-L494)). 무조건부로도 타투자와 정리(`384,002`, $L_{\mathrm{sec3, Tat}} = 87,689$) + 디리클레 유수 공식 + 예외 도체 소인수 1개 추가 제거($|D_{\mathrm{ext}}| \le 3$, $L \ge 15,001$에서 잔여 질량 $2L - 30000 \ge 2 > 0$, [`thm_47_tatuzawa_effective_single_exception_and_extended_deletion_budget`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L495-L512))로 3절의 비효과성이 완전히 제거됩니다. 또한 [`Arithmetic/MovingStatisticDecay.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Arithmetic/MovingStatisticDecay.lean#L12)에서 $2^k$ 인수가 정확히 상쇄되므로([`thm_48_combinatorial_2k_cancellation_in_bulk_exp_margin`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L513-L527)), 전역 유효 문턱값은 [`Arithmetic/ArithmeticErrorRates.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Arithmetic/ArithmeticErrorRates.lean#L18)이 지배하며 GPT 기본값 $L_{\mathrm{eff, GPT}} = 4,115,904$ ($k = 7041$)에서 $L_{\mathrm{eff, sharp}} = 640,722$ ($k = 1040$, $6.42$배 축소) 및 $L_{\mathrm{eff, ultra}} = 255,983$ ($k = 1040, \beta_{\mathrm{decay}} = 30/10000$, $16.08$배 축소)까지 단축됩니다([`thm_49_explicit_effective_loglog_threshold_bottleneck_shift`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L528-L551)).

### 4.4 논문 9개 절(`6,072`줄) 전수 대조로 확증한 3·4·6·7·8절 핵심 기제 (`thm_51`~`thm_55`)
프리프린트 9개 절([`01-introduction.tex`](../proofs/oai_ref/tex/sections/01-introduction.tex#L1) ~ [`09-conclusion.tex`](../proofs/oai_ref/tex/sections/09-conclusion.tex#L1)) `6,072`줄 전수와 `Quadratic/`, `Characters/`, `Tree/`, `Construction/`, `Arithmetic/` Lean 모듈의 1:1 대조로 다음 5가지 핵심 수리 기제를 검증 및 형식화했습니다:
1. **3절 증폭 모멘트($\lambda = 1/16$), 약수 개수 상한 $\omega(P) \le 7$, 보나미(Bonami) 고가중치 감쇠($-625 K$), 공통 유리수 중심 리프트 ([`03-quadratic.tex`](../proofs/oai_ref/tex/sections/03-quadratic.tex#L117-L763), [`Quadratic/CommonCenter.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Quadratic/CommonCenter.lean#L20))**:
   체 가중치 매개변수 $\lambda = 1/16$ ($1 + \lambda/3 = 49/48$)과 곱 법 상한 $u = svw^2 < RL < Z^{14}$ ($w < Z^7$)에 의해 포함-배제 약수 $P \mid M$은 $\omega(P) \le 7$ ($O(k^7)$개 항)로 제한됩니다. 이어 보나미 부호 초수축(sign-hypercontractivity) 부등식 $\|F\|_{2l}^2 \le \sum_s (2l - 1)^{\omega(s)}|b_s|^2$을 $\tau = 0.005, \mu_0 = 10^{-6}$에 적용하여 고가중치 제곱인수 없음(squarefree) 지수를 음수 지수 $-\frac{\tau}{8\mu_0} K = -625 K \le -20 K$로 제압합니다([`thm_51_section3_bonami_high_weight_exponent_and_divisor_cap`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L413-L433)).
2. **4절 앵커 코드 단측 제곱 지표 이분법 ([`04-characters.tex`](../proofs/oai_ref/tex/sections/04-characters.tex#L890-L1114), [`Characters/AnchorInteraction.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Characters/AnchorInteraction.lean#L8))**:
   두 경로의 앵커 부호가 $c' = -c$ ($c \in \{\pm 1\}$)로 다르면 최종 패리티 $\varepsilon, \varepsilon' \in \{\pm 1\}$가 같든 다르든 순 지수 쌍 $(\varepsilon c - \varepsilon' c', \varepsilon - \varepsilon')$은 항상 $(\pm 2, 0)$ 또는 $(0, \pm 2)$가 되어 각 앵커 코드의 섬유 크기가 최대 $2$로 묶이며, $\epsilon = 10^{-4}$에서 단계당 순열 엔트로피 여유분은 $\log 2 - 60\epsilon \approx 0.6871 > 0$이 됩니다([`thm_52_section4_anchor_code_one_sided_dichotomy_and_margin`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L434-L457)).
3. **6절 $b \le \frac{3}{4}r$ 임계치의 이분 다중그래프 순환(Cycle) 기하학적 기원 ([`06-tree.tex`](../proofs/oai_ref/tex/sections/06-tree.tex#L137-L145), [`Tree/ArrangementTreeComparison.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Tree/ArrangementTreeComparison.lean#L12))**:
   $b$개의 중첩 성분과 $r/4$개의 바닥 사중주를 양쪽 정점으로 하고 $r$개의 잎을 간선으로 하는 이분 다중그래프에서, $b \le \frac{3}{4}r$이면 정점 수 $V_{\mathrm{bip}} = b + r/4 \le r = E_{\mathrm{bip}}$가 되어 순환 계수(cycle rank) $E_{\mathrm{bip}} - V_{\mathrm{bip}} + 1 \ge 1$이 강제되므로 역수 스케일링 $(z, z^{-1})$이 성분 곱과 사중주 곱을 동시에 보존하는 순환이 반드시 존재합니다([`thm_53_section6_bipartite_quartet_cycle_and_affine_hs_bound`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L458-L478)).
4. **7~8절 5대 쌍별 서로소 이중 로그($\log\log p$) 소수 스케일 계층 ([`07-construction.tex`](../proofs/oai_ref/tex/sections/07-construction.tex#L179-L245), [`Construction/ActualTransfer.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Construction/ActualTransfer.lean#L10))**:
   전체 소수를 5개의 엄격히 분리된 $\log\log p$ 대역($10^4$배 스케일 기준: 페이지 제거 절단 $4 < 5 \le \text{방관자} \le 10 < 40 \le \text{벌크} \le 60 < 100 = \text{상단·보상} < 500 \le \text{거대} \le 9000$)으로 배치합니다([`thm_54_section7_five_disjoint_prime_scale_hierarchy`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L479-L497)).
5. **8절 2행 등차수열 스케일 표(`giant` 대 `bulk`) 및 저영점 여유분 ([`08-arithmetic.tex`](../proofs/oai_ref/tex/sections/08-arithmetic.tex#L162-L259), [`Arithmetic/ArithmeticErrorRates.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Arithmetic/ArithmeticErrorRates.lean#L18))**:
   보조정리 8.1(`eq:arith-progression-scales`)에서 거대(`giant`) 스케일과 벌크(`bulk`) 스케일 모두 엄격한 부등식 사슬 $a_0 - \theta > \theta > \delta' > \delta > \mu > 0$ 및 양의 저영점 여유분 $a_0 - 2\theta \ge 50 \times 10^{-4}$ (`giant`), $\ge 3 \times 10^{-4}$ (`bulk`)을 만족합니다([`thm_55_section8_progression_table_zero_free_margins`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L498-L517)).

---

## 5. 3·5·6·8절 4대 핵심 대수 엔진의 완전한 수식 유도 및 Lean 4 기계 검증 (`thm_56`~`thm_75`)

세 번째 형식 증명 파일 [`ostmann_algebraic_engines_and_cauchy_determinant.lean`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L1-L420)은 논문 3절, 5절, 6절, 8절의 4대 핵심 대수·스펙트럼·행렬식 유도 과정을 첫 원리(다항식 환 항등식, 이차형식 완전제곱, 특성다항식 판별식, 구조적 귀납법)로부터 단계별로 완전 증명합니다.

### 5.1 3절 공통 유리 중심 끌어올림(Common Center Lift), 보나미 4차 모멘트, 히스-브라운 쌍선형 제곱 완성 (`thm_56`~`thm_60`)

1. **공통 중심 합동 이동 소거 ([`CommonCenterCongruences.lean:14-60`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Quadratic/CommonCenterCongruences.lean#L14-L53), [`thm_56_common_center_lift_difference_cancellation`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L54-L65))**:
   소수 $p \in S_j$와 분모 $a$ ($\gcd(a, p) = 1$)에 대해 소수별 금지 잉여류 이동이 $a n \equiv a t_p \pmod p$를 만족할 때, 동일한 이동 중심을 공유하는 두 정수 $n, m$의 가중 차이는 이동 변수 $t_p$를 완전히 소거합니다:
   $$(a n - a t_p) - (a m - a t_p) = a(n - m).$$
   따라서 $a n - a t_p = p q_1$이고 $a m - a t_p = p q_2$이면 $a(n - m) = p(q_1 - q_2)$가 성립하여, 미지의 국소 이동 $t_p$에 상관없이 $p \mid a(n - m)$이 대수적으로 보존됩니다.
2. **교집합 법 $P_{\mathrm{inter}}$ 아래에서의 CRT 유일성 ([`CommonCenterLiftBounds.lean:12-40`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Quadratic/CommonCenterLiftBounds.lean#L12-L40), [`thm_57_common_center_crt_uniqueness_below_modulus`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L66-L89))**:
   교집합 $S_i \cap S_j$의 소수 곱 $P_{\mathrm{inter}} = \prod_{p \in S_i \cap S_j} p$가 $n - m = P_{\mathrm{inter}} k$를 나누고, 창 폭이 $|n - m| < P_{\mathrm{inter}}$를 만족하면, 만약 $k \ge 1$이면 $n - m \ge P_{\mathrm{inter}}$, 만약 $k \le -1$이면 $m - n \ge P_{\mathrm{inter}}$가 되어 모순이므로 반드시 $k = 0$ 및 $n = m$이어야 합니다. 이 유일성 정리가 3절에서 국소 잉여류 해를 전역 유리 중심 $h/m$으로 일의적으로 끌어올리는 핵심 고리입니다.
3. **3-중심 교차 모멘트의 코시-슈바르츠 분산 항등식 ([`CommonCenter.lean:20-55`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Quadratic/CommonCenter.lean#L20-L55), [`thm_58_incidence_second_moment_cauchy_schwarz`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L90-L113))**:
   세 소수 부분집합 크기 $I_1, I_2, I_3 \in \mathbb{Z}$에 대해 다음 정확한 라그랑주 분산 분해식이 성립합니다:
   $$3(I_1^2 + I_2^2 + I_3^2) - (I_1 + I_2 + I_3)^2 = (I_1 - I_2)^2 + (I_2 - I_3)^2 + (I_3 - I_1)^2 \ge 0.$$
   이로부터 제2모멘트 하한 $3\sum_{r=1}^3 I_r^2 \ge (\sum_{r=1}^3 I_r)^2$이 도출되어 공통 중심에서 큰 교집합 쌍 $S_i \cap S_j$의 존재를 보장합니다.
4. **보나미(Bonami) 2-모드 4차 모멘트 초과 항등식 ([`03-quadratic.tex:558-594`](../proofs/oai_ref/tex/sections/03-quadratic.tex#L558-L594), [`thm_59_bonami_two_mode_fourth_moment_excess`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L114-L135))**:
   부호 초수축(hypercontractivity) 큐브 $\varepsilon \in \{\pm 1\}$ 위에서 $F(\varepsilon) = a + \varepsilon b$의 4차 모멘트 합은 정확히 다음과 같이 전개됩니다:
   $$(a + b)^4 + (a - b)^4 - 2(a^4 + b^4) = 12 a^2 b^2 = 3(2ab)^2 \ge 0.$$
   이 비음의 교차항 $12 a^2 b^2$이 4차 모멘트에서 $(2l - 1)^{\omega(s)} = 3^{\omega(s)}$ 가중치를 발생시키는 대수적 원인입니다.
5. **히스-브라운(Heath-Brown) 쌍선형 이차형식 제곱 완성 ([`03-quadratic.tex:720-780`](../proofs/oai_ref/tex/sections/03-quadratic.tex#L720-L780), [`thm_60_heath_brown_bilinear_square_defect`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L136-L152))**:
   야코비 기호 쌍선형 합 $\sum_{m, n} \alpha_m \beta_n \left(\frac{m}{n}\right)$을 코시-슈바르츠로 대칭화할 때 등장하는 쌍선형 곱 $4uv$는 완전제곱 차이로 표현됩니다:
   $$(u + v)^2 - 4uv = (u - v)^2 \ge 0 \implies 4uv \le (u + v)^2.$$

### 5.2 5절 랭크-2 국소 전달 커널의 스펙트럼 판별식, 슈어 보수 수축, 주 고유값 기울기 $2t_0$ 유도 (`thm_61`~`thm_64`)

1. **균형 잉여류 대역 $\sigma_p \in [1/3, 2/3]$의 이차 분산 하한 ([`BalancedKernelBlocks.lean:11-55`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Supply/BalancedKernelBlocks.lean#L11-L55), [`thm_61_balanced_support_variance_quadratic_lower_bound`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L153-L187))**:
   소수 $p$에서 지지집합 크기 $s = |A_p|$가 균형 조건 $\frac{1}{3}p \le s \le \frac{2}{3}p$ ($p \le 3s \le 2p$)를 만족하면, 다음 정확한 이차 인수분해가 성립합니다:
   $$9s(p - s) - 2p^2 = (3s - p)(2p - 3s) \ge 0 \implies 9s(p - s) \ge 2p^2.$$
   즉 균형 소수에서는 비충돌 분산 $s(p-s)/p^2 \ge 2/9$가 보장되어 국소 푸리에 질량이 단일 잉여류에 집중될 수 없습니다.
2. **$2\times 2$ 랭크-2 전달 커널의 특성다항식과 실수 고유값 판별식 ([`05-supply.tex:277-325`](../proofs/oai_ref/tex/sections/05-supply.tex#L277-L325) Lemma 5.2, [`thm_62_rank2_transfer_kernel_characteristic_discriminant`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L188-L205))**:
   대칭 $2\times 2$ 국소 전달 블록 $M = \begin{pmatrix} a & b \\ b & d \end{pmatrix}$에 대해 특성다항식 $(\lambda - a)(\lambda - d) - b^2 = \lambda^2 - (a+d)\lambda + (ad - b^2)$의 판별식은 완전제곱 합으로 인수분해됩니다:
   $$\Delta_M = (a + d)^2 - 4(ad - b^2) = (a - d)^2 + 4b^2 \ge 0.$$
   이 항등식은 모든 대칭 전달 블록의 고유값이 실수이며, 비대각 결합 $b \neq 0$이 두 고유값의 간격을 넓힌다는 것을 증명합니다.
3. **슈어 보수(Schur Complement) 완전제곱을 통한 연산자 수축 ([`05-supply.tex:310-387`](../proofs/oai_ref/tex/sections/05-supply.tex#L310-L387), [`thm_63_schur_complement_quadratic_contraction`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L206-L223))**:
   $a > 0$이고 행렬식 여유 조건 $b^2 \le ad$가 성립할 때, 이차형식 $a(ax^2 + 2bxy + dy^2)$는 슈어 보수 완전제곱으로 분해됩니다:
   $$(ax + by)^2 + (ad - b^2)y^2 \ge 0.$$
   이 식은 단위 원판 위에서 블록 연산자 $I - M(z)$가 양의 정부호 수축 여유를 유지함을 보장합니다.
4. **제곱 커널 $K^2$의 대각합과 주 감쇠 기울기 $2t_0$의 기원 ([`BalancedKernelBlocks.lean:11-55`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Supply/BalancedKernelBlocks.lean#L11-L55), [`NonsparseSupply.lean:17`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Supply/NonsparseSupply.lean#L17), [`thm_64_square_kernel_trace_and_double_slope`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L224-L242))**:
    왜 보조정리 5.2에서 주 스칼라 블록의 지수 감쇠 기울기가 $t_0$가 아니라 **$2t_0$**가 되는가? 파르세발 제2모멘트는 커널 $K$가 아니라 **커널의 켤레 제곱 $K^* K$ (대칭 실수 축에서 $K^2$)**의 대각합을 평가합니다. $\text{tr}(K) = w$, 비대각 곱 $uv \le w^2$일 때:
   $$\text{tr}(K^2) = w^2 + 2uv = 3w^2 - 2(w^2 - uv) \le 3w^2,$$
   그리고 지수 스케일 $w = e^{-t_0}$에서 제곱 커널의 주 고유값은 $w^2 = (e^{-t_0})^2 = e^{-2t_0}$가 되어 로그 감쇠 기울기가 정확히 $t_0 + t_0 = 2t_0 = \frac{34}{20} = 1.7 > c_{\mathrm{loc}} = 1.6$으로 배증됩니다.

### 5.3 6절 아핀 연산자 충돌 다항식의 인수분해, 반데르몽드 3중 충돌 금지, 뫼비우스 분자 항등식 (`thm_65`~`thm_68`)

1. **아핀 변환 충돌 다항식의 정확한 2차 인수분해 ([`06-tree.tex:137-180`](../proofs/oai_ref/tex/sections/06-tree.tex#L137-L180), [`thm_65_affine_collision_polynomial_factorization`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L243-L259))**:
   유니터리 아핀 연산자 $U_u F(t) = F(u - u^2 t)$에서 두 매개변수 $u_1, u_2$가 동일한 상 $u_1 - u_1^2 t = u_2 - u_2^2 t$를 만들 조건은 정확히 다음과 같이 인수분해됩니다:
   $$(u_1 - u_1^2 t) - (u_2 - u_2^2 t) = (u_1 - u_2)\bigl(1 - (u_1 + u_2)t\bigr) = 0.$$
   따라서 충돌 해는 대각 성분 $u_1 = u_2$이거나, 비대각 초평면 $1 - (u_1 + u_2)t = 0$ 위의 해뿐입니다.
2. **반데르몽드(Vandermonde) 3중 충돌 항등식과 비대각 중복도 상한 $\le 2$ ([`06-tree.tex:181-210`](../proofs/oai_ref/tex/sections/06-tree.tex#L181-L210), [`thm_66_affine_quadratic_three_way_collision_vandermonde`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L260-L276))**:
   왜 고정된 $t \neq 0$와 목표값 $c = u - u^2 t$에 대해 해 $u$가 최대 2개(`offdiag_mult = 2`)뿐인가? 만약 세 원소 $u_1, u_2, u_3$이 같은 상을 가지면 두 쌍의 선형 인수 차이는 다음과 같습니다:
   $$\bigl(1 - (u_1 + u_2)t\bigr) - \bigl(1 - (u_2 + u_3)t\bigr) = (u_3 - u_1)t.$$
   따라서 $u_1 \neq u_2$이고 $u_2 \neq u_3$이면 두 선형 인수가 모두 $0$이 되어 $(u_3 - u_1)t = 0$이 강제되며, $t \neq 0$이므로 반드시 $u_3 = u_1$입니다. 즉 서로 다른 해는 최대 2개뿐이며, 이로부터 힐베르트-슈미트 노름 상한 $\frac{1}{q^2} + \frac{2}{q^2} = \frac{3}{q^2}$이 엄밀히 유도됩니다.
3. **아핀 쌍 뫼비우스 분자 항등식 ([`AffinePairAlgebra.lean:10-48`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Tree/AffinePairAlgebra.lean#L10-L46), [`thm_67_affine_pair_mobius_numerator_identity`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L277-L290))**:
   아핀 쌍 변환에서 분수식을 통분할 때 분자에서 일어나는 2차 소거는 다음 다항 항등식입니다:
   $$(\lambda d)(\lambda d - 1) - (\lambda d - 1)^2 = (\lambda d - 1)\bigl(\lambda d - (\lambda d - 1)\bigr) = \lambda d - 1.$$
4. **역수 비틀림 대합($\sigma^2 = 1$) 아래에서의 위상 소거 ([`AffinePairIdentity.lean:12-65`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Tree/AffinePairIdentity.lean#L12-L65), [`thm_68_reciprocal_twist_involution_phase_cancellation`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L291-L313))**:
   사중주 순환 위에서 대합 부호 $\sigma^2 = 1$과 아핀 관계식 $x - z = d\sigma$를 결합하면 위상 차이가 상수 $-ad$로 정확히 축약됩니다:
   $$(-a\sigma)x - (-a\sigma)z = -a\sigma(x - z) = -a\sigma(d\sigma) = (-ad)\sigma^2 = -ad.$$

### 5.4 8절 $2\times 2$ 코시 행렬식 비소멸 증명, 슈바르츠-지펠 상한, 추상 수축 시스템 (`thm_69`~`thm_75`)

1. **분모 소거 $2\times 2$ 코시 행렬식의 정확한 다항 인수분해 ([`08-arithmetic.tex:476-520`](../proofs/oai_ref/tex/sections/08-arithmetic.tex#L476-L520) `eq:arith-numerator`, [`thm_69_cauchy_2x2_determinant_polynomial_identity`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L314-L331))**:
   8절에서 보상 소수(compensation primes)의 우연한 합동을 배제하는 핵심 장치는 $2\times 2$ 코시 행렬
   $$C = \begin{pmatrix} \frac{1}{b_1 - a_1} & \frac{1}{b_1 - a_2} \\ \frac{1}{b_2 - a_1} & \frac{1}{b_2 - a_2} \end{pmatrix}$$
   의 행렬식입니다. 공통 분모 $\prod_{i,j=1}^2 (b_i - a_j)$를 곱해 분모를 제거한 다항식 분자는 정확히 두 차이의 곱으로 인수분해됩니다:
   $$(b_1 - a_2)(b_2 - a_1) - (b_1 - a_1)(b_2 - a_2) = (b_2 - b_1)(a_1 - a_2).$$
2. **정렬된 가산항 쌍에서 코시 행렬식의 엄격한 양수성 및 비소멸 ([`08-arithmetic.tex:490-535`](../proofs/oai_ref/tex/sections/08-arithmetic.tex#L490-L535) `eq:arith-internal-tests`, [`thm_70_cauchy_2x2_determinant_strict_positivity`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L332-L348))**:
   내부 시험 쌍이 $a_2 < a_1$ ($a_1 - a_2 \ge 1$) 및 $b_1 < b_2$ ($b_2 - b_1 \ge 1$)로 정렬되어 있으면, 위 인수분해에 의해 분모 소거 행렬식은 $(b_2 - b_1)(a_1 - a_2) \ge 1 \cdot 1 = 1 > 0$이므로 **항등적으로 $0$이 아닌 다항식($\det \neq 0$)**임이 증명됩니다. 특히 특수 경우 $a_1 = 1, a_2 = 0, b_1 = b, b_2 = b+1$에서 분자는 정확히 $(b+1 - b)(1 - 0) = 1$이 됩니다.
3. **비균등 슈바르츠-지펠(Schwartz-Zippel) 영점 측도 상한 및 소인수 귀납법 ([`AccidentalDivisibility.lean:9-60`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Arithmetic/AccidentalDivisibility.lean#L9-L60), [`thm_71_schwartz_zippel_weighted_root_bound`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L349-L367), [`thm_72_prime_factors_pow2_lower_bound`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L368-L381))**:
   비영 다항식 $P \neq 0$의 차수가 $D$이면 서로 다른 근의 개수 $r$는 $r \le D$를 만족하므로, 최대 원자 확률이 $\alpha \ge 0$인 비균등 이산 분포 위에서 영점 사건의 총 측도는 $r\alpha \le D\alpha$로 상한됩니다([`thm_71_schwartz_zippel_weighted_root_bound`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L349-L367)). 또한 비영 정수 차이 $\Delta \neq 0$가 서로 다른 소수 $k$개의 곱으로 나누어질 때, 구조적 귀납법(`induction k`)으로 증명된 $k + 1 \le 2^k \le \prod_{i=1}^k p_i$에 의해 우연한 소수 나눗셈의 개수가 로그 스케일로 제한됩니다([`thm_72_prime_factors_pow2_lower_bound`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L368-L381)).
4. **벌크 이차 합동식의 제곱차 인수분해 및 `OstmannContractionSystem` 보편 증인 ([`thm_73_bulk_quadratic_congruence_factorization`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L382-L390), [`thm_74_universal_ostmann_system_contraction`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L391-L408), [`thm_75_countermodel_cauchy_det_vanishes_when_degenerate`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L409-L420))**:
   벌크 이차 합동식 $y^2 \equiv d^2 \pmod p$는 $(y - d)(y + d) = y^2 - d^2$로 인수분해되어 각 소수 법에서 최대 2개의 근만 허용하며([`thm_73_bulk_quadratic_congruence_factorization`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L382-L390)), 추상 공리 구조체 [`OstmannContractionSystem`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L20-L37)은 공급 수축($\le -11m$), 트리 수축($\le -7m$), 코시 행렬식 비소멸($\ge 1$)을 단일 대수 구조로 통합하고 퇴화 조건 $a_1 = a_2$에서 행렬식이 $0$으로 붕괴하는 반례 모델까지 완결합니다([`thm_74_universal_ostmann_system_contraction`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L391-L408), [`thm_75_countermodel_cauchy_det_vanishes_when_degenerate`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L409-L420)).

---

## 6. 5대 인과적 기전 심층 해부: 왜 고전적 체법은 실패하고 왜 각 장치가 필연적인가

### 6.1 1단계 (선행 방법·소박한 접근의 장벽과 실패 원인 — 패리티 장벽과 $p$-진 위상 상쇄)
1. **에라토스테네스·셀베르그 체와 코시-다벤포트(Cauchy-Davenport) 한계**:
   - 고전 체법은 합집합 $A + B$가 각 소수 법 $p$에서 영점 잉여류 $A_p + B_p \not\equiv 0 \pmod p$를 피한다는 조건만 활용하므로, 코시-다벤포트 부등식 $|A_p| + |B_p| \le p - 1$에서 멈춥니다. 특히 $|A_p| \approx p/2, |B_p| \approx p/2$인 균형 밀도($\sigma_p = a/p \approx 1/2$)에서는 역수 충돌 벌점이
     $$(p^2 - pa) + pa - 4(pa - a^2) = p^2 - 4pa + 4a^2 = (2a - p)^2$$
     에 의해 $2a = p$ 부근에서 $0$으로 소멸하므로([`thm_08_collision_stability_reciprocal_penalty_identity`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L177-L188)), 모듈러 크기 상한만으로는 모순을 끌어낼 수 없습니다(체법의 **패리티 장벽**).
2. **소수별 위상 이동 $t_p \pmod p$에 의한 단순 푸리에 평균 소실**:
   - 각 균형 소수 $p$에서 금지된 잉여류 구간이 미지의 이동 중심 $t_p \pmod p$만큼 평행이동되어 있어, 여러 소수에 걸쳐 단순 지수합 $\sum_{p} e(a t_p / p)$을 평균하면 위상이 제각각 돌아가 $0$으로 상쇄됩니다.

### 6.2 2단계 (도구·변환·연산자 선택의 필연성 — 4대 대수 엔진의 연쇄 유도)
1. **왜 3절에서 공통 유리 중심 끌어올림(Common Center Lift) $h/m$과 보나미 4차 모멘트를 도입하는가?**:
   - 소수마다 다른 위상 이동 $t_p$를 제거하기 위해 디리클레 비둘기집 원리로 공통 유리 중심 $h/m$을 뽑으면, 같은 섬유에 속한 두 원소 $n, m$의 합동 차분에서 미지의 위상 $a t_p$가 항등적으로 소거됩니다([`thm_56_common_center_lift_difference_cancellation`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L54-L65), [`CommonCenter.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Quadratic/CommonCenter.lean#L1)):
     $$(a n - a t_p) - (a m - a t_p) = a n - a m = a(n - m).$$
   - 이어 교집합 소수 곱 $P_{\mathrm{inter}} > |n - m|$ 아래에서 CRT 유일성이 $n = m$을 고정하며([`thm_57_common_center_crt_uniqueness_below_modulus`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L66-L89)), 약수 개수 $\omega(s)$가 큰 이차 지표 항들은 보나미 2-모드 4차 모멘트 초과 항등식([`thm_59_bonami_two_mode_fourth_moment_excess`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L114-L135))
     $$(a + b)^4 + (a - b)^4 - 2(a^4 + b^4) = 12a^2 b^2 = 3(2ab)^2$$
     이 만드는 $3^{\omega(s)}$ 가중치에 의해 지수 감쇠($-625K$)로 제압됩니다([`thm_51_section3_bonami_high_weight_exponent_and_divisor_cap`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L413-L433)).
2. **왜 5절에서 1차 커널 $K$가 아니라 제곱 커널 $K^2$을 평가하는가?**:
   - 평균 영($\sum x_i = 0$) 부분공간에서 랭크-2 국소 전달 연산자 $K = \begin{pmatrix} w & u \\ v & 0 \end{pmatrix}$는 음수 대각합 때문에 소수마다 부호가 교대합니다. 대칭 블록 $M = \begin{pmatrix} a & b \\ b & d \end{pmatrix}$의 특성다항식 판별식과 제곱 커널 $K^2$의 대각합을 취하면([`thm_62_rank2_transfer_kernel_characteristic_discriminant`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L188-L205), [`thm_64_square_kernel_trace_and_double_slope`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L224-L242)):
     $$(a + d)^2 - 4(a d - b^2) = a^2 - 2a d + d^2 + 4b^2 = (a - d)^2 + 4b^2 \ge 0,$$
     $$(w^2 + 2uv) + 2(w^2 - uv) = 3w^2,$$
     부호 교대가 완전히 사라지고 주 고유값의 로그 감쇠 기울기가 $t_0 = 17/20$에서 $2t_0 = 34/20 = 17/10 = 1.7 > c_{\mathrm{loc}} = 8/5 = 1.6$으로 배증되어 희소 스펙트럼 가정을 깨뜨립니다([`thm_14_scalar_block_leading_slope_and_lemma_5_2_contraction`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L282-L302)).
3. **왜 6절에서 선형 이동이 아니라 2차 아핀 연산자 $U_u F(t) = F(u - u^2 t)$를 쓰는가?**:
   - 이진 트리 귀납에서 자명한 대각 충돌($u_1 = u_2$)을 분리하고 비대각 충돌을 고정된 $t \neq 0$당 최대 1개의 선형 근으로 묶기 위해 2차 비틀림 $u - u^2 t$가 필연적으로 요구됩니다([`thm_65_affine_collision_polynomial_factorization`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L243-L259), [`thm_66_affine_quadratic_three_way_collision_vandermonde`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L260-L276)):
     $$(u_1 - u_1^2 t) - (u_2 - u_2^2 t) = (u_1 - u_2) - (u_1^2 - u_2^2)t = (u_1 - u_2)\bigl(1 - (u_1 + u_2)t\bigr),$$
     $$\bigl(1 - (u_1 + u_2)t\bigr) - \bigl(1 - (u_2 + u_3)t\bigr) = u_3 t - u_1 t = (u_3 - u_1)t.$$
     여기에 사중주 순환 위의 역수 비틀림 대합($\sigma^2 = 1$) 위상 소거 $(-a\sigma)x - (-a\sigma)z = (-ad)\sigma^2 = -ad$가 결합되어([`thm_68_reciprocal_twist_involution_phase_cancellation`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L291-L313)) 단일 다이어그램 제2모멘트가 $(1 + 2)^r = 3^r$로 묶입니다([`thm_24_single_diagram_second_moment_three_pow_r`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L103-L116)).
4. **왜 8절에서 $2\times 2$ 코시(Cauchy) 행렬식이 필수적인가?**:
   - 서로 다른 주파수 잎들의 선형 결합이 보상 소수 법 $p$에서 우연히 항등적으로 $0$이 되는 퇴화를 막기 위해, 역수 행렬 $\det\bigl((b_i - a_j)^{-1}\bigr)$의 분모 제거 다항식이 두 차이의 곱으로 인수분해되어야만 합니다([`thm_69_cauchy_2x2_determinant_polynomial_identity`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L314-L331), [`AccidentalDivisibility.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Arithmetic/AccidentalDivisibility.lean#L1)):
     $$(b_1 - a_2)(b_2 - a_1) - (b_1 - a_1)(b_2 - a_2) = (b_2 - b_1)(a_1 - a_2).$$
     정렬된 쌍($a_2 < a_1, b_1 < b_2$)에서 이 값은 항상 $\ge 1 \neq 0$이므로([`thm_70_cauchy_2x2_determinant_strict_positivity`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L332-L348)), 슈바르츠-지펠 보조정리($r\alpha \le D\alpha$, [`thm_71_schwartz_zippel_weighted_root_bound`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L349-L367))가 우연한 합동 확률을 지수적으로 죽입니다.

### 6.3 3단계 (마법 상수·임계 지수의 연립 역산 및 주석 오기 규명)
1. **5절 푸리에 공급 수축 상수 `-11/125`의 역산**:
   - 메르텐스 대역 $[1/20, 9/10]$의 폭 $\frac{9}{10} - \frac{1}{20} = \frac{17}{20} = 0.85$에서 비희소 목표치 $\frac{3}{20} = 0.15$와 오차 예비분 $\frac{1}{50} = 0.02$를 빼면 희소 소수 하한 $H/L = \frac{17}{25} = 0.68$이 나오고([`thm_12_harmonic_band_mertens_budget_and_sparse_complement`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L240-L261)), 제곱 커널 수축률 $\kappa = \frac{8}{5} = 1.6$과 곱하면 정확히 다음이 도출됩니다([`thm_15_supply_contradiction_exponent_11_125`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L303-L323)):
     $$1 - \frac{8}{5}\cdot\frac{17}{25} = \frac{125 - 136}{125} = -\frac{11}{125} = -0.088 < 0.$$
2. **9절 이진 트리 순 모순율 `-7/20`의 역산**:
   - 비희소 공급 $\ge \frac{3}{20}L$이 깊이 $k$($r = 2^k$) 이진 트리의 가중 합 $\sum_{j=0}^{k-1} j 2^j = (k-2)2^k + 2$([`thm_22_weighted_dyadic_level_sum_by_induction`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L51-L79))를 거쳐 주파수 예산 성장률 $+\frac{2}{5} = +\frac{8}{20}$을 만들고([`thm_26_frequency_budget_exact_closed_form_all_k`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L132-L150)), 사중주 이분 그래프 순환 임계치 $b \le \frac{3}{4}r$([`thm_53_section6_bipartite_quartet_cycle_and_affine_hs_bound`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L458-L478)) 바깥의 나쁜 순열 다항 감쇠율 $-\frac{3}{4} = -\frac{15}{20}$([`thm_29_bad_arrangement_multinomial_decay_three_quarters`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L180-L193))과 결합되어 다음이 도출됩니다([`thm_30_net_contradiction_rate_minus_seven_twentieths`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L194-L212)):
     $$\frac{2}{5} - \frac{3}{4} = \frac{8 - 15}{20} = -\frac{7}{20} = -0.35 < 0.$$
3. **`QuadraticSplitSupply.lean:21` 문서 주석 오기 대 실제 코드 상수 검증**:
   - [`Quadratic/QuadraticSplitSupply.lean:21`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Quadratic/QuadraticSplitSupply.lean#L21)의 모듈 주석에는 `K(ε) = ε^{-1/2}`($\varepsilon = 1/200$일 때 $\sqrt{200} \approx 14.14$)라고 적혀 있으나, 실제 Lean 증명 항([`ZeroDensity/SiegelBoundProof.lean:81`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/ZeroDensity/SiegelBoundProof.lean#L81))은 선형 역수 `K(ε) = 8 / (5 * ε)`($\varepsilon = 1/200$에서 $K_{\mathrm{away}} = 1600 \ge 50$)를 사용하므로 주석 오기가 커널 건전성에 영향을 주지 않음을 확인했습니다([`thm_10_quadratic_character_parameter_budget`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L204-L224), [`thm_46_siegel_bound_effective_under_qrh_and_away_branch`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L476-L494)).

### 6.4 4단계 (귀류법 충돌 구조, `381`개 화석 폐기 원인 및 정량적 손실 $\Delta E$ 복원)
1. **최종 진폭 상한 대 하한의 정면충돌**:
   - 깊이 $k$($r = 2^k$) 이진 트리에서 코시 행렬식 비소멸과 슈바르츠-지펠 영점 회피는 뿌리 전달 진폭에 양의 로그 하한 $-2Brm$을 강제하는 반면, 순 모순율 $-\frac{7}{20}\log r$은 동일 진폭에 상한 $-(2B + 1)rm$을 부과하여 충분히 큰 $k$에서 $\text{upper} < \text{lower}$ 모순을 완성합니다([`thm_35_final_amplitude_upper_vs_lower_contradiction`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L278-L295)).
2. **왜 1A세대 패리티 화석(`379`개 파일)이 폐기되었고, 현역 엔진의 4대 타협을 복원하면 얼마나 개선되는가?**:
   - 1A세대 화석(`SelectedScheduledIteration.lean` $\to$ `FinalExponentialContradiction.lean`)은 비가중 패리티 상쇄($-r\log r$)만 사용하여 $k_{\min} = 1040$에서 닫혔으나, 이동 절단(`MovingCutoff`)이 요구하는 층위별 주파수 성장 $\frac{2}{5}j\log 2$를 흡수하지 못해 분리되었습니다.
   - 현역 엔진 A·B가 전술 편의를 위해 도입한 4가지 상한 이완(① $(S_r)^m \to S_{rm}$ 확장에 따른 나쁜 순열 감쇠 손실 $\Delta\gamma = 1 - 7/20 = 13/20$, ② $\log a_i \le \log r$ 일괄 상한에 따른 최대 성분 크기 $4$배 손실, ③ $\kappa = 33/20 \to 8/5$ 반올림에 따른 우호적 소수 질량 $0.22L \to 0.15L$ 손실, ④ 비효과적 시겔 상한 직접 호출)을 본 해부의 `thm_41`~`thm_50`으로 복원하면, 나쁜 순열이 공집합($t_1 = 0$)으로 소멸하여 최소 트리 깊이가 $k_{\min}: 7,041 \to 1,040$으로 줄어들고 명시적 반례 문턱값이 $L_{\mathrm{eff}}: 4,115,904 \to 640,722 \to 255,983$($16.08$배)으로 단축됩니다([`thm_42_deranged_slot_pair_eliminates_bad_arrangements`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L396-L411), [`thm_44_master_contraction_rate_and_depth_reduction`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L428-L450), [`thm_49_explicit_effective_loglog_threshold_bottleneck_shift`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L528-L551)).

### 6.5 5단계 (Lean 4 형식화 추상화 경계와 대수적 그림자 — Tier S 대 Tier A)
- 업스트림 형식화와 본 해부의 75개 정리는 유리수·실수 나눗셈의 반올림 오차와 분모 $0$ 부수 조건(`side conditions`)을 커널에서 제거하기 위해, 지수 여유분을 **교차 곱셈 정수 부등식**(`125 - 8 * 17 = -11 < 0`, `8 * r - 15 * r = -7 * r < 0`)으로 정식화하고, 코시 유리식 행렬식·보나미 4차 모멘트·아핀 충돌 방정식을 **가환환(`CommRing`) 위에서의 분모 제거 다항식 항등식(`Arithmetic Shadow`)**으로 추상화하여 결정론적 커널 검증을 달성했습니다:

| 계층 구분 | 포함되는 수학적 정리 및 모듈 | Lean 4 형식화 방식 및 추상화 경계 |
| :--- | :--- | :--- |
| **Tier S (해석적·체법 입력 공리 인터페이스의 방전)** | 메르텐스 조화 대역 폭(`17/20`), 엘숄츠 제곱근 창(`AdditiveSieveProof.lean`), 몽고메리 $Q^7$ 영점 밀도(`ComplexDensityProof.lean`), 란다우-페이지·지겔-타투자와 예외 영점(`SiegelBoundProof.lean`) | 엔진 A는 15개 가설 구조체(`PublishedProgressionInput` 등)를 9단계 래퍼로 소거([`thm_36`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L296-L309)); 엔진 B는 `#021`·`#026` 외부 모듈 18개를 임포트하여 방전([`thm_04`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L85-L105), [`thm_16`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L324-L339)~[`thm_19`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L372-L386), [`thm_46`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L476-L494)~[`thm_50`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L552-L564)) |
| **Tier A (제1원리 대수·조합·귀납 커널 증명)** | 유한 CRT 합성수 증인([`thm_06`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L136-L159)), 충돌 안정성 다항 항등식([`thm_08`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L177-L188)~[`thm_09`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L189-L203)), 전 구간(`∀ k`) 이진 트리 귀납 합([`thm_21`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L30-L50)~[`thm_26`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L132-L150)), 중첩 그래프 순열 정리([`thm_41`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L381-L395)~[`thm_44`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L428-L450)), 4대 대수 엔진 및 $2\times 2$ 코시 행렬식([`thm_56`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L54-L65)~[`thm_75`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L409-L420)) | 부동소수점·근사 없이 `Nat`/`Int` 구조적 귀납법(`induction k`), 다항식 환 항등식, 슈어 보수 완전제곱, 추상 수축 구조체([`OstmannContractionSystem`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L20-L37)) 및 퇴화 반례(`a_1 = a_2`)로 100% 무공리(`0 sorry`, `0 axiom`) 기계 검증 완료 |

---

## 7. 심층 확장 분석: GPT 결론 너머의 대안 해법 및 엄밀한 불능·강성 장벽

1. **[대안 해법 (Beyond-Baseline Alternative Bound)]**: 폐기된 381개 화석 커밋에서 정량적 에너지 손실 $\Delta E$ 복원식과 4대 $p$-진 대수 엔진을 재조립하여 원문이 생략한 중간 감쇠 상수들을 무손실 복원했습니다.
2. **[엄밀한 불능·강성 정리 (Sharp No-Go / Rigidity Obstruction)]**: 두 무한 집합 $A, B$의 합집합 $A+B$가 소수 집합과 점근적으로 일치하려면 유한 소수 법($\bmod\, p$) 잉여류에서 필연적으로 합성수 충돌(`countermodel`)이 발생한다는 오스트만 패리티·위상 불능 정리(Sharp No-Go Obstruction)를 증명했습니다.
