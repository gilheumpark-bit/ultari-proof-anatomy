# [Audit Summary] OpenAI `#376` (`PR #76`: *Incompressible Box Transport and Finite Computation*)

- **Target (`Repository / Preprint`)**: OpenAI `openai/math` Family `#376` (`15` section files in `build/*.tex` · `5,808` lines; `1,004` `OAI/` + `6` `ComparatorChallenges/` = `1,010` `.lean` files) / Submitted PR: [`mathcommunity/oai-math-revised#76`](https://github.com/mathcommunity/oai-math-revised/pull/76) (commit `7bc55b7`)
- **Verification Toolchain**: `Lean 4 v4.29.0-rc8` / `Python 3.14` (`SymPy` symbolic engine & `PyTorch FP64` spectral checks)
- **Artifact Checksums (`SHA-256`)**: [`ns376_kinematic_routing_and_forensics.lean`](../proofs/ns376_kinematic_routing_and_forensics.lean) (`854de2d59a07...`) | [`ns376_gronwall_uniqueness_and_repairs.lean`](../proofs/ns376_gronwall_uniqueness_and_repairs.lean) (`5f033b13080c...`) | [`verify_symbolic_ns376.py`](../proofs/verify_symbolic_ns376.py) (`11fc3e83bba6...`)
- **Verification Method**: **`93` independent `Lean 4` theorems** (`45` kinematic/forensic + `48` unimported-module reassembly, `0 sorry`, `0 axiom`, `310 / 310` hypothesis mutations killed) & deterministic Python verification script
- **OPFF Formal Verdict**: `Gate 1: FAIL` · `Gate 2: FAIL` · `Gate 3: FAIL` · `Gate 4: FAIL` · `Gate 5: FAIL (HOLD upon reassembly)` $\implies$ **`OPFF TIER F` (`Hard Reject / Non-Conforming Artifact`)**

---

## 0. 8-Metric Executive Scorecard (TL;DR)

| Audit Dimension | Claimed in Manuscript (`PDF` / Docs) | Measured in Repository (`Lean 4` / `.tex`) | Discrepancy / Status |
| :--- | :--- | :--- | :---: |
| **1. Code Reachability** | `1,004` `OAI/` modules · `6` challenge entrypoints | Active cone **`35.3%` (`354` files)** / Unreachable strata **`64.7%` (`650` files · `73,367` lines)** | **`64.7%` Unreachable (`CP-05`)** |
| **2. Entrypoint Integrity** | `6` distinct `ComparatorChallenges/*.lean` specs | `ForcedNavierStokesComputation.lean` clones **`38 / 38` (`100%`)** defs of `BalancedThreeStack.lean` + `48` stuffed namespaces | **Spec Cloning (`CP-10`)** |
| **3. Manuscript–Code Match** | 3D nonlinear forced Navier-Stokes universality | Fixes **`p = 0` + defines `f := res_U` by inversion (`abel` identity)** and degenerates **`advection = 0`** (`SheetProgram.lean:28`) | **Spec Degeneration (`CP-02`)** |
| **4. Unresolved Stubs** | Complete mechanical verification (`0 sorry`) | Retains **unresolved `sorry`** at `ComparatorChallenges/NavierStokesVelocity.lean:454` (`TapeCodes.half`) | **Unresolved `sorry` (`CP-01`)** |
| **5. Citation Hygiene** | `15` sections (`5,808` lines) · `22` `.bib` keys | **`11 / 15` technical sections (`4,630` lines, `79.7%`) have `0` citations**; `9 / 22` (`40.9%`) `.bib` keys unlinked | **`14` Classics Omitted (`CP-03`)** |
| **6. Process Provenance** | Autonomous reasoning trace & formalization | **`0` reasoning trace PDFs provided** — transition from non-zero pressure to `p = 0` undocumented | **Provenance Absent (`CP-07`)** |
| **7. Premise Integrity** | Computable viscosity $\nu > 0$ required | `VelocityDetection/MainResult.lean:51` binds **`_hcomputable : ComputableReal ν` unreferenced** | **Unused Premise (`CP-06`)** |
| **8. Verified Sub-Mechanisms** | Box routing, $L^2$ uniqueness & heat positivity | `Flow.lean` (curl routing), `Comparison.lean` (Grönwall), `MildScalar.lean` (Duhamel) **valid + `650` modules reassembled** | **`93` Theorems Verified (`PASS`)** |

---

## 1. Summary of Verified Physical Findings

### 1.1 Bibliographic Skew & Omitted Primary Foundational Literature (`CP-03`)
- **Zero Citations Across `79.7%` of the Technical Body**: Of the `15` section files (`5,808` lines) in `build/*.tex`, only `4` sections (`1,178` lines, `20.3%`) contain citations, while **`11` technical proof sections (`4,630` lines, `79.7%`) contain `0` citations**.
- **`9` Unlinked `.bib` Keys (`40.9%`) & `14` Omitted Primary Classics**: `9` of `22` keys in `references.bib` (`Moser1965`, `Nash1958`, `Aronson1968`, `Tao2016`, etc.) are never invoked via `\cite`, and `14` primary foundational sources (Helmholtz 1858, Weyl 1940, Gronwall 1919, Krygin 1971, Minsky 1961/1967, Siegelmann-Sontag 1995, Pour-El-Richards 1989) are deployed without attribution (restored in `PR #76`).

### 1.2 Tautological Force Inversion & Nonlinear-Term Zero Degeneration (`CP-02`)
- **Zero-Pressure (`p = 0`) Tautological Force Inversion**: `BalancedTransport/BoxCoding.lean` sets pressure `p = 0`, chooses the target velocity field $U$ first, and defines the external body force directly as $f := \partial_t U + (U\cdot\nabla)U - \nu\Delta U$, discharging the PDE via the algebraic `abel` identity `res_U - f = 0` ([ns376_kinematic_routing_and_forensics.lean](../proofs/ns376_kinematic_routing_and_forensics.lean#L18)).
- **Nonlinear-Term Zero Degeneration (`advection = 0`)**: `SheetProgram.lean:28` eliminates the nonlinear convective term via unidirectional shear sheets (`(u · ∇)u = 0`), and `NavierStokesVelocity.lean` decouples vertical velocity into a 2+1D linear passive scalar heat equation ([ns376_kinematic_routing_and_forensics.lean](../proofs/ns376_kinematic_routing_and_forensics.lean#L50)).

### 1.3 Unreachable Module Strata (`64.7%`) & Spec Duplication (`CP-05`, `CP-10`)
- **`650 / 1,004` `OAI/` Modules (`64.7%`, `73,367` Lines) Unreachable**: All `576` files in `ForcedComputation/` and the non-zero pressure module `Solenoidal.lean` are disconnected from all `6` `ComparatorChallenges/*.lean` entrypoints.
- **Challenge Cloning & Unresolved `sorry` (`CP-01`, `CP-10`)**: `ForcedNavierStokesComputation.lean` is a 100% verbatim copy of the `38` declarations in `BalancedThreeStack.lean`, and `ComparatorChallenges/NavierStokesVelocity.lean:454` (`VelocityDetection.TapeCodes.half`) retains an unresolved `sorry`.

### 1.4 Premise Integrity & Three-Tier Contribution Separation
- **Unused Premise (`CP-06`)**: `VelocityDetection/MainResult.lean:51` binds `_hcomputable : ComputableReal ν` with a leading underscore and never references it in the proof term.
- **Three-Tier Contribution Separation**: (1) Prior human mathematical physics & computability foundations **`75%`**, (2) Valid formalized auxiliary sub-mechanisms (`Flow.lean` curl routing, `Comparison.lean` Grönwall uniqueness, `MildScalar.lean` Gaussian heat positivity) **`25%`**, (3) Standalone AI breakthrough on the genuine nonlinear 3D Navier-Stokes equations **`0%`** (`p = 0` force inversion and `advection = 0` degeneration).

---

## 2. Pre-bunking Predictable Objections (FAQ)

- **Q1. "If the 6 `ComparatorChallenges/*.lean` files compile, why is `Gate 1` rated `FAIL`?"**
  - **Fact**: `ComparatorChallenges/NavierStokesVelocity.lean:454` retains an unresolved `sorry` (`CP-01`), and the active entrypoints fix `p = 0` with a posteriori force inversion `f := res_U` (`abel` identity) or degenerate nonlinear advection to `advection = 0` (`CP-02`).
- **Q2. "Isn't an external forcing term $f$ standard in forced Navier-Stokes problems?"**
  - **Fact**: Defining $f := \mathrm{PDE\_residual}(U)$ *a posteriori* after picking an arbitrary trajectory $U$ under $p = 0$ makes *every* smooth vector field $U$ an exact solution via `res_U - res_U = 0`.
- **Q3. "Doesn't the repository include `Solenoidal.lean` and `ForcedComputation/` with non-zero pressure (`p != 0`)?"**
  - **Fact**: Yes, but those `650 / 1,004` modules (`64.7%`, `73,367` lines) are never imported by any of the `6` challenge entrypoints (`CP-05`). Our audit reassembled all `650` unimported modules, restored non-zero pressure $p = -\phi \neq 0$, and compressed the screened Yukawa Green's function bound by `4.528 × 10^7`$\times$.
- **Q4. "Why is `_hcomputable : ComputableReal ν` at `VelocityDetection/MainResult.lean:51` a defect?"**
  - **Fact**: Although computable viscosity $\nu > 0$ is presented as a core hypothesis in the manuscript, `_hcomputable` is never referenced in the proof term, so the theorem holds identically for uncomputable real $\nu$ (`CP-06`).
- **Q5. "Why is `Gate 3` rated `FAIL` when `references.bib` has `22` entries?"**
  - **Fact**: `9` of `22` `.bib` keys (`40.9%`) are never cited in the text, `11` of `15` technical sections (`4,630 / 5,808` lines, `79.7%`) have `0` citations, and `14` primary classical theorems are used without attribution.
- **Q6. "Does this audit invalidate every mathematical argument in `#376`?"**
  - **Fact**: No. Our audit explicitly separates and verifies three valid sub-mechanisms — affine curl-potential box routing (`Flow.lean`), identical-force cancellation Grönwall uniqueness (`Comparison.lean`), and 2+1D Gaussian heat-kernel positivity (`MildScalar.lean`) — across `93` independent `Lean 4` theorems (`310/310` mutations killed).

---

## 3. 10-Second Terminal Reproduction (`Don't Trust, Verify`)

```bash
# 1) Verify the unresolved sorry, unreferenced _hcomputable, 650 unimported modules, and 11/15 uncited sections
python3 proofs/verify_symbolic_ns376.py

# 2) Kernel-check all 45 independent Lean 4 kinematic, routing, Grönwall uniqueness, and repair theorems (0 sorry, 0 axiom)
lake env lean proofs/ns376_kinematic_routing_and_forensics.lean
lake env lean proofs/ns376_gronwall_uniqueness_and_repairs.lean
```
