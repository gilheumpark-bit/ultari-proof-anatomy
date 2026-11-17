- Language: English | [한국어 (README.ko.md)](./README.ko.md)

# OpenAI #001 Milne's Rationality Conjecture Audit & Repair

This forensic audit examines the 6 LaTeX section files (alongside `main.tex`, `references.tex`, and `figures/two-transports.tex`) of OpenAI #001 (Milne's rationality conjecture for abelian varieties) and verifies 5 surgical repairs across 36 standalone Lean 4 theorems (v4.29.0-rc8, 0 sorry, 232/232 hypothesis mutations caught).

## Key Findings

1. Dependency Boundary with `[OAI26]`: We confirm that `Theorem 1.1` and `Corollary 6.3` are completely independent of `[OAI26]`, whereas `Corollary 6.4` in Section 6 (`05_reduction.tex:370, 412`) invokes the non-retracted CM abelian variety companion paper `[OAI26, Theorem 1.1]` (*The rational Hodge conjecture for CM abelian varieties*, October 6, 2026; only the K3 preprints in `#032` were retracted).
2. Pointwise KZ25 Lift ([Medium-1]): We replace the unpublished `[GLX26]` family assumption in `Proposition 3.1` / `Lemma 3.3` (`02_transport.tex:474-487, 520-540`) with pointwise Breuil-Kisin (`[PR24]`) and Kisin-Zhou (`[KZ25b]`) integral lifts.
3. Canonical Beauville Projector ([Medium-2]): We normalize the non-unique Section 6 cycle lift via Beauville's weight-0 projector $P_{r,0}$ and tighten 3 ramified DVR, Kronecker, and Rosati bounds ([Low-1] to [Low-3]).

## 4-Tier Reader Guide

| Tier | Target Audience | Document | Summary |
| :---: | :--- | :--- | :--- |
| Tier 1 | Beginners | [01_Beginner_Guide.md](./en/01_Beginner_Guide.md) | Plain-language overview of Milne's conjecture, the 4-stage proof bridge, and the 5 repairs. |
| Tier 2 | Intermediates | [02_Intermediate_Math_and_Code_Guide.md](./en/02_Intermediate_Math_and_Code_Guide.md) | Section-by-section equations and a 1-to-1 guide to all 36 Lean 4 theorems. |
| Tier 3 | Experts | [03_Expert_Mathematical_and_Formal_Report.md](./en/03_Expert_Mathematical_and_Formal_Report.md) | Referee report covering `[OAI26]` boundary, Kisin-Zhou uniformization, and Beauville projection. |
| Tier 4 | Automated Verifiers | [04_Automated_Verification_and_Manifest.md](./en/04_Automated_Verification_and_Manifest.md)<br>[manifest.json](./manifest.json) | Reproduction commands, SHA-256 checksums, and 36-theorem line index. |

## Formal Proofs & One-Command Verification

- [proofs/milne_transport_and_filtration.lean](./proofs/milne_transport_and_filtration.lean): Theorems 1-16 (101/101 mutations caught).
- [proofs/milne_weil_reduction_and_repairs.lean](./proofs/milne_weil_reduction_and_repairs.lean): Theorems 17-36 (131/131 mutations caught).
- [proofs/verify_symbolic_milne.py](./proofs/verify_symbolic_milne.py) & [proofs/oai_001_milne_repair.patch](./proofs/oai_001_milne_repair.patch).

```bash
lean ./proofs/milne_transport_and_filtration.lean && lean ./proofs/milne_weil_reduction_and_repairs.lean && (cd ./proofs && python3 verify_symbolic_milne.py)
```
