# Case 008: OpenAI `#003` 유사 리만 가설(QRH) 생태계 심층 합성 (`23/24` 대 `11/12` 격차, 미연결 `CubicGauss` 3차 큰 체, $\mathbb{Q}(\sqrt{921})$ 파카스 결합 해제)

본 디렉터리는 OpenAI `#003` 유사 리만 가설(QRH) 생태계 전체(`DirichletL/ShortDraft`, `CubicGauss/`, `paper.tex` 1부, `paper2.tex`, `AlexKontorovich/quasi-rh`, Baiying Liu의 `arXiv:2610.12234`, Xu–Sang의 `arXiv:2610.15291`, 그리고 선행 [`Case 005`](../005-openai-003-qrh-mathematician-referee-audit/README.ko.md))를 교차 해부하여 4대 발견을 30개의 Lean 4 정리(`0 sorry`, `240/240` 가설 돌연변이 포착)로 형식화한 패키지입니다.

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
- [`verify_symbolic_qrh_synthesis.py`](proofs/verify_symbolic_qrh_synthesis.py): [`symbolic_verification_result.json`](proofs/symbolic_verification_result.json)을 결정론적으로 재현하는 SymPy 기호 검증기.
