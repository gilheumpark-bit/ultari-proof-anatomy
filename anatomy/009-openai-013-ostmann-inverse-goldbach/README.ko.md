> **언어 선택 (Language)**: [**English (`README.md`)**](./README.md) | **한국어**

# 사례 009: OpenAI `#013` 오스트만 역 골드바흐 추측 (`Erdős #431`) 해부 및 형식증명

이 패키지는 OpenAI `#013`(*소수 집합의 가법적 분해 불가능성*, `OAI/NumberTheory/Ostmann/`, `7,716`개 `.lean` 파일 `609,199`줄)을 해부한 결과물입니다. 모든 결론은 `45`개 독립 Lean 4 정리와 `2`개 `def`(`v4.29.0-rc8`, `0 sorry`, 가설 변이 `287/287`건 포착)로 검증했습니다.

## 핵심 해부 결과

1. **쌍둥이 엔진(`Twin-Engine`) `7,716`개 파일 중복 규명**: `Ostmann/` 폴더가 동일한 정리를 증명하는 두 개의 독립 증명 트리(`Complete.lean`: `3,165`개, `Main.lean`: `4,175`개, 공유 파일 `5`개 `372`줄)와 `381`개 화석 파일로 이루어져 있음을 밝힙니다(`3165 + 4175 - 5 + 381 = 7716`).
2. **5절 푸리에 공급 수축(`-11/125`) 및 $+53\%$ 정밀화**: 불균형 밀도 벌점 $\frac{(2\sigma_p-1)^2}{\sigma_p(1-\sigma_p)} \ge \frac{1}{2}$, 국소 수축률 $1 - \frac{8}{5}\cdot\frac{17}{25} = -\frac{11}{125} < 0$, `#003`(`QRH`) 임포트 `0`건의 완전 독립성, 무손실 $\kappa = \frac{33}{20}, \frac{17}{10}$ 복원에 따른 소수 질량 확장($0.15L \to 0.23L$)을 검증합니다.
3. **전 구간 귀납법 트리 예산 및 완전순열($t_1=0$) 돌파구**: $\sum_{j=0}^{k-1} j 2^j = (k-2)2^k+2$를 귀납법으로 증명해 순 모순율 $\frac{2}{5} - \frac{3}{4} = -\frac{7}{20} < 0$을 도출하고, 완전순열 슬롯 쌍($t_1 = 0$)으로 최소 트리 깊이 $k_{\min}$을 `7041 -> 1040`으로 단축합니다.

## 4단계 독자 맞춤형 가이드

| 단계 | 대상 독자 | 문서 파일 | 핵심 내용 |
| :---: | :--- | :--- | :--- |
| **1단계** | **초보자 (일반 독자)** | [`ko/01_Beginner_Guide.md`](ko/01_Beginner_Guide.md) | 오스트만 역 골드바흐 문제, 쌍둥이 엔진 중복 구조, 3단계 증명 원리 쉬운 해설. |
| **2단계** | **중급자 (이공계·개발자)** | [`ko/02_Intermediate_Guide.md`](ko/02_Intermediate_Guide.md) | 핵심 대수 방정식과 45개 Lean 4 정리 1대1 줄 번호 색인표. |
| **3단계** | **전문가 (수론·형식증명 연구자)** | [`ko/03_Advanced_Guide.md`](ko/03_Advanced_Guide.md) | 3세대 화석 트리, 5절 푸리에 공급 수축, 6절 이진 트리 전달 심층 보고서. |
| **4단계** | **자동 검증기 및 파서** | [`ko/04_Expert_Verification.md`](ko/04_Expert_Verification.md)<br>[`manifest.json`](manifest.json) | SHA-256 해시 원장, 가설 돌연변이 시험 결과 및 1줄 재현 명령어. |

## 형식증명 코드 및 1줄 검증 명령어

- [`ostmann_twin_engines_and_supply_contraction.lean`](proofs/ostmann_twin_engines_and_supply_contraction.lean#L1-L404): 정리 1~20 (`131/131` 변이 포착).
- [`ostmann_tree_transfers_and_permutation_contradiction.lean`](proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L1-L481): 정리 21~45 + `def` 2개 (`156/156` 변이 포착).
- [`verify_symbolic_ostmann.py`](proofs/verify_symbolic_ostmann.py) 및 [`symbolic_verification_result.json`](proofs/symbolic_verification_result.json).

```bash
lean proofs/ostmann_twin_engines_and_supply_contraction.lean && lean proofs/ostmann_tree_transfers_and_permutation_contradiction.lean && (cd proofs && python3 verify_symbolic_ostmann.py)
```
