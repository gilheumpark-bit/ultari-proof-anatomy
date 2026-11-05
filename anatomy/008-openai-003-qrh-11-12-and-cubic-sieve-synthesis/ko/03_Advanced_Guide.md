# 고급 가이드: $\mathbb{Q}(\sqrt{921})$ 대수적 통합과 매개변수 파카스(Farkas) 쌍대성 정리

> **대상 독자**: 해석적 정수론 연구자, 형식 검증 전문가, 그리고 `Case 005`의 안장점($\approx 0.8749755$), Baiying Liu(`arXiv:2610.12234`)의 3면 등화 최적값($\approx 0.8749571$), Xu–Sang(`arXiv:2610.15291`)의 6차 모멘트 증폭($\approx 0.8748867$), 그리고 결합 해제(unbundling) 경계들이 어떻게 단일 대수적·선형계획적 구조로 통합되는지 확인하고 싶은 분.

---

## 1. $\mathbb{Q}(\sqrt{921})$ 대수적 통합: 왜 두 독립 연구에서 똑같이 $\sqrt{921}$이 나오는가?

### 1.1 임계 각도 $\delta_c = \frac{49 - \sqrt{921}}{48}$의 기원 (`thm_16`)

헤케 $L$-함수 영점 밀도 추정에서 6차 모멘트 개수 상한 지수(sextic count envelope)는 $B \in [5/6, 7/8]$ 영역에서 중심값 $B = 7/8$, 즉 $\frac{2B}{1-B} = 14$로 정규화할 때 다음과 같이 주어집니다:
$$R(\delta, b) = \frac{10 - 2\delta + (7 - 8\delta)b}{17 + 14b - 24\delta(1+b)}.$$
고정된 튜브 폭 $b = 1/2$에서 이 상한이 날카로운 3차 큰 체 임계치 $R(\delta_c, 1/2) = 2/3$와 만나는 방정식은
$$\frac{10 - 2\delta_c + \frac{7}{2} - 4\delta_c}{24 - 36\delta_c} = \frac{2}{3} \iff 3(27 - 12\delta_c) = 4(24 - 36\delta_c)$$
가 아니라, 본래의 $(1-B)$-가중 밀도 식(`Blueprint.lean` 및 `V2Optimization.lean:45`)인
$$288\delta_c^2 - 588\delta_c + 185 = 0$$
입니다([`thm_16`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L18)). 이 이차방정식의 해는
$$\delta_c = \frac{588 - \sqrt{588^2 - 4 \cdot 288 \cdot 185}}{576} = \frac{49 - \sqrt{49^2 - 1480}}{48} = \frac{49 - \sqrt{921}}{48} \approx 0.38858268$$
입니다. 즉 **$\Delta = 49^2 - 1480 = 2401 - 1480 = 921$**이 바로 $\sqrt{921}$의 유일한 근원입니다!

### 1.2 `Case 005`의 $\beta_{\mathrm{SOS}}(0)$ 대 Baiying Liu의 $B_{\mathrm{Liu}}$ (`thm_17`–`thm_20`)

1. **`Case 005`의 전역 제곱합(SOS) 안장점 $\beta_{\mathrm{SOS}}(0)$ (`b = 1/8, ℓ = 1/6` 고정)**:
   `Blueprint.lean`의 고정된 보조 매개변수 $(b, \ell) = (1/8, 1/6)$ 위에서 2차 모멘트 면과 6차 모멘트 면을 등화하면 다음 값을 얻습니다:
   $$\beta_{\mathrm{SOS}}(0) = \frac{6843 - 7\sqrt{921}}{7578} \approx 0.8749754723.$$
2. **Baiying Liu (`arXiv:2610.12234`, `V2Optimization.lean`)의 3면 동시 등화 최적값 $B_{\mathrm{Liu}}$**:
   $\ell$을 고정하지 않고 $\delta = 0$에서의 6차 모멘트 면 $F_0(M)$, $\delta = \delta_c$에서의 2차 모멘트 면 $F_K(M, \ell)$, 그리고 큰 체 면 $F_H(M, \ell)$ 세 개를 동시에 등화하면 최적 매개변수
   $$\ell_{\mathrm{Liu}} = \frac{1 + 2\delta_c}{9 + 18\delta_c} = \frac{33 + 8\sqrt{921}}{1653} \approx 0.1668381, \qquad M_{\mathrm{Liu}} = \frac{4 + 12\delta_c}{9 + 18\delta_c} = \frac{502 - 4\sqrt{921}}{1653} \approx 0.2302521$$
   에서 다음 최적값을 얻습니다([`thm_18`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L59), [`thm_19`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L77)):
   $$B_{\mathrm{Liu}} = \frac{7 + 18\delta_c}{9 + 18\delta_c} = \frac{203 - 3\sqrt{921}}{219 - 3\sqrt{921}} = \frac{1507 - 2\sqrt{921}}{1653} \approx 0.8749570703.$$
3. **두 $\mathbb{Q}(\sqrt{921})$ 상수의 정확한 대수적 차이 (`thm_20`)**:
   $$\beta_{\mathrm{SOS}}(0) - B_{\mathrm{Liu}} = \frac{6843 - 7\sqrt{921}}{7578} - \frac{1507 - 2\sqrt{921}}{1653} = \frac{1195\sqrt{921} - 36189}{4175478} \approx 1.8402 \times 10^{-5} > 0.$$
   여기서 $1195^2 \times 921 - 36189^2 = 1315211025 - 1309643721 = 5567304 > 0$이므로 $\ell$을 $1/6 \approx 0.16667$에서 $\ell_{\mathrm{Liu}} \approx 0.16684$로 미세 조정할 때 얻는 순수 이득이 정확히 $\frac{1195\sqrt{921} - 36189}{4175478}$임이 증명됩니다([`thm_20`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L95)).

### 1.3 $7/8$ 근방의 5점 엄격 순서 관계 (`thm_17`, `thm_23`)

유리수 인증값 $B_r = \frac{34999}{40000} = 0.874975$ (`V2Optimization.lean`)와 `Case 005`의 유리수 인증값 $\frac{41999}{48000} \approx 0.87497917$까지 포함한 5개의 상수는 다음의 엄격한 부등식 사슬을 이룹니다([`thm_17`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L41), [`thm_23`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L154)):
$$B_{\mathrm{Liu}} = \frac{1507 - 2\sqrt{921}}{1653} < B_r = \frac{34999}{40000} < \beta_{\mathrm{SOS}}(0) = \frac{6843 - 7\sqrt{921}}{7578} < \frac{41999}{48000} < \frac{7}{8}.$$

---

## 2. 매개변수 파카스(Farkas) 쌍대성 정리 (`thm_21`, `thm_22`, `thm_24`)

세 개의 활성 제약 면에 비음수 절감량(savings) $(\Delta_0, \Delta_K, \Delta_H)$를 도입한 매개변수 선형계획 문제를 생각합니다:
$$\begin{aligned}
F_0(M; \Delta_0) &= \frac{21 - 6M}{24 - 6M} - \Delta_0 \approx \frac{7}{8} - \frac{M}{32} - \Delta_0 \le B, \\
F_K(M, \ell; \Delta_K) &= 1 - \frac{3}{4}\ell - \frac{(1/2 - 3\ell/4)\delta_c}{1/2 + \ell/2} M - \Delta_K \le B, \\
F_H(M, \ell; \Delta_H) &= \frac{5}{6} + \frac{1}{2}\ell - \frac{1}{6}M - \Delta_H \le B.
\end{aligned}$$
여기서 파카스 쌍대 가중치(Farkas multipliers)를
$$w_0 = \frac{4 + 18\delta_c}{9 + 18\delta_c}, \qquad w_K = \frac{2}{9 + 18\delta_c}, \qquad w_H = \frac{3}{9 + 18\delta_c}$$
로 잡으면 $w_0 + w_K + w_H = 1$이고 $w_0, w_K, w_H > 0$이며, **임의의 $\delta_c$에 대해 $(M, \ell)$의 계수가 항등적으로 $0$으로 소거**됩니다([`thm_21`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L116), [`thm_24`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L179)):
$$B^*(\Delta_0, \Delta_K, \Delta_H) = \frac{7 + 18\delta_c}{9 + 18\delta_c} - \left(w_0 \Delta_0 + w_K \Delta_K + w_H \Delta_H\right) = B_{\mathrm{Liu}} - \frac{(4 + 18\delta_c)\Delta_0 + 2\Delta_K + 3\Delta_H}{9 + 18\delta_c}.$$

이 단일 공식이 모든 후속 연구를 즉시 설명합니다:
1. **$\Delta_0 = \Delta_K = \Delta_H = 0$ (고정된 OpenAI 3개 공리 하의 하한)**:
   $B \ge B_{\mathrm{Liu}} \approx 0.8749571$. 즉 입력 공리를 고치지 않고 매개변수 $(b, \ell, M)$만 최적화해서는 절대 $B_{\mathrm{Liu}}$ 아래로 내려갈 수 없습니다([`thm_22`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L137)).
2. **Xu–Sang (`arXiv:2610.15291`, $\Delta_0 > 0, \Delta_K = \Delta_H = 0$)**:
   $\delta = 0$에서의 6차 모멘트 증폭으로 $\Delta_0 > 0$을 얻으면 $w_0 \approx 0.6874$의 가중치만큼 경계가 내려가 $B_{\mathrm{XS}} = \frac{109651}{125332} \approx 0.8748867$이 됩니다([`thm_24`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L179)).
3. **`Case 005`의 그램 + 슈티켈베르거 결합 해제 ($\Delta_K, \Delta_H > 0$)**:
   `CubicGram`의 반단순 그램 행렬식 결합 해제와 슈티켈베르거 아이디얼 교차항 절감($z_{\mathrm{high}}' = 7/20 < 3/8 = 15/40$, 절감량 $1/40$)을 넣으면 $\Delta_K, \Delta_H > 0$이 되어 $\frac{4103}{4896} \approx 0.838031$ 및 $\frac{4069}{4896} \approx 0.831087$로 크게 내려갑니다([`thm_25`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L206)–[`thm_28`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L258)).
4. **`CubicGauss`의 날카로운 $2/3$ 큰 체 연결 (`Path-A`, $R_{\mathrm{eff}} = 7/9$)**:
   잠들어 있던 `CubicGauss`의 날카로운 $2/3$ 지수를 6차 모멘트 개수 함수에 직접 연결하면 바닥 경계가 $\frac{71}{108} \approx 0.657407$까지 내려갑니다([`thm_29`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L280), [`thm_30`](../proofs/qrh_q_sqrt_921_farkas_and_unbundling_synthesis.lean#L298)).
