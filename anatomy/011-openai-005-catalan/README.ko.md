# OpenAI #005 (Catalan's constant is irrational): 포렌식 해부 및 형식 검증

- 언어 선택: [English (README.md)](./README.md) | 한국어 | 상위 목차: [상위 해부 색인](../../README.ko.md)

이 자료는 OpenAI의 대표 수론 문제군 #005 (Catalan's constant is irrational, 2026년 9월 24일)의 9개 LaTeX 원고 파일(3,001줄 + references.bib 319줄)과 OAI/NumberTheory/Catalan/의 981개 Lean 4 파일(573,816줄; ComparatorChallenges/Catalan.lean 포함 시 982개 파일 / 573,829줄) 전수를 수리·포렌식 관점에서 해부하고, 75개 독립 Lean 4 정리(1,336줄, 0 sorry, 0 axiom, 432/432 가설 변이 100% 포착, 69/75 비자명 대수·귀납 정리, 15개 비선형·귀납 증명, 6개 ∀ k : Nat 귀납 정리, 이중 증인 검증)로 재검증한 아카이브입니다.

## 1. 6단계 문서 색인 (en/ & ko/)

| 단계 | 영문 문서 (en/) | 국문 문서 (ko/) | 핵심 범위 |
| :---: | :--- | :--- | :--- |
| Tier 1 | [en/01_Executive_Summary_and_General_Guide.md](en/01_Executive_Summary_and_General_Guide.md) | [ko/01_일반인용_해설서.md](ko/01_일반인용_해설서.md) | 5대 인과적 질문 ($\zeta(2)$ 접촉 소거, $-2.29084$ 유한 자리 하한, 회문 프로베니우스 블록 분해 및 법 101 인증, 508/981 (51.8%) 진입점 미도달 모듈 층위, 2엽 실수 자리 에너지 및 50점 데카르트 루트 브래킷 상한 $< -2.290939875$) |
| Tier 2 | [en/02_Intermediate_Math_and_Code_Guide.md](en/02_Intermediate_Math_and_Code_Guide.md) | [ko/02_중급자용_수학및코드가이드.md](ko/02_중급자용_수학및코드가이드.md) | 제2~8절 수식 파이프라인, 75개 정리 매핑(thm_01–thm_75), 기호 검증기 해설 |
| Tier 3 | [en/03_Expert_Forensic_and_Mathematical_Physics_Report.md](en/03_Expert_Forensic_and_Mathematical_Physics_Report.md) | [ko/03_전문가용_학술및수리물리보고서.md](ko/03_전문가용_학술및수리물리보고서.md) | 981개 파일 층서학(473개 활성 vs 508개 미도달 + 7개 ZetaFive + 14개 타오 팀 PrimeNumberTheoremAnd 패치 외부 네임스페이스 배치), 58/58 oai_ref/ TeX/Lean/patch #L 라인 인용(references.bib 포함 59개), 13개 중복 선언, 10개 바인더·필터 위생 관례(Class A / Gate 2 hygiene) 및 원고 정합 ((n N)!)^2 >= 1 점근 여유 확인, 28/28 .bib 인용 층서학 감사 |
| Tier 4 | [en/04_Automated_Verification_and_Parser_Spec.md](en/04_Automated_Verification_and_Parser_Spec.md) | [ko/04_자동검증및파서용_명세서.md](ko/04_자동검증및파서용_명세서.md) | 암호학적 SHA-256 체크섬 대조표 및 원클릭 재현 명령 |
| Tier 5 | [en/05_Detailed_Forensic_Referee_Report.md](en/05_Detailed_Forensic_Referee_Report_Catalan005.md) | [ko/05_상세형_포렌식심사보고서.md](ko/05_상세형_포렌식심사보고서_Catalan005.md) | 5대 관문(제0부~제7부) 전수 감사 및 TIER C 판정서 (`Gate 1: PASS`) |
| Tier 6 | [en/06_Basic_Audit_Report.md](en/06_Basic_Audit_Report_Catalan005.md) | [ko/06_기본형_감사리포트.md](ko/06_기본형_감사리포트_Catalan005.md) | 기본형 감사 요약 리포트: TL;DR 8대 지표 요약표, 실측 물증, 6문 6답 FAQ 및 10초 재현 명령 |

## 2. 검증 산출물 (proofs/)

- [proofs/catalan_rows_two_adic_and_odd_primes.lean](proofs/catalan_rows_two_adic_and_odd_primes.lean#L1-L446) (Theorems 1–25, 446줄, 144/144 변이 포착, nonlin: 7)
- [proofs/catalan_palindromic_frobenius_and_modular.lean](proofs/catalan_palindromic_frobenius_and_modular.lean#L1-L454) (Theorems 26–50, 454줄, 153/153 변이 포착, nonlin: 6)
- [proofs/catalan_real_place_energy_and_contradiction.lean](proofs/catalan_real_place_energy_and_contradiction.lean#L1-L436) (Theorems 51–75, 436줄, 135/135 변이 포착, nonlin: 2)
- [proofs/verify_symbolic_catalan005.py](proofs/verify_symbolic_catalan005.py#L1-L495) $\to$ [proofs/symbolic_verification_result.json](proofs/symbolic_verification_result.json#L1-L226)
- [proofs/problem_spec.md](proofs/problem_spec.md#L1-L19) & [manifest.json](manifest.json)

## 3. 1줄 검증 명령어

이 사례 폴더에서 아래 명령어를 실행하면 SHA-256 해시, Lean 4 커널, SymPy 재현, `#L` 링크 및 전칭 가설 돌연변이 시험을 일괄 검증합니다.

```bash
python3 ../../tools/verify_all.py --root .
```
