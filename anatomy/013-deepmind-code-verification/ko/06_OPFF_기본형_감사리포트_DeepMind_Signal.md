# 감사 요약 리포트: Google DeepMind AlphaProof Code (code-verification, Formally Verifying Signal's Security Using AI, 커밋 808b4b7ffef1)

- 감사 대상: Google DeepMind AlphaProof Code ([google-deepmind/code-verification](https://github.com/google-deepmind/code-verification), 최초 공개 커밋 `808b4b7ffef1` 및 후속 PR #2 커밋 `b0f729accbc2` · 2026년 10월 26일 원고 및 동반 문서 [DEVIATIONS.md](../proofs/oai_ref/Computational/docs/DEVIATIONS.md#L1-L3617) 3,617줄, [PAPER_DIFFERENCES.md](../proofs/oai_ref/docs/Symbolic/PAPER_DIFFERENCES.md#L1-L337) 337줄, [READING_THE_THEOREMS.md](../proofs/oai_ref/Computational/docs/READING_THE_THEOREMS.md#L1-L330) 330줄, [PQXDH.md](../proofs/oai_ref/Computational/docs/PQXDH.md#L1-L136) 136줄, [PAPER_MAP.md](../proofs/oai_ref/docs/PAPER_MAP.md#L1-L252) 252줄; 11,323개 `.lean` 파일 · 7,528,295줄 + AArch64 ELF `libsignal-cli.elf` 617,448바이트)
- 검증 환경: Lean 4 v4.29.0-rc8 / Python 3.14 (SymPy 기호 연산기 및 1차 원문 실시간 파서)
- 산출물 해시 (SHA-256): [deepmind_signal_stratigraphy_and_hook_boundary.lean](../proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean) (e58829f52915...) | [deepmind_arm64_tcb_and_syscall_divergences.lean](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean) (109d9e94c216...) | [deepmind_comparator_laundering_and_crypto_bounds.lean](../proofs/deepmind_comparator_laundering_and_crypto_bounds.lean) (5960b90f4ee0...) | [deepmind_signal_forensic_parsers.py](../proofs/deepmind_signal_forensic_parsers.py) (8d41db304ae8...) | [verify_symbolic_deepmind_signal.py](../proofs/verify_symbolic_deepmind_signal.py) (4cc43598acf0...)
- 검증 방식: 독립 Lean 4 정리 81개 (1,457줄, 0 sorry, 0 axiom, 391 / 391 전칭 가설 변이 사살 = 100%) 및 보존 원문 83종 (59개 .lean + 24개 비-Lean) 실시간 파서 검증
- OPFF 공식 판정: Gate 1: HOLD · Gate 2: FAIL · Gate 3: FAIL · Gate 4: FAIL · Gate 5: PASS ⇒ OPFF TIER C (조건부 검증 인정 및 아티팩트·TCB 경계 규격 미충족)

## 0. 8대 핵심 지표 요약표

| 감사 축 | 원고 및 공시 문서 표방 내용 | 실제 저장소(Lean 4 / Arm64 / CLI / comparator) 실측치 | 괴리율 / 상태 |
| :--- | :--- | :--- | :---: |
| 1. 빌드 및 코드 도달성 | 11,323개 파일 · 7,528,295줄 검증 | 기본 lake build가 CliElfLib(120개 모듈 · 85,249줄) 등 592개 모듈(267,194줄) 제외; 6대 표제 정리 모두에서 1,450개 파일(595,231줄) 미도달 | 595,231줄 미도달 (CP-05) |
| 2. 바이너리 Hook 절단면 | 컴파일된 AArch64 libsignal-cli 종단간 검증 | 추적 심볼 64개 중 55개(85.94%)가 기계어 실행 우회 (Lean 훅 37개 + 패닉 18개, Drop::drop 영점화 훅 2개 포함; 단 9개 = 14.06%만 ELF 바이트 실행) | 85.94% Hook 우회 (CP-02 · CP-04) |
| 3. 최하위 ISA/시스콜 TCB | 형식화된 AArch64 ISA 및 리눅스 시스콜 시맨틱 | `Arm64/Trusted/` 61개 파일(16,767줄) 내 증명된 정리 0개; `Hoare.lean`(`Spec`/`reaches_outcome`)은 `.Exception` 177개를 fail-closed로 배제(비모델링 경로 도달 불가 증명 필요)하며 `Spec.allowOom`으로 `.OutOfMemory`만 면책; 31 / 301+ 시스콜만 모델링; `AT_RANDOM` 0 초기화 | 16,767줄 미증명 TCB (Gate 1 HOLD) |
| 4. Rust CLI 하네스 고정 | 시그널 세션·프리키·난수·저장소 검증 | [coins.rs](../proofs/oai_ref/third_party/libsignal/libsignal-session/cli/src/coins.rs#L32-L46) 고갈 난수 버퍼 0 패딩, 시계 UNIX_EPOCH = 0 고정 (30일 SPK 만료 우회), Waker::noop() 단발 폴링, EBADF = 9 무음 EOF | 하네스 환경 고정 (CP-02 · CP-04) |
| 5. comparator TCB 경계 | 외부 비교기가 명세·공리 변조 원천 차단 | ComparatorChallenge가 326개 파일(153,682줄)을 TCB 안으로 임포트; "enable_nanoda": false; Linux 5.10 < 5.13 비샌드박스 빌드; PR #2에서 주의사항 67줄 삭제 | 153,682줄 TCB 편입 (CP-07) |
| 6. 양자내성 및 PQXDH 상계 | $2^{40}$ 질의 규모 하이브리드 PQXDH + SPQR V1 보안 | 계산 정리는 고전 보안만 증명 (DEV-PQ19); [PQXDH.md](../proofs/oai_ref/Computational/docs/PQXDH.md#L69-L112)의 $q_{\text{total}} = 2^{40}$에서 표준 모델 GapDH 제5항이 $17,441 / 16,384 > 1$로 공허화 | $2^{40}$ 상계 공허화 (CP-02) |
| 7. 세션 MAC 및 프리키 절벽 | 다중 에포크 래칫 및 최후 수단 프리키 운용 | 8바이트 MAC 상계(DEV-C14)가 $q = 35,211$에서 1 초과 (DEVIATIONS.md:2733은 구형 수치 38,967 기재); .base-keys가 56,680회 핸드셰이크($> 2\text{ MiB}$) 후 영구 거부 | 35,211 / 56,680 절벽 (CP-04) |
| 8. 재현성 및 위생 스크립트 | 자가 시험 위생 스크립트 및 완결 아티팩트 | [check_refinement_hygiene.sh](../proofs/oai_ref/Symbolic/scripts/check_refinement_hygiene.sh#L121-L136) --self-test 실패 (7/14 구형 정리명, 종료 코드 1); 본문 인용 감사 스크립트 5종 + TRUSTED_BASE.md 누락 (0 / 6 수록); AGPL-3.0 ELF 미커밋 | 자가시험 실패 / 6종 누락 (CP-03 · CP-07) |

## 1. 영역별 실측 물증 요약

### 1.1 85.94% 심볼 Hook 우회, 16,767줄 미증명 Arm64 TCB 및 CliElfLib 기본 빌드 제외 (CP-02, CP-04, CP-05)
- 추적 바이너리 심볼 64개 중 55개(85.94%) AArch64 기계어 실행 우회: 배치 바이너리 검증의 추적 심볼 64개 중 37개 Lean 사양 훅과 18개 패닉 스텁(비밀키 메모리를 지우는 Drop::drop 훅 2개 포함, 합계 55 / 64 = 85.94%, PR #2 이후 45 / 64 = 70.31%)이 AArch64 기계어 스텝 실행을 우회하며, 실제 ELF 기계어 바이트를 실행해 검증한 심볼은 9개(14.06%: mallocng 할당/해제, memcpy, memset, 파일 읽기)뿐입니다([deepmind_signal_stratigraphy_and_hook_boundary.lean](../proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean#L1)).
- 16,767줄 미증명 ISA/시스콜 기저 및 595,231줄 미도달 모듈: Arm64/Trusted/(61개 파일, 16,767줄)에는 증명된 정리가 0개이며(저장소 전체에 sorry 토큰 38개 존재), 기본 lake build는 CliElfLib(120개 모듈, 85,249줄)를 포함한 592개 모듈(267,194줄)을 빌드에서 제외하고, 6대 표제 정리 모두에서 도달하지 않는 파일이 1,450개(595,231줄)에 달합니다.

### 1.2 고정된 CLI 하네스(고갈 난수 0 패딩·고정 시계) 및 153,682줄 Comparator TCB 편입 (CP-02, CP-07)
- 고갈 난수 버퍼 0 패딩 및 UNIX_EPOCH = 0 고정 시계: [coins.rs](../proofs/oai_ref/third_party/libsignal/libsignal-session/cli/src/coins.rs#L32-L46)는 고갈된 CryptoRng 버퍼를 0으로 채우고 시스템 시계를 UNIX_EPOCH = 0으로 고정(30일 서명 프리키 만료 검사 우회)하며, 단발 폴링 Waker::noop()과 EBADF = 9 무음 EOF 처리를 사용합니다.
- ComparatorChallenge의 153,682줄 TCB 편입 및 PR #2 주의사항 삭제: 외부 비교기용 챌린지 파일이 326개 파일(153,682줄)을 전이적으로 임포트하여 TCB에 편입시켰고("enable_nanoda": false), 후속 PR #2(커밋 b0f729accbc2)는 comparator/README.md에 있던 67줄 분량의 한계·주의사항 절을 삭제했습니다.

### 1.3 고전 전용 보안 귀착(DEV-PQ19), PQXDH $2^{40}$ 상계 공허화($17,441/16,384 > 1$) 및 운용 절벽 (CP-02, CP-04)
- $q_{\text{total}} = 2^{40}$ 표준 모델 GapDH 상계 공허화 및 `DEV-C14` 구형 수치 불일치: 계산 정리들은 고전 보안만 증명하며(`DEV-PQ19`), [PQXDH.md](../proofs/oai_ref/Computational/docs/PQXDH.md#L69-L115)가 표방한 $q_{\text{total}} = 2^{40}$ 규모에서 표준 모델 GapDH 제5항은 $q_{\text{total}} \ge 1,081,110,205,009 \approx 2^{39.98}$에서 1을 넘어 $17,441 / 16,384 \approx 1.0645 > 1$로 공허해지므로(`PQXDH.md:115`) 구체적 보안 여유 구간을 $q_{\text{total}} \le 2^{24}$로 제한합니다. 또한 8바이트 MAC 충돌 상계(`DEV-C14`, $q_{\text{ep}} = q$)는 실제로는 $q = 35,211$개 단일 세션 메시지에서 1을 초과하나 `DEVIATIONS.md:2733`은 구형 수치 `38,967`을 기재하고 있으며, `.base-keys` 파일은 56,680회 핸드셰이크($> 2\text{ MiB}$) 이후 프리키를 영구 거부합니다.
- 위생 스크립트 자가시험 실패 및 인용 감사 파일 6종 누락: [check_refinement_hygiene.sh](../proofs/oai_ref/Symbolic/scripts/check_refinement_hygiene.sh#L121-L136) --self-test 실행 시 구형 정리명 불일치(7/14)로 실패(종료 코드 1)하며, 문서에서 인용한 감사 스크립트 5종과 TRUSTED_BASE.md가 저장소에 존재하지 않고(0 / 6 수록) AGPL-3.0-only 파생 ELF 바이너리가 미커밋 상태입니다.

### 1.4 유효 다계층 형식 검증 코어 공인 및 인간 · 도구 · AI 3층 기여도 분리
- 유효 다계층 형식 검증 코어 공인 (Gate 5: PASS): 추상 암호학 게임 귀착(Computational/Proofs, ACD19 + SPQR V1 고전 비회귀), 기호 실행 불변량(Symbolic/Proofs), 그리고 9개 비-훅 심볼(mallocng, memcpy, memset, 파일 읽기)의 AArch64 기계어 배치 정제는 실질적 컴퓨터 보조 검증 업적이며, 본 감사단의 독립 Lean 4 정리 81개(1,457줄, 391/391 변이 사살)로 검증되었습니다.
- 3층 기여도 분리: (1) 선행 인간 암호학 이론(ACD19, PQXDH, SPQR) 및 AArch64 ISA 모델링 65%, (2) AI 보조 Lean 4 게임 호핑·기호 실행 증명 및 9개 심볼 AArch64 기계어 정제 35% (Gate 5 PASS), (3) 85.94% Hook 우회, 153,682줄 비교기 TCB 편입, $2^{40}$ GapDH 상계 공허화 및 6종 감사 파일 누락은 시정 대상입니다.

## 2. 예상 반론에 대한 사전 사실 확인 (FAQ)

- Q1. "이 저장소가 컴파일된 AArch64 libsignal-cli 바이너리를 기계어 수준까지 종단간 검증한 것 아닌가?"
  - 사실 확인: 추적 대상 64개 심볼 중 실제 AArch64 ELF 기계어 명령어를 실행해 검증한 것은 9개(14.06%: mallocng 할당/해제, memcpy, memset, 파일 읽기)뿐이며, 나머지 55 / 64개(85.94%, PR #2 이후 45 / 64 = 70.31%)는 37개 Lean 훅과 18개 패닉 스텁으로 우회되었고 CliElfLib(85,249줄)는 기본 lake build에서 제외되어 있습니다.
- Q2. "외부 비교기(comparator)를 통과했으므로 정리 명세와 TCB가 최소화된 것 아닌가?"
  - 사실 확인: 아닙니다. ComparatorChallenge 자체가 326개 파일(153,682줄)을 TCB 안으로 전이 임포트하고 미증명 Arm64/Trusted/ 61개 파일(16,767줄)을 포함하며, "enable_nanoda": false로 설정되어 있고 PR #2에서 comparator/README.md의 67줄 주의사항 절이 삭제되었습니다.
- Q3. "PQXDH와 SPQR 증명이 표방된 $2^{40}$ 규모에서 양자내성 보안을 보장하는가?"
  - 사실 확인: `DEVIATIONS.md`(`DEV-PQ19`)가 밝히듯 계산 정리는 고전 보안만 형식화했으며, [PQXDH.md](../proofs/oai_ref/Computational/docs/PQXDH.md#L69-L115)에서 표준 모델 GapDH 제5항이 $q_{\text{total}} \ge 1,081,110,205,009 \approx 2^{39.98}$에서 1을 넘어 $q_{\text{total}} = 2^{40}$에서 $17,441 / 16,384 \approx 1.0645 > 1$이 되므로, `PQXDH.md:115`는 구체적 보안 여유를 $q_{\text{total}} \le 2^{24}$로 제한합니다.
- Q4. "왜 `DEVIATIONS.md:2733`의 `DEV-C14` 임계치는 `38,967`인데 실제 상계는 `35,211`에서 1을 넘는가?"
  - 사실 확인: 코드의 수식이 변경된 뒤 `DEVIATIONS.md:2733`($q_{\text{ep}} = q$일 때 단일 세션 내 메시지/질의 수)의 본문 수치가 구형 값(`38,967`) 그대로 방치되어 단일 세션 내 `3,756`개 메시지의 괴리가 발생했기 때문입니다([deepmind_comparator_laundering_and_crypto_bounds.lean](../proofs/deepmind_comparator_laundering_and_crypto_bounds.lean#L1)).
- Q5. "그럼에도 추상 게임 귀착과 9개 비-훅 심볼의 AArch64 정제는 공학적 가치가 있는가?"
  - 사실 확인: 매우 높습니다. Computational/Proofs의 다단계 암호 게임 귀착, Symbolic/Proofs의 Rust 기호 정제, 그리고 mallocng·memcpy·memset 기계어 증명은 AI 보조 형식 검증의 중요한 성취이므로 Gate 5: PASS로 공인했습니다.
- Q6. "OPFF TIER A로 승격되기 위한 수정 요건은 무엇인가?"
  - 사실 확인: (1) 기본 lake build에 CliElfLib를 포함하고 미도달 파일 1,450개(595,231줄)를 정리하며, (2) 153,682줄에 달하는 ComparatorChallenge TCB를 축소하고 삭제된 67줄 주의사항 공시를 복구하며, (3) PQXDH.md의 $2^{40}$ GapDH 상계 공허화 수식과 DEV-C14 수치(35,211)를 교정하고, (4) 누락된 감사 스크립트 5종·TRUSTED_BASE.md 및 위생 자가시험 오류를 수리하면 됩니다.

## 3. 10초 재현 명령어

```bash
# 1) 11,323개 파일(7,528,295줄) 층서학, 55/64 (85.94%) Hook 우회, 153,682줄 비교기 TCB 및 PQXDH/DEV-C14 상계 실측 확인
python3 -B proofs/verify_symbolic_deepmind_signal.py

# 2) 81개 독립 Lean 4 정리 커널 검증 (0 sorry, 0 axiom, 391/391 가설 변이 사살)
lean proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean
lean proofs/deepmind_arm64_tcb_and_syscall_divergences.lean
lean proofs/deepmind_comparator_laundering_and_crypto_bounds.lean
```
