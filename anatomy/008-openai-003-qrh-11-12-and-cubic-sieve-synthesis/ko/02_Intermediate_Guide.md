# 중급 가이드: $\text{Re}(s) > 11/12$ 스케일링 아키텍처와 `CubicGauss/` 비선형 점화식의 정확한 해법

> **대상 독자**: 해석적 정수론, 디리클레 급수, 또는 Lean 4 형식화에 익숙하며, `DirichletL`이 왜 $\text{Re}(s) > 23/24$에서 멈췄는지와 `CubicGauss`의 비선형 체 점화식이 어떻게 정확히 풀리는지 코드 수준에서 추적하고 싶은 분.

---

## 1. 아키텍처 해부 1: 왜 `DirichletL/Foundation.lean`은 $23/24$까지만 증명하는가?

OpenAI의 `first-proof` 저장소에는 디리클레 $L$-함수에 대한 두 개의 서로 다른 목표 정리가 공존합니다:

| 항목 | 원본 `DirichletL/Foundation.lean` (`ShortDraft`) | `paper2.tex` & `AlexKontorovich/quasi-rh` |
|---|---|---|
| 최상위 목표 정리 | `ShortDraft.DirichletTarget` (`ZeroFreeRegion.lean:204`) | `DirichletTarget` (`ZeroFreeRegion.lean:274`) |
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
   $\vartheta = 1/10$에서 6차 모멘트 창 크기 $H = Z^{1 + \vartheta} = Z^{11/10}$, 체 절단 크기 $Y = H^{1/6} = Z^{11/60}$이 결정됩니다. 이때 코시-슈바르츠 부등식을 적용하면 지수가 다음과 같이 고정됩니다([`thm_01`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L19), [`thm_02`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L38)):
   $$E_{\mathrm{CS}}(\vartheta) = \frac{1 + \vartheta}{2} + \frac{1 + \vartheta}{12} + \frac{5 - 2\vartheta}{12} = \frac{11 + 5\vartheta}{12} \xrightarrow{\vartheta = 1/10} \frac{137}{120} - \frac{11}{60} = \frac{23}{24}.$$

### 1.2 `CanonicalDescentScale`과 $(\vartheta, \eta) = (6\varepsilon/5, \varepsilon/2)$ 스케일링

`paper2.tex`와 `AlexKontorovich/quasi-rh`에서는 고정된 `denominator = 1000, reserve = 1/20`을 다음 불변량으로 교체합니다([`thm_05`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L90)):
$$\text{CanonicalDescentScale}: \quad \text{reserve} \cdot \text{denominator} \ge 50.$$
임의의 $\vartheta > 0$에 대해 예비 여백을 $\kappa = \vartheta / 2$로 잡고 분모를 $D = \lceil 100/\vartheta \rceil + 1$로 잡으면 $\kappa D > 50$이 항상 성립하고 $\vartheta > \kappa$이므로 하한선 제약이 완전히 사라집니다.

이제 임의의 목표 여백 $\varepsilon \in (0, 1/12)$에 대해
$$\vartheta = \frac{6}{5}\varepsilon, \qquad \eta = \frac{1}{2}\varepsilon$$
로 설정하면, 최종 코시-슈바르츠 지수와 멜린 절단 여유분 $\eta$의 합이 정확히 목표치를 맞춥니다([`thm_04`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L70)):
$$E_{\mathrm{CS}}\!\left(\frac{6}{5}\varepsilon\right) + \frac{1}{2}\varepsilon = \frac{11 + 6\varepsilon}{12} + \frac{6\varepsilon}{12} = \frac{11}{12} + \varepsilon.$$

### 1.3 란다우 소 아이디얼 정리를 우회하는 매끄러운 $b^6$-증폭 (`cauchy_const = 768`)

원본 `ShortDraft`는 소수 행(prime rows)만 추출한 뒤 마지막에 란다우의 소 아이디얼 정리(Prime Ideal Theorem)를 호출하려다 막혔습니다. 반면 $11/12$ 증명은 **모든 양의 정수 $b$**에 대해 6제곱 가중치 $b^6$를 곱해 증폭합니다([`thm_06`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L108)–[`thm_08`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L140)):
- 6개 소수 $p_1, \dots, p_6 \in [P, 2P]$의 곱 $b = p_1 \cdots p_6 \in [P^6, 64P^6]$에 대해 $\mu(b)^2 = 1$인 무제곱수 항들의 가중합을 계산할 때, 오일러 피 밀도 `totientDensity I = ∏_{p | I} (1 - 1/N(p))`와 보정 인자 `eulerCorrection = ∏_{p ∤ 6} (1 - 1/(p^2 - p))`이 등장합니다.
- 이때 코시-슈바르츠 증폭 상수는 $6 \times 128 = 768$로 결정됩니다([`thm_06`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L108)).

---

## 2. 아키텍처 해부 2: `OAI/NumberTheory/CubicGauss/` (30개 파일, 6,252줄)의 완전 해독

`lean/OAI/NumberTheory/CubicGauss/` 디렉터리에는 30개의 Lean 파일(총 6,252줄, `0 sorry`)이 들어 있으며, `MainTheorem.lean:645`에서 날카로운 3차 큰 체 부등식 `cubic_large_sieve`를 무조건부로 증명합니다. 그러나 저장소 전체(`DirichletL` 2,926개 파일, `CubicMoment` 3,549개 파일)를 검색해 보면 `import OAI.NumberTheory.CubicGauss`는 **단 한 곳에도 없습니다**.

### 2.1 체 임계값 `sieveThreshold`와 1단계 갱신 `sieveStep`

`CubicGauss/MainTheorem.lean:24–38`은 입력 지수 $\alpha > 4/3$에 대해 다음 두 유리함수를 정의합니다:
$$\text{sieveThreshold}(\alpha) = \frac{6\alpha - 5}{3\alpha - 1}, \qquad \text{sieveStep}(\alpha) = \frac{6\alpha - 4}{3\alpha - 1}.$$
$\alpha > 4/3$일 때 항상 다음 부등식이 성립합니다([`thm_09`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L165)):
$$\frac{4}{3} < \text{sieveStep}(\alpha) < \alpha, \qquad \text{sieveStep}(\alpha) - \frac{4}{3} = \frac{2(3\alpha - 4)}{3(3\alpha - 1)}, \qquad \alpha - \text{sieveStep}(\alpha) = \frac{(3\alpha - 4)(3\alpha - 3)}{3(3\alpha - 1)}.$$

### 2.2 OpenAI의 선형화 근사식 vs. 정확한 뫼비우스 좌표 선형화

OpenAI의 `MainTheorem.lean:38, 439`는 비선형 점화식 $\tilde{\alpha}_{n+1} = \text{sieveStep}(\tilde{\alpha}_n)$을 직접 풀지 않고, $3\alpha - 1 > 3$을 이용해 느슨한 선형 상한선 `sieveExponent n`을 정의했습니다:
$$\alpha_n = \frac{4}{3} + \left(\frac{2}{3}\right)^{n+1} \implies \alpha_0 = 2, \; \alpha_1 = \frac{16}{9}, \; \alpha_2 = \frac{44}{27}, \; \alpha_3 = \frac{124}{81}.$$
1단계마다 버려지는 정확한 이차 여유분(quadratic slack)은 다음과 같습니다([`thm_10`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L182)):
$$\left(\frac{4}{3} + \frac{2}{3}\left(\alpha - \frac{4}{3}\right)\right) - \frac{6\alpha - 4}{3\alpha - 1} = \frac{2(3\alpha - 4)^2}{9(3\alpha - 1)} > 0.$$

반면 저희는 점화식의 두 고정점 $\alpha = 4/3$(매력적 고정점, 고유값 $2/3$)과 $\alpha = 1$(반발적 고정점, 고유값 $1$)을 이용한 **뫼비우스 변환**
$$u(\alpha) = \frac{\alpha - 4/3}{\alpha - 1} = \frac{3\alpha - 4}{3(\alpha - 1)}$$
을 도입했습니다. 그러면 비선형 점화식이 **오차 없이 정확히 등비수열**로 바뀝니다([`thm_11`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L206)):
$$u(\text{sieveStep}(\alpha)) = \frac{\frac{6\alpha - 4}{3\alpha - 1} - \frac{4}{3}}{\frac{6\alpha - 4}{3\alpha - 1} - 1} = \frac{2(3\alpha - 4)}{3(3\alpha - 3)} = \frac{2}{3}\,u(\alpha).$$
초기값 $\tilde{\alpha}_0 = 2$에서 $u(2) = 2/3$이므로 $u(\tilde{\alpha}_n) = (2/3)^{n+1}$이며, 역변환하면 모든 $n \ge 0$에 대한 **정확한 닫힌 공식(closed form)**을 얻습니다([`thm_12`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L229), [`thm_13`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L252)):
$$\tilde{\alpha}_n = \frac{\frac{4}{3} - \left(\frac{2}{3}\right)^{n+1}}{1 - \left(\frac{2}{3}\right)^{n+1}} \implies \tilde{\alpha}_0 = 2, \; \tilde{\alpha}_1 = \frac{8}{5}, \; \tilde{\alpha}_2 = \frac{28}{19}, \; \tilde{\alpha}_3 = \frac{92}{65}.$$
특히 $4/3$을 초과하는 잔여 오차를 비교하면
$$\frac{\tilde{\alpha}_n - 4/3}{\alpha_n - 4/3} = \frac{\frac{1}{3}(2/3)^{n+1} / (1 - (2/3)^{n+1})}{(2/3)^{n+1}} = \frac{1}{3\left(1 - (2/3)^{n+1}\right)} \xrightarrow{n \to \infty} \frac{1}{3}$$
으로서, 정확한 점화식의 잔여 오차가 OpenAI 상한선의 **점근적으로 $1/3$**에 불과합니다!

### 2.3 포아송 쌍대 절단 지수 (`ScalarBounds.lean`)와 `CubicGram` 4제곱 인자 분해

- **`CubicGauss/ScalarBounds.lean:45–160` (`thm_14`)**: 쌍대 절단점 $K = d(N/k)^2/M$에서 1차 영빈도 항과 진동 적분 상한이 모두 정확히 $(M(N/k)d)^{2/3}$과 일치하여 쌍대 손실이 $0$임을 증명합니다([`thm_14`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L270)).
- **`CubicGram/MainTheorem.lean:155–227` (`thm_15`)**: 반단순 그램 행렬식(semisimple Gram determinant)의 원시 3차 지표 합이 아이젠슈타인 소수 $\pi$에서 $|\tau(\chi_\pi)|^4 = p^2$로 정확히 4제곱 인자 분해되어 대각 지배성 $p^2 \le p^3$을 만족함을 증명합니다([`thm_15`](../proofs/qrh_eleven_twelfths_and_cubic_large_sieve.lean#L289)).
