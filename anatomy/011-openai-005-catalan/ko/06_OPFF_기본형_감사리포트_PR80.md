# 감사 요약 리포트: OpenAI #005 (PR #80: Catalan's Constant Is Irrational)

- 감사 대상: OpenAI openai/math Family #005 (build/main.tex 및 build/sections/*.tex 9개 파일 · 3,001줄, references.bib 28개 키 · 319줄, \cite 호출 37회; OAI/NumberTheory/Catalan/ 981개 .lean 파일 · 573,816줄 + ComparatorChallenges/Catalan.lean 13줄 = 982개 파일 · 573,829줄 + lean/patches/PrimeNumberTheoremAnd-lean4341.patch 39,904줄) / 제출 PR: [mathcommunity/oai-math-revised#80](https://github.com/mathcommunity/oai-math-revised/pull/80) (헤드 커밋 e0bd547)
- 검증 환경: Lean 4 v4.29.0-rc8 (감사 대상 v4.34.1 대조) / Python 3.14 (SymPy 기호 연산기)
- 산출물 해시 (SHA-256): [catalan_rows_two_adic_and_odd_primes.lean](../proofs/catalan_rows_two_adic_and_odd_primes.lean) (194cfca5ed0b...) | [catalan_palindromic_frobenius_and_modular.lean](../proofs/catalan_palindromic_frobenius_and_modular.lean) (c4d28ebdd6a9...) | [catalan_real_place_energy_and_contradiction.lean](../proofs/catalan_real_place_energy_and_contradiction.lean) (77b4a4c45c9d...) | [verify_symbolic_catalan005.py](../proofs/verify_symbolic_catalan005.py) (b555a159da0e...)
- 검증 방식: 독립 Lean 4 정리 75개 + def 3개 (1,336줄, 0 sorry, 0 axiom, 432 / 432 전칭 가설 변이 사살 = 100%) 및 결정론적 SymPy 재현 스크립트
- OPFF 공식 판정: Gate 1: FAIL · Gate 2: FAIL · Gate 3: FAIL · Gate 4: FAIL · Gate 5: PASS ⇒ OPFF TIER F (업스트림 원저자 고지문 17줄 행 보존 공백 치환, 외부 네임스페이스 46개 파일 무귀속 배치, 전체 코드 줄 수의 78.3% 미도달 및 원고-아티팩트 불일치로 인한 규격 부적격 판정)

## 0. 8대 핵심 지표 요약표

| 감사 축 | 원고(PDF / 공시 문서) 표방 내용 | 실제 저장소(Lean 4 / PrimeNumberTheoremAnd-lean4341.patch) 실측치 | 괴리율 / 상태 |
| :--- | :--- | :--- | :---: |
| 1. 코드 도달성 | Catalan/ 내 981개 .lean 파일 · 573,816줄 | 활성 증명 콘 48.2% (473 / 981개 · 124,449줄 = 21.7%) / 진입점 미도달 지층 51.8% (508 / 981개 · 449,367줄 = 78.3%) | 줄 수 기준 78.3% 미도달 (CP-05 FAIL) |
| 2. 루트 진입점 (Main.lean) | 29개 최상위 import 선언 (30줄, 정리 0개) | 실제 전파 1 / 29개 (Results.Catalan, 3.4%) / 미전파 루트 임포트 28 / 29개 (96.6%) | 96.6% 미전파 (CP-05 FAIL) |
| 3. 원고 Table 1 대 실제 코드 | Table 1에 법 101($\mathbb{F}_{101}$) 가우스 소거 피벗 144개($3\times 48$) 수록 | FixedGaussian* 147개 파일 (376,998줄 = 65.7%) 전량 미도달; 활성 코드는 64자리 정수 상수 `S_scale`(L494, L504, L514)로 분모 소거 후 $\operatorname{ZMod} 101$ 우역행렬 `M * R = I` (523줄) 사용 | 원고-코드 불일치 (CP-04 FAIL) |
| 4. 수식 (5.15) $(n!)^2$ 인자 | real-place.tex:407-408에서 "Factorials, measure masses, and sheet sums have all been accounted for explicitly."라고 서술 | RealDeterminantUpper.lean:27에서 `/ ((n N).factorial : ℝ)^2` 정의 후 L39-50에서 $1 \le ((n N)! : \mathbb{R})^2$으로 $(n!)^2$을 1로 이완하고 앞 인자를 $(2An)^n$으로 상계 | 팩토리얼 인자 이완 (CP-07 FAIL) |
| 5. 외부 의존성 패치 | lean/patches/PrimeNumberTheoremAnd-lean4341.patch (39,904줄, 55개 블록) | PrimeNumberTheoremAnd/IEANTN/Mertens(oai_ref 미수록, 헝크 @@ -284,23 +284,23 @@, 업스트림 287-303행, 발췌 [PrimeNumberTheoremAnd-lean4341.patch#L228-L284](../proofs/oai_ref/patches/PrimeNumberTheoremAnd-lean4341.patch#L228-L284))의 Kontorovich–Tao `section blueprint_comment` 고지문 17줄을 빈 줄 17개(0x0A $\times 17$)로 치환 + 외부 PrimeNumberTheoremAnd/ 하위에 자체 파일 46개(+33,333줄) 배치 | 고지문 치환 및 무귀속 배치 (CP-03 · CP-12 FAIL) |
| 6. 인용 분포 및 원저 귀속 | 9개 .tex 파일 (3,001줄) 내 \cite 호출 37회 (28개 .bib 키) | `main.tex`(44줄) + `introduction.tex`(208줄) + `conclusion.tex`(51줄) (= 303줄, 10.1%)에 30 / 37회 (81.1%, 100줄당 9.90회) 집중 vs. §2–§7(2,698줄)에 7 / 37회 (18.9%, 100줄당 0.26회 = 38.1 : 1 편중); PrimeNumberTheoremAnd 및 12대 1차 원저 누락 | 38.1 : 1 편중 / 12종 누락 (CP-09 · CP-10 FAIL) |
| 7. 활성 콘 전제·네임스페이스 위생 | 0 sorry, 0 axiom (커널 타입체크 통과) | 더미 바인딩 1건 (have _ := hlo), 콜론 뒤 필터 1건, 미사용 _h* 바인더 8건, 동일 네임스페이스 내 동명 private theorem 중복 선언 13쌍 | 전제·중복 경고 (CP-01 · CP-06 WARN) |
| 8. 아델-아르키메데스 코어 유효성 | 카탈란 상수 무리수성 ($G = \sum_{n=0}^\infty (-1)^n/(2n+1)^2 \notin \mathbb{Q}$) | 유한 자리 지수 $> -2.29084$ 대 실수 자리 지수 $< -2.290939875 < -2.2909$ 모순 성립; OPFF 독립 정리 75개(1,336줄, 432/432 변이 사살)로 재검증 완료 | 실제 난제 돌파 (Gate 5 PASS) |

## 1. 영역별 실측 물증 요약

### 1.1 서지 편중성(서론·결론 81.1%, 밀도비 38.1 : 1) 및 12대 1차 원저 귀속 결손 (CP-09, CP-10)
- 기술 본문(89.9%)의 인용 기근: 전체 9개 build/*.tex 파일(3,001줄, \cite 호출 37회, .bib 키 28개) 중 `main.tex`(44줄) + `introduction.tex`(208줄) + `conclusion.tex`(51줄) = 303줄(10.1%)에 인용의 81.1%(30 / 37회, 100줄당 9.90회)가 집중된 반면, 실제 증명이 전개되는 §2~§7(2,698줄, 89.9%)에는 단 7회(18.9%, 100줄당 0.26회, 밀도비 38.1 : 1)만 배치되어 있습니다.
- 기반 라이브러리 및 12대 고전 원저 누락 (PR #80에서 복원): `Descartes1637`은 `certificate.tex:186`에서 인용되고 `references.bib:285-294`에도 수록된 반면, 39,904줄의 패치를 적용해 직접 의존한 Kontorovich–Tao `PrimeNumberTheoremAnd` (2024–2026)를 원고에서 누락하는 등 총 12종의 1차 문헌(Catalan (1865), Legendre (1808), Kummer (1852), Binet (1813), Cauchy (1815), Cauchy (1841), Andréief (1886), Hadamard (1893), Hadamard (1896), de la Vallée Poussin (1896), Newman (1980), Kontorovich–Tao (2024–2026))이 누락되었습니다.

### 1.2 업스트림 패치 고지문 17줄 행 보존 공백 치환 및 외부 네임스페이스 46개 파일 배치 (CP-03, CP-12)
- 외부 네임스페이스 하위 46개 파일 무귀속 배치: lean/patches/PrimeNumberTheoremAnd-lean4341.patch(39,904줄, 55개 diff 블록: 신규 생성 파일 47개 +33,333줄 + 기존 파일 8개 수정 +989 / -3,447줄)는 외부 PrimeNumberTheoremAnd/ 네임스페이스 하위에 자체 생성 파일 46개를 신설했습니다.
- 원저자 고지문 17줄의 개행 공백(0x0A) 치환 및 귀속 헤더 불균형: 패치는 PrimeNumberTheoremAnd/IEANTN/Mertens(oai_ref 미수록, 헝크 @@ -284,23 +284,23 @@, 업스트림 287-303행, 발췌 [PrimeNumberTheoremAnd-lean4341.patch#L228-L284](../proofs/oai_ref/patches/PrimeNumberTheoremAnd-lean4341.patch#L228-L284))의 테렌스 타오 `section blueprint_comment` 고지문 17줄(287-303행)을 삭제하고 정확히 동일한 줄 수의 개행 공백 17줄(0x0A $\times 17$)로 치환했으며, 업스트림 Wiener 모듈의 미완성 구간 -2,716줄을 절단하고 blueprint_comment 주석 블록 109줄(6 + 6 + 29 + 68줄)을 동일 바이트 수의 ASCII 스페이스(0x20)로 치환했습니다. 수정된 `Wiener.lean` 상단에는 5줄짜리 `Adapted from PrimeNumberTheoremAnd...` Apache-2.0 헤더(발췌 [L184-L188](../proofs/oai_ref/patches/PrimeNumberTheoremAnd-lean4341.patch#L184-L188), `SiegelZeros/NOTICE.md` [L153](../proofs/oai_ref/patches/PrimeNumberTheoremAnd-lean4341.patch#L153) 병행)가 추가된 반면, 활성 콘 내 신설 `Catalan/*`·`ZetaFive/*` 14개 파일에는 라이선스·출처 헤더가 부재합니다. 한편 활성 콘이 경유하는 패치 사슬 10개 파일(2,937줄) 자체는 순수 Mathlib 위에서 0 sorryAx로 닫힙니다.

### 1.3 도달성 층서학 (줄 수 기준 78.3% 미도달) 및 원고-아티팩트 불일치 2건 (CP-04, CP-05, CP-07)
- 진입점 미도달 모듈 지층 (449,367 / 573,816줄 = 78.3%) 및 미전파 루트 임포트 (28 / 29 = 96.6%): OAI/NumberTheory/Catalan/ 내 981개 파일(573,816줄) 중 주정리가 도달하는 활성 콘은 473개 파일(48.2%, 124,449줄 = 21.7%)이며, 나머지 508개 파일(51.8%, 449,367줄 = 78.3%)은 미도달 지층입니다. 또한 Main.lean의 29개 루트 import 중 Results.Catalan 1개(3.4%)만 활성이고 28개(96.6%)는 주정리로 전파되지 않습니다.
- 원고-아티팩트 불일치 2건:
  1. 원고 Table 1 가우스 소거 대 실제 코드의 ZMod 101 우역행렬: 원고 Table 1이 보고한 법 101($\mathbb{F}_{101}$) 가우스 소거 피벗 144개($3\times 48$)에 대응하는 FixedGaussian* 파일 147개(376,998줄 = 전체의 65.7%)는 전량 미도달 상태이며, 실제 활성 코드(`FixedDeterminantsNonzero.lean`, 523줄)는 64자리 정수 상수 `S_scale`(L494, L504, L514)로 분모 소거 후 $\operatorname{ZMod} 101$ 위에서의 모듈러 우역행렬 곱셈 `M * R = I`($\det \equiv 27, 50, 74 \not\equiv 0 \pmod{101}$)으로 비영성을 증명합니다.
  2. 수식 (5.15) $(n!)^2$ 분모 인자 이완: 원고 real-place.tex:407-408은 "Factorials, measure masses, and sheet sums have all been accounted for explicitly."라고 서술하나, 실제 코드 RealDeterminantUpper.lean:27은 `/ ((n N).factorial : ℝ)^2`을 정의한 뒤 L39-50에서 $1 \le ((n N)! : \mathbb{R})^2$ 자명 하한으로 해당 인자를 1로 이완합니다.

### 1.4 수학적 돌파 유효성 공인 및 인간 · 고전 · AI 3층 기여도 분리
- 카탈란 상수 무리수성($G \notin \mathbb{Q}$) 최초 무조건부 해결 공인 (Gate 5: PASS): 테일러 차수 $L=59N$에서의 $\zeta(2)$ 상쇄, 2-진 완전제곱 완성 $-\frac{2809}{4608}\log 2$, 쿠머 단일 올림수 여과, 8구간 홀수 소수 적분 $\frac{8609}{2}$ ($> -2.29084$)과 회문 프로베니우스 블록 분해($\det U = 2^{p(p-1)/2}$), $\operatorname{ZMod} 101$ 우역행렬 인증서, 2겹 블라슈케-코시 등각 에너지 및 50점 데카르트 부호 구간($< -2.290939875 < -2.2909$)의 결합은 $G \notin \mathbb{Q}$를 엄밀히 증명하며, 본 감사단의 독립 Lean 4 정리 75개(1,336줄, 432/432 변이 사살)로 재검증되었습니다.
- 3층 기여도 분리: (1) 선행 인간 초월수론·등각 퍼텐셜·소수 정리 뼈대 60%, (2) AI $L=59N$ $\zeta(2)$ 상쇄, 회문 프로베니우스 분해, $\operatorname{ZMod} 101$ 인증서 및 473개 활성 모듈 0 sorry 형식화 코어 40% (Gate 5 PASS), (3) 업스트림 고지문 공백 치환, 외부 네임스페이스 46개 파일 배치, 78.3% 미도달 지층 및 Table 1·수식 (5.15) 원고-코드 불일치로 인해 원본 아티팩트는 OPFF TIER F로 판정됩니다.

## 2. 예상 반론에 대한 사전 사실 확인 (FAQ)

- Q1. "활성 Lean 4 증명 콘에서 카탈란 상수의 무리수성($G \notin \mathbb{Q}$)이 실제로 증명된 것이 맞는가?"
  - 사실 확인: 예. 473개 파일(124,449줄)로 이루어진 활성 증명 콘은 0 sorry, 0 커스텀 공리로 컴파일되며, 아델 하한($> -2.29084$)이 아르키메데스 상한($< -2.290939875 < -2.2909$)을 엄격히 넘어 모순을 유도함을 본 감사단의 독립 정리 75개(432/432 변이 사살)로 확인했습니다(Gate 5: PASS).
- Q2. "수학적 증명이 성립하는데 왜 원본 제출물의 등급이 OPFF TIER F인가?"
  - 사실 확인: OPFF 5대 관문 헌장에 따라, 업스트림 원저자 고지문 17줄을 행 번호 유지를 위해 빈 줄 17개(0x0A $\times 17$)로 치환한 행위(CP-03), 외부 라이브러리 네임스페이스(PrimeNumberTheoremAnd/) 하위에 자체 파일 46개(+33,333줄)를 무귀속 배치한 행위(CP-12), 그리고 실제 활성 증명과 무관한 376,998줄의 미도달 가우스 소거 코드를 원고 Table 1에 수록한 원고-아티팩트 괴리(CP-04, CP-05)는 Gate 1~4 결격 사유에 해당하기 때문입니다.
- Q3. "RealDeterminantUpper.lean:39-50에서 $((nN)!)^2 \ge 1$로 이완한 것이 무리수성 증명을 깨뜨리는가?"
  - 사실 확인: 깨뜨리지 않습니다. 등각 에너지와 쿠머 여과의 여유분($0.000099875$)이 충분히 커서 해당 인자를 1로 두어도 부등식이 성립하나, 원고(real-place.tex:407-408)가 이를 명시적으로 반영했다고 서술한 점이 원고-코드 불일치(CP-07)입니다.
- Q4. "미도달 FixedGaussian* 파일 147개(376,998줄 = 65.7%)는 왜 저장소에 남아 있는가?"
  - 사실 확인: 초기 법 101($\mathbb{F}_{101}$) 가우스 소거 트레이스($3\times 48 = 144$개 피벗)가 활성 코드(`FixedDeterminantsNonzero.lean`, 523줄)에서는 64자리 정수 상수 `S_scale`(L494, L504, L514)로 분모를 소거한 뒤 $\operatorname{ZMod} 101$ 우역행렬 곱셈 `M * R = I`로 검증하는 방식으로 대체되었으나, 원고 본문과 Table 1은 구형 가우스 소거 수치 그대로 남겨졌기 때문입니다(CP-04, CP-05).
- Q5. "PrimeNumberTheoremAnd/IEANTN/Mertens(oai_ref 미수록, 헝크 @@ -284,23 +284,23 @@, 업스트림 287-303행, 발췌 [PrimeNumberTheoremAnd-lean4341.patch#L228-L284](../proofs/oai_ref/patches/PrimeNumberTheoremAnd-lean4341.patch#L228-L284))의 빈 줄 17개와 109줄의 스페이스 패딩이 자동 포매터 때문일 가능성은 없는가?"
  - 사실 확인: 어떤 자동 포매터도 17줄의 영문 고지 주석을 삭제하면서 줄 번호 보존을 위해 정확히 17개의 개행 문자(0x0A)를 삽입하거나, 109줄의 LaTeX 블루프린트 주석을 바이트 길이가 일치하도록 ASCII 스페이스(0x20)로 치환하지 않습니다.
- Q6. "제출된 PR #80은 무엇을 교정하며, OPFF TIER A 승격 요건은 무엇인가?"
  - 사실 확인: PR #80은 누락된 PrimeNumberTheoremAnd 및 12대 1차 원저를 참고문헌에 복원하고 감사 내역을 공시합니다. 나아가 업스트림 고지문 17줄 복구 및 외부 네임스페이스 파일 46개 분리, 미도달 파일 508개(449,367줄) 및 Main.lean 미전파 임포트 28개 정리, 원고 Table 1과 수식 (5.15)의 활성 코드 정합화가 이루어지면 OPFF TIER A 요건을 충족합니다.

## 3. 10초 재현 명령어

```bash
# 1) 981개 파일 층서학(473 활성 / 508 미도달), Main.lean 28/29 미전파, 패치 감사 및 ZMod 101 우역행렬 실측 확인
python3 -B proofs/verify_symbolic_catalan005.py

# 2) 75개 독립 Lean 4 정리 커널 검증 (0 sorry, 0 axiom, 432/432 가설 변이 사살)
lean proofs/catalan_rows_two_adic_and_odd_primes.lean
lean proofs/catalan_palindromic_frobenius_and_modular.lean
lean proofs/catalan_real_place_energy_and_contradiction.lean
```
