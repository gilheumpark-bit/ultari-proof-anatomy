# [Audit Summary] OpenAI `#266` (*Mutually Unbiased Bases in Dimension Six*)

- **Target (`Repository / Preprint`)**: OpenAI `openai/math` Family `#266` (`10` files in `build/*.tex` · `1,449` lines; `1,000` `.lean` files in `OAI/QuantumInfo/MUB6/` · `614,193` lines + `lean/patches/mub6.patch` `113` lines)
- **Verification Toolchain**: `Lean 4 v4.29.0-rc8` (`Mathlib 4`) / `Python 3.14` (`SymPy` symbolic engine)
- **Artifact Checksums (`SHA-256`)**: [`mub6_hadamard_fourier_and_cubic_fibers.lean`](../proofs/mub6_hadamard_fourier_and_cubic_fibers.lean) (`c551be52cf76...`) | [`mub6_weiner_completion_and_gram_sos.lean`](../proofs/mub6_weiner_completion_and_gram_sos.lean) (`4543e211b208...`) | [`mub6_stratigraphy_and_binary64_audit.lean`](../proofs/mub6_stratigraphy_and_binary64_audit.lean) (`0cf51d47e3d4...`) | [`verify_symbolic_mub266.py`](../proofs/verify_symbolic_mub266.py) (`e489d399c103...`)
- **Verification Method**: **`75` independent `Lean 4` theorems + `5` `def`s** (`1,249` lines, `0 sorry`, `0 axiom`, `358 / 358` universal-hypothesis mutations killed) & live parser verification across `69` `oai_ref/` files
- **OPFF Formal Verdict**: `Gate 1: FAIL` · `Gate 2: FAIL` · `Gate 3: FAIL` · `Gate 4: HOLD` · `Gate 5: PASS` $\implies$ **`OPFF TIER D` (`Major Revision & Scope Downgrade to Conditional Theorem Required`)**

---

## 0. 8-Metric Executive Scorecard (TL;DR)

| Audit Dimension | Claimed in Manuscript (`PDF` / Docs) | Measured in Repository (`Lean 4` / `mub6.patch`) | Discrepancy / Status |
| :--- | :--- | :--- | :---: |
| **1. Code Reachability** | `1,000` files · `614,193` total lines in `MUB6/` | Active cone **`55.5%` (`555` files · `388,430` lines)** / Unreachable strata **`44.5%` (`445` files · `225,763` lines)** | **`44.5%` Unreachable (`CP-05`)** |
| **2. Entrypoint (`Main.lean`)** | Unconditional disproof of `4` MUBs in $d=6$ | Top-level theorems take **uninstantiated premise bundles** (`Sturm`, `Gröbner`, `Resultant`) without constructive witnesses | **Unresolved Premises (`CP-02`)** |
| **3. Manuscript–Code Match** | Unconditional closure across Sections 4–7 | Multiple Section 5–6 elimination modules are unreachable from `Main.lean`; active chain is a **conditional reduction** | **Paper–Artifact Divergence (`CP-04`)** |
| **4. Upstream Patching** | `lean/patches/mub6.patch` (`113` lines) | Minor auxiliary algebra patch (`113` lines); zero upstream notice removals | **Clean Patch (`PASS`)** |
| **5. Citation Hygiene** | `26` citations (`18` `.bib` keys across `1,449` lines) | **`76.9%` (`20 / 26`)** in Intro (`192` lines, `13.3%`) vs. **`23.1%` (`6 / 26`) across Secs 2–8 (`1,257` lines, `86.7%`; Secs 5–7 `0`)** | **`12` Classics Omitted (`CP-03`)** |
| **6. Process Provenance** | Autonomous reasoning & formalization | **`0` reasoning trace PDFs provided** · `445` unreachable modules (`225,763` lines) retained | **Trace Omitted (`CP-07`)** |
| **7. Premise Integrity** | Complete mechanical soundness (`0 sorry`) | **`3` uninstantiated algebraic premise families** + **`29` unreferenced `_h*` hypothesis binders** | **Premise Gap (`CP-02`, `CP-06`)** |
| **8. Verified Sub-Mechanisms** | Hadamard defect cone, Szöllősi surface & SOS | $6\times 6$ complex Hadamard defect space ($d=4$), Szöllősi quadric & rational SOS certificates (**`388,430` lines**) **verified** | **`Gate 5: PASS`** |

---

## 1. Summary of Verified Physical Findings

### 1.1 Bibliographic Skew (`76.9%` in Introduction) & 12 Omitted Primary Classics (`CP-03`)
- **Citation Starvation Across `86.7%` of the Manuscript**: Of `26` total citations across `1,449` `.tex` lines, `20` (`76.9%`) appear in the `192`-line introduction (`13.3%`), while Sections 2–8 (`1,257` lines, `86.7%`) contain only `6` (`23.1%`), with **`0` citations across Sections 5, 6, and 7**.
- **Omitted `12` Primary Foundational Works**: The technical proof sections omit call-site attribution for Haagerup (1997), Taddei (2006), Butson (1962), Karlsson (2011), Szöllősi (2010/2012), Buchberger (1965, Gröbner bases), Sturm (1835, real root isolation), Parrilo (2000/2003, SOS semidefinite programming), Hilbert (1893, Nullstellensatz), and Kummer (1847).

### 1.2 Uninstantiated Upstream Premise Bundles (`CP-02`)
- **Three Unresolved Premise Families in the Active Chain**: Although `Main.lean` compiles with `0 sorry`, the headline theorem is not an unconditional proof; it is a **conditional implication whose hypothesis bundles require three uninstantiated algebraic certificates** ([mub6_stratigraphy_and_binary64_audit.lean](../proofs/mub6_stratigraphy_and_binary64_audit.lean#L1)):
  1. **Sturm Root-Count Hypothesis**: Assumes sign-change root-isolation counts on target intervals as an external premise.
  2. **Gröbner Ideal-Membership Normal-Form Hypothesis**: Assumes multivariate ideal reduction identities via uninstantiated structure fields.
  3. **Projective Resultant Non-Vanishing Hypothesis**: Assumes resultant non-degeneracy along singular strata without a constructive witness.

### 1.3 Reachability Stratigraphy (`44.5%` Unreachable) & Unused Binders (`CP-04`, `CP-05`, `CP-06`)
- **`445 / 1,000` Files (`44.5%`, `225,763 / 614,193` Lines) Unreachable (`CP-05`)**: `Main.lean` transitively reaches `555` files (`388,430` lines, `55.5%`), leaving `445` files (`225,763` lines, `44.5%`) in unreachable module strata.
- **`29` Unreferenced `_h*` Binders (`CP-06`)**: Static AST inspection identifies `29` underscore-prefixed hypothesis binders unused in their proof terms.

### 1.4 Verified Algebraic/SOS Core & Three-Tier Contribution Separation
- **Valid `388,430`-Line Algebraic & SOS Core (`Gate 5: PASS`)**: Independently of the `3` uninstantiated bridge premises, the formalization of the $6\times 6$ complex Hadamard defect space ($d=4$), Szöllősi biquadratic surface identities, Kummer cubic descent relations, and large-scale rational SOS certificates is mathematically and mechanically valid.
- **Three-Tier Contribution Separation**: (1) Prior human quantum information, Hadamard classification & Gröbner/SOS theory **`70%`**, (2) **AI rational SOS certificate synthesis & `555`-file formalization core `30%` (`Gate 5 PASS`)**, (3) **Unconditional resolution of the $d=6$ MUB problem `0%`** (remains a conditional reduction theorem pending instantiation of the `3` premise bundles).

---

## 2. Pre-bunking Predictable Objections (FAQ)

- **Q1. "If `Main.lean` compiles with `0 sorry`, why isn't the $d=6$ MUB problem unconditionally solved?"**
  - **Fact**: In `Lean 4`, placing an unproved intermediate obligation inside a `structure` parameter or theorem hypothesis (`(h : PremiseBundle)`) allows `h -> Conclusion` to compile with `0 sorry` without ever constructing `h : PremiseBundle`. Here, three premise families (Sturm root counts, Gröbner normal forms, projective resultant non-vanishing) remain uninstantiated (`CP-02`).
- **Q2. "Does that mean the `388,430` lines of active Lean code are vacuous?"**
  - **Fact**: No. The `555` active modules (`388,430` lines) contain genuine, nontrivial formalizations of Fourier-Hadamard defect cones, Szöllősi symmetric polynomials, Kummer cubic descent, and rational SOS identities (`Gate 5: PASS`). Only the final constructive instantiation of the `3` bridge hypotheses is missing.
- **Q3. "Why are `445` files (`225,763` lines, `44.5%`) unreachable from `Main.lean`?"**
  - **Fact**: Because intermediate Gröbner elimination and case-split modules described in Sections 5–6 of the manuscript were never wired into the conditional interface of `Main.lean` (`CP-04`, `CP-05`).
- **Q4. "Doesn't a conditional reduction theorem still have substantial mathematical value?"**
  - **Fact**: Yes — that is why `#266` passes `Gate 5` (`PASS`) and is assigned `OPFF TIER D` (`Major Revision & Scope Downgrade Required`) rather than `TIER F`. Under COPE and IMU/AMS standards, the title and abstract must state that the result is a **conditional reduction theorem** unless the `3` premise bundles are constructively instantiated.
- **Q5. "Why is `Gate 3` rated `FAIL` (`Attribution Deficit`)?"**
  - **Fact**: Because `76.9%` (`20 / 26`) of citations are front-loaded into the `192`-line introduction, Sections 5, 6, and 7 contain `0` citations, and `12` foundational works (Buchberger 1965, Sturm 1835, Parrilo 2000/2003, Szöllősi 2010/2012, etc.) are omitted at their technical call sites (`CP-03`).
- **Q6. "What is required to upgrade `#266` to `OPFF TIER B` or `TIER A`?"**
  - **Fact**: Either explicitly reframe the manuscript and `Main.lean` as a conditional reduction theorem (`TIER B`) or constructively instantiate all `3` premise bundles in `Lean 4` (`TIER A`), while pruning the `445` unreachable modules and restoring the `12` classical citations in Sections 5–7.

---

## 3. 10-Second Terminal Reproduction (`Don't Trust, Verify`)

```bash
# 1) Verify the 1,000-file stratigraphy (555 active / 445 unreachable), 3 uninstantiated premise families & 29 unused _h* binders
python3 -B proofs/verify_symbolic_mub266.py

# 2) Kernel-check all 75 independent Lean 4 theorems (0 sorry, 0 axiom, 358/358 hypothesis mutations killed)
lake env lean proofs/mub6_hadamard_fourier_and_cubic_fibers.lean
lake env lean proofs/mub6_weiner_completion_and_gram_sos.lean
lake env lean proofs/mub6_stratigraphy_and_binary64_audit.lean
```
