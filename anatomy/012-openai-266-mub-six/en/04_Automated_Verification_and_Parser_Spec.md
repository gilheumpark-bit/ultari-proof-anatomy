# [Case 012 / Tier 4 Automated Verification & Parser Spec] OpenAI `#266` (`Mutually unbiased bases in dimension six`) SHA-256 Integrity & Reproduction Protocol

> **Target Audience**: Automated verification pipelines (`tools/verify_all.py`) and reproducibility auditors
> **Navigation**: [English Main README (`README.md`)](../README.md) | [Executive Summary (`en/01_`)](01_Executive_Summary_and_General_Guide.md) | [Intermediate Guide (`en/02_`)](02_Intermediate_Math_and_Code_Guide.md) | [Expert Forensic Report (`en/03_`)](03_Expert_Forensic_and_Mathematical_Physics_Report.md)

---

## 1. Cryptographic SHA-256 Checksum Ledger (`proofs/`)

| Artifact Path (`proofs/...`) | SHA-256 Checksum | Role & Verification Gate |
| :--- | :--- | :--- |
| [`proofs/mub6_hadamard_fourier_and_cubic_fibers.lean`](../proofs/mub6_hadamard_fourier_and_cubic_fibers.lean) | `f2ec0224dade6a0f0e0ff3880c607fded366b2891de69c20035f6a29a670c341` | `Theorems 1-25` (`429` lines: Kronecker 3-MUB lower bound, Newton sextic $z^6-e_3z^3+e_6$ & $(3,3)$ cube-fiber cancellation, pair-moment $L_H$ SOS vanishing, `5`-cycle Tao classification $\lvert\operatorname{Aut}(T)\rvert=720$, repaired `SmallPartitions.lean` lemmas, `103/103` mutations caught) |
| [`proofs/mub6_weiner_completion_and_gram_sos.lean`](../proofs/mub6_weiner_completion_and_gram_sos.lean) | `7a35eb64367bd78f96b21491593f59686af7514994c7c46610d18a5bc3c0fb49` | `Theorems 26-50` (`416` lines: Weiner realigned Kraus superoperator $6\to 7$ completion, dimension-rigidity barrier $36-5k=6 \iff k=6$, `6` Young-symmetrizer Schur blocks with `98` pivots $>40,000$, `37,623,398,400 = 6480 * 5,806,080` denominator bridge & `N(6) <= 5`, `113/113` mutations caught) |
| [`proofs/mub6_stratigraphy_and_binary64_audit.lean`](../proofs/mub6_stratigraphy_and_binary64_audit.lean) | `389340460d6644f782366ce7376733c840a73cf247628d53d38690083eebdd36` | `Theorems 51-75` (`404` lines: `3,386`-file / `2,835,031`-line stratigraphy, `Main.lean` `15/16` unused imports, orphaned `Attainable 3` `342` lines, `62,767` unused binders, reflected canonicalizer saving `2,015,523` lines, Stage A/B/C conservation & `binary64` FMA hazard, `142/142` mutations caught) |
| [`proofs/verify_symbolic_mub266.py`](../proofs/verify_symbolic_mub266.py) | `1c14ea9d1e931fac06bd0e935b2099bdb6271fe72f1e5ae06b829ab445f8e93b` | Deterministic symbolic and forensic verifier (`439` lines; live-parses all `69` `oai_ref/` files and reproduces `symbolic_verification_result.json` byte-for-byte) |
| [`proofs/symbolic_verification_result.json`](../proofs/symbolic_verification_result.json) | `92bb0e153e4f664ea4c9250be709630beae0db07e1e1199f67cdd63f3e84b47b` | `108` Kronecker inner products `1/6`, `20` balanced permutations $\lvert g_T\rvert^2=1/4$, `25` exact rational $U^T D U$ entries of `Block0.lean`, 22-digit residual margin `-2517408343748053647360`, C++/verifier audit, and stratigraphy JSON (`180` lines) |
| [`proofs/problem_spec.md`](../proofs/problem_spec.md) | `99fb0660e1f6cad2b2255d32b226364955f975752948b3d84d89943ddc619241` | Problem specification, three-pillar subsystem scope, and append-only seal revision ledger (`24` lines) |

---

## 2. Append-Only Seal Revision Ledger (`prev_sha256` $\to$ `entry_sha256`)

Rather than silently overwriting previously sealed hashes, every post-seal revision is appended below with its explicit rewrite reason and the cryptographic link from `Seq 1` (`prev_sha256`, commit `d31a33e`) to `Seq 2` (`entry_sha256`), mirrored in `manifest.json` (`seal_revision_ledger`) and at the bottom of each revised file.

- **Revision Sequence & Date**: `Seq 2` (`2026-11-13`, superseding `Seq 1` at commit `d31a33e`)
- **Rewrite Reason**: Removed internal prompt classification labels from the `L8` header comments of the `3` `.lean` files and the `L1` title of `problem_spec.md` for public release clarity, and appended `prev_sha256` provenance footers at the bottom of each revised file (zero changes to theorem declarations, proof terms, line numbers, or mathematical formulas).

| Target Artifact | Rewrite Scope & Reason | Previous Sealed Hash (`prev_sha256`, `Seq 1`) | New Sealed Hash (`entry_sha256`, `Seq 2`) |
| :--- | :--- | :--- | :--- |
| `mub6_hadamard_fourier_and_cubic_fibers.lean` | `L8` header comment cleanup + `L429` bottom `prev_sha256` footer (`0` theorem/proof edits) | `1cbdf44e2ac2264afe7ea1442eb02dfbf39af1ce553c923afa170e8f8b1a5d40` | `f2ec0224dade6a0f0e0ff3880c607fded366b2891de69c20035f6a29a670c341` |
| `mub6_weiner_completion_and_gram_sos.lean` | `L8` header comment cleanup + `L416` bottom `prev_sha256` footer (`0` theorem/proof edits) | `e9b89f4f5a2d535a2a5454560d289c19d6a02d5d30249ee5412cb5d7cf3fec73` | `25e779adea9e284c09310483dc278b9629c43e3953ad6e6c3910b34bd5f07d3d` |
| `mub6_stratigraphy_and_binary64_audit.lean` | `L8` header comment cleanup + `L404` bottom `prev_sha256` footer (`0` theorem/proof edits) | `f8e5845ad731044fecbf8e6ae8548508223171c06e917ceefd89dffd005726e3` | `1e65a0c7ff96d9b64ddc1ee95af78e14656422b8fa44526ba0d8fd052e7fbe3d` |
| `problem_spec.md` | `L1` title label cleanup + bottom Section 3 (`L21-L24`) `prev_sha256` seal ledger | `7ceb936e9585544f11cbb9b066073e8faae6d7fbd359968e84ab8a019586afcf` | `99fb0660e1f6cad2b2255d32b226364955f975752948b3d84d89943ddc619241` |
| `verify_symbolic_mub266.py` | Unmodified (`Seq 1` seal preserved) | `1c14ea9d1e931fac06bd0e935b2099bdb6271fe72f1e5ae06b829ab445f8e93b` | `1c14ea9d1e931fac06bd0e935b2099bdb6271fe72f1e5ae06b829ab445f8e93b` |
| `symbolic_verification_result.json` | Unmodified (`Seq 1` seal preserved) | `92bb0e153e4f664ea4c9250be709630beae0db07e1e1199f67cdd63f3e84b47b` | `92bb0e153e4f664ea4c9250be709630beae0db07e1e1199f67cdd63f3e84b47b` |

---

## 3. Deterministic One-Click Verification Commands

```bash
# 1. Cryptographic SHA-256 checksum verification
sha256sum -c proofs/checksums.sha256

# 2. Lean 4 kernel compilation check (0 sorry, 1,249 lines, 75 theorems)
~/.elan/bin/lean proofs/mub6_hadamard_fourier_and_cubic_fibers.lean
~/.elan/bin/lean proofs/mub6_weiner_completion_and_gram_sos.lean
~/.elan/bin/lean proofs/mub6_stratigraphy_and_binary64_audit.lean

# 3. Symbolic and forensic verifier reproduction
python3 -B proofs/verify_symbolic_mub266.py

# 4. Full verification suite (358/358 mutations caught + Elab MetaM DoF 74/75 + nonlin 14 + oai_ref 69/69 100%)
python3 -B ../../tools/verify_all.py --root .
```
