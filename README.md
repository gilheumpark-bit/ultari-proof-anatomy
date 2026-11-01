# `ultari-proof-anatomy` — Dissecting Human & AI Mathematical Proofs

> **Language**: **English** | [**한국어 (`README.ko.md`)**](./README.ko.md)

[![Lean 4](https://img.shields.io/badge/Lean_4-v4.35.0_Verified-blue)](#one-command-repository-verification)
[![Symbolic Solver](https://img.shields.io/badge/SymPy-Exact_Rational_%26_Radical-success)](#one-command-repository-verification)
[![Zero Sorry](https://img.shields.io/badge/Proof_Integrity-0_sorry_%7C_0_axiom-brightgreen)](#one-command-repository-verification)

In Korean, **울타리 (*Ultari*)** means a **protective boundary or enclosure**.

**`ultari-proof-anatomy`** is an open research archive dedicated to dissecting landmark mathematical and scientific papers—whether authored by human researchers or frontier AI systems—into **exact closed-form algebraic invariants**, **standalone machine-checked Lean 4 theorems**, and **4-tier reader guides** (from general intuition to automated AI parsers).

---

## Core Mission: Why `ultari-proof-anatomy` Exists

1. **From Magic Numbers & Tactic Relaxations to Exact Invariants**:
   - Complex mathematical papers and large-scale automated formalizations frequently rely on hardcoded rational proxies and coarse upper-bound relaxations (`gcongr`, `linarith`) to close proof obligations quickly.
   - We reverse-engineer these proofs line by line to recover their **exact algebraic equations** (such as quadratic irrational stationary points and exact linear margin roots) and quantify the **internal margins left on the table**.
2. **Strict Epistemic Boundary (`Ultari`) Between Proved & Open**:
   - Every structural claim in this repository is backed by standalone, zero-`sorry` **Lean 4** kernel theorems and deterministic symbolic verification scripts (`SymPy`).
   - To prevent overclaiming, every case study draws an explicit boundary (`Ultari`) separating **Formalized Rational/Integer/Algebraic Theorems** from **Open Analytic/Operator Extensions**.
3. **4-Tier Knowledge Translation (Human to Machine)**:
   - Rather than locking results inside impenetrable specialist prose or raw `.lean` files, every dissected paper is organized into four self-contained layers:
     - **Tier 1 (`01_Beginner`)**: Intuition-first explanation without heavy formulas.
     - **Tier 2 (`02_Intermediate`)**: Core algebraic equations and a complete 1-to-1 theorem & line-number map.
     - **Tier 3 (`03_Expert`)**: Full technical report with cross-verification tables and formal scope boundaries.
     - **Tier 4 (`04_Automated` & `manifest.json`)**: Deterministic 1-line verification commands, SHA-256 artifact ledger, and machine-readable JSON manifest.

---

## Dissected Papers & Formal Proof Archive

| Case ID | Target Paper / Formalization | Author Type | Key Structural Findings & Recovered Invariants | Formal Artifacts (`0 sorry`) | Guides (`en` / `ko`) |
| :---: | :--- | :---: | :--- | :--- | :---: |
| **[`001`](./anatomy/001-openai-003-qrh/README.md)** | **OpenAI `#003`: The Quasi-Riemann Hypothesis ($\text{Re}(s) > 7/8$)**<br>(`FirstProof2026Problem3`, 3,414 `.lean` files) | Frontier AI<br>*(OpenAI)* | 1. **Floor Margin Root**: $B_{\text{floor}}(\eta) = \frac{3}{2}\eta - \frac{1}{48} = 0 \implies a_{\max} = \mathbf{\frac{37}{72}} \approx 0.513889$<br>2. **Exact Irrational Stationary Point**: $a^* = \mathbf{\frac{323}{276} - \frac{35\sqrt{16354}}{9384}} \approx 0.693319$ (approximated in `Endpoint.lean` by SOS proxy $\frac{283}{408}$)<br>3. **Componentwise Gram Savings**: $\mathbf{\frac{215}{3264}}$ ($\mathbf{592.35\times}$ larger than baseline SOS margin $\frac{49}{440640}$; $\mathbf{1341.73\times}$ at pure scale)<br>4. **$m \ge 2$ Tail Vanishing**: **6 of 8** non-principal Gauss branches vanish identically, relaxing $z_{\text{re}} \ge \frac{1}{6} \to \mathbf{\frac{1}{12}}$<br>5. **Principal Shift Budget & Tasks 1–3**: $\mathbf{\frac{17}{48000}}$ budget, universal `(1 - V)` & 2nd-order Euler polynomial identities over `Int`, $Q \ge 112$ threshold reduction, and master scale-coupling equations | **40 Lean 4 Theorems** (`404 + 295 lines`, `Rat`/`Int`/`Nat`, `22/22` hypothesis mutations caught)<br>[`qrh_exponent_and_parameter_bounds.lean`](./anatomy/001-openai-003-qrh/proofs/qrh_exponent_and_parameter_bounds.lean)<br>[`qrh_continuation_and_rescaling.lean`](./anatomy/001-openai-003-qrh/proofs/qrh_continuation_and_rescaling.lean)<br>[`verify_symbolic_qrh.py`](./anatomy/001-openai-003-qrh/proofs/verify_symbolic_qrh.py) | [**English (`en/`)**](./anatomy/001-openai-003-qrh/en/README.md)<br>[**한국어 (`ko/`)**](./anatomy/001-openai-003-qrh/ko/README.md) |
| **[`002`](./anatomy/002-openai-032-k3-hodge/README.md)** | **OpenAI `#032`: Retracted K3 Hodge Conjecture Manuscripts & `[EEMS13]` Forensics**<br>(`openai/math` commit `adc7f12`, 3,064 `.lean` files + 9 preprints) | Frontier AI<br>*(OpenAI)*<br>& `[EEMS13]` | 1. **Symplectic Double-Bind**: Reverse trace $G_2$ gives degrees $(1, 2k-1)$ and sign $-1$ ($I_{\mathrm{new}} = \mathbf{-2m \neq 0}$); forward trace $G_1$ at $\phi_0$ gives sign $+1$ but degrees $\mathbf{(2, 2k-2)}$, breaking degree-`2` curvature vanishing in `curvature.tex`<br>2. **`[EEMS13]` Boundary Sign Discrepancy**: `min-intersectYETI-final.tex:410, 694` omits the odd-dimensional boundary Poincaré-Hopf sign $(-1)^{\dim U} = -1$ on $D^{2k-1}$, contradicting `line 421` ($\operatorname{ind}_U + k - 1 = 3k - 2$)<br>3. **Rescued `Part I` Reduction Engine**: `exactks.tex` `4-7-10` exterior degree separation ($[6..22]$) and Buchweitz-Flenner semiregularity squeeze ($\dim\operatorname{Ext}^2 = b_2 - 19$) verified intact<br>4. **Algebraic No-Go & Additivity vs. Rigidity Circularity**: Central fiber split sum ($26 > 3$), 2-step Yoneda cone ($\dim U_B = 3 < 18 = \dim N \implies \ge 15$ uncobounded), Kummer fixed points ($\ker_{\mathrm{exc}}=0$), Clifford spinor ($\dim\operatorname{End}=2^{18}$), Walsh-Hadamard ($\operatorname{Ext}^2 = 2,093,056 > 523,779$), 4-term Koszul ($\mathbf{2,485,504 > 523,779}$), and External Additivity ($\mathbf{2,747,136 > 523,779}$) vs. Single Stable Family Hyperkähler Rigidity ($\mathbf{140,033 < 523,779}$ but $\operatorname{rank}(\phi^*)=\mathbf{0 \neq 21}$)<br>5. **Bogomolov Sign-Flip Obstruction**: $R_1 = 1 \implies \Delta_{\mathrm{lead}} = 0$ forces $\Delta_{\mathrm{Bog}}(h_-) < 0$, requiring a pure-$E^g$ 4th-degree correction $\gamma \in H^0(B)\otimes H^4(E^g)$ | **27 Lean 4 Theorems** (`452 lines`, `Int`/`Nat`, `112/112` hypothesis mutations caught)<br>[`k3_forensic_paths.lean`](./anatomy/002-openai-032-k3-hodge/proofs/k3_forensic_paths.lean)<br>[`verify_symbolic_k3.py`](./anatomy/002-openai-032-k3-hodge/proofs/verify_symbolic_k3.py) | [**English (`en/`)**](./anatomy/002-openai-032-k3-hodge/en/README.md)<br>[**한국어 (`ko/`)**](./anatomy/002-openai-032-k3-hodge/ko/README.md) |

---

## Repository Architecture

Each case under [`anatomy/`](./anatomy/) shares a **single, deduplicated `proofs/` directory** and a single [`manifest.json`](./anatomy/001-openai-003-qrh/manifest.json) between its English (`en/`) and Korean (`ko/`) documentation tiers, eliminating hash drift between languages:

```text
ultari-proof-anatomy/
├── README.md                  # Global English master index
├── README.ko.md               # Global Korean master index
├── tools/
│   └── verify_all.py          # 1-command deterministic verifier across all cases
└── anatomy/
    └── 001-openai-003-qrh/
        ├── README.md          # Case 001 English overview
        ├── README.ko.md       # Case 001 Korean overview
        ├── manifest.json      # Single source-of-truth SHA-256 & theorem ledger
        ├── proofs/            # Single deduplicated formal & symbolic proof suite
        │   ├── qrh_exponent_and_parameter_bounds.lean
        │   ├── qrh_continuation_and_rescaling.lean
        │   ├── verify_symbolic_qrh.py
        │   ├── symbolic_verification_result.json
        │   ├── problem_spec.md
        │   └── oai_ref/       # Reference .lean files from the target paper
        ├── en/                # 4-Tier English guides (01_Beginner .. 04_Automated)
        └── ko/                # 4-Tier Korean guides (01_초보자용 .. 04_자동검증용)
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
