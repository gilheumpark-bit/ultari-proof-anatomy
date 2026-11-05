# OpenAI `#001` (`Milne's rationality conjecture for abelian varieties`) Forensic Audit & Repair Specification

- **Target Manuscript**: `Milnes-rationality-conjecture-for-abelian-varieties-October-7-2026` (6 LaTeX sections: `00_intro.tex` = Section 1, `01_preliminaries.tex` = Section 2, `02_transport.tex` = Section 3, `03_filtration.tex` = Section 4, `04_weil.tex` = Section 5, `05_reduction.tex` = Section 6)
- **Severity Breakdown**: High (`상`): 0, Medium (`중`): 2, Low (`하`): 3
- **Lean 4 Formal Verification Scope (Category A / 영역 A)**:
  - `33` Lean 4 theorems across `proofs/milne_transport_and_filtration.lean` (`16` theorems, `101/101` hypothesis mutations caught) and `proofs/milne_weil_reduction_and_repairs.lean` (`17` theorems, `110/110` hypothesis mutations caught), totaling `211/211` hypothesis mutations caught with `0 sorry` and `0` custom axioms.
- **Repairs & Formal Proofs**:
  1. `[Medium-1]` (`02_transport.tex:471-505`, `00_intro.tex:163-171`): Bypass unpublished `[GLX26, Corollary 6.3]` and hypothesis `(U_x)` via pointwise Breuil-Kisin specialization (`[PR24, Proposition 3.5.1]`) and Kisin-Zhou affine Deligne-Lusztig uniformization (`[KZ25b, Theorem 2.2.5 & Proposition 2.2.3]`). (`Theorem 29`)
  2. `[Medium-2]` (`05_reduction.tex:428-447`): Eliminate denominator-`N` sensitivity in `CH^r(A_0)_Q` via Beauville's canonical Lagrange interpolation projector `P_{r,0}` (`[Bea86, Proposition 2]`). (`Theorem 30`, `Audit 6`)
  3. `[Low-1]` (`01_preliminaries.tex:171-200`): Replace unramified filtered Dieudonné citation (`e <= p-1`) on highly ramified DVRs (`e >= q > B >= 3`) with Colmez-Fontaine (`[CF00, Theorem A]`) + Tate's extension theorem (`[Tat67, Theorem 4]`) + Serre-Tate deformation (`[Gro70]`, `[Ill85]`). (`Theorem 31`)
  4. `[Low-2]` (`03_filtration.tex:99-121`): Tighten Kronecker substitution degree bound from `b * sum_{i=0}^{r-1} N^i` to the sharp total-degree bound `B_sharp = b * N^{r-1}`. (`Theorem 32`, `Audit 2`)
  5. `[Low-3]` (`03_filtration.tex:257-275`, `00_intro.tex:66-70`): Prove strictly positive real spectrum `z = mu_i^2 > 0` of `u^2` from positive-definite Rosati symmetry and add `[Mil09]` (`arXiv:0707.3173v4`, §6). (`Theorem 33`, `Audit 7`)
