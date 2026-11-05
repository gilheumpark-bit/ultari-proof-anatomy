# OpenAI `#376` (`강제 나비에-스토크스 유동의 보편 계산`) 수리물리 및 Lean 4 포렌식 검증 패키지 (`40`개 정리)

## 1. 4계층 종합 심사 판정 (Four-Layer Referee Verdict)
OpenAI `#376` 코퍼스(`1,010`개 Lean 4 파일 `142,131`줄 = `ComparatorChallenges` `6`개 `2,284`줄 + `OAI/` `1,004`개 `139,847`줄 전수 `0 sorry`, LaTeX 프리프린트 `10`개 폴더 / `75`개 `.tex` 파일 `23,477`줄)에 대한 4계층 검증 결과는 다음과 같습니다:

- **`Layer 1A` (논문 자체의 명시적 강제 유동 모델 및 정합성): 성립 (`PASS`)**
  - 논문 본문(`Incompressible-Box-Transport/introduction.tex:90-96`, `Scalar-Potentials/main.tex:452-454`)과 [`lean/docs/376.md`](proofs/oai_ref/lean/docs/376.md#L1-L37)는 정지 상태($u(0)=0$)에서 출발하는 무발산 속도장 $U = \nabla\times(\chi\Psi)$에 대해 외부 체적력을 미분 잔차 $f := \partial_t U + (U\cdot\nabla)U - \nu\Delta U$ ($p=0$)로 정의한다는 점을 명시하고 있습니다.
  - 초기 구간 $t \in [0, 1]$에서 입력 단어 $w$를 인코딩한 뒤, $t \ge 1$ 이후 속도장 $U(M,w,t,x) = \text{repeated}(M,t,x)$와 외력 $f = f_0 + \nu f_1$은 입력 $w$ 및 단계 $n$에 무관한 **시간 주기 1의 주기장(`PeriodicAfterOne`, [`BalancedThreeStack.lean:214-231`](proofs/oai_ref/lean/ComparatorChallenges/BalancedThreeStack.lean#L214-L231))** 이며, 계산 상태 전이는 라그랑주 입자 상미분방정식 $\dot{X}(t) = U(t, X(t))$를 통해 수행됩니다.
- **`Layer 1B` (자율 비선형 유체역학 계산 vs 역문제 운동학 조향의 구분): 조건부 / 역문제 (`CONDITIONAL / INVERSE-FORCING`)**
  - 5개 상자·시트 챌린지에서는 나비에-스토크스 운동량 방정식이 $f := \partial_t U + (U\cdot\nabla)U - \nu\Delta U$ ($p=0$) 역산 대입([`BalancedTransport/BoxCoding.lean:53-66`](proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/BalancedTransport/BoxCoding.lean#L53-L66)의 `abel` 항등식) 또는 단방향 전단 시트(`advection u t x = 0`, [`SolenoidalSheetPrograms.lean:188`](proofs/oai_ref/lean/ComparatorChallenges/SolenoidalSheetPrograms.lean#L188))로 만족됩니다.
  - 3번째 챌린지([`NavierStokesVelocity.lean`](proofs/oai_ref/lean/ComparatorChallenges/NavierStokesVelocity.lean#L1-L1275))는 $x_3$에 독립인 $2+1\text{D}$ 삼각 속도장 $u = (a_1(t,x_1,x_2), a_2(t,x_1,x_2), w(t,x_1,x_2))$을 사용하여 수직 속도 $w$를 2차원 선형 수동 스칼라 방정식으로 분리하고 가우스 열핵([`VelocityDetection/MildScalar.lean`](proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/VelocityDetection/MildScalar.lean#L1-L120))으로 풀이합니다.
  - [`lean/docs/376.md`](proofs/oai_ref/lean/docs/376.md#L16-L17)에 명시된 범위 한계: [`SolenoidalSheetPrograms.lean`](proofs/oai_ref/lean/ComparatorChallenges/SolenoidalSheetPrograms.lean#L1-L197)은 코딩 시트 위의 유한 양수 대각 사상만 다루며, 논문의 고정 입자 정지 검출기와 고체 상자 위의 역수 사상은 형식화 범위 밖입니다.
- **`Layer 2` (Lean 4 저장소 구조 및 챌린지 패키징 감사): 구조적 결함 확인**
  1. **챌린지 #5·#6 명세 중복**: [`ForcedNavierStokesComputation.lean`](proofs/oai_ref/lean/ComparatorChallenges/ForcedNavierStokesComputation.lean#L1-L232)(`232`줄)은 [`BalancedThreeStack.lean`](proofs/oai_ref/lean/ComparatorChallenges/BalancedThreeStack.lean#L1-L239)(`239`줄)의 `38`개 정의와 정리(`balanced_three_stack_realization`)를 그대로 복제했으며 두 JSON 파일 모두 `OAI.MathematicalPhysics.NavierStokes.BalancedTransport.MainResult`를 가리킵니다.
  2. **`650 / 1,004`개 미임포트 `OAI/` 모듈 (`64.7%`)**: 6개 챌린지 진입점에서 도달 가능한 `OAI/` 파일은 `354`개(`66,480`줄)이며, `ForcedComputation/` 하위 `576`개 파일(`60,321`줄)을 포함한 `650`개 파일(`73,367`줄)은 어느 챌린지에서도 임포트되지 않습니다.
  3. **챌린지 파일 추출 아티팩트 (`NavierStokesVelocity.lean:454`)**: [`ComparatorChallenges/NavierStokesVelocity.lean`](proofs/oai_ref/lean/ComparatorChallenges/NavierStokesVelocity.lean#L453-L454)(`1,275`줄)은 `48`개 내부 네임스페이스를 포함하며 `454`번째 줄 `VelocityDetection.TapeCodes.half`에 `w.liftOn word (by sorry)`가 남아 있습니다(솔루션 모듈 [`VelocityDetection/TapeCodes.lean:32-33`](proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/VelocityDetection/TapeCodes.lean#L32-L33)에는 `0 sorry`로 증명되어 있음).
  4. **중복 점성 오라클 가설 (`_hcomputable`)**: [`VelocityDetection/MainResult.lean:14,51`](proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/VelocityDetection/MainResult.lean#L14-L51)은 `(hν_comp : ComputableReal ν)`를 `_hcomputable`로 받아 사용하지 않는데, 이는 `RationalBox 5`가 0번째 좌표 `x(0) = ν`로 점성 계수 근사를 이미 공급하기 때문입니다.
- **`Layer 3 & Layer 4` (내부 핵심 수리 기법 3종 및 독립 40정리·수치 검증): 통과 (`PASS`)**
  - 회전 상자 조향($\nabla\times(\chi\Psi)$), Serrin-Grönwall $L^2$ 에너지 유일성($12C$), $2+1\text{D}$ 가우스 열핵 Duhamel 양수성 및 5대 수리 규격을 **`40`개의 독립 Lean 4 정리(`0 sorry`, `0 axiom`, `163/163` 가설 변이 사살)** 와 `SymPy`·`PyTorch` FP64 스펙트럼/자동미분 시뮬레이션으로 검증했습니다.

---

## 2. 수준별 문서 및 증명 파일 안내

- **한국어 4단계 해설서 (`ko/`)**:
  - [`ko/01_초보자용_쉬운해설.md`](ko/01_초보자용_쉬운해설.md)
  - [`ko/02_중급자용_구조및수식가이드.md`](ko/02_중급자용_구조및수식가이드.md)
  - [`ko/03_전문가용_수리물리및형식증명심사보고서.md`](ko/03_전문가용_수리물리및형식증명심사보고서.md)
  - [`ko/04_자동검증및파서용_명세서.md`](ko/04_자동검증및파서용_명세서.md)
- **영어 4단계 해설서 (`en/`)**:
  - [`en/01_Beginner_Guide.md`](en/01_Beginner_Guide.md)
  - [`en/02_Intermediate_Math_and_Code_Guide.md`](en/02_Intermediate_Math_and_Code_Guide.md)
  - [`en/03_Expert_Forensic_and_Mathematical_Physics_Report.md`](en/03_Expert_Forensic_and_Mathematical_Physics_Report.md)
  - [`en/04_Automated_Verification_and_Parser_Spec.md`](en/04_Automated_Verification_and_Parser_Spec.md)
- **형식 증명 및 기호·수치 검증 (`proofs/`)**:
  - [`proofs/ns376_kinematic_routing_and_forensics.lean`](proofs/ns376_kinematic_routing_and_forensics.lean) (`Theorems 1–20`, `370`줄, `0 sorry`, `106/106` 변이 사살)
  - [`proofs/ns376_gronwall_uniqueness_and_repairs.lean`](proofs/ns376_gronwall_uniqueness_and_repairs.lean) (`Theorems 21–40`, `324`줄, `0 sorry`, `57/57` 변이 사살)
  - [`proofs/verify_symbolic_ns376.py`](proofs/verify_symbolic_ns376.py) (`434`줄) 및 [`proofs/symbolic_verification_result.json`](proofs/symbolic_verification_result.json)
  - [`proofs/problem_spec.md`](proofs/problem_spec.md)
