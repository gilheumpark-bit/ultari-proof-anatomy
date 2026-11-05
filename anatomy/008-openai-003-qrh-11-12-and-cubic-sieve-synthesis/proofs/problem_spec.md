# Problem Specification: OpenAI `#003` QRH Ecosystem Deep Synthesis (Zero-Hint Problem Specification)

## 1. Scope & Target Repositories
- **Primary Upstream Target**: `openai/math` (`mathcommunity/oai-math-revised`, Family `#003`: Quasi-Riemann Hypothesis for Dirichlet and Hecke $L$-Functions):
  1. `preprints/The-Quasi-Riemann-Hypothesis-September-30-2026/build/paper.tex` (`16,677` lines, 199 pages: Part I on Dirichlet $L$-functions at `L520–6809`, Part II on Hecke $L$-functions at `L6810–16677`)
  2. `preprints/The-Quasi-Riemann-Hypothesis-October-5-2026/build/paper2.tex` (`3,988` lines, 49 pages: standalone human-assisted Dirichlet $L$-functions paper)
  3. `lean/OAI/NumberTheory/DirichletL/` (`2,926` `.lean` files), `CubicGauss/` (`30` `.lean` files, `6,252` lines), `CubicGram/` (`45` `.lean` files, `10,446` lines)
- **Follow-up Formalizations Audited in Parallel**:
  1. Alex Kontorovich, `AlexKontorovich/quasi-rh` (`331` `.lean` files: `ElevenTwelfths/Amplification.lean`, `ElevenTwelfths/Nonvanishing.lean`, `docs/argument.md`)
  2. Baiying Liu, `arXiv:2610.12234` (`liubaiying101/Slightly-improved-zero-free-half-planes-for-the-quasi-Riemann-hypothesis`, `229` `.lean` files: `geometry/V2Optimization.lean`, `CombinedPaperVerification.lean`)
  3. `Case 005` (`anatomy/005-openai-003-qrh-mathematician-referee-audit`) and Xu–Sang (`arXiv:2610.15291`).

## 2. Target Symbols & Modules to Audit
1. **Pillar 1 (`DirichletL/` vs. `paper2.tex` & `AlexKontorovich/quasi-rh`)**:
   - `OAI.NumberTheory.DirichletL.RowCompletion.ShortDraft.DirichletTarget` (`ZeroFreeRegion.lean:197–214`, `EisensteinCoordinates.lean:253`) vs. `ElevenTwelfths/Unconditional.lean:118–137` (`paper2.tex:74`)
   - `OAI.NumberTheory.DirichletL.CubicSieve.ClosedRecursion` (`ClosedRecursion.lean:120`) and `MeanSquare.ThetaDensity` (`ThetaDensity.lean:86–93`)
   - `OAI.NumberTheory.DirichletL.Mellin.SixthPowerAverage.outside_totient_moebius_bound` (`SixthPowerAverage.lean:317–331`) and `PrimeRows.NormFiberExtraction` (`NormFiberExtraction.lean:343–355`)
   - `OAI.NumberTheory.DirichletL.CubicSieve.CanonicalDescentScale` (`DescentScale.lean:15–118`) and `ElevenTwelfths/Amplification.lean` (`totientDensity`, `eulerCorrection`, `cauchy_const`)
2. **Pillar 2 (`OAI/NumberTheory/CubicGauss/` & `CubicGram/`)**:
   - `OAI.NumberTheory.CubicGauss.sieveThreshold`, `sieveStep`, `sieveExponent`, and `cubic_large_sieve` (`CubicGauss/Recurrence.lean:350–431`, `CubicGauss/LargeSieve.lean:15–194`, `CubicGauss/Main.lean`)
   - `OAI.NumberTheory.CubicGauss.ScalarBounds` (`mixed_one`, `mixed_two`, `scale_epsilon` in `ScalarBounds.lean:14–114`) and `CubicGram/SieveImprovement.lean:163–274` (`CubicGram/Main.lean`)
3. **Pillar 3 & Pillar 4 (`CubicMoment/Blueprint.lean`, `geometry/V2Optimization.lean`, and Unbundling Hierarchy)**:
   - `OAI.NumberTheory.CubicMoment.Blueprint` (`count`, `energy`, `Face_0`, `Face_K`, `Face_H`) and `V2Optimization.lean` (`delta_c`, `B_Liu`, `B_r`, Farkas dual multipliers)
   - Parametric Farkas shift across `arXiv:2610.12234`, `arXiv:2610.15291`, `Case 005` componentwise Gram + Stickelberger unbundling, and `CubicGauss` Path-A wiring.
