# `ultari-proof-anatomy`: 인간 및 AI 수학·과학 증명 해부 아카이브

> **언어 선택 (Language)**: [**English (`README.md`)**](./README.md) | **한국어**

[![Lean 4](https://img.shields.io/badge/Lean_4-v4.29.0--rc8_Verified-blue)](#1줄-전체-저장소-검증-명령어)
[![Theorems & Mutants](https://img.shields.io/badge/Verified_Archive-386_Theorems_%7C_2%2C205%2F2%2C205_Mutants_Killed-purple)](#논문-및-형식증명-해부-아카이브-목록)
[![Symbolic Solver](https://img.shields.io/badge/SymPy-Exact_Rational_%26_Radical-success)](#1줄-전체-저장소-검증-명령어)
[![Zero Sorry](https://img.shields.io/badge/Proof_Integrity-0_sorry_%7C_0_axiom-brightgreen)](#1줄-전체-저장소-검증-명령어)
[![License](https://img.shields.io/badge/License-Apache_2.0_%7C_CC_BY_4.0-orange.svg)](./LICENSE)

**'울타리(`Ultari`)'**는 검증된 사실과 미증명 추측을 가르는 **엄밀한 경계(Protective Boundary)**를 뜻합니다.

**`ultari-proof-anatomy`**는 인간 학자나 프론티어 AI의 수학·과학 논문과 `Lean 4` 형식증명 코드를 분해하여 **정확한 대수 불변량**, **독립 실행 가능한 `Lean 4` 정리(`0 sorry`)**, **4단계 독자 맞춤형 가이드**로 제공하는 오픈 리서치 아카이브입니다.

> **아카이브 검증 규모 (`001`~`009`)**: **9개 심층 해부 사례** · **독립 Lean 4 정리 총 `386`개** (`0 sorry`, `0 axiom`) · **전칭 가설 돌연변이 사살 `2,205 / 2,205`건 (`100%`)** · **원본 대조 `.lean` 파일 `22,247`개**.

---

## 설립 목적: 무엇을 하는 곳인가

1. **하드코딩된 상수(매직 넘버)와 숨은 여유분 역산**:
   - 대규모 형식증명 코드는 증명 전술(`gcongr`, `linarith`)을 빠르게 통과시키려고 무리수 해를 근사 유리수로 바꾸거나 상한을 넉넉히 잡습니다.
   - 본 아카이브는 코드를 줄 단위로 역추적해 원래 방정식과 부등식 내부의 여유분(Slack)을 정확히 계산합니다.
2. **'실제로 증명된 범위'와 '미해결 영역' 사이의 울타리(`Ultari`)**:
   - 모든 주장은 1줄 명령어로 재현되는 **`Lean 4` 커널 증명(`0 sorry`, `0 axiom`)**과 **`SymPy` 스크립트**로 검증합니다.
   - 각 사례마다 코드가 실제로 증명한 범위와 단순화된 모델 가정·미해결 영역을 명확히 구분해 적습니다.
3. **독자 눈높이에 맞춘 4단계 가이드 (`ko/` · `en/`)**:
   - 모든 해부 사례는 한국어와 영어로 각각 4단계 문서를 제공합니다:
     - **1단계 (`01_초보자용`)**: 복잡한 수식 없이 핵심 질문과 결론을 설명하는 쉬운 해설.
     - **2단계 (`02_중급자용`)**: 핵심 방정식과 전체 Lean 4 정리 1대1 줄 번호 색인표.
     - **3단계 (`03_전문가용`)**: 상세 수식 유도, 교차 검증표 및 증명 범위 한계 명세서.
     - **4단계 (`04_자동검증용` & `manifest.json`)**: 1줄 검증 명령어 및 SHA-256 해시 원장.

---

## 논문 및 형식증명 해부 아카이브 목록

**번호(`001`~`009`)**를 누르면 각 사례 요약 페이지로 이동하며, 오른쪽 끝 열에서 **1단계 초보자용 쉬운 해설**을 바로 볼 수 있습니다.

| 번호 | 분석 대상 논문 및 원본 규모 | 한눈에 보는 핵심 해부 결과 (3줄 요약) | 검증 산출물 (`0 sorry`) | 4단계 가이드 (`ko` / `en`) |
| :---: | :--- | :--- | :--- | :---: |
| **[`001`](./anatomy/001-openai-003-qrh/README.ko.md)** | **OpenAI `#003`: 준리만 가설 ($\text{Re}(s) > 7/8$)**<br>Family `003` (`3,414`개 `.lean` 파일) | • **정류점 복원**: 유리수 근사점($\frac{283}{408}$) 뒤의 정확한 무리수 해 $a^* \approx 0.6933$과 바닥 영점 $a_{\max} = \frac{37}{72}$를 도출합니다.<br>• **그람 지수 여유분**: 3개 행렬 에너지를 단일 상한으로 묶을 때 버려진 지수 차이($\frac{215}{3264}$, $\frac{487}{3264}$)를 분리합니다.<br>• **꼬리항 소멸**: $m \ge 2$ 비주항 가우스 분기 6/8 소멸과 `(1 - V)` 약분에 따른 임계치 축소($Q \ge 480 \to 112$)를 증명합니다. | **정리 40개** (`22/22` 변이 포착)<br>[`qrh_exponent_and_parameter_bounds.lean`](./anatomy/001-openai-003-qrh/proofs/qrh_exponent_and_parameter_bounds.lean)<br>[`qrh_continuation_and_rescaling.lean`](./anatomy/001-openai-003-qrh/proofs/qrh_continuation_and_rescaling.lean)<br>[`verify_symbolic_qrh.py`](./anatomy/001-openai-003-qrh/proofs/verify_symbolic_qrh.py) | [**한국어 (`ko/`)**](./anatomy/001-openai-003-qrh/ko/README.md)<br>[**English (`en/`)**](./anatomy/001-openai-003-qrh/en/README.md) |
| **[`002`](./anatomy/002-openai-032-k3-hodge/README.ko.md)** | **OpenAI `#032`: K3 호지 추측 철회본 포렌식**<br>커밋 `adc7f12` (`3,064`개 `.lean` + 원고 `9`편) | • **심플렉틱 양면 모순**: 역방향 대각합 $G_2$($-2m \neq 0$)와 정방향 대각합 $G_1$(차수 2 곡률 폭발)이 동시에 막히는 이유를 밝힙니다.<br>• **인용 원문 부호 누락**: `[EEMS13]`(`min-intersectYETI-final.tex:410, 694`)의 홀수 차원 경계 부호 $(-1)^{\dim U} = -1$ 누락을 적발합니다.<br>• **1부 환원 구출**: `Part I` 조건부 환원 엔진의 무결성을 검증하고, `Part II` 7개 우회 경로의 차원 장벽을 증명합니다. | **정리 27개** (`112/112` 변이 포착)<br>[`k3_forensic_paths.lean`](./anatomy/002-openai-032-k3-hodge/proofs/k3_forensic_paths.lean)<br>[`verify_symbolic_k3.py`](./anatomy/002-openai-032-k3-hodge/proofs/verify_symbolic_k3.py) | [**한국어 (`ko/`)**](./anatomy/002-openai-032-k3-hodge/ko/README.md)<br>[**English (`en/`)**](./anatomy/002-openai-032-k3-hodge/en/README.md) |
| **[`003`](./anatomy/003-openai-001-milne-rationality/README.ko.md)** | **OpenAI `#001`: 밀른의 유리성 추측**<br>10월 7일 프리프린트 (`.tex` `6`개 파일) | • **철회본 독립성**: 철회된 `[OAI26]`(`#032`) 인용이 서론에만 쓰이고 내부 증명 사슬(`§2~§6`)과 무관함을 확인합니다.<br>• **점별 `KZ25` 리프트**: `Proposition 4.8`의 미출판 `GLX26` 가정을 점별 Kisin-Zhou 적분 리프트로 대체해 수리합니다.<br>• **정규 보빌 사영자**: 6절의 비유일 리프트를 가중치-0 보빌 사영자 $P_{r,0}$로 정규화하고 3건의 경계를 보강합니다. | **정리 33개** (`211/211` 변이 포착)<br>[`milne_transport_and_filtration.lean`](./anatomy/003-openai-001-milne-rationality/proofs/milne_transport_and_filtration.lean)<br>[`milne_weil_reduction_and_repairs.lean`](./anatomy/003-openai-001-milne-rationality/proofs/milne_weil_reduction_and_repairs.lean)<br>[`verify_symbolic_milne.py`](./anatomy/003-openai-001-milne-rationality/proofs/verify_symbolic_milne.py) | [**한국어 (`ko/`)**](./anatomy/003-openai-001-milne-rationality/ko/01_초보자용_쉬운해설.md)<br>[**English (`en/`)**](./anatomy/003-openai-001-milne-rationality/en/01_Beginner_Guide.md) |
| **[`004`](./anatomy/004-openai-378-eth-disproof/README.ko.md)** | **OpenAI `#378`: 지수 시간 가설(`ETH`) 반증**<br>`SubexponentialSAT` (`3,977`개 `.lean`, `710,320`줄) | • **4세대 화석 고고학**: 활성 `2,569`개 파일과 폐기된 `1,408`개 화석 파일(`35.4%`)을 분리해 4세대 진화 과정을 복원합니다.<br>• **5대 우회 기법 감사**: 진리표 DFA 내장, `sparsifySchedule = 0`($n \le 2^{65,535}$) 절단, 단항 패딩, 표수 3/0 괴리를 규명합니다.<br>• **부록 D 및 화석 결합**: 부록 D의 $1/32$ 감쇠를 형식화하고 `2~3세대` 화석을 결합해 다항식 상한을 $171,835$배 압축합니다. | **정리 50개** (`408/408` 변이 포착)<br>[`eth_subexp_interpolation_and_hashes.lean`](./anatomy/004-openai-378-eth-disproof/proofs/eth_subexp_interpolation_and_hashes.lean)<br>[`eth_tensor_contraction_and_circuits.lean`](./anatomy/004-openai-378-eth-disproof/proofs/eth_tensor_contraction_and_circuits.lean)<br>[`eth_five_repairs_and_four_layer_verdict.lean`](./anatomy/004-openai-378-eth-disproof/proofs/eth_five_repairs_and_four_layer_verdict.lean)<br>[`verify_symbolic_eth.py`](./anatomy/004-openai-378-eth-disproof/proofs/verify_symbolic_eth.py) | [**한국어 (`ko/`)**](./anatomy/004-openai-378-eth-disproof/ko/01_초보자용_쉬운해설.md)<br>[**English (`en/`)**](./anatomy/004-openai-378-eth-disproof/en/01_Beginner_Guide.md) |
| **[`005`](./anatomy/005-openai-003-qrh-mathematician-referee-audit/README.ko.md)** | **OpenAI `#003`: 심층 심사 및 $\beta \to 1/2$ 설계도**<br>Family `003` (`3,233`개 `.lean` + 참조 모듈 `26`개) | • **3종 $\beta$ 지표 분리**: 전역 SOS 안장점($\frac{41999}{48000}$), 국소 $\delta=0$ 균형점($\frac{131}{150}$), 비예외 꼬리 바닥($\frac{4103}{4896}$)을 구분합니다.<br>• **$\beta = 2/3$ 장벽 돌파**: 슈티켈베르거 소멸($k_\infty = -6 \neq 0$)로 `coordR` 극점 장벽을 $\frac{2}{3} \to \frac{7}{12} \to \frac{1}{2}$로 낮춥니다.<br>• **임계선 전달 법칙**: 선형 전달 법칙 $\beta(\Delta_{\mathrm{gram}})$과 $\beta = \frac{1}{2}$ 도달에 필요한 조건부 임계치 $\Delta_{\mathrm{hybrid}} = \frac{14}{33}$를 역산합니다. | **정리 48개 + `def` 3개** (`441/441` 변이 포착)<br>[`qrh_mathematician_referee_audit.lean`](./anatomy/005-openai-003-qrh-mathematician-referee-audit/proofs/qrh_mathematician_referee_audit.lean)<br>[`qrh_eight_tasks_critical_upgrade.lean`](./anatomy/005-openai-003-qrh-mathematician-referee-audit/proofs/qrh_eight_tasks_critical_upgrade.lean)<br>[`verify_qrh_mathematician_audit.py`](./anatomy/005-openai-003-qrh-mathematician-referee-audit/proofs/verify_qrh_mathematician_audit.py) | [**한국어 (`ko/`)**](./anatomy/005-openai-003-qrh-mathematician-referee-audit/ko/README.md)<br>[**English (`en/`)**](./anatomy/005-openai-003-qrh-mathematician-referee-audit/en/README.md) |
| **[`006`](./anatomy/006-openai-376-navier-stokes/README.ko.md)** | **OpenAI `#376`: 강제 나비에-스토크스 보편 계산**<br>Family `376` (`1,010`개 `.lean` + `.tex` `75`개) | • **핵심 PDE 검증**: 아핀 컬 퍼텐셜 $U = \nabla\times(\chi\Psi)$, $L^2$ 에너지 유일성, 2+1D 수동 스칼라 검출기를 검증합니다.<br>• **모델 가정 경계**: 영압력($p=0$) 역산 외력 $f = f_0 + \nu f_1$ 및 전단 유동(`advection = 0`)과 자율 3D 유동의 차이를 분리합니다.<br>• **임포트 지층 분석**: 6개 챌린지가 `1,004`개 중 `354`개만 임포트하고 `650`개(`64.7%`)를 미연결 상태로 남겼음을 확인합니다. | **정리 40개** (`163/163` 변이 포착)<br>[`ns376_kinematic_routing_and_forensics.lean`](./anatomy/006-openai-376-navier-stokes/proofs/ns376_kinematic_routing_and_forensics.lean)<br>[`ns376_gronwall_uniqueness_and_repairs.lean`](./anatomy/006-openai-376-navier-stokes/proofs/ns376_gronwall_uniqueness_and_repairs.lean)<br>[`verify_symbolic_ns376.py`](./anatomy/006-openai-376-navier-stokes/proofs/verify_symbolic_ns376.py) | [**한국어 (`ko/`)**](./anatomy/006-openai-376-navier-stokes/ko/01_초보자용_쉬운해설.md)<br>[**English (`en/`)**](./anatomy/006-openai-376-navier-stokes/en/01_Beginner_Guide.md) |
| **[`007`](./anatomy/007-openai-376-navier-stokes-complete-reassembly/README.ko.md)** | **OpenAI `#376`: 미연결 `650` 모듈 전수 재조립**<br>`OAI/` `1,004`개 `.lean` + 10월 6일 개정판 | • **전수 재조립**: 미연결 `650`(`718`) 모듈을 `ForcedComputation/Main.lean`(`770`개)과 `MaterialFlow.lean`으로 전수 연결합니다.<br>• **비영 압력 및 그린 상한**: 무발산 외력($p = -\phi \neq 0$)을 검증하고 차폐 그린 노름 상한을 $4,528$만 배($\frac{1}{16\pi^2}$) 압축합니다.<br>• **상한 정밀화**: 토러스 르레이 상수(`52 -> 16.53`), 검출기 한계 $H_{\max}$($7,560$배), 짝수 진법 칸토어 간격($b$배)을 개선합니다. | **정리 48개** (`136/136` 변이 포착)<br>[`ns376_unimported_solenoidal_and_leray_bounds.lean`](./anatomy/007-openai-376-navier-stokes-complete-reassembly/proofs/ns376_unimported_solenoidal_and_leray_bounds.lean)<br>[`ns376_detector_margins_and_undecidability_chains.lean`](./anatomy/007-openai-376-navier-stokes-complete-reassembly/proofs/ns376_detector_margins_and_undecidability_chains.lean)<br>[`verify_symbolic_ns376_complete.py`](./anatomy/007-openai-376-navier-stokes-complete-reassembly/proofs/verify_symbolic_ns376_complete.py) | [**한국어 (`ko/`)**](./anatomy/007-openai-376-navier-stokes-complete-reassembly/ko/01_고등학생_직관가이드.md)<br>[**English (`en/`)**](./anatomy/007-openai-376-navier-stokes-complete-reassembly/en/01_high_school_intuition_guide.md) |
| **[`008`](./anatomy/008-openai-003-qrh-11-12-and-cubic-sieve-synthesis/README.ko.md)** | **OpenAI `#003`: `23/24` 대 `11/12` 및 3부작 통합**<br>`DirichletL/`, `CubicGauss/` (`30`개) & `arXiv:2610.12234` | • **`23/24` 대 `11/12`**: `reserve = 1/20` 고정이 $\frac{23}{24}$을 강제한 원인과 `CanonicalDescentScale`의 $\frac{11}{12}+\varepsilon$ 확장을 증명합니다.<br>• **미연결 `CubicGauss`**: 미연결 30개 파일의 $2/3$ 큰 체를 발굴하고 점화식 일반항 $\frac{4\cdot 3^n-2^{n+1}}{3\cdot 3^n-2^{n+1}}$을 귀납법으로 증명합니다.<br>• **3부작 통합**: $\mathbb{Z}[\sqrt{921}]$ 링 위에서 `Case 001`·`005`·`008`을 결합해 $\beta = \frac{71}{108} \approx 0.6574$까지 사슬을 연결합니다. | **정리 45개 + `def` 7개** (`344/344` 변이 포착)<br>[`qrh_eleven_twelfths_and_cubic_large_sieve.lean`](./anatomy/008-openai-003-qrh-11-12-and-cubic-sieve-synthesis/proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean)<br>[`qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean`](./anatomy/008-openai-003-qrh-11-12-and-cubic-sieve-synthesis/proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean)<br>[`qrh_trilogy_induction_and_algebraic_bridge.lean`](./anatomy/008-openai-003-qrh-11-12-and-cubic-sieve-synthesis/proofs/qrh_trilogy_induction_and_algebraic_bridge.lean)<br>[`verify_symbolic_qrh_synthesis.py`](./anatomy/008-openai-003-qrh-11-12-and-cubic-sieve-synthesis/proofs/verify_symbolic_qrh_synthesis.py) | [**한국어 (`ko/`)**](./anatomy/008-openai-003-qrh-11-12-and-cubic-sieve-synthesis/ko/01_Beginner_Guide.md)<br>[**English (`en/`)**](./anatomy/008-openai-003-qrh-11-12-and-cubic-sieve-synthesis/en/01_Beginner_Guide.md) |
| **[`009`](./anatomy/009-openai-013-ostmann-inverse-goldbach/README.ko.md)** | **OpenAI `#013`: 오스트만 역 골드바흐 (`Erdős #431`)**<br>`Ostmann/` (`7,716`개 `.lean`, `609,199`줄 + `.tex` `9`개) | • **쌍둥이 엔진 중복**: 동일 정리를 증명하는 두 독립 트리(`3,165`개 + `4,175`개, 공유 `5`개)와 `381`개 화석 파일을 규명합니다.<br>• **푸리에 공급 수축**: $-\frac{11}{125} < 0$ 수축률, `#003`(`QRH`) 무의존성, 무손실 $\kappa$ 복원에 따른 소수 질량 $+53\%$ 확장을 검증합니다.<br>• **트리 예산 및 유효 문턱값**: 전 구간 귀납법으로 $\frac{2}{5} - \frac{3}{4} = -\frac{7}{20} < 0$을 증명하고, 완전순열($t_1=0$)로 $k_{\min}: 7041 \to 1040$ 및 유효 문턱값 $L_{\mathrm{eff}}: 4,115,904 \to 640,722$를 도출합니다. | **정리 55개 + `def` 2개** (`370/370` 변이 포착)<br>[`ostmann_twin_engines_and_supply_contraction.lean`](./anatomy/009-openai-013-ostmann-inverse-goldbach/proofs/ostmann_twin_engines_and_supply_contraction.lean)<br>[`ostmann_tree_transfers_and_permutation_contradiction.lean`](./anatomy/009-openai-013-ostmann-inverse-goldbach/proofs/ostmann_tree_transfers_and_permutation_contradiction.lean)<br>[`verify_symbolic_ostmann.py`](./anatomy/009-openai-013-ostmann-inverse-goldbach/proofs/verify_symbolic_ostmann.py) | [**한국어 (`ko/`)**](./anatomy/009-openai-013-ostmann-inverse-goldbach/ko/01_Beginner_Guide.md)<br>[**English (`en/`)**](./anatomy/009-openai-013-ostmann-inverse-goldbach/en/01_Beginner_Guide.md) |

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
│   └── verify_all.py          # 전 사례(001~009, 376개 정리) 통합 1줄 자동 검증기
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
    ├── 008-openai-003-qrh-11-12-and-cubic-sieve-synthesis/
    └── 009-openai-013-ostmann-inverse-goldbach/
```

---

## 1줄 전체 저장소 검증 명령어

저장소 루트에서 [`tools/verify_all.py`](./tools/verify_all.py)를 실행하면 다음 5단계 검증을 한 번에 수행합니다.
1. **Lean 4 커널 컴파일**: 모든 `.lean` 파일이 `0 sorry`, `0 axiom`, `exit 0`으로 통과하는지 확인합니다.
2. **기호 연산 재현 검증**: `SymPy` 스크립트 실행 결과가 고정된 JSON과 정확히 일치하는지 확인합니다.
3. **SHA-256 해시 대조**: `manifest.json` 및 `04_*.md`의 해시표를 실제 파일과 대조합니다.
4. **정리 및 줄 번호 링크 대조**: 한·영 전체 문서(`en/`, `ko/`)의 정리 이름과 `#L` 줄 번호를 1대1로 대조합니다.
5. **전칭 가설 돌연변이 시험**: 모든 가설을 하나씩 `(h : True)`로 바꿨을 때 컴파일러가 100% 거부하는지 확인합니다.

```bash
python3 tools/verify_all.py
```

---

## 라이선스 및 제3자 저작물 고지 (`LICENSE` / `NOTICE`)

- **자체 형식증명 코드 및 검증 스크립트** (`proofs/*.lean`(`oai_ref/` 제외), `proofs/verify_*.py`, `tools/*.py`, `manifest.json`): [**Apache-2.0**](./LICENSE)을 따릅니다.
- **자체 감사 보고서 및 4단계 가이드** (`*.md`): [**Apache-2.0**](./LICENSE) 및 [**CC BY 4.0**](https://creativecommons.org/licenses/by/4.0/)이 함께 적용됩니다. 출처 표기 기준은 [`NOTICE`](./NOTICE)를 따릅니다.
- **제3자 감사 대상 참조 스냅샷** (`anatomy/*/proofs/oai_ref/`): 줄 번호 대조 및 재현 검증을 위해 수록된 참조 코드이며 원저작자의 라이선스를 따릅니다([`NOTICE`](./NOTICE) 참조).
