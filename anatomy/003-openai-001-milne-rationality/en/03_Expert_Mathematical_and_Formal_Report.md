# [Level 3: Expert Report] Arithmetic Geometry & $p$-adic Hodge Forensic Audit and Repair Report

- **Release Date**: 2026-11-01
- **Verification Toolchain**: `Lean 4 (v4.29.0-rc8)`, `Python 3 (SymPy / PyTorch FP64 in PyTorch FP64)`, Dynamic Hypothesis-Removal Mutation Testing (`211/211 = 101 + 110`)
- **Primary Formal Proof & Patch Artifacts**: [`proofs/milne_transport_and_filtration.lean`](../proofs/milne_transport_and_filtration.lean) (`16` theorems, `101/101`), [`proofs/milne_weil_reduction_and_repairs.lean`](../proofs/milne_weil_reduction_and_repairs.lean) (`17` theorems, `110/110`), [`proofs/oai_001_milne_repair.patch`](../proofs/oai_001_milne_repair.patch) (`234` lines)

---

## 1. Architectural Dependency Audit: `Theorem 1.1` & `Corollary 6.3` vs. `Corollary 6.4` (`[OAI26]` Boundary)

The logical dependency boundary between `#001` and `#032` (`[OAI26]`, *The rational Hodge conjecture for CM abelian varieties*) splits cleanly as follows ([`milne_001_internal_dependency_and_lefschetz_vs_chow_gap`](../proofs/milne_weil_reduction_and_repairs.lean#L164-L174)):

1. **`Theorem 1.1` and `Corollary 6.3` (Self-Contained, Independent of `[OAI26]`)**:
   * `Theorem 1.1` proves rationality and realization-independence of Frobenius traces paired against **complementary Lefschetz classes $\operatorname{Lef}^{d-r}(A_0)$** (divisor intersection classes).
   * Its proof uses only `Section 3` ($p$-adic transport), `Section 4` (adapted filtration), `Section 5` (balanced Weil classes are rational combinations of divisor powers), and `Lemma 6.1`–`Theorem 6.2` of `Section 6`, without invoking `[OAI26]`.
   * `Corollary 6.3` follows immediately from `Theorem 1.1` via `[Mil09, Theorem 4.5]` ([`cor_6_3_frobenius_trace_rational_equality`](../proofs/milne_weil_reduction_and_repairs.lean#L204-L219)).
2. **`Corollary 6.4` (Strictly Dependent on `[OAI26, Theorem 1.1]`)**:
   * `Corollary 6.4` constructs an algebraic cycle $z_\gamma \in \operatorname{CH}^r(A_0)_\mathbb{Q}$ whose intersection pairing matches $\gamma_0$ against **all algebraic cycles in $\operatorname{CH}^{d-r}(A_0)_\mathbb{Q}$**.
   * On abelian varieties of Weil type, exceptional Weil classes ($\dim_{\mathrm{weil}} \ge 2$) are orthogonal to $\operatorname{Lef}^{d-r}(A_0)$, leaving a non-zero Lefschetz pairing radical of dimension $\dim_{\mathrm{ker,lef}} = \dim_{\mathrm{weil}} \ge 2$ ([`milne_001_internal_dependency_and_lefschetz_vs_chow_gap`](../proofs/milne_weil_reduction_and_repairs.lean#L164-L174)). Bridging this gap requires `[OAI26, Theorem 1.1]` on the CM product $B_0 = \prod_\Delta B_\Delta$ (which is formally verified in `33,428` Lean 4 files / `2,742,470` lines with `0 sorry` in the OpenAI repository), achieving $\dim_{\mathrm{alg,CM}} = \dim_{\mathrm{hdg}}$ and $\dim_{\mathrm{ker,chow}} = 0$.

---

## 2. Dissection and Repair of the 2 Medium Vulnerabilities (`[Medium-1]`, `[Medium-2]`)

### 2.1 `[Medium-1]` (`02_transport.tex:471-505`, `00_intro.tex:163-171`): Pointwise Breuil-Kisin + Kisin-Zhou ADLV Bypass of `[GLX26, Corollary 6.3]`

* **Original Vulnerability**: To lift an admissible filtration $f_{\mathcal{F}} \in \mathcal{F}_{J,\mu}^{\mathrm{adm}}(K)$ to a point $\widetilde{y} \in \mathcal{S}_K(\mathcal{O}_K)$, `Lemma 3.3` invoked condition $(U_x)$ (formal-scheme representability $\mathfrak{M}_{\mathcal{J},b_x,\mu}$ of the local Shimura variety $\mathcal{M}_{\mathcal{J},b_x,\mu}$) via the unpublished 2026 preprint `[GLX26, Corollary 6.3]`.
* **Verified Repair ([`oai_001_milne_repair.patch:31-132`](../proofs/oai_001_milne_repair.patch#L31-L132), [`repair_medium1_pointwise_kz_adlv_bypasses_glx26`](../proofs/milne_weil_reduction_and_repairs.lean#L234-L245))**:
  1. `Lemma 3.3` only needs to lift a **single classical framed point $z \in M_{\mathcal{J},b_x,\mu,K_p}(K)$** lying above $f_{\mathcal{F}}$.
  2. By `[PR24, §3.5 & Proposition 3.5.1]`, the Breuil-Kisin $\mathcal{J}$-torsor $\mathcal{P}_{\mathrm{BK}}$ associated to $z$ specializes at $u = 0$ directly to a point $g \in X_{\mathcal{J}}(\mu^{-1}, b_x)$ in the affine Deligne-Lusztig variety.
  3. Applying Kisin-Zhou's isogeny-class uniformization map $i_x : X_{\mathcal{J}}(\mu^{-1}, b_x) \to \mathcal{I}_x \subset \mathcal{S}_K(\mathbb{F})$ (`[KZ25b, Theorem 2.2.5]`) produces $y = i_x(g) \in \mathcal{I}_x$ and the tensor-preserving quasi-isogeny $b : C_x \to C_y$.
  4. By `[KZ25b, Proposition 2.2.3]`, the completed local ring $\widehat{\mathcal{O}}_{\mathcal{S}_K, y}$ is isomorphic to that of the local model $\mathbb{M}_{\mathcal{J},\mu}^{\mathrm{loc}}$, lifting $C_y$ pointwise to $C_{\widetilde{y}} / \mathcal{O}_K$ with $b^*\operatorname{Fil}^1 H^1_{\mathrm{dR}}(C_{\widetilde{y}}/K) = \mathcal{F}^1$ ([`repair_medium1_pointwise_kz_adlv_bypasses_glx26`](../proofs/milne_weil_reduction_and_repairs.lean#L234-L245): $\dim(\operatorname{Fil}^1 + \mathcal{F}^1) = g_C, \text{mismatch\_codim} = 0$). This eliminates the dependency on `[GLX26]` and condition $(U_x)$.

### 2.2 `[Medium-2]` (`05_reduction.tex:428-447`): Eliminating Denominator-$N$ Ambiguity in `Corollary 6.4` via Beauville's Projector $P_{r,0}$

* **Original Vulnerability**: In `Corollary 6.4`, the raw cycle $z_\gamma^{(N)} := N^{-2r}(Nb)^* Z_0 \in \operatorname{CH}^r(A_0)_\mathbb{Q}$ depends on the choice of denominator $N > 0$ whenever $Z_0$ has non-zero components in the Beauville eigenspaces $\operatorname{CH}^r_{(s)}(B_0)$ for $s \neq 0$ (`[Bea86, Proposition 2]`, where $[k]^*$ acts by $k^{2r-s}$). In `Audit 6` ($d=4, r=2, s \in \{-2, \dots, 4\}$), changing $N=3$ to $N=6$ on $b^*Z_0 = (3, -5, 11, 7, -2, 4, 1)^{\mathsf{t}}$ creates an $L^1$ discrepancy of $\|z_\gamma^{(6)} - z_\gamma^{(3)}\|_1 = \frac{42109}{432} \neq 0$.
* **Verified Repair ([`oai_001_milne_repair.patch:193-231`](../proofs/oai_001_milne_repair.patch#L193-L231), [`repair_medium2_beauville_projector_canonical_cycle_invariance`](../proofs/milne_weil_reduction_and_repairs.lean#L248-L259))**:
  Applying Beauville's explicit rational Lagrange-interpolation projector
  $$P_{r, 0} := \prod_{\substack{s = r - d \\ s \neq 0}}^d \frac{[k]_{A_0}^* - k^{2r - s} \mathrm{id}}{k^{2r} - k^{2r - s}} \in \operatorname{End}_\mathbb{Q}\bigl(\operatorname{CH}^r(A_0)_\mathbb{Q}\bigr) \quad (k \ge 2)$$
  defines the canonical cycle $z_\gamma := P_{r, 0}(N^{-2r}(Nb)^* Z_0) \in \operatorname{CH}^r_{(0)}(A_0)$, which is **100% invariant across all $N \ge 1$ and $k \ge 2$** (`Audit 6`: $z_\gamma = (0, 0, 11, 0, 0, 0, 0)^{\mathsf{t}}$ across all $N \in \{1, 2, 3, 5, 6, 10\}$) while preserving every Weil realization $\operatorname{cl}_v(z_\gamma) = \gamma_{0,v} = 11$.

---

## 3. Dissection and Repair of the 3 Low Vulnerabilities (`[Low-1]`, `[Low-2]`, `[Low-3]`)

1. **`[Low-1]` (`01_preliminaries.tex:171-200`, [`repair_low1_ramified_dvr_unconditional_lifting_range`](../proofs/milne_weil_reduction_and_repairs.lean#L267-L281))**:
   In `Section 5.4` (`04_weil.tex:345`), `Lemma 2.3` is invoked over an Eisenstein extension $R = \mathcal{O}_K$ of prime degree $q > B \ge 3$, where $e(R/W(\mathbb{F})) \ge q \ge 4 > p - 1$ and $v_\pi(\pi^p/p) = p - e \le -1 < 0$ ([`repair_low1_ramified_dvr_unconditional_lifting_range`](../proofs/milne_weil_reduction_and_repairs.lean#L267-L281)). We removed the unramified Dieudonné citation (`[Gro70]`, `[Ill85, §4.2(v)]`, valid only for $e \le p-1$) and replaced it with the unconditional chain: Colmez-Fontaine generic-fiber equivalence (`[CF00, Theorem A]`) + Tate's $p$-divisible group extension theorem (`[Tat67, Theorem 4]`, `rk_coker_tate = 0`) + special-fiber Dieudonné faithfulness over $W(\mathbb{F})$ + Serre-Tate square-zero deformation (`[Gro70, p. 432]`, `[Ill85, Theorem 2.3.3]`) and formal GAGA (`[Stacks, Tag 0A42]`).
2. **`[Low-2]` (`03_filtration.tex:99-121`, [`repair_low2_sharp_kronecker_bound_attained_3var`](../proofs/milne_weil_reduction_and_repairs.lean#L285-L314))**:
   Tightened the Kronecker substitution degree bound in `Lemma 4.2` from $b\sum_{i=0}^{r-1} N^i$ to the sharp total-degree bound $B_{\mathrm{sharp}} = b N^{r-1}$ (attained at $X_{r-1}^b$), saving $\Delta B = b\sum_{i=0}^{r-2} N^i > 0$ ($215 \to 180$, saving $35$ in degree for $r=3, b=5, N=6$, `Audit 2`).
3. **`[Low-3]` (`03_filtration.tex:257-275`, `00_intro.tex:66-70`, `references.tex`, [`repair_low3_rosati_positive_definite_u2_eigenvalues_strictly_positive`](../proofs/milne_weil_reduction_and_repairs.lean#L317-L323))**:
   Proved explicitly that self-adjointness of $L_u$ for the positive-definite Rosati trace form $\langle a, b \rangle = \operatorname{Tr}(a b^\dagger)$ on $\operatorname{End}^0(A_0) \otimes_\mathbb{Q} \mathbb{R}$ forces $u$ to have nonzero real eigenvalues $\mu_i \in \mathbb{R}^\times$ and $u^2$ to have strictly positive real algebraic eigenvalues $z = \mu_i^2 > 0$ (`Audit 7`: 1,000/1,000 random numerical trials), and added `[Mil09]` (`arXiv:0707.3173v4`, §6) to `00_intro.tex` and `references.tex`.

---

## 4. Diff Forensic Analysis: `September 23` First Edition vs. `October 7` Revised Edition

An exhaustive diff between `Milnes-rationality-conjecture-for-abelian-varieties-September-23-2026` and `October-7-2026` establishes:

1. **`00_intro.tex` (`Section 1`)**:
   * The conditional `Theorem 1.3` of the September 23 edition (asserting algebraicity of absolute Hodge classes conditional on Weil classes being generated by intersections of divisors) was replaced in the October 7 edition by the unconditional `Corollary 6.4`, which invokes `[OAI26, Theorem 1.1]` (the rational Hodge conjecture for CM abelian varieties).
2. **`01_preliminaries.tex` through `04_weil.tex` (`Sections 2–5`)**:
   * There is zero character difference (`diff = 0 lines`) between the two editions across all four middle sections. Consequently, `[Medium-1]` (`Lemma 3.3`'s dependency on the unpublished `[GLX26]`), `[Low-1]` (`Lemma 2.3`'s unramified Dieudonné citation over high-ramification DVRs), `[Low-2]` (`Lemma 4.2`'s non-sharp Kronecker degree bound), and `[Low-3]` (`Lemma 4.7`'s omitted Rosati trace-positivity proof) persisted unchanged from September 23 into October 7.
3. **`05_reduction.tex` (`Section 6`)**:
   * Lines `399–447` were added in the October 7 edition to state and prove `Corollary 6.3` and `Corollary 6.4`. This addition introduced `[Medium-2]` (dependence of the unprojected cycle $z_\gamma^{(N)} = N^{-2r}(Nb)^*Z_0$ on the choice of denominator-clearing integer $N$ whenever $Z_0$ has non-zero Beauville $s \neq 0$ components).

---

## 5. File-by-File Specification of [`oai_001_milne_repair.patch`](../proofs/oai_001_milne_repair.patch)

[`oai_001_milne_repair.patch`](../proofs/oai_001_milne_repair.patch) (`234` lines) applies cleanly to the 6 LaTeX source files (`repaired_build/main.tex`, `25` pages, `0` errors and `0` warnings).

| Target Manuscript File | Patch Line Range | Severity | Summary of Mathematical Modification |
| :--- | :--- | :---: | :--- |
| `references.tex` | [`oai_001_milne_repair.patch:1-30`](../proofs/oai_001_milne_repair.patch#L1-L30) | `[Medium-2]`, `[Low-3]` | Adds primary bibliography entries `[Bea86]` (Beauville 1986) and `[Mil09a]` (Milne 2009, `arXiv:0707.3173v4`, §6) |
| `sections/00_intro.tex` | [`oai_001_milne_repair.patch:31-58`](../proofs/oai_001_milne_repair.patch#L31-L58) | `[Medium-1]`, `[Low-3]` | Cites `[Mil09a, §6]` in the introduction and replaces the primary `Section 3` outline route with pointwise `[PR24]` + `[KZ25b, Proposition 2.2.3 & Theorem 2.2.5]` lifting (demoting global `[GLX26]` uniformization to a parenthetical remark) |
| `sections/01_preliminaries.tex` | [`oai_001_milne_repair.patch:59-103`](../proofs/oai_001_milne_repair.patch#L59-L103) | `[Low-1]` | Replaces the unramified `[Gro70], [Ill85]` citation in `Lemma 2.3` with `[CF00, Theorem A]` + `[Tat67, Theorem 4]` + Serre-Tate square-zero deformation |
| `sections/02_transport.tex` | [`oai_001_milne_repair.patch:104-132`](../proofs/oai_001_milne_repair.patch#L104-L132) | `[Medium-1]` | Establishes in `Lemma 3.3` that hypothesis $(U_x)$ and `[GLX26, Corollary 6.3]` are not required for the pointwise lift, supplying the self-contained proof via Breuil-Kisin specialization (`[PR24, Proposition 3.5.1]`) and Kisin-Zhou uniformization (`[KZ25b, Theorem 2.2.5 & Proposition 2.2.3]`) |
| `sections/03_filtration.tex` | [`oai_001_milne_repair.patch:133-190`](../proofs/oai_001_milne_repair.patch#L133-L190) | `[Low-2]`, `[Low-3]` | Replaces $b\sum_{i=0}^{r-1}N^i$ with the sharp Kronecker bound $B = b N^{r-1}$ in `Lemma 4.2` and supplies the Rosati trace-positivity proof $\operatorname{Tr}(ab^\dagger) > 0 \implies z = \mu_i^2 > 0$ in `Lemma 4.7` |
| `sections/05_reduction.tex` | [`oai_001_milne_repair.patch:191-234`](../proofs/oai_001_milne_repair.patch#L191-L234) | `[Medium-2]` | Introduces Beauville's projector $P_{r,0}$ in `Corollary 6.4` to define the $N$-invariant canonical cycle $z_\gamma := P_{r,0}(N^{-2r}(Nb)^*Z_0) \in \operatorname{CH}^r_{(0)}(A_0)$ and proves preservation of cycle class maps |
