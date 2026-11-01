> **언어 선택 (Language)**: [**English (`README.md`)**](./README.md) | **한국어**

# OpenAI `#003` (준리만 가설 Lean 4 형식증명) 수식 구조 분석 및 검증 패키지 (한국어판)

- **작성 기준일**: 2026-10-31
- **분석 대상**: `openai/frontiermath-open-problems` (`FirstProof2026Problem3` / 디리클레·헤케 $L$-함수 준리만 가설 Lean 4 증명 저장소)
- **핵심 검증 산출물**:
  - Lean 4 형식증명(40개 정리, 404+295행, `0 sorry`, `0 axiom`): [`proofs/qrh_exponent_and_parameter_bounds.lean`](./proofs/qrh_exponent_and_parameter_bounds.lean), [`proofs/qrh_continuation_and_rescaling.lean`](./proofs/qrh_continuation_and_rescaling.lean)
  - 기호 연산 검산 스크립트(`SymPy` / 유리수 정밀 연산): [`proofs/verify_symbolic_qrh.py`](./proofs/verify_symbolic_qrh.py)
  - 기호 연산 검산 결과 데이터(JSON): [`proofs/symbolic_verification_result.json`](./proofs/symbolic_verification_result.json)

---

## 독자 수준별 맞춤 읽기 안내 (4단계 구성)

본 패키지는 **초보자(비전공자)**, **중급자(이공계·개발자)**, **전문가(해석적 수론·형식증명 연구자)**, **AI 및 자동 검증 시스템** 모두가 자신의 수준과 목적에 맞게 이해하고 검증할 수 있도록 4단계로 구성되어 있습니다.

| 단계 | 대상 독자 | 문서 파일 | 핵심 내용 요약 |
| :---: | :--- | :--- | :--- |
| **1단계** | **초보자 (비전공자·일반 독자)** | [`01_초보자용_쉬운해설.md`](./ko/01_초보자용_쉬운해설.md) | 복잡한 수식 없이 이해하는 리만 가설과 준리만 가설, OpenAI `#003` 증명 코드의 유리수 근사 방식과 주요 경계값(`0.51 / 0.69 / 0.875`)의 수학적 의미 |
| **2단계** | **중급자 (이공계 학부·개발자)** | [`02_중급자용_구조및수식가이드.md`](./ko/02_중급자용_구조및수식가이드.md) | 5대 핵심 수식 과제의 방정식과 코드 구조 해설, OpenAI 원본 `.lean` 파일과 40개 Lean 4 정리 일대일 매핑 |
| **3단계** | **전문가 (수론·형식증명 연구자)** | [`03_전문가용_수론및형식증명보고서.md`](./ko/03_전문가용_수론및형식증명보고서.md) | 학술 기술 보고서, 유리수·정수 형식 증명 완료 범위와 향후 복소해석적 멜린 적분 형식화 과제의 구분 명세 |
| **4단계** | **AI 및 자동 검증 파이프라인** | [`04_자동검증및파서용_명세서.md`](./ko/04_자동검증및파서용_명세서.md)<br>[`manifest.json`](./manifest.json) | 1줄 재현 명령어(`lean`, `python3`, `sha256sum`), SHA-256 해시 목록, 해석상 유의사항 및 JSON 매니페스트 |

---

## 1줄 즉시 검증 방법

패키지 루트 폴더에서 아래 명령어를 실행하면 40개 Lean 4 정리의 커널 컴파일(`exit 0`)과 기호 연산 결과를 즉시 재현할 수 있습니다.

```bash
lean proofs/qrh_exponent_and_parameter_bounds.lean && lean proofs/qrh_continuation_and_rescaling.lean && (cd proofs && python3 verify_symbolic_qrh.py)
```
