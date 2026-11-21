# Anthropic(알푀게 + Claude) 리만 가설 1,737만 줄 Lean 증명 완전 풀이집

> **언어 선택 (Language)**: **한국어** | [**English (`README.en.md`)**](./README.en.md)

레벤트 알푀게(Levent Alpöge)와 Claude가 공개한 리만 가설(RH) 및 디리클레 $L$-함수 일반화 리만 가설(GRH) Lean 4 아카이브(`175,187`개 파일, `17,374,215`줄)는 공식 `leanprover/lean4:v4.33.1` 이종 커널(`x86_64` · `aarch64`)에서 에러 `0`건, 표준 3공리만으로 전수 검증을 통과했습니다(`PASS`, 검증 영수증 [FINAL_FEDERATED_VERDICT.txt](./data/FINAL_FEDERATED_VERDICT.txt)). 본 저장소는 주석 `0`줄과 참고문헌 `0`개로 배포된 이 증명을 역설계하여 일반 독자용 무수식 비유부터 수론 전공자·심사위원용 심부 등식 복원, 기출 `195`선 전수 서지 사전, 독립 Lean 4 산술 감사까지 완비한 한국어 해설 패키지 및 출판 단행본입니다.

---

## 단행본 합본 (인쇄 · 태블릿 통독용, 한·영 완비)

- **한국어판 (`48`쪽 A4)**: **[리만가설_1737만줄_완전풀이집.pdf](./book/리만가설_1737만줄_완전풀이집.pdf)** · **[오프라인 HTML](./book/리만가설_1737만줄_완전풀이집.html)** (`PASS`)
- **영문판 (`51`쪽 A4)**: **[Alpoge_RH_17M_Complete_Decompilation_EN.pdf](./book/Alpoge_RH_17M_Complete_Decompilation_EN.pdf)** · **[Offline HTML](./book/Alpoge_RH_17M_Complete_Decompilation_EN.html)** · **[영문 6권 본문 (`en/`)](./README.en.md)** (`PASS`)

---

## 개별 문서 목차 (눈높이별 · 심도별 열람)

1. **[00_한눈에_보는_전체지도.md](./00_한눈에_보는_전체지도.md)** (`전 독자 공통 · 3분 요약 + 용어 통역표`)
    - `175,187`개 파일 구성 도판([도판 1](./figures/fig1_archive_breakdown.png)), 전문 용어 6개 일상 통역표, 4계단 조립 지도.
2. **[01_수식없이_읽는_비유풀이.md](./01_수식없이_읽는_비유풀이.md)** (`일반인 · 중고생용 · 수식 기호 0개`)
    - `10` 이하 소수 손계산 예제, 소리굽쇠 공명, 돋보기 제곱근 개수 직렬 연결, 시소 저울질, 거울 사각지대 봉합 및 베렌트 체 비유 완결 편.
3. **[02_눈으로_만지는_핵심원리_5막.md](./02_눈으로_만지는_핵심원리_5막.md)** (`학부생 · 개발자용 · 핵심 수식 + 선형대수·복소켤레 장난감 모형 + 도판 2·3`)
    - $m = \sqrt{X}$ 대수 유도, 유한차원 행렬 전치·차원 나눗셈 및 복소켤레 거울 사각지대 장난감 모형, 실측 비교 그래프([도판 2](./figures/fig2_residual_vs_fake_zero.png), [도판 3](./figures/fig3_lift_cost_barrier.png)).
4. **[03_Lean코드_척추_해부원장.md](./03_Lean코드_척추_해부원장.md)** (`수학 연구자 · 검증자용 아키텍처 원장`)
    - `src/Main.lean:1-12`부터 5막 기저 파일, 투영 푸앵카레 급수·코시-슈바르츠 감쇠 모듈, 메타코드 8종, `VWin` 짝수(`PsiEven`) 7분할 심부 패칭(`103만 줄` 신작 계층) 및 `UnusedSlot` 9종(`2 + 7`)까지의 Lean 행 번호 대조 원장.
5. **[04_기출대정리_원전복원사전.md](./04_기출대정리_원전복원사전.md)** (`서지 · 선행 연구 195 / 195 전수 복원 사전`)
    - `EveryCharacterOfLiteratureOfVWin.lean`에 수록된 기출 래퍼 정리 `195`개 전량(`100.0%`)의 행 번호, 수리 명제, 원저자·연도 사전.
6. **[05_전공자용_수론심층심사및수식복원서.md](./05_전공자용_수론심층심사및수식복원서.md)** (`전공 수론학자 · 심사위원용 심층 수리 보고서`)
    - 전역 척도($\varepsilon < 1/52$, `Ct = 401`, 루카스 소수 `413,718,278,401`), 바르그만-포크·`MasterIdentity`·양기안 RTT 행렬식, 지겔-베유 $-C m^2 L / k$ 약분식, 투영 푸앵카레·코시-슈바르츠 감쇠 $q^{-(k-2r-5)}$, `VWin`(`1,609만 줄`: 기출 `1,506만 줄` + 신작 패칭 `103만 줄`) 7분할 $\mathrm{GSp}_4 \cdot U(3)$ 심부 해부([도판 4](./figures/fig4_vwin_parity_and_counts.png)), 형식화 여유분 및 OpenAI `#003` 교차 심사.

---

## 형식 검증 증명 및 재현·조판 스크립트

- **[alpoge_spine_arithmetic_audit.lean](./proofs/alpoge_spine_arithmetic_audit.lean)**: 제05권의 지수·합동·기우성·반디버 `plusLen` 통합 지수·형식화 여유분 항등식 `16`개 정리를 외부 의존성 없이 검증한 Lean 4(`v4.33.1`) 증명 파일(`0 sorry`, `PASS`).
- **[extract_proof_anatomy.py](./scripts/extract_proof_anatomy.py)** → **[anatomy_stats.json](./data/anatomy_stats.json)**: `175,187`개 파일 임포트 그래프, 영역별 줄 수, 기출 래퍼 `195`선 추출(`PASS`).
- **[build_04_dict.py](./scripts/build_04_dict.py)** → **[04_기출대정리_원전복원사전.md](./04_기출대정리_원전복원사전.md)**: `EveryCharacterOfLiteratureOfVWin.lean`의 `195`개 기출 래퍼 행 번호 및 7대 기둥 서지 사전 자동 생성(`PASS`).
- **[prime_intuition_lab.py](./scripts/prime_intuition_lab.py)** → **[prime_lab_results.json](./data/prime_lab_results.json)**: $X \le 10,000$ 잔차 $G_z(X)$ 및 베렌트 등차수열 회피 집합 계산(`PASS`).
- **[generate_figures.py](./scripts/generate_figures.py)**: 고해상도 한글 편집 도판 4종 생성(`PASS`).
- **[build_typeset_book.py](./scripts/build_typeset_book.py)**: 마크다운 6권을 합본 HTML 및 A4 출판용 PDF 단행본으로 조판(`PASS`).
- **[verify_guide_integrity.py](./scripts/verify_guide_integrity.py)**: 문서 7종, 도판 4종, 기출 `195`핀 전수 일치, 보조 Lean 컴파일, 조판 무결성 통합 검증(`PASS`).
