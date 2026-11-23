# 제2부. 기출 201선 직접 임포트 및 PublishedTheorems(1,073개) 의미론 동치성 감사

- **대상 범위**: `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/EveryCharacterOfLiteratureOfVWin.lean:1-814`, 직접 로컬 임포트 `201`개 전수(`12,171`줄), 아카이브 전체 `PublishedTheorems` 계층 `1,073`개 파일(`107,246`줄), 상위 무가정 결합부 `Development/AutomorphicArithmetic/CharacterBoxes/MainConclusion.lean:1-14` 전 영역을 포괄합니다.
- **연동 전수 도감**: Part B 제9권(`atlas/volumes/B09_PublishedTheorems_1073_And_201_Imports.md`, 고유 모듈 `1,258`개 · `119,064`줄 · 선언 `8,243`개) 및 `atlas/data/published_theorems_and_201_imports.jsonl` 데이터베이스와 1대1로 연동됩니다.
- **핵심 감사 목표**: 단순 정리 식별자 대조에 머물렀던 초동 사전(`195`선)을 넘어, 하위 `.lean` 원문의 실제 `Prop` 정의식을 수식으로 역번역하고 고전 원논문과 1대1 동치인 **유형 I 명제**와 아카이브 전용 데이터 구조체·부분 로커스에 투영된 **유형 II 특화 명제**를 전수 판별합니다.

---

## 제1장. 기출 문헌 소거 아키텍처의 정량 해부 (`EveryCharacterOfLiteratureOfVWin.lean` 및 `PublishedTheorems` `1,073`개)

### 1.1 `EveryCharacterOfLiteratureOfVWin.lean`과 `MainConclusion.lean`의 2단계 가정 소거 구조

알푀게(Levent Alpöge)와 Claude의 리만 가설 형식증명 아카이브(`175,187`개 파일, `17,374,215`줄)는 현대 정수론·대수기하·보형표현론의 기출 대정리들을 외부 공리(`axiom`)로 남겨두지 않고 순수 `Mathlib` 위에서 내부 재증명해 소거하는 설계를 취합니다.
이 거대한 문헌 소거 작업이 신작 영점 소거 엔진(`UpperTheory.Top.VWin`)과 만나는 단일 용접점이 바로 `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/EveryCharacterOfLiteratureOfVWin.lean:1-814`입니다.
해당 파일은 전체 아카이브에서 오직 단 하나의 상위 모듈인 `Development/AutomorphicArithmetic/CharacterBoxes/MainConclusion.lean:1`에서만 임포트(`in_degree = 1`, `out_degree = 201`, `Main` 최단 거리 `5`)되며, 총 `814`줄은 정확히 네 개의 계층으로 구획됩니다.

1. **임포트 헤더 계층 (`L1-208`)**: 총 `208`개의 `import` 문으로 이루어집니다. 이 중 `L62`(`Mathlib`)와 `L138-143`(복소 리우빌 정리 및 거듭제곱·로그·지수 미분 `Mathlib.Analysis.*` `6`개 모듈)의 외부 표준 라이브러리 `7`줄을 제외하면, 정확히 **`201`개의 아카이브 내부 로컬 모듈(`12,171`줄)**이 직접 호출됩니다.
2. **지연 문헌 레코드 정의 (`L215-218`)**: 순환 임포트를 방지하기 위해 세 개의 최상위 표현론·갈루아 명세를 담는 `Prop` 구조체 `UpperTheory.LiteratureTheorems.OpenLiteratureStatements`를 선언합니다.
3. **개별 기출 증인 래퍼 (`L219-588`)**: 번호순으로 총 `185`개의 개별 `theorem` 선언이 배치됩니다. 각 정리는 형식상 `(O : OpenLiteratureStatements)`를 인자로 받지만, 원문 대입 항을 전수 검사하면 **`185`개 중 `177`개(구문상 `O` 미등장 `152`개[`151`개 활성 기출 증인 + `L505-506`의 비활성 슬롯 `siegel_eisenstein_simple_pole : UnusedSlot72 := trivial`] + 하위 래퍼에 형식 인자로만 전달하고 실제 소모하지 않는 `25`개)는 의미론적으로 `O`와 무관하게** `201`개 임포트 모듈이 공급하는 무조건부 정리(`*_holds`, `PositivityTheory.*`, `GlobalTheory.*`,
`CompanionTheory.*`)로 환원됩니다. 오직 국소 랑글란즈 존재성과 편극 갈루아 대응 사슬에 속한 **`8`개 정리**(`L283`, `L285`, `L313`, `L389`, `L421`, `L423`, `L459`, `L461`)만이 직간접적으로 `O`의 필드를 실제 투영합니다.
4. **상위 가설 번들 조립자 `9`종 및 최상위 결합 주정리 (`L589-814`)**: `L589-809`의 `9`개 조립 정리가 개별 기출 래퍼들을 분야별 대형 `Prop` 구조체(`LocalRepresentationTheoryHypothesesAlt` `19`필드, `GlobalAutomorphicGaloisHypotheses'` `16`필드, `LitCoh` `12`필드, `NonEndoscopicHypothesesAlt` `5`필드, `GeometricGaloisRepCompatibility` `12`필드, `NLink.Hypotheses₂` `7`필드,
`UnitaryGroupThirdPlaceHypotheses` `60`필드, `ThetaLocalInputs` `53`필드, `PublishedHodgeBundleTheorems` `28`필드)로 조립합니다.
마지막 `L810-813`의 주정리 `every_character_of_literature_of_vWin`이 이 가설 번들들과 신작 창문 정리 `hV : UpperTheory.Top.VWin`을 `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/SiegelEisensteinSecondTermHypotheses.lean:69-73`의 `every_character_of_theta_integrals_local_matching`에 대입하여 모든 디리클레 $L$-함수의 우반평면 무영점 명제
`UpperTheory.EveryCharacter`를 도출합니다.

```lean
-- Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/EveryCharacterOfLiteratureOfVWin.lean:215-218
structure UpperTheory.LiteratureTheorems.OpenLiteratureStatements : Prop where
  caraianiLocalGlobalDual : _root_.UpperTheory.One.M.Row
  localLanglandsExists : _root_.UpperTheory.Zero.LLC.RecTExists
  galoisRepOfPolarizedPairLit : _root_.UpperTheory.One.M.Row

-- Development/AutomorphicArithmetic/CharacterBoxes/MainConclusion.lean:7-14
theorem UpperTheory.FinalTheorems.everyCharacter_of_row
    (h : UpperTheory.GalStar.Row0b fun h rc => UpperTheory.Zero.LLC.IsRecT h rc) : UpperTheory.EveryCharacter :=
  UpperTheory.LiteratureTheorems.every_character_of_literature_of_vWin
    ⟨h, UpperTheory.Zero.LLC.recTExists, h⟩ (UpperTheory.One.vwin_of_row h)

theorem UpperTheory.FinalTheorems.everyCharacter : UpperTheory.EveryCharacter :=
  UpperTheory.FinalTheorems.everyCharacter_of_row UpperTheory.Gal.Int.galoisLocalGlobalStrong_recParameter

theorem UpperTheory.FinalTheorems.riemannHypothesis : RiemannHypothesis :=
  UpperTheory.riemannHypothesis_of_everyCharacter UpperTheory.FinalTheorems.everyCharacter
```

위 코드에서 드러나듯 외부 가정이 정확히 `0`개로 소멸하는 최종 마감은 `Development/AutomorphicArithmetic/CharacterBoxes/MainConclusion.lean:7-14`에서 완성됩니다.
첫째, `Development/AutomorphicArithmetic/Foundations/UnitarySphericalFixing/SatakeParameters/RecT.lean:4-6`에서 `_root_.UpperTheory.One.M.Row`는 `UpperTheory.GalStar.Row0b recT`의 정의적 별칭(`def`)이므로 `OpenLiteratureStatements`의 제1필드와 제3필드는 동일한 명제 타입을 가집니다.
둘째, 제2필드 `RecTExists`는 `Development/AutomorphicArithmetic/Foundations/LocalLanglands/LocalCentralUnits/RecTExists.lean:20-66`의 무조건부 정리 `UpperTheory.Zero.LLC.recTExists`로 채워집니다.
셋째, 남은 단일 매개변수 `h : Row0b recT`는 세타 파르세발 커널 리프트로부터 증명된 `Development/AutomorphicArithmetic/Foundations/GaloisRepresentations/IntegralStructures/RowSrc.lean:6`의 무조건부 정리 `galoisLocalGlobalStrong_recParameter`로 동시에 소거되면서 `O`와 `hV := UpperTheory.One.vwin_of_row h` 양쪽의 모든 전제를 한 번에 닫습니다.
이어 `Development/AutomorphicArithmetic/CharacterBoxes/EveryCharacter.lean:13-14`의 명제

$$
\mathrm{EveryCharacter} \iff \forall N \ge 1,\; \forall \chi \bmod N,\; \forall s \in \mathbb{C},\quad \mathrm{Re}(s) > \frac{1}{2} \implies (\chi \neq 1 \lor s \neq 1) \implies L(s, \chi) \neq 0
$$

에 법 $N = 1$ 자명 지표를 대입하고 완성 제타 함수의 대칭성 $\Lambda(s) = \Lambda(1 - s)$와 감마 인자 $\Gamma_{\mathbb{R}}(s)$의 극점 판정을 적용하는 `Development/AutomorphicArithmetic/CharacterBoxes/RiemannHypothesisOfEveryCharacter.lean:211-231`을 거쳐 `Supplements/Kernels/MainTheorems.lean:7-16`과 `Main.lean:4-12`의 5대 정리가 무가정 상태로 봉인됩니다.

---

### 1.2 `PublishedTheorems` `1,073`개와 직접 임포트 `201`개의 정량 분포 및 피참조 허브

아카이브 내부에서 기출 정리 명세와 직결된 모듈 모집단은 크게 두 집합으로 나뉩니다. 첫째는 모듈 경로에 `PublishedTheorems` 식별자를 포함하는 **`1,073`개 명세·보조 파일(`107,246`줄)**이고, 둘째는 `EveryCharacterOfLiteratureOfVWin.lean`이 직접 호출하는 **`201`개 로컬 임포트(`12,171`줄)**입니다. 두 집합의 교집합은 정확히 `17`개 모듈이며, 여기에 통합 본체 `EveryCharacterOfLiteratureOfVWin.lean`(`814`줄) `1`개를 합치면 Part B 제9권(`B09`)에 전수 수록된 고유 모듈 수

$$
N_{\mathrm{B09}} = 1{,}073 + 201 - 17 + 1 = 1{,}258\text{개 파일} \quad (119{,}064\text{줄, 정리 } 5{,}799\text{개, 정의·구조체 } 2{,}426\text{개})
$$

와 1줄의 오차도 없이 일치합니다. 먼저 `PublishedTheorems` `1,073`개 파일의 상위 네임스페이스 및 주요 하위 디렉터리 분포는 아래 표와 같습니다.

| `PublishedTheorems` 상위 경로 및 핵심 하위 분과 | 파일 수 | 코드 줄 수 | 정리 수 | 정의·구조체 수 | 대표 명세 영역 |
| :--- | ---: | ---: | ---: | ---: | :--- |
| **`Development.WeilBound.CoreStatements.PublishedTheorems`** | **`540`개** | **`48,718`줄** | **`2,202`개** | **`557`개** | 나델 소멸(`197`개), 자케-샬리카(`73`개), 푸아투-테이트(`64`개), 카셀만-왈라흐(`63`개), 대역 오일러(`42`개), 매끄러운 벡터(`42`개) |
| **`Development.AbelianVarietyTheory.PublishedTheorems`** | **`493`개** | **`56,194`줄** | **`2,744`개** | **`1,632`개** | 인자·변형·호지(`Divisors₂` `152`개), 뒤틀림 대각합·실수군(`97`개), 갈루아 코호몰로지(`80`개), 보형 형식(`52`개), 갈루아 기하(`46`개), 지겔-베유(`18`개) |
| **`Development.AutomorphicSpectrum.PublishedTheorems`** | **`23`개** | **`1,543`줄** | **`43`개** | **`75`개** | 복소 GAGA(`Geometry₂` `5`개), 대역 린니크·스펙트럼(`5`개), 대수·계량·가분성·제트(`13`개) |
| **`Development.AutomorphicArithmetic.AutomorphicVarieties.*`** | **`13`개** | **`685`줄** | **`0`개** | **`73`개** | `PublishedTheorems`(`10`개), `LocalPublishedTheorems`(`1`개), `HeightAndVanishing`(`1`개), `MixedUnitPublishedTheorems`(`1`개) |
| **`PositivityTheory.PublishedTheorems`** | **`3`개** | **`105`줄** | **`4`개** | **`0`개** | 멱등원 단수 소멸(`UnitKilling`), 타워 보조(`TowerLemmas`), 베유 표현 코어(`WeilRepresentations`) |
| **`CompanionTheory.EightfoldTheory.VariationTheory.PublishedTheorems`** | **`1`개** | **`1`줄** | **`0`개** | **`0`개** | 변분 이론 임포트 브리지(`ImportsAlt.lean`) |
| **`PublishedTheorems` 전체 합계** | **`1,073`개** | **`107,246`줄** | **`4,993`개** | **`2,337`개** | **아카이브 전체 기출 명세 및 직결 보조정리 풀** |

한편 `EveryCharacterOfLiteratureOfVWin.lean`이 직접 호출하는 `201`개 로컬 임포트(`12,171`줄)의 아키텍처 계층별 구성은 `Development.AbelianVarietyTheory.Proofs`가 `79`개(`39.30%`, `5,516`줄), `Development.WeilBound`가 `70`개(`34.83%`, `CoreStatements` `57`개 + `RepresentationTheoryGL` `12`개 + `ThetaLifts` `1`개, `3,240`줄), `Development.AutomorphicArithmetic`이 `33`개(`16.42%`,
`ThetaCorrespondence` `27`개 + `Foundations` `4`개 + `AutomorphicVarieties` `1`개 + `CharacterBoxes` `1`개, `1,511`줄), 외부 기초군(`CompanionTheory` `6`개 + `GroundTheory` `1`개 + `DiscreteGroups` `1`개)이 `8`개(`3.98%`, `530`줄), `AbelianVarietyTheory.PublishedTheorems` 직접 호출이 `6`개(`2.99%`, `891`줄), `AutomorphicSpectrum`이 `5`개(`2.49%`, `483`줄)입니다.
이는 `PublishedTheorems` 폴더가 기출 정리의 **목표 명세(`def ... : Prop`)와 즉각적 귀결 보조정리**를 정의하는 반면, `EveryCharacterOfLiteratureOfVWin.lean`은 그 명세를 실제로 증명해 내는 하부 `Proofs`·`CoreStatements`의 **최상단 증인 정리(`*_holds`)**를 끌어와 용접하기 때문입니다.

아래 표는 `1,258`개 기출 경계 모집단 전체에서 아카이브 피참조 횟수(`in_degree`) 최상위 `15`개 핵심 허브 모듈을 추출한 결과입니다.

| 순위 | `src/` 기준 모듈 경로 및 줄 수 | 피참조 (`in_degree`) | `Main` 거리 | 핵심 선언 및 아카이브 내 기능 | 동치성 유형 |
| :---: | :--- | ---: | :---: | :--- | :---: |
| `1` | `Development/AbelianVarietyTheory/PublishedTheorems/AutomorphicForms₂/ExistsNormLeHeightPow.lean:18-33` (`114`줄) | `2,460` | `7` | `quotHeight`, `IsRapidDecay`, `CuspRapidDecay`, 페터슨 내적 가적분성 | 유형 II-A |
| `2` | `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/CohomologicalCsdTempered.lean:1` (`1`줄) | `2,242` | `6` | `import Mathlib` 단일 줄 리팩터링 호환 스텁 (구 가정 허브 화석) | 조립·어댑터 |
| `3` | `Development/AbelianVarietyTheory/PublishedTheorems/TwistedTraceFormula/HarishChandraModulesOn.lean:18-45` (`211`줄) | `1,684` | `7` | `HarishChandraModulesOn`, `KFiniteAnalyticUJ`, $U(p,q)$ 피복군 $(\mathfrak{g},K)$-가군 | 유형 II-A |
| `4` | `Development/AbelianVarietyTheory/PublishedTheorems/TwistedTraceFormula/AdmissibleDiscreteSeriesOfHasParam.lean:16-39` (`267`줄) | `1,354` | `7` | `DiscreteSeriesCover`, 블래트너 원뿔 `InCone`, 보간 부등식 `vogan_add_le` | 유형 II-A |
| `5` | `Development/AbelianVarietyTheory/PublishedTheorems/AutomorphicForms₂/HasDRepIffHasDerivAt.lean:19-112` (`115`줄) | `1,051` | `7` | `IsSmoothModRep`, `sobNorm`, `CasselmanWallach` 매끄러운 완비화 명세 | 유형 II-A |
| `6` | `Development/AbelianVarietyTheory/PublishedTheorems/Divisors₂/GeometricallyConnectedOfIsIsoRestrict.lean:13-126` (`129`줄) | `937` | `6` | 매끄러운 폭발열 `IsSmoothBlowupSeq` 및 히로나카 `Principalisation` | 유형 I |
| `7` | `Development/AbelianVarietyTheory/PublishedTheorems/GaloisGeometry₂/HoweUnram.lean:8-20` (`23`줄) | `885` | `7` | 비분기 유니터리 이중쌍 구형 하우 쌍대성 `HoweUnram` 명세 | 유형 II-A |
| `8` | `Development/AbelianVarietyTheory/PublishedTheorems/Divisors₂/CrysToDRBijective.lean:24-87` (`90`줄) | `859` | `6` | 아벨 스킴 드람 코호몰로지 `AbelianDeRham` 및 결정-드람 전단사 `Rigid` | 유형 I |
| `9` | `Development/AbelianVarietyTheory/PublishedTheorems/AutomorphicForms₂/HarishChandraFinite.lean:39-59` (`145`줄) | `814` | `6` | 고정 레벨·$K$-타입·겔판트 고윳값 보형 형식 유한차원성 `HarishChandraFinite` | 유형 II-A |
| `10` | `Development/AbelianVarietyTheory/PublishedTheorems/Divisors₂/ExistsCrystalPairing.lean:25-129` (`135`줄) | `812` | `5` | `DualAbelianScheme`, `CrystallineDeRham`, 편극 결정 쌍대 형식 유일성 | 유형 I |
| `11` | `Development/AbelianVarietyTheory/PublishedTheorems/AutomorphicForms₂/WeilRepresentationUnitaryPair.lean:12-16` (`19`줄) | `780` | `6` | `D7` 에르미트 쌍 $(S,T)$ 위 유니터리 베유 표현 `WeilRepresentationUnitaryPair` | 유형 II-A |
| `12` | `Development/AutomorphicArithmetic/Foundations/LocalLanglands/IsRecTOfIsRec.lean:20-85` (`116`줄) | `775` | `6` | `GoodCusp` 깊이 `0` 로커스 강화 국소 랑글란즈 `LawsT`, `IsRecT`, `RecTExists` | 유형 II-B |
| `13` | `Development/AbelianVarietyTheory/PublishedTheorems/AutomorphicForms₂/MumfordConstruction.lean:11-22` (`23`줄) | `768` | `14` | CM 호스트 `Host E`·완비 국소환 퇴화 반아벨 `PELUnif` 멈퍼드 구성 `MumfordConstruction` | 유형 II-A |
| `14` | `Development/AbelianVarietyTheory/PublishedTheorems/AutomorphicForms₂/ExistsUniqueHcharOfFiniteOrder.lean:25-492` (`495`줄) | `740` | `6` | `GlobalArtinReciprocity`, `HeckeLAdicCharacter`, 유한 위수 헤케 지표 유일성 | 유형 I |
| `15` | `Development/AbelianVarietyTheory/PublishedTheorems/Divisors₂/AbelianHodgeDeRham.lean:15-30` (`31`줄) | `669` | `6` | 아벨 다양체 호지 여과 퇴화 및 복소 주기 비교 `AbelianHodgeDeRham` | 유형 I |

특히 피참조 2위(`2,242`회)인 `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/CohomologicalCsdTempered.lean:1`이 단 1줄(`import Mathlib`)뿐인 빈 모듈이라는 사실은 원문 열람 없이는 절대 포착할 수 없는 포렌식 단서입니다.
초기 스캐폴딩 단계에서 `2,242`개 파일이 이 모듈을 미증명 가정 허브로 임포트했으나, 이후 실제 정리 명세가 `Development/AbelianVarietyTheory/PublishedTheorems/GaloisGeometry₂/CaraianiTempered.lean:13-18`로 분리되고 그 증명이 `Development/AbelianVarietyTheory/Proofs/SatakeParameters/CohomologicalCsdTemperedOfSegments.lean:16-29`에서 완성되자, 하위 `2,242`개 파일의 임포트 그래프를 깨뜨리지 않기 위해 기존 경로에 `import Mathlib` 스텁만 남겨 둔 것입니다.

---

### 1.3 인식론적 핵심 구분: 유형 I(원논문 동치 명제) 대 유형 II(아카이브 고유 구조체·로커스 특화 명제)

기출 대정리 파일에 붙어 있는 `HarishChandraModules`, `CasselmanWallach`, `HasseNormSt`, `L2ExtensionLogCanonical` 같은 식별자만 보고 해당 `def ... : Prop`이 대학원 교과서의 일반 정리와 1대1 동치라고 단정하면 심각한 해석 오류에 빠집니다. 본 감사에서는 `PublishedTheorems`와 `201`개 직접 임포트의 모든 수학 명제를 원문 타입 시그니처에 따라 다음 세 범주로 엄격히 분류합니다.

- **유형 I (원논문·교과서 동치 일반 명제)**: `Mathlib`의 표준 범주(`NumberField`, `Scheme.{0}`, `Representation`, `IsNonarchimedeanLocalField`, `Valuation`)만을 입력으로 삼아 원논문의 일반 정리를 축소 없이 그대로 정식화한 명제입니다.
예를 들어 번스타인 유니터리 유도곱 기약성(`Development/AbelianVarietyTheory/PublishedTheorems/TwistedTraceFormula/BernsteinUnitaryProductIrreducible.lean:10-16`),
아벨 다양체 $[n]$-비틀림 기수 $n^{2g}$ (`Development/AbelianVarietyTheory/PublishedTheorems/Landherr₂/DimEqZero.lean:10-11`), 숄체-와인스타인 $p$-가분군 분류(`Development/AbelianVarietyTheory/PublishedTheorems/Divisors₂/ScholzeWeinsteinB.lean:13-24`),
히로나카 주이데알화(`Development/AbelianVarietyTheory/PublishedTheorems/Divisors₂/GeometricallyConnectedOfIsIsoRestrict.lean:118-126`)가 여기에 속합니다.
- **유형 II-A (아카이브 고유 데이터 구조체 투영 특화 명제)**: 일반 가약군 $G$나 임의의 시무라 다양체 대신, 본 아카이브가 $\sqrt{X}$-세타 리프트와 아라켈로프 부피 계산을 수행하기 위해 직접 설계한 전용 레코드 위에서만 명제를 진술한 경우입니다. 모든 유형 II-A 명제를 지배하는 5대 고유 데이터 구조체의 원문 정의 위치와 수리적 실체는 다음과 같습니다.
    1. `D : D7` (`Formalism/LocalRingCardinality/RhoDetPrimeEqMuTildeMulChiPow.lean:76-114`): 차수 매개변수 `R : Ranks`, 완전 실수체 `D.host.F`와 CM 이차 확장 `D.host.E`를 담는 `host : Host R`, 에르미트 공간 족 `sp`, 부피 정규화 함수 `vol`, 아르키메데스 자리 동형 `eTau : what₂.Tau ≃ R.Psi`, 하리시-찬드라 매개변수 족 `hcW`, 갈루아 수체 `what₂.LL` 및 인자 데이터 `div`를 하나로 묶은 대역 유니터리-세타 마스터 데이텀입니다.
    2. `V : HSp D` 및 `GA D V`, `GQ V` (`Formalism/LocalRingCardinality/DataTheta.lean:489-495`): `D.host.E` 위 비퇴화 에르미트 공간 `HSpace D.host.E`와 그 아델 유니터리 군 $U(V)(\mathbb{A}_F)$ (`GA D V`), 유리 이산 부분군 $U(V)(F)$ (`GQ V`)입니다.
`CuspRapidDecay`, `HarishChandraFinite`, `WeilRepresentationUnitaryPair`, `SiegelWeilUnitaryConvergent`는 모두 임의의 대수군이 아닌 `(D : D7)`와 `(V : HSp D)`에 한정되어 진술됩니다.
    3. `T : GrpData p q` (`Formalism/LocalRingCardinality/DataTheta.lean:93-120`): 부정부호 유니터리 군 $U(p,q)$ (`Formalism.UG.Upq p q`)의 **행렬식 제곱근 2중 피복군** $G$를 추상화한 위상·측도군 레코드입니다.
피복 준동형 `cov : G →* GL (Ix p q) ℂ`와 행렬식 제곱근 지표 `sq : G →* ℂˣ`가 $(\mathrm{sq}(x))^2 = \det(\mathrm{cov}(x))$를 만족하며 각 $(g, w) \in U(p,q) \times \mathbb{C}^\times$ ($w^2 = \det g$)마다 유일한 원소 $x \in G$가 대응하고(`bij`), 매장 $x \mapsto (\mathrm{cov}(x), \mathrm{sq}(x))$가 위상 매장(`emb`)이며 리 대수 지수사상 승강 `expt : Mat p q → G`를 갖추도록 규정합니다.
쿠들라 메타플렉틱 분해 이전 단계의 반정수 가중치 포크 모형을 다루기 위해 실수 표현론 명세(`HarishChandraModulesOn`, `DiscreteSeriesCover`)가 선형군 $U(p,q)$ 대신 이 2중 피복 `GrpData p q` 위에 구축되었습니다.
    4. `UJset ε` (`Development/AbelianVarietyTheory/PublishedTheorems/TwistedTraceFormula/HarishChandraModulesOn.lean:16-22`): 부호 벡터 $\varepsilon : \mathrm{Fin}\,n \to \mathrm{Bool}$이 정하는 대각 에르미트 행렬 $J_\varepsilon = \mathrm{diag}(\pm 1)$의 등거리 행렬 집합 $\{g \in M_n(\mathbb{C}) \mid g^* J_\varepsilon g = J_\varepsilon\} \cong U(p,q)$입니다.
`KFiniteAnalyticUJ`와 `CasselmanWallach`는 일반 실수 가약군 대신 `UJset ε` 위에서만 정식화됩니다.
    5. `X : ProvA` (`Formalism/LocalRingCardinality/DataTheta.lean:471-478`): 모든 부호수 $(p,q)$에 걸친 피복군 공급자 `grp : ∀ p q, GrpData p q`, 이중쌍 텐서 포크 모형 공급자 `fock : ∀ p q r s, FockData ...`, 유리 하리시-찬드라 매개변수별 이산계열 대표원 공급자 `ds : ∀ p q, (Ix p q → ℚ) → DSRep (grp p q)`를 묶은 아르키메데스 표현 공급 패키지입니다.
- **유형 II-B (부분 로커스·약화 조건 특화 명제)**: 아카이브 전용 구조체를 쓰지 않더라도, 고전 대정리의 전체 명제 대신 본 증명 경로에서 실제로 호출되는 진부분집합(부분 로커스)만을 정의한 경우입니다.
대표 사례로 일반 수체 대신 완전 복소 수체(`[IsTotallyComplex E]`)나 CM 수체(`[IsCMField E]`) 로커스에서만 정식화된 자케-샬리카 등압 강성(`Development/AbelianVarietyTheory/PublishedTheorems/GaloisCohomology₂/StrongMultiplicityOne.lean:189-203`), 일반 순환 확장 대신 **이차 확장 $F(\sqrt{\delta})/F$**만 다루는 `HasseNormSt`(`Development/AbelianVarietyTheory/PublishedTheorems/Landherr₂/ExistsNormTensor.lean:12`), 임의 분기 초첨점 표현 대신 **1차원 지표와 $\mathbb{Q}_g$ 위 깊이 `0` 표현의 비틀림(`GoodCusp`)**에서만 정밀 공리를 부과하는 `IsRecT`(`Development/AutomorphicArithmetic/Foundations/LocalLanglands/IsRecTOfIsRec.lean:20-76`),
양의 차원 로그 정준 중심 대신 **유한 개 고립 점(`(A.zeroSet s).Finite`)**에서의 보간만 요구하는 드마이 $L^2$-확장(`Development/AbelianVarietyTheory/PublishedTheorems/Divisors₂/L2ExtensionLogCanonical.lean:32-55`), 연접층 전체 코호몰로지 대신 **선다발의 `0`차 단면(`LB.Sec`) 전단사**만 요구하는 `GagaSections`(`Development/AutomorphicSpectrum/PublishedTheorems/Geometry₂/GagaSections.lean:10-18`),
일반 $p$-가분군 사상 대신 **상수군 $\underline{\mathbb{Q}_p/\mathbb{Z}_p}$에서 $\mu_{p^\infty}$로 가는 사상의 완전충실성**만 요구하는 `PrismaticDieudonneHodgeAt`(`Development/AbelianVarietyTheory/PublishedTheorems/Divisors₂/InjectiveOfSmulMemRange.lean:56-58`)이 있습니다.

---

### 1.4 커널 진리값 불변성과 인간 압축 논문용 번역 어댑터 보조정리의 비대칭성

유형 II-A 및 유형 II-B 특화가 발견되었을 때 가장 먼저 구별해야 할 수리논리적 원칙은 **기계적 형식증명의 건전성(soundness)**과 **인간 수학자의 문헌 블랙박스 인용 가능성** 사이의 비대칭성입니다.

첫째, **`Main.lean`의 Lean 4 커널 진리값에는 유형 II 특화가 추호의 결함도 유발하지 않습니다.** 형식 체계 안에서 중간 기출 명제 $P_{\mathrm{arch}}$는 외부에서 주입된 공리(`axiom`)가 아니라, 하부 모듈이 증명한 정리 $T_{\mathrm{low}} : \vdash P_{\mathrm{arch}}$와 상부 모듈이 증명한 함의 $T_{\mathrm{high}} : P_{\mathrm{arch}} \vdash \mathrm{RiemannHypothesis}$를 잇는 **내부 절단 공식(cut formula)**일 뿐입니다. 연역 규칙(Modus Ponens)

$$
\frac{\vdash P_{\mathrm{arch}} \qquad P_{\mathrm{arch}} \vdash \mathrm{RiemannHypothesis}}{\vdash \mathrm{RiemannHypothesis}}
$$

에 의해 최종 결론 `Main.riemannHypothesis`의 타입에는 `D7`, `GrpData`, `GoodCusp`, `UnusedSlot72` 등 아카이브 내부 정의가 단 하나도 남지 않으며 오직 `Mathlib`의 표준 `_root_.RiemannHypothesis`만 남습니다.
극단적인 예로 `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/EveryCharacterOfLiteratureOfVWin.lean:505-506`에서 `siegel_eisenstein_simple_pole`의 반환 타입 `UnusedSlot72`가 `True`로 정의되어 `trivial`로 증명되었더라도,
상위 소비자인 `every_character_of_theta_integrals_local_matching`이 해당 슬롯의 정보를 쓰지 않고도 `EveryCharacter`를 연역해 냈음을 커널이 검증했으므로 최종 정리의 수학적 진리값은 100% 보존됩니다.

둘째, **반대로 인간 수학자가 `1,315만 줄`에 달하는 하부 기출 재증명 코드를 읽는 대신 기존 출판 논문을 블랙박스로 인용하여 약 150쪽 분량의 인간 가독성 단축 논문을 집필할 때는 유형 II 명제마다 반드시 '번역 어댑터 보조정리(Translation Adapter Lemma)'를 입증해야 합니다.** 인간 단축 논문은 내부 증명 $\vdash P_{\mathrm{arch}}$를 버리고 문헌의 고전 정리 $T_{\mathrm{lit}}$로 대체하려는 시도이므로, 논리적 완결성을 얻으려면 브리지 함의

$$
T_{\mathrm{lit}} \implies P_{\mathrm{arch}}
$$

가 참이어야 합니다. 유형 II-B(부분 로커스 약화)는 대개 일반 정리가 특수 경우를 즉시 함의하므로($\forall L/F\text{ 순환} \implies \forall F(\sqrt{\delta})/F\text{ 이차}$) 어댑터가 자명합니다. 그러나 유형 II-A(고유 구조체 투영)에서는 다음 세 가지 어댑터 검증이 필수입니다.

1. **비선형/피복군 범주 적합성**: 고전 문헌의 하리시-찬드라 가군·카셀만-왈라흐·이산계열 정리는 보통 연결 반단순 행렬 리 군 또는 하리시-찬드라 부류(class $\mathcal{H}$) 가약군에 관해 서술됩니다.
이를 `GrpData p q`에 대입하려면 $U(p,q)$의 $\det^{1/2}$ 2중 피복군 $G = \{(g, w) \in U(p,q) \times \mathbb{C}^\times \mid w^2 = \det g\}$가 유한 중심을 갖는 닫힌 행렬 리 부분군($\mathrm{GL}_{p+q}(\mathbb{C}) \times \mathrm{GL}_1(\mathbb{C})$ 안의 대수적 실수 부분군)으로서 하리시-찬드라 부류 공리를 만족함을 보이는 어댑터 보조정리가 필요합니다.
2. **측도·높이·부호 정규화 일치성**: `SiegelWeilUnitaryConvergent`와 `RallisInnerProductConvergent`는 아카이브 고유의 다마가와·격자 공집합 부피 조건 `IsCovolOne (ratL B A) μ 𝓨` 및 반선형 켤레 규약 위에서 등식을 서술합니다. 쿠들라-랄리스(`1994`)나 간-추-다케다(`2014`)의 정리를 인용할 때 하르 측도 상수 배수나 중심 지표 부호(`χB` 대 `χB⁻¹`)가 어긋나지 않음을 확인해야 합니다.
3. **사상 정의역 및 스킴 가설 정합성**: 아라켈로프·토로이달 명세(`ToroidalForFanKS`, `ArDegree`)에서 아카이브의 `Scheme.{0}` 우주 제약, `LB` 체흐 코사이클 선다발 표현, `IsArithVar` 조건이 팔팅스-차이(`1990`) 및 보스트-질레-술레(`1994`)의 정칙 사영 산술 다양체 가설 안에 정확히 들어맞는지 대조해야 합니다.

끝으로 제1장의 정량 해부를 완결하기 위해 `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/EveryCharacterOfLiteratureOfVWin.lean:589-809`가 개별 기출 증인 `185`개를 어떤 `9`개의 중간 가설 번들로 조립하여 신작 영점 소거 엔진에 주입하는지, 그리고 `PublishedTheorems` 양대 산맥(`WeilBound` `540`개 대 `AbelianVarietyTheory` `493`개)의 내부 세부 분과가 어떻게 배치되어 있는지 전수 정량표로 정리합니다.

---

### 1.5 `9`대 상위 가설 번들 조립 구조 및 `PublishedTheorems` 세부 분과 전수 해부

`Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/EveryCharacterOfLiteratureOfVWin.lean:589-809`에 배치된 `9`개의 조립 정리(`186`번~`194`번)는 평면적으로 나열된 `185`개 기출 증인을 계층적 의존 트리로 압축합니다.
특히 `189`번 `literature_nonexistence`는 하위 `3`개 번들(`186`·`187`·`188`)을 품고, 다시 `192`번 `published_results_eigen`(`60`필드)이 `189`·`190`·`191`번 번들 세 개를 자신의 부분 필드(`litN`, `toHypothesesX`, `nLink`)로 중첩 수납합니다. 그 결과 최상위 주정리 `every_character_of_literature_of_vWin`(`L810-813`)은 단 몇 개의 상위 번들 인자만으로 `194`개 전 기출 정리를 한꺼번에 전달받습니다.

| 조립 순번 (`행 범위`) | 조립 정리 식별자 | 반환 구조체 타입 (`정의 모듈`) | 필드 수 | 핵심 수납 기출 정리 및 연결 소비처 |
| :---: | :--- | :--- | ---: | :--- |
| `186` (`L589-608`) | `literature_local` | `LocalRepresentationTheoryHypothesesAlt` (`Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/LocalRepresentationTheoryHypotheses.lean:13-32`) | `19`개 | 번스타인-젤레빈스키, 모이-프라사드, `RecTExists`, 국소 역정리, 브라우어, 그린 정칙 지표 $\to$ `litN.loc` |
| `187` (`L609-625`) | `literature_automorphy` | `GlobalAutomorphicGaloisHypotheses'` (`Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/LocalRepresentationTheoryHypotheses.lean:33-49`) | `16`개 | 첨점 급감소, 하리시-찬드라 유한성, 자케-샬리카, 기저변환, `O.caraianiLocalGlobalDual`, 베르제 $\to$ `litN.aut` |
| `188` (`L626-638`) | `literature_cohomology` | `LitCoh` (`LocalTypeDictionary` 계층 정의) | `12`개 | 푸아투-테이트 9항 완전열, 국소·대역 테이트 쌍대성·오일러 지표·유한성, 그린버그-와일즈, 블록-가토 $\to$ `litN.coh` |
| `189` (`L639-644`) | `literature_nonexistence` | `NonEndoscopicHypothesesAlt` (`Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/BernsteinUnitaryProductIrreducible.lean:12-17`) | `5`개 | `loc`(`186`), `aut`(`187`), `coh`(`188`), `JoinOut`(`5`종 CM·제타 결합), 테이트 함수방정식 $\to$ `eigen.litN` |
| `190` (`L645-657`) | `published_results_analytic` | `GeometricGaloisRepCompatibility` (`GlobalTheory.NRows`) | `12`개 | 유니터리 베유 쌍, 이산계열 분류, 첨점 대각합 부류, 플라스 인수분해, 배가법, 노스코트 높이 유한성 $\to$ `eigen.toHypothesesX` |
| `191` (`L658-665`) | `published_results_local` | `NLink.Hypotheses₂` (`GlobalTheory.NLink`) | `7`개 | 폰텐 `Bcris`, 대역 아르틴, 블록-가토, 기저체 $K$ 국소 코호몰로지 `3`종, 바트-숄체 정수 격자 $\to$ `eigen.nLink` |
| `192` (`L666-726`) | `published_results_eigen` | `UnitaryGroupThirdPlaceHypotheses` (`Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/BernsteinUnitaryProductIrreducible.lean:22-82`) | `60`개 | 클로젤, 카라이아니, 라베스-신 기저변환, 타디치 유니터리 쌍대, 카셀만-왈라흐, 비활성 `UnusedSlot72` 외 $\to$ 주정리 제1인자 |
| `193` (`L727-780`) | `published_results_first` | `ThetaLocalInputs` (`GlobalTheory.FunPr`) | `53`개 | 린니크, CM $j$-불변량, 미라볼릭, 바일 분기, 랄리스 내적, 스톤-폰 노이만, 하우 쌍대성 외 $\to$ 주정리 제2인자 |
| `194` (`L781-809`) | `published_results_arithmetic` | `PublishedHodgeBundleTheorems` (`GlobalTheory.CovTop`) | `28`개 | 토로이달 콤팩트화, 모리와키 부피, 아벨 드람, 준안정 환원, 란트헤어, 하세 노름, 프리즘, GFGA 외 $\to$ `topCovolSlim2` |

아울러 `PublishedTheorems` `1,073`개 파일 중 `96.27%`(`1,033`개)가 집중된 양대 디렉터리 `Development.WeilBound.CoreStatements.PublishedTheorems`(`540`개, `19`개 하위 분과)와 `Development.AbelianVarietyTheory.PublishedTheorems`(`493`개, `21`개 하위 분과)의 세부 분과 구성을 전수 집계하면 다음과 같습니다.

- **`WeilBound.CoreStatements.PublishedTheorems` (`540`개 파일, `48,718`줄)**: `NadelVanishingPairs`가 `197`개(`9,901`줄)로 단일 최다 파일 수를 기록하며, 이어 `JacquetShalikaRigidity`(`67`개, `12,503`줄 - 줄 수 기준 최대), `PoitouTateDuality`(`64`개, `4,738`줄), `CasselmanWallach`(`63`개, `6,874`줄), `SmoothVectorEstimates`(`42`개, `5,734`줄), `GlobalEulerCharacteristic`(`42`개, `3,855`줄),
`NefNumerics`(`27`개, `1,332`줄), `PoincareDeRhamDuality`(`14`개, `2,443`줄), `JacquetShalikaBound`(`6`개, `645`줄), `GlobalFiniteness`(`4`개, `316`줄), 그리고 각 `1`~`2`개 파일로 구성된 `9`개 소분과(`FiniteGLInvariants`, `LanglandsClassification`, `SiegelWeilSchrodinger`, `SegmentRepresentations`, `CuspidalMultiplicityOne`, `HeckeLAdicCharacters`, `ClozelPurity`,
`PolarizedGaloisRepresentations`, `PotentialSemistability`, 합계 `14`개 파일 · `377`줄)가 뒤를 잇습니다.
- **`AbelianVarietyTheory.PublishedTheorems` (`493`개 파일, `56,194`줄)**: 산술·대수기하 분과 `Divisors₂`(`152`개, `18,694`줄)와 실수·보형 대각합 분과 `TwistedTraceFormula`(`97`개, `13,635`줄)가 절반 이상을 차지하며, `GaloisCohomology₂`(`80`개, `8,023`줄), `AutomorphicForms₂`(`52`개, `4,660`줄), `GaloisGeometry₂`(`46`개, `3,391`줄), `SiegelWeil₂`(`18`개, `1,488`줄), `GlobalTheta`(`8`개, `1,691`줄),
`PublishedFoundations`(`8`개, `1,254`줄), `AdelicLattices₂`(`7`개, `1,416`줄), `DiscreteSeriesUnitary₂`(`7`개, `447`줄), 그리고 나머지 `11`개 특수 분과(`SemiabelianTori`, `Landherr₂`, `RelativeAmpleness`, `DefiniteCompactness`, `RosatiTraces`, `AbelianLaws`, `DiscreteSeries₂`, `SemistableReduction₂`, `ThetaCharacteristics`, `BesselIntegrals`, `WeberRayClassFields`,
합계 `18`개 파일 · `1,495`줄)로 완비되어 있습니다.

이 정량 분포는 아카이브가 기출 명세를 단일 폴더에 무작위로 쌓아둔 것이 아니라, `AbelianVarietyTheory.PublishedTheorems`에 **기출 명세 원형(`Prop`)과 기초 귀결**을 배치하고 `WeilBound.CoreStatements.PublishedTheorems`에 **나델 소멸·자케-샬리카·카셀만-왈라흐·푸아투-테이트의 실질적 증명 엔진**을 분산 배치한 이원 설계로 구축되었음을 입증합니다.

---

## 제2장. 보형 형식 급감소·유한 부피 및 하리시-찬드라 $(\mathfrak{g},K)$-가군 명세 원문 감사

### 2.1 아델 유니터리 몫높이, 첨점 급감소 및 보렐-하리시-찬드라 유한 부피 감사

기출 명세 전체 피참조 1위(`in_degree = 2,460`)인 `Development/AbelianVarietyTheory/PublishedTheorems/AutomorphicForms₂/ExistsNormLeHeightPow.lean:18-111`은 마스터 데이텀 `D : D7`와 에르미트 공간 `V : HSp D` 위에서 아델 유니터리 보형 형식의 완만 증가 및 첨점 급감소를 정식화합니다. 원문 `L18-33`의 핵심 정의 세 개는 다음과 같습니다.

```lean
-- Development/AbelianVarietyTheory/PublishedTheorems/AutomorphicForms₂/ExistsNormLeHeightPow.lean:18-33
def quotHeight (θ : D.what₂.Tau → (Ainf D.host.F ⊗[D.host.F] D.host.E →+* ℂ)) (V : HSp D) (g : GA D V) : NNReal :=
  ⨅ γ : GQ V, height θ V ((γ : GA D V) * g)

def IsRapidDecay (θ : D.what₂.Tau → (Ainf D.host.F ⊗[D.host.F] D.host.E →+* ℂ)) (V : HSp D) (φ : GA D V → ℂ) : Prop :=
  ∀ N : ℕ, ∃ C : ℝ, ∀ g : GA D V, ‖φ g‖ * (quotHeight θ V g : ℝ) ^ N ≤ C

def CuspRapidDecay : Prop :=
  ∀ (D : D7) (θ : D.what₂.Tau → (Ainf D.host.F ⊗[D.host.F] D.host.E →+* ℂ)), IsInfFam θ →
    ∀ (V : HSp D) (e : LieInf V → GA D V), IsExpFam θ V e →
      ∀ φ : GA D V → ℂ, IsAutFun V φ → IsSmoothInf V e φ → IsUnifModerate θ V e φ → IsCuspFun V φ →
        GlobalTheory.CuspDecay.IsRapidDecay θ V φ
```

이를 표준 해석적 수론 표기로 역번역하면 다음과 같습니다. 완전 실수체 $F = \mathrm{D.host.F}$의 무한 아델 텐서 대수 $F_\infty \otimes_F E$에서 복소수체로 가는 무한 자리 매장 족 $\theta$ (`IsInfFam θ`)가 고정될 때, 아델 군 $G(\mathbb{A}_F) = U(V)(\mathbb{A}_F)$ (`GA D V`) 위의 아델 높이 $\mathrm{ht}_\theta(g) \ge 1$을 유리 이산 부분군 $\Gamma = U(V)(F)$ (`GQ V`)의 왼쪽 궤도에 걸쳐 하한 취한 몫높이(quotient height)는

$$
\mathrm{ht}_{\mathrm{quot}}(\theta, V, g) := \inf_{\gamma \in U(V)(F)} \mathrm{ht}_\theta(\gamma g) \in [1, \infty)
$$

로 정의됩니다(`one_le_quotHeight`, `L43-44`). 하한 성질에 의해 임의의 $g \in U(V)(\mathbb{A}_F)$마다 $\mathrm{ht}_\theta(\gamma g) \le 2\,\mathrm{ht}_{\mathrm{quot}}(\theta, V, g)$를 만족하는 유리 원소 $\gamma \in U(V)(F)$가 존재합니다(`exists_height_le`, `L46-50`).
따라서 완만 증가 좌불변 함수 $\psi(\gamma g) = \psi(g)$ ($\lvert\psi(g)\rvert \le C\,\mathrm{ht}_\theta(g)^N$)와 급감소 함수 $\varphi$ ($\sup_g \lvert\varphi(g)\rvert\,\mathrm{ht}_{\mathrm{quot}}(\theta, V, g)^N \le C'_N$)의 곱은

$$
\lvert \psi(g) \rvert \cdot \lvert \varphi(g) \rvert = \lvert \psi(\gamma g) \rvert \cdot \lvert \varphi(g) \rvert \le \lvert C \rvert \, 2^N \left( \lvert \varphi(g) \rvert \, \mathrm{ht}_{\mathrm{quot}}(\theta, V, g)^N \right) \le \lvert C \rvert \, 2^N C'_N
$$

으로 전역 유계가 됩니다(`IsRapidDecay.mul_bounded`, `L56-71`). 나아가 `Development/AbelianVarietyTheory/PublishedTheorems/TwistedTraceFormula/UnifModGrowthOfIsUnifModerate.lean:17-32`(`in_degree = 522`)의 강화 명세 `CuspDecayBound`는 열린 레벨 부분군 $U \subset U(V)(\mathbb{A}_F)$과 지수 $A, N \in \mathbb{N}$마다 유한 개의 리 대수 미분 단어 집합 $\mathcal{L}$과 상수 $C > 0$가 존재하여,
균등 완만 증가 상수 $c(l) = \sup_g \lvert (R(l)\varphi)(g)\rvert\,\mathrm{ht}(g)^{-A}$들의 선형 합만으로 첨점 형식의 가중 노름을 지배함을 진술합니다.

$$
\sup_{g \in U(V)(\mathbb{A}_F)} \lvert \varphi(g) \rvert \cdot \mathrm{ht}_{\mathrm{quot}}(V, g)^N \le C \sum_{l \in \mathcal{L}} \sup_{h \in U(V)(\mathbb{A}_F)} \frac{\lvert (R(l)\varphi)(h) \rvert}{\mathrm{ht}(V, h)^A}
$$

여기에 페터슨 내적의 절대적분 가능성(`integrableOn_star_mul`, `Development/AbelianVarietyTheory/PublishedTheorems/AutomorphicForms₂/ExistsNormLeHeightPow.lean:101-111`)을 결합하기 위해 도입된 명제가 보렐-하리시-찬드라 유한 부피 정리 `FiniteVolume₂`입니다. 원문 `Development/AbelianVarietyTheory/Definitions/Foundations/CdScaleTieIff.lean:81-85`에 기록된 정의는 다음과 같습니다.

$$
\mathrm{FiniteVolume}_2 \iff \forall (E/F\text{ CM 확장}),\; \forall M \in \mathbb{N},\; \forall J \in \mathrm{Herm}_{\mathrm{nd}}(M, E),\; \forall \mu\text{ Haar},\; \forall \mathcal{F}\text{ 기본영역},\quad \mu(\mathcal{F}) < \infty
$$

`FiniteVolume₂`는 `D7`에 종속되지 않고 임의의 CM 확장 $(E/F, \sigma)$와 비퇴화 에르미트 행렬 $J$에 관해 진술되므로 **유형 I에 가까운 유니터리 일반 명제**(Borel-Harish-Chandra `1962`의 유니터리 특수 경우)이며,
`Development/AbelianVarietyTheory/Proofs/IwasawaDecomposition/FiniteVolumeAdelicUnitaryQuotient.lean:124-186`에서 유한 아델 유수 유한성(`finite_classSet_hermitianUnitary_openLevel`)과 실수 격자 안정화군 유한 공집합 부피(`finite_covolume_latticeStabiliser_unitaryRealPoints`)를 결합해 무조건부로 증명됩니다.
반면 `CuspRapidDecay`와 `CuspDecayBound`는 `D : D7` 및 무한 지수 사상 족 `IsExpFam θ V e` 위에 투영된 **유형 II-A 명제**이며,
그 증인은 `Development/AbelianVarietyTheory/Proofs/DecoratedLatticeProofs/CuspidalModerateGrowthRapidDecay.lean:20-106`과 `Development/AbelianVarietyTheory/Proofs/DecoratedLatticeProofs/CuspFormsRapidDecay.lean:10-11`에서 공급됩니다($\mathrm{GL}_n$ 측 대응물은 `Development/AutomorphicSpectrum/Proofs/BlockDecomposition/CuspRapidDecaySiegelGL.lean:21-32`에서 별도 증명됨).

---

### 2.2 실수 피복군 하리시-찬드라 $(\mathfrak{g},K)$-가군 및 $K$-유한 실해석성 감사

피참조 3위(`in_degree = 1,684`) 허브인 `Development/AbelianVarietyTheory/PublishedTheorems/TwistedTraceFormula/HarishChandraModulesOn.lean:18-45`는 아르키메데스 자리에서의 유니터리 표현론과 대수적 $(\mathfrak{g}, K)$-가군 사이의 하리시-찬드라 사전을 정의합니다. 원문 `L24-45`는 두 개의 핵심 명제 `HarishChandraModulesOn`과 `KFiniteAnalyticUJ`의 논리곱으로 `HarishChandraModules`를 구성합니다.

```lean
-- Development/AbelianVarietyTheory/PublishedTheorems/TwistedTraceFormula/HarishChandraModulesOn.lean:24-45
def HarishChandraModulesOn {p q : ℕ} (T : GrpData p q) : Prop :=
  (∀ πU : URep T, IrrU πU →
    (∀ x, KFin T πU.π x → Smooth T πU.π x) ∧
    (∃ (M : GKMod p q) (io : M.V →ₗ[ℂ] πU.H), IsHCMod πU M io) ∧
    ∀ (M : GKMod p q) (io : M.V →ₗ[ℂ] πU.H), IsHCMod πU M io → AdmGK M ∧ IrrGK M) ∧
  (∀ π₁ π₂ : URep T, IrrU π₁ → IrrU π₂ →
    ∀ (M₁ M₂ : GKMod p q) (io₁ : M₁.V →ₗ[ℂ] π₁.H) (io₂ : M₂.V →ₗ[ℂ] π₂.H),
      IsHCMod π₁ M₁ io₁ → IsHCMod π₂ M₂ io₂ →
      ∀ e : M₁.V ≃ₗ[ℂ] M₂.V, (∀ Z v, e (M₁.act Z v) = M₂.act Z (e v)) →
      ∃ U : π₁.H ≃ₗᵢ[ℂ] π₂.H, ∀ g x, U (π₁.π g x) = π₂.π g (U x)) ∧
  (∀ (πU : URep T) (M : GKMod p q) (io : M.V →ₗ[ℂ] πU.H), IsHCMod πU M io →
    AdmGK M → IrrGK M → IrrU πU)

def KFiniteAnalyticUJ : Prop :=
  ∀ (n : ℕ) (ε : Fin n → Bool) (H : Type) [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
    [Nontrivial H] (σ : Matrix (Fin n) (Fin n) ℂ → (H →L[ℂ] H)),
    IsURepOn (UJset ε) σ → IsIrredOn (UJset ε) σ →
    ∀ v : H, IsKFin ε σ v → AnalyticOnUJ ε fun g => σ g v
```

원문 시그니처의 세 절과 해석성 명세를 수식으로 풀면 하리시-찬드라(`1953`, `1954`)의 고전 정리 네 축이 정확히 복원됩니다.

1. **매끄러움·허용성·대수적 기약성 (`L25-28`)**: $p + q \ge 1$인 2중 피복군 `T : GrpData p q`의 임의의 위상 기약 유니터리 힐베르트 표현 $(\pi_U, \mathcal{H})$에 관하여, 극대 콤팩트 부분군 $K_T = \mathrm{cov}^{-1}(U(p) \times U(q))$의 모든 $K_T$-유한 벡터는 $C^\infty$ 매끄러운 벡터이며,
$K_T$-유한 부분공간 위에 유도된 복소화 리 대수 $\mathfrak{g}_{\mathbb{C}} = \mathfrak{gl}_{p+q}(\mathbb{C})$ (`Mat p q`) 가군 $M$은 각 $K_T$-타입 중복도가 유한한 허용(`AdmGK`) 대수적 기약(`IrrGK`) 가군입니다.
2. **무한소 동치에서 유니터리 동치로의 승강 (`L29-33`)**: 두 기약 유니터리 표현 $\pi_1, \pi_2$에 대응하는 하리시-찬드라 가군 $M_1, M_2$ 사이에 $\mathfrak{g}_{\mathbb{C}}$-선형 동형 $e : M_1 \xrightarrow{\sim} M_2$가 존재하면, 힐베르트 공간 사이의 전역 등거리 유니터리 동형 $U : \mathcal{H}_1 \xrightarrow{\sim} \mathcal{H}_2$ ($U \circ \pi_1(g) = \pi_2(g) \circ U$)가 존재합니다.
유니터리 표현에 한정되어 있으므로 일반 반단순 군에서 비유니터리 바하(Banach) 표현끼리 무한소 동치만으로는 전역 동형이 되지 않는 병리 현상이 배제되고, 넬슨(Nelson) 해석 벡터 유일성에 의해 전역 등거리사상으로 승강됩니다.
3. **역방향 위상 기약성 (`L34-35`)**: 유니터리 표현 $\pi_U$의 기저 하리시-찬드라 가군 $M$이 허용적이고 대수적으로 기약이면 $\pi_U$는 위상적으로도 기약입니다.
4. **$K$-유한 궤도의 실해석성 (`L37-42`, `L18-23`)**: 부정부호 유니터리 행렬군 $U(J_\varepsilon) \subset M_n(\mathbb{C})$의 기약 유니터리 표현 $\sigma$에서 임의의 $K$-유한 벡터 $v \in \mathcal{H}_{K\text{-fin}}$에 관해, 궤도 사상 $g \mapsto \sigma(g)v$는 주변 유클리드 공간 $\mathbb{C}^{n \times n} \cong \mathbb{R}^{2n^2}$의 열린 근방 위 실해석 함수 $F$의 제한(`AnalyticOnUJ`)으로 표현됩니다.
파일 하단 `L166-206`에서는 명세의 비자명 거주성(non-vacuity)을 보증하기 위해 2중 피복군 고유 지표 `sqrtDetRep`($g \mapsto \mathrm{sq}(g)\cdot \mathrm{id}_{\mathbb{C}}$)와 행렬식 표현 `det_isURepOn`을 직접 구성하여 검증합니다.

또한 고정 레벨 보형 형식의 유한차원성을 담당하는 `Development/AbelianVarietyTheory/PublishedTheorems/AutomorphicForms₂/HarishChandraFinite.lean:39-59`(`in_degree = 814`)는 열린 부분군 $U \subset U(V)(\mathbb{A}_F)$, 각 무한 자리 $\tau$에서의 유한차원 연속 $K_\tau$-타입 $(\rho_\tau, W_\tau)$,
그리고 보편포락대수 중심의 **겔판트-카시미르 불변 미분연산자 고윳값 수열** `gelf θ V τ k φ = c τ k • φ` (`k : ℕ`)가 고정된 매끄러운 보형 형식들의 생성 부분공간이 복소 유한차원임을 진술합니다.
이는 하리시-찬드라(`1968`, *Automorphic Forms on Semisimple Lie Groups*) 정리 1의 `D7` 유니터리 특화(유형 II-A)이며, `Development/WeilBound/RepresentationTheoryGL/ConstantTermFiniteness/CuspidalConstantTerms/FiniteOfCuspOfConstTerm.lean:129-133`에서 상수항 귀납법으로 증명됩니다.

---

### 2.3 카셀만-왈라흐 매끄러운 프레셰 완비화 및 플라스 인수분해 감사

피참조 4위권(`in_degree = 1,051`)인 `Development/AbelianVarietyTheory/PublishedTheorems/AutomorphicForms₂/HasDRepIffHasDerivAt.lean:19-112`는 실수 세타 대응에서 로컬 시험함수 공간과 힐베르트 표현 사이의 연속 얽힘 사상을 제어하는 카셀만-왈라흐 정리 `CasselmanWallach`를 정의합니다. 원문 `L22-47`과 `L98-112`의 정의를 수식으로 복원하면 다음과 같습니다.

먼저 완비 하우스도르프 국소볼록 공간 $E$ 위의 가산 반노름 족 $\{p_i\}_{i \in \mathbb{N}}$ (`WithSeminorms p`)에 관하여, `IsSmoothModRep ε p π dπ` (`L22-31`)는 $U(J_\varepsilon)$의 연속 표현 $\pi$가 모든 $X \in \mathfrak{u}(J_\varepsilon)$ 방향으로 미분 연산자 $d\pi(X)$를 가지며, 힐베르트-슈미트 노름 제곱 $\mathrm{hs}(g) = \sum_{a,b} \lvert g_{ab}\rvert^2$에 관해 완만 증가 부등식

$$
\forall i \in \mathbb{N},\; \exists (q\text{ 연속 반노름}),\; \exists N \in \mathbb{N},\quad \forall g \in U(J_\varepsilon),\; \forall v \in E,\quad p_i(\pi(g)v) \le \bigl(1 + \mathrm{hs}(g)\bigr)^N q(v)
$$

를 만족하는 매끄러운 완만 증가 프레셰(Fréchet) 표현임을 뜻합니다. 한편 기약 유니터리 힐베르트 표현 $(\sigma, \mathcal{H})$ 위의 유한 리 대수 단어 목록 $S = [l_1, \dots, l_m]$ ($l_r = [X_{r,1}, \dots, X_{r,k_r}] \subset \mathfrak{u}(J_\varepsilon)$)에 대응하는 소볼레프 노름은 `sobNorm σ S w` (`L34-35`), 즉

$$
\| w \|_{S, \sigma} := \sum_{l \in S} \bigl\| d\sigma(X_{l,1}) \cdots d\sigma(X_{l,k_l}) w \bigr\|_{\mathcal{H}}
$$

로 정의됩니다. 이때 `CasselmanWallach : Prop` (`L98-112`)는 임의의 $(\mathfrak{u}(J_\varepsilon), K_\varepsilon)$-가군 준동형 $T_0 : \mathcal{H}_{K\text{-fin}} \to E$ (`IsGKMap ε σ π dπ T₀`)마다 매끄러운 벡터 전체 공간 $\mathcal{H}^\infty = \{w \in \mathcal{H} \mid \mathrm{SmoothVec}(\mathfrak{u}(J_\varepsilon), \sigma, w)\}$ 위에서 다음 네 성질을 동시에 만족하는 연장 $T$가 존재함을 요구합니다.

1. **$G$-등변 연속 연장 (`L105`)**: $\mathcal{H}_{K\text{-fin}}$ 위에서 $T = T_0$이고, 모든 $g \in U(J_\varepsilon), w \in \mathcal{H}^\infty$에 관해 $T(\sigma(g)w) = \pi(g)(Tw)$이며 각 반노름 $p_i(Tw) \le C_i \|w\|_{S_i, \sigma}$로 지배됩니다(`IsSmoothGMap`).
2. **유일성 (`L106-107`)**: $\mathcal{H}_{K\text{-fin}}$ 위에서 $T_0$와 일치하는 또 다른 연속 $G$-사상 $T'$는 $\mathcal{H}^\infty$ 전체에서 $T' = T$입니다($\mathcal{H}_{K\text{-fin}}$의 $\mathcal{H}^\infty$-소볼레프 조밀성).
3. **닫힌 상 성질 (`L108`)**: 매끄러운 부분공간의 상 $T(\mathcal{H}^\infty) \subset E$는 프레셰 공간 $E$ 안에서 닫힌 부분집합(`IsClosed`)입니다.
4. **역 소볼레프 위상 매장성 (`L109-111`)**: 만약 $T_0\rvert_{\mathcal{H}_{K\text{-fin}}} \neq 0$이면(기약성에 의해 $T_0$는 단사), 임의의 리 단어 목록 $S$마다 $E$ 위의 연속 반노름 $q$가 존재하여 모든 $w \in \mathcal{H}^\infty$에 관해 역 부등식

$$
\| w \|_{S, \sigma} \le q(T w)
$$

이 성립합니다. 이는 열린 사상 정리(Open Mapping Theorem)에 의해 $T : \mathcal{H}^\infty \xrightarrow{\sim} T(\mathcal{H}^\infty) \subset E$가 위상적 선형 동형사상이 됨을 뜻하며, 카셀만(`1989`, *Canonical extensions of Harish-Chandra modules*) 및 왈라흐(`1992`, *Real Reductive Groups II*, 제11장) 정리의 핵심 결론을 `UJset ε` 기약 유니터리 표현이라는 **유형 II-A 도메인** 위에 한 치의 손실도 없이 구현한 명세입니다.
이 명세의 증명은 `Development/WeilBound/CoreStatements/PublishedTheorems/CasselmanWallach/FinalB.lean:8`의 `PositivityTheory.CWB.casselmanWallach`에서 종결됩니다.
아울러 같은 이름(`FinalB.lean`)을 쓰는 아델 허용성 모듈 `CompanionTheory/RealGroups/UnitaryAdmissibility/ArchimedeanUnitaryDual/FinalB.lean:53-57`은 이와사와·카르탕 격자 합동 부분군 분해(`stCartanU`)와 헤케 대수 사영(`locPI`)을 결합하여 국소·실수 유니터리 허용성 `UnitaryIrreducibleAdmissible`과 아델 기약 표현 인수분해 `FlathTensorProduct`(Flath `1979`, 유형 I)를 증명합니다.

---

### 2.4 이산계열 매개변수 소진성(`DsExhaust`)과 블래트너 $K$-타입 원뿔 감사

피참조 `1,354`회인 `Development/AbelianVarietyTheory/PublishedTheorems/TwistedTraceFormula/AdmissibleDiscreteSeriesOfHasParam.lean:16-264`와 두 직접 임포트 `CompanionTheory/RealGroups/DiscreteSeries/DiscreteSeriesClassification/KTypesAbove.lean:9-22`,
`CompanionTheory/RealGroups/DiscreteSeries/DiscreteSeriesClassification/DiscreteSeriesExhaustion/DsExhaust.lean:14-21`은 2중 피복군 `T : GrpData p q` 위 이산계열 표현(`DSRep T`)의 분류와 소진성을 담당합니다.

원문 `Development/AbelianVarietyTheory/PublishedTheorems/TwistedTraceFormula/AdmissibleDiscreteSeriesOfHasParam.lean:19-39`에서 하리시-찬드라 매개변수 $\lambda : \mathrm{Ix}(p,q) \to \mathbb{Q}$ (`IsParam lam`,
반정수 정칙 매개변수)에 대응하는 블래트너(Blattner) 최저 $K$-타입 가중치 $\Lambda_{\mathrm{Bl}}(\lambda) = \mathrm{blattner}(\lambda)$와 양근 원뿔 조건 `InCone lam μ` (`L19-23`)는 음이 아닌 정수 행렬 $m : \mathrm{Ix}(p,q)^2 \to \mathbb{N}$ ($m_{a,b} \neq 0 \implies \lambda_b < \lambda_a$)을 써서

$$
\mu = \Lambda_{\mathrm{Bl}}(\lambda) + \sum_{\lambda_a > \lambda_b} m_{a,b} (e_a - e_b)
$$

로 기술됩니다. `HasTypes R lam` (`L24-28`)은 이산계열 표현 $R$이 ① 최고 가중치 공간 $\mathrm{hwSub}(\Lambda_{\mathrm{Bl}}(\lambda))$에서 중복도 `1`을 갖고, ② 카시미르 연산자가 스칼라 $\|\lambda\|^2 - \|\rho_{p+q}\|^2$로 작용하며, ③ $R$에 나타나는 모든 $K$-타입 최고 가중치 $\mu$가 위 원뿔 `InCone lam μ` 안에 놓임을 뜻합니다. 특히 원문 `L138-175`의 보조정리 `vogan_add_le`는 보간 노름(Vogan $\Lambda$-norm) 이차 부등식

$$
\mathrm{vogan}\bigl(\Lambda_{\mathrm{Bl}}(\lambda)\bigr) + \sum_{c \in \mathrm{Ix}(p,q)} \bigl(\mu_c - \Lambda_{\mathrm{Bl}}(\lambda)_c\bigr)^2 \le \mathrm{vogan}(\mu)
$$

를 순수 대수 산술(`ring`, `linarith`)로 증명하여 최저 $K$-타입의 유일성과 매개변수 결정성(`HasTypes.eq_of_hasParam`, `L192-203`)을 도출합니다. 이어서 `DiscreteSeriesCover : Prop` (`L35-39`)는 모든 $p+q \ge 1$과 `T : GrpData p q`마다 정칙 매개변수 집합에서 `DSRep T`로의 전단사 분류 사상 $D$가 존재하여 모든 $\lambda$에서 `HasTypes (D lam) lam.1`이 성립하고 임의의 이산계열 표현 $R$이 어떤 $D(\lambda)$와 유니터리 동치(`UnitEquiv R (D lam)`)임을 요구합니다.
`CompanionTheory/RealGroups/DiscreteSeries/DiscreteSeriesClassification/KTypesAbove.lean:9-20`이 정칙 단면의 명시적 $L^2$ 적분 가능성으로 존재성(`discreteSeriesExists`, `discreteSeriesCoverExists`)과 원뿔 조건(`kTypesAbove`)을 구성하고,
`CompanionTheory/RealGroups/DiscreteSeries/DiscreteSeriesClassification/DiscreteSeriesExhaustion/DsExhaust.lean:14-21`이 카시미르 이동과 행렬계수 감쇠 추정으로 소진성(`dsExhaust`)을 닫아 이 명세를 완성합니다.

| 감사 대상 명세 식별자 | 원문 위치 (`src/` 기준) | 피참조 | 대응 고전 원전 | 동치성 분류 및 번역 어댑터 핵심 점검 사항 |
| :--- | :--- | ---: | :--- | :--- |
| `CuspRapidDecay` / `CuspDecayBound` | `Development/AbelianVarietyTheory/PublishedTheorems/AutomorphicForms₂/ExistsNormLeHeightPow.lean:28-33` | `2,460` | Godement, Harish-Chandra (1968), Borel (1974) | **유형 II-A**: `D7` 에르미트 공간 `GA D V` 투영. `IsExpFam` 미분 단어와 표준 지겔 영역 소볼레프 노름 동치성 확인 필요 |
| `FiniteVolume₂` | `Development/AbelianVarietyTheory/Definitions/Foundations/CdScaleTieIff.lean:81-85` | `2,460` 경유 | Borel-Harish-Chandra (1962) | **유형 I (유니터리군)**: 임의 CM 확장 $E/F$ 비퇴화 에르미트 아델 몫의 유한 하르 부피. 고전 정리 직결 |
| `HarishChandraModules` | `Development/AbelianVarietyTheory/PublishedTheorems/TwistedTraceFormula/HarishChandraModulesOn.lean:24-45` | `1,684` | Harish-Chandra (1953, 1954), Nelson (1959) | **유형 II-A**: `GrpData p q`($\det^{1/2}$ 2중 피복) 및 `UJset ε` 기약 유니터리 표현 특화. 피복군의 유한 중심 행렬 리 군 성질 점검 |
| `HarishChandraFinite` | `Development/AbelianVarietyTheory/PublishedTheorems/AutomorphicForms₂/HarishChandraFinite.lean:50-59` | `814` | Harish-Chandra (1968), 정리 1 | **유형 II-A**: `D7` 위 겔판트 중심 연산자 `gelf θ V τ k` 고윳값 고정 공간 유한차원성. 하리시-찬드라 동형사상으로 $\mathcal{Z}(\mathfrak{g})$ 생성성 확인 |
| `CasselmanWallach` | `Development/AbelianVarietyTheory/PublishedTheorems/AutomorphicForms₂/HasDRepIffHasDerivAt.lean:98-112` | `1,051` | Casselman (1989), Wallach (1992) | **유형 II-A**: `UJset ε` 기약 유니터리 힐베르트 표현의 $\mathcal{H}^\infty$ 완비화 닫힌 상 및 역 소볼레프 매장성. 일반 정리의 특수 경우 |
| `DiscreteSeriesCover` | `Development/AbelianVarietyTheory/PublishedTheorems/TwistedTraceFormula/AdmissibleDiscreteSeriesOfHasParam.lean:35-39` | `1,354` | Harish-Chandra (1965-1966), Hecht-Schmid (1975), Herb | **유형 II-A**: `GrpData p q` 위 유리 반정수 매개변수 블래트너 $K$-타입 분류 및 소진성(`DsExhaust`). 2중 피복군 바일 지표 공식 어댑터 점검 |

---

### 2.5 이산계열 형식 차수(`FormalDegreeFormula₂`) 및 딕스미에-말리아뱅 대각합 부류 감사

실수 리 군 기둥에서 스펙트럼 전개와 상대 대각합 공식의 정규화 상수를 고정하는 또 다른 핵심 명세가 이산계열의 **형식 차수(formal degree) 공식**과 **첨점 합성곱 연산자의 대각합 부류(trace class) 성질**입니다.

첫째, `Development/AbelianVarietyTheory/Definitions/Foundations/CdScaleTieIff.lean:92-98`의 `FormalDegreeFormula₂` 및 직접 임포트 `Development/WeilBound/RepresentationTheoryGL/DiscreteSeries/DiscreteSeriesCovers/FdTopB.lean:7-10`(`formalDegreeCompactDual`)은 콤팩트 쌍대군 $U(N)$과의 하르 측도 비율 척도 `CdScaleIs cd sc`가 주어졌을 때,
부호 벡터 $\varepsilon : \mathrm{Fin}\,N \to \mathrm{Bool}$ 위 하리시-찬드라 매개변수 $\lambda \in \mathbb{R}^N$ (`IsHCParam lam`)에 대응하는 이산계열 표현 $(\sigma, \mathcal{H})$와 임의의 비영 벡터 $w \neq 0$에 관하여 슈어 직교성 형식 차수가 명시적 바일 차수 곱과 일치함을 선언합니다.

$$
d_\sigma\bigl(\mathrm{sc}(N, \varepsilon) \cdot \mu_{G_\varepsilon}\bigr) = \mathrm{fdeg}_{\mathrm{HC}}(\lambda) = \prod_{1 \le i < j \le N} \frac{\lvert \lambda_i - \lambda_j \rvert}{j - i}
$$

여기서 좌변 $d_\sigma(\mu)$는 제곱적분가능 행렬계수 직교 관계 $\int_{G_\varepsilon} \lvert \langle \sigma(g)w, w \rangle \rvert^2\, d\mu(g) = d_\sigma(\mu)^{-1} \|w\|^4$로 정의되는 형식 차수입니다(`SchurOrthogonalitySquareIntegrable`). 이는 하리시-찬드라(`1966`) 및 그로스-프랑켈-간(콤팩트 쌍대 오일러-푸앵카레 측도 정규화) 공식의 `UJset ε` 투영(**유형 II-A**)이며, 비영 정칙 보형 형식의 존재성을 하한 평가할 때 아르키메데스 플랑슈렐 밀도를 정확한 유리수로 고정하는 역할을 맡습니다.

둘째, `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/EveryCharacterOfLiteratureOfVWin.lean:341-342` 및 `L367-368`에 등록된 `cusp_trace_class_of_literature`와 `dixmier_malliavin_factorisation_of_literature`의 결합 구조를 보면, 아카이브는 뮐러(W. Müller, `1989`)의 일반 가약군 대각합 부류 정리를 첨점 부분공간에 한정해 훨씬 간결한 해석적 경로로 증명합니다.
구체적으로 `Development/AbelianVarietyTheory/Proofs/DivisorProofs/DixmierMalliavinFactorisationFromLibrary.lean:7-9`와 `Development/WeilBound/CoreStatements/AbelianHeightsDuality/PublishedTheoremStatements/BridgesMore.lean:47-49`는 임의의 매끄러운 콤팩트 지지 시험함수 $f \in C_c^\infty(G(\mathbb{A}))$가 유한 개의 매끄러운 함수 합성곱 합

$$
f = \sum_{j=1}^{r} \alpha_j * \beta_j \qquad \bigl(\alpha_j, \beta_j \in C_c^\infty(G(\mathbb{A}))\bigr)
$$

으로 분해된다는 딕스미에-말리아뱅(`1978`, Ann. Sci. ENS 11) 인수분해 정리(`DixmierMalliavinFactorisation`, **유형 I**)를 먼저 증명합니다.
그런 다음 제2.1절의 첨점 급감소(`CuspRapidDecay`)와 유한 부피(`FiniteVolume₂`)에 의해 단일 매끄러운 커널 적분 연산자 $R(\alpha_j)\rvert_{L^2_{\mathrm{cusp}}}$가 유계 커널을 가져 **힐베르트-슈미트(Hilbert-Schmidt) 연산자**가 됨을 보이고, 두 힐베르트-슈미트 연산자의 합성 $R(\alpha_j) \circ R(\beta_j)$는 자동으로 **대각합 부류(trace class, 핵 연산자)**가 된다는 표준 함수해석학 정리를 적용하여 `cuspTraceClass_of`를 단 세 줄 만에 완결합니다.

---

## 제3장. 켤레 자기쌍대 갈루아-보형 대응, 강화 랑글란즈 및 자케-샬리카 강성 원문 감사

### 3.1 `CohomologicalCsdTempered` 스텁(`in_degree = 2,242`)과 코호몰로지 완만성 사슬

제3막과 제4막에서 갈루아 표현과 유니터리 보형 형식을 연결하는 대역 표현론의 출발점은 정칙 대수적 켤레 자기쌍대(RAECSDC) 첨점 표현의 모든 유한 자리 국소 성분이 완만(tempered)하다는 라마누잔-페터슨 순수성 정리입니다.
앞서 제1.2절에서 확인했듯 `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/CohomologicalCsdTempered.lean:1`(`in_degree = 2,242`)은 리팩터링 이후 `import Mathlib` 한 줄만 남은 호환 스텁이며,
실제 수학적 명세와 증명은 `Development/AbelianVarietyTheory/PublishedTheorems/GaloisGeometry₂/CaraianiTempered.lean:13-18`과 `Development/AbelianVarietyTheory/Proofs/SatakeParameters/CohomologicalCsdTemperedOfSegments.lean:16-29`에 수록되어 있습니다.

```lean
-- Development/AbelianVarietyTheory/PublishedTheorems/GaloisGeometry₂/CaraianiTempered.lean:13-18
def CaraianiTempered : Prop :=
  ∀ (L : Type) [Field L] [NumberField L] [IsCMField L] (n : ℕ), 2 ≤ n →
    ∀ π : CuspSub L n, π.IsCsd → GKCoh.IsCohomological π →
      ∀ (y : HeightOneSpectrum (𝓞 L)) (σ : SmIrr (GL (Fin n) (y.adicCompletion L))), π.IsLocComp y σ →
        LocGL.IsTemperedCoeff σ.ρ
```

원문 `CaraianiTempered`는 임의의 CM 수체 $L$과 차수 $n \ge 2$에 관해, $\mathrm{GL}_n(\mathbb{A}_L)$의 첨점 보형 표현 $\pi$ (`CuspSub L n`)가 켤레 자기쌍대(`π.IsCsd`, $\pi^\vee \cong \pi^c$)이고 $(\mathfrak{g}, K_\infty)$-코호몰로지 표현(`GKCoh.IsCohomological π`)이면, 분기 여부를 불문한 **모든 유한 자리** $y$에서의 국소 기약 성분 $\sigma \cong \pi_y$가 행렬계수 완만 추정(`IsTemperedCoeff σ.ρ`)을 만족함을 진술합니다.
이는 카라이아니(`2012`, *Local-global compatibility and the action of monodromy on nearby cycles*, Duke Math. J. 161, 정리 1.2)의 주정리와 정확히 일치하는 **유형 I 명제**입니다.
이어 `Development/AbelianVarietyTheory/Proofs/SatakeParameters/CohomologicalCsdTemperedOfSegments.lean:16-29`는 이 행렬계수 완만성에 자케의 완만 유도분해(`TemperedProductOfSquareIntegrable`)와 젤레빈스키 중심 뒤틀림 제곱적분가능 세그먼트 분류(`EssSquareIntegrableSegments`)를 결합하여, 각 국소 성분 $\pi_y$가 유니터리화 가능한 제곱적분가능 세그먼트 표현들의 표준 포물선 유도곱과 동형이라는 표현론적 분해 형태 `CohomologicalCsdTempered`를 도출합니다.

---

### 3.2 선별 로커스(`GoodCusp`) 국소 랑글란즈 대응 `IsRecT`와 `LlOf.lean` 투영 어댑터

제3장에서 가장 주목할 포렌식 발견은 아카이브가 해리스-테일러(`2001`)·에니아르(`2000`)의 $\mathrm{GL}_n$ 국소 랑글란즈 대응을 어떻게 정식화하고 우회했는가 하는 점입니다.
피참조 `775`회인 `Development/AutomorphicArithmetic/Foundations/LocalLanglands/IsRecTOfIsRec.lean:20-85`를 열면, 임의의 비아르키메데스 국소체 $k$ 위 모든 초첨점 표현에서 전단사성과 $\varepsilon$-인자 보존을 요구하는 고전 명세 `IsRec` 대신, **좋은 초첨점 로커스 `GoodCusp`**에 집중된 약화·강화 혼합 명세 `IsRecT`가 핵심 인터페이스로 정의되어 있습니다.

```lean
-- Development/AutomorphicArithmetic/Foundations/LocalLanglands/IsRecTOfIsRec.lean:20-27, 55-80
def GoodCusp (y : IrrGL k) : Prop :=
  y.1 = 1 ∨ ((∃ (g : ℕ) (_ : Fact g.Prime) (i : ℚ_[g] ≃+* k), Continuous i) ∧
    ∃ (y₀ : IrrGL k) (χ : kˣ →* ℂˣ) (hχ : IsSmoothChar χ),
      GlobalTheory.PRep.fixed y₀.rep (GlobalTheory.SplitWeil.KOne k (Fin y₀.1)) ≠ ⊥ ∧ y = y₀.tw χ hχ)

def Good (x : IrrGL k) : Prop := ∃ s, HasSupport x.rep s ∧ ∀ y ∈ s, GoodCusp y
```

이 정의를 수식으로 해독하면 극도로 정교한 전략적 축소가 드러납니다. 기약 매끄러운 표현 $y \in \mathrm{Irr}(\mathrm{GL}_m(k))$가 `GoodCusp`에 속한다는 것은 다음 두 조건 중 하나를 만족한다는 뜻입니다.

$$
\mathrm{GoodCusp}(y) \iff (m = 1) \;\lor\; \Bigl( k \simeq_{\mathrm{top}} \mathbb{Q}_g \;\land\; \exists y_0, \chi:\; y_0^{1 + g M_m(\mathbb{Z}_g)} \neq 0 \;\land\; y \cong y_0 \otimes (\chi \circ \det) \Bigr)
$$

즉 1차원 준지표이거나, 기저 국소체가 **절대 비분기 소수체 $\mathbb{Q}_g$와 동형**이면서 제1합동 부분군 $K_1 = I_m + g M_m(\mathbb{Z}_g)$ (`KOne k`) 고정 벡터를 갖는 **모이-프라사드 깊이 `0` 표현 $y_0$의 지표 비틀림**인 경우만 `GoodCusp`로 지정합니다. 그리고 `Good(x)`는 초첨점 지지(supercuspidal support)의 모든 인자가 `GoodCusp`에 속하는 표현입니다.
그 위에서 베유-들리뉴 사상 $\mathrm{rc} : \mathrm{IrrGL}(E_w) \to \mathrm{WD}(E_w)$의 공리 구조체 `LawsT a ha rc` (`L55-73`)는 이원화된 조건을 부과합니다.

1. **전체 표현 공간 $\mathrm{IrrGL}(E_w)$ 위에서의 전역 조건 (`L57-64`)**: 차원 보존 $\dim \mathrm{rc}(x) = n$, $n=1$ 국소 아르틴 사상 일치 $\mathrm{rc}(\chi) = \chi \circ a$, 랑글란즈 다중세그먼트 분류 가법성 $\mathrm{rc}(L(\Delta_1, \dots, \Delta_r)) = \bigoplus_j \mathrm{rc}(\Delta_j)$, 초첨점 표현의 기약 베유-들리뉴 상(`IsIrrWD`), 비분기 복소 거듭제곱 이동 $\mathrm{rc}(x \otimes \lvert\det\rvert^s) = \mathrm{rc}(x)(s)$,
중심 지표 절댓값 보존 $\prod \lvert \lambda_i(\mathrm{rc}(x)(\sigma)) \rvert = \lvert \omega_x(a(\sigma)) \rvert$.
2. **`Good` 부분 로커스 위에서의 정밀 조건 (`L65-72`)**: `Good x`일 때만 정확한 지표 비틀림 호환성(`twist`), 부호까지 포함한 중심 지표 일치 $\det \mathrm{rc}(x)(\sigma) = \omega_x(a(\sigma))$ (`central`), 반경사 쌍대성 $\mathrm{rc}(\pi^\vee) = \mathrm{rc}(\pi)^\vee$ (`dual`), `Good y`에 관한 단사성 $\mathrm{rc}(x) = \mathrm{rc}(y) \implies x = y$ (`inj`), 깊이 `0`일 때의 완만 분기성(`IsTameWD`, `depth`),
그리고 가장 결정적인 **깊이 `0` 관성 다항식 명시 공식 `TypeLaw`**(`L35-53`)을 요구합니다.

원문 `L35-53`의 `TypeLaw`는 유한체 $\mathbb{F}_{g^n}$ (`normV w' = g ^ n`, $(g) \notin w'^2$)의 그린(J. A. Green, `1955`) 정칙 원환 지표 $\theta : \mathbb{F}_{g^n}^\times \to \mathbb{C}^\times$ (`IsRegularChar g n θ`)로부터 유도된 유한 일반선형군 $\mathrm{GL}_n(\mathbb{F}_g)$ 첨점 표현 $\tau$가 깊이 `0` 표현 $\sigma$로 부풀려질(`Inflates`) 때,
대응하는 베유-들리뉴 표현 $\mathrm{rc}(\sigma)$는 단자 연산자가 `0`(`mono0`)이고 야생 분기를 제외한 관성 원소 $t \in I_{E'}$ (국소 아르틴 상 $a'(t) \equiv z \pmod{\mathfrak{p}_{E'}}$) 위에서의 특성다항식이 정확히 프로베니우스 갈루아 켤레들의 곱

$$
P_{\mathrm{inert}}\bigl(\mathrm{rc}(\sigma)\rvert_{I_{E'}}(t), X\bigr) = \prod_{j=0}^{n-1} \Bigl( X - \theta\bigl(z^{g^j}\bigr) \Bigr)
$$

이 됨을 규정합니다(Bushnell-Henniart `2006` *The Local Langlands Conjecture for GL(2)* 및 Silberger-Zink 깊이 `0` 맥도날드 대응). 왜 이런 **유형 II-B 로커스 특화**가 도입되었을까요. 아카이브가 자체 증명한 신작 영점 소거 엔진은 임의의 고차 야생 분기 초첨점 표현을 쓸 필요가 없고 오직 유리수체 $\mathbb{Q}$ 위에서 분해되거나 깊이 `0`인 보조 자리(`g.Prime`)에서의 사타케·관성 고윳값 추적만 필요로 합니다.
덕분에 아카이브는 시무라 다양체 소멸 윤체 전체를 동원해야 하는 일반 해리스-테일러 정리 대신, 깊이 `0` 들리뉴-루스티그·그린 지표 이론만으로 `Development/AutomorphicArithmetic/Foundations/LocalLanglands/LocalCentralUnits/RecTExists.lean:20-66`에서 `RecTExists`를 훨씬 직접적으로 구성해 냈습니다.
나아가 `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/LlOf.lean:18-21`을 열면 구 버전(`namespace Old`)이 비워지고 신 버전(`namespace New`)에서

```lean
-- Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/LlOf.lean:18-21
theorem llOf_alt : RecTExists → LocalConverseGL → DepthZeroInduction →
    BrauerDegreeZero → ChevalleyUnits → GlobalArtinReciprocity → LanglandsExhaustionGL → LanglandsMultisegments →
    StandardCosocleGL → ZelevinskyPolynomialRing → GeometricLemma → BernsteinZelevinskyFiniteness → RecTExists :=
  fun h _ _ _ _ _ _ _ _ _ _ _ => h
```

와 같이 나머지 `11`개 인자를 버리고 제1인자 `h : RecTExists`를 그대로 투영하는 어댑터로 리팩터링된 흔적이 고스란히 확인됩니다(한편 고전적 전체 `LocalLanglandsGL`을 깊이 `0`·브라우어·국소 역정리로부터 연역하는 경로 자체도 `Development/AbelianVarietyTheory/Proofs/InertiaEigenvalues/LocalLanglandsOfHyp.lean:22-49`에 별도로 보존되어 있습니다).
인간 수학자가 150쪽 압축 논문을 쓸 때는 해리스-테일러(`2001`)·에니아르(`2000`)의 고전 정리 `IsRec`과 부슈넬-에니아르 깊이 `0` 관성 공식 `DepthZeroTypeInertia`를 인용한 뒤 `Development/AutomorphicArithmetic/Foundations/LocalLanglands/IsRecTOfIsRec.lean:106-113`의 정리 `isRecT_of_isRec : DepthZeroTypeInertia → IsRec h rc → IsRecT h rc`를 번역 어댑터로 한 줄 인용하면 완벽히 접속됩니다.

---

### 3.3 편극 갈루아 표현 및 $\ell = p$ 국소-대역 호환성(`PolarizedGaloisRepPublished`, `CaraianiLocalGlobalDual`) 감사

클로젤-해리스-테일러(`2008`), 신석우(`2011`), 카라이아니(`2012`, `2014`), 바넷-램-지-게라티-테일러(`2014`)의 갈루아 표현 구성 정리는 원문 `Development/AbelianVarietyTheory/PublishedTheorems/GaloisGeometry₂/PolarizedGaloisRepPublished.lean:20-73`과 `Development/AbelianVarietyTheory/PublishedTheorems/GaloisGeometry₂/CaraianiLocalGlobalDual.lean:16-29`에 **유형 I** 수준으로 극도로 정밀하게 기록되어 있습니다.

원문 `PolarizedGaloisRepPublished` (`L67-73`)는 임의의 CM 수체 $E$ (최대 실수 부분체 $F = E^+$), 소수 $\ell$, 체 동형 $\iota : \overline{\mathbb{Q}}_\ell \xrightarrow{\sim} \mathbb{C}$, 차수 $a \ge 1$, 정칙 대수적 첨점 표현 $\pi$ (`(CG.mk π).IsRegAlg`) 및 편극 헤케 지표 쌍 $(\pi, \chi)$ (`PolarizedPair π χ`, 즉 $\pi^\vee \cong \pi^c \otimes (\chi \circ \mathrm{Nm}_{E/F} \circ \det)$과 부호 조건)에 관하여,
연속 반단순 갈루아 표현 $r : \mathrm{Gal}(\overline{E}/E) \to \mathrm{GL}_a(\overline{\mathbb{Q}}_\ell)$과 정수 가중치 $\mathrm{wt} \in \mathbb{Z}$, 호지-테이트 중복집합 $HT : \mathrm{Hom}(E, \overline{\mathbb{Q}}_\ell) \to \mathrm{Multiset}(\mathbb{Z})$가 존재하여 `GalHyps.Props` (`L36-62`)의 여섯 성질을 만족함을 진술합니다.

1. **편극 켤레 쌍대성 (`pol`, `L43-44`)**: $\chi$에 대응하는 $\ell$-진 지표 $\mu$와 복소켤레 연장 $c \in \mathrm{Aut}(\Omega)$에 관하여 $r^c \cong r^\vee \otimes \epsilon_{\mathrm{cyc}}^{1-a} \mu\rvert_{G_E}$ (`IsConjDual`).
2. **$\ell \nmid w$ 국소-대역 호환성 및 순수성 (`away`, `pure`, `L46-50`)**: $\ell$을 나누지 않는 모든 자리 $w$에서 $\mathrm{WD}(r\rvert_{G_{E_w}}) = \mathrm{rc}(\pi_w \otimes \lvert\det\rvert^{(1-a)/2})$ (`algNorm σ`)이며, $\mathrm{wt}/2$만큼 뒤튼 베유-들리뉴 표현이 완만(`tempered`)합니다.
3. **무한소 지표와 호지-테이트 점프 대응 (`weights`, `weights_conj`, `L52-56`)**: 각 매장 $\tau : E \hookrightarrow \overline{\mathbb{Q}}_\ell$에서 $\pi_\infty$의 하리시-찬드라 무한소 지표 중복집합 $m_\tau \subset \mathbb{C}$와 호지-테이트 가중치 $HT(\tau) \subset \mathbb{Z}$는 고전적 반정수 이동 공식

$$
HT(\tau) = \left\{ \frac{a - 1}{2} - z \;\middle|\; z \in m_{\iota \circ \tau} \right\}, \qquad HT(\tau \circ c) = \bigl\{ \mathrm{wt} - h \;\big|\; h \in HT(\tau) \bigr\}
$$

을 만족합니다.
4. **$\ell \mid w$ $p$-진 호지 호환성 (`Above`, `L20-35`)**: $\ell$ 위의 모든 자리 $w$에서 제한 표현 $r\rvert_{D_w}$는 드람 표현(`IsdRAt`)이며 각 유도 매장에서 정확히 $HT(\tau)$를 호지-테이트 점프로 가집니다(`jumps`). 또한 $\pi_w$가 이와호리 고정 벡터를 가지면 준안정(`IsSstAt`)이면서 폰텐 베유-들리뉴 함자 상 `wdAt`이 `rc (algNorm σ)`와 일치하고(`iwahori`), $\pi_w$가 비분기 구형 표현(`IsSpherical`)이면 결정 표현(`IsCrysAt`)이 됩니다(`crys`).

더 나아가 `Development/AbelianVarietyTheory/PublishedTheorems/GaloisGeometry₂/CaraianiLocalGlobalDual.lean:16-29`는 이와호리 가정을 제거하여 모든 $\ell \mid w$ 자리에서 잠재적 준안정성(`IsPstAt`)과 베유-들리뉴 일치식 `wdAt P ι Bw h hj (R.comp Dec.subtype) = rc (algNorm σ)`(Caraiani `2014`, Duke Math. J. 163)을 진술하며,
`Development/AbelianVarietyTheory/Proofs/SatakeParameters/LocalGlobalAboveL.lean:20-37`은 $\ell \nmid w'$ 자리들의 베유 군 대각합 일치와 체보타레프 반단순 켤레 유일성(`semisimple_conj_of_trace_equal`)을 결합해 임의의 편극 갈루아 표현 $r$로 $\ell \mid w$ 호환성을 이전합니다.
`n = 1` 대수적 헤케 지표의 경우 대응하는 베유-들리뉴 일치식 `AlgebraicCharacterWD`가 `Development/AbelianVarietyTheory/PublishedTheorems/GaloisGeometry₂/AlgebraicCharacterWD.lean:14-24`에 정의되고 `Development/AutomorphicArithmetic/ThetaCorrespondence/AlgebraicCharacters/AlgebraicCharacterWD.lean:9-33`에서 국소-대역 아르틴 가환성 및 호지-테이트 지수 소거(`locPow * ∏ τ(a σ)^(-n) = 1`, `L21-27`)로 직접 증명됩니다.

---

### 3.4 자케-샬리카 등압 강성·사타케 상한 및 번스타인 유니터리 유도곱 기약성 감사

$\mathrm{GL}_n$ 보형 스펙트럼의 강성과 국소 포물선 유도 기약성을 규율하는 자케-샬리카 정리와 번스타인 정리는 원문에서 각각 완전 복소 수체 로커스 **유형 II-B**와 비아르키메데스 일반 **유형 I**로 정식화되어 있습니다.

첫째, `Development/AbelianVarietyTheory/PublishedTheorems/GaloisCohomology₂/StrongMultiplicityOne.lean:189-203`(`in_degree = 463`)에 정의된 `JacquetShalikaRigidity`와 `JacquetShalikaBound`는 완전히 복소인 수체 $E$ (`IsTotallyComplex E`) 위의 첨점 동치류 `CG E m`에 관하여 다음 두 명제를 선언합니다.

```lean
-- Development/AbelianVarietyTheory/PublishedTheorems/GaloisCohomology₂/StrongMultiplicityOne.lean:189-203
def JacquetShalikaRigidity : Prop :=
  ∀ (E : Type) [Field E] [NumberField E] [IsTotallyComplex E] (ι κ : Type) [Fintype ι] [Fintype κ]
    (m : ι → ℕ) (m' : κ → ℕ) (π : ∀ i, CG E (m i)) (π' : ∀ j, CG E (m' j)),
    (∀ i, 1 ≤ m i) → (∀ j, 1 ≤ m' j) →
    (∀ᶠ w : HeightOneSpectrum (𝓞 E) in Filter.cofinite, ∃ (B : ι → Multiset ℂˣ) (B' : κ → Multiset ℂˣ),
      (∀ i, (π i).HasSat w (B i)) ∧ (∀ j, (π' j).HasSat w (B' j)) ∧ ∑ i, B i = ∑ j, B' j) →
    ∃ s : ι ≃ κ, ∀ i, (⟨m i, π i⟩ : Σ a, CG E a) = ⟨m' (s i), π' (s i)⟩

def JacquetShalikaBound : Prop :=
  ∀ (E : Type) [Field E] [NumberField E] [IsTotallyComplex E] (a : ℕ) (π : CG E a), π.IsUnitary →
    ∀ (w : HeightOneSpectrum (𝓞 E)) (B : Multiset ℂˣ), π.HasSat w B → ∀ α ∈ B,
      (Ideal.absNorm w.asIdeal : ℝ) ^ (-(1 / 2) : ℝ) < ‖(α : ℂ)‖ ∧ ‖(α : ℂ)‖ < (Ideal.absNorm w.asIdeal : ℝ) ^ (1 / 2 : ℝ)
```

수식으로 쓰면 유한 개 자리를 제외한 거의 모든 유한 자리 $w$에서 두 형식적 등압 합 $\boxplus_{i \in \iota} \pi_i$와 $\boxplus_{j \in \kappa} \pi'_j$의 비분기 사타케 매개변수 중복집합 합이 일치하면($\bigsqcup_{i \in \iota} B_{i,w} = \bigsqcup_{j \in \kappa} B'_{j,w}$), 전단사 치환 $s : \iota \xrightarrow{\sim} \kappa$가 존재하여 각 차수와 첨점 표현 쌍 $(m_i, \pi_i) = (m'_{s(i)}, \pi'_{s(i)})$가 일치한다는 자케-샬리카(`1981`,
*On Euler products and the classification of automorphic representations II*, Am. J. Math. 103, 정리 4.4) 정리 그대로입니다(단일 첨점 강한 중복도 1 `strong_multiplicity_one` 및 실수 거듭제곱 지수 유일성 `unitary`가 `L208-244`에서 이로부터 즉시 연역됨). 또한 `JacquetShalikaBound`는 유니터리 중심 지표를 갖는 첨점 표현의 모든 비분기 사타케 고윳값 $\alpha \in B_w$가 엄격한 부등식

$$
q_w^{-1/2} < \lvert \alpha \rvert < q_w^{1/2} \qquad \bigl(q_w := \mathrm{Nm}(\mathfrak{p}_w)\bigr)
$$

을 만족한다는 자케-샬리카(`1981`, 제I부 보조정리 2.5) 고전 상한과 정확히 일치합니다(단, 기저체를 일반 수체가 아닌 `[IsTotallyComplex E]`로 한정했으므로 엄밀한 분류상 **유형 II-B**에 속하며, CM 수체 기저변환 사슬에는 손실 없이 적용됩니다). 증명은 `Development/WeilBound/CoreStatements/PublishedTheorems/JacquetShalikaRigidity/JacquetShalikaRigidity.lean:10-16`에서 랭킨-셀베르그 극점 판정(`rsPole`)을 거쳐 완성됩니다.

둘째, `Development/AbelianVarietyTheory/PublishedTheorems/TwistedTraceFormula/BernsteinUnitaryProductIrreducible.lean:10-16`(`in_degree = 118`)에 정의된 `BernsteinUnitaryProductIrreducible`은 임의의 비아르키메데스 국소체 $k$와 임의의 차수 $r, t \in \mathbb{N}$에 관하여,
$\mathrm{GL}_r(k)$와 $\mathrm{GL}_t(k)$의 매끄럽고 기약이며 유니터리화 가능한(`IsUnitarisable`) 두 표현 $\pi_1, \pi_2$의 정규화 포물선 유도곱 $\pi_1 \times \pi_2$ (`prod₂ π₁ π₂`)가 항상 기약임을 진술합니다.
이는 조지프 번스타인(`1984`, *P-invariant distributions on GL(N) and the classification of unitary representations of GL(N)*, Springer LNM 1041, 정리 0.2)의 원논문 명제와 한 글자도 다르지 않은 완벽한 **유형 I 동치 명제**이며, 그 증인은 `Development/WeilBound/RepresentationTheoryGL/UnitaryDualProof/BernsteinExponentBounds/BernAll.lean:27-28`에서 공급됩니다.
한편 같은 파일명을 가진 `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/BernsteinUnitaryProductIrreducible.lean:12-85`는 번스타인 정리가 아니라 제3자리 `60`필드 가설 번들 `UnitaryGroupThirdPlaceHypotheses`를 정의하는 조립 파일이므로 파일명 혼동에 유의해야 합니다.

| 감사 대상 명세 식별자 | 원문 위치 (`src/` 기준) | 피참조 | 대응 고전 원전 | 동치성 분류 및 감사 판정 요지 |
| :--- | :--- | ---: | :--- | :--- |
| `CaraianiTempered` | `Development/AbelianVarietyTheory/PublishedTheorems/GaloisGeometry₂/CaraianiTempered.lean:13-18` | `5` (스텁 `2,242`) | Caraiani (2012), Clozel (1991), Shin (2011) | **유형 II-B**: `[IsCMField L]` 로커스에서 $n \ge 2$ 코호몰로지 켤레 자기쌍대 첨점 표현의 모든 유한 자리 완만성 |
| `IsRecT` / `RecTExists` | `Development/AutomorphicArithmetic/Foundations/LocalLanglands/IsRecTOfIsRec.lean:55-81` | `775` | Harris-Taylor (2001), Bushnell-Henniart (2006), Green (1955) | **유형 II-B**: $\mathrm{GL}_1$ 및 $\mathbb{Q}_g$ 깊이 `0` 비틀림 `GoodCusp` 로커스에서 단사성·관성 다항식 `TypeLaw` 부과. `isRecT_of_isRec`가 어댑터 제공 |
| `PolarizedGaloisRepPublished` | `Development/AbelianVarietyTheory/PublishedTheorems/GaloisGeometry₂/PolarizedGaloisRepPublished.lean:67-73` | `16` 경유 | CHT (2008), Shin (2011), BLGGT (2014) | **유형 II-A**: `[IsCMField E]` 및 `LocPrime`·`LocBridge` 주기환 브리지 위에서 편극 첨점 쌍의 $\ell$-진 갈루아 표현과 이와호리·구형 $p$-진 호지 호환성 정식화 |
| `CaraianiLocalGlobalDual` | `Development/AbelianVarietyTheory/PublishedTheorems/GaloisGeometry₂/CaraianiLocalGlobalDual.lean:16-29` | `16` | Caraiani (2012, 2014) | **유형 II-A**: `[IsCMField E]` 및 `LocPrime`·`LocAinf`·`LocTied`·`LocBridge` 위에서 $\ell \mid w$ 잠재적 준안정성(`IsPstAt`)과 `wdAt` 일치식 정식화 |
| `AlgebraicCharacterWD` | `Development/AbelianVarietyTheory/PublishedTheorems/GaloisGeometry₂/AlgebraicCharacterWD.lean:14-24` | `63` | Weil (1956), Serre (1968), Tate (1979) | **유형 II-A**: 아카이브 `LocPrime`·`LocBridge` 주기환 브리지 위에서 대수적 헤케 지표의 국소 베유-들리뉴 일치식 정식화 |
| `JacquetShalika` | `Development/AbelianVarietyTheory/PublishedTheorems/GaloisCohomology₂/StrongMultiplicityOne.lean:189-203` | `463` | Jacquet-Shalika (1981) | **유형 II-B**: `[IsTotallyComplex E]` 수체 로커스에서 사타케 중복집합 등압 분해 유일성 및 $q_w^{-1/2} < \lvert\alpha\rvert < q_w^{1/2}$ 상한 |
| `BernsteinUnitaryProductIrreducible` | `Development/AbelianVarietyTheory/PublishedTheorems/TwistedTraceFormula/BernsteinUnitaryProductIrreducible.lean:10-16` | `118` | Bernstein (1984) | **유형 I**: 비아르키메데스 $\mathrm{GL}_r(k) \times \mathrm{GL}_t(k)$ 유니터리 기약 표현 포물선 유도곱 기약성. 원논문과 완전 동치 |

---

### 3.5 모든 유한 자리 비분기 기저변환(`DefiniteN`) 및 대역화된 겔판트-카즈단 쌍대성 감사

제3장의 마지막 감사 항목으로 `EveryCharacterOfLiteratureOfVWin.lean`의 `022`번(`base_change_definite_unitary_group_of_literature`, `L261-262`)과 `037`번(`gelfand_kazhdan_dual_of_literature`, `L291-292`)을 원문에서 해부하면, 명칭만으로는 절대 짐작할 수 없는 두 가지 독창적 정식화가 확인됩니다.

첫째, 완전 정부호 유니터리 군에서 $\mathrm{GL}_n(\mathbb{A}_E)$로의 표준 기저변환을 담당하는 `Development/AutomorphicArithmetic/Foundations/BaseChangeIdentities/Narrow.lean:12-35`의 `DefiniteN` (`BaseChangeDefiniteUnitaryGroup`의 실체)을 열면 다음과 같은 전제가 명시되어 있습니다.

```lean
-- Development/AutomorphicArithmetic/Foundations/BaseChangeIdentities/Narrow.lean:28-35
def DefiniteN : Prop :=
  ∀ (E : Type) [Field E] [NumberField E] [IsCMField E],
    (∀ w : HeightOneSpectrum (𝓞 E), Algebra.IsUnramifiedAt (𝓞 (maximalRealSubfield E)) w.asIdeal) →
    ∀ n : ℕ, 1 ≤ n → ∀ π : Submodule ℂ (UA E n → ℂ), IsAutRepU π →
      ∃ (c : ℕ) (N : Fin c → ℕ) (h : ∑ i, N i = n) (V : ∀ i, Submodule ℂ (Sm E (N i)))
        (σ : ∀ i (w : HeightOneSpectrum (𝓞 E)), SmIrr (GL (Fin (N i)) (w.adicCompletion E)))
        (m : Fin c → (E →+* ℂ) → Multiset ℂ), IsBaseChangeU π h V σ m
```

원문 `L30`의 조건 `∀ w, Algebra.IsUnramifiedAt (𝓞 (maximalRealSubfield E)) w.asIdeal`에 주목해야 합니다. 일반 라베스(`2011`)나 신석우(`2014`)의 기저변환 정리는 임의의 CM 확장 $E/F$ 위에서 성립하지만 분기 소수 자리에서의 국소 안정 전이 인자(Langlands-Shelstad transfer factor)와 기본 보조정리(Fundamental Lemma) 처리를 요구합니다.
반면 본 아카이브는 유수 `1` 이상인 보조 CM 확장을 구성할 때 **최대 실수 부분체 $E^+$ 위 모든 유한 자리에서 비분기(`IsUnramifiedAt`)인 CM 확장**만을 선택합니다.
그 결과 모든 유한 자리가 분할(`IsSplitAt`, `L25`)이거나 비분기 관성(`IsUnramInv`, `L22-24`) 자리로만 나뉘어 분기 엔도스코피 전이가 통째로 우회되며, 등압 이산 합 $\boxplus_{i=1}^c V_i$ ($\sum_i N_i = n$, 각 $V_i$는 켤레 자기쌍대 이산 스펙트럼 `CsdAsc`)로의 승강이 비분기 구형 사타케 사상 `bcParam n α` 일치만으로 완결됩니다(**유형 II-B 로커스 특화**).

둘째, `Development/WeilBound/CoreStatements/TemperedRepresentationTheory/MultiplicityOneRigidity/GelfandKazhdanDualOfRigidity.lean:64-79`에 수록된 `gelfandKazhdanDual_of_rigidity`를 열면 아카이브의 `GelfandKazhdanDual`이 $p$-진 국소 표현론의 초함수 정리(Gelfand-Kazhdan `1975`)가 아니라 **대역 첨점 보형 공간 $\pi \subset \mathcal{A}_0(\mathrm{GL}_n(\mathbb{A}_E))$의 전치 역원 공간
$\pi^\iota = \{\varphi(g^{-T}) \mid \varphi \in \pi\}$ (`dualSubC π`)와 반경사 쌍대 페터슨 내적의 동형(`InvTransposeModel π`)으로 대역화되어 있음**이 드러납니다.
덕분에 아카이브는 번스타인-젤레빈스키 초함수 이론을 다시 경유하지 않고도, 거의 모든 비분기 자리에서 $\pi^\iota$와 $\pi^\vee$의 사타케 매개변수가 일치함(`hasSat_dual`, `L69`)을 보인 뒤 제3.4절의 자케-샬리카 강한 중복도 1(`hJ.strong_multiplicity_one`,
`L66`)을 즉시 적용해 $\pi^\iota \cong \pi^\vee$를 대역적으로 단숨에 증명해 냅니다(`Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/SPairs.lean:11-14`에서 편극 첨점 쌍을 갈루아 표현 입력으로 넘길 때 바로 이 대역 형태가 사용됨).

셋째, 국소 유니터리 쌍대 분류를 닫는 `Development/AbelianVarietyTheory/PublishedTheorems/GaloisCohomology₂/IsComplementaryProductOfIsCuspidal.lean:14-33`의 `GenericUnitaryDualGL`은 표수 `0` 비아르키메데스 국소체 $k$ 위 $\mathrm{GL}_N(k)$의 매끄럽고 기약이며 유니터리화 가능한 모든 일반적(`IsGeneric`,
비퇴화 휘태커 모형 보유) 표현 $\pi$가 유니터리 랑글란즈 세그먼트 $\delta_i$들과 개구간 $0 < \sigma_j < 1/2$ 지수의 보충계열 쌍 $\tau_j \lvert\det\rvert^{\sigma_j} \times \tau_j \lvert\det\rvert^{-\sigma_j}$들의 기약 포물선 유도곱(`IsComplementaryProduct π`)과 동형임을 진술합니다.
이는 타디치(M. Tadić, `1986`, Ann. Sci. ENS 19)의 분류 정리 원형과 완전히 일치하는 **유형 I 명제**이며, `Development/WeilBound/CoreStatements/AutomorphicKernels/UnitaryDualGL/GenericUnitaryDual/GenericUnitaryDualGLHolds.lean:53-107`에서 지수 판독 귀납법으로 증명됩니다.

---

## 제4장. 지겔-베유 공식, 아이젠슈타인 제2항, 정규화 세타 리프트 및 미라볼릭 명세 원문 감사

### 4.1 베유 절대수렴 영역과 쿠들라-랄리스-이치노 연속 영역 지겔-베유 공식 및 아이젠슈타인 명세 해부

유니터리 이중쌍 $(U(A), U(B))$ 위에서 세타 적분의 상수항·평균값을 지겔 아이젠슈타인 급수의 특수값과 일치시키는 지겔-베유 공식은 아카이브 내부에서 랭크 부등식 영역에 따라 두 개의 서로 다른 `Prop`으로 정밀 분리되어 있습니다.
먼저 베유 표현 자체의 유니터리 쌍 당김 명세인 `Development/AbelianVarietyTheory/PublishedTheorems/AutomorphicForms₂/WeilRepresentationUnitaryPair.lean:12-16`(`in_degree = 780`)은 마스터 데이텀 `D : D7`, 표준 가법 지표 $\psi : \mathbb{A}_F / F \to \mathbb{C}^\times$, 에르미트 공간 쌍 $S, T \in \mathrm{HSp}(D)$,
그리고 $\mathbb{A}_F^\times$로의 제한이 각각 $\eta_{E/F}^{\mathrm{rk}(S)}, \eta_{E/F}^{\mathrm{rk}(T)}$와 일치하는(`ResEta`) 두 원분값 헤케 지표 $\chi_S, \chi_T : \mathbb{A}_E^\times / E^\times \to S^1$에 관하여 쿠들라(`1994`) 분해 사상이 결합된 아델 베유 작용소 준동형 $\omega : U(S)(\mathbb{A}_F) \times U(T)(\mathbb{A}_F) \to \mathrm{End}_{\mathbb{C}}(\mathcal{S}(W_{S,T}(\mathbb{A}_F)))$
(`IsWeilDatumO ψ S T χS χT ω`)의 존재를 선언합니다.

이 베유 표현 위에서 배가 공간(doubled Hermitian space) $S = A \oplus (-A)$ (`dblSp A`, 부호수 $(r_A, r_A)$ 분할 에르미트 공간)와 표적 공간 $B$를 짝지을 때, 고전 이론의 지겔-베유 수렴 임계점은 $r_B$와 $2 r_A$의 대소 및 $B$의 비등방성(Witt 지수 $\mathrm{ind}_{\mathrm{Witt}}(B)$)에 의해 결정됩니다.
원문 `Development/AbelianVarietyTheory/PublishedTheorems/TwistedTraceFormula/WeilSiegelFormulaUnitary.lean:56-70`과 `Development/AbelianVarietyTheory/PublishedTheorems/SiegelWeil₂/SiegelWeilUnitaryConvergent.lean:18-33`을 나란히 열면 이 두 영역의 구분이 수식 그대로 드러납니다.

```lean
-- Development/AbelianVarietyTheory/PublishedTheorems/TwistedTraceFormula/WeilSiegelFormulaUnitary.lean:56-70
def WeilSiegelFormulaUnitary : Prop :=
  ∀ (D : D7) (A B : HSp D) (m : Measure (GA D B)), m.IsHaarMeasure → 1 ≤ A.rank →
    (Formalism.MainNotions.SchurIrreducible.wittIdx B = 0 ∨ A.rank + Formalism.MainNotions.SchurIrreducible.wittIdx B < B.rank) →
    (∀ (d : ℕ) (ε : Module.Basis (Fin d) D.host.F D.host.E),
      ∃ ν : Seminorm ℂ (WeilM.schA D.host.F (Fin B.rank × Fin A.rank × Fin d)), IsContSeminorm ν ∧
        ∀ φ : WeilM.schA D.host.F (Fin B.rank × Fin A.rank × Fin d),
          absThetaInt B m (φ.1 ∘ coord ε) ≤ ENNReal.ofReal (ν φ)) ∧
    ∀ (ψ : AddChar (AF D.host.F) ℂ) (χ : (AE D)ˣ →* Circle)
      (ω : GA D (dblSp A) × GA D B →* Module.End ℂ (WO (dblSp A) B → ℂ)),
      IsWeilDatumO ψ (dblSp A) B 1 χ ω → ∀ f, IsThetaFunO ψ (dblSp A) B f →
      (∀ g, Integrable (descend (GQ B) fun h => thetaKO ω g h f) (autMeasure B m)) ∧
      (2 * A.rank < B.rank → ∀ ν 𝓖, IsCovolOne (ratL B A) ν 𝓖 →
        LeftInv (siegelQ A) (swSection A B ν 𝓖 ω f) ∧ ∀ g, CosetConv (siegel A) (GQ (dblSp A)) (swSection A B ν 𝓖 ω f) g ∧
          cosetSum (siegel A) (GQ (dblSp A)) (swSection A B ν 𝓖 ω f) g =
            ⨍ q, descend (GQ B) (fun h => thetaKO ω g h f) q ∂autMeasure B m)

-- Development/AbelianVarietyTheory/PublishedTheorems/SiegelWeil₂/SiegelWeilUnitaryConvergent.lean:18-33
def SiegelWeilUnitaryConvergent : Prop :=
  ∀ (D : D7) (ψ : AddChar (AF D.host.F) ℂ) (A B : HSp D), A.rank < B.rank → B.rank ≤ 2 * A.rank →
    A.rank + Formalism.MainNotions.SchurIrreducible.wittIdx B < B.rank →
  ∀ (χB : (AE D)ˣ →* Circle) (ω : GA D (dblSp A) × GA D B →* Module.End ℂ (WO (dblSp A) B → ℂ)),
    IsWeilDatumO ψ (dblSp A) B 1 χB ω →
  ∀ a : GL (Fin A.rank) (AE D), IsMaj A a → HasIwasawa D.sp.cm.sig (dblSp A).gram (Khat A a) →
  ∀ (θ : InfFam D) (sS : RealMat (dblSp A)) (sB : RealMat B), IsInfFam θ →
    (∀ τ, IsCartanInv (gramAt D (dblSp A) τ) (sS τ)) → (∀ τ, IsCartanInv (gramAt D B τ) (sB τ)) →
    (∀ k ∈ Khat A a, ∀ τ, compAt θ τ (Formalism.L2.Theta.mt (dblSp A) k) * sS τ =
      sS τ * compAt θ τ (Formalism.L2.Theta.mt (dblSp A) k)) →
  ∀ (μ : Measure (WO A B)) (𝓨 : Set (WO A B)), IsCovolOne (ratL B A) μ 𝓨 →
  ∀ ν : Measure (GA D B), ν.IsHaarMeasure →
  ∀ f : WO (dblSp A) B → ℂ, IsFockVec ψ θ (dblSp A) B sS sB f →
    (∀ g, Integrable (AutomorphicL2Unitary.descend (GQ B) fun h => thetaKO ω g h f) (autMeasure B ν)) ∧
    Eis.EisValueAt A (flat A a (swSec A B ω μ 𝓨 f) (sZero A B)) (sZero A B) (thetaMean ω ν f)
```

두 명세의 수리적 역할 분담은 다음과 같습니다.

1. **베유 절대수렴 영역 (`WeilSiegelFormulaUnitary`, $r_B > 2 r_A$)**: 베유 수렴 기준 $\mathrm{ind}_{\mathrm{Witt}}(B) = 0$ 또는 $r_A + \mathrm{ind}_{\mathrm{Witt}}(B) < r_B$ 하에서 세타 커널 $\Theta_\omega(g, h; f)$는 $[U(B)] = U(B)(F)\backslash U(B)(\mathbb{A}_F)$ 위에서 절대적분 가능하며 연속 슈바르츠 반노름 $\nu(\varphi)$로 지배됩니다(`L59-62`).
특히 엄격한 수렴 영역 $r_B > 2 r_A$에서는 지겔 포물선 부분군 $P_{\mathrm{Sieg}}(F)\backslash U(A \oplus -A)(F)$ 위 잉여류 급수가 절대수렴(`CosetConv`)하여 정규화 평균 세타 적분과 점별로 일치합니다(Weil `1965`).

$$
\sum_{\gamma \in P_{\mathrm{Sieg}}(F)\backslash U(A \oplus (-A))(F)} \Phi_f(\gamma g) = \frac{1}{\mathrm{vol}\bigl([U(B)]_\nu\bigr)} \int_{[U(B)]} \Theta_\omega(g, h; f)\, d\nu(h) \qquad (r_B > 2 r_A)
$$

2. **이치노 반수렴·해석적 연속 영역 (`SiegelWeilUnitaryConvergent`, $r_A < r_B \le 2 r_A$)**: 이 구간에서는 지겔 아이젠슈타인 급수 $E(g, s; \Phi_f)$가 평가점 $s_0 = \frac{r_B - r_A}{2}$ (`sZero A B`)에서 절대수렴하지 않습니다. 그러나 세타 적분 쪽은 여전히 베유 수렴 부등식 $r_A + \mathrm{ind}_{\mathrm{Witt}}(B) < r_B$를 만족하므로 절대수렴합니다.
원문은 카르탕 대합(`IsCartanInv`)에 맞춘 아르키메데스 다항 포크 벡터(`IsFockVec`) $f$에서 평탄 단면 `flat A a (swSec ... f) s₀`의 아이젠슈타인 급수가 $s = s_0$에서 정칙 해석적 연속값(`Eis.EisValueAt`)을 가지며 그 값이 정확히 세타 평균 `thetaMean ω ν f`와 일치함을 진술합니다.
이는 쿠들라-랄리스(`1994`) 정칙화 지겔-베유 공식의 제1항 영역을 넘어 이치노(`2001`, `2004`, *A regularized Siegel-Weil formula for unitary groups*, Math. Z. 247)가 확립한 반수렴 영역 지겔-베유 정리의 `D7` 투영(**유형 II-A**)입니다.

아울러 포렌식 관점에서 반드시 짚어야 할 두 가지 명명 불일치 및 리팩터링 현상이 있습니다.

- **`SiegelEisensteinSimplePole`의 비활성 봉합**: `Development/AbelianVarietyTheory/PublishedTheorems/SiegelWeil₂/SiegelEisensteinSimplePoleOfDoublingMethod.lean:14-20`에는 배가 아이젠슈타인 급수가 $s_0 = (b - r_V)/2$ ($b > r_V$)에서 기껏해야 1차 극(`EisPoleLE ... 1`)을 갖는다는 명세가 선언되어 있습니다.
그러나 상위 연속성 정리 `SiegelEisensteinContinuation`과 배가법 제타 적분 `ResidueKilled.DM`(`Development/WeilBound/RepresentationTheoryGL/EisensteinResidues/AnisotropicGlobalForms/DmOfHyp.lean:13-35`)이 이미 $s_0$에서의 정칙성·유수 제어를 내부 흡수했기 때문에,
`Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/EveryCharacterOfLiteratureOfVWin.lean:505-506`에서는 해당 슬롯이 `UnusedSlot72 := trivial`로 봉합되었습니다.
- **`SiegelEisensteinSecondTermHypotheses.lean`의 실제 정체**: `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/SiegelEisensteinSecondTermHypotheses.lean:44-73`(`76`줄)은 파일 이름만 보면 쿠들라-랄리스 아이젠슈타인 로랑 전개 제2항(second-term identity) 가설을 담고 있을 것처럼 보입니다.
그러나 원문 전체를 열람한 결과, 이 파일은 `Development/AutomorphicArithmetic/ThetaCorrespondence/FockModels/EveryCharacterE.lean:41-72`의 구형 조립기 `hypsE₂` / `everyE₂`를 제3자리 `RecTExists` 체계로 이식한 **최상위 확정 측 가설 비공집합성 및 `EveryCharacter` 도출 조립기**(`nonempty_hyps_definite_side_of_closed_bound` 및 `every_character_of_theta_integrals_local_matching`)임이 확인되었습니다.
즉 파일명은 과거 아이젠슈타인 제2항 경계 추적을 시도하던 시기의 디렉터리 유산이며, 실제 실행 코드에서는 제1항 수렴·반수렴 지겔-베유 공식(`SiegelWeilUnitaryConvergent` 및 `SiegelWeilStd`)만으로 시소 내적과 비소멸 격자(`GridA (max CF0 CF1)`)가 닫힙니다.

---

### 4.2 시소 항등식과 랄리스 내적 공식(`RallisDM`) 및 `TheoremKOfMod` 국소 매칭 감사

첨점 형식 $f_1, f_2 \in \mathcal{A}_0(U(A))$의 세타 리프트 $\Theta_{\Phi_i}(f_i)(h) = \int_{[U(A)]} \Theta_\omega(g, h; \Phi_i) \overline{f_i(g)}\, dm(g)$가 비자명($\neq 0$)임을 증명하는 핵심 도구가 랄리스 내적 공식입니다.
원문 명세 `Development/AbelianVarietyTheory/PublishedTheorems/TwistedTraceFormula/LowerLiftsZeroOfWittIdxEqZero.lean:41-60`과 그 증명 파일 `Development/AutomorphicArithmetic/ThetaCorrespondence/FockModels/RallisDM.lean:24-111`을 대조하면 시소(seesaw) 쌍대성의 전 과정이 한 줄의 생략도 없이 복원됩니다.

1. **첫 출현(First Occurrence) 수렴 조건 (`Development/AbelianVarietyTheory/PublishedTheorems/TwistedTraceFormula/LowerLiftsZeroOfWittIdxEqZero.lean:42-53`)**: $r_A < r_B \le 2 r_A$이면서 $B$가 비등방($\mathrm{ind}_{\mathrm{Witt}}(B) = 0$)이거나 $r_A + \mathrm{ind}_{\mathrm{Witt}}(B) < r_B$이고, $B$의 비트 타워 아래 단계로의 세타 리프트가 모두 `0`으로 소멸(`LowerLiftsZero`)한다고 가정합니다.
이 조건 아래에서 세타 리프트 $\Theta_{\Phi_i}(f_i)$는 $[U(B)]$ 위에서 절대수렴하고 $L^2_{\mathrm{cusp}}([U(B)])$에 속합니다(`L56-57`).
2. **유니터리 시소 푸비니 교환과 중심 지표 보정 (`Development/AutomorphicArithmetic/ThetaCorrespondence/FockModels/RallisDM.lean:72-108`)**: 배가 공간 포함 사상 $\iota_A : U(A) \times U(-A) \hookrightarrow U(A \oplus (-A))$에 관한 베유 표현 분해 조항 `ThetaClause`(`hid`, `L77-83`)은

$$
\Theta_\omega(g_1, h; \Phi_1) \, \overline{\Theta_\omega(g_2, h; \Phi_2)} = \chi_B(\det g_2) \, \Theta_{\omega_d}\bigl(\iota_A(g_1, g_2), h; \delta(\Phi_1, \Phi_2)\bigr)
$$

를 부여합니다. 급감소 첨점 형식 $\overline{f_1}, \overline{f_2}$와 완만 증가 세타 커널에 시소 푸비니 정리(`seesaw_fubini`, `L72-75`)를 적용하여 $[U(A)] \times [U(A)] \times [U(B)]$ 위 적분 순서를 바꾸면 다음 항등식이 도출됩니다(`hval`, `L99-108`).

$$
\frac{1}{\mathrm{vol}([U(B)]_{m_H})} \bigl\langle \Theta_{\Phi_1}(f_1),\, \Theta_{\Phi_2}(f_2) \bigr\rangle_{L^2([U(B)])} = \iint_{[U(A)] \times [U(A)]} \overline{f_1(g_1)}\, f_2(g_2)\, \chi_B(\det g_2)\, \mathcal{M}_{\omega_d}\bigl(\delta(\Phi_1, \Phi_2)\bigr)\bigl(\iota_A(g_1, g_2)\bigr)\, dm(g_1)\, dm(g_2)
$$

여기서 $\mathcal{M}_{\omega_d}$는 $[U(B)]$ 위 평균 세타 적분 `thetaMean`입니다. 마지막으로 `L52-55`와 `L109-110`에서 앞서 검토한 `SiegelWeilUnitaryConvergent`로 $\mathcal{M}_{\omega_d}(\delta(\Phi_1, \Phi_2))$를 퇴화 아이젠슈타인 급수 $E(\iota_A(g_1, g_2), s_0; \Phi_{\delta})$로 치환하고,
피아테츠키-샤피로-랄리스 배가 제타 적분 정리(`ResidueKilled.DM`)의 정칙 평가 정리 `zetaHolValueAt_of_eisValueAt`를 대입하여 우변이 정확히 중앙 근처 표준 $L$-값에 비례하는 배가 제타 특수값 `ZetaValueAt A χB⁻¹ m ... s₀`와 같음을 완결합니다(Rallis `1984`, Li `1992`, Gan-Qiu-Takeda `2014`, **유형 II-A**).

이와 짝을 이루는 `Development/WeilBound/ThetaLifts/Reductions/FiniteClosure/TheoremKOfMod.lean:14-28`(`29`줄)은 배가 경계 아이젠슈타인 성질 `EisBL`(`Development/WeilBound/RepresentationTheoryGL/EisensteinSeries/SiegelEisensteinHalfPlane/SchwartzBruhatMajorants/SiegelMultOf.lean:101-114`)과 표준 가우스 단면 지겔-베유 정규화
`SiegelWeilStd`(`Development/WeilBound/CoreStatements/AutomorphicKernels/SiegelWeilFormula/SiegelWeilStandard/SiegelWeilStd.lean:8-9`), 그리고 분기·비분기 자리 구형 하우 쌍대성(`howeInert`,
`ramifiedMultiplicityOne`)을 결합하여 부정부호 행과 정부호 행 사이의 세타 적분 일치 및 국소 인자 매칭 `ThetaIntegralsAgree ∧ LocalMatching`을 도출합니다(`Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/EveryCharacterOfLiteratureOfVWin.lean:565-566`에 직접 주입됨).

---

### 4.3 지겔 질량·산술 공집합 부피(`TopCovolSlim2Use`) 및 열 켤레 측도·미라볼릭 명세 감사

정부호 유니터리 군과 부정정 시무라 다양체 사이의 격자 부피·높이 성장을 통제하는 차울라-셀베르그·지겔 질량 축은 두 갈래로 구현되어 있습니다.
에르미트 격자 종 질량 공식 자체는 `Development/AbelianVarietyTheory/Proofs/GlobalInterpolation/GenusMassAtTwo.lean:7-8`에서 모든 `D : D7`에 관해 `GenusMassAt D 2`로 증명되어 하위 `Development/AutomorphicArithmetic/CharacterBoxes/RiemannHypothesisOfEveryCharacter.lean:88`로 공급되며,
토로이달 콤팩트화 호지 다발의 아라켈로프 자기교차 부피 상한은 `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/HodgeBundleWeights/TopCovolSlim2Use.lean:16-22` 및 리팩터링 쌍둥이 `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/TopCovolSlim2Use.lean:16-22`에서 조립됩니다.

원문 `topCovolSlim2_use_alt_alt`는 `15`개의 대수기하·산술교차 입력(`ResolutionCharZero`, `PrincipalisationCharZero`, `PoincareLelongInv`, 산술 힐베르트-사무엘 `hsUse_outright`, 모리와키 거대성 `moriwakiBig_outright`, 파르그 완전열 `FarguesExact`, 자르힌 트릭 `ZarhinStatement`, 점근 리만-로흐 `NefRR`, 지겔·팬 토로이달 콤팩트화 `SiegelToroidalIntegral`·`ToroidalForFanKS`, 준아벨 리 준음수성 `SemiAbelianLieSeminegative`,
두 점 분리 `PointSeparationPair`, 아라켈로프 차수 `ArDegree`, `28`필드 호지 번들 레코드 `PublishedHodgeBundleTheorems`, 그로텐디크 변형 `GrothendieckDeformation`)을 받아 푸비니-스투디 차우 높이 공식(`fubiniStudy_chowHeight_formula`)과 소단면 단사성(`small_sections_injective`)을 거쳐 최종 공집합 부피 상한 `CovolumeBoundOfX`를 생성합니다.

한편 $\mathrm{GL}_k$ 측에서 푸리에-휘태커 전개와 스펙트럼 분해를 떠받치는 세 핵심 모듈의 원문 감사 결과는 다음과 같습니다.

1. **`ColumnConjugationMeasure.lean` (`in_degree = 64`, `407`줄)**: `Development/WeilBound/CoreStatements/PublishedTheorems/JacquetShalikaRigidity/ColumnConjugationMeasure.lean:32-140`은 `Development.WeilBound.CoreStatements` 전체 최다 피참조 허브입니다.
완전히 복소인 수체 $E$의 아델 일반선형군 $\mathrm{GL}_k(\mathbb{A}_E)$ (`GA E k`) 위에서 이델 노름 행렬식 `Dt : GA E k → ℝ`(`D0`, `L32-40`: 유리 원소·단멱원소·콤팩트 정수 원소에서 `Dt = 1`, 중심 이동에서 $\exp(k[E:\mathbb{Q}]t)$)을 정의하고, 열 단멱 블록 `blkU x`의 켤레 변환 야코비안 등식(`L46-48`)

$$
\int_{(\mathbb{A}_E)^{j}} F\bigl(g \cdot u_{\mathrm{col}}(x) \cdot g^{-1}\bigr)\, dx = \mathrm{Dt}(g)^{-1} \int_{(\mathbb{A}_E)^{j}} F\bigl(u_{\mathrm{col}}(x)\bigr)\, dx
$$

및 미라볼릭 부분군 단계별 푸리에 계수 사상 `colT ψ m f`의 $L^2$-플랑슈렐 등거리 항등식(`U1`, `U2`, `L126-136`: $\langle f, \varphi \rangle_{\beta} = \langle \mathcal{W}_\psi f, \mathcal{W}_\psi \varphi \rangle_{\beta'}$)을 **유형 I** 형태로 완비합니다.
2. **`CuspSp.lean` (`86`줄)**: `Development/WeilBound/CoreStatements/RegularisedThetaMirabolic/KFiniteCuspForms/CuspSp.lean:47-86`은 $\mathrm{GL}_a(\mathbb{A}_E)$의 닫힌 기약 첨점 $L^2$-부분표현 $\mathcal{H} \subset L^2_{\mathrm{cusp}}([\mathrm{GL}_a])$ 안의 모든 $K$-유한 벡터를 매끄러운 첨점 형식 `Sm E a` 대표원으로 승강(`exists_cusp_form_of_K_finite`,
`L30-40`)하여 대수적 기약 첨점 가군 `π : CuspSub E a`를 구성하고, 이산 분해·$K$-유한 조밀성·첨점 유계성 3종 묶음 `CuspidalSpectrumGL` (`L85-86`, **유형 I**)을 증명합니다.
3. **`Mirabolic.lean` (`366`줄)과 유한체 `CuspidalMirabolic`의 포렌식 실체**: `GroundTheory/HeightsAndTheta/Theta/FiniteGL/Mirabolic.lean:15-359`는 임의의 체 $F$ 위에서 상삼각 단멱군 $U_n(F)$ (`upperUnipotent`), 마지막 행이 $(0, \dots, 0, 1)$인 미라볼릭 부분군 $P_n(F)$ (`mirabolic`, `L61-85`), 초대각선 합 비퇴화 지표 $\psi_0(\sum_{i} u_{i,i+1})$ (`genericChar`, `L103-150`),
미라볼릭 공유도 표현 `mirabolicInduced`(`L163-165`), 진부분 깃발 근기 불변량 소멸로서의 첨점성 `IsCuspidal`(`L234-236`), 그리고 단멱 지지 델타 벡터 `mirabolicDelta`(`L323-359`)를 구성합니다.
여기서 주목할 점은 `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/EveryCharacterOfLiteratureOfVWin.lean:343-344`의 기출 정리 `cuspidal_mirabolic_of_literature : CuspidalMirabolic`의 원문 정의(`Development/AbelianVarietyTheory/PublishedTheorems/PublishedFoundations/BlockTriangularOfSubOne.lean:215-226`)를 실제로 열어보면,
기저체 타입이 비아르키메데스 국소체가 아니라 **`[Field k] [Fintype k]`(유한체 $\mathbb{F}_q$)**로 지정되어 있다는 사실입니다.

$$
\mathrm{CuspidalMirabolic} \iff \forall \mathbb{F}_q,\; \forall n \in \mathbb{N},\quad \Bigl(\exists \rho \in \mathrm{Irr}_{\mathrm{cusp}}(\mathrm{GL}_{n+1}(\mathbb{F}_q))\Bigr) \;\land\; \Bigl(\forall \psi_0 \neq 1,\; \forall \rho \in \mathrm{Irr}_{\mathrm{cusp}}(\mathrm{GL}_{n+1}(\mathbb{F}_q)),\; \rho\rvert_{P_{n+1}(\mathbb{F}_q)} \simeq \mathrm{Ind}_{U_{n+1}(\mathbb{F}_q)}^{P_{n+1}(\mathbb{F}_q)} \psi_0\Bigr)
$$

즉 명칭만 보고 $p$-진 번스타인-젤레빈스키(`1976`) 키릴로프 모형으로 오인하기 쉬우나, 실제 코드는 겔판트(S. I. Gelfand, `1970`)의 **유한 일반선형군 첨점 표현의 미라볼릭 제한 유일 기약성 정리**(**유형 I**, 유한체 정식화)이며, 모이-프라사드 깊이 `0` 초첨점 유도와 결합되어 비분기·깊이 `0` 휘태커 비소멸을 공급합니다.

| 감사 대상 명세 식별자 | 원문 위치 (`src/` 기준) | 피참조 | 대응 고전 원전 | 동치성 분류 및 감사 판정 요지 |
| :--- | :--- | ---: | :--- | :--- |
| `WeilRepresentationUnitaryPair` | `Development/AbelianVarietyTheory/PublishedTheorems/AutomorphicForms₂/WeilRepresentationUnitaryPair.lean:12-16` | `780` | Kudla (1994), HKS (1996) | **유형 II-A**: `D7` 에르미트 쌍 $(S,T)$ 및 반정수 헤케 지표 $(\chi_S,\chi_T)$ 위 베유 표현 존재성 |
| `WeilSiegelFormulaUnitary` | `Development/AbelianVarietyTheory/PublishedTheorems/TwistedTraceFormula/WeilSiegelFormulaUnitary.lean:56-70` | `14` | Weil (1965), Kudla-Rallis (1988) | **유형 II-A**: 절대수렴 영역 $r_B > 2r_A$에서의 지겔 잉여류 합과 세타 평균 일치 공식 |
| `SiegelWeilUnitaryConvergent` | `Development/AbelianVarietyTheory/PublishedTheorems/SiegelWeil₂/SiegelWeilUnitaryConvergent.lean:18-33` | `35` | Kudla-Rallis (1994), Ichino (2001, 2004) | **유형 II-A**: 반수렴 영역 $r_A < r_B \le 2r_A$, $r_A + \mathrm{ind}_{\mathrm{Witt}}(B) < r_B$에서 아이젠슈타인 연속값 일치 |
| `RallisInnerProductConvergent` | `Development/AbelianVarietyTheory/PublishedTheorems/TwistedTraceFormula/LowerLiftsZeroOfWittIdxEqZero.lean:41-60` | `12` | Rallis (1984), Li (1992), GQT (2014) | **유형 II-A**: 첫 출현 비트 타워 조건 하 세타 리프트 페터슨 내적과 배가 제타 특수값 일치 |
| `ColumnConjugationMeasure` | `Development/WeilBound/CoreStatements/PublishedTheorems/JacquetShalikaRigidity/ColumnConjugationMeasure.lean:46-49` | `64` | Jacquet-Shalika (1981), Godement-Jacquet | **유형 I**: $\mathrm{GL}_k(\mathbb{A}_E)$ 단멱 열 켤레 야코비안 $\mathrm{Dt}(g)^{-1}$ 및 푸리에-휘태커 등거리성 |
| `CuspidalMirabolic` | `Development/AbelianVarietyTheory/PublishedTheorems/PublishedFoundations/BlockTriangularOfSubOne.lean:215-226` | `6` | S. I. Gelfand (1970), Green (1955) | **유형 I (유한체)**: 유한체 $\mathrm{GL}_{n+1}(\mathbb{F}_q)$ 첨점 표현 존재성 및 미라볼릭 키릴로프 유도 동형 |

---

### 4.4 배가법 제타 적분(`DmOfHyp`), 비분기 구형 오일러 인자 및 `max CF0 CF1` 격자 결합 감사

제4.2절의 랄리스 내적 공식과 제1.1절의 최상위 조립기를 실질적으로 작동시키는 해석적 동력은 피아테츠키-샤피로-랄리스(`1987`) 배가법(Doubling Method) 제타 적분의 해석적 연속과 비분기 구형 계산입니다.

첫째, `Development/WeilBound/RepresentationTheoryGL/EisensteinResidues/AnisotropicGlobalForms/DmOfHyp.lean:13-35`에 선언된 `ResidueKilled.DM` (`DoublingMethodLocalZetaIntegrals`의 실체)은 에르미트 공간 $V$ ($\mathrm{rk}(V) > 0$)와 퇴화 주계열 단면 $\varphi \in \mathrm{degPS}(V, a, \mu, s_1)$에 관하여 ① 평탄화 단면 지겔 아이젠슈타인 급수의 유리형 연속성 및 임의 점 $s_0$에서의 유한 극
차수(`EisContinues ∧ ∀ s₀, ∃ k, EisRegularAt ... k`), ② 우반평면 $\mathrm{Re}(s) > \frac{1}{2}\mathrm{rk}(V)$에서 두 첨점 형식 $f_1, f_2 \in \mathcal{A}_0(U(V))$에 관한 배가 적분 전개 기본 항등식(`BasicIdentity V μ m (flat V a φ s₁ s) f₁ f₂`, `L21`), ③ 배가 제타 적분 자체의 전 평면 유리형 연속성(`ZetaContinues`, `L22`)을 묶어 진술합니다(**유형 II-A**).
특히 `dm_of_two` (`L24-35`)는 `CuspRapidDecay`와 `SiegelEisensteinContinuation` 두 정리만으로 첨점 급감소에 의한 적분-연속성 교환(`zetaContinues_of_eisRegularAt`)을 수행하여 `DM`을 증명합니다.

둘째, 각 비분기 유한 자리에서 위 `BasicIdentity`의 국소 제타 적분을 표준 오일러 $L$-인자로 계산하는 정리가 `Development/AbelianVarietyTheory/Proofs/DecoratedLatticeProofs/IsCommensuratedKO.lean:125-162`의 `unramifiedDoublingGL`입니다.
원문 증명은 비아르키메데스 국소체 $k$ (잉여체 기수 $q_k = \mathrm{resCard}(k) > 1$, 균일화원 $\varpi$) 위에서 극대 콤팩트 부분군 $K_0 = \mathrm{GL}_n(\mathcal{O}_k)$ (`KO k (Fin n)`)의 통약성(`isCommensurated_KO`)과 이중 잉여류 길이 함수 `cellLen` 위 구형 급수 합산(`hasSum_sphericalFunction_doublingLength`, `L138-140`)을 수행하여,
충분히 큰 $\mathrm{Re}(s)$ 영역 $\lvert q_k^{-(n/2 + s)} \rvert < \delta$에서 구형 행렬계수 $\omega(g)$와 구형 배가 단면 $\Phi_s(\iota(g, 1))$의 국소 적분이 비분기 사타케 매개변수 $\alpha_1, \dots, \alpha_n \in \mathbb{C}^\times$에 대응하는 국소 $L$-인자

$$
\int_{\mathrm{GL}_n(k)} \Phi_s\bigl(\iota(g, 1)\bigr)\, \omega(g)\, d\mu(g) = \prod_{i=1}^{n} \bigl(1 - \alpha_i^{-1} q_k^{-(s + 1/2)}\bigr)^{-1} \cdot \bigl(\text{정규화 인자}^{-1}\bigr)
$$

(`prod_one_sub_eq_invNormFactor`, `L104-122`, `L150-161`)와 일치함을 아카이브 배가군 구조체(`Formalism.UG`, `KO k (Fin n)`) 위의 **유형 II-A** 정리로 직접 계산합니다.

셋째, 이 모든 세타·배가법·아라켈로프 기출 증인들이 `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/SiegelEisensteinSecondTermHypotheses.lean:44-68`의 `nonempty_hyps_definite_side_of_closed_bound` 내부에서 결합되는 방식을 보면 아카이브의 전역 상수 설계가 명료해집니다.

1. `L52-54`에서 실수 하우 쌍대성(`howeDualityReal`), 비분기 하우 분리성(`howeUnram_holds`), 수렴 지겔-베유(`siegelWeilUnitaryConvergent`), 지겔 기본영역 세타 수렴(`twisted_weil_representation_convergence`)을 결합한 `evaluation_grid_of_join`이 세타 적분 격자 임계 상수 `CF1`을 산출합니다.
2. `L55-56`에서 피복군 이산계열(`discreteSeriesCover`), 하리시-찬드라 가군(`harishChandraModules`), 첨점 급감소(`cuspRapidDecay`), 카셀만-왈라흐(`casselmanWallach`), 광선 유체(`rayClassFieldSt`)를 결합한 `rowFun_at_gridA_alt`가 아르키메데스 함수해석 임계 상수 `CF0`을 산출합니다.
3. `L57-68`에서 두 임계 상수의 최댓값 $C_{\max} := \max(\mathrm{CF}_0, \mathrm{CF}_1)$을 취해 공통 평가 격자 `GridA (max CF0 CF1)`을 고정하고, 여기에 제4.3절의 아라켈로프 공집합 부피 상한 `hX : CovolumeBoundOfX`와 제3.2절의 `hL : RecTExists`를 `linked_bundles_l3_of_open_alt`(`L65-67`)에 투입함으로써 최종 확정 측 비공집합 가설 `Nonempty (HypsAlt S0.NL DefiniteSideCondition)`을 비구성적 선택 없이 닫습니다.

---

## 제5장. 대수기하(GAGA·히로나카·드마이·아벨 다양체) 및 $p$-진 호지·유체론 명세 원문 감사

### 5.1 세르 GAGA 단면 전단사, 히로나카 주이데알화 및 드마이 로그 정준 $L^2$-확장 감사

시무라·유니터리 모듈라이 다양체의 토로이달 콤팩트화 위에서 해석적 보형 형식을 대수적 선다발 단면으로 바꾸고 아라켈로프 높이를 평가하기 위해 아카이브는 복소·대수기하의 3대 대정리(세르 GAGA, 히로나카 특이점 해소, 오사와-다케고시·드마이 $L^2$-확장)를 내부 증명합니다. 원문을 직접 열면 이 세 명제의 정밀도가 극명하게 대비됩니다.

첫째, `Development.AutomorphicSpectrum.PublishedTheorems` 최다 피참조 허브(`in_degree = 153`)인 `Development/AutomorphicSpectrum/PublishedTheorems/Geometry₂/GagaSections.lean:10-18`과 `Development/AbelianVarietyTheory/PublishedTheorems/Divisors₂/SerreHolomorphicSections.lean:15-20`을 열면 세르(`1956`,
*Géométrie algébrique et géométrie analytique*) 정리의 **선다발 `0`차 전역 단면(`LB.Sec`) 버전**이 수록되어 있습니다.

```lean
-- Development/AutomorphicSpectrum/PublishedTheorems/Geometry₂/GagaSections.lean:10-18
def GagaSections : Prop :=
  ∀ (X : Scheme.{0}) (s : X ⟶ Sp ℂ), IsProper s → Smooth s → ∀ (L : LB X), L.IsLB →
    ∀ h : L.ι → (Sp ℂ ⟶ X) → ℂ,
      (∀ (i : L.ι) (m : ℕ) (B : Set (Fin m → ℂ)) (y : (Fin m → ℂ) → (Sp ℂ ⟶ X)), IsOpen B → IsHolTo B y →
        (∀ b ∈ B, y b ≫ s = 𝟙 _ ∧ ⊤ ≤ y b ⁻¹ᵁ L.U i) → DifferentiableOn ℂ (fun b => h i (y b)) B) →
      (∀ (i j : L.ι) (x : Sp ℂ ⟶ X), x ≫ s = 𝟙 _ → ⊤ ≤ x ⁻¹ᵁ (L.U i ⊓ L.U j) →
        h i x = valAt' x (L.U i ⊓ L.U j) (L.g i j).val * h j x) →
      ∃ σ : L.Sec, ∀ (i : L.ι) (x : Sp ℂ ⟶ X), x ≫ s = 𝟙 _ → ⊤ ≤ x ⁻¹ᵁ L.U i → valAt' x (L.U i) (σ.f i) = h i x
```

즉 복소수체 위 고유(`IsProper`, 또는 `SerreHolomorphicSections`에서는 사영 `IsProjOver`)하고 매끄러운 스킴 $X / \mathrm{Spec}\,\mathbb{C}$ 위에서 체흐 열린 피복 $\{U_i\}_{i \in \iota}$와 전이함수 $g_{ij} \in \mathcal{O}_X^\times(U_i \cap U_j)$로 주어진 선다발 $L$에 관하여,
임의의 정칙 복소 사상 $y : B \subset \mathbb{C}^m \to X(\mathbb{C})$와의 합성이 복소 미분가능(`DifferentiableOn ℂ`)하고 전이 법칙 $h_i(x) = g_{ij}(x) h_j(x)$를 만족하는 해석적 단면 족 $\{h_i\}$는 유일한 대수적 정칙 단면 $\sigma \in H^0_{\mathrm{alg}}(X, L)$ (`L.Sec`)에서 온다는 명제입니다.
연접층 전체의 아벨 범주 동치나 고차 코호몰로지 $H^q(X^{\mathrm{an}}, \mathcal{F}^{\mathrm{an}}) \cong H^q(X, \mathcal{F})$ ($q \ge 1$)를 요구하지 않고 오직 선다발의 $H^0$ 대수화만 추출한 **유형 II-B 부분 특화**이며, 덕분에 `Development/AbelianVarietyTheory/Proofs/DivisorProofs/SerreHolomorphicSectionsHolds.lean:14-52`에서 아핀 경계 다항 성장 추정(`continuous_section_polynomial_growth`)과 층 접합만으로 간결하게 증명됩니다.

둘째, 피참조 `937`회인 `Development/AbelianVarietyTheory/PublishedTheorems/Divisors₂/GeometricallyConnectedOfIsIsoRestrict.lean:118-126`의 히로나카 주이데알화 명세 `Principalisation`은 표수 `0` 체 $k$ 위 차원 $d$의 매끄럽고 사영적인 적분 스킴 $Y / \mathrm{Spec}\,k$와 영이 아닌 이데알 층 $I \neq \perp$에 관하여,
지지집합 $\mathrm{Supp}(I)$ 내부의 매끄러운 닫힌 중심들을 따라 유한 번 폭발시킨 사상 $s : Y' \to Y$ (`IsSmoothBlowupSeq f I.support s`)가 존재하여 ① $\mathrm{Supp}(I)$ 바깥에서 동형사상(`IsIso (s ∣_ I.support.compl)`)이고, ② 당김 이데알 $s^{-1}I \cdot \mathcal{O}_{Y'}$가 유효 카르티에 인자(`EffCartier (I.comap s)`)가 되며, ③ 그 지지집합의 소멸 이데알이 단순 정규 교차(`FinalTheorems.Snc`)를 이룬다고 진술합니다.
이는 히로나카(`1964`) 및 콜라르(`2007`, *Lectures on Resolution of Singularities*, 정리 3.26)의 사영 주이데알화 정리와 완전히 일치하는 **유형 I 명제**입니다.

셋째, `Development/AbelianVarietyTheory/PublishedTheorems/Divisors₂/L2ExtensionLogCanonical.lean:16-55`(`in_degree = 158`)의 `L2ExtensionLogCanonical`은 원문을 열었을 때 가장 정교한 **유형 II-B 특화**가 발견되는 명세입니다. 일반적인 오사와-다케고시(`1987`)나 드마이(`2015`)의 로그 정준 $L^2$-확장 정리는 임의 차원의 로그 정준 중심(log canonical center) 부분다양체로부터의 확장을 다룹니다.
반면 본 아카이브 원문 `L40-55`는 가중 복소 다양체 아틀라스 `A : WeightedAtlas n Y ι La` 위에서 $n$개의 단면 $s_1, \dots, s_n \in H^0(Y, L)$의 공통 영점 집합 $Z(s) = \mathrm{A.zeroSet}(s)$가 **유한 집합(`(A.zeroSet s).Finite`, 즉 `0`차원 고립 점들의 집합)**이고 각 점 $P \in Z(s)$에서 야코비 행렬식 $J_s(P) = \det(ds(P)) \neq 0$ (`jacAt A s P ≠ 0`)인 횡단 교차 상황으로 한정합니다.
그 대신 로그 특이점 가중치 $\psi(y) = n \log \|s(y)\|_L^2 \le 0$와 곡률 양수성 $\mathrm{Levi}(\varphi_E + \alpha \psi) \ge 0$ ($\alpha \in [1, 1+\delta]$) 아래에서, 유한 점집합 위의 임의의 값 $f : Z(s) \to \mathbb{C}$를 보간($F(P) = f(P)$)하는 수반 선다발 $K_Y + E$의 전역 정칙 단면 $F$가 명시적 보편 상수 $34/\delta$를 갖는 예리한 $L^2$ 추정식

$$
\int_Y \frac{2^n}{1 + \bigl(\delta \psi(y)\bigr)^2} \, \| F(y) \|_{K_Y + E}^2 \, e^{-\psi(y)} \, d\mu_A(y) \;\le\; \frac{34}{\delta} \cdot \frac{2^{n+1}\pi^n}{\Gamma(n)} \sum_{P \in Z(s)} \frac{\lvert f(P) \rvert^2}{\lvert J_s(P) \rvert^2} \, e^{-\varphi_E(P) + n \varphi_L(P)}
$$

을 만족함을 진술합니다. 이는 드마이(`2015`, *Extension of holomorphic functions defined on singular subvarieties with nontrivial multiplier ideal sheaves*)의 점 중심 잔류(point-residue) $L^2$-보간 정리로서, 아카이브가 시무라 다양체 위 유한 개 CM·특수 점에서 소단면을 분리(`SmallSectionsInjective`)할 때 딱 이 `0`차원 점 보간과 명시 상수 $34/\delta$만 필요하기 때문에 고안된 맞춤형 정식화입니다.

---

### 5.2 아벨 스킴 주편극 단일 단면, $[n]$-비틀림 기수, 드람·결정 변형 및 준안정 환원 감사

아벨 다양체의 대수적 기초를 이루는 5개 핵심 명세 파일을 원문 대조한 결과는 다음과 같습니다.

1. **주편극 세타 단면 차원 `1` (`Development/AbelianVarietyTheory/PublishedTheorems/AbelianLaws/PrincipalPolarisationOneSection.lean:11-12`)**: 대수적으로 닫힌 체 $K$ 위의 임의의 주편극 아벨 다양체 `P : PolAV (Spec K)`에 관하여 주편극 선다발 $P.L$의 전역 단면 공간 차원이 정확히 `1`임을 선언합니다.

$$
\dim_K H^0(P.A,\, P.L) = 1
$$

멈퍼드(`1970`, *Abelian Varieties*, 제16절 리만-로흐 및 파피안 공식: $\chi(L) = \sqrt{\deg \phi_L} = 1$)의 고전 정리와 일치하는 **유형 I 명제**이며, `Development/AbelianVarietyTheory/Proofs/AbelianSchemeLawProofs/PrincipalPolarisationUniqueSection.lean:7-9`에서 증명됩니다.
2. **$[n]$-비틀림 기수 $n^{2g}$ (`Development/AbelianVarietyTheory/PublishedTheorems/Landherr₂/DimEqZero.lean:10-11`, `Development/AbelianVarietyTheory/Proofs/CoherentCohomologyProofs/AbelianVarietyTorsionCardEqPowProof.lean:18-21`)**: 대수적으로 닫힌 체 $k$ 위 상대 차원 $g$인 아벨 스킴 $B / \mathrm{Spec}\,k$와 체에서 가역인 자연수 $(n : k) \neq 0$에 관하여 $n$-비틀림 유리점 군의 기수를

$$
\# \bigl\{ x \in B(k) \;\big|\; x^n = 1 \bigr\} = n^{2g}
$$

로 정식화합니다(**유형 I**, Mumford `1970`, 제6절). 증명은 세제곱 정리(Theorem of the Cube) 총복합체 비순환성(`CubeTotalComplexAcyclicOfSlicesInductionOnCard`)과 경직성 보조정리(`rigidity_holds`)로부터 도출됩니다.
3. **상대 드람 코호몰로지 및 그로텐디크-메싱 변형 (`Development/AbelianVarietyTheory/PublishedTheorems/Divisors₂/CrysToDRBijective.lean:24-68`, `Development/AbelianVarietyTheory/PublishedTheorems/Divisors₂/ExistsCrystalPairing.lean:25-129`,
`Development/AbelianVarietyTheory/PublishedTheorems/Divisors₂/GrothendieckDeformation.lean:12-16`)**: 피참조 `859`회인 `CrysToDRBijective.lean`은 임의의 가환환 $R$ 위 상대 차원 $g$ 아벨 스킴 $A / \mathrm{Spec}\,R$에 관해 `AbelianDeRham`을 5개 명제의 곱으로 정의합니다: ① `Free`($H^1_{\mathrm{dR}}(A/R)$이 각 소이데알 줄기 랭크 $2g$인 유한 사영 $R$-가군이며 컵곱
$\bigwedge^2 H^1_{\mathrm{dR}} \xrightarrow{\sim} H^2_{\mathrm{dR}}$이 동형), ② `Hodge`(불변 미분 부분가군 $\omega_A \subset H^1_{\mathrm{dR}}$이 랭크 $g$ 직합 인자), ③ `BaseChange`(임의의 $R \to R'$ 기저변환 호환성), ④ `Rigid`(멱영 분할거듭제곱 이데알 $(I, \kappa)$에 관한 결정 승강 전단사 `crysToDR_bijective`), ⑤ `Duality`(주편극 `KTriv` 시 교대 쌍선형 형식 `ψ`의 완전 쌍대성 및 호지 여과 등방성).
그 위에서 `GrothendieckDeformation` (`in_degree = 288`)은 임의의 전사 멱영 분할거듭제곱 두꺼워짐 $(R \twoheadrightarrow R_0, I, \kappa)$에서 아벨 스킴 변형과 호지 여과 승강의 동치성(`GrothendieckMessing.At κ π`, Grothendieck `1970`, Messing `1972`)을 **유형 I**로 진술합니다.
4. **$p$-진 준안정 환원 (`Development/AbelianVarietyTheory/PublishedTheorems/SemistableReduction₂/SemistableReductionSt.lean:15-23`,
`Development/AbelianVarietyTheory/Proofs/DegenerationProofs/SemistableReductionPpavPadicField.lean:19-22`)**: 원문 시그니처는 임의의 데데킨트 정역 대신 **$p$-진수체 $\mathbb{Q}_p$의 유한 확장 $K \subset \overline{\mathbb{Q}}_p$ 위의 주편극 아벨 다양체 `P : Out.PolAV (Sp K)`**를 입력으로 받아,
유한 확장 $K'/K$와 그 정수환 $\mathcal{O}_{K'} = \mathrm{integralClosure}(\mathbb{Z}_p, K')$ 위의 준아벨 군 스킴(`IsSemiAbelian G`)이 존재하여 일반 섬유 $G \times_{\mathcal{O}_{K'}} K' \cong P.A \times_K K'$가 군 스킴 당김 동형을 이룸을 선언합니다. 그로텐디크 SGA 7 I (`1972`) 준안정 환원 정리의 $p$-진 주편극 부분 경우(**유형 II-B**)이며, 멈퍼드-레이노 $p$-진 균일화(`UniformisationConclusion`)를 경유해 증명됩니다.

---

### 5.3 폰텐 $B_{\mathrm{cris}}$, 바트-숄체 $A_{\inf}$ 격자, 숄체-와인스타인 분류 및 프리즘 디외도네 감사

정수 및 유리 $p$-진 호지 이론 명세 `4`종은 현대 산술기하학의 최신 문헌(`1994`~`2023`)과 직결되며, 원문 대조 결과 `3`종은 완전한 **유형 I**, `1`종(`PrismaticDieudonneHodge`)은 정교한 **유형 II-B**임이 밝혀졌습니다.

1. **폰텐 결정 주기환 기본 완전열 (`Development/AbelianVarietyTheory/PublishedTheorems/GaloisCohomology₂/OneSubPhiOntoOfFilZero.lean:15-21`,
`Development/AbelianVarietyTheory/Proofs/InertiaEigenvalues/FontaineBcrisBasicTheoremsProof.lean:15-23`)**: 소수 $\ell$의 주기환 코어 `C : Core l` 위에서 `FontaineBcris`는 7중 논리곱 `TensorInj ∧ PhiInj ∧ IotaInj ∧ Fund ∧ PhiSubOneOntoFilZero C ∧ FundOnto ∧ Regular`로 정의됩니다. 핵심 항인 `Fund`와 `PhiSubOneOntoFilZero`는 폰텐(`1994`)과 콜메즈-폰텐(`2000`)의 기본 완전열

    $$
    0 \longrightarrow \mathbb{Q}_\ell \longrightarrow B_{\mathrm{cris}}^{\varphi = 1} \cap \mathrm{Fil}^0 B_{\mathrm{dR}} \longrightarrow 0, \qquad 0 \longrightarrow \mathbb{Q}_\ell \longrightarrow \mathrm{Fil}^0 B_{\mathrm{cris}} \xrightarrow{\;\varphi - 1\;} B_{\mathrm{cris}} \longrightarrow 0
    $$

    및 $\overline{\mathbb{Q}}_\ell \otimes_{\mathbb{Q}_\ell} B_{\mathrm{cris}} \hookrightarrow B_{\mathrm{dR}}$의 단사성(`TensorInj`), $G_K$-정칙성(`Regular`)을 정확히 표현하는 **유형 I 명제**입니다.
2. **바트-모로우-숄체 정수 $A_{\inf}$ 격자 (`Development/AbelianVarietyTheory/PublishedTheorems/GaloisCohomology₂/BhattScholzeIntegral.lean:12-30`, `in_degree = 506`)**: 유한 확장 $K/\mathbb{Q}_\ell$의 결정 갈루아 표현 $\rho : G_K \to \mathrm{GL}(V)$ 안의 임의의 $G_K$-안정 $\mathbb{Z}_\ell$-격자 $L \subset V$에 관하여,
정수환 $\mathcal{O}_K$ 위의 브뢰유-키신-파르그(Breuil-Kisin-Fargues) $F$-결정 `E : FCrys l (OL K)`와 반선형 비교 사상 $j : E(P_0) \to W(\mathbb{C}_\ell^\flat) \otimes_{\mathbb{Z}_\ell} L$ (`Realises`)가 존재하며, 격자 사이의 $G_K$-등변 사상 $f : T \to T'$가 유일한 $F$-결정 사상 $u : E \to E'$로 승강됨을 진술합니다(Bhatt-Morrow-Scholze `2018`, Publ. Math. IHÉS 128, **유형 I**).
3. **숄체-와인스타인 $p$-가분군 선형대수 분류 (`Development/AbelianVarietyTheory/PublishedTheorems/Divisors₂/ScholzeWeinsteinB.lean:13-24`, `in_degree = 454`)**: 대수적으로 닫힌 완비 비아르키메데스 체 $(C, v)$의 $p$-진 완비 정수환 $\mathcal{O}_C$ 위에서 $p$-가분군 범주 `PDivGroup p O`와 선형대수 쌍 $(T, W)$ ($T \cong \mathbb{Z}_p^h$는 테이트 가군,
$W = \ker(\alpha_{G,\mathrm{HT}}) \subset \mathcal{O}_C \otimes_{\mathbb{Z}_p} T$는 $c \cdot x \in W \implies x \in W$를 만족하는 포화 $\mathcal{O}_C$-부분가군) 사이의 범주 동치(사상의 유일 승강 완전충실성 `L17-19` 및 포화 부분가군 실현 대상 동형 전사성 `L20-23`)를 원문 그대로 정식화합니다(Scholze-Weinstein `2013`, Ann. of Math. 178, 정리 B, **유형 I**).
4. **프리즘 디외도네 호지 완전열 및 파르그 완전성 (`Development/AbelianVarietyTheory/PublishedTheorems/Divisors₂/InjectiveOfSmulMemRange.lean:23-67`,
`Development/AutomorphicArithmetic/ThetaCorrespondence/PrismaticDieudonne/PrismaticDieudonneHodge.lean:19-29`)**: 원문 `PrismaticDieudonneHodgeAt`는 반가법 반변 함자 $M : \mathrm{PDivGroup}(p, \mathcal{O}_C)^{\mathrm{op}} \to \mathrm{Mod}_{A_{\inf}}$ (자유 랭크 $\mathrm{ht}(G)$), 프로베니우스 $\varphi_G$ ($\varphi(\xi) M(G) \subset \mathrm{im}(\varphi_G)$),
폰텐 $\theta : A_{\inf} \twoheadrightarrow \mathcal{O}_C$ 핵 $\xi$ 법 환원 사상 $r_G : M(G) \twoheadrightarrow D(G)$, 그리고 호지-드람 완전열

    $$
    0 \longrightarrow \omega_G \xrightarrow{\;\iota_G\;} D(G) \xrightarrow{\;\pi_G\;} \mathrm{Lie}(G^\vee) \longrightarrow 0
    $$

    과 에탈 상수군 $\underline{\mathbb{Q}_p/\mathbb{Z}_p}$ (`const p O`, $\varphi = \sigma$) 및 곱셈군 $\mu_{p^\infty}$ (`PDivGroup.mu p O`, $\varphi = \varphi(\xi)\sigma$)의 명시 계산을 담고 있습니다. 단, 마지막 `L56-58`에서 함자 $M$의 완전충실성을 임의의 두 $p$-가분군 $(G, H)$ 전체에서 요구하지 않고 **오직 $\mathrm{Hom}(\underline{\mathbb{Q}_p/\mathbb{Z}_p}, \mu_{p^\infty})$ 위에서의 전단사성**만 요구합니다.
이는 안쉬츠-르브라(`2023`, *Prismatic Dieudonné theory*) 정리의 **유형 II-B 특화**로서, 연결-에탈 확장의 분류를 거쳐 로랑 파르그(`2010`)의 유한 평탄 군 스킴 하더-나라심한 여과 완전성 `FarguesExact` (`Development/AutomorphicArithmetic/ThetaCorrespondence/PrismaticDieudonne/PrismaticDieudonneHodge.lean:27-29`)를 도출하기에 필요충분한 정확한 절단면입니다.

---

### 5.4 이차 확장 하세 노름 정리, 란트헤어 에르미트 분류 및 유체론·국소 코호몰로지 감사

수론 및 갈루아 코호몰로지 기둥에서도 원문 대조는 결정적인 사실들을 밝혀줍니다.

```lean
-- Development/AbelianVarietyTheory/PublishedTheorems/Landherr₂/ExistsNormTensor.lean:12
def HasseNormSt : Prop :=
  (∀ (F : Type) [Field F] [NumberField F] (δ x : F), δ ≠ 0 → x ≠ 0 →
    (∀ σ : F →+* ℝ, ∃ a b : ℝ, σ x = a ^ 2 - σ δ * b ^ 2) →
    (∀ v : IsDedekindDomain.HeightOneSpectrum (𝓞 F), ∃ a b : v.adicCompletion F,
      algebraMap F (v.adicCompletion F) x = a ^ 2 - algebraMap F (v.adicCompletion F) δ * b ^ 2) →
    ∃ a b : F, x = a ^ 2 - δ * b ^ 2)
```

위 원문 `Development/AbelianVarietyTheory/PublishedTheorems/Landherr₂/ExistsNormTensor.lean:12`가 증명하듯, `hasse_norm_st_of_literature`의 기저 명세 `HasseNormSt`는 임의 차수 순환 갈루아 확장 $L/F$의 하세 노름 정리가 아니라 **수체 이차 확장 $F(\sqrt{\delta})/F$에서의 국소-대역 노름 원리**(모든 실수 매장 $\sigma$와 모든 유한 자리 완비화 $F_v$에서 $x = a_v^2 - \delta b_v^2$이면 대역 원소 $a, b \in F$로 $x = a^2 - \delta b^2$가 성립함,
즉 3원 이차 형식 $a^2 - \delta b^2 - x c^2$의 하세-민코프스키 정리)로 특화된 **유형 II-B 명제**입니다. 왜냐하면 바로 다음 단계인 `Development/AbelianVarietyTheory/PublishedTheorems/Landherr₂/LandherrStIffLandherr.lean:12`의 란트헤어(`1936`) 정리 `LandherrSt`가 CM 수체 $E$ 위 비퇴화 에르미트 행렬 $G, G' \in M_r(E)$의 등거리 동치($\gamma^T G \overline{\gamma} = G'$) 필요충분조건으로 ① 모든 복소 매장 $\tau$에서의 부호수 일치와 ② 행렬식 비
$\det(G')/\det(G) = z \overline{z}$가 $E / E^+$ 이차 노름이라는 조건만 요구하기 때문입니다(`Development/AbelianVarietyTheory/Proofs/AdelicLatticeProofs/LandherrAndLandherrSt.lean:19-23`에서 `HasseNormSt`로부터 직접 도출됨, `LandherrSt` 자체는 CM 에르미트 형식 전수 분류로서 **유형 I**).

끝으로 피참조 `740`회인 `Development/AbelianVarietyTheory/PublishedTheorems/AutomorphicForms₂/ExistsUniqueHcharOfFiniteOrder.lean:25-79`는 대역 아르틴 상호법칙 `GlobalArtinReciprocity`를 열린 몫사상 $\mathrm{art} : \mathbb{A}_E^\times \twoheadrightarrow \mathrm{Gal}(\overline{E}/E)^{\mathrm{ab}}$ (핵 $\ker(\mathrm{art}) = \overline{E^\times \cdot (E_\infty^\times)^\circ}$,
관성군 상 $\mathrm{art}(\mathcal{O}_v^\times) = \mathrm{im}(I_v)$, 균일화원 상 기하 프로베니우스 $\sigma_v^{-1}$)로 결점 없이 정식화하고(**유형 I**), 그 위에서 대수적 헤케 지표(`IsAlgPos χ n`)의 베유-세르 $\ell$-진 갈루아 지표 변환 `HeckeLAdicCharacter`를 정의합니다.
또한 `Formalism/GaloisCohomology/LocalTateDualityK.lean:41-62`와 직접 임포트 `CompanionTheory/AutomorphicTheory/PadicCyclotomicFields/GcohTop.lean:11-14`, `CompanionTheory/AutomorphicTheory/PadicCyclotomicFields/GcohTopEuler.lean:6-7`은 유한 확장 $K/\mathbb{Q}_\ell$ 위 유한 이산 $\mathbb{Z}/\ell^r\mathbb{Z}[G_K]$-가군 $M$에 관하여 $n \ge 3$ 소멸을 포함한 코호몰로지 유한성 `LocalFinitenessK`,
원분 뒤틀림 $\mathbb{Z}/\ell^r\mathbb{Z}(1)$ (`cycK`) 컵곱 전단사 `LocalTateDualityK`, 그리고 테이트(`1957`) 국소 오일러-푸앵카레 공식

$$
\# H^1(G_K, M) = \# H^0(G_K, M) \cdot \# H^2(G_K, M) \cdot (\# M)^{[K : \mathbb{Q}_\ell]}
$$

(`LocalEulerCharK`, `L57-61`)을 어떠한 축소도 없는 **순수 유형 I**로 증명합니다. 아울러 대역 코호몰로지 쌍대성을 담당하는 `Development/AbelianVarietyTheory/PublishedTheorems/GaloisCohomology₂/PoitouTateNormalised.lean:12-29`의 `PoitouTateNormalised`는 수체 $F$ 위 유한 이산 $\mathbb{Z}/\ell^r\mathbb{Z}[G_{F,S}]$-가군 $M$에 관해 정규화 국소 불변량 사상 족 `inv`와 푸아투-테이트 9항 완전열(`NineTermExact`), 테이트-샤파레비치 쌍대성(`ShaDual`),
$n \ge 3$ 코호몰로지 소멸을 선언하되, `L14`에 **`(l ≠ 2 ∨ IsTotallyComplex F)`** 조건을 명시합니다. 실수 무한 자리에서의 2-비틀림 갈루아 코호몰로지 잔류항을 원천 배제하여 홀수 소수 $\ell \ge 3$ 또는 CM 수체 위에서만 대역 오일러 지표와 그린버그-와일즈 셀머 비율 공식(`Development/AutomorphicArithmetic/ThetaCorrespondence/GaloisRepresentations/GreenbergWiles.lean:3-6`)을 깔끔하게 구동시키는 **유형 II-B 로커스 특화**입니다.

| 감사 대상 명세 식별자 | 원문 위치 (`src/` 기준) | 피참조 | 대응 고전 원전 | 동치성 분류 및 감사 판정 요지 |
| :--- | :--- | ---: | :--- | :--- |
| `GagaSections` / `SerreHolomorphicSections` | `Development/AutomorphicSpectrum/PublishedTheorems/Geometry₂/GagaSections.lean:10-18` | `153` | Serre (GAGA, 1956) | **유형 II-B**: 복소 매끄러운 고유·사영 스킴 위 선다발 `LB`의 $H^0$ 단면 대수화 전단사 특화 |
| `Principalisation` | `Development/AbelianVarietyTheory/PublishedTheorems/Divisors₂/GeometricallyConnectedOfIsIsoRestrict.lean:118-126` | `937` | Hironaka (1964), Kollár (2007) | **유형 I**: 표수 `0` 매끄러운 사영 스킴 이데알 층의 매끄러운 폭발열 SNC 주이데알화 |
| `L2ExtensionLogCanonical` | `Development/AbelianVarietyTheory/PublishedTheorems/Divisors₂/L2ExtensionLogCanonical.lean:32-55` | `158` | Ohsawa-Takegoshi (1987), Demailly (2015) | **유형 II-B**: 유한 개 고립 점 중심 `(A.zeroSet s).Finite`, 비소멸 야코비안, 명시 상수 $34/\delta$ 보간 특화 |
| `principalPolarisationOneSection` / `AbMulNSt` | `Development/AbelianVarietyTheory/PublishedTheorems/AbelianLaws/PrincipalPolarisationOneSection.lean:11-12` | `3` / `40` | Mumford (1970) | **유형 I**: 주편극 단면 차원 `1` 및 가역 $n$에 관한 $n$-비틀림 기수 $n^{2g}$. 교과서 정리 그대로 |
| `SemistableReductionSt` | `Development/AbelianVarietyTheory/PublishedTheorems/SemistableReduction₂/SemistableReductionSt.lean:15-23` | `10` | Grothendieck (SGA 7 I, 1972) | **유형 II-B**: $p$-진 유한 확장 $K/\mathbb{Q}_p$ 위 주편극 아벨 다양체의 준아벨 정수 모형 존재성 |
| `FontaineBcris` / `BhattScholzeIntegral` | `Development/AbelianVarietyTheory/PublishedTheorems/GaloisCohomology₂/BhattScholzeIntegral.lean:12-30` | `5` / `506` | Fontaine (1994), BMS (2018) | **유형 I**: $B_{\mathrm{cris}}$ 기본 완전열 및 결정 갈루아 격자의 $A_{\inf}$ 브뢰유-키신-파르그 가군 실현 |
| `ScholzeWeinsteinB` / `PrismaticDieudonneHodge` | `Development/AbelianVarietyTheory/PublishedTheorems/Divisors₂/ScholzeWeinsteinB.lean:13-24` | `454` / `3` | Scholze-Weinstein (2013), Anschütz-Le Bras (2023) | `ScholzeWeinsteinB`는 **유형 I**, 프리즘 디외도네는 $\mathrm{Hom}(\underline{\mathbb{Q}_p/\mathbb{Z}_p}, \mu_{p^\infty})$ 완전충실성 **유형 II-B** |
| `HasseNormSt` / `LandherrSt` | `Development/AbelianVarietyTheory/PublishedTheorems/Landherr₂/ExistsNormTensor.lean:12` | `33` / `10` | Hasse (1931), Landherr (1936) | `HasseNormSt`는 이차 확장 $a^2 - \delta b^2$ **유형 II-B**, `LandherrSt`는 CM 에르미트 분류 **유형 I** |
| `LocalTateDualityK` / `LocalEulerCharK` | `Formalism/GaloisCohomology/LocalTateDualityK.lean:47-62` | `5` / `6` | Tate (1957, 1958), Serre (1964) | **유형 I**: 유한 확장 $K/\mathbb{Q}_\ell$ 위 $\mathbb{Z}/\ell^r\mathbb{Z}$-가군 테이트 컵곱 쌍대성 및 오일러 지표 공식 |

---

### 5.5 토로이달 콤팩트화(`ToroidalForFanKS`) 및 산술 힐베르트-사무엘·아라켈로프 부피 감사

제5장의 대미를 장식하는 기둥은 아라켈로프 공집합 부피 상한(`TopCovolSlim2Use`)에 직접 투입되는 **유니터리 모듈라이 원환체(토로이달) 콤팩트화**와 **산술 힐베르트-사무엘 점근 부피 이론**입니다.

첫째, 피참조 `528`회인 `Development/AbelianVarietyTheory/PublishedTheorems/Divisors₂/ToroidalCompactificationBis.lean:45-55`에 정의된 `ToroidalForFanKS`는 CM 수체 $E$ 위의 호스트 데이터 `H : Host E`와 부호수 $(p,q)$ ($p + q \ge 1$) 모듈라이 데이텀 `Dw : Datum H` 위에서 팔팅스-차이(`1990`, *Degeneration of Abelian Varieties*) 및 란(Kai-Wen Lan, `2013`,
*Arithmetic Compactifications of PEL-Type Shimura Varieties*)의 정수 모형 토로이달 콤팩트화를 정식화합니다.

```lean
-- Development/AbelianVarietyTheory/PublishedTheorems/Divisors₂/ToroidalCompactificationBis.lean:45-55
def ToroidalForFanKS : Prop :=
  ∀ (E : Type) [Field E] [NumberField E] [IsCMField E] (H : Host E) (Dw : Datum H), 1 ≤ Dw.p + Dw.q →
    ∀ φ : InvFun (𝓞 E), IsPolFan H.bar (min Dw.p Dw.q) φ → NoSelfInt H.bar (min Dw.p Dw.q) φ →
      ∀ (l : Geo.Tor.Level H) (Xo : Moduli Dw l) (c : Coeff l),
        ∃ (Y : Model Xo c (RingHom.id c.F)) (BD : EffCartierData Y.X) (d k : ℕ), 1 ≤ d ∧ 1 ≤ k ∧
          SmoothOfRelativeDimension Dw.dim (genStr Y) ∧ FinalTheorems.Snc (genBdIdeal Y) ∧
          (∀ x ∈ BD.idealSheaf.support, x ∉ abLocus Y.t.G) ∧
          (∀ x ∈ genBd Y, GlobalTheory.MumfordChart.HasChartOf φ Y BD d x) ∧
          ((GlobalTheory.FlagMod.detOm Y).IsLB → GlobalTheory.IsAmpleLB (GlobalTheory.TorRef.polOf Y k BD)) ∧
          GlobalTheory.LogKS.HasLogKS Y.t Y.s (GlobalTheory.LogKS.interior Y)
```

원문 시그니처는 자기교차가 없는(`NoSelfInt`) 사영 불변 다면체 부채꼴(polyhedral cone decomposition) `φ : InvFun (𝓞 E)`(`SiegelToroidalIntegral.exists_fan`, `L56-61`에서 존재성 공급)가 주어질 때, 임의의 레벨 `l`과 모듈라이 `Xo : Moduli Dw l` 위로 확장된 콤팩트 모형 `Y`와 경계 유효 카르티에 인자 `BD`가 존재하여 다음 다섯 기하학적 성질을 만족함을 요구합니다(**유형 II-A**): ① 일반 섬유 구조 사상 `genStr Y`가 차원 $p q$ (`Dw.dim`)로 매끄럽고,
② 경계 이데알 `genBdIdeal Y`가 단순 정규 교차(`Snc`) 인자를 이루며, ③ 경계 지지집합이 내부 아벨 궤적 `abLocus`와 만나지 않고 모든 경계점 $x \in \mathrm{genBd}(Y)$ 근방에서 멈퍼드 반아벨 퇴화 완비 국소 차트(`HasChartOf φ Y BD d x`)를 가지며, ④ 호지 행렬식 선다발 $\omega_Y = \det \Omega^1_{G/Y}$ (`detOm Y`)에서 경계 인자의 양의 배수 $k \cdot \mathrm{BD}$만큼 비튼 선다발 $\omega_Y^{\otimes m} \otimes \mathcal{O}(- \mathrm{BD})$ 계통(`polOf Y k BD`,
최소 콤팩트화 베일리-보렐 선다발의 당김 변형)이 풍부(`IsAmpleLB`)해지고, ⑤ 내부 열린 궤적 위에서 대수적 로그 고다이라-스펜서 사상이 동형(`HasLogKS`)이 됩니다.

둘째, 이 토로이달 모형 위에서 아라켈로프 높이·소단면 개수를 지배하는 `Development/AbelianVarietyTheory/PublishedTheorems/Divisors₂/SmallSecTensTriv.lean:65-97`(`in_degree = 257`)은 상대 차원 $D$인 적분 산술 다양체 $p : X \to \mathrm{Spec}\,\mathcal{O}_k$ (`IsArithVar p D`) 위의 산술적 수치 양수(`L.IsNef D`) 에르미트 선다발 $\overline{L} = (L, \|\cdot\|)$에 관해,
모든 무한 자리에서 점별 노름 제곱이 `1` 이하인 정수 소단면 집합 $\widehat{H}^0_{\mathrm{small}}(X, \overline{L}^{\otimes m}) := (\mathrm{L.pow}\;m).\mathrm{smallSec}$의 유한성과 점근 산술 힐베르트-사무엘 공식을 다음과 같이 정식화합니다(`of_triv`, `L65-69`).

$$
\log \# \widehat{H}^0_{\mathrm{small}}\bigl(X, \overline{L}^{\otimes m}\bigr) = \frac{a}{\Gamma(D + 2)}\, m^{D + 1} + o\bigl(m^{D + 1}\bigr) \qquad (m \to \infty)
$$

여기서 $a \in \mathbb{R}$는 $\overline{L}$의 $(D+1)$-중 아라켈로프 자기교차수(`L.IsSelfInter a`)이며, `L89-97`의 정리 `volNef`는 위 점근식을 $\Gamma(D+2) / m^{D+1}$로 나누어 상극한(`limsup`)을 취함으로써 산술 nef 선다발의 모리와키 산술 부피 $\widehat{\mathrm{vol}}(\overline{L})$이 정확히 자기교차수 $a$와 일치함을 연역합니다(Gillet-Soulé `1992`, Zhang `1995`, Moriwaki `2000`, Yuan `2008`).
여기에 `Development/WeilBound/CoreStatements/TemperedRepresentationTheory/ArakelovCycleHeights/CycleHeightFormulas/CycleHeightsDirect.lean:138-147`의 푸앵카레-를롱 전류 기반 직접 교차 연산(`arCalc_direct`,
`cycleHeights_direct`)과 `Development/AbelianVarietyTheory/Proofs/DivisorProofs/VolGeOfHilbertSamuel.lean:26-86`의 차분 부피 부등식 $\widehat{\mathrm{vol}}(\overline{L} - \overline{M}) \ge (\overline{L}^{D+1}) - (D+1)(\overline{L}^D \cdot \overline{M})$ (`VolGe`, Yuan `2008` 시우형 산술 부등식)이 결합되어 시무라 다양체 위 비소멸 대수적 보형 단면을 생산하는 산술기하 엔진이 완결됩니다.

---

## 제6장. `EveryCharacterOfLiteratureOfVWin` 직접 임포트 `201`개 전수 분류 원장

본 장은 `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/EveryCharacterOfLiteratureOfVWin.lean:1-208`의 전체 `import` 선언 `208`줄 가운데 순수 `Mathlib` 임포트 `7`줄(`L62`의 `Mathlib` 및 `L138-143`의 복소해석·특수함수 `6`종)을 제외한 **아카이브 내부 직접 로컬 임포트 `201 / 201`개 전수(`100.00%`, 총 `12,171`줄, 정리 `690`개, 정의·구조체 `103`개)**를 단 하나의 누락도 없이 전수 대조한 원장입니다.

각 항목에는 원본 임포트 순번(`001`~`201`)과 `EveryCharacterOfLiteratureOfVWin.lean` 내부 임포트 행 번호(`L1`~`L208`), `src/` 기준 정확한 파일·행 범위 핀(대표 최상위 선언 위치), 파일 줄 수와 전체 아카이브 피참조 횟수(`in_degree`), 핵심 선언 식별자, 대응 고전 문헌, 그리고 제1장 제1.3절의 기준에 따른 의미론 동치성 분류를 병기했습니다.

| 동치성 분류 범주 | 직접 임포트 모듈 수 (`201`개 중) | 점유 비율 | 인식론적 성격 및 인간 논문 압축 시 처리 원칙 |
| :--- | ---: | ---: | :--- |
| **유형 I** (원논문·교과서 동치 일반 명제) | `92`개 | `45.77%` | 표준 수학 정의(`Mathlib` 체·스킴·표현·코호몰로지) 위에서 일반 정리를 그대로 정식화함. 원논문 블랙박스 직접 인용 가능 |
| **유형 II-A** (아카이브 고유 구조체 투영 명제) | `56`개 | `27.86%` | `D7`, `HSp D`, `GA D V`, `GrpData p q`, `LocPrime`·`LocTied`, `UJset` 등 아카이브 전용 구조체 위에서만 진술됨. 인간 인용 시 구조체 번역 어댑터 보조정리 점검 필수 |
| **유형 II-B** (부분 로커스·약화 조건 특화 명제) | `34`개 | `16.92%` | `[IsTotallyComplex]`·`[IsCMField]`, 이차 확장 노름, 비분기 `DefiniteN`, 깊이 `0` `GoodCusp`, $\ell \neq 2$, 점 중심 $L^2$-확장 등 증명에 필요한 부분 로커스로 한정됨. 고전 대정리가 함의함 |
| **조립·어댑터** (가설 번들·시그니처 브리지·스텁) | `19`개 | `9.45%` | 기출 증인들을 상위 가설 구조체로 묶거나 리팩터링 전후 타입을 맞추는 내부 배선 모듈 및 행렬·위상 보조정리 |
| **합계** | **`201`개** | **`100.00%`** | **단일 누락·중복 없음 (`001`~`201` 전수 검증 완료)** |

### 6.1 제1군: `CompanionTheory` · `GroundTheory` · `DiscreteGroups` 외부 기초 모듈 (`8`개)

실수 리 군 이산계열 분류·소진성, 아델 제한 텐서곱 허용성, 미라볼릭 키릴로프 모형, 국소 역정리, $p$-진 원분체 국소 갈루아 코호몰로지를 공급하는 비-`Development` 기초 모듈군 및 `DiscreteGroups` 모듈입니다.

| 순번 (`임포트 행`) | `src/` 기준 모듈 경로 및 대표 선언 핀 (`줄 수` · `피참조`) | 대표 선언명 (`종류`) | 대응 고전 원전 및 역할 | 동치성 판정 및 원문 포렌식 요지 |
| :--- | :--- | :--- | :--- | :--- |
| `001` (`L1`) | `CompanionTheory/SpectralGeometry/LocalGlobalProofs/AdelicAnalysis/Imports.lean:10-13` (`14`줄 · 피참조 `2`) | `siegelWeilUnitaryConvergent` (`theorem`) | Ichino (2004), GQT (2014) | **유형 II-A**: 헤케 지표 뒤틀림 유니터리 수렴 지겔-베유 등식 증인 |
| `002` (`L2`) | `CompanionTheory/AutomorphicTheory/PadicCyclotomicFields/GcohTop.lean:13-14` (`15`줄 · 피참조 `5`) | `top_locfin` (`theorem`) | Tate (1958), Serre (1964) | **유형 I**: 국소체 유한 비틀림 가군 테이트 쌍대성·유한성 증인 |
| `003` (`L3`) | `CompanionTheory/AutomorphicTheory/PadicCyclotomicFields/GcohTopEuler.lean:6-7` (`8`줄 · 피참조 `6`) | `top_euler` (`theorem`) | Tate (1957), Milne (1986) | **유형 I**: 국소체 갈루아 코호몰로지 오일러-푸앵카레 지표 공식 |
| `004` (`L4`) | `CompanionTheory/RealGroups/DiscreteSeries/DiscreteSeriesClassification/KTypesAbove.lean:21-22` (`23`줄 · 피참조 `5`) | `classUsed` (`theorem`) | Harish-Chandra (1966), Knapp (1986) | **유형 II-A**: 실수 $U(p,q)$ 및 2중 피복군 이산계열 존재·상위 $K$-타입 |
| `005` (`L5`) | `CompanionTheory/RealGroups/DiscreteSeries/DiscreteSeriesClassification/DiscreteSeriesExhaustion/DsExhaust.lean:20-21` (`22`줄 · 피참조 `2`) | `discreteSeriesCover` (`theorem`) | Harish-Chandra (1966), Herb (1979) | **유형 II-A**: 유한 길이 소진성에 기반한 피복군 이산계열 전단사 분류 |
| `006` (`L6`) | `CompanionTheory/RealGroups/UnitaryAdmissibility/ArchimedeanUnitaryDual/FinalB.lean:55-57` (`58`줄 · 피참조 `2`) | `flathTensorProduct` (`theorem`) | Harish-Chandra (1953), Flath (1979) | **유형 I**: 기약 유니터리 허용성 및 아델 제한 텐서곱 분해 |
| `081` (`L82`) | `Development/DiscreteGroups/GlobalIrreducibility/LConvFinal.lean:22-23` (`24`줄 · 피참조 `3`) | `unitAdmGL` (`theorem`) | Henniart (1993), JPSS (1983) | **유형 I**: 뒤틀림 감마·엡실론 인자에 의한 $\mathrm{GL}_n$ 국소 역정리 및 유니터리 허용성 |
| `085` (`L86`) | `GroundTheory/HeightsAndTheta/Theta/FiniteGL/Mirabolic.lean:351-359` (`366`줄 · 피참조 `2`) | `mirabolicDelta_ne_zero` (`theorem`) | Gelfand-Kazhdan (1975), BZ (1976) | **유형 I**: 체 위 미라볼릭 부분군 유도 공간·비퇴화 지표·깃발 첨점성 기초 |

### 6.2 제2군: `Development.AbelianVarietyTheory.PublishedTheorems` 직접 명세 모듈 (`6`개)

`EveryCharacterOfLiteratureOfVWin.lean`이 중간 증인 래퍼를 거치지 않고 `AbelianVarietyTheory.PublishedTheorems` 내부에서 직접 호출하는 아라켈로프 당김, 산술 부피, 그로텐디크 변형, 카라이아니 쌍대 명세, 아르틴 광선 지표, 초첨점 랑글란즈 명세 `6`선입니다.

| 순번 (`임포트 행`) | `src/` 기준 모듈 경로 및 대표 선언 핀 (`줄 수` · `피참조`) | 대표 선언명 (`종류`) | 대응 고전 원전 및 역할 | 동치성 판정 및 원문 포렌식 요지 |
| :--- | :--- | :--- | :--- | :--- |
| `007` (`L7`) | `Development/AbelianVarietyTheory/PublishedTheorems/Divisors₂/ResidueDegreeOfIsClosedImmersion.lean:191-195` (`209`줄 · 피참조 `80`) | `isSelfInter_shift` (`theorem`) | Bost-Gillet-Soulé (1994), Zhang (1995) | **유형 II-A**: 닫힌 몰입 잉여차수와 아라켈로프 순환 높이 당김 공식 |
| `008` (`L8`) | `Development/AbelianVarietyTheory/PublishedTheorems/Divisors₂/SmallSecTensTriv.lean:89-97` (`100`줄 · 피참조 `257`) | `volNef` (`theorem`) | Moriwaki (2000-2009), Chen (2010) | **유형 II-A**: 산술 nef 선다발 소단면 점근 극한 및 부피 연속성 |
| `009` (`L9`) | `Development/AbelianVarietyTheory/PublishedTheorems/Divisors₂/GrothendieckDeformation.lean:31-39` (`42`줄 · 피참조 `288`) | `_root_.GlobalTheory.Published.GrothendieckDeformation.at_dualNumber` (`theorem`) | Grothendieck (1970), Messing (1972) | **유형 I**: 아벨 스킴 무한소 변형 명세 및 결정 디외도네 함의 |
| `010` (`L10`) | `Development/AbelianVarietyTheory/PublishedTheorems/GaloisGeometry₂/CaraianiLocalGlobalDual.lean:16-29` (`32`줄 · 피참조 `16`) | `CaraianiLocalGlobalDual` (`def`) | Caraiani (2012, 2014) | **유형 II-A**: (`LocPrime`·`LocTied`·`LocBridge` 주기환 브리지) 켤레 자기쌍대 코호몰로지 첨점 표현의 모든 자리 국소-대역 호환 명세 |
| `011` (`L11`) | `Development/AbelianVarietyTheory/PublishedTheorems/GaloisCohomology₂/ExistsIdealsPrimeToEqSpan.lean:463-481` (`484`줄 · 피참조 `13`) | `kills_of_rayPrincipal` (`theorem`) | Artin (1927), Takagi (1920) | **유형 II-B**: (`[IsTotallyComplex]` 수체 로커스) 서로소 이데알 대표원 선택 및 광선 유군 아르틴 지표 유도 |
| `184` (`L191`) | `Development/AbelianVarietyTheory/PublishedTheorems/GaloisCohomology₂/SupercuspidalLanglands.lean:16-21` (`24`줄 · 피참조 `4`) | `SupercuspidalLanglands` (`def`) | Harris-Taylor (2001), Henniart (2000) | **유형 I**: 비아르키메데스 국소체 초첨점 표현의 국소 랑글란즈 전단사 명세 정의 |

### 6.3 제3군: `Development.AbelianVarietyTheory.Proofs` 대수기하·표현론·수론 기출 증인 모듈 (`79`개)

`201`개 직접 임포트 중 단일 최대 비중(`39.30%`, `79`개 파일, `5,516`줄)을 차지하는 핵심 증인 계층입니다. 아벨 스킴·GAGA·토로이달·드마이 $L^2$-확장(`DivisorProofs` 외 `39`개), 에르미트 격자·첨점 급감소(`6`개), 사타케·순수성(`10`개), 폰텐 $B_{\mathrm{cris}}$·바트-숄체·깊이 `0` 국소 랑글란즈(`21`개), 바일 알코브·대역 아르틴·기하 보조정리(`3`개)를 망라합니다.

| 순번 (`임포트 행`) | `src/` 기준 모듈 경로 및 대표 선언 핀 (`줄 수` · `피참조`) | 대표 선언명 (`종류`) | 대응 고전 원전 및 역할 | 동치성 판정 및 원문 포렌식 요지 |
| :--- | :--- | :--- | :--- | :--- |
| `012` (`L12`) | `Development/AbelianVarietyTheory/Proofs/AbelianSchemeLawProofs/PrincipalPolarisationUniqueSection.lean:7-9` (`10`줄 · 피참조 `3`) | `principalPolarisation_unique_section` (`theorem`) | Mumford (1970) | **유형 I**: 대수적 닫힌 체 위 주편극 아벨 다양체 전역 단면 차원 1 증인 |
| `013` (`L13`) | `Development/AbelianVarietyTheory/Proofs/AdelicLatticeProofs/HasseNormTheoremQuadraticExtension.lean:13-33` (`34`줄 · 피참조 `33`) | `hasseNormSt` (`theorem`) | Hasse (1931) | **유형 II-B**: 수체 이차 확장 전용 국소-대역 노름 일치 정리 증인 |
| `014` (`L14`) | `Development/AbelianVarietyTheory/Proofs/AdelicLatticeProofs/LandherrAndLandherrSt.lean:19-23` (`24`줄 · 피참조 `10`) | `_root_.GlobalTheory.QNorm.landherr_and_landherrSt` (`theorem`) | Landherr (1936), Scharlau (1985) | **유형 I**: 하세 이차 노름 정리로부터 CM 에르미트 형식 분류 도출 |
| `015` (`L15`) | `Development/AbelianVarietyTheory/Proofs/CoherentCohomologyProofs/AbelianVarietyTorsionCardEqPowProof.lean:18-21` (`22`줄 · 피참조 `40`) | `_root_.GlobalTheory.abMulN_holds` (`theorem`) | Mumford (1970) | **유형 I**: 아벨 스킴 $n$-배 사상의 비틀림 부분군 기수 $n^{2g}$ 증명 |
| `016` (`L16`) | `Development/AbelianVarietyTheory/Proofs/DecoratedLatticeProofs/ImportsBis.lean:8-12` (`13`줄 · 피참조 `182`) | `weilRepresentationUnitaryPair` (`theorem`) | Kudla (1994), HKS (1996) | **유형 II-A**: 유니터리 시소 이중쌍 위 베유 표현 당김 구성 증인 |
| `017` (`L17`) | `Development/AbelianVarietyTheory/Proofs/DecoratedLatticeProofs/IsCommensuratedKO.lean:125-162` (`163`줄 · 피참조 `4`) | `unramifiedDoublingGL` (`theorem`) | Piatetski-Shapiro-Rallis (1987) | **유형 II-A**: 비분기 구형 벡터에서의 배가법 국소 제타 적분 계산 |
| `018` (`L18`) | `Development/AbelianVarietyTheory/Proofs/DecoratedLatticeProofs/CuspidalModerateGrowthRapidDecay.lean:20-106` (`107`줄 · 피참조 `5`) | `cuspDecayBound` (`theorem`) | Harish-Chandra (1968), Borel (1974) | **유형 II-A**: D7 아델 유니터리 첨점 형식의 미분 노름 급감소 상한 |
| `019` (`L19`) | `Development/AbelianVarietyTheory/Proofs/DecoratedLatticeProofs/CuspFormsRapidDecay.lean:10-11` (`11`줄 · 피참조 `4`) | `GlobalTheory.RapidDecay.cuspRapidDecay` (`theorem`) | Godement, Harish-Chandra (1968) | **유형 II-A**: D7 아델 유니터리 첨점 형식의 몫높이 다항식 급감소 증인 |
| `020` (`L20`) | `Development/AbelianVarietyTheory/Proofs/DegenerationProofs/SemistableReductionPpavPadicField.lean:19-22` (`23`줄 · 피참조 `10`) | `_root_.GlobalTheory.SS.semistableReductionSt` (`theorem`) | Grothendieck (SGA 7 I, 1972) | **유형 II-B**: p-진 유한 확장 위 주편극 아벨 다양체의 준안정 환원 증인 |
| `021` (`L21`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/ChowFormIntExistsAndChowFormExists.lean:249-251` (`252`줄 · 피참조 `10`) | `chowFormExists_holds` (`theorem`) | Chow-van der Waerden (1937), Philippon | **유형 I**: 사영 부분다양체의 정수·체 계수 차우 형식 존재성 증명 |
| `022` (`L22`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/SerreHolomorphicSectionsHolds.lean:53-56` (`56`줄 · 피참조 `23`) | `GlobalTheory.AnRead.bijective_valC` (`theorem`) | Serre (GAGA, 1956) | **유형 II-B**: 복소 매끄러운 사영 스킴 선다발의 해석-대수 단면 전단사 증인 |
| `023` (`L23`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/GrothendieckDeformationOfLifting.lean:9-13` (`14`줄 · 피참조 `13`) | `grothendieckDeformation_of_lifting` (`theorem`) | Grothendieck, Illusie (1971-1985) | **유형 I**: 드람 코호몰로지 및 승강성으로부터 아벨 변형 매끄러움 도출 |
| `024` (`L24`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/SemiAbelianHomExtensionHolds.lean:7-9` (`10`줄 · 피참조 `40`) | `semiAbelianHomExtension_holds` (`theorem`) | Raynaud, Faltings-Chai (1990) | **유형 I**: 정규 기저 위 준아벨 스킴 군 사상의 유일 확장 증인 |
| `025` (`L25`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/KawamataViehwegOfNadelVanishingPair.lean:62-68` (`69`줄 · 피참조 `2`) | `kawamataViehweg_of_nadelVanishingPair` (`theorem`) | Kawamata-Viehweg (1982), Nadel (1990) | **유형 I**: 나델 승수 이데알 소멸과 클라이먼 수치성에서 KV 소멸 도출 |
| `026` (`L26`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/JoinOutOfFive.lean:15-17` (`17`줄 · 피참조 `2`) | `GlobalTheory.JoinFun.joinOut_of_five` (`theorem`) | 내부 문헌 결합 어댑터 | **조립·어댑터**: CM 주정리·지겔-클링엔·테이트 함수방정식 5종을 JoinOut으로 결합 |
| `027` (`L27`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/VolGeOfHilbertSamuel.lean:26-86` (`87`줄 · 피참조 `2`) | `volGe_of_hilbertSamuel` (`theorem`) | Yuan (2008), Moriwaki (2009) | **유형 II-A**: 산술 힐베르트-사무엘 정리로부터 산술 부피 하한 VolGe 도출 |
| `028` (`L28`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/L2ExtensionLogCanonical.lean:13-17` (`18`줄 · 피참조 `2`) | `l2ExtensionLogCanonical'` (`theorem`) | Ohsawa-Takegoshi (1987), Demailly (2015) | **유형 II-B**: 0차원 고립 로그 정준 중심 위 정칙 단면 $L^2$ 확장 증인 |
| `029` (`L29`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/LogDerOneHolds.lean:11-79` (`80`줄 · 피참조 `2`) | `logDerOne_holds` (`theorem`) | Hadamard, de la Vallée Poussin (1896) | **유형 I**: s=1 근방 로그미분 극점 유수 및 단위원 경계 평가 증인 |
| `030` (`L30`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/GoodChernWeil.lean:10-12` (`13`줄 · 피참조 `2`) | `goodChernWeil` (`theorem`) | Chern-Weil, Mumford (1977) | **유형 II-A**: 좋은 에르미트 계량 선다발 위 천-베유 곡률 대표원 일치 |
| `031` (`L31`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/MetaplecticRepresentationHolds.lean:17-107` (`108`줄 · 피참조 `2`) | `metaplecticRepresentation_holds` (`theorem`) | Weil (1964) | **유형 I**: 국소·아델 심플렉틱 군의 2중 메타플렉틱 표현 구성 증인 |
| `032` (`L32`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/SemiAbelianLieSeminegativeBis.lean:22-29` (`30`줄 · 피참조 `2`) | `semiAbelianLieSeminegative` (`theorem`) | Faltings (1983), Faltings-Chai (1990) | **유형 II-A**: 준아벨 스킴 리 대수 쌍대 호지 다발 곡률 준음수성 |
| `033` (`L33`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/InfinitesimalEquivalenceUnitaryGroupPQ.lean:737-739` (`742`줄 · 피참조 `2`) | `gkGlobalisation_holds` (`theorem`) | Harish-Chandra (1953), Clozel (1986) | **유형 II-A**: $U(p,q)$ 무한소 동치 및 국소 이산계열의 대역 첨점화 증인 |
| `034` (`L34`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/HolomorphicDiscreteSeriesHolds.lean:15-42` (`43`줄 · 피참조 `2`) | `holomorphicDiscreteSeries_holds` (`theorem`) | Harish-Chandra (1955-1956) | **유형 II-A**: 에르미트 대칭 영역 정칙 이산계열 최저 가중치 실현 증인 |
| `035` (`L35`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/DualAbelianSchemeExistsBiduality.lean:29-34` (`35`줄 · 피참조 `16`) | `dualAbelianScheme` (`theorem`) | Grothendieck, Mumford, Raynaud | **유형 I**: 기저 스킴 위 쌍대 아벨 스킴 존재성 및 이중쌍대성 증명 |
| `036` (`L36`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/KFiniteVectorsIrreducibleUnitaryUnitaryGroupPQ.lean:76-83` (`86`줄 · 피참조 `2`) | `kFiniteVectors_irreducibleUnitary_unitaryGroupPQ` (`theorem`) | Harish-Chandra (1953) | **유형 II-A**: 부정부호 유니터리 군 기약 유니터리 표현 $K$-유한 벡터 조밀성 |
| `037` (`L37`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/DixmierMalliavinFactorisationFromLibrary.lean:7-9` (`10`줄 · 피참조 `2`) | `dixmierMalliavinFactorisation_fromLibrary` (`theorem`) | Dixmier-Malliavin (1978) | **유형 I**: 매끄러운 콤팩트 지지 시험함수의 유한 합성곱 인수분해 증인 |
| `038` (`L38`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/GeometricLemmaFiltrationHolds.lean:6-8` (`9`줄 · 피참조 `7`) | `geometricLemmaFiltration_holds` (`theorem`) | Bernstein-Zelevinsky (1977), Casselman | **유형 I**: 포물선 유도 후 자케 제한 함자의 브뤼아 궤도 여과열 증인 |
| `039` (`L39`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/HeckeTateFE.lean:5-6` (`6`줄 · 피참조 `2`) | `GlobalTheory.Top.heckeTateFE` (`theorem`) | Tate (1950) | **유형 II-B**: (`[IsCMField]`·`[IsTotallyComplex]` 로커스) 아델 수체 위 헤케 L-함수 해석적 연속 및 테이트 함수방정식 |
| `040` (`L40`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/LocfinHolds.lean:9-10` (`11`줄 · 피참조 `2`) | `locfin_holds` (`theorem`) | Tate, Serre (1964) | **유형 I**: 수체 완비화 국소 갈루아 코호몰로지 군 유한성 래퍼 증인 |
| `041` (`L41`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/LoceulerHolds.lean:8-9` (`10`줄 · 피참조 `2`) | `loceuler_holds` (`theorem`) | Tate (1957) | **유형 I**: 수체 완비화 국소 갈루아 오일러-푸앵카레 지표 공식 증인 |
| `042` (`L42`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/HcfjHolds.lean:7-8` (`9`줄 · 피참조 `3`) | `hcfj_holds` (`theorem`) | Weber (1908), Shimura (1971) | **유형 II-B**: (`[IsTotallyComplex]` 허수 이차체 로커스) 허수 이차체 타원 j-불변량의 힐베르트 유체 생성 정리 증인 |
| `043` (`L43`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/AbelianSchemeHomLiftingNilpotentDividedPowers.lean:19-23` (`24`줄 · 피참조 `4`) | `abelianScheme_hom_lifting_nilpotent_dividedPowers` (`theorem`) | Grothendieck, Norman-Oort (1980) | **유형 I**: 멱영 분할거듭제곱 두꺼워짐 위 아벨 스킴 사상 승강 증인 |
| `044` (`L44`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/HoweDualityRealHolds.lean:18-48` (`51`줄 · 피참조 `2`) | `howeDualityReal_holds` (`theorem`) | Howe (1989) | **유형 II-A**: 아르키메데스 실수 유니터리 가약 이중쌍 위 하우 쌍대성 증인 |
| `045` (`L45`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/ExistsMulEquiv.lean:115-129` (`130`줄 · 피참조 `2`) | `localTateDuality` (`theorem`) | Tate (1958-1962) | **유형 I**: p-진 국소체 갈루아 코호몰로지 컵곱 국소 테이트 완전 쌍대성 |
| `046` (`L46`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/ImportsTailTer.lean:14-22` (`23`줄 · 피참조 `2`) | `strongApproxSU` (`theorem`) | Kneser (1965), Platonov (1969) | **유형 II-B**: (`IsCMExt` CM 확장 로커스) 단일연결 특수유니터리 군 SU(V)의 아델 강한 근사 정리 증인 |
| `047` (`L47`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/ToroidalCompactificationFanLogKodairaSpencerIso.lean:8-10` (`11`줄 · 피참조 `3`) | `toroidalForFanKS` (`theorem`) | Faltings-Chai (1990), Lan (2013) | **유형 II-A**: 적합 다면체 부채꼴 위 토로이달 경계 및 로그 고다이라-스펜서 동형 |
| `048` (`L48`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/ToroidalCompactificationHolds.lean:10-16` (`17`줄 · 피참조 `2`) | `toroidalCompactification_holds` (`theorem`) | AMRT (1975), Faltings-Chai (1990) | **유형 II-A**: 유니터리·지겔 모듈라이의 원환체 콤팩트화 모델 존재 증인 |
| `049` (`L49`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/CuspidalMirabolicHolds.lean:7-9` (`10`줄 · 피참조 `2`) | `cuspidalMirabolic_holds` (`theorem`) | S. I. Gelfand (1970), Green (1955) | **유형 I**: 유한체 $\mathrm{GL}_{n+1}(\mathbb{F}_q)$ 첨점 표현의 미라볼릭 제한 기약성 증인 |
| `050` (`L50`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/SiegelToroidalIntegralHolds.lean:14-16` (`17`줄 · 피참조 `2`) | `siegelToroidalIntegral_holds` (`theorem`) | Faltings-Chai (1990) | **유형 II-A**: CM 정수환 위 불변 양수 다면체 부채꼴 구성 증인 |
| `051` (`L51`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/CmCurveGoodOutsidePrime.lean:47-102` (`103`줄 · 피참조 `2`) | `cmCurveGoodOutsidePrime` (`theorem`) | Serre-Tate (1968) | **유형 II-B**: (`p ≡ 3 (mod 4)` 허수 이차 CM 로커스) 복소곱셈 타원곡선의 도체 외부 좋은 환원 및 잠재적 환원 증인 |
| `052` (`L52`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/ArithHilbertSamuelOfPrincipalisation.lean:11-15` (`16`줄 · 피참조 `2`) | `arithHilbertSamuel_of_principalisation` (`theorem`) | Gillet-Soulé (1992), Zhang (1995) | **유형 I**: 주이데알화로부터 산술 힐베르트-사무엘 점근 공식 도출 |
| `053` (`L53`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/KudlaSplittingSplitUnitary.lean:17-43` (`44`줄 · 피참조 `2`) | `kudlaSplittingSplitUnitary` (`theorem`) | Kudla (1994) | **유형 II-A**: 분할 유니터리 이중쌍 위 메타플렉틱 피복 분해 준동형 증인 |
| `054` (`L54`) | `Development/AbelianVarietyTheory/Proofs/SatakeParameters/ApplyMemTwKerOfNormalizer.lean:775-781` (`782`줄 · 피참조 `16`) | `depthZeroJacquetInjective` (`theorem`) | Moy-Prasad (1994-1996) | **유형 I**: 깊이 0 표현에서 파라호릭 고정 공간으로 가는 자케 사상 단사성 |
| `055` (`L55`) | `Development/AbelianVarietyTheory/Proofs/SatakeParameters/AbsPowValEqZpow.lean:35-40` (`40`줄 · 피참조 `3`) | `GlobalTheory.TotDisjUnlinked.main` (`theorem`) | Zelevinsky (1980) | **유형 I**: 초첨점 지지 서로소 기약성으로부터 비연결 세그먼트 곱 기약성 도출 |
| `056` (`L56`) | `Development/AbelianVarietyTheory/Proofs/SatakeParameters/RegularAlgebraicPurityOfClozel.lean:8-12` (`13`줄 · 피참조 `4`) | `regularAlgebraicPurity_of_clozel` (`theorem`) | Clozel (1990), Shin (2011), Caraiani (2012) | **유형 II-B**: (`[IsCMField]` 수체 로커스) 클로젤 코호몰로지·순수성 결합으로 정칙 대수적 순수성 도출 |
| `057` (`L57`) | `Development/AbelianVarietyTheory/Proofs/SatakeParameters/LocalGlobalAboveL.lean:20-37` (`40`줄 · 피참조 `3`) | `main` (`theorem`) | Caraiani (2014), BLGGT (2014) | **유형 II-A**: (`LocPrime`·`LocTied`·`LocBridge` 주기환 브리지) l 외 자리 흔적 일치와 체보타레프 조밀성으로 l 위 호환성 도출 |
| `058` (`L58`) | `Development/AbelianVarietyTheory/Proofs/SatakeParameters/HeckeLAdicParameterAboveOfAlgebraicCharacterWD.lean:7-13` (`14`줄 · 피참조 `5`) | `heckeLAdicParameterAbove_of_algebraicCharacterWD` (`theorem`) | Weil (1956), Serre (1968), Tate (1979) | **유형 II-A**: 대수적 지표 베유-들리뉴 대응으로부터 l 위 매개변수 정합성 도출 |
| `059` (`L59`) | `Development/AbelianVarietyTheory/Proofs/SatakeParameters/CohomologicalCsdTemperedOfSegments.lean:16-29` (`30`줄 · 피참조 `5`) | `cohomologicalCsdTempered_of_caraianiTempered` (`theorem`) | Caraiani (2012), Zelevinsky (1980) | **유형 II-B**: (`[IsCMField]` 수체 로커스) 카라이아니 완만성과 세그먼트 분류로 켤레 자기쌍대 완만성 증명 |
| `060` (`L60`) | `Development/AbelianVarietyTheory/Proofs/SatakeParameters/LocalGlobalOfGelfandKazhdan.lean:12-24` (`25`줄 · 피참조 `6`) | `galoisRepOfPolarizedCuspidal_iff_pair` (`theorem`) | Gelfand-Kazhdan (1975), CHT (2008) | **유형 II-B**: (`[IsCMField]` 수체 로커스) 겔판트-카즈단 전치 쌍대성으로 편극 쌍과 첨점 갈루아 대응 동치화 |
| `061` (`L61`) | `Development/AbelianVarietyTheory/Proofs/SatakeParameters/ExistsCount.lean:70-71` (`74`줄 · 피참조 `6`) | `htCard` (`theorem`) | Fontaine (1982), Sen (1980) | **유형 II-A**: `LocPrime`·`LocTied` 위 $\ell$-진 드람 가군의 호지-테이트 여과 점프 중복도 합(`HtCard := PhtCmp`) 증인 |
| `062` (`L63`) | `Development/AbelianVarietyTheory/Proofs/SatakeParameters/UnitarySegmentOfCentralUnit.lean:78-101` (`101`줄 · 피참조 `2`) | `GlobalTheory.UnitLSeg.main` (`theorem`) | Zelevinsky (1980), Tadić (1986) | **유형 I**: 유니터리 중심 지표를 갖는 랑글란즈 세그먼트의 유니터리화 가능성 |
| `063` (`L64`) | `Development/AbelianVarietyTheory/Proofs/SatakeParameters/LocalComponentTempered.lean:44-56` (`57`줄 · 피참조 `2`) | `main` (`theorem`) | Clozel (1991), Shin (2011) | **유형 II-B**: (`[IsCMField]` 수체 로커스) 편극 첨점 갈루아 표현 존재성으로부터 비분기 국소 성분 완만성 유도 |
| `064` (`L65`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/GelfandInvariantsDetermineMultiset.lean:27-68` (`69`줄 · 피참조 `3`) | `gelfVal_multiset_eq` (`theorem`) | Harish-Chandra (1958), Gelfand | **유형 II-A**: 보편포락대수 겔판트 중심 불변량에 의한 무한소 지표 중복집합 결정 |
| `065` (`L66`) | `Development/AbelianVarietyTheory/Proofs/GlobalInterpolation/WeylModuleSimpleClosedLowestAlcove.lean:33-49` (`50`줄 · 피참조 `4`) | `inducedSimpleLowestAlcove` (`theorem`) | Jantzen (1987) | **유형 I**: 최저 알코브 닫힌 영역 내부 가중치에서 바일 유도 가군의 단순성 |
| `066` (`L67`) | `Development/AbelianVarietyTheory/Proofs/IwasawaDecomposition/GlobalArtinReciprocityHolds.lean:5` (`5`줄 · 피참조 `50`) | `GlobalTheory.globalArtinReciprocity_holds` (`theorem`) | Artin (1927), Chevalley (1940) | **유형 I**: 수체 이델 유군과 최대 아벨 갈루아 군의 대역 아르틴 상호법칙 증인 |
| `067` (`L68`) | `Development/AbelianVarietyTheory/Proofs/InertiaEigenvalues/FontaineBcrisBasicTheoremsProof.lean:21-23` (`24`줄 · 피참조 `5`) | `fontaineBcris` (`theorem`) | Fontaine (1982-1994), Colmez-Fontaine (2000) | **유형 I**: 대수적 닫힌 체 텐서 단사성으로부터 $B_{\mathrm{cris}}$ 기본 완전열 증명 |
| `068` (`L69`) | `Development/AbelianVarietyTheory/Proofs/InertiaEigenvalues/ChebotarevDegreeOne.lean:66-68` (`71`줄 · 피참조 `73`) | `cheb_holds` (`theorem`) | Tschebotareff (1926) | **유형 I**: 차수 1 프로베니우스 소수 조밀성 및 유한 생성 표본 Cheb 증인 |
| `069` (`L70`) | `Development/AbelianVarietyTheory/Proofs/InertiaEigenvalues/ExistsContractNeZero.lean:138-142` (`145`줄 · 피참조 `15`) | `depthZeroSupport` (`theorem`) | Moy-Prasad (1996), Dat | **유형 I**: 깊이 0 기약 표현의 초첨점 지지 및 제1합동 고정 벡터 보존 증명 |
| `070` (`L71`) | `Development/AbelianVarietyTheory/Proofs/InertiaEigenvalues/ImportsTerAlt.lean:14-56` (`59`줄 · 피참조 `3`) | `main` (`theorem`) | Moy-Prasad (1996), Bushnell-Henniart | **유형 II-B**: 깊이 0 표현의 야생 분기 관성 작용 제어 보조 정리 |
| `071` (`L72`) | `Development/AbelianVarietyTheory/Proofs/InertiaEigenvalues/BrauerDegreeZero.lean:203-216` (`219`줄 · 피참조 `4`) | `brauerDegreeZero` (`theorem`) | Brauer (1947) | **유형 I**: 유한군 지표환에서 차수 0 가상 지표의 1차원 유도 지표 정수 결합 |
| `072` (`L73`) | `Development/AbelianVarietyTheory/Proofs/InertiaEigenvalues/ChevalleyUnits.lean:174-182` (`182`줄 · 피참조 `49`) | `GlobalTheory.Published.chevalleyUnits'` (`theorem`) | Chevalley (1951) | **유형 I**: 수체 전역 단수군 $(\mathcal{O}_E)^\times$에서 모든 유한 자리 합동 조건이 함의하는 $m$-거듭제곱 판정 정리 증인 |
| `073` (`L74`) | `Development/AbelianVarietyTheory/Proofs/InertiaEigenvalues/FixedNeBotOfIsSubquotient.lean:64-82` (`85`줄 · 피참조 `14`) | `depthZeroInduction` (`theorem`) | Moy-Prasad (1994-1996), Morris | **유형 I**: 깊이 0 초첨점 표현의 파라호릭 유한 가약군 첨점 컴팩트 유도 |
| `074` (`L75`) | `Development/AbelianVarietyTheory/Proofs/InertiaEigenvalues/LocalLanglandsOfHyp.lean:22-49` (`50`줄 · 피참조 `24`) | `localLanglandsGL_of_depthZero_zelevinsky_bernstein` (`theorem`) | Harris-Taylor (2001), Henniart (2000) | **유형 I**: 깊이 0·젤레빈스키·브라우어·국소 역정리로부터 국소 랑글란즈 도출 |
| `075` (`L76`) | `Development/AbelianVarietyTheory/Proofs/InertiaEigenvalues/BhattScholzeCoefficientsOfPadicIntLattices.lean:98-165` (`166`줄 · 피참조 `5`) | `bhattScholze_coeff` (`theorem`) | Bhatt-Morrow-Scholze (2018), BS (2019) | **유형 II-A**: (`LocPrime`·`LocAinf`·`LocTied` 주기환 구조체) 정수 $A_{\mathrm{inf}}$ 실현으로부터 임의 유한 확장 계수 결정 격자 도출 |
| `076` (`L77`) | `Development/AbelianVarietyTheory/Proofs/InertiaEigenvalues/HeckeLAdicCharacterAboveOfPublished.lean:14-23` (`26`줄 · 피참조 `4`) | `heckeLAdicCharacterAbove_of_potSemistable` (`theorem`) | Serre (1968), Fontaine | **유형 II-A**: (`LocPrime`·`LocTied`·`LocBridge` 주기환 브리지) 잠재적 준안정성과 드람 성질로부터 l 위 헤케 지표 호지-테이트 도출 |
| `077` (`L78`) | `Development/AbelianVarietyTheory/Proofs/InertiaEigenvalues/UnramifiedOrthogonalityHolds.lean:7-9` (`10`줄 · 피참조 `2`) | `unramifiedOrthogonality_holds` (`theorem`) | Tate (1962), Milne (1986) | **유형 I**: 비분기 갈루아 코호몰로지 $H^1_{\mathrm{ur}}$ 부분공간의 테이트 쌍대 등방성 |
| `078` (`L79`) | `Development/AbelianVarietyTheory/Proofs/InertiaEigenvalues/BhattScholzeIntegral.lean:14-33` (`34`줄 · 피참조 `2`) | `bhattScholzeIntegral` (`theorem`) | Bhatt-Morrow-Scholze (2018) | **유형 II-A**: (`LocPrime`·`LocAinf` 주기환 구조체) 결정 갈루아 표현 $\mathbb{Z}_\ell$ 격자의 $A_{\mathrm{inf}}$ 브뢰유-키신-파르그 가군 실현 |
| `079` (`L80`) | `Development/AbelianVarietyTheory/Proofs/InertiaEigenvalues/DeRhamPotentiallySemistable.lean:11-13` (`14`줄 · 피참조 `5`) | `deRham_potentiallySemistable` (`theorem`) | Berger (2002), André, Kedlaya, Mebkhout | **유형 II-A**: (`LocPrime`·`LocTied`·`LocBridge` 주기환 브리지) p-진 드람 갈루아 표현의 잠재적 준안정성 단자 정리 증인 |
| `080` (`L81`) | `Development/AbelianVarietyTheory/Proofs/TwistedOperators/GeometricLemmaOfFiltration.lean:8-13` (`14`줄 · 피참조 `15`) | `geometricLemma_of_filtration` (`theorem`) | Bernstein-Zelevinsky (1977) | **유형 I**: 유한 길이 성질과 여과열로부터 번스타인-젤레빈스키 기하 보조정리 도출 |
| `092` (`L93`) | `Development/AbelianVarietyTheory/Proofs/InertiaEigenvalues/LocalLanglandsExtensionInjective.lean:64-67` (`70`줄 · 피참조 `3`) | `lpTw_injective` (`theorem`) | Zelevinsky (1980), Rodier (1982) | **유형 I**: 랑글란즈 분류 매개변수 연장의 단사성 및 뒤틀림 기약성 보존 |
| `093` (`L94`) | `Development/AbelianVarietyTheory/Proofs/InertiaEigenvalues/LocalLanglandsExtensionCharacterTwist.lean:28-41` (`44`줄 · 피참조 `6`) | `hasCentralChar_ofChar` (`theorem`) | Harris-Taylor (2001) | **유형 I**: 베유-들리뉴 표현 지표 뒤틀림 가환성 및 1차원 중심 지표 보조정리 |
| `094` (`L95`) | `Development/AbelianVarietyTheory/Proofs/InertiaEigenvalues/LocalLanglandsExtensionCentralCharacter.lean:16-23` (`24`줄 · 피참조 `5`) | `prod_roots_prod_of_monic` (`theorem`) | Harris-Taylor (2001) | **유형 I**: 모닉 특성다항식 근 곱과 중심 지표 일치를 잇는 대수 보조정리 |
| `095` (`L96`) | `Development/AbelianVarietyTheory/Proofs/InertiaEigenvalues/LocalLanglandsExtensionRankinSelberg.lean:43-50` (`51`줄 · 피참조 `3`) | `map_summand_dual` (`theorem`) | JPSS (1983), Shahidi | **유형 I**: 랑글란즈 합 표현의 랭킨-셀베르그 쌍대 직합원 및 지수 이동 보존 |
| `096` (`L97`) | `Development/AbelianVarietyTheory/Proofs/InertiaEigenvalues/SubquotientOfProductOfSupport.lean:13-31` (`32`줄 · 피참조 `5`) | `isSubquotient_prodIrr_of_hasSupport` (`theorem`) | Bernstein-Zelevinsky (1977) | **유형 I**: 초첨점 지지를 갖는 기약 표현이 유도곱의 부분몫으로 실현됨을 증명 |
| `097` (`L98`) | `Development/AbelianVarietyTheory/Proofs/InertiaEigenvalues/CuspidalEqUnitaryTwist.lean:19-47` (`48`줄 · 피참조 `2`) | `main` (`theorem`) | Bernstein-Zelevinsky (1977) | **유형 I**: 초첨점 기약 표현의 중심 지표 정규화에 의한 유니터리 비틀림 분해 |
| `098` (`L99`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/BlockUnipotentMemUpperUnipotent.lean:31-36` (`37`줄 · 피참조 `4`) | `superDiag_mul_unip` (`theorem`) | 기초 행렬군 보조정리 | **조립·어댑터**: 상삼각 블록 단멱원소의 초대각선 합 가법성 보조정리 |
| `099` (`L100`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/InvariantIntegralVanishesIwahori.lean:53-71` (`72`줄 · 피참조 `2`) | `main` (`theorem`) | Borel (1976), Casselman (1980) | **유형 I**: 이와호리 단위 세포 지시함수 위 불변 적분 소멸 기준 |
| `100` (`L101`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/ParabolicBlockDecompositionEmbed.lean:44-51` (`52`줄 · 피참조 `2`) | `main` (`theorem`) | 기초 대수군 보조정리 | **조립·어댑터**: 가환환 위 일반선형군의 포물선 레비·단멱 블록 매장 항등식 |
| `101` (`L102`) | `Development/AbelianVarietyTheory/Proofs/DivisorProofs/ExistsBoxSubsetOfMemNhdsZero.lean:58-118` (`119`줄 · 피참조 `3`) | `one_add_small_near_one` (`theorem`) | 기초 비아르키메데스 위상 보조정리 | **조립·어댑터**: 영 근방 열린집합 내 아딕 상자 포함 및 1 근방 원소 분해 |

### 6.4 제4군: `Development.AutomorphicSpectrum` 보형 스펙트럼·린니크·CM 모듈 (`5`개)

$\mathrm{GL}_n(\mathbb{A})$ 지겔 영역 첨점 급감소, 복소곱셈 타원곡선 $j$-불변량 갈루아 작용, 포물선 기하 보조정리, 하리시-찬드라 행렬계수 실해석성, 린니크 영점 밀도 적분을 공급하는 `5`개 모듈입니다.

| 순번 (`임포트 행`) | `src/` 기준 모듈 경로 및 대표 선언 핀 (`줄 수` · `피참조`) | 대표 선언명 (`종류`) | 대응 고전 원전 및 역할 | 동치성 판정 및 원문 포렌식 요지 |
| :--- | :--- | :--- | :--- | :--- |
| `112` (`L113`) | `Development/AutomorphicSpectrum/Proofs/BlockDecomposition/CuspRapidDecaySiegelGL.lean:30-32` (`33`줄 · 피참조 `23`) | `cuspFormsBoundedGL` (`theorem`) | Godement, Borel-Jacquet (1979) | **유형 II-B**: (`[IsTotallyComplex]` 수체 로커스) 수체 위 $\mathrm{GL}_n$ 지겔 영역 첨점 형식 급감소 및 유계성 증명 |
| `113` (`L114`) | `Development/AutomorphicSpectrum/Proofs/GlobalProofs/ComplexMultiplicationJacquetShalika.lean:91-108` (`109`줄 · 피참조 `5`) | `complexMultiplicationJ` (`theorem`) | Shimura (1971) | **유형 II-B**: (`[IsTotallyComplex]` 수체 로커스) CM 타원곡선 격자 자기준동형환과 j-불변량 갈루아 작용 증명 |
| `114` (`L115`) | `Development/AutomorphicSpectrum/Proofs/GlobalProofs/GeometricLemma.lean:8-20` (`21`줄 · 피참조 `30`) | `geometricLemma` (`theorem`) | Bernstein-Zelevinsky (1977) | **유형 I**: 포물선 유도-자케 제한 기하 보조정리 대역 연결 래퍼 |
| `115` (`L116`) | `Development/AutomorphicSpectrum/Proofs/GlobalProofs/AdmissibleOfIwasawaDecomposition.lean:172-174` (`177`줄 · 피참조 `3`) | `harishChandra_analyticity_density` (`theorem`) | Harish-Chandra (1953-1954) | **유형 II-A**: 이와사와 분해 기반 허용 행렬계수 실해석성 및 레비 조밀성 증명 |
| `147` (`L154`) | `Development/AutomorphicSpectrum/PublishedTheorems/PublishedGlobalResults/InvLogIntervalIntegrable.lean:135-140` (`143`줄 · 피참조 `2`) | `linnik` (`theorem`) | Linnik (1944) | **유형 I**: 로그 역수 적분 가능성 및 영점 밀도 지수에 의한 린니크 보조 증인 |

### 6.5 제5군: `Development.WeilBound` 고전 대정리 증인·국소 표현론·세타 리프트 모듈 (`70`개)

자케-샬리카 강성, 번스타인 유니터리 유도곱 기약성, 타디치 일반적 유니터리 쌍대, 카셀만-왈라흐 완비화, 히로나카 특이점 해소, 푸아투-테이트 9항 완전열, 지겔-베유 정규화 및 세타 적분 국소 매칭(`TheoremKOfMod`)을 종결하는 `70`개 모듈(`CoreStatements` `57`개 + `RepresentationTheoryGL` `12`개 + `ThetaLifts` `1`개)입니다.

| 순번 (`임포트 행`) | `src/` 기준 모듈 경로 및 대표 선언 핀 (`줄 수` · `피참조`) | 대표 선언명 (`종류`) | 대응 고전 원전 및 역할 | 동치성 판정 및 원문 포렌식 요지 |
| :--- | :--- | :--- | :--- | :--- |
| `084` (`L85`) | `Development/WeilBound/CoreStatements/AutomorphicKernels/DepthZeroCuspidal/WhittakerSupportTildeOf.lean:231-237` (`240`줄 · 피참조 `3`) | `whittaker_support_tilde` (`theorem`) | Bernstein-Zelevinsky (1976), Bushnell-Kutzko | **유형 I**: 깊이 0 초첨점 표현의 반자기동형 쌍대 휘태커 지지 보존 |
| `086` (`L87`) | `Development/WeilBound/CoreStatements/AutomorphicKernels/DepthZeroCuspidal/IsTateEpsUnramTwist.lean:49-53` (`56`줄 · 피참조 `3`) | `TwPow` (`def`) | Tate (1979), Deligne (1973) | **유형 I**: 국소 테이트 엡실론 인자의 비분기 지표 뒤틀림 변환 공식 |
| `087` (`L88`) | `Development/WeilBound/RepresentationTheoryGL/GaloisPermutationReps/SubquotientEquivalence/CechDescentTests/SubquotientNontrivial.lean:54-80` (`85`줄 · 피참조 `2`) | `main` (`theorem`) | Bernstein-Zelevinsky (1977) | **유형 I**: 비아르키메데스 국소체 $\mathrm{GL}_m$ 비분기 주계열 부분몫의 비자명성 |
| `088` (`L89`) | `Development/WeilBound/CoreStatements/AutomorphicKernels/DepthZeroCuspidal/IsArtinCond.lean:24-41` (`44`줄 · 피참조 `2`) | `IsArtinCond` (`structure`) | Artin (1931), Swan | **유형 I**: 베유-들리뉴 표현의 국소 아르틴 도체 지수 공리 구조체 정의 |
| `089` (`L90`) | `Development/WeilBound/RepresentationTheoryGL/GaloisPermutationReps/SubquotientEquivalence/DepthZeroIntermediateHolds.lean:17-18` (`19`줄 · 피참조 `3`) | `depth_zero_count_holds` (`theorem`) | Moy-Prasad (1996) | **유형 II-B**: 깊이 0 중간 파라호릭 유도 부분몫 동치 및 개수 계산 증인 |
| `116` (`L117`) | `Development/WeilBound/CoreStatements/HodgeTatePoints/ZarTop.lean:6-8` (`9`줄 · 피참조 `2`) | `zarhin` (`theorem`) | Zarhin (1974) | **유형 I**: 쌍대 아벨 스킴을 결합해 4제곱 곱 주편극을 만드는 자르힌 정리 |
| `117` (`L118`) | `Development/WeilBound/CoreStatements/PublishedTheorems/CasselmanWallach/FinalB.lean:8-9` (`10`줄 · 피참조 `2`) | `casselmanWallach` (`theorem`) | Casselman (1989), Wallach (1992) | **유형 II-A**: 부정부호 유니터리 군 $(\mathfrak{g},K)$-가군의 매끄러운 프레셰 완비화 증인 |
| `118` (`L119`) | `Development/WeilBound/CoreStatements/PublishedTheorems/FiniteGLInvariants/AffineLieInvariants/Imports.lean:6-7` (`7`줄 · 피참조 `20`) | `CuspFormAutomorphicBounds.automorphicFormsFiniteGL` (`theorem`) | Harish-Chandra (1968), Borel-Jacquet (1979) | **유형 II-B**: (`[IsTotallyComplex]` 수체 로커스) 고정 레벨·무한소 지표 $\mathrm{GL}_n$ 보형 형식 공간의 유한차원성 증인 |
| `119` (`L120`) | `Development/WeilBound/CoreStatements/PublishedTheorems/ClozelPurity/Bridge.lean:6-8` (`9`줄 · 피참조 `2`) | `clozelPurity` (`theorem`) | Clozel (1990), Shin (2011), Caraiani (2012) | **유형 II-B**: (`[IsCMField]` 수체 로커스) 코호몰로지 첨점 표현의 비분기 사타케 순수성 브리지 증인 |
| `120` (`L121`) | `Development/WeilBound/CoreStatements/PublishedTheorems/PolarizedGaloisRepresentations/GaloisRepOfPolarizedPairLit.lean:5-6` (`7`줄 · 피참조 `4`) | `GaloisRepOfPolarizedPairLit` (`def`) | CHT (2008), Shin (2011), BLGGT (2014) | **유형 I**: 편극 보형 쌍의 갈루아 표현 존재성 명세 별칭 정의 |
| `121` (`L122`) | `Development/WeilBound/CoreStatements/PublishedTheorems/GlobalEulerCharacteristic/GlobalEulerCharOfLemmaX.lean:13-15` (`16`줄 · 피참조 `2`) | `globalEulerChar_full` (`theorem`) | Tate (1962), Milne (1986) | **유형 I**: 수체 제한 분기 갈루아 코호몰로지 대역 오일러 지표 공식 증명 |
| `122` (`L123`) | `Development/WeilBound/CoreStatements/PublishedTheorems/GlobalFiniteness/GlobalFiniteness.lean:10-22` (`23`줄 · 피참조 `2`) | `globalFiniteness` (`theorem`) | Tate (1962), Serre (1964) | **유형 II-B**: (`l ≠ 2` 홀수 소수 로커스) 수체 S-정수환 제한 분기 갈루아 코호몰로지 군 유한성 증명 |
| `123` (`L124`) | `Development/WeilBound/CoreStatements/PublishedTheorems/JacquetShalikaRigidity/JacquetShalikaRigidity.lean:15-16` (`17`줄 · 피참조 `33`) | `jacquetShalika` (`theorem`) | Jacquet-Shalika (1981) | **유형 II-B**: (`[IsTotallyComplex]` 수체 로커스) 랭킨-셀베르그 극점 판정으로 등압 강한 중복도 1 및 사타케 상한 증명 |
| `124` (`L125`) | `Development/WeilBound/CoreStatements/PublishedTheorems/SmoothVectorEstimates/CuspidalMultiplicityOne.lean:7-8` (`9`줄 · 피참조 `5`) | `cuspidalMultiplicityOne` (`theorem`) | Shalika (1974), Piatetski-Shapiro (1979) | **유형 II-B**: (`[IsTotallyComplex]` 수체 로커스) 푸리에-휘태커 전개 유일성에 의한 $\mathrm{GL}_n$ 첨점 중복도 1 증인 |
| `125` (`L126`) | `Development/WeilBound/CoreStatements/PublishedTheorems/NefNumerics/NefRiemannRoch/NefLineBundleNumericalTheoremsProof.lean:11-13` (`14`줄 · 피참조 `6`) | `nefNumerics_outright` (`theorem`) | Kleiman (1966) | **유형 I**: 수치적 양수(nef) 선다발의 클라이먼 교차수 비음수성 증인 |
| `126` (`L127`) | `Development/WeilBound/CoreStatements/PublishedTheorems/PoitouTateDuality/PoitouTateNineTerm/PoitouTateNormalisedHolds.lean:18-20` (`21`줄 · 피참조 `2`) | `poitouTateNormalised_holds` (`theorem`) | Poitou (1967), Tate (1962) | **유형 II-B**: (`l ≠ 2 ∨ [IsTotallyComplex]` 로커스) 수체 갈루아 코호몰로지의 정규화 푸아투-테이트 9항 완전열 증인 |
| `127` (`L128`) | `Development/WeilBound/CoreStatements/AutomorphicKernels/DeligneRibet/DeligneRibetHolds.lean:3-4` (`4`줄 · 피참조 `2`) | `PositivityTheory.PfDR.deligneRibet_holds` (`theorem`) | Deligne-Ribet (1980) | **유형 I**: 완전 실수체 부분 제타 특수값 합동 및 p-진 보간 증인 |
| `128` (`L129`) | `Development/WeilBound/CoreStatements/AutomorphicKernels/DualAbelianScheme/AbelianDeRhamDuality/AbelianDeRhamDuality.lean:20-24` (`25`줄 · 피참조 `2`) | `abelianDeRham` (`theorem`) | Grothendieck (1966), Oda (1969) | **유형 I**: 아벨 스킴 상대 드람 코호몰로지 국소 자유성·호지·쌍대성 증인 |
| `129` (`L130`) | `Development/WeilBound/CoreStatements/AutomorphicKernels/LanglandsExhaustion/LanglandsMultisegmentsOfSeg.lean:16-18` (`19`줄 · 피참조 `5`) | `langlandsMultisegments_of_seg` (`theorem`) | Zelevinsky (1980), Rodier (1982) | **유형 I**: 세그먼트 표현으로부터 유일 기약 몫·소진성·다중세그먼트 분류 도출 |
| `130` (`L131`) | `Development/WeilBound/CoreStatements/AutomorphicKernels/LanglandsExhaustion/EssSquareIntegrableSegmentsOfSeg.lean:10-19` (`20`줄 · 피참조 `3`) | `essSquareIntegrableSegments_of_seg` (`theorem`) | Zelevinsky (1980) | **유형 I**: 세그먼트 표현으로부터 중심 뒤틀림 제곱적분가능 표현 분류 도출 |
| `131` (`L132`) | `Development/WeilBound/CoreStatements/AutomorphicKernels/GrothendieckRingPolynomial/GrothendieckRingPolynomialOfSeg.lean:8-13` (`14`줄 · 피참조 `7`) | `grothendieckRingPolynomial_of_seg` (`theorem`) | Zelevinsky (1980) | **유형 I**: 세그먼트 표현으로부터 매끄러운 표현 그로텐디크 환 다항식성 도출 |
| `132` (`L133`) | `Development/WeilBound/CoreStatements/AutomorphicKernels/LocalLanglandsExistence/InstField.lean:83-84` (`87`줄 · 피참조 `2`) | `epsFam` (`def`) | Tate (1950, 1979), Deligne (1973) | **유형 I**: 국소 테이트 측도 정규화 및 국소 엡실론 인자 족 기초 구성 |
| `133` (`L134`) | `Development/WeilBound/CoreStatements/AutomorphicKernels/LocalLanglandsExistence/ExistsPowEqOneOfValuationEqOne.lean:191-375` (`390`줄 · 피참조 `2`) | `main` (`theorem`) | Harris-Taylor (2001), Henniart (2000) | **유형 I**: 단위원 부치 원소 거듭제곱 유한성 및 베유 특성다항식 부분 관계 |
| `134` (`L135`) | `Development/WeilBound/CoreStatements/AutomorphicKernels/LocalLanglandsExistence/ExistsCompletionEquivOfHe.lean:65-93` (`98`줄 · 피참조 `3`) | `exists_completionEquiv_of_he` (`theorem`) | 기초 완비 국소체 보조정리 | **조립·어댑터**: 등거리사상 역함수 연속성 및 관성 차수 1 완비화 동형 구성 |
| `135` (`L136`) | `Development/WeilBound/CoreStatements/AutomorphicKernels/LocalLanglandsExistence/IsTateMeasMulHighlyRamified.lean:81-85` (`103`줄 · 피참조 `2`) | `alphaChar_apply` (`theorem`) | Deligne-Henniart (1981), Jacquet | **유형 I**: 고도 분기 지표 뒤틀림에서 국소 테이트 가우스 합 알파 지표 공식 |
| `136` (`L137`) | `Development/WeilBound/CoreStatements/AutomorphicKernels/LocalLanglandsExistence/ContinuousOfIsSmoothChar.lean:239-244` (`247`줄 · 피참조 `2`) | `isTateMeas_localEpsilon` (`theorem`) | Tate (1950), Deligne (1973) | **유형 I**: 매끄러운 준지표 연속성 및 국소 엡실론 인자의 테이트 측도 정합성 |
| `137` (`L144`) | `Development/WeilBound/CoreStatements/AutomorphicKernels/NadelVanishing/TopNSI.lean:7-9` (`10`줄 · 피참조 `2`) | `nadelVanishingAndNonKltDivisor` (`theorem`) | Nadel (1990), Lazarsfeld (2004) | **유형 I**: 나델 승수 이데알 코호몰로지 소멸 및 비-klt 인자 절단 증인 |
| `138` (`L145`) | `Development/WeilBound/CoreStatements/AutomorphicKernels/NadelVanishing/TopPointSep.lean:6-8` (`9`줄 · 피참조 `3`) | `pointSeparationPair` (`theorem`) | Serre (1955), Lazarsfeld (2004) | **유형 I**: 충분히 큰 양수 선다발 거듭제곱의 두 점 분리 단면 존재 증인 |
| `139` (`L146`) | `Development/WeilBound/CoreStatements/AutomorphicKernels/SiegelWeilFormula/SiegelWeilStandard/SiegelWeilStd.lean:8-9` (`10`줄 · 피참조 `4`) | `siegelWeilStd` (`theorem`) | Ichino (2001-2004), GQT (2014) | **유형 II-A**: 표준 가우스-슈바르츠 단면에서의 배가 지겔-베유 정규화 증인 |
| `140` (`L147`) | `Development/WeilBound/CoreStatements/AutomorphicKernels/UnitaryDualGL/GenericUnitaryDual/GenericUnitaryDualGLHolds.lean:53-107` (`110`줄 · 피참조 `7`) | `genericUnitaryDualGL_holds` (`theorem`) | Tadić (1986), Vogan (1986) | **유형 I**: 비퇴화 휘태커 모형을 갖는 $\mathrm{GL}_n$ 일반적 유니터리 쌍대 분류 증명 |
| `141` (`L148`) | `Development/WeilBound/CoreStatements/RegularisedThetaMirabolic/KFiniteCuspForms/CuspSp.lean:85-86` (`86`줄 · 피참조 `3`) | `RfCs.cuspidalSpectrumGL` (`theorem`) | Gelfand-Piatetski-Shapiro (1963), MW | **유형 II-B**: (`[IsTotallyComplex]` 수체 로커스) $\mathrm{GL}_n$ 첨점 $L^2$ 공간의 $K$-유한 매끄러운 대표원 및 스펙트럼 분해 증명 |
| `142` (`L149`) | `Development/WeilBound/CoreStatements/AbelianHeightsDuality/GelfandKazhdanDuality/GelfandKazhdanDualOfHyp.lean:122-129` (`132`줄 · 피참조 `5`) | `gelfandKazhdanDual_of_multiplicityOne` (`theorem`) | Gelfand-Kazhdan (1975) | **유형 II-B**: (`[IsTotallyComplex]` 수체 로커스) 자케-샬리카 강성과 첨점 중복도 1로부터 겔판트-카즈단 전치 쌍대성 도출 |
| `143` (`L150`) | `Development/WeilBound/CoreStatements/AbelianHeightsDuality/PublishedTheoremStatements/BridgesAut.lean:52-55` (`56`줄 · 피참조 `2`) | `siegelKlingenDeligneRibet_of` (`theorem`) | Green (1955), Siegel (1937), Klingen (1962) | **유형 I**: 그린 포물선 계열 및 지겔-클링엔-들리뉴-리벳 결합 브리지 |
| `144` (`L151`) | `Development/WeilBound/CoreStatements/AbelianHeightsDuality/PublishedTheoremStatements/BridgesGeo.lean:16-18` (`19`줄 · 피참조 `2`) | `arDegree_of` (`theorem`) | Faltings (1984), Bost (1996) | **유형 II-A**: 순환 높이 사영과 복소 천 차수로부터 아라켈로프 차수 공식 도출 |
| `145` (`L152`) | `Development/WeilBound/CoreStatements/AbelianHeightsDuality/PublishedTheoremStatements/BridgesMore.lean:54-56` (`57`줄 · 피참조 `6`) | `toroidalChartsForFan_of` (`theorem`) | Müller (1989), Zelevinsky (1980), AMRT | **유형 II-A**: (`D7`·`UJset`·`GrpData` 전용 구조체) 딕스미에-말리아뱅 대각합 부류·젤레빈스키 쌍대환·토로이달 차트 브리지 |
| `146` (`L153`) | `Development/WeilBound/CoreStatements/AbelianHeightsDuality/PublishedTheoremStatements/BridgesRep.lean:15-18` (`19`줄 · 피참조 `2`) | `flathFactorisation_of` (`theorem`) | Flath (1979) | **유형 I**: 제한 텐서곱 유일성과 유니터리 허용성에서 플라스 인수분해 도출 |
| `148` (`L155`) | `Development/WeilBound/CoreStatements/AbelianHeightsDuality/PublishedTheoremStatements/ProvedMore.lean:82-84` (`85`줄 · 피참조 `6`) | `siegelKlingen_holds` (`theorem`) | Shimura-Taniyama (1961), Borel-Casselman | **유형 II-A**: (`UJset`·완전 복소 수체 전용 구조체) 타원 CM 주정리·보렐-카셀만·부분 제타·지겔-클링엔 등 14종 증인 집약 |
| `149` (`L156`) | `Development/WeilBound/CoreStatements/ResolutionCharZero/PlugResK.lean:7-9` (`10`줄 · 피참조 `4`) | `resK` (`theorem`) | Hironaka (1964) | **유형 I**: 표수 0 대수다양체 특이점 해소로부터 아라켈로프 입력 ResK 어댑터 연결 |
| `150` (`L157`) | `Development/WeilBound/CoreStatements/ResolutionCharZero/ResolutionCharZero.lean:6-8` (`9`줄 · 피참조 `2`) | `resolutionCharZero` (`theorem`) | Hironaka (1964) | **유형 I**: 표수 0 대수다양체 매끄러운 특이점 해소 존재성 증인 |
| `151` (`L158`) | `Development/WeilBound/CoreStatements/ResolutionCharZero/PrincipalisationCharZeroClosed.lean:7-9` (`10`줄 · 피참조 `2`) | `principalisationCharZero_closed` (`theorem`) | Hironaka (1964), Bierstone-Milman (1997) | **유형 I**: 표수 0 매끄러운 스킴 위 닫힌 부분스킴 주이데알화 증인 |
| `152` (`L159`) | `Development/WeilBound/CoreStatements/ResolutionCharZero/PrincipalisationClosed.lean:14-39` (`40`줄 · 피참조 `5`) | `principalisation_closed` (`theorem`) | Hironaka (1964), Kollár (2007) | **유형 I**: 사영 매끄러운 스킴 이데알 층의 매끄러운 폭발열 주이데알화 증명 |
| `153` (`L160`) | `Development/WeilBound/CoreStatements/TotallyDisjointProducts/SLGLProductIrreducibility/TdpFill.lean:3-6` (`6`줄 · 피참조 `3`) | `PositivityTheory.SlGl.totallyDisjointProductIrreducible_of_parts` (`theorem`) | Bernstein-Zelevinsky (1977), Zelevinsky (1980) | **유형 I**: 기하 보조정리와 그로텐디크 다항식성으로 초첨점 지지 서로소 기약성 도출 |
| `154` (`L161`) | `Development/WeilBound/CoreStatements/StandardPublishedResults/StandardTheoremStatements/GlobalArtinReciprocity.lean:14-16` (`17`줄 · 피참조 `5`) | `heckeLAdicCharacter` (`theorem`) | Artin (1927), Takagi (1920), Weil (1956) | **유형 I**: 대역 아르틴 상호법칙·광선 유체·대수적 헤케 l-진 지표 표준 증인 |
| `155` (`L162`) | `Development/WeilBound/CoreStatements/StandardPublishedResults/StandardTheoremStatements/RealMetaplecticRepresentation.lean:5-7` (`8`줄 · 피참조 `2`) | `realMetaplecticRepresentation` (`theorem`) | Weil (1964), Kashiwara-Vergne (1978) | **유형 I**: 실수 메타플렉틱 군의 슈뢰딩거·포크 모형 표준 증인 |
| `156` (`L163`) | `Development/WeilBound/CoreStatements/StandardPublishedResults/StandardTheoremStatements/GreenRegularCharacters.lean:5-7` (`8`줄 · 피참조 `3`) | `greenRegularCharacters` (`theorem`) | Green (1955), Deligne-Lusztig (1976) | **유형 I**: 유한 일반선형군 $\mathrm{GL}_n(\mathbb{F}_q)$ 정칙 원환 지표 기약성 표준 증인 |
| `157` (`L164`) | `Development/WeilBound/CoreStatements/StandardPublishedResults/StandardTheoremStatements/HermitianHassePrinciple.lean:18-20` (`21`줄 · 피참조 `2`) | `stoneVonNeumann` (`theorem`) | Landherr (1936), Weil (1965), Mackey (1949) | **유형 II-A**: (`D7` 에르미트 데이텀 구조체) 에르미트 하세 원리·유리 세타 불변성·스톤-폰 노이만 표준 증인 |
| `158` (`L165`) | `Development/WeilBound/CoreStatements/StandardPublishedResults/StandardTheoremStatements/SchurOrthogonalitySquareIntegrable.lean:17-19` (`20`줄 · 피참조 `2`) | `radfordShufflePolynomial` (`theorem`) | Harish-Chandra, Hecke (1920), Radford (1979) | **유형 I**: 슈어 직교성·헤케 부분 연속·에르미트 국소-대역·래드퍼드 셔플 증인 |
| `159` (`L166`) | `Development/WeilBound/CoreStatements/StandardPublishedResults/StandardTheoremStatements/HeckeLEntireAndNonzeroAtOne.lean:21-23` (`24`줄 · 피참조 `2`) | `weylBranching` (`theorem`) | Takagi (1920), Hecke (1920), Weyl (1939) | **유형 I**: 이차 유체론·비자명 헤케 L(1,chi) 비소멸·바일 유니터리 분기 증인 |
| `160` (`L167`) | `Development/WeilBound/CoreStatements/StandardPublishedResults/StandardTheoremStatements/CuspDecaySobolev.lean:11-13` (`14`줄 · 피참조 `2`) | `cuspBounded` (`theorem`) | Harish-Chandra (1968), Borel (1974) | **유형 II-A**: 유니터리 첨점 형식 소볼레프 점별 감쇠 및 유계성 표준 증인 |
| `161` (`L168`) | `Development/WeilBound/CoreStatements/StandardPublishedResults/StandardTheoremStatements/HarishChandraModules.lean:12-14` (`15`줄 · 피참조 `2`) | `greenCuspidal` (`theorem`) | Harish-Chandra (1953), Green (1955) | **유형 II-A**: $U(p,q)$ 피복 $(\mathfrak{g},K)$-가군 동치 및 $\mathrm{GL}_n(\mathbb{F}_q)$ 그린 첨점 지표 증인 |
| `162` (`L169`) | `Development/WeilBound/CoreStatements/TemperedRepresentationTheory/ArakelovCycleHeights/CycleHeightFormulas/CycleHeightsDirect.lean:144-147` (`148`줄 · 피참조 `2`) | `cycleHeights_direct` (`theorem`) | Gillet-Soulé (1990), Bost-Gillet-Soulé (1994) | **유형 II-A**: 푸앵카레-를롱과 특이점 해소로부터 아라켈로프 교차 연산·순환 높이 직접 구성 |
| `163` (`L170`) | `Development/WeilBound/CoreStatements/TemperedRepresentationTheory/BernsteinZelevinskyGL/TopAdm.lean:6-8` (`9`줄 · 피참조 `41`) | `irreducibleAdmissibleGL_top` (`theorem`) | Bernstein (1974), Jacquet (1975) | **유형 I**: 비아르키메데스 $\mathrm{GL}_n$ 기약 매끄러운 표현의 허용성 최상단 증인 |
| `164` (`L171`) | `Development/WeilBound/CoreStatements/TemperedRepresentationTheory/BernsteinZelevinskyGL/TopStd.lean:7-12` (`13`줄 · 피참조 `9`) | `standardFunctorsFiniteLength_top` (`theorem`) | Bernstein-Zelevinsky (1977) | **유형 I**: 포물선 유도 및 자케 제한 함자의 유한 길이 보존 최상단 증인 |
| `165` (`L172`) | `Development/WeilBound/CoreStatements/TemperedRepresentationTheory/ChernDegreeComplex/ChernDegreeComplex.lean:19-52` (`53`줄 · 피참조 `2`) | `chernDegreeComplex` (`theorem`) | Chern (1946), Griffiths-Harris (1978) | **유형 I**: 복소 사영 다양체 에르미트 선다발의 천 곡률 적분 차수 일치 증명 |
| `166` (`L173`) | `Development/WeilBound/CoreStatements/TemperedRepresentationTheory/FormalAlgebraisation/Development.lean:17-23` (`24`줄 · 피참조 `2`) | `formalAlgebraisation` (`theorem`) | Grothendieck (EGA III, 1961) | **유형 I**: 사영 사상 위 형식적 완비화 선다발·단면의 그로텐디크 대수화(GFGA) |
| `167` (`L174`) | `Development/WeilBound/CoreStatements/TemperedRepresentationTheory/GeometricSplitting/Imports.lean:5-6` (`6`줄 · 피참조 `9`) | `PositivityTheory.Geo.geometricLemmaFiltration` (`theorem`) | Bernstein-Zelevinsky (1977) | **유형 I**: 기하적 분해 여과열 정리 임포트 브리지 증인 |
| `168` (`L175`) | `Development/WeilBound/CoreStatements/TemperedRepresentationTheory/MultiplicityOneRigidity/GelfandKazhdanDualOfRigidity.lean:72-79` (`82`줄 · 피참조 `8`) | `gelfandKazhdanDual_of_rigidity` (`theorem`) | Gelfand-Kazhdan (1975), Jacquet-Shalika (1981) | **유형 II-B**: (`[IsTotallyComplex]` 수체 로커스) 자케-샬리카 강성과 유계성만으로 겔판트-카즈단 전치 쌍대성 직접 도출 |
| `169` (`L176`) | `Development/WeilBound/CoreStatements/TemperedRepresentationTheory/NefDivisors/NefRR.lean:14-53` (`54`줄 · 피참조 `2`) | `nefRR` (`theorem`) | Fujita, Lazarsfeld (2004) | **유형 I**: 수치적 양수(nef) 선다발 위 점근 리만-로흐 차원 부등식 증명 |
| `170` (`L177`) | `Development/WeilBound/CoreStatements/TemperedRepresentationTheory/PoincareLelong/PoincareLelongInv.lean:19-24` (`25`줄 · 피참조 `3`) | `poincareLelongInv` (`theorem`) | Lelong (1957), Demailly | **유형 I**: 복소 다양체 유리형 단면의 푸앵카레-를롱 전류 방정식 및 역공식 증인 |
| `171` (`L178`) | `Development/WeilBound/RepresentationTheoryGL/CasimirAlgebra/KugaCoordinates/ClozelCohomological.lean:8-10` (`11`줄 · 피참조 `4`) | `clozelCohomological` (`theorem`) | Clozel (1991), Shin (2011) | **유형 II-B**: (`[IsTotallyComplex]`·`[IsCMField]` 로커스) 쿠가-사토 좌표·휘태커 미분·코체인 접합으로 코호몰로지 갈루아 표현 구성 |
| `172` (`L179`) | `Development/WeilBound/RepresentationTheoryGL/DiscreteSeries/DiscreteSeriesCovers/FdTopB.lean:9-10` (`11`줄 · 피참조 `2`) | `formalDegreeCompactDual` (`theorem`) | Harish-Chandra (1966), Gross-Prasad | **유형 II-A**: 피복군 이산계열 형식 차수와 콤팩트 쌍대군 바일 차수 비례 증인 |
| `173` (`L180`) | `Development/WeilBound/RepresentationTheoryGL/EisensteinSeries/SiegelEisensteinContinuation/EisensteinChartSplitting/SiegelEisensteinContinuation.lean:8-11` (`12`줄 · 피참조 `2`) | `siegelEisensteinContinuation` (`theorem`) | Langlands (1976), Shimura, Tan (1999) | **유형 II-A**: 유니터리 지겔 아이젠슈타인 급수의 유리형 해석적 연속 및 함수방정식 |
| `174` (`L181`) | `Development/WeilBound/RepresentationTheoryGL/EisensteinSeries/SiegelEisensteinHalfPlane/SchwartzBruhatMajorants/SiegelMultOf.lean:101-114` (`115`줄 · 피참조 `8`) | `eisBL` (`theorem`) | Kudla-Rallis (1990-1994), Lapid-Rallis | **유형 II-A**: 슈바르츠-브뤼아 지배를 이용한 배가 경계 아이젠슈타인 급수 EisBL 증인 |
| `175` (`L182`) | `Development/WeilBound/RepresentationTheoryGL/EisensteinSeries/SiegelEisensteinHalfPlane/IntegralUnitCoefficients/CoefND.lean:24-26` (`29`줄 · 피참조 `3`) | `field` (`theorem`) | Kudla-Rallis (1988-1994), Ichino (2004) | **유형 II-A**: 슈뢰딩거 모형 기저에서의 유니터리 지겔-베유 비퇴화 푸리에 계수 일치 |
| `176` (`L183`) | `Development/WeilBound/RepresentationTheoryGL/EisensteinResidues/AnisotropicGlobalForms/DmOfHyp.lean:24-35` (`36`줄 · 피참조 `11`) | `dm_of_two` (`theorem`) | Piatetski-Shapiro-Rallis (1987), LR (2005) | **유형 II-A**: 첨점 급감소와 지겔 아이젠슈타인 연속성으로부터 배가법 제타 적분 DM 도출 |
| `177` (`L184`) | `Development/WeilBound/RepresentationTheoryGL/GenericUnitaryGL/ComplementarySeries/SegmentJacquetSubquotients/SegmentRepresentation.lean:9-13` (`14`줄 · 피참조 `15`) | `segmentRepresentation` (`theorem`) | Zelevinsky (1980) | **유형 I**: 초첨점 세그먼트의 유일 기약 몫 및 자케 부분몫 구조 증인 |
| `178` (`L185`) | `Development/WeilBound/RepresentationTheoryGL/GenericUnitaryGL/GenericUnlinkedGL/GenericUnlinkedGLOfSegRep2.lean:11-15` (`16`줄 · 피참조 `6`) | `genericUnlinkedGL_of_segRep2` (`theorem`) | Zelevinsky (1980) | **유형 I**: 세그먼트 표현으로부터 쌍별 비연결 일반적(generic) 표현 분류 도출 |
| `179` (`L186`) | `Development/WeilBound/RepresentationTheoryGL/ConstantTermFiniteness/CuspidalConstantTerms/FiniteOfCuspOfConstTerm.lean:129-133` (`136`줄 · 피참조 `2`) | `_root_.PositivityTheory.RgHf.harishChandraFinite` (`theorem`) | Harish-Chandra (1968) | **유형 II-A**: 첨점 및 상수항 유한차원성 귀납으로 D7 유니터리 보형 형식 유한차원성 증명 |
| `180` (`L187`) | `Development/WeilBound/RepresentationTheoryGL/UnitaryDualProof/BernsteinExponentBounds/BernAll.lean:27-28` (`29`줄 · 피참조 `3`) | `bernsteinUnitaryProductIrreducible` (`theorem`) | Bernstein (1984) | **유형 I**: 지수 상한 제어를 거쳐 $\mathrm{GL}_r \times \mathrm{GL}_t$ 유니터리 유도곱 기약성 증명 |
| `181` (`L188`) | `Development/WeilBound/ThetaLifts/Reductions/FiniteClosure/TheoremKOfMod.lean:26-28` (`29`줄 · 피참조 `3`) | `theoremK_head2` (`theorem`) | Kudla-Rallis, HKS (1996), Mínguez (2008) | **유형 II-A**: 배가 아이젠슈타인·표준 지겔-베유·하우 쌍대성을 결합해 세타 적분·국소 매칭 도출 |

### 6.6 제6군: `Development.AutomorphicArithmetic` 보형-갈루아 조립·기저변환·최상위 용접 모듈 (`33`개)

아서-클로젤·라베스-신 기저변환, 랄리스 내적 공식, 프리즘 디외도네, 린니크 정리 증인과 함께 `ThirdPlaceSeries` 가설 구조체·공집합 부피 상한(`TopCovolSlim2Use`)·리만 가설 최종 귀결(`RiemannHypothesisOfEveryCharacter`)을 용접하는 `33`개 모듈입니다.

| 순번 (`임포트 행`) | `src/` 기준 모듈 경로 및 대표 선언 핀 (`줄 수` · `피참조`) | 대표 선언명 (`종류`) | 대응 고전 원전 및 역할 | 동치성 판정 및 원문 포렌식 요지 |
| :--- | :--- | :--- | :--- | :--- |
| `082` (`L83`) | `Development/AutomorphicArithmetic/ThetaCorrespondence/AlgebraicCharacters/AlgebraicCharacterWD.lean:9-33` (`33`줄 · 피참조 `4`) | `UpperTheory.Lit.CharWD.algebraicCharacterWD` (`theorem`) | Weil (1956), Tate (1979) | **유형 II-A**: 아르틴 상호법칙과 드람 성질로 대수적 헤케 지표의 베유-들리뉴 일치 증명 |
| `083` (`L84`) | `Development/AutomorphicArithmetic/ThetaCorrespondence/GaloisRepresentations/BlochKatoLocal.lean:3` (`3`줄 · 피참조 `2`) | `UpperTheory.Lit.blochKatoLocal` (`theorem`) | Bloch-Kato (1990) | **유형 II-A**: (`LocPrime`·`LocAinf`·`LocTied` 국소 구조체) 국소 블록-가토 유한 부분공간 $H^1_f$ 정합성 증인 |
| `090` (`L91`) | `Development/AutomorphicArithmetic/ThetaCorrespondence/GaloisRepresentations/GreenbergWiles.lean:3-6` (`6`줄 · 피참조 `2`) | `UpperTheory.Lit.greenbergWiles` (`theorem`) | Greenberg, Wiles (1995) | **유형 II-B**: (`l ≠ 2` 정규화 푸아투-테이트 로커스) 푸아투-테이트 쌍대성과 오일러 지표로부터 그린버그-와일즈 비율 도출 |
| `091` (`L92`) | `Development/AutomorphicArithmetic/ThetaCorrespondence/GaloisRepresentations/HeckeDeRham.lean:3` (`3`줄 · 피참조 `3`) | `UpperTheory.Lit.heckeLAdicCharacterDeRham` (`theorem`) | Serre (1968), Fontaine | **유형 II-A**: (`LocPrime`·`LocBridge` 주기환 브리지) 대수적 헤케 지표 l-진 갈루아 표현의 l 위 드람 성질 증인 |
| `102` (`L103`) | `Development/AutomorphicArithmetic/ThetaCorrespondence/Linnik.lean:142-155` (`156`줄 · 피참조 `2`) | `linnik` (`theorem`) | Linnik (1944) | **유형 I**: 법 $q$ 등차수열 내 최소 소수의 다항식 상한 $p \le C q^L$ 증명 |
| `103` (`L104`) | `Development/AutomorphicArithmetic/ThetaCorrespondence/FockModels/GlnTemp.lean:22-48` (`51`줄 · 피참조 `2`) | `temperedProduct` (`theorem`) | Jacquet (1977), Waldspurger (2003) | **유형 I**: 제곱적분가능 세그먼트들의 유니터리 유도곱에 의한 완만 표현 분류 |
| `104` (`L105`) | `Development/AutomorphicArithmetic/ThetaCorrespondence/FockModels/RallisDM.lean:24-111` (`115`줄 · 피참조 `2`) | `rallis_of_dm` (`theorem`) | Rallis (1984), Li (1992), GQT (2014) | **유형 II-A**: 배가법과 수렴 지겔-베유 공식으로부터 랄리스 내적 공식 증명 |
| `105` (`L106`) | `Development/AutomorphicArithmetic/ThetaCorrespondence/FockModels/FockAnisoFree.lean:17-21` (`22`줄 · 피참조 `5`) | `fockAniso_free` (`theorem`) | Kudla-Rallis (1994), Ichino (2007) | **유형 II-A**: 비등방 포크 모형 자유성 및 유니터리 확장 지겔-베유 증인 |
| `106` (`L107`) | `Development/AutomorphicArithmetic/ThetaCorrespondence/PrismaticDieudonne/PrismaticDieudonneHodge.lean:27-29` (`32`줄 · 피참조 `3`) | `farguesExact` (`theorem`) | Anschütz-Le Bras (2023), Fargues (2010) | **유형 II-B**: 프리즘 디외도네 호지 완전열 및 파르그 HN 여과 완전성 증명 |
| `107` (`L108`) | `Development/AutomorphicArithmetic/ThetaCorrespondence/WeilRepresentation/WeilEx.lean:6-7` (`8`줄 · 피참조 `2`) | `weilRepresentationExists_pair` (`theorem`) | Weil (1964) | **유형 II-A**: 국소·대역 베유 표현 쌍 존재성 증인 래퍼 |
| `108` (`L109`) | `Development/AutomorphicArithmetic/ThetaCorrespondence/WeilRepresentation/WeilTheta.lean:9-11` (`12`줄 · 피참조 `4`) | `weilThetaConvergence` (`theorem`) | Borel-Harish-Chandra (1962), Weil (1965) | **유형 II-A**: 유니터리 지겔 기본영역 피복 및 베유 세타 급수 수렴 증인 |
| `109` (`L110`) | `Development/AutomorphicArithmetic/AutomorphicVarieties/AutomorphicForms/TemperedLocalComponents/PSpecC.lean:19-24` (`24`줄 · 피참조 `2`) | `UpperTheory.V.Af.cuspSpectrumGL` (`theorem`) | Gelfand-Piatetski-Shapiro (1963), Godement | **유형 II-B**: (`[IsTotallyComplex]` 수체 로커스) $\mathrm{GL}_n$ 첨점 스펙트럼 이산 분해 및 중심 지표 법 유계성 묶음 |
| `110` (`L111`) | `Development/AutomorphicArithmetic/Foundations/BaseChangeIdentities/DefiniteNHolds.lean:5-6` (`6`줄 · 피참조 `5`) | `UpperTheory.BaseChangeIdentities.baseChangeN` (`theorem`) | Arthur-Clozel (1989) | **유형 II-A**: 유니터리-CM 문맥에서의 등압 기저변환 존재성 증인 |
| `111` (`L112`) | `Development/AutomorphicArithmetic/Foundations/BaseChangeIdentities/Narrow.lean:73-75` (`78`줄 · 피참조 `9`) | `bridge` (`theorem`) | Labesse (2011), Shin (2014) | **유형 II-B**: 모든 유한 자리 비분기 CM 로커스에서 등압 기저변환으로부터 `DefiniteN` 도출 |
| `182` (`L189`) | `Development/AutomorphicArithmetic/ThetaCorrespondence/FockModels/EveryCharacterE.lean:73-87` (`88`줄 · 피참조 `3`) | `CovE` (`structure`) | 알푀게-Claude 상위 조립기 | **조립·어댑터**: 세타·지겔-베유·국소 랑글란즈·공집합 부피와 VWin을 결합하는 구형 조립기 |
| `183` (`L190`) | `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/HodgeBundleWeights/TopCovolSlim2Use.lean:16-22` (`24`줄 · 피참조 `2`) | `topCovolSlim2_use_alt` (`theorem`) | Faltings-Chai, Moriwaki, Fargues, Zarhin | **조립·어댑터**: 아라켈로프 차우 높이·자르힌·파르그·모리와키 부피에서 공집합 부피 상한 도출 |
| `185` (`L192`) | `Development/AutomorphicArithmetic/CharacterBoxes/RiemannHypothesisOfEveryCharacter.lean:215-231` (`231`줄 · 피참조 `3`) | `UpperTheory.riemannHypothesis_of_everyCharacter` (`theorem`) | 리만 함수방정식·오일러 곱 귀결 | **조립·어댑터**: EveryCharacter(Re(s)>1/2 무영점)와 완성 제타 대칭성으로 RH 최종 도출 |
| `186` (`L193`) | `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/CohomologicalCsdTempered.lean:1` (`1`줄 · 피참조 `2242`) | *(선언 없음: `import Mathlib` 스텁)* | 리팩터링 호환 빈 스텁 (피참조 2242) | **조립·어댑터**: import Mathlib 단일 줄 스텁: 구 가정 허브의 2242개 하위 임포트 보존용 |
| `187` (`L194`) | `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/SiegelEisensteinSecondTermHypotheses.lean:69-73` (`76`줄 · 피참조 `1`) | `every_character_of_theta_integrals_local_matching` (`theorem`) | 알푀게-Claude 제3자리 주조립기 | **조립·어댑터**: 60필드·53필드 가설 번들과 RecTExists·VWin을 결합해 EveryCharacter 최종 도출 |
| `188` (`L195`) | `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/TopCovolSlim2Use.lean:16-22` (`25`줄 · 피참조 `1`) | `topCovolSlim2_use_alt_alt` (`theorem`) | Faltings-Chai, Moriwaki, Fargues, Zarhin | **조립·어댑터**: 제3자리 리팩터링 버전 공집합 부피 상한 CovolumeBoundOfX 조립 정리 |
| `189` (`L196`) | `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/LlOf.lean:18-21` (`25`줄 · 피참조 `3`) | `llOf_alt` (`theorem`) | 리팩터링 시그니처 투영 어댑터 | **조립·어댑터**: 12개 국소·대역 인자 중 제1인자 RecTExists를 그대로 반환하는 호환 투영자 |
| `190` (`L197`) | `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/BernsteinUnitaryProductIrreducible.lean:83-84` (`87`줄 · 피참조 `7`) | `UnitaryGroupThirdPlaceHypotheses.geometricLemma` (`theorem`) | 알푀게-Claude 제3자리 가설 구조체 | **조립·어댑터**: UnitaryGroupThirdPlaceHypotheses(60필드) 및 비엔도스코피 가설 구조체 정의 |
| `191` (`L198`) | `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/LocalRepresentationTheoryHypotheses.lean:33-49` (`52`줄 · 피참조 `6`) | `GlobalAutomorphicGaloisHypotheses'` (`structure`) | 알푀게-Claude 국소·보형 가설 구조체 | **조립·어댑터**: LocalRepresentationTheoryHypothesesAlt(19필드)·보형 갈루아(16필드) 정의 |
| `192` (`L199`) | `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/LitCharCrys.lean:9-12` (`12`줄 · 피참조 `1`) | `UpperTheory.Lit.heckeLAdicCharacterCrystalline_of_deRham` (`theorem`) | Serre (1968), Fontaine | **유형 II-B**: 드람·잠재적 준안정성·베유-들리뉴·RecTExists로부터 헤케 지표 결정성 유도 |
| `193` (`L200`) | `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/WeightsConj.lean:81-82` (`85`줄 · 피참조 `37`) | `mergeP'_alt` (`theorem`) | CHT (2008), Shin (2011) | **유형 II-B**: RecT 기반 갈루아 대응의 켤레 가중치 대칭성 및 편극 첨점 성질 보조정리 |
| `194` (`L201`) | `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/SOfStar.lean:54` (`57`줄 · 피참조 `2`) | `ofDual_star_alt` (`theorem`) | CHT (2008), Caraiani (2012) | **조립·어댑터**: OpenLiteratureStatements의 Row 필드에서 PairUAlt 및 CarUAlt 추출 변환 |
| `195` (`L202`) | `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/HeckeLAdicParameterAbove.lean:13-22` (`25`줄 · 피참조 `6`) | `HeckeLAdicParameterAboveAlt` (`def`) | Serre (1968), Tate (1979) | **유형 II-A**: l 위 자리에서 대수적 헤케 지표 갈루아 매개변수 일치 명세 HeckeLAdicParameterAboveAlt |
| `196` (`L203`) | `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/HeckeLAdicParameterAboveOfAlgebraicCharacterWDAl.lean:10-15` (`17`줄 · 피참조 `2`) | `heckeLAdicParameterAbove_of_algebraicCharacterWD_alt` (`theorem`) | Serre (1968), Tate (1979) | **유형 II-A**: AlgebraicCharacterWD로부터 리팩터링 명세 HeckeLAdicParameterAboveAlt 도출 |
| `197` (`L204`) | `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/SPairs.lean:16` (`18`줄 · 피참조 `5`) | `carU_of_regular_algebraic_purity` (`theorem`) | Gelfand-Kazhdan (1975), CHT (2008) | **조립·어댑터**: 겔판트-카즈단 전치 쌍대성으로 PairUAlt를 CuspUAlt로 변환하는 어댑터 |
| `198` (`L205`) | `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/SOneRow.lean:11-12` (`14`줄 · 피참조 `2`) | `bridgeStar_alt` (`theorem`) | Gelfand-Kazhdan (1975), Caraiani (2012) | **조립·어댑터**: Row->CarUAlt와 PairUAlt->CuspUAlt 두 변환을 묶는 쌍대 브리지 |
| `199` (`L206`) | `Development/AutomorphicArithmetic/Foundations/UnitarySphericalFixing/SatakeParameters/RecT.lean:6` (`6`줄 · 피참조 `5`) | `UpperTheory.One.M.Row` (`def`) | 알푀게-Claude 최상위 인터페이스 별칭 | **조립·어댑터**: IsRecT 기반 갈루아-국소랑글란즈 정합성 명세 UpperTheory.One.M.Row 정의 |
| `200` (`L207`) | `Development/AutomorphicArithmetic/Foundations/LocalLanglands/IsRecTOfIsRec.lean:106-113` (`116`줄 · 피참조 `775`) | `isRecT_of_isRec` (`theorem`) | Bushnell-Henniart (2006), Green (1955) | **유형 II-B**: 지표 및 $Q_g$ 위 깊이 0 비틀림 `GoodCusp` 로커스 특화 국소 랑글란즈 `LawsT` 정의 |
| `201` (`L208`) | `Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/AlLocalGlobalAboveLPstlocalGlobalAboveL.lean:3` (`3`줄 · 피참조 `1`) | `UpperTheory.GalS.CarUAlt.localGlobalAboveL` (`theorem`) | 내부 항등 타입 별칭 브리지 | **조립·어댑터**: CarUAlt 국소-대역 l 위 호환성 사상을 carId에 연결하는 3줄 호환 래퍼 |

### 6.7 인간 수학자의 `150`쪽 단축 논문 집필을 위한 `8`대 유형 II 번역 어댑터 체크리스트

제1장부터 제6장까지의 전수 감사를 종합하면, `201`개 직접 로컬 임포트 중 `92`개(`45.77%`)는 원논문과 1대1로 일치하는 **유형 I**이고 `19`개(`9.45%`)는 내부 조립·어댑터 모듈이며, 나머지 **`90`개(`44.78%`: 유형 II-A `56`개[`27.86%`] + 유형 II-B `34`개[`16.92%`])**가 아카이브 고유 구조체 투영 또는 부분 로커스 특화 명제입니다.
또한 `201`개 직접 임포트와 `1,073`개 `PublishedTheorems` 폴더의 교집합은 정확히 `17`개 모듈(`007`~`011`, `117`~`126`, `147`, `184`번)로서, 이 `17`개 파일이 명세 정의와 최상위 증인을 한 파일에 겸비한 직접 접합점 역할을 수행합니다.

향후 인간 연구자가 하부 `1,315만 줄`의 기출 재증명 코드를 생략하고 표준 출판 문헌 인용만으로 약 `150`쪽 분량의 자립적 수학 논문을 재구성할 때, 반드시 부록 보조정리로 명시·점검해야 할 `8`대 핵심 번역 어댑터($T_{\mathrm{lit}} \implies P_{\mathrm{arch}}$)는 다음 표로 완결 요약됩니다.

| 순번 | 대상 특화 명제군 (`유형`) | 대표 원문 핀 (`src/` 기준) | 인용할 고전 원논문 $T_{\mathrm{lit}}$ | 단축 논문 부록에서 입증할 번역 어댑터 보조정리 요지 |
| :---: | :--- | :--- | :--- | :--- |
| `A1` | `GrpData p q` 실수 표현론 (`유형 II-A`) | `Development/AbelianVarietyTheory/PublishedTheorems/TwistedTraceFormula/HarishChandraModulesOn.lean:24-45` | Harish-Chandra (1953, 1966), Knapp (1986) | $\det^{1/2}$ 2중 피복 $G \subset \mathrm{GL}_{p+q}(\mathbb{C}) \times \mathbb{C}^\times$가 유한 중심 닫힌 행렬 리 군으로서 하리시-찬드라 부류 공리를 만족함 |
| `A2` | `UJset ε` 카셀만-왈라흐 (`유형 II-A`) | `Development/AbelianVarietyTheory/PublishedTheorems/AutomorphicForms₂/HasDRepIffHasDerivAt.lean:98-112` | Casselman (1989), Wallach (1992) | `IsSmoothModRep` 반노름 증가율 $(1 + \mathrm{hs}(g))^N$이 표준 가약군 완만 증가 프레셰 공간 정의와 위상 동치임 |
| `A3` | `D7` 아델 첨점 급감소·유한성 (`유형 II-A`) | `Development/AbelianVarietyTheory/PublishedTheorems/AutomorphicForms₂/ExistsNormLeHeightPow.lean:28-33` | Harish-Chandra (1968), Borel (1974) | `IsExpFam` 미분 단어 지배와 `gelf` 중심 연산자 고윳값 조건이 표준 지겔 영역 $(\mathfrak{g},K)$-보형 형식 정의를 함의함 |
| `A4` | `GoodCusp` 국소 랑글란즈 `IsRecT` (`유형 II-B`) | `Development/AutomorphicArithmetic/Foundations/LocalLanglands/IsRecTOfIsRec.lean:55-81` | Harris-Taylor (2001), Bushnell-Henniart (2006) | 일반 국소 랑글란즈 대응과 깊이 `0` 완만 관성 공식이 `isRecT_of_isRec`(`L106-113`)에 의해 `LawsT` 12개 필드를 충족함 |
| `A5` | 비분기 CM 기저변환 `DefiniteN` (`유형 II-B`) | `Development/AutomorphicArithmetic/Foundations/BaseChangeIdentities/Narrow.lean:28-35` | Labesse (2011), Shin (2014) | 모든 유한 자리 비분기(`IsUnramifiedAt`) CM 확장에서 안정 기저변환이 분할·관성 구형 사타케 조건 `IsBaseChangeU`를 만족함 |
| `A6` | 반수렴 지겔-베유 및 랄리스 내적 (`유형 II-A`) | `Development/AbelianVarietyTheory/PublishedTheorems/SiegelWeil₂/SiegelWeilUnitaryConvergent.lean:18-33` | Ichino (2001, 2004), GQT (2014) | 격자 공집합 부피 `IsCovolOne` 및 쿠들라 분해 지표 $\chi_B$ 정규화 하에서 아이젠슈타인 특수값과 세타 평균 상수가 `1`로 일치함 |
| `A7` | 점 중심 $L^2$-확장 및 단면 GAGA (`유형 II-B`) | `Development/AbelianVarietyTheory/PublishedTheorems/Divisors₂/L2ExtensionLogCanonical.lean:32-55` | Demailly (2015), Serre (1956) | `0`차원 고립 중심 야코비안 잔류 공식의 보편 상수가 $34/\delta \cdot 2^{n+1}\pi^n / \Gamma(n)$ 이하로 유계이며 `LB.Sec`이 대수적 $H^0$와 동형임 |
| `A8` | 프리즘 디외도네 및 정규화 푸아투-테이트 (`유형 II-B`) | `Development/AbelianVarietyTheory/PublishedTheorems/Divisors₂/InjectiveOfSmulMemRange.lean:23-67` | Anschütz-Le Bras (2023), Poitou-Tate (1967) | 일반 프리즘 디외도네 동치가 $\mathrm{Hom}(\underline{\mathbb{Q}_p/\mathbb{Z}_p}, \mu_{p^\infty})$ 전단사성을 포함하며 $\ell \neq 2 \lor F$ 완전 복소 조건에서 실수 자리 오차가 소멸함 |
