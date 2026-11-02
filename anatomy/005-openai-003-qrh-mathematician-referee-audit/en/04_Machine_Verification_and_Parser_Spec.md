# 04. Machine Verification and Parser Specification

This specification defines the deterministic SHA-256 artifact checksums, the Lean 4 `406/406` (`283/283` + `123/123`) nested-binder hypothesis mutation-testing protocol, and the SymPy + Blackwell GPU reproduction commands for the OpenAI `#003` Mathematician & Referee Deep Audit and 8-Task Critical-Line Upgrade package (`46` theorems across Parts I–VII).

---

## 1. Artifact SHA-256 Checksum Table

| Artifact Path | SHA-256 Checksum | Lines | Role |
| :--- | :--- | :---: | :--- |
| [`proofs/qrh_mathematician_referee_audit.lean`](../proofs/qrh_mathematician_referee_audit.lean) | `33c57a9d4f8b572b97f55cbfd5a545f71b873bf29492c5b6d07de01be64dd790` | `499` | `38` structural, referee & transfer Lean 4 theorems (`0 sorry`, `283/283` mutations caught) |
| [`proofs/qrh_eight_tasks_critical_upgrade.lean`](../proofs/qrh_eight_tasks_critical_upgrade.lean) | `a2d4c01b2fe5bc5aa1f753f3eec0fca017da119c74c97a6a27a87ab8cfa753ec` | `173` | `8` remaining-task (`thm_39`–`thm_46`) Lean 4 theorems (`0 sorry`, `123/123` mutations caught) |
| [`proofs/verify_qrh_mathematician_audit.py`](../proofs/verify_qrh_mathematician_audit.py) | `da1db1190b7a8373840b0386a5829e9707958c93bad2bcfef785b61464a8c208` | `490` | SymPy symbolic + Blackwell GPU tensor verifier (`Stage 1`–`Stage 6`) |
| [`proofs/symbolic_verification_result.json`](../proofs/symbolic_verification_result.json) | `a30bd042bdb519c3190fa5f4e7f7026c764bed2ed92dfbd011c2f44f150e2162` | `199` | Deterministic symbolic & GPU verification output JSON |
| [`proofs/problem_spec.md`](../proofs/problem_spec.md) | `f386385f0e44b04eb57ee0170c4f21b21174532707b9f3482127269755ed198d` | `23` | 6-stage Mathematician Deep Audit, Master Transfer & 8-Task Upgrade problem specification |

---

## 2. Automated Verification Gates

1. **Lean 4 Kernel & Hypothesis Mutation Gate (`406/406` = `283/283` + `123/123`)**:
   ```bash
   ~/.elan/bin/lean proofs/qrh_mathematician_referee_audit.lean
   ~/.elan/bin/lean proofs/qrh_eight_tasks_critical_upgrade.lean
   ```
   * Pass criteria: Exit code `0`, `0 sorry`, and `406/406` (`100%`) relational hypothesis mutations rejected by the Lean 4 kernel across all `46` theorems (`thm_01`–`thm_46`).
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
