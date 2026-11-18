# Forensic & Referee Audit Report: Full Audit of OpenAI #376 (Incompressible Box Transport and Finite Computation)

## 0. Provenance & Cryptographic Ledger

| Item | Details |
| :--- | :--- |
| Target Paper / Preprint | Incompressible Box Transport and Finite Computation (preprints/Incompressible-Box-Transport-and-Finite-Computation-October-6-2026/, 16 `.tex` files in `build/`: `main.tex` 56 lines + 15 `\input` section files 5,808 lines = 5,864 lines; 75 total `.tex` files across 10 companion folders) |
| Target Code Repository & Submitted PR | `openai/math` Family 376 (commit `4eaee87`; 1,010 `.lean` files: 1,004 in `lean/OAI/` + 6 in `lean/ComparatorChallenges/`) / Companion Bibliography PR: [mathcommunity/oai-math-revised#76](https://github.com/mathcommunity/oai-math-revised/pull/76) |
| Companion Reasoning Logs / Patches | Reasoning trace PDFs not provided (0 files) / 6 comparator challenge entrypoints (`SolenoidalSheetPrograms.lean`, `NavierStokesAlternating.lean`, `NavierStokesVelocity.lean`, `BalancedBoxRouting.lean`, `BalancedThreeStack.lean`, `ForcedNavierStokesComputation.lean`) |
| Toolchain & Compiler | Lean 4 v4.29.0-rc8 (verification archive standard) / Python 3.14 (SymPy symbolic engine & PyTorch FP64 spectral/autograd checks) |
| Verification Artifact SHA-256 | • [ns376_kinematic_routing_and_forensics.lean](../proofs/ns376_kinematic_routing_and_forensics.lean): `cab492b22b85491d1b74b32e30cdc6ace221a0af05905b4b8cb609e486c0fcdd`<br>• [ns376_gronwall_uniqueness_and_repairs.lean](../proofs/ns376_gronwall_uniqueness_and_repairs.lean): `2f871a49e16d64c582bcb2e272158d5fa1e9f35667c48647e00fc4323b0210f9`<br>• [verify_symbolic_ns376.py](../proofs/verify_symbolic_ns376.py): `2f39eefded4b2e34488d3b8fc98fdcd940b397238a7772e80d7a755ec4e7b84c` |
| Verification Method | **45 standalone Lean 4 theorems** (0 sorry, 0 axiom, **184/184 hypothesis mutations caught** in `proofs/`) + SymPy/PyTorch FP64 verification; full unimported-module reassembly (48 separate theorems, 150/150 mutations caught) lives in the companion full-reassembly package |
| Governing Audit Rubric | 5-Gate Audit Rubric (self-archived rubric records in this repository synthesizing COPE · IMU/AMS · ACM v1.1 · ICMJE/CRediT · NeurIPS, not external regulatory DOIs: Charter Concept DOI [10.5281/zenodo.24241228](https://doi.org/10.5281/zenodo.24241228), Ledger v1.0.0 DOI [10.5281/zenodo.24241229](https://doi.org/10.5281/zenodo.24241229)) |
| 5-Gate & Tier Verdict | Gate 1 (Premise Integrity): FAIL (`CP-06`) · Gate 2 (Packaging & Alignment): FAIL (`CP-04, CP-05, CP-10`) · Gate 3 (Bib/Ethics): FAIL (`CP-03`) · Gate 4 (Provenance): FAIL (`CP-07`) · Gate 5 (Modeling Scope & Math Value): **FAIL** (`Class A` manuscript–challenge match on $p=0, \text{advection}=0$, disqualifying 3D incompressible fluid dynamics scope; 3 auxiliary mechanisms PASS; `TIER F` maintained) $\implies$ TIER F (Non-Conforming Artifact) |



### 0.1 Executive 8-Metric Scorecard

| # | Audit Dimension | Measured Metric | Standard | Status |
| :-: | :--- | :---: | :---: | :---: |
| 1 | Unreachable Module Strata (Active Cone vs. Repository, `Class B`) | 650 / 1,004 `OAI/` modules (64.7%, 73,367 lines) unimported, incl. `Solenoidal.lean` & all 576 `ForcedComputation/` files | 0% unreachable | FAIL (CP-04, CP-05) |
| 2 | Kernel & Premise Integrity (Library `0 sorry` vs. Unused Binder, `Class B`) | `VelocityDetection/MainResult.lean:51` leaves `_hcomputable : ComputableReal ν` unused (library `TapeCodes.lean:32-33` & `MainResult.lean:11-55` are `0 sorry`) | All premises consumed | FAIL (CP-06) |
| 3 | Co-Generated Scope Reduction (`Class A` Matched · Gate 5 `FAIL`) | Forced flow from $u(0)=0$ via matched $p = 0, f := \text{res}_U$ (`analysis.tex:36-41` Lemma 2.2, `BalancedThreeStack.lean:219-230`, `docs/376.md:26`) and `advection = 0` (`SolenoidalSheetPrograms.lean:188`, `docs/376.md:12,14`) | Full 3D incompressible Eulerian/Navier–Stokes dynamics | FAIL (`Gate 5` Modeling Scope; `Class A` Matched) |
| 4 | Section Citation Skew (Manuscript Distribution) | 11 / 15 sections (4,630 / 5,808 lines, 79.7%) with 0 citations | Full technical attribution | FAIL (CP-03) |
| 5 | Uncited `.bib` Keys & Primary Literature | 9 / 22 `.bib` keys unlinked (40.9%) + 14 primary classics omitted | 100% linked & cited | FAIL (CP-03) |
| 6 | Namespace Overlap & Helper-`def` `sorry` Hygiene (`Class B`) | Challenge #5/#6 share 38 defs (`37 def + 1 inductive`) & 50 helper decls + main theorem among 51 decls (7 wrapper lines differ); `NavierStokesVelocity.lean` inlines 48 namespaces with `(by sorry)` in `def half` at `L454` (`isDefEq` via `Prop` proof irrelevance, exposing comparator `def`-scanner blind spot; distinct from `main_result` `L1232`/`L1270`) | Clean modular challenge interface | FAIL (CP-04, CP-10) |
| 7 | Provenance & Reasoning Trace Completeness | 0 reasoning trace PDFs provided (100% provenance absent) | Full prompt/trace log | FAIL (CP-07) |
| 8 | Verified Valid Sub-Mechanisms & Mutation Kill | 3 valid mechanisms (`Flow`, `Comparison`, `MildScalar`) · **45 standalone theorems (184/184 mutations caught)** | Constructive separation | PASS (Verified) |



### 0.2 Three-Tier Summary

* Class B Internal & Packaging Defects (`CP-03, CP-04, CP-05, CP-06, CP-07, CP-10`):
  1. Unused Viscosity Computability Premise (`Gate 1 / CP-06`): `VelocityDetection/MainResult.lean:51` binds `_hcomputable : ComputableReal ν` with a leading underscore without referencing it in the proof term; `RationalBox 5` (`NavierStokesVelocity.lean:1203`) supplies $\nu = x(0)$ directly, so the theorem holds for uncomputable $\nu$.
  2. Unreachable Module Strata (`64.7%`) & Challenge #5/#6 Duplication (`Gate 2 / CP-04, CP-05, CP-10`): 650 of 1,004 `OAI/` modules (64.7%, 73,367 lines), including non-zero pressure `PeriodicLattice/Solenoidal.lean` ($p = -\phi \neq 0$) and all 576 `ForcedComputation/` files, are disconnected from all 6 comparator challenge entrypoints, while `ForcedNavierStokesComputation.lean` (232L) shares all 38 definitions (`37 def + 1 inductive`) and 50 helper declarations plus main theorem `balanced_three_stack_realization` among 51 declarations with `BalancedThreeStack.lean` (239L; 7 wrapper, docstring, and `Fintype Direction` lines differ).
  3. Challenge Namespace-Inlining & Comparator Helper-`def` `sorry`-Scanner Blind Spot (`Gate 2 / CP-04, CP-10`): `ComparatorChallenges/NavierStokesVelocity.lean` (1,275L) inlines 48 internal namespaces and retains `w.liftOn word (by sorry)` in helper `def half` (`VelocityDetection.TapeCodes.half` at `L454`, distinct from intentional target placeholder `main_result` at `L1232`/`L1270`). Because `(by sorry)` occupies a `Prop` quotient-coherence argument and `OAI/` (`TapeCodes.lean:32-33`, `MainResult.lean:11-55`) is `0 sorry`, Lean 4 `Prop` proof irrelevance preserves `isDefEq` with `OAI/` (so `L454` is not kernel-unsound), yet its survival inside an official comparator challenge exposes a **comparator `sorry`-scanner blind spot on helper `def` declarations** alongside 48-namespace inlining.
  4. Zero Citations Across 79.7% of the Technical Body & 40.9% Unlinked `.bib` Keys (`Gate 3 / CP-03`): 11 of 15 section files (4,630 / 5,808 lines, 79.7%) contain 0 citations, and 9 of 22 entries in `references.bib` (40.9%) are never invoked via `\cite`.
  5. Provenance Deficit (`Gate 4 / CP-07`): 0 reasoning trace PDFs are included in the archive; while `docs/376.md:12,14,26` and `analysis.tex:36-41, 263-267` disclose the modeling boundaries, no reasoning log records how the comparator packaging omitted `ForcedComputation/` and `Solenoidal.lean`.
* Co-Generated Scope Reduction (`Class A` Disclosed; `Gate 5: FAIL`, `TIER F` Maintained):
  - Starting from rest $u(0)=0$ (`docs/376.md:1`), `#376` explicitly adopts inverse residual forcing $p=0, f := \partial_t U + (U\cdot\nabla)U - \nu\Delta U$ (`analysis.tex:36-41` Lemma 2.2, `BalancedThreeStack.lean:219-230`, `docs/376.md:26`) and unidirectional shear sheets with `advection = 0` (`SolenoidalSheetPrograms.lean:188`, `docs/376.md:12,14`) while explicitly excluding fixed-particle detection and solid-box reciprocal maps from `SolenoidalSheetPrograms.lean` (`docs/376.md:14`). Because both manuscript and challenge specs agree, this is recorded as a matched `Class A` scope (not paper–code divergence or `Gate 1` failure), building on prescribed-flow background literature (Cardona–Miranda–Peralta-Salas–Presas 2021–2025; Tao 2016). However, co-generating both the manuscript and public challenges with zero pressure ($p=0$) and zero nonlinear advection ($(u\cdot\nabla)u = 0$) reduces 3D incompressible fluid dynamics to unconstrained residual inversion and linear shear/heat equations, failing **`Gate 5` (Modeling Scope Disqualification, `TIER F`)**.
* Verified Valid Sub-Mechanisms (`Gate 5 PASS` Auxiliary Core):
  - Three internal mechanisms are mathematically valid and formally verified (`0 sorry`): (1) affine curl-potential volume-preserving routing (`BoxTransport/Flow.lean`), (2) identical-force cancellation and $12C$ Serrin-Grönwall $L^2$ energy uniqueness (`BalancedTransport/Comparison.lean`), and (3) 2+1D Gaussian heat-kernel Duhamel positivity (`VelocityDetection/MildScalar.lean`). All findings are verified across **45 standalone Lean 4 theorems (184/184 mutations caught)** in `proofs/` (the separate companion full-reassembly package verifies 48 additional theorems / 150/150 mutations restoring non-zero pressure $p = -\phi \neq 0$ and $4.528 \times 10^7\times$ Yukawa bound compression).



## Part 1. Bibliographic Distribution & Attribution Audit

### 1.1 Section-by-Section Citation Density Distribution (`build/*.tex`: `main.tex` 56 lines + 15 `\input` sections 5,808 lines = 5,864 lines)

| Manuscript Segment | Files (`build/*.tex`) | Lines (%) | `\cite` Commands vs. Expanded Keys | Verdict |
| :--- | :--- | :---: | :--- | :---: |
| Cited Sections (4/15) | `introduction.tex` (173 lines); `analysis.tex` (282 lines: 1 `\cite` command, 1 key `\cite[Section~18]{Leray1934}`); `coding-conventions.tex` (211 lines: 2 `\cite` commands `\cite{Bennett1973}` + `\cite{Moore1990,Moore1991}`, expanding to 3 keys); `persistent-history.tex` (512 lines: 1 `\cite` command, 1 key `\cite{Bennett1973}`) | 1,178 (20.3%) | Post-intro sections contain **4 `\cite` commands** (**5 key invocations**, **4 unique keys**: `Leray1934`, `Bennett1973`, `Moore1990`, `Moore1991`); `introduction.tex` supplies the remaining **9 unique keys** for a total of **13 / 22 unique `.bib` entries linked** | Front-Loaded Distribution |
| Zero-Citation Technical Body (11/15) | `geometry.tex`, `balanced.tex`, `compilers.tex`, `routing-conventions.tex`, `initialization.tex`, `observer-routing.tex`, `solid-routing.tex`, `torus-routing.tex`, `guarded-history.tex`, `clocks.tex`, `compact-processors.tex` (11 technical proof sections) | 4,630 (79.7%) | 0 `\cite` commands / 0 expanded keys (100% uncited) | Attribution Deficit |
| Uncited `.bib` Entries | `build/references.bib` (9 of 22 keys never invoked) | 9 / 22 (40.9%) | Names authors in prose ("Moser's area correction") without `\cite`, omitting 9 unique `.bib` keys from the compiled bibliography | Unlinked `.bib` Entries |

### 1.2 9 Uncited `.bib` Entries and 14 Uncited Primary Foundational Sources (Restored in PR #76)

1. 9 entries (9/22 = 40.9%) present in `references.bib` but omitted from `\cite` calls in the manuscript:
   - `Moser1965` (named in `introduction.tex` without `\cite`), `Nash1958` & `Aronson1968` (`initialization.tex` Remark 8.9 parabolic heat-kernel bounds), `EtnyreGhrist2000` (Reeb-Beltrami contact equivalence), `Tao2016` (averaged Navier-Stokes blowup circuits), `CardonaMirandaPeraltaSalas2022`, `CardonaMirandaPeraltaSalasPresas2023`, `CardonaMirandaPeraltaSalas2025FluidComputer`, `Cardona2025Advice`.
2. 14 primary foundational sources invoked across the technical body (centered on the 11 zero-citation sections, 4,630 lines) without `\cite` attribution:

| Manuscript Location (File:Section) | Classical Theorem / Mechanism Used | Original Citations | Primary Literature Restored (DOI) |
| :--- | :--- | :---: | :--- |
| Section 2 (`analysis.tex`, Lemma 2.1 & Prop 2.4) | $L^2(\mathbb{R}^3)$ divergence-free / gradient orthogonality ($\langle w, \nabla p\rangle = 0$) and periodic Leray-Helmholtz projector $P = I - \nabla\Delta^{-1}\operatorname{div}$ | 0 | von Helmholtz (1858, 10.1515/crll.1858.55.25), Weyl (1940), Constantin-Foias (1988), Galdi (2011) |
| Section 2 (`analysis.tex`, Lemma 2.2) | Pointwise energy inequality $\frac{1}{2}\frac{d}{dt}\|w\|_2^2 + \nu\|\nabla w\|_2^2 \le \|\nabla U\|_{\infty,\mathrm{op}}\|w\|_2^2$ and integrating-factor uniqueness | 0 | Gronwall (1919, 10.2307/1967124) |
| Section 3.1 (`geometry.tex`, Lemma 3.1) | Compactly supported divergence-free vector field extension of disjoint rigid block motions | 0 | Krygin (1971, 10.1007/BF01076419) |
| Section 4 (`balanced.tex`, Thm 4.1) & Section 5.1 (`compilers.tex`, Lemma 5.1) | Two-stack / three-stack tape representation $(L,R,J)$ and local injectivity of reversible partial transition tables | 0 | Minsky (1961, 1967, 10.2307/1970290), Axelsen-Glück (2011), Morita (2017) |
| Section 6.2 (`coding-conventions.tex`, Lemma 6.2) | Odd-digit gapped base-$B$ Cantor stack encoding and disjoint symbol cylinder rectangles | 0 | Koiran-Cosnard-Garzon (1994), Siegelmann-Sontag (1995) |
| Section 1.2 (`introduction.tex`) | Effective smooth fields, rational-error mixed derivatives, and computable viscosity $\nu > 0$ | 0 | Pour-El-Richards (1989), Weihrauch (2000) |



## Part 2. Provenance Omission & Specification Duplication Audit

1. Absence of Reasoning Trace PDFs (0 files):
   - Family #376 includes 1,010 `.lean` files and 75 `.tex` files with 0 reasoning trace PDFs or initial prompt records (while `docs/376.md:12,14,26` and `analysis.tex:36-41, 263-267` document the chosen zero-pressure forcing and unidirectional shear formulations, no reasoning trace records why `ForcedComputation/` and non-zero pressure `Solenoidal.lean` were omitted from the comparator challenge entrypoints).
2. Challenge Overlap & Internal Namespace Inlining (CP-10):
   - `ComparatorChallenges/ForcedNavierStokesComputation.lean` (232 lines) and `BalancedThreeStack.lean` (239 lines) share the exact same 38 definitions (37 `def` + 1 `inductive`) and 50 helper declarations plus main theorem `balanced_three_stack_realization` among 51 declarations (7 lines differ across namespace wrappers, docstrings, and `instance : Fintype Direction`) ([ns376_kinematic_routing_and_forensics.lean](../proofs/ns376_kinematic_routing_and_forensics.lean#L295)).
   - `ComparatorChallenges/NavierStokesVelocity.lean` uses internal namespace inlining by embedding 48 internal implementation namespaces directly inside the challenge file ([ns376_kinematic_routing_and_forensics.lean](../proofs/ns376_kinematic_routing_and_forensics.lean#L319)).



## Part 3. Module Fragmentation & Challenge Hygiene Audit (`Gate 2`)

1. Challenge Namespace-Inlining & Comparator Helper-`def` `sorry`-Scanner Blind Spot (`Gate 2 / CP-04, CP-10`):
   - Distinct from the intentional challenge target placeholder (`main_result`, `L1232`/`L1270`), `ComparatorChallenges/NavierStokesVelocity.lean` (1,275 lines) performs internal namespace inlining across 48 internal namespaces and retains `w.liftOn word (by sorry)` in helper `def half` (`VelocityDetection.TapeCodes.half`) at `L454`.
   - Because `(by sorry)` is a `Prop` quotient-well-definedness argument and the actual `OAI/` library ([VelocityDetection/TapeCodes.lean:32-33](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/VelocityDetection/TapeCodes.lean#L32-L33) and [VelocityDetection/MainResult.lean:11-55](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/VelocityDetection/MainResult.lean#L11-L55)) proves both with `0 sorry`, Lean 4 `Prop` proof irrelevance preserves definitional equality (`isDefEq`) with `OAI/` (so `L454` does not make the spec unsound); however, emitting an official challenge with `by sorry` inside helper `def` exposes a **comparator `sorry`-scanner blind spot on helper `def` declarations** alongside 48-namespace inlining under `Gate 2 (CP-04 / CP-10)`.
2. Multi-Subtree Architectural Fragmentation:
   - Disjoint subtrees (`BoxTransport/`, `BalancedTransport/`, `VelocityDetection/`, `SheetFlows/`, `ForcedComputation/`) coexist inside `OAI/` without bridge theorems connecting `ForcedComputation/` and `PeriodicLattice/Solenoidal.lean` to the comparator entrypoints.



## Part 4. Stratigraphy & Reachability Audit (1,004 OAI/ Modules)

### 4.1 Repository Reachability Partition (Across 1,004 OAI/ Modules)

| Category | Files (%) | Lines of Code | Composition & Role |
| :--- | :---: | :---: | :--- |
| Active Proof Cone | 354 (35.3%) | 66,480 lines | Modules transitively imported by the 6 `ComparatorChallenges/*.lean` entrypoints |
| Unreachable Module Strata | 650 (64.7%) | 73,367 lines | All 576 files in `ForcedComputation/` plus non-zero pressure `PeriodicLattice/Solenoidal.lean` ($p=-\phi\neq 0$), not imported by any of the 6 challenge entrypoints |
| Total `OAI/` | 1,004 (100%) | 139,847 lines (142,131 incl. 6 challenges) | 650 / 1,004 (64.7%) modules belong to unreachable module strata |



## Part 5. Modeling Boundary (`Class A`) vs. Internal & Packaging Defects (`Class B`)

### 5.1 Modeling Scope (`Class A` / Gate 5) vs. Active Code State

| Analysis Axis | Disclosed Manuscript & Docs Scope | Active Repository (`Lean 4`) Behavior | Audit Classification |
| :--- | :--- | :--- | :---: |
| 1. Forced-Flow Inverse Forcing ($p=0, f:=\text{res}_U$) | Explicitly starts from rest $u(0)=0$ with $p=0$, $f = f_0 + \nu f_1 = \partial_t U + (U\cdot\nabla)U - \nu\Delta U$ (`analysis.tex:36-41` Lemma 2.2, `docs/376.md:1,26`; Euclidean vs. $\mathbb{T}_L^3$ $p=-\phi$ distinguished at `analysis.tex:263-267`) | `BalancedTransport/BoxCoding.lean:53-66` & `BalancedThreeStack.lean:219-230` implement $p=0, f := \text{res}_U$ (`abel` identity) and $12C$ Serrin-Grönwall uniqueness ([ns376_kinematic_routing_and_forensics.lean](../proofs/ns376_kinematic_routing_and_forensics.lean#L18)) | `Class A` Matched · **`Gate 5: FAIL`** (eliminates pressure projection & nonlinear constraint) |
| 2. Unidirectional Shear (`advection = 0`) & Excluded Scope | Discloses zero-pressure solenoidal shear sheets and explicitly excludes fixed-particle detector & solid-box reciprocal maps (`docs/376.md:12,14`) | `SolenoidalSheetPrograms.lean:188` satisfies `(∀ t x, advection u t x = 0)` and Challenge 3 decouples vertical velocity via 2+1D passive scalar heat kernel ([ns376_kinematic_routing_and_forensics.lean](../proofs/ns376_kinematic_routing_and_forensics.lean#L50)) | `Class A` Matched · **`Gate 5: FAIL`** (linearizes Eulerian advection to zero) |
| 3. Disconnected Non-Zero Pressure & Unused Modules | `analysis.tex:164-267` develops $\mathbb{T}_L^3$ projection ($p=-\phi$) alongside `ForcedComputation/` | `650/1,004` (`64.7%`) `OAI/` modules, including `PeriodicLattice/Solenoidal.lean` and all 576 `ForcedComputation/` files, are unimported by all 6 comparator entrypoints | Class B: Unreachable Module Strata (`Gate 2 FAIL: CP-04, CP-05`) |

### 5.2 Class B Internal Premise, Overlap & Hygiene Defects (`Gate 1 & Gate 2 FAIL`)

| Defect Category | Defect Description | Location & Formal Witness |
| :--- | :--- | :--- |
| Unused Premise (`Gate 1 / CP-06`) | Binds the computable-viscosity hypothesis with a leading underscore and does not reference it in the proof term (theorem holds for uncomputable $\nu$) | `VelocityDetection/MainResult.lean:51`: `_hcomputable : ComputableReal ν` unreferenced ([ns376_kinematic_routing_and_forensics.lean](../proofs/ns376_kinematic_routing_and_forensics.lean#L338)) |
| Unreachable Modules & Overlap (`Gate 2 / CP-04, CP-05, CP-10`) | 650 (64.7%) unimported `OAI/` modules (incl. `Solenoidal.lean` & 576 `ForcedComputation/` files); Challenge #5/#6 share 38 defs & 50/51 helper decls + main theorem (7 wrapper lines differ) | `ForcedNavierStokesComputation.lean` vs `BalancedThreeStack.lean` ([ns376_kinematic_routing_and_forensics.lean](../proofs/ns376_kinematic_routing_and_forensics.lean#L251), [#L295](../proofs/ns376_kinematic_routing_and_forensics.lean#L295)) |
| Challenge Inlining & Helper-`def` `sorry` Blind Spot (`Gate 2 / CP-04, CP-10`) | Inlines 48 internal namespaces and retains `(by sorry)` in helper `def half` at `L454` (`TapeCodes.lean:32-33` & `MainResult.lean:11-55` are `0 sorry`, preserving `isDefEq` via `Prop` proof irrelevance; exposes comparator `def`-scanner blind spot, distinct from `main_result` placeholder `L1232`/`L1270`) | `ComparatorChallenges/NavierStokesVelocity.lean:454` ([ns376_kinematic_routing_and_forensics.lean](../proofs/ns376_kinematic_routing_and_forensics.lean#L319)) |



## Part 6. Constructive Verification, Valid Mechanism Separation & Repair

### 6.1 Valid Auxiliary Mathematical Mechanisms Verified

- Three sub-mechanisms inside the repository are mathematically valid and formally verified (`0 sorry`):
  1. Volume-preserving box routing via affine curl potentials $U = \nabla\times(\chi\Psi)$ (`BoxTransport/Flow.lean`).
  2. Cancellation of identical forcing `(res_u - f) - (res_U - f) = res_u - res_U` and $12C$ Serrin-Grönwall $L^2$ uniqueness for $w = u - U$ (`BalancedTransport/Comparison.lean`, Theorems 21–26).
  3. Positivity detection of the 2+1D Gaussian heat-kernel Duhamel integral (`VelocityDetection/MildScalar.lean`, Theorems 27–31).

### 6.2 Independent Lean 4 Verification & Companion Reassembly Scope (**45 Standalone Theorems in This Package**)

1. Kinematic, Routing, Uniqueness & Forensic Verification (**45 standalone theorems in `proofs/`, 184/184 mutations caught**):
   - Formalizes the disclosed inverse-forcing identity (`T01–T02`, contrasting fixed $K=16$ finite-dimensional forcing in `T33_repair1` and unforced $f=0$ rejection in `T34_repair2`), shear-sheet zero advection (`T03`), `_hcomputable` non-reference (`T18`, `T32`, `T36_repair4`), Challenge #5/#6 overlap (`T16`, `T35_repair3`), and 1,010-file stratigraphy (`T14–T15`, `T37_repair5`) across [ns376_kinematic_routing_and_forensics.lean](../proofs/ns376_kinematic_routing_and_forensics.lean) and [ns376_gronwall_uniqueness_and_repairs.lean](../proofs/ns376_gronwall_uniqueness_and_repairs.lean).
2. Companion Full-Reassembly Package (48 separate theorems, 150/150 mutations caught):
   - Reconnects `ForcedComputation/Main.lean` (770 modules) and `Solenoidal.lean` to restore non-zero pressure $p = -\phi \neq 0$ under divergence-free forcing, compresses the screened Yukawa Green's function norm bound by $4.528 \times 10^7\times$ ($\frac{1}{16\pi^2}$), tightens the periodic Leray constant ($52 \to 16.53$), and improves the detector threshold $H_{\max}$ by $7,560\times$.



## Part 7. Standard-Bound Verdict & Formal Conclusion

### 7.1 International Standards & 5-Gate Assessment Matrix

| Audit Category | Governing Standard | Confirmed Evidence in #376 | Verdict |
| :--- | :--- | :--- | :---: |
| Premise Integrity (Gate 1) | IMU/AMS + Lean Kernel (`CP-06`) | `VelocityDetection/MainResult.lean:51` leaves `_hcomputable : ComputableReal ν` unused (`RationalBox 5` supplies $\nu = x(0)$); actual `OAI/` library modules (`TapeCodes.lean:32-33`, `MainResult.lean:11-55`) are `0 sorry` | FAIL (`Class B`: `CP-06`) |
| Reachability, Overlap & Hygiene (Gate 2) | ACM Artifact Badging v1.1 (`CP-04, CP-05, CP-10`) | 650 of 1,004 `OAI/` modules (64.7%, 73,367 lines) unimported (incl. `Solenoidal.lean` & 576 `ForcedComputation/` files); Challenge #5/#6 share 50/51 decls (7 wrapper lines differ); `NavierStokesVelocity.lean` inlines 48 namespaces with `(by sorry)` in helper `def half` at `L454` (`isDefEq` preserved via `Prop` proof irrelevance, exposing comparator `def`-scanner blind spot; distinct from `main_result` `L1232`/`L1270`) | FAIL (`Class B`: `CP-04, CP-05, CP-10`) |
| Attribution Deficit (Gate 3) | COPE + AMS Ethical Guidelines (`CP-03`) | 9/22 (40.9%) `.bib` keys unlinked and 11/15 sections (79.7%, 4,630 lines) with 0 citations (14 foundational classics omitted) | FAIL (`Class B`: `CP-03`) |
| Provenance Omission (Gate 4) | ICMJE + CRediT + NeurIPS (`CP-07`) | 0 reasoning trace PDFs provided | FAIL (`Class B`: `CP-07`) |
| Modeling Scope & Sub-Mechanisms (Gate 5) | IMO / Erdős / Mathlib Standard | Co-generated $u(0)=0$ forced-flow ($p=0, f:=\text{res}_U$) & unidirectional shear (`advection = 0`) match `Class A` docs (NOT `Gate 1` or paper–code divergence) yet eliminate 3D pressure projection & nonlinear advection, failing **`Gate 5` (`FAIL`, `TIER F` maintained)**; 3 auxiliary mechanisms (`Flow`, `Comparison`, `MildScalar`) remain valid across 45 theorems (184/184 mutants) | **FAIL** (Modeling Scope; 3 Auxiliary Mechanisms PASS) |



### 7.2 Three-Tier Contribution & Scope Separation

| Contribution Stratum | Stratum Role | Measured Content & File Coordinates | Audit Verdict |
| :--- | :---: | :--- | :---: |
| 1. Prior Human Mathematical Physics & Computability | Classical Foundation | Leray-Helmholtz decomposition (von Helmholtz 1858; Weyl 1940; Leray 1934), Grönwall-Prodi-Serrin uniqueness (1919/1959/1962), compactly supported volume-preserving extension (Krygin 1971; Banyaga 1978), multi-stack machines (Minsky 1961/1967), Cantor coding (Koiran 1994; Siegelmann-Sontag 1995), computable analysis (Pour-El-Richards 1989), hydrodynamic computation (Cardona et al. 2021–2025; Tao 2016) | Prior Human Theory (0 citations in 11/15 sections; 9/22 `.bib` keys unlinked) |
| 2. Verified Formalized Sub-Mechanisms | Valid Auxiliary Core | Affine curl-potential $U = \nabla\times(\chi\Psi)$ routing (`BoxTransport/Flow.lean`), identical-force cancellation $12C$ Grönwall uniqueness (`BalancedTransport/Comparison.lean`), 2+1D Gaussian heat-kernel Duhamel positivity (`VelocityDetection/MildScalar.lean`), plus unimported `Solenoidal.lean` $p = -\phi \neq 0$ recovery | Mathematically & Mechanically Valid (**45 standalone theorems, 184/184 mutants**; 48 separate reassembly theorems in companion package) |
| 3. Co-Generated Scope (`Gate 5 FAIL`) vs. Packaging/Premise Defects (`Class B`) | Modeling Scope vs. Defects | `Class A` Matched Scope (`Gate 5 FAIL`): co-generated $u(0)=0$ ($p=0, f:=res_U$) & shear (`advection = 0`) matching `docs/376.md:1,12,14,26` & `analysis.tex:36-41` while eliminating 3D fluid dynamics. `Class B` (`Gate 1–4 FAIL`): unused `_hcomputable` (`CP-06`), 650/1,004 unimported modules (`CP-04/CP-05`), Challenge #5/#6 overlap (`CP-10`), and `NavierStokesVelocity.lean` 48-namespace inlining with `L454` helper-`def` `sorry`-scanner blind spot (`CP-04/CP-10`) | `Gate 5: FAIL` (Modeling Scope); `Class B`: Gates 1–4 FAIL |



### 7.3 Pre-Bunking FAQ (6 Questions & Verified Answers)

1. Q1. "If the 6 `ComparatorChallenges/*.lean` files typecheck and `OAI/` has 0 sorry, why do Gates 1 and 2 fail?"
   - A1. First, under Gate 1 (`CP-06`), `VelocityDetection/MainResult.lean:51` binds `_hcomputable : ComputableReal ν` with a leading underscore and never uses it, so the theorem holds equally for non-computable real viscosities $\nu$. Second, under Gate 2 (`CP-04, CP-05, CP-10`), 650 of 1,004 `OAI/` modules (including `Solenoidal.lean` with $p=-\phi\neq 0$ and all 576 `ForcedComputation/` files) are disconnected from all 6 challenges, Challenge #5 and #6 share 50/51 declarations (7 wrapper lines differ), and `NavierStokesVelocity.lean` inlines 48 internal namespaces while leaving `(by sorry)` in helper `def half` at `L454` (distinct from target placeholder `main_result` at `L1232`/`L1270`; `TapeCodes.lean:32-33` and `MainResult.lean:11-55` are `0 sorry` and preserve `isDefEq` via Lean 4 `Prop` proof irrelevance, exposing a comparator `def`-scanner blind spot rather than library kernel unsoundness).
2. Q2. "Doesn't fluid-computer literature use inverse forcing, and doesn't `docs/376.md` & `analysis.tex` disclose $p = 0$ and `advection = 0`?"
   - A2. Yes. Hydrodynamic computation literature (Cardona–Miranda–Peralta-Salas–Presas 2021–2025; Tao 2016) studies prescribed/forced embeddings, and `docs/376.md:1,12,14,26`, `analysis.tex:36-41` (Lemma 2.2), and `analysis.tex:263-267` match the comparator specs on $u(0)=0$, $p=0$ residual forcing $f = f_0 + \nu f_1$, unidirectional shear `advection = 0` (`SolenoidalSheetPrograms.lean:188`), and excluded targets. Accordingly, we do NOT classify this as manuscript–code divergence or `Gate 1 FAIL`; however, co-generating both manuscript and challenges without pressure projection or nonlinear advection disqualifies **`Gate 5` (`FAIL`)**, separate from the `Class B` unimported `Solenoidal.lean` ($p=-\phi\neq 0$) disconnect ([ns376_manufactured_force_arbitrary_trajectory_witness](../proofs/ns376_kinematic_routing_and_forensics.lean#L34); contrasted with fixed $K=16$ forcing in `T33_repair1`).
3. Q3. "Doesn't the repository contain `Solenoidal.lean` and `ForcedComputation/` with non-zero pressure ($p \neq 0$)?"
   - A3. Yes, but all 576 files in `ForcedComputation/` and `PeriodicLattice/Solenoidal.lean` (totaling 650 / 1,004 `OAI/` modules, 64.7%, 73,367 lines) are never imported by any of the 6 `ComparatorChallenges/*.lean` entrypoints (Unreachable Module Strata, `CP-04 / CP-05`). The separate companion full-reassembly package reconnects all 650 modules, restores non-zero pressure $p = -\phi \neq 0$, and compresses the screened Yukawa Green's function bound by $4.528 \times 10^7\times$.
4. Q4. "Why is `_hcomputable : ComputableReal ν` at `VelocityDetection/MainResult.lean:51` flagged under Gate 1 (`CP-06`)?"
   - A4. While the theorem signature requires `(hν_comp : ComputableReal ν)`, `MainResult.lean:51` binds the premise as `_hcomputable` and never references it in the proof term (`RationalBox 5` at `NavierStokesVelocity.lean:1203` supplies $\nu = x(0)$ directly), so the proof accepts non-computable real $\nu$ ([ns376_vacuous_computable_viscosity_premise](../proofs/ns376_kinematic_routing_and_forensics.lean#L338)).
5. Q5. "Why is Gate 3 rated FAIL (Attribution Deficit) when `references.bib` contains 22 entries?"
   - A5. First, 9 of 22 `.bib` keys (40.9%, including `Moser1965`, `Nash1958`, `Aronson1968`, `Tao2016`) are never invoked via `\cite` and are omitted from the compiled bibliography. Second, 11 of 15 manuscript section files (4,630 / 5,808 lines, 79.7%) contain 0 citations, omitting 14 primary foundational works (`Helmholtz 1858`, `Gronwall 1919`, `Krygin 1971`, `Minsky 1961`, `Siegelmann-Sontag 1995`, `Pour-El-Richards 1989`).
6. Q6. "Does this audit invalidate the mathematical results proved inside #376?"
   - A6. No. Part 6 explicitly separates and verifies three valid auxiliary PDE mechanisms (affine curl-potential box routing in `BoxTransport/Flow.lean`, identical-force cancellation $12C$ Grönwall $L^2$ uniqueness in `BalancedTransport/Comparison.lean`, and 2+1D Gaussian heat-kernel Duhamel positivity in `VelocityDetection/MildScalar.lean`) across **45 standalone Lean 4 theorems in `proofs/` (184/184 mutations caught)** within the disclosed `Class A` forced-flow modeling scope.



### 7.4 10-Second Reproduction (Don't Trust, Verify)

```bash
# 1. Verify the 4 SymPy identities (plus 2+1D decoupling), PyTorch FP64 3D routing / passive-scalar / Leray leakage,
#    and the bundled 6 challenges + NavierStokesVelocity.lean:454 vs TapeCodes.lean (plus stratigraphy JSON checks).
#    (Note: _hcomputable non-use, 11/15 uncited sections, and full 650-module AST traversal are verified directly
#    against openai/math commit 4eaee87 and companion bibliography PR mathcommunity/oai-math-revised#76.)
python3 proofs/verify_symbolic_ns376.py

# 2. Kernel-check all 45 independent Lean 4 kinematic, routing, Gronwall uniqueness, and repair theorems (0 sorry, 0 axiom)
lean proofs/ns376_kinematic_routing_and_forensics.lean
lean proofs/ns376_gronwall_uniqueness_and_repairs.lean
```



### 7.5 Referee Verdict Summary

- Formal Verdict: TIER F (Non-Conforming Artifact: `Gate 1–4` `Class B` Defects & `Gate 5` Co-Generated Modeling Scope `FAIL`; 3 Auxiliary Mechanisms `PASS`) / PR #76 Bibliographic & Forensic Audit Pending Merge
- While the `OAI/` library (`0 sorry`) contains valid formalized mechanisms for affine curl-potential box routing (`BoxTransport/Flow.lean`), $12C$ Grönwall $L^2$ uniqueness (`BalancedTransport/Comparison.lean`), and 2+1D Gaussian heat-kernel positivity (`VelocityDetection/MildScalar.lean`), the submission (`openai/math` commit `4eaee87`) is assigned TIER F due to: (1) unused `_hcomputable` binder at `MainResult.lean:51` (`Gate 1 / CP-06`), (2) `650 / 1,004` (64.7%, 73,367 lines) unimported `OAI/` modules including `Solenoidal.lean` and all 576 `ForcedComputation/` files (`Gate 2 / CP-04, CP-05`), (3) Challenge #5/#6 overlap (38 shared defs & 50/51 decls, 7 wrapper lines differ) and `NavierStokesVelocity.lean` 48-namespace inlining with `(by sorry)` in helper `def half` at `L454` (`isDefEq` preserved via `Prop` proof irrelevance, exposing comparator `def`-scanner blind spot, distinct from `main_result` placeholder `L1232`/`L1270`, `Gate 2 / CP-04, CP-10`), (4) 0 citations across 11/15 technical sections (4,630 / 5,808 lines, 79.7%), 9/22 (40.9%) unlinked `.bib` entries (`Gate 3 / CP-03`), and 0 reasoning traces (`Gate 4 / CP-07`), and (5) co-generated `Class A` matched $p=0, f:=\text{res}_U$ & `advection=0` scope eliminating 3D incompressible pressure projection & nonlinear advection (`Gate 5 FAIL`, distinct from paper–code divergence).
- Submitted [PR #76](https://github.com/mathcommunity/oai-math-revised/pull/76) restores the 9 unlinked `.bib` keys and 14 missing primary foundational citations at their exact mathematical call sites and records the formal verification and stratigraphy audit in `NOTES.md`.
