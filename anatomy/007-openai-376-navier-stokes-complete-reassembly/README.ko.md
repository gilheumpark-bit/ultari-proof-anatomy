# OpenAI #376 미연결 650 모듈 전수 재조립 및 10월 6일 개정판 검증

- 언어 선택: [English (README.md)](./README.md) | 한국어 | 상위 목차: [ultari-proof-anatomy](../../README.ko.md)

이 650-모듈 재조립 감사는 OpenAI #376(`proofs/oai_ref/` 외부 파일은 원본 `openai/math` 커밋 `4eaee87` 기준, 원고 서지 보강은 `oai-math-revised` `PR #76` 병행 참조)에서 6개 공식 챌린지에 연결되지 않았던 650개(718개 순수 미연결) `OAI/` 모듈과 2026년 10월 6일 자 개정 프리프린트를 전수 재조립하고 재계산한 결과물이며, `docs/376.md:12,26` 및 [analysis.tex:263-267](proofs/oai_ref/tex/Incompressible-Box-Transport-and-Finite-Computation-October-6-2026/build/analysis.tex#L263-L267)에 공개된 영압력 콤팩트 지지·전단 시트 범위와 상호 보완되는 주기 토러스 무발산 절반을 복원합니다. 계층 분할, 대수적 항등식, 유리수 상한 및 조건부 비율 부등식은 48개 독립 Lean 4 정리(v4.29.0-rc8, 0 sorry, 가설 변이 150/150건 포착)로 검증했고, 초월 상수 평가($Z_3(2) \approx 16.532316$, $e^{4\pi}$, $\pi$ 구간)와 기호 적분($1/\lambda$ 그린 커널)은 [proofs/verify_symbolic_ns376_complete.py](proofs/verify_symbolic_ns376_complete.py)에서 계산한 뒤 Lean 4 정리(`thm_17`, `thm_09`, `thm_13`)에 명시적 가설(`hz3`, `h_lamSq`, `h_E`, `piSq_lo/hi`)로 전달했습니다.

## 핵심 해부 결과

1. 전수 재조립 (1,004개 모듈): [ForcedComputation/Main.lean](proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/ForcedComputation/Main.lean#L1-L33)(770개), [MaterialFlow.lean](proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/Material/MaterialFlow.lean#L81-L115)(19개 비중복 `Material/` 계층, [Encoding.lean](proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/Material/Encoding.lean#L12-L58) 포함), [StationaryContraction.lean](proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/StationaryContraction.lean#L1-L72)(3개)을 연결해 미연결 모듈을 전수 복원하고, `docs/376.md:12,26`의 $p \equiv 0$ 유클리드·시트 절반에 대응하는 주기 토러스 $\mathbb{T}_L^3$ 무발산 절반을 완결합니다.
2. 비영 압력($p \neq 0$) 및 그린 연산자 상한 정밀화 ($4.528 \times 10^7$배): [Solenoidal.lean](proofs/oai_ref/lean/OAI/Analysis/PeriodicLattice/Solenoidal.lean#L334-L373)의 무발산 외력 구성을 검증했습니다. Lean 4의 `thm_08`은 $(E-1)$ 대수 약분을 증명하고 `thm_09`는 외부 하한 가설 `lamSq >= 157`, `E >= 286751` 하에서 $4.50 \times 10^7$배 초과 압축을 증명하며, `verify_symbolic_ns376_complete.py`의 SymPy 검증은 [PeriodicInverse.lean](proofs/oai_ref/lean/OAI/Analysis/PeriodicLattice/PeriodicInverse.lean#L183-L345)의 정확한 $L^1$ 차폐 그린 노름 $\frac{1}{16\pi^2} \approx 0.006333$($\approx 286,753$ 대비 $45,282,268$배 압축)을 도출합니다.
3. 르레이·검출기·칸토어 상한 개선: [analysis.tex:164-224](proofs/oai_ref/tex/Incompressible-Box-Transport-and-Finite-Computation-October-6-2026/build/analysis.tex#L164-L224)의 `Proposition 2.4 (\label{prop:projection-l2})`에서 3차원 토러스 르레이 상수 52는 Lean 4로 유리수 $L^\infty$ 상한 $\frac{134}{3}$(`thm_12`), 5계층 정육면체 분할(`thm_14`), $n=1$ 유클리드 합 $\frac{89}{9}$(`thm_15`), 그리고 외부 공급 상수 `z3_scaled = 165324`를 가설로 받아 $3.14$배 초과 축소를 확인하는 `thm_17`로 검증됩니다. Lean 4 자체는 무한 격자 합 $Z_3(2) \approx 16.532316$을 평가하지 않으며, 해당 수치 계산($N=250$ 부분합 $16.490619$, 리처드슨 추정치 $16.532149$, 꼬리 상계 포함 엄밀 상한 $16.540885 < 16.59$, 52 대비 $3.145$배 압축)은 `verify_symbolic_ns376_complete.py`에서 수행합니다. 또한 검출기 작동 한계 $H_{\max}$를 $7,560$배($10^9 \to 7.56\times 10^{12}$), 짝수 진법 칸토어 간격을 $b$배($\frac{1}{b-1}$) 확장합니다.

## 4단계 독자 맞춤형 가이드

| 단계 | 대상 독자 | 문서 파일 | 핵심 내용 |
| :---: | :--- | :--- | :--- |
| 1단계 | 초보자 (일반 독자) | [ko/01_고등학생_직관가이드.md](ko/01_고등학생_직관가이드.md) | 4대 모듈 지층 구조, 공개 범위 경계 및 5대 상한 정밀화 결과의 직관적 해설. |
| 2단계 | 중급자 (이공계·개발자) | [ko/02_대학생_수리해부.md](ko/02_대학생_수리해부.md) | 핵심 수식 유도, 신뢰 경계 구분 및 원문 24개 파일 1대1 매핑표. |
| 3단계 | 전문가 (수리물리·형식증명 연구자) | [ko/03_전문가_비평및재구성.md](ko/03_전문가_비평및재구성.md) | 미연결 모듈 전수 해부 및 10월 6일 토러스 에너지 상한 심층 보고서. |
| 4단계 | 자동 검증기 및 파서 | [ko/04_컴퓨터공학_실증검증.md](ko/04_컴퓨터공학_실증검증.md)<br>[manifest.json](manifest.json) | SHA-256 해시 원장, 가설 변이 시험 결과 및 1줄 재현 명령어. |

## 형식증명 코드 및 1줄 검증 명령어

- [proofs/ns376_unimported_solenoidal_and_leray_bounds.lean](proofs/ns376_unimported_solenoidal_and_leray_bounds.lean): 정리 1~24 (80/80 변이 포착).
- [proofs/ns376_detector_margins_and_undecidability_chains.lean](proofs/ns376_detector_margins_and_undecidability_chains.lean): 정리 25~48 (70/70 변이 포착).
- [proofs/verify_symbolic_ns376_complete.py](proofs/verify_symbolic_ns376_complete.py), [proofs/symbolic_verification_result.json](proofs/symbolic_verification_result.json), [proofs/problem_spec.md](proofs/problem_spec.md).

```bash
python3 ../../tools/verify_all.py --root .
lean proofs/ns376_unimported_solenoidal_and_leray_bounds.lean && lean proofs/ns376_detector_margins_and_undecidability_chains.lean && (cd proofs && python3 verify_symbolic_ns376_complete.py)
```
