# Case 013: Google DeepMind `code-verification` (`libsignal-cli`, Commit `808b4b7ffef1`) : Forensic Anatomy & Formal Verification Package

> **한국어 안내**: [README.ko.md](README.ko.md) | **Parent Archive**: [Archive Main Index](../../README.md)

This case (`013-deepmind-code-verification`) dissects Google DeepMind's **`code-verification`** repository (commit `808b4b7ffef198e6a91f71ed776d641a1c236882`, accompanying the October 26, 2026 draft *Formally Verifying Signal's Security Using AI*), spanning **`11,323` Lean 4 files (`7,528,295` lines)** across `Computational/`, `Symbolic/`, `LibsignalBinary/`, `arm64-semantics/`, and `comparator/`. It audits non-default `CliElfLib` target isolation, the `55/64` (`85.94%`) binary symbol `Hook` bypass (`37` hooks in `808b4b7ffef1` $\to$ `27` hooks in subsequent `PR #2` `b0f729accbc2`), `check_refinement_hygiene.sh --self-test` failure (`7/14` stale entries), `ValidCall` `5`-clause binary trace restrictions and SPQR classical non-regression scope, the Rust CLI harness's zero-padded `coins.rs` `CryptoRng`, `Waker::noop()` single-poll executors, and frozen `UNIX_EPOCH` clock (`30`-day signed-prekey expiry bypass), the `16,767`-line unproved `Arm64/Trusted` TCB alongside Sail/Unicorn fault skips and hooked `Drop::drop` secret zeroization, `153,682`-line `ComparatorChallenge` TCB laundering (plus `PR #2` `b0f729accbc2`'s silent `67`-line `comparator/README.md` Linux `5.10` `unsandboxed` disclaimer deletion), `PQXDH.md` `q_total = 2^40` standard-model vacuity (`17,441 / 16,384 > 1`), the SPQR V1 `8`-byte MAC vacuity cliff (`q = 35,211`), the `.base-keys` `56,680`-key DoS cliff, and uncommitted `AGPL-3.0-only` `.GeneratedLean` ELF (`617,448` B) plus unimported `LibsignalBinary/Heap/` (`22` mirrored files) debt, re-verified via **`81` standalone Lean 4 theorems** (`1,457` lines on `leanprover/lean4:v4.29.0-rc8`, `0 sorry`, `391/391` hypothesis mutations caught = `100%`, `74/81` structural, `DoF>0: 65/81`, `nonlin: 10`).

---

## 1. Four-Tier Documentation Index (`en/` & `ko/`)

| Tier | English Guide (`en/`) | Korean Guide (`ko/`) | Core Scope |
| :---: | :--- | :--- | :--- |
| **Tier 1** | [`en/01_Executive_Summary_and_General_Guide.md`](en/01_Executive_Summary_and_General_Guide.md) | [`ko/01_일반인용_해설서.md`](ko/01_일반인용_해설서.md) | Five Causal Questions & 13 Technical/Domain Perspectives: non-default `CliElfLib` isolation (`85,249` lines), `55/64` (`85.94%`) binary symbol `Hook` bypass, zero-padded `coins.rs` RNG & frozen `UNIX_EPOCH` clock, `16,767`-line unproved `Arm64/Trusted` TCB + Sail/zeroize/side-channel gaps, `153,682`-line `ComparatorChallenge` TCB laundering, and `PQXDH.md` `2^40` vacuity + `8`-byte MAC (`q = 35,211`) + `.base-keys` `56,680` cliff + uncommitted `AGPL-3.0-only` ELF |
| **Tier 2** | [`en/02_Intermediate_Math_and_Code_Guide.md`](en/02_Intermediate_Math_and_Code_Guide.md) | [`ko/02_중급자용_수학및코드가이드.md`](ko/02_중급자용_수학및코드가이드.md) | Three-pillar mathematical, ABI, and protocol pipeline, `81`-theorem mapping (`thm_01`..`thm_81`), and two-module live parser + symbolic verifier walkthrough |
| **Tier 3** | [`en/03_Expert_Forensic_and_Mathematical_Physics_Report.md`](en/03_Expert_Forensic_and_Mathematical_Physics_Report.md) | [`ko/03_전문가용_학술및수리물리보고서.md`](ko/03_전문가용_학술및수리물리보고서.md) | Full `7,528,295`-line stratigraphy & reachability audit, 13 code/cryptographic/threat-model/hardware/production/maintainability/`AGPL-3.0-only` forensic subsections, `83/83` `oai_ref/` (`59` `.lean` + `24` non-Lean) `#L` master index, reflected block-decoder alternative (`18,373` decode lines saved), and `16`-byte MAC rigidity barrier |
| **Tier 4** | [`en/04_Automated_Verification_and_Parser_Spec.md`](en/04_Automated_Verification_and_Parser_Spec.md) | [`ko/04_자동검증및파서용_명세서.md`](ko/04_자동검증및파서용_명세서.md) | Cryptographic SHA-256 checksum ledger across all `7` proof artifacts and one-click reproduction commands |

---

## 2. Verification Artifacts (`proofs/`)

- [`proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean`](proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean#L1-L475) (`Theorems 1-25, 76-77`, `475` lines, `27` theorems, `143/143` mutations caught, `DoF>0: 24/27`, `nonlin: 1`)
- [`proofs/deepmind_arm64_tcb_and_syscall_divergences.lean`](proofs/deepmind_arm64_tcb_and_syscall_divergences.lean#L1-L460) (`Theorems 26-50, 78-79`, `460` lines, `27` theorems, `119/119` mutations caught, `DoF>0: 20/27`, `nonlin: 3`)
- [`proofs/deepmind_comparator_laundering_and_crypto_bounds.lean`](proofs/deepmind_comparator_laundering_and_crypto_bounds.lean#L1-L522) (`Theorems 51-75, 80-81`, `522` lines, `27` theorems, `129/129` mutations caught, `DoF>0: 21/27`, `nonlin: 6`)
- [`proofs/deepmind_signal_forensic_parsers.py`](proofs/deepmind_signal_forensic_parsers.py#L1-L330) + [`proofs/verify_symbolic_deepmind_signal.py`](proofs/verify_symbolic_deepmind_signal.py#L1-L359) $\to$ [`proofs/symbolic_verification_result.json`](proofs/symbolic_verification_result.json#L1-L276)
- [`proofs/problem_spec.md`](proofs/problem_spec.md#L1-L19) & [`manifest.json`](manifest.json#L1-L584)
