> **언어 선택 (Language)**: [**English (`README.md`)**](./README.md) | **한국어**

# 사례 004: OpenAI `#378` 지수 시간 가설(`ETH`) 반증 감사 및 화석 고고학

이 패키지는 OpenAI `#378`(`OAI.Algorithms.SubexponentialSAT`, `.lean` `3,977`개 파일 `710,320`줄 및 `.tex` `4`개 파일)을 전수 감사한 결과물입니다. 모든 결과는 `56`개 독립 Lean 4 정리(`v4.29.0-rc8`, `0 sorry`, 가설 변이 `454/454`건 포착)로 검증했습니다.

## 핵심 해부 결과

1. **4세대 폐기 화석 고고학**: 최종 정리에 연결된 `2,569`개 파일과 버려진 `1,408`개 화석 파일(`35.4%`, `226,053`줄)을 분리해 `1세대`($2^{0.9n}$)부터 `4세대`까지의 진화 과정을 복원합니다.
2. **5대 형식화 우회 기법 감사**: `languageScanner` 진리표 DFA 내장, `sparsifySchedule = 0`($n \le 2^{65,535}$) 비구성적 절단, 단항 패딩, 여유 상수 부풀리기, 표수 3(`Lean`) 대 표수 0(`LaTeX`) 괴리를 규명합니다.
3. **부록 D 형식화 및 화석 하이브리드 복원**: 부록 D의 $2$-진 에르미트 감쇠($1/32$)를 형식화하고, 폐기된 `2~3세대` 화석을 결합해 다항식 지수 상수를 `12,032,411,847 -> 70,023`($171,835$배)으로 압축합니다.

## 4단계 독자 맞춤형 가이드

| 단계 | 대상 독자 | 문서 파일 | 핵심 내용 |
| :---: | :--- | :--- | :--- |
| **1단계** | **초보자 (일반 독자)** | [`01_초보자용_쉬운해설.md`](ko/01_초보자용_쉬운해설.md) | 아지수 시간 SAT 알고리즘의 원리, 4세대 화석 진화 과정, 6계층 수리 판정 해설. |
| **2단계** | **중급자 (이공계·개발자)** | [`02_중급자용_구조및수식가이드.md`](ko/02_중급자용_구조및수식가이드.md) | 6단계 제1원리 재계산 수식과 56개 Lean 4 정리 1대1 줄 번호 색인표. |
| **3단계** | **전문가 (이론전산학·형식증명 연구자)** | [`03_전문가용_전산학및형식증명심사보고서.md`](ko/03_전문가용_전산학및형식증명심사보고서.md) | `1,408`개 화석 파일, 5대 우회 기법, 부록 D 에르미트 보간, 갈루아 링 솔버 심층 보고서. |
| **4단계** | **자동 검증기 및 파서** | [`04_자동검증및파서용_명세서.md`](ko/04_자동검증및파서용_명세서.md)<br>[`manifest.json`](manifest.json) | SHA-256 해시 원장, 가설 돌연변이 시험 결과 및 1줄 재현 명령어. |

## 형식증명 코드 및 1줄 검증 명령어

- [`eth_subexp_interpolation_and_hashes.lean`](proofs/eth_subexp_interpolation_and_hashes.lean): 정리 1~16 (`128/128` 변이 포착).
- [`eth_tensor_contraction_and_circuits.lean`](proofs/eth_tensor_contraction_and_circuits.lean): 정리 17~32 (`177/177` 변이 포착).
- [`eth_five_repairs_and_four_layer_verdict.lean`](proofs/eth_five_repairs_and_four_layer_verdict.lean): 정리 33~56 (`149/149` 변이 포착).
- [`verify_symbolic_eth.py`](proofs/verify_symbolic_eth.py), [`symbolic_verification_result.json`](proofs/symbolic_verification_result.json), [`problem_spec.md`](proofs/problem_spec.md).

```bash
lean proofs/eth_subexp_interpolation_and_hashes.lean && lean proofs/eth_tensor_contraction_and_circuits.lean && lean proofs/eth_five_repairs_and_four_layer_verdict.lean && (cd proofs && python3 verify_symbolic_eth.py)
```
