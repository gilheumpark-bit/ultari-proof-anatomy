# 1단계: 초보자용 쉬운 해설: OpenAI #003 준리만 가설 생태계의 5가지 핵심 의문

[제1부 (7/8 ShortDraft 감사)](../../001-openai-003-qrh/README.ko.md)와 [제2부 (심판관·비묶음 그람 감사)](../../005-openai-003-qrh-mathematician-referee-audit/README.ko.md)에서 우리는 OpenAI의 $\text{Re}(s) > \frac{7}{8} = 0.875$ 증명 내부 상수와 그람 연산자 여유분을 분석했습니다. 이제 제3부(11/12 및 CubicGauss 통합)에서 openai/math #003 저장소 전체(6,856개 .lean 파일, proofs/oai_ref/ 외부 파일은 커밋 4eaee87 / PR #70 ca28f20 기준)와 후속 연구(Alex Kontorovich의 quasi-rh, Baiying Liu의 arXiv:2610.12234 미심사 프리프린트)를 함께 대조하면 다섯 가지 모듈 계층 의문이 드러납니다.

먼저 #003 전체 범위를 명확히 둡니다. OpenAI #003의 증명된 주정리인 SevenEighths.lean($\beta = 7/8 = 21/24$, 0 sorry)은 이미 $\text{Re}(s) > 11/12$와 $\text{Re}(s) > 23/24$를 논리적으로 모두 함의하며, 가변 스케일 모듈인 DescentScale.lean 역시 저장소 내부에 이미 존재합니다. 따라서 본 보고서의 ElevenTwelfths(23/24 대 11/12) 및 미연결 30개 CubicGauss 파일 발굴은 #003이 11/12에 도달하지 못했다는 주장이 아니라, 엄밀히 모듈 층위와 중간 목표를 규명한 분석입니다.

## 1. 생태계 전체를 관통하는 5대 질문 해답

1. 왜 논문은 $\text{Re}(s) > 11/12$를 제시하는데 독립 ShortDraft 서브모듈은 $23/24$만 증명하는가?
   - paper.tex 1부와 paper2.tex(openai/math 커밋 4eaee87 / PR #70 ca28f20)의 도입 정리는 무영점 영역 폭을 $1 - 11/12 = 1/12 \approx 0.0833$으로 제시합니다.
   - 저장소 주정리 SevenEighths.lean($\beta = 7/8 = 21/24$, 0 sorry)이 이미 $11/12$와 $23/24$를 모두 함의하고 DescentScale.lean도 저장소에 존재하지만, 별도 서브모듈인 DirichletL/RowCompletion/ZeroFreeRegion.lean의 ShortDraft.DirichletTarget은 폭이 절반인 $\text{Re}(s) > 23/24$(폭 $1/24 \approx 0.0417$)만 증명합니다.
   - [thm_01_shortdraft_fixed_reserve_and_23_24_exponent](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L25-L38)과 [thm_04_canonical_descent_scale_budget_unlocks_arbitrary_theta](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L76-L92)에서 우리는 RankMargins.lean:83-132의 $\text{reserve} = \frac{1}{20}$ 상수(`ClosedRecursion.lean:120` $\eta \le 1/1000$)가 하드코딩되어 $\vartheta = 1/10$로 묶였기 때문임을 밝히고, CanonicalDescentScale(`PR #70` DescentScale.lean)로 $\frac{11}{12} + \varepsilon$이 열림을 증명했습니다.
2. 왜 30개 파일(6,252줄) 분량의 날카로운 삼차 큰 체(CubicGauss/)가 미연결 상태로 남아 있는가?
   - lean/OAI/NumberTheory/CubicGauss/(openai/math 커밋 4eaee87 / PR #70 ca28f20)에는 히스-브라운(Heath-Brown)의 날카로운 $2/3$ 삼차 큰 체 부등식이 0 sorry로 완성되어 있습니다.
   - 그러나 DirichletL의 어떤 파일도 CubicGauss를 임포트하지 않고 CubicGram만 사용합니다([thm_15_unimported_cubic_gauss_vs_bundled_cubic_gram_gap](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L297-L311)).
   - 우리는 [thm_31_sieve_iter_mobius_invariants_by_induction](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L36-L69)에서 [thm_33_sieve_iter_strictly_beats_openai_sieve_exponent_all_n](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L92-L107)까지 수학적 귀납법(induction n)으로 모든 $n \in \mathbb{N}$에서 점화식 sieveIter의 정확한 닫힌 해 $\tilde{\alpha}_n = \frac{4\cdot 3^n - 2^{n+1}}{3\cdot 3^n - 2^{n+1}}$을 증명했습니다. 아울러 CubicGauss/LargeSieve.lean:75의 기하급수 상계 역시 정확한 점화식과 동일한 점근 고정점 $\alpha^{\ast} = 4/3$에 수렴하는 유효한 단순화임을 확인했습니다.
3. 왜 제2부와 Baiying Liu의 연구가 똑같이 수체 $\mathbb{Q}(\sqrt{921})$에서 만나는가?
   - 제2부의 전역 SOS 안장점 $\beta_{\mathrm{SOS}}(0) = \frac{6843 - 7\sqrt{921}}{7578}$과 Liu의 최적값 $B_{\mathrm{Liu}} = \frac{1507 - 2\sqrt{921}}{1653}$(arXiv:2610.12234, 미심사 프리프린트)에는 모두 $\sqrt{921}$이 등장합니다.
   - [thm_16_shared_critical_quadratic_288_588_185_and_count_2_3](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L24-L42), [thm_19_exact_gap_between_fixed_scale_saddle_and_liu_optimum](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L85-L97), [thm_34_zsqrt921_norm_and_critical_quadratic_root](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L130-L138) 및 [thm_35_zsqrt921_liu_rationalization_and_case005_gap](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L144-L157)은 두 값 모두 6차 체 카운트가 $2/3$와 만나는 동일한 이차방정식 $288\delta_c^2 - 588\delta_c + 185 = 0$에서 나옴을 증명합니다.
4. 선형계획법(LP) 섭동으로 Liu의 파카스 쌍대 장벽($0.874957$)을 어떻게 넘어서는가?
   - Liu(arXiv:2610.12234, 미심사 프리프린트)는 OpenAI의 묶음 부등식 3개를 그대로 두면 $0.874957$ 아래로 내려갈 수 없음을 보였습니다([thm_21_farkas_dual_weights_and_closure_obstruction](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L124-L139)).
   - 매개변수 LP에서 묶음 지수 여백을 풀고 CubicGauss를 결합하면 대수적 지수 목표치가 $\frac{4103}{4896} \approx 0.8380$, $\frac{4069}{4896} \approx 0.8311$을 거쳐 조건부로 $\frac{71}{108} \approx 0.6574$까지 단계적으로 내려갑니다([thm_24_parametric_unbundled_farkas_shift_theorem](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L187-L211)에서 [thm_28_ten_tier_qrh_boundary_hierarchy](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L268-L284)).
5. 제1부·제2부·제3부는 대수적으로 어떻게 하나의 3부작으로 맞물리는가 (정리 36~45)?
   - 제1부의 여유분 $\frac{215}{3264}$에 큰 체 가중치 $\frac{2}{3}$를 곱하면 정확히 제2부의 이동폭 $\frac{7}{8} - \frac{4069}{4896} = \frac{215}{4896}$이 됩니다([thm_36_trilogy_denominator_bridge_3264_and_4896](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L167-L178), [thm_37_case001_margin_215_3264_drives_case005_4069_4896](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L185-L205)).
   - 또한 CubicGauss 고정점 $\alpha^{\ast} = \frac{4}{3}$과 coordR 극점 $\beta_{\mathrm{pole}} = \frac{2}{3}$은 $\alpha^{\ast} + \beta_{\mathrm{pole}} = 2$ 쌍대성을 만족합니다([thm_39_eisenstein_pole_duality_cubic_gauss_vs_coordR](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L232-L243)에서 [thm_42_gap_between_71_108_and_7_12_equals_3264_over_44064](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L284-L293)).

## 2. 엄밀한 경계: 조건부 지수 합성과 미구축 해석적 증명 과제

- 조건부 LP 및 대수적 지수 합성 ($\frac{23}{24} \to \frac{71}{108} \approx 0.6574$):
  - 우리의 0 sorry Lean 4 정리([thm_27_connecting_cubic_gauss_2_3_sieve_to_path_A_71_108](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L252-L264), [thm_40_cubic_gauss_plus_stickelberger_crosses_two_thirds](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L249-L258), [thm_41_case001_gauss_branch_vanishing_drives_case005_pole_shift](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L264-L278))는 $\frac{71}{108} \approx 0.6574$의 조건부 LP 및 대수적 지수 합성을 검증합니다.
  - 그러나 실제 무영점 경계 $\beta = \frac{71}{108}$의 달성은 슈티켈베르거 극점 소멸($k_\infty = -6$)과 보로노이-멜린 전달의 완전한 해석적 증명 구축에 조건부로 의존하며, 이는 아직 완성된 증명 코드가 아닌 미구축 이론적 설계도입니다.
- $\beta = 1/2$까지 남아 있는 해석적 난제 ($\frac{71}{108} \to \frac{1}{2}$):
  - 위 $71/108$ 전달 설계도를 구축한 뒤에도 마지막 $\frac{17}{108} \approx 0.1574$ 에너지 간격([thm_44_six_stage_trilogy_telescoping_decomposition](../proofs/qrh_trilogy_induction_and_algebraic_bridge.lean#L316-L331))을 넘어 $\beta = \frac{1}{2}$에 도달하려면, 비대각 스펙트럼 상쇄 기반의 조건부 이득 $\Delta_{\mathrm{hybrid}} = \frac{14}{33}$을 새로 증명해야 하며 이는 해석적 수론의 열린 난제입니다.

## 3. 10단계 무영점 경계($\beta$) 진화 요약

1. 1단계, OpenAI ShortDraft 서브모듈 (DirichletL/RowCompletion/ZeroFreeRegion.lean, openai/math 커밋 4eaee87 / PR #70 ca28f20): $\beta = 23/24 \approx 0.95833333$, 무영점 영역 폭 $1 - \beta = 1/24 \approx 0.04167$ ($1.00\times$).
2. 2단계, OpenAI paper2.tex 및 AlexKontorovich/quasi-rh: $\beta = 11/12 \approx 0.91666667$, 영역 폭 $1/12 \approx 0.08333$ ($2.00\times$).
3. 3단계, OpenAI SevenEighths.lean 증명 기준선 (1·2단계를 논리적으로 함의): $\beta = \frac{7}{8} = 0.87500000$, 영역 폭 $1/8 = 0.12500$ ($3.00\times$).
4. 4단계, 제2부 고정 스케일 전역 SOS 안장점: $\beta = (6843 - 7\sqrt{921})/7578 \approx 0.87497547$, 영역 폭 $0.12502453$ ($3.0006\times$).
5. 5단계, Baiying Liu 유리수 섭동 (arXiv:2610.12234, 미심사 프리프린트): $\beta = 34999/40000 = 0.87497500$, 영역 폭 $5001/40000 = 0.125025$.
6. 6단계, Baiying Liu 3-평면 $\mathbb{Q}(\sqrt{921})$ 최적해 (arXiv:2610.12234, 미심사 프리프린트): $\beta = (1507 - 2\sqrt{921})/1653 \approx 0.87495707$, 영역 폭 $0.12504293$ ($3.0010\times$).
7. 7단계, Y. Xu & H. Sang $\delta = 0$ 반사 분자 증폭 모멘트 (arXiv:2610.15291, 미심사 프리프린트): $\beta = 8748867/10000000 = 0.87488670$, 영역 폭 $0.12511330$ ($3.0027\times$).
8. 8단계, 제2부 2항 비묶음 그람 + 슈티켈베르거 이동 지수 목표치: $\beta = 4103/4896 \approx 0.83803105$, 영역 폭 $793/4896 \approx 0.16197$ ($3.89\times$).
9. 9단계, 제2부 3항 비묶음 그람 + 슈티켈베르거 이동 지수 목표치: $\beta = 4069/4896 \approx 0.83108660$, 영역 폭 $827/4896 \approx 0.16891$ ($4.05\times$).
10. 10단계, 형식적 영에너지 LP 절편 ($\Delta_{\mathrm{gram}} = 53/216$ 가상 상쇄 + 슈티켈베르거 설계도): $\beta = 71/108 \approx 0.65740741$, 영역 폭 $37/108 \approx 0.34259$ ($8.22\times$).

## 4. 단계별 문서 안내

- [한국어 메인 README (README.ko.md)](../README.ko.md): 통합 감사 범위, 선언 총수(45개 정리, 11개 def, 1개 structure), 및 1줄 검증 명령어 요약.
- [중급 가이드 (ko/02_Intermediate_Guide.md)](02_Intermediate_Guide.md): 5대 기둥의 대수적 유도와 원문 참조 파일 26개 1대1 대응표.
- [고급 가이드 (ko/03_Advanced_Guide.md)](03_Advanced_Guide.md): 귀납법 닫힌 해, Z[sqrt(921)] 정역 계산, 3부작 브리지 및 178개 선언 전수 대조 원장.
- [전문가 검증 가이드 (ko/04_Expert_Verification.md)](04_Expert_Verification.md): SHA-256 해시 원장, Lean 4 커널 검증 명령어 및 45개 정리 1대1 대조표.
