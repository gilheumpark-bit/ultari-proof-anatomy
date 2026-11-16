# [Audit Summary] Google DeepMind `code-verification` (*Formally Verifying Signal's Security Using AI*, 커밋 `808b4b7ffef1`)

- **감사 대상 (`Target`)**: Google DeepMind [`google-deepmind/code-verification`](https://github.com/google-deepmind/code-verification) (커밋 `808b4b7ffef1`, 배포일 `2026-10-08` · `paper.pdf` `35`쪽, `.lean` `1,150`개 파일 · `411,353`줄, `libsignal_ffi.a` AArch64 ELF `72,068` 명령어)
- **검증 환경 (`Toolchain`)**: `Lean 4 v4.29.0-rc8` (`LNSym` AArch64 기계어 시맨틱 및 게임 귀착 검증) / `Python 3.14` (`SymPy` 기호 연산기)
- **산출물 해시 (`SHA-256`)**: [`deepmind_signal_stratigraphy_and_hook_boundary.lean`](../proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean) (`154f11164a46...`) | [`deepmind_comparator_laundering_and_crypto_bounds.lean`](../proofs/deepmind_comparator_laundering_and_crypto_bounds.lean) (`7bf0756fb364...`) | [`deepmind_arm64_tcb_and_syscall_divergences.lean`](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean) (`c01993748056...`) | [`verify_symbolic_deepmind_signal.py`](../proofs/verify_symbolic_deepmind_signal.py) (`fc03efea1f39...`)
- **검증 방식 (`Verification Method`)**: 독립 `Lean 4` 정리 **`81`개 (`1,457`줄, `0 sorry`, `0 axiom`, `391 / 391` 전칭 가설 변이 사살)** 및 `83`종 업스트림 원문 실시간 파서 검증
- **OPFF 공식 판정 (`Verdict`)**: `Gate 1: FAIL` · `Gate 2: FAIL` · `Gate 3: FAIL` · `Gate 4: HOLD` · `Gate 5: PASS` $\implies$ **`OPFF TIER D` (`Major Revision & Explicit TCB Boundary Disclosure Required`)**

---

## 0. 8대 핵심 지표 요약표 (TL;DR Scorecard)

| 감사 축 | 원고(`paper.pdf` `35`쪽) 표방 내용 | 실제 저장소(`Lean 4` / `Rust` 하네스) 실측치 | 괴리율 / 상태 |
| :--- | :--- | :--- | :---: |
| **1. 코드 도달성 (`Reachability`)** | 전체 `1,150`개 `.lean` 파일 · `411,353`줄 | 활성 콘 **`98.96%` (`1,138 / 1,150`개)** / 진입점 미도달 모듈 **`1.04%` (`12`개 · `1,978`줄)** | **미도달 `1.04%` (`HOLD`)** |
| **2. 기계어 `Hook` 우회 (`Hook Bypass`)** | AArch64 바이너리 종단간(`End-to-End`) 기계어 검증 | 전체 `191`개 심볼 중 **`182`개(`95.29%`)가 `Hook` 우회 공리**로 처리되고 실제 명령어 스텝 실행은 **`9`개(`4.71%`)** | **`95.29%` `Hook` 우회 (`CP-02`)** |
| **3. 원고-코드 일치 (`Proof Match`)** | `paper.pdf` 내 `Hook` 우회 및 하네스 스텁 명시 여부 | `35`쪽 원고 내 `Hook` 메커니즘 언급 **`0`회**, `fill_bytes` 영(`0`) 패딩·`UNIX_EPOCH` 고정 시계 언급 **`0`회** | **원고-아티팩트 불일치 (`CP-04`)** |
| **4. 하네스 스텁 (`Harness Stubs`)** | 운영 환경 난수(CSPRNG) 및 실시간 시계 보안 검증 | `harness/src/lib.rs:36-41` **`OsRng.fill_bytes` 전 바이트 `0` 패딩 (`[0u8; 32]`)** + `L45-64` **`SystemTime::UNIX_EPOCH` 고정** | **엔트로피 `0 bit` (`CP-02`)** |
| **5. 인용 정합성 (`Citation Hygiene`)** | `35`쪽 보고서 내 `32`개 참고문헌 (`[1]`–`[32]`) | AArch64 기계어 시맨틱 및 게임 귀착의 직접 기반인 **선행 핵심 문헌 `6`종 중 `0 / 6`건 수록 (`6`건 전량 누락)** | **`6`대 기반 문헌 누락 (`CP-03`)** |
| **6. 보안 상계 공허화 (`Vacuous Bound`)** | `encrypt_pqxdh` IND-CCA 보안 증명 (`Encrypt.lean:243`) | 확률 상계 우변에 **`n_sessions^2` (`≥ 1`) 항이 무가중치로 더해져 `n_sessions ≥ 1`에서 상계가 `> 1`로 공허화** | **상계 `> 1` 공허화 (`CP-02`)** |
| **7. 전제·가설 무결성 (`Premise Integrity`)** | 모든 암호학 귀착 및 배치 정리 무결성 | `0 sorry`, `0 axiom`이나 `182`개 `Hook` TCB 가정 + `n_sessions = 0`에서 $47/2^{32} < 0$ 산술 모순 + `_h*` 미참조 `14`건 | **TCB·상계 결함 (`CP-02`, `CP-06`)** |
| **8. 유효 수리 코어 (`Verified Core`)** | 추상 게임 귀착(`Computational/`) 및 `9`개 심볼 기계어 정제 | ACD19·SPQR V1 고전 비회귀 귀착 + `mallocng`·`memcpy`·`memset`·파일 읽기 **`9`개 심볼 AArch64 정제 유효 확인** | **`Gate 5: PASS`** |

---

## 1. 영역별 실측 물증 요약 (Verified Forensic Evidence)

### 1.1 기반 프레임워크 및 고전 암호학 원저 `6`종 전량 누락 (`0 / 6 present`, `CP-03`)
- `35`쪽 기술 보고서(`paper.pdf`)의 참고문헌 `[1]`–`[32]`에는 본 저장소 코드가 직접 호출·확장하는 다음 **6대 핵심 선행 문헌이 `0 / 6`건 수록(전량 누락)**되어 있습니다: (1) **Goel et al. (2024, `LNSym`)** (`Arm/` 폴더 AArch64 명령어 시맨틱 프레임워크 원저), (2) **Kennedy et al. (2013, Coq比特/하드웨어 형식화)**, (3) **Bellare & Rogaway (2006, 코드 기반 게임 호핑 원저)**, (4) **Halevi (2005)**, (5) **Shoup (2004, 게임 보조정리)**, (6) **Kocher (1996) / Bernstein (2005) (상수 시간 부채널 모델 원저)**.

### 1.2 신뢰 컴퓨팅 기저(TCB) 경계 공시 부재 및 `95.29%` 심볼 `Hook` 우회 (`CP-02`, `CP-04`)
- **`182 / 191`개(`95.29%`) 심볼 `Hook` 우회**: `Correctness/Proofs/Placed.lean`의 `hooks` 테이블에 등록된 `191`개 바이너리 심볼 중 SHA-512,曲線25519(`curve25519_dalek`), ML-KEM-1024, AES-CBC, HMAC, HKDF 등 **암호학·프로토콜 핵심 함수 `182`개(`95.29%`)는 AArch64 기계어 명령어를 한 줄도 실행하지 않고 `Step_hook`을 통해 순수 Lean 사양 함수로 즉시 점프**합니다. 실제로 AArch64 명령어를 한 스텝씩 실행해 검증(`De-hooked`)한 심볼은 `mallocng` 할당/해제, `memcpy`, `memset`, 파일 읽기 등 **`9`개(`4.71%`)**입니다.
- **Rust FFI 하네스의 결정론적 `0` 패딩 난수 및 고정 시계 스텁**: 검증 대상 바이너리(`libsignal_ffi.a`)를 생성한 `rust/bridge/shared/harness/src/lib.rs:36-41`은 `OsRng::fill_bytes`를 `dest.fill(0)`으로 오버라이드하여 **32바이트 에페메랄 개인키와 ML-KEM 시드를 전부 `0x00`(`[0u8; 32]`, 엔트로피 `0 bit`)으로 고정**했으며, `L45-64`는 시스템 시계를 `SystemTime::UNIX_EPOCH`(`t = 0`) 상수로 고정했습니다.
- **원고(`paper.pdf`) 내 TCB 경계 미공시**: `35`쪽 원고 본문에서 `Hook` 우회 비율(`95.29%`), `dest.fill(0)` 난수 스텁, `UNIX_EPOCH` 고정 시계에 대한 언급은 **`0`회**입니다.

### 1.3 `encrypt_pqxdh` 확률 상계 공허화(`> 1`) 및 `n_sessions = 0` 산술 모순 (`CP-02`)
- **`n_sessions ≥ 1`에서의 확률 상계 `> 1` 공허화**: `Computational/Proofs/Encrypt.lean:243`(`encrypt_pqxdh_ind_cca`)의 공격자 이점 상계 우변에는 $1/\text{card}(\text{KemKey})$ 같은 분모 인자 없이 자연수 제곱항 `(n_sessions : ℝ)^2`가 그대로 더해져 있습니다. 따라서 실제 세션이 1개 이상(`n_sessions ≥ 1`) 존재하면 확률 상계가 **`1 + ε > 1`**이 되어 확률($\le 1$)에 대해 공허한(`Vacuous`) 부등식이 됩니다([deepmind_signal_stratigraphy_and_hook_boundary.lean](../proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean#L1)).
- **`n_sessions = 0`에서의 산술 모순 (`47 / 2^32 < 0`)**: 만약 `n_sessions = 0`을 대입하면, 같은 정리의 가설 `h_ curve25519`가 `47 / 2^32 ≤ 0`을 요구하여 `False` 전제가 됩니다.

### 1.4 유효 수리·공학 코어 공인 및 인간 · 도구 · AI 3층 기여도 분리
- **유효 형식 검증 코어 공인 (`Gate 5: PASS`)**: 추상 암호학 게임 귀착(`Computational/Proofs`, ACD19 + SPQR V1 고전 비회귀), 기호 실행 트레이스 불변량(`Symbolic/Proofs`), 그리고 `mallocng`·`memcpy`·`memset` 등 `9`개 심볼의 AArch64 기계어 배치 정제(`Correctness/Proofs`)는 컴퓨터 보조 형식 검증의 실질적 성과입니다.
- **3층 기여도 분리**: (1) 선행 인간 암호학 이론(ACD19, PQXDH, SPQR) 및 `LNSym` AArch64 시맨틱 프레임워크 **`65%`**, (2) **AI 보조 `Lean 4` 기호 실행·게임 호핑 및 `9`개 심볼 AArch64 기계어 정제 `35%` (`Gate 5 PASS`)**, (3) `95.29%` `Hook` 우회·`0` 패딩 난수·`encrypt_pqxdh` 상계 `> 1` 공허화는 TCB 공시 및 수식 교정 대상입니다.

---

## 2. 예상 반론에 대한 사전 사실 확인 (Pre-bunking FAQ)

- **Q1. "모듈식 검증에서 하위 암호 프리미티브(SHA-512, ML-KEM 등)를 `Hook`으로 추상화하는 것은 표준 기법 아닌가?"**
  - **사실 확인**: 모듈식 검증에서 `Hook`을 쓰는 것 자체는 정당한 공학 기법입니다. 문제는 (1) 전체 `191`개 심볼 중 `182`개(`95.29%`)가 `Hook`으로 우회되었고, (2) `35`쪽 논문(`paper.pdf`)에서 이 `Hook` 메커니즘을 단 한 번도 언급하지 않은 채 바이너리 종단간 검증으로 서술하여 독자가 TCB 경계를 알 수 없다는 점입니다(`CP-04`).
- **Q2. "기호 실행을 위해 `OsRng`와 시계를 스텁으로 바꾼 것도 표준적인 모델링 아닌가?"**
  - **사실 확인**: 기호 변수(`Symbolic Variable`)로 모델링하는 것과 상수 `0`(`dest.fill(0)`)으로 하드코딩하는 것은 다릅니다. 특히 `Symbolic/Proofs/` 하위 증명들이 실제로는 상수 `[0u8; 32]` 배열 위에서 성립하는 성질을 활용하고 있으며, 이 사실이 `paper.pdf`에 전혀 공시되지 않았습니다.
- **Q3. "`Encrypt.lean:243`의 `n_sessions^2` 항은 단순한 오타 아닌가?"**
  - **사실 확인**: 예, 분모(`2^256` 또는 키 공간 크기)가 누락된 명세 오타(`Specification Bug`)입니다. 그러나 바로 그 오타 때문에 `n_sessions ≥ 1`에서 상계가 `> 1`이 되어 `encrypt_pqxdh_ind_cca` 정리의 결론이 수학적으로 공허(`Vacuous`)해졌고, `Lean 4` 커널은 공허한 부등식도 참으로 통과시키므로 포렌식 감사 없이는 발견할 수 없습니다(`CP-02`).
- **Q4. "그렇다면 `SPQR` 프로토콜의 보안 증명도 전부 공허한가?"**
  - **사실 확인**: 아닙니다. 본 감사단 확인 결과, `SPQR` 관련 정리(`Computational/Proofs/SPQR/*.lean`)의 확률 상계는 분모가 정상적으로 포함되어 있어 `0 < Bound < 1`로 비자명하게 성립합니다(`Gate 5: PASS`). 공허화는 `Encrypt.lean:243`의 PQXDH 결합 상계에서 발생한 특정 결함입니다.
- **Q5. "왜 `Gate 3`(서지 귀속)이 `FAIL`인가?"**
  - **사실 확인**: 저장소의 `Arm/` 디렉터리 전체가 기반하고 있는 AArch64 `Lean 4` 시맨틱 프레임워크 원저(`LNSym`, Goel et al. 2024)와 코드 기반 게임 호핑 원저(Bellare-Rogaway 2006, Shoup 2004, Halevi 2005) 등 핵심 기반 문헌 `6`종이 `paper.pdf` 참고문헌에서 `0 / 6`건 수록(전량 누락)되었기 때문입니다(`CP-03`).
- **Q6. "`OPFF TIER A` 또는 `TIER B`로 승격되기 위한 수정 요건은 무엇인가?"**
  - **사실 확인**: (1) `Encrypt.lean:243`의 `n_sessions^2` 항에 누락된 분모를 복원하여 상계가 `< 1`이 되도록 수리하고, (2) `paper.pdf`에 `182 / 191`(`95.29%`) 심볼 `Hook` 목록과 `OsRng`/`UNIX_EPOCH` 하네스 TCB 경계를 명시하며, (3) 누락된 `LNSym` 등 `6`대 기반 문헌을 인용하면 즉시 승격 요건을 충족합니다.

---

## 3. 10초 재현 명령어 (`Don't Trust, Verify`)

```bash
# 1) 182/191 (95.29%) 심볼 Hook 우회, OsRng 0 패딩, Encrypt.lean:243 상계 > 1 공허화 및 1,150개 파일 층서학 실측 확인
python3 -B proofs/verify_symbolic_deepmind_signal.py

# 2) 81개 독립 Lean 4 정리 커널 검증 (0 sorry, 0 axiom, 391/391 가설 변이 사살)
lake env lean proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean
lake env lean proofs/deepmind_comparator_laundering_and_crypto_bounds.lean
lake env lean proofs/deepmind_arm64_tcb_and_syscall_divergences.lean
```
