# OpenAI #001 Milne's Rationality Conjecture Audit & Repair

- Language: English | [Korean (README.ko.md)](./README.ko.md) | Main Index: [ultari-proof-anatomy](../../README.md)

This forensic audit examines the 6 LaTeX section files (alongside `main.tex`, `references.tex`, and `figures/two-transports.tex`) of OpenAI #001 (Milne's rationality conjecture for abelian varieties) and verifies 5 targeted refinements across 36 standalone Lean 4 theorems (v4.29.0-rc8, 0 sorry, 232/232 hypothesis mutations caught). Note that `proofs/oai_ref/repaired_build/` is the **post-patch manuscript snapshot** (upstream `openai/math` commit `4eaee87` October 7, 2026 submission with [proofs/oai_001_milne_repair.patch](./proofs/oai_001_milne_repair.patch) applied), not the raw unpatched October 7 submission.

## Key Findings

1. Dependency Boundary with `[OAI26]`: We confirm that `Theorem 1.1` and `Corollary 6.3` are completely independent of `[OAI26]`, whereas `Corollary 6.4` in Section 6 (`05_reduction.tex:370, 412`) invokes the non-retracted CM abelian variety companion paper `[OAI26, Theorem 1.1]` (*The rational Hodge conjecture for CM abelian varieties*, October 6, 2026; only the K3 preprints in `#032` were retracted).
2. Pointwise `[KZ25b]` Lift (`[Medium-1]`): In `Proposition 3.1` / `Lemma 3.3` (`02_transport.tex:474-487, 520-540`), we eliminate reliance on the global formal-scheme representability assumption `(U_x)` of `[GLX26, Corollary 6.3]` (Gleason–Lim–Xu, *Inventiones Mathematicae* 243 (2026), 805–861, `doi:10.1007/s00222-025-01386-1`) by localizing the integral lift to pointwise Breuil-Kisin (`[PR24]`) and Kisin-Zhou (`[KZ25b]`, `arXiv:2505.02165v1`, 2025 preprint) lifts.
3. Canonical Beauville Projector (`[Medium-2]`) and Precision Refinements (`[Low-1]`–`[Low-3]`): While `05_reduction.tex:469-470` explicitly disclaimed cycle uniqueness modulo rational equivalence, applying Beauville's weight-0 projector $P_{r,0}$ makes the `Corollary 6.4` cycle lift canonical across all $N \ge 1$ in $\operatorname{CH}^r(A_0)_\mathbb{Q}$, alongside 3 precision and formalization boundary refinements for `Lemma 2.4` (whose second sentence already noted the `[Tat67]` generic-fiber route), `Lemma 4.2`, and `Theorem 4.1`.

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
python3 ../../tools/verify_all.py --root .
lean ./proofs/milne_transport_and_filtration.lean && lean ./proofs/milne_weil_reduction_and_repairs.lean && (cd ./proofs && python3 verify_symbolic_milne.py)
```
