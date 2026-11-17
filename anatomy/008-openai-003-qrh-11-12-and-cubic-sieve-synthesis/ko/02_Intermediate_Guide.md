# 중급 가이드: $\text{Re}(s) > 11/12$ 스케일링 아키텍처, CubicGauss/ 귀납적 해법, 그리고 5대 합성 기둥

- 대상 독자: 해석적 정수론, 디리클레 급수, 또는 Lean 4 형식화에 익숙하며, `DirichletL`이 왜 $\text{Re}(s) > 23/24$에서 멈췄는지, `CubicGauss`의 비선형 체 점화식이 어떻게 모든 $n \in \mathbb{N}$에서 풀리는지, 그리고 제1부(7/8 ShortDraft 감사)·제2부(심판관·비묶음 그람 감사)·제3부(11/12 및 CubicGauss 통합)가 어떻게 연결되는지 코드 수준에서 추적하고 싶은 분.



## 1. 제1기둥: 왜 `DirichletL/RowCompletion/ZeroFreeRegion.lean`은 $23/24$까지만 증명하는가?

OpenAI의 `first-proof` 저장소에는 디리클레 $L$-함수에 대한 두 개의 서로 다른 목표 정리가 공존합니다:

| 항목 | 원본 `DirichletL/RowCompletion/ZeroFreeRegion.lean` (ShortDraft) | `paper2.tex` & `AlexKontorovich/quasi-rh` |
|---|---|---|
| 최상위 목표 정리 | `ShortDraft.DirichletTarget` (`DirichletL/RowCompletion/ZeroFreeRegion.lean:197–214`, `DirichletL/Arithmetic/EisensteinCoordinates.lean:253`) | `dirichletL_ne_zero_of_gt_eleven_twelfths` (`DirichletL/ElevenTwelfths/Unconditional.lean:118–137`, `paper2.tex:74`) |
| 영점 비존재 영역 | $\text{Re}(s) > 23/24 \approx 0.95833$ | $\text{Re}(s) > 11/12 \approx 0.91667$ |
| 영점 비존재 폭 ($1 - \beta_0$) | $1/24 \approx 0.04167$ | $1/12 \approx 0.08333$ (정확히 2배) |
| 예비 여백(reserve) | $\frac{1}{20}$ 하드코딩 (`DirichletL/CubicSieve/ClosedRecursion.lean:120`) | `CanonicalDescentScale` (`50 ≤ reserve * denom`) |
| 코시-슈바르츠 지수 | $\frac{11 + 5(1/10)}{12} = \frac{23}{24}$ (`DirichletL/PrimeRows/NormFiberExtraction.lean:343`) | $\frac{11 + 5\vartheta}{12} + \eta = \frac{11}{12} + \varepsilon$ |

### 1.1 하드코딩된 $\sigma = 1/10$ 사슬 추적

1. `CubicSieve/ClosedRecursion.lean:120`:
   이차 잉여 기호(quadratic symbol) 하강 단계에서 분모 `denominator = 1000`과 예비 여백 $\text{reserve} = \frac{1}{20}$을 상수로 고정했습니다.
2. `MeanSquare/ThetaDensity.lean:93`:
   위의 $\text{reserve} = \frac{1}{20}$ 조건 때문에, 평균제곱 밀도 정리 `exists_C_theta_density`에 `hσ_low : (1 : ℝ) / 20 < σ`라는 하한선이 박혔습니다.
3. `Mellin/SixthPowerAverage.lean:331` (`outside_totient_moebius_bound`):
   $\sigma > \frac{1}{20}$을 만족시키기 위해 구체적 수치 $\sigma = \vartheta = 1/10$을 대입했습니다.
4. `PrimeRows/NormFiberExtraction.lean:343` (`exists_good_dyadic_scale_zpow`):
   $\vartheta = 1/10$에서 6차 모멘트 창 크기 $H = Z^{1 + \vartheta} = Z^{11/10}$, 체 절단 크기 $Y = H^{1/6} = Z^{11/60}$이 결정됩니다. 이때 코시-슈바르츠 부등식을 적용하면 지수가 다음과 같이 고정됩니다([thm_01_shortdraft_fixed_reserve_and_23_24_exponent](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L25-L38), [thm_02_symbolic_sixth_power_cauchy_schwarz_exponent](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L44-L55)):
   $$E_{\mathrm{CS}}(\vartheta) = \frac{2 + \vartheta - \frac{1+\vartheta}{6}}{2} = \frac{11 + 5\vartheta}{12} \xrightarrow{\vartheta = 1/10} \frac{137}{120} - \frac{11}{60} = \frac{23}{24}.$$

### 1.2 `CanonicalDescentScale`과 $(\vartheta, \eta) = (6\varepsilon/5, \varepsilon/2)$ 스케일링

`paper2.tex`와 `AlexKontorovich/quasi-rh`에서는 고정된 $\text{denominator} = 1000,\; \text{reserve} = \frac{1}{20}$을 다음 불변량으로 교체합니다([thm_04_canonical_descent_scale_budget_unlocks_arbitrary_theta](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L76-L92)):
$$\text{CanonicalDescentScale}: \quad \text{reserve} \cdot \text{denominator} \ge 50.$$
임의의 $\vartheta > 0$에 대해 예비 여백을 $\kappa = \vartheta / 2$로 잡고 분모를 $D = \lceil 100/\vartheta \rceil + 1$로 잡으면 $\kappa D > 50$이 항상 성립하고 $\vartheta > \kappa$이므로 하한선 제약이 사라집니다. 임의의 목표 여백 $\varepsilon \in (0, 1/12)$에 대해 $\vartheta = \frac{6}{5}\varepsilon$, $\eta = \frac{1}{2}\varepsilon$으로 설정하면 목표치를 정확히 맞춥니다([thm_03_kontorovich_epsilon_split_exact_11_12](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L60-L70), [thm_05_remainder_exponent_subdominance_and_crossover](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L98-L110)):
$$E_{\mathrm{CS}}\!\left(\frac{6}{5}\varepsilon\right) + \frac{1}{2}\varepsilon = \frac{11 + 6\varepsilon}{12} + \frac{6\varepsilon}{12} = \frac{11}{12} + \varepsilon.$$
또한 매끄러운 고리 영역의 모든 아이젠슈타인 정수 $b$에 대해 $b^6$ 가중 평균을 취하면(`cauchy_const = 6 * 128 = 768`), 란다우의 소 아이디얼 정리를 완전히 우회합니다([thm_06_sixth_power_fiber_cauchy_constant_768](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L116-L126), [thm_07_totient_euler_correction_vs_prime_amplification_tradeoff](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L132-L142), [thm_08_part_one_paper_tex_table_vs_shortdraft_gap](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L148-L161)).



## 2. 제2기둥: 미연결 `OAI/NumberTheory/CubicGauss/` (30개 파일, 6,252줄) 해독

`lean/OAI/NumberTheory/CubicGauss/` 디렉터리에는 30개의 Lean 파일(총 6,252줄, 0 sorry)이 들어 있으며, 날카로운 3차 큰 체 부등식 `cubic_large_sieve`를 무조건부로 증명합니다. 그러나 `DirichletL`(2,926개 파일)이나 `CubicMoment`(3,549개 파일)에서는 `CubicGauss`를 단 한 줄도 import하지 않았습니다([thm_15_unimported_cubic_gauss_vs_bundled_cubic_gram_gap](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L297-L311)).

- `sieveThreshold`와 `sieveStep` ([thm_09_cubic_gauss_sieve_step_and_threshold_identities](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L173-L185)):
  $$\text{sieveThreshold}(\alpha) = \frac{6\alpha - 5}{3\alpha - 1}, \qquad \text{sieveStep}(\alpha) = \frac{6\alpha - 4}{3\alpha - 1}.$$
- 이차 여유분과 뫼비우스 공액 선형화 ([thm_10_cubic_gauss_quadratic_slack_and_attracting_fixed_point](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L190-L209), [thm_11_mobius_conjugacy_exact_closed_form_solution](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L214-L232)):
  OpenAI는 느슨한 선형 상한 $\alpha_n = \frac{4}{3} + \left(\frac{2}{3}\right)^{n+1}$을 썼지만, 뫼비우스 변환 $u(\alpha) = \frac{\alpha - 4/3}{\alpha - 1}$을 도입하면 $u(\text{sieveStep}(\alpha)) = \frac{2}{3}u(\alpha)$로 오차 0의 등비수열이 됩니다([thm_12_nonlinear_vs_linearized_sieve_iterates_comparison](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L237-L254), [thm_13_short_four_thirds_and_reciprocity_symmetrization](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L260-L272), [thm_14_scalar_bounds_epsilon_and_mixed_exponents](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L278-L290)).



## 3. 제3·4기둥: $\mathbb{Q}(\sqrt{921})$ 대수적 통합과 매개변수 파카스 결합 해제

제2부와 Baiying Liu의 `arXiv:2610.12234`(`geometry/V2Optimization.lean`)에서 6차 모멘트 개수 함수가 $u = 1/2$에서 목표치 $2/3$와 만나는 방정식은 $288\,d^2 - 588\,d + 185 = 0$이며, 그 근은 $\delta_c = \frac{49 - \sqrt{921}}{48}$입니다([thm_16_shared_critical_quadratic_288_588_185_and_count_2_3](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L24-L42)).
- $(b, \ell) = (1/8, 1/6)$을 고정하면 제2부의 안장점 $\beta_{\mathrm{SOS}}(0) = \frac{6843 - 7\sqrt{921}}{7578}$이 나오고([thm_17_case005_fixed_scale_saddle_vs_liu_rational_B_r](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L49-L61)), $(b, \ell)$을 움직여 3면을 등화하면 $B_{\mathrm{Liu}} = \frac{1507 - 2\sqrt{921}}{1653}$이 나옵니다([thm_18_liu_three_face_equalization_in_Q_sqrt_921](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L67-L78)–[thm_23_complete_square_uniqueness_at_dc_and_u_half](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L162-L174)).
- 세 면에 절감량 $(\Delta_0, \Delta_K, \Delta_H)$를 도입하면 파카스 최적해가 $B^*(\Delta_0, \Delta_K, \Delta_H) = B_{\mathrm{Liu}} - (w_0\Delta_0 + w_K\Delta_K + w_H\Delta_H)$만큼 이동하여 10단계 계보 전체가 도출됩니다([thm_24_parametric_unbundled_farkas_shift_theorem](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L187-L211)–[thm_30_master_qrh_ecosystem_synthesis_verdict](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L308-L321)).



## 4. 제5기둥: 전 구간 수학적 귀납법(`induction n`), $\mathbb{Z}[\sqrt{921}]$ 정역, 그리고 준리만 가설 3단계 통합 브리지

[proofs/qrh_trilogy_induction_and_algebraic_bridge.lean](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean)(정리 31–45)에서는 유한 단계 검증을 넘어 전 구간 수학적 귀납법과 3부작 통합 정리를 구축했습니다:
- 모든 $n \in \mathbb{N}$에 대한 `sieveIter` 수학적 귀납법 (`induction n`): 재귀함수 `sieveIter : Nat → Nat × Nat`에 대해 $3p_n - 4q_n = 2^{n+1}$ 및 $p_n - q_n = 3^n$을 귀납법으로 증명하고([thm_31_sieve_iter_mobius_invariants_by_induction](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L36-L69)), 닫힌 해 $p_n = 4\cdot 3^n - 2^{n+1}$, $q_n = 3\cdot 3^n - 2^{n+1}$([thm_32_sieve_iter_exact_closed_form_all_n](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L73-L86))과 분모 격차 $9\cdot 3^n - 3q_n = 3\cdot 2^{n+1}$([thm_33_sieve_iter_strictly_beats_openai_sieve_exponent_all_n](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L92-L107))을 증명했습니다.
- 이차 정역 $\mathbb{Z}[\sqrt{921}]$ 구조체 (`structure ZSqrt921`): 환 곱셈 `z921Mul`, 켤레 `z921Conj`, 노름 `z921Norm`을 정의하여 $48\delta_c = \langle 49, -1\rangle$의 근 항등식([thm_34_zsqrt921_norm_and_critical_quadratic_root](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L130-L138))과 유리화·격차 노름 $-5567304 < 0$([thm_35_zsqrt921_liu_rationalization_and_case005_gap](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L144-L157))을 증명했습니다.
- $3264 \leftrightarrow 4896 \leftrightarrow 215 \leftrightarrow 44064$ 3부작 대수적 브리지 (제1부 + 제2부 + 제3부):
  1. 제1부의 소수 기울기 17이 $17 \times 96 = 1632 = \gcd(3264, 4896)$($d_{001} = 2\times 1632$, $d_{005} = 3\times 1632$)을 생성하고([thm_36_trilogy_denominator_bridge_3264_and_4896](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L167-L178)), 제1부의 여백 $\frac{215}{3264}$에 큰 체 가중치 $\frac{2}{3}$를 곱하면 정확히 $\frac{7}{8} - \frac{4069}{4896} = \frac{215}{4896}$가 됩니다([thm_37_case001_margin_215_3264_drives_case005_4069_4896](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L185-L205), [thm_38_case001_unbundling_breaks_case008_farkas_wall](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L212-L225)).
  2. 제3부의 `CubicGauss` 고정점 $\alpha^{\ast} = \frac{4}{3}$과 제2부의 극점 $\beta_{\mathrm{pole}} = \frac{2}{3}$는 $\alpha^{\ast} + \beta_{\mathrm{pole}} = 2$ 쌍대이며, 공통분모 $44064$ 위에서 $\left(\frac{71}{108} - \frac{7}{12}\right)\times 44064 = 3264 = d_{001}$이 성립합니다([thm_39_eisenstein_pole_duality_cubic_gauss_vs_coordR](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L232-L243)–[thm_45_grand_trilogy_synthesis_verdict](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L338-L354)).




## 5. 원문 참조 파일 26개(100.0%) 전수 1대1 매핑 총람 (`proofs/oai_ref/`)

[proofs/oai_ref/](../proofs/oai_ref/Endpoint.lean)에 수록된 전체 26개 Lean 4 파일(3,319줄, 178 / 178개 선언 = 100.0%)과 본 3부작 통합 감사의 45개 형식 정리 간 1대1 대응표입니다:

| 번호 | 원문 참조 파일 (`proofs/oai_ref/`) | 줄 수 | 선언 수 | 대응 3부작 통합 정리 | 핵심 수리·통합 역할 |
| :---: | :--- | :---: | :---: | :--- | :--- |
| 01 | [SiegelZeros/Structure/ArithmeticCutoffTransport.lean](../proofs/oai_ref/ArithmeticCutoffTransport.lean#L1-L524) | 524 | 33 | `thm_28` (L268), `thm_30` (L308), `thm_45` (L338) | `actualCutoffSpanning_of_localBezout`, `rowSpan_top_of_field_map` 및 직사각 상자 베주(Bézout) 절단 전달 |
| 02 | [SiegelZeros/Intersection/BezoutBoundary.lean](../proofs/oai_ref/BezoutBoundary.lean#L1-L27) | 27 | 1 | `thm_28` (L268), `thm_30` (L308), `thm_45` (L338) | 고립 베주 배제로부터 도출되는 균일 배제 정리 `uniform_exclusion_of_local_isolated_bezout` |
| 03 | [DirichletL/Detector/CentralExponent.lean](../proofs/oai_ref/CentralExponent.lean#L1-L104) | 104 | 12 | `thm_16` (L24), `thm_17` (L49), `thm_18` (L67), `thm_19` (L85), `thm_23` (L162), `thm_34` (L130), `thm_35` (L144) | 중심 지수 `sourceExponent`, `relativeExponent`, `d ≤ 13/16 + ζ` 및 `d ≤ 5/6` 장벽, `realLoss`, `physical_scale_identity` |
| 04 | [DirichletL/Detector/CorrectionBounds.lean](../proofs/oai_ref/CorrectionBounds.lean#L1-L87) | 87 | 4 | `thm_07` (L132), `thm_26` (L234), `thm_39` (L232), `thm_40` (L249) | 비분기 표시 오차 상한 `unramified_marked_error_bound` 및 `continuedCorrection_defect_bound` (`inv_one_sub_norm_le_two`) |
| 05 | [DirichletL/PrimeRows/CubeFloorSaving.lean](../proofs/oai_ref/CubeFloorSaving.lean#L1-L81) | 81 | 2 | `thm_14` (L278), `thm_16` (L24), `thm_27` (L252) | `51/100` 절단 임계치 및 `7/1200` 총 예산에서 증명한 `actual_floor_cube_saving`과 `savingFloorPoolOutside` |
| 06 | [DirichletL/Endpoint.lean](../proofs/oai_ref/Endpoint.lean#L1-L113) | 113 | 13 | `thm_16` (L24), `thm_17` (L49), `thm_18` (L67), `thm_19` (L85), `thm_21` (L124), `thm_34` (L130), `thm_35` (L144) | 유리수 제곱합(SOS) 항등식 `endpoint_identity`, `balancedExponent`, `balanced_endpoint_margin`, `balanced_endpoint_strict` (`0 ≤ y ≤ 1/2`) |
| 07 | [DirichletL/Detector/Euler.lean](../proofs/oai_ref/Euler.lean#L1-L48) | 48 | 4 | `thm_07` (L132), `thm_39` (L232), `thm_40` (L249) | 표시 인자 `markedFactor`, `markedTableSeries`, `marked_table_resummation` 및 `unramified_marked_error` |
| 08 | [DirichletL/Detector/EulerCoordinates.lean](../proofs/oai_ref/EulerCoordinates.lean#L1-L84) | 84 | 14 | `thm_26` (L234), `thm_39` (L232), `thm_40` (L249), `thm_41` (L264) | 원문 좌표 `coordR = A * Q^(4 - 6x - 6z)` 및 `coordV`, `coordW`, `coordD`, `coordK`, `actualUnramifiedClosed` 정의·노름 상한 |
| 09 | [SiegelZeros/Estimates/GeometricBoundary.lean](../proofs/oai_ref/GeometricBoundary.lean#L1-L56) | 56 | 1 | `thm_28` (L268), `thm_30` (L308), `thm_45` (L338) | 지겔 영점 기하 경계 `uniform_exclusion_of_actual_cutoff` (`H = 86,713,344`, `N_0 = 18,818`) |
| 10 | [DirichletL/Detector/GramBound.lean](../proofs/oai_ref/GramBound.lean#L1-L99) | 99 | 1 | `thm_15` (L297), `thm_20` (L103), `thm_21` (L124), `thm_24` (L187), `thm_26` (L234), `thm_38` (L212) | $0 < \delta < 1$ 구간 가법 그람 상한 `actual_additive_gram_bound` |
| 11 | [DirichletL/Detector/GramScaleLoss.lean](../proofs/oai_ref/GramScaleLoss.lean#L1-L39) | 39 | 2 | `thm_17` (L49), `thm_36` (L167), `thm_37` (L185), `thm_38` (L212), `thm_42` (L284) | 매개변수 $(M, P, Y)$ 위 비예외 스케일 항등식 `nonexceptional_scale_identity` 및 손실 부등식 `nonexceptional_scale_loss` |
| 12 | [DirichletL/Detector/HighRowsCentralQuotient.lean](../proofs/oai_ref/HighRowsCentralQuotient.lean#L1-L52) | 52 | 2 | `thm_07` (L132), `thm_28` (L268) | `480 ≤ Q` 및 `51/100 ≤ a ≤ 1`에서 고행 중앙 몫 하한 `unramifiedClosed_central_lower`와 `unramifiedSelected_central_quotient` |
| 13 | [DirichletL/Detector/HighRowsCentralTerms.lean](../proofs/oai_ref/HighRowsCentralTerms.lean#L1-L119) | 119 | 1 | `thm_22` (L145), `thm_24` (L187), `thm_41` (L264) | `51/100 ≤ alpha ≤ 1`, `0 < eps ≤ 1/1000`, `goodLambda ∉ (p)`, `ringChar ≠ 2` 조건하 `sourceRowTerm_central_nonstrict` |
| 14 | [DirichletL/Detector/HighRowsScalar.lean](../proofs/oai_ref/HighRowsScalar.lean#L1-L81) | 81 | 4 | `thm_14` (L278), `thm_41` (L264) | 스칼라 접속 인자 `row_even_kzero`, `row_nonprincipal_kzero`, `row_squarefree_kone`, `row_nonprincipal_kone` |
| 15 | [DirichletL/Detector/HighRowsTail.lean](../proofs/oai_ref/HighRowsTail.lean#L1-L76) | 76 | 4 | `thm_41` (L264), `thm_44` (L316) | `gaussValuationTable_above` ($6 \mid r$), `positiveScalar_stable_large`, `rowMarkedTerm_base_tail` 및 `rowInner_base_rational` |
| 16 | [DirichletL/Detector/HighRowsUnramified.lean](../proofs/oai_ref/HighRowsUnramified.lean#L1-L90) | 90 | 4 | `thm_07` (L132), `thm_39` (L232) | `goodLambda ∉ (p)`, `ringChar ≠ 2`, `rho^6 = 1` 조건하 `rowMarkedTerm_unramified`, `rowMarkedSeries_unramified`, `rowClosedMarked_unramified`, `sourceRowSeries_unramified_euler` |
| 17 | [SiegelZeros/Intersection/IsolatedBezoutFromRegularSelection.lean](../proofs/oai_ref/IsolatedBezoutFromRegularSelection.lean#L1-L373) | 373 | 16 | `thm_28` (L268), `thm_30` (L308), `thm_45` (L338) | 정칙 열 선택으로부터 고립 베주 교차 도출(`localIsolatedBezout_of_actual_regular_selection`, `torus_local_length_le_of_local_isolated_bezout`, `affine_local_regular_list_bezout`) |
| 18 | [DirichletL/Detector/Local.lean](../proofs/oai_ref/Local.lean#L1-L98) | 98 | 12 | `thm_07` (L132), `thm_39` (L232), `thm_40` (L249) | 국소 오일러 인자 $1 - V$ 소거, `continuedCorrection_eq_raw` 및 `normalized_cancellation` |
| 19 | [DirichletL/Detector/LowGramScale.lean](../proofs/oai_ref/LowGramScale.lean#L1-L53) | 53 | 4 | `thm_09` (L173), `thm_15` (L297), `thm_20` (L103), `thm_27` (L252), `thm_38` (L212) | 보상 그람 비율 `compensated_gram_ratio`, `compensated_gram_scale_bound`, `source_gram_power`, `source_gram_sqrt_power` |
| 20 | [DirichletL/Detector/LowSourceScales.lean](../proofs/oai_ref/LowSourceScales.lean#L1-L108) | 108 | 7 | `thm_04` (L76), `thm_17` (L49), `thm_36` (L167), `thm_37` (L185) | `source_scale_ratio`, `source_compensated_scale_admissible`, `lowGramFactor_source_bound` 및 `eventually_compensated_source_scales` |
| 21 | [DirichletL/Parameters.lean](../proofs/oai_ref/Parameters.lean#L1-L66) | 66 | 4 | `thm_17` (L49), `thm_18` (L67), `thm_19` (L85), `thm_20` (L103), `thm_35` (L144), `thm_37` (L185) | `compensated_geometry` (`0 ≤ d ≤ 1/6`), `exists_height_cutoff`, `exists_tail_order`, `cumulative_frequency_bound` |
| 22 | [DirichletL/ParametersHighData.lean](../proofs/oai_ref/ParametersHighData.lean#L1-L114) | 114 | 2 | `thm_24` (L187), `thm_28` (L268), `thm_44` (L316) | 임의의 `0 < Δ`에 대해 고행 매개변수 구조체 `HighData` 존재성을 증명하는 `exists_high_data` |
| 23 | [SiegelZeros/Selection/PivotBounds.lean](../proofs/oai_ref/PivotBounds.lean#L1-L96) | 96 | 1 | `thm_28` (L268), `thm_30` (L308), `thm_45` (L338) | 이중이차 클라인 4-군 토러스 제트 가중 스케일링 $H^{-1}$ 및 지겔 피벗 임계치 `N_0 = 18,818` (`source_pivot_bounds`) |
| 24 | [DirichletL/Detector/PrincipalRemainderBounds.lean](../proofs/oai_ref/PrincipalRemainderBounds.lean#L1-L640) | 640 | 25 | `thm_05` (L98), `thm_22` (L145), `thm_26` (L234), `thm_41` (L264) | `window_sharp_bound`, `full_scale_bound` ($\upsilon \in [19/20, 2]$), `residue_scale_bound`, `source_remainders_strict_saving` |
| 25 | [DirichletL/Detector/ScalarTable.lean](../proofs/oai_ref/ScalarTable.lean#L1-L64) | 64 | 4 | `thm_14` (L278), `thm_41` (L264) | 6차 가우스 합 가중치 표 `gaussValuationTable`, `actualSextic_gaussValuationTable`, `positiveScalar_actual_table`, `zero_index_scalar` |
| 26 | [SiegelZeros/Conclusions/Theorem.lean](../proofs/oai_ref/Theorem.lean#L1-L27) | 27 | 1 | `thm_28` (L268), `thm_29` (L290), `thm_30` (L308), `thm_43` (L299), `thm_44` (L316), `thm_45` (L338) | 지겔 영점 절대 실영점 간극 정리 `exists_absolute_real_zero_gap` |
