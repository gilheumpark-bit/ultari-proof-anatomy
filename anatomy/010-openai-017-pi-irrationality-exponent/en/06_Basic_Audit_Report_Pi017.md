# Audit Summary: OpenAI #017 (The irrationality exponent of $\pi$ is $2$)

- Target (Repository / Preprint): OpenAI openai/math (commit 4eaee87) Family #017 (5 files across main.tex and `sections/*.tex` · 1,591 lines; 869 .lean files in OAI/NumberTheory/PiExponent/ · 94,948 lines + reasoning_traces/irrationality-exponent-of-pi.pdf 42 pages)
- Verification Toolchain: Lean 4 v4.34.1 (upstream) · Lean 4 v4.35.0 (archive standard) / Python 3.14 (SymPy symbolic engine)
- Artifact Checksums (SHA-256): [pi_simplex_parameters_and_stratigraphy.lean](../proofs/pi_simplex_parameters_and_stratigraphy.lean) (fa4c73cf1acb...) | [pi_transverse_multiplicity_and_seshadri_blowup.lean](../proofs/pi_transverse_multiplicity_and_seshadri_blowup.lean) (2e7c8c2e726c...) | [pi_laurent_determinant_and_flint_hills.lean](../proofs/pi_laurent_determinant_and_flint_hills.lean) (3795672a078f...) | [verify_symbolic_pi017.py](../proofs/verify_symbolic_pi017.py) (602809c6314c...)
- Verification Method: 75 independent Lean 4 theorems (1,646 lines, 0 sorry, 0 axiom, 120 / 120 hypothesis mutations killed, 44 nonlinear/inductive proofs) & live parser verification across 60 oai_ref/ files
- 5-Gate Audit Verdict: Gate 1: PASS · Gate 2: HOLD · Gate 3: FAIL · Gate 4: HOLD · Gate 5: PASS $\implies$ TIER C (Conditional Revision Required - Genuine Mathematical Breakthrough with Trace-to-Paper Citation Drop & Technical Attribution Deficit)



## 0. 8-Metric Executive Scorecard (TL;DR)

| Audit Dimension | Claimed in Manuscript (PDF / Docs) | Measured in Repository (Lean 4 / Reasoning Trace) | Discrepancy / Status |
| :--- | :--- | :--- | :---: |
| 1. Code Reachability | 869 files in OAI/NumberTheory/PiExponent/ (94,948 lines) | File import reachability 100% (869 / 869) / 4 files (259 lines) with 0 outgoing calls · 552 unused decls | Call-Graph Redundancy (HOLD, CP-05) |
| 2. Scope Note (017.md) | lean/docs/017.md:11: Flint-Hills convergence "outside selected statement" (`PiExponent.lean`) | `017.md:11` accurately scopes `PiExponent.lean`; [Main.lean:29-32](../proofs/oai_ref/lean/OAI/NumberTheory/PiExponent/Main.lean#L29-L32) additionally proves `flint_hills_summable` (Cor 1.2) with `0 sorry` (only Cor 5.2 omitted) | Class C Unclaimed Discovery |
| 3. Manuscript–Code Match | Continuous simplex ($2k!$), $\Lambda_{\text{paper}}=4\log 2$, sine constant $8/\pi$ | Inscribed discrete rectangle ($k^k$, $C_*$ 3.83 × 10^6$\times$ larger), Chebyshev $\Lambda_{\text{Lean}}=\log 4+4$, Fin 4 constant 16 | 4 Constructive Adaptations (HOLD, CP-07) |
| 4. Upstream Patching | Pure Mathlib dependency | 0 third-party patches (100% pure Mathlib dependency) | Clean Dependency (PASS) |
| 5. Citation Hygiene | 37 \cite commands / 38 key invocations (25 / 25 .bib keys linked) | Intro 24 commands / 25 keys (264 lines) vs. Secs 2–5 13 (1,327 lines, 9.3 : 1 skew; Sec 4 0) + 16 / 23 (69.6%) trace refs dropped vs. 3/25 non-input `math.GM` notes | Selection Asymmetry (CP-03) |
| 6. Worker & Duplicate Strata | Unified formalization repository | 20 parallel worker namespaces (W06–W64, 137 blocks) · 263 duplicate names (656x) · 23 cloned theorem pairs | Worker Strata Retained (CP-10, CP-11) |
| 7. Premise Integrity | Full definition & bundle soundness | 0 sorry, 0 axiom, 23 active structure bundles constructively witnessed (14 unused `_h*` lines are benign over-hypotheses) | Kernel Sound (Gate 1 PASS) |
| 8. Mathematical Value | Resolves $\mu(\pi)=2$ (Thm 1.1) & Flint-Hills (Cor 1.2) | First unconditional resolution of both open problems verified + 5,000$\times$ ($m=2$) $C_*$ compression without Riemann integration | Genuine Breakthrough (Gate 5 PASS) |



## 1. Summary of Verified Physical Findings

### 1.1 69.6% Trace-to-Paper Citation Drop & 9.3 : 1 Section Citation Skew (CP-03)
- 16 / 23 (69.6%) Reasoning-Trace References Dropped from references.bib: Of 23 works cited in the 42-page reasoning trace (reasoning_traces/irrationality-exponent-of-pi.pdf), 16 (69.6%) were omitted from the final bibliography, including OpenAI (2026) [17] (#005 Catalan, cited 35 times across Part I), [18] (#107), Esnault–Viehweg (1984) [11], Ru–Vojta (1997) [20] / Vojta (1996) [22], Bombieri–Vaaler (1983) [6], and Hartshorne (1977) [14].
- 9.3 : 1 Citation Skew, 6 Uncited Classical Theorem Families & Bibliographic Selection Asymmetry: The introduction (264 lines) contains 24 `\cite` commands / 25 citation keys (90.91 commands / 1k lines), whereas Sections 2–5 (1,327 lines) contain only 13 (9.80 / 1k lines, with 0 in conclusion.tex), deploying 6 classical theorem families without call-site attribution: (I) Esnault-Viehweg 1984 / Faltings 1991 / Fischler-Nakamaye 2014 weighted multiprojective zero estimates, (II) Ax 1971 / Lang 1982 logarithmic differential residue rigidity, (III) Serre 1955 / Hartshorne 1977 algebraic Čech-Serre vanishing, (IV) Laurent 1991 / Waldschmidt 2000 interpolation determinant row translation, (V) Chebyshev 1852 / Hanson 1972 / Nair 1982 dyadic LCM bounds, and (VI) Jordan 1882 / Hardy-Littlewood 1923 dyadic semicircle spacing. Conversely, while omitting 16 / 23 (69.6%) peer-reviewed reasoning-trace inputs, `references.bib` retains `#23`–`#25` unrefereed `arXiv [math.GM]` preprints explicitly declared in [main.tex:140-155](../proofs/oai_ref/tex/main.tex#L140-L155) as non-input contextual notes (`LopezZapata2026`, `withdrawn v2` `MantzakourasLopezZapata2025`, and `Carella2022` `arXiv:1902.08817v10` where main.tex states `"Neither claim is used here"` while Footnote 1 notes Thm 8.1's sign obstruction and leaves Carella's $\mu(\pi)=2$ claim `"not decide[d]"`).

### 1.2 Main.lean:29-32 Class C Unclaimed Formalization Discovery & 4 Constructive Adaptations (CP-04, CP-07)
- Flint-Hills Series Formalization Verified (Class C Unclaimed Discovery): `lean/docs/017.md:11` accurately states relative to the comparator wrapper `PiExponent.lean` (`theorem main`) that the Flint-Hills series convergence consequence is `"outside this selected statement"`, whereas [Main.lean:29-32](../proofs/oai_ref/lean/OAI/NumberTheory/PiExponent/Main.lean#L29-L32) (`flint_hills_summable`) additionally proves Corollary 1.2 with `0 sorry` as an unclaimed formalization discovery (only the two-parameter Corollary 5.2 is omitted).
- Four Paper-to-Lean Structural Adaptations: (1) Lemma 2.2 continuous simplex covering ($2k!$) $\to$ inscribed discrete rectangle ($k^k$, RectangularVolume.lean), (2) Section 3 global matrix size $M = |\mathcal{A}|$ integral $\to$ two opposite injections (`card_le_card_of_injOn` sandwich, `SimplexCounting.lean:40-110`), (3) three-tier LCM constant shift $\Lambda_{\text{PNT}} \approx 1.732 \to \Lambda_{\text{paper}} = 4\log 2 \approx 2.773 \to \Lambda_{\text{Lean}} = \log 4 + 4 \approx 5.386$ (Arithmetic.lean:13-24), and (4) complex Kodaira vanishing $\to$ algebraic Rees blowups + finite affine cover Čech cohomology (FiniteCoverCohomology.lean) and Fin 4 residue partitioning (`FlintSine.lean:74-86, 88-136`).

### 1.3 Call-Graph Redundancy & Parallel Worker Namespaces (CP-05, CP-10, CP-11)
- Across the 869 imported files (94,948 lines), call-graph analysis identifies 4 imported files (259 lines) with 0 outgoing declaration/instance references (OpenPullbackUnit.lean, LineBundleGluingTransitions.lean, FormalBranchOrder.lean, WeightedMonomialLattice.lean), 5 instance-only files (309 lines), 552 unreferenced top-level declarations, 263 duplicate declaration names (656 occurrences), 23 verbatim cloned theorem pairs, and 20 parallel worker namespaces (W06–W64, 137 blocks).

### 1.4 Verified Mathematical Breakthrough & Three-Tier Contribution Separation
- Unconditional Resolution of $\mu(\pi)=2$ and Flint-Hills Convergence Verified (Gate 1 & Gate 5: PASS): Euler periodicity $e^{2\pi i j} = 1 \in \mathbb{Z}[i]$ and Gaussian integer determinant norm multiplicativity $\|\Delta\| \ge 1$ strictly block overreach to general Liouville numbers ($\mu(\alpha)=\infty$).
- Three-Tier Contribution Separation: (1) Prior human transcendence theory & algebraic geometry foundations (Classical Foundation Layer), (2) AI Section 45 high-dimensional $m!$ simplex cancellation ($\theta=1-\delta, A=1-b\delta$) & 869-file 0-sorry constructive algebraic formalization (AI Asymptotic & Formalization Layer, Gate 1 & Gate 5 PASS; `Main.lean:29-32` `flint_hills_summable` is a `0 sorry` Class C unclaimed discovery), (3) 16/23 trace citation drop requiring bibliographic restoration (`017.md:11` accurately scopes `PiExponent.lean`).



## 2. Pre-bunking Predictable Objections (FAQ)

- Q1. "Are $\mu(\pi)=2$ (Theorem 1.1) and Flint-Hills series convergence (Corollary 1.2) genuinely proved without gaps?"
  - Fact: Both `pi_irrationalityExponent_eq_two` (`Main.lean:14-15`), `main` (`Main.lean:17-27`), and `flint_hills_summable` (`Main.lean:29-32`) together with the 9-line `Mathlib` comparator statement ([PiExponent.lean](../proofs/oai_ref/lean/ComparatorChallenges/PiExponent.lean#L7-L15)) compile across 869 modules (94,948 lines) with 0 sorry, 0 custom axioms, and 0 external patches, independently verified by our 75 Lean 4 theorems (120/120 mutations killed). Note, however, that Lean kernel soundness (`Gate 1 PASS`) does not substitute for completed human journal peer review (with `oai-math-revised` remediation ongoing).
- Q2. "Why did external commentators claim that the Flint-Hills series was not formalized?"
  - Fact: Because lean/docs/017.md:11 described only the comparator wrapper PiExponent.lean (theorem main), whereas Main.lean:29-32 and FlintConsequence.lean ($\nu = 9/4$) prove classical Flint-Hills convergence (Corollary 1.2) with 0 sorry.
- Q3. "Could this proof overreach and falsely prove $\mu(\alpha)=2$ for a Liouville number $\alpha$?"
  - Fact: No. Lemma 3.1 and Lemma 3.2 depend on Euler's period identity $e^{2\pi i j} = 1 \in \mathbb{Z}[i]$ and Gaussian integer clearing $q_i r_i = 2\pi i p_i \in 2\pi i \mathbb{Z}[i]$, which fail when $e^{j\alpha} \notin \mathbb{Z}[i]$.
- Q4. "Do the constant shifts between paper and Lean ($\Lambda = 4\log 2$ vs. $\log 4 + 4$, and $C_*^{\text{paper}}$ vs. $C_*^{\text{Lean}}$) affect $\mu(\pi)=2$?"
  - Fact: No. Once dimension $m$ is fixed, the lacunary weights $w_1 \gg w_2 \gg \dots \gg w_m$ are chosen inductively so that $\Lambda \sum_{i=1}^m 1/w_i < \varepsilon_0/3$ (WeightErrorMargin.lean), absorbing any $(m,\sigma)$-dependent constant.
- Q5. "If Gate 1 and Gate 5 both PASS, why is the overall tier TIER C (Conditional Revision Required)?"
  - Fact: Independently of mathematical/kernel soundness (`Gate 1 & 5: PASS`, distinct from completed journal peer review), bibliographic selection asymmetry omits 16 of 23 peer-reviewed references (69.6%) cited in the 42-page reasoning trace (including 35 citations to #005 Catalan and Esnault-Viehweg 1984 / Ru-Vojta 1997) from `references.bib` while `#23`–`#25` retain explicit non-input `math.GM` contextual notes (`main.tex:140-155`), and 6 classical theorem families are used across Sections 2–5 without call-site citations (Gate 3: FAIL, CP-03).
- Q6. "What exact revisions are required to upgrade #017 to TIER A?"
  - Fact: (1) Restore the 16 dropped peer-reviewed reasoning-trace references and 6 classical theorem citations at their call sites in `sections/*.tex` to resolve the bibliographic selection asymmetry (16 trace inputs dropped vs. 3 non-input `math.GM` contextual notes retained), and (2) prune the 4 unreferenced files (259 lines) (`017.md:11` already accurately scopes `PiExponent.lean` itself, while `Main.lean:29-32` `flint_hills_summable` is a `0 sorry` Class C unclaimed formalization discovery).



## 3. 10-Second Terminal Reproduction (Don't Trust, Verify)

```bash
# 1) Verify the 869-module stratigraphy, Lemma 4.1 rational witnesses, 3-tier LCM constants, and citation audit
python3 -B proofs/verify_symbolic_pi017.py

# 2) Kernel-check all 75 independent Lean 4 theorems (v4.35.0, 1,646 lines, 0 sorry, 0 axiom, 120/120 mutations killed)
lean proofs/pi_simplex_parameters_and_stratigraphy.lean
lean proofs/pi_transverse_multiplicity_and_seshadri_blowup.lean
lean proofs/pi_laurent_determinant_and_flint_hills.lean
```
