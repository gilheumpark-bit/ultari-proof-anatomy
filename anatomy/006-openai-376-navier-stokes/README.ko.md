> **언어 선택 (Language)**: [**English (`README.md`)**](./README.md) | **한국어**

# 사례 006: OpenAI `#376` 강제 나비에-스토크스 유동의 보편 계산 감사

이 패키지는 OpenAI `#376`(`1,010`개 `.lean` 파일 `142,131`줄 및 `75`개 `.tex` 파일)을 수리물리학 및 형식증명 관점에서 감사한 결과물입니다. 모든 결론은 `45`개 독립 Lean 4 정리(`v4.29.0-rc8`, `0 sorry`, 가설 변이 `176/176`건 포착)로 검증했습니다.

## 핵심 해부 결과

1. **핵심 PDE 구성 검증**: 부피 보존 아핀 컬 퍼텐셜 $U = \nabla\times(\chi\Psi)$([`BoxTransport/Flow.lean`](proofs/oai_ref/lean/OAI/Analysis/BoxTransport/Flow.lean#L114-L225)), $L^2$ 에너지 유일성([`Comparison.lean`](proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/BalancedTransport/Comparison.lean#L85-L132)), 2+1D 가우스 열핵 수동 스칼라 검출기([`MildScalar.lean`](proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/VelocityDetection/MildScalar.lean#L1-L120))를 검증합니다.
2. **역산 외력 모델 경계 분리**: 5개 상자·시트 챌린지가 영압력($p=0$) 역산 외력 항등식 $f := \partial_t U + (U\cdot\nabla)U - \nu\Delta U$([`BoxCoding.lean:53-66`](proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/BalancedTransport/BoxCoding.lean#L53-L66)) 또는 비선형 이류가 소멸하는 단방향 전단 시트(`advection = 0`)를 사용함을 규명합니다.
3. **임포트 지층 및 중복 챌린지 적발**: 6개 챌린지가 `1,004`개 `OAI/` 파일 중 `354`개만 임포트하고 `650`개(`64.7%`, `ForcedComputation/` 포함)를 미연결 상태로 남겼으며, 챌린지 5번과 6번이 동일한 정리를 중복 선언했음을 확인합니다.
4. **고전 인간 수학자 원저 귀속 및 미인용 참고문헌(`references.bib`) 감사**: 주 논문(`Incompressible-Box-Transport-and-Finite-Computation-October-6-2026/build/`, `16`개 `.tex` 파일 `5,864`줄)의 `references.bib` 등록 문헌 `22`개 중 `9`개(`40.9%`, `Moser1965`·`Nash1958`·`Aronson1968`·`Tao2016`·`EtnyreGhrist2000` 등)가 본문 `\cite` 누락으로 PDF 참고문헌에서 빠졌고, `15`개 섹션 파일 중 `11`개(`4,630 / 5,808`줄, `79.7%`)에 인간 문헌 인용이 `0`건임을 확인하고 누락된 핵심 고전 원저를 대조 복원했습니다([`ko/03_전문가용_수리물리및형식증명심사보고서.md`](ko/03_전문가용_수리물리및형식증명심사보고서.md) `1.7`절).

## 4단계 독자 맞춤형 가이드

| 단계 | 대상 독자 | 문서 파일 | 핵심 내용 |
| :---: | :--- | :--- | :--- |
| **1단계** | **초보자 (일반 독자)** | [`ko/01_초보자용_쉬운해설.md`](ko/01_초보자용_쉬운해설.md) | 자율 유체 동역학 계산과 역산 외력 상자 수송의 차이 및 핵심 요약. |
| **2단계** | **중급자 (이공계·개발자)** | [`ko/02_중급자용_구조및수식가이드.md`](ko/02_중급자용_구조및수식가이드.md) | 10개 프리프린트 폴더·6대 챌린지 매핑 및 45개 Lean 4 정리 1대1 색인표. |
| **3단계** | **전문가 (수리물리·형식증명 연구자)** | [`ko/03_전문가용_수리물리및형식증명심사보고서.md`](ko/03_전문가용_수리물리및형식증명심사보고서.md) | 4계층 심사 판정, `1,010`개 파일 임포트 지층 분석, 르레이 투영 비국소성 및 5대 수리 규격. |
| **4단계** | **자동 검증기 및 파서** | [`ko/04_자동검증및파서용_명세서.md`](ko/04_자동검증및파서용_명세서.md)<br>[`manifest.json`](manifest.json) | SHA-256 해시 원장 및 45개 Lean 4 정리 줄 번호 매핑표. |

## 형식증명 코드 및 1줄 검증 명령어

- [`proofs/ns376_kinematic_routing_and_forensics.lean`](proofs/ns376_kinematic_routing_and_forensics.lean): 정리 1~20 (`106/106` 변이 포착).
- [`proofs/ns376_gronwall_uniqueness_and_repairs.lean`](proofs/ns376_gronwall_uniqueness_and_repairs.lean): 정리 21~45 (`70/70` 변이 포착).
- [`proofs/verify_symbolic_ns376.py`](proofs/verify_symbolic_ns376.py), [`proofs/symbolic_verification_result.json`](proofs/symbolic_verification_result.json), [`proofs/problem_spec.md`](proofs/problem_spec.md).

```bash
lean proofs/ns376_kinematic_routing_and_forensics.lean && lean proofs/ns376_gronwall_uniqueness_and_repairs.lean && (cd proofs && python3 verify_symbolic_ns376.py)
```
