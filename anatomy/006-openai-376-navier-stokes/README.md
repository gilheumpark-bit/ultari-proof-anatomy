> **Language**: **English** | [**한국어 (`README.ko.md`)**](./README.ko.md)

# Case 006: OpenAI `#376` Universal Computation in Forced Navier–Stokes Flows

This package audits the `1,010` Lean 4 files (`142,131` lines) and `75` LaTeX files of OpenAI `#376`. All findings are verified across `45` standalone Lean 4 theorems (`v4.29.0-rc8`, `0 sorry`, `176/176` hypothesis mutations caught).

## Key Findings

1. **Core PDE Mechanisms Verified**: We verify volume-preserving affine box routing $U = \nabla\times(\chi\Psi)$ ([`BoxTransport/Flow.lean`](proofs/oai_ref/lean/OAI/Analysis/BoxTransport/Flow.lean#L114-L225)), Serrin-Grönwall $L^2$ uniqueness ([`Comparison.lean`](proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/BalancedTransport/Comparison.lean#L85-L132)), and 2+1D Gaussian scalar detection ([`MildScalar.lean`](proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/VelocityDetection/MildScalar.lean#L1-L120)).
2. **Inverse-Forcing Scope Boundary**: The 5 box/sheet challenges define the external force via the residual $f := \partial_t U + (U\cdot\nabla)U - \nu\Delta U$ with zero pressure ($p = 0$, [`BoxCoding.lean:53-66`](proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/BalancedTransport/BoxCoding.lean#L53-L66)) or use shear sheets where $(u\cdot\nabla)u = 0$ ([`SolenoidalSheetPrograms.lean:188`](proofs/oai_ref/lean/ComparatorChallenges/SolenoidalSheetPrograms.lean#L188)).
3. **Repository Packaging Audit**: The 6 challenges import `354` of `1,004` `OAI/` files, leaving `650` files (`64.7%`, including `ForcedComputation/`) unimported, while [`ForcedNavierStokesComputation.lean`](proofs/oai_ref/lean/ComparatorChallenges/ForcedNavierStokesComputation.lean#L1-L232) duplicates [`BalancedThreeStack.lean`](proofs/oai_ref/lean/ComparatorChallenges/BalancedThreeStack.lean#L1-L239).

## 4-Tier Reader Guide

| Tier | Target Audience | Document | Summary |
| :---: | :--- | :--- | :--- |
| **Tier 1** | **Beginners** | [`en/01_Beginner_Guide.md`](en/01_Beginner_Guide.md) | Plain-language comparison between autonomous fluid dynamics and inverse-forcing box routing. |
| **Tier 2** | **Intermediates** | [`en/02_Intermediate_Math_and_Code_Guide.md`](en/02_Intermediate_Math_and_Code_Guide.md) | Mapping of the 10 preprint folders, 6 challenges, and 45 Lean 4 theorems. |
| **Tier 3** | **Experts** | [`en/03_Expert_Forensic_and_Mathematical_Physics_Report.md`](en/03_Expert_Forensic_and_Mathematical_Physics_Report.md) | Mathematical-physics referee report, Leray projection leakage analysis, and 5 structural repairs. |
| **Tier 4** | **Automated Verifiers** | [`en/04_Automated_Verification_and_Parser_Spec.md`](en/04_Automated_Verification_and_Parser_Spec.md)<br>[`manifest.json`](manifest.json) | SHA-256 checksum table and 1-to-1 theorem line mapping. |

## Formal Proofs & One-Command Verification

- [`proofs/ns376_kinematic_routing_and_forensics.lean`](proofs/ns376_kinematic_routing_and_forensics.lean): Theorems 1–20 (`106/106` mutations caught).
- [`proofs/ns376_gronwall_uniqueness_and_repairs.lean`](proofs/ns376_gronwall_uniqueness_and_repairs.lean): Theorems 21–45 (`70/70` mutations caught).
- [`proofs/verify_symbolic_ns376.py`](proofs/verify_symbolic_ns376.py), [`proofs/symbolic_verification_result.json`](proofs/symbolic_verification_result.json), and [`proofs/problem_spec.md`](proofs/problem_spec.md).

```bash
lean proofs/ns376_kinematic_routing_and_forensics.lean && lean proofs/ns376_gronwall_uniqueness_and_repairs.lean && (cd proofs && python3 verify_symbolic_ns376.py)
```
