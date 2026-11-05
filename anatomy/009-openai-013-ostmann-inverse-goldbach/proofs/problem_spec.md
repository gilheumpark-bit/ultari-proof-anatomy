# Problem Specification: OpenAI `#013` Ostmann's Inverse Goldbach Conjecture (Zero-Hint Problem Specification)

## 1. Scope & Target Repository
- **Primary Upstream Target**: `openai/math` (`mathcommunity/oai-math-revised`, Family `#013`: Ostmann's Inverse Goldbach Problem / *The additive indecomposability of the primes*):
  1. `preprints/the-additive-indecomposability-of-the-primes-September-24-2026/build/` (`paper.tex`, `references.bib`, `glyph-mappings.tex`, and `sections/01-introduction.tex` through `sections/09-conclusion.tex`)
  2. `lean/ComparatorChallenges/OstmannComplete.lean` and `lean/ComparatorChallenges/OstmannPrimes.lean`
  3. `lean/OAI/NumberTheory/Ostmann/` (`Complete.lean`, `Main.lean`, `Result.lean`, `Corollaries.lean`, `InverseGoldbach.lean`, and all subdirectories `Preliminaries/`, `Quadratic/`, `QuadraticCenter/`, `Characters/`, `ZeroDensity/`, `Supply/`, `Tree/`, `Construction/`, `Arithmetic/`, `Conclusion/`)

## 2. Target Symbols & Subsystems to Audit
1. **Pillar 1 (Import-Cone Stratigraphy & Logical Bridge)**:
   - Import cones of `OAI.NumberTheory.Ostmann.Complete` (`inverseGoldbach`, `twoInfiniteSummandsImpossible`) and `OAI.NumberTheory.Ostmann.Main` (`Ostmann.main`, `Ostmann.infinite_summands`), shared intersection modules (`Defs.lean`, `Statement.lean`, `Endpoint.lean`, `FiniteCRT.lean`, `FiniteFactor.lean`), and unreachable modules in `OAI/NumberTheory/Ostmann/`.
   - External `OAI` dependencies of both import cones (`OAI.NumberTheory.Jacobsthal.*`, `OAI.NumberTheory.PrimeGaps.*`, `OAI.NumberTheory.DirichletL.*`).
2. **Pillar 2 (Finite-Summand CRT, Collision Stability, and Section 5 Fourier Supply Contraction)**:
   - `OAI.NumberTheory.Ostmann.FiniteCRT` and `FiniteFactor` (`02-preliminaries.tex` Lemma 2.2), shifted sieve and Elsholtz counting window (`Lemma 2.1`, `Lemma 2.4`), and residue density collision stability (`Lemma 2.5`).
   - `OAI.NumberTheory.Ostmann.Supply.Statement` (`nonsparsePrimes`, `NonsparseSupply`) and `Supply.NonsparseSupply` (`05-supply.tex` Proposition 5.1, Lemma 5.2, Lemma 5.3, Remark 5.4).
3. **Pillar 3 (Binary Tree Transfers, Overlap Graph Bad Permutations, and Final Contradiction Rate)**:
   - `OAI.NumberTheory.Ostmann.Conclusion.Scales` (`bulkScale`, `bulkSize`, `initialGap`, `stepGap`, `sum_dyadic`, `sum_dyadic_log`, `frequencyBudget`, `finalRate`) and `Arithmetic.MovingFrequencyBudget` (`movingCutoffExponent`, `movingFrequencyRate`).
   - `OAI.NumberTheory.Ostmann.Construction.ScheduledAnalyticParameters`, `SelectedScheduledFinalContradiction`, `Conclusion.ActualComparisonObstructionInterface`, and `Conclusion.ActualFourComparisonConsumer` (`06-tree.tex` through `09-conclusion.tex`).
