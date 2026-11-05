# OpenAI `#001` (밀른 유리성 추측) 포렌식 해부 및 5대 수리·검증 패키지 (한국어판)

- **작성 기준일**: 2026-11-01
- **분석 및 수리 대상**: `openai/math` 패밀리 `#001` (`Milnes-rationality-conjecture-for-abelian-varieties-October-7-2026`)
- **핵심 검증 산출물**:
  - Lean 4 형식증명(총 33개 정리, `0 sorry`, `0 axiom`, 가설 변이 `211/211` 사살 = `101/101` + `110/110`):
    - [`proofs/milne_transport_and_filtration.lean`](./proofs/milne_transport_and_filtration.lean) (정리 1~16, 변이 `101/101` 사살)
    - [`proofs/milne_weil_reduction_and_repairs.lean`](./proofs/milne_weil_reduction_and_repairs.lean) (정리 17~33, 변이 `110/110` 사살)
  - 기호 및 PyTorch 텐서 검증 스크립트(`Audit 1~7` 전수 통과): [`proofs/verify_symbolic_milne.py`](./proofs/verify_symbolic_milne.py)
  - 기호 및 수치 검증 결과 데이터(JSON): [`proofs/symbolic_verification_result.json`](./proofs/symbolic_verification_result.json)
  - LaTeX 원문 6개 섹션 수리 통합 패치(`234`줄): [`proofs/oai_001_milne_repair.patch`](./proofs/oai_001_milne_repair.patch)

---

## 독자 수준별 맞춤 읽기 안내 (4단계 구성)

| 단계 | 대상 독자 | 문서 파일 | 핵심 내용 요약 |
| :---: | :--- | :--- | :--- |
| **1단계** | **초보자 (비전공자·일반 독자)** | [`01_초보자용_쉬운해설.md`](./ko/01_초보자용_쉬운해설.md) | 수식 없이 이해하는 밀른의 유리성 추측과 4단계 증명 다리, 포렌식 감사에서 적발한 5가지 약점(중 2, 하 3)과 수리 결과 |
| **2단계** | **중급자 (이공계 학부·개발자)** | [`02_중급자용_구조및수식가이드.md`](./ko/02_중급자용_구조및수식가이드.md) | 6개 LaTeX 섹션과 33개 Lean 4 정리(파일 2종) 및 7대 수치/기호 감사 모듈의 1대1 수식 매핑 해설 |
| **3단계** | **전문가 (산술기하·형식증명 연구자)** | [`03_전문가용_산술기하및형식증명보고서.md`](./ko/03_전문가용_산술기하및형식증명보고서.md) | `#032`(`[OAI26]`) 의존 경계 분석, `[중-1]` Kisin-Zhou 점별 ADLV 우회, `[중-2]` 보빌 사영자 $P_{r,0}$ 불변성, `[하-1]`~`[하-3]` 수리 증명 |
| **4단계** | **AI 및 자동 검증 파이프라인** | [`04_자동검증및파서용_명세서.md`](./ko/04_자동검증및파서용_명세서.md)<br>[`manifest.json`](./manifest.json) | 1줄 재현 명령어(`lean`, `python3`, `sha256sum`), SHA-256 해시 목록, 33개 정리 줄 번호 및 JSON 매니페스트 |

---

## 1줄 즉시 검증 방법

```bash
lean ./proofs/milne_transport_and_filtration.lean && lean ./proofs/milne_weil_reduction_and_repairs.lean && (cd ./proofs && python3 verify_symbolic_milne.py)
```
