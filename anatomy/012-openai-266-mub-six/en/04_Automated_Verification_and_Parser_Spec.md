# [Case 012 / Tier 4 Automated Verification & Parser Spec] OpenAI `#266` (`Mutually unbiased bases in dimension six`) SHA-256 Integrity & Reproduction Protocol

> **Target Audience**: Automated verification pipelines (`tools/verify_all.py`, `extra_scan.py`, `code_discipline.py`) and reproducibility auditors
> **Navigation**: [English Main README (`README.md`)](../README.md) | [Executive Summary (`en/01_`)](01_Executive_Summary_and_General_Guide.md) | [Intermediate Guide (`en/02_`)](02_Intermediate_Math_and_Code_Guide.md) | [Expert Forensic Report (`en/03_`)](03_Expert_Forensic_and_Mathematical_Physics_Report.md)

---

## 1. Cryptographic SHA-256 Checksum Ledger (`proofs/`)

| Artifact Path (`proofs/...`) | SHA-256 Checksum | Role & Verification Gate |
| :--- | :--- | :--- |
| [`proofs/mub6_hadamard_fourier_and_cubic_fibers.lean`](../proofs/mub6_hadamard_fourier_and_cubic_fibers.lean) | `1cbdf44e2ac2264afe7ea1442eb02dfbf39af1ce553c923afa170e8f8b1a5d40` | `Theorems 1-25` (`429` lines: Kronecker 3-MUB lower bound, Newton sextic $z^6-e_3z^3+e_6$ & $(3,3)$ cube-fiber cancellation, pair-moment $L_H$ SOS vanishing, `5`-cycle Tao classification $\lvert\operatorname{Aut}(T)\rvert=720$, repaired `SmallPartitions.lean` lemmas, `103/103` mutations caught) |
| [`proofs/mub6_weiner_completion_and_gram_sos.lean`](../proofs/mub6_weiner_completion_and_gram_sos.lean) | `e9b89f4f5a2d535a2a5454560d289c19d6a02d5d30249ee5412cb5d7cf3fec73` | `Theorems 26-50` (`416` lines: Weiner realigned Kraus superoperator $6\to 7$ completion, dimension-rigidity barrier $36-5k=6 \iff k=6$, `6` Young-symmetrizer Schur blocks with `98` pivots $>40,000$, `37,623,398,400 = 6480 * 5,806,080` denominator bridge & `N(6) <= 5`, `113/113` mutations caught) |
| [`proofs/mub6_stratigraphy_and_binary64_audit.lean`](../proofs/mub6_stratigraphy_and_binary64_audit.lean) | `f8e5845ad731044fecbf8e6ae8548508223171c06e917ceefd89dffd005726e3` | `Theorems 51-75` (`404` lines: `3,386`-file / `2,835,031`-line stratigraphy, `Main.lean` `15/16` unused imports, orphaned `Attainable 3` `342` lines, `62,767` unused binders, reflected canonicalizer saving `2,015,523` lines, Stage A/B/C conservation & `binary64` FMA hazard, `142/142` mutations caught) |
| [`proofs/verify_symbolic_mub266.py`](../proofs/verify_symbolic_mub266.py) | `1c14ea9d1e931fac06bd0e935b2099bdb6271fe72f1e5ae06b829ab445f8e93b` | Deterministic symbolic and forensic verifier (`439` lines; live-parses all `69` `oai_ref/` files and reproduces `symbolic_verification_result.json` byte-for-byte) |
| [`proofs/symbolic_verification_result.json`](../proofs/symbolic_verification_result.json) | `92bb0e153e4f664ea4c9250be709630beae0db07e1e1199f67cdd63f3e84b47b` | `108` Kronecker inner products `1/6`, `20` balanced permutations $\lvert g_T\rvert^2=1/4$, `25` exact rational $U^T D U$ entries of `Block0.lean`, 22-digit residual margin `-2517408343748053647360`, C++/verifier audit, and stratigraphy JSON (`180` lines) |
| [`proofs/problem_spec.md`](../proofs/problem_spec.md) | `7ceb936e9585544f11cbb9b066073e8faae6d7fbd359968e84ab8a019586afcf` | Problem specification and three-pillar subsystem scope (`20` lines) |

---

## 2. Deterministic One-Click Verification Commands

```bash
# 1. Cryptographic SHA-256 checksum verification
sha256sum -c proofs/checksums.sha256

# 2. Lean 4 kernel compilation check (0 sorry, 1,249 lines, 75 theorems)
~/.elan/bin/lean proofs/mub6_hadamard_fourier_and_cubic_fibers.lean
~/.elan/bin/lean proofs/mub6_weiner_completion_and_gram_sos.lean
~/.elan/bin/lean proofs/mub6_stratigraphy_and_binary64_audit.lean

# 3. Symbolic and forensic verifier reproduction
python3 -B proofs/verify_symbolic_mub266.py

# 4. Ultari full verification gate (358/358 mutations caught + Elab MetaM DoF 74/75 + nonlin 14 + oai_ref 69/69 100%)
python3 -B ../../tools/verify_all.py --root .
```
