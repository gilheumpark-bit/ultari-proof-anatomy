# [Tier 1: Beginner Guide] Plain-Language Guide to the OpenAI `#003` Quasi-Riemann Hypothesis Audit

This guide explains what OpenAI's `#003` proof does, why its Lean 4 code leaves large unused margins, and what our mathematical audit proved. No advanced background in number theory or formal verification is required.

---

## 1. Core Summary

We audited the Lean 4 source code of OpenAI `#003` (*Quasi-Riemann Hypothesis for Dirichlet $L$-functions*). The original code replaced irrational square roots and separate matrix energy terms with simpler rational upper bounds. We recovered the exact underlying equations and verified 40 standalone Lean 4 theorems with zero `sorry` placeholders.

---

## 2. Background: The Riemann Hypothesis vs. the Quasi-Riemann Hypothesis

1. **The Riemann Hypothesis**:
   - This famous unsolved problem predicts that all non-trivial zeros of the Riemann zeta function lie on the central vertical line $\text{Re}(s) = 0.50$.
   - The location of these zeros controls how evenly prime numbers are distributed.
2. **The Quasi-Riemann Hypothesis (Zero-Free Strip)**:
   - Proving that every zero lies exactly on $0.50$ remains out of reach.
   - Instead, a Quasi-Riemann Hypothesis proves that no zeros exist to the right of a boundary $\beta < 1$, such as $\beta = 0.875 = 7/8$.
   - Pushing $\beta$ closer to $0.50$ produces a stronger theorem.

---

## 3. Why Did OpenAI's Code Leave Unused Margins?

OpenAI's `#003` formalization contains `3,414` Lean 4 files in `DirichletL/` and `SiegelZeros/`. In formal theorem proving, an inequality passes verification whether it holds by a margin of `0.0001` or `100`. Handling irrational square roots like $\sqrt{16354}$ requires much more formal code than checking simple fractions.

To keep the proofs short over rational arithmetic (`Rat`), the authors used three shortcuts:
1. **Rational Proxy for an Irrational Root**: The true stationary point of the balanced exponent is an irrational number involving $\sqrt{16354}$ ($\approx 0.693319$). The code replaced it with the nearby fraction $\frac{283}{408} \approx 0.693627$.
2. **Bundling Matrix Energy Terms**: Keeping the three matrix energy terms separate gives an exponent of $\frac{14+17\delta}{96}$ (or $\frac{1}{16} + \frac{17\delta}{96}$ at $L=1$). The code bundled them under $\frac{3}{16} + \frac{23\delta}{96}$, losing $\frac{215}{3264} \approx 0.0659$ (or $\frac{487}{3264} \approx 0.1492$ at $L=1$).
3. **Stopping at $m=1$ Instead of $m \ge 2$**: In the $m \ge 2$ geometric tail, 6 of the 8 non-principal Gauss-sum branches vanish identically to zero. This relaxes the convergence threshold from $\frac{1}{6}$ to $\frac{1}{12}$.

---

## 4. Three Key Thresholds (`0.51 / 0.69 / 0.875`)

Solving the exact algebraic equations behind `#003` reveals three structural thresholds:

| Threshold | Value | Mathematical Meaning |
| :---: | :---: | :--- |
| **Baseline Zero-Free Boundary** | **`0.875`** ($\frac{7}{8}$) | The zero-free boundary proved in `#003` by combining the $\frac{5}{6}$ Gauss pole with bundled matrix bounds. |
| **Stationary Point Boundary** | **`0.6933`** ($\approx 0.69$) | The point where the $m=1$ Gauss-sum condition, the sextic pole ($z = \frac{1}{6}$), and the stationary root meet. |
| **Cube Floor Upper Limit** | **`0.5139`** ($\frac{37}{72}$) | The exact root where the floor exponent saving vanishes, requiring $a_{\text{floor}} < \frac{37}{72}$ (such as `0.51`). |

---

## 5. Verified Scope vs. Open Complex-Analytic Problems (`Category A`)

- **Verified Rational & Integer Theorems**:
  - All 40 theorems in [`proofs/qrh_exponent_and_parameter_bounds.lean`](../proofs/qrh_exponent_and_parameter_bounds.lean) and [`proofs/qrh_continuation_and_rescaling.lean`](../proofs/qrh_continuation_and_rescaling.lean) compile in Lean 4 with zero `sorry` or custom axioms.
  - They verify the floor root $\frac{37}{72}$, the irrational root formula, the Gram exponent gaps ($\frac{215}{3264}$ and $\frac{487}{3264}$), the vanishing of 6 of 8 branches for $m \ge 2$, and the prime-norm reduction $Q \ge 480 \to 112$.
- **Open Analytic Requirements**:
  - Proving these exact parameter and exponent identities (`Category A`) does not by itself complete a complex-analytic proof of the Riemann Hypothesis.
  - Pushing the full 3,414-file formalization below $\beta = 7/8$ requires formalizing complex Mellin residue continuation for the $m=1$ terms and interval bounds for small prime norms $4 \le Q < 480$.
