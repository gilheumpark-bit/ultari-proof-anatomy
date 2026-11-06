# Case 009: OpenAI `#013` Ostmann's Inverse Goldbach Conjecture — Twin-Engine `7,716`-File Stratigraphy, `-11/125` Fourier Supply Contraction, and `-7/20 log r` Binary Tree Permutation Contradiction

This directory contains the mathematical and formal anatomy of OpenAI's `#013` flagship proof (*The additive indecomposability of the primes*, September 24, 2026, solving Hans-Heinrich Ostmann's 1950 Inverse Goldbach Conjecture / Problem 19 in `BloomErdosProblems`, [`Erdős Problem #431`](https://www.erdosproblems.com/431)): for any sets $A, B \subseteq \mathbb{N}$ with $|A|, |B| \ge 2$, the sumset $A + B = \{a + b : a \in A, b \in B\}$ cannot coincide with the set of prime numbers $\mathcal{P}$ up to finitely many exceptions ($((A + B) \mathbin{\triangle} \mathcal{P}).\text{Infinite}$).

## 4-Tier Documentation (English & Korean)

- **English (`en/`)**:
  - [01_Beginner_Guide.md](en/01_Beginner_Guide.md)
  - [02_Intermediate_Guide.md](en/02_Intermediate_Guide.md)
  - [03_Advanced_Guide.md](en/03_Advanced_Guide.md)
  - [04_Expert_Verification.md](en/04_Expert_Verification.md)
- **Korean (`ko/`)**:
  - [01_Beginner_Guide.md](ko/01_Beginner_Guide.md)
  - [02_Intermediate_Guide.md](ko/02_Intermediate_Guide.md)
  - [03_Advanced_Guide.md](ko/03_Advanced_Guide.md)
  - [04_Expert_Verification.md](ko/04_Expert_Verification.md)

## Formal Proofs & Verification Scripts (`proofs/`)

- [`ostmann_twin_engines_and_supply_contraction.lean`](proofs/ostmann_twin_engines_and_supply_contraction.lean#L1-L404): 20 theorems (`0 sorry`, 100% hypothesis mutation kill rate) covering Pillar 1 (the `7,716`-file / `609,199`-line Twin-Engine partition `3165 + 4175 - 5 + 381 = 7716`, the 3-line logical bridge between `Complete.lean` and `Main.lean`, and the finite-summand CRT + Dirichlet composite reduction) and Pillar 2 (the shifted sieve Elsholtz window, the collision stability penalty $(2\sigma_p - 1)^2/(\sigma_p(1 - \sigma_p)) \ge 1/2$, the Section 5 local Fourier contraction $1 - \frac{8}{5}\cdot\frac{17}{25} = -\frac{11}{125} = -0.088 < 0$, Montgomery zero-density $Q^2 T = Q^7$ / tail $Q^{-8}$, and strict independence from `#003` QRH).
- [`ostmann_tree_transfers_and_permutation_contradiction.lean`](proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L1-L481): 25 theorems + 2 recursive `def`s (`0 sorry`, 100% hypothesis mutation kill rate) proving all-$k$ mathematical induction (`induction k`) for binary tree leaf sums $\sum_{j=0}^{k-1} 2^j = 2^k - 1$ (`dyadicSum`) and level-weighted sums $\sum_{j=0}^{k-1} j 2^j = (k - 2)2^k + 2$ (`weightedDyadicSum`), the $+\frac{2}{5}\log r$ frequency budget vs. $-\frac{3}{4}\log r$ bad-arrangement multinomial decay yielding the net contradiction rate $\frac{2}{5} - \frac{3}{4} = -\frac{7}{20} = -0.35 < 0$, the cross-repository architecture synthesis, and the 4 sharp breakthroughs (`thm_41`–`thm_45`: unsplit-leaf majority $t_1 > r/2$, deranged slot pair $t_1 = 0 \implies \text{Bad} = \emptyset$, $4\times$ component max size bound $4a_c \le r + 4$, master contraction rate $\gamma = 1 - 2\theta - \delta_{\text{step}}$ reducing $k_{\min}: 7041 \to 1040$, and Section 5 supply expansion $\kappa = 33/20, 17/10$).
- [`verify_symbolic_ostmann.py`](proofs/verify_symbolic_ostmann.py): Deterministic SymPy verifier reproducing [`symbolic_verification_result.json`](proofs/symbolic_verification_result.json).
