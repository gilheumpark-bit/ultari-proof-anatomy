# Tier 4 Automated Verification & Parser Spec: Google DeepMind AlphaProof Code (`code-verification`, `libsignal-cli`, Commit `808b4b7ffef1`) SHA-256 Integrity & Reproduction Protocol

- Target Audience: Automated verification pipelines (tools/verify_all.py) and reproducibility auditors
- Navigation: [English Main README (README.md)](../README.md) | [Executive Summary (en/01_)](01_Executive_Summary_and_General_Guide.md) | [Intermediate Guide (en/02_)](02_Intermediate_Math_and_Code_Guide.md) | [Expert Forensic Report (en/03_)](03_Expert_Forensic_and_Mathematical_Physics_Report.md)



## 1. Cryptographic SHA-256 Checksum Ledger (`proofs/`)

| Artifact Path (`proofs/...`) | SHA-256 Checksum | Role & Verification Gate |
| :--- | :--- | :--- |
| [proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean](../proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean) | `e58829f52915609cee169645f20d5501627bd0979309d4fdbc6f372099fc3dc1` | Theorems 1-25, 76-77 (475 lines, 27 theorems: 11,323-file / 7,528,295-line build stratigraphy, non-default `CliElfLib` isolation, `DEVIATIONS.md` `207/206` off-by-one (`15` vs `14` AEAD) & 38 sorrys, 55/64 (85.94%) binary hook bypass, pre-boot 5-byte `.data` token patch, 1 GiB peak heap budget & `FdsHiFrame`, reflected block-decoder compression saving 18,373 lines, `check_refinement_hygiene.sh --self-test` 7/14 stale-entry failure, and `ValidCall` 5-clause + SPQR classical non-regression scope, 143/143 mutations caught) |
| [proofs/deepmind_arm64_tcb_and_syscall_divergences.lean](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean) | `109d9e94c2165d3058828609c085ac7647c20492147880cd92440df52856b8f1` | Theorems 26-50, 78-79 (460 lines, 27 theorems: 61-file / 16,767-line unproved `Arm64/Trusted` TCB census, 177 `.Exception` + 12 `.OutOfMemory` + 10 `.trap`, `Hoare.lean` fail-closed `.Exception` restriction vs `Spec.allowOom` `.OutOfMemory` excuse, 31 vs 301+ Linux syscalls, `Mmap`/`Exit`/`ReadWrite`/`ReadWritev`/`openat`/`ppoll` ABI divergences, Rust CLI `coins.rs` zero-fill tail & frozen `UNIX_EPOCH` 30-day expiry bypass, Sail/Unicorn fault skips, `udf #0` Class Z stubs, and 2 hooked `Drop::drop` zeroize symbols, 119/119 mutations caught) |
| [proofs/deepmind_comparator_laundering_and_crypto_bounds.lean](../proofs/deepmind_comparator_laundering_and_crypto_bounds.lean) | `5960b90f4ee0382bbc594054f4499be62f016a69089f729dc6123817b073d51c` | Theorems 51-75, 80-81 (522 lines, 27 theorems: 6-headline 9,873-file reachability vs 1,450 unreachable files, 24 -> 21 comparator deduplication, 153,682-line ComparatorChallenge TCB inclusion, "enable_nanoda": false, Cheval '26 2/4 carrier aliasing & 10 synthetic sorrys, DEV-C14 q = 35,211 vs stale 38,967, 16-byte MAC rigidity q = 2,307,621,357 > q_u32_max, .base-keys 56,680 cliff, PQXDH.md 2^40 vacuity (17,441/16,384 > 1), and uncommitted AGPL-3.0-only ELF + unimported Heap/ 22-file mirror, 129/129 mutations caught) |
| [proofs/deepmind_signal_forensic_parsers.py](../proofs/deepmind_signal_forensic_parsers.py) | `8d41db304ae88c0ccebd8119ff3e4de6824ad0e5a3384a66ff7e4cb5b2e4a05c` | Live regex and text extraction module over `proofs/oai_ref/` (83 upstream files: 59 .lean + 24 non-Lean) without hardcoded snapshot self-assertions (330 lines, every function <= 77 lines) |
| [proofs/verify_symbolic_deepmind_signal.py](../proofs/verify_symbolic_deepmind_signal.py) | `4cc43598acf05cb2b062677e3a5bd9b55adec7eeaa32ecdf30f70954bb60cd00` | Deterministic symbolic and kernel verification driver cross-checking all 13 perspectives, SymPy/Fraction bounds, and parallel Lean 4 kernel compilation of all 81 theorems to emit symbolic_verification_result.json (359 lines, every function <= 65 lines) |
| [proofs/symbolic_verification_result.json](../proofs/symbolic_verification_result.json) | `9f3da5893afca7f3b8c14461c773cc315fcaf5dfc4420f40a7223873d8d744b5` | Exact verification ledger for 55/64 binary symbol bypass, Rust CLI harness limits, check_refinement_hygiene.sh allowlists (38 slots), Arm64/Trusted ABI divergences + Sail skips + alink_check.py stubs, PQXDH.md 17,441/16,384 vacuity, DEV-C14 thresholds (35,211 vs 38,967), .base-keys 56,680 cliff, and 81-theorem Lean kernel receipt (276 lines) |
| [proofs/problem_spec.md](../proofs/problem_spec.md) | `6185e2dff33a84587d368a5c5ef40b22a16eb95e1ae6f63dcb9c38e9f15b05ae` | Problem specification, 83-file oai_ref/ preservation scope, and three-pillar / 13-perspective audit specification (19 lines) |



## 2. Deterministic One-Click Verification Commands

```bash
# 1. Cryptographic SHA-256 checksum verification (all 7 proof artifacts)
sha256sum -c proofs/checksums.sha256

# 2. Lean 4 kernel compilation check (0 sorry, 1,457 lines, 81 theorems)
lean proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean
lean proofs/deepmind_arm64_tcb_and_syscall_divergences.lean
lean proofs/deepmind_comparator_laundering_and_crypto_bounds.lean

# 3. Live parser, symbolic solver, and parallel Lean kernel verifier reproduction
python3 -B proofs/verify_symbolic_deepmind_signal.py

# 4. Full verification suite (391/391 mutations caught + DoF 65/81 + nonlin 10 + oai_ref 59/59 .lean 100%)
python3 -B ../../tools/verify_all.py --root .
```
