# [1단계: 초보자용 쉬운 해설] 왜 소수 집합은 두 집합의 합(`A + B`)으로 쪼갤 수 없는가?

## 1. 오스트만 역 골드바흐 추측이란 무엇인가?

골드바흐의 추측은 모든 짝수가 두 소수의 합($\mathcal{P} + \mathcal{P}$)인지 묻습니다. 1950년 독일 수학자 한스-하인리히 오스트만(Hans-Heinrich Ostmann)은 그 **역방향** 질문을 던졌습니다([`Erdős Problem #431`](https://www.erdosproblems.com/431)):

> **소수 전체의 집합 $\mathcal{P} = \{2, 3, 5, 7, 11, \dots\}$을 원소가 2개 이상인 두 자연수 부분집합 $A, B \subseteq \mathbb{N}$의 합집합 $A + B = \{a + b : a \in A, b \in B\}$으로 (유한 개의 예외만 빼고) 표현할 수 있는가?**

예를 들어 $A = \{0, 2\}$처럼 유한 집합을 잡으면, $B$의 모든 원소 $b$에 대해 $(b, b+2)$가 모두 소수(쌍둥이 소수)여야 하므로 3으로 나눈 나머지에서 곧바로 모순이 생깁니다. 하지만 $A$와 $B$가 둘 다 무한 집합이면 어떨까요? 이 문제는 76년 동안 가법적 소수론의 대표적인 미해결 난제로 남아 있었습니다. OpenAI `#013`(*소수의 가법적 분해 불가능성*, 2026년 9월 24일)은 그러한 집합 $A, B$가 존재할 수 없음을 증명했습니다:

$$\forall A, B \subseteq \mathbb{N},\quad |A| \ge 2 \;\wedge\; |B| \ge 2 \implies \bigl((A + B) \mathbin{\triangle} \mathcal{P}\bigr)\text{ 은 무한 집합이다.}$$

---

## 2. 왜 `OAI/NumberTheory/Ostmann/` 폴더에는 `7,716`개 파일(`609,199`줄)이 들어 있는가?

OpenAI 수학 저장소(`openai/math`)에서 `lean/OAI/NumberTheory/Ostmann/`은 단일 문제 기준 **저장소 전체 1위 규모**(`7,716`개 `.lean` 파일, 전체 `148,832`개 파일의 `5.18%`, [`thm_37_engine_b_jacobsthal_and_prime_gaps_reuse_accounting`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L317-L331))입니다. 9개 절짜리 LaTeX 논문([`thm_38_paper_9_sections_to_lean_subsystem_mapping`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L332-L356))이 왜 `7,716`개 파일로 불어났을까요?

임포트 그래프를 추적한 결과 **쌍둥이 엔진(`Twin-Engine`) 중복 구축**이 원인임을 밝혀냈습니다([`thm_01_ostmann_directory_inclusion_exclusion_partition`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L20-L43)):
1. **동일한 정리를 담은 2개의 챌린지**: `OstmannComplete.lean`과 `OstmannPrimes.lean`은 수학적으로 똑같은 명제이며 명제논리 3줄이면 서로 유도됩니다([`thm_05_complete_vs_main_logical_bridge_equivalence`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L106-L135)).
2. **엔진 A (`Complete.lean` 원뿔, `3,165`개 파일)**: 15단계 하향식 가설 소거 사슬([`thm_36_engine_a_15_step_conditional_discharge_spine`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L296-L316))로 구성되며 외부 `OAI` 모듈을 단 1개만 임포트합니다.
3. **엔진 B (`Main.lean` 원뿔, `4,175`개 파일)**: 상향식 4-공급자 구조([`thm_04_external_dependency_asymmetry_1_vs_18`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L85-L105))로, `#021`(`Jacobsthal`) 15개와 `#026`(`PrimeGaps`) 3개 등 외부 파일 18개를 임포트합니다.
4. **극소수 공유 코어(`5`개 파일, `372`줄)와 `381`개 화석**: 두 엔진이 공유하는 파일은 기초 정의 5개(`0.065%`)뿐이며([`thm_02_shared_intersection_five_files_accounting`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L44-L60)), 나머지 `381`개 파일(`39,517`줄)은 양쪽 어디에서도 쓰이지 않는 화석 파일입니다([`thm_03_unreachable_orphan_381_files_accounting`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L61-L84)).

```mermaid
flowchart TD
    subgraph Shared["공유 기초 코어 (5개 파일, 372줄 - 0.065%)"]
        S["Defs.lean (46) + Statement.lean (2) + Endpoint.lean (190)\nFiniteCRT.lean (68) + FiniteFactor.lean (66)"]
    end
    subgraph EngineA["엔진 A: Complete.lean 원뿔 (3,165개 파일, 266,820줄)"]
        A1["하향식 15-가설 소거 척추\nInverseGoldbach.lean -> ... -> MainWithoutQuadraticSieve.lean"]
        A2["외부 OAI 임포트 1건 (PrimeGaps.SiegelBounds)\nComparatorChallenges/OstmannComplete.lean"]
        A1 --> A2
    end
    subgraph EngineB["엔진 B: Main.lean 원뿔 (4,175개 파일, 303,234줄)"]
        B1["상향식 Actual* 4-공급자 구조\nActualFourComparisonConsumer.lean (Cs = 17, Ccov = 17)"]
        B2["외부 OAI 임포트 18건 (Jacobsthal 15 + PrimeGaps 3)\nComparatorChallenges/OstmannPrimes.lean"]
        B1 --> B2
    end
    subgraph Orphans["미도달 화석 파일 (381개 파일, 39,517줄)"]
        O1["Arithmetic (264) + Construction (86) + 기타 (29)\n+ All.lean (152줄) + PaperMain.lean (25줄)"]
    end
    S --> EngineA
    S --> EngineB
```

---

## 3. 3단계로 이해하는 핵심 증명 원리 (`영역 A`)

1. **1단계: 유한 소환수 배제 (`FiniteCRT.lean`, 보조정리 2.2)**:
   - 만약 $A$가 유한 집합($|A| \ge 2$)이고 $B$가 무한 집합이면, 중국인의 나머지 정리(CRT)와 디리클레 등차수열 소수 정리에 의해 무한히 많은 소수 $p = a + b$에서 이동된 합 $f(a) + b \in A + B$가 합성수가 되어 모순이 발생합니다([`thm_06_finite_summand_crt_dirichlet_composite_witness`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L136-L159)).
2. **2단계: 푸리에 공급 수축 (`-11/125 < 0`)**:
   - $A, B$가 모두 무한 집합이면 충돌 안정성에 의해 거의 모든 소수에서 밀도 $\sigma_p = |A_p|/p$가 $[1/3, 2/3]$ 안에 들어와야 합니다. 이 구간 밖에서는 벌점 $\frac{(2\sigma_p - 1)^2}{\sigma_p(1 - \sigma_p)} \ge \frac{1}{2}$이 부과되기 때문입니다([`thm_08_collision_stability_reciprocal_penalty_identity`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L177-L188), [`thm_09_unbalanced_density_penalty_lower_bound_one_half`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L189-L203)).
   - 또한 푸리에 모드가 희소한 소수의 비율이 $H \ge \frac{17}{25}L = 0.68L$ 이상이면 국소 전달 연산자가 $1 - \frac{8}{5}\times\frac{17}{25} = -\frac{11}{125} < 0$으로 수축해 모순이 생깁니다([`thm_15_supply_contradiction_exponent_11_125`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L303-L323)).
3. **3단계: 이진 트리 예산 대 나쁜 순열 감쇠 (`2/5 - 3/4 = -7/20 < 0`)**:
   - 따라서 조화 가중치 $\ge \frac{3}{20}L = 0.15L$([`thm_12_harmonic_band_mertens_budget_and_sparse_complement`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L240-L261)) 이상의 소수가 퍼진(비희소) 스펙트럼을 가집니다.
   - 깊이 $k$($r = 2^k$개 잎)인 이진 트리에서 주파수 예산은 $+\frac{2}{5}\log r$ 속도로 자라는 반면([`thm_26_frequency_budget_exact_closed_form_all_k`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L132-L150)), 나쁜 겹침 순열은 $-\frac{3}{4}\log r$ 속도로 감쇠합니다([`thm_29_bad_arrangement_multinomial_decay_three_quarters`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L180-L193)).
   - 두 비율의 합이 $\frac{2}{5} - \frac{3}{4} = -\frac{7}{20} < 0$이므로 충분히 큰 $k$에서 상한과 하한이 충돌합니다([`thm_30_net_contradiction_rate_minus_seven_twentieths`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L194-L212), [`thm_35_final_amplitude_upper_vs_lower_contradiction`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L278-L295)).

---

## 4. 적대적 검증(Adversarial Audit) 요약: 화석 복원, 형식화 꼼수, 유효 문턱값 (`정리 41~55`)

1. **`#003`(`QRH`) 순환 의존성 `0`건 확증**: 논문 5절 비고 5.4가 OpenAI `#003`을 언급하지만, 두 Lean 증명 엔진 모두 `OAI.NumberTheory.DirichletL` 임포트가 `0`건이며 고전적 영점 밀도 추정만으로 완전 독립 증명되었습니다([`thm_19_qrh_003_citation_in_remark_5_4_is_strictly_optional`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L372-L386)).
2. **나쁜 순열 완전 소멸 및 트리 깊이 단축 ($k_{\min}: 7041 \to 1040$)**: 나쁜 순열($3r < 4t$)이 발생하려면 전체 잎의 절반 초과가 크기 1인 비분할 성분($r < 2t_1$)으로 남아야 합니다([`thm_41_bad_arrangement_requires_majority_unsplit_leaves`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L396-L404)). 화석 `FinalReassignments.lean`의 슬롯별 완전순열($t_1 = 0$)을 복원하면 나쁜 순열이 공집합이 되어([`thm_42_deranged_slot_pair_eliminates_bad_arrangements`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L411-L421)) 최소 이진 트리 깊이가 $k_{\min} = 7041$에서 $1040$으로 줄어들며([`thm_44_master_contraction_rate_and_depth_reduction`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L443-L459)), 반올림된 $\kappa = 8/5$를 $33/20, 17/10$으로 복원하면 우호적 소수 질량이 $+46.7\% \sim +53.3\%$ 확장됩니다([`thm_45_supply_contraction_favorable_mass_expansion`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L466-L479)).
3. **시겔 정리 비효과성 제거 및 명시적 유효 문턱값 도출 ($L_{\mathrm{eff}}: 4,115,904 \to 640,722$)**: `PublishedSiegelBound`가 등장하는 `33`개 파일 중 실제 분해는 단 `1`곳(`ZeroDensity/HadamardPrimeBound.lean:48`)에서만 일어납니다([`thm_50_effective_ostmann_counterexample_bound_master`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L569-L579)). 타투자와 정리(`denom_no_root = 384,002`)와 소인수 1개 추가 제거(`|D_ext| <= 3`, [`thm_47_tatuzawa_effective_single_exception_and_extended_deletion_budget`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L512-L523)) 및 $2^k$ 인수 약분([`thm_48_combinatorial_2k_cancellation_in_bulk_exp_margin`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L530-L537))을 결합하면, 명시적 반례 로그-로그 문턱값을 $L_{\mathrm{eff}} = 4,115,904$에서 $640,722$(방관자 셀 확장 시 $255,983$)로 단축할 수 있으며([`thm_49_explicit_effective_loglog_threshold_bottleneck_shift`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L545-L561)), 논문 3·4·6·7·8절의 핵심 기제도 전수 검증했습니다([`thm_51_section3_bonami_high_weight_exponent_and_divisor_cap`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L413-L426)~[`thm_55_section8_progression_table_zero_free_margins`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L498-L515)).
