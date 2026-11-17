# Audit Summary: OpenAI #376 (PR #76: Incompressible Box Transport and Finite Computation)

- 감사 대상: OpenAI openai/math Family #376 (`build/*.tex` 15개 섹션 파일 · 5,808줄, OAI/ 1,004개 + ComparatorChallenges/ 6개 = 1,010개 .lean 파일) / 제출 PR: [mathcommunity/oai-math-revised#76](https://github.com/mathcommunity/oai-math-revised/pull/76) (커밋 7bc55b7)
- 검증 환경: Lean 4 v4.29.0-rc8 / Python 3.14 (SymPy 기호 연산기 및 PyTorch FP64 스펙트럼 검증)
- 산출물 해시 (SHA-256): [ns376_kinematic_routing_and_forensics.lean](../proofs/ns376_kinematic_routing_and_forensics.lean) (cab492b22b85...) | [ns376_gronwall_uniqueness_and_repairs.lean](../proofs/ns376_gronwall_uniqueness_and_repairs.lean) (2f871a49e16d...) | [verify_symbolic_ns376.py](../proofs/verify_symbolic_ns376.py) (2f39eefded4b...)
- 검증 방식: 독립 Lean 4 정리 본 패키지 45개 (0 sorry, 0 axiom, 184 / 184 가설 변이 사살) + 동반 재조립 패키지 48개 (0 sorry, 150 / 150 변이 사살) = 합산 93개 정리 (334 / 334 변이 사살) 및 결정론적 파이썬 검증 스크립트
- OPFF 공식 판정: Gate 1: FAIL · Gate 2: FAIL · Gate 3: FAIL · Gate 4: FAIL · Gate 5: FAIL (재조립 시 HOLD) $\implies$ OPFF TIER F (Hard Reject / Non-Conforming Artifact)



## 0. 8대 핵심 지표 요약표

| 감사 축 | 원고(PDF/공시 문서) 표방 내용 | 실제 저장소(Lean 4 / .tex) 실측치 | 괴리율 / 상태 |
| :--- | :--- | :--- | :---: |
| 1. 코드 도달성 | OAI/ 1,004개 모듈 · 6개 챌린지 진입점 | 활성 증명 콘 35.3% (354개) / 진입점 미도달 모듈 64.7% (650개 · 73,367줄) | 미도달 64.7% (CP-05) |
| 2. 진입점 정합성 | 6개 `ComparatorChallenges/*.lean` 완결 표방 | ForcedNavierStokesComputation.lean(232줄)과 BalancedThreeStack.lean(239줄)이 38개 정의(`def` 37 + `inductive` 1)·51개 선언 공유(래퍼 7줄 차이) + 48개 네임스페이스 병합 | 명세 중복 (CP-10) |
| 3. 원고-코드 일치 | 3D 비선형 비압축성 강제 나비에-스토크스 보편 계산 | 압력 p = 0 고정 + 외력 `f := res_U` 역산 (abel 항등식) 및 단방향 전단 `advection = 0` 퇴화 (`SheetFlows/SheetProgram.lean:28`) | 명세 퇴화 (CP-02) |
| 4. 미완성 스텁 (Unresolved Stub) | 모든 비교 챌린지 기계 검증 완료 | ComparatorChallenges/NavierStokesVelocity.lean:454 (VelocityDetection.TapeCodes.half) 내 미해소 sorry 잔존 | sorry 잔존 (CP-01) |
| 5. 인용 정합성 | 15개 섹션(5,808줄) · 22개 .bib 엔트리 | 11 / 15개 기술 증명 섹션(4,630줄, 79.7%) 인용 0회 / .bib 9 / 22개(40.9%) 본문 `\cite` 누락 | 14대 고전 미귀속 (CP-03) |
| 6. 생성 이력 | 자율 추론을 통한 원고·코드 생성 | 추론 로그 PDF 0편(미제공) - `docs/376.md:12,14,26`에서 p=0, $f_0 + \nu f_1$, 범위 제한은 명시했으나 `ForcedComputation/`·`Solenoidal.lean` 분리 경위 추론 로그 부재 | 이력 부재 (CP-07) |
| 7. 전제·가설 무결성 | 계산 가능 점성 계수 $\nu > 0$ 전제 핵심 사용 | VelocityDetection/MainResult.lean:51의 `_hcomputable : ComputableReal ν` 미참조 | 미사용 가설 (CP-06) |
| 8. 유효 수리 코어 | 상자 라우팅 · 유일성 · 열핵 양수성 보조정리 | Flow.lean(컬 퍼텐셜), Comparison.lean(그론월 유일성), MildScalar.lean(열핵 양수성) 유효 확인 + 동반 패키지에서 650개 미도달 모듈 재조립 복원 | 본 패키지 45개 + 동반 48개 정리 검증 (PASS) |



## 1. 영역별 실측 물증 요약

### 1.1 서지 편중성 및 1차 고전 문헌 귀속 결손 (CP-03)
- 기술 증명 본문 79.7% 무인용: `build/*.tex` 15개 섹션(5,808줄) 중 인용이 존재하는 섹션은 4개(1,178줄, 20.3%)뿐이며, geometry.tex, balanced.tex, compilers.tex, routing-conventions.tex, initialization.tex, observer-routing.tex, solid-routing.tex, torus-routing.tex, guarded-history.tex, clocks.tex, compact-processors.tex 등 11개 기술 증명 섹션(4,630줄, 79.7%)은 선행 문헌 인용이 0건입니다.
- 미연결 .bib 9건(40.9%) 및 미귀속 1차 고전 14건: references.bib 22개 키 중 Moser1965, Nash1958, Aronson1968, Tao2016 등 9개(40.9%)가 본문 `\cite`에서 누락되었고, 헬름홀츠-바일 분해(1858/1940), 그론월 부등식(1919), 크리긴 확장(1971), 민스키 2/3스택 기계(1961/1967), 지겔만-손탁 칸토어 인코딩(1995), 푸어엘-리처즈 계산 가능 해석학(1989) 등 14건의 1차 고전이 무인용으로 사용되었습니다(PR #76에서 전량 복원).

### 1.2 외력 역산 항등식화 및 비선형 항 영(0) 퇴화 (CP-02)
- 영압력(p = 0) 외력 역산 항등식화 (Tautological Force Inversion): BalancedTransport/BoxCoding.lean은 압력을 p = 0으로 고정하고, 목표 속도장 $U$를 먼저 설정한 뒤 외력을 $f := \partial_t U + (U\cdot\nabla)U - \nu\Delta U$로 역산 정의하여 abel 항등식(`res_U - f = 0`)으로 방정식을 통과시켰습니다([ns376_kinematic_routing_and_forensics.lean](../proofs/ns376_kinematic_routing_and_forensics.lean#L18)).
- 비선형 이류항 영(0) 퇴화 (Nonlinear-Term Zero Degeneration): `SheetFlows/SheetProgram.lean:28`은 단방향 전단 시트를 통해 비선형 이류항을 `(u · ∇)u = 0` (`advection = 0`)으로 소거하였으며, NavierStokesVelocity.lean은 수직 속도를 2+1차원 선형 수동 스칼라 열방정식으로 분리하였습니다([ns376_kinematic_routing_and_forensics.lean](../proofs/ns376_kinematic_routing_and_forensics.lean#L50)).

### 1.3 진입점 미도달 모듈 층위 (64.7%) 및 명세 중복 (CP-05, CP-10)
- 650 / 1,004개 모듈(64.7%, 73,367줄) 진입점 미도달: 비영 압력 복원 모듈(Solenoidal.lean)과 ForcedComputation/ 576개 파일 전량을 포함한 650개 모듈이 6개 `ComparatorChallenges/*.lean` 진입점에서 임포트되지 않는 미도달 층위로 분리되었습니다.
- 챌린지 중복 및 미해소 sorry (CP-01, CP-10): ForcedNavierStokesComputation.lean(232줄)과 BalancedThreeStack.lean(239줄)은 동일한 38개 정의(`def` 37개 + `inductive` 1개), 51개 선언(보조 선언 50개·주정리 동일, 래퍼·주석 7줄 차이)을 공유하며, ComparatorChallenges/NavierStokesVelocity.lean:454 (VelocityDetection.TapeCodes.half)에는 미해소 sorry가 잔존합니다.

### 1.4 전제 무결성 및 인간 · 고전 · AI 3층 기여도 분리
- 미사용 가설 (CP-06): VelocityDetection/MainResult.lean:51의 `_hcomputable : ComputableReal ν`는 언더스코어로 바인딩되어 증명 항에서 참조되지 않습니다.
- 3층 기여도 분리: (1) 선행 인간 수리물리·계산이론 뼈대 75%, (2) 유효 보조 형식화 코어(Flow.lean 컬 퍼텐셜 라우팅, Comparison.lean 그론월 유일성, MildScalar.lean 열핵 양수성) 25%, (3) 진정한 비선형 3D 나비에-스토크스 고유 난제에 대한 단독 AI 돌파 0% (p = 0 역산 및 `advection = 0` 퇴화).



## 2. 예상 반론에 대한 사전 사실 확인

- Q1. "`ComparatorChallenges/*.lean` 6개 파일이 컴파일되는데 왜 Gate 1이 FAIL인가?"
  - 사실 확인: ComparatorChallenges/NavierStokesVelocity.lean:454에 미증명 sorry가 남아 있을 뿐 아니라(CP-01), 활성 코드가 압력 p = 0 아래 외력을 목표 속도장의 잔차 `f := res_U`로 역산 정의(abel 항등식)하고 비선형 이류항을 `advection = 0`으로 소거했기 때문입니다(CP-02).
- Q2. "강제 나비에-스토크스 방정식에서 외력 $f$를 두는 것은 표준적이지 않은가?"
  - 사실 확인: 고정된 외력 공간에서 해 $u$를 구하는 것과 달리, 임의의 궤적 $U$를 먼저 고른 뒤 사후적으로 $f := \mathrm{PDE\_residual}(U)$로 정의하면 유체역학과 무관한 임의의 매끄러운 궤적도 항등식 `res_U - res_U = 0`으로 항상 방정식을 만족합니다.
- Q3. "저장소 안에 비영 압력(p != 0) 모듈인 Solenoidal.lean과 ForcedComputation/이 있지 않은가?"
  - 사실 확인: 존재하나, 해당 650 / 1,004개 모듈(64.7%, 73,367줄)은 6개 챌린지 진입점 어디에서도 임포트되지 않는 미도달 모듈 층위(CP-05)입니다. 동반 재조립 패키지에서 이 650개 모듈을 전수 재조립하여 비영 압력 $p = -\phi \neq 0$ 모델을 복원하고 그린 함수 상수를 $4.528 \times 10^7$배 압축했습니다.
- Q4. "VelocityDetection/MainResult.lean:51의 `_hcomputable : ComputableReal ν`는 왜 결함인가?"
  - 사실 확인: 원고는 점성 계수 $\nu$의 계산 가능성을 핵심 가정으로 내세우나, 실제 정리에서는 `_hcomputable`이 증명 본문에서 한 번도 참조되지 않아 비계산 실수 $\nu$에 대해서도 동일한 증명 항이 그대로 통과합니다(CP-06).
- Q5. "references.bib에 22개 문헌이 있는데 왜 귀속 결손(CP-03)인가?"
  - 사실 확인: 22개 키 중 9개(40.9%)가 본문 `\cite`에서 누락되어 참고문헌에서 빠졌고, 15개 섹션 중 11개 기술 증명 섹션(4,630 / 5,808줄, 79.7%)에서 인용이 0회이며 14대 1차 고전 문헌이 무인용으로 사용되었습니다.
- Q6. "그렇다면 #376 저장소의 모든 수학적 내용이 무효라는 뜻인가?"
  - 사실 확인: 아닙니다. 아핀 컬 퍼텐셜 라우팅(Flow.lean), 동일 외력 상쇄 후 그론월 $L^2$ 에너지 유일성(Comparison.lean), 2+1차원 열핵 두하멜 양수성(MildScalar.lean)의 3가지 보조 메커니즘은 수학적으로 유효함을 본 감사에서 분리 공인하였으며, 본 패키지 45개 정리(184/184 변이 사살) + 동반 재조립 패키지 48개 정리(150/150 변이 사살) = 합산 93개 독립 정리(334/334 변이 사살)로 재검증 및 재조립 수리를 완료했습니다.



## 3. 10초 재현 명령어

```bash
# 1) 미해소 sorry(NavierStokesVelocity.lean:454), _hcomputable 미참조, 650개 미도달 모듈 및 11/15 무인용 섹션 실측 확인
python3 proofs/verify_symbolic_ns376.py

# 2) 45개 독립 Lean 4 운동학·라우팅·그론월 유일성·5대 수리 정리 커널 검증 (0 sorry, 0 axiom)
lean proofs/ns376_kinematic_routing_and_forensics.lean
lean proofs/ns376_gronwall_uniqueness_and_repairs.lean
```
