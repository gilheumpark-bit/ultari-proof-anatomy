# 03. Expert Critique and Reconstruction: Verbatim Code Audit of the Unimported `650` (`718`) Modules and the 5 Breakthroughs

## 1. Executive Assessment: Recovering the Unimported Master Hub `ForcedComputation/Main.lean`

In our initial forensic audit (`006`) of OpenAI `#376` (`Universal computation in forced Navier-Stokes flows`), we showed that the 6 official Comparator Challenges (`ComparatorChallenges/*.json`) import only `286` `OAI/` files (`354` when `RapidForcing/Main` and `PeriodicLattice/Main` are grouped), all of which use identically zero pressure ($p \equiv 0$) and terminate at step-simulation equivalences ($\text{particle enters box} \leftrightarrow \text{finite-table machine halts}$). In this complete reassembly (`007`), we audited the remaining **`650` (`718` strictly unimported, `73,367` lines)** `OAI/` Lean 4 modules and the October 6, 2026 revision (`Incompressible-Box-Transport-and-Finite-Computation-October-6-2026`), establishing three structural discoveries and five quantitative mathematical breakthroughs:

1. **Discovery of the Unimported Master Hub [`ForcedComputation/Main.lean`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/ForcedComputation/Main.lean#L1-L33)**:
   Not referenced by any `ComparatorChallenges/*.json`, [`ForcedComputation/Main.lean`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/ForcedComputation/Main.lean#L1-L33) imports 30 sub-main modules spanning `770` files (`696` disjoint from the challenge roots) across all 9 papers of Family 376.
2. **Resolution of the Scope Note in `lean/docs/376.md`**:
   `lean/docs/376.md` noted that the paper's fixed-particle halting detector and its reciprocal maps on solid boxes were omitted from `SolenoidalSheetPrograms.json` because that challenge pointed only to `SheetFlows/SheetProgram.lean`. Both theorems are proved with zero gaps in [`ShearFlows/Main.lean:55`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/ShearFlows/Main.lean#L55-L66) (`reciprocal_affine_maps_by_shears`) and [`ForcedComputation/Programs/FixedParticleMain.lean:45`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/ForcedComputation/Programs/FixedParticleMain.lean#L45-L56) (`fixed_particle_effective_computation`).
3. **Genuine Non-Zero Pressure $p = -\phi \neq 0$, Solenoidal Forcing $\operatorname{div} f_{\text{sol}} = 0$, and Unconditional Halting Undecidability**:
   [`PeriodicLattice/Solenoidal.lean:315-366`](../proofs/oai_ref/lean/OAI/Analysis/PeriodicLattice/Solenoidal.lean#L315-L366) solves $\Delta \phi = \operatorname{div} g$ on $\mathbb{T}^3$ so that $p = -\phi \neq 0$ and $\operatorname{div} f_{\text{sol}} = 0$, while [`VelocityUnconditional.lean`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/ForcedComputation/Detector/VelocityUnconditional.lean#L60-L130) and [`FiniteMachineHaltingDischarge.lean`](../proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/ForcedComputation/Programs/FiniteMachineHaltingDischarge.lean#L1-L25) connect Mathlib's `ComputablePred.halting_problem 0` to unconditional fluid observation undecidability.

```lean
-- Source: proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/ForcedComputation/Main.lean:1-32
import OAI.MathematicalPhysics.NavierStokes.ShearFlows.Main
import OAI.Analysis.BoxTransport.Routing
import OAI.MathematicalPhysics.SheetFlows.SheetProgram
import OAI.MathematicalPhysics.RapidForcing.Main
import OAI.MathematicalPhysics.AlternatingFlow.Development
import OAI.Analysis.PeriodicLattice.Main
import OAI.MathematicalPhysics.NavierStokes.ForcedComputation.Programs.InitializedMain
import OAI.MathematicalPhysics.NavierStokes.ForcedComputation.Programs.FixedParticleMain
import OAI.MathematicalPhysics.NavierStokes.ForcedComputation.Programs.StationaryMain
import OAI.MathematicalPhysics.NavierStokes.ForcedComputation.Flow.PlanarProcessorMain
import OAI.MathematicalPhysics.NavierStokes.ForcedComputation.Programs.PeriodicMain
import OAI.MathematicalPhysics.NavierStokes.ForcedComputation.Programs.PrefixMain
import OAI.MathematicalPhysics.NavierStokes.ForcedComputation.Scalar.ScalarDecayMain
import OAI.MathematicalPhysics.NavierStokes.ForcedComputation.Programs.TorusSlowMain
import OAI.MathematicalPhysics.NavierStokes.ForcedComputation.Programs.PeriodicLatticeCorollaryMain
import OAI.MathematicalPhysics.NavierStokes.ForcedComputation.Detector.CompactDetectorMain
import OAI.MathematicalPhysics.NavierStokes.ForcedComputation.Detector.TorusDetectorMain
import OAI.MathematicalPhysics.NavierStokes.ForcedComputation.Detector.ExpandingMain
import OAI.MathematicalPhysics.NavierStokes.ForcedComputation.Programs.ParticleDecisionCorollaries
import OAI.MathematicalPhysics.NavierStokes.ForcedComputation.Programs.RapidDecisionCorollaries
import OAI.MathematicalPhysics.NavierStokes.ForcedComputation.Detector.VelocityDecisionCorollaries
import OAI.MathematicalPhysics.NavierStokes.ForcedComputation.Programs.BalancedCycle
import OAI.MathematicalPhysics.NavierStokes.ForcedComputation.Programs.BalancedMain

import OAI.MathematicalPhysics.NavierStokes.ForcedComputation.Flow.PlanarProcessorUnconditional
import OAI.MathematicalPhysics.NavierStokes.ForcedComputation.Programs.ParticleDecisionUnconditional
import OAI.MathematicalPhysics.NavierStokes.ForcedComputation.Programs.RapidDecisionUnconditional
import OAI.MathematicalPhysics.NavierStokes.ForcedComputation.Detector.ExpandingEnergyDischarge
import OAI.MathematicalPhysics.NavierStokes.ForcedComputation.Flow.TorusVariationsDischarge
import OAI.MathematicalPhysics.NavierStokes.ForcedComputation.Detector.VelocityDecisionDischarge
import OAI.MathematicalPhysics.NavierStokes.ForcedComputation.Detector.VelocityUnconditional
```

---

## 2. Breakthrough #1 Audit: `PeriodicLattice/Solenoidal.lean` & `PeriodicInverse.lean`

### 2.1 Verbatim Verification of Non-Zero Pressure and Solenoidal Forcing (`Solenoidal.lean:315-366`)

```lean
-- Source: proofs/oai_ref/lean/OAI/Analysis/PeriodicLattice/Solenoidal.lean:315-366
def solenoidalForce (ν : ℝ) (d : Input) : VectorField := force ν d - gradient (potential d)

theorem solenoidalForce_contDiff (ν : ℝ) (d : Input) :
    ContDiff ℝ ∞ (lifted (solenoidalForce ν d)) :=
  (force_contDiff ν d).sub (contDiff_gradient (potential_contDiff d))

theorem solenoidalForce_solenoidal (ν : ℝ) (d : Input) : Solenoidal (solenoidalForce ν d) := by
  intro t ht q
  rw [solenoidalForce, divergence_sub (smooth_slice_differentiable (force_contDiff ν d) t)
    (smooth_slice_differentiable (contDiff_gradient (potential_contDiff d)) t),
    ← Pi.sub_apply, ← Pi.sub_apply, divergence_gradient]
  change divergence (force ν d) t q - laplacian (potential d) t q = 0
  rw [potential_poisson, sub_self]

theorem solenoidalForce_meanZero (ν : ℝ) (d : Input) : MeanZero (solenoidalForce ν d) := by
  intro t ht
  change (∫ q, force ν d t q - gradient (potential d) t q ∂torusVolume) = 0
  rw [integral_sub (smooth_slice_integrable (force_contDiff ν d) t)
    (smooth_slice_integrable (contDiff_gradient (potential_contDiff d)) t),
    force_meanZero ν d t ht, integral_gradient (potential_contDiff d) t, sub_self]

theorem solenoidalForce_equations (ν : ℝ) (d : Input) :
    NavierStokes ν (solenoidalForce ν d) (velocity d) (-potential d) := by
  refine ⟨?_, (equations ν d).2⟩
  intro t ht q
  rw [(equations ν d).1 t ht q, Residual.gradient_zero, Pi.zero_apply, Pi.zero_apply,
    neg_zero, zero_add, gradient_neg]
  change ν • laplacian (velocity d) t q + force ν d t q =
    -(-gradient (potential d) t q) + ν • laplacian (velocity d) t q +
      (force ν d t q - gradient (potential d) t q)
  abel

theorem solenoidalForce_classical_solution (ν : ℝ) (d : Input) :
    ClassicalSolution ν (solenoidalForce ν d) (velocity d) (-potential d) := by
  refine classical_of_smooth_pressure (velocity_contDiff d) (potential_contDiff d).neg ?_
    (solenoidalForce_equations ν d)
  intro t ht
  change (∫ q, -potential d t q ∂torusVolume) = 0
  rw [integral_neg, potential_meanZero d t ht, neg_zero]
```

### 2.2 The `45,282,268x` Slack in `PeriodicInverse.lean:183-200`

```lean
-- Source: proofs/oai_ref/lean/OAI/Analysis/PeriodicLattice/PeriodicInverse.lean:183-200
theorem first_weighted_bound (lam t : ℝ) {H : ℝ → ℝ → ℝ} {w C : ℝ} (hw : 0 ≤ w)
    (hC : ∀ y : ℝ, w * ‖H t y‖ ≤ C) (y : ℝ) :
    w * ‖first lam H t y‖ ≤ ‖(1 - Real.exp lam)⁻¹‖ * Real.exp |lam| * C := by
  have hC₀ : 0 ≤ C := (mul_nonneg hw (norm_nonneg _)).trans (hC 0)
  have hi : ‖∫ s in (0 : ℝ)..1, w * (Real.exp (lam * s) * H t (y - s))‖ ≤ Real.exp |lam| * C := by
    have hz := intervalIntegral.norm_integral_le_of_norm_le_const (a := 0) (b := 1)
      (C := Real.exp |lam| * C) (f := fun s => w * (Real.exp (lam * s) * H t (y - s)))
    apply (by simpa only [sub_zero, abs_one, mul_one] using hz : (∀ s ∈ uIoc (0 : ℝ) 1,
        ‖w * (Real.exp (lam * s) * H t (y - s))‖ ≤ Real.exp |lam| * C) → _)
    intro s hs
    have hs' : 0 ≤ s ∧ s ≤ 1 := by
      rw [uIoc_of_le (by norm_num : (0 : ℝ) ≤ 1)] at hs
      exact ⟨hs.1.le, hs.2⟩
    have he : Real.exp (lam * s) ≤ Real.exp |lam| := by
      apply Real.exp_le_exp.mpr
      calc lam * s ≤ |lam| * s := mul_le_mul_of_nonneg_right (le_abs_self lam) hs'.1
           _ ≤ |lam| := by nlinarith [abs_nonneg lam]
```

**Critique and Reconstruction** ([`thm_07`–`thm_10`](../proofs/ns376_unimported_solenoidal_and_leray_bounds.lean#L97-L162)):
Applying `Real.exp (lam * s) ≤ Real.exp |lam|` inside `screened (4 * Real.pi) = first (-4*pi) (first (4*pi) H)` multiplies the negative-exponent step by $e^{4\pi} \approx 286,751.31$ instead of $1$, and fails to integrate the positive kernel $|1 - e^{\pm\lambda}|^{-1}\int_0^1 e^{\pm\lambda s}\,ds = |\lambda|^{-1}$. Replacing the pointwise bound by exact positive-kernel integration tightens the operator norm from $\frac{e^{12\pi}}{(e^{4\pi}-1)^2} \approx 286,753.3131$ to $\frac{1}{16\pi^2} \approx 0.006332574$ (**`45,282,268.18x` tighter**).

---

## 3. Breakthrough #2 Audit: October 6, 2026 3D Torus Leray Constant (`oct06/build/analysis.tex:213-224`)

```tex
% Source: proofs/oai_ref/tex/Incompressible-Box-Transport-and-Finite-Computation-October-6-2026/build/analysis.tex:213-224
For $|\beta|\le r$, Cauchy--Schwarz bounds the absolute sum of the
Fourier series for $\partial_x^\beta G$ by
\[
 \left(\sum_{k\in\Z^3}(1+|\xi_k|^2)^{-2}\right)^{1/2}
 \|G\|_{H^{r+2}}.
\]
The shell $|k|_\infty=n\ge1$ contains $24n^2+2\le26n^2$ points.
Since $\sum_{n\ge1}n^{-2}\le2$, the factor is at most $S_L$.
For the tail $|k|_\infty>N\ge1$, it is at most
\begin{equation}\label{eq:projection-tail}
 \left(26(L/(2\pi))^4/N\right)^{1/2}.
\end{equation}
```

**Critique and Reconstruction** ([`thm_11`–`thm_17`](../proofs/ns376_unimported_solenoidal_and_leray_bounds.lean#L164-L250)):
Keeping $|k|_2 \ge |k|_\infty = n$ with rational bounds $\sum n^{-2} \le \frac{7}{4}$ and $\sum n^{-4} \le \frac{4}{3}$ tightens `52` to $\frac{134}{3} = 44.\overline{6}$ (`thm_12`), while the exact $L^\infty$-shell sum is $4\pi^2 + \frac{\pi^4}{45} \approx 41.6431$ (`thm_13`). Decomposing each cubical shell $S_n$ into 5 Euclidean strata (`thm_14`) reduces the $n=1$ shell from $26$ to $\frac{89}{9} \approx 9.8889$ (`thm_15`) and yields the exact 3D Epstein zeta value $Z_3(2) \approx \mathbf{16.532149}$ (**`3.145x` smaller** than `52`, `thm_17`).

---

## 4. Breakthroughs #3, #4, and #5 Audit: `ShearFlows/Affine.lean`, `VelocityDetectorScales.lean`, and `Material/Encoding.lean`

```lean
-- Source: proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/ShearFlows/Affine.lean:40-52
theorem reciprocal_correction_bound {lam s h : ℝ} (hlam : 0 < lam)
    (hs : |s| ≤ h) (hslam : |s / lam| ≤ h) :
    |(lam⁻¹ - 1) * s| ≤ h := by
  have heq : (lam⁻¹ - 1) * s = s / lam - s := by ring
  rw [heq, abs_le]
  obtain ⟨hslo, hshi⟩ := abs_le.mp hs
  obtain ⟨hqlo, hqhi⟩ := abs_le.mp hslam
  rcases le_total 0 s with hsign | hsign
  · have hq : 0 ≤ s / lam := div_nonneg hsign hlam.le
    constructor <;> linarith
  · have hq : s / lam ≤ 0 := div_nonpos_of_nonpos_of_nonneg hsign hlam.le
    constructor <;> linarith
```

```lean
-- Source: proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/ForcedComputation/Detector/DetectorMargins.lean:17-27
theorem detector_old_mass_margin (L : ℕ) :
    (16 : ℝ) * (massBound L : ℝ) < 1 / 16 := by
  have h := (massBound_real_small L).2
  linarith

theorem detector_wait_margin (L : ℕ) {H : ℝ} (hH : H ≤ 1000000000) :
    H * (massBound L : ℝ) + (16 * (massBound L : ℝ) + 1 / 16) < 1 / 2 := by
  have hm := massBound_real_small L
  have hh := mul_le_mul_of_nonneg_right hH hm.1
  nlinarith
```

```lean
-- Source: proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/Material/Encoding.lean:12-16
def AllowedDigits (b : ℕ) (ds : List ℕ) : Prop :=
  ∀ d ∈ ds, Even d ∧ d + 2 ≤ b

noncomputable def tailBound (b : ℕ) : ℝ := ((b : ℝ) - 2) / ((b : ℝ) - 1)
```

In [`thm_20`–`thm_22`](../proofs/ns376_unimported_solenoidal_and_leray_bounds.lean#L275-L324), [`thm_25`–`thm_32`](../proofs/ns376_detector_margins_and_undecidability_chains.lean#L17-L114), and [`thm_41`–`thm_48`](../proofs/ns376_detector_margins_and_undecidability_chains.lean#L219-L334), we formally prove the $(1 - \min(\lambda, \lambda^{-1}))h$ excursion bound, the `157.5x` mass tightening and `7,560x` $H$-range expansion at $L \ge 1$, the $b$-fold even-digit Cantor cylinder separation $\frac{1}{b-1}$, and the exact rational Banach contraction margins of `StationaryContraction.lean`.
