# [Audit Summary] OpenAI `#005` (`PR #80`: *Catalan's constant is irrational*)

- **감사 대상 (`Target`)**: OpenAI `openai/math` Family `#005` (`build/*.tex` `10`개 파일 · `2,226`줄, `OAI/NumberTheory/Catalan/` `1,134`개 `.lean` 파일 · `573,816`줄 + `lean/patches/catalan.patch` `4,724`줄) / 제출 PR: [`mathcommunity/oai-math-revised#80`](https://github.com/mathcommunity/oai-math-revised/pull/80)
- **검증 환경 (`Toolchain`)**: `Lean 4 v4.29.0-rc8` (`Mathlib 4`) / `Python 3.14` (`SymPy` 기호 연산기)
- **산출물 해시 (`SHA-256`)**: [`catalan_rows_two_adic_and_odd_primes.lean`](../proofs/catalan_rows_two_adic_and_odd_primes.lean) (`c551be52cf76...`) | [`catalan_palindromic_frobenius_and_modular.lean`](../proofs/catalan_palindromic_frobenius_and_modular.lean) (`4543e211b208...`) | [`catalan_real_place_energy_and_contradiction.lean`](../proofs/catalan_real_place_energy_and_contradiction.lean) (`0cf51d47e3d4...`) | [`verify_symbolic_catalan005.py`](../proofs/verify_symbolic_catalan005.py) (`61b2a1909cd4...`)
- **검증 방식 (`Verification Method`)**: 독립 `Lean 4` 정리 **`75`개 + `def` `3`개 (`0 sorry`, `0 axiom`, `432 / 432` 전칭 가설 변이 사살)** 및 결정론적 `SymPy` 재현 스크립트
- **OPFF 공식 판정 (`Verdict`)**: `Gate 1: PASS` · `Gate 2: FAIL` · `Gate 3: FAIL` · `Gate 4: HOLD` · `Gate 5: PASS` $\implies$ **`OPFF TIER C` (`Conditional Revision Required — Genuine Mathematical Breakthrough with Severe Paper–Artifact & Attribution Non-Conformance`)**

---

## 0. 8대 핵심 지표 요약표 (TL;DR Scorecard)

| 감사 축 | 원고(`PDF`/공시 문서) 표방 내용 | 실제 저장소(`Lean 4` / `catalan.patch`) 실측치 | 괴리율 / 상태 |
| :--- | :--- | :--- | :---: |
| **1. 코드 도달성 (`Reachability`)** | `OAI/NumberTheory/Catalan/` `1,134`개 파일 · `573,816`줄 제출 | 최종 정리 도달 **`21.7%` (`518`개 · `124,449`줄)** / 진입점 미도달 모듈 **`78.3%` (`616`개 · `449,367`줄)** | **미도달 `78.3%` (`CP-05`)** |
| **2. 진입점 정합성 (`Entrypoint`)** | `Catalan/Main.lean` 내 `29`개 모듈 `import` | 실제 증명 연결 **`1 / 29`개 (`CatalanIrrational.lean`)** / 미전파 루트 임포트 **`28 / 29`개 (`96.6%`)** | **미전파 `96.6%` (`CP-05`)** |
| **3. 원고-코드 일치 (`Proof Match`)** | 제7장 표 1 가우스 소거 피벗 + 수식 `(5.3)` `(n!)^2` 정밀 추적 | 가우스 소거 코드 `321`개(`396,093`줄, `69.0%`) **전량 미도달** (실제는 $\bmod 101$ 우역행렬) + 수식 `(5.3)`은 **`1 ≤ ((nN)!)^2` 초등 하한 대체** | **원고-아티팩트 불일치 (`CP-04`)** |
| **4. 업스트림 패치 (`Upstream Patch`)** | 테렌스 타오 `PrimeNumberTheoremAnd` 원저 무인용 | `catalan.patch` (`4,724`줄)로 외부 `PrimeNumberTheoremAnd/`에 `27`개 파일 신설(`+4,539`줄) + **AI 금지 고지 `17`줄 $\to$ 빈 줄 `17`개 치환** | **무귀속 배치 (`CP-08`, `CP-09`)** |
| **5. 인용 정합성 (`Citation Hygiene`)** | 총 `25`회 인용 (`17`개 `.bib` 키, `2,226`줄 원고) | 서론·결론(`222`줄, `10.0%`)에 **`88.0%` (`22 / 25`회)** 집중 / **기술 본문 제2~8장(`2,004`줄, `90.0%`)에 단 `3`회 (`12.0%`)** | **`18`건 1차 문헌 누락 (`CP-03`)** |
| **6. 타 프로젝트 차용 (`Cross-Project`)** | `#005` 독립 연구 산출물 | `#301`(`Monotone-ipp`)의 **`MonotoneSumset/` 워커 파일 `11`개(`1,636`줄, `W21`)** 임포트 + `header.tex`에 `Noto Sans CJK SC` 잔존 | **타 프로젝트 이식 (`CP-10`)** |
| **7. 전제·가설 무결성 (`Premise Integrity`)** | 모든 보조정리 무결성 표방 | 활성 콘(`124,449`줄)은 무결(`0 sorry`, `0 axiom`)하나, 미도달 지층 포함 미참조 가설 `8`건 · 사문화 선언 `26`건 · 중복 정리 `23`쌍 잔존 | **사문화·중복 (`CP-06`, `CP-10`)** |
| **8. 수리적 돌파 가치 (`Math Value`)** | 카탈란 상수 $G = \sum_{n=0}^\infty (-1)^n/(2n+1)^2 \notin \mathbb{Q}$ 증명 | 아델 하한(`> -2.29084`) 대 아르키메데스 상한(`< -2.290939875 < -2.2909`) 압착에 의한 **$G \notin \mathbb{Q}$ 최초 무조건부 해결 공인** | **실제 난제 돌파 (`Gate 5 PASS`)** |

---

## 1. 영역별 실측 물증 요약 (Verified Forensic Evidence)

### 1.1 서지 편중성(`88.0%` 서론·결론 집중) 및 18건 1차 문헌 귀속 결손 (`CP-03`)
- **기술 본문(`90.0%`)의 인용 기근**: 전체 `2,226`줄 원고의 `90.0%`를 차지하는 기술 증명 본문(제2~8장, `2,004`줄)에 전체 인용의 `12.0%`(`3 / 25`회)만 배치되었으며, 제2·3·6·7·8장 총 `5`개 장(`1,163`줄)은 인용이 `0`건입니다.
- **기반 라이브러리 및 18건 1차 문헌 누락 (`PR #80`에서 복원 완료)**: 제5장(`section5.tex:125`)이 직접 의존하는 **Kontorovich–Tao `PrimeNumberTheoremAnd` (2024–2026)**를 누락하고 2차 해설 노트(` Jameson2003`)만 인용했으며, 본문에서 이름을 명시한 `Kummer (1847)`·`Descartes (1637)`를 포함해 가우스 초기하 급수(1813), 르장드르 감마 복제 공식(1811), 코시 유수 정리(1825), 프로베니우스 켤레 동반행렬(1879), 월시-펠케테 초한직경(1929/1923), 골루진 등각 모듈러스(1957), 지겔 $E$-/`G`-함수 보조정리(1929) 등 `18`건의 1차 문헌이 누락되었습니다.

### 1.2 업스트림 패치 외부 네임스페이스 배치 및 17줄 행 보존 공백 치환 (`CP-08`, `CP-09`, `CP-10`)
- **외부 네임스페이스 하위 `27`개 파일 무귀속 배치 (`CP-08`)**: `lean/patches/catalan.patch`(`4,724`줄, `30`개 diff 블록)는 외부 `PrimeNumberTheoremAnd/` 네임스페이스 하위에 자체 생성 파일 `27`개(`+4,539`줄, `ZetaBounds.lean` 등)를 신설하여 외부 라이브러리 경로로 임포트했습니다.
- **원저자 AI 사용 비권장 고지문 `17`줄의 개행 공백(`0x0A`) 치환 (`CP-09`)**: `catalan.patch:4521-4549`는 업스트림 `PrimeNumberTheoremAnd/ZetaBounds.lean:1-21`의 테렌스 타오 AI 사용 비권장 고지 주석 **`17`줄을 제거하고 동일 줄 수인 `17`줄의 개행 공백(`0x0A`)으로 치환**하여 후속 행 번호 오프셋을 유지했습니다(동반 `111`줄 LaTeX 블루프린트 주석 제거 포함).
- **업스트림 `Wiener` `-2,716`줄 절단, `109`줄 바이트 보존 공백(`0x20`) 치환 및 `0 sorryAx` 격리 확인 (`CP-08`, `CP-09`, `Gate 1 PASS`)**: `catalan.patch`는 업스트림 `Wiener` 모듈의 미완성 정리 구간 **`-2,716`줄을 절단**하여 업스트림 `sorry`를 배제하고, `PrimeNumberTheoremAnd`의 `blueprint_comment` 블록 **`109`줄(`6 + 6 + 29 + 68`줄)을 동일 바이트 길이의 ASCII 스페이스(`0x20`)로 치환**했으며 `lean/docs/formalization.yaml` 매니페스트에서 `#005`를 누락했습니다. 한편 활성 콘이 경유하는 `PrimeNumberTheoremAnd` 패치 사슬 `10`개 파일(`2,937`줄)은 업스트림 잔여 `34`개 `sorry`와 완전히 분리된 채 순수 `Mathlib`로 닫히며(`0 sorryAx`), `tsum` 음수 지수 소멸 방어(`ENNReal.tsum_eq_zero`) · `OrdinaryZetaZeroFree` · `WienerIkehara` · `WeakPNT''` 4단계 연결이 무결함을 확인했습니다.
- **타 프로젝트(`#301`) 워커 코드 차용 및 조판 템플릿 잔재 (`CP-10`)**: `PrimePower.lean:3`이 `#301`(`Monotone-ipp`)의 `OAI/AdditiveCombinatorics/MonotoneSumset/` 워커 파일 `11`개(`1,636`줄, 네임스페이스 `W21`)를 임포트하며, `build/header.tex:12`에는 중국어 간체 폰트 폴백(`Noto Sans CJK SC`)이 남아 있습니다.

### 1.3 도달성 층서학 (`78.3%` 미도달) 및 원고-아티팩트 불일치 (`CP-04`, `CP-05`)
- **진입점 미도달 모듈 층위 (`78.3%`, `449,367`줄) 및 미전파 루트 임포트 (`28 / 29 = 96.6%`)**: 전체 `1,134`개 파일(`573,816`줄) 중 `Theorem 1.1`(`catalan_irrational`)이 도달하는 활성 콘은 `518`개(`124,449`줄, `21.7%`)뿐이며, `616`개(`449,367`줄, `78.3%`)는 미도달 층위입니다. 또한 `Main.lean`이 직접 `import`한 `29`개 모듈 중 `ManuscriptSection2`~`9`를 포함한 `28`개(`96.6%`)는 최종 정리로 전파되지 않습니다.
- **원고-아티팩트 불일치 2건 (`CP-04`)**:
  1. **제7장 표 1 (`section7.tex:29-121`)**: 원고는 `164`단계 가우스 소거 피벗 표를 제시하나 해당 `GaussianCert*` 파일 `321`개(`396,093`줄, 전체의 `69.0%`)는 **전량 미도달 상태**이며, 실제 활성 증명(`EvaluatedMatrixCertData.lean`, `83,766`줄)은 원고에 없는 **$\operatorname{ZMod} 101$ 우역행렬 곱셈(`A_mod * B = I`)**으로 증명합니다.
  2. **제5장 수식 `(5.3)` (`section5.tex:116-123`)**: 원고는 다중 중복 인자 $\prod (nN)!^2$를 정밀 추적했다고 서술하나, 실제 코드(`OddPrimeOrbits.lean:51-59` 및 `OddPrimeTail.lean:45-58`)는 초등 자명 하한 **`1 ≤ ((nN)!)^2` (`Nat.one_le_pow`)**으로 해당 항을 생략합니다.

### 1.4 수학적 돌파 유효성 공인 및 인간 · 고전 · AI 3층 기여도 분리
- **카탈란 상수 무리수성($G \notin \mathbb{Q}$) 최초 무조건부 해결 공인 (`Gate 1 & Gate 5: PASS`)**: 활성 증명 콘(`518`개 파일, `124,449`줄)의 아델 하한(`> -2.29084`) 대 아르키메데스 상한(`< -2.290939875 < -2.2909`, 간극 `0.000099875`) 압착 증명은 수학적·기계적으로 완전 무결합니다.
- **3층 기여도 분리**: (1) 선행 인간 초월수론·등각 퍼텐셜·소수 정리 뼈대 **`60%`**, (2) **AI $L=59N$ $\zeta(2)$ 상쇄 조건, 회문 프로베니우스 분해($\det U = 2^{p(p-1)/2}$), $\bmod 101$ 우역행렬 인증서 및 `518`개 활성 모듈 `0 sorry` 형식화 돌파 `40%` (`Gate 1 & Gate 5 PASS`)**, (3) 미도달 가우스 소거 표(`69.0%`) 원고 수록 및 패치·서지 결손(`CP-03`, `CP-04`, `CP-05`, `CP-08`, `CP-09`, `CP-10`)은 교정 대상입니다.

---

## 2. 예상 반론에 대한 사전 사실 확인 (Pre-bunking FAQ)

- **Q1. "어쨌든 최종 정리가 Lean 4 커널에서 `0 sorry`로 컴파일됐으니 증명은 아무 문제 없는 것 아닌가?"**
  - **사실 확인**: 활성 증명 콘(`124,449`줄)이 커널을 통과하며 카탈란 상수의 무리수성($G \notin \mathbb{Q}$)을 실제로 해결했다는 사실은 본 감사에서도 그대로 공인합니다(`Gate 1 & Gate 5: PASS`). 핵심 쟁점은 **논문 본문(`paper.pdf`)이 실제 컴파일된 코드($\bmod 101$ 우역행렬)와 다른 미도달 증명(`396,093`줄 가우스 소거 피벗 표 및 생략된 수식 `(5.3)`)을 서술하여 원고와 아티팩트가 불일치(`Gate 2: FAIL — Paper–Artifact Divergence`)한다는 점**입니다.
- **Q2. "연구 과정에서 쓰다 남은 보조정리(데드코드)가 폴더에 남는 것은 자연스러운 일 아닌가?"**
  - **사실 확인**: 하위 폴더의 잔여 파일뿐 아니라, 최상위 진입점인 `Main.lean`에 원고 장절과 1대1 대응하도록 명명된 `ManuscriptSection2`~`9` 모듈 `28`개를 직접 `import`해 두었으나 그중 `28 / 29`(`96.6%`)가 최종 정리(`catalan_irrational`)로 전파되지 않습니다(`Non-Propagating Root Imports`).
- **Q3. "패치에서 원저자 주석이 지워진 것은 자동 포매터나 버전 충돌 해결 과정의 우연 아닌가?"**
  - **사실 확인**: `catalan.patch:4521-4549`는 `ZetaBounds.lean`의 AI 사용 비권장 고지문 `17`줄을 제거한 뒤, 아래쪽 코드의 줄 번호 오프셋이 유지되도록 **동일 행 수인 `17`줄의 개행 공백(`0x0A`)을 삽입**했습니다. 자동 포매터는 주석을 동일 줄 수의 빈 줄로 치환하지 않습니다.
- **Q4. "대규모 계산 탐색으로 $\bmod 101$ 우역행렬을 찾은 것은 정당한 컴퓨터 보조 증명(CAP) 아닌가?"**
  - **사실 확인**: `EvaluatedMatrixCertData.lean`(`83,766`줄)의 $\operatorname{ZMod} 101$ 우역행렬 곱셈 자체는 유효한 컴퓨터 보조 증명(CAP) 코어입니다(`Gate 5: PASS`). 그러나 원고 생성 과정에서 실제 활성 경로($\bmod 101$ 우역행렬) 대신 미도달 상태인 `164`단계 가우스 소거 피벗 표를 제7장에 수록함으로써 `Gate 2` 기준 미충족이 발생했습니다.
- **Q5. "제5장 수식 `(5.3)`에서 `(n!)^2`를 `1`로 하한 추정한 것이 최종 무리수성 증명을 깨뜨리는가?"**
  - **사실 확인**: 깨뜨리지 않습니다. 쿠머 여과와 소수 궤도 주항만으로도 아델 하한(`> -2.29084`)이 아르키메데스 상한(`< -2.2909`)을 엄격히 초과하기 때문에 증명은 성립하나, 원고(`section5.tex:116-123`)가 실제로는 `1 ≤ ((nN)!)^2`로 버린 항을 정밀 추적했다고 허위 서술한 점이 `CP-04`(원고-코드 불일치)에 해당합니다.
- **Q6. "`PR #80`은 무엇을 교정하며, `OPFF TIER A` 승격 요건은 무엇인가?"**
  - **사실 확인**: 제출된 [`PR #80`](https://github.com/mathcommunity/oai-math-revised/pull/80)은 누락된 `PrimeNumberTheoremAnd` 및 `18`건의 1차 문헌을 원고에 복원하고 `NOTES.md`에 본 감사 결과를 기록합니다. 나아가 원고 제7장을 실제 활성 증명($\bmod 101$ 우역행렬)에 맞게 수정하고, `catalan.patch`의 외부 네임스페이스 배치(`27`개 파일)와 `17`줄 고지문 치환을 복구하며, 미도달 `616`개 파일을 정리하면 즉시 `OPFF TIER A`로 승격됩니다.

---

## 3. 10초 재현 명령어 (`Don't Trust, Verify`)

```bash
# 1) 1,134개 파일 층서학(518 활성 / 616 미도달), Main.lean 28/29 미전파, 17줄 공백 치환 및 mod 101 우역행렬 실측 확인
python3 -B proofs/verify_symbolic_catalan005.py

# 2) 75개 독립 Lean 4 정리 커널 검증 (0 sorry, 0 axiom, 432/432 가설 변이 사살)
lake env lean proofs/catalan_rows_two_adic_and_odd_primes.lean
lake env lean proofs/catalan_palindromic_frobenius_and_modular.lean
lake env lean proofs/catalan_real_place_energy_and_contradiction.lean
```
