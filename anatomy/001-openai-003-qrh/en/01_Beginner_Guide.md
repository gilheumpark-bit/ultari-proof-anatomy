# [Tier 1: Beginner Guide] Plain-Language Guide to the OpenAI `#003` Quasi-Riemann Hypothesis Analysis

This guide explains **what OpenAI's `#003` proof is**, **why its code uses simplified rational bounds with large unused margins**, and **what our mathematical analysis proved**, without requiring advanced mathematics or programming background.

---

## 1. One-Sentence Summary

By analyzing the source code of OpenAI's `#003` Quasi-Riemann Hypothesis proof in Lean 4, we showed that **the authors replaced irrational square roots and separate matrix energy terms with simpler rational upper bounds (relaxing the non-exceptional square-root $Z$-exponent by $\frac{215}{3264} \approx 0.0659$, or $\frac{487}{3264} \approx 0.1492$ at pure scale)**, and we formally proved the exact algebraic equations for the key thresholds (`0.51`, `0.69`, `0.875`) in Lean 4.

---

## 2. Background: The Riemann Hypothesis vs. the Quasi-Riemann Hypothesis

1. **The Riemann Hypothesis (Mathematics' Greatest Unsolved Problem)**:
   - States that all non-trivial zeros of the Riemann zeta function (and related $L$-functions governing prime numbers) lie on the central vertical line **$0.50$** in the complex plane.
2. **The Quasi-Riemann Hypothesis (Zero-Free Strip)**:
   - Because proving that every zero lies on $0.50$ all at once is extremely difficult, a **Quasi-Riemann Hypothesis** proves that no zeros can exist near $1.00$, confining them inside a boundary $\beta < 1$ (such as $\beta = 0.875$, $0.75$, $0.69$, or $0.51$).
   - Pushing $\beta$ closer to $0.50$ yields a stronger theorem.

---

## 3. Why Did OpenAI's Proof Leave Large Unused Margins?

OpenAI's `#003` repository (`FirstProof2026Problem3`) contains 3,414 files of formal Lean 4 code. In formal theorem proving, **an inequality passes verification in the exact same way whether it holds by a margin of `0.0001` or `100`**. Conversely, manipulating irrational square roots (such as $\sqrt{16354}$) or tracking multiple separate exponent terms requires significantly more formal proof code.

To keep the formalization tractable over rational arithmetic (`Rat`), the code used three simplifications:
1. **Replacing an Irrational Stationary Point with a Nearby Fraction**: The true stationary point of the balanced exponent is an irrational number involving $\sqrt{16354}$ ($\approx 0.693319$), which the code approximated by the nearby fraction $\frac{283}{408} \approx 0.693627$.
2. **Grouping Separate Matrix Scales into a Single Upper Bound**: Keeping the three matrix energy terms separate yields an exact non-exceptional exponent difference of **$\frac{215}{3264} \approx 0.0659$** (**$\frac{487}{3264} \approx 0.1492$** at pure scale $L=1$, compared to the SOS rounding residual $\frac{49}{440640} \approx 0.0001112$), whereas the code grouped them under the single cubic Gauss upper bound $\frac{18+23\delta}{96}$.
3. **Stopping at $m=1$ Rather Than Using $m \ge 2$ Branch Vanishing**: In the $m \ge 2$ geometric tail, **6 out of 8** non-principal Gauss-sum branches vanish identically to $0$, relaxing the convergence condition from $\frac{1}{6}$ to $\frac{1}{12}$.

---

## 4. Three Key Thresholds (`0.51 / 0.69 / 0.875`) Governing the Equations

Solving the exact algebraic equations behind the rational constants in `#003` identifies three structural thresholds:

| Threshold | Value | Mathematical Meaning |
| :---: | :---: | :--- |
| **Baseline Zero-Free Boundary** | **`0.875`** ($\frac{7}{8}$) | The baseline zero-free boundary formed by combining the Gauss-sum pole ($\frac{5}{6}$) with the baseline matrix scale exponents. |
| **Stationary Point & $z_{\text{re}}=1/6$ Boundary** | **`0.6933`** ($\approx 0.69$) | The point where the $m=1$ Gauss-sum exponent condition, the sextic zeta pole ($z = \frac{1}{6}$), and the stationary point of the balanced exponent meet. |
| **Cube Floor Upper Limit** | **`0.5139`** ($\frac{37}{72}$) | The exact root where the floor exponent saving vanishes to $0$, explaining why the floor parameter $a_{\text{floor}}$ must be chosen below $\frac{37}{72}$ (e.g., at `0.51`). |

---

## 5. Formal Verification Scope vs. Future Complex-Analytic Extensions

- **Formalized Rational & Integer Theorems (`qrh_exponent_and_parameter_bounds.lean`)**:
  - All 27 theorems in `proofs/qrh_exponent_and_parameter_bounds.lean` compile in Lean 4 with zero `sorry` or custom axioms, proving the exact rational and integer identities for the floor root ($\frac{37}{72}$), the irrational stationary point formula, the exact componentwise Gram exponent differences ($\frac{215}{3264}$ and $\frac{487}{3264}$), the vanishing of 6 of 8 branches for $m \ge 2$, and the parameter budget inequalities.
- **Future Complex-Analytic Extensions**:
  - Proving the algebraic exponent and parameter inequalities does not by itself complete a complex-analytic proof of the Riemann Hypothesis. Extending all 3,414 files of the repository below $\beta = 7/8$ requires formalizing the complex Mellin residue continuation for the separated finite $m=1$ terms and interval-arithmetic bounds for finite prime norms $4 \le Q < 480$ in Lean 4.
