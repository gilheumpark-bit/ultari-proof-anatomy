> **Language**: **English** | [**한국어 (`README.ko.md`)**](./README.ko.md)

# Case 002: OpenAI `#032` Retracted K3 Hodge Conjecture Forensics

This package dissects the three retracted K3 Hodge Conjecture preprints in OpenAI `#032` (commit `adc7f12`) alongside `[EEMS13]`. All findings are verified across `27` standalone Lean 4 theorems (`v4.29.0-rc8`, `0 sorry`, `135/135` hypothesis mutations caught).

## Key Findings

1. **Symplectic Double-Bind**: Using the reverse trace $G_2$ leaves intersection sum $-2m 
eq 0$, while switching to the forward trace $G_1$ creates a degree-$2$ point that breaks Floer curvature vanishing ($m_0 = 0$).
2. **`[EEMS13]` Boundary Sign Error**: We locate an omitted odd-dimensional Poincaré-Hopf boundary sign $(-1)^{\dim U} = -1$ on $D^{2k-1}$ in `min-intersectYETI-final.tex:410, 694`.
3. **Part I Rescue vs. Part II Barriers**: We verify that the `Part I` Clifford reduction (`4-7-10` degree split) is sound, while proving rank and dimension obstructions across 7 `Part II` repair paths.

## 4-Tier Reader Guide

| Tier | Target Audience | Document | Summary |
| :---: | :--- | :--- | :--- |
| **Tier 1** | **Beginners** | [`01_Beginner_Guide.md`](./en/01_Beginner_Guide.md) | Equation-light overview of the Hodge Conjecture, the double-bind trap, and the rescued `Part I` reduction. |
| **Tier 2** | **Intermediates** | [`02_Intermediate_Math_and_Code_Guide.md`](./en/02_Intermediate_Math_and_Code_Guide.md) | Algebraic equations for Problems 1–5 and a 1-to-1 index of all 35 Lean 4 theorems. |
| **Tier 3** | **Experts** | [`03_Expert_Mathematical_and_Formal_Report.md`](./en/03_Expert_Mathematical_and_Formal_Report.md) | Technical report on the `[EEMS13]` sign error, Shioda-Inose obstructions, and hyperkähler rigidity. |
| **Tier 4** | **Automated Verifiers** | [`04_Automated_Verification_and_Manifest.md`](./en/04_Automated_Verification_and_Manifest.md)<br>[`manifest.json`](./manifest.json) | Verification pipeline, SHA-256 hash table, and JSON theorem manifest. |

## Formal Proofs & One-Command Verification

- [`proofs/k3_forensic_paths.lean`](./proofs/k3_forensic_paths.lean): Theorems 1–27 (`0 sorry`, `135/135` mutations caught).
- [`proofs/verify_symbolic_k3.py`](./proofs/verify_symbolic_k3.py): SymPy verifier reproducing [`proofs/symbolic_verification_result.json`](./proofs/symbolic_verification_result.json).

```bash
lean proofs/k3_forensic_paths.lean && (cd proofs && python3 verify_symbolic_k3.py)
```
