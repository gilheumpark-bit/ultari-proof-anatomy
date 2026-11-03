# [Level 2: Intermediate Guide] 5 Core Forensic Problems and 27 Lean 4 Theorems Mapping

This guide maps the mathematical equations of OpenAI's `#032` withdrawn K3 manuscripts and `[EEMS13]` one-to-one against our Lean 4 formal proof suite (`proofs/k3_forensic_paths.lean`) and symbolic solver (`proofs/verify_symbolic_k3.py`).

---

## 1. The Symplectic Double-Bind Relation

In real source dimension $n = 2k$ ($k = 4$), `topology.tex:557` locks the intersection sign of every graded Lagrangian double point $x$ to the parity of its Maslov branch degree $|x|$:

$$\operatorname{sign}(x) = (-1)^k (-1)^{|x|}$$

- **Topological cancellation (`topology.tex`)** requires positive sign $+(-1)^k$, forcing $|x|$ to be **even** (`odd_degree_trace_sign_always_opposite`, `eliashberg_murphy_cancellation_fails`).
- **Curvature vanishing (`curvature.tex:159, 459, 533`)** requires avoiding degree $|x| \in \{2, 2k-2\}$, which fails at the non-loose unknot $\phi_0$ because the forward stabilization trace $G_1 : \phi_0 \to \phi_1$ produces $(|x_{12}|, |x_{21}|) = (2, 2k-2)$ (`eems_poincare_hopf_and_maslov_degrees`).

---

## 2. Five Core Forensic Problems (Problems 1-5) and Theorem Links

### Problem 1: Symplectic Double-Bind & `[EEMS13]` Poincaré-Hopf Sign Discrepancy (`Theorems 1-5, 12-13, 17`)
- **References**: `topology.tex:557`, `curvature.tex:159, 459, 533`, `min-intersectYETI-final.tex:410, 421, 694`
- **Equations**: On $U = D^{2k-1}$, the interior global maximum $x_{\max}$ of $\tilde{\phi} = \phi - 2h$ has odd Morse index $\operatorname{ind}_U(x_{\max}) = 2k - 1$ and cusp-adjusted effective index $\operatorname{ind}_{\mathrm{eff}} = 2k - 2$.
- **Verified Theorems**: `odd_maslov_degree_sign_always_negative`, `odd_degree_trace_sign_always_opposite`, `eliashberg_murphy_cancellation_fails`, `polterovich_surgery_maslov_obstruction`, `even_branch_generator_avoids_degree_two`, `eems_poincare_hopf_and_maslov_degrees`, `eems_chi_zero_stabilization_no_go`, `eems_opposite_sign_and_stokes_blindness`

### Problem 2: Surviving `Part I` Algebraic Clifford Reduction & Semiregularity Squeeze (`Theorems 6-9`)
- **References**: `exactks.tex:208-224, 264-373`, `auxiliary.tex:124-143`, `cohomology.tex:230-261`
- **Verified Theorems**: `exactks_4_7_10_degree_separation`, `auxiliary_6_9_12_degree_separation`, `semiregularity_injective_squeeze`, `zero_transcendental_component_breaks_ext2_bound`

### Problem 3: Shioda-Inose Central Fiber $B \times E^g$ ($\rho(B)=19$) Algebraic Obstructions (`Theorems 10-11`)
- **References**: `manuscript.tex:1166-1266`, `exactks.tex:125-136, 264-373`
- **Verified Theorems**: `shioda_inose_split_sum_obstruction_rank`, `yoneda_cone_atiyah_rank_no_go`

### Problem 4: Symplectic Deformation & Algebraic Descent Obstructions (`Theorems 14-16, 18, 20-27`)
- **Verified Theorems**: `maurer_cartan_forward_trace_obstruction`, `kummer_bkr_untwisted_deficit_and_clifford_gap`, `semihomogeneous_rank21_diagonal_ext2_overflow`, `kummer_bkr_fixed_point_atiyah_vanishing`, `clifford_spin_endomorphism_ext2_explosion`, `walsh_hadamard_decoupling_diagonal_ext2_no_go`, `ample_koszul_4_term_diagonal_and_section_overflow`, `mukai_semihomogeneous_projective_flatness_barrier`, `markman_secant_mukai_dimension_gap`, `additivity_vs_hyperkahler_rigidity_circularity`

### Problem 5: Bogomolov Discriminant Sign-Flip Obstruction & Pure-$E^g$ 4th-Degree Repair (`Theorem 19`)
- **References**: `exactks.tex:156-163`
- **Verified Theorem**: `bogomolov_mixed_discriminant_sign_flip_no_go`

---

## 3. Complete Index of All 27 Lean 4 Theorems (`proofs/k3_forensic_paths.lean`)

| Index | Line | Theorem Name | Tactic | Core Formalized Result |
| :---: | :---: | :--- | :---: | :--- |
| **Theorem 1** | `L9` | `odd_maslov_degree_sign_always_negative` | `induction; omega` | $(-1)^{2j+1} = -1$ for all $j \in \mathbb{N}$ |
| **Theorem 2** | `L23` | `odd_degree_trace_sign_always_opposite` | `induction; decide` | Odd Maslov degree gives sign $-(-1)^k \neq +(-1)^k$ (`topology.tex:557`) |
| **Theorem 3** | `L41` | `eliashberg_murphy_cancellation_fails` | `rw; omega` | $I(f_1) = -m < 0 \implies I_{\mathrm{new}} = -2m \neq 0$ |
| **Theorem 4** | `L51` | `polterovich_surgery_maslov_obstruction` | `omega` | Parity obstruction $2j \neq 2m+1, 1, 2k-1$ |
| **Theorem 5** | `L59` | `even_branch_generator_avoids_degree_two` | `omega` | Avoiding $\{2, 2k-2\}$ for even $2j$ requires $2 \le j \le k-2$ |
| **Theorem 6** | `L71` | `exactks_4_7_10_degree_separation` | `decide` | `4-7-10` operator degrees $[6,8,10,12,14,16,18,20,22]$ are distinct and $> 2$ |
| **Theorem 7** | `L79` | `auxiliary_6_9_12_degree_separation` | `decide` | `6-9-12` operator degrees $[10..26]$ are distinct and $> 6$ |
| **Theorem 8** | `L86` | `semiregularity_injective_squeeze` | `Int.le_antisymm` | Rank-nullity squeeze $\operatorname{rank}(\tau) = \dim\operatorname{Ext}^2 = b_2 - 19$ |
| **Theorem 9** | `L99` | `zero_transcendental_component_breaks_ext2_bound` | `omega` | Zero transcendental Mukai component forces $\dim\ker \le 5 < 19$ |
| **Theorem 10** | `L109` | `shioda_inose_split_sum_obstruction_rank` | `omega` | Split direct sum ($\ker(\alpha) \le 1$) forces $\dim\operatorname{Ext}^2 \ge b_2 - 1 > b_2 - 19$ |
| **Theorem 11** | `L124` | `yoneda_cone_atiyah_rank_no_go` | `omega` | 2-step Yoneda cone leaves $\ge 15$ directions of $N$ uncobounded |
| **Theorem 12** | `L141` | `eems_poincare_hopf_and_maslov_degrees` | `omega` | `[EEMS13]` `L421` vs `L410,694` parity discrepancy and $G_2=(1,2k-1), G_1=(2,2k-2)$ |
| **Theorem 13** | `L166` | `eems_chi_zero_stabilization_no_go` | `omega` | $\chi(U)=0$ forces $n_{\mathrm{even}} = n_{\mathrm{odd}} \ge 1$ and $\operatorname{SI} = 2n_{\mathrm{odd}} \ge 2$ |
| **Theorem 14** | `L178` | `maurer_cartan_forward_trace_obstruction` | `omega` | Maurer-Cartan degree mismatch $1+2=3 \neq 2$ and $\dim H^2 > b_2$ |
| **Theorem 15** | `L187` | `kummer_bkr_untwisted_deficit_and_clifford_gap` | `omega` | Kummer untwisted $\operatorname{HH}^2$ deficit $16$ and Clifford gap $2^9 - 1 = 511$ |
| **Theorem 16** | `L201` | `semihomogeneous_rank21_diagonal_ext2_overflow` | `omega` | 18 semi-homogeneous bundles exceed $2g^2 - g + 3$ for $g \ge 4$ |
| **Theorem 17** | `L218` | `eems_opposite_sign_and_stokes_blindness` | `omega` | Opposite-sign residual degree-2 point ($\operatorname{SI}=d_{\mathrm{pos}}+2$) and Stokes blindness |
| **Theorem 18** | `L233` | `kummer_bkr_fixed_point_atiyah_vanishing` | `omega` | Fixed-point pullback vanishing $\ker_{\mathrm{exc}}=0 \implies \ker_{\mathrm{total}} = 3 < 19$ |
| **Theorem 19** | `L247` | `bogomolov_mixed_discriminant_sign_flip_no_go` | `omega` | Zero pure-$E^g$ 4th-degree term ($\Delta_{\mathrm{lead}}=0$) forces $\Delta_- < 0$ |
| **Theorem 20** | `L260` | `clifford_spin_endomorphism_ext2_explosion` | `omega` | Unreduced $2^9$ Clifford spinor bundle gives $\dim\operatorname{End} = 2^{18} = 262,144$ overflow |
| **Theorem 21** | `L281` | `walsh_hadamard_decoupling_diagonal_ext2_no_go` | `omega` | Walsh-Hadamard decoupling ($\operatorname{Ext}^1_{\mathrm{cross}}=0$) and $\operatorname{Ext}^2 = 2,093,056 > 523,779$ |
| **Theorem 22** | `L303` | `ample_koszul_4_term_diagonal_and_section_overflow` | `omega` | 4-term ample Koszul ($r=3$) diagonal multiplicity $\ge 19$ and $\forall g \ge 4$ overflow ($2,485,504 > 523,779$) |
| **Theorem 23** | `L328` | `mukai_semihomogeneous_projective_flatness_barrier` | `omega` | $\forall g \ge 4, r \ge 1, M \ge 21$ Mukai projective flatness diagonal $\operatorname{Ext}^2$ overflow ($2,747,136 > 523,779$) |
| **Theorem 24** | `L355` | `markman_secant_mukai_dimension_gap` | `omega` | Markman secant sheaf $\mathfrak{so}(2,d)$ ($d \le 5$, rank $\le 7$) vs. K3 $\mathfrak{so}(2,19)$ ($21$) gap $\ge 14$ |
| **Theorem 25** | `L376` | `additivity_vs_hyperkahler_rigidity_circularity` | `omega` | $\forall g \ge 13, M \ge 21$ External additivity overflow ($2,747,136 > 523,779$) vs. Hyperkähler rigidity ($140,033 < 523,779$, $\operatorname{rank}(\phi^*)=0 < 21$) |
| **Theorem 26** | `L408` | `universal_mumford_diagonal_overflow_for_all_g_and_M` | `omega` | $\forall g \ge 5, M \ge 5$ Universal Mumford diagonal $\operatorname{Ext}^2$ overflow from unfactored definitions ($654,080 > 523,779$ at $g=512, M=5$) |
| **Theorem 27** | `L438` | `universal_g1_branch_stokes_and_kummer_moduli_no_go` | `omega` | $\forall k \ge 3, d \ge 1$ $G_1$ local degree-1 branch absence (`2≠1, 2k-2≥4≠1`), Stokes point vanishing ($0<2k-2$), and generalized Kummer deficit ($22-7=15, 17-1=16$) |
