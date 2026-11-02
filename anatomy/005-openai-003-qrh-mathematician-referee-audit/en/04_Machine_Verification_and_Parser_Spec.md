# 04. Machine Verification and Parser Specification

This specification defines the deterministic SHA-256 artifact checksums, the Lean 4 `407/407` (`284/284` + `123/123`) nested-binder hypothesis mutation-testing protocol, and the SymPy + Blackwell GPU reproduction commands for the OpenAI `#003` Mathematician & Referee Deep Audit and 8-Task Critical-Line Upgrade package (`46` theorems across Parts I–VII).

---

## 1. Artifact SHA-256 Checksum Table

| Artifact Path | SHA-256 Checksum | Lines | Role |
| :--- | :--- | :---: | :--- |
| [`proofs/qrh_mathematician_referee_audit.lean`](proofs/qrh_mathematician_referee_audit.lean) | `6219192ca82058c9d0ac094a3cb55fddc9332b1f7c857d2d2a1aa30b56b925ee` | `499` | `38` structural, referee & transfer Lean 4 theorems (`0 sorry`, `284/284` mutations caught) |
| [`proofs/qrh_eight_tasks_critical_upgrade.lean`](proofs/qrh_eight_tasks_critical_upgrade.lean) | `a2d4c01b2fe5bc5aa1f753f3eec0fca017da119c74c97a6a27a87ab8cfa753ec` | `173` | `8` remaining-task (`thm_39`–`thm_46`) Lean 4 theorems (`0 sorry`, `123/123` mutations caught) |
| [`proofs/verify_qrh_mathematician_audit.py`](proofs/verify_qrh_mathematician_audit.py) | `2b40b4b277ac400fbee20c6b992f987e6294972f1ce51941b1a9163c67d96edc` | `490` | SymPy symbolic + Blackwell GPU tensor verifier (`Stage 1`–`Stage 6`) |
| [`proofs/symbolic_verification_result.json`](proofs/symbolic_verification_result.json) | `95cfab711006e02fffad01235c4d12918afb095d293a6547d6cda22836ef3f97` | `199` | Deterministic symbolic & GPU verification output JSON |
| [`proofs/problem_spec.md`](proofs/problem_spec.md) | `1178341167f290674ad01b15ab50b78ddc5ae8c82910c7f6c6f3b4b79e01ac92` | `23` | 6-stage Mathematician Deep Audit, Master Transfer & 8-Task Upgrade problem specification |

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
3. **Artifact SHA-256 Checksum Integrity Gate**:
   ```bash
   sha256sum proofs/qrh_mathematician_referee_audit.lean \
             proofs/qrh_eight_tasks_critical_upgrade.lean \
             proofs/verify_qrh_mathematician_audit.py \
             proofs/symbolic_verification_result.json \
             proofs/problem_spec.md
   ```
   * Pass criteria: Exact SHA-256 checksum match across all `5` core artifacts (`EXIT 0`).
