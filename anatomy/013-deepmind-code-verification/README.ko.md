# Google DeepMind AlphaProof Code (`google-deepmind/code-verification`, `libsignal-cli`, 커밋 `808b4b7ffef1`): 포렌식 해부 및 형식 검증 보고서

- 언어 선택: [English (README.md)](./README.md) | 한국어 | 상위 목차: [ultari-proof-anatomy](../../README.ko.md)

본 해부는 Google DeepMind의 AlphaProof Code (`google-deepmind/code-verification` 저장소, 2026년 10월 26일 초안 Formally Verifying Signal's Security Using AI 및 2026년 11월 10일 공식 공개본 [`Gemini 4 Carbon` 증명 생성 · `Claude Opus 5.5` 명세 교차 검토 · `libsignal v0.105.4` 대상 ~650만 줄 증명 포함], 초기 커밋 `808b4b7ffef198e6a91f71ed776d641a1c236882` 및 11월 11일 PR #2 `b0f729accbc2`, 총 11,323개 Lean 4 파일 · 7,528,295줄)를 대상으로 비기본 빌드 지층 격리(`CliElfLib`), 55/64 (85.94%) 명세 훅 및 패닉 스텁 치환 단면(`808b4b7ffef1` 37개 훅 $\to$ 후속 PR #2 `b0f729accbc2` 27개 훅; 직접 ELF 검증 루틴 9개[PR #2 이후 19개]; 암호·배리어 26개 및 `Drop::drop` 영점화 2개 훅은 수학적 난제 가정과 별개로 컴파일된 AArch64 암호 구현[`HACL Star`·`Fiat-Crypto`·`s2n-bignum`] 및 `Drop::drop` dead-store 소거 미검증), 그리고 `DEVIATIONS.md` 및 `PQXDH.md`의 **Class A 자진 공시 운용·보안 경계**(`ValidCall` 5대 이진 트레이스 제약, 고전 전용 `DEV-PQ19`, `coins.rs` 0 패딩[`Class A` 공시이면서 `HACL*`급 종단간 엔트로피 보장 밖], `Waker::noop()` 동기 폴링, `UNIX_EPOCH = 0` 시계 고정 하네스 전제 `DEV-PQ8`/`DEV-PQ9`, `PQXDH.md:87-115` 점근적 $q_{\mathrm{total}} = 2^{40}$ 구간 [$17,441 / 16,384 > 1$] 대 구체적 보안 여유 $q_{\mathrm{total}} \le 2^{24}$, `DEV-CLI21` `.base-keys` `56,680`회 미회전 최후수단 Kyber 프리키 상한[기존 세션 정상 유지])과 **Class B 미공시 구식 수치·도구·TCB 경계 미달분**(`DEVIATIONS.md:2733` `DEV-C14` 구수치 `38,967` 대 실제 `35,211`, PR #2의 `comparator/README.md` 67줄 주의사항 삭제, `check_refinement_hygiene.sh --self-test` 7/14 실패 종료 코드 1, 미수록 0/6 루트 감사 파일[`scripts/TrustedClosure.lean` 등], 전체 38건 `sorry` 중 미완성 `Synthetic/Disproofs` 스텁 10건[정상 챌린지 자리표시자 24건 + 음성 픽스처 4건과 구분], `seL4`·`CompCert`·`HACL*` 기준 대비 4대 자체 `Arm64` TCB 경계 미달분[`arm64-semantics/ProofLib/TrustedClosure.lean:328-360`(업스트림 커밋 `808b4b7ffef1`, `oai_ref` 미수록)의 `VerifiedLibraries`/`CaseStudies`/`FormalRfcs` 한정 검사 및 `"Arm64" :: _ => true` 전면 면제 + `31/301+` 시스콜, `Hoare.lean` 199개 비정상 분기 및 `mmap` `.OutOfMemory` 정지로 인한 호출자 `NULL` 역참조 은닉, Sail `(1, 13)` 건너뛰기, `AT_RANDOM` 16바이트 0 초기화], **`Trusted.` 심판기 기준선(`Symbolic/BugInjection/`과 별개)인 `ComparatorChallenge`의 326개 파일·153,682줄 TCB 편입** + `"enable_nanoda": false`, 미커밋 AGPL-3.0-only 파생 ELF 617,448바이트 및 미참조 `LibsignalBinary/Heap/` 22개 미러 파일)를 분리 해부하고, 독립적인 81개 Lean 4 정리(1,457줄, `leanprover/lean4:v4.29.0-rc8`, 0 sorry, 391/391 가설 변이 포착 = 100%, 74/81 다변수·귀납 정리, 65/81 매개변수 정리, 10건 곱·4차 부등식)로 재검증한 자료입니다.

## 1. 6단계 문서 색인 (en/ & ko/)

| 단계 | 한국어 가이드 (ko/) | 영어 가이드 (en/) | 핵심 수록 범위 |
| :---: | :--- | :--- | :--- |
| Tier 1 | [ko/01_일반인용_해설서.md](ko/01_일반인용_해설서.md) | [en/01_Executive_Summary_and_General_Guide.md](en/01_Executive_Summary_and_General_Guide.md) | 5대 인과 질문 및 13대 기술·전문 관점 요약: 비기본 타깃 CliElfLib 격리(85,249줄), 55/64 (85.94%) 명세 훅 및 패닉 스텁 치환(직접 ELF 검증 9개[PR #2 이후 19개], 암호 26개 + Drop::drop 2개 훅), Class A 공시 경계(coins.rs 0 패딩·DEV-PQ8/PQ9 시계 고정·PQXDH.md q_total <= 2^24·DEV-CLI21 .base-keys 56,680 상한) 대 Class B 미공시 결함(DEV-C14 35,211 대 38,967·PR #2 67줄 삭제·자가시험 7/14 실패·미수록 6종), 4대 자체 Arm64 TCB 경계 미달분(`TrustedClosure.lean` `"Arm64" :: _ => true`, 시스콜/OOM/Sail/`AT_RANDOM`) 및 Trusted. ComparatorChallenge 326개/153,682줄 TCB 편입 |
| Tier 2 | [ko/02_중급자용_수학및코드가이드.md](ko/02_중급자용_수학및코드가이드.md) | [en/02_Intermediate_Math_and_Code_Guide.md](en/02_Intermediate_Math_and_Code_Guide.md) | 3대 기둥 수리·ABI·프로토콜 파이프라인, 81개 정리(thm_01..thm_81) 1대1 매핑, 2분할 실시간 파서·기호 검증기 해설 |
| Tier 3 | [ko/03_전문가용_학술및수리물리보고서.md](ko/03_전문가용_학술및수리물리보고서.md) | [en/03_Expert_Forensic_and_Mathematical_Physics_Report.md](en/03_Expert_Forensic_and_Mathematical_Physics_Report.md) | 7,528,295줄 빌드·도달성 지층 분석, 13대 코드·암호·위협모델·하드웨어·프로덕션·유지보수·AGPL-3.0-only 전문 포렌식 절, 83/83 oai_ref/(59개 .lean + 24개 비-Lean) 마스터 색인, 반사 블록 디코더 대안 해법(18,373줄 절감) 및 16바이트 MAC 강성 장벽 |
| Tier 4 | [ko/04_자동검증및파서용_명세서.md](ko/04_자동검증및파서용_명세서.md) | [en/04_Automated_Verification_and_Parser_Spec.md](en/04_Automated_Verification_and_Parser_Spec.md) | 7종 산출물 암호학적 SHA-256 체크섬 원장 및 원클릭 결정론적 재현 명령 |
| Tier 5 | [ko/05 상세형 포렌식 심사 보고서](ko/05_상세형_포렌식심사보고서_DeepMind_Signal.md) | [en/05 Detailed Forensic Referee Report](en/05_Detailed_Forensic_Referee_Report_DeepMind_Signal.md) | 5대 관문(제0부~제7부) 전수 감사 및 TIER C 공식 심사 판정서 |
| Tier 6 | [ko/06 기본형 감사 요약 리포트](ko/06_기본형_감사리포트_DeepMind_Signal.md) | [en/06 Basic Audit Summary Report](en/06_Basic_Audit_Report_DeepMind_Signal.md) | 기본형 감사 요약서(8대 지표 요약표, 실측 oai_ref/ 좌표, 6문 6답 FAQ 및 TIER C 판정) |

## 2. 검증 산출물 (proofs/)

- [proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean](proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean#L1-L475) (Theorems 1-25, 76-77, 475줄, 27개 정리, 143/143 변이 포착, 24/27 다변수 정리, 1건 곱 부등식)
- [proofs/deepmind_arm64_tcb_and_syscall_divergences.lean](proofs/deepmind_arm64_tcb_and_syscall_divergences.lean#L1-L460) (Theorems 26-50, 78-79, 460줄, 27개 정리, 119/119 변이 포착, 20/27 다변수 정리, 3건 곱 부등식)
- [제3기둥 비교기 TCB 및 암호 상계 모듈](proofs/deepmind_comparator_laundering_and_crypto_bounds.lean#L1-L522) (Theorems 51-75, 80-81, 522줄, 27개 정리, 129/129 변이 포착, 21/27 다변수 정리, 6건 곱·4차 부등식)
- [proofs/deepmind_signal_forensic_parsers.py](proofs/deepmind_signal_forensic_parsers.py#L1-L330) + [proofs/verify_symbolic_deepmind_signal.py](proofs/verify_symbolic_deepmind_signal.py#L1-L359) $\to$ [proofs/symbolic_verification_result.json](proofs/symbolic_verification_result.json#L1-L276)
- [proofs/problem_spec.md](proofs/problem_spec.md#L1-L19) & [manifest.json](manifest.json)

## 3. 1줄 검증 명령어

이 사례 폴더에서 아래 명령어를 실행하면 SHA-256 해시, Lean 4 커널, SymPy 재현, `#L` 링크 및 전칭 가설 돌연변이 시험을 일괄 검증합니다.

```bash
python3 ../../tools/verify_all.py --root .
```
