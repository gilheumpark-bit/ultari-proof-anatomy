# Case 008: OpenAI `#003` QRH Ecosystem Deep Synthesis (`23/24` vs. `11/12`, Unimported `CubicGauss` Large Sieve, and `ℚ(√921)` Farkas Unbundling)

This directory contains the cross-repository mathematical and formal synthesis of OpenAI's `#003` Quasi-Riemann Hypothesis (QRH) ecosystem (`DirichletL/ShortDraft`, `CubicGauss/`, `paper.tex` Part I, `paper2.tex`, `AlexKontorovich/quasi-rh`, Baiying Liu's `arXiv:2610.12234`, Xu–Sang's `arXiv:2610.15291`, and our `Case 005`).

## 4-Tier Documentation (English & Korean)

- **English (`en/`)**:
  - [01_Beginner_Guide.md](en/01_Beginner_Guide.md)
  - [02_Intermediate_Guide.md](en/02_Intermediate_Guide.md)
  - [03_Advanced_Guide.md](en/03_Advanced_Guide.md)
  - [04_Expert_Verification.md](en/04_Expert_Verification.md)
- **Korean (`ko/`)**:
  - [01_Beginner_Guide.md](ko/01_Beginner_Guide.md)
  - [02_Intermediate_Guide.md](ko/02_Intermediate_Guide.md)
  - [03_Advanced_Guide.md](ko/03_Advanced_Guide.md)
  - [04_Expert_Verification.md](ko/04_Expert_Verification.md)

## Formal Proofs & Verification Scripts (`proofs/`)

- [`qrh_eleven_twelfths_and_cubic_large_sieve.lean`](proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L1-L305): 15 theorems (`0 sorry`, `115/115` hypothesis mutations caught) covering Pillar 1 (`23/24` vs. `11/12`) and Pillar 2 (unimported 30-file `CubicGauss` Heath-Brown cubic large sieve).
- [`qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean`](proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L1-L313): 15 theorems (`0 sorry`, `125/125` hypothesis mutations caught) covering Pillar 3 ($\mathbb{Q}(\sqrt{921})$ unity across `Case 005` and Baiying Liu `arXiv:2610.12234`) and Pillar 4 (parametric Farkas unbundling & the 10-tier boundary hierarchy).
- [`verify_symbolic_qrh_synthesis.py`](proofs/verify_symbolic_qrh_synthesis.py): Deterministic SymPy verifier reproducing [`symbolic_verification_result.json`](proofs/symbolic_verification_result.json).
