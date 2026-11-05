# 고급 가이드: 전 구간 수학적 귀납법(`induction n`), $\mathbb{Z}[\sqrt{921}]$ 대수적 통합, 매개변수 파카스 쌍대성, 그리고 `001`·`005`·`008` 3부작 브리지

> **대상 독자**: 해석적 정수론 연구자, 형식 검증 전문가, 그리고 `CubicGauss` 비선형 점화식의 전 구간 귀납법 증명, $\mathbb{Z}[\sqrt{921}]$ 정역 연산, 매개변수 파카스 쌍대성, 및 `Case 001`·`Case 005`·`Case 008` 3부작이 어떻게 단일 대수적 불변량으로 통합되는지 확인하고 싶은 분.

---

## 1. `CubicGauss` 비선형 점화식의 뫼비우스 공액 선형화 및 모든 $n \in \mathbb{N}$에 대한 수학적 귀납법 증명 (`정리 9–14, 31–33`)

`lean/OAI/NumberTheory/CubicGauss/Recurrence.lean:350–370`에서 정의된 3차 큰 체 지수 점화식은 다음과 같습니다:
$$\text{sieveThreshold}(\alpha) = \frac{6\alpha - 5}{3\alpha - 1}, \qquad \text{sieveStep}(\alpha) = \frac{6\alpha - 4}{3\alpha - 1}.$$
OpenAI의 `LargeSieve.lean:75`는 $\text{sieveStep}(\alpha)$를 느슨한 등비 상한선 $\alpha_n = \frac{4}{3} + \left(\frac{2}{3}\right)^{n+1}$로 근사했습니다. 그러나 $\alpha = p/q > 4/3$($\delta = 3p - 4q > 0$, $D = 3p - q$)에서 1단계마다 버려지는 정확한 이차 여유분은 양수입니다([`thm_10_cubic_gauss_quadratic_slack_and_attracting_fixed_point`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L182-L202)):
$$\frac{2}{3}\left(\alpha - \frac{4}{3}\right) - \left(\text{sieveStep}(\alpha) - \frac{4}{3}\right) = \frac{2(3p - 4q)^2}{9q(3p - q)} = \frac{2\delta^2}{9qD} > 0.$$
고정점 방정식 $3\alpha^2 - 7\alpha + 4 = (3\alpha - 4)(\alpha - 1) = 0$의 두 근 $\alpha^* = 4/3$, $\alpha^{**} = 1$을 이용해 뫼비우스 좌표 $u(\alpha) = \frac{\alpha - 4/3}{\alpha - 1} = \frac{3p - 4q}{3(p - q)}$를 도입하면, $\alpha' = p'/q' = \frac{6p - 4q}{3p - q}$에 대해([`thm_11_mobius_conjugacy_exact_closed_form_solution`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L206-L224)):
$$3p' - 4q' = 3(6p - 4q) - 4(3p - q) = 2(3p - 4q), \qquad p' - q' = (6p - 4q) - (3p - q) = 3(p - q)$$
가 성립하여 $u(\text{sieveStep}(\alpha)) = \frac{2}{3}u(\alpha)$로 **오차 0의 선형 공액**이 됩니다.

[`proofs/qrh_trilogy_induction_and_algebraic_bridge.lean`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L14-L107)에서는 재귀함수 `sieveIter (n : Nat) : Nat × Nat`:
$$\text{sieveIter}(0) = (2, 1), \qquad \text{sieveIter}(n+1) = (6p_n - 4q_n,\; 3p_n - q_n)$$
및 `mobiusNum(p, q) = 3p - 4q`, `mobiusDen(p, q) = p - q`를 정의하고, $n \in \mathbb{N}$에 대한 **구조적 수학적 귀납법**(`induction n with | zero => ... | succ k ih => ...`)으로 모든 자연수 $n \ge 0$에 대해 다음 세 정리를 증명했습니다:
1. **전 구간 뫼비우스 불변량 ([`thm_31_sieve_iter_mobius_invariants_by_induction`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L36-L69))**:
   $$3p_n - 4q_n = 2^{n+1}, \qquad p_n - q_n = 3^n.$$
2. **모든 $n \in \mathbb{N}$에 대한 정확한 닫힌 해 ([`thm_32_sieve_iter_exact_closed_form_all_n`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L73-L86))**:
   $$p_n = 4\cdot 3^n - 2^{n+1}, \qquad q_n = 3\cdot 3^n - 2^{n+1}, \qquad \tilde{\alpha}_n = \frac{p_n}{q_n} = \frac{4\cdot 3^n - 2^{n+1}}{3\cdot 3^n - 2^{n+1}} = \frac{\frac{4}{3} - \left(\frac{2}{3}\right)^{n+1}}{1 - \left(\frac{2}{3}\right)^{n+1}}.$$
3. **OpenAI 선형 상한 수열 대비 보편적 우위 ([`thm_33_sieve_iter_strictly_beats_openai_sieve_exponent_all_n`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L92-L107), [`thm_12_nonlinear_vs_linearized_sieve_iterates_comparison`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L229-L247))**:
   $$\tilde{\alpha}_n - \frac{4}{3} = \frac{2^{n+1}}{3q_n}, \qquad \alpha_n - \frac{4}{3} = \frac{2^{n+1}}{3^{n+1}}, \qquad 9\cdot 3^n - 3q_n = 3\cdot 2^{n+1} > 0, \qquad \lim_{n\to\infty} \frac{\tilde{\alpha}_n - 4/3}{\alpha_n - 4/3} = \frac{1}{3}.$$

---

## 2. $\mathbb{Z}[\sqrt{921}]$ 이차 정역과 파카스 쌍대 가중치의 보편적 $(M, \ell)$-소거 (`정리 16–23, 34–35`)

### 2.1 임계 이차방정식 $288\delta_c^2 - 588\delta_c + 185 = 0$과 `ZSqrt921` 정역 (`thm_16`, `thm_34`)
6차 모멘트 개수 상한 $R(d, u)$가 최악 단면 $u = 1/2$에서 날카로운 3차 큰 체 목표치 $R(\delta_c, 1/2) = 2/3$와 만나는 방정식은 $288\delta_c^2 - 588\delta_c + 185 = 0$이며, 그 근은 $\delta_c = \frac{49 - \sqrt{921}}{48}$입니다([`thm_16_shared_critical_quadratic_288_588_185_and_count_2_3`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L18-L34)).

[`proofs/qrh_trilogy_induction_and_algebraic_bridge.lean`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L112-L157)에서는 이차 정역 $\mathbb{Z}[\sqrt{921}]$을 `structure ZSqrt921`(`⟨a, b⟩ = a + b√921`)로 형식화하고 환 곱셈 `z921Mul`, 켤레 `z921Conj`, 노름 `z921Norm x = x.a^2 - 921*x.b^2`를 정의하여 다음을 증명했습니다:
- **정역 내 정확한 근 확인 ([`thm_34_zsqrt921_norm_and_critical_quadratic_root`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L130-L137))**: $X = 48\delta_c = \langle 49, -1\rangle$에 대해 $\operatorname{Norm}(X) = 49^2 - 921 = 1480 = 8 \times 185$이고 $288 X^2 - 588\cdot 48 X + 185\cdot 48^2 = \langle 0, 0\rangle$.
- **켤레 곱 유리화 및 `Case 005` 대 Liu 격차 노름 ([`thm_35_zsqrt921_liu_rationalization_and_case005_gap`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L144-L157), [`thm_19_exact_gap_between_fixed_scale_saddle_and_liu_optimum`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L77-L90))**:
  $$\langle 203, -3\rangle \cdot \langle 219, 3\rangle = \langle 36168, -48\rangle = 24 \cdot \langle 1507, -2\rangle, \qquad \operatorname{Norm}(\langle 219, -3\rangle) = 39672 = 24 \times 1653$$
  으로부터 $B_{\mathrm{Liu}} = \frac{1507 - 2\sqrt{921}}{1653}$이 도출되며, `Case 005` 안장점과의 차이 $\beta_{\mathrm{SOS}}(0) - B_{\mathrm{Liu}} = \frac{1195\sqrt{921} - 36189}{4175478}$의 분자 원소 $\langle -36189, 1195\rangle$는 노름이 $-36189^2 - 921\times 1195^2 = -5567304 < 0$이므로 엄격히 양수입니다.

### 2.2 파카스 쌍대 가중치와 매개변수 이동 정리 (`thm_21`–`thm_30`)
세 활성 면 $\text{Face}_0, \text{Face}_K, \text{Face}_H$에 대해 파카스 쌍대 가중치
$$w_0(\delta_c) = \frac{4 + 18\delta_c}{9 + 18\delta_c}, \qquad w_K(\delta_c) = \frac{2}{9 + 18\delta_c}, \qquad w_H(\delta_c) = \frac{3}{9 + 18\delta_c}$$
는 **임의의 $\delta_c$에 대해 $(M, \ell)$을 항등 소거**하며([`thm_21_farkas_dual_weights_and_closure_obstruction`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L116-L132)), 각 면의 비음수 절감량 $(\Delta_0, \Delta_K, \Delta_H)$에 대해 최적 경계를 정확히 선형 이동시킵니다([`thm_24_parametric_unbundled_farkas_shift_theorem`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L179-L201)–[`thm_30_master_qrh_ecosystem_synthesis_verdict`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L298-L311)):
$$B^*(\Delta_0, \Delta_K, \Delta_H) = B_{\mathrm{Liu}} - \left(w_0\,\Delta_0 + w_K\,\Delta_K + w_H\,\Delta_H\right).$$

---

## 3. `Case 001` $\leftrightarrow$ `Case 005` $\leftrightarrow$ `Case 008` 3부작 대수적 브리지 (`정리 36–45`)

[`proofs/qrh_trilogy_induction_and_algebraic_bridge.lean`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L162-L355)에서는 우리의 리만 관련 3개 리포트가 왜 동일한 소수 인자와 분모를 공유하는지 10개의 정리(`thm_36`–`thm_45`)로 증명합니다:

1. **소수 기울기 `17`과 `3264` $\leftrightarrow$ `4896` 분모 브리지 ([`thm_36_trilogy_denominator_bridge_3264_and_4896`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L167-L178))**:
   `Case 001`에서 발굴한 성분별 그람 지수 $\frac{14 + 17\delta}{96}$의 소수 기울기 `17`과 분모 `96`의 곱이 3부작 기본 단위 $17 \times 96 = 1632 = \gcd(3264, 4896)$을 형성하며, $d_{001} = 2 \times 1632 = 3264$, $d_{005} = 3 \times 1632 = 4896$으로 정확히 $2 : 3$ 비율을 이룹니다.
2. **분자 `215` 보존 법칙: `Case 001`의 $\frac{215}{3264}$가 `Case 005`의 $\frac{4069}{4896}$을 구동함 ([`thm_37_case001_margin_215_3264_drives_case005_4069_4896`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L185-L204), [`thm_38_case001_unbundling_breaks_case008_farkas_wall`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L212-L224))**:
   교차점 $\delta_{\max} = \frac{15}{34}$에서 `Case 001`이 확보한 총 결합 해제 여백은 $\frac{215}{3264}$입니다. 여기에 3차 큰 체 가중치 $\frac{2}{3}$를 곱하면:
   $$\frac{7}{8} - \frac{4069}{4896} = \frac{4284 - 4069}{4896} = \frac{215}{4896} = \frac{2}{3} \times \frac{215}{3264}.$$
   즉 `Case 005`의 3항 결합 해제 경계 $\frac{4069}{4896}$가 $7/8$에서 내려간 폭 $\frac{215}{4896}$는 **`Case 001`의 여백 $\frac{215}{3264}$에 정확히 $\frac{2}{3}$를 곱한 값**입니다.
3. **아이젠슈타인 극점 쌍대성 $\alpha^* + \beta_{\mathrm{pole}} = 2$ 및 `3264 / 44064` 항등식 ([`thm_39_eisenstein_pole_duality_cubic_gauss_vs_coordR`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L232-L242)–[`thm_42_gap_between_71_108_and_7_12_equals_3264_over_44064`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L284-L292))**:
   - `Case 008`의 `CubicGauss` 수렴 고정점 $\alpha^* = \frac{4}{3}$와 `Case 005`의 `coordR` 극점 장벽 $\beta_{\mathrm{pole}} = \frac{2}{3}$는 $\alpha^* + \beta_{\mathrm{pole}} = 2$ 쌍대 관계를 만족하며, `CubicGauss`를 연결한 바닥 경계 $\frac{71}{108}$는 $\beta_{\mathrm{pole}} = \frac{72}{108}$를 $\frac{1}{108}$만큼 돌파합니다.
   - 동시에 `Case 001`의 가우스 분기 6/8 소멸($\frac{1}{6} \to \frac{1}{12}$, 절감량 $\frac{1}{12}$)과 `Case 005`의 슈티켈베르거 소멸자($k_\infty = -6$, 순 극점 위수 $1 - 1 = 0$)가 극점 장벽을 $\frac{2}{3} \to \frac{7}{12} \to \frac{1}{2}$로 이동시킵니다.
   - 3부작 최소공배수 분모 $44064 = \operatorname{lcm}(24, 4896, 108) = 9 \times 4896$ 위에서 $\frac{71}{108}$과 이동된 극점 $\frac{7}{12}$ 사이의 거리는 정확히 `Case 001`의 분모 $d_{001} = 3264$입니다:
     $$\left(\frac{71}{108} - \frac{7}{12}\right) \times 44064 = 28968 - 25704 = 3264 = d_{001}.$$
4. **6단계 망원 분해와 $\beta = 1/2$ (`0.5`) 도달을 위한 엄밀한 범위 경계 ([`thm_43_eleven_twelfths_to_seven_eighths_bridge`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L299-L308)–[`thm_45_grand_trilogy_synthesis_verdict`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L338-L355))**:
   공통분모 $44064$ 위에서 $\frac{23}{24}$부터 $\frac{1}{2}$까지의 전체 폭 $20196$은 6단계 정수 폭으로 분해됩니다:
   $$1836 + 1836 + 1935 + 7653 + 3264 + 3672 = 20196 = \left(\frac{23}{24} - \frac{1}{2}\right) \times 44064.$$
   - **기존 `0 sorry` 모듈 조립으로 달성 가능한 영역 (`1~4단계`, 합계 $13260 / 44064 \to \beta = 71/108 \approx 0.6574$ 및 $\beta = 2/3$ 극점 제거)**: 가변 하강 스케일($1836$), 3차 모멘트 전환($1836$), 그램 결합 해제 + 슈티켈베르거 이동($1935$), 미연결 `CubicGauss` 연결($7653$)로 달성됩니다.
   - **진정한 미해결 해석적 난제로 남는 영역 (`5~6단계`, 합계 $3264 + 3672 = 6936 / 44064 = 17/108 \approx 0.1574$, $\frac{71}{108} \to \frac{1}{2}$)**: 극점 장벽 제거로 길은 열렸으나, 실제 모멘트 에너지 바닥을 $\frac{71}{108}$에서 $\frac{1}{2}$까지 밀어 내리려면 큰 체 부등식을 넘어서는 비대각 스펙트럼/클루스터만 제곱근 상쇄($\Delta_{\mathrm{hybrid}} = \frac{14}{33} \approx 0.4242$)에 대한 새로운 해석적 증명이 필요합니다.
