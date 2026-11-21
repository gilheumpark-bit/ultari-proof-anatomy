# 05. Specialist Referee and Equation Audit (Acts 3-5 Core Identities, Parity Split & Cross-Audit)

Across `175,187` Lean 4 modules (`17,374,215` lines), Levent Alpöge and Claude construct the positive Stepanov determinant functional $W(\cdot) \ge 0$ by combining Bargmann-Fock symmetric tensor determinants with $\mathfrak{gl}_2$ Yangian RTT fusion, eliminate the quadratic `2/3`-barrier loss $-C m^2 L / k$ via companion lattice rank normalization $k \asymp x^{9/2+10\varepsilon}$, and discharge `VWin` (`Ct = 401`,
$\varepsilon < 1/52$) by joining an odd (`minus`) Stickelberger-Kato wing with an even (`plus`, Vandiver) $\mathrm{GSp}_4 \cdot U(3)$ Hida deformation-patching wing (`PASS`).
This referee report reconstructs the exact equations, magic constants, formalization slacks, and compression paths directly from source, backed by 15 standalone kernel-checked theorems in [alpoge_spine_arithmetic_audit.lean](../proofs/alpoge_spine_arithmetic_audit.lean) (`0 sorry`, `LEAN_RC:0`).

---

## Chapter 1. Asymptotic `Scale` Hierarchy and Reverse-Engineering $\varepsilon < \frac{1}{52}$, `la = 3/2`, and `413,718,278,401`

### 1.1 Master `Scale` Structure (`src/Formalism/LocalRingCardinality/DataParams₂.lean:9-47`)

Every asymptotic inequality in the archive is parameterized over a single structure `Scale` ($x > 1$, $0 < \varepsilon < \frac{1}{52}$, $J \ge 1$) defining the subexponential and polynomial scales:

$$L = x^\varepsilon, \qquad b = e^{L} = \exp(x^\varepsilon), \qquad a = x \cdot \exp(x^\varepsilon), \qquad X' = \exp\bigl(x^{\varepsilon/3}\bigr)$$

$$b' = \frac{a}{X'} = x \cdot \exp\bigl(x^\varepsilon - x^{\varepsilon/3}\bigr), \qquad \delta_1 = x^{-\varepsilon/8}, \qquad A = 26, \qquad p_0(k) = k^2 x^{26}$$

The dyadic-exponential window `Scales la` (`src/Development/AutomorphicArithmetic/PrimeDiscriminants/Scales.lean:9-39`) requires $[Y, Y^{\mathrm{la}}]$ to sit inside admissible windows above any threshold $y$, specialized at `src/Development/AutomorphicArithmetic/CharacterBoxes/EveryCharacter.lean:10` and `src/Development/AutomorphicArithmetic/CharacterBoxes/SupplyChi.lean:9` to $\mathrm{la} = \frac{3}{2} \in (1, 2]$ inside $[Y, Y^2]$.

### 1.2 Four-Rank Tuple $(m, 2^e, k, t)$ and Why $\varepsilon < \frac{1}{52}$

In `src/Development/AbelianVarietyTheory/Proofs/GlobalInterpolation/ExistsRanksRankValFrame.lean:24-100`, given a 2-power frame order $\mathrm{ord} = 2^e$, four coupled integer ranks $(m, 2^e, k, t)$ are chosen simultaneously:

| Rank | Selection Interval | Mathematical Role | Active Constraint & Pin |
| :---: | :--- | :--- | :--- |
| **$m$** (`Even m`) | $\bigl[x^{\frac{1}{2}-\frac{\varepsilon}{16}},\, 2x^{\frac{1}{2}-\frac{\varepsilon}{16}}\bigr]$ | Iterated theta-lift chain length ($\sqrt{x \delta_1}$) | $4 \le x^{-\varepsilon/100}\sqrt{x\delta_1}$ ($x \ge 256$, `DIVfromGLbud.lean:18-32`) |
| **$2^e$** (`φ.ord`) | $\bigl[x^{2+8\varepsilon},\, 2x^{2+8\varepsilon}\bigr]$ | Cyclotomic $\mathbb{Z}_2$-tower layer (`PageN`) | $x^2 \le x^{2+8\varepsilon} \le x^3 \iff \varepsilon \le \frac{1}{8}$ (`ExistsRanksRankValFrame.lean:53-58`) |
| **$k$** (`Even k`) | $\bigl[x^{\frac{9}{2}+10\varepsilon},\, 2x^{\frac{9}{2}+10\varepsilon}\bigr]$ | Companion orthogonal/hermitian base rank | $m^2 L \le k$ and $x^4 \le k$ (`MassLowerBoundClosed.lean:57`) |
| **$t$** (`R.t`) | $8 f r + 4 + 8 T W - r$ | Unramified twist and cohomology cutoff | $r = k + m - 1$ (odd), $f = 2^{e+1}$, $r + t = 8 f r + 4 + T(8W)$ (line `41`) |

Two independent bottlenecks pin the global threshold $\varepsilon < \frac{1}{52}$ ($E = 1/\varepsilon > 52$, [alpoge_spine_arithmetic_audit.lean](../proofs/alpoge_spine_arithmetic_audit.lean) `thm_04`, `thm_05`):
1. Half the reciprocal of the base polynomial constant $A = 26$ (`DataParams₂.lean:41`) equals $\frac{1}{2A} = \frac{1}{52}$, aligning lattice-perturbation decay $x^{-A/2} = x^{-13}$ against $\varepsilon$-losses.
2. In `src/Formalism/SharpRestriction/GrowthBounds/MultisetValuation/PriceLinearCombinationLe.lean:45-81` (`ne_rG_lt`), fitting the small-prime price degree $r_G = \lceil 8(h_G + 2)/\varepsilon \rceil + 1 < 32E + 66$ inside $(34E)^2 \le x^2 \le x^{9/2+10\varepsilon-\mathrm{szTh}} \le k$ explicitly invokes `have hinv : 52 < E` (line `60`).

### 1.3 Auxiliary Prime Pair `WinPair` and the 12-Digit Lucas Witness Prime $g_A = 413{,}718{,}278{,}401$

In `src/Development/AutomorphicArithmetic/CharacterBoxes/ExistsPageN.lean:27-38`, `WinPair eps Y q d` imposes simultaneous congruence and divisibility conditions on auxiliary primes $(q, d)$:

$$q \equiv 3 \pmod 8, \qquad d \equiv 7 \pmod{16}, \qquad q \mid d + 1, \qquad \forall p \le Y^{\varepsilon/5}\;(p \neq 2 \implies p \mid d + 1)$$

- **Arithmetic Reason (`thm_06`)**: $d \equiv 7 \pmod{16}$ implies $-d \equiv 1 \pmod 8$, so $2$ splits completely in the imaginary quadratic field $K = \mathbb{Q}(\sqrt{-d})$ (matching the exact hypothesis of `ThetaNormCM.lean:31`), while $d \equiv -1 \pmod p$ gives $\bigl(\frac{-d}{p}\bigr) = \bigl(\frac{1}{p}\bigr) = +1$, splitting every odd prime $p \le Y^{\varepsilon/5}$ in $K$.
- **Non-Vacuity Witness (`thm_07`)**: To prove non-emptiness at the base of the local-ring hierarchy, `src/Formalism/LocalRingCardinality/SpanPowerMembership.lean:18-29` and `src/Formalism/LocalRingCardinality/SpanPowerMembership/Primes.lean:86-87` instantiate $q = 571$ ($571 \equiv 3 \bmod 8$) and $d = 599$ ($599 \equiv 7 \bmod{16}$, $599+1 = 600 = 2^3 \cdot 3 \cdot 5^2$).
  Over this pair, the code certifies the explicit 12-digit prime below in-kernel via the Lucas primality test (`lucas_list`) at primitive root base `34`:

$$g_A = 413{,}718{,}278{,}401, \qquad g_A - 1 = 2^8 \cdot 3^3 \cdot 5^2 \cdot 7 \cdot 571 \cdot 599 \equiv 0 \pmod{16 \cdot 571 \cdot 599}$$

---

## Chapter 2. Threefold Algebraic Construction of the Positive Functional $W(\cdot) \ge 0$

The "natively-automorphic Stepanov determinant" cited in `remark.pdf` (pp. 3-4, items 1, 4, 7, 13) is realized by three interlocking modules inside `Formalism`.

### 2.1 Bargmann-Fock Permanent and Symmetric-Power Determinant Amplification (`src/Formalism/FockGram/StatementFock.lean:9-76`)

Over the multivariate polynomial ring $R[\tau]$, the multi-factorial Fock inner product (`fock`) and Gram matrix (`fockGram`) are defined by

$$\langle f, g \rangle_{\mathrm{Fock}} = \sum_{\mathbf{m}} f_{\mathbf{m}} \overline{g_{\mathbf{m}}}\, \mathbf{m}!, \qquad G_{\mathrm{Fock}}(v)_{i,j} = \langle v_i, v_j \rangle_{\mathrm{Fock}}$$

Products of homogeneous linear forms satisfy the Wick permanent identity $\langle \prod_{s=1}^a x_s, \prod_{t=1}^a y_t \rangle_{\mathrm{Fock}} = \mathrm{perm}\bigl(\langle x_s, y_t \rangle_{\mathrm{Fock}}\bigr)$ (`FockPerm`, line `47`), and passing to the degree-$a$ symmetric monomial basis $\mathrm{Sym}^a(e)$ amplifies the determinant exponent by a binomial coefficient (`DetFockSym`, lines `63-68`, `thm_11`):

$$\det G_{\mathrm{Fock}}\bigl(\mathrm{Sym}^a(e)\bigr) = \bigl(\det G_{\mathrm{Fock}}(e)\bigr)^{\binom{|\sigma| + a - 1}{|\sigma|}} \prod_{\mathbf{t} \in \mathrm{Sym}^a(\sigma)} \mathbf{t}!$$

### 2.2 Orthogonal-Projection Gram Identity and DVR Cokernel Bridge (`src/Formalism/GaussIdealIdentity/StatementLA.lean:29-89`)

Let $\{e_\sigma\}_{\sigma=1}^d$ ($e_\sigma \neq 0$, nonzero orthogonal family without unit-norm assumption) span a subspace $Z$ of a complex Hilbert space $V$ with orthogonal projection $\mathrm{pr}_Z$.
For any test family $\{F_a\}_{a=1}^d$, projected Gram matrix $G_{a,b} = \langle \mathrm{pr}_Z F_a, \mathrm{pr}_Z F_b \rangle$, period matrix $C_{\sigma,a} = \langle e_\sigma, F_a \rangle$, nonzero scalar $A \in \mathbb{C}^\times$, and $B_0 \in M_d(\mathbb{C})$, `MasterIdentity` (lines `39-50`) establishes

$$\det G = \frac{|\det C|^2}{\prod_{\sigma=1}^d \|e_\sigma\|^2} \ge 0, \qquad \frac{\|\det(A^{-1} B_0 \overline{C})\|^2}{\mathrm{Re}(\det G)} = |A|^{-2d}\, \|\det B_0\|^2 \prod_{\sigma=1}^d \|e_\sigma\|^2$$

Over any discrete valuation ring (DVR) $\mathcal{O}$, Gauss prime-ideal localization (`GaussLength`, lines `74-79`) and dual-lattice inclusion $L^\vee \subseteq L$ (`Ld ≤ L`, `GramDetLength`, lines `80-89`) give

$$g \cdot \det\bigl(B(b_i, b_j)\bigr) = 1 \implies \mathrm{length}_{\mathcal{O}}(L / L^\vee) = v_{\mathcal{O}}(g)$$

coupling Archimedean positivity ($\det G \ge 0$) to finite-place $p$-adic invertibility (Bost slope inequality, `remark.pdf` item 13) through `Formalism/ProductFormula`.

### 2.3 $\mathfrak{gl}_2$ Yangian RTT Transfer Matrices and Word Fusion (`src/Formalism/HermitianCurvature/StatementW.lean:9-27`)

To fuse $m$ Gan-Gross-Prasad (GGP) period matrices while preserving weight-$0/1$ interlacing and up to $m$ unlinked Chebyshev nodes inside a positive determinant, the code formalizes the Yang-Baxter RTT relation (`IsRTT`) and quantum determinant (`IsDet`) on $2 \times 2$ matrix-valued spectral polynomials $M(Y)$:

$$\bigl((Y' - Y) I_4 - P_{\mathrm{flip}}\bigr)\, E_1\bigl(M(Y')\bigr)\, E_2\bigl(M(Y)\bigr) = E_2\bigl(M(Y)\bigr)\, E_1\bigl(M(Y')\bigr)\, \bigl((Y' - Y) I_4 - P_{\mathrm{flip}}\bigr)$$

$$M(Y + 1)^{\mathsf{T}} J M(Y) = q(Y) J \quad \overset{\mathrm{WordFusion}}{\Longrightarrow} \quad \left(\prod_{\nu=1}^m M_\nu(Y+1)\right)^{\mathsf{T}} J \left(\prod_{\nu=1}^m M_\nu(Y)\right) = \left(\prod_{\nu=1}^m q_\nu(Y)\right) J$$

By `WordFusion` (lines `20-26`), multiplying pairwise entry-commuting transfer letters $L = [(M_1, q_1), \dots, (M_m, q_m)]$ preserves both RTT intertwiners and scalar quantum determinants $\prod_{\nu=1}^m q_\nu(Y)$ across the entire $m$-step chain.

---

## Chapter 3. The `2/3` Barrier and Cancellation of $-C m^2 L / k$ via Seesaw & Mass Bounds

### 3.1 Why Unreduced Iteration Stalls at $\sigma = \frac{2}{3}$ (`thm_02`)

Setting $m = x^\alpha$ ($0 < \alpha < 1$) gives Chebyshev discretization error $O(x / m) = O(x^{1-\alpha})$ (`ZetaNonvanishingChebyshevWeights.lean:27`). If discriminant and level denominators accumulate linearly ($\propto j$) at step $j$, the $m$-step log-denominator penalty scales like $\sum_{j=1}^m j \asymp m^2 = x^{2\alpha}$, fixing the balance point at

$$(1 - \alpha) - 2\alpha = 1 - 3\alpha \quad \Longrightarrow \quad \alpha = \frac{1}{3}, \qquad \sigma = 1 - \frac{1}{3} = \frac{2}{3}$$

short of the critical line $\frac{1}{2}$ (`remark.pdf` p. 4 item 14).

### 3.2 Seesaw Adjointness and Finite-Field Gauss Operator Scalar Collapse (`Statement.lean` · `GaussOp.lean`)

First, adelic double-coset representative independence (`ThetaLiftAMFKIndep`, `src/Formalism/ThetaLiftIndependence/Statement.lean:106-115`) and formal seesaw adjointness of `chainOp w K m f` (`KerAdjoint`, lines `29-33`) establish

$$\langle \mathcal{K}_{w, K} f,\, g \rangle_{w'} = \langle f,\, \mathcal{K}_{w', K^*} g \rangle_w, \qquad \left(\prod_{j=0}^{m-1} D_j\right) \cdot \mathrm{chainOp}(w, K, m, f) \in \Lambda_m$$

At finite-field components $\mathbb{F}$, for any nontrivial additive character $\psi \neq 1$ and mean-zero vector $\sum_{c \in \mathbb{F}^\times} \rho(c) v = 0$, the composite Gauss operator (`src/Formalism/ThetaLiftIndependence/ThetaOrbitSums/GaussOp.lean:27-73`) collapses to a character-independent scalar:

$$\mathcal{G}^* \mathcal{G} v = \sum_{e \in \mathbb{F}^\times} \left(\sum_{d \in \mathbb{F}^\times} \psi\bigl((e - 1)d\bigr)\right) \rho(e) v = |\mathbb{F}| \cdot v$$

### 3.3 CM Jacobi Theta Inverse Norms and Two-Sided Siegel-Weil Mass Bounds (`ThetaNormCM.lean` · `MassLowerBoundClosed.lean`)

Second, `PI.ThetaNormCM` (`src/Formalism/PeriodIntegrals/ThetaNormCM.lean:30-40`) evaluates the inverse $L^2$-norm of the 2-torsion CM theta function $G$ on $\Lambda = \mathbb{Z}\omega_1 \oplus \mathbb{Z}\omega_1\tau$ ($d \equiv 7 \pmod 8$) via Jacobi $\vartheta_2$:

$$\|G\|_{L^2(\Lambda)}^{-2} = \sqrt{2\,\mathrm{Im}\,\tau} \cdot \left(\exp\!\left(-\frac{\pi a^2\,\mathrm{Im}\,\tau}{4}\right) \cdot \left|\vartheta_2\!\left(\frac{a\tau + b}{2},\, \tau\right)\right|\right)^2$$

Third, ascending from a rank-$k$ hermitian lattice $L_k$ to rank $r = k - 1 + m$ lattice $L_r$, `MassLowerBoundClosed` and `MassUpperBoundClosed` (`src/Formalism/GL3MeanSquares/MassLowerBoundClosed.lean:12-74`) sandwich the normalized Siegel-mass, index, and Weyl-dimension ratio $D^* / d^*$:

$$\sum_{j=0}^{m-1} \frac{1}{[K^+:\mathbb{Q}]} \sum_{\rho} \log\!\left(\frac{w_{\rho,j}\, v_{\mathrm{inv}}(K)}{\pi}\right) + m\log(g_1 g_2) - C\!\left(L + \frac{m^2 L}{k}\right) \le \frac{\log(D^* / d^*)}{[K^+:\mathbb{Q}]\, k} \le C \cdot m \cdot L$$

- **Exact Cancellation (`thm_03`)**: The negative penalty $-C \frac{m^2 L}{k}$ at line `40` is the quadratic $m^2$ obstruction.
  Because Chapter 1 sets companion rank $k \asymp x^{9/2 + 10\varepsilon}$ against $m \asymp x^{1/2 - \varepsilon/16}$ and $L = x^\varepsilon$, normalization by $k$ satisfies `(m : ℝ) ^ 2 * L ≤ k` (line `57`) and drives the quadratic term to zero, leaving only the linear bound $C m L = O\bigl(x^{1/2 + 15\varepsilon/16}\bigr)$ needed for $\theta = \frac{1}{2}$:

$$\frac{m^2 L}{k} \asymp x^{2(1/2 - \varepsilon/16) + \varepsilon - (9/2 + 10\varepsilon)} = x^{-\frac{7}{2} - \frac{73}{8}\varepsilon} \longrightarrow 0 \qquad (x \to \infty)$$

### 3.4 Remark's $\mathrm{GL}_5$ Six-Fold Cover Heuristic vs Actual Projected Poincaré Series & Cauchy-Schwarz Implementation

On p. 4 item 16 (`10/14/26`) of `remark.pdf`, Alpöge traces the off-diagonal bound to an earlier half-plane argument *"via sixfold cover of $\mathrm{GL}_5$ automorphy of $\mu$ and reducing via Cauchy-Schwarz to a bound on the norm of a suitably projected Poincaré series, approximate orthogonality of the columns of the integral structure."*
Exhaustive inspection of all `175,187` `.lean` files reveals that **no standalone $\mathrm{GL}_5$ six-fold metaplectic group is defined in Lean**; instead, the codebase formalizes Poincaré-series projection, two-type Cauchy-Schwarz decay, and column-kernel determinant bounds directly in **general rank** across four module groups:

1. **Finite-Cover Discrete Series Export & Parseval Compatibility**: `DiscreteSeriesCover` (`src/Development/AbelianVarietyTheory/PublishedTheorems/TwistedTraceFormula/AdmissibleDiscreteSeriesOfHasParam.lean:35-39`) feeds into third-place theta series via
   `exportSt_of_discrete_series_cover` (`src/Development/AutomorphicArithmetic/ThetaCorrespondence/ThetaPairLifts/ThirdPlaceSeries/ExportStOfPrintsStatement.lean:11-12`), paired with `AllCore` (`src/Development/AutomorphicArithmetic/Foundations/GaloisRepresentations/ThetaParseval/AllCoreOf.lean:12-27`).
2. **Cuspidality & Multiplicity Realization of Level-Projected Poincaré Series**: `poin_isCuspFun` (`src/Development/AutomorphicArithmetic/ThetaCorrespondence/RealBands/ExistsMultTEqPoin.lean:15-70`) proves cuspidality via unipotent fiber-integral vanishing (`fibre_integral_eq_zero`), and `exists_multT_eq_poin` (lines `75-109`) embeds `poin θ M (congLev D.sp.cm V.gram Λ 𝔪) v c` inside the multiplicity space `MultT θ M`.
3. **Integral-Structure Column Kernels & DVR Determinant Length**: `StatLenKer` and `StatGlobal` (`src/Formalism/CharacterColumnKernels/Statement.lean:102-153`) prove $\mathrm{length}_{\mathcal{O}}\bigl(\ker \mathrm{matQ}_{\mathcal{O}}(A)\bigr) = v_{\mathcal{O}}(\det A)$ over a DVR and bound congruence-ideal valuations `vIdeal O (congIdeal J π)` across block-triangular Hecke columns (`remark.pdf` p. 4 items 15 and 16).
4. **Quadric Gauss-Sum Cancellation & Two-Type Cauchy-Schwarz Decay (`thm_15`)**: `GaussSumZeroCountBound` (`src/Formalism/FlagUnipotentLattices/ConductorCharacterLeakBound.lean:43-57`) bounds character sums over isotropic quadrics ($\rho \ge 4$) by $\frac{8}{7} q^{1-\rho} \lvert U\rvert / q^a$,
   and `hermitian_assembly_numeric_bound` (`src/Formalism/FlagUnipotentLattices/MinkowskiFactorialBounds/GaussSumCharacterAverageBound.lean:21-98`, `S4aux.type_cauchy_schwarz` at line `85`) proves the weighted amplitude bound below for $k \ge 4r + 7$ and $\lvert\mathrm{Ty}\rvert \le H^{r+2}$.
    - **Polynomial Reserve & Super-Polynomial Decay (`GaussSumCharacterAverageBound.lean:83`, `thm_15`)**: Consolidating $9r^2 + 36r + 38$ under $39(r+1)^2 = 39r^2 + 78r + 39$ at line `83` leaves exact quadratic gap $30r^2 + 42r + 1 \ge 1$ ($r = 0$ min gap `1`: $38 + 1 = 39$),
      while companion rank $k \asymp x^{9/2+10\varepsilon} \gg 2r + 5$ makes $q^{-(k - 2r - 5)}$ crush off-diagonal leakage super-polynomially.

$$\sum_{d \in D} w(d)\,\Bigl\|\sum_{t \in \mathrm{Ty}} \mathrm{amp}(t, d)\Bigr\|^2 \le H^{39(r+1)^2} \cdot q^{-(k - 2r - 5)} \cdot \mathrm{nn}$$

---

## Chapter 4. `VWin` (`Ct = 401`) Five-Count Assembly and Mirror-Parity Split

![Figure 4. The 16.09M-Line VWin Dependency Cone and Its Odd/Even Parity Wings](../figures/fig4_vwin_parity_and_counts_en.png)

### 4.1 Origin of `Ct = 401` (`ExistsPageN.lean:49` · `TailNum.lean:33` · `MSqDiagA.lean:256`)

Over cyclotomic subfields $E \subset \mathbb{Q}(\zeta_N)$ satisfying `IsChiField ψ e q d E`, `VWin` bounds unramified Shafarevich-Tate lengths across finite prime sets $S$ (`src/Development/AutomorphicArithmetic/CharacterBoxes/ExistsPageN.lean:12-50`):

$$\sum_{l \in S} (\log l) \sum_{e=1}^{\lfloor x^{401} \rfloor - 1} \mathrm{shaLen}_l(E, e) \le \sqrt{\exp(x^\varepsilon)} = \exp\!\left(\frac{1}{2} x^\varepsilon\right) \qquad \left(0 < \varepsilon < \frac{1}{52}\right)$$

The integer `401` originates in the $\mathrm{GL}_3$ Jacobi character-sum modules `src/Formalism/GL3MeanSquares/GenusMeanAsymptotics/JacobiCharacterSums/TailNum.lean:33-53` and `src/Formalism/GL3MeanSquares/GenusMeanAsymptotics/JacobiCharacterSums/MSqDiagA.lean:238-259` (`thm_09`):
truncating the diagonal main sum at $\lfloor x^{400} \rfloor$ produces a tail polynomial $x^{398}(x^2 + 1) \le x^{401}$ and log factor $1 + \log\lfloor x^{400} \rfloor \le 401 \log x$ ($x \ge e$), instantiated as `400 + 1 = 401` at `HVCore.lean:21`.

### 4.2 Odd/Even Mirror-Parity Wings Inside `JointWinOfCounts`

Inspecting `src/Development/AutomorphicArithmetic/AutomorphicVarieties/HeightAndVanishing/JointWinOfCounts.lean:16-34`, `HVCore.lean:18-24`, and `WindowBoundOfLiteratureLevel.lean:25-34` shows that `VWin` splits along complex conjugation $c$ ($c^2 = 1$):

| Parity Wing | Components & Identifiers | Arithmetic Machinery | Source Pins |
| :---: | :--- | :--- | :--- |
| **Odd (`minus`) Wing** | `ThmBab K 401`, `ThmBcFree` (`ShaMinus`), `CountI` | Stickelberger congruence (`Odd a`), Ferrero-Washington ($\mu=0$), Kato $\mathrm{GL}_2$ Euler system (`KatoTwoW`), Behrend sieve | `StickelbergerCarrySpecAndWeightOneCoeffOfOdd.lean:5-7`<br>`ThmBabOfLemmaK.lean:9-13`<br>`ThmBcOfPsiBound.lean:15-109`<br>`CountI.lean:19-102` |
| **Even (`plus` / Vandiver) Wing** | `CountII`, `CountIII`, `CountV`, `CountVs`, `CountZ` | Symplectic $\mathrm{GSp}_4$ (`sp4In0_alt`), unitary $U(3)$ Hida family (`THidaU`), Taylor-Wiles-Kisin patching (`published_hypotheses_from_patching_alt`), Poitou-Tate duality | `WindowBoundOfLiteratureLevel.lean:25-34`<br>`FinalU.lean:20-53`<br>`CorGKOf.lean:10-28` |

- **Odd Wing Bound**: `ThmBcOfPsiBound.lean:15-40` (`stick_of`) bounds odd cohomology length `minusLen` from Stickelberger annihilation $l^r \cdot \mathrm{ShaMinus}(D, e) = 0$ as shown below.
  In parallel, `CountI.lean:11-102` combines Kato's Euler system (`katoTwoW_of_printsH`) with $\sum_{H \in T} \varphi([(\mathbb{Z}/N\mathbb{Z})^\times : H]) \le N$ to prove $\sum_{l \in L_s} (\log l) \sum_\psi V_n(\psi) \le (N t)^{k+19}$ (`thm_10`), filtered across cyclotomic twists $e$ by `WindowTwo` (`BehrendSets/Statement.lean:48-81`, `thm_13`).

$$(\log l)\cdot \mathrm{minusLen}(D, e) \le 8 C l [E:\mathbb{Q}]^2 (e + 1) \bigl(\log(e l N)\bigr)^2$$

- **Why the Even (Vandiver) Wing Forces `15.76M` Lines (`thm_12`)**: On even classes $c(v) = v$, the odd projector vanishes identically ($v - c(v) = 0$, guarded by `Odd a` at `StickelbergerCarrySpecAndWeightOneCoeffOfOdd.lean:7`).
  Because abelian Stickelberger elements vanish on the Vandiver plus-part, the proof upgrades Ribet-Wiles converse-Herbrand patching to $\mathrm{GSp}_4$ and $U(3)$ Hida families (`RowSrc.lean:6`), pulling in the `15.76M`-line Shimura/abelian/prismatic dependency cone of `vwin_of_row`.

---

## Chapter 5. Formalization Slacks, OpenAI `#003` Cross-Audit & Compression Blueprint

### 5.1 Four Formalization Slacks and Scaffolding Artifacts Audited in Source

- **1. Rounding Margin `1 / 500` in the Cubic Eisenstein Tail (`thm_08`)**:
  `src/Formalism/EisensteinCokernelLengths/FactorialValuationBounds/RationalTailBoundCubic.lean:24-43` (`numC_cubic`) proves $\frac{8(2\ell-1)}{(\ell-1)^3} + \frac{8}{(\ell-1)^2} + \frac{1}{\ell(\ell-1)} \le \frac{31.11}{\ell^2}$ for $\ell \ge 11$.
  Substituting $\ell = d + 11$ ($d \ge 0$) and clearing denominators yields a boundary value at $\ell = 11$ ($d = 0$) of $\frac{31108}{1000} = 31.108$, leaving an exact rational rounding gap of $\frac{2}{1000} = \frac{1}{500}$ below $31.11 = \frac{3111}{100}$:

$$3111(\ell - 1)^3 - 100\bigl(8(2\ell-1)\ell^2 + 8\ell^2(\ell-1) + \ell(\ell-1)^2\bigr) = 611 d^3 + 12630 d^2 + 65300 d + 200$$

- **2. Degree Padding $t^{k+12}$ in `CountI.absorb` (`thm_10`)**:
  `src/Development/AutomorphicArithmetic/AutomorphicVarieties/HeightAndVanishing/CountI.lean:11-17` promotes $e^7 \le t^7$ to $t^{k+19}$ so a single `ring` call closes $(N t)^{k+19}$, introducing an additive degree reserve of $(k + 19) - 7 = k + 12 \ge 12$.
- **3. Global Unification of $\varepsilon$ Thresholds (`thm_04`)**:
  Local modules permit $\varepsilon \le \frac{1}{8}$ (`ExistsRanksRankValFrame.lean:56`) and $\varepsilon \le \frac{200}{57}$ (`DIVfromGLbud.lean:31`), all unified globally under $\varepsilon < \frac{1}{2A} = \frac{1}{52}$.
- **4. Two-Way Split of the 9 `UnusedSlot` Identifiers (`2` Dead `True` Slots vs `7` Live Namespaces, `thm_14`)**:
  Across `371` unique files (`375` slot-file pairs, `2,226` occurrences), the 9 `UnusedSlot*` identifiers split into two distinct classes (`2 + 7 = 9`):
    - **2 Dead `Prop := True` Hypothesis Slots (`14` pairs)**: Only `UnusedSlot55` (`4` files, `TrivialLocalCondition.lean:89`) and `UnusedSlot72` (`10` files, `DiscreteSpectrumResidualClassification.lean:7` and [04_Literature_195_Attribution_Dictionary.md](./04_Literature_195_Attribution_Dictionary.md) `#144` `L505`) are dummy `True` hypotheses.
    - **7 Live Mathematical `namespace` Identifiers (`361` pairs)**: `UnusedSlot33` (`71`), `34` (`37`), `35` (`10`), `36` (`2`, `OrderValuation.lean:7`), `38` (`5`, `GradedCompletionLemmas.lean:8`), `39` (`43`), and `80` (`193`, `ExtensionInvariantClause.lean:7`) are active `namespace` blocks containing live theorems ([03_Lean_Code_Spine_Ledger.md](./03_Lean_Code_Spine_Ledger.md) Section 6).

### 5.2 One-to-One Cross-Audit: OpenAI `#003` (`(2, 3, 6)`-Triangle Multiplicity-`1` Stepanov) vs Alpöge + Claude

On p. 2 of `remark.pdf`, Alpöge explicitly identifies OpenAI's public Problem `#003` (`DirichletL` · `SevenEighths.lean` · `ShortDraft`) on the `(2, 3, 6)`-triangle CM curve $\mathbb{C}/\mathbb{Z}[\omega]$ as **"a Stepanov argument without multiplicity"**. Comparing the public `#003` formalization directly against Alpöge and Claude's `175,187`-file archive isolates four structural bifurcation points:

| Mathematical Axis | OpenAI `#003` (`(2, 3, 6)`-Triangle Multiplicity-`1` Method) | Alpöge + Claude (`175,187` Files) | Audit Verdict |
| :--- | :--- | :--- | :--- |
| **Base CM Seed** | Eisenstein ring $\mathbb{Z}[\omega]$ ($\lvert\mu_K\rvert = 6$) cubic/sextic Gauss sums and fixed-rank Gram matrices | Same $\mathbb{C}/\mathbb{Z}[\omega]$ order-`6` normalized Gauss sum + CM lattice `ThetaNormCM` (`ThetaNormCM.lean:30-40`) | Identical starting CM seed |
| **Multiplicity `1` vs `m` & `2/3` Barrier** | Multiplicity-`1` positivity gives $\mathrm{Re}(s) > \frac{23}{24},\; \frac{7}{8}$; unreduced lifts stall at $\frac{X}{m} \asymp m^2 \implies \sigma = \frac{2}{3}$ (`thm_02`) | Chains $m \asymp \sqrt{X}$ lifts (`ZetaNonvanishingChebyshevWeights.lean:30-35`) + rank-$k$ division (`thm_03`) to reach $\sigma = \frac{1}{2}$ | $m \asymp \sqrt{X}$ + rank-$k$ division is the key pivot |
| **Off-Diagonal Gauss Control** | Constrained by fixed-rank oscillatory character/Voronoi cancellation limits | Bypasses fixed-rank oscillation via level-projected Poincaré series (`ExistsMultTEqPoin.lean:15-109`) + two-type Cauchy-Schwarz decay $q^{-(k - 2r - 5)}$ (`GaussSumCharacterAverageBound.lean:21-98`, `thm_15`) | Large companion rank $k$ crushes off-diagonal leakage exponentially |
| **Abelian Stickelberger vs Parity Wall** | Abelian Stickelberger elements act nontrivially only on odd parity and vanish ($v - c(v) = 0$, `thm_12`) on even fixed classes $c(v) = v$ | Restricts Stickelberger/Kato/Behrend to odd `CountI`, deploying $\mathrm{GSp}_4 \cdot U(3)$ Hida patching on even Vandiver `CountII · CountIII · CountV` | **Even Vandiver blind spot blocks any Stickelberger-only shortcut** |

### 5.3 Parity-Aware Short-Proof Compression Routes

Because `thm_12` rules out replacing the even Vandiver block (`vwin_of_row`) by abelian Stickelberger elements alone, viable compression paths narrow to three routes (estimate):

1. **Immediate Cleanup (`2` Dead `True` Slots & Behrend Simplification)**: Prune `UnusedSlot55` and `UnusedSlot72` (`14` file references) while replacing the progression-free `BehrendSets` filter (`remark.pdf` footnote 7) with standard Dirichlet pigeonhole averaging (estimate).
2. **Algebraic Rank Descent ($\mathrm{GSp}_4 \cdot U(3)$ Patching -> CM Elliptic-Unit Euler System)**: Descending the even-wing Selmer bound from $\mathrm{GSp}_4 \cdot U(3)$ deformation rings to Rubin elliptic-unit Euler systems or rank-`2` congruence modules over the CM tower $E$ would detach most of the `8.14M`-line `AbelianVarietyTheory` cone (estimate).
3. **Direct Analytic Period Bypass (Avoiding $\bmod\,\ell$ Cohomology)**: Bounding denominator invertibility directly in the Siegel-Weil ratio $D^* / d^*$ via local Bessel periods and relative-trace mean-square sieves without factoring through prime-by-prime `shaLen` would bypass `VWin` altogether (estimate).

---

## Chapter 6. Standalone 15-Theorem Formal Verification Ledger ([alpoge_spine_arithmetic_audit.lean](../proofs/alpoge_spine_arithmetic_audit.lean))

Every exponent, congruence, parity, and slack identity in this report corresponds 1-to-1 to a zero-dependency theorem checked under official `leanprover/lean4:v4.33.1` (`0 sorry`, `LEAN_RC:0`):

| Audit Theorem | Verified Algebraic Invariant | Upstream Module |
| :--- | :--- | :--- |
| `thm_01_chebyshev_sqrt_exponent` | At $\theta = 1/2$, $1 - \theta - \varepsilon = 1/2 - \varepsilon < 1/2 - \varepsilon/16$ | `ZetaNonvanishingChebyshevWeights.lean:33` |
| `thm_02_naive_lift_barrier_two_thirds` | $1 - \alpha = 2\alpha \iff \alpha = 1/3,\; \sigma = 2/3$ | `remark.pdf` p. 4 item 14 |
| `thm_03_rank_division_kills_quadratic_loss` | $m^2 L / k$ net degree $= -7/2 - (73/8)\varepsilon < 0$ | `MassLowerBoundClosed.lean:40,57` |
| `thm_04_scale_eps_52_invariants` | $2A = 52$ and simultaneous validity of all 4 scale bounds for $E > 52$ | `DataParams₂.lean:14,41` · `DIVfromGLbud.lean:18` |
| `thm_05_rank_balance_identity` | Odd parity of $r = k+m-1$ and $r + t = 8 f r + 4 + T(8W)$ | `ExistsRanksRankValFrame.lean:24-43` |
| `thm_06_winpair_cm_splitting_congruences` | $q \equiv 3 \bmod 8,\; d \equiv 7 \bmod{16} \implies 8 \mid d+1$ | `ExistsPageN.lean:27-38` · `ThetaNormCM.lean:31` |
| `thm_07_lucas_witness_prime_413718278401` | Exact prime-power factorization and congruences of $g_A - 1$ | `SpanPowerMembership/Primes.lean:86` |
| `thm_08_cubic_tail_3111_100_and_slack` | Global positivity of `numC_cubic` and exact $\ell=11$ gap `1/500` | `RationalTailBoundCubic.lean:24-43` |
| `thm_09_ct_401_tail_identity` | $x^{398}(x^2 + 1) \le x^{401}$ and $400 + 1 = 401$ | `TailNum.lean:33` · `ExistsPageN.lean:49` |
| `thm_10_countI_absorb_bound` | $A N^{19} e^7 \le (N t)^{k+19}$ and additive reserve $k+12$ | `CountI.lean:11-17` |
| `thm_11_fock_and_minor_identities` | Symmetric-power Fock exponent $\binom{a+1}{2}$ and minor count | `StatementFock.lean:56-68` · `Statement.lean:48` |
| `thm_12_stickelberger_parity_annihilation` | $c(v) = v \implies v - c(v) = 0$ on the even Vandiver eigenspace | `StickelbergerCarrySpecAndWeightOneCoeffOfOdd.lean:7` |
| `thm_13_behrend_base5_sphere_zero_3ap` | Zero nontrivial 3-term arithmetic progressions on the 12-point base-5 shell | `BehrendSets/Statement.lean:48-62` |
| `thm_14_literature_195_partition` | `184 + 1 + 9 + 1 = 195` wrapper split and `2 + 7 = 9` (`14 + 361 = 375`) `UnusedSlot` split | `EveryCharacterOfLiteratureOfVWin.lean:219-810` |
| `thm_15_cauchy_schwarz_exponent_and_decay_margin` | Cauchy-Schwarz exponent gap $30r^2 + 42r + 1 \ge 1$ ($r=0$ min gap `1`) and decay margin $k - (2r+5) \ge 2r+2$ | `GaussSumCharacterAverageBound.lean:83` |
