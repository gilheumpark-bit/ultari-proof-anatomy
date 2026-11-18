# Forensic & Referee Audit Report: Full Audit of OpenAI #376 (PR #76: Incompressible Box Transport and Finite Computation)

## 0. Provenance & Cryptographic Ledger

| Item | Details |
| :--- | :--- |
| Target Paper / Preprint | Incompressible Box Transport and Finite Computation (preprints/Incompressible-Box-Transport-and-Finite-Computation-October-6-2026/, 15 section files in `build/*.tex` · 5,808 lines; 75 total .tex files across companion folders) |
| Target Code Repository & Submitted PR | openai/math Family 376 (1,010 .lean files: 1,004 in lean/OAI/ + 6 in lean/ComparatorChallenges/) / Submitted PR: [mathcommunity/oai-math-revised#76](https://github.com/mathcommunity/oai-math-revised/pull/76) (head commit 7bc55b7) |
| Companion Reasoning Logs / Patches | Reasoning trace PDFs not provided (0 files) / 6 comparator challenge entrypoints (SolenoidalSheetPrograms.lean, NavierStokesAlternating.lean, NavierStokesVelocity.lean, BalancedBoxRouting.lean, BalancedThreeStack.lean, ForcedNavierStokesComputation.lean) |
| Toolchain & Compiler | Lean 4 v4.29.0-rc8 (ultari-proof-anatomy verification archive standard) / Python 3.14 (SymPy symbolic engine & PyTorch FP64 spectral/autograd checks) |
| Verification Artifact SHA-256 | • [ns376_kinematic_routing_and_forensics.lean](../proofs/ns376_kinematic_routing_and_forensics.lean): `cab492b22b85491d1b74b32e30cdc6ace221a0af05905b4b8cb609e486c0fcdd`<br>• [ns376_gronwall_uniqueness_and_repairs.lean](../proofs/ns376_gronwall_uniqueness_and_repairs.lean): `2f871a49e16d64c582bcb2e272158d5fa1e9f35667c48647e00fc4323b0210f9`<br>• [verify_symbolic_ns376.py](../proofs/verify_symbolic_ns376.py): `2f39eefded4b2e34488d3b8fc98fdcd940b397238a7772e80d7a755ec4e7b84c` |
| Verification Method | Local kinematic/routing/forensic Lean 4 theorems 45 (0 sorry, 0 axiom, 184/184 hypothesis mutations killed in this package) + companion unimported-module reassembly theorems 48 (0 sorry, 150/150 mutations killed in the companion reassembly package) $\implies$ 93 combined independent theorems (334/334 mutations killed) |
| Governing Audit Rubric | ultari-proof-anatomy 5-Gate Audit Rubric (Open Proof Forensic Framework, OPFF) (COPE · IMU/AMS · ACM v1.1 · ICMJE/CRediT · NeurIPS, Charter DOI: [10.5281/zenodo.24241228](https://doi.org/10.5281/zenodo.24241228), Ledger v1.0.0 DOI: [10.5281/zenodo.24241229](https://doi.org/10.5281/zenodo.24241229)) |
| 5-Gate & Tier Verdict | Gate 1 (Kernel/Spec): FAIL · Gate 2 (Paper-Code): FAIL · Gate 3 (Bib/Ethics): FAIL · Gate 4 (Provenance): FAIL · Gate 5 (Math Value): FAIL (HOLD upon reassembly) $\implies$ TIER F (Hard Reject / Non-Conforming Artifact) |



### 0.1 Executive 8-Metric Scorecard

| # | Audit Dimension | Measured Metric | Standard | Status |
| :-: | :--- | :---: | :---: | :---: |
| 1 | Unreachable Module Strata (Active Cone vs. Repository) | 650 / 1,004 OAI/ modules (64.7%, 73,367 lines) unimported | 0% unreachable | FAIL (CP-05) |
| 2 | Kernel & Premise Integrity (Sorry & Unused Binders) | 1 sorry in NavierStokesVelocity.lean:454 + `_hcomputable` unused | 0 sorry, all premises used | FAIL (CP-01, CP-06) |
| 3 | Main Theorem Specification Alignment | p = 0 + f := `res_U` (abel identity) + advection = 0 degeneration | Genuine nonlinear PDE | FAIL (CP-02, CP-04) |
| 4 | Section Citation Skew (Manuscript Distribution) | 11 / 15 sections (4,630 / 5,808 lines, 79.7%) with 0 citations | Full technical attribution | FAIL (CP-03) |
| 5 | Uncited .bib Keys & Primary Literature | 9 / 22 .bib keys unlinked (40.9%) + 14 primary classics omitted | 100% linked & cited | FAIL (CP-03) |
| 6 | Namespace & Specification Duplication | 38 defs (`def` 37 + `inductive` 1) among 51 decls shared (7 wrapper lines differ) + 48 internal namespaces stuffed | Clean modular interface | FAIL (CP-10) |
| 7 | Provenance & Reasoning Trace Completeness | 0 reasoning trace PDFs provided (100% provenance absent) | Full prompt/trace log | FAIL (CP-07) |
| 8 | Verified Valid Sub-Mechanisms & Mutation Kill | 3 valid mechanisms (Flow, Comparison, MildScalar) · 45 local (184/184) + 48 companion reassembly (150/150) thms | Constructive separation | PASS (Verified) |



### 0.2 Three-Tier Traffic-Light Summary

* Standard Non-Conformance (CP-01, CP-02, CP-03, CP-05, CP-06, CP-10):
  1. Tautological Force Inversion & Nonlinear-Term Zero Degeneration (CP-02): BalancedTransport/BoxCoding.lean sets pressure p = 0 and defines the body force directly as the PDE residual of the target velocity field $f := \partial_t U + (U\cdot\nabla)U - \nu\Delta U$ (Tautological Force Inversion), discharging the equation via the algebraic abel identity `res_U - f = 0`, while SheetFlows/SheetProgram.lean:28 reduces nonlinear advection to `(u · ∇)u = 0` (`advection = 0`, Nonlinear-Term Zero Degeneration).
  2. Unresolved sorry & Unused Premise (CP-01, CP-06): ComparatorChallenges/NavierStokesVelocity.lean:454 (VelocityDetection.TapeCodes.half) retains an unresolved sorry token, and VelocityDetection/MainResult.lean:51 binds `_hcomputable : ComputableReal ν` with a leading underscore without referencing it in the proof term.
  3. Unreachable Module Strata (64.7%) & Spec Overlap (CP-05, CP-10): 650 of 1,004 OAI/ modules (64.7%, 73,367 lines), including all 576 files in ForcedComputation/ and Solenoidal.lean, are not imported by any of the 6 challenge entrypoints, and ForcedNavierStokesComputation.lean (232L) shares all 38 definitions (37 `def` + 1 `inductive`) among 51 declarations (50 helper declarations and 1 main theorem verbatim identical; 7 wrapper, docstring, and `Fintype Direction` lines differ) with BalancedThreeStack.lean (239L).
  4. Zero Citations Across 79.7% of the Technical Body & 40.9% Unlinked .bib Keys (CP-03): 11 of 15 section files (4,630 / 5,808 lines, 79.7%) contain 0 citations, and 9 of 22 entries in references.bib (40.9%) are never invoked via `\cite`.
* Provenance Deficit (CP-07):
  - 0 reasoning trace PDFs are included in the archive; while `docs/376.md:12,14,26` explicitly discloses zero pressure ($p=0$), $f_0 + \nu f_1$, and `SolenoidalSheetPrograms.lean` scope omissions, the reasoning history behind leaving the non-zero pressure Solenoidal.lean and ForcedComputation/ modules unimported from the active challenge entrypoints is undocumented.
* Verified Valid Sub-Mechanisms & Reassembly (Gate 5):
  - Three sub-mechanisms inside the repository are mathematically valid and formally verified: (1) affine curl-potential volume-preserving routing (BoxTransport/Flow.lean), (2) identical-force cancellation and Grönwall $L^2$ energy uniqueness (BalancedTransport/Comparison.lean), and (3) 2+1D Gaussian heat-kernel Duhamel positivity (VelocityDetection/MildScalar.lean). Reassembling the 650 unimported modules in the companion reassembly package restores non-zero pressure $p = -\phi \neq 0$ and compresses the screened Yukawa Green's function bound by $4.528 \times 10^7\times$, verified across 45 local Lean 4 theorems (184/184 mutations killed) + 48 companion reassembly theorems (150/150 mutations killed) = 93 combined theorems (334/334 mutations killed).



## Part 1. Bibliographic Distribution & Attribution Audit

### 1.1 Section-by-Section Citation Density Distribution (`build/*.tex`, 15 section files, 5,808 lines)

| Manuscript Segment | Files (`build/*.tex`) | Lines (%) | Citation Status & Distribution | Verdict |
| :--- | :--- | :---: | :--- | :---: |
| Cited Sections (4/15) | introduction.tex (173 lines), analysis.tex (282 lines, `\cite{Leray1934}` x1), coding-conventions.tex (211 lines, `\cite{Bennett1973}`, `\cite{Moore1990,Moore1991}` x2), persistent-history.tex (512 lines, `\cite{Bennett1973}` x1) | 1,178 (20.3%) | 13 of 22 entries in references.bib linked via `\cite` | Front-Loaded Distribution |
| Zero-Citation Technical Body (11/15) | geometry.tex, balanced.tex, compilers.tex, routing-conventions.tex, initialization.tex, observer-routing.tex, solid-routing.tex, torus-routing.tex, guarded-history.tex, clocks.tex, compact-processors.tex (11 technical proof sections) | 4,630 (79.7%) | 0 literature citations (100% uncited) | Attribution Deficit |
| Uncited .bib Entries | build/references.bib (9 of 22 keys not invoked) | 9 / 22 (40.9%) | Names authors in prose ("Moser's area correction") without `\cite`, omitting them from the compiled bibliography | Unlinked .bib Entries |

### 1.2 9 Uncited .bib Entries and 14 Uncited Primary Foundational Sources (Restored in PR #76)

1. 9 entries (9/22 = 40.9%) present in references.bib but omitted from `\cite` calls in the manuscript:
   - Moser1965 (named in introduction.tex without `\cite`), Nash1958 & Aronson1968 (initialization.tex Remark 8.9 parabolic heat-kernel bounds), EtnyreGhrist2000 (Reeb-Beltrami contact equivalence), Tao2016 (averaged Navier-Stokes blowup circuits), CardonaMirandaPeraltaSalas2022, CardonaMirandaPeraltaSalasPresas2023, CardonaMirandaPeraltaSalas2025FluidComputer, Cardona2025Advice.
2. 14 primary foundational sources invoked across the technical body (centered on the 11 zero-citation sections, 4,630 lines) without `\cite` attribution:

| Manuscript Location (File:Section) | Classical Theorem / Mechanism Used | Original Citations | Primary Literature Restored (DOI) |
| :--- | :--- | :---: | :--- |
| Section 2 (analysis.tex, Lemma 2.1 & Prop 2.4) | $L^2(\mathbb{R}^3)$ divergence-free / gradient orthogonality ($\langle w, \nabla p\rangle = 0$) and periodic Leray-Helmholtz projector $P = I - \nabla\Delta^{-1}\operatorname{div}$ | 0 | von Helmholtz (1858, 10.1515/crll.1858.55.25), Weyl (1940), Constantin-Foias (1988), Galdi (2011) |
| Section 2 (analysis.tex, Lemma 2.2) | Pointwise energy inequality $\frac{1}{2}\frac{d}{dt}\|w\|_2^2 + \nu\|\nabla w\|_2^2 \le \|\nabla U\|_{\infty,\mathrm{op}}\|w\|_2^2$ and integrating-factor uniqueness | 0 | Gronwall (1919, 10.2307/1967124) |
| Section 3.1 (geometry.tex, Lemma 3.1) | Compactly supported divergence-free vector field extension of disjoint rigid block motions | 0 | Krygin (1971, 10.1007/BF01076419) |
| Section 4 (balanced.tex, Thm 4.1) & Section 5.1 (compilers.tex, Lemma 5.1) | Two-stack / three-stack tape representation $(L,R,J)$ and local injectivity of reversible partial transition tables | 0 | Minsky (1961, 1967, 10.2307/1970290), Axelsen-Glück (2011), Morita (2017) |
| Section 6.2 (coding-conventions.tex, Lemma 6.2) | Odd-digit gapped base-$B$ Cantor stack encoding and disjoint symbol cylinder rectangles | 0 | Koiran-Cosnard-Garzon (1994), Siegelmann-Sontag (1995) |
| Section 1.2 (introduction.tex) | Effective smooth fields, rational-error mixed derivatives, and computable viscosity $\nu > 0$ | 0 | Pour-El-Richards (1989), Weihrauch (2000) |



## Part 2. Provenance Omission & Specification Duplication Audit

1. Absence of Reasoning Trace PDFs (0 files):
   - Family #376 includes 1,010 .lean files and 75 .tex files with 0 reasoning trace PDFs or initial prompt records (while `docs/376.md:12,14,26` documents the chosen zero pressure, $f_0 + \nu f_1$, and `SolenoidalSheetPrograms.lean` scope boundaries, no reasoning trace records the derivation transition from non-zero pressure to zero-pressure forcing and linearized shear-sheet formulations).
2. Challenge Cloning & Spec Stuffing (CP-10):
   - ComparatorChallenges/ForcedNavierStokesComputation.lean (232 lines) and BalancedThreeStack.lean (239 lines) share the exact same 38 definitions (37 `def` + 1 `inductive`) among 51 declarations (50 helper declarations and the main theorem `balanced_three_stack_realization` verbatim identical; 7 lines differ across namespace wrappers, docstrings, and `instance : Fintype Direction`) ([ns376_kinematic_routing_and_forensics.lean](../proofs/ns376_kinematic_routing_and_forensics.lean#L295)).
   - ComparatorChallenges/NavierStokesVelocity.lean embeds 48 internal implementation namespaces directly inside the challenge specification file (Spec Stuffing) ([ns376_kinematic_routing_and_forensics.lean](../proofs/ns376_kinematic_routing_and_forensics.lean#L319)).



## Part 3. Module Fragmentation & Unresolved sorry Audit

1. Unresolved sorry Inside a Comparator Challenge File (CP-01 Non-Conformance):
   - ComparatorChallenges/NavierStokesVelocity.lean:454 (VelocityDetection.TapeCodes.half) contains an unresolved sorry token (whereas OAI/VelocityDetection/TapeCodes.lean:32-33 contains a proof term, the challenge specification file retains an unproved sorry stub).
2. Multi-Subtree Architectural Fragmentation:
   - Disjoint subtrees (BoxTransport/, BalancedTransport/, VelocityDetection/, SheetFlows/, ForcedComputation/) coexist inside OAI/ without bridge theorems connecting them to the comparator entrypoints.



## Part 4. Stratigraphy & Reachability Audit (1,004 OAI/ Modules)

| Category | Files (%) | Lines of Code | Composition & Role |
| :--- | :---: | :---: | :--- |
| Active Proof Cone | 354 (35.3%) | 66,480 lines | Modules transitively imported by the 6 `ComparatorChallenges/*.lean` entrypoints |
| Unreachable Module Strata | 650 (64.7%) | 73,367 lines | All 576 files in ForcedComputation/ plus the non-zero pressure recovery module (Solenoidal.lean), not imported by any of the 6 challenge entrypoints |
| Total OAI/ | 1,004 (100%) | 139,847 lines (142,131 incl. 6 challenges) | 650 / 1,004 (64.7%) modules belong to unreachable module strata |



## Part 5. Paper–Artifact Divergence & Premise Integrity Audit

### 5.1 Manuscript vs. Active Code Divergence Matrix

| Discrepancy Axis | Manuscript (manuscript.pdf) Claim | Actual Repository (Lean 4) Active Code State | Classification |
| :--- | :--- | :--- | :---: |
| 1. Tautological Force Inversion & Zero Pressure ($p=0$) | Universal Turing computation by 3D incompressible forced Navier-Stokes flows | BalancedTransport/BoxCoding.lean sets pressure p = 0, selects the target velocity field $U$ first, and defines the body force $f := \partial_t U + (U\cdot\nabla)U - \nu\Delta U = f_0 + \nu f_1$ by inversion (Tautological Force Inversion), discharging the PDE via the abel identity `res_U - f = 0` ([ns376_kinematic_routing_and_forensics.lean](../proofs/ns376_kinematic_routing_and_forensics.lean#L18)) | CP-02 Tautological Force Inversion |
| 2. Nonlinear-Term Zero Degeneration (`advection = 0`) | Nonlinear 3D fluid dynamics universality | `SheetFlows/SheetProgram.lean:28` sets nonlinear advection `(u · ∇)u = 0` (`advection = 0`, Nonlinear-Term Zero Degeneration) via unidirectional shear sheets, and Challenge 3 decouples vertical velocity into a 2+1D linear passive scalar heat equation ([ns376_kinematic_routing_and_forensics.lean](../proofs/ns376_kinematic_routing_and_forensics.lean#L50)) | CP-02 Nonlinear-Term Zero Degeneration |
| 3. Disclosed Scope Boundaries (Halting Detector & Box Inverses) | Fixed-particle halting detector and solid-box reciprocal maps | Explicitly declared outside `SolenoidalSheetPrograms.lean` scope in `docs/376.md:14` | Paper–Artifact Scope Gap (CP-04) |

### 5.2 Premise & Hypothesis Integrity Audit

| Premise Audit Category | Defect Description | Location & Formal Witness |
| :--- | :--- | :--- |
| Unused Premise (CP-06) | Binds the computable-viscosity hypothesis with a leading underscore and does not reference it in the proof term | VelocityDetection/MainResult.lean:51: `_hcomputable : ComputableReal ν` unreferenced ([ns376_kinematic_routing_and_forensics.lean](../proofs/ns376_kinematic_routing_and_forensics.lean#L338)) |
| Tautological Force Inversion (CP-02) | Any trajectory $U$ satisfies the forced equation when $f$ is defined as its PDE residual | BalancedTransport/BoxCoding.lean ([ns376_kinematic_routing_and_forensics.lean](../proofs/ns376_kinematic_routing_and_forensics.lean#L34)) |
| Duplicate & Unreachable Modules (CP-05, CP-10) | 38 shared definitions (51 declarations, 7 wrapper lines differ) in ForcedNavierStokesComputation.lean and 650 (64.7%) unimported modules | [ns376_kinematic_routing_and_forensics.lean](../proofs/ns376_kinematic_routing_and_forensics.lean#L251) |



## Part 6. Constructive Verification, Valid Mechanism Separation & Repair

### 6.1 Valid Auxiliary Mathematical Mechanisms Verified

- Independently of the specification divergences above, three sub-mechanisms inside the repository are mathematically valid and formally verified:
  1. Volume-preserving box routing via affine curl potentials $U = \nabla\times(\chi\Psi)$ (BoxTransport/Flow.lean).
  2. Cancellation of identical forcing `(res_u - f) - (res_U - f) = res_u - res_U` and Grönwall $L^2$ uniqueness for $w = u - U$ (BalancedTransport/Comparison.lean, Theorems 21–26).
  3. Positivity detection of the 2+1D Gaussian heat-kernel Duhamel integral (VelocityDetection/MildScalar.lean, Theorems 27–31).

### 6.2 Independent Lean 4 Verification & Companion Reassembly of the 650 Unimported Modules (45 Local + 48 Companion = 93 Combined Theorems, 334/334 Mutations Killed)

1. Kinematic, Routing, Uniqueness & Forensic Verification (45 local theorems in `006/proofs/`, 184/184 mutations killed):
   - Formalizes the tautological force inversion identity, shear-sheet zero advection, `_hcomputable` non-reference, 1,010-file stratigraphy, and 5 repair specifications (`T33_repair1`–`T37_repair5`) across [ns376_kinematic_routing_and_forensics.lean](../proofs/ns376_kinematic_routing_and_forensics.lean) and [ns376_gronwall_uniqueness_and_repairs.lean](../proofs/ns376_gronwall_uniqueness_and_repairs.lean).
2. Full Reassembly of the 650 Unimported Modules & Constant Compression (48 theorems in companion reassembly package, 150/150 mutations killed):
   - Reconnects ForcedComputation/Main.lean (770 modules) and Solenoidal.lean to restore non-zero pressure $p = -\phi \neq 0$ under divergence-free forcing, compresses the screened Yukawa Green's function norm bound by $4.528 \times 10^7\times$ ($\frac{1}{16\pi^2}$), tightens the periodic Leray constant (52 -> 16.53), and improves the detector threshold $H_{\max}$ by $7,560\times$.



## Part 7. Standard-Bound Verdict & Formal Conclusion (Standard-Bound Verdict)

### 7.1 International Standards & COPE Non-Conformance Matrix

| Non-Conformance Category | Governing Standard | Confirmed Evidence in #376 | Verdict |
| :--- | :--- | :--- | :---: |
| Specification Divergence & Unresolved sorry (Gate 1) | IMU/AMS + Lean Kernel TCB (CP-01, CP-02, CP-06) | Zero-pressure ($p=0$) tautological force inversion (BoxCoding.lean), `advection = 0` degeneration (`SheetFlows/SheetProgram.lean:28`), unreferenced `_hcomputable` (MainResult.lean:51), unresolved sorry in NavierStokesVelocity.lean:454 | Non-Conformance |
| Unreachable Module Strata & Overlap (Gate 2) | ACM Artifact Badging v1.1 (CP-04, CP-05, CP-10) | 650 of 1,004 OAI/ modules (64.7%, 73,367 lines) unimported, 38-definition (51-declaration, 7 wrapper lines differ) challenge overlap, 48-namespace spec stuffing | Non-Conformance |
| Attribution Deficit (Gate 3) | COPE + AMS Ethical Guidelines (CP-03) | 9/22 (40.9%) .bib keys unlinked and 11/15 sections (79.7%, 4,630 lines) with 0 citations (14 foundational classics omitted) | Attribution Deficit |
| Provenance Omission (Gate 4) | ICMJE + CRediT + NeurIPS (CP-07) | 0 reasoning trace PDFs provided | Non-Conformance |
| Valid Sub-Mechanisms & Reassembly (Gate 5) | IMO / Erdős / Mathlib Standard | Active entrypoints degenerate to p = 0 force inversion / linear shear (FAIL), while 3 auxiliary mechanisms (Flow, Comparison, MildScalar) are valid and reassembling the 650 unimported modules restores non-zero pressure (HOLD) | FAIL (HOLD upon reassembly) |



### 7.2 Three-Tier Contribution Separation (0% Standalone AI Nonlinear Breakthrough vs. Valid Sub-Mechanisms vs. Automated Packaging Divergence)

| Contribution Stratum | Share | Measured Content & File Coordinates | Audit Verdict |
| :--- | :---: | :--- | :---: |
| 1. Prior Human Mathematical Physics & Computability (Classical Theory) | 75% | Leray-Helmholtz orthogonal decomposition (von Helmholtz 1858; Leray 1934), Grönwall energy inequality (Gronwall 1919), compactly supported volume-preserving extension (Krygin 1971), 2/3-stack universal machines (Minsky 1961/1967), Cantor stack encoding (Siegelmann-Sontag 1995), computable analysis (Pour-El-Richards 1989) across 14 primary classics | Prior Human Theory (0 citations in 11/15 sections) |
| 2. Valid Formalized Sub-Mechanisms (Verified Auxiliary Core) | 25% | Affine curl-potential $U = \nabla\times(\chi\Psi)$ routing (BoxTransport/Flow.lean), identical-force cancellation Grönwall uniqueness (BalancedTransport/Comparison.lean), 2+1D Gaussian heat-kernel Duhamel positivity (VelocityDetection/MildScalar.lean), and unimported Solenoidal.lean pressure recovery | Mathematically & Mechanically Valid (45 local + 48 companion reassembly theorems) |
| 3. Autonomous AI Nonlinear Fluid Dynamics Breakthrough | 0% | Active challenge entrypoints fix pressure p = 0 and define body force by residual inversion `f := res_U` (BoxCoding.lean) or degenerate nonlinear advection to `advection = 0` (`SheetFlows/SheetProgram.lean:28`), yielding 0% standalone AI breakthrough on the genuine nonlinear 3D Navier-Stokes equations | CP-02 Degeneration & 650 (64.7%) Unreachable Modules |



### 7.3 Pre-Bunking FAQ (6 Questions & Verified Answers)

1. Q1. "If the 6 `ComparatorChallenges/*.lean` files compile, why is Gate 1 rated FAIL?"
   - A1. First, ComparatorChallenges/NavierStokesVelocity.lean:454 (VelocityDetection.TapeCodes.half) retains an unresolved sorry token (CP-01). Second, BalancedTransport/BoxCoding.lean fixes pressure p = 0 and defines the external force $f := \partial_t U + (U\cdot\nabla)U - \nu\Delta U$ directly from the chosen velocity field $U$, reducing the PDE to the algebraic identity `res_U - f = 0` (abel), while `SheetFlows/SheetProgram.lean:28` degenerates the nonlinear convective term to `advection = 0` (CP-02).
2. Q2. "Isn't an external forcing term $f$ standard in the forced Navier-Stokes equations?"
   - A2. In PDE analysis, a forced Navier-Stokes problem specifies a fixed or finite-dimensional control force $f$ first and solves for the resulting flow $u$. Defining $f := \mathrm{PDE\_residual}(U)$ a posteriori for an arbitrary target trajectory $U$ with $p = 0$ turns every smooth vector field $U$ into an exact "solution" via `res_U - res_U = 0` ([ns376_kinematic_routing_and_forensics.lean](../proofs/ns376_kinematic_routing_and_forensics.lean#L34)).
3. Q3. "Doesn't the repository contain Solenoidal.lean and ForcedComputation/ with non-zero pressure (p != 0)?"
   - A3. Yes, but all 576 files in ForcedComputation/ and Solenoidal.lean - totaling 650 / 1,004 OAI/ modules (64.7%, 73,367 lines) - are never imported by any of the 6 `ComparatorChallenges/*.lean` entrypoints (Unreachable Module Strata, CP-05). Our audit's companion reassembly package reconnected all 650 unimported modules, restored non-zero pressure $p = -\phi \neq 0$, and compressed the screened Yukawa Green's function bound by $4.528 \times 10^7\times$.
4. Q4. "Why is `_hcomputable : ComputableReal ν` at VelocityDetection/MainResult.lean:51 flagged as a defect?"
   - A4. While the manuscript highlights computable viscosity $\nu > 0$ as a foundational requirement, MainResult.lean:51 binds the hypothesis with a leading underscore (`_hcomputable`) and never references it in the proof term (CP-06). Consequently, the theorem holds identically for any uncomputable real $\nu$ ([ns376_kinematic_routing_and_forensics.lean](../proofs/ns376_kinematic_routing_and_forensics.lean#L338)).
5. Q5. "Why is Gate 3 rated FAIL (Attribution Deficit) when references.bib contains 22 entries?"
   - A5. First, 9 of the 22 .bib keys (40.9%, including Moser1965, Nash1958, Aronson1968, Tao2016) are never invoked via `\cite` and are omitted from the compiled bibliography. Second, 11 of the 15 manuscript section files (4,630 / 5,808 lines, 79.7%) contain 0 citations, omitting 14 primary foundational works (Helmholtz 1858, Gronwall 1919, Krygin 1971, Minsky 1961, Siegelmann-Sontag 1995, Pour-El-Richards 1989).
6. Q6. "Does this audit invalidate every mathematical argument in #376?"
   - A6. No. Part 6 (6.1–6.2) explicitly separates and verifies three valid sub-mechanisms: (1) affine curl-potential box routing (BoxTransport/Flow.lean), (2) identical-force cancellation Grönwall $L^2$ uniqueness (BalancedTransport/Comparison.lean), and (3) 2+1D Gaussian heat-kernel Duhamel positivity (VelocityDetection/MildScalar.lean), across 45 local theorems in `proofs/` (184/184 mutations killed) + 48 companion reassembly theorems (150/150 mutations killed) = 93 combined theorems (334/334 mutations killed).



### 7.4 10-Second Reproduction (Don't Trust, Verify)

```bash
# 1. Verify the unresolved sorry, unreferenced _hcomputable, 650 unimported modules, and 11/15 uncited sections
python3 proofs/verify_symbolic_ns376.py

# 2. Kernel-check all 45 independent Lean 4 kinematic, routing, Grönwall uniqueness, and repair theorems (0 sorry, 0 axiom)
lean proofs/ns376_kinematic_routing_and_forensics.lean
lean proofs/ns376_gronwall_uniqueness_and_repairs.lean
```



### 7.5 Referee Verdict Summary

- Formal Verdict: TIER F (Hard Reject / Non-Conforming Artifact, original submission) / PR #76 Bibliographic & Forensic Audit Pending Merge
- 
- While the active repository contains valid sub-proofs for affine curl-potential box routing (BoxTransport/Flow.lean), Grönwall $L^2$ uniqueness (Comparison.lean), and 2+1D Gaussian heat-kernel positivity (MildScalar.lean), the original OpenAI #376 (Incompressible Box Transport and Finite Computation) submission is assigned TIER F (Hard Reject / Non-Conforming Artifact) under the 5-Gate Audit Rubric (`AUDIT_CHARTER`) due to: (1) nonlinear-term zero degeneration (`advection = 0`, `SheetFlows/SheetProgram.lean:28`) and zero-pressure ($p=0$) tautological force inversion (BoxCoding.lean, CP-02), (2) an unresolved sorry at NavierStokesVelocity.lean:454 and unreferenced `_hcomputable` binder at MainResult.lean:51 (CP-01, CP-06), (3) 650 / 1,004 (64.7%, 73,367 lines) unreachable module strata disconnected from the six challenge entrypoints (CP-05), and (4) 0 literature citations across 11/15 technical sections (4,630 / 5,808 lines, 79.7%) alongside 9/22 (40.9%) unlinked .bib entries (CP-03).
- 
- Submitted [PR #76](https://github.com/mathcommunity/oai-math-revised/pull/76) (mathcommunity/oai-math-revised) restores the 9 unlinked .bib keys and 14 missing primary foundational citations at their exact mathematical call sites and records the formal verification and stratigraphy audit in NOTES.md.
