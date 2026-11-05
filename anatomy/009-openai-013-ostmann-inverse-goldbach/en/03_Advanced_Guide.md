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
