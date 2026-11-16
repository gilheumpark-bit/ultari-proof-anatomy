# [Audit Summary] OpenAI `#005` (`PR #80`: *Catalan's constant is irrational*)

- **Target (`Repository / Preprint`)**: OpenAI `openai/math` Family `#005` (`10` files in `build/*.tex` · `2,226` lines; `1,134` `.lean` files in `OAI/NumberTheory/Catalan/` · `573,816` lines + `lean/patches/catalan.patch` `4,724` lines) / Submitted PR: [`mathcommunity/oai-math-revised#80`](https://github.com/mathcommunity/oai-math-revised/pull/80)
- **Verification Toolchain**: `Lean 4 v4.29.0-rc8` (`Mathlib 4`) / `Python 3.14` (`SymPy` symbolic engine)
- **Artifact Checksums (`SHA-256`)**: [`catalan_rows_two_adic_and_odd_primes.lean`](../proofs/catalan_rows_two_adic_and_odd_primes.lean) (`c551be52cf76...`) | [`catalan_palindromic_frobenius_and_modular.lean`](../proofs/catalan_palindromic_frobenius_and_modular.lean) (`4543e211b208...`) | [`catalan_real_place_energy_and_contradiction.lean`](../proofs/catalan_real_place_energy_and_contradiction.lean) (`0cf51d47e3d4...`) | [`verify_symbolic_catalan005.py`](../proofs/verify_symbolic_catalan005.py) (`61b2a1909cd4...`)
- **Verification Method**: **`75` independent `Lean 4` theorems + `3` `def`s** (`0 sorry`, `0 axiom`, `432 / 432` universal-hypothesis mutations killed) & deterministic `SymPy` reproduction script
- **OPFF Formal Verdict**: `Gate 1: PASS` · `Gate 2: FAIL` · `Gate 3: FAIL` · `Gate 4: HOLD` · `Gate 5: PASS` $\implies$ **`OPFF TIER C` (`Conditional Revision Required — Genuine Mathematical Breakthrough with Severe Paper–Artifact & Attribution Non-Conformance`)**

---

## 0. 8-Metric Executive Scorecard (TL;DR)

| Audit Dimension | Claimed in Manuscript (`PDF` / Docs) | Measured in Repository (`Lean 4` / `catalan.patch`) | Discrepancy / Status |
| :--- | :--- | :--- | :---: |
| **1. Code Reachability** | `1,134` files · `573,816` total lines in `Catalan/` | Active cone **`21.7%` (`518` files · `124,449` lines)** / Unreachable strata **`78.3%` (`616` files · `449,367` lines)** | **`78.3%` Unreachable (`CP-05`)** |
| **2. Entrypoint (`Main.lean`)** | `29` top-level module `import`s in `Main.lean` | Active cone **`1 / 29` (`CatalanIrrational.lean`)** / Non-propagating root imports **`28 / 29` (`96.6%`)** | **`96.6%` Disconnected (`CP-05`)** |
| **3. Manuscript–Code Match** | Sec 7 Table 1 Gaussian pivots + Eq. `(5.3)` `(n!)^2` tracking | Gaussian pivot code (`321` files · `396,093` lines, `69.0%`) **100% unreachable** (active proof uses $\bmod 101$ right-inverse); Eq. `(5.3)` uses **`1 ≤ ((nN)!)^2`** | **Paper–Artifact Divergence (`CP-04`)** |
| **4. Upstream Patching** | Zero citation to Tao's `PrimeNumberTheoremAnd` | `catalan.patch` (`4,724` lines) places **`27` files (`+4,539` lines)** into `PrimeNumberTheoremAnd/` + **replaces `17`-line AI notice with `17` blank lines** | **Unattributed Placement (`CP-08`, `CP-09`)** |
| **5. Citation Hygiene** | `25` citations (`17` `.bib` keys across `2,226` lines) | **`88.0%` (`22 / 25`)** in Intro/Conclusion (`222` lines, `10.0%`) vs. **`12.0%` (`3 / 25`) across Secs 2–8 (`2,004` lines, `90.0%`)** | **`18` Primary Refs Omitted (`CP-03`)** |
| **6. Cross-Project Grafting** | Standalone `#005` formalization | `PrimePower.lean:3` imports **`11` files (`1,636` lines, worker `W21`)** from `#301` (`MonotoneSumset/`) + `Noto Sans CJK SC` in `header.tex:12` | **Cross-Family Import (`CP-10`)** |
| **7. Premise Integrity** | Complete lemma soundness | Active cone (`124,449` lines) is `100%` sound (`0 sorry`, `0 axiom`); repository retains `8` unused premises, `26` uncalled lemmas, and `23` duplicate theorem pairs | **Redundant Strata (`CP-06`, `CP-10`)** |
| **8. Mathematical Value** | Proves Catalan's constant $G = \sum_{n=0}^\infty (-1)^n/(2n+1)^2 \notin \mathbb{Q}$ | **Complete proof of $G \notin \mathbb{Q}$ verified** via adelic lower bound (`> -2.29084`) vs. Archimedean upper bound (`< -2.290939875 < -2.2909`) | **Genuine Breakthrough (`Gate 5 PASS`)** |

---

## 1. Summary of Verified Physical Findings

### 1.1 Bibliographic Skew (`88.0%` in Intro/Conclusion) & 18 Omitted Primary Sources (`CP-03`)
- **Citation Starvation Across `90.0%` of the Manuscript**: Sections 2–8 (`2,004 / 2,226` lines, `90.0%`) contain only `3` of `25` citations (`12.0%`), with **`0` citations across Sections 2, 3, 6, 7, and 8 (`1,163` lines)**.
- **Omitted Upstream Library & `18` Primary Classics (Restored in `PR #80`)**: `section5.tex:125` relies directly on **Kontorovich–Tao's `PrimeNumberTheoremAnd` (2024–2026)** via `PrimePower.lean` while citing only an expository note (`Jameson2003`), and omits `18` primary foundational works including `Kummer (1847)` and `Descartes (1637)` (both named in prose without `.bib` entries), Gauss (1813), Legendre (1811), Cauchy (1825), Frobenius (1879), Walsh (1929), Fekete (1923), Goluzin (1957), and Siegel (1929).

### 1.2 Upstream Patch Namespace Placement & 17-Line Notice Replacement (`CP-08`, `CP-09`, `CP-10`)
- **Unattributed External-Namespace Placement (`CP-08`)**: `lean/patches/catalan.patch` (`4,724` lines across `30` diff blocks) creates `27` new files (`+4,539` lines) inside the external `PrimeNumberTheoremAnd/` namespace hierarchy.
- **Line-Preserving Notice Replacement (`CP-09`)**: `catalan.patch:4521-4549` removes the `17`-line AI-restriction header comment in `PrimeNumberTheoremAnd/ZetaBounds.lean:1-21` (*"Please do NOT use extensive AI tools to automaticallyfill in proofs..."*) and replaces it with **exactly `17` blank newline lines (`0x0A`)** (alongside `-111` lines of deleted LaTeX blueprint comments).
- **Upstream `Wiener` `-2,716`-Line Truncation, `109`-Line Byte-Preserving Space (`0x20`) Replacement & `0-sorryAx` Isolation (`CP-08`, `CP-09`, `Gate 1 PASS`)**: `catalan.patch` truncates **`-2,716` lines** from upstream `Wiener` to remove upstream `sorry`s, replaces **`109` lines (`6 + 6 + 29 + 68`)** of upstream `blueprint_comment` blocks with an equal byte count of ASCII spaces (`0x20`), and omits `#005` from `lean/docs/formalization.yaml`. Meanwhile, the `10`-file (`2,937`-line) active `PrimeNumberTheoremAnd` patch chain closes in pure `Mathlib` without touching the `34` upstream `sorry`s (`0 sorryAx`), and the 4-step `tsum` (`ENNReal.tsum_eq_zero`) / `OrdinaryZetaZeroFree` / `WienerIkehara` / `WeakPNT''` chain is verified sound.
- **Cross-Project Mosaic Borrowing & Template Relics (`CP-10`)**: `PrimePower.lean:3` imports `11` files (`1,636` lines, worker namespace `W21`) from `#301` (`OAI/AdditiveCombinatorics/MonotoneSumset/`), and `build/header.tex:12` retains an unused Simplified Chinese font fallback (`Noto Sans CJK SC`).

### 1.3 Proof Reachability Stratigraphy (`78.3%` Unreachable) & Paper–Artifact Divergence (`CP-04`, `CP-05`)
- **Unreachable Module Strata (`78.3%`, `449,367` Lines) & Non-Propagating Root Imports (`28 / 29 = 96.6%`)**: Of `1,134` `.lean` files (`573,816` lines) in `OAI/NumberTheory/Catalan/`, `Theorem 1.1` (`catalan_irrational`) transitively reaches `518` files (`124,449` lines, `21.7%`), leaving `616` files (`449,367` lines, `78.3%`) in unreachable module strata. Moreover, `28` of the `29` modules imported in `Main.lean` (`96.6%`, including `ManuscriptSection2`–`9`) do not propagate to `catalan_irrational`.
- **Two Major Manuscript–Artifact Divergences (`CP-04`)**:
  1. **Section 7, Table 1 (`section7.tex:29-121`)**: All `321` `GaussianCert*` files (`396,093` lines, `69.0%` of the directory) encoding the manuscript's `164`-step Gaussian elimination pivot table are **100% unreachable**; the active proof in `EvaluatedMatrixCertData.lean` (`83,766` lines) uses a **mod-`101` right-inverse matrix multiplication (`A_mod * B = I`)** never mentioned in the paper.
  2. **Section 5, Equation `(5.3)` (`section5.tex:116-123`)**: Whereas `section5.tex:116-123` claims to track the high-multiplicity factorial product $\prod (nN)!^2$, `OddPrimeOrbits.lean:51-59` and `OddPrimeTail.lean:45-58` replace it with the trivial bound **`1 ≤ ((nN)!)^2` (`Nat.one_le_pow`)**.

### 1.4 Verified Mathematical Breakthrough & Three-Tier Contribution Separation
- **Complete Proof of Catalan's Constant Irrationality ($G \notin \mathbb{Q}$) Verified (`Gate 1 & Gate 5: PASS`)**: The `518`-file active proof cone (`124,449` lines) rigorously establishes $G \notin \mathbb{Q}$ via the strict squeeze between the adelic denominator growth bound (`> -2.29084`) and the Archimedean conformal/Descartes upper bound (`< -2.290939875 < -2.2909`, net margin `0.000099875`).
- **Three-Tier Contribution Separation**: (1) Prior human transcendence theory, conformal potential theory & PNT library foundations **`60%`**, (2) **AI $L=59N$ $\zeta(2)$ cancellation, palindromic Frobenius block factorization ($\det U = 2^{p(p-1)/2}$), $\operatorname{ZMod} 101$ right-inverse certificate & `518`-file `0-sorry` formalization breakthrough `40%` (`Gate 1 & Gate 5 PASS`)**, (3) Unreachable Gaussian pivot table (`69.0%`) in manuscript & patch/citation non-conformance (`CP-03`, `CP-04`, `CP-05`, `CP-08`, `CP-09`, `CP-10`) requiring revision.

---

## 2. Pre-bunking Predictable Objections (FAQ)

- **Q1. "The final theorem compiles with `0 sorry` in the Lean 4 kernel — doesn't that mean the proof is valid?"**
  - **Fact**: Yes — the `124,449`-line active proof cone is valid and genuinely proves $G \notin \mathbb{Q}$, as confirmed by our `75` independent `Lean 4` theorems (`432/432` mutations killed, `Gate 1 & Gate 5: PASS`). The non-conformance is that **the manuscript text (`paper.pdf`) describes a different, unreachable `396,093`-line Gaussian pivot proof and claims explicit factorial bounds that the active code omits (`Gate 2: FAIL — Paper–Artifact Divergence`)**.
- **Q2. "Isn't unreferenced code just normal leftover scratch work from research exploration?"**
  - **Fact**: Beyond unreferenced files in subdirectories, the top-level entrypoint `Main.lean` explicitly `import`s `28` `ManuscriptSection*` wrapper modules named after the paper's sections (`28 / 29 = 96.6%`), none of which propagate to `catalan_irrational` (`Non-Propagating Root Imports`).
- **Q3. "Could the upstream comment removal in `catalan.patch` be an accident from auto-formatting?"**
  - **Fact**: `catalan.patch:4521-4549` removes the `17`-line upstream AI-restriction comment block in `ZetaBounds.lean` and inserts **exactly `17` blank newline lines (`0x0A`)**, preserving downstream line numbers. Auto-formatters do not replace deleted comment blocks with an equal number of blank lines.
- **Q4. "Isn't finding a mod-101 right-inverse matrix a legitimate Computer-Assisted Proof (CAP)?"**
  - **Fact**: Yes — the `83,766`-line $\operatorname{ZMod} 101$ right-inverse multiplication in `EvaluatedMatrixCertData.lean` is a valid CAP core (`Gate 5: PASS`). The non-conformance lies in the manuscript pipeline writing up the unreachable `396,093`-line Gaussian pivot table (`Table 1`) instead of the active proof.
- **Q5. "Does replacing `(n!)^2` with `1` in Equation `(5.3)` break the irrationality proof?"**
  - **Fact**: No — the Kummer single-carry filtration and odd-prime orbit main terms alone yield `> -2.29084 > -2.2909`, so the theorem holds. However, claiming in `section5.tex:116-123` to track a factorial product that the code bounds by `1 ≤ ((nN)!)^2` constitutes `Paper–Artifact Divergence` (`CP-04`).
- **Q6. "What does `PR #80` fix, and what is required to upgrade `#005` to `OPFF TIER A`?"**
  - **Fact**: Submitted [`PR #80`](https://github.com/mathcommunity/oai-math-revised/pull/80) restores the missing `PrimeNumberTheoremAnd` and `18` primary classical citations in `build/*.tex` and documents this audit in `NOTES.md`. Revising Section 7 to match the active mod-`101` proof, relocating the `27` patched files out of `PrimeNumberTheoremAnd/` while restoring the `17`-line header in `ZetaBounds.lean`, and pruning the `616` unreachable files will upgrade `#005` to `OPFF TIER A`.

---

## 3. 10-Second Terminal Reproduction (`Don't Trust, Verify`)

```bash
# 1) Verify the 1,134-file stratigraphy (518 active / 616 unreachable), 28/29 non-propagating imports, 17-line replacement & mod-101 certificate
python3 -B proofs/verify_symbolic_catalan005.py

# 2) Kernel-check all 75 independent Lean 4 theorems (0 sorry, 0 axiom, 432/432 hypothesis mutations killed)
lake env lean proofs/catalan_rows_two_adic_and_odd_primes.lean
lake env lean proofs/catalan_palindromic_frobenius_and_modular.lean
lake env lean proofs/catalan_real_place_energy_and_contradiction.lean
```
