# [Case 013 / Tier 4 Automated Verification & Parser Spec] Google DeepMind `code-verification` (`libsignal-cli`, Commit `808b4b7ffef1`) SHA-256 Integrity & Reproduction Protocol

> **Target Audience**: Automated verification pipelines (`tools/verify_all.py`) and reproducibility auditors
> **Navigation**: [English Main README (`README.md`)](../README.md) | [Executive Summary (`en/01_`)](01_Executive_Summary_and_General_Guide.md) | [Intermediate Guide (`en/02_`)](02_Intermediate_Math_and_Code_Guide.md) | [Expert Forensic Report (`en/03_`)](03_Expert_Forensic_and_Mathematical_Physics_Report.md)

---

## 1. Cryptographic SHA-256 Checksum Ledger (`proofs/`)

| Artifact Path (`proofs/...`) | SHA-256 Checksum | Role & Verification Gate |
| :--- | :--- | :--- |
| [`proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean`](../proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean) | `f74ceceffc91ea0fa3b20c44c4b95dca4c1fd8694be364320dc130b249add4f0` | `Theorems 1-25, 76-77` (`475` lines, `27` theorems: `11,323`-file / `7,528,295`-line build stratigraphy, non-default `CliElfLib` isolation, `DEVIATIONS.md` `207/206` off-by-one & `38` `sorry`s, `55/64` (`85.94%`) binary hook bypass, pre-boot `5`-byte `.data` token patch, `1 GiB` peak heap budget & `FdsHiFrame`, reflected block-decoder compression saving `18,373` lines, `check_refinement_hygiene.sh --self-test` `7/14` stale-entry failure, and `ValidCall` `5`-clause + SPQR classical non-regression scope, `143/143` mutations caught) |
| [`proofs/deepmind_arm64_tcb_and_syscall_divergences.lean`](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean) | `433e50b87076690b5846ca7c3756de9aec2b62b02252ad4590b64c4add5a281b` | `Theorems 26-50, 78-79` (`460` lines, `27` theorems: `61`-file / `16,767`-line unproved `Arm64/Trusted` TCB census, `177` `.Exception` + `12` `.OutOfMemory` + `10` `.trap`, Hoare `.Exception` guard vacuity, `31` vs `301+` Linux syscalls, `Mmap`/`Exit`/`MAX_RW_COUNT`/`openat`/`ppoll` ABI divergences, Rust CLI `coins.rs` zero-fill tail & frozen `UNIX_EPOCH` `30`-day expiry bypass, Sail/Unicorn fault skips, `udf #0` Class `Z` stubs, and `2` hooked `Drop::drop` zeroize symbols, `119/119` mutations caught) |
| [`proofs/deepmind_comparator_laundering_and_crypto_bounds.lean`](../proofs/deepmind_comparator_laundering_and_crypto_bounds.lean) | `96e5aa6c46df7f73dd25aaa0964762625827eeeda8e080004011f70eba798a36` | `Theorems 51-75, 80-81` (`522` lines, `27` theorems: `6`-headline `9,873`-file reachability vs `1,450` unreachable files, `24 -> 21` `comparator` deduplication, `153,682`-line `ComparatorChallenge` TCB laundering, `"enable_nanoda": false`, Cheval '26 `2/4` carrier aliasing & `10` synthetic `sorry`s, `DEV-C14` `q = 35,211` vs stale `38,967`, `16`-byte MAC rigidity `q = 2,307,621,357 > q_u32_max`, `.base-keys` `56,680` cliff, `PQXDH.md` `2^40` vacuity (`17,441/16,384 > 1`), and uncommitted `AGPL-3.0-only` ELF + unimported `Heap/` `22`-file mirror, `129/129` mutations caught) |
| [`proofs/deepmind_signal_forensic_parsers.py`](../proofs/deepmind_signal_forensic_parsers.py) | `edfca45ae4417f1c1f46e14d3b9b733ddb1a40a5aec78be159e80ecb2416416b` | Live regex and text extraction module over `proofs/oai_ref/` (`83` upstream files: `59` `.lean` + `24` non-Lean) without hardcoded snapshot self-assertions (`330` lines, every function `<= 77` lines) |
| [`proofs/verify_symbolic_deepmind_signal.py`](../proofs/verify_symbolic_deepmind_signal.py) | `cfc6cac5be61baab7d8e5c8335a50b266894bb132ac4e967f475975df6c273f9` | Deterministic symbolic and kernel verification driver cross-checking all 13 perspectives, `SymPy`/`Fraction` bounds, and parallel Lean 4 kernel compilation of all `81` theorems to emit `symbolic_verification_result.json` (`359` lines, every function `<= 65` lines) |
| [`proofs/symbolic_verification_result.json`](../proofs/symbolic_verification_result.json) | `9f3da5893afca7f3b8c14461c773cc315fcaf5dfc4420f40a7223873d8d744b5` | Exact verification ledger for `55/64` binary symbol bypass, Rust CLI harness limits, `check_refinement_hygiene.sh` allowlists (`38` slots), `Arm64/Trusted` ABI divergences + Sail skips + `alink_check.py` stubs, `PQXDH.md` `17,441/16,384` vacuity, `DEV-C14` thresholds (`35,211` vs `38,967`), `.base-keys` `56,680` cliff, and `81`-theorem Lean kernel receipt (`276` lines) |
| [`proofs/problem_spec.md`](../proofs/problem_spec.md) | `a7e87de50ea3d2534e634abff62cc5f26e96944f8988c5b212857e770cd1df11` | Problem specification, `83`-file `oai_ref/` preservation scope, and three-pillar / 13-perspective audit specification (`19` lines) |

---

## 2. Deterministic One-Click Verification Commands

```bash
# 1. Cryptographic SHA-256 checksum verification (all 7 proof artifacts)
sha256sum -c proofs/checksums.sha256

# 2. Lean 4 kernel compilation check (0 sorry, 1,457 lines, 81 theorems)
~/.elan/bin/lean proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean
~/.elan/bin/lean proofs/deepmind_arm64_tcb_and_syscall_divergences.lean
~/.elan/bin/lean proofs/deepmind_comparator_laundering_and_crypto_bounds.lean

# 3. Live parser, symbolic solver, and parallel Lean kernel verifier reproduction
python3 -B proofs/verify_symbolic_deepmind_signal.py

# 4. Full verification suite (391/391 mutations caught + DoF 65/81 + nonlin 10 + oai_ref 59/59 .lean 100%)
python3 -B ../../tools/verify_all.py --root .
```
