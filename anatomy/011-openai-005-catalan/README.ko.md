# Case 011: OpenAI `#005` (`Catalan's constant is irrational`): 포렌식 해부 및 형식 검증 패키지

> **English Guide**: [README.md](README.md) | **상위 저장소**: [`ultari-proof-anatomy`](../../README.md)

본 케이스(`011-openai-005-catalan`)는 OpenAI의 대표 수론 문제군 **`#005` (`Catalan's constant is irrational`, 2026년 9월 24일)**의 `9`개 LaTeX 원고 파일(`3,001`줄 + `references.bib` `319`줄)과 `OAI/NumberTheory/Catalan/`의 `981`개 Lean 4 파일(`573,816`줄; `ComparatorChallenges/Catalan.lean` 포함 시 `982`개 파일 / `573,829`줄) 전수를 수리·포렌식 관점에서 해부하고, `75`개 독립 Lean 4 정리(`1,333`줄, `0 sorry`, `432/432` 가설 변이 100% 포착, `69/75` 구조적 정리, `15`개 비선형·귀납 증명, `6`개 `∀ k : Nat` 귀납 정리, 이중 증인 검증)로 재검증한 패키지입니다.

---

## 1. 4단계 문서 색인 (`en/` & `ko/`)

| 단계 | 영문 문서 (`en/`) | 국문 문서 (`ko/`) | 핵심 범위 |
| :---: | :--- | :--- | :--- |
| **Tier 1** | [`en/01_Executive_Summary_and_General_Guide.md`](en/01_Executive_Summary_and_General_Guide.md) | [`ko/01_일반인용_해설서.md`](ko/01_일반인용_해설서.md) | 5대 인과적 질문 ($\zeta(2)$ 접촉 소거, $-2.29084$ 유한 자리 하한, 회문 프로베니우스 블록 분해 및 법 `101` 인증, `508/981 (51.8%)` 미도달 유령 장부, 2엽 실수 자리 에너지 및 `50`점 데카르트 루트 브래킷 상한 $< -2.290939875$) |
| **Tier 2** | [`en/02_Intermediate_Math_and_Code_Guide.md`](en/02_Intermediate_Math_and_Code_Guide.md) | [`ko/02_중급자용_수학및코드가이드.md`](ko/02_중급자용_수학및코드가이드.md) | 제2~8절 수식 파이프라인, `75`개 정리 매핑(`thm_01`–`thm_75`), 기호 검증기 해설 |
| **Tier 3** | [`en/03_Expert_Forensic_and_Mathematical_Physics_Report.md`](en/03_Expert_Forensic_and_Mathematical_Physics_Report.md) | [`ko/03_전문가용_학술및수리물리보고서.md`](ko/03_전문가용_학술및수리물리보고서.md) | `981`개 파일 층서학(`473`개 활성 vs `508`개 미도달 + `7`개 `ZetaFive` + `14`개 타오 팀 `PrimeNumberTheoremAnd` `.patch` 밀수), `58/58` `oai_ref/` `.tex`/`.lean`/`.patch` `#L` 라인 인용(`references.bib` 포함 `59`개), `13`개 중복 선언, `10`개 가설·필터 결함 + `((n N)!)^2 >= 1` 방기 괴리 수리, `28/28` `.bib` 인용 층서학 감사 |
| **Tier 4** | [`en/04_Automated_Verification_and_Parser_Spec.md`](en/04_Automated_Verification_and_Parser_Spec.md) | [`ko/04_자동검증및파서용_명세서.md`](ko/04_자동검증및파서용_명세서.md) | 암호학적 SHA-256 체크섬 대조표 및 원클릭 재현 명령 |

---

## 2. 검증 산출물 (`proofs/`)

- [`proofs/catalan_rows_two_adic_and_odd_primes.lean`](proofs/catalan_rows_two_adic_and_odd_primes.lean#L1-L446) (`Theorems 1–25`, `446`줄, `144/144` 변이 포착, `nonlin: 7`)
- [`proofs/catalan_palindromic_frobenius_and_modular.lean`](proofs/catalan_palindromic_frobenius_and_modular.lean#L1-L454) (`Theorems 26–50`, `454`줄, `153/153` 변이 포착, `nonlin: 6`)
- [`proofs/catalan_real_place_energy_and_contradiction.lean`](proofs/catalan_real_place_energy_and_contradiction.lean#L1-L433) (`Theorems 51–75`, `433`줄, `135/135` 변이 포착, `nonlin: 2`)
- [`proofs/verify_symbolic_catalan005.py`](proofs/verify_symbolic_catalan005.py#L1-L631) $\to$ [`proofs/symbolic_verification_result.json`](proofs/symbolic_verification_result.json#L1-L226)
- [`proofs/problem_spec.md`](proofs/problem_spec.md#L1-L19) & [`manifest.json`](manifest.json#L1-L524)
