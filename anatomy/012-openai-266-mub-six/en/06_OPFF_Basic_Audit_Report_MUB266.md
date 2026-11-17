# Audit Summary: OpenAI #266 (Mutually Unbiased Bases in Dimension Six)

- Target (Repository / Preprints): OpenAI openai/math Family #266 - Preprint 1 ($N(6) = 3$: 12 .tex files · 5,945 lines, [references_mub6.bib](../proofs/oai_ref/tex_mub/references_mub6.bib#L1-L363) 27 keys, 33 \cite calls, 8 .cpp files · 2,316 lines, [check_records.py](../proofs/oai_ref/cpp/check_records.py#L1-L373) 373 lines) & Preprint 2 ($N(6) \le 5$: 8 .tex files · 1,997 lines, [references.bib](../proofs/oai_ref/tex_fourier/references.bib#L1-L326) 26 keys, 38 \cite commands / 41 key invocations, [verify.py](../proofs/oai_ref/tex_fourier/verify.py#L1-L576) 576 lines); 3,397 .lean files · 2,836,463 lines (MutuallyUnbiased/ 3,386 files · 2,835,031 lines + Hadamard/ 9 files · 1,329 lines + [MUBSix.lean](../proofs/oai_ref/challenges/MUBSix.lean#L1-L66) & [HadamardCubeFiber.lean](../proofs/oai_ref/challenges/HadamardCubeFiber.lean#L1-L37))
- Verification Toolchain: Lean 4 v4.29.0-rc8 (vs. audited v4.34.1) / Python 3.14 (SymPy symbolic engine)
- Artifact Checksums (SHA-256): [mub6_hadamard_fourier_and_cubic_fibers.lean](../proofs/mub6_hadamard_fourier_and_cubic_fibers.lean) (d15df51beb42...) | [mub6_weiner_completion_and_gram_sos.lean](../proofs/mub6_weiner_completion_and_gram_sos.lean) (84fa18c465e5...) | [mub6_stratigraphy_and_binary64_audit.lean](../proofs/mub6_stratigraphy_and_binary64_audit.lean) (818cc8871bac...) | [verify_symbolic_mub266.py](../proofs/verify_symbolic_mub266.py) (96ec2c66ba17...)
- Verification Method: 75 independent Lean 4 theorems + 5 defs (1,249 lines, 0 sorry, 0 axiom, 358 / 358 universal-hypothesis mutations killed = 100%) & live parser verification across 69 preserved oai_ref/ files
- OPFF Formal Verdict: Gate 1: PASS · Gate 2: FAIL · Gate 3: FAIL · Gate 4: FAIL · Gate 5: PASS ⇒ OPFF TIER C (Conditional Verification & Non-Conforming Artifact)

## 0. 8-Metric Executive Scorecard (TL;DR)

| Audit Dimension | Claimed in Preprints (PDF / Docs) | Measured in Repository (Lean 4 / C++ / Python) | Discrepancy / Status |
| :--- | :--- | :--- | :---: |
| 1. Formalization Scope | Resolves maximum MUBs in dimension six $N(6) = 3$ (#266) | Lean 4 proves $N(6) \le 5$ (Preprint 2); Preprint 1's $N(6) = 3$ ($n = 4, 5$ exclusion) has 0 lines of Lean formalization and relies on C++ binary64 search | $N(6)=3$ Unformalized (CP-04 FAIL) |
| 2. Unrolling Inflation | MutuallyUnbiased/ 3,386 files · 2,835,031 lines | 4,921.9x line inflation over 576-line [verify.py](../proofs/oai_ref/tex_fourier/verify.py#L1-L576); kernel reflection (Reflected Canonicalizer) saves 2,015,523 lines (71.1%) | 4,921.9x Inflation (CP-05 WARN) |
| 3. Entrypoint (Main.lean) | [Main.lean](../proofs/oai_ref/lean/Main.lean#L1-L33) 16 import statements (33 lines) | 1 / 16 active (Bounds.lean) vs. 15 / 16 (93.75%, 29,683 lines) non-propagating root imports; completed Attainable 3 proof (4 files, 342 lines, 0 sorry) left unimported | 15/16 Disconnected (CP-05 FAIL) |
| 4. check_records.py Scope | Verifies 100-run C++ certificate (196 artifact files) | [check_records.py](../proofs/oai_ref/cpp/check_records.py#L2-L7) is a derived format/bounds parser performing 0 mathematical recomputations of Hadamard residuals, singular values, or clique exclusions | 0 Recomputations (CP-04 · CP-07 FAIL) |
| 5. binary64 & Sept 7 Run | Rigorous IEEE-754 floating-point cover exclusion | Conditionally depends on MXCSR 0x1f80, -ffp-contract=off, and manual disassembly at covrun offset 6035; [covout.cpp](../proofs/oai_ref/cpp/covout.cpp#L100-L136) omits checkcpu(); Sept 7 run unauthenticated & replaced Oct 4 | Hardware & Provenance Gap (CP-07 · CP-11 FAIL) |
| 6. Premise Hygiene (_h*) | 629,541 declarations (0 sorry, 0 axiom) | 62,767 unused _h* hypothesis binders across generated Fubini normalization shards (54,676 in MixedSemantics, 7,685 in PairSemantics, 40 in [SmallPartitions.lean](../proofs/oai_ref/lean/SmallPartitions.lean#L77-L307)) | 62,767 Unused Binders (CP-01 · CP-06 WARN) |
| 7. Citation Hygiene | Preprint 1: 33 \cite calls; Preprint 2: 38 commands (41 key invocations) | 20/33 (60.6%) and 23/38 commands (24/41 key invocations = 58.5%) concentrated in the opening file (refinement.tex 656L & execution.tex 400L have 0 citations); 5 named classics omitted | Front-Loaded / 5 Omitted (CP-09 · CP-10 FAIL) |
| 8. Exact Fourier & SOS Core | MRW non-Tao vanishing, $(3,3)$ cubic 5-cycle, $N(6) \le 5$ | 6 Schur blocks (98 pivots $> 40,000$), denominator bridge 5,806,080, Weiner dimension lock $d^2-k(d-1)=d \iff k=d$ verified; confirmed by 75 OPFF theorems (358/358 mutants killed) | Gate 1 & Gate 5 PASS |

## 1. Summary of Verified Physical Findings

### 1.1 Scope Split Between Preprint 1 ($N(6)=3$, 0 Lean Lines) and Preprint 2 ($N(6)\le 5$, 2.84M Lean Lines) (CP-04, CP-07)
- Preprint 1 ($N(6) = 3$) Relies on Unformalized C++ binary64 Search & Format-Only Checker: While Preprint 2's algebraic bound $N(6) \le 5$ is formalized in Lean 4 with 0 sorry ([MUBSix.lean](../proofs/oai_ref/challenges/MUBSix.lean#L1-L66)), Preprint 1's headline exclusion of $n \in \{4, 5\}$ ($N(6) = 3$) has 0 lines of Lean formalization ([266.md](../proofs/oai_ref/docs/266.md#L1-L23)). Its companion script [check_records.py](../proofs/oai_ref/cpp/check_records.py#L2-L7) performs 0 mathematical recomputations of Hadamard residuals, singular values, or clique exclusions, and [introduction.tex:155-159](../proofs/oai_ref/tex_mub/introduction.tex#L155-L159) together with [execution.tex:4, 395-400](../proofs/oai_ref/tex_mub/execution.tex#L395-L400) ([execution.tex:4](../proofs/oai_ref/tex_mub/execution.tex#L4)) discloses that the initial September 7, 2026 run was not authenticated because its complete evidence packet was not recovered and was replaced post-hoc on October 4, 2026.
- Orphaned Attainable 3 Proof & 15 / 16 Non-Propagating Root Imports (CP-05): In [Main.lean](../proofs/oai_ref/lean/Main.lean#L1-L33) (16 imports), only 1 import (Bounds.lean) propagates to the challenge theorem while 15 / 16 (93.75%, 29,683 lines) are disconnected, and a completed 4-file (342-line, 0-sorry) proof of Attainable 3 is left unimported.

### 1.2 4,921.9x Unrolling Inflation (2,835,031 Lines) & 62,767 Unused _h* Binders (CP-05, CP-06)
- Unrolled Fubini Sum-Swap Shards: Instead of using a single polymorphic kernel-reflected canonicalizer, MutuallyUnbiased/ unrolls Fubini sum-swap lemmas across 56,427 keys into 3,386 files and 2,835,031 lines (a 4,921.9x expansion over the 576-line [verify.py](../proofs/oai_ref/tex_fourier/verify.py#L1-L576)); replacing the unrolled shards with a reflected canonicalizer saves 2,015,523 lines (71.1%).
- 62,767 Unused _h* Hypothesis Binders: AST inspection across all 629,541 declarations identifies 62,767 unused _h* binders (54,676 in MixedSemantics, 7,685 in PairSemantics, 40 in [SmallPartitions.lean](../proofs/oai_ref/lean/SmallPartitions.lean#L77-L307)).

### 1.3 Bibliographic Front-Loading (60.6% & 58.5%) & 5 Omitted Primary Sources (CP-09, CP-10)
- Front-Loaded Citations & Zero-Citation Proof Sections: In Preprint 1 (33 \cite calls), 20 (60.6%) appear in introduction.tex while refinement.tex (656 lines) and execution.tex (400 lines) contain 0 citations. In Preprint 2 (38 \cite commands / 41 key invocations), 23 commands (24 key invocations = 58.5%) appear in paper.tex while 5 technical works named in prose are omitted from the bibliography.

### 1.4 Verified Exact Fourier & Gram SOS Core ($3 \le N(6) \le 5$, Gate 1 & Gate 5: PASS)
- Valid Exact Rational & Algebraic Certificates: Our 75 independent Lean 4 theorems (1,249 lines, 358/358 mutations killed) verify (i) the MRW non-Tao Fourier vanishing $3\langle|L_H|^2\rangle + \langle|g_H(\alpha)g_H(q)|^2\rangle = 0$ via the $8,871 \times 909$ pair-moment matrix ($\operatorname{rank} = 897$) and 26-term witness $L_H$, (ii) the $(3,3)$ cube-fiber connected 5-cycle ($C_5$) classification under Newton power-sum cancellation $z^6 - e_3 z^3 + e_6$, and (iii) Weiner's $6 \to 7$ Kraus superoperator completion ($d^2 - k(d-1) = d \iff k = d$) combined with the 6 $S_5$ Young Schur blocks (98 pivots $> 40,000$, net integer margin $-2,517,408,343,748,053,647,360 < 0$).
- Three-Tier Contribution Separation: (1) Prior human MUB, Hadamard & representation-theory foundations 65%, (2) AI exact Fourier/Schur SOS certificate synthesis & $N(6) \le 5$ Lean 4 formalization 35% (Gate 1 & Gate 5 PASS), (3) unformalized $N(6)=3$ C++ search, format-only check_records.py, Sept 7 run replacement, and 2.02M lines of unrolled boilerplate require revision.

## 2. Pre-bunking Predictable Objections (FAQ)

- Q1. "Does the 2.84-million-line Lean 4 repository prove $N(6) = 3$?"
  - Fact: No. As noted in [266.md](../proofs/oai_ref/docs/266.md#L1-L23), the Lean 4 codebase proves only Preprint 2's algebraic bound $N(6) \le 5$ ([MUBSix.lean](../proofs/oai_ref/challenges/MUBSix.lean#L1-L66)) and the $(3,3)$ cubic fiber theorem ([HadamardCubeFiber.lean](../proofs/oai_ref/challenges/HadamardCubeFiber.lean#L1-L37)). Preprint 1's claim $N(6) = 3$ has 0 lines of Lean formalization.
- Q2. "Doesn't check_records.py independently verify Preprint 1's C++ computer-assisted proof?"
  - Fact: No. Line-by-line inspection of [check_records.py](../proofs/oai_ref/cpp/check_records.py#L2-L7) confirms that it is a schema and pre-tabulated threshold parser that performs 0 mathematical recomputations of matrix entries, singular values, or interval cover exclusions (CP-04, CP-07).
- Q3. "Are Preprint 2's exact Fourier and Gram SOS certificates for $N(6) \le 5$ mathematically sound?"
  - Fact: Yes. Both comparator challenges for Preprint 2 compile with 0 sorry and 0 custom axioms, and reconnecting the orphaned 342-line Attainable 3 proof yields the complete two-sided theorem $3 \le N(6) \le 5$ (Gate 1 & Gate 5: PASS).
- Q4. "Why did MutuallyUnbiased/ expand to 2,835,031 lines across 3,386 files?"
  - Fact: Because the generator emitted separate Fubini sum-swap normalization lemmas across 56,427 keys instead of using a kernel-reflected canonicalizer, inflating the 576-line Python verifier by 4,921.9x and leaving 62,767 unused _h* binders.
- Q5. "Why is the September 7, 2026 C++ execution flagged under Gate 4 (Provenance)?"
  - Fact: Because [introduction.tex:155-159](../proofs/oai_ref/tex_mub/introduction.tex#L155-L159) and [execution.tex:4, 395-400](../proofs/oai_ref/tex_mub/execution.tex#L395-L400) ([execution.tex:4](../proofs/oai_ref/tex_mub/execution.tex#L4)) explicitly state that the initial September 7 run was not authenticated because its complete evidence packet was not recovered and had to be replaced post-hoc by an October 4 re-execution, while [covout.cpp](../proofs/oai_ref/cpp/covout.cpp#L100-L136) omits the checkcpu() MXCSR hardware guard.
- Q6. "What exact revisions are required to upgrade #266 to OPFF TIER A?"
  - Fact: (1) Replace check_records.py with an independent interval-arithmetic verifier (or Lean 4 formalization) that recomputes Preprint 1's cover exclusions from raw matrix witnesses, (2) wire Attainable 3 into Main.lean and prune the 15 disconnected root imports, (3) fold the 2.02M lines of unrolled Fubini shards via reflection, and (4) restore the 5 omitted primary citations in the technical sections.

## 3. 10-Second Terminal Reproduction (Don't Trust, Verify)

```bash
# 1) Verify the 3,397-file (2,836,463-line) stratigraphy, 62,767 unused _h* binders, Schur pivots & check_records.py audit
python3 -B proofs/verify_symbolic_mub266.py

# 2) Kernel-check all 75 independent Lean 4 theorems (0 sorry, 0 axiom, 358/358 hypothesis mutations killed)
lean proofs/mub6_hadamard_fourier_and_cubic_fibers.lean
lean proofs/mub6_weiner_completion_and_gram_sos.lean
lean proofs/mub6_stratigraphy_and_binary64_audit.lean
```
