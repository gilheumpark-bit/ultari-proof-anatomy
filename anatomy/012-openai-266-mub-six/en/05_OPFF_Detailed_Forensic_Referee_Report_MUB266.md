# Forensic & Referee Audit Report: Full Audit of OpenAI #266 (Mutually Unbiased Bases in Dimension Six)

## 0. Provenance & Cryptographic Ledger

| Item | Verified Specification |
| :--- | :--- |
| Target Papers / Preprints | • Preprint 1 (N(6) = 3): The maximum number of mutually unbiased bases in dimension six (preprints/The-maximum-number-of-mutually-unbiased-bases-in-dimension-six-September-24-2026/, 12 .tex files 5,945 lines, [references_mub6.bib](../proofs/oai_ref/tex_mub/references_mub6.bib#L1-L363) 27 keys · 363 lines, 8 .cpp files 2,316 lines, [check_records.py](../proofs/oai_ref/cpp/check_records.py#L1-L373) 373 lines)<br>• Preprint 2 (N(6) <= 5 & Fourier Certificates): Exact Fourier certificates for complex Hadamard matrices of order six (preprints/Exact-Fourier-certificates-for-complex-Hadamard-matrices-of-order-six-September-24-2026/, 8 .tex files 1,997 lines, [references.bib](../proofs/oai_ref/tex_fourier/references.bib#L1-L326) 26 keys · 326 lines, [verify.py](../proofs/oai_ref/tex_fourier/verify.py#L1-L576) 576 lines) |
| Target Code Repository | openai/math Family 266 (lean/OAI/Analysis/MutuallyUnbiased/ 3,386 .lean files · 2,835,031 lines + lean/OAI/LinearAlgebra/Hadamard/ 9 files · 1,329 lines + comparator challenges [MUBSix.lean](../proofs/oai_ref/challenges/MUBSix.lean#L1-L66) 66 lines & [HadamardCubeFiber.lean](../proofs/oai_ref/challenges/HadamardCubeFiber.lean#L1-L37) 37 lines = 3,397 files · 2,836,463 lines, largest single problem family by line count in openai/math) |
| Companion Traces / Scope Doc | Reasoning trace PDFs not provided (0 files) / Scope disclosure: [266.md](../proofs/oai_ref/docs/266.md#L1-L23) (23 lines, stating that Preprint 1's N(6) = 3 result is not formalized in Lean 4) |
| Toolchain & Compiler | Lean 4 v4.29.0-rc8 (leanprover/lean4:v4.29.0-rc8) vs. audited v4.34.1 / Python 3.14 (SymPy symbolic engine) |
| Verification Artifact SHA-256 | • [mub6_hadamard_fourier_and_cubic_fibers.lean](../proofs/mub6_hadamard_fourier_and_cubic_fibers.lean): `d15df51beb425c543561b40f27bfd07a1a849267c04350a3b90d3d2c3187a270`<br>• [mub6_weiner_completion_and_gram_sos.lean](../proofs/mub6_weiner_completion_and_gram_sos.lean): `84fa18c465e5bc8884169398c79e4dc6b1282de61d44de9169bd680afc26cd58`<br>• [mub6_stratigraphy_and_binary64_audit.lean](../proofs/mub6_stratigraphy_and_binary64_audit.lean): `818cc8871bac65e8da608e98de8b3d0b015cb4fd55ed61ffdfbdac337f6bbcc8`<br>• [verify_symbolic_mub266.py](../proofs/verify_symbolic_mub266.py): `96ec2c66ba17292b922e818b12a7962568fb96fac17735ae9c678772142c0bd1` |
| Verification Method | standalone Lean 4 suite of 75 theorems + 5 defs (1,249 lines, 0 sorry, 0 axiom, 358 / 358 universal-hypothesis mutations killed = 100%, 74 / 75 structural, 14 nonlinear/inductive) + live parsing across 69 preserved upstream reference files |
| Governing Audit Rubric | ultari-proof-anatomy 5-Gate Audit Rubric (Open Proof Forensic Framework, OPFF) (COPE · IMU/AMS · ACM v1.1 · ICMJE/CRediT · NeurIPS, Charter DOI: [10.5281/zenodo.24241228](https://doi.org/10.5281/zenodo.24241228), Ledger v1.0.0 DOI: [10.5281/zenodo.24241229](https://doi.org/10.5281/zenodo.24241229)) |
| 5-Gate & Tier Verdict | Gate 1 (Kernel/Spec): PASS (Preprint 2 N(6)<=5 verified with 0 sorry) · Gate 2 (Paper-Code): FAIL (Preprint 1 N(6)=3 has 0 Lean lines, check_records.py performs 0 mathematical recomputations, Attainable 3 left unimported, Main.lean has 15/16 non-propagating imports) · Gate 3 (Bib/Ethics): FAIL (60.6% & 58.5% front-loaded citations and 5 omitted primary sources) · Gate 4 (Provenance): FAIL (0 reasoning traces, unauthenticated Sept 7 run replaced Oct 4, `enable_nanoda: false`, 62,767 unused `_h*` binders) · Gate 5 (Math Value): PASS $\implies$ TIER C (Conditional Verification & Non-Conforming Artifact) |

### 0.1 Executive 8-Metric Scorecard

| # | Audit Dimension | Surface Claim | Measured Physical Reality | Rubric Checkpoint & Verdict |
| :---: | :--- | :--- | :--- | :---: |
| 1 | Formalization Scope (N(6) = 3 vs. N(6) <= 5) | Resolves maximum MUBs in dimension six $N(6) = 3$ (#266) | Lean 4 proves $N(6) \le 5$ (Preprint 2); Preprint 1's N(6) = 3 (n = 4, 5 exclusion) has 0 lines of Lean formalization and relies on C++ binary64 search | CP-04 FAIL |
| 2 | Unrolling Inflation & Reachability | MutuallyUnbiased/ 3,386 files · 2,835,031 lines | 4,921.9x line inflation over 576-line [verify.py](../proofs/oai_ref/tex_fourier/verify.py#L1-L576); kernel reflection (Reflected Canonicalizer) saves 2,015,523 lines (71.1%) | CP-05 WARN |
| 3 | Root Entrypoint (Main.lean) & Orphans | [Main.lean](../proofs/oai_ref/lean/Main.lean#L1-L33) 16 import statements (33 lines) | 1 / 16 active (Bounds.lean) vs. 15 / 16 (93.75%, 29,683 lines) non-propagating root imports; completed Attainable 3 proof (4 files, 342 lines, 0 sorry) left unimported | CP-05 FAIL |
| 4 | Preprint 1 check_records.py Scope | Verifies 100-run C++ certificate (196 artifact files) | [check_records.py](../proofs/oai_ref/cpp/check_records.py#L2-L7) is a derived format/bounds checker performing 0 mathematical recomputations of Hadamard residuals, singular values, or clique exclusions | CP-04 · CP-07 FAIL |
| 5 | binary64 Hardware Contract & Sept 7 Run | Rigorous IEEE-754 floating-point cover exclusion | Conditionally depends on MXCSR 0x1f80, -ffp-contract=off, and manual disassembly at covrun offset 6035; [covout.cpp](../proofs/oai_ref/cpp/covout.cpp#L100-L136) omits checkcpu(); Sept 7 run unauthenticated & replaced Oct 4 | CP-07 · CP-11 FAIL |
| 6 | Premise Hygiene (`_h*` Unused Binders) | 629,541 declarations (0 sorry, 0 axiom) | 62,767 unused `_h*` hypothesis binders across generated Fubini normalization shards (54,676 in MixedSemantics, 7,685 in PairSemantics, 40 in [SmallPartitions.lean](../proofs/oai_ref/lean/SmallPartitions.lean#L77-L307)) | CP-01 · CP-06 WARN |
| 7 | Bibliographic Concentration & Omissions | Preprint 1: 33 `\cite` calls; Preprint 2: 38 \cite commands (41 key invocations) | 20/33 (60.6%) and 23/38 commands (24/41 key invocations = 58.5%) concentrated in the opening file (refinement.tex 656L & execution.tex 400L have 0 citations); 5 named primary sources omitted from .bib | CP-09 · CP-10 FAIL |
| 8 | Exact Fourier & Gram SOS Core Validity | MRW non-Tao vanishing, $(3,3)$ cubic 5-cycle, $N(6) \le 5$ | 6 Schur blocks (98 pivots > 40,000), denominator bridge 5,806,080, Weiner dimension lock $d^2-k(d-1)=d \iff k=d$ verified; confirmed by 75 standalone Lean 4 theorems (358/358 mutants killed) | Gate 1 & Gate 5 PASS |

### 0.2 Three-Tier Traffic-Light Scope Summary

- (Mathematically & Kernel-Valid Core) Preprint 2 Exact Fourier & Gram SOS Certificates for $3 \le N(6) \le 5$ (Gate 1 & Gate 5: PASS): (i) MRW non-Tao Fourier vanishing $3\langle|L_H|^2\rangle + \langle|g_H(\alpha)g_H(q)|^2\rangle = 0$ via the $8,871 \times 909$ pair-moment matrix ($\operatorname{rank} = 897$) and 26-term witness $L_H$, (ii) classification of $(3,3)$ cube fibers as a unique connected 5-cycle ($C_5$) under Newton power-sum cancellation $z^6 - e_3 z^3 + e_6$, and (iii) Weiner's $6 \to 7$ realigned Kraus superoperator completion ($d^2 - k(d-1) = d \iff k = d$) combined with the 6 $S_5$ Young Schur blocks (98 pivots > 40,000, net integer margin -2,517,408,343,748,053,647,360 < 0) validly prove $N(6) \le 5$ with 0 sorry in Lean 4 (and $3 \le N(6) \le 5$ once the orphaned 342-line Attainable 3 proof is reconnected).
- (Conditional Hardware Reliance & Unrolling Inflation): Preprint 1's exclusion of $n \in \{4, 5\}$ ($N(6) = 3$) has 0 lines of Lean 4 formalization and depends conditionally on x86-64 little-endian binary64 rounding (MXCSR 0x1f80), disabled FMA contraction (-ffp-contract=off), and manual disassembly inspection at binary offset 6035. Meanwhile, the Lean codebase unrolls Fubini sum-swap lemmas across 56,427 keys into 2,835,031 lines (4,921.9x inflation over verify.py) and introduces 62,767 unused `_h*` binders.
- (International Publication & Artifact Standard Violations): (1) Presenting [check_records.py](../proofs/oai_ref/cpp/check_records.py#L2-L7) (a derived format/bounds parser performing 0 mathematical recomputations) as the verification script for Preprint 1, (2) acknowledging in [introduction.tex:155-159](../proofs/oai_ref/tex_mub/introduction.tex#L155-L159) and [execution.tex:4, 395-400](../proofs/oai_ref/tex_mub/execution.tex#L395-L400) ([execution.tex:4](../proofs/oai_ref/tex_mub/execution.tex#L4)) that the initial September 7, 2026 run was not authenticated because its complete evidence packet was not recovered and was replaced post-hoc on October 4, 2026, (3) 15/16 (93.75%) non-propagating root imports in Main.lean and `enable_nanoda: false` across both challenges, and (4) 60.6%/58.5% front-loaded citations with 5 omitted primary classical sources result in an overall determination of TIER C.



## Part 1. Bibliographic Distribution & Attribution Audit

### 1.1 Citation Density Distribution Across Both Preprints ([thm_68_citation_concentration_both_preprints](../proofs/mub6_stratigraphy_and_binary64_audit.lean#L283-L294))

| Preprint | Opening File Citations (%) | Remaining Body/Appendix Citations (%) | Uncited (0) Technical Sections | Verdict |
| :--- | :---: | :---: | :--- | :---: |
| Preprint 1 (N(6) = 3, 5,945 lines, 33 `\cite` calls) | [introduction.tex](../proofs/oai_ref/tex_mub/introduction.tex#L1-L246) (246L): 20 / 33 (60.6%) | Remaining 11 .tex files (5,699L): 13 / 33 (39.4%) | [refinement.tex](../proofs/oai_ref/tex_mub/refinement.tex#L1-L656) (656L, 0), [execution.tex](../proofs/oai_ref/tex_mub/execution.tex#L1-L400) (400L, 0), [conclusion.tex](../proofs/oai_ref/tex_mub/conclusion.tex#L1-L11) (0) | Front Concentration (35.6 : 1) |
| Preprint 2 (N(6) <= 5, 1,997 lines, 41 key calls) | [paper.tex](../proofs/oai_ref/tex_fourier/paper.tex#L1-L278) (278L): 23 / 38 commands (24 / 41 key invocations = 58.5%) | Remaining 7 .tex files (1,719L): 17 / 41 (41.5%) | [01-preliminaries.tex](../proofs/oai_ref/tex_fourier/01-preliminaries.tex#L1-L33) (33L, 0); 02-pair-moments.tex (305L, 1), 05-verification.tex (401L, 1) | Front Concentration (8.7 : 1) |

### 1.2 5 Primary Sources Named in Prose/Code but Omitted from .bib

| Call Site (File:Line) | Named Method / Mathematical Identity | Existing Citation | Omitted Primary Source |
| :--- | :--- | :--- | :--- |
| [paper.tex:93-95](../proofs/oai_ref/tex_fourier/paper.tex#L93-L95) | Names "Fourier and Delsarte approach" and linear-programming duality bounds | Matolcsi2012 (secondary citation only) | Delsarte (1973) (Philips Res. Rep. Suppl. 10, 1–103) |
| [Superoperator.lean:1-202](../proofs/oai_ref/lean/Superoperator.lean#L1-L202) & [03-complete-family.tex:15-90](../proofs/oai_ref/tex_fourier/03-complete-family.tex#L15-L90) | Completely positive superoperators and Kraus operator-sum representation $\Phi(X) = \sum K_i X K_i^*$ | Weiner2013 only | Kraus (1971) (Ann. Physics 64, 311–335); Choi (1975) (Linear Algebra Appl. 10, 285–290) |
| [04-mixed.tex:195-265](../proofs/oai_ref/tex_fourier/04-mixed.tex#L195-L265) & [Block0.lean](../proofs/oai_ref/lean/Block0.lean#L1-L186) | $S_5$ Young symmetrizer block reduction and 98 rational Schur-complement pivots | GatermannParrilo2004 only | Young (1900) (Proc. London Math. Soc. 33, 97–146); Schur (1905, 1917) |
| [paper.tex:23-27](../proofs/oai_ref/tex_fourier/paper.tex#L23-L27) | Definition of $6 \times 6$ complex Hadamard matrices $H H^* = 6 I_6$ | Uncited (0) | Hadamard (1893) (Bull. Sci. Math. (2) 17, 240–246) |
| [03-cubic.tex:25-34](../proofs/oai_ref/tex_fourier/03-cubic.tex#L25-L34) & [Polynomials.lean](../proofs/oai_ref/hadamard/Polynomials.lean#L1-L213) | Invokes "Newton's identities" to derive $p_1 = p_2 = 0 \implies z^6 - e_3 z^3 + e_6$ | Uncited (0) | Girard (1629) (Invention nouvelle en l'algèbre); Newton (1707) (Arithmetica Universalis) |



## Part 2. Provenance & Unauthenticated Initial Run Audit

1. Absence of Reasoning Trace PDFs (0 Files):
   - Despite comprising 2,836,463 lines of Lean 4 code (#1 by line count in openai/math), Family #266 provides 0 reasoning trace PDFs or prompt logs.
2. Unauthenticated September 7, 2026 Run & Post-Hoc October 4 Replacement:
   - [introduction.tex:155-159](../proofs/oai_ref/tex_mub/introduction.tex#L155-L159) and [execution.tex:4, 395-400](../proofs/oai_ref/tex_mub/execution.tex#L395-L400) ([execution.tex:4](../proofs/oai_ref/tex_mub/execution.tex#L4)) explicitly state that the initial September 7, 2026 C++ execution underlying the draft "has not been authenticated here" because "The complete evidence packet for the execution reported on 7 September 2026 was not recovered" and was replaced post-hoc by an October 4, 2026 execution (100 native processes, 196 artifact files).



## Part 3. 2,835,031-Line Stratigraphy, Non-Propagating Root Imports & Orphaned Attainable 3 Audit

| Stratum | Files (%) | Lines (%) | Composition & Reachability |
| :--- | :---: | :---: | :--- |
| Active Proof Cone (Bounds.lean) | 3,365 / 3,386 (99.38%) | 2,804,944 / 2,835,031 (98.94%) | MixedSemantics 911 (1,729,610L) + `Gram*` 576 (377,806L) + PairSemantics 519 (343,540L) + Mixed{Sources,Targets,Merge} 1,000 (331,358L) + TaoCertificate 152 (20,762L) + core 207 |
| Non-Propagating Root Imports (Main.lean only) | 16 / 3,386 (0.47%) | 29,683 / 2,835,031 (1.05%) | 15 / 16 (93.75%, 29,650 lines) of [Main.lean](../proofs/oai_ref/lean/Main.lean#L1-L33) (33L) imports are unused chunks outside Bounds.lean ([thm_52](../proofs/mub6_stratigraphy_and_binary64_audit.lean#L36-L51)) |
| Completely Unimported Orphans (MutuallyUnbiased/) | 5 / 3,386 (0.15%) | 404 / 2,835,031 (0.01%) | Lower-bound proof Attainable 3 (4 files, 342 lines, 0 sorry: SmallMatrices, Tensor, ThreeBases, ThreeMain) + [TaoSymmetry.lean](../proofs/oai_ref/lean/TaoSymmetry.lean#L1-L62) (62L) ([thm_53](../proofs/mub6_stratigraphy_and_binary64_audit.lean#L52-L65)) |
| Auxiliary Hadamard/ Tree (9 files) | 5 active / 4 orphan | 863 active / 466 orphan | [HadamardCubeFiber.lean](../proofs/oai_ref/challenges/HadamardCubeFiber.lean#L18-L37) uses 5 files (863L), leaving 1 wrapper (117L) + 3 `Tao*` orphans (349L) ([thm_54](../proofs/mub6_stratigraphy_and_binary64_audit.lean#L66-L80)) |



## Part 4. binary64 Hardware Contract & Derived Checker (check_records.py) Audit

1. Unformalized Status of Preprint 1 (N(6) = 3) & 100-Run C++ Pipeline ([thm_60](../proofs/mub6_stratigraphy_and_binary64_audit.lean#L166-L179)–[thm_66](../proofs/mub6_stratigraphy_and_binary64_audit.lean#L251-L265)):
   - As disclosed in [266.md:10-17](../proofs/oai_ref/docs/266.md#L10-L17), Preprint 1 ($N(6) = 3$) has 0 lines of Lean 4 formalization and relies on 100 native C++ runs (1 seed + 4 Stage A + 2 Stage B + 88 initial Stage C [with 15 runs hitting binCap=2,000,000/capSteps=5,000,000 on 163 records] + 1 fallback Stage B + 4 final Stage C).
2. Zero Mathematical Recomputations in [check_records.py](../proofs/oai_ref/cpp/check_records.py#L2-L7):
   - check_records.py (373 lines) states in L2-L7 and JSON "scope" (L353) that it is a "derived checker, not the original audit". It unpacks binary record sizes (356 + 288k bytes) and checks isfinite and scalar box bounds (`|p|<=4`, n,root<1e-6), but recomputes 0 Hadamard residuals $F(P)$, 0 Jacobian singular-value perturbation radii, 0 $U(2)$ polar lattice bounds, and 0 Stage C 66-pair clique exclusions.
3. Conditional x86-64 binary64 ABI/Disassembly Contract & Missing checkcpu() in [covout.cpp](../proofs/oai_ref/cpp/covout.cpp#L100-L136) ([thm_67](../proofs/mub6_stratigraphy_and_binary64_audit.lean#L266-L282), [thm_74](../proofs/mub6_stratigraphy_and_binary64_audit.lean#L381-L391)):
   - [execution.tex:72-105](../proofs/oai_ref/tex_mub/execution.tex#L72-L105) conditions soundness on MXCSR 0x1f80, -ffp-contract=off, and manual disassembly checks at covrun offsets 6035, 6039, 603d, 608b, while [covout.cpp:100-136](../proofs/oai_ref/cpp/covout.cpp#L100-L136) omits checkcpu() (_mm_getcsr()) and calls libm pow.



## Part 5. Paper–Artifact Divergence & 62,767 Unused Premise Audit

### 5.1 Paper–Artifact Divergence Matrix

| Discrepancy Axis | Manuscript / Challenge Claim | Actual Repository (Lean 4 / C++) State | Verified Theorem & Verdict |
| :--- | :--- | :--- | :---: |
| 1. N(6) = 3 vs. N(6) <= 5 Formalization Gap | Preprint 1 headline: The maximum number of MUBs in dimension six ($N(6)=3$) | Comparator challenge [MUBSix.lean](../proofs/oai_ref/challenges/MUBSix.lean#L56-L66) proves $N(6) \le 5$ (¬Attainable 6) only; n = 4, 5 exclusion has 0 Lean lines | [thm_69](../proofs/mub6_stratigraphy_and_binary64_audit.lean#L295-L307) (CP-04 FAIL) |
| 2. Orphaned Attainable 3 Lower Bound | Two-sided MUB bound ($3 \le N(6) \le 5$) | 4 files (342 lines) proving Attainable 3 via $\mathbb{C}^2 \otimes \mathbb{C}^3$ with 0 sorry are never imported by Main.lean or MUBSix.lean | [thm_53](../proofs/mub6_stratigraphy_and_binary64_audit.lean#L52-L65) (CP-05 FAIL) |
| 3. Paper Denominator 6,480 vs. Lean Denominator 37,623,398,400 | [04-mixed.tex:280-290](../proofs/oai_ref/tex_fourier/04-mixed.tex#L280-L290): Rational sum over denominator 6,480 yielding $-\frac{2007321335237}{30} < 0$ | [Expression.lean:8-11](../proofs/oai_ref/lean/Expression.lean#L8-L11) scales by 5,806,080 (`2^10 * 3^4 * 5 * 7`) to 37,623,398,400 (-2,517,408,343,748,053,647,360 < 0), leaving contradiction_of_residual in [Algebra.lean:131](../proofs/oai_ref/lean/Algebra.lean#L131-L139) uncalled | [thm_43](../proofs/mub6_weiner_completion_and_gram_sos.lean#L284-L299)–[thm_47](../proofs/mub6_weiner_completion_and_gram_sos.lean#L351-L363) |
| 4. Disabled External Checker (nanoda) | Independent comparator verification ([MUBSix.json](../proofs/oai_ref/challenges/MUBSix.json#L1-L14), [HadamardCubeFiber.json](../proofs/oai_ref/challenges/HadamardCubeFiber.json#L1-L14)) | Both JSON configurations set "enable_nanoda": false | [thm_70](../proofs/mub6_stratigraphy_and_binary64_audit.lean#L308-L322) (CP-11 FAIL) |

### 5.2 Census of 62,767 Unused `_h*` Premises in the Active Cone ([thm_25](../proofs/mub6_hadamard_fourier_and_cubic_fibers.lean#L419-L427), [thm_56](../proofs/mub6_stratigraphy_and_binary64_audit.lean#L96-L108))

- Generated Fubini Normalization Shards (62,727): 48,742 unused (_hB : IsMUBFamily B) + 5,934 auxiliary `_h*` in MixedSemantics + 7,685 unused (_hH : IsHadamard H) in PairSemantics + 107 in PairTargets + 259 in MixedSources = 62,727.
- Handwritten Moment File [SmallPartitions.lean:77-307](../proofs/oai_ref/lean/SmallPartitions.lean#L77-L307) (40): 4 redundant equality binders in arity-3 (pattern3_0..3) + 36 (`8*3 + 6*2`) in arity-4 (pattern4_0..13) = 40 (repaired in thm_22–thm_24).



## Part 6. Active Core Certification (Gate 5: PASS), 2,015,523-Line Reflection Compression & Weiner Rigidity

### 6.1 Certification of Preprint 2's Exact Fourier & Gram SOS Core (Gate 1 & Gate 5: PASS)

1. MRW Non-Tao Fourier Vanishing & Cubic 5-Cycle Classification (Theorems 1–25):
   - Certifies $3\langle|L_H|^2\rangle + \langle|g_H(\alpha)g_H(q)|^2\rangle = 0$ via the $8,871 \times 909$ pair-moment system ($\operatorname{rank} = 897$) and 26-term witness $L_H$, and proves that $(3,3)$ zero-sum cube fibers form a unique connected 5-cycle ($C_5$).
2. Weiner $6 \to 7$ Kraus Completion & 6-Block Schur Positivstellensatz (Theorems 26–50):
   - Proves that 6 MUBs force a 7th via the $6$-dimensional superoperator fixed-point algebra (Attainable 6 -> Attainable 7) and refutes Attainable 7 via 6 $S_5$ Young blocks (98 Schur pivots > 40,000, Block0 minor 35,303,779,555,791 > 0) and 46,041 mixed-moment equations (2,425-leaf tree), establishing $N(6) \le 5$.

### 6.2 Constructive Repairs: Kernel Reflection (2,015,523 Lines Saved) & Weiner Rigidity Wall

1. Kernel Reflection (Reflected Canonicalizer) Saving 2,015,523 Lines (71.1%) ([thm_58](../proofs/mub6_stratigraphy_and_binary64_audit.lean#L122-L143), [thm_59](../proofs/mub6_stratigraphy_and_binary64_audit.lean#L145-L165)):
   - Replacing 2,073,150 lines of unrolled Fubini permutation proofs across 56,427 keys with a 1,200-line reflective invariance theorem and 1 decide line per key (57,627 lines) saves 2,073,150 - 57,627 = 2,015,523 lines (71.1%) and eliminates 56,534 unused binders.
2. Weiner Superoperator Dimension Lock ($d^2 - k(d-1) = d \iff k = d$) ([thm_31](../proofs/mub6_weiner_completion_and_gram_sos.lean#L91-L108), [thm_49](../proofs/mub6_weiner_completion_and_gram_sos.lean#L398-L404), [thm_50](../proofs/mub6_weiner_completion_and_gram_sos.lean#L407-L414)):
   - Proves that orthogonal complement dimension $d^2 - k(d-1)$ matches maximal abelian subalgebra dimension $d$ iff $(d-k)(d-1) = 0 \iff k = d$, and constructs an explicit $k = 5$ counter-model (11 > 6 complement dimension) showing why superoperator completion alone cannot prove $N(6) \le 4$.



## Part 7. Standard-Bound Verdict, Three-Tier Attribution & Formal Conclusion

### 7.1 International Standards Non-Conformance Matrix (COPE · IMU/AMS · ACM v1.1 · ICMJE/CRediT · NeurIPS)

| Standard Category | Governing Criterion | Confirmed Coordinates & Metrics in (#266) | Verdict |
| :--- | :--- | :--- | :---: |
| Paper–Artifact Divergence (Gate 2) | Alignment between headline paper claims, formal proofs, and verification scripts (ACM Artifact Review v1.1) | • Preprint 1's $N(6)=3$ claim (n=4,5 exclusion) has 0 lines of Lean 4 formalization<br>• [check_records.py](../proofs/oai_ref/cpp/check_records.py#L2-L7) performs 0 mathematical recomputations, Main.lean has 15/16 (93.75%) non-propagating imports, and Attainable 3 (342L) is left unimported | Paper–Artifact Divergence (Gate 2: FAIL) |
| Provenance & Execution Authentication (Gate 4) | Pre-authenticated computational runs, active external checkers, and premise hygiene (IMU/AMS · NeurIPS Guidelines) | • 0 reasoning traces, unauthenticated Sept 7 run replaced post-hoc on Oct 4 (introduction.tex:158)<br>• [covout.cpp](../proofs/oai_ref/cpp/covout.cpp#L100-L136) omits checkcpu(), both challenges set "enable_nanoda": false, and 62,767 `_h*` binders are unused | Non-Conformance (Gate 4: FAIL) |
| Attribution Deficit (Gate 3) | Primary-source attribution in technical sections (COPE · AMS Ethical Guidelines) | • 60.6% (20/33) and 58.5% (24/41) citations concentrated in the opening file (refinement.tex 656L & execution.tex 400L have 0 citations)<br>• 5 named primary pillars (Delsarte 1973, Kraus 1971, Choi 1975, Young 1900 / Schur 1905, 1917, Hadamard 1893, Girard 1629 / Newton 1707) omitted from .bib | Attribution Deficit (Gate 3: FAIL) |

### 7.2 Three-Tier Attribution Analysis: Human Quantum-Information Foundations & External Solvers vs. Valid CAP Core vs. Automated Unrolling Pipeline

1. 0% Standalone AI Generation Possibility: Dependence on Human Theory and External SDP / Linear-Algebra Solvers (verify.py & C++):
   - Both preprints rest on ① human-established mathematical frameworks (Matolcsi-Ruzsa-Weiner (MRW) Fourier moment identities, Weiner 2013 Kraus superoperator completion, Gatermann-Parrilo 2004 symmetry-adapted SDP, Rump 2011 verified singular-value bounds) and ② external Python/CRT row-reduction solvers ([verify.py:132-441](../proofs/oai_ref/tex_fourier/verify.py#L132-L441) modulo $10^9+7$) plus 100 native C++ branch-and-bound processes.
   - Because the 2,804,944 active Lean lines serialize rational pivot/weight tables precomputed by the external Python solver into 3,224 .lean files checked via decide +kernel, the probability that this proof was produced by standalone language-model reasoning without human quantum-information theory and external CAS/C++ solvers is 0%.
2. Substantive Achievement of the Valid Computer-Assisted Proof (CAP) Core (Gate 1 & Gate 5: PASS):
   - Preprint 2 and MutuallyUnbiased/Results/Bounds.lean deliver a complete, kernel-verified (0 sorry) computer-assisted proof of MRW non-Tao Fourier vanishing, $(3,3)$ cubic 5-cycle classification, and $N(6) \le 5$ via 6 $S_5$ Young Schur blocks (98 pivots > 40,000) and Weiner's superoperator completion.
3. Structural Divergences Introduced by the Automated Unrolling & Packaging Pipeline:
   - Unrolling 56,427 Fubini sum-swap keys into 2,835,031 lines (4,921.9x inflation over verify.py) with 62,767 unused `_h*` binders, leaving Attainable 3 (342 lines) unimported alongside 15/16 non-propagating root imports in Main.lean, and pairing an unformalized C++ binary64 search (0 Lean lines, 0 mathematical recomputations in check_records.py) with a formal proof repository reflect automated code-generation and packaging divergences.

### 7.3 Pre-bunking FAQ (6 Anticipated Questions & Fact-Based Responses)

- Q1. "Didn't OpenAI formally prove $N(6) = 3$ in Lean 4 in Family #266?"
  - A1. No. As disclosed in [266.md:10-17](../proofs/oai_ref/docs/266.md#L10-L17), Preprint 1's $N(6) = 3$ claim (n = 4, 5 exclusion) has 0 lines of Lean 4 formalization. Lean 4 proves only Preprint 2's upper bound $N(6) \le 5$ (¬Attainable 6) and the cubic Hadamard fiber theorems ([thm_69](../proofs/mub6_stratigraphy_and_binary64_audit.lean#L295-L307)).
- Q2. "Doesn't check_records.py independently verify the C++ computer-assisted proof of $N(6) = 3$?"
  - A2. [check_records.py:2-7, 353](../proofs/oai_ref/cpp/check_records.py#L2-L7) explicitly states that it is a "derived checker, not the original audit". It checks binary record sizes (356 + 288k bytes) and scalar box bounds, but performs 0 mathematical recomputations of Hadamard residuals, Jacobian singular values, polar lattice exclusions, or 66-pair clique exclusions. Moreover, the initial Sept 7 run was unauthenticated and replaced post-hoc on Oct 4.
- Q3. "Doesn't 2.835M lines of Lean 4 code reflect deep formal reasoning?"
  - A3. 2,073,150 lines (73.1%) consist of unrolled 35–45-line Fubini sum-swap proofs repeated across 56,427 keys. Replacing unrolling with a single reflective invariance theorem (Reflected Canonicalizer) saves 2,015,523 lines (71.1%) ([thm_58](../proofs/mub6_stratigraphy_and_binary64_audit.lean#L122-L143)), and [verify.py](../proofs/oai_ref/tex_fourier/verify.py#L1-L576) executes the entire exact rational verification in 576 lines (4,921.9x inflation, [thm_57](../proofs/mub6_stratigraphy_and_binary64_audit.lean#L109-L121)).
- Q4. "Why can't Weiner's superoperator completion be iterated to deduce ¬Attainable 5 or ¬Attainable 4?"
  - A4. Our rigidity theorem ([thm_31](../proofs/mub6_weiner_completion_and_gram_sos.lean#L91-L108), [thm_49](../proofs/mub6_weiner_completion_and_gram_sos.lean#L398-L404), [thm_50](../proofs/mub6_weiner_completion_and_gram_sos.lean#L407-L414)) proves that the orthogonal complement dimension $d^2 - k(d-1)$ equals the maximal abelian subalgebra dimension $d$ iff $(d-k)(d-1) = 0 \iff k = d$. At $d=6, k=5$, the complement has dimension 11 > 6, admitting non-commuting fixed points (thm_50).
- Q5. "Do the 62,767 unused `_h*` binders invalidate the $N(6) \le 5$ theorem?"
  - A5. No. Finite-sum reindexing holds over arbitrary complex arrays without needing IsMUBFamily or IsHadamard; the generator attached unused _hB/_hH binders to every shard lemma, and the 40 redundant equality hypotheses in [SmallPartitions.lean](../proofs/oai_ref/lean/SmallPartitions.lean#L77-L307) are repaired in [thm_22](../proofs/mub6_hadamard_fourier_and_cubic_fibers.lean#L389-L397)–[thm_24](../proofs/mub6_hadamard_fourier_and_cubic_fibers.lean#L408-L418).
- Q6. "Is the lower bound $N(6) \ge 3$ (Attainable 3) missing from the repository?"
  - A6. It is proved with 0 sorry across 4 files (342 lines: SmallMatrices.lean, Tensor.lean, ThreeBases.lean, ThreeMain.lean), but was left unimported by both Main.lean and MUBSix.lean ([thm_53](../proofs/mub6_stratigraphy_and_binary64_audit.lean#L52-L65)).

### 7.4 10-Second Terminal Reproduction

```bash
# Verify all 75 standalone Lean 4 theorems (0 sorry, 0 axiom, 358/358 mutants killed) & SymPy checks
lean proofs/mub6_hadamard_fourier_and_cubic_fibers.lean && \
lean proofs/mub6_weiner_completion_and_gram_sos.lean && \
lean proofs/mub6_stratigraphy_and_binary64_audit.lean && \
python3 proofs/verify_symbolic_mub266.py
```

### 7.5 Referee Verdict Summary

- Formal Verdict: TIER C (Conditional Verification & Non-Conforming Artifact): Preprint 2 ($N(6) \le 5$) Formal Core Certified / Major Revision Required for Unformalized Preprint 1 ($N(6) = 3$) binary64 Claims & 2.835M-Line Repository Packaging
- Within OpenAI #266 (Mutually Unbiased Bases in Dimension Six), Preprint 2 and MutuallyUnbiased/Results/Bounds.lean validly prove MRW non-Tao Fourier vanishing, $(3,3)$ cubic 5-cycle classification, and $N(6) \le 5$ in the Lean 4 kernel (0 sorry) via Weiner's $6 \to 7$ Kraus completion and 6 $S_5$ Young Schur blocks (98 pivots > 40,000), satisfying Gate 1 & Gate 5: PASS. However, the overall submission is assigned TIER C (Conditional Verification & Non-Conforming Artifact) due to: (1) 0 lines of Lean 4 formalization for Preprint 1's headline $N(6) = 3$ claim (n = 4, 5 exclusion), 0 mathematical recomputations in check_records.py, and post-hoc Oct 4 replacement of an unauthenticated Sept 7 run (CP-04, CP-07, CP-11), (2) 15 / 16 (93.75%, 29,683 lines) non-propagating root imports in Main.lean, unimported abandonment of the completed 342-line Attainable 3 proof, 62,767 unused `_h*` binders, and 4,921.9x unrolling inflation (CP-05, CP-06), and (3) 60.6%/58.5% opening-file citation concentration alongside 5 omitted primary classical sources (CP-09, CP-10).
