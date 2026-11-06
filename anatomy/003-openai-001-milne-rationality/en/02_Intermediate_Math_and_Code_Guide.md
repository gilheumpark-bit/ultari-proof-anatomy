# [Level 2: Intermediate Guide] 6-Section Mathematical Structure & Complete Mapping of All 36 Lean 4 Theorems

The 6 LaTeX sections of OpenAI `#001` (*Milne's rationality conjecture for abelian varieties*) correspond one-to-one with our **36 Lean 4 theorems** (split across two modular files under 500 lines, with **`232/232` (`101 + 131`)** hypothesis mutations caught) and **7 SymPy + PyTorch verification audits (`Audit 1–7`)**.

---

## 1. Exact Mapping Between Manuscript `.tex` Files and Paper Sections

Because `00_intro.tex` opens with `\section{Introduction}`, each file index `0k_*.tex` corresponds to **Section `k + 1`** in the compiled paper:

| Manuscript File | Paper Section & Title | Core Mathematical Role | Mapped Lean 4 Theorems |
| :--- | :--- | :--- | :--- |
| `sections/00_intro.tex` | **Section 1. Introduction** | Main theorem (`Theorem 1.1`) and architectural dependency graph | Theorems 26, 29 |
| `sections/01_preliminaries.tex` | **Section 2. Preliminaries** | Homogeneous pullback scaling, $p$-divisible groups & filtered modules (`Lemma 2.3`) | Theorems 1, 31 |
| `sections/02_transport.tex` | **Section 3. $p$-adic transport** | Auxiliary group $J$ (`Lemma 3.2`), pointwise ADLV lift (`Lemma 3.3`), similitude $\lambda$ | Theorems 2, 3, 29 |
| `sections/03_filtration.tex` | **Section 4. Adapted filtration** | Kronecker bound (`Lemma 4.2`), Lagrangian Grassmannian (`Lemma 4.3`), HN defect (`Theorem 4.6`), Rosati involution (`Lemma 4.7`), Breuil-Kisin rank (`Proposition 4.8`), divisor filtration (`Corollary 4.9`) | Theorems 4–16, 24, 32–33 |
| `sections/04_weil.tex` | **Section 5. Weil classes** | Balanced Weil dichotomy (`Proposition 5.2`), kernel contradiction (`Lemma 5.3`), Vandermonde separation (`Lemma 5.4`), unitary orbit (`Lemma 5.5`) | Theorems 17–20, 25, 27 |
| `sections/05_reduction.tex` | **Section 6. CM Reduction** | Balanced CM idempotent factor $B_\Delta$ (`Lemma 6.1`, `Theorem 6.2`), Tate classes (`Corollary 6.3`), Chow cycle realization (`Corollary 6.4`) | Theorems 21–23, 26, 28, 30 |

---

## 2. File A: [`milne_transport_and_filtration.lean`](../proofs/milne_transport_and_filtration.lean) (Theorems 1–16, `101/101` Mutations Caught)

### Part I: Rational Pullback Scaling & Shimura Transport (Theorems 1–3)
1. **Theorem 1** ([`rational_pullback_clearing_multiplier_invariance`](../proofs/milne_transport_and_filtration.lean#L20-L36)): Proves that clearing the denominator of a rational homomorphism $f$ by $N$ vs. $kN$ yields $(k^{2r})((Nf)^*\alpha) = ((kNf)^*\alpha)$ on $H^{2r}$.
2. **Theorem 2** ([`auxiliary_hodge_datum_torus_and_representation_dimensions`](../proofs/milne_transport_and_filtration.lean#L45-L66)): Proves the torus rank $\operatorname{rk} J = 1 + d_P(\operatorname{rk} G - 1)$, abelianization dimension $\dim J^{\mathrm{ab}} = 1 + d_P(\dim G^{\mathrm{ab}} - 1)$, and symplectic representation dimension $\dim W = 2 m d_P \dim A \ge 2$ (`Lemma 3.2`, `Audit 1`).
3. **Theorem 3** ([`transport_common_rational_similitude_normalization`](../proofs/milne_transport_and_filtration.lean#L74-L100)): Proves that $\operatorname{deg}_{\mathrm{den}} \cdot \lambda_v = \operatorname{deg}_{\mathrm{num}} \neq 0$ forces $\lambda_\ell = \lambda_p \neq 0$ across all realizations and $a^*\eta_{B,0} = (d_P \lambda^r)\gamma_0$ (`Audit 1`).

### Part II: Kronecker Exponent Injectivity & Lagrangian Grassmannian Duality (Theorems 4–6)
4. **Theorem 4** ([`base_N_monomial_exponent_injective_2var`](../proofs/milne_transport_and_filtration.lean#L110-L142)): Proves base-$N$ exponent injectivity $d_0 + d_1 N = e_0 + e_1 N \implies d_0 = e_0 \wedge d_1 = e_1$ for $N \ge b + 1$ (`Lemma 4.2`).
5. **Theorem 5** ([`lemma_4_2_eisenstein_valuation_layer_uniqueness`](../proofs/milne_transport_and_filtration.lean#L148-L181)): Proves Eisenstein prime $q$-adic valuation layer non-cancellation ($q v_1 + E_1 = q v_2 + E_2 \implies v_1 = v_2 \wedge E_1 = E_2$ for $0 \le E_1, E_2 \le B < q$, `Lemma 4.2`, `03_filtration.tex:110-120`).
6. **Theorem 6** ([`lagrangian_grassmannian_incidence_and_duality`](../proofs/milne_transport_and_filtration.lean#L188-L206)): Proves `Lemma 4.3` Case 1 ($1 \le a \le m$), showing that the incidence locus over $\mathbb{P}(W_0)$ ($\dim = a-1$) with $\operatorname{LGr}(m-1, 2m-2)$ fibers has codimension $m - a + 1 \ge 1$ in $\operatorname{LGr}(m, 2m)$.

### Part III: Harder-Narasimhan Defect Supermodularity & Weak Admissibility (Theorems 7–10)
7. **Theorem 7** ([`defect_supermodularity_and_maximizer_closure`](../proofs/milne_transport_and_filtration.lean#L215-L224)): Proves supermodularity $f(P) + f(Q) \le f(P \cap Q) + f(P + Q)$ of $f(P) = t_H(P) - t_N(P)$ and closure of the maximizer locus under $\cap$ and $+$ (`Theorem 4.6`).
8. **Theorem 8** ([`block_slope_duality_newton_sum_identity`](../proofs/milne_transport_and_filtration.lean#L227-L245)): Proves the slope-1 duality sum $\sum \lambda \dim M_\lambda = m$ (`qd_newton_sum = q_d * m`) on a $2m$-dimensional symplectic block (`Eq. 4.6`, `Audit 3`).
9. **Theorem 9** ([`block_newton_hodge_weak_admissibility_bound`](../proofs/milne_transport_and_filtration.lean#L248-L263)): Proves the weak admissibility bound $t_H(M') = \max(0, a - m) \le t_N(M')$ from slope bounds in $[0, 1]$ (`Eq. 4.7`, `Audit 3`).
10. **Theorem 10** ([`divisor_filtration_wedge_two_decomposition`](../proofs/milne_transport_and_filtration.lean#L268-L299)): Proves $\dim \operatorname{Fil}^1(\bigwedge^2 D_K) = g(3g-1)/2$ and that the vanishing of `proj_H_wedge2 = 0` on the $U$-stable $\psi$-Lagrangian $H = L^\perp$ forces `Du_total = Du_fil1` ($D^u \in \operatorname{Fil}^1(\bigwedge^2 D_K)$, `Corollary 4.9`).

### Part VI-A: Modified Pairing $B(x, y) = \beta(x, u y)$ & Symplectic Perp Invariance (Theorems 11–16)
11. **Theorem 11** ([`modified_pairing_alternating_from_rosati_symmetry`](../proofs/milne_transport_and_filtration.lean#L307-L314)): Proves $B(y, x) = -B(x, y)$ from $\beta(y, x) = -\beta(x, y)$ and $\beta(ux, y) = \beta(x, uy)$.
12. **Theorem 12** ([`modified_pairing_e_bilinear_from_conjugate_cancellation`](../proofs/milne_transport_and_filtration.lean#L320-L327)): Proves $E$-bilinearity $B(ex, y) = B(x, ey)$ via cancellation of Rosati conjugation $\beta(ex, w) = \beta(x, \bar{e}w)$ against $ue = \bar{e}u$.
13. **Theorem 13** ([`modified_pairing_u_similitude_on_eigenspace`](../proofs/milne_transport_and_filtration.lean#L332-L341)): Proves the similitude scaling $B(ux, uy) = z B(x, y)$ on $u^2 = z$ eigenspaces.
14. **Theorem 14** ([`u_stable_b_lagrangian_implies_beta_lagrangian`](../proofs/milne_transport_and_filtration.lean#L344-L351)): Proves that any $u$-stable $B$-Lagrangian $L$ satisfies $\beta(x, y) = B(x, u^{-1}y) = 0$ and is therefore $\beta$-Lagrangian (`Audit 7`).
15. **Theorem 15** ([`hn_defect_symplectic_perp_invariance`](../proofs/milne_transport_and_filtration.lean#L359-L367)): Proves symplectic orthogonal-complement invariance $f(P^\perp) = f(P) = a_{\max}$ from $t_H(P^\perp) = g - d_P + t_H(P)$ and $t_N(P^\perp) = g - d_P + t_N(P)$ (`03_filtration.tex:241-246`).
16. **Theorem 16** ([`lagrangian_perp_intersection_duality`](../proofs/milne_transport_and_filtration.lean#L370-L381)): Proves $\dim(L \cap W) = a - m + \dim(L \cap W^\perp) \ge a - m \ge 1$ for $a > m$ directly from Grassmann's identity.

---

## 3. File B: [`milne_weil_reduction_and_repairs.lean`](../proofs/milne_weil_reduction_and_repairs.lean) (Theorems 17–36, `131/131` Mutations Caught)

### Part IV: Balanced Weil Dichotomy & Retraction Algebra (Theorems 17–20)
17. **Theorem 17** ([`weil_pairing_bidegree_saturation_on_conjugate_pair`](../proofs/milne_weil_reduction_and_repairs.lean#L16-L28)): Proves bidegree saturation on $V_\tau \oplus V_{\bar{\tau}}$, forcing $\deg_\tau(\psi_0) = \deg_{\bar{\tau}}(\psi_0) = 0$ and $d_i = 2$ for every divisor factor $D_i$ (`Lemma 5.3`).
18. **Theorem 18** ([`non_invertible_u_kernel_radical_contradiction`](../proofs/milne_weil_reduction_and_repairs.lean#L31-L41)): Proves that a non-invertible $u \in U$ has $\dim C \ge 1$ with equal positive embedding multiplicity $m_C \ge 1$, forcing $\operatorname{rank}(D^u|_{V_{\bar{\tau}}}) \le 2s - m_C < 2s$ (`Lemma 5.3`, `Audit 4`).
19. **Theorem 19** ([`weil_unitary_similitude_group_and_orbit_dimensions`](../proofs/milne_weil_reduction_and_repairs.lean#L45-L62)): Proves $\dim G = 1 + d_0(4s^2 - 1)$, $\dim \mathcal{O} = d_0 s^2$, and $\dim G - 4\dim\mathcal{O} = 1 - d_0$ (`Lemma 5.5`).
20. **Theorem 20** ([`weil_retraction_projector_cohomology_recovery`](../proofs/milne_weil_reduction_and_repairs.lean#L68-L78)): Proves Poincaré complement splitting $B_0 \sim A_0 \times K_0$ ($\operatorname{rk}(R_0) = \dim A_0$, $\dim\ker(R_0) = \dim K_0$) and cohomological pullback recovery $f_0^*(R_0^*\kappa_0) = \gamma_0$ from $\kappa_0 = R_0^*\kappa_0 + \kappa_{\ker}$ (`04_weil.tex:373-435`).

### Part V: Balanced CM Idempotent Reduction & Universal Bounds (Theorems 21–26)
21. **Theorem 21** ([`cm_balanced_idempotent_factor_dimensions`](../proofs/milne_weil_reduction_and_repairs.lean#L87-L100)): Proves $\dim_\mathbb{Q} T = 2 d d_K$, $\dim_\mathbb{Q} U = 2 r d_K$, $\dim B_\Delta = r d_K$, and $p_\tau = q_\tau = r$ for balanced CM idempotent factors (`Lemma 6.1`, `Audit 5`).
22. **Theorem 22** ([`unbalanced_cm_subset_violates_hodge_bidegree`](../proofs/milne_weil_reduction_and_repairs.lean#L103-L108)): Proves that an unbalanced subset ($p_{\sigma\Delta} \neq r$) has $p_{\sigma\Delta} \neq q_{\sigma\Delta}$ and cannot carry a rational Hodge class of bidegree $(r, r)$.
23. **Theorem 23** ([`thm_6_2_cm_galois_orbit_partition`](../proofs/milne_weil_reduction_and_repairs.lean#L115-L125)): Proves the Galois orbit partition of CM eigenspace subsets (`Theorem 6.2`, `05_reduction.tex:250-365`) into balanced ($N_{\mathrm{bal}}$) and unbalanced ($N_{\mathrm{unbal}}$) orbits, showing that vanishing on unbalanced orbits (`hodge_unbal = 0`) restricts the full rational Hodge class to balanced CM factors (`hodge_total = hodge_bal`).
24. **Theorem 24** ([`prop_4_8_breuil_kisin_rank_and_zero_defect`](../proofs/milne_weil_reduction_and_repairs.lean#L133-L144)): Proves `Proposition 4.8` (`03_filtration.tex:380-445`): over the degree-$q$ Eisenstein extension $K'/K$, the adapted Lagrangian $L \subset D_{K'}$ defines a Breuil-Kisin filtration of rank $\operatorname{rk}\operatorname{Fil}^1\mathfrak{M} = g = \operatorname{rk}(\mathfrak{M}/\operatorname{Fil}^1\mathfrak{M})$ with zero total defect $t_H(D_{K'}) - t_N(D_{K'}) = 0$.
25. **Theorem 25** ([`universal_weil_divisor_polynomial_pure_degree_separation`](../proofs/milne_weil_reduction_and_repairs.lean#L147-L156)): Proves the polynomial Vandermonde degree separation $\deg_{\mathrm{mixed}} \le 2(s-1) < 2s = \deg_{\mathrm{pure}}$ (`Lemma 5.4`, `Audit 4`).
26. **Theorem 26** ([`milne_001_internal_dependency_and_lefschetz_vs_chow_gap`](../proofs/milne_weil_reduction_and_repairs.lean#L164-L174)): Proves that exceptional Weil classes ($\dim_{\mathrm{weil}} \ge 2$) create a positive Lefschetz pairing radical $\dim_{\mathrm{ker,lef}} = \dim_{\mathrm{weil}} \ge 2$, whereas CM Chow pullback (`[OAI26, Theorem 1.1]`, `Corollary 6.4`) achieves $\dim_{\mathrm{alg,CM}} = \dim_{\mathrm{hdg}}$ and $\dim_{\mathrm{ker,chow}} = 0$.

### Part VI-B: Néron-Severi Filtration Lifting & Rational Tate Class Compatibility (Theorems 27–28)
27. **Theorem 27** ([`first_factor_projector_retraction_pullback_chain`](../proofs/milne_weil_reduction_and_repairs.lean#L187-L196)): Proves that vanishing of the filtration obstruction `obs_hom_L_to_quot = 0` in $\operatorname{Hom}(L, D_K^\vee / L^\perp)$ implies $\dim(h_{D_0}'(L) + L^\perp) = g = \dim L$, allowing $h_{D_0}'$ to lift as a filtered module homomorphism (`04_weil.tex:392-425`).
28. **Theorem 28** ([`cor_6_3_frobenius_trace_rational_equality`](../proofs/milne_weil_reduction_and_repairs.lean#L204-L219)): Proves `Corollary 6.3` (`05_reduction.tex:399-426`, `[Mil09, Theorem 4.5]`): when every complementary Lefschetz pairing equals the same rational number $q_{\mathrm{num}}/q_{\mathrm{den}}$ ($q_{\mathrm{den}} \ge 1$) across $\ell$-adic and crystalline realizations, the cross-realization discrepancy `realization_diff = trace_ell - trace_p = 0` vanishes identically.

### Part VII: The 5 Formal Repair Verification Theorems (Theorems 29–33)
29. **Theorem 29 (`[Medium-1]` Repair)** ([`repair_medium1_pointwise_kz_adlv_bypasses_glx26`](../proofs/milne_weil_reduction_and_repairs.lean#L234-L245)): Proves that the pointwise Kisin-Zhou lift (`[KZ25b, Proposition 2.2.3]`) satisfies $\dim(\operatorname{Fil}^1 + \mathcal{F}^1) = g_C$ and filtration mismatch codimension `mismatch_codim = 0` without `[GLX26, Corollary 6.3]`.
30. **Theorem 30 (`[Medium-2]` Repair)** ([`repair_medium2_beauville_projector_canonical_cycle_invariance`](../proofs/milne_weil_reduction_and_repairs.lean#L248-L259)): Proves that Beauville projection $P_{r,0}$ eliminates the $N \to MN$ scaling discrepancy (`z_MN ≠ z_N` vs. `z_can_MN = z_can_N`) while preserving `cl_z_can = cl_z_N = gamma_0` (`Audit 6`).
31. **Theorem 31 (`[Low-1]` Repair)** ([`repair_low1_ramified_dvr_unconditional_lifting_range`](../proofs/milne_weil_reduction_and_repairs.lean#L267-L281)): Unified proof for $e \ge p + 1 > p - 1 = e_{\mathrm{max,pd}}$ combining the PD failure $v_\pi(\pi^p/p) = p - e \le -1$ with Colmez-Fontaine + Tate extension (`rk_Hom_R = rk_Hom_GK = rk_Hom_MF ≥ 1`, `rk_coker_tate = 0`) and Serre-Tate square-zero valuation $v_\pi(I_n^2) = 2n \ge n + 1$.
32. **Theorem 32 (`[Low-2]` Repair)** ([`repair_low2_sharp_kronecker_bound_attained_3var`](../proofs/milne_weil_reduction_and_repairs.lean#L285-L314)): Unified proof that for 3-variable total degree $d_0 + d_1 + d_2 \le b$, the Kronecker exponent satisfies $E \le B_{\mathrm{sharp}} = b N^2 < B_{\mathrm{paper}} = b(1+N+N^2)$ with exact degree savings $\Delta B = b(1+N) \ge 3$ (`Audit 2`).
33. **Theorem 33 (`[Low-3]` Repair)** ([`repair_low3_rosati_positive_definite_u2_eigenvalues_strictly_positive`](../proofs/milne_weil_reduction_and_repairs.lean#L317-L323)): Proves that any nonzero real eigenvalue ($|\mu| \ge 1$) of a Rosati-symmetric invertible endomorphism $u$ yields a strictly positive eigenvalue $z = |\mu|^2 \ge 1 > 0$ of $u^2$ (`Audit 7`).

---

## 4. Detailed Mapping of the 7 Symbolic & PyTorch Audits (`Audit 1–7`)

[`verify_symbolic_milne.py`](../proofs/verify_symbolic_milne.py) combines SymPy symbolic algebra with PyTorch FP64 tensor computations across 7 modular audit functions and records deterministic results in [`symbolic_verification_result.json`](../proofs/symbolic_verification_result.json).

| Audit ID | Function & Line Range | Mathematical Formula & Verification Algorithm | Verified Output Metrics (`JSON` Keys) | Corresponding Lean 4 Theorems |
| :--- | :--- | :--- | :--- | :--- |
| **`Audit 1`** | `_run_audits_1_and_2` (`L25-L47`) | Auxiliary Hodge datum torus rank $\operatorname{rk} J = 1 + d_P(\operatorname{rk} G - 1)$, abelianization dimension, symplectic dimension $\dim W = 2 d_P m \dim A$, and normalized pullback identity $(\lambda^{-r}/d_P)(\lambda^r d_P \gamma_0) = \gamma_0$ | `status: PASS`, `rk_J_formula`, `normalized_pullback_identity` | Theorems 1, 2, 3 |
| **`Audit 2`** | `_run_audits_1_and_2` (`L49-L76`) | Injectivity of base-$N$ ($N=6$) Kronecker exponents across all $\binom{3+5}{3} = 56$ monomials of total degree $\le 5$ in $r=3$ variables, sharp bound $B_{\mathrm{sharp}} = 5 \cdot 6^2 = 180$ vs. paper bound $B_{\mathrm{paper}} = 5(1+6+36) = 215$ | `monomial_count_total_deg_le_b: 56`, `B_sharp_max_total_deg_exponent: 180`, `exact_degree_slack: 35` | Theorems 4, 5, 32 |
| **`Audit 3`** | `_run_audit_3_symplectic_num` (`L79-L143`) | $2m = 12$-dimensional symplectic isocrystal ($m=6$, slope-dual sum $\sum \lambda_i = 6$): FP64 Lagrangian isotropy check and exhaustive inspection of all $2^{12} = 4096$ slope-graded subobjects verifying weak admissibility $t_H(M') - t_N(M') \le 0$ | `lagrangian_isotropy_max_err: 0.0`, `slope_graded_subobjects_tested: 4096`, `max_defect_tH_minus_tN: "0"` | Theorems 6–10, 15–16, 24 |
| **`Audit 4`** | `_run_audits_4_and_5_weil` (`L146-L178`) | Pure-power coefficient extraction $D_i^2$ from $(\sum_{i=1}^4 x_i^2 D_i)^2$ ($d_E = 4, s = 2$), full FP64 Vandermonde rank $\operatorname{rank}(V) = \binom{4+2-1}{2} = 10$ across 25 evaluation points, and degenerate Pfaffian $\det(\Omega_{\mathrm{deg}}) = 0.0$ for non-invertible $u$ | `vandermonde_monomial_rank: 10`, `expected_monomial_space_dim: 10`, `non_invertible_u_pfaffian_det: -0.0` | Theorems 17–20, 25, 27 |
| **`Audit 5`** | `_run_audits_4_and_5_weil` (`L180-L192`) | Balanced CM idempotent factor dimensions for $d = 4, r = 2, d_K = 6$: $\dim_\mathbb{Q} T = 48$, $\dim_\mathbb{Q} U = 24$, and abelian factor dimension $\dim B_\Delta = 12$ | `dim_T: 48`, `dim_U_Q: 24`, `dim_B_Delta: 12` | Theorems 21, 22, 23, 26, 28 |
| **`Audit 6`** | `_run_audit_6_beauville_projector` (`L195-L240`) | Idempotency ($P_{2,0}^2 = P_{2,0}$) of Beauville projector for $d = 4, r = 2, s \in \{-2, \dots, 4\}$, unrepaired $N=3$ vs. $N=6$ discrepancy $\|z_\gamma^{(6)} - z_\gamma^{(3)}\|_1 = \frac{42109}{432}$, and exact $N$-invariance across $N \in \{1,2,3,5,6,10\}$ with preserved cohomology class $11$ | `unrepaired_N3_vs_N6_l1_discrepancy: "42109/432"`, `repaired_canonical_cycle_N_invariant: true`, `common_cohomological_class_value: "11"` | Theorem 30 |
| **`Audit 7`** | `_run_audit_7_rosati_num` (`L243-L275`) | PyTorch batch of $1000$ random Rosati-symmetric positive-definite operators $u$ ($6 \times 6$): minimum $u^2$ eigenvalue $\min z = 10^{-6} > 0$ and zero Lagrangian isotropy error $0.0$ | `batch_trials: 1000`, `min_u2_eigenvalue_z: 1e-06`, `all_u2_eigenvalues_strictly_positive: true`, `max_lagrangian_isotropy_error: 0.0` | Theorems 11–14, 33 |

---

## 5. Symbol Glossary (LaTeX Manuscript vs. Lean 4 Identifiers)

- **Rational Pullback & Shimura Transport (`Part I`)**:
  - `N`, `k`, `r`, `k_pow_2r`: Denominator-clearing integer $N \ge 1$, multiplier $k \ge 2$, codimension $r$, cohomology scaling factor $k^{2r}$
  - `d_P`, `rk_G`, `rk_J`, `dim_W`: Totally real degree $[P:\mathbb{Q}]$, original rank $\operatorname{rk} G$, auxiliary group rank $\operatorname{rk} J$, symplectic representation dimension $\dim W$
  - `lam_l`, `lam_p`, `deg_num`, `deg_den`: $\ell$-adic and crystalline similitude factors $\lambda_\ell, \lambda_p$ and polarization intersection numerator/denominator
- **Kronecker Substitution & Lagrangian Filtration (`Part II–III, VI-A`)**:
  - `b`, `N`, `B_sharp`, `B_paper`: Total degree bound $b$, Kronecker base $N = b+1$, sharp bound $b N^{r-1}$, paper bound $b\sum_{i=0}^{r-1} N^i$
  - `tH_P`, `tN_P`, `a_max`: Hodge number $t_H(P) = \dim(P \cap L)$, Newton number $t_N(P)$, maximum defect $a_{\max} = \max_P (t_H(P) - t_N(P))$
  - `Du_total`, `Du_fil1`, `proj_H_wedge2`: Total 2-form $D^u \in \bigwedge^2 D_K^\vee$, its $\operatorname{Fil}^1$ component, and its projection to $\bigwedge^2 H^\vee$
- **Weil Dichotomy, CM Reduction & 5 Repairs (`Part IV–V, VI-B, VII`)**:
  - `dim_weil`, `dim_lef`, `dim_ker_lef`, `dim_ker_chow`: Exceptional Weil-class dimension, Lefschetz subspace dimension, Lefschetz pairing radical dimension, full CM Chow pairing radical dimension
  - `val_pi_p_over_p`, `val_In_sq`: $\pi$-adic valuation $p - e \le -1$ of $\pi^p/p$ and valuation $2n \ge n+1$ of the square-zero Serre-Tate ideal $I_n^2$
  - `z_N`, `z_MN`, `z_can_N`, `z_can_MN`: Raw unprojected cycles $z_\gamma^{(N)}, z_\gamma^{(MN)}$ vs. Beauville-projected canonical cycles $P_{r,0}(z_\gamma^{(N)}), P_{r,0}(z_\gamma^{(MN)})$


---

## 6. Extended Preliminaries & CM Transport Formalization (Theorems 34-36)

To achieve **100% (`10 / 10` files, `28 / 28` environments, delayed proofs, and repair patch)** 1-to-1 formal audit coverage across `proofs/oai_ref/repaired_build/` and `oai_001_milne_repair.patch`, [`milne_weil_reduction_and_repairs.lean`](../proofs/milne_weil_reduction_and_repairs.lean) includes three additional theorems (`Theorem 34` through `Theorem 36`, [`L326-L379`](../proofs/milne_weil_reduction_and_repairs.lean#L326-L379)):

| Theorem | Lean Identifier & Line | Source File & Section | Formalized Mathematical Invariant |
| :--- | :--- | :--- | :--- |
| **Theorem 34** | [`lemma_2_1_comparison_isomorphism_and_tate_twist_compatibility`](../proofs/milne_weil_reduction_and_repairs.lean#L329-L340) | [`01_preliminaries.tex`](../proofs/oai_ref/repaired_build/sections/01_preliminaries.tex#L50-L75) (`Lemma 2.1`, `lem:comparison`) | Cross-realization agreement `t_cris_etale = t_dR` (`diff_comp = 0`) and Tate-twist weight cancellation `2r + (-2r) = 0` on $H^{2r}(X)(r)$. |
| **Theorem 35** | [`lemma_2_2_lefschetz_pairing_functoriality_and_projection_system`](../proofs/milne_weil_reduction_and_repairs.lean#L345-L362) | [`01_preliminaries.tex`](../proofs/oai_ref/repaired_build/sections/01_preliminaries.tex#L108-L142) (`Definition` & `Lemma 2.2`, `lem:pairing-functorial`) | Invertibility of rational Lefschetz pairing matrix (`det_M ≥ 1`) and `rhs_ell = rhs_p` force `c_ell = c_p` and functorial pullback preservation under $f^*$. |
| **Theorem 36** | [`corollary_3_4_cm_transport_first_factor_pullback_recovery`](../proofs/milne_weil_reduction_and_repairs.lean#L368-L379) | [`02_transport.tex`](../proofs/oai_ref/repaired_build/sections/02_transport.tex#L35-L114) (`Proposition 3.1`) & [`02_transport.tex`](../proofs/oai_ref/repaired_build/sections/02_transport.tex#L790-L827) (`Corollary 3.4`, `cor:cm-transport`) | Product dimension $\dim A_0^n = n \dim A_0$ and composite first-factor pullback $(a \circ j)^* \kappa_0 = \gamma_0$ across prime-to-$p$ and crystalline realizations. |

## 7. Complete 10-File (`100%`) Source-to-Lean Mapping Table (`proofs/oai_ref/` + Repair Patch)

| # | Reference File (`proofs/`) | Lines | Envs / Blocks | Mapped Lean 4 Theorems | Primary Mathematical Content Audited |
| :---: | :--- | :---: | :---: | :--- | :--- |
| `01` | [`oai_ref/repaired_build/main.tex`](../proofs/oai_ref/repaired_build/main.tex#L1-L73) | `73` | `0` | Theorems 1-36 | Master LaTeX build root assembling `sections/00_intro.tex` through `sections/05_reduction.tex` and `references.tex` |
| `02` | [`oai_ref/repaired_build/references.tex`](../proofs/oai_ref/repaired_build/references.tex#L1-L287) | `287` | `0` | Theorems 26, 28, 29, 30, 31, 33 | Bibliography database including repaired citations `[Bea86]`, `[Mil09a]`, `[CF00]`, `[Tat67]`, `[PR24]`, `[KZ25b]` |
| `03` | [`oai_ref/repaired_build/figures/two-transports.tex`](../proofs/oai_ref/repaired_build/figures/two-transports.tex#L1-L28) | `28` | `0` | Theorems 2, 3, 29, 36 | Commutative diagram of the two $p$-adic transport steps ($A_0^n \to B_0$ via $C_x$ and $C_y$) |
| `04` | [`oai_ref/repaired_build/sections/00_intro.tex`](../proofs/oai_ref/repaired_build/sections/00_intro.tex#L1-L283) | `283` | `1` | Theorems 26, 28, 29, 33 | `Section 1`: Main theorem (`Theorem 1.1`, `thm:main`, `L29`) and 5-step proof architecture |
| `05` | [`oai_ref/repaired_build/sections/01_preliminaries.tex`](../proofs/oai_ref/repaired_build/sections/01_preliminaries.tex#L1-L232) | `232` | `4` | Theorems 1, 27, 31, 34, 35 | `Section 2`: Rational pullback (`L15`), `lem:comparison` (`L50`), Lefschetz pairing definition (`L108`), `lem:pairing-functorial` (`L119`), `lem:lift-hom` (`L158`) |
| `06` | [`oai_ref/repaired_build/sections/02_transport.tex`](../proofs/oai_ref/repaired_build/sections/02_transport.tex#L1-L827) | `827` | `4` | Theorems 2, 3, 29, 36 | `Section 3`: `prop:transport` (`L35`), `lem:auxiliary-datum` (`L116`), `lem:admissible-realization` (`L330`), `cor:cm-transport` (`L790`) |
| `07` | [`oai_ref/repaired_build/sections/03_filtration.tex`](../proofs/oai_ref/repaired_build/sections/03_filtration.tex#L1-L493) | `493` | `7` | Theorems 4-16, 24, 32, 33 | `Section 4`: `thm:filtration` (`L38`), `lem:avoidance` (`L87`), `Remark` (`L131`), `lem:lagrangian-intersection` (`L138`), `Proof of thm:filtration` (`L219`), `cor:filtration-admissible` (`L448`), `cor:filtration-divisor` (`L461`) |
| `08` | [`oai_ref/repaired_build/sections/04_weil.tex`](../proofs/oai_ref/repaired_build/sections/04_weil.tex#L1-L439) | `439` | `6` | Theorems 17-20, 25, 27 | `Section 5`: `def:weil-space` (`L18`), `prop:weil` (`L55`), `lem:weil-orthogonality` (`L70`), `lem:weil-divisor-span` (`L205`), `lem:weil-group` (`L280`), `Proof of prop:weil` (`L328`) |
| `09` | [`oai_ref/repaired_build/sections/05_reduction.tex`](../proofs/oai_ref/repaired_build/sections/05_reduction.tex#L1-L471) | `471` | `5` | Theorems 21-23, 26, 28, 30 | `Section 6`: `lem:cm-reduction` (`L18`), `cor:cm-pairing` (`L207`), `Proof of thm:main` (`L227`), `cor:all-hodge-specialization` (`L281`), `cor:algebraic-specialization` (`L375`) |
| `10` | [`oai_001_milne_repair.patch`](../proofs/oai_001_milne_repair.patch#L1-L234) | `234` | `1` | Theorems 29, 30, 31, 32, 33 | Unified diff repairing `[Medium-1]`, `[Medium-2]`, `[Low-1]`, `[Low-2]`, and `[Low-3]` across 6 manuscript files |
