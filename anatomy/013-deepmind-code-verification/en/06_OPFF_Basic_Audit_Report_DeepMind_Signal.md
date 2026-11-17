# Audit Summary: Google DeepMind AlphaProof Code (code-verification, Formally Verifying Signal's Security Using AI, Commit 808b4b7ffef1)

- Target (Repository / Companion Docs): Google DeepMind AlphaProof Code ([google-deepmind/code-verification](https://github.com/google-deepmind/code-verification), initial commit `808b4b7ffef1` and follow-up PR #2 commit `b0f729accbc2` · October 26, 2026 draft, [DEVIATIONS.md](../proofs/oai_ref/Computational/docs/DEVIATIONS.md#L1-L3617) 3,617 lines, [PAPER_DIFFERENCES.md](../proofs/oai_ref/docs/Symbolic/PAPER_DIFFERENCES.md#L1-L337) 337 lines, [READING_THE_THEOREMS.md](../proofs/oai_ref/Computational/docs/READING_THE_THEOREMS.md#L1-L330) 330 lines, [PQXDH.md](../proofs/oai_ref/Computational/docs/PQXDH.md#L1-L136) 136 lines, [PAPER_MAP.md](../proofs/oai_ref/docs/PAPER_MAP.md#L1-L252) 252 lines; 11,323 `.lean` files · 7,528,295 lines + AArch64 ELF `libsignal-cli.elf` 617,448 bytes)
- Verification Toolchain: Lean 4 v4.29.0-rc8 / Python 3.14 (SymPy symbolic engine & live primary-source parsers)
- Artifact Checksums (SHA-256): [deepmind_signal_stratigraphy_and_hook_boundary.lean](../proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean) (e58829f52915...) | [deepmind_arm64_tcb_and_syscall_divergences.lean](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean) (109d9e94c216...) | [deepmind_comparator_laundering_and_crypto_bounds.lean](../proofs/deepmind_comparator_laundering_and_crypto_bounds.lean) (5960b90f4ee0...) | [deepmind_signal_forensic_parsers.py](../proofs/deepmind_signal_forensic_parsers.py) (8d41db304ae8...) | [verify_symbolic_deepmind_signal.py](../proofs/verify_symbolic_deepmind_signal.py) (4cc43598acf0...)
- Verification Method: 81 independent Lean 4 theorems (1,457 lines, 0 sorry, 0 axiom, 391 / 391 universal-hypothesis mutations killed = 100%) & live parser verification across 83 preserved upstream files (59 .lean + 24 non-Lean)
- OPFF Formal Verdict: Gate 1: HOLD · Gate 2: FAIL · Gate 3: FAIL · Gate 4: FAIL · Gate 5: PASS ⇒ OPFF TIER C (Conditional Verification & Non-Conforming Artifact)

## 0. 8-Metric Executive Scorecard (TL;DR)

| Audit Dimension | Claimed in Manuscript & Public Docs | Measured in Repository (Lean 4 / Arm64 / CLI / comparator) | Discrepancy / Status |
| :--- | :--- | :--- | :---: |
| 1. Build & Reachability | 11,323 files · 7,528,295 lines verified | Default lake build excludes 592 modules (267,194 lines) including CliElfLib (120 modules · 85,249 lines); 1,450 files (595,231 lines) unreachable from all 6 headlines | 595,231 Lines Unreachable (CP-05) |
| 2. Binary Hook Cut-Plane | End-to-end verification of compiled AArch64 libsignal-cli | 55 / 64 (85.94%) tracked symbols bypass machine-code execution (37 Lean hooks + 18 panics, including 2 Drop::drop zeroize hooks; only 9 = 14.06% execute ELF bytes) | 85.94% Hook Bypass (CP-02 · CP-04) |
| 3. Lowest-Layer ISA/Syscall TCB | Formal AArch64 ISA & Linux syscall semantics | `Arm64/Trusted/` 61 files (16,767 lines) contain 0 proved theorems; `Hoare.lean` (`Spec`/`reaches_outcome`) excludes 177 `.Exception` branches fail-closed while `Spec.allowOom` excuses `.OutOfMemory`; 31 / 301+ syscalls modeled; `AT_RANDOM` zeroed | 16,767-Line Unproved TCB (Gate 1 HOLD) |
| 4. Rust CLI Harness Pinning | Verification of Signal session, prekey, RNG, and storage | [coins.rs](../proofs/oai_ref/third_party/libsignal/libsignal-session/cli/src/coins.rs#L32-L46) zero-pads exhausted CryptoRng buffers, clock frozen at UNIX_EPOCH = 0 (30-day SPK expiry bypassed), Waker::noop() single-poll, EBADF = 9 silent EOF | Harness Pinned (CP-02 · CP-04) |
| 5. comparator TCB Boundary | External comparator prevents specification/axiom drift | ComparatorChallenge imports 326 files (153,682 lines) into the TCB; "enable_nanoda": false; Linux 5.10 < 5.13 unsandboxed build; PR #2 removes 67-line caveat section | 153,682-Line TCB Inclusion (CP-07) |
| 6. Post-Quantum & PQXDH Bound | Hybrid PQXDH + SPQR V1 security at $2^{40}$ scale | Computational theorems prove classical security only (DEV-PQ19); at $q_{\text{total}} = 2^{40}$ in [PQXDH.md](../proofs/oai_ref/Computational/docs/PQXDH.md#L69-L112), the standard-model GapDH 5th term is $17,441 / 16,384 > 1$ (vacuous) | $2^{40}$ Bound Vacuous (CP-02) |
| 7. Session MAC & Prekey Cliffs | Multi-epoch ratchet & last-resort prekey operation | 8-byte MAC bound (DEV-C14) exceeds 1 at $q = 35,211$ (DEVIATIONS.md:2733 lists stale 38,967); .base-keys permanently rejects prekeys after 56,680 handshakes ($> 2\text{ MiB}$) | 35,211 / 56,680 Cliffs (CP-04) |
| 8. Reproducibility & Hygiene | Self-testing hygiene scripts & complete artifacts | [check_refinement_hygiene.sh](../proofs/oai_ref/Symbolic/scripts/check_refinement_hygiene.sh#L121-L136) --self-test fails (7/14 stale theorems, exit code 1); 5 cited audit scripts + TRUSTED_BASE.md absent (0 / 6 present); AGPL-3.0-only ELF uncommitted | Self-Test Fails / 6 Absent (CP-03 · CP-07) |

## 1. Summary of Verified Physical Findings

### 1.1 85.94% Symbol Hook Bypass, 16,767-Line Unproved Arm64 TCB & Non-Default CliElfLib Build (CP-02, CP-04, CP-05)
- 55 / 64 (85.94%) Tracked Binary Symbols Bypass AArch64 Execution: Across the 64 tracked symbols in placed binary verification (45 / 64 = 70.31% after PR #2), 37 Lean specification hooks and 18 panic stubs (including 2 Drop::drop secret-zeroization hooks) bypass AArch64 machine-code stepping, leaving only 9 symbols (14.06%: mallocng alloc/free, memcpy, memset, file read) instruction-stepped ([deepmind_signal_stratigraphy_and_hook_boundary.lean](../proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean#L1)).
- 16,767-Line Unproved ISA/Syscall Base & 595,231 Unreachable Lines: Arm64/Trusted/ (61 files, 16,767 lines) contains 0 proved theorems (with 38 sorry tokens across the repository), and default lake build excludes 592 modules (267,194 lines) including CliElfLib (120 modules, 85,249 lines), while 1,450 files (595,231 lines) are unreachable from all 6 headline theorems.

### 1.2 Pinned CLI Harness (Zero-Padded RNG & Frozen Clock) and 153,682-Line Comparator TCB Inclusion (CP-02, CP-07)
- Zero-Padded Exhausted RNG & Frozen UNIX_EPOCH = 0 Clock: [coins.rs](../proofs/oai_ref/third_party/libsignal/libsignal-session/cli/src/coins.rs#L32-L46) zero-pads exhausted CryptoRng buffers, freezes the system clock at UNIX_EPOCH = 0 (bypassing 30-day signed prekey expiration), uses single-poll Waker::noop(), and maps EBADF = 9 to silent EOF.
- ComparatorChallenge TCB Expansion & PR #2 Caveat Removal: The comparator challenge files transitively import 326 files (153,682 lines) into the trusted computing base with "enable_nanoda": false, and PR #2 (commit b0f729accbc2) removed the 67-line caveat section from comparator/README.md.

### 1.3 Classical-Only Reductions (DEV-PQ19), PQXDH $2^{40}$ Bound Vacuity ($17,441/16,384 > 1$) & Operational Cliffs (CP-02, CP-04)
- Standard-Model GapDH Vacuity at $q_{\text{total}} = 2^{40}$ and Stale DEV-C14 Threshold: The computational theorems prove classical security only (DEV-PQ19). In [PQXDH.md](../proofs/oai_ref/Computational/docs/PQXDH.md#L69-L112), evaluating the standard-model GapDH 5th term at the advertised $q_{\text{total}} = 2^{40}$ scale yields $17,441 / 16,384 > 1$ (vacuous probability bound). In addition, the 8-byte MAC collision bound (DEV-C14) exceeds 1 at $q = 35,211$ (whereas DEVIATIONS.md:2733 reports the stale threshold 38,967), and .base-keys permanently rejects prekeys after 56,680 handshakes ($> 2\text{ MiB}$).
- Failing Hygiene Self-Test & 6 Omitted Audit Artifacts: Running [check_refinement_hygiene.sh](../proofs/oai_ref/Symbolic/scripts/check_refinement_hygiene.sh#L121-L136) --self-test fails (7/14 stale theorem names, exit code 1), 5 audit scripts and TRUSTED_BASE.md cited in the documentation are absent from the repository (0 / 6 present), and the AGPL-3.0-only ELF binary is uncommitted.

### 1.4 Verified Multi-Layer Formal Core & Three-Tier Contribution Separation
- Valid Multi-Layer Verification Core (Gate 5: PASS): The abstract computational game reductions (Computational/Proofs, ACD19 + SPQR V1 classical non-regression), symbolic trace invariants (Symbolic/Proofs), and placed AArch64 instruction refinement across the 9 de-hooked symbols constitute a substantial formal verification achievement, confirmed by our 81 standalone Lean 4 theorems (1,457 lines, 391/391 mutations killed).
- Three-Tier Contribution Separation: (1) Prior human cryptographic theory (ACD19, PQXDH, SPQR) & AArch64 ISA modeling 65%, (2) AI-assisted Lean 4 game-hopping, symbolic trace proofs & 9-symbol AArch64 refinement 35% (Gate 5 PASS), (3) 85.94% Hook bypass, 153,682-line comparator TCB inclusion, $2^{40}$ GapDH vacuity, and 6 missing audit files require revision.

## 2. Pre-bunking Predictable Objections (FAQ)

- Q1. "Does the repository verify the compiled AArch64 libsignal-cli binary end-to-end down to machine instructions?"
  - Fact: Only 9 of the 64 tracked symbols (14.06%: mallocng alloc/free, memcpy, memset, file read) execute AArch64 ELF instructions; the remaining 55 / 64 (85.94%, or 45 / 64 = 70.31% after PR #2) are bypassed via 37 Lean specification hooks and 18 panic stubs, and CliElfLib (85,249 lines) is excluded from default lake build.
- Q2. "Doesn't the external comparator guarantee that the theorem statements and TCB are minimal?"
  - Fact: No. ComparatorChallenge transitively imports 326 files (153,682 lines) into the TCB alongside the unproved 61-file (16,767-line) Arm64/Trusted/ base, runs with "enable_nanoda": false, and PR #2 deleted the 67-line caveat section in comparator/README.md that previously documented these limitations.
- Q3. "Are the PQXDH and SPQR proofs post-quantum secure at the advertised $2^{40}$ scale?"
  - Fact: `DEVIATIONS.md` (`DEV-PQ19`) notes that the computational theorems formalize classical security only, and in [PQXDH.md](../proofs/oai_ref/Computational/docs/PQXDH.md#L69-L115) GapDH Term 5 crosses `1` at $q_{\mathrm{total}} \ge 1,081,110,205,009 \approx 2^{39.98}$ and reaches $17,441 / 16,384 \approx 1.0645 > 1$ at $q_{\mathrm{total}} = 2^{40}$, forcing `PQXDH.md:115` to restrict concrete security margins to $q_{\mathrm{total}} \le 2^{24}$.
- Q4. "Why does `DEV-C14` in `DEVIATIONS.md:2733` state `38,967` messages/queries within a single session when the bound exceeds `1` at `35,211`?"
  - Fact: Because the formula in the code was updated while the prose threshold in `DEVIATIONS.md:2733` (`q_ep = q`, messages/queries within a single session) was left at the stale value `38,967`, leaving a `3,756`-message discrepancy ([deepmind_comparator_laundering_and_crypto_bounds.lean](../proofs/deepmind_comparator_laundering_and_crypto_bounds.lean#L1)).
- Q5. "Do the computational game reductions and 9 de-hooked AArch64 symbols still have high engineering value?"
  - Fact: Yes. The multi-stage game reductions in Computational/Proofs, symbolic Rust refinement in Symbolic/Proofs, and machine-code proofs for mallocng/memcpy/memset are genuine milestones in AI-assisted formal verification (Gate 5: PASS).
- Q6. "What exact revisions are required to upgrade this work to OPFF TIER A?"
  - Fact: (1) Include CliElfLib in default lake build and prune the 1,450 unreachable files (595,231 lines), (2) shrink the 153,682-line ComparatorChallenge TCB and restore the 67-line TCB caveat disclosure, (3) fix the $2^{40}$ GapDH vacuity in PQXDH.md and update DEV-C14 to 35,211, and (4) commit the 5 missing audit scripts, TRUSTED_BASE.md, and the failing hygiene self-test fix.

## 3. 10-Second Terminal Reproduction (Don't Trust, Verify)

```bash
# 1) Verify the 11,323-file (7,528,295-line) stratigraphy, 55/64 (85.94%) Hook bypass, 153,682-line comparator TCB & PQXDH/DEV-C14 bounds
python3 -B proofs/verify_symbolic_deepmind_signal.py

# 2) Kernel-check all 81 independent Lean 4 theorems (0 sorry, 0 axiom, 391/391 hypothesis mutations killed)
lean proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean
lean proofs/deepmind_arm64_tcb_and_syscall_divergences.lean
lean proofs/deepmind_comparator_laundering_and_crypto_bounds.lean
```
