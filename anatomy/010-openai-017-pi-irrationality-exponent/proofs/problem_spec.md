# Problem Specification: OpenAI `#017` The Irrationality Exponent of Pi Is 2 (Zero-Hint Problem Specification)

## 1. Scope & Target Repository
- **Primary Upstream Target**: `openai/math` (`mathcommunity/oai-math-revised`, Family `#017`: *The irrationality exponent of $\pi$ is 2*):
  1. `preprints/The-irrationality-exponent-of-pi-is-2-September-24-2026/build/` (`main.tex`, `references.bib`, and `sections/interpolation.tex`, `sections/determinant.tex`, `sections/conclusion.tex`, `sections/series.tex`)
  2. `lean/ComparatorChallenges/PiExponent.lean` and `lean/ComparatorChallenges/PiExponent.json`
  3. `lean/OAI/NumberTheory/PiExponent/` (`Main.lean`, `Statement.lean`, and all subdirectories `Geometry/`, `LocalAlgebra/`, `Approximation/`, `Cohomology/`, `Ampleness/`, `Jets/`, `Polynomials/`, `Analysis/`)

## 2. Target Symbols & Subsystems to Audit
1. **Pillar 1 (Import-Cone Stratigraphy, Reasoning-Trace Evolution, and Simplex Parameters)**:
   - Import cone of `OAI.NumberTheory.PiExponent.Main` (`pi_eventual_lower_bound`, `pi_integer_eventual_lower_bound`, `pi_irrationalityExponent_eq_two`, `main`, `flint_hills_summable`) versus `ComparatorChallenges/PiExponent.lean` and `lean/docs/017.md`.
   - `OAI.NumberTheory.PiExponent.Approximation.Parameters` (`paramB`, `paramDelta`, `paramTheta`, `paramA`, `paramC`, `paramBigB`) and `Approximation.AdmissibleParameters` (`conclusion.tex` Lemma 4.1).
2. **Pillar 2 (Transverse Multiplicity, Inscribed Discrete Rectangle vs Simplex, and Rees Blowup / Serre-Čech Vanishing)**:
   - `OAI.NumberTheory.PiExponent.Approximation.RectangularVolume`, `Jets.TransverseWeightedMultiplicity`, and `Approximation.WeightSeparationConstant` (`interpolation.tex` Lemma 2.2) versus `Polynomials.SimplexCounting` (`simplex_count_lower_sandwich`).
   - `OAI.NumberTheory.PiExponent.Geometry.CurveZeroPole`, `Ampleness.BlowupIdeal`, `Ampleness.ExceptionalCurveDegree`, `Cohomology.FiniteCoverCohomology`, and `Approximation.WeightSeparation` (`interpolation.tex` Theorem 2.1 and Proposition 2.3).
3. **Pillar 3 (Gaussian-Integer Determinant Clearing, Row Translation, Cauchy-Schwarz Collision, and Flint-Hills)**:
   - `OAI.NumberTheory.PiExponent.Approximation.MatrixArithmetic`, `Approximation.RowTranslation`, `Polynomials.HomogeneousSubmoduleGrading`, `Approximation.DeterminantContradiction`, and `Analysis.DeterminantAnalyticBound` (`determinant.tex` Lemma 3.1, Lemma 3.2, Lemma 3.3, Proposition 3.4).
   - `OAI.NumberTheory.PiExponent.Analysis.FlintConsequence`, `Analysis.FlintSine` (`sineGroup_residue_injective`), and `Approximation.InterpolationConsequence` (`series.tex` Lemma 5.1, Corollary 1.2, Corollary 5.2).
