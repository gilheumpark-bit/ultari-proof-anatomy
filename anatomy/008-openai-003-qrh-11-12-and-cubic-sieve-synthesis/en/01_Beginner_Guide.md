# [Tier 1: Beginner Guide] Five Mysteries in the OpenAI `#003` QRH Ecosystem

In [`Case 001`](../../001-openai-003-qrh/README.md) and [`Case 005`](../../005-openai-003-qrh-mathematician-referee-audit/README.md), we audited the constant margins inside OpenAI's $\text{Re}(s) > 7/8 = 0.875$ proof. Stepping back to inspect the entire `#003` repository (`6,856` `.lean` files across `DirichletL`, `SiegelZeros`, `CubicGauss`, `CubicGram`, and `CubicMoment`) alongside follow-up papers by Alex Kontorovich and Baiying Liu (`arXiv:2610.12234`) reveals five structural mysteries.

---

## 1. Five Ecosystem Mysteries Solved

1. **Why Does `ShortDraft` Prove $\text{Re}(s) > 23/24$ When the Paper Claims $11/12$?**
   - Both `paper.tex` and `paper2.tex` state a warm-up zero-free strip of $\text{Re}(s) > 11/12 = 22/24$ (width $1/12$).
   - Yet `ShortDraft.DirichletTarget` in `ZeroFreeRegion.lean` only proves $\text{Re}(s) > 23/24$ (width $1/24$, half as wide).
   - We prove in [`thm_01_shortdraft_fixed_reserve_and_23_24_exponent`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L19-L33) and [`thm_04_canonical_descent_scale_budget_unlocks_arbitrary_theta`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L70-L85) that hardcoding `reserve = 1/20` locked $\vartheta = 1/10$, whereas switching to `CanonicalDescentScale` unlocks $\frac{11}{12} + \varepsilon$.
2. **Why Is the 30-File Sharp Cubic Large Sieve (`CubicGauss/`) Left Unimported?**
   - Inside `lean/OAI/NumberTheory/CubicGauss/`, OpenAI proved Heath-Brown's cubic large sieve with the sharp exponent $2/3$ (`0 sorry`).
   - However, zero files in `DirichletL` import `CubicGauss` ([`thm_15_unimported_cubic_gauss_vs_bundled_cubic_gram_gap`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L289-L303)).
   - Using `Nat` induction in [`thm_31_sieve_iter_mobius_invariants_by_induction`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L36-L69) through [`thm_33_sieve_iter_strictly_beats_openai_sieve_exponent_all_n`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L92-L107), we prove the exact closed-form iteration $\tilde{\alpha}_n = \frac{4\cdot 3^n - 2^{n+1}}{3\cdot 3^n - 2^{n+1}}$ for all $n \in \mathbb{N}$.
3. **Why Did `Case 005` and Baiying Liu Both Hit $\mathbb{Q}(\sqrt{921})$?**
   - Both our `Case 005` saddle $\beta_{\mathrm{SOS}}(0) = \frac{6843 - 7\sqrt{921}}{7578}$ and Liu's optimum $B_{\mathrm{Liu}} = \frac{1507 - 2\sqrt{921}}{1653}$ involve $\sqrt{921}$.
   - We prove in [`thm_16_shared_critical_quadratic_288_588_185_and_count_2_3`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L18-L34), [`thm_19_exact_gap_between_fixed_scale_saddle_and_liu_optimum`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L77-L90), and [`thm_34_zsqrt921_norm_and_critical_quadratic_root`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L130-L137) through [`thm_35_zsqrt921_liu_rationalization_and_case005_gap`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L144-L157) that both come from the quadratic $288\delta_c^2 - 588\delta_c + 185 = 0$ where the sextic sieve count hits $2/3$.
4. **How Do We Break Past Liu's Farkas Barrier ($0.874957$)?**
   - Liu showed that keeping the three bundled inequalities unchanged blocks any improvement below $0.874957$ ([`thm_21_farkas_dual_weights_and_closure_obstruction`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L116-L132)).
   - Unbundling those terms lowers the bound to $\frac{4103}{4896} \approx 0.8380$, $\frac{4069}{4896} \approx 0.8311$, and $\frac{71}{108} \approx 0.6574$ when combined with `CubicGauss` ([`thm_24_parametric_unbundled_farkas_shift_theorem`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L179-L201) to [`thm_28_ten_tier_qrh_boundary_hierarchy`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L258-L275)).
5. **How Do `Case 001`, `Case 005`, and `Case 008` Lock Together (`Theorems 36–45`)?**
   - `Case 001`'s margin $\frac{215}{3264}$ scales by the $2/3$ sieve weight to `Case 005`'s gain $\frac{7}{8} - \frac{4069}{4896} = \frac{215}{4896}$ ([`thm_36_trilogy_denominator_bridge_3264_and_4896`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L167-L178), [`thm_37_case001_margin_215_3264_drives_case005_4069_4896`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L185-L204)).
   - Meanwhile, the `CubicGauss` fixed point $\alpha^* = \frac{4}{3}$ and the `coordR` pole $\beta_{\mathrm{pole}} = \frac{2}{3}$ satisfy $\alpha^* + \beta_{\mathrm{pole}} = 2$ ([`thm_39_eisenstein_pole_duality_cubic_gauss_vs_coordR`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L232-L242) to [`thm_42_gap_between_71_108_and_7_12_equals_3264_over_44064`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L284-L292)).

---

## 2. Scope Boundary (`Ultari`): Proved Components vs. Open Gap to $\beta = 1/2$ (`Category A`)

- **Proved & Ready for Assembly ($\frac{23}{24} \to \frac{71}{108} \approx 0.6574$)**:
  - Combining existing `0 sorry` modules (`CanonicalDescentScale`, unbundled `CubicGram`, Stickelberger $k_\infty = -6$, and `CubicGauss`) lowers the boundary from $\frac{23}{24}$ to $\frac{71}{108} \approx 0.6574$ and removes the `coordR` pole at $\frac{2}{3}$ ([`thm_40_cubic_gauss_plus_stickelberger_crosses_two_thirds`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L249-L257), [`thm_41_case001_gauss_branch_vanishing_drives_case005_pole_shift`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L264-L277)).
- **Remaining Open Analytic Problem ($\frac{71}{108} \to \frac{1}{2}$)**:
  - Crossing the final $\frac{17}{108} \approx 0.1574$ energy gap to $\beta = \frac{1}{2}$ ([`thm_44_six_stage_trilogy_telescoping_decomposition`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L316-L331)) requires proving the conditional saving $\Delta_{\mathrm{hybrid}} = \frac{14}{33}$ via off-diagonal spectral cancellation, which remains an open problem.

---

## 3. Ten-Tier QRH Boundary Progression

| Tier | Milestone / Source | Exact Boundary $\beta$ | Decimal | Strip Width $1 - \beta$ |
| :--- | :--- | :--- | :--- | :--- |
| 1 | OpenAI `ShortDraft` (`ZeroFreeRegion.lean`) | $23/24$ | $0.95833333$ | $1/24 \approx 0.04167$ ($1.00\times$) |
| 2 | OpenAI `paper2.tex` & `AlexKontorovich/quasi-rh` | $11/12$ | $0.91666667$ | $1/12 \approx 0.08333$ ($2.00\times$) |
| 3 | OpenAI `SevenEighths.lean` Baseline | $7/8$ | $0.87500000$ | $1/8 = 0.12500$ ($3.00\times$) |
| 4 | `Case 005` Fixed-Scale Global SOS Saddle | $(6843 - 7\sqrt{921})/7578$ | $0.87497547$ | $0.12502453$ ($3.0006\times$) |
| 5 | Baiying Liu Rational Perturbation (`arXiv:2610.12234`) | $34999/40000$ | $0.87497500$ | $5001/40000 = 0.125025$ |
| 6 | Baiying Liu 3-Face $\mathbb{Q}(\sqrt{921})$ Optimum | $(1507 - 2\sqrt{921})/1653$ | $0.87495707$ | $0.12504293$ ($3.0010\times$) |
| 7 | Xu-Sang $\delta = 0$ Amplification (`arXiv:2610.15291`) | $8748867/10000000$ | $0.87488670$ | $0.12511330$ ($3.0027\times$) |
| 8 | `Case 005` 2-Term Unbundled Gram + Stickelberger | $4103/4896$ | $0.83803105$ | $793/4896 \approx 0.16197$ ($3.89\times$) |
| 9 | `Case 005` 3-Term Unbundled Gram + Stickelberger | $4069/4896$ | $0.83108660$ | $827/4896 \approx 0.16891$ ($4.05\times$) |
| 10 | `Case 005` + `Case 008` Sharp `CubicGauss` Floor | $71/108$ | $0.65740741$ | $37/108 \approx 0.34259$ ($8.22\times$) |
