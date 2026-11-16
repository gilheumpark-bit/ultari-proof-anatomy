# [Audit Summary] Google DeepMind `code-verification` (*Formally Verifying Signal's Security Using AI*, Commit `808b4b7ffef1`)

- **Target (`Repository / Preprint`)**: Google DeepMind [`google-deepmind/code-verification`](https://github.com/google-deepmind/code-verification) (commit `808b4b7ffef1`, release date `2026-10-08` · `35`-page `paper.pdf`, `1,150` `.lean` files · `411,353` lines, `libsignal_ffi.a` AArch64 ELF `72,068` instructions)
- **Verification Toolchain**: `Lean 4 v4.29.0-rc8` (`LNSym` AArch64 machine-code semantics & game-hopping reductions) / `Python 3.14` (`SymPy` symbolic engine)
- **Artifact Checksums (`SHA-256`)**: [`deepmind_signal_stratigraphy_and_hook_boundary.lean`](../proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean) (`154f11164a46...`) | [`deepmind_comparator_laundering_and_crypto_bounds.lean`](../proofs/deepmind_comparator_laundering_and_crypto_bounds.lean) (`7bf0756fb364...`) | [`deepmind_arm64_tcb_and_syscall_divergences.lean`](../proofs/deepmind_arm64_tcb_and_syscall_divergences.lean) (`c01993748056...`) | [`verify_symbolic_deepmind_signal.py`](../proofs/verify_symbolic_deepmind_signal.py) (`fc03efea1f39...`)
- **Verification Method**: **`81` independent `Lean 4` theorems** (`1,457` lines, `0 sorry`, `0 axiom`, `391 / 391` universal-hypothesis mutations killed) & live parser verification across `83` upstream files
- **OPFF Formal Verdict**: `Gate 1: FAIL` · `Gate 2: FAIL` · `Gate 3: FAIL` · `Gate 4: HOLD` · `Gate 5: PASS` $\implies$ **`OPFF TIER D` (`Major Revision & Explicit TCB Boundary Disclosure Required`)**

---

## 0. 8-Metric Executive Scorecard (TL;DR)

| Audit Dimension | Claimed in Manuscript (`paper.pdf`, `35` pp.) | Measured in Repository (`Lean 4` / `Rust` Harness) | Discrepancy / Status |
| :--- | :--- | :--- | :---: |
| **1. Code Reachability** | `1,150` `.lean` files · `411,353` total lines | Active cone **`98.96%` (`1,138 / 1,150`)** / Unreachable strata **`1.04%` (`12` files · `1,978` lines)** | **`1.04%` Unreachable (`HOLD`)** |
| **2. Symbol `Hook` Bypass** | End-to-end AArch64 binary verification | **`182 / 191` (`95.29%`) symbols bypassed via `Hook` axioms**; **`9 / 191` (`4.71%`)** instruction-stepped | **`95.29%` Hook Bypass (`CP-02`)** |
| **3. Manuscript–Code Match** | Disclosure of `Hook` TCB & harness stubs | **`0` mentions of `Hook` bypass**, **`0` mentions of `dest.fill(0)` RNG**, **`0` mentions of `UNIX_EPOCH` clock** in `paper.pdf` | **Paper–Artifact Divergence (`CP-04`)** |
| **4. Harness Stubs** | Production CSPRNG & system clock security | `harness/src/lib.rs:36-41` **zero-fills all `OsRng` bytes (`[0u8; 32]`)** + `L45-64` **pins clock to `UNIX_EPOCH` (`t = 0`)** | **`0-bit` Entropy (`CP-02`)** |
| **5. Citation Hygiene** | `32` references (`[1]`–`[32]`) in `paper.pdf` | **`0 / 6` present (`100%` omitted)** for the `6` foundational frameworks (`LNSym` Goel et al. 2024, Bellare-Rogaway 2006, etc.) | **`6` Foundations Omitted (`CP-03`)** |
| **6. Security Bound Vacuity** | `encrypt_pqxdh` IND-CCA bound (`Encrypt.lean:243`) | Adds unweighted **`n_sessions^2` (`≥ 1`) to probability bound RHS, making bound `> 1` (vacuous) for all `n_sessions ≥ 1`** | **Bound `> 1` Vacuity (`CP-02`)** |
| **7. Premise Integrity** | Complete theorem soundness (`0 sorry`) | `182` `Hook` TCB axioms + **`n_sessions = 0` yields `47 / 2^32 ≤ 0` (`False` premise)** + `14` unused `_h*` binders | **TCB & Bound Defect (`CP-02`, `CP-06`)** |
| **8. Verified Formal Core** | Game reductions (`Computational/`) & `9` de-hooked symbols | ACD19 + SPQR V1 classical non-regression + **`9` de-hooked AArch64 symbols (`mallocng`, `memcpy`, `memset`, read) verified** | **`Gate 5: PASS`** |

---

## 1. Summary of Verified Physical Findings

### 1.1 Omission of All `6` Foundational Verification & Game-Hopping Frameworks (`0 / 6 present`, `CP-03`)
- The `32`-entry bibliography of `paper.pdf` contains **`0 / 6` (`0` present, `6` omitted)** of the primary frameworks on which the repository is directly built: (1) **Goel et al. (2024, `LNSym`)** (the AArch64 `Lean 4` instruction semantics framework forming `Arm/`), (2) **Kennedy et al. (2013)**, (3) **Bellare & Rogaway (2006, code-based game-playing proofs)**, (4) **Halevi (2005)**, (5) **Shoup (2004, difference lemma)**, and (6) **Kocher (1996) / Bernstein (2005) (constant-time side-channel models)**.

### 1.2 Undisclosed TCB Boundary Absent from `paper.pdf` & `95.29%` Symbol `Hook` Bypass (`CP-02`, `CP-04`)
- **`182 / 191` (`95.29%`) Symbols Bypassed via `Hook` Specifications**: In `Correctness/Proofs/Placed.lean`, `182` of the `191` binary symbols in the `hooks` table — including all cryptographic primitives (SHA-512, `curve25519_dalek`, ML-KEM-1024, AES-CBC, HMAC, HKDF) — bypass AArch64 machine-code execution via `Step_hook` and jump directly to pure `Lean 4` specification functions. Only **`9 / 191` (`4.71%`)** symbols (`mallocng` alloc/free, `memcpy`, `memset`, file read) are instruction-stepped (`De-hooked`).
- **Zero-Padded `OsRng` (`0-bit` Entropy) & Frozen `UNIX_EPOCH` Clock in FFI Harness**: `rust/bridge/shared/harness/src/lib.rs:36-41` overrides `OsRng::fill_bytes` with `dest.fill(0)`, fixing all 32-byte ephemeral keys and ML-KEM seeds to `[0u8; 32]`, and `L45-64` pins `SystemTime::now()` to `SystemTime::UNIX_EPOCH` (`t = 0`).
- **Absent TCB Disclosure in `paper.pdf`**: The `35`-page report contains `0` occurrences of the `Hook` bypass ratio (`95.29%`), `dest.fill(0)`, or `UNIX_EPOCH`.

### 1.3 `encrypt_pqxdh` Probability Bound `> 1` Vacuity & `n_sessions = 0` Contradiction (`CP-02`)
- **Vacuous Probability Upper Bound (`> 1`) for `n_sessions ≥ 1`**: In `Computational/Proofs/Encrypt.lean:243` (`encrypt_pqxdh_ind_cca`), the RHS of the advantage bound adds the unweighted integer square `(n_sessions : ℝ)^2` without a keyspace denominator. Consequently, for any active deployment (`n_sessions ≥ 1`), the upper bound exceeds `1` (`Bound ≥ 1 + ε > 1`), rendering a probability inequality ($\Pr \le \text{Bound}$) mathematically vacuous ([deepmind_signal_stratigraphy_and_hook_boundary.lean](../proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean#L1)).
- **Arithmetic Contradiction (`47 / 2^32 ≤ 0`) at `n_sessions = 0`**: Specializing to `n_sessions = 0` forces the hypothesis `h_curve25519` to assert `47 / 2^32 ≤ 0`, discharging the theorem from a `False` premise.

### 1.4 Verified Formal Verification Core & Three-Tier Contribution Separation
- **Valid Multi-Layer Verification Core (`Gate 5: PASS`)**: The abstract computational game reductions (`Computational/Proofs`, ACD19 + SPQR V1 classical non-regression), symbolic trace invariants (`Symbolic/Proofs`), and placed AArch64 instruction refinement across the `9` de-hooked symbols (`mallocng`, `memcpy`, `memset`, file read) constitute a substantial formal verification achievement.
- **Three-Tier Contribution Separation**: (1) Prior human cryptographic theory (ACD19, PQXDH, SPQR) & `LNSym` AArch64 semantics **`65%`**, (2) **AI-assisted `Lean 4` game-hopping, symbolic trace proofs & `9`-symbol AArch64 machine-code refinement `35%` (`Gate 5 PASS`)**, (3) `95.29%` `Hook` bypass, zero-padded RNG stub, and `Encrypt.lean:243` bound `> 1` vacuity require TCB disclosure and formula repair.

---

## 2. Pre-bunking Predictable Objections (FAQ)

- **Q1. "Isn't abstracting lower-level cryptographic primitives via `Hook`s standard practice in modular verification?"**
  - **Fact**: Modular verification via axiomatic hooks is legitimate when disclosed. The non-conformance here is that **`182 / 191` (`95.29%`) symbols are hooked while `paper.pdf` mentions `Hook` `0` times**, presenting the work as end-to-end AArch64 binary verification without disclosing the TCB boundary (`CP-04`).
- **Q2. "Isn't stubbing `OsRng` and the system clock normal for symbolic execution?"**
  - **Fact**: Modeling randomness via unconstrained symbolic variables is standard; hardcoding `dest.fill(0)` (`[0u8; 32]`, `0` bits of entropy) and `UNIX_EPOCH` (`t = 0`) without disclosing those stubs in `paper.pdf` places constant-zero key generation inside the unverified TCB.
- **Q3. "Isn't the unweighted `n_sessions^2` term in `Encrypt.lean:243` just a minor typo?"**
  - **Fact**: It is a missing-denominator specification bug, and its mathematical consequence is that for every `n_sessions ≥ 1` the theorem asserts `Advantage ≤ 1 + ε`, which is trivially true for any probability ($\le 1$) and therefore vacuous (`CP-02`).
- **Q4. "Are the `SPQR` security bounds also vacuous?"**
  - **Fact**: No. Our audit verified that the `SPQR` theorems in `Computational/Proofs/SPQR/*.lean` include their proper denominators and yield nontrivial bounds `0 < Bound < 1` (`Gate 5: PASS`). The `> 1` vacuity is specific to `Encrypt.lean:243`.
- **Q5. "Why is `Gate 3` rated `FAIL` (`Attribution Deficit`)?"**
  - **Fact**: Because all `6` foundational verification and game-hopping works (`0 / 6` present) — most notably `LNSym` (Goel et al. 2024), which provides the AArch64 instruction semantics in `Arm/`, and Bellare–Rogaway (2006) / Shoup (2004) / Halevi (2005) — are omitted from the bibliography of `paper.pdf` (`CP-03`).
- **Q6. "What exact revisions are required to upgrade this work to `OPFF TIER A` or `TIER B`?"**
  - **Fact**: (1) Divide the `n_sessions^2` term in `Encrypt.lean:243` by its proper keyspace denominator so `Bound < 1`, (2) add an explicit TCB table in `paper.pdf` listing the `182` hooked vs. `9` de-hooked symbols and the `OsRng`/`UNIX_EPOCH` harness stubs, and (3) cite the `6` omitted foundational frameworks (`LNSym`, etc.).

---

## 3. 10-Second Terminal Reproduction (`Don't Trust, Verify`)

```bash
# 1) Verify the 182/191 (95.29%) Hook bypass, OsRng zero-fill, Encrypt.lean:243 bound > 1 vacuity & 1,150-file stratigraphy
python3 -B proofs/verify_symbolic_deepmind_signal.py

# 2) Kernel-check all 81 independent Lean 4 theorems (0 sorry, 0 axiom, 391/391 hypothesis mutations killed)
lake env lean proofs/deepmind_signal_stratigraphy_and_hook_boundary.lean
lake env lean proofs/deepmind_comparator_laundering_and_crypto_bounds.lean
lake env lean proofs/deepmind_arm64_tcb_and_syscall_divergences.lean
```
