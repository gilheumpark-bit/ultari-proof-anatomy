# Forensic & Referee Audit Report: Google DeepMind AlphaProof Code (code-verification, Formally Verifying Signal's Security Using AI, 커밋 808b4b7ffef1) 전수 감사 보고서

## 0. 감사 메타데이터 및 암호학적 봉인 원장

| 항목 | 세부 내역 |
| :--- | :--- |
| 대상 논문 / 프리프린트 | Formally Verifying Signal's Security Using AI (2026년 10월 26일 초안, 동반 기술 문서 [DEVIATIONS.md](../proofs/oai_ref/Computational/docs/DEVIATIONS.md#L1-L3617) 3,617줄, [PAPER_DIFFERENCES.md](../proofs/oai_ref/docs/Symbolic/PAPER_DIFFERENCES.md#L1-L337) 337줄, [READING_THE_THEOREMS.md](../proofs/oai_ref/Computational/docs/READING_THE_THEOREMS.md#L1-L330) 330줄, [PQXDH.md](../proofs/oai_ref/Computational/docs/PQXDH.md#L1-L136) 136줄, [PAPER_MAP.md](../proofs/oai_ref/docs/PAPER_MAP.md#L1-L252) 252줄) |
| 대상 코드 저장소 및 커밋 | Google DeepMind AlphaProof Code (google-deepmind/code-verification, 초기 공개 커밋 808b4b7ffef198e6a91f71ed776d641a1c236882 및 후속 PR #2 커밋 b0f729accbc2, 총 11,323개 .lean 파일 · 7,528,295줄: 임포트 가능 모듈 11,314개 7,525,836줄 + Lake 빌드 파일 9개 2,459줄) |
| 동반 바이너리 / 비교 챌린지 | 정적 링크 AArch64 ELF .GeneratedLean/cli-elf/libsignal-cli.elf (617,448바이트, SHA-256: `2f20c836342437a882b5882c34eab604e4f23b2b388c2b2a0696eeda51cddc7e`, AGPL-3.0-only 파생물로 저장소 미커밋·미수록) / comparator 챌린지 스텁 8개 파일(343줄, JSON 항목 8 + 16 = 24건 $\to$ 고유 정리 21건) |
| 툴체인 및 컴파일러 | Lean 4 v4.29.0-rc8 (leanprover/lean4:v4.29.0-rc8) / Python 3.14 (SymPy 기호 연산기 및 실시간 원문 파서) |
| 검증 산출물 SHA-256 | • [deepmind_signal_stratigraphy_and_hook_boundary.lean](../proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean): `e58829f52915609cee169645f20d5501627bd0979309d4fdbc6f372099fc3dc1`<br>• [deepmind_arm64_tcb_and_syscall_divergences.lean](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean): `109d9e94c2165d3058828609c085ac7647c20492147880cd92440df52856b8f1`<br>• [deepmind_comparator_laundering_and_crypto_bounds.lean](../proofs/deepmind_comparator_laundering_and_crypto_bounds.lean): `5960b90f4ee0382bbc594054f4499be62f016a69089f729dc6123817b073d51c`<br>• [deepmind_signal_forensic_parsers.py](../proofs/deepmind_signal_forensic_parsers.py): `8d41db304ae88c0ccebd8119ff3e4de6824ad0e5a3384a66ff7e4cb5b2e4a05c`<br>• [verify_symbolic_deepmind_signal.py](../proofs/verify_symbolic_deepmind_signal.py): `4cc43598acf05cb2b062677e3a5bd9b55adec7eeaa32ecdf30f70954bb60cd00` |
| 검증 방식 | 독립 Lean 4 정리 81개 (1,457줄, 0 sorry, 0 axiom, 전칭 가설 돌연변이 포착 391 / 391건 = 100%, 구조적 정리 74 / 81건, DoF > 0: 65 / 81건, 비선형 10건) 및 83종 업스트림 원문(59개 .lean + 24개 비-Lean) 실시간 파싱·기호 검증 스위트 |
| 준거 감사 헌장 | Open Proof Forensics Foundation (OPFF) 5-Gate Joint International Audit Charter (COPE · IMU/AMS · ACM v1.1 · ICMJE/CRediT · NeurIPS, Charter DOI: [10.5281/zenodo.24241228](https://doi.org/10.5281/zenodo.24241228), Ledger v1.0.0 DOI: [10.5281/zenodo.24241229](https://doi.org/10.5281/zenodo.24241229)) |
| OPFF 5대 관문 및 공식 등급 판정 | Gate 1 (수리·커널): HOLD (무증명 16,767줄 Arm64/Trusted TCB 및 38개 sorry 잔존) · Gate 2 (원고-코드): FAIL (85.94% 심볼 Hook 우회·비기본 CliElfLib 격리·DEV-C14 임계치 오기재) · Gate 3 (서지·윤리): FAIL (미수록 감사 스크립트 5종·TRUSTED_BASE.md 누락 및 AGPL-3.0-only ELF 미배포) · Gate 4 (공정·개입): FAIL (153,682줄 ComparatorChallenge TCB 편입·enable_nanoda:false·PR #2의 README 67줄 고지 삭제) · Gate 5 (수리 가치): PASS $\implies$ OPFF TIER C (조건부 기계 검증 코어 인정 / 엔드투엔드 바이너리·양자내성 표방 대비 기준 미충족 아티팩트 / Conditional Verification & Non-Conforming Artifact) |



### 0.1 8대 핵심 지표 요약표 (8-Metric Executive Scorecard)

| 감사 축 | 원고 및 공개 문서 표방 내용 | 실제 저장소(Lean 4 / Arm64 / CLI / comparator) 실측치 | 괴리율 / 상태 |
| :--- | :--- | :--- | :---: |
| 1. 빌드·코드 도달성 | 11,323개 파일 · 7,528,295줄 전체 검증 | 기본 lake build에서 CliElfLib(120개·85,249줄) 등 592개 모듈(267,194줄) 제외; 6대 헤드라인 미도달 1,450개 파일(595,231줄) | 미도달 595,231줄 |
| 2. 바이너리 Hook 절단면 | 컴파일된 AArch64 libsignal-cli 기계어 정밀 검증 | 추적 경계 심볼 64개 중 55개(85.94%) 기계어 미실행 우회(37개 Lean 함수 훅 + 18개 패닉; Drop::drop 영점화 2개 포함, 실제 실행은 9개 = 14.06%) | 85.94% Hook 우회 |
| 3. 최하위 ISA·시스콜 TCB | AArch64 명령어 및 리눅스 시스콜 정식 모델링 | `Arm64/Trusted/` 61개 파일(16,767줄) 증명 정리 0건; `Hoare.lean`(`Spec`/`SubroutineOutcome`/`reaches_outcome`)은 `.Exception` 177개를 fail-closed 배제하면서 `Spec.allowOom`으로 `.OutOfMemory`만 면책; 리눅스 시스콜 31 / 301+만 구현; `AT_RANDOM` 16B 0 초기화 | 무증명 TCB 16,767줄 |
| 4. Rust CLI 하네스 제약 | 실제 Signal 세션·프리키·난수·저장소 동작 검증 | [coins.rs](../proofs/oai_ref/third_party/libsignal/libsignal-session/cli/src/coins.rs#L32-L46) 부족분 0 패딩 CryptoRng, 시계 UNIX_EPOCH = 0 고정(30일 SPK 만료 우회), Waker::noop() 단일 폴링, EBADF = 9 침묵 EOF | 하네스 환경 고정 |
| 5. comparator 심판기 경계 | 독립 심판기가 명세·공리 변형을 외부에서 차단 | ComparatorChallenge가 326개 파일(153,682줄)을 TCB에 편입; "enable_nanoda": false; Linux 5.10 < 5.13 비샌드박스 빌드; PR #2에서 한계 고지 67줄 삭제 | TCB 153,682줄 편입 |
| 6. 양자내성 및 PQXDH 상계 | PQXDH + SPQR V1 하이브리드 프로토콜 안전성 | 계산적 정리는 고전 안전성 전용(DEV-PQ19); [PQXDH.md](../proofs/oai_ref/Computational/docs/PQXDH.md#L69-L112) q_total = 2^40에서 표준 모델 GapDH 제5항 17,441 / 16,384 > 1 공허화(q_total <= 2^24 후퇴) | 2^40 상계 공허화 |
| 7. 세션 MAC·프리키 절벽 | 다중 에포크 래칫 및 프리키 누적 운용 보장 | 8바이트 MAC 상계(DEV-C14) q = 35,211에서 > 1 공허화(DEVIATIONS.md:2733에 구수치 38,967 오기재); .base-keys 56,680회(> 2 MiB) 직후 영구 거부(DoS) | 35,211 / 56,680 절벽 |
| 8. 재현성·위생 스크립트 | 자체 점검 스크립트 및 아티팩트 완비 | [check_refinement_hygiene.sh](../proofs/oai_ref/Symbolic/scripts/check_refinement_hygiene.sh#L121-L136) --self-test 7/14 사멸 항목으로 실패(종료 코드 1); 감사 스크립트 5종·TRUSTED_BASE.md 미수록(0/6); AGPL-3.0-only ELF 미커밋 | 자가점검 실패 / 미수록 |



### 0.2 3단 신호등 범위 요약표 (Traffic-Light Scope Summary)

| 등급 | 검증 영역 및 산출물 범위 | 정밀 판정 및 수리·형식검증 상태 |
| :--- | :--- | :--- |
| Tier 1<br>(유효 확인된 형식검증 자산) | • 추상 계산적 게임 감축(Computational/Proofs, ACD19 + SPQR V1 고전 비퇴행 감축)<br>• 기호 트레이스 불변량(Symbolic/Proofs) 및 9개 de-hook 심볼(mallocng 할당·해제·memcpy·memset·파일 읽기)의 배치 AArch64 기계어 정제 증명<br>• 본 감사단 독립 Lean 4 재검증 정리 81개(1,457줄, 0 sorry, 391/391 가설 변이 포착) | Gate 5 (수리 가치): PASS: 대규모 AArch64 명령어 상태 전이 및 프로토콜 게임 감축을 Lean 4 커널 안에서 연결한 컴퓨터 보조 형식검증 코어의 기술적 성취 확인 |
| Tier 2<br>(조건부 전제·하네스 고정 인터페이스) | • 55 / 64(85.94%, PR #2 이후 45 / 64 = 70.31%) 외부·런타임 심볼 Hook 절단면(26개 암호·`Drop::drop` 영점화 훅 전량 이상화 함수 대체)<br>• `Arm64/Trusted/` 61개 파일(16,767줄) 무증명 ISA·시스콜 공리계 및 `Hoare.lean` fail-closed `.Exception` 제한(`Spec`/`reaches_outcome`)·`Spec.allowOom` `.OutOfMemory` 면책<br>• `coins.rs` 0 패딩 난수원, `UNIX_EPOCH = 0` 고정 시계, `ValidCall` 5대 트레이스 제약, 1 GiB 피크 메모리 및 `FdsHiFrame`(`fd >= 3` 닫힘) 전제 | 조건부 유효 (Conditional Scope): 프로덕션 Signal 앱이나 임의 리눅스 프로세스가 아니라, 이상화된 훅과 고정 테스트 하네스 전제 위에서만 성립하는 조건부 정리 |
| Tier 3<br>(원고-아티팩트 불일치 및 기준 미충족 경계) | • ComparatorChallenge의 326개 파일(153,682줄) TCB 역임포트, "enable_nanoda": false, Linux 5.10 비샌드박스 실행 및 PR #2의 comparator/README.md 67줄 고지 삭제<br>• PQXDH.md q_total = 2^40 표준 모델 GapDH 공허화(17,441 / 16,384 > 1), DEV-C14 8바이트 MAC q = 35,211 공허화(38,967 오기재), .base-keys 56,680회 영구 거부 절벽<br>• 기본 lake build의 CliElfLib(85,249줄) 제외, check_refinement_hygiene.sh --self-test 실패, 감사 스크립트 5종·TRUSTED_BASE.md·AGPL-3.0-only ELF 미수록 | Gate 2·3·4: FAIL: 원고·헤드라인 표방과 실제 실행 아티팩트·신뢰 기반 경계 사이의 불일치로 인해 무수정 게재 기준 미충족 |



## 제1부. 문서·편차 원장 정합성 및 참조 누락 감사 (Documentation Ledger & Attribution Audit)

### 1.1 DEVIATIONS.md 편차 집계 불일치 및 인라인 범위 제한 태그 전수 센서스

1. DEVIATIONS.md 요약표(207건) 대 실제 활성 섹션(206건) 대 미등재 인라인 태그(+4건 = 210건) ([thm_05_deviations_ledger_off_by_one_and_undocumented_tags](../proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean#L87)):
   - [DEVIATIONS.md](../proofs/oai_ref/Computational/docs/DEVIATIONS.md#L103-L117) 상단 요약표(`L109` AEAD 행 `15`건, `L116` 전체 합계 `207`건; `L105`는 `SM = 27`)는 하단 `L3571`(`## Retired IDs`)에서 `DEV-AEAD15`가 퇴역 처리되었음에도 차감되지 않아 실제 활성 `### DEV-*` 섹션 헤더(206건, AEAD 14건)와 1건 어긋남.
   - 반대로 .lean 소스 코드 주석에 존재하는 인라인 `DEV-*` 식별자 4건(DEV-PQS-IDENTITY, 번호 없는 DEV-SM [L3609는 번호 붙은 구명칭 DEV-SMn만 언급], DEV-TR-NS, DEV-TR-OOO)은 DEVIATIONS.md에 개별 `### DEV-*` 섹션이 누락되어 있어 실제 편차 항목 합계는 206 + 4 = 210건임.
2. 코드 내 대괄호 범위 제한 태그 70건 분포 ([thm_06_inline_scope_disclaimer_tag_census](../proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean#L102)):
   - .lean 명세 파일 전반에 대괄호 범위 제한 태그 70건이 분포함: [INTENTIONAL_SCOPE] 30건 + [API_RESTRICTION] 15건 + [USER_VA_LIMIT] 10건 + [OVERPINNED_BEHAVIOR] 7건 + [INTENTIONAL_OVERAPPROX] 4건 + [PARTIAL_SPEC] 4건 (30 + 15 + 10 + 7 + 4 + 4 = 70).

### 1.2 본문 인용 감사 스크립트 5종 및 TRUSTED_BASE.md 미수록 (0 / 6 수록)

- 물증 좌표: [PAPER_MAP.md](../proofs/oai_ref/docs/PAPER_MAP.md#L1-L252), [DEVIATIONS.md](../proofs/oai_ref/Computational/docs/DEVIATIONS.md#L1-L120) 및 [thm_08_missing_audit_scripts_and_trusted_base_doc](../proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean#L137).
- 관측 사실: 공식 문서가 공리·신뢰 기반·무-sorry·반증·상계 임계치 검증 근거로 인용하는 아래 6개 핵심 감사 파일이 공개 저장소 트리에 수록되어 있지 않음(0 / 6 존재):
  | 번호 | 문서 내 인용 경로 | 문서가 표방한 역할 | 공개 저장소 수록 상태 |
  | :---: | :--- | :--- | :---: |
  | 1 | scripts/HeadlineAxioms.lean | 헤드라인 정리의 커널 공리 의존성 점검 | 미수록 (Missing) |
  | 2 | scripts/TrustedClosure.lean | 신뢰 기반(TCB) 역임포트 폐포 점검 | 미수록 (Missing) |
  | 3 | scripts/check_no_sorry.py | 저장소 내 sorry 토큰 부재 자동 검사 | 미수록 (Missing) |
  | 4 | scripts/bug_injection.py | 변이·버그 주입 반증 자동 실행기 | 미수록 (Missing) |
  | 5 | scripts/bound_thresholds.py | 암호 상계 공허화 임계치 수치 계산기 | 미수록 (Missing) |
  | 6 | Computational/docs/TRUSTED_BASE.md | 계산적 신뢰 기반(TCB) 명세 문서 | 미수록 (Missing) |



## 제2부. 후속 커밋 고지 삭제 및 미커밋 파생 산출물 감사 (Post-Release Notice Removal & Uncommitted Artifact Audit)

### 2.1 후속 PR #2 (b0f729accbc2)의 comparator/README.md 67행 한계 고지 삭제

- 물증 좌표: 초기 공개 커밋(808b4b7ffef1)의 [comparator/README.md](../proofs/oai_ref/comparator/README.md#L65-L131) (138줄) 대 후속 PR #2 커밋(b0f729accbc2, 2026년 11월 11일, 101줄).
- 관측된 상태 변화:
  - 초기 커밋의 comparator/README.md L65–L131에는 ## What this check does not cover 절(67행)이 존재하며, 특히 L112–L131에 (i) 해법 정교화(elaboration) 중 실행되는 코드가 챌린지 빌드 전에 챌린지 자체를 변경할 수 있다는 점("Code that runs while the solution is elaborated could change the challenge before it is built")과 (ii) Landlock 샌드박스는 Linux >= 5.13을 요구하나 GitHub On-Prem 러너 커널은 Linux 5.10이어서 landrun --best-effort가 아무것도 격리하지 못하고 comparator의 빌드와 내보내기가 비샌드박스(unsandboxed) 상태로 실행된다는 점이 명시되어 있었음.
  - 후속 PR #2(b0f729accbc2)에서 실제 커널 버전이나 "enable_nanoda": false 설정이 수리되지 않은 상태에서 위 ## What this check does not cover 절을 포함한 67행(L65–L131)이 삭제되어 138줄이 101줄로 축소됨.

### 2.2 AGPL-3.0-only 파생 ELF(617,448 B) 및 생성 Lean 파일의 .gitignore 미커밋 분리

- 물증 좌표: [third_party/libsignal/README.md](../proofs/oai_ref/third_party/libsignal/README.md#L12-L59), [CliElf.lean](../proofs/oai_ref/LibsignalBinary/Specifications/SignalSession/CliElf.lean#L71-L73) 및 [thm_81_uncommitted_agpl_elf_and_unreferenced_heap_brittleness](../proofs/deepmind_comparator_laundering_and_crypto_bounds.lean#L507).
- 관측된 상태 변화:
  - 바이너리 정제 정리들이 참조하는 .GeneratedLean/cli-elf/libsignal-cli.elf(617,448바이트, SHA-256: `2f20c836342437a882b5882c34eab604e4f23b2b388c2b2a0696eeda51cddc7e`)와 .GeneratedLean/ 하위 Lean 바이트 배열 파일들은 Signal의 AGPL-3.0-only 소스에서 파생되어 Apache-2.0 저장소에 커밋·수록되지 않고(미수록) .gitignore로 제외됨.
  - 또한 ELF 내부의 패닉 메타데이터 문자열이 Rust 소스 파일의 정확한 줄 번호를 품고 있어, 주석 한 줄만 추가되어도 바이너리 해시(2f20c836...)와 1,394개 하드코딩 PC 디코드 보조정리가 불일치하게 됨.



## 제3부. 테스트 하네스 환경 고정, 부팅 전 메모리 패치 및 링커 스텁 감사 (Harness Pinning & Pre-Boot Patch Forensics)

### 3.1 Rust CLI 하네스의 0 패딩 난수원·고정 시계·단일 폴링 실행기

- 물증 좌표: [coins.rs](../proofs/oai_ref/third_party/libsignal/libsignal-session/cli/src/coins.rs#L32-L46), [cli/src/lib.rs](../proofs/oai_ref/third_party/libsignal/libsignal-session/cli/src/lib.rs#L90-L250), [handshake/src/lib.rs](../proofs/oai_ref/third_party/libsignal/libsignal-session/cli/handshake/src/lib.rs#L33-L65), [ratchet/src/lib.rs](../proofs/oai_ref/third_party/libsignal/libsignal-session/cli/ratchet/src/lib.rs#L36-L68), [cli/io/src/lib.rs](../proofs/oai_ref/third_party/libsignal/libsignal-session/cli/io/src/lib.rs#L41-L58), [stores.rs](../proofs/oai_ref/third_party/libsignal/libsignal-session/cli/src/stores.rs#L361-L445) 및 [thm_78_rust_harness_zero_rng_and_frozen_epoch_bypass](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean#L418).
- 하네스 물리적 동작:
  1. 부족분 0 패딩 `CryptoRng` (`coins.rs:32-46`): 입력 난수 슬라이스가 소진되면 오류를 반환하지 않고 남은 출력 버퍼를 `dst[now.len()..].fill(0)`으로 채우며, `impl rand_core::CryptoRng for Coins` 마커 트레이트를 부여함.
  2. `UNIX_EPOCH = 0` 시계 고정 및 30일 만료 검사 우회 (`cli/src/lib.rs:140-250`, `DEV-PQ8`·`DEV-PQ9`): 모든 CLI 서브커맨드 호출 시각을 `SystemTime::UNIX_EPOCH`(`Timestamp::from_epoch_millis(0)`)로 고정하여 서명 프리키(SPK) 30일(`30 * 86,400 = 2,592,000`초) 만료 및 세션 노화 검사를 비활성화함.
  3. 단일 폴링 동기 실행기 (`Waker::noop()`) 및 `EBADF = 9` 침묵 처리: `Context::from_waker(Waker::noop())`로 async 프로토콜 함수를 1회 동기 폴링(`poll_once`, `handshake/src/lib.rs#L58-L65`, `ratchet/src/lib.rs#L61-L68`)하며, `cli/io/src/lib.rs`는 닫힌 파일 디스크립터 오류(`EBADF = 9`)를 정상 EOF(0바이트 읽기) 또는 쓰기 성공으로 처리하고 `stores.rs:373-374, 428-432`는 37바이트(`4B LE SignedPreKeyId + 0x05 + 32B 공개키`) `.base-keys` 레코드를 누적함.

### 3.2 부팅 전 `.data` 5바이트 덮어쓰기 및 `alink_check.py` `udf #0` 트랩 스텁

- 부팅 전 `.data` 5바이트 패치 ([Guards.lean#L140-L156](../proofs/oai_ref/LibsignalBinary/Specifications/LibsignalSpqrV1/Guards.lean#L140-L156), [CliBinaryPq.lean#L278-L280](../proofs/oai_ref/LibsignalBinary/Specifications/SignalSession/CliBinaryPq.lean#L278-L280), [thm_13](../proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean#L214), [thm_14](../proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean#L226)):
  - `Arm64/Trusted/ISA/Eval.lean`이 시스템 레지스터 읽기 명령(`MRS`)에서 `.Exception`으로 정지하므로, [Guards.lean](../proofs/oai_ref/LibsignalBinary/Specifications/LibsignalSpqrV1/Guards.lean#L140-L156)의 `token_cells_initial`(`0x9a038`의 `0xff`, `0x9a048`의 `[3,0,0,0]`)이 가리키는 `5`바이트를 [CliBinaryPq.lean](../proofs/oai_ref/LibsignalBinary/Specifications/SignalSession/CliBinaryPq.lean#L278-L280)의 `Placed.cliTokenPatchPlaced`가 부팅 전 0으로 덮어써 런타임 `cpufeatures`의 `getauxval(AT_HWCAP)` 호출 경로를 진입 전에 차단함.
- 링커 주소 격리 및 udf #0 스텁 (stock.ld:1-177, alink_check.py:21-31, [thm_12](../proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean#L199), [thm_79](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean#L439)):
  - [stock.ld](../proofs/oai_ref/third_party/libsignal/libsignal-session/cli-elf/stock.ld#L1-L177)는 `.text.hooked.*` 섹션을 진입점(e_entry) 아래의 :text_a 영역으로 분리하고, [alink_check.py](../proofs/oai_ref/scripts/stock-pin/alink_check.py#L21-L31)는 미정의 외부 심볼 및 약한 원자 연산 3종(displaced_weak)을 4바이트 미정의 명령어 트랩 udf #0(0x00000000) 스텁으로 배치함.



## 제4부. 증명 도달성 층서학, 바이너리 Hook 우회 단면 및 ComparatorChallenge TCB 감사 (Stratigraphy, Hook Cut-Plane & Comparator Audit)

### 4.1 저장소 빌드·도달성 분할 (11,323개 파일 · 7,528,295줄, [thm_01](../proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean#L25)~[thm_04](../proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean#L70), [thm_51](../proofs/deepmind_comparator_laundering_and_crypto_bounds.lean#L26))

| 계층 구분 | 파일 수 (비율) | 코드 줄 수 (비율) | 구조적 역할 및 도달성 상태 |
| :--- | :---: | :---: | :--- |
| 기본 lake build 타깃 (@[default_target]) | 10,722개 (94.69%) | 7,258,642줄 (96.42%) | Arm64, VerifiedLibraries, Computational, Symbolic 기본 빌드 대상 |
| 기본 빌드 제외 모듈 (8개 버킷) | 592개 (5.23%) | 267,194줄 (3.55%) | 배치 ELF 대표 정리(F3, C5)가 속한 CliElfLib 전용 120개 모듈(85,249줄) 포함 기본 빌드 제외 |
| 6대 대표 진입점 도달 폐포 (Reachable Cone) | 9,873개 (87.19%) | 6,933,064줄 (92.09%) | Main.lean, Lemmas.lean, ModelSecurity.lean, Refinement.lean, RefinementPreservation.lean, Security.lean 역임포트 도달 |
| 6대 대표 진입점 미도달 모듈 (Unreachable Strata) | 1,450개 (12.81%) | 595,231줄 (7.91%) | 모든 대표 정리와 단절된 미도달 모듈(LibsignalBinary/Heap/Fine/ 22개 미러 파일 포함) |

### 4.2 배치 ELF 경계 심볼 55 / 64 (85.94%) Hook 우회 단면 ([thm_09](../proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean#L154)~[thm_11](../proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean#L185))

- 물증 좌표: [CliRun.lean](../proofs/oai_ref/LibsignalBinary/Specifications/SignalSession/CliRun.lean#L1-L495), [CliBinaryPq.lean](../proofs/oai_ref/LibsignalBinary/Specifications/SignalSession/CliBinaryPq.lean#L137-L482).
- 경계 심볼 분할 (64개 추적 심볼):
  1. 기계어 실행(cliDehookedSymsPlaced): 9 / 64개 (14.06%): Rust 할당자 심볼 5개(__rust_no_alloc_shim_is_unstable_v2, __rust_alloc, __rust_dealloc, __rust_realloc, __rust_alloc_zeroed), memcpy, memset, read_file, read_stdin (PR #2 b0f729accbc2에서 비암호 헬퍼 10개 추가로 19 / 64 = 29.69%).
  2. 이상화 Lean 함수 대체(cliHookTablePlaced): 37 / 64개 (57.81%):
     - 암호·비밀소거·배리어 심볼 26개: 대칭 프리미티브 5개(compress256, compress512, libcrux_hmac::hmac, aes_256_cbc_encrypt, aes_256_cbc_decrypt) + 공개키·격자 연산 18개(curve25519_dalek 7, x25519_dalek 2, mlkem1024 2, mlkem768 7) + X25519 Drop::drop 비밀키 영점화(zeroize) 심볼 2개 + core::hint::black_box 1개 (PR #2 이후에도 26개 전량 우회 유지).
     - 비암호 I/O·메모리·포맷·시계 헬퍼 11개: write_file, write_stdout, memmove, bcmp, strlen, memrchr, from_utf8, core::fmt::write, format_inner, SystemTime::duration_since, SystemTime::add (PR #2에서 write_file 외 10개 de-hook).
  3. 패닉 트랩(cliPanicSymbolsPlaced): 18 / 64개 (28.13%): SIGABRT 종료 처리.
  - $\implies$ 합계 37 + 18 = 55 / 64개(85.94%, PR #2 기준 27 + 18 = 45 / 64 = 70.31%) 심볼이 AArch64 기계어를 실행하지 않으며, 특히 2개 Drop::drop 영점화 심볼이 우회되어 물리 RAM·스택·레지스터상의 비밀키 소거 여부는 검증되지 않음.

### 4.3 ComparatorChallenge의 153,682줄 TCB 편입 및 비샌드박스 실행 ([thm_52](../proofs/deepmind_comparator_laundering_and_crypto_bounds.lean#L42)~[thm_57](../proofs/deepmind_comparator_laundering_and_crypto_bounds.lean#L149))

- 물증 좌표: [computational.json](../proofs/oai_ref/comparator/computational.json#L1-L20), [symbolic.json](../proofs/oai_ref/comparator/symbolic.json#L1-L24), [Computational.lean](../proofs/oai_ref/comparator/ComparatorChallenge/Computational.lean#L1-L21), [Symbolic.lean](../proofs/oai_ref/comparator/ComparatorChallenge/Symbolic.lean#L1-L22), [run.sh](../proofs/oai_ref/comparator/run.sh#L44-L48).
- 관측 사실:
  1. ComparatorChallenge 루트 허브가 얇은 독립 명세 대신 구현 서브트리를 전이 임포트하여 326개 파일(153,682줄, ProofLib >= 92,732줄 포함)을 신뢰 기반(TCB)에 편입시킴(챌린지 스텁 343줄 대비 > 448배 TCB 팽창).
  2. 두 JSON 설정 파일 모두 "enable_nanoda": false로 외부 독립 커널 검증기를 비활성화함.
  3. run.sh:44-48은 landrun 실행 전에 샌드박스 바깥에서 lake build --no-ansi를 선행 실행하며, 러너 커널(Linux 5.10 < 5.13)에서 Landlock이 비활성화됨.
  4. JSON 검사 대상 24개(8 + 16) 중 배치 ELF·심볼 정리 3개가 중복 등록되어 실제 고유 검사 정리는 21개임.



## 제5부. 원고-아티팩트 불일치, 최하위 TCB 괴리 및 암호 상계 공허화 감사 (Paper–Artifact Divergence, TCB & Cryptographic Vacuity Audit)

### 5.1 최하위 신뢰 기반(Arm64/Trusted, 16,767줄) 무증명 상태 및 리눅스 시스콜 괴리 ([thm_26](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean#L24)~[thm_50](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean#L396))

| 감사 항목 (파일:행) | 상위 문서·명세 전제 | Arm64/Trusted/ 실제 코드 상태 | 검증 정리 |
| :--- | :--- | :--- | :--- |
| 1. Arm64/Trusted 증명 유무<br>(61개 파일 · 16,767줄) | AArch64 ISA 및 리눅스 시스콜 정식 검증 | 61개 파일(1,259개 선언) 전체에 theorem/lemma 0건; .Exception 177개 + .OutOfMemory 12개 + .trap 10개 = 199개 비정상 종료 분기 | [thm_26](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean#L24)~[thm_28](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean#L61) |
| 2. Hoare 사후조건 예외 트랩 (`fail-closed` vs 면책 OOM)<br>([Hoare.lean:124-222](../proofs/oai_ref/arm64-semantics/Arm64/Trusted/Spec/Hoare.lean#L124-L222)) | 서브루틴 호출 후 메모리·보안 불변량 유지 | `Spec`·`SubroutineOutcome`·`reaches_outcome`·`safe_until`은 `.Exception`을 배제(`fail-closed`, `177`개 미모델링 ISA·시스콜 분기가 검증 입력 도메인을 축소)하며, `Spec.allowOom`의 `onOom := ⌜True⌝` 또는 `CliReachesOOMPlaced`(`DEV-CLI15`)만 `.OutOfMemory`를 면책함 | [thm_30](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean#L92), [thm_31](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean#L109) |
| 3. 리눅스 시스콜 범위 및 AT_RANDOM<br>([Syscalls.lean:1-57](../proofs/oai_ref/arm64-semantics/Arm64/Trusted/Syscalls.lean#L1-L57), [Types.lean:120-121](../proofs/oai_ref/arm64-semantics/Arm64/Trusted/Process/Types.lean#L120-L121), [Loader.lean:377-427](../proofs/oai_ref/arm64-semantics/Arm64/Trusted/Process/Loader.lean#L377-L427)) | 리눅스 유저스페이스 실행 환경 모델링 | 301+개 AArch64 시스콜 중 31개만 구현(270+개는 `.Exception`); 프로세스 로더가 보조 벡터 `AT_RANDOM` 16바이트(128비트)를 전부 0으로 초기화 | [thm_29](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean#L78), [thm_32](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean#L126) |
| 4. mmap 고갈 시 동작<br>([Mmap.lean:176-202](../proofs/oai_ref/arm64-semantics/Arm64/Trusted/Syscalls/Mm/Mmap.lean#L176-L202)) | 리눅스 `mmap` 실패 시 `-ENOMEM(-12)` 반환 | `X0 = 0xfffffffffffffff4#64(-12)` 반환 대신 기계를 `.OutOfMemory`로 즉시 정지시켜 호출자의 NULL 포인터 역참조 경로가 OOM 면책 뒤에 가려짐 | [thm_33](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean#L146), [thm_45](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean#L331), [thm_46](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean#L344) |
| 5. `exit_group` 종료 코드 및 파일·시그널<br>([Exit.lean:1-44](../proofs/oai_ref/arm64-semantics/Arm64/Trusted/Syscalls/Kernel/Exit.lean#L1-L44), [ReadWrite.lean:110-189](../proofs/oai_ref/arm64-semantics/Arm64/Trusted/Syscalls/Fs/ReadWrite.lean#L110-L189), [ReadWritev.lean:100-119](../proofs/oai_ref/arm64-semantics/Arm64/Trusted/Syscalls/Fs/ReadWritev.lean#L100-L119), [Open.lean:163,249-250](../proofs/oai_ref/arm64-semantics/Arm64/Trusted/Syscalls/Fs/Open.lean#L163-L250), [Select.lean](../proofs/oai_ref/arm64-semantics/Arm64/Trusted/Syscalls/Fs/Select.lean#L1-L134)) | POSIX 종료 상태 및 표준 파일·시그널 의미론 | `Exit.lean`이 `X0 & 0xff` 하위 8비트 마스킹을 생략(`X0 = 256*m`에서 POSIX는 0, TCB는 비영 기록); `ReadWrite.lean`은 `read`/`write` 모두를 `0x7ffff000`으로 잘라내고 `ReadWritev.lean`은 초과 시 `.Exception` 발생; `Open.lean`은 비-`0o600` `O_CREAT`에서 트랩하고 기존 `FsState` 권한 비트를 생략; `Select.lean` `fd >= 3` `ppoll` 트랩; 27개 시스콜 전체 `-EINTR` 0건; 동기 폴트 시 `rt_sigaction` 미호출; Sail/Unicorn 시험([TESTING.md:124-132](../proofs/oai_ref/arm64-semantics/Arm64/TESTING.md#L124-L132))에서 결함 상태(1, 13) 및 DC ZVA·ADDV 건너뛰기 | [thm_35](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean#L174)~[thm_44](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean#L291), [thm_79](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean#L439) |

### 5.2 암호·프로토콜 상계 공허화 및 문서-코드 수치 불일치 (Paper–Artifact Divergence)

| 불일치 및 공허화 축 | 문서(DEVIATIONS.md / PQXDH.md / PAPER_MAP.md) 기재 내용 | 실제 활성 코드 및 대수적 실측 결과 | 검증 정리 |
| :--- | :--- | :--- | :--- |
| 1. DEV-C14 8바이트 MAC 공허화 임계치 오기재<br>([DEVIATIONS.md:2712-2733](../proofs/oai_ref/Computational/docs/DEVIATIONS.md#L2712-L2733) 대 [StatementComposed.lean](../proofs/oai_ref/Computational/Specifications/Session/StatementComposed.lean#L1-L545)) | DEVIATIONS.md:2733은 합성 게임 DEV-C14의 $2^{-32}$ 및 공허화($> 1$) 임계치를 DEV-LS31과 동일한 q = 9,459 (qep = 0) 및 q = 38,967 (qep = q)로 기재 | DEV-C14 분자식 $12q^4 + 56q^3 + 96q^2 + 56q$는 DEV-LS31보다 $4q(q^3 + 2q^2 + 6q - 10) > 0$만큼 커서 실제로는 q = 7,327 (qep = 0)에서 $2^{-32}$를 넘고 q = 35,211 (qep = q)에서 이미 $18,448,187,719,356,341,620 > 2^{64}$로 확률 상계 1을 초과해 공허화됨(3,756회 조기 공허화) | [thm_59](../proofs/deepmind_comparator_laundering_and_crypto_bounds.lean#L197)~[thm_64](../proofs/deepmind_comparator_laundering_and_crypto_bounds.lean#L279) |
| 2. `PQXDH.md` $q_{\mathrm{total}} = 2^{40}$ 표준 모델 GapDH 공허화 및 고전 전용 범위<br>([PQXDH.md:69-136](../proofs/oai_ref/Computational/docs/PQXDH.md#L69-L136), `DEV-PQ19`) | PQXDH + SPQR 하이브리드 핸드셰이크 및 대규모($2^{40}$) 세션 보안 | 계산적 정리는 고전 안전성만 증명(`DEV-PQ19`, 양자 적대자 미포함)하며, 4-leg GapDH 계수 합 $c_3 = \frac{17441}{16384}\cdot 2^{60}$으로 인해 제5항이 $q_{\mathrm{total}} \ge 1,081,110,205,009 \approx 2^{39.98}$에서 `1`을 넘고 $q_{\mathrm{total}} = 2^{40}$에서 `17441 / 16384 > 1`로 공허화되어 $q_{\mathrm{total}} \le 2^{24}$ 이하로 구체적 보안 구간이 축소됨(`PQXDH.md:107-115`, `136` 수작업 계산 시인). 또한 단일 키 X25519+XEdDSA의 `GapSigEufCma`·`GapDhWithSign` 분리 및 독립 `XeddsaRom/` Forking-Lemma 손실(`DEV-PQ13`)은 TCB 외부에 남고, `DEV-PQ16`은 `P.isCanonical` 소수 위수 부분군 가드를 강제(`is_torsion_free` 훅 처리)하는 반면 `DEV-PQ17`은 코팩터-8 `P.pow8`로 감축하여 $O(q_{\text{total}}^2)$ DDH 예산을 요구함 | [thm_77](../proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean#L457), [thm_80](../proofs/deepmind_comparator_laundering_and_crypto_bounds.lean#L484) |
| 3. .base-keys 56,680회 영구 거부(DoS) 절벽<br>([PqDir.lean:1-463](../proofs/oai_ref/LibsignalBinary/Specifications/SignalSession/PqDir.lean#L1-L463), DEV-CLI21) | 지속적인 최후수단(last-resort) Kyber 프리키 중복 제거 및 세션 수립 | .base-keys 파일이 키당 37바이트를 추가 전용으로 기록하여 $37 \times 56,679 = 2,097,123 \le 2^{21}$ 직후 56,680번째 핸드셰이크($37 \times 56,680 = 2,097,160 > 2,097,152$ B)에서 fileCapBytes = 2 MiB 상한을 넘고, 56,681번째 핸드셰이크부터 미회전 최후수단 Kyber 프리키 수락이 영구 거부됨 | [thm_66](../proofs/deepmind_comparator_laundering_and_crypto_bounds.lean#L322), [thm_67](../proofs/deepmind_comparator_laundering_and_crypto_bounds.lean#L338) |
| 4. Cheval '26 기호 반증 재조준 불일치 및 38개 sorry 잔존<br>([PAPER_MAP.md:216-238](../proofs/oai_ref/docs/PAPER_MAP.md#L216-L238)) | T-12(d): 기호 반증 증인들이 각 취약점의 공격 트레이스를 기계 검증함 | Cheval '26 CLI 반증 4개 중 2개([Cheval26SmallSubgroupTorsionCli.lean](../proofs/oai_ref/Symbolic/BugInjection/Disproofs/Cheval26SmallSubgroupTorsionCli.lean#L83-L93), [Cheval26WeakStateCli.lean](../proofs/oai_ref/Symbolic/BugInjection/Disproofs/Cheval26WeakStateCli.lean#L88-L98))는 고유 공격 트레이스 증명 없이 타 운반체 정리를 재사용하며, Symbolic/BugInjection/Synthetic/Disproofs/ 10개 파일은 전원 sorry 미완성 상태임(저장소 전체 sorry 38건 = 챌린지 스텁 24 + 합성 반증 10 + 픽스처 4) | [thm_07](../proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean#L119), [thm_55](../proofs/deepmind_comparator_laundering_and_crypto_bounds.lean#L95) |



## 제6부. 유효 증명 코어(Gate 5: PASS) 공인, 독립 재검증 및 대안 수리 명세 (Constructive Verification & Repair)

### 6.1 컴퓨터 보조 형식검증 코어(Gate 5: PASS)의 수리·공학적 유효성 공인

- 위 조건부 전제 및 TCB 경계와 독립적으로, 다음 두 가지 핵심 형식검증 성취는 Lean 4 커널 안에서 유효하게 작동함을 확인하고 공인함(Gate 5: PASS):
  1. 게임 기반 계산적 감축 및 기호 정제 파이프라인: ACD19 이중 래칫과 SPQR V1 포스트양자 브리지를 결합한 다단계 게임 변환(Computational/Proofs) 및 기호 트레이스 정제(Symbolic/Proofs)가 실제 Lean 4 커널 타입 검사를 통과함.
  2. 배치 AArch64 기계어 슬라이스 및 mallocng 정제: cliDehookedSymsPlaced에 속한 9개 심볼(mallocng 할당·해제 및 메모리·읽기 루틴, PR #2 이후 19개)에 대해 실제 배치된 ELF 기계어 명령어 시퀀스의 상태 전이와 힙 불변량이 형식 검증됨.

### 6.2 OPFF 독립 Lean 4 재검증(81개 정리, 391/391 변이 포착) 및 구조적 수리 대안

1. 반사(Reflection) 기반 기본 블록 디코더 테이블 압축으로 18,373줄(94.14%) 증명 절감 ([thm_20](../proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean#L348)~[thm_23](../proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean#L381)):
   - 고유 주소 $k = 1,023$개와 중복 호출 지점 $d = 371$개($k + d = 1,394$)마다 14줄짜리 `*_decode_0x...` 보조정리를 반복 생성하는 기존 구조(`14 * 1,394 = 19,516`줄)를 120줄 공통 반사 검증기와 주소당 1줄 룩업 테이블(120 + 1,023 = 1,143줄)로 교체하면 19,516 - 1,143 = 18,373줄(94.14%)이 절감되고 중복 주소 증명 파손이 제거됨:
     $$14(k + d) - (120 + k) = 13k + 14d - 120 = 18,373$$
2. 16바이트(128비트) 와이어 MAC 태그 확장을 통한 단일 세션 공허화 완전 제거 ([thm_65_rigidity_16byte_mac_eliminates_u32_session_vacuity](../proofs/deepmind_comparator_laundering_and_crypto_bounds.lean#L300)):
   - 와이어 MAC 태그 길이를 8바이트($2^{64}$)에서 16바이트($2^{128}$)로 확장하면 DEV-C14 공허화 임계점이 q = 35,211에서 q = 2,307,621,357 > q_u32_max = 2,147,471,145로 이동하여, u32 래칫 카운터가 도달할 수 있는 전 구간에서 단일 세션 MAC 공허화가 원천 소멸함.
3. 5대 필수 아키텍처 수리 명세:
   - ① ComparatorChallenge에서 153,682줄 구현 트리 임포트를 제거하고 순수 명세 인터페이스만 남기며, "enable_nanoda": true 및 Linux >= 5.13 샌드박스 격리 활성화(삭제된 comparator/README.md 67줄 한계 고지 복원),
   - ② lakefile.lean 기본 @[default_target]에 CliElfLib(120개 모듈) 편입 및 check_refinement_hygiene.sh의 사멸 정리 7건·LC_ALL=C 정렬 오류 수리,
   - ③ DEVIATIONS.md:2733의 DEV-C14 임계치를 실제 값(q = 7,327 및 q = 35,211)으로 정정하고 미수록 감사 스크립트 5종·TRUSTED_BASE.md 공개,
   - ④ Arm64/Trusted/Syscalls/Mm/Mmap.lean의 .OutOfMemory 정지를 리눅스 표준 -ENOMEM(-12) 반환으로 교정하고 Drop::drop 영점화 심볼 2개를 de-hook하여 실제 스택·레지스터 소거 검증,
   - ⑤ 초록·서론·헤드라인 정리 표제에 [Conditional on 85.94% Symbol Hooks, 16,767-Line Unproved Arm64/Trusted TCB, Classical-Only DEV-PQ19, and q < 35,211 / 56,680 Operational Bounds] 조건부 범위를 명시.



## 제7부. 국제 학술기준 대비 불부합 대조표, 예상 반론 사실 확인 및 최종 판정 (OPFF Standard-Bound Verdict)

### 7.1 국제 출판·형식검증 가이드라인 대조표 (COPE · IMU/AMS · ACM v1.1 · ICMJE/CRediT · NeurIPS)

| 국제 표준 대비 불부합 범주 | 준거 국제 가이드라인 조항 | 대상 저장소 확정 좌표 및 물리적 관측 수치 | 최종 판정 |
| :--- | :--- | :--- | :---: |
| 원고-아티팩트 불일치 (Paper–Artifact Divergence / Gate 2) | ACM Artifact Review v1.1 / COPE Core Practices (표방된 검증 범위·수치와 실제 실행 아티팩트의 1대1 정합성 요건) | • 경계 심볼 55 / 64(85.94%, 암호·Drop::drop 영점화 26개 전량 포함)가 기계어 실행 대신 Lean 함수 훅으로 우회됨<br>• 기본 lake build가 CliElfLib(85,249줄) 등 592개 모듈을 제외하며, DEVIATIONS.md:2733의 DEV-C14 임계치(38,967)가 실제 코드 임계치(35,211)와 불일치함<br>• PQXDH.md q_total = 2^40에서 표준 모델 GapDH 항이 17,441 / 16,384 > 1로 공허화되고 고전 안전성(DEV-PQ19)만 증명됨 | 불일치 (Paper–Artifact Divergence) |
| 프로비넌스·심판기 경계 미충족 (Provenance & TCB Non-Conformance / Gate 1·4) | IMU/AMS / NeurIPS Code & Data Guidelines (독립 검증기 TCB 격리 및 한계 고지 보존 요건) | • `ComparatorChallenge`가 326개 파일(153,682줄)을 TCB에 편입시키고 `"enable_nanoda": false` 및 Linux 5.10 비샌드박스 상태로 동작함<br>• 후속 PR #2(`b0f729accbc2`)에서 `comparator/README.md`의 비샌드박스·챌린지 변경 가능성 고지 67줄(`L65–L131`)이 삭제됨<br>• `Arm64/Trusted/` 61개 파일(16,767줄)에 증명 정리가 0건이며 `Hoare.lean`은 `.Exception` 177개를 fail-closed로 배제(비모델링 경로 도달 불가 증명 필요)하면서 `Spec.allowOom`으로 `.OutOfMemory`를 면책함 | 기준 미충족 |
| 참조 아티팩트 미수록 (Artifact Omission Deficit / Gate 3) | ACM Reproducibility / COPE Citation & Data Guidelines (본문 인용 검증 스크립트 및 대상 바이너리 공개 요건) | • 문서가 인용하는 감사 스크립트 5종(HeadlineAxioms.lean 등)과 TRUSTED_BASE.md가 저장소에 미수록(0 / 6)됨<br>• check_refinement_hygiene.sh --self-test가 7/14 사멸 항목으로 실패하며, 617,448 B AGPL-3.0-only 파생 ELF가 미커밋 상태임 | 아티팩트 결손 (Artifact Omission) |

### 7.2 인간 · 컴퓨터 보조 형식검증(ITP) · 자동 에이전트 파이프라인 3층 기여도 분리

1. 인간 선행 암호학·명령어 명세 자산 없이는 성립 불가능한 기반 (단독 AI 해결 가능성 0%):
   - 본 저장소의 보안 게임 구조와 기호 추적 모델은 인간 암호학자들이 확립한 Alwen–Coretti–Dodis (ACD19, 이중 래칫), Kret–Schmidt (PQXDH), Bhargavan et al. / Cheval et al. (ProVerif 기호 모델), 그리고 ARM 아키텍처 참조 매뉴얼(Sail AArch64 ISA 명세) 및 Signal 재단의 libsignal Rust/C 코드베이스 위에서만 성립합니다. 인간이 구축한 이 5대 선행 자산과 Arm64/Trusted 수동 TCB 설계(16,767줄) 없이는 AI 단독으로 증명 명세 자체를 정의할 가능성은 0%입니다.
2. 전통적 컴퓨터 보조 형식검증(인간 명세 설계 + Lean 4 전술 자동화)으로 유효한 코어 (Gate 5: PASS):
   - 인간 연구진이 설계한 Hoare 삼중항 프레임워크(ProofLib)와 게임 감축 골격 위에서, AI 에이전트와 자동 생성기가 1,394개 PC 디코드 보조정리와 470,030개 스택 오프셋(sp) 전달 증명 등 반복적인 어셈블리·힙 상태 전이 보일러플레이트를 대량 생성해 커널 검사를 통과시킨 부분은 유효한 엔지니어링 성과입니다.
3. 자동 생성·포장 파이프라인에서 발생한 기준 미충족 (Gate 2~4: FAIL):
   - 자동화된 증명·패키징 파이프라인이 ① 해결되지 않은 26개 암호·Drop::drop 영점화 심볼을 Hook 테이블 뒤로 우회시키고, ② ComparatorChallenge가 153,682줄 구현 트리를 TCB로 역임포트하도록 구성하며, ③ Symbolic/BugInjection/Synthetic/Disproofs/ 10개 파일에 미완성 sorry를 남기고, ④ 후속 PR #2에서 comparator/README.md의 비샌드박스 한계 고지 67줄을 삭제함으로써, 유효한 조건부 형식검증 코어와 대외 표방("Signal 보안의 엔드투엔드 형식검증") 사이에 구조적 불일치를 발생시켰습니다.

### 7.3 예상 반론에 대한 사전 사실 확인 (Pre-bunking FAQ 6문 6답)

- Q1. "후속 PR #2(b0f729accbc2)에서 훅 10개를 제거해 de-hook 심볼을 9개에서 19개로 늘렸으니 훅 우회 문제는 해소된 것 아닌가?"
  - 사실 확인: PR #2가 de-hook한 10개 심볼은 모두 비암호 메모리·문자열·포맷·시간 보조함수(memmove, strlen 등)입니다. Curve25519, SHA-256/512, HMAC, AES-256-CBC, ML-KEM-768/1024 및 2개의 X25519 Drop::drop 비밀키 영점화 심볼을 포함한 26개 암호·비밀소거·배리어 훅은 PR #2 이후에도 100% 기계어 실행을 우회합니다([thm_11](../proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean#L185)).
- Q2. "모든 편차와 한계가 DEVIATIONS.md(206개 섹션)에 이미 투명하게 문서화되어 있지 않은가?"
  - 사실 확인: DEVIATIONS.md가 상세한 편차 기록을 담고 있는 점은 긍정적이나, ① 요약표(207건)와 실제 활성 섹션(206건) 및 미등재 인라인 태그(4건)가 어긋나고([thm_05](../proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean#L87)), ② DEVIATIONS.md:2733의 DEV-C14 공허화 임계치(38,967)가 실제 코드 임계치(35,211)보다 3,756회 높게 잘못 기재되어 있으며([thm_64](../proofs/deepmind_comparator_laundering_and_crypto_bounds.lean#L279)), ③ 무엇보다 후속 PR #2에서는 오히려 comparator/README.md의 핵심 샌드박스·TCB 한계 고지 67줄(L65–L131)이 삭제되었습니다.
- Q3. "기계어 검증에서 하드웨어 ISA와 OS 시스콜 계층(Arm64/Trusted)을 TCB로 두는 것은 표준적인 관행 아닌가?"
  - 사실 확인: ISA·시스콜 명세를 TCB로 두려면 그 명세가 실제 커널·하드웨어 의미론을 과대근사 없이 충실히 반영해야 합니다. 그러나 `Arm64/Trusted`는 `mmap` 실패 시 `-ENOMEM` 반환 대신 `.OutOfMemory`로 정지해 호출자의 `NULL` 역참조를 가리고([thm_33](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean#L146), [thm_46](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean#L344)), `Hoare.lean`은 `.Exception` 177개 분기를 fail-closed로 배제(검증된 입력 영역 제한)하면서 `Spec.allowOom`으로 `.OutOfMemory`를 면책하며([thm_30](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean#L92)), Sail 차등 시험조차 결함 상태(1, 13)를 건너뜁니다([thm_79](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean#L439)).
- Q4. "외부 comparator 심판기가 통과했으니 명세 왜곡이나 공리 오염이 없는 것 아닌가?"
  - 사실 확인: ComparatorChallenge 자체가 326개 구현 파일(153,682줄)을 전이 임포트해 TCB 안으로 끌어들였으며([thm_53](../proofs/deepmind_comparator_laundering_and_crypto_bounds.lean#L60)), "enable_nanoda": false로 독립 커널 검증기를 끄고 Linux 5.10 러너에서 비샌드박스 상태로 빌드를 수행합니다.
- Q5. "PQXDH와 SPQR V1이 결합되었으니 양자 컴퓨터 공격(HNDL)에 대한 안전성이 증명된 것 아닌가?"
  - 사실 확인: DEVIATIONS.md DEV-PQ19가 명시하듯 계산적 보안 정리는 고전(classical) 가정만 증명하며, PQXDH.md의 표준 모델 GapDH 상계조차 q_total = 2^40에서 제5항 분자(17,441)가 분모(16,384)를 초과해(17,441 > 16,384, 확률 상계 > 1) 공허화되어 q_total <= 2^24 이하로 축소됩니다([thm_80](../proofs/deepmind_comparator_laundering_and_crypto_bounds.lean#L484)).
- Q6. "저장소에 752만 줄의 Lean 4 코드가 있다는 것 자체가 완전 자동 검증의 증거 아닌가?"
  - 사실 확인: 기본 lake build는 배치 ELF 헤드라인이 속한 CliElfLib(120개 모듈, 85,249줄) 등 592개 모듈(267,194줄)을 빌드에서 제외하며([thm_02](../proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean#L38), [thm_04](../proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean#L70)), 6대 헤드라인 어디에서도 도달하지 않는 미도달 파일이 1,450개(595,231줄) 존재합니다([thm_51](../proofs/deepmind_comparator_laundering_and_crypto_bounds.lean#L26)).

### 7.4 10초 터미널 재현 명령어

```bash
# 1) 83종 보존 원문 실시간 파싱, SymPy 다항식 검산 및 81개 Lean 4 정리 통합 검증 (EXIT 0)
python3 -B proofs/verify_symbolic_deepmind_signal.py

# 2) 7종 산출물 SHA-256 체크섬 및 391/391 가설 돌연변이 사살·#L 라인 링크 전수 검증 (EXIT 0)
sha256sum -c proofs/checksums.sha256 && python3 -B ../../tools/verify_all.py --root .
```

### 7.5 최종 심사 판정문 (Formal OPFF Referee Verdict Box)

- 최종 공식 판정: OPFF TIER C (Conditional Verification & Non-Conforming Artifact): 조건부 범위 명시, `ComparatorChallenge` TCB 분리 및 미수록 검증 스크립트 공개 전 무수정 게재 불가
- Google DeepMind의 AlphaProof Code (`code-verification`) 저장소(11,323개 파일, 7,528,295줄)는 추상 프로토콜 게임 감축과 일부 배치 AArch64 기계어 슬라이스(`mallocng` 등 9개 심볼)를 Lean 4 커널 안에서 연결한 유효한 컴퓨터 보조 형식검증 코어(Gate 5: PASS)를 포함하고 있다. 그러나 (1) 외부·런타임 경계 심볼 55 / 64(85.94%, 암호 연산 및 `Drop::drop` 비밀키 영점화 26개 전량 포함)의 기계어 미실행 Hook 우회와 기본 `lake build`의 `CliElfLib`(85,249줄) 제외, (2) 무증명 16,767줄 `Arm64/Trusted` TCB(177개 fail-closed `.Exception` 제한 및 `Spec.allowOom` `.OutOfMemory` 면책), 리눅스 시스콜(`mmap` `.OutOfMemory`, `AT_RANDOM` 0 초기화, `Exit` 미마스킹) 및 고정 테스트 하네스(`coins.rs` 0 패딩, `UNIX_EPOCH = 0` 고정 시계) 괴리, (3) `ComparatorChallenge`의 326개 파일(153,682줄) TCB 편입, `"enable_nanoda": false`, Linux 5.10 비샌드박스 실행 및 후속 PR #2의 `comparator/README.md` 67줄 고지 삭제, (4) `PQXDH.md` $q_{\mathrm{total}} = 2^{40}$ 표준 모델 GapDH 공허화($17,441 / 16,384 > 1$, 고전 전용 `DEV-PQ19`), `DEV-C14` 8바이트 MAC의 $q = 35,211$ 공허화(38,967 오기재), `.base-keys` 56,680회 영구 거부 절벽 및 본문 인용 감사 스크립트 6종 미수록으로 인해 OPFF 5대 관문 심사에서 OPFF TIER C (Conditional Verification & Non-Conforming Artifact)로 판정한다.
