# Audit Summary: OpenAI #376 (Incompressible Box Transport and Finite Computation)

- Target (Repository / Preprint): OpenAI `openai/math` Family #376 (commit `4eaee87`; 16 `.tex` files in `build/`: `main.tex` 56 lines + 15 `\input` section files 5,808 lines = 5,864 lines; 1,004 `OAI/` + 6 `ComparatorChallenges/` = 1,010 `.lean` files) / Companion Bibliography PR: [mathcommunity/oai-math-revised#76](https://github.com/mathcommunity/oai-math-revised/pull/76)
- Verification Toolchain: Lean 4 v4.29.0-rc8 / Python 3.14 (SymPy symbolic engine & PyTorch FP64 spectral checks)
- Artifact Checksums (SHA-256): [ns376_kinematic_routing_and_forensics.lean](../proofs/ns376_kinematic_routing_and_forensics.lean) (cab492b22b85...) | [ns376_gronwall_uniqueness_and_repairs.lean](../proofs/ns376_gronwall_uniqueness_and_repairs.lean) (2f871a49e16d...) | [verify_symbolic_ns376.py](../proofs/verify_symbolic_ns376.py) (2f39eefded4b...)
- Verification Method: **45 standalone Lean 4 theorems** in `proofs/` (0 sorry, 0 axiom, **184 / 184 hypothesis mutations caught**) & deterministic Python verification script (separate 48-theorem / 150/150-mutation unimported-module reassembly lives in the companion full-reassembly package)
- 5-Gate Audit Verdict: Gate 1 (`CP-06`): FAIL · Gate 2 (`CP-04, CP-05`): FAIL · Gate 3 (`CP-03`): FAIL · Gate 4 (`CP-10, CP-11`): FAIL · Gate 5 (Modeling Scope & Value): **FAIL** (`Class A` manuscript–challenge match on $p=0, \text{advection}=0$, disqualifying 3D incompressible fluid dynamics scope; 3 auxiliary mechanisms PASS; `TIER F` maintained) $\implies$ TIER F (Spec & Scope Non-Conforming Artifact)



## 0. 8-Metric Executive Scorecard (TL;DR)

| Audit Dimension | Disclosed Scope / Claim | Measured in Repository (Lean 4 / `.tex`) | Classification / Status |
| :--- | :--- | :--- | :---: |
| 1. Code Reachability (`Class B`) | 1,004 `OAI/` modules · 6 challenge entrypoints | Active cone 35.3% (354 files) / Unreachable strata 64.7% (650 files · 73,367 lines, incl. `Solenoidal.lean` & 576 `ForcedComputation/` files) | 64.7% Unreachable (`Gate 2 / CP-04, CP-05`) |
| 2. Entrypoint Overlap (`Class B`) | 6 distinct `ComparatorChallenges/*.lean` specs | `ForcedNavierStokesComputation.lean` (232L) shares all 38 defs (`37 def + 1 inductive`) & 50 helper decls + main theorem among 51 decls with `BalancedThreeStack.lean` (239L; 7 wrapper lines differ) | Spec Overlap (`Gate 4 / CP-10`) |
| 3. Co-Generated Forced-Flow Scope (`Class A` Matched · `Gate 5 FAIL`) | Starts from rest $u(0)=0$ with disclosed $p = 0, f := f_0 + \nu f_1$ & shear sheets (`docs/376.md:1,12,14,26`; `analysis.tex:36-41, 263-267`) | `BoxCoding.lean` / `BalancedThreeStack.lean:219-230` (`p = 0, f := res_U`) and `SolenoidalSheetPrograms.lean:188` (`advection = 0`) match manuscript (`Class A`), yet remove pressure projection & nonlinear advection | **`Gate 5: FAIL`** (Modeling Scope; `Class A` Matched) |
| 4. Challenge Hygiene & `L454` `def`-Scanner Blind Spot (`Class B`) | Complete mechanical verification in `OAI/` (`0 sorry`) | `OAI/` (`TapeCodes.lean:32-33`, `MainResult.lean:11-55`) is `0 sorry`; `NavierStokesVelocity.lean` inlines 48 namespaces with `(by sorry)` in `def half` at `L454` (`Prop`-level `isDefEq` preserved; see Sec. 1.3) | Challenge Hygiene & `def`-Scanner Gap (`Gate 2 / CP-04`) |
| 5. Citation Hygiene (`Class B`) | 16 `.tex` files (`main.tex` 56L + 15 sections 5,808L) · 22 `.bib` keys | 11 / 15 technical sections (4,630 lines, 79.7%) have 0 citations; 9 / 22 (40.9%) `.bib` keys unlinked | 14 Classics Omitted (`Gate 3 / CP-03`) |
| 6. Process Provenance (`Class B`) | Reasoning traces & packaging derivation | 0 reasoning trace PDFs provided (`docs/376.md:12,14,26` discloses `p = 0` & `SolenoidalSheetPrograms.lean` scope; trace omitting `ForcedComputation/` & `Solenoidal.lean` absent) | Provenance Absent (`Gate 4 / CP-11`) |
| 7. Premise Integrity (`Class B`) | Computable viscosity $\nu > 0$ required | `VelocityDetection/MainResult.lean:51` binds `_hcomputable : ComputableReal ν` unreferenced (`RationalBox 5` supplies $\nu = x(0)$) | Unused Premise (`Gate 1 / CP-06`) |
| 8. Verified Sub-Mechanisms (`Class A` Core) | Box routing, $L^2$ uniqueness & heat positivity | `Flow.lean` (curl routing), `Comparison.lean` ($12C$ Grönwall), `MildScalar.lean` (2+1D Duhamel) verified across **45 standalone theorems (184/184 mutants)** | 45 Theorems Verified (`PASS`) |



## 1. Summary of Verified Physical & Packaging Findings

### 1.1 Bibliographic Skew & Omitted Primary Foundational Literature (`Gate 3 / CP-03`)
- Zero Citations Across 79.7% of the Technical Body: Of the 15 `\input` section files (5,808 lines; plus `main.tex` 56 lines = 5,864 lines across 16 `.tex` files) in `build/*.tex`, only 4 sections (1,178 lines, 20.3%) contain citations (`4` `\cite` commands / `5` key tokens / `4` unique keys in post-intro sections plus `9` unique keys in `introduction.tex`), while 11 technical proof sections (4,630 lines, 79.7%) contain 0 citations.
- 9 Unlinked `.bib` Keys (40.9%) & 14 Omitted Primary Classics: 9 of 22 keys in `references.bib` (`Moser1965`, `Nash1958`, `Aronson1968`, `Tao2016`, etc.) are never invoked via `\cite`, and 14 primary foundational sources (`Helmholtz 1858`, `Weyl 1940`, `Gronwall 1919`, `Krygin 1971`, `Minsky 1961/1967`, `Siegelmann-Sontag 1995`, `Pour-El-Richards 1989`) are used without attribution (restored in PR #76).

### 1.2 Co-Generated Modeling Scope (`Class A` Matched · `Gate 5: FAIL`)
- Disclosed Zero-Pressure Inverse Forcing (`docs/376.md:26`, `analysis.tex:36-41` Lemma 2.2, `BalancedThreeStack.lean:219-230`): Consistent with hydrodynamic computation literature (Cardona–Miranda–Peralta-Salas–Presas 2021–2025; Tao 2016), `#376` starts from rest $u(0)=0$, prescribes a divergence-free field $U$, sets $p = 0$, and defines $f := \partial_t U + (U\cdot\nabla)U - \nu\Delta U$, satisfying the momentum equation via `abel` ([ns376_kinematic_routing_and_forensics.lean](../proofs/ns376_kinematic_routing_and_forensics.lean#L18)).
- Disclosed Unidirectional-Shear Scope (`docs/376.md:12,14`, `SolenoidalSheetPrograms.lean:188`): Sheet challenges enforce unidirectional shear `(u · ∇)u = 0` (`advection = 0`) and explicitly exclude fixed-particle detection and solid-box reciprocal maps ([ns376_kinematic_routing_and_forensics.lean](../proofs/ns376_kinematic_routing_and_forensics.lean#L50)), while `NavierStokesVelocity.lean` decouples vertical velocity into a 2+1D passive scalar heat equation. Because manuscript and challenge specs agree (`Class A` matched scope), these are NOT `Gate 1` defects or paper–code divergence; however, co-generating both without pressure projection or nonlinear advection reduces 3D fluid dynamics to unconstrained residual inversion and linear equations, disqualifying **`Gate 5` (`FAIL`, `TIER F` maintained)**.

### 1.3 Class B Unreachable Module Strata (64.7%), Spec Overlap & Helper-`def` `sorry` Blind Spot (`Gates 2 & 4`)
- 650 / 1,004 `OAI/` Modules (64.7%, 73,367 Lines) Unreachable (`Gate 2 / CP-04, CP-05`): All 576 files in `ForcedComputation/` and non-zero pressure `PeriodicLattice/Solenoidal.lean` ($p = -\phi \neq 0$, distinguished from Euclidean $p=0$ at `analysis.tex:263-267`) are disconnected from all 6 `ComparatorChallenges/*.lean` entrypoints.
- Challenge Overlap (`Gate 4 / CP-10`) & Comparator Helper-`def` `sorry`-Scanner Blind Spot (`Gate 2 / CP-04`): `ForcedNavierStokesComputation.lean` (232L) shares all 38 definitions (`37 def + 1 inductive`) and 50 helper declarations plus main theorem among 51 declarations with `BalancedThreeStack.lean` (239L; 7 wrapper lines differ). Distinct from intentional target placeholder `main_result` (`L1232`/`L1270`), `ComparatorChallenges/NavierStokesVelocity.lean` (1,275L) inlines 48 internal namespaces and retains `(by sorry)` in helper `def half` at `L454` (`VelocityDetection.TapeCodes.half`); because `(by sorry)` is a `Prop` quotient-coherence argument and `OAI/` (`TapeCodes.lean:32-33`, `MainResult.lean:11-55`) is `0 sorry`, Lean 4 `Prop` proof irrelevance preserves `isDefEq` (never `unsound`), yet its survival in an official challenge exposes a **comparator `sorry`-scanner blind spot on helper `def` declarations**.

### 1.4 Premise Integrity (`Gate 1`) & Contribution Separation
- Unused Premise (`Gate 1 / CP-06`): `VelocityDetection/MainResult.lean:51` binds `_hcomputable : ComputableReal ν` with a leading underscore and never references it in the proof term (`RationalBox 5` supplies $\nu = x(0)$ directly), so the theorem holds equally for uncomputable $\nu$.
- Three-Part Stratum Separation: (1) Prior human mathematical physics & computability foundations (`14` unattributed classics + `9` unlinked `.bib` keys), (2) Verified auxiliary forced-flow sub-mechanisms (`Flow.lean` curl routing, `Comparison.lean` $12C$ Grönwall uniqueness, `MildScalar.lean` Gaussian heat positivity; **45 standalone theorems, 184/184 mutants** + 48 separate reassembly theorems in the companion package), and (3) `Class A` matched modeling scope (`p=0, f:=res_U` & `advection = 0` failing `Gate 5` modeling scope) separated from `Class B` internal/packaging defects (unused `_hcomputable`, 650 unimported modules, Challenge #5/#6 overlap, `NavierStokesVelocity.lean` 48-namespace inlining & helper-`def` `L454` `sorry`-scanner blind spot).



## 2. Pre-bunking Predictable Objections (FAQ)

- Q1. "If the 6 `ComparatorChallenges/*.lean` files typecheck and `OAI/` has 0 sorry, why do Gates 1, 2, and 4 fail?"
  - Fact: Under Gate 1 (`CP-06`), `VelocityDetection/MainResult.lean:51` binds `_hcomputable : ComputableReal ν` unused. Under Gate 2 (`CP-04, CP-05`) and Gate 4 (`CP-10`), 650/1,004 `OAI/` modules (incl. `Solenoidal.lean` $p=-\phi\neq 0$ and 576 `ForcedComputation/` files) are unimported by all 6 challenges, Challenge #5/#6 share 50/51 declarations (7 wrapper lines differ), and `NavierStokesVelocity.lean` inlines 48 internal namespaces with `(by sorry)` in helper `def half` at `L454` (see Sec. 1.3: `Prop`-level `isDefEq` holds with 0-sorry `OAI/`, exposing a comparator `def`-scanner gap rather than kernel unsoundness).
- Q2. "Doesn't fluid-computer literature use inverse forcing, and doesn't `docs/376.md` & `analysis.tex` disclose $p = 0$ and `advection = 0`?"
  - Fact: Yes. Cardona–Miranda–Peralta-Salas–Presas (2021–2025) and Tao (2016) study prescribed/forced fluid computation, and `docs/376.md:1,12,14,26` alongside `analysis.tex:36-41, 263-267` explicitly disclose starting from rest $u(0)=0$, $p = 0$ forcing $f_0 + \nu f_1$, `advection = 0` (`SolenoidalSheetPrograms.lean:188`), and scope limits. Because manuscript and challenge specs agree, this is NOT paper–code divergence or `Gate 1 FAIL`; however, co-generating both with zero pressure and zero nonlinear advection eliminates 3D fluid dynamics and disqualifies **`Gate 5` (`FAIL`)**, separate from the `Class B` unimported `Solenoidal.lean` disconnect.
- Q3. "Doesn't the repository include `Solenoidal.lean` and `ForcedComputation/` with non-zero pressure ($p \neq 0$)?"
  - Fact: Yes, but those 650 / 1,004 modules (64.7%, 73,367 lines) are never imported by any of the 6 challenge entrypoints (`CP-04 / CP-05`). The separate companion full-reassembly package reconnects all 650 unimported modules, restores non-zero pressure $p = -\phi \neq 0$, and compresses the screened Yukawa Green's function bound by $4.528 \times 10^7\times$.
- Q4. "Why is `_hcomputable : ComputableReal ν` at `VelocityDetection/MainResult.lean:51` a `Gate 1` defect?"
  - Fact: Although computable viscosity $\nu > 0$ appears in the theorem statement, `_hcomputable` is never referenced in the proof term (`RationalBox 5` supplies $\nu = x(0)$), so the theorem holds identically for uncomputable real $\nu$ (`CP-06`).
- Q5. "Why is Gate 3 rated FAIL when `references.bib` has 22 entries?"
  - Fact: 9 of 22 `.bib` keys (40.9%) are never cited in the text, 11 of 15 technical sections (4,630 / 5,808 lines, 79.7%) have 0 citations, and 14 primary classical theorems are used without attribution.
- Q6. "Does this audit invalidate the valid mathematical sub-mechanisms in #376?"
  - Fact: No. Our audit verifies three valid auxiliary PDE mechanisms (`Flow.lean` curl routing, `Comparison.lean` $12C$ Grönwall uniqueness, `MildScalar.lean` 2+1D Gaussian heat positivity) across **45 standalone Lean 4 theorems in `proofs/` (184/184 mutations caught)** within the disclosed `Class A` forced-flow scope.



## 3. 10-Second Terminal Reproduction (Don't Trust, Verify)

```bash
# 1) Verify the 4 SymPy identities (plus 2+1D decoupling), PyTorch FP64 3D routing / passive-scalar / Leray leakage,
#    and the bundled 6 challenges + NavierStokesVelocity.lean:454 vs TapeCodes.lean (plus stratigraphy JSON checks).
#    (Note: _hcomputable non-use, 11/15 uncited sections, and full 650-module AST traversal are verified directly
#    against openai/math commit 4eaee87 and companion bibliography PR mathcommunity/oai-math-revised#76.)
python3 proofs/verify_symbolic_ns376.py

# 2) Kernel-check all 45 independent Lean 4 kinematic, routing, Gronwall uniqueness, and repair theorems (0 sorry, 0 axiom)
lean proofs/ns376_kinematic_routing_and_forensics.lean
lean proofs/ns376_gronwall_uniqueness_and_repairs.lean
```
