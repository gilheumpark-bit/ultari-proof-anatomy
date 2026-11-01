# OpenAI `#032` (Retracted K3 Hodge Conjecture Manuscripts) Forensic Anatomy & Lean 4 Verification Package (English Edition)

- **Release Date**: 2026-11-01
- **Target Repository**: `openai/math` Family `#032` (`The rational Hodge conjecture for CM abelian varieties` & 3 retracted K3/Eightfold Hodge conjecture manuscripts at commit `adc7f1241b42` + `[EEMS13]` `arXiv:1303.0588v2`)
- **Primary Formal & Symbolic Artifacts**:
  - Formal Lean 4 Proofs (27 Theorems, 452 lines, `0 sorry`, `0 axiom`, `112/112` hypothesis mutations killed): [`proofs/k3_forensic_paths.lean`](../proofs/k3_forensic_paths.lean)
  - Symbolic Verification Script (`SymPy` / Exact Integer & Determinant Arithmetic): [`proofs/verify_symbolic_k3.py`](../proofs/verify_symbolic_k3.py)
  - Symbolic Verification Output Data (JSON): [`proofs/symbolic_verification_result.json`](../proofs/symbolic_verification_result.json)

---

## 4-Tier Reader Guide (Tailored by Background)

This package is structured into 4 self-contained tiers so that **Beginners**, **Intermediates**, **Experts**, and **Automated Verification Systems** can understand and verify the results.

| Tier | Target Audience | Document | Summary of Contents |
| :---: | :--- | :--- | :--- |
| **Tier 1** | **Beginners (General Readers)** | [`01_Beginner_Guide.md`](./01_Beginner_Guide.md) | Plain-language introduction to the Hodge Conjecture and K3 surfaces, why fixing a single sign fails (the Double Bind), rescued `Part I` reduction engine, and key forensic invariants (`-2m / 2 / 2,747,136 vs 523,779 vs 140,033`) |
| **Tier 2** | **Intermediates (STEM / Engineers)** | [`02_Intermediate_Math_and_Code_Guide.md`](./02_Intermediate_Math_and_Code_Guide.md) | Step-by-step algebraic equations for Problems 1 to 5 and a complete 1-to-1 index of all 27 Lean 4 theorems |
| **Tier 3** | **Experts (Algebraic & Symplectic Geometers, Formal Verification Researchers)** | [`03_Expert_Mathematical_and_Formal_Report.md`](./03_Expert_Mathematical_and_Formal_Report.md) | Technical report covering the `[EEMS13]` Poincaré-Hopf sign discrepancy, Shioda-Inose central fiber No-Go theorems, Additivity vs. Hyperkähler Rigidity circularity, and Bogomolov discriminant sign-flip obstruction |
| **Tier 4** | **AI Parsers & Automated Verification** | [`04_Automated_Verification_and_Manifest.md`](./04_Automated_Verification_and_Manifest.md)<br>[`manifest.json`](../manifest.json) | One-command verification pipeline (`lean`, `python3`, `sha256sum`), SHA-256 hash list, scope notes, and JSON manifest |

---

## One-Command Verification

Run the following command from the package root directory to compile all 27 Lean 4 theorems (`exit 0`) and reproduce the symbolic verification JSON:

```bash
lean ../proofs/k3_forensic_paths.lean && (cd ../proofs && python3 verify_symbolic_k3.py)
```
