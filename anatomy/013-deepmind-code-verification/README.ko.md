# Case 013: Google DeepMind `code-verification` (`libsignal-cli`, 커밋 `808b4b7ffef1`) : 포렌식 해부 및 형식 검증 패키지

> **English Guide**: [README.md](README.md) | **상위 아카이브**: [아카이브 메인 색인](../../README.ko.md)

이 케이스(`013-deepmind-code-verification`)는 Google DeepMind의 **`code-verification`** 저장소(커밋 `808b4b7ffef198e6a91f71ed776d641a1c236882`, 2026년 10월 26일 초안 *Formally Verifying Signal's Security Using AI* 동반 저장소, 총 **`11,323`개 Lean 4 파일 · `7,528,295`줄**)를 대상으로 비기본 빌드 지층 격리(`CliElfLib`), `55/64` (`85.94%`) 바이너리 심볼 `Hook` 우회 단면(`808b4b7ffef1` `37`개 훅 $\to$ 후속 `PR #2` `b0f729accbc2` `27`개 훅), `check_refinement_hygiene.sh --self-test` 자체 실패(`7/14` 사멸 항목), `ValidCall` `5`대 이진 트레이스 제약 및 SPQR 고전 비퇴행 범위, Rust CLI 하네스의 `0` 패딩 `coins.rs` 난수기·`Waker::noop()` 동기 폴링 및 `UNIX_EPOCH` 고정 시계(`30`일 서명 프리키 만료 우회), `16,767`줄 무증명 `Arm64/Trusted` TCB 시스콜 괴리 및 Sail·부채널·`Drop::drop` 영점화 후킹 공백, `153,682`줄 `ComparatorChallenge` 신뢰 기반 세탁(및 `PR #2` `b0f729accbc2`의 `comparator/README.md` `67`줄 Linux `5.10` `unsandboxed` 자백 무음 삭제), `PQXDH.md` `q_total = 2^40` 표준 모델 공허화(`17,441 / 16,384 > 1`), SPQR V1 `8`바이트 MAC 공허화 절벽(`q = 35,211`), `.base-keys` `56,680`회 영구 먹통 절벽, 미커밋 `AGPL-3.0-only` 파생 ELF(`617,448`바이트) 및 미참조 `LibsignalBinary/Heap/`(`22`개 미러 파일) 부채를 해부하고, 독립적인 **`81`개 Lean 4 정리**(`1,457`줄, `leanprover/lean4:v4.29.0-rc8`, `0 sorry`, `391/391` 가설 변이 포착 = `100%`, `74/81` 구조적 정리, `DoF>0: 65/81`, `nonlin: 10`)로 재검증한 패키지입니다.

---

## 1. 4단계 한·영 문서 색인 (`en/` & `ko/`)

| 단계 | 한국어 가이드 (`ko/`) | 영어 가이드 (`en/`) | 핵심 수록 범위 |
| :---: | :--- | :--- | :--- |
| **Tier 1** | [`ko/01_일반인용_해설서.md`](ko/01_일반인용_해설서.md) | [`en/01_Executive_Summary_and_General_Guide.md`](en/01_Executive_Summary_and_General_Guide.md) | 5대 인과 질문 및 13대 기술·전문 관점 요약: 비기본 타깃 `CliElfLib` 격리(`85,249`줄), `55/64` (`85.94%`) 바이너리 심볼 `Hook` 우회, `coins.rs` 영점 패딩 난수기·`UNIX_EPOCH` 고정 시계, `16,767`줄 무증명 `Arm64/Trusted` TCB 및 Sail·영점화·부채널 공백, `153,682`줄 `ComparatorChallenge` 세탁, `PQXDH.md` `2^40` 공허화·`8`바이트 MAC 절벽(`q = 35,211`)·`.base-keys` `56,680`회 먹통 절벽·미커밋 `AGPL-3.0-only` ELF |
| **Tier 2** | [`ko/02_중급자용_수학및코드가이드.md`](ko/02_중급자용_수학및코드가이드.md) | [`en/02_Intermediate_Math_and_Code_Guide.md`](en/02_Intermediate_Math_and_Code_Guide.md) | 3대 기둥 수리·ABI·프로토콜 파이프라인, `81`개 정리(`thm_01`..`thm_81`) 1대1 매핑, 2분할 실시간 파서·기호 검증기 해설 |
| **Tier 3** | [`ko/03_전문가용_학술및수리물리보고서.md`](ko/03_전문가용_학술및수리물리보고서.md) | [`en/03_Expert_Forensic_and_Mathematical_Physics_Report.md`](en/03_Expert_Forensic_and_Mathematical_Physics_Report.md) | `7,528,295`줄 빌드·도달성 지층 분석, 13대 코드·암호·위협모델·하드웨어·프로덕션·유지보수·`AGPL-3.0-only` 전문 포렌식 절, `82/82` `oai_ref/`(`59`개 `.lean` + `23`개 비-Lean) 마스터 색인, 반사 블록 디코더 대안 해법(`18,373`줄 절감) 및 `16`바이트 MAC 강성 장벽 |
| **Tier 4** | [`ko/04_자동검증및파서용_명세서.md`](ko/04_자동검증및파서용_명세서.md) | [`en/04_Automated_Verification_and_Parser_Spec.md`](en/04_Automated_Verification_and_Parser_Spec.md) | `7`종 산출물 암호학적 SHA-256 체크섬 원장 및 원클릭 결정론적 재현 명령 |

---

## 2. 검증 산출물 (`proofs/`)

- [`proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean`](proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean#L1-L475) (`Theorems 1-25, 76-77`, `475`줄, `27`개 정리, `143/143` 변이 포착, `DoF>0: 24/27`, `nonlin: 1`)
- [`proofs/deepmind_arm64_tcb_and_syscall_divergences.lean`](proofs/deepmind_arm64_tcb_and_syscall_divergences.lean#L1-L460) (`Theorems 26-50, 78-79`, `460`줄, `27`개 정리, `119/119` 변이 포착, `DoF>0: 20/27`, `nonlin: 3`)
- [`proofs/deepmind_comparator_laundering_and_crypto_bounds.lean`](proofs/deepmind_comparator_laundering_and_crypto_bounds.lean#L1-L522) (`Theorems 51-75, 80-81`, `522`줄, `27`개 정리, `129/129` 변이 포착, `DoF>0: 21/27`, `nonlin: 6`)
- [`proofs/deepmind_signal_forensic_parsers.py`](proofs/deepmind_signal_forensic_parsers.py#L1-L330) + [`proofs/verify_symbolic_deepmind_signal.py`](proofs/verify_symbolic_deepmind_signal.py#L1-L359) $\to$ [`proofs/symbolic_verification_result.json`](proofs/symbolic_verification_result.json#L1-L272)
- [`proofs/problem_spec.md`](proofs/problem_spec.md#L1-L19) & [`manifest.json`](manifest.json#L1-L584)
