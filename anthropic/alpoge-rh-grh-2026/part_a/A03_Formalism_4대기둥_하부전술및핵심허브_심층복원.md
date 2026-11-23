# 제3부. 신작 코어 `Formalism` 4대 기둥(`2,577,937`줄)의 하부 전술 및 핵심 허브 심층 복원

본 제3부는 알푀게(Levent Alpöge)와 Claude의 리만 가설 형식증명 아카이브에서 신작 수리 엔진의 중심축을 이루는 `Formalism` 4대 기둥(`LocalToGlobal`, `SharpRestriction`, `HermitianCurvature`, `PeriodIntegrals`, 합계 `14,866`개 파일, `2,577,937`줄, 선언 `196,578`개)의 하부 핵심 허브와 `*Proofs/` 전술 본문을 원문에서 직접 열어 인간 수학 수식과 정리 체인으로 역컴파일한 결과물입니다.

선행 초동 포렌식은 `Formalism` 최상단의 `Statement*` 명세 파일 `38`개만 확인한 채 그 아래에 놓인 `2,577,937`줄의 4대 기둥 내부 구현부는 열람하지 못했습니다. 본 권에서는 Part B 전수 AST 도감(`B01`~`B04`)에서 추출한 피참조 차수(`in_degree`) 및 최단 경로(`dist`) 지도를 나침반으로 삼아, 각 기둥의 최다 피참조 대수·해석 허브 원문을 줄 단위로 직독하고 그 내부에서 작동하는 보형 중복도 적층, 반복 파르세발 그람 행렬 상한, 아르키메데스 정칙화 절단 쌍둥이 생성기, 랄리스 시소·차울라-셀베르그·지겔 질량 3중 상쇄 공식을 완결된 수식으로 복원합니다.

---

## 제1장. `Formalism` 4대 기둥의 거시 결합 구조와 전술 통계 (`14,866`개 파일 · `2,577,937`줄)

### 1.1 4대 기둥의 정량 선언 분포와 `Main.lean` 최단 거리 스펙트럼

`Formalism` 네임스페이스 전체(`18,254`개 파일, `3,200,748`줄, 선언 `240,099`개) 가운데 상위 4개 서브트리가 파일 수의 `81.44%`(`14,866`개), 코드 줄 수의 `80.54%`(`2,577,937`줄), 전체 선언의 `81.87%`(`196,578`개)를 점유합니다. 구문 분석기(`atlas/data/formalism_18254.jsonl`)로 전수 집계한 기둥별 파일·바이트·선언 종별 분포와 `Main.lean`으로부터의 임포트 최단 거리(`dist`) 구간은 아래 표와 같습니다.

| 구분 (`Formalism` 하위 영역) | 고유 파일 수 | 코드 줄 수 | 원본 용량 (`Bytes`) | `theorem` | `lemma` | 정리 합계 (`thm+lem`) | `def` | `abbrev` | `structure` | `instance` 외 | 선언 총계 | `Main` 거리 (`dist`) |
| :--- | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| **제1기둥: `LocalToGlobal`** | `5,501` | `955,843` | `49,605,549` | `48,542` | `1,298` | **`49,840`** | `20,543` | `1,293` | `1,151` | `446` | **`73,273`** | `6` ~ `33` |
| **제2기둥: `SharpRestriction`** | `3,093` | `709,436` | `37,418,210` | `33,062` | `760` | **`33,822`** | `19,065` | `778` | `650` | `333` | **`54,648`** | `6` ~ `43` |
| **제3기둥: `HermitianCurvature`** | `1,922` | `460,802` | `24,655,327` | `24,870` | `3,205` | **`28,075`** | `7,475` | `158` | `131` | `119` | **`35,958`** | `7` ~ `25` |
| **제4기둥: `PeriodIntegrals`** | `4,350` | `451,856` | `21,879,248` | `20,675` | `2,859` | **`23,534`** | `8,368` | `382` | `86` | `329` | **`32,699`** | `6` ~ `31` |
| **소계: `Formalism` 4대 기둥** | **`14,866`** | **`2,577,937`** | **`133,558,334`** | **`127,149`** | **`8,122`** | **`135,271`** | **`55,451`** | **`2,611`** | **`2,018`** | **`1,227`** | **`196,578`** | **`6` ~ `43`** |
| **기타 `112`개 특수 소이론 (`A04`)** | `3,388` | `622,811` | `32,299,515` | `21,070` | `5,777` | `26,847` | `15,632` | `484` | `305` | `253` | `43,521` | `6` ~ `37` |
| **합계: `Formalism` 전체** | **`18,254`** | **`3,200,748`** | **`165,857,849`** | **`148,219`** | **`13,899`** | **`162,118`** | **`71,083`** | **`3,095`** | **`2,323`** | **`1,480`** | **`240,099`** | **`6` ~ `43`** |

위 정량 분포에서 세 가지 설계 특성이 확인됩니다.

1. **구조체(`structure`) 밀도와 대수 인터페이스의 집중**: 4대 기둥의 `structure` 선언 `2,018`개 가운데 `89.25%`인 `1,801`개가 `LocalToGlobal`(`1,151`개)과 `SharpRestriction`(`650`개)에 집중되어 있습니다. 두 기둥은 수십 개의 산술·보형 가설 필드를 묶은 레코드(`LinksStage.Inputs`, `AllTied`, `FamP`, `LocalSituation.Sit`, `AsmIface.Shd`)를 매개변수로 넘기며 국소-전역 호환성을 조립하는 골격 역할을 맡습니다.
2. **파일당 평균 줄 수의 극단적 대비**: `HermitianCurvature`는 파일당 평균 `239.75`줄(`460,802 / 1,922`)이며 `Formalism/HermitianCurvature/HermitianCurvatureProofs/UnipotentCoordinatesMeasurePreserving.lean:1-6929`처럼 단일 파일이 수천 줄에 이르는 연속 해석학·리 군 적분 계산을 담고 있습니다. 반대로 `PeriodIntegrals`는 파일당 평균 `103.87`줄(`451,856 / 4,350`)로 가장 잘게 쪼개져 있으며, 유니터리 군 질량 공식의 국소 부피 인자 계산을 `4,350`개 원자 모듈로 분할해 병렬 컴파일 병목을 제거했습니다.
3. **`Main.lean` 최단 거리(`dist = 6`~`7`)의 전면 배치**: 4대 기둥은 모두 `dist = 6` 또는 `dist = 7`에서 외부 `Development.*` 및 `CompanionTheory.*` 용접 계층과 직접 맞물립니다. 즉 4대 기둥은 깊은 밑바닥의 보조 라이브러리가 아니라 최상단 리만 가설 귀류법 바로 한 계단 아래에서 핵심 부등식을 직접 토해내는 주력 증명 엔진입니다.

---

### 1.2 전술(Tactic) 공학 해부: 무탐색 결정론적 재작성과 커스텀 엘라보레이터

4대 기둥 내부 `196,578`개 선언의 증명 본문에서 추출한 상위 14종 전술의 호출 빈도(선언 단위 등장 횟수)는 아래와 같습니다.

| 전술명 (`Tactic`) | `LocalToGlobal` (`73,273`선언) | `SharpRestriction` (`54,648`선언) | `HermitianCurvature` (`35,958`선언) | `PeriodIntegrals` (`32,699`선언) | 4대 기둥 합계 (`196,578`선언) | 기둥 내 수리적 역할 |
| :--- | ---: | ---: | ---: | ---: | ---: | :--- |
| **`rw` / `erw`** | `31,670` | `20,745` | `15,226` | `14,727` | **`82,368`** | 명시적 등식·동치 치환 및 정의 풀어쓰기 후 재결합 |
| **`exact`** | `24,732` | `17,814` | `11,461` | `11,505` | **`65,512`** | 백트래킹 없는 직접 증인 항(proof term) 종결 |
| **`simp` / `simpa`** | `18,189` | `11,718` | `12,303` | `10,748` | **`52,958`** | 제한된 `[simp]` 보조정리 집합(`simp only [...]`) 정규화 |
| **`refine`** | `12,914` | `9,685` | `6,879` | `6,462` | **`35,940`** | 다중 연언·존재 골의 골격 선행 확정 |
| **`obtain` / `rcases`** | `12,078` | `10,126` | `5,485` | `5,478` | **`33,167`** | 거대 패키지 구조체(`Inputs`, `FamP`, `Sit`) 필드 해체 |
| **`ext` / `funext`** | `9,684` | `5,160` | `4,805` | `5,039` | **`24,688`** | 아델 행렬·작용소·측도 함수의 점별 외연성 환원 |
| **`apply`** | `4,860` | `3,653` | `2,198` | `2,597` | **`13,308`** | 단조성·연속성·가측성 함의 규칙 역방향 적용 |
| **`ring` / `ring_nf`** | `4,609` | `3,607` | `2,694` | `2,303` | **`13,213`** | 가환환 다항식·지수 결합식·행렬식 대수 항등식 검증 |
| **`omega`** | `3,202` | `4,675` | `3,009` | `1,852` | **`12,738`** | 격자 차수·유니터리 계수(`Fin (2*r+k+1)`) 프레스버거 산술 |
| **`congr`** | `2,943` | `2,021` | `2,249` | `1,274` | **`8,487`** | 유한합(`∑`)·유한곱(`∏`)·적분(`∫`) 피적분식 합동 축소 |
| **`linarith` / `nlinarith`** | `1,402` | `3,319` | `1,652` | `778` | **`7,151`** | 실수 지수 창(`eps < 1/52`) 및 슈어·코시-슈바르츠 부등식 |
| **`induction`** | `2,137` | `2,248` | `1,217` | `1,229` | **`6,831`** | $m$단계 세타 사슬·파르세발 깊이 $r$·리 미분 단어 귀납 |
| **`calc`** | `1,659` | `1,660` | `1,539` | `1,124` | **`5,982`** | 다단계 부등식·행렬 켤레전치(`gᴴ * J * g`) 연쇄 유도 |
| **`aesop`** | `3` | `2` | `0` | `5` | **`10`** | 사실상 전면 배제 (`0.0051%`, 결정론적 컴파일 시간 보장) |

기둥별 전술 비율의 차이는 각 기둥이 다루는 수학적 대상을 정확히 반영합니다.

- **`SharpRestriction`의 `omega`(`4,675`회)·`linarith`/`nlinarith`(`3,319`회) 집중**: 제2기둥은 5진 수준 깊이 $j_0 = \lceil \log_5(n N(m)/m)\rceil_+$와 갈루아 변형 환의 거듭제곱 절단 지수, 다면체 격자점 개수 상한을 다루므로 자연수 나눗셈·부등식 결정 절차인 `omega`와 실수 선형 부등식 결정기 `linarith` 사용 빈도가 4대 기둥 중 가장 높습니다.
- **`HermitianCurvature`의 `simp`/`simpa`(`34.21%`)·`calc`(`1,539`회) 집중**: 제3기둥은 의사유니터리 군 $U(p,q)$ 위에서 리 미분 작용소 단어(`Dw`)의 교환자와 반쌍형 형식의 코시-슈바르츠 부등식을 전개하므로 `calc` 체인과 `simp only [Matrix.mul_assoc]` 형태의 정규화 빈도가 높게 나타납니다.
- **엘라보레이터 우회용 커스텀 전술 `kexactB`**: 거대 대수 구조체가 중첩되는 `LocalToGlobal` 내부에서는 Lean 4 기본 정교화기(`elaborator`)의 메타변수 단일화 지연을 피하기 위해 `Formalism/LocalToGlobal/IndefiniteReal/HeckeNonvanishing/Imports.lean:1-8`(`in_degree = 45`, `dist = 7`)에 전용 전술 매크로를 정의해 사용합니다.

```lean
-- 출처: Formalism/LocalToGlobal/IndefiniteReal/HeckeNonvanishing/Imports.lean:1-8
import Mathlib
open Lean Elab Tactic Meta in
elab "kexactB " t:term : tactic => withMainContext do
  let goal ← getMainGoal
  let e ← elabTerm t none
  goal.assign e
```

`kexactB`는 기대 타입(`expectedType`)을 `none`으로 두고 항 `t`를 먼저 독립 정교화한 뒤 주 골 메타변수에 `goal.assign e`로 즉시 대입합니다. 기대 타입과 증인 항 사이의 고비용 고차 단일화(higher-order unification)를 생략하고 커널 타입 검사기에서 최종 일치 여부만 판정하게 만들어, 수백 개의 필드를 가진 보형 패키지 접합 파일들의 컴파일 시간을 선형으로 억제합니다.

---

### 1.3 기둥 간 교차 임포트 비대칭 행렬과 단방향 해석 엔진 구조

4대 기둥 내부 모듈들과 `Formalism` 기타 영역(`Other`), 그리고 `Formalism` 바깥의 상위 용접 계층(`OutsideFormalism`) 사이에 형성된 로컬 `import` 간선 수를 전수 집계하면 엄격한 방향성 비순환 계층(DAG)이 드러납니다. 아래 표의 행은 **임포트하는 주체(수요자)**이고 열은 **임포트당하는 대상(공급자)**입니다.

| 수요자 \ 공급자 (`import` 방향 $\to$) | `LocalToGlobal` | `SharpRestriction` | `PeriodIntegrals` | `HermitianCurvature` | `Formalism` 기타(`112`종) |
| :--- | ---: | ---: | ---: | ---: | ---: |
| **`LocalToGlobal` 내부 파일** | (내부 결합) | `743` | `667` | `147` | `1,007` |
| **`SharpRestriction` 내부 파일** | `202` | (내부 결합) | `184` | `104` | `948` |
| **`PeriodIntegrals` 내부 파일** | `266` | `136` | (내부 결합) | `127` | `367` |
| **`HermitianCurvature` 내부 파일** | **`0`** | `15` | `117` | (내부 결합) | `181` |
| **`Formalism` 기타(`112`종) 파일** | `164` | `219` | `91` | `48` | (내부 결합) |
| **`Formalism` 외부 상위 계층 (`Pure_Vwin`·척추)** | `89` | `114` | `42` | `19` | `312` |

이 교차 행렬에서 확인되는 핵심 아키텍처 불변량은 다음과 같습니다.

1. **`HermitianCurvature` $\to$ `LocalToGlobal` 임포트 `0`건**: 제3기둥 `HermitianCurvature`(`1,922`개 파일)는 제1기둥 `LocalToGlobal`을 단 한 건도 임포트하지 않습니다. 즉 아르키메데스 무한자리 곡률 양수성과 양자 소행렬식(`QuantumDeterminants`) 미분 항등식은 전역 세타 리프트 사슬의 존재성이나 대수적 격자 패칭에 전혀 의존하지 않는 순수 실해석·리 군 엔진으로 하부에서 먼저 완결되며, 역방향으로 `LocalToGlobal`(`147`회), `PeriodIntegrals`(`127`회), `SharpRestriction`(`104`회)에 부호 확정성 정리를 일방 공급합니다.
2. **`LocalToGlobal`과 `SharpRestriction`의 상호 분업**: `LocalToGlobal`이 `SharpRestriction`을 `743`회 임포트하여 국소 파르세발·슈어 상한(`ParConsts`, `SchurIrreducible`, `AsmIface`)을 가져오고, 다시 `SharpRestriction`의 최상단 조립부(`GlobalSchurBounds`, `RamificationFrobenius`)가 `LocalToGlobal`의 보형 다중도 구성물(`202`회)과 `PeriodIntegrals`의 안정자 부피 공식(`184`회)을 불러와 최종 명시 공식 오차항을 마감합니다.

나아가 각 기둥이 자신의 경계 바깥(`Formalism` 내 타 기둥 및 `Development.*` 상위 용접부)으로 내보내는 최상단 수출 관문(`dist = 6`~`8`) 파일들을 추적하면 아래 표와 같이 4대 기둥의 대외 인터페이스가 명확히 식별됩니다.

| 소속 기둥 | 대외 수출 관문 모듈 (`src/` 상대경로) | 줄 수 | `dist` | 외부 피참조 | 대외 공급 핵심 정리 및 수리 객체 |
| :--- | :--- | ---: | ---: | ---: | :--- |
| **`LocalToGlobal`** | `Formalism/LocalToGlobal/IndefiniteReal/FinitePlaces/VacExA.lean` | `459` | `6` | `3` | 유한 자리 파라호릭 진공 시험 벡터 존재성(`VacExA`) |
| **`LocalToGlobal`** | `Formalism/LocalToGlobal/IndefiniteReal/LevelTypeEquivalence/UnimodInst.lean` | `292` | `6` | `27` | 레벨-유형 동치 아래 유니모듈러 하르 측도 인스턴스 |
| **`LocalToGlobal`** | `Formalism/LocalToGlobal/IndefiniteReal/SmExpSmulContDiff.lean` | `132` | `6` | `6` | 리 군 지수 스칼라 작용의 매끄러운 미분가능성(`ContDiff`) |
| **`SharpRestriction`** | `Formalism/SharpRestriction/LevelLetterCocycles/SphericalInertData.lean` | `181` | `6` | `95` | 비분해 구면(spherical) 자리의 헤케-갈루아 데이터 호환 |
| **`SharpRestriction`** | `Formalism/SharpRestriction/LevelLetterCocycles/QuotientImageDivisibility/RkMultVOfNotJump.lean` | `153` | `6` | `7` | 비도약(non-jump) 자리에서 몫 상 가분성 계수 공식 |
| **`SharpRestriction`** | `Formalism/SharpRestriction/CuspSpanNormBounds/GlobAut.lean` | `261` | `7` | `25` | 전역 보형 형식 공간과 국소 사영 푸앵카레 생성원 연결 |
| **`HermitianCurvature`** | `Formalism/HermitianCurvature/WeylElementCommutesLevelOne.lean` | `496` | `7` | `4` | 레벨 1 바일 원소 교환성 및 정칙화 쌍 출력(`LemmaBDouble`) |
| **`HermitianCurvature`** | `Formalism/HermitianCurvature/FiniteOrderIntersectionInSmooth.lean` | `218` | `8` | `16` | 유한 위수 부분군 교집합의 매끄러운 다양체 매장 정리 |
| **`HermitianCurvature`** | `Formalism/HermitianCurvature/StatementQ.lean` | `1,119` | `10` | `36` | 양자 소행렬식 행 전개 및 제타 교환 수반 명세(`ZetaComm`) |
| **`PeriodIntegrals`** | `Formalism/PeriodIntegrals/UnitaryGroupMassFormula/ArchimedeanOrbitMeasures/PiDens.lean` | `162` | `6` | `4` | 곱 공간 위 라돈-니코딤 차트 밀도 인수분해(`pi_chart_dens`) |
| **`PeriodIntegrals`** | `Formalism/PeriodIntegrals/OrbitalBoundsConclusion/WittExtensionTheorem.lean` | `144` | `8` | `8` | 국소 에르미트 등거리 사상의 비트 확장 정리(`WittExtension`) |
| **`PeriodIntegrals`** | `Formalism/PeriodIntegrals/UnitaryGroupMassFormula/AdelicClassFiniteness/DictAll.lean` | `98` | `10` | `8` | 아델 에르미트 격자 유수 유한성(보렐 유한성) 사전(`DictAll`) |

---

### 1.4 상단 5대 명세(`Statement`·`StatementOC`·`StatementU`·`StatementCM`·`StatementFL`)와의 결합 및 `Main.lean` 공급 경로

`Formalism` 최상단에 놓인 5대 명세 파일(`Formalism/Statement.lean`, `Formalism/StatementOC.lean`, `Formalism/StatementU.lean`, `Formalism/StatementCM.lean`, `Formalism/StatementFL.lean`)은 모두 증명 본문(`theorem`)을 담지 않고 해석적 목표 명제(`def ... : Prop`)만을 선언하는 **명세 리프(specification leaves)**입니다(`out_degree = 0` 또는 `1`). 따라서 Lean의 구문적 `import` 화살표는 4대 기둥 및 소이론 증명 파일에서 이 5대 `Statement*` 파일을 향해 들어가며, 논리적 정리 공급 화살표는 4대 기둥이 해당 `Prop` 명제들의 가설을 실현하여 `dist = 8 \to 7 \to 6 \to 5`를 거쳐 `Main.lean`으로 올라갑니다.

먼저 5대 명세 파일 전체의 선언 구성과 이를 직접 임포트하여 소비하는 하위 증명 모듈들의 대응 원장을 제시합니다.

| 상단 명세 리프 (`src/` 상대경로) | 줄 수 | `in_deg` | `dist` | 핵심 선언 (`line_start`-`line_end`) | 직접 임포트하여 가설을 소거하는 대표 모듈 (`src/` 상대경로) |
| :--- | ---: | ---: | ---: | :--- | :--- |
| `Formalism/Statement.lean` | `50` | `2` | `9` | `LamF`(`11-13`), `G`(`21-23`), `LandauStepEps`(`39-45`), `RHofG`(`46-49`) | `Formalism/StatementOC.lean`, `Formalism/ZetaRealNonvanish.lean` |
| `Formalism/StatementOC.lean` | `73` | `6` | `8` | `Gz`(`13-14`), `Gchi`(`20-22`), `OCAvg`(`39-51`), `RiemannHypothesisOfLowerBounds`(`65-72`) | `Formalism/SharpRestriction/RamificationFrobenius/TotientGaloisClasses/ExplicitFormulaErrorOfHostConditions.lean` |
| `Formalism/StatementU.lean` | `47` | `5` | `10` | `Gzbar`(`9-10`), `wavg`(`11-13`), `ZetaLandauBarEps`(`29-33`), `RiemannSumApprox`(`42-46`) | `Formalism/ZetaNonvanishing/ZetaLandau.lean`, `Formalism/ZetaNonvanishing/GzLipschitz.lean` |
| `Formalism/StatementCM.lean` | `45` | `3` | `13` | `IsCMType`(`9-10`), `HalfTypes`(`22-26`), `ForcedSumCM`(`35-40`), `ForcedSumIdentity`(`41-44`) | `Formalism/CMTypeGalois/StatementGroup.lean`, `Formalism/ProductFormula/StatementOCCM.lean` |
| `Formalism/StatementFL.lean` | `44` | `1` | `15` | `famComb`(`17-20`), `FamilyLandauC`(`21-31`), `FamilyLandauCW3`(`32-43`) | `Formalism/LFunctionBounds/Statement.lean` |

5대 명세 파일 각각의 원문 수식 정의와 이를 충족하는 4대 기둥의 공급 정리는 다음과 같습니다.

#### (1) `Formalism/Statement.lean:11-50` (`50`줄, `dist = 9`) - 체비쇼프 가중 폰 망골트 잔차 $G(\chi, x)$와 란다우 단측 하한 귀류 명세
원문 `Formalism/Statement.lean:11-23`은 디리클레 지표 $\chi$ (`[NeZero N]`)에 결합된 비음수 계수 $\mathrm{LamF}(\chi, n) := \Lambda(n)(1 + \Re\chi(n))$, 절단합 $S(\chi, x)$, 로그미분 상수 $\gamma_F(\chi)$, 그리고 주항 보정 잔차 $G(\chi, x)$를 다음과 같이 정의합니다.

$$
S(\chi, x) := \sum_{n=1}^{\lfloor x \rfloor} \Lambda(n)\bigl(1 + \Re\chi(n)\bigr)\left(\frac{x}{n} - 1\right), \qquad \gamma_F(\chi) := \gamma + \Re\!\left(\frac{L'(1, \chi)}{L(1, \chi)}\right), \qquad G(\chi, x) := S(\chi, x) - x\log x + \bigl(1 + \gamma_F(\chi)\bigr)x
$$

이어서 `Formalism/Statement.lean:32-49`는 실수 지표($\Im\chi(n) = 0$) 위 란다우 귀류 단계 `LandauStep`, `LandauStepEps`와 최종 목표 명제 `RHofG`(`Formalism/Statement.lean:46-49`)를 선언합니다. `RHofG χ`는 모든 $\varepsilon > 0$마다 $x \ge 1$에서 **단측 하한** $-C x^{1/2 + \varepsilon} \le G(\chi, x)$가 성립하면 `RiemannHypothesis`와 반평면 $\Re(s) > 1/2$에서의 $L(s, \chi) \ne 0$이 동시에 도출된다는 귀류 원리입니다. 양측 절댓값 $|G(\chi, x)|$ 대신 **실수 단측 부등식만으로 충분하다**는 이 비대칭성이 4대 기둥 전체에서 에르미트 그람 행렬의 양수성($0 \le \langle \Theta f, \Theta f \rangle$)으로부터 영점 부재를 끌어내는 출발점입니다.

#### (2) `Formalism/StatementOC.lean:11-73` (`73`줄, `dist = 8`) - 실수화 지표 잔차 $G_\chi(x)$와 영점 차수 일치 명세 `OCAvg`
`Formalism/StatementOC.lean:11-22`는 `Formalism.Statement`를 임포트한 뒤 순수 제타 잔차 $G_z(x) := S_z(x) - x\log x + (1 + \gamma)x$와 법 $N$의 지표 $\chi$에 관한 **실수값** 꼬인 합 $S_\chi(x)$ 및 잔차 $G_\chi(x)$를 선언합니다.

$$
S_\chi(x) := \sum_{n=1}^{\lfloor x \rfloor} \Lambda(n)\,\Re\chi(n)\left(\frac{x}{n} - 1\right), \qquad G_\chi(x) := S_\chi(x) + \Re\!\left(\frac{L'(1, \chi)}{L(1, \chi)}\right) x
$$

이어서 차분 $G_z(x) - G_\chi(x)$의 단측 하한·상한으로부터 $\Re(s) > \theta$ ($s \ne 1$)에서의 해석적 영점 차수 일치 `analyticOrderAt riemannZeta s = analyticOrderAt (LFunction χ) s`를 도출하는 `OCStep`(`Formalism/StatementOC.lean:23-30`), 가중 평균 판본 `OCAvgUpper`(`Formalism/StatementOC.lean:52-64`), `RiemannHypothesisOfLowerBounds`(`Formalism/StatementOC.lean:65-72`)를 정의합니다. 제2기둥 `SharpRestriction` 내부의 핵심 출력 허브인 `Formalism/SharpRestriction/RamificationFrobenius/TotientGaloisClasses/ExplicitFormulaErrorOfHostConditions.lean:2`(`168`줄, `dist = 7`, `in_degree = 10`)가 이 `Formalism.StatementOC`를 직접 임포트하여 원시 지표 유한군 수준 $\Lambda : \mathrm{Level}$ 위에서 결합 선형 형식 $\Lambda.\mathrm{Gm}(y)$(`Formalism/SharpRestriction/RamificationFrobenius/TotientGaloisClasses/ExplicitFormulaErrorOfHostConditions.lean:38`)를 구성합니다.

$$
\Lambda.\mathrm{Gm}(y) := G_z(y) + \sum_{\psi \in \Lambda.\mathrm{Nt}} \Lambda.\mathrm{wt}(\psi)\,\Re\left(g_\chi(\psi.\chi, y)\right), \qquad \Lambda.\mathrm{wt}(\psi) := \begin{cases} 1 & (\Lambda.\mathrm{psK} = \mathrm{some}\,\psi) \\ (3\,\Lambda.o + 1)^{-1} & (\text{그 외}) \end{cases}
$$

여기서 가중치 $(3\,\Lambda.o + 1)^{-1}$(`Formalism/SharpRestriction/RamificationFrobenius/TotientGaloisClasses/ExplicitFormulaErrorOfHostConditions.lean:36`)은 위수 $\Lambda.o = |\Xi|$인 지표 부분군 위에서 코셋 지시함수의 양수성을 강제하는 결정적 계수이며, 같은 파일의 정리 `EAtH.explicit_formula_error_of_host_conditions`(`Formalism/SharpRestriction/RamificationFrobenius/TotientGaloisClasses/ExplicitFormulaErrorOfHostConditions.lean:155-165`)가 호스트 조건 `HostConditions`로부터 명시 공식 오차 패키지 `EAtH`를 도출합니다.

#### (3) `Formalism/StatementU.lean:9-47` (`47`줄, `dist = 10`) - 연속 적분 평균 `Gzbar`, 표본 평균 `wavg`와 멜린-란다우 해석적 연속
`Formalism/StatementU.lean:9-13`은 구간 $[1, 2]$ 위의 연속 적분 평활화 잔차 $\bar{G}_z(x)$(`Gzbar`)와 일반 표본점·가중치 평균 `wavg xs ω x f`를 다음과 같이 정의합니다.

$$
\bar{G}_z(x) := \int_{1}^{2} u\, G_z\!\left(\frac{x}{u}\right) du, \qquad \mathrm{wavg}(\mathrm{xs}, \omega, x, f) := \sum_{j=0}^{m-1} \omega_j \frac{x}{\mathrm{xs}_j} f(\mathrm{xs}_j)
$$

명제 `ZetaLandauBarEps`(`Formalism/StatementU.lean:29-33`)는 부호 $s_0 \in \{1, -1\}$에 관한 적분 평활화 단측 상한 $s_0\,\bar{G}_z(x) \le C x^{\theta + \varepsilon}$ ($x \ge x_0$)으로부터 $\Re(s) > \theta$에서의 $\zeta(s) \ne 0$을 도출하며, 조화 격자 $\mathrm{xs}_j = x / (1 + \frac{j+1}{m})$과 균등 가중치 $\omega_j = 1/m$에서의 이산-연속 오차 $|\mathrm{wavg} - \bar{G}_z(x)| \le K x / m$은 `RiemannSumApprox`(`Formalism/StatementU.lean:42-46`)가 연결합니다. 이 명세는 `Formalism/ZetaNonvanishing/ZetaLandau.lean:18-99`(`300`줄, `dist = 11`)에서 멜린 변환 항등식 `mellin_HZ`(`Formalism/ZetaNonvanishing/ZetaLandau.lean:75-91`)로 실현됩니다. 구체적으로 $H_Z(\varepsilon, C, \theta; x) := \varepsilon G_z(x) + C x^\theta \ge 0$의 멜린 적분 $I_Z(s) = \int_1^\infty H_Z(x) x^{-s-1}\,dx$가 $\Re(s) > 1$에서

$$
\Phi_Z(\varepsilon, C, \theta; s) = \frac{\varepsilon \, n_Z(s)}{s(s - 1)} + \frac{C}{s - \theta}, \qquad n_Z(s) := -\frac{\zeta_1'(s)}{\zeta_1(s)} - 1 + (1 + \gamma)s
$$

와 일치함을 보이고(`PhiZ_eq`, `Formalism/ZetaNonvanishing/ZetaLandau.lean:93-98`), 양수 피적분함수에 관한 란다우 실축 특이점 정리로 실수 영점 및 복소 영점의 존재를 차단합니다.

#### (4) `Formalism/StatementCM.lean:9-45` (`45`줄, `dist = 13`) 및 `Formalism/StatementFL.lean:11-44` (`44`줄, `dist = 15`) - 단수군 CM 반유형 분할과 홀수 지표 차분 공식
`Formalism/StatementCM.lean:9-44`는 홀수 소수 $l \ge 3$의 **곱셈 단수군** $(\mathbb{Z}/l\mathbb{Z})^\times$ (`(ZMod l)ˣ`) 위에서 각 대립쌍 $\{g, -g\}$ 중 정확히 한 원소만 선택하는 CM 유형(`IsCMType`, `Formalism/StatementCM.lean:9-10`: `∀ g : (ZMod l)ˣ, g ∈ Φ ↔ -g ∉ Φ`)과 절반족 항등식 `HalfTypes`(`Formalism/StatementCM.lean:22-26`), 그리고 쌍대 유형 $\Phi \cup \Phi^\vee$ 위의 합동류 가중 폰 망골트 합 오차 `ForcedSumCM`(`Formalism/StatementCM.lean:35-40`)을 명세합니다. 한편 `Formalism/StatementFL.lean:11-43`은 복소 계수 $c_i \in \mathbb{C}$에 관한 지표 가족 **차분** 결합식 `famComb`(`Formalism/StatementFL.lean:17-20`)

$$
\mathrm{famComb}(N, \chi, c, x) := G_z(x) - \Re\left(\sum_{i} c_i\, G_{\chi,\mathbb{C}}(\chi_i, x)\right)
$$

을 정의하며, 이는 `Formalism/LFunctionBounds/Statement.lean:11-126`(`127`줄, `dist = 14`)에서 소수 법 $l$ 위 합이 $l$인 세 쌍 $S = (s_1, s_2, s_3) \in \mathrm{triples}(l)$의 확률 분포 $\nu$와 톱니파 주기 항등식(`PeriodIdentity`, `Formalism/LFunctionBounds/Statement.lean:44-53`) 및 예외적 영점 보유 지표를 소거하는 `KillingLemma`(`Formalism/LFunctionBounds/Statement.lean:55-59`: $|BB| \le l^{1-\varepsilon}$인 나쁜 홀수 지표 집합 $BB$ 위에서 $c_W(l, \nu, \chi) = 0$)로 구현됩니다.

#### (5) 4대 기둥에서 `CoreGm.lean`을 거쳐 `Main.lean`에 이르는 최종 용접 체인
4대 기둥이 생산한 정리들은 제2기둥의 전역 묶음 파일 `Formalism/SharpRestriction/GlobalSchurBounds/TieGlobal.lean:97-124`(`127`줄, `dist = 8`)의 정리 `ChainTied.core_of`에서 단일 핵심 명제 `ChainCore`로 통합된 뒤, `Formalism` 외부 상단 용접부인 `Development/AutomorphicArithmetic/PrimitiveCosets/CoreGm.lean:12-74`(`74`줄)의 주정리 `UpperTheory.Comparison₂.core_gm`(`Development/AutomorphicArithmetic/PrimitiveCosets/CoreGm.lean:12-15`)으로 직결됩니다.

$$
\mathrm{EAtH}(\Lambda, H, TT, x, \varepsilon, C) \;\wedge\; \mathrm{CoreAtH}(H, TT, e_D, e_L, K, c_{HH}, e_K, \varepsilon, x) \implies \Lambda.\mathrm{Gm}(x) \le x^{\frac{1}{2} + (e_D + e_L + 7)\varepsilon}
$$

`Development/AutomorphicArithmetic/PrimitiveCosets/CoreGm.lean:30-31`의 증명 본문이 `obtain`으로 풀어내는 `CoreAtH`의 `36`개 존재 증인(`U0, i0, tr, W, i4, i5, Top, i6, m, f, Dd, Cc, Xpp, ell, N, T2, a, w, eT, eP, η, X', θ` 및 부속 부등식 `13`개)이 바로 아래 제2장~제5장에서 복원할 4대 기둥의 최종 산출물입니다. $\varepsilon \in (0, 1/52)$(`Formalism/SharpRestriction/ParConsts.lean:99-100`)를 $0$으로 보내면 위 지수 $\frac{1}{2} + (e_D + e_L + 7)\varepsilon$이 임계선 $\frac{1}{2}$로 수렴하며 `Formalism/SharpRestriction/RamificationFrobenius/TotientGaloisClasses/ExplicitFormulaErrorOfHostConditions.lean:40-41`의 `ChebyshevGrowthImpliesZeroFree`에 의해 모든 원시 디리클레 지표와 리만 제타 함수의 반평면 $\Re(s) > 1/2$ 무영점성이 확립됩니다.

---

## 제2장. 제1기둥 `Formalism.LocalToGlobal` 심층 해부 (`5,501`개 파일 · `955,843`줄 · `49,840`개 정리)

### 2.1 하위 `35`개 서브패키지 계층 분해와 역할 분담

제1기둥 `Formalism.LocalToGlobal`은 전체 아카이브 신작 영역 가운데 단일 규모가 가장 큰 서브트리(`5,501`개 파일, `955,843`줄, 정리·보조정리 `49,840`개, 정의·구조체 외 `23,433`개)입니다. 이 기둥의 임무는 양의 정부호 및 부정형 에르미트 공간 사슬 위에서 길이 $m \approx \sqrt{x}$의 반복 세타 리프트(iterated theta lift)를 구성하고, 사영 격자 패밀리 위에서 공통 영점 부재 및 단축 평가(`ShortValAt`)를 수행해 정수환 $\mathbb{Z}$ 위에서 미분 연산자 없이 스테파노프(Stepanov) 대수적 중복도를 실현하는 것입니다. `35`개 하위 서브패키지의 정량 분포와 수리적 분업은 아래 표와 같습니다.

| 순위 | 하위 서브패키지 (`Formalism/LocalToGlobal/*`) | 파일 수 | 코드 줄 수 | 정리 (`thm+lem`) | 정의·구조체 외 | 전담 수리 엔진 및 핵심 역할 |
| ---: | :--- | ---: | ---: | ---: | ---: | :--- |
| `1` | **`SiegelLatticeTheory`** | `2,085` | `339,004` | `16,907` | `5,865` | 닫힌 국소 궤도(`TermLoc`), 비일반 항 코커널 증폭 계수(`NGData`), 지겔 격자 세타 핵 |
| `2` | **`Columns`** | `376` | `95,905` | `5,313` | `2,524` | 아델 행렬 열 공간 분해, 포물선 부분군 불변 조건 및 기저 변환 |
| `3` | **`IndefiniteReal`** | `435` | `78,821` | `4,014` | `3,006` | $m$단계 원시 세타 연결고리(`LinksStage`), 시험 벡터(`DatumVec`), 복합 그람 고유값(`PThmB`) |
| `4` | **`TorsionIntegrality`** | `489` | `70,444` | `4,581` | `1,477` | 비틀림 코커널 위수 상한과 국소-전역 정수가역성(`p`-진 분모 소거) |
| `5` | **`GlobalTheory`** | `389` | `69,295` | `3,562` | `1,308` | 유니터리 속 질량·기본영역 부피비(`GL5/Statement.lean` `GenusMassVolumes`) 및 등차수열 소수 정리 귀결 조립 |
| `6` | **`KernelLattices`** | `162` | `48,309` | `2,778` | `1,421` | 멱등 사영 핵 격자(`ker(1-e)`)의 판별식·기울기 보존 정리 |
| `7` | **`ProjectiveLattices`** | `325` | `43,028` | `1,865` | `1,606` | 아벨 다양체 사영 단면(`FreeBridge`), 단축 정규화 평가(`ThShort`), 전칭 시험(`AllTest`) |
| `8` | **`CharacterGerms`** | `238` | `40,069` | `2,068` | `767` | 국소 지표 싹(germ) 전개와 분지 도체 지수 정합성 |
| `9` | **`Divisibility`** | `96` | `31,447` | `1,687` | `1,091` | 아라켈로프 높이 가분성 및 헤케 고유값 정수성 전이 |
| `10` | **`GroupLattices`** | `229` | `31,001` | `1,740` | `812` | 아델 콤팩트 열린 부분군 안정자와 정수 격자 동치류 대응 |
| `11` | **`InertKernelTheory`** | `149` | `29,697` | `1,555` | `548` | 비분해(inert) 소수 자리에서의 파라호릭 핵 공간 차원 산정 |
| `12` | **`PairingIndexBounds`** | `127` | `17,269` | `945` | `346` | 에르미트 쌍대 격자 지수 $[L^\vee : L]$의 자리별 곱 상한 |
| `13` | **`IndefiniteForms`** | `31` | `10,423` | `437` | `567` | 부정형 형식 나무 및 로그 평균 점유율 부등식(`HSClaim`) |
| `14` | **`NumberFieldFamilies` 외 `22`종** | `360` | `50,591` | `2,388` | `2,095` | 수체 가족 구조체 검사(`OwnStruct`), 베셀-에르미트 세타 총괄(`AllTied`), 속 접합(`GenusGluing`) |
| **합계** | **`LocalToGlobal` 전수 (`35`종)** | **`5,501`** | **`955,843`** | **`49,840`** | **`23,433`** | **선언 총계 `73,273`개 (`Main.lean` 최단 거리 `dist = 6`~`33`)** |

추가로 하위 특수 패키지 가운데 `IndefiniteForms`의 핵심 명세인 `Formalism/LocalToGlobal/IndefiniteForms/IndefiniteTree/RealCubicMeans/LogMeanShares/LogMeanStatements/HSClaim.lean:7-23`(`24`줄, `in_degree = 208`, `dist = 10`)은 이항계수 $R(T, D) := \binom{T-1}{D}$와 점유율 인자 $Z(T, D, \delta, d) := 1 - R(T, D)\delta / d$를 정의하여 부정형 나무 분기에서 발생하는 밀도 손실률을 닫힌 대수식으로 통제합니다. 또한 `NumberFieldFamilies`의 `Formalism/LocalToGlobal/NumberFieldFamilies/OwnStruct.lean:7-65`(`66`줄, `dist = 9`)는 Lean 4 메타 함수 `kdefeq`와 `ownStruct`를 이용해 수체 가족 위에서 생성된 구조체의 생성자·사영자 정의 동치성을 커널 환원(`Meta.isDefEq`)으로 검증합니다.

---

### 2.2 최다 피참조 핵심 허브 `15`선 원문 직독 및 구조체·정리 해부

`LocalToGlobal` 내부의 `5,501`개 파일이 공통으로 의존하는 최상위 허브 모듈들과, 이와 직접 맞물리는 전역 연결 모듈(`CoreGm.lean`, `TieGlobal.lean`, `HeckeNonVanishing.lean`)의 원문 명세 요약표는 아래와 같습니다.

| 허브 모듈 (`src/` 상대경로) | 줄 수 | `in_deg` | `dist` | 핵심 선언 및 수리적 기능 |
| :--- | ---: | ---: | ---: | :--- |
| `Formalism/LocalToGlobal/IndefiniteReal/LinksStage.lean` | `315` | `524` | `7` | $m$단계 유니터리 타워 `Yc D i`, 시소 쌍 `(Vc, Wc)`, 마스터 입력 `Inputs` |
| `Formalism/LocalToGlobal/ProjectiveLattices/AllTest.lean` | `16` | `452` | `8` | 모든 허용 매개변수·시험 데이터에 걸친 전칭 검증 래퍼 `AllTest` |
| `Formalism/LocalToGlobal/SiegelLatticeTheory/CokernelGLCounts/NGData.lean` | `128` | `339` | `10` | 비일반(non-generic) 코커널 증폭 몫 `a2C = ‖grpC‖^2 / J2of` 및 계수 상한 |
| `Formalism/LocalToGlobal/IndefiniteReal/FWExist.lean` | `803` | `275` | `8` | 프레임-비트 기저 확장 `extB`, 정수 격자 양립 `lIntegral_topN`, 차원 일치 `tie_of_fwEq` |
| `Formalism/LocalToGlobal/IndefiniteReal/DatumVec.lean` | `214` | `255` | `7` | 아델 순수 텐서 시험 벡터 `pureTensorO`, 멱등합 `IsIdemSum`, 단계 벡터 `IsDatumStep` |
| `Formalism/LocalToGlobal/IndefiniteReal/ConcretePkgSpec.lean` | `234` | `226` | `8` | 추상 링크 조건을 구체 보형 패키지 `concretePkg`로 사상하는 `concretePkg_spec` |
| `Formalism/LocalToGlobal/IndefiniteReal/BaseLiftsPackageOfPrimitiveLinks.lean` | `367` | `223` | `7` | 단일 단계 `PThmA`, $m$중 복합 그람 작용소 `thmBop_of`, `base_lifts_package_of_primitive_links` |
| `Formalism/LocalToGlobal/IndefiniteReal/ZeroPartEigenvalueConvention.lean` | `282` | `217` | `8` | 영(zero-part) 고유값 위상 정규화 `Face3`, `Char3`, `characterisation_of_weak` |
| `Formalism/LocalToGlobal/ProjectiveLattices/ThShort.lean` | `355` | `207` | `9` | 아벨 스킴 위 단축 정규화 평가 `ShortValAt` 및 비중첩 생성 `shortNe0_of_t4Span` |
| `Formalism/LocalToGlobal/ProjectiveLattices/FreeBridge.lean` | `120` | `204` | `9` | 자유 가군 표현과 사영 아벨 단면 사이의 동치 변환 `FDSec_eq`, `noCommonZero_iff` |
| `Formalism/LocalToGlobal/BesselHermitianTheta/AllTied.lean` | `43` | `197` | `7` | 베셀·에르미트·세타 16개 하부 명제를 하나로 묶는 총괄 레코드 `AllTied` |
| `Formalism/LocalToGlobal/SiegelLatticeTheory/ClosedLocalOrbits/TermLoc.lean` | `412` | `190` | `9` | 닫힌 국소 궤도 질량 데이터 `MassDat`, 국소 항 구성기 `mkTermLoc`, `recBBTie_of` |
| `Formalism/LocalToGlobal/IndefiniteReal/HeckeNonvanishing/InputsHecke.lean` 외 | `18`+`112` | `45` | `7`~`11` | `Imports.lean`(`kexactB`), `isCMExt`, 카펠리 멱영 소거 `nonVan`(`HeckeNonVanishing.lean`) |
| `Formalism/SharpRestriction/GlobalSchurBounds/TieGlobal.lean` | `127` | `2` | `8` | 전역·국소·산술 4중 결속 `ChainTied` 및 `ChainTied.core_of` (소속 위치 교차 확인 완료) |
| `Development/AutomorphicArithmetic/PrimitiveCosets/CoreGm.lean` | `74` | `1` | `5` | `CoreAtH`와 `EAtH`를 결합해 $\Lambda.\mathrm{Gm}(x) \le x^{1/2+(e_D+e_L+7)\varepsilon}$ 도출 |

각 허브의 원문 코드에서 추출한 구체적인 대수 구조와 수식은 다음과 같습니다.

#### (1) `LinksStage.lean` (`in_degree = 524`) - $m$단계 유니터리 사슬과 시소 쌍의 중앙 배선판
`Formalism/LocalToGlobal/IndefiniteReal/LinksStage.lean:31-310`은 `LocalToGlobal` 전체에서 가장 많이 임포트되는 중앙 허브입니다.
이 파일은 총실수체 $F = D.\mathrm{host}.F$ 위의 CM 확대체 $E = D.\mathrm{host}.E$에 관한 에르미트 공간 열 `Yc D i` ($0 \le i < m$)와 종착 정부호 공간 `D.sp.X'`(`SpOK`, `Formalism/LocalToGlobal/IndefiniteReal/LinksStage.lean:240`: `(Yc D (D.R.m - 1)).IsDefinite ∧ D.sp.X'.IsDefinite`)을 배열합니다.
각 단계 $i \in \mathrm{Fin}\,m$마다 시소 쌍 `(Vc D i, Wc D i)`가 부착되며, `SplitAt`(`Formalism/LocalToGlobal/IndefiniteReal/LinksStage.lean:109-123`)과 `IdemAt`(`Formalism/LocalToGlobal/IndefiniteReal/LinksStage.lean:124-125`)이 유한 자리 집합 $R.P_g \cup R.Q(t)$ 위에서 직교 멱등원 $e \in \mathrm{AE}(D)$의 존재를 부과합니다.
특히 `Formalism/LocalToGlobal/IndefiniteReal/LinksStage.lean:290-310`에 정의된 `19`개 필드의 마스터 전제 구조체 `Inputs : Prop`는 `LocalToGlobal` 하위 `524`개 증명 파일이 호출하는 단일 가설 묶음으로, 그 필드별 원문 명세는 아래 표와 같습니다.

| 필드 순번 및 이름 (`LinksStage.Inputs`) | 행 번호 | 원문 타입 명세 (`Prop`) | 수학적 의미 및 하부 공급처 |
| :--- | ---: | :--- | :--- |
| `1. weil` / `2. vac` | `291-292` | `WeilExistsFull D` / `VacExistsO D` | 아델 베유 표현 전체 구성 및 유한 자리 진공 벡터(`Formalism/LocalToGlobal/IndefiniteReal/FinitePlaces/VacExA.lean:1-459`) |
| `3. stepVec` / `4. thPVec` | `293-294` | `StepVecExists D` / `ThPVecExists D` | 단계별 세타 시험 벡터 및 종단 사영 시험 벡터 존재(`Formalism/LocalToGlobal/IndefiniteReal/DatumVec.lean:185-207`) |
| `5. ptStable` / `6. cartan` | `295-296` | `PtStable D` / `CartanOK D` | 특수 평가점 안정자 호환 및 무한자리 카르탕 대합 정합(`Formalism/LocalToGlobal/IndefiniteReal/LinksStage.lean:95-100`) |
| `7. selfDual` / `8. vecTheta` | `297-298` | `SelfDualOK D` / `VecThetaSD D` | 자기쌍대 에르미트 격자 판별식 보존 및 자기쌍대 세타 급수 수렴 |
| `9. measFD` / `10. measDef` / `11. fund` | `299-301` | `MeasFDExists D` / `FundDomExists D` | 기본영역 유한 하르 측도 및 정부호 레벨 측도 존재(`PeriodIntegrals` 공급) |
| `12. sp` / `13. lev` | `302-303` | `SpOK D` / `LevOK D` | 종착 공간 `(Yc D (m-1), X')`의 완전 정부호성 및 합동 레벨 양립(`Formalism/LocalToGlobal/IndefiniteReal/LinksStage.lean:240-246`) |
| `14. hc` / `15. schur` | `304-305` | `HCAll D` / `SchurAll D` | 하리시-찬드라 이산계열 모형 및 기약 표현 슈어 보조정리(`Formalism/SharpRestriction/CuspSpanNormBounds/BridgeCSchur.lean:611-625`) |
| `16. pet` / `17. sm` | `306-307` | `PetAll D` / `SmAll D` | 첨점 공간 페테르손 내적 완비성 및 이산계열 매끄러운 벡터 비소멸 |
| `18. dim` / `19. act` | `308-310` | `DimOK D` / `ActRep D` | 최저 $K$-유형 공간 차원 양수성(`0 < dimK`) 및 아델 군 작용 선형 표현 정합 |

#### (2) `DatumVec.lean` (`in_degree = 255`) 및 `FWExist.lean` (`in_degree = 275`) - 아델 순수 텐서 시험 벡터와 프레임-비트 정합
`Formalism/LocalToGlobal/IndefiniteReal/DatumVec.lean:16-211`은 $m$단계 세타 사슬에 투입할 국소-전역 슈바르츠-브뤼아(Schwartz-Bruhat) 시험 함수 $\Phi = \bigotimes'_v \Phi_v$를 구성합니다.
유한 아델 텐서환 $\mathrm{EAf}(D) := E \otimes_F \mathbb{A}_{F,\mathrm{fin}}$(`Formalism/LocalToGlobal/IndefiniteReal/DatumVec.lean:16`) 위에서 유한 자리 집합 $P$의 지시 멱등합 `IsIdemSum e P`(`Formalism/LocalToGlobal/IndefiniteReal/DatumVec.lean:78-82`)는 아델 환 원소 $e$가 $e \cdot c_A(D, e) = 0$ 및 자리별 성분 $e_v \in \{0, 1\}$을 만족하도록 강제합니다.
이어서 단계별 시험 벡터 조건 `IsStepVecOf`(`Formalism/LocalToGlobal/IndefiniteReal/DatumVec.lean:84-97`)와 종단 사영 시험 벡터 조건 `IsThPVecOf`(`Formalism/LocalToGlobal/IndefiniteReal/DatumVec.lean:109-121`)는 가우스 아르키메데스 핵 위에서 유한 자리 성분이 파라호릭 지표 $\omega_G \cdot \omega_Q$(`Formalism/LocalToGlobal/IndefiniteReal/DatumVec.lean:51-73`)의 변환 법칙을 따르는 순수 텐서 `pureTensorO`(`Formalism/LocalToGlobal/IndefiniteReal/DatumVec.lean:130-135`)로 주어짐을 규정합니다.

이 시험 벡터가 실제 정수 격자 위에서 잘 정의되기 위한 기하적 전제는 `Formalism/LocalToGlobal/IndefiniteReal/FWExist.lean:19-800`(`803`줄)에서 증명됩니다.
`FWExist.lean`은 쌍곡 평면 기저(Witt basis)와 정부호 정규직교 기저(Frame basis)를 잇는 사상 `crd`(`Formalism/LocalToGlobal/IndefiniteReal/FWExist.lean:19-21`)와 기저 확장 `extB`(`Formalism/LocalToGlobal/IndefiniteReal/FWExist.lean:34-38`)를 구성하고, 정리 `lIntegral_topN`(`Formalism/LocalToGlobal/IndefiniteReal/FWExist.lean:773-776`), `FWTie.dimMatch`(`Formalism/LocalToGlobal/IndefiniteReal/FWExist.lean:790-794`), `tie_of_fwEq`(`Formalism/LocalToGlobal/IndefiniteReal/FWExist.lean:795-800`)에서 최상단 격자의 $\mathcal{O}_E$-정수성과 보형 형식 공간의 차원 일치를 확립합니다.

#### (3) `ZeroPartEigenvalueConvention.lean` (`in_degree = 217`), `ConcretePkgSpec.lean` (`in_degree = 226`), `BaseLiftsPackageOfPrimitiveLinks.lean` (`in_degree = 223`)
세 모듈은 원시 연결고리(`PrimitiveLinks`)들을 합쳐 단일 전역 보형 패키지를 조립하는 3단 파이프라인입니다.
1. `Formalism/LocalToGlobal/IndefiniteReal/ZeroPartEigenvalueConvention.lean:29-275`는 경계 데이터 `Face3`(`:29-44`) 위에서 헤케 연산자의 영(zero-part) 고유값 규약과 위상 인자 `phase`(`:232-235`)를 정의하고, 정리 `characterisation_of_weak`(`:272-275`)에서 약한 고유값 조건 `WeakCharacterisation`(`:259-269`)으로부터 완전 특성화 `Char3`(`:243-258`)를 유도합니다.
2. `Formalism/LocalToGlobal/IndefiniteReal/BaseLiftsPackageOfPrimitiveLinks.lean:68-196`은 단일 단계 $i$의 수반 결합 $\theta_{i,t} \circ \theta_{i,t}^*$가 부분공간 $W_{i,p}$ 위에서 양의 스칼라 $\lambda_{i,t,p,v_0} > 0$로 작용한다는 `PThmA`(`:68-70`)와, $m$단 합성 리프트 $\Theta_t \circ \Theta_t^*$가 곱 고유값으로 작용한다는 `PThmB`(`:71-73`)를 선언합니다.
   특히 유한차원 복소 내적공간 $E, F$ 사이의 선형 사상 위상 소거 보조정리 `phase_cancel`(`Formalism/LocalToGlobal/IndefiniteReal/BaseLiftsPackageOfPrimitiveLinks.lean:130-161`)은 단위 복소수 $\zeta \in \mathbb{C}$ ($\|\zeta\| = 1$)로 비틀린 사상 $T_\zeta := \zeta \cdot T$에 관해

   $$
   \left(T_\zeta\right) \circ \left(T_\zeta\right)^* = \left(\zeta\, T\right) \circ \left(\overline{\zeta}\, T^*\right) = |\zeta|^2 \, \left(T \circ T^*\right) = T \circ T^*
   $$

   임을 `LinearMap.adjoint_smul`과 `Complex.mul_conj'`로 증명하여, 베유 표현의 사영 2-코사이클 위상 오차가 자기수반 그람 연산자에서 완벽히 상쇄됨을 보입니다.
   그 직후 정리 `thmAop_of`(`:175-183`)와 `thmBop_of`(`:184-196`), 그리고 24행 조건 레코드 `PrimRows3`(`:199-223`)를 입력받는 주정리 `base_lifts_package_of_primitive_links`(`:288-348`)가 기저 수준 리프트 패키지를 완결합니다.
3. `Formalism/LocalToGlobal/IndefiniteReal/ConcretePkgSpec.lean:140-229`(`234`줄, `in_degree = 226`)는 위 결과를 받아 추상 연결고리 인터페이스를 구체적 보형 패키지 `concretePkg`로 실체화하는 전술 증명을 담고 있습니다.
   - **비분지 자리 비뒤틀림 정리 `untw` (`Formalism/LocalToGlobal/IndefiniteReal/ConcretePkgSpec.lean:140-153`)**: 유한 지지집합 바깥의 자리 $w$에서 $\mu(w) = A.\mu_0$임을 대입하고(`h.mu_off`), 귀류 가정 `hW : ¬ R.NonzeroIndexPlace F w`에 드모르간 부정 밀어넣기(`push Not at hn`, `:147`)를 적용해 5개의 국소 변형 지수(`Iw`, `jw`, `F0` 및 켤레 자리 `conjPl w`)가 모두 $0$임을 얻은 뒤 `IndefData.Aw`를 펼쳐 자명성을 완결합니다.
   - **에르미트-베유 노름 척도 정리 `ewNorm` (`Formalism/LocalToGlobal/IndefiniteReal/ConcretePkgSpec.lean:154-163`)**: 양수 인자 $\sqrt{n_P(F, b)}$로 척도 변환된 벡터들의 복소 내적에 `inner_smul_left`, `inner_smul_right`, `Real.mul_self_sqrt (nP_pos b).le`를 연속 적용하여

     $$
     \overline{\left\langle \sqrt{n_P}\,x,\; \sqrt{n_P}\,y \right\rangle_{\mathbb{C}}} = n_P \cdot \overline{\langle x, y \rangle_{\mathbb{C}}}
     $$

     의 정확한 스칼라 인출 항등식을 증명합니다.
   - **실수 자리 $K$-형식 기저 생성 정리 `kForm` (`Formalism/LocalToGlobal/IndefiniteReal/ConcretePkgSpec.lean:164-177`)**: 수체 $L = D.\mathrm{what}_2.\mathrm{LL}$ 위 유한 기저의 선형독립성을 복소 매장 자리 `sgAt embLL v`로 올리고 가역 스칼라 $(\sqrt{n_P})^{-1} \ne 0$을 곱한 뒤(`units_smul`), `Tw.linInd`와 `Tw.span_top`으로 복소 힐베르트 부분공간의 완비 기저성을 도출합니다.
   - **30개 필드 레코드 `cxLinks` 및 `concretePkg_spec` (`Formalism/LocalToGlobal/IndefiniteReal/ConcretePkgSpec.lean:178-224`)**: 위 세 정리와 구체 입력 `hL : ConcreteLinks R F Y C CH`의 필드들을 30개 항목(`stable`, `inBlock`, `ratZ`, ..., `untw`, `passage`, `fun0`)으로 조립한 뒤, 최종 사양 정리 `concretePkg_spec`(`:218-224`)을 정의적 환원 4중쌍 `⟨rfl, rfl, rfl, rfl⟩`로 종결합니다.

#### (4) `AllTest.lean` (`in_degree = 452`), `FreeBridge.lean` (`in_degree = 204`), `ThShort.lean` (`in_degree = 207`) - 사영 격자 단면과 단축 평가
사영 아벨 다양체 위의 세타 함수 평가를 담당하는 `ProjectiveLattices`의 3대 허브입니다.
`Formalism/LocalToGlobal/ProjectiveLattices/AllTest.lean:12-15`는 허용되는 모든 시험 배치에 걸친 보편 정합 술어 `AllTest`를 정의하여 `452`개 하위 모듈의 공통 타입 서명을 통일합니다.
`Formalism/LocalToGlobal/ProjectiveLattices/FreeBridge.lean:18-117`은 자유 $\mathcal{O}_E$-격자 표현(`Unf`)과 사영 스킴 단면(`Pj`) 사이의 번역기 `Unf.ofPj`·`Unf.toPj`(`:38-43`)를 구축하고, 유한 차원 정칙 첨점 단면 일치 정리 `FDSec_eq`(`:18-19`), `isHolCusp_iff`(`:20-22`), 그리고 평가점 집합 위에서 공통 영점이 없음을 번역하는 `noCommonZero_iff`(`:104-106`)를 증명합니다.
그 위에서 `Formalism/LocalToGlobal/ProjectiveLattices/ThShort.lean:244-349`는 아벨 스킴 상의 조화 다항식 $P \in \mathrm{harmL}(\Lambda, a)$에 4중 정규화 역원($\beta^{-1} \cdot \mathrm{mIdx}_N(\Lambda)^{-1} \cdot |\mathrm{LevQ}^n|^{-1} \cdot N^{-\deg P}$)을 결부한 충실 평탄 단축 평가 관계식 `ShortValAt`(`:244-262`)를 정의하고, 우세 가중치 생성 가정으로부터 비영 평가점의 존재를 도출하는 정리 `shortNe0_of_t4Span`(`:335-349`)을 증명합니다.

#### (5) `NGData.lean` (`in_degree = 339`), `TermLoc.lean` (`in_degree = 190`), `AllTied.lean` (`in_degree = 197`)
지겔 격자 궤도 계산을 담당하는 `Formalism/LocalToGlobal/SiegelLatticeTheory/CokernelGLCounts/NGData.lean:18-125`는 퇴화·비일반 푸리에-야코비 궤도의 기여도를 제어하기 위해 가중 지수합 `Jw`(`:29-33`), 제곱합 `J2of`(`:34-38`), 군 평균합 `grpC`(`:39-42`), 그리고 코시-슈바르츠 증폭 비율

$$
\mathrm{a2C} := \frac{\|\mathrm{grpC}\|^2}{\mathrm{J2of}}
$$

(`Formalism/LocalToGlobal/SiegelLatticeTheory/CokernelGLCounts/NGData.lean:43-45`)를 도입하여 정리 `counting_bound_of_joint_chain`(`:110-125`)에서 비일반 항의 개수를 상한합니다.
한편 `Formalism/LocalToGlobal/SiegelLatticeTheory/ClosedLocalOrbits/TermLoc.lean:334-411`은 닫힌 국소 궤도의 안정자 질량 데이터 `MassDat`(`:334-348`)로부터 국소 항 `mkTermLoc`(`:349-381`)을 생성하고 `recBBTie_of`(`:400-411`)로 재귀적 베셀 결합식을 증명합니다.
이렇게 확보된 베셀·에르미트·세타 성분들은 `Formalism/LocalToGlobal/BesselHermitianTheta/AllTied.lean:20-40`의 마스터 번들 구조체 `AllTied (D : D7) (X : ThetaX D) (A : TH.ProvA)`에서 아래 `10`개 필드로 통합됩니다.

| 필드명 (`AllTied`) | 행 번호 | 원문 타입 명세 | 결속되는 수리적 정합 내용 |
| :--- | ---: | :--- | :--- |
| `T` / `sm` / `ty` | `22-26` | `ThetaTied D X` / `ThetaSmoothnessCondition T` / `TypTied T` | 전역 세타 핵 정의, 매끄러움 조건, 국소 $K$-유형·파라호릭 유형 일치 |
| `W` / `unr` / `kf` | `28-31` | `WeilTied D X T` / `WeilUnramifiedCondition W` / `KfinTied W` | 아델 베유 표현 결합, 비분지 자리 구면 벡터 고정성, $K$-유한성 보존 |
| `phiUp` / `B` | `33-35` | `PhiYupTied W` / `BesselTied D X T W` | 상향 슈바르츠 함수 올림 정합 및 푸리에-베셀 주기 적분과의 동치 결합 |
| `real` / `prov` | `37-39` | `RealTied D` / `ProvisionCompatibility D A` | 무한자리 실수 리 군 데이터(`RealTied`) 및 외부 산술 공급자(`ProvA`) 호환 |

#### (6) `HeckeNonvanishing` 계통과 교차 경로 모듈(`TieGlobal.lean`, `CoreGm.lean`) 원문 확인
선행 목록에서 상대 위치 확인이 요구되었던 모듈들의 정확한 아카이브 경로와 원문 증명 구조는 다음과 같이 확정됩니다.
- **`HeckeNonvanishing` 계통과 멱영 핵 소거 증명**: `Formalism/LocalToGlobal/IndefiniteReal/HeckeNonvanishing/Imports.lean:1-8`(`kexactB` 정의) 및 `Formalism/LocalToGlobal/IndefiniteReal/HeckeNonvanishing/InputsHecke.lean:13-15`(CM 확대체 판정 정리 `isCMExt`)와 함께, 헤케 연산자 리프팅 명세는 `Formalism/LocalToGlobal/IndefiniteReal/NormalDecomposition/LiftHeckeOperators.lean:23-79`(`liftHeckeOperators`, `eigensystemChoice`, `ZeroEigenvalueCondition`), `Formalism/LocalToGlobal/IndefiniteReal/PrimitivePackageFullHecke.lean:29-52`(`primitivePackageFullHecke`, `primRows3_data`), `Formalism/LocalToGlobal/IndefiniteReal/NearConstantMultiplicities.lean:50-62`(`passage3_of`, `packageFullHecke`)에 자리 잡고 있습니다.
  실제 카펠리 중심원소에 기반한 이산계열 헤케 고유함수 비소멸 정리는 `CompanionTheory/SpectralGeometry/LocalGlobalProofs/StableLattices/HeckeNonVanishing.lean:15-112`에서 4단 선형대수 보조정리로 완결됩니다.
  1. `exists_ker`(`:19-33`): 유한차원 비자명 $\mathbb{C}$-가군 위의 선형변환 $T$가 다항식 $P(T) = 0$을 만족하면 최소근에서 비영 고유벡터 $\ker(T - \lambda\,\mathrm{id}) \ne \{0\}$이 존재합니다.
  2. `eq_zero_of_nilp`(`:34-48`): $(T - c\,\mathrm{id})^k v = 0$인 일반화 고유벡터 $v$가 동시에 반단순 대각합 조건을 만족하면 $c = 0$일 때 $T v = 0$으로 축약됩니다.
  3. `exists_nnPlus_ne`(`:49-67`): 가환 헤케·카펠리 작용소 열 위에서 동시 일반화 고유공간을 추출하여 비소멸 양수 노름 벡터의 존재를 보장합니다.
  4. `nonVan`(`:68-112`): 위 세 보조정리와 `eeV_eq_om`(`:15-18`)을 결합해 안정 격자 위 헤케 사영 성분이 항등적으로 $0$이 아님을 최종 증명합니다.
- **`TieGlobal.lean` 및 `CoreGm.lean`의 정확한 소속 위치**: 전수 경로 탐색 결과 `TieGlobal.lean`은 제2기둥 하부인 `Formalism/SharpRestriction/GlobalSchurBounds/TieGlobal.lean:1-127`에 위치하며, 점별 결합 `TiePts`(`:39-47`), 전역 리프트 결합 `TieGlobal`(`:50-62`), 국소 슈어·형식차수 결합 `TieLocal`(`:63-83`), 산술 소수점 결합 `TieArith`(`:84-96`)의 4개 절을 합친 `ChainTied`(`:97-115`)로부터 정리 `ChainTied.core_of`(`:116-124`)를 도출합니다. 그리고 `CoreGm.lean`은 `Formalism` 상단 바깥인 `Development/AutomorphicArithmetic/PrimitiveCosets/CoreGm.lean:12-74`에 위치하며 앞서 제1장 1.4절에서 확인한 최종 지수 부등식 `UpperTheory.Comparison₂.core_gm`을 완결합니다.

---

### 2.3 수리적 핵심 복원: 완전 정부호 유니터리 사슬 $U(X_0) \to \dots \to U(X_m)$ ($m \approx \sqrt{x}$)의 $+1$ 보형 중복도 적층과 무미분 스테파노프 평가

고전적인 함수체 리만 가설 증명(스테파노프·봄비에리 방법)에서는 유한체 위의 곡선 $\mathcal{C}/\mathbb{F}_q$ 위에서 보조 다항식 $\Phi$를 구성한 뒤 하세-슈미트 초미분(Hasse-Schmidt hyperderivative) $D^{(r)}\Phi$를 취해 프로베니우스 고정점들에서 높은 소멸 중복도 $m$을 강제합니다. 그러나 유리수체 $\mathbb{Q}$와 정수환 $\mathbb{Z}$에는 모든 소수를 가로질러 라이프니츠 법칙을 보존하는 전역 미분 연산자가 존재하지 않습니다. `LocalToGlobal` 기둥이 구현한 핵심 해법은 **미분 연산자를 통한 소멸 차수 인상 대신, 길이 $m \approx \sqrt{x}$인 완전 정부호 유니터리 군 사슬 위에서 원시 세타 연결고리(`PrimitiveLinks`)를 $m$번 합성하여 보형 스펙트럼 중복도와 아라켈로프 정규화 인자를 단계마다 $+1$씩 곱셈적으로 적층하는 것**입니다. 원문 코드에서 복원한 정확한 매개변수 척도와 연산자 방정식은 다음 4단계로 요약됩니다.

#### 제1단계: 매개변수 척도 창 `(m, n, k)`의 원문 고정 (`Formalism/SharpRestriction/InertJacobiLevels/AsmIface.lean:142-144`)
점근 규모 $x \to \infty$와 미소 지수 $\varepsilon \in (0, 1/52)$(`Formalism/SharpRestriction/ParConsts.lean:99-100`)가 주어질 때, 리프트 사슬의 단계 수 $m := D.R.m$, 평가 차원 매개변수 $n := D.R.n$, 그리고 기저 유니터리 계수 $k := D.R.k$는 `Formalism/SharpRestriction/InertJacobiLevels/AsmIface.lean:142-144`에 의해 다음 구간으로 엄격히 고정됩니다.

$$
\sqrt{x\,\delta_1} \le m \le 2\sqrt{x\,\delta_1}, \qquad x^{2 + 8\varepsilon} \le n \le 2\,x^{2 + 8\varepsilon}, \qquad x^{\frac{9}{2} + 10\varepsilon} \le k \le 2\,x^{\frac{9}{2} + 10\varepsilon}
$$

여기서 $\delta_1 > 0$은 고정된 밀도 상수이므로 사슬 길이 $m$은 정확히 $\Theta(\sqrt{x})$ 척도를 갖습니다.

#### 제2단계: 유니터리 에르미트 사슬과 단계별 랄리스 스칼라 작용 (`Formalism/LocalToGlobal/IndefiniteReal/BaseLiftsPackageOfPrimitiveLinks.lean:68-73`)
고정된 홀수 차수 보폭 $t := P.t$에 관해 총실수체 $F$ 위의 완전 정부호(totally definite) 에르미트 공간 열

$$
X_0 \longrightarrow X_1 \longrightarrow \cdots \longrightarrow X_j \longrightarrow X_{j+1} \longrightarrow \cdots \longrightarrow X_m
$$

(`Formalism/SharpRestriction/Divisibility/FunctionModelRallisFromInputs.lean:577-581`, $\mathrm{rk}_E(X_{j+1}) = \mathrm{rk}_E(X_j) + (t + 1)$, 비트 지수 $\mathrm{wittIdx}(X_j) = 0$)과 부정형 동반 열 `Yc D i`(`Formalism/LocalToGlobal/IndefiniteReal/LinksStage.lean:240`)를 고려합니다. 각 연결고리 $j \in \{0, \dots, m-1\}$에서 아델 유니터리 군 $U(X_j)(\mathbb{A}_F) \times U(X_{j+1})(\mathbb{A}_F)$ 위의 베유 표현(Weil representation)과 시험 벡터 $\Phi_j \in \mathcal{S}(X_j \otimes X_{j+1})(\mathbb{A}_F)$(`Formalism/LocalToGlobal/IndefiniteReal/DatumVec.lean:84-105`)는 적분 세타 리프트 연산자

$$
\theta_{j, t} : \mathcal{A}_{\mathrm{cusp}}\left(U(X_j)\right) \longrightarrow \mathcal{A}_{\mathrm{cusp}}\left(U(X_{j+1})\right), \qquad \left(\theta_{j,t} f\right)(h) := \int_{[U(X_j)]} \Theta_{\Phi_j, \mu_{j+1}}(g, h)\, \overline{f(g)}\, dg
$$

를 정의합니다(완전 정부호성 $\mathrm{wittIdx}(X_j) = 0$에 의해 `ThetaCuspidalityCondition`, `Formalism/SharpRestriction/Divisibility/FunctionModelRallisFromInputs.lean:527-528`에서 모든 보형 형식은 자동으로 첨점 형식 `X.cusp V = ⊤`이 됩니다). 이때 `Formalism/LocalToGlobal/IndefiniteReal/BaseLiftsPackageOfPrimitiveLinks.lean:68-70`의 명제 `PThmA`는 각 단계 $j$의 수반 결합 연산자 $\theta_{j,t} \circ \theta_{j,t}^*$가 지정된 국소-전역 헤케·$K$-유형 고유공간 $W_{j, p, v_0}$ 위에서 양의 스칼라 배수로 작용함을 진술합니다.

$$
\left.\left(\theta_{j, t} \circ \theta_{j, t}^*\right)\right|_{W_{j, p, v_0}} = \lambda_{j, t, p, v_0} \cdot \mathrm{id}_{W_{j, p, v_0}}, \qquad \lambda_{j, t, p, v_0} > 0
$$

#### 제3단계: $m$중 합성 그람 연산자 고유값 적층 (`thmBop_of` 및 `DetChain`)
이제 $0$번째 기저 공간에서 출발해 $m$개의 원시 연결고리를 연속으로 합성한 전역 리프트 연산자 $\Theta_t := \theta_{m-1, t} \circ \cdots \circ \theta_{1, t} \circ \theta_{0, t}$를 구성합니다. `Formalism/LocalToGlobal/IndefiniteReal/BaseLiftsPackageOfPrimitiveLinks.lean:71-73`의 `PThmB`와 정리 `prod_lamN`(`:110-125`), 그리고 `thmBop_of`(`:184-196`)는 단계별 등거리 사상 조건과 위상 소거 정리 `phase_cancel`(`:130-161`)을 재귀적으로 결합하여, 종단 부분공간 $E_{p, v_0}$의 임의의 원소 $e$ 위에서 합성 그람 연산자 $\Theta_t \circ \Theta_t^*$가 정확히 $m$개 단계 고유값들의 곱으로 작용함을 증명합니다.

$$
\left(\Theta_t \circ \Theta_t^*\right)(e) = \left(\kappa \prod_{j=0}^{m-1} \lambda_{j, t, p, v_0}\right) e
$$

더 나아가 직합 분해 $E = \bigoplus_{s \in \sigma} E_s$ 및 $W_j = \bigoplus_{s \in \sigma} W_{j,s}$ ($\dim W_{j,s} = \dim E_s$) 위에서 각 단계 연산자가 블록별 스칼라 작용 $B_j|_{W_{j,s}} = \lambda_{j,s}\,\mathrm{id}$를 갖고 합성 연산자가 $A|_{E_s} = (\kappa \prod_j \lambda_{j,s})\,\mathrm{id}$로 주어질 때, `Formalism/ThetaLiftIndependence/Statement.lean:266-277`(`301`줄, `in_degree = 19`, `dist = 9`)의 명제 `DetChain`은 합성 그람 연산자 $A$의 행렬식이

$$
\det(A) = \kappa^{\dim_{\mathbb{k}} E} \prod_{j=0}^{m-1} \det(B_j)
$$

로 분해됨을 확립합니다. 즉 연결고리 $U(X_j) \to U(X_{j+1})$를 한 단계 통과할 때마다 중심 $L$-값 및 국소 부피 비율에서 기인하는 보형 이득 인자 $\lambda_{j, t, p, v_0}$가 지수 위에 $+1$겹씩 정확히 $m$번 쌓여 $\prod_{j=0}^{m-1} \lambda_j \asymp \Lambda_{\mathrm{gain}}^m$ 크기의 곱셈적 증폭을 만들어냅니다.

#### 제4단계: 무미분 단축 평가 관계식 `ShortValAt`와의 결합 (`Formalism/LocalToGlobal/ProjectiveLattices/ThShort.lean:244-262`)
마지막으로 종단 공간 $U(X_m)$에 도달한 보형 형식 $\Theta_t(f_0)$를 특수 CM 점 주기(CM cycles) 위에서 평가할 때, `Formalism/LocalToGlobal/ProjectiveLattices/ThShort.lean:244-262`의 `ShortValAt`는 아벨 스킴 위 조화 다항식 $P \in \mathrm{harmL}(\Lambda, a)$에 관한 **충실 평탄(faithfully flat) 기저변환 관계식(`Prop`)**으로서, 확장 대수 $\varphi : S \to S'$ 위에서 평가값 $v \in S$가 네 정규화 역원($\beta^{-1}$, 격자 지수 $\mathrm{mIdx}_N(\Lambda)^{-1}$, 레벨 몫 기수 $|\mathrm{LevQ}^n|^{-1}$, 차수 척도 $N^{-\deg P}$)과 유한 지지 합 등식

$$
\varphi(v) = \iota_{S'}\!\left(\beta^{-1} \cdot \mathrm{mIdx}_N(\Lambda)^{-1} \cdot |\mathrm{LevQ}^n|^{-1} \cdot N^{-\deg P}\right) \sum_{q}^{\mathrm{f}} \iota_{S'}(w_q) \sum_{i} \sum_{m \in \mathrm{supp}(P)} \iota_{S'}(P_m) \prod_{b} \nabla_{y'}\!\left(N^2, F_{q,i,b}, \mathrm{col}_m(b)\right)
$$

을 만족함을 규정합니다. 여기서 $\nabla_{y'}$는 기하적 가우스-마닌/마아스-시무라 접속층(고정된 유한 차수 $\deg P$)에서만 작동하며, 유리수 소수 $p$ 방향으로 고계 도함수를 취하지 않습니다. 대신 소수점 개수를 압도하는 $\Theta(\sqrt{x})$차 중복도는 전적으로 앞선 $m$단계 유니터리 세타 사슬의 고유값 곱 $\prod_{j=0}^{m-1} \lambda_j$와 아라켈로프 선다발 차수 하한에서 공급됩니다. 이것이 정수환 $\mathbb{Z}$ 위에서 미분 없이 작동하는 보형 스테파노프 중복도의 정확한 Lean 4 구현 메커니즘입니다.

위 4단계 구성을 기저 단계($j = 0$)부터 종단 평가 단계($j = m$)까지 단계별 공간·연산자·누적량 대응표로 집약하면 아래와 같습니다.

| 사슬 단계 색인 | 대상 에르미트 공간 및 군 | 적용 연산자 및 시험 벡터 | 단계별 산출 고유값 및 누적량 | 전담 검증 모듈 및 행 번호 |
| :--- | :--- | :--- | :--- | :--- |
| **기저 ($j = 0$)** | $X_0$ ($\mathrm{rk}_E X_0 = k$, 완전 정부호) | 초기 기약 첨점 부분공간 $\pi_0 \le \mathcal{A}_{\mathrm{cusp}}(U(X_0))$ | 기저 링크 `IsLink X P 0 π_0` 및 비영 벡터 $f_0 \in \pi_0$ | `Formalism/SharpRestriction/Divisibility/FunctionModelRallisFromInputs.lean:507-533` |
| **일반 단계 ($0 \le j < m$)** | $U(X_j) \times U(X_{j+1})$ ($\Delta \mathrm{rk} = t + 1$) | 순수 텐서 $\Phi_j$ (`IsStepVecOf`) 및 $\theta_{j, t}$ | 단일 단계 스칼라 $\lambda_{j, t, p, v_0} > 0$ (`PThmA`, 중복도 $+1$ 추가) | `Formalism/LocalToGlobal/IndefiniteReal/DatumVec.lean:84-105` |
| **부정형 시소 쌍 ($j$)** | `(Vc D j, Wc D j)` 및 `Yc D j` | 프레임-비트 확장 `extB` 및 시소 변환 `vth` | 페테르손·베셀 주기 비소멸 전이 `PerNZ` (`stmt2c`) | `Formalism/LocalToGlobal/IndefiniteReal/LinksStage.lean:109-290` |
| **$m$단 합성 ($j = m$)** | 종단 정부호 공간 $U(X_m)$ ($m \asymp \sqrt{x}$) | 합성 리프트 $\Theta_t = \theta_{m-1, t} \circ \cdots \circ \theta_{0, t}$ | 곱 고유값 $\kappa \prod_{j=0}^{m-1} \lambda_{j, t, p, v_0}$ (`thmBop_of`) 및 `DetChain` | `Formalism/LocalToGlobal/IndefiniteReal/BaseLiftsPackageOfPrimitiveLinks.lean:184-348` |
| **특수점 평가** | 사영 아벨 스킴 $X_o$ 및 격자 $\Lambda$ | 정규화 평가 `ShortValAt` ($N^{-\deg P}$ 척도) | 무미분 비영 대수적 정수비 $\alpha \ne 0$ (`shortNe0_of_t4Span`) | `Formalism/LocalToGlobal/ProjectiveLattices/ThShort.lean:244-349` |

---

## 제3장. 제2기둥 `Formalism.SharpRestriction` 심층 해부 (`3,093`개 파일 · `709,436`줄 · `33,822`개 정리)

### 3.1 하위 `13`개 서브패키지 계층 분해와 기능 배선

제2기둥 `Formalism.SharpRestriction`은 `3,093`개 파일, `709,436`줄, 정리·보조정리 `33,822`개, 정의·구조체 외 `20,826`개(선언 총계 `54,648`개)로 구성됩니다.
제1기둥 `LocalToGlobal`이 $m \approx \sqrt{x}$ 단계의 보형 리프트 사슬을 위로 쌓아 올리는 건설자라면, 제2기둥 `SharpRestriction`은 고계 유니터리 군의 보형 형식을 작은 부분군 및 CM 주기로 제한(restriction)할 때 발생하는 **첨점 생성 공간의 그람 행렬 작용소 노름(`CuspSpanNormBounds`·`GlobalSchurBounds`)과 $p$-진 갈루아 코사이클·다면체 높이 오차(`LevelLetterCocycles`·`ValuationFrobeniusEpsilon`)를 날카로운 지수 상한으로 가두는 제어기**입니다.

`13`개 하위 서브패키지의 정량 지표와 전담 수학 영역은 아래 표와 같습니다.

| 순위 | 하위 서브패키지 (`Formalism/SharpRestriction/*`) | 파일 수 | 코드 줄 수 | 정리 (`thm+lem`) | 정의·구조체 외 | 전담 수리 엔진 및 핵심 역할 |
| ---: | :--- | ---: | ---: | ---: | ---: | :--- |
| `1` | **`GrowthBounds`** | `1,210` | `231,225` | `11,586` | `4,555` | 매개변수 창 `(m, n, k, j0)`에서의 지수 성장률 비교 및 주항-오차항 분리 |
| `2` | **`LevelLetterCocycles`** | `758` | `170,849` | `7,138` | `3,626` | 국소 갈루아 코호몰로지(`LocCoh`), 바흐-헤르 격자(`DataNLoc`), 관성 특성다항식(`TameType`) |
| `3` | **`CuspSpanNormBounds`** | `399` | `132,978` | `6,418` | `4,749` | 재귀 코커널 제곱합(`Kk_succ`), 사영 푸앵카레 그람 분해(`RelevantZeroGramTerms`), C*-슈어 다리 |
| `4` | **`Divisibility`** | `274` | `63,162` | `2,670` | `3,220` | 차트 독립 생성원 유일성(`ThExprUniqOfChartIndep2`), 슈어 기약성(`SchurIrreducible`), 랄리스 모형 |
| `5` | **`GlobalSchurBounds`** | `158` | `48,032` | `2,399` | `2,338` | 유니터리 형식차수(`ThickPlacesCorollaryOfAnyTranslate`), 속 질량 부피(`GenusMassVolumes`), `TieGlobal` |
| `6` | **`GenusPolyhedralBounds`** | `88` | `27,878` | `1,718` | `600` | 에르미트 속(genus) 내 격자점의 다면체 절단 합 및 에르하르트 부피 상한 |
| `7` | **`RamificationFrobenius`** | `42` | `10,366` | `783` | `243` | 분지 프로베니우스 동치류 분포 및 호스트 명시 공식 오차(`ExplicitFormulaErrorOfHostConditions`) |
| `8` | **`ValuationFrobeniusEpsilon`** | `39` | `9,947` | `270` | `971` | 3차 유니터리 갈루아 변형 환 `S3hat`의 가우스·비분해 높이 상한(`UnitaryThreeHeightBounds`) |
| `9` | **`InertJacobiLevels`** | `48` | `6,911` | `398` | `303` | 비분해 야코비 수준 깊이 $j_0$ 및 상수 어셈블리 인터페이스(`AsmIface`) |
| `10` | **`AdmissibleParameterJoins`** | `51` | `6,068` | `343` | `63` | 다중 소수 자리·레벨 매개변수의 허용 가능 교집합 비공집합성 검증 |
| `11` | **`(root)` 최상위 공통부** | `10` | `1,005` | `51` | `134` | 전역 허용 창 `FamP` 및 미소 매개변수 경계 $\varepsilon < 1/52$ 선언(`ParConsts`) |
| `12` | **`SmoothDesignExistence`** | `15` | `1,002` | `48` | `23` | 매끄러운 구면·유니터리 가중 설계(smooth design) 존재성 구성 |
| `13` | **`AbelianModels`** | `1` | `13` | `0` | `1` | 아벨 모형 기본 타입 별칭 |
| **합계** | **`SharpRestriction` 전수 (`13`종)** | **`3,093`** | **`709,436`** | **`33,822`** | **`20,826`** | **선언 총계 `54,648`개 (`Main.lean` 최단 거리 `dist = 6`~`43`)** |

특히 `ValuationFrobeniusEpsilon` 서브패키지의 핵심 파일인 `Formalism/SharpRestriction/ValuationFrobeniusEpsilon/UnitaryThreeHeightBounds.lean:29-140`(`982`줄, `dist = 15`)을 열람하면 $U(3)$ 갈루아 리프팅 문제 `UnitaryThreeLiftingProblem`(`:29-82`)이 정밀하게 정의되어 있습니다.
이 구조체는 완비 국소환 동형 $e_S : Q.\widehat{A}.C \simeq V.\widehat{S}_3(l, e, \chi, K, g_1)$(`:77`)과 8개의 대칭·노름 관계식 위치표 `posTab`(`:22`)을 부여한 뒤, 가우스 소수 분해 사례(`GaussianCaseHeightBound`, `:119-128`)와 비분해 사례(`InertCaseHeightBound`, `:129-138`)에서 변형 가군 길이 `V.Vlen l e χ`의 $l$-진 부치 상한을 다음과 같이 확립합니다.

$$
\begin{aligned}
\text{가우스 분해 사례:} \quad & \sum_{\chi'' \sim \chi} \mathrm{Vlen}(l, e, \chi'') \le 2\, v_l\left(\mathrm{N}_{\mathbb{Q}(i)/\mathbb{Q}}(\mathrm{NN})\right), \\
& \log \|\mathrm{NN}\|_{\mathbb{C}} \le C_1 \, \deg_{\mathbb{Q}}(\chi)\, \mathrm{cond}(V)^{18}\, e^7 \log p, \\
\text{비분해(inert) 사례:} \quad & \mathrm{Vlen}(l, e, \chi)\,\log l \le C_2 \, |d_K|^6 \, \deg_{\mathbb{Q}}(\chi)\, \mathrm{cond}(V)^{18}\, e^7 \log\log\left(\mathrm{cond}(V)\,l\right)
\end{aligned}
$$

지수 $\mathrm{cond}(V)^{18} e^7$과 판별식 거듭제곱 $|d_K|^6$(`bD = 6`, `Formalism/SharpRestriction/ValuationFrobeniusEpsilon/UnitaryThreeHeightBounds.lean:137`)이 이처럼 명시적인 다항식 지수로 고정되어 있기 때문에, 뒤이은 전역 창 조립에서 모든 오차 상수가 $x^\varepsilon$ 안으로 흡수됩니다.

---

### 3.2 최다 피참조 핵심 허브 `12`선 원문 직독 및 수식 역컴파일

`SharpRestriction` 내부 피참조 최상위 12개 필수 허브 모듈의 정량 지표와 원문 역컴파일 결과는 다음과 같습니다.

| 순위 | 허브 모듈 (`src/` 상대경로) | 줄 수 | `in_deg` | `dist` | 대표 선언 및 핵심 수리 내용 |
| ---: | :--- | ---: | ---: | ---: | :--- |
| `1` | `Formalism/SharpRestriction/Divisibility/GeneratorPowers/ThExprUniqOfChartIndep2.lean` | `41` | `873` | `9` | `ChartIndepSt2`, `thExprUniq_of_chartIndep2` ($p^k$ 격자 이동 계수 유일성) |
| `2` | `Formalism/SharpRestriction/LevelLetterCocycles/LocCoh.lean` | `195` | `654` | `7` | 블로흐-카토 결정/드람 코호몰로지 핵 `bkACore`, `bkBCore`, `LocalTateTopDegree` |
| `3` | `Formalism/SharpRestriction/LevelLetterCocycles/LocalSituation.lean` | `641` | `627` | `7` | 30개 필드 $p$-진 갈루아 리프팅 상황 `Sit`, `LocalLiftingUniformConstant` |
| `4` | `Formalism/SharpRestriction/CuspSpanNormBounds/FractionFieldToGenericStalkAlgebraMapEq.lean` | `282` | `400` | `9` | 국소 분해 베셀 모형 `Model`, 재귀 코커널 제곱합 전개 `Kk_succ` |
| `5` | `Formalism/SharpRestriction/Divisibility/SchurIrreducible.lean` | `617` | `377` | `7` | 블라트너 매개변수 `DiscreteSeriesBlattner`, `ArchimedeanRallisLocal` |
| `6` | `Formalism/SharpRestriction/ParConsts.lean` | `103` | `224` | `7` | 무이득 기준 `NoGain`, 36개 필드 가족 `FamP`, 허용 범위 `DFamP`(`eps < 1/52`) |
| `7` | `Formalism/SharpRestriction/CuspSpanNormBounds/RelevantZeroGramTerms.lean` | `573` | `201` | `7` | 사영 푸앵카레 그람 연산자 `Kmat`, `RelevantZeroGramTerms`, `famNG`, `famG` |
| `8` | `Formalism/SharpRestriction/InertJacobiLevels/AsmIface.lean` | `221` | `191` | `7` | 상수 묶음 `FC`, 5진 깊이 `j0`, 수치 창 `NumAt`, 그림자 인터페이스 `Shd` |
| `9` | `Formalism/SharpRestriction/GlobalSchurBounds/ThickPlacesCorollaryOfAnyTranslate.lean` | `2,354` | `189` | `7` | `formalDegreeBound_all_unitaryGroups`, `volumeMass_of_unfolding` |
| `10` | `Formalism/SharpRestriction/LevelLetterCocycles/DataNLoc.lean` | `1,260` | `188` | `7` | 바흐-헤르 $(\varphi, \Gamma)$-격자 `LocLat`, 잉여 격자 `resLat`, 호지 가중치 `LocHW` |
| `11` | `Formalism/SharpRestriction/GlobalSchurBounds/GeneralLinearActions/GenusMassVolumes.lean` | `399` | `183` | `7` | 에르미트 판별식·하르·기본영역 측도 정합 `SdW`, `SdR`, `SdHerm`, `IsXbetaMeasure` |
| `12` | `Formalism/SharpRestriction/LevelLetterCocycles/ExistsInertiaCharpolyFactorOfTameType.lean` | `1,739` | `172` | `8` | `brauerNesbitt_matrix`, `heckePol_coeff_mem`, 완만 관성 특성다항식 인수분해 |

12개 허브 각각의 원문 정의와 증명 구조를 차례로 해부합니다.

#### (1) `ThExprUniqOfChartIndep2.lean` (`in_degree = 873`) - 아카이브 신작 전체 피참조 2위 허브의 대수적 정체
`Formalism/SharpRestriction/Divisibility/GeneratorPowers/ThExprUniqOfChartIndep2.lean:12-40`(`41`줄)은 단 하나의 명제 정의 `ChartIndepSt2`(`:12-23`)와 단 하나의 정리 `thExprUniq_of_chartIndep2`(`:24-40`)만으로 `873`개 모듈의 직접 임포트를 받는 초고밀도 기초 허브입니다.
그 수리적 내용은 아벨 다양체 세타 단면의 국소 좌표 차트 변환에서 발생하는 소수 거듭제곱 이동 격자의 유일성입니다.
구체적으로 소수 $p$(`hp : Nat.Prime p`)와 거듭제곱 $p^k$에 관해 잔차 이동 지표가 $h_0 \equiv h_0' \pmod{p^k}$ 조건 아래 등식

$$
h_0 + d \cdot p^k = h_0' + d' \cdot p^k \quad (0 \le h_0, h_0' < p^k)
$$

을 만족하면 $h_0 = h_0'$이고 $d = d'$임을 `ZMod.natCast_eq_natCast_iff'`와 `Nat.mod_eq_of_lt`, `Nat.mul_right_cancel (Nat.pow_pos hp.pos)`를 결합하여 증명합니다(`Formalism/SharpRestriction/Divisibility/GeneratorPowers/ThExprUniqOfChartIndep2.lean:24-40`).
차트 독립성 조건 `ChartIndepSt2`가 주어지면 세타 생성원 거듭제곱 전개식의 정수 계수가 국소 완비화 차트 선택과 무관하게 유일하게 결정되므로, `Divisibility`와 `LocalToGlobal` 전반의 `873`개 가분성 보조정리가 이 정리를 기준점으로 호출합니다.

#### (2) `LocCoh.lean` (`in_degree = 654`), `LocalSituation.lean` (`in_degree = 627`), `DataNLoc.lean` (`in_degree = 188`), `ExistsInertiaCharpolyFactorOfTameType.lean` (`in_degree = 172`) - $p$-진 갈루아 변형과 완만 관성 인수분해 4중주
`LevelLetterCocycles` 서브패키지의 4대 허브는 보형 갈루아 표현 $\rho_{\pi, \lambda}$의 국소 분지 및 셀머(Selmer) 군 차원을 통제합니다.

1. **`LocCoh.lean`**: `Formalism/SharpRestriction/LevelLetterCocycles/LocCoh.lean:21-192`는 국소체 위 갈루아 표현 `GRep`(`:36-52`)에 관해 드람(de Rham) 성질 `IsDR`(`:21-24`), 원분 뒤틀림 `IsTwistRep`(`:60-63`), 1차 코호몰로지 쌍대 격자 `IsDualLat1`(`:87-90`), 1-코바운더리 `CobO`(`:140-142`)를 정의하고, 블로흐-카토 부분군 핵 `bkACore`(`:154-160`)·`bkBCore`(`:161-170`), 국소 테이트 최고차 쌍대성 `LocalTateTopDegree`(`:171-176`), 테이트 유한성 `TateFiniteness`(`:182-186`), 드람 쌍대성 `drDualCore`(`:187-192`)의 6대 코호몰로지 공리계를 정립합니다.
2. **`LocalSituation.lean`**: `Formalism/SharpRestriction/LevelLetterCocycles/LocalSituation.lean:28-79`의 거대 구조체 `Sit`는 잉여 표수 $p$, 분지 지수, 국소 갈루아 군 $G_K$, 관성군 $I_K$, 야생 관성군 $P_K$, 프로베니우스 원소와 표현 행렬을 30개 필드로 묶고, 최하단 `LocalLiftingPackage`(`:635-637`) 및 `LocalLiftingUniformConstant`(`:638-640`)에서 잉여 표현의 변형 환 리프팅이 균일한 상수 한계 안에서 존재함을 보증합니다.
3. **`DataNLoc.lean`**: `Formalism/SharpRestriction/LevelLetterCocycles/DataNLoc.lean:12-1259`는 $p$-진 호지 이론의 바흐-헤르(Wach-Herr) $(\varphi, \Gamma)$-가군 격자 `LocLat`(`:12-30`)와 문자 알파벳 `LetA`(`:52-53`, $(\mathcal{E}, \pi, \varphi, \gamma)$ 데이터), 잉여 격자 `resLat`(`:76-83`)를 정의한 뒤, 최하단에서 국소 호지 가중치 구조체 `LocHW`(`:1227-1237`), 폰테인 환 사상 `LocFon`(`:1238-1240`), 결정 비교 동형 `LocCmpT`(`:1241-1244`)를 완성합니다.
4. **`ExistsInertiaCharpolyFactorOfTameType.lean`**: `Formalism/SharpRestriction/LevelLetterCocycles/ExistsInertiaCharpolyFactorOfTameType.lean:15-1738`은 비분지 소수들의 프로베니우스 대각합 정보를 완만 분지(tame ramification) 자리의 관성군 특성다항식 인수분해로 전달하는 보형-갈루아 가교 파일입니다.
   - 먼저 `ss_of_isSSRep`(`:18-28`)와 `brauerNesbitt_matrix`(`:29-56`)에서 체 위의 두 반단순(semisimple) 행렬 표현 $\rho_1, \rho_2 : G \to \mathrm{GL}_n(L)$이 모든 $g \in G$에서 $\mathrm{Tr}\,\rho_1(g) = \mathrm{Tr}\,\rho_2(g)$를 만족하면 야코브슨 조밀성 및 요르당-횔더 단순 인자 유일성에 의해 모든 원소의 특성다항식 $\det(X I_n - \rho_1(g)) = \det(X I_n - \rho_2(g))$가 일치함을 증명합니다.
   - 이어서 `closed_of_adic`(`:73-118`)과 `heckePol_coeff_mem`(`:122-140`)에서 $\mathfrak{m}$-진 완비 정수환 $\mathcal{O}_\lambda$의 위상적 닫힘성을 이용해 조밀한 비분지 프로베니우스 원소 집합에서 성립하는 헤케 특성다항식 합동식이 완만 관성 생성원 $\tau \in I_w / P_w$로 연속 확장됨을 보이고, 최하단 `galois_clause_of_sufficient`(`:1736-1738`)에서 완만 관성 유형의 선형 인수 분리를 완결합니다.

#### (3) `ParConsts.lean` (`in_degree = 224`) 및 `AsmIface.lean` (`in_degree = 191`) - 전역 매개변수 창 `FamP`와 5진 레벨 깊이 $j_0$
`Formalism/SharpRestriction/ParConsts.lean:19-100`은 아카이브 전체의 점근 오차 예산을 통괄하는 헌법 파일입니다.
특히 `Formalism/SharpRestriction/ParConsts.lean:31-98`의 구조체 `FamP (eps : ℝ)` 내부를 직독하면, 수치 상수의 부동소수점 이탈이나 색인 간 불일치를 원천 차단하기 위해 하드코딩된 정수 상수들과 색인 불변성(`i, i' : Ix x`) 제약들이 아래 표와 같이 선언되어 있습니다.

| 필드명 (`ParConsts.FamP`) | 행 번호 | 원문 수식 및 고정 상수 명세 | 점근 오차 예산 내 역할 |
| :--- | ---: | :--- | :--- |
| `params_K` / `parT_K` | `33-41` | `parConsts (params x hx i) = PK` (`23`개 실수 상수 리스트 고정) | 모든 $x > x_1$ 및 색인 $i$에서 보조 상수들이 $x$와 무관한 상수 벡터 `PK`, `PT`임을 강제 |
| `supp_sat` / `tw_supp` | `57-61` | `resChar w ≤ X'' n → w ∈ supp` 및 `muAt w ≠ mu0 → w ∈ supp` | 임계 크기 이하의 모든 소수 자리와 보조 지표 뒤틀림 자리를 유한 지지집합 `supp`에 포섭 |
| `h_eq` | `73` | `(D x i).div.h u = DV.hExpl6 (D x i) (L x i) (X x i) Csz u` | 아라켈로프 인자 높이 함수를 명시적 6항 높이 공식 `hExpl6`과 등식 결합 |
| `rho_le` | `79-80` | `G.rhoB (D x i) GK (L x i).sc ≤ x ^ (-2 : ℝ)` | 상대 밀도 변동 폭 $\rho_B$를 $x^{-2}$ 이하로 눌러 이차 오차항을 완전 소거 |
| `drop_iff` | `83-84` | `p ∈ (L x i).drop ↔ NoGain (Gx x i) GK Cr p ∧ ∀ u, p ≠ A.T` | 체(sieve)에서 버리는 예외 소수 집합 `drop`을 정확히 무이득(`NoGain`) 소수로 한정 |
| `fixed` | `86-87` | `Pr1=1, dl1=5, dl2=4, Ce=1, c6=12, dig=3, Cr=1, CnW=10, 12≤eP` | 9개 핵심 조합·자릿수·차수 상수를 리터럴 정수로 직접 못 박아 상수 순환성 차단 |
| `eta_eq` ~ `ep_eq` | `89-97` | `etaSz`, `Sc`, `hP`, `bs`, `off`, `kapI`, `ep`의 `i, i' : Ix x` 불변성 | 동일 척도 $x$ 내 서로 다른 패밀리 가지 `i, i'` 사이의 게이지·오프셋 완전 동기화 |
| `DFamP` | `99-100` | `∀ ε : ℝ, 0 < ε → ε < 1 / 52 → FamP ε` | 미소 매개변수 허용 열린 구간 $(0, \frac{1}{52})$ 확정 |

이와 짝을 이루는 `Formalism/SharpRestriction/InertJacobiLevels/AsmIface.lean:10-218`은 상수 리스트 레코드 `PC`(`:10-34`), `PTC`(`:40-48`), `FC`(`:51-69`)와 수치 창 검증 구조체 `NumAt`(`:120-145`)를 정의합니다.
특히 `Formalism/SharpRestriction/InertJacobiLevels/AsmIface.lean:139`는 비분해 야코비 수준 깊이 $L.j_0$를 밑이 $5$인 로그의 올림 정수로 고정합니다.

$$
j_0 := \left\lceil \frac{\log\left(n \cdot N(m) / m\right)}{\log 5} \right\rceil_+
$$

밑이 $5$로 선택된 이유는 제3.3절에서 다룰 5진 야코비 수준 가지치기와 일반 계수 유니터리 지겔-베유 부피비 구조와 직결됩니다.

#### (4) `SchurIrreducible.lean` (`in_degree = 377`), `GenusMassVolumes.lean` (`in_degree = 183`), `ThickPlacesCorollaryOfAnyTranslate.lean` (`in_degree = 189`)
아르키메데스 및 전역 측도 정규화를 담당하는 3대 허브입니다.
- `Formalism/SharpRestriction/Divisibility/SchurIrreducible.lean:20-614`는 이산계열의 최저 $K$-유형 블라트너(Blattner) 매개변수 `DiscreteSeriesBlattner`(`:74-81`)와 올림·내림 작용소 핵 `lowKer`(`:38-42`), `raised`(`:43-48`)를 정의하고, 국소 아르키메데스 랄리스 내적 공식 `ArchimedeanRallisLocal`(`:613-614`)을 출력합니다.
- `Formalism/SharpRestriction/GlobalSchurBounds/GeneralLinearActions/GenusMassVolumes.lean:11-396`은 CM 확대 $E/F$ 위의 비퇴화 에르미트 형식 `IsHermND`(`:22-24`)에 관해 베유 측도 `SdW`(`:353-356`), 실수 자리 측도 `SdR`(`:357-360`), 에르미트 궤도 측도 `SdHerm`(`:361-364`), 푸리에-베셀 궤도 측도 `IsXbetaMeasure`(`:365-389`) 사이의 정규화 정합성 `IsCompatible`(`:390-396`)을 정의합니다.
- `Formalism/SharpRestriction/GlobalSchurBounds/ThickPlacesCorollaryOfAnyTranslate.lean:17-2353`(`2,354`줄)은 이 기둥 최대 규모의 증명 파일 중 하나로, 순감소 하리시-찬드라 매개변수 열의 반복 상한 양수성 `harishChandraAbs_pos_of_strictAnti`(`:2251-2260`)로부터 모든 유니터리 군에 걸친 형식차수 상하한 정리 `formalDegreeBound_all_unitaryGroups`(`:2261-2312`) 및 `familyFormalDegree_all`(`:2317-2321`)을 완결 증명하고, 최하단 `volumeMass_of_unfolding`(`:2342-2353`)에서 언폴딩 질량 비율을 확정합니다.

#### (5) `FractionFieldToGenericStalkAlgebraMapEq.lean` (`in_degree = 400`) 및 `RelevantZeroGramTerms.lean` (`in_degree = 201`)
첨점 형식 생성 부분공간의 그람 행렬 노름을 직접 계산하는 두 핵심 허브이며, 그 내부 방정식 체인을 아래 제3.3절에서 전수 복원합니다.

---

### 3.3 수리적 핵심 복원: 재귀 코커널 제곱합 `Kk_succ`, 일반 계수 유니터리 지겔-베유 질량비(`GL5/Statement.lean`), 그리고 무투영 C*-슈어 상한 체인

해석적 정수론에서 푸앵카레 급수(Poincaré series)들의 내적 행렬 $\langle P_u, P_{u'} \rangle$을 상한할 때, 전통적인 쿠즈네초프-페테르손 대각합 공식은 클루스터만 합(Kloosterman/Gauss sums)의 개별 복소 위상 상쇄(예: 베유 상한 $q^{1/2}$)에 의존합니다. 그러나 고계 유니터리 군의 다중 분지 레벨에서는 고차원 지수합의 퇴화 쌍곡선 특이점 때문에 점별 위상 상쇄만으로는 지수 손실을 막을 수 없습니다.

`SharpRestriction` 기둥이 이 난관을 돌파하기 위해 구축한 해법은 **개별 가우스 합의 부호 상쇄나 단독 $\mathrm{GL}_5$ 6중 메타플렉틱 피복군 정의 없이, 몫가군 코커널 동치류 위의 재귀 제곱합(`Kk_succ`), 일반 계수 유니터리 지겔-베유 속 질량·부피비(`GL5/Statement.lean`), 그리고 C*-대수 함수해석적 슈어 보조정리를 결합해 그람 행렬의 힐베르트-슈미트 및 작용소 노름을 순수 양수 $L^2$ 제곱합으로 압축하는 것**입니다. 원문 코드에 기록된 정확한 수식 체인은 다음 4단계로 구성됩니다.

#### 제1단계: 코커널 동치류 위의 재귀 베셀 핵 정의와 전개 보조정리 (`Kk_succ`)
`Formalism/SharpRestriction/CuspSpanNormBounds/FractionFieldToGenericStalkAlgebraMapEq.lean:42-260`은 비아르키메데스 국소체 확장 $E/F$ 위의 분해 모형 `Model F E`(`:42-47`), 정수환 부분환 $R := M.R \subseteq E$(`:52-60`), 가법 지표 $\psi_R : E \to \mathbb{C}^\times$(`:66-70`), 그리고 크기 $m+1$ 행렬들의 코커널 `M.Cok ZZ`(`:90-92`) 및 동형 동치류 집합 $\mathrm{Cls}_m(M) := M.\mathrm{Cls}\,m$(`:143`, 자기동형군 크기 $|\Aut(c)| = M.\mathrm{nAut}\,c$, `:145`)을 정의합니다.

하삼각·상삼각 멱단 행렬 $u_{\mathrm{Low}}(x)$(`:181-183`)와 $u_{\mathrm{Up}}(w, y)$(`:184-187`)에 관해 부분 베셀 적분 계수 $\mathrm{BB}(M; w, c) \in \mathbb{C}$(`:211-214`)를 도입한 뒤, 원문은 깊이 $i$의 재귀 핵 함수 $K_k := M.\mathrm{Kk}$(`:215-218`) 자체를 코커널 동치류 합으로 직접 정의하고 정의적 전개 보조정리 `Kk_succ`(`Formalism/SharpRestriction/CuspSpanNormBounds/FractionFieldToGenericStalkAlgebraMapEq.lean:254-256`, `:= rfl`)로 다음 등식을 기록합니다.

$$
K_{m+1}(w, w') = \sum_{c \in \mathrm{Cls}_m(M)} \frac{\mathrm{BB}(M; w, c)\,\overline{\mathrm{BB}(M; w', c)}}{|\Aut(c)|}
$$

특히 대각선 $w = w'$에서는

$$
K_{m+1}(w, w) = \sum_{c \in \mathrm{Cls}_m(M)} \frac{\left|\mathrm{BB}(M; w, c)\right|^2}{|\Aut(c)|} \ge 0
$$

이 되어 복소 진동항의 점별 상쇄를 추정할 필요 없이 하위 궤도 적분 일치 정리들이 유한 아벨 코커널 `M.Cok ZZ` 위의 양정치 제곱합에 직결됩니다. 비대각선 $w \ne w'$인 경우에도 즉시 코시-슈바르츠 부등식 $|K_{m+1}(w, w')|^2 \le K_{m+1}(w, w)\,K_{m+1}(w', w')$가 성립합니다.

#### 제2단계: 사영 푸앵카레 그람 행렬 `Kmat`의 5중 세포 분해 (`Formalism/SharpRestriction/CuspSpanNormBounds/RelevantZeroGramTerms.lean:335-524`)
`Formalism/SharpRestriction/CuspSpanNormBounds/RelevantZeroGramTerms.lean:335-377`은 단어 매개변수 $u, u' \in \mathrm{Word}$에 대응하는 첨점 부분공간 `s.Cu u` 위에서 정규화 상수

$$
c_0(u) := \frac{\mathrm{vol}_N(u)\,\mathrm{vol}_H(u)}{\dim \Pi(u)}, \qquad \dim \Pi(u) := \prod_{\tau} \dim \Pi_U\left(k, u_\tau\right)
$$

(`Formalism/SharpRestriction/CuspSpanNormBounds/RelevantZeroGramTerms.lean:335-337`)로 척도를 맞춘 사영 푸앵카레 그람 연산자 $K(u, u') := \mathrm{Kmat}(s, u, u') : \mathcal{C}_{u'} \to \mathcal{C}_u$(`:339-344`)를 급수 합 $\sum_t a_{u, u'}(t)$(`KExpansion`, `:345`)로 전개합니다. 그리고 브뤼아(Bruhat)·궤도 항 $t \in s.\mathrm{Term}(u, u')$ 전체를 상호 배타적인 5개 성분으로 정밀 분할합니다(`Formalism/SharpRestriction/CuspSpanNormBounds/RelevantZeroGramTerms.lean:351-376`).

$$
K(u, u') = K_{\mathrm{id}}(u, u') + K_2(u, u') + K_{\mathrm{NG}}(u, u') + K_{\mathrm{G, sc}}(u, u') + K_{\mathrm{G, loop}}(u, u')
$$

5개 그람 행렬 세포 각각의 원문 술어 정의, 전담 제어 수단, 그리고 노름 감쇠 메커니즘을 대조하면 아래 표와 같습니다.

| 그람 행렬 성분 | 원문 정의 (`RelevantZeroGramTerms.lean`) | 정의 조건 술어 | 전담 상한 정리 및 노름 억제 메커니즘 |
| :--- | :--- | :--- | :--- |
| **`1.` $K_{\mathrm{id}}(u, u')$** | `IdCellDiag`(`:372`), `IdCellOff`(`:375`) | $s.\mathrm{isId}(t)$ | 정규화 인자 $c_0(u)$에 의해 대각선 $u=u'$에서 $\mathrm{id}_{\mathcal{C}_u}$, 비대각선 $u \ne u'$에서 $0$ |
| **`2.` $K_2(u, u')$** | `RelevantZeroGramTerms`(`:351`), `K2`(`:366`) | $s.\mathrm{relevant}(t) \wedge s.\mathrm{Gterm}(t) = 0$ | 매끄러운 절단 `isCutoff_exists`(`:548-557`) 및 카펠리 간격 `capW`(`:536-541`)로 소거 |
| **`3.` $K_{\mathrm{NG}}(u, u')$** | `famNG`(`:353`), `KOf s u u' famNG` | $\neg s.\mathrm{isId}(t) \wedge s.\mathrm{Gterm}(t) \ne 0 \wedge \neg s.\mathrm{generic}(t)$ | `Formalism/LocalToGlobal/SiegelLatticeTheory/CokernelGLCounts/NGData.lean:43-125`의 코시-슈바르츠 비율 $\mathrm{a2C} = \|\mathrm{grpC}\|^2 / \mathrm{J2of}$로 상한 |
| **`4.` $K_{\mathrm{G, sc}}(u, u')$** | `famG`(`:355`) 내 `scalarP`(`:361`), `Kgs`(`:368`) | 일반항 쌍 중 대각 스칼라 결합 쌍 | `Formalism/SharpRestriction/CuspSpanNormBounds/FractionFieldToGenericStalkAlgebraMapEq.lean:254-256`의 재귀 코커널 제곱합 `Kk_succ` 직결 |
| **`5.` $K_{\mathrm{G, loop}}(u, u')$** | `famG`(`:355`) 내 `loopP`(`:357`) | 일반항 쌍 중 비대각 교차 루프 쌍 | 2유형 코시-슈바르츠 제곱평균 및 5진 깊이 $5^{-j_0}$ 부피 감쇠(`Formalism/SharpRestriction/InertJacobiLevels/AsmIface.lean:139`) |

각 성분의 집합 정의식을 원문 그대로 적으면 다음과 같습니다.
- **연관 영-그람 항 집합 (`:351`)**:
  $$\mathrm{RelevantZeroGramTerms} := \left\{ t \in s.\mathrm{Term}(u, u') \;\mid\; s.\mathrm{relevant}(t) \wedge s.\mathrm{Gterm}(t) = 0 \right\}$$
- **비일반 비영 그람 항 집합 (`:353`)**:
  $$\mathrm{famNG} := \left\{ t \in s.\mathrm{Term}(u, u') \;\mid\; \neg s.\mathrm{isId}(t) \wedge s.\mathrm{Gterm}(t) \ne 0 \wedge \neg s.\mathrm{generic}(t) \right\}$$
- **일반(큰 브뤼아 세포) 항 집합 (`:355`)**:
  $$\mathrm{famG} := \left\{ t \in s.\mathrm{Term}(u, u') \;\mid\; \neg s.\mathrm{isId}(t) \wedge s.\mathrm{Gterm}(t) \ne 0 \wedge s.\mathrm{generic}(t) \right\}$$
  여기서 모든 주 소행렬식 `leadMinor`(`:235-237`)가 가역인 `famG` 내부의 곱집합 쌍 $(t_1, t_2) \in \mathrm{pairsIn}(\mathrm{famG})$(`:364`)이 `scalarP`와 `loopP`로 이분되어 위 표의 4번·5번 성분을 형성합니다.

#### 제3단계: `GL5` 폴더(`GenusMassVolumes`)의 실제 정체와 푸리에 감쇠 차수 $K = 5$ · 5진 깊이 결합 (`GL5/Statement.lean` 및 `AsmIface.lean`)
선언문 초안(`remark.pdf` 16번)은 초기 착안 배경으로 $\mathrm{GL}_5$ 6중 피복을 언급했으나, 실제 Lean 코드에서 `GL5`라는 디렉터리 이름을 가진 모듈군(`Formalism/LocalToGlobal/GlobalTheory/GL5/Statement.lean:14-147`, `148`줄, `dist = 9`)을 열람하면 메타플렉틱 6중 피복군은 전혀 정의되지 않으며 네임스페이스 역시 `Formalism.L2.GlobalTheoryTheory.GenusMassVolumes`입니다.
구체적으로 이 모듈은 일반 계수 유니터리 군의 `FamP eps` 가족 위에서 실수 자리 정합 `TiedRealF`(`:15-17`), 프레임 정합 `TiedFrameF`(`:28-30`), 베유-지겔 정리 `WeilSiegelCM`(`:31-38`) 및 미사용 슬롯 래퍼 `WeilSiegelGauge`(`:39-44`), 표준 격자 질량 비율 `MassRatioStd`(`:45-50`), 기본영역 부피비 `VolRatioTrue`(`:51-68`), 하리시-찬드라 형식차수 `HCFormalDegree`(`:69-75`), 란트헤르-하세 국소-전역 원리 `LandherrHasse`(`:76-81`), 그리고 5단 연결 명제 `LinkCount5`(`:137-140`)를 순수 유니터리 지겔-베유 질량 공식으로 결합합니다.
마찬가지로 제3기둥 `Formalism/HermitianCurvature/HermitianCurvatureProofs/TheoremPIntegralOfPlaces.lean:27`의 `(S.mkData Kr hK0 Th e).K = 5`는 아르키메데스 푸리에 감쇠 차수 정수 $K = 5$이며, 비대각 루프 쌍 `loopP` 제어는 코커널 제곱합 $|K_{m+1}|^2$과 5진 야코비 수준 깊이 $j_0 = \lceil \log_5(n N(m)/m)\rceil_+$(`Formalism/SharpRestriction/InertJacobiLevels/AsmIface.lean:139`)에 따른 부피 감쇠 인자 $5^{-j_0}$로 직접 완결됩니다.

#### 제4단계: C*-대수 함수미적분 슈어 보조정리와 전역 노름 마감 (`BridgeCSchur.lean` 및 `MainSup.lean`)
마지막으로 국소 제곱적분 가능 표현 공간 위에서 합성 적분 연산자가 스칼라 배수로 축약되고 힐베르트-슈미트 노름 `hsSqD u u'`(`Formalism/SharpRestriction/CuspSpanNormBounds/RelevantZeroGramTerms.lean:519`)가 연산자 노름을 지배함을 보이기 위해, `Formalism/SharpRestriction/CuspSpanNormBounds/BridgeCSchur.lean:18-630`(`635`줄, `in_degree = 29`, `dist = 9`)은 완비 힐베르트 공간 위의 연속 선형 작용소 C*-대수에서 비유계·유계 슈어 보조정리 `schur_selfAdjoint`(`:18-121`)와 `schur_bounded`(`:122-138`)를 스펙트럼 사영 없이 순수 함수해석(`CFC` 연속 함수 미적분)으로 직접 증명합니다.
이어서 이를 의사유니터리 군 `UJ ε`의 기약 제곱적분 표현 `SqRep`(`:146-152`)에 대입하여 슈어 직교 관계식 `schur_UJ`(`:611-625`)와 이산계열 형식차수 공식 `fdeg_of_DS`(`:626-630`)를 도출합니다.

$$
\int_{U_J(\varepsilon)} \langle \sigma(g) v_1, w_1 \rangle \, \overline{\langle \sigma(g) v_2, w_2 \rangle}\, d\mu(g) = \frac{\langle v_1, v_2 \rangle \, \overline{\langle w_1, w_2 \rangle}}{d(\sigma)}
$$

이 형식차수 $d(\sigma) = \mathrm{fdegOf}(\mu, \sigma)$(`Formalism/SharpRestriction/CuspSpanNormBounds/RelevantZeroGramTerms.lean:43-46`)에 `Formalism/SharpRestriction/GlobalSchurBounds/ThickPlacesCorollaryOfAnyTranslate.lean:2261-2312`의 균일 다항식 하한을 결합하면, `Formalism/SharpRestriction/GlobalSchurBounds/MainSup.lean:249-306`(`chosenProviso_sup`, `tuSize_thr`)에서 전체 사영 그람 행렬의 상한이 마감되고 `Formalism/SharpRestriction/GlobalSchurBounds/TieGlobal.lean:116-124`(`ChainTied.core_of`)를 거쳐 전역 상수 고리가 닫힙니다.

위 제4단계의 두 핵심 증명 파일(`BridgeCSchur.lean`과 `ThickPlacesCorollaryOfAnyTranslate.lean`)이 커널 내부에서 실제로 수행하는 전술 연역 과정을 해부하면 다음과 같습니다.

1. **`Formalism/SharpRestriction/CuspSpanNormBounds/BridgeCSchur.lean:18-138`의 무투영 C*-함수미적분 슈어 보조정리 증명**:
   무한차원 힐베르트 공간 $H$ 위의 기약 유니터리 표현 $\sigma$와 가환인 자기수반 유계 작용소 $T \in (H \to_L H)$(`IsSelfAdjoint T`)가 스칼라의 상수배임을 보일 때, 전통적 증명은 보렐 스펙트럼 측도(spectral projection) 구성을 필요로 합니다.
   반면 `schur_selfAdjoint`(`Formalism/SharpRestriction/CuspSpanNormBounds/BridgeCSchur.lean:18-121`)는 `Mathlib`의 연속 함수 미적분(`cfc : (ℝ → ℝ) → (H →L[ℂ] H) → (H →L[ℂ] H)`)만을 사용해 이를 우회합니다.
   - 만약 스펙트럼 $\mathrm{spectrum}\,\mathbb{R}\,T$에 서로 다른 두 실수 $s \ne t$가 존재한다면, 서로소인 지지를 갖는 두 음이 아닌 연속 천막 함수 $f_1(x) = \max(0, |s-t|/2 - |x-s|)$, $f_2(x) = \max(0, |s-t|/2 - |x-t|)$ ($f_1(s) > 0$, $f_2(t) > 0$, $f_1 \cdot f_2 = 0$)를 구성합니다.
   - 연속 함수 미적분 가환성에 의해 `cfc f_1 T`와 `cfc f_2 T` 역시 모든 $U \in \mathcal{U}$와 가환이고 `cfc f_1 T * cfc f_2 T = 0`이므로, **닫힌 핵 부분공간** $K := \ker(\mathrm{cfc}\,f_1\,T)$는 $U$-불변이면서 $\bot$도 아니고($\mathrm{cfc}\,f_2\,T \ne 0$의 상이 $K$에 포함됨) $\top$도 아니어서($\mathrm{cfc}\,f_1\,T \ne 0$) 기약성과 모순됩니다.
   - 따라서 스펙트럼은 한 점 $\{c\}$로 축약되며 `cfc_id'`에 의해 $T = c \cdot \mathrm{id}_H$가 도출됩니다.
   - 일반 유계 가환 작용소 $S$는 카르탕 실수·허수 분해 $S = \frac{S + S^*}{2} + i\,\frac{S - S^*}{2i}$를 거쳐 `schur_bounded`(`:122-138`)에서 즉시 복소 스칼라로 환원됩니다.
2. **`Formalism/SharpRestriction/GlobalSchurBounds/ThickPlacesCorollaryOfAnyTranslate.lean:17-2353`의 유니터리 형식차수 및 언폴딩 부피비 증명**:
   - 파일 상단부(`:17-61`)의 `finrank_host`, `fDeg_host`, `vInv_host`, `cmField_unramified_massIdentity`, `massIdentity_holds`, `lVal_pos`는 호스트 CM 확대체의 상대 판별식과 디리클레·헤케 $L$-값 $L(M, \eta^M) > 0$을 결합해 비분지 국소 질량 항등식을 먼저 고정합니다.
   - 파일 하단부(`:2251-2321`)의 `harishChandraAbs_pos_of_strictAnti`(`:2251-2260`)는 순감소하는 하리시-찬드라 매개변수 열 $\lambda_0 > \lambda_1 > \dots > \lambda_{N-1}$ ($N \ge 2$)에 관해 $|\lambda_0 - \lambda_1| > 0$으로부터 반복 상한 $\mathrm{lamAbs}(\lambda) := \sup_a \sup_b |\lambda_a - \lambda_b| > 0$을 증명하고, 이를 `formalDegreeBound_all_unitaryGroups`(`:2261-2312`) 및 `familyFormalDegree_all`(`:2317-2321`)로 올려 사슬 내 모든 계수의 유니터리 군에서 형식차수 $d(\sigma)$의 다항식 상하한을 동시에 확립합니다.
   - 마지막 정리 `volumeMass_of_unfolding`(`:2342-2353`)은 부피 비율 `VolumeRatio₂`(`:2330-2341`)를 지겔-베유 언폴딩 등식과 결합해 전역 질량 상수를 마감합니다.

---

## 제4장. 제3기둥 `Formalism.HermitianCurvature` 심층 해부 (`1,922`개 파일 · `460,802`줄 · `28,075`개 정리)

### 4.1 내부 이원 구조(`(root)` 명세 대 `HermitianCurvatureProofs` 본문)와 핵심 허브 `14`선

제3기둥 `Formalism.HermitianCurvature`는 `1,922`개 파일, `460,802`줄, 정리·보조정리 `28,075`개, 정의·구조체 외 `7,883`개(선언 총계 `35,958`개)를 담고 있는 순수 아르키메데스 해석학·미분기하·조화해석 엔진입니다.
앞서 제1장 1.3절의 교차 임포트 행렬에서 확인했듯, 이 기둥은 제1기둥 `LocalToGlobal`을 단 한 번도 임포트하지 않는(`0`건) 자족적 하부 기둥입니다.
폴더 내부 구성 역시 명세 계층과 전술 증명 계층의 철저한 이원 분리를 따릅니다.

| 내부 계층 구분 (`Formalism/HermitianCurvature/*`) | 파일 수 | 코드 줄 수 | 정리 (`thm+lem`) | 정의·구조체 외 | 평균 줄 수 | 계층별 수리·공학적 기능 |
| :--- | ---: | ---: | ---: | ---: | ---: | :--- |
| **`(root)` 최상위 명세·결합 계층** | `68` | `23,591` | `1,533` | `3,536` | `346.9` | 양자 소행렬식(`StatementQ`), 반쌍형 형식(`StatementB`), 파동 생성원(`HerGen`) 명세 |
| **`HermitianCurvatureProofs` 증명 본문** | `1,854` | `437,211` | `26,542` | `4,347` | `235.8` | 위상 정칙화(`RegularisedPairingViaPhase`), 절단 쌍둥이 생성기(`CutCptCopy`), 자리별 적분 |
| **합계: `HermitianCurvature` 전수** | **`1,922`** | **`460,802`** | **`28,075`** | **`7,883`** | **`239.8`** | **선언 총계 `35,958`개 (`Main.lean` 최단 거리 `dist = 7`~`25`)** |

`B03` 전수 AST 도감에서 추출한 `HermitianCurvature` 내부 최다 피참조 허브 및 출력·절단 핵심 모듈 `14`선의 정량 지표와 원문 기능은 아래 표와 같습니다.

| 순위 | 허브 및 출력 모듈 (`src/` 상대경로) | 줄 수 | `in_deg` | `dist` | 대표 선언 및 수리적 역할 |
| ---: | :--- | ---: | ---: | ---: | :--- |
| `1` | `Formalism/HermitianCurvature/StatementQ.lean` | `1,119` | `90` | `10` | 양자 소행렬식 행 전개 `qminorRow`, 제타 교환자 `ZetaComm`, `ActualAdjoint` |
| `2` | `Formalism/HermitianCurvature/WeylElementCommutesLevelOne.lean` | `496` | `78` | `7` | 레벨 1 바일 원소 교환성, 하르 유일성 `HaarUnique`, 최상단 출력 `LemmaBDouble` |
| `3` | `Formalism/HermitianCurvature/HermitianCurvatureProofs/RegularisedPairingViaPhase.lean` | `897` | `70` | `11` | 카르탕 팽창 `aDil_mem_gv`, 리 미분 수반 `word_adj`, `phase_function_adjoint` |
| `4` | `Formalism/HermitianCurvature/HermitianCurvatureProofs/BetaSesquilinearity.lean` | `1,532` | `66` | `10` | 의사유니터리 군 `GV k r` 닫힘성, 미분 단어 `Dw`, `assemble_equality_identity` |
| `5` | `Formalism/HermitianCurvature/BesselNonvanishingReduction.lean` | `481` | `60` | `9` | 스펙트럼 간격 `GapOK`, 재생핵 `Repro`, 정칙화 핵 `PhiReg`, 베셀 비소멸 환원 |
| `6` | `Formalism/HermitianCurvature/HerGenC.lean` | `80` | `55` | `12` | 콤팩트 지지 파동 생성원 귀납족 `HerGenC`, 부분공간 `herKc`, `ThmPActualCpt` |
| `7` | `Formalism/HermitianCurvature/HermitianCurvatureProofs/TheoremPIntegralOfPlaces.lean` | `935` | `32` | `11` | 무한자리 곱 적분 `thmPInt_of_covolume_prod`, `theorem_P_integral_of_places` |
| `8` | `Formalism/HermitianCurvature/StatementB.lean` | `565` | `26` | `8` | 반쌍형 극화 `Polarisation`, 반노름 부등식 `SeminormIneq`, `LemmaBClosed` |
| `9` | `Formalism/HermitianCurvature/TopDensNonnegOfKappa.lean` | `182` | `12` | `10` | 파동 생성원 `HerGen`, 곡률 사상 양수성 `XKappa`, `TopDensNonnegOfKappa` |
| `10` | `Formalism/HermitianCurvature/LatticeHerglotzBound.lean` | `167` | `10` | `13` | 불변 평균 `IsMeanInf`, `MeanSplit`, 격자 헤르글로츠 부등식 `LatticeHerglotzBound` |
| `11` | `Formalism/HermitianCurvature/Statement.lean` | `63` | `7` | `11` | 날카로운 재귀 상한 `RecursionSharp`, 쌍대 크기 항등식 `DualSizeIdentity`, `OmNorm` |
| `12` | `Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptCopy.lean` | `91` | `1` | `17` | 메타프로그래밍 쌍둥이 정리 생성기 `toCopy`, `copyAll`, 명령 `cpt_copy_thms` |
| `13` | `Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptDefs.lean` | `195` | `1` | `18` | 콤팩트 지지 섬유·그람·곡률 적분 쌍둥이 명세 `GLGramCpt`, `GLGermCpt` |
| `14` | `Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptManual.lean` | `551` | `1` | `17` | 수동 기저 증명 `form_csCpt`, `truncated_limit_positivity_holdsCpt`, `glGramCpt` |

이 네임스페이스들이 모두 `Formalism.FourierDecayAlt` 및 `Formalism.QuantumDeterminants`라는 내부 모듈 이름을 공유하고 있다는 사실(`Formalism/HermitianCurvature/HermitianCurvatureProofs/BetaSesquilinearity.lean:11-13`, `Formalism/HermitianCurvature/TopDensNonnegOfKappa.lean:8-10`)은 이 기둥의 수리적 본질을 그대로 드러냅니다.
즉 에르미트 계량의 곡률 양수성을 이용해 비콤팩트 궤도 위의 발산하는 푸리에-베셀 적분에 위상 이동 정칙화와 매끄러운 절단을 가하고, 그 극한에서 음이 아닌 스펙트럼 밀도(`TopDensNonneg`)를 추출하는 것이 이 기둥의 임무입니다.

특히 위 허브 표 상위권에 자리 잡은 3대 명세·출력 허브(`StatementQ.lean`, `WeylElementCommutesLevelOne.lean`, `StatementB.lean`)의 내부 선언 체인을 먼저 짚어두면 다음과 같습니다.

1. **`StatementQ.lean` (`1,119`줄, `in_degree = 90`, 선언 `189`개)**:
   `Formalism/HermitianCurvature/StatementQ.lean:16-1118`은 양자 행렬식 대수(`QuantumDeterminants`)의 모든 대수적 교환 관계를 집대성한 제3기둥 최대 피참조 허브입니다.
   행·열 생략 색인 사상 `skip1`·`skip2`(`:16-23`)로부터 양자 소행렬식 행 벡터 `qminorRow`(`:30-35`)와 제1열 라플라스 전개 `ExpFirstCol`(`:40-44`)를 정의하고, 하단부에서 제타 비 함수와의 미분 교환식 `ZetaComm`(`:1080-1092`), 힐베르트-슈미트 내적에 관한 실제 수반성 `ActualAdjoint`(`:1093-1107`), 가군 정규형 도출 `NormalFormFromModule`(`:1110-1112`), 그리고 레벨 귀납 출발 조건 `ActualStartFromLevels`(`:1116-1118`)을 순차 결합합니다.
2. **`WeylElementCommutesLevelOne.lean` (`496`줄, `in_degree = 78`, `dist = 7`)**:
   `Formalism/HermitianCurvature/WeylElementCommutesLevelOne.lean:12-495`는 제3기둥에서 `Main.lean`까지의 최단 거리(`dist = 7`)를 기록하는 최상단 대외 수출 허브입니다.
   닫힌 행렬 부분군 구조체 `IsClosedSubgroup`(`:12-18`)과 하르 측도 상수배 유일성·역원 불변성 `HaarUnique`·`HaarInvFromUnique`(`:25-34`)로부터 출발하여, 레벨 1에서 반대 바일 원소(Weyl element) 공액 작용이 궤도 야코비안과 가환임을 정립하고 최하단에서 조악한 상한 `LemmaBCrude`(`:475-480`), 이중 레벨 상한 `LemmaBDouble`(`:483-487`), 그리고 $\xi$-게이지 최종 쌍 상한 `LemmaBFromXiFromParts`(`:493-495`)를 외부 기둥으로 내보냅니다.
3. **`StatementB.lean` (`565`줄, `in_degree = 26`, `dist = 8`, 선언 `110`개)**:
   `Formalism/HermitianCurvature/StatementB.lean:14-564`는 비콤팩트 궤도 위의 정칙화 쌍형식이 만족해야 할 반쌍형 대수 구조를 정의합니다.
   반쌍형성 `IsSesq`(`:14-17`), 비음수성 `IsNonneg`(`:18-19`), 반노름 삼각 부등식 `SeminormIneq`(`:20-23`), 복소 4항 극화 항등식 `Polarisation`(`:24-27`)을 기초로 삼아, 다항식 계수 수반성 `AdjointnessPolynomialCoefficients`(`:529-535`)와 단계별 절 `StepClause`(`:538-549`)를 조립해 닫힌 쌍형식 정리 `LemmaBClosed` 및 `LemmaBClosedFromParts`(`:556-564`)를 완성합니다.

---

### 4.2 아르키메데스 정칙화 절단(`CutCpt`) 메타프로그래밍 쌍둥이 생성기 역컴파일

비콤팩트 리 군 $G_V(k, r) := \{g \in \mathrm{Mat}_{2r+k+1}(\mathbb{C}) \mid g^{\mathrm{H}} H_{p,k} g = H_{p,k}\}$(`Formalism/HermitianCurvature/HermitianCurvatureProofs/BetaSesquilinearity.lean:25-36`) 위에서 궤도 적분과 부분적분(`word_adj`)을 수행할 때, 무한대에서의 경계항 소멸을 엄밀히 정당화하려면 먼저 **콤팩트 지지(compact support) 절단 공간 위에서 모든 대수적·해석적 항등식을 증명한 뒤 지배수렴 및 파투(Fatou) 극한으로 비콤팩트 원래 함수 공간에 전이**해야 합니다.
인간 수학 논문에서는 흔히 "콤팩트 지지에서의 증명은 동일하게 반복된다"라고 한 줄로 생략하지만, 형식증명 커널에서는 타입이 다른 두 함수 공간(`RadSp` 대 콤팩트 지지 절단 공간) 위에서 수백 개의 중간 보조정리를 모두 다시 증명해야 합니다.

`Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptCopy.lean:16-90`(`91`줄)은 이 문제를 공리 추가나 `sorry` 없이 순수 Lean 4 커널 내부에서 해결하는 **의존성 그래프 자동 복제기(`CptCopy`)**입니다.
원문 코드를 줄 단위로 해부하면 이 생성기는 정확히 4단계 알고리즘으로 작동합니다.

#### 제1단계: 경계 단말(`terminal`)과 출발 뿌리(`roots`)의 명시적 분리 (`Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptCopy.lean:16-33`)
복제기는 무작정 전체 환경을 복사하지 않고, 비콤팩트 공간과 콤팩트 지지 공간에서 증명이 실제로 달라지는 기저 정리 `17`개만을 단말(`terminal`)로 지정해 멈춤벽을 세웁니다.
- **특수 이름 치환 목록 `special` (`Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptCopy.lean:16-20`, `3`쌍)**:
  - `pb_formPos` $\mapsto$ `module_form_pos_compact_support`
  - `list_duality_level_group` $\mapsto$ `size_standard_compact`
  - `vector_isomorphism_levels` $\mapsto$ `vector_isomorphism_compact_support`
  이 3개 기저 정리는 별도 파일(`ModuleFormPosCompactSupport.lean`, `SizeStandardCompact.lean`, `VectorIsomorphismCompactSupport.lean`, `:7-9`에서 임포트)에서 직접 증명되어 있습니다.
- **수동 증명 목록 `manual` (`Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptCopy.lean:21-27`, `14`개)**:
  `ThmPActual`, `SizeStd`, `VIso`, `FormPos`, `standard_pairing_of_heads`, `FormNonneg`, `form_re_nonneg`, `form_cs`, `formNonneg_of`, `posAt_of_cpt`, `integral_three_at_place_of_parts`, `integral_four_at_place_of_parts`, `truncated_limit_positivity_holds`, `glGram`의 `14`개 기저 선언입니다.
  이들의 콤팩트 지지 대응물(`*Cpt` 접미사 부착본)은 `Formalism/HermitianCurvature/HerGenC.lean:63-79`(`ThmPActualCpt`), `Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptDefs.lean:18-194`, 그리고 `Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptManual.lean:12-550`에서 인간/에이전트 전술 코드로 수동 증명되어 있습니다.
- **출발 뿌리 목록 `roots` (`Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptCopy.lean:28-31`, `6`개)**:
  최상단 목표 정리인 `thmBpAt_main4`, `germ_truncation_positive`, `block_growth_bound_of_compact_coef`, `nFTopFormAll_of_ptw`, `top_identity_of_domination_limits`, `nfPolFormAll_of_top`의 `6`개 정리를 출발점으로 잡습니다.

#### 제2단계: 오염 전파(`tainted`) 후위 순회 탐색 `go` 및 `toCopy` (`Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptCopy.lean:38-57`)
함수 `proposals`(`:38-40`)는 환경 내 각 상수 선언의 타입(`ci.type`)과 증명 항 본문(`ci.value`)에 등장하는 모든 참조 상수를 추출합니다.
재귀 탐색기 `go`(`:41-53`)는 `roots`에서 시작하여 `Formalism` 접두사를 가진 하위 의존 상수들을 깊이 우선 탐색하되, `terminal` 집합에 도달하면 더 내려가지 않고 멈춥니다.
그리고 자식 노드 중 하나라도 `terminal`이거나 이미 오염(`tainted`)으로 표시된 경우 현재 노드를 `tainted` 집합에 넣고 위상 정렬 배열 `order`에 추가합니다(`:51`).
반면 순수 행렬 대수나 `Mathlib` 보조정리처럼 `terminal`에 의존하지 않는 노드는 복사하지 않고 원본 그대로 재사용합니다.

#### 제3단계: 상수 치환기 `subst`와 커널 직접 등록 `copyAll` (`Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptCopy.lean:58-90`)
위상 정렬 순서(`order`)를 따라 `copyAll`(`:68-85`)은 각 오염 노드의 이름 끝에 `"Cpt"`를 붙인 새 이름 `n'`(`mapName`, `:58-62`)을 만들고, 식 치환 함수 `subst`(`:63-67`)로 타입 식(`d.type`, `t.type`)과 증명 항 식(`d.value`, `t.value`) 내부의 모든 오염 상수 참조를 대응하는 `*Cpt` 상수로 일괄 치환합니다.
결정적인 대목은 `:78`과 `:82`의 커널 제출 방식입니다.
`copyAll`은 `addDecl (.defnDecl ...)`과 `addDecl (.thmDecl ...)`을 호출하여 **치환된 증명 항 전체를 Lean 4 커널 타입 검사기에 정식으로 통과시킵니다**.
만약 수동 기저 정리(`CutCptManual.lean`)와 복제된 상위 정리 사이에 단 하나의 인자 타입이나 우주 레벨(universe level) 불일치라도 있으면 `addDecl` 단계에서 즉시 커널 거부 오류가 발생합니다.
즉 `cpt_copy_thms`(`:87-90`)는 신뢰 기저(TCB)를 전혀 넓히지 않으면서 콤팩트 지지 쌍둥이 정리 계층 전체를 기계적으로 완결하는 무결성 보존 메타프로그래밍입니다.

#### 제4단계: 수동 기저 파일 `CutCptManual.lean`의 코시-슈바르츠 및 절단 극한 증명 (`Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptManual.lean:12-550`)
복제기의 바닥을 받치는 `Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptManual.lean:12-85`를 열람하면, 음이 아닌 에르미트 반쌍형 형식 조건 `FormNonnegCpt`(`:12-16`: 모든 유한 지지 벡터 $x$에서 $(p.\mathrm{form}\,x\,x).\mathrm{im} = 0$ 및 $0 \le (p.\mathrm{form}\,x\,x).\mathrm{re}$)으로부터 코시-슈바르츠 부등식 `form_csCpt`(`:25-79`)를 증명하는 전술 본문이 확인됩니다.
구체적으로 복소 스칼라 $t := -c \cdot \overline{p.\mathrm{form}(x, y)}$ ($c \in \mathbb{R}$)에 관해 $0 \le \Re\,p.\mathrm{form}(x + t y, x + t y)$를 전개하여 실수 이차다항식

$$
0 \le \Re\,p.\mathrm{form}(x, x) - 2 c\,\|p.\mathrm{form}(x, y)\|^2 + c^2 \|p.\mathrm{form}(x, y)\|^2\,\Re\,p.\mathrm{form}(y, y)
$$

을 얻고, $\Re\,p.\mathrm{form}(y, y) = 0$인 퇴화 경우와 양수인 경우($c = (\Re\,p.\mathrm{form}(y, y))^{-1}$ 대입)로 나누어

$$
\|p.\mathrm{form}(x, y)\|^2 \le \Re\,p.\mathrm{form}(x, x) \cdot \Re\,p.\mathrm{form}(y, y)
$$

를 완결합니다(`Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptManual.lean:45-79`).
나아가 같은 파일 하단의 `posAt_of_cptCpt`(`:443-462`), `truncated_limit_positivity_holdsCpt`(`:463-483`), `glGramCpt`(`:486-550`)가 매끄러운 절단 열의 단조·지배 극한 아래에서도 이 양수성이 그대로 보존됨을 확정합니다.

`Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptDefs.lean:18-194`에 정의된 `11`개 콤팩트 지지 쌍둥이 명세와 `Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptManual.lean:12-550`에 수록된 `9`개 수동 기저 정리의 전체 대조 원장은 아래 표와 같습니다.

| 구분 | 원문 선언명 (`*Cpt` 쌍둥이 기저) | 파일 및 행 번호 (`src/` 기준) | 비콤팩트 원본 대응물 및 수리적 역할 |
| :--- | :--- | :--- | :--- |
| **쌍둥이 명세 `1`** | `FibreTopCpt` / `GLFibreCpt` | `Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptDefs.lean:18-45` | 콤팩트 지지 절단 아래 최상단 파이버 적분 및 일반선형 파이버 정합 |
| **쌍둥이 명세 `2`** | `GLGramCpt` / `GLContCpt` | `Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptDefs.lean:54-97` | 절단된 궤도 그람 행렬의 반정치성 및 매개변수 연속성 명세 |
| **쌍둥이 명세 `3`** | `GermDataLowAllCpt` / `GLGermCpt` | `Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptDefs.lean:72-164` | 특이점 근방 낮은 차수 싹(germ) 전개와 콤팩트 지지 경계 소멸 |
| **쌍둥이 명세 `4`** | `PStdCpt` / `CurvatureIntegralOfPartsCpt` | `Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptDefs.lean:106-128` | 표준 쌍 결합 및 부분 곡률 적분 합산 공식 |
| **쌍둥이 명세 `5`** | `IntegralFourFromComponentsCpt` | `Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptDefs.lean:134-140` | 4중 성분 분해 적분의 콤팩트 지지 수렴 명세 |
| **쌍둥이 명세 `6`** | `NFTopFormAllCpt` / `GermDataTopAllCpt` | `Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptDefs.lean:171-194` | 정규형(normal form) 최상단 쌍형식과 최상단 싹 일치 명세 |
| **수동 정리 `1`** | `formNonneg_ofCpt` / `form_re_nonnegCpt` | `Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptManual.lean:22-85` | 대각 실수부 비음수성 $\Re\,p.\mathrm{form}(x, x) \ge 0$ 추출 |
| **수동 정리 `2`** | `form_csCpt` | `Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptManual.lean:25-79` | 콤팩트 지지 반쌍형 형식 코시-슈바르츠 부등식 직접 증명 |
| **수동 정리 `3`** | `integral_four_at_place_of_partsCpt` | `Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptManual.lean:93-257` | 아르키메데스 단일 자리에서 4성분 절단 적분 조립(`165`줄 전술 증명) |
| **수동 정리 `4`** | `integral_three_at_place_of_partsCpt` | `Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptManual.lean:265-415` | 아르키메데스 단일 자리에서 3성분 절단 적분 조립(`151`줄 전술 증명) |
| **수동 정리 `5`** | `standard_pairing_of_headsCpt` | `Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptManual.lean:422-428` | 선두 항(head terms)으로부터 표준 정칙화 쌍 구성 |
| **수동 정리 `6`** | `posAt_of_cptCpt` / `glGramCpt` | `Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptManual.lean:443-550` | 절단 극한 양수성 `truncated_limit_positivity_holdsCpt`(`:463-483`) 및 그람 양정치성 |

---

### 4.3 에르미트 계량 곡률 텐서 양수성, 양자 소행렬식(`Dmin`), 아라켈로프 전역 높이 부등식 결합

제3기둥 전체가 증명하는 핵심 수리 메커니즘은 **부호 $(p, q) = (r + k + 1, r)$인 의사유니터리 대칭공간 위에서 양자 소행렬식(quantum minors)으로 정의된 에르미트 계량 곡률 함수 $G_f$의 양수성을 리 대수 교환자와 결합해 최고차 스펙트럼 밀도의 비음수성(`TopDensNonneg`)을 얻고, 이를 격자 헤르글로츠 부등식과 전 자리 적분(`theorem_P_integral_of_places`)을 거쳐 아라켈로프 뒤틀린 높이 하한으로 변환하는 것**입니다.
최상위 요약 리프인 `Formalism/HermitianCurvature/Statement.lean:7-62`(`63`줄, `dist = 11`)는 이 기둥의 수치 목표를 날카로운 차원 재귀 상한 `RecursionSharp`(`:7-15`), 상자 합 정규화 `BoxSumOne`(`:25-32`), 쌍대 크기 항등식 `DualSizeIdentity`(`:33-39`), 주 상수 `MainConstant`(`:40-47`), 주 소행렬식 개수 `LeadingMinorsCount`(`:48-53`), 그리고 진동 노름 상한 `OmNorm`(`:54-62`)의 7개 명제로 정리합니다.
하부 원문 파일들에서 복원한 정확한 수식 체인은 다음 5단계로 이어집니다.

#### 제1단계: 의사유니터리 군 `GV k r` 위의 양자 소행렬식 `Dmin`과 곡률 포텐셜 `Gf`
부호 행렬 $H_{p,k}(k, r)$($H_{p,k}^2 = I_{2r+k+1}$, `Formalism/HermitianCurvature/HermitianCurvatureProofs/BetaSesquilinearity.lean:20-21`)이 정의하는 의사유니터리 군 $G_V(k, r) = \{g \in \mathrm{Mat}_{2r+k+1}(\mathbb{C}) \mid g^{\mathrm{H}} H_{p,k} g = H_{p,k}\}$와 그 리 대수 $\mathfrak{g}_V = \{X \mid X^{\mathrm{H}} H_{p,k} + H_{p,k} X = 0\}$(`Formalism/HermitianCurvature/HermitianCurvatureProofs/BetaSesquilinearity.lean:66-84`, 지수사상 닫힘성 `exp_mem`)을 고려합니다.
고정된 쌍대 프레임 벡터 $z, z' \in \mathbb{C}^{2r+k+1}$에 관해 `Formalism/HermitianCurvature/HermitianCurvatureProofs/TheoremPIntegralOfPlaces.lean:113-138` 및 `Formalism/HermitianCurvature/StatementQ.lean:30-44`는 에르미트 쌍 행렬 $\widehat{Z}(z, z'; g) \in \mathrm{Mat}_{r+1}(\mathbb{C})$(`contDiff_Zhat`, `:113-119`)의 $l$차 주 소행렬식 $D_{\min}(k, r, z, z', g; l) := \det \widehat{Z}_{[l]}(g)$(`contDiff_Dmin`, `:120-124`)를 정의하고, 인접한 두 주 소행렬식 노름 제곱의 차이로 곡률 함수 $G_f$를 구성합니다(`contDiff_Gf`, `Formalism/HermitianCurvature/HermitianCurvatureProofs/TheoremPIntegralOfPlaces.lean:133-138`).

$$
G_f(k, r, z, z'; g) := \left|D_{\min}\left(k, r, z, z', g; l_1\right)\right|^2 - c_{k, r}\,\left|D_{\min}\left(k, r, z, z', g; l_0\right)\right|^2
$$

실베스터-야코비 행렬식 항등식과 `Formalism/HermitianCurvature/StatementQ.lean:1080-1107`의 양자 행렬식 제타 교환 관계(`ZetaComm`, `ActualAdjoint`)에 의해, 로그 소행렬식 포텐셜 $-\log |D_{\min}|^2$의 복소 헤시안(에르미트 선다발의 천 곡률 2-형식)은 큰 브뤼아 세포 위에서 $G_f(g) \ge \varepsilon > 0$인 코바운더리 지배 영역을 형성합니다.

#### 제2단계: 위상 정칙화 쌍 `phase_function_adjoint`와 리 미분 단어 반쌍형성
비콤팩트 방향에서의 진동 적분을 수렴시키기 위해 `Formalism/HermitianCurvature/HermitianCurvatureProofs/BetaSesquilinearity.lean:96-108`은 좌·우 불변 리 미분 작용소 `Dx`(`:101`)의 합성 단어 연산자 `Dw w f`(`:103`)를 정의합니다.

$$
\left(D_{(b, X)} f\right)(g) := \left.\frac{d}{dt}\right|_{t=0} \begin{cases} f\left(\exp(-t X)\, g\right) & (b = \mathrm{true}) \\ f\left(g\,\exp(t X)\right) & (b = \mathrm{false}) \end{cases}
$$

그 위에서 `Formalism/HermitianCurvature/HermitianCurvatureProofs/RegularisedPairingViaPhase.lean:732-896`은 리 미분 단어의 부분적분 수반 공식 `word_adj`(`:732-780`)와 위상 인자 교환 수반 정리 `phase_function_adjoint`(`:838-896`)를 증명하여, `Formalism/HermitianCurvature/StatementB.lean:556-564`의 정칙화된 반쌍형 형식 `LemmaBClosed`와 `Formalism/HermitianCurvature/HermitianCurvatureProofs/BetaSesquilinearity.lean:1500-1531`의 대각 항등식 `assemble_diagonal_identity`·`assemble_equality_identity`를 확립합니다.

두 `*Proofs/` 핵심 파일의 실제 전술 본문을 열람하면 비콤팩트 군 위의 정칙화 수반성이 다음의 엄밀한 해석적 단계들로 증명되어 있습니다.

1. **`Formalism/HermitianCurvature/HermitianCurvatureProofs/RegularisedPairingViaPhase.lean:838-896` (`phase_function_adjoint`)의 5단 전술 구조**:
   - **미분 계수 여유분 확보 (`:840-842`, `:871-872`)**: 미분 연산자 다발 $\Theta$의 최대 차수 `opOrder Θ`보다 $5$단계 더 높은 매끄러움 등급 `CkOn (opOrder Θ + 5) (GV k r)`를 `ckOn_rho`와 `ckOn_coef`로 먼저 확보하여, 단어 길이 $|w| + 1 \le \mathrm{opOrder}\,\Theta + 5$(`len_le_order`, `:805-816`) 범위 안에서 연쇄 법칙과 부분적분이 미분가능성 손실 없이 작동하게 만듭니다.
   - **열린 지지집합 `UU` 내외부 분리 (`:843-857`)**: 좌변 위상 쌍 `Ph D (opApply Θ F) F' p`의 피적분함수를 하르 측도 거의 모든 점(`haar_ae D.haarG`)에서 열린 집합 $g \in UU$인 경우와 $g \notin UU$인 경우로 `by_cases` 분기합니다. $g \in UU$에서는 위상-미분 교환 가정 `hcom`을 적용하고, $g \notin UU$에서는 $F'$의 지지집합 폐포 포함관계 `hsF' (subset_closure ...)`로부터 $F'(g) = 0$을 끌어내 경계 밖 기여를 `hs_zero_right`로 소거합니다.
   - **역순 단어 수반식 전개 (`:858-870`)**: 우변 `Ph D F (opAdj Θ F') p`에서 수반 미분 연산자 `opAdj`는 리 미분 단어 `T.word`를 역순 리스트 `T.word.reverse`로 뒤집고 부호 $(-1)^{|T.\mathrm{word}|}$를 곱한 형태로 풀어집니다.
   - **양변 절대적분가능성 검증 (`:873-888`)**: 유한합과 르베그 적분 기호를 교환하기 전에 좌변 항 `hIl`과 우변 역순 항 `hIr` 각각의 힐베르트-슈미트 내적 적분가능성(`hs_integrable`)을 성장률 가설 `hIC`로부터 별도로 증명합니다.
   - **단어 길이 귀납 수반 정리 `word_adj` 대입 (`:889-895`)**: `integral_listSum`으로 유한합을 적분 밖으로 뽑아낸 뒤 각 단항 $T \in \Theta$마다 유니모듈러 하르 부분적분 정리 `word_adj`(`:732-780`)를 대입하여

     $$
     \int_{G_V(k,r)} \left\langle R_w\left(\rho_p F\right)(g),\; T_{\mathrm{adj}} F'(g) \right\rangle_{\mathrm{HS}} d\mu_G(g) = (-1)^{|w|} \int_{G_V(k,r)} \left\langle \rho_p F(g),\; R_{w^{\mathrm{rev}}}\left(T_{\mathrm{adj}} F'\right)(g) \right\rangle_{\mathrm{HS}} d\mu_G(g)
     $$

     로 좌우변을 정확히 일치시킵니다.
2. **`Formalism/HermitianCurvature/HermitianCurvatureProofs/BetaSesquilinearity.lean:1500-1531` (`assemble_diagonal_identity` · `assemble_equality_identity`)의 극한 결합**:
   - `assemble_diagonal_identity`(`:1500-1509`)는 파투 보조정리(`hFa`)와 지배 계량 `diagDom`(`hDD`)을 결합하여 2차원 감쇠 매개변수 $\tau \in \mathrm{Quad}$ 위에서 대각 적분 에너지가 유한(`ENNReal.ofReal_ne_top`)임을 보인 뒤 기저 등식 `core`(`:1407-1491`)로 $\beta_\tau(F, F)$ 항등식을 닫습니다.
   - `assemble_equality_identity`(`:1510-1531`)는 기준점 $\tau_0 = (1, 1) \in \mathrm{Quad}$(`:1513`)에서 정칙화 연산자 $J_\tau(1, 1) F = J_F F$(`eJ`, `:1514`)와 반쌍형 형식 $\beta(F, F') = \beta_\tau(1, 1; F, F')$(`eB`, `:1517-1518`)가 일치함을 이용해 근방 $U_0$의 연속 상한 `hC0`를 비정칙화 원래 쌍형식 `beta D F F'`으로 전이시킵니다.

#### 제3단계: 파동 절편 귀납 원뿔 `HerGen`과 곡률 사상 양수성 `XKappa` $\implies$ `TopDensNonneg`
`Formalism/HermitianCurvature/TopDensNonnegOfKappa.lean:22-68`은 방사 함수 공간 `RadSp P.k P.r z z' π π'` 위에서 레벨 색인 $i \in \mathrm{Fin}(P.r + 1)$을 따라 단계적으로 확장되는 귀납적 생성자족 `HerGen`(`:28-42`)과 그 선형 생성 부분공간 $K_i := \mathrm{herK}(i)$(`:43-45`)를 구성합니다(콤팩트 지지 쌍둥이 판본은 `Formalism/HermitianCurvature/HerGenC.lean:24-41`의 `HerGenC` 및 `herKc`).
`HerGen`의 4개 귀납 생성 규칙과 그 위에서 성립하는 6중 해석 패키지 `HerAnalytic`(`Formalism/HermitianCurvature/TopDensNonnegOfKappa.lean:64-68`)의 원문 명세는 아래 표와 같습니다.

| 생성자 / 패키지 절 | 행 번호 | 원문 귀납 규칙 및 수식 조건 | 해석적 보존 성질 |
| :--- | ---: | :--- | :--- |
| **`HerGen.jf`** | `29-30` | `JFOK P z z' F → IsRadJF ... F Φ → HerGen 0 Φ` | 곡률 양수 지지 조건($F(g) \ne 0 \implies G_f(g) \ge \varepsilon > 0$)을 만족하는 레벨 $0$ 기저 핵 |
| **`HerGen.slice`** | `31-32` | `WordOK ... w → HerGen l.castSucc Φ → HerGen l.succ ((bTl L l w a b).1 Φ)` | 허용 미분 단어 $w$와 절편 연산자 `bTl`에 의한 레벨 $l \to l+1$ 승격 |
| **`HerGen.waveC`** | `33-36` | `multiplicationOperator Wv (fsv s (c' l)) → HerGen l.castSucc ((Vw ...).1 Φ)` | 중간 좌표 $c'_l$의 복소 거듭제곱 위상 승수 `fsv(±s, c'_l)` 아래의 닫힘성 |
| **`HerGen.waveZ`** | `37-41` | `multiplicationOperator Wv (fsv s (zeta ... g)) → HerGen (last r) ((Vw ...).1 Φ)` | 최상단 레벨 `Fin.last P.r`에서 양자 소행렬식 비 `zeta(g)` 위상 변환 닫힘성 |
| **`HerAnalytic` 6절** | `64-68` | `AdjTop ∧ TopDensNonneg ∧ TopTwistDens ∧ StepDens ∧ FormInt ∧ CompositeFormulaLevelZero` | 수반성, 최상단 밀도 비음수성, 위상 공변성(`:48-54`), 적분가능성(`:55-63`), 합성 공식 결합 |

이어서 `Formalism/HermitianCurvature/TopDensNonnegOfKappa.lean:98-106`의 핵심 양수성 조건 `XKappa`는 대수 준동형사상 $\kappa : (\mathrm{Ty}(P) \to \mathbb{C}) \to \mathrm{Pr}(\mathrm{RadSp})$가 모든 양수 스펙트럼 가중치 함수 $f(\rho) > 0$와 모든 방사 단면 $\Phi$, 매개변수 $c$, 군 원소 $g \in \mathrm{Mx}(k, r)$에서 점별 힐베르트-슈미트 내적 부등식

$$
0 \le \left\langle \left((\kappa f)\,\Phi\right)(c, g),\; \Phi(c, g) \right\rangle_{\mathrm{HS}}
$$

(`XKappa`, `:104-105`; 정규형 섬유 판본은 `KappaFibrePos`, `:130-139`)을 만족함을 진술합니다.
사상 $\kappa$가 곡률 연산자 역원 $st.x_i(Y) = \kappa(\rho \mapsto x_0(P, l_0, \rho, Y)^{-1})$(`:103`)을 양수 스펙트럼 적분으로 표현하므로, `TopDensNonnegOfKappa`(`:107-116`)에 의해 최상단 뒤틀린 궤도 밀도 `topDens`가 모든 허용 단어 위에서 음이 아님(`TopDensNonneg`)이 도출됩니다.
또한 `Formalism/HermitianCurvature/BesselNonvanishingReduction.lean:399-475`는 이 재생핵 구조 `Repro`(`:399-415`)와 정칙화 핵 `PhiReg`(`:416-429`), 이차 수렴 `QuadConv`(`:448-471`)를 묶어 아르키메데스 베셀 주기의 비소멸 환원 명제 `BesselNonvanishingReduction`(`:474-475`)을 공급합니다.

#### 제4단계: 격자 헤르글로츠-페예르 부등식 (`Formalism/HermitianCurvature/LatticeHerglotzBound.lean:90-97`)
이렇게 얻은 국소 스펙트럼 양수성을 CM 수체의 대수적 정수 격자 합으로 옮기는 다리가 `Formalism/HermitianCurvature/LatticeHerglotzBound.lean:12-166`입니다.
복소 벡터 공간 $V(f) := \mathbb{C}^f$ 안의 이산 $\mathbb{Z}$-격자 $\Lambda := \mathrm{La}$와 그 쌍대 격자 $\Lambda^\vee := \mathrm{dualSet}(\Lambda) = \{\sigma \in \mathbb{C}^f \mid \forall z \in \Lambda, \psi(\sigma \cdot z) = 1\}$(`:25-26`)를 잡습니다.
무한대 소멸 불변 평균 범함수 `IsMeanInf Λ LIM`(`:45-48`, 아메너블 평균 분해 `MeanSplit`, `:79-89`)을 이용해 매끄러운 주항 외의 진동 오차항 자기상관 함수 $A(\sigma)$가 양정치(`PDOn (dualSet La) A`, `:29-32`: 모든 유한합에서 $\Re \sum_{\sigma, \sigma'} A(\sigma - \sigma') c_\sigma \overline{c_{\sigma'}} \ge 0$)임을 확인한 뒤, 명제 `LatticeHerglotzBound`(`Formalism/HermitianCurvature/LatticeHerglotzBound.lean:90-97`)에서 임의의 음이 아닌 반연속 적분가능 함수 $N : \mathbb{C}^f \to \mathbb{R}_{\ge 0}$와 단일 격자 잉여류에 속하는 유한 점집합 $S \subset z_0 + \Lambda$에 관해 다음 부등식을 확립합니다.

$$
\mathrm{covol}(\Lambda) \sum_{z \in S} N(z) \le \sum_{\sigma \in \Lambda^\vee} \left\|\widehat{N}(\sigma) + A(\sigma)\right\|
$$

보흐너-헤르글로츠 양정치성 덕분에 양정치 보정항 $A(\sigma)$를 푸리에 변환 $\widehat{N}(\sigma)$에 더해도 푸아송 합 공식의 좌변 점별 합 하한이 깨지지 않으면서 우변의 고주파 꼬리가 가중치 $m_L(K, L, \sigma) = \prod_v \min(1, (L_v / \|\sigma_v\|)^K)$(`mfac`·`mL`, `:16-19`, 적분값 $\prod_v \frac{\pi x_v^2 K}{K-2}$, `MajIntegralProd`, `:54-58`)에 의해 절대수렴(`LatticeSummable`, `:59-62`)하게 됩니다.

#### 제5단계: 무한자리 곱 적분 `theorem_P_integral_of_places`와 아라켈로프 높이 부등식 결합
마지막으로 `Formalism/HermitianCurvature/HermitianCurvatureProofs/TheoremPIntegralOfPlaces.lean:801-932`는 CM 체 $E$의 모든 무한자리 $v \in \mathrm{InfinitePlace}\,E$($f = [E^+ : \mathbb{Q}]$개 복소 매장)에 걸쳐 위의 자리별 곡률·헤르글로츠 상한을 곱셈적으로 적분하여(`thmPInt_of_covolume_prod`, `:801-924`), 전역 정리 `theorem_P_integral_of_places`(`:929-932`)와 최적 지수 문턱값 정리 `jc_theta_exists_variant`(`:73-90`, 유한 문턱 집합 $\mathrm{thrSet}$의 상한 $\sup \mathrm{thrSet}$에 지수 $-1/f$를 취한 양수 매개변수 구성)를 완성합니다.

이 무한자리 아르키메데스 기여분은 `Formalism/HermitianCurvature/HermitianCurvatureProofs/BlockRelationTwistedHeight.lean:175-265`의 뒤틀린 블록 대각합 항등식(`glue_cf`, `form_tr`, `rrform_tr`, `ph_tr`)을 거쳐 아라켈로프 높이 허브 `Formalism/PairingDivisors/StatementH.lean:30-98`(`139`줄, `in_degree = 484`, `dist = 7`)에 직접 결합됩니다.
구체적으로 `Formalism/PairingDivisors/StatementH.lean:30-43`의 아라켈로프 높이 핵 `HeightCore`와 `:72-98`의 `HeightBoundOfLocalValuations`는 수체 $K$의 비영 대수적 원소(세타 평가값)에 관해 아르키메데스 로그 노름 평균 `meanInf`(`:13-15`, 에르미트 선다발 계량 및 그린 함수 절단에서 공급)과 비아르키메데스 유한 소수 부치 합 `WtSum`(`:24-29`, 가분성 및 단축 평가에서 공급)을 아라켈로프 곱공식(product formula)으로 묶어 다음의 전역 높이 부등식을 성립시킵니다.

$$
\frac{1}{[K : \mathbb{Q}]} \sum_{\sigma : K \hookrightarrow \mathbb{C}} \log |\sigma(\alpha)| + \frac{1}{[K : \mathbb{Q}]} \sum_{\mathfrak{p} \nmid \infty} v_{\mathfrak{p}}(\alpha)\,\log \mathrm{N}(\mathfrak{p}) = 0 \implies \sum_{\mathfrak{p} \in \mathcal{P}_{\mathrm{target}}} v_{\mathfrak{p}}(\alpha)\,\log \mathrm{N}(\mathfrak{p}) \le h_{\infty}(\alpha) - h_{\mathrm{forced}}(\alpha)
$$

제3기둥 `HermitianCurvature`가 증명한 곡률 양수성과 `LatticeHerglotzBound`는 바로 우변의 무한자리 아라켈로프 계량 항 $h_{\infty}(\alpha)$에서 불필요한 지수 팽창이 일어나지 않고 정칙화 절단 오차가 음의 방향(상한을 줄이는 방향)으로 떨어지도록 보장하는 해석적 버팀목입니다.

---

## 제5장. 제4기둥 `Formalism.PeriodIntegrals` 심층 해부 (`4,350`개 파일 · `451,856`줄 · `23,534`개 정리)

### 5.1 하위 서브패키지 `9`종 및 `UnitaryGroupMassFormula`(`3,615`개 파일) 계층 분해

제4기둥 `Formalism.PeriodIntegrals`는 `4,350`개 파일, `451,856`줄, 정리·보조정리 `23,534`개, 정의·구조체 외 `9,165`개(선언 총계 `32,699`개)로 이루어진 주기 적분·안정자 질량·사영 격자 차수 엔진입니다.
이 기둥의 존재 이유는 단 하나의 치명적인 수리적 장벽, 곧 **$m$회 반복 세타 리프트를 수행할 때 유한 자리 사영 분모와 보조 헤케 지표 의존성이 누적되어 무영점 영역을 $\sigma = \frac{2}{3}$에 가두는 수준·분모 손실 장벽(level-denominator loss barrier)을 정밀 상쇄하고 전역 정수가역성(integrality) 하한을 확보하는 것**입니다.

`PeriodIntegrals` 직하위 `9`개 서브패키지의 분포와, 그중 전체 줄 수의 `95.27%`(`430,489`줄)를 차지하는 거대 중추 `UnitaryGroupMassFormula` 내부 상위 `12`개 서브모듈의 분포는 아래 두 표와 같습니다.

| 순위 | 직하위 서브패키지 (`Formalism/PeriodIntegrals/*`) | 파일 수 | 코드 줄 수 | 정리 (`thm+lem`) | 정의·구조체 외 | 전담 수리 엔진 및 핵심 역할 |
| ---: | :--- | ---: | ---: | ---: | ---: | :--- |
| `1` | **`UnitaryGroupMassFormula`** | `3,615` | `430,489` | `22,869` | `6,922` | 지겔-베유 안정자 부피(`InVolumesAtOfSWS`), 아르키메데스 곱 밀도(`PiDens`), 질량 공식 |
| `2` | **`(root)` 최상위 명세·교량부** | `328` | `14,912` | `77` | `2,156` | 카펠리 무한소 지표(`DSInfCharCap`), 베셀 유일성(`BesselMapUniq`), 사영 격자(`DivisionRows`) |
| `3` | **`OrbitalBoundsConclusion`** | `380` | `4,309` | `464` | `0` | 자리별 국소 궤도 적분 상한의 전역 수렴 조립 |
| `4` | **`HermitianGenusExtension`** | `11` | `1,236` | `65` | `21` | 에르미트 격자 속(genus) 확장 및 국소 등거리 접합 |
| `5` | **`AdmissibleModel`** | `1` | `405` | `28` | `8` | 허용 표현 모형의 기저 정합성 증명 |
| `6` | **`ExplicitFormulaCounts` 외 `4`종** | `15` | `505` | `31` | `58` | 명시 공식 계수 집계, 블록 형상(`JointBlockShapes`), 나블라 생성(`NablaSpans`) |
| **합계** | **`PeriodIntegrals` 전수 (`9`종)** | **`4,350`** | **`451,856`** | **`23,534`** | **`9,165`** | **선언 총계 `32,699`개 (`Main.lean` 최단 거리 `dist = 6`~`31`)** |

| 순위 | `UnitaryGroupMassFormula/*` 내부 핵심 모듈 | 파일 수 | 코드 줄 수 | 정리 (`thm+lem`) | 정의·구조체 외 | 질량 공식 내 세부 역할 |
| ---: | :--- | ---: | ---: | ---: | ---: | :--- |
| `1` | **`StabilizerVolume`** | `155` | `19,855` | `789` | `285` | 지겔-베유 가설로부터 안정자 기본영역 부피 도출(`InVolumesAtOfSWS`, `VolStabFromSWS`) |
| `2` | **`StabilizerOrbitVolume`** | `147` | `19,387` | `779` | `278` | 안정자-궤도 몫 공간의 파이버 적분 분해(`FibInfEx`) |
| `3` | **`WeilStabilizerVolume`** | `146` | `18,416` | `739` | `281` | 베유 표현 정규화 게이지 아래의 등방 튜플 부피(`VolStabFromSWW`) |
| `4` | **`ArchimedeanOrbitMeasures`** | `153` | `18,102` | `731` | `395` | 무한자리 라돈-니코딤 곱 차트 밀도(`PiDens.lean`, `dist = 6` 최상단 직결) |
| `5` | **`CountingFormula`** | `113` | `12,999` | `661` | `173` | 완전 정부호 유니터리 속 내 자기동형군 가중 격자 개수 공식 |
| `6` | **`LatticeIndices`** | `95` | `8,970` | `468` | `162` | 부분격자 지수 $[L : L']$와 국소 부피 비율의 정확한 등식 |
| `7` | **`LocalUnitaryOrbits`** | `69` | `8,249` | `389` | `108` | $\mathfrak{p}$-진 유니터리 군의 궤도 대표원 및 헨젤 리프팅 밀도 |
| `8` | **`ValuationLocalVolumes`** | `84` | `8,031` | `395` | `108` | 유한 소수 부치별 표준 격자 부피 최종 공식(`VolVFinal.lean`) |
| `9` | **`GelfandTsetlinLowering`** | `37` | `5,613` | `301` | `66` | 겔판트-체틀린(Gelfand-Tsetlin) 분기 규칙 및 내림 연산자 정규화 |
| `10` | **`WeightedLimitGauge`** | `41` | `5,500` | `342` | `133` | 리 대수 하르 게이지 극한(`VolumeLieE.lean`, `in_degree = 40`) |
| `11` | **`FockJointMultiplicity`** | `30` | `5,276` | `326` | `107` | 바르그만-포크(Fock) 공간 결합 중복도와 세타 핵 다항식 차수 |
| `12` | **`ExplicitFormula` 외 나머지 하위 폴더** | `2,545` | `309,991` | `17,149` | `4,826` | 원시 소수 인자 곱 수렴, 수준 분할(`LevelSplitting`), 반직접곱 부피(`SemidirectVolume`) |

---

### 5.2 최다 피참조 핵심 허브 `13`선 원문 직독 및 수식 해부

`B04` 도감에서 확인한 `PeriodIntegrals` 내부 최다 피참조 허브 및 최상단 출력 모듈 `13`선의 정량 지표와 원문 역컴파일 요지는 아래와 같습니다.

| 순위 | 허브 및 출력 모듈 (`src/` 상대경로) | 줄 수 | `in_deg` | `dist` | 대표 선언 및 수리적 기능 |
| ---: | :--- | ---: | ---: | ---: | :--- |
| `1` | `Formalism/PeriodIntegrals/DSInfCharCap.lean` | `47` | `91` | `7` | 카펠리 양자 행렬식과 이산계열 무한소 지표 일치 명제 `DSInfCharCap` |
| `2` | `Formalism/PeriodIntegrals/UnitaryGroupMassFormula/StabilizerVolume/InVolumesAtOfSWS.lean` | `27` | `64` | `9` | 지겔-베유 입력 `SWXS`로부터 안정자 부피 도출 정리 `inVolumesAt_of_SWS` |
| `3` | `Formalism/PeriodIntegrals/QuotInv.lean` | `54` | `54` | `7` | 우불변 하르 몫측도 유일성 `QuotInv` 및 합성곱 영(Young) 부등식 `QuotYoung` |
| `4` | `Formalism/PeriodIntegrals/RhsWLim.lean` | `143` | `39` | `11` | 비트 기저 안정자 공(ball) 부피 극한 존재성 `WbDataEx`, `RhsWLim` |
| `5` | `Formalism/PeriodIntegrals/UpqRep.lean` | `381` | `38` | `8` | 의사유니터리 군 `UJ ε` 닫힌 매장 `UJEmb`, 케일리 변환 `IsCayleyU`, `IsDSHpk` |
| `6` | `Formalism/PeriodIntegrals/BesselMapUniq.lean` | `61` | `35` | `7` | 카셀만-월러크 매끄러운 베셀 범함수 공간의 1차원 유일성 `BesselMapUniq` |
| `7` | `Formalism/PeriodIntegrals/DivisionRowsRationalLattice.lean` | `283` | `32` | `11` | 사영 격자 차수 하한 `DegreeKernelLowerBound`, `Conclusion4a`, `division_rows_rational_lattice` |
| `8` | `Formalism/PeriodIntegrals/IsLowUnitH.lean` | `150` | `30` | `8` | 겔판트 중심 연산자 `gelfandOp`, 무한소 지표 `HasInfChar`, 최저 $K$-유형 단위벡터 `IsLowUnitH` |
| `9` | `Formalism/PeriodIntegrals/VolFromSW.lean` | `137` | `17` | `11` | 지겔-베유 평균 항등식 `SWc1` $\implies$ 안정자 등식 `VolStabAt` (`volumesFromSW_of`) |
| `10` | `Formalism/PeriodIntegrals/BesselPeriodGGP.lean` | `122` | `6` | `10` | 엇갈림 조건 `InterlacingCondition` 아래 간-그로스-프라사드(GGP) 주기 `BesselPeriodGGP` |
| `11` | `Formalism/PeriodIntegrals/TwChrOne.lean` | `248` | `2` | `11` | 비틀린 파라호릭 부분군 $Q$ 위의 지표 자명성 `ChrOkL`, `TwChrOne` |
| `12` | `Formalism/PeriodIntegrals/TwNormLat.lean` | `250` | `2` | `14` | 비틀린 노름 격자의 유계성 `Bdd` 및 정규형 일치 `TwNormLat` |
| `13` | `Formalism/PeriodIntegrals/UnitaryGroupMassFormula/ArchimedeanOrbitMeasures/PiDens.lean` | `162` | `4` | `6` | 유한 곱 공간 위의 라돈-니코딤 차트 밀도 인수분해 정리 `pi_chart_dens` (`dist = 6` 최단 수출점) |

주요 허브들의 내부 원문 정의를 구체적으로 확인합니다.

1. **`UpqRep.lean` · `IsLowUnitH.lean` · `DSInfCharCap.lean` (의사유니터리 표현과 카펠리 무한소 지표)**:
   `Formalism/PeriodIntegrals/UpqRep.lean:10-120`은 부호 벡터 $\varepsilon : \mathrm{Fin}\,n \to \mathrm{Bool}$이 정하는 대각 행렬 $J_m(\varepsilon) = \mathrm{diag}(\pm 1)$(`:10-12`)에 관해 의사유니터리 군 $U_J(\varepsilon) = \{g \mid g^{\mathrm{H}} J_m(\varepsilon) g = J_m(\varepsilon)\}$(`:44-73`)가 $\mathrm{Mat}_n(\mathbb{C})$ 안에 닫힌 위상 매장(`isClosed_pseudoUnitary`·`isInducing_coeMatrix`, `:101-120`)을 이룸을 직접 증명합니다.
   그 위에서 `Formalism/PeriodIntegrals/IsLowUnitH.lean:41-84`는 순환 행렬 단위로 구성된 $k$차 겔판트 중심 미분연산자(Gelfand invariant operator)

   $$
   \left(\mathrm{gelfandOp}_{\varepsilon, k} F\right)(g) := \sum_{a : \mathrm{Fin}(k+1) \to \mathrm{Fin}\,n} \left(D_{E_{a_0, a_1}} D_{E_{a_1, a_2}} \cdots D_{E_{a_k, a_0}} F\right)(g)
   $$

   (`Formalism/PeriodIntegrals/IsLowUnitH.lean:41-45`)를 정의하고, 이산계열 행렬계수가 모든 $k \ge 0$에서 고유방정식 $\mathrm{gelfandOp}_{\varepsilon, k} F = c(k)\,F$를 만족한다는 `HasInfChar`(`:66-69`)를 정식화합니다.
   그리고 피참조 1위 허브인 `Formalism/PeriodIntegrals/DSInfCharCap.lean:40-46`은 이산계열 표현 $\sigma$ 위에서 보편포락대수 카펠리 중심원소(quantum determinant)가 스칼라 $c_{\mathrm{Cap}}(\lambda)$로 작용함을 보장하여, 제2장 2.2절에서 확인한 카펠리 헤케 비소멸 정리(`CompanionTheory/SpectralGeometry/LocalGlobalProofs/StableLattices/HeckeNonVanishing.lean:68-112`)에 정확한 고유값을 공급합니다.

2. **`BesselMapUniq.lean` · `BesselPeriodGGP.lean` (베셀 범함수 1차원 유일성과 GGP 주기 인수분해)**:
   `Formalism/PeriodIntegrals/BesselMapUniq.lean:38-60`은 카셀만-월러크 매끄러운 완비 공간 연속 조건 `IsCWCont`(`:32-37`)를 만족하는 베셀 범함수 공간 `IsBesselMapSm`(`:38-47`)의 차원이 최대 $1$임을 뜻하는 국소 유일성 명제 `BesselMapUniq`(`:50-60`: 임의의 두 베셀 범함수 $L, L_0$에서 $L_0 \ne 0 \implies \exists c \in \mathbb{C}, L = c \cdot L_0$)를 선언합니다.
   이 1차원 유일성 덕분에 전역 베셀 주기는 국소 베셀 적분들의 오일러 곱으로 인수분해되며, `Formalism/PeriodIntegrals/BesselPeriodGGP.lean:27-121`은 하리시-찬드라 매개변수의 엇갈림 조건 `InterlacingCondition`(`:27-31`), 반정수 차이 조건 `HalfIntegralDifference`(`:32-34`), 스펙트럼 간격 `GapBig`(`:37-41`) 아래에서 아르키메데스 간-그로스-프라사드(GGP) 국소 베셀 주기를 이산계열 형식차수 `fdegH`(`:85-88`)와 등식으로 묶어냅니다(`BesselPeriodGGP`, `:105-121`).

3. **`QuotInv.lean` · `RhsWLim.lean` (우불변 몫측도 영 부등식과 비트 공 부피 극한)**:
   `Formalism/PeriodIntegrals/QuotInv.lean:31-51`(`54`줄, `in_degree = 54`, `dist = 7`)은 닫힌 행렬군 $G$와 부분군 $H$의 몫 설정 `QuotientSetting`(`:31-34`) 위에서 우불변 몫측도의 상수배 유일성 `QuotInv`(`:35-40`)와 함께, 몫공간 $H \backslash G$ 위의 $L^2$ 함수와 군 $G$ 위의 $L^1$ 합성곱 핵 사이의 영(Young) 부등식 `QuotYoung`(`:41-51`)을 정식화합니다.

   $$
   \left\| f *_{G} \varphi \right\|_{L^2(H \backslash G)} \le \|f\|_{L^2(H \backslash G)} \cdot \|\varphi\|_{L^1(G)}
   $$

   이 부등식은 `SharpRestriction`과 `HermitianCurvature` 전반에서 매끄러운 헤케·시험 함수 합성곱이 궤도 $L^2$ 노름을 증폭시키지 않음을 보증하는 기초 도구로 `54`회 호출됩니다.
   한편 `Formalism/PeriodIntegrals/RhsWLim.lean:105-142`(`143`줄, `in_degree = 39`)는 의사유니터리 군 $U(H_{p,k})$ 안의 등방 비트 프레임 안정자 위에서 기저 측도 `mBase`(`:105-108`)와 반경 $\varepsilon$ 공 측도 `mBall`(`:111-114`)의 정규화 부피비 `WbData`(`:118-132`)를 구성하고, $\varepsilon \to 0^+$일 때 이 비율이 리 대수 접공간 야코비안 극한으로 수렴한다는 `RhsWLim`(`:137-142`)을 공급합니다.

4. **`PiDens.lean` (`dist = 6` 최단 거리 수출 관문의 라돈-니코딤 곱 밀도 증명)**:
   `Formalism/PeriodIntegrals/UnitaryGroupMassFormula/ArchimedeanOrbitMeasures/PiDens.lean:11-161`(`162`줄, `dist = 6`)은 명세가 아닌 순수 전술 증명 4개로만 이루어져 상단 `PublishedHypothesesFromPatching.lean`(`dist = 5`)에 직결되는 최상위 수출 파일입니다.
   - `lintegral_fin_prod`(`:11-43`) 및 `lintegral_fintype_prod`(`:44-60`): 유한 색인 집합 $\iota$(`Fintype ι`) 위의 시그마-유한 측도족 $\mu_i$에 관해 곱가측 함수 $\prod_{i \in \iota} f_i(x_i)$의 르베그 적분이 토넬리 정리와 `Fin` 귀납법에 의해 개별 적분들의 곱 $\prod_{i \in \iota} \int^- f_i\,d\mu_i$와 일치함을 증명합니다.
   - `withDensity_pi`(`:61-85`): 이를 이용해 각 좌표 측도에 밀도 $f_i$를 곱한 곱측도 `Measure.pi (fun i => (μ i).withDensity (f i))`가 원래 곱측도에 곱밀도 $\prod_i f_i(x_i)$를 취한 `(Measure.pi μ).withDensity (fun x => ∏ i, f i (x i))`와 외연적으로 완전히 같음을 증명합니다.
   - `pi_chart_dens`(`:86-161`): 유한 개의 아르키메데스 자리 차트 사상들이 유도하는 푸시포워드-풀백 측도들의 곱이 전역 아델 아르키메데스 궤도 측도와 정확히 일치함을 완결하여, 질량 공식의 무한자리 인자를 자리별 적분의 곱으로 분해합니다.

---

### 5.3 반복 리프트의 $\sigma = \frac{2}{3}$ 수준·분모 손실 장벽: 아라켈로프 사영 격자 차수 강하의 원문 복원

왜 단순한 반복 세타 리프트나 고전적 보조 다항식 구성만으로는 영점 부재 영역이 $\sigma = \frac{2}{3}$ 부근의 장벽에 가로막히며, 이 아카이브가 어떻게 이를 돌파했는지는 `Formalism/PeriodIntegrals/DivisionRowsRationalLattice.lean:62-251`(`283`줄, `in_degree = 32`)의 원문 수식을 열면 수학적으로 투명하게 드러납니다.

#### (1) 단일 사영 단계에서의 분모 $n$ 손실 공식 (`DegreeKernelLowerBound`)
수체 $K$ 위의 아라켈로프 에르미트 격자 $A : \mathrm{HLat}\,K$(기저 $\mathcal{O}_K$-격자 $L := A.L$, 기울기 상한 $\mu_{\max}(L) := \mathrm{muMaxL}\,A\,L$, 아라켈로프 차수 $\deg(L) := \mathrm{degL}\,A\,L$)와 자기수반 멱등 사영 연산자 $e \in \End_K(A.V)$ ($e^2 = e$)를 생각합니다.
연산자 $e$가 정수 격자 $L$을 그대로 보존하지 못하고 양의 정수 분모 $n \in \mathbb{N}_{>0}$을 가져 $n \cdot e(L) \subseteq L$(`IsProj A e n`, `Formalism/PeriodIntegrals/DivisionRowsRationalLattice.lean:62-65`)만을 만족할 때, 핵 절단 격자 $\mathrm{cut}_e(L) := L \cap \ker(1 - e)$와 사영 상 격자 $\mathrm{img}_e(L) := e(L)$ 사이에는 유한 비틀림 몫이 발생합니다.
`ProjectionSandwichLength`(`:74-86`)와 `GramDetKernelValuation`(`:192-196`)은 유한 소수 자리 $w$에서의 지수 손실과 그람 행렬식 부치 상승이

$$
\mathrm{idx}_w\left(\mathrm{img}_e(L),\, \mathrm{cut}_e(L)\right) \le \min\left(\dim e,\, \dim(1 - e)\right) v_w(n), \qquad v_w\left(\det h|_{\mathrm{cut}_e(L)}\right) \le 2\,\dim(1 - e)\,v_w(n)
$$

로 묶임을 보입니다.
이를 전 자리에 걸쳐 합산한 `DegreeKernelLowerBound`(`Formalism/PeriodIntegrals/DivisionRowsRationalLattice.lean:87-89`)는 단일 사영 후 아라켈로프 차수의 하한을 다음과 같이 기록합니다.

$$
\deg\left(\mathrm{cut}_e(L)\right) \ge \deg(L) - \dim_K(1 - e) \cdot \left(\mu_{\max}(L) + 2\log n\right)
$$

#### (2) 순진한 $m$회 축차 사영이 초래하는 $\sigma = \frac{2}{3}$ 장벽의 기원
만약 $m$단계 리프트 사슬 $U(X_0) \to U(X_1) \to \dots \to U(X_m)$에서 각 단계 $j = 1, \dots, m$마다 헤케·파라호릭 사영 $e_j$를 독립적으로 가하고 그 분모 손실 $2\log n_j$와 최대 기울기 상승분 $\Delta \mu_{\max}$가 단계마다 누적된다고 가정해 봅시다.
$j$번째 단계에서 기울기 상한 $\mu_{\max}(L_j)$ 자체가 이전 단계들의 분모 손실 $\sum_{i < j} O(\log x)$만큼 커지므로, $m$단계 전체에 걸친 누적 아라켈로프 높이 손실(유한 자리 분모 팽창)은 이차항 $\Omega(m^2 \cdot \mathrm{rk} \cdot \log x)$ 또는 레벨 곱 폭발 $\Omega(m^3 \log x)$을 겪게 됩니다.
반면 $m$단계 중복도 적층에서 얻는 주항 소멸 이득은 $x / m$ 창 위에서 균형식을 세울 때 $m$에 선형 비례합니다.
구체적으로 창 폭 $x / m$에서의 해석적 잔차 $x \cdot m^{-1}$과 분모 누적 비용 $m^2$을 등치시키면

$$
\frac{x}{m} \asymp m^2 \iff m \asymp x^{\frac{1}{3}} \implies \text{오차 지수 } x^{1 - \frac{1}{3}} = x^{\frac{2}{3}} \quad \left(\sigma = \frac{2}{3}\right)
$$

에 갇혀 $m$을 결코 $\sqrt{x}$까지 키울 수 없게 됩니다.

#### (3) 군환 멱등원 일괄 절단 `Conclusion4a`·`Conclusion4b`와 $2$-진 반형식 소거 `halfForm_int_host`
`Formalism/PeriodIntegrals/DivisionRowsRationalLattice.lean:125-160`의 제4보조정리(`Conclusion4a`·`Conclusion4b`)와 `:230-251`의 `L7`·`division_rows_rational_lattice`는 이 $m^2$ 누적을 **유한군 $G$의 군환 원소 $\varepsilon(P) \cdot e_G(T)$에 관한 일괄 망원 분해(telescoping decomposition)**로 단번에 해소합니다.
기저 쌍 $P_0$와 목표 쌍 $P$에 관해 `Conclusion4a`(`:136-146`)는 절단 격자의 차수와 최대 기울기가 중간 경로 길이 $m$의 제곱과 무관하게 기저 조각들의 가중합으로부터 오직 군 상수 $\lambda_G := \mathrm{laG}(G)$ 배수 오차 안에 머무름을 증명합니다.

$$
\begin{aligned}
\left|\deg\left(\mathrm{cut}_{\varepsilon(P) e_G(T)}(L)\right) - \sum_{s \in T.S} n_S(P, s)\,\deg\left(\mathrm{cut}_{\varepsilon(P_0) e_S(s)}(L)\right)\right| & \le 10\,\lambda_G\,\mathrm{rk}_T(P_0, P, L), \\
\mu_{\max}\left(\mathrm{cut}_{\varepsilon(P) e_G(T)}(L)\right) & \le \mu_{\max}\left(\mathrm{cut}_{\varepsilon(P_0) e_G(T)}(L)\right) + 10\,\lambda_G
\end{aligned}
$$

즉 최대 기울기 $\mu_{\max}$가 $m$단계 동안 선형 증가하지 않고 기저 기울기에 고정 상수 $10\,\lambda_G$를 더한 값으로 유계 고정되며(`:145`), 전 자리 지수 편차 합 역시 `Conclusion4b`(`:158`)에서 $\sum_w l_w \delta_{\mathrm{rk}}(w) \le 8\,\lambda_G\,\mathrm{rk}_T$로 묶입니다.
더불어 소수 $2$에서 이차형식 반정수성($\frac{1}{2}\mathbb{Z}$) 때문에 매 단계 $2^{-1}$ 분모가 새어 나오는 현상 역시 `Formalism/SharpRestriction/Divisibility/WeightFamilies.lean:220-265`의 정리 `halfForm_int_host`(`:224`의 `D.host.d % 16 = 7` 가설 활용)에서 호스트 판별식 합동 조건

$$
d \equiv 7 \pmod{16} \implies d + 1 = 4k, \qquad c := \frac{1 + \sqrt{-d}}{2} \in \mathcal{O}_E, \qquad 1 - c = \overline{c}
$$

을 구성함으로써 모든 격자 원소 $y$에서 $\beta(y, y) = \beta(c y + \overline{c} y, y) \in 2\mathbb{Z}$가 되게 만들어 원천 제거합니다.

---

### 5.4 3중 상쇄 메커니즘과 정수가역성(Integrality) 하한의 완결 유도

사영 격자의 대수적 기울기 누적을 막은 뒤에도, $m \approx \sqrt{x}$ 단계의 해석적 내적 공식과 주기 비율에서 발생하는 (i) 단계별 보조 헤케 지표 $\mu_j$에 따른 도체 왜곡, (ii) 개별 CM 아벨 주기의 초월적 진동, (iii) 유니터리 안정자 기본영역 부피 비율의 불확정성을 모두 상쇄해야만 최종 아라켈로프 곱공식에서 순수 정수 하한 $1 \le \prod_v |\alpha|_v$가 성립합니다.
제4기둥 `PeriodIntegrals`와 `Divisibility`·`ThetaLiftIndependence`·`PairingDivisors` 결합부는 이를 **3중 상쇄 항등식**으로 완결합니다.

#### 제1상쇄: 랄리스 시소 항등식(`SeeSaw`)과 베셀 주기의 헤케 지표 $\mu$ 독립성
`Formalism/SharpRestriction/Divisibility/FunctionModelRallisFromInputs.lean:262-629`(`660`줄)는 길이 $m$의 리프트 사슬에서 비소멸 주기가 전파되는 핵심 정리 `stmt2c`(`:305-318`)와 `stmt3c`(`:566-628`)를 증명합니다.
1. **배가 적분과 랄리스 내적 공식 (`points_of_functionModelRallis`, `:466-472`)**:
   에르미트 공간 쌍 $(A, B)$ ($\mathrm{rk}\,B = \mathrm{rk}\,A + t'$, $t' = P.t + 1$)와 분해 보조 헤케 지표 쌍 $(\chi, \chi') = (\mu_{j+1}, \mu_{j+1})$(`IsAuxiliaryHeckeCharacter`, `:510-511`)에 관해 피아트세츠키-샤피로-랄리스 배가 적분(doubling integral) `dblInt`(`:332-335`)과 지겔-베유 특수값 `SWat`(`:336-340`, 중심점 $s_0 = t'/2$)을 결합하면, 리프트된 형식 $\mathrm{lift}_3(f_1, \varphi_1), \mathrm{lift}_3(f_2, \varphi_2)$의 페테르손 내적은 `PointsLemma`(`:417-426`)에서 다음과 같이 인수분해됩니다.

   $$
   \left\langle \theta_{\mu_{j+1}}(f_2, \varphi_2),\; \theta_{\mu_{j+1}}(f_1, \varphi_1) \right\rangle_{\mathrm{Pet}, B} = c_{A, B} \cdot \mathrm{be}(\pi; f_1, f_2) \cdot \frac{L^S\left(\frac{t' + 1}{2}, \pi \times \mu_{j+1}\right)}{d_S\left(\frac{t'}{2}\right)} \cdot \prod_{v \in S} Z_v\left(\frac{t'}{2}; f_1, f_2, \varphi_1, \varphi_2\right)
   $$

   실제 전술 본문인 `stmt3c`(`Formalism/SharpRestriction/Divisibility/FunctionModelRallisFromInputs.lean:566-628`)가 이 공식을 이용해 길이 $m = D.R.m$의 정부호 보형 사슬 `DefiniteLiftChain`(`:492-500`)을 건설하는 과정은 다음 4단 연역으로 이루어집니다.
   - **기저 표현 및 보조 지표 추출 (`:568`)**: `AuxiliaryCharactersExist`로부터 보조 헤케 지표 열 $\mu : \mathbb{N} \to X.\mathrm{Chr}$과 $0$단계 기저 첨점 표현 $\pi_0 \le X.\mathrm{AF}(X_0)$(`IsLink X P 0 π0`)를 동시에 꺼냅니다.
   - **단일 단계 승격 보조정리 `step` 증명 (`:569-599`)**: 임의의 $j < m$과 현재 사슬 표현 $\pi_j$에 관해 `ChainPeriodExistence`로부터 우변 `rallisRHS ≠ 0`(`hne`, `:572`)인 벡터 쌍 $(f_1, f_2)$와 구면 시험 함수 $(\varphi_1, \varphi_2)$를 얻습니다. 완전 정부호 조건 `WittIndexCondition`(`hw`: $\mathrm{wittIdx}(X_{j+1}) = 0$) 덕분에 첫째로 `ThetaCuspidalityCondition`에서 $X.\mathrm{cusp}(X_{j+1}) = \top$이 되어 리프트 상이 자동으로 첨점 공간에 들어가고(`:583-586`), 둘째로 퇴화 소멸 조건 `V3`(`0 < wittIdx B → ...`)가 `Nat.pos_iff_ne_zero` 모순(`absurd`, `:587-588`)으로 즉시 성립합니다. 만약 리프트 $\mathrm{lift}_3(f_2, \varphi_2) = 0$이라면 좌변 페테르손 내적이 `pet_zero_left`(`:563-564`)에 의해 $0$이 되어 양수 상수 $c > 0$ 및 `rallisRHS ≠ 0`과 모순되므로(`:590-594`), `ChainLinkExistence`가 비영 다음 단계 표현 $\pi_{j+1}$(`IsLink` $\wedge$ `SumLifts`)을 반환합니다(`:598-599`).
   - **`Classical.choose`와 `Nat.rec`를 이용한 $m$단 사슬 구성 (`:600-609`)**: 선택 연산자 `nx j π`를 정의한 뒤 자연수 귀납 재귀자 `Nat.rec`으로 전체 표현 열 $\mathrm{sq} : \forall j, \mathrm{Submodule}\,\mathbb{C}\,(X.\mathrm{AF}(X_j))$를 건설합니다.
   - **전 구간 불변량 귀납 검증 (`:610-628`)**: `induction j`로 모든 $j \le m$에서 `IsChain X P μ j (sq j)`(`hsq`)와 `SumLifts X P μ j (sq j) (sq (j + 1))`(`hsum`)를 증명하여, 단계마다 첨점성과 국소 유형 `typeX P j`를 보존하는 길이 $m$의 세타 사슬을 완결합니다.
2. **시소 쌍대성과 보조 헤케 지표 $\mu$의 완전 소거 (`stmt2c`, `TwChrOne`, `EigenSwap`)**:
   반대편 부정형 타워 $(Y_{j+1}, Y_j)$와의 시소 쌍에서 `Formalism/SharpRestriction/Divisibility/FunctionModelRallisFromInputs.lean:262-263`의 `Conclusion2`(`Unfold ∧ SeeSaw`)는 시소 항등식

   $$
   \left\langle \theta_{X_j \to X_{j+1}, \mu_{j+1}}(\Phi', \varphi'),\; F \right\rangle_{X_{j+1}} = \left\langle \varphi',\; \vartheta_{Y_{j+1} \to Y_j, \mu_{j+1}}(\Phi, F) \right\rangle_{X_j}
   $$

   을 성립시킵니다.
   실제 증명인 `stmt2c`(`Formalism/SharpRestriction/Divisibility/FunctionModelRallisFromInputs.lean:305-318`)는 상단 주기 비소멸 가설 `hper : PerNZ X P.t (j + 1) ...`를 중간 단계(`j + 1 < D.R.m`, 푸리에-야코비 언폴딩 `adm2b` + `hU` 재작성, `:309-312`)와 최상단 경계 단계(`j + 1 = D.R.m`, 최고차 베셀 시소 `adm2c` + `hS` 재작성, `:313-317`)로 이분(`rcases`)하여 역방향 세타 리프트 $G = \vartheta(\Phi, F)$와의 주기 비소멸 `PerNZ X P.t j φ' G`를 하향 전달합니다.
   이때 분지 자리에서 보조 헤케 지표 $\mu_{j+1}$의 뒤틀림이 유한 레벨 분모를 오염시키지 않도록 `Formalism/PeriodIntegrals/TwChrOne.lean:230-247`의 `TwChrOne`은 파라호릭 안정자 부분군 $Q$ 위에서 뒤틀린 지표 $\chi_L|_Q \equiv 1$이 자명화됨을 보증하고, `Formalism/PeriodIntegrals/TwNormLat.lean:230-249`의 `TwNormLat`은 정규화된 격자 노름이 $\mu_{j+1}$의 선택에 무관하게 유계임을 확립합니다.
   나아가 `Formalism/ThetaLiftIndependence/Statement.lean:244-300`의 `ChainScalar`(`:244-252`), `DetSwap`(`:284-293`), `EigenSwap`(`:294-300`)은 가우스 연산자 수반 교환(`GaussOpAdj`, `:278-283`)을 이용해 정규화된 베셀 주기 비율과 합성 행렬식 고유값에서 보조 지표 $\mu_{j+1}$ 의존 인자가 분자·분모에서 정확히 약분됨을 증명합니다.

#### 제2상쇄: 차울라-셀베르그 주기 공식(`ChowlaSelbergFamily`)과 유수 평균 오일러 상수 정합
두 번째 장벽은 종단 세타 형식을 CM 아벨 주기에 대입할 때 등장하는 초월 주기 상수 `cmConst`와 유수(class group) 변동입니다.
`Formalism/SharpRestriction/Divisibility/WeightFamilies.lean:493-506`은 `FamP eps` 전역 가족 위에 차울라-셀베르그 주기 가설 `ChowlaSelbergFamily`(`:493`)를 투입하여 쿠들라 산술 가족 정리 `KudlaFamilyStatement`(`:506`)를 도출합니다.
그 정확한 대수·해석 결합식은 `Formalism/PairingDivisors/StatementH.lean:48-98`의 `LimitArith`(`:58-65`)와 `HeightBoundOfLocalValuations`(`:72-98`)에 원문 그대로 적혀 있습니다.
구체적으로 세타 평가값 $a \in K^\times$의 12거듭제곱을 보형 판별식 $\Delta^{\mathrm{wt}_M(k, \kappa)}$($v_w(\Delta) = -12\,o(w)$, `:79`)로 나눈 비인자 단면 $a^{12} \Delta^{-\mathrm{wt}_M(k, \kappa)}$의 무한자리 노름은 `:88-89`에서

$$
\left\|\sigma_v\left(a^{12}\,\Delta^{-\mathrm{wt}_M(k, \kappa)}\right)\right\| = \frac{\left(\mathrm{cmConst}(d_F, d, k, \kappa)\, L_v\right)^{12}}{D_c\left(\mathrm{cls}(v)\right)^{\mathrm{wt}_M(k, \kappa)}}, \qquad \mathrm{cmConst} = d_F^{\frac{k-1}{2}} \left(\prod_{\tau} \Gamma(k + \kappa_\tau)\right) \left(\frac{2\pi}{\sqrt{d}}\right)^{|\kappa|}
$$

로 주어집니다.
개별 이데알 유수 $c \in \mathrm{Cl}$마다 판별식 주기 $D_c$는 요동하지만, 전체 유수군 $\mathrm{Cl}$에 걸쳐 평균을 취하면 차울라-셀베르그 공식(`Formalism/PairingDivisors/StatementH.lean:63-64` 및 `:92-93`)에 의해

$$
\frac{1}{|\mathrm{Cl}|} \sum_{c \in \mathrm{Cl}} \log D_c = 12\log(2\pi) - 6\log d + 6\gamma - 6\,\Sigma_p
$$

가 성립합니다.
여기서 $(2\pi)^{12}$와 $(\sqrt{d})^{-12}$ 항은 분자의 $\mathrm{cmConst}^{12}$에 들어 있는 $(2\pi / \sqrt{d})^{12|\kappa|}$와 정확히 마주 보며 상쇄되고, 오일러-마스케로니 상수 $6\gamma$와 로그 소수 합 $-6\,\Sigma_p$는 제1장 1.4절에서 본 디리클레 $L$-함수 로그 도함수 $-\frac{L'}{L}(1, \chi)$ 주기 항등식(`Formalism/LFunctionBounds/Statement.lean:50-54`)의 $\gamma + \log(2\pi/l)$ 주항과 정밀하게 맞물립니다.
이로써 초월 주기 인자들이 모두 소거되고 `BBSize`(`Formalism/PairingDivisors/StatementH.lean:120-138`)의 선형 높이 상한 $((C_\kappa + 1)(6 + 2 C_n) + 4 + \frac{C_f}{4} + 2 C_N)\,|\Phi|\,b\,(L + \log x)$만이 남습니다.

#### 제3상쇄: 지겔-베유 정리(`VolFromSW`)와 유니터리 안정자 기본영역 등량성(`VolStabAt`)
세 번째 장벽은 $m$개 유니터리 군 $U(X_j)$ 및 등방 안정자 부분군들의 아델 기본영역 부피 $\mu(\mathcal{F}_j)$가 차원 증가에 따라 통제 불능으로 커지거나 찌그러지는 문제입니다.
`Formalism/PeriodIntegrals/VolFromSW.lean:24-136`(`137`줄)과 `Formalism/PeriodIntegrals/UnitaryGroupMassFormula/StabilizerVolume/InVolumesAtOfSWS.lean:13-26`(`27`줄, `in_degree = 64`)이 이를 해결합니다.
1. `Formalism/PeriodIntegrals/VolFromSW.lean:24-47`의 지겔-베유 평균 항등식 `SWc1`은 $n + 2 \le M$인 수렴 범위에서 에르미트 행렬 $T = \mathrm{gram}_E(X)$ 위의 세타 급수 기본영역 평균 `meanC μ 𝓕 (thetaS ...)`가 무한자리 밀도 $g_\infty(T)$와 유한자리 국소 밀도들의 오일러 곱 $\prod_v g_v(T)$와 정확히 같음을 진술합니다.

   $$
   \frac{1}{\mu(\mathcal{F})} \int_{\mathcal{F}} \sum_{X \in E^{n \times M},\; \mathrm{gram}_E(X) = T} \Phi\left(h^{-1} X\right) d\mu(h) = g_\infty(T) \prod_{v \nmid \infty} g_v(T)
   $$

2. 좌변을 궤도-안정자 측정 호환성 `IsCompatT`(`Formalism/PeriodIntegrals/VolFromSW.lean:83-90`)와 자리별 파이버 분해 `IsOmT`(`:58-82`)로 언폴딩하여 우변의 국소 밀도 곱과 약분하면, `VolStabAt`(`Formalism/PeriodIntegrals/VolFromSW.lean:91-102`)의 결론식(`:101`)에서 놀라울 만큼 간결한 **안정자 기본영역 등량 항등식**이 도출됩니다.

   $$
   \mu'\left(\mathcal{F}'\right) = \mu\left(\mathcal{F}\right)
   $$

   즉 비퇴화 튜플 안정자(`VolStab`, `:103-107`)와 등방(isotropic) 튜플 안정자(`VolumeIsotropicTuple`, `:108-113`) 모두에서 하부 안정자 기본영역 부피 $\mu'(\mathcal{F}')$가 모군 기본영역 부피 $\mu(\mathcal{F})$와 정확히 일치합니다(`volumesFromSW_of`, `:133-136`; 특수화된 사슬 적용본은 `Formalism/PeriodIntegrals/UnitaryGroupMassFormula/StabilizerVolume/InVolumesAtOfSWS.lean:21-26`의 `inVolumesAt_of_SWS` 및 유한 소수 부피 확정 정리 `Formalism/PeriodIntegrals/UnitaryGroupMassFormula/ValuationLocalVolumes/VolVFinal.lean:12-15`의 `volTypV_holds`).
   여기에 `Formalism/SharpRestriction/GlobalSchurBounds/ThickPlacesCorollaryOfAnyTranslate.lean:2330-2353`의 `volumeMass_of_unfolding`이 결합되어 전체 유니터리 속 질량 비율이 특수 $L$-값 곱으로 고정됩니다.

#### 최종 귀결: $m \approx \sqrt{x}$에서의 정수가역성 하한과 4대 기둥 폐루프 완성
위 세 축의 상쇄가 결합되면 비영 대수적 세타 주기 평가값 $\alpha \in K^\times$(`stmt3c`와 `shortNe0_of_t4Span`이 보장하는 $\alpha \ne 0$)에 관해 유한 분모 소수들 바깥의 모든 자리에서 $\alpha$는 국소 정수가 되며, 아라켈로프 곱공식

$$
\sum_{v \mid \infty} \log \|\alpha\|_v + \sum_{w \nmid \infty} \log \|\alpha\|_w = 0 \iff 1 = \prod_{v \mid \infty} \|\alpha\|_v \cdot \prod_{w \nmid \infty} \|\alpha\|_w
$$

으로부터 $\prod_{w \in \mathcal{P}_{\mathrm{forced}}} \|\alpha\|_w^{-1} \le \prod_{v \mid \infty} \|\alpha\|_v \cdot \prod_{w \in \mathcal{P}_{\mathrm{denom}}} \|\alpha\|_w$라는 전역 정수가역성 하한이 성립합니다.
분모 손실 $\prod_{w \in \mathcal{P}_{\mathrm{denom}}} \|\alpha\|_w$가 $\sigma = 2/3$ 장벽을 유발하던 $m^2$ 누적 없이 선형 범위 안에 묶여 있으므로 사슬 길이 $m$을 최대 허용 창 $m \asymp \sqrt{x}$(`Formalism/SharpRestriction/InertJacobiLevels/AsmIface.lean:142`)까지 밀어 올릴 수 있습니다.

---

### 5.5 4대 기둥 종단 용접부(`TieGlobal.lean` · `CoreGm.lean`)의 31개 데이터 필드 및 최종 전술 증명 해부

본 권의 마무리를 위해, 제2장~제5장에서 해부한 4대 기둥의 모든 출력물들이 단일 구조체 `Dd : Data φ.A Word Top m f`로 합류하는 `Formalism/SharpRestriction/GlobalSchurBounds/TieGlobal.lean:15-124`(`127`줄, `dist = 8`)와 그 바로 위에서 최종 부등식을 도출하는 `Development/AutomorphicArithmetic/PrimitiveCosets/CoreGm.lean:12-74`(`74`줄, `dist = 5`)의 전술 본문을 줄 단위로 대조 복원합니다.

#### (1) 유체론 아르틴 상호법칙 사상 `recOf`와 4중 결속 술어 (`Formalism/SharpRestriction/GlobalSchurBounds/TieGlobal.lean:24-95`)
`Formalism/SharpRestriction/GlobalSchurBounds/TieGlobal.lean:24-35`는 호스트 원시 지표 수준 $H : \mathrm{HostRaw}\,\varphi$의 도체 법 $(\mathbb{Z} / H.\mathrm{condN}\,\mathbb{Z})^\times$에서 유한 아벨군 $E_0 \times \varphi.A$($E_0 = \mathbb{Z}/2\mathbb{Z} \times \mathbb{Z}/2\mathbb{Z}$ 부호군)로 가는 곱셈 군 준동형사상 `recOf H`를 아르틴 기호 `H.art u`로 정의하고, 이를 유체론 산술 데이터 `arithOf H := cftData H.q H.d (recOf H)`(`:34`)로 포장합니다.

그 위에서 매개변수 가족 `Fm : FamP eps`의 구체적 인스턴스 `Fm.D x (pt u0)` 및 `Fm.L x (pt u0)`가 추상 사슬 데이터 `Dd`의 **전역 필드 16개(`TieGlobal`, `:50-62`)** 및 **국소·아라켈로프 필드 15개(`TieLocal`, `:63-83`)**와 1대1 등식으로 묶입니다.

| 구분 | `Dd` 데이터 필드 (`TieGlobal.lean`) | 행 번호 | 바인딩되는 원문 기둥 값 | 공급 기둥 및 수리적 정체 |
| :--- | :--- | ---: | :--- | :--- |
| **`TiePts`** | `toFrame`, `m`, `f`, `q`, `d`, `u0`, `aT`, `bT` | `39-47` | `(Fm.D x (pt u0)).R` 및 `host` 매개변수 | `SharpRestriction.InertJacobiLevels` (`Formalism/SharpRestriction/InertJacobiLevels/AsmIface.lean:142-145`) |
| **`TieGlobal` `1`** | `Dd.a`, `Dd.b`, `Dd.b'`, `Dd.k`, `Dd.L` | `53-54` | `(Fm.L x (pt u0)).sc` 및 `R.k` | `SharpRestriction` 척도 창 (`k ≈ x^(9/2+10ε)`, `m ≈ √x`) |
| **`TieGlobal` `2`** | `Dd.La`, `Dd.B0`, `Dd.Nc` | `54-55` | `(Fm.L x (pt u0)).La`, `B0`, `Nc` | `HermitianCurvature` 격자 공분산·상자 크기 (`Formalism/HermitianCurvature/LatticeHerglotzBound.lean:90-97`) |
| **`TieGlobal` `3`** | `Dd.gam`, `Dd.LpL` | `56` | `eulerMascheroniConstant`, `logDerivativeAtOne` | `Formalism/StatementOC.lean:20-22` 및 차울라-셀베르그 `Formalism/PairingDivisors/StatementH.lean:63-64` |
| **`TieGlobal` `4`** | `Dd.v`, `Dd.lg`, `Dd.logGam` | `57-59` | `host.v`, `log(g 0 * g 1)`, `log(GamL)` | 아르키메데스 감마 인자 및 호스트 소수 쌍 로그 크기 (`LogGammaLe`) |
| **`TieGlobal` `5`** | `Xpp`, `η`, `X'` | `60-61` | `sc.X'' R.n`, `etaSz`, `sc.X'` | 체 절단 상한 $X''(n)$ 및 두꺼운 집합 밀도 $\eta_{\mathrm{Sz}}$ (`Formalism/SharpRestriction/ParConsts.lean:89`) |
| **`TieLocal` `1`** | `Dd.d`, `Dd.T`, `Dd.h` | `67-71` | `(div.Nu u).rank`, `(mem u).A.T`, `div.h u` | `LocalToGlobal.Divisibility` 핵 계수 및 6항 명시 높이 `hExpl6`(`Formalism/SharpRestriction/ParConsts.lean:73`) |
| **`TieLocal` `2`** | `Dd.muN`, `Dd.muMaxN`, `Dd.muM`, `Dd.muMaxM` | `69-73` | `(div.Nu u).mu`, `muMax`, `(fm u).lat 0` | `PeriodIntegrals` 사영 격자 아라켈로프 평균·최대 기울기 (`DivisionRows:136-146`) |
| **`TieLocal` `3`** | `Dd.EeJ u0 u j` (`j : Fin m`) | `74-75` | `∑ w ∈ supp, sz w (E u (j+1) w)` | `LocalToGlobal` $m$단계 연결고리별 국소 지수 합 (`LinksStage`·`BaseLiftsPackage`) |
| **`TieLocal` `4`** | `Dd.muCC`, `Dd.muMinCC` | `76-77` | `div.RR.muDual`, `div.RR.muMinDual` | 랄리스 쌍대 격자 기울기 하한 (`Formalism/SharpRestriction/Divisibility/FunctionModelRallisFromInputs.lean:417-426`) |
| **`TieLocal` `5`** | `Dd.Fo`, `Dd.Ga`, `Dd.Ta`, `Dd.IO`, `Dd.del` | `78-83` | `Fo`, `Ga`, `∑ sz(tau w)`, `∑ lwP * ramIdx * io`, `delp` | 형식차수(`ThickPlaces:2261`), 분지 지수(`LocCoh`·`DataNLoc`), 국소 부피(`VolFromSW`) |
| **`TieArith`** | `TT`, `T2`, `a`, `w`, `ell` | `84-94` | `TTn`, `dig`, `wj`, `logDerivativeAtOne χ` | 보형 가중치 `wj`와 원시 디리클레 지표 로그 도함수 `-L'/L(1, χ)`의 산술 일치 |

#### (2) `ChainTied`의 8대 종결 절과 `ChainTied.core_of` (`Formalism/SharpRestriction/GlobalSchurBounds/TieGlobal.lean:97-124`)
위의 4중 등식(`TiePts ∧ TieGlobal ∧ TieLocal ∧ TieArith`, `:104-106`)이 성립하면, `ChainTied`(`:97-115`)는 오차 지수 상한 `C.eDiv ≤ eD`, `C.eLoss ≤ eL`, `C.cHH ≤ cHH`(`:107`)와 함께 4대 기둥이 증명한 7개의 핵심 사슬 정리를 연언(conjunction)으로 묶습니다.

1. **`Ident Dd ...` (`:108`)**: 보형 세타 평가 합과 가중 폰 망골트·지표 로그 도함수 합 사이의 대수적 항등식(`LocalToGlobal` + `PeriodIntegrals` 3중 상쇄의 산출물).
2. **`LChain.SizeData₂ Dd C Xpp` (`:109`)**: 모든 보조 격자 계수·기울기·부피 변수들이 척도 창 안에 들어온다는 크기 검증(`SharpRestriction.GrowthBounds`).
3. **`ErrWindows Dd C Xpp eK K` (`:110`)**: 사영 푸앵카레 그람 노름과 아르키메데스 곡률 절단 오차가 $x^{(e_D + e_L + 3)\varepsilon}$ 창을 넘지 않는다는 오차 상한(`RelevantZeroGramTerms` + `HermitianCurvature`).
4. **`BNBounds Dd T2` (`:111`)**: 예외적 분지·도약 집합 `T2`의 원소 개수 및 브라우어-네스비트 갈루아 차수 상한(`ExistsInertiaCharpolyFactorOfTameType`).
5. **`GrowthInequalityRemainingHyps ...` (`:112`)**: 체비쇼프 평균 전환 및 호스트 로그 도함수 경계 가설(`ExplicitFormulaErrorOfHostConditions`).
6. **`CostWindows x ...` (`:113`)**: 두꺼운 소수 자리 선택 비용과 밀도 $\eta$ 사이의 수지 균형 부등식.
7. **`RestSize eps x ...` (`:114`)**: 여집합 잔여 항들의 조합론적 크기가 주항 대비 $x^{-\varepsilon}$ 이하로 소멸한다는 잉여 크기 조건.

정리 `ChainTied.core_of`(`Formalism/SharpRestriction/GlobalSchurBounds/TieGlobal.lean:116-124`)는 단 5줄의 `obtain` + `exact` 전술로 위 `ChainTied` 증인과 호스트 유체론 사실 `hF i0`를 묶어 `ChainCore eD eL K cHH eK CL eps x` 타입의 닫힌 증인을 즉시 반환합니다.

#### (3) `Development/AutomorphicArithmetic/PrimitiveCosets/CoreGm.lean:12-74` 전술 본문의 마지막 7단 연역 복원
이제 `Development/AutomorphicArithmetic/PrimitiveCosets/CoreGm.lean:12-74`에서 정리 `UpperTheory.Comparison₂.core_gm`이 어떻게 두 입력 `hE : EAtH Λ H.toHostRaw TT x eps C`와 `hCore : CoreAtH H.toHostRaw TT eD eL K cHH eK eps x`(`ChainCore`의 호스트 투영본)로부터 최종 부등식을 완성하는지 줄 번호 그대로 복원합니다.

1. **가중치 유계성 확인 (`Development/AutomorphicArithmetic/PrimitiveCosets/CoreGm.lean:17-20`)**:
   지표 부분군 위수 $\Lambda.o \ge 0$으로부터 코셋 가중치 절댓값 부등식 $|(3\,\Lambda.o + 1)^{-1}| \le 1$을 `positivity`와 `inv_le_one_of_one_le₀`로 확보합니다.
2. **세 문턱값 $x_1, x_2, x_3$ 선택 및 최댓값 고정 (`Development/AutomorphicArithmetic/PrimitiveCosets/CoreGm.lean:21-29`)**:
   - `Deduction.ch_core`에서 사슬 추론 문턱값 $x_1$을 뽑고(`:21-22`),
   - `large_x_eventually`에서 점근 상수 문턱값 $x_2$를 뽑으며(`:23`),
   - `tendsto_rpow_atTop`에서 다항식 흡수 조건 $1 + 4\,\Lambda.o \le x^\varepsilon$을 만족하는 문턱값 $x_3$을 뽑아(`:24-25`),
   최종 시작점을 $\max(x_1, \max(x_2, x_3))$으로 잡습니다(`:26`).
3. **4대 기둥 증인 36개 해체 (`Development/AutomorphicArithmetic/PrimitiveCosets/CoreGm.lean:30-37`)**:
   `obtain`으로 `hCore` 내부의 36개 존재 증인(`U0, i0, tr, W, ..., Dd, Cc, Xpp, ell, N, T2, a, w, eT, eP, η, X', θ` 및 `hId`, `hLed`, `hWin`, `hBN`, `hSz`, `hThin`, `hCost`, `hRest`, `hT2`)과 창 부등식 `w1`~`w27`, 상수 조건 `c1`~`c17`을 일거에 풀어냅니다.
4. **오차 지수 정렬 (`Development/AutomorphicArithmetic/PrimitiveCosets/CoreGm.lean:51-54`)**:
   합산 오차 상수 `CErr Cc`가 $e_D + e_L + 3$ 이하임을 `linarith`로 확인하여(`hExp`), 상단 사슬 오차 인자를 $x^{(e_D + e_L + 3)\varepsilon}$으로 정렬합니다.
5. **최상단 상자 추론 `ch_top` 및 `ch_core` 결합 (`Development/AutomorphicArithmetic/PrimitiveCosets/CoreGm.lean:55-60`)**:
   모든 피복 원소 $u \in TT$에서 `Deduction.ch_top`과 `hExp`를 합성하여 `hmain` 부등식을 얻습니다.
6. **선형 결합 잔차 $\Lambda.\mathrm{Gm}(x)$ 치환 (`Development/AutomorphicArithmetic/PrimitiveCosets/CoreGm.lean:61-62`)**:
   등식 `gmA_eq`(`:61`)로 추상 선형 결합을 실제 제타·디리클레 잔차 합 $\Lambda.\mathrm{Gm}(x)$로 치환하고, 예외 부호 항 상한 `sigA_le`(`:62`)를 결합합니다.
7. **지수 법칙 `x^ε * x^(1/2 + (eD+eL+6)ε)` 마감 (`Development/AutomorphicArithmetic/PrimitiveCosets/CoreGm.lean:63-74`)**:
   체비쇼프 평균 손실분 $+3\varepsilon$이 더해진 지수 $\frac{1}{2} + (e_D + e_L + 6)\varepsilon$에 문턱값 $x \ge x_3$에서 확보한 상수 흡수 인자 $1 + 4\,\Lambda.o \le x^\varepsilon$을 곱하여(`h2`, `Real.rpow_add`, `:65-69`)

   $$
   (1 + 4\,\Lambda.o)\,x^{\frac{1}{2} + (e_D + e_L + 6)\varepsilon} \le x^\varepsilon \cdot x^{\frac{1}{2} + (e_D + e_L + 6)\varepsilon} = x^{\frac{1}{2} + (e_D + e_L + 7)\varepsilon}
   $$

   을 얻고, 마지막 줄 `:74`의 `linarith` 한 줄로

   $$
   \Lambda.\mathrm{Gm}(x) \le x^{\frac{1}{2} + (e_D + e_L + 7)\varepsilon}
   $$

   의 커널 증명을 종결합니다.

---

### 5.6 4대 기둥 핵심 방정식 5단 폐루프 요약 및 직독 모듈 `58`선 전수 색인

본 제3부에서 역컴파일한 `Formalism` 4대 기둥(`14,866`개 파일, `2,577,937`줄, 선언 `196,578`개)의 인간 수학적 작동 원리를 5단 등식·부등식 체인으로 압축하면 다음과 같습니다.

1. **제1기둥(`LocalToGlobal`) $m$단 보형 중복도 적층**:
   척도 창 $\sqrt{x\,\delta_1} \le m \le 2\sqrt{x\,\delta_1}$ 위에서 완전 정부호 유니터리 사슬 $U(X_0) \to \dots \to U(X_m)$의 합성 그람 연산자는 단계마다 $+1$겹의 양수 스칼라 고유값을 곱셈적으로 적층하며(`thmBop_of`), 무미분 단축 평가 `ShortValAt`에서 비영 대수적 주기비 $\alpha \ne 0$을 생성합니다.

   $$
   \left(\Theta_t \circ \Theta_t^*\right)(e) = \left(\kappa \prod_{j=0}^{m-1} \lambda_{j, t, p, v_0}\right) e, \qquad \det(A) = \kappa^{\dim_{\mathbb{C}} E} \prod_{j=0}^{m-1} \det(B_j)
   $$

2. **제2기둥(`SharpRestriction`) 코커널 제곱합·슈어 그람 상한**:
   가우스 합의 점별 위상 상쇄나 단독 $\mathrm{GL}_5$ 6중 피복군 없이 코커널 동치류 재귀 제곱합(`Kk_succ`), 2유형 코시-슈바르츠 제곱평균($5^{-j_0}$ 감쇠), C*-연속 함수 미적분 슈어 보조정리(`schur_UJ`)로 사영 푸앵카레 그람 연산자 $K(u, u')$의 노름을 통제합니다.

   $$
   K_{r+1}(w, w') = \sum_{c \in \mathrm{Cls}_r(M)} \frac{\mathrm{BB}(M; w, c)\,\overline{\mathrm{BB}(M; w', c)}}{|\Aut(c)|}
   $$

3. **제3기둥(`HermitianCurvature`) 아르키메데스 곡률 양수성과 헤르글로츠 부등식**:
   양자 소행렬식 곡률 간격 $G_f(g) \ge \varepsilon > 0$과 커널 `addDecl` 기반 콤팩트 지지 쌍둥이 생성기(`CutCptCopy`)로 최고차 스펙트럼 밀도의 비음수성(`TopDensNonneg`)을 확립하고, 무한자리 격자 합을 양정치 보정 푸리에 급수로 상한합니다.

   $$
   0 \le \left\langle \left((\kappa f)\,\Phi\right)(c, g),\; \Phi(c, g) \right\rangle_{\mathrm{HS}}, \qquad \mathrm{covol}(\Lambda) \sum_{z \in S} N(z) \le \sum_{\sigma \in \Lambda^\vee} \left\|\widehat{N}(\sigma) + A(\sigma)\right\|
   $$

4. **제4기둥(`PeriodIntegrals`) $\sigma = \frac{2}{3}$ 분모 장벽 타파 및 3중 상쇄**:
   군환 멱등원 망원 분해(`Conclusion4a`)와 $d \equiv 7 \pmod{16}$ 반형식 소거(`halfForm_int_host`), 랄리스 시소 $\mu$-독립성(`stmt2c`·`TwChrOne`), 차울라-셀베르그 유수 평균(`LimitArith`), 지겔-베유 안정자 기본영역 등량성 $\mu'(\mathcal{F}') = \mu(\mathcal{F})$(`VolStabAt`)를 결합해 $m^2$ 분모 누적을 선형 오차 $10\,\lambda_G\,\mathrm{rk}_T$ 안으로 압축합니다.

5. **최상단 용접(`TieGlobal` $\to$ `CoreGm`)과 임계선 $\Re(s) = \frac{1}{2}$ 수렴**:
   위 네 기둥이 공급한 `36`개 존재 증인은 $\varepsilon \in (0, 1/52)$ 전역 가족 위에서 단측 명시 공식 부등식

   $$
   \Lambda.\mathrm{Gm}(x) \le x^{\frac{1}{2} + (e_D + e_L + 7)\varepsilon}
   $$

   을 완결하며, $\varepsilon \to 0^+$ 극한에서 리만 제타 함수와 모든 원시 디리클레 $L$-함수의 반평면 $\Re(s) > \frac{1}{2}$ 영점 부재를 도출합니다.

마지막으로 본 제3부 전 장에 걸쳐 원문을 직접 열람하고 수식을 역컴파일한 대표 핵심 허브·증명 모듈 `58`선과 Part B 전수 도감(`B01`~`B04`)의 교차 열람 색인표를 수록합니다.

| 수록 장 | 원문 파일 경로 및 전체 줄 범위 (`src/` 기준) | 줄 수 | `in_deg` | `dist` | 도감 구분 | 역컴파일된 핵심 수리 객체 및 정리 |
| :--- | :--- | ---: | ---: | ---: | :--- | :--- |
| 제1장 | `Formalism/Statement.lean:1-50` | `50` | `2` | `9` | 명세 리프 | 체비쇼프 가중 잔차 `G(x)` 및 단측 란다우 귀류 `RHofG` |
| 제1장 | `Formalism/StatementOC.lean:1-73` | `73` | `6` | `8` | 명세 리프 | 디리클레 지표 잔차 `Gchi(x)` 및 평균 창 `OCAvg` |
| 제1장 | `Formalism/StatementU.lean:1-47` | `47` | `5` | `10` | 명세 리프 | 이산 창 평균 `wavg` 및 멜린-란다우 명세 `ZetaLandauBarEps` |
| 제1장 | `Formalism/StatementCM.lean:1-45` | `45` | `3` | `13` | 명세 리프 | CM 반유형 `HalfTypes` 및 강제 합동류 합 `ForcedSumCM` |
| 제1장 | `Formalism/StatementFL.lean:1-44` | `44` | `1` | `15` | 명세 리프 | 홀수 지표 가족 선형 결합 `famComb` 및 `FamilyLandauCW3` |
| 제1장 | `Development/AutomorphicArithmetic/PrimitiveCosets/CoreGm.lean:1-74` | `74` | `1` | `5` | 최상단 용접 | `EAtH` + `CoreAtH` 결합 지수 상한 `core_gm` (`dist = 5`) |
| 제2장 | `Formalism/LocalToGlobal/IndefiniteReal/LinksStage.lean:1-315` | `315` | `524` | `7` | `B01` 허브 | $m$단 유니터리 타워 `Yc D i`, 시소 쌍 및 19필드 `Inputs` |
| 제2장 | `Formalism/LocalToGlobal/ProjectiveLattices/AllTest.lean:1-16` | `16` | `452` | `8` | `B01` 허브 | 사영 격자 전칭 시험 배치 래퍼 `AllTest` |
| 제2장 | `Formalism/LocalToGlobal/SiegelLatticeTheory/CokernelGLCounts/NGData.lean:1-128` | `128` | `339` | `10` | `B01` 허브 | 비일반 궤도 코시-슈바르츠 증폭 비율 `a2C` 및 계수 상한 |
| 제2장 | `Formalism/LocalToGlobal/IndefiniteReal/FWExist.lean:1-803` | `803` | `275` | `8` | `B01` 허브 | 프레임-비트 기저 확장 `extB` 및 최상단 격자 정수성 |
| 제2장 | `Formalism/LocalToGlobal/IndefiniteReal/DatumVec.lean:1-214` | `214` | `255` | `7` | `B01` 허브 | 아델 순수 텐서 시험 벡터 `pureTensorO` 및 멱등합 `IsIdemSum` |
| 제2장 | `Formalism/LocalToGlobal/IndefiniteReal/ConcretePkgSpec.lean:1-234` | `234` | `226` | `8` | `B01` 허브 | 30필드 `cxLinks` 전술 증명 및 구체 패키지 `concretePkg_spec` |
| 제2장 | `Formalism/LocalToGlobal/IndefiniteReal/BaseLiftsPackageOfPrimitiveLinks.lean:1-367` | `367` | `223` | `7` | `B01` 허브 | 위상 소거 `phase_cancel`, $m$중 그람 고유값 곱 `thmBop_of` |
| 제2장 | `Formalism/LocalToGlobal/IndefiniteReal/ZeroPartEigenvalueConvention.lean:1-282` | `282` | `217` | `8` | `B01` 허브 | 영 고유값 위상 정규화 `Face3` 및 `WeakCharacterisation` |
| 제2장 | `Formalism/LocalToGlobal/IndefiniteForms/IndefiniteTree/RealCubicMeans/LogMeanShares/LogMeanStatements/HSClaim.lean:1-24` | `24` | `208` | `10` | `B01` 허브 | 부정형 나무 분기 로그 평균 점유율 부등식 `HSClaimS` |
| 제2장 | `Formalism/LocalToGlobal/ProjectiveLattices/ThShort.lean:1-355` | `355` | `207` | `9` | `B01` 허브 | 무미분 단축 평가 `ShortValAt` 및 비영 생성 `shortNe0_of_t4Span` |
| 제2장 | `Formalism/LocalToGlobal/ProjectiveLattices/FreeBridge.lean:1-120` | `120` | `204` | `9` | `B01` 허브 | 자유 격자 표현과 사영 아벨 단면 동치 `noCommonZero_iff` |
| 제2장 | `Formalism/LocalToGlobal/BesselHermitianTheta/AllTied.lean:1-43` | `43` | `197` | `7` | `B01` 허브 | 베셀-에르미트-세타 10필드 총괄 결합 레코드 `AllTied` |
| 제2장 | `Formalism/LocalToGlobal/SiegelLatticeTheory/ClosedLocalOrbits/TermLoc.lean:1-412` | `412` | `190` | `9` | `B01` 허브 | 닫힌 국소 궤도 안정자 질량 `MassDat` 및 `recBBTie_of` |
| 제2장 | `Formalism/LocalToGlobal/IndefiniteReal/FinitePlaces/VacExA.lean:1-459` | `459` | `3` | `6` | `B01` 수출 | 유한 자리 파라호릭 진공 시험 벡터 존재성 (`dist = 6`) |
| 제2장 | `Formalism/LocalToGlobal/IndefiniteReal/LevelTypeEquivalence/UnimodInst.lean:1-292` | `292` | `27` | `6` | `B01` 수출 | 레벨-유형 동치 유니모듈러 하르 측도 인스턴스 (`dist = 6`) |
| 제2장 | `Formalism/LocalToGlobal/IndefiniteReal/HeckeNonvanishing/Imports.lean:1-8` | `8` | `45` | `7` | `B01` 전술 | 고차 단일화 우회 커스텀 전술 엘라보레이터 `kexactB` |
| 제2장 | `CompanionTheory/SpectralGeometry/LocalGlobalProofs/StableLattices/HeckeNonVanishing.lean:1-112` | `112` | `1` | `8` | 동반 증명 | 카펠리 가환 작용소 멱영 핵 소거 헤케 비소멸 `nonVan` |
| 제3장 | `Formalism/SharpRestriction/Divisibility/GeneratorPowers/ThExprUniqOfChartIndep2.lean:1-41` | `41` | `873` | `9` | `B02` 허브 | 차트 독립 소수 거듭제곱 격자 이동 유일성 (전체 2위 허브) |
| 제3장 | `Formalism/SharpRestriction/LevelLetterCocycles/LocCoh.lean:1-195` | `195` | `654` | `7` | `B02` 허브 | 블로흐-카토 결정·드람 코호몰로지 및 국소 테이트 쌍대성 |
| 제3장 | `Formalism/SharpRestriction/LevelLetterCocycles/LocalSituation.lean:1-641` | `641` | `627` | `7` | `B02` 허브 | 30필드 $p$-진 갈루아 리프팅 상황 `Sit` 및 균일 상수 |
| 제3장 | `Formalism/SharpRestriction/CuspSpanNormBounds/FractionFieldToGenericStalkAlgebraMapEq.lean:1-282` | `282` | `400` | `9` | `B02` 허브 | 코커널 동치류 재귀 제곱합 전개 보조정리 `Kk_succ` |
| 제3장 | `Formalism/SharpRestriction/Divisibility/SchurIrreducible.lean:1-617` | `617` | `377` | `7` | `B02` 허브 | 이산계열 블라트너 매개변수 및 국소 아르키메데스 랄리스 공식 |
| 제3장 | `Formalism/SharpRestriction/ParConsts.lean:1-103` | `103` | `224` | `7` | `B02` 허브 | 전역 매개변수 창 `FamP`, 리터럴 고정 상수 및 `DFamP` (`eps < 1/52`) |
| 제3장 | `Formalism/SharpRestriction/CuspSpanNormBounds/RelevantZeroGramTerms.lean:1-573` | `573` | `201` | `7` | `B02` 허브 | 사영 푸앵카레 그람 연산자 `Kmat`의 5중 세포 분해 |
| 제3장 | `Formalism/SharpRestriction/InertJacobiLevels/AsmIface.lean:1-221` | `221` | `191` | `7` | `B02` 허브 | 매개변수 척도 창 `(m, n, k)` 및 5진 레벨 깊이 `j0` 고정 |
| 제3장 | `Formalism/SharpRestriction/GlobalSchurBounds/ThickPlacesCorollaryOfAnyTranslate.lean:1-2354` | `2,354` | `189` | `7` | `B02` 허브 | 모든 유니터리 군 형식차수 다항식 상하한 및 언폴딩 부피비 |
| 제3장 | `Formalism/SharpRestriction/LevelLetterCocycles/DataNLoc.lean:1-1260` | `1,260` | `188` | `7` | `B02` 허브 | 바흐-헤르 $(\varphi, \Gamma)$-격자 `LocLat` 및 결정 비교 `LocCmpT` |
| 제3장 | `Formalism/SharpRestriction/GlobalSchurBounds/GeneralLinearActions/GenusMassVolumes.lean:1-399` | `399` | `183` | `7` | `B02` 허브 | CM 에르미트 속 베유·실수·궤도 측도 정합 `IsCompatible` |
| 제3장 | `Formalism/SharpRestriction/LevelLetterCocycles/ExistsInertiaCharpolyFactorOfTameType.lean:1-1739` | `1,739` | `172` | `8` | `B02` 허브 | 브라우어-네스비트 정리 및 완만 관성 특성다항식 인수 분리 |
| 제3장 | `Formalism/SharpRestriction/CuspSpanNormBounds/BridgeCSchur.lean:1-635` | `635` | `29` | `9` | `B02` 증명 | 연속 함수 미적분(`CFC`) 기반 무투영 슈어 보조정리 `schur_UJ` |
| 제3장 | `Formalism/SharpRestriction/ValuationFrobeniusEpsilon/UnitaryThreeHeightBounds.lean:1-982` | `982` | `2` | `15` | `B02` 증명 | $U(3)$ 갈루아 변형 환 가우스·비분해 높이 다항식 상한 |
| 제3장 | `Formalism/SharpRestriction/RamificationFrobenius/TotientGaloisClasses/ExplicitFormulaErrorOfHostConditions.lean:1-168` | `168` | `10` | `7` | `B02` 수출 | 지표군 선형 결합 `Gm(y)` 및 명시 공식 오차 `EAtH` 도출 |
| 제3장 | `Formalism/SharpRestriction/GlobalSchurBounds/TieGlobal.lean:1-127` | `127` | `2` | `8` | `B02` 용접 | 31개 전역·국소 필드 결속 `ChainTied` 및 `ChainTied.core_of` |
| 제4장 | `Formalism/HermitianCurvature/StatementQ.lean:1-1119` | `1,119` | `90` | `10` | `B03` 허브 | 양자 소행렬식 행 전개 `qminorRow` 및 제타 교환 `ZetaComm` |
| 제4장 | `Formalism/HermitianCurvature/WeylElementCommutesLevelOne.lean:1-496` | `496` | `78` | `7` | `B03` 수출 | 레벨 1 바일 원소 교환성 및 정칙화 쌍 출력 `LemmaBDouble` |
| 제4장 | `Formalism/HermitianCurvature/HermitianCurvatureProofs/RegularisedPairingViaPhase.lean:1-897` | `897` | `70` | `11` | `B03` 증명 | 역순 리 미분 단어 부분적분 `word_adj` 및 `phase_function_adjoint` |
| 제4장 | `Formalism/HermitianCurvature/HermitianCurvatureProofs/BetaSesquilinearity.lean:1-1532` | `1,532` | `66` | `10` | `B03` 증명 | 의사유니터리 지수 닫힘성 `exp_mem` 및 대각·등식 극한 조립 |
| 제4장 | `Formalism/HermitianCurvature/BesselNonvanishingReduction.lean:1-481` | `481` | `60` | `9` | `B03` 허브 | 재생핵 `Repro` 및 아르키메데스 베셀 비소멸 환원 |
| 제4장 | `Formalism/HermitianCurvature/TopDensNonnegOfKappa.lean:1-182` | `182` | `12` | `10` | `B03` 허브 | 4생성자 귀납 원뿔 `HerGen` 및 곡률 양수성 `XKappa` $\implies$ `TopDensNonneg` |
| 제4장 | `Formalism/HermitianCurvature/LatticeHerglotzBound.lean:1-167` | `167` | `10` | `13` | `B03` 허브 | 불변 평균 분해 `MeanSplit` 및 격자 헤르글로츠-페예르 부등식 |
| 제4장 | `Formalism/HermitianCurvature/HermitianCurvatureProofs/TheoremPIntegralOfPlaces.lean:1-935` | `935` | `32` | `11` | `B03` 증명 | 양자 소행렬식 곡률 `Gf` 매끄러움 및 무한자리 곱 적분 |
| 제4장 | `Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptCopy.lean:1-91` | `91` | `1` | `17` | `B03` 메타 | 커널 `addDecl` 기반 콤팩트 지지 쌍둥이 정리 자동 생성기 |
| 제4장 | `Formalism/HermitianCurvature/HermitianCurvatureProofs/CutCptManual.lean:1-551` | `551` | `1` | `17` | `B03` 증명 | 콤팩트 지지 코시-슈바르츠 `form_csCpt` 및 절단 극한 양수성 |
| 제5장 | `Formalism/PeriodIntegrals/DSInfCharCap.lean:1-47` | `47` | `91` | `7` | `B04` 허브 | 카펠리 양자 행렬식과 이산계열 무한소 지표 스칼라 일치 |
| 제5장 | `Formalism/PeriodIntegrals/UnitaryGroupMassFormula/StabilizerVolume/InVolumesAtOfSWS.lean:1-27` | `27` | `64` | `9` | `B04` 허브 | 지겔-베유 가설로부터 안정자 부피 도출 `inVolumesAt_of_SWS` |
| 제5장 | `Formalism/PeriodIntegrals/QuotInv.lean:1-54` | `54` | `54` | `7` | `B04` 허브 | 우불변 몫측도 유일성 `QuotInv` 및 합성곱 영 부등식 `QuotYoung` |
| 제5장 | `Formalism/PeriodIntegrals/BesselMapUniq.lean:1-61` | `61` | `35` | `7` | `B04` 허브 | 카셀만-월러크 매끄러운 베셀 범함수 1차원 유일성 |
| 제5장 | `Formalism/PeriodIntegrals/DivisionRowsRationalLattice.lean:1-283` | `283` | `32` | `11` | `B04` 허브 | 사영 격자 차수 하한 `DegreeKernelLowerBound` 및 망원 상쇄 `Conclusion4` |
| 제5장 | `Formalism/PeriodIntegrals/VolFromSW.lean:1-137` | `137` | `17` | `11` | `B04` 허브 | 지겔-베유 평균 항등식 `SWc1` $\implies$ 안정자 기본영역 등량성 `VolStabAt` |
| 제5장 | `Formalism/PeriodIntegrals/UnitaryGroupMassFormula/ArchimedeanOrbitMeasures/PiDens.lean:1-162` | `162` | `4` | `6` | `B04` 수출 | 곱측도 라돈-니코딤 차트 밀도 인수분해 `pi_chart_dens` (`dist = 6`) |
| 제5장 | `Formalism/SharpRestriction/Divisibility/FunctionModelRallisFromInputs.lean:1-660` | `660` | `2` | `14` | 시소 결합 | 랄리스 시소 `stmt2c` 및 $m$단 정부호 리프트 사슬 귀납 건설 `stmt3c` |
| 제5장 | `Formalism/PairingDivisors/StatementH.lean:1-139` | `139` | `484` | `7` | 높이 결합 | 차울라-셀베르그 유수 평균 `LimitArith` 및 아라켈로프 높이 상한 `BBSize` |

이로써 `Formalism` 4대 기둥 `14,866`개 파일(`2,577,937`줄, `196,578`개 선언)이 하부 리 군 곡률·유니터리 질량·반복 파르세발·세타 중복도 사슬로부터 출발하여 최상단 리만 가설 및 디리클레 일반화 리만 가설의 임계선 지수 $\frac{1}{2}$을 사용자 추가 공리 `0`건(표준 3공리 이하)·무손실로 도출하는 전 과정의 수리 포렌식 복원이 완료되었습니다.

