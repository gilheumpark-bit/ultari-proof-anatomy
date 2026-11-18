# Forensic & Referee Audit Report: Google DeepMind AlphaProof Code (code-verification, Formally Verifying Signal's Security Using AI, 커밋 808b4b7ffef1) 전수 감사 보고서

## 0. 감사 메타데이터 및 암호학적 봉인 원장

| 항목 | 세부 내역 |
| :--- | :--- |
| 대상 논문 / 공개 발표 | Formally Verifying Signal's Security Using AI (2026년 10월 26일 초안, 2026년 11월 10일 Google DeepMind `AlphaProof Code` 공식 공개 [`Gemini 4 Carbon` 증명 생성 · `Claude Opus 5.5` 명세 교차 검토], 동반 기술 문서 [DEVIATIONS.md](../proofs/oai_ref/Computational/docs/DEVIATIONS.md#L1-L3617) 3,617줄, [PAPER_DIFFERENCES.md](../proofs/oai_ref/docs/Symbolic/PAPER_DIFFERENCES.md#L1-L337) 337줄, [READING_THE_THEOREMS.md](../proofs/oai_ref/Computational/docs/READING_THE_THEOREMS.md#L1-L330) 330줄, [PQXDH.md](../proofs/oai_ref/Computational/docs/PQXDH.md#L1-L136) 136줄, [PAPER_MAP.md](../proofs/oai_ref/docs/PAPER_MAP.md#L1-L252) 252줄) |
| 대상 코드 저장소 및 커밋 | Google DeepMind AlphaProof Code (`google-deepmind/code-verification`, `libsignal v0.105.4` 대상 ~650만 줄 증명 포함 총 11,323개 `.lean` 파일 · 7,528,295줄: 임포트 가능 모듈 11,314개 7,525,836줄 + Lake 빌드 파일 9개 2,459줄; 초기 커밋 `808b4b7ffef198e6a91f71ed776d641a1c236882` 및 11월 11일 PR #2 커밋 `b0f729accbc2`) |
| 동반 바이너리 / 비교 챌린지 | 정적 링크 AArch64 ELF .GeneratedLean/cli-elf/libsignal-cli.elf (617,448바이트, SHA-256: `2f20c836342437a882b5882c34eab604e4f23b2b388c2b2a0696eeda51cddc7e`, AGPL-3.0-only 파생물로 저장소 미커밋·미수록) / comparator 챌린지 스텁 8개 파일(343줄, JSON 항목 8 + 16 = 24건 $\to$ 고유 정리 21건) |
| 툴체인 및 컴파일러 | Lean 4 v4.29.0-rc8 (leanprover/lean4:v4.29.0-rc8) / Python 3.14 (SymPy 기호 연산기 및 실시간 원문 파서) |
| 검증 산출물 SHA-256 | • [deepmind_signal_stratigraphy_and_hook_boundary.lean](../proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean): `e58829f52915609cee169645f20d5501627bd0979309d4fdbc6f372099fc3dc1`<br>• [deepmind_arm64_tcb_and_syscall_divergences.lean](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean): `109d9e94c2165d3058828609c085ac7647c20492147880cd92440df52856b8f1`<br>• [Comparator TCB & Crypto Bounds Module](../proofs/deepmind_comparator_laundering_and_crypto_bounds.lean): `5960b90f4ee0382bbc594054f4499be62f016a69089f729dc6123817b073d51c`<br>• [deepmind_signal_forensic_parsers.py](../proofs/deepmind_signal_forensic_parsers.py): `8d41db304ae88c0ccebd8119ff3e4de6824ad0e5a3384a66ff7e4cb5b2e4a05c`<br>• [verify_symbolic_deepmind_signal.py](../proofs/verify_symbolic_deepmind_signal.py): `4cc43598acf05cb2b062677e3a5bd9b55adec7eeaa32ecdf30f70954bb60cd00` |
| 검증 방식 | 독립 Lean 4 정리 81개 (1,457줄, 0 sorry, 0 axiom, 전칭 가설 돌연변이 포착 391 / 391건 = 100%) 및 83종 업스트림 원문(59개 .lean + 24개 비-Lean) 실시간 파싱·기호 검증 스위트 |
| 적용 감사 규격 | ultari-proof-anatomy 5-Gate 감사 규격 (COPE · IMU/AMS · ACM v1.1 · ICMJE/CRediT · NeurIPS, 헌장 DOI: [10.5281/zenodo.24241228](https://doi.org/10.5281/zenodo.24241228), 원장 v1.0.0 DOI: [10.5281/zenodo.24241229](https://doi.org/10.5281/zenodo.24241229)) |
| 5대 관문 및 등급 판정 | Gate 1 (수리·커널): HOLD (자체 16,767줄 `Arm64/Trusted` TCB의 4대 경계 미달분[`arm64-semantics/ProofLib/TrustedClosure.lean:328-360` `"Arm64" :: _ => true` 면제(커밋 `808b4b7ffef1`, `oai_ref` 미수록), 31/301+ 시스콜, `Hoare.lean` `.Exception` 177건 및 `mmap` `.OutOfMemory`, `coins.rs` `Class A`/엔트로피 밖 + `AT_RANDOM` 0 초기화, `TESTING.md` `(1, 13)` 스킵] 및 38개 `sorry` 잔존[미완성 `Synthetic/Disproofs` 스텁 10개, 정상 `ComparatorChallenge` 플레이스홀더 24개, 부정 픽스처 `Fixtures.lean` 4개]) · Gate 2 (원고-코드): FAIL (`55/64(85.94%)` 명세 훅 및 패닉 스텁 대체[9개(PR #2 19개) ELF 루틴 직접 검증, 26개 암호·2개 `Drop::drop` 영점화 훅 포함]·비기본 `CliElfLib` 격리·Class B `DEV-C14` 구수치 `38,967` 오기재) · Gate 3 (서지·윤리): FAIL (미수록 루트 감사 스크립트 5종·`TRUSTED_BASE.md` 누락 및 AGPL-3.0-only ELF 미배포) · Gate 4 (공정·개입): FAIL (326개 파일·153,682줄 `ComparatorChallenge` [`Trusted.`] TCB 편입·`enable_nanoda:false`·PR #2의 `README` 67줄 고지 삭제) · Gate 5 (수리 가치): PASS $\implies$ TIER C (조건부 기계 검증 코어 인정 / 엔드투엔드 바이너리·표방 대비 기준 미충족 아티팩트 / Conditional Verification & Non-Conforming Artifact) |



### 0.1 8대 핵심 지표 요약표 (8-Metric Executive Scorecard)

| 감사 축 | 원고 및 공개 문서 표방 내용 | 실제 저장소(Lean 4 / Arm64 / CLI / comparator) 실측치 | 괴리율 / 상태 |
| :--- | :--- | :--- | :---: |
| 1. 빌드·코드 도달성 | 11,323개 파일 · 7,528,295줄 전체 검증 | 기본 lake build에서 CliElfLib(120개·85,249줄) 등 592개 모듈(267,194줄) 제외; 6대 헤드라인 미도달 1,450개 파일(595,231줄) | 미도달 595,231줄 |
| 2. 바이너리 훅 절단면 | 컴파일된 AArch64 libsignal-cli 기계어 정밀 검증 | 추적 경계 심볼 64개 중 9개(14.06%, PR #2 19개 = 29.69%, `mallocng`·메모리·읽기) ELF 루틴을 직접 검증하고, 55개(85.94%, PR #2 45개)는 명세 훅(37개) 및 패닉 스텁(18개)으로 대체(26개 암호 훅 + `Drop::drop` 2개 영점화 훅 포함; 수학적 난제 가정과 별개로 컴파일된 AArch64 암호 구현[`HACL*`/`Fiat-Crypto`/`s2n-bignum` 대비] 및 dead-store 소거는 미검증) | 55/64(85.94%) 명세 훅 대체 |
| 3. 최하위 ISA·시스콜 TCB | AArch64 명령어 및 리눅스 시스콜 정식 모델링 | `Arm64/Trusted/` 61개 파일(16,767줄)은 `seL4`·`CompCert`처럼 설계상 공리적 ISA/시스콜 TCB(정리 0건)이나 4대 경계 미달분을 보유함: `arm64-semantics/ProofLib/TrustedClosure.lean:328-360` `"Arm64" :: _ => true` 면제(커밋 `808b4b7ffef1`, `oai_ref` 미수록; 미수록 루트 `scripts/TrustedClosure.lean`과 별개), 리눅스 시스콜 `31 / 301+`, `Hoare.lean` `.Exception` 177개 fail-closed 배제 + `Spec.allowOom`/`mmap` `.OutOfMemory`(`-ENOMEM` `NULL` 역참조 미모델링), `AT_RANDOM` 16B 0 초기화, `TESTING.md` `(1, 13)` 스킵 | 자체 TCB 경계 미달분 |
| 4. Rust CLI 하네스 제약 (Class A) | 실제 Signal 세션·프리키·난수·저장소 동작 검증 | [coins.rs](../proofs/oai_ref/third_party/libsignal/libsignal-session/cli/src/coins.rs#L32-L46) 부족분 0 패딩 `CryptoRng`(`Class A` 공시 범위이면서 `HACL*`급 종단간 엔트로피 보장 밖), `UNIX_EPOCH = 0` 시계 고정 하네스 전제(`DEV-PQ8`·`DEV-PQ9`), `ValidCall` 2자 제한, `DEV-PQ19` 고전 범위는 원고·`DEVIATIONS.md` 자체 공시 범위(Class A / Tier 2)이며, `Waker::noop()` 단일 폴링·`EBADF = 9` 침묵 EOF와 함께 프로덕션 환경과 분리됨 | Class A 자체 공시 하네스 전제 |
| 5. comparator 심판기 경계 (Class B) | 독립 심판기가 명세·공리 변형을 외부에서 차단 | [comparator/README.md](../proofs/oai_ref/comparator/README.md#L17-L18)에 `Trusted.`로 명시된 심판기 기준선(`Symbolic/BugInjection/`과 별개)인 `ComparatorChallenge`가 326개 파일(153,682줄)을 TCB에 편입([#L108-L116](../proofs/oai_ref/comparator/README.md#L108-L116) 인용 임포트 폐포 신뢰); `"enable_nanoda": false`; Linux 5.10 비샌드박스; PR #2에서 한계 고지 67줄 삭제 | Class B TCB 153,682줄 편입 |
| 6. 양자내성 및 PQXDH 상계 (Class A) | PQXDH + SPQR V1 하이브리드 프로토콜 경계 | 계산적 정리는 고전 안전성 전용(`DEV-PQ19`); [PQXDH.md](../proofs/oai_ref/Computational/docs/PQXDH.md#L87-L115) `L115`에서 점근 상계 `q_total = 2^40` (제5항 `17,441 / 16,384 > 1`)과 현실 예산 `q_total <= 2^24`의 구체적 안전 여유(`Curve25519` 약 `2^-58.4` / `2^-59.3`)를 직접 구분·공시함 | Class A 공시 운용·보안 경계 |
| 7. 세션 MAC(Class B)·프리키(Class A) 경계 | 다중 에포크 래칫 및 프리키 누적 한도 | `Class B`: 8바이트 MAC 상계(`DEV-C14`)는 `q = 35,211`에서 `> 1` 도달하나 [DEVIATIONS.md#L2733](../proofs/oai_ref/Computational/docs/DEVIATIONS.md#L2733)에 구수치 `38,967` 오기재. `Class A`: `.base-keys` `56,680`회 비순환 최후 수단 프리키 상한([DEV-CLI21](../proofs/oai_ref/Computational/docs/DEVIATIONS.md#L3474-L3528))은 `56,681`회째부터 해당 키 신규 `recv`를 거절하나 `L3522-L3524` 명시대로 기존 세션(`send`·whisper·OTK·승격)은 정상 유지 | Class B `DEV-C14` 오기재 / Class A `56,680` 공시 |
| 8. 재현성·위생 스크립트 (Class B) | 자체 점검 스크립트 및 아티팩트 완비 | [check_refinement_hygiene.sh](../proofs/oai_ref/Symbolic/scripts/check_refinement_hygiene.sh#L121-L136) `--self-test` 7/14 사멸 항목으로 실패(종료 코드 1); 감사 스크립트 5종·`TRUSTED_BASE.md` 미수록(`0/6`); 미완성 `Synthetic/Disproofs` `sorry` 스텁 10건; AGPL-3.0-only ELF 미커밋 | Class B 자가점검 실패 / 미수록 |



### 0.2 3단 신호등 범위 요약표 (Traffic-Light Scope Summary)

| 등급 | 검증 영역 및 산출물 범위 | 정밀 판정 및 수리·형식검증 상태 |
| :--- | :--- | :--- |
| Tier 1<br>(유효 확인된 형식검증 자산) | • 추상 계산적 게임 감축(Computational/Proofs, ACD19 + SPQR V1 고전 비퇴행 감축)<br>• 기호 트레이스 불변량(Symbolic/Proofs) 및 9개 de-hook 심볼(mallocng 할당·해제·memcpy·memset·파일 읽기)의 배치 AArch64 기계어 정제 증명<br>• 독립 Lean 4 재검증 정리 81개(1,457줄, 0 sorry, 391/391 가설 변이 포착) | Gate 5 (수리 가치): PASS: 대규모 AArch64 명령어 상태 전이 및 프로토콜 게임 감축을 Lean 4 커널 안에서 연결한 컴퓨터 보조 형식검증 코어의 기술적 성취 확인 |
| Tier 2<br>(Class A: 원고·`DEVIATIONS.md`·`PQXDH.md` 자체 공시 운용·보안 경계 및 조건부 인터페이스) | • 55 / 64(85.94%, PR #2 이후 45 / 64 = 70.31%) 외부·런타임 심볼 명세 훅 및 패닉 스텁 대체(9개 [PR #2 19개] ELF 루틴 직접 검증; 26개 암호 훅 + `Drop::drop` 2개 영점화 훅 포함; 수학적 난제 가정과 별개로 컴파일된 AArch64 암호 구현 및 dead-store 소거는 미검증)<br>• `Arm64/Trusted/` 61개 파일(16,767줄): `seL4`·`CompCert`·`HACL*`처럼 설계상 공리적 ISA TCB(정리 0건)이나 4대 자체 경계 미달분(`arm64-semantics/ProofLib/TrustedClosure.lean:328-360` `"Arm64" :: _ => true` 전면 면제[커밋 `808b4b7ffef1`, `oai_ref` 미수록; 미수록 루트 `scripts/TrustedClosure.lean`과 별개], `31 / 301+` 시스콜, `Mmap.lean` `.OutOfMemory`(`-ENOMEM` `NULL` 역참조 미모델링)·`Hoare.lean` `.Exception` 177건, `AT_RANDOM` 0 초기화, `TESTING.md` `(1, 13)` 스킵) 보유(`Gate 1: HOLD`)<br>• **Class A 자체 공시 경계**: 원고·`DEVIATIONS.md`·`PQXDH.md`가 명시적으로 구분·공시한 하네스 전제 및 운용·보안 상계(`coins.rs` 0 패딩[`Class A` 공시 범위이면서 `HACL*`급 종단간 엔트로피 보장 밖], `UNIX_EPOCH = 0` 시계 고정 하네스 전제 [`DEV-PQ8`·`DEV-PQ9`], 2자 `ValidCall`, 고전 전용 `DEV-PQ19`, [PQXDH.md#L87-L115](../proofs/oai_ref/Computational/docs/PQXDH.md#L87-L115) `q_total <= 2^24` 구체적 여유 vs `2^40` 점근 한계, [DEV-CLI21](../proofs/oai_ref/Computational/docs/DEVIATIONS.md#L3474-L3528) `.base-keys` `56,680`회 비순환 프리키 상한[기존 세션 정상 유지], 1 GiB 피크 메모리, `FdsHiFrame`) | 조건부 유효 (Conditional Scope): 자체 공시된 이상화 훅, 공리적 TCB 경계 미달분, Class A 운용·보안 상계 및 고정 테스트 하네스 전제 위에서만 성립하는 조건부 정리 |
| Tier 3<br>(Class B: 미공시·모순 아티팩트 결함 및 원고-아티팩트 불일치) | • 심판기 기준선(`Trusted.`, `Symbolic/BugInjection/`과 별개)인 `ComparatorChallenge`의 326개 파일(153,682줄) TCB 역임포트, `"enable_nanoda": false`, Linux 5.10 비샌드박스 실행 및 PR #2의 `comparator/README.md` 67줄 고지 삭제<br>• [DEVIATIONS.md#L2733](../proofs/oai_ref/Computational/docs/DEVIATIONS.md#L2733) `DEV-C14` 8바이트 MAC 구수치(`38,967` 오기재 대 실제 `q = 35,211`, 인라인 태그 `4`곳 및 `207 / 206` off-by-one)<br>• 기본 `lake build`의 `CliElfLib`(85,249줄) 제외 및 미도달 1,450개 파일(595,231줄), `check_refinement_hygiene.sh --self-test` `7/14` 실패(종료 코드 `1`), 미수록 감사 스크립트 5종·`TRUSTED_BASE.md`(`0/6`), 미완성 `Synthetic/Disproofs` `sorry` 스텁 10개(전체 38개 중 정상 `ComparatorChallenge` 24개·부정 픽스처 `Fixtures.lean` 4개 별도), AGPL-3.0-only ELF 누락 | Gate 2·3·4: FAIL (Class B 결함): 자체 공시 범위(Class A / Tier 2)를 넘어서는 미공시 수치 오기재·재현 도구 결손·TCB 한계 고지 삭제로 무수정 게재 기준 미충족 |



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

- 물증 좌표: [coins.rs](../proofs/oai_ref/third_party/libsignal/libsignal-session/cli/src/coins.rs#L32-L46), [cli/src/lib.rs](../proofs/oai_ref/third_party/libsignal/libsignal-session/cli/src/lib.rs#L90-L250), [handshake/src/lib.rs](../proofs/oai_ref/third_party/libsignal/libsignal-session/cli/handshake/src/lib.rs#L33-L65), [ratchet/src/lib.rs](../proofs/oai_ref/third_party/libsignal/libsignal-session/cli/ratchet/src/lib.rs#L36-L68), [cli/io/src/lib.rs](../proofs/oai_ref/third_party/libsignal/libsignal-session/cli/io/src/lib.rs#L41-L58), [stores.rs](../proofs/oai_ref/third_party/libsignal/libsignal-session/cli/src/stores.rs#L361-L445) 및 [thm_78](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean#L418).
- 하네스 물리적 동작:
  1. 부족분 0 패딩 `CryptoRng` (`coins.rs:32-46`): 입력 난수 슬라이스가 소진되면 오류를 반환하지 않고 남은 출력 버퍼를 `dst[now.len()..].fill(0)`으로 채우며, `impl rand_core::CryptoRng for Coins` 마커 트레이트를 부여함.
  2. `UNIX_EPOCH = 0` 시계 고정 하네스 전제 (`cli/src/lib.rs:140-250`, `DEV-PQ8`·`DEV-PQ9`, `DEVIATIONS.md:1720-1739`): 모든 CLI 서브커맨드 호출 시각을 `SystemTime::UNIX_EPOCH`(`Timestamp::from_epoch_millis(0)`)로 고정하여 서명 프리키(SPK) 30일(`30 * 86,400 = 2,592,000`초) 만료 및 세션 노화 검사가 발동하지 않도록 전제함.
  3. 단일 폴링 동기 실행기 (`Waker::noop()`) 및 `EBADF = 9` 침묵 처리: `Context::from_waker(Waker::noop())`로 async 프로토콜 함수를 1회 동기 폴링(`poll_once`, `handshake/src/lib.rs#L58-L65`, `ratchet/src/lib.rs#L61-L68`)하며, `cli/io/src/lib.rs`는 닫힌 파일 디스크립터 오류(`EBADF = 9`)를 정상 EOF(0바이트 읽기) 또는 쓰기 성공으로 처리하고 `stores.rs:373-374, 428-432`는 37바이트(`4B LE SignedPreKeyId + 0x05 + 32B 공개키`) `.base-keys` 레코드를 누적함.

### 3.2 부팅 전 `.data` 5바이트 덮어쓰기 및 `alink_check.py` `udf #0` 트랩 스텁

- 부팅 전 `.data` 5바이트 패치 ([Guards.lean#L140-L156](../proofs/oai_ref/LibsignalBinary/Specifications/LibsignalSpqrV1/Guards.lean#L140-L156), [CliBinaryPq.lean#L278-L280](../proofs/oai_ref/LibsignalBinary/Specifications/SignalSession/CliBinaryPq.lean#L278-L280), [thm_13](../proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean#L214), [thm_14](../proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean#L226)):
  - `Arm64/Trusted/ISA/Eval.lean`이 시스템 레지스터 읽기 명령(`MRS`)에서 `.Exception`으로 정지하므로, [Guards.lean](../proofs/oai_ref/LibsignalBinary/Specifications/LibsignalSpqrV1/Guards.lean#L140-L156)의 `token_cells_initial`(`0x9a038`의 `0xff`, `0x9a048`의 `[3,0,0,0]`)이 가리키는 `5`바이트를 [CliBinaryPq.lean](../proofs/oai_ref/LibsignalBinary/Specifications/SignalSession/CliBinaryPq.lean#L278-L280)의 `Placed.cliTokenPatchPlaced`가 부팅 전 0으로 덮어써 런타임 `cpufeatures`의 `getauxval(AT_HWCAP)` 호출 경로를 진입 전에 차단함.
- 링커 주소 격리 및 udf #0 스텁 (stock.ld:1-177, alink_check.py:21-31, [thm_12](../proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean#L199), [thm_79](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean#L439)):
  - [stock.ld](../proofs/oai_ref/third_party/libsignal/libsignal-session/cli-elf/stock.ld#L1-L177)는 `.text.hooked.*` 섹션을 진입점(e_entry) 아래의 :text_a 영역으로 분리하고, [alink_check.py](../proofs/oai_ref/scripts/stock-pin/alink_check.py#L21-L31)는 미정의 외부 심볼 및 약한 원자 연산 3종(displaced_weak)을 4바이트 미정의 명령어 트랩 udf #0(0x00000000) 스텁으로 배치함.



## 제4부. 증명 도달성 층서학, 바이너리 명세 훅 절단면 및 ComparatorChallenge TCB 감사 (Stratigraphy, Hook Cut-Plane & Comparator Audit)

### 4.1 저장소 빌드·도달성 분할 (11,323개 파일 · 7,528,295줄, [thm_01](../proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean#L25)~[thm_04](../proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean#L70), [thm_51](../proofs/deepmind_comparator_laundering_and_crypto_bounds.lean#L26))

| 계층 구분 | 파일 수 (비율) | 코드 줄 수 (비율) | 빌드·도달성 역할 및 상태 |
| :--- | :---: | :---: | :--- |
| 기본 lake build 타깃 (@[default_target]) | 10,722개 (94.69%) | 7,258,642줄 (96.42%) | Arm64, VerifiedLibraries, Computational, Symbolic 기본 빌드 대상 |
| 기본 빌드 제외 모듈 (8개 버킷) | 592개 (5.23%) | 267,194줄 (3.55%) | 배치 ELF 대표 정리(F3, C5)가 속한 CliElfLib 전용 120개 모듈(85,249줄) 포함 기본 빌드 제외 |
| 6대 대표 진입점 도달 폐포 (Reachable Cone) | 9,873개 (87.19%) | 6,933,064줄 (92.09%) | Main.lean, Lemmas.lean, ModelSecurity.lean, Refinement.lean, RefinementPreservation.lean, Security.lean 역임포트 도달 |
| 6대 대표 진입점 미도달 모듈 (Unreachable Strata) | 1,450개 (12.81%) | 595,231줄 (7.91%) | 모든 대표 정리와 단절된 미도달 모듈(LibsignalBinary/Heap/Fine/ 22개 미러 파일 포함) |

### 4.2 배치 ELF 경계 심볼 55 / 64 (85.94%) 명세 훅 및 패닉 스텁 치환 단면 ([thm_09](../proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean#L154)~[thm_11](../proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean#L185))

- 물증 좌표: [CliRun.lean](../proofs/oai_ref/LibsignalBinary/Specifications/SignalSession/CliRun.lean#L1-L495), [CliBinaryPq.lean](../proofs/oai_ref/LibsignalBinary/Specifications/SignalSession/CliBinaryPq.lean#L137-L482).
- 경계 심볼 분할 (64개 추적 심볼):
  1. 직접 ELF 기계어 실행 검증(cliDehookedSymsPlaced): 9 / 64개 (14.06%): Rust 할당자 심볼 5개(`__rust_no_alloc_shim_is_unstable_v2`, `__rust_alloc`, `__rust_dealloc`, `__rust_realloc`, `__rust_alloc_zeroed`), `memcpy`, `memset`, `read_file`, `read_stdin` (PR #2 `b0f729accbc2`에서 비암호 헬퍼 10개 추가로 19 / 64 = 29.69%).
  2. 이상화 Lean 명세 훅 대체(cliHookTablePlaced): 37 / 64개 (57.81%):
     - 암호·비밀소거·배리어 심볼 26개: 대칭 프리미티브 5개(`compress256`, `compress512`, `libcrux_hmac::hmac`, `aes_256_cbc_encrypt`, `aes_256_cbc_decrypt`) + 공개키·격자 연산 18개(`curve25519_dalek` 7, `x25519_dalek` 2, `mlkem1024` 2, `mlkem768` 7) + X25519 `Drop::drop` 비밀키 영점화(zeroize) 훅 2개 + `core::hint::black_box` 1개 (PR #2 이후에도 26개 전량 명세 훅 치환 유지).
     - 비암호 I/O·메모리·포맷·시계 헬퍼 11개: `write_file`, `write_stdout`, `memmove`, `bcmp`, `strlen`, `memrchr`, `from_utf8`, `core::fmt::write`, `format_inner`, `SystemTime::duration_since`, `SystemTime::add` (PR #2에서 `write_file` 외 10개 de-hook).
  3. 패닉 스텁(cliPanicSymbolsPlaced): 18 / 64개 (28.13%): `SIGABRT` 종료 처리.
  - $\implies$ 합계 37 + 18 = 55 / 64개(85.94%, PR #2 기준 27 + 18 = 45 / 64 = 70.31%) 심볼이 명세 훅 및 패닉 스텁으로 치환되며, 특히 암호학적 난제 가정(공리적 게임 인터페이스 분리)과 별개로 컴파일된 AArch64 암호 구현 정당성(`HACL Star`·`Fiat-Crypto`·`s2n-bignum` 대비) 및 2개 `Drop::drop` 영점화 훅의 컴파일러 dead-store 소거 유지 여부(물리 RAM·스택·레지스터 소거)는 검증 범위 밖에 남습니다.

### 4.3 ComparatorChallenge(`Trusted.` 심판기 기준선)의 153,682줄 TCB 편입 및 비샌드박스 실행 ([thm_52](../proofs/deepmind_comparator_laundering_and_crypto_bounds.lean#L42)~[thm_57](../proofs/deepmind_comparator_laundering_and_crypto_bounds.lean#L149))

- 물증 좌표: [comparator/README.md](../proofs/oai_ref/comparator/README.md#L17-L18), [#L108-L116](../proofs/oai_ref/comparator/README.md#L108-L116), [computational.json](../proofs/oai_ref/comparator/computational.json#L1-L20), [symbolic.json](../proofs/oai_ref/comparator/symbolic.json#L1-L24), [Computational.lean](../proofs/oai_ref/comparator/ComparatorChallenge/Computational.lean#L1-L21), [Symbolic.lean](../proofs/oai_ref/comparator/ComparatorChallenge/Symbolic.lean#L1-L22), [run.sh](../proofs/oai_ref/comparator/run.sh#L44-L48).
- 관측 사실:
  1. [comparator/README.md](../proofs/oai_ref/comparator/README.md#L17-L18)은 `ComparatorChallenge`(`challenge_module`)를 적대적 버그 주입 스위트(`Symbolic/BugInjection/`)와 별개인 **`Trusted.`** 심판기 기준선으로 표기하며 `#L108-L116`에서 챌린지의 임포트 폐포 전체가 신뢰됨(`"the challenge's import closure is trusted"`)을 설명함. 그러나 얇은 독립 명세 대신 구현 서브트리를 전이 임포트하여 326개 파일(153,682줄, `ProofLib` >= 92,732줄 포함)을 신뢰 기반(TCB)에 편입시킴(챌린지 스텁 343줄 대비 > 448배 TCB 팽창).
  2. 두 JSON 설정 파일 모두 "enable_nanoda": false로 외부 독립 커널 검증기를 비활성화함.
  3. run.sh:44-48은 landrun 실행 전에 샌드박스 바깥에서 lake build --no-ansi를 선행 실행하며, 러너 커널(Linux 5.10 < 5.13)에서 Landlock이 비활성화됨.
  4. JSON 검사 대상 24개(8 + 16) 중 배치 ELF·심볼 정리 3개가 중복 등록되어 실제 고유 검사 정리는 21개임.



## 제5부. 원고-아티팩트 불일치, 최하위 TCB 괴리 및 암호 상계 공허화 감사 (Paper–Artifact Divergence, TCB & Cryptographic Vacuity Audit)

### 5.1 최하위 공리적 TCB(Arm64/Trusted, 16,767줄)의 자체 시스콜·OOM 의미론 괴리 ([thm_26](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean#L24)~[thm_50](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean#L396))

| 감사 항목 (파일:행) | 상위 문서·명세 전제 | Arm64/Trusted/ 실제 코드 상태 | 검증 정리 |
| :--- | :--- | :--- | :--- |
| 1. 공리적 ISA·시스콜 TCB 설계 범위<br>(61개 파일 · 16,767줄) | AArch64 ISA 및 리눅스 시스콜 공리 기반 명세 | `seL4`·`CompCert`와 같이 설계상 공리적 TCB(61개 파일, 1,259개 선언, `theorem`/`lemma` 0건)로 두었으나 4대 자체 경계 미달분(`arm64-semantics/ProofLib/TrustedClosure.lean:328-360` `"Arm64" :: _ => true` 문장 폐포 면제[커밋 `808b4b7ffef1`, `oai_ref` 미수록; 미수록 루트 `scripts/TrustedClosure.lean`과 별개] + `.Exception` 177개 + `.OutOfMemory` 12개 + `.trap` 10개 = 199개 비정상 종료 분기)이 커널·POSIX·`HACL*` 의미론과 괴리 | [thm_26](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean#L24)~[thm_28](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean#L61) |
| 2. Hoare 사후조건 예외 트랩 (`fail-closed` vs 면책 OOM)<br>([Hoare.lean:124-222](../proofs/oai_ref/arm64-semantics/Arm64/Trusted/Spec/Hoare.lean#L124-L222)) | 서브루틴 호출 후 메모리·보안 불변량 유지 | `Spec`·`SubroutineOutcome`·`reaches_outcome`·`safe_until`은 `.Exception`을 배제(`fail-closed`, `177`개 미모델링 ISA·시스콜 분기가 검증 입력 도메인을 축소)하며, `Spec.allowOom`의 `onOom := ⌜True⌝` 또는 `CliReachesOOMPlaced`(`DEV-CLI15`)만 `.OutOfMemory`를 면책함 | [thm_30](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean#L92), [thm_31](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean#L109) |
| 3. 리눅스 시스콜 범위 및 AT_RANDOM<br>([Syscalls.lean:1-57](../proofs/oai_ref/arm64-semantics/Arm64/Trusted/Syscalls.lean#L1-L57), [Types.lean:120-121](../proofs/oai_ref/arm64-semantics/Arm64/Trusted/Process/Types.lean#L120-L121), [Loader.lean:377-427](../proofs/oai_ref/arm64-semantics/Arm64/Trusted/Process/Loader.lean#L377-L427)) | 리눅스 유저스페이스 실행 환경 모델링 | 301+개 AArch64 시스콜 중 31개만 구현(270+개는 `.Exception`); 프로세스 로더가 보조 벡터 `AT_RANDOM` 16바이트(128비트)를 전부 0으로 초기화(`coins.rs` `.fill(0)`은 Class A 자진 공시 경계이나 `HACL*`급 종단간 엔트로피 보장 밖) | [thm_29](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean#L78), [thm_32](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean#L126) |
| 4. mmap 고갈 시 동작<br>([Mmap.lean:176-202](../proofs/oai_ref/arm64-semantics/Arm64/Trusted/Syscalls/Mm/Mmap.lean#L176-L202)) | 리눅스 `mmap` 실패 시 `-ENOMEM(-12)` 반환 | `X0 = 0xfffffffffffffff4#64(-12)` 반환 대신 기계를 `.OutOfMemory`로 즉시 정지시켜 호출자의 NULL 포인터 역참조 경로가 OOM 면책 뒤에 가려짐 | [thm_33](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean#L146), [thm_45](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean#L331), [thm_46](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean#L344) |
| 5. `exit_group` 종료 코드 및 파일·시그널<br>([Exit.lean:1-44](../proofs/oai_ref/arm64-semantics/Arm64/Trusted/Syscalls/Kernel/Exit.lean#L1-L44), [ReadWrite.lean:110-189](../proofs/oai_ref/arm64-semantics/Arm64/Trusted/Syscalls/Fs/ReadWrite.lean#L110-L189), [ReadWritev.lean:100-119](../proofs/oai_ref/arm64-semantics/Arm64/Trusted/Syscalls/Fs/ReadWritev.lean#L100-L119), [Open.lean:163,249-250](../proofs/oai_ref/arm64-semantics/Arm64/Trusted/Syscalls/Fs/Open.lean#L163-L250), [Select.lean](../proofs/oai_ref/arm64-semantics/Arm64/Trusted/Syscalls/Fs/Select.lean#L1-L134)) | POSIX 종료 상태 및 표준 파일·시그널 의미론 | `Exit.lean`이 `X0 & 0xff` 하위 8비트 마스킹을 생략(`X0 = 256*m`에서 POSIX는 0, TCB는 비영 기록); `ReadWrite.lean`은 `read`/`write` 모두를 `0x7ffff000`으로 잘라내고 `ReadWritev.lean`은 초과 시 `.Exception` 발생; `Open.lean`은 비-`0o600` `O_CREAT`에서 트랩하고 기존 `FsState` 권한 비트를 생략; `Select.lean` `fd >= 3` `ppoll` 트랩; 27개 시스콜 전체 `-EINTR` 0건; 동기 폴트 시 `rt_sigaction` 미호출; Sail/Unicorn 시험([TESTING.md:124-132](../proofs/oai_ref/arm64-semantics/Arm64/TESTING.md#L124-L132))에서 결함 상태(1, 13) 및 DC ZVA·ADDV 건너뛰기 | [thm_35](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean#L174)~[thm_44](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean#L291), [thm_79](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean#L439) |

### 5.2 암호·프로토콜 상계 공허화 및 문서-코드 수치 불일치 (Paper–Artifact Divergence)

| 불일치 및 공허화 축 | 문서(DEVIATIONS.md / PQXDH.md / PAPER_MAP.md) 기재 내용 | 실제 활성 코드 및 대수적 실측 결과 | 검증 정리 |
| :--- | :--- | :--- | :--- |
| 1. Class B DEV-C14 8바이트 MAC 구수치 오기재<br>([DEVIATIONS.md:2712-2733](../proofs/oai_ref/Computational/docs/DEVIATIONS.md#L2712-L2733) 대 [StatementComposed.lean](../proofs/oai_ref/Computational/Specifications/Session/StatementComposed.lean#L1-L545)) | DEVIATIONS.md:2733은 합성 게임 DEV-C14의 $2^{-32}$ 및 1 초과 임계치를 DEV-LS31과 동일한 q = 9,459 (qep = 0) 및 q = 38,967 (qep = q)로 기재 | DEV-C14 분자식 $12q^4 + 56q^3 + 96q^2 + 56q$는 DEV-LS31보다 $4q(q^3 + 2q^2 + 6q - 10) > 0$만큼 커서 실제로는 q = 7,327 (qep = 0)에서 $2^{-32}$를 넘고 q = 35,211 (qep = q)에서 이미 $18,448,187,719,356,341,620 > 2^{64}$로 확률 상계 1을 초과함(3,756회 조기 초과, 미공시 구수치 오기재) | [thm_59](../proofs/deepmind_comparator_laundering_and_crypto_bounds.lean#L197)~[thm_64](../proofs/deepmind_comparator_laundering_and_crypto_bounds.lean#L279) |
| 2. Class A `PQXDH.md:87-115` 구체적 여유 구간 및 고전 전용 범위<br>([PQXDH.md:69-136](../proofs/oai_ref/Computational/docs/PQXDH.md#L69-L136), `DEV-PQ19`) | PQXDH + SPQR 하이브리드 핸드셰이크 및 구체적 보안 여유 구간 | 계산적 정리는 고전 안전성만 증명(`DEV-PQ19`, 양자 적대자 미포함)하며, 4-leg GapDH 계수 합 $c_3 = \frac{17441}{16384}\cdot 2^{60}$으로 인해 제5항이 $q_{\mathrm{total}} = 2^{40}$에서 `17441 / 16384 > 1`이 되는 점근 구간임을 `L87-L115`에서 자진 공시하고 `L115`에서 구체적 비공허 보안 여유를 $q_{\mathrm{total}} \le 2^{24}$로 명시 산출함(`L136` 수작업 계산 고지). 또한 단일 키 X25519+XEdDSA의 `GapSigEufCma`·`GapDhWithSign` 분리 및 독립 `XeddsaRom/` Forking-Lemma 손실(`DEV-PQ13`)은 TCB 외부에 남고, `DEV-PQ16`은 `P.isCanonical` 소수 위수 부분군 가드를 강제(`is_torsion_free` 훅 처리)하는 반면 `DEV-PQ17`은 코팩터-8 `P.pow8`로 감축하여 $O(q_{\text{total}}^2)$ DDH 예산을 요구함 | [thm_77](../proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean#L457), [thm_80](../proofs/deepmind_comparator_laundering_and_crypto_bounds.lean#L484) |
| 3. Class A .base-keys 56,680회 미회전 프리키 상한<br>([PqDir.lean:1-463](../proofs/oai_ref/LibsignalBinary/Specifications/SignalSession/PqDir.lean#L1-L463), `DEV-CLI21` [DEVIATIONS.md:3474-3528](../proofs/oai_ref/Computational/docs/DEVIATIONS.md#L3474-L3528)) | 최후수단(last-resort) Kyber 프리키 중복 제거 및 기존 세션 유지 | .base-keys 파일이 키당 37바이트를 추가 전용으로 기록하여 $37 \times 56,679 = 2,097,123 \le 2^{21}$ 직후 56,680번째 핸드셰이크($37 \times 56,680 = 2,097,160 > 2,097,152$ B)에서 fileCapBytes = 2 MiB 상한에 도달하며, 56,681번째부터 해당 미회전 최후수단 Kyber 프리키 신규 수락만 상한 거부(`Outcome.exited 1 []`, 파일 무변경)되는 반면 기존 세션의 `send`·whisper `recv`·일회용 프리키 `recv`·세션 승격은 `L3522-L3524`대로 정상 지속됨 | [thm_66](../proofs/deepmind_comparator_laundering_and_crypto_bounds.lean#L322), [thm_67](../proofs/deepmind_comparator_laundering_and_crypto_bounds.lean#L338) |
| 4. Class B Cheval '26 기호 반증 재조준 불일치 및 38건 sorry 분해<br>([PAPER_MAP.md:216-238](../proofs/oai_ref/docs/PAPER_MAP.md#L216-L238)) | T-12(d): 기호 반증 증인들이 각 취약점의 공격 트레이스를 기계 검증함 | Cheval '26 CLI 반증 4개 중 2개([Cheval26SmallSubgroupTorsionCli.lean](../proofs/oai_ref/Symbolic/BugInjection/Disproofs/Cheval26SmallSubgroupTorsionCli.lean#L83-L93), [Cheval26WeakStateCli.lean](../proofs/oai_ref/Symbolic/BugInjection/Disproofs/Cheval26WeakStateCli.lean#L88-L98))는 고유 공격 트레이스 증명 없이 타 운반체 정리를 재사용하며, 전체 38건 sorry 중 `Symbolic/BugInjection/Synthetic/Disproofs/` 미완성 스텁 10건이 `sorry` 상태로 남아 있음(정상 챌린지 표적 자리표시자 24건 + 부정 버그 주입 픽스처 4건과 구분) | [thm_07](../proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean#L119), [thm_55](../proofs/deepmind_comparator_laundering_and_crypto_bounds.lean#L95) |



## 제6부. 유효 증명 코어(Gate 5: PASS) 공인, 독립 재검증 및 대안 수리 명세 (Constructive Verification & Repair)

### 6.1 컴퓨터 보조 형식검증 코어(Gate 5: PASS)의 수리·공학적 유효성 확인

- 위 조건부 전제 및 TCB 경계와 독립적으로, 다음 두 가지 핵심 형식검증 성취는 Lean 4 커널 안에서 유효하게 작동함을 확인하고 확인함(Gate 5: PASS):
  1. 게임 기반 계산적 감축 및 기호 정제 파이프라인: ACD19 이중 래칫과 SPQR V1 포스트양자 브리지를 결합한 다단계 게임 변환(Computational/Proofs) 및 기호 트레이스 정제(Symbolic/Proofs)가 실제 Lean 4 커널 타입 검사를 통과함.
  2. 배치 AArch64 기계어 슬라이스 및 mallocng 정제: cliDehookedSymsPlaced에 속한 9개 심볼(mallocng 할당·해제 및 메모리·읽기 루틴, PR #2 이후 19개)의 실제 배치된 ELF 기계어 명령어 시퀀스 상태 전이와 힙 불변량이 형식 검증됨.

### 6.2 독립 Lean 4 재검증(81개 정리, 391/391 변이 포착) 및 대안 수리 명세

1. 반사(Reflection) 기반 기본 블록 디코더 테이블 압축으로 18,373줄(94.14%) 증명 절감 ([thm_20](../proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean#L348)~[thm_23](../proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean#L381)):
   - 고유 주소 $k = 1,023$개와 중복 호출 지점 $d = 371$개($k + d = 1,394$)마다 14줄짜리 `*_decode_0x...` 보조정리를 반복 생성하는 기존 구조(`14 * 1,394 = 19,516`줄)를 120줄 공통 반사 검증기와 주소당 1줄 룩업 테이블(120 + 1,023 = 1,143줄)로 교체하면 19,516 - 1,143 = 18,373줄(94.14%)이 절감되고 중복 주소 증명 파손이 제거됨:
     $$14(k + d) - (120 + k) = 13k + 14d - 120 = 18,373$$
2. 16바이트(128비트) 와이어 MAC 태그 확장으로 단일 세션 공허화 완전 제거 ([thm_65_rigidity_16byte_mac_eliminates_u32_session_vacuity](../proofs/deepmind_comparator_laundering_and_crypto_bounds.lean#L300)):
   - 와이어 MAC 태그 길이를 8바이트($2^{64}$)에서 16바이트($2^{128}$)로 확장하면 DEV-C14 공허화 임계점이 q = 35,211에서 q = 2,307,621,357 > q_u32_max = 2,147,471,145로 이동하여, u32 래칫 카운터가 도달할 수 있는 전 구간에서 단일 세션 MAC 공허화가 원천 소멸함.
3. 5대 필수 아키텍처·Class B 시정 명세:
   - (1) ComparatorChallenge에서 153,682줄 구현 트리 임포트를 제거하고 순수 명세 인터페이스만 남기며, "enable_nanoda": true 및 Linux >= 5.13 샌드박스 격리 활성화(삭제된 comparator/README.md 67줄 한계 고지 복원),
   - (2) lakefile.lean 기본 @[default_target]에 CliElfLib(120개 모듈) 편입, check_refinement_hygiene.sh의 사멸 정리 7건·LC_ALL=C 정렬 오류 수리 및 미완성 `Synthetic/Disproofs/` `sorry` 스텁 10건 완성,
   - (3) DEVIATIONS.md:2733의 DEV-C14 구수치(38,967)를 실제 값(q = 7,327 및 q = 35,211)으로 정정하고 상단 요약표 `207/206`·인라인 4건·`PAPER_MAP.md` `T-12(d)` 교정 및 미수록 감사 스크립트 5종·TRUSTED_BASE.md 공개,
   - (4) Arm64/Trusted/Syscalls/Mm/Mmap.lean의 .OutOfMemory 정지를 리눅스 표준 -ENOMEM(-12) 반환으로 교정하고 Drop::drop 영점화 심볼 2개를 de-hook하여 실제 스택·레지스터 소거 검증,
   - (5) 초록·서론·헤드라인 정리 표제에 Class A 자진 공시 운용·보안 경계(`55/64 [85.94%]` 명세 훅·패닉 스텁 치환[직접 ELF 검증 루틴 9개, PR #2 이후 19개; 암호 26개 + `Drop::drop` 영점화 2개 훅], `16,767`줄 자체 `Arm64/Trusted` ISA/시스콜 TCB, 고전 전용 `DEV-PQ19`, `PQXDH.md:115` $q_{\mathrm{total}} \le 2^{24}$ 구체적 보안 여유, `DEV-CLI21` `.base-keys` `56,680`회 미회전 프리키 상한[기존 세션 유지], `q < 35,211` 8바이트 MAC 구간)를 명시.



## 제7부. 국제 학술기준 대비 불부합 대조표, 예상 반론 사실 확인 및 최종 판정 (Standard-Bound Verdict)

### 7.1 국제 출판·형식검증 가이드라인 대조표 (COPE · IMU/AMS · ACM v1.1 · ICMJE/CRediT · NeurIPS)

| 국제 표준 대비 불부합 범주 | 준거 국제 가이드라인 조항 | 대상 저장소 확정 좌표 및 물리적 관측 수치 | 최종 판정 |
| :--- | :--- | :--- | :---: |
| 원고-아티팩트 불일치 (Paper–Artifact Divergence / Gate 2) | ACM Artifact Review v1.1 / COPE Core Practices (표방된 검증 범위·수치와 실제 실행 아티팩트의 1대1 정합성 요건) | • 경계 심볼 55 / 64(85.94%: 명세 훅 37개 + 패닉 스텁 18개; 직접 ELF 검증 루틴 9개[PR #2 19개]; 암호 26개 + `Drop::drop` 영점화 2개 훅의 기계어 구현 및 dead-store 소거 미검증)<br>• 기본 lake build가 CliElfLib(85,249줄) 등 592개 모듈을 제외하며, **Class B** DEVIATIONS.md:2733의 DEV-C14 구수치(38,967)가 실제 코드 임계치(35,211)와 불일치함<br>• **Class A** 자진 공시 경계로서 DEV-PQ19 고전 안전성 전용 및 PQXDH.md:87-115에서 $q_{\mathrm{total}} = 2^{40}$ 점근 구간(`17,441 / 16,384 > 1`)과 구체적 보안 여유 $q_{\mathrm{total}} \le 2^{24}$를 분리 명시 | 불일치 (Paper–Artifact Divergence) |
| 프로비넌스·심판기 경계 미충족 (Provenance & TCB Non-Conformance / Gate 1·4) | IMU/AMS / NeurIPS Code & Data Guidelines (독립 검증기 TCB 격리 및 한계 고지 보존 요건) | • 심판기 기준선(`Trusted.`, `Symbolic/BugInjection/`과 별개)인 `ComparatorChallenge`가 326개 파일(153,682줄)을 TCB에 편입시키고 `"enable_nanoda": false` 및 Linux 5.10 비샌드박스 상태로 동작함<br>• 후속 PR #2(`b0f729accbc2`)에서 `comparator/README.md`의 비샌드박스·챌린지 변경 가능성 고지 67줄(`L65–L131`)이 삭제됨<br>• 공리적 ISA·시스콜 TCB인 `Arm64/Trusted/`(61개 파일, 16,767줄)는 `arm64-semantics/ProofLib/TrustedClosure.lean:328-360` `"Arm64" :: _ => true` 면제(커밋 `808b4b7ffef1`, `oai_ref` 미수록; 미수록 루트 `scripts/TrustedClosure.lean`과 별개)·`31 / 301+` 시스콜 제한·`Hoare.lean` `.Exception` 177개 fail-closed 배제 및 `Spec.allowOom` `mmap` `.OutOfMemory` 면책·`AT_RANDOM` 0 초기화(`coins.rs` `.fill(0)`은 Class A 공시이나 `HACL*`급 종단간 엔트로피 보장 밖)·`TESTING.md` `(1, 13)` 폴트 스킵의 4대 경계 미달분을 보유함 | 기준 미충족 |
| 참조 아티팩트 미수록 (Artifact Omission Deficit / Gate 3) | ACM Reproducibility / COPE Citation & Data Guidelines (본문 인용 검증 스크립트 및 대상 바이너리 공개 요건) | • 문서가 인용하는 감사 스크립트 5종(HeadlineAxioms.lean 등)과 TRUSTED_BASE.md가 저장소에 미수록(0 / 6)됨<br>• check_refinement_hygiene.sh --self-test가 7/14 사멸 항목으로 실패하며(종료 코드 1), 전체 38건 `sorry` 중 `Synthetic/Disproofs/` 미완성 스텁 10건 및 미커밋 617,448 B AGPL-3.0-only 파생 ELF가 존재함 | 아티팩트 결손 (Artifact Omission) |

### 7.2 인간 · 컴퓨터 보조 형식검증(ITP) · 자동 에이전트 파이프라인 3층 기여도 분리

1. 인간 선행 암호학·명령어 명세 자산 기반:
   - 본 저장소의 보안 게임 구조와 기호 추적 모델은 인간 암호학자들이 확립한 Alwen–Coretti–Dodis (ACD19, 이중 래칫), Kret–Schmidt (PQXDH), Bhargavan et al. / Cheval et al. (ProVerif 기호 모델), 그리고 ARM 아키텍처 참조 매뉴얼(Sail AArch64 ISA 명세) 및 Signal 재단의 libsignal Rust/C 코드베이스 위에서 성립합니다. 인간이 구축한 이 5대 선행 자산과 `Arm64/Trusted` 수동 TCB 설계(16,767줄)는 AI 보조 형식화 계층과 분리된 선행 인류 기반 자산으로 분류합니다.
2. 전통적 컴퓨터 보조 형식검증(인간 명세 설계 + Lean 4 전술 자동화)으로 유효한 코어 (Gate 5: PASS):
   - 인간 연구진이 설계한 Hoare 삼중항 프레임워크(ProofLib)와 게임 감축 골격 위에서, AI 에이전트와 자동 생성기가 1,394개 PC 디코드 보조정리와 470,030개 스택 오프셋(sp) 전달 증명 등 반복적인 어셈블리·힙 상태 전이 보일러플레이트를 대량 생성해 커널 검사를 통과시킨 부분은 유효한 엔지니어링 성과입니다.
3. 자동 생성·포장 파이프라인에서 발생한 기준 미충족 (Gate 2~4: FAIL):
   - 자동화된 증명·패키징 파이프라인이 (1) 해결되지 않은 26개 암호·Drop::drop 영점화 심볼을 명세 훅 테이블 뒤로 치환하고, (2) ComparatorChallenge가 153,682줄 구현 트리를 TCB로 역임포트하도록 구성하며, (3) Symbolic/BugInjection/Synthetic/Disproofs/ 10개 파일에 미완성 sorry를 남기고, (4) 후속 PR #2에서 comparator/README.md의 비샌드박스 한계 고지 67줄을 삭제함으로써, 유효한 조건부 형식검증 코어와 대외 표방("Signal 보안의 엔드투엔드 형식검증") 사이에 정합성 불일치를 발생시켰습니다.

### 7.3 예상 반론 사전 사실 확인 (Pre-bunking FAQ 6문 6답)

- Q1. "암호 프리미티브를 수학적 가정으로 치환하는 것은 프로토콜 검증의 표준 관행이고 PR #2에서 훅 10개도 제거했는데, 훅 치환이 왜 문제인가?"
  - 사실 확인: PR #2가 de-hook한 10개 심볼은 모두 비암호 메모리·문자열·포맷·시간 보조함수(`memmove`, `strlen` 등)이며, Curve25519·SHA-256/512·HMAC·AES-256-CBC·ML-KEM-768/1024 및 2개의 X25519 `Drop::drop` 비밀키 영점화 훅을 포함한 26개 훅은 PR #2 이후에도 100% 명세 훅 치환 상태를 유지합니다([thm_11](../proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean#L185)). 프로토콜 모델에서 암호의 수학적 난제 가정을 공리화하는 것과 달리, 컴파일된 AArch64 암호 구현 정당성(`HACL Star`·`Fiat-Crypto`·`s2n-bignum`의 구현 검증 영역)과 `Drop::drop`의 컴파일러 dead-store 소거 유지 여부는 바이너리 훅 절단면 밖에서 미검증으로 남습니다.
- Q2. "모든 편차와 하네스 제약이 원고와 `DEVIATIONS.md`(206개 섹션)에 이미 투명하게 문서화되어 있지 않은가?"
  - 사실 확인: `coins.rs` `.fill(0)` 0 패딩(`Class A` 자진 공시 경계로 인정하되 `HACL*`급 종단간 엔트로피 보장 밖), `UNIX_EPOCH = 0` 시계 고정 하네스 전제(`DEV-PQ8`·`DEV-PQ9`), 2자 `ValidCall`, `DEV-PQ19` 고전 범위, `PQXDH.md:87-115` 구체적 여유 $q_{\mathrm{total}} \le 2^{24}$, `DEV-CLI21` `.base-keys` `56,680`회 미회전 프리키 상한(기존 세션 유지)을 원고·`DEVIATIONS.md`·`PQXDH.md`가 Class A로 자진 공시한 점은 분명히 인정합니다. 그러나 이와 구분되는 Class B 미공시·모순 결함으로서 (1) 요약표(207건)와 활성 섹션(206건)·미등재 인라인 태그(4건) 불일치([thm_05](../proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean#L87)), (2) `DEVIATIONS.md:2733`의 `DEV-C14` 공허화 임계치(`38,967`)가 실제 코드 임계치(`35,211`)보다 3,756회 높게 잘못 기재된 점([thm_64](../proofs/deepmind_comparator_laundering_and_crypto_bounds.lean#L279)), (3) `check_refinement_hygiene.sh --self-test` 실패 및 인용 감사 파일 0/6 미수록, (4) 후속 PR #2에서 `comparator/README.md`의 핵심 샌드박스·TCB 한계 고지 67줄(`L65–L131`)이 삭제된 점이 확인됩니다.
- Q3. "`seL4`나 `CompCert`처럼 하드웨어 ISA와 OS 시스콜 계층(`Arm64/Trusted`)을 정리 없는 공리적 TCB로 두는 것은 표준적인 관행 아닌가?"
  - 사실 확인: 맞습니다. `seL4`·`CompCert`와 마찬가지로 ISA·시스콜 명세를 정리 0건의 공리적 TCB로 두는 설계 자체는 표준적이며 본 감사는 그 점을 결함으로 삼지 않습니다. `Gate 1: HOLD`는 공리적 TCB 안에 커널·하드웨어·엔트로피 기준선과 어긋나는 4대 경계 미달분이 존재하기 때문입니다: `arm64-semantics/ProofLib/TrustedClosure.lean:328-360` `"Arm64" :: _ => true` 면제(커밋 `808b4b7ffef1`, `oai_ref` 미수록; 미수록 루트 `scripts/TrustedClosure.lean`과 별개), `Arm64/Trusted`의 `31 / 301+` 시스콜 제한 및 `Mmap.lean`의 `-ENOMEM` 미반환 `.OutOfMemory` 정지([thm_33](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean#L146), [thm_46](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean#L344)), `Hoare.lean` `.Exception` 177개 fail-closed 배제 및 `Spec.allowOom` OOM 면책([thm_30](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean#L92)), `AT_RANDOM` 0 초기화(`coins.rs` `.fill(0)`은 Class A 공시 범위이나 `HACL*`급 종단간 엔트로피 보장 밖) 및 Sail `(1, 13)` 폴트 스킵([thm_79](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean#L439)).
- Q4. "`ComparatorChallenge`가 통과했으니 명세 왜곡이나 공리 오염이 원천 차단된 것 아닌가?"
  - 사실 확인: [comparator/README.md](../proofs/oai_ref/comparator/README.md#L17-L18)은 `ComparatorChallenge`(`challenge_module`, 적대적 버그 주입인 `Symbolic/BugInjection/`과 별개)를 **`Trusted.`** 심판기 기준선으로 표기하고 `#L108-L116`에서 챌린지의 임포트 폐포가 신뢰됨을 명시합니다. 문제는 이 `ComparatorChallenge`가 326개 구현 파일(153,682줄)을 전이 임포트해 TCB 안으로 끌어들였으며([thm_53](../proofs/deepmind_comparator_laundering_and_crypto_bounds.lean#L60)), `"enable_nanoda": false`로 독립 커널 검증기를 끄고 Linux 5.10 러너에서 비샌드박스 상태로 빌드를 수행한다는 점입니다.
- Q5. "PQXDH와 SPQR V1이 결합되었으니 양자 컴퓨터 공격(HNDL) 방어 안전성이 증명된 것 아닌가?"
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

### 7.5 최종 심사 판정문 (Referee Verdict Summary)

- 최종 판정: TIER C (Conditional Verification & Non-Conforming Artifact): 조건부 범위 명시, `ComparatorChallenge` TCB 분리 및 미수록 검증 스크립트 공개 전 무수정 게재 불가
- Google DeepMind의 AlphaProof Code (`code-verification`, 2026년 11월 10일 `Gemini 4 Carbon` 및 `Claude Opus 5.5` 명세 교차 검토 공개본) 저장소(11,323개 파일, 7,528,295줄)는 추상 프로토콜 게임 감축과 일부 배치 AArch64 기계어 슬라이스(`mallocng` 등 9개, PR #2 19개 심볼)를 Lean 4 커널 안에서 연결한 유효한 컴퓨터 보조 형식검증 코어(Gate 5: PASS)를 포함하고 있다. 그러나 (1) 외부·런타임 경계 심볼 55 / 64(85.94%, PR #2 45 / 64 = 70.31%: 명세 훅 37개 + 패닉 스텁 18개, 직접 ELF 검증 9개[PR #2 이후 19개]; 암호 26개 + `Drop::drop` 영점화 2개 훅의 기계어 구현 정당성 및 dead-store 소거 미검증)와 기본 `lake build`의 `CliElfLib`(85,249줄) 제외, (2) `seL4`·`CompCert`형 공리적 `Arm64/Trusted` TCB(16,767줄) 내부의 4대 경계 미달분(`arm64-semantics/ProofLib/TrustedClosure.lean:328-360` `"Arm64" :: _ => true` 면제[커밋 `808b4b7ffef1`, `oai_ref` 미수록; 미수록 루트 `scripts/TrustedClosure.lean`과 별개]·`31 / 301+` 시스콜 제한·177개 fail-closed `.Exception` 및 `Spec.allowOom`(`mmap` `.OutOfMemory` 면책)·`AT_RANDOM` 0 초기화·`Exit` 미마스킹·Sail `(1, 13)` 폴트 스킵)과 전체 38건 `sorry` 중 `Synthetic/Disproofs/` 미완성 스텁 10건(정상 챌린지 자리표시자 24 + 부정 픽스처 4와 분리), (3) `Trusted.` 심판기 기준선(`Symbolic/BugInjection/`과 별개)인 `ComparatorChallenge`의 326개 파일(153,682줄) TCB 편입·`"enable_nanoda": false`·Linux 5.10 비샌드박스 실행 및 후속 PR #2의 `comparator/README.md` 67줄 고지 삭제, (4) Class A 자진 공시 운용·보안 경계(`coins.rs` `.fill(0)` 0 패딩[`Class A` 공시 경계로 인정하되 `HACL*`급 종단간 엔트로피 보장 밖], `DEV-PQ8`·`DEV-PQ9` `UNIX_EPOCH = 0` 시계 고정 하네스 전제, `DEV-PQ19` 고전 전용, `PQXDH.md:87-115` 구체적 여유 $q_{\mathrm{total}} \le 2^{24}$ 대 점근 $2^{40}$, `DEV-CLI21` `.base-keys` `56,680`회 미회전 프리키 상한[기존 세션 정상 유지])와 구분되는 Class B 미공시 결함(`DEV-C14` 8바이트 MAC 구수치 `38,967` 오기재 대 실제 $q = 35,211$, `check_refinement_hygiene.sh --self-test` 7/14 실패, 본문 인용 감사 파일 0/6 미수록)으로 인해 5대 관문 감사에서 TIER C (Conditional Verification & Non-Conforming Artifact)로 판정한다.
