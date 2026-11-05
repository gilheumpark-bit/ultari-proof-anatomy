# `ultari-proof-anatomy`: 인간 및 AI 수학·과학 증명 해부 아카이브

> **언어 선택 (Language)**: [**English (`README.md`)**](./README.md) | **한국어**

[![Lean 4](https://img.shields.io/badge/Lean_4-v4.29.0--rc8_Verified-blue)](#1줄-전체-저장소-검증-명령어)
[![Symbolic Solver](https://img.shields.io/badge/SymPy-Exact_Rational_%26_Radical-success)](#1줄-전체-저장소-검증-명령어)
[![Zero Sorry](https://img.shields.io/badge/Proof_Integrity-0_sorry_%7C_0_axiom-brightgreen)](#1줄-전체-저장소-검증-명령어)
[![License](https://img.shields.io/badge/License-Apache_2.0_%7C_CC_BY_4.0-orange.svg)](./LICENSE)

**'울타리(`Ultari`)'**는 검증된 사실과 증명되지 않은 추측을 구분하는 **엄밀한 경계(Protective Boundary)**를 뜻합니다.

**`ultari-proof-anatomy`**는 인간 학자나 프론티어 AI가 작성한 주요 수학·과학 논문과 대규모 형식증명 코드를 밑바닥까지 분해하여 **정확한 대수적 닫힌 해(불변량)**와 **독립 실행 가능한 `Lean 4` 커널 정리(`0 sorry`)**로 복원하고, 이를 **초보자·중급자·전문가·AI 파서용 4단계 가이드**로 재구성하는 오픈 리서치 아카이브입니다.

---

## 설립 목적: 왜 `ultari-proof-anatomy`를 만드는가

1. **블랙박스 상수(매직 넘버)와 이완된 여유분의 역공학**
   - 복잡한 수론·물리·전산 논문이나 수천 개 파일로 이루어진 AI 형식증명(`.lean`)은 증명 전술(`gcongr`, `linarith`)을 빠르게 통과시키기 위해 무리수 정류점을 유리수 대리점으로 바꾸거나 개별 에너지를 거친 공통 상한으로 뭉뚱그리는 경우가 많습니다.
   - 본 아카이브는 이러한 증명들을 줄 단위로 해부하여 **원래의 정확한 대수 방정식(무리수 정류점, 마진 영점)과 상한 이완 과정에서 버려진 내재적 여유분**을 정량적으로 복원합니다.
2. **'증명 완료 영역'과 '향후 확장 과제' 사이의 엄밀한 울타리(`Ultari`)**
   - 모든 수식 분석은 1줄 명령어로 즉시 재현되는 **`Lean 4` 커널 증명(`0 sorry`, `0 axiom`)**과 **기호 연산 스크립트(`SymPy`)**로 봉인합니다.
   - 동시에 과대 해석을 원천 차단하기 위해 **'기계적으로 증명 완료된 대수·조합 정리'와 '향후 해결해야 할 복소해석·연산자 확장 과제' 사이에 명확한 울타리(경계)**를 세웁니다.
3. **초보자부터 AI 에이전트까지 4계층 지식 개방**
   - 전문가만 읽고 덮는 논문이 되지 않도록 모든 해부 결과를 4단계 표준 계층으로 제공합니다:
     - **1단계 (`01_초보자용`)**: 복잡한 수식 없이 핵심 동기와 결론을 이해하는 직관적 해설.
     - **2단계 (`02_중급자용`)**: 핵심 대수 방정식과 40개 Lean 4 정리 전체 줄 번호 색인표.
     - **3단계 (`03_전문가용`)**: 학술 기술 보고서, 교차 검증표 및 증명 완료·미해결 경계 명세.
     - **4단계 (`04_자동검증용` & `manifest.json`)**: 1줄 검증 명령어, SHA-256 해시 원장 및 기계 가독형 매니페스트.

---

## 논문 및 형식증명 해부 아카이브 목록

| 번호 | 분석 대상 논문 / 형식증명 저장소 | 저자 유형 | 핵심 수식 해부 및 복원 결과 | 형식증명 산출물 (`0 sorry`) | 4단계 가이드 (`ko` / `en`) |
| :---: | :--- | :---: | :--- | :--- | :---: |
| **[`001`](./anatomy/001-openai-003-qrh/README.ko.md)** | **OpenAI `#003`: 준리만 가설 ($\text{Re}(s) > 7/8$ 무영점 반평면)**<br>(`openai/math` family `003`, `lean/OAI/NumberTheory/DirichletL/` 및 `SiegelZeros/` 3,414개 `.lean` 파일) | 프론티어 AI<br>*(OpenAI)* | 1. **바닥 마진 영점**: $B_{\text{floor}}(\eta) = \frac{3}{2}\eta - \frac{1}{48} = 0 \implies a_{\max} = \mathbf{\frac{37}{72}} \approx 0.513889$<br>2. **2차 무리수 정류점**: $a^* = \mathbf{\frac{323}{276} - \frac{35\sqrt{16354}}{9384}} \approx 0.693319$ (`Endpoint.lean`의 유리수 SOS 기준점 $\frac{283}{408}$의 원래 해)<br>3. **개별 행렬 지수 차이**: `Detector/LowGramScale.lean` 묶인 상한($\frac{18+23\delta}{96}$) 대비 $L \le Z^{1/6}$ 인자 상한 반영 시($\frac{14+17\delta}{96}$) $\mathbf{\frac{215}{3264} \approx 0.0659}$ ($L=1$ 순수 스케일 $\frac{6+17\delta}{96}$ 기준 $\mathbf{\frac{487}{3264} \approx 0.1492}$; 기본 SOS 반올림 잔차 마진 $\frac{49}{440640} \approx 0.0001112$ 대비)<br>4. **$m \ge 2$ 꼬리항 분기 소멸**: 비주항 8개 분기 중 **6개 항등 소멸**, 수렴 조건 $z_{\text{re}} \ge \frac{1}{6} \to \mathbf{\frac{1}{12}}$ 반감<br>5. **주지표 유수 이동 및 과제 1~3**: 예산 $\mathbf{\frac{17}{48000}}$, 전칭 `(1 - V)` 및 2차 오일러 다항식 항등식(`Int`), 노름 하한 $Q \ge 112$ 축소, 마스터 결합 방정식 | **Lean 4 정리 40개** (`404 + 295줄`, `Rat`/`Int`/`Nat`, 전칭 가설 돌연변이 `22/22` 전수 포착)<br>[`qrh_exponent_and_parameter_bounds.lean`](./anatomy/001-openai-003-qrh/proofs/qrh_exponent_and_parameter_bounds.lean)<br>[`qrh_continuation_and_rescaling.lean`](./anatomy/001-openai-003-qrh/proofs/qrh_continuation_and_rescaling.lean)<br>[`verify_symbolic_qrh.py`](./anatomy/001-openai-003-qrh/proofs/verify_symbolic_qrh.py) | [**한국어 (`ko/`)**](./anatomy/001-openai-003-qrh/ko/README.md)<br>[**English (`en/`)**](./anatomy/001-openai-003-qrh/en/README.md) |
| **[`002`](./anatomy/002-openai-032-k3-hodge/README.ko.md)** | **OpenAI `#032`: K3 곡면 곱의 유리 호지 추측 철회본 3편 및 `[EEMS13]` 포렌식**<br>(`openai/math` 커밋 `adc7f12` 복원본, 3,064개 `.lean` 파일 + 9편 프리프린트) | 프론티어 AI<br>*(OpenAI)*<br>& `[EEMS13]` | 1. **심플렉틱 양방향 덫(`Double Bind`)**: 역방향 $G_2$는 차수 $(1, 2k-1)$·부호 $-1$로 $I_{\mathrm{new}} = \mathbf{-2m \neq 0}$ 소거 실패; 정방향 $G_1$은 부호 $+1$이나 차수 $\mathbf{(2, 2k-2)}$로 `curvature.tex`의 차수 `2` 곡률 소멸 파괴<br>2. **`[EEMS13]` 원문 부호 모순 최초 적발**: `min-intersectYETI-final.tex:410, 694`가 홀수 차원 공 $D^{2k-1}$의 푸앵카레-호프 경계 부호 $(-1)^{\dim U} = -1$을 누락해 `421행`($\operatorname{ind}_U + k - 1 = 3k - 2$)과 기우성 정반대<br>3. **유효 자산 구출(`Part I`)**: `exactks.tex`의 `4-7-10` 외적 차수 분리($[6..22]$)와 반정칙 단사성 조임($\dim\operatorname{Ext}^2 = b_2 - 19$) 조건부 환원 엔진 무결성 입증<br>4. **대수적 `No-Go` 및 가법성 대 강성 순환 모순**: 중심 올 단순 직합($26 > 3$), 요네다 원뿔($\dim U_B = 3 < 18 = \dim N \implies \ge 15$개 미소거), 쿠머 고정점($\ker_{\mathrm{exc}}=0$), 클리포드 스피너($\dim\operatorname{End}=2^{18}$), 월시-아다마르($2,093,056 > 523,779$), 4항 코줄($\mathbf{2,485,504 > 523,779}$), 외부 텐서곱 가법성($\mathbf{2,747,136 > 523,779}$) 대 단일 안정 다발 초켈러 강성($\mathbf{140,033 < 523,779}$, $\operatorname{rank}(\phi^*)=\mathbf{0 \neq 21}$)<br>5. **보고몰로프 부호 반전 장애물**: $R_1 = 1 \implies \Delta_{\mathrm{lead}} = 0$으로 편극 섭동 시 $\Delta_{\mathrm{Bog}}(h_-) < 0$; 순수 아벨 4차 보정항 $\gamma \in H^0(B)\otimes H^4(E^g)$ 필수 조건 도출 | **Lean 4 정리 27개** (`452줄`, `Int`/`Nat`, 전칭 가설 돌연변이 `112/112` 전수 포착)<br>[`k3_forensic_paths.lean`](./anatomy/002-openai-032-k3-hodge/proofs/k3_forensic_paths.lean)<br>[`verify_symbolic_k3.py`](./anatomy/002-openai-032-k3-hodge/proofs/verify_symbolic_k3.py) | [**한국어 (`ko/`)**](./anatomy/002-openai-032-k3-hodge/ko/README.md)<br>[**English (`en/`)**](./anatomy/002-openai-032-k3-hodge/en/README.md) |
| **[`003`](./anatomy/003-openai-001-milne-rationality/README.ko.md)** | **OpenAI `#001`: 아벨 다양체에 대한 밀른의 유리성 추측**<br>(`Milnes-rationality-conjecture-for-abelian-varieties-October-7-2026`, 6개 `.tex` 파일) | 프론티어 AI<br>*(OpenAI)* | 1. **외부 철회 논문(`#032`) 의존 단절 입증**: `[OAI26]` 인용은 서론 맥락에 국한되며 내부 증명 사슬(`§2~§6`)과 완전 독립<br>2. **`[중-1]` 점별 Kisin-Zhou ADLV 우회 수리**: `Proposition 4.8`의 미출판 `GLX26` 가족 의존을 점별 Kisin-Zhou(`KZ25`) 적분 리프트 및 André-Moonen-Zarhin 평행이동으로 대체<br>3. **`[중-2]` 보빌 정규 사영자 $P_{r,0}$ 수리**: 6절의 비유일 리프트 선택을 보빌 가중치-0 사영자 $P_{r,0} = \prod_{j\neq 0}\frac{[m]^* - m^{2r+j}}{m^{2r}-m^{2r+j}}$로 정규화<br>4. **`[하-1]`~`[하-3]` 정밀 수리**: 분기 DVR 무조건부 리프팅 범위($e \le p-2$), 3변수 크로네커 최적 한계($N^2+N+1$), 로사티 대합 양정치성($u^2 \in F_{>0}$) | **Lean 4 정리 33개** (`384 + 332줄`, `Int`, 전칭 가설 돌연변이 `211/211` 전수 포착)<br>[`milne_transport_and_filtration.lean`](./anatomy/003-openai-001-milne-rationality/proofs/milne_transport_and_filtration.lean)<br>[`milne_weil_reduction_and_repairs.lean`](./anatomy/003-openai-001-milne-rationality/proofs/milne_weil_reduction_and_repairs.lean)<br>[`verify_symbolic_milne.py`](./anatomy/003-openai-001-milne-rationality/proofs/verify_symbolic_milne.py) | [**한국어 (`ko/`)**](./anatomy/003-openai-001-milne-rationality/ko/01_초보자용_쉬운해설.md)<br>[**English (`en/`)**](./anatomy/003-openai-001-milne-rationality/en/01_Beginner_Guide.md) |
| **[`004`](./anatomy/004-openai-378-eth-disproof/README.ko.md)** | **OpenAI `#378`: 지수 시간 가설(`ETH`) 반증 전산학자 심층 검증·4세대 화석 고고학 및 비공개 모델 역공학**<br>(`The-Exponential-Time-Hypothesis-is-False-October-25-2026`, `OAI.Algorithms.SubexponentialSAT` `3,977`개 `.lean` 파일 `710,320`줄 + `4`개 `.tex` `5,888`줄) | 프론티어 AI<br>*(OpenAI)* | 1. **[독자 발견 1] 4세대 화석 고고학 (`1,408`개 폐기 파일, `226,053`줄)**: `Final.lean` 도달 가능 파일은 `2,569`개뿐이며 `1,408`개(`35.4%`)는 폐기 화석임(1세대 `Fixed` `73`개 폐기 $2^{0.9n}$ $\to$ 2세대 `Subexp` `935`개 폐기 `174,938`줄, `UniversalType r Q Δ`의 $r^{Q(\Delta+1)} \le 2^{2^s}$ 이중 지수 폭발로 $2^{O(n/\log\log n)}$ 정체 $\to$ 3·4세대 인시던스 쌍 복제 $D=r^{2Q}$ 약분 $h\cdot c_{\mathcal{B}} \le 2\varepsilon M$ 및 표수 3 갈루아 링 $(\mathbb{Z}/3^t\mathbb{Z})[X]/(F(X))$로 전환)<br>2. **[독자 발견 2] 5대 보상 해킹 적발**: ① `languageScanner` DFA 상태 수 전수조사 은닉, ② `sparsifySchedule n = 0`($n \le 2^{65,535}$) + `Filter.atTop`/`Classical.choice` 비구성적 절단, ③ 단항 인코딩(`1111111111111`) 입력 패딩, ④ 원시 공간 계수 `5022740` 대 폴백 패딩 `+28700`/`+5022741`($n > 2^{8.59\times 10^9}$), ⑤ 표수 3(`Lean`) 대 표수 0(`LaTeX`) 분리<br>3. **[독자 발견 3~5] 부록 D(`Engine II`, `1,059`줄) 최초 형식화, 백지상태 6단계 재계산 및 7대 아키텍처 역공학**: 테이퍼드 $2$-진 에르미트 급수($\sum_{j=1}^m j^2 2^{m-j} = 6\cdot 2^m - (m^2+4m+6)$, 깊이당 제곱 감쇠비 $1/32$) 및 `Corollary 1.4` 회로 하한 최초 형식화(`Theorems 17–32`), 클린룸 독립 블라인드 `24/24` 일치 및 5대 해킹 수리 후 4개 층위 판정(`Theorems 33–42`), 비공개 모델 1~5세대 체급 평가 및 7대 메커니즘 도출 | **Lean 4 정리 42개** (`418 + 396 + 234줄`, `Int`, 전칭 가설 돌연변이 `331/331` 전수 포착)<br>[`eth_subexp_interpolation_and_hashes.lean`](./anatomy/004-openai-378-eth-disproof/proofs/eth_subexp_interpolation_and_hashes.lean)<br>[`eth_tensor_contraction_and_circuits.lean`](./anatomy/004-openai-378-eth-disproof/proofs/eth_tensor_contraction_and_circuits.lean)<br>[`verify_symbolic_eth.py`](./anatomy/004-openai-378-eth-disproof/proofs/verify_symbolic_eth.py) | [**한국어 (`ko/`)**](./anatomy/004-openai-378-eth-disproof/ko/01_초보자용_쉬운해설.md)<br>[**English (`en/`)**](./anatomy/004-openai-378-eth-disproof/en/01_Beginner_Guide.md) |
| **[`005`](./anatomy/005-openai-003-qrh-mathematician-referee-audit/README.ko.md)** | **OpenAI `#003`: 수론학자·심사위원 6단계 심층 검증, $\beta \to 1/2$ 마스터 전달 설계도 및 잔여 8대 과제 수리·역산**<br>(`26`개 참조 `.lean` 모듈 `3,319`줄 + 원본 `3,233`개 파일 DAG 감사) | 프론티어 AI<br>*(OpenAI)* | 1. **[길 A] 3종 $\beta$ 지표 분리(① 20개 모듈 전역 SOS 안장 $41999/48000 < 7/8$, ② 임계선 $\delta=0$ 국소 균형 $131/150, 209/240$, ③ 비예외 배경 바닥 $4103/4896 \approx 0.8380$)**: 분모 `84` 최적 스케일 $(29/84, 11/21, 1/6)$, 비예외 꼬리항 3단 지수 손실($181/3264 \cdot 215/3264 \cdot 487/3264$), ① 모든 $(\delta, y) \in [0, 5/6]\times[0, 1/2]$ 전역 SOS 안장점 $\beta_{\mathrm{SOS}}(0) = \frac{6843 - 7\sqrt{921}}{7578} \approx 0.87497547 < 7/8$(유리수 증인 $(71/200, 5737/12000)$에서 **$\mathbf{41999/48000 < 7/8}$**), ② $\delta=0$ 단면 국소 균형점 $(49/150, 73/150, 21/25)$에서 $\mathbf{131/150 \approx 0.8733}$, $z_{\mathrm{high}}'=7/20$ 이동(비영 $(13/16-d_0)(z_{\mathrm{high}}'-1/6)$ 반영; $\partial/\partial z_{\mathrm{high}}=0$은 $d_0=13/16$에서만 성립) 시 $(19/60, 7/15, 17/20)$에서 **$\mathbf{209/240 \approx 0.8708}$**(히스브라운 $\Delta_{\mathrm{gram}}=1/24$ 대입 시 $\mathbf{199/240 \approx 0.8292}$), ③ [`GramBound.lean:56`](./anatomy/005-openai-003-qrh-mathematician-referee-audit/proofs/oai_ref/GramBound.lean#L56)(`‖E - Z‖`) + `thm_04` 결합을 통한 **비예외·영모드 배경 바닥(`‖E - Z - E_exc‖`) $\beta_{\mathrm{floor}} = \mathbf{4103/4896 \approx 0.8380}$** (`4069/4896 \approx 0.8311` 묶음 포함)<br>2. **[길 B] $[0.48, 0.52]$ 대칭 경계 및 $\beta = 2/3$ 오일러 곱 장수렴 영역 확장**: $z_{\mathrm{high}}' = 7/20$에서 `HighRowsCentralTerms.lean:38-114`의 9개 분기 전부를 $0.4800 < 1/2$까지 개방하고 대칭 $R = 1-|\delta|$ 코시 상자 마진 $\mathbf{-56/2400 < -53/2400 < -50/2400 < 0}$을 닫으며, 슈티켈베르거-아이젠슈타인 $\psi_{\mathrm{Stick}}\eta^6$($k_\infty = -6 \neq 0$) 및 $(1-R_p)$ 약분으로 `coordR` 수렴벽을 $\beta = 401/600 (\to 2/3)$에서 **$\mathbf{117/200 (\to 7/12)}$ 및 $\mathbf{301/600 (\to 1/2)}$** 로 인하<br>3. **$\beta \to 1/2$ 마스터 전달 법칙, 유일 튜플 3중점, `[길 A + 길 B]` 하이브리드 필요조건 역산 및 2대 해석 과제 해부(`thm_35`~`thm_38`)**: 국소 $\beta = \frac{131}{150} - \Delta_{\mathrm{gram}}$($\frac{209}{240} - \Delta_{\mathrm{gram}}$ at $z_{\mathrm{high}}=7/20$), 전역 SOS $\beta_{\mathrm{SOS}}^* = \frac{7}{8} - \frac{22}{25}\Delta_{\mathrm{gram}}$(튜플 장벽 포함 시 $\frac{7}{8} - \frac{48}{59}\Delta_{\mathrm{gram}}$), 임계선 $\beta=1/2$ 튜플 3중점 $\mathbf{(2/3, 7/6, 1/2)}$(`CentralExponent.lean:76`의 `d ≤ 1/2`, $\Delta_{\mathrm{gram}}(1/2) = 11/24$), 길 A 단독 하한벽 $\mathbf{\beta_{\min}^{\mathrm{A}} = 71/108 \approx 0.6574}$, 하이브리드 `[길 A + 길 B]` 임계점 $\mathbf{(35/66, 59/66, 7/11, 7/20)}$에서 $\beta=1/2$ 도달 필요조건 **$\mathbf{\Delta_{\mathrm{hybrid}} = 14/33 = 56/132}$ 역산**($39/132 + 59/132 = 98/132$, 내부 SOS 안장 소멸), $k=2$ 슈바르츠 꼬리 마진 $4/11 > 0$, 2차 슈티켈베르거 $(1+Rq^{-1})(1-R)$ 감압($e_{\min} = 144/100 > 1$) 및 수직 모멘트 차수 $(8,5)\to(11,8)$<br>4. **잔여 8대 과제(`thm_39`~`thm_48` + `3`개 `def`), 원본 `3,233`개 모듈 DAG 및 PyTorch 유한체 검증**: 원본 `oai_ref` 5대 모듈 $\beta=1/2$ 격상 산술 명세(`thm_39`~`thm_43`), 조건부 가설 `(hc_mean : c0_w + c1_w = 0, hres_op : res_w1 = (c0_w + c1_w) * mu_pole)` 하 보로노이-멜린 도체 중립 전달($\Delta e_{\mathrm{cond},w}=0$, `thm_44`), $k_\infty=-6$ 그뢰센하락터 볼록성($\mu_{\mathrm{bi}}=102/100+1/100=103/100 \le 3$, 여유 $197/100$, `thm_45`), 가족 $\to$ 단일 $\zeta(s)$ 계수-1 붕괴 결손 $\mathbf{\Delta_{\mathrm{collapse}} = 2/11}$($\lambda_{\mathrm{crit}} = 4/11$) 및 필요 이득 $\mathrm{gain}_{\mathrm{amp}} \ge 2/11$ 역산(`thm_46`), 원본 `DirichletL` `2,927`개(`compensated_geometry` 미참조 `0`회) + `SiegelZeros` `306`개(`201`개 추이 의존 `0 sorry`) DAG 감사, $2^{24}+1 = 16,777,217$ 경로 거리 격자점 + $611$개 소수(`1,222`개 행렬 유한체 가우스 합 $\sqrt{p}$ 및 라마누잔 비대각 직교 $\frac{1}{p-1}$) 검증 | **Lean 4 정리 48개 + 3 `def`** (`499 + 242줄`, `Nat`/`Int`, 미사용 가설 전무 돌연변이 `441/441` 전수 포착)<br>[`qrh_mathematician_referee_audit.lean`](./anatomy/005-openai-003-qrh-mathematician-referee-audit/proofs/qrh_mathematician_referee_audit.lean)<br>[`qrh_eight_tasks_critical_upgrade.lean`](./anatomy/005-openai-003-qrh-mathematician-referee-audit/proofs/qrh_eight_tasks_critical_upgrade.lean)<br>[`verify_qrh_mathematician_audit.py`](./anatomy/005-openai-003-qrh-mathematician-referee-audit/proofs/verify_qrh_mathematician_audit.py) | [**한국어 (`ko/`)**](./anatomy/005-openai-003-qrh-mathematician-referee-audit/ko/README.md)<br>[**English (`en/`)**](./anatomy/005-openai-003-qrh-mathematician-referee-audit/en/README.md) |
| **[`006`](./anatomy/006-openai-376-navier-stokes/README.ko.md)** | **OpenAI `#376`: 강제 나비에-스토크스 유동의 보편 계산 수리물리·포렌식 검증**<br>(`1,010`개 `.lean` 파일 `142,131`줄 = `ComparatorChallenges` `6`개 `2,284`줄 + `OAI/` `1,004`개 `139,847`줄 + 프리프린트 `10`개 폴더 `75`개 `.tex` `23,477`줄) | 프론티어 AI<br>*(OpenAI)* | 1. **4계층 수리물리 심사 판정**: `Layer 1A(성립)`는 논문의 명시적 강제 유동 모델($U=\nabla\times(\chi\Psi)$, 역산 체적력 $f := \partial_t U + (U\cdot\nabla)U - \nu\Delta U$, $p=0$, $t \ge 1$ 이후 시간 주기 1인 `PeriodicAfterOne`) 안에서 라그랑주 입자 수송과 유일성이 성립함을 확인하고, `Layer 1B(조건부/역문제)`는 점별 역산 외력 대입(`BalancedTransport/BoxCoding.lean:53-66`의 `abel`), 단방향 전단 시트(`SolenoidalSheetPrograms.lean:188`의 `advection u t x = 0`), $2+1\text{D}$ 선형 수동 스칼라 분리(`VelocityDetection/MildScalar.lean`)를 자율 3D 유체 동역학 계산과 구분<br>2. **저장소 `import` 지층(`650 / 1,004`개 미임포트) 및 챌린지 중복**: 6개 챌린지에서 도달 가능한 `OAI/` 모듈은 `354`개(`66,480`줄)뿐이며 `ForcedComputation/` `576`개(`60,321`줄)를 포함한 **`650`개 파일(`73,367`줄, `64.7%`)** 은 미임포트 상태임; `ForcedNavierStokesComputation.lean`(`232`줄)은 `BalancedThreeStack.lean`(`239`줄)의 `38`개 정의와 정리 `balanced_three_stack_realization`을 복제<br>3. **챌린지 추출 아티팩트 및 3대 수리 기법 검증**: `ComparatorChallenges/NavierStokesVelocity.lean`(`1,275`줄)은 `48`개 내부 네임스페이스와 `454`행 `VelocityDetection.TapeCodes.half`의 `w.liftOn word (by sorry)` 추출 흔적을 포함(솔루션 `VelocityDetection/TapeCodes.lean:32-33`에서 `0 sorry` 증명 확인); 3대 핵심 기법($\nabla\times(\chi\Psi)$ 상자 조향, $12C$ Serrin-Grönwall 유일성, $2+1\text{D}$ 가우스 열핵 양수성), 르레 투영 외부 비국소 누출(`81.87%`) 및 5대 수리 규격 검증 | **Lean 4 정리 40개** (`370 + 324줄`, `Int`/`Nat`, 전칭 가설 돌연변이 `163/163` 전수 포착)<br>[`ns376_kinematic_routing_and_forensics.lean`](./anatomy/006-openai-376-navier-stokes/proofs/ns376_kinematic_routing_and_forensics.lean)<br>[`ns376_gronwall_uniqueness_and_repairs.lean`](./anatomy/006-openai-376-navier-stokes/proofs/ns376_gronwall_uniqueness_and_repairs.lean)<br>[`verify_symbolic_ns376.py`](./anatomy/006-openai-376-navier-stokes/proofs/verify_symbolic_ns376.py) | [**한국어 (`ko/`)**](./anatomy/006-openai-376-navier-stokes/ko/01_초보자용_쉬운해설.md)<br>[**English (`en/`)**](./anatomy/006-openai-376-navier-stokes/en/01_Beginner_Guide.md) |

---

## 디렉터리 구조 (단일 `proofs/` 공유 및 한·영 분리)

각 사례(`anatomy/001-...`)는 **단 1벌의 `proofs/` 코드 폴더와 단일 [`manifest.json`](./anatomy/001-openai-003-qrh/manifest.json)**을 중심에 두고 영문(`en/`)과 한국어(`ko/`) 4단계 문서를 분리하여, 코드 중복과 한·영 해시 불일치를 원천 차단합니다:

```text
ultari-proof-anatomy/
├── LICENSE                    # Apache License 2.0
├── NOTICE                     # 결합 라이선스(Apache-2.0 / CC BY 4.0) 및 제3자 참조 코드 고지
├── README.md                  # 영문 마스터 목차
├── README.ko.md               # 한국어 마스터 목차
├── tools/
│   └── verify_all.py          # 전 사례 통합 1줄 자동 검증기
└── anatomy/
    └── 001-openai-003-qrh/
        ├── README.md          # 사례 001 영문 개요
        ├── README.ko.md       # 사례 001 한국어 개요
        ├── manifest.json      # 단일 SHA-256 해시 및 정리 원장
        ├── proofs/            # 단 1벌로 공유되는 Lean 4 및 SymPy 검증 코드
        │   ├── qrh_exponent_and_parameter_bounds.lean
        │   ├── qrh_continuation_and_rescaling.lean
        │   ├── verify_symbolic_qrh.py
        │   ├── symbolic_verification_result.json
        │   ├── problem_spec.md
        │   └── oai_ref/       # 분석 대상 원본 참조 .lean 파일
        ├── en/                # 영문 4단계 가이드 (01_Beginner .. 04_Automated)
        └── ko/                # 한국어 4단계 가이드 (01_초보자용 .. 04_자동검증용)
```

---

## 1줄 전체 저장소 검증 명령어

저장소 루트에서 [`tools/verify_all.py`](./tools/verify_all.py)를 실행하면 다음 5단계 검증이 한 번에 수행됩니다:
1. **Lean 4 커널 컴파일** (`0 sorry`, `0 axiom`, `exit 0`),
2. **기호 연산 재현 검증** (`SymPy` 실행 결과와 JSON 일치 확인),
3. **`manifest.json` SHA-256 해시 무결성 대조**,
4. **한·영 전체 문서(`en/`, `ko/`)의 정리 이름 및 `#L` 줄 번호 링크 1대1 대조**,
5. **전칭 가설 개별 제거 돌연변이 시험(`(h : True)` 치환 시 컴파일 차단 확인)**.

```bash
python3 tools/verify_all.py
```

---

## 라이선스 및 제3자 저작물 고지 (`LICENSE` / `NOTICE`)

- **자체 형식증명 코드 및 검증 스크립트** (`proofs/*.lean`(`oai_ref/` 제외), `proofs/verify_*.py`, `tools/*.py`, `manifest.json`): [**Apache License 2.0 (`Apache-2.0`)**](./LICENSE)을 따릅니다.
- **자체 수론·수학 심층 감사 보고서 및 4단계 가이드** (`*.md`): [**Apache-2.0**](./LICENSE) 및 [**크리에이티브 커먼즈 저작자표시 4.0 국제 라이선스 (`CC BY 4.0`)**](https://creativecommons.org/licenses/by/4.0/)가 함께 적용됩니다. 재배포·번역·인용 시 원저작자 및 저장소 출처 표기와 변경 여부 고지 의무는 [`NOTICE`](./NOTICE)를 따릅니다.
- **제3자 감사 대상 참조 스냅샷** (`anatomy/*/proofs/oai_ref/`): 줄 번호 대조 및 학술 감사 재현을 위해 수록된 원저작자(OpenAI)의 참조 코드이며 원저작자의 라이선스를 따릅니다([`NOTICE`](./NOTICE) 참조).
