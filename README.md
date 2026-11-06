# `ultari-proof-anatomy`: Dissecting Human & AI Mathematical Proofs

> **Language**: **English** | [**한국어 (`README.ko.md`)**](./README.ko.md)

[![Lean 4](https://img.shields.io/badge/Lean_4-v4.29.0--rc8_Verified-blue)](#one-command-repository-verification)
[![Theorems & Mutants](https://img.shields.io/badge/Verified_Archive-436_Theorems_%7C_2%2C337%2F2%2C337_Mutants_Killed-purple)](#dissected-papers--formal-proof-archive)
[![Symbolic Solver](https://img.shields.io/badge/SymPy-Exact_Rational_%26_Radical-success)](#one-command-repository-verification)
[![Zero Sorry](https://img.shields.io/badge/Proof_Integrity-0_sorry_%7C_0_axiom-brightgreen)](#one-command-repository-verification)
[![License](https://img.shields.io/badge/License-Apache_2.0_%7C_CC_BY_4.0-orange.svg)](./LICENSE)

In Korean, **울타리 (*Ultari*)** means a **protective boundary or enclosure**.

**`ultari-proof-anatomy`** breaks down math and science papers and their Lean 4 code into **exact closed-form roots**, **standalone zero-`sorry` Lean 4 theorems**, and **4-tier reader guides**.

> **Archive Scale (`001`–`009`)**: **9 Case Studies** · **436 Standalone Lean 4 Theorems** (`0 sorry`, `0 axiom`) · **2,337 / 2,337 Hypothesis Mutations Killed (`100%`)** · **22,247 Upstream `.lean` Files Audited**.

---

## Core Mission: What This Repository Does

1. **Reverse-Engineering Hardcoded Constants & Proof Margins**:
   - Large formal proofs often replace exact roots with rational proxies or loose upper bounds (`gcongr`, `linarith`) to close goals quickly.
   - We trace these proofs line by line to recover the exact equations and measure the unused slack inside the bounds.
2. **Drawing a Strict Boundary (`Ultari`) Between Proved & Open**:
   - Every claim in this archive is backed by standalone, zero-`sorry` **Lean 4** theorems and **SymPy** scripts.
   - Each case separates what the code actually proves from what remains open or relies on simplified model assumptions.
3. **4-Tier Guides for Every Reader**:
   - Every case folder provides four guides in both English (`en/`) and Korean (`ko/`).
   - **Tier 1 (`01_Beginner`)**: Plain-language overview of the problem and findings without heavy formulas.
   - **Tier 2 (`02_Intermediate`)**: Core equations and a 1-to-1 Lean theorem & line-number index.
   - **Tier 3 (`03_Expert`)**: Full referee report, cross-check tables, and scope boundaries.
   - **Tier 4 (`04_Automated` & `manifest.json`)**: 1-line check commands and SHA-256 checksums.

---

## Dissected Papers & Formal Proof Archive

Click any **Case ID** for the case overview, or open the **Tier 1 Beginner Guide** in the right-most column.

| Case ID | Target Paper & Upstream Scale | Key Findings at a Glance | Verified Proofs (`0 sorry`) | 4-Tier Guides (`en` / `ko`) |
| :---: | :--- | :--- | :--- | :---: |
| **[`001`](./anatomy/001-openai-003-qrh/README.md)** | **OpenAI `#003`: Quasi-Riemann Hypothesis ($\text{Re}(s) > 7/8$)**<br>`openai/math` family `003` (`3,414` `.lean` files) | • **Stationary Point**: Recovers exact root $a^* = \frac{323}{276} - \frac{35\sqrt{16354}}{9384} \approx 0.6933$ behind proxy $\frac{283}{408}$ and floor root $a_{\max} = \frac{37}{72}$.<br>• **Gram Slack**: Measures the additive gap ($\frac{215}{3264}$ and $\frac{487}{3264}$) lost by bundling three Gram matrix energy terms.<br>• **Tail Vanishing**: Shows 6 of 8 Gauss branches vanish for $m \ge 2$ and `(1 - V)` cancellation lowers $Q \ge 480 \to 112$. | **48 Theorems** (`28/28` mutants)<br>[`qrh_exponent_and_parameter_bounds.lean`](./anatomy/001-openai-003-qrh/proofs/qrh_exponent_and_parameter_bounds.lean)<br>[`qrh_continuation_and_rescaling.lean`](./anatomy/001-openai-003-qrh/proofs/qrh_continuation_and_rescaling.lean)<br>[`verify_symbolic_qrh.py`](./anatomy/001-openai-003-qrh/proofs/verify_symbolic_qrh.py) | [**English (`en/`)**](./anatomy/001-openai-003-qrh/en/README.md)<br>[**한국어 (`ko/`)**](./anatomy/001-openai-003-qrh/ko/README.md) |
| **[`002`](./anatomy/002-openai-032-k3-hodge/README.md)** | **OpenAI `#032`: Retracted K3 Hodge Conjecture**<br>Commit `adc7f12` (`3,064` `.lean` files + `9` preprints) | • **Symplectic Double-Bind**: Proves why reverse trace $G_2$ ($-2m \neq 0$) and forward trace $G_1$ (degree-$2$ curvature blow-up) both fail.<br>• **`[EEMS13]` Sign Error**: Pinpoints an omitted odd-dimensional boundary sign $(-1)^{\dim U} = -1$ in `min-intersectYETI-final.tex:410, 694`.<br>• **Part I Rescue**: Verifies the intact `Part I` Clifford reduction while proving rank/dimension blocks across 7 `Part II` repair paths. | **35 Theorems** (`135/135` mutants)<br>[`k3_forensic_paths.lean`](./anatomy/002-openai-032-k3-hodge/proofs/k3_forensic_paths.lean)<br>[`verify_symbolic_k3.py`](./anatomy/002-openai-032-k3-hodge/proofs/verify_symbolic_k3.py) | [**English (`en/`)**](./anatomy/002-openai-032-k3-hodge/en/README.md)<br>[**한국어 (`ko/`)**](./anatomy/002-openai-032-k3-hodge/ko/README.md) |
| **[`003`](./anatomy/003-openai-001-milne-rationality/README.md)** | **OpenAI `#001`: Milne's Rationality Conjecture**<br>Oct 7 preprint (`6` `.tex` files) | • **Retracted-Paper Independence**: Confirms retracted `[OAI26]` (`#032`) is cited only in the intro and never used in the proof chain (`§2–§6`).<br>• **Pointwise `KZ25` Lift**: Replaces the unpublished `GLX26` family assumption in `Proposition 4.8` with pointwise Kisin-Zhou integral lifts.<br>• **Canonical Projector**: Normalizes the Section 6 cycle lift via Beauville's projector $P_{r,0}$ and tightens 3 DVR/Kronecker/Rosati bounds. | **36 Theorems** (`232/232` mutants)<br>[`milne_transport_and_filtration.lean`](./anatomy/003-openai-001-milne-rationality/proofs/milne_transport_and_filtration.lean)<br>[`milne_weil_reduction_and_repairs.lean`](./anatomy/003-openai-001-milne-rationality/proofs/milne_weil_reduction_and_repairs.lean)<br>[`verify_symbolic_milne.py`](./anatomy/003-openai-001-milne-rationality/proofs/verify_symbolic_milne.py) | [**English (`en/`)**](./anatomy/003-openai-001-milne-rationality/en/01_Beginner_Guide.md)<br>[**한국어 (`ko/`)**](./anatomy/003-openai-001-milne-rationality/ko/01_초보자용_쉬운해설.md) |
| **[`004`](./anatomy/004-openai-378-eth-disproof/README.md)** | **OpenAI `#378`: Disproof of the ETH**<br>`SubexponentialSAT` (`3,977` `.lean` files, `710,320` lines) | • **Fossil Stratigraphy**: Separates `2,569` active files from `1,408` discarded `.lean` fossils (`35.4%`) across 4 model generations.<br>• **5 Shortcut Audits**: Audits DFA truth-table embedding, `sparsifySchedule = 0` ($n \le 2^{65,535}$) cutoff, unary padding, and the char-3/char-0 split.<br>• **Appendix D & Hybrids**: Formalizes Appendix D's $1/32$ Hermite decay and combines `Gen 2–3` fossils to cut the polynomial constant by $171,835\times$. | **56 Theorems** (`454/454` mutants)<br>[`eth_subexp_interpolation_and_hashes.lean`](./anatomy/004-openai-378-eth-disproof/proofs/eth_subexp_interpolation_and_hashes.lean)<br>[`eth_tensor_contraction_and_circuits.lean`](./anatomy/004-openai-378-eth-disproof/proofs/eth_tensor_contraction_and_circuits.lean)<br>[`eth_five_repairs_and_four_layer_verdict.lean`](./anatomy/004-openai-378-eth-disproof/proofs/eth_five_repairs_and_four_layer_verdict.lean)<br>[`verify_symbolic_eth.py`](./anatomy/004-openai-378-eth-disproof/proofs/verify_symbolic_eth.py) | [**English (`en/`)**](./anatomy/004-openai-378-eth-disproof/en/01_Beginner_Guide.md)<br>[**한국어 (`ko/`)**](./anatomy/004-openai-378-eth-disproof/ko/01_초보자용_쉬운해설.md) |
| **[`005`](./anatomy/005-openai-003-qrh-mathematician-referee-audit/README.md)** | **OpenAI `#003`: Referee Audit & $\beta \to 1/2$ Blueprint**<br>Family `003` DAG (`3,233` `.lean` files + `26` ref modules) | • **3 $\beta$ Regimes**: Separates the global SOS saddle ($\frac{41999}{48000} < \frac{7}{8}$), the $\delta=0$ slice ($\frac{131}{150}$), and the unbundled tail floor ($\frac{4103}{4896}$).<br>• **Breaking $\beta = 2/3$**: Uses Stickelberger annihilation ($k_\infty = -6 \neq 0$) to shift the `coordR` pole barrier from $\frac{2}{3}$ down to $\frac{7}{12}$ and $\frac{1}{2}$.<br>• **Conditional Transfer**: Derives linear transfer laws $\beta(\Delta_{\mathrm{gram}})$ and the required hybrid saving $\Delta_{\mathrm{hybrid}} = \frac{14}{33}$ for $\beta = \frac{1}{2}$. | **48 Theorems + 3 `def`s** (`441/441` mutants)<br>[`qrh_mathematician_referee_audit.lean`](./anatomy/005-openai-003-qrh-mathematician-referee-audit/proofs/qrh_mathematician_referee_audit.lean)<br>[`qrh_eight_tasks_critical_upgrade.lean`](./anatomy/005-openai-003-qrh-mathematician-referee-audit/proofs/qrh_eight_tasks_critical_upgrade.lean)<br>[`verify_qrh_mathematician_audit.py`](./anatomy/005-openai-003-qrh-mathematician-referee-audit/proofs/verify_qrh_mathematician_audit.py) | [**English (`en/`)**](./anatomy/005-openai-003-qrh-mathematician-referee-audit/en/README.md)<br>[**한국어 (`ko/`)**](./anatomy/005-openai-003-qrh-mathematician-referee-audit/ko/README.md) |
| **[`006`](./anatomy/006-openai-376-navier-stokes/README.md)** | **OpenAI `#376`: Forced Navier–Stokes Computation**<br>Family `376` (`1,010` `.lean` files + `75` `.tex` files) | • **Core PDE Proofs**: Verifies curl-potential box routing $U = \nabla\times(\chi\Psi)$, $L^2$ Grönwall uniqueness, and 2+1D Gaussian scalar detection.<br>• **Model Scope**: Distinguishes manufactured zero-pressure forcing $f = f_0 + \nu f_1$ and shear sheets (`advection = 0`) from unforced 3D flows.<br>• **Import Graph**: Shows the 6 challenges import `354` of `1,004` `OAI/` files, leaving `650` files (`64.7%`) unimported. | **45 Theorems** (`176/176` mutants)<br>[`ns376_kinematic_routing_and_forensics.lean`](./anatomy/006-openai-376-navier-stokes/proofs/ns376_kinematic_routing_and_forensics.lean)<br>[`ns376_gronwall_uniqueness_and_repairs.lean`](./anatomy/006-openai-376-navier-stokes/proofs/ns376_gronwall_uniqueness_and_repairs.lean)<br>[`verify_symbolic_ns376.py`](./anatomy/006-openai-376-navier-stokes/proofs/verify_symbolic_ns376.py) | [**English (`en/`)**](./anatomy/006-openai-376-navier-stokes/en/01_Beginner_Guide.md)<br>[**한국어 (`ko/`)**](./anatomy/006-openai-376-navier-stokes/ko/01_초보자용_쉬운해설.md) |
| **[`007`](./anatomy/007-openai-376-navier-stokes-complete-reassembly/README.md)** | **OpenAI `#376`: Reassembly of `650` Unimported Modules**<br>`1,004` `OAI/` `.lean` files + Oct 6 revision | • **Full Reassembly**: Reconnects all `650` (`718`) unimported modules via `ForcedComputation/Main.lean` (`770` files) and `MaterialFlow.lean`.<br>• **Solenoidal Forcing**: Verifies non-zero pressure $p = -\phi \neq 0$ (`Solenoidal.lean`) and tightens the Green's norm by $4.53\times 10^7\times$ to $\frac{1}{16\pi^2}$.<br>• **Sharp Bounds**: Tightens the $\mathbb{T}^3$ Leray constant (`52 -> 16.53`), detector horizon $H_{\max}$ ($7,560\times$), and Cantor gap ($b\times$). | **48 Theorems** (`134/134` mutants)<br>[`ns376_unimported_solenoidal_and_leray_bounds.lean`](./anatomy/007-openai-376-navier-stokes-complete-reassembly/proofs/ns376_unimported_solenoidal_and_leray_bounds.lean)<br>[`ns376_detector_margins_and_undecidability_chains.lean`](./anatomy/007-openai-376-navier-stokes-complete-reassembly/proofs/ns376_detector_margins_and_undecidability_chains.lean)<br>[`verify_symbolic_ns376_complete.py`](./anatomy/007-openai-376-navier-stokes-complete-reassembly/proofs/verify_symbolic_ns376_complete.py) | [**English (`en/`)**](./anatomy/007-openai-376-navier-stokes-complete-reassembly/en/01_high_school_intuition_guide.md)<br>[**한국어 (`ko/`)**](./anatomy/007-openai-376-navier-stokes-complete-reassembly/ko/01_고등학생_직관가이드.md) |
| **[`008`](./anatomy/008-openai-003-qrh-11-12-and-cubic-sieve-synthesis/README.md)** | **OpenAI `#003`: `23/24` vs. `11/12`, `CubicGauss` & Trilogy**<br>`DirichletL/`, `CubicGauss/` (`30` files) & `arXiv:2610.12234` | • **`23/24` vs. `11/12`**: Shows fixed `reserve = 1/20` locks `ShortDraft` at $\frac{23}{24}$, while `CanonicalDescentScale` unlocks $\frac{11}{12}+\varepsilon$.<br>• **Unimported `CubicGauss`**: Audits the 30-file sharp $2/3$ cubic sieve and proves the closed-form iteration $\frac{4\cdot 3^n-2^{n+1}}{3\cdot 3^n-2^{n+1}}$ by induction.<br>• **Trilogy Synthesis**: Unifies `Case 005` and Liu's $\mathbb{Q}(\sqrt{921})$ roots and links `Case 001`–`005`–`008` down to $\beta = \frac{71}{108} \approx 0.6574$. | **45 Theorems + 7 `def`s** (`344/344` mutants)<br>[`qrh_eleven_twelfths_and_cubic_large_sieve.lean`](./anatomy/008-openai-003-qrh-11-12-and-cubic-sieve-synthesis/proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean)<br>[`qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean`](./anatomy/008-openai-003-qrh-11-12-and-cubic-sieve-synthesis/proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean)<br>[`qrh_trilogy_induction_and_algebraic_bridge.lean`](./anatomy/008-openai-003-qrh-11-12-and-cubic-sieve-synthesis/proofs/qrh_trilogy_induction_and_algebraic_bridge.lean)<br>[`verify_symbolic_qrh_synthesis.py`](./anatomy/008-openai-003-qrh-11-12-and-cubic-sieve-synthesis/proofs/verify_symbolic_qrh_synthesis.py) | [**English (`en/`)**](./anatomy/008-openai-003-qrh-11-12-and-cubic-sieve-synthesis/en/01_Beginner_Guide.md)<br>[**한국어 (`ko/`)**](./anatomy/008-openai-003-qrh-11-12-and-cubic-sieve-synthesis/ko/01_Beginner_Guide.md) |
| **[`009`](./anatomy/009-openai-013-ostmann-inverse-goldbach/README.md)** | **OpenAI `#013`: Ostmann's Inverse Goldbach (`Erdős #431`)**<br>`Ostmann/` (`7,716` `.lean` files, `609,199` lines + `60` `oai_ref` files) | • **Twin-Engine Duplication**: Shows `Ostmann/` contains two almost disjoint proof trees (`3,165` + `4,175` files sharing `5` files) plus `381` fossils.<br>• **4 Core Algebraic Engines**: Proves the $-\frac{11}{125} < 0$ supply squeeze, squared-kernel slope $2t_0$, Vandermonde 3-way collision bound, and $2\times 2$ Cauchy determinant non-vanishing.<br>• **Tree & Effective Bounds**: Proves all-$k$ rate $\frac{2}{5} - \frac{3}{4} = -\frac{7}{20} < 0$, cuts depth $k_{\min}: 7041 \to 1040$, and makes `#013` effective ($L_{\mathrm{eff}}: 4,115,904 \to 640,722$). | **75 Theorems + 3 `def`s** (`393/393` mutants)<br>[`ostmann_twin_engines_and_supply_contraction.lean`](./anatomy/009-openai-013-ostmann-inverse-goldbach/proofs/ostmann_twin_engines_and_supply_contraction.lean)<br>[`ostmann_tree_transfers_and_permutation_contradiction.lean`](./anatomy/009-openai-013-ostmann-inverse-goldbach/proofs/ostmann_tree_transfers_and_permutation_contradiction.lean)<br>[`ostmann_algebraic_engines_and_cauchy_determinant.lean`](./anatomy/009-openai-013-ostmann-inverse-goldbach/proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean)<br>[`verify_symbolic_ostmann.py`](./anatomy/009-openai-013-ostmann-inverse-goldbach/proofs/verify_symbolic_ostmann.py) | [**English (`en/`)**](./anatomy/009-openai-013-ostmann-inverse-goldbach/en/01_Beginner_Guide.md)<br>[**한국어 (`ko/`)**](./anatomy/009-openai-013-ostmann-inverse-goldbach/ko/01_Beginner_Guide.md) |

---

## Repository Architecture

Each case under [`anatomy/`](./anatomy/) shares a **single `proofs/` directory** and a single [`manifest.json`](./anatomy/001-openai-003-qrh/manifest.json) between its English (`en/`) and Korean (`ko/`) guides, preventing hash drift between languages:

```text
ultari-proof-anatomy/
├── LICENSE                    # Apache License 2.0
├── NOTICE                     # Dual-license (Apache-2.0 / CC BY 4.0) & third-party attribution
├── README.md                  # Global English index
├── README.ko.md               # Global Korean index
├── tools/
│   └── verify_all.py          # 1-command deterministic verifier across all 9 cases (436 theorems)
└── anatomy/
    ├── 001-openai-003-qrh/
    │   ├── README.md          # Case English overview
    │   ├── README.ko.md       # Case Korean overview
    │   ├── manifest.json      # Single source-of-truth SHA-256 & theorem ledger
    │   ├── proofs/            # Single shared formal & symbolic proof suite
    │   │   ├── *.lean         # Standalone zero-sorry Lean 4 theorems
    │   │   ├── verify_*.py    # Deterministic SymPy / numerical verification script
    │   │   ├── symbolic_verification_result.json
    │   │   ├── problem_spec.md
    │   │   └── oai_ref/       # Reference .lean / .tex files from the target paper
    │   ├── en/                # 4-Tier English guides (01_Beginner .. 04_Automated)
    │   └── ko/                # 4-Tier Korean guides (01_초보자용 .. 04_자동검증용)
    ├── 002-openai-032-k3-hodge/
    ├── 003-openai-001-milne-rationality/
    ├── 004-openai-378-eth-disproof/
    ├── 005-openai-003-qrh-mathematician-referee-audit/
    ├── 006-openai-376-navier-stokes/
    ├── 007-openai-376-navier-stokes-complete-reassembly/
    ├── 008-openai-003-qrh-11-12-and-cubic-sieve-synthesis/
    └── 009-openai-013-ostmann-inverse-goldbach/
```

---

## One-Command Repository Verification

Run [`tools/verify_all.py`](./tools/verify_all.py) from the repo root to run all five checks:
1. **Lean 4 Kernel Check**: Compiles every `.lean` file with zero `sorry` and zero custom `axiom` (`exit 0`).
2. **Symbolic Solver Check**: Runs every `SymPy` script and checks for an exact match with the locked JSON output.
3. **SHA-256 Checksum Check**: Verifies all artifact hashes against each `manifest.json` and `04_*.md` table.
4. **1-to-1 Theorem Link Check**: Verifies every theorem name and `#L` line link across all English and Korean guides.
5. **Hypothesis Mutation Check**: Replaces each theorem premise with `True` one by one and confirms the Lean compiler rejects every mutant.

```bash
python3 tools/verify_all.py
```

---

## License & Third-Party Attribution

- **Original Code & Proofs** (`proofs/*.lean` excluding `oai_ref/`, `proofs/verify_*.py`, `tools/*.py`, `manifest.json`): Licensed under [**Apache-2.0**](./LICENSE).
- **Original Reports & 4-Tier Guides** (`*.md`): Dual-licensed under [**Apache-2.0**](./LICENSE) and [**CC BY 4.0**](https://creativecommons.org/licenses/by/4.0/). See [`NOTICE`](./NOTICE) for attribution details.
- **Reference Snapshots** (`anatomy/*/proofs/oai_ref/`): Included for line-by-line refereeing and verification; subject to their upstream license terms (see [`NOTICE`](./NOTICE)).
