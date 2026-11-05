# `ultari-proof-anatomy`: 인간 및 AI 수학·과학 증명 해부 아카이브

> **언어 선택 (Language)**: [**English (`README.md`)**](./README.md) | **한국어**

[![Lean 4](https://img.shields.io/badge/Lean_4-v4.29.0--rc8_Verified-blue)](#1줄-전체-저장소-검증-명령어)
[![Theorems & Mutants](https://img.shields.io/badge/Verified_Archive-316_Theorems_%7C_1%2C731%2F1%2C731_Mutants_Killed-purple)](#논문-및-형식증명-해부-아카이브-목록)
[![Symbolic Solver](https://img.shields.io/badge/SymPy-Exact_Rational_%26_Radical-success)](#1줄-전체-저장소-검증-명령어)
[![Zero Sorry](https://img.shields.io/badge/Proof_Integrity-0_sorry_%7C_0_axiom-brightgreen)](#1줄-전체-저장소-검증-명령어)
[![License](https://img.shields.io/badge/License-Apache_2.0_%7C_CC_BY_4.0-orange.svg)](./LICENSE)

**'울타리(`Ultari`)'**는 검증된 사실과 증명되지 않은 추측을 구분하는 **엄밀한 경계(Protective Boundary)**를 뜻합니다.

**`ultari-proof-anatomy`**는 인간 학자나 프론티어 AI가 작성한 수학·과학 논문과 대규모 `Lean 4` 형식증명 코드를 분해하여 **정확한 대수 불변량**, **독립 실행 가능한 `Lean 4` 정리(`0 sorry`)**, 그리고 **초보자부터 전문가·자동 파서까지 읽을 수 있는 4단계 가이드**로 제공하는 오픈 리서치 아카이브입니다.

> **아카이브 검증 규모 (`001`~`008`)**: **8개 심층 해부 사례** · **독립 Lean 4 정리 총 `316`개** (`0 sorry`, `0 axiom`) · **전칭 가설 돌연변이 사살 `1,731 / 1,731`건 (`100%`)** · **원본 대조 `.lean` 파일 `14,531`개**.

---

## 설립 목적: 무엇을 하는 곳인가

1. **하드코딩된 상수(매직 넘버)와 숨은 여유분 역산**:
   - 대규모 형식증명 코드는 증명 전술(`gcongr`, `linarith`)을 빠르게 통과시키기 위해 무리수 정류점을 근사 유리수로 바꾸거나 상한을 넉넉하게 잡는 경우가 많습니다.
   - 본 아카이브는 코드를 줄 단위로 역추적하여 **원래의 정확한 대수 방정식**과 **부등식 내부에 남아 있는 여유분(Slack)**을 계산합니다.
2. **'실제로 증명된 범위'와 '미해결 영역' 사이의 명확한 울타리(`Ultari`)**:
   - 모든 주장은 1줄 명령어로 재현되는 **`Lean 4` 커널 증명(`0 sorry`, `0 axiom`)**과 **기호 연산 스크립트(`SymPy`)**로 검증합니다.
   - 각 사례마다 **형식증명 코드가 실제로 증명한 대수·해석적 범위**와 **단순화된 모델 가정 또는 미해결로 남은 영역**을 명확히 구분해 적습니다.
3. **독자 눈높이에 맞춘 4단계 가이드 (`ko/` · `en/`)**:
   - 모든 해부 사례는 한국어와 영어로 각각 4단계 문서를 제공합니다:
     - **1단계 (`01_초보자용`)**: 복잡한 수식 없이 핵심 질문과 결론을 한눈에 이해하는 쉬운 해설.
     - **2단계 (`02_중급자용`)**: 핵심 방정식과 전체 Lean 4 정리 1대1 줄 번호 색인표.
     - **3단계 (`03_전문가용`)**: 상세 수식 유도, 교차 검증표 및 증명 범위 한계 명세서.
     - **4단계 (`04_자동검증용` & `manifest.json`)**: 1줄 검증 명령어 및 SHA-256 해시 원장.

---

## 논문 및 형식증명 해부 아카이브 목록

**번호(`001`~`008`)**를 누르면 각 사례의 요약 페이지로 이동하며, 오른쪽 끝 열에서 **1단계 초보자용 쉬운 해설**을 바로 읽을 수 있습니다.

| 번호 | 분석 대상 논문 및 원본 규모 | 한눈에 보는 핵심 해부 결과 (3줄 요약) | 검증 산출물 (`0 sorry`) | 4단계 가이드 (`ko` / `en`) |
| :---: | :--- | :--- | :--- | :---: |
| **[`001`](./anatomy/001-openai-003-qrh/README.ko.md)** | **OpenAI `#003`: 준리만 가설 ($\text{Re}(s) > 7/8$)**<br>`openai/math` family `003`<br>(`DirichletL/` 및 `SiegelZeros/` `3,414`개 `.lean` 파일) | • **정확한 무리수 정류점 복원**: `Endpoint.lean`의 유리수 근사점($\frac{283}{408}$) 뒤에 숨은 원래 2차 방정식 해 $a^* = \frac{323}{276} - \frac{35\sqrt{16354}}{9384} \approx 0.6933$과 바닥 마진 영점 $a_{\max} = \frac{37}{72}$를 도출합니다.<br>• **그람 행렬 지수 여유분**: 성분별 선형 지수($\frac{14+17\delta}{96}$, 차이 $\frac{215}{3264}$), 쌍선형 지수($\frac{1}{16}+\frac{17\delta}{96}$, 차이 $\frac{487}{3264}$), 묶음 상한($\frac{3}{16}+\frac{23\delta}{96}$) 사이의 가산 여유분을 분리합니다.<br>• **꼬리항 소멸 및 임계치 축소**: $m \ge 2$ 비주항 가우스 분기 8개 중 6개가 항등 소멸함($z_{\text{re}} \ge \frac{1}{6} \to \frac{1}{12}$)과 `(1 - V)` 약분으로 소수 노름 하한이 $Q \ge 480 \to 112$로 줄어듦을 증명합니다. | **정리 40개** (`22/22` 변이 포착)<br>[`qrh_exponent_and_parameter_bounds.lean`](./anatomy/001-openai-003-qrh/proofs/qrh_exponent_and_parameter_bounds.lean)<br>[`qrh_continuation_and_rescaling.lean`](./anatomy/001-openai-003-qrh/proofs/qrh_continuation_and_rescaling.lean)<br>[`verify_symbolic_qrh.py`](./anatomy/001-openai-003-qrh/proofs/verify_symbolic_qrh.py) | [**한국어 (`ko/`)**](./anatomy/001-openai-003-qrh/ko/README.md)<br>[**English (`en/`)**](./anatomy/001-openai-003-qrh/en/README.md) |
| **[`002`](./anatomy/002-openai-032-k3-hodge/README.ko.md)** | **OpenAI `#032`: K3 유리 호지 추측 철회본 3편 및 `[EEMS13]` 포렌식**<br>`openai/math` 커밋 `adc7f12`<br>(`3,064`개 `.lean` 파일 + 프리프린트 `9`편) | • **심플렉틱 양방향 모순 규명**: 역방향 대각합 $G_2$($I_{\mathrm{new}} = -2m \neq 0$)와 정방향 대각합 $G_1$(차수 $(2,2k-2)$ 곡률 소멸 파괴)이 동시에 성립할 수 없는 이유를 규명합니다.<br>• **인용 원문(`[EEMS13]`) 부호 누락 적발**: `min-intersectYETI-final.tex:410, 694`에서 홀수 차원 공 $D^{2k-1}$의 푸앵카레-호프 경계 부호 $(-1)^{\dim U} = -1$이 누락된 원인을 찾아냅니다.<br>• **1부 조건부 환원 구출 및 2부 한계 입증**: `Part I`의 `4-7-10` 외적 차수 분리 엔진이 유효함을 검증하고, `Part II`의 7가지 대수적 우회 경로가 막히는 차원 장벽을 증명합니다. | **정리 27개** (`112/112` 변이 포착)<br>[`k3_forensic_paths.lean`](./anatomy/002-openai-032-k3-hodge/proofs/k3_forensic_paths.lean)<br>[`verify_symbolic_k3.py`](./anatomy/002-openai-032-k3-hodge/proofs/verify_symbolic_k3.py) | [**한국어 (`ko/`)**](./anatomy/002-openai-032-k3-hodge/ko/README.md)<br>[**English (`en/`)**](./anatomy/002-openai-032-k3-hodge/en/README.md) |
| **[`003`](./anatomy/003-openai-001-milne-rationality/README.ko.md)** | **OpenAI `#001`: 아벨 다양체에 대한 밀른의 유리성 추측**<br>10월 7일 자 프리프린트<br>(`.tex` 원고 `6`개 파일) | • **철회 논문(`#032`)과의 독립성 확인**: 철회된 `[OAI26]`(`#032`) 인용이 서론 배경 설명에만 등장하며 내부 증명 사슬(`§2~§6`)에는 전혀 쓰이지 않음을 확인합니다.<br>• **점별 `KZ25` 적분 리프트 수리**: `Proposition 4.8`의 미출판 `GLX26` 가족 가정을 점별 Kisin-Zhou(`KZ25`) 적분 리프트와 평행이동으로 대체합니다.<br>• **정규 보빌 사영자 도입**: 6절의 비유일 리프트 선택을 가중치-0 보빌 사영자 $P_{r,0}$로 정규화하고 분기 DVR·크로네커·로사티 양정치성 경계를 보강합니다. | **정리 33개** (`211/211` 변이 포착)<br>[`milne_transport_and_filtration.lean`](./anatomy/003-openai-001-milne-rationality/proofs/milne_transport_and_filtration.lean)<br>[`milne_weil_reduction_and_repairs.lean`](./anatomy/003-openai-001-milne-rationality/proofs/milne_weil_reduction_and_repairs.lean)<br>[`verify_symbolic_milne.py`](./anatomy/003-openai-001-milne-rationality/proofs/verify_symbolic_milne.py) | [**한국어 (`ko/`)**](./anatomy/003-openai-001-milne-rationality/ko/01_초보자용_쉬운해설.md)<br>[**English (`en/`)**](./anatomy/003-openai-001-milne-rationality/en/01_Beginner_Guide.md) |
| **[`004`](./anatomy/004-openai-378-eth-disproof/README.ko.md)** | **OpenAI `#378`: 지수 시간 가설(`ETH`) 반증 감사 및 화석 고고학**<br>`OAI.Algorithms.SubexponentialSAT`<br>(`3,977`개 `.lean` 파일 `710,320`줄 + `.tex` `4`개) | • **4세대 폐기 화석 고고학**: 최종 정리에 연결된 `2,569`개 파일과 버려진 `1,408`개 파일(`35.4%`)을 분리하여 $2^{0.9n}$(`1세대`)부터 표수 3 갈루아 링 $\mathrm{GR}(3^t, d)$(`3~4세대`)까지의 진화 과정을 복원합니다.<br>• **5대 형식화 우회 기법 감사**: `languageScanner` 진리표 내장, `sparsifySchedule = 0`($n \le 2^{65,535}$) 절단, 단항 패딩, 공간 상한 폴백, 표수 3(`Lean`) 대 표수 0(`LaTeX`) 괴리를 규명합니다.<br>• **부록 D 형식화 및 화석 하이브리드 복원**: 부록 D의 $2$-진 에르미트 감쇠($1/32$)를 최초 형식화하고 폐기된 `2~3세대` 화석을 결합해 다항식 상한을 $171,835$배 압축합니다. | **정리 50개** (`408/408` 변이 포착)<br>[`eth_subexp_interpolation_and_hashes.lean`](./anatomy/004-openai-378-eth-disproof/proofs/eth_subexp_interpolation_and_hashes.lean)<br>[`eth_tensor_contraction_and_circuits.lean`](./anatomy/004-openai-378-eth-disproof/proofs/eth_tensor_contraction_and_circuits.lean)<br>[`eth_five_repairs_and_four_layer_verdict.lean`](./anatomy/004-openai-378-eth-disproof/proofs/eth_five_repairs_and_four_layer_verdict.lean)<br>[`verify_symbolic_eth.py`](./anatomy/004-openai-378-eth-disproof/proofs/verify_symbolic_eth.py) | [**한국어 (`ko/`)**](./anatomy/004-openai-378-eth-disproof/ko/01_초보자용_쉬운해설.md)<br>[**English (`en/`)**](./anatomy/004-openai-378-eth-disproof/en/01_Beginner_Guide.md) |
| **[`005`](./anatomy/005-openai-003-qrh-mathematician-referee-audit/README.ko.md)** | **OpenAI `#003`: 수론 심사위원 심층 감사 및 $\beta \to 1/2$ 전달 설계도**<br>`openai/math` family `003` 전체 DAG<br>(`3,233`개 `.lean` 파일 감사 + 참조 모듈 `26`개) | • **혼재된 3종 $\beta$ 지표 분리**: 전역 SOS 안장점($\frac{41999}{48000} < \frac{7}{8}$), 국소 $\delta=0$ 균형점($\frac{131}{150} \approx 0.8733$), 비예외 배경 바닥($\frac{4103}{4896} \approx 0.8380$)을 엄밀히 구분합니다.<br>• **$\beta = 2/3$ 수렴 장벽 돌파**: 슈티켈베르거-아이젠슈타인 소멸($k_\infty = -6 \neq 0$)을 이용해 `coordR` 극점 장벽을 $\beta = \frac{2}{3}$에서 $\frac{7}{12}$ 및 $\frac{1}{2}$로 낮춥니다.<br>• **임계선($\beta = 1/2$) 마스터 전달 법칙**: 그람 이득에 따른 선형 법칙 $\beta(\Delta_{\mathrm{gram}})$과 $\beta = \frac{1}{2}$ 도달에 필요한 하이브리드 임계치 $\Delta_{\mathrm{hybrid}} = \frac{14}{33}$를 역산합니다. | **정리 48개 + `def` 3개** (`441/441` 변이 포착)<br>[`qrh_mathematician_referee_audit.lean`](./anatomy/005-openai-003-qrh-mathematician-referee-audit/proofs/qrh_mathematician_referee_audit.lean)<br>[`qrh_eight_tasks_critical_upgrade.lean`](./anatomy/005-openai-003-qrh-mathematician-referee-audit/proofs/qrh_eight_tasks_critical_upgrade.lean)<br>[`verify_qrh_mathematician_audit.py`](./anatomy/005-openai-003-qrh-mathematician-referee-audit/proofs/verify_qrh_mathematician_audit.py) | [**한국어 (`ko/`)**](./anatomy/005-openai-003-qrh-mathematician-referee-audit/ko/README.md)<br>[**English (`en/`)**](./anatomy/005-openai-003-qrh-mathematician-referee-audit/en/README.md) |
| **[`006`](./anatomy/006-openai-376-navier-stokes/README.ko.md)** | **OpenAI `#376`: 강제 나비에-스토크스 유동의 보편 계산 검증**<br>`openai/math` family `376`<br>(`1,010`개 `.lean` 파일 `142,131`줄 + `.tex` `75`개) | • **핵심 PDE 구성 검증**: 아핀 컬 퍼텐셜 $U = \nabla\times(\chi\Psi)$(`BoxTransport/Flow.lean`), $L^2$ 에너지 유일성(`Comparison.lean`), 2+1D 수동 스칼라 수송(`MildScalar.lean`)을 검증합니다.<br>• **모델 가정 경계 분리**: 영압력($p=0$) 역산 외력 항등식 $f = f_0 + \nu f_1$(`BoxCoding.lean`) 및 단방향 전단 유동(`advection = 0`)과 자율 3D 유체 방정식의 차이를 구분합니다.<br>• **임포트 지층 분석**: 6개 챌린지 엔트리포인트가 `OAI/` `1,004`개 파일 중 `354`개만 임포트하고 `650`개 파일(`64.7%`, `ForcedComputation/` 전체 포함)을 임포트하지 않음을 확인합니다. | **정리 40개** (`163/163` 변이 포착)<br>[`ns376_kinematic_routing_and_forensics.lean`](./anatomy/006-openai-376-navier-stokes/proofs/ns376_kinematic_routing_and_forensics.lean)<br>[`ns376_gronwall_uniqueness_and_repairs.lean`](./anatomy/006-openai-376-navier-stokes/proofs/ns376_gronwall_uniqueness_and_repairs.lean)<br>[`verify_symbolic_ns376.py`](./anatomy/006-openai-376-navier-stokes/proofs/verify_symbolic_ns376.py) | [**한국어 (`ko/`)**](./anatomy/006-openai-376-navier-stokes/ko/01_초보자용_쉬운해설.md)<br>[**English (`en/`)**](./anatomy/006-openai-376-navier-stokes/en/01_Beginner_Guide.md) |
| **[`007`](./anatomy/007-openai-376-navier-stokes-complete-reassembly/README.ko.md)** | **OpenAI `#376`: 미연결 `650` 모듈 전수 재조립 및 10월 6일 개정판 검증**<br>`OAI/` `1,004`개 `.lean` 파일 + 10월 6일 자 개정 프리프린트 | • **미연결 `650`(`718`) 모듈 재조립**: `ForcedComputation/Main.lean`(`770`개), `Material/MaterialFlow.lean`(`19`개), `StationaryNS`(`3`개)를 전수 연결하고 `lean/docs/376.md`의 경로 오기를 바로잡습니다.<br>• **비영 압력($p \neq 0$) 및 그린 연산자 상한(`4,528만 배`) 정밀화**: `PeriodicLattice/Solenoidal.lean`의 무발산 외력($\operatorname{div} f_{\text{sol}} = 0$) 구성을 검증하고 차폐 그린 노름 상한을 $\approx 286,753$에서 $\frac{1}{16\pi^2} \approx 0.00633$으로 압축합니다.<br>• **르레이·검출기·칸토어 상한 개선**: 토러스 르레이 상수를 `52`에서 $16.5321$($3.15$배)로 줄이고, 검출기 작동 한계 $H_{\max}$를 $7,560$배($10^9 \to 7.56\times 10^{12}$) 확장합니다. | **정리 48개** (`134/134` 변이 포착)<br>[`ns376_unimported_solenoidal_and_leray_bounds.lean`](./anatomy/007-openai-376-navier-stokes-complete-reassembly/proofs/ns376_unimported_solenoidal_and_leray_bounds.lean)<br>[`ns376_detector_margins_and_undecidability_chains.lean`](./anatomy/007-openai-376-navier-stokes-complete-reassembly/proofs/ns376_detector_margins_and_undecidability_chains.lean)<br>[`verify_symbolic_ns376_complete.py`](./anatomy/007-openai-376-navier-stokes-complete-reassembly/proofs/verify_symbolic_ns376_complete.py) | [**한국어 (`ko/`)**](./anatomy/007-openai-376-navier-stokes-complete-reassembly/ko/01_고등학생_직관가이드.md)<br>[**English (`en/`)**](./anatomy/007-openai-376-navier-stokes-complete-reassembly/en/01_high_school_intuition_guide.md) |
| **[`008`](./anatomy/008-openai-003-qrh-11-12-and-cubic-sieve-synthesis/README.ko.md)** | **OpenAI `#003`: `23/24` 대 `11/12` 스케일링, 미연결 `CubicGauss` 및 $\mathbb{Q}(\sqrt{921})$ 통합**<br>`DirichletL/`, `CubicGauss/` (`30`개 파일), `paper2.tex`, `quasi-rh` & `arXiv:2610.12234` | • **`23/24` 고정 원인 및 `11/12` 확장 규명**: `reserve = 1/20`(`ClosedRecursion.lean:120`)이 $\vartheta = 1/10 \implies \frac{23}{24}$을 강제한 원인과 `CanonicalDescentScale` 및 $(\vartheta,\eta)=(\frac{6\varepsilon}{5},\frac{\varepsilon}{2})$를 통한 $\frac{11}{12}+\varepsilon$ 확장(`cauchy_const = 768`)을 증명합니다.<br>• **미연결 `CubicGauss`(`6,252`줄) 해부 및 뫼비우스 정확 해**: 미연결 30개 파일의 날카로운 $2/3$ 3차 큰 체를 발굴하고, 비선형 점화식 `sieveStep(α) = (6α-4)/(3α-1)`을 $u(\alpha)=\frac{\alpha-4/3}{\alpha-1}$($u_{n+1}=\frac{2}{3}u_n$, 잔여 오차 $1/3$로 축소)로 정확히 풉니다.<br>• **$\mathbb{Q}(\sqrt{921})$ 대수적 통합 및 파카스 10단계 계보**: `Case 005`($\frac{6843-7\sqrt{921}}{7578}$)와 Baiying Liu의 $B_{\mathrm{Liu}}=\frac{1507-2\sqrt{921}}{1653}$가 $288\delta_c^2-588\delta_c+185=0$을 공유함(차이 $\frac{1195\sqrt{921}-36189}{4175478}$)을 밝히고 $\frac{71}{108}$까지의 10단계 계보를 완성합니다. | **정리 30개** (`240/240` 변이 포착)<br>[`qrh_eleven_twelfths_and_cubic_large_sieve.lean`](./anatomy/008-openai-003-qrh-11-12-and-cubic-sieve-synthesis/proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean)<br>[`qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean`](./anatomy/008-openai-003-qrh-11-12-and-cubic-sieve-synthesis/proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean)<br>[`verify_symbolic_qrh_synthesis.py`](./anatomy/008-openai-003-qrh-11-12-and-cubic-sieve-synthesis/proofs/verify_symbolic_qrh_synthesis.py) | [**한국어 (`ko/`)**](./anatomy/008-openai-003-qrh-11-12-and-cubic-sieve-synthesis/ko/01_Beginner_Guide.md)<br>[**English (`en/`)**](./anatomy/008-openai-003-qrh-11-12-and-cubic-sieve-synthesis/en/01_Beginner_Guide.md) |

---

## 디렉터리 구조 (단일 `proofs/` 공유 및 한·영 분리)

각 사례(`anatomy/001-...`)는 **단 1벌의 `proofs/` 코드 폴더와 단일 [`manifest.json`](./anatomy/001-openai-003-qrh/manifest.json)**을 중심에 두고 영문(`en/`)과 한국어(`ko/`) 4단계 문서를 분리하여, 코드 중복과 한·영 해시 불일치를 원천 차단합니다:

```text
ultari-proof-anatomy/
├── LICENSE                    # Apache License 2.0
├── NOTICE                     # 결합 라이선스(Apache-2.0 / CC BY 4.0) 및 제3자 참조 코드 고지
├── README.md                  # 영문 마스터 목차
├── README.ko.md               # 한국어 마스터 목차
├── tools/
│   └── verify_all.py          # 전 사례(001~008, 316개 정리) 통합 1줄 자동 검증기
└── anatomy/
    ├── 001-openai-003-qrh/
    │   ├── README.md          # 사례별 영문 개요
    │   ├── README.ko.md       # 사례별 한국어 개요
    │   ├── manifest.json      # 단일 SHA-256 해시 및 정리 원장
    │   ├── proofs/            # 단 1벌로 공유되는 Lean 4 및 SymPy 검증 코드
    │   │   ├── *.lean         # 독립 실행형 0-sorry Lean 4 정리
    │   │   ├── verify_*.py    # 결정론적 SymPy / 수치 검증 스크립트
    │   │   ├── symbolic_verification_result.json
    │   │   ├── problem_spec.md
    │   │   └── oai_ref/       # 분석 대상 원본 참조 .lean / .tex 파일
    │   ├── en/                # 영문 4단계 가이드 (01_Beginner .. 04_Automated)
    │   └── ko/                # 한국어 4단계 가이드 (01_초보자용 .. 04_자동검증용)
    ├── 002-openai-032-k3-hodge/
    ├── 003-openai-001-milne-rationality/
    ├── 004-openai-378-eth-disproof/
    ├── 005-openai-003-qrh-mathematician-referee-audit/
    ├── 006-openai-376-navier-stokes/
    ├── 007-openai-376-navier-stokes-complete-reassembly/
    └── 008-openai-003-qrh-11-12-and-cubic-sieve-synthesis/
```

---

## 1줄 전체 저장소 검증 명령어

저장소 루트에서 [`tools/verify_all.py`](./tools/verify_all.py)를 실행하면 다음 5단계 검증이 한 번에 수행됩니다:
1. **Lean 4 커널 컴파일** (`0 sorry`, `0 axiom`, `exit 0`),
2. **기호 연산 재현 검증** (`SymPy` 실행 결과와 JSON 일치 확인),
3. **`manifest.json` SHA-256 해시 무결성 대조**,
4. **한·영 전체 문서(`en/`, `ko/`)의 정리 이름 및 `#L` 줄 번호 링크 1대1 대조**,
5. **전칭 가설 개별 제거 돌연변이 시험(`(h : True)` 치환 시 컴파일 차단 확인)**.

```bash
python3 tools/verify_all.py
```

---

## 라이선스 및 제3자 저작물 고지 (`LICENSE` / `NOTICE`)

- **자체 형식증명 코드 및 검증 스크립트** (`proofs/*.lean`(`oai_ref/` 제외), `proofs/verify_*.py`, `tools/*.py`, `manifest.json`): [**Apache License 2.0 (`Apache-2.0`)**](./LICENSE)을 따릅니다.
- **자체 수론·수학 심층 감사 보고서 및 4단계 가이드** (`*.md`): [**Apache-2.0**](./LICENSE) 및 [**크리에이티브 커먼즈 저작자표시 4.0 국제 라이선스 (`CC BY 4.0`)**](https://creativecommons.org/licenses/by/4.0/)가 함께 적용됩니다. 재배포·번역·인용 시 원저작자 및 저장소 출처 표기와 변경 여부 고지 의무는 [`NOTICE`](./NOTICE)를 따릅니다.
- **제3자 감사 대상 참조 스냅샷** (`anatomy/*/proofs/oai_ref/`): 줄 번호 대조 및 학술 감사 재현을 위해 수록된 원저작자(OpenAI)의 참조 코드이며 원저작자의 라이선스를 따릅니다([`NOTICE`](./NOTICE) 참조).
