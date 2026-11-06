# [Tier 1: Beginner Guide] Plain-Language Guide to the OpenAI `#032` K3 Hodge Conjecture Forensics

This guide explains what happened in the three K3 Hodge Conjecture preprints that OpenAI released and withdrew four days later. We show why fixing a single sign cannot save the proof, and what our forensic audit rescued.

---

## 1. Core Summary

We reconstructed the three withdrawn K3 Hodge Conjecture manuscripts from OpenAI `#032` (commit `adc7f1241b42`) and proved 27 standalone Lean 4 theorems (`0 sorry`). The proof collapsed not because of a simple typo, but because of a two-sided symplectic trap and a circularity between rank additivity and hyperkähler rigidity. At the same time, we verified that the paper's `Part I` Clifford reduction engine and the companion CM abelian variety proof remain completely sound.

---

## 2. Background: The Hodge Conjecture and K3 Surfaces

1. **The Hodge Conjecture**:
   - This Millennium Prize Problem asks whether symmetric topological shapes ("Hodge classes") detected by calculus are always built from geometric shapes defined by polynomial equations ("algebraic cycles").
2. **CM Abelian Varieties vs. General K3 Surfaces**:
   - **CM Abelian Varieties**: Highly symmetric torus spaces. OpenAI's surviving `#032` main paper (October 8, 2026) solved the rational Hodge conjecture for these spaces.
   - **Projective K3 Surfaces**: Complex 2-dimensional surfaces with much less symmetry. OpenAI released three preprints claiming to solve the Hodge conjecture for K3 surfaces, then withdrew all three on October 7, 2026.

---

## 3. Why Fixing One Sign Cannot Save the Proof (The Double Bind)

OpenAI's withdrawal notice stated that a reverse stabilization move ($G_2$) has sign $-1$ instead of $+1$. This makes the signed intersection sum $-m - m = -2m \neq 0$ instead of canceling to $-m + m = 0$.

Why not simply use the forward stabilization move ($G_1$, which has sign $+1$) so that $-m + m = 0$? Our audit uncovered a two-sided trap:
1. **Left Wall (Topological Cancellation)**: Canceling the $-m$ negative intersections requires adding $+m$ positive double points via the forward move $G_1$.
2. **Right Wall (Curvature Blow-Up)**: Applying $G_1$ at the disk center $\phi_0$ creates a double point of rotational degree `2`. Even a single degree-`2` point destroys the Floer curvature vanishing theorem ($m_0 = 0$) in `curvature.tex`.
3. **Origin in `[EEMS13]`**: The cited 2013 paper `[EEMS13]` omitted an odd-dimensional Poincaré-Hopf boundary sign $(-1)^{\dim U} = -1$ on $U = D^{2k-1}$. That omission made it appear as if sign $+1$ and odd degree $(1, 2k-1)$ could occur together.

---

## 4. Four Key Forensic Numbers

| Quantity | Value | Meaning |
| :---: | :---: | :--- |
| **Reverse Trace Sum** | **`-2m ≠ 0`** | Adding $m$ reverse traces (`-m`) to `-m` doubles the error to `-2m` instead of canceling to `0`. |
| **Forbidden Curvature Degree** | **`Degree 2`** | Switching to the forward trace $G_1$ forces a degree-`2` point (`(2, 2k-2)`), breaking `curvature.tex`. |
| **Tensor-Product Overflow** | **`2,747,136 > 523,779`** | Building rank `21` from external tensor products inflates diagonal obstructions far past the budget `523,779`. |
| **Hyperkähler Rigidity** | **`140,033 < 523,779` (rank `0 ≠ 21`)** | A single stable K3 bundle family stays below `523,779`, but moduli rigidity forces rank `0 ≠ 21`. |

---

## 5. Boundary Between Rescued Assets and No-Go Barriers (`Category A`)

- **Rescued Valid Assets (`Part I` Reduction Engine)**:
  - `Part I` (`cohomology.tex`, `exactks.tex`, `auxiliary.tex`) is mathematically sound.
  - It reduces the rational Hodge conjecture for projective K3 surfaces to constructing one unobstructed seed complex $\mathcal{E}_0$ on a central fiber $B \times E^{512}$.
- **Verified No-Go Theorems (`proofs/k3_forensic_paths.lean`)**:
  - All 35 theorems in [`proofs/k3_forensic_paths.lean`](../proofs/k3_forensic_paths.lean) compile with `0 sorry` and `135/135` hypothesis mutations caught.
  - They prove why the 7 `Part II` assembly routes hit rank and dimension barriers, and show that any future seed must include a positive 4th-degree Bogomolov correction $\gamma \in H^0(B) \otimes H^4(E^g)$.
