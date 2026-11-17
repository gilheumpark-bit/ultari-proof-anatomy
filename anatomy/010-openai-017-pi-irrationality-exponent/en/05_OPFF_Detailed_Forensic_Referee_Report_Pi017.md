# Forensic & Referee Audit Report: Full Audit of OpenAI #017 (The irrationality exponent of $\pi$ is $2$)

## 0. Provenance & Cryptographic Ledger

| Item | Details |
| :--- | :--- |
| Target Paper / Preprint | The irrationality exponent of $\pi$ is $2$ (preprints/The-irrationality-exponent-of-pi-is-2-September-24-2026/, 5 files across main.tex and `sections/*.tex` · 1,591 lines; references.bib 269 lines · 25 entries) |
| Target Code Repository & Scope Doc | openai/math Family 017 (869 .lean files in OAI/NumberTheory/PiExponent/ · 94,948 lines + ComparatorChallenges/PiExponent.lean 19 lines + lean/docs/017.md 17 lines) |
| Companion Reasoning Logs / Patches | reasoning_traces/irrationality-exponent-of-pi.pdf (42 pages, 45 sections: Part I Sections 1–44 $\mu(\pi) \le 62/25 = 2.48$, Part II Section 45 $\mu(\pi) = 2$) / 0 third-party patches (pure Mathlib dependency) |
| Toolchain & Compiler | Lean 4 v4.34.1 (upstream corpus) · Lean 4 v4.35.0 (OPFF verification archive standard) / Python 3.14 (SymPy symbolic engine) |
| Verification Artifact SHA-256 (1–3) | • [pi_simplex_parameters_and_stratigraphy.lean](../proofs/pi_simplex_parameters_and_stratigraphy.lean): `fa4c73cf1acb7f311a5dae2018c521b69cb2eeb031b65880034e2ecc6362ca1d`<br>• [pi_transverse_multiplicity_and_seshadri_blowup.lean](../proofs/pi_transverse_multiplicity_and_seshadri_blowup.lean): `2e7c8c2e726ce1180002dc3a2f0f84d37fb1bc8a28c88d83aa567bb12d828313`<br>• [pi_laurent_determinant_and_flint_hills.lean](../proofs/pi_laurent_determinant_and_flint_hills.lean): `3795672a078f1f74760c2ec9f7723d2ba4915f963b916008cf4e26ffc599d8b9` |
| Verification Artifact SHA-256 (4–5) | • [verify_symbolic_pi017.py](../proofs/verify_symbolic_pi017.py): `602809c6314c4c89e605e2a6544e993e2860a4707b34eb4144511490ce01ff4d`<br>• [symbolic_verification_result.json](../proofs/symbolic_verification_result.json): `01470abe37f8962dd8b5e9fe2331d0c3184993848ae371f3d4fd65859bda73a1` |
| Verification Method | Independent Lean 4 formalization 75 theorems (1,646 lines, 0 sorry, 0 axiom, 120/120 hypothesis mutations killed, 44 nonlinear/inductive proofs) + deterministic parser audit across 60 oai_ref/ files |
| Governing Charter | Open Proof Forensics Foundation (OPFF) 5-Gate Joint International Audit Charter (COPE · IMU/AMS · ACM v1.1 · ICMJE/CRediT · NeurIPS, Charter DOI: [10.5281/zenodo.24241228](https://doi.org/10.5281/zenodo.24241228), Ledger v1.0.0 DOI: [10.5281/zenodo.24241229](https://doi.org/10.5281/zenodo.24241229)) |
| OPFF 5-Gate & Formal Tier Verdict | Gate 1 (Kernel/Spec): PASS · Gate 2 (Paper-Code): HOLD · Gate 3 (Bib/Ethics): FAIL · Gate 4 (Provenance): HOLD · Gate 5 (Math Value): PASS $\implies$ OPFF TIER C (Conditional Revision Required) |



### 0.1 Executive 8-Metric Scorecard

| # | Audit Dimension | Measured Metric | Standard | Status |
| :-: | :--- | :---: | :---: | :---: |
| 1 | Reachability & Call-Graph Redundancy | 869 / 869 imported (100%) · 4 files (259 lines) unreferenced · 552 unused decls | Clean call-graph | HOLD (CP-05, CP-10) |
| 2 | Kernel & Premise Integrity | 0 sorry, 0 axiom, 0 third-party patches · 14 unused `_h*` lines (15 binders) | 0 sorry, 0 axiom | PASS (Kernel Sound) |
| 3 | Main Theorem & Scope Note Alignment | Theorem 1.1 ($\mu(\pi)=2$) & Corollary 1.2 (Flint-Hills) proved (017.md:11 omits Cor 1.2) | Exact scope match | PASS (Gate 1) / HOLD (Gate 2) |
| 4 | Section Citation Skew (Manuscript Distribution) | Intro 24 commands / 25 keys (90.9 / 1k lines) vs. Secs 2–5 13 (9.8 / 1k lines) (9.3 : 1 skew; Sec 4 0) | Balanced attribution | FAIL (CP-03) |
| 5 | Trace-to-Paper Citation Drop & Uncited Classics | 25 / 25 .bib linked · 16 / 23 (69.6%) trace refs dropped + 6 classical families uncited | Zero trace ref drop | FAIL (CP-03) |
| 6 | Worker Namespace Strata & Duplication | 0 external namespace placement · 20 worker namespaces (W06–W64) · 263 dup names | Unified namespace | HOLD (CP-10) |
| 7 | Provenance & Reasoning Trace Completeness | 42-page (45-section) trace (Sec 1–44 $\mu \le 62/25$ $\to$ Sec 45 $\mu = 2$) provided | Full trace disclosure | HOLD (CP-07) |
| 8 | Mathematical Breakthrough & Mutation Kill | Genuine resolution of $\mu(\pi) = 2$ & Flint-Hills convergence · 75 thms (120/120 mutations) | Genuine breakthrough | PASS (Gate 5) |



### 0.2 Three-Tier Traffic-Light Summary

* Standard Non-Conformance (CP-03):
  1. Trace-to-Paper Citation Drop (16 / 23 = 69.6%): Out of 23 references cited in the 42-page reasoning trace (reasoning_traces/irrationality-exponent-of-pi.pdf), 16 references (69.6%) were dropped from the final manuscript's references.bib, including 35 citations to the companion preprint #005 (Catalan's constant is irrational, [17]), Esnault-Viehweg (1984, [11]), Ru-Vojta (1997, [20]), Vojta (1996, [22]), Bombieri-Vaaler (1983, [6]), Fischler-Rivoal (2018/2023, [12, 13]), and Hartshorne (1977, [14]).
  2. Technical Body Citation Skew (9.3 : 1) & 6 Uncited Classical Theorem Families (CP-03): While the introduction (main.tex, 264 lines) contains 24 \cite commands (25 key invocations, 90.91 commands per 1,000 lines), the 4 technical proof sections (Sections 2–5, 1,327 lines) contain only 13 citations (9.80 per 1,000 lines, with 0 in conclusion.tex), deploying 6 foundational theorem families without citation at the call sites (Esnault-Viehweg 1984 / Faltings 1991 / Fischler-Nakamaye 2014 weighted multiprojective zero estimates; Ax 1971 / Lang 1982 logarithmic differential residue rigidity; Serre 1955 / Hartshorne 1977 algebraic Čech-Serre vanishing; Laurent 1991 / Waldschmidt 2000 interpolation determinant row translation; Chebyshev 1852 / Hanson 1972 / Nair 1982 dyadic LCM bounds; Jordan 1882 / Hardy-Littlewood 1923 dyadic semicircle spacing).
* Scope Note Discrepancy, Structural Adaptations & Call-Graph Redundancy (CP-04, CP-05, CP-10):
  1. lean/docs/017.md:11 Scope Note vs. Main.lean:29-32 (Discovery 1): 017.md:11 states relative to the comparator wrapper PiExponent.lean (theorem main) that "The paper's convergence consequence for the Flint-Hills series is outside this selected statement", leading external commentators to report that Flint-Hills was unformalized. In fact, OAI/NumberTheory/PiExponent/Main.lean:29-32 (flint_hills_summable) fully proves Corollary 1.2 with 0 sorry (only the two-parameter generalization Corollary 5.2 is omitted).
  2. Four Constructive Paper-to-Lean Adaptations & Internal Redundancy: The Lean formalization replaces continuous simplex volume ($2k!$) in Lemma 2.2 with an inscribed discrete rectangle ($k^k$, inflating $C_*$ by 3.83 × 10^6$\times$ at $m=6$), shifts the LCM constant across three strata ($\Lambda_{\text{PNT}} \approx 1.732 \to \Lambda_{\text{paper}} = 4\log 2 \approx 2.773 \to \Lambda_{\text{Lean}} = \log 4 + 4 \approx 5.386$), replaces complex Kodaira vanishing with algebraic Rees blowups and finite-cover Čech cohomology, and simplifies the Flint-Hills constant from $8/\pi$ to 16 via Fin 4 residue partitioning. Across the 869 imported files, 4 files (259 lines) have 0 outgoing references, 5 files (309 lines) are instance-only, 552 declarations are unreferenced, 263 declaration names are duplicated (656 times), 23 theorem pairs are verbatim duplicates, and 20 parallel worker namespaces (W06–W64, 137 blocks) remain unmerged.
* Verified Mathematical & Formal Breakthrough (Gate 1 & Gate 5: PASS):
  - Both main claims - Theorem 1.1 ($\mu(\pi) = 2$) and Corollary 1.2 (convergence of the Flint-Hills series $\sum_{n=1}^{\infty} (n^3 \sin^2 n)^{-1} < \infty$) - are mathematically sound and mechanically verified across 869 Lean 4 modules (94,948 lines, 0 sorry, 0 custom axioms, 0 external patches), independently confirmed by our 75 Lean 4 theorems (120/120 hypothesis mutations killed).



## Part 1. Bibliographic Distribution & Attribution Audit

### 1.1 Section-by-Section Citation Density Distribution (5 .tex files, 1,591 lines)

| Section | File (Lines) | `\cite` Calls | Density (per 1,000 lines) | Audit Finding |
| :--- | :--- | :---: | :---: | :--- |
| Section 1 (Introduction & Main Results) | [main.tex](../proofs/oai_ref/tex/main.tex#L1-L264) (264 lines) | 24 (25 keys) | 90.91 / 1k lines | Concentrates historical survey and prior bounds ($7.1032$, Salikhov, Zeilberger-Zudilin) |
| Section 2 (Weighted Zero Estimate & Blowup) | [interpolation.tex](../proofs/oai_ref/tex/sections/interpolation.tex#L1-L584) (584 lines) | 9 | 15.41 / 1k lines | Cites Stacks Project (x4), mondal2021 (x2), lazarsfeld, philippon1986, demailly1992 |
| Section 3 (Laurent Interpolation Determinant) | [determinant.tex](../proofs/oai_ref/tex/sections/determinant.tex#L1-L432) (432 lines) | 2 | 4.63 / 1k lines | Cites `\cite[Section~6]{laurent1991}` at L6 and `\cite[Theorem~1]{laurent2000}` in §3.3 at L263; 0 citations inside Lemmas 3.1–3.2 |
| Section 4 (Parameters & Proof of $\mu(\pi)=2$) | [conclusion.tex](../proofs/oai_ref/tex/sections/conclusion.tex#L1-L156) (156 lines) | 0 | 0.00 / 1k lines | 100% uncited across Lemma 4.1 and the final contradiction of Theorem 1.1 |
| Section 5 (Flint-Hills Series Convergence) | [series.tex](../proofs/oai_ref/tex/sections/series.tex#L1-L155) (155 lines) | 2 | 12.90 / 1k lines | Cites alekseyev, meiburg (x1 each); 0 citations in Lemma 5.1 proof |
| Total (Sections 1–5) | 5 .tex files (1,591 lines) | 37 commands (38 keys; 25/25 .bib linked) | Skew Ratio 9.28 : 1 (Intro vs. Secs 2–5) | 100% .bib linkage, but 9.3 : 1 citation density drop in the technical proof body |

### 1.2 16 / 23 (69.6%) Reasoning-Trace References Dropped & 6 Uncited Classical Theorem Families

1. 16 of 23 references (69.6%) cited in reasoning_traces/irrationality-exponent-of-pi.pdf (42 pages) omitted from the final references.bib:
   - Omitted companion preprints (2 items): OpenAI (2026) [17] (Catalan's constant is irrational, #005), cited 35 times across Part I as the direct template for weighted multiprojective jet interpolation, and [18] (The joint Dickman law..., 1 citation).
   - Omitted algebraic geometry & Diophantine foundations (14 items): H. Esnault & E. Viehweg (1984) [11] (Invent. Math. 78, 3 citations), M. Ru & P. Vojta (1997) [20] / P. Vojta (1996) [22] (5 citations), E. Bombieri & J. Vaaler (1983) [6] (Invent. Math. 73), S. Fischler & T. Rivoal (2018, 2023) [12, 13], and R. Hartshorne (1977) [14] (Algebraic Geometry).
2. 6 primary classical theorem families deployed across Sections 2–5 (1,327 lines) without call-site attribution:

| Axis | Manuscript & Lean Coordinates | Uncited Classical Mechanism | Call-Site Citations | Primary Foundational Literature (DOI) |
| :-: | :--- | :--- | :---: | :--- |
| I | interpolation.tex:24-98, 198-249 / WeightSeparation.lean | Weighted multiprojective zero estimate on $(\mathbb{P}^1)^m \times \mathbb{P}^1$ under lacunary weight separation $\prod w_a > C_* \prod v_b$ | 0 (dropped from trace) | Esnault-Viehweg (1984, 10.1007/BF01388447), Faltings (1991, 10.2307/2944319), Ru-Vojta (1997, 10.1007/s002220050114), Fischler-Nakamaye (2014, 10.5802/aif.2869) |
| II | interpolation.tex:303-368 (Eq. 2.15–2.16) / LogarithmicObstruction.lean | Logarithmic differential identity $dX_i = dY/Y$ under commuting derivations $D_0 = Y\partial_Y + \sum \partial_{X_i}$ and simple-pole residue obstruction $\operatorname{ord}_P Y \neq 0$ | 0 | Ax (1971, 10.2307/1970774), Lang (1982, 10.1007/978-1-4757-1779-2) |
| III | interpolation.tex:427-584 (Eq. 2.17–2.23) / FiniteCoverCohomology.lean | Convex-combination ampleness on finite-colength Rees blowups (Eq. 2.20) and finite affine cover Čech-Serre vanishing $H^1 = 0$ | Tag 0B5U only | Serre (1955, 10.2307/1969915), Hartshorne (1977, 10.1007/978-1-4757-3849-0 II.7 & III.4–5), Kodaira (1953) |
| IV | determinant.tex:172-335 (Lemma 3.2–3.3) / RowTranslation.lean & AdmissibleMatrixInterpolation.lean:76-123 | Derivative-free Laurent interpolation determinant row-translation invariance (Lemma 3.2), `actualMatrix_surjective_of_formalPackets`, and Taylor vanishing + Cauchy-Schwarz collision order bound (`determinant.tex:260-335`; `thm_69, thm_75` use `Matrix.vandermonde` only as a standalone verification model) | L6 (`\cite[Section~6]{laurent1991}`), L263 (`\cite[Theorem~1]{laurent2000}` in §3.3); 0 in Lemma 3.2 | Laurent (1991, Astérisque 198-200), Waldschmidt (2000, 10.1007/978-3-662-11569-5, Chap. 9) |
| V | determinant.tex:84, 136-143 (Lemma 3.1) / Arithmetic.lean:13-24 | Elementary dyadic central-binomial bound $\operatorname{lcm}(1,\dots,n) \le 4^{2n}$ ($\Lambda_{\text{paper}} = 4\log 2$) and Chebyshev bound $\Lambda_{\text{Lean}} = \log 4 + 4$ | 0 | Chebyshev (1852), Hanson (1972, 10.4153/CMB-1972-007-7), Nair (1982, 10.2307/2320934) |
| VI | series.tex:23-91 (Lemma 5.1, Cor 1.2) / FlintSine.lean | Dyadic shell semicircle minimum-spacing rearrangement $x_j \ge jd$ and Jordan's sine chord inequality $\lvert\sin x\rvert \ge \frac{2}{\pi}\lvert x\rvert$ | 0 | Jordan (1882, Cours d'analyse I), Hardy-Littlewood (1923, 10.1007/BF02403921) |



## Part 2. Two-Part Reasoning Trace Evolution & Provenance Audit

1. Pivot from Part I ($\mu(\pi) \le 62/25 = 2.48$) to Part II ($\mu(\pi) = 2$) in irrationality-exponent-of-pi.pdf (42 pages, 45 sections):
   - Part I (Sections 1–44, pp. 1–39, 95% of trace): Records 31 negative exploratory branches (Sections 1–31, including arctangent Padé, Salikhov integrals, semicircle Toeplitz, CM Masser relations, and #005 Catalan mixed moments), then establishes $\mu(\pi) \le 62/25 = 2.48 < 5/2$ and Flint-Hills series convergence ($2\mu - 5 = -1/25 < 0$) in Sections 32–44 using fixed exponents ($a=0.8, b=0.887, c=0.89$) and $\Lambda_{\text{PNT}} \approx 1.732$ ([pi_simplex_parameters_and_stratigraphy.lean](../proofs/pi_simplex_parameters_and_stratigraphy.lean#L106-L124)).
   - Part II (Section 45, pp. 39–40, 1.2 pages): Observes that in the high-dimensional limit $m \to \infty$ on $(\mathbb{P}^1)^m \times \mathbb{P}^1$, the simplex factorial $m!$ cancels between numerator and denominator ([pi_laurent_determinant_and_flint_hills.lean](../proofs/pi_laurent_determinant_and_flint_hills.lean#L167-L187)), setting $\theta = 1-\delta$, $A = 1-b\delta$, $b \in (1/2, 1-1/\nu)$ to reach $\mu(\pi) = 2$ for every $\nu > 2$.
2. Omission of Search Path in Final Manuscript:
   - The final manuscript (main.tex and `sections/*.tex`) omits the 39-page Part I intermediate theorem ($\mu(\pi) \le 62/25 = 2.48$) and the borrowing provenance from #005 Catalan's geometric framework, presenting only the Section 45 final construction in deductive order.



## Part 3. Parallel Worker Namespace Strata & Code Duplication Audit

1. 20 Parallel Agent Worker Namespaces (W06–W64, 137 blocks) Retained in Code (CP-10):
   - OAI/NumberTheory/PiExponent/ retains 20 numbered worker namespaces across PiExponentJets.W06–W64 (11), PiExponentSiegel.W08–W58 (6), and PiExponentSiegelAux.W09/W30/W31 (3).
2. 263 Duplicate Declaration Names (656 occurrences) & 23 Verbatim Cloned Theorem Pairs (CP-10):
   - Across 422 namespaces, 263 declaration names are defined multiple times (schemeFreeOpen 34 times across 30 files; schemeUnit 10 times), and 23 pairs of theorems ($\ge 120$ characters) have byte-identical proof bodies (including 7 declarations cloned between Cohomology/PencilCohomologySections.lean and Approximation/GlobalSectionClearing.lean).



## Part 4. Stratigraphy & Call-Graph Reachability Audit (869 Modules, 94,948 Lines)

### 4.1 Subdirectory Stratigraphy of OAI/NumberTheory/PiExponent/

| Subdirectory | Files | Lines (%) | Thms / Defs / Structs / Insts | Unused `_h*` | Primary Mathematical Role |
| :--- | :---: | :---: | :---: | :---: | :--- |
| Geometry/ | 181 | 19,957 (21.0%) | 834 / 375 / 8 / 61 | 4 | Weighted projective compactification Proj(imageGrade a), normalized curve model, Bézout (Prop 2.3) |
| LocalAlgebra/ | 172 | 16,427 (17.3%) | 754 / 236 / 9 / 37 | 2 | Regular local rings, maximal-ideal power quotients, regular parameter frames |
| Approximation/ | 133 | 15,257 (16.1%) | 709 / 269 / 3 / 24 | 2 (3 binders) | Lemma 4.1 parameters (Parameters.lean), separation constant $C_*$, determinant contradiction |
| Cohomology/ | 99 | 14,821 (15.6%) | 623 / 318 / 4 / 52 | 4 | Finite affine cover Čech cohomology (FiniteCoverCohomology.lean), algebraic Serre vanishing (Tag 0B5U) |
| Ampleness/ | 119 | 11,028 (11.6%) | 497 / 198 / 2 / 47 | 0 | Finite-colength Rees blowups, exceptional divisor degree, convex-combination ampleness (Eq. 2.20) |
| Jets/ | 63 | 6,945 (7.3%) | 348 / 144 / 0 / 3 | 0 | Algebraic Hasse-Taylor stalk maps and transverse multiplicity (Lemma 2.2) |
| Polynomials/ | 68 | 6,698 (7.1%) | 312 / 132 / 0 / 17 | 2 | Euclidean quotient-remainder simplex lattice sandwich (SimplexCounting.lean) |
| Analysis/ | 32 | 3,752 (4.0%) | 216 / 37 / 0 / 0 | 0 | Cauchy integral bounds, field-trace logarithmic obstruction, Flint-Hills Fin 4 residue partition |
| (root) | 2 | 63 (0.1%) | 5 / 6 / 0 / 0 | 0 | Statement.lean & Main.lean (`pi_irrationalityExponent_eq_two`, `flint_hills_summable`) |
| Total | 869 | 94,948 (100%) | 4,298 / 1,715 / 26 / 241 | 14 lines (15) | 869 / 869 (100%) file import reachability, 0 sorry, 0 axiom |

### 4.2 Call-Graph Audit: 4 Unreferenced Imported Modules (259 Lines) & 552 Unreferenced Declarations

- While all 869 files are transitively imported by Main.lean:
  1. 4 imported files (259 lines) have 0 outgoing declaration or instance references: Approximation/OpenPullbackUnit.lean (2 lines, empty wrapper), Geometry/LineBundleGluingTransitions.lean (85 lines), Jets/FormalBranchOrder.lean (136 lines, superseded by FormalBranchOrderRational.lean), and Polynomials/WeightedMonomialLattice.lean (36 lines).
  2. 5 files (309 lines) are instance-only modules, and 552 top-level declarations are unreferenced across the call-graph (including LaurentChartPresentation in ProjectiveTwistAcyclicity.lean:26-79, 7 cone lemmas in Ampleness/NefAmple.lean:23-113, PolynomialLocalUnmixedness.lean 156 lines, and LocalAlgebra/Dimension.lean 172 lines).



## Part 5. Paper–Artifact Divergence & Constructive Adaptation Audit

| Axis | Manuscript (`sections/*.tex`) & Scope Note (017.md) | Actual Lean 4 Code (OAI/NumberTheory/PiExponent/) | Classification |
| :--- | :--- | :--- | :---: |
| 1. 017.md:11 Flint-Hills Scope Note | lean/docs/017.md:11 states (relative to PiExponent.lean) that the Flint-Hills series convergence result is "outside this selected statement" | [Main.lean:29-32](../proofs/oai_ref/lean/OAI/NumberTheory/PiExponent/Main.lean#L29-L32) fully proves flint_hills_summable (Corollary 1.2) with 0 sorry (only the two-parameter Corollary 5.2 is omitted) | Scope Note Under-Reporting (Discovery 1) |
| 2. Lemma 2.2 Multiplicity Bound & $C_*$ | Continuous unit-cube covering $\ge \frac{T^k}{2k!\prod \kappa_b}$ and $C_*^{\text{paper}} = \max 2k!(L_0/\sigma)^k$ (Eq. 2.5, 2.8) | Inscribed discrete rectangle $\ge \frac{T^k}{k^k\prod \kappa_b}$ (RectangularVolume.lean) and $C_*^{\text{Lean}} = 2(m+2)^{m+2}(1+(m+2)/\sigma)^{m+2}$ (3,826,375$\times$ larger at $m=6, \sigma=1$, absorbed by lacunary weights) | Valid Discrete Adaptation |
| 3. Section 3 Global Matrix Size $M = \lvert\mathcal{A}\rvert$ | Continuous simplex volume integral $M \prod w_i \ge v_0^m / m!$ (determinant.tex:29-34) | Two opposite injections (`card_le_card_of_injOn` sandwich) via Euclidean division $b_i \mapsto (b_i/w_i, b_i \bmod w_i)$ proving $\lvert\Delta_1(N)\rvert \le \lvert\Delta_w(N)\rvert \prod w_i$ and $\lvert\Delta_w(N)\rvert \prod w_i \le \lvert\Delta_1(N + \sum(w_i - 1))\rvert$ without Riemann integration (`SimplexCounting.lean:40-110`) | Exact Combinatorial Bridge |
| 4. Three-Tier LCM Constant $\Lambda$ | Trace Part I: $\Lambda_{\text{PNT}} \approx 1.732$ $\to$ Paper Lemma 3.1: central binomial dyadic sum $\Lambda_{\text{paper}} = 4\log 2 \approx 2.7726$ | Arithmetic.lean:13-24: invokes Mathlib's Chebyshev.psi_le_const_mul_self with $\Lambda_{\text{Lean}} = \log 4 + 4 \approx 5.3863$ | Three-Stratum Constant Shift |
| 5. Lemma 5.1 Flint-Hills Sine Constant | Semicircle projection $[-\pi/2, \pi/2)$ with Jordan constant $8/\pi$ (series.tex:86) | `FlintSine.lean:74-86` (`sineGroup_residue_injective` via Fin 4 residue classes) & `L88-126` (rational constant 16 = $4 \times 4$) | Valid Rational Adaptation |



## Part 6. Constructive Verification & Constant Compression (75 Theorems, 120/120 Mutations Killed)

### 6.1 Verification of Mathematical & Kernel Soundness (Gate 1 & Gate 5: PASS)

- Auditing all 24 structure bundles and core algebraic-geometry definitions (Scheme, LineBundle.IsAmple, cohomology, IntegralCurve, curveDegree) across the 869 modules confirms 0 definition distortions and 0 vacuous structure bundles. Furthermore, Euler periodicity $e^{2\pi i j} = 1 \in \mathbb{Z}[i]$ and Gaussian integer determinant norm multiplicativity $\|\Delta\| \ge 1$ strictly block overreach to general Liouville numbers ([pi_laurent_determinant_and_flint_hills.lean](../proofs/pi_laurent_determinant_and_flint_hills.lean#L77-L109)).

### 6.2 OPFF Independent Lean 4 Verification (75 Theorems) & 5,000$\times$ $C_*$ Compression

1. 75 Independent Lean 4 Theorems (1,646 lines, 0 sorry, 120/120 mutations killed):
   - Formalized across [pi_simplex_parameters_and_stratigraphy.lean](../proofs/pi_simplex_parameters_and_stratigraphy.lean) (Theorems 1–25), [pi_transverse_multiplicity_and_seshadri_blowup.lean](../proofs/pi_transverse_multiplicity_and_seshadri_blowup.lean) (Theorems 26–50), and [pi_laurent_determinant_and_flint_hills.lean](../proofs/pi_laurent_determinant_and_flint_hills.lean) (Theorems 51–75).
2. Eliminating the 5,000$\times$ ($m=2$) / 3,826,375$\times$ ($m=6$) $C_*$ Inflation Without Riemann Integration (thm_27, thm_28):
   - Combining the Euclidean quotient-remainder sandwich with the falling-factorial simplex inequality $(Q-k)^k \le k!\binom{Q}{k}$ restores the exact $1/k!$ simplex volume factor ($C_*^{\text{paper}} = 64$ at $m=2, \sigma=1$) purely combinatorially ([pi_transverse_multiplicity_and_seshadri_blowup.lean](../proofs/pi_transverse_multiplicity_and_seshadri_blowup.lean#L120-L133)).



## Part 7. Standard-Bound Verdict & Formal Conclusion (OPFF Verdict)

### 7.1 International Standards & COPE Matrix

| OPFF Gate | Governing Standard | Measured Evidence in #017 | Verdict |
| :--- | :--- | :--- | :---: |
| Gate 1 (Kernel & Spec Soundness) | IMU/AMS + Lean Kernel TCB | 869 files (94,948 lines) with 0 sorry, 0 axiom, 0 external patches; both $\mu(\pi)=2$ (Main.main) and Flint-Hills convergence (Main.flint_hills_summable) kernel-verified | PASS |
| Gate 2 (Paper–Artifact Alignment) | ACM Artifact Badging v1.1 (CP-04, CP-05, CP-10) | 017.md:11 under-reports flint_hills_summable; 4 paper-to-Lean constant/geometric adaptations ($\Lambda$: $4\log 2 \to \log 4 + 4$); 4 unreferenced files (259 lines), 552 unused decls, 23 cloned theorem pairs | HOLD |
| Gate 3 (Bibliographic Attribution) | COPE + AMS Ethical Guidelines (CP-03) | 16 / 23 (69.6%) reasoning-trace references dropped from references.bib (incl. #005 Catalan x35, Esnault-Viehweg 1984, Ru-Vojta 1997); 9.3 : 1 citation skew and 6 classical theorem families uncited in Sections 2–5 | FAIL (Attribution Deficit) |
| Gate 4 (Process Provenance) | ICMJE + CRediT + NeurIPS (CP-07) | 42-page (45-section) reasoning trace PDF disclosed (Part I $62/25 \to$ Part II $2$); 20 parallel worker namespaces (W06–W64) retained in code | HOLD |
| Gate 5 (Mathematical Breakthrough) | IMO / Erdős / Mathlib Standard | Complete unconditional resolution of $\mu(\pi) = 2$ and Flint-Hills series convergence, independently verified across 75 theorems (120/120 mutations killed) | PASS |



### 7.2 Three-Tier Contribution Separation (Verified Breakthrough vs. Classical Algebraic Geometry vs. Trace Citation Drop)

| Contribution Stratum | Share | Measured Content & File Coordinates | Audit Verdict |
| :--- | :---: | :--- | :---: |
| 1. Prior Human Algebraic Geometry & Transcendence Theory (Classical Foundations) | 65% | Laurent interpolation determinants (Laurent 1991, 2000), multiprojective zero estimates & Seshadri interpolation (Philippon 1986; Esnault-Viehweg 1984; Ru-Vojta 1997; Fischler-Nakamaye 2014), algebraic Čech-Serre vanishing (Serre 1955; Hartshorne 1977), logarithmic differential residue rigidity (Ax 1971), Chebyshev-Hanson-Nair LCM bounds | Prior Human Theory (16 dropped trace refs + 6 classical families require restoration) |
| 2. AI High-Dimensional Asymptotic & Constructive Formalization Breakthrough | 35% | Section 45 asymptotic $m!$ cancellation on $(\mathbb{P}^1)^m \times \mathbb{P}^1$ with parameter window $\theta = 1-\delta, A = 1-b\delta, b \in (1/2, 1-1/\nu)$ closing $\mu(\pi)=2$, plus constructive replacement of continuous integrals and complex Kodaira vanishing by Euclidean division sandwiches (SimplexCounting.lean), algebraic Hasse-Taylor stalk maps (Jets/), and finite-cover Čech cohomology (Cohomology/) across 869 0-sorry modules | Verified Breakthrough Contribution (Gate 1 & Gate 5 PASS) |
| 3. Packaging & Bibliographic Omissions (Editorial Deficit) | Remediable | 16/23 (69.6%) trace references dropped from .bib, 017.md:11 scope under-reporting of flint_hills_summable, 4 unreferenced files (259 lines), 552 unused declarations, 20 worker namespaces (W06–W64) | Does not affect mathematical validity (Conditional Revision) |



### 7.3 Pre-Bunking FAQ (6 Questions & Verified Answers)

1. Q1. "Are $\mu(\pi)=2$ (Theorem 1.1) and Flint-Hills series convergence (Corollary 1.2) genuinely proved without gaps?"
   - A1. Yes. Both `pi_irrationalityExponent_eq_two` (`Main.lean:14-15`), `main` (`Main.lean:17-27`), and `flint_hills_summable` (`Main.lean:29-32`) compile across 869 modules (94,948 lines) with 0 sorry, 0 custom axioms, and 0 external patches, and our 75 independent Lean 4 theorems (120/120 mutations killed) confirm zero definition distortion.
2. Q2. "Why did external reviews claim that the Flint-Hills series was not formalized in #017?"
   - A2. Because lean/docs/017.md:11 described only the single-theorem comparator wrapper ComparatorChallenges/PiExponent.lean (theorem main). Direct inspection of [Main.lean:29-32](../proofs/oai_ref/lean/OAI/NumberTheory/PiExponent/Main.lean#L29-L32) and [FlintConsequence.lean](../proofs/oai_ref/lean/OAI/NumberTheory/PiExponent/Analysis/FlintConsequence.lean#L17-L31) ($\nu = 9/4$) shows that classical Flint-Hills convergence (Corollary 1.2) is completely formalized with 0 sorry ([pi_simplex_parameters_and_stratigraphy.lean](../proofs/pi_simplex_parameters_and_stratigraphy.lean#L95-L103)).
3. Q3. "Does this proof suffer from an overreach flaw that would also force $\mu(\alpha)=2$ for a Liouville number $\alpha$?"
   - A3. No. Lemma 3.1 (MatrixArithmetic.lean) and Lemma 3.2 (RowTranslation.lean) rely on Euler's period identity $e^{2\pi i j} = 1 \in \mathbb{Z}[i]$ and Gaussian integer clearing $q_i r_i = 2\pi i p_i \in 2\pi i \mathbb{Z}[i]$. For a general Liouville number $\alpha$, $e^{j\alpha} \notin \mathbb{Z}[i]$, blocking both row-translation invariance and the Gaussian norm lower bound $\|\Delta\| \ge 1$ ([pi_laurent_determinant_and_flint_hills.lean](../proofs/pi_laurent_determinant_and_flint_hills.lean#L77-L109)).
4. Q4. "Why don't the constant shifts between paper and Lean ($\Lambda = 4\log 2$ vs. $\log 4 + 4$, and $C_*^{\text{paper}}$ vs. $C_*^{\text{Lean}}$) break the exponent $2$?"
   - A4. Because in Section 4 (AdmissibleParameters.lean), the dimension $m$ is fixed first and the lacunary weights $w_1 \gg w_2 \gg \dots \gg w_m$ are chosen inductively afterward. Any constant depending only on $(m, \sigma)$ or $\Lambda$ is absorbed into the tail sum $\Lambda \sum_{i=1}^m 1/w_i < \varepsilon_0 / 3$ (WeightErrorMargin.lean).
5. Q5. "If Gate 1 and Gate 5 both PASS, why is the overall tier OPFF TIER C (Conditional Revision Required)?"
   - A5. Under the OPFF 5-Gate rubric, a submission that resolves its target problem (Gate 1 & Gate 5: PASS) but exhibits a Gate 3 attribution deficit - here, dropping 16 / 23 (69.6%) references from its own reasoning trace (including 35 citations to #005 Catalan and Esnault-Viehweg 1984 / Ru-Vojta 1997) and omitting call-site citations for 6 classical theorem families in Sections 2–5 (CP-03) - receives OPFF TIER C pending bibliographic restoration.
6. Q6. "What exact revisions are required to upgrade #017 to OPFF TIER A?"
   - A6. No changes to the mathematical proof or Lean 4 kernel terms are needed: (1) restore the 16 dropped reasoning-trace references and 6 classical theorem citations at their call sites in `sections/*.tex`, (2) update lean/docs/017.md:11 to note Main.flint_hills_summable, and (3) prune the 4 unreferenced files (259 lines).



### 7.4 10-Second Reproduction (Don't Trust, Verify)

```bash
# 1. Verify the 869-module stratigraphy, Lemma 4.1 rational witnesses, 3-tier LCM constants, and citation audit
python3 -B proofs/verify_symbolic_pi017.py

# 2. Kernel-check all 75 independent Lean 4 theorems (v4.35.0, 1,646 lines, 0 sorry, 0 axiom)
lean proofs/pi_simplex_parameters_and_stratigraphy.lean
lean proofs/pi_transverse_multiplicity_and_seshadri_blowup.lean
lean proofs/pi_laurent_determinant_and_flint_hills.lean
```



### 7.5 Formal OPFF Referee Verdict Box

- Formal Verdict: OPFF TIER C (Conditional Revision Required - Genuine Mathematical Breakthrough with Trace-to-Paper Citation Drop & Technical Attribution Deficit)
- OpenAI #017 (The irrationality exponent of $\pi$ is $2$) achieves a genuine, mechanically verified resolution (Gate 1: PASS, Gate 5: PASS) of two long-standing problems in transcendence theory - $\mu(\pi) = 2$ (Theorem 1.1) and convergence of the Flint-Hills series (Corollary 1.2, Main.lean:29-32) - across 869 Lean 4 modules (94,948 lines, 0 sorry, 0 axiom).
- Because (1) 16 of 23 references (69.6%) from the 42-page reasoning trace (including 35 citations to #005 Catalan, Esnault-Viehweg 1984, and Ru-Vojta 1997) were omitted from the final references.bib and 6 classical theorem families are deployed across Sections 2–5 (1,327 lines) without call-site attribution (Gate 3: FAIL, CP-03), and (2) lean/docs/017.md:11 omits Main.flint_hills_summable while 4 unreferenced modules (259 lines), 552 unused declarations, and 20 worker namespaces (W06–W64) remain in the repository (Gate 2 & Gate 4: HOLD), the submission is assigned OPFF TIER C (Conditional Revision Required), with upgrade to OPFF TIER A recommended upon bibliographic and scope-note restoration.
