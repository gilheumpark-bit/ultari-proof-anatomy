# Beginner Guide: What Else Was Hidden Inside OpenAI's Quasi-Riemann Hypothesis (`#003`)?

## 1. Beyond Local Margin Checks: Four Structural Mysteries in the QRH Ecosystem
In `Case 001` and `Case 005`, we audited the constant-margin tables and unbundled the cubic Gram operator inside OpenAI's $\text{Re}(s) > 7/8 = 0.875$ proof (`lean/OAI/NumberTheory/DirichletL/`). However, when we step back and inspect the **entire** OpenAI `#003` repository (`6,856` `.lean` files across `DirichletL`, `SiegelZeros`, `CubicGauss`, `CubicGram`, and `CubicMoment`), its two preprints (`paper.tex` at 199 pages and `paper2.tex` at 49 pages), and the follow-up formalizations by Alex Kontorovich (`AlexKontorovich/quasi-rh`) and Baiying Liu (`arXiv:2610.12234`), four deeper structural questions emerge:

1. **Why does OpenAI's preliminary Lean spine (`ShortDraft`) prove $\text{Re}(s) > 23/24 \approx 0.9583$ when the papers claim $\text{Re}(s) > 11/12 \approx 0.9167$?**
   - In both `paper.tex` (Part I) and `paper2.tex`, the introductory warm-up theorem states that no Dirichlet $L$-function vanishes for $\text{Re}(s) > 11/12 = 22/24$ (a zero-free strip of width $1/12 \approx 0.0833$).
   - Yet in OpenAI's upstream `DirichletL/RowCompletion/ZeroFreeRegion.lean`, `ShortDraft.DirichletTarget` only proves non-vanishing for $\text{Re}(s) > 23/24$ (a strip of width $1/24 \approx 0.0417$, **half** as wide as claimed!).
   - In [`thm_01_shortdraft_fixed_reserve_and_23_24_exponent`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L19-L33) and [`thm_04_canonical_descent_scale_budget_unlocks_arbitrary_theta`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L70-L85), we prove that this happened because a single descent parameter (`reserve = 1/20`, `step = 1/1000`) was hardcoded as a constant instead of a symbolic variable, forcing the mean-square radius $\vartheta$ to be fixed at $1/10$ (`(11 + 5*(1/10))/12 = 23/24`).

2. **Why is a complete 30-file, 6,252-line proof of Heath-Brown's Sharp Cubic Large Sieve (`CubicGauss/`) sitting completely unimported?**
   - Inside `lean/OAI/NumberTheory/CubicGauss/`, OpenAI formalized a `0 sorry` proof of Heath-Brown's celebrated cubic large sieve inequality with the sharp exponent $2/3$ (`4/3` in un-symmetrized form).
   - Yet **zero files** in `DirichletL` (`2,926` files) or `CubicMoment` (`3,549` files) import `CubicGauss` ([`thm_15_unimported_cubic_gauss_vs_bundled_cubic_gram_gap`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L289-L303))! Instead, the $7/8$ proof imports a weaker one-step bundled bound (`CubicGram`), leaving significant exponent savings on the table.

3. **Why did our `Case 005` and Baiying Liu's `arXiv:2610.12234` independently hit the exact same number field $\mathbb{Q}(\sqrt{921})$?**
   - Both our `Case 005` global sum-of-squares (SOS) saddle $\beta_{\mathrm{SOS}}(0) = \frac{6843 - 7\sqrt{921}}{7578} \approx 0.87497547$ and Baiying Liu's 3-face optimum $B_{\mathrm{Liu}} = \frac{1507 - 2\sqrt{921}}{1653} \approx 0.87495707$ contain $\sqrt{921}$.
   - In [`thm_16_shared_critical_quadratic_288_588_185_and_count_2_3`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L18-L34) and [`thm_19_exact_gap_between_fixed_scale_saddle_and_liu_optimum`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L77-L90), we prove that both are governed by the exact same quadratic equation $288\delta_c^2 - 588\delta_c + 185 = 0$ ($\delta_c = \frac{49 - \sqrt{921}}{48}$) where the sextic sieve count hits $2/3$, and that adjusting the scale parameters $(b, \ell)$ accounts for the exact difference $\beta_{\mathrm{SOS}}(0) - B_{\mathrm{Liu}} = \frac{1195\sqrt{921} - 36189}{4175478} \approx 1.84 \times 10^{-5}$.

4. **How do we break past Baiying Liu's Farkas dual obstruction ($0.874957$)?**
   - Liu proved that if you keep OpenAI's three bundled scalar inequalities unchanged, no choice of parameters can go below $B_{\mathrm{Liu}} \approx 0.874957$ ([`thm_21_farkas_dual_weights_and_closure_obstruction`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L116-L132)).
   - In [`thm_24_parametric_unbundled_farkas_shift_theorem`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L179-L201) through [`thm_28_ten_tier_qrh_boundary_hierarchy`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L258-L275), we prove that unbundling the three faces lowers the boundary step by step: to $0.8748867$ (`Xu–Sang`), to $\frac{4103}{4896} \approx 0.8380$ and $\frac{4069}{4896} \approx 0.8311$ (`Case 005` unbundled Gram + Stickelberger shift), and down to $\frac{71}{108} \approx 0.6574$ when combined with the sharp cubic sieve from `CubicGauss`.

## 2. Summary Table of the 10-Tier QRH Boundary Progression

| Tier | Milestone / Source | Exact Zero-Free Boundary $\beta$ | Decimal Value | Zero-Free Strip Width $1 - \beta$ |
| :--- | :--- | :--- | :--- | :--- |
| 1 | OpenAI Upstream `ShortDraft` (`ZeroFreeRegion.lean`) | $23/24$ | $0.95833333$ | $1/24 \approx 0.04167$ ($1.00\times$) |
| 2 | OpenAI `paper2.tex` & `AlexKontorovich/quasi-rh` | $11/12$ | $0.91666667$ | $1/12 \approx 0.08333$ ($2.00\times$) |
| 3 | OpenAI `SevenEighths.lean` Baseline | $7/8$ | $0.87500000$ | $1/8 = 0.12500$ ($3.00\times$) |
| 4 | `Case 005` Fixed-Scale Global SOS Saddle (`b=1/8, ℓ=1/6`) | $(6843 - 7\sqrt{921})/7578$ | $0.87497547$ | $0.12502453$ ($3.0006\times$) |
| 5 | Baiying Liu Rational Perturbation (`B_r`, `arXiv:2610.12234`) | $34999/40000$ | $0.87497500$ | $5001/40000 = 0.125025$ |
| 6 | Baiying Liu 3-Face $\mathbb{Q}(\sqrt{921})$ Optimum (`B_Liu`) | $(1507 - 2\sqrt{921})/1653$ | $0.87495707$ | $0.12504293$ ($3.0010\times$) |
| 7 | Xu–Sang $\delta = 0$ Sixth-Moment Amplification (`arXiv:2610.15291`) | $8748867/10000000$ | $0.87488670$ | $0.12511330$ ($3.0027\times$) |
| 8 | `Case 005` 2-Term Unbundled Gram + Stickelberger Shift | $4103/4896$ | $0.83803105$ | $793/4896 \approx 0.16197$ ($3.89\times$) |
| 9 | `Case 005` 3-Term Unbundled Gram + Stickelberger Shift | $4069/4896$ | $0.83108660$ | $827/4896 \approx 0.16891$ ($4.05\times$) |
| 10 | `Case 005` Path-A Sharp Cubic-Sieve Floor (`CubicGauss` Bridge) | $71/108$ | $0.65740741$ | $37/108 \approx 0.34259$ ($8.22\times$) |
