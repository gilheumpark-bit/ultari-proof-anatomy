# Intermediate Guide: Collision Stability, Contracting Local Kernels (`-11/125`), and Binary Tree Transfers (`-7/20`)

## 1. Architecture of the 9-Section Paper vs. the Two Lean Engines

OpenAI's preprint `preprints/the-additive-indecomposability-of-the-primes-September-24-2026/build/` is organized into 9 mathematical sections (`6,072` lines of LaTeX across `sections/01-introduction.tex` through `09-conclusion.tex`, plus `552` lines in `paper.tex`, `glyph-mappings.tex`, and `references.bib`, [`thm_38_paper_9_sections_to_lean_subsystem_mapping`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L332-L356)):

| Section File | Lines | Mathematical Role | Corresponding `OAI/NumberTheory/Ostmann/` Subdirectory |
| :--- | :---: | :--- | :--- |
| `01-introduction.tex` | `141` | Main theorem & overview of the 2-stage contradiction | `Complete.lean`, `Main.lean`, `Result.lean`, `Corollaries.lean` |
| `02-preliminaries.tex` | `292` | Finite-factor CRT, Elsholtz window, collision stability | `FiniteCRT.lean`, `FiniteFactor.lean`, `Preliminaries/` |
| `03-quadratic.tex` | `1,076` | Quadratic character large sieve & exceptional zero control | `Quadratic/`, `QuadraticCenter/` |
| `04-characters.tex` | `1,182` | Higher character Cauchy-Schwarz trees & anchor codes | `Characters/` |
| `05-supply.tex` | `772` | Nonsparse Fourier supply (`-11/125`) & Montgomery $Q^7$ zero-density | `Supply/`, `ZeroDensity/` |
| `06-tree.tex` | `683` | Binary tree transfer recurrences & $3^r$ diagram moment | `Tree/` |
| `07-construction.tex` | `784` | Multi-scale schedule ($z = k^4, r = 2^k$) & cell selection | `Construction/` |
| `08-arithmetic.tex` | `756` | Moving frequency cutoffs & covariance estimates | `Arithmetic/` |
| `09-conclusion.tex` | `386` | Bad overlap arrangements (`-3/4`) & `-7/20 log r` contradiction | `Conclusion/` |

---

## 2. Section 2: Finite-Factor CRT, Shifted Sieve, and the `[1/3, 2/3]` Balanced Density Band

Suppose $A + B =_{\mathrm{cofinite}} \mathcal{P}$, so there exists a cutoff $N$ above which every element of $A + B$ is prime and every prime $p > N$ lies in $A + B$.

### 2.1 Ruling Out a Finite Summand (`Lemma 2.2`, `FiniteCRT.lean`, `FiniteFactor.lean`)
If $A$ is finite with $\max A \le M$ and contains two distinct elements $a_0 \neq a_1$, define $f : A \to A$ by swapping $a_0 \leftrightarrow a_1$ and fixing all other $a \in A$. Choose distinct primes $q_a = p_{M + a} > M \ge a$ for each $a \in A$, and use the Chinese Remainder Theorem to find an integer $r$ with $\gcd(r, \prod_{a \in A} q_a) = 1$ such that:
$$r \equiv q_a + a - f(a) \pmod{q_a} \quad (\forall a \in A).$$
By Dirichlet's theorem, there exists a prime $p > M + \max_a q_a + N$ with $p \equiv r \pmod{\prod q_a}$. Since $p \in A + B$, we can write $p = a + b$ for some $a \in A, b \in B$. Then the shifted element $s = f(a) + b \in A + B$ satisfies ([`thm_06_finite_summand_crt_dirichlet_composite_witness`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L136-L159)):
$$s = p - a + f(a) \equiv r - a + f(a) \equiv q_a \equiv 0 \pmod{q_a}, \qquad s > p - M > q_a \ge 2.$$
Hence $s = k_{\mathrm{mult}} q_a$ with $k_{\mathrm{mult}} \ge 2$ is composite, contradicting that all sufficiently large elements of $A + B$ are prime!

### 2.2 Elsholtz Counting Window and Collision Stability (`Lemma 2.1`, `Lemma 2.4`, `Lemma 2.5`)
When both $A$ and $B$ are infinite, sifting by a prime product up to $Q^{1/(10j)}$ with $Q = \sqrt{X}/(\log X)^{b+1}$ ($b = 4 \implies b+1 = 5$, [`thm_07_shifted_sieve_modulus_exponent_and_elsholtz_window`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L160-L176)) forces the counting functions $A(Y), B(Y)$ into Elsholtz's square-root window:
$$\frac{\sqrt{Y}}{(\log Y)^3} \ll A(Y), B(Y) \ll \sqrt{Y}(\log Y)^2.$$
For each prime $p \le Q$, let $A_p, B_p \subseteq \mathbb{Z}/p\mathbb{Z}$ be the tail residue classes of $A$ and $B$. Since $(A_p + B_p) \cap \{0\} = \emptyset$, $|A_p| + |B_p| \le p$, and writing $\sigma_p = |A_p|/p \in (0, 1)$, Selberg's sieve weights produce the local reciprocal sum $\frac{1}{\sigma_p} + \frac{1}{1 - \sigma_p} - 4$. By the exact polynomial identity ([`thm_08_collision_stability_reciprocal_penalty_identity`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L177-L188)):
$$\frac{1}{\sigma_p} + \frac{1}{1 - \sigma_p} - 4 = \frac{(2\sigma_p - 1)^2}{\sigma_p(1 - \sigma_p)} \ge 0.$$
Furthermore, whenever $\sigma_p \notin (1/3, 2/3)$ (i.e. $3a \le p$ or $3a \ge 2p$), clearing denominators gives ([`thm_09_unbalanced_density_penalty_lower_bound_one_half`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L189-L203)):
$$2(2a - p)^2 - a(p - a) = (p - 3a)(2p - 3a) \ge 0 \implies \frac{(2\sigma_p - 1)^2}{\sigma_p(1 - \sigma_p)} \ge \frac{1}{2}.$$
Therefore, unbalanced primes outside $[1/3, 2/3]$ can have only bounded harmonic sum $\sum_{\sigma_p \notin [1/3, 2/3]} 1/p = O(1)$.

---

## 3. Section 5: Nonsparse Fourier Supply and the `-11/125` Contraction Exponent

On the doubly-logarithmic prime band $\mathcal{B}_L = \{p : \frac{1}{20}L \le \log\log p \le \frac{9}{10}L\}$, Mertens' theorem gives total harmonic mass $(\frac{9}{10} - \frac{1}{20})L = \frac{17}{20}L + o(1) = 0.85L + o(1)$ ([`thm_12_harmonic_band_mertens_budget_and_sparse_complement`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L240-L261)). Let $\gamma_p$ measure the non-concentration (flatness) of the non-zero Fourier modes of $A_p \pmod p$. Proposition 5.1 (`Supply/NonsparseSupply.lean`) states that the subset of balanced primes in $\mathcal{B}_L$ with $\gamma_p \ge \delta_0$ has harmonic mass at least $\frac{3}{20}L = 0.15L$.

**Proof by Contradiction**:
1. Suppose the nonsparse balanced primes have harmonic sum $< \frac{3}{20}L$. Since unbalanced primes contribute $O(1)$, the complementary **sparse balanced primes** $\mathcal{S} \subseteq \mathcal{B}_L$ carry harmonic mass at least $(\frac{17}{20} - \frac{3}{20})L - o(L) = \frac{7}{10}L - o(L) \ge \frac{17}{25}L = 0.68L$ (with a strict Mertens reserve of $\frac{7}{10} - \frac{17}{25} = \frac{1}{50} = 0.02$, [`thm_12_harmonic_band_mertens_budget_and_sparse_complement`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L240-L261)).
2. For each $p \in \mathcal{S}$, construct a rank-2 local kernel with projection weight $t_0 = \frac{17}{20} = 0.85$. On the polydisc $|u|, |v| \le R = \frac{103}{100} = 1.03$, the lower-right block norm is at most $R t_0 = \frac{1751}{2000} = 0.8755 < \frac{19}{20} = 0.95$ ([`thm_13_local_transfer_polydisc_contraction_margin`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L262-L281)), while at $u = v = 1$ the leading scalar contraction slope is $2t_0 = \frac{17}{10} = 1.7$, leaving a $\frac{1}{10}$ margin above the Lemma 5.2 contraction rate $c_{\mathrm{loc}} = \frac{8}{5} = 1.6$ (`s_p(1, 1) \le 1 - \frac{8}{5p}`, [`thm_14_scalar_block_leading_slope_and_lemma_5_2_contraction`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L282-L302)).
3. Multiplying over $p \in \mathcal{S}$ with $H = \sum_{p \in \mathcal{S}} 1/p \ge \frac{17}{25}L$ gives an upper bound scaling as $\exp(-\frac{8}{5}H)\sqrt{z} \le \exp(-\frac{136}{125}L)\sqrt{z}$, whereas prime coverage in $[X/2, X]$ (controlled unconditionally via Montgomery's zero-density bound at $T = Q^5 \implies Q^2 T = Q^7$, tail $Q^{-8}$, and deleting at most 1 Landau-Page exceptional prime, [`thm_16_montgomery_zero_density_Q7_and_tail_Q_minus_8`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L324-L339), [`thm_18_page_exceptional_zero_single_prime_deletion_budget`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L355-L371)) gives a lower bound scaling as $z \exp(-L)$. Comparing the two forces ([`thm_15_supply_contradiction_exponent_11_125`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L303-L323)):
   $$\sqrt{z} \le \exp\left(\left(1 - \frac{8}{5}\cdot\frac{17}{25}\right)L + o(L)\right) = \exp\left(-\frac{11}{125}L + o(L)\right) = \exp(-0.088L + o(L)),$$
   which is impossible for $z \ge e^{-o(L)}$!

---

## 4. Sections 6–9: Binary Tree Transfers (`+2/5 log r`) vs. Bad Permutations (`-3/4 log r`)

With the nonsparse Fourier supply ($\ge \frac{3}{20}L$) established, Sections 6–9 construct a depth-$k$ binary transfer tree with $r_j = 2^j$ active blocks at level $j \in \{0, \dots, k-1\}$ ($r = 2^k$, scale $z = k^4$, even bulk size $m = 2\lfloor zL/2\rfloor$, [`thm_25_section_7_schedule_scales_and_even_bulk_size`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L117-L131)):
- **Exact Inductive Tree Budget (`thm_21`–`thm_26`)**: By structural induction on $k$ (`induction k` in [`thm_21_dyadic_tree_leaf_sum_by_induction`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L30-L50) and [`thm_22_weighted_dyadic_level_sum_by_induction`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L51-L79)),
  $$\sum_{j=0}^{k-1} 2^j = 2^k - 1 = r - 1, \qquad \sum_{j=0}^{k-1} j 2^j = (k - 2)2^k + 2,$$
  so the step frequency gaps $\Delta_j = r_j(B_D + B_z \log z + \frac{2}{5}\log r_j)m$ sum to a total frequency budget $E_k$ whose leading $k$-dependent term per unit of $rm$ is $+\frac{2}{5}\log r = +0.40\log r$ ([`thm_26_frequency_budget_exact_closed_form_all_k`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L132-L150)).
- **Bad Overlap Permutations (`thm_28`–`thm_30`)**: When two leaf permutations $(a, b)$ form a "bad arrangement", the overlap graph on $r$ blocks has $t$ connected components with total merge deficit $\sum_{i=1}^t (a_i - 1) = r - t < r/4$, which forces $t > \frac{3}{4}r$ ([`thm_28_overlap_graph_component_merge_bound`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L168-L179)). Multinomial counting over $m$ coordinates forces the fraction of bad arrangements to decay at rate $-\frac{3}{4}\log r = -0.75\log r$ per unit of $rm$ ([`thm_29_bad_arrangement_multinomial_decay_three_quarters`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L180-L193)).
- **The Final Contradiction (`thm_30`–`thm_35`)**: Adding the frequency budget rate $+\frac{2}{5}\log r$ and the bad-arrangement decay rate $-\frac{3}{4}\log r$ gives the exact net rate in `Scales.lean:85-87` (`finalRate`) and `09-conclusion.tex:367` ([`thm_30_net_contradiction_rate_minus_seven_twentieths`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L194-L212)):
  $$\frac{2}{5} - \frac{3}{4} = \frac{8 - 15}{20} = -\frac{7}{20} = -0.35 < 0.$$
  Since $\log r = k\log 2$ grows linearly in $k$ while $\log z = 4\log k$ grows logarithmically, taking $k$ large enough forces $|\eta_k|^2 \le \exp(-(2B+1)rm)$, contradicting the tree recurrence lower bound $|\eta_k|^2 \ge \exp(-2Brm)$ ([`thm_34_linear_k_log_2_dominates_logarithmic_4_log_k`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L264-L277), [`thm_35_final_amplitude_upper_vs_lower_contradiction`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L278-L295)).
