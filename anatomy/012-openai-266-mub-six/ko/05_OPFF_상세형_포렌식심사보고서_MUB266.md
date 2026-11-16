# [Forensic & Referee Audit Report] OpenAI `#266` (*Mutually Unbiased Bases in Dimension Six*) 전수 감사 보고서

## 0. 감사 메타데이터 및 암호학적 봉인 원장 (`Provenance & Cryptographic Ledger`)

| 항목 | 세부 내역 |
| :--- | :--- |
| **대상 논문 / 프리프린트** | • **프리프린트 1 (`N(6) = 3`)**: *The maximum number of mutually unbiased bases in dimension six* (`preprints/The-maximum-number-of-mutually-unbiased-bases-in-dimension-six-September-24-2026/`, `12`개 `.tex` `5,945`줄, [`references_mub6.bib`](../proofs/oai_ref/tex_mub/references_mub6.bib#L1-L363) `27`개 키 · `363`줄, `8`개 `.cpp` `2,316`줄, [`check_records.py`](../proofs/oai_ref/cpp/check_records.py#L1-L373) `373`줄)<br>• **프리프린트 2 (`N(6) <= 5` 및 푸리에 인증서)**: *Exact Fourier certificates for $6 \times 6$ complex Hadamard matrices* (`preprints/Exact-Fourier-certificates-for-6x6-complex-Hadamard-matrices-September-24-2026/`, `8`개 `.tex` `1,997`줄, [`references.bib`](../proofs/oai_ref/tex_fourier/references.bib#L1-L326) `26`개 키 · `326`줄, [`verify.py`](../proofs/oai_ref/tex_fourier/verify.py#L1-L576) `576`줄) |
| **대상 코드 저장소** | `openai/math` Family `266` (`lean/OAI/Analysis/MutuallyUnbiased/` `3,386`개 `.lean` 파일 · `2,835,031`줄 + `lean/OAI/LinearAlgebra/Hadamard/` `9`개 파일 · `1,329`줄 + 비교 챌린지 [`MUBSix.lean`](../proofs/oai_ref/challenges/MUBSix.lean#L1-L66) `66`줄 · [`HadamardCubeFiber.lean`](../proofs/oai_ref/challenges/HadamardCubeFiber.lean#L1-L37) `37`줄 = 총 **`3,397`개 파일 · `2,836,463`줄**, 저장소 단일 난제군 줄 수 1위) |
| **동반 추론 로그 / 범위 문서** | 추론 로그 PDF **미제공 (`0`편)** / 범위 공시 문서: [`266.md`](../proofs/oai_ref/docs/266.md#L1-L23) (`23`줄: 프리프린트 1의 `N(6) = 3` 결과가 Lean 4로 형식화되지 않았음을 명시) |
| **툴체인 및 컴파일러** | `Lean 4 v4.29.0-rc8` (`leanprover/lean4:v4.29.0-rc8`) 대 피감 원본 `v4.34.1` / `Python 3.14` (`SymPy` 기호 연산기) |
| **검증 산출물 SHA-256** | • [`mub6_hadamard_fourier_and_cubic_fibers.lean`](../proofs/mub6_hadamard_fourier_and_cubic_fibers.lean): `f2ec0224dade6a0f0e0ff3880c607fded366b2891de69c20035f6a29a670c341`<br>• [`mub6_weiner_completion_and_gram_sos.lean`](../proofs/mub6_weiner_completion_and_gram_sos.lean): `b146dd3a77c83adda600b5dedee13dd9f6c155877ebd4224f1bd2b14462987dd`<br>• [`mub6_stratigraphy_and_binary64_audit.lean`](../proofs/mub6_stratigraphy_and_binary64_audit.lean): `d22a9477cb62a1cf7b71dd2c272136f0c770a0f7eba24362ac09e8d666eb852e`<br>• [`verify_symbolic_mub266.py`](../proofs/verify_symbolic_mub266.py): `1c14ea9d1e931fac06bd0e935b2099bdb6271fe72f1e5ae06b829ab445f8e93b` |
| **검증 방식 (`Verification Method`)** | 독립 `Lean 4` 정리 **`75`개 + `def` `5`개 (`1,249`줄, `0 sorry`, `0 axiom`, 전칭 가설 돌연변이 사살 `358 / 358`건 = `100%`, 구조적 정리 `74 / 75`건, 비선형·귀납 `14`건)** 및 `69`개 업스트림 원문 실시간 파싱·기호 검증 스위트 |
| **준거 감사 헌장 (`Governing Charter`)** | **Open Proof Forensics Foundation (`OPFF`) 5-Gate Joint International Audit Charter** (`COPE · IMU/AMS · ACM v1.1 · ICMJE/CRediT · NeurIPS`, Charter DOI: [`10.5281/zenodo.24241228`](https://doi.org/10.5281/zenodo.24241228), Ledger v1.0.0 DOI: [`10.5281/zenodo.24241229`](https://doi.org/10.5281/zenodo.24241229)) |
| **OPFF 5대 관문 및 공식 등급 판정** | `Gate 1 (수리·커널): PASS (프리프린트 2 범위 N(6)<=5 커널 검증 0 sorry)` · `Gate 2 (원고-코드): FAIL (프리프린트 1 N(6)=3 Lean 형식화 0줄·check_records.py 수식 재계산 0건·고아 Attainable 3 미연결·Main.lean 15/16 미전파 임포트)` · `Gate 3 (서지·윤리): FAIL (서두 60.6%·58.5% 인용 집중 및 1차 고전 문헌 5건 미수록)` · `Gate 4 (공정·개입): FAIL (추론 로그 0편, 9월 7일 미인증 실행본 사후 교체, enable_nanoda:false, 62,767개 미사용 _h* 바인더)` · `Gate 5 (수리 가치): PASS` $\implies$ **`OPFF TIER C` (프리프린트 2 $N(6) \le 5$ 정확 푸리에·그람 SOS 인증서 유효 공인 / 프리프린트 1 $N(6) = 3$ 미형식화 `binary64` 하드웨어 조건부 의존 및 `283.5만`줄 전개 패키징 기준 미충족 / `Conditional Verification & Non-Conforming Artifact`)** |

### 0.1 8대 핵심 지표 요약 스코어카드 (`Executive 8-Metric Scorecard`)

| # | 포렌식 감사 지표 (`Audit Dimension`) | 원본 주장 또는 외형 (`Surface Claim`) | 계측된 물리적 수치 (`Measured Reality`) | OPFF 체크포인트 및 판정 |
| :---: | :--- | :--- | :--- | :---: |
| **1** | **형식 검증 범위 (`N(6) = 3` 대 `N(6) <= 5`)** | 6차원 상호 불편 기저 최대 개수 $N(6) = 3$ 해결 (`#266`) | Lean 4 커널 증명 범위는 **$N(6) \le 5$ (프리프린트 2)**; 프리프린트 1의 **`N(6) = 3`은 Lean 형식화 `0`줄**(`n = 4, 5` 배제는 미형식화 C++ `binary64` 탐색에 의존) | `CP-04 FAIL` |
| **2** | **코드베이스 전개 팽창 및 도달성** | `MutuallyUnbiased/` `3,386`개 파일 · `2,835,031`줄 | `576`줄 [`verify.py`](../proofs/oai_ref/tex_fourier/verify.py#L1-L576) 대비 **`4,921.9`배 줄 수 팽창**; 커널 반사(`Reflected Canonicalizer`) 적용 시 **`2,015,523`줄(`71.1%`) 즉시 절감** | `CP-05 WARN` |
| **3** | **루트 진입점(`Main.lean`) 및 미임포트 고아** | [`Main.lean`](../proofs/oai_ref/lean/Main.lean#L1-L33) `16`개 `import` 구문 (`33`줄) | 활성 전파 `1 / 16`개(`Bounds.lean`) 대 **미전파 임포트 `15 / 16`개(`93.75%`, `29,683`줄)**; 완성된 하한 증명 **`Attainable 3` (`4`개 파일 `342`줄, `0 sorry`) 미임포트 방치** | `CP-05 FAIL` |
| **4** | **프리프린트 1 `check_records.py` 검증 범위** | `100`회 C++ 실행(`196`개 아티팩트) 재현·검증 스크립트 | [`check_records.py`](../proofs/oai_ref/cpp/check_records.py#L2-L7)는 **파생 포맷·범위·단조성만 검사하며 아다마르 잔차·특이값·클리크 배제 수식 재계산 `0`건** | `CP-04 · CP-07 FAIL` |
| **5** | **`binary64` 하드웨어 계약 및 미인증 실행본** | IEEE-754 부동소수점 엄밀 구간 덮개 증명 | `MXCSR 0x1f80`, `-ffp-contract=off`, `covrun` 오프셋 `6035` 수동 역어셈블에 조건부 의존; [`covout.cpp`](../proofs/oai_ref/cpp/covout.cpp#L100-L136) `checkcpu()` 누락; **9월 7일 초기 실행본 미인증 시인 후 10월 4일 실행본으로 교체** | `CP-07 · CP-11 FAIL` |
| **6** | **전제 무결성 (`_h*` 미사용 바인더)** | `629,541`개 선언 (`0 sorry`, `0 axiom`) | 자동 생성 푸비니 정규화 파일 등에 **참조되지 않는 미사용 `_h*` 바인더 `62,767`개**(`MixedSemantics` `54,676` + `PairSemantics` `7,685` + [`SmallPartitions.lean`](../proofs/oai_ref/lean/SmallPartitions.lean#L77-L307) `40`개 등) | `CP-01 · CP-06 WARN` |
| **7** | **두 프리프린트 서지 편중 및 문헌 누락** | 프리프린트 1 `\cite` `33`회, 프리프린트 2 `\cite` `41`회 | 서두 파일에 **`20/33`(`60.6%`) 및 `24/41`(`58.5%`) 집중**(`refinement.tex` `656`줄·`execution.tex` `400`줄 인용 `0`회); 본문 호명 1차 문헌 `5`건(`Delsarte 1973`, `Kraus 1971`, `Schur 1905` 등) `.bib` 미수록 | `CP-09 · CP-10 FAIL` |
| **8** | **정확 푸리에·그람 SOS 수리 코어 유효성** | MRW 비-타오 소멸, $(3,3)$ 세제곱 `5`-순환, $N(6) \le 5$ | `6`개 슈어 블록(`98`개 피벗 `> 40,000`), 분모 교량 `5,806,080`, 바이너 차원 강성 $d^2-k(d-1)=d \iff k=d$ 완결; OPFF 정리 `75`개(`358/358` 변이 사살)로 교차 검증 | `Gate 1 & Gate 5 PASS` |

### 0.2 3단계 신호등 판정 요약표 (`Three-Tier Traffic-Light Scope Summary`)

- 🟢 **`[VERIFIED / 수학적·커널 유효성 공인]` 프리프린트 2 정확 푸리에·그람 SOS 인증서 및 $3 \le N(6) \le 5$ (`Gate 1 & Gate 5: PASS`)**: (i) $8,871 \times 909$ 쌍 모멘트 계수행렬($\operatorname{rank} = 897$)과 `26`항 유리수 푸리에 증인 $L_H$를 통한 비-타오 아다마르 행렬의 $3\langle|L_H|^2\rangle + \langle|g_H(\alpha)g_H(q)|^2\rangle = 0$ 소멸, (ii) 뉴턴 거듭제곱합 소거 $z^6 - e_3 z^3 + e_6$ 위에서 $(3,3)$ 세제곱 섬유의 유일한 연결 `5`-순환 그래프 분류, (iii) 바이너(Weiner)의 $6 \to 7$ 재정렬 크라우스 초연산자 보완($d^2 - k(d-1) = d \iff k = d$)과 $S_5$의 `6`개 영 대칭자 슈어 블록(`98`개 피벗 `> 40,000`, 순 정수 마진 `-2,517,408,343,748,053,647,360 < 0`)을 결합한 $N(6) \le 5$ 증명은 `Lean 4` 커널에서 `0 sorry`로 성립하며, 미임포트 고아로 방치된 `Attainable 3`(`342`줄)을 재연결하면 $3 \le N(6) \le 5$가 완결됨.
- 🟡 **`[DIVERGENT / 조건부 하드웨어 의존 및 전술 전개 팽창]`**: 프리프린트 1의 $N(6) = 3$ 증명(`n = 4, 5` 배제)은 Lean 4로 형식화되지 않았으며(`0`줄), x86-64 리틀엔디언 `binary64` 하드웨어 반올림(`MXCSR 0x1f80`), FMA 비활성화(`-ffp-contract=off`), 바이너리 오프셋 `6035` 수동 역어셈블에 조건부로 의존함. 또한 Lean 코드베이스는 푸비니 유한합 교환을 `56,427`개 키마다 개별 파일로 풀어 써서 `2,835,031`줄(`verify.py` 대비 `4,921.9`배)과 `62,767`개의 미사용 `_h*` 바인더를 발생시킴.
- 🔴 **`[NON-CONFORMING / 국제 출판·아티팩트 규격 미충족]`**: ① [`check_records.py`](../proofs/oai_ref/cpp/check_records.py#L2-L7)가 아다마르 잔차나 특이값 경계를 재계산하지 않는 파생 포맷 검사기임에도 검증 스크립트로 제시된 점, ② [`introduction.tex:155-160`](../proofs/oai_ref/tex_mub/introduction.tex#L155-L160)이 시인하듯 2026년 9월 7일 초기 실행본이 미인증 상태여서 사후(10월 4일) 실행본으로 교체된 점, ③ [`Main.lean`](../proofs/oai_ref/lean/Main.lean#L1-L33)의 `15/16`(`93.75%`) 미전파 루트 임포트와 두 챌린지의 `"enable_nanoda": false` 비활성화, ④ 서두 인용 편중(`60.6%`·`58.5%`) 및 1차 문헌 `5`건 미수록으로 인해 전체 패키지는 `OPFF TIER C`로 판정됨.

---

## 제1부. 서지 분포 편중성 및 선행 문헌 귀속 감사 (`Bibliographic Distribution & Attribution Audit`)

### 1.1 두 프리프린트 장절별 인용 밀도 분포 ([`thm_68_citation_concentration_both_preprints`](../proofs/mub6_stratigraphy_and_binary64_audit.lean#L283-L294))

| 원고 구분 | 서두 파일 인용 (`비율`) | 본문·부록 파일 인용 (`비율`) | 무인용(`0`회) 기술 본문 절 | 판정 |
| :--- | :---: | :---: | :--- | :---: |
| **프리프린트 1 (`N(6) = 3`, `5,945`줄, `\cite` `33`회)** | [`introduction.tex`](../proofs/oai_ref/tex_mub/introduction.tex#L1-L246) (`246`줄): **`20 / 33`회 (`60.6%`)** | 나머지 `9`개 `.tex` (`5,699`줄): **`13 / 33`회 (`39.4%`)** | [`refinement.tex`](../proofs/oai_ref/tex_mub/refinement.tex#L1-L656) (`656`줄, `0`회), [`execution.tex`](../proofs/oai_ref/tex_mub/execution.tex#L1-L400) (`400`줄, `0`회), [`conclusion.tex`](../proofs/oai_ref/tex_mub/conclusion.tex#L1-L11) (`0`회) | **서두 인용 편중 (`34.9 : 1`)** |
| **프리프린트 2 (`N(6) <= 5`, `1,997`줄, 키 호출 `41`회)** | [`paper.tex`](../proofs/oai_ref/tex_fourier/paper.tex#L1-L278) (`278`줄): **`24 / 41`회 (`58.5%`)** | 나머지 `6`개 `.tex` (`1,719`줄): **`17 / 41`회 (`41.5%`)** | [`01-preliminaries.tex`](../proofs/oai_ref/tex_fourier/01-preliminaries.tex#L1-L33) (`33`줄, `0`회); `02-pair-moments.tex`(`305`줄, `1`회), `05-verification.tex`(`401`줄, `1`회) | **서두 인용 편중 (`8.7 : 1`)** |

### 1.2 본문에서 기명·호출되었으나 `.bib`에서 누락된 1차 고전 문헌 `5`건

| 원고·코드 호출 위치 (`파일:행`) | 본문 내 명칭 및 사용된 수학 구조 | 원고 기존 인용 | 누락된 필수 1차 문헌 |
| :--- | :--- | :--- | :--- |
| [`paper.tex:93-95`](../proofs/oai_ref/tex_fourier/paper.tex#L93-L95) | *"Fourier and Delsarte approach"* 실명 언급 및 선형계획 쌍대 경계 | `Matolcsi2012` (2차 문헌만 인용) | **Delsarte (1973)** (*Philips Res. Rep. Suppl.* **10**, 1–103) |
| [`Superoperator.lean:1-202`](../proofs/oai_ref/lean/Superoperator.lean#L1-L202) & [`03-complete-family.tex:15-90`](../proofs/oai_ref/tex_fourier/03-complete-family.tex#L15-L90) | 완전 양수(CP) 초연산자 및 크라우스 연산자 합 표현 $\Phi(X) = \sum K_i X K_i^*$ | `Weiner2013`만 인용 | **Kraus (1971)** (*Ann. Physics* **64**, 311–335); **Choi (1975)** (*Linear Algebra Appl.* **10**, 285–290) |
| [`04-mixed.tex:195-265`](../proofs/oai_ref/tex_fourier/04-mixed.tex#L195-L265) & [`Block0.lean`](../proofs/oai_ref/lean/Block0.lean#L1-L186) | $S_5$ 영 대칭자(Young symmetrizer) 기저 분해 및 `98`개 슈어 여행렬(Schur complement) 피벗 | `GatermannParrilo2004`만 인용 | **Young (1900)** (*Proc. London Math. Soc.* **33**, 97–146); **Schur (1905, 1917)** |
| [`paper.tex:23-27`](../proofs/oai_ref/tex_fourier/paper.tex#L23-L27) | $6 \times 6$ 복소 아다마르 행렬 정의 및 직교성 조건 $H H^* = 6 I_6$ | **무인용 (`0`회)** | **Hadamard (1893)** (*Bull. Sci. Math.* (2) **17**, 240–246) |
| [`03-cubic.tex:25-34`](../proofs/oai_ref/tex_fourier/03-cubic.tex#L25-L34) & [`Polynomials.lean`](../proofs/oai_ref/hadamard/Polynomials.lean#L1-L213) | *"Newton's identities"* 호출을 통한 $p_1 = p_2 = 0 \implies z^6 - e_3 z^3 + e_6$ 유도 | **무인용 (`0`회)** | **Girard (1629)** (*Invention nouvelle en l'algèbre*); **Newton (1707)** (*Arithmetica Universalis*) |

---

## 제2부. 생성 프로비넌스 및 미인증 초기 실행본 감사 (`Provenance & Unauthenticated Run Audit`)

1. **추론 로그(`reasoning_traces`) PDF 미제공 (`0`편)**:
   - 저장소 내 최대 줄 수(`2,836,463`줄)를 차지하는 대표 난제군임에도 두 프리프린트 모두 추론 로그 PDF와 프롬프트 이력이 공개되지 않음.
2. **프리프린트 1의 2026년 9월 7일 미인증 초기 실행본 고백 및 사후 교체**:
   - [`introduction.tex:155-160`](../proofs/oai_ref/tex_mub/introduction.tex#L155-L160)과 [`execution.tex:395-400`](../proofs/oai_ref/tex_mub/execution.tex#L395-L400)은 원고 초안의 기반이 된 2026년 9월 7일 초기 C++ 실행본이 검증되지 않았음(*"has not been authenticated here"*)을 명시하고, 원고 공개일(9월 24일) 이후인 **2026년 10월 4일 실행본(`100`회 프로세스, `196`개 아티팩트)**으로 사후 교체한 사실을 기록함.

---

## 제3부. `2,835,031`줄 전개 층서학, 미전파 우산 임포트 및 고아 `Attainable 3` 방치 감사 (`Stratigraphy & Orphan Audit`)

### 3.1 `OAI/Analysis/MutuallyUnbiased/` 및 `Hadamard/` 층서학 분할 ([`thm_51`](../proofs/mub6_stratigraphy_and_binary64_audit.lean#L22-L35)~[`thm_55`](../proofs/mub6_stratigraphy_and_binary64_audit.lean#L81-L95))

| 계층 구분 | 파일 수 (`비율`) | 코드 줄 수 (`비율`) | 세부 구성 및 도달 상태 |
| :--- | :---: | :---: | :--- |
| **활성 증명 콘 (`Bounds.lean` 도달)** | `3,365 / 3,386` (`99.38%`) | `2,804,944 / 2,835,031` (`98.94%`) | `MixedSemantics` `911`개(`1,729,610`줄) + `Gram*` `576`개(`377,806`줄) + `PairSemantics` `519`개(`343,540`줄) + `Mixed{Sources,Targets,Merge}` `1,000`개(`331,358`줄) + `TaoCertificate` `152`개(`20,762`줄) + 코어 `207`개 |
| **미전파 우산 임포트 (`Main.lean` 단독 참조)** | `16 / 3,386` (`0.47%`) | `29,683 / 2,835,031` (`1.05%`) | [`Main.lean`](../proofs/oai_ref/lean/Main.lean#L1-L33)(`33`줄)의 `16`개 임포트 중 **`15`개(`93.75%`, `29,650`줄)**가 주정리 `Bounds.lean`으로 전파되지 않는 미사용 청크 ([`thm_52`](../proofs/mub6_stratigraphy_and_binary64_audit.lean#L36-L51)) |
| **완전 미임포트 고아 (`MutuallyUnbiased/`)** | `5 / 3,386` (`0.15%`) | `404 / 2,835,031` (`0.01%`) | 하한 증명 **`Attainable 3` `4`개 파일(`342`줄, `0 sorry`: `SmallMatrices`·`Tensor`·`ThreeBases`·`ThreeMain`)** + [`TaoSymmetry.lean`](../proofs/oai_ref/lean/TaoSymmetry.lean#L1-L62)(`62`줄) ([`thm_53`](../proofs/mub6_stratigraphy_and_binary64_audit.lean#L52-L65)) |
| **보조 `Hadamard/` 트리 (`9`개 파일)** | `5` 활성 / `4` 고아 | `863` 활성 / `466` 고아 | [`HadamardCubeFiber.lean`](../proofs/oai_ref/challenges/HadamardCubeFiber.lean#L18-L37) 활성 `5`개(`863`줄) 대 래퍼 `1`개(`117`줄) + `Tao*` 고아 `3`개(`349`줄) ([`thm_54`](../proofs/mub6_stratigraphy_and_binary64_audit.lean#L66-L80)) |

---

## 제4부. `binary64` 부동소수점 하드웨어 계약 및 파생 검사기(`check_records.py`) 한계 감사 (`Hardware Contract & Verifier Scope Audit`)

1. **프리프린트 1 (`N(6) = 3`)의 미형식화 상태 및 `100`회 C++ 실행 파이프라인** ([`thm_60`](../proofs/mub6_stratigraphy_and_binary64_audit.lean#L166-L179)~[`thm_66`](../proofs/mub6_stratigraphy_and_binary64_audit.lean#L251-L265)):
   - [`266.md:10-17`](../proofs/oai_ref/docs/266.md#L10-L17)이 공시하듯 $N(6) = 3$을 주장하는 프리프린트 1은 Lean 4로 형식화되지 않았으며(`0`줄), `seed`(`1`회: `151,744,086`쌍 $\to$ `249,878`개) $\to$ Stage A(`4`회: `3,083`개) $\to$ Stage B(`2`회: `22,379`개 `88`배치) $\to$ 초기 Stage C(`88`회 중 `15`회에서 `binCap = 2,000,000`·`capSteps = 5,000,000` 초과 `163`개 발생) $\to$ 폴백 Stage B(`1`회: `163 -> 1,127`개) $\to$ 최종 Stage C(`4`회)의 총 **`100`회 네이티브 C++ 프로세스**에 의존함.
2. **파생 검사기 [`check_records.py`](../proofs/oai_ref/cpp/check_records.py#L2-L7)의 수식 재계산 `0`건 한계**:
   - `check_records.py`(`373`줄)는 독스트링(`L2-L7`)과 JSON `"scope"`(`L353`)에서 스스로 *"derived checker, not the original audit"*임을 명시하며, 바이너리 레코드 바이트 크기(`356 + 288k` B), `isfinite`, 스칼라 범위(`|p|<=4`, `n,root<1e-6` 등) 및 로그 단조성만 검사할 뿐 **아다마르 잔차 $F(P)$, 야코비 행렬 $DF(P)$ 특이값 섭동 반경, $U(2)$ 극분해 격자 배제, Stage C `66`쌍 클리크 배제 수식을 단 `1`건도 재계산하지 않음**.
3. **x86-64 `binary64` ABI·역어셈블 의존성 및 [`covout.cpp`](../proofs/oai_ref/cpp/covout.cpp#L100-L136)의 `checkcpu()` 누락** ([`thm_67`](../proofs/mub6_stratigraphy_and_binary64_audit.lean#L266-L282), [`thm_74`](../proofs/mub6_stratigraphy_and_binary64_audit.lean#L381-L391)):
   - [`execution.tex:72-105`](../proofs/oai_ref/tex_mub/execution.tex#L72-L105)는 증명 건전성이 `MXCSR 0x1f80`(최근접 짝수 반올림, 비정규수 플러시 금지), `-ffp-contract=off`(FMA 병합 금지), 그리고 컴파일된 `covrun` 바이너리 오프셋 `6035`, `6039`, `603d`, `608b`의 수동 역어셈블 확인에 의존함을 명시함.
   - 그러나 Stage A/B/C 드라이버와 달리 [`covout.cpp:100-136`](../proofs/oai_ref/cpp/covout.cpp#L100-L136)는 `_mm_getcsr()`를 검증하는 `checkcpu()` 호출을 누락하고 표준 라이브러리 `pow` 함수에 의존함.

---

## 제5부. 원고-아티팩트 불일치 및 `62,767`개 미사용 가설 무결성 감사 (`Paper–Artifact Divergence & Premise Integrity Audit`)

### 5.1 원고·챌린지 대 실제 코드의 불일치 대조표

| 불일치 축 | 원고 및 챌린지 표방 내용 | 실제 저장소(`Lean 4` / `C++`) 상태 | 검증 정리 및 판정 |
| :--- | :--- | :--- | :---: |
| **1. `N(6) = 3` 대 `N(6) <= 5` 형식화 간극** | `#266` 대표 원고(프리프린트 1) 제목: *The maximum number of MUBs in dimension six* ($N(6)=3$) | Lean 4 비교 챌린지 [`MUBSix.lean`](../proofs/oai_ref/challenges/MUBSix.lean#L56-L66)은 **$N(6) \le 5$ (`¬Attainable 6`)만 증명**하며 `n = 4, 5` 배제는 Lean 형식화 `0`줄 | [`thm_69`](../proofs/mub6_stratigraphy_and_binary64_audit.lean#L295-L307) (`CP-04 FAIL`) |
| **2. 하한 `Attainable 3` 고아 방치** | 6차원 MUB 최대 개수 경계 ($3 \le N(6) \le 5$) | $\mathbb{C}^2 \otimes \mathbb{C}^3$ 텐서곱으로 `Attainable 3`을 `0 sorry`로 증명한 `4`개 파일(`342`줄)이 **`Main.lean`·`MUBSix.lean` 어디에도 임포트되지 않음** | [`thm_53`](../proofs/mub6_stratigraphy_and_binary64_audit.lean#L52-L65) (`CP-05 FAIL`) |
| **3. 원고 분모 `6,480` 대 Lean 분모 `37,623,398,400`** | [`04-mixed.tex:280-290`](../proofs/oai_ref/tex_fourier/04-mixed.tex#L280-L290): 분모 `6,480` 유리수 잔차 합 $-\frac{2007321335237}{30} < 0$ 제시 | [`Expression.lean:8-11`](../proofs/oai_ref/lean/Expression.lean#L8-L11)은 배율 **`5,806,080` (`2^10 * 3^4 * 5 * 7`)**을 곱한 분모 `37,623,398,400`과 22자리 정수 청크 합 `-2,517,408,343,748,053,647,360 < 0`을 사용하며 [`Algebra.lean:131`](../proofs/oai_ref/lean/Algebra.lean#L131-L139)의 `contradiction_of_residual`은 미호출 사문화됨 | [`thm_43`](../proofs/mub6_weiner_completion_and_gram_sos.lean#L284-L299)~[`thm_47`](../proofs/mub6_weiner_completion_and_gram_sos.lean#L351-L363) |
| **4. 외부 커널 검사기(`nanoda`) 비활성화** | 독립 비교 챌린지 검증 ([`MUBSix.json`](../proofs/oai_ref/challenges/MUBSix.json#L1-L14), [`HadamardCubeFiber.json`](../proofs/oai_ref/challenges/HadamardCubeFiber.json#L1-L14)) | 두 JSON 설정 파일 모두 **`"enable_nanoda": false`**로 외부 커널 검사기 비활성화 | [`thm_70`](../proofs/mub6_stratigraphy_and_binary64_audit.lean#L308-L322) (`CP-11 FAIL`) |

### 5.2 활성 증명 콘 내부 `62,767`개 미사용 `_h*` 가설 바인더 집계 ([`thm_25`](../proofs/mub6_hadamard_fourier_and_cubic_fibers.lean#L419-L427), [`thm_56`](../proofs/mub6_stratigraphy_and_binary64_audit.lean#L96-L108))

- **자동 생성 푸비니 정규화 파일 (`62,727`건)**: 유한합 교환 항등식에서 불필요하게 선언된 미사용 `(_hB : IsMUBFamily B)` `48,742`건 + `MixedSemantics` 보조 `5,934`건 + 미사용 `(_hH : IsHadamard H)` `7,685`건 + `PairTargets` `107`건 + `MixedSources` `259`건 = **`62,727`건**.
- **수작업 모멘트 파일 [`SmallPartitions.lean:77-307`](../proofs/oai_ref/lean/SmallPartitions.lean#L77-L307) (`40`건)**: 항수 3 분할 정리 `4`개(`pattern3_0..3`)에서 각 `1`개(`4`건) + 항수 4 분할 정리 `14`개(`pattern4_0..13`)에서 `8 * 3 + 6 * 2 = 36`개 = **`40`건**의 추이적 등식 잉여 가설(`thm_22`~`thm_24`에서 제거 수리 완료).

---

## 제6부. 유효 증명 코어(`Gate 5: PASS`) 공인, `2,015,523`줄 반사 압축 및 바이너 차원 강성 증명 (`Constructive Verification & Repair`)

### 6.1 프리프린트 2 정확 푸리에·그람 SOS 수리 코어(`Gate 1 & Gate 5: PASS`)의 유효성 공인

1. **MRW 비-타오 아다마르 푸리에 소멸 및 세제곱 `5`-순환 분류 (`Theorems 1–25`)**:
   - $8,871 \times 909$ 쌍 모멘트 선형계($\operatorname{rank} = 897$)와 `26`항 유리수 증인 $L_H$를 통해 $3\langle|L_H|^2\rangle + \langle|g_H(\alpha)g_H(q)|^2\rangle = 0$을 유도하고, 세제곱 아다마르 행렬의 $(3,3)$ 영합 섬유가 5개 정점 위에서 유일한 2-정칙 연결 그래프인 `5`-순환($C_5$)을 이룸을 증명함.
2. **바이너 $6 \to 7$ 크라우스 초연산자 보완 및 `6`개 슈어 블록 Positivstellensatz (`Theorems 26–50`)**:
   - $6$개 MUB가 존재하면 여공간 차원 $36 - 5 \times 6 = 6$ 위에서 재정렬 크라우스 초연산자의 고정점 공간이 가환 대수를 이루어 `7`번째 기저가 강제됨(`Attainable 6 -> Attainable 7`)을 보이고, $S_5$의 `6`개 영 블록 위에서 `98`개 슈어 여행렬 피벗(`> 40,000`, `Block0` 선두 $2\times 2$ 소행렬식 `35,303,779,555,791 > 0`)과 `46,041`개 혼합 모멘트 방정식(`2,425`개 잎 이진 트리)으로 $\neg\text{Attainable } 7 \implies \neg\text{Attainable } 6$ ($N(6) \le 5$)을 완결함.

### 6.2 OPFF 대안 수리: 커널 반사(`2,015,523`줄 절감) 및 바이너 차원 강성 장벽 증명

1. **커널 반사(`Reflected Canonicalizer`)를 통한 `2,015,523`줄(`71.1%`) 코드 압축** ([`thm_58`](../proofs/mub6_stratigraphy_and_binary64_audit.lean#L122-L143), [`thm_59`](../proofs/mub6_stratigraphy_and_binary64_audit.lean#L145-L165)):
   - `56,427`개 모멘트 키(`48,742 + 7,685`)의 행·열 순열 동치 증명을 매번 풀어 쓰는 `2,073,150`줄의 전개 코드를 `1,200`줄 반사 정규화 정리와 키당 `1`줄 `decide` 호출(`57,627`줄)로 대체하여 **`2,073,150 - 57,627 = 2,015,523`줄(`71.1%`)**과 `56,534`개 미사용 바인더를 동시에 제거함.
2. **바이너 초연산자 보완의 차원 강성 장벽 ($d^2 - k(d-1) = d \iff k = d$)** ([`thm_31`](../proofs/mub6_weiner_completion_and_gram_sos.lean#L91-L108), [`thm_49`](../proofs/mub6_weiner_completion_and_gram_sos.lean#L398-L404), [`thm_50`](../proofs/mub6_weiner_completion_and_gram_sos.lean#L407-L414)):
   - 여공간 차원 $d^2 - k(d-1)$이 극대 아벨 부분대수 차원 $d$와 일치할 조건이 $(d-k)(d-1) = 0 \iff k = d$임을 증명하고, $d=6, k=5$에서는 여공간 차원이 `11 > 6`이 되어 `5`차원 비가환 여유분이 발생하므로 초연산자 방법만으로는 $N(6) \le 4$로 내려갈 수 없음을 반례 모델(`thm_50`)로 입증함.

---

## 제7부. 외부 규격 대비 불부합 판정, 3층위 기여 분석 및 최종 결론 (`OPFF Standard-Bound Verdict`)

### 7.1 국제 출판·형식검증 표준 대비 불부합 대조표 (`COPE · IMU/AMS · ACM v1.1 · ICMJE/CRediT · NeurIPS`)

| 국제 표준 대비 불부합 범주 | 규격 판정 기준 | 본 사건(`#266`) 확정 좌표 및 물리적 수치 | 최종 판정 |
| :--- | :--- | :--- | :---: |
| **원고-아티팩트 불일치 (`Paper–Artifact Divergence` / `Gate 2`)** | 대표 원고 주장과 형식 검증 아티팩트 및 검증 스크립트의 정합성 (`ACM Artifact Review v1.1`) | • 프리프린트 1의 $N(6)=3$ 주장은 Lean 4 형식화 `0`줄(`n=4,5` 미형식화)<br>• [`check_records.py`](../proofs/oai_ref/cpp/check_records.py#L2-L7)는 수식 재계산 `0`건인 파생 포맷 검사기이며, `Main.lean` `15/16`(`93.75%`) 임포트가 미전파 상태이고 `Attainable 3`(`342`줄)이 미임포트 고아로 방치됨 | **원고-아티팩트 불일치 (`Gate 2: FAIL`)** |
| **생성 프로비넌스 및 실행 인증 미충족 (`Gate 4`)** | 계산 실험의 사전 인증, 외부 커널 검증 활성화 및 전제 위생 (`IMU/AMS` · `NeurIPS Guidelines`) | • 추론 로그 PDF `0`편 미제공, 프리프린트 1의 **9월 7일 초기 실행본 미인증 시인(`introduction.tex:158`) 및 10월 4일 사후 교체**<br>• [`covout.cpp`](../proofs/oai_ref/cpp/covout.cpp#L100-L136) `checkcpu()` 누락, 두 챌린지 `"enable_nanoda": false`, `62,767`개 미사용 `_h*` 바인더 | **기준 미충족 (`Gate 4: FAIL`)** |
| **선행 문헌 귀속 결손 (`Attribution Deficit` / `Gate 3`)** | 핵심 대수·양자정보 기법의 1차 원전 귀속 (`COPE` · `AMS Ethical Guidelines`) | • 두 원고 인용의 `60.6%`(`20/33`)·`58.5%`(`24/41`)가 서두 파일에 집중(`refinement.tex` `656`줄·`execution.tex` `400`줄 인용 `0`회)<br>• 본문에서 호출한 `Delsarte (1973)`, `Kraus (1971)`, `Choi (1975)`, `Schur (1905)`, `Hadamard (1893)`, `Newton (1707)` 1차 원전 `.bib` 미수록 | **귀속 결손 (`Gate 3: FAIL`)** |

### 7.2 3층위 기여 주체 분석: 인간 선행 이론·CAS 솔버 vs. 유효 `CAP` 코어 vs. 자동 전개 파이프라인 (`Three-Tier Attribution Analysis`)

1. **AI 단독 생성 가능성 `0%`: 인간 양자정보 이론 및 외부 SDP/선형대수 솔버(`verify.py` · `C++`) 의존성**:
   - 본 연구의 두 축은 ① 인간 학자들이 확립한 **Matolcsi–Réffy–Weiner (`MRW`) 푸리에 모멘트 체계**, **Weiner (2013)의 크라우스 초연산자 보완 정리($k=6 \implies k=7$)**, **Gatermann–Parrilo (2004) 대칭군 불변 반정부호계획법(SDP)**, **Rump (2011) 특이값 섭동 경계**, 그리고 ② 외부 Python/CRT 행소거 솔버([`verify.py:142-408`](../proofs/oai_ref/tex_fourier/verify.py#L142-L408), 소수 $10^9+7$ 법 가우스 소거 및 유리수 복원)와 `100`회 C++ 격자 탐색기가 계산한 수치·유리수 인증서 데이터에 전적으로 의존함.
   - 특히 `2,804,944`줄의 활성 Lean 코드는 스스로 `98`개 슈어 피벗이나 `2,425`개 선형 결합 가중치를 탐색한 것이 아니라, 외부 Python 솔버가 생성한 유리수 계수 테이블을 `.lean` 파일 `3,224`개로 직렬화해 `decide +kernel` / `norm_num`으로 검산한 것이므로, 인간 선행 이론과 외부 CAS/C++ 솔버 없이 언어모델 단독 추론으로 본 증명이 생성되었을 가능성은 **`0%`**임.
2. **유효 컴퓨터 보조 증명(`CAP`) 코어의 실질적 수리 기여 (`Gate 1 & Gate 5: PASS`)**:
   - 동시에 프리프린트 2와 `MutuallyUnbiased/Results/Bounds.lean`이 완결한 **$8,871 \times 909$ 쌍 모멘트 푸리에 소멸 + $(3,3)$ 세제곱 섬유 `5`-순환 유일성 + $S_5$ `6`개 슈어 블록(`98`개 피벗 `> 40,000`) 유리수 Positivstellensatz + 바이너 초연산자 보완** 결합은 비소수 거듭제곱 차원 $d=6$에서 아다마르·MUB 모멘트 장벽과 $N(6) \le 5$를 `Lean 4` 커널(`0 sorry`)로 기계 검증한 유효 컴퓨터 보조 증명 코어임.
3. **자동 코드 전개·포장 파이프라인에서 발생한 구조적 불일치**:
   - 반대로 ① `576`줄짜리 `verify.py`의 유한합 정규화를 커널 반사 대신 `3,224`개 샤드 파일(`2,835,031`줄, `4,921.9`배 팽창)과 `62,767`개의 미사용 `_h*` 바인더로 단순 전개한 현상, ② 완성된 `Attainable 3`(`342`줄)을 임포트하지 않고 `Main.lean`에 `15/16` 미전파 임포트를 남긴 현상, ③ 프리프린트 1의 `N(6)=3` 탐색이 Lean으로 형식화되지 않았고 `check_records.py`가 수식 재계산 없는 파생 포맷 검사기임에도 패키지 전면에 배치된 현상은 자동화된 코드 생성·패키징 파이프라인의 구조적 불일치임.

### 7.3 예상 반론 및 팩트 선제 차단 Q&A (`Pre-bunking FAQ`, 6문 6답)

- **Q1. "OpenAI가 `#266`에서 6차원 MUB 최대 개수 난제($N(6) = 3$)를 Lean 4로 완전히 형식 증명한 것 아닌가?"**
  - **A1.** 아닙니다. 업스트림 범위 문서 [`266.md:10-17`](../proofs/oai_ref/docs/266.md#L10-L17)이 직접 인정하듯, **프리프린트 1의 $N(6) = 3$ 주장(`n = 4, 5` 배제)은 Lean 4로 단 1줄도 형식화되지 않았습니다(`0`줄)**. Lean 4 커널이 증명한 것은 프리프린트 2의 상한 $N(6) \le 5$ (`¬Attainable 6`)와 세제곱 아다마르 섬유 성질뿐입니다([`thm_69`](../proofs/mub6_stratigraphy_and_binary64_audit.lean#L295-L307)).
- **Q2. "프리프린트 1에는 C++ 코드와 `check_records.py` 검증기가 함께 공개되어 있으니 $N(6)=3$ 컴퓨터 증명이 재현·검증된 것 아닌가?"**
  - **A2.** [`check_records.py:2-7, 353`](../proofs/oai_ref/cpp/check_records.py#L2-L7)은 스스로 *"원본 감사가 아닌 파생 검사기(derived checker, not the original audit)"*라고 명시하며, 저장된 바이너리 레코드의 바이트 포맷(`356 + 288k` B)과 스칼라 수치 범위만 읽을 뿐 **아다마르 잔차, 야코비 특이값 경계, 극분해 격자 배제, `66`쌍 클리크 배제 수식을 단 1건도 재계산하지 않습니다**. 또한 원고 초안의 9월 7일 실행본은 미인증 상태여서 사후(10월 4일) 실행본으로 교체되었고, 정리의 건전성은 x86-64 `binary64` 하드웨어 반올림과 바이너리 오프셋 `6035` 수동 역어셈블에 조건부로 의존합니다.
- **Q3. "저장소에 `283.5만` 줄의 Lean 4 코드가 있다는 것은 그만큼 깊이 있는 형식 증명이 이루어졌다는 뜻 아닌가?"**
  - **A3.** `2,835,031`줄 중 `2,073,150`줄(`73.1%`)은 `56,427`개 모멘트 키에 대해 유한합의 행·열 순열 교환(푸비니 정리)을 매번 `35~45`줄씩 복사·전개한 보일러플레이트입니다. 동일한 수학적 내용을 커널 반사(`Reflected Canonicalizer`)로 작성하면 **`2,015,523`줄(`71.1%`)이 즉시 제거**되며([`thm_58`](../proofs/mub6_stratigraphy_and_binary64_audit.lean#L122-L143)), 프리프린트 2의 독립 검증기 [`verify.py`](../proofs/oai_ref/tex_fourier/verify.py#L1-L576)는 전체 계산을 단 `576`줄로 수행합니다(`4,921.9`배 전개 인플레이션, [`thm_57`](../proofs/mub6_stratigraphy_and_binary64_audit.lean#L109-L121)).
- **Q4. "바이너(Weiner)의 초연산자 보완법으로 `¬Attainable 7`에서 `¬Attainable 6`을 얻었듯, 같은 방법으로 `¬Attainable 5`나 `¬Attainable 4`도 증명할 수 있지 않은가?"**
  - **A4.** 불가능합니다. 본 감사의 차원 강성 정리([`thm_31`](../proofs/mub6_weiner_completion_and_gram_sos.lean#L91-L108), [`thm_49`](../proofs/mub6_weiner_completion_and_gram_sos.lean#L398-L404), [`thm_50`](../proofs/mub6_weiner_completion_and_gram_sos.lean#L407-L414))가 증명하듯, $k$개 MUB의 직교 여공간 차원 $d^2 - k(d-1)$이 극대 아벨 부분대수 차원 $d$와 같아져야 초연산자 고정점들이 자동 가환되어 $(k+1)$번째 기저를 생성합니다. 이는 $(d-k)(d-1) = 0 \iff k = d$에서만 성립하며, $d=6, k=5$에서는 여공간 차원이 `11 > 6`이 되어 비가환 반례(`thm_50`)가 존재합니다.
- **Q5. "`62,767`개의 미사용 `_h*` 가설 바인더가 $N(6) \le 5$ 정리를 무효화하는가?"**
  - **A5.** 최종 정리를 무효화하지 않습니다. 유한합 재색인 항등식이 원래 `IsMUBFamily`나 `IsHadamard` 가설 없이 성립함에도 코드 생성기가 모든 샤드 보조정리 헤더에 `(_hB : IsMUBFamily B)` 등을 일괄 부착했기 때문이며, 수작업 파일 [`SmallPartitions.lean`](../proofs/oai_ref/lean/SmallPartitions.lean#L77-L307)의 `40`개 잉여 등식 가설 역시 본 감사의 [`thm_22`](../proofs/mub6_hadamard_fourier_and_cubic_fibers.lean#L389-L397)~[`thm_24`](../proofs/mub6_hadamard_fourier_and_cubic_fibers.lean#L408-L418)에서 잉여 가설 없이 수리 증명되었습니다.
- **Q6. "하한 $N(6) \ge 3$ (`Attainable 3`)은 저장소에 없는가?"**
  - **A6.** 놀랍게도 `SmallMatrices.lean`, `Tensor.lean`, `ThreeBases.lean`, `ThreeMain.lean` `4`개 파일(`342`줄)에 `0 sorry`로 완전히 증명되어 있으나, `Main.lean`과 `MUBSix.lean` 어디에도 `import`되지 않은 채 고아 파일로 방치되어 있었습니다([`thm_53`](../proofs/mub6_stratigraphy_and_binary64_audit.lean#L52-L65)). 이를 `Main.lean`에 연결하면 Lean 4 내부에서 $3 \le N(6) \le 5$ 양측 경계가 완성됩니다.

### 7.4 10초 터미널 재현 명령어 (`10-Second Terminal Reproduction`)

```bash
# 1. 독립 Lean 4 정리 75개 (0 sorry, 0 axiom, 358/358 변이 사살) 및 SymPy 검증
lean proofs/mub6_hadamard_fourier_and_cubic_fibers.lean && \
lean proofs/mub6_weiner_completion_and_gram_sos.lean && \
lean proofs/mub6_stratigraphy_and_binary64_audit.lean && \
python3 proofs/verify_symbolic_mub266.py
```

### 7.5 최종 심사 판정문 (`Formal OPFF Referee Verdict Box`)

> **[최종 공식 판정: `OPFF TIER C` (`Conditional Verification & Non-Conforming Artifact`) — 프리프린트 2 ($N(6) \le 5$) 형식증명 코어 유효 공인 / 프리프린트 1 ($N(6) = 3$) 미형식화 `binary64` 조건부 한계 명시 및 `283.5만`줄 아티팩트 재구축 전 무수정 게재 불가]**
>
> OpenAI `#266`(*Mutually Unbiased Bases in Dimension Six*) 가운데 프리프린트 2와 `MutuallyUnbiased/Results/Bounds.lean`이 구축한 정확 푸리에 모멘트 소멸, $(3,3)$ 세제곱 섬유 `5`-순환 분류, 바이너 $6 \to 7$ 크라우스 초연산자 보완 및 $S_5$ `6`개 슈어 블록(`98`개 피벗 `> 40,000`) Positivstellensatz는 상한 $N(6) \le 5$를 `Lean 4` 커널(`0 sorry`)에서 유효하게 증명하여 **`Gate 1 & Gate 5: PASS`**를 충족한다. 그러나 전체 제출 패키지는 **(1) 대표 원고인 프리프린트 1의 $N(6) = 3$ 주장(`n = 4, 5` 배제)이 Lean 4로 형식화되지 않았고(`0`줄), 동반 `check_records.py`가 수식 재계산 `0`건인 파생 포맷 검사기이며, 초기(9월 7일) 실행본이 미인증 상태여서 사후(10월 4일) 교체된 점(`CP-04`, `CP-07`, `CP-11`)**, **(2) `Main.lean`의 `15 / 16`(`93.75%`, `29,683`줄) 미전파 루트 임포트, 완성된 `Attainable 3`(`342`줄, `0 sorry`) 하한 증명의 미임포트 방치, `62,767`개의 미사용 `_h*` 바인더 및 `4,921.9`배 전개 팽창(`CP-05`, `CP-06`)**, **(3) 두 원고의 서두 인용 편중(`60.6%`·`58.5%`)과 본문 호출 1차 고전 문헌 `5`건의 `.bib` 미수록(`CP-09`, `CP-10`)**으로 인해 **OPFF 5대 관문 심사에서 `OPFF TIER C` (`Conditional Verification & Non-Conforming Artifact`)**로 판정한다.
