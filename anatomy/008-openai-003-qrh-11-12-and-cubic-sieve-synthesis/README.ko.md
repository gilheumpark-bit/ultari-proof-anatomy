# Case 008: OpenAI `#003` 유사 리만 가설(QRH) 생태계 심층 합성 (`23/24` 대 `11/12` 격차, 미연결 `CubicGauss` 3차 큰 체, $\mathbb{Z}[\sqrt{921}]$ 파카스 결합 해제, 그리고 `001`·`005`·`008` 3부작 통합)

본 디렉터리는 OpenAI `#003` 유사 리만 가설(QRH) 생태계 전체(`DirichletL/ShortDraft`, `CubicGauss/`, `paper.tex` 1부, `paper2.tex`, `AlexKontorovich/quasi-rh`, Baiying Liu의 `arXiv:2610.12234`, Xu–Sang의 `arXiv:2610.15291`, 그리고 선행 [`Case 001`](../001-openai-003-qrh/README.ko.md) 및 [`Case 005`](../005-openai-003-qrh-mathematician-referee-audit/README.ko.md))를 교차 해부하여 45개의 Lean 4 정리 + 7개 `def`(`0 sorry`, `344/344` 가설 돌연변이 포착)로 형식화한 패키지입니다.

## 4단계 해설 문서 (`ko/` · `en/`)

- **한국어 (`ko/`)**:
  - [01_Beginner_Guide.md](ko/01_Beginner_Guide.md)
  - [02_Intermediate_Guide.md](ko/02_Intermediate_Guide.md)
  - [03_Advanced_Guide.md](ko/03_Advanced_Guide.md)
  - [04_Expert_Verification.md](ko/04_Expert_Verification.md)
- **English (`en/`)**:
  - [01_Beginner_Guide.md](en/01_Beginner_Guide.md)
  - [02_Intermediate_Guide.md](en/02_Intermediate_Guide.md)
  - [03_Advanced_Guide.md](en/03_Advanced_Guide.md)
  - [04_Expert_Verification.md](en/04_Expert_Verification.md)

## 형식 증명 및 기호 검증 스크립트 (`proofs/`)

- [`qrh_eleven_twelfths_and_cubic_large_sieve.lean`](proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L1-L305): 정리 1–15 (`0 sorry`, `115/115` 가설 돌연변이 포착). 제1축($\text{Re}(s) > 23/24$ 대 $\text{Re}(s) > 11/12$ 스케일링 격차 및 `CanonicalDescentScale`)과 제2축(미연결 30개 파일 `CubicGauss/`의 날카로운 Heath-Brown 3차 큰 체 및 뫼비우스 좌표 선형화) 검증.
- [`qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean`](proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L1-L313): 정리 16–30 (`0 sorry`, `125/125` 가설 돌연변이 포착). 제3축(`Case 005`의 $\beta_{\mathrm{SOS}}(0)$와 Baiying Liu의 $B_{\mathrm{Liu}}$ 사이의 $\mathbb{Q}(\sqrt{921})$ 대수적 통합 및 정확한 격차 $\frac{1195\sqrt{921}-36189}{4175478}$)과 제4축(매개변수 파카스 쌍대성 정리 및 10단계 영점 비존재 경계 계보) 검증.
- [`qrh_trilogy_induction_and_algebraic_bridge.lean`](proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L1-L356): 정리 31–45 + `def` 7개 (`0 sorry`, `104/104` 가설 돌연변이 포착). 모든 자연수 $n \in \mathbb{N}$에 대한 `sieveIter` 수학적 귀납법(`induction n`) 증명, 이차 정역 $\mathbb{Z}[\sqrt{921}]$ 구조체 연산, 3부작(`Case 001` $\leftrightarrow$ `Case 005` $\leftrightarrow$ `Case 008`) 대수적 통합(`3264`/`4896`/`215`/`44064` 및 아이젠슈타인 극점 쌍대성 $\alpha^* + \beta_{\mathrm{pole}} = 2$), 그리고 기존 `0 sorry` 모듈 조립으로 도달 가능한 $\beta = 71/108 \approx 0.6574$(극점 장벽 제거 포함)와 미해결 해석적 난제 구간($\frac{71}{108} \to \frac{1}{2} = 0.5$, 추가 절감량 $\Delta_{\mathrm{hybrid}} = 14/33$ 필요) 사이의 엄밀한 경계 검증.
- [`verify_symbolic_qrh_synthesis.py`](proofs/verify_symbolic_qrh_synthesis.py): [`symbolic_verification_result.json`](proofs/symbolic_verification_result.json)을 결정론적으로 재현하는 SymPy 기호 검증기.
