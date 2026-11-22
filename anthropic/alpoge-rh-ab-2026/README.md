# 알푀게 리만 가설 · GRH 1,737만 줄 Lean 4 형식증명 심층 해독 패키지 (`Part A` + `Part B`)

- **작성 및 수리 기준일**: `2026-11-22`
- **검증 대상 원본**: Levent Alpöge & Claude (Anthropic), `175,187`개 `.lean` 파일 (`17,374,215`줄, `1,030.53 MB`, 전수 선언 `1,061,425`개 · 무속성 기본 선언 `1,054,282`개, `leanprover/lean4:v4.33.1`, 공식 `mathlib4` `0df444a3`)

---

## 1. 패키지 구성 요약 (`Part A` 학술 단행본 + `Part B` 전수 수식 도감)

| 구분 | 디렉터리 / 산출물 | 수록 규모 (실측) | 설명 |
| :--- | :--- | :--- | :--- |
| **Part A 조판 단행본** | `book/알푀게_리만가설_신작증명_심층해독단행본_AB.pdf` (`.html`) | **A4 단행본 `133`쪽 PDF** (`19.22 MB`, 도판 `4`종 내장) | 신작 `422만 줄` 하부 허브 수식 복원, `Mathlib` 경계 의미론 감사, 기출 `201`임포트 동치성 판정, `152`쪽 인간 논문 청사진 |
| **Part A 마크다운 원고** | `part_a/A00` ~ `A06` (`7`개 권) | 총 **`5,618`줄** · 검증된 정확 경로 `.lean:line` 핀 **`1,870`개** (`오류 0건`) | 제0부 총괄 지도 ~ 제6부 단축 논문 청사진 및 전역 총색인 |
| **Part B 마크다운 도감** | `atlas/volumes/B00` ~ `B10` (`11`개 권) | 총 **`373,974`줄** · 고유 **`30,343`개 모듈** · **`308,731`개 선언** (`100.00%` 전수) | `Formalism`(`18,254`개) $\cup$ `Pure_Vwin`(`10,832`개) $\cup$ `PublishedTheorems`(`1,073`개) $\cup$ `201`임포트 무명 `instance`·`scoped`·`local` 포함 전수 시그니처·전술·피참조 차수 색인 |
| **Part B JSONL 원장** | `atlas/data/*.jsonl` (`4`종) + `atlas_summary.json` | `30,343`개 레코드 (`JSONL`) | 기계 질의·그래프 탐색용 무손실 AST 선언 및 의존성 데이터베이스 |
| **독립 기계 검증 스위트** | `proofs/alpoge_ab_deep_audit.lean` | **`1,143`줄** · 무-sorry 정리 **`44`개** (주 정리 `30` + 보조 `14`, 사용자 추가 공리 `0`건 · 표준 내장 공리 이하) | 외부 패키지 없이 순수 Lean 4 코어만으로 즉시 검증되는 핵심 산술·부등식·합동식 감사 코드 (`68`개 주석 원문 핀 전수 검증) |
| **빌드 · 검증 스크립트** | `scripts/` (`4`종) | Python 3 자동화 파이프라인 (`sys.dont_write_bytecode = True`) | `build_part_b_atlas.py`, `generate_ab_figures.py`, `build_ab_monograph.py`, `verify_ab_project.py` |

---

## 2. Part A 학술 단행본 권별 세부 목록 (`part_a/`)

1. **`A00_총괄서문_및_전체해부지도.md`** (`89`줄, 핀 `2`개): 4계층 검증 분리표, 신작 합집합(`29,067`개 파일, `300,415`개 선언) 정량 원장, 피참조 멱법칙 및 저비용 전술(`aesop` `0.0033%`) 해명.
2. **`A01_최상위봉인_Mathlib경계의미론_및_상단브리지감사.md`** (`925`줄, 핀 `391`개): `Main.lean`·`Statements.lean` 닫힌 명제 건전성, 메타프로그래밍 `8`종 전수 감사(`allowUnsafeReducibility` `33`개 고유 파일 `37`회 포함), 고정 `Mathlib` 제타($s=1$ 극점 나눗셈 값, $s=0$, 자명영점) 및 디리클레 $L$-함수($N=1$, 비원시 오일러 인자 $\operatorname{Re}(s)=0$) 원문 증명, 상단 `43`개 브리지 해부.
3. **`A02_기출201선_및_PublishedTheorems_의미론동치성감사.md`** (`1,184`줄, 핀 `417`개): `EveryCharacterOfLiteratureOfVWin.lean` 로컬 임포트 `201 / 201`개 전수 동치성 분류(유형 I `127`개, 유형 II-A `44`개, 유형 II-B `11`개, 조립·어댑터 `19`개) 및 `PublishedTheorems`(`1,073`개) 핵심 원문 수식 복원.
4. **`A03_Formalism_4대기둥_하부전술및핵심허브_심층복원.md`** (`1,207`줄, 핀 `315`개): `LocalToGlobal`(`95.6만 줄`), `SharpRestriction`(`70.9만 줄`), `HermitianCurvature`(`46.1만 줄`), `PeriodIntegrals`(`45.2만 줄`) 내부 최다 피참조 허브 직독 및 $\sigma = 2/3$ 분모 장벽 3중 상쇄 메커니즘 복원.
5. **`A04_Formalism_112개특수소이론_및_전역상수폐루프복원.md`** (`989`줄, 핀 `334`개): 피참조 1위 `RhoDetPrimeEqMuTildeMulChiPow.lean`(`in=921`) 외 `112`개 특수 소이론 6대 클러스터(`43,521`개 선언) 복원 및 `ShapeWin` $(C_{\mathrm{abs}}, C_0, e_D, e_L) = (2, 3, 2, 0)$ $\to$ `CoreGm`($1/2 + 9\varepsilon$) $\to$ `landauWindow` 비순환 양화사 폐루프 검증.
6. **`A05_PureVwin_반디버우회_베렌트타워_및_기계검증확장.md`** (`1,066`줄, 핀 `293`개): `Pure_Vwin`(`10,832`개 파일, `103만 줄`, `61,209`개 선언) 약화된 반디버 성질 양날개 패칭, `LiteratureRankNHypothesis`(`56`슬롯 = 문헌 `50` + 신작 `6`), 베렌트 이와사와 타워, 지수 임계치 `Ct = 401` 및 `44`개 Lean 감사 정리 해설.
7. **`A06_부록_인간단축논문_재구성청사진_및_전역참조총색인.md`** (`158`줄, 핀 `118`개): `152`쪽 인간 학술지 논문 장·절 매핑 설계도, 전역 상수·기호 사전, 최다 피참조 허브 Top 50, 감사 정리 `30`선 및 `8`대 번역 어댑터(`A1`~`A8`) 조견표.

---

## 3. 재현 및 무결성 검증 실행 명령

```bash
# 1. Part B 30,343개 모듈 · 308,731개 선언(100.00%) 전수 AST 도감 재생성
python3 -B scripts/build_part_b_atlas.py

# 2. 실측 도판 4종 재생성
python3 -B scripts/generate_ab_figures.py

# 3. Part A 단행본 HTML 및 A4 PDF 조판 빌드
python3 -B scripts/build_ab_monograph.py

# 4. 1,870+68개 .lean:line 핀 실존·범위 검사 + HTML 조판 감사 + 44개 Lean 정리 컴파일 검증
python3 -B scripts/verify_ab_project.py
```
