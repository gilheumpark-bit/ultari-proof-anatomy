# OpenAI #376 문제 명세 및 경계 조건 (Zero-Hint Problem Specification)

## 1. 대상 문제 및 진입점 파일
- **문제 식별자**: OpenAI Math `#376` (`Universal computation in forced Navier–Stokes flows`)
- **검증 대상 챌린지 파일 (`proofs/oai_ref/lean/ComparatorChallenges/*.lean` 및 `*.json`)**:
  1. `SolenoidalSheetPrograms.lean` -> `OAI.MathematicalPhysics.SheetFlows.SheetProgram` (`OAI.Solenoidal.sheet_theorem`)
  2. `NavierStokesAlternating.lean` -> `OAI.MathematicalPhysics.AlternatingFlow.Development` (`OAI.AlternatingNS.alternating`)
  3. `NavierStokesVelocity.lean` -> `OAI.MathematicalPhysics.NavierStokes.VelocityDetection.Main` (`OAI.VelocityDetection.main_result` in `VelocityDetection/MainResult.lean:11`)
  4. `BalancedBoxRouting.lean` -> `OAI.Analysis.BoxTransport.Routing` (`OAI.BoxTransport.Routing.balanced_box_routing`)
  5. `BalancedThreeStack.lean` -> `OAI.MathematicalPhysics.NavierStokes.BalancedTransport.MainResult` (`OAI.BalancedTransport.balanced_three_stack_realization`)
  6. `ForcedNavierStokesComputation.lean` -> `OAI.MathematicalPhysics.NavierStokes.BalancedTransport.MainResult` (`OAI.BalancedTransport.balanced_three_stack_realization`)

## 2. 감사 및 검증 대상 심볼 목록 (Target Symbols)
1. **외력 구성 및 운동량 방정식 정의**:
   - `OAI.BalancedTransport.affineForce` (`lean/OAI/MathematicalPhysics/NavierStokes/BalancedTransport/Model.lean:139`, `ComparatorChallenges/BalancedThreeStack.lean:124`)
   - `OAI.BalancedTransport.inertialCoefficient` (`lean/OAI/MathematicalPhysics/NavierStokes/BalancedTransport/Model.lean:142`, `ComparatorChallenges/BalancedThreeStack.lean:127`)
   - `OAI.BalancedTransport.viscousCoefficient` (`lean/OAI/MathematicalPhysics/NavierStokes/BalancedTransport/Model.lean:145`, `ComparatorChallenges/BalancedThreeStack.lean:130`)
   - `OAI.BalancedTransport.residual_zero_pressure_solution` (`lean/OAI/MathematicalPhysics/NavierStokes/BalancedTransport/BoxCoding.lean:53`)
   - `OAI.AlternatingNS.residual` (`lean/ComparatorChallenges/NavierStokesAlternating.lean:225`)
2. **비선형 이류항 및 전단 유동 정의**:
   - `OAI.Solenoidal.advection` (`lean/ComparatorChallenges/SolenoidalSheetPrograms.lean:86,188`)
   - `OAI.Solenoidal.scheduleVelocity_advection_zero` (`lean/OAI/MathematicalPhysics/SheetFlows/Differential.lean:99,269`)
3. **3차원 상자 수송 및 유일성 보조정리**:
   - `OAI.BoxTransport.Routing.potentialComponent` / `movingAffinePotential` (`lean/OAI/Analysis/BoxTransport/Flow.lean:114,205` 및 `Routing.lean:94`)
   - `OAI.BalancedTransport.Analysis.unique_in_comparison` (`lean/OAI/MathematicalPhysics/NavierStokes/BalancedTransport/Comparison.lean:85`)
4. **속도 검출기 및 계산 가능성 정의**:
   - `VelocityDetection.TapeCodes.half` (`lean/ComparatorChallenges/NavierStokesVelocity.lean:453` vs `lean/OAI/MathematicalPhysics/NavierStokes/VelocityDetection/TapeCodes.lean:32`)
   - `VelocityDetection.residualCode` (`lean/ComparatorChallenges/NavierStokesVelocity.lean:1085`)
   - `VelocityDetection.Effective.MachineRecipe.compile` / `Program.Represents` (`lean/ComparatorChallenges/NavierStokesVelocity.lean:1176,1201`)
   - `OAI.VelocityDetection.main_result` (`lean/OAI/MathematicalPhysics/NavierStokes/VelocityDetection/MainResult.lean:11,51`)

## 3. 블라인드 검증 요구사항
- 원본 `ComparatorChallenges` 및 `OAI/` 디렉터리의 `import` 도달 가능성 그래프를 전수 조사할 것.
- 외력 정의가 자율 편미분방정식 해법인지 역산 대입인지 판별하되, 논문 본문의 명시적 전제($f := \partial_t U + (U\cdot\nabla)U - \nu\Delta U$, 시간 주기 1인 `PeriodicAfterOne`)와 구분할 것.
- 6개 챌린지 간 명세 중복 여부와 챌린지 추출본(`NavierStokesVelocity.lean:454`) 대 솔루션(`VelocityDetection/TapeCodes.lean:32`)의 증명 상태를 확인할 것.
