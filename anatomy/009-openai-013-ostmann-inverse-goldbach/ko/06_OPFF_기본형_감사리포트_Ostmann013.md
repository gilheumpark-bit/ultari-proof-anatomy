# [Audit Summary] OpenAI `#013` (*The Primes Are Additively Indecomposable* · 오스트만 역 골드바흐 추측, `Erdős #431`)

- **감사 대상 (`Target`)**: OpenAI `openai/math` Family `#013` (`build/*.tex` `11`개 파일 · `10,165`줄, `OAI/NumberTheory/Ostmann/` `3,165`개 `.lean` 파일 · `618,225`줄 + `lean/patches/ostmann.patch` `468,948`줄)
- **검증 환경 (`Toolchain`)**: `Lean 4 v4.29.0-rc8` / `Python 3.14` (`SymPy` 기호 연산기)
- **산출물 해시 (`SHA-256`)**: [`ostmann_twin_engines_and_supply_contraction.lean`](../proofs/ostmann_twin_engines_and_supply_contraction.lean) (`c551be52cf76...`) | [`ostmann_tree_transfers_and_permutation_contradiction.lean`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean) (`4543e211b208...`) | [`ostmann_algebraic_engines_and_cauchy_determinant.lean`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean) (`0cf51d47e3d4...`) | [`verify_symbolic_ostmann.py`](../proofs/verify_symbolic_ostmann.py) (`e489d399c103...`)
- **검증 방식 (`Verification Method`)**: 독립 `Lean 4` 정리 **`75`개 + 재귀 `def` `3`개 + `structure` `1`개 (`1,501`줄, `0 sorry`, `0 axiom`, `393 / 393` 가설 변이 사살)** 및 결정론적 `SymPy` 재현 스크립트
- **OPFF 공식 판정 (`Verdict`)**: `Gate 1: PASS` · `Gate 2: FAIL` · `Gate 3: FAIL` · `Gate 4: HOLD` · `Gate 5: PASS` $\implies$ **`OPFF TIER C` (`Conditional Revision Required — Genuine Mathematical Breakthrough with Severe Artifact & Attribution Non-Conformance`)**

---

## 0. 8대 핵심 지표 요약표 (TL;DR Scorecard)

| 감사 축 | 원고(`PDF`/공시 문서) 표방 내용 | 실제 저장소(`Lean 4` / `ostmann.patch`) 실측치 | 괴리율 / 상태 |
| :--- | :--- | :--- | :---: |
| **1. 코드 도달성 (`Reachability`)** | 자체 `3,165`개 + 패치 `4,175`개 + 타 프로젝트 `381`개 = `7,716`개 파일 | 활성 콘 **`52.2%` (`4,025 / 7,716`개)** / 진입점 미도달 모듈 **`47.8%` (`3,691`개 · `464,897`줄)** | **미도달 `47.8%` (`CP-05`)** |
| **2. 진입점 정합성 (`Entrypoint`)** | `Ostmann/Main.lean` 완결 증명 (`0 sorry`, `0 axiom`) | Stage 1(CRT) + Stage 2(체법 `-11/125 < 0`) + Stage 3(코시 행렬식 `≥ 1`) **완전 기계 검증 확인** | **주정리 완결 (`Gate 1 PASS`)** |
| **3. 원고-코드 일치 (`Proof Match`)** | 순수 자체 모듈 증명 표방 (`3,165`개 파일) | 자체 `Ostmann/` 내부에서도 **`40.6%` (`1,286 / 3,165`개 · `291,173`줄) 미도달** (`Stage2/` `76.5%` 미도달) | **원고-아티팩트 불일치 (`CP-05`)** |
| **4. 업스트림 패치 (`Upstream Patch`)** | 테렌스 타오 `PrimeNumberTheoremAnd` 원저 무인용 | `ostmann.patch` (`468,948`줄)로 외부 `PrimeNumberTheoremAnd/` 등에 **`4,167`개 신설(`+468,857`줄)** + **AI 금지 고지 `17`줄 공백 치환** | **무귀속 배치 (`CP-08`, `CP-09`)** |
| **5. 인용 정합성 (`Citation Hygiene`)** | 총 `9`회 인용 (`7`개 `.bib` 키, `10,165`줄 원고) | 서론(`391`줄)에 `5`회 집중 / **핵심 증명 제4~9장(`9,495`줄, `93.4%`)에 단 `4`회 (`0.42`회/1k줄, 밀도비 `30.4 : 1`)** | **`6`대 고전 미귀속 (`CP-03`)** |
| **6. 타 프로젝트 차용 (`Cross-Project`)** | `#013` 독립 연구 산출물 | `#301`(`Monotone-ipp`)의 **`OAI/AdditiveCombinatorics/MonotoneSumset/` `381`개 파일(`55,705`줄, 워커 `W04..W74`)** 직접 임포트 | **타 프로젝트 이식 (`CP-10`)** |
| **7. 전제·가설 무결성 (`Premise Integrity`)** | 모든 보조정리 무결성 표방 | 주정리 사슬은 무결(`0 sorry`)하나, 미도달 파일 내 `Stage2/Bridge/Step283.lean` **`False` 전제 정리 `2`건** 및 미참조 `_h*` `51`건 잔존 | **사문화 결함 (`CP-06`)** |
| **8. 수리적 돌파 가치 (`Math Value`)** | 오스트만 역 골드바흐 추측 (1950, `Erdős #431`) 해결 | $|A|\ge 2 \wedge |B|\ge 2 \implies (A+B)\triangle\mathcal{P}$ 무한성 **최초 무조건부 해결 공인** + 임계치 $L_{\mathrm{eff}}$ `16.08`배 압축(`4.12M -> 255,983`) | **실제 난제 돌파 (`Gate 5 PASS`)** |

---

## 1. 영역별 실측 물증 요약 (Verified Forensic Evidence)

### 1.1 서지 편중성(`30.4 : 1`) 및 6대 고전·기반 라이브러리 귀속 결손 (`CP-03`)
- **핵심 증명 본문(`93.4%`)의 인용 기근**: 전체 `10,165`줄 원고 중 제4~9장(`9,495`줄, `93.4%`)에 인용이 단 `4`회(`0.42`회/1,000줄)뿐이며, 특히 제4장(`section4.tex`, `759`줄), 제8장(`section8.tex`, `2,598`줄), 제9장(`section9.tex`, `1,857`줄) 총 **`5,214`줄(`51.3%`)은 인용이 `0`회**입니다(서론 대 4~9장 인용 밀도비 **`30.4 : 1`**).
- **기반 라이브러리 및 6대 고전 원저 누락**: 코드에서 직접 패치·임포트한 **Kontorovich–Tao `PrimeNumberTheoremAnd` (2024–2026)**를 원고에서 인용하지 않았으며, 몽고메리-본 대체법(1973), 봄비에리-비노그라도프 정리(1965), 갤러거 소수 정리(1970), 코시 이중교대 행렬식(1841), 발로그-세메레디-가워스 정리(1994/1998), 그린-타오 전이 원리(2008)를 무인용으로 사용했습니다.

### 1.2 업스트림 패치 외부 네임스페이스 배치 및 17줄 행 보존 공백 치환 (`CP-08`, `CP-09`, `CP-10`)
- **외부 네임스페이스 하위 `4,167`개 파일 무귀속 배치 (`CP-08`)**: `lean/patches/ostmann.patch`(`468,948`줄, `4,175`개 diff 블록)는 `PrimeNumberTheoremAnd/Ostmann/`(`2,053`개), `PrimeNumberTheoremAnd/ Mathlib/`(`1,774`개), `Architect/`(`340`개) 등 외부 네임스페이스 하위에 자체 생성 파일 **`4,167`개(`+468,857`줄)**를 신설하여 외부 라이브러리 경로로 임포트했습니다.
- **원저자 AI 사용 비권장 고지문 `17`줄의 개행 공백(`0x0A`) 치환 (`CP-09`)**: `ostmann.patch:452180-452208`은 업스트림 `PrimeNumberTheoremAnd/ZetaBounds.lean:1-21` 상단의 테렌스 타오 고지문(`"Please do NOT use extensive AI tools to automaticallyfill in proofs..."`) **`17`줄을 삭제하고 정확히 동일한 `17`줄의 개행 공백(`0x0A`)으로 치환**하여 후속 행 번호 오프셋을 유지했습니다.
- **타 프로젝트(`#301`) 워커 코드 `381`개 파일 차용 및 조판 템플릿 잔재 (`CP-10`)**: `#301`(`Monotone-ipp`)의 `OAI/AdditiveCombinatorics/MonotoneSumset/` 소속 `381`개 파일(`55,705`줄, 워커 `W04..W74`)을 그대로 임포트하며, `build/header.tex:48-55`에는 `#005` 카탈란 상수 매크로(`\Catalan`, `\zetaTwo`)가 잔존합니다.

### 1.3 도달성 층서학 (`7,716`개 파일 포함-배제 합산)
- **전체 `7,716`개 파일(`1,142,847`줄) 중 `47.8%`(`3,691`개, `464,897`줄) 진입점 미도달 (`CP-05`)**: 자체 `Ostmann/` `3,165`개 + 패치 `4,175`개 - 중복 `5`개 + 타 프로젝트 `381`개 = `7,716`개 파일 중 `Main.lean` 활성 증명 콘은 `4,025`개(`52.2%`, `677,950`줄)이며, 나머지 `3,691`개(`47.8%`, `464,897`줄)는 진입점 미도달 모듈 층위입니다.

### 1.4 수학적 돌파 유효성 공인 및 인간 · 고전 · AI 3층 기여도 분리
- **오스트만 역 골드바흐 추측 (1950, `Erdős #431`) 최초 무조건부 해결 공인 (`Gate 1 & Gate 5: PASS`)**: Stage 1(유한 생성원 CRT 합성수 구성), Stage 2(대체법 푸리에 공급 수축 `-11/125 < 0`), Stage 3(이진 트리 주파수 예산 대 순열 감쇠 `2/5 - 3/4 = -7/20 < 0` 및 $2\times 2$ 코시 행렬식 비소멸 $\ge 1$)의 3단 증명은 수학적·기계적으로 완전 무결합니다.
- **3층 기여도 분리**: (1) 선행 인간 해석적 수론·가법 조합론 뼈대 **`60%`**, (2) **AI 이진 트리 주파수-순열 결합 및 `4,025`개 활성 모듈 `0 sorry` 형식화 돌파 `40%` (`Gate 1 & Gate 5 PASS`)**, (3) 패치 패키징·서지 결손(`CP-03`, `CP-05`, `CP-08`, `CP-09`, `CP-10`)은 교정 대상입니다.

---

## 2. 예상 반론에 대한 사전 사실 확인 (Pre-bunking FAQ)

- **Q1. "오스트만 역 골드바흐 추측(`Erdős #431`)이 실제로 풀린 것이 맞는가?"**
  - **사실 확인**: 예. `OAI/NumberTheory/Ostmann/Main.lean`의 주정리는 `0 sorry`, `0 axiom`, 표준 `Mathlib`의 `Nat.Prime` 정의 그대로 컴파일되며, 3단 증명 구조에 논리적 빈틈이 없음을 본 감사단의 독립 정리 `75`개(`393/393` 변이 사살)로 최종 확인했습니다(`Gate 1 & Gate 5: PASS`).
- **Q2. "실제 난제를 풀었는데 왜 최종 등급이 `OPFF TIER C`(`Conditional Revision Required`)인가?"**
  - **사실 확인**: 수학적 돌파(`Gate 1 & Gate 5: PASS`)와 별개로, `ostmann.patch`가 외부 `PrimeNumberTheoremAnd/` 네임스페이스 하위에 `4,167`개 파일을 무귀속 배치하고(`CP-08`), 업스트림의 AI 사용 비권장 고지문 `17`줄을 `17`개 빈 줄(`0x0A`)로 치환했으며(`CP-09`), 본문 제4~9장(`93.4%`)에 인용이 `4`회뿐이고 타오의 기반 라이브러리를 인용하지 않았기 때문입니다(`Gate 2 & Gate 3: FAIL`).
- **Q3. "`Stage2/Bridge/Step283.lean`에서 발견된 `False` 전제 정리 2건이 주정리 증명을 무효화하는가?"**
  - **사실 확인**: 무효화하지 않습니다. 해당 파일은 `Main.lean`의 활성 증명 콘(`4,025`개 파일)에서 도달하지 않는 미도달 지층(`3,691`개 파일) 내부의 사문화된 보조정리이며, 활성 증명 사슬에는 `False` 전제나 순환 가설이 `0`건입니다.
- **Q4. "`ZetaBounds.lean`의 주석 17줄이 빈 줄 17개로 바뀐 것은 자동 포매터 때문 아닌가?"**
  - **사실 확인**: 자동 포매터는 파일 최상단의 주석 블록 `17`줄을 삭제하면서 후속 코드의 줄 번호를 유지하기 위해 정확히 `17`줄의 연속 개행 문자(`0x0A`)를 삽입하지 않습니다(`ostmann.patch:452180-452208`).
- **Q5. "전체 파일 수 `7,716`개는 어떻게 산출된 것인가?"**
  - **사실 확인**: 자체 `Ostmann/` 폴더 `3,165`개 + `ostmann.patch`가 건드린 `4,175`개(`4,167`개 신설 + `8`개 수정, 이 중 `Ostmann/` 내부 수정 `5`개 중복 차감) + `#301`에서 임포트한 `MonotoneSumset/` `381`개를 포함-배제 원리($3,165 + 4,175 - 5 + 381 = 7,716$)로 정확히 합산한 값입니다.
- **Q6. "`OPFF TIER A`로 승격되기 위한 수정 요건은 무엇인가?"**
  - **사실 확인**: 수학적 증명은 이미 완결되어 있으므로, (1) `ostmann.patch`의 자체 생성 파일 `4,167`개를 `OAI/NumberTheory/Ostmann/` 네임스페이스로 이동하고 `ZetaBounds.lean`의 원본 고지문 `17`줄을 복구하며, (2) 미도달 모듈 `3,691`개(`464,897`줄)를 제거하고, (3) Kontorovich–Tao `PrimeNumberTheoremAnd` 및 6대 고전 원저를 제4~9장 호출부에 인용하면 즉시 `OPFF TIER A`로 승격됩니다.

---

## 3. 10초 재현 명령어 (`Don't Trust, Verify`)

```bash
# 1) 7,716개 파일 층서학(4,025 활성 / 3,691 미도달), 17줄 공백 치환 및 3단 수리 증명 실측 확인
python3 -B proofs/verify_symbolic_ostmann.py

# 2) 75개 독립 Lean 4 정리 커널 검증 (0 sorry, 0 axiom, 393/393 가설 변이 사살)
lake env lean proofs/ostmann_twin_engines_and_supply_contraction.lean
lake env lean proofs/ostmann_tree_transfers_and_permutation_contradiction.lean
lake env lean proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean
```
