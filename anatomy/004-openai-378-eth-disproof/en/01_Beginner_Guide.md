# [Tier 1: Beginner Guide] Plain-Language Guide to the OpenAI `#378` ETH Disproof Audit

OpenAI `#378` (*The Exponential Time Hypothesis is False*) contains `3,977` Lean 4 files (`710,320` lines) and `4` LaTeX manuscripts. This guide explains how its subexponential `3-SAT` algorithm works, why `1,408` files were abandoned during development, and what changes when we repair 5 formalization shortcuts.

---

## 1. How the Subexponential `3-SAT` Algorithm Works

Counting solutions to an $n$-variable `3-SAT` formula (`#3-SAT`) normally takes exponential time $2^{\Omega(n)}$. OpenAI `#378` reduces this asymptotic complexity to $2^{O(n/\sqrt{\log n})}$ using three algebraic mechanisms:

1. **Commuting Swap Window ($M_0 = V_0 f_{\mathcal{I}}(W_0)$, [`Theorem 1`](../proofs/eth_subexp_interpolation_and_hashes.lean#L22-L50) to [`Theorem 4`](../proofs/eth_subexp_interpolation_and_hashes.lean#L95-L106))**:
   - The weight operator $W_0 = \frac{1}{2}\sum_{s=1}^Q (I_D - \Pi_s)$ has binomial eigenvalue multiplicities $\operatorname{Bin}(Q, \frac{r-1}{2r})$.
   - Multiplying the swap matrix $V_0$ by a Newton polynomial $f_{\mathcal{I}}(W_0)$ keeps both the correction rank ($\le \varepsilon D$) and polynomial degree ($\le R-1$) small.
2. **Exact Cancellation of Dimension $D = r^{2Q}$ ([`Theorem 5`](../proofs/eth_subexp_interpolation_and_hashes.lean#L111-L125) to [`Theorem 7`](../proofs/eth_subexp_interpolation_and_hashes.lean#L149-L161))**:
   - Grouping $M$ clause-variable pairs into buckets of size $D = r^{2Q}$ produces $h \le 2M/D$ buckets.
   - Multiplying $h \le 2M/D$ by the per-bucket rank $\le \varepsilon D$ cancels $D$ identically ($h \cdot c_{\mathcal{B}} \le 2\varepsilon M$), removing the maximum variable degree $\Delta$ from the exponent.
3. **Tanner Expander Hashing and $3n$ Rounds ([`Theorem 10`](../proofs/eth_subexp_interpolation_and_hashes.lean#L238-L266) to [`Theorem 12`](../proofs/eth_subexp_interpolation_and_hashes.lean#L317-L339))**:
   - Each hashing round shrinks false witnesses by $\frac{3}{4}$.
   - Running $3n$ rounds gives $\left(\frac{3}{4}\right)^{3n} 2^n = \left(\frac{27}{32}\right)^n < 1$, eliminating all false witnesses.

---

## 2. Four Generations of Fossils and Five Formalization Shortcuts

### ① `1,408` Discarded Fossil Files Across Four Generations
Tracing imports from [`SqrtLogSpace/Final.lean`](../proofs/oai_ref/lean/OAI/Algorithms/SubexponentialSAT/SqrtLogSpace/Final.lean#L1-L201) shows that only `2,569` files are active. The remaining `1,408` files (`35.4%`, `226,053` lines) are abandoned fossils:
- **Generation 1 (`Fixed`, `73` discarded files)**: Proved $2^{0.9n}$ ([`ExponentArithmetic.lean:15-48`](../proofs/oai_ref/lean/OAI/Algorithms/SubexponentialSAT/ExponentArithmetic.lean#L15-L48)) before hitting a constant-capacity ceiling.
- **Generation 2 (`Subexp`, `935` discarded files, `174,938` lines)**: Bundled all $\Delta$ variable slots together, causing a doubly exponential blow-up that stalled at $2^{O(n/\log\log n)}$ ([`SubexpParameters.lean:51-115`](../proofs/oai_ref/lean/OAI/Algorithms/SubexponentialSAT/SubexpParameters.lean#L51-L115)).
- **Generations 3 & 4 (`SqrtLog` & `SqrtLogSpace`)**: Switched to incidence-pair buckets ($D = r^{2Q}$) and characteristic-3 Galois rings ([`RingModel.lean:19-68`](../proofs/oai_ref/lean/OAI/Algorithms/SubexponentialSAT/SqrtLog/RingModel.lean#L19-L68)).

### ② Five Specification Shortcuts Audited
1. **DFA Truth-Table Lookup ([`FixedParameters.lean:759-808`](../proofs/oai_ref/lean/OAI/Algorithms/SubexponentialSAT/FixedParameters.lean#L759-L808))**: Precomputes `SAT.bruteForce` into the state table of a finite automaton (`languageScanner`).
2. **Asymptotic Cutoff at $n \le 2^{65,535}$ ([`Asymptotics.lean:18-65`](../proofs/oai_ref/lean/OAI/Algorithms/SubexponentialSAT/SqrtLogSpace/Asymptotics.lean#L18-L65), [`Final.lean:44-82`](../proofs/oai_ref/lean/OAI/Algorithms/SubexponentialSAT/SqrtLogSpace/Final.lean#L44-L82))**: `sparsifySchedule n` is `0` until $n > 2^{65,535}$, routing all physical input sizes to a brute-force fallback.
3. **Unary Input Padding ([`ComparatorChallenges/SubexponentialSAT.lean:50-75`](../proofs/oai_ref/lean/ComparatorChallenges/SubexponentialSAT.lean#L50-L75))**: Unary variable delimiters inflate input length to $N = \Theta(mn)$.
4. **Slack-Constant Padding ([`Theorem 16`](../proofs/eth_subexp_interpolation_and_hashes.lean#L403-L418))**: Adds `+ 28700` and `+ 5022741` padding to close `omega` goals quickly.
5. **Char-3 (`Lean`) vs. Char-0 (`LaTeX`) Split ([`Theorem 30`](../proofs/eth_tensor_contraction_and_circuits.lean#L329-L347), [`Theorem 31`](../proofs/eth_tensor_contraction_and_circuits.lean#L354-L372))**: Leaves Appendix D (`Engine II`, which removes $(\log\log n)^2$) unformalized in Lean.

---

## 3. Six-Layer Verdict After Repairing All Five Shortcuts (`Category A`)

| Evaluation Layer | Before Repair | After Repair | Verdict |
| :--- | :--- | :--- | :--- |
| **1. Formal Space Spec** ([`SubexponentialSAT.lean:216`](../proofs/oai_ref/lean/ComparatorChallenges/SubexponentialSAT.lean#L216)) | Unary padding ($L \ge n$) makes `visitedSpace` bound True | Binary encoding ($L = \Theta(\log n)$) cannot write the $n$-bit output (`49,000 < 1,048,576`) | **Changes (True $\to$ False)** ([`Theorem 33`](../proofs/eth_five_repairs_and_four_layer_verdict.lean#L20-L30), [`Theorem 34`](../proofs/eth_five_repairs_and_four_layer_verdict.lean#L38-L51)) |
| **2. Circuit Lower Bound** ([`quantitative-circuits.tex:46-70`](../proofs/oai_ref/tex/quantitative-circuits.tex#L46-L70)) | Claims $\Omega(n\sqrt{\log n})$ via unformalized `Engine II` | `Engine I` alone gives $\Omega(n\sqrt{\log n}/(\log\log n)^2)$ | **Weakened without Appendix D** ([`Theorem 35`](../proofs/eth_five_repairs_and_four_layer_verdict.lean#L61-L73), [`Theorem 36`](../proofs/eth_five_repairs_and_four_layer_verdict.lean#L79-L91)) |
| **3. Finite Regime** ($n < 2^{33,554,431}$) | Uses noncomputable [`FiniteFallback`](../proofs/oai_ref/lean/OAI/Algorithms/SubexponentialSAT/SqrtLogSpace/FiniteFallback.lean#L258-L299) or [`reject`](../proofs/oai_ref/lean/OAI/Algorithms/SubexponentialSAT/SqrtLogSpace/HighQueryProgram.lean#L50-L52) | [`LeafParametersProgram.lean:101`](../proofs/oai_ref/lean/OAI/Algorithms/SubexponentialSAT/SqrtLog/LeafParametersProgram.lean#L101) (`4*R ≤ Q`) and [`CostAssemblyFinal.lean:53-54`](../proofs/oai_ref/lean/OAI/Algorithms/SubexponentialSAT/SqrtLog/CostAssemblyFinal.lean#L53-L54) run $2^n$ search | **Runs as $2^n$ search** ([`Theorem 37`](../proofs/eth_five_repairs_and_four_layer_verdict.lean#L101-L119) to [`Theorem 40`](../proofs/eth_five_repairs_and_four_layer_verdict.lean#L166-L183)) |
| **4. Asymptotic Limit** ($n \to \infty$) | $2^{o(n)}$ (ETH False) | Core algebraic reduction holds for $n \ge N_0(k)$ | **Preserved ($2^{o(n)}$ holds)** ([`Theorem 41`](../proofs/eth_five_repairs_and_four_layer_verdict.lean#L191-L203), [`Theorem 42`](../proofs/eth_five_repairs_and_four_layer_verdict.lean#L210-L230)) |
| **5. Fossil Hybrid Bounds** | $\log_2 L = 25$ and constant `12,032,411,847` | Combining `Gen 2` + `Gen 3` fossils cuts $\log_2 L \to 15$ ($1,024\times$) and constant to `70,023` ($171,835\times$) | **171,835x tighter constant** ([`Theorem 43`](../proofs/eth_five_repairs_and_four_layer_verdict.lean#L245-L269) to [`Theorem 46`](../proofs/eth_five_repairs_and_four_layer_verdict.lean#L328-L343)) |
| **6. Galois-Ring Solver & Patch** | Appendix D([`Theorem 21`](../proofs/eth_tensor_contraction_and_circuits.lean#L96-L112)) and solver unformalized | Formalizes $\mathrm{GR}(3^3, 2)$ Hensel lift, Hermite reconstruction, and 5-module patch | **Verified in Lean 4 & Python** ([`Theorem 47`](../proofs/eth_five_repairs_and_four_layer_verdict.lean#L359-L377) to [`Theorem 50`](../proofs/eth_five_repairs_and_four_layer_verdict.lean#L428-L441)) |
