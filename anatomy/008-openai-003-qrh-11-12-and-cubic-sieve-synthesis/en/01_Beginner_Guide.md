# Tier 1: Beginner Guide: Five Mysteries in the OpenAI #003 QRH Ecosystem

In [Part I (7/8 ShortDraft Audit)](../../001-openai-003-qrh/README.md) and [Part II (Referee & Unbundled Gram Audit)](../../005-openai-003-qrh-mathematician-referee-audit/README.md), we audited the constant margins inside OpenAI's $\text{Re}(s) > \frac{7}{8} = 0.875$ proof. Stepping back in Part III (11/12 & CubicGauss Synthesis) to inspect the broader openai/math #003 repository (6,856 .lean files across DirichletL, SiegelZeros, CubicGauss, CubicGram, and CubicMoment at commit 4eaee87 / PR #70 ca28f20 for files outside proofs/oai_ref/) alongside follow-up work by Alex Kontorovich and Baiying Liu (arXiv:2610.12234, unrefereed preprint) reveals five module-architecture questions.

Note upfront on overall #003 scope: OpenAI #003's proved main theorem in SevenEighths.lean ($\beta = 7/8 = 21/24$, 0 sorry) already logically implies both $\text{Re}(s) > 11/12$ and $\text{Re}(s) > 23/24$, and DescentScale.lean already exists inside the repository. Therefore, our ElevenTwelfths (23/24 vs. 11/12) and 30 unimported CubicGauss findings are strictly module-stratigraphy and intermediate-target analyses, not a claim that #003 failed to reach 11/12.

## 1. Five Ecosystem Questions Answered

1. Why Does the Standalone ShortDraft Submodule Prove $\text{Re}(s) > 23/24$ When the Paper States $11/12$?
   - Both paper.tex and paper2.tex (openai/math commit 4eaee87 / PR #70 ca28f20) present a warm-up zero-free strip of $\text{Re}(s) > 11/12 = 22/24$ (width $1/12$).
   - While the repository's proved main theorem SevenEighths.lean ($\beta = 7/8 = 21/24$, 0 sorry) already implies both $11/12$ and $23/24$ and DescentScale.lean exists in-repo, the standalone submodule ShortDraft.DirichletTarget in DirichletL/RowCompletion/ZeroFreeRegion.lean only proves $\text{Re}(s) > 23/24$ (width $1/24$, half as wide).
   - We prove in [thm_01_shortdraft_fixed_reserve_and_23_24_exponent](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L25-L38) and [thm_04_canonical_descent_scale_budget_unlocks_arbitrary_theta](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L76-L92) that hardcoding $\text{reserve} = \frac{1}{20}$ in ClosedRecursion.lean locked $\vartheta = 1/10$, whereas switching to CanonicalDescentScale (DescentScale.lean) unlocks $\frac{11}{12} + \varepsilon$.
2. Why Is the 30-File Sharp Cubic Large Sieve (CubicGauss/) Left Unimported?
   - Inside lean/OAI/NumberTheory/CubicGauss/ (openai/math commit 4eaee87 / PR #70 ca28f20), OpenAI formalized Heath-Brown's cubic large sieve with the sharp exponent $2/3$ (0 sorry).
   - However, zero files in DirichletL import CubicGauss ([thm_15_unimported_cubic_gauss_vs_bundled_cubic_gram_gap](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L297-L311)).
   - Using Nat induction in [thm_31_sieve_iter_mobius_invariants_by_induction](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L36-L69) through [thm_33_sieve_iter_strictly_beats_openai_sieve_exponent_all_n](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L92-L107), we prove the exact closed-form iteration $\tilde{\alpha}_n = \frac{4\cdot 3^n - 2^{n+1}}{3\cdot 3^n - 2^{n+1}}$ for all $n \in \mathbb{N}$, while noting that OpenAI's geometric-series majorization in CubicGauss/LargeSieve.lean:75 is a valid asymptotic simplification that still reaches the exact same fixed point $\alpha^{\ast} = 4/3$.
3. Why Did Part II and Baiying Liu Both Hit $\mathbb{Q}(\sqrt{921})$?
   - Both the Part II saddle $\beta_{\mathrm{SOS}}(0) = \frac{6843 - 7\sqrt{921}}{7578}$ and Liu's optimum $B_{\mathrm{Liu}} = \frac{1507 - 2\sqrt{921}}{1653}$ (arXiv:2610.12234, unrefereed preprint) involve $\sqrt{921}$.
   - We prove in [thm_16_shared_critical_quadratic_288_588_185_and_count_2_3](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L24-L42), [thm_19_exact_gap_between_fixed_scale_saddle_and_liu_optimum](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L85-L97), and [thm_34_zsqrt921_norm_and_critical_quadratic_root](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L130-L138) through [thm_35_zsqrt921_liu_rationalization_and_case005_gap](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L144-L157) that both arise from the quadratic $288\delta_c^2 - 588\delta_c + 185 = 0$ where the sextic sieve count hits $2/3$.
4. How Do Linear Programming Perturbations Move Past Liu's Farkas Barrier ($0.874957$)?
   - Liu (arXiv:2610.12234, unrefereed preprint) showed that keeping the three bundled inequalities unchanged blocks any improvement below $0.874957$ ([thm_21_farkas_dual_weights_and_closure_obstruction](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L124-L139)).
   - Unbundling those exponent margins in the parametric LP shifts the algebraic target downward to $\frac{4103}{4896} \approx 0.8380$, $\frac{4069}{4896} \approx 0.8311$, and conditionally to $\frac{71}{108} \approx 0.6574$ when combined with CubicGauss ([thm_24_parametric_unbundled_farkas_shift_theorem](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L187-L211) through [thm_28_ten_tier_qrh_boundary_hierarchy](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L268-L284)).
5. How Do Part I, Part II, and Part III Lock Together Algebraically (Theorems 36-45)?
   - Part I's margin $\frac{215}{3264}$ scales by the $2/3$ sieve weight to Part II's shift $\frac{7}{8} - \frac{4069}{4896} = \frac{215}{4896}$ ([thm_36_trilogy_denominator_bridge_3264_and_4896](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L167-L178), [thm_37_case001_margin_215_3264_drives_case005_4069_4896](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L185-L205)).
   - Meanwhile, the CubicGauss fixed point $\alpha^{\ast} = \frac{4}{3}$ and the coordR pole $\beta_{\mathrm{pole}} = \frac{2}{3}$ satisfy $\alpha^{\ast} + \beta_{\mathrm{pole}} = 2$ ([thm_39_eisenstein_pole_duality_cubic_gauss_vs_coordR](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L232-L243) through [thm_42_gap_between_71_108_and_7_12_equals_3264_over_44064](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L284-L293)).

## 2. Scope Boundary: Conditional Exponent Synthesis vs. Open Analytic Proofs

- Conditional LP and Algebraic Exponent Synthesis ($\frac{23}{24} \to \frac{71}{108} \approx 0.6574$):
  - Our 0 sorry Lean 4 theorems ([thm_27_connecting_cubic_gauss_2_3_sieve_to_path_A_71_108](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L252-L264), [thm_40_cubic_gauss_plus_stickelberger_crosses_two_thirds](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L249-L258), and [thm_41_case001_gauss_branch_vanishing_drives_case005_pole_shift](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L264-L278)) verify the conditional LP and algebraic exponent synthesis down to $\beta = \frac{71}{108} \approx 0.6574$.
  - Actually attaining $\beta = \frac{71}{108}$ in a full analytic zero-free region theorem remains contingent on constructing the complete analytic proof of Stickelberger pole cancellation ($k_\infty = -6$) and Voronoi-Mellin transfer, which is still an unbuilt theoretical blueprint rather than an assembled proof.
- Remaining Open Analytic Problem ($\frac{71}{108} \to \frac{1}{2}$):
  - Beyond that unbuilt $71/108$ transfer blueprint, crossing the remaining $\frac{17}{108} \approx 0.1574$ energy gap to $\beta = \frac{1}{2}$ ([thm_44_six_stage_trilogy_telescoping_decomposition](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L316-L331)) requires proving the conditional saving $\Delta_{\mathrm{hybrid}} = \frac{14}{33}$ via off-diagonal spectral cancellation, which remains an open analytic problem.

## 3. Ten-Tier QRH Boundary Progression

1. Tier 1, OpenAI ShortDraft submodule (DirichletL/RowCompletion/ZeroFreeRegion.lean, openai/math commit 4eaee87 / PR #70 ca28f20): $\beta = 23/24 \approx 0.95833333$, strip width $1 - \beta = 1/24 \approx 0.04167$ ($1.00\times$).
2. Tier 2, OpenAI paper2.tex and AlexKontorovich/quasi-rh: $\beta = 11/12 \approx 0.91666667$, strip width $1/12 \approx 0.08333$ ($2.00\times$).
3. Tier 3, OpenAI SevenEighths.lean proved main baseline (which logically implies Tiers 1 and 2): $\beta = \frac{7}{8} = 0.87500000$, strip width $1/8 = 0.12500$ ($3.00\times$).
4. Tier 4, Part II Fixed-Scale Global SOS Saddle: $\beta = (6843 - 7\sqrt{921})/7578 \approx 0.87497547$, strip width $0.12502453$ ($3.0006\times$).
5. Tier 5, Baiying Liu Rational Perturbation (arXiv:2610.12234, unrefereed preprint): $\beta = 34999/40000 = 0.87497500$, strip width $5001/40000 = 0.125025$.
6. Tier 6, Baiying Liu 3-Face $\mathbb{Q}(\sqrt{921})$ Optimum (arXiv:2610.12234, unrefereed preprint): $\beta = (1507 - 2\sqrt{921})/1653 \approx 0.87495707$, strip width $0.12504293$ ($3.0010\times$).
7. Tier 7, Xu-Sang $\delta = 0$ Amplification (arXiv:2610.15291, unrefereed preprint): $\beta = 8748867/10000000 = 0.87488670$, strip width $0.12511330$ ($3.0027\times$).
8. Tier 8, Part II 2-Term Unbundled Gram plus Stickelberger exponent target: $\beta = 4103/4896 \approx 0.83803105$, strip width $793/4896 \approx 0.16197$ ($3.89\times$).
9. Tier 9, Part II 3-Term Unbundled Gram plus Stickelberger exponent target: $\beta = 4069/4896 \approx 0.83108660$, strip width $827/4896 \approx 0.16891$ ($4.05\times$).
10. Tier 10, Conditional LP Synthesis Floor (Part II plus CubicGauss exponent blueprint): $\beta = 71/108 \approx 0.65740741$, strip width $37/108 \approx 0.34259$ ($8.22\times$), contingent on constructing the full analytic Stickelberger pole-cancellation and Voronoi-Mellin transfer proof.

## 4. Navigation Across Tiers

- [Main English README (README.md)](../README.md): Overview of the synthesis scope, declaration totals (45 theorems, 11 def declarations, and 1 structure), and verification commands.
- [Intermediate Guide (en/02_Intermediate_Guide.md)](02_Intermediate_Guide.md): Detailed algebraic derivations for the five pillars and the 26-file reference corpus mapping.
- [Advanced Guide (en/03_Advanced_Guide.md)](03_Advanced_Guide.md): Full synthesis proofs, Z[sqrt(921)] ring computations, trilogy bridge, and 178-declaration audit ledger.
- [Expert Verification (en/04_Expert_Verification.md)](04_Expert_Verification.md): SHA-256 artifact checksums, Lean 4 kernel commands, and 1-to-1 map of all 45 theorems.
