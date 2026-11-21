# 02. Core Principles in Five Acts: Algebraic Derivation of the $m \approx \sqrt{X}$ Chain

The signature parameter of Levent Alpöge and Claude's proof, the theta-lift chain length $m \approx \sqrt{X}$, follows directly from forcing the $m$-node Chebyshev discretization error $O(X \log m / m)$ below the critical-line target $O(X^{1/2+\varepsilon})$, yielding $m \ge X^{1 - \theta - \varepsilon}$ at $\theta = 1/2$ (`src/Formalism/ZetaNonvanishingChebyshevWeights.lean:26-35`, `PASS`).
This volume walks through all five acts at an undergraduate calculus and linear-algebra level alongside exact prime computations up to $X = 10,000$ ([prime_lab_results.json](../data/prime_lab_results.json)).

---

## Act 1. Smoothing the Prime Staircase into the Residual $G_z(x)$

The raw von Mangoldt sum $\psi(x) = \sum_{n \le x} \Lambda(n)$ (assigning $\log p$ to prime powers $n = p^k$) jumps discontinuously at every prime power, resisting finite-node quadrature.

Starting at `src/Formalism/StatementOC.lean:11-13`, the proof integrates once against the Cesaro-type kernel $(x/n - 1)$ to form the continuous sum $S_z(x)$ and subtracts the pole main term to isolate the residual $G_z(x)$:

$$S_z(x) = \sum_{1 \le n \le \lfloor x \rfloor} \Lambda(n)\left(\frac{x}{n} - 1\right)$$

$$G_z(x) = S_z(x) - x \log x + (1 + \gamma) x$$

Here $\gamma \approx 0.57721566$ denotes the Euler-Mascheroni constant. Applying the Mellin transform identity (`MellinSgen`, `src/Formalism/DefsOC.lean:12-19`) gives

$$\int_1^\infty S_z(x)\, x^{-s-1}\,dx = -\frac{\zeta'(s)}{\zeta(s)} \cdot \frac{1}{s(s-1)} \qquad (\mathrm{Re}(s) > 1)$$

The quadratic denominator $s(s-1)$ damps high-ordinate zeros, while $x\log x - (1+\gamma)x$ cancels the double residue at $s = 1$. Consequently, the growth exponent of $|G_z(x)|$ matches the supremum $\theta = \sup \mathrm{Re}(\rho)$ of nontrivial zeta zeros.

![Figure 2. Smoothed Prime Residual vs Off-Line Zero Blowup](../figures/fig2_residual_vs_fake_zero_en.png)

### Empirical Check of $G_z(x)$ on True Primes ([prime_intuition_lab.py](../scripts/prime_intuition_lab.py))

| Cutoff $X$ | Chain $m = \sqrt{X}$ | Smoothed Sum $S_z(X)$ | Main Trend $X\log X - (1+\gamma)X$ | Residual $G_z(X)$ | Ratio $\lvert G_z(X) \rvert / \sqrt{X}$ | Off-Line Scale ($X^{0.75}$) |
| ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| `100` | `10` | `304.5171` | `302.7955` | `+1.7217` | `0.17217` | `31.62` |
| `400` | `20` | `1,767.4809` | `1,765.6996` | `+1.7813` | `0.08907` | `89.44` |
| `1,600` | `40` | `9,282.1486` | `9,280.8692` | `+1.2794` | `0.03199` | `252.98` |
| `3,600` | `60` | `23,802.2198` | `23,801.3045` | `+0.9153` | `0.01526` | `464.76` |
| `10,000` | `100` | `76,332.9964` | `76,331.2471` | **`+1.7493`** | **`0.01749`** | **`1,000.00`** |

> **Act 1 Summary**: At $X = 10,000$, $S_z(10000)$ reaches `76,332.9964`, yet after subtracting the main term the residual $G_z(10000)$ is `+1.7493`, sitting a factor of `570` below the hypothetical $\mathrm{Re}(\rho) = 0.75$ scale (`1,000.00`). Bounding $|G_z(x)| \lesssim x^{1/2+\varepsilon}$ as $x \to \infty$ implies RH.

---

## Act 2. Landau Positivity and the Zero-Order Identity (`OCAvg`)

Because a single $G_z(x)$ changes sign, Mellin inversion alone cannot rule out complex off-line zeros without positivity. In `src/Formalism/StatementOC.lean:17-51` and `src/Formalism/DefsOC.lean:26-47`, the proof pairs $\zeta(s)$ against families of real quadratic Dirichlet characters $\chi_i$:

$$G_z(x) - G_{\chi_i}(x) = \sum_{n \le x} \Lambda(n)\bigl(1 - \chi_i(n)\bigr)\left(\frac{x}{n} - 1\right) - x\log x + C_{\chi_i} x$$

Because $\chi_i(n) \in \{-1, 0, +1\}$, every Dirichlet coefficient satisfies $1 - \chi_i(n) \ge 0$. Under this nonnegativity, **Landau's theorem on Dirichlet integrals (`LandauEq`)** converts a two-sided bound $|\sum_i w_i (G_z(x) - G_{\chi_i}(x))| \le C x^\theta$ ($w_i > 0$) into an exact zero-multiplicity identity (`OrderLogDeriv`) across the entire half-plane $\mathrm{Re}(s) > \theta$:

$$\left(\sum_i w_i\right) \cdot \mathrm{ord}_s(\zeta) = \sum_i w_i \cdot \mathrm{ord}_s\bigl(L(\cdot, \chi_i)\bigr)$$

> **Act 2 Summary**: Coefficient positivity $1 - \chi_i(n) \ge 0$ forces any hypothetical zero of $\zeta(s)$ in $\mathrm{Re}(s) > \theta$ to be a simultaneous common zero of every participating $L(s, \chi_i)$ in the weighted family.

---

## Act 3. Three-Line Derivation of $m = \sqrt{X}$ (`ZetaNonvanishingChebyshevWeights`)

The exact algebra behind $m \approx \sqrt{X}$ appears in `src/Formalism/ZetaNonvanishingChebyshevWeights.lean:9-35`.

To replace continuous Chebyshev smoothing $G_{\text{cheb}}(x)$ by a finite determinant functional, the proof samples $m$ **Chebyshev nodes** $c_{m,j} = \sin^2\bigl(\frac{(2j-1)\pi}{4m}\bigr)$. By `ChebyshevWeightApproximation` (lines `26-28`), the quadrature discrepancy between the $m$-node average and the continuous integral is bounded by

$$\left|\text{chebAvg}(m, x, G_z) - G_{\text{cheb}}(x)\right| \le K \cdot \frac{x (1 + \log m)}{m}$$

To establish zero-freeness on $\mathrm{Re}(s) > \theta$, this quadrature error must fall below $x^{\theta + \varepsilon}$. Requiring $\frac{x \log m}{m} \lesssim x^{\theta + \varepsilon}$ yields the lower bound on $m$ stated at line `33` (`x ^ (1 - θ - ε) ≤ m`):

$$\frac{x}{m} \le x^{\theta + \varepsilon} \quad \Longleftrightarrow \quad m \ge x^{1 - \theta - \varepsilon}$$

Substituting the critical-line target $\theta = \frac{1}{2}$ fixes the exponent immediately:

$$m \ge x^{1 - 1/2 - \varepsilon} = x^{1/2 - \varepsilon} \approx \sqrt{x}$$

> **Act 3 Summary**: Each theta lift along the definite unitary chain $U(X_0) \to U(X_1) \to \dots \to U(X_m)$ increments the node multiplicity of the positive determinant functional $W(\cdot) \ge 0$ by `1`, so pushing $x/m$ down to $x^{1/2}$ uniquely demands $m \approx \sqrt{x}$ serial lifts.

---

## Act 4. Why Naive Iteration Stalls at `2/3` and How Seesaw Normalization Clears It

![Figure 3. Naive 2/3 Lift Barrier vs Seesaw-Normalized Balance](../figures/fig3_lift_cost_barrier_en.png)

Acquiring multiplicity $m$ via $m$ serial lifts introduces an competing arithmetic cost: discriminant and level denominators grow at each step.
- Under a naive step-by-step product bound, the cumulative log-denominator penalty after $m$ lifts scales quadratically like $m^2$ (dashed brown curve in Figure 3). Balancing quadrature error $X/m$ against $m^2$ gives $X/m \approx m^2 \implies m \approx X^{1/3}$, stalling at $1 - \theta = 1/3$, namely **$\theta = 2/3$** (`remark.pdf` p. 4 item 14).
- Three mechanisms flatten the effective loss to linear scale $\sim m$ (solid green curve in Figure 3), unlocking $m = \sqrt{X}$:
    1. **Rallis Seesaw & Inner-Product Duality**: Dualizes iterated theta periods into Bessel periods on the opposite seesaw partner, isolating character dependence (`src/Formalism/ThetaLiftIndependence/FinalThetaLiftAMFKIndep.lean:1-15`).
    2. **CM Jacobi Theta Inverse-Norm Identity**: Evaluates inverse $L^2$-norms of complex-multiplication theta functions in closed form via $\vartheta_2$ (`src/Formalism/PeriodIntegrals/ThetaNormCM.lean:30-40`).
    3. **Companion Lattice Rank Normalization & $\mathrm{GL}_5$ Six-Fold Cover**: Embeds the chain into a base lattice of large rank $k \asymp x^{9/2+10\varepsilon}$ so that dividing by $k$ sends the normalized quadratic error $-C m^2 L / k$ to `0`, while a $\mathrm{GL}_5$ six-fold metaplectic form absorbs cubic/sextic Gauss sums via iterated Parseval and relative trace formulas.

---

## Act 5. Progression-Free Behrend Sieve and the Cyclotomic Tower (`BehrendSets` · `VWin`)

The final stage bounds the unramified Shafarevich-Tate cohomology length (`shaLen`) of $H^1(\mathcal{O}_E[1/\ell], \mathbb{Q}_\ell/\mathbb{Z}_\ell(-e))$ for resonant twists that survive character averaging.

The automorphic window predicate `VWin` (`Ct = 401`, `src/Development/AutomorphicArithmetic/CharacterBoxes/ExistsPageN.lean:12-50`) requires the weighted sum of `shaLen` up to twist $e < \lfloor x^{401} \rfloor$ to stay below $\sqrt{\exp(x^\varepsilon)}$.
To prevent linear resonances among cyclotomic layers $e$, `src/Formalism/BehrendSets/Statement.lean:48-71` constructs dense sets $T \subseteq [1, N]$ free of nontrivial solutions to $\alpha x_1 + \beta x_2 + \gamma x_3 = 0$ ($\alpha+\beta+\gamma=0$, $|\alpha|,|\beta|,|\gamma| \le K$):

$$|T| \ge N \cdot \exp\left(-C \sqrt{\log N \cdot \log(K+1)}\right)$$

In [prime_intuition_lab.py](../scripts/prime_intuition_lab.py), extracting the base-`5` sphere shell ($r^2 = 5$) below $N = 500$ yields the 12-element set `{7, 11, 27, 35, 51, 55, 127, 135, 175, 251, 255, 275}` with `0` three-term arithmetic progressions (`ap_violations = 0`).
Combining `WindowTwo` (at most `2` elements per progression window) with odd Stickelberger/Kato bounds and even $\mathrm{GSp}_4 \cdot U(3)$ Hida patching closes `VWin`, `everyCharacter`, and `riemannHypothesis`.

---

## Bridge to Volumes 03 and 05: Three Specialist Terms Translated

Before moving to the specialist equation audit in [05_Specialist_Referee_and_Equation_Audit.md](./05_Specialist_Referee_and_Equation_Audit.md), keep three translations in mind:
- **Arakelov / DVR Cokernel Length (`StatementLA`)**: The prime-by-prime algebraic measurement of denominator loss; bounding integer divisibility prime by prime is equivalent to bounding the length of a quotient lattice $L / L^\vee$.
- **Siegel-Weil Mass Ratio (`D* / d*`)**: The exact volume-and-index ratio between the bottom rank-$k$ lattice and top rank-$(k-1+m)$ lattice where the $-C m^2 L / k$ cancellation occurs.
- **Mirror Parity (`minus` vs `plus` / Vandiver Wing)**: Complex conjugation splits cohomology into an odd half (`minus`, killed by classical Stickelberger elements) and an even half (`plus`, where Stickelberger acts as `0`, forcing the proof to import $\mathrm{GSp}_4$ and $U(3)$ deformation patching).
