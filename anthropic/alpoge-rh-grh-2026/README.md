# Anthropic(알푀게 + Claude) 리만 가설 · GRH 1,737만 줄 Lean 4 형식증명 완전 해독 아카이브

> **언어 선택 (Language)**: **한국어** | [**English (`README.en.md`)**](./README.en.md)

레벤트 알푀게(Levent Alpöge)와 Claude가 공개한 리만 가설(RH) 및 디리클레 $L$-함수 일반화 리만 가설(GRH) Lean 4 아카이브(`175,187`개 파일, `17,374,215`줄)는 공식 `leanprover/lean4:v4.33.1` 이중 CPU(`x86_64` · `aarch64`) 컴파일 및 외부 독립 커널(`nanoda` · `con-leche` · `lean4lean`) 교차 검증에서 에러 `0`건, 표준 3공리만으로 기계적 형식 인증을 통과했습니다(`PASS`, 검증 영수증 [FINAL_FEDERATED_VERDICT.txt](./data/FINAL_FEDERATED_VERDICT.txt), 인간 학계 동료심사 진행 중 `ONGOING`).
본 폴더는 (1) 신작 `422만 줄` 하부 허브 수식 복원·`Mathlib` 경계 의미론 감사·기출 `201`임포트 동치성 판정·`152`쪽 인간 논문 청사진을 담은 **한·영 전 7권 학술 심층 해독 단행본(`Part A`)**, (2) 고유 `30,343`개 모듈·`308,731`개 선언(`100.00%`) **전수 AST 수식 도감(`Part B`)**, (3) 일반인 무수식 비유부터 전공자 심사까지 아우르는 **한·영 전 6권 눈높이별 풀이집(`00`~`05`)**, (4) 외부 의존성 없는 **독립 무-sorry Lean 4 감사 정리 총 `61`개(`44 + 17`)**를 한곳에 통합 수록합니다.

---

## 출판 조판 단행본 합본 4종 (인쇄 · 태블릿 통독용, 한·영 완비)

- **신작 422만 줄 심층 해독 단행본 (`Part A`, 한국어 `132`쪽 A4)**: **[알푀게_리만가설_신작증명_심층해독단행본_AB.pdf](./book/알푀게_리만가설_신작증명_심층해독단행본_AB.pdf)** · **[오프라인 HTML](./book/알푀게_리만가설_신작증명_심층해독단행본_AB.html)** (`PASS`)
- **신작 422만 줄 심층 해독 단행본 (`Part A`, English `148`p A4)**: **[Alpoge_RH_AB_Deep_Decompilation_EN.pdf](./book/Alpoge_RH_AB_Deep_Decompilation_EN.pdf)** · **[Offline HTML](./book/Alpoge_RH_AB_Deep_Decompilation_EN.html)** (`PASS`)
- **눈높이별 6권 완전 풀이집 (`00`~`05`, 한국어 `53`쪽 A4)**: **[리만가설_1737만줄_완전풀이집.pdf](./book/리만가설_1737만줄_완전풀이집.pdf)** · **[오프라인 HTML](./book/리만가설_1737만줄_완전풀이집.html)** (`PASS`)
- **눈높이별 6권 완전 풀이집 (`00`~`05`, English `55`p A4)**: **[Alpoge_RH_17M_Complete_Decompilation_EN.pdf](./book/Alpoge_RH_17M_Complete_Decompilation_EN.pdf)** · **[Offline HTML](./book/Alpoge_RH_17M_Complete_Decompilation_EN.html)** (`PASS`)

---

## 제I부. 신작 422만 줄 심층 해독 7권 (`part_a/` · `part_a_en/`) 및 전수 AST 수식 도감 (`atlas/`)

각 권의 한국어판(`5,618`줄)과 영문판(`5,427`줄)은 검증된 정확 경로 `.lean:line` 핀 **`1,870`개**가 권별로 `100.00%` 1대1 일치합니다.

1. **제0부 · 총괄 서문 및 해부 지도**: [한국어 (`A00`)](./part_a/A00_총괄서문_및_전체해부지도.md) · [English (`A00`)](./part_a_en/A00_Executive_Preface_And_Master_Map.md)
    - 4계층 검증 분리표, 신작 합집합(`29,067`개 파일, `300,415`개 선언) 정량 원장, 피참조 멱법칙 및 결정론적 전술(`aesop` `0.0033%`) 도판([도판 AB-1](./figures/fig_ab_01_archive_stratification.png) ~ [도판 AB-4](./figures/fig_ab_04_tactic_anatomy.png)).
2. **제1부 · 최상위 봉인 · `Mathlib` 의미론 및 상단 브리지 감사**: [한국어 (`A01`)](./part_a/A01_최상위봉인_Mathlib경계의미론_및_상단브리지감사.md) · [English (`A01`)](./part_a_en/A01_Top_Seal_Mathlib_Boundary_Semantics_And_Upper_Bridge_Audit.md)
    - `Main.lean` · `Statements.lean` 닫힌 명제 건전성, 메타프로그래밍 `8`종(`allowUnsafeReducibility` 고유 `33`파일 `37`회), 고정 `Mathlib` 제타($s=1$ 나눗셈 값, $s=0$, 자명영점) 및 비원시 오일러 인자($\mathrm{Re}(s)=0$) 원문 증명, 상단 `43`개 브리지 해부.
3. **제2부 · 기출 `201`선 및 `PublishedTheorems` 동치성 감사**: [한국어 (`A02`)](./part_a/A02_기출201선_및_PublishedTheorems_의미론동치성감사.md) · [English (`A02`)](./part_a_en/A02_Classical_201_Imports_And_PublishedTheorems_Semantic_Equivalence_Audit.md)
    - `EveryCharacterOfLiteratureOfVWin.lean` 로컬 임포트 `201 / 201`개 전수 분류(유형 I `127` · 유형 II-A `44` · 유형 II-B `11` · 조립·어댑터 `19`) 및 `PublishedTheorems`(`1,073`개) 원문 수식 복원.
4. **제3부 · `Formalism` 4대 기둥(`258만 줄`) 하부 허브 심층 복원**: [한국어 (`A03`)](./part_a/A03_Formalism_4대기둥_하부전술및핵심허브_심층복원.md) · [English (`A03`)](./part_a_en/A03_Formalism_Four_Pillars_Lower_Tactics_And_Core_Hubs_Decompilation.md)
    - `LocalToGlobal`(`95.6만 줄`), `SharpRestriction`(`70.9만 줄`), `HermitianCurvature`(`46.1만 줄`), `PeriodIntegrals`(`45.2만 줄`) 최다 피참조 허브 직독 및 $\sigma = 2/3$ 분모 장벽 3중 상쇄 복원.
5. **제4부 · `Formalism` `112`개 특수 소이론 및 전역 상수 폐루프 복원**: [한국어 (`A04`)](./part_a/A04_Formalism_112개특수소이론_및_전역상수폐루프복원.md) · [English (`A04`)](./part_a_en/A04_Formalism_112_Specialized_Subtheories_And_Global_Constant_Closure.md)
    - 피참조 1위 `RhoDetPrimeEqMuTildeMulChiPow.lean`(`in=921`) 외 `112`개 소이론 6대 클러스터(`43,521`선언) 복원 및 `ShapeWin` $(C_{\mathrm{abs}}, C_0, e_D, e_L) = (2, 3, 2, 0)$ 에서 `CoreGm` $\frac{1}{2} + 9\varepsilon$ 에 이르는 비순환 양화사 폐루프 검증.
6. **제5부 · `Pure_Vwin` 반디버 우회 · 베렌트 타워 및 기계 검증 확장**: [한국어 (`A05`)](./part_a/A05_PureVwin_반디버우회_베렌트타워_및_기계검증확장.md) · [English (`A05`)](./part_a_en/A05_PureVwin_Vandiver_Bypass_Behrend_Tower_And_Formal_Audit_Suite.md)
    - `Pure_Vwin`(`10,832`개 파일, `103만 줄`, `61,209`선언) 약화된 반디버 성질 양날개 패칭, `LiteratureRankNHypothesis` `56`슬롯(문헌 `50` + 신작 `6`), 베렌트 이와사와 타워, 임계치 `Ct = 401` 및 `44`개 Lean 감사 정리 해설.
7. **제6부 · `152`쪽 인간 단축 논문 청사진 및 전역 참조 총색인**: [한국어 (`A06`)](./part_a/A06_부록_인간단축논문_재구성청사진_및_전역참조총색인.md) · [English (`A06`)](./part_a_en/A06_Appendix_152p_Journal_Paper_Blueprint_And_Global_Master_Index.md)
    - `152`쪽 학술지 논문 장·절 매핑 설계도, 전역 기호 사전, 신작 허브 Top 50, 감사 정리 `30`선 및 `8`대 번역 어댑터(`A1`~`A8`) 조견표.
8. **Part B `100.00%` AST 전수 수식 도감 (`atlas/volumes/B00`~`B10`)**: [한국어 마스터 색인 (`B00`)](./atlas/volumes/B00_Master_Index_And_Hubs.md) · [English Master Index (`B00.en`)](./atlas/volumes/B00_Master_Index_And_Hubs.en.md)
    - 고유 `30,343`개 모듈 · `308,731 / 308,731`개 선언(`100.00%`, 무명 `instance` · `scoped` · `local` 포함)의 시그니처·전술·피참조 차수 마크다운 도감(`374,166`줄) 및 JSONL 원장 4종([atlas_summary.json](./atlas/data/atlas_summary.json)).

---

## 제II부. 눈높이별 · 심도별 6권 완전 풀이집 (`00`~`05` · `en/00`~`05`)

1. **[00_한눈에_보는_전체지도.md](./00_한눈에_보는_전체지도.md)** · **[English (`en/00`)](./en/00_Executive_Overview_and_Map.md)** (`전 독자 공통 · 3분 요약 + 용어 통역표`)
    - `175,187`개 파일 구성 도판([도판 1](./figures/fig1_archive_breakdown.png)), 전문 용어 6개 일상 통역표, 4계단 조립 지도.
2. **[01_수식없이_읽는_비유풀이.md](./01_수식없이_읽는_비유풀이.md)** · **[English (`en/01`)](./en/01_Plain_Language_Analogy_Guide.md)** (`일반인 · 중고생용 · 수식 기호 0개`)
    - `10` 이하 소수 손계산 예제, 소리굽쇠 공명, 돋보기 제곱근 개수 직렬 연결, 시소 저울질, 거울 사각지대 봉합 및 베렌트 체 비유 완결 편.
3. **[02_눈으로_만지는_핵심원리_5막.md](./02_눈으로_만지는_핵심원리_5막.md)** · **[English (`en/02`)](./en/02_Core_Principles_Five_Acts.md)** (`학부생 · 개발자용 · 핵심 수식 + 장난감 모형 + 도판 2·3`)
    - $m = \sqrt{X}$ 대수 유도, 유한차원 행렬 전치·차원 나눗셈 및 복소켤레 거울 사각지대 장난감 모형, 실측 비교 그래프([도판 2](./figures/fig2_residual_vs_fake_zero.png), [도판 3](./figures/fig3_lift_cost_barrier.png)).
4. **[03_Lean코드_척추_해부원장.md](./03_Lean코드_척추_해부원장.md)** · **[English (`en/03`)](./en/03_Lean_Code_Spine_Ledger.md)** (`수학 연구자 · 검증자용 아키텍처 원장`)
    - `src/Main.lean:1-12` 부터 5막 기저 파일, 투영 푸앵카레 급수·코시-슈바르츠 감쇠 모듈, 메타코드 8종, `VWin` 짝수(`PsiEven`) 7분할 심부 패칭 및 `UnusedSlot` 9종(`2 + 7`) 대조 원장.
5. **[04_기출대정리_원전복원사전.md](./04_기출대정리_원전복원사전.md)** · **[English (`en/04`)](./en/04_Literature_195_Attribution_Dictionary.md)** (`기출 래퍼 195 / 195 전수 서지 사전`)
    - `EveryCharacterOfLiteratureOfVWin.lean` 기출 래퍼 정리 `195`개 전량(`100.0%`)의 행 번호, 수리 명제, 원저자·연도 한·영 사전.
6. **[05_전공자용_수론심층심사및수식복원서.md](./05_전공자용_수론심층심사및수식복원서.md)** · **[English (`en/05`)](./en/05_Specialist_Referee_and_Equation_Audit.md)** (`전공 수론학자용 심층 요약 · OpenAI #003 교차 심사`)
    - 전역 척도($\varepsilon < 1/52$, `Ct = 401`, 루카스 소수 `413,718,278,401`), 바르그만-포크·양기안 RTT 행렬식, 지겔-베유 $-C m^2 L / k$ 약분식, `VWin` 7분할 심부 해부([도판 4](./figures/fig4_vwin_parity_and_counts.png)) 및 OpenAI `#003` 교차 심사.

---

## 제III부. 독립 Lean 4 기계 검증 스위트 (`61`개 정리) 및 재현 스크립트

- **[alpoge_ab_deep_audit.lean](./proofs/alpoge_ab_deep_audit.lean)**: `Part A` 전권의 코시-슈바르츠 리스트 부등식, 강한 귀납법 르장드르 항등식, 베렌트 3항 행렬식 소거, 비원시 오일러 인자 격리 등 **`44`개 무-sorry 정리**(주 정리 `30` + 보조 `14`, 주석 핀 `68`개) 증명(`PASS`).
- **[alpoge_spine_arithmetic_audit.lean](./proofs/alpoge_spine_arithmetic_audit.lean)**: 6권 풀이집의 지수·합동·기우성·반디버 `plusLen` 통합 지수·전역 체인 폐루프 항등식 **`17`개 무-sorry 정리** 증명(`PASS`).
- **[verify_ab_project.py](./scripts/verify_ab_project.py)** 및 **[verify_guide_integrity.py](./scripts/verify_guide_integrity.py)**: 한·영 `Part A`(`3,740`핀)·`Part B`(`308,731`선언)·6권 풀이집(`390`문헌 핀)·단행본 4종·`MANIFEST.sha256`(`85`건)·Lean `61`개 정리 컴파일을 일괄 검증하는 자동화 게이트(`python3 -B scripts/verify_ab_project.py && python3 -B scripts/verify_guide_integrity.py`).
- **빌드 파이프라인**:
    - Part A-B 파이프라인: [build_part_b_atlas.py](./scripts/build_part_b_atlas.py), [generate_ab_figures.py](./scripts/generate_ab_figures.py), [build_ab_monograph.py](./scripts/build_ab_monograph.py).
    - 6권 풀이집 파이프라인: [extract_proof_anatomy.py](./scripts/extract_proof_anatomy.py), [build_04_dict.py](./scripts/build_04_dict.py), [prime_intuition_lab.py](./scripts/prime_intuition_lab.py), [generate_figures.py](./scripts/generate_figures.py), [build_typeset_book.py](./scripts/build_typeset_book.py).
