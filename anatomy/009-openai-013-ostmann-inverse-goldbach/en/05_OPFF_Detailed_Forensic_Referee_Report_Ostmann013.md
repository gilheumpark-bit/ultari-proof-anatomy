# [Forensic & Referee Audit Report] Full Audit of OpenAI `#013` (*The Primes Are Additively Indecomposable* · Ostmann's Inverse Goldbach Problem, `Erdős #431`)

## 0. Provenance Metadata & Cryptographic Seal Ledger

| Field | Verified Specification |
| :--- | :--- |
| **Target Manuscript / Preprint** | *The Primes Are Additively Indecomposable* (`preprints/The-primes-are-additively-indecomposable-September-24-2026/`, [`01-introduction.tex`](../proofs/oai_ref/tex/sections/01-introduction.tex#L1-L141)–[`09-conclusion.tex`](../proofs/oai_ref/tex/sections/09-conclusion.tex#L1-L386), `9` sections totaling `6,072` lines + root `paper.tex` & `glyph-mappings.tex`, `52` total `\cite` invocations) |
| **Target Code Repository** | `openai/math` Family `013` (`lean/OAI/NumberTheory/Ostmann/` **`7,716` `.lean` files · `609,199` lines**, representing `5.18%` of all `148,832` `.lean` files in `openai/math`, #1 by file count + `2` comparator challenges `OstmannComplete.lean` & `OstmannPrimes.lean`) |
| **Companion Traces / External Imports** | Reasoning trace PDFs: **None provided (`0` files)** / Cross-family imports: Engine A imports `1` external `OAI` file (`PrimeGaps.SiegelBounds`) vs. Engine B importing **`18` external `OAI` files** (`15` from `#021` `OAI.NumberTheory.Jacobsthal.*` + `3` from `#026` `OAI.NumberTheory.PrimeGaps.*`) |
| **Compiler & Toolchain** | `Lean 4 v4.29.0-rc8` (`leanprover/lean4:v4.29.0-rc8`) vs. upstream `v4.34.1` / `Python 3.14` (`SymPy` symbolic engine) |
| **Verification Artifact SHA-256** | • [`ostmann_twin_engines_and_supply_contraction.lean`](../proofs/ostmann_twin_engines_and_supply_contraction.lean): `5e405c0f131c573c313fdb02799c8cf438ce27abaabe9ea4bd8dbd53e4785bd6`<br>• [`ostmann_tree_transfers_and_permutation_contradiction.lean`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean): `49e0207b9d0eecd15f434192b4d22ad38eb67a5c0ce410d2dff91f31586a3617`<br>• [`ostmann_algebraic_engines_and_cauchy_determinant.lean`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean): `ca474c31be0c4247c9cd512831959bda94d67dbf4645b5025c987ddbadae542c`<br>• [`verify_symbolic_ostmann.py`](../proofs/verify_symbolic_ostmann.py): `dd14880ab1aaed9a94e80d5228485264346a8b2230488ead675957ab7b75b47e` |
| **Verification Method** | standalone `Lean 4` suite of **`75` theorems + `3` recursive `def`s + `1` `structure` (`1,501` lines, `0 sorry`, `0 axiom`, `393 / 393` universal hypothesis mutations killed = `100%`)** and deterministic `SymPy` reproduction script |
| **Governing Audit Charter** | **Open Proof Forensics Foundation (`OPFF`) 5-Gate Joint International Audit Charter** (`COPE · IMU/AMS · ACM v1.1 · ICMJE/CRediT · NeurIPS`, Charter DOI: [`10.5281/zenodo.24241228`](https://doi.org/10.5281/zenodo.24241228), Ledger v1.0.0 DOI: [`10.5281/zenodo.24241229`](https://doi.org/10.5281/zenodo.24241229)) |
| **OPFF 5-Gate & Official Tier Verdict** | `Gate 1 (Kernel): PASS (0 sorry, standard Mathlib definitions preserved)` · `Gate 2 (Artifact): FAIL (duplicate twin engines of 7,335 files / 569,682 lines, 381 unreachable fossil files / 39,517 lines, & closed-form Scales.lean definitions)` · `Gate 3 (Ethics/Bib): FAIL (0 citations in Sec 7 [784L] & Sec 9 [386L], plus 18 undisclosed cross-family imports from #021 & #026)` · `Gate 4 (Provenance): FAIL (0 reasoning traces & disconnected root wrappers All.lean / PaperMain.lean)` · `Gate 5 (Value): PASS` $\implies$ **`OPFF TIER C` (`Valid Mathematical Core & Non-Conforming Artifact Packaging`)** |

---

### 0.1 8-Metric Executive Scorecard (TL;DR)

| Audit Dimension | Claimed in Manuscript (`PDF` `9` Secs · `6,072` Lines) | Measured in Repository (`OAI/NumberTheory/Ostmann/` `7,716` Files) | Discrepancy / Status |
| :--- | :--- | :--- | :---: |
| **1. Reachability & Duplication** | Lean 4 formalization of a 9-section paper (`7,716` files · `609,199` lines) | **Duplicate Twin Engines (`Complete.lean` `3,165` files vs. `Main.lean` `4,175` files, sharing only `5` files / `372` lines = `0.065%`)** + **`381` unreachable fossils (`39,517` lines)** | Twin Duplication / `381` Fossils |
| **2. Root Entrypoints** | `Complete.lean` · `Main.lean` · `All.lean` · `PaperMain.lean` | [`All.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/All.lean#L1) (`152`L) and [`PaperMain.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/PaperMain.lean#L1) (`25`L) are **unreachable from both comparator challenges** | `2` Root Wrappers Disconnected |
| **3. Dyadic Sum Induction** | Sec 9 derives $\sum_{j=0}^{k-1} j 2^j = (k-2)2^k + 2$ across tree levels | Engine B [`Scales.lean:51-73`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Conclusion/Scales.lean#L51-L73) defines `sum_dyadic_log` directly as the closed formula `(k-2)2^k \log 2 + 2\log 2` without finite-sum induction | Closed-Form `def` in Engine B |
| **4. Citation Distribution** | `52` `\cite` calls across `9` sections (`6,072` lines) | **`18` (`34.62%`, `12.77` / 100L)** in Sec 1 (`141`L, `2.32%`); **`0` citations in Sec 7 (`784`L) and Sec 9 (`386`L)**, `2` in Sec 4 (`1,182`L) (`30.4 : 1` skew vs. Secs 4–9) | **Citation Starvation in Secs 4–9** |
| **5. Cross-Family Dependencies** | Sec 5 `Remark 5.4` cites `#003` (`OpenAIQRH2026`) | Both Lean engines have **`0` imports from `#003`**; conversely, Engine B imports **`18` files from `#021` (`Jacobsthal`, `15`) and `#026` (`PrimeGaps`, `3`)** with `0` manuscript disclosure | Inverted Dependency Disclosure |
| **6. Docstring–Code Parity** | Sec 3 Siegel exceptional zero constant $K(\varepsilon)$ | [`QuadraticSplitSupply.lean:21`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Quadratic/QuadraticSplitSupply.lean#L21) docstring states `K(ε) = ε^{-1/2}` ($14.14$), whereas [`SiegelBoundProof.lean:81`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/ZeroDensity/SiegelBoundProof.lean#L81) uses `8/(5ε) = 1600` | Docstring Formula Drift |
| **7. Premise Forwarding & Slack** | `PublishedSiegelBound` & overlap-graph permutation decay | **`32 / 33` files forward `PublishedSiegelBound` without unpacking**; $(S_r)^m \to S_{rm}$ relaxation and $\kappa = 33/20 \to 8/5$ rounding inflate $k_{\min}: 1,040 \to 7,041$ and $L_{\mathrm{eff}}: 255,983 \to 4,115,904$ (`16.08x`) | `16.08x` Threshold Slack |
| **8. Generation Provenance** | Automated formalization pipeline | **`0` reasoning trace PDFs provided**; 3 generations of proof strata (`Gen 1A` `379` fossils $\to$ `Gen 1B` `3,165` files $\to$ `Gen 2` `4,175` files) coexist in one folder | `0` Reasoning Traces |

---

### 0.2 3-Tier Traffic-Light Scope Summary

| Tier | Audited Subsystem & Artifact Scope | Formal Determination & Verification Status |
| :--- | :--- | :--- |
| **🟢 `Tier 1`<br>(Unconditionally Verified Mathematical Core)** | • Complete 3-stage proof resolving Ostmann's Inverse Goldbach Problem ($|A|\ge 2 \wedge |B|\ge 2 \implies (A+B)\triangle\mathcal{P}$ infinite) with `0 sorry`, `0 axiom`, and standard Mathlib `Nat.Prime` / `DirichletCharacter.LFunction`<br>• Stage 1 finite-summand CRT composite witness ([`FiniteCRT.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/FiniteCRT.lean#L1)), Stage 2 Fourier supply contraction (`-11/125 < 0`), Stage 3 dyadic tree frequency budget vs. permutation decay (`2/5 - 3/4 = -7/20 < 0`) and $2\times 2$ Cauchy determinant non-vanishing ($\ge 1$)<br>• independent Lean 4 suite (`75` theorems, `1,501` lines, `393/393` mutants killed) & effective threshold reduction ($L_{\mathrm{eff}}: 4,115,904 \to 640,722 \to 255,983$) | **`Gate 1 & Gate 5: PASS`** — Confirms a genuine mathematical and formalization breakthrough resolving Ostmann's 1950 problem (`Erdős #431`) |
| **🟡 `Tier 2`<br>(Tactical Automation Relaxations & Constant Slack)** | • Relaxation of slot-wise permutations $(S_r)^m$ to the full product symmetric group $S_{rm}$, introducing size-1 unsplit components ($a_c = 1$) and inflating minimum tree depth ($k_{\min}: 1,040 \to 7,041$)<br>• Uniform bound $\log a_i \le \log r$ in component factorials ($4\times$ looser than $a_c \le r/4+1$) and rounding $\kappa = 33/20 \to 8/5$<br>• Forwarding of `PublishedSiegelBound` across `32 / 33` files in Engine A before single-site unpacking | **`Sound but Sub-Optimal Slack`** — Preserves logical soundness while inflating the effective counterexample log-log threshold by `16.08x` |
| **🔵 `Tier 3`<br>(Artifact Packaging & Bibliographic Non-Conformance)** | • Duplicate twin proof trees (`Complete.lean` `3,165` files + `Main.lean` `4,175` files sharing only `5` files = `0.065%`) alongside `381` unreachable fossil files (`39,517` lines, including `All.lean` & `PaperMain.lean`)<br>• Closed-form sum definitions in Engine B [`Scales.lean:51-73`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Conclusion/Scales.lean#L51-L73) and docstring formula drift (`ε^{-1/2}`) in [`QuadraticSplitSupply.lean:21`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Quadratic/QuadraticSplitSupply.lean#L21)<br>• `0` citations in Sec 7 (`784`L) and Sec 9 (`386`L), unused `#003` citation in `Remark 5.4`, and `18` undisclosed cross-family imports from `#021` & `#026` | **`Gate 2·3·4: FAIL (Non-Conformance)`** — Repository packaging, bibliographic attribution, and manuscript-code correspondence require revision |

---

## Part I. Bibliographic Skew & Attribution Deficit Audit

### 1.1 Section-by-Section Citation Density Imbalance (`sections/01–09.tex` `6,072` Lines, `52` `\cite` Calls)

| Manuscript Region | Files (`proofs/oai_ref/tex/sections/*.tex`) | Lines (`Share`) | Citations (`Share`) | Citations / 100 Lines | Assessment |
| :--- | :--- | :---: | :---: | :---: | :---: |
| **Introduction (`Section 1`)** | [`01-introduction.tex`](../proofs/oai_ref/tex/sections/01-introduction.tex#L1-L141) | `141` (`2.32%`) | **`18` (`34.62%`)** | **`12.77`** | **Front-Loaded Clustering** |
| **Preliminaries & Quadratic (`Secs. 2–3`)** | [`02-preliminaries.tex`](../proofs/oai_ref/tex/sections/02-preliminaries.tex#L1-L292), [`03-quadratic.tex`](../proofs/oai_ref/tex/sections/03-quadratic.tex#L1-L1076) | `1,368` (`22.53%`) | `15` (`28.85%`) | `1.10` | Moderate |
| **Core Technical Body (`Secs. 4–9`)** | [`04-characters.tex`](../proofs/oai_ref/tex/sections/04-characters.tex#L1-L1182) (`2`), [`05-supply.tex`](../proofs/oai_ref/tex/sections/05-supply.tex#L1-L772) (`7`), [`06-tree.tex`](../proofs/oai_ref/tex/sections/06-tree.tex#L1-L683) (`3`), [`07-construction.tex`](../proofs/oai_ref/tex/sections/07-construction.tex#L1-L784) (**`0`**), [`08-arithmetic.tex`](../proofs/oai_ref/tex/sections/08-arithmetic.tex#L1-L756) (`7`), [`09-conclusion.tex`](../proofs/oai_ref/tex/sections/09-conclusion.tex#L1-L386) (**`0`**) | **`4,563` (`75.15%`)** | **`19` (`36.54%`)** | **`0.42`** | **Citation Starvation (`0` in Secs 7 & 9)** |
| **Total** | All `9` sections (`6,072` lines) | `6,072` (`100%`) | `52` (`100%`) | `0.86` | **Skew Ratio `30.4 : 1` (Sec 1 vs. Secs 4–9)** |

### 1.2 Inverted Cross-Paper Dependency Disclosure & Omitted Primary References

1. **Cited in Manuscript (`Remark 5.4`) but Unused in Code (`0` Imports from `#003` QRH)** ([`thm_19_qrh_003_citation_in_remark_5_4_is_strictly_optional`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L386-L400)):
   - [`05-supply.tex:751-772`](../proofs/oai_ref/tex/sections/05-supply.tex#L751-L772) cites OpenAI `#003` (`\cite{OpenAIQRH2026}`), whereas both Lean engines (`Complete.lean` and `Main.lean`) have **`0` imports from `OAI.NumberTheory.DirichletL`** and discharge all zero-density bounds unconditionally via classical Montgomery bounds and Landau–Page single-prime deletion.
2. **Used in Code (`18` External Files in Engine B) but Undisclosed in Manuscript** ([`thm_04_external_dependency_asymmetry_1_vs_18`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L97-L117), [`thm_37_engine_b_jacobsthal_and_prime_gaps_reuse_accounting`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L310-L324)):
   - Engine B (`Main.lean` cone, `4,175` files) directly imports **`15` files from `#021` (`OAI.NumberTheory.Jacobsthal.*`, Erdős `#970`)** and **`3` files from `#026` (`OAI.NumberTheory.PrimeGaps.*`, Problem 344)** without disclosing these cross-family dependencies in the manuscript.
3. **Omitted Classical Primary Literature in Technical Sections**:
   - `Section 3` (`03-quadratic.tex`): Uses Landau–Page exceptional zero repulsion and Siegel bounds while citing only the textbook `MontgomeryVaughan2007` and omitting primary sources **Page (1935)** (*Proc. London Math. Soc.* (2) **39**, 116–141), **Siegel (1935)** (*Acta Arith.* **1**, 83–86), and **Tatuzawa (1951)** (*Jap. J. Math.* **21**, 163–178).
   - `Section 5` (`05-supply.tex`): Uses Schur complement positivity without citing **Schur (1917)** (*J. Reine Angew. Math.* **147**, 205–232).
   - `Section 8` (`08-arithmetic.tex:476-520`): Relies on the $2\times 2$ Cauchy determinant identity $\det[(b_i - a_j)^{-1}]$ (`eq:arith-numerator`) without citing **Cauchy (1841)** (*Exercices d'analyse et de physique mathématique* **2**, 151–159).

---

## Part II. Provenance Omissions & Multi-Generation Stratum Accumulation

- **Absence of Reasoning Trace PDFs (`0` Files)**:
  - Despite `OAI/NumberTheory/Ostmann/` being the largest single problem directory by file count in `openai/math` (`7,716` `.lean` files, `609,199` lines), `0` reasoning trace PDFs or initial prompt logs are released.
- **Unpruned 3-Generation Proof Evolution Inside One Directory** ([`thm_01`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L30-L53)–[`thm_03`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L71-L96)):
  - Dependency-graph reconstruction reveals three successive generations left side-by-side without pruning: (i) **Generation 1A (`379` fossil files: `SelectedScheduledIteration.lean` $\to$ `FinalExponentialContradiction.lean`)**, (ii) **Generation 1B (`3,165` active files in Engine A `Complete.lean`)**, and (iii) **Generation 2 (`4,175` active files in Engine B `Main.lean`)**, plus `2` disconnected root wrappers (`All.lean`, `PaperMain.lean`).

---

## Part III. Twin-Engine Duplication Architecture & Cross-Family Grafting

### 3.1 Four-Way Inclusion–Exclusion Partition of `OAI/NumberTheory/Ostmann/` (`7,716` Files · `609,199` Lines, [`thm_01`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L30-L53)–[`thm_05`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L118-L147))

| Stratum | File Count (`Share`) | Line Count (`Share`) | Architectural Role & External Dependencies |
| :--- | :---: | :---: | :--- |
| **Engine A (`Complete.lean` Active Cone)** | `3,165` (`41.02%`) | `266,820` (`43.80%`) | 9-stage top-down 15-hypothesis discharge spine ([`InverseGoldbach.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/InverseGoldbach.lean#L30) $\to$ [`Complete.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Complete.lean#L11)); `1` external `OAI` import |
| **Engine B (`Main.lean` Active Cone)** | `4,175` (`54.11%`) | `303,234` (`49.78%`) | Bottom-up `Actual*` 4-provider consumer ([`ActualComparisonContradiction.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Conclusion/ActualComparisonContradiction.lean#L14)); **`18` external `OAI` imports** (`15` `#021` + `3` `#026`) |
| **Shared Foundation (`Complete ∩ Main`)** | **`5` (`0.065%`)** | **`372` (`0.061%`)** | [`Defs.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Defs.lean#L1) (`46`), `Statement.lean` (`2`), [`Endpoint.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Endpoint.lean#L1) (`190`), [`FiniteCRT.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/FiniteCRT.lean#L1) (`68`), [`FiniteFactor.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/FiniteFactor.lean#L1) (`66`) |
| **Reachable Union (`Complete ∪ Main`)** | `7,335` (`95.06%`) | `569,682` (`93.51%`) | $3,165 + 4,175 - 5 = 7,335$ files; $266,820 + 303,234 - 372 = 569,682$ lines |
| **Unreachable Module Strata (`Orphans`)** | **`381` (`4.94%`)** | **`39,517` (`6.49%`)** | `Arithmetic` (`264`), `Construction` (`86`), `Quadratic` (`10`), `Characters` (`8`), `ZeroDensity` (`7`), `Tree` (`2`), `Preliminaries` (`1`), `QuadraticCenter` (`1`), root [`All.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/All.lean#L1) & [`PaperMain.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/PaperMain.lean#L1) (`2`) |
| **Total (`Ostmann/`)** | **`7,716` (`100%`)** | **`609,199` (`100%`)** | Two comparator challenges (`OstmannComplete.lean`, `OstmannPrimes.lean`) compile two nearly disjoint `267k`-line and `303k`-line trees for logically equivalent theorems |

---

## Part IV. Paper–Artifact Divergence & Four Formalization Relaxations Audit

### 4.1 Manuscript / Docstring vs. Active Lean Code Divergences

| Divergence Axis | Manuscript (`paper.pdf`) / Docstring Statement | Active Lean 4 Repository Reality | Verified Theorem |
| :--- | :--- | :--- | :--- |
| **1. Sec 9 Dyadic Tree Sum Derivation**<br>([`09-conclusion.tex:355`](../proofs/oai_ref/tex/sections/09-conclusion.tex#L355) vs. [`Scales.lean:51-73`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Conclusion/Scales.lean#L51-L73)) | Derives the level-weighted frequency budget via finite summation $\sum_{j=0}^{k-1} 2^j \log(2^j) = ((k-2)2^k + 2)\log 2$ | Engine A (`MovingFrequencyBudget.lean`) sums over `Finset.range k`, whereas Engine B ([`Scales.lean:51-53`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Conclusion/Scales.lean#L51-L53)) defines `sum_dyadic` and `sum_dyadic_log` directly as closed-form expressions without finite-sum induction | [`thm_21`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L30-L50)–[`thm_26`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L132-L150) |
| **2. Sec 3 Siegel Constant `K(ε)` Docstring**<br>([`QuadraticSplitSupply.lean:21`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Quadratic/QuadraticSplitSupply.lean#L21) vs. [`SiegelBoundProof.lean:81`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/ZeroDensity/SiegelBoundProof.lean#L81)) | Module docstring states `K(ε) = ε^{-1/2}` ($\sqrt{200} \approx 14.14$ at $\varepsilon = 1/200$) | Active proof code uses the linear reciprocal `K(ε) = 8 / (5 * ε)` ($K_{\mathrm{away}} = 1600 \ge 50$ at $\varepsilon = 1/200$) | [`thm_10`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L218-L238), [`thm_46`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L476-L494) |
| **3. Root Wrappers `All.lean` & `PaperMain.lean`**<br>([`All.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/All.lean#L1), [`PaperMain.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/PaperMain.lean#L1)) | Named as root umbrella entrypoints for the paper | Unimported by both comparator challenges (`OstmannComplete.lean`, `OstmannPrimes.lean`), sitting in unreachable strata | [`thm_03`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L71-L96) |

### 4.2 Four Formalization Relaxations (`Formalization Slack`) & Premise Forwarding

| Relaxation Axis (`File:Line`) | Formalization Shortcut in Code | Quantitative Loss | Lossless Recovery Theorem |
| :--- | :--- | :--- | :--- |
| **1. Symmetric Group Expansion ($(S_r)^m \to S_{rm}$)**<br>`Tree/ArrangementGraph.lean:12`, `Conclusion/OverlapComponents.lean:10` | Symmetrizes over `Equiv.Perm (Fin r × Fin m)` ($S_{rm}$) instead of slot-wise $(S_r)^m$ (`FinalReassignments.lean`) | Permits size-1 unsplit components ($a_c = 1$), weakening bad-arrangement decay from $-1$ to $-3/4$ and net rate from $1$ to $7/20$ ($k_{\min}: 1,040 \to 7,041$) | [`thm_41`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L381-L395), [`thm_42`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L396-L411), [`thm_44`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L428-L450) |
| **2. Uniform Component Bound ($\log a_i \le \log r$)**<br>`Tree/ComponentFactorial.lean:35-53` | Bounds each component logarithm via $a_i \le r$ (`Finset.single_le_sum`) prior to $\sum(a_i - 1) = r - t$ | Loses a **$4\times$ factor** relative to the true maximum component bound $a_c \le r - t + 1 \le r/4 + 1$ when $4(r-t) \le r$ | [`thm_43_bad_component_max_size_quarter_bound`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L412-L427) |
| **3. Local Parseval Rounding ($\kappa = 8/5$)**<br>[`Supply/ContractionConstants.lean:45`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Supply/ContractionConstants.lean#L45) | Rounds $\kappa = 33/20 = 1.65$ (asymptotic $17/10 = 1.70$) down to $8/5 = 1.60$ | Shrinks non-sparse favorable prime harmonic mass from $0.22L\text{–}0.23L$ to $0.15L$ ($+46.7\%\text{–}+53.3\%$ loss) | [`thm_45_supply_contraction_favorable_mass_expansion`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L451-L475) |
| **4. `PublishedSiegelBound` Forwarding (`32/33` Files)**<br>`ZeroDensity/HadamardPrimeBound.lean:48` | `32` of `33` files forward `hSiegel` untouched while `1` file invokes the ineffective Siegel bound | Renders the counterexample bound ineffective and inflates the log-log threshold to $L_{\mathrm{eff}} = 4,115,904$ | [`thm_46`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L476-L494)–[`thm_50`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L552-L562) ($L_{\mathrm{eff}} \to 640,722 \to 255,983$) |

---

## Part V. Valid Mathematical Core Recognition (`Gate 5: PASS`), 4 Algebraic Engines & `16.08x` Threshold Reduction

### 5.1 Recognition of the Complete Proof Resolving Ostmann's Inverse Goldbach Problem (`Gate 1 & Gate 5: PASS`)

- Independently of the twin-engine duplication and packaging issues, the active proof cones in `OAI/NumberTheory/Ostmann/` contain **`0 sorry` and `0` custom axioms** over standard Mathlib definitions and **validly resolve Ostmann's 1950 Inverse Goldbach Problem (`Erdős #431`) (`Gate 1 & Gate 5: PASS`)**:
  1. **Finite-Summand Exclusion ([`thm_06`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L148-L171))**: For finite $|A|\ge 2$ and infinite $B$, a 2-element transposition combined with CRT and Dirichlet's theorem forces infinitely many composite sums $f(a)+b = k q_a \in A+B$.
  2. **Sec 3 Common Rational Center Lift & Bonami 4th Moment ([`thm_51`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L427-L447), [`thm_56`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L54-L65)–[`thm_60`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L136-L152))**: Cancels unknown local shifts $t_p$ via $(an - at_p) - (am - at_p) = a(n-m)$ and suppresses high-weight squarefree terms via $(a+b)^4 + (a-b)^4 - 2(a^4+b^4) = 12a^2b^2 \ge 0$ ($-625K$ exponent).
  3. **Sec 5 Rank-2 Squared Transfer Kernel $K^2$ & Supply Contraction ([`thm_14`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L296-L316)–[`thm_15`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L317-L337), [`thm_61`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L153-L187)–[`thm_64`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L224-L242))**: Doubles the leading decay slope to $2t_0 = 17/10 > 8/5$, refuting sparse Fourier support via $1 - \frac{8}{5}\cdot\frac{17}{25} = -\frac{11}{125} < 0$.
  4. **Secs 6, 8 & 9 Affine Collision Factorization, $2\times 2$ Cauchy Determinant & Dyadic Tree Contradiction ([`thm_21`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L30-L50)–[`thm_35`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L278-L295), [`thm_65`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L243-L259)–[`thm_75`](../proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L409-L418))**: Combines $(u_1 - u_2)(1 - (u_1+u_2)t) = 0$ and the non-vanishing Cauchy determinant numerator $(b_2 - b_1)(a_1 - a_2) \ge 1 \neq 0$ against the net tree contraction rate $\frac{2}{5} - \frac{3}{4} = -\frac{7}{20} < 0$.

### 5.2 OPFF Independent `Lean 4` Re-Verification (`75` Theorems, `393/393` Mutants Killed) & `16.08x` Threshold Tightening

1. **Eliminating Bad Arrangements via Slot-Wise Derangements ($t_1 = 0$) & Cutting Tree Depth by `85.2%` (`k_min: 7,041 -> 1,040`)**:
   - Theorems [`thm_41`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L381-L395), [`thm_42`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L396-L411), and [`thm_44`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L428-L450) prove that enforcing a single deranged slot pair ($\sigma_2(l) \neq \sigma_1(l)$) forces $t_1 = 0 \implies 4(r-t) \ge 2r > r$, making the bad-arrangement set empty and reducing minimum tree depth from `7,041` to **`1,040` (`6,001` levels saved)**.
2. **Making Ostmann's Bound Effective via Tatuzawa's Theorem (`384,002`) & $2^k$ Cancellation (`L_eff: 4,115,904 -> 640,722 -> 255,983`)**:
   - Theorems [`thm_47`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L495-L512)–[`thm_50`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L552-L562) replace the single `PublishedSiegelBound` unpacking in `HadamardPrimeBound.lean:48` with Tatuzawa's theorem plus 1 extra deleted prime ($|D_{\mathrm{ext}}| \le 3$) and cancel $2^k$ in `MovingStatisticDecay.lean`, tightening the explicit effective log-log counterexample threshold from **`4,115,904` to `640,722` (`255,983` with widened spectator cell, `16.08x` reduction)**.

### 5.3 Full Audit of the `14` `Published*` Inputs in [`InverseGoldbach.lean:13-26`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/InverseGoldbach.lean#L13-L26) and Upstream Patch / Transitive Cone Findings

1. **Zero Specification Weakening Across All `14` `Published*` Analytic Inputs (`0` `sorryAx`)**:
   - Auditing all `14` analytic number-theoretic hypotheses taken by [`InverseGoldbach.lean:13-26`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/InverseGoldbach.lean#L13-L26) (`P0 : PublishedProgressionInput`, `ls : PublishedAdditiveLargeSieve`, `hsize : PublishedSummandSizeBound`, `hBonami : PublishedBonamiBound`, `Hreal : PublishedRealZeroInput P0`, `hSiegel : PublishedSiegelBound`, `sieve : PublishedQuadraticLargeSieve`, `hM : MertensEstimate CM`, `hMH : MertensHarmonicEstimate CH`, `Z : ComplexZeroEnumeration`, `hD : PublishedComplexZeroDensity Z`, `hR : PublishedComplexZeroRegion Z`, `Pexplicit : PublishedSmoothExplicitFormula Z`, `hPNT : PublishedSmoothPrincipalPNT`) confirms that every definition matches the standard classical theorems (Montgomery–Vaughan 1973, Elsholtz 2006, Bonami 1970, Page–Siegel 1935, Heath-Brown 1995, Montgomery 1969) over `Nat.Prime` and `DirichletCharacter.LFunction`. In particular, `actualCharacterZeros` in [`ComplexDensityProof.lean:28`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/ZeroDensity/ComplexDensityProof.lean#L28) is a bijection $\mathbb{N} \simeq \{p : \mathbb{C}\times\mathbb{N} \mid \chi.L(p.1)=0 \wedge p.2 < \mathrm{analyticOrderNatAt}\}$, preventing empty-enumeration bypasses.
   - Setting `"enable_nanoda": false` in [`OstmannComplete.json`](../proofs/oai_ref/lean/ComparatorChallenges/OstmannComplete.json#L1-L15) and [`OstmannPrimes.json`](../proofs/oai_ref/lean/ComparatorChallenges/OstmannPrimes.json#L1-L14) matches the repository-wide default (`413 / 418 = 98.80%` of challenge JSONs due to `vm.max_map_count` limits), and all reachable modules (`3,207` in Engine A and `4,358` in Engine B) contain `0` `sorry`, `0` `sorryAx`, `0` custom `axiom`, `0` `native_decide`, and `0` `unsafe` declarations.
2. **Upstream Compatibility Patches Adding `+47,394` Lines in External Namespaces, Omitting Apache 2.0 `NOTICE.md`, and Replacing `2,253` Comment Lines with Byte-Preserving Spaces (`0x20`)**:
   - Inspecting the upstream dependency patches imported by Engine B (`OstmannPrimes.json` $\to$ [`Main.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Main.lean#L1)) reveals:
     - `PrimeNumberTheoremAnd` patch: Adds `20` new files (`+21,197` lines) under `PrimeNumberTheoremAnd/Erdos970/*`. Its Hadamard support module (`+6,805` lines, `31` sections) concatenates the `11` `SiegelZeros` files (`228 / 228` declarations identical) while **omitting the `SiegelZeros/NOTICE.md` attribution file (`Copyright 2025 Stefan Kebekus, 2026 Matteo Cipollina`, Apache 2.0) from `Erdos970/` (`0` `NOTICE` files)** and replacing `91` comment lines with ASCII spaces (`0x20`).
     - `StrongPNT` patch: Adds `8` new files (`+26,197` lines) under `StrongPNT/Erdos970/*` while **replacing `2,162` lines of upstream comments, blueprints, and headers with exact byte-length ASCII spaces (`0x20`)** (`702` lines in `PNT4`, `580` in `PNT1`, `478` in `PNT3`, `338` in `PNT2`).
   - Meanwhile, the `#013` manuscript and `references.bib` (`35` entries) contain **`0` citations** to the three external Lean repositories imported by the proofs (**`PrimeNumberTheoremAnd`**, **`StrongPNT`**, and **`CBirkbeck/AINTLIB` `BernoulliRegular`** used by Engine A for quadratic Gauss-sum signs; note that Engine A [`Complete.lean`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/Complete.lean#L1-L24) does not depend on the `Erdos970` patch modules).
3. **Transitive Cross-Family Cones (`42` vs. `183` External `OAI` Modules), Omission from `formalization.yaml`, and `952` Unused Internal Hypotheses**:
   - Expanding the full transitive import closure shows that Engine A (`Complete.lean`) imports `42` modules from `#026` `PrimeGaps.*` (`3,207`-module cone) and Engine B (`Main.lean`) imports `136` modules from `#021` `Jacobsthal.*` (including `105` in `Jacobsthal/Siegel/*`) plus `47` from `#026` `PrimeGaps.*` (**`183` external `OAI` modules total**, `4,358`-module cone) without manuscript disclosure; `#013` is also omitted from the repository's `formalization.yaml` (`176`-paper list) and retains `952` unused hypothesis binders across internal helper lemmas.

---

## Part VI. Actionable Architectural & Bibliographic Repair Specification

1. **Consolidate Twin Engines & Prune `381` Unreachable Fossil Files (`39,517` Lines)**:
   - Unify the directory around either self-contained Engine A (`Complete.lean`) or modular Engine B (`Main.lean`), removing `3,160+` duplicate modules and archiving the `381` unreachable fossil files (including `All.lean` and `PaperMain.lean`).
2. **Bridge `Scales.lean:51-73` by Induction & Fix the `QuadraticSplitSupply.lean:21` Docstring**:
   - Connect the closed-form definitions in `Scales.lean` to the `Finset.range k` inductive proof ([`thm_21`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L30-L50)–[`thm_23`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L80-L102)) and update `K(ε) = ε^{-1/2}` in `QuadraticSplitSupply.lean:21` to `8 / (5 * ε)`.
3. **Restore Omitted Primary Citations in Secs 3, 5, 7, 8 & 9 and Disclose `#021` / `#026` Imports**:
   - Add primary citations to `Page (1935)`, `Siegel (1935)`, `Tatuzawa (1951)`, `Schur (1917)`, and `Cauchy (1841)`, populate references in Sections 7 and 9, and explicitly document Engine B's `18` imported modules from `#021` (`Jacobsthal`) and `#026` (`PrimeGaps`).

---

## Part VII. International-Standard Non-Conformance Matrix, Three-Tier Attribution & Final Verdict

### 7.1 International Publication & Verification Standards Non-Conformance Matrix (`COPE · IMU/AMS · ACM v1.1 · ICMJE/CRediT · NeurIPS`)

| Standard Category | Governing International Provision | Verified Physical Observation in (`#013` Ostmann) | Determination |
| :--- | :--- | :--- | :---: |
| **Paper–Artifact Divergence & Packaging Bloat (`Gate 2`)** | `ACM Artifact Review v1.1` (1-to-1 correspondence between manuscript structure and repository modules without unpruned duplicate trees) | • Two nearly disjoint proof trees (`Complete.lean` `3,165` files vs. `Main.lean` `4,175` files, sharing `5` files = `0.065%`) plus `381` unreachable fossils (`39,517` lines, including `All.lean` & `PaperMain.lean`) inflate the folder to `7,716` files (`609,199` lines)<br>• `Scales.lean:51-73` declares closed-form dyadic sums without finite-sum induction, and `QuadraticSplitSupply.lean:21` lists `ε^{-1/2}` instead of `8/(5ε)` | **Paper–Artifact Divergence (`Gate 2: FAIL`)** |
| **Attribution Deficit & Undisclosed Cross-Imports (`Gate 3`)** | `COPE Citation Guidelines` / `AMS Ethical Guidelines` (mandatory primary-source attribution in technical proof sections and accurate dependency disclosure) | • `34.62%` (`18/52`) of citations cluster in Sec 1 (`2.32%` of lines), while Sec 7 (`784`L) and Sec 9 (`386`L) have `0` citations<br>• `Remark 5.4` cites unused `#003` (`0` imports) while omitting Engine B's `18` imported files from `#021` (`15`) & `#026` (`3`) and primary sources `Page (1935)`, `Siegel (1935)`, and `Cauchy (1841)` | **Attribution Deficit (`Gate 3: FAIL`)** |
| **Provenance Omission (`Gate 4`)** | `NeurIPS Code & Data Guidelines` / `ICMJE` (disclosure of generation logs and multi-generation code lineage) | • `0` reasoning trace PDFs provided for the largest directory in `openai/math` (`7,716` files), with 3 generations of proof attempts left unpruned in one tree | **Non-Conformance (`Gate 4: FAIL`)** |

### 7.2 Three-Tier Attribution Analysis (Human Foundations vs. Computer-Assisted Proof vs. Automated Pipeline)

1. **Foundational Human Number-Theoretic & Combinatorial Assets (`0%` Standalone AI Possibility)**:
   - Every analytical and algebraic tool in the proof builds directly upon human literature: finite-summand reductions (**Ostmann 1956, Hornfeck 1954–1955, Elsholtz 2001–2006, Elsholtz–Harper 2015, Green–Harper 2014**), sign-hypercontractivity (**Bonami 1970**), bilinear character bounds (**Heath-Brown 1995**), zero-density and exceptional-zero theory (**Page 1935, Siegel 1935, Montgomery 1969**), additive combinatorics (**Kneser 1953, Gowers 2008, Babai–Nikolov–Pyber 2008**), the **Cauchy determinant (Cauchy 1841)**, **Schwartz–Zippel (1979–1980)**, and the human-authored **Mathlib 4** library. Without these human assets, the standalone AI probability of formulating or proving `#013` is **`0%`**.
2. **Valid Mathematical Synthesis & `0 sorry` Lean 4 Formalization Core (`Gate 1 & Gate 5: PASS`)**:
   - Overcoming the classical sieve parity barrier and mod-$p$ phase cancellation by combining (i) Sec 3 common rational center lifts ($h/m$), (ii) Sec 5 rank-2 squared transfer kernels ($K^2$, slope $2t_0 = 1.7 > 1.6$), and (iii) Sec 6 quadratic affine operators $U_u F(t) = F(u - u^2 t)$ with Sec 8 $2\times 2$ Cauchy determinant non-vanishing across a 5-tier $\log\log p$ prime hierarchy (`0 sorry` in Lean 4) represents a **genuine, publication-grade mathematical and computer-assisted proof achievement**.
3. **Bloat & Divergences Introduced by the Automated Multi-Agent Pipeline (`Gate 2–4: FAIL`)**:
   - During iterative formalization across Generation 1A (`379` fossils), Generation 1B (`3,165` files), and Generation 2 (`4,175` files), the automated multi-agent pipeline left all three generations and disconnected root wrappers (`All.lean`, `PaperMain.lean`) inside one `7,716`-file directory, relaxed $(S_r)^m \to S_{rm}$ and $\kappa = 33/20 \to 8/5$ (`16.08x` threshold inflation), left `0` citations in Sections 7 and 9, and omitted disclosure of Engine B's `18` cross-family imports from `#021` and `#026`.

### 7.3 Pre-bunking Predictable Objections (FAQ — 6 Questions)

- **Q1. "Doesn't the presence of `7,716` files (`609,199` lines) reflect the intrinsic length of a single unified proof?"**
  - **Fact**: The `7,716` files do not form a single proof chain. They consist of two parallel proof engines proving the same theorem—Engine A (`Complete.lean`, `3,165` files) and Engine B (`Main.lean`, `4,175` files)—which share only `5` foundational files (`372` lines, `0.065%`), plus `381` unreachable fossil files (`39,517` lines) ([`thm_01`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L30-L53)–[`thm_03`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L71-L96)).
- **Q2. "Since Section 5 `Remark 5.4` cites OpenAI `#003` (`QRH`), does `#013` depend on `#003`?"**
  - **Fact**: Both Lean engines (`Complete.lean` and `Main.lean`) have **`0` imports from `OAI.NumberTheory.DirichletL` (`#003`)** and complete the proof unconditionally using classical Montgomery zero-density bounds and Landau–Page single-prime deletion ([`thm_19`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L386-L400)).
- **Q3. "Because `PublishedSiegelBound` appears in `33` files of Engine A, is the proof intrinsically ineffective?"**
  - **Fact**: `32` of those `33` files forward `hSiegel` without unpacking it, and the single unpacking in `HadamardPrimeBound.lean:48` can be replaced unconditionally via Tatuzawa's theorem (`384,002`) plus 1 extra deleted prime ($|D_{\mathrm{ext}}| \le 3$), yielding an explicit effective log-log counterexample bound $L_{\mathrm{eff}} = 640,722$ (`255,983` ultra-sharp) ([`thm_46`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L476-L494)–[`thm_50`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L552-L562)).
- **Q4. "Does the closed-form definition of `sum_dyadic_log` in Engine B's `Scales.lean` invalidate the dyadic tree bound?"**
  - **Fact**: Engine A (`MovingFrequencyBudget.lean`) defines the finite sum over `Finset.range k`, and our independent theorems [`thm_21`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L30-L50)–[`thm_26`](../proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L132-L150) prove the exact equivalence $\sum_{j=0}^{k-1} j 2^j = (k-2)2^k + 2$ by structural induction (`induction k`) for all $k \in \mathbb{N}$.
- **Q5. "Does the docstring formula `K(ε) = ε^{-1/2}` in `QuadraticSplitSupply.lean:21` corrupt the kernel proof?"**
  - **Fact**: That formula appears only in a module docstring comment; the actual Lean proof term in [`SiegelBoundProof.lean:81`](../proofs/oai_ref/lean/OAI/NumberTheory/Ostmann/ZeroDensity/SiegelBoundProof.lean#L81) uses `K(ε) = 8 / (5 * ε) = 1600 >= 50` ([`thm_10`](../proofs/ostmann_twin_engines_and_supply_contraction.lean#L218-L238)).
- **Q6. "Is `#013` a degenerate/altered specification like `#376` (Navier–Stokes), or a genuine resolution of Ostmann's problem?"**
  - **Fact**: Unlike `#376`, `#013` formalizes the exact classical statement of Ostmann's Inverse Goldbach Problem ($|A|\ge 2 \wedge |B|\ge 2 \implies (A+B)\triangle\mathcal{P}$ infinite) over standard Mathlib `Nat.Prime` with `0 sorry` (`Gate 1 & Gate 5: PASS`). The non-conformances lie in repository duplication (`7,716` files), `381` unpruned fossils, citation starvation in Sections 7 & 9, and undisclosed `#021`/`#026` imports.

### 7.4 10-Second Terminal Reproduction (`Don't Trust, Verify`)

```bash
# 1) Compile all 75 standalone Lean 4 theorems (0 sorry) & run SymPy symbolic verification (EXIT 0)
~/.elan/bin/lean proofs/ostmann_twin_engines_and_supply_contraction.lean && \
  ~/.elan/bin/lean proofs/ostmann_tree_transfers_and_permutation_contradiction.lean && \
  ~/.elan/bin/lean proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean && \
  (cd proofs && python3 -B verify_symbolic_ostmann.py)

# 2) Verify all 6 SHA-256 checksums, 393/393 hypothesis mutations & #L line links (EXIT 0)
sha256sum -c proofs/checksums.sha256 && python3 -B ../../tools/verify_all.py --root .
```

### 7.5 Formal OPFF Referee Verdict Box

> **[Final Official Determination: `OPFF TIER C` (`Valid Mathematical Core & Non-Conforming Artifact Packaging`) — Mathematical Core (`Gate 1·5: PASS`) Recommended for Acceptance Subject to Twin-Engine Consolidation & Bibliographic Revision]**
>
> OpenAI `#013` (*The Primes Are Additively Indecomposable*) resolves Ostmann's 1950 Inverse Goldbach Problem (`Erdős #431`) in Lean 4 (`0 sorry`, `0 axiom`) over standard Mathlib definitions by combining finite-summand CRT composite witnesses, common rational center lifts and Bonami 4th-moment hypercontractivity, rank-2 squared transfer kernel ($K^2$, slope $2t_0 = 17/10 > 8/5$) Fourier supply contraction (`-11/125 < 0`), and quadratic affine collision factorization, $2\times 2$ Cauchy determinant non-vanishing ($\ge 1$), and dyadic tree permutation decay (`2/5 - 3/4 = -7/20 < 0`), satisfying **`Gate 1 (Kernel): PASS` and `Gate 5 (Mathematical Value): PASS`**.
>
> However, the submitted repository packaging and manuscript bibliography exhibit **(1) unpruned twin proof trees (`Complete.lean` `3,165` files vs. `Main.lean` `4,175` files, sharing `5` files = `0.065%`) and `381` unreachable fossil files (`39,517` lines, including `All.lean` and `PaperMain.lean`)**, **(2) closed-form dyadic sum declarations in Engine B `Scales.lean:51-73` and docstring formula drift (`ε^{-1/2}`) in `QuadraticSplitSupply.lean:21`**, and **(3) `0` citations across Sections 7 (`784` lines) and 9 (`386` lines), omission of primary sources (`Page 1935`, `Siegel 1935`, `Tatuzawa 1951`, `Schur 1917`, `Cauchy 1841`), and `18` undisclosed cross-family imports from `#021` and `#026`**, resulting in an artifact classification of **`OPFF TIER C`** pending twin-tree consolidation and bibliographic restoration.
