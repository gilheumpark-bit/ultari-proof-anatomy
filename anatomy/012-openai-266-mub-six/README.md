# Case 012: OpenAI `#266` (`Mutually unbiased bases in dimension six`) : Forensic Anatomy & Formal Verification Package

> **한국어 안내**: [README.ko.md](README.ko.md) | **Parent Repository**: [`ultari-proof-anatomy`](../../README.md)

This case (`012-openai-266-mub-six`) dissects OpenAI's flagship quantum-information family **`#266` (`Mutually unbiased bases in dimension six`, September 24, 2026)** across both accompanying preprints (Preprint 1 claiming $N(6) = 3$ via native C++ `binary64` covers across `12` `.tex` files = `5,945` lines + `8` `.cpp` files = `2,316` lines, and Preprint 2 establishing exact Fourier certificates across `8` `.tex` files = `1,997` lines + `verify.py` = `576` lines) together with the single largest directory in `openai/math`: `OAI/Analysis/MutuallyUnbiased/` (**`3,386` Lean 4 files, `2,835,031` lines**) plus `OAI/LinearAlgebra/Hadamard/` (**`9` files, `1,329` lines**), independently re-verifying the architecture via `75` standalone Lean 4 theorems (`1,249` lines, `0 sorry`, `358/358` hypothesis mutations caught = `100%`, `74/75` structural, `14` nonlinear/inductive proofs, dual-witness non-vacuity checks).

---

## 1. Four-Tier Documentation Index (`en/` & `ko/`)

| Tier | English Guide (`en/`) | Korean Guide (`ko/`) | Core Scope |
| :---: | :--- | :--- | :--- |
| **Tier 1** | [`en/01_Executive_Summary_and_General_Guide.md`](en/01_Executive_Summary_and_General_Guide.md) | [`ko/01_일반인용_해설서.md`](ko/01_일반인용_해설서.md) | Five Causal Questions (prime-power Galois collapse at $d=6$, sextic cube fibers $z^6-e_3z^3+e_6$ & unique `5`-cycle $T$, Weiner $6\to 7$ superoperator completion & `6`-block Schur Positivstellensatz $N(6) \le 5$, `2.835M`-line unrolling inflation & orphaned `Attainable 3`, unformalized `binary64` $N(6) = 3$ gap) |
| **Tier 2** | [`en/02_Intermediate_Math_and_Code_Guide.md`](en/02_Intermediate_Math_and_Code_Guide.md) | [`ko/02_중급자용_수학및코드가이드.md`](ko/02_중급자용_수학및코드가이드.md) | Three-pillar mathematical pipeline, `75`-theorem mapping (`thm_01`..`thm_75`), symbolic verifier walkthrough |
| **Tier 3** | [`en/03_Expert_Forensic_and_Mathematical_Physics_Report.md`](en/03_Expert_Forensic_and_Mathematical_Physics_Report.md) | [`ko/03_전문가용_학술및수리물리보고서.md`](ko/03_전문가용_학술및수리물리보고서.md) | `3,386 + 9`-file stratigraphy (`2,835,031` lines vs `576`-line Python = `4,921.9x` inflation, `Main.lean` `15/16` unused imports, `62,767` vacuous `_h*` binders, orphaned `Attainable 3` `342` lines), `69/69` `oai_ref/` `#L` index, reflected canonicalizer (`>2.01M` lines saved) & Weiner dimension rigidity ($36-5k=6 \iff k=6$), `binary64` ABI contract & `.bib` citation audit |
| **Tier 4** | [`en/04_Automated_Verification_and_Parser_Spec.md`](en/04_Automated_Verification_and_Parser_Spec.md) | [`ko/04_자동검증및파서용_명세서.md`](ko/04_자동검증및파서용_명세서.md) | Cryptographic SHA-256 checksum ledger and one-click reproduction commands |

---

## 2. Verification Artifacts (`proofs/`)

- [`proofs/mub6_hadamard_fourier_and_cubic_fibers.lean`](proofs/mub6_hadamard_fourier_and_cubic_fibers.lean#L1-L429) (`Theorems 1-25`, `429` lines, `103/103` mutations caught, `nonlin: 7`)
- [`proofs/mub6_weiner_completion_and_gram_sos.lean`](proofs/mub6_weiner_completion_and_gram_sos.lean#L1-L416) (`Theorems 26-50`, `416` lines, `113/113` mutations caught, `nonlin: 4`)
- [`proofs/mub6_stratigraphy_and_binary64_audit.lean`](proofs/mub6_stratigraphy_and_binary64_audit.lean#L1-L404) (`Theorems 51-75`, `404` lines, `142/142` mutations caught, `nonlin: 3`)
- [`proofs/verify_symbolic_mub266.py`](proofs/verify_symbolic_mub266.py#L1-L439) $\to$ [`proofs/symbolic_verification_result.json`](proofs/symbolic_verification_result.json#L1-L180)
- [`proofs/problem_spec.md`](proofs/problem_spec.md#L1-L20) & [`manifest.json`](manifest.json#L1-L530)
