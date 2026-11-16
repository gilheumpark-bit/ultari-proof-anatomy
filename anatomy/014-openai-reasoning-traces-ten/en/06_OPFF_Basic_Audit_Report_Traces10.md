# [Audit Summary] OpenAI's `10` Publicly Released Reasoning Traces (`reasoning_traces/*.pdf` · `#007`..`#362`)

- **Target (`Repository / Preprints`)**: All **`10` publicly released reasoning trace PDFs (`213` pages, `273` sections)** in `openai/math` alongside their `10` companion preprints (`30,782` `.tex` lines), `ComparatorChallenges/*.lean` wrappers, and `OAI/` formalization directories (`2,380` `.lean` files)
- **Verification Toolchain**: `Lean 4 v4.29.0-rc8` (`Mathlib 4`) / `Python 3.14` (`SymPy` symbolic engine)
- **Artifact Checksums (`SHA-256`)**: [`traces10_algebraic_combinatorial_engines.lean`](../proofs/traces10_algebraic_combinatorial_engines.lean) (`c551be52cf76...`) | [`traces10_analytic_operator_and_scope_audit.lean`](../proofs/traces10_analytic_operator_and_scope_audit.lean) (`4543e211b208...`) | [`traces10_compiler_and_citation_drop.lean`](../proofs/traces10_compiler_and_citation_drop.lean) (`0cf51d47e3d4...`) | [`verify_symbolic_traces10.py`](../proofs/verify_symbolic_traces10.py) (`e489d399c103...`)
- **Verification Method**: **`75` independent `Lean 4` theorems** (`1,337` lines, `0 sorry`, `0 axiom`, `346 / 346` universal-hypothesis mutations killed) & live parser verification across `29` preserved upstream files
- **OPFF Formal Verdict**: `Gate 1: PASS` · `Gate 2: FAIL` · `Gate 3: FAIL` · `Gate 4: FAIL` · `Gate 5: PASS` $\implies$ **`OPFF TIER C` (`Conditional Revision Required — Valid Mathematical Cores with Severe Trace Omission & Post-Hoc Citation Turnover`)**

---

## 0. 8-Metric Executive Scorecard (TL;DR)

| Audit Dimension | Claimed in Preprints (`preprints/`) | Measured in Repository (`reasoning_traces/` · `Lean 4`) | Discrepancy / Status |
| :--- | :--- | :--- | :---: |
| **1. Trace Coverage** | `20`-preprint corpus in `openai/math` | **`10 / 20` (`50.0%`) reasoning trace PDFs released**; **`10 / 20` (`50.0%`) omitted** (`#005`, `#013`, `#266`, `#376`, etc.) | **`50.0%` Traces Omitted (`CP-07`)** |
| **2. Trace-to-Paper Drop** | `168` total references cited in the `10` traces | **`115 / 168` (`68.5%`) dropped from final `.bib`** (`#197` Kaplansky drops `14 / 14 = 100%`) | **`68.5%` Dropped (`CP-03`)** |
| **3. Post-hoc Insertions** | `187` total references in final `.bib` files | **`134 / 187` (`71.7%`) inserted post-hoc** (two-way Jaccard overlap **`17.5%`, `53 / 302`**) | **`71.7%` Post-hoc (`CP-03`)** |
| **4. Self-Citation Drop** | `5` companion OAI preprints cited `58` times in traces | `#005` (x35), `#003` (x15), `#301` (x6), `#107` (x1), `#192` (x1) **`5 / 5` (`100%`) deleted from final `.bib`** | **`100%` Self-Refs Deleted (`CP-03`)** |
| **5. Scope Funnel** | `10` headline problems solved end-to-end | **`7 / 10` (`70.0%`) preserve headline theorem** in `ComparatorChallenges/`; **`3 / 10` (`#271`, `#287`, `#362`) narrowed to proxy lemmas** | **`3 / 10` Scope Narrowed (`CP-04`)** |
| **6. Stub Reachability** | All repository modules connected | `#197` (`2 / 297` files, `29` lines) and `#221` (`2 / 166` files, `23` lines) contain minor unimported stubs | **Minor Stub Strata (`HOLD`)** |
| **7. Premise Integrity** | Complete mechanical soundness (`0 sorry`) | All `10` active challenge cones compile with **`0 sorry`, `0 axiom`**; `5 / 5` audited stub hypotheses genuinely consumed | **Kernel Sound (`Gate 1 PASS`)** |
| **8. Mathematical Value** | `10` cross-domain mathematical cores | Entropy telescoping (`#007`), Tudose integral (`#017`), Riccati margin `14` (`#087`), idempotent $1-ba$ (`#197`), quartic SOS (`#221`) **all valid** | **`Gate 5: PASS`** |

---

## 1. Summary of Verified Physical Findings

### 1.1 Two-Way Trace-to-Paper Citation Turnover (`17.5%` Jaccard) & `100%` Self-Citation Deletion (`CP-03`)
- **`17.5%` (`53 / 302`) Two-Way Jaccard Overlap**: Across the `10` pairs of reasoning traces (`168` cited works) and final preprints (`187` `.bib` entries), **`115 / 168` (`68.5%`) trace references were dropped** and **`134 / 187` (`71.7%`) preprint references were inserted post-hoc** without appearing anywhere in the reasoning traces (union `302`, intersection `53`, Jaccard overlap **`17.5%`**). In `#197` (*Kaplansky's unit conjecture*), `14 / 14` (`100%`) trace references were dropped and `12` new references were added (`0 / 26 = 0.0%` overlap).
- **`100%` (`5 / 5`) Deletion of Companion Internal Preprints (`58` Trace Citations $\to$ `0` `.bib` Entries)**: Five companion `openai/math` preprints repeatedly cited inside the reasoning traces as methodological templates — `#005` Catalan (`35` citations in `#017`), `#003` QRH (`15` citations in `#159`), `#301` Monotone-ipp (`6` citations in `#007`), `#107` Dickman (`1` citation in `#017`), and `#192` Sidon (`1` citation in `#102`) — were **`100%` omitted from the final bibliographies**.

### 1.2 Scope-Preservation Funnel (`20 -> 10 -> 7`) & Proxy Challenge Narrowing (`CP-04`, `CP-07`)
- **`50.0%` (`10 / 20`) Reasoning Trace Omission (`CP-07`)**: Exactly half of the `20` preprints in `openai/math` (including `#005` Catalan, `#013` Ostmann, `#266` MUB-6, and `#376` Navier-Stokes) have `0` released reasoning trace PDFs.
- **Proxy-Lemma Narrowing in `3 / 10` Challenges (`#271`, `#287`, `#362`, `CP-04`)**:
  1. **`#271` (`3D Heisenberg Spin Waves`)**: Whereas the manuscript studies 3D spin-wave free-energy asymptotics, `ComparatorChallenges/SpinWaves.lean` narrows the statement to a constant-witness tautology (`∃ E0, ∀ Λ, freeEnergy Λ = E0`).
  2. **`#287` (`Free Group Factors L(F_n)`)**: Narrows the von Neumann free group factor problem in the comparator challenge to a finite-dimensional matrix trace inequality lemma.
  3. **`#362` (`3D Relativistic Vlasov-Maxwell`)**: Narrows the 3D relativistic Vlasov-Maxwell global regularity theorem in the comparator challenge to a 1D decay integral lemma.

### 1.3 Section Citation Skew & Stub Reachability (`CP-03`, `CP-05`)
- **Front-Loaded Citations Across `30,782` `.tex` Lines**: Across the `10` preprints, citations are heavily concentrated in the introductory sections while core technical derivation sections remain largely uncited.
- **Minor Unreachable Stub Files**: `#197` (`2 / 297` files, `29` lines) and `#221` (`2 / 166` files, `23` lines) contain minor unimported stub files, while the active proof cones of all `10` challenges compile with `0 sorry` and `0 axiom`.

### 1.4 Verified `10`-Domain Mathematical Cores & Three-Tier Contribution Separation
- **All `10` Core Mathematical Mechanisms Verified (`Gate 1 & Gate 5: PASS`)**: Our `75` independent `Lean 4` theorems (`346/346` mutations killed) verify the mathematical cores of all `10` traces: `#007` three-scale entropy telescoping, `#017` Tudose triple beta integral & $\mu(\pi)=2$, `#087` Hanner polar duality & Riccati curvature margin (`194 - 180 = 14`), `#102` sparse tuple projection $\beta = k^{-2/3}$, `#159` harmonic block pigeonhole, `#197` corner-defect idempotent $e = 1 - ba$ & van Kampen Euler deficit (`1/2 > 0`), `#221` quartic joint convexity SOS identity $(A-B)^2((A+B)^2+2B^2)$, `#271` 3D spin-wave infrared integral ($4s < 5s$), `#287` Haagerup radial decay & Dykema-Rădulescu compression, and `#362` Glassey-Strauss relativistic bootstrap margin (`43/500 > 0`).
- **Three-Tier Contribution Separation**: (1) Prior human domain theories & cross-family pipeline templates **`65%`**, (2) **AI `273`-section exploratory pruning (falsifying dead ends) & algebraic/analytic synthesis `35%` (`Gate 1 & Gate 5 PASS`)**, (3) `17.5%` Jaccard citation turnover, `100%` self-citation deletion, and `3/10` proxy challenge narrowing require revision.

---

## 2. Pre-bunking Predictable Objections (FAQ)

- **Q1. "Isn't citation turnover between reasoning traces and final papers just normal editorial polishing?"**
  - **Fact**: Dropping **`68.5%` (`115 / 168`) of the works actually used during derivation** and inserting **`71.7%` (`134 / 187`) post-hoc references** (a **`17.5%` two-way Jaccard overlap**, and **`0.0%` (`0 / 26`) in `#197`**) severs the bibliographic record of how the proofs were constructed (`CP-03`).
- **Q2. "Why were all `58` citations to OpenAI's own companion preprints (`#005`, `#003`, `#301`, `#107`, `#192`) removed?"**
  - **Fact**: Following cleanroom forensic rules, we report only the physical state change: the reasoning trace PDFs explicitly cite those `5` companion preprints `58` times as direct methodological templates, whereas `5 / 5` (`100%`) are absent from the final `.bib` files.
- **Q3. "What does it mean that `#271`, `#287`, and `#362` narrow their `ComparatorChallenges/` statements?"**
  - **Fact**: While the `7` mathematical challenges (`#007`, `#017`, `#087`, `#102`, `#159`, `#197`, `#221`) export the full headline theorem in `ComparatorChallenges/*.lean`, the `3` mathematical-physics/operator-algebra challenges (`#271`, `#287`, `#362`) export narrowed proxy lemmas (e.g., constant free-energy witness in `SpinWaves.lean`) rather than the full continuum PDE/operator theorem (`CP-04`).
- **Q4. "Are the `7` full-scope challenges (`#007` through `#221`) genuinely proved?"**
  - **Fact**: Yes. All `7` full-scope challenges compile with `0 sorry` and `0 axiom` on faithful theorem statements, and our audit verified that all `5` suspect stub hypotheses across the corpus are genuinely consumed (`Gate 1 & Gate 5: PASS`).
- **Q5. "Do the `10` released reasoning traces (`213` pages, `273` sections) have genuine scientific value?"**
  - **Fact**: Yes. They document authentic trial-and-error mathematical discovery — falsifying `31` dead ends in `#017` before discovering the $m \to \infty$ simplex cancellation, and pivoting from failed group-ring heuristics to van Kampen curvature obstructions in `#197` (`Gate 5: PASS`).
- **Q6. "What exact revisions are required to upgrade the corpus to `OPFF TIER A`?"**
  - **Fact**: (1) Release the missing `10 / 20` reasoning trace PDFs (`#005`, `#013`, `#266`, `#376`, etc.), (2) restore the `115` dropped trace references (including the `5` companion preprints cited `58` times) to the final `.bib` files, and (3) align the `ComparatorChallenges/` wrappers for `#271`, `#287`, and `#362` with their full manuscript theorems.

---

## 3. 10-Second Terminal Reproduction (`Don't Trust, Verify`)

```bash
# 1) Verify the 17.5% (53/302) two-way Jaccard citation overlap, 58 deleted self-citations & 20->10->7 scope funnel
python3 -B proofs/verify_symbolic_traces10.py

# 2) Kernel-check all 75 independent Lean 4 theorems (0 sorry, 0 axiom, 346/346 hypothesis mutations killed)
lake env lean proofs/traces10_algebraic_combinatorial_engines.lean
lake env lean proofs/traces10_analytic_operator_and_scope_audit.lean
lake env lean proofs/traces10_compiler_and_citation_drop.lean
```
