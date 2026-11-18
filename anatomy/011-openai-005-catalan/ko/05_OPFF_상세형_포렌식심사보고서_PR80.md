# Forensic & Referee Audit Report: OpenAI #005 (PR #80: Catalan's Constant Is Irrational) 전수 감사 보고서

## 0. 감사 메타데이터 및 암호학적 봉인 원장

| 항목 | 세부 내역 |
| :--- | :--- |
| 대상 논문 / 프리프린트 | Catalan's Constant Is Irrational (preprints/Catalans-constant-is-irrational-September-24-2026/, build/main.tex 및 `build/sections/*.tex` 3,001줄, references.bib 28개 키 · 319줄) |
| 대상 코드 저장소 및 제출 PR | openai/math Family 005 (lean/OAI/NumberTheory/Catalan/ 981개 .lean 파일 · 573,816줄 + ComparatorChallenges/Catalan.lean 13줄 = 총 982개 파일 · 573,829줄) / 제출 PR: [mathcommunity/oai-math-revised#80](https://github.com/mathcommunity/oai-math-revised/pull/80) (헤드 커밋 e0bd547) |
| 동반 추론 로그 / 패치 | 추론 로그 PDF 미제공 (0편) / 외부 패키지 패치: lean/patches/PrimeNumberTheoremAnd-lean4341.patch (39,904줄, 55개 diff 블록: 신규 생성 47개 파일 +33,333줄 + 업스트림 수정 8개 파일 +989 / -3,447줄) |
| 툴체인 및 컴파일러 | Lean 4 v4.29.0-rc8 (검증 아카이브 표준) 대 피감 원본 v4.34.1 / Python 3.14 (SymPy 기호 연산기) |
| 검증 산출물 SHA-256 | • [catalan_rows_two_adic_and_odd_primes.lean](../proofs/catalan_rows_two_adic_and_odd_primes.lean): `194cfca5ed0b19bab3582fc453906b4904d46b5a5a3818813082fe9be590b918`<br>• [catalan_palindromic_frobenius_and_modular.lean](../proofs/catalan_palindromic_frobenius_and_modular.lean): `c4d28ebdd6a9102acd0496b7467a817a60d98bc41898093ca5b3114c24930354`<br>• [catalan_real_place_energy_and_contradiction.lean](../proofs/catalan_real_place_energy_and_contradiction.lean): `77b4a4c45c9daecb1764434bd1e20741a6cc40a112fb59eb661fab2ad2bb2432`<br>• [verify_symbolic_catalan005.py](../proofs/verify_symbolic_catalan005.py): `b555a159da0e934d8c9a3673094ee61acbed535406db50dedcb652ed02958aa0` |
| 검증 방식 | 독립 스탠드얼론 Lean 4 정리 75개 + def 3개 (1,336줄, 0 sorry, 0 axiom, 전칭 가설 돌연변이 사살 432 / 432건 = 100%) 및 결정론적 SymPy 재현 스크립트 |
| 적용 감사 규격 | ultari-proof-anatomy 5-Gate Audit Rubric (Open Proof Forensic Framework, OPFF) (COPE · IMU/AMS · ACM v1.1 · ICMJE/CRediT · NeurIPS, Charter DOI: [10.5281/zenodo.24241228](https://doi.org/10.5281/zenodo.24241228), Ledger v1.0.0 DOI: [10.5281/zenodo.24241229](https://doi.org/10.5281/zenodo.24241229)) |
| 5대 관문 및 등급 판정 | Gate 1 (수리·커널): FAIL (CP-12 외부 네임스페이스 무귀속 배치) · Gate 2 (원고-코드): FAIL · Gate 3 (서지·윤리): FAIL · Gate 4 (공정·개입): FAIL · Gate 5 (수리 가치): PASS $\implies$ TIER F (업스트림 고지문 공백 치환·외부 네임스페이스 무귀속 배치·78.3% 진입점 미도달 모듈 층위에 따른 기준 미충족 기각 / Hard Reject / Non-Conforming Artifact) |

### 0.1 8대 핵심 지표 요약 스코어카드

| # | 포렌식 감사 지표 | 원본 주장 또는 외형 (Surface Claim) | 계측된 물리적 수치 (Measured Reality) | 규격 체크포인트 및 판정 |
| :---: | :--- | :--- | :--- | :---: |
| 1 | 저장소 활성 증명 도달률 (Active Proof Cone) | 981개 .lean 파일 · 573,816줄 | 활성 473 / 981개 (48.2%, 124,449줄 = 21.7%) 대 미도달 508 / 981개 (51.8%, 449,367줄 = 78.3%) | CP-05 FAIL |
| 2 | 루트 진입점(Main.lean) 전파율 | 29개 import 구문 (30줄, 정리 0개) | 활성 전파 1 / 29개 (Results.Catalan, 3.4%) 대 미전파 루트 임포트 28 / 29개 (96.6%) | CP-05 FAIL |
| 3 | 원고 Table 1 가우스 소거 대 활성 코드 | Table 1 법 101($\mathbb{F}_{101}$) 가우스 소거 피벗 144개($3\times 48$) 제시 | `FixedGaussian*` 147개 파일(376,998줄 = 65.7%) 전량 진입점 미도달; 활성 코드는 64자리 정수 상수 `S_scale`(L494, L504, L514)로 분모 소거 후 $\operatorname{ZMod} 101$ 우역행렬 곱셈(523줄) 사용 | CP-04 · CP-05 FAIL |
| 4 | 원고 Eq. (5.15) $(n!)^2$ 분모 대 활성 코드 | "Factorials, measure masses, and sheet sums have all been accounted for explicitly." (real-place.tex:407-408) | RealDeterminantUpper.lean:27에서 `/ ((n N).factorial : ℝ) ^ 2` 정의 후 L39-50에서 `1 <= ((n N).factorial : ℝ)^2`으로 $(n!)^2$ 분모를 1로 완화하고 `(2An)^n` 상한 적용 | CP-07 FAIL |
| 5 | 외부 패키지 패치(PrimeNumberTheoremAnd) | lean/patches/PrimeNumberTheoremAnd-lean4341.patch (39,904줄) | PrimeNumberTheoremAnd/IEANTN/Mertens(oai_ref 미수록, @@ -284,23 +284,23 @@, 발췌 L228–L284) 원저자 고지문 17행을 동일 행 수의 공백(0x0A $\times 17$)으로 치환 + PrimeNumberTheoremAnd/ 하위에 자체 파일 46개(+33,333줄) 무귀속 배치 | CP-03 · CP-12 FAIL |
| 6 | 원고 장절별 인용 밀도 및 선행 문헌 귀속 | 전체 .tex 3,001줄 내 `\cite` 37회 (references.bib 28개 키) | 서론·결론 303줄에 30/37회(81.1%, 9.90회/100줄) 대 본문 2,698줄에 7/37회(18.9%, 0.26회/100줄 = 38.1 : 1); PrimeNumberTheoremAnd 및 1차 고전 문헌 12건 미수록 | CP-09 · CP-10 FAIL |
| 7 | 활성 코드 내 가설·네임스페이스 무결성 | 0 sorry, 0 axiom (커널 타입체크 통과) | 더미 바인딩(have _ := hlo) 1건, 콜론 뒤 필터 배치 1건, 미사용 `_h*` 바인더 8건, 동일 네임스페이스 중복 private theorem 13건 | CP-01 · CP-06 WARN |
| 8 | 아델-아르키메데스 수리 코어 유효성 | 카탈랑 상수의 무리수성 ($G \notin \mathbb{Q}$) | 유한 자리 지수 > -2.29084 대 실수 자리 지수 < -2.290939875 < -2.2909 모순 완결; 독립 정리 75개(432/432 변이 사살)로 1,336줄 재증명 | Gate 5 PASS |

### 0.2 3단계 신호등 판정 요약표 (Three-Tier Traffic-Light Scope Summary)

- (수학적 유효성 확인) 아델-아르키메데스 부등식 압착 코어 (124,449줄, Gate 5: PASS): 테일러 접촉 차수 $L=59N$에서의 $\zeta(2)$ 상쇄, $2$-진 완전제곱 $-\frac{2809}{4608}\log 2$, 쿠머 단일 올림수 여과 및 8구간 홀수 소수 적분 $\frac{8609}{2}$(> -2.29084), 회문 프로베니우스 블록 분해($\det U = 2^{p(p-1)/2}$)와 $\operatorname{ZMod} 101$ 우역행렬 인증서($\det \equiv 27, 50, 74 \not\equiv 0$), 실수 자리 2엽 블라슈케-코시 등각 에너지 및 50점 데카르트 브래킷 상한(< -2.290939875 < -2.2909)을 결합한 $G \notin \mathbb{Q}$ 증명은 수학적으로 유효하며 독립 Lean 4 정리 75개(0 sorry, 432/432 변이 사살)로 교차 검증됨.
- (원고-코드 불일치 및 가설 결함): 원고 Table 1에 대응하는 376,998줄 법 101($\mathbb{F}_{101}$) 가우스 소거 트레이스(`FixedGaussian*` 147개 파일)는 활성 증명 콘에서 제외되어 있으며(활성 코드 `FixedDeterminantsNonzero.lean`은 L494, L504, L514의 64자리 정수 상수 `S_scale`로 분모 소거 후 $\operatorname{ZMod} 101$ 우역행렬 곱셈을 수행), `RealDeterminantUpper.lean:27`에 정의된 $(n!)^2$ 분모는 L39-50에서 `1 <= ((n N).factorial : ℝ)^2`으로 완화됨. 또한 활성 콘 내부에 더미 바인딩 1건(have _ := hlo), 콜론 뒤 필터 1건, 미사용 `_h*` 바인더 8건, 중복 선언 13건이 존재함.
- (국제 출판·아티팩트 규격 미충족): 업스트림 PrimeNumberTheoremAnd/IEANTN/Mertens(oai_ref 미수록, @@ -284,23 +284,23 @@)의 원저자 고지문 17행을 동일 행 수의 개행 공백(0x0A $\times 17$)으로 치환하고 PrimeNumberTheoremAnd/ 네임스페이스 하위에 자체 파일 46개(+33,333줄)를 무귀속 배치한 패치 구조(CP-03, CP-12), 전체 코드의 78.3%(449,367줄)에 달하는 진입점 미도달 모듈 층위와 Main.lean의 28/29(96.6%) 미전파 루트 임포트(CP-05), 그리고 PrimeNumberTheoremAnd 및 1차 문헌 12건의 서지 누락(CP-09, CP-10)으로 인해 원본 아티팩트는 TIER F로 판정됨.



## 제1부. 서지 분포 및 선행 문헌 귀속 감사

### 1.1 장절별 인용 밀도 분포 분석 (`build/*.tex` 9개 파일 3,001줄, `\cite` 37회)

| 원고 구간 | 파일명 (`build/sections/*.tex`) | 줄 수 (비율) | 인용 횟수 (비율) | 100줄당 인용 밀도 | 판정 |
| :--- | :--- | :---: | :---: | :---: | :---: |
| 서론 및 결론 (3개 파일) | build/main.tex(44줄, 0회)·introduction.tex(208줄, 26회)·conclusion.tex(51줄, 4회) | 303줄 (10.1%) | 30회 (81.1%) | 9.90회 | 서두·결말 인용 집중 |
| 기술 증명 본문 (§2~§7) | foundations.tex, odd-primes.tex, real-place.tex 등 본문 | 2,698줄 (89.9%) | 7회 (18.9%) | 0.26회 | 기술 본문 귀속 결손 |
| 합계 | 전체 .tex (references.bib 28개 키; 비의존 `Sun2026` `[math.GM]` 1건 포함) | 3,001줄 (100%) | 37회 (100%) | 1.23회 | 인용 밀도 비율 38.1 : 1 |

### 1.2 선행 라이브러리 귀속 결손(Attribution Deficit) 및 1차 문헌 복원 매핑

1. 콘토로비치·타오 팀 PrimeNumberTheoremAnd 서지 누락 및 2차 해설서(Zagier1997) 단독 인용:
   - 원고 Section 3.4 (build/sections/odd-primes.tex:612)는 체비쇼프 소수합 점근식 $\theta(y) = \sum_{p \le y}\log p \sim y$와 뉴먼(Newman)의 해석적 증명을 본문에서 기술하면서 2차 해설 노트인 자기어(Zagier1997)만 인용함.
   - 실제 활성 Lean 코드(ImportedPNTCoreBridge.lean:2,8 및 ContinuousWeightedPNT.lean)는 알렉스 콘토로비치·테런스 타오 팀의 PrimeNumberTheoremAnd 저장소(커밋 c39a751)를 패치하여 CatalanPNT.WeakPNT''(L28)와 CatalanPNT.chebyshev_asymptotic(L32)을 호출하나, 원고 참고문헌(references.bib)에는 PrimeNumberTheoremAnd 항목이 수록되지 않음.
2. 복원 필수 1차 문헌 12건 전수 매핑표 (PR #80에서 복원 완료):

| 원고 위치 (파일:행) | 사용된 수학 항등식·정리·외부 라이브러리 | 원고 기존 인용 | 누락된 필수 1차 문헌 (DOI / 서지정보) |
| :--- | :--- | :--- | :--- |
| Section 3.4 (odd-primes.tex:612) | 체비쇼프 소수합 $\theta(y)\sim y$, 뉴먼 해석적 증명(본문 기명), PrimeNumberTheoremAnd Lean 4 라이브러리 | Zagier1997 (2차 노트 단독, 1차 원전 누락) | Kontorovich, Tao & contributors (2024) (PrimeNumberTheoremAnd); Newman (1980) (10.2307/2321853); Hadamard (1896) (10.24033/bsmf.545); de la Vallée Poussin (1896) |
| Section 2.2 (foundations.tex:146, Lemma 2.1) | 카탈랑 적분 표현 $-4\int_0^{\pi/4}\log\tan v\,dv = 4G$ 및 항별 적분 | 무인용 (0회) | Catalan (1865) (Mém. Acad. Roy. Belgique 33, 1–50) |
| Section 2.3 (foundations.tex:292, Prop 2.3) & Section 3.1 (odd-primes.tex:81, Lemma 3.1) | 르장드르 팩토리얼 $p$-진 부치 공식 $\lfloor z/p\rfloor - 2\lfloor(z/2)/p\rfloor$ 및 쿠머 단일 올림수(carry) 정리 | 무인용 (0회) | Legendre (1808) (Essai sur la théorie des nombres); Kummer (1852) (10.1515/crll.1852.44.93) |
| Section 2.3 (foundations.tex:385) & Section 3 (odd-primes.tex:16) | 정수 열 필터 $\det(\mathcal{F}\mathcal{T})$ 위에서 소행렬식 부치 하한을 전달하는 코시-비네 전개 | 무인용 (0회) | Binet (1813) (J. École Polytech. 9(16)); Cauchy (1815) (J. École Polytech. 10(17)) |
| Section 1.2 (introduction.tex:155-156) & Section 5.1 (real-place.tex:43, 59) | 안드레예프 다중적분 행렬식 항등식 및 코시 이중 교대행렬식 $\det[(1-t_i s_j)^{-1}]$ | 2차 서베이(Forrester2018Andreief, Krattenthaler1999, 1차 원전 누락) | Andréief (1886) (Mém. Soc. Sci. Bordeaux 2, 1–14); Cauchy (1841) (Exercices d'analyse 2, 151–159) |
| Section 5.3 (real-place.tex:342, Prop 5.3) | 단위원 반데르몽드 단항식 행렬의 아다마르 행렬식 부등식($\le n^{n/2}$) | 무인용 (0회) | Hadamard (1893) (Bull. Sci. Math. (2) 17, 240–246) |



## 제2부. 생성 이력 미제공 감사 (Provenance Omission Audit)

- 추론 로그 미제공 및 문제 간 시드 공유:
  - #005(카탈랑 상수의 무리수성)에는 추론 로그(reasoning_traces)와 초기 프롬프트 파일이 제공되지 않음(0편).
  - 동반 문제군인 #017($\mu(\pi)=2$) 추론 로그 1절에서 #005 카탈랑 증명의 아키텍처가 초기 시드로 참조된 기록이 확인됨.



## 제3부. 외부 네임스페이스 무귀속 배치 및 업스트림 고지문 공백 치환 (Unattributed External-Namespace Placement & Comment Blank-Line Replacement)

### 3.1 외부 라이브러리 네임스페이스 하위 무귀속 배치 (PrimeNumberTheoremAnd-lean4341.patch, 39,904줄)

- 패치 구조 (55개 diff 블록, 39,904줄):
  - 신규 파일 47개 생성(46개 Lean 파일 + SiegelZeros/NOTICE.md oai_ref 미수록, +33,333줄) 및 기존 업스트림 파일 8개 수정(+989 / -3,447줄).
  - 콘토로비치·타오 팀의 외부 패키지 네임스페이스인 PrimeNumberTheoremAnd/ 경로 아래에 자체 Lean 파일 46개가 배치됨(Unattributed External-Namespace Placement). 이 중 14개 파일(5,367줄: `PrimeNumberTheoremAnd/Catalan/*` 8개 2,452줄 + `PrimeNumberTheoremAnd/ZetaFive/*` 6개 2,915줄)이 최종 정리 Results/Catalan.lean의 활성 증명 콘에 직·간접 임포트됨.

### 3.2 업스트림 고지문 17행의 동일 행 수 개행 공백 치환 (Line-Preserving Comment Blank-Line Replacement)

- 물증 좌표: lean/patches/PrimeNumberTheoremAnd-lean4341.patch L38712–L38745 (발췌 스냅샷 [PrimeNumberTheoremAnd-lean4341.patch](../proofs/oai_ref/patches/PrimeNumberTheoremAnd-lean4341.patch#L228-L284), 업스트림 PrimeNumberTheoremAnd/IEANTN/Mertens @@ -284,23 +284,23 @@ 원본 287–303행, oai_ref 미수록).
- 바이트·행 변화 현상: 원저자(콘토로비치·타오 팀)의 blueprint_comment 블록 17행(oai_ref 미수록 IEANTN/Mertens 패치 L38723·발췌 [L255](../proofs/oai_ref/patches/PrimeNumberTheoremAnd-lean4341.patch#L255) 고지문: "As such, extensive use of AI tools is \emph{strongly discouraged} in this section." 포함)이 삭제되고 동일 행 수인 17행의 개행 공백(0x0A $\times 17$)으로 치환되어 후속 행 번호 오프셋이 그대로 유지됨.
- 업스트림 PrimeNumberTheoremAnd/Wiener 코드 절삭 및 귀속 헤더 불균형 (L31316–L35688): 업스트림 PrimeNumberTheoremAnd/Wiener(oai_ref 미수록, 발췌 [L178-L227](../proofs/oai_ref/patches/PrimeNumberTheoremAnd-lean4341.patch#L178-L227))에서 import Architect, 원저자 주석, blueprint_comment 블록 및 하류 WeakPNT/체보타레프 증명 등 -2,716줄(+439 / -2,716줄)이 삭제됨. 수정본 `Wiener.lean` 상단에는 5줄짜리 `Adapted from PrimeNumberTheoremAnd...` Apache-2.0 귀속 헤더([L184-L188](../proofs/oai_ref/patches/PrimeNumberTheoremAnd-lean4341.patch#L184-L188), `SiegelZeros/NOTICE.md` [L153](../proofs/oai_ref/patches/PrimeNumberTheoremAnd-lean4341.patch#L153) 병행)가 추가된 반면, 활성 콘에 편입된 신설 `PrimeNumberTheoremAnd/Catalan/*` 및 `PrimeNumberTheoremAnd/ZetaFive/*` 14개 파일에는 라이선스·출처 헤더가 부재함.

### 3.3 타 문제군(#004 $\zeta(5)$) 워커 네임스페이스 교차 임포트

- ImportedPNTCoreBridge.lean:2,8은 namespace Zeta5.W12.ImportedPNTCoreBridge를 선언하고, ContinuousWeightedPNT.lean:11,18은 별도 문제군인 OAI/NumberTheory/ZetaFive/(#004 $\zeta(5)$)에서 7개 파일(1,086줄)을 임포트하여 namespace Zeta5.Workers.W14를 선언함.



## 제4부. 증명 도달성 층서학 및 미전파 루트 임포트 감사 (Stratigraphy & Non-Propagating Root Imports Audit)

### 4.1 Catalan/ 저장소 도달성 분할 (981개 파일 · 573,816줄, [thm_40_catalan_981_file_stratigraphy_and_ghost_ledger](../proofs/catalan_palindromic_frobenius_and_modular.lean#L270))

| 구분 | 파일 수 (비율) | 코드 줄 수 (비율) | 주요 구성 파일 및 성격 |
| :--- | :---: | :---: | :--- |
| 내부 활성 증명 콘 (Active Cone) | 473개 (48.2%) | 124,449줄 (21.7%) | 최종 정리 Results/Catalan.lean (Conclusions.lean)에서 실제 도달 가능한 증명 트리 |
| 외부 패치·타 문제군 차용 활성 파일 | 21개 (Catalan/ 외부) | 6,453줄 (외부) | .patch 생성 14개(5,367줄) + ZetaFive/ 차용 7개(1,086줄) |
| 진입점 미도달 모듈 층위 (Unreachable Module Strata) | 508개 (51.8%) | 449,367줄 (78.3%) | 최종 정리(Results/Catalan.lean)에서 참조되지 않는 미도달 코드 (`FixedGaussian*` 147개 파일 376,998줄 등) |
| 미전파 루트 임포트 (Non-Propagating Root Imports, Main.lean) | 29개 import | 30줄 (정리 0개) | 활성 전파 1 / 29개 (Results.Catalan, 3.4%) 대 미전파 루트 임포트 28 / 29개 (96.6%) ([thm_67_main_lean_unused_manuscript_imports_ratio](../proofs/catalan_real_place_energy_and_contradiction.lean#L302)) |



## 제5부. 원고-아티팩트 불일치 및 증명 전제 무결성 감사 (Paper–Artifact Divergence & Premise Integrity Audit)

### 5.1 원고 본문 대 실제 활성 코드의 불일치 대조표 (Paper–Artifact Divergence Matrix)

| 불일치 축 | 원고(`build/*.tex`) 서술 위치 및 주장 | 실제 저장소(Lean 4) 활성 코드 상태 | 판정 범주 |
| :--- | :--- | :--- | :---: |
| 1. Section 4 비소멸 인증서 (Table 1 가우스 소거 대 $\mathbb{F}_{101}$ 우역행렬) | Section 4, Table 1: 법 101($\mathbb{F}_{101}$) 위에서의 가우스 소거 피벗 $3\times 48 = 144$개와 행 교환 횟수(0, 2, 0)를 표로 제시하며 이를 통해 비소멸성을 증명했다고 서술 | Table 1을 구현한 `FixedGaussian*` 147개 파일(376,998줄, 전체의 65.7%)이 전량 진입점 미도달 모듈 층위에 속함; 실제 활성 코드(FixedDeterminantsNonzero.lean, 523줄)는 64자리 정수 스케일링 상수 `S_scale`(L494, L504, L514)로 분모를 소거한 뒤 $\operatorname{ZMod} 101$ 위에서 $48\times 48$ 우역행렬 3개(FixedModularZeroRightInverse.lean 201줄, FixedModularPlusRightInverse.lean 183줄, FixedModularMinusRightInverse.lean 183줄)를 곱해 $\det \equiv 27, 50, 74 \pmod{101}$만 확인함 ([thm_41](../proofs/catalan_palindromic_frobenius_and_modular.lean#L290), [thm_66](../proofs/catalan_real_place_energy_and_contradiction.lean#L283)) | 원고-아티팩트 불일치 (CP-04, CP-05) |
| 2. Section 5 안드레예프 $(n!)^2$ 분모 완화 (Eq. 5.15) | build/sections/real-place.tex:46-56, 387-408 (Eq. 5.15): 앞에 붙는 인자 $\frac{2^n K_n}{(n!)^2}$을 유지하며 "Factorials, measure masses, and sheet sums have all been accounted for explicitly."(L407-408)라고 서술 | 실제 활성 코드 `RealDeterminantUpper.lean:26-54`는 L27에서 `/ ((n N).factorial : ℝ) ^ 2`을 정의한 뒤 `realDeterminant_factorial_sq_one_le`(L39-50)에서 부등식 `(1 : ℝ) ≤ ((n N).factorial : ℝ) ^ 2`으로 $(n!)^2$ 분모를 1로 완화하고 상한 $(2An)^n$을 사용함 | 원고-아티팩트 불일치 (CP-07) |

### 5.2 증명 전제 및 공리·가설 무결성 감사 (10건의 가설·바인더 결함 및 13건의 중복 선언)

| 전제·가설 무결성 감사 범주 | 학술·형식검증 결함 내용 | 적발 건수 | 적발 위치 (파일:행 및 바인더·정리명) |
| :--- | :--- | :---: | :--- |
| 1. 더미 바인딩에 의한 가설 미참조 (Dummy Binding) | 하한 가설 hlo를 선언한 뒤 증명 본문에서 have _ := hlo로 바인딩하여 후속 추론에서 참조하지 않음 | 1건 | OddLowerPairPool.lean:230-232 (have _ := hlo, [thm_13_repaired_oddUpperProfiles_without_vacuous_hlo](../proofs/catalan_rows_two_adic_and_odd_primes.lean#L237)) |
| 2. 콜론(:) 뒤 필터 배치 (Post-Colon Filter Placement) | 점근 필터 ∀ᶠ N : ℕ in atTop을 정리 파라미터가 아니라 콜론(:) 뒤 결론 타입에 배치함 | 1건 | OddPrimeLossNormalization.lean:210-213 ([thm_45_repaired_pre_colon_large_prime_threshold](../proofs/catalan_palindromic_frobenius_and_modular.lean#L368)) |
| 3. 미사용 가설 바인더 (Unused _h* Premises) | 활성 증명 트리 내부 정리에서 참조되지 않는 미사용 바인더 선언 | 8건 | FinitePlaceAssembly.lean:479, 626 (_hrep, _z), OddPrimeCentralZetaContraction.lean:773 (_hN, _hH), OddPrimeExtractionIndices.lean:36 (_hp), FixedCompactRowsAll.lean:115, 122 (_n, _hn), BarrierCaseTwoBracketYGroup0.lean:138 (_hk) ([thm_18](../proofs/catalan_rows_two_adic_and_odd_primes.lean#L319), [thm_48](../proofs/catalan_palindromic_frobenius_and_modular.lean#L413)) |
| 4. 동일 네임스페이스 중복 선언 (Duplicate Declarations) | 동일 namespace OAI.InternalCatalan 내부의 서로 다른 파일에 동일한 이름의 private theorem을 중복 선언 | 13건 | • barrier_T_3 .. barrier_T_8 (6건): BarrierCaseTwoPointX0.lean:15-37 & BarrierCaseOnePointY1.lean:12-34<br>• barrier_case2_U_3 .. barrier_case2_U_9 (7건): BarrierCaseTwoXExplicitGroup7.lean:490-516 & BarrierCaseTwoXBaseProductCoefficientsData.lean:355-381 ([thm_39](../proofs/catalan_palindromic_frobenius_and_modular.lean#L257)) |



## 제6부. 유효 증명 코어(Gate 5: PASS) 공인, 독립 재검증 및 대안 수리 명세 (Constructive Verification & Repair)

### 6.1 컴퓨터 보조 증명 활성 코어(Active Proof Core, 124,449줄)의 수학적 유효성 확인

- 패치 배치 및 미도달 모듈 층위와 독립적으로, 실제 활성 증명 콘(473개 파일, 124,449줄)이 수행하는 아델-아르키메데스 부등식 압착(Adelico-Archimedean Squeeze) 수리 코어는 수학적으로 완결되어 카탈랑 상수의 무리수성($G \notin \mathbb{Q}$)을 유효하게 증명함(Gate 5: PASS)을 확인함:
  1. 유한 자리($2$-진 및 홀수 소수) 하한: 테일러 접촉 차수 $L=59N$에서의 $\zeta(2)$ 상쇄, $2$-진 완전제곱 계수 $-\frac{2809}{4608}\log 2$, 쿠머 단일 올림수 여과 및 8구간 홀수 소수 손실 적분 $\frac{8609}{2}$을 결합해 유한 자리 지수 하한 > -2.29084 달성 (Theorems 1–25).
  2. 회문 프로베니우스 분해 및 법 101 비소멸 인증서: 회문 기저 전환 행렬식 $\det U = 2^{p(p-1)/2}$과 $\operatorname{ZMod} 101$ 우역행렬 곱셈($\det \equiv 27, 50, 74 \not\equiv 0 \pmod{101}$)으로 비영 유리수 행렬식 보장 (Theorems 26–50).
  3. 실수 자리 2엽 에너지 상한 및 유리성 모순: 블라슈케-코시 등각 접합과 50점 데카르트 부호 변화 브래킷으로 실수 자리 지수 상한 < -2.290939875 < -2.2909를 확립하여, 곱 공식($-2.29084 < -2.2909$ 모순)으로부터 $G \notin \mathbb{Q}$ 도출 (Theorems 51–75).

### 6.2 독립 Lean 4 재검증 및 수리 명세 (75개 정리, 432/432 변이 사살)

1. 3개 독립 .lean 파일(75개 정리 + def 3개, 0 sorry, 0 axiom, 432/432 변이 사살):
   - 573,829줄의 원본 코퍼스를 1,336줄의 스탠드얼론 Lean 4 정본 정리 75개로 재구축하고, have _ := hlo 더미 바인딩 수리본([thm_13](../proofs/catalan_rows_two_adic_and_odd_primes.lean#L237))과 콜론 앞 필터 교정본([thm_45](../proofs/catalan_palindromic_frobenius_and_modular.lean#L368))을 직접 증명함.
2. 필수 아키텍처 수리 명세:
   - ① PrimeNumberTheoremAnd/IEANTN/Mertens(oai_ref 미수록)의 공백 치환된 17행 원저자 고지문 복구 및 46개 신설 파일을 PrimeNumberTheoremAnd/ 네임스페이스에서 OAI/ 내부로 이전,
   - ② 진입점 미도달 모듈 508개(449,367줄, 78.3%) 및 Main.lean 미전파 루트 임포트 28개 정리,
   - ③ 원고 Section 4(Table 1 가우스 소거)와 Section 5((n!)^2 분모 서술)를 실제 활성 코드(ZMod 101 우역행렬 및 (2An)^n 상한)와 일치하도록 개정.

### 6.3 PrimeNumberTheoremAnd 패치 사슬의 sorryAx 비전파(0건) 검증 및 109줄 공백(0x20) 치환 실측

1. 활성 패치 사슬(10개 파일, 2,937줄)의 sorryAx 전파 0건 및 WeakPNT'' 4단계 정석 유도 확인:
   - [Conclusions.lean:11-23](../proofs/oai_ref/lean/Conclusions.lean#L11-L23)(catalan_irrational) $\to$ [ImportedPNTCoreBridge.lean:1-43](../proofs/oai_ref/lean/ImportedPNTCoreBridge.lean#L1-L43)(PrimeNumberTheoremAnd.Catalan.Consequences, oai_ref 미수록)의 외부 임포트 사슬은 패치가 신설한 10개 파일(2,937줄: `Catalan/*` 7개 + ZetaFive/Fourier·Sobolev·SmoothExistence 3개, oai_ref 미수록)만 거친 뒤 순수 `Mathlib.*`에서 닫히며, 미완성 sorry(34개)가 남아 있는 업스트림 PrimeNumberTheoremAnd 원본 파일은 단 1개도 임포트하지 않아 sorryAx = 0임:
     - ① 최상위 tsum (∑') 정의 ([Challenge_Catalan.lean:7-9](../proofs/oai_ref/lean/Challenge_Catalan.lean#L7-L9)): `Irrational (∑' j : ℕ, (-1 : ℝ) ^ j / ((2 * j + 1 : ℕ) : ℝ) ^ 2)`에서 급수가 수렴하지 않으면 ∑'가 유리수 0을 반환해 Irrational 0이 거짓이 되므로, 급수 수렴과 표준 카탈랑 상수 $G$ 일치가 자동 강제됨.
     - ② $\operatorname{Re}(s) \ge 1$ 제타 무영점 (OrdinaryZetaZeroFree, 175줄, oai_ref 미수록): 표준 Complex.riemannZeta와 삼각 부등식 $3 + 4\cos\theta + \cos 2\theta = 2(1+\cos\theta)^2 \ge 0$만으로 $s \neq 1, \operatorname{Re}(s) \ge 1$ 무영점을 유도함.
     - ③ 정칙화 및 위너-이케하라 타우버 정리 (OrdinaryZetaContinuation · Catalan/Wiener, oai_ref 미수록): `Function.update (fun s ↦ (s-1)*riemannZeta s) 1 1` 제거 가능 특이점과 WienerIkeharaTheorem'으로 Tendsto (fun N ↦ cumsum Λ N / N) atTop (𝓝 1) (WeakPNT)을 도출함.
     - ④ WeakPNT'' 및 chebyshev_asymptotic (Catalan/Consequences, 68줄, oai_ref 미수록): $\psi(R)/R \to 1$ 및 Chebyshev.abs_psi_sub_theta_le_sqrt_mul_log를 결합해 $\theta(R)/R \to 1$을 유도하며, [ImportedPNTCoreBridge.lean:12-18](../proofs/oai_ref/lean/ImportedPNTCoreBridge.lean#L12-L18)에서 표준 Mathlib Chebyshev.psi·theta와 rfl로 일치함을 확인함.
2. 업스트림 Wiener 모듈 -2,716줄 절삭, 복제본 원저자 주석 109줄 바이트 보존 공백(0x20) 치환 및 formalization.yaml 누락:
   - [PrimeNumberTheoremAnd-lean4341.patch](../proofs/oai_ref/patches/PrimeNumberTheoremAnd-lean4341.patch)는 IEANTN/Mertens(oai_ref 미수록, @@ -284,23 +284,23 @@)의 17행 개행(0x0A) 치환 외에도, 업스트림 Wiener 모듈에서 -2,716줄을 절삭하고 복제된 4개 파일(Catalan/Wiener 6줄, WienerBounds 6줄, ZetaFive/Sobolev 29줄, ZetaFive/Wiener 68줄) 내부의 원저자 blueprint_comment 109줄을 원래 바이트 길이 그대로의 아스키 공백(0x20)으로 치환했으며, 루트 formalization.yaml(176편 목록)에 #005가 등재 누락되어 있음.



## 제7부. 외부 규격 대비 불부합 판정 및 최종 결론 (Standard-Bound Verdict)

### 7.1 출판윤리위원회(COPE) 및 5대 국제 학술 표준 대비 불부합 대조표

| 국제 표준 대비 불부합 범주 | 규격 판정 기준 | 본 사건(#005) 확정 좌표 및 수치 | 최종 판정 |
| :--- | :--- | :--- | :---: |
| 원고-아티팩트 불일치 (Paper–Artifact Divergence / Gate 2) | 원고의 표·수식 서술과 실제 활성 증명 코드 경로의 일치성 (ACM Artifact Review v1.1) | • 376,998줄(147개 파일) 가우스 소거 코드가 진입점 미도달 상태임에도 원고 Table 1에 증명 경로로 수록<br>• 코드(RealDeterminantUpper.lean:39-50)에서 1 <= (n!)^2으로 완화한 팩토리얼 분모를 원고 Eq. (5.15)에서 유지된 것으로 기술 | 불일치 (Paper–Artifact Divergence) |
| 업스트림 고지문 공백 치환 및 미전파 루트 임포트 (Gate 1·2) | 외부 저장소 원문 보존 및 루트 진입점과 활성 증명 트리의 정합성 (CP-05, CP-12) | • PrimeNumberTheoremAnd/IEANTN/Mertens(oai_ref 미수록, @@ -284,23 +284,23 @@)의 원저자 고지문 17행이 동일 행 수의 개행 공백(0x0A $\times 17$)으로 치환되어 후속 행 번호 오프셋이 유지됨<br>• Main.lean 루트 임포트 28/29(96.6%)가 미전파 임포트이며 449,367 / 573,816줄(78.3%, 508/981개 파일)이 진입점 미도달 모듈 층위에 해당함 | 기준 미충족 |
| 선행 문헌 귀속 결손 및 외부 네임스페이스 무귀속 배치 (Gate 3·4) | 선행 오픈소스·1차 문헌 귀속 및 네임스페이스 경계 준수 (COPE · AMS Ethical Guidelines) | • PrimeNumberTheoremAnd를 .bib에서 누락한 채 PrimeNumberTheoremAnd/ 네임스페이스 하위에 46개 파일(+33,333줄) 무귀속 배치<br>• #004 $\zeta(5)$ 프로젝트의 Zeta5.W12·W14 워커 파일 미고지 재사용 및 고전 1차 문헌 12건 미귀속 | 귀속 결손 (Attribution Deficit) |

### 7.2 3층위 기여 주체 분석: 인간 학자 선행 자산 vs. 컴퓨터 보조 증명(CAP) 코어 vs. 자동 포장 파이프라인 (Three-Tier Attribution Analysis)

1. AI 단독 생성 가능성 0%: 인간 학자 선행 인프라 및 컴퓨터 대수(CAS) 탐색 의존성:
   - 본 증명의 3대 축은 ① 콘토로비치·타오 팀의 PrimeNumberTheoremAnd 라이브러리(위너-이케하라 타우버 정리 및 체비쇼프 소수합 점근식 $\theta(y) \sim y$), ② 리보알(Rivoal)·바실리 주딜린(Vasily Zudilin) 계열 초거대 유리수 행렬 및 다중적분 틀, ③ 외부 CAS/수치 최적화 파이프라인이 탐색한 테일러 접촉 차수 $L=59N$, $\operatorname{ZMod} 101$ 우역행렬 엔트리 $3 \times 48^2 = 6,912$개, 실수 자리 50점 데카르트 브래킷 격자에 직접 의존함.
   - 특히 FixedModularZeroRightInverse.lean, FixedModularPlusRightInverse.lean, FixedModularMinusRightInverse.lean에 하드코딩된 $48 \times 48$ 법 101 우역행렬과 `BarrierCase*`의 다항식 계수 데이터는 외부 선형대수 솔버가 계산한 산출물을 Lean 배열 리터럴로 직렬화하여 decide +kernel·norm_num으로 검증한 인증서(Certificate)이므로, 인간 학자의 PrimeNumberTheoremAnd 인프라와 외부 CAS 계산기 없이 언어모델 단독 추론으로 본 증명이 생성되었을 가능성은 0%임.
2. 유효 컴퓨터 보조 증명(CAP) 코어의 실질적 수리 기여 (Gate 5: PASS):
   - 동시에, 124,449줄의 활성 증명 콘이 수행한 회문 프로베니우스 기저 분해($\det U = 2^{p(p-1)/2}$) + $\operatorname{ZMod} 101$ 우역행렬 검증(523줄) + $2$-진 완전제곱($-\frac{2809}{4608}\log 2$) + 8구간 홀수 소수 적분($\frac{8609}{2}$) + 2엽 블라슈케-코시 등각 에너지 상한(<-2.290939875 < -2.2909) 결합은 약 160년간 미해결이던 카탈랑 상수의 무리수성($G \notin \mathbb{Q}$)을 Lean 4 커널 위에서 0 sorry로 완결한 유효 컴퓨터 보조 증명(Valid CAP Core)임.
3. 자동 포장·번역 파이프라인(Automated Packaging Pipeline)에서 발생한 구조적 불일치:
   - 반대로 ① 구세대 법 101($\mathbb{F}_{101}$) 가우스 소거 트레이스(`FixedGaussian*` 147개 파일 376,998줄)를 523줄짜리 $\operatorname{ZMod} 101$ 우역행렬 곱셈(`M * R = I`)으로 교체한 뒤에도 구세대 파일을 삭제하지 않고 Main.lean에 28/29 미전파 임포트로 남겨둔 현상(78.3% 미도달 층위), ② 원고 Table 1과 Eq. (5.15)가 교체 전·완화 전 수식을 그대로 서술한 원고-코드 괴리, ③ .patch 병합 과정에서 IEANTN/Mertens(oai_ref 미수록)의 17행 고지문이 개행 공백으로 치환되고 46개 워커 파일이 PrimeNumberTheoremAnd/ 하위에 배치된 현상은 수리 증명 코어 자체의 결함이 아니라 다중 워커(Zeta5.W12·W14) 병합 및 자동 원고 생성 파이프라인의 검수 부재에서 기인한 아티팩트 패키징 결함임.

### 7.3 예상 반론 및 팩트 선제 차단 Q&A (Pre-bunking FAQ, 6문 6답)

- Q1. "Results/Catalan.lean이 0 sorry, 0 axiom으로 Lean 4 커널을 통과했는데 왜 TIER F인가?"
  - A1. 5대 관문 감사 규격은 수학적 유효성(Gate 5)과 아티팩트·서지·패치 무결성(Gate 1~4)을 분리 심사합니다. 활성 수리 코어는 Gate 5: PASS를 받았으나, 외부 라이브러리(PrimeNumberTheoremAnd) 네임스페이스 하위에 46개 파일을 무귀속 배치하고 원저자 고지문 17행을 공백 치환한 패치(Gate 1·3·4 FAIL) 및 78.3% 미도달 모듈·원고 Table 1 불일치(Gate 2 FAIL)는 국제 출판·아티팩트 규격(COPE, ACM v1.1)의 Hard Reject 요건에 해당합니다.
- Q2. "376,998줄의 가우스 소거 코드(`FixedGaussian*`)가 사용되지 않았다면 비소멸성 증명에 구멍이 뚫린 것 아닌가?"
  - A2. 아닙니다. 정수 행렬 $M \in \mathbb{Z}^{48 \times 48}$의 행렬식이 소수 $p = 101$을 법으로 하여 $\det(M \bmod 101) \equiv 27, 50, 74 \not\equiv 0 \pmod{101}$이면 정수 위에서도 $\det M \neq 0$이 즉시 성립합니다([thm_41](../proofs/catalan_palindromic_frobenius_and_modular.lean#L290)). 즉 수학적으로는 523줄의 $\operatorname{ZMod} 101$ 우역행렬 증명이 훨씬 간결하고 완전하며, 문제는 수학적 구멍이 아니라 폐기된 376,998줄의 구세대 법 101 가우스 소거 트레이스 코드를 저장소에 남겨두고 원고 Table 1에 마치 활성 증명인 것처럼 수록한 원고-아티팩트 불일치입니다(64자리 정수 `S_scale`은 `FixedDeterminantsNonzero.lean:494,504,514`의 분모 소거용 스케일링 상수임).
- Q3. "원고 Eq. (5.15)와 달리 코드(RealDeterminantUpper.lean:39-50)가 $(n!)^2$ 분모를 1로 완화했다면 실수 자리 상한 부등식이 깨지지 않는가?"
  - A3. 깨지지 않습니다. $(n!)^2 \ge 1$이므로 분모를 1로 바꾸면 상한이 더 커지는 방향(보수적 완화)이며, 회문 프로베니우스 기저와 2엽 등각 사상이 만드는 지수 감쇠율(<-2.290939875)이 다항식·지수 오차를 압도하기 때문에 $(n!)^2$ 분모 없이도 최종 모순($-2.29084 < -2.2909$)이 성립합니다. 다만 원고 본문(real-place.tex:407-408)이 "팩토리얼 인자를 명시적으로 반영했다"고 실제 코드와 다르게 서술한 점이 CP-07 원고-코드 불일치로 지적된 것입니다.
- Q4. "IEANTN/Mertens(oai_ref 미수록)의 17행 고지문 삭제는 단순한 빌드 오류 회피용 수정 아닌가?"
  - A4. import Architect 의존성을 제거할 때 주석 매크로만 주석 처리(/- ... -/)하거나 삭제하면 행 수가 줄어듭니다. 반면 패치 L38712–L38745(@@ -284,23 +284,23 @@, 발췌 [L228-L284](../proofs/oai_ref/patches/PrimeNumberTheoremAnd-lean4341.patch#L228-L284))는 IEANTN/Mertens(oai_ref 미수록)에서 원저자의 AI 사용 제한 고지문 17행을 제거한 자리에 정확히 동일한 행 수인 17줄의 개행 바이트(0x0A $\times 17$)를 삽입해 후속 행 번호 오프셋을 보존했으며, 동시에 PrimeNumberTheoremAnd를 원고 .bib에서 누락했습니다. 본 보고서는 의도를 추정하지 않고 이 물리적 바이트·행 보존 현상과 서지 누락만을 객관적 사실로 기록합니다.
- Q5. "OddLowerPairPool.lean:230의 have _ := hlo 더미 바인딩이 전체 카탈랑 무리수성 정리를 무효화하는가?"
  - A5. 최종 정리를 무효화하지 않습니다. 해당 보조정리의 결론 부등식은 하한 가설 hlo 없이도 상한 가설만으로 성립하는 단조 부등식이며, 본 감사의 [thm_13_repaired_oddUpperProfiles_without_vacuous_hlo](../proofs/catalan_rows_two_adic_and_odd_primes.lean#L237)에서 잉여 가설 hlo를 완전히 제거한 정본 정리를 0 sorry로 증명해 수리했습니다.
- Q6. "제출된 PR #80을 병합하면 무엇이 해결되는가?"
  - A6. PR #80은 원고 .tex와 references.bib에서 누락된 콘토로비치·타오 팀의 PrimeNumberTheoremAnd 및 1차 고전 문헌 12건(Catalan 1865, Legendre 1808, Kummer 1852, Cauchy 1815/1841, Binet 1813, Andréief 1886, Hadamard 1893/1896, de la Vallée Poussin 1896, Newman 1980)을 정확한 수식 호출 위치에 복원하고, NOTES.md(oai_ref 미수록)에 패치 구조·미도달 모듈 층위·원고-코드 대조 원장을 명시하여 독자와 후속 연구자가 활성 수리 코어(124,449줄)를 투명하게 검증·활용할 수 있게 합니다.

### 7.4 10초 터미널 재현 명령어 (10-Second Terminal Reproduction)

```bash
# 1. 독립 Lean 4 정리 75개 (0 sorry, 0 axiom) 및 SymPy 대수·아델 수축 검증
lean proofs/catalan_rows_two_adic_and_odd_primes.lean && \
lean proofs/catalan_palindromic_frobenius_and_modular.lean && \
lean proofs/catalan_real_place_energy_and_contradiction.lean && \
(cd proofs && python3 verify_symbolic_catalan005.py)

# 2. IEANTN/Mertens(oai_ref 미수록) 17행 공백 치환 및 PrimeNumberTheoremAnd 패치 스냅샷 직접 확인
sed -n '228,284p' proofs/oai_ref/patches/PrimeNumberTheoremAnd-lean4341.patch
```

### 7.5 최종 심사 판정문 (Referee Verdict Summary)

- 최종 판정: TIER F (Hard Reject / Non-Conforming Artifact, 원본 패치·아티팩트 기준) / PR #80 서지 복원·포렌식 감사 병합 대기
- OpenAI #005(Catalan's Constant Is Irrational)의 활성 수리 코어(473개 파일, 124,449줄: $\operatorname{ZMod} 101$ 우역행렬 인증서 및 아델-아르키메데스 부등식 압착)는 카탈랑 상수의 무리수성($G \notin \mathbb{Q}$)을 수학적으로 유효하게 증명하여 Gate 5 (수리 가치): PASS를 충족하나, 제출된 원고와 저장소 패키징은 (1) PrimeNumberTheoremAnd/IEANTN/Mertens(oai_ref 미수록, @@ -284,23 +284,23 @@)의 원저자 고지문 17행을 동일 행 수의 공백(0x0A $\times 17$)으로 치환하고 PrimeNumberTheoremAnd/ 네임스페이스 하위에 46개 파일(+33,333줄)을 무귀속 배치한 패치 구조(CP-03, CP-12), (2) 전체 코드의 449,367 / 573,816줄(78.3%, 508 / 981개 파일)이 진입점 미도달 모듈 층위이고 Main.lean 루트 임포트의 28 / 29개(96.6%)가 미전파 임포트인 아티팩트 불일치(CP-05), (3) 미도달 상태인 376,998줄 법 101 가우스 소거 피벗을 원고 Table 1에 수록하고 코드에서 1 <= (n!)^2으로 완화한 분모를 명시적으로 반영했다고 기술한 원고-아티팩트 불일치(CP-04, CP-07)로 인해 5대 관문 감사에서 TIER F (Hard Reject / Non-Conforming Artifact)로 판정한다.
- 아울러 mathcommunity/oai-math-revised에 제출된 [PR #80](https://github.com/mathcommunity/oai-math-revised/pull/80)은 원고 본문에서 누락된 PrimeNumberTheoremAnd 및 1차 고전 문헌 12건을 정확한 수식 위치에 복원하고, NOTES.md(oai_ref 미수록)에 위 패치 구조·고지문 치환·미도달 모듈 층위 감사 원장을 공식 기록하는 시정 기여이다.
