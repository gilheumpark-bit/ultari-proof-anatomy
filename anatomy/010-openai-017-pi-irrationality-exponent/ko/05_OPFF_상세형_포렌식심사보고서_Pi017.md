# [Forensic & Referee Audit Report] OpenAI `#017` (*The irrationality exponent of $\pi$ is $2$*) 전수 감사 보고서

## 0. 감사 메타데이터 및 암호학적 봉인 원장 (`Provenance & Cryptographic Ledger`)

| 항목 | 세부 내역 |
| :--- | :--- |
| **대상 논문 / 프리프린트** | *The irrationality exponent of $\pi$ is $2$* (`preprints/The-irrationality-exponent-of-pi-is-2-September-24-2026/`, `main.tex` 및 `sections/*.tex` 총 `5`개 파일 · `1,591`줄, `references.bib` `269`줄 · `25`개 엔트리) |
| **대상 코드 저장소 및 범위 문서** | `openai/math` Family `017` (`OAI/NumberTheory/PiExponent/` `869`개 `.lean` 파일 · `94,948`줄 + `ComparatorChallenges/PiExponent.lean` `19`줄 + `lean/docs/017.md` `14`줄) |
| **동반 추론 로그 / 패치** | `reasoning_traces/irrationality-exponent-of-pi.pdf` (`42`쪽, `45`개 절: `Part I` `Sections 1–44` $\mu(\pi) \le 62/25 = 2.48$, `Part II` `Section 45` $\mu(\pi) = 2$) / 외부 서드파티 패치 `0`건 (`Mathlib` 순수 의존) |
| **툴체인 및 컴파일러** | `Lean 4 v4.34.1` (원본 코퍼스) · `Lean 4 v4.29.0-rc8` (검증 아카이브 표준) / `Python 3.14` (`SymPy` 기호 연산기) |
| **검증 산출물 (1·2·3)** | • [`pi_simplex_parameters_and_stratigraphy.lean`](../proofs/pi_simplex_parameters_and_stratigraphy.lean): `b53f4c754771710f92d0b355516914d3aa5305263f2971d554b2a32a4e6779c3`<br>• [`pi_transverse_multiplicity_and_seshadri_blowup.lean`](../proofs/pi_transverse_multiplicity_and_seshadri_blowup.lean): `5c215fc726921ac6fbc7d9fdf97b6ff057eac982f2fbd7e5cacbe19950fcc3ba`<br>• [`pi_laurent_determinant_and_flint_hills.lean`](../proofs/pi_laurent_determinant_and_flint_hills.lean): `517c79e6ac21f03193f1746ef4542128433199308b7f719c016bde95459aa902` |
| **검증 산출물 (4·5)** | • [`verify_symbolic_pi017.py`](../proofs/verify_symbolic_pi017.py): `86860a82755dc12927c1f6734b555838103a7321d5e8ce0426d82ca410e8c6d7`<br>• [`symbolic_verification_result.json`](../proofs/symbolic_verification_result.json): `01470abe37f8962dd8b5e9fe2331d0c3184993848ae371f3d4fd65859bda73a1` |
| **검증 방식 (`Verification Method`)** | 독립 `Lean 4` 형식 증명 **`75`개 정리 (`1,646`줄, `0 sorry`, `0 axiom`, `120/120` 가설 변이 사살, `44`개 비선형·귀납 증명)** + `oai_ref/` `60`개 파일 결정론적 파서 검증 |
| **준거 감사 헌장 (`Governing Charter`)** | **Open Proof Forensics Foundation (`OPFF`) 5-Gate Joint International Audit Charter** (`COPE · IMU/AMS · ACM v1.1 · ICMJE/CRediT · NeurIPS`, Charter DOI: [`10.5281/zenodo.24241228`](https://doi.org/10.5281/zenodo.24241228), Ledger v1.0.0 DOI: [`10.5281/zenodo.24241229`](https://doi.org/10.5281/zenodo.24241229)) |
| **OPFF 5대 관문 및 공식 등급 판정** | `Gate 1 (수리·커널): PASS` · `Gate 2 (원고-코드): HOLD` · `Gate 3 (서지·윤리): FAIL` · `Gate 4 (공정·개입): HOLD` · `Gate 5 (수리 가치): PASS` $\implies$ **`OPFF TIER C` (조건부 수정 요구 / `Conditional Revision Required`)** |

---

### 0.1 8대 핵심 지표 스코어카드 (`Executive 8-Metric Scorecard`)

| # | 감사 영역 (`Audit Dimension`) | 실측 지표 (`Measured Metric`) | 기준점 (`Standard`) | 판정 (`Status`) |
| :-: | :--- | :---: | :---: | :---: |
| **1** | **활성 증명 콘 대 미참조·중복 모듈 (`Reachability & Redundancy`)** | **`869 / 869` imported (`100%`) · `4` files (`259` lines) unreferenced · `552` unused decls** | Clean call-graph | **HOLD (`CP-05`, `CP-10`)** |
| **2** | **외부 공리·미완성 스텁·전제 무결성 (`Kernel & Premise Integrity`)** | **`0 sorry`, `0 axiom`, `0` third-party patches · `14` unused `_h*` lines (`15` binders)** | `0 sorry`, `0 axiom` | **PASS (`Kernel Sound`)** |
| **3** | **주정리 명세 및 범위 노트 정합성 (`Specification & Scope Alignment`)** | **`Theorem 1.1` ($\mu(\pi)=2$) & `Corollary 1.2` (`Flint-Hills`) proved (`017.md:11` omits `Cor 1.2`)** | Exact scope match | **PASS (`Gate 1`) / HOLD (`Gate 2`)** |
| **4** | **장절별 인용 밀도 편중 (`Section Citation Skew`)** | **Intro `24` (`90.9` / 1k lines) vs. Secs 2–5 `13` (`9.8` / 1k lines) (`9.3 : 1` skew; Sec 4 `0`)** | Balanced attribution | **FAIL (`CP-03`)** |
| **5** | **추론 로그 대비 원고 서지 탈락 및 미귀속 고전 (`Trace-to-Paper Citation Drop`)** | **`25 / 25` `.bib` linked · `16 / 23` (`69.6%`) trace refs dropped + `6` classical families uncited** | Zero trace ref drop | **FAIL (`CP-03`)** |
| **6** | **네임스페이스 귀속 및 워커 분절 지층 (`Worker Namespace Strata`)** | **`0` external namespace placement · `20` worker namespaces (`W06–W64`) · `263` dup names** | Unified namespace | **HOLD (`CP-10`)** |
| **7** | **생성 이력 및 추론 로그 완결성 (`Provenance & Trace Completeness`)** | **`42`-page (`45`-section) trace (`Sec 1–44` $\mu \le 62/25$ $\to$ `Sec 45` $\mu = 2$) provided** | Full trace disclosure | **HOLD (`CP-07`)** |
| **8** | **수리적 돌파 가치 및 독립 재검증 (`Mathematical Breakthrough & Verification`)** | **Genuine resolution of $\mu(\pi) = 2$ & Flint-Hills convergence · `75` thms (`120/120` mutations)** | Genuine breakthrough | **PASS (`Gate 5`)** |

---

### 0.2 3단계 신호등 요약 (`Three-Tier Traffic-Light Summary`)

* **[RED — 규격 불부합 (`Non-Conformance`: `CP-03`)]:**
  1. **추론 로그 참고문헌의 원고 탈락 (`Trace-to-Paper Citation Drop`: `16 / 23 = 69.6%`)**: `42`쪽 추론 로그(`irrationality-exponent-of-pi.pdf`)의 참고문헌 `23`건 중 `16`건(`69.6%`, Esnault-Viehweg 1984, Ru-Vojta 1997, Vojta 1996, Bombieri-Vaaler 1983, Fischler-Rivoal 2018/2023, Hartshorne 1977 및 `35`회 인용된 선행 프리프린트 `#005` Catalan 등)이 최종 원고 `references.bib`에서 제외됨.
  2. **핵심 기술 본문(`Sections 2–5`)의 인용 편중(`9.3 : 1`) 및 `6`대 고전 정리 무인용 전개 (`CP-03`)**: 서론(`main.tex`, `264`줄)에 `24`회 인용이 집중된 반면, 실제 증명이 수행되는 `Sections 2–5`(`1,327`줄)에는 인용이 `13`회(`conclusion.tex` `0`회)에 그치며, 곱사영공간 가중 영점 추정(Esnault-Viehweg 1984; Faltings 1991; Fischler-Nakamaye 2014), 로그 미분 유수 강성(Ax 1971; Lang 1982), 대수적 Serre-Čech 소멸(Serre 1955; Hartshorne 1977), 로랑 보간 행렬식 행 변환(Laurent 1991; Waldschmidt 2000), 중심 이항계수 최소공배수 상한(Chebyshev 1852; Hanson 1972; Nair 1982), 이진 반원 최소간격 정렬 및 조르당 사인 부등식(Jordan 1882; Hardy-Littlewood 1923) 등 `6`대 고전 기법이 호출부 인용 없이 전개됨.
* **[AMBER — 아티팩트 범위 기술 불일치 및 코드 중복 (`Artifact & Scope Divergence`: `CP-04`, `CP-05`, `CP-10`)]:**
  1. **`lean/docs/017.md:11` 범위 기술과 `Main.lean:29-32` 실제 형식화의 불일치**: `017.md:11`은 챌린지 래퍼 `ComparatorChallenges/PiExponent.lean`(`theorem main`)만을 기준으로 Flint-Hills 급수 수렴 결과가 선택 명제 밖이라고 기술하여 외부 논평에서 미형식화로 오인되었으나, 실제 최상위 모듈 `OAI/NumberTheory/PiExponent/Main.lean:29-32`에는 `flint_hills_summable`(`Corollary 1.2`)이 `0 sorry`로 완전히 증명되어 있음(실제 미형식화 항목은 2-매개변수 일반화인 `Corollary 5.2`뿐임).
  2. **논문 대 Lean 코드의 4대 대수·조합적 치환 및 내부 사문화 선언**: 연속 단체 부피($2k!$) $\to$ 내접 직사각형($k^k$, $C_*$ `3.83 × 10^6`배 팽창), 최소공배수 상수 $\Lambda_{\text{PNT}} \approx 1.732 \to \Lambda_{\text{paper}} = 4\log 2 \approx 2.773 \to \Lambda_{\text{Lean}} = \log 4 + 4 \approx 5.386$, 복소 Kodaira 소멸 $\to$ 대수적 Rees 폭발 + 유한 아핀 덮개 Čech 코호몰로지, Flint-Hills 상수 $8/\pi \to 16$ (`Fin 4` 잉여류 분할)의 4대 구조적 치환이 이루어졌으며, `869`개 모듈 내부에 미참조 임포트 파일 `4`개(`259`줄), 인스턴스 전용 모듈 `5`개(`309`줄), 미참조 선언 `552`개, 동명 중복 선언 `263`종(`656`회), 완전 복제 정리 `23`쌍, 병렬 워커 네임스페이스 `20`개(`W06`~`W64`)가 잔존함.
* **[GREEN — 수학적·형식적 난제 해결 완결성 공인 (`Verified Mathematical Breakthrough`: `Gate 1 & Gate 5 PASS`)]:**
  - 초월수론의 미해결 난제였던 **원주율의 무리수 지수 $\mu(\pi) = 2$ 확정 (`Theorem 1.1`)** 및 **Flint-Hills 급수 $\sum_{n=1}^{\infty} (n^3 \sin^2 n)^{-1} < \infty$ 수렴 (`Corollary 1.2`)** 증명은 수학적으로나 기계적 형식증명(`869`개 파일, `94,948`줄, `0 sorry`, `0` 커스텀 공리, `0` 외부 패치)으로나 **유효하고 완결된 돌파임**을 본 감사단의 독립 `Lean 4` 정리 `75`개(`120/120` 가설 변이 사살)로 최종 공인함.

---

## 제1부. 서지 분포 및 선행 문헌 귀속 감사 (`Bibliographic Distribution & Attribution Audit`)

### 1.1 장절별 인용 밀도 분포 분석 (`main.tex` 및 `sections/*.tex` `5`개 파일, `1,591`줄)

| 장절 (`Section`) | 파일명 (`줄 수`) | 본문 `\cite` 호출 수 | `1,000`줄당 인용 밀도 | 판정 및 구조적 특징 |
| :--- | :--- | :---: | :---: | :--- |
| **`Section 1` (서론 및 주정리)** | [`main.tex`](../proofs/oai_ref/tex/main.tex#L1-L264) (`264`줄) | **`24`회** | **`90.91`회 / 1k줄** | 역사적 배경 및 선행 상한($7.1032$, Salikhov, Zeilberger-Zudilin 등) 집중 인용 |
| **`Section 2` (가중 영점 추정 및 폭발 기하)** | [`interpolation.tex`](../proofs/oai_ref/tex/sections/interpolation.tex#L1-L584) (`584`줄) | `9`회 | `15.41`회 / 1k줄 | `Stacks Project`(`4`회), `Mondal2021`(`2`회), `Lazarsfeld`, `Philippon1986`, `Demailly1992` 인용 |
| **`Section 3` (가중 로랑 보간 행렬식)** | [`determinant.tex`](../proofs/oai_ref/tex/sections/determinant.tex#L1-L432) (`432`줄) | `2`회 | `4.63`회 / 1k줄 | 서두(`L13`)에서 `Laurent1991, Laurent2000` 1회 언급 외 `Lemma 3.1–3.3` 증명 전체 무인용 |
| **`Section 4` (매개변수 구성 및 $\mu(\pi)=2$ 완결)** | [`conclusion.tex`](../proofs/oai_ref/tex/sections/conclusion.tex#L1-L156) (`156`줄) | **`0`회** | **`0.00`회 / 1k줄** | `Lemma 4.1` 매개변수 창 구성 및 `Theorem 1.1` 귀류법 완결부 **`100%` 무인용** |
| **`Section 5` (Flint-Hills 급수 수렴)** | [`series.tex`](../proofs/oai_ref/tex/sections/series.tex#L1-L155) (`155`줄) | `2`회 | `12.90`회 / 1k줄 | `Alekseyev`, `Meiburg` 각 1회 인용 (`Lemma 5.1` 이진 반원 최소간격 정렬 증명 무인용) |
| **전체 합계 (`Sections 1–5`)** | `5`개 `.tex` 파일 (`1,591`줄) | `37`회 (`25/25` `.bib` 연결) | 서론 대 `2~5`절 밀도비 **`9.28 : 1`** | `.bib` 연결률은 `100%`이나 핵심 증명부(`1,327`줄) 인용 밀도가 서론 대비 `1/9.3`로 급감 |

### 1.2 추론 로그(`42`쪽) 참고문헌 `16 / 23`건(`69.6%`) 원고 탈락 및 본문 미귀속 6대 고전 원저

1. **추론 로그(`reasoning_traces/irrationality-exponent-of-pi.pdf`) 참고문헌 `23`건 중 최종 원고(`references.bib`)에서 탈락한 `16`건 (`69.6%`)**:
   - **동일 코퍼스 선행 프리프린트 `2`건 탈락**: 추론 로그 `Part I` 전반에서 **`35`회 인용**하며 다변수 제트 보간과 가중 Seshadri 기하의 직접 모태로 사용된 **OpenAI (2026) `[17]` (*Catalan's constant is irrational*, `#005`)** 및 `[18]` (*The joint Dickman law...*, `1`회 인용)이 최종 원고에서 완전히 삭제됨.
   - **대수기하·디오판토스 핵심 원저 `14`건 탈락**: **H. Esnault & E. Viehweg (1984) `[11]`** (`Invent. Math. 78`, `3`회 인용), **M. Ru & P. Vojta (1997) `[20]` / P. Vojta (1996) `[22]`** (합계 `5`회 인용), **E. Bombieri & J. Vaaler (1983) `[6]`** (`Invent. Math. 73`, `1`회 인용), **S. Fischler & T. Rivoal (2018, 2023) `[12, 13]`**, **R. Hartshorne (1977) `[14]`** (*Algebraic Geometry*) 등이 최종 `references.bib`에서 누락됨.
2. **본문 `Sections 2–5`(`1,327`줄)에서 호출부 인용 없이 전개된 `6`대 고전 정리군**:

| 축 | 원고 및 Lean 4 좌표 | 무인용 전개된 고전 수리 기법 | 원고 호출부 인용 | 복원 필수 1차 고전 원저 (DOI) |
| :-: | :--- | :--- | :---: | :--- |
| **I** | `interpolation.tex:24-98, 198-249` / `WeightSeparation.lean` | 곱사영공간 $(\mathbb{P}^1)^m \times \mathbb{P}^1$ 위 급격히 증가하는 가중치 비율 $\prod w_a > C_* \prod v_b$를 이용한 가중 영점 다중도 추정 | **`0`건** (추론 로그 인용 후 탈락) | Esnault-Viehweg (1984, `10.1007/BF01388447`), Faltings (1991, `10.2307/2944319`), Ru-Vojta (1997, `10.1007/s002220050114`), Fischler-Nakamaye (2014, `10.5802/aif.2869`) |
| **II** | `interpolation.tex:303-368` (`Eq. 2.15–2.16`) / `LogarithmicObstruction.lean` | 가환 미분틀 $D_0 = Y\partial_Y + \sum \partial_{X_i}$ 아래 법기저 비교로 $dX_i = dY/Y$ 유도 후 단순극 유수 $\operatorname{ord}_P Y \neq 0$으로 비상수성 배제 | **`0`건** | Ax (1971, `10.2307/1970774`), Lang (1982, `10.1007/978-1-4757-1779-2`) |
| **III** | `interpolation.tex:427-584` (`Eq. 2.17–2.23`) / `FiniteCoverCohomology.lean` | 유한 여길이 아이디얼 Rees 폭발 위 볼록 결합 풍부성(`Eq. 2.20`) 및 유한 아핀 덮개 체흐 복합체 대수적 Serre 소멸 $H^1 = 0$ | `Tag 0B5U`만 표기 (원저 미인용) | Serre (1955, `10.2307/1969915`), Hartshorne (1977, `10.1007/978-1-4757-3849-0` II.7 & III.4–5), Kodaira (1953) |
| **IV** | `determinant.tex:172-335` (`Lemma 3.2–3.3`) / `RowTranslation.lean` | 중심 이동 기저 $A_a$의 단위 상삼각 행 변환 행렬식 불변성 및 테일러 충돌 차수 합 반데르몽드·코시-슈바르츠 하한 | **`0`건** (서두 언급 후 증명부 무인용) | Laurent (1991, `Astérisque 198-200`), Waldschmidt (2000, `10.1007/978-3-662-11569-5`, Chap. 9) |
| **V** | `determinant.tex:84, 136-143` (`Lemma 3.1`) / `Arithmetic.lean:13-24` | 중심 이항계수 $\binom{2\ell}{\ell} \le 4^\ell$ 이진 합산에 의한 $\operatorname{lcm}(1,\dots,n) \le 4^{2n}$ ($\Lambda_{\text{paper}} = 4\log 2$) 및 체비쇼프 상수 $\Lambda_{\text{Lean}} = \log 4 + 4$ | **`0`건** | Chebyshev (1852), Hanson (1972, `10.4153/CMB-1972-007-7`), Nair (1982, `10.2307/2320934`) |
| **VI** | `series.tex:23-91` (`Lemma 5.1`, `Cor 1.2`) / `FlintSine.lean` | 이진 구간 $K \le q < 2K$ 반원 사영 최소간격 $x_j \ge jd$ 정렬 및 조르당 사인 현 부등식 $|\sin x| \ge \frac{2}{\pi}|x|$ 결합 | **`0`건** | Jordan (1882, *Cours d'analyse* I), Hardy-Littlewood (1923, `10.1007/BF02403921`) |

---

## 제2부. 추론 로그 2부 구조 및 원고 전환 감사 (`Reasoning Trace Evolution & Provenance Audit`)

1. **`42`쪽 추론 로그(`45`개 절)의 `Part I`($62/25 = 2.48$) $\to$ `Part II`($2$) 도약 분석**:
   - **`Part I` (`Sections 1–44`, 1~39쪽, 분량의 `95%`)**: `Sections 1–31`에서 아크탄젠트 파데, Salikhov 대칭 적분, 반원 Toeplitz, CM Masser 관계, `#005` Catalan 혼합 모멘트 등 `31`개 경로의 실패를 기록한 뒤, `Sections 32–44`에서 고정 매개변수($a=0.8, b=0.887, c=0.89$)와 소수 정리($\Lambda_{\text{PNT}} \approx 1.732$)를 결합해 $\mu(\pi) \le 62/25 = 2.48 < 5/2$ 및 Flint-Hills 급수 수렴($2\mu - 5 = -1/25 < 0$)을 먼저 달성함([`thm_04_reasoning_trace_45_sections_62_over_25_to_2_pivot`](../proofs/pi_simplex_parameters_and_stratigraphy.lean#L106-L124)).
   - **`Part II` (`Section 45`, 39~40쪽, `1.2`쪽 분량)**: 차원 $m \to \infty$ 극한에서 $(\mathbb{P}^1)^m \times \mathbb{P}^1$ 가중 단체 부피 인자 $m!$이 행렬 차수 분자와 분모에서 정확히 상쇄됨([`thm_56_asymptotic_cancellation_of_m_factorial_in_log_d_over_m_log_m`](../proofs/pi_laurent_determinant_and_flint_hills.lean#L167-L187))을 포착하고, $\theta = 1-\delta$, $A = 1-b\delta$, $b \in (1/2, 1-1/\nu)$를 대입하여 임의의 $\nu > 2$에서 $\mu(\pi) = 2$로 도약함.
2. **최종 원고에서의 탐색 경로 생략**:
   - 최종 원고(`main.tex` 및 `sections/*.tex`)는 `Part I`(`39`쪽)의 `62/25 = 2.48` 중간 정리와 `#005` Catalan 기하 틀로부터의 차용 경위를 생략하고 `Section 45`의 최종 구성만을 연역적 순서로 서술함.

---

## 제3부. 병렬 에이전트 워커 지층 및 코드 복제 감사 (`Parallel Worker Strata & Code Duplication Audit`)

1. **`20`개 병렬 에이전트 워커 네임스페이스(`W06`~`W64`, `137`개 블록) 잔존 (`CP-10`)**:
   - `OAI/NumberTheory/PiExponent/` 내부에는 `PiExponentJets.W06`~`W64`(`11`개), `PiExponentSiegel.W08`~`W58`(`6`개), `PiExponentSiegelAux.W09`·`W30`·`W31`(`3`개) 등 총 **`20`개의 병렬 에이전트 워커 네임스페이스(`137`개 블록)**가 통합되지 않은 채 분산 배치됨.
2. **동명 선언 중복 `263`종(`656`회) 및 본문 완전 복제 정리 `23`쌍 (`CP-10`)**:
   - 전체 `422`개 네임스페이스에 걸쳐 동일 이름의 보조정리·정의가 `263`종(`656`회, 예: `schemeFreeOpen` `30`개 파일 `34`회, `schemeUnit` `10`회) 중복 선언되었으며, `120`자 이상 증명 본문이 바이트 단위로 복제된 정리가 `23`쌍(`Cohomology/PencilCohomologySections.lean`과 `Approximation/GlobalSectionClearing.lean` 간 `7`개 선언 통째 복제 등) 확인됨.

---

## 제4부. 증명 도달성 층서학 및 미참조 선언 감사 (`Stratigraphy & Call-Graph Audit`)

### 4.1 `OAI/NumberTheory/PiExponent/` `869`개 파일(`94,948`줄) 디렉터리별 층서학

| 하위 디렉터리 | 파일 수 | 코드 줄 수 (`비율`) | 정리 / 정의 / 구조체 / 인스턴스 | 미사용 가설 (`_h*`) | 핵심 수학적 역할 |
| :--- | :---: | :---: | :---: | :---: | :--- |
| `Geometry/` | `181` | `19,957` (`21.0%`) | `834 / 375 / 8 / 61` | `4` | 가중 단항식 사영 콤팩트화 `Proj(imageGrade a)`, 1차원 정규화 곡선 모델 및 베주 부등식 (`Prop 2.3`) |
| `LocalAlgebra/` | `172` | `16,427` (`17.3%`) | `754 / 236 / 9 / 37` | `2` | 정칙 국소환, 극대 아이디얼 거듭제곱 몫공간 차원 및 정규 매개변수 틀 |
| `Approximation/` | `133` | `15,257` (`16.1%`) | `709 / 269 / 3 / 24` | `2` (`3` 바인더) | `Lemma 4.1` 매개변수(`Parameters.lean`), 가중 분리 상수 $C_*$, 행렬식 모순 및 지수 결합 |
| `Cohomology/` | `99` | `14,821` (`15.6%`) | `623 / 318 / 4 / 52` | `4` | 유한 아핀 덮개 체흐 코호몰로지(`FiniteCoverCohomology.lean`), 대수적 Serre 소멸(`Tag 0B5U`) |
| `Ampleness/` | `119` | `11,028` (`11.6%`) | `497 / 198 / 2 / 47` | `0` | 유한 여길이 아이디얼 Rees 폭발, 예외 인자 $E$ 차수 및 볼록 결합 풍부성 (`Eq. 2.20`) |
| `Jets/` | `63` | `6,945` (`7.3%`) | `348 / 144 / 0 / 3` | `0` | 국소화 줄기 대수적 Hasse-Taylor 사상 및 횡단 다중도 (`Lemma 2.2`) |
| `Polynomials/` | `68` | `6,698` (`7.1%`) | `312 / 132 / 0 / 17` | `2` | 가중 단체 격자점 개수 유클리드 몫-나머지 샌드위치 (`SimplexCounting.lean`) |
| `Analysis/` | `32` | `3,752` (`4.0%`) | `216 / 37 / 0 / 0` | `0` | 코시 적분 계수 추정, 로그 미분 체 대각합 장애, Flint-Hills `Fin 4` 잉여류 분할 |
| `(root)` | `2` | `63` (`0.1%`) | `5 / 6 / 0 / 0` | `0` | `Statement.lean` 및 `Main.lean` (`pi_irrationality_exponent_eq_two`, `flint_hills_summable`) |
| **전체 합계** | **`869`** | **`94,948` (`100%`)** | **`4,298 / 1,715 / 26 / 241`** | **`14`줄 (`15`개)** | **파일 단위 `import` 도달률 `869/869 (100%)`, `0 sorry`, `0 axiom`** |

### 4.2 전이적 호출 그래프(Call-Graph) 상의 미참조 파일 `4`개(`259`줄) 및 미참조 선언 `552`개

- 파일 단위 `import` 문은 `869/869`개 모두 `Main.lean`에 연결되어 있으나, 실제 선언 호출 그래프를 추적하면:
  1. **내부 선언·인스턴스가 `0`회 호출되는 미참조 모듈 `4`개 (`259`줄)**: `Approximation/OpenPullbackUnit.lean`(`2`줄, 빈 파일), `Geometry/LineBundleGluingTransitions.lean`(`85`줄), `Jets/FormalBranchOrder.lean`(`136`줄, 유리수 판본 `FormalBranchOrderRational.lean`으로 대체), `Polynomials/WeightedMonomialLattice.lean`(`36`줄).
  2. **인스턴스 전용 모듈 `5`개 (`309`줄)** 및 **미참조 최상위 선언 `552`개** (예: `Cohomology/ProjectiveTwistAcyclicity.lean:26-79`의 미사용 구조체 `LaurentChartPresentation`, `Ampleness/NefAmple.lean:23-113`의 볼록 원뿔 정리 `7`개, `Polynomials/PolynomialLocalUnmixedness.lean` `156`줄, `LocalAlgebra/Dimension.lean` `172`줄 등).

---

## 제5부. 원고-아티팩트 불일치 및 구조적 치환 감사 (`Paper–Artifact Divergence & Structural Adaptation Audit`)

### 5.1 범위 노트(`017.md`) 및 원고 대 Lean 4 코드의 5대 구조적 차이 대조표

| 대조 축 | 원고(`sections/*.tex`) 및 범위 노트(`017.md`) | 실제 `Lean 4` 코드 (`OAI/NumberTheory/PiExponent/`) | 감사 판정 |
| :--- | :--- | :--- | :---: |
| **1. `017.md:11` Flint-Hills 범위 기술** | `lean/docs/017.md:11`: 챌린지 래퍼(`PiExponent.lean`) 기준 *"Flint-Hills 급수 수렴 결과는 선택 명제 밖"*이라고 기술 | 최상위 모듈 [`Main.lean:29-32`](../proofs/oai_ref/lean/OAI/NumberTheory/PiExponent/Main.lean#L29-L32)에 **`flint_hills_summable` (`Corollary 1.2`)이 `0 sorry`로 완전히 증명됨** (미형식화된 것은 2-매개변수 일반화 `Corollary 5.2`뿐임) | **범위 노트 과소 기술 (`Discovery 1`)** |
| **2. `Lemma 2.2` 국소 다중도 하한 및 분리 상수 $C_*$** | 연속 단위 정육면체 덮개로 단체 부피 $\ge \frac{T^k}{2k!\prod \kappa_b}$ 유도, $C_*^{\text{paper}} = \max 2k!(L_0/\sigma)^k$ (`Eq. 2.5, 2.8`) | 리만 적분을 우회하기 위해 이산 내접 직사각형 $\ge \frac{T^k}{k^k\prod \kappa_b}$ (`RectangularVolume.lean`) 및 $C_*^{\text{Lean}} = 2(m+2)^{m+2}(1+(m+2)/\sigma)^{m+2}$ 사용 ($m=6, \sigma=1$에서 `3,826,375`배 증가하나 점근 지수 불변) | **유효 대수·이산 치환 (`Valid Adaptation`)** |
| **3. `Section 3` 전역 행렬 차수 $M = |\mathcal{A}|$** | 연속 단체 부피 적분으로 $M \prod w_i \ge v_0^m / m!$ 유도 (`determinant.tex:29-34`) | $m!$을 $m^m$으로 바꾸면 $\mu(\pi)=2$가 붕괴하므로, 유클리드 나눗셈 전단사 $b_i \mapsto (b_i/w_i, b_i \bmod w_i)$ 샌드위치로 정확한 이항계수 하한 증명 (`SimplexCounting.lean:40-65`) | **핵심 무손실 이산 증명 (`Exact Combinatorial Bridge`)** |
| **4. 최소공배수 상수 $\Lambda$의 3단 지층** | 추론 로그 `Part I`: 소수 정리 $\Lambda_{\text{PNT}} \approx 1.732$ $\to$ 원고 `Lemma 3.1`: 중심 이항계수 이진 합산 $\Lambda_{\text{paper}} = 4\log 2 \approx 2.7726$ | `Arithmetic.lean:13-24`: Mathlib의 `Chebyshev.psi_le_const_mul_self`를 직접 호출해 **$\Lambda_{\text{Lean}} = \log 4 + 4 \approx 5.3863$** 채택 | **3단 상수 지층 (`Paper–Code Constant Shift`)** |
| **5. `Lemma 5.1` Flint-Hills 사인 하한 상수** | 반원 사영 $[-\pi/2, \pi/2)$ 위 조르당 부등식 상수 $8/\pi$ (`series.tex:86`) | `FlintSine.lean:88-90`: 구간을 `Fin 4`($n \bmod 4$) 잉여류로 4분할하여 유리수 상수 **`16` ($4 \times 4$)**으로 단순화 | **유효 유리수 상수 치환 (`Valid Adaptation`)** |

---

## 제6부. 유효 증명 구조 공인, 독립 재검증 및 상수 최적화 수리 (`Constructive Verification & Constant Compression`)

### 6.1 수학적·기계적 난제 돌파 완결성 공인 (`Gate 1 & Gate 5: PASS`)

- 본 감사단은 `869`개 원본 모듈(`94,948`줄)의 `24`개 구조체 번들과 핵심 대수기하 정의(`Scheme`, `LineBundle.IsAmple`, `cohomology`, `IntegralCurve`, `curveDegree`)를 전수 대조한 결과, **정의 왜곡이나 가설 동어반복이 `0`건**이며 오일러 주기 $e^{2\pi i j} = 1 \in \mathbb{Z}[i]$와 가우스 정수 행렬식 노름 $\|\Delta\| \ge 1$을 통해 일반 리우빌 수($\mu(\alpha)=\infty$)로의 과잉 일반화(`Overreach`)가 엄밀히 차단됨을 확인함([`thm_51_gaussian_integer_clearing_and_liouville_obstruction`](../proofs/pi_laurent_determinant_and_flint_hills.lean#L77-L109)).

### 6.2 OPFF 독립 `Lean 4` 재검증(`75`개 정리) 및 $C_*$ `5,000`배 팽창 제거 대안 해법

1. **독립 `Lean 4` 정리 `75`개 (`1,646`줄, `0 sorry`, `120/120` 가설 변이 사살)**:
   - [`pi_simplex_parameters_and_stratigraphy.lean`](../proofs/pi_simplex_parameters_and_stratigraphy.lean) (`Theorems 1–25`), [`pi_transverse_multiplicity_and_seshadri_blowup.lean`](../proofs/pi_transverse_multiplicity_and_seshadri_blowup.lean) (`Theorems 26–50`), [`pi_laurent_determinant_and_flint_hills.lean`](../proofs/pi_laurent_determinant_and_flint_hills.lean) (`Theorems 51–75`)에서 4대 대수·기하 축과 디리클레 하한 강성 장벽($\mu(\pi) \ge 2$)을 완전 검증함.
2. **리만 적분 없는 하강 계승 단체 부등식을 통한 $C_*$ 상수 압축 (`thm_27`, `thm_28`)**:
   - `RectangularVolume.lean`이 내접 직사각형($k^k$)을 사용해 감수한 상수 팽창($m=2, \sigma=1$에서 $320,000 / 64 = 5,000$배, $m=6$에서 `3,826,375`배)을 유클리드 나눗셈과 하강 계승 부등식 $(Q-k)^k \le k!\binom{Q}{k}$로 대체하여, 리만 적분 없이도 논문 원래의 $1/k!$ 단체 부피 계수($C_*^{\text{paper}} = 64$)를 복원함([`thm_28_euclidean_quotient_remainder_simplex_sandwich`](../proofs/pi_transverse_multiplicity_and_seshadri_blowup.lean#L120-L133)).

---

## 제7부. 외부 규격 대비 불부합 판정 및 최종 결론 (`OPFF Standard-Bound Verdict`)

### 7.1 5대 국제 학술 표준 및 COPE 가이드라인 대비 대조표

| 심사 관문 (`OPFF Gate`) | 준거 국제 표준 및 OPFF 코드 | 본 사건(`#017`) 실측 결과 | 최종 판정 |
| :--- | :--- | :--- | :---: |
| **`Gate 1` (수리·커널 무결성)** | `IMU/AMS` + `Lean Kernel TCB` | `869`개 파일(`94,948`줄) `0 sorry`, `0 axiom`, `0` 외부 패치; $\mu(\pi)=2$ (`Main.main`) 및 Flint-Hills 수렴 (`Main.flint_hills_summable`) 커널 검증 완료 | **PASS** |
| **`Gate 2` (원고-아티팩트 정합성)** | `ACM Artifact Badging v1.1` (`CP-04`, `CP-05`, `CP-10`) | `017.md:11`이 `flint_hills_summable` 형식화 사실을 누락 기술; 논문 대 Lean 4대 상수·기하 치환($\Lambda$: $4\log 2 \to \log 4 + 4$ 등); 미참조 모듈 `4`개(`259`줄), 미참조 선언 `552`개, 복제 정리 `23`쌍 | **HOLD** |
| **`Gate 3` (서지·귀속 무결성)** | `COPE` + `AMS Ethical Guidelines` (`CP-03`) | 추론 로그 참고문헌 **`16 / 23`건(`69.6%`) 원고 탈락**(`#005` Catalan `35`회 인용 및 Esnault-Viehweg, Ru-Vojta 등 누락); 본문 `Sections 2–5` 인용 밀도비 `9.3 : 1` 편중 및 **`6`대 고전 정리군 무인용 전개** | **FAIL (`귀속 결손`)** |
| **`Gate 4` (공정 투명성)** | `ICMJE` + `CRediT` + `NeurIPS` (`CP-07`) | `42`쪽(`45`절) 추론 로그 PDF 공개(`Part I` $62/25 \to$ `Part II` $2$), 코드 내 `20`개 병렬 워커 네임스페이스(`W06–W64`) 잔존 | **HOLD** |
| **`Gate 5` (수리적 돌파 가치)** | `IMO` / `Erdős` / `Mathlib` Standard | 초월수론 난제 $\mu(\pi) = 2$ 및 Flint-Hills 급수 수렴의 완전한 해결 (`75`개 독립 정리 · `120/120` 변이 사살로 교차 검증) | **PASS** |

---

### 7.2 인간 이론 · 고전 대수기하 · AI 추론 기여도 3층 분리표 (`실제 초월수론 난제 돌파 공인` vs. `고전 기하 뼈대` vs. `추론 로그 서지 탈락`)

| 기여 층위 (`Contribution Stratum`) | 비중 (`Share`) | 실측 구성 내용 및 파일 좌표 | 검증 판정 |
| :--- | :---: | :--- | :---: |
| **1. 선행 인간 대수기하·초월수론 뼈대 (`Human Classical Theory`)** | **`65%`** | 로랑 보간 행렬식(Laurent 1991, 2000), 곱공간 영점 추정 및 Seshadri 보간(Philippon 1986; Esnault-Viehweg 1984; Ru-Vojta 1997; Fischler-Nakamaye 2014), 대수적 Serre-Čech 소멸(Serre 1955; Hartshorne 1977), 로그 미분 유수 강성(Ax 1971), 체비쇼프-Hanson-Nair 최소공배수 상한(1852/1972/1982) | 인간 선행 이론 (`Sections 2–5` 및 추론 로그 탈락분 `16`건 복원 필요) |
| **2. AI 다변수 극한 결합 및 대수적 치환 돌파 (`AI Parameter & Formalization Breakthrough`)** | **`35%`** | 추론 로그 `Section 45`에서 $(\mathbb{P}^1)^m \times \mathbb{P}^1$ 차원 $m \to \infty$ 극한의 $m!$ 단체 부피 상쇄 및 매개변수 창 $\theta = 1-\delta, A = 1-b\delta, b \in (1/2, 1-1/\nu)$를 결합해 $\mu(\pi)=2$를 닫고, 연속 적분·복소 해석을 유클리드 나눗셈 샌드위치(`SimplexCounting.lean`)·대수적 Hasse-Taylor 사상(`Jets/`)·유한 덮개 Čech 코호몰로지(`Cohomology/`)로 치환해 `869`개 모듈 `0 sorry` 형식화를 완수함 | **실제 난제 해결 기여 공인 (`Gate 1 & Gate 5 PASS`)** |
| **3. 원고-코드 패키징 및 서지 편집 결손 (`Packaging & Bibliographic Deficit`)** | **교정 대상** | 추론 로그 참고문헌 `16/23`건(`69.6%`) 원고 누락, `017.md:11`의 `flint_hills_summable` 범위 오기, `4`개 미참조 모듈(`259`줄)·`552`개 미참조 선언·`20`개 워커 네임스페이스(`W06–W64`) 미정리 | 수학적 진리값 훼손 없음 (`Conditional Revision`으로 시정 가능) |

---

### 7.3 예상 반론에 대한 사전 사실 확인 (`Pre-bunking FAQ 6문 6답`)

1. **Q1. "원주율의 무리수 지수 $\mu(\pi)=2$와 Flint-Hills 급수 수렴이 실제로 빈틈없이 증명되었는가?"**
   - **A1.** 예. `OAI/NumberTheory/PiExponent/Main.lean`의 `pi_irrationality_exponent_eq_two` (`L21-27`)와 `flint_hills_summable` (`L29-32`)은 `869`개 모듈(`94,948`줄) 전체에 걸쳐 **`0 sorry`, `0` 커스텀 공리, `0` 외부 패치**로 완전히 기계 검증되었으며, 정의 왜곡이나 가설 동어반복 결함이 `0`건임을 본 감사단의 독립 `Lean 4` 정리 `75`개(`120/120` 변이 사살)로 교차 확인하였습니다.
2. **Q2. "외부 리뷰에서는 `lean/docs/017.md`를 근거로 Flint-Hills 급수가 형식화되지 않았다고 했는데 어느 쪽이 맞는가?"**
   - **A2.** `lean/docs/017.md:11`은 외부 비교기용 단일 정리 래퍼인 `ComparatorChallenges/PiExponent.lean`(`theorem main`)만을 기준으로 설명했기 때문에 빚어진 오해입니다. 실제 최상위 모듈인 [`Main.lean:29-32`](../proofs/oai_ref/lean/OAI/NumberTheory/PiExponent/Main.lean#L29-L32)와 [`FlintConsequence.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/PiExponent/Analysis/FlintConsequence.lean#L17-L31)(`ν = 9/4` 대입)에 고전적 Flint-Hills 급수 수렴(`Corollary 1.2`)이 `0 sorry`로 완전히 증명되어 있습니다([`thm_03_flint_hills_scope_note_vs_main_lean_audit`](../proofs/pi_simplex_parameters_and_stratigraphy.lean#L95-L103)).
3. **Q3. "이 증명이 임의의 실수 $\alpha$에 대해서도 $\mu(\alpha)=2$를 증명해 버리는 과잉 일반화(`Overreach`) 오류는 없는가?"**
   - **A3.** 없습니다. `Lemma 3.1`(`MatrixArithmetic.lean`)과 `Lemma 3.2`(`RowTranslation.lean`)는 오일러 주기 항등식 **$e^{2\pi i j} = 1 \in \mathbb{Z}[i]$**와 순허수 가우스 정수 $q_i r_i = 2\pi i p_i \in 2\pi i \mathbb{Z}[i]$에 결정적으로 의존합니다. 일반 리우빌 수 $\alpha$에 대해서는 $e^{j\alpha} \notin \mathbb{Z}[i]$이므로 행 변환 불변성과 가우스 정수 행렬식 하한 $\|\Delta\| \ge 1$이 성립하지 않습니다([`thm_51_gaussian_integer_clearing_and_liouville_obstruction`](../proofs/pi_laurent_determinant_and_flint_hills.lean#L77-L109)).
4. **Q4. "논문과 Lean 코드 사이에 최소공배수 상수($4\log 2$ 대 $\log 4 + 4$)와 분리 상수($C_*$)가 다른데 증명이 깨지지 않는가?"**
   - **A4.** 깨지지 않습니다. `Section 4`(`AdmissibleParameters.lean`)에서 차원 $m$을 먼저 충분히 크게 고른 뒤 가중치 수열 $w_1 \gg w_2 \gg \dots \gg w_m$의 비율을 귀납적으로 선택하므로, $m$에만 의존하는 분리 상수 $C_*$나 상수 배율 $\Lambda$는 가중치 꼬리 합 $\Lambda \sum_{i=1}^m 1/w_i < \varepsilon_0 / 3$ (`WeightErrorMargin.lean`)에 의해 임의로 작게 흡수되어 최종 극한 $\mu(\pi)=2$에 영향을 주지 않습니다.
5. **Q5. "`Gate 1`과 `Gate 5`가 모두 `PASS`인데 왜 최종 등급이 `OPFF TIER C`(`Conditional Revision Required`)인가?"**
   - **A5.** 수학적 증명과 커널 무결성은 완전 통과(`PASS`)했으나, `Gate 3`(서지 귀속)에서 (1) `42`쪽 추론 로그에서 실제 사용한 참고문헌 `23`건 중 **`16`건(`69.6%`, `#005` Catalan `35`회 인용 및 Esnault-Viehweg 1984, Ru-Vojta 1997 등)이 최종 원고 `.bib`에서 탈락**했고, (2) 핵심 증명 본문(`Sections 2–5`)에서 `6`대 고전 정리군이 호출부 인용 없이 전개되었기 때문입니다(`CP-03`).
6. **Q6. "`OPFF TIER A`로 승격되기 위한 구체적 수정 요건은 무엇인가?"**
   - **A6.** 수학적 증명이나 Lean 커널 코드를 재작성할 필요 없이, (1) 추론 로그에서 탈락한 `16`개 참고문헌과 본 보고서 `1.2`절 표의 `6`대 고전 원저를 `sections/*.tex` 해당 정리 호출부에 복원하고, (2) `lean/docs/017.md:11`에 `Main.flint_hills_summable` 형식화 사실을 명시하며, (3) 미참조 파일 `4`개(`259`줄)를 정리하면 즉시 `OPFF TIER A` 요건을 충족합니다.

---

### 7.4 10초 재현 명령어 (`Don't Trust, Verify — 10-Second Reproduction`)

```bash
# 1. OpenAI #017 869개 모듈 층서학, Lemma 4.1 유리수 해, 3단 LCM 상수 및 서지 감사 실측 검증
python3 -B proofs/verify_symbolic_pi017.py

# 2. 75개 독립 Lean 4 정리 커널 검증 (v4.29.0-rc8, 1,646줄, 0 sorry, 0 axiom)
~/.elan/bin/lean proofs/pi_simplex_parameters_and_stratigraphy.lean
~/.elan/bin/lean proofs/pi_transverse_multiplicity_and_seshadri_blowup.lean
~/.elan/bin/lean proofs/pi_laurent_determinant_and_flint_hills.lean
```

---

### 7.5 최종 심사 판정문 (`Formal OPFF Referee Verdict Box`)

> **[최종 공식 판정: `OPFF TIER C` (`Conditional Revision Required — Genuine Mathematical Breakthrough with Trace-to-Paper Citation Drop & Technical Attribution Deficit`)]**
>
> OpenAI `#017`(*The irrationality exponent of $\pi$ is $2$*)은 $(\mathbb{P}^1)^m \times \mathbb{P}^1$ 위의 가중 다중점 로랑 보간 행렬식과 유한 여길이 아이디얼 Rees 폭발·대수적 Serre-Čech 소멸을 결합하여 초월수론의 미해결 난제인 **$\mu(\pi) = 2$ (`Theorem 1.1`)**와 **Flint-Hills 급수 수렴 (`Corollary 1.2`, `Main.lean:29-32`)**을 `869`개 `Lean 4` 모듈(`94,948`줄, `0 sorry`, `0 axiom`)로 완결 증명한 유효한 수리적 돌파(`Gate 1: PASS`, `Gate 5: PASS`)이다.
>
> 다만 (1) `42`쪽 추론 로그의 참고문헌 `23`건 중 `16`건(`69.6%`, `#005` Catalan `35`회 인용 및 Esnault-Viehweg 1984, Ru-Vojta 1997 등)이 최종 원고 `references.bib`에서 탈락하고 본문 `Sections 2–5`(`1,327`줄)에서 `6`대 고전 기법이 호출부 인용 없이 전개된 귀속 결손(`Gate 3: FAIL`, `CP-03`), 및 (2) `lean/docs/017.md:11`의 `flint_hills_summable` 범위 오기와 `4`개 미참조 모듈(`259`줄)·`552`개 미참조 선언·`20`개 병렬 워커 네임스페이스(`W06–W64`) 잔존(`Gate 2 & Gate 4: HOLD`)이 확인되므로 **`OPFF TIER C` (`Conditional Revision Required`)**로 판정하며, 위 서지 귀속 및 범위 문서 교정 시 `OPFF TIER A`로의 승격을 권고한다.
