> **언어 선택 (Language)**: [**English (`README.md`)**](./README.md) | **한국어**

# 사례 001: OpenAI `#003` 준리만 가설 ($\text{Re}(s) > 7/8$) 해부 및 형식증명

이 패키지는 OpenAI `#003`(`DirichletL/` 및 `SiegelZeros/` `3,414`개 `.lean` 파일, 핵심 레퍼런스 `26/26`개 파일 및 `178/178`개 선언문 1:1 전수 대조 포함)을 감사한 결과물입니다. 유리수 근사 상수 뒤의 정확한 대수 방정식을 복원하고 `48`개 독립 Lean 4 정리(`v4.29.0-rc8`, `0 sorry`, 가설 변이 `28/28`건 포착)로 검증했습니다.

## 핵심 해부 결과

1. **정확한 무리수 정류점 복원**: `Endpoint.lean`의 유리수 근사점($\frac{283}{408}$) 뒤에 숨은 2차 방정식 해 $a^* = \frac{323}{276} - \frac{35\sqrt{16354}}{9384} \approx 0.6933$과 바닥 마진 영점 $a_{\max} = \frac{37}{72}$를 도출합니다.
2. **그람 행렬 지수 여유분 분리**: 성분별 지수($\frac{14+17\delta}{96}$, 차이 $\frac{215}{3264}$)와 쌍선형 지수($\frac{1}{16}+\frac{17\delta}{96}$, 차이 $\frac{487}{3264}$)를 묶음 상한($\frac{3}{16}+\frac{23\delta}{96}$)과 분리합니다.
3. **꼬리항 소멸 및 임계치 축소**: $m \ge 2$ 비주항 가우스 분기 8개 중 6개가 항등 소멸함($z_{\text{re}} \ge \frac{1}{6} \to \frac{1}{12}$)과 $(1 - V)$ 약분으로 소수 노름 하한이 $Q \ge 480 \to 112$로 줄어듦을 증명합니다.

## 4단계 독자 맞춤형 가이드

| 단계 | 대상 독자 | 문서 파일 | 핵심 내용 |
| :---: | :--- | :--- | :--- |
| **1단계** | **초보자 (일반 독자)** | [`01_초보자용_쉬운해설.md`](./ko/01_초보자용_쉬운해설.md) | 준리만 가설의 개념과 3대 임계치(`0.51`, `0.69`, `0.875`)의 쉬운 해설. |
| **2단계** | **중급자 (이공계·개발자)** | [`02_중급자용_구조및수식가이드.md`](./ko/02_중급자용_구조및수식가이드.md) | 핵심 대수 방정식 유도 및 48개 Lean 4 정리·26개 원본 파일 1대1 색인표. |
| **3단계** | **전문가 (수론·형식증명 연구자)** | [`03_전문가용_수론및형식증명보고서.md`](./ko/03_전문가용_수론및형식증명보고서.md) | 무리수 정류점, 그람 지수 여유분, `178/178`개 선언문 1:1 전수 대조 원장. |
| **4단계** | **자동 검증기 및 파서** | [`04_자동검증및파서용_명세서.md`](./ko/04_자동검증및파서용_명세서.md)<br>[`manifest.json`](./manifest.json) | 1줄 재현 명령어, SHA-256 해시 원장 및 JSON 매니페스트. |

## 형식증명 코드 및 1줄 검증 명령어

- [`proofs/qrh_exponent_and_parameter_bounds.lean`](./proofs/qrh_exponent_and_parameter_bounds.lean): 정리 1~27 (`0 sorry`).
- [`proofs/qrh_continuation_and_rescaling.lean`](./proofs/qrh_continuation_and_rescaling.lean): 정리 28~48 (`0 sorry`).
- [`proofs/verify_symbolic_qrh.py`](./proofs/verify_symbolic_qrh.py): [`proofs/symbolic_verification_result.json`](./proofs/symbolic_verification_result.json)을 재현하는 결정론적 `SymPy` 스크립트.

```bash
lean proofs/qrh_exponent_and_parameter_bounds.lean && lean proofs/qrh_continuation_and_rescaling.lean && (cd proofs && python3 verify_symbolic_qrh.py)
```
