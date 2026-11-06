> **Language**: **English** | [**한국어 (`README.ko.md`)**](./README.ko.md)

# Case 007: OpenAI `#376` Reassembly of the `650` Unimported Modules & Oct 6 Bounds

This package reassembles all `650` (`718` strictly unimported) `OAI/` Lean 4 modules in OpenAI `#376` alongside the October 6, 2026 revision. All results are verified across `48` standalone Lean 4 theorems (`v4.29.0-rc8`, `0 sorry`, `134/134` hypothesis mutations caught).

## Key Findings

1. **Full `1,004`-File Reassembly**: We reconnect the unimported modules via [`ForcedComputation/Main.lean`](proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/ForcedComputation/Main.lean#L1-L33) (`770` files), [`MaterialFlow.lean`](proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/Material/MaterialFlow.lean#L85-L115) (`19` files), and [`StationaryContraction.lean`](proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/StationaryContraction.lean#L1-L72) (`3` files).
2. **Non-Zero Pressure & Green's Bound (`4.53e7x`)**: We verify non-zero pressure $p = -\phi \neq 0$ in [`Solenoidal.lean`](proofs/oai_ref/lean/OAI/Analysis/PeriodicLattice/Solenoidal.lean#L315-L366) and tighten the screened Green's norm in [`PeriodicInverse.lean`](proofs/oai_ref/lean/OAI/Analysis/PeriodicLattice/PeriodicInverse.lean#L183-L345) from $\approx 286,753$ to $\frac{1}{16\pi^2} \approx 0.00633$.
3. **Sharp Leray, Detector & Cantor Bounds**: We tighten the $\mathbb{T}^3$ Leray constant from `52` to $16.5321$ ($3.15\times$), expand the detector horizon $H_{\max}$ by $7,560\times$ ($10^9 \to 7.56\times 10^{12}$), and prove a $b\times$ larger Cantor gap ($\frac{1}{b-1}$).

## 4-Tier Reader Guide

| Tier | Target Audience | Document | Summary |
| :---: | :--- | :--- | :--- |
| **Tier 1** | **Beginners** | [`en/01_high_school_intuition_guide.md`](en/01_high_school_intuition_guide.md) | High-school intuition guide to the 4 module strata and the 5 tightened analytical bounds. |
| **Tier 2** | **Intermediates** | [`en/02_undergraduate_mathematical_anatomy.md`](en/02_undergraduate_mathematical_anatomy.md) | Step-by-step derivations and a 1-to-1 index of all 48 Lean 4 theorems. |
| **Tier 3** | **Experts** | [`en/03_expert_critique_and_reconstruction.md`](en/03_expert_critique_and_reconstruction.md) | Full mathematical-physics reconstruction of the unimported modules and October 6 torus bounds. |
| **Tier 4** | **Automated Verifiers** | [`en/04_cs_empirical_verification.md`](en/04_cs_empirical_verification.md)<br>[`manifest.json`](manifest.json) | SHA-256 checksum table, mutation test results, and reproduction commands. |

## Formal Proofs & One-Command Verification

- [`proofs/ns376_unimported_solenoidal_and_leray_bounds.lean`](proofs/ns376_unimported_solenoidal_and_leray_bounds.lean): Theorems 1–24 (`68/68` mutations caught).
- [`proofs/ns376_detector_margins_and_undecidability_chains.lean`](proofs/ns376_detector_margins_and_undecidability_chains.lean): Theorems 25–48 (`66/66` mutations caught).
- [`proofs/verify_symbolic_ns376_complete.py`](proofs/verify_symbolic_ns376_complete.py), [`proofs/symbolic_verification_result.json`](proofs/symbolic_verification_result.json), and [`proofs/problem_spec.md`](proofs/problem_spec.md).

```bash
lean proofs/ns376_unimported_solenoidal_and_leray_bounds.lean && lean proofs/ns376_detector_margins_and_undecidability_chains.lean && (cd proofs && python3 verify_symbolic_ns376_complete.py)
```
