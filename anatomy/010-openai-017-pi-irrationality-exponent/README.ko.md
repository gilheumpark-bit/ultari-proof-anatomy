# OpenAI #017 원주율 $\pi$의 무리수 지수 $\mu(\pi) = 2$ 및 Flint-Hills 급수 수렴 정밀 해부

- English Version: [README.md](README.md) | 상위 저장소: [ultari-proof-anatomy](../../README.ko.md)

이 자료는 OpenAI의 openai/math 코퍼스 중 초월수론 대표 문제인 Family #017 (The irrationality exponent of π is 2, 2026년 9월 24일)의 LaTeX 원고(5개 파일 1,591줄 + references.bib 269줄), Lean 4 형식화(869개 파일 94,948줄), 그리고 42쪽(45개 절) 분량의 추론 로그(irrationality-exponent-of-pi.pdf)를 전수 해부하고 75개의 Mathlib 4 실물 대수·해석 Lean 4 정리(1,646줄, 0 sorry, 0 커스텀 공리, 120/120 가설 변이 포착, 44개 비선형·귀납 증명, 이중 증인 검증)로 기계 검증한 종합 분석 아카이브입니다.



## 1. 4계층 문서 색인 (ko/ & en/)

| 계층 | 한국어 문서 (ko/) | 영문 문서 (en/) | 핵심 내용 |
| :---: | :--- | :--- | :--- |
| Tier 1 | [ko/01_일반인용_해설서.md](ko/01_일반인용_해설서.md) | [en/01_Executive_Summary_and_General_Guide.md](en/01_Executive_Summary_and_General_Guide.md) | 5대 인과적 질문(62/25 -> 2 도약, $b \in (1/2, 1-1/\nu)$, 리우빌 수 장애, 017.md 대 Main.lean 범위 대조, 3단 LCM 상수 지층 및 4대 이산·대수 치환) 해설 |
| Tier 2 | [ko/02_중급자용_구조및수식가이드.md](ko/02_중급자용_구조및수식가이드.md) | [en/02_Intermediate_Math_and_Code_Guide.md](en/02_Intermediate_Math_and_Code_Guide.md) | Sections 2–5 수식 파이프라인, 75개 Mathlib 4 정리(thm_01~thm_75) 매핑 및 수치 시뮬레이션 |
| Tier 3 | [ko/03_전문가용_수리물리및형식증명심사보고서.md](ko/03_전문가용_수리물리및형식증명심사보고서.md) | [en/03_Expert_Forensic_and_Mathematical_Physics_Report.md](en/03_Expert_Forensic_and_Mathematical_Physics_Report.md) | 869개 파일 층위학, 60개 oai_ref 전수 링크, 25개 BibTeX DOI 감사 및 6대 무인용 고전 원저 귀속 |
| Tier 4 | [ko/04_자동검증및파서용_명세서.md](ko/04_자동검증및파서용_명세서.md) | [en/04_Automated_Verification_and_Parser_Spec.md](en/04_Automated_Verification_and_Parser_Spec.md) | SHA-256 체크섬 테이블 및 원클릭 검증 프로토콜 |
| OPFF 심사 | [ko/05_OPFF_상세형_포렌식심사보고서_Pi017.md](ko/05_OPFF_상세형_포렌식심사보고서_Pi017.md) | [en/05_OPFF_Detailed_Forensic_Referee_Report_Pi017.md](en/05_OPFF_Detailed_Forensic_Referee_Report_Pi017.md) | OPFF 5대 관문 7부작 상세 포렌식 심사 보고서(Part 0–Part 7: 추론 로그 16/23 인용 탈락, 017.md:11 대 Main.flint_hills_summable, 4대 대수·이산 치환 및 OPFF TIER C 공식 판정) |
| OPFF 요약 | [ko/06_OPFF_기본형_감사리포트_Pi017.md](ko/06_OPFF_기본형_감사리포트_Pi017.md) | [en/06_OPFF_Basic_Audit_Report_Pi017.md](en/06_OPFF_Basic_Audit_Report_Pi017.md) | OPFF 기본형 감사 리포트(OPFF TIER C): 8대 핵심 지표 요약표(TL;DR), 핵심 실측 물증, 6문 6답 FAQ 및 10초 재현 명령어 |



## 2. 검증 아티팩트 요약 (proofs/)

- [proofs/pi_simplex_parameters_and_stratigraphy.lean](proofs/pi_simplex_parameters_and_stratigraphy.lean#L1-L509) (Theorems 1–25, 509줄, 28/28 변이 포착, nonlin: 8)
- [proofs/pi_transverse_multiplicity_and_seshadri_blowup.lean](proofs/pi_transverse_multiplicity_and_seshadri_blowup.lean#L1-L586) (Theorems 26–50, 586줄, 46/46 변이 포착, nonlin: 18)
- [proofs/pi_laurent_determinant_and_flint_hills.lean](proofs/pi_laurent_determinant_and_flint_hills.lean#L1-L551) (Theorems 51–75, 551줄, 46/46 변이 포착, nonlin: 18)
- [proofs/verify_symbolic_pi017.py](proofs/verify_symbolic_pi017.py#L1-L534) $\to$ [proofs/symbolic_verification_result.json](proofs/symbolic_verification_result.json#L1-L612)
- [proofs/problem_spec.md](proofs/problem_spec.md#L1-L18) 및 [manifest.json](manifest.json#L1-L509)
