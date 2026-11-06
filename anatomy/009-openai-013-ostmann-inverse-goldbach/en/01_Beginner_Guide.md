# [Tier 1: Beginner Guide] Why the Prime Numbers Cannot Be Split into Two Sumsets (`A + B`)

## 1. What Is Ostmann's Inverse Goldbach Conjecture?

Goldbach's conjecture asks whether every even number is the sum of two primes ($\mathcal{P} + \mathcal{P}$). In 1950, Hans-Heinrich Ostmann asked the inverse question ([`Erdős Problem #431`](https://www.erdosproblems.com/431)):

> **Can the set of prime numbers $\mathcal{P} = \{2, 3, 5, 7, 11, \dots\}$ coincide (up to finitely many exceptions) with a sumset $A + B = \{a + b : a \in A, b \in B\}$ where $|A| \ge 2$ and $|B| \ge 2$?**

If $A = \{0, 2\}$ is finite, then every $b \in B$ must generate twin primes $(b, b+2)$, which fails modulo $3$. Whether two infinite sets $A$ and $B$ could be tuned to produce only primes remained open for 76 years. In OpenAI `#013` (*The additive indecomposability of the primes*, September 24, 2026), OpenAI proved unconditionally that no such sets $A$ and $B$ exist:

$$\forall A, B \subseteq \mathbb{N},\quad |A| \ge 2 \;\wedge\; |B| \ge 2 \implies \bigl((A + B) \mathbin{\triangle} \mathcal{P}\bigr)\text{ is infinite.}$$

---

## 2. Why Does `OAI/NumberTheory/Ostmann/` Have `7,716` Files (`609,199` Lines)?

`Ostmann/` is the single largest folder in `openai/math`, containing `7,716` `.lean` files (`5.18%` of the entire repository, [`thm_37_engine_b_jacobsthal_and_prime_gaps_reuse_accounting`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L317-L331)) for a 9-section LaTeX paper ([`thm_38_paper_9_sections_to_lean_subsystem_mapping`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L332-L356)).

Our import-graph audit uncovered a **Twin-Engine Duplication** ([`thm_01_ostmann_directory_inclusion_exclusion_partition`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L20-L43)):
1. **Two Identical Challenge Entrypoints**: `OstmannComplete.lean` and `OstmannPrimes.lean` state the exact same theorem and follow from each other in 3 lines of logic ([`thm_05_complete_vs_main_logical_bridge_equivalence`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L106-L135)).
2. **Engine A (`Complete.lean` cone, `3,165` files)**: A top-down 15-step discharge spine ([`thm_36_engine_a_15_step_conditional_discharge_spine`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L296-L316)) with only 1 external `OAI` import.
3. **Engine B (`Main.lean` cone, `4,175` files)**: A bottom-up 4-provider consumer ([`thm_04_external_dependency_asymmetry_1_vs_18`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L85-L105)) importing 18 external files from `#021` (`Jacobsthal`) and `#026` (`PrimeGaps`).
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

## 3. How the Proof Works in Three Steps (`Category A`)

1. **Step 1: Ruling Out a Finite Summand (`FiniteCRT.lean`, Lemma 2.2)**:
   - If $A$ is finite ($|A| \ge 2$) and $B$ is infinite, the Chinese Remainder Theorem and Dirichlet's theorem produce infinitely many primes $p = a + b$ where a shifted sum $f(a) + b \in A + B$ is divisible by a prime $q_a$ ([`thm_06_finite_summand_crt_dirichlet_composite_witness`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L136-L159)).
2. **Step 2: Fourier Supply Contraction (`-11/125 < 0`)**:
   - When both $A$ and $B$ are infinite, collision stability forces balanced density $\sigma_p \in [1/3, 2/3]$, since outside that interval the penalty $\frac{(2\sigma_p - 1)^2}{\sigma_p(1 - \sigma_p)}$ is at least $\frac{1}{2}$ ([`thm_08_collision_stability_reciprocal_penalty_identity`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L177-L188), [`thm_09_unbalanced_density_penalty_lower_bound_one_half`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L189-L203)).
   - If Fourier modes were sparse on $H \ge \frac{17}{25}L$ of the primes, a transfer operator would contract at rate $1 - \frac{8}{5}\times\frac{17}{25} = -\frac{11}{125} < 0$ ([`thm_15_supply_contradiction_exponent_11_125`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L303-L323)).
3. **Step 3: Binary Tree vs. Bad Permutations (`2/5 - 3/4 = -7/20 < 0`)**:
   - Thus a harmonic fraction $\ge \frac{3}{20}L = 0.15L$ ([`thm_12_harmonic_band_mertens_budget_and_sparse_complement`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L240-L261)) of primes has spread-out spectra.
   - Across a depth-$k$ binary tree ($r = 2^k$ leaves), the frequency budget grows at $+\frac{2}{5}\log r$ ([`thm_26_frequency_budget_exact_closed_form_all_k`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L132-L150)) while bad permutations decay at $-\frac{3}{4}\log r$ ([`thm_29_bad_arrangement_multinomial_decay_three_quarters`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L180-L193)).
   - Their net sum is $\frac{2}{5} - \frac{3}{4} = -\frac{7}{20} < 0$, forcing an amplitude contradiction for large $k$ ([`thm_30_net_contradiction_rate_minus_seven_twentieths`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L194-L212), [`thm_35_final_amplitude_upper_vs_lower_contradiction`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L278-L295)).
