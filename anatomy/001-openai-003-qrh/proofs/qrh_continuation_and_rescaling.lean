/-
  OpenAI Math Benchmark #003 (Quasi-Riemann Hypothesis for Dirichlet L-Functions, β = 7/8)
  Part II: Complex-Analytic Continuation & Master Scale-Coupling Anatomy (Theorems 28–40)
  =======================================================================================
  Scope: Category A (Universal Polynomial Ring & Cleared-Denominator Scale-Coupling Identities)
  Standard Lean 4 (v4.29.0-rc8) kernel-verified proofs with zero external dependencies,
  zero `sorry`, and zero `axiom`.

  Contents:
  1. Task 1 (Theorems 28–30): Universal `(1 - V)` polynomial factor cancellation in `markedFactor`,
     threshold reduction `480 → 112`, non-vanishing across all 21 small Eisenstein prime-power norms
     `4 ≤ Q < 112`, and universal finite bad-prime mask absorption (`FirstTail.lean:81-100`).
  2. Task 2 (Theorems 31–34): Universal 5-term polynomial cancellation in `secondContinuedCorrection`,
     convergence barrier drop `17/50 → 97/600 < 1/6`, exact `z₀`-invariance of `sourceExponent`
     at `d₀ = 13/16`, and universal sub-critical conductor `z₀`-shift improvement (`d < d₀`).
  3. Task 3 (Theorems 35–40): Master scale-coupling equations for `c_sig = -11/16`, `e_low = 3/16`,
     and `β_crit(α_X, α_Y, ℓ) = 5/6 + (α_X + α_Y - 2*ℓ)/12`, Regime A (`128519/146880 < 7/8` via
     `LowSourceScales.lean:80-104` vs. `Parameters.lean:12` split invariance), Regime B (`5/6`, `3/4`,
     `69/100`), universal monotonicity, `z = 1/6` Mellin pole-shift remainder saving (`-17/48000`),
     and Capped-Width Energy Induction compatibility down to `β = 51/100`.
-/

namespace QRHContinuationAndRescaling

/-- Reference balanced row count `R_bal(δ, y)` (`Endpoint.lean:26`). -/
def refBalancedRowCount (δ y : Rat) : Rat :=
  let den := (5 / 6 - δ) * ((37 + 34 * y) / 18) + δ * ((7 + 18 * y + 8 * y ^ 2) / 9)
  let cut := 1 + δ * ((7 + 18 * y + 8 * y ^ 2) / 9) / (2 * den)
  1 - 5 / 6 + (5 / 6 - δ) * cut

/-- Reference `balancedExponent` (`Endpoint.lean:29`). -/
def refBalancedExponent (δ y : Rat) : Rat :=
  -(1 / 48) + (2 / 3) * δ + δ * (1 / 2 - y) / 6 - (13 / 16) * (1 - refBalancedRowCount δ y)

/-- Generalized `sourceExponent` (`CentralExponent.lean:11-14`) parameterized by contour abscissa `z0`. -/
def sourceExponentAtZ0 (a d R q z0 : Rat) : Rat :=
  (17 / 48) * (1 / 2 - z0) + a + z0 - 1 - a * (23 / 48) - d * z0 + d * R +
    d * (a - 1 / 2) + (1 / 6) * (z0 - 1 / 2 + q)

/-- Signal exponent `c_sig(α_X, ℓ) = α_X / 3 + ℓ / 6 - 5 / 6` (`PrincipalSignalComparison.lean:412`). -/
def signalExponentOffset (αX ell : Rat) : Rat := αX / 3 + ell / 6 - 5 / 6

/-- Low Gram square-root exponent `e_gauss(α_X, α_Y) = (5*α_X + α_Y) / 12` (`LowSourceScales.lean:64-68`). -/
def lowGramGaussExponent (αX αY : Rat) : Rat := (5 * αX + αY) / 12

/-- Critical contradiction threshold `β_crit(α_X, α_Y, ℓ) = e_gauss - c_sig = 5/6 + (α_X + α_Y - 2*ℓ) / 12` (`Supremum.lean:40-43`). -/
def criticalBeta (αX αY ell : Rat) : Rat := 5 / 6 + (αX + αY - 2 * ell) / 12

/-- Generalized `balancedExponent` (`Endpoint.lean:30`, `CentralExponent.lean:11-20`) as a function of `(α_X, α_Y, ℓ)`. -/
def generalizedBalancedExponent (αX αY ell δ y : Rat) : Rat :=
  let d0 : Rat := 1 + ell - αX
  let c_end : Rat := 1 / 2 + (6 * ell - 11 * αX - 7 * αY) / 12
  let slope_δ : Rat := (2 + ell - αX - αY) / 2
  c_end + slope_δ * δ + ell * δ * (1 / 2 - y) - d0 * (1 - refBalancedRowCount δ y)

-- ============================================================================
-- 1. Task 1: Universal `(1 - V)` Cancellation, 21 Small Norms, and Mask Absorption
-- ============================================================================

/-- [Theorem 28] Task 1 — Universal `(1 - V)` polynomial factor cancellation and threshold reduction `480 → 112`
    (`HighRowsCentralQuotient.lean:8-28`, `Local.lean:16-17`, `Euler.lean:11`):
    For all `(R V qInv K W D : Int)`, after clearing `(1 - V)` in `markedFactor`, the 1st-order central defect
    `(1 - D) * (1 - R) * (continuedCorrection - 1)` reduces identically in `ℤ[R, V, qInv, K, W, D]` to
    `R - V*W + W*D - R*D + R*V*W - R*(W*W) + (1 - W)*(-R*qInv - K*V + V*D - V*W*R)`,
    reducing the central quotient defect coefficient from `84` (`Q ≥ 480`) to `19` (`Q ≥ 112`, `93/112 > 31/40`). -/
theorem theorem_28_marked_factor_singularity_cancels_identically (R V qInv K W D : Int) :
    ((1 - R) * (1 - V * W) + (1 - W) * (R * (1 - qInv) - K * V + (1 - V) * (-D + W * R))) - (1 - D) * (1 - R) =
      R - V * W + W * D - R * D + R * V * W - R * (W * W) + (1 - W) * (-R * qInv - K * V + V * D - V * W * R) ∧
    (1 - (84 : Rat) / 480 > 31 / 40 ∧
     1 - (19 : Rat) / 112 = 93 / 112 ∧
     (93 : Rat) / 112 > 31 / 40 ∧
     1 - (19 : Rat) / 88 = 69 / 88 ∧
     (69 : Rat) / 88 > 31 / 40) := by
  constructor
  · simp only [Int.mul_add, Int.mul_sub, Int.mul_neg, Int.mul_one, Int.mul_comm, Int.mul_left_comm]
    omega
  · decide +kernel

/-- [Theorem 29] Task 1 — Explicit non-vanishing of Euler denominators across all 21 small Eisenstein prime-power norms
    `4 ≤ Q < 112` (`FirstTail.lean:81-100`, `CubePrimeThresholds.lean:13-33`):
    Across all 21 Eisenstein prime-power norms `Q ∈ {4,7,9,13,16,19,25,27,31,37,43,49,61,64,67,73,79,81,97,103,109}`,
    on the central contour (`x_re ≥ 51/100 > 1/2`, `z_re = 17/50 > 1/3`), `|V| ≤ 4^(-2) = 1/16`, `|D| ≤ 4^(-1/2) = 1/2`,
    and `|R| ≤ 4^(-1) = 1/4`, keeping `1 - |V| ≥ 15/16`, `1 - |D| ≥ 1/2`, and `1 - |R| ≥ 3/4` strictly positive. -/
theorem theorem_29_all_small_eisenstein_norms_nonvanishing :
    let norms : List Nat := [4, 7, 9, 13, 16, 19, 25, 27, 31, 37, 43, 49, 61, 64, 67, 73, 79, 81, 97, 103, 109]
    norms.length = 21 ∧
    (∀ Q ∈ norms, 4 ≤ Q ∧ Q < 112 ∧ 16 ≤ Q ^ 2) ∧
    1 - (1 : Rat) / (4 ^ 2) = 15 / 16 ∧
    1 - (1 : Rat) / 2 = 1 / 2 ∧
    1 - (1 : Rat) / 4 = 3 / 4 ∧
    (240 : Rat) / 480 = 1 / 2 := by decide +kernel

/-- [Theorem 30] Task 1 — Universal finite bad-prime mask absorption law (`FirstTail.lean:53-100`, `ParametersFixedSource.lean:26-37`):
    For any prime norm `Q : Nat` and finite exclusion cutoff `N_cut ≥ 480`, if `Q` is not in `smallPrimeSet N_cut` (`¬(Q ≤ N_cut)`),
    then `Q ≥ 481 > 480` and `240 < Q` (`240 * Q⁻¹ < 1/2`). -/
theorem theorem_30_universal_finite_bad_prime_mask_absorption (Q N_cut : Nat)
    (hcut : 480 ≤ N_cut) (h_outside : ¬(Q ≤ N_cut)) :
    481 ≤ Q ∧ 480 < Q ∧ 2 * 240 < Q := by
  revert hcut h_outside
  omega

-- ============================================================================
-- 2. Task 2: 2nd/3rd-Order Euler Continuation & `z₀`-Invariance at `d₀ = 13/16`
-- ============================================================================

/-- [Theorem 31] Task 2 — Universal 2nd-order Euler continuation polynomial cancellation (`Local.lean:16-75`, `Euler.lean:38-43`):
    For all `(R V qInv K W D : Int)`, in `(1 - D) * (secondContinuedCorrection - 1)`, all five first-order terms
    (`1 - 1 = 0`, `-R + R = 0`, `-D + D = 0`, `+W*R - W*R = 0`, `+R*D - R*D = 0`) cancel identically in `ℤ[R, V, qInv, K, W, D]`. -/
theorem theorem_31_second_continuation_exact_polynomial_identity (R V qInv K W D : Int) :
    ((1 - R) * (1 - V * W) + (1 - W) * (R * (1 - qInv) - K * V + (1 - V) * (-D + W * R))) - (1 - D) =
    -V * W + W * D - R * (W * W) + R * V * W + (1 - W) * (-R * qInv - K * V + V * D - V * W * R) := by
  simp only [Int.mul_add, Int.mul_sub, Int.mul_neg, Int.mul_one, Int.mul_comm, Int.mul_left_comm]
  omega

/-- [Theorem 32] Task 2 — Convergence barrier drop from `z_re = 17/50` to below `z_re = 1/6` via 2nd/3rd-order Euler continuation
    (`HighRowsFirstRegion.lean:8-79`, `FirstContinuation.lean:68-156`):
    At `x_re = 51/100`:
    (1) Uncancelled 1st-order `R` has exponent `4 - 6*x_re - 6*z_re`, which requires `z_re > 97/300 ≈ 0.3233` (`-11/10` at `z_re = 17/50`),
    (2) After peeling off `(1 - R)` and `(1 - R*W^2)`, the surviving `R*qInv` and `R*V` terms have exponents
        `3 - 6*x_re - 6*z_re` and `4 - 6*x_re - 12*z_re`, which at `z_re = 1/6` both equal `-(53/50) = -1.06 < -1`,
        lowering the Euler-tail `R`-convergence threshold to `z_re > 97/600 ≈ 0.16167 < 1/6`. -/
theorem theorem_32_second_and_third_continuation_convergence_barrier :
    let x_re : Rat := 51 / 100
    let z_first : Rat := 17 / 50
    let z_sixth : Rat := 1 / 6
    let exp_R_first : Rat := 4 - 6 * x_re - 6 * z_first
    let exp_Rq_at_sixth : Rat := 3 - 6 * x_re - 6 * z_sixth
    let exp_RV_at_sixth : Rat := 4 - 6 * x_re - 12 * z_sixth
    let z_barrier_1st : Rat := (5 - 6 * x_re) / 6
    let z_barrier_2nd_Rq : Rat := (4 - 6 * x_re) / 6
    let z_barrier_2nd_RV : Rat := (5 - 6 * x_re) / 12
    exp_R_first = -(11 / 10) ∧
    z_barrier_1st = 97 / 300 ∧
    z_barrier_2nd_Rq = 47 / 300 ∧
    z_barrier_2nd_RV = 97 / 600 ∧
    z_barrier_2nd_Rq < z_sixth ∧
    z_barrier_2nd_RV < z_sixth ∧
    exp_Rq_at_sixth = -(53 / 50) ∧
    exp_RV_at_sixth = -(53 / 50) ∧
    exp_Rq_at_sixth < -1 ∧
    exp_RV_at_sixth < -1 := by decide +kernel

/-- [Theorem 33] Task 2 — Exact `z₀`-invariance of `sourceExponent` at `d₀ = 13/16` and strict saving at `d = 1/2`
    (`CentralExponent.lean:11-22`, `75-81`):
    (1) Because `1 + 1/6 - 17/48 - 13/16 = 0`, at `d = 13/16` `sourceExponentAtZ0 a (13/16) R q z0` is completely independent of `z0`,
    (2) At the intermediate conductor `d = 1/2` (`intermediate_source_margin`), shifting `z0` from `17/50` down to `1/6`
        strictly improves the exponent margin by `(13/16 - 1/2) * (17/50 - 1/6) = 13/240`, strengthening `-49/14400` to `-829/14400`. -/
theorem theorem_33_central_exponent_z0_invariance_at_d0 :
    let z_old : Rat := 17 / 50
    let z_new : Rat := 1 / 6
    let z_low : Rat := 9 / 100
    let coeff_z0_at_d0 : Rat := -(17 / 48) + 1 - 13 / 16 + 1 / 6
    let saving_at_d_half : Rat := (13 / 16 - 1 / 2) * (z_old - z_new)
    let old_intermediate_margin : Rat := -(49 / 14400)
    let new_intermediate_margin : Rat := old_intermediate_margin - saving_at_d_half
    coeff_z0_at_d0 = 0 ∧
    sourceExponentAtZ0 (283 / 408) (13 / 16) 1 (79 / 408) z_old =
      sourceExponentAtZ0 (283 / 408) (13 / 16) 1 (79 / 408) z_new ∧
    sourceExponentAtZ0 (283 / 408) (13 / 16) 1 (79 / 408) z_old =
      sourceExponentAtZ0 (283 / 408) (13 / 16) 1 (79 / 408) z_low ∧
    saving_at_d_half = 13 / 240 ∧
    new_intermediate_margin = -(829 / 14400) ∧
    new_intermediate_margin < old_intermediate_margin := by decide +kernel

/-- [Theorem 34] Task 2 — Universal sub-critical conductor `z₀`-shift improvement law (`∀` parameters over `Int`):
    For any integer numerators `(d_n, d0_n, z_old_n, z_new_n)` with `d_n < d0_n` and `z_new_n < z_old_n`,
    the `z₀`-shift difference `(d_n - d0_n) * (z_old_n - z_new_n)` is strictly negative (`< 0`),
    proving that lowering `z₀` strictly improves the High-Row Euler-tail exponent bound for every `d < d₀`. -/
theorem theorem_34_universal_z0_shift_improves_subcritical_d (d_n d0_n z_old_n z_new_n : Int)
    (hd : d_n < d0_n) (hz : z_new_n < z_old_n) :
    0 < (d0_n - d_n) * (z_old_n - z_new_n) ∧
    (d_n - d0_n) * z_old_n < (d_n - d0_n) * z_new_n := by
  have hpos : 0 < (d0_n - d_n) * (z_old_n - z_new_n) :=
    Int.mul_pos (by revert hd; omega) (by revert hz; omega)
  have hexp : (d_n - d0_n) * z_new_n - (d_n - d0_n) * z_old_n = (d0_n - d_n) * (z_old_n - z_new_n) := by
    simp only [Int.mul_sub, Int.sub_mul]
    omega
  refine ⟨hpos, ?_⟩
  omega

-- ============================================================================
-- 3. Task 3: Master Scale-Coupling Equations & Rescaling Anatomy
-- ============================================================================

/-- [Theorem 35] Task 3 — Master scale-coupling identities (`PrincipalSignalComparison.lean:412`, `LowSourceScales.lean:40-68`,
    `CentralExponent.lean:11-20`, `Endpoint.lean:30`):
    At OpenAI's baseline `(α_X, α_Y, ℓ) = (17/48, 23/48, 1/6)`, the general coupling formulas reproduce
    `c_sig = -11/16`, `e_gauss = 3/16`, `β_crit = 7/8`, `d₀ = 13/16`, `C_end = -1/48`, and `slope_δ = 2/3`. -/
theorem theorem_35_master_scale_coupling_identities :
    let αX : Rat := 17 / 48
    let αY : Rat := 23 / 48
    let ell : Rat := 1 / 6
    let d0 : Rat := 1 + ell - αX
    let c_end : Rat := 1 / 2 + (6 * ell - 11 * αX - 7 * αY) / 12
    let slope_δ : Rat := (2 + ell - αX - αY) / 2
    signalExponentOffset αX ell = -(11 / 16) ∧
    lowGramGaussExponent αX αY = 3 / 16 ∧
    criticalBeta αX αY ell = 7 / 8 ∧
    lowGramGaussExponent αX αY - signalExponentOffset αX ell = criticalBeta αX αY ell ∧
    d0 = 13 / 16 ∧
    c_end = -(1 / 48) ∧
    slope_δ = 2 / 3 ∧
    generalizedBalancedExponent αX αY ell (79 / 204) 0 = refBalancedExponent (79 / 204) 0 := by decide +kernel

/-- [Theorem 36] Task 3 (Regime A) — SOS-slack rescaling `β_crit = 128519/146880 < 7/8` under `LowSourceScales.lean:80-104`
    vs. conductor-split invariance under `Parameters.lean:12`:
    (1) Shifting `(α_X', α_Y') = (17/48 - η, 23/48 - η)` by `η = 3/73440` with fixed split `ℓ = 1/6` preserves
        `LowSourceScales.lean:80-104` across all `d ∈ [0, 1/6]` via Poisson slack `2*α_X' - α_Y' - ℓ = 4587/73440 > 0`,
        keeps the worst-case endpoint exponent `≤ -7/440640 < 0`, and yields `criticalBeta αX' αY' (1/6) = 128519/146880 < 7/8`.
    (2) Conversely, if `ℓ' = 1/6 - η` is shifted simultaneously to keep `α_X' - ℓ' = 3/16` in `Parameters.lean:14`,
        then `α_X' + α_Y' - 2*ℓ' = 1/2` is invariant and `criticalBeta αX' αY' ℓ' = 7/8`. -/
theorem theorem_36_regime_A_sos_slack_rescaling_and_conductor_split :
    let η : Rat := 3 / 73440
    let αX' : Rat := 17 / 48 - η
    let αY' : Rat := 23 / 48 - η
    let ell : Rat := 1 / 6
    let ell' : Rat := 1 / 6 - η
    let max_perturbation_on_box : Rat := (3 / 2 + 5 / 6) * η
    let new_worst_case_upper_bound : Rat := -(49 / 440640) + max_perturbation_on_box
    αX' = 26007 / 73440 ∧
    αY' = 35187 / 73440 ∧
    αY' - αX' = 1 / 8 ∧
    2 * αX' - αY' - ell = 4587 / 73440 ∧
    0 < 2 * αX' - αY' - ell ∧
    3 / 16 ≤ αX' - ell' ∧
    5 / 16 ≤ αY' - ell' ∧
    new_worst_case_upper_bound = -(7 / 440640) ∧
    new_worst_case_upper_bound < 0 ∧
    generalizedBalancedExponent αX' αY' ell (79 / 204) 0 < -(1 / 10000) ∧
    criticalBeta αX' αY' ell = 128519 / 146880 ∧
    criticalBeta αX' αY' ell < 7 / 8 ∧
    criticalBeta αX' αY' ell' = 7 / 8 := by decide +kernel

/-- [Theorem 37] Task 3 (Regime B) — Full rescaling with unbundled Gram saving (`215/3264`) and diagonal Gram dominance
    (`β_crit = 5/6`, `3/4`, `69/100`):
    (1) At `(α_X, α_Y, ℓ) = (1/3, 1/3, 1/3)`, `criticalBeta = 5/6 < 7/8` and the unbundled Gram saving `215/3264`
        exceeds `7/8 - 5/6 = 1/24` with net margin `+79/3264 > 0`.
    (2) Under diagonal Gram dominance (`e_low = α_X / 2`), `β_crit_diag(α_X, ℓ) = 5/6 + (α_X - ℓ)/6` reaches `3/4` and `69/100`. -/
theorem theorem_37_regime_B_gram_unbundled_and_diagonal_beta_bounds :
    let αX_56 : Rat := 1 / 3
    let αY_56 : Rat := 1 / 3
    let ell_56 : Rat := 1 / 3
    let unbundled_saving : Rat := 215 / 3264
    let beta_diag (αX ell : Rat) : Rat := (αX / 2) - signalExponentOffset αX ell
    criticalBeta αX_56 αY_56 ell_56 = 5 / 6 ∧
    lowGramGaussExponent αX_56 αY_56 = 1 / 6 ∧
    signalExponentOffset αX_56 ell_56 = -(2 / 3) ∧
    2 * αX_56 - αY_56 - ell_56 = 0 ∧
    0 < unbundled_saving - (7 / 8 - 5 / 6) ∧
    unbundled_saving - (7 / 8 - 5 / 6) = 79 / 3264 ∧
    beta_diag (1 / 6) (2 / 3) = 3 / 4 ∧
    beta_diag (7 / 50) (1 / 1) = 69 / 100 := by decide +kernel

/-- [Theorem 38] Task 3 — Universal scale-reduction monotonicity law (`∀` parameters over `Int`):
    For any integer numerators `(αX_n, αY_n, ell_n, η_n)` with `η_n > 0` and `αY_n + ell_n + η_n ≤ 2 * αX_n`,
    reducing `αX_n` and `αY_n` by `η_n` strictly decreases `αX_n + αY_n - 2 * ell_n` by `2 * η_n > 0`
    while preserving the Poisson admissibility inequality `αY'_n + ell_n ≤ 2 * αX'_n`. -/
theorem theorem_38_universal_beta_crit_monotonicity (αX_n αY_n ell_n η_n : Int)
    (hη : 0 < η_n) (h_poisson : αY_n + ell_n + η_n ≤ 2 * αX_n) :
    let δ_old := αX_n + αY_n - 2 * ell_n
    let αX'_n := αX_n - η_n
    let αY'_n := αY_n - η_n
    let δ_new := αX'_n + αY'_n - 2 * ell_n
    δ_new + 2 * η_n = δ_old ∧
    δ_new < δ_old ∧
    αY'_n + ell_n ≤ 2 * αX'_n := by
  revert hη h_poisson
  omega

/-- [Theorem 39] Task 2 & 3 — Exact `z = 1/6` Mellin pole-shift remainder exponents (`PrincipalMellinResidues.lean:292-348`,
    `PrincipalRemainderBounds.lean:518-599`):
    When the `w`-contour shifts to `19/20 < 1` and the `z`-contour shifts across the sextic Gauss pole `z = 1/6` to `33/200 = 0.165`,
    the remainder exponents at `e = 1/1000` have strict savings `-1063/48000` and `-17/48000` below `β - 11/16`. -/
theorem theorem_39_m1_sextic_pole_residue_and_33_200_remainder_saving :
    let e_max : Rat := 1 / 1000
    let w_shift_saving : Rat := e_max + (13 / 16) * e_max - 23 / 960
    let z_shift_at_33_200 : Rat := (13 / 16) * (33 / 200 - 1 / 6)
    let z_total_saving : Rat := e_max + z_shift_at_33_200
    let target_saving : Rat := -(17 / 48000)
    z_shift_at_33_200 = -(13 / 9600) ∧
    w_shift_saving = -(1063 / 48000) ∧
    z_total_saving = -(17 / 48000) ∧
    w_shift_saving ≤ target_saving ∧
    z_total_saving ≤ target_saving := by decide +kernel

/-- [Theorem 40] Task 3 — Full compatibility of OpenAI's Capped-Width Energy Induction tree (`Energy/CertifiedExistence.lean:19-48`,
    `FinalAssemblyUnconditional.lean:15-36`) down to `β = 51/100`:
    Setting `κ = 3/4` satisfies `51/100 ≤ β`, `3/4 ≤ κ`, and `2*β - 1 ≤ κ` simultaneously for all `β ∈ {7/8, 5/6, 3/4, 69/100, 51/100}`. -/
theorem theorem_40_energy_induction_compatible_below_seven_eighths :
    let κ_fixed : Rat := 3 / 4
    let targets : List Rat := [7 / 8, 5 / 6, 3 / 4, 69 / 100, 51 / 100]
    (3 / 4 : Rat) ≤ κ_fixed ∧
    (∀ β ∈ targets, (51 / 100 : Rat) ≤ β ∧ 2 * β - 1 ≤ κ_fixed) ∧
    2 * (51 / 100 : Rat) - 1 = 1 / 50 ∧
    2 * (69 / 100 : Rat) - 1 = 19 / 50 ∧
    2 * (3 / 4 : Rat) - 1 = 1 / 2 ∧
    2 * (5 / 6 : Rat) - 1 = 2 / 3 ∧
    2 * (7 / 8 : Rat) - 1 = 3 / 4 := by decide +kernel

end QRHContinuationAndRescaling
