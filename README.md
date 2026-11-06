# `ultari-proof-anatomy`: Dissecting Human & AI Mathematical Proofs

> **Language**: **English** | [**한국어 (`README.ko.md`)**](./README.ko.md)

[![Lean 4](https://img.shields.io/badge/Lean_4-v4.29.0--rc8_Verified-blue)](#one-command-repository-verification)
[![Theorems & Mutants](https://img.shields.io/badge/Verified_Archive-376_Theorems_%7C_2%2C122%2F2%2C122_Mutants_Killed-purple)](#dissected-papers--formal-proof-archive)
[![Symbolic Solver](https://img.shields.io/badge/SymPy-Exact_Rational_%26_Radical-success)](#one-command-repository-verification)
[![Zero Sorry](https://img.shields.io/badge/Proof_Integrity-0_sorry_%7C_0_axiom-brightgreen)](#one-command-repository-verification)
[![License](https://img.shields.io/badge/License-Apache_2.0_%7C_CC_BY_4.0-orange.svg)](./LICENSE)

In Korean, **울타리 (*Ultari*)** means a **protective boundary or enclosure**.

**`ultari-proof-anatomy`** is an open research archive that dissects mathematical and scientific papers (authored by human researchers or frontier AI systems) and their Lean 4 formalizations into **exact closed-form invariants**, **standalone machine-checked Lean 4 theorems (`0 sorry`)**, and **4-tier reader guides** (from plain-language intuition to automated JSON manifests).

> **Archive Scale (`001`–`009`)**: **9 Case Studies** · **376 Standalone Lean 4 Theorems** (`0 sorry`, `0 axiom`) · **2,122 / 2,122 Hypothesis Mutations Killed (`100%`)** · **22,247 Upstream `.lean` Files Audited**.

---

## Core Mission: What This Repository Does

1. **Reverse-Engineering Hardcoded Constants & Proof Margins**:
   - Large-scale formalizations often replace exact algebraic roots with hardcoded rational proxies or coarse upper bounds (`gcongr`, `linarith`) to close proof obligations quickly.
   - We trace these proofs line by line to recover the underlying **exact equations** and measure the **slack left inside the bounds**.
2. **Drawing a Strict Boundary (`Ultari`) Between Proved & Open**:
   - Every claim in this archive is backed by standalone, zero-`sorry` **Lean 4** theorems and reproducible **SymPy** scripts.
   - Each case explicitly separates **what the formalization actually proves** from **what remains open or relies on simplified model assumptions**.
3. **4-Tier Guides for Every Reader**:
   - Every case directory provides four self-contained guides in both English (`en/`) and Korean (`ko/`):
     - **Tier 1 (`01_Beginner`)**: Plain-language overview of the problem and findings without heavy formulas.
     - **Tier 2 (`02_Intermediate`)**: Core equations and a 1-to-1 Lean theorem & line-number index.
     - **Tier 3 (`03_Expert`)**: Full technical referee report, cross-verification tables, and scope boundaries.
     - **Tier 4 (`04_Automated` & `manifest.json`)**: 1-line verification commands and SHA-256 artifact checksums.

---

## Dissected Papers & Formal Proof Archive

Click any **Case ID** for the full case overview, or jump directly to the **Tier 1 Beginner Guide** in the right-most column.

| Case ID | Target Paper & Upstream Scale | Key Findings at a Glance | Verified Proofs (`0 sorry`) | 4-Tier Guides (`en` / `ko`) |
| :---: | :--- | :--- | :--- | :---: |
| **[`001`](./anatomy/001-openai-003-qrh/README.md)** | **OpenAI `#003`: Quasi-Riemann Hypothesis ($\text{Re}(s) > 7/8$)**<br>`openai/math` family `003`<br>(`3,414` `.lean` files in `DirichletL/` & `SiegelZeros/`) | • **Exact Stationary Point**: Recovers the quadratic root $a^* = \frac{323}{276} - \frac{35\sqrt{16354}}{9384} \approx 0.6933$ behind the rational proxy $\frac{283}{408}$ in `Endpoint.lean`, plus floor root $a_{\max} = \frac{37}{72}$.<br>• **Exponent Margins**: Quantifies the additive gap between componentwise ($\frac{14+17\delta}{96}$, gap $\frac{215}{3264}$), bilinear ($\frac{1}{16}+\frac{17\delta}{96}$, gap $\frac{487}{3264}$), and bundled ($\frac{3}{16}+\frac{23\delta}{96}$) Gram bounds.<br>• **Tail & Threshold Slack**: Shows 6 of 8 non-principal Gauss branches vanish for $m \ge 2$ ($z_{\text{re}} \ge \frac{1}{6} \to \frac{1}{12}$) and `(1 - V)` cancellation lowers $Q \ge 480 \to 112$. | **40 Theorems** (`22/22` mutants)<br>[`qrh_exponent_and_parameter_bounds.lean`](./anatomy/001-openai-003-qrh/proofs/qrh_exponent_and_parameter_bounds.lean)<br>[`qrh_continuation_and_rescaling.lean`](./anatomy/001-openai-003-qrh/proofs/qrh_continuation_and_rescaling.lean)<br>[`verify_symbolic_qrh.py`](./anatomy/001-openai-003-qrh/proofs/verify_symbolic_qrh.py) | [**English (`en/`)**](./anatomy/001-openai-003-qrh/en/README.md)<br>[**한국어 (`ko/`)**](./anatomy/001-openai-003-qrh/ko/README.md) |
| **[`002`](./anatomy/002-openai-032-k3-hodge/README.md)** | **OpenAI `#032`: Retracted K3 Hodge Conjecture & `[EEMS13]` Forensics**<br>`openai/math` commit `adc7f12`<br>(`3,064` `.lean` files + `9` preprints) | • **Symplectic Double-Bind**: Shows why the reverse trace $G_2$ ($I_{\mathrm{new}} = -2m \neq 0$) and forward trace $G_1$ (degree-$(2,2k-2)$ curvature obstruction) cannot simultaneously close.<br>• **`[EEMS13]` Sign Discrepancy**: Locates an omitted odd-dimensional boundary Poincaré-Hopf sign $(-1)^{\dim U} = -1$ on $D^{2k-1}$ in `min-intersectYETI-final.tex:410, 694`.<br>• **Part I Rescue vs. Part II No-Go**: Verifies the intact `Part I` conditional reduction (`4-7-10` degree split) while proving algebraic rank/dimension obstructions across 7 `Part II` repair paths. | **27 Theorems** (`112/112` mutants)<br>[`k3_forensic_paths.lean`](./anatomy/002-openai-032-k3-hodge/proofs/k3_forensic_paths.lean)<br>[`verify_symbolic_k3.py`](./anatomy/002-openai-032-k3-hodge/proofs/verify_symbolic_k3.py) | [**English (`en/`)**](./anatomy/002-openai-032-k3-hodge/en/README.md)<br>[**한국어 (`ko/`)**](./anatomy/002-openai-032-k3-hodge/ko/README.md) |
| **[`003`](./anatomy/003-openai-001-milne-rationality/README.md)** | **OpenAI `#001`: Milne's Rationality Conjecture for Abelian Varieties**<br>Oct 7 preprint release<br>(`6` `.tex` manuscript files) | • **Retracted-Paper Isolation**: Confirms that the retracted `[OAI26]` (`#032`) citation appears only in the introduction and is never used in the internal proof chain (`§2–§6`).<br>• **Pointwise `KZ25` Repair**: Replaces the unpublished `GLX26` family assumption in `Proposition 4.8` with pointwise Kisin-Zhou (`KZ25`) integral lifts and parallel transport.<br>• **Canonical Beauville Projector**: Replaces the non-unique Section 6 lift with the canonical weight-0 Beauville projector $P_{r,0}$ and tightens 3 DVR/Kronecker/Rosati bounds. | **33 Theorems** (`211/211` mutants)<br>[`milne_transport_and_filtration.lean`](./anatomy/003-openai-001-milne-rationality/proofs/milne_transport_and_filtration.lean)<br>[`milne_weil_reduction_and_repairs.lean`](./anatomy/003-openai-001-milne-rationality/proofs/milne_weil_reduction_and_repairs.lean)<br>[`verify_symbolic_milne.py`](./anatomy/003-openai-001-milne-rationality/proofs/verify_symbolic_milne.py) | [**English (`en/`)**](./anatomy/003-openai-001-milne-rationality/en/01_Beginner_Guide.md)<br>[**한국어 (`ko/`)**](./anatomy/003-openai-001-milne-rationality/ko/01_초보자용_쉬운해설.md) |
| **[`004`](./anatomy/004-openai-378-eth-disproof/README.md)** | **OpenAI `#378`: Disproof of the Exponential Time Hypothesis (`ETH`)**<br>`OAI.Algorithms.SubexponentialSAT`<br>(`3,977` `.lean` files, `710,320` lines + `4` `.tex` files) | • **4-Generation Fossil Archaeology**: Maps `2,569` active files vs. `1,408` discarded `.lean` files (`35.4%`), tracing how the proof evolved from $2^{0.9n}$ (`Gen 1`) to char-3 Galois ring $\mathrm{GR}(3^t, d)$ pullback (`Gen 3–4`).<br>• **5 Specification Shortcuts Audited**: Documents `languageScanner` truth-table embedding, `sparsifySchedule = 0` ($n \le 2^{65,535}$) asymptotic cutoff, unary padding, space-cap fallback, and the char-3 (`Lean`) vs. char-0 (`LaTeX`) split.<br>• **Appendix D & Fossil Hybrids**: Formalizes the $2$-adic Hermite decay ($1/32$) in Appendix D and combines discarded `Gen 2–3` fossils to compress the polynomial ceiling by $171,835\times$. | **50 Theorems** (`408/408` mutants)<br>[`eth_subexp_interpolation_and_hashes.lean`](./anatomy/004-openai-378-eth-disproof/proofs/eth_subexp_interpolation_and_hashes.lean)<br>[`eth_tensor_contraction_and_circuits.lean`](./anatomy/004-openai-378-eth-disproof/proofs/eth_tensor_contraction_and_circuits.lean)<br>[`eth_five_repairs_and_four_layer_verdict.lean`](./anatomy/004-openai-378-eth-disproof/proofs/eth_five_repairs_and_four_layer_verdict.lean)<br>[`verify_symbolic_eth.py`](./anatomy/004-openai-378-eth-disproof/proofs/verify_symbolic_eth.py) | [**English (`en/`)**](./anatomy/004-openai-378-eth-disproof/en/01_Beginner_Guide.md)<br>[**한국어 (`ko/`)**](./anatomy/004-openai-378-eth-disproof/ko/01_초보자용_쉬운해설.md) |
| **[`005`](./anatomy/005-openai-003-qrh-mathematician-referee-audit/README.md)** | **OpenAI `#003`: Referee Deep Audit & $\beta \to 1/2$ Transfer Blueprint**<br>`openai/math` family `003` full DAG<br>(`3,233` `.lean` files audited + `26` reference modules) | • **3 Distinct $\beta$ Metrics Separated**: Distinguishes the global SOS saddle ($\frac{41999}{48000} < \frac{7}{8}$), the local $\delta=0$ equilibrium ($\frac{131}{150} \approx 0.8733$), and the non-exceptional background floor ($\frac{4103}{4896} \approx 0.8380$).<br>• **Breaking the $\beta = 2/3$ Wall**: Uses Stickelberger-Eisenstein annihilation ($k_\infty = -6 \neq 0$) to lower the `coordR` pole barrier from $\beta = \frac{2}{3}$ to $\frac{7}{12}$ and $\frac{1}{2}$.<br>• **Master Transfer Laws to $\beta = 1/2$**: Derives exact linear laws $\beta(\Delta_{\mathrm{gram}})$ and the hybrid saving threshold $\Delta_{\mathrm{hybrid}} = \frac{14}{33}$ required to reach the critical line $\beta = \frac{1}{2}$. | **48 Theorems + 3 `def`s** (`441/441` mutants)<br>[`qrh_mathematician_referee_audit.lean`](./anatomy/005-openai-003-qrh-mathematician-referee-audit/proofs/qrh_mathematician_referee_audit.lean)<br>[`qrh_eight_tasks_critical_upgrade.lean`](./anatomy/005-openai-003-qrh-mathematician-referee-audit/proofs/qrh_eight_tasks_critical_upgrade.lean)<br>[`verify_qrh_mathematician_audit.py`](./anatomy/005-openai-003-qrh-mathematician-referee-audit/proofs/verify_qrh_mathematician_audit.py) | [**English (`en/`)**](./anatomy/005-openai-003-qrh-mathematician-referee-audit/en/README.md)<br>[**한국어 (`ko/`)**](./anatomy/005-openai-003-qrh-mathematician-referee-audit/ko/README.md) |
| **[`006`](./anatomy/006-openai-376-navier-stokes/README.md)** | **OpenAI `#376`: Universal Computation in Forced Navier–Stokes Flows**<br>`openai/math` family `376`<br>(`1,010` `.lean` files, `142,131` lines + `75` `.tex` files) | • **Core PDE Constructions Checked**: Verifies the affine curl potential $U = \nabla\times(\chi\Psi)$ (`BoxTransport/Flow.lean`), $L^2$ Grönwall energy uniqueness (`Comparison.lean`), and 2+1D passive-scalar mild transport (`MildScalar.lean`).<br>• **Model Scope Boundary**: Separates the zero-pressure manufactured-forcing identity $f = f_0 + \nu f_1$ (`BoxCoding.lean`) and unidirectional shear sheets (`advection = 0`) from autonomous 3D unforced flows.<br>• **Import Graph Stratigraphy**: Shows the 6 challenge entrypoints import `354` of `1,004` `OAI/` modules, leaving `650` files (`64.7%`, including `ForcedComputation/`) unimported, plus a duplicate challenge file and an unused `ComputableReal ν` hypothesis. | **40 Theorems** (`163/163` mutants)<br>[`ns376_kinematic_routing_and_forensics.lean`](./anatomy/006-openai-376-navier-stokes/proofs/ns376_kinematic_routing_and_forensics.lean)<br>[`ns376_gronwall_uniqueness_and_repairs.lean`](./anatomy/006-openai-376-navier-stokes/proofs/ns376_gronwall_uniqueness_and_repairs.lean)<br>[`verify_symbolic_ns376.py`](./anatomy/006-openai-376-navier-stokes/proofs/verify_symbolic_ns376.py) | [**English (`en/`)**](./anatomy/006-openai-376-navier-stokes/en/01_Beginner_Guide.md)<br>[**한국어 (`ko/`)**](./anatomy/006-openai-376-navier-stokes/ko/01_초보자용_쉬운해설.md) |
| **[`007`](./anatomy/007-openai-376-navier-stokes-complete-reassembly/README.md)** | **OpenAI `#376`: Reassembly of the `650` Unimported Modules & Oct 6 Bounds**<br>`1,004` `OAI/` `.lean` files + Oct 6 preprint revision | • **Full `1,004`-File Reassembly**: Reconnects the `650` (`718`) unimported modules via `ForcedComputation/Main.lean` (`770` files), `Material/MaterialFlow.lean` (`19` files), and `StationaryNS` (`3` files), resolving the `lean/docs/376.md` path mismatch.<br>• **Non-Zero Pressure & Green's Bound (`4.53e7x`)**: Verifies genuine pressure $p = -\phi \neq 0$ and $\operatorname{div} f_{\text{sol}} = 0$ in `PeriodicLattice/Solenoidal.lean`, tightening the screened Green's norm in `PeriodicInverse.lean` from $\approx 286,753$ to $\frac{1}{16\pi^2} \approx 0.00633$.<br>• **Leray, Detector & Cantor Bounds**: Tightens the $\mathbb{T}^3$ Leray constant from `52` to $16.5321$ ($3.15\times$), expands the detector horizon $H_{\max}$ by $7,560\times$ ($10^9 \to 7.56\times 10^{12}$), and proves a $b\times$ Cantor gap ($\frac{1}{b-1}$) for even bases. | **48 Theorems** (`134/134` mutants)<br>[`ns376_unimported_solenoidal_and_leray_bounds.lean`](./anatomy/007-openai-376-navier-stokes-complete-reassembly/proofs/ns376_unimported_solenoidal_and_leray_bounds.lean)<br>[`ns376_detector_margins_and_undecidability_chains.lean`](./anatomy/007-openai-376-navier-stokes-complete-reassembly/proofs/ns376_detector_margins_and_undecidability_chains.lean)<br>[`verify_symbolic_ns376_complete.py`](./anatomy/007-openai-376-navier-stokes-complete-reassembly/proofs/verify_symbolic_ns376_complete.py) | [**English (`en/`)**](./anatomy/007-openai-376-navier-stokes-complete-reassembly/en/01_high_school_intuition_guide.md)<br>[**한국어 (`ko/`)**](./anatomy/007-openai-376-navier-stokes-complete-reassembly/ko/01_고등학생_직관가이드.md) |
| **[`008`](./anatomy/008-openai-003-qrh-11-12-and-cubic-sieve-synthesis/README.md)** | **OpenAI `#003`: `23/24` vs. `11/12` Scaling, Unimported `CubicGauss` & Trilogy Synthesis**<br>`DirichletL/`, `CubicGauss/` (`30` files), `paper2.tex`, `quasi-rh` & `arXiv:2610.12234` | • **Why `ShortDraft` Stops at `23/24` vs. `11/12`**: Traces how `reserve = 1/20` (`ClosedRecursion.lean:120`) locks $\vartheta = 1/10 \implies \frac{23}{24}$, while `CanonicalDescentScale` and $(\vartheta,\eta)=(\frac{6\varepsilon}{5},\frac{\varepsilon}{2})$ unlock $\frac{11}{12}+\varepsilon$ (`cauchy_const = 768`).<br>• **Unimported `CubicGauss` (`6,252` Lines) & All-$n$ Inductive Solution**: Audits the unimported 30-file sharp $2/3$ cubic large sieve and proves by `Nat` induction (`induction n`) that `sieveStep(α) = (6α-4)/(3α-1)` has exact closed form $\frac{4\cdot 3^n-2^{n+1}}{3\cdot 3^n-2^{n+1}}$.<br>• **$\mathbb{Z}[\sqrt{921}]$ Ring & `001`–`005`–`008` Trilogy Bridge**: Proves `Case 001`'s margin $\frac{215}{3264}$ scales by $\frac{2}{3}$ to $\frac{7}{8}-\frac{4069}{4896}=\frac{215}{4896}$, and $\alpha^*=\frac{4}{3}$ (`CubicGauss`) is dual to $\beta_{\mathrm{pole}}=\frac{2}{3}$ (`Case 005`). | **45 Theorems + 7 `def`s** (`344/344` mutants)<br>[`qrh_eleven_twelfths_and_cubic_large_sieve.lean`](./anatomy/008-openai-003-qrh-11-12-and-cubic-sieve-synthesis/proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean)<br>[`qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean`](./anatomy/008-openai-003-qrh-11-12-and-cubic-sieve-synthesis/proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean)<br>[`qrh_trilogy_induction_and_algebraic_bridge.lean`](./anatomy/008-openai-003-qrh-11-12-and-cubic-sieve-synthesis/proofs/qrh_trilogy_induction_and_algebraic_bridge.lean)<br>[`verify_symbolic_qrh_synthesis.py`](./anatomy/008-openai-003-qrh-11-12-and-cubic-sieve-synthesis/proofs/verify_symbolic_qrh_synthesis.py) | [**English (`en/`)**](./anatomy/008-openai-003-qrh-11-12-and-cubic-sieve-synthesis/en/01_Beginner_Guide.md)<br>[**한국어 (`ko/`)**](./anatomy/008-openai-003-qrh-11-12-and-cubic-sieve-synthesis/ko/01_Beginner_Guide.md) |
| **[`009`](./anatomy/009-openai-013-ostmann-inverse-goldbach/README.md)** | **OpenAI `#013`: Ostmann's Inverse Goldbach Conjecture (`Erdős #431`)**<br>`OAI/NumberTheory/Ostmann/` (`7,716` `.lean` files, `609,199` lines + `9` `.tex` sections) | • **Twin-Engine `7,716`-File Duplication & 3-Generation Fossil Tree**: Reveals why `Ostmann/` is the #1 largest directory in `openai/math`: two almost disjoint proof trees (`Complete.lean` cone: `3,165` files; `Main.lean` cone: `4,175` files) sharing only `5` elementary files (`372` lines, `0.065%`), plus `381` orphaned fossils (`3165 + 4175 - 5 + 381 = 7716`) spanning `Gen 1A` (`FinalExponentialContradiction.lean`) $\to$ `Gen 1B` $\to$ `Gen 2`.<br>• **Section 5 Fourier Supply Contraction (`-11/125`) & $+53\%$ Sharpening**: Verifies the unbalanced collision penalty $\frac{(2\sigma_p-1)^2}{\sigma_p(1-\sigma_p)} \ge \frac{1}{2}$, local contraction $1 - \frac{8}{5}\cdot\frac{17}{25} = -\frac{11}{125} < 0$, strict independence from `#003` (`QRH`), and unrounded $\kappa = \frac{33}{20}, \frac{17}{10}$ expanding favorable prime mass from $0.15L$ to $0.23L$.<br>• **All-$k$ Inductive Tree Budget & Deranged $t_1=0$ Breakthrough**: Proves by `induction k` that $\sum_{j=0}^{k-1} j 2^j = (k-2)2^k+2$ gives net rate $\frac{2}{5} - \frac{3}{4} = -\frac{7}{20} < 0$, and proves that deranged slot pairs ($t_1 = 0$) eliminate bad permutations completely ($\gamma = 1 - 2\theta - \delta_{\text{step}}: \frac{7}{20} \to \frac{19}{20} \to 1$, reducing $k_{\min}: 7041 \to 1040$). | **45 Theorems + 2 `def`s** (`287/287` mutants)<br>[`ostmann_twin_engines_and_supply_contraction.lean`](./anatomy/009-openai-013-ostmann-inverse-goldbach/proofs/ostmann_twin_engines_and_supply_contraction.lean)<br>[`ostmann_tree_transfers_and_permutation_contradiction.lean`](./anatomy/009-openai-013-ostmann-inverse-goldbach/proofs/ostmann_tree_transfers_and_permutation_contradiction.lean)<br>[`verify_symbolic_ostmann.py`](./anatomy/009-openai-013-ostmann-inverse-goldbach/proofs/verify_symbolic_ostmann.py) | [**English (`en/`)**](./anatomy/009-openai-013-ostmann-inverse-goldbach/en/01_Beginner_Guide.md)<br>[**한국어 (`ko/`)**](./anatomy/009-openai-013-ostmann-inverse-goldbach/ko/01_Beginner_Guide.md) |

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
│   └── verify_all.py          # 1-command deterministic verifier across all 9 cases (376 theorems)
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

Run [`tools/verify_all.py`](./tools/verify_all.py) from the repository root to execute:
1. **Lean 4 Kernel Compilation** (`lean` with zero `sorry`, zero custom `axiom`, `exit 0`),
2. **Symbolic Solver Reproduction** (`SymPy` exact rational & radical solver vs. locked JSON),
3. **SHA-256 Checksum Integrity** against every `manifest.json`,
4. **1-to-1 Theorem Name & `#L` Line-Number Verification** across all English and Korean markdown guides, and
5. **Dynamic Hypothesis-Removal Mutation Testing** (verifying that no theorem premise is vacuous).

```bash
python3 tools/verify_all.py
```

---

## License & Third-Party Attribution

- **Original Code & Formal Proofs** (`proofs/*.lean` excluding `oai_ref/`, `proofs/verify_*.py`, `tools/*.py`, `manifest.json`): Licensed under the [**Apache License, Version 2.0 (`Apache-2.0`)**](./LICENSE).
- **Original Mathematical Reports & 4-Tier Guides** (`*.md`): Dual-licensed under [**Apache-2.0**](./LICENSE) and [**Creative Commons Attribution 4.0 International (`CC BY 4.0`)**](https://creativecommons.org/licenses/by/4.0/). See [`NOTICE`](./NOTICE) for attribution and modification requirements.
- **Third-Party Reference Snapshots** (`anatomy/*/proofs/oai_ref/`): Included strictly for line-by-line academic refereeing and reproducible verification; subject to their upstream copyright and license terms (see [`NOTICE`](./NOTICE)).
