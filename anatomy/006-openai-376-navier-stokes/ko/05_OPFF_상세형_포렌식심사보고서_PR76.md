# [Forensic & Referee Audit Report] OpenAI `#376` (`PR #76`: *Incompressible Box Transport and Finite Computation*) 전수 감사 보고서

## 0. 감사 메타데이터 및 암호학적 봉인 원장 (`Provenance & Cryptographic Ledger`)

| 항목 | 세부 내역 |
| :--- | :--- |
| **대상 논문 / 프리프린트** | *Incompressible Box Transport and Finite Computation* (`preprints/Incompressible-Box-Transport-and-Finite-Computation-October-6-2026/`, `build/*.tex` `15`개 섹션 파일 · `5,808`줄, 동반 프리프린트 포함 총 `75`개 `.tex` 파일) |
| **대상 코드 저장소 및 제출 PR** | `openai/math` Family `376` (`1,010`개 `.lean` 파일: `lean/OAI/` `1,004`개 + `lean/ComparatorChallenges/` `6`개) / 제출 PR: [`mathcommunity/oai-math-revised#76`](https://github.com/mathcommunity/oai-math-revised/pull/76) (헤드 커밋 `7bc55b7`) |
| **동반 추론 로그 / 패치** | 추론 로그 PDF **미공개 (`0`편)** / 비교 챌린지 진입점 `6`개 (`ForcedNavierStokesComputation.lean`, `BalancedThreeStack.lean`, `NavierStokesVelocity.lean`, `SheetProgram.lean`, `SolenoidalSheetPrograms.lean`, `UniversalNavierStokes.lean`) |
| **툴체인 및 컴파일러** | `Lean 4 v4.29.0-rc8` (검증 아카이브 표준) / `Python 3.14` (`SymPy` 기호 연산기 및 `PyTorch FP64` 스펙트럼·자동미분 검증) |
| **검증 산출물 SHA-256** | • [`ns376_kinematic_routing_and_forensics.lean`](../proofs/ns376_kinematic_routing_and_forensics.lean): `854de2d59a077144a2383ccf97e7308e4d9b519fa6075d2b7d4f230640a3c973`<br>• [`ns376_gronwall_uniqueness_and_repairs.lean`](../proofs/ns376_gronwall_uniqueness_and_repairs.lean): `5f033b13080ce8f75999daf0a2e9bc89f44ca8fcf6938b74d17ba3c1e4a54450`<br>• [`verify_symbolic_ns376.py`](../proofs/verify_symbolic_ns376.py): `11fc3e83bba66269ccd818d4b7155a9739f628e8ab4bbfd5d9a847eaa5a0d96e` |
| **검증 방식 (`Verification Method`)** | `Case 006` 독립 `Lean 4` 정리 **`45`개 (`0 sorry`, `0 axiom`, `176/176` 가설 변이 사살)** + `Case 007` 미연결 모듈 재조립 정리 **`48`개 (`0 sorry`, `134/134` 변이 사살)** $\implies$ **합계 `93`개 독립 정리 (`310/310` 변이 사살)** |
| **준거 감사 헌장 (`Governing Charter`)** | **Open Proof Forensics Foundation (`OPFF`) 5-Gate Joint International Audit Charter** (`COPE · IMU/AMS · ACM v1.1 · ICMJE/CRediT · NeurIPS`, Charter DOI: [`10.5281/zenodo.24241228`](https://doi.org/10.5281/zenodo.24241228), Ledger v1.0.0 DOI: [`10.5281/zenodo.24241229`](https://doi.org/10.5281/zenodo.24241229)) |
| **OPFF 5대 관문 및 공식 등급 판정** | `Gate 1 (수리·커널): FAIL` · `Gate 2 (원고-코드): FAIL` · `Gate 3 (서지·윤리): FAIL` · `Gate 4 (공정·개입): FAIL` · `Gate 5 (수리 가치): FAIL (재조립 시 HOLD)` $\implies$ **`OPFF TIER F` (즉결 영구 기각 / `Hard Reject`)** |

---

## 제1부. 서지 편중성 및 인용 세탁 감사 (`Bibliographic & Citation Laundering Audit`)

### 1.1 장절별 인용 밀도 기형성 분석 (`build/*.tex` `15`개 섹션 파일, `5,808`줄)

| 원고 구간 | 파일 구성 (`build/*.tex`) | 줄 수 (`비율`) | 인용 유무 및 분포 | 판정 |
| :--- | :--- | :---: | :--- | :---: |
| **인용 존재 섹션 (`4/15`개)** | `introduction.tex` 등 극소수 서두 파일 | `1,178`줄 (`20.3%`) | `references.bib` `22`개 엔트리 중 **`13`개만 `\cite`로 연결** | 서두 편중 |
| **무인용 기술 본문 (`11/15`개)** | `analysis.tex`, `geometry.tex`, `balanced.tex`, `compilers.tex`, `coding-conventions.tex` 등 **`11`개 핵심 증명 섹션** | **`4,630`줄 (`79.7%`)** | **인간 선행 연구 인용 `0`회 (`100%` 무인용)** | **극단적 인용 기근** |
| **참고문헌 미연결 유령 엔트리** | `build/references.bib` (`22`개 키 중 **`9`개 키 미호출**) | `40.9%` 유령 등재 | 본문에서 저자명("Moser's area correction" 등)을 거명하고도 `\cite`를 빠뜨려 PDF 참고문헌에서 누락시킴 | **서지 연결 파산** |

### 1.2 미연결 유령 문헌 `9`건 및 본문 무인용 1차 고전 문헌 `14`건 (`PR #76`에서 복원 완료)

1. **`references.bib`에 넣어두고 본문 `\cite`를 빠뜨린 `9`건 (`40.9%`)**:
   - `Moser1965` (모저 부피보존 미분동형사상, `introduction.tex` 본문 기명 후 미인용), `Nash1958` & `Aronson1968` (`initialization.tex` Remark 8.9 이류-확산 열핵 상하한), `EtnyreGhrist2000` (Reeb-Beltrami 접촉 위상 동치), `Tao2016` (평균 나비에-스토크스 회로 폭발), `CardonaMirandaPeraltaSalas2022`, `CardonaMirandaPeraltaSalasPresas2023`, `CardonaMirandaPeraltaSalas2025FluidComputer`, `Cardona2025Advice`.
2. **기술 증명 본문(`11/15`개 섹션, `4,630`줄)에서 무인용 전유한 필수 1차 고전 문헌 `14`건**:
   | 원고 위치 (`파일:절`) | 무인용 차용된 고전 수리물리·계산이론 정리 | 원고 기존 인용 | 복원 필수 1차 문헌 (DOI) |
   | :--- | :--- | :---: | :--- |
   | `Section 2` (`analysis.tex`, Lemma 2.1 & Prop 2.4) | $L^2(\mathbb{R}^3)$ 무발산-기울기 직교 분해($\langle w, \nabla p\rangle = 0$) 및 평탄 토러스 르레이-헬름홀츠 사영 $P = I - \nabla\Delta^{-1}\operatorname{div}$ | **`0`건** | von Helmholtz (1858, `10.1515/crll.1858.55.25`), Weyl (1940), Constantin-Foias (1988), Galdi (2011) |
   | `Section 2` (`analysis.tex`, Lemma 2.2) | 점별 에너지 미분부등식 $\frac{1}{2}\frac{d}{dt}\|w\|_2^2 + \nu\|\nabla w\|_2^2 \le \|\nabla U\|_{\infty,\mathrm{op}}\|w\|_2^2$ 및 적분인자 유일성 | **`0`건** | Gronwall (1919, `10.2307/1967124`) |
   | `Section 3.1` (`geometry.tex`, Lemma 3.1) | 서로소 블록 위의 국소 부피보존 운동을 콤팩트 지지 무발산 벡터장으로 확장 | **`0`건** | Krygin (1971, `10.1007/BF01076419`) |
   | `Section 4` (`balanced.tex`, Thm 4.1) & `Section 5.1` (`compilers.tex`, Lemma 5.1) | 2스택/3스택 테이프 시뮬레이션 $(L,R,J)$ 및 가역 부분 전이표의 국소 단사 역조건 | **`0`건** | Minsky (1961, 1967, `10.2307/1970290`), Axelsen-Glück (2011), Morita (2017) |
   | `Section 6.2` (`coding-conventions.tex`, Lemma 6.2) | 홀수 자릿수 간격 진법-$B$ 칸토어 스택 인코딩 및 닫힌 기호 실린더 직사각형 분리 | **`0`건** | Koiran-Cosnard-Garzon (1994), Siegelmann-Sontag (1995) |
   | `Section 1.2` (`introduction.tex`) | 유효 매끄러운 장, 유리수 오차 혼합 미분 계산 및 계산 가능 점성 계수 $\nu > 0$ | **`0`건** | Pour-El-Richards (1989), Weihrauch (2000) |

---

## 제2부. 사후 인용 조작 및 생성 기록 은닉 (`Post-hoc Fabrication & Log Concealment`)

1. **추론 로그(`Reasoning Trace`) 전면 비공개 (`0`편)**:
   - OpenAI는 `#376`에 대해 프리프린트와 `1,010`개 `.lean` 파일만 살포하고, 어떻게 영압력 역산 외력과 선형 전단 유동 설정으로 흘러갔는지를 보여주는 추론 로그와 초기 프롬프트를 전량 비공개 처리함.
2. **챌린지 파일 복제 및 내부 네임스페이스 스터핑(`Spec Stuffing`)**:
   - `ComparatorChallenges/ForcedNavierStokesComputation.lean`은 `BalancedThreeStack.lean`의 **모든 `38`개 정의와 주정리를 토씨 하나 바꾸지 않고 100% 그대로 복제**하여 별개 챌린지인 것처럼 부풀림([`ns376_challenge_clone_module_identity`](../proofs/ns376_kinematic_routing_and_forensics.lean#L295)).
   - `ComparatorChallenges/NavierStokesVelocity.lean`은 단일 명세 파일 안에 **`48`개의 내부 구현 네임스페이스를 통째로 우겨넣어(`Spec Stuffing`)** 명세와 증명의 경계를 무너뜨림([`ns376_velocity_challenge_spec_stuffing_ratio`](../proofs/ns376_kinematic_routing_and_forensics.lean#L319)).

---

## 제3부. 패치워크 모자이크 및 미해소 `sorry` 은폐 (`Patchwriting & Unresolved Sorry Forensics`)

1. **비교 챌린지 내부 미해소 `sorry` 잔존 적발 (`CP-01` 직접 위반)**:
   - `ComparatorChallenges/NavierStokesVelocity.lean:454`의 `VelocityDetection.TapeCodes.half` 선언부에 **미완성 `sorry`가 제거되지 않은 채 그대로 남아 있음**이 적발됨(정작 내부 모듈인 `OAI/VelocityDetection/TapeCodes.lean:32-33`에는 증명이 존재함에도, 챌린지 파일에 복제·병합하는 과정에서 `sorry` 스텁을 방치함).
2. **다세대 폴더 분열 및 미완성 브리지 방치**:
   - `OAI/` 산하에 `BoxTransport/`, `BalancedTransport/`, `VelocityDetection/`, `SheetProgram/`, `ForcedComputation/` 등 서로 다른 시기에 생성된 하위 아키텍처들이 통합되지 않은 채 파편화되어 방치됨.

---

## 제4부. 증명 도달성 층서학 및 대규모 미연결 모듈 감사 (`Stratigraphy & Reachability Audit`)

### 4.1 저장소 도달성 분할 (`1,004`개 `OAI/` 모듈 기준)

| 구분 | 파일 수 (`비율`) | 코드 줄 수 | 주요 구성 파일 및 성격 |
| :--- | :---: | :---: | :--- |
| **활성 증명 콘 (`Active Cone`)** | `354`개 (`35.3%`) | 활성 코어 | `6`개 `ComparatorChallenges/*.lean` 진입점이 실제 직·간접 임포트하는 모듈 |
| **미도달 유령 모듈 (`Unimported Ghost Files`)** | **`650`개 (`64.7%`)** | **`73,367`줄** | **`ForcedComputation/` `576`개 파일 전량** 및 무발산 압력 복원 모듈(`Solenoidal.lean`)을 포함해 최종 챌린지와 완전히 단절된 유령 모듈군 |
| **전체 `OAI/` 합계** | `1,004`개 (`100%`) | `1,010`개 (챌린지 6개 포함) | 전체 모듈의 약 **3분의 2(`64.7%`)가 주정리와 연결되지 않은 유령 코드** |

---

## 제5부. 원고-코드 중대 괴리 및 증명 전제 무결성 감사 (`Bait-and-Switch & Premise Integrity Audit`)

### 5.1 원고 본문 대 실제 활성 코드의 구조적 스위치 (`Bait-and-Switch Matrix`)

| 불일치 축 | 원고(`manuscript.pdf`) 주장 | 실제 저장소(`Lean 4`) 활성 코드 상태 | 심각도 |
| :--- | :--- | :--- | :---: |
| **1. 역산 외력 주입 (`Manufactured Forcing`) 및 영압력($p=0$)** | 3차원 비압축성 강제 나비에-스토크스 유동의 보편 튜링 계산 | `BalancedTransport/BoxCoding.lean` 등에서 압력을 **`p = 0`으로 고정**한 뒤, 원하는 속도장 $U$를 먼저 정하고 **외력을 $f := \partial_t U + (U\cdot\nabla)U - \nu\Delta U = f_0 + \nu f_1$로 역산 정의**하여 `abel` 항등식(`res_U - f = 0`)으로 운동방정식을 자명하게 통과시킴 ([`ns376_manufactured_force_abel_identity`](../proofs/ns376_kinematic_routing_and_forensics.lean#L18)) | **치명적 (`CP-02` 정의 조작)** |
| **2. 비선형 이류항 소거 (`advection = 0`)** | 3차원 비선형 유체역학의 보편 계산성 | `SheetProgram.lean:28` 및 단방향 전단 시트(`unidirectional shear sheets`)에서 **비선형 이류항을 `(u · ∇)u = 0` (`advection = 0`)으로 소거**하거나, 챌린지 3에서 수직 속도를 **2+1차원 선형 수동 스칼라 열방정식**으로 분리함 ([`ns376_orthogonal_shear_advection_zero`](../proofs/ns376_kinematic_routing_and_forensics.lean#L50)) | **치명적 (선형 방정식 치환)** |
| **3. 정지 검출기 및 고체 상자 역함수 누락** | 고정 입자 정지 검출기(`fixed-particle halting detector`) 및 고체 상자 역배치 사상 증명 | `SolenoidalSheetPrograms.lean`에서 원고의 고정 입자 정지 검출기 및 고체 상자 상호 사상을 형식화에서 누락함 | **원고-코드 불일치 (`CP-04`)** |

### 5.2 증명 전제 및 공리·가설 무결성 감사

| 전제·가설 무결성 감사 범주 | 학술·형식검증 결함 내용 | 적발 위치 및 물증 |
| :--- | :--- | :--- |
| **공허 및 잉여 가설 (`Vacuous Premise`)** | 점성 계수의 계산 가능성 가설을 언더스코어 바인더로 받고 증명에서 단 한 번도 쓰지 않고 폐기함 | `VelocityDetection/MainResult.lean:51` : **`_hcomputable : ComputableReal ν`** 미사용 폐기 ([`ns376_vacuous_computable_viscosity_premise`](../proofs/ns376_kinematic_routing_and_forensics.lean#L338)) |
| **비자명성 훼손 (`Manufactured Residual`)** | 임의의 궤적 $U$에 대해 외력 $f$를 잔차 그대로 정의해 모든 궤적이 해가 되도록 공허화함 | `BalancedTransport/BoxCoding.lean` ([`ns376_manufactured_force_arbitrary_trajectory_witness`](../proofs/ns376_kinematic_routing_and_forensics.lean#L34)) |
| **선언 중복 및 미호출 모듈 (`Duplicate & Uncalled`)** | `ForcedNavierStokesComputation.lean`의 `38`개 정의 전량 복제 및 `650`개(`64.7%`) 미연결 모듈 방치 | [`ns376_ecosystem_1010_file_stratigraphy`](../proofs/ns376_kinematic_routing_and_forensics.lean#L251) |

---

## 제6부. 정당한 증명 구조 분리 확인, 독립 재검증 및 대안 수리 명세 (`Constructive Verification & Repair`)

### 6.1 정당한 수리 메커니즘 분리 확인 (`Valid Mechanisms Verified`)

- 정의 왜곡과 별개로, 코드 내부의 다음 **3가지 보조 수학 메커니즘 자체는 타당함**을 확인하여 분리 평가함:
  1. 아핀 컬 퍼텐셜 $U = \nabla\times(\chi\Psi)$를 이용한 부피보존 상자 라우팅 (`BoxTransport/Flow.lean`).
  2. 동일 외력 $f$를 공유하는 두 해의 차 $w = u - U$에 대한 외력 상쇄(`(res_u - f) - (res_U - f) = res_u - res_U`) 및 그론월(Grönwall) $L^2$ 에너지 유일성 (`BalancedTransport/Comparison.lean`, `Theorems 21–26`).
  3. 2+1차원 가우스 열핵 두하멜(Duhamel) 적분의 양수성 검출 (`VelocityDetection/MildScalar.lean`, `Theorems 27–31`).

### 6.2 OPFF 독립 `Lean 4` 재검증 및 `Case 007` 전수 재조립 수리 명세 (`93`개 정리, `310/310` 변이 사살)

1. **`Case 006` (`45`개 정리, `176/176` 변이 사살)**:
   - 역산 외력 항등식, 전단 유동 선형화, `_hcomputable` 폐기, `1,010`개 파일 층서학 및 5대 수리 조건(`T33_repair1`~`T37_repair5`: 유한차원 외력 공간 제한, 자율 무외력 분리, `_hcomputable` 오라클 실제 소비, `100%` 도달성 가지치기)을 커널 검증함.
2. **`Case 007` 미연결 `650`개 모듈 전수 재조립 및 상수 압축 (`48`개 정리, `134/134` 변이 사살)**:
   - 방치된 `ForcedComputation/Main.lean`(`770`개 모듈)과 `Solenoidal.lean`을 재연결하여 **비영 압력 $p = -\phi \neq 0$ 무발산 외력 모델을 복원**하고, 차폐 그린 함수 노름 상한을 **`4,528만` 배($\frac{1}{16\pi^2}$) 압축**하며, 평탄 토러스 르레이 상수(`52 -> 16.53`)와 검출기 한계 $H_{\max}$(`7,560`배)를 개선함.

---

## 제7부. 연구윤리 위반 판정 및 최종 결론 (`OPFF Verdict & Three-Tier Attribution`)

### 7.1 5대 국제 학술 표준 및 COPE 가이드라인 위반 대조표

| 위반 범주 | 준거 국제 규정 | 본 사건(`#376`) 확정 물증 | 최종 판정 |
| :--- | :--- | :--- | :---: |
| **문제 정의 왜곡 및 미완성 은폐 (`Gate 1`)** | `IMU/AMS` + `Lean Kernel TCB` (`CP-01`, `CP-02`, `CP-06`) | 영압력($p=0$) 역산 외력 주입, `advection = 0` 선형화, `_hcomputable` 폐기, `NavierStokesVelocity.lean:454` `sorry` 잔존 | **위반 확정** |
| **아티팩트 단절 및 복제 (`Gate 2`)** | `ACM Artifact Badging v1.1` (`CP-04`, `CP-05`, `CP-10`) | `OAI/` `1,004`개 모듈 중 **`650`개(`64.7%`, `73,367`줄) 미연결 유령 방치**, 챌린지 `38`개 정의 100% 복제, `48`개 네임스페이스 스터핑 | **위반 확정** |
| **서지 누락 및 무인용 전유 (`Gate 3`)** | `COPE` + `AMS Ethical Guidelines` (`CP-03`) | `references.bib` `9/22`(`40.9%`) 본문 `\cite` 누락 및 **`11/15`개 섹션(`79.7%`, `4,630`줄) 인간 문헌 인용 `0`건**(헬름홀츠·바일·그론월·민스키 등 `14`대 고전 무인용) | **위반 확정** |

### 7.2 최종 심사 판정문 (`Formal OPFF Referee Verdict Box`)

> **[최종 공식 판정: `OPFF TIER F` (`Hard Reject / Fraudulent Artifact`, 원본 기준) / `PR #76` 서지·아티팩트 감사 병합 대기]**
>
> OpenAI `#376`(*Incompressible Box Transport and Finite Computation*) 원본 제출물은 **(1) 비선형 이류항 소거(`advection = 0`) 및 영압력($p=0$) 역산 외력 주입을 통한 나비에-스토크스 문제 정의의 본질적 변질(`CP-02`)**, **(2) 비교 챌린지 `NavierStokesVelocity.lean:454` 내 미해소 `sorry` 잔존 및 `_hcomputable` 가설 폐기(`CP-01`, `CP-06`)**, **(3) 전체 `1,004`개 모듈 중 `650`개(`64.7%`, `73,367`줄)를 주정리와 단절시킨 유령 아티팩트 투기(`CP-05`)**, **(4) 본문 `11/15`개 섹션(`79.7%`)의 선행 연구 인용 전무 및 `.bib` `9/22`개 미연결(`CP-03`)**로 인해 **OPFF 5대 관문 심사에서 즉결 영구 기각(`OPFF TIER F`)**으로 판정한다.
>
> 단, `mathcommunity/oai-math-revised`에 제출된 **[`PR #76`](https://github.com/mathcommunity/oai-math-revised/pull/76)**은 위 결함 중 미연결 `.bib` `9`건과 누락된 1차 고전 문헌 `14`건을 원고 적소에 복원하고 `NOTES.md`에 위 형식증명·아티팩트 감사 결과를 공식 등재하는 시정 기여이다.
