# [Case 015 / Tier 4 Automated Verification & Parser Spec] Cryptographic SHA-256 Integrity and Reproducibility Protocol for the Five Classical Riemann Barriers (`Theorems 1-75`)

> **Target Audience**: Automated verification pipelines (`tools/verify_all.py`) and reproducibility auditors
> **Parent Index**: [Main English README (`README.md`)](../README.md) | [Executive Summary (`en/01_`)](01_Executive_Summary_and_General_Guide.md) | [Intermediate Guide (`en/02_`)](02_Intermediate_Math_and_Code_Guide.md) | [Expert Forensic Report (`en/03_`)](03_Expert_Forensic_and_Mathematical_Physics_Report.md)

---

## 1. Cryptographic SHA-256 Checksum Table (`proofs/`)

| Artifact Path (`proofs/...`) | SHA-256 Checksum | Role & Verification Gate |
| :--- | :--- | :--- |
| [`proofs/classical_dlvp_korobov_and_zero_free.lean`](../proofs/classical_dlvp_korobov_and_zero_free.lean) | `af6541ccf6b13c36569f9f404073ba2b2f67082fdf69d99e59eb1629609f44ed` | `Theorems 1-15` (`508` lines: pole-zero SOS identity, `(3,4,1)` 4-tier cascade, `(17,24,8)` square `(41-4√102)/32`, irreducible quintic, Fejer-Riesz `c_1 < 2 c_0`, degree-3 counterexample `(65/16, 9/2, 0, -1)` & ceiling `(3-2√2)/3`, `39/39` mutations caught) |
| [`proofs/classical_ingham_huxley_zero_density.lean`](../proofs/classical_ingham_huxley_zero_density.lean) | `ce28dcbc8557015d7ce4c12de6cc4f796f9d9795e350313ffb0b50d725d51215` | `Theorems 16-25` (`400` lines: Ingham 3-term balance `3/(2-σ)`, Halasz-Schur phase loss `ε n^2 > 0`, Huxley reflection `3/(3σ-1)`, `σ* = 3/4` minimax peak `12/5`, prime-gap `7/12`, `28/28` mutations caught) |
| [`proofs/classical_guth_maynard_and_qrh_gram.lean`](../proofs/classical_guth_maynard_and_qrh_gram.lean) | `063a458575e8bdf4ca04583c2675b6a0fdde9f98ceb1eb09848b0e7862a81ce4` | `Theorems 26-35` (`380` lines: Guth-Maynard `15/(5σ+3)` & SOS margin `250(σ-3/4)^2+3/8 > 0`, `7/10` peak `30/13`, universal-`δ` `QRH` unbundling `215/3264` & `487/3264`, hybrid `β = 1/2` `14/33` & `-17/132` deficit, `25/25` mutations caught) |
| [`proofs/classical_siegel_zero_and_ineffectiveness.lean`](../proofs/classical_siegel_zero_and_ineffectiveness.lean) | `a9ac0f98d367306960a4578dfe3a1bf5c2a98c32187650aa79e1cb41d551611d` | `Theorems 36-50` (`372` lines: Estermann biquadratic `{0, 4}`, Perron optimal cutoff, `Classical.em` No-Go barrier, Landau-Page `5/46` repulsion, Goldfeld-Gross-Zagier rank-`3` effectivity & `Ostmann` cutoff ladder, `47/47` mutations caught) |
| [`proofs/classical_levinson_conrey_and_mollifier_barrier.lean`](../proofs/classical_levinson_conrey_and_mollifier_barrier.lean) | `86b85b06ff93f7ff6ba799a18913106ede607986a1bd16aec7af8f223da44198` | `Theorems 51-63` (`309` lines: mollifier ladder `1/2 < 17/33 < 35/66 < 4/7`, `HasDerivAt` invariant `J_{AB} = -1/2`, Cauchy-Schwarz `1 <= 4 I_{AA} J_{BB}`, `coth ω > 1 => κ(θ) < 1`, Levinson `κ > 1/3` certificate, `29/29` mutations caught) |
| [`proofs/classical_burgess_and_kim_sarnak_barrier.lean`](../proofs/classical_burgess_and_kim_sarnak_barrier.lean) | `0af3b9d26d65e527aa42364a668bb7bf7f0cef875716ccf6143afc2194b18eed` | `Theorems 64-75` (`269` lines: Burgess moment balance `h = 1/(2r)`, SOS trap `(r-2)^2/(16 r^2)`, Petrow-Young `1/6` cubic saving, Selberg `1/4` gap, Kim-Sarnak `GL_5` `7/64` & `5/832` saving, `20/20` mutations caught) |
| [`proofs/verify_symbolic_classical_riemann.py`](../proofs/verify_symbolic_classical_riemann.py) | `2126c51dd29f929d792e08d235efe371741f32f4b23e61108b64305f726ebddf` | Deterministic symbolic & numerical entrypoint (`503` lines: SymPy/NumPy verification across Papers 1-5, `15` `oai_ref/` upstream file checks, exact byte reproduction of `symbolic_verification_result.json`) |
| [`proofs/symbolic_siegel_conrey_burgess.py`](../proofs/symbolic_siegel_conrey_burgess.py) | `0fc01ccd985065d164d2dd0d9d24d684b894d9e2a8f10ad55e43287f02148c28` | Symbolic & quadrature helper module (`149` lines: Estermann-Siegel identities, `80`-point Gauss-Legendre symmetric degree-`17` Conrey optimization, `p <= 1999` Kloosterman `98.01%` cancellation) |
| [`proofs/symbolic_verification_result.json`](../proofs/symbolic_verification_result.json) | `6314872da8f8f84b4ae3c240ed0e9d625a4943181e737270136641a52eefc326` | Deterministic verification ledger (`196` lines: exact symbolic/numerical invariants for Papers 1-5 and `oai_ref/` combined digest) |
| [`proofs/problem_spec.md`](../proofs/problem_spec.md) | `89a5ebbf0e9e9b4e238a18e25bc729c71ecff31c28a975a37ce37be89451b64a` | Clean-room problem specification, exclusion boundaries, anchor checks, and five-pillar scope (`23` lines) |

---

## 2. Deterministic One-Click Verification Commands

```bash
# 1. Verify cryptographic SHA-256 checksums
sha256sum -c proofs/checksums.sha256

# 2. Compile all 6 Lean 4 modules (v4.29.0-rc8, 0 sorry, 2,238 lines, 75 theorems)
~/.elan/bin/lean proofs/classical_dlvp_korobov_and_zero_free.lean
~/.elan/bin/lean proofs/classical_ingham_huxley_zero_density.lean
~/.elan/bin/lean proofs/classical_guth_maynard_and_qrh_gram.lean
~/.elan/bin/lean proofs/classical_siegel_zero_and_ineffectiveness.lean
~/.elan/bin/lean proofs/classical_levinson_conrey_and_mollifier_barrier.lean
~/.elan/bin/lean proofs/classical_burgess_and_kim_sarnak_barrier.lean

# 3. Verify byte-identical symbolic & numerical reproduction
python3 -B proofs/verify_symbolic_classical_riemann.py

# 4. Run full repository gate (188/188 mutations killed + MetaM AST + 15/15 oai_ref coverage)
python3 -B ../../tools/verify_all.py --root .
```
