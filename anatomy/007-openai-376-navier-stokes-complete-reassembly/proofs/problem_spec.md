# OpenAI #376 미연결 650(718) 모듈 전수 재조립 및 10월 6일 개정판 명세 (Zero-Hint Problem Specification)

## 1. 대상 문제 및 진입점 파일
- **문제 식별자**: OpenAI Math `#376` (`Universal computation in forced Navier–Stokes flows` — 미연결 `650` (`718`) `OAI/` Lean 4 모듈 및 2026년 10월 6일 개정판 `Incompressible-Box-Transport-and-Finite-Computation-October-6-2026` 전수 재조립)
- **검증 대상 마스터 허브 및 미연결 모듈 (`proofs/oai_ref/lean/OAI/**/*.lean` 및 `proofs/oai_ref/tex/**/*.tex`)**:
  1. `OAI/MathematicalPhysics/NavierStokes/ForcedComputation/Main.lean` (30개 서브 메인 모듈을 결합하는 770개 파일 마스터 허브)
  2. `OAI/Analysis/PeriodicLattice/Solenoidal.lean`, `PeriodicInverse.lean`, `Main.lean` 및 `ForcedComputation/Programs/PeriodicLatticeCorollaryMain.lean` (비영 압력 $p = -\phi \neq 0$, 무발산 외력 $\operatorname{div} f_{\text{sol}} = 0$, 1차원 차폐 그린 연산자 $\mathcal{S}_{4\pi}$)
  3. `Incompressible-Box-Transport-and-Finite-Computation-October-6-2026/build/analysis.tex` (3차원 주기 토러스 $\mathbb{T}_L^3 = (\mathbb{R}/L\mathbb{Z})^3$ 상의 유한 에너지 경계 및 르레이 투영 상수 $S_L = (1 + 52(L/2\pi)^4)^{1/2}$)
  4. `OAI/MathematicalPhysics/NavierStokes/ShearFlows/Affine.lean`, `Main.lean` 및 `ForcedComputation/Programs/FixedParticleMain.lean` (4단 전단 유동 쌍곡 대각 분해 $S_X(\lambda-1)\circ S_Y(1)\circ S_X(\lambda^{-1}-1)\circ S_Y(-\lambda)$ 및 고정 입자 검출기)
  5. `OAI/MathematicalPhysics/NavierStokes/ForcedComputation/Detector/VelocityDetectorScales.lean`, `DetectorMargins.lean`, `VelocityUnconditional.lean` (콤팩트 지지 속도 검출기 질량 급수 `massBound`, 확산 손실 및 무조건부 결정 불가능성 방출 사슬)
  6. `OAI/MathematicalPhysics/NavierStokes/ForcedComputation/Programs/BalancedCycle.lean`, `BalancedMain.lean`, `FiniteMachineHaltingDischarge.lean`, `RapidMachineHaltingDischarge.lean`, `ParticleDecisionUnconditional.lean`, `StationaryMain.lean`
  7. `OAI/MathematicalPhysics/RapidForcing/Scales.lean`, `OAI/MathematicalPhysics/NavierStokes/Material/Encoding.lean`, `MaterialFlow.lean`, `HomogeneousDatum.lean`, `FiniteRankGap.lean`, `StationaryContraction.lean`

## 2. 감사 및 재계산 대상 심볼 목록 (Target Symbols)
1. **3차원 주기 격자 무발산 외력 및 그린 연산자 (`PeriodicLattice/`)**:
   - `OAI.PeriodicLattice.FluidLift.doubleSlope` / `vertical_energy` / `doubleSlope_second` (`lean/OAI/Analysis/PeriodicLattice/Solenoidal.lean:19,41,46`)
   - `OAI.PeriodicLattice.FluidLift.pressureBase` / `pressureSource` / `pressureMode` / `potential` (`lean/OAI/Analysis/PeriodicLattice/Solenoidal.lean:58,109,140,165`)
   - `OAI.PeriodicLattice.FluidLift.solenoidalForce` / `solenoidalForce_solenoidal` / `solenoidalForce_classical_solution` (`lean/OAI/Analysis/PeriodicLattice/Solenoidal.lean:334,340,355,366`)
   - `OAI.PeriodicLattice.PeriodicInverse.first` / `first_weighted_bound` / `screened` / `screened_rapid` (`lean/OAI/Analysis/PeriodicLattice/PeriodicInverse.lean:84,183,328,340`)
2. **2026년 10월 6일 개정판 3차원 토러스 르레이 투영 및 푸리에 껍질 급수 (`oct06/build/analysis.tex`)**:
   - `\sum_{k \in \mathbb{Z}^3 \setminus \{0\}} |k|^{-4} \le 52` 및 $S_L := (1 + 52(L/2\pi)^4)^{1/2}$ (`tex/Incompressible-Box-Transport-and-Finite-Computation-October-6-2026/build/analysis.tex:187,219-223`)
3. **4단 전단 유동 쌍곡 스케일링 및 중간 궤적 이탈 한계 (`ShearFlows/`)**:
   - `OAI.ShearFlows.scalingEndpoints` / `four_shears` / `reciprocal_correction_bound` / `scaling_endpoints_bound` (`lean/OAI/MathematicalPhysics/NavierStokes/ShearFlows/Affine.lean:13,24,40,67`)
   - `OAI.ShearFlows.reciprocal_affine_maps_by_shears` (`lean/OAI/MathematicalPhysics/NavierStokes/ShearFlows/Main.lean:92`)
4. **콤팩트 속도 검출기 스케일 및 무조건부 결정 불가능성 사슬 (`ForcedComputation/`)**:
   - `OAI.ForcedComputation.massBound` / `diffusion_loss_small` / `heat_wait_long` / `massBound_small` (`lean/OAI/MathematicalPhysics/NavierStokes/ForcedComputation/Detector/VelocityDetectorScales.lean:23,64,74,78`)
   - `OAI.ForcedComputation.detector_old_mass_margin` / `detector_wait_margin` (`lean/OAI/MathematicalPhysics/NavierStokes/ForcedComputation/Detector/DetectorMargins.lean:17,22`)
   - `OAI.ForcedComputation.compact_detector_unconditional` / `torus_velocity_undecidable_unconditional` (`lean/OAI/MathematicalPhysics/NavierStokes/ForcedComputation/Detector/VelocityUnconditional.lean:63,104`)
   - `OAI.ForcedComputation.BalancedCycle.preparation` / `stay_cycle` / `left_cycle` / `right_cycle` (`lean/OAI/MathematicalPhysics/NavierStokes/ForcedComputation/Programs/BalancedCycle.lean:160-168`)
5. **초지수 급속 외력 스케일, 짝수 진법 칸토어 부호화 및 정상 축대칭 수축 사상**:
   - `OAI.RapidForcing.s` / `s_succ` / `s_succ_lower` / `small_motion_exponents` (`lean/OAI/MathematicalPhysics/RapidForcing/Scales.lean:32,73,77,87`)
   - `OAI.NavierStokes.Material.AllowedDigits` / `tailBound` / `fraction_le_tailBound` (`lean/OAI/MathematicalPhysics/NavierStokes/Material/Encoding.lean:12,15,37`)
   - `OAI.NavierStokes.Material.exists_globalMaterialFlow` (`lean/OAI/MathematicalPhysics/NavierStokes/Material/MaterialFlow.lean:81`)
   - `OAI.StationaryNS.homogeneousDatum` (`lean/OAI/MathematicalPhysics/NavierStokes/HomogeneousDatum.lean:40,65`), `finite_rank_gap` (`FiniteRankGap.lean:34`), `lipschitz_budget` / `coercivity_budget` (`StationaryContraction.lean:43,58`)

## 3. 블라인드 검증 요구사항
- `OAI/` 디렉터리 전체 `1,004`개 파일(`139,847`줄)을 4개 독립 계층으로 무누락 분할하고, `lean/docs/376.md`가 범위 밖이라고 선언했던 정리들이 미연결 모듈 어디에 증명되어 있는지 특정할 것.
- OpenAI가 편의상 느슨한 상한으로 뭉개고 지나간 5대 핵심 상수(1차원 차폐 그린 연산자 노름, 3차원 토러스 르레이 투영 상수 `52`, 4단 전단 유동 보정 한계, 속도 검출기 질량 급수 및 증폭 한계 $H$, 짝수 자릿수 칸토어 간격)를 1부터 재계산하여 정밀화된 상한과 비율을 Lean 4 정리 48개(`0 sorry`, `0 axiom`) 및 SymPy/GPU 수치 검증으로 입증할 것.
