# Google DeepMind AlphaProof Code (`code-verification`, `libsignal-cli`, 커밋 `808b4b7ffef1`): 포렌식 해부 및 형식 검증 보고서

- 언어 선택: [English (README.md)](./README.md) | 한국어 | 상위 목차: [ultari-proof-anatomy](../../README.ko.md)

본 해부는 Google DeepMind의 AlphaProof Code (`code-verification` 저장소, 2026년 10월 26일 초안 Formally Verifying Signal's Security Using AI 및 2026년 11월 10일 공식 공개본 [`Gemini 4 Carbon` 증명 생성 · `Claude Opus 5.5` 명세 교차 검토 · `libsignal v0.105.4` 대상 ~650만 줄 증명 포함], 초기 커밋 `808b4b7ffef198e6a91f71ed776d641a1c236882` 및 11월 11일 PR #2 `b0f729accbc2`, 총 11,323개 Lean 4 파일 · 7,528,295줄)를 대상으로 비기본 빌드 지층 격리(`CliElfLib`), 55/64 (85.94%) 바이너리 심볼 Hook 우회 단면(`808b4b7ffef1` 37개 훅 $\to$ 후속 PR #2 `b0f729accbc2` 27개 훅; 수학적 난제 가정과 별개로 컴파일된 AArch64 암호 구현[`HACL*`·`Fiat-Crypto`·`s2n-bignum`] 및 `Drop::drop` 영점화 dead-store 미검증), `check_refinement_hygiene.sh --self-test` 자체 실패(7/14 사멸 항목), 원고·`DEVIATIONS.md`에 자체 공시된 `ValidCall` 5대 이진 트레이스 제약·SPQR 고전 비퇴행(`DEV-PQ19`)·Rust CLI 하네스 0 패딩 `coins.rs`·`Waker::noop()` 동기 폴링·`UNIX_EPOCH = 0` 고정 시계(30일 서명 프리키 만료 우회) 대 구식 `DEV-C14` `38,967` 오기재 및 미수록 0/6 스크립트 분리, `seL4`·`CompCert`형 공리적 `Arm64/Trusted` TCB(16,767줄) 내부의 `31/301+` 시스콜·`mmap` `.OutOfMemory`·Sail `(1, 13)` 폴트 스킵 공백, **`Trusted.` 심판기 기준선(`Symbolic/BugInjection/`과 별개)인 `ComparatorChallenge`의 153,682줄 TCB 편입**(및 PR #2 `b0f729accbc2`의 `comparator/README.md` 67줄 Linux 5.10 unsandboxed 고지 삭제), `PQXDH.md` $q_{\mathrm{total}} = 2^{40}$ 표준 모델 공허화(17,441 / 16,384 > 1), SPQR V1 8바이트 MAC 공허화 절벽($q = 35,211$), `.base-keys` 56,680회 영구 먹통 절벽, 미커밋 AGPL-3.0-only 파생 ELF(617,448바이트) 및 미참조 `LibsignalBinary/Heap/`(22개 미러 파일) 부채를 해부하고, 독립적인 81개 Lean 4 정리(1,457줄, `leanprover/lean4:v4.29.0-rc8`, 0 sorry, 391/391 가설 변이 포착 = 100%, 74/81 구조적 정리, DoF>0: 65/81, nonlin: 10)로 재검증한 자료입니다.

## 1. 6단계 문서 색인 (en/ & ko/)

| 단계 | 한국어 가이드 (ko/) | 영어 가이드 (en/) | 핵심 수록 범위 |
| :---: | :--- | :--- | :--- |
| Tier 1 | [ko/01_일반인용_해설서.md](ko/01_일반인용_해설서.md) | [en/01_Executive_Summary_and_General_Guide.md](en/01_Executive_Summary_and_General_Guide.md) | 5대 인과 질문 및 13대 기술·전문 관점 요약: 비기본 타깃 CliElfLib 격리(85,249줄), 55/64 (85.94%) 바이너리 심볼 Hook 우회(암호 구현·영점화 dead-store 미검증), 자체 공시 coins.rs·UNIX_EPOCH 경계 대 미공시 결함, 16,767줄 공리적 Arm64/Trusted TCB의 시스콜·OOM·Sail 공백, Trusted. 심판기 ComparatorChallenge 153,682줄 TCB 편입, PQXDH.md 2^40 공허화·8바이트 MAC 절벽(q = 35,211)·.base-keys 56,680회 먹통 절벽·미커밋 AGPL-3.0-only ELF |
| Tier 2 | [ko/02_중급자용_수학및코드가이드.md](ko/02_중급자용_수학및코드가이드.md) | [en/02_Intermediate_Math_and_Code_Guide.md](en/02_Intermediate_Math_and_Code_Guide.md) | 3대 기둥 수리·ABI·프로토콜 파이프라인, 81개 정리(thm_01..thm_81) 1대1 매핑, 2분할 실시간 파서·기호 검증기 해설 |
| Tier 3 | [ko/03_전문가용_학술및수리물리보고서.md](ko/03_전문가용_학술및수리물리보고서.md) | [en/03_Expert_Forensic_and_Mathematical_Physics_Report.md](en/03_Expert_Forensic_and_Mathematical_Physics_Report.md) | 7,528,295줄 빌드·도달성 지층 분석, 13대 코드·암호·위협모델·하드웨어·프로덕션·유지보수·AGPL-3.0-only 전문 포렌식 절, 83/83 oai_ref/(59개 .lean + 24개 비-Lean) 마스터 색인, 반사 블록 디코더 대안 해법(18,373줄 절감) 및 16바이트 MAC 강성 장벽 |
| Tier 4 | [ko/04_자동검증및파서용_명세서.md](ko/04_자동검증및파서용_명세서.md) | [en/04_Automated_Verification_and_Parser_Spec.md](en/04_Automated_Verification_and_Parser_Spec.md) | 7종 산출물 암호학적 SHA-256 체크섬 원장 및 원클릭 결정론적 재현 명령 |
| Tier 5 | [ko/05_OPFF_상세형_포렌식심사보고서_DeepMind_Signal.md](ko/05_OPFF_상세형_포렌식심사보고서_DeepMind_Signal.md) | [en/05_OPFF_Detailed_Forensic_Referee_Report_DeepMind_Signal.md](en/05_OPFF_Detailed_Forensic_Referee_Report_DeepMind_Signal.md) | 5대 관문(제0부~제7부) 전수 감사 및 TIER C 공식 심사 판정서 |
| Tier 6 | [ko/06_OPFF_기본형_감사리포트_DeepMind_Signal.md](ko/06_OPFF_기본형_감사리포트_DeepMind_Signal.md) | [en/06_OPFF_Basic_Audit_Report_DeepMind_Signal.md](en/06_OPFF_Basic_Audit_Report_DeepMind_Signal.md) | 기본형 감사 요약서(8대 지표 요약표, 실측 oai_ref/ 좌표, 6문 6답 FAQ 및 TIER C 판정) |

## 2. 검증 산출물 (proofs/)

- [proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean](proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean#L1-L475) (Theorems 1-25, 76-77, 475줄, 27개 정리, 143/143 변이 포착, DoF>0: 24/27, nonlin: 1)
- [proofs/deepmind_arm64_tcb_and_syscall_divergences.lean](proofs/deepmind_arm64_tcb_and_syscall_divergences.lean#L1-L460) (Theorems 26-50, 78-79, 460줄, 27개 정리, 119/119 변이 포착, DoF>0: 20/27, nonlin: 3)
- [proofs/deepmind_comparator_laundering_and_crypto_bounds.lean](proofs/deepmind_comparator_laundering_and_crypto_bounds.lean#L1-L522) (Theorems 51-75, 80-81, 522줄, 27개 정리, 129/129 변이 포착, DoF>0: 21/27, nonlin: 6)
- [proofs/deepmind_signal_forensic_parsers.py](proofs/deepmind_signal_forensic_parsers.py#L1-L330) + [proofs/verify_symbolic_deepmind_signal.py](proofs/verify_symbolic_deepmind_signal.py#L1-L359) $\to$ [proofs/symbolic_verification_result.json](proofs/symbolic_verification_result.json#L1-L276)
- [proofs/problem_spec.md](proofs/problem_spec.md#L1-L19) & [manifest.json](manifest.json)

## 3. 1줄 검증 명령어

이 사례 폴더에서 아래 명령어를 실행하면 SHA-256 해시, Lean 4 커널, SymPy 재현, `#L` 링크 및 전칭 가설 돌연변이 시험을 일괄 검증합니다.

```bash
python3 ../../tools/verify_all.py --root .
```
