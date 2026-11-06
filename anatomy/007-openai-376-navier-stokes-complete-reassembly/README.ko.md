> **언어 선택 (Language)**: [**English (`README.md`)**](./README.md) | **한국어**

# 사례 007: OpenAI `#376` 미연결 `650` 모듈 전수 재조립 및 10월 6일 개정판 검증

이 패키지는 OpenAI `#376`에서 6개 공식 챌린지에 연결되지 않았던 `650`개(`718`개 순수 미연결) `OAI/` 모듈과 2026년 10월 6일 자 개정 프리프린트를 전수 재조립하고 재계산한 결과물입니다. 모든 결론은 `48`개 독립 Lean 4 정리(`v4.29.0-rc8`, `0 sorry`, 가설 변이 `134/134`건 포착)로 검증했습니다.

## 핵심 해부 결과

1. **전수 재조립 (`1,004`개 모듈)**: [`ForcedComputation/Main.lean`](proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/ForcedComputation/Main.lean#L1-L33)(`770`개), [`MaterialFlow.lean`](proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/Material/MaterialFlow.lean#L85-L115)(`19`개), [`StationaryContraction.lean`](proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/StationaryContraction.lean#L1-L72)(`3`개)을 통해 미연결 모듈을 전수 복원합니다.
2. **비영 압력($p \neq 0$) 및 그린 연산자 상한 정밀화 (`4,528만 배`)**: [`Solenoidal.lean`](proofs/oai_ref/lean/OAI/Analysis/PeriodicLattice/Solenoidal.lean#L315-L366)의 무발산 외력 구성을 검증하고, [`PeriodicInverse.lean`](proofs/oai_ref/lean/OAI/Analysis/PeriodicLattice/PeriodicInverse.lean#L183-L345)의 차폐 그린 노름 상한을 $\approx 286,753$에서 $\frac{1}{16\pi^2} \approx 0.00633$으로 압축합니다.
3. **르레이·검출기·칸토어 상한 개선**: 3차원 토러스 르레이 상수를 `52`에서 $16.5321$($3.15$배)로 줄이고, 검출기 작동 한계 $H_{\max}$를 $7,560$배($10^9 \to 7.56\times 10^{12}$), 짝수 진법 칸토어 간격을 $b$배($\frac{1}{b-1}$) 확장합니다.

## 4단계 독자 맞춤형 가이드

| 단계 | 대상 독자 | 문서 파일 | 핵심 내용 |
| :---: | :--- | :--- | :--- |
| **1단계** | **초보자 (일반 독자)** | [`ko/01_고등학생_직관가이드.md`](ko/01_고등학생_직관가이드.md) | 4대 모듈 지층 구조와 5대 상한 정밀화 결과의 직관적 해설. |
| **2단계** | **중급자 (이공계·개발자)** | [`ko/02_대학생_수리해부.md`](ko/02_대학생_수리해부.md) | 핵심 수식 유도 및 48개 Lean 4 정리 1대1 줄 번호 색인표. |
| **3단계** | **전문가 (수리물리·형식증명 연구자)** | [`ko/03_전문가_비평및재구성.md`](ko/03_전문가_비평및재구성.md) | 미연결 모듈 전수 해부 및 10월 6일 토러스 에너지 상한 심층 보고서. |
| **4단계** | **자동 검증기 및 파서** | [`ko/04_컴퓨터공학_실증검증.md`](ko/04_컴퓨터공학_실증검증.md)<br>[`manifest.json`](manifest.json) | SHA-256 해시 원장, 가설 변이 시험 결과 및 1줄 재현 명령어. |

## 형식증명 코드 및 1줄 검증 명령어

- [`proofs/ns376_unimported_solenoidal_and_leray_bounds.lean`](proofs/ns376_unimported_solenoidal_and_leray_bounds.lean): 정리 1~24 (`68/68` 변이 포착).
- [`proofs/ns376_detector_margins_and_undecidability_chains.lean`](proofs/ns376_detector_margins_and_undecidability_chains.lean): 정리 25~48 (`66/66` 변이 포착).
- [`proofs/verify_symbolic_ns376_complete.py`](proofs/verify_symbolic_ns376_complete.py), [`proofs/symbolic_verification_result.json`](proofs/symbolic_verification_result.json), [`proofs/problem_spec.md`](proofs/problem_spec.md).

```bash
lean proofs/ns376_unimported_solenoidal_and_leray_bounds.lean && lean proofs/ns376_detector_margins_and_undecidability_chains.lean && (cd proofs && python3 verify_symbolic_ns376_complete.py)
```
