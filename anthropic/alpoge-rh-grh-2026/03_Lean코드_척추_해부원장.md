# 03. Lean 코드 척추 해부 원장 (`Main.lean`부터 5막 기저까지 1대1 대조)

원본 아카이브(`175,187`개 파일, `17,374,215`줄)는 주석이 `0`줄인 순수 Lean 소스 트리로 배포되었으나, 최상위 진입점 `src/Main.lean:1-12`에서 출발해 역방향 의존성을 추적하면 전체 증명이 명확한 4계층 척추로 분리됩니다(`PASS`). 본 문서는 연구자와 검증자가 원본 파일을 직접 열람할 때 사용할 실제 정리 시그니처와 정확한 행 번호를 사람 말 기능명 우선 순서로 매핑한 원장입니다.

---

## 1. 최상위 진입부: 순정 `Mathlib` 명제와 5대 최종 정리 (`Level 0 ~ 1`)

### 1.1 목표 명제 정의 파일 (`src/Statements.lean:1-16`, 전문 `16`줄)
- **의존성**: `import Mathlib` 단일 줄(`1`행). 사용자 정의 공리·구조체 `0`건.
- **선언 정의 4종**:
    - 제타 비자명 영점 임계선 명제(`RiemannZetaZerosOnLine`, `3~4`행): $\zeta(s)=0$이고 음의 짝수 자명영점 $-2(n+1)$ 및 극점 $s=1$이 아니면 $\operatorname{Re}(s) = 1/2$.
    - 디리클레 우반평면 무영점 명제(`DirichletLNonvanishingRightOfHalf`, `6~8`행): 모든 양의 법 $N$과 모든 디리클레 지표 $\chi \bmod N$에서 $\operatorname{Re}(s) > 1/2$이고 $(\chi \neq 1 \lor s \neq 1)$이면 $L(s, \chi) \neq 0$.
    - 디리클레 임계띠 영점 정렬 명제(`DirichletLZerosOnLine`, `10~12`행): 임계띠 $0 < \operatorname{Re}(s) < 1$ 내 모든 디리클레 $L$-함수 영점은 $\operatorname{Re}(s) = 1/2$.
    - 원시 디리클레 지표 임계선 명제(`PrimitiveDirichletLZerosOnLine`, `14~16`행): 원시 디리클레 지표에 관한 동일 임계선 명제.

### 1.2 최종 5대 정리 진입 파일 (`src/Main.lean:1-12`, 전문 `12`줄)
- `4`행: 순정 리만 가설(`theorem riemannHypothesis : RiemannHypothesis := rhOfAll`)
- `6`행: 제타 영점 실수부 정리(`theorem riemannZeta_eq_zero_re : RiemannZetaZerosOnLine := rhOfAll`)
- `8`행: 디리클레 우반평면 무영점 정리(`theorem LFunction_ne_zero_of_half_lt_re : DirichletLNonvanishingRightOfHalf := allChi`)
- `10`행: 디리클레 임계선 정리(`theorem LFunction_eq_zero_re : DirichletLZerosOnLine := claimAll.2.1`)
- `12`행: 원시 지표 임계선 정리(`theorem LFunction_eq_zero_re_of_isPrimitive : PrimitiveDirichletLZerosOnLine := critAll`)

---

## 2. 함수방정식 대칭 브리지: 우반평면 무영점에서 임계선으로 (`Level 2`)

### 2.1 주정리 연결 커널 (`src/Supplements/Kernels/MainTheorems.lean:7-16`)
- `7`행: 전 지표 무영점 총괄(`theorem allChi : UpperTheory.EveryCharacter := UpperTheory.FinalTheorems.everyCharacter`)
- `9`행: 리만 가설 도출(`theorem rhOfAll : RiemannHypothesis := Formalism.VW.rh_of_every allChi`)
- `11~13`행: 임계선 대칭 도출(`theorem critAll ... := Formalism.VW.critLine allChi N χ hχ s h0 h1 hz`)

### 2.2 감마 인자 무영점 및 반사 대칭 (`src/Formalism/GammaFactorNonvanishing/CritLine.lean:6-32` · `src/Development/AutomorphicArithmetic/CharacterBoxes/RiemannHypothesisOfEveryCharacter.lean:211-229`)
- **수리 역할**: 우반평면 $\operatorname{Re}(s) > 1/2$ 무영점(`EveryCharacter`)이 확립되면 완비 $L$-함수 방정식 $\Lambda(s, \chi^{-1}) = \varepsilon \Lambda(1-s, \chi)$와 감마 인자 무영점(`gammaFactor_ne_zero`, `6`행)에 의해 좌반쪽 $0 < \operatorname{Re}(s) < 1/2$에서도 $1 - s$가 우반평면으로 반사되어 모순이 발생합니다. 법 $N=1$ 자명 지표($L(s, 1) = \zeta(s)$, `LFunction_modOne_eq`) 특화로 리만 제타 함수가 함께 증명됩니다.

---

## 3. 대분기점: 기출 대정리 `195`선과 신작 엔진 `VWin`의 결합 (`Level 3`)

### 3.1 최종 결론 조립 파일 (`src/Development/AutomorphicArithmetic/CharacterBoxes/MainConclusion.lean:7-14`)
```lean
theorem UpperTheory.FinalTheorems.everyCharacter_of_row
    (h : UpperTheory.GalStar.Row0b fun h rc => UpperTheory.Zero.LLC.IsRecT h rc) :
    UpperTheory.EveryCharacter :=
  UpperTheory.LiteratureTheorems.every_character_of_literature_of_vWin
    ⟨h, UpperTheory.Zero.LLC.recTExists, h⟩ (UpperTheory.One.vwin_of_row h)

theorem UpperTheory.FinalTheorems.everyCharacter : UpperTheory.EveryCharacter :=
  UpperTheory.FinalTheorems.everyCharacter_of_row
    UpperTheory.Gal.Int.galoisLocalGlobalStrong_recParameter
```
- **3대 하위 의존 콘 실측 ([anatomy_stats.json](./data/anatomy_stats.json))**:
    1. 국소 랑글란즈 대응 매개변수 존재성(`recTExists`, `src/Development/AutomorphicArithmetic/Foundations/LocalLanglands/LocalCentralUnits/RecTExists.lean:1-6`): 의존 콘 `26,673`개 파일 / `4,206,972`줄.
    2. 세타 리프트 기반 갈루아 국소-대역 정합성(`galoisLocalGlobalStrong_recParameter`, `src/Development/AutomorphicArithmetic/Foundations/GaloisRepresentations/IntegralStructures/RowSrc.lean:6`): 의존 콘 `66,168`개 파일 / `7,850,273`줄.
    3. 보형 창문 성립 정리(`vwin_of_row`, `src/Development/AutomorphicArithmetic/AutomorphicVarieties/ModularityArgument/ThresholdArguments/DenseThresholdCases/VwinOfRow.lean:4-5`): 의존 콘 `157,604`개 파일 / `16,087,324`줄.

### 3.2 보형 창문 인터페이스 (`src/Development/AutomorphicArithmetic/CharacterBoxes/EveryCharacter.lean:8-18` · `src/Development/AutomorphicArithmetic/CharacterBoxes/ExistsPageN.lean:12-50`)
- 원시 지표 무영점 조립(`plugWin`, `EveryCharacter.lean` `8~11`행): 그린 함수 조건(`Green`), 보형 창문 조건(`VWin`), 닫힌 패밀리 가설을 결합해 `la := 3 / 2` 스케일에서 원시 지표 무영점(`ZeroFreeAll`)을 도출하고, `18`행 비원시 확장(`imprimitive`)으로 모든 지표를 덮습니다.
- 보형 창문 상수(`VWin`, `ExistsPageN.lean` `49`행): 지수 상한 `Ct = 401`과 $\varepsilon < 1/52$, 소수 쌍 $(q \equiv 3 \pmod 8,\; d \equiv 7 \pmod{16},\; q \mid d+1)$ 조건(`WinPair`, `27~38`행)에서 샤파레비치-테이트 코호몰로지 길이 합 상한 `VVle E ⌊x^401⌋₊ √(exp(x^ε))`을 요구합니다.

---

## 4. 본문 5막과 대응하는 핵심 모듈 요약표 (`Level 4`)

표의 가로 가독성을 위해 핵심 모듈명과 행 번호만 먼저 표기하고, 전체 디렉터리 경로는 표 바로 아래 색인에 일괄 기재합니다.

| 막 | 수학적 핵심 장치 | 대표 모듈 및 행 번호 | 핵심 정의 · 정리 식별자 |
| :---: | :--- | :--- | :--- |
| **제1막** | 폰 망골트 적분 잔차 및 란다우-유수 영점 비교 | `StatementOC.lean:11-51`<br>`DefsOC.lean:12-47` | `Sz`, `Gz`, `OCAvg`, `LandauEq`, `OrderLogDeriv` |
| **제2막** | 가중 평균 근사 및 마디 이산화 오차 $O(x\log m / m)$ | `StatementU.lean:9-46`<br>`ZetaNonvanishingGeneralWeights.lean:9-25` | `wavg`, `RiemannSumApprox`, `ZetaNonvanishingGeneralWeights` |
| **제3막** | $m \ge x^{1-\theta-\varepsilon}$ 체비쇼프 무영점 판정식 및 반복 리프트 | `ZetaNonvanishingChebyshevWeights.lean:9-35`<br>`EveryCharacterOfLiteratureOfVWin.lean:810-814` | `chebNode`, `ChebyshevWeightApproximation`, `ZetaNonvanishingChebyshevWeights` |
| **제4막** | 랄리스 시소 독립성, CM 야코비 세타 노름 역수, 주기 일치 | `FinalThetaLiftAMFKIndep.lean:1-15`<br>`ThetaNormCM.lean:30-40`<br>`SiegelEisensteinSecondTermHypotheses.lean:69` | `final_gaussOp`, `PI.ThetaNormCM`, `every_character_of_theta_integrals_local_matching` |
| **제5막** | 베렌트 선형관계 회피 집합, 등차 창문 상한, 이와사와 타워 | `BehrendSets/Statement.lean:48-81`<br>`RowSrc.lean:6`<br>`CorGKOf.lean:10-29` | `BehrendFree`, `WindowTwo`, `galoisLocalGlobalStrong_recParameter`, `corGK` |

- **4절 모듈 전체 경로 색인**:
    - 제1~3막 `Formalism` 직속: `src/Formalism/StatementOC.lean:11-51`, `src/Formalism/DefsOC.lean:12-47`, `src/Formalism/StatementU.lean:9-46`, `src/Formalism/ZetaNonvanishingGeneralWeights.lean:9-25`, `src/Formalism/ZetaNonvanishingChebyshevWeights.lean:9-35`
    - 제3~4막 세타·주기: `src/Formalism/ThetaLiftIndependence/FinalThetaLiftAMFKIndep.lean:1-15`, `src/Formalism/PeriodIntegrals/ThetaNormCM.lean:30-40`, `src/Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/SiegelEisensteinSecondTermHypotheses.lean:69`, `src/Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/EveryCharacterOfLiteratureOfVWin.lean:810-814`
    - 제5막 베렌트·타워: `src/Formalism/BehrendSets/Statement.lean:48-81`, `src/Development/AutomorphicArithmetic/Foundations/GaloisRepresentations/IntegralStructures/RowSrc.lean:6`, `src/Development/AutomorphicArithmetic/AutomorphicVarieties/SmallClassNumbers/CorGKOf.lean:10-29`

---

## 5. 메타프로그래밍 사용 파일 8종 전수 감사 기록

아카이브 전체에서 `import Lean` 또는 `CoreM` 엘라보레이터를 호출하는 파일은 아래 8개뿐이며, 이종 커널(`x86_64` · `aarch64`) 실컴파일에서 모두 커널 타입체크를 통과했습니다(`PASS`).

1. 검색 제외 등록(`src/BuildAid/D1.lean:1-4` ~ `src/BuildAid/D5.lean:1-4`, `5`개): 라이브러리 검색 제안 거부 목록(`nameDenyListExt`) 등록 전용.
2. 메타변수 할당 전술(`src/Formalism/LocalToGlobal/IndefiniteReal/HeckeNonvanishing/Imports.lean:1-8`): `elab "kexactB "` 전술(정리 등록 시 C++ 커널 검증 수행).
3. 구조체 프로젝션 복사 전술(`src/Formalism/LocalToGlobal/NumberFieldFamilies/OwnStruct.lean:1-66`): `elab "kcopy "` 전술(`Kernel.isDefEq` 호출).
4. 콤팩트 지지 선언 복제기(`src/Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptCopy.lean:68-90` 및 호출처 `src/Formalism/HermitianCurvature/HermitianCurvatureProofs/CutMainCpt.lean:945`): `addDecl (.defnDecl ...)`와 `addDecl (.thmDecl ...)`만 호출해 쌍둥이 선언 `21`개를 복제 등록하며 공리 추가(`axiomDecl`) `0`건.

---

## 6. `VWin`(`Ct = 401`) 내부 5대 카운트 조립부 및 `UnusedSlot` 9종 분류 감사

`vwin_of_row`(`157,604`개 파일 의존 콘) 내부에서 홀·짝 기우성 코호몰로지 상한을 합류시키는 핵심 조립 모듈과 아카이브 전역의 `UnusedSlot` 식별자 분류는 다음과 같습니다(상세 수식 유도는 [05_전공자용_수론심층심사및수식복원서.md](./05_전공자용_수론심층심사및수식복원서.md) 제4·5장 참조).

- **`VWin` 5대 카운트 합류 사슬**:
    - 5개 카운트(`CountI · CountII · CountIII · CountV · CountZ`) 통합: `src/Development/AutomorphicArithmetic/AutomorphicVarieties/HeightAndVanishing/JointWinOfCounts.lean:16-34`
    - 페레로-워싱턴(`FW.ferreroWashington`), `Ct = 401`, 베렌트 체(`Odd.thmBcFree_of`) 결합: `src/Development/AutomorphicArithmetic/AutomorphicVarieties/ModularityArgument/ThresholdArguments/DenseThresholdCases/HVCore.lean:18-24`
    - 가토 $\mathrm{GL}_2$ 오일러 계(`katoTwoW_of_printsH`), $\mathrm{GSp}_4$ (`sp4In0_alt`), $U(3)$ 히다 패칭(`published_hypotheses_from_patching_alt`) 분배: `src/Development/AutomorphicArithmetic/AutomorphicVarieties/ModularityArgument/ThresholdArguments/DenseThresholdCases/WindowBoundOfLiteratureLevel.lean:25-34`
    - 슈티켈베르거 홀수 기우성 합동(`Odd a`): `src/Development/AutomorphicArithmetic/AutomorphicVarieties/StickelbergerElements/StickelbergerCarrySpecAndWeightOneCoeffOfOdd.lean:5-7`
- **`UnusedSlot` 식별자 9종 전수 분류 (`2 + 7 = 9`종, 고유 파일 `371`개 · 슬롯-파일 쌍 `375`개 · 출현 `2,226`회)**:
    - **실제 비활성 `Prop := True` 가정 슬롯 2종 (`14`개 슬롯-파일 쌍)**: `UnusedSlot55`(`4`개 파일, `src/Development/AutomorphicArithmetic/Foundations/GaloisRepresentations/TypeConditions/TrivialLocalCondition.lean:89`)와 `UnusedSlot72`(`10`개 파일, `src/Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/LocalTypeDictionary/DiscreteSpectrumResidualClassification.lean:7`)만 `True`(`trivial`)로 봉합된 구형 가설 인자입니다.
    - **활성 수학 정리를 담은 `namespace` 명명 잔재 7종 (`361`개 슬롯-파일 쌍)**: 나머지 `UnusedSlot33`(`71`개), `UnusedSlot34`(`37`개), `UnusedSlot35`(`10`개), `UnusedSlot36`(`2`개), `UnusedSlot38`(`5`개), `UnusedSlot39`(`43`개), `UnusedSlot80`(`193`개)은 일괄 익명화·재명명 과정에서 이름만 `UnusedSlot*`으로 남은 **활성 네임스페이스**이며 내부에는 바흐 가군·등급 완비화·높이 부치 정리가 실제로 구현되어 있습니다.
