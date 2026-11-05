# 전문가 검증 가이드: 45개 Lean 4 정리, `344/344` 가설 돌연변이 시험, SHA-256 무결성 명세

> **대상 독자**: 형식 검증 엔지니어, Lean 4 심판관, 그리고 `Case 008`의 모든 증명 산출물을 로컬에서 직접 재현하고 해시를 대조하려는 감사자.

---

## 1. 재현 명령어

```bash
# 1. 단독 Lean 4 커널 검증 (0 sorry, 45개 정리 + 7개 def)
~/.elan/bin/lean proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean && \
  ~/.elan/bin/lean proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean && \
  ~/.elan/bin/lean proofs/qrh_trilogy_induction_and_algebraic_bridge.lean

# 2. 결정론적 SymPy 기호 검증
python3 proofs/verify_symbolic_qrh_synthesis.py

# 3. 전체 Ultari Proof Anatomy 검증 게이트 (SHA-256 + 344/344 돌연변이 시험 + 줄 번호 링크 + RH13~RH30)
python3 ../../tools/verify_all.py --root .
```

---

## 2. 증명 산출물 SHA-256 해시 명세

| 산출물 파일 | SHA-256 체크섬 |
| :--- | :--- |
| [`proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean) | `e9dc7e61b68c2e9650b566370ddcb61c78db6a455cbfa78fe41c01a8ecad4e06` |
| [`proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean) | `1bf3fedc64965d2c76917f08c994d2ee20fe0cbbc91e408d06b789408cbd16ca` |
| [`proofs/qrh_trilogy_induction_and_algebraic_bridge.lean`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean) | `7358f4ad1e7da151d70dc827ea0c0aaeafd449e8b1456d8a9379926a1f2af737` |
| [`proofs/verify_symbolic_qrh_synthesis.py`](../proofs/verify_symbolic_qrh_synthesis.py) | `1802f838d9251109e7a6329d895948149f6ff9dd5a4379a1cc44fa695cc04818` |
| [`proofs/symbolic_verification_result.json`](../proofs/symbolic_verification_result.json) | `d3d5a2ef03f796c24578ea54b2bf6cdd8cf013df327499464d9a4977698e713e` |
| [`proofs/problem_spec.md`](../proofs/problem_spec.md) | `b5b60157da94c3117fe821e80ccbfe90d40c6a79d176f68f7f5f846c128d975d` |

---

## 3. 45개 Lean 4 정리 1대1 대조표 (`344/344` 가설 돌연변이 적발)

### 파일 1: [`proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L1-L305)
- **정리 1**: [`thm_01_shortdraft_fixed_reserve_and_23_24_exponent`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L19-L33) : 하드코딩된 `1/20 < σ` 및 `σ = 1/10` (`H = Z^(11/10), Y = Z^(11/60)`)이 `137/120 - 11/60 = 23/24`를 생성함(`11/12` 폭의 절반).
- **정리 2**: [`thm_02_symbolic_sixth_power_cauchy_schwarz_exponent`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L38-L50) : 기호 6차 코시-슈바르츠 지수 `E_CS(θ) = (11 + 5θ)/12`.
- **정리 3**: [`thm_03_kontorovich_epsilon_split_exact_11_12`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L54-L64) : `(θ, η) = (6ε/5, ε/2)` 대입으로 `(11 + 5θ)/12 + η = 11/12 + ε` 정확 달성.
- **정리 4**: [`thm_04_canonical_descent_scale_budget_unlocks_arbitrary_theta`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L70-L85) : `CanonicalDescentScale` 예산 조건 `50 ≤ κ * denom_sym`을 만족시켜 임의의 `θ > 0` 허용.
- **정리 5**: [`thm_05_remainder_exponent_subdominance_and_crossover`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L90-L103) : 포아송/가분성 나머지 지수 `E_rem(θ) = (5 - θ)/6`의 열세 및 여백 `(1 + 7θ)/12 > 0`.
- **정리 6**: [`thm_06_sixth_power_fiber_cauchy_constant_768`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L108-L119) : 6제곱 올(fiber) 차수 `6`과 원판 상수 `128`의 곱 (`768 = 6 * 128` 대 `384 = 3 * 128`).
- **정리 7**: [`thm_07_totient_euler_correction_vs_prime_amplification_tradeoff`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L124-L134) : 국소 오일러 피 밀도 `(N_p - 1)/N_p ∈ [1/2, 1)` 및 `Re(s) > 0` 오일러 보정 수렴성.
- **정리 8**: [`thm_08_part_one_paper_tex_table_vs_shortdraft_gap`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L140-L154) : 미형식화된 `paper.tex` Part I 여백 표 `(1021/25000, 1/40, 1/1200, 43/300)`와 `ShortDraft` `1/24` 격차 비교.
- **정리 9**: [`thm_09_cubic_gauss_sieve_step_and_threshold_identities`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L165-L178) : `CubicGauss/Recurrence.lean`의 `sieveThreshold(α)` 및 `sieveStep(α)` 유리 항등식.
- **정리 10**: [`thm_10_cubic_gauss_quadratic_slack_and_attracting_fixed_point`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L182-L202) : 이차 여유분 `2(3p - 4q)^2 / (9q(3p - q)) > 0` 및 유일 매력 고정점 `α* = 4/3`.
- **정리 11**: [`thm_11_mobius_conjugacy_exact_closed_form_solution`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L206-L224) : 뫼비우스 공액 좌표 `u(α) = (α - 4/3)/(α - 1)`에서의 정확한 선형화 `u(sieveStep(α)) = (2/3) * u(α)`.
- **정리 12**: [`thm_12_nonlinear_vs_linearized_sieve_iterates_comparison`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L229-L247) : 비선형 정확 수열 `(2, 8/5, 28/19, 92/65)` 대 선형 상한 수열 `(2, 16/9, 44/27, 124/81)` 비교.
- **정리 13**: [`thm_13_short_four_thirds_and_reciprocity_symmetrization`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L252-L265) : `short_four_thirds` 및 3차 상호법칙 대칭화에 따른 `max(a, b, 2(a+b)/3)` 도출.
- **정리 14**: [`thm_14_scalar_bounds_epsilon_and_mixed_exponents`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L270-L284) : `CubicGauss/ScalarBounds.lean`의 단항식 지수 법칙(`mixed_one`, `mixed_two`, `scale_epsilon`).
- **정리 15**: [`thm_15_unimported_cubic_gauss_vs_bundled_cubic_gram_gap`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L289-L303) : 미연결된 30개 파일 `CubicGauss` (`6,252`줄, 외부 import `0`건)와 결합된 `CubicGram` 격차.

### 파일 2: [`proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L1-L313)
- **정리 16**: [`thm_16_shared_critical_quadratic_288_588_185_and_count_2_3`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L18-L34) : 공통 임계 이차방정식 `288δ_c^2 - 588δ_c + 185 = 0` (`δ_c = (49 - √921)/48`, `R(δ_c, 1/2) = 2/3`).
- **정리 17**: [`thm_17_case005_fixed_scale_saddle_vs_liu_rational_B_r`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L41-L54) : 엄격 순서 관계 `B_r = 34999/40000 < β_SOS(0) = (6843 - 7√921)/7578 < 41999/48000 < 7/8`.
- **정리 18**: [`thm_18_liu_three_face_equalization_in_Q_sqrt_921`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L59-L71) : `ℚ(√921)`에서의 3면 등화로 `ℓ_Liu = (33 + 8√921)/1653` 및 `B_Liu = (1507 - 2√921)/1653` 도출.
- **정리 19**: [`thm_19_exact_gap_between_fixed_scale_saddle_and_liu_optimum`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L77-L90) : 정확한 대수적 격차 `β_SOS(0) - B_Liu = (1195√921 - 36189)/4175478 > 0` (`1195^2 * 921 - 36189^2 = 5567304`).
- **정리 20**: [`thm_20_liu_gram_gate_parameter_b_new_and_margins`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L95-L111) : `0 < b_new < 1/8` 및 결합된 그램 게이트 조건 `y - ℓ - 11b/6 > 0` 성립 증명.
- **정리 21**: [`thm_21_farkas_dual_weights_and_closure_obstruction`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L116-L132) : 파카스 쌍대 가중치의 보편적 `(M, ℓ)` 소거 및 `(203 - 3√921)/(219 - 3√921) = B_Liu` 유리화.
- **정리 22**: [`thm_22_signal_matching_identity_and_face_K_origin`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L137-L149) : 신호 정합 항등식 `(11/12 - ℓ/4) - (4 + b)/6 = x/2 + b/12` 및 `Face_K`의 기원.
- **정리 23**: [`thm_23_complete_square_uniqueness_at_dc_and_u_half`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L154-L168) : `A_c(v)` 및 `disc(v)` 계수 양수성을 이용한 `(d, u) = (δ_c, 1/2)`에서의 완전제곱 유일성.
- **정리 24**: [`thm_24_parametric_unbundled_farkas_shift_theorem`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L179-L201) : 매개변수 파카스 이동 정리 `B*(Δ_0, Δ_K, Δ_H) = B_Liu - (w_0 Δ_0 + w_K Δ_K + w_H Δ_H)`.
- **정리 25**: [`thm_25_xu_sang_delta0_sixth_moment_breaks_liu_obstruction`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L206-L219) : `w_0 > 2/3` 및 `δ = 0` 6차 모멘트 절감으로 `B_Liu`를 `8748867/10000000`으로 낮춤.
- **정리 26**: [`thm_26_unbundled_gram_and_stickelberger_shift_breaks_face_H`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L224-L237) : 그램 결합 해제 + 슈티켈베르거 `z_high' = 7/20` 이동으로 `4103/4896` 및 `4069/4896` 달성.
- **정리 27**: [`thm_27_connecting_cubic_gauss_2_3_sieve_to_path_A_71_108`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L242-L253) : `CubicGauss`의 날카로운 `2/3` 큰 체(`R_eff = 7/9`)를 연결하여 Path-A 바닥 경계 `71/108` 도출.
- **정리 28**: [`thm_28_ten_tier_qrh_boundary_hierarchy`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L258-L275) : `1/2`부터 `23/24`까지의 10단계 영점 비존재 경계 엄격 순서 관계.
- **정리 29**: [`thm_29_zero_free_strip_width_progression_ratios`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L280-L293) : 영점 비존재 폭 배율 진행(`1x → 2x → 3x → 3.89x → 4.05x → 8.22x → 12x`).
- **정리 30**: [`thm_30_master_qrh_ecosystem_synthesis_verdict`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L298-L311) : 4대 축 전체를 결합한 마스터 생태계 합성 정리.

### 파일 3: [`proofs/qrh_trilogy_induction_and_algebraic_bridge.lean`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L1-L356)
- **정리 31**: [`thm_31_sieve_iter_mobius_invariants_by_induction`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L36-L69) : 모든 자연수 `n : Nat`에 대한 수학적 귀납법(`induction n`)으로 `mobiusNum (sieveIter n) = 2^(n+1)` 및 `mobiusDen (sieveIter n) = 3^n` 증명.
- **정리 32**: [`thm_32_sieve_iter_exact_closed_form_all_n`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L73-L86) : 모든 `n : Nat`에 대한 `CubicGauss` 비선형 점화식의 정확한 닫힌 해 `p_n = 4*3^n - 2^(n+1)`, `q_n = 3*3^n - 2^(n+1)` 도출.
- **정리 33**: [`thm_33_sieve_iter_strictly_beats_openai_sieve_exponent_all_n`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L92-L107) : 모든 `n : Nat`에서 선형 상한 분모 `9*3^n`과 실제 분모 `3*q_n`의 차이 `3*2^(n+1)` 증명.
- **정리 34**: [`thm_34_zsqrt921_norm_and_critical_quadratic_root`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L130-L137) : 이차 정역 `ℤ[√921]` 구조체 연산으로 `48δ_c = ⟨49, -1⟩`이 `288*(48δ_c)^2 - 588*48*(48δ_c) + 185*48^2 = ⟨0, 0⟩`을 만족함을 증명.
- **정리 35**: [`thm_35_zsqrt921_liu_rationalization_and_case005_gap`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L144-L157) : `ℤ[√921]` 켤레 곱으로 `B_Liu` 유리화 및 `Case 005`와의 격차 노름 `z921Norm ⟨-36189, 1195⟩ = -5567304 < 0` 증명.
- **정리 36**: [`thm_36_trilogy_denominator_bridge_3264_and_4896`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L167-L178) : 소수 기울기 `17` 브리지 (`17 * 96 = 1632 = gcd(3264, 4896)`, `d_001 = 2 * 1632 = 3264`, `d_005 = 3 * 1632 = 4896`).
- **정리 37**: [`thm_37_case001_margin_215_3264_drives_case005_4069_4896`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L185-L204) : 분자 `215` 항등식 `7/8 - 4069/4896 = 215/4896 = (2/3) * (215/3264)` 증명.
- **정리 38**: [`thm_38_case001_unbundling_breaks_case008_farkas_wall`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L212-L224) : `Case 001` 그람 결합 해제(`18/288 = 1/16`)가 `Case 008`의 `ℚ(√921)` 파카스 장벽을 돌파함을 증명.
- **정리 39**: [`thm_39_eisenstein_pole_duality_cubic_gauss_vs_coordR`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L232-L242) : `Case 008` `CubicGauss` 고정점 `α* = 4/3`과 `Case 005` `coordR` 극점 `β_pole = 2/3`의 쌍대성(`α* + β_pole = 2`) 및 `β_pole - 71/108 = 1/108`.
- **정리 40**: [`thm_40_cubic_gauss_plus_stickelberger_crosses_two_thirds`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L249-L257) : 슈티켈베르거 소멸자(`k_∞ = -6`, 순 극점 위수 `1 - 1 = 0`)를 통한 `β = 2/3` 장벽 돌파.
- **정리 41**: [`thm_41_case001_gauss_branch_vanishing_drives_case005_pole_shift`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L264-L277) : `Case 001` 가우스 분기 6/8 소멸(`1/6 → 1/12`)과 `Case 005` 극점 이동(`2/3 → 7/12 → 1/2`)의 일치.
- **정리 42**: [`thm_42_gap_between_71_108_and_7_12_equals_3264_over_44064`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L284-L292) : 공통분모 `44064`에서 `(71/108 - 7/12) * 44064 = 3264 = d_001` 일치 증명.
- **정리 43**: [`thm_43_eleven_twelfths_to_seven_eighths_bridge`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L299-L308) : 1부 `11/12` (`14/24 + 8/24 = 11/12`)에서 2부 `7/8` (`14/24 + 7/24 = 7/8`)로의 전이.
- **정리 44**: [`thm_44_six_stage_trilogy_telescoping_decomposition`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L316-L331) : 6단계 망원 합 `3672 + 1836 + 1935 + 5817 + 3264 + 3672 = 20196 = (23/24 - 1/2) * 44064`.
- **정리 45**: [`thm_45_grand_trilogy_synthesis_verdict`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L338-L355) : `Case 001` + `Case 005` + `Case 008` 3부작 통합 마스터 정리.
