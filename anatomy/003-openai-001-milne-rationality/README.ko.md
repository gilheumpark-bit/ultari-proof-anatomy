> **언어 선택 (Language)**: [**English (`README.md`)**](./README.md) | **한국어**

# 사례 003: OpenAI `#001` 밀른의 유리성 추측 포렌식 감사 및 5대 수리

이 패키지는 OpenAI `#001`(*아벨 다양체에 대한 밀른의 유리성 추측*)의 LaTeX 원고 6개 절을 전수 감사하고, 5건의 수리 패치를 `33`개 독립 Lean 4 정리(`v4.29.0-rc8`, `0 sorry`, 가설 변이 `232/232`건 포착)로 검증합니다.

## 핵심 해부 결과

1. **철회 논문(`#032`)과의 독립성 확인**: 철회된 `[OAI26]`(`#032`) 인용이 서론 배경 설명에만 등장하며 내부 증명 사슬(`§2~§6`)에는 전혀 쓰이지 않음을 확인합니다.
2. **점별 `KZ25` 적분 리프트 수리 (`[Medium-1]`)**: `Lemma 3.3` 및 `Proposition 4.8`의 미출판 `GLX26` 가족 가정을 점별 브뢰유-키신 및 키신-저우(`KZ25`) 적분 리프트로 대체합니다.
3. **정규 보빌 사영자 도입 (`[Medium-2]`)**: 6절의 비유일 대수적 사이클 리프트를 가중치-0 보빌 사영자 $P_{r,0}$로 정규화하고, 분기 DVR·크로네커·로사티 경계 3건을 보강합니다.

## 4단계 독자 맞춤형 가이드

| 단계 | 대상 독자 | 문서 파일 | 핵심 내용 |
| :---: | :--- | :--- | :--- |
| **1단계** | **초보자 (일반 독자)** | [`01_초보자용_쉬운해설.md`](./ko/01_초보자용_쉬운해설.md) | 밀른의 유리성 추측 개념, 4단계 증명 다리, 5건의 수리 내역 쉬운 해설. |
| **2단계** | **중급자 (이공계·개발자)** | [`02_중급자용_구조및수식가이드.md`](./ko/02_중급자용_구조및수식가이드.md) | 6개 절 수식 매핑과 36개 Lean 4 정리 1대1 줄 번호 색인표. |
| **3단계** | **전문가 (산술기하·형식증명 연구자)** | [`03_전문가용_산술기하및형식증명보고서.md`](./ko/03_전문가용_산술기하및형식증명보고서.md) | `#032` 독립성, 키신-저우 점별 리프트, 보빌 사영자 및 5대 수리 기술 보고서. |
| **4단계** | **자동 검증기 및 파서** | [`04_자동검증및파서용_명세서.md`](./ko/04_자동검증및파서용_명세서.md)<br>[`manifest.json`](./manifest.json) | 1줄 재현 명령어, SHA-256 해시 원장 및 36개 정리 매니페스트. |

## 형식증명 코드 및 1줄 검증 명령어

- [`proofs/milne_transport_and_filtration.lean`](./proofs/milne_transport_and_filtration.lean): 정리 1~16 (`101/101` 변이 포착).
- [`proofs/milne_weil_reduction_and_repairs.lean`](./proofs/milne_weil_reduction_and_repairs.lean): 정리 17~36 (`131/131` 변이 포착).
- [`proofs/verify_symbolic_milne.py`](./proofs/verify_symbolic_milne.py) 및 [`proofs/oai_001_milne_repair.patch`](./proofs/oai_001_milne_repair.patch).

```bash
lean ./proofs/milne_transport_and_filtration.lean && lean ./proofs/milne_weil_reduction_and_repairs.lean && (cd ./proofs && python3 verify_symbolic_milne.py)
```
