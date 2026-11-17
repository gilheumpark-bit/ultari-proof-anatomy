# Tier 4 Automated Verification & Parser Spec: Cryptographic SHA-256 Integrity and Reproducibility Protocol for the Five Classical Riemann Barriers (Theorems 1-75)

- Target Audience: Automated verification pipelines (tools/verify_all.py) and reproducibility auditors
- Parent Index: [Main English README (README.md)](../README.md) | [Executive Summary (en/01_)](01_Executive_Summary_and_General_Guide.md) | [Intermediate Guide (en/02_)](02_Intermediate_Math_and_Code_Guide.md) | [Expert Forensic Report (en/03_)](03_Expert_Forensic_and_Mathematical_Physics_Report.md)



## 1. Cryptographic SHA-256 Checksum Table (`proofs/`)

| Artifact Path (`proofs/...`) | SHA-256 Checksum | Role & Verification Gate |
| :--- | :--- | :--- |
| [proofs/classical_dlvp_korobov_and_zero_free.lean](../proofs/classical_dlvp_korobov_and_zero_free.lean) | `c4119be676231c12c65a2eb1eb85107fad279b711e7f3c4b47493c2ac960851b` | Theorems 1-15 (508 lines: pole-zero SOS identity, (3,4,1) 4-tier cascade, (17,24,8) square (41-4√102)/32, irreducible quintic, Fejer-Riesz c_1 < 2 c_0, degree-3 counterexample (65/16, 9/2, 0, -1) & ceiling (3-2√2)/3, 39/39 mutations caught) |
| [proofs/classical_ingham_huxley_zero_density.lean](../proofs/classical_ingham_huxley_zero_density.lean) | `696e7e58ce6b8a1fb11ca12a951b6ea5793eb5b50bcaf77736f1fea5d8b3426f` | Theorems 16-25 (400 lines: Ingham 3-term balance 3/(2-σ), Halasz-Schur phase loss ε n^2 > 0, Huxley reflection 3/(3σ-1), `σ* = 3/4` minimax peak 12/5, prime-gap 7/12, 28/28 mutations caught) |
| [proofs/classical_guth_maynard_and_qrh_gram.lean](../proofs/classical_guth_maynard_and_qrh_gram.lean) | `e771762ef219d2cb3e52558763f3628b7c906950dabc4b3effbc5ba9385c5b28` | Theorems 26-35 (380 lines: Guth-Maynard 15/(5σ+3) & SOS margin 250(σ-3/4)^2+3/8 > 0, 7/10 peak 30/13, universal-δ QRH unbundling 215/3264 & 487/3264, hybrid β = 1/2 14/33 & -17/132 deficit, 25/25 mutations caught) |
| [proofs/classical_siegel_zero_and_ineffectiveness.lean](../proofs/classical_siegel_zero_and_ineffectiveness.lean) | `cc2532a99f0a37270e097a11af89c74a9aafdd2014b1f3f92745d9c2332b9e1a` | Theorems 36-50 (372 lines: Estermann biquadratic {0, 4}, Perron optimal cutoff, Classical.em No-Go barrier, Landau-Page 5/46 repulsion, Goldfeld-Gross-Zagier rank-3 effectivity & Ostmann cutoff ladder, 47/47 mutations caught) |
| [proofs/classical_levinson_conrey_and_mollifier_barrier.lean](../proofs/classical_levinson_conrey_and_mollifier_barrier.lean) | `cf67a2648cc092df1a3f3d4c5689462aa0b0aeba23f03f5a1fd53f494e68f56d` | Theorems 51-63 (309 lines: mollifier ladder 1/2 < 17/33 < 35/66 < 4/7, HasDerivAt invariant $J_{AB} = -1/2$, Cauchy-Schwarz $1 \le 4 I_{AA} J_{BB}$, coth ω > 1 => κ(θ) < 1, Levinson κ > 1/3 certificate, 29/29 mutations caught) |
| [proofs/classical_burgess_and_kim_sarnak_barrier.lean](../proofs/classical_burgess_and_kim_sarnak_barrier.lean) | `213402efc6360d3eb78d3c32be42ae7037fa14ecd5a58a3007bfff54c97b3854` | Theorems 64-75 (269 lines: Burgess moment balance h = 1/(2r), SOS trap (r-2)^2/(16 r^2), Petrow-Young 1/6 cubic saving, Selberg 1/4 gap, Kim-Sarnak GL_5 7/64 & 5/832 saving, 20/20 mutations caught) |
| [proofs/verify_symbolic_classical_riemann.py](../proofs/verify_symbolic_classical_riemann.py) | `201563b296cc49b2f3b46775b44f2270d705b7febedffcc0412a3c79b099a9df` | Deterministic symbolic & numerical entrypoint (503 lines: SymPy/NumPy verification across Papers 1-5, 15 oai_ref/ upstream file checks, exact byte reproduction of symbolic_verification_result.json) |
| [proofs/symbolic_siegel_conrey_burgess.py](../proofs/symbolic_siegel_conrey_burgess.py) | `ae1a388193d630dcaf33115c1ca7ccb5dc85dc6eb759e8bb56957dc3887c060a` | Symbolic & quadrature helper module (149 lines: Estermann-Siegel identities, 80-point Gauss-Legendre symmetric degree-17 Conrey optimization, p <= 1999 Kloosterman 98.01% cancellation) |
| [proofs/symbolic_verification_result.json](../proofs/symbolic_verification_result.json) | `6314872da8f8f84b4ae3c240ed0e9d625a4943181e737270136641a52eefc326` | Deterministic verification ledger (196 lines: exact symbolic/numerical invariants for Papers 1-5 and oai_ref/ combined digest) |
| [proofs/problem_spec.md](../proofs/problem_spec.md) | `79a27abe73a3f9290f843022755482a70d66defe5f74a4a9d811c92dc782f30c` | Clean-room problem specification, exclusion boundaries, anchor checks, and five-pillar scope (23 lines) |



## 2. Deterministic One-Click Verification Commands

```bash
# 1. Verify cryptographic SHA-256 checksums
sha256sum -c proofs/checksums.sha256

# 2. Compile all 6 Lean 4 modules (v4.35.0, 0 sorry, 2,238 lines, 75 theorems)
lean proofs/classical_dlvp_korobov_and_zero_free.lean
lean proofs/classical_ingham_huxley_zero_density.lean
lean proofs/classical_guth_maynard_and_qrh_gram.lean
lean proofs/classical_siegel_zero_and_ineffectiveness.lean
lean proofs/classical_levinson_conrey_and_mollifier_barrier.lean
lean proofs/classical_burgess_and_kim_sarnak_barrier.lean

# 3. Verify byte-identical symbolic & numerical reproduction
python3 -B proofs/verify_symbolic_classical_riemann.py

# 4. Run full repository gate (188/188 mutations killed + MetaM AST + 15/15 oai_ref coverage)
python3 -B ../../tools/verify_all.py --root .
```
