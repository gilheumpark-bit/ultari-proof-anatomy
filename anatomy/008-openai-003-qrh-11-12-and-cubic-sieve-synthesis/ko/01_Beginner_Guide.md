# 초급 가이드: 숨겨진 두 번째 논문(`paper2.tex`), 잠들어 있는 6,252줄 코드, $\sqrt{921}$의 비밀, 그리고 `001`·`005`·`008` 3부작 통합

> **대상 독자**: 학부생, 일반 개발자, 또는 복잡한 해석적 정수론 배경지식 없이도 OpenAI의 유사 리만 가설(`#003`) 저장소 속에서 무엇을 새로 찾아냈고, `0.5`($1/2$)로 가는 길이 어디까지 열렸는지 직관적으로 이해하고 싶은 분.

---

## 1. 한눈에 보는 비유: 공항 보안 검색대와 잠겨 있는 최신형 스캐너

공항에서 가짜 신분증(영점, zeros)이 통과하지 못하도록 막는 보안 구역을 만든다고 상상해 보겠습니다.

1. **초기 설계도(`ShortDraft`)**: 경비원들이 복도의 **절반**만 감시합니다($\text{Re}(s) > 23/24$, 폭 $1/24 \approx 0.0417$). 옛날 매뉴얼에 예비 안전 여백(`reserve`)을 무조건 `1/20 = 0.05`로 고정하라고 적혀 있었기 때문입니다.
2. **업그레이드 설계도(`paper2.tex` & `AlexKontorovich/quasi-rh`)**: 고정된 `1/20` 예비 여백을 원하는 만큼 줄일 수 있는 가변 나사(`CanonicalDescentScale`)로 바꾸자, 복도 폭이 정확히 **두 배**인 $\text{Re}(s) > 11/12$ (폭 $1/12 \approx 0.0833$)로 넓어졌습니다.
3. **창고에 잠든 6,252줄짜리 최신형 레이저 스캐너(`CubicGauss/`)**: 공항 창고를 열어 보니, 이미 조립되어 작동 시험(`0 sorry`)까지 끝난 **6,252줄짜리 최신형 3차 큰 체(Cubic Large Sieve) 스캐너**가 들어 있었습니다. 그런데 정작 복도 경비 시스템(`DirichletL`과 `CubicMoment`)에는 전원 코드가 **단 한 줄도 연결되어 있지 않았습니다**.
4. **세 보고서(`Case 001`·`Case 005`·`Case 008`)의 비밀 기어 맞물림**: 우리가 앞서 분석한 [`Case 001`](../../001-openai-003-qrh/README.ko.md)의 분모 `3264`(분자 `215`)와 [`Case 005`](../../005-openai-003-qrh-mathematician-referee-audit/README.ko.md)의 분모 `4896`(경계 `4069/4896`)을 맞대어 보니, `Case 001`에서 찾은 여백 $\frac{215}{3264}$에 `CubicGauss`의 큰 체 지수 $\frac{2}{3}$를 곱한 값이 **오차 0으로 정확히** `Case 005`의 전진 폭 $\frac{7}{8} - \frac{4069}{4896} = \frac{215}{4896}$과 일치했습니다!

---

## 2. 왜 `Case 001`과 `Case 005` 이후에 또 파고들었나요?

이전 [`Case 001`](../../001-openai-003-qrh/README.ko.md)과 [`Case 005`](../../005-openai-003-qrh-mathematician-referee-audit/README.ko.md)에서는 `CubicMoment/Blueprint.lean`(영점 비존재 경계 $7/8 = 0.875$)을 감사했습니다. 그런데 OpenAI의 `first-proof` 저장소 전체와 최근 공개된 학계 후속 연구들, 그리고 우리의 선행 리포트 2편을 교차 대조해 보니 **다섯 가지 핵심 퍼즐 조각**이 하나로 맞물렸습니다:

1. **두 개의 서로 다른 디리클레 $L$-함수 정리 ($23/24$ 대 $11/12$)**:
   - 원본 저장소의 `DirichletL/RowCompletion/ZeroFreeRegion.lean`은 $\text{Re}(s) > 23/24$까지만 증명합니다([`thm_01_shortdraft_fixed_reserve_and_23_24_exponent`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L19-L33)).
   - 반면 `paper2.tex`와 Alex Kontorovich 교수의 `quasi-rh` 저장소는 **엄격히 두 배 넓은** $\text{Re}(s) > 11/12$를 증명합니다([`thm_04_canonical_descent_scale_budget_unlocks_arbitrary_theta`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L70-L85)).
2. **연결되지 않은 30개 파일(`CubicGauss/`, 6,252줄)과 전 구간 수학적 귀납법 해**:
   - Heath-Brown의 날카로운 $2/3$ 지수($M + N + (MN)^{2/3}$)가 이미 `0 sorry`로 증명되어 있는데, 본 증명 파일들에서는 한 번도 `import`하지 않았습니다([`thm_15_unimported_cubic_gauss_vs_bundled_cubic_gram_gap`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L289-L303)).
   - 나아가 Lean 4에서 재귀함수 `sieveIter`를 정의하고 수학적 귀납법(`induction n`)을 적용하여, **모든 자연수 $n \in \mathbb{N}$**에 대해 점화식의 정확한 닫힌 해 $\tilde{\alpha}_n = \frac{4\cdot 3^n - 2^{n+1}}{3\cdot 3^n - 2^{n+1}}$을 증명했습니다([`thm_31_sieve_iter_mobius_invariants_by_induction`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L36-L69)–[`thm_33_sieve_iter_strictly_beats_openai_sieve_exponent_all_n`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L92-L107)).
3. **두 독립 연구에서 동시에 튀어나온 마법의 숫자 $\sqrt{921}$ (`ZSqrt921` 정역)**:
   - 저희가 `Case 005`에서 찾은 안장점 $\frac{6843 - 7\sqrt{921}}{7578} \approx 0.8749755$와, 퍼듀 대학교 Baiying Liu 교수(`arXiv:2610.12234`)가 찾은 최적값 $\frac{1507 - 2\sqrt{921}}{1653} \approx 0.8749571$에 똑같이 $\sqrt{921}$이 등장합니다([`thm_16_shared_critical_quadratic_288_588_185_and_count_2_3`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L18-L34), [`thm_34_zsqrt921_norm_and_critical_quadratic_root`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L130-L137)–[`thm_35_zsqrt921_liu_rationalization_and_case005_gap`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L144-L157)).
4. **모든 경계를 하나로 묶는 통합 공식 (매개변수 파카스 쌍대성)**:
   - OpenAI의 $7/8$, Liu의 $\sqrt{921}$ 최적값, Xu–Sang(`arXiv:2610.15291`)의 $0.8748867$, 그리고 저희의 결합 해제(unbundling) 경계들을 **단 하나의 선형계획법(Farkas 보조정리) 공식**으로 통합했습니다([`thm_24_parametric_unbundled_farkas_shift_theorem`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L179-L201)–[`thm_30_master_qrh_ecosystem_synthesis_verdict`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L298-L311)).
5. **`Case 001` $\leftrightarrow$ `Case 005` $\leftrightarrow$ `Case 008` 3부작 대수적 브리지 (`Theorems 36–45`)**:
   - `Case 001`의 소수 기울기 `17`이 $17 \times 96 = 1632 = \gcd(3264, 4896)$을 만들고, `Case 001`의 여백 $\frac{215}{3264}$가 $\frac{2}{3}$배 축소되어 `Case 005`의 $\frac{215}{4896}$가 되며, `Case 008`의 `CubicGauss` 고정점 $\alpha^* = \frac{4}{3}$과 `Case 005`의 극점 장벽 $\beta_{\mathrm{pole}} = \frac{2}{3}$가 정확히 $\alpha^* + \beta_{\mathrm{pole}} = 2$ 쌍대 관계임을 증명했습니다([`thm_36_trilogy_denominator_bridge_3264_and_4896`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L167-L178)–[`thm_45_grand_trilogy_synthesis_verdict`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L338-L355)).

---

## 3. 엄밀한 범위 경계(`Ultari`): `0.5`($\beta = 1/2$)로 가는 길은 어디까지 열렸는가?

리만 가설의 최종 목적지인 임계선 $\beta = 1/2 = 0.5000$을 향해 **무엇이 이미 해결되었고, 무엇이 진정한 미해결 난제로 남아 있는지** 명확한 울타리(`Ultari`)를 칩니다:

1. **기존 `0 sorry` 부품 조립만으로 도달 가능한 영역 ($\frac{23}{24} \approx 0.9583 \to \frac{71}{108} \approx 0.6574$)**:
   - 가변 하강 스케일(`CanonicalDescentScale`), 그램 행렬 결합 해제(`Case 001`), 슈티켈베르거 소멸자(`Case 005`), 그리고 창고에 잠들어 있던 30개 파일 `CubicGauss`의 날카로운 $2/3$ 큰 체(`Case 008`)를 배선하면, 새로운 해석적 가설 없이도 영점 비존재 경계가 $\frac{23}{24} \to \frac{11}{12} \to \frac{7}{8} \to \frac{4069}{4896} \to \mathbf{\frac{71}{108} \approx 0.6574}$까지 내려갑니다(영점 비존재 폭 **8.22배** 확장).
2. **`0.5`로 가는 길목을 가로막던 '수식 폭발(극점) 바위' 제거 ($\beta_{\mathrm{pole}}: \frac{2}{3} \to \frac{7}{12} \to \frac{1}{2}$)**:
   - 기존에는 $\beta = 2/3 \approx 0.6667$ 위치에 데데킨트 제타 함수의 극점(`coordR` at $w=1$)이 버티고 있어서 $2/3$ 아래로는 수식 자체가 발산했습니다.
   - `Case 001`의 가우스 분기 6/8 소멸($1/6 \to 1/12$)과 `Case 005`의 슈티켈베르거 소멸자($k_\infty = -6$, 순 극점 위수 $1 - 1 = 0$)를 결합해 이 극점 장벽을 $\frac{2}{3} \to \frac{7}{12} \to \frac{1}{2}$로 치워버렸습니다([`thm_40_cubic_gauss_plus_stickelberger_crosses_two_thirds`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L249-L257), [`thm_41_case001_gauss_branch_vanishing_drives_case005_pole_shift`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L264-L277)). 즉 **$0.5$까지 내려가는 고속도로의 바위는 치워졌습니다.**
3. **남아 있는 진짜 수학적 난제 ($\frac{71}{108} \approx 0.6574 \to \frac{1}{2} = 0.5000$, 잔여 거리 $\frac{17}{108} \approx 0.1574$)**:
   - 공통분모 `44064` 위에서 $\frac{23}{24}$부터 $\frac{1}{2}$까지의 전체 거리 `20196` 중 `13260`($\frac{71}{108}$까지)은 기존 부품들의 결합으로 주파되지만, 마지막 남은 두 구간 `3264 + 3672 = 6936`($\frac{71}{108} \to \frac{7}{12} \to \frac{1}{2}$)을 주파하려면 **오차(모멘트 에너지) 자체를 추가로 $\Delta_{\mathrm{hybrid}} = \frac{14}{33} \approx 0.4242$만큼 더 깎는 새로운 해석적 정수론 정리**(예: 6차 모멘트 비대각 클루스터만 합에서의 제곱근 상쇄 또는 준볼록성)를 증명해야 합니다([`thm_44_six_stage_trilogy_telescoping_decomposition`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L316-L331)).

---

## 4. 10단계 영점 비존재 경계 계보 요약표

| 단계 | 출처 및 핵심 메커니즘 | 정확한 영점 비존재 경계 $\beta$ | 소수점 수치 | 영점 비존재 폭 $1 - \beta$ |
| :--- | :--- | :--- | :--- | :--- |
| 1 | OpenAI 원본 `ShortDraft` (`ZeroFreeRegion.lean`) | $23/24$ | $0.95833333$ | $1/24 \approx 0.04167$ ($1.00\times$) |
| 2 | OpenAI `paper2.tex` & `AlexKontorovich/quasi-rh` | $11/12$ | $0.91666667$ | $1/12 \approx 0.08333$ ($2.00\times$) |
| 3 | OpenAI `SevenEighths.lean` 기준선 | $7/8$ | $0.87500000$ | $1/8 = 0.12500$ ($3.00\times$) |
| 4 | `Case 005` 고정 스케일 전역 SOS 안장점 (`b=1/8, ℓ=1/6`) | $(6843 - 7\sqrt{921})/7578$ | $0.87497547$ | $0.12502453$ ($3.0006\times$) |
| 5 | Baiying Liu 유리수 섭동 (`B_r`, `arXiv:2610.12234`) | $34999/40000$ | $0.87497500$ | $5001/40000 = 0.125025$ |
| 6 | Baiying Liu 3면 등화 $\mathbb{Q}(\sqrt{921})$ 최적값 (`B_Liu`) | $(1507 - 2\sqrt{921})/1653$ | $0.87495707$ | $0.12504293$ ($3.0010\times$) |
| 7 | Xu–Sang $\delta = 0$ 6차 모멘트 증폭 (`arXiv:2610.15291`) | $8748867/10000000$ | $0.87488670$ | $0.12511330$ ($3.0027\times$) |
| 8 | `Case 005` 2항 그램 결합 해제 + 슈티켈베르거 이동 | $4103/4896$ | $0.83803105$ | $793/4896 \approx 0.16197$ ($3.89\times$) |
| 9 | `Case 001` + `Case 005` 3항 결합 해제 (`7/8 - 215/4896`) | $4069/4896$ | $0.83108660$ | $827/4896 \approx 0.16891$ ($4.05\times$) |
| 10 | `Case 005` + `Case 008` 날카로운 3차 큰 체 연결 (`CubicGauss`) | $71/108$ | $0.65740741$ | $37/108 \approx 0.34259$ ($8.22\times$) |

---

## 5. 다음 단계로 읽기

- 실제 Lean 4 파일 줄 번호와 5대 기둥의 아키텍처 해부가 궁금하다면: [`02_Intermediate_Guide.md`](02_Intermediate_Guide.md)
- 전 구간 수학적 귀납법(`induction n`), $\mathbb{Z}[\sqrt{921}]$ 정역, 그리고 `001`·`005`·`008` 3부작 대수 증명이 궁금하다면: [`03_Advanced_Guide.md`](03_Advanced_Guide.md)
- 45개 정리의 SHA-256 해시와 `344/344` 돌연변이 검증 명령어를 확인하려면: [`04_Expert_Verification.md`](04_Expert_Verification.md)
