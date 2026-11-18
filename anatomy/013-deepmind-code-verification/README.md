# Google DeepMind AlphaProof Code (`code-verification`, `libsignal-cli`, Commit `808b4b7ffef1`): Forensic Anatomy & Formal Verification

- Language: English | [한국어 (README.ko.md)](./README.ko.md) | Main Index: [ultari-proof-anatomy](../../README.md)

This anatomy dissects Google DeepMind's AlphaProof Code (`code-verification` repository, accompanying the October 26, 2026 draft Formally Verifying Signal's Security Using AI and the November 10, 2026 public `AlphaProof Code` release using `Gemini 4 Carbon` + `Claude Opus 5.5` cross-model review targeting `libsignal v0.105.4` with ~6.5M proof lines; initial commit `808b4b7ffef198e6a91f71ed776d641a1c236882` and November 11 PR #2 `b0f729accbc2`), spanning 11,323 Lean 4 files (7,528,295 lines) across `Computational/`, `Symbolic/`, `LibsignalBinary/`, `arm64-semantics/`, and `comparator/`. It audits non-default `CliElfLib` target isolation, the 55/64 (85.94%) binary symbol Hook bypass (37 hooks in `808b4b7ffef1` $\to$ 27 hooks in PR #2 `b0f729accbc2`; leaving compiled AArch64 crypto implementation correctness [cf. `HACL*`/`Fiat-Crypto`/`s2n-bignum`] and `Drop::drop` zeroize dead-store elimination unverified beyond mathematical hardness assumptions), `check_refinement_hygiene.sh --self-test` failure (7/14 stale entries), self-disclosed harness/model bounds in `DEVIATIONS.md` (`ValidCall` 5-clause scope, classical-only `DEV-PQ19`, zero-padded `coins.rs` `CryptoRng`, `Waker::noop()` single-poll, frozen `UNIX_EPOCH = 0` clock) cleanly separated from stale `DEV-C14` `38,967` vs `35,211` and missing `0/6` audit scripts, custom syscall/OOM/Sail semantic gaps (`31/301+` syscalls, `mmap` `.OutOfMemory`, `TESTING.md` `(1, 13)` skips) inside the 16,767-line axiomatic `Arm64/Trusted` TCB (`seL4`/`CompCert`-style design), `Trusted.` judge baseline `ComparatorChallenge` (separate from `Symbolic/BugInjection/`) 153,682-line TCB inclusion (plus PR #2 `b0f729accbc2`'s 67-line `comparator/README.md` Linux 5.10 unsandboxed disclaimer removal), `PQXDH.md` $q_{\mathrm{total}} = 2^{40}$ standard-model vacuity (17,441 / 16,384 > 1), the SPQR V1 8-byte MAC vacuity cliff ($q = 35,211$), the `.base-keys` 56,680-key DoS cliff, and uncommitted AGPL-3.0-only `.GeneratedLean` ELF (617,448 B) plus unimported `LibsignalBinary/Heap/` (22 mirrored files) debt, re-verified via 81 standalone Lean 4 theorems (1,457 lines on `leanprover/lean4:v4.29.0-rc8`, 0 sorry, 391/391 hypothesis mutations caught = 100%, 74/81 structural, DoF>0: 65/81, nonlin: 10).

## 1. Six-Tier Documentation Index (en/ & ko/)

| Tier | English Guide (en/) | Korean Guide (ko/) | Core Scope |
| :---: | :--- | :--- | :--- |
| Tier 1 | [en/01_Executive_Summary_and_General_Guide.md](en/01_Executive_Summary_and_General_Guide.md) | [ko/01_일반인용_해설서.md](ko/01_일반인용_해설서.md) | Five Causal Questions & 13 Technical/Domain Perspectives: non-default CliElfLib isolation (85,249 lines), 55/64 (85.94%) binary symbol Hook bypass (compiled crypto/zeroize dead-store unverified), self-disclosed coins.rs/UNIX_EPOCH bounds vs undisclosed defects, 16,767-line axiomatic Arm64/Trusted TCB syscall/OOM/Sail gaps, Trusted. judge ComparatorChallenge 153,682-line TCB inclusion, and PQXDH.md 2^40 vacuity + 8-byte MAC (q = 35,211) + .base-keys 56,680 cliff + uncommitted AGPL-3.0-only ELF |
| Tier 2 | [en/02_Intermediate_Math_and_Code_Guide.md](en/02_Intermediate_Math_and_Code_Guide.md) | [ko/02_중급자용_수학및코드가이드.md](ko/02_중급자용_수학및코드가이드.md) | Three-pillar mathematical, ABI, and protocol pipeline, 81-theorem mapping (thm_01..thm_81), and two-module live parser + symbolic verifier walkthrough |
| Tier 3 | [en/03_Expert_Forensic_and_Mathematical_Physics_Report.md](en/03_Expert_Forensic_and_Mathematical_Physics_Report.md) | [ko/03_전문가용_학술및수리물리보고서.md](ko/03_전문가용_학술및수리물리보고서.md) | Full 7,528,295-line stratigraphy & reachability audit, 13 code/cryptographic/threat-model/hardware/production/maintainability/AGPL-3.0-only forensic subsections, 83/83 oai_ref/ (59 .lean + 24 non-Lean) #L master index, reflected block-decoder alternative (18,373 decode lines saved), and 16-byte MAC rigidity barrier |
| Tier 4 | [en/04_Automated_Verification_and_Parser_Spec.md](en/04_Automated_Verification_and_Parser_Spec.md) | [ko/04_자동검증및파서용_명세서.md](ko/04_자동검증및파서용_명세서.md) | Cryptographic SHA-256 checksum ledger across all 7 proof artifacts and one-click reproduction commands |
| Tier 5 | [en/05_OPFF_Detailed_Forensic_Referee_Report_DeepMind_Signal.md](en/05_OPFF_Detailed_Forensic_Referee_Report_DeepMind_Signal.md) | [ko/05_OPFF_상세형_포렌식심사보고서_DeepMind_Signal.md](ko/05_OPFF_상세형_포렌식심사보고서_DeepMind_Signal.md) | Standalone 5-Gate (Part 0–Part 7) forensic referee report & TIER C official determination |
| Tier 6 | [en/06_OPFF_Basic_Audit_Report_DeepMind_Signal.md](en/06_OPFF_Basic_Audit_Report_DeepMind_Signal.md) | [ko/06_OPFF_기본형_감사리포트_DeepMind_Signal.md](ko/06_OPFF_기본형_감사리포트_DeepMind_Signal.md) | Concise Basic Audit Summary (8-metric scorecard, verified oai_ref/ coordinates, 6-question FAQ & TIER C verdict) |

## 2. Verification Artifacts (proofs/)

- [proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean](proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean#L1-L475) (Theorems 1-25, 76-77, 475 lines, 27 theorems, 143/143 mutations caught, DoF>0: 24/27, nonlin: 1)
- [proofs/deepmind_arm64_tcb_and_syscall_divergences.lean](proofs/deepmind_arm64_tcb_and_syscall_divergences.lean#L1-L460) (Theorems 26-50, 78-79, 460 lines, 27 theorems, 119/119 mutations caught, DoF>0: 20/27, nonlin: 3)
- [proofs/deepmind_comparator_laundering_and_crypto_bounds.lean](proofs/deepmind_comparator_laundering_and_crypto_bounds.lean#L1-L522) (Theorems 51-75, 80-81, 522 lines, 27 theorems, 129/129 mutations caught, DoF>0: 21/27, nonlin: 6)
- [proofs/deepmind_signal_forensic_parsers.py](proofs/deepmind_signal_forensic_parsers.py#L1-L330) + [proofs/verify_symbolic_deepmind_signal.py](proofs/verify_symbolic_deepmind_signal.py#L1-L359) $\to$ [proofs/symbolic_verification_result.json](proofs/symbolic_verification_result.json#L1-L276)
- [proofs/problem_spec.md](proofs/problem_spec.md#L1-L19) & [manifest.json](manifest.json)

## 3. One-Command Verification

Run the deterministic verifier from this case directory to check SHA-256 hashes, Lean 4 compilation, SymPy reproduction, `#L` links, and all hypothesis mutations:

```bash
python3 ../../tools/verify_all.py --root .
```
