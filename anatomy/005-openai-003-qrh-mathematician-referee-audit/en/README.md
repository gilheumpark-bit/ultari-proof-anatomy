> **Language**: **English** | [**한국어 (`README.ko.md`)**](../README.ko.md)

# Case 005: OpenAI `#003` Referee Audit & Conditional $eta 	o 1/2$ Blueprint

This package performs a number-theoretic referee audit of OpenAI `#003` (`3,233` upstream `.lean` files and `26` reference modules in [`proofs/oai_ref/`](../proofs/oai_ref/Endpoint.lean)). All results are verified across `48` standalone Lean 4 theorems and `3` `def`s (`v4.29.0-rc8`, `0 sorry`, `441/441` hypothesis mutations caught, `Category A` cleared-denominator arithmetic).

## Key Findings

1. **Three Distinct $eta$ Regimes**: We separate the 20-module global SOS saddle ($eta_{\mathrm{SOS}}(0) = rac{6843 - 7\sqrt{921}}{7578} pprox 0.874975 < rac{7}{8}$, rational witness $rac{41999}{48000}$), the local $\delta = 0$ slice ($rac{131}{150}$ and $rac{209}{240}$), and the unbundled tail floor ($rac{4103}{4896} pprox 0.8380$).
2. **Breaking the $eta = 2/3$ Pole Wall**: Using Stickelberger-Eisenstein annihilation ($k_\infty = -6 
eq 0$) and $(1 - R_p)$ cancellation, we shift the `coordR` convergence boundary from $rac{401}{600} (	o rac{2}{3})$ down to $rac{117}{200} (	o rac{7}{12})$ and $rac{301}{600} (	o rac{1}{2})$.
3. **Conditional Transfer to $eta = 1/2$**: We prove the linear transfer laws $eta(\Delta_{\mathrm{gram}})$ and show that reaching $eta = rac{1}{2}$ along the coupled `[Path A + Path B]` locus requires the conditional hybrid saving $\Delta_{\mathrm{hybrid}} = rac{14}{33}$ ([`thm_35`](../proofs/qrh_mathematician_referee_audit.lean#L454-L461), [`thm_46`](../proofs/qrh_eight_tasks_critical_upgrade.lean#L156-L171)).

## 4-Tier Reader Guide

| Tier | Target Audience | Document | Summary |
| :---: | :--- | :--- | :--- |
| **Tier 1** | **Beginners** | [`01_Beginner_Intuitive_Guide.md`](./01_Beginner_Intuitive_Guide.md) | Plain-language walkthrough of the 5 referee questions and the conditional path toward $eta = 1/2$. |
| **Tier 2** | **Intermediates** | [`02_Intermediate_Math_and_Code_Guide.md`](./02_Intermediate_Math_and_Code_Guide.md) | Step-by-step algebraic derivations and a 1-to-1 index of all 48 Lean 4 theorems. |
| **Tier 3** | **Experts** | [`03_Expert_Mathematician_Referee_Audit_Report.md`](./03_Expert_Mathematician_Referee_Audit_Report.md) | Full referee report covering the 3-tier exponent losses, Bézout-Siegel chain, and conditional transfer blueprint. |
| **Tier 4** | **Automated Verifiers** | [`04_Machine_Verification_and_Parser_Spec.md`](./04_Machine_Verification_and_Parser_Spec.md)<br>[`manifest.json`](../manifest.json) | SHA-256 checksum table, mutation testing protocol, and reproduction commands. |

## Formal Proofs & One-Command Verification

- [`qrh_mathematician_referee_audit.lean`](../proofs/qrh_mathematician_referee_audit.lean): Theorems 1–38 (`286/286` mutations caught).
- [`qrh_eight_tasks_critical_upgrade.lean`](../proofs/qrh_eight_tasks_critical_upgrade.lean): Theorems 39–46 + 3 `def`s (`155/155` mutations caught).
- [`verify_qrh_mathematician_audit.py`](../proofs/verify_qrh_mathematician_audit.py), [`symbolic_verification_result.json`](../proofs/symbolic_verification_result.json), and [`problem_spec.md`](../proofs/problem_spec.md).

```bash
lean proofs/qrh_mathematician_referee_audit.lean && lean proofs/qrh_eight_tasks_critical_upgrade.lean && (cd proofs && python3 verify_qrh_mathematician_audit.py)
```
