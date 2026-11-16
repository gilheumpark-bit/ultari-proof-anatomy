# [Audit Summary] OpenAI `#266` (*Mutually Unbiased Bases in Dimension Six*)

- **감사 대상 (`Target`)**: OpenAI `openai/math` Family `#266` (`build/*.tex` `10`개 파일 · `1,449`줄, `OAI/QuantumInfo/MUB6/` `1,000`개 `.lean` 파일 · `614,193`줄 + `lean/patches/mub6.patch` `113`줄)
- **검증 환경 (`Toolchain`)**: `Lean 4 v4.29.0-rc8` (`Mathlib 4`) / `Python 3.14` (`SymPy` 기호 연산기)
- **산출물 해시 (`SHA-256`)**: [`mub6_hadamard_fourier_and_cubic_fibers.lean`](../proofs/mub6_hadamard_fourier_and_cubic_fibers.lean) (`c551be52cf76...`) | [`mub6_weiner_completion_and_gram_sos.lean`](../proofs/mub6_weiner_completion_and_gram_sos.lean) (`4543e211b208...`) | [`mub6_stratigraphy_and_binary64_audit.lean`](../proofs/mub6_stratigraphy_and_binary64_audit.lean) (`0cf51d47e3d4...`) | [`verify_symbolic_mub266.py`](../proofs/verify_symbolic_mub266.py) (`e489d399c103...`)
- **검증 방식 (`Verification Method`)**: 독립 `Lean 4` 정리 **`75`개 + `def` `5`개 (`1,249`줄, `0 sorry`, `0 axiom`, `358 / 358` 전칭 가설 변이 사살)** 및 `oai_ref/` `69`개 파일 실시간 파서 검증
- **OPFF 공식 판정 (`Verdict`)**: `Gate 1: FAIL` · `Gate 2: FAIL` · `Gate 3: FAIL` · `Gate 4: HOLD` · `Gate 5: PASS` $\implies$ **`OPFF TIER D` (`Major Revision & Scope Downgrade to Conditional Theorem Required`)**

---

## 0. 8대 핵심 지표 요약표 (TL;DR Scorecard)

| 감사 축 | 원고(`PDF`/공시 문서) 표방 내용 | 실제 저장소(`Lean 4` / `mub6.patch`) 실측치 | 괴리율 / 상태 |
| :--- | :--- | :--- | :---: |
| **1. 코드 도달성 (`Reachability`)** | `OAI/QuantumInfo/MUB6/` `1,000`개 파일 · `614,193`줄 제출 | 최종 정리 도달 **`55.5%` (`555`개 · `388,430`줄)** / 진입점 미도달 모듈 **`44.5%` (`445`개 · `225,763`줄)** | **미도달 `44.5%` (`CP-05`)** |
| **2. 진입점 정합성 (`Entrypoint`)** | `Main.lean` 무조건부(`Unconditional`) 6차원 MUB 부재 증명 | `Main.lean`이 미인스턴스화 가설 번들 **`h : ¬ Nonempty FourMUBInDim6` 또는 `SevenPointExclusionData`를 전제로 요구** | **미해소 전제 (`CP-02`)** |
| **3. 원고-코드 일치 (`Proof Match`)** | 제4~7장 부츠온 원뿔 · 솔로시 곡면 · 쿠머 강하 무조건부 결합 | 원고 제5~6장 대응 모듈 다수가 `Main.lean`과 단절되고, 활성 사슬은 **`3`개 미연결 전제(스투르름 근 개수 · 그뢰브너 정규형 · 사영 소거)**에 의존 | **원고-아티팩트 불일치 (`CP-04`)** |
| **4. 업스트림 패치 (`Upstream Patch`)** | `lean/patches/mub6.patch` (`113`줄) | 보조 대수 보조정리 패치(`113`줄), 외부 권위자 고지문 삭제 없음 | **패치 경미 (`PASS`)** |
| **5. 인용 정합성 (`Citation Hygiene`)** | 총 `26`회 인용 (`18`개 `.bib` 키, `1,449`줄 원고) | 서론(`192`줄, `13.3%`)에 **`76.9%` (`20 / 26`회)** 집중 / **기술 본문 제2~8장(`1,257`줄, `86.7%`)에 단 `6`회 (`23.1%`, 제5·6·7장 `0`회)** | **`12`대 고전 미귀속 (`CP-03`)** |
| **6. 생성 이력 (`Provenance`)** | 자율 추론 및 형식화 | 추론 로그 PDF **`0`편(미제공)** · `445`개 미도달 모듈(`225,763`줄) 및 병렬 워커 지층 잔존 | **이력 미제공 (`CP-07`)** |
| **7. 전제·가설 무결성 (`Premise Integrity`)** | 모든 보조정리 완결 표방 (`0 sorry`) | 미해소 상류 전제 **`3`건**(`Sturm`, `Gröbner`, `Resultant`) + 미참조 `_h*` 바인더 **`29`건** + 구성적 증인 없는 번들 | **전제 미봉합 (`CP-02`, `CP-06`)** |
| **8. 유효 수리 코어 (`Verified Core`)** | 아다마르 분류 · 솔로시 매개변수화 · SOS 인증서 | $6\times 6$ 복소 아다마르 결손 공간($d=4$), 솔로시 2차 곡면 항등식 및 유리수 SOS 다항식 인증서 **`388,430`줄 자체는 유효** | **`Gate 5: PASS`** |

---

## 1. 영역별 실측 물증 요약 (Verified Forensic Evidence)

### 1.1 서지 편중성(`76.9%` 서론 집중) 및 12대 고전 원저 귀속 결손 (`CP-03`)
- **핵심 증명 본문(`86.7%`)의 인용 기근**: 전체 `1,449`줄 원고 중 서론(`192`줄, `13.3%`)에 인용의 `76.9%`(`20 / 26`회)가 집중된 반면, 제2~8장(`1,257`줄, `86.7%`)에는 `6`회(`23.1%`)만 배치되었고, **제5장(쿠머 강하), 제6장(그뢰브너·종결식 소거), 제7장(스투르름 근 분리 및 SOS 인증서)은 인용이 `0`회**입니다.
- **미귀속 12대 1차 고전 문헌**: 하거업-타데세 아다마르 분류(Haagerup 1997; Taddei 2006), 부츠온 결손 원뿔(Butson 1962; Karlsson 2011), 솔로시 복원 공식(Szöllősi 2010/2012), 부흐베르거 그뢰브너 기저(1965), 스투르름 실근 정리(1835), 파릴로 SOS 반정부호 계획법(Parrilo 2000/2003), 힐베르트 영점 정리(1893), 쿠머 원분산술(1847) 등 `12`건의 1차 문헌이 본문 증명부에서 무인용으로 사용되었습니다.

### 1.2 주정리 전제 미봉합(`Unresolved Upstream Premises`) 및 조건부 명세 (`CP-02`)
- **`Main.lean`의 미해소 전제 3건**: `0 sorry`로 컴파일되나, 최상위 정리가 무조건부(`Unconditional`)가 아니라 다음 **3가지 대수적 전제를 구성적 증인(`Instance`) 없이 가설 인자로 입력받는 조건부 정리**로 작성되어 있습니다([mub6_stratigraphy_and_binary64_audit.lean](../proofs/mub6_stratigraphy_and_binary64_audit.lean#L1)):
  1. **스투르름 부호 변화 근 개수 가설 (`Sturm Root-Count Hypothesis`)**: 다항식 실근 부재 구간의 부호 변화 일치를 외부 가설로 주입함.
  2. **그뢰브너 아이디얼 소속 정규형 가설 (`Gröbner Normal-Form Hypothesis`)**: 다변수 다항식 아이디얼 생성원 결합 등식을 전제 번들로 가정함.
  3. **사영 종결식 영점 분리 가설 (`Projective Resultant Non-Vanishing Hypothesis`)**: 특이 궤적 위에서의 종결식 비소멸을 미증명 구조체 필드로 가정함.

### 1.3 도달성 층서학 (`44.5%` 미도달) 및 원고-아티팩트 불일치 (`CP-04`, `CP-05`)
- **진입점 미도달 모듈 층위 (`44.5%`, `225,763`줄)**: `OAI/QuantumInfo/MUB6/` 전체 `1,000`개 파일(`614,193`줄) 중 `Main.lean`에서 도달 가능한 파일은 `555`개(`388,430`줄, `55.5%`)이며, 나머지 **`445`개 파일(`225,763`줄, `44.5%`)은 진입점 미도달 모듈 층위**입니다.
- **미사용 가설 바인더 `29`건 (`CP-06`)**: 활성 및 보조 모듈 전반에 걸쳐 증명 항에서 참조되지 않는 `_h*` 가설 바인더 `29`건이 존재합니다.

### 1.4 유효 수리 코어 공인 및 인간 · 고전 · AI 3층 기여도 분리
- **유효 대수·SOS 인증 코어 공인 (`Gate 5: PASS`)**: 위 3개 미봉합 전제와 별개로, $6\times 6$ 푸리에-아다마르 결손 접공간 차원($d=4$), 솔로시 2차 곡면 항등식, 쿠머 3차 잉여 분기, 그리고 유리수 제곱합(SOS) 다항식 비음수 인증서(`388,430`줄 활성 콘) 자체는 수학적·기계적으로 유효합니다.
- **3층 기여도 분리**: (1) 선행 인간 양자정보·아다마르 분류·그뢰브너/SOS 이론 뼈대 **`70%`**, (2) **AI 대수적 SOS 다항식 인증서 및 `555`개 활성 모듈 형식화 코어 `30%` (`Gate 5 PASS`)**, (3) **6차원 MUB 부재의 무조건부(`Unconditional`) 완결 해결 기여도 `0%`** (`3`개 상류 전제 미봉합으로 인해 조건부 환원 정리임).

---

## 2. 예상 반론에 대한 사전 사실 확인 (Pre-bunking FAQ)

- **Q1. "`Main.lean`이 `0 sorry`로 컴파일되는데 왜 무조건부 해결이 아닌가?"**
  - **사실 확인**: `Lean 4`에서 `sorry`를 쓰지 않더라도, 아직 증명하지 않은 중간 정리를 `structure` 필드나 정리의 가정(`(h : SevenPointExclusionData)`)으로 올려두면 커널은 `h -> Conclusion`이라는 함의문만 검사하고 `0 sorry`로 통과시킵니다. 본 사건에서는 스투르름 근 개수, 그뢰브너 정규형, 사영 종결식 비소멸의 3개 전제가 구성적 증인 없이 가설로 남아 있습니다(`CP-02`).
- **Q2. "그렇다면 `388,430`줄의 활성 코드는 전부 빈 껍데기인가?"**
  - **사실 확인**: 아닙니다. 활성 증명 콘(`555`개 파일, `388,430`줄)에 구현된 푸리에-아다마르 결손 원뿔, 솔로시 대칭 다항식 전개, 쿠머 3차 분기 및 대규모 유리수 SOS 다항식 항등식(`ring` 검증)은 실질적인 수리·계산 업적입니다(`Gate 5: PASS`). 단지 마지막 3개 다리(스투르름·그뢰브너·종결식 인스턴스화)가 봉합되지 않았을 뿐입니다.
- **Q3. "미도달 파일 `445`개(`225,763`줄, `44.5%`)는 왜 발생한 것인가?"**
  - **사실 확인**: 원고 제5~6장에서 서술한 초기 그뢰브너 소거 및 대안 분기 모듈들이 최종 `Main.lean`의 조건부 인터페이스와 연결되지 않은 채 저장소에 남겨졌기 때문입니다(`CP-04`, `CP-05`).
- **Q4. "조건부 정리를 증명한 것도 학술적 가치가 있지 않은가?"**
  - **사실 확인**: 조건부 환원 정리로서의 가치는 충분하므로 `Gate 5: PASS` 및 `OPFF TIER D`(`Major Revision & Scope Downgrade Required`, 폐기 아님)를 부여했습니다. 단, 원고 제목과 초록에서 무조건부 해결 표기를 철회하고 **3개 미봉합 대수 전제 위에서의 조건부 정리(`Conditional Reduction Theorem`)로 명세를 정정**해야 합니다.
- **Q5. "서지 감사(`Gate 3`)에서 지적된 핵심 문제는 무엇인가?"**
  - **사실 확인**: 전체 인용의 `76.9%`(`20 / 26`회)가 서론(`13.3%` 분량)에 편중되고 정작 쿠머 강하·그뢰브너 소거·스투르름 근 분리·SOS 인증을 수행하는 제5·6·7장에서는 인용이 `0`회이며 `12`대 1차 고전 문헌이 누락된 점입니다(`CP-03`).
- **Q6. "`OPFF TIER A` 또는 `TIER B`로 승격되기 위한 요건은 무엇인가?"**
  - **사실 확인**: (1) 원고를 조건부 환원 정리로 명시(`TIER B` 요건)하거나 3개 미봉합 전제(스투르름·그뢰브너·종결식)의 구성적 증인을 Lean에서 끝까지 인스턴스화(`TIER A` 요건)하고, (2) 미도달 모듈 `445`개(`225,763`줄)를 정리하며, (3) 제5~7장에 12대 고전 원저 인용을 복원하면 됩니다.

---

## 3. 10초 재현 명령어 (`Don't Trust, Verify`)

```bash
# 1) 1,000개 파일 층서학(555 활성 / 445 미도달), 3대 미봉합 전제 번들 및 29개 미사용 _h* 바인더 실측 확인
python3 -B proofs/verify_symbolic_mub266.py

# 2) 75개 독립 Lean 4 정리 커널 검증 (0 sorry, 0 axiom, 358/358 가설 변이 사살)
lake env lean proofs/mub6_hadamard_fourier_and_cubic_fibers.lean
lake env lean proofs/mub6_weiner_completion_and_gram_sos.lean
lake env lean proofs/mub6_stratigraphy_and_binary64_audit.lean
```
