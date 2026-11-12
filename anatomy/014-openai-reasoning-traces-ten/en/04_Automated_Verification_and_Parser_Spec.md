# [Case 014 / Tier 4 Automated Verification & Parser Spec] OpenAI `10` Publicly Released Reasoning Traces (`reasoning_traces/`) SHA-256 Integrity & Reproduction Protocol

> **Target Audience**: Automated verification pipelines (`tools/verify_all.py`) and reproducibility auditors
> **Navigation**: [English Main README (`README.md`)](../README.md) | [Executive Summary (`en/01_`)](01_Executive_Summary_and_General_Guide.md) | [Intermediate Guide (`en/02_`)](02_Intermediate_Math_and_Code_Guide.md) | [Expert Forensic Report (`en/03_`)](03_Expert_Forensic_and_Mathematical_Physics_Report.md)

---

## 1. Cryptographic SHA-256 Checksum Ledger (`proofs/`)

| Artifact Path (`proofs/...`) | SHA-256 Checksum | Role & Verification Gate |
| :--- | :--- | :--- |
| [`proofs/traces10_compiler_and_citation_drop.lean`](../proofs/traces10_compiler_and_citation_drop.lean) | `1c96229c436f33d5ac72bd5ab3fffa90d47acfab5da54b4074f79ecf5137184d` | `Theorems 1-25` (`403` lines: `10/373` trace sampling & `202`-page / `9,308`-line accounting, `reasoning_traces/mezard-parisi-formula.tex` `#102` macros (`L47-L56`) & `FandolFang` (`L68`) `"自由"` unused CJK fallback (`L76-L79`) vs `38` math glyphs in `glyph-mappings.tex`, `MinUncut.lean` `22`-line `1,401`-byte docstring masking, `BinaryCorrectedElliott.lean` `27`-line `open` header, `230/332 = 115/166` citation drop & `3/3` self-citation erasure, `4/8` unformalized sibling papers, `132/132` mutations caught) |
| [`proofs/traces10_algebraic_combinatorial_engines.lean`](../proofs/traces10_algebraic_combinatorial_engines.lean) | `64df0ca7c8b741235ee9da2526ffa8029772a6f94ad685b2f04c50415e0d5a62` | `Theorems 26-50` (`469` lines: `#007` Elliott log-saving denominator & `3`-scale pigeonhole, `#017` single-box barrier (`1 + 1/√a > 2`), `62/25 < 5/2` Flint-Hills convergence (`2μ - 5 = -1/25`), `m!` simplex cancellation, & `7.1032 -> 2.4800 -> 2.0000` drop, `#087` `4^n` Hanner duality, Riccati `194 > 180` margin, & `384 vs 256` simplex gap, `#102` trilinear `Q(x)`, `k^(-2/3)` sparse projection, & `5`-preprint fanout, `#159` doubly exponential precision blowup, `#197` char-`2` punctured projective line, planar Euler contradiction, & defect idempotent, `99/99` mutations caught) |
| [`proofs/traces10_analytic_operator_and_scope_audit.lean`](../proofs/traces10_analytic_operator_and_scope_audit.lean) | `fbe8685b917b390052f51f73caaa6d208c25b808073e490590f00ecd17a29697` | `Theorems 51-75` (`465` lines: `#221` quadratic & quartic cavity SOS identities, `#271` Heisenberg reflection-positivity floor & infrared shell `4s < 5s`, `#287` Haagerup radial word bound & Dykema-Radulescu `1+(r-1)/t^2=2` compression, `#362` Vlasov-Maxwell `496 > 410` bootstrap & subluminal gap, `22 -> 11 -> 9 -> 7` scope attrition funnel, `5/5` stub false positives vs `2,170` `OAI/` vacuous hypotheses No-Go theorem, `#087` (`45`p/`2,191`L) vs `#221` (`5`p/`210`L) dispersion, `115/115` mutations caught) |
| [`proofs/verify_symbolic_traces10.py`](../proofs/verify_symbolic_traces10.py) | `c0e92bca74105ee11a2dd90cd26314de0ae59f7cc5ffae43e88541d3154ea540` | Deterministic symbolic and primary-source forensic verifier (`341` lines; live-parses all `51` `oai_ref/` reference files and reproduces `symbolic_verification_result.json` byte-for-byte) |
| [`proofs/symbolic_verification_result.json`](../proofs/symbolic_verification_result.json) | `f018edf7128ebe7dbb410bc27603e4de64c4d37c36bc750ac540d85e8f2dfe15` | Live forensic audit ledger (`177` lines: `211`-line `mezard-parisi-formula.tex` template audit, per-trace `332`-vs-`315` citation breakdown, `21` challenge & `9,929` `OAI/` checks, and exact SymPy invariants across all `10` domains) |
| [`proofs/problem_spec.md`](../proofs/problem_spec.md) | `38d9ca5639a7bdefdc324af0c5f270b6d4a36861e9cc02c8c8c69b16c3f8e919` | Problem specification, exclusion boundary, anchor checks, and three-pillar subsystem scope (`21` lines) |

---

## 2. Deterministic One-Click Verification Commands

```bash
# 1. Cryptographic SHA-256 checksum verification
sha256sum -c proofs/checksums.sha256

# 2. Lean 4 kernel compilation check (v4.29.0-rc8, 0 sorry, 1,337 lines, 75 theorems)
~/.elan/bin/lean proofs/traces10_compiler_and_citation_drop.lean
~/.elan/bin/lean proofs/traces10_algebraic_combinatorial_engines.lean
~/.elan/bin/lean proofs/traces10_analytic_operator_and_scope_audit.lean

# 3. Symbolic and primary-source forensic verifier reproduction
python3 -B proofs/verify_symbolic_traces10.py

# 4. Integrated package verification gate (346/346 mutations caught + Elab MetaM DoF 73/75 + nonlin 19 + oai_ref 29/29 100%)
python3 -B ../../tools/verify_all.py --root .
```
