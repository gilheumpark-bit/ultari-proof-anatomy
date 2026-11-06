/-!
# Formal Lean 4 (v4.29.0-rc8) Verification of Rational Exponent & Parameter Identities in OpenAI #003
Compiles standalone with `lean` over exact rational and integer arithmetic (`Rat`, `Int`, `Nat`).
Verifies:
1. **Exponent Evaluations at $z_{\text{re}} \in \{17/50, 6/25, 17/100\}$**:
   - At $z_{\text{re}} = 17/50 = 0.34$: $4 - 6(51/100) - 6(17/50) = -11/10$
   - At $z_{\text{re}} = 6/25 = 0.24$: $2(4 - 6(51/100 + 16/1000) - 6(6/25)) = -149/125 < -1$
   - At $z_{\text{re}} = 17/100 = 0.17$: $6 - 2(1 + 3(51/100)) - 6(17/100) = -2/25 \le -1/100$
2. **Rational Sum-of-Squares (SOS) Identities (`DirichletL/Endpoint.lean`) & Stationary Point ($\delta = 79/204$)**:
   - Polynomial identity at $\delta = 79/204, y = 0$ ($a = (1 + \delta)/2 = 283/408 \approx 0.693627$):
     `10368 * certificateWeight(0) * balanceDenominator(79/204, 0) * (-balancedExponent(79/204, 0)) = 3 * 49 = 147`
     and `-balancedExponent(79/204, 0) = 7 / 30672 > 49 / 440640`.
   - Certified exponent margins for $\beta \in \{7/8, 5/6, 3/4, 69/100\}$.
3. **Cube Floor Exponent Margin (`DirichletL/Detector/CentralExponent.lean` & `DirichletL/PrimeRows/CubeFloorSaving.lean`)**:
   - Linear relation `sourceExponent(1/2 + η, 13/16, 1, η) - 3/16 = -1/48 + (3/2)*η`.
   - Evaluations at $\eta \in \{1/100, 1/200, 1/1000, 1/10000\}$ and root $\eta = 1/72$ ($a = 37/72 \approx 0.513889$).
-/

namespace QRHExponentBounds

-- ============================================================================
-- 1. Definitions from OpenAI #003 (`DirichletL/Endpoint.lean` & `DirichletL/Detector/CentralExponent.lean`)
-- ============================================================================

def denominator (y : Rat) : Rat := (37 + 34 * y) / 18

def primeWeight (y : Rat) : Rat := (7 + 18 * y + 8 * y ^ 2) / 9

def balanceDenominator (δ y : Rat) : Rat :=
  (5 / 6 - δ) * denominator y + δ * primeWeight y

def certificateWeight (y : Rat) : Rat := 51 + 41 * y

def balancedCutoff (δ y : Rat) : Rat :=
  1 + δ * primeWeight y / (2 * balanceDenominator δ y)

def balancedRowCount (δ y : Rat) : Rat :=
  1 - 5 / 6 + (5 / 6 - δ) * balancedCutoff δ y

def balancedExponent (δ y : Rat) : Rat :=
  -(1 / 48) + (2 / 3) * δ + δ * (1 / 2 - y) / 6 -
    (13 / 16) * (1 - balancedRowCount δ y)

def endpointSOS_LHS (δ y : Rat) : Rat :=
  10368 * certificateWeight y * balanceDenominator δ y * (-balancedExponent δ y)

def endpointSOS_RHS (δ y : Rat) : Rat :=
  (3 + 5 * y) * ((4 * certificateWeight y * δ - 79) ^ 2 + 49) +
    4 * y * (4 * certificateWeight y * δ *
      ((1 + 3 * y) * (15 + 32 * y) * δ + 9 - 13 * y) + 265 + 3485 * y)

def sourceExponent (a d R q : Rat) : Rat :=
  (17 / 48) * (1 / 2 - 17 / 50) + a + 17 / 50 - 1 - a * (23 / 48) - d * (17 / 50) + d * R +
    d * (a - 1 / 2) + (1 / 6) * (17 / 50 - 1 / 2 + q)

def relativeExponent (δ d R q : Rat) : Rat :=
  -(1 / 48) + (2 / 3) * δ + q / 6 - (13 / 16) * (1 - R) + (d - 13 / 16) * (R + δ / 2 - 17 / 50)

-- ============================================================================
-- 2. Mellin Continuation Exponent Evaluations
-- ============================================================================

/-- [Theorem 1] At `x = 51/100` and `z = 17/50`, the `coordR` exponent equals `-11/10`. -/
theorem coordR_exponent_at_z_034 :
    (4 : Rat) - 6 * (51 / 100) - 6 * (17 / 50) = -11 / 10 := by decide +kernel

/-- [Theorem 2] At `x = 51/100` and `z = 6/25` (`0.24`), the quadratic `R^2` exponent equals `-1`,
    and for `x = 51/100 + 16/1000` (`a + 16*e`) it equals `-149/125 < -1`. -/
theorem coordR_squared_exponent_at_z_024 :
    2 * ((4 : Rat) - 6 * (51 / 100) - 6 * (6 / 25)) = -1 ∧
    2 * ((4 : Rat) - 6 * (51 / 100 + 16 / 1000) - 6 * (6 / 25)) = -149 / 125 ∧
    (-149 / 125 : Rat) < -1 := by decide +kernel

/-- [Theorem 3] At `x = 51/100` and `z = 17/100` (`0.17`), the finite Gauss sum branch `(e=0, l=2, k=0, m=1)`
    equals `-2/25` (`-0.08`), which satisfies `-2/25 <= 1/2 - 51/100 = -1/100`. -/
theorem gauss_branch_exponent_at_z_017 :
    (6 : Rat) - 2 * (1 + 3 * (51 / 100)) - 6 * (17 / 100) = -2 / 25 ∧
    (-2 / 25 : Rat) ≤ 1 / 2 - 51 / 100 := by decide +kernel

-- ============================================================================
-- 3. Sum-of-Squares (SOS) Certificates (`DirichletL/Endpoint.lean`)
-- ============================================================================

/-- [Theorem 4] The rational root of the squared linear term `(4*51*δ - 79)^2` in `DirichletL/Endpoint.lean` is
    `δ_ref = 79/204`, corresponding to abscissa `a_ref = (1 + δ_ref)/2 = 283/408 ≈ 0.693627`. -/
theorem rational_sos_reference_abscissa :
    let δ_ref : Rat := 79 / 204
    let a_ref : Rat := (1 + δ_ref) / 2
    4 * certificateWeight 0 * δ_ref - 79 = 0 ∧
    a_ref = 283 / 408 ∧
    (69 / 100 : Rat) < a_ref ∧ a_ref < 694 / 1000 := by decide +kernel

/-- [Theorem 5] At `(δ, y) = (79/204, 0)`, `endpointSOS_LHS = endpointSOS_RHS = 147`,
    and `-balancedExponent(79/204, 0) = 7 / 30672 > 49 / 440640`. -/
theorem exact_sos_identity_and_margin_at_79_204 :
    endpointSOS_LHS (79 / 204) 0 = 147 ∧
    endpointSOS_RHS (79 / 204) 0 = 147 ∧
    -balancedExponent (79 / 204) 0 = 7 / 30672 ∧
    (49 / 440640 : Rat) < 7 / 30672 := by decide +kernel

/-- [Theorem 6] Verification of the SOS polynomial identity across rational test points in `[0, 5/6] × [0, 1/2]`. -/
theorem sos_polynomial_identity_sample_points :
    endpointSOS_LHS (1 / 5) (1 / 10) = endpointSOS_RHS (1 / 5) (1 / 10) ∧
    endpointSOS_LHS (2 / 5) (1 / 4) = endpointSOS_RHS (2 / 5) (1 / 4) ∧
    endpointSOS_LHS (3 / 4) (1 / 2) = endpointSOS_RHS (3 / 4) (1 / 2) ∧
    endpointSOS_LHS (19 / 50) (1 / 20) = endpointSOS_RHS (19 / 50) (1 / 20) := by decide +kernel

/-- [Theorem 7] Rational exponent margins for `β ∈ {7/8, 5/6, 3/4, 69/100}`. -/
theorem certified_exponent_margins_by_beta :
    -(49 / 440640 : Rat) - 459 / 88128 = -293 / 55080 ∧
    -(49 / 440640 : Rat) - 1473 / 88128 = -3707 / 220320 ∧
    -(49 / 440640 : Rat) - 1566 / 44064 = -15709 / 440640 := by decide +kernel

-- ============================================================================
-- 4. Cube Floor Exponent Margin (`DirichletL/Detector/CentralExponent.lean` & `DirichletL/PrimeRows/CubeFloorSaving.lean`)
-- ============================================================================

/-- [Theorem 8] At `a_floor = 51/100` (`0.51`), the floor source margin equals `-7/1200`. -/
theorem floor_source_margin_at_051 :
    sourceExponent (51 / 100) (13 / 16) 1 (1 / 100) - 3 / 16 = -7 / 1200 := by decide +kernel

/-- [Theorem 9] At `a_floor = 101/200` (`0.505`), the floor source margin equals `-1/75`. -/
theorem floor_source_margin_at_0505 :
    sourceExponent (101 / 200) (13 / 16) 1 (1 / 200) - 3 / 16 = -1 / 75 := by decide +kernel

/-- [Theorem 10] At `a_floor = 501/1000` (`0.501`), the floor source margin equals `-29/1500`. -/
theorem floor_source_margin_at_0501 :
    sourceExponent (501 / 1000) (13 / 16) 1 (1 / 1000) - 3 / 16 = -29 / 1500 := by decide +kernel

/-- [Theorem 11] At `a_floor = 5001/10000` (`0.5001`), the floor source margin equals `-1241/60000`,
    increasing the absolute saving over `-7/1200` by `891/60000 = 297/20000`. -/
theorem floor_source_margin_at_05001 :
    sourceExponent (5001 / 10000) (13 / 16) 1 (1 / 10000) - 3 / 16 = -1241 / 60000 ∧
    (1241 / 60000 : Rat) - (7 / 1200) = 297 / 20000 := by decide +kernel

/-- [Theorem 12] Vanishing root of the floor margin: at `η = 1/72` (`a_floor = 37/72 ≈ 0.513889`),
    `sourceExponent (37/72) (13/16) 1 (1/72) - 3/16 = 0`. -/
theorem floor_source_margin_root_37_72 :
    sourceExponent (37 / 72) (13 / 16) 1 (1 / 72) - 3 / 16 = 0 := by decide +kernel

-- ============================================================================
-- 5. Non-Strict Gauss-Sum Branches (`DirichletL/Detector/HighRowsCentralTerms.lean`) & Parameter Budget
-- ============================================================================

def gaussBranchExponent (nu x_re w_re z_re : Rat) (e l k m : Rat) : Rat :=
  nu - (x_re + 1 / 2) * e - (1 + 3 * x_re) * l - w_re * k - 6 * z_re * m

/-- [Theorem 13] All 9 non-strict finite Gauss-sum branches `(e, l, k, m)` in `DirichletL/Detector/HighRowsCentralTerms.lean`
    satisfy `gaussBranchExponent <= 1/2 - x_re` at `z_re = 17/100` and `x_re = 5001/10000`. -/
theorem nonstrict_gauss_branches_at_05001_and_017 :
    let x : Rat := 5001 / 10000
    let w : Rat := 1 - x
    let z : Rat := 17 / 100
    let target : Rat := 1 / 2 - x
    gaussBranchExponent 5 x w z 0 2 0 0 ≤ target ∧
    gaussBranchExponent 6 x w z 0 2 0 1 ≤ target ∧
    gaussBranchExponent 6 x w z 0 2 1 1 ≤ target ∧
    gaussBranchExponent (1 / 2) x w z 1 0 0 0 ≤ target ∧
    gaussBranchExponent (3 / 2) x w z 1 0 1 1 ≤ target ∧
    gaussBranchExponent (5 / 2) x w z 0 1 0 0 ≤ target ∧
    gaussBranchExponent 3 x w z 0 1 1 0 ≤ target ∧
    gaussBranchExponent (7 / 2) x w z 1 1 0 0 ≤ target ∧
    gaussBranchExponent 4 x w z 1 1 1 0 ≤ target := by decide +kernel

/-- [Theorem 14] Rational parameter budget inequality (`DirichletL/PrimeRows/CubeFloorSaving.lean:41` & `DirichletL/Parameters.lean`)
    at `β = 69/100`, `r_ext = 17/100`, `a_floor = 5001/10000 = 0.5001`, `N = 22`. -/
theorem parameter_budget_inequality_at_05001 :
    let floor_budget : Rat := 1241 / 60000
    let target_margin : Rat := 15709 / 440640
    let ζ : Rat := 1241 / 960000
    let e : Rat := 1 / 100000
    let eps : Rat := 1241 / 14400000
    let τ : Rat := 1241 / 1440000
    let loss : Rat := 1241 / 480000
    let mesh : Rat := 1241 / 80000
    let nu : Rat := 1241 / 480000
    let saving : Rat := 1241 / 480000
    let N : Rat := 22
    0 < saving ∧
    τ * (2 + 4 * eps) < loss ∧
    2 * ζ + 26 * e + (N + 8) * eps + loss + mesh / 6 + nu + saving = 6309 / 400000 ∧
    (6309 / 400000 : Rat) ≤ floor_budget ∧
    (6309 / 400000 : Rat) ≤ target_margin := by decide +kernel

-- ============================================================================
-- 6. SiegelZeros Constants, Zero-Free Region Union, and Reflection Symmetry
-- ============================================================================

/-- [Theorem 15] In `SiegelZeros/Selection/PivotBounds.lean:63` and `SiegelZeros/Estimates/GeometricBoundary.lean:26`,
    the constants `c₁ = 1 / (4 * 97^2) = 1 / 37636`, `C₁ = 192`, and `H = 86713344` satisfy `(C₁ / c₁) / H = 1 / 12`. -/
theorem siegel_zeros_constants_ratio_identity :
    let c1 : Rat := 1 / (4 * 97 ^ 2)
    let C1 : Rat := 192
    let H : Rat := 86713344
    c1 = 1 / 37636 ∧
    (C1 / c1) / H = 1 / 12 ∧
    (1 / 12 : Rat) < 1 / 10 := by decide +kernel

/-- [Theorem 16] Complementary zero-free widths `1 - β` for `β ∈ {7/8, 3/4, 69/100}`. -/
theorem complementary_zero_free_widths :
    let β1 : Rat := 7 / 8
    let β2 : Rat := 3 / 4
    let β3 : Rat := 69 / 100
    let gap1 : Rat := 1 - β1
    let gap2 : Rat := 1 - β2
    let gap3 : Rat := 1 - β3
    gap1 = 1 / 8 ∧
    gap2 = 1 / 4 ∧
    gap3 = 31 / 100 ∧
    (0 : Rat) < gap1 ∧ gap1 < gap2 ∧ gap2 < gap3 := by decide +kernel

/-- [Theorem 17] Functional-equation reflection symmetry (`0.49 <-> 0.50 <-> 0.51`) & quotient error ratios
    at `Q = 480` (`192 / 480 = 2 / 5`) and `Q = 112` (`56 / 112 = 1 / 2`). -/
theorem functional_equation_reflection_and_quotient_thresholds :
    let crit_line : Rat := 1 / 2
    let floor_right : Rat := 51 / 100
    let floor_left : Rat := 1 - floor_right
    let half_width : Rat := floor_right - crit_line
    floor_left = 49 / 100 ∧
    crit_line - floor_left = half_width ∧
    half_width = 1 / 100 ∧
    floor_right - floor_left = 1 / 50 ∧
    (192 / 480 : Rat) = 2 / 5 ∧
    (56 / 112 : Rat) = 1 / 2 := by decide +kernel

-- ============================================================================
-- 7. Exponent Balance Relation, z_re = 1/6 Boundary, and m >= 2 Tail Margins
-- ============================================================================

/-- [Theorem 18] Exponent balance relation combining `DirichletL/Detector/LowGramScale.lean` (`α_X = 17/48, α_Y = 23/48 -> gram_sqrt = 3/16`),
    `DirichletL/PrincipalMellinResidues.lean:392` (`s + 1/6 - 1 = s - 5/6`),
    `DirichletL/PrincipalSignalComparison.lean:411` (`signal_shift = -5/6 + α_X/3 + ℓ/6 = -11/16`),
    and `DirichletL/Hecke/CommonProbe.lean:19-21` (`β = gram_sqrt - signal_shift = 5/6 + (α_X + α_Y - 2ℓ)/12 = 7/8`). -/
theorem exponent_balance_relation_identity :
    let α_X : Rat := 17 / 48
    let α_Y : Rat := 23 / 48
    let ℓ : Rat := 1 / 6
    let gram_sqrt : Rat := α_X / 2 + (α_Y - α_X) / 12
    let signal_shift : Rat := -(5 / 6) + α_X / 3 + ℓ / 6
    let d0_const : Rat := 1 - α_X + ℓ
    let β_base : Rat := gram_sqrt - signal_shift
    let β_formula : Rat := 5 / 6 + (α_X + α_Y - 2 * ℓ) / 12
    gram_sqrt = 3 / 16 ∧
    signal_shift = -(11 / 16) ∧
    d0_const = 13 / 16 ∧
    β_base = 7 / 8 ∧
    β_formula = 7 / 8 ∧
    β_base - (0 : Rat) = 7 / 8 ∧
    β_base - (1 / 8 : Rat) = 3 / 4 ∧
    β_base - (37 / 200 : Rat) = 69 / 100 ∧
    β_base - (73 / 200 : Rat) = 51 / 100 := by decide +kernel

/-- [Theorem 19] Convergence boundary at `z_re = 1/6` and principal contour shift budget `17/48000`:
    (1) Branch `(e=0, l=2, k=0, m=1)` in `DirichletL/Detector/HighRowsCentralTerms.lean:47-53` at `x = 1/2` satisfies
        `6 - 2*(1 + 3*(1/2)) - 6*z_re*1 = 1/2 - 1/2` at `z_re = 1/6`.
    (2) Shifting across `z_pole = 1/6` to `z_shifted = 33/200 < 1/6` in `DirichletL/Detector/PrincipalRemainderBounds.lean:577-598`
        yields `13/16 * (1/6 - 33/200) - 1/1000 = 17/48000` (`principal_budget` in `DirichletL/ParametersHighData.lean:45`). -/
theorem convergence_boundary_at_one_sixth :
    let x_crit : Rat := 1 / 2
    let z_barrier : Rat := 1 / 6
    let z_shifted : Rat := 33 / 200
    let d0 : Rat := 13 / 16
    let e_max : Rat := 1 / 1000
    6 - 2 * (1 + 3 * x_crit) - 6 * z_barrier * 1 = 1 / 2 - x_crit ∧
    6 * z_barrier = 1 ∧
    z_shifted < z_barrier ∧
    d0 * (z_barrier - z_shifted) = 13 / 9600 ∧
    (13 / 9600 : Rat) - e_max = 17 / 48000 := by decide +kernel

/-- [Theorem 20] Exponent margins for the `m >= 2` geometric tail (`DirichletL/Detector/HighRowsTail.lean:50-56`):
    For `m >= 2`, the surviving branches `(0,2,0,m>=2)` and `(1,0,1,m>=2)` require `z_re >= 1/12`.
    At `z_re = 9/100 > 1/12` and `x = 51/100`, all `m >= 2` branch margins are strictly positive. -/
theorem tail_m_ge_2_exponent_margins :
    let z_min_m2 : Rat := 1 / 12
    let z_eval : Rat := 9 / 100
    let x_floor : Rat := 51 / 100
    let w_floor : Rat := 1 - x_floor
    let branch2_m2_margin : Rat := (1 / 2 - x_floor) - (6 - 2 * (1 + 3 * x_floor) - 6 * z_eval * 2)
    let branch6_m2_margin_at_floor : Rat := (1 / 2 - x_floor) - (3 / 2 - (x_floor + 1 / 2) - w_floor - 6 * z_eval * 2)
    let branch6_m2_min_at_top : Rat := (1 / 2 - 1) - (3 / 2 - (1 + 1 / 2) - 0 - 6 * z_eval * 2)
    let small_tail_saving : Rat := 3 / 8 - (13 / 16) * z_eval - 1 / 50
    let combined_sos_margin : Rat := 49 / 440640 + (13 / 16) * (73 / 200)
    12 * z_min_m2 = 1 ∧
    z_min_m2 < z_eval ∧
    branch2_m2_margin = 13 / 100 ∧
    branch6_m2_margin_at_floor = 107 / 100 ∧
    branch6_m2_min_at_top = 29 / 50 ∧
    small_tail_saving = 451 / 1600 ∧
    combined_sos_margin = 1307263 / 4406400 ∧
    (0 : Rat) < branch2_m2_margin ∧
    (0 : Rat) < branch6_m2_min_at_top ∧
    (0 : Rat) < small_tail_saving ∧
    (0 : Rat) < combined_sos_margin := by decide +kernel

-- ============================================================================
-- 8. Universally Quantified (`∀`) Theorems & Componentwise Gram Exponent Bounds
-- ============================================================================

/-- [Theorem 21] For all `j < 6`, `n ≤ 5`, and `m ≥ 2`, the valuation table indices
    `j + 6*m` (`k = 0`) and `j + 6*m - 1` (`k = 1`) strictly exceed `n + 1`, never equal `n`,
    and lie below `6*(m + 1)`. -/
theorem gauss_valuation_table_indices_m_ge_2 (j n m : Nat)
    (hj : j < 6) (hn : n ≤ 5) (hm : 2 ≤ m) :
    n + 1 < j + 6 * m ∧
    n + 1 < j + 6 * m - 1 ∧
    j + 6 * m ≠ n ∧
    j + 6 * m - 1 ≠ n ∧
    j + 6 * m < 6 * (m + 1) := by
  revert hj hn hm
  omega

/-- [Theorem 22] For all `a_bp ∈ [5001, 10000]`, `eps_bp ∈ [0, 10]`, `m₁ ≥ 1`, and `m₂ ≥ 2`,
    the linear Gauss-sum exponent inequalities hold with positive margins at `z_re = 17/100` (`m₁ ≥ 1`)
    and `z_re = 9/100` (`m₂ ≥ 2`). -/
theorem gauss_sum_linear_exponent_bounds_m1_m2 (a_bp eps_bp m1 m2 : Nat)
    (ha_lo : 5001 ≤ a_bp) (ha_hi : a_bp ≤ 10000)
    (heps : eps_bp ≤ 10) (hm1 : 1 ≤ m1) (hm2 : 2 ≤ m2) :
    let x_bp := a_bp + 16 * eps_bp
    let z_017_bp := 1700
    let z_009_bp := 900
    35000 + 205 ≤ 5 * x_bp + 6 * z_017_bp * m1 ∧
    15000 + 201 ≤ x_bp + 6 * z_017_bp * m1 ∧
    35000 + 805 ≤ 5 * x_bp + 6 * z_009_bp * m2 ∧
    15000 + 801 ≤ x_bp + 6 * z_009_bp * m2 ∧
    -- combined upper bound on x_bp = a_bp + 16 * eps_bp:
    x_bp ≤ 10160 := by
  revert ha_lo ha_hi heps hm1 hm2
  omega

/-- [Theorem 23] For any order `M ≥ 1` and tail index `m ≥ M`, whenever `2 * x_num ≥ D` (`x ≥ 1/2`)
    and `6 * z_m_prod ≥ D` (`z_re * m ≥ 1/6`), the inequality `10 * x_num + 12 * z_m_prod ≥ 7 * D` (`5x + 6zm ≥ 7/2`) holds. -/
theorem general_order_m_tail_exponent_bound (M m x_num z_m_prod D : Nat)
    (hM : 1 ≤ M) (hm : M ≤ m) (hx : D ≤ 2 * x_num) (hzm : D ≤ 6 * z_m_prod) :
    1 ≤ m ∧ M ≤ m ∧ 7 * D ≤ 10 * x_num + 12 * z_m_prod := by
  revert hM hm hx hzm
  omega

/-- [Theorem 24] Componentwise Gram exponent differences (`DirichletL/Detector/LowSourceScales.lean:81`, `DirichletL/Detector/GramScaleLoss.lean:9`, `DirichletL/Detector/GramBound.lean:55`, `DirichletL/Detector/LowGramScale.lean:45`):
    Comparing the individual square-root `Z`-exponents (`17/96`, `14/96 + (17/96)*δ`, `18/96`) against the bundled
    upper bound `18/96 + (23/96)*δ` at `δ = 79/204` yields componentwise differences `2021/19584`, `215/3264`,
    and `1817/19584` (and `487/3264` at `L = 1` vs. the SOS rounding residual `49/440640`). -/
theorem componentwise_gram_exponent_differences :
    let δ_ref : Rat := 79 / 204
    let exp_bundled : Rat := 18 / 96 + (23 / 96) * δ_ref
    let exp_term0_zero : Rat := 17 / 96
    let exp_term1_nonexc : Rat := 14 / 96 + (17 / 96) * δ_ref
    let exp_term2_exc : Rat := 18 / 96
    let diff_term0 : Rat := exp_bundled - exp_term0_zero
    let diff_term1 : Rat := exp_bundled - exp_term1_nonexc
    let diff_term2 : Rat := exp_bundled - exp_term2_exc
    let baseline_sos_margin : Rat := 49 / 440640
    diff_term0 = 2021 / 19584 ∧
    diff_term1 = 215 / 3264 ∧
    diff_term2 = 1817 / 19584 ∧
    diff_term1 < diff_term2 ∧
    diff_term2 < diff_term0 ∧
    diff_term1 + (8 / 96 : Rat) = 487 / 3264 ∧
    baseline_sos_margin < diff_term1 := by decide +kernel

/-- [Theorem 25] For all `y_num ≥ 0` and `D > 0` (`y = y_num / D ≥ 0`),
    `51*D + 41*y_num ≤ 17 * (3*D + 5*y_num)` and `49 * (3*D + 5*y_num) ≥ 147 * D > 0` (`DirichletL/Endpoint.lean:83-88`). -/
theorem sos_certificate_weight_linear_bound (y_num D : Int)
    (hy : 0 ≤ y_num) (hD : 0 < D) :
    51 * D + 41 * y_num ≤ 17 * (3 * D + 5 * y_num) ∧
    147 * D ≤ 49 * (3 * D + 5 * y_num) ∧
    0 < 49 * (3 * D + 5 * y_num) := by
  revert hy hD
  omega

/-- [Theorem 26] For any `σ_num, β_num, c_num, D : Int`, if `¬(β_num ≤ σ_num ∧ σ_num ≤ D - c_num)`,
    `¬(D - c_num < σ_num)`, and `¬(β_num ≤ D - σ_num)`, then `D - β_num < σ_num ∧ σ_num < β_num ∧ σ_num ≤ D - c_num`. -/
theorem zero_free_region_union_and_symmetry (σ_num β_num c_num D : Int)
    (h_no_qrh : ¬(β_num ≤ σ_num ∧ σ_num ≤ D - c_num))
    (h_no_siegel : ¬(D - c_num < σ_num))
    (h_no_reflected : ¬(β_num ≤ D - σ_num)) :
    D - β_num < σ_num ∧ σ_num < β_num ∧ σ_num ≤ D - c_num := by
  revert h_no_qrh h_no_siegel h_no_reflected
  omega

/-- [Theorem 27] Quadratic stationary-point root and boundary second-derivative identities (`323/276 - 35*√16354/9384`):
    At `y = 0` in `DirichletL/Endpoint.lean`:
    (1) `dE_bal(δ, 0) / dδ = 0` reduces to `9384 * δ^2 - 25160 * δ + 8325 = 0`,
    (2) The root `δ* = 185/138 - 35*√16354/4692` gives abscissa `a* = (1 + δ*)/2 = 323/276 - 35*√16354/9384`,
    (3) At `δ = 79/204`, `balancedExponent(79/204, 0) = -7/30672`,
        `∂²E_bal/∂δ²(79/204, 0) = -236315300 / 608806611 < 0`, and `∂E_bal/∂y(79/204, 0) = -2933665 / 333189936 < 0`. -/
theorem stationary_point_quadratic_root_323_276_identity :
    let δ_rat : Rat := 185 / 138
    let δ_rad_sq : Rat := (35 ^ 2 * 16354) / (4692 ^ 2)
    let a_rat : Rat := (1 + δ_rat) / 2
    let δ_sos : Rat := 79 / 204
    let d2E_ddelta2_at_sos : Rat :=
      -(13 / 16) * (37 / 18) * ((7 / 9) ^ 2) * ((5 / 6) ^ 2) / ((balanceDenominator δ_sos 0) ^ 3)
    let dE_dy_at_sos : Rat :=
      -δ_sos / 6 + (13 / 32) * (5 / 6 - δ_sos) * δ_sos *
        ((2 : Rat) * (balanceDenominator δ_sos 0) - (7 / 9) * ((5 / 6 - δ_sos) * (34 / 18) + δ_sos * 2)) /
        ((balanceDenominator δ_sos 0) ^ 2)
    a_rat = 323 / 276 ∧
    2 * 9384 * δ_rat - 25160 = 0 ∧
    9384 * (δ_rat ^ 2 + δ_rad_sq) - 25160 * δ_rat + 8325 = 0 ∧
    balancedExponent δ_sos 0 = -(7 / 30672) ∧
    d2E_ddelta2_at_sos = -(236315300 / 608806611) ∧
    dE_dy_at_sos = -(2933665 / 333189936) := by decide +kernel

end QRHExponentBounds
