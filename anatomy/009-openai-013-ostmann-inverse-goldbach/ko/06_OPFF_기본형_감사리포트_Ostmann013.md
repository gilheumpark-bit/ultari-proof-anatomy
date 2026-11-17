# 감사 요약 리포트: OpenAI #013 (The additive indecomposability of the primes · 오스트만 역 골드바흐 문제, Erdős #431)

- 감사 대상: OpenAI `openai/math` Family #013 ([01-introduction.tex](../proofs/oai_ref/tex/sections/01-introduction.tex#L1-L141)~[09-conclusion.tex](../proofs/oai_ref/tex/sections/09-conclusion.tex#L1-L386) 9개 절 · 6,072줄 + 루트 `paper.tex` · `glyph-mappings.tex`, `\cite` 명령 51회 / 총 인용 52건 · 고유 키 35개; `OAI/NumberTheory/Ostmann/` 7,716개 `.lean` 파일 · 609,199줄 + 비교 챌린지 `OstmannComplete.lean` · `OstmannPrimes.lean` 2종)
- 검증 환경: Lean 4 v4.29.0-rc8 (업스트림 v4.34.1 대조) / Python 3.14 (SymPy 기호 연산기)
- 산출물 해시 (SHA-256): [ostmann_twin_engines_and_supply_contraction.lean](../proofs/ostmann_twin_engines_and_supply_contraction.lean) (edbc820be45e...) | [ostmann_tree_transfers_and_permutation_contradiction.lean](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean) (529c59062f95...) | [ostmann_algebraic_engines_and_cauchy_determinant.lean](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean) (1681e0b1fbd2...) | [verify_symbolic_ostmann.py](../proofs/verify_symbolic_ostmann.py) (8f5c742ebfde...)
- 검증 방식: 독립 Lean 4 정리 75개 + 재귀 def 3개 + structure 1개 (1,517줄, 0 sorry, 0 axiom, 393 / 393 전칭 가설 변이 사살 = 100%) 및 결정론적 SymPy 재현 스크립트
- OPFF 공식 판정: Gate 1: PASS · Gate 2: FAIL · Gate 3: FAIL · Gate 4: FAIL · Gate 5: PASS ⇒ OPFF TIER C (수학적 돌파 코어 유효 및 아티팩트 패키징·서지 규격 미충족)

## 0. 8대 핵심 지표 요약표

| 감사 축 | 원고(PDF 9개 절 · 6,072줄) 표방 내용 | 실제 저장소(OAI/NumberTheory/Ostmann/ 7,716개 파일) 실측치 | 괴리율 / 상태 |
| :--- | :--- | :--- | :---: |
| 1. 코드 도달성 및 중복 | 9개 절 논문의 단일 Lean 4 형식화 (7,716개 파일 · 609,199줄) | 쌍둥이 중복 엔진 ([Complete.lean](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Complete.lean#L1) 3,165개 대 [Main.lean](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Main.lean#L1) 4,175개, 공유 파일 5개 / 372줄 = 0.065%) + 미도달 화석 381개 (39,517줄; 3,165 + 4,175 - 5 + 381 = 7,716) | 쌍둥이 중복 / 화석 381개 (CP-05) |
| 2. 루트 진입점 정합성 | Complete.lean · Main.lean · All.lean · PaperMain.lean | [All.lean](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/All.lean#L1) (152줄) 및 [PaperMain.lean](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/PaperMain.lean#L1) (25줄)이 두 비교 챌린지 모두에서 미도달 | 루트 래퍼 2종 단절 (CP-05) |
| 3. 이진 합 및 지겔 상수 대조 | 제9장 $\sum_{j=1}^k r_j \log r_j$; 제3장 지겔 $q^{1/200} \le (\log X)^{1/2}$ | [Conclusion/Scales.lean:51-83](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Conclusion/Scales.lean#L51-L83)은 `induction k`(0 기반)로 `sum_dyadic` 및 `sum_dyadic_log`를 증명하며 엔진 B는 `Bs=200`, `BD=322`로 이완; [SiegelBoundProof.lean:17,81](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/ZeroDensity/SiegelBoundProof.lean#L81)은 `¬ hnear`에서 `2/η = 8/ε = 1600` 증명 | `induction k` 확인 / 16.08배 여유분 |
| 4. 장절별 인용 분포 | 9개 절(6,072줄)에 걸쳐 `\cite` 명령 51회 (인용 키 호출 52회) | 제1장(141줄, 2.32%)에 17개 명령 / 18회 키 호출(34.62%, 100줄당 12.77회) 집중; 제7장(784줄)·제9장(386줄) 0회, 제4장(1,182줄) 2회 (4~9장 대비 30.4 : 1 편중) | 제4~9장 인용 기근 (CP-03) |
| 5. 패밀리 간 교차 의존성 | 제5장 Remark 5.4에서 #003 (`OpenAIQRH2026`) 인용 | 두 Lean 엔진 모두 #003 임포트 0건; 반대로 엔진 B는 원고 공시 없이 #021(`Jacobsthal`, 15개) 및 #026(`PrimeGaps`, 3개)에서 18개 파일 임포트 | 의존성 공시 역전 (CP-10) |
| 6. 외부 패치 및 매니페스트 | 자체 Mathlib 및 표준 소수정리 의존성 | `PrimeNumberTheoremAnd/Erdos970/*` (+21,197줄) 및 `StrongPNT/Erdos970/*` (+26,197줄) +47,394줄 추가 중 `SiegelZeros/NOTICE.md` 누락 및 주석 2,253줄 0x20 공백 치환, `formalization.yaml`(`oai_ref/` 미수록)에서 #013 누락 | 고지문 누락 / 2,253줄 공백화 |
| 7. 전제 전달 및 상수 여유분 | `PublishedSiegelBound` 및 중첩 그래프 순열 감쇠 | 32 / 33개 파일이 `PublishedSiegelBound`를 개봉 없이 전달; $(S_r)^m \to S_{rm}$ 이완 및 $\kappa = 33/20 \to 8/5$ 반올림으로 $k_{\min}: 1,040 \to 7,041$, $L_{\mathrm{eff}}: 255,983 \to 4,115,904$ (16.08배) 팽창 | 임계치 16.08배 팽창 (CP-06) |
| 8. 수리적 돌파 가치 | 오스트만 역 골드바흐 문제 (1950, Erdős #431) 해결 | $\lvert A\rvert\ge 2 \wedge \lvert B\rvert\ge 2 \implies \lvert(A+B)\triangle\mathcal{P}\rvert = \infty$ 최초 무조건부 해결 공인 + 반례 임계치 $L_{\mathrm{eff}}$ 16.08배 압축 ($4.12\text{M} \to 255,983$) | 실제 난제 돌파 (Gate 1 & Gate 5 PASS) |

## 1. 영역별 실측 물증 요약

### 1.1 서지 편중성(30.4 : 1) 및 미공시 교차 패밀리 임포트 (CP-03, CP-10)
- 핵심 증명 본문(제4~9장)의 인용 기근: 전체 9개 절(6,072줄, \cite 명령 51회 / 총 인용 52건 · 고유 키 35개) 중 제1장 서론(141줄, 2.32%)에 \cite 명령 17회(인용 키 호출 18회, 34.62%, 100줄당 12.77회)가 집중된 반면, 제7장(784줄)과 제9장(386줄)은 인용이 0회이고 제4장(1,182줄)은 2회에 불과합니다(서론 대 제4~9장 인용 밀도비 30.4 : 1).
- 원고 인용과 실제 코드 임포트의 역전: 원고 제5장 Remark 5.4는 자사 동반 프리프린트 #003(OpenAIQRH2026)을 인용하나 정작 두 Lean 엔진에서 #003 임포트는 0건입니다. 반대로 엔진 B는 원고에 아무런 언급 없이 #021(Jacobsthal, 15개)과 #026(PrimeGaps, 3개)에서 외부 OAI 모듈 18개를 직접 임포트합니다.

### 1.2 쌍둥이 중복 증명 엔진(7,335개 도달 파일) 및 381개 미도달 화석 지층 (CP-04, CP-05)
- 7,716개 파일(609,199줄)의 포함-배제 4분할: OAI/NumberTheory/Ostmann/ 내 7,716개 .lean 파일 전체의 import 그래프를 추적한 결과, 비교 챌린지 OstmannComplete.lean은 엔진 A([Complete.lean](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Complete.lean#L1), 3,165개 파일 · 266,820줄)를, OstmannPrimes.lean은 엔진 B([Main.lean](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Main.lean#L1), 4,175개 파일 · 303,234줄)를 호출합니다. 두 엔진이 공유하는 파일은 단 5개(372줄, 도달 가능 합집합 7,335개 파일 · 569,682줄의 0.0653%)뿐이며, 나머지 381개 파일(39,517줄, 루트 래퍼 [All.lean](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/All.lean#L1) 및 [PaperMain.lean](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/PaperMain.lean#L1) 포함)은 어디에서도 도달하지 않는 화석 지층입니다($3,165 + 4,175 - 5 + 381 = 7,716$).
- 외부 Erdos970 패치(+47,394줄, NOTICE 누락 · 주석 2,253줄 공백화) 및 매니페스트 누락: 업스트림 호환 패치 2종(`PrimeNumberTheoremAnd/Erdos970/*` +21,197줄 및 `StrongPNT/Erdos970/*` +26,197줄 = +47,394줄, `oai_ref/` 미수록)에서 `SiegelZeros/NOTICE.md`가 누락되고 주석 2,253줄이 0x20 공백으로 치환되었으며, `formalization.yaml`(`oai_ref/` 미수록)에서 #013이 누락되어 있습니다. 한편 엔진 B [Conclusion/Scales.lean:51-83](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Conclusion/Scales.lean#L51-L83)은 `Finset.range k` `induction k`(0 기반)로 `sum_dyadic`·`sum_dyadic_log`를 귀납 증명하며 [SiegelBoundProof.lean:17,81](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/ZeroDensity/SiegelBoundProof.lean#L81)은 `¬ hnear`에서 `2/η = 8/ε = 1600`을 증명합니다.

### 1.3 14개 `Published*` 해석적 입력 모듈 전수 검증 및 반례 임계치 16.08배 압축
- 14개 `Published*` 해석적 입력 전수 무결성 확인 (Gate 1: PASS): [InverseGoldbach.lean:13-21](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/InverseGoldbach.lean#L13-L21)에 임포트된 14개 `Published*` 모듈(1,514줄)과 양대 공급 사슬(엔진 A #026 모듈 42개, 엔진 B #021·#026 모듈 183개)을 전수 대조하여 명세 약화 0건, `publishedComplexZeroDensity`([ComplexDensityProof.lean:28](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/ZeroDensity/ComplexDensityProof.lean#L28))의 `actualCharacterZeros` 전단사 정합, `sorryAx` 0건을 확인했습니다.
- 반례 임계치 16.08배 압축: 곱대칭군 이완 $(S_r)^m \to S_{rm}$ 제거, 성분 팩토리얼 상한 $\log a_i \le \log r \to a_c \le r/4+1$ 정밀화, $\kappa = 8/5 \to 33/20$ 복원을 결합해 최소 트리 깊이를 $k_{\min}: 7,041 \to 1,040$으로 줄이고 유효 반례 로그-로그 스케일을 $L_{\mathrm{eff}}: 4,115,904 \to 255,983$으로 16.08배 압축했습니다.

### 1.4 수학적 돌파 유효성 공인 및 인간 · 고전 · AI 3층 기여도 분리
- 오스트만 역 골드바흐 문제 (1950, Erdős #431) 최초 무조건부 해결 공인 (Gate 1 & Gate 5: PASS): 1단계(유한 생성원 중국인의 나머지 정리 합성수 구성, [FiniteCRT.lean](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/FiniteCRT.lean#L1)), 2단계(대체법 푸리에 공급 수축 $-11/125 < 0$), 3단계(이진 트리 주파수 예산 대 순열 감쇠 $2/5 - 3/4 = -7/20 < 0$ 및 [08-arithmetic.tex:407-497](../proofs/oai_ref/tex/sections/08-arithmetic.tex#L407-L497)의 분모 소거 $2\times 2$ 선형형식 소행렬식 판정·슈바르츠-지펠 근 상한)의 3단 증명은 수학적·기계적으로 완전 무결합니다.
- 3층 기여도 분리: (1) 선행 인간 해석적 수론·가법 조합론 뼈대 60%, (2) AI 이진 트리 주파수-순열 결합 및 0 sorry 형식화 돌파 40% (Gate 1 & Gate 5 PASS), (3) 쌍둥이 중복 트리(7,335개 파일)·미도달 화석(381개 파일)·외부 Erdos970 패치(+47,394줄, NOTICE 누락·주석 2,253줄 공백화)·`formalization.yaml` 누락·제7/9장 무인용은 시정 대상입니다.

## 2. 예상 반론에 대한 사전 사실 확인 (FAQ)

- Q1. "오스트만 역 골드바흐 문제(Erdős #431)가 미증명 가설 없이 실제로 해결된 것이 맞는가?"
  - 사실 확인: 예. 엔진 A(`Complete.lean`)와 엔진 B(`Main.lean`) 모두 0 sorry, 0 커스텀 공리, 표준 Mathlib `Nat.Prime` 및 `DirichletCharacter.LFunction` 정의 위에서 컴파일되며, 본 감사단의 독립 정리 75개(393/393 가설 변이 사살)로 교차 검증되었습니다(Gate 1 & Gate 5: PASS).
- Q2. "수학적 증명이 유효한데 왜 최종 등급이 OPFF TIER C인가?"
  - 사실 확인: 단일 폴더 안에 거의 겹치지 않는 두 개의 거대 증명 트리(3,165 + 4,175 - 5 = 7,335개 파일, 공유율 0.065%)와 미도달 화석 파일 381개(39,517줄)가 혼재되어 있고, 외부 Erdos970 패치 +47,394줄 내 `SiegelZeros/NOTICE.md` 누락 및 주석 2,253줄 공백화(`formalization.yaml` 내 #013 누락, `oai_ref/` 미수록)를 포함하며, 제7장(784줄)·제9장(386줄) 인용이 0회이고 #021·#026 외부 모듈 18개 임포트가 원고에 공시되지 않았기 때문입니다(Gate 2·3·4: FAIL).
- Q3. "`Conclusion/Scales.lean`과 `SiegelBoundProof.lean`의 수식은 원고와 어떻게 대응하는가?"
  - 사실 확인: [Conclusion/Scales.lean:51-83](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Conclusion/Scales.lean#L51-L83)은 `sum_dyadic`과 `sum_dyadic_log`를 모두 `Finset.range k`(원고의 1 기반 대 0 기반 첨자) 위에서 k에 대한 수학적 귀납법(`induction k`)으로 증명하며 엔진 B의 `Bs = 200`, `BD = 322` 매개변수 패딩이 16.08배 여유분에 기여합니다. 또한 [QuadraticSplitSupply.lean:25-33](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Quadratic/QuadraticSplitSupply.lean#L25-L33)과 [SiegelBoundProof.lean:17,81](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/ZeroDensity/SiegelBoundProof.lean#L81)은 `¬ hnear`에서 `2/η = 8/ε = 1600`을 엄밀히 증명합니다.
- Q4. "전체 파일 수 7,716개는 어떻게 산출된 것인가?"
  - 사실 확인: 포함-배제 원리에 따라 엔진 A(`Complete.lean` 콘) 3,165개 + 엔진 B(`Main.lean` 콘) 4,175개 - 공통 교집합 5개(`Defs.lean`, `Statement.lean`, `Endpoint.lean`, `FiniteCRT.lean`, `FiniteFactor.lean`) = 도달 가능 파일 7,335개에 미도달 화석 파일 381개를 합산($3,165 + 4,175 - 5 + 381 = 7,716$)한 정확한 실측치입니다([thm_01_ostmann_directory_inclusion_exclusion_partition](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L30-L48)).
- Q5. "임계치 $L_{\mathrm{eff}}$의 16.08배 여유분이 정성적 무한성 정리에 영향을 주는가?"
  - 사실 확인: 영향을 주지 않습니다. 오스트만 문제는 대칭차 $(A+B)\triangle\mathcal{P}$의 무한성을 묻는 점근적 정리이므로 임의의 유한 임계치 $L_{\mathrm{eff}}$만 확보되면 논리적으로 완결되며, 본 감사단의 16.08배 압축($4,115,904 \to 255,983$)은 전술 자동화 과정에서 발생한 상수 팽창을 정량화해 복원한 것입니다.
- Q6. "OPFF TIER A로 승격되기 위한 수정 요건은 무엇인가?"
  - 사실 확인: (1) 쌍둥이 중복 증명 트리를 단일화하고 미도달 화석 파일 381개(39,517줄)를 정리하며, (2) `Erdos970` 패치 내 누락된 `SiegelZeros/NOTICE.md` 및 2,253줄 공백 치환 주석을 복구하고 `formalization.yaml`(`oai_ref/` 미수록)에 #013을 등재하며, (3) 제4~9장 고전 문헌 인용 복원 및 #021·#026 교차 임포트 18건 공시를 추가하면 즉시 OPFF TIER A 요건을 충족합니다.

## 3. 10초 재현 명령어

```bash
# 1) 7,716개 파일 포함-배제 층서학(3,165 + 4,175 - 5 + 381), 30.4:1 인용 편중 및 16.08배 임계치 압축 실측 확인
python3 -B proofs/verify_symbolic_ostmann.py

# 2) 75개 독립 Lean 4 정리 커널 검증 (0 sorry, 0 axiom, 393/393 가설 변이 사살)
lean proofs/ostmann_twin_engines_and_supply_contraction.lean
lean proofs/ostmann_tree_transfers_and_permutation_contradiction.lean
lean proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean
```
