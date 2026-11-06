> **Language**: **English** | [**한국어 (`README.ko.md`)**](./README.ko.md)

# Case 003: OpenAI `#001` Milne's Rationality Conjecture Audit & Repair

This package audits the 6 LaTeX sections of OpenAI `#001` (*Milne's rationality conjecture for abelian varieties*) and verifies 5 surgical repairs across `33` standalone Lean 4 theorems (`v4.29.0-rc8`, `0 sorry`, `211/211` hypothesis mutations caught).

## Key Findings

1. **Independence from Retracted `#032`**: We confirm that the retracted `[OAI26]` (`#032`) citation appears only in the introduction and is never used in the internal proof chain (`§2–§6`).
2. **Pointwise `KZ25` Lift (`[Medium-1]`)**: We replace the unpublished `GLX26` family assumption in `Lemma 3.3` / `Proposition 4.8` with pointwise Breuil-Kisin and Kisin-Zhou integral lifts.
3. **Canonical Beauville Projector (`[Medium-2]`)**: We normalize the non-unique Section 6 cycle lift via Beauville's weight-0 projector $P_{r,0}$ and tighten 3 ramified DVR, Kronecker, and Rosati bounds (`[Low-1]` to `[Low-3]`).

## 4-Tier Reader Guide

| Tier | Target Audience | Document | Summary |
| :---: | :--- | :--- | :--- |
| **Tier 1** | **Beginners** | [`01_Beginner_Guide.md`](./en/01_Beginner_Guide.md) | Plain-language overview of Milne's conjecture, the 4-stage proof bridge, and the 5 repairs. |
| **Tier 2** | **Intermediates** | [`02_Intermediate_Math_and_Code_Guide.md`](./en/02_Intermediate_Math_and_Code_Guide.md) | Section-by-section equations and a 1-to-1 guide to all 33 Lean 4 theorems. |
| **Tier 3** | **Experts** | [`03_Expert_Mathematical_and_Formal_Report.md`](./en/03_Expert_Mathematical_and_Formal_Report.md) | Referee report covering `#032` independence, Kisin-Zhou uniformization, and Beauville projection. |
| **Tier 4** | **Automated Verifiers** | [`04_Automated_Verification_and_Manifest.md`](./en/04_Automated_Verification_and_Manifest.md)<br>[`manifest.json`](./manifest.json) | Reproduction commands, SHA-256 checksums, and 33-theorem line index. |

## Formal Proofs & One-Command Verification

- [`proofs/milne_transport_and_filtration.lean`](./proofs/milne_transport_and_filtration.lean): Theorems 1–16 (`101/101` mutations caught).
- [`proofs/milne_weil_reduction_and_repairs.lean`](./proofs/milne_weil_reduction_and_repairs.lean): Theorems 17–33 (`110/110` mutations caught).
- [`proofs/verify_symbolic_milne.py`](./proofs/verify_symbolic_milne.py) & [`proofs/oai_001_milne_repair.patch`](./proofs/oai_001_milne_repair.patch).

```bash
lean ./proofs/milne_transport_and_filtration.lean && lean ./proofs/milne_weil_reduction_and_repairs.lean && (cd ./proofs && python3 verify_symbolic_milne.py)
```
