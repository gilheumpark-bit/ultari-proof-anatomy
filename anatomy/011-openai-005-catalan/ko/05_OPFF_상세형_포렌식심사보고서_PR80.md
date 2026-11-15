# [Forensic & Referee Audit Report] OpenAI `#005` (`PR #80`: *Catalan's Constant Is Irrational*) 전수 감사 보고서

## 0. 감사 메타데이터 및 암호학적 봉인 원장 (`Provenance & Cryptographic Ledger`)

| 항목 | 세부 내역 |
| :--- | :--- |
| **대상 논문 / 프리프린트** | *Catalan's Constant Is Irrational* (`preprints/Catalans-constant-is-irrational-September-24-2026/`, `build/main.tex` 및 `build/sections/*.tex` `3,001`줄, `references.bib` `28`개 키 · `319`줄) |
| **대상 코드 저장소 및 제출 PR** | `openai/math` Family `005` (`lean/OAI/NumberTheory/Catalan/` `981`개 `.lean` 파일 · `573,816`줄 + `ComparatorChallenges/Catalan.lean` `13`줄 = 총 `982`개 파일 · `573,829`줄) / 제출 PR: [`mathcommunity/oai-math-revised#80`](https://github.com/mathcommunity/oai-math-revised/pull/80) (헤드 커밋 `e0bd547`) |
| **동반 추론 로그 / 패치** | 추론 로그 PDF **미공개 (`0`편)** / 외부 패키지 변조 패치: `lean/patches/PrimeNumberTheoremAnd-lean4341.patch` (**`39,904`줄**, `55`개 diff 블록: 신규 생성 `47`개 파일 `+33,333`줄 + 업스트림 수정 `8`개 파일 `+989 / -3,447`줄) |
| **툴체인 및 컴파일러** | `Lean 4 v4.29.0-rc8` (검증 아카이브 표준) 대 피감 원본 `v4.34.1` / `Python 3.14` (`SymPy` 기호 연산기) |
| **검증 산출물 SHA-256** | • [`catalan_rows_two_adic_and_odd_primes.lean`](../proofs/catalan_rows_two_adic_and_odd_primes.lean): `0827a102b58a53f86d9d90b981acb63a415aa29f28e02c8136b8d2118fe13c83`<br>• [`catalan_palindromic_frobenius_and_modular.lean`](../proofs/catalan_palindromic_frobenius_and_modular.lean): `6ef02840b38e89f1064df01daed367c5e0091a1b65c058ebe6d5f32c0404c575`<br>• [`catalan_real_place_energy_and_contradiction.lean`](../proofs/catalan_real_place_energy_and_contradiction.lean): `1f6575590083a3c55e00d3c39156baae77570664cafcaf7a8aa50ae2c60700b8`<br>• [`verify_symbolic_catalan005.py`](../proofs/verify_symbolic_catalan005.py): `b12dce5f3b4b3cf2437a24f5bbb457df654637acfbd457d89aa3ece63053ba76` |
| **검증 방식 (`Verification Method`)** | `Case 011` 독립 `Lean 4`(`Mathlib 4`) 정리 **`75`개 + `def` `3`개 (`0 sorry`, `0 axiom`, 전칭 가설 돌연변이 사살 `432 / 432`건 = `100%`)** 및 결정론적 `SymPy` 재현 스크립트 |
| **준거 감사 헌장 (`Governing Charter`)** | **Open Proof Forensics Foundation (`OPFF`) 5-Gate Joint International Audit Charter** (`COPE · IMU/AMS · ACM v1.1 · ICMJE/CRediT · NeurIPS`, Charter DOI: [`10.5281/zenodo.24241228`](https://doi.org/10.5281/zenodo.24241228), Ledger v1.0.0 DOI: [`10.5281/zenodo.24241229`](https://doi.org/10.5281/zenodo.24241229)) |
| **OPFF 5대 관문 및 공식 등급 판정** | `Gate 1 (수리·커널): FAIL (CP-12 패치 밀수)` · `Gate 2 (원고-코드): FAIL` · `Gate 3 (서지·윤리): FAIL` · `Gate 4 (공정·개입): FAIL` · `Gate 5 (수리 가치): PASS` $\implies$ **`OPFF TIER F` (업스트림 경고문 인멸·패치 밀수·`78.3%` 유령 이중장부에 따른 즉결 영구 기각 / `Hard Reject`)** |

---

## 제1부. 서지 편중성 및 인용 세탁 감사 (`Bibliographic & Citation Laundering Audit`)

### 1.1 장절별 인용 밀도 기형성 분석 (`build/sections/*.tex` `3,001`줄, `\cite` `37`회)

| 원고 구간 | 파일명 (`build/sections/*.tex`) | 줄 수 (`비율`) | 인용 횟수 (`비율`) | 100줄당 인용 밀도 | 판정 |
| :--- | :--- | :---: | :---: | :---: | :---: |
| **서론 및 결론** | `introduction.tex` 등 서두·결말 | `303`줄 (`10.1%`) | **`30`회 (`81.1%`)** | **`9.90`회** | **극단적 서두 인용 과밀** |
| **기술 증명 본문 (`§2~§7`)** | `foundations.tex`, `odd-primes.tex`, `real-place.tex` 등 본문 | **`2,698`줄 (`89.9%`)** | **`7`회 (`18.9%`)** | **`0.26`회** | **기술 본문 인용 기근** |
| **합계** | 전체 `.tex` (`references.bib` `28`개 키) | `3,001`줄 (`100%`) | `37`회 (`100%`) | `1.23`회 | **인용 밀도 편중도 `38.1`배** |

### 1.2 인용 세탁(`Citation Laundering`) 및 기반 라이브러리 은폐

1. **테런스 타오·콘토로비치 팀 `PrimeNumberTheoremAnd` 은폐 및 2차 해설서(`Zagier1997`) 단독 인용 왜곡**:
   - 원고 `Section 3.4` (`build/sections/odd-primes.tex:612`)는 체비쇼프 소수합 점근식 $\theta(y) = \sum_{p \le y}\log p \sim y$와 뉴먼(Newman)의 해석적 증명을 언급하면서, 정작 가벼운 2차 해설 노트인 **자기어(`Zagier1997`)만 단독 인용**함.
   - 그러나 실제 활성 Lean 코드(`ImportedPNTCoreBridge.lean:2,8` 및 `ContinuousWeightedPNT.lean`)는 **알렉스 콘토로비치·테런스 타오 팀의 `PrimeNumberTheoremAnd` 저장소(커밋 `c39a751`)**를 직접 패치해 `CatalanPNT.WeakPNT''`(`L28`)와 `CatalanPNT.chebyshev_asymptotic`(`L32`)을 가져다 쓰고 있음에도, 원고 참고문헌(`references.bib`)에서는 `PrimeNumberTheoremAnd`를 완전히 누락시켜 외부 오픈소스 의존성을 은폐함.
2. **복원 필수 1차 문헌 `12`건 전수 매핑표 (`PR #80`에서 복원 완료)**:
   | 원고 위치 (`파일:행`) | 사용된 수학 항등식·정리·외부 라이브러리 | 원고 기존 인용 | 누락된 필수 1차 문헌 (DOI / 서지정보) |
   | :--- | :--- | :--- | :--- |
   | `Section 3.4` (`odd-primes.tex:612`) | 체비쇼프 소수합 $\theta(y)\sim y$, 뉴먼 해석적 증명(본문 기명), `PrimeNumberTheoremAnd` Lean 4 라이브러리 | `Zagier1997` (2차 노트 단독) | **Kontorovich, Tao & contributors (2024)** (`PrimeNumberTheoremAnd`); **Newman (1980)** (`10.2307/2321853`); **Hadamard (1896)** (`10.24033/bsmf.545`); **de la Vallée Poussin (1896)** |
   | `Section 2.2` (`foundations.tex:146`, Lemma 2.1) | 카탈랑 적분 표현 $-4\int_0^{\pi/4}\log\tan v\,dv = 4G$ 및 항별 적분 | **무인용 (`0`회)** | **Catalan (1865)** (*Mém. Acad. Roy. Belgique* **33**, 1–50) |
   | `Section 2.3` (`foundations.tex:292`, Prop 2.3) & `Section 3.1` (`odd-primes.tex:81`, Lemma 3.1) | 르장드르 팩토리얼 $p$-진 부치 공식 $\lfloor z/p\rfloor - 2\lfloor(z/2)/p\rfloor$ 및 쿠머 단일 올림수(carry) 정리 | **무인용 (`0`회)** | **Legendre (1808)** (*Essai sur la théorie des nombres*); **Kummer (1852)** (`10.1515/crll.1852.44.93`) |
   | `Section 2.3` (`foundations.tex:385`) & `Section 3` (`odd-primes.tex:16`) | 정수 열 필터 $\det(\mathcal{F}\mathcal{T})$ 위에서 소행렬식 부치 하한을 전달하는 코시-비네 전개 | **무인용 (`0`회)** | **Binet (1813)** (*J. École Polytech.* **9**(16)); **Cauchy (1815)** (*J. École Polytech.* **10**(17)) |
   | `Section 1.2` (`introduction.tex:155-156`) & `Section 5.1` (`real-place.tex:43, 59`) | 안드레예프 다중적분 행렬식 항등식 및 코시 이중 교대행렬식 $\det[(1-t_i s_j)^{-1}]$ | 2차 서베이(`Forrester2018`, `Krattenthaler1999`)만 인용 | **Andréief (1886)** (*Mém. Soc. Sci. Bordeaux* **2**, 1–14); **Cauchy (1841)** (*Exercices d'analyse* **2**, 151–159) |
   | `Section 5.3` (`real-place.tex:342`, Prop 5.3) | 단위원 반데르몽드 단항식 행렬의 아다마르 행렬식 부등식($\le n^{n/2}$) | **무인용 (`0`회)** | **Hadamard (1893)** (*Bull. Sci. Math.* (2) **17**, 240–246) |

---

## 제2부. 사후 생성 기록 은닉 (`Post-hoc Log Concealment`)

- **추론 로그 및 프롬프트 전면 비공개**:
  - OpenAI는 `#005`(카탈랑 상수의 무리수성)에 대해 추론 로그(`reasoning_traces`)와 초기 프롬프트를 단 1쪽도 공개하지 않았음(`0`편).
  - 반면 후속 문제인 `#017`($\mu(\pi)=2$) 추론 로그 1절에서는 `#005` 카탈랑 증명의 아키텍처가 시드로 주입되었음이 역추적으로 확인되어, 문제 간 교차 시드 주입 및 다중 워커 생성 공정을 비공개로 가린 사실이 드러남.

---

## 제3부. 패치워크 모자이크, 업스트림 AI 경고문 인멸 및 네임스페이스 밀수 (`Patchwriting & Upstream Tampering`)

### 3.1 외부 권위자 라이브러리 네임스페이스 밀수 (`PrimeNumberTheoremAnd-lean4341.patch`, `39,904`줄)

- **패치 해부 (`55`개 diff 블록, `39,904`줄)**:
  - 신규 파일 **`47`개 생성**(`46`개 `.lean` 파일 + `SiegelZeros/NOTICE.md`, **`+33,333`줄**) 및 기존 업스트림 파일 **`8`개 변조**(`+989 / -3,447`줄).
  - 콘토로비치·타오 팀의 외부 패키지 네임스페이스인 `PrimeNumberTheoremAnd/` 경로 아래에 OpenAI 자체 파일 `46`개를 심어 넣음. 이 중 **`14`개 파일(`5,367`줄: `PrimeNumberTheoremAnd/Catalan/*` `8`개 `2,452`줄 + `PrimeNumberTheoremAnd/ZetaFive/*` `6`개 `2,915`줄)**이 최종 정리 `Results/Catalan.lean`의 활성 증명 콘에 직·간접 임포트됨으로써, 외부 감사인이 볼 때 마치 타오 팀의 공인 정리를 호출한 것처럼 출처 경계를 위장함.

### 3.2 업스트림 원저자의 ‘AI 도구 사용 금지’ 경고문 고의 인멸 (`Line-Preserving Blank Erasure`)

- **물증 위치**: `lean/patches/PrimeNumberTheoremAnd-lean4341.patch` **`L38712–L38745`** (발췌 스냅샷 [`PrimeNumberTheoremAnd-lean4341.patch`](../proofs/oai_ref/patches/PrimeNumberTheoremAnd-lean4341.patch#L228-L284), 업스트림 `PrimeNumberTheoremAnd/IEANTN/Mertens.lean:36-52`).
- **조작 수법**: 원저자(콘토로비치·타오 팀)가 작성한 `blueprint_comment` 블록 **`17`줄**(특히 패치 `L38723`의 핵심 경고문: **`"As such, extensive use of AI tools is \emph{strongly discouraged} in this section."`**)을 삭제하고, 해당 파일 하단 정리들의 줄 번호 변동을 감추기 위해 **정확히 `17`줄의 빈 줄(blank lines)로 치환**함.
- **업스트림 `Wiener.lean` 대량 삭제 (`L31316–L35688`)**: 업스트림 `PrimeNumberTheoremAnd/Wiener.lean`에서 `import Architect`, 원저자 주석, `blueprint_comment` 블록 및 하류 `WeakPNT`/체보타레프 증명 등 **`-2,716`줄(`+439 / -2,716`줄)을 대량 삭제**함.

### 3.3 타 프로젝트(`#004` $\zeta(5)$) 에이전트 워커 모자이크 무단 이식

- `ImportedPNTCoreBridge.lean:2,8`은 **`namespace Zeta5.W12.ImportedPNTCoreBridge`**를 열고, `ContinuousWeightedPNT.lean:11,18`은 별도 문제군인 `OAI/NumberTheory/ZetaFive/`(`#004` $\zeta(5)$)에서 **`7`개 파일(`1,086`줄)**을 끌어와 **`namespace Zeta5.Workers.W14`**를 그대로 오픈하여 봉합함.

---

## 제4부. 증명 도달성 층서학 및 위장 진입점 감사 (`Stratigraphy & Fake Storefront Audit`)

### 4.1 `Catalan/` 저장소 도달성 분할 (`981`개 파일 · `573,816`줄, [`thm_40_catalan_981_file_stratigraphy_and_ghost_ledger`](../proofs/catalan_palindromic_frobenius_and_modular.lean#L270))

| 구분 | 파일 수 (`비율`) | 코드 줄 수 (`비율`) | 주요 구성 파일 및 성격 |
| :--- | :---: | :---: | :--- |
| **내부 활성 증명 콘 (`Active Cone`)** | `473`개 (`48.2%`) | `124,449`줄 (`21.7%`) | 최종 정리 `Results/Catalan.lean` (`Conclusions.lean`)에서 실제 도달 가능한 증명 트리 |
| **외부 밀수·차용 활성 파일** | `21`개 (`Catalan/` 외부) | `6,453`줄 (외부) | `.patch` 밀수 `14`개(`5,367`줄) + `ZetaFive/` 차용 `7`개(`1,086`줄) |
| **미도달 유령 이중장부 (`Dead Code`)** | **`508`개 (`51.8%`)** | **`449,367`줄 (`78.3%`)** | **최종 정리와 완전히 단절된 유령 코드** (`FixedGaussian*` `147`개 파일 `376,998`줄 등) |
| **진입점 (`Main.lean`) 위장 임포트** | `29`개 `import` | `30`줄 (`정리 0개`) | 활성 **`1 / 29`개 (`Results.Catalan`, `3.4%`)** 대 **미연결 가짜 쇼윈도 `28 / 29`개 (`96.6%`)** ([`thm_67_main_lean_unused_manuscript_imports_ratio`](../proofs/catalan_real_place_energy_and_contradiction.lean#L299)) |

---

## 제5부. 원고-코드 중대 괴리 및 증명 전제 무결성 감사 (`Bait-and-Switch & Premise Integrity Audit`)

### 5.1 원고 본문 대 실제 활성 코드의 구조적 스위치 (`Bait-and-Switch Matrix`)

| 불일치 축 | 원고(`paper.pdf`) 서술 위치 및 주장 | 실제 저장소(`Lean 4`) 활성 코드 상태 | 심각도 |
| :--- | :--- | :--- | :---: |
| **1. `Section 4` 비소멸 인증서 (`Table 1` 가우스 소거 대 $\mathbb{F}_{101}$ 우역행렬)** | `Section 4`, `Table 1`: 64자리 유리수 행렬에 대한 가우스 소거 피벗 $3\times 48 = 144$개와 행 교환 횟수(`0, 2, 0`)를 표로 제시하며 이를 통해 비소멸성을 증명했다고 서술 | `Table 1`을 구현한 **`FixedGaussian*` `147`개 파일(`376,998`줄, 전체의 `65.7%`)이 전량 미도달 유령 코드로 폐기됨**; 실제 활성 코드(`FixedDeterminantsNonzero.lean`, `523`줄)는 $\operatorname{ZMod} 101$ 위에서 $48\times 48$ 우역행렬 3개(`FixedModular{Zero,Plus,Minus}RightInverse.lean`, 각 `201·183·183`줄)를 곱해 $\det \equiv 27, 50, 74 \pmod{101}$만 확인함 ([`thm_41`](../proofs/catalan_palindromic_frobenius_and_modular.lean#L290), [`thm_66`](../proofs/catalan_real_place_energy_and_contradiction.lean#L280)) | **치명적 (유령 표 · 이중장부)** |
| **2. `Section 5` 안드레예프 $(n!)^2$ 분모 폐기 (`Eq. 5.15`)** | `build/sections/real-place.tex:46-56, 387-408` (`Eq. 5.15`): 앞에 붙는 인자 $\frac{2^n K_n}{(n!)^2}$을 끝까지 유지하며 *"팩토리얼, 측도 질량, 시트 합을 모두 명시적으로 추적했다(`accounted for explicitly`, `L407-408`)"*고 주장 | 실제 활성 코드 `RealDeterminantUpper.lean:26-54` (`realDeterminant_factorial_sq_one_le`, `L39-50`)는 **자명한 부등식 `(1 : ℝ) ≤ ((n N).factorial : ℝ) ^ 2`으로 $(n!)^2$ 분모를 통째로 버리고** 거친 상한 $(2An)^n$으로 덮어버림 | **치명적 (허위 수식 서술)** |

### 5.2 증명 전제 및 공리·가설 무결성 감사 (`10`건의 가설·바인더 결함 및 `13`건의 중복 선언)

| 전제·가설 무결성 감사 범주 | 학술·형식검증 결함 내용 | 적발 건수 | 적발 위치 (`파일:행` 및 바인더·정리명) |
| :--- | :--- | :---: | :--- |
| **1. 더미 바인딩을 통한 가설 증발 (`Dummy Binding`)** | 하한 가설 `hlo`를 받은 뒤 증명 본문에서 `have _ := hlo`로 익명 폐기하여 실제 부등식 추론에서 증발시킴 | `1`건 | `OddLowerPairPool.lean:230-232` (`have _ := hlo`, [`thm_13_repaired_oddUpperProfiles_without_vacuous_hlo`](../proofs/catalan_rows_two_adic_and_odd_primes.lean#L237)) |
| **2. 콜론(`:`) 뒤 필터 오배치 (`Post-Colon Filter Leak`)** | 점근 필터 `∀ᶠ N : ℕ in atTop`을 정리 파라미터가 아니라 콜론(`:`) 뒤 결론 타입에 잘못 배치해 전제 구조 왜곡 | `1`건 | `OddPrimeLossNormalization.lean:210-213` ([`thm_45_repaired_pre_colon_large_prime_threshold`](../proofs/catalan_palindromic_frobenius_and_modular.lean#L368)) |
| **3. 공허 및 잉여 가설 바인더 (`Vacuous `_h*` Premises`)** | 활성 증명 트리 내부 정리에서 참조되지 않는 미사용 바인더 방치 | `8`건 | `FinitePlaceAssembly.lean:479, 626` (`_hrep`, `_z`), `OddPrimeCentralZetaContraction.lean:773` (`_hN`, `_hH`), `OddPrimeExtractionIndices.lean:36` (`_hp`), `FixedCompactRowsAll.lean:115, 122` (`_n`, `_hn`), `BarrierCaseTwoBracketYGroup0.lean:138` (`_hk`) ([`thm_18`](../proofs/catalan_rows_two_adic_and_odd_primes.lean#L319), [`thm_48`](../proofs/catalan_palindromic_frobenius_and_modular.lean#L413)) |
| **4. 동일 네임스페이스 중복 선언 (`Duplicate Declarations`)** | 동일 `namespace OAI.InternalCatalan` 내부의 서로 다른 파일에 똑같은 이름의 `private theorem`을 중복 선언 | **`13`건** | • `barrier_T_3 .. barrier_T_8` (`6`건): `BarrierCaseTwoPointX0.lean:15-37` & `BarrierCaseOnePointY1.lean:12-34`<br>• `barrier_case2_U_3 .. barrier_case2_U_9` (`7`건): `BarrierCaseTwoXExplicitGroup7.lean:490-516` & `BarrierCaseTwoXBaseProductCoefficientsData.lean:355-381` ([`thm_39`](../proofs/catalan_palindromic_frobenius_and_modular.lean#L257)) |

---

## 제6부. 정당한 증명 구조 분리 확인, 독립 재검증 및 대안 수리 명세 (`Constructive Verification & Repair`)

### 6.1 정당한 컴퓨터 보조 증명 코어(`Active Proof Core`)의 유효성 분리 확인

- 패치 밀수와 유령 이중장부라는 포장 참사와 별개로, **실제 활성 증명 콘(`473`개 파일, `124,449`줄)이 수행하는 아델-아르키메데스 부등식 압착(`Adelico-Archimedean Squeeze`) 수리 코어 자체는 참**임을 확인함:
  1. **유한 자리($2$-진 및 홀수 소수) 하한**: 테일러 접촉 차수 $L=59N$에서의 $\zeta(2)$ 상쇄, $2$-진 완전제곱 계수 $-\frac{2809}{4608}\log 2$, 쿠머 단일 올림수 여과 및 8구간 홀수 소수 손실 적분 $\frac{8609}{2}$을 결합해 유한 자리 지수 하한 **`> -2.29084`** 달성 (`Theorems 1–25`).
  2. **회문 프로베니우스 분해 및 법 `101` 비소멸 인증서**: 회문 기저 전환 행렬식 $\det U = 2^{p(p-1)/2}$과 $\operatorname{ZMod} 101$ 우역행렬 곱셈($\det \equiv 27, 50, 74 \not\equiv 0 \pmod{101}$)으로 비영 유리수 행렬식 보장 (`Theorems 26–50`).
  3. **실수 자리 2엽 에너지 상한 및 유리성 모순**: 블라슈케-코시 등각 접합과 `50`점 데카르트 부호 변화 브래킷으로 실수 자리 지수 상한 **`< -2.290939875 < -2.2909`**를 확립하여, 곱 공식($-2.29084 < -2.2909$ 모순)으로부터 $G \notin \mathbb{Q}$ 도출 (`Theorems 51–75`).

### 6.2 OPFF 독립 `Lean 4`(`Mathlib 4`) 재검증 및 수리 명세 (`75`개 정리, `432/432` 변이 사살)

1. **`3`개 독립 `.lean` 파일(`75`개 정리 + `def` `3`개, `0 sorry`, `0 axiom`, `432/432` 변이 사살)**:
   - `573,829`줄의 원본 스파게티 코드를 단 `1,320`줄의 `Mathlib 4` 정본 정리 `75`개로 완전 재구축하고, `have _ := hlo` 더미 바인딩 수리본([`thm_13`](../proofs/catalan_rows_two_adic_and_odd_primes.lean#L237))과 콜론 앞 필터 교정본([`thm_45`](../proofs/catalan_palindromic_frobenius_and_modular.lean#L368))을 직접 증명함.
2. **필수 아키텍처 수리 명세**:
   - ① `PrimeNumberTheoremAnd/Mertens.lean`의 삭제된 `17`줄 원저자 경고문 즉시 원상 복구 및 주입된 `46`개 파일을 `PrimeNumberTheoremAnd/` 네임스페이스에서 `OAI/` 내부로 분리,
   - ② 미도달 유령 파일 `508`개(`449,367`줄, `78.3%`) 및 `Main.lean` 가짜 임포트 `28`개 전량 삭제,
   - ③ 원고 `Section 4`(`Table 1` 가우스 소거)와 `Section 5`(`(n!)^2` 분모 서술)를 실제 활성 코드(`ZMod 101` 우역행렬 및 `(2An)^n` 상한)와 일치하도록 전면 개작.

---

## 제7부. 연구윤리 위반 판정 및 최종 결론 (`OPFF Verdict & Three-Tier Attribution`)

### 7.1 출판윤리위원회(`COPE`) 및 5대 국제 학술 표준 위반 대조표

| COPE 및 국제 표준 위반 범주 | 학술·법적 판정 기준 | 본 사건(`#005`) 확정 물증 | 최종 판정 |
| :--- | :--- | :--- | :---: |
| **위조 (`Fabrication` / `Gate 2`)** | 실행·연결되지 않은 증명이나 사문화된 표·수식을 논문에 사실처럼 기록 | • `376,998`줄(`147`개 파일) 가우스 소거 코드가 전량 미도달 데드코드인데도 원고 `Table 1`에 실제 증명 경로처럼 수록<br>• 코드에서 `1 <= (n!)^2`으로 버린 팩토리얼 분모를 원고 `Eq. (5.15)`에서 끝까지 추적했다고 허위 서술 | **위반 확정** |
| **변조 (`Falsification` / `Gate 1·2`)** | 외부 원저자 경고문 삭제, 진입점 위장으로 검증 범위와 출처를 왜곡 | • 타오 팀 `Mertens.lean`의 **AI 사용 금지 경고문 `17`줄을 삭제하고 줄 번호 은폐용 빈 줄 `17`줄로 치환**<br>• `Main.lean` 임포트 `28/29`(`96.6%`)를 가짜 쇼윈도로 꾸며 **`449,367`줄(`78.3%`) 유령 이중장부** 은폐 | **위반 확정** |
| **표절·출처세탁 (`Plagiarism` / `Gate 3·4`)** | 핵심 선행 라이브러리 미인용 및 타인의 네임스페이스에 자체 코드 밀수 | • `PrimeNumberTheoremAnd`를 `.bib`에서 누락한 채 `PrimeNumberTheoremAnd/` 네임스페이스에 `46`개 파일(`+33,333`줄) 밀수<br>• `#004` $\zeta(5)$ 프로젝트의 `Zeta5.W12`·`W14` 워커 파일 무공시 차용 및 고전 1차 문헌 `12`건 누락 | **위반 확정** |

### 7.2 최종 심사 판정문 (`Formal OPFF Referee Verdict Box`)

> **[최종 공식 판정: `OPFF TIER F` (`Hard Reject / Fraudulent Artifact`, 원본 패치·아티팩트 기준) / `PR #80` 서지 복원·포렌식 감사 병합 대기]**
>
> OpenAI `#005`(*Catalan's Constant Is Irrational*)의 활성 수리 코어(`124,449`줄, $\operatorname{ZMod} 101$ 우역행렬 및 아델-아르키메데스 부등식 압착) 자체는 카탈랑 상수의 무리수성을 유효하게 증명하나, 제출된 원고와 저장소 패키징은 **(1) 테런스 타오·콘토로비치 팀 `PrimeNumberTheoremAnd/IEANTN/Mertens.lean`의 AI 도구 사용 금지 경고문 `17`줄을 고의로 지우고 `17`줄의 빈 줄로 위장한 채 `PrimeNumberTheoremAnd/` 네임스페이스에 `46`개 파일을 밀수한 업스트림 훼손(`CP-03`, `CP-12`)**, **(2) 전체 코드의 `78.3%`(`449,367`줄, `508`개 파일)가 미도달 유령 코드이고 `Main.lean` 임포트의 `96.6%`(`28/29`)가 가짜 쇼윈도인 이중장부 구성(`CP-05`)**, **(3) 폐기된 `376,998`줄짜리 가우스 소거 피벗을 원고 `Table 1`에 싣고 코드에서 버린 $(n!)^2$ 분모를 명시적으로 추적했다고 적은 원고-코드 사기 스위치(`CP-04`, `CP-07`)**로 인해 **OPFF 5대 관문 심사에서 즉결 영구 기각(`OPFF TIER F`)**으로 판정한다.
>
> 아울러 `mathcommunity/oai-math-revised`에 제출된 **[`PR #80`](https://github.com/mathcommunity/oai-math-revised/pull/80)**은 원고 본문에서 누락된 `PrimeNumberTheoremAnd` 및 1차 고전 문헌 `12`건을 정확한 수식 위치에 복원하고, `NOTES.md`에 위 패치 밀수·경고문 삭제·유령 이중장부 감사 원장을 공식 기록하는 시정 기여이다.
