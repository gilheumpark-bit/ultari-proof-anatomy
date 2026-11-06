> **언어 선택 (Language)**: [**English (`README.md`)**](./README.md) | **한국어**

# 사례 008: OpenAI `#003` `23/24` 대 `11/12`, 미연결 `CubicGauss` 및 3부작 통합

이 패키지는 OpenAI `#003` 생태계 전체(`DirichletL/ShortDraft`, `CubicGauss/`, `paper2.tex`, `AlexKontorovich/quasi-rh`, Baiying Liu `arXiv:2610.12234`, [`사례 001`](../001-openai-003-qrh/README.ko.md) 및 [`사례 005`](../005-openai-003-qrh-mathematician-referee-audit/README.ko.md))를 통합 검증한 결과물입니다. 모든 결론은 `45`개 독립 Lean 4 정리와 `7`개 `def`(`v4.29.0-rc8`, `0 sorry`, 가설 변이 `344/344`건 포착)로 증명했습니다.

## 핵심 해부 결과

1. **`23/24` 고정 원인 및 `11/12` 확장**: `DirichletL/CubicSieve/ClosedRecursion.lean`의 `reserve = 1/20` 상수가 $\vartheta = 1/10 \implies \frac{23}{24}$을 강제한 원인을 밝히고, `CanonicalDescentScale`을 통한 $\frac{11}{12}+\varepsilon$ 확장을 증명합니다.
2. **미연결 `CubicGauss` 발굴 및 귀납법 닫힌 해**: 미연결 30개 파일(`6,252`줄)의 날카로운 $2/3$ 삼차 큰 체를 감사하고, 모든 $n \in \mathbb{N}$에 대해 점화식 `sieveIter`의 일반항 $\frac{4\cdot 3^n - 2^{n+1}}{3\cdot 3^n - 2^{n+1}}$을 수학적 귀납법으로 증명합니다.
3. **$\mathbb{Z}[\sqrt{921}]$ 링 및 `001`·`005`·`008` 3부작 통합**: `Case 005`와 Liu의 $\mathbb{Q}(\sqrt{921})$ 이차방정식을 통합하고, 기존 `0 sorry` 모듈만으로 도달 가능한 $\beta = \frac{71}{108} \approx 0.6574$와 $\beta = \frac{1}{2}$ 도달에 필요한 열린 해석적 조건($\Delta_{\mathrm{hybrid}} = \frac{14}{33}$)의 경계를 확정합니다.

## 4단계 독자 맞춤형 가이드

| 단계 | 대상 독자 | 문서 파일 | 핵심 내용 |
| :---: | :--- | :--- | :--- |
| **1단계** | **초보자 (일반 독자)** | [`ko/01_Beginner_Guide.md`](ko/01_Beginner_Guide.md) | 5대 생태계 수수께끼와 10단계 비영점 경계 진화표의 쉬운 해설. |
| **2단계** | **중급자 (이공계·개발자)** | [`ko/02_Intermediate_Guide.md`](ko/02_Intermediate_Guide.md) | 핵심 대수 유도 과정과 45개 Lean 4 정리 1대1 줄 번호 색인표. |
| **3단계** | **전문가 (수론·형식증명 연구자)** | [`ko/03_Advanced_Guide.md`](ko/03_Advanced_Guide.md) | `CubicGauss` 큰 체, $\mathbb{Z}[\sqrt{921}]$, 파카스 쌍대 해체 및 3부작 통합 보고서. |
| **4단계** | **자동 검증기 및 파서** | [`ko/04_Expert_Verification.md`](ko/04_Expert_Verification.md)<br>[`manifest.json`](manifest.json) | SHA-256 해시 원장, 가설 돌연변이 시험 결과 및 1줄 재현 명령어. |

## 형식증명 코드 및 1줄 검증 명령어

- [`qrh_eleven_twelfths_and_cubic_large_sieve.lean`](proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L1-L305): 정리 1~15 (`115/115` 변이 포착).
- [`qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean`](proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L1-L313): 정리 16~30 (`125/125` 변이 포착).
- [`qrh_trilogy_induction_and_algebraic_bridge.lean`](proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L1-L356): 정리 31~45 + `def` 7개 (`104/104` 변이 포착).
- [`verify_symbolic_qrh_synthesis.py`](proofs/verify_symbolic_qrh_synthesis.py) 및 [`symbolic_verification_result.json`](proofs/symbolic_verification_result.json).

```bash
lean proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean && lean proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean && lean proofs/qrh_trilogy_induction_and_algebraic_bridge.lean && (cd proofs && python3 verify_symbolic_qrh_synthesis.py)
```
