# 04. Machine Verification and Parser Specification

This specification defines the deterministic SHA-256 artifact checksums, the Lean 4 `407/407` (`284/284` + `123/123`) nested-binder hypothesis mutation-testing protocol, and the SymPy + Blackwell GPU reproduction commands for the OpenAI `#003` Mathematician & Referee Deep Audit and 8-Task Critical-Line Upgrade package (`46` theorems across Parts I–VII).

---

## 1. Artifact SHA-256 Checksum Table

| Artifact Path | SHA-256 Checksum | Lines | Role |
| :--- | :--- | :---: | :--- |
| [`proofs/qrh_mathematician_referee_audit.lean`](proofs/qrh_mathematician_referee_audit.lean) | `2827d3d4a10abc5d55b13b035c7710a77a6f9eb049d28e44bdb6412531ef3782` | `499` | `38` structural, referee & transfer Lean 4 theorems (`0 sorry`, `284/284` mutations caught) |
| [`proofs/qrh_eight_tasks_critical_upgrade.lean`](proofs/qrh_eight_tasks_critical_upgrade.lean) | `939a9625fc5c0696d404fdc6bdd6e3a5ab71a6ec25c60ceee4d5bf89e85c038f` | `173` | `8` remaining-task (`thm_39`–`thm_46`) Lean 4 theorems (`0 sorry`, `123/123` mutations caught) |
| [`proofs/verify_qrh_mathematician_audit.py`](proofs/verify_qrh_mathematician_audit.py) | `1d9bf3c2adcb54c3d40c1faf608e0db3a91b229141c46343fe4562aa5cc1714c` | `490` | SymPy symbolic + Blackwell GPU tensor verifier (`Stage 1`–`Stage 6`) |
| [`proofs/symbolic_verification_result.json`](proofs/symbolic_verification_result.json) | `a84c39667d612831b2e5e45ad4ee328403a56c5cd1b46450e200d41d87552a0f` | `199` | Deterministic symbolic & GPU verification output JSON |
| [`proofs/problem_spec.md`](proofs/problem_spec.md) | `8149028e4727eebb2e6703eed0f7979441a482b15147976d8152304228f0b4bf` | `23` | 6-stage Mathematician Deep Audit, Master Transfer & 8-Task Upgrade problem specification |

---

## 2. Automated Verification Gates

1. **Lean 4 Kernel & Hypothesis Mutation Gate (`407/407` = `284/284` + `123/123`)**:
   ```bash
   ~/.elan/bin/lean proofs/qrh_mathematician_referee_audit.lean
   ~/.elan/bin/lean proofs/qrh_eight_tasks_critical_upgrade.lean
   ```
   * Pass criteria: Exit code `0`, `0 sorry`, and `407/407` (`100%`) relational hypothesis mutations rejected by the Lean 4 kernel across all `46` theorems (`thm_01`–`thm_46`).
2. **Symbolic (SymPy) + Blackwell GPU (PyTorch) Reproduction Gate**:
   ```bash
   python3 proofs/verify_qrh_mathematician_audit.py
   ```
   * Pass criteria: Exit code `0`, Blackwell GPU `float64` verification across $2^{24}+1 = 16,777,217$ complex contour grid points and all $611$ Eisenstein split primes $p \equiv 1 \pmod 6$ in $[7, 9973]$ (`1,222` cubic & sextic Gauss Gram matrices), Stage 5 & Stage 6 symbolic verification, and byte-identical reproduction of `proofs/symbolic_verification_result.json`.
3. **Static Discipline & Document Integrity Scan (`extra_scan.py` & `code_discipline.py`)**:
   ```bash
   python3 /home/heum/바탕화면/울타리_연구원/template/.ultari/extra_scan.py .
   python3 /home/heum/바탕화면/울타리_연구원/template/.ultari/code_discipline.py .
   ```
   * Pass criteria: `0` warnings and `0` problems (`EXIT 0`).

---

## 3. Multi-Vendor 3-CLI Clean-Room Blind Derivation (`20/20`) & Adversarial Referee Audit

To eliminate single-model bias, the entire suite was cross-examined across three independent vendor CLIs (`muse`, `opencode`, `agy`) under two tracks: **Track 1 (Zero-Hint Clean-Room Blind Derivation)** with access only to `oai_ref/*.lean`, and **Track 2 (Adversarial Referee Audit, `--bias referee / falsifier`)** across all `46` theorems and reports.

| Independent CLI Engine (Version / Model) | Track 1: Zero-Hint 20-Item Blind Derivation (`blind_answers.json` SHA-256) | Track 1: Standalone Clean-Room Lean 4 Proof (`blind_proof.lean` SHA-256) | Track 2: Adversarial Referee Audit (`46` Theorems Audited & Fixes Applied) |
| :--- | :--- | :--- | :--- |
| **`muse`**<br>(`Meta Muse Code CLI v1.4.14`, `muse-spark`) | **`20/20` (`100%`)**<br>`blind_answers.json`: `249a531e594dd509...` (`715B`, no trailing `\n`)<br>`solve_blind.py`: `dd0a8bf0e16a44a9...` | **`10` theorems (`0 sorry`, `EXIT 0`)**<br>`d7f5a7badb587d2b...` | • Confirmed `0` formula mismatches across all `46` theorems and `epistemic_boundary_honest = true`<br>• Referee findings resolved: ① fixed header count `36 → 38 Theorems`, ② formalized both 2-term unbundled floor `4103/4896` and 3-term bundled floor `4069/4896` in [`thm_27`](proofs/qrh_mathematician_referee_audit.lean#L356-L364) (`284/284` mutations caught), ③ bound [`thm_26`](proofs/qrh_mathematician_referee_audit.lean#L340-L347) directly to `N_0 = 2*97^2` and `H = 12*192*(2*N_0)` and strengthened 5-module call-chain verification in [`verify_qrh_mathematician_audit.py`](proofs/verify_qrh_mathematician_audit.py#L132-L137) |
| **`opencode`**<br>(`OpenCode CLI v2.0.32`, `deepseek-v4.1-flash-free`) | **`20/20` (`100%`)**<br>`blind_answers.json`: `b0aa08c41ef0d973...` (`716B`, with trailing `\n`; `strip()` hash matches `muse` `249a531e594dd509...`)<br>`solve_blind.py`: `7bb3e58176039b33...` | **`20` theorems (`0 sorry`, `EXIT 0`)**<br>`0979c12ae3c2c0ac...` | • Generated a standalone 403-line audit harness (`audit_referee.py`) scanning all `46` theorems: `0 sorry/axiom`, `0` vacuous/suspect hypotheses, and `epistemic_boundary_honest = true`<br>• Confirmed via raw source comparison against `oai_ref/*.lean` that Stage 5 transfer formulas (`131/150 - Delta_gram`, `209/240 - Delta_gram`) are new Stage 5 extensions ([`thm_28`](proofs/qrh_mathematician_referee_audit.lean#L368-L375), [`thm_32`](proofs/qrh_mathematician_referee_audit.lean#L412-L423)) beyond upstream's `7/8`-frozen code |
| **`agy`**<br>(`Google Antigravity CLI v1.4.12`) | **`20/20` (`100%`)**<br>`blind_answers.json`: `b0aa08c41ef0d973...` (`716B`, with trailing `\n`; deterministic `json.dumps(indent=2)+"\n"` byte-identical to `opencode`)<br>`solve_blind.py`: `c9c794aa06a0afdf...` | **`12` theorems (`0 sorry`, `EXIT 0`)**<br>`0060ed9ca0dede13...` | • **`PASS`** (`94445a3d83f03bda...`): Audited all `46` theorems (`38 + 8`), `0 sorry`, `0` vacuous hypotheses, `0` formula mismatches against the `26` upstream `oai_ref/*.lean` modules, end-to-end SymPy+GPU reproduction (`16,777,217` grid points & `611` primes), and `epistemic_boundary_honest = true` |
