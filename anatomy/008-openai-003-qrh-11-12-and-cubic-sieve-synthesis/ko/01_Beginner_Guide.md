# 초급 가이드: 숨겨진 두 번째 논문(`paper2.tex`), 잠들어 있는 6,252줄 코드, 그리고 $\sqrt{921}$의 비밀

> **대상 독자**: 학부생, 일반 개발자, 또는 복잡한 해석적 정수론 배경지식 없이도 OpenAI의 유사 리만 가설(`#003`) 저장소 속에서 무엇을 새로 찾아냈는지 직관적으로 이해하고 싶은 분.

---

## 1. 한눈에 보는 비유: 공항 보안 검색대와 잠겨 있는 최신형 스캐너

공항에서 가짜 신분증(영점, zeros)이 통과하지 못하도록 막는 보안 구역을 만든다고 상상해 보겠습니다.

1. **초기 설계도(`ShortDraft`)**: 경비원들이 복도의 **절반**만 감시합니다($\text{Re}(s) > 23/24$, 폭 $1/24 \approx 0.0417$). 왜냐하면 옛날 매뉴얼에 예비 안전 여백(`reserve`)을 무조건 `1/20 = 0.05`로 고정하라고 적혀 있었기 때문입니다.
2. **업그레이드 설계도(`paper2.tex` & `AlexKontorovich/quasi-rh`)**: 고정된 `1/20` 예비 여백을 원하는 만큼 줄일 수 있는 가변 나사(`CanonicalDescentScale`)로 바꾸자, 복도 폭이 정확히 **두 배**인 $\text{Re}(s) > 11/12$ (폭 $1/12 \approx 0.0833$)로 넓어졌습니다!
3. **창고에 잠든 6,252줄짜리 최신형 레이저 스캐너(`CubicGauss/`)**: 공항 창고를 열어 보니, 이미 완벽하게 조립되어 작동 시험(`0 sorry`)까지 끝난 **6,252줄짜리 최신형 3차 큰 체(Cubic Large Sieve) 스캐너**가 들어 있었습니다. 그런데 정작 복도 경비 시스템(`DirichletL`과 `CubicMoment`)에는 전원 코드가 **단 한 줄도 연결되어 있지 않았습니다**.

이것이 바로 `Case 008`이 밝혀내고 Lean 4로 완전 기계 검증한 첫 번째와 두 번째 발견입니다.

---

## 2. 왜 `Case 005` 이후에 또 파고들었나요?

이전 [`Case 005`](../../005-openai-003-qrh-mathematician-referee-audit/README.md)에서는 `CubicMoment/Blueprint.lean`(영점 비존재 경계 $7/8 = 0.875$)을 수학자 심판관 시각에서 감사하여 8대 과제를 해결했습니다.

그런데 OpenAI의 `first-proof` 저장소 전체와 최근 공개된 학계 후속 연구들을 교차 대조해 보니, 아직 아무도 연결하지 않은 **네 가지 거대한 퍼즐 조각**이 남아 있었습니다:

1. **두 개의 서로 다른 디리클레 $L$-함수 정리 ($23/24$ 대 $11/12$)**:
   - 원본 저장소의 `DirichletL/Foundation.lean`은 $\text{Re}(s) > 23/24$까지만 증명합니다.
   - 반면 같은 폴더에 들어 있는 `paper2.tex`(262쪽 단독 논문)와 Alex Kontorovich 교수의 `quasi-rh` 저장소는 **엄격히 두 배 넓은** $\text{Re}(s) > 11/12$를 증명합니다.
2. **연결되지 않은 30개 파일(`CubicGauss/`, 6,252줄)**:
   - Heath-Brown의 날카로운 $2/3$ 지수($M + N + (MN)^{2/3}$)가 이미 `0 sorry`로 증명되어 있는데, 본 증명 파일들에서는 한 번도 `import`하지 않았습니다.
3. **두 독립 연구에서 동시에 튀어나온 마법의 숫자 $\sqrt{921}$**:
   - 저희가 `Case 005`에서 찾은 안장점 $\frac{6843 - 7\sqrt{921}}{7578} \approx 0.8749755$와, 퍼듀 대학교 Baiying Liu 교수(`arXiv:2610.12234`)가 찾은 최적값 $\frac{1507 - 2\sqrt{921}}{1653} \approx 0.8749571$에 **똑같이 $\sqrt{921}$**이 등장합니다!
4. **모든 경계를 하나로 묶는 통합 공식**:
   - OpenAI의 $7/8$, Liu의 $\sqrt{921}$ 최적값, Xu–Sang(`arXiv:2610.15291`)의 $0.8748867$, 그리고 저희의 결합 해제(unbundling) 경계들을 **단 하나의 선형계획법(Farkas 보조정리) 공식**으로 통합할 수 있습니다.

---

## 3. 네 가지 핵심 발견 요약

### 발견 1: 왜 $23/24$에서 멈췄고, 어떻게 $11/12$가 되는가?
- **원인**: `CubicSieve/ClosedRecursion.lean:120`에서 분모를 `1000`, 예비 여백을 `1/20`으로 고정했기 때문에, `MeanSquare/ThetaDensity.lean:93`에서 $\sigma > 1/20$ 조건이 걸렸고, 결국 $\vartheta = 1/10$을 대입해 코시-슈바르츠 지수가 $\frac{11 + 5(1/10)}{12} = \frac{23}{24}$에 고정되었습니다([`thm_01`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L19)–[`thm_03`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L54)).
- **해결**: 고정된 `1/20` 대신 $\vartheta = 6\varepsilon/5$, $\eta = \varepsilon/2$를 넣으면 지수가 정확히 $\frac{11}{12} + \varepsilon$이 됩니다([`thm_04`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L70)–[`thm_08`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L140)).

### 발견 2: `CubicGauss/`의 비선형 점화식을 한 줄로 푸는 방법
- `CubicGauss/MainTheorem.lean`에는 $\alpha_{n+1} = \frac{6\alpha_n - 4}{3\alpha_n - 1}$이라는 분수 점화식이 있습니다.
- OpenAI는 이를 풀기 어려워 $\alpha_n = \frac{4}{3} + \left(\frac{2}{3}\right)^n$이라는 느슨한 근사식을 썼습니다.
- 저희는 **뫼비우스 좌표 변환** $u(\alpha) = \frac{\alpha - 4/3}{\alpha - 1}$을 쓰면 이 점화식이 **오차 없이 정확히** $u_{n+1} = \frac{2}{3} u_n$으로 직선화되며, 실제 오차가 OpenAI 근사식의 **정확히 $1/3$**로 줄어든다는 것을 증명했습니다([`thm_09`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L165)–[`thm_15`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L289)).

### 발견 3: 왜 하필 $\sqrt{921}$인가?
- 6차 모멘트 개수 함수가 날카로운 목표치 $2/3$와 만나는 임계 방정식이 $288\delta_c^2 - 588\delta_c + 185 = 0$입니다.
- 이 이차방정식의 판별식을 약분하면 $49^2 - 2 \times 144 \times 185 / 36 = 2401 - 1480 = \mathbf{921}$이 됩니다!
- 그래서 `Case 005`의 안장점과 Baiying Liu의 최적값 모두 수체 $\mathbb{Q}(\sqrt{921})$의 원소가 되며, 두 값의 차이는 정확히 $\frac{1195\sqrt{921} - 36189}{4175478} \approx 0.0000184$입니다([`thm_16`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L18)–[`thm_23`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L154)).

### 발견 4: 10단계 영점 비존재 경계 계보
- 세 개의 병목 면($\delta = 0$의 6차 모멘트, $\delta = \delta_c$의 2차 모멘트 $K$, 큰 체 $H$)에서 얻는 절감량 $(\Delta_0, \Delta_K, \Delta_H)$을 대입하면 모든 연구 결과가 하나의 수식으로 정렬됩니다([`thm_24`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L179)–[`thm_30`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L298)):
  - $11/12 \approx 0.9167 \to 7/8 = 0.875 \to \beta_{\mathrm{SOS}}(0) \approx 0.874975 \to B_{\mathrm{Liu}} \approx 0.874957 \to B_{\mathrm{XS}} \approx 0.874887 \to 4103/4896 \approx 0.8380 \to 4069/4896 \approx 0.8311 \to 71/108 \approx 0.6574$.

---

## 4. 다음 단계로 읽기

- 실제 Lean 4 파일 줄 번호와 점화식 유도 과정이 궁금하다면: [`02_Intermediate_Guide.md`](02_Intermediate_Guide.md)
- $\mathbb{Q}(\sqrt{921})$ 대수적 구조와 매개변수 파카스(Farkas) 쌍대성 증명이 궁금하다면: [`03_Advanced_Guide.md`](03_Advanced_Guide.md)
- 30개 정리의 SHA-256 해시와 `239/239` 돌연변이 검증 명령어를 확인하려면: [`04_Expert_Verification.md`](04_Expert_Verification.md)
