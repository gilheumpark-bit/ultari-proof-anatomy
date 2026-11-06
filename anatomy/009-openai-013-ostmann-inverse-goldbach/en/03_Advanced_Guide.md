# Advanced Guide: Forensic Stratigraphy of the Twin Proof Engines (`Complete.lean` vs. `Main.lean`) and All-`k` Inductive Verification

## 1. Complete Stratigraphy of `OAI/NumberTheory/Ostmann/` (`7,716` Files, `609,199` Lines)

Our graph traversal of every `import` statement across all `7,716` `.lean` files in `OAI/NumberTheory/Ostmann/` established the exact 4-way partition formalized in [`thm_01_ostmann_directory_inclusion_exclusion_partition`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L20-L43), [`thm_02_shared_intersection_five_files_accounting`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L44-L60), and [`thm_03_unreachable_orphan_381_files_accounting`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L61-L84):

| Stratum | File Count | Line Count | Share of Reachable Lines | Architectural Signature |
| :--- | :---: | :---: | :---: | :--- |
| **Engine A (`Complete.lean` cone)** | `3,165` | `266,820` | `46.84%` | Top-down 15-hypothesis conditional discharge spine (`InverseGoldbach.lean` $\to$ `Complete.lean`); `1` external `OAI` import |
| **Engine B (`Main.lean` cone)** | `4,175` | `303,234` | `53.23%` | Bottom-up `Actual*` 4-provider consumer (`ActualFourComparisonConsumer.lean`, `Cs = 17, Ccov = 17`); `18` external `OAI` imports |
| **Shared Core (`Complete ∩ Main`)** | `5` | `372` | `0.0653%` | `Defs.lean` (`46`), `Statement.lean` (`2`), `Endpoint.lean` (`190`), `FiniteCRT.lean` (`68`), `FiniteFactor.lean` (`66`) |
| **Reachable Union (`Complete ∪ Main`)** | `7,335` | `569,682` | `100.00%` | $3165 + 4175 - 5 = 7335$ files; $266820 + 303234 - 372 = 569682$ lines |
| **Unreachable Orphans (`Fossils`)** | `381` | `39,517` | — | `Arithmetic` (`264`), `Construction` (`86`), `Quadratic` (`10`), `Characters` (`8`), `ZeroDensity` (`7`), `Tree` (`2`), `Preliminaries` (`1`), `QuadraticCenter` (`1`), `All.lean` + `PaperMain.lean` (`2`) |
| **Total `OAI/NumberTheory/Ostmann/`** | **`7,716`** | **`609,199`** | — | $7335 + 381 = 7716$ files; $569682 + 39517 = 609199$ lines |

---

## 2. Side-by-Side Comparison of Engine A (`Complete`) vs. Engine B (`Main`)

### 2.1 Engine A's 9-Module Top-Down Discharge Chain (`thm_36`)
In Engine A, `InverseGoldbach.lean` (`L45–61`) states the main theorem conditional on `15` explicit analytic and sieve hypotheses (`P0 : PublishedProgressionInput`, `hM : MertensEstimate C`, `hS : ShiftedSieveInput`, `hE : ElsholtzSummandBounds`, `hCol : CollisionStabilityInput`, etc.). Nine successive wrapper modules discharge these `15` hypotheses down to `0` ([`thm_36_engine_a_15_step_conditional_discharge_spine`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L296-L316)):
1. `InverseGoldbach.lean`: `15` hypotheses
2. `ReducedPublishedInputs.lean`: `12` hypotheses (`-3` discharged)
3. `MainWithoutPage.lean`: `8` hypotheses (`-4` discharged)
4. `MainActualProgression.lean`: `7` hypotheses (`-1` discharged)
5. `MainWithoutProgression.lean`: `6` hypotheses (`-1` discharged)
6. `MainWithoutAdditiveSieve.lean`: `5` hypotheses (`-1` discharged)
7. `MainWithoutSummandSize.lean`: `3` hypotheses (`-2` discharged)
8. `MainWithoutSiegel.lean`: `1` hypothesis (`-2` discharged)
9. `MainWithoutQuadraticSieve.lean` $\to$ `Complete.lean`: `0` hypotheses (`-1` discharged; total $3 + 4 + 1 + 1 + 1 + 2 + 2 + 1 = 15$).

At the heart of Engine A's tree contradiction are `Construction/ScheduledAnalyticParameters.lean` (`L10–56`, setting `scheduledInitialRate = 6 * log 2 + 13`, `scheduledIterationRate = 6 * log 2 + 14`, and depth threshold $k^3 \ge 120 \iff k \ge 5$, [`thm_32_scheduled_gap_parameters_and_depth_reserves_engine_a`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L232-L248)), `Arithmetic/MovingFrequencyBudget.lean` (`L12–120`, defining `movingCutoffExponent`, `movingFrequencyRate`, and `moving_sum_two_pow`, [`thm_27_engine_a_vs_engine_b_frequency_rate_unification`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L151-L167)), and `Construction/SelectedScheduledFinalContradiction.lean` (`L12–169`, [`thm_33_comparison_slot_complexity_bound`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L249-L263)).

### 2.2 Engine B's Bottom-Up 4-Provider Consumer (`thm_04`, `thm_31`, `thm_37`)
In Engine B, `Result.lean` (`L13–23`) and `Conclusion/ActualNoDecomposition.lean` invoke `Conclusion/ActualFourComparisonConsumer.lean` (`L14–55`) with concrete constants $C_s = 17$ and $C_{\mathrm{cov}} = 17$ ([`thm_04_external_dependency_asymmetry_1_vs_18`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L85-L105), [`thm_31_diagonal_good_permutation_rate_and_four_providers`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L213-L231)):
- `ActualSingleComparisonProvider d 17`
- `ActualDiagonalGoodComparisonProvider d`
- `ActualBadCovarianceComparisonProvider d 17`
- `ActualGoodCovarianceComparisonProvider d`

Inside `Conclusion/ActualComparisonObstructionInterface.lean` (`L22–57`), Engine B sets $B_s = 200$, $B_z \ge 9$, $B_D \ge 200 + C_s + 105 = 322$, $C = C_{\mathrm{cov}} + 2 = 19$, good covariance margin $65$, target rate threshold $\text{finalRate } B_D\, 200\, B_z\, 19\, k < -66$, and diagonal good margin $67$ ([`thm_31_diagonal_good_permutation_rate_and_four_providers`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L213-L231)). Unlike Engine A, Engine B reuses `15` modules from `#021` (`OAI.NumberTheory.Jacobsthal.*`, Erdős `#970`) and `3` modules from `#026` (`OAI.NumberTheory.PrimeGaps.*`, Problem 344) for its Siegel-Walfisz and explicit-formula infrastructure ([`thm_37_engine_b_jacobsthal_and_prime_gaps_reuse_accounting`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L317-L331)).

### 2.3 Why `#013` Is Strictly Independent of `#003` (`QRH`) (`thm_16`–`thm_19`)
In `sections/05-supply.tex`, Remark 5.4 (`L751–772`) mentions that if one invokes OpenAI `#003` (`\cite{openai2026quasiriemann}`, zero-free region $\text{Re}(s) > 7/8$), then every Dirichlet $L$-function has no zeros in $\text{Re}(s) > 7/8$, yielding an immediate $X^{7/8}$ error term ($1 - 7/8 = 1/8$ power saving) with zero exceptional-character deletions. However, the actual proof in `05-supply.tex` Lemma 5.3 (`L466–597`) and in both Lean engines (`ZeroDensity/` and `Supply/`) **never imports `#003`**: it sets $T = Q^5$ in Montgomery's classical zero-density estimate $N(\sigma, T, \chi) \ll (Q^2 T)^{3(1-\sigma)/(2-\sigma)}(\log QT)^{14}$ so that $Q^2 T = Q^7$ (`slope_A = 21`) and Perron's horizontal tail is $Q^2 T^{-2} = Q^{-8}$ ([`thm_16_montgomery_zero_density_Q7_and_tail_Q_minus_8`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L324-L339), [`thm_17_zero_density_critical_exponent_crossover_at_sigma_half`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L340-L354)), and deletes at most $1$ prime dividing the Landau-Page exceptional modulus $q_{\mathrm{ex}}$ from $\mathcal{S}$ ([`thm_18_page_exceptional_zero_single_prime_deletion_budget`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L355-L371), [`thm_19_qrh_003_citation_in_remark_5_4_is_strictly_optional`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L372-L386)).

---

## 3. All-`k` Structural Induction for the Binary Tree Frequency Budget (`thm_21`–`thm_27`)

In `Conclusion/Scales.lean` (`L51–83`) and `09-conclusion.tex` (`L355`), the accumulated step gap across tree levels $j = 0, \dots, k-1$ with $r_j = 2^j$ and $r = 2^k$ is:
$$\sum_{j=0}^{k-1} \Delta_j = \sum_{j=0}^{k-1} 2^j \left(B_D + B_z \log z + \frac{2}{5}\log(2^j)\right) m.$$
In [`ostmann_tree_transfers_and_permutation_contradiction.lean`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L17-L150), we define the recursive functions `dyadicSum` and `weightedDyadicSum` and prove by structural induction (`induction k`) for all $k \in \mathbb{N}$:
1. [`thm_21_dyadic_tree_leaf_sum_by_induction`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L30-L50):
   $$\text{dyadicSum}(k) = \sum_{j=0}^{k-1} 2^j = 2^k - 1.$$
2. [`thm_22_weighted_dyadic_level_sum_by_induction`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L51-L79):
   $$\text{weightedDyadicSum}(k) = \sum_{j=0}^{k-1} j 2^j = k 2^k - 2\cdot 2^k + 2 = (k - 2)2^k + 2.$$
3. [`thm_23_weighted_dyadic_strict_upper_bound_all_k`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L80-L102) & [`thm_26_frequency_budget_exact_closed_form_all_k`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L132-L150):
   $$k 2^k - \text{weightedDyadicSum}(k) = 2(2^k - 1) = 2\,\text{dyadicSum}(k) > 0 \quad (\forall k \ge 1).$$
   Multiplying by $\frac{2}{5}\log 2$, the weighted sum $\frac{2}{5}\sum_{j=0}^{k-1} 2^j \log(2^j) = \frac{2}{5}(r\log r - 2r\log 2 + 2\log 2)$ is strictly bounded above by $\frac{2}{5}r\log r$. Combining this $+\frac{2}{5}\log r$ frequency growth with the $-\frac{3}{4}\log r$ bad-arrangement multinomial decay ([`thm_28_overlap_graph_component_merge_bound`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L168-L179), [`thm_29_bad_arrangement_multinomial_decay_three_quarters`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L180-L193)) yields the exact net rate ([`thm_30_net_contradiction_rate_minus_seven_twentieths`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L194-L212), [`thm_39_two_stage_analytic_combinatorial_contraction_comparison`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L357-L376), [`thm_40_master_ostmann_inverse_goldbach_synthesis_verdict`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L377-L389)):
   $$\text{finalRate}(k) = -\frac{7}{20}\log(2^k) + B_D + 2B_s + (B_z + 16)\log(k^4) + C \xrightarrow{k \to \infty} -\infty.$$

---

## 4. 3-Generation Evolutionary Tree, 4-Stratum Fossil Restoration (`381` Files), 4 Internal Formalization Shortcuts, and Sharp Breakthrough Proofs (`thm_41`–`thm_45`)

### 4.1 The 3-Generation Evolutionary Tree and 4 Fossil Strata (`381` Orphans, `39,517` Lines)
Tracing the internal module graph of the `381` unreachable orphan files (`39,517` lines, forming `66` connected components with internal hubs `Arithmetic/StepwiseQuantitativeInduction.lean` imported by `234` orphans and `Construction/SelectedScheduledIteration.lean` imported by `71` orphans) reconstructs a **3-generation evolutionary tree**:
- **Generation 1A (Fossil Parity Prototype, `379` files)**: `Construction/SelectedScheduledIteration.lean` $\to$ `Arithmetic/StepwiseQuantitativeInduction.lean` $\to$ `Construction/FinalExponentialContradiction.lean`. Used parity/character cancellation ($-r \log r$) against $(6\log 2 + 16)r$, closing at tree depth $k_{\min} = 1040$. Abandoned because the unweighted parity induction could not absorb the $j\log 2$ frequency growth of the moving cutoff.
- **Generation 1B (Live Engine A, `3,165` files)**:Replaced `SelectedScheduledIteration.lean` with `SelectedScheduledMovingIteration.lean` + `Arithmetic/MovingFrequencyBudget.lean` + `Construction/SelectedScheduledFinalContradiction.lean`, adding the $+\frac{2}{5}r\log r$ moving frequency budget and closing at $k_{\min} = 5340$.
- **Generation 2 (Live Engine B, `4,175` files)**: Refactored into the paper-aligned 10-folder architecture (`Conclusion/Scales.lean`, `ActualFourComparisonConsumer.lean`) and built `All.lean` + `PaperMain.lean` (`2` root fossils).

The `381` fossils partition into **4 distinct mathematical strata**:
1. **Stratum I (`350` files: `Arithmetic` `264` + `Construction` `86`)**: The complete Generation 1A parity contradiction engine (`FinalExponentialContradiction.lean`, `FinalReassignments.lean`, `StepwiseQuantitativeInduction.lean`).
2. **Stratum II (`19` files: `Quadratic` `10` + `Characters` `8` + `QuadraticCenter` `1`)**: Early double-character fourth-moment prototypes (`FourthMomentBound.lean`, `PrimeDoubleCharacterSum.lean`) superseded by `Quadratic/OffDiagonal.lean`.
3. **Stratum III (`7` files in `ZeroDensity/`)**: The abandoned contour-integration bridge (`ContourIntegralBound.lean`, `ZeroSumBound.lean`, ` ExplicitFormulaBridge.lean`) superseded by `18` external imports from `#021` (`Jacobsthal`) and `#026` (`PrimeGaps`).
4. **Stratum IV (`5` files: `Tree` `2` + `Preliminaries` `1` + Root `2`)**: `Tree/SlotPermutationDecomposition.lean`, `Tree/TreeTransferTheorem.lean`, `Preliminaries/PrimeSumsetReduction.lean`, `All.lean`, and `PaperMain.lean`.

### 4.2 Four Internal Formalization Shortcuts Uncovered in Upstream Lean
1. **Shortcut 1 (`Tree/ArrangementGraph.lean:45–53`)**: Instead of constructing the bipartite overlap multigraph $H(\sigma)$ on $\mathcal{L}_k \times [m]$, GPT defined `overlapComponentMap (r m : Nat) (pi : Equiv.Perm (Fin r)) : Fin r -> Fin r := fun l => ⟨l.1 / 2, ...⟩`, collapsing the arrangement graph to deterministic halving `l / 2` independent of `m` and `pi`.
2. **Shortcut 2 (`Construction/SelectedScheduledFinalContradiction.lean:18–21`)**: Defined `def selectedScheduledLeafScale (_X : Nat) (k : Nat) : Nat := k`, turning $\log r_k = k \log 2$ into $\log k$ inside `SelectedScheduledFinalContradiction.lean` before compensating with linear `k * log 2` terms in `Conclusion/Scales.lean`.
3. **Shortcut 3 (`Tree/ComponentFactorial.lean:28–38`)**: Proved `component_log_cost` (`a_c * log r <= r * log r`) via `Nat.le_of_lt a_c.isLt` ($a_c \le r$) instead of using the partition bound $\sum_{c=1}^t (a_c - 1) = r - t$.
4. **Shortcut 4 (`Conclusion/Scales.lean:51–53`)**: Defined `sum_dyadic` and `sum_dyadic_log` immediately as closed-form formulas (`2^k - 1` and `(k - 2)2^k + 2`) rather than over `Finset.range k` (which we discharged by structural induction `induction k` in `thm_21`–`thm_23`).

### 4.3 Four Sharp Mathematical Breakthroughs (`thm_41`–`thm_45`)
1. **Breakthrough 1 — Overlap Graph Unsplit-Leaf Majority & Zero Bad Arrangements (`thm_41`, `thm_42`)**:
   In any balanced $m$-regular overlap graph on $r$ leaves with $t = t_1 + t_{\ge 2}$ connected components ($t_1$ of size $1$, $t_{\ge 2}$ of size $\ge 2$), $2(t - t_1) \le r - t_1 \implies 2t \le r + t_1$. Thus GPT's bad-arrangement condition $3r < 4t$ forces $r < 2t_1$ ([`thm_41_bad_arrangement_requires_majority_unsplit_leaves`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L396-L404)): strictly more than half of all leaves must remain unsplit size-1 components! Restoring the slotwise permutation structure (`Construction/FinalReassignments.lean` $S_r^m$) with at least one deranged slot pair $\sigma_2(l) \neq \sigma_1(l)$ forces $t_1 = 0$, so $2t \le r$ and $4(r - t) \ge 2r > r$ for all $r \ge 1$ ([`thm_42_deranged_slot_pair_eliminates_bad_arrangements`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L411-L421)): **the bad-arrangement set is strictly empty ($\text{card}(\text{Bad}) = 0$)**, eliminating multinomial approximations altogether.
2. **Breakthrough 2 — $4\times$ Tightened Maximum Bad Component Size (`thm_43`)**:
   Using $a_c + \sum_{c' \neq c} a_{c'} = r$ with $\sum_{c' \neq c} a_{c'} \ge t - 1$ inside the bad regime $4(r - t) \le r$ proves $a_c \le r - t + 1$ and $4a_c \le r + 4$ ([`thm_43_bad_component_max_size_quarter_bound`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L427-L434)), tightening `ComponentFactorial.lean:34` by a factor of $4$.
3. **Breakthrough 3 — Master Contraction Rate Law & $85\%$ Tree Depth Reduction (`thm_44`)**:
   Parameterized by the bad-merge threshold $\theta \in [0, 1/2)$ ($r - t \le \theta r$) and step-cutoff exponent $\delta_{\text{step}} > 0$, the net contradiction rate is
   $$\gamma(\theta, \delta_{\text{step}}) = (1 - \theta) - (\theta + \delta_{\text{step}}) = 1 - 2\theta - \delta_{\text{step}}.$$
   As formalized in [`thm_44_master_contraction_rate_and_depth_reduction`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L443-L459), moving from GPT's $(\theta, \delta_{\text{step}}) = (5/20, 3/20)$ ($\gamma = 7/20 = 0.35$, $k_{\min} = 7041$ in Engine B / $5340$ in Engine A) to tuned $(1/20, 1/20)$ gives $\gamma = 17/20 = 0.85$ ($k_{\min} = 2036$), deranged $t_1 = 0$ $(0, 1/20)$ gives $\gamma = 19/20 = 0.95$ ($k_{\min} = 1803$), and the restored Gen 1A parity fossil $(0, 0)$ gives $\gamma = 20/20 = 1.00$ ($k_{\min} = 1040$, saving $6,001$ binary tree levels).
4. **Breakthrough 4 — Section 5 Supply Expansion by $+46.7\%$ to $+53.3\%$ (`thm_45`)**:
   In `Supply/ContractionConstants.lean:45` (`local_strict_norm_numerical`) and `Supply/CoverageMargin.lean:114`, replacing the rounded local Parseval rate $\kappa = 8/5 = 32/20$ ($H = 68/100 L$) by the unrounded rate $\kappa = 33/20 = 1.65$ ($H = 61/100 L$) and asymptotic limit $\kappa = 17/10 = 34/20$ ($H = 60/100 L$) keeps the scaled pair-sum exponent $2000 - \kappa_{20} H_{100}$ strictly negative ($-13 < 0$ and $-40 < 0$) while expanding the guaranteed favorable prime reciprocal mass from $30/200 L$ ($0.15 L$) to $44/200 L$ ($0.22 L$, $+46.7\%$) and $46/200 L$ ($0.23 L$, $+53.3\%$, [`thm_45_supply_contraction_favorable_mass_expansion`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L466-L479)).
