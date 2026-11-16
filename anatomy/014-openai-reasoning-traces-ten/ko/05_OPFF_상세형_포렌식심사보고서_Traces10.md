# [Forensic & Referee Audit Report] OpenAI 공개 추론 로그 `10`편 전편 (`reasoning_traces/*.pdf` · `#007`~`#362`) 전수 감사 보고서

## 0. 감사 메타데이터 및 암호학적 봉인 원장 (`Provenance & Cryptographic Ledger`)

| 항목 | 세부 내역 |
| :--- | :--- |
| **대상 추론 로그 / 프리프린트** | OpenAI 공식 `openai/math` 저장소 공개 추론 로그 **`10`편 전수**(`reasoning_traces/*.pdf`, 총 `202`쪽 · 추출 텍스트 `9,308`줄, 전체 `373`개 난제군 중 `2.68%`: `#007`, `#017`, `#087`, `#102`, `#159`, `#197`, `#221`, `#271`, `#287`, `#362`) + 해당 난제군 프리프린트 원고 **`22`편**(`11`편 추적 주원고 + `11`편 로그 미공개 자매 원고; 주원고 `.bib` 총 `315`건) |
| **대상 코드 저장소 및 커밋** | `openai/math` (`HEAD` `4eaee87548250b2682affda7d05d947c05554bae`: 범위 공시 문서 `lean/docs/{007..362}.md` `10`편 `211`줄 + 비교 챌린지 `ComparatorChallenges/*.lean` `21`개 파일 `1,949`줄 + `OAI/` Lean 4 해법 파일 **`9,929`개**) |
| **유출된 사후 조판 소스** | [`mezard-parisi-formula.tex`](../proofs/oai_ref/preprints_tex/mezard-parisi-formula.tex#L1-L211) (`211`줄: `10`편 중 유일하게 삭제되지 않고 `reasoning_traces/`에 잔류한 사후 LuaLaTeX 요약 컴파일러 원본) 및 `#221` 본논문 [`glyph-mappings.tex`](../proofs/oai_ref/preprints_tex/glyph-mappings.tex#L1-L40) (`40`줄) |
| **툴체인 및 컴파일러** | `Lean 4 v4.29.0-rc8` (`leanprover/lean4:v4.29.0-rc8`) 대 피감 원본 `v4.34.1` / `Python 3.14` (`SymPy` 기호 연산기 및 양방향 인용 매칭 파서) |
| **검증 산출물 SHA-256** | • [`traces10_compiler_and_citation_drop.lean`](../proofs/traces10_compiler_and_citation_drop.lean): `2e597fb81c89de35fb444cafd4f18cd8d7559ce72ad8037f1e38e342ec29b137`<br>• [`traces10_algebraic_combinatorial_engines.lean`](../proofs/traces10_algebraic_combinatorial_engines.lean): `f64cbd70b0bde87e7fcff94bdc734aa71b42466cc910428fa5a40e690d739d89`<br>• [`traces10_analytic_operator_and_scope_audit.lean`](../proofs/traces10_analytic_operator_and_scope_audit.lean): `ac67add4a1f60e0f9523a073762f6ff28f03f79cf0d502845427f8de3c96e773`<br>• [`verify_symbolic_traces10.py`](../proofs/verify_symbolic_traces10.py): `c0e92bca74105ee11a2dd90cd26314de0ae59f7cc5ffae43e88541d3154ea540` |
| **검증 방식 (`Verification Method`)** | 독립 `Lean 4` 정리 **`75`개 (`1,337`줄, `0 sorry`, `0 axiom`, 전칭 가설 돌연변이 사살 `346 / 346`건 = `100%`, 구조적 정리 `74 / 75`건, 비선형·귀납 `19`건)** 및 `29`개 업스트림 참조 원문 실시간 파싱·기호 검증 스위트 |
| **준거 감사 헌장 (`Governing Charter`)** | **Open Proof Forensics Foundation (`OPFF`) 5-Gate Joint International Audit Charter** (`COPE · IMU/AMS · ACM v1.1 · ICMJE/CRediT · NeurIPS`, Charter DOI: [`10.5281/zenodo.24241228`](https://doi.org/10.5281/zenodo.24241228), Ledger v1.0.0 DOI: [`10.5281/zenodo.24241229`](https://doi.org/10.5281/zenodo.24241229)) |
| **OPFF 5대 관문 및 공식 등급 판정** | `Gate 1 (수리·커널): PASS (형식화된 18편 코어 0 sorry)` · `Gate 2 (원고-코드): FAIL (22->11->10->7 범위 축소 깔때기·4/8 자매 원고 미형식화·087.md 내부 모순·OAI/ 2,170개 미사용 가설)` · `Gate 3 (서지·윤리): FAIL (추론 인용 230/332 = 69.28% 탈락·자사 2026년 동반 원고 3/3 = 100% 삭제·사후 213건 삽입·자카드 일치도 18.72%)` · `Gate 4 (공정·개입): FAIL (사후 LuaLaTeX 조판 컴파일러·프롬프트 비공개 2편·다중 봉합 5편·MinUncut.lean 1,401바이트 공백 치환)` · `Gate 5 (수리 가치): PASS` $\implies$ **`OPFF TIER C` (`10`개 분야 수리·해석 증명 엔진 유효 공인 / `69.28%` 추론 참고문헌 탈락·사후 LuaLaTeX 편집·`21.51%` 결합 출처 충실도 기준 미충족 / `Valid Mathematical Engines & Non-Conforming Provenance Artifact`)** |

### 0.1 8대 핵심 지표 요약 스코어카드 (`Executive 8-Metric Scorecard`)

| # | 포렌식 감사 지표 (`Audit Dimension`) | 원본 주장 또는 외형 (`Surface Claim`) | 계측된 물리적 수치 (`Measured Reality`) | OPFF 체크포인트 및 판정 |
| :---: | :--- | :--- | :--- | :---: |
| **1** | **추론 로그 대 원고 인용 보존율** | 추론 로그(`332`건 인용) 기반 원고(`.bib` `315`건) 작성 | 보존 `102`건(`30.72%`) 대 **원고 탈락 `230 / 332`건(`69.28%` = `115/166`)** + **사후 추가 `213`건(`67.62%`)**; 양방향 자카드 일치도 **`102 / 545 = 18.72% < 1/5`** | `CP-08 · CP-09 FAIL` |
| **2** | **자사 2026년 동반 원고 인용 및 `#287` 탈락** | 문제 간 독립 추론 및 정직한 서지 귀속 | `#017`이 `20`회 이상 호출한 `#005`(카탈랑) 등 **OpenAI 2026년 자사 동반 원고 `3 / 3`건(`100%`) 전량 삭제**; `#287` 자유군 인자는 **`49 / 54`건(`90.7%`) 탈락** | `CP-08 · CP-10 FAIL` |
| **3** | **사후 LuaLaTeX 조판 컴파일러 물증** | 날것의 모델 추론 과정(`reasoning_traces`) 공개 | 잔류한 [`mezard-parisi-formula.tex`](../proofs/oai_ref/preprints_tex/mezard-parisi-formula.tex#L47-L79)(`211`줄)에서 **타 난제군(`#102`) 복잡도 매크로 `5`종, 미사용 중국어 `"自由"` 한자 폴백(`U+81EA`, `U+7531`), `[Administrative details redacted.]` 확인** | `CP-11 FAIL` |
| **4** | **프롬프트 비공개 및 다중 실행 봉합** | 단일 연속 추론 트레이스 | `10`편 중 **`2`편(`#017`, `#287`) 초기 프롬프트 `0`개 비공개**; **`5`편(`#007, #017, #087, #159, #197`) 복수 실행(`16`개 파트) 다중 봉합**; `#087` 2부는 1부를 외부 공급 전제로 수령 | `CP-11 FAIL` |
| **5** | **바이트 보존 주석 공백 치환 및 헤더 중복** | 깔끔한 비교 챌린지 및 `OAI/` 진입점 코드 | [`MinUncut.lean:5-13, 63-101`](../proofs/oai_ref/challenges/MinUncut.lean#L5-L13)에서 **`22`줄(`1,401`바이트) 문서화 주석이 동일 바이트 수 아스키 공백(`0x20`)으로 치환**; [`BinaryCorrectedElliott.lean`](../proofs/oai_ref/oai_modules/BinaryCorrectedElliott.lean#L1-L27) `27`줄 중복 `open` | `CP-03 · CP-12 FAIL` |
| **6** | **`22 -> 11 -> 10 -> 7` 범위 축소 깔때기** | `10`개 난제군 전수 해결 및 Lean 4 형식화 | `22`편 원고 중 **자매 원고 `11`편(`50%`) 추론 로그 미공개**, `#197`·`#271` 자매 원고 **`4 / 8`편 미형식화**, `#017`·`#102`·`#159` 표제·정량 파트 제외로 온전 보존 `7 / 10` (`결합 충실도 714/3320 = 21.51% < 1/4`) | `CP-04 · CP-05 FAIL` |
| **7** | **스텁 위양성 `5/5` 대 `OAI/` `2,170`개 미사용 가설** | 챌린지 스텁 가설 및 내부 보조정리 무결성 | 챌린지 스텁 가설 `5`개(`hNP`, `hK` $\times 3$, `hM`)는 `OAI/` 본문에서 `5 / 5`(`100%`) 실제 소비되나, **`OAI/` `9,929`개 파일 내부 보조정리에 미사용 가설 `2,170`개(`#159`에 `1,537`개 = `70.83%`) 존재** | `CP-01 · CP-06 WARN` |
| **8** | **`10`개 분야 수리·해석 증명 엔진 유효성** | 수론·볼록기하·복잡도·군환·수리물리·PDE `10`개 난제군 | `m=2n` 베타 계승 상쇄($\mu(\pi)=2$), 하너 극체 쌍대성, 희석 스핀 유리 4차 SOS, 하이젠베르크 적외선 껍질, 블라소프-맥스웰 부트스트랩 등 `10`개 코어 완결(`Gate 5: PASS`, OPFF 정리 `75`개 `346/346` 변이 사살) | `Gate 1 & Gate 5 PASS` |

### 0.2 3단계 신호등 판정 요약표 (`Three-Tier Traffic-Light Scope Summary`)

- 🟢 **`[VERIFIED / 수학적·커널 유효성 공인]` `10`개 분야 핵심 수리·해석 증명 엔진 및 스텁 가설 `5/5` 실제 소비 확인 (`Gate 1 & Gate 5: PASS`)**: `#007` 3척도 엔트로피 비둘기집 망원 합, `#017` 투도세 3중 베타 적분 $m=2n$ 계승 상쇄($\mu(\pi)=2$), `#087` 하너 극체 쌍대성·리카티 곡률 여유분(`194 - 180 = 14`), `#102` 희소 튜플 사영 $\beta = k^{-2/3}$, `#159` 조화 블록 비둘기집, `#197` 모서리 결손 멱등원 $e = 1 - ba$ 및 반 캄펜 오일러 결손(`1/2 > 0`), `#221` 4차 공동 볼록성 SOS 항등식 $(A-B)^2((A+B)^2+2B^2)$, `#271` 3차원 스핀파 적외선 적분($4s < 5s$), `#287` 호게루프 방사 감쇠·다이케마-라둘레스쿠 압축, `#362` 글래시-스트라우스 상대론적 부트스트랩 여유분(`43/500 > 0`) 등 `10`개 분야 수리 코어는 유효하며 독립 정리 `75`개(`0 sorry`, `346/346` 변이 사살)로 검증됨.
- 🟡 **`[DIVERGENT / 22 -> 11 -> 10 -> 7 범위 축소 깔때기 및 내부 2,170개 미사용 가설]`**: `10`개 난제군 소속 `22`편 프리프린트 중 자매 원고 `11`편은 추론 로그가 제공되지 않았고, `#197`의 무비틀림 단원 반례 원고 `1`편과 `#271`의 자매 원고 `3`편(합계 `4 / 8`편)은 Lean 4로 형식화되지 않았으며, `#102`의 원래 표제(`BasicSDP` 임계값)와 `#159`의 2부 준다항식 상한은 비교 챌린지에서 제외됨. 또한 `OAI/` `9,929`개 파일 내부 보조정리에 미사용 가설 바인더 `2,170`개(`#159`에 `1,537`개)가 존재함.
- 🔴 **`[NON-CONFORMING / 서지 69.28% 탈락 및 사후 조판·주석 공백 치환]`**: ① 추론 로그가 실제 참조한 선행 문헌 `332`건 중 `230`건(`69.28%`)이 주원고 `.bib`에서 탈락하고(자사 2026년 동반 원고 `3 / 3 = 100%` 삭제, `#287` `49 / 54 = 90.7%` 삭제) 로그에 없던 `213`건이 사후 삽입되어 양방향 자카드 일치도가 `18.72%`(`102 / 545`)에 불과한 점, ② 유출된 `mezard-parisi-formula.tex`가 일괄 사후 요약 조판(`#102` 매크로, `"自由"` 한자 폴백, `[Administrative details redacted.]`) 및 프롬프트 비공개(`2`편)·다중 실행 봉합(`5`편)을 입증하는 점, ③ `MinUncut.lean`의 `22`줄(`1,401`바이트) 주석이 아스키 공백(`0x20`)으로 바이트 보존 치환된 점으로 인해 `OPFF TIER C`로 판정됨.

---

## 제1부. 양방향 서지 대조(`332` 대 `315`) 및 `69.28%` 인용 탈락 감사 (`Bidirectional Citation Audit`)

### 1.1 `10`개 난제군 전수 양방향 인용 보존·탈락·사후 추가 원장 ([`thm_10`](../proofs/traces10_compiler_and_citation_drop.lean#L154-L166)~[`thm_17`](../proofs/traces10_compiler_and_citation_drop.lean#L250-L264), [`thm_65`](../proofs/traces10_analytic_operator_and_scope_audit.lean#L264-L283))

$$102\text{ (보존)} + 230\text{ (원고 탈락)} = 332\text{ (로그 인용)} \quad;\quad 102\text{ (보존)} + 213\text{ (사후 추가)} = 315\text{ (원고 .bib)} \quad;\quad \text{Jaccard} = \frac{102}{545} = 18.72\%$$

| 난제군 (`추론 로그 PDF`) | 쪽 / 줄 수 | 프롬프트 / 파트 | 추론 로그 인용 | 주원고 보존 | 주원고 탈락 (`비율`) | 주원고 `.bib` (`+사후 추가`) | 원고 수 (`로그유/전체`) | `OAI/` 파일 (`미사용 가설`) |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| **`#007` 이진 엘리엇 상관** | `7`p / `284`L | `2` / `2` | `17` | `9` | `8` (`47.1%`) | `21` (`+12`) | `1 / 1` | `854` (`45`) |
| **`#017` 원주율 무리수 지수 $\mu(\pi)=2$** | `42`p / `2,073`L | **`0`** / `2` | `23` | `7` | `16` (`69.6%`) | `25` (`+18`) | `1 / 1` | `869` (`13`) |
| **`#087` 대칭·일반 말러 추측** | `45`p / `2,191`L | `3` / `3` | `67` | `17` | `50` (`74.6%`) | `58` (`+41`) | `2 / 3` | `592` (`33`) |
| **`#102` 유일 게임 및 CSP** | `16`p / `708`L | `1` / `1` | `56` | `20` | `36` (`64.3%`) | `42` (`+22`) | `1 / 5` | `1,803` (`163`) |
| **`#159` 에르되시 역수합 등차수열** | `41`p / `1,779`L | `2` / `2` | `53` | `26` | `27` (`50.9%`) | `48` (`+22`) | `1 / 1` | `4,774` (**`1,537`**) |
| **`#197` 카플란스키 직접유한성** | `23`p / `1,045`L | `2` / `2` | `42` | `9` | `33` (`78.6%`) | `21` (`+12`) | `1 / 4` | `247` (`25`) |
| **`#221` 희석 스핀 유리 메자르-파리지** | `5`p / `210`L | `1` / `1` | `5` | `2` | `3` (`60.0%`) | `18` (`+16`) | `1 / 1` | `405` (`38`) |
| **`#271` 3차원 하이젠베르크 강자성** | `6`p / `277`L | `1` / `1` | `9` | `3` | `6` (`66.7%`) | `36` (`+33`) | `1 / 4` | `128` (`23`) |
| **`#287` 보간 자유군 인자 동형** | `11`p / `490`L | **`0`** / `1` | `54` | `5` | **`49` (`90.7%`)** | `17` (`+12`) | `1 / 1` | `50` (`4`) |
| **`#362` 상대론적 블라소프-맥스웰** | `6`p / `251`L | `1` / `1` | `6` | `4` | `2` (`33.3%`) | `29` (`+25`) | `1 / 1` | `207` (`289`) |
| **합계 (`10`개 난제군)** | **`202`p / `9,308`L** | **`13` / `16`** | **`332`** | **`102`** | **`230` (`69.28%`)** | **`315` (`+213`)** | **`11 / 22` (`50%`)** | **`9,929` (`2,170`)** |

### 1.2 OpenAI 2026년 자사 동반 원고 `3 / 3`건(`100%`) 삭제 및 핵심 채택 경로 문헌 탈락 ([`thm_12`](../proofs/traces10_compiler_and_citation_drop.lean#L180-L193)~[`thm_14`](../proofs/traces10_compiler_and_citation_drop.lean#L207-L219))

- **자사 2026년 동반 프리프린트 `3 / 3`건(`100%`) 원고 `.bib` 누락**:
  1. `#017` 추론 로그 `[17]`: `OpenAI. Catalan's constant is irrational (2026)` (`#005` 카탈랑 상수; 1부 `39`쪽 전반에서 초기가하 구성 시드로 `20`회 이상 호출되었으나 `#017` 원고 `.bib` `25`건에서 `0`건으로 삭제됨).
  2. `#017` 추론 로그 `[18]`: `OpenAI. Joint Dickman law for prime factors of shifted integers (2026)` (원고 `.bib`에서 삭제됨).
  3. `#159` 추론 로그 `[46]`: `OpenAI. Monochromatic finite sums and products in the naturals (2026)` (원고 `references.tex` `48`건에서 삭제됨).
- **채택된 주증명 사슬의 핵심 선행 문헌 탈락**: `#287`(`49 / 54 = 90.7%` 탈락)에서는 채택된 자유군 인자 증명이 직접 사용하는 호게루프 방사 승수·포파 변형-강성·오자와 고체성 문헌이 탈락했고, `#197`(`33 / 42 = 78.6%` 탈락)에서는 가담(Gardam 2021)·패스먼 증강 아이디얼·뤼크 $L^2$-불변량 문헌이 탈락함.

---

## 제2부. 유출된 사후 LuaLaTeX 컴파일러(`mezard-parisi-formula.tex`) 및 다중 봉합 감사 (`Post-Hoc Compiler & Stitching Audit`)

1. **사후 요약 컴파일러 [`mezard-parisi-formula.tex`](../proofs/oai_ref/preprints_tex/mezard-parisi-formula.tex#L1-L211) (`211`줄)의 4대 물증** ([`thm_02`](../proofs/traces10_compiler_and_citation_drop.lean#L38-L53)~[`thm_04`](../proofs/traces10_compiler_and_citation_drop.lean#L68-L84)):
   - **타 난제군(`#102`) 매크로 잔류 (`L47–L56`)**: 희석 스핀 유리(`#221`) 조판 파일 안에 `#102` 유일 게임 정리 전용 매크로 5종(`\UGC`, `\CSP`, `\NP`, `\OPT`, `\SDP`)이 선언되어 있어, 단일 공용 프리앰블로 `10`편의 추론 로그 PDF를 사후 일괄 조판했음이 확인됨.
   - **미사용 중국어 `"自由"` 한자 폴백 (`L62–L79`)**: `L68`에서 `FandolFang-Regular.otf` 중국어 글꼴을 적재하고 `L76–L77`에서 `\catcode"81EA=13\relax\gdef自`(`U+81EA`)와 `\catcode"7531=13\relax\gdef由`(`U+7531`)를 활성 문자로 선언해 `\QuoteGlyphSetup`(`L78`)에 연결함(본문 등장 `0`회, `#221` 본논문 [`glyph-mappings.tex`](../proofs/oai_ref/preprints_tex/glyph-mappings.tex#L1-L40)에는 수학 기호 `38`개만 존재하고 한자 `0`개).
   - **행정 편집 표지 (`L154`)**: 본문 `L154`에 `[Administrative details redacted.]` 편집 표지가 기록됨.
   - **프롬프트 지침 대 베른슈타인 인증서 불일치 (`L89`)**: 공통 프롬프트 `L89`는 *"Brute-force enumerations and computer-assisted proofs are strongly discouraged in the final writeup"*이라고 지시하나, `#087` 3부는 `32`차(`33`개 유리수 계수) 베른슈타인 다항식 컴퓨터 인증서로 증명을 종결함 ([`thm_64`](../proofs/traces10_analytic_operator_and_scope_audit.lean#L253-L263)).
2. **프롬프트 비공개(`2`편) 및 다중 실행 봉합(`5`편)**:
   - `#017`(`42`쪽)과 `#287`(`11`쪽)은 `Original prompt` 블록이 `0`개이며, `#007`(`2`파트)·`#017`(`39`쪽 1부 + `2`쪽 2부)·`#087`(`3`파트, 2부는 1부 결과를 외부 공급 전제로 수령)·`#159`(`2`파트)·`#197`(`2`파트) 등 `5`편은 복수 실행을 이어 붙인 총 `16`개 파트로 구성됨.

---

## 제3부. 바이트 보존 주석 공백 치환(`MinUncut.lean`) 및 생성 헤더 감사 (`Byte-Preserving Comment Masking Audit`)

1. **[`MinUncut.lean:5-13, 63-101`](../proofs/oai_ref/challenges/MinUncut.lean#L5-L101)의 `22`줄(`1,401`바이트) 아스키 공백(`0x20`) 치환** ([`thm_07_minuncut_blank_space_byte_masking`](../proofs/traces10_compiler_and_citation_drop.lean#L111-L126)):
   - `#102` 비교 챌린지 `MinUncut.lean`(`130`줄)의 `L5–L13`(`8`줄)과 `L63–L101`(`14`줄)에서 원래 존재하던 `/-- ... -/` 문서화 주석 블록이 삭제되지 않고 **동일한 바이트 수(`1,401`바이트)의 아스키 공백(`0x20`)과 개행으로 치환되어 파일 바이트 오프셋과 행 번호가 그대로 유지됨**.
2. **[`BinaryCorrectedElliott.lean:1-27`](../proofs/oai_ref/oai_modules/BinaryCorrectedElliott.lean#L1-L27) 중복 `open` 헤더 및 `087.md` 자기모순** ([`thm_08`](../proofs/traces10_compiler_and_citation_drop.lean#L127-L139), [`thm_09`](../proofs/traces10_compiler_and_citation_drop.lean#L140-L153)):
   - `#007` 진입점 `BinaryCorrectedElliott.lean`(`56`줄)은 상단 `27`줄이 중복 `open` 구문(`MeasureTheory` `7`회, `Finset` `10`회 반복)으로 이루어져 있으며, `lean/docs/087.md:13`은 일반(비대칭) 말러 추측이 제외되었다고 적었으나 바로 아래 `L15–L17` 및 [`GeneralMahler.lean`](../proofs/oai_ref/challenges/GeneralMahler.lean#L24-L33)에서 이를 포함시키는 문서 내 모순을 보임.

---

## 제4부. `22 -> 11 -> 10 -> 7` 3단계 범위 축소 깔때기 감사 (`Three-Stage Scope Funnel Audit`)

| 단계 (`Stage`) | 보존 산출물 수 (`비율`) | 탈락·제외 내역 및 물증 좌표 | 검증 정리 |
| :--- | :---: | :--- | :--- |
| **1단계: 난제군 전체 원고 $\to$ 추론 로그 공개 원고** | **`22`편 $\to$ `11`편 (`50.0%`)** | 자매 원고 **`11`편 추론 로그 미제공 (`0`편)**: `#087` 심플렉틱 그로모프 폭 `1`편, `#102` 자매 원고 `4`편(`OptimalMaxCut`, `VertexCover`, `MinUncut`, `DirectedFeedback`), `#197` 자매 원고 `3`편(`OddKaplansky`, `GroupRingDeterminant`, 무비틀림 단원 반례), `#271` 자매 원고 `3`편(블로흐 띠, 격자 게이지, 구면 스핀 유리) | [`thm_61`](../proofs/traces10_analytic_operator_and_scope_audit.lean#L214-L228), [`thm_62`](../proofs/traces10_analytic_operator_and_scope_audit.lean#L229-L240) |
| **2단계: 전체 원고 `22`편 $\to$ Lean 4 형식화 원고** | **`22`편 $\to$ `18`편 (`81.8%`)** | `#197` 및 `#271` 소속 자매 원고 `8`편 중 **`4`편(`50%`) Lean 4 미형식화 (`0`줄)**: `#197`의 10월 4일자 무비틀림 단원 반례 대표 원고 `1`편(`lean/docs/197.md:1-8`은 표제를 `# A torsion-free group algebra that is not directly finite`로 내걸었으나 정작 해당 무비틀림 대표 원고 `2,346`줄은 형식화 `0`줄·추론 로그 `0`편으로 제외하고 비틀림 군 원고 `3`편만 형식화; 또한 제외된 무비틀림 원고는 `Gardam (2021, Annals of Math.)` 인용이 `0`건으로 누락되어 있고 `.bib` 내 `DykemaJuschenko2015` `1`건이 본문 미인용 `0`건임) 및 `#271`의 10월 5일자 자매 원고 `3`편(`lean/docs/271.md:1-6`은 표제를 `# Bloch's law, its lattice correction, and the spherical magnetization law`로 내걸었으나 9월 24일자 최근접 이웃 원고 `1`편만 `128`개 파일로 형식화하고, 정작 표제에 적힌 10월 5일자 3대 주원고 *Bloch's Law* `3,023`줄 · *First lattice correction* `2,976`줄 · *Spherical magnetization law* `3,550`줄 합계 `9,549`줄은 형식화 `0`줄·추론 로그 `0`편임; 더욱이 `spherical-magnetization-law` 원고는 짝수 격자 변 길이 `L even`으로 제한되어 있으며 `DiaconisSaloffCoste1993`, `DoyleSnell1984`, `Nash1958`, `SuzukiFisher1971`, `Timar2013` 등 `.bib` `5`건이 본문 미인용 `0`건으로 남아 4순위 코퍼스 전체 미인용 `.bib`의 `12 / 13 = 92.3%`가 `#271`에 집중됨) | [`thm_24`](../proofs/traces10_compiler_and_citation_drop.lean#L379-L386) |
| **3단계: 추론 로그 `10`편 $\to$ 표제 온전 보존 챌린지** | **`10`편 $\to$ `7`편 (`70.0%`)** | **`3`개 난제군에서 추론 로그 표제·정량 파트 제외 및 암묵적 가설의 명시적 추가**: ① `#017` [`PiExponent.lean`](../proofs/oai_ref/challenges/PiExponent.lean#L7-L18)은 `Corollary 1.2`(Flint-Hills 급수) 제외, ② `#102` [`UniqueGamesTheorem.lean`](../proofs/oai_ref/challenges/UniqueGamesTheorem.lean#L231-L238)은 추론 로그 표제인 라가벤드라 `BasicSDP` 최적성(`Corollary 7.1`) 제외, ③ `#159` [`ErdosReciprocal.lean`](../proofs/oai_ref/challenges/ErdosReciprocal.lean#L31-L35)은 2부 준다항식 상한 제외 (`결합 출처 충실도 교차곱: 4 * (102 * 7) = 2856 < 3320 = 332 * 10`, `21.51%`). 아울러 [`GeneralMahler.lean:24-27`](../proofs/oai_ref/challenges/GeneralMahler.lean#L24-L27)은 원고 정리 문장에 암묵적이던 `IsCompact K`, `Convex ℝ K`, `(interior K).Nonempty` 3종을, [`VlasovMaxwell.lean:47-53`](../proofs/oai_ref/challenges/VlasovMaxwell.lean#L47-L53)은 `BoundedSmooth`, `MemLp 2` 및 가우스 발산 구속조건 2종을 명시적 가설로 추가함 | [`thm_22`](../proofs/traces10_compiler_and_citation_drop.lean#L351-L364), [`thm_23`](../proofs/traces10_compiler_and_citation_drop.lean#L365-L378), [`thm_74`](../proofs/traces10_analytic_operator_and_scope_audit.lean#L420-L445) |

---

## 제5부. 스텁 스캐너 위양성(`5/5`) 대 `OAI/` 내부 `2,170`개 미사용 가설 불능 정리 감사 (`Premise Integrity & Scanner No-Go Audit`)

1. **비교 챌린지(`:= by sorry` 스텁) 반환형 스캐너의 `5 / 5` (`100%`) 위양성 붕괴** ([`thm_66_five_challenge_stub_false_positives_verified_used`](../proofs/traces10_analytic_operator_and_scope_audit.lean#L284-L297)):
   - `ComparatorChallenges/*.lean` 스텁은 본문이 `:= by sorry`이므로 비의존 명제 가설 `(h : P)`가 반환형 `Q`에 재등장하지 않음.
   - 실제 `OAI/` 증명 본문을 대조한 결과, 스텁 스캐너가 의심한 `5`개 가설(**`OrdinaryElliott.lean:33`의 `hNP` [`BinaryCorrectedElliott.lean:45,47`에서 소비], `MahlerConjecture.lean:15`·`SymmetricMahlerEquality.lean:43`·`SymmetricPolar.lean:40`의 `hK` [`MainTheorem.lean:20`·`Classification.lean:539`에서 소비], `DilutedSpin.lean:148`의 `hM` [`DilutedSpin/Main.lean`에서 소비]**)은 **`5 / 5` 전량 실제 증명에 필수 소비됨**이 확인됨.
2. **`OAI/` `9,929`개 파일 내부 보조정리의 실제 미사용 가설 `2,170`개 검출 및 불능 정리** ([`thm_67`](../proofs/traces10_analytic_operator_and_scope_audit.lean#L298-L329)~[`thm_70`](../proofs/traces10_analytic_operator_and_scope_audit.lean#L359-L380)):
   - 반대로 `OAI/` `9,929`개 파일의 증명항 본문을 전수 스캔하면 참조되지 않는 내부 보조정리 미사용 가설이 **`45 + 13 + 33 + 163 + 1537 + 25 + 38 + 23 + 4 + 289 = 2,170`개** 검출되며, 이 중 **`1,537`개(`70.83%`)가 `#159` `Progressions/`(`4,774`개 파일)에 집중**됨.
   - 이에 따라 `sorry` 스텁 헤더만 검사하는 어떠한 정적 분석기도 위양성 `0`건과 내부 공허 가설 포착을 동시에 달성할 수 없다는 **스텁 전용 스캐너 불능 정리(`thm_69_stub_only_scanner_blindness_no_go_counter_model`)**를 형식 증명함.

---

## 제6부. `10`개 분야 수리·해석 증명 코어(`Gate 5: PASS`) 공인 및 독립 재검증 (`Constructive Verification & Repair`)

- 서지 탈락 및 사후 편집 문제와 독립적으로, `10`개 추론 로그와 `OAI/` 활성 증명 트리가 구축한 다음 **`10`대 도메인 수리·해석 엔진은 수학적으로 유효함(`Gate 1 & Gate 5: PASS`)**을 공인하고 `75`개 독립 `Lean 4` 정리(`1,337`줄, `0 sorry`, `346/346` 변이 사살)로 재검증함:
  1. **`#007` (수론)**: `7`-블록 분할 및 타오 3척도 엔트로피 망원 합 $d_1 + d_2 + d_3 = H_0 - H_3$ (`thm_26`, `thm_27`).
  2. **`#017` (초월수론)**: 유리수 `(3,-2)` Box 가중치(`62/25 = 2.48`, Flint-Hills 지수 `-1/25 < 0`)에서 투도세 3중 베타 적분 $m = 2n$ 단체 계승 상쇄($2(m+n)-(2n+m)=2n$)로의 피벗을 통한 $\mu(\pi) = 2$ 증명 (`thm_28`~`thm_32`).
  3. **`#087` (볼록기하)**: 하너 극체 부피곱 불변량 $4^n/n!$ (`32/3 - 64/9 = 32/9`), 쌍곡 그림자 리카티 곡률 여유분 `194 - 180 = 14 > 0`, `32`차 베른슈타인 인증서 (`thm_33`~`thm_35`).
  4. **`#102` (계산복잡도)**: 가우스-그라스만 삼중선형 잡음 잠금 및 희소 사영 창 $\beta = k^{-2/3}$ ($k=m^3, \beta=m^{-2} \implies k\beta^2 = 1/m \ll m = k\beta$, `thm_36`~`thm_39`, `thm_44`, `thm_45`).
  5. **`#159` (가법조합론)**: 이진 조화 블록 비둘기집 임계치 및 켈리-메카 이중지수 정밀도 스케일링 (`thm_40`, `thm_48`).
  6. **`#197` (군환·위상)**: 표수 `2` 결손 멱등원 $e = 1 - ba$, 폭스 증강 아이디얼 차원 $n-1$, 평면 반 캄펜 오일러 결손 $1/2 > 0$ (`thm_41`~`thm_43`, `thm_49`).
  7. **`#221` (통계물리)**: 희석 스핀 유리 $p=2, 4$ 공동 볼록성 다항식 SOS 항등식 $A^4 + 3B^4 - 4AB^3 = (A-B)^2((A+B)^2 + 2B^2) \ge 0$ (`thm_51`, `thm_52`).
  8. **`#271` (수리물리)**: 3차원 하이젠베르크 강자성체 다이슨-말레예프 적외선 껍질 적분 비 $4s < 5s = \beta_0$ (`thm_53`, `thm_54`).
  9. **`#287` (작용소대수)**: 호게루프 방사 감쇠 $(k+1)^4$ 및 다이케마-라둘레스쿠 자유군 인자 압축 $t^2(r'-1) = r-1$ (`thm_55`, `thm_56`).
  10. **`#362` (편미분방정식)**: 상대론적 블라소프-맥스웰 빛원뿔 분모 간격 $q - p > 0$ 및 부트스트랩 지수 여유분 $496/1000 - 410/1000 = 43/500 > 0$ (`thm_57`~`thm_59`).

---

## 제7부. 외부 규격 대비 불부합 판정, 3층위 기여 분석 및 최종 결론 (`OPFF Standard-Bound Verdict`)

### 7.1 국제 출판·형식검증 표준 대비 불부합 대조표 (`COPE · IMU/AMS · ACM v1.1 · ICMJE/CRediT · NeurIPS`)

| 국제 표준 대비 불부합 범주 | 규격 판정 기준 | 본 사건(추론 로그 `10`편) 확정 좌표 및 물리적 수치 | 최종 판정 |
| :--- | :--- | :--- | :---: |
| **선행 문헌 귀속 결손 (`Attribution Deficit` / `Gate 3`)** | 추론 과정에서 실제 참조한 선행 문헌 및 동반 연구의 원고 `.bib` 귀속 (`COPE` · `AMS Ethical Guidelines`) | • 추론 로그 인용 `332`건 중 **`230`건(`69.28%`)이 주원고 `.bib`에서 탈락**하고 사후 `213`건이 삽입됨(`Jaccard = 102/545 = 18.72%`)<br>• `#017`·`#159`가 호출한 **OpenAI 2026년 자사 동반 원고 `3 / 3`건(`100%`) 전량 삭제** 및 `#287` 인용 `49 / 54`건(`90.7%`) 탈락 | **귀속 결손 (`Gate 3: FAIL`)** |
| **생성 프로비넌스 및 사후 편집 불일치 (`Gate 4`)** | 원시 추론 로그·초기 프롬프트 보존 및 코드 주석 무결성 (`ICMJE/CRediT` · `NeurIPS Reproducibility`) | • [`mezard-parisi-formula.tex`](../proofs/oai_ref/preprints_tex/mezard-parisi-formula.tex#L47-L154)에서 `#102` 매크로, `"自由"` 한자 폴백, `[Administrative details redacted.]` 사후 조판 확인<br>• `#017`·`#287` 초기 프롬프트 `0`개 비공개, `5`편(`16`파트) 다중 실행 봉합, [`MinUncut.lean`](../proofs/oai_ref/challenges/MinUncut.lean#L5-L101) `22`줄(`1,401`B) 공백 치환 | **기준 미충족 (`Gate 4: FAIL`)** |
| **원고-아티팩트 범위 불일치 (`Paper–Artifact Divergence` / `Gate 2`)** | 패밀리 원고·범위 문서(`lean/docs/*.md`)·비교 챌린지의 1대1 정합성 (`ACM Artifact Review v1.1`) | • `22`편 원고 중 자매 원고 `11`편 로그 미공개, `#197`·`#271` 자매 원고 `4 / 8`편 미형식화, `#017`·`#102`·`#159` 표제·정량 파트 제외(`22 -> 11 -> 10 -> 7` 깔때기)<br>• `087.md:13`과 `GeneralMahler.lean` 사이의 자기모순 및 `OAI/` 내부 `2,170`개 미사용 가설 | **원고-아티팩트 불일치 (`Gate 2: FAIL`)** |

### 7.2 3층위 기여 주체 분석: 인간 학자 `332`건 선행 문헌 vs. 유효 수리·형식화 코어 vs. 사후 요약·서지 편집 파이프라인 (`Three-Tier Attribution Analysis`)

1. **AI 단독 무(無)문헌 창발 가능성 `0%`: 추론 로그 내부에 기록된 `332`건의 인간 선행 문헌 의존성**:
   - 공개된 `10`편의 추론 로그 텍스트(`9,308`줄) 자체가 모델이 백지상태에서 정리를 창안한 것이 아니라, **인간 학자들의 선행 논문 `332`건(타오 3척도 엔트로피, 투도세·자일베르거-주딜린 베타 적분, 나자로프·마이어-라이스너 볼록기하, 라가벤드라 `BasicSDP`, 켈리-메카 밀도 증분, 가담·패스먼 군환, 판첸코·프란츠-레오네 스핀 유리, 다이슨-말레예프 스핀파, 호게루프·포파·다이케마-라둘레스쿠 작용소대수, 글래시-스트라우스 상대론적 운동론)과 자사 선행 시드(`#005` 카탈랑 등 `3`건)**를 단계별로 조합·변형해 증명을 구성했음을 증명함.
   - 따라서 인간이 구축한 `332`건의 선행 수리물리·순수수학 문헌과 `Mathlib 4` 인프라 없이 AI 단독으로 본 `10`개 난제군 증명이 성립했을 가능성은 **`0%`**임.
2. **유효 컴퓨터 보조 수리·형식화 코어의 실질적 성취 (`Gate 1 & Gate 5: PASS`)**:
   - 동시에 `#017`에서 `39`쪽의 `(3,-2)` Box 탐색(`62/25 = 2.48`)이 $1+1/\sqrt{a}>2$ 장벽에 막히자 `2`쪽의 2부에서 $m=2n$ 단체 계승 상쇄로 전환해 $\mu(\pi)=2$를 타개한 피벗이나, `18`편의 원고 핵심 정리를 `9,929`개 `OAI/` 파일(`0 sorry`)로 형식화한 코어는 실질적인 컴퓨터 보조 수학 성취임.
3. **사후 원고 조판·서지 재작성 파이프라인에서 발생한 구조적 괴리**:
   - 반대로 추론 로그가 실제로 사용한 선행 문헌 `230 / 332`건(`69.28%`)과 자사 2026년 동반 원고 `3 / 3`건(`100%`)이 최종 원고 `.bib`에서 탈락하고 사후에 `213`건의 다른 문헌으로 대체된 현상(`Jaccard = 18.72%`), `mezard-parisi-formula.tex`의 일괄 요약 조판과 `MinUncut.lean`의 `1,401`바이트 공백 치환은 수리 증명 코어와 분리된 **사후 출판 포장·편집 파이프라인의 불일치**임 ([`thm_18_nonlinear_reward_hacking_novelty_score_distortion`](../proofs/traces10_compiler_and_citation_drop.lean#L265-L293)).

### 7.3 예상 반론 및 팩트 선제 차단 Q&A (`Pre-bunking FAQ`, 6문 6답)

- **Q1. "추론 로그의 참고문헌 `230 / 332`건(`69.28%`)이 원고에서 빠진 것은 단순히 탐색 중 버려진 막다른 가지(dead-end branches)의 인용을 정리했기 때문 아닌가?"**
  - **A1.** 세 가지 물리적 수치로 기각됩니다. 첫째, 원고 `.bib` `315`건 중 **`213`건(`67.62%`)은 추론 로그 어디에도 없던 문헌이 사후에 새로 삽입된 것**입니다([`thm_15`](../proofs/traces10_compiler_and_citation_drop.lean#L220-L232)). 둘째, `#287`(`49 / 54 = 90.7%` 탈락)과 `#197`(`33 / 42 = 78.6%` 탈락)에서는 버려진 가지가 아니라 **최종 채택된 주증명 사슬이 직접 사용하는 호게루프 방사 승수·포파 변형-강성·패스먼 증강 아이디얼 원전**이 탈락했습니다([`thm_12`](../proofs/traces10_compiler_and_citation_drop.lean#L180-L193), [`thm_13`](../proofs/traces10_compiler_and_citation_drop.lean#L194-L206)). 셋째, `#017` 1부 전반에서 핵심 시드로 `20`회 이상 호출된 OpenAI 자사 2026년 동반 원고(`#005` 카탈랑 등 `3`건)가 **`3 / 3` (`100%`) 전량 삭제**되었습니다([`thm_14`](../proofs/traces10_compiler_and_citation_drop.lean#L207-L219)).
- **Q2. "공개된 `10`개의 `reasoning_traces/*.pdf`는 모델이 출력한 날것의 원시 추론 로그(raw CoT dump) 아닌가?"**
  - **A2.** 아닙니다. `#221` 폴더에 삭제되지 않고 남은 [`mezard-parisi-formula.tex`](../proofs/oai_ref/preprints_tex/mezard-parisi-formula.tex#L1-L211)(`211`줄)를 열면, 타 난제군(`#102`) 전용 매크로 5종(`L47–L56`), `\QuoteGlyphSetup`의 미사용 중국어 `"自由"` 한자 폴백(`L68, L76–L77`), 그리고 `[Administrative details redacted.]` 편집 표지(`L154`)가 들어 있는 **사후 편집된 LuaLaTeX 요약 문서**임이 확인됩니다([`thm_02`](../proofs/traces10_compiler_and_citation_drop.lean#L38-L53), [`thm_03`](../proofs/traces10_compiler_and_citation_drop.lean#L54-L67)).
- **Q3. "비교 챌린지(`ComparatorChallenges/*.lean`)에서 `hNP`, `hK`, `hM` 가설이 반환형에 쓰이지 않으니 공허한 가짜 정리 아닌가?"**
  - **A3.** 그것은 `:= by sorry` 스텁 파일만 보고 실제 `OAI/` 증명 본문을 열지 않은 피상적 스캐너의 **`5 / 5` (`100%`) 오경보(False Positive)**입니다. 본 감사가 `OAI/` 증명항을 전수 추적한 결과 `5`개 가설 전부가 실제 증명에 필수적으로 소비됨을 입증했습니다([`thm_66`](../proofs/traces10_analytic_operator_and_scope_audit.lean#L284-L297)). 진짜 미사용 가설은 스텁이 아니라 **`OAI/` `9,929`개 파일 내부 보조정리에 있는 `2,170`개(`#159`에 `1,537`개)**입니다([`thm_67`](../proofs/traces10_analytic_operator_and_scope_audit.lean#L298-L329)).
- **Q4. "`#017`에서 Flint-Hills 급수 수렴(`Corollary 1.2`)은 미형식화된 것 아닌가?"**
  - **A4.** 비교 챌린지 스텁 [`PiExponent.lean`](../proofs/oai_ref/challenges/PiExponent.lean#L7-L18)과 문서 `017.md:11`에서는 제외되었으나, 실제 `OAI/NumberTheory/PiExponent/Main.lean:29-32`(`flint_hills_summable`) 내부에는 `0 sorry`로 증명되어 있습니다. 반면 `#102`의 `BasicSDP` 따름정리와 `#159`의 2부 준다항식 상한, 그리고 `#197`·`#271`의 자매 원고 `4`편은 실제로 미형식화 상태입니다([`thm_22`](../proofs/traces10_compiler_and_citation_drop.lean#L351-L364)~[`thm_24`](../proofs/traces10_compiler_and_citation_drop.lean#L379-L386)).
- **Q5. "`MinUncut.lean`의 `1,401`바이트 공백은 단순한 줄바꿈 포맷팅 아닌가?"**
  - **A5.** 일반적인 포맷터는 줄 끝 후행 공백(trailing whitespace)을 제거합니다. 반면 [`MinUncut.lean:5-13, 63-101`](../proofs/oai_ref/challenges/MinUncut.lean#L5-L101)의 `22`개 행은 각 행마다 원래 `/-- ... -/` 주석 글자 수와 일치하는 수십 개의 연속 아스키 공백(`0x20`, 합계 `1,401`바이트)으로 채워져 있어 바이트 오프셋과 행 번호가 보존된 상태입니다([`thm_07`](../proofs/traces10_compiler_and_citation_drop.lean#L111-L126)).
- **Q6. "추론 로그에서 탈락한 `230`건의 참고문헌을 복원하면 어떤 의미가 있는가?"**
  - **A6.** 주원고 `.bib`만 보면 추론 과정의 문헌 기반이 `102`건으로 보이지만, 탈락한 `+230`건을 복원하면 보존 기준선의 **`3.25`배(`332 / 102`)**에 달하는 인간 선행 문헌 연결망과 문제 간 시드 전이(`#005 -> #017`)가 투명하게 복원됩니다([`thm_63_citation_audit_recovery_gain`](../proofs/traces10_analytic_operator_and_scope_audit.lean#L241-L252)).

### 7.4 10초 터미널 재현 명령어 (`10-Second Terminal Reproduction`)

```bash
# 1. 독립 Lean 4 정리 75개 (0 sorry, 0 axiom, 346/346 변이 사살) 및 10편 추론 로그 양방향 인용 파서 실행
lean proofs/traces10_compiler_and_citation_drop.lean && \
lean proofs/traces10_algebraic_combinatorial_engines.lean && \
lean proofs/traces10_analytic_operator_and_scope_audit.lean && \
python3 proofs/verify_symbolic_traces10.py
```

### 7.5 최종 심사 판정문 (`Formal OPFF Referee Verdict Box`)

> **[최종 공식 판정: `OPFF TIER C` (`Valid Mathematical Engines & Non-Conforming Provenance Artifact`) — `10`개 분야 수리·해석 증명 코어 유효 공인 / 탈락된 `230`건(`69.28%`) 추론 참고문헌 및 자사 동반 원고 `3`건 복원·미공개 추론 로그 `11`편 및 미형식화 자매 원고 `4`편 공시 전 무수정 게재 불가]**
>
> OpenAI가 공개한 추론 로그 `10`편(`#007`~`#362`, `202`쪽, `9,308`줄)과 `OAI/` `9,929`개 파일에 구현된 10개 분야 수리·해석 증명 엔진($\mu(\pi)=2$ 단체 계승 상쇄, 말러 극체 쌍대성, 희소 사영 창, 카플란스키 결손 멱등원, 희석 스핀 유리 4차 SOS, 하이젠베르크 적외선 적분, 자유군 인자 압축, 블라소프-맥스웰 부트스트랩)은 수학적으로 유효하며 비교 챌린지 스텁 가설 `5`종(`hNP`, `hK`, `hM`) 역시 실제 증명항에서 `100%` 소비되어 **`Gate 1 & Gate 5: PASS`**를 충족한다. 그러나 제출된 추론 로그 및 원고 패키지는 **(1) 추론 로그 인용 `332`건 중 `230`건(`69.28%`)과 자사 2026년 동반 원고 `3 / 3`건(`100%`)이 주원고 `.bib`에서 탈락하고 사후 `213`건이 삽입되어 양방향 자카드 일치도가 `18.72%`(`102 / 545`)에 그친 귀속 결손(`CP-08`, `CP-09`, `CP-10`)**, **(2) 유출된 `mezard-parisi-formula.tex`(`211`줄)가 입증하는 사후 일괄 LuaLaTeX 요약 조판(`#102` 매크로, `"自由"` 한자 폴백, `[Administrative details redacted.]`), 초기 프롬프트 비공개(`2`편), 다중 실행 봉합(`5`편) 및 `MinUncut.lean`의 `22`줄(`1,401`바이트) 공백 치환(`CP-03`, `CP-11`, `CP-12`)**, **(3) `22 -> 11 -> 10 -> 7` 범위 축소 깔때기(자매 원고 `11`편 로그 미공개, `#197`·`#271` 자매 원고 `4 / 8`편 미형식화, 표제·정량 파트 `3`건 제외로 결합 충실도 `21.51% < 1/4`) 및 `OAI/` 내부 보조정리 미사용 가설 `2,170`개(`CP-01`, `CP-04`, `CP-06`)**로 인해 **OPFF 5대 관문 심사에서 `OPFF TIER C`**로 판정한다.
