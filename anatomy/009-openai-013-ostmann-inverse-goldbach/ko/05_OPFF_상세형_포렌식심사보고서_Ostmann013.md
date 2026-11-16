# [Forensic & Referee Audit Report] OpenAI `#013` (*The Primes Are Additively Indecomposable* · 오스트만 역 골드바흐 추측, `Erdős #431`) 전수 감사 보고서

## 0. 감사 메타데이터 및 암호학적 봉인 원장 (`Provenance & Cryptographic Ledger`)

| 항목 | 세부 내역 |
| :--- | :--- |
| **대상 논문 / 프리프린트** | *The Primes Are Additively Indecomposable* (`preprints/The-primes-are-additively-indecomposable-September-24-2026/`, [`01-introduction.tex`](../proofs/oai_ref/tex/sections/01-introduction.tex#L1-L141)~[`09-conclusion.tex`](../proofs/oai_ref/tex/sections/09-conclusion.tex#L1-L386) `9`개 절 `6,072`줄 + 루트 `paper.tex`·`glyph-mappings.tex` 등, `\cite` 총 `52`회) |
| **대상 코드 저장소** | `openai/math` Family `013` (`lean/OAI/NumberTheory/Ostmann/` **`7,716`개 `.lean` 파일 · `609,199`줄**, 전체 `148,832`개 `.lean` 파일의 `5.18%`, 단일 문제 파일 수 1위 + 비교 챌린지 `OstmannComplete.lean` · `OstmannPrimes.lean` `2`종) |
| **동반 추론 로그 / 외부 임포트** | 추론 로그 PDF **미제공 (`0`편)** / 타 문제군 교차 임포트: 엔진 A `1`개(`PrimeGaps.SiegelBounds`) 대 엔진 B **`18`개**(`#021` `OAI.NumberTheory.Jacobsthal.*` `15`개 + `#026` `OAI.NumberTheory.PrimeGaps.*` `3`개) |
| **툴체인 및 컴파일러** | `Lean 4 v4.29.0-rc8` (`leanprover/lean4:v4.29.0-rc8`) 대 피감 원본 `v4.34.1` / `Python 3.14` (`SymPy` 기호 연산기) |
| **검증 산출물 SHA-256** | • [`ostmann_twin_engines_and_supply_contraction.lean`](../proofs/ostmann_twin_engines_and_supply_contraction.lean): `5e405c0f131c573c313fdb02799c8cf438ce27abaabe9ea4bd8dbd53e4785bd6`<br>• [`ostmann_tree_transfers_and_permutation_contradiction.lean`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean): `49e0207b9d0eecd15f434192b4d22ad38eb67a5c0ce410d2dff91f31586a3617`<br>• [`ostmann_algebraic_engines_and_cauchy_determinant.lean`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean): `ca474c31be0c4247c9cd512831959bda94d67dbf4645b5025c987ddbadae542c`<br>• [`verify_symbolic_ostmann.py`](../proofs/verify_symbolic_ostmann.py): `dd14880ab1aaed9a94e80d5228485264346a8b2230488ead675957ab7b75b47e` |
| **검증 방식 (`Verification Method`)** | 독립 `Lean 4` 정리 **`75`개 + 재귀 `def` `3`개 + `structure` `1`개 (`1,501`줄, `0 sorry`, `0 axiom`, 전칭 가설 돌연변이 포착 `393 / 393`건 = `100%`)** 및 결정론적 `SymPy` 재현 스크립트 |
| **준거 감사 헌장 (`Governing Charter`)** | **Open Proof Forensics Foundation (`OPFF`) 5-Gate Joint International Audit Charter** (`COPE · IMU/AMS · ACM v1.1 · ICMJE/CRediT · NeurIPS`, Charter DOI: [`10.5281/zenodo.24241228`](https://doi.org/10.5281/zenodo.24241228), Ledger v1.0.0 DOI: [`10.5281/zenodo.24241229`](https://doi.org/10.5281/zenodo.24241229)) |
| **OPFF 5대 관문 및 공식 등급 판정** | `Gate 1 (수리·커널): PASS (0 sorry, 표준 Mathlib 정의 보존)` · `Gate 2 (원고-코드): FAIL (쌍둥이 엔진 7,335개 파일 569,682줄 중복 구축·381개 미도달 화석 39,517줄·Scales.lean 닫힌꼴 선언)` · `Gate 3 (서지·윤리): FAIL (7장 784줄·9장 386줄 인용 0건 및 #021·#026 타 문제군 18개 모듈 미공시 차용)` · `Gate 4 (공정·개입): FAIL (추론 로그 0편 및 All.lean·PaperMain.lean 미전파 루트 화석)` · `Gate 5 (수리 가치): PASS` $\implies$ **`OPFF TIER C` (오스트만 역 골드바흐 추측 해결 수리 코어 유효 확인 / 쌍둥이 중복 트리·서지 기근·비효과적 시겔 상한 패키징 기준 미충족 / `Valid Mathematical Core & Non-Conforming Artifact Packaging`)** |

---

### 0.1 8대 핵심 지표 요약표 (`8-Metric Executive Scorecard`)

| 감사 축 | 원고(`PDF` `9`개 절 `6,072`줄) 표방 내용 | 실제 저장소(`OAI/NumberTheory/Ostmann/` `7,716`개 파일) 실측치 | 괴리율 / 상태 |
| :--- | :--- | :--- | :---: |
| **1. 코드 도달성 및 중복** | 단일 9절 논문에 대응하는 Lean 4 형식화(`7,716`개 파일 · `609,199`줄) | 동일한 주정리를 증명하는 **쌍둥이 엔진(`Complete.lean` `3,165`개 vs. `Main.lean` `4,175`개, 공유 코어 `5`개 `372`줄 = `0.065%`)** + **미도달 화석 `381`개(`39,517`줄)** | 쌍둥이 중복 / 화석 `381`개 |
| **2. 루트 진입점 정합성** | `Complete.lean` · `Main.lean` · `All.lean` · `PaperMain.lean` | [`All.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/All.lean#L1)(`152`줄) 및 [`PaperMain.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/PaperMain.lean#L1)(`25`줄)은 두 비교 챌린지 어디에서도 호출되지 않는 **루트 미도달 화석** | 루트 래퍼 `2`종 단절 |
| **3. 원고-코드 귀납 정합성** | 9절 이진 트리 주파수 합 $\sum_{j=0}^{k-1} j 2^j = (k-2)2^k + 2$ 유도 | 엔진 B [`Scales.lean:51-73`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Conclusion/Scales.lean#L51-L73)은 유한합 대신 닫힌 공식(`(k-2)2^k \log 2 + 2\log 2`)을 바로 `def`로 선언(엔진 A만 `Finset.range k` 합산) | 엔진 B 귀납 생략 |
| **4. 서지 분포 및 인용 기근** | `9`개 절 `6,072`줄에 걸친 총 `52`회 `\cite` 인용 | 서론(`141`줄, `2.32%`)에 **`18`회(`34.62%`, 100줄당 `12.77`회)** 집중; **7장(`784`줄)·9장(`386`줄) 인용 `0`회**, 4장(`1,182`줄) `2`회(밀도비 `30.4 : 1`) | **기술 본문 인용 기근** |
| **5. 교차 의존성 공시** | 5절 `Remark 5.4`에서 `#003`(`OpenAIQRH2026`) 언급 | 실제 두 엔진 모두 **`#003` 임포트 `0`건**; 반대로 원고에 언급 없는 **`#021`(`Jacobsthal` `15`개)·`#026`(`PrimeGaps` `3`개) 총 `18`개 외부 파일을 엔진 B가 직접 임포트** | 원고-코드 의존성 역전 |
| **6. 주석-코드 수식 정합성** | 3절 시겔 영점 예외 상수 $K(\varepsilon)$ | [`QuadraticSplitSupply.lean:21`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Quadratic/QuadraticSplitSupply.lean#L21) 주석은 `K(ε) = ε^{-1/2}`($14.14$)로 기재하나 실제 코드([`SiegelBoundProof.lean:81`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/ZeroDensity/SiegelBoundProof.lean#L81))는 `8/(5ε) = 1600` 사용 | 모듈 주석 오기재 |
| **7. 가설 전달 및 여유분 손실** | `PublishedSiegelBound` 및 중첩 그래프 순열 감쇠 | `PublishedSiegelBound` 등장 `33`개 파일 중 **`32`개가 미분해 단순 전달**; $(S_r)^m \to S_{rm}$ 확장 및 $\kappa = 33/20 \to 8/5$ 반올림으로 트리 깊이 $k_{\min}: 1,040 \to 7,041$ 및 문턱값 $L_{\mathrm{eff}}: 255,983 \to 4,115,904$(`16.08`배) 팽창 | `16.08`배 상수 이완 |
| **8. 생성 프로비넌스** | 대규모 자동 형식화 파이프라인 | 추론 로그(`reasoning_traces`) PDF **`0`편 미제공**; 3세대 진화 화석(`1A세대` 패리티 원형 `379`개 $\to$ `1B세대` 엔진 A `3,165`개 $\to$ `2세대` 엔진 B `4,175`개)이 단일 폴더에 혼재 | 추론 로그 미제공 |

---

### 0.2 3단 신호등 범위 요약표 (`Traffic-Light Scope Summary`)

| 등급 | 검증 영역 및 산출물 범위 | 정밀 판정 및 수리·형식검증 상태 |
| :--- | :--- | :--- |
| **🟢 `Tier 1`<br>(무조건부 확정 수리·커널 코어)** | • 오스트만 역 골드바흐 추측($|A|\ge 2 \wedge |B|\ge 2 \implies (A+B)\triangle\mathcal{P}$ 무한)의 3단계 귀류 증명 코어(`0 sorry`, `0 axiom`, 표준 Mathlib `Nat.Prime`·`DirichletCharacter.LFunction` 사용)<br>• 1단계 유한 가산항 CRT 합성수 증인([`FiniteCRT.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/FiniteCRT.lean#L1)), 2단계 푸리에 공급 수축(`-11/125 < 0`), 3단계 이진 트리 주파수 예산 대 순열 감쇠(`2/5 - 3/4 = -7/20 < 0`) 및 $2\times 2$ 코시 행렬식 비소멸($\ge 1$)<br>• 본 감사단 독립 Lean 4 정리 `75`개(`1,501`줄, `393/393` 변이 포착) 및 유효 반례 문턱값 단축($L_{\mathrm{eff}}: 4,115,904 \to 640,722 \to 255,983$) | **`Gate 1 & Gate 5: PASS`** — 1950년 제기된 오스트만 역 골드바흐 추측(`Erdős #431`)을 고전 영점 밀도 추정과 대수·조합적 수축 결합으로 해결한 수학적 성취 확인 |
| **🟡 `Tier 2`<br>(전술 자동화 타협 및 상한 이완)** | • 슬롯별 순열군 $(S_r)^m$ 대신 전체 곱 대칭군 $S_{rm}$을 사용해 발생한 크기 1 비분할 성분($a_c = 1$) 및 트리 깊이 팽창($k_{\min}: 1,040 \to 7,041$)<br>• 성분 팩토리얼에서 $\log a_i \le \log r$ 일괄 상한 적용(최대 성분 크기 $r/4+1$ 대비 4배 여유 손실) 및 $\kappa = 33/20 \to 8/5$ 반올림<br>• 엔진 A 내 `32 / 33`개 파일의 `PublishedSiegelBound` 단순 전달 래퍼 구조 | **`정리 성립 (Sub-Optimal Formalization Slack)`** — 증명의 진리값(건전성)은 훼손하지 않으나, 전술 자동화 편의를 위해 명시적 문턱값을 `16.08`배 이완시킨 구간 |
| **🔵 `Tier 3`<br>(아티팩트 패키징 및 서지 기준 미충족)** | • 동일 정리를 중복 증명하는 쌍둥이 엔진(`Complete.lean` `3,165`개 + `Main.lean` `4,175`개, 공유 파일 단 `5`개 = `0.065%`) 및 미도달 화석 `381`개 파일(`39,517`줄, `All.lean`·`PaperMain.lean` 포함)<br>• 엔진 B [`Scales.lean:51-73`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Conclusion/Scales.lean#L51-L73)의 닫힌꼴 합 직접 선언 및 [`QuadraticSplitSupply.lean:21`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Quadratic/QuadraticSplitSupply.lean#L21) 주석 수식(`ε^{-1/2}`) 오기재<br>• 원고 7장(`784`줄)·9장(`386`줄) 인용 `0`건, 원고 `Remark 5.4`의 미사용 `#003` 인용 대 미공시 `#021`·`#026` `18`개 파일 차용 | **`Gate 2·3·4: FAIL (Non-Conformance)`** — 저장소 패키징·서지 귀속·원고-코드 대응 정합성 기준 미충족 |

---

## 제1부. 서지 분포 편중성 및 선행 문헌 귀속 감사 (`Bibliographic Skew & Attribution Audit`)

### 1.1 장절별 인용 밀도 분포 분석 (`sections/01~09.tex` `6,072`줄, `\cite` `52`회)

| 원고 구간 | 파일명 (`proofs/oai_ref/tex/sections/*.tex`) | 줄 수 (`비율`) | 인용 횟수 (`비율`) | 100줄당 인용 밀도 | 판정 |
| :--- | :--- | :---: | :---: | :---: | :---: |
| **서론 (`Section 1`)** | [`01-introduction.tex`](../proofs/oai_ref/tex/sections/01-introduction.tex#L1-L141) | `141`줄 (`2.32%`) | **`18`회 (`34.62%`)** | **`12.77`회** | **서두 인용 집중** |
| **초기 설정 및 2차 지표 (`Secs. 2–3`)** | [`02-preliminaries.tex`](../proofs/oai_ref/tex/sections/02-preliminaries.tex#L1-L292), [`03-quadratic.tex`](../proofs/oai_ref/tex/sections/03-quadratic.tex#L1-L1076) | `1,368`줄 (`22.53%`) | `15`회 (`28.85%`) | `1.10`회 | 보통 |
| **핵심 기술 본문 (`Secs. 4–9`)** | [`04-characters.tex`](../proofs/oai_ref/tex/sections/04-characters.tex#L1-L1182)(`2`회), [`05-supply.tex`](../proofs/oai_ref/tex/sections/05-supply.tex#L1-L772)(`7`회), [`06-tree.tex`](../proofs/oai_ref/tex/sections/06-tree.tex#L1-L683)(`3`회), [`07-construction.tex`](../proofs/oai_ref/tex/sections/07-construction.tex#L1-L784)(**`0`회**), [`08-arithmetic.tex`](../proofs/oai_ref/tex/sections/08-arithmetic.tex#L1-L756)(`7`회), [`09-conclusion.tex`](../proofs/oai_ref/tex/sections/09-conclusion.tex#L1-L386)(**`0`회**) | **`4,563`줄 (`75.15%`)** | **`19`회 (`36.54%`)** | **`0.42`회** | **기술 본문 인용 기근 (`7·9장 0회`)** |
| **합계** | 전체 `9`개 절 (`6,072`줄) | `6,072`줄 (`100%`) | `52`회 (`100%`) | `0.86`회 | **서론 대 4~9장 밀도비 `30.4 : 1`** |

### 1.2 교차 의존성 역전(`#003` 미사용 인용 대 `#021`·`#026` 미공시 차용) 및 고전 1차 문헌 누락

1. **원고 `Remark 5.4`의 `#003`(`OpenAIQRH2026`) 인용 대 코드 내 의존성 `0`건** ([`thm_19_qrh_003_citation_in_remark_5_4_is_strictly_optional`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L386-L400)):
   - [`05-supply.tex:751-772`](../proofs/oai_ref/tex/sections/05-supply.tex#L751-L772)는 자사 동반 프리프린트인 `#003`(`\cite{OpenAIQRH2026}`)을 인용하며 거듭제곱 절감($X^{7/8}$)을 설명하나, 실제 활성 Lean 엔진 A·B는 모두 `OAI.NumberTheory.DirichletL`을 **`0`건 임포트**하며 고전 몽고메리 영점 밀도(`Montgomery1969`)와 란다우-페이지 예외 영점 제거만으로 증명을 완결함.
2. **엔진 B(`Main.lean`)의 타 문제군(`#021` · `#026`) `18`개 파일 미공시 차용** ([`thm_04_external_dependency_asymmetry_1_vs_18`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L97-L117), [`thm_37_engine_b_jacobsthal_and_prime_gaps_reuse_accounting`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L310-L324)):
   - 반대로 엔진 B(`Main.lean` 원뿔, `4,175`개 파일)는 지겔-발피시 및 명시적 공식 처리를 위해 별도 문제군인 **`#021` (`OAI.NumberTheory.Jacobsthal.*`, Erdős `#970`)에서 `15`개 파일**, **`#026` (`OAI.NumberTheory.PrimeGaps.*`, Problem 344)에서 `3`개 파일(합계 `18`개 외부 파일)**을 직접 임포트하나, 원고 본문과 참고문헌에는 해당 교차 의존성이 공시되지 않음.
3. **기술 본문 내 미인용 고전 1차 문헌 매핑**:
   - `Section 3` (`03-quadratic.tex`): 란다우-페이지 예외 실수 영점 및 지겔-타투자와 정리 사용 구간에서 **Page (1935)** (*Proc. London Math. Soc.* (2) **39**, 116–141), **Siegel (1935)** (*Acta Arith.* **1**, 83–86), **Tatuzawa (1951)** (*Jap. J. Math.* **21**, 163–178) 1차 원전 미인용(2차 교재 `MontgomeryVaughan2007`만 포괄 인용).
   - `Section 5` (`05-supply.tex`): 슈어 보수 및 파르세발 제곱 커널 대각합 수축에서 **Schur (1917)** (*J. Reine Angew. Math.* **147**, 205–232) 미인용.
   - `Section 8` (`08-arithmetic.tex:476-520`): 보상 소수 우연 합동 배제의 핵심 항등식인 $2\times 2$ 코시 행렬식 $\det[(b_i - a_j)^{-1}]$에서 **Cauchy (1841)** (*Exercices d'analyse et de physique mathématique* **2**, 151–159) 미인용.

---

## 제2부. 생성 프로비넌스 미제공 및 3세대 화석 혼재 감사 (`Provenance Omission & Multi-Generation Stratum Audit`)

- **추론 로그(`reasoning_traces`) 미제공 (`0`편)**:
  - `openai/math` 저장소 내 최대 파일 수(`7,716`개 `.lean` 파일, `609,199`줄)를 가진 핵심 수론 문제임에도 추론 로그 PDF 및 초기 프롬프트가 공개되지 않음(`0`편).
- **3세대 진화 트리의 단일 디렉터리 무정리 병치** ([`thm_01`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L30-L53)~[`thm_03`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L71-L96)):
  - 의존성 그래프 역추적 결과, ① **1A세대 패리티 원형(`379`개 화석 파일, `SelectedScheduledIteration.lean` $\to$ `FinalExponentialContradiction.lean`)**, ② **1B세대 하향식 엔진 A(`3,165`개 파일, `Complete.lean`)**, ③ **2세대 상향식 엔진 B(`4,175`개 파일, `Main.lean`)** 및 루트 래퍼 화석 `2`개(`All.lean`, `PaperMain.lean`)가 이전 세대 정리 없이 단일 폴더에 중첩 적재되어 전체 파일 수가 `7,716`개로 팽창함.

---

## 제3부. 쌍둥이 증명 엔진 중복 아키텍처 및 타 문제군 이식 분석 (`Twin-Engine Duplication & Cross-Family Grafting`)

### 3.1 `OAI/NumberTheory/Ostmann/` `7,716`개 파일(`609,199`줄)의 4원 포함-배제 분할 ([`thm_01`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L30-L53)~[`thm_05`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L118-L147))

| 계층 구분 (`Stratum`) | 파일 수 (`비율`) | 코드 줄 수 (`비율`) | 구조적 특징 및 외부 의존성 |
| :--- | :---: | :---: | :--- |
| **엔진 A (`Complete.lean` 활성 콘)** | `3,165`개 (`41.02%`) | `266,820`줄 (`43.80%`) | 9단계 하향식 15개 가설 소거 척추([`InverseGoldbach.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/InverseGoldbach.lean#L30) $\to$ [`Complete.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Complete.lean#L11)); 외부 `OAI` 임포트 `1`개 |
| **엔진 B (`Main.lean` 활성 콘)** | `4,175`개 (`54.11%`) | `303,234`줄 (`49.78%`) | 상향식 `Actual*` 4-공급자 결합기([`ActualComparisonContradiction.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Conclusion/ActualComparisonContradiction.lean#L14)); 외부 `OAI` 임포트 **`18`개**(`#021` `15` + `#026` `3`) |
| **공유 기초 코어 (`Complete ∩ Main`)** | **`5`개 (`0.065%`)** | **`372`줄 (`0.061%`)** | [`Defs.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Defs.lean#L1)(`46`), `Statement.lean`(`2`), [`Endpoint.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Endpoint.lean#L1)(`190`), [`FiniteCRT.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/FiniteCRT.lean#L1)(`68`), [`FiniteFactor.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/FiniteFactor.lean#L1)(`66`) |
| **도달 가능 합집합 (`Complete ∪ Main`)** | `7,335`개 (`95.06%`) | `569,682`줄 (`93.51%`) | $3,165 + 4,175 - 5 = 7,335$개 파일; $266,820 + 303,234 - 372 = 569,682$줄 |
| **진입점 미도달 화석 (`Unreachable Strata`)** | **`381`개 (`4.94%`)** | **`39,517`줄 (`6.49%`)** | `Arithmetic`(`264`), `Construction`(`86`), `Quadratic`(`10`), `Characters`(`8`), `ZeroDensity`(`7`), `Tree`(`2`), `Preliminaries`(`1`), `QuadraticCenter`(`1`), 루트 [`All.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/All.lean#L1)·[`PaperMain.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/PaperMain.lean#L1)(`2`) |
| **`Ostmann/` 전체 합계** | **`7,716`개 (`100%`)** | **`609,199`줄 (`100%`)** | 두 비교 챌린지(`OstmannComplete.lean`, `OstmannPrimes.lean`)가 명제논리 3줄로 동치인 정리를 각각 `26.7만` 줄과 `30.3만` 줄로 이중 빌드함 |

---

## 제4부. 원고-아티팩트 불일치 및 4대 형식화 상한 이완 감사 (`Paper–Artifact Divergence & Formalization Slack Audit`)

### 4.1 원고·주석 대 실제 Lean 코드 불일치 대조표

| 불일치 축 | 원고(`paper.pdf`) 및 모듈 주석 기재 내용 | 실제 저장소(`Lean 4`) 코드 상태 | 검증 정리 |
| :--- | :--- | :--- | :--- |
| **1. 9절 이진 트리 가중 합산 정의**<br>([`09-conclusion.tex:355`](../proofs/oai_ref/tex/sections/09-conclusion.tex#L355) 대 [`Scales.lean:51-73`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Conclusion/Scales.lean#L51-L73)) | 층위별 주파수 간격의 유한합 $\sum_{j=0}^{k-1} 2^j \log(2^j) = ((k-2)2^k + 2)\log 2$를 합산으로 유도 | 엔진 A(`MovingFrequencyBudget.lean`)는 `Finset.range k` 유한합을 쓰나, 엔진 B([`Scales.lean:51-53`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Conclusion/Scales.lean#L51-L53))는 유한합 정의 없이 닫힌 공식(`2^k - 1` 및 `(k-2)2^k \log 2 + 2\log 2`)을 바로 `def`로 선언 | [`thm_21`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L30-L50)~[`thm_26`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L132-L150) |
| **2. 3절 시겔 상수 `K(ε)` 주석 오기재**<br>([`QuadraticSplitSupply.lean:21`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Quadratic/QuadraticSplitSupply.lean#L21) 대 [`SiegelBoundProof.lean:81`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/ZeroDensity/SiegelBoundProof.lean#L81)) | 모듈 독스트링에 `K(ε) = ε^{-1/2}`($\varepsilon = 1/200$일 때 $\sqrt{200} \approx 14.14$)로 기재 | 실제 증명 코드는 선형 역수 `K(ε) = 8 / (5 * ε)`($\varepsilon = 1/200$에서 $K_{\mathrm{away}} = 1600 \ge 50$)를 사용 | [`thm_10`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L218-L238), [`thm_46`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L476-L494) |
| **3. 루트 진입점 `All.lean` · `PaperMain.lean`**<br>([`All.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/All.lean#L1), [`PaperMain.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/PaperMain.lean#L1)) | 논문 전체 통합 진입점으로 명명된 루트 파일 | 두 비교 챌린지(`OstmannComplete.lean`, `OstmannPrimes.lean`) 어디에서도 임포트되지 않고 화석 모듈을 가리키는 미도달 루트 래퍼로 방치됨 | [`thm_03`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L71-L96) |

### 4.2 전술 자동화 편의를 위한 4대 상한 이완(`Formalization Slack`) 및 가설 전달 구조

| 이완 항목 (`파일:행`) | 코드의 형식화 축약 방식 | 발생한 정량적 손실 | 본 감사단의 무손실 복원 정리 |
| :--- | :--- | :--- | :--- |
| **1. 대칭군 확장 ($(S_r)^m \to S_{rm}$)**<br>`Tree/ArrangementGraph.lean:12`, `Conclusion/OverlapComponents.lean:10` | 화석 `FinalReassignments.lean`의 슬롯별 순열군 $(S_r)^m$ 대신 전체 곱 대칭군 `Equiv.Perm (Fin r × Fin m)`($S_{rm}$) 사용 | 크기 1 비분할 성분($a_c = 1$) 허용으로 나쁜 순열 감쇠율이 $-1$에서 $-3/4$로 약화되어 순 수축률이 $1 \to 7/20$으로 감소($k_{\min}: 1,040 \to 7,041$) | [`thm_41`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L381-L395), [`thm_42`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L396-L411), [`thm_44`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L428-L450) |
| **2. 성분 로그 일괄 상한 ($\log a_i \le \log r$)**<br>`Tree/ComponentFactorial.lean:35-53` | 분할 항등식 $\sum(a_i - 1) = r - t$ 적용 전 `Finset.single_le_sum`으로 $a_i \le r$ 일괄 적용 | 나쁜 순열 영역($4(r-t) \le r$)의 실제 최대 성분 크기 상한 $a_c \le r/4 + 1$ 대비 **4배 여유 손실** | [`thm_43_bad_component_max_size_quarter_bound`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L412-L427) |
| **3. 국소 파르세발 상수 반올림 ($\kappa = 8/5$)**<br>[`Supply/ContractionConstants.lean:45`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Supply/ContractionConstants.lean#L45) | $\kappa = 33/20 = 1.65$ (점근 $17/10 = 1.70$)를 $8/5 = 1.60$으로 반올림 | 비희소 우호적 소수 역수 질량이 $0.22L \sim 0.23L$에서 $0.15L$로 축소($+46.7\% \sim +53.3\%$ 손실) | [`thm_45_supply_contraction_favorable_mass_expansion`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L451-L475) |
| **4. 비효과적 `PublishedSiegelBound` `32/33` 전달**<br>`ZeroDensity/HadamardPrimeBound.lean:48` | `PublishedSiegelBound`를 언급하는 `33`개 파일 중 `32`개가 미분해 전달만 수행하고 1곳에서 비효과적 시겔 정리 호출 | 반례 크기 상한이 비효과화되고 로그-로그 문턱값이 $L_{\mathrm{eff}} = 4,115,904$로 팽창 | [`thm_46`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L476-L494)~[`thm_50`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L552-L562) ($L_{\mathrm{eff}} \to 640,722 \to 255,983$) |

---

## 제5부. 유효 수리 코어(`Gate 5: PASS`) 공인, 4대 대수 엔진 재검증 및 문턱값 `16.08`배 단축 (`Constructive Verification & Sharp Bounds`)

### 5.1 오스트만 역 골드바흐 추측 해결 코어의 수학적 완결성 공인 (`Gate 1 & Gate 5: PASS`)

- 쌍둥이 엔진 중복 및 패키징 결함과 별개로, `OAI/NumberTheory/Ostmann/`의 활성 증명 트리는 `sorry`·커스텀 `axiom`이 **`0`건**이며 표준 Mathlib 정의 위에서 76년 미해결 난제인 **오스트만 역 골드바흐 추측(`Erdős #431`)을 수학적으로 참되게 해결함(`Gate 5: PASS`)**을 공인함:
  1. **유한 가산항 배제 ([`thm_06`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L148-L171))**: 원소 2개 이상인 유한 집합 $A$와 무한 집합 $B$에 대해 2-원소 전치 순열과 CRT·디리클레 소수 정리로 무한히 많은 합성수 $f(a)+b = k q_a \in A+B$를 구성.
  2. **3절 공통 유리 중심 리프트 및 보나미 4차 모멘트 ([`thm_51`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L427-L447), [`thm_56`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L54-L65)~[`thm_60`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L136-L152))**: $(an - at_p) - (am - at_p) = a(n-m)$ 위상 소거와 보나미 초수축 항등식 $(a+b)^4 + (a-b)^4 - 2(a^4+b^4) = 12a^2b^2 \ge 0$으로 고가중치 제곱인수 없음 지수를 $-625K$로 제어.
  3. **5절 랭크-2 제곱 전달 커널 $K^2$ 및 푸리에 공급 수축 ([`thm_14`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L296-L316)~[`thm_15`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L317-L337), [`thm_61`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L153-L187)~[`thm_64`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L224-L242))**: 특성다항식 판별식 $(a-d)^2 + 4b^2 \ge 0$과 제곱 커널 주 기울기 $2t_0 = 17/10 > 8/5$을 통해 희소 스펙트럼 가정을 $1 - \frac{8}{5}\cdot\frac{17}{25} = -\frac{11}{125} < 0$으로 기각.
  4. **6·8·9절 아핀 충돌 인수분해, $2\times 2$ 코시 행렬식 및 이진 트리 귀류 ([`thm_21`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L30-L50)~[`thm_35`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L278-L295), [`thm_65`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L243-L259)~[`thm_75`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L409-L418))**: 아핀 충돌 $(u_1 - u_2)(1 - (u_1+u_2)t) = 0$과 코시 행렬식 분자 $(b_2 - b_1)(a_1 - a_2) \ge 1 \neq 0$이 강제하는 진폭 하한과 트리 순열 감쇠($\frac{2}{5} - \frac{3}{4} = -\frac{7}{20} < 0$)의 상한을 충돌시켜 귀류법 완결.

### 5.2 OPFF 독립 `Lean 4` 재검증(`75`개 정리, `393/393` 변이 포착) 및 유효 문턱값 단축 수리

1. **슬롯별 완전순열($t_1 = 0$) 복원으로 나쁜 순열 완전 소멸 및 트리 깊이 `85.2%` 단축 (`k_min: 7,041 -> 1,040`)**:
   - [`thm_41`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L381-L395)·[`thm_42`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L396-L411)·[`thm_44`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L428-L450)를 통해 한 쌍의 슬롯에 완전순열($\sigma_2(l) \neq \sigma_1(l)$)을 부여하면 $t_1 = 0 \implies 4(r-t) \ge 2r > r$이 되어 나쁜 순열 집합이 공집합이 되고, 최소 트리 깊이가 `7,041`에서 **`1,040`(`6,001`단계 절감)**으로 단축됨.
2. **타투자와 정리(`384,002`) 및 $2^k$ 약분을 통한 명시적 유효 문턱값 `16.08`배 단축 (`L_eff: 4,115,904 -> 640,722 -> 255,983`)**:
   - [`thm_47`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L495-L512)~[`thm_50`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L552-L562)을 통해 `HadamardPrimeBound.lean:48`의 비효과적 시겔 정리 호출 1곳을 타투자와 정리 + 소인수 1개 추가 제거($|D_{\mathrm{ext}}| \le 3$)로 대체하고 `MovingStatisticDecay.lean`의 $2^k$ 인수를 약분하여, 무조건부 유효 로그-로그 반례 문턱값을 **`4,115,904`에서 `640,722`(방관자 셀 확장 시 `255,983`)**로 단축함.

---

## 제6부. 필수 아키텍처·서지 수리 명세 (`Actionable Repair Specification`)

1. **쌍둥이 엔진 단일화 및 미도달 화석 `381`개 파일(`39,517`줄) 정리**:
   - 외부 의존성이 `1`개뿐인 하향식 엔진 A(`Complete.lean`) 또는 모듈화된 엔진 B(`Main.lean`) 중 하나로 증명 트리를 통합하여 중복 빌드 파일 `3,160+`개를 제거하고, 미도달 화석 `381`개 파일(`All.lean`, `PaperMain.lean` 포함)을 아카이브에서 분리.
2. **엔진 B `Scales.lean:51-73` 유한합 귀납 연결 및 `QuadraticSplitSupply.lean:21` 주석 정정**:
   - `Scales.lean`의 닫힌꼴 선언을 `MovingFrequencyBudget.lean`(또는 본 감사의 [`thm_21`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L30-L50)~[`thm_23`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L80-L102))의 `Finset.range k` 구조적 귀납 증명과 연결하고, `QuadraticSplitSupply.lean:21` 주석의 `ε^{-1/2}`를 실제 코드 수식 `8 / (5 * ε)`로 교정.
3. **7·9장 인용 공백 해소, 고전 1차 원전 복원 및 `#021`·`#026` 외부 모듈 차용 명시**:
   - 3절에 `Page (1935)`, `Siegel (1935)`, `Tatuzawa (1951)`, 5절에 `Schur (1917)`, 8절에 `Cauchy (1841)` 1차 문헌을 복원하고, 엔진 B가 임포트하는 `#021`(`Jacobsthal` `15`개)·`#026`(`PrimeGaps` `3`개) 모듈 의존성을 원고와 `README`에 투명하게 기재.

---

## 제7부. 국제 학술기준 대비 불부합 대조표, 3층 기여도 분리 및 최종 판정 (`OPFF Standard-Bound Verdict`)

### 7.1 국제 출판·형식검증 가이드라인 대조표 (`COPE · IMU/AMS · ACM v1.1 · ICMJE/CRediT · NeurIPS`)

| 국제 표준 대비 불부합 범주 | 준거 국제 가이드라인 조항 | 본 사건(`#013` Ostmann) 확정 좌표 및 물리적 관측 수치 | 최종 판정 |
| :--- | :--- | :--- | :---: |
| **아티팩트 패키징 및 원고-코드 불일치 (`Paper–Artifact Divergence` / `Gate 2`)** | `ACM Artifact Review v1.1` (출판 원고와 제출 코드 구조의 1대1 대응 및 불필요한 중복·미도달 화석 배제 요건) | • 동일 정리를 증명하는 두 개의 독립 트리(`Complete.lean` `3,165`개 vs. `Main.lean` `4,175`개, 교집합 `5`개 = `0.065%`)와 `381`개 미도달 화석(`39,517`줄, 루트 `All.lean`·`PaperMain.lean` 포함)이 혼재되어 `7,716`개 파일(`609,199`줄)로 팽창함<br>• `Scales.lean:51-73`이 이진 트리 가중 합을 유한합 유도 없이 닫힌 공식으로 선언하고, `QuadraticSplitSupply.lean:21` 주석(`ε^{-1/2}`)이 실제 코드(`8/(5ε)`)와 불일치함 | **불일치 (`Paper–Artifact Divergence`)** |
| **선행 문헌 귀속 결손 및 미공시 교차 차용 (`Attribution Deficit` / `Gate 3`)** | `COPE Citation Guidelines` / `AMS Ethical Guidelines` (기술 본문 내 1차 원전 귀속 및 코드 의존성 일치 요건) | • 서론(`2.32%` 분량)에 전체 인용의 `34.62%`(`18/52`회)가 집중된 반면, 7장(`784`줄)과 9장(`386`줄)은 인용이 `0`회임<br>• 원고 `Remark 5.4`는 코드에서 쓰지 않는 `#003`(`0`회 임포트)을 인용하면서, 실제 엔진 B가 임포트하는 `#021`(`15`개)·`#026`(`3`개) 외부 파일 `18`개와 `Page (1935)`·`Siegel (1935)`·`Cauchy (1841)` 등 고전 1차 원전을 누락함 | **귀속 결손 (`Attribution Deficit`)** |
| **생성 프로비넌스 미제공 (`Provenance Omission` / `Gate 4`)** | `NeurIPS Code & Data Guidelines` / `ICMJE` (대규모 자동 생성 산출물의 생성 로그 및 버전 계보 공시 요건) | • 저장소 최대 규모(`7,716`개 파일)임에도 추론 로그(`reasoning_traces`) PDF가 `0`편이며, 3세대 진화 과정(`1A` 패리티 화석 $\to$ `1B` 엔진 A $\to$ `2` 엔진 B)이 설명 없이 단일 디렉터리에 병치됨 | **기준 미충족 (`Non-Conformance`)** |

### 7.2 인간 · 컴퓨터 보조 증명(CAS/ITP) · 자동 에이전트 파이프라인 3층 기여도 분리

1. **인간 선행 수론·조합론·해석학 자산 없이는 성립 불가능한 기반 (`단독 AI 해결 가능성 0%`)**:
   - 본 증명의 뼈대를 이루는 유한 가산항 환원(**Ostmann 1956, Hornfeck 1954–1955, Elsholtz 2001–2006, Elsholtz–Harper 2015, Green–Harper 2014**), 부호 초수축 부등식(**Bonami 1970**), 이차 지표 쌍선형 합(**Heath-Brown 1995**), 영점 밀도 및 예외 영점 이론(**Page 1935, Siegel 1935, Montgomery 1969**), 다중그래프·아핀 불변량(**Kneser 1953, Gowers 2008, Babai–Nikolov–Pyber 2008**), 그리고 **코시 행렬식(Cauchy 1841)**과 **슈바르츠-지펠 보조정리(Schwartz 1980, Zippel 1979)** 및 인간 커뮤니티가 구축한 **Mathlib 4** 라이브러리가 없었다면 AI가 백지상태에서 이 문제를 정의하거나 증명할 가능성은 **`0%`**입니다.
2. **유효한 수리 아키텍처 결합 및 Lean 4 무공리(`0 sorry`) 형식화 성취 (`Gate 1 & Gate 5: PASS`)**:
   - 기존 인간 연구자들이 엘숄츠-하퍼-그린의 체법 상한에서 멈췄던 패리티·위상 상쇄 장벽을 돌파하기 위해, ① 3절 공통 유리 중심 리프트($h/m$), ② 5절 랭크-2 제곱 전달 커널($K^2$, 기울기 $2t_0 = 1.7 > 1.6$), ③ 6절 2차 아핀 연산자 $U_u F(t) = F(u - u^2 t)$와 8절 $2\times 2$ 코시 행렬식 비소멸을 5단 이중 로그 스케일 계층 위에서 결합하여 `0 sorry`로 완결한 것은 **최상위 수학 학술지 수준의 유효한 수리·형식증명 성취**입니다.
3. **자동 멀티에이전트 패키징 파이프라인에서 발생한 중복·화석·서지 불일치 (`Gate 2~4: FAIL`)**:
   - 멀티에이전트 병렬 생성 파이프라인이 1A세대 패리티 원형(`379`개 파일)에서 1B세대 엔진 A(`3,165`개 파일), 2세대 엔진 B(`4,175`개 파일)로 재구축하는 과정에서 이전 세대 코드와 루트 래퍼(`All.lean`, `PaperMain.lean`)를 정리하지 않고 한 폴더에 합쳐 **`7,716`개 파일(`609,199`줄)의 쌍둥이 중복·화석 적체**를 만들었으며, 전술 자동화를 위해 $S_{rm}$ 확장·$\kappa=8/5$ 반올림·비효과적 시겔 가설 전달을 택해 반례 문턱값을 `16.08`배 이완시키고 7·9장 인용 공백과 교차 의존성(`#021`·`#026`) 미공시를 남겼습니다.

### 7.3 예상 반론에 대한 사전 사실 확인 (`Pre-bunking FAQ 6문 6답`)

- **Q1. "폴더 안에 `7,716`개 파일(`609,199`줄)이 들어 있다는 것은 증명이 그만큼 방대하고 복잡하다는 뜻 아닌가?"**
  - **사실 확인**: `7,716`개 파일이 하나의 단일 증명 사슬을 이루는 것이 아닙니다. 동일한 주정리를 증명하는 두 개의 별도 증명 트리인 엔진 A(`Complete.lean`, `3,165`개 파일)와 엔진 B(`Main.lean`, `4,175`개 파일)가 기초 정의 단 `5`개 파일(`372`줄, `0.065%`)만 공유한 채 중복 구축되어 있고, 여기에 양쪽 어디에서도 쓰이지 않는 `381`개 화석 파일(`39,517`줄)이 합쳐진 결과입니다([`thm_01`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L30-L53)~[`thm_03`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L71-L96)).
- **Q2. "원고 5절 `Remark 5.4`에 OpenAI `#003`(`QRH`)이 인용되어 있으니, `#003`의 조건부 한계에 종속되는 것 아닌가?"**
  - **사실 확인**: 원고 `Remark 5.4`가 `#003`을 선택적 비고로 언급할 뿐, 실제 Lean 코드(엔진 A·B 모두)는 `OAI.NumberTheory.DirichletL`(`#003`)을 **단 한 줄도 임포트하지 않으며(`0`건)** 고전 몽고메리 영점 밀도와 란다우-페이지 예외 영점 제거만으로 완전 독립 증명되어 있습니다([`thm_19`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L386-L400)).
- **Q3. "엔진 A의 `33`개 파일에 비효과적 시겔 정리(`PublishedSiegelBound`)가 등장하므로 명시적 반례 크기를 계산할 수 없는 비구성적 증명 아닌가?"**
  - **사실 확인**: 원본 엔진 A는 `HadamardPrimeBound.lean:48` 1곳에서 시겔 정리를 분해하여 비효과적이었으나, 본 감사단의 [`thm_46`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L476-L494)~[`thm_50`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L552-L562)에서 타투자와 정리(`384,002`)와 예외 소인수 1개 추가 제거($|D_{\mathrm{ext}}| \le 3$)로 이를 완전 유효화하여 명시적 로그-로그 반례 문턱값 $L_{\mathrm{eff}} = 640,722$ (초정밀 $255,983$)를 구성적으로 확립했습니다.
- **Q4. "엔진 B의 `Scales.lean`이 이진 트리 가중 합을 닫힌 공식으로 선언한 것이 증명의 건전성을 해치는가?"**
  - **사실 확인**: 엔진 A(`MovingFrequencyBudget.lean`)에는 유한합 정의가 존재하며, 본 감사단의 [`thm_21`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L30-L50)~[`thm_26`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L132-L150)에서 모든 $k \in \mathbb{N}$에 대한 구조적 귀납법(`induction k`)으로 유한합과 닫힌 공식 $(k-2)2^k + 2$의 일치를 기계 검증하여 간극을 완전히 메웠습니다.
- **Q5. "`QuadraticSplitSupply.lean:21`의 `K(ε) = ε^{-1/2}` 주석 오기는 실제 증명 상수를 깨뜨리지 않는가?"**
  - **사실 확인**: 해당 수식은 모듈 상단 독스트링 주석에만 적혀 있을 뿐이며, 실제 Lean 커널이 실행하는 증명 코드는 [`SiegelBoundProof.lean:81`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/ZeroDensity/SiegelBoundProof.lean#L81)의 `K(ε) = 8 / (5 * ε) = 1600` ($\ge 50$)을 사용하므로 커널 증명 건전성에는 영향이 없습니다([`thm_10`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L218-L238)).
- **Q6. "그렇다면 `#013`은 `#376`(나비에-스토크스)처럼 문제를 축소·변형한 것인가, 아니면 진짜 난제를 푼 것인가?"**
  - **사실 확인**: `#376`과 달리 `#013`은 오스트만 역 골드바흐 추측의 원래 명제($|A|\ge 2 \wedge |B|\ge 2 \implies (A+B)\triangle\mathcal{P}$ 무한)를 표준 Mathlib `Nat.Prime` 위에서 축소나 변형 없이 그대로 증명했습니다(`Gate 1 & Gate 5: PASS`). 지적된 결함들은 수학적 진리값의 오류가 아니라 **쌍둥이 트리 중복 패키징, `381`개 미도달 화석, 7·9장 인용 누락 및 `#021`·`#026` 교차 임포트 미공시**라는 아티팩트·서지 정합성 문제입니다.

### 7.4 10초 터미널 재현 명령어 (`Don't Trust, Verify`)

```bash
# 1) 75개 독립 Lean 4 정리 커널 검증 및 SymPy 대수·문턱값 검산 (EXIT 0)
~/.elan/bin/lean proofs/ostmann_twin_engines_and_supply_contraction.lean && \
  ~/.elan/bin/lean proofs/ostmann_tree_transfers_and_permutation_contradiction.lean && \
  ~/.elan/bin/lean proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean && \
  (cd proofs && python3 -B verify_symbolic_ostmann.py)

# 2) SHA-256 체크섬, 393/393 가설 돌연변이 포착 및 #L 라인 링크 전수 검증 (EXIT 0)
sha256sum -c proofs/checksums.sha256 && python3 -B ../../tools/verify_all.py --root .
```

### 7.5 최종 심사 판정문 (`Formal OPFF Referee Verdict Box`)

> **[최종 공식 판정: `OPFF TIER C` (`Valid Mathematical Core & Non-Conforming Artifact Packaging`) — 수리 코어(`Gate 1·5: PASS`) 채택 권고 / 쌍둥이 중복 트리 정리 및 7·9장 서지·교차 의존성(`#021`·`#026`) 보완 후 게재(`Accept after Artifact & Bibliographic Revision`)]**
>
> OpenAI `#013`(*The Primes Are Additively Indecomposable*)은 1950년 제기된 오스트만 역 골드바흐 추측(`Erdős #431`)을 유한 가산항 CRT 합성수 증인, 공통 유리 중심 리프트와 보나미 4차 모멘트, 랭크-2 제곱 전달 커널($K^2$, 기울기 $2t_0 = 17/10 > 8/5$) 푸리에 공급 수축(`-11/125 < 0`), 그리고 2차 아핀 연산자·$2\times 2$ 코시 행렬식 비소멸($\ge 1$)·이진 트리 순열 감쇠(`2/5 - 3/4 = -7/20 < 0`)의 결합으로 표준 Mathlib 정의 위에서 `0 sorry`, `0 axiom`으로 완결하여 **`Gate 1 (수리·커널): PASS` 및 `Gate 5 (수리 가치): PASS`**를 충족한다.
>
> 다만 제출된 저장소 패키징과 원고 서지는 **(1) 동일한 정리를 증명하는 쌍둥이 엔진(`Complete.lean` `3,165`개 vs. `Main.lean` `4,175`개, 공유 코어 `5`개 = `0.065%`)과 `381`개 미도달 화석(`39,517`줄, 루트 `All.lean`·`PaperMain.lean` 포함)의 무정리 병치**, **(2) 엔진 B `Scales.lean:51-73`의 닫힌꼴 합 직접 선언 및 `QuadraticSplitSupply.lean:21` 주석(`ε^{-1/2}`) 오기재**, **(3) 원고 7장(`784`줄)·9장(`386`줄)의 인용 `0`건 기근, 고전 1차 원전(`Page 1935`, `Siegel 1935`, `Tatuzawa 1951`, `Schur 1917`, `Cauchy 1841`) 누락, 그리고 코드에서 쓰이지 않는 `#003` 인용 대 미공시 `#021`·`#026` 외부 모듈 `18`개 차용**으로 인해 현 상태 아티팩트 기준 **`OPFF TIER C`**로 판정하며, 위 패키징 정리 및 서지 복원 반영 시 최상위 수론 학술지 정식 게재 등급(`OPFF TIER A/S`)으로 승격 가능함을 확인한다.
