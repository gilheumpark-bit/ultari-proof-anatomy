# [1단계: 초보자용 쉬운 해설] OpenAI `#003` 준리만 가설 생태계의 5가지 구조적 수수께끼

[`사례 001`](../../001-openai-003-qrh/README.ko.md)과 [`사례 005`](../../005-openai-003-qrh-mathematician-referee-audit/README.ko.md)에서 우리는 OpenAI의 $\text{Re}(s) > 7/8 = 0.875$ 증명 내부 상수와 그람 연산자 여유분을 분석했습니다. 이제 시야를 넓혀 `#003` 저장소 전체(`6,856`개 `.lean` 파일)와 후속 연구(Alex Kontorovich의 `quasi-rh`, Baiying Liu의 `arXiv:2610.12234`)를 함께 대조하면 다섯 가지 흥미로운 수수께끼가 드러납니다.

---

## 1. 생태계 전체를 관통하는 5대 수수께끼 해답

1. **왜 논문은 $\text{Re}(s) > 11/12$를 주장하는데 예비 Lean 코드는 $23/24$만 증명하는가?**
   - `paper.tex` 1부와 `paper2.tex`의 도입 정리는 무영점 영역의 폭을 $1 - 11/12 = 1/12 \approx 0.0833$으로 제시합니다.
   - 그런데 `ZeroFreeRegion.lean`의 `ShortDraft.DirichletTarget`은 폭이 절반인 $\text{Re}(s) > 23/24$(폭 $1/24 \approx 0.0417$)만 증명합니다.
   - [`thm_01_shortdraft_fixed_reserve_and_23_24_exponent`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L19-L33)과 [`thm_04_canonical_descent_scale_budget_unlocks_arbitrary_theta`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L70-L85)에서 우리는 `reserve = 1/20` 상수가 하드코딩되어 $\vartheta = 1/10$로 묶였기 때문임을 밝히고, `CanonicalDescentScale`로 $\frac{11}{12} + \varepsilon$이 열림을 증명했습니다.
2. **왜 30개 파일(`6,252`줄) 분량의 날카로운 삼차 큰 체(`CubicGauss/`)가 미연결 상태로 방치되었는가?**
   - `lean/OAI/NumberTheory/CubicGauss/` 폴더에는 히스-브라운(Heath-Brown)의 날카로운 $2/3$ 삼차 큰 체 부등식이 `0 sorry`로 완성되어 있습니다.
   - 그러나 `DirichletL`의 어떤 파일도 `CubicGauss`를 임포트하지 않고 더 약한 `CubicGram`만 사용합니다([`thm_15_unimported_cubic_gauss_vs_bundled_cubic_gram_gap`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L289-L303)).
   - 우리는 [`thm_31_sieve_iter_mobius_invariants_by_induction`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L36-L69)~[`thm_33_sieve_iter_strictly_beats_openai_sieve_exponent_all_n`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L92-L107)에서 수학적 귀납법(`induction n`)을 사용해 점화식 `sieveIter`의 정확한 닫힌 해 $\tilde{\alpha}_n = \frac{4\cdot 3^n - 2^{n+1}}{3\cdot 3^n - 2^{n+1}}$을 모든 $n \in \mathbb{N}$에 대해 증명했습니다.
3. **왜 `사례 005`와 Baiying Liu의 연구가 똑같이 수체 $\mathbb{Q}(\sqrt{921})$에서 만나는가?**
   - `사례 005`의 전역 SOS 안장점 $\beta_{\mathrm{SOS}}(0) = \frac{6843 - 7\sqrt{921}}{7578}$과 Liu의 최적값 $B_{\mathrm{Liu}} = \frac{1507 - 2\sqrt{921}}{1653}$에는 모두 $\sqrt{921}$이 등장합니다.
   - [`thm_16_shared_critical_quadratic_288_588_185_and_count_2_3`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L18-L34), [`thm_19_exact_gap_between_fixed_scale_saddle_and_liu_optimum`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L77-L90), [`thm_34_zsqrt921_norm_and_critical_quadratic_root`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L130-L137)~[`thm_35_zsqrt921_liu_rationalization_and_case005_gap`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L144-L157)을 통해 두 값 모두 6차 체 카운트가 $2/3$와 만나는 동일한 이차방정식 $288\delta_c^2 - 588\delta_c + 185 = 0$에서 나옴을 증명했습니다.
4. **Liu의 파카스 쌍대 장벽($0.874957$)을 어떻게 넘어서는가?**
   - Liu는 OpenAI의 묶음 부등식 3개를 그대로 두면 $0.874957$ 아래로 내려갈 수 없음을 보였습니다([`thm_21_farkas_dual_weights_and_closure_obstruction`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L116-L132)).
   - 묶음 상한을 풀고 `CubicGauss`를 결합하면 경계가 $\frac{4103}{4896} \approx 0.8380 \to \frac{4069}{4896} \approx 0.8311 \to \frac{71}{108} \approx 0.6574$까지 단계적으로 내려갑니다([`thm_24_parametric_unbundled_farkas_shift_theorem`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L179-L201)~[`thm_28_ten_tier_qrh_boundary_hierarchy`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L258-L275)).
5. **`사례 001`·`005`·`008`은 어떻게 하나의 3부작으로 맞물리는가 (`정리 36~45`)?**
   - `사례 001`의 여유분 $\frac{215}{3264}$에 큰 체 가중치 $\frac{2}{3}$를 곱하면 정확히 `사례 005`의 개선폭 $\frac{7}{8} - \frac{4069}{4896} = \frac{215}{4896}$이 됩니다([`thm_36_trilogy_denominator_bridge_3264_and_4896`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L167-L178), [`thm_37_case001_margin_215_3264_drives_case005_4069_4896`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L185-L204)).
   - 또한 `CubicGauss` 고정점 $\alpha^* = \frac{4}{3}$과 `coordR` 극점 $\beta_{\mathrm{pole}} = \frac{2}{3}$은 $\alpha^* + \beta_{\mathrm{pole}} = 2$ 쌍대성을 만족합니다([`thm_39_eisenstein_pole_duality_cubic_gauss_vs_coordR`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L232-L242)~[`thm_42_gap_between_71_108_and_7_12_equals_3264_over_44064`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L284-L292)).

---

## 2. 엄밀한 경계(`Ultari`): 달성된 범위와 $\beta = 1/2$까지의 미해결 과제 (`영역 A`)

- **기존 `0 sorry` 모듈 결합으로 도달 가능한 범위 ($\frac{23}{24} \to \frac{71}{108} \approx 0.6574$)**:
  - 저장소 내부에 이미 증명된 구성요소(`CanonicalDescentScale`, 비묶음 `CubicGram`, 슈티켈베르거 소멸자, 미연결 `CubicGauss` 큰 체)를 결합하면 무영점 경계가 $\frac{23}{24}$에서 $\frac{71}{108} \approx 0.6574$까지 내려가며, $\beta = \frac{2}{3}$ 극점 장벽도 제거됩니다([`thm_40_cubic_gauss_plus_stickelberger_crosses_two_thirds`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L249-L257), [`thm_41_case001_gauss_branch_vanishing_drives_case005_pole_shift`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L264-L277)).
- **미해결로 남아 있는 해석적 난제 ($\frac{71}{108} \to \frac{1}{2}$)**:
  - 마지막 남은 $\frac{17}{108} \approx 0.1574$ 에너지 간격([`thm_44_six_stage_trilogy_telescoping_decomposition`](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L316-L331))을 넘어 $\beta = \frac{1}{2}$에 도달하려면 조건부 하이브리드 이득 $\Delta_{\mathrm{hybrid}} = \frac{14}{33}$(6차 모멘트 비대각 스펙트럼 상쇄 등)을 새로 증명해야 하며, 이는 해석적 수론의 열린 문제입니다.

---

## 3. 10단계 무영점 경계($\beta$) 진화 요약표

| 단계 | 출처 및 이정표 | 정확한 경계 $\beta$ | 소수점 수치 | 무영점 영역 폭 $1 - \beta$ |
| :--- | :--- | :--- | :--- | :--- |
| 1 | OpenAI `ShortDraft` (`ZeroFreeRegion.lean`) | $23/24$ | $0.95833333$ | $1/24 \approx 0.04167$ ($1.00\times$) |
| 2 | OpenAI `paper2.tex` 및 `AlexKontorovich/quasi-rh` | $11/12$ | $0.91666667$ | $1/12 \approx 0.08333$ ($2.00\times$) |
| 3 | OpenAI `SevenEighths.lean` 기준선 | $7/8$ | $0.87500000$ | $1/8 = 0.12500$ ($3.00\times$) |
| 4 | `사례 005` 고정 스케일 전역 SOS 안장점 | $(6843 - 7\sqrt{921})/7578$ | $0.87497547$ | $0.12502453$ ($3.0006\times$) |
| 5 | Baiying Liu 유리수 섭동 (`arXiv:2610.12234`) | $34999/40000$ | $0.87497500$ | $5001/40000 = 0.125025$ |
| 6 | Baiying Liu 3-평면 $\mathbb{Q}(\sqrt{921})$ 최적해 | $(1507 - 2\sqrt{921})/1653$ | $0.87495707$ | $0.12504293$ ($3.0010\times$) |
| 7 | Xu-Sang $\delta = 0$ 6차 모멘트 증폭 (`arXiv:2610.15291`) | $8748867/10000000$ | $0.87488670$ | $0.12511330$ ($3.0027\times$) |
| 8 | `사례 005` 2항 비묶음 그람 + 슈티켈베르거 이동 | $4103/4896$ | $0.83803105$ | $793/4896 \approx 0.16197$ ($3.89\times$) |
| 9 | `사례 005` 3항 비묶음 그람 + 슈티켈베르거 이동 | $4069/4896$ | $0.83108660$ | $827/4896 \approx 0.16891$ ($4.05\times$) |
| 10 | `사례 005` + `사례 008` `CubicGauss` 큰 체 결합 바닥 | $71/108$ | $0.65740741$ | $37/108 \approx 0.34259$ ($8.22\times$) |
