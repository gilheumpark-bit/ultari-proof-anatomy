# Part B 도감 제10권: 최상위 Main.lean 거리 0~4단 척추 및 빌드 보조 모듈 원장

- **범위 설명**: `Main.lean`으로부터 임포트 거리 4 이하 최상단 조립 계층, `Supplements`, `BuildAid` 전수 시그니처
- **수록 파일 수**: `43`개 (`100.00%` 전수 수록)
- **수록 코드 줄 수**: `2,318`줄
- **수록 선언 수**: 총 `192`개 (`theorem`/`lemma` `145`개, `def`/`structure` 등 `47`개)

## 하위 모듈 요약 통계

| 하위 모듈군 | 파일 수 | 줄 수 | 정리 수 | 정의·구조체 수 | 최다 피참조 허브 파일 (`in_degree`) |
| :--- | ---: | ---: | ---: | ---: | :--- |
| `Development.AutomorphicArithmetic.AutomorphicVarieties` | `16` | `1,531` | `102` | `32` | `DiscreteSeriesCoefficientsCuspidal.lean` (`520`) |
| `Development.AutomorphicArithmetic.CharacterBoxes` | `3` | `349` | `12` | `0` | `RiemannHypothesisOfEveryCharacter.lean` (`3`) |
| `Development.WeilBound.RepresentationTheoryGL` | `1` | `135` | `2` | `11` | `BaseChangeIsobaricNOf.lean` (`5`) |
| `Development.AbelianVarietyTheory.Proofs` | `4` | `104` | `5` | `0` | `CrystallineSmoothLiftOfRelations.lean` (`14`) |
| `Development.AutomorphicArithmetic.Foundations` | `7` | `79` | `8` | `0` | `NarrowSwap.lean` (`5`) |
| `Formalism.GammaFactorNonvanishing.CritLine` | `1` | `32` | `3` | `0` | `CritLine.lean` (`1`) |
| `Development.AutomorphicArithmetic.ThetaCorrespondence` | `1` | `18` | `4` | `0` | `SerreTate.lean` (`1`) |
| `Statements` | `1` | `16` | `0` | `4` | `Statements.lean` (`1`) |
| `Supplements.Kernels.MainTheorems` | `1` | `16` | `4` | `0` | `MainTheorems.lean` (`1`) |
| `Main` | `1` | `12` | `5` | `0` | `Main.lean` (`0`) |
| `BuildAid.D1` | `1` | `4` | `0` | `0` | `D1.lean` (`3`) |
| `BuildAid.D2` | `1` | `4` | `0` | `0` | `D2.lean` (`4`) |
| `BuildAid.D3` | `1` | `4` | `0` | `0` | `D3.lean` (`25`) |
| `BuildAid.D4` | `1` | `4` | `0` | `0` | `D4.lean` (`5`) |
| `BuildAid.D5` | `1` | `4` | `0` | `0` | `D5.lean` (`1`) |
| `Supplements.Kernels.MainTheoremsCritical` | `1` | `4` | `0` | `0` | `MainTheoremsCritical.lean` (`1`) |
| `Supplements.Kernels.MainTheoremsAll` | `1` | `2` | `0` | `0` | `MainTheoremsAll.lean` (`1`) |

---

## 모듈군: `Development.AutomorphicArithmetic.AutomorphicVarieties` (`16`개 파일)

### `Development/AutomorphicArithmetic/AutomorphicVarieties/ModularityArgument/ThresholdArguments/DenseThresholdCases/DiscreteSeriesCoefficientsCuspidal.lean` (`1`줄 · 피참조 `520` · Main거리 `4`)
- *(선언 없음: 임포트 집계 또는 옵션·커맨드 전용 모듈)*

### `Development/AutomorphicArithmetic/AutomorphicVarieties/ModularityArgument/ThresholdArguments/DenseThresholdCases/LitAut.lean` (`65`줄 · 피참조 `191` · Main거리 `4`)
- `L12-L30`: `structure LitLocAlt : Prop`
- `L31-L46`: `structure LiteratureAutomorphyHypothesis : Prop`
- `L47-L58`: `structure LiteratureCMHypothesis : Prop`
- `L59-L63`: `structure LiteratureRankNHypothesis : Prop`

### `Development/AutomorphicArithmetic/AutomorphicVarieties/GaloisLibrary/SelmerTransport/Places.lean` (`164`줄 · 피참조 `94` · Main거리 `4`)
- `L5-L164`: `theorem UpperTheory.V.Base.places : ∀ (k Ω : Type) [Field k] [NumberField k] [Field Ω] [Algebra k Ω] [IsAlgClosure k Ω] (l : ℕ) [Fact l.Prime] (A : ValuationSubring Ω), (A ≠ ⊤ → ∃ v : HeightOneSpectrum (𝓞 k), IsPlaceOver A v) ∧ (A = ⊤ → Ine (F` · 전술: `apply,by_contra,exact,ext,obtain,rcases`

### `Development/AutomorphicArithmetic/AutomorphicVarieties/UnitaryThreeGroups/KatoUse.lean` (`68`줄 · 피참조 `50` · Main거리 `4`)
- `L13-L18`: `def KatoUse : Prop`
- `L19-L25`: `structure CohInp : Prop`
- `L26-L35`: `structure Inp : Prop extends CohInp`
- `L36-L43`: `def PropGK : Prop`
- `L44-L53`: `def CorGK : Prop`
- `L54-L65`: `def OneChar : Prop`

### `Development/AutomorphicArithmetic/AutomorphicVarieties/CharacterLevelBounds/PlacesQ.lean` (`152`줄 · 피참조 `30` · Main거리 `4`)
- `L12-L17`: `theorem prime_l : Prime ((l : ℕ) : 𝓞 ℚ)` · 전술: `exact,rw`
- `L18-L22`: `def vQ : HeightOneSpectrum (𝓞 ℚ)` · 전술: `exact,rw`
- `L25-L64`: `theorem isPlaceOver_vQ [Algebra ℚ Ω] [IsAlgClosure ℚ Ω] (A : ValuationSubring Ω) (hA : A.valuation ((l : ℕ) : Ω) < 1) : IsPlaceOver (F` · 전술: `by_contra,exact,obtain,refine,rw`
- `L65-L67`: `theorem val_natCast_le_one (A : ValuationSubring Ω) (n : ℕ) : A.valuation (n : Ω) ≤ 1`
- `L68-L102`: `theorem val_lt_one_iff (A : ValuationSubring Ω) (n : ℕ) (hn : n ≠ 0) : A.valuation (n : Ω) < 1 ↔ ∃ p ∈ n.primeFactors, A.valuation (p : Ω) < 1` · 전술: `by_contra,exact,induction,rw,simp`
- `L103-L122`: `theorem exists_place [CharZero Ω] (p : ℕ) (hp : p.Prime) : ∃ A : ValuationSubring Ω, A.valuation (p : Ω) < 1` · 전술: `exact,obtain,rw`
- `L126-L152`: `theorem UpperTheory.V.Chr.placesQ : ∀ (Ω : Type) [Field Ω] [CharZero Ω] [IsAlgClosure ℚ Ω], (∀ p : ℕ, p.Prime → ∃ A : ValuationSubring Ω, A.valuation (p : Ω) < 1) ∧ (∀ (A : ValuationSubring Ω) (n : ℕ), n ≠ 0 → (A.valuation (n : Ω) < 1 ↔ ∃ p ∈ n.primeFactors, A.valuation (p : Ω) < 1)) ∧ ∀ (p : ℕ) (A A' : ValuationSubring Ω), p.Prime → A.valuation (p : Ω) < 1 → A'.valuation (p : Ω) < 1 → ∃ u : G ℚ Ω, (∀ x ∈ Dec (F` · 전술: `exact,ext,obtain,refine,rw`

### `Development/AutomorphicArithmetic/AutomorphicVarieties/ModularityArgument/AutomorphyLifting/WeakOfAtt.lean` (`115`줄 · 피참조 `27` · Main거리 `4`)
- `L19-L22`: `def Unl1 (r : G F Ω →* GL (Fin n) (Qbar l)) (v : HeightOneSpectrum (𝓞 F)) : Prop`
- `L23-L26`: `def PotUnl (r : G F Ω →* GL (Fin n) (Qbar l)) (v : HeightOneSpectrum (𝓞 F)) : Prop`
- `L27-L31`: `def WitA [IsCMField F] (ι : Qbar l ≃+* ℂ) (r : G F Ω →* GL (Fin n) (Qbar l)) : Prop`
- `L32-L37`: `def IneAb (r : G F Ω →* GL (Fin n) (Qbar l)) : Prop`
- `L38-L41`: `def Flagged (r : G F Ω →* GL (Fin n) (Qbar l)) : Prop`
- `L42-L46`: `def Keeps (r : G F Ω →* GL (Fin n) (Qbar l)) (L : Type) [Field L] [NumberField L] [Algebra F L] [Algebra L Ω] [IsScalarTower F L Ω] : Prop`
- `L47-L48`: `def RowT : Prop`
- `L49-L54`: `def PlainRec : Prop`
- `L55-L63`: `def Thru (b : Bool) : Prop`
- `L64-L69`: `def WeakOfAtt : Prop`
- `L70-L84`: `def FlagLaws : Prop`
- `L85-L89`: `def AIsoTw : Prop`
- `L90-L97`: `def AUpDown : Prop`
- `L98-L104`: `def ARead : Prop`
- `L105-L114`: `theorem aRead_of (H : PlainRec) : ARead` · 전술: `exact,obtain`

### `Development/AutomorphicArithmetic/AutomorphicVarieties/HeightAndVanishing/SplittingFieldIsoQuadratic.lean` (`67`줄 · 피참조 `7` · Main거리 `4`)
- `L8-L49`: `theorem splitting_field_iso_quadratic (p : ℕ) (hp : 0 < p) (K : Type) [Field K] [NumberField K] (hK : Module.finrank ℚ K = 2) (δ : K) (hδ : δ ^ 2 = -(p : K)) (L : Type) [Field L] [NumberField L] [hL : IsSplittingField ℚ L (X ^ 2 + C (p : ℚ) : ℚ[X])] : Nonempty (L ≃ₐ[ℚ] K)` · 전술: `exact,linarith,norm_num,obtain,omega,positivity`
- `L50-L67`: `theorem UpperTheory.V.HV.kstar : ∀ p : ℕ, p.Prime → p % 4 = 3 → discr (Kstar p) = -(p : ℤ) ∧ IsTotallyComplex (Kstar p) ∧ Module.finrank ℚ (Kstar p) = 2 ∧ ∃ s : Kstar p, s ^ 2 = -(p : Kstar p)` · 전술: `exact,obtain,rw`

### `Development/AutomorphicArithmetic/AutomorphicVarieties/HeightAndVanishing/KstarRam.lean` (`76`줄 · 피참조 `3` · Main거리 `4`)
- `L8-L17`: `theorem sqrt_div_mul_eq_sqrt_mul (p : ℕ) (L : Type) [Field L] [Algebra ℚ L] [h : IsSplittingField ℚ L (X ^ 2 + C (p : ℚ) : ℚ[X])] : ∃ s : L, s ^ 2 = -(p : L)` · 전술: `norm_num,obtain,refine,rw`
- `L19-L22`: `theorem sqrt_kstar (p : ℕ) : ∃ s : Kstar p, s ^ 2 = -(p : Kstar p)` · 전술: `exact`
- `L23-L76`: `theorem UpperTheory.V.HV.kstarRam : ∀ p : ℕ, p.Prime → p % 4 = 3 → ∀ (Ω : Type) [Field Ω] [CharZero Ω] [IsAlgClosure ℚ Ω] [Algebra (Kstar p) Ω] (A : ValuationSubring Ω), A.valuation (p : Ω) < 1 → ¬ Ine (F` · 전술: `exact,norm_num,obtain,omega,rcases,ring`

### `Development/AutomorphicArithmetic/AutomorphicVarieties/ModularityArgument/LinkedUnramifiedChains/WeightInfinitesimalCharacters/OneCharU.lean` (`89`줄 · 피참조 `3` · Main거리 `4`)
- `L12-L68`: `theorem oneChar_unramU (hC : U3.CohInp) (hLM : LemmaM) (hLM' : LemmaM') (hLP : LemmaP) (hK : Z.Kato.KatoTwo) (hRI : Th.RigI) (hRII : Th.RigII) (hAd : AdmI) (hA : Aut.AutomorphyUnramifiedCoefficients) (Ω : Type) [Field Ω] [CharZero Ω] [IsAlgClosure ℚ Ω] (K : Type) [Field K] [NumberField K] [IsCMField K] [Algebra K Ω] [IsAlgClosure K Ω] (l : ℕ) [Fact l.Prime] (c : Coef l) (N : ℕ) [NeZero N] (e : ℕ) (ψ : DirichletCharacter c.O N) (he : eO l c.O = 1) (hG : GD Ω K l e ψ) (ι : Qbar l ≃+* ℂ) (σ : G K Ω) (t : Qbar l) (ht : t = algebraMap c.O (PadicAlgCl l) ((Chr.Psi l e (Chr.dirG ℚ Ω ψ) (galEmb ℚ K Ω σ) : c.O) + 1 + (((Chr.Psi l e (Chr.dirG ℚ Ω ψ) (galEmb ℚ K Ω σ))⁻¹ : c.Oˣ) : c.O)))` · 전술: `congr,exact,obtain,rcases,refine,rw`
- `L69-L89`: `theorem UpperTheory.V.Z.J.oneCharU : U3.CohInp → LemmaM → LemmaM' → LemmaP → Z.Kato.KatoTwo → Th.RigI → Th.RigII → AdmI → Aut.AutomorphyUnramifiedCoefficients → OneCharU` · 전술: `congr,exact,ext,obtain,refine,rw`

### `Development/AutomorphicArithmetic/AutomorphicVarieties/SmallClassNumbers/ClassNumberThree.lean` (`115`줄 · 피참조 `3` · Main거리 `3`)
- `L13-L15`: `def len (Ω : Type) [Field Ω] [CharZero Ω] (l : ℕ) [Fact l.Prime] (c : Coef l) (e : ℕ) : ℕ∞`
- `L16-L21`: `def Bound : Prop`
- `L22-L31`: `theorem vlen_one (Ω : Type) [Field Ω] [CharZero Ω] [IsAlgClosure ℚ Ω] (l : ℕ) [Fact l.Prime] (c : Coef l) (e : ℕ) : Vlen Ω c e (1 : DirichletCharacter c.O 2) = len Ω l c e` · 전술: `ext,rw,simp`
- `L32-L43`: `theorem classNumber_three : classNumber (Kstar 3) = 1` · 전술: `apply,nlinarith,norm_num,obtain,omega,rw`
- `L44-L58`: `theorem val_not_lt {Ω : Type} [Field Ω] (A : ValuationSubring Ω) {p n : ℕ} (hc : p.Coprime n) (hp : A.valuation (p : Ω) < 1) : ¬ A.valuation (n : Ω) < 1` · 전술: `exact,obtain,refine,rw`
- `L59-L63`: `theorem eq_one {O : Type} [CommRing O] (ψ : DirichletCharacter O 2) : ψ = 1` · 전술: `ext,rw,simp`
- `L64-L87`: `theorem gd (Ω : Type) [Field Ω] [CharZero Ω] [IsAlgClosure ℚ Ω] [Algebra (Kstar 3) Ω] (l : ℕ) [hl : Fact l.Prime] (e : ℕ) (he : 1 ≤ e) (hev : Even e) (h5 : 5 ≤ l) (hg : ¬ l - 1 ∣ 2 * e) {O : Type} [CommRing O] : GD Ω (Kstar 3) l e (1 : DirichletCharacter O 2)` · 전술: `norm_num,obtain,omega,refine,rw,simp`
- `L88-L112`: `theorem bound_of (hG : U3.CorGK) : Bound` · 전술: `exact,nlinarith,norm_num,obtain,positivity,refine`

### `Development/AutomorphicArithmetic/AutomorphicVarieties/ModularityArgument/ThresholdArguments/DenseThresholdCases/TopMainZj.lean` (`75`줄 · 피참조 `2` · Main거리 `3`)
- `L18-L37`: `theorem UpperTheory.One.Join.local_inputs_from_literature (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) : _root_.GlobalTheory.Mem.LiteralAutomorphy.LitLocAlt`
- `L38-L54`: `theorem UpperTheory.One.Join.automorphic_inputs_from_literature (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) (bc : _root_.PositivityTheory.Rg.BcN.BaseChangeIsobaricN) (gal : _root_.UpperTheory.V.Z.Win.RowT) : _root_.GlobalTheory.Mem.LiteralAutomorphy.LiteratureAutomorphyHypothesis`
- `L55-L58`: `theorem UpperTheory.One.Join.v_window_of_depth_zero_residual_bc_cm (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) (bc : _root_.PositivityTheory.Rg.BcN.BaseChangeIsobaricN) (gal : _root_.UpperTheory.V.Z.Win.RowT) (cm : _root_.GlobalTheory.Mem.LiteralAutomorphy.LiteratureCMHypothesis) : UpperTheory.Top.VWin`
- `L59-L70`: `theorem UpperTheory.One.Join.cm_abelian_inputs_from_literature (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) : _root_.GlobalTheory.Mem.LiteralAutomorphy.LiteratureCMHypothesis`
- `L71-L74`: `theorem UpperTheory.One.Join.automorphic_window_of_inputs (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) (bc : _root_.PositivityTheory.Rg.BcN.BaseChangeIsobaricN) (gal : _root_.UpperTheory.V.Z.Win.RowT) : UpperTheory.Top.VWin`

### `Development/AutomorphicArithmetic/AutomorphicVarieties/ModularityArgument/ThresholdArguments/DenseThresholdCases/TemperedProductOfSquareIntegrable.lean` (`344`줄 · 피참조 `1` · Main거리 `4`)
- `L207-L208`: `structure UpperTheory.LiteratureTheorems.OpenImageCondition : Prop`
- `L209-L210`: `theorem UpperTheory.LiteratureTheorems.elliptic_main_theorem_cm_of_open (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) : GlobalTheory.Published.EllipticMainTheoremCM`
- `L211-L212`: `theorem UpperTheory.LiteratureTheorems.hecke_tate_functional_equation_of_open (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) : GlobalTheory.Published.HeckeTateFunctionalEquation`
- `L213-L214`: `theorem UpperTheory.LiteratureTheorems.hilbert_class_field_j_of_open (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) : GlobalTheory.Published.HilbertClassFieldJ`
- `L215-L216`: `theorem UpperTheory.LiteratureTheorems.partial_zeta_functional_equation_of_open (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) : GlobalTheory.Published.PartialZetaFunctionalEquation`
- `L217-L218`: `theorem UpperTheory.LiteratureTheorems.deligne_ribet_of_open (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) : GlobalTheory.Published.DeligneRibet`
- `L219-L220`: `theorem UpperTheory.LiteratureTheorems.siegel_klingen_deligne_ribet_of_open (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) : GlobalTheory.Published.SiegelKlingenDeligneRibet`
- `L221-L222`: `theorem UpperTheory.LiteratureTheorems.abelian_de_rham_of_open (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) : GlobalTheory.Published.AbelianDeRham`
- `L223-L224`: `theorem UpperTheory.LiteratureTheorems.de_rham_pot_semistable_of_open (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) : GlobalTheory.Published.DeRhamPotSemistable`
- `L225-L226`: `theorem UpperTheory.LiteratureTheorems.global_artin_reciprocity_of_open (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) : GlobalTheory.Published.GlobalArtinReciprocity`
- `L227-L228`: `theorem UpperTheory.LiteratureTheorems.hecke_ladic_character_de_rham_of_open (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) : GlobalTheory.Published.HeckeLAdicCharacterDeRham`
- `L229-L230`: `theorem UpperTheory.LiteratureTheorems.algebraic_character_wd_of_open (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) : GlobalTheory.Published.AlgebraicCharacterWD`
- `L231-L232`: `theorem UpperTheory.LiteratureTheorems.automorphic_forms_finite_gl_of_open (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) : GlobalTheory.Published.AutomorphicFormsFiniteGL`
- `L233-L234`: `theorem UpperTheory.LiteratureTheorems.bernstein_unitary_product_irreducible_of_open (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) : GlobalTheory.Published.BernsteinUnitaryProductIrreducible`
- `L235-L236`: `theorem UpperTheory.LiteratureTheorems.bernstein_zelevinsky_finiteness_of_open (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) : GlobalTheory.Published.BernsteinZelevinskyFiniteness`
- `L237-L238`: `theorem UpperTheory.LiteratureTheorems.bloch_kato_local_of_open (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) : GlobalTheory.Published.BlochKatoLocal`
- `L239-L240`: `theorem UpperTheory.LiteratureTheorems.brauer_degree_zero_of_open (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) : GlobalTheory.Published.BrauerDegreeZero`
- `L241-L242`: `theorem UpperTheory.LiteratureTheorems.ess_square_integrable_segments_of_open (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) : GlobalTheory.Published.EssSquareIntegrableSegments`
- `L243-L244`: `theorem UpperTheory.LiteratureTheorems.local_converse_gl_of_open (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) : GlobalTheory.Published.LocalConverseGL`
- `L245-L246`: `theorem UpperTheory.LiteratureTheorems.cusp_forms_bounded_gl_of_open (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) : GlobalTheory.Published.CuspFormsBoundedGL`
- `L247-L248`: `theorem UpperTheory.LiteratureTheorems.jacquet_shalika_rigidity_of_open (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) : GlobalTheory.Published.JacquetShalikaRigidity`
- `L249-L250`: `theorem UpperTheory.LiteratureTheorems.gelfand_kazhdan_dual_of_open (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) : GlobalTheory.Published.GelfandKazhdanDual`
- `L251-L252`: `theorem UpperTheory.LiteratureTheorems.generic_unlinked_gl_of_open (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) : GlobalTheory.Published.GenericUnlinkedGL`
- `L253-L254`: `theorem UpperTheory.LiteratureTheorems.chevalley_units_of_open (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) : GlobalTheory.Published.ChevalleyUnits`
- `L255-L256`: `theorem UpperTheory.LiteratureTheorems.bernstein_zelevinsky_geometric_of_open (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) : GlobalTheory.Published.GeometricLemma`
- `L257-L258`: `theorem UpperTheory.LiteratureTheorems.grothendieck_ring_polynomial_of_open (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) : GlobalTheory.Published.GrothendieckRingPolynomial`
- `L259-L260`: `theorem UpperTheory.LiteratureTheorems.segment_representation_of_open (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) : GlobalTheory.Published.SegmentRepresentation`
- `L261-L262`: `theorem UpperTheory.LiteratureTheorems.zelevinsky_polynomial_ring_of_open (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) : GlobalTheory.Published.ZelevinskyPolynomialRing`
- `L263-L264`: `theorem UpperTheory.LiteratureTheorems.depth_zero_induction_of_open (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) : GlobalTheory.Published.DepthZeroInduction`
- `L265-L266`: `theorem UpperTheory.LiteratureTheorems.langlands_exhaustion_gl_of_open (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) : GlobalTheory.Published.LanglandsExhaustionGL`
- `L267-L268`: `theorem UpperTheory.LiteratureTheorems.langlands_multisegments_of_open (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) : GlobalTheory.Published.LanglandsMultisegments`
- `L269-L270`: `theorem UpperTheory.LiteratureTheorems.standard_cosocle_gl_of_open (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) : GlobalTheory.Published.StandardCosocleGL`
- `L271-L272`: `theorem UpperTheory.LiteratureTheorems.irreducible_admissible_gl_of_open (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) : GlobalTheory.Published.IrreducibleAdmissibleGL`
- `L273-L274`: `theorem UpperTheory.LiteratureTheorems.standard_functors_finite_length_of_open (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) : GlobalTheory.Published.StandardFunctorsFiniteLength`
- `L275-L276`: `theorem UpperTheory.LiteratureTheorems.tempered_product_of_square_integrable_of_open (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) : GlobalTheory.Published.TemperedProductOfSquareIntegrable`
- `L277-L278`: `theorem UpperTheory.LiteratureTheorems.clozel_cohomological_of_open (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) : GlobalTheory.Published.ClozelCohomological`
- `L279-L280`: `theorem UpperTheory.LiteratureTheorems.clozel_purity_of_open (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) : GlobalTheory.Published.ClozelPurity`
- `L281-L282`: `theorem UpperTheory.LiteratureTheorems.cusp_rapid_decay_of_open (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) : GlobalTheory.Published.CuspRapidDecay`
- `L283-L284`: `theorem UpperTheory.LiteratureTheorems.cuspidal_spectrum_gl_of_open (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) : GlobalTheory.Published.CuspidalSpectrumGL`
- `L285-L286`: `theorem UpperTheory.LiteratureTheorems.green_regular_characters_of_open (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) : GlobalTheory.Published.GreenRegularCharacters`
- `L287-L288`: `theorem UpperTheory.LiteratureTheorems.abelian_lifting_of_open (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) : GlobalTheory.Published.AbelianLifting`
- `L289-L290`: `theorem UpperTheory.LiteratureTheorems.grothendieck_deformation_of_open (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) : GlobalTheory.Published.GrothendieckDeformation`
- `L291-L292`: `theorem UpperTheory.LiteratureTheorems.harish_chandra_finite_of_open (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) : GlobalTheory.Published.HarishChandraFinite`
- `L293-L294`: `theorem UpperTheory.LiteratureTheorems.hecke_ladic_character_crystalline_of_open (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) : GlobalTheory.Published.HeckeLAdicCharacterCrystalline`
- `L295-L296`: `theorem UpperTheory.LiteratureTheorems.hecke_ladic_character_above_of_open (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) : GlobalTheory.Published.HeckeLAdicCharacterAbove`
- `L297-L298`: `theorem UpperTheory.LiteratureTheorems.jacquet_shalika_of_open (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) : GlobalTheory.Published.JacquetShalika`
- `L299-L300`: `theorem UpperTheory.LiteratureTheorems.moy_prasad_jacquet_iso_of_open (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) : GlobalTheory.Published.MoyPrasadJacquetIso`
- `L301-L302`: `theorem UpperTheory.LiteratureTheorems.poitou_tate_normalised_of_open (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) : GlobalTheory.Published.PoitouTateNormalised`
- `L303-L304`: `theorem UpperTheory.LiteratureTheorems.ray_class_field_st_of_open (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) : GlobalTheory.Published.RayClassFieldSt`
- `L305-L306`: `theorem UpperTheory.LiteratureTheorems.square_integrable_segment_of_open (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) : GlobalTheory.Published.SquareIntegrableSegment`
- `L307-L308`: `theorem UpperTheory.LiteratureTheorems.totally_disjoint_product_irreducible_of_open (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) : GlobalTheory.Published.TotallyDisjointProductIrreducible`
- `L309-L310`: `theorem UpperTheory.LiteratureTheorems.dual_abelian_scheme_of_open (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) : GlobalTheory.Published.DualAbelianScheme`
- `L311-L312`: `theorem UpperTheory.LiteratureTheorems.global_euler_char_of_open (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) : ReciprocityTheory.Gal.GlobalEulerChar`
- `L313-L314`: `theorem UpperTheory.LiteratureTheorems.global_finiteness_of_open (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) : ReciprocityTheory.Gal.GlobalFiniteness`
- `L315-L316`: `theorem UpperTheory.LiteratureTheorems.localEulerChar_alt (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) : ReciprocityTheory.Gal.LocalEulerChar`
- `L317-L318`: `theorem UpperTheory.LiteratureTheorems.local_finiteness_of_open (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) : ReciprocityTheory.Gal.LocalFiniteness`
- `L319-L320`: `theorem UpperTheory.LiteratureTheorems.local_tate_duality_of_open (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) : ReciprocityTheory.Gal.LocalTateDuality`
- `L321-L322`: `theorem UpperTheory.LiteratureTheorems.greenberg_wiles_of_open (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) : ReciprocityTheory.Gal.GreenbergWiles`
- `L323-L324`: `theorem UpperTheory.LiteratureTheorems.unramified_orthogonality_of_open (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) : ReciprocityTheory.Gal.UnramifiedOrthogonality`
- `L325-L326`: `theorem UpperTheory.LiteratureTheorems.local_euler_char_k_of_open (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) : Formalism.GaloisCohomology.LocalEulerCharK`
- `L327-L328`: `theorem UpperTheory.LiteratureTheorems.local_finiteness_k_of_open (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) : Formalism.GaloisCohomology.LocalFinitenessK`
- `L329-L330`: `theorem UpperTheory.LiteratureTheorems.local_tate_duality_k_of_open (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) : Formalism.GaloisCohomology.LocalTateDualityK`
- `L331-L343`: `theorem UpperTheory.LiteratureTheorems.galois_cohomology_from_literature (O : _root_.UpperTheory.LiteratureTheorems.OpenImageCondition) : GlobalTheory.Mem.LiteralAutomorphy.LitCoh`

### `Development/AutomorphicArithmetic/AutomorphicVarieties/ModularityArgument/ThresholdArguments/DenseThresholdCases/WindowBoundOfLiteratureLevel.lean` (`35`줄 · 피참조 `1` · Main거리 `4`)
- `L25-L29`: `theorem vwin_of_hypotheses_H_E_alt (hH : _root_.UpperTheory.V.Af.HypothesesH') : VWin`
- `L30-L31`: `theorem v_window_of_automorphy_csd_ss_mono_odd (hN : _root_.GlobalTheory.Mem.LiteralAutomorphy.LiteratureRankNHypothesis) : VWin`
- `L33-L34`: `theorem UpperTheory.V.v_window_of_literal_automorphy_n (hN : _root_.GlobalTheory.Mem.LiteralAutomorphy.LiteratureRankNHypothesis) : VWin`

### `Development/AutomorphicArithmetic/AutomorphicVarieties/SmallClassNumbers/CorGKOf.lean` (`29`줄 · 피참조 `1` · Main거리 `2`)
- `L10-L19`: `theorem corGK_of (hH : UpperTheory.V.Af.HypothesesH') : U3.CorGK`
- `L20-L24`: `theorem litN : GlobalTheory.Mem.LiteralAutomorphy.LiteratureRankNHypothesis`
- `L25-L26`: `theorem corGK : U3.CorGK`
- `L27-L28`: `theorem bound : Bound`

### `Development/AutomorphicArithmetic/AutomorphicVarieties/SmallClassNumbers/LenEqZeroIff.lean` (`95`줄 · 피참조 `1` · Main거리 `3`)
- `L9-L11`: `theorem QO_eq (l : ℕ) [Fact l.Prime] (O : Type) [CommRing O] [Algebra ℤ_[l] O] : QO l O = (O ⊗[ℤ_[l]] (ℚ_[l] ⧸ ZlSub l))`
- `L12-L14`: `theorem ZlSub_eq (l : ℕ) [Fact l.Prime] : ZlSub l = (1 : Submodule ℤ_[l] ℚ_[l])` · 전술: `exact,ext,simp`
- `L17-L18`: `def chi (g : Ω ≃ₐ[ℚ] Ω) : c.O`
- `L19-L26`: `def Vanish : Prop`
- `L27-L32`: `theorem act (g : Ω ≃ₐ[ℚ] Ω) (m : QO l c.O) : twist₂ l (chiO ℚ Ω l c.O ^ (-(e : ℤ))) g m = chi Ω l c e g • m` · 전술: `rw`
- `L33-L64`: `theorem len_eq_zero_iff : len Ω l c e = 0 ↔ Vanish Ω l c e` · 전술: `exact,obtain,refine,rw`
- `L65-L69`: `def Large : Prop`
- `L70-L85`: `theorem large_of (h : Bound) : Large` · 전술: `by_contra,exact,nlinarith,obtain,rcases,refine`
- `L86-L92`: `theorem exists_coef (l : ℕ) [Fact l.Prime] : ∃ c : Coef l, c.O = ⊥` · 전술: `exact,rw`

### `Development/AutomorphicArithmetic/AutomorphicVarieties/SmallClassNumbers/OnePoint.lean` (`41`줄 · 피참조 `1` · Main거리 `3`)
- `L10-L17`: `def UpperTheory.V.SmallClassNumbers.OnePoint : Prop`
- `L18-L41`: `theorem UpperTheory.V.SmallClassNumbers.onePoint (hC : U3.CohInp) (hLM : LemmaM) (hLM' : LemmaM') (hLP : LemmaP) (hK : Z.Kato.KatoTwo) (hRI : Th.RigI) (hRII : Th.RigII) (hAd : AdmI) (hA : Aut.AutomorphyUnramifiedCoefficients) : UpperTheory.V.SmallClassNumbers.OnePoint` · 전술: `by_contra,exact,obtain,rcases,refine,rw`

## 모듈군: `Development.AutomorphicArithmetic.CharacterBoxes` (`3`개 파일)

### `Development/AutomorphicArithmetic/CharacterBoxes/RiemannHypothesisOfEveryCharacter.lean` (`231`줄 · 피참조 `3` · Main거리 `5`)
- `L211-L214`: `theorem UpperTheory.zeta_ne_zero_of_everyCharacter (h : UpperTheory.EveryCharacter) : ∀ s : ℂ, 1 / 2 < s.re → s ≠ 1 → riemannZeta s ≠ 0`
- `L215-L231`: `theorem UpperTheory.riemannHypothesis_of_everyCharacter (h : UpperTheory.EveryCharacter) : RiemannHypothesis` · 전술: `by_contra,exact,linarith,norm_num,obtain,rcases`

### `Development/AutomorphicArithmetic/CharacterBoxes/ClaimStrip.lean` (`104`줄 · 피참조 `1` · Main거리 `4`)
- `L7-L22`: `theorem factor_ne_zero {M : ℕ} (ψ : DirichletCharacter ℂ M) {s : ℂ} (hs : 0 < s.re) (p : ℕ) (hp : p.Prime) : (1 : ℂ) - ψ p * (p : ℂ) ^ (-s) ≠ 0` · 전술: `calc,exact,linarith,rw`
- `L23-L34`: `theorem prim_zero {N : ℕ} [NeZero N] (χ : DirichletCharacter ℂ N) [NeZero χ.conductor] {s : ℂ} (hs0 : 0 < s.re) (hs1 : s.re < 1) (h : DirichletCharacter.LFunction χ s = 0) : DirichletCharacter.LFunction χ.primitiveCharacter s = 0` · 전술: `exact,obtain,rcases,rw`
- `L35-L41`: `theorem gamma_ne_zero {M : ℕ} [NeZero M] (φ : DirichletCharacter ℂ M) {t : ℂ} (ht : 0 < t.re) : DirichletCharacter.gammaFactor φ t ≠ 0` · 전술: `exact,linarith,rcases,rw`
- `L42-L58`: `theorem prim_reflect {M : ℕ} [NeZero M] (ψ : DirichletCharacter ℂ M) (hψ : ψ.IsPrimitive) {s : ℂ} (hs0 : 0 < s.re) (hs1 : s.re < 1) (h : DirichletCharacter.LFunction ψ s = 0) : DirichletCharacter.LFunction ψ⁻¹ (1 - s) = 0` · 전술: `exact,linarith,rw`
- `L59-L74`: `theorem strip (h : HalfPlane) : Strip` · 전술: `exact,linarith,rcases,rw`
- `L75-L101`: `theorem zeta (h : HalfPlane) : Zeta` · 전술: `exact,linarith,norm_num,obtain,rcases,ring`
- `L102-L103`: `theorem zeta_iff : Zeta ↔ RiemannHypothesis`

### `Development/AutomorphicArithmetic/CharacterBoxes/MainConclusion.lean` (`14`줄 · 피참조 `1` · Main거리 `4`)
- `L7-L9`: `theorem UpperTheory.FinalTheorems.everyCharacter_of_row (h : UpperTheory.GalStar.Row0b fun h rc => UpperTheory.Zero.LLC.IsRecT h rc) : UpperTheory.EveryCharacter`
- `L10-L12`: `theorem UpperTheory.FinalTheorems.everyCharacter : UpperTheory.EveryCharacter`
- `L13-L14`: `theorem UpperTheory.FinalTheorems.riemannHypothesis : RiemannHypothesis`

## 모듈군: `Development.WeilBound.RepresentationTheoryGL` (`1`개 파일)

### `Development/WeilBound/RepresentationTheoryGL/ArchimedeanBaseChange/ArchimedeanBaseChangeProof/BaseChangeIsobaricNOf.lean` (`135`줄 · 피참조 `5` · Main거리 `4`)
- `L18-L20`: `def CsdAsc {E : Type} [Field E] [NumberField E] [IsCMField E] {N : ℕ} (V : Submodule ℂ (Sm E N)) : Prop`
- `L21-L38`: `structure IsBaseChangeN {E : Type} [Field E] [NumberField E] [IsCMField E] {n : ℕ} (π : Submodule ℂ (UA E n → ℂ)) {c : ℕ} {N : Fin c → ℕ} (h : ∑ i, N i = n) (V : ∀ i, Submodule ℂ (Sm E (N i))) (σ : ∀ i (w : HeightOneSpectrum (𝓞 E)), SmIrr (GL (Fin (N i)) (w.adicCompletion E))) (m : Fin c → (E →+* ℂ) → Multiset ℂ) (P : ∀ w : HeightOneSpectrum (𝓞 E), SmIrr (GL (Fin n) (w.adicCompletion E))) : Prop`
- `L39-L47`: `def BaseChangeIsobaricN : Prop`
- `L48-L60`: `structure Datum (E : Type) [Field E] [NumberField E] [IsCMField E] (n : ℕ)`
- `L63-L66`: `def SplitAt (π : Submodule ℂ (UA E n → ℂ)) (D : Datum E n) (w : HeightOneSpectrum (𝓞 E)) : Prop`
- `L67-L69`: `def SatAt (D : Datum E n) (w : HeightOneSpectrum (𝓞 E)) (B : Fin D.c → Multiset ℂˣ) : Prop`
- `L70-L73`: `def Weak (π : Submodule ℂ (UA E n → ℂ)) (D : Datum E n) : Prop`
- `L74-L76`: `def Unr (E : Type) [Field E] [NumberField E] [IsCMField E] : Prop`
- `L77-L81`: `def RunSplit : Prop`
- `L82-L87`: `def RunInert : Prop`
- `L88-L93`: `def Rigid : Prop`
- `L94-L111`: `theorem core_of (hS : RunSplit) (hI : RunInert) (hR : Rigid) (hE : Unr E) (hn : 1 ≤ n) (π : Submodule ℂ (UA E n → ℂ)) (hπ : IsAutRepU π) : ∃ D : Datum E n, (∀ τ lam, HasWeightAt π τ lam → ∑ i, D.m i τ = infOfWeight lam) ∧ (∀ w, IsSplitAt w → SplitAt π D w) ∧ ∀ w, IsUnramU π w → ¬ IsSplitAt w → ∃ B, SatAt D w B ∧ ∀ (s : w.adicCompletion E →+* w.adicCompletion E) (ϖ : w.adicCompletion E) (q : ℕ), (∀ x : E, s (algebraMap E _ x) = algebraMap E _ (IsCMField.complexConj E x)) → IsUnramInv ϖ s q → ∀ α, HasSatAt π w s ϖ q α → ∑ i, B i = GlobalTheory.LGrp.bcParam n α` · 전술: `exact,obtain,refine,simp`
- `L113-L132`: `theorem baseChangeIsobaricN_of (hS : RunSplit) (hI : RunInert) (hR : Rigid) : BaseChangeIsobaricN` · 전술: `exact,obtain,refine,rw`

## 모듈군: `Development.AbelianVarietyTheory.Proofs` (`4`개 파일)

### `Development/AbelianVarietyTheory/Proofs/DivisorProofs/CrystallineSmoothLiftOfRelations.lean` (`74`줄 · 피참조 `14` · Main거리 `4`)
- `L19-L47`: `theorem exists_linearEquiv_of_rel {R : Type*} [CommRing R] {M N : Type*} [AddCommGroup M] [Module R M] [AddCommGroup N] [Module R N] (p : M → N → Prop) (h1 : ∀ c, ∃ h, p c h) (h2 : ∀ h, ∃ c, p c h) (h0 : ∀ c h, p c h → (c = 0 ↔ h = 0)) (hadd : ∀ a b h h', p a h → p b h' → p (a + b) (h + h')) (hsmul : ∀ (r : R) a h, p a h → p (r • a) (r • h)) : ∃ e : M ≃ₗ[R] N, ∀ c h, e c = h ↔ p c h` · 전술: `exact,obtain,refine,rw`
- `L52-L73`: `theorem crystallineSmoothLift_of_relations : GlobalTheory.Published.CrystallineSmoothLift` · 전술: `exact,obtain,refine`

### `Development/AbelianVarietyTheory/Proofs/DivisorProofs/AbelianDualCrystalOfHyp.lean` (`12`줄 · 피참조 `4` · Main거리 `4`)
- `L8-L11`: `theorem abelianDualCrystal_of_dual_of_smoothLift : GlobalTheory.Published.DualAbelianScheme → GlobalTheory.Published.CrystallineSmoothLift → GlobalTheory.Published.AbelianDualCrystal`

### `Development/AbelianVarietyTheory/Proofs/DivisorProofs/PeriodComparisonHolds.lean` (`6`줄 · 피참조 `2` · Main거리 `4`)
- `L5-L6`: `theorem GlobalTheory.PeriodFamily.periodComparison_holds : GlobalTheory.Published.PeriodComparison`

### `Development/AbelianVarietyTheory/Proofs/DivisorProofs/ImportsSideExtra.lean` (`12`줄 · 피참조 `1` · Main거리 `4`)
- `L9-L11`: `theorem main : GlobalTheory.Published.GaussManinPeriods`

## 모듈군: `Development.AutomorphicArithmetic.Foundations` (`7`개 파일)

### `Development/AutomorphicArithmetic/Foundations/BaseChangeIdentities/DefiniteNHolds.lean` (`6`줄 · 피참조 `5` · Main거리 `3`)
- `L5-L6`: `theorem UpperTheory.BaseChangeIdentities.baseChangeN : PositivityTheory.Rg.BcN.BaseChangeIsobaricN`

### `Development/AutomorphicArithmetic/Foundations/BaseChangeIdentities/NarrowSwap.lean` (`24`줄 · 피참조 `5` · Main거리 `4`)
- `L14-L15`: `theorem speh (h : PositivityTheory.Rg.BcN.BaseChangeIsobaricN) : GlobalTheory.BcSpeh.BcSpeh`
- `L16-L21`: `theorem Conclusion1 : DefiniteN → GlobalTheory.Published.BernsteinUnitaryProductIrreducible → GlobalTheory.Published.DiscreteSpectrumGL → GlobalTheory.Published.GenericUnitaryDualGL → GlobalTheory.Published.StandardCosocleGL → ∀ (hL : GlobalTheory.Published.LocalLanglandsGL) (D : D7) (T : GlobalTheory.RowTie.WDTie D.nd D.naut) (A : AUSide D), CGTrue hL D T → AUTrue hL D T A → SphericalInertData.Conclusion1 D`

### `Development/AutomorphicArithmetic/Foundations/BaseChangeIdentities/FillPre.lean` (`9`줄 · 피참조 `2` · Main거리 `4`)
- `L7-L9`: `theorem UpperTheory.BaseChangeIdentities.baseChangeN_of (hCF : PositivityTheory.Rg.BcB.F.FX.CandFin) : PositivityTheory.Rg.BcN.BaseChangeIsobaricN`

### `Development/AutomorphicArithmetic/Foundations/GaloisRepresentations/IntegralStructures/RowSrc.lean` (`8`줄 · 피참조 `2` · Main거리 `3`)
- `L6-L7`: `theorem galoisLocalGlobalStrong_recParameter : UpperTheory.GalStar.Row0b recT`

### `Development/AutomorphicArithmetic/Foundations/BaseChangeIdentities/FrameMatching/HeckeEigenvalueFiniteness/FrameEx.lean` (`19`줄 · 피참조 `1` · Main거리 `4`)
- `L15-L18`: `theorem candFin : CandFin`

### `Development/AutomorphicArithmetic/Foundations/GaloisRepresentations/IntegralStructures/GaloisRepresentationsOfThetaLift.lean` (`8`줄 · 피참조 `1` · Main거리 `4`)
- `L6-L7`: `theorem galoisRepresentations_of_thetaLift (up : UpperTheory.TP.TLiftK) : UpperTheory.GalStar.Row0b recT`

### `Development/AutomorphicArithmetic/Foundations/GaloisRepresentations/ThetaParseval/ThetaKernels/TLiftK.lean` (`5`줄 · 피참조 `1` · Main거리 `4`)
- `L4-L5`: `theorem UpperTheory.TP.K.tLiftK : UpperTheory.TP.TLiftK`

## 모듈군: `Formalism.GammaFactorNonvanishing.CritLine` (`1`개 파일)

### `Formalism/GammaFactorNonvanishing/CritLine.lean` (`32`줄 · 피참조 `1` · Main거리 `4`)
- `L6-L10`: `theorem Formalism.VW.gammaFactor_ne_zero {N : ℕ} (χ : DirichletCharacter ℂ N) {s : ℂ} (hs : 0 < s.re) : gammaFactor χ s ≠ 0` · 전술: `exact,linarith,rcases,rw`
- `L11-L28`: `theorem Formalism.VW.critLine (h : UpperTheory.EveryCharacter) (N : ℕ) [NeZero N] (χ : DirichletCharacter ℂ N) (hχ : χ.IsPrimitive) (s : ℂ) (h0 : 0 < s.re) (h1 : s.re < 1) (hz : LFunction χ s = 0) : s.re = 1 / 2` · 전술: `by_contra,exact,linarith,rcases,refine,rw`
- `L29-L32`: `theorem Formalism.VW.rh_of_every (h : UpperTheory.EveryCharacter) : RiemannHypothesis`

## 모듈군: `Development.AutomorphicArithmetic.ThetaCorrespondence` (`1`개 파일)

### `Development/AutomorphicArithmetic/ThetaCorrespondence/GoodReduction/SerreTate.lean` (`18`줄 · 피참조 `1` · Main거리 `4`)
- `L7-L8`: `theorem neronOggShafarevich : GlobalTheory.Published.NeronOggShafarevichSt`
- `L9-L11`: `theorem potentialGoodReduction : GlobalTheory.Published.PotentialGoodReductionSt`
- `L12-L14`: `theorem cmPotentialGoodReduction : GlobalTheory.Published.CMPotentialGoodReductionSt`
- `L15-L17`: `theorem serreTateGoodReduction : GlobalTheory.Published.SerreTateGoodReductionSt`

## 모듈군: `Statements` (`1`개 파일)

### `Statements.lean` (`16`줄 · 피참조 `1` · Main거리 `1`)
- `L3-L5`: `def RiemannZetaZerosOnLine : Prop`
- `L6-L9`: `def DirichletLNonvanishingRightOfHalf : Prop`
- `L10-L13`: `def DirichletLZerosOnLine : Prop`
- `L14-L16`: `def PrimitiveDirichletLZerosOnLine : Prop`

## 모듈군: `Supplements.Kernels.MainTheorems` (`1`개 파일)

### `Supplements/Kernels/MainTheorems.lean` (`16`줄 · 피참조 `1` · Main거리 `3`)
- `L7-L8`: `theorem allChi : UpperTheory.EveryCharacter`
- `L9-L10`: `theorem rhOfAll : RiemannHypothesis`
- `L11-L14`: `theorem critAll (N : ℕ) [NeZero N] (χ : DirichletCharacter ℂ N) (hχ : χ.IsPrimitive) (s : ℂ) (h0 : 0 < s.re) (h1 : s.re < 1) (hz : LFunction χ s = 0) : s.re = 1 / 2`
- `L15-L16`: `theorem claimAll : Claim.HalfPlane ∧ Claim.Strip ∧ Claim.Zeta`

## 모듈군: `Main` (`1`개 파일)

### `Main.lean` (`12`줄 · 피참조 `0` · Main거리 `0`)
- `L4-L5`: `theorem riemannHypothesis : RiemannHypothesis`
- `L6-L7`: `theorem riemannZeta_eq_zero_re : RiemannZetaZerosOnLine`
- `L8-L9`: `theorem LFunction_ne_zero_of_half_lt_re : DirichletLNonvanishingRightOfHalf`
- `L10-L11`: `theorem LFunction_eq_zero_re : DirichletLZerosOnLine`
- `L12-L12`: `theorem LFunction_eq_zero_re_of_isPrimitive : PrimitiveDirichletLZerosOnLine`

## 모듈군: `BuildAid.D1` (`1`개 파일)

### `BuildAid/D1.lean` (`4`줄 · 피참조 `3` · Main거리 `13`)
- *(선언 없음: 임포트 집계 또는 옵션·커맨드 전용 모듈)*

## 모듈군: `BuildAid.D2` (`1`개 파일)

### `BuildAid/D2.lean` (`4`줄 · 피참조 `4` · Main거리 `12`)
- *(선언 없음: 임포트 집계 또는 옵션·커맨드 전용 모듈)*

## 모듈군: `BuildAid.D3` (`1`개 파일)

### `BuildAid/D3.lean` (`4`줄 · 피참조 `25` · Main거리 `8`)
- *(선언 없음: 임포트 집계 또는 옵션·커맨드 전용 모듈)*

## 모듈군: `BuildAid.D4` (`1`개 파일)

### `BuildAid/D4.lean` (`4`줄 · 피참조 `5` · Main거리 `8`)
- *(선언 없음: 임포트 집계 또는 옵션·커맨드 전용 모듈)*

## 모듈군: `BuildAid.D5` (`1`개 파일)

### `BuildAid/D5.lean` (`4`줄 · 피참조 `1` · Main거리 `19`)
- *(선언 없음: 임포트 집계 또는 옵션·커맨드 전용 모듈)*

## 모듈군: `Supplements.Kernels.MainTheoremsCritical` (`1`개 파일)

### `Supplements/Kernels/MainTheoremsCritical.lean` (`4`줄 · 피참조 `1` · Main거리 `2`)
- *(선언 없음: 임포트 집계 또는 옵션·커맨드 전용 모듈)*

## 모듈군: `Supplements.Kernels.MainTheoremsAll` (`1`개 파일)

### `Supplements/Kernels/MainTheoremsAll.lean` (`2`줄 · 피참조 `1` · Main거리 `1`)
- *(선언 없음: 임포트 집계 또는 옵션·커맨드 전용 모듈)*
