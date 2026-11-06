# Independent Symbolic & Algebraic Audit Specification

Using only the Lean 4 reference files in `./oai_ref/` and standard Python (`sympy`, `fractions`, `math`), extract the definitions directly from the `.lean` source files, solve the 5 problems below from scratch, execute `verify_symbolic_qrh.py`, and save the output dictionary to `symbolic_verification_result.json`.

## Problem 1: Floor Source Margin Vanishing Threshold (`oai_ref/CentralExponent.lean`, `oai_ref/CubeFloorSaving.lean`; upstream `lean/OAI/NumberTheory/DirichletL/Detector/CentralExponent.lean`, `lean/OAI/NumberTheory/DirichletL/PrimeRows/CubeFloorSaving.lean`)
Read `oai_ref/CentralExponent.lean` (`sourceExponent`, `relativeExponent`, `floor_source_margin`) and `oai_ref/CubeFloorSaving.lean`.
In `floor_source_margin`, the floor abscissa is parameterized as `a = 1/2 + eta` with `q = eta`, `R = 1`, and `d = 13/16` (at `Delta = 0, zeta = 0`).
1. Extract the exact linear expression for `sourceExponent (1/2 + eta) (13/16) 1 eta - 3/16` from `oai_ref/CentralExponent.lean`.
2. Solve for the exact rational root `eta_max` where `sourceExponent (1/2 + eta_max) (13/16) 1 eta_max - 3/16 = 0`, and compute the critical real-part threshold `a_max = 1/2 + eta_max` as an irreducible fraction `"num/den"`.

## Problem 2: Exact Closed-Form Algebraic Saddle Point (`oai_ref/Endpoint.lean`; upstream `lean/OAI/NumberTheory/DirichletL/Endpoint.lean`)
Read `oai_ref/Endpoint.lean` and extract the exact rational function `balancedExponent δ y` on the domain `0 ≤ δ ≤ 5/6`, `0 ≤ y ≤ 1/2`.
1. At the boundary `y = 0`, solve `d/dδ (balancedExponent δ 0) = 0` symbolically on `0 ≤ δ ≤ 5/6` to find the exact quadratic irrational root `delta_true` and corresponding abscissa `a_true = (1 + delta_true) / 2`.
2. Express `a_true` in canonical radical form `p/q - r*sqrt(D)/s` with positive integers `p, q, r, D, s` (`D` square-free, `gcd(p,q)=1`, `gcd(r,s)=1`), and record `[p, q, r, D, s]` and its 10-digit float value.
3. Identify the rational point `delta_SOS` where the squared term in `DirichletL/Endpoint.lean`'s `certificateIdentity` vanishes at `y = 0`, and evaluate the exact rational values of `balancedExponent delta_SOS 0` and `d^2/dδ^2 (balancedExponent δ 0)` at `δ = delta_SOS`.

## Problem 3: Componentwise Gram Scale Exponents (`oai_ref/LowSourceScales.lean`, `oai_ref/GramScaleLoss.lean`, `oai_ref/GramBound.lean`, `oai_ref/LowGramScale.lean`; upstream `lean/OAI/NumberTheory/DirichletL/Detector/`)
Read `oai_ref/LowSourceScales.lean`, `oai_ref/GramScaleLoss.lean`, `oai_ref/GramBound.lean`, and `oai_ref/LowGramScale.lean`.
1. Compare the exact `Z`-power exponents of the non-exceptional and exceptional terms in `oai_ref/LowSourceScales.lean`, `oai_ref/GramScaleLoss.lean`, and `oai_ref/GramBound.lean` (before they are relaxed and bundled into the coarse factor in `oai_ref/LowGramScale.lean`) against the coarse square-root `Z`-exponent in `source_gram_sqrt_power`.
2. At `δ = delta_SOS` from Problem 2, compute the exact rational square-root `Z`-exponent savings `saving_nonexceptional`, `saving_nonexceptional_with_L_bound`, and `saving_exceptional` (as irreducible fractions `"num/den"`).

## Problem 4: Exact `m >= 2` Vanishing and Continuation Threshold (`oai_ref/HighRowsTail.lean`, `oai_ref/HighRowsScalar.lean`, `oai_ref/ScalarTable.lean`, `oai_ref/HighRowsCentralTerms.lean`; upstream `lean/OAI/NumberTheory/DirichletL/Detector/`)
Read `oai_ref/HighRowsTail.lean`, `oai_ref/HighRowsScalar.lean`, `oai_ref/ScalarTable.lean`, and `oai_ref/HighRowsCentralTerms.lean`.
1. Using `gaussValuationTable_above` and the 8 non-principal `(e, l, k)` branches in `oai_ref/HighRowsCentralTerms.lean`, determine how many of the 8 branches vanish identically for all `m >= 2`.
2. For the surviving branches at `m >= 2`, extract their exponent inequalities from `oai_ref/HighRowsCentralTerms.lean` and compute the exact minimum rational value `z_re_min` such that the inequalities hold for all `m >= 2` and all `x >= 1/2, w >= 0` (`x + w = 1`).

## Problem 5: Principal Remainder Contour Shift Budget (`oai_ref/PrincipalRemainderBounds.lean`, `oai_ref/ParametersHighData.lean`; upstream `lean/OAI/NumberTheory/DirichletL/Detector/PrincipalRemainderBounds.lean`, `lean/OAI/NumberTheory/DirichletL/ParametersHighData.lean`)
Read `oai_ref/PrincipalRemainderBounds.lean` and `oai_ref/ParametersHighData.lean`.
1. Extract the exact rational expression for the principal remainder contour-shift saving in `oai_ref/PrincipalRemainderBounds.lean` and compare it to `principal_budget` in `oai_ref/ParametersHighData.lean`.
2. Record its exact irreducible fraction `"num/den"` as `B_principal` and boolean `matches_principal_budget`.
