# [Audit Summary] OpenAI `#013` (*The Primes Are Additively Indecomposable* · Ostmann's Inverse Goldbach Problem, `Erdős #431`)

- **Target (`Repository / Preprint`)**: OpenAI `openai/math` Family `#013` (`11` files in `build/*.tex` · `10,165` lines; `3,165` `.lean` files in `OAI/NumberTheory/Ostmann/` · `618,225` lines + `lean/patches/ostmann.patch` `468,948` lines)
- **Verification Toolchain**: `Lean 4 v4.29.0-rc8` / `Python 3.14` (`SymPy` symbolic engine)
- **Artifact Checksums (`SHA-256`)**: [`ostmann_twin_engines_and_supply_contraction.lean`](../proofs/ostmann_twin_engines_and_supply_contraction.lean) (`c551be52cf76...`) | [`ostmann_tree_transfers_and_permutation_contradiction.lean`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean) (`4543e211b208...`) | [`ostmann_algebraic_engines_and_cauchy_determinant.lean`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean) (`0cf51d47e3d4...`) | [`verify_symbolic_ostmann.py`](../proofs/verify_symbolic_ostmann.py) (`e489d399c103...`)
- **Verification Method**: **`75` independent `Lean 4` theorems + `3` recursive `def`s + `1` `structure`** (`1,501` lines, `0 sorry`, `0 axiom`, `393 / 393` universal-hypothesis mutations killed) & deterministic `SymPy` reproduction script
- **OPFF Formal Verdict**: `Gate 1: PASS` · `Gate 2: FAIL` · `Gate 3: FAIL` · `Gate 4: HOLD` · `Gate 5: PASS` $\implies$ **`OPFF TIER C` (`Conditional Revision Required — Genuine Mathematical Breakthrough with Severe Artifact & Attribution Non-Conformance`)**

---

## 0. 8-Metric Executive Scorecard (TL;DR)

| Audit Dimension | Claimed in Manuscript (`PDF` / Docs) | Measured in Repository (`Lean 4` / `ostmann.patch`) | Discrepancy / Status |
| :--- | :--- | :--- | :---: |
| **1. Code Reachability** | `3,165` own + `4,175` patched + `381` cross = `7,716` files | Active cone **`52.2%` (`4,025 / 7,716`)** / Unreachable strata **`47.8%` (`3,691` files · `464,897` lines)** | **`47.8%` Unreachable (`CP-05`)** |
| **2. Entrypoint (`Main.lean`)** | Unconditional `0-sorry` proof of `Erdős #431` | Stage 1 (CRT) + Stage 2 (sieve `-11/125 < 0`) + Stage 3 (Cauchy det `≥ 1`) **fully kernel-verified** | **Main Theorem Valid (`Gate 1 PASS`)** |
| **3. Manuscript–Code Match** | Self-contained `Ostmann/` formalization | Within `Ostmann/` itself, **`40.6%` (`1,286 / 3,165` files · `291,173` lines) are unreachable** (`76.5%` in `Stage2/`) | **Unreachable Strata (`CP-05`)** |
| **4. Upstream Patching** | Zero citation to Tao's `PrimeNumberTheoremAnd` | `ostmann.patch` (`468,948` lines) places **`4,167` new files (`+468,857` lines)** into `PrimeNumberTheoremAnd/` + **replaces `17`-line AI notice with `17` blank lines** | **Unattributed Placement (`CP-08`, `CP-09`)** |
| **5. Citation Hygiene** | `9` total citations (`7` `.bib` keys across `10,165` lines) | `5` in Intro (`391` lines) vs. **`4` across Sections 4–9 (`9,495` lines, `93.4%`; `0.42` / 1k lines, `30.4 : 1` skew)** | **`6` Classics Omitted (`CP-03`)** |
| **6. Cross-Project Grafting** | Standalone `#013` formalization | Directly imports **`381` files (`55,705` lines, workers `W04..W74`)** from `#301` (`OAI/AdditiveCombinatorics/MonotoneSumset/`) | **Cross-Family Import (`CP-10`)** |
| **7. Premise Integrity** | Complete lemma soundness | Active cone is `100%` sound (`0 sorry`); unreachable strata contain **`2` `False`-premise lemmas** (`Stage2/Bridge/Step283.lean`) & `51` unused `_h*` binders | **Unreachable Defects (`CP-06`)** |
| **8. Mathematical Value** | Resolves Ostmann's Inverse Goldbach Problem (1950) | **First unconditional proof** of $|A|\ge 2 \wedge |B|\ge 2 \implies |(A+B)\triangle\mathcal{P}| = \infty$ + **`16.08`$\times$ threshold reduction** ($L_{\mathrm{eff}}: 4.12\text{M} \to 255,983$) | **Genuine Breakthrough (`Gate 5 PASS`)** |

---

## 1. Summary of Verified Physical Findings

### 1.1 Bibliographic Skew (`30.4 : 1`) & Omitted Foundational Libraries (`CP-03`)
- **Citation Starvation Across `93.4%` of the Manuscript**: Of `10,165` `.tex` lines (`11` files), Sections 4–9 (`9,495` lines, `93.4%`) contain only `4` citations (`0.42` per `1,000` lines vs. `12.77` in the introduction, a **`30.4 : 1` density skew**), with **`0` citations across Sections 4, 8, and 9 (`5,214` lines, `51.3%`)**.
- **Omitted Upstream Library & `6` Classical Pillars**: The manuscript never cites **Kontorovich–Tao's `PrimeNumberTheoremAnd` (2024–2026)** despite patching and importing it, and deploys Montgomery–Vaughan large sieve (1973), Bombieri–Vinogradov (1965), Gallagher's prime theorem (1970), Cauchy's double alternant determinant (1841), Balog–Szemerédi–Gowers (1994/1998), and Green–Tao transference (2008) without call-site attribution.

### 1.2 Upstream Patch Namespace Placement & 17-Line Notice Replacement (`CP-08`, `CP-09`, `CP-10`)
- **Unattributed Placement of `4,167` Files Under External Namespaces (`CP-08`)**: `lean/patches/ostmann.patch` (`468,948` lines, `4,175` diff blocks) creates **`4,167` new files (`+468,857` lines)** inside external namespaces (`PrimeNumberTheoremAnd/Ostmann/` `2,053`, `PrimeNumberTheoremAnd/Mathlib/` `1,774`, `Architect/` `340`).
- **Line-Preserving Replacement of Upstream 17-Line AI Notice (`CP-09`)**: `ostmann.patch:452180-452208` removes the `17`-line upstream header comment in `PrimeNumberTheoremAnd/ZetaBounds.lean:1-21` (*"Please do NOT use extensive AI tools to automaticallyfill in proofs..."*) and replaces it with **exactly `17` blank newline lines (`0x0A`)**, preserving downstream line numbers.
- **Cross-Project Grafting from `#301` & Template Relics (`CP-10`)**: The proof imports `381` files (`55,705` lines, worker namespaces `W04..W74`) from `#301` (`Monotone-ipp`), and `build/header.tex:48-55` retains unused `#005` Catalan macros (`\Catalan`, `\zetaTwo`).

### 1.3 Reachability Stratigraphy (`7,716` Files via Inclusion–Exclusion)
- **`47.8%` (`3,691 / 7,716` Files · `464,897 / 1,142,847` Lines) Unreachable (`CP-05`)**: Across the `7,716` total `.lean` files ($3,165 + 4,175 - 5 + 381 = 7,716$), the active proof cone of `Main.lean` reaches `4,025` files (`52.2%`, `677,950` lines), leaving `3,691` files (`47.8%`, `464,897` lines) in unreachable module strata.

### 1.4 Verified Mathematical Breakthrough & Three-Tier Contribution Separation
- **Unconditional Resolution of Ostmann's Inverse Goldbach Problem (1950, `Erdős #431`) Verified (`Gate 1 & Gate 5: PASS`)**: Stage 1 (finite-summand CRT composite witness), Stage 2 (Fourier sieve supply contraction `-11/125 < 0`), and Stage 3 (dyadic tree frequency budget vs. permutation decay `2/5 - 3/4 = -7/20 < 0` and $2\times 2$ Cauchy determinant $\ge 1$) are mathematically and mechanically complete.
- **Three-Tier Contribution Separation**: (1) Prior human analytic number theory & additive combinatorics foundations **`60%`**, (2) **AI dyadic-tree frequency/permutation synthesis & `4,025`-file `0-sorry` formalization breakthrough `40%` (`Gate 1 & Gate 5 PASS`)**, (3) Patch packaging & bibliographic non-conformance (`CP-03`, `CP-05`, `CP-08`, `CP-09`, `CP-10`) requiring revision.

---

## 2. Pre-bunking Predictable Objections (FAQ)

- **Q1. "Is Ostmann's Inverse Goldbach Problem (`Erdős #431`) genuinely solved here?"**
  - **Fact**: Yes. `OAI/NumberTheory/Ostmann/Main.lean` compiles with `0 sorry`, `0 axiom`, and standard `Mathlib` `Nat.Prime`, and our `75` independent `Lean 4` theorems (`393/393` mutations killed) confirm that the 3-stage proof is completely sound (`Gate 1 & Gate 5: PASS`).
- **Q2. "If the proof is a genuine breakthrough, why is it assigned `OPFF TIER C` (`Conditional Revision Required`)?"**
  - **Fact**: Because alongside the valid proof (`Gate 1 & Gate 5: PASS`), `ostmann.patch` places `4,167` generated files inside the external `PrimeNumberTheoremAnd/` namespace (`CP-08`), replaces the `17`-line upstream AI-policy notice with `17` blank lines (`CP-09`), leaves `47.8%` (`464,897` lines) of the codebase unreachable (`CP-05`), and omits Tao's `PrimeNumberTheoremAnd` and `6` classical pillars across Sections 4–9 (`Gate 2 & Gate 3: FAIL`).
- **Q3. "Do the `2` `False`-premise theorems in `Stage2/Bridge/Step283.lean` invalidate `Main.lean`?"**
  - **Fact**: No. `Step283.lean` lies inside the unreachable `3,691`-file stratum and is never imported by the `4,025`-file active cone of `Main.lean`.
- **Q4. "Could replacing the 17-line header notice in `ZetaBounds.lean` with 17 blank lines be an auto-formatter artifact?"**
  - **Fact**: Auto-formatters do not delete a `17`-line top-of-file prose comment block and insert `17` consecutive blank newline characters (`0x0A`) to preserve downstream line offsets (`ostmann.patch:452180-452208`).
- **Q5. "How is the total of `7,716` files computed?"**
  - **Fact**: By exact inclusion–exclusion: `3,165` files in `OAI/NumberTheory/Ostmann/` + `4,175` files touched by `ostmann.patch` (`4,167` created + `8` modified, minus `5` overlapping files inside `Ostmann/`) + `381` files imported from `#301` (`MonotoneSumset/`) = `7,716` files (`1,142,847` lines).
- **Q6. "What exact revisions are needed to upgrade `#013` to `OPFF TIER A`?"**
  - **Fact**: (1) Relocate the `4,167` self-authored files from `PrimeNumberTheoremAnd/` into `OAI/NumberTheory/Ostmann/` and restore the `17`-line header in `ZetaBounds.lean`, (2) prune the `3,691` unreachable files (`464,897` lines), and (3) cite Kontorovich–Tao's `PrimeNumberTheoremAnd` and the `6` classical theorem families in Sections 4–9.

---

## 3. 10-Second Terminal Reproduction (`Don't Trust, Verify`)

```bash
# 1) Verify the 7,716-file stratigraphy (4,025 active / 3,691 unreachable), 17-line notice replacement, and 3-stage proof
python3 -B proofs/verify_symbolic_ostmann.py

# 2) Kernel-check all 75 independent Lean 4 theorems (0 sorry, 0 axiom, 393/393 hypothesis mutations killed)
lake env lean proofs/ostmann_twin_engines_and_supply_contraction.lean
lake env lean proofs/ostmann_tree_transfers_and_permutation_contradiction.lean
lake env lean proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean
```
