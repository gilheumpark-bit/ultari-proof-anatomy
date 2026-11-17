# Forensic & Referee Audit Report: Full Audit of Google DeepMind AlphaProof Code (code-verification, Formally Verifying Signal's Security Using AI, Commit 808b4b7ffef1)

## 0. Provenance Metadata & Cryptographic Seal Ledger

| Field | Verified Specification |
| :--- | :--- |
| Target Manuscript / Companion Docs | Formally Verifying Signal's Security Using AI (October 26, 2026 draft, accompanied by [DEVIATIONS.md](../proofs/oai_ref/Computational/docs/DEVIATIONS.md#L1-L3617) 3,617 lines, [PAPER_DIFFERENCES.md](../proofs/oai_ref/docs/Symbolic/PAPER_DIFFERENCES.md#L1-L337) 337 lines, [READING_THE_THEOREMS.md](../proofs/oai_ref/Computational/docs/READING_THE_THEOREMS.md#L1-L330) 330 lines, [PQXDH.md](../proofs/oai_ref/Computational/docs/PQXDH.md#L1-L136) 136 lines, and [PAPER_MAP.md](../proofs/oai_ref/docs/PAPER_MAP.md#L1-L252) 252 lines) |
| Target Code Repository & Commits | Google DeepMind AlphaProof Code (google-deepmind/code-verification, initial public commit 808b4b7ffef198e6a91f71ed776d641a1c236882 and follow-up PR #2 commit b0f729accbc2, spanning 11,323 .lean files · 7,528,295 lines: 11,314 importable modules 7,525,836 lines + 9 Lake build files 2,459 lines) |
| Companion Binary / Challenges | Statically linked AArch64 ELF .GeneratedLean/cli-elf/libsignal-cli.elf (617,448 bytes, SHA-256: `2f20c836342437a882b5882c34eab604e4f23b2b388c2b2a0696eeda51cddc7e`, uncommitted AGPL-3.0-only derivative absent from repo) / comparator challenge stubs (8 files, 343 lines; 8 + 16 = 24 JSON entries $\to$ 21 distinct theorems) |
| Compiler & Toolchain | Lean 4 v4.29.0-rc8 (leanprover/lean4:v4.29.0-rc8) / Python 3.14 (SymPy symbolic engine & live primary-source parsers) |
| Verification Artifact SHA-256 | • [deepmind_signal_stratigraphy_and_hook_boundary.lean](../proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean): `e58829f52915609cee169645f20d5501627bd0979309d4fdbc6f372099fc3dc1`<br>• [deepmind_arm64_tcb_and_syscall_divergences.lean](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean): `109d9e94c2165d3058828609c085ac7647c20492147880cd92440df52856b8f1`<br>• [deepmind_comparator_laundering_and_crypto_bounds.lean](../proofs/deepmind_comparator_laundering_and_crypto_bounds.lean): `5960b90f4ee0382bbc594054f4499be62f016a69089f729dc6123817b073d51c`<br>• [deepmind_signal_forensic_parsers.py](../proofs/deepmind_signal_forensic_parsers.py): `8d41db304ae88c0ccebd8119ff3e4de6824ad0e5a3384a66ff7e4cb5b2e4a05c`<br>• [verify_symbolic_deepmind_signal.py](../proofs/verify_symbolic_deepmind_signal.py): `4cc43598acf05cb2b062677e3a5bd9b55adec7eeaa32ecdf30f70954bb60cd00` |
| Verification Method | standalone Lean 4 suite of 81 theorems (1,457 lines, 0 sorry, 0 axiom, 391 / 391 universal hypothesis mutations killed = 100%, 74 / 81 structural, DoF > 0: 65 / 81, nonlin: 10) plus live parsing and symbolic verification across 83 preserved upstream reference files (59 .lean + 24 non-Lean) |
| Governing Audit Charter | Open Proof Forensics Foundation (OPFF) 5-Gate Joint International Audit Charter (COPE · IMU/AMS · ACM v1.1 · ICMJE/CRediT · NeurIPS, Charter DOI: [10.5281/zenodo.24241228](https://doi.org/10.5281/zenodo.24241228), Ledger v1.0.0 DOI: [10.5281/zenodo.24241229](https://doi.org/10.5281/zenodo.24241229)) |
| OPFF 5-Gate & Official Tier Verdict | Gate 1 (Kernel): HOLD (unproved 16,767-line Arm64/Trusted TCB & 38 sorry tokens) · Gate 2 (Artifact): FAIL (85.94% symbol Hook bypass, non-default CliElfLib isolation, DEV-C14 threshold drift) · Gate 3 (Ethics/Artifacts): FAIL (5 cited audit scripts + TRUSTED_BASE.md omitted & AGPL-3.0-only ELF uncommitted) · Gate 4 (Provenance): FAIL (153,682-line ComparatorChallenge TCB inclusion, enable_nanoda:false, & PR #2 removal of 67-line README caveat) · Gate 5 (Value): PASS $\implies$ OPFF TIER C (Conditional Verification & Non-Conforming Artifact) |



### 0.1 8-Metric Executive Scorecard (TL;DR)

| Audit Dimension | Claimed in Manuscript & Public Docs | Measured in Repository (Lean 4 / Arm64 / CLI / comparator) | Discrepancy / Status |
| :--- | :--- | :--- | :---: |
| 1. Build & Reachability | 11,323 files · 7,528,295 lines verified | Default lake build excludes 592 modules (267,194 lines) including CliElfLib (120 modules · 85,249 lines); 1,450 files (595,231 lines) unreachable from all 6 headlines | 595,231 Lines Unreachable |
| 2. Binary Hook Cut-Plane | End-to-end verification of compiled AArch64 libsignal-cli | 55 / 64 (85.94%) tracked symbols bypass machine-code execution (37 Lean hooks + 18 panics, including 2 Drop::drop zeroize hooks; only 9 = 14.06% execute ELF bytes) | 85.94% Hook Bypass |
| 3. Lowest-Layer ISA/Syscall TCB | Formal AArch64 ISA & Linux syscall semantics | `Arm64/Trusted/` 61 files (16,767 lines) contain 0 proved theorems; `Hoare.lean` (`Spec`/`SubroutineOutcome`/`reaches_outcome`) excludes 177 `.Exception` branches fail-closed while excusing `.OutOfMemory` via `Spec.allowOom`; 31 / 301+ syscalls modeled; `AT_RANDOM` zeroed | 16,767-Line Unproved TCB |
| 4. Rust CLI Harness Pinning | Verification of Signal session, prekey, RNG, and storage | [coins.rs](../proofs/oai_ref/third_party/libsignal/libsignal-session/cli/src/coins.rs#L32-L46) zero-pads exhausted CryptoRng buffers, clock frozen at UNIX_EPOCH = 0 (30-day SPK expiry bypassed), Waker::noop() single-poll, EBADF = 9 silent EOF | Harness Environment Pinned |
| 5. comparator TCB Boundary | External comparator prevents specification/axiom drift | ComparatorChallenge imports 326 files (153,682 lines) into the TCB; "enable_nanoda": false; Linux 5.10 < 5.13 unsandboxed build; PR #2 removes 67-line caveat section | 153,682-Line TCB Inclusion |
| 6. Post-Quantum & PQXDH Bound | Hybrid PQXDH + SPQR V1 security at 2^40 scale | Computational theorems prove classical security only (DEV-PQ19); at q_total = 2^40 in [PQXDH.md](../proofs/oai_ref/Computational/docs/PQXDH.md#L69-L112), the standard-model GapDH 5th term is 17,441 / 16,384 > 1 (vacuous) | 2^40 Bound Vacuous |
| 7. Session MAC & Prekey Cliffs | Multi-epoch ratchet & last-resort prekey operation | 8-byte MAC bound (DEV-C14) exceeds 1 at q = 35,211 (DEVIATIONS.md:2733 lists stale 38,967); .base-keys permanently rejects prekeys after 56,680 handshakes (> 2 MiB) | 35,211 / 56,680 Cliffs |
| 8. Reproducibility & Hygiene | Self-testing hygiene scripts & complete artifacts | [check_refinement_hygiene.sh](../proofs/oai_ref/Symbolic/scripts/check_refinement_hygiene.sh#L121-L136) --self-test fails (7/14 stale theorems, exit code 1); 5 cited audit scripts + TRUSTED_BASE.md absent (0 / 6 present); AGPL-3.0-only ELF uncommitted | Self-Test Fails / Absent |



### 0.2 3-Tier Traffic-Light Scope Summary

| Tier | Audited Subsystem & Artifact Scope | Formal Determination & Verification Status |
| :--- | :--- | :--- |
| Tier 1<br>(Verified Formal Verification Core) | • Abstract computational game reductions (Computational/Proofs, ACD19 + SPQR V1 classical non-regression)<br>• Symbolic trace invariants (Symbolic/Proofs) & placed AArch64 machine-code refinement across the 9 de-hooked symbols (mallocng alloc/free, memcpy, memset, file read)<br>• independent Lean 4 verification suite (81 theorems, 1,457 lines, 0 sorry, 391/391 hypothesis mutations caught) | Gate 5 (Mathematical & Engineering Value): PASS: Confirms the genuine computer-assisted formalization achievement connecting multi-stage cryptographic game reductions and placed AArch64 instruction slices in Lean 4 |
| Tier 2<br>(Conditional Interface & Pinned Harness Scope) | • 55 / 64 (85.94%, 45 / 64 = 70.31% after PR #2) boundary symbol Hook cut-plane (replacing all 26 cryptographic & `Drop::drop` zeroization routines with idealized Lean functions)<br>• `Arm64/Trusted/` 61-file (16,767-line) unproved ISA/syscall axiom base & `Hoare.lean` fail-closed `.Exception` restriction (`Spec`/`reaches_outcome`) alongside `Spec.allowOom` `.OutOfMemory` excuse<br>• `coins.rs` zero-padded RNG, `UNIX_EPOCH = 0` frozen clock, `ValidCall` 5-clause trace restriction, 1 GiB peak RAM & `FdsHiFrame` (`fd >= 3` closed) assumptions | Conditional Validity: Theorems hold strictly relative to idealized symbol hooks and fixed CLI harness invariants rather than production Signal deployments or general Linux processes |
| Tier 3<br>(Paper–Artifact Divergence & Non-Conforming Boundaries) | • ComparatorChallenge transitive import of 326 files (153,682 lines) into the TCB, "enable_nanoda": false, Linux 5.10 unsandboxed execution, & PR #2 removal of 67 caveat lines in comparator/README.md<br>• PQXDH.md q_total = 2^40 standard-model GapDH vacuity (17,441 / 16,384 > 1), DEV-C14 8-byte MAC vacuity at q = 35,211 (vs. stale 38,967), & .base-keys 56,680-handshake permanent rejection cliff<br>• Default lake build exclusion of CliElfLib (85,249 lines), failing check_refinement_hygiene.sh --self-test, & absence of 5 cited audit scripts, TRUSTED_BASE.md (missing), and the AGPL-3.0-only ELF | Gate 2·3·4: FAIL (Non-Conformance): Structural divergences between headline claims and executed artifacts/TCB boundaries preclude unmodified archival acceptance |



## Part I. Documentation Ledger Consistency & Missing Audit Script Audit

### 1.1 DEVIATIONS.md Count Discrepancy & Inline Scope-Restriction Tag Census

1. DEVIATIONS.md Summary Table (207) vs. Active Section Headers (206) vs. Undocumented Inline Tags (+4 = 210) ([thm_05_deviations_ledger_off_by_one_and_undocumented_tags](../proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean#L87)):
   - The summary table in [DEVIATIONS.md](../proofs/oai_ref/Computational/docs/DEVIATIONS.md#L103-L117) (`L109` AEAD claiming `15`, `L116` total claiming `207`, while `L105` is `SM = 27`) was not decremented after retiring `DEV-AEAD15` at `L3571` (`## Retired IDs`), leaving 206 active `### DEV-*` section headers (`14` active AEAD headers).
   - Conversely, 4 inline `DEV-*` identifiers present in .lean source comments (DEV-PQS-IDENTITY, unnumbered DEV-SM [L3609 lists only numbered DEV-SMn], DEV-TR-NS, DEV-TR-OOO) lack individual `### DEV-*` sections in DEVIATIONS.md, bringing the total deviation count to 206 + 4 = 210.
2. Census of 70 Bracketed Scope-Restriction Tags ([thm_06_inline_scope_disclaimer_tag_census](../proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean#L102)):
   - Across the .lean specifications, 70 bracketed scope-restriction tags partition into [INTENTIONAL_SCOPE] (30), [API_RESTRICTION] (15), [USER_VA_LIMIT] (10), [OVERPINNED_BEHAVIOR] (7), [INTENTIONAL_OVERAPPROX] (4), and [PARTIAL_SPEC] (4).

### 1.2 Audit of 5 Cited Scripts and TRUSTED_BASE.md Absent from the Repository (0 / 6 Present)

- Coordinates: [PAPER_MAP.md](../proofs/oai_ref/docs/PAPER_MAP.md#L1-L252), [DEVIATIONS.md](../proofs/oai_ref/Computational/docs/DEVIATIONS.md#L1-L120), and [thm_08_missing_audit_scripts_and_trusted_base_doc](../proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean#L137).
- Observed State: Six verification scripts and TCB documents cited in the repository documentation as the basis for axiom, TCB closure, sorry, bug-injection, and threshold audits are absent from the public repository tree (0 / 6 present):
  | # | Cited Path in Documentation | Documented Audit Role | Repository Status |
  | :---: | :--- | :--- | :---: |
  | 1 | scripts/HeadlineAxioms.lean | Kernel axiom dependency audit for headline theorems | Omitted (0 / 1) |
  | 2 | scripts/TrustedClosure.lean | Reverse-import TCB closure verification | Omitted (0 / 1) |
  | 3 | scripts/check_no_sorry.py | Repository-wide sorry token scanner | Omitted (0 / 1) |
  | 4 | scripts/bug_injection.py | Automated mutation and bug-injection runner | Omitted (0 / 1) |
  | 5 | scripts/bound_thresholds.py | Concrete cryptographic vacuity threshold calculator | Omitted (0 / 1) |
  | 6 | Computational/docs/TRUSTED_BASE.md | Computational Trusted Computing Base specification | Omitted (0 / 1) |



## Part II. Post-Release Notice Removal & Uncommitted Derivative Artifact Audit

### 2.1 Removal of 67 Caveat Lines from comparator/README.md in Follow-Up PR #2 (b0f729accbc2)

- Coordinates: [comparator/README.md](../proofs/oai_ref/comparator/README.md#L65-L131) (138 lines in initial commit 808b4b7ffef1 vs. 101 lines in follow-up PR #2 b0f729accbc2, November 11, 2026).
- Observed Diff:
  - In initial commit 808b4b7ffef1, comparator/README.md L65–L131 (67 lines) contained the section ## What this check does not cover, documenting at L112–L131 that (i) "Code that runs while the solution is elaborated could change the challenge before it is built" and (ii) "Landlock needs Linux >= 5.13; the GitHub On-Prem runners run 5.10 (run.sh prints the kernel), so landrun --best-effort confines nothing there and comparator's builds and exports run unsandboxed."
  - In follow-up PR #2 (b0f729accbc2), while "enable_nanoda": false and the pre-sandbox lake build remained unchanged, the 67-line block (L65–L131) containing ## What this check does not cover was removed (138 -> 101 lines).

### 2.2 .gitignore Exclusion of the 617,448-Byte AGPL-3.0-only ELF and Generated Lean Files

- Coordinates: [third_party/libsignal/README.md](../proofs/oai_ref/third_party/libsignal/README.md#L12-L59), [CliElf.lean](../proofs/oai_ref/LibsignalBinary/Specifications/SignalSession/CliElf.lean#L71-L73), and [thm_81_uncommitted_agpl_elf_and_unreferenced_heap_brittleness](../proofs/deepmind_comparator_laundering_and_crypto_bounds.lean#L507).
- Observed State:
  - Because .GeneratedLean/cli-elf/libsignal-cli.elf (617,448 bytes, SHA-256: `2f20c836342437a882b5882c34eab604e4f23b2b388c2b2a0696eeda51cddc7e`) is a derivative work of AGPL-3.0-only Signal source code, both the binary and .GeneratedLean/ byte-array modules are omitted (excluded via .gitignore, absent from the Apache-2.0 repository).
  - Because Rust panic metadata embeds exact source line numbers into the ELF image, any single-line comment change alters the binary SHA-256 and invalidates the 1,394 hardcoded hexadecimal PC decode lemmas.



## Part III. Harness Environment Pinning, Pre-Boot Memory Patch & Linker Stub Forensics

### 3.1 Rust CLI Harness: Zero-Padded CryptoRng, Frozen UNIX_EPOCH Clock & Single-Poll Executor

- Coordinates: [coins.rs](../proofs/oai_ref/third_party/libsignal/libsignal-session/cli/src/coins.rs#L32-L46), [cli/src/lib.rs](../proofs/oai_ref/third_party/libsignal/libsignal-session/cli/src/lib.rs#L90-L250), [handshake/src/lib.rs](../proofs/oai_ref/third_party/libsignal/libsignal-session/cli/handshake/src/lib.rs#L33-L65), [ratchet/src/lib.rs](../proofs/oai_ref/third_party/libsignal/libsignal-session/cli/ratchet/src/lib.rs#L36-L68), [cli/io/src/lib.rs](../proofs/oai_ref/third_party/libsignal/libsignal-session/cli/io/src/lib.rs#L41-L58), [stores.rs](../proofs/oai_ref/third_party/libsignal/libsignal-session/cli/src/stores.rs#L361-L445), and [thm_78_rust_harness_zero_rng_and_frozen_epoch_bypass](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean#L418).
- Observed Harness Behavior:
  1. Zero-Padded `CryptoRng` (`coins.rs:32-46`): When the input entropy slice is exhausted, `Coins::fill_bytes` pads the remainder of the destination buffer with zeros (`dst[now.len()..].fill(0)`) without raising an error, while implementing `rand_core::CryptoRng`.
  2. Frozen `UNIX_EPOCH = 0` Clock Bypassing 30-Day Expiry (`cli/src/lib.rs:140-250`, `DEV-PQ8`·`DEV-PQ9`): Every CLI subcommand pins the system timestamp to `SystemTime::UNIX_EPOCH` (`Timestamp::from_epoch_millis(0)`), bypassing the 30-day (`30 * 86,400 = 2,592,000`-second) signed-prekey (SPK) expiration and session staleness checks.
  3. Single-Poll Executor (`Waker::noop()`) & Silent `EBADF = 9`: Async protocol futures are driven via a single synchronous `poll_once` (`Context::from_waker(Waker::noop())`, `handshake/src/lib.rs#L58-L65`, `ratchet/src/lib.rs#L61-L68`), and `cli/io/src/lib.rs` treats closed file-descriptor errors (`EBADF = 9`) as normal 0-byte EOF on reads or success on writes (`stores.rs:373-374, 428-432` writes 37-byte `4B LE SignedPreKeyId + 0x05 + 32B pubkey` `.base-keys` records).

### 3.2 Pre-Boot .data 5-Byte Overwrite & alink_check.py udf #0 Trap Stubs

- Pre-Boot `.data` 5-Byte Patch ([Guards.lean#L140-L156](../proofs/oai_ref/LibsignalBinary/Specifications/LibsignalSpqrV1/Guards.lean#L140-L156), [CliBinaryPq.lean#L278-L280](../proofs/oai_ref/LibsignalBinary/Specifications/SignalSession/CliBinaryPq.lean#L278-L280), [thm_13](../proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean#L214), [thm_14](../proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean#L226)):
  - Because `Arm64/Trusted/ISA/Eval.lean` halts with `.Exception` on `MRS` system-register reads, `token_cells_initial` in [Guards.lean](../proofs/oai_ref/LibsignalBinary/Specifications/LibsignalSpqrV1/Guards.lean#L140-L156) (`0xff` at `0x9a038`, `[3,0,0,0]` at `0x9a048`) is overwritten to zeros before `main` by `Placed.cliTokenPatchPlaced` in [CliBinaryPq.lean](../proofs/oai_ref/LibsignalBinary/Specifications/SignalSession/CliBinaryPq.lean#L278-L280) to disable `cpufeatures` `getauxval(AT_HWCAP)` hardware probing.
- Linker Quarantine & udf #0 Stubs (stock.ld:1-177, alink_check.py:21-31, [thm_12](../proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean#L199), [thm_79](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean#L439)):
  - [stock.ld](../proofs/oai_ref/third_party/libsignal/libsignal-session/cli-elf/stock.ld#L1-L177) quarantines `.text.hooked.*` symbols into :text_a (< e_entry), while [alink_check.py](../proofs/oai_ref/scripts/stock-pin/alink_check.py#L21-L31) maps undefined external symbols and 3 outline atomic helpers (displaced_weak) to 4-byte udf #0 (0x00000000) trap stubs.



## Part IV. Proof Reachability Stratigraphy, Binary Hook Cut-Plane & ComparatorChallenge TCB Audit

### 4.1 Repository Build & Reachability Partition (11,323 Files · 7,528,295 Lines, [thm_01](../proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean#L25)–[thm_04](../proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean#L70), [thm_51](../proofs/deepmind_comparator_laundering_and_crypto_bounds.lean#L26))

| Stratum | File Count (Share) | Line Count (Share) | Structural Role & Reachability Status |
| :--- | :---: | :---: | :--- |
| Default lake build Targets (@[default_target]) | 10,722 (94.69%) | 7,258,642 (96.42%) | Compiled by default across Arm64, VerifiedLibraries, Computational, and Symbolic |
| Excluded from Default Build (8 Buckets) | 592 (5.23%) | 267,194 (3.55%) | Includes CliElfLib (120 modules · 85,249 lines) housing placed-ELF headline theorems F3 & C5 |
| Reachable from 6 Headline Entrypoints | 9,873 (87.19%) | 6,933,064 (92.09%) | Reverse-dependency closure of Main.lean, Lemmas.lean, ModelSecurity.lean, Refinement.lean, RefinementPreservation.lean, Security.lean |
| Unreachable Module Strata | 1,450 (12.81%) | 595,231 (7.91%) | Disconnected from all 6 headline entrypoints (including 22 mirrored files in LibsignalBinary/Heap/Fine/) |

### 4.2 Placed-ELF Boundary Symbol 55 / 64 (85.94%) Hook Cut-Plane ([thm_09](../proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean#L154)–[thm_11](../proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean#L185))

- Coordinates: [CliRun.lean](../proofs/oai_ref/LibsignalBinary/Specifications/SignalSession/CliRun.lean#L1-L495), [CliBinaryPq.lean](../proofs/oai_ref/LibsignalBinary/Specifications/SignalSession/CliBinaryPq.lean#L137-L482).
- Partition of the 64 Tracked Boundary Symbols:
  1. Executed as Placed ELF Bytes (cliDehookedSymsPlaced): 9 / 64 (14.06%): 5 Rust allocator symbols (__rust_no_alloc_shim_is_unstable_v2, __rust_alloc, __rust_dealloc, __rust_realloc, __rust_alloc_zeroed), memcpy, memset, read_file, and read_stdin (19 / 64 = 29.69% after PR #2 de-hooked 10 non-cryptographic helpers).
  2. Intercepted by Idealized Lean Functions (cliHookTablePlaced): 37 / 64 (57.81%):
     - 26 Cryptographic, Secret-Zeroization & Barrier Hooks: 5 symmetric primitives (compress256, compress512, libcrux_hmac::hmac, aes_256_cbc_encrypt, aes_256_cbc_decrypt) + 18 public-key/lattice operations (7 curve25519_dalek, 2 x25519_dalek, 2 mlkem1024, 7 mlkem768) + 2 X25519 Drop::drop secret-zeroization (zeroize) symbols + 1 core::hint::black_box (all 26 remain bypassed after PR #2).
     - 11 Non-Cryptographic I/O, Memory, Formatting & Clock Helpers: write_file, write_stdout, memmove, bcmp, strlen, memrchr, from_utf8, core::fmt::write, format_inner, SystemTime::duration_since, SystemTime::add (10 de-hooked in PR #2).
  3. Panic Traps (cliPanicSymbolsPlaced): 18 / 64 (28.13%): Immediate SIGABRT termination.
  - $\implies$ 37 + 18 = 55 / 64 (85.94%, or 45 / 64 = 70.31% after PR #2) symbols bypass AArch64 machine-code execution, leaving physical RAM/stack/register zeroization (Drop::drop) and constant-time side-channel properties unverified.

### 4.3 ComparatorChallenge 153,682-Line TCB Inclusion & Unsandboxed Execution ([thm_52](../proofs/deepmind_comparator_laundering_and_crypto_bounds.lean#L42)–[thm_57](../proofs/deepmind_comparator_laundering_and_crypto_bounds.lean#L149))

- Coordinates: [computational.json](../proofs/oai_ref/comparator/computational.json#L1-L20), [symbolic.json](../proofs/oai_ref/comparator/symbolic.json#L1-L24), [Computational.lean](../proofs/oai_ref/comparator/ComparatorChallenge/Computational.lean#L1-L21), [Symbolic.lean](../proofs/oai_ref/comparator/ComparatorChallenge/Symbolic.lean#L1-L22), [run.sh](../proofs/oai_ref/comparator/run.sh#L44-L48).
- Observed Facts:
  1. ComparatorChallenge transitively imports 326 repository files (153,682 lines, including ProofLib >= 92,732 lines) into the Trusted Computing Base (> 448x amplification relative to the 343 lines of challenge files).
  2. Both JSON configurations set "enable_nanoda": false, disabling the external kernel checker.
  3. run.sh:44-48 runs lake build --no-ansi outside landrun, and Landlock is inactive on the Linux 5.10 < 5.13 runner kernel.
  4. Of the 24 (8 + 16) JSON challenge entries, 3 placed-ELF/label theorems are duplicated, yielding 21 distinct theorems.



## Part V. Paper–Artifact Divergence, Lowest-Layer TCB Gaps & Cryptographic Vacuity Audit

### 5.1 Unproved 16,767-Line Arm64/Trusted TCB & Linux Syscall Divergences ([thm_26](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean#L24)–[thm_50](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean#L396))

| Audit Axis (File:Line) | Upper-Layer Assumption | Arm64/Trusted/ Implementation Reality | Verified Theorem |
| :--- | :--- | :--- | :--- |
| 1. Arm64/Trusted Theorem Count<br>(61 files · 16,767 lines) | Verified AArch64 ISA & syscall semantics | 0 proved theorem/lemma declarations across all 61 files (1,259 declarations); 199 non-normal exits (177 .Exception + 12 .OutOfMemory + 10 .trap) | [thm_26](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean#L24)–[thm_28](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean#L61) |
| 2. Fail-Closed `.Exception` Restriction & Excused `.OutOfMemory`<br>([Hoare.lean:124-222](../proofs/oai_ref/arm64-semantics/Arm64/Trusted/Spec/Hoare.lean#L124-L222)) | Callers prove postconditions / fault unreachability | `Spec` (`L160-165`), `SubroutineOutcome` (`L190-194`), `reaches_outcome` (`L208-209`), and `safe_until` (`L124-130`) exclude `.Exception` fail-closed (restricting the verified domain on 177 unmodeled paths), while `Spec.allowOom` (`onOom := ⌜True⌝`, `L178-179`) / `CliReachesOOMPlaced` (`DEV-CLI15`) excuses `.OutOfMemory` | [thm_30](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean#L92), [thm_31](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean#L109) |
| 3. Linux Syscall Coverage & `AT_RANDOM`<br>([Syscalls.lean:1-57](../proofs/oai_ref/arm64-semantics/Arm64/Trusted/Syscalls.lean#L1-L57), [Types.lean:120-121](../proofs/oai_ref/arm64-semantics/Arm64/Trusted/Process/Types.lean#L120-L121), [Loader.lean:377-427](../proofs/oai_ref/arm64-semantics/Arm64/Trusted/Process/Loader.lean#L377-L427)) | Faithful Linux userspace syscall environment | Models 31 of 301+ Linux AArch64 syscalls (270+ raise `.Exception`); ELF loader initializes all 16 bytes (128 bits) of `AT_RANDOM` to 0 | [thm_29](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean#L78), [thm_32](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean#L126) |
| 4. mmap Exhaustion Semantics<br>([Mmap.lean:176-202](../proofs/oai_ref/arm64-semantics/Arm64/Trusted/Syscalls/Mm/Mmap.lean#L176-L202)) | Linux mmap returns -ENOMEM (-12) on exhaustion | Halts the machine with .OutOfMemory instead of returning X0 = 0xfffffffffffffff4#64 (-12), masking caller NULL-pointer dereference paths behind excused OOM | [thm_33](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean#L146), [thm_45](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean#L331), [thm_46](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean#L344) |
| 5. `exit_group`, File I/O & Signals<br>([Exit.lean:1-44](../proofs/oai_ref/arm64-semantics/Arm64/Trusted/Syscalls/Kernel/Exit.lean#L1-L44), [ReadWrite.lean](../proofs/oai_ref/arm64-semantics/Arm64/Trusted/Syscalls/Fs/ReadWrite.lean#L110-L189), [ReadWritev.lean](../proofs/oai_ref/arm64-semantics/Arm64/Trusted/Syscalls/Fs/ReadWritev.lean#L100-L119), [Open.lean](../proofs/oai_ref/arm64-semantics/Arm64/Trusted/Syscalls/Fs/Open.lean#L163-L250), [Select.lean](../proofs/oai_ref/arm64-semantics/Arm64/Trusted/Syscalls/Fs/Select.lean#L1-L134)) | POSIX exit masking, file permissions & signals | `Exit.lean` omits `X0 & 0xff` masking; `ReadWrite.lean` clamps both `read` and `write` to `MAX_RW_COUNT` (faulting at `FS_SAFE_MAX_FILESIZE`), whereas `ReadWritev.lean` raises `.Exception` above `MAX_RW_COUNT`; `Open.lean` traps on non-`0o600` `O_CREAT` modes (`L249-250`) while omitting permission mode bits on pre-existing `FsState` files (`L163`); `Select.lean` traps on `ppoll` for `fd >= 3`; 0 `-EINTR` across 27 syscall files; `Signal.lean` never invokes `rt_sigaction` on synchronous faults; Sail/Unicorn ([TESTING.md:124-132](../proofs/oai_ref/arm64-semantics/Arm64/TESTING.md#L124-L132)) skips fault statuses (1, 13) and `DC ZVA`/`ADDV` | [thm_35](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean#L174)–[thm_44](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean#L291), [thm_79](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean#L439) |

### 5.2 Cryptographic Bound Vacuity & Documentation–Code Numerical Drift (Paper–Artifact Divergence)

| Divergence & Vacuity Axis | Documented Claim (DEVIATIONS.md / PQXDH.md / PAPER_MAP.md) | Active Code & Algebraic Measurement | Verified Theorem |
| :--- | :--- | :--- | :--- |
| 1. DEV-C14 8-Byte MAC Vacuity Drift<br>([DEVIATIONS.md:2712-2733](../proofs/oai_ref/Computational/docs/DEVIATIONS.md#L2712-L2733) vs. [StatementComposed.lean](../proofs/oai_ref/Computational/Specifications/Session/StatementComposed.lean#L1-L545)) | DEVIATIONS.md:2733 states that DEV-C14 crosses $2^{-32}$ at q = 9,459 (qep = 0) and exceeds 1 (vacuity) at q = 38,967 (qep = q) (copied from DEV-LS31) | Because DEV-C14 has numerator $12q^4 + 56q^3 + 96q^2 + 56q$, exceeding DEV-LS31 by $4q(q^3 + 2q^2 + 6q - 10) > 0$, it actually crosses $2^{-32}$ at q = 7,327 (qep = 0) and exceeds 1 at q = 35,211 (qep = q) ($18,448,187,719,356,341,620 > 2^{64}$, 3,756 queries earlier) | [thm_59](../proofs/deepmind_comparator_laundering_and_crypto_bounds.lean#L197)–[thm_64](../proofs/deepmind_comparator_laundering_and_crypto_bounds.lean#L279) |
| 2. `PQXDH.md` $q_{\mathrm{total}} = 2^{40}$ Standard-Model GapDH Vacuity & Classical Scope<br>([PQXDH.md:69-136](../proofs/oai_ref/Computational/docs/PQXDH.md#L69-L136), `DEV-PQ19`) | PQXDH + SPQR hybrid security at $q_{\mathrm{total}} = 2^{40}$ deployment scale | Computational theorems prove classical security only (`DEV-PQ19`); with 4-leg GapDH coefficient $c_3 = \frac{17441}{16384}\cdot 2^{60}$, Term 5 crosses `1` at $q_{\mathrm{total}} \ge 1,081,110,205,009 \approx 2^{39.98}$ and equals `17441 / 16384 > 1` at $q_{\mathrm{total}} = 2^{40}$ (vacuous, forcing retreat to $q_{\mathrm{total}} \le 2^{24}$ at `PQXDH.md:107-115`, `136` hand-computed). Single-key X25519+XEdDSA `GapSigEufCma` & `GapDhWithSign` Forking-Lemma loss (`DEV-PQ13`, standalone `XeddsaRom/`) remains outside the Lean TCB, `DEV-PQ16` enforces `P.isCanonical` subgroup guards (`is_torsion_free` hooked via `CliBinaryPq.lean:159-160`), and `DEV-PQ17` quotients `GapDhWithSign` modulo cofactor-8 `P.pow8` with $O(q_{\text{total}}^2)$ DDH queries | [thm_77](../proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean#L457), [thm_80](../proofs/deepmind_comparator_laundering_and_crypto_bounds.lean#L484) |
| 3. .base-keys 56,680-Handshake Permanent DoS Cliff<br>([PqDir.lean:1-463](../proofs/oai_ref/LibsignalBinary/Specifications/SignalSession/PqDir.lean#L1-L463), DEV-CLI21) | Ongoing deduplication of last-resort Kyber prekeys | Appending 37 bytes per key reaches $37 \times 56,679 = 2,097,123 \le 2^{21}$ and exceeds fileCapBytes = 2,097,152 B (2 MiB) at handshake 56,680 ($2,097,160$ B), permanently rejecting unrotated last-resort Kyber prekeys from handshake 56,681 onward | [thm_66](../proofs/deepmind_comparator_laundering_and_crypto_bounds.lean#L322), [thm_67](../proofs/deepmind_comparator_laundering_and_crypto_bounds.lean#L338) |
| 4. Cheval '26 Disproof Carrier Reuse & 38 sorry Tokens<br>([PAPER_MAP.md:216-238](../proofs/oai_ref/docs/PAPER_MAP.md#L216-L238)) | T-12(d): Symbolic disproof witnesses verify attack traces per vulnerability | 2 of 4 Cheval '26 CLI disproofs ([Cheval26SmallSubgroupTorsionCli.lean](../proofs/oai_ref/Symbolic/BugInjection/Disproofs/Cheval26SmallSubgroupTorsionCli.lean#L83-L93), [Cheval26WeakStateCli.lean](../proofs/oai_ref/Symbolic/BugInjection/Disproofs/Cheval26WeakStateCli.lean#L88-L98)) reuse another carrier theorem without proving dedicated attack traces, and all 10 files in Symbolic/BugInjection/Synthetic/Disproofs/ contain sorry (38 total sorry tokens = 24 challenge stubs + 10 synthetic disproofs + 4 fixtures) | [thm_07](../proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean#L119), [thm_55](../proofs/deepmind_comparator_laundering_and_crypto_bounds.lean#L95) |



## Part VI. Valid Proof Core Recognition (Gate 5: PASS), Independent Re-Verification & Repair Specification

### 6.1 Recognition of the Valid Computer-Assisted Formalization Core (Gate 5: PASS)

- Independently of the conditional boundaries above, two core engineering and mathematical accomplishments are verified in the Lean 4 kernel (Gate 5: PASS):
  1. Multi-Stage Game Reduction & Symbolic Trace Refinement: The formal reductions linking ACD19 Double Ratchet and SPQR V1 classical non-regression (Computational/Proofs) and the symbolic trace refinement (Symbolic/Proofs) typecheck cleanly in the Lean 4 kernel.
  2. Placed AArch64 Machine-Code Slices & mallocng Heap Refinement: Across the 9 de-hooked symbols (19 after PR #2), placed AArch64 instruction sequences and mallocng allocator invariants are mechanically verified against the Arm64 state machine.

### 6.2 OPFF Independent Lean 4 Re-Verification (81 Theorems, 391/391 Mutants Killed) & Structural Repairs

1. Reflection-Based Basic-Block Decoder Table Compression Saving 18,373 Lines (94.14%) ([thm_20](../proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean#L348)–[thm_23](../proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean#L381)):
   - Replacing 1,394 unrolled 14-line `*_decode_0x...` lemmas (k = 1,023 unique addresses + d = 371 duplicates = 19,516 lines) with a 120-line reflective block checker and a 1-line lookup entry per unique address (120 + 1,023 = 1,143 lines) saves 19,516 - 1,143 = 18,373 lines (94.14%):
     $$14(k + d) - (120 + k) = 13k + 14d - 120 = 18,373$$
2. Eliminating Single-Session MAC Vacuity via 16-Byte (128-Bit) Wire MAC Tags ([thm_65_rigidity_16byte_mac_eliminates_u32_session_vacuity](../proofs/deepmind_comparator_laundering_and_crypto_bounds.lean#L300)):
   - Extending the truncated wire MAC tag from 8 bytes ($2^{64}$) to 16 bytes ($2^{128}$) shifts the DEV-C14 vacuity threshold from q = 35,211 to q = 2,307,621,357 > q_u32_max = 2,147,471,145, eliminating single-session MAC vacuity across the entire reachable u32 ratchet counter range.
3. 5-Point Actionable Repair Specification:
   - (1) Strip the 153,682-line implementation import tree from ComparatorChallenge, set "enable_nanoda": true, run inside a Linux >= 5.13 Landlock sandbox, and restore the 67 deleted caveat lines in comparator/README.md;
   - (2) Include CliElfLib (120 modules) in @[default_target] in lakefile.lean and repair the 7 stale theorem names and LC_ALL=C sort bug in check_refinement_hygiene.sh;
   - (3) Update DEVIATIONS.md:2733 with the exact DEV-C14 thresholds (q = 7,327 and q = 35,211) and commit the 5 missing audit scripts and TRUSTED_BASE.md;
   - (4) Replace .OutOfMemory halting in Mmap.lean with Linux -ENOMEM (-12) return semantics and de-hook the 2 Drop::drop zeroization symbols;
   - (5) Explicitly label headline claims as [Conditional on 85.94% Symbol Hooks, 16,767-Line Unproved Arm64/Trusted TCB, Classical-Only DEV-PQ19, and q < 35,211 / 56,680 Operational Bounds].



## Part VII. International-Standard Non-Conformance Matrix, Pre-bunking FAQ & Final Verdict

### 7.1 International Publication & Verification Standards Non-Conformance Matrix (COPE · IMU/AMS · ACM v1.1 · ICMJE/CRediT · NeurIPS)

| Standard Category | Governing International Provision | Verified Physical Observation in Target Repository | Determination |
| :--- | :--- | :--- | :---: |
| Paper–Artifact Divergence (Gate 2) | ACM Artifact Review v1.1 / COPE Core Practices (1-to-1 correspondence between claimed verification scope/thresholds and executed artifacts) | • 55 / 64 (85.94%) boundary symbols (including all 26 cryptographic & Drop::drop zeroize hooks) bypass machine-code execution<br>• Default lake build excludes CliElfLib (85,249 lines), and DEVIATIONS.md:2733 lists q = 38,967 instead of the true DEV-C14 vacuity point q = 35,211<br>• At q_total = 2^40, PQXDH.md GapDH 5th term is 17,441 / 16,384 > 1 (vacuous), and DEV-PQ19 proves classical security only | Paper–Artifact Divergence (Gate 2: FAIL) |
| Provenance & Comparator TCB Non-Conformance (Gate 1·4) | IMU/AMS / NeurIPS Code & Data Guidelines (isolation of external comparator TCB and preservation of limitation disclosures) | • `ComparatorChallenge` pulls 326 files (153,682 lines) into the TCB, sets `"enable_nanoda": false`, and builds unsandboxed on Linux 5.10<br>• Follow-up PR #2 (`b0f729accbc2`) removes 67 lines (`L65–L131`) of sandbox/challenge caveats from `comparator/README.md`<br>• `Arm64/Trusted/` (61 files, 16,767 lines) has 0 proved theorems (`Hoare.lean` excludes 177 `.Exception` stops fail-closed while excusing `.OutOfMemory` via `Spec.allowOom`) | Non-Conformance (Gate 4: FAIL) |
| Artifact Omission Deficit (Gate 3) | ACM Reproducibility / COPE Data Guidelines (availability of cited verification scripts and target binaries) | • 5 cited audit scripts (HeadlineAxioms.lean, etc.) and TRUSTED_BASE.md are absent (0 / 6 present)<br>• check_refinement_hygiene.sh --self-test fails (7/14 stale items, exit code 1), and the 617,448-byte AGPL-3.0-only ELF is uncommitted | Artifact Omission (Gate 3: FAIL) |

### 7.2 Three-Tier Attribution Analysis (Human Foundations vs. Computer-Assisted ITP vs. Automated Pipeline)

1. Foundational Human Cryptographic & ISA Assets (0% Standalone AI Possibility):
   - Every security game and machine specification in the repository rests on human-authored cryptographic frameworks (Alwen–Coretti–Dodis ACD19, Kret–Schmidt PQXDH, Bhargavan et al. / Cheval et al. ProVerif models), the ARM Architecture Reference Manual (Sail AArch64 ISA specification), Signal's libsignal Rust/C codebase, and the manually written 16,767-line Arm64/Trusted TCB. Without these human-built foundations, the probability of an AI system formulating or verifying the problem independently is 0%.
2. Valid Computer-Assisted Formalization (Human Architecture + Automated Lean 4 Tactics) Core (Gate 5: PASS):
   - Within the human-designed Hoare-triple framework (ProofLib) and game-reduction spine, automated proof generation successfully discharged 1,394 PC decode lemmas and 470,030 stack-pointer (sp) offset forwarding steps across 9 de-hooked binary routines (mallocng alloc/free, memcpy, memset, file read), constituting a valid computer-assisted formalization core.
3. Divergence Introduced by the Automated Packaging & Evaluation Pipeline (Gate 2–4: FAIL):
   - The automated packaging and evaluation layer (i) routed 26 cryptographic and Drop::drop zeroization routines into cliHookTablePlaced rather than verifying their machine code, (ii) pulled 326 repository files (153,682 lines) into ComparatorChallenge's TCB with "enable_nanoda": false, (iii) left 10 sorry tokens in Symbolic/BugInjection/Synthetic/Disproofs/, and (iv) removed 67 lines of sandbox/TCB limitation disclosures from comparator/README.md in follow-up PR #2, creating a divergence between the conditional formal proof and unconditional end-to-end binary claims.

### 7.3 Pre-bunking Predictable Objections (FAQ: 6 Questions)

- Q1. "Didn't follow-up PR #2 (b0f729accbc2) resolve the hook bypass by de-hooking 10 symbols (9 -> 19 de-hooked)?"
  - Fact: All 10 symbols de-hooked in PR #2 are non-cryptographic memory, string, formatting, and time helpers (memmove, strlen, etc.). All 26 cryptographic, Drop::drop secret-zeroization, and barrier hooks (100%) remain bypassed after PR #2 ([thm_11](../proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean#L185)).
- Q2. "Aren't all deviations already documented transparently in DEVIATIONS.md (206 sections)?"
  - Fact: While DEVIATIONS.md provides extensive documentation, (1) its summary table (207) disagrees with the active section headers (206) and omits 4 inline `DEV-*` tags ([thm_05](../proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean#L87)), (2) DEVIATIONS.md:2733 misstates the DEV-C14 vacuity cliff as q = 38,967 rather than q = 35,211 ([thm_64](../proofs/deepmind_comparator_laundering_and_crypto_bounds.lean#L279)), and (3) follow-up PR #2 removed 67 lines of limitation disclosures (L65–L131) from comparator/README.md.
- Q3. "Isn't treating the ISA and OS syscall layer (Arm64/Trusted) as part of the TCB standard practice in binary verification?"
  - Fact: A sound ISA/syscall TCB cannot under-approximate fault states that mask memory-safety bugs. In `Arm64/Trusted`, `Mmap.lean` halts with `.OutOfMemory` instead of returning `-ENOMEM` (`-12`), masking caller NULL-dereference paths ([thm_33](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean#L146), [thm_46](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean#L344)), `Hoare.lean` restricts the verified input domain fail-closed across 177 unmodeled `.Exception` branches while excusing `.OutOfMemory` via `Spec.allowOom` ([thm_30](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean#L92)), and Sail differential testing skips fault statuses 1 and 13 ([thm_79](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean#L439)).
- Q4. "Doesn't passing the external comparator check guarantee that the theorem statements and axioms are uncorrupted?"
  - Fact: ComparatorChallenge transitively imports 326 implementation files (153,682 lines) into the TCB ([thm_53](../proofs/deepmind_comparator_laundering_and_crypto_bounds.lean#L60)), disables the external kernel checker ("enable_nanoda": false), and runs lake build outside the sandbox on Linux 5.10.
- Q5. "Doesn't the verification of PQXDH + SPQR V1 establish post-quantum (HNDL) security?"
  - Fact: As noted in DEV-PQ19, the computational theorems prove classical security only, and in PQXDH.md the standard-model GapDH 5th term exceeds 1 (17441 / 16384 > 1) at q_total = 2^40, restricting concrete security to q_total <= 2^24 ([thm_80](../proofs/deepmind_comparator_laundering_and_crypto_bounds.lean#L484)).
- Q6. "Doesn't a 7.53M-line Lean 4 repository prove that the entire codebase was verified end-to-end?"
  - Fact: Default lake build excludes 592 modules (267,194 lines) including CliElfLib (120 modules, 85,249 lines) ([thm_02](../proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean#L38), [thm_04](../proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean#L70)), and 1,450 files (595,231 lines) are unreachable from all 6 headline entrypoints ([thm_51](../proofs/deepmind_comparator_laundering_and_crypto_bounds.lean#L26)).

### 7.4 10-Second Terminal Reproduction (Don't Trust, Verify)

```bash
# 1) Run live parsing across all 83 preserved upstream files, SymPy checks & 81 Lean 4 theorems (EXIT 0)
python3 -B proofs/verify_symbolic_deepmind_signal.py

# 2) Verify all 7 SHA-256 checksums, 391/391 hypothesis mutations & #L line links (EXIT 0)
sha256sum -c proofs/checksums.sha256 && python3 -B ../../tools/verify_all.py --root .
```

### 7.5 Formal OPFF Referee Verdict Box

- Final Official Determination: OPFF TIER C (Conditional Verification & Non-Conforming Artifact): Major Revision Required Prior to Unqualified Binary/Post-Quantum Archival Acceptance
- Google DeepMind's AlphaProof Code (`code-verification`) repository (11,323 files, 7,528,295 lines) contains a valid computer-assisted formalization core linking abstract protocol game reductions and 9 de-hooked AArch64 machine-code routines in the Lean 4 kernel (Gate 5: PASS). However, (1) the 55 / 64 (85.94%) boundary symbol Hook bypass (including all 26 cryptographic and `Drop::drop` zeroization symbols) and exclusion of `CliElfLib` (85,249 lines) from default `lake build`, (2) the unproved 16,767-line `Arm64/Trusted` TCB (with 177 fail-closed `.Exception` stops and `Spec.allowOom` `.OutOfMemory` excusal), Linux syscall divergences (`mmap` `.OutOfMemory`, zeroed `AT_RANDOM`, unmasked `Exit`), and pinned CLI harness (`coins.rs` zero-padding, frozen `UNIX_EPOCH = 0` clock), (3) `ComparatorChallenge`'s inclusion of 326 files (153,682 lines) into the TCB alongside `"enable_nanoda": false`, Linux 5.10 unsandboxed execution, and PR #2's removal of 67 caveat lines from `comparator/README.md`, and (4) `PQXDH.md` $q_{\mathrm{total}} = 2^{40}$ standard-model GapDH vacuity ($17,441 / 16,384 > 1$, classical-only `DEV-PQ19`), `DEV-C14` 8-byte MAC vacuity at $q = 35,211$ (vs. stale 38,967), the `.base-keys` 56,680-handshake DoS cliff, and 6 omitted audit scripts/docs result in an overall determination of OPFF TIER C (Conditional Verification & Non-Conforming Artifact).
