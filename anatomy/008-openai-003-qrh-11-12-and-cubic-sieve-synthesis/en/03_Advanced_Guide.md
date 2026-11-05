# Advanced Guide: Exact Algebraic Proofs, Möbius Conjugacy, and Farkas Duality

## 1. Exact Möbius Linearization of the Heath-Brown Cubic Large Sieve Recurrence (`Theorems 9–14`)
In `lean/OAI/NumberTheory/CubicGauss/Recurrence.lean:350–370`, OpenAI defines the exponent recurrence for the cubic large sieve over $\mathbb{Z}[\omega]$:
$$\text{sieveThreshold}(\alpha) = \frac{6\alpha - 5}{3\alpha - 1}, \qquad \text{sieveStep}(\alpha) = \frac{6\alpha - 4}{3\alpha - 1}.$$
In `LargeSieve.lean:75`, OpenAI bounds $\text{sieveStep}(\alpha)$ from above by the linearized geometric recurrence:
$$\text{sieveStep}(\alpha) - \frac{4}{3} \le \frac{2}{3}\left(\alpha - \frac{4}{3}\right) \implies \alpha_n = \frac{4}{3} + \left(\frac{2}{3}\right)^{n+1}.$$
In [`thm_10_cubic_gauss_quadratic_slack_and_attracting_fixed_point`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L182-L202), we prove that for $\alpha = p/q > 4/3$ with $\delta = 3p - 4q > 0$ and $D = 3p - q$, the exact slack discarded by this linearization is strictly positive and quadratic in $\delta$:
$$\frac{2}{3}\left(\alpha - \frac{4}{3}\right) - \left(\text{sieveStep}(\alpha) - \frac{4}{3}\right) = \frac{2(3p - 4q)^2}{9q(3p - q)} = \frac{2\delta^2}{9qD} > 0.$$
Moreover, since the fixed-point equation $\text{sieveStep}(\alpha) = \alpha \iff 3\alpha^2 - 7\alpha + 4 = (3\alpha - 4)(\alpha - 1) = 0$ has roots at $\alpha^* = 4/3$ and $\alpha^{**} = 1$, we introduce the Möbius coordinate $u(\alpha) = \frac{\alpha - 4/3}{\alpha - 1} = \frac{3p - 4q}{3(p - q)}$ in [`thm_11_mobius_conjugacy_exact_closed_form_solution`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L206-L224) and prove that for $\alpha' = p'/q' = \frac{6p - 4q}{3p - q}$:
$$3p' - 4q' = 3(6p - 4q) - 4(3p - q) = 6p - 8q = 2(3p - 4q), \qquad p' - q' = (6p - 4q) - (3p - q) = 3(p - q),$$
which implies the **exact linear conjugacy** $u(\text{sieveStep}(\alpha)) = \frac{2}{3}\,u(\alpha)$ with zero approximation error! Starting from $\tilde{\alpha}_0 = 2$ ($u_0 = 2/3$), this gives $u_n = (2/3)^{n+1}$ and the exact closed-form solution ([`thm_12_nonlinear_vs_linearized_sieve_iterates_comparison`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L229-L247)):
$$\tilde{\alpha}_n = \frac{\frac{4}{3} - \left(\frac{2}{3}\right)^{n+1}}{1 - \left(\frac{2}{3}\right)^{n+1}} = \frac{4}{3} + \frac{\frac{1}{3}\left(\frac{2}{3}\right)^{n+1}}{1 - \left(\frac{2}{3}\right)^{n+1}}, \qquad \lim_{n\to\infty} \frac{\tilde{\alpha}_n - 4/3}{\alpha_n - 4/3} = \frac{1}{3}.$$

| Step $n$ | Exact Nonlinear Iterate $\tilde{\alpha}_n$ | Excess $\tilde{\alpha}_n - 4/3$ | OpenAI Linearized $\alpha_n = 4/3 + (2/3)^{n+1}$ | Excess $\alpha_n - 4/3$ |
| :--- | :--- | :--- | :--- | :--- |
| $n = 0$ | $2$ | $2/3 \approx 0.66667$ | $2$ | $2/3 \approx 0.66667$ |
| $n = 1$ | $8/5 = 1.60000$ | $4/15 \approx 0.26667$ | $16/9 \approx 1.77778$ | $4/9 \approx 0.44444$ |
| $n = 2$ | $28/19 \approx 1.47368$ | $8/57 \approx 0.14035$ | $44/27 \approx 1.62963$ | $8/27 \approx 0.29630$ |
| $n = 3$ | $92/65 \approx 1.41538$ | $16/195 \approx 0.08205$ | $124/81 \approx 1.53086$ | $16/81 \approx 0.19753$ |

## 2. Universal $(M, \ell)$-Cancellation in Farkas Duality and $\mathbb{Q}(\sqrt{921})$ Rationalization (`Theorems 16–23`)
In Baiying Liu's `arXiv:2610.12234` (`geometry/V2Optimization.lean:211–243`), the three scalar majorant faces in terms of $M = x + y$ and $\ell$ are:
$$\text{Face}_0(M, \ell) = \frac{5}{6} + \frac{M}{12} - \frac{\ell}{6}, \quad \text{Face}_K(M, \ell) = \frac{1}{3} + \frac{7M}{12} + \frac{\ell}{3}, \quad \text{Face}_H(\delta_c, M, \ell) = 1 + \delta_c - \frac{1 + \delta_c}{2}M + \delta_c\,\ell.$$
In [`thm_21_farkas_dual_weights_and_closure_obstruction`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L116-L132), we prove that for **any** $\delta_c$, the Farkas multipliers:
$$w_0(\delta_c) = \frac{4 + 18\delta_c}{9 + 18\delta_c}, \qquad w_K(\delta_c) = \frac{2}{9 + 18\delta_c}, \qquad w_H(\delta_c) = \frac{3}{9 + 18\delta_c}$$
satisfy $w_0 + w_K + w_H = 1$ and annihilate both $M$ and $\ell$ identically:
$$\frac{(4 + 18\delta_c) + 7(2) - 6(1 + \delta_c)(3)}{12(9 + 18\delta_c)}M = 0, \qquad \frac{-(4 + 18\delta_c) + 2(2) + 6\delta_c(3)}{6(9 + 18\delta_c)}\ell = 0,$$
leaving the pure constant term $\frac{7 + 18\delta_c}{9 + 18\delta_c}$. Substituting $\delta_c = \frac{49 - \sqrt{921}}{48}$ ($s = \sqrt{921}$) and rationalizing the denominator $(219 - 3s)(219 + 3s) = 39672 = 24 \times 1653$ yields:
$$\frac{7 + 18\delta_c}{9 + 18\delta_c} = \frac{203 - 3s}{219 - 3s} = \frac{(203 - 3s)(219 + 3s)}{219^2 - 9 \times 921} = \frac{36168 - 48s}{39672} = \frac{1507 - 2\sqrt{921}}{1653} = B_{\mathrm{Liu}}.$$

## 3. Parametric Unbundled Farkas Theorem (`Theorems 24–30`)
When the three faces are improved by non-negative savings $(\Delta_0, \Delta_K, \Delta_H)$:
$$\text{Face}_0(M, \ell) - \Delta_0 \le B, \qquad \text{Face}_K(M, \ell) - \Delta_K \le B, \qquad \text{Face}_H(\delta_c, M, \ell) - \Delta_H \le B,$$
contracting with $(w_0, w_K, w_H)$ immediately yields the exact parametric Farkas shift ([`thm_24_parametric_unbundled_farkas_shift_theorem`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L179-L201)):
$$B^*(\Delta_0, \Delta_K, \Delta_H) = B_{\mathrm{Liu}} - \left(w_0\,\Delta_0 + w_K\,\Delta_K + w_H\,\Delta_H\right).$$
- Since $w_0 = \frac{163 - 3\sqrt{921}}{183 - 3\sqrt{921}} \approx 0.68736 > \frac{2}{3}$ ([`thm_25_xu_sang_delta0_sixth_moment_breaks_liu_obstruction`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L206-L219)), sixth-moment amplification at $\delta = 0$ ($\Delta_0 > 0$, `Xu–Sang arXiv:2610.15291`) pushes $B^*$ down to $0.8748867 < B_{\mathrm{Liu}}$.
- Unbundling the cubic Gram operator ($\Delta_K \in \{1/30, 8/45\}$) and shifting $z_{\mathrm{high}} = 1/6 \to 7/20$ ($\Delta d_0 = 1/10$ in `Face_H`) drops the non-exceptional floor to $\frac{4103}{4896} \approx 0.83803$ and $\frac{4069}{4896} \approx 0.83109$ ([`thm_26_unbundled_gram_and_stickelberger_shift_breaks_face_H`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L224-L237)).
- Wiring the sharp $2/3$ cubic large sieve from `CubicGauss/LargeSieve.lean` into the sextic count envelope ($R_{\mathrm{eff}} = 7/9 > 2/3$) lowers the Path-A floor to $\frac{71}{108} \approx 0.65741$ ([`thm_27_connecting_cubic_gauss_2_3_sieve_to_path_A_71_108`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L242-L253)).
