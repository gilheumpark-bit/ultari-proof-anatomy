# 중급 가이드: 충돌 안정성 벌점, 국소 커널 수축(`-11/125`), 이진 트리 전이(`-7/20`)

## 1. 9개 절 논문 본문과 두 Lean 증명 엔진의 대응 구조

OpenAI의 프리프린트 `preprints/the-additive-indecomposability-of-the-primes-September-24-2026/build/`는 총 9개 수학 절(`sections/01-introduction.tex` ~ `09-conclusion.tex` 합계 `6,072`줄, 루트 파일 `paper.tex`·`glyph-mappings.tex`·`references.bib` `552`줄 포함 총 `6,624`줄, [`thm_38_paper_9_sections_to_lean_subsystem_mapping`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L332-L356))로 이루어져 있습니다:

| LaTeX 절 파일 | 줄 수 | 핵심 수리 역할 | 대응하는 `OAI/NumberTheory/Ostmann/` 하위 폴더 |
| :--- | :---: | :--- | :--- |
| `01-introduction.tex` | `141` | 주정리 및 2단계 귀류법 골격 소개 | `Complete.lean`, `Main.lean`, `Result.lean`, `Corollaries.lean` |
| `02-preliminaries.tex` | `292` | 유한 가산항 CRT, 엘숄츠 창, 충돌 안정성 | `FiniteCRT.lean`, `FiniteFactor.lean`, `Preliminaries/` |
| `03-quadratic.tex` | `1,076` | 이차 지표 대체(Large Sieve) 및 예외 영점 제어 | `Quadratic/`, `QuadraticCenter/` |
| `04-characters.tex` | `1,182` | 고차 지표 코시-슈바르츠 트리 및 앵커 코드 | `Characters/` |
| `05-supply.tex` | `772` | 비희소 푸리에 공급(`-11/125`) 및 몽고메리 $Q^7$ 영점 밀도 | `Supply/`, `ZeroDensity/` |
| `06-tree.tex` | `683` | 이진 트리 전이 점화식 및 단일 다이어그램 $3^r$ 모멘트 | `Tree/` |
| `07-construction.tex` | `784` | 다중 스케일 스케줄($z = k^4, r = 2^k$) 및 셀 선택 | `Construction/` |
| `08-arithmetic.tex` | `756` | 이동 주파수 절단(cutoff) 및 공분산 추정 | `Arithmetic/` |
| `09-conclusion.tex` | `386` | 나쁜 겹침 순열(`-3/4`) 및 `-7/20 log r` 최종 모순 | `Conclusion/` |

---

## 2. 2절: 유한 가산항 CRT, 이동 체, `[1/3, 2/3]` 균형 밀도 대역

$A + B =_{\mathrm{cofinite}} \mathcal{P}$라고 가정하면, 어떤 절단값 $N$ 이상에서 $A + B$의 원소는 모두 소수이고 $N$보다 큰 모든 소수는 $A + B$에 속합니다.

### 2.1 유한 가산항 배제 (`Lemma 2.2`, `FiniteCRT.lean`, `FiniteFactor.lean`)
$A$가 유한 집합($\max A \le M$)이고 서로 다른 두 원소 $a_0 \neq a_1$을 포함한다면, $a_0 \leftrightarrow a_1$만 맞바꾸고 나머지 원소는 고정하는 전단사 함수 $f : A \to A$를 정의합니다. 각 $a \in A$마다 서로 다른 소수 $q_a = p_{M + a} > M \ge a$를 고르고, 중국인의 나머지 정리(CRT)로 $\gcd(r, \prod_{a \in A} q_a) = 1$이면서 다음 합동식을 만족하는 정수 $r$을 찾습니다:
$$r \equiv q_a + a - f(a) \pmod{q_a} \quad (\forall a \in A).$$
디리클레 정리에 의해 $p > M + \max_a q_a + N$이고 $p \equiv r \pmod{\prod q_a}$인 소수 $p = a + b \in A + B$가 존재합니다. 이때 이동된 합 $s = f(a) + b \in A + B$는 다음을 만족합니다([`thm_06_finite_summand_crt_dirichlet_composite_witness`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L136-L159)):
$$s = p - a + f(a) \equiv r - a + f(a) \equiv q_a \equiv 0 \pmod{q_a}, \qquad s > p - M > q_a \ge 2.$$
즉 $s = k_{\mathrm{mult}} q_a$ ($k_{\mathrm{mult}} \ge 2$)는 $q_a$의 진배수인 합성수가 되어 모순입니다.

### 2.2 엘숄츠 제곱근 창과 충돌 안정성 벌점 (`Lemma 2.1`, `Lemma 2.4`, `Lemma 2.5`)
$A, B$가 모두 무한 집합일 때, $Q = \sqrt{X}/(\log X)^{b+1}$ ($b = 4 \implies b+1 = 5$, [`thm_07_shifted_sieve_modulus_exponent_and_elsholtz_window`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L160-L176))에 대해 $[z_0, Q^{1/(10j)}]$ 구간의 소수 곱으로 체질을 수행하면 원소 개수 함수 $A(Y), B(Y)$는 엘숄츠 창에 갇힙니다:
$$\frac{\sqrt{Y}}{(\log Y)^3} \ll A(Y), B(Y) \ll \sqrt{Y}(\log Y)^2.$$
각 소수 $p \le Q$에 대해 꼬리 잉여류 집합 $A_p, B_p \subseteq \mathbb{Z}/p\mathbb{Z}$는 $(A_p + B_p) \cap \{0\} = \emptyset$이므로 $|A_p| + |B_p| \le p$입니다. 국소 밀도 $\sigma_p = |A_p|/p \in (0, 1)$에 대해 분모를 $p^2$으로 통분하면 다음 정확한 다항 항등식이 성립합니다([`thm_08_collision_stability_reciprocal_penalty_identity`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L177-L188)):
$$\frac{1}{\sigma_p} + \frac{1}{1 - \sigma_p} - 4 = \frac{(2\sigma_p - 1)^2}{\sigma_p(1 - \sigma_p)} \ge 0.$$
특히 $\sigma_p \notin (1/3, 2/3)$일 때($3a \le p$ 또는 $3a \ge 2p$), 분모를 소거한 차이는 다음과 같이 인수분해됩니다([`thm_09_unbalanced_density_penalty_lower_bound_one_half`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L189-L203)):
$$2(2a - p)^2 - a(p - a) = (p - 3a)(2p - 3a) \ge 0 \implies \frac{(2\sigma_p - 1)^2}{\sigma_p(1 - \sigma_p)} \ge \frac{1}{2}.$$
따라서 $[1/3, 2/3]$ 바깥의 불균형 소수들의 역수 합은 $\sum_{\sigma_p \notin [1/3, 2/3]} 1/p = O(1)$로 유계입니다.

---

## 3. 5절: 비희소 푸리에 공급과 `-11/125` 국소 커널 수축 지수

이중 로그 소수 대역 $\mathcal{B}_L = \{p : \frac{1}{20}L \le \log\log p \le \frac{9}{10}L\}$의 전체 메르텐스 조화 질량은 $(\frac{9}{10} - \frac{1}{20})L = \frac{17}{20}L + o(1) = 0.85L + o(1)$입니다([`thm_12_harmonic_band_mertens_budget_and_sparse_complement`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L240-L261)). 명제 5.1(`Supply/NonsparseSupply.lean`)은 $\sigma_p \in [1/3, 2/3]$이면서 푸리에 평탄도 $\gamma_p \ge \delta_0$인 비희소 균형 소수들의 조화합이 최소 $\frac{3}{20}L = 0.15L$임을 증명합니다.

**귀류법 검증**:
1. 비희소 균형 소수의 조화합이 $< \frac{3}{20}L$이라고 가정하면, 여집합인 **희소 균형 소수 집합** $\mathcal{S} \subseteq \mathcal{B}_L$의 조화 질량은 최소 $(\frac{17}{20} - \frac{3}{20})L - o(L) = \frac{7}{10}L - o(L) \ge \frac{17}{25}L = 0.68L$입니다($\frac{7}{10} - \frac{17}{25} = \frac{1}{50} = 0.02$의 메르텐스 여유분 확보, [`thm_12_harmonic_band_mertens_budget_and_sparse_complement`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L240-L261)).
2. 사영 가중치 $t_0 = \frac{17}{20} = 0.85$와 다중원판 반지름 $R = \frac{103}{100} = 1.03$에서 우하단 블록 노름은 $R t_0 = \frac{1751}{2000} = 0.8755 < \frac{19}{20} = 0.95$이고([`thm_13_local_transfer_polydisc_contraction_margin`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L262-L281)), $u = v = 1$에서 스칼라 블록의 주 수축 기울기는 $2t_0 = \frac{17}{10} = 1.7$이므로 보조정리 5.2의 수축률 $c_{\mathrm{loc}} = \frac{8}{5} = 1.6$ (`s_p(1, 1) \le 1 - \frac{8}{5p}`) 위로 $\frac{1}{10}$의 오차 흡수 여유가 남습니다([`thm_14_scalar_block_leading_slope_and_lemma_5_2_contraction`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L282-L302)).
3. $\mathcal{S}$ 위에서 텐서 곱을 취하면 상한은 $\exp(-\frac{8}{5}H)\sqrt{z} \le \exp(-\frac{136}{125}L)\sqrt{z}$인 반면, 몽고메리 영점 밀도 추정($T = Q^5 \implies Q^2 T = Q^7$, 꼬리 오차 $Q^{-8}$)과 란다우-페이지 예외 영점 소수 최대 1개 제거([`thm_16_montgomery_zero_density_Q7_and_tail_Q_minus_8`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L324-L339), [`thm_18_page_exceptional_zero_single_prime_deletion_budget`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L355-L371))로 얻는 소수 피복 하한은 $z\exp(-L)$이므로 다음 모순이 도출됩니다([`thm_15_supply_contradiction_exponent_11_125`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L303-L323)):
   $$\sqrt{z} \le \exp\left(\left(1 - \frac{8}{5}\cdot\frac{17}{25}\right)L + o(L)\right) = \exp\left(-\frac{11}{125}L + o(L)\right) = \exp(-0.088L + o(L)).$$

---

## 4. 6~9절: 이진 트리 전이(`+2/5 log r`) 대 나쁜 순열(`-3/4 log r`)의 결합 모순

5절에서 확보한 비희소 푸리에 공급($\ge \frac{3}{20}L$) 위에서 깊이 $k$($r = 2^k$, 스케일 $z = k^4$, 짝수 벌크 크기 $m = 2\lfloor zL/2\rfloor$, [`thm_25_section_7_schedule_scales_and_even_bulk_size`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L117-L131))인 이진 전이 트리를 구성합니다:
- **모든 $k$에 대한 귀납적 주파수 예산 합산 (`thm_21`~`thm_26`)**: $k$에 대한 구조적 수학적 귀납법(`induction k`, [`thm_21_dyadic_tree_leaf_sum_by_induction`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L30-L50) 및 [`thm_22_weighted_dyadic_level_sum_by_induction`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L51-L79))에 의해
  $$\sum_{j=0}^{k-1} 2^j = 2^k - 1 = r - 1, \qquad \sum_{j=0}^{k-1} j 2^j = (k - 2)2^k + 2$$
  가 성립하며, 누적 주파수 예산 $E_k / (rm)$의 $k$-의존 최고차 계수는 정확히 $+\frac{2}{5}\log r = +0.40\log r$입니다([`thm_26_frequency_budget_exact_closed_form_all_k`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L132-L150)).
- **나쁜 겹침 순열의 다항 감쇠 (`thm_28`~`thm_30`)**: 겹침 그래프의 연결 성분 개수 $t$가 병합 결손 조건 $\sum_{i=1}^t (a_i - 1) = r - t < r/4$를 만족하면 $t > \frac{3}{4}r$이 강제되며([`thm_28_overlap_graph_component_merge_bound`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L168-L179)), 나쁜 순열의 비율은 $rm$당 $-\frac{3}{4}\log r = -0.75\log r$의 지수율로 감쇠합니다([`thm_29_bad_arrangement_multinomial_decay_three_quarters`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L180-L193)).
- **최종 모순율 $-\frac{7}{20}\log r$ (`thm_30`~`thm_35`)**: 두 지수율을 더하면 `Scales.lean:85-87` (`finalRate`) 및 `09-conclusion.tex:367`의 정확한 순 모순율이 나옵니다([`thm_30_net_contradiction_rate_minus_seven_twentieths`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L194-L212)):
  $$\frac{2}{5} - \frac{3}{4} = \frac{8 - 15}{20} = -\frac{7}{20} = -0.35 < 0.$$
  $\log r = k\log 2$는 $k$에 대해 선형으로 감소하고 $\log z = 4\log k$는 로그적으로만 자라므로, 충분히 큰 $k$에서 상한 $|\eta_k|^2 \le \exp(-(2B+1)rm)$이 하한 $|\eta_k|^2 \ge \exp(-2Brm)$을 깨뜨립니다([`thm_34_linear_k_log_2_dominates_logarithmic_4_log_k`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L264-L277), [`thm_35_final_amplitude_upper_vs_lower_contradiction`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L278-L295)).

---

## 5. 화석 복원, 유효 문턱값, 3·4·6·7·8절 핵심 기제 (`정리 41~55`)

- **슬롯별 완전순열 복원 및 마스터 수축률 공식 (`thm_41`~`thm_45`)**: $r$개 잎 위의 $m$-정칙 중첩 그래프에서 연결 성분 $t = t_1 + t_{\ge 2}$에 대해 $2(t - t_1) \le r - t_1 \implies 2t \le r + t_1$이므로, 나쁜 순열 조건 $3r < 4t$는 $r < 2t_1$([`thm_41_bad_arrangement_requires_majority_unsplit_leaves`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L396-L404)) 및 $4a_c \le r + 4$([`thm_43_bad_component_max_size_quarter_bound`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L427-L434))를 강제합니다. `Construction/FinalReassignments.lean`의 슬롯별 완전순열($t_1 = 0$)을 복원하면 나쁜 순열이 공집합이 되어([`thm_42_deranged_slot_pair_eliminates_bad_arrangements`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L411-L421)) 마스터 수축률 $\gamma = 1 - 2\theta - \delta_{\mathrm{step}}$이 $7/20$ ($k_{\min} = 7041$)에서 $17/20$ ($2036$), $19/20$ ($1803$), $20/20$ ($1040$, [`thm_44_master_contraction_rate_and_depth_reduction`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L443-L459))으로 향상되며, 무손실 $\kappa = 33/20, 17/10$ 복원은 우호적 소수 질량을 $0.22L, 0.23L$로 확장합니다([`thm_45_supply_contraction_favorable_mass_expansion`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L466-L479)).
- **시겔 정리 비효과성 제거 및 명시적 유효 문턱값 (`thm_46`~`thm_50`)**: `PublishedSiegelBound`가 등장하는 `33`개 파일 중 단 `1`개(`ZeroDensity/HadamardPrimeBound.lean:48`)만 가설을 분해합니다([`thm_50_effective_ostmann_counterexample_bound_master`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L569-L579)). `¬ hnear` 분기($K_{\mathrm{away}} = 1600, L_{\mathrm{sec3, away}} = 56,170$) 및 `#003` QRH ($K_{\mathrm{QRH}} = 8, L_{\mathrm{sec3, QRH}} = 39,613$, [`thm_46_siegel_bound_effective_under_qrh_and_away_branch`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L491-L503)), 또는 무조건부 타투자와 정리(`denom_no_root = 384,002`) + 소인수 1개 추가 제거($|D_{\mathrm{ext}}| \le 3, L_{\mathrm{sec3, Tat}} = 87,689$, [`thm_47_tatuzawa_effective_single_exception_and_extended_deletion_budget`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L512-L523))와 `MovingFinalRate.lean:50`의 $2^k$ 인수 약분([`thm_48_combinatorial_2k_cancellation_in_bulk_exp_margin`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L530-L537))을 결합하면, 전역 유효 문턱값 $L_{\mathrm{eff}}$가 $4,115,904$ ($k = 7041$)에서 $640,722$ ($k = 1040$) 및 $255,983$으로 단축됩니다([`thm_49_explicit_effective_loglog_threshold_bottleneck_shift`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L545-L561)).
- **3·4·6·7·8절 논문-Lean 1:1 핵심 기제 (`thm_51`~`thm_55`)**: 3절의 약수 개수 상한 $\omega(P) \le 7$과 보나미 고가중치 감쇠 지수 $-\frac{\tau}{8\mu_0}K = -625K$([`thm_51_section3_bonami_high_weight_exponent_and_divisor_cap`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L413-L426)), 4절의 앵커 코드 단측 제곱 지표 이분법 $(\pm 2, 0)$ 대 $(0, \pm 2)$ 및 엔트로피 여유분 $0.6871k$([`thm_52_section4_anchor_code_one_sided_dichotomy_and_margin`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L434-L449)), 6절의 성분-사중주 이분 다중그래프 순환 임계치 $V_{\mathrm{bip}} = b + r/4 \le r = E_{\mathrm{bip}}$와 아핀 힐베르트-슈미트 상한 $3/q^2$([`thm_53_section6_bipartite_quartet_cycle_and_affine_hs_bound`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L458-L470)), 7절의 5대 서로소 $\log\log p$ 소수 대역([`thm_54_section7_five_disjoint_prime_scale_hierarchy`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L479-L491)), 8절의 2행 등차수열(`giant` 대 `bulk`) 저영점 여유분([`thm_55_section8_progression_table_zero_free_margins`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L498-L515))을 형식화했습니다.
