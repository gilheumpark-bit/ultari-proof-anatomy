# [Tier 1: Beginner Guide] Why the Prime Numbers Cannot Be Split into Two Sumsets (`A + B`)

## 1. What Is Ostmann's Inverse Goldbach Conjecture?

Goldbach's conjecture asks whether every even number is the sum of two primes ($\mathcal{P} + \mathcal{P}$). In 1950, Hans-Heinrich Ostmann asked the inverse question ([`Erdős Problem #431`](https://www.erdosproblems.com/431)):

> **Can the set of prime numbers $\mathcal{P} = \{2, 3, 5, 7, 11, \dots\}$ coincide (up to finitely many exceptions) with a sumset $A + B = \{a + b : a \in A, b \in B\}$ where $|A| \ge 2$ and $|B| \ge 2$?**

If $A = \{0, 2\}$ is finite, then every $b \in B$ must generate twin primes $(b, b+2)$, which fails modulo $3$. Whether two infinite sets $A$ and $B$ could be tuned to produce only primes remained open for 76 years. In OpenAI `#013` (*The additive indecomposability of the primes*, September 24, 2026), OpenAI proved unconditionally that no such sets $A$ and $B$ exist:

$$\forall A, B \subseteq \mathbb{N},\quad |A| \ge 2 \;\wedge\; |B| \ge 2 \implies \bigl((A + B) \mathbin{\triangle} \mathcal{P}\bigr)\text{ is infinite.}$$

---

## 2. Why Does `OAI/NumberTheory/Ostmann/` Have `7,716` Files (`609,199` Lines)?

`Ostmann/` is the single largest folder in `openai/math`, containing `7,716` `.lean` files (`5.18%` of the entire repository, [`thm_37_engine_b_jacobsthal_and_prime_gaps_reuse_accounting`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L310-L324)) for a 9-section LaTeX paper ([`thm_38_paper_9_sections_to_lean_subsystem_mapping`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L325-L342)).

Our import-graph audit uncovered a **Twin-Engine Duplication** ([`thm_01_ostmann_directory_inclusion_exclusion_partition`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L20-L43)):
1. **Two Identical Challenge Entrypoints**: `OstmannComplete.lean` and `OstmannPrimes.lean` state the exact same theorem and follow from each other in 3 lines of logic ([`thm_05_complete_vs_main_logical_bridge_equivalence`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L106-L135)).
2. **Engine A ([`Complete.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Complete.lean#L1) cone, `3,165` files)**: A top-down 15-step discharge spine ([`thm_36_engine_a_15_step_conditional_discharge_spine`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L296-L309)) with only 1 external `OAI` import.
3. **Engine B ([`Main.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Main.lean#L1) cone, `4,175` files)**: A bottom-up 4-provider consumer ([`thm_04_external_dependency_asymmetry_1_vs_18`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L85-L105)) importing 18 external files from `#021` (`Jacobsthal`) and `#026` (`PrimeGaps`).
4. **Tiny Shared Core (`5` files, `372` lines) & `381` Fossils**: The two engines share only 5 elementary files ([`thm_02_shared_intersection_five_files_accounting`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L44-L60)), while `381` files (`39,517` lines) are unreachable fossils ([`thm_03_unreachable_orphan_381_files_accounting`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L61-L84)).

```mermaid
flowchart TD
    subgraph Shared["Shared Elementary Core (5 files, 372 lines - 0.065%)"]
        S["Defs.lean (46) + Statement.lean (2) + Endpoint.lean (190)\nFiniteCRT.lean (68) + FiniteFactor.lean (66)"]
    end
    subgraph EngineA["Engine A: Complete.lean Cone (3,165 files, 266,820 lines)"]
        A1["Top-Down 15-Hypothesis Discharge Spine\nInverseGoldbach.lean -> ... -> MainWithoutQuadraticSieve.lean"]
        A2["1 External OAI Import (PrimeGaps.SiegelBounds)\nComparatorChallenges/OstmannComplete.lean"]
        A1 --> A2
    end
    subgraph EngineB["Engine B: Main.lean Cone (4,175 files, 303,234 lines)"]
        B1["Bottom-Up Actual* 4-Provider Consumer\nActualFourComparisonConsumer.lean (Cs = 17, Ccov = 17)"]
        B2["18 External OAI Imports (15 Jacobsthal #021 + 3 PrimeGaps #026)\nComparatorChallenges/OstmannPrimes.lean"]
        B1 --> B2
    end
    subgraph Orphans["Unreachable Fossil Files (381 files, 39,517 lines)"]
        O1["Arithmetic (264) + Construction (86) + Others (29)\n+ All.lean (152 lines) + PaperMain.lean (25 lines)"]
    end
    S --> EngineA
    S --> EngineB
```

---

## 3. Why Classical Prime Sieves Failed for 76 Years (The Parity Barrier and Phase Cancellation)

Classical sieves (Eratosthenes, Selberg) only use the local zero-avoidance condition $a + b \not\equiv 0 \pmod p$ at each prime $p$. By themselves, such congruences hit the **Cauchy-Davenport barrier**:
- For example, at $p = 7$, choosing $A_7 = \{1, 2, 3\}$ and $B_7 = \{1, 2, 3\}$ gives two sets that each occupy nearly half of all residues ($3/7 \approx 1/2$), yet their sumset $A_7 + B_7 = \{2, 3, 4, 5, 6\} \pmod 7$ completely misses $0 \pmod 7$.
- Because any pair satisfying $|A_p| + |B_p| \le p - 1$ can avoid zero modulo $p$, density bounds alone stall completely in the balanced regime $\sigma_p \approx 1/2$ (the **sieve parity barrier**).
- Worse still, at each prime $p$ the forbidden residue interval is shifted by an unknown translation phase $t_p \pmod p$ that varies erratically across primes, causing naive Fourier averages over $p$ to cancel out to zero.

---

## 4. How the Proof Works in Three Steps + Toy Numerical Hand-Calculations

OpenAI `#013` breaks through this barrier in three stages (**Finite Summand Elimination $\to$ Fourier Supply Contraction $\to$ Binary Tree Permutation Contradiction**):

1. **Step 1: Ruling Out a Finite Summand ([`FiniteCRT.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/FiniteCRT.lean#L1), Lemma 2.2) — Why Even One Finite Set Forces Composite Sums**:
   - If $A$ is finite ($|A| \ge 2$) and $B$ is infinite, let $f : A \to A$ swap two distinct elements $a_0 \leftrightarrow a_1$. By the Chinese Remainder Theorem (CRT) and Dirichlet's theorem on primes in arithmetic progressions, infinitely many primes $p = a + b$ force the swapped sum $s = f(a) + b \in A + B$ to be a proper multiple of a prime $q_a$ ([`thm_06_finite_summand_crt_dirichlet_composite_witness`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L136-L159)).
   - **Toy Hand-Calculation ($A = \{1, 3\}$)**: Set $f(1) = 3, f(3) = 1$ and pick distinct primes $q_1 = 5, q_3 = 7$. Solving the CRT system
     $$r \equiv 5 + 1 - 3 = 3 \pmod 5, \qquad r \equiv 7 + 3 - 1 = 2 \pmod 7$$
     gives $r \equiv 23 \pmod{35}$. Now take any large prime $p \equiv 23 \pmod{35}$ (for instance, $p = 163 = 35 \times 4 + 23$) written as $p = a + b$:
     - If $a = 1, b = 162$, the swapped sum is $s = f(1) + b = 3 + 162 = 165 = 5 \times 33$, which is composite (divisible by $5$)!
     - If $a = 3, b = 160$, the swapped sum is $s = f(3) + b = 1 + 160 = 161 = 7 \times 23$, which is composite (divisible by $7$)!
     Either way, $A + B$ is forced to contain composite numbers, ruling out any finite $A$.

2. **Step 2: Fourier Supply Contraction (`-11/125 < 0`) — Why Fourier Modes Cannot Stay Sparse**:
   - When both $A$ and $B$ are infinite, collision stability forces balanced density $\sigma_p = |A_p|/p \in [1/3, 2/3]$ at almost all primes, because outside that interval the reciprocal collision penalty satisfies
     $$\frac{1}{\sigma_p} + \frac{1}{1 - \sigma_p} - 4 = \frac{(2\sigma_p - 1)^2}{\sigma_p(1 - \sigma_p)} \ge \frac{1}{2}$$
     ([`thm_08_collision_stability_reciprocal_penalty_identity`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L177-L188), [`thm_09_unbalanced_density_penalty_lower_bound_one_half`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L189-L203)).
   - To eliminate the erratic prime-by-prime shift $t_p$, Dirichlet's pigeonhole principle lifts the shifts to a **Common Rational Center $h/m$**, so subtracting two congruent elements cancels $t_p$ identically: $(an - at_p) - (am - at_p) = a(n - m)$ ([`thm_56_common_center_lift_difference_cancellation`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L54-L65)).
   - If Fourier modes were sparse on $H \ge \frac{17}{25}L = 0.68L$ of the primes, the squared rank-2 transfer operator $K^2$ (with contraction rate $\kappa = \frac{8}{5}$) would force the net exponent
     $$1 - \frac{8}{5}\cdot\frac{17}{25} = \frac{125 - 136}{125} = -\frac{11}{125} < 0,$$
     contradicting the zero-density lower bound ([`thm_15_supply_contradiction_exponent_11_125`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L303-L323)).

3. **Step 3: Binary Tree vs. Bad Permutations (`2/5 - 3/4 = -7/20 < 0`) and the $2\times 2$ Cauchy Determinant**:
   - Consequently, a harmonic fraction $\ge \frac{3}{20}L = 0.15L$ ([`thm_12_harmonic_band_mertens_budget_and_sparse_complement`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L240-L261)) of primes must carry spread-out Fourier spectra.
   - Across a depth-$k$ binary tree ($r = 2^k$ leaves), the affine operator $U_u F(t) = F(u - u^2 t)$ factors collisions as $(u_1 - u_1^2 t) - (u_2 - u_2^2 t) = (u_1 - u_2)(1 - (u_1 + u_2)t)$ ([`thm_65_affine_collision_polynomial_factorization`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L243-L259)), driving frequency budget growth at $+\frac{2}{5}\log r$ ([`thm_26_frequency_budget_exact_closed_form_all_k`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L132-L150)) while bad permutations decay at $-\frac{3}{4}\log r$ ([`thm_29_bad_arrangement_multinomial_decay_three_quarters`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L180-L193)).
   - Meanwhile, accidental vanishing modulo compensation primes is blocked by the **$2\times 2$ Cauchy determinant** ([`thm_69_cauchy_2x2_determinant_polynomial_identity`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L314-L331)). Evaluating a concrete toy instance $a_1 = 2, a_2 = 1, b_1 = 4, b_2 = 5$ by hand gives:
     $$\frac{1}{(4 - 2)(5 - 1)} - \frac{1}{(4 - 1)(5 - 2)} = \frac{1}{8} - \frac{1}{9} = \frac{9 - 8}{72} = \frac{(5 - 4)(2 - 1)}{(4 - 2)(4 - 1)(5 - 2)(5 - 1)} = \frac{1}{72} \neq 0,$$
     whose numerator $(b_2 - b_1)(a_1 - a_2) \ge 1$ never vanishes for distinct ordered pairs ([`thm_70_cauchy_2x2_determinant_strict_positivity`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L332-L348)).
   - Combining the positive Cauchy lower bound with the tree permutation upper bound yields the net rate
     $$\frac{2}{5} - \frac{3}{4} = \frac{8 - 15}{20} = -\frac{7}{20} < 0,$$
     forcing an amplitude contradiction for large $k$ ([`thm_30_net_contradiction_rate_minus_seven_twentieths`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L194-L212), [`thm_35_final_amplitude_upper_vs_lower_contradiction`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L278-L295)).

---

## 5. Adversarial Verification Summary: Shortcuts, 4 Core Algebraic Engines, and Effective Thresholds (`Theorems 41–75`)

1. **Zero Hidden Dependency on `#003` (`QRH`)**: Although `05-supply.tex` Remark 5.4 mentions OpenAI `#003`, both Lean engines have `0` imports from `OAI.NumberTheory.DirichletL` ([`thm_19_qrh_003_citation_in_remark_5_4_is_strictly_optional`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L372-L386)).
2. **Eliminating Bad Permutations ($k_{\min}: 7041 \to 1040$)**: Any bad arrangement ($3r < 4t$) requires more than half of all leaves to remain unsplit size-1 components ($r < 2t_1$, [`thm_41_bad_arrangement_requires_majority_unsplit_leaves`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L381-L395)). Restoring slotwise deranged pairs ($t_1 = 0$) from the `FinalReassignments.lean` fossil makes the bad-arrangement set empty ([`thm_42_deranged_slot_pair_eliminates_bad_arrangements`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L396-L411)) and cuts the minimum binary tree depth from $k_{\min} = 7041$ down to $1040$ ([`thm_44_master_contraction_rate_and_depth_reduction`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L428-L450)), while unrounding $\kappa = 8/5 \to 33/20, 17/10$ expands the favorable prime supply by $+46.7\%$ to $+53.3\%$ ([`thm_45_supply_contraction_favorable_mass_expansion`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L451-L475)).
3. **Making Ostmann's Theorem Effective and Deriving the 4 Algebraic Engines ($L_{\mathrm{eff}}: 4,115,904 \to 640,722$, `thm_46`–`thm_75`)**: Out of `33` files mentioning `PublishedSiegelBound`, `32` merely pass the hypothesis and only `1` file (`ZeroDensity/HadamardPrimeBound.lean:48`) unpacks it ([`thm_50_effective_ostmann_counterexample_bound_master`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L552-L564)). Replacing that single bottleneck via Tatuzawa's theorem (`denom_no_root = 384,002`) with at most 1 extra deleted prime (`|D_ext| <= 3`, [`thm_47_tatuzawa_effective_single_exception_and_extended_deletion_budget`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L495-L512)) and cancelling $2^k$ in the combinatorial margin ([`thm_48_combinatorial_2k_cancellation_in_bulk_exp_margin`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L513-L527)) yields an explicit counterexample log-log threshold $L_{\mathrm{eff}} = 640,722$ ($255,983$ with widened spectator cell, down from $4,115,904$, [`thm_49_explicit_effective_loglog_threshold_bottleneck_shift`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L528-L551)). Furthermore, we prove from first principles the Section 3 Common Center congruence cancellation and Bonami 4th moment ([`thm_56_common_center_lift_difference_cancellation`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L54-L65)–[`thm_60_heath_brown_bilinear_square_defect`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L136-L152)), Section 5 rank-2 transfer kernel discriminant and squared-kernel slope $2t_0$ ([`thm_61_balanced_support_variance_quadratic_lower_bound`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L153-L187)–[`thm_64_square_kernel_trace_and_double_slope`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L224-L242)), Section 6 affine collision factorization and Vandermonde 3-way collision bound ([`thm_65_affine_collision_polynomial_factorization`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L243-L259)–[`thm_68_reciprocal_twist_involution_phase_cancellation`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L291-L313)), and Section 8 $2\times 2$ Cauchy determinant non-vanishing ([`thm_69_cauchy_2x2_determinant_polynomial_identity`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L314-L331)–[`thm_75_countermodel_cauchy_det_vanishes_when_degenerate`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L409-L420)).
