# [Case 015 / Tier 1 Executive Summary] Why Five 130-Year Classical Attacks on the Riemann Hypothesis Terminate at Exact Mathematical Walls

> **Target Audience**: General scientific readers, mathematicians outside analytic number theory, and researchers auditing AI mathematical reasoning
> **Parent Index**: [Main English README (`README.md`)](../README.md) | [Intermediate Guide (`en/02_`)](02_Intermediate_Math_and_Code_Guide.md) | [Expert Forensic Report (`en/03_`)](03_Expert_Forensic_and_Mathematical_Physics_Report.md) | [Verification Spec (`en/04_`)](04_Automated_Verification_and_Parser_Spec.md)

## 1. Core Takeaway: Not Lazy Hand Calculation, but Rigid Structural Obstructions

The Riemann Hypothesis asserts that every nontrivial zero of the Riemann zeta function lies on the single vertical line `Re(s) = 1/2`. Since the proof of the Prime Number Theorem in 1896, analytic number theorists have developed five classical lines of attack to squeeze, count, isolate, or capture those zeros.

A natural question in the era of automated theorem proving and large-scale numerical search is whether classical barriers (`1/100`, `3/4`, `4/7`, `3/16`, `7/64`) merely reflect human hand-calculation shortcuts, or whether they mark genuine walls built into the proof mechanisms themselves. In `Case 015`, we first recover **all** hand-calculation slack left behind in textbooks and modern Lean repositories (`PrimeNumberTheoremAnd` and `openai/math`), and then prove in **Lean 4 over `ℝ`** (`75` theorems, `0 sorry`, `0` custom axioms, `188 / 188` hypothesis mutations killed) that **each method still hits an unbreakable algebraic, logical, or variational ceiling**.

## 2. Five Classical Fronts and Their Exact Glass Ceilings

### Front 1: Pushing Leftward from the Boundary `σ = 1` (Paper 1)
- De la Vallee Poussin (1896) used `3 + 4 cos θ + cos 2θ = 2(1 + cos θ)^2 >= 0` to clear a narrow zero-free strip just left of `σ = 1`.
- Textbooks fix a convenient step ratio (`s_1 = 4δ`) to get `1/100 = 0.01`.
- Solving the exact AM-GM stationary point and switching to the integer square `(4 cos θ + 3)^2 = 17 + 24 cos θ + 8 cos 2θ >= 0` widens the constant by **+88.12%** to `(41 - 4√102)/32 ≈ 0.018812`.
- Yet even if one searches over cosine polynomials of degree `8`, `1,000`, or `10^9`, the Fejer-Riesz theorem forces `c_1 < 2 c_0`.
- That locks the constant below `(3 - 2√2)/3 ≈ 0.05719`, and dividing by the growing Weyl factor `M(|t|) = (log |t|)^{2/3}(log log |t|)^{1/3} -> ∞` forces the zero-free width back to `0` (`σ = 1 - o(1)`). Positivity of trigonometric polynomials alone can never clear even a fixed strip `σ > 0.9999`.

### Front 2: Counting Off-Line Exceptions via Zero-Density Estimates (Paper 2)
- Instead of forbidding exceptions, zero-density theorems bound how many exceptions can exist to the right of `σ`.
- Combining Ingham (1940) with Huxley (1972) creates a minimax bottleneck at `σ* = 3/4` with exponent `12/5 = 2.4`.
- After 52 years, Guth and Maynard (2024) used `3 x 3` determinant rank-defect geometry to push the inflection point down to `σ* = 7/10` with exponent `30/13 ≈ 2.3077`, shrinking prime gaps to `x^{17/30}`.
- Why does `30/13` still fall short of the Density Hypothesis (`A = 2`)? Every large-value sieve takes absolute values of off-diagonal Gram entries, destroying oscillatory phase cancellation (`ε n^2 > 0`), while `3 x 3` determinantal minors vanish identically whenever Dirichlet vectors lie in a rank-2 subspace (`S_2`).

### Front 3: Isolating the Phantom Landau-Siegel Zero (Paper 3)
- For primes in arithmetic progressions modulo `q`, a single hypothetical real zero `β_1` very close to `s = 1` controls every error term.
- Siegel (1935) proved `1 - β_1 >= C(ε) q^{-ε}`, but only by splitting the universe via the Law of Excluded Middle (`Classical.em`): either no counterexample exists anywhere, or one fixed "phantom" modulus `q_1` exists and repels all larger moduli.
- Because `q_1` is unknown, `C(ε)` cannot be computed by any algorithm from Siegel's proof.
- Goldfeld (1976) and Gross-Zagier (1986) finally made class-number bounds effective using an elliptic curve (`N_E = 5077`) of analytic rank `3`, paying an exponential-to-logarithmic rate penalty (`D^{1/2 - ε}` down to `log D`).

### Front 4: Raising the Critical-Line Zero Proportion via Mollifiers (Paper 4)
- Levinson (1974) multiplied `ζ(s)` by a Dirichlet-polynomial mollifier of length `T^{θ}` (`θ = 1/2`) to prove that more than `1/3` (`34.74%`) of zeros lie on `Re(s) = 1/2`.
- Conrey (1989) pushed `θ` to `4/7` via Kloosterman sums and optimized a degree-`17` polynomial to reach `40.81%`.
- Even if a future breakthrough allowed arbitrarily large finite `θ` (say `θ = 2` or `θ = 100`), Levinson's method **still cannot reach 100%**: integration by parts under `Q(0) = 1, Q(1) = 0` pins `J_{AB} = -1/2`, and Cauchy-Schwarz plus `coth(ω) > 1` forces the mean-square `c > 1` (`κ(θ) = 1 - ln(c)/R < 1`) for every finite `θ, R > 0`.

### Front 5: Breaking Subconvexity and Spectral Ramanujan Barriers (Paper 5)
- Burgess (1963) combined character shifts with Weil's Riemann Hypothesis over finite fields to reach `q^{3/16 + ε}`.
- Rewriting Burgess's `2r`-th moment exponent yields the exact sum-of-squares identity `E_Burgess(r) - 3/16 = (r - 2)^2 / (16 r^2)`.
- Thus `r = 2` is the **unique global minimum**, and higher moments (`r >= 3`) strictly worsen the bound because of the diagonal `+1` collision term.
- Petrow and Young (2020) broke `3/16` down to `1/6` by algebraically eliminating that `+1` collision at `r = 3`, while Kim and Sarnak (2003) reached `ϑ = 7/64` via `Sym^4` functoriality on `GL_5` (`3/26 - 7/64 = 5/832`), leaving a strictly positive finite-`k` gap `< 1/(2k)` short of `ϑ = 0`.

## 3. Summary Comparison

| Dimension | Superficial Constant Plugging | Verified Anatomy in `Case 015` |
| :--- | :--- | :--- |
| **Hand-Calculation Slack** | Copies `1/100`, `12/5`, `3/16`, `7/64` as black-box constants | Recovers `+43.59%`, `+88.12%`, and `487/3264` slack first, then proves the exact ceiling |
| **Hypothesis Hygiene** | Vulnerable to unused binders or back-solved assumptions | `188 / 188` (`100%`) `: True` mutations killed across all `75` theorems |
| **Barrier Mechanism** | Informal heuristic narrative | Machine-checked SOS identities, `HasDerivAt` invariants, and `Classical.em` dependencies |

Taken together, these `75` machine-checked theorems demonstrate that overcoming any of the five classical barriers requires genuinely new cancellation mechanisms rather than further numerical tuning of classical inequalities.
