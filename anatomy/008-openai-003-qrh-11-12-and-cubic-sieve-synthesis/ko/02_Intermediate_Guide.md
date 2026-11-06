# 중급 가이드: $\text{Re}(s) > 11/12$ 스케일링 아키텍처, `CubicGauss/` 귀납적 해법, 그리고 5대 합성 기둥

> **대상 독자**: 해석적 정수론, 디리클레 급수, 또는 Lean 4 형식화에 익숙하며, `DirichletL`이 왜 $\text{Re}(s) > 23/24$에서 멈췄는지, `CubicGauss`의 비선형 체 점화식이 어떻게 모든 $n \in \mathbb{N}$에서 풀리는지, 그리고 `Case 001`·`Case 005`·`Case 008`이 어떻게 연결되는지 코드 수준에서 추적하고 싶은 분.

---

## 1. 제1기둥: 왜 `DirichletL/RowCompletion/ZeroFreeRegion.lean`은 $23/24$까지만 증명하는가?

OpenAI의 `first-proof` 저장소에는 디리클레 $L$-함수에 대한 두 개의 서로 다른 목표 정리가 공존합니다:

| 항목 | 원본 `DirichletL/RowCompletion/ZeroFreeRegion.lean` (`ShortDraft`) | `paper2.tex` & `AlexKontorovich/quasi-rh` |
|---|---|---|
| 최상위 목표 정리 | `ShortDraft.DirichletTarget` (`ZeroFreeRegion.lean:197–214`, `EisensteinCoordinates.lean:253`) | `dirichletL_ne_zero_of_gt_eleven_twelfths` (`Unconditional.lean:118–137`, `paper2.tex:74`) |
| 영점 비존재 영역 | $\text{Re}(s) > 23/24 \approx 0.95833$ | $\text{Re}(s) > 11/12 \approx 0.91667$ |
| 영점 비존재 폭 ($1 - \beta_0$) | $1/24 \approx 0.04167$ | $1/12 \approx 0.08333$ (**정확히 2배**) |
| 예비 여백(`reserve`) | `1/20` 하드코딩 (`ClosedRecursion.lean:120`) | `CanonicalDescentScale` (`50 ≤ reserve * denom`) |
| 코시-슈바르츠 지수 | $\frac{11 + 5(1/10)}{12} = \frac{23}{24}$ (`NormFiberExtraction.lean:343`) | $\frac{11 + 5\vartheta}{12} + \eta = \frac{11}{12} + \varepsilon$ |

### 1.1 하드코딩된 $\sigma = 1/10$ 사슬 추적

1. **`CubicSieve/ClosedRecursion.lean:120`**:
   이차 잉여 기호(quadratic symbol) 하강 단계에서 분모 `denominator = 1000`과 예비 여백 `reserve = 1 / 20`을 상수로 고정했습니다.
2. **`MeanSquare/ThetaDensity.lean:93`**:
   위의 `reserve = 1/20` 조건 때문에, 평균제곱 밀도 정리 `exists_C_theta_density`에 `hσ_low : (1 : ℝ) / 20 < σ`라는 하한선이 박혔습니다.
3. **`Mellin/SixthPowerAverage.lean:331` (`outside_totient_moebius_bound`)**:
   $\sigma > 1/20$을 만족시키기 위해 구체적 수치 $\sigma = \vartheta = 1/10$을 대입했습니다.
4. **`PrimeRows/NormFiberExtraction.lean:343` (`exists_good_dyadic_scale_zpow`)**:
   $\vartheta = 1/10$에서 6차 모멘트 창 크기 $H = Z^{1 + \vartheta} = Z^{11/10}$, 체 절단 크기 $Y = H^{1/6} = Z^{11/60}$이 결정됩니다. 이때 코시-슈바르츠 부등식을 적용하면 지수가 다음과 같이 고정됩니다([`thm_01_shortdraft_fixed_reserve_and_23_24_exponent`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L19-L33), [`thm_02_symbolic_sixth_power_cauchy_schwarz_exponent`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L38-L50)):
   $$E_{\mathrm{CS}}(\vartheta) = \frac{2 + \vartheta - \frac{1+\vartheta}{6}}{2} = \frac{11 + 5\vartheta}{12} \xrightarrow{\vartheta = 1/10} \frac{137}{120} - \frac{11}{60} = \frac{23}{24}.$$

### 1.2 `CanonicalDescentScale`과 $(\vartheta, \eta) = (6\varepsilon/5, \varepsilon/2)$ 스케일링

`paper2.tex`와 `AlexKontorovich/quasi-rh`에서는 고정된 `denominator = 1000, reserve = 1/20`을 다음 불변량으로 교체합니다([`thm_04_canonical_descent_scale_budget_unlocks_arbitrary_theta`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L70-L85)):
$$\text{CanonicalDescentScale}: \quad \text{reserve} \cdot \text{denominator} \ge 50.$$
임의의 $\vartheta > 0$에 대해 예비 여백을 $\kappa = \vartheta / 2$로 잡고 분모를 $D = \lceil 100/\vartheta \rceil + 1$로 잡으면 $\kappa D > 50$이 항상 성립하고 $\vartheta > \kappa$이므로 하한선 제약이 사라집니다. 임의의 목표 여백 $\varepsilon \in (0, 1/12)$에 대해 $\vartheta = \frac{6}{5}\varepsilon$, $\eta = \frac{1}{2}\varepsilon$으로 설정하면 목표치를 정확히 맞춥니다([`thm_03_kontorovich_epsilon_split_exact_11_12`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L54-L64), [`thm_05_remainder_exponent_subdominance_and_crossover`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L90-L103)):
$$E_{\mathrm{CS}}\!\left(\frac{6}{5}\varepsilon\right) + \frac{1}{2}\varepsilon = \frac{11 + 6\varepsilon}{12} + \frac{6\varepsilon}{12} = \frac{11}{12} + \varepsilon.$$
또한 매끄러운 고리 영역의 모든 아이젠슈타인 정수 $b$에 대해 $b^6$ 가중 평균을 취하면(`cauchy_const = 6 * 128 = 768`), 란다우의 소 아이디얼 정리를 완전히 우회합니다([`thm_06_sixth_power_fiber_cauchy_constant_768`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L108-L119), [`thm_07_totient_euler_correction_vs_prime_amplification_tradeoff`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L124-L134), [`thm_08_part_one_paper_tex_table_vs_shortdraft_gap`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L140-L154)).

---

## 2. 제2기둥: 미연결 `OAI/NumberTheory/CubicGauss/` (30개 파일, 6,252줄) 해독

`lean/OAI/NumberTheory/CubicGauss/` 디렉터리에는 30개의 Lean 파일(총 6,252줄, `0 sorry`)이 들어 있으며, 날카로운 3차 큰 체 부등식 `cubic_large_sieve`를 무조건부로 증명합니다. 그러나 `DirichletL`(2,926개 파일)이나 `CubicMoment`(3,549개 파일)에서는 `CubicGauss`를 단 한 줄도 `import`하지 않았습니다([`thm_15_unimported_cubic_gauss_vs_bundled_cubic_gram_gap`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L289-L303)).

- **`sieveThreshold`와 `sieveStep` ([`thm_09_cubic_gauss_sieve_step_and_threshold_identities`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L165-L178))**:
  $$\text{sieveThreshold}(\alpha) = \frac{6\alpha - 5}{3\alpha - 1}, \qquad \text{sieveStep}(\alpha) = \frac{6\alpha - 4}{3\alpha - 1}.$$
- **이차 여유분과 뫼비우스 공액 선형화 ([`thm_10_cubic_gauss_quadratic_slack_and_attracting_fixed_point`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L182-L202), [`thm_11_mobius_conjugacy_exact_closed_form_solution`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L206-L224))**:
  OpenAI는 느슨한 선형 상한 $\alpha_n = \frac{4}{3} + \left(\frac{2}{3}\right)^{n+1}$을 썼지만, 뫼비우스 변환 $u(\alpha) = \frac{\alpha - 4/3}{\alpha - 1}$을 도입하면 $u(\text{sieveStep}(\alpha)) = \frac{2}{3}u(\alpha)$로 **오차 0의 등비수열**이 됩니다([`thm_12_nonlinear_vs_linearized_sieve_iterates_comparison`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L229-L247), [`thm_13_short_four_thirds_and_reciprocity_symmetrization`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L252-L265), [`thm_14_scalar_bounds_epsilon_and_mixed_exponents`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L270-L284)).

---

## 3. 제3·4기둥: $\mathbb{Q}(\sqrt{921})$ 대수적 통합과 매개변수 파카스 결합 해제

`Case 005`와 Baiying Liu의 `arXiv:2610.12234`(`geometry/V2Optimization.lean`)에서 6차 모멘트 개수 함수가 $u = 1/2$에서 목표치 $2/3$와 만나는 방정식은 $288\,d^2 - 588\,d + 185 = 0$이며, 그 근은 $\delta_c = \frac{49 - \sqrt{921}}{48}$입니다([`thm_16_shared_critical_quadratic_288_588_185_and_count_2_3`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L18-L34)).
- $(b, \ell) = (1/8, 1/6)$을 고정하면 `Case 005`의 안장점 $\beta_{\mathrm{SOS}}(0) = \frac{6843 - 7\sqrt{921}}{7578}$이 나오고([`thm_17_case005_fixed_scale_saddle_vs_liu_rational_B_r`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L41-L54)), $(b, \ell)$을 움직여 3면을 등화하면 $B_{\mathrm{Liu}} = \frac{1507 - 2\sqrt{921}}{1653}$이 나옵니다([`thm_18_liu_three_face_equalization_in_Q_sqrt_921`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L59-L71)–[`thm_23_complete_square_uniqueness_at_dc_and_u_half`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L154-L168)).
- 세 면에 절감량 $(\Delta_0, \Delta_K, \Delta_H)$를 도입하면 파카스 최적해가 $B^*(\Delta_0, \Delta_K, \Delta_H) = B_{\mathrm{Liu}} - (w_0\Delta_0 + w_K\Delta_K + w_H\Delta_H)$만큼 이동하여 10단계 계보 전체가 도출됩니다([`thm_24_parametric_unbundled_farkas_shift_theorem`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L179-L201)–[`thm_30_master_qrh_ecosystem_synthesis_verdict`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L298-L311)).

---

## 4. 제5기둥: 전 구간 수학적 귀납법(`induction n`), $\mathbb{Z}[\sqrt{921}]$ 정역, 그리고 `001`·`005`·`008` 3부작 브리지

[`proofs/qrh_trilogy_induction_and_algebraic_bridge.lean`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L1-L356)(`정리 31–45`)에서는 유한 단계 검증을 넘어 전 구간 수학적 귀납법과 3부작 통합 정리를 구축했습니다:
- **모든 $n \in \mathbb{N}$에 대한 `sieveIter` 수학적 귀납법 (`induction n`)**: 재귀함수 `sieveIter : Nat → Nat × Nat`에 대해 $3p_n - 4q_n = 2^{n+1}$ 및 $p_n - q_n = 3^n$을 귀납법으로 증명하고([`thm_31_sieve_iter_mobius_invariants_by_induction`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L36-L69)), 닫힌 해 $p_n = 4\cdot 3^n - 2^{n+1}$, $q_n = 3\cdot 3^n - 2^{n+1}$([`thm_32_sieve_iter_exact_closed_form_all_n`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L73-L86))과 분모 격차 $9\cdot 3^n - 3q_n = 3\cdot 2^{n+1}$([`thm_33_sieve_iter_strictly_beats_openai_sieve_exponent_all_n`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L92-L107))을 증명했습니다.
- **이차 정역 $\mathbb{Z}[\sqrt{921}]$ 구조체 (`structure ZSqrt921`)**: 환 곱셈 `z921Mul`, 켤레 `z921Conj`, 노름 `z921Norm`을 정의하여 $48\delta_c = \langle 49, -1\rangle$의 근 항등식([`thm_34_zsqrt921_norm_and_critical_quadratic_root`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L130-L137))과 유리화·격차 노름 $-5567304 < 0$([`thm_35_zsqrt921_liu_rationalization_and_case005_gap`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L144-L157))을 증명했습니다.
- **`3264` $\leftrightarrow$ `4896` $\leftrightarrow$ `215` $\leftrightarrow$ `44064` 3부작 대수적 브리지 (`Case 001` + `Case 005` + `Case 008`)**:
  1. `Case 001`의 소수 기울기 `17`이 $17 \times 96 = 1632 = \gcd(3264, 4896)$($d_{001} = 2\times 1632$, $d_{005} = 3\times 1632$)을 생성하고([`thm_36_trilogy_denominator_bridge_3264_and_4896`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L167-L178)), `Case 001`의 여백 $\frac{215}{3264}$에 큰 체 가중치 $\frac{2}{3}$를 곱하면 정확히 $\frac{7}{8} - \frac{4069}{4896} = \frac{215}{4896}$가 됩니다([`thm_37_case001_margin_215_3264_drives_case005_4069_4896`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L185-L204), [`thm_38_case001_unbundling_breaks_case008_farkas_wall`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L212-L224)).
  2. `Case 008`의 `CubicGauss` 고정점 $\alpha^* = \frac{4}{3}$과 `Case 005`의 극점 $\beta_{\mathrm{pole}} = \frac{2}{3}$는 $\alpha^* + \beta_{\mathrm{pole}} = 2$ 쌍대이며, 공통분모 $44064$ 위에서 $\left(\frac{71}{108} - \frac{7}{12}\right)\times 44064 = 3264 = d_{001}$이 성립합니다([`thm_39_eisenstein_pole_duality_cubic_gauss_vs_coordR`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L232-L242)–[`thm_45_grand_trilogy_synthesis_verdict`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L338-L355)).


---

## 7. 원문 참조 파일 26개(`100.0%`) 전수 1대1 매핑 총람 (`proofs/oai_ref/`)

[`proofs/oai_ref/`](../proofs/oai_ref/Endpoint.lean)에 수록된 전체 26개 Lean 4 파일(`3,319`줄, `178 / 178`개 선언 = `100.0%`)과 본 3부작 통합 패키지의 45개 형식 정리 간 1대1 대응표입니다:

| 번호 | 원문 참조 파일 (`proofs/oai_ref/`) | 줄 수 | 선언 수 | 대응 3부작 통합 정리 | 핵심 수리·통합 역할 |
| :---: | :--- | :---: | :---: | :--- | :--- |
| `01` | [`ArithmeticCutoffTransport.lean`](../proofs/oai_ref/ArithmeticCutoffTransport.lean#L1-L524) | `524` | `33` | `thm_28` (`L258`), `thm_30` (`L298`), `thm_45` (`L338`) | Siegel-zero arithmetic cutoff transport (`cutoff_transport`) from Bézout identity to `PivotBounds` |
| `02` | [`BezoutBoundary.lean`](../proofs/oai_ref/BezoutBoundary.lean#L1-L27) | `27` | `1` | `thm_28` (`L258`), `thm_30` (`L298`), `thm_45` (`L338`) | Bézout homogenization cone and degree boundary (`bezout_boundary`, `homogenized_cone`) |
| `03` | [`CentralExponent.lean`](../proofs/oai_ref/CentralExponent.lean#L1-L104) | `104` | `12` | `thm_16` (`L18`), `thm_17` (`L41`), `thm_18` (`L59`), `thm_19` (`L77`), `thm_23` (`L154`), `thm_34` (`L130`), `thm_35` (`L144`) | Central exponent `sourceExponent`, `ℚ(√921)` critical quadratic `288δ² - 588δ + 185 = 0`, and `d ≤ 1/2` barrier |
| `04` | [`CorrectionBounds.lean`](../proofs/oai_ref/CorrectionBounds.lean#L1-L87) | `87` | `4` | `thm_07` (`L124`), `thm_26` (`L224`), `thm_39` (`L232`), `thm_40` (`L249`) | Local Euler correction bounds (`Q ≥ 128` vs `Q ≥ 480`) and non-`R` error exponents |
| `05` | [`CubeFloorSaving.lean`](../proofs/oai_ref/CubeFloorSaving.lean#L1-L81) | `81` | `2` | `thm_14` (`L270`), `thm_16` (`L18`), `thm_27` (`L242`) | Cube-free vs square-full floor source saving (`37/72` threshold and `floorSourceMargin`) |
| `06` | [`Endpoint.lean`](../proofs/oai_ref/Endpoint.lean#L1-L113) | `113` | `13` | `thm_16` (`L18`), `thm_17` (`L41`), `thm_18` (`L59`), `thm_19` (`L77`), `thm_21` (`L116`), `thm_34` (`L130`), `thm_35` (`L144`) | `balancedExponent`, irrational `ℚ(√921)` saddle vs rational SOS anchor `δ_SOS = 79/204`, and 7-monomial certificate |
| `07` | [`Euler.lean`](../proofs/oai_ref/Euler.lean#L1-L48) | `48` | `4` | `thm_07` (`L124`), `thm_39` (`L232`), `thm_40` (`L249`) | Euler factor `(1 - V)` marked cancellation and second continuation `continuedCorrection` |
| `08` | [`EulerCoordinates.lean`](../proofs/oai_ref/EulerCoordinates.lean#L1-L84) | `84` | `14` | `thm_26` (`L224`), `thm_39` (`L232`), `thm_40` (`L249`), `thm_41` (`L264`) | Stickelberger-Eisenstein coordinate `coordR` (`k_∞ = -6 ≠ 0`) breaking the `β = 2/3` pole wall |
| `09` | [`GeometricBoundary.lean`](../proofs/oai_ref/GeometricBoundary.lean#L1-L56) | `56` | `1` | `thm_28` (`L258`), `thm_30` (`L298`), `thm_45` (`L338`) | Siegel-zero geometric boundary (`H = 86,713,344`) and conditional `h_geometry` discharge |
| `10` | [`GramBound.lean`](../proofs/oai_ref/GramBound.lean#L1-L99) | `99` | `1` | `thm_15` (`L289`), `thm_20` (`L95`), `thm_21` (`L116`), `thm_24` (`L179`), `thm_26` (`L224`), `thm_38` (`L212`) | 3-mode Gram decomposition (`E - Z - E_exc`), Farkas dual weights `(9,6,2)/17`, and unbundling shift `1/16` |
| `11` | [`GramScaleLoss.lean`](../proofs/oai_ref/GramScaleLoss.lean#L1-L39) | `39` | `2` | `thm_17` (`L41`), `thm_36` (`L167`), `thm_37` (`L185`), `thm_38` (`L212`), `thm_42` (`L284`) | 3-tier non-exceptional Gram relaxation losses (`181/3264`, `215/3264`, `487/3264`) and `3264 ↔ 4896` bridge |
| `12` | [`HighRowsCentralQuotient.lean`](../proofs/oai_ref/HighRowsCentralQuotient.lean#L1-L52) | `52` | `2` | `thm_07` (`L124`), `thm_28` (`L258`) | Bad-prime mask absorbing wild (`Q=3`) and char-2 (`Q=4`) primes across `[3, 128)` |
| `13` | [`HighRowsCentralTerms.lean`](../proofs/oai_ref/HighRowsCentralTerms.lean#L1-L119) | `119` | `1` | `thm_22` (`L137`), `thm_24` (`L179`), `thm_41` (`L264`) | 9-branch high-row thresholds and signal-matching origin of Face `K` (`1 - d - α_X/3`) |
| `14` | [`HighRowsScalar.lean`](../proofs/oai_ref/HighRowsScalar.lean#L1-L81) | `81` | `4` | `thm_14` (`L270`), `thm_41` (`L264`) | Scalar continuation multipliers and branch-by-branch residue weights feeding `HighRowsCentralTerms` |
| `15` | [`HighRowsTail.lean`](../proofs/oai_ref/HighRowsTail.lean#L1-L76) | `76` | `4` | `thm_41` (`L264`), `thm_44` (`L316`) | High-row tail truncation (`m ≥ 2`, `6/8` branches vanish identically via `J = j + 6m ≥ 12 > n+1`) |
| `16` | [`HighRowsUnramified.lean`](../proofs/oai_ref/HighRowsUnramified.lean#L1-L90) | `90` | `4` | `thm_07` (`L124`), `thm_39` (`L232`) | Eisenstein sextic power-residue symbol unramified condition `Q ≥ 7` (`Q ≡ 1 mod 6`) |
| `17` | [`IsolatedBezoutFromRegularSelection.lean`](../proofs/oai_ref/IsolatedBezoutFromRegularSelection.lean#L1-L373) | `373` | `16` | `thm_28` (`L258`), `thm_30` (`L298`), `thm_45` (`L338`) | Isolated Bézout intersection from regular sequence selection (`regular_selection`) |
| `18` | [`Local.lean`](../proofs/oai_ref/Local.lean#L1-L98) | `98` | `12` | `thm_07` (`L124`), `thm_39` (`L232`), `thm_40` (`L249`) | Local Euler polynomial `(1 - V)` cancellation and 5-pole simultaneous continuation |
| `19` | [`LowGramScale.lean`](../proofs/oai_ref/LowGramScale.lean#L1-L53) | `53` | `4` | `thm_09` (`L165`), `thm_15` (`L289`), `thm_20` (`L95`), `thm_27` (`L242`), `thm_38` (`L212`) | Bundled `11/12` cubic Gram scale vs unimported `CubicGauss` `2/3` large sieve (`R_eff = 7/9 → 71/108`) |
| `20` | [`LowSourceScales.lean`](../proofs/oai_ref/LowSourceScales.lean#L1-L108) | `108` | `7` | `thm_04` (`L70`), `thm_17` (`L41`), `thm_36` (`L167`), `thm_37` (`L185`) | Constant-`B` absorption slack `B ≤ Z^{1/16}` vs uninflated scales `(29/84, 11/21)` |
| `21` | [`Parameters.lean`](../proofs/oai_ref/Parameters.lean#L1-L66) | `66` | `4` | `thm_17` (`L41`), `thm_18` (`L59`), `thm_19` (`L77`), `thm_20` (`L95`), `thm_35` (`L144`), `thm_37` (`L185`) | Fixed scales `(17/48, 23/48, 1/6)` (`4069/4896`) vs Baiying Liu `ℚ(√921)` free-scale optimum |
| `22` | [`ParametersHighData.lean`](../proofs/oai_ref/ParametersHighData.lean#L1-L114) | `114` | `2` | `thm_24` (`L179`), `thm_28` (`L258`), `thm_44` (`L316`) | 7-term error budget admissibility at `β = 0.5001` and 3-way dyadic contraction |
| `23` | [`PivotBounds.lean`](../proofs/oai_ref/PivotBounds.lean#L1-L96) | `96` | `1` | `thm_28` (`L258`), `thm_30` (`L298`), `thm_45` (`L338`) | Biquadratic Klein 4-group torus jet weight scaling `H^{-1}` and Siegel pivot threshold `N_0 = 18,818` |
| `24` | [`PrincipalRemainderBounds.lean`](../proofs/oai_ref/PrincipalRemainderBounds.lean#L1-L640) | `640` | `25` | `thm_05` (`L90`), `thm_22` (`L137`), `thm_26` (`L224`), `thm_41` (`L264`) | Double-contour `w = 19/20` vs `z = 33/200` residue separation and signal offset `29/36 - α_X/3` |
| `25` | [`ScalarTable.lean`](../proofs/oai_ref/ScalarTable.lean#L1-L64) | `64` | `4` | `thm_14` (`L270`), `thm_41` (`L264`) | 8-branch sextic Gauss sum table (`(j, m, d)` indices) and vanishing for `m ≥ 2` |
| `26` | [`Theorem.lean`](../proofs/oai_ref/Theorem.lean#L1-L27) | `27` | `1` | `thm_28` (`L258`), `thm_29` (`L280`), `thm_30` (`L298`), `thm_43` (`L299`), `thm_44` (`L316`), `thm_45` (`L338`) | Top-level QRH `β = 7/8` synthesis and 10-tier boundary hierarchy (`23/24 → 11/12 → 7/8 → 71/108 → 1/2`) |
