# Forensic & Referee Audit Report: OpenAI #013 (The additive indecomposability of the primes · 오스트만 역 골드바흐 추측, Erdős #431) 전수 감사 보고서

## 0. 감사 메타데이터 및 암호학적 봉인 원장

| 항목 | 세부 내역 |
| :--- | :--- |
| 대상 논문 / 프리프린트 | The additive indecomposability of the primes (`preprints/the-additive-indecomposability-of-the-primes-September-24-2026/`, [01-introduction.tex](../proofs/oai_ref/tex/sections/01-introduction.tex#L1-L141)~[09-conclusion.tex](../proofs/oai_ref/tex/sections/09-conclusion.tex#L1-L386) 9개 절 6,072줄 + 루트 [paper.tex](../proofs/oai_ref/tex/paper.tex#L1-L80)·[glyph-mappings.tex](../proofs/oai_ref/tex/glyph-mappings.tex#L1-L74), `\cite` 명령 51회 · 총 인용 52건 · 고유 키 35종) |
| 대상 코드 저장소 | `openai/math` Family 013 (`lean/OAI/NumberTheory/Ostmann/` 7,716개 `.lean` 파일 · 609,199줄, 전체 148,832개 `.lean` 파일의 5.18%, 단일 문제 파일 수 1위 + 비교 챌린지 [OstmannComplete.lean](../proofs/oai_ref/lean/ComparatorChallenges/OstmannComplete.lean#L1-L38) · [OstmannPrimes.lean](../proofs/oai_ref/lean/ComparatorChallenges/OstmannPrimes.lean#L1-L15) 2종) |
| 동반 추론 로그 / 외부 임포트 | 추론 로그 PDF 미제공 (0편) / 타 문제군 교차 임포트: 엔진 A 1개(`PrimeGaps.SiegelBounds`) 대 엔진 B 18개(#021 `OAI.NumberTheory.Jacobsthal.*` 15개 + #026 `OAI.NumberTheory.PrimeGaps.*` 3개) |
| 툴체인 및 컴파일러 | Lean 4 v4.29.0-rc8 (`leanprover/lean4:v4.29.0-rc8`) 대 피감 원본 v4.34.1 / Python 3.14 (SymPy 기호 연산기) |
| 검증 산출물 SHA-256 | • [ostmann_twin_engines_and_supply_contraction.lean](../proofs/ostmann_twin_engines_and_supply_contraction.lean): `edbc820be45ec3b384022ccb043fd33aa90a1ff28c0ebe83b878f51491a2185d`<br>• [ostmann_tree_transfers_and_permutation_contradiction.lean](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean): `529c59062f95b012231c781d29caa795fd6e5f948016d4f2bbc6bdc8c232df59`<br>• [ostmann_algebraic_engines_and_cauchy_determinant.lean](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean): `1681e0b1fbd21477104b589aa6ae8f7a644bd0d4d672fd5beb65ca57972c1cf7`<br>• [verify_symbolic_ostmann.py](../proofs/verify_symbolic_ostmann.py): `8f5c742ebfdec6a8aa943f51f6c5a650404d21aa9c970f86fc5afbc2f919bc98` |
| 검증 방식 | 독립 Lean 4 정리 75개 + 재귀 def 3개 + structure 1개 (1,517줄, 0 `sorry`, 0 `axiom`, 전칭 가설 돌연변이 포착 393 / 393건 = 100%) 및 결정론적 SymPy 재현 스크립트 |
| 적용 감사 규격 | ultari-proof-anatomy 5-Gate Audit Rubric (Open Proof Forensic Framework, OPFF) (COPE · IMU/AMS · ACM v1.1 · ICMJE/CRediT · NeurIPS, Charter DOI: [10.5281/zenodo.24241228](https://doi.org/10.5281/zenodo.24241228), Ledger v1.0.0 DOI: [10.5281/zenodo.24241229](https://doi.org/10.5281/zenodo.24241229)) |
| 5대 관문 및 등급 판정 | Gate 1 (수리·커널): PASS (0 `sorry`, 표준 Mathlib 정의 보존) · Gate 2 (원고-코드): FAIL (쌍둥이 엔진 7,335개 파일 569,682줄 중복 구축·381개 미도달 화석 39,517줄·`Erdos970` 패치 +47,394줄 내 NOTICE 누락 및 주석 2,253줄 공백 치환·문턱값 16.08배 이완) · Gate 3 (서지·윤리): FAIL (7장 784줄·9장 386줄 인용 0건 및 #021·#026 타 문제군 18개 모듈 미공시 차용) · Gate 4 (공정·개입): FAIL (추론 로그 0편·`formalization.yaml` 누락 및 `All.lean`·`PaperMain.lean` 미전파 루트 화석) · Gate 5 (수리 가치): PASS $\implies$ TIER C (오스트만 역 골드바흐 추측 해결 수리 코어 유효 확인 / 쌍둥이 중복 트리·패치 고지 누락·서지 기근·비효과적 시겔 상한 패키징 기준 미충족 / Valid Mathematical Core & Non-Conforming Artifact Packaging) |



### 0.1 8대 핵심 지표 요약표 (8-Metric Executive Scorecard)

| 감사 축 | 원고(PDF 9개 절 6,072줄) 표방 내용 | 실제 저장소(OAI/NumberTheory/Ostmann/ 7,716개 파일) 실측치 | 괴리율 / 상태 |
| :--- | :--- | :--- | :---: |
| 1. 코드 도달성 및 중복 | 단일 9절 논문에 대응하는 Lean 4 형식화(7,716개 파일 · 609,199줄) | 동일한 주정리를 증명하는 쌍둥이 엔진(Complete.lean 3,165개 vs. Main.lean 4,175개, 공유 코어 5개 372줄 = 0.065%) + 미도달 화석 381개(39,517줄) | 쌍둥이 중복 / 화석 381개 |
| 2. 루트 진입점 정합성 | Complete.lean · Main.lean · All.lean · PaperMain.lean | [All.lean](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/All.lean#L1)(152줄) 및 [PaperMain.lean](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/PaperMain.lean#L1)(25줄)은 두 비교 챌린지 어디에서도 호출되지 않는 루트 미도달 화석 | 루트 래퍼 2종 단절 |
| 3. 이진 합 및 시겔 상수 | 9절 $\sum_{j=1}^k r_j \log r_j$ 합산; 3절 시겔 $q^{1/200} \le (\log X)^{1/2}$ | [Conclusion/Scales.lean:51-83](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Conclusion/Scales.lean#L51-L83)은 `Finset.range k`(0 기반) `induction k`로 `sum_dyadic`·`sum_dyadic_log`를 증명하며 `Bs=200`, `BD=322`로 이완; [SiegelBoundProof.lean:17,81](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/ZeroDensity/SiegelBoundProof.lean#L81)은 `¬ hnear`에서 `2/η = 8/ε = 1600` 사용 | 귀납 검증 완료 / 16.08배 이완 |
| 4. 서지 분포 및 인용 기근 | 9개 절 6,072줄에 걸친 총 52건 인용 | 서론(141줄, 2.32%)에 17개 명령 / 18회 키 호출(34.62%, 100줄당 12.77회) 집중; 7장(784줄)·9장(386줄) 인용 0건, 4장(1,182줄) 2회(밀도비 30.4 : 1) | 기술 본문 인용 기근 |
| 5. 교차 의존성 공시 | 5절 Remark 5.4에서 #003(`OpenAIQRH2026`) 언급 | 실제 두 엔진 모두 #003 임포트 0건; 반대로 원고에 언급 없는 #021(Jacobsthal 15개)·#026(PrimeGaps 3개) 총 18개 외부 파일을 엔진 B가 직접 임포트 | 원고-코드 의존성 역전 |
| 6. 업스트림 패치·매니페스트 | 표준 Mathlib 및 자체 형식화 의존 | `PrimeNumberTheoremAnd/Erdos970/*`(+21,197줄) 및 `StrongPNT/Erdos970/*`(+26,197줄) +47,394줄 추가 중 `SiegelZeros/NOTICE.md` 누락 및 주석 2,253줄 0x20 공백 치환; `formalization.yaml`(`oai_ref/` 미수록) #013 누락 | 고지 누락 / 2,253줄 공백화 |
| 7. 가설 전달 및 여유분 손실 | `PublishedSiegelBound` 및 중첩 그래프 순열 감쇠 | `PublishedSiegelBound` 등장 33개 파일 중 32개가 미분해 단순 전달; $(S_r)^m \to S_{rm}$ 확장 및 $\kappa = 33/20 \to 8/5$ 반올림으로 트리 깊이 $k_{\min}: 1,040 \to 7,041$ 및 문턱값 $L_{\mathrm{eff}}: 255,983 \to 4,115,904$(16.08배) 팽창, 내부 미사용 가설 바인더 952건 | 16.08배 상수 이완 |
| 8. 생성 프로비넌스 | 대규모 자동 형식화 파이프라인 | 추론 로그(`reasoning_traces`) PDF 0편 미제공; 3세대 진화 화석(1A세대 패리티 원형 379개 $\to$ 1B세대 엔진 A 3,165개 $\to$ 2세대 엔진 B 4,175개)이 단일 폴더에 혼재 | 추론 로그 미제공 |



### 0.2 3단 신호등 범위 요약표 (Traffic-Light Scope Summary)

| 등급 | 검증 영역 및 산출물 범위 | 정밀 판정 및 수리·형식검증 상태 |
| :--- | :--- | :--- |
| Tier 1<br>(무조건부 확정 수리·커널 코어) | • 오스트만 역 골드바흐 추측($\lvert A\rvert\ge 2 \wedge \lvert B\rvert\ge 2 \implies (A+B)\triangle\mathcal{P}$ 무한)의 3단계 귀류 증명 코어(0 `sorry`, 0 `axiom`, 표준 Mathlib `Nat.Prime`·`DirichletCharacter.LFunction` 사용)<br>• 1단계 유한 가산항 CRT 합성수 증인([FiniteCRT.lean](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/FiniteCRT.lean#L1)), 2단계 푸리에 공급 수축(-11/125 < 0), 3단계 이진 트리 주파수 예산 대 순열 감쇠(2/5 - 3/4 = -7/20 < 0) 및 통분된 $2\times 2$ 선형형식 소행렬 비퇴화·슈바르츠-지펠 근 개수 상한([08-arithmetic.tex:407-497](../proofs/oai_ref/tex/sections/08-arithmetic.tex#L407-L497))<br>• 독립 Lean 4 정리 75개(1,517줄, 393/393 변이 포착) 및 유효 반례 문턱값 단축($L_{\mathrm{eff}}: 4,115,904 \to 640,722 \to 255,983$) | Gate 1 & Gate 5: PASS: 1950년 제기된 오스트만 역 골드바흐 추측(Erdős #431)을 고전 영점 밀도 추정과 대수·조합적 수축 결합으로 해결한 수학적 성취 확인 |
| Tier 2<br>(전술 자동화 타협 및 상한 이완) | • 슬롯별 순열군 $(S_r)^m$ 대신 전체 곱 대칭군 $S_{rm}$을 사용해 발생한 크기 1 비분할 성분($a_c = 1$) 및 트리 깊이 팽창($k_{\min}: 1,040 \to 7,041$)<br>• 성분 팩토리얼에서 $\log a_i \le \log r$ 일괄 상한 적용(최대 성분 크기 $r/4+1$ 대비 4배 여유 손실) 및 $\kappa = 33/20 \to 8/5$ 반올림<br>• 엔진 A 내 32 / 33개 파일의 `PublishedSiegelBound` 단순 전달 래퍼 구조 | 정리 성립 (Sub-Optimal Formalization Slack): 증명의 진리값(건전성)은 훼손하지 않으나, 전술 자동화 편의를 위해 명시적 문턱값을 16.08배 이완시킨 구간 |
| Tier 3<br>(아티팩트 패키징 및 서지 기준 미충족) | • 동일 정리를 중복 증명하는 쌍둥이 엔진(`Complete.lean` 3,165개 + `Main.lean` 4,175개, 공유 파일 단 5개 = 0.065%) 및 미도달 화석 381개 파일(39,517줄, `All.lean`·`PaperMain.lean` 포함)<br>• 업스트림 `Erdos970` 패치(+47,394줄) 내 `SiegelZeros/NOTICE.md` 누락 및 주석 2,253줄의 0x20 공백 치환, `formalization.yaml`(`oai_ref/` 미수록) #013 누락<br>• 원고 7장(784줄)·9장(386줄) 인용 0건, 원고 Remark 5.4의 미사용 #003 인용 대 미공시 #021·#026 18개 파일 차용 및 외부 Lean 저장소(`PrimeNumberTheoremAnd`·`StrongPNT`·`CBirkbeck/AINTLIB`) 인용 0건 | Gate 2·3·4: FAIL: 저장소 패키징·라이선스 고지·서지 귀속·원고-코드 대응 정합성 기준 미충족 |



## 제1부. 서지 분포 편중성 및 선행 문헌 귀속 감사 (Bibliographic Skew & Attribution Audit)

### 1.1 장절별 인용 밀도 분포 분석 (`proofs/oai_ref/tex/sections/` 6,072줄, 인용 52건)

| 원고 구간 | 파일명 (`proofs/oai_ref/tex/sections/`) | 줄 수 (비율) | 인용 건수 (비율) | 100줄당 인용 밀도 | 판정 |
| :--- | :--- | :---: | :---: | :---: | :---: |
| 서론 (Section 1) | [01-introduction.tex](../proofs/oai_ref/tex/sections/01-introduction.tex#L1-L141) | 141줄 (2.32%) | 18건 (34.62%) | 12.77건 | 서두 인용 집중 |
| 초기 설정 및 2차 지표 (Secs. 2–3) | [02-preliminaries.tex](../proofs/oai_ref/tex/sections/02-preliminaries.tex#L1-L292), [03-quadratic.tex](../proofs/oai_ref/tex/sections/03-quadratic.tex#L1-L1076) | 1,368줄 (22.53%) | 15건 (28.85%) | 1.10건 | 보통 |
| 핵심 기술 본문 (Secs. 4–9) | [04-characters.tex](../proofs/oai_ref/tex/sections/04-characters.tex#L1-L1182)(2건), [05-supply.tex](../proofs/oai_ref/tex/sections/05-supply.tex#L1-L772)(7건), [06-tree.tex](../proofs/oai_ref/tex/sections/06-tree.tex#L1-L683)(3건), [07-construction.tex](../proofs/oai_ref/tex/sections/07-construction.tex#L1-L784)(0건), [08-arithmetic.tex](../proofs/oai_ref/tex/sections/08-arithmetic.tex#L1-L756)(7건), [09-conclusion.tex](../proofs/oai_ref/tex/sections/09-conclusion.tex#L1-L386)(0건) | 4,563줄 (75.15%) | 19건 (36.54%) | 0.42건 | 기술 본문 인용 기근 (7·9장 0건) |
| 합계 | 전체 9개 절 (6,072줄) | 6,072줄 (100%) | 52건 (100%) | 0.86건 | 서론 대 4~9장 밀도비 30.4 : 1 |

### 1.2 교차 의존성 역전(#003 미사용 인용 대 #021·#026 미공시 차용) 및 고전 1차 문헌 누락

1. 원고 Remark 5.4의 #003(`OpenAIQRH2026`) 인용 대 코드 내 의존성 0건 ([thm_19_qrh_003_citation_in_remark_5_4_is_strictly_optional](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L386-L395)):
   - [05-supply.tex:751-772](../proofs/oai_ref/tex/sections/05-supply.tex#L751-L772)는 자사 동반 프리프린트인 #003(`\cite{OpenAIQRH2026}`)을 인용하며 거듭제곱 절감($X^{7/8}$)을 설명하나, 실제 활성 Lean 엔진 A([Complete.lean](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Complete.lean#L1-L26))·B([Main.lean](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Main.lean#L1))는 모두 `OAI.NumberTheory.DirichletL`을 0건 임포트하며 고전 몽고메리 영점 밀도(`Montgomery1969`)와 란다우-페이지 예외 영점 제거만으로 증명을 완결함.
2. 엔진 B(`Main.lean`)의 타 문제군(#021 · #026) 18개 파일 미공시 차용 ([thm_04_external_dependency_asymmetry_1_vs_18](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L97-L110), [thm_37_engine_b_jacobsthal_and_prime_gaps_reuse_accounting](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L310-L318)):
   - 반대로 엔진 B(`Main.lean` 원뿔, 4,175개 파일)는 지겔-발피시 및 명시적 공식 처리를 위해 별도 문제군인 #021 (`OAI.NumberTheory.Jacobsthal.*`, Erdős #970)에서 15개 파일, #026 (`OAI.NumberTheory.PrimeGaps.*`, Problem 344)에서 3개 파일(합계 18개 외부 파일)을 직접 임포트하나, 원고 본문과 참고문헌에는 해당 교차 의존성이 공시되지 않음.
3. 기술 본문 내 미인용 고전 1차 문헌 및 외부 Lean 저장소 매핑:
   - Section 3 ([03-quadratic.tex:907-910](../proofs/oai_ref/tex/sections/03-quadratic.tex#L907-L910)): 란다우-페이지 예외 실수 영점 및 지겔 정리 사용 구간에서 2차 교재(`MontgomeryVaughan2007`)만 포괄 인용하고 1차 원전인 Page (1935) (Proc. London Math. Soc. (2) 39, 116–141) 및 Siegel (1935) (Acta Arith. 1, 83–86) 누락.
   - Sections 7 & 9 ([07-construction.tex:1-784](../proofs/oai_ref/tex/sections/07-construction.tex#L1-L784), [09-conclusion.tex:1-386](../proofs/oai_ref/tex/sections/09-conclusion.tex#L1-L386)): 총 1,170줄에 인용이 0건이며, Section 8 ([08-arithmetic.tex:481-497](../proofs/oai_ref/tex/sections/08-arithmetic.tex#L481-L497))은 분모 소거 $2\times 2$ 선형형식 소행렬식 판정(`L407-467`) 위에서 슈바르츠-지펠 보조정리(`Schwartz1980`, `Zippel1979`, `DeMilloLipton1978`)를 직접 인용함.
   - 외부 Lean 저장소: Lean 증명 원뿔이 직접 의존하는 `PrimeNumberTheoremAnd`, `StrongPNT`, `CBirkbeck/AINTLIB`(`BernoulliRegular`)에 대한 원고 및 참고문헌 인용 0건.



## 제2부. 생성 프로비넌스 미제공 및 3세대 화석 혼재 감사 (Provenance Omission & Multi-Generation Stratum Audit)

- 추론 로그(`reasoning_traces`) 미제공 (0편):
  - openai/math 저장소 내 최대 파일 수(7,716개 .lean 파일, 609,199줄)를 가진 핵심 수론 문제임에도 추론 로그 PDF 및 초기 프롬프트가 공개되지 않음(0편).
- 3세대 진화 트리의 단일 디렉터리 무정리 병치 ([thm_01](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L30-L48)~[thm_03](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L71-L90)):
  - 의존성 그래프 역추적 결과, ① 1A세대 패리티 원형(379개 화석 파일: `SelectedScheduledIteration.lean` $\to$ `FinalExponentialContradiction.lean`, 모두 `oai_ref/` 미수록), ② 1B세대 하향식 엔진 A(3,165개 파일, `Complete.lean`), ③ 2세대 상향식 엔진 B(4,175개 파일, `Main.lean`) 및 루트 래퍼 화석 2개([All.lean](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/All.lean#L1), [PaperMain.lean](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/PaperMain.lean#L1))가 이전 세대 정리 없이 단일 폴더에 중첩 적재되어 전체 파일 수가 7,716개로 팽창함.



## 제3부. 쌍둥이 증명 엔진 중복 아키텍처 및 타 문제군 이식 분석 (Twin-Engine Duplication & Cross-Family Grafting)

### 3.1 `OAI/NumberTheory/Ostmann/` 7,716개 파일(609,199줄)의 4원 포함-배제 분할 ([thm_01](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L30-L48)~[thm_05](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L118-L141))

| 계층 구분 (Stratum) | 파일 수 (비율) | 코드 줄 수 (비율) | 구조적 특징 및 외부 의존성 |
| :--- | :---: | :---: | :--- |
| 엔진 A (`Complete.lean` 활성 콘) | 3,165개 (41.02%) | 266,820줄 (43.80%) | 9단계 하향식 14개 해석적 입력 소거 척추([InverseGoldbach.lean](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/InverseGoldbach.lean#L13-L21) $\to$ [Complete.lean](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Complete.lean#L16-L23)); 직접 외부 OAI 임포트 1개(#026 전이 42개) |
| 엔진 B (`Main.lean` 활성 콘) | 4,175개 (54.11%) | 303,234줄 (49.78%) | 상향식 `Actual*` 4-공급자 결합기([ActualComparisonContradiction.lean](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Conclusion/ActualComparisonContradiction.lean#L14)); 직접 외부 OAI 임포트 18개(#021 15 + #026 3; 전이 183개) |
| 공유 기초 코어 (`Complete ∩ Main`) | 5개 (0.065%) | 372줄 (0.061%) | [Defs.lean](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Defs.lean#L1)(46), `Statement.lean`(2, `oai_ref/` 미수록), [Endpoint.lean](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Endpoint.lean#L1)(190), [FiniteCRT.lean](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/FiniteCRT.lean#L1)(68), [FiniteFactor.lean](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/FiniteFactor.lean#L1)(66) |
| 도달 가능 합집합 (`Complete ∪ Main`) | 7,335개 (95.06%) | 569,682줄 (93.51%) | $3,165 + 4,175 - 5 = 7,335$개 파일; $266,820 + 303,234 - 372 = 569,682$줄 |
| 진입점 미도달 화석 (`Unreachable Strata`) | 381개 (4.94%) | 39,517줄 (6.49%) | `Arithmetic`(264), `Construction`(86), `Quadratic`(10), `Characters`(8), `ZeroDensity`(7), `Tree`(2), `Preliminaries`(1), `QuadraticCenter`(1), 루트 [All.lean](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/All.lean#L1)·[PaperMain.lean](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/PaperMain.lean#L1)(2) |
| `Ostmann/` 전체 합계 | 7,716개 (100%) | 609,199줄 (100%) | 두 비교 챌린지(`OstmannComplete.lean`, `OstmannPrimes.lean`)가 명제논리 3줄로 동치인 정리를 각각 26.7만 줄과 30.3만 줄로 이중 빌드함 |



## 제4부. 원고-아티팩트 정합성 및 4대 형식화 상한 이완 감사 (Paper-Artifact Comparison & Formalization Slack Audit)

### 4.1 원고 대 실제 Lean 코드 구조 대조표

| 대조 축 | 원고(`paper.tex` / `proofs/oai_ref/tex/sections/`) 기재 내용 | 실제 저장소(Lean 4) 코드 상태 | 검증 정리 |
| :--- | :--- | :--- | :--- |
| 1. 9절 이진 트리 가중 합산 및 엔진 B 상수<br>([09-conclusion.tex:355-358](../proofs/oai_ref/tex/sections/09-conclusion.tex#L355-L358) 대 [Scales.lean:51-87](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Conclusion/Scales.lean#L51-L87)) | 1기반 색인 유한합 $\sum_{j=1}^k r_j = r - 1$, $\sum_{j=1}^k r_j \log r_j = r\log r - 2r\log 2 + 2\log 2$ 기재 | 엔진 A(`MovingFrequencyBudget.lean`, `oai_ref/` 미수록)와 엔진 B([Conclusion/Scales.lean:51-83](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Conclusion/Scales.lean#L51-L83)) 모두 `Finset.range k`(0 기반) `induction k`로 `sum_dyadic`·`sum_dyadic_log`를 증명함; 단 엔진 B는 `Bs=200`, `BD=322` 이완으로 $k_{\min}=7,041$ | [thm_21](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L30-L46)~[thm_26](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L132-L144) |
| 2. 3절 시겔 상수 `K(ε)` 및 `¬ hnear` 분기<br>([03-quadratic.tex:985-988](../proofs/oai_ref/tex/sections/03-quadratic.tex#L985-L988) 대 [SiegelBoundProof.lean:17,81](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/ZeroDensity/SiegelBoundProof.lean#L81)) | $\varepsilon_1 = 1/200$, $q \le (\log X)^{100}$에서 비효과적 시겔 정리 $(1-\beta)^{-1} \ll q^{1/200} \le (\log X)^{1/2}$ 사용 | [QuadraticSplitSupply.lean:25-33](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Quadratic/QuadraticSplitSupply.lean#L25-L33)는 $\varepsilon = 1/200$, `(40000*K)^2 ≤ L`을 요구하고, [SiegelBoundProof.lean:17,81](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/ZeroDensity/SiegelBoundProof.lean#L81)은 `η = min (ε/4) (1/4)`로 두어 `¬ hnear` 분기에서 `2/η = 8/ε = 1600`을 증명하며 `LargePrimeGaps.quadratic_siegel` 호출을 `hnear`로 격리함 | [thm_10](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L218-L234), [thm_46](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L476-L486) |
| 3. 루트 진입점 `All.lean` · `PaperMain.lean`<br>([All.lean](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/All.lean#L1), [PaperMain.lean](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/PaperMain.lean#L1)) | 논문 전체 통합 진입점으로 명명된 루트 파일 | 두 비교 챌린지([OstmannComplete.lean](../proofs/oai_ref/lean/ComparatorChallenges/OstmannComplete.lean#L1-L38), [OstmannPrimes.lean](../proofs/oai_ref/lean/ComparatorChallenges/OstmannPrimes.lean#L1-L15)) 어디에서도 임포트되지 않고 화석 모듈을 가리키는 미도달 루트 래퍼로 방치됨 | [thm_03](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L71-L90) |

### 4.2 전술 자동화 편의를 위한 4대 상한 이완(Formalization Slack) 및 가설 전달 구조

| 이완 항목 (파일:행) | 코드의 형식화 축약 방식 | 발생한 정량적 손실 | 독립 무손실 복원 정리 |
| :--- | :--- | :--- | :--- |
| 1. 대칭군 확장 ($(S_r)^m \to S_{rm}$)<br>`Tree/ArrangementGraph.lean:12`, `Conclusion/OverlapComponents.lean:10` (`oai_ref/` 미수록) | 화석 `FinalReassignments.lean`(`oai_ref/` 미수록)의 슬롯별 순열군 $(S_r)^m$ 대신 전체 곱 대칭군 `Equiv.Perm (Fin r × Fin m)`($S_{rm}$) 사용 | 크기 1 비분할 성분($a_c = 1$) 허용으로 나쁜 순열 감쇠율이 $-1$에서 $-3/4$로 약화되어 순 수축률이 $1 \to 7/20$으로 감소($k_{\min}: 1,040 \to 7,041$) | [thm_41](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L381-L388), [thm_42](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L396-L405), [thm_44](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L428-L442) |
| 2. 성분 로그 일괄 상한 ($\log a_i \le \log r$)<br>`Tree/ComponentFactorial.lean:35-53` (`oai_ref/` 미수록) | 분할 항등식 $\sum(a_i - 1) = r - t$ 적용 전 `Finset.single_le_sum`으로 $a_i \le r$ 일괄 적용 | 나쁜 순열 영역($4(r-t) \le r$)의 실제 최대 성분 크기 상한 $a_c \le r/4 + 1$ 대비 4배 여유 손실 | [thm_43_bad_component_max_size_quarter_bound](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L412-L418) |
| 3. 국소 파르세발 상수 반올림 ($\kappa = 8/5$)<br>[Supply/ContractionConstants.lean:55-80](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Supply/ContractionConstants.lean#L55-L80) | $\kappa = 33/20 = 1.65$ (점근 $17/10 = 1.70$)를 $8/5 = 1.60$으로 반올림 | 비희소 우호적 소수 역수 질량이 $0.22L \sim 0.23L$에서 $0.15L$로 축소($+46.7\% \sim +53.3\%$ 손실) | [thm_45_supply_contraction_favorable_mass_expansion](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L451-L464) |
| 4. 비효과적 `PublishedSiegelBound` 32/33 전달<br>`ZeroDensity/HadamardPrimeBound.lean:48` (`oai_ref/` 미수록) | `PublishedSiegelBound`를 언급하는 33개 파일 중 32개가 미분해 전달만 수행하고 1곳에서 비효과적 시겔 정리 호출 | 반례 크기 상한이 비효과화되고 로그-로그 문턱값이 $L_{\mathrm{eff}} = 4,115,904$로 팽창 | [thm_46](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L476-L486)~[thm_50](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L552-L562) ($L_{\mathrm{eff}} \to 640,722 \to 255,983$) |



## 제5부. 유효 수리 코어(Gate 5: PASS) 공인, 4대 대수 엔진 재검증 및 문턱값 16.08배 단축 (Constructive Verification & Sharp Bounds)

### 5.1 오스트만 역 골드바흐 추측 해결 코어의 수학적 완결성 확인 (Gate 1 & Gate 5: PASS)

- 쌍둥이 엔진 중복 및 패키징 결함과 별개로, `OAI/NumberTheory/Ostmann/`의 활성 증명 트리는 `sorry`·커스텀 `axiom`이 0건이며 표준 Mathlib 정의 위에서 76년 미해결 난제인 오스트만 역 골드바흐 추측(Erdős #431)을 수학적으로 참되게 해결함(Gate 5: PASS)을 확인함:
  1. 유한 가산항 배제 ([thm_06](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L148-L161)): 원소 2개 이상인 유한 집합 $A$와 무한 집합 $B$에 대해 2-원소 치환 사상과 CRT·디리클레 소수 정리로 무한히 많은 합성수 $f(a)+b = k q_a \in A+B$를 구성.
  2. 3절 공통 유리 중심 리프트 및 보나미 4차 모멘트 ([thm_51](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L427-L440), [thm_56](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L54-L60)~[thm_60](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L136-L143)): $(n - a t_p) - (m - a t_p) = n - m$ 위상 소거와 보나미 초수축 항등식 $(a+b)^4 + (a-b)^4 - 2(a^4+b^4) = 12a^2b^2 \ge 0$으로 고가중치 제곱인수 없음 지수를 $-625K$로 제어.
  3. 5절 랭크-2 블록 노름 고유값 상한 및 푸리에 공급 수축 ([thm_14](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L296-L309)~[thm_15](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L317-L331), [thm_61](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L153-L182)~[thm_64](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L224-L233)): 특성다항식 판별식 $(a-d)^2 + 4b^2 \ge 0$과 블록 노름 주 기울기 $s_p(1,1) = 1 - (2t_0/p^2)\lVert\Pi_p F_p\rVert^2 + O(\varepsilon_0/p) \le 1 - (1.7 - O(\varepsilon_0))/p$을 통해 희소 스펙트럼 가정을 $1 - \frac{8}{5}\cdot\frac{17}{25} = -\frac{11}{125} < 0$으로 기각.
  4. 6·8·9절 아핀 충돌 인수분해, 선형형식 소행렬식 판정·슈바르츠-지펠 및 이진 트리 귀류 ([thm_21](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L30-L46)~[thm_35](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L278-L285), [thm_65](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L243-L253)~[thm_75](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L409-L418)): 아핀 충돌 $(u_1 - u_2)(1 - (u_1+u_2)t) = 0$과 [08-arithmetic.tex:407-497](../proofs/oai_ref/tex/sections/08-arithmetic.tex#L407-L497)의 분모 소거 $2\times 2$ 선형형식 소행렬식 판정·슈바르츠-지펠 근 상한(독립 대수 소행렬식 모델 `thm_69`–`thm_70`, `thm_75` 병행 검증)을 트리 순열 감쇠($\frac{2}{5} - \frac{3}{4} = -\frac{7}{20} < 0$) 상한과 충돌시켜 귀류법 완결.

### 5.2 독립 Lean 4 재검증(75개 정리, 393/393 변이 포착) 및 유효 문턱값 단축 수리

1. 슬롯별 완전순열($t_1 = 0$) 복원으로 나쁜 순열 완전 소멸 및 트리 깊이 85.2% 단축 (`k_min`: 7,041 -> 1,040):
   - [thm_41](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L381-L388)·[thm_42](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L396-L405)·[thm_44](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L428-L442)를 통해 한 쌍의 슬롯에 완전순열($\sigma_2(l) \neq \sigma_1(l)$)을 부여하면 $t_1 = 0 \implies 4(r-t) \ge 2r > r$이 되어 나쁜 순열 집합이 공집합이 되고, 최소 트리 깊이가 7,041에서 1,040(6,001단계 절감)으로 단축됨.
2. 타투자와 정리(384,002) 및 $2^k$ 약분을 통한 명시적 유효 문턱값 16.08배 단축 (`L_eff`: 4,115,904 -> 640,722 -> 255,983):
   - [thm_47](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L495-L506)~[thm_50](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L552-L562)을 통해 `ZeroDensity/HadamardPrimeBound.lean:48`(`oai_ref/` 미수록)의 비효과적 시겔 정리 호출 1곳을 타투자와 정리 + 소인수 1개 추가 제거($\lvert D_{\mathrm{ext}}\rvert \le 3$)로 대체하고 [MovingStatisticDecay.lean](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Arithmetic/MovingStatisticDecay.lean#L12)의 $2^k$ 인수를 약분하여, 무조건부 유효 로그-로그 반례 문턱값을 4,115,904에서 640,722(방관자 셀 확장 시 255,983)로 단축함.

### 5.3 [InverseGoldbach.lean:13-21](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/InverseGoldbach.lean#L13-L21)의 14개 `Published*` 해석적 가설 명세 검증 및 업스트림 패치·전이 폐포 실측

1. 14개 `Published*` 해석적 수론 가설의 명세 약화(Spec Weakening) 여부 전수 대조 (약화 0건, `sorryAx` = 0):
   - [InverseGoldbach.lean:13-21](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/InverseGoldbach.lean#L13-L21)이 입력으로 받는 14개 가설(`P0 : PublishedProgressionInput`, `ls : PublishedAdditiveLargeSieve`, `hsize : PublishedSummandSizeBound`, `hBonami : PublishedBonamiBound`, `Hreal : PublishedRealZeroInput P0`, `hSiegel : PublishedSiegelBound`, `sieve : PublishedQuadraticLargeSieve`, 및 `(CM CH : ℝ)`, `hM : MertensEstimate CM`, `hMH : MertensHarmonicEstimate CH`, `Z : ∀ χ, ComplexZeroEnumeration χ`, `hD : PublishedComplexZeroDensity Z`, `hR : PublishedComplexZeroRegion Z`, `Pexplicit : PublishedSmoothExplicitFormula Z`, `hPNT : PublishedSmoothPrincipalPNT`)의 정의식을 전수 대조한 결과, 모든 명제가 표준 `Nat.Prime` 및 `DirichletCharacter.LFunction` 위에서 고전 정리(Montgomery-Vaughan 1973, Elsholtz 2006, Bonami 1970, Page-Siegel 1935, Heath-Brown 1995, Montgomery 1969)와 일치하며, 특히 [ComplexDensityProof.lean:28](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/ZeroDensity/ComplexDensityProof.lean#L28)의 `publishedComplexZeroDensity`가 `actualCharacterZeros`($\mathbb{N} \simeq \{p : \mathbb{C}\times\mathbb{N} \mid \chi.L(p.1)=0 \wedge p.2 < \mathrm{analyticOrderNatAt}\}$ 전단사)에 대해 증명되어 빈 열거 우회가 원천 차단되어 있음.
   - 두 비교 챌린지([OstmannComplete.json](../proofs/oai_ref/lean/ComparatorChallenges/OstmannComplete.json#L1-L15), [OstmannPrimes.json](../proofs/oai_ref/lean/ComparatorChallenges/OstmannPrimes.json#L1-L14))의 `"enable_nanoda": false`는 저장소 전체 418개 챌린지 중 413개(98.80%)에 설정된 전역 기본값(`vm.max_map_count` 한계)이며, 도달 가능한 전 모듈(3,207개 및 4,358개)에서 `sorry` / `sorryAx` / 사용자 `axiom` / `native_decide` / `unsafe`는 모두 0건임.
2. 업스트림 호환성 패치 내 +47,394줄 외부 네임스페이스 코드 배치 · Apache 2.0 NOTICE.md 누락 · 주석 2,253줄 바이트 보존 공백(0x20) 치환:
   - 엔진 B([OstmannPrimes.json](../proofs/oai_ref/lean/ComparatorChallenges/OstmannPrimes.json#L1-L14) $\to$ [Main.lean](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Main.lean#L1))의 전이 의존성 사슬에 포함된 업스트림 패치 2종을 실측한 결과:
     - PrimeNumberTheoremAnd 패치: 업스트림에 없던 `PrimeNumberTheoremAnd/Erdos970/*` 신규 모듈 20개(+21,197줄)를 추가했으며, 이 중 Erdos970 하위의 아다마르 보조 파일(+6,805줄, 31개 섹션)은 동일 패치 내 SiegelZeros 모듈(11개 파일, 228 / 228개 선언 100% 일치)을 단일 파일로 병합 복제하면서 SiegelZeros/NOTICE.md에 수록된 원저작자 고지(Copyright 2025 Stefan Kebekus, 2026 Matteo Cipollina, Apache 2.0)를 Erdos970/ 디렉터리에서 누락(0건)하고 주석 91줄을 공백 문자열(0x20)로 치환함.
     - StrongPNT 패치: `StrongPNT/Erdos970/*` 신규 모듈 8개(+26,197줄)를 추가하면서 원 파일의 주석·블루프린트·헤더 2,162줄을 원래 바이트 길이와 동일한 아스키 공백(0x20)으로 치환함(PNT4 702줄, PNT1 580줄, PNT3 478줄, PNT2 338줄 등).
   - 반면 #013 원고 본문과 `references.bib`(35종 인용; 파일 `oai_ref/` 미수록)에는 엔진 A·B가 실제 임포트한 외부 Lean 저장소 3곳(`PrimeNumberTheoremAnd`, `StrongPNT`, 그리고 엔진 A가 이차 가우스 합 부호 결정에 사용한 `CBirkbeck/AINTLIB` `BernoulliRegular`)에 대한 인용이 0건임(단, 엔진 A [Complete.lean](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Complete.lean#L1-L26)은 위 `Erdos970` 패치 모듈 없이 독립 성립함).
3. 표면 임포트(1 대 18) 하위 전이 폐포 의존성(42 대 183개 외부 OAI 모듈), `formalization.yaml` 누락 및 미사용 가설 952건:
   - 표면 직접 임포트(1개 대 18개)의 전이 폐포를 끝까지 전개하면 엔진 A(`Complete.lean`)는 #026 `PrimeGaps.*` 42개 모듈(3,207개 콘)을, 엔진 B(`Main.lean`)는 #021 `Jacobsthal.*` 136개(`Jacobsthal/Siegel/*` 105개 포함) + #026 `PrimeGaps.*` 47개 = 총 183개 외부 OAI 모듈(4,358개 콘)을 원고 공시 없이 호출하며, 저장소 루트 `formalization.yaml`(176편 공식 목록, `oai_ref/` 미수록)에 #013이 누락되어 있고 내부 보조정리 계층에 미사용 가설 바인더 952건이 존재함.



## 제6부. 필수 아키텍처·서지 수리 명세 (Actionable Repair Specification)

1. 쌍둥이 엔진 단일화 및 미도달 화석 381개 파일(39,517줄) 정리:
   - 외부 의존성이 1개뿐인 하향식 엔진 A([Complete.lean](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Complete.lean#L1-L26)) 또는 모듈화된 엔진 B([Main.lean](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Main.lean#L1)) 중 하나로 증명 트리를 통합하여 중복 빌드 파일 3,160+개를 제거하고, 미도달 화석 381개 파일([All.lean](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/All.lean#L1), [PaperMain.lean](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/PaperMain.lean#L1) 포함)을 아카이브에서 분리.
2. 비효과적 `PublishedSiegelBound` 분해 대체, 16.08배 이완 압축 및 `Erdos970` 고지·주석 복구:
   - `ZeroDensity/HadamardPrimeBound.lean:48`(`oai_ref/` 미수록)의 시겔 정리 호출 1곳을 타투자와 정리(384,002, [thm_47](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L495-L506)~[thm_50](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L552-L562))로 대체하고 $(S_r)^m$ 및 $\kappa=33/20$ 복원([thm_41](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L381-L388)~[thm_45](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L451-L464))으로 문턱값을 압축($k_{\min}: 7,041 \to 1,040$, $L_{\mathrm{eff}}: 4,115,904 \to 255,983$)하며, `Erdos970/` 디렉터리 내 누락된 `SiegelZeros/NOTICE.md` 및 0x20 공백 치환 주석 2,253줄을 복구하고 `formalization.yaml`(`oai_ref/` 미수록)에 #013을 등재.
3. 7·9장 인용 공백 해소, 3절 고전 1차 원전 복원 및 #021·#026 외부 모듈 차용 명시:
   - 3절에 Page (1935) 및 Siegel (1935) 1차 문헌과 외부 Lean 저장소(`PrimeNumberTheoremAnd`, `StrongPNT`, `CBirkbeck/AINTLIB`) 인용을 복원하고, 7·9장 인용 공백을 채우며 엔진 B가 임포트하는 #021(`Jacobsthal` 15개·전이 136개) 및 #026(`PrimeGaps` 3개·전이 47개) 모듈 의존성을 원고에 투명하게 기재.



## 제7부. 국제 학술기준 대비 불부합 대조표, 3층 기여도 분리 및 최종 판정 (Standard-Bound Verdict)

### 7.1 국제 출판·형식검증 가이드라인 대조표 (COPE · IMU/AMS · ACM v1.1 · ICMJE/CRediT · NeurIPS)

| 국제 표준 대비 불부합 범주 | 준거 국제 가이드라인 조항 | 본 사건(#013 Ostmann) 확정 좌표 및 물리적 관측 수치 | 최종 판정 |
| :--- | :--- | :--- | :---: |
| 아티팩트 패키징 및 원고-코드 불일치 (Paper-Artifact Divergence / Gate 2) | ACM Artifact Review v1.1 (출판 원고와 제출 코드 구조의 1대1 대응, 불필요한 중복·미도달 화석 배제 및 업스트림 라이선스 보존 요건) | • 동일 정리를 증명하는 두 개의 독립 트리(`Complete.lean` 3,165개 vs. `Main.lean` 4,175개, 교집합 5개 = 0.065%)와 381개 미도달 화석(39,517줄, 루트 `All.lean`·`PaperMain.lean` 포함)이 혼재되어 7,716개 파일(609,199줄)로 팽창함<br>• `Erdos970` 패치(+47,394줄)에서 `SiegelZeros/NOTICE.md`가 누락되고 주석 2,253줄이 0x20 공백으로 치환되었으며, 4대 전술 이완이 `L_eff`를 16.08배 팽창시킴 | 불일치 (Paper-Artifact Divergence) |
| 선행 문헌 귀속 결손 및 미공시 교차 차용 (Attribution Deficit / Gate 3) | COPE Citation Guidelines / AMS Ethical Guidelines (기술 본문 내 1차 원전 귀속 및 코드 의존성 일치 요건) | • 서론(2.32% 분량)에 전체 인용의 34.62%(18/52건)가 집중된 반면, 7장(784줄)과 9장(386줄)은 인용이 0건임<br>• 원고 Remark 5.4는 코드에서 쓰지 않는 #003(0건 임포트)을 인용하면서, 실제 엔진 B가 임포트하는 #021(15개)·#026(3개) 외부 파일 18개, Page (1935)·Siegel (1935)(3절 1차 원전), 및 외부 Lean 저장소 3종을 누락함 | 귀속 결손 (Attribution Deficit) |
| 생성 프로비넌스 미제공 (Provenance Omission / Gate 4) | NeurIPS Code & Data Guidelines / ICMJE (대규모 자동 생성 산출물의 생성 로그·매니페스트 등록 및 버전 계보 공시 요건) | • 저장소 최대 규모(7,716개 파일)임에도 추론 로그(`reasoning_traces`) PDF가 0편이며, 3세대 진화 과정(1A 패리티 화석 $\to$ 1B 엔진 A $\to$ 2 엔진 B)이 설명 없이 단일 디렉터리에 병치되었고 `formalization.yaml`(`oai_ref/` 미수록)에서 #013이 누락됨 | 기준 미충족 |

### 7.2 인간 · 컴퓨터 보조 증명(CAS/ITP) · 자동 에이전트 파이프라인 3층 기여도 분리

1. 인간 선행 수론·조합론·해석학 자산 없이는 성립 불가능한 기반 (단독 AI 해결 가능성 0%):
   - 본 증명의 뼈대를 이루는 유한 가산항 환원(Ostmann 1956, Hornfeck 1954–1955, Elsholtz 2001–2006, Elsholtz-Harper 2015, Green-Harper 2014), 부호 초수축 부등식(Bonami 1970), 이차 지표 쌍선형 합(Heath-Brown 1995), 영점 밀도 및 예외 영점 이론(Page 1935, Siegel 1935, Montgomery 1969), 다중그래프·아핀 불변량(Kneser 1953, Gowers 2008, Babai-Nikolov-Pyber 2008), 그리고 슈바르츠-지펠 보조정리(Schwartz 1980, Zippel 1979, DeMillo-Lipton 1978) 및 인간 커뮤니티가 구축한 Mathlib 4 라이브러리가 없었다면 AI가 백지상태에서 이 문제를 정의하거나 증명할 가능성은 0%입니다.
2. 유효한 수리 아키텍처 결합 및 Lean 4 무공리(0 `sorry`) 형식화 성취 (Gate 1 & Gate 5: PASS):
   - 기존 인간 연구자들이 엘숄츠-하퍼-그린의 체법 상한에서 멈췄던 패리티·위상 상쇄 장벽을 돌파하기 위해, ① 3절 공통 유리 중심 리프트($h/m$), ② 5절 랭크-2 제곱 전달 커널($K^2$, 블록 노름 기울기 $2t_0 = 1.7 > 1.6$), ③ 6절 2차 아핀 연산자 $U_u F(t) = F(u - u^2 t)$와 8절 분모 소거 $2\times 2$ 선형형식 소행렬식 판정·슈바르츠-지펠 상한을 5단 이중 로그 스케일 계층 위에서 결합하여 0 sorry로 완결한 것은 최상위 수학 학술지 수준의 유효한 수리·형식증명 성취입니다.
3. 자동 멀티에이전트 패키징 파이프라인에서 발생한 중복·화석·고지 누락 (Gate 2~4: FAIL):
   - 멀티에이전트 병렬 생성 파이프라인이 1A세대 패리티 원형(379개 파일)에서 1B세대 엔진 A(3,165개 파일), 2세대 엔진 B(4,175개 파일)로 재구축하는 과정에서 이전 세대 코드와 루트 래퍼([All.lean](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/All.lean#L1), [PaperMain.lean](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/PaperMain.lean#L1))를 정리하지 않고 한 폴더에 합쳐 7,716개 파일(609,199줄)의 쌍둥이 중복·화석 적체를 만들었으며, 전술 자동화를 위해 $S_{rm}$ 확장·$\kappa=8/5$ 반올림·비효과적 시겔 가설 전달을 택해 반례 문턱값을 16.08배 이완시키고 7·9장 인용 공백과 교차 의존성(#021·#026) 미공시 및 `Erdos970` 패치 내 `SiegelZeros/NOTICE.md` 누락과 주석 2,253줄 0x20 공백화를 남겼습니다.

### 7.3 예상 반론에 대한 사전 사실 확인 (Pre-bunking FAQ 6문 6답)

- Q1. "폴더 안에 7,716개 파일(609,199줄)이 들어 있다는 것은 증명이 그만큼 방대하고 복잡하다는 뜻 아닌가?"
  - 사실 확인: 7,716개 파일이 하나의 단일 증명 사슬을 이루는 것이 아닙니다. 동일한 주정리를 증명하는 두 개의 별도 증명 트리인 엔진 A([Complete.lean](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Complete.lean#L1-L26), 3,165개 파일)와 엔진 B([Main.lean](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Main.lean#L1), 4,175개 파일)가 기초 정의 단 5개 파일(372줄, 0.065%)만 공유한 채 중복 구축되어 있고, 여기에 양쪽 어디에서도 쓰이지 않는 381개 화석 파일(39,517줄)이 합쳐진 결과입니다([thm_01](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L30-L48)~[thm_03](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L71-L90)).
- Q2. "원고 5절 Remark 5.4에 OpenAI #003(QRH)이 인용되어 있으니, #003의 조건부 한계에 종속되는 것 아닌가?"
  - 사실 확인: 원고 Remark 5.4가 #003을 선택적 비고로 언급할 뿐, 실제 Lean 코드(엔진 A·B 모두)는 `OAI.NumberTheory.DirichletL`(#003)을 단 한 줄도 임포트하지 않으며(0건) 고전 몽고메리 영점 밀도와 란다우-페이지 예외 영점 제거만으로 완전 독립 증명되어 있습니다([thm_19](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L386-L395)).
- Q3. "엔진 A의 33개 파일에 비효과적 시겔 정리(`PublishedSiegelBound`)가 등장하므로 명시적 반례 크기를 계산할 수 없는 비구성적 증명 아닌가?"
  - 사실 확인: 원본 엔진 A는 `ZeroDensity/HadamardPrimeBound.lean:48`(`oai_ref/` 미수록) 1곳에서 시겔 정리를 분해하여 비효과적이었으나, 독립 재검증 [thm_46](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L476-L486)~[thm_50](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L552-L562)에서 타투자와 정리(384,002)와 예외 소인수 1개 추가 제거($\lvert D_{\mathrm{ext}}\rvert \le 3$)로 이를 완전 유효화하여 명시적 로그-로그 반례 문턱값 $L_{\mathrm{eff}} = 640,722$ (초정밀 $255,983$)를 구성적으로 확립했습니다.
- Q4. "엔진 B `Conclusion/Scales.lean`의 0 기반 색인이나 이완된 상수(`Bs=200`, `BD=322`)가 이진 트리 상한을 해치는가?"
  - 사실 확인: 아닙니다. [Conclusion/Scales.lean:51-83](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Conclusion/Scales.lean#L51-L83)은 `Finset.range k` 위에서 구조적 귀납법(`induction k`)으로 `sum_dyadic`과 `sum_dyadic_log`를 직접 증명해 [09-conclusion.tex:355-358](../proofs/oai_ref/tex/sections/09-conclusion.tex#L355-L358)의 1기반 합산과 일치하며, 독립 재검증 [thm_21](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L30-L46)~[thm_26](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L132-L144)이 모든 $k \in \mathbb{N}$에 대해 이를 독립 재검증했고 [thm_41](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L381-L388)~[thm_44](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L428-L442)가 $k_{\min}$을 7,041에서 1,040으로 단축했습니다.
- Q5. "[SiegelBoundProof.lean:81](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/ZeroDensity/SiegelBoundProof.lean#L81)의 `2 / η = 8 / ε = 1600` 분기가 원고 3절의 $\varepsilon_1 = 1/200$ 시겔 상한과 충돌하지 않는가?"
  - 사실 확인: 충돌하지 않습니다. [QuadraticSplitSupply.lean:25-33](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Quadratic/QuadraticSplitSupply.lean#L25-L33)은 $\varepsilon = 1/200$에서 `(40000 * K)^2 <= L`을 요구하고, [SiegelBoundProof.lean:17,81](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/ZeroDensity/SiegelBoundProof.lean#L81)은 `η = min (ε/4) (1/4)`($\varepsilon = 1/200$에서 `1/800`)로 설정하여 `¬ hnear` 분기에서 `(1 - e.beta)^{-1} <= 2/η = 8/ε = 1600`을 증명하며, [thm_10](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L218-L234) 및 [thm_46](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L476-L486)~[thm_50](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L552-L562)이 타투자와 정리 대체를 통해 비효과적 분기까지 완전 유효화했습니다.
- Q6. "그렇다면 #013은 #376(나비에-스토크스)처럼 문제를 축소·변형한 것인가, 아니면 진짜 난제를 푼 것인가?"
  - 사실 확인: #376과 달리 #013은 오스트만 역 골드바흐 추측의 원래 명제($\lvert A\rvert\ge 2 \wedge \lvert B\rvert\ge 2 \implies (A+B)\triangle\mathcal{P}$ 무한)를 표준 Mathlib `Nat.Prime` 위에서 축소나 변형 없이 그대로 증명했습니다(Gate 1 & Gate 5: PASS). 지적된 결함들은 수학적 진리값의 오류가 아니라 쌍둥이 트리 중복 패키징, 381개 미도달 화석, `Erdos970` 패치 고지(`NOTICE.md`) 누락 및 주석 공백화, 7·9장 인용 누락 및 #021·#026 교차 임포트 미공시라는 아티팩트·서지 정합성 문제입니다.

### 7.4 10초 터미널 재현 명령어

```bash
# 1) 75개 독립 Lean 4 정리 커널 검증 및 SymPy 대수·문턱값 검산 (EXIT 0)
lean proofs/ostmann_twin_engines_and_supply_contraction.lean && \
  lean proofs/ostmann_tree_transfers_and_permutation_contradiction.lean && \
  lean proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean && \
  (cd proofs && python3 -B verify_symbolic_ostmann.py)

# 2) SHA-256 체크섬, 393/393 가설 돌연변이 포착 및 #L 라인 링크 전수 검증 (EXIT 0)
sha256sum -c proofs/checksums.sha256 && python3 -B ../../tools/verify_all.py --root .
```

### 7.5 최종 심사 판정문 (Referee Verdict Summary)

- 최종 판정: TIER C (Valid Mathematical Core & Non-Conforming Artifact Packaging): 수리 코어(Gate 1·5: PASS) 채택 권고 / 쌍둥이 중복 트리 정리·Erdos970 고지 복원 및 7·9장 서지·교차 의존성(#021·#026) 보완 후 게재(Accept after Artifact & Bibliographic Revision)
- 
- OpenAI #013(The additive indecomposability of the primes)은 1950년 제기된 오스트만 역 골드바흐 추측(Erdős #431)을 유한 가산항 CRT 합성수 증인, 공통 유리 중심 리프트와 보나미 4차 모멘트, 랭크-2 제곱 전달 커널($K^2$, 블록 노름 기울기 $2t_0 = 17/10 > 8/5$) 푸리에 공급 수축(-11/125 < 0), 그리고 2차 아핀 연산자·[08-arithmetic.tex:407-497](../proofs/oai_ref/tex/sections/08-arithmetic.tex#L407-L497)의 분모 소거 $2\times 2$ 선형형식 소행렬식 판정 및 슈바르츠-지펠 상한·이진 트리 순열 감쇠(2/5 - 3/4 = -7/20 < 0)의 결합으로 표준 Mathlib 정의 위에서 0 `sorry`, 0 `axiom`으로 완결하여 Gate 1 (수리·커널): PASS 및 Gate 5 (수리 가치): PASS를 충족한다.
- 
- 다만 제출된 저장소 패키징과 원고 서지는 (1) 동일한 정리를 증명하는 쌍둥이 엔진(`Complete.lean` 3,165개 vs. `Main.lean` 4,175개, 공유 코어 5개 = 0.065%)과 381개 미도달 화석(39,517줄, 루트 `All.lean`·`PaperMain.lean` 포함)의 무정리 병치, (2) +47,394줄 규모 `Erdos970` 업스트림 패치 내 `SiegelZeros/NOTICE.md` 누락·주석 2,253줄 0x20 공백 치환·`formalization.yaml`(`oai_ref/` 미수록) #013 누락 및 16.08배 문턱값 이완, (3) 원고 7장(784줄)·9장(386줄)의 인용 0건 기근, 3절 고전 1차 원전(Page 1935, Siegel 1935) 및 외부 Lean 저장소 3종(`PrimeNumberTheoremAnd`·`StrongPNT`·`CBirkbeck/AINTLIB`) 누락, 그리고 코드에서 쓰이지 않는 #003 인용 대 미공시 #021·#026 외부 모듈 18개(전이 183개) 차용으로 인해 현 상태 아티팩트 기준 TIER C로 판정하며, 위 패키징 정리·라이선스 복원 및 서지 보완 반영 시 최상위 수론 학술지 정식 게재 등급(TIER A/S)으로 승격 가능함을 확인한다.
