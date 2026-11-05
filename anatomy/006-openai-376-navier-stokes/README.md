# OpenAI `#376` (*Universal computation in forced Navier–Stokes flows*) Mathematical Physics & Lean 4 Forensic Audit (`40` Theorems)

## 1. Executive Four-Layer Verdict
OpenAI Math corpus `#376` (`1,010` Lean 4 files totaling `142,131` lines = `6` `ComparatorChallenges/*.lean` files of `2,284` lines + `1,004` `OAI/**` files of `139,847` lines with `0 sorry`, paired with `10` LaTeX preprint folders / `75` `.tex` files of `23,477` lines) is evaluated across 4 layers:

- **`Layer 1A` (Consistency with the Papers' Explicit Forced-Flow Model): `PASS`**
  - The accompanying papers (`Incompressible-Box-Transport/introduction.tex:90-96`, `Scalar-Potentials/main.tex:452-454`) and [`lean/docs/376.md`](proofs/oai_ref/lean/docs/376.md#L1-L37) explicitly prescribe a divergence-free velocity field $U = \nabla \times (\chi \Psi)$ starting from rest ($U|_{t=0} = 0$) and define the external body force via the differential residual $f := \partial_t U + (U\cdot\nabla)U - \nu\Delta U$ with zero pressure ($p = 0$).
  - After encoding the input word $w$ during $t \in [0, 1]$, the velocity field $U(M, w, t, x) = \text{repeated}(M, t, x)$ and forcing $f = f_0 + \nu f_1$ are **time-1 periodic (`PeriodicAfterOne` at [`BalancedThreeStack.lean:214-231`](proofs/oai_ref/lean/ComparatorChallenges/BalancedThreeStack.lean#L214-L231)) and independent of the input $w$ and step index $n$** for all $t \ge 1$. State transitions are carried by the Lagrangian ODE $\dot{X}(t) = U(t, X(t))$ across periodic cycles.
- **`Layer 1B` (Autonomous Hydrodynamic Nonlinearity vs. Inverse-Forcing Kinematic Routing): `CONDITIONAL / INVERSE-FORCING`**
  - In the 5 box/sheet challenges, the Navier-Stokes momentum equation is satisfied point-by-point by defining $f := \partial_t U + (U\cdot\nabla)U - \nu\Delta U$ (`p = 0`, discharged by `abel` in [`BalancedTransport/BoxCoding.lean:53-66`](proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/BalancedTransport/BoxCoding.lean#L53-L66)) or restricting to unidirectional shear sheets where $(u\cdot\nabla)u = 0$ identically ([`SolenoidalSheetPrograms.lean:188`](proofs/oai_ref/lean/ComparatorChallenges/SolenoidalSheetPrograms.lean#L188), [`SheetFlows/Differential.lean:269`](proofs/oai_ref/lean/OAI/MathematicalPhysics/SheetFlows/Differential.lean#L269)).
  - In Challenge #3 ([`NavierStokesVelocity.lean`](proofs/oai_ref/lean/ComparatorChallenges/NavierStokesVelocity.lean#L1-L1275)), the 3D velocity field has the $x_3$-independent $2+1\text{D}$ triangular form $u = (a_1(t,x_1,x_2), a_2(t,x_1,x_2), w(t,x_1,x_2))$, reducing the vertical component to a 2D linear passive-scalar advection-diffusion equation solved via the Gaussian heat kernel ([`VelocityDetection/MildScalar.lean`](proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/VelocityDetection/MildScalar.lean#L1-L120)).
  - Scope note from [`lean/docs/376.md`](proofs/oai_ref/lean/docs/376.md#L16-L17): [`SolenoidalSheetPrograms.lean`](proofs/oai_ref/lean/ComparatorChallenges/SolenoidalSheetPrograms.lean#L1-L197) formalizes only the finite positive diagonal maps on coding sheets; the paper's fixed-particle halting detector and reciprocal maps on solid boxes are outside the formalization's scope.
- **`Layer 2` (Lean 4 Repository Architecture & Challenge Packaging Audit): Structural Issues Identified**
  1. **Duplicated Challenge Specification**: [`ForcedNavierStokesComputation.lean`](proofs/oai_ref/lean/ComparatorChallenges/ForcedNavierStokesComputation.lean#L1-L232) (`232` lines) duplicates the `38` definitions and main theorem (`balanced_three_stack_realization`) of [`BalancedThreeStack.lean`](proofs/oai_ref/lean/ComparatorChallenges/BalancedThreeStack.lean#L1-L239) (`239` lines), and both JSON files point to `OAI.MathematicalPhysics.NavierStokes.BalancedTransport.MainResult`.
  2. **`650 / 1,004` Unimported `OAI/` Modules (`64.7%`)**: Only `354` `OAI/` files (`66,480` lines) are transitively imported by the 6 challenge entrypoints, while `650` `OAI/` files (`73,367` lines)—including all `576` files (`60,321` lines) under `OAI/MathematicalPhysics/NavierStokes/ForcedComputation/`—are not imported by any comparator challenge.
  3. **Challenge-File Extraction Artifact (`NavierStokesVelocity.lean:454`)**: [`ComparatorChallenges/NavierStokesVelocity.lean`](proofs/oai_ref/lean/ComparatorChallenges/NavierStokesVelocity.lean#L453-L454) (`1,275` lines) includes `48` internal namespaces (`residualCode`, `compile`) and retains a stripped proof obligation `w.liftOn word (by sorry)` in `VelocityDetection.TapeCodes.half` at line `454` (which is proved without `sorry` in the solution module [`VelocityDetection/TapeCodes.lean:32-33`](proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/VelocityDetection/TapeCodes.lean#L32-L33)).
  4. **Redundant Viscosity Oracle Premise (`_hcomputable`)**: [`VelocityDetection/MainResult.lean:14,51`](proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/VelocityDetection/MainResult.lean#L14-L51) passes `(hν_comp : ComputableReal ν)` as `_hcomputable` (unused) because `RationalBox 5` (`NavierStokesVelocity.lean:1203`) already includes $\nu = x(0)$ as its 0-th rational box coordinate.
- **`Layer 3 & Layer 4` (Core Mathematical Mechanisms & Standalone 40-Theorem Verification): `PASS`**
  - Formalizes and verifies the 3 genuine mathematical mechanisms ($\nabla\times(\chi\Psi)$ volume-preserving affine box routing, $12C$ Serrin-Grönwall $L^2$ uniqueness, $2+1\text{D}$ Gaussian heat-kernel Duhamel positivity) and 5 structural repairs across **`40` Lean 4 theorems (`0 sorry`, `0` custom axioms, `163/163` hypothesis mutations killed)** plus `SymPy` and `PyTorch` FP64 spectral/autograd simulations.

---

## 2. Package Contents & 4-Tier Reader Guides

### English Guides (`en/`)
- [`en/01_Beginner_Guide.md`](en/01_Beginner_Guide.md): Intuitive comparison between autonomous fluid computation and inverse-forcing box routing.
- [`en/02_Intermediate_Math_and_Code_Guide.md`](en/02_Intermediate_Math_and_Code_Guide.md): Complete mapping of the `10` preprint folders and `6` comparator challenges, plus derivations of the 3 core PDE/kinematic mechanisms.
- [`en/03_Expert_Forensic_and_Mathematical_Physics_Report.md`](en/03_Expert_Forensic_and_Mathematical_Physics_Report.md): Code-level mathematical physics referee report, Leray-projection non-locality analysis (`81.87%` exterior leakage), and 5 structural repairs.
- [`en/04_Automated_Verification_and_Parser_Spec.md`](en/04_Automated_Verification_and_Parser_Spec.md): SHA-256 checksum table and 1-to-1 line mapping for all `40` Lean 4 theorems.

### Korean Guides (`ko/`)
- [`ko/01_초보자용_쉬운해설.md`](ko/01_초보자용_쉬운해설.md): 순방향 유체 동역학 계산과 역산 외력 상자 수송의 차이 및 핵심 요약.
- [`ko/02_중급자용_구조및수식가이드.md`](ko/02_중급자용_구조및수식가이드.md): 10개 프리프린트 폴더·6대 챌린지 매핑 및 3대 핵심 수리 기법 수식 유도.
- [`ko/03_전문가용_수리물리및형식증명심사보고서.md`](ko/03_전문가용_수리물리및형식증명심사보고서.md): 4계층 심사 판정, `1,010`개 파일 `import` 지층 분석, 르레 투영 비국소성 실험 및 5대 수리 규격.
- [`ko/04_자동검증및파서용_명세서.md`](ko/04_자동검증및파서용_명세서.md): SHA-256 무결성 해시 테이블 및 `40`개 Lean 4 정리 전수 매핑표.

### Formal Proofs & Verification Scripts (`proofs/`)
- [`proofs/ns376_kinematic_routing_and_forensics.lean`](proofs/ns376_kinematic_routing_and_forensics.lean): `Theorems 1–20` (`370` lines, `0 sorry`, `106/106` hypothesis mutations killed).
- [`proofs/ns376_gronwall_uniqueness_and_repairs.lean`](proofs/ns376_gronwall_uniqueness_and_repairs.lean): `Theorems 21–40` (`324` lines, `0 sorry`, `57/57` hypothesis mutations killed).
- [`proofs/verify_symbolic_ns376.py`](proofs/verify_symbolic_ns376.py): Deterministic `SymPy` + `PyTorch` FP64 spectral/autograd verifier (`434` lines).
- [`proofs/symbolic_verification_result.json`](proofs/symbolic_verification_result.json): Machine-readable verification output JSON.
- [`proofs/problem_spec.md`](proofs/problem_spec.md): Target entrypoints and symbol audit specification.
