# Forensic & Referee Audit Report: Full Audit of OpenAI #005 (Catalan's Constant Is Irrational)

## 0. Provenance & Cryptographic Ledger

| Item | Details |
| :--- | :--- |
| Target Paper / Preprint | Catalan's Constant Is Irrational (preprints/Catalans-constant-is-irrational-September-24-2026/, build/main.tex and `build/sections/*.tex` 3,001 lines, references.bib 28 keys · 319 lines) |
| Target Code Repository & Submitted PR | openai/math Family 005 (lean/OAI/NumberTheory/Catalan/ 981 .lean files · 573,816 lines + ComparatorChallenges/Catalan.lean 13 lines = 982 files · 573,829 lines) / Companion Bibliography PR: [mathcommunity/oai-math-revised#80](https://github.com/mathcommunity/oai-math-revised/pull/80) |
| Companion Reasoning Logs / Patches | Reasoning trace PDFs not provided (0 files) / External dependency patch: lean/patches/PrimeNumberTheoremAnd-lean4341.patch (39,904 lines, 55 diff blocks: 47 newly created files +33,333 lines + 8 modified upstream files +989 / -3,447 lines) |
| Toolchain & Compiler | Lean 4 v4.29.0-rc8 (independent verification archive standard) vs. audited v4.34.1 / Python 3.14 (SymPy symbolic engine) |
| Verification Artifact SHA-256 | • [catalan_rows_two_adic_and_odd_primes.lean](../proofs/catalan_rows_two_adic_and_odd_primes.lean): `194cfca5ed0b19bab3582fc453906b4904d46b5a5a3818813082fe9be590b918`<br>• [catalan_palindromic_frobenius_and_modular.lean](../proofs/catalan_palindromic_frobenius_and_modular.lean): `c4d28ebdd6a9102acd0496b7467a817a60d98bc41898093ca5b3114c24930354`<br>• [catalan_real_place_energy_and_contradiction.lean](../proofs/catalan_real_place_energy_and_contradiction.lean): `77b4a4c45c9daecb1764434bd1e20741a6cc40a112fb59eb661fab2ad2bb2432`<br>• [verify_symbolic_catalan005.py](../proofs/verify_symbolic_catalan005.py): `b555a159da0e934d8c9a3673094ee61acbed535406db50dedcb652ed02958aa0` |
| Verification Method | Independent standalone Lean 4 theorems 75 + 3 defs (1,336 lines, 0 sorry, 0 axiom, 432 / 432 universal-hypothesis mutations killed = 100%) + deterministic SymPy reproduction script |
| Governing Audit Rubric | 5-Gate Audit Rubric (Open Proof Forensic Framework; COPE · IMU/AMS · ACM v1.1 · ICMJE/CRediT · NeurIPS, Charter DOI: [10.5281/zenodo.24241228](https://doi.org/10.5281/zenodo.24241228), Ledger v1.0.0 DOI: [10.5281/zenodo.24241229](https://doi.org/10.5281/zenodo.24241229)) |
| 5-Gate & Tier Verdict | Gate 1 (Kernel / Spec Soundness): PASS (0 sorry, 0 axiom, sorryAx = 0; sound `catalan_irrational` statement) · Gate 2 (Paper–Code Alignment & Reachability): FAIL (CP-04, CP-05) · Gate 3 (Bib / Attribution & Patch Boundary): FAIL (CP-03, CP-09) · Gate 4 (Provenance & Artifact Hygiene): FAIL (CP-10, CP-11) · Gate 5 (Math Value): PASS $\implies$ TIER C (Valid Kernel Proof / Packaging & Attribution Hold) |

### 0.1 Executive 8-Metric Scorecard

| # | Audit Dimension | Surface Claim | Measured Physical Reality | Rubric Checkpoint & Verdict |
| :---: | :--- | :--- | :--- | :---: |
| 1 | Repository Active Proof Reachability | 981 .lean files · 573,816 lines | Active 473 / 981 (48.2%, 124,449 lines = 21.7%) vs. unreachable 508 / 981 (51.8%, 449,367 lines = 78.3%) | CP-05 FAIL (Gate 2) |
| 2 | Root Entrypoint (Main.lean) Propagation | 29 import statements (30 lines, 0 theorems) | 1 / 29 active (Results.Catalan, 3.4%) vs. 28 / 29 non-propagating root imports (96.6%) | CP-05 FAIL (Gate 2) |
| 3 | Manuscript Table 1 Gaussian Elimination vs. Code | Table 1 reports 144 mod-101 ($\mathbb{F}_{101}$) Gaussian-elimination pivots ($3\times 48$) | All 147 `FixedGaussian*` files (376,998 lines = 65.7%) are unreachable from the entrypoint; OpenAI's active code clears denominators by 64-digit integer `S_scale` (L494, L504, L514) and uses $\operatorname{ZMod} 101$ right-inverses (523 lines) | CP-04 · CP-05 FAIL (Gate 2) |
| 4 | Manuscript Eq. (5.15) $(n!)^2$ Asymptotic Slack vs. Code | Unnormalized bound carries $\frac{2^n K_n}{(n!)^2}$ (real-place.tex:390) before Eq. (5.15) (`eq:real-supremum-reduction`, L399-406) absorbs $-\frac{2\log(n!)}{n^2}\le 0$ into $+O(\frac{\log(n+2)}{n})$ | RealDeterminantUpper.lean:27 defines `/ ((n N).factorial : ℝ) ^ 2` and L39-50 applies `1 <= ((n N).factorial : ℝ)^2` to bound the prefactor by `(2An)^n`, matching Eq. (5.15) (`Class A / G2`) | Class A / G2 Aligned (PASS) |
| 5 | External Dependency Patch (PrimeNumberTheoremAnd) | lean/patches/PrimeNumberTheoremAnd-lean4341.patch (39,904 lines) | Replaces 17 lines of Kontorovich-Tao's notice in PrimeNumberTheoremAnd/IEANTN/Mertens (openai/math commit 4eaee87; absent from oai_ref, @@ -284,23 +284,23 @@, excerpt L228–L284) with 17 blank lines (0x0A $\times 17$) + places 46 custom files (+33,333 lines) under PrimeNumberTheoremAnd/ | CP-03 (Gate 3) · CP-10/CP-11 (Gate 4) FAIL |
| 6 | Citation Density & Direct Borrowing Attribution | 37 `\cite` calls across 3,001 .tex lines (28 .bib keys) | 30/37 (81.1%, 9.90/100L) in Intro/Conclusion (303L) vs. 7/37 (18.9%, 0.26/100L = 38.1 : 1) in §2–§7 (2,698L); omits `PrimeNumberTheoremAnd` (Kontorovich–Tao 2024) & `Newman (1980)` (`CP-03 / CP-09`), distinct from 19th-century textbook eponyms (`INFO`) | CP-03 · CP-09 FAIL (Gate 3) |
| 7 | Active-Tree Binder Hygiene & Namespace Conventions | 0 sorry, 0 axiom (passes kernel typecheck) | 1 dummy binding (have _ := hlo), 1 post-colon `Filter.atTop` convention, 8 unused `_h*` binders, and 13 duplicate private theorem declarations in the same namespace (`Class A / Gate 2 hygiene`) | Gate 1 PASS · Class A / Gate 2 Hygiene (INFO/WARN) |
| 8 | Adelico-Archimedean Proof Core Validity | Irrationality of Catalan's constant ($G \notin \mathbb{Q}$) | Finite-place exponent > -2.29084 vs. real-place exponent < -2.290939875 < -2.2909 contradiction holds; re-verified in 1,336 lines via 75 standalone Lean 4 theorems (432/432 mutants killed) | Gate 1 · Gate 5 PASS |

### 0.2 Three-Tier Traffic-Light Scope Summary

- (Mathematically Valid & Sound Kernel Core; Gate 1: PASS, Gate 5: PASS) Adelico-Archimedean Squeeze (124,449 lines): Combining $\zeta(2)$ cancellation at Taylor order $L=59N$, $2$-adic perfect-square completion $-\frac{2809}{4608}\log 2$, Kummer single-carry filtration, and the 8-interval odd-prime integral $\frac{8609}{2}$ (> -2.29084) with palindromic Frobenius block factorization ($\det U = 2^{p(p-1)/2}$), OpenAI's $\operatorname{ZMod} 101$ right-inverse certificates ($\det \equiv 27, 50, 74 \not\equiv 0$), and two-sheeted Blaschke-Cauchy conformal energy with 50-point Descartes sign brackets (< -2.290939875 < -2.2909) validly proves `catalan_irrational` (`0 sorry, 0 axiom, sorryAx = 0`), independently re-verified across 75 standalone Lean 4 theorems (432/432 mutations killed).
- (Paper–Code Divergence & Hygiene; Gate 2: FAIL [CP-04, CP-05]): The 376,998 lines of mod-101 ($\mathbb{F}_{101}$) Gaussian elimination trace (147 `FixedGaussian*` files) corresponding to Manuscript Table 1 are unreachable from the entrypoint (while OpenAI's active `FixedDeterminantsNonzero.lean` multiplies mod-101 right-inverses after clearing denominators with the 64-digit integer scalar `S_scale` at L494, L504, L514), and 508 / 981 files (449,367 / 573,816 lines = 78.3%) alongside 28 / 29 (96.6%) non-propagating root imports in `Main.lean` lie outside the active cone. Meanwhile, `RealDeterminantUpper.lean:39-50`'s `1 <= ((n N).factorial : ℝ)^2` step aligns with `real-place.tex:399-406` (`eq:real-supremum-reduction`, `Class A / G2` asymptotic slack, not a Gate 2 divergence), and the 10 `_h*` / `Filter.atTop` / `hlo` items plus 13 duplicate private theorem names are `Class A / Gate 2 hygiene` formalization conventions.
- (Attribution, Patch Boundary & Provenance Hold; Gate 3: FAIL [CP-03, CP-09], Gate 4: FAIL [CP-10, CP-11] $\implies$ TIER C): Line-preserving stripping of the 17-line Kontorovich & Tao notice in `PrimeNumberTheoremAnd/IEANTN/Mertens` (openai/math commit 4eaee87; absent from oai_ref, @@ -284,23 +284,23 @@) into 17 blank lines (`0x0A * 17`), placement of 46 custom files (`+33,333` lines) under `PrimeNumberTheoremAnd/` without origin headers on the 14 active `Catalan/*` & `ZetaFive/*` files (`Gate 3 CP-03`), omission of `PrimeNumberTheoremAnd` and `Newman (1980)` from `.tex`/`.bib` (`CP-03 / CP-09`), and missing reasoning trace PDFs / provenance metadata (`Gate 4 CP-10/CP-11`) place the submission in **TIER C (Valid Kernel Proof / Packaging & Attribution Hold)**.



## Part 1. Bibliographic Distribution & Attribution Audit

### 1.1 Section-by-Section Citation Density Distribution (9 `build/*.tex` files, 3,001 lines, 37 `\cite` calls)

| Manuscript Segment | Files (`build/sections/*.tex`) | Lines (%) | Citations (%) | Citations per 100 Lines | Verdict |
| :--- | :--- | :---: | :---: | :---: | :---: |
| Introduction & Conclusion (3 files) | build/main.tex (44 lines, 0), introduction.tex (208 lines, 26), conclusion.tex (51 lines, 4) | 303 (10.1%) | 30 (81.1%) | 9.90 | Front/Back Concentration |
| Technical Proof Body (§2–§7) | foundations.tex, odd-primes.tex, real-place.tex, etc. | 2,698 (89.9%) | 7 (18.9%) | 0.26 | Attribution Deficit |
| Total | All .tex (28 keys in references.bib; incl. non-input `Sun2026` `[math.GM]`) | 3,001 (100%) | 37 (100%) | 1.23 | 38.1 : 1 Density Ratio |

### 1.2 Upstream Dependency Attribution Gap (`CP-03 / CP-09 FAIL`) vs. Classical Textbook Eponyms (`INFO`)

1. Direct Code & Method Borrowing (`CP-03 / CP-09 FAIL`: `PrimeNumberTheoremAnd` & `Newman 1980`):
   - Manuscript Section 3.4 (build/sections/odd-primes.tex:612) invokes the Chebyshev prime-sum asymptotic $\theta(y) = \sum_{p \le y}\log p \sim y$ and names Newman's analytic proof in prose, while citing only Zagier's secondary exposition (Zagier1997).
   - Meanwhile, OpenAI's active Lean proof (ImportedPNTCoreBridge.lean:2,8 and ContinuousWeightedPNT.lean) patches and imports Alex Kontorovich and Terence Tao's PrimeNumberTheoremAnd repository (commit c39a751) to invoke CatalanPNT.WeakPNT'' (L28) and CatalanPNT.chebyshev_asymptotic (L32), while `PrimeNumberTheoremAnd` and `Newman (1980)` are absent from references.bib.
2. Separation of Direct Borrowing (`CP-03 / CP-09`) from 19th-Century Textbook Eponyms (`INFO`) in PR #80:

| Manuscript Location (File:Line) | Mathematical Identity / Theorem / External Library Used | Original Citation | Literature Classification & Restored Reference |
| :--- | :--- | :--- | :--- |
| Section 3.4 (odd-primes.tex:612) | PrimeNumberTheoremAnd Lean 4 library & Newman's analytic proof (named in prose) | Zagier1997 (secondary note only) | **`CP-03 / CP-09 FAIL` (Direct Code/Method Borrowing)**: Kontorovich, Tao & contributors (2024) (`PrimeNumberTheoremAnd`); Newman (1980) (10.2307/2321853) |
| Section 3.4 (odd-primes.tex:612) | Classical Prime Number Theorem ($\theta(y)\sim y$) | Zagier1997 (secondary note) | **`INFO` (19th-Century Textbook Eponym)**: Hadamard (1896) (10.24033/bsmf.545); de la Vallée Poussin (1896) |
| Section 2.2 (foundations.tex:146, Lemma 2.1) | Catalan's log-tangent integral $-4\int_0^{\pi/4}\log\tan v\,dv = 4G$ | Uncited (0) | **`INFO` (19th-Century Classical Background)**: Catalan (1865) (Mém. Acad. Roy. Belgique 33, 1–50) |
| Section 2.3 (foundations.tex:292, Prop 2.3) & Section 3.1 (odd-primes.tex:81, Lemma 3.1) | Legendre's factorial $p$-adic valuation $\lfloor z/p\rfloor - 2\lfloor(z/2)/p\rfloor$ and Kummer's single-carry theorem | Uncited (0) | **`INFO` (19th-Century Textbook Eponyms)**: Legendre (1808) (Essai sur la théorie des nombres); Kummer (1852) (10.1515/crll.1852.44.93) |
| Section 2.3 (foundations.tex:385) & Section 3 (odd-primes.tex:16) | Cauchy-Binet minor expansion transferring valuation lower bounds across $\det(\mathcal{F}\mathcal{T})$ | Uncited (0) | **`INFO` (19th-Century Textbook Eponyms)**: Binet (1813) (J. École Polytech. 9(16)); Cauchy (1815) (J. École Polytech. 10(17)) |
| Section 1.2 (introduction.tex:155-156) & Section 5.1 (real-place.tex:43, 59) | Andréief multiple-integral determinant identity and Cauchy double alternant $\det[(1-t_i s_j)^{-1}]$ | Secondary surveys (Forrester2018Andreief, Krattenthaler1999) | **`INFO` (19th-Century Primary Sources)**: Andréief (1886) (Mém. Soc. Sci. Bordeaux 2, 1–14); Cauchy (1841) (Exercices d'analyse 2, 151–159) |
| Section 5.3 (real-place.tex:342, Prop 5.3) | Hadamard determinant bound ($\le n^{n/2}$) on unit-circle Vandermonde monomial matrices | Uncited (0) | **`INFO` (19th-Century Textbook Eponym)**: Hadamard (1893) (Bull. Sci. Math. (2) 17, 240–246) |



## Part 2. Provenance Omission Audit

- Absence of Reasoning Trace PDFs & Cross-Problem Seed Reference:
  - Family #005 (Catalan's Constant Is Irrational) includes 0 reasoning trace PDFs or initial prompt files.
  - Section 1 of the companion #017 ($\mu(\pi)=2$) reasoning trace documents that the #005 Catalan proof architecture was supplied as an initial seed across problem families.



## Part 3. External-Namespace Placement (`Gate 3 CP-03`) & Upstream Notice Removal (`Gate 3/4`)

### 3.1 External-Namespace Placement (PrimeNumberTheoremAnd-lean4341.patch, 39,904 lines)

- Patch Structure (55 diff blocks, 39,904 lines):
  - Creates 47 new files (46 Lean files + SiegelZeros/NOTICE.md in upstream openai/math commit 4eaee87, absent from oai_ref, +33,333 lines) and modifies 8 existing upstream files (+989 / -3,447 lines).
  - Places 46 custom Lean files directly under the external PrimeNumberTheoremAnd/ namespace (`PrimeNumberTheoremAnd/Catalan/*` and `PrimeNumberTheoremAnd/ZetaFive/*`). Of these, 14 patch-injected files (5,367 lines: 8 in `Catalan/*` 2,452 lines + 6 in `ZetaFive/*` 2,915 lines) are transitively imported into the active proof cone of Results/Catalan.lean under the PrimeNumberTheoremAnd library namespace (`Gate 3 CP-03 FAIL`).

### 3.2 Line-Preserving `blueprint_comment` Stripping of Upstream Authors' 17-Line Notice

- Forensic Location: lean/patches/PrimeNumberTheoremAnd-lean4341.patch L38712–L38745 (excerpt snapshot [PrimeNumberTheoremAnd-lean4341.patch](../proofs/oai_ref/patches/PrimeNumberTheoremAnd-lean4341.patch#L228-L284), modifying upstream PrimeNumberTheoremAnd/IEANTN/Mertens at @@ -284,23 +284,23 @@, lines 287–303, in upstream openai/math commit 4eaee87; absent from oai_ref).
- Observed Byte & Line Transformation: The 17-line blueprint_comment block authored by Kontorovich & Tao in IEANTN/Mertens (openai/math commit 4eaee87; absent from oai_ref; patch L38723, excerpt [L255](../proofs/oai_ref/patches/PrimeNumberTheoremAnd-lean4341.patch#L255): "As such, extensive use of AI tools is \emph{strongly discouraged} in this section.") is stripped and replaced by an identical count of 17 blank newline characters (0x0A $\times 17$), preserving all subsequent line-number offsets.
- Code Removal & Attribution Split in Upstream PrimeNumberTheoremAnd/Wiener (L31316–L35688): Removes -2,716 lines (+439 / -2,716 lines) of upstream proofs, import Architect, and blueprint_comment blocks from PrimeNumberTheoremAnd/Wiener (openai/math commit 4eaee87; absent from oai_ref; excerpt [L178-L227](../proofs/oai_ref/patches/PrimeNumberTheoremAnd-lean4341.patch#L178-L227)). While modified `Wiener.lean` adds a 5-line `Adapted from PrimeNumberTheoremAnd...` Apache-2.0 attribution header (excerpt [L184-L188](../proofs/oai_ref/patches/PrimeNumberTheoremAnd-lean4341.patch#L184-L188), alongside `SiegelZeros/NOTICE.md` at excerpt [L153](../proofs/oai_ref/patches/PrimeNumberTheoremAnd-lean4341.patch#L153)), the 14 newly created `PrimeNumberTheoremAnd/Catalan/*` and `PrimeNumberTheoremAnd/ZetaFive/*` files in the active cone carry no license or origin headers.

### 3.3 Cross-Family Worker Namespace Imports (#004 $\zeta(5)$)

- ImportedPNTCoreBridge.lean:2,8 opens namespace Zeta5.W12.ImportedPNTCoreBridge, and ContinuousWeightedPNT.lean:11,18 imports 7 files (1,086 lines) from OAI/NumberTheory/ZetaFive/ (#004 $\zeta(5)$) and opens namespace Zeta5.Workers.W14 (`Gate 4 CP-10/CP-11`).



## Part 4. Stratigraphy & Non-Propagating Root Imports Audit (981 Files · 573,816 Lines)

### 4.1 Catalan/ Repository Reachability Partition (981 Files · 573,816 Lines, [thm_40_catalan_981_file_stratigraphy_and_ghost_ledger](../proofs/catalan_palindromic_frobenius_and_modular.lean#L270))

| Category | Files (%) | Lines of Code (%) | Composition & Role |
| :--- | :---: | :---: | :--- |
| Internal Active Proof Cone | 473 (48.2%) | 124,449 (21.7%) | Transitively reachable from Results/Catalan.lean (Conclusions.lean) |
| External Patch-Placed / Cross-Family Active Files | 21 (outside Catalan/) | 6,453 (external) | 14 .patch-placed files (5,367 lines) + 7 ZetaFive/ files (1,086 lines) |
| Unreachable Module Strata | 508 (51.8%) | 449,367 (78.3%) | Not referenced by the main theorem Results/Catalan.lean (including 147 `FixedGaussian*` files totaling 376,998 lines) |
| Non-Propagating Root Imports (Main.lean) | 29 imports | 30 lines (0 theorems) | 1 / 29 active (Results.Catalan, 3.4%) vs. 28 / 29 non-propagating root imports (96.6%) ([catalan_real_place_energy_and_contradiction.lean](../proofs/catalan_real_place_energy_and_contradiction.lean#L302)) |



## Part 5. Paper–Code Alignment & Active-Tree Hygiene Audit

### 5.1 Manuscript vs. Active Code Alignment Matrix

| Audit Axis | Manuscript (`build/*.tex`) Claim | Actual Repository (Lean 4) Active Code State | Classification |
| :--- | :--- | :--- | :---: |
| 1. Section 4 Nonvanishing Certificate (Table 1 Gaussian Elimination vs. $\mathbb{F}_{101}$ Right-Inverses) | Section 4, Table 1: Presents 144 mod-101 ($\mathbb{F}_{101}$) Gaussian-elimination pivots ($3\times 48$) and row-swap counts (0, 2, 0) as the nonvanishing proof | All 147 `FixedGaussian*` files (376,998 lines, 65.7% of the repo) implementing Table 1 belong to the unreachable module strata; OpenAI's active proof (FixedDeterminantsNonzero.lean, 523 lines) clears denominators via the 64-digit integer scalar `S_scale` (L494, L504, L514) and multiplies $48\times 48$ right-inverses over $\operatorname{ZMod} 101$ (FixedModularZeroRightInverse.lean, FixedModularPlusRightInverse.lean, FixedModularMinusRightInverse.lean) showing $\det \equiv 27, 50, 74 \pmod{101}$ ([catalan_palindromic_frobenius_and_modular.lean](../proofs/catalan_palindromic_frobenius_and_modular.lean#L290), [catalan_real_place_energy_and_contradiction.lean](../proofs/catalan_real_place_energy_and_contradiction.lean#L283)) | Paper–Artifact Divergence (`Gate 2 CP-04, CP-05 FAIL`) |
| 2. Section 5 Eq. (5.15) $(n!)^2$ Asymptotic Slack (`real-place.tex:389-408`) | build/sections/real-place.tex:389-408: Unnormalized L390 carries $\frac{2^n K_n}{(n!)^2}$, and Eq. (5.15) (`\label{eq:real-supremum-reduction}`, L399-406) already drops $-\frac{2\log(n!)}{n^2}\le 0$ into $+O(\frac{\log(n+2)}{n})$ | Active code RealDeterminantUpper.lean:26-54 defines `/ ((n N).factorial : ℝ) ^ 2` at L27 and applies `realDeterminant_factorial_sq_one_le` (`(1 : ℝ) ≤ ((n N).factorial : ℝ) ^ 2`, L39-50) to bound the prefactor by $(2An)^n$, matching Eq. (5.15); our guide constructively notes the full $(n!)^2$ Stirling refinement (`thm_60`) | `Class A / G2` Manuscript-Aligned Asymptotic Slack (PASS) |

### 5.2 Active-Tree Binder Hygiene & Asymptotic Formalization Conventions (10 Conventions & 13 Duplicate Declarations, `Class A / Gate 2 hygiene`)

| Hygiene Category | Formalization Convention Description | Count | Locations (File:Line & Theorem/Binder) |
| :--- | :--- | :---: | :--- |
| 1. Dummy Binding (have _ := hlo) | Declares lower-bound hypothesis hlo and binds it to have _ := hlo without referencing it in subsequent steps (`Class A / Gate 2 hygiene`) | 1 | OddLowerPairPool.lean:230-232 ([catalan_rows_two_adic_and_odd_primes.lean](../proofs/catalan_rows_two_adic_and_odd_primes.lean#L237)) |
| 2. Post-Colon `Filter.atTop` Convention | Places asymptotic filter ∀ᶠ N : ℕ in atTop after the colon (:) inside the conclusion type (`Class A / Gate 2 hygiene`) | 1 | OddPrimeLossNormalization.lean:210-213 ([catalan_palindromic_frobenius_and_modular.lean](../proofs/catalan_palindromic_frobenius_and_modular.lean#L368)) |
| 3. Unused `_h*` Premises | Unused underscore-prefixed binders in active proof-cone theorems (`Class A / Gate 2 hygiene`) | 8 | FinitePlaceAssembly.lean:479, 626 (_hrep, _z), OddPrimeCentralZetaContraction.lean:773 (_hN, _hH), OddPrimeExtractionIndices.lean:36 (_hp), FixedCompactRowsAll.lean:115, 122 (_n, _hn), BarrierCaseTwoBracketYGroup0.lean:138 (_hk) |
| 4. Duplicate Declarations in Same Namespace | Identically named private theorems declared across separate files in namespace OAI.InternalCatalan (`Class A / Gate 2 hygiene`) | 13 | • barrier_T_3 .. barrier_T_8 (6): BarrierCaseTwoPointX0.lean:15-37 & BarrierCaseOnePointY1.lean:12-34<br>• barrier_case2_U_3 .. barrier_case2_U_9 (7): BarrierCaseTwoXExplicitGroup7.lean:490-516 & BarrierCaseTwoXBaseProductCoefficientsData.lean:355-381 ([catalan_palindromic_frobenius_and_modular.lean](../proofs/catalan_palindromic_frobenius_and_modular.lean#L257)) |



## Part 6. Constructive Verification, Kernel & Core Certification (`Gate 1 & Gate 5: PASS`) & Repair

### 6.1 Kernel Soundness & Mathematical Validity of the Active Core (124,449 Lines, Gate 1: PASS, Gate 5: PASS)

- Independently of packaging and attribution gaps, the active proof cone (473 files, 124,449 lines) passes Gate 1 (Kernel / Spec Soundness: 0 sorry, 0 axiom, `sorryAx = 0`, sound `catalan_irrational` statement) and executes a mathematically valid Adelico-Archimedean squeeze proving $G \notin \mathbb{Q}$ (Gate 5: PASS):
  1. Finite-place ($2$-adic & odd-prime) lower bound: Combines $\zeta(2)$ cancellation at Taylor order $L=59N$, $2$-adic perfect-square slope $-\frac{2809}{4608}\log 2$, Kummer single-carry filtration, and the 8-interval odd-prime loss integral $\frac{8609}{2}$ to establish the finite-place exponent > -2.29084 (Theorems 1–25).
  2. Palindromic Frobenius splitting & $\operatorname{ZMod} 101$ certificate: Uses palindromic change-of-basis determinant $\det U = 2^{p(p-1)/2}$ and OpenAI's $\operatorname{ZMod} 101$ right-inverse multiplication ($\det \equiv 27, 50, 74 \not\equiv 0 \pmod{101}$) to certify nonvanishing rational determinants (Theorems 26–50).
  3. Real-place two-sheeted energy upper bound & contradiction: Establishes the real-place exponent < -2.290939875 < -2.2909 via Blaschke-Cauchy conformal grafting and 50-point Descartes sign brackets, yielding $G \notin \mathbb{Q}$ from the product-formula contradiction $-2.29084 < -2.2909$ (Theorems 51–75).

### 6.2 Independent Lean 4 Verification & Hygiene Refinements (75 Theorems, 432/432 Mutations Killed)

1. 3 standalone .lean files (75 theorems + 3 defs, 0 sorry, 0 axiom, 432/432 mutations killed):
   - Reconstructs the 573,829-line codebase into 1,336 lines of standalone Lean 4 theorems, provides streamlined forms without the unused `hlo` and post-colon `atTop` wrappers ([catalan_rows_two_adic_and_odd_primes.lean](../proofs/catalan_rows_two_adic_and_odd_primes.lean#L237), [catalan_palindromic_frobenius_and_modular.lean](../proofs/catalan_palindromic_frobenius_and_modular.lean#L368)), and documents the full $(n!)^2$ accounting ([thm_60_andreief_vandermonde_pair_count_plus_diagonal](../proofs/catalan_real_place_energy_and_contradiction.lean#L167)).
2. Architectural Remediation Specifications:
   - ① Restore the 17-line upstream notice in PrimeNumberTheoremAnd/IEANTN/Mertens (openai/math commit 4eaee87; absent from oai_ref) and relocate all 46 custom files out of PrimeNumberTheoremAnd/ into OAI/,
   - ② Prune the 508 unreachable files (449,367 lines, 78.3%) and the 28 non-propagating imports in Main.lean,
   - ③ Align Manuscript Section 4 (Table 1) with OpenAI's active ZMod 101 right-inverse certificate (`FixedDeterminantsNonzero.lean`), and add `PrimeNumberTheoremAnd` and `Newman (1980)` to `.tex`/`.bib`.

### 6.3 Verification of Zero sorryAx Propagation Across the PrimeNumberTheoremAnd Patch Chain and 109-Line Space (0x20) Replacement Audit

1. Zero sorryAx Propagation Across the 10-File (2,937-Line) Active Patch Chain and 4-Step WeakPNT'' Derivation:
   - Tracing the external import cone from [Conclusions.lean:11-23](../proofs/oai_ref/lean/Conclusions.lean#L11-L23) (catalan_irrational) through [ImportedPNTCoreBridge.lean:1-43](../proofs/oai_ref/lean/ImportedPNTCoreBridge.lean#L1-L43) (PrimeNumberTheoremAnd.Catalan.Consequences; openai/math commit 4eaee87, absent from oai_ref) confirms that it traverses only 10 newly patched files (2,937 lines: 7 under `Catalan/*` and 3 under ZetaFive/Fourier, Sobolev, SmoothExistence; openai/math commit 4eaee87, absent from oai_ref) before closing in pure `Mathlib.*`, importing 0 of the upstream PrimeNumberTheoremAnd files containing the 34 unfinished sorrys (sorryAx = 0):
     - ① Top-level tsum (∑') definition ([Challenge_Catalan.lean:7-9](../proofs/oai_ref/lean/Challenge_Catalan.lean#L7-L9)): Because a non-summable ∑' in Mathlib evaluates to 0 : ℝ (¬ Irrational 0), proving `Irrational (∑' j : ℕ, (-1 : ℝ) ^ j / ((2 * j + 1 : ℕ) : ℝ) ^ 2)` automatically forces series convergence to Catalan's constant $G$.
     - ② Zero-free region on $\operatorname{Re}(s) \ge 1$ (OrdinaryZetaZeroFree, 175 lines; openai/math commit 4eaee87, patch file absent from oai_ref): Derives $\zeta(s) \neq 0$ for $s \neq 1, \operatorname{Re}(s) \ge 1$ directly from Complex.riemannZeta via $3 + 4\cos\theta + \cos 2\theta = 2(1+\cos\theta)^2 \ge 0$.
     - ③ Regularization & Wiener-Ikehara Tauberian theorem (OrdinaryZetaContinuation & Catalan/Wiener; openai/math commit 4eaee87, patch files absent from oai_ref): Uses `Function.update (fun s ↦ (s-1)*riemannZeta s) 1 1` and WienerIkeharaTheorem' to derive Tendsto (fun N ↦ cumsum Λ N / N) atTop (𝓝 1) (WeakPNT).
     - ④ WeakPNT'' and chebyshev_asymptotic (Catalan/Consequences, 68 lines; openai/math commit 4eaee87, patch file absent from oai_ref): Combines $\psi(R)/R \to 1$ with Chebyshev.abs_psi_sub_theta_le_sqrt_mul_log to obtain $\theta(R)/R \to 1$, matching Mathlib's Chebyshev.psi and Chebyshev.theta by rfl in [ImportedPNTCoreBridge.lean:12-18](../proofs/oai_ref/lean/ImportedPNTCoreBridge.lean#L12-L18).
2. Upstream Wiener -2,716-Line Truncation, 109 Lines of Byte-Preserving Space (0x20) Replacement in Cloned Blueprint Comments, and Entry omitted from formalization.yaml:
   - Beyond the 17-line newline (0x0A) replacement in IEANTN/Mertens (openai/math commit 4eaee87; absent from oai_ref, @@ -284,23 +284,23 @@), [PrimeNumberTheoremAnd-lean4341.patch](../proofs/oai_ref/patches/PrimeNumberTheoremAnd-lean4341.patch) truncates -2,716 lines from the upstream Wiener module and replaces 109 lines of upstream blueprint_comment blocks across 4 cloned files (6 lines in Catalan/Wiener, 6 in WienerBounds, 29 in ZetaFive/Sobolev, and 68 in ZetaFive/Wiener) with exact byte-length ASCII spaces (0x20), while #005 is also omitted from the root formalization.yaml (176-paper index, `Gate 4 CP-10/CP-11`).



## Part 7. Standard-Bound Verdict & Formal Conclusion

### 7.1 COPE & International Standards Compliance Matrix

| Standard-Bound Category | Governing Criterion | Confirmed Coordinates & Metrics in #005 | Verdict |
| :--- | :--- | :--- | :---: |
| Paper–Artifact Alignment & Reachability (Gate 2) | 1-to-1 correspondence between manuscript tables/equations and active proof code; entrypoint reachability (ACM Artifact Review v1.1, CP-04, CP-05) | • Presenting 376,998 lines (147 files) of unreachable Gaussian-elimination code in Manuscript Table 1 while active code uses `ZMod 101` right-inverses (`CP-04`)<br>• 28/29 (96.6%) non-propagating root imports in Main.lean alongside 449,367 / 573,816 lines (78.3%, 508/981 files) of unreachable module strata (`CP-05`; note Eq. 5.15 / `(n!)^2` is `Class A / G2` aligned) | Gate 2 FAIL (CP-04 · CP-05) |
| Attribution & External-Namespace Patch Boundary (Gate 3) | Attribution of borrowed libraries/methods, preservation of upstream notices, and namespace boundary hygiene (COPE · AMS, CP-03, CP-09) | • Placing 46 custom files (+33,333 lines) under `PrimeNumberTheoremAnd/` without origin headers on the 14 active `Catalan/*` & `ZetaFive/*` files (`CP-03`)<br>• Stripping 17 lines of Kontorovich-Tao's notice in `IEANTN/Mertens` (openai/math commit 4eaee87; absent from oai_ref, @@ -284,23 +284,23 @@) via `0x0A * 17` while omitting `PrimeNumberTheoremAnd` and `Newman (1980)` from `.tex`/`.bib` (`CP-03 · CP-09`) | Gate 3 FAIL (CP-03 · CP-09) |
| Provenance & Artifact Hygiene (Gate 4) | Traceability of prompt/reasoning logs, cross-family worker provenance, and index consistency (CP-10, CP-11) | • 0 reasoning trace PDFs or initial prompt files; cross-family reuse of #004 `Zeta5.W12/W14` worker files (1,086 lines) and `#005` omitted from `formalization.yaml` | Gate 4 FAIL (CP-10 · CP-11) |

### 7.2 Three-Tier Attribution Analysis: Human Mathematical Foundations vs. Computer-Assisted Proof (CAP) Core vs. Automated Packaging Pipeline

1. Hybrid Human Library, CAS Certificate, and Lean Formalization Dependency Profile:
   - The proof builds on three layers: ① Kontorovich and Tao's PrimeNumberTheoremAnd repository (Wiener-Ikehara Tauberian machinery and Chebyshev prime-sum asymptotic $\theta(y) \sim y$), ② Rivoal-Zudilin hypergeometric determinant and multiple-integral frameworks, and ③ external CAS/numerical optimization searches that produced the Taylor contact order $L=59N$, the $3 \times 48^2 = 6,912$ entries of the $\operatorname{ZMod} 101$ right-inverse matrices, and the 50-point Descartes bracket grid.
   - In particular, the $48 \times 48$ modular right-inverses hardcoded in FixedModularZeroRightInverse.lean, FixedModularPlusRightInverse.lean, and FixedModularMinusRightInverse.lean and the polynomial bracket arrays in `BarrierCase*` are serialized certificates computed by an external linear-algebra / root-isolation solver and checked inside Lean (`decide +kernel` / `norm_num`).
2. Substantive Mathematical Achievement of the Active Computer-Assisted Proof (CAP) Core (Gate 1: PASS, Gate 5: PASS):
   - The active proof cone (473 files, 124,449 lines) combining palindromic Frobenius block splitting ($\det U = 2^{p(p-1)/2}$) + OpenAI's $\operatorname{ZMod} 101$ right-inverse certification (523 lines) + $2$-adic perfect-square completion ($-\frac{2809}{4608}\log 2$) + 8-interval odd-prime loss integration ($\frac{8609}{2}$) + two-sheeted Blaschke-Cauchy conformal energy upper bounds (<-2.290939875 < -2.2909) constitutes a mathematically complete, kernel-verified computer-assisted proof of $G \notin \mathbb{Q}$ (`0 sorry, 0 axiom`).
3. Packaging and Attribution Gaps Introduced by the Automated Pipeline (Gates 2–4: FAIL):
   - Conversely, ① retaining 147 superseded mod-101 ($\mathbb{F}_{101}$) Gaussian-elimination trace files (`FixedGaussian*`, 376,998 lines) after switching to the 523-line $\operatorname{ZMod} 101$ right-inverse multiplication (`M * R = I`) certificate and leaving 28/29 non-propagating imports in Main.lean (78.3% unreachable strata), ② presenting the unimported Gaussian pivots in Manuscript Table 1, and ③ mechanically stripping 17 lines of upstream notice in IEANTN/Mertens (openai/math commit 4eaee87; absent from oai_ref) with `0x0A * 17` while placing 46 worker files under PrimeNumberTheoremAnd/ and omitting `PrimeNumberTheoremAnd` / `Newman (1980)` from `.bib` reflect automated multi-worker (`Zeta5.W12/W14`) packaging and citation gaps rather than a soundness flaw in the kernel proof.

### 7.3 Pre-bunking FAQ (6 Anticipated Questions & Fact-Based Responses)

- Q1. "If Results/Catalan.lean compiles with 0 sorry and 0 axiom in the Lean 4 kernel, why is the submission assigned TIER C?"
  - A1. The 5-Gate Audit Rubric evaluates kernel/spec soundness (`Gate 1: PASS`, `sorryAx = 0`, sound `catalan_irrational` statement) and mathematical validity (`Gate 5: PASS`) separately from paper–code alignment (`Gate 2`), bibliographic/patch attribution (`Gate 3`), and provenance (`Gate 4`). Because the kernel proof is valid and sorry-free, it passes Gate 1 and Gate 5; however, 78.3% unreachable code and Manuscript Table 1 divergence (`Gate 2: FAIL [CP-04, CP-05]`), placing 46 custom files under `PrimeNumberTheoremAnd/` while stripping the 17-line upstream notice and omitting `PrimeNumberTheoremAnd` / `Newman (1980)` (`Gate 3: FAIL [CP-03, CP-09]`), and missing provenance traces (`Gate 4: FAIL [CP-10, CP-11]`) place the package in **TIER C (Valid Kernel Proof / Packaging & Attribution Hold)**.
- Q2. "Does leaving 376,998 lines of Gaussian elimination (`FixedGaussian*`) unreachable create a gap in the nonvanishing determinant proof?"
  - A2. No. For an integer matrix $M \in \mathbb{Z}^{48 \times 48}$, showing $\det(M \bmod 101) \equiv 27, 50, 74 \not\equiv 0 \pmod{101}$ via a right-inverse over $\operatorname{ZMod} 101$ immediately implies $\det M \neq 0$ over $\mathbb{Q}$ ([catalan_palindromic_frobenius_and_modular.lean](../proofs/catalan_palindromic_frobenius_and_modular.lean#L290)). Mathematically, OpenAI's 523-line modular right-inverse proof is cleaner and faster; the packaging issue (`CP-04, CP-05`) is retaining 376,998 lines of unreachable mod-101 Gaussian-elimination trace code in the repository and presenting Table 1's Gaussian pivots as the active proof path (whereas the 64-digit integer `S_scale` only appears as the pre-reduction denominator-clearing scalar in FixedDeterminantsNonzero.lean:494, 504, 514).
- Q3. "Does `RealDeterminantUpper.lean:39-50`'s `1 <= ((n N).factorial : ℝ)^2` step diverge from Manuscript Eq. (5.15) or weaken the real-place bound?"
  - A3. No on both counts. Direct inspection of `real-place.tex:389-408` proves that the paper's numbered Eq. (5.15) (`\label{eq:real-supremum-reduction}`, L399-406) already absorbs $-\frac{2\log(n!)}{n^2} \le 0$ into $+O(\frac{\log(n+2)}{n})$, matching `RealDeterminantUpper.lean:39-50` (`1 <= ((n N).factorial : ℝ)^2`) directly. Thus `(n!)^2 >= 1` is `Class A / G2` manuscript-aligned asymptotic slack (not a Gate 2 divergence), and the two-sheeted conformal energy leaves enough margin (`0.000099875`) to beat the finite-place lower bound (`> -2.29084`), while our guide constructively notes the full $(n!)^2$ accounting in [thm_60_andreief_vandermonde_pair_count_plus_diagonal](../proofs/catalan_real_place_energy_and_contradiction.lean#L167).
- Q4. "Wasn't the 17-line removal in IEANTN/Mertens (openai/math commit 4eaee87; absent from oai_ref) just an automated build-fix stripping `blueprint_comment` blocks?"
  - A4. Regardless of intent, a line-offset-preserving `blueprint_comment` stripper (`0x0A * 17` at patch L38712–L38745, @@ -284,23 +284,23 @@, excerpt [L228-L284](../proofs/oai_ref/patches/PrimeNumberTheoremAnd-lean4341.patch#L228-L284), alongside `0x20 * 109` across 4 cloned files) mechanically erased the 17-line upstream author notice (`"As such, extensive use of AI tools is \emph{strongly discouraged} in this section."`) while `references.bib` simultaneously omitted `PrimeNumberTheoremAnd` and the 14 active `Catalan/*` & `ZetaFive/*` files lacked origin headers, producing a dual attribution gap (`Gate 3 FAIL [CP-03, CP-09]`).
- Q5. "Does the dummy binding have _ := hlo in OddLowerPairPool.lean:230 invalidate the main theorem?"
  - A5. No. The target inequality in that lemma holds monotonically from the upper-bound hypothesis alone without needing hlo (`Class A / Gate 2 hygiene`). Our standalone theorem [thm_13_repaired_oddUpperProfiles_without_vacuous_hlo](../proofs/catalan_rows_two_adic_and_odd_primes.lean#L237) removes the unused hlo binder and proves the streamlined statement with 0 sorry.
- Q6. "What does PR #80 (mathcommunity/oai-math-revised#80) accomplish?"
  - A6. PR #80 restores Kontorovich & Tao's `PrimeNumberTheoremAnd` and `Newman (1980)` (`CP-03 / CP-09`), along with classical 19th-century background references (Catalan 1865, Legendre 1808, Kummer 1852, Cauchy 1815/1841, Binet 1813, Andréief 1886, Hadamard 1893/1896, de la Vallée Poussin 1896) at their mathematical call sites in `.tex` and `references.bib`, and records the complete patch, reachability, and paper–code audit ledger in NOTES.md (companion bibliography PR mathcommunity/oai-math-revised#80 vs. upstream openai/math commit 4eaee87; absent from oai_ref).

### 7.4 10-Second Terminal Reproduction

```bash
# 1. Verify all 75 standalone Lean 4 theorems (0 sorry, 0 axiom) and SymPy symbolic checks
lean proofs/catalan_rows_two_adic_and_odd_primes.lean && \
lean proofs/catalan_palindromic_frobenius_and_modular.lean && \
lean proofs/catalan_real_place_energy_and_contradiction.lean && \
(cd proofs && python3 verify_symbolic_catalan005.py)

# 2. Inspect the 17-line blank-line replacement in IEANTN/Mertens (openai/math commit 4eaee87; absent from oai_ref) inside the patch snapshot
sed -n '228,284p' proofs/oai_ref/patches/PrimeNumberTheoremAnd-lean4341.patch
```

### 7.5 Referee Verdict Summary

- Formal Verdict: **TIER C (Valid Kernel Proof / Packaging & Attribution Hold)** (`Gate 1: PASS · Gate 2: FAIL · Gate 3: FAIL · Gate 4: FAIL · Gate 5: PASS`) / PR #80 Bibliographic Restoration & Audit Pending Merge
- OpenAI #005's active mathematical proof core (473 files, 124,449 lines: $\operatorname{ZMod} 101$ right-inverse certificate and Adelico-Archimedean squeeze) compiles with `0 sorry, 0 axiom` (`sorryAx = 0`) for a sound `catalan_irrational` statement (**Gate 1: PASS**) and validly proves $G \notin \mathbb{Q}$ (**Gate 5: PASS**). However, the submitted manuscript and repository packaging remain in **TIER C (Valid Kernel Proof / Packaging & Attribution Hold)** due to: (1) 449,367 / 573,816 lines (78.3%, 508 / 981 files) of unreachable module strata, 28 / 29 (96.6%) non-propagating root imports in `Main.lean`, and paper–artifact divergence between Manuscript Table 1 (376,998 lines of unreachable mod-101 Gaussian elimination) and the active `ZMod 101` certificate (**Gate 2: FAIL [CP-04, CP-05]**; note Eq. 5.15 `(n!)^2 >= 1` is `Class A / G2` manuscript-aligned asymptotic slack), (2) line-preserving `blueprint_comment` stripping of Kontorovich & Tao's 17-line notice in `PrimeNumberTheoremAnd/IEANTN/Mertens` (openai/math commit 4eaee87; absent from oai_ref, @@ -284,23 +284,23 @@) via `0x0A * 17`, placement of 46 custom files (`+33,333` lines) under `PrimeNumberTheoremAnd/` without origin headers on the 14 active files, and omission of `PrimeNumberTheoremAnd` and `Newman (1980)` from `.tex`/`.bib` (**Gate 3: FAIL [CP-03, CP-09]**), and (3) missing reasoning trace PDFs / prompt provenance and `formalization.yaml` omission (**Gate 4: FAIL [CP-10, CP-11]**).
- Submitted [PR #80](https://github.com/mathcommunity/oai-math-revised/pull/80) restores `PrimeNumberTheoremAnd`, `Newman (1980)`, and classical background references at their mathematical call sites in the manuscript and records the patch structure, notice stripping, and unreachable module strata audit in NOTES.md (companion bibliography PR mathcommunity/oai-math-revised#80 vs. upstream openai/math commit 4eaee87; absent from oai_ref).
