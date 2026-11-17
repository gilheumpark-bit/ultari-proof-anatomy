# OpenAI 공개 추론 로그 10편 전편 (reasoning_traces/) 포렌식 해부 및 형식 검증 패키지

- English Guide: [README.md](README.md) | 상위 저장소: [ultari-proof-anatomy](../../README.ko.md)

본 해부는 OpenAI 공식 `openai/math` 저장소(HEAD `4eaee87548250b2682affda7d05d947c05554bae`)에 공개된 추론 로그 10편 전수(`reasoning_traces/*.pdf`, 총 202쪽, 추출 텍스트 9,308줄, 전체 373개 난제군 중 2.68%인 `#007`, `#017`, `#087`, `#102`, `#159`, `#197`, `#221`, `#271`, `#287`, `#362`)를 해당 난제군의 프리프린트 원고 22편(11편 추적 주원고 + 11편 로그 미공개 자매 원고, 이 중 18편 형식화 및 `#197`·`#271` 자매 원고 4편 미형식화), 범위 공시 문서 10편(`lean/docs/*.md`, 211줄), 비교 챌린지 21개(`ComparatorChallenges/*.lean`, 1,949줄), `OAI/` Lean 4 해법 파일 9,929개와 교차 대조해 전수 해부하고, 75개 독립 Lean 4 (v4.29.0-rc8) 정리(1,337줄, 0 sorry, 346/346 가설 변이 100% 포착, 74/75 대수·논리·보존 정리, 19개 비선형·귀납 증명, 이중 증인 모형 검증)로 재검증한 결과물입니다.



## 1. 4단계 문서 색인 (en/ & ko/)

| 단계 | 영문 문서 (en/) | 국문 문서 (ko/) | 핵심 범위 |
| :---: | :--- | :--- | :--- |
| Tier 1 | [en/01_Executive_Summary_and_General_Guide.md](en/01_Executive_Summary_and_General_Guide.md) | [ko/01_일반인용_해설서.md](ko/01_일반인용_해설서.md) | 5대 핵심 질문(Q1~Q5): 유일 잔존 사후 LuaLaTeX 요약 컴파일러(reasoning_traces/mezard-parisi-formula.tex, `\QuoteGlyphSetup` 내 미사용 한자 "自由" 폴백 및 #102 복잡도 매크로 상속), 69.28% (230/332) 추론 참고문헌 탈락 및 자사 동반 원고 100% (3/3) 누락과 사후 213건 교체, 다중 실행 봉합·프롬프트 비공개(#017, #287, #087), 22 -> 11 -> 9 -> 7 범위 축소 깔때기, OAI/ 내부 2,170개 미사용 가설 감사 |
| Tier 2 | [en/02_Intermediate_Math_and_Code_Guide.md](en/02_Intermediate_Math_and_Code_Guide.md) | [ko/02_중급자용_수학및코드가이드.md](ko/02_중급자용_수학및코드가이드.md) | 10개 난제군 전편 3대 기둥 도메인 수식·보존 원장 분리 해설, 75개 정리 1:1 매핑(thm_01~thm_75), 실시간 기호·원문 검증기 해설 |
| Tier 3 | [en/03_Expert_Forensic_and_Mathematical_Physics_Report.md](en/03_Expert_Forensic_and_Mathematical_Physics_Report.md) | [ko/03_전문가용_학술및수리물리보고서.md](ko/03_전문가용_학술및수리물리보고서.md) | 10편 전편 학술 심판 감사: mezard-parisi-formula.tex 211줄 컴파일러 층서학(L68, L76-L79), 332 대 315 양방향 인용 대조표(자카드 일치도 102/545 = 18.72%) 및 예상 반론 검증, 51개 `oai_ref/` 보존 원문 중 29개 핵심 선언 #L 색인, 10개 분야 수학 불변량, 3단계 범위 소실 깔때기 및 챌린지 스텁 위양성 5/5 대 OAI/ 내부 2,170개 공허 가설 불능 정리 |
| Tier 4 | [en/04_Automated_Verification_and_Parser_Spec.md](en/04_Automated_Verification_and_Parser_Spec.md) | [ko/04_자동검증및파서용_명세서.md](ko/04_자동검증및파서용_명세서.md) | 암호학적 SHA-256 체크섬 대조표 및 결정론적 원클릭 재현 명령 |
| OPFF 심사 | [en/05_OPFF_Detailed_Forensic_Referee_Report_Traces10.md](en/05_OPFF_Detailed_Forensic_Referee_Report_Traces10.md) | [ko/05_OPFF_상세형_포렌식심사보고서_Traces10.md](ko/05_OPFF_상세형_포렌식심사보고서_Traces10.md) | 7부 구성 OPFF 학술 최종 포렌식 심사 보고서(8대 지표 스코어카드, 3층위 기여 주체 분석, 6문 6답 FAQ 및 공식 판정문) |
| OPFF 요약 | [en/06_OPFF_Basic_Audit_Report_Traces10.md](en/06_OPFF_Basic_Audit_Report_Traces10.md) | [ko/06_OPFF_기본형_감사리포트_Traces10.md](ko/06_OPFF_기본형_감사리포트_Traces10.md) | OPFF 기본형 감사 리포트(OPFF TIER C: 8대 핵심 지표 요약표, 230/332 인용 탈락 및 18.72% 자카드 요약, 6문 6답 FAQ 및 10초 재현 명령어) |



## 2. 검증 산출물 (proofs/)

- [proofs/traces10_compiler_and_citation_drop.lean](proofs/traces10_compiler_and_citation_drop.lean#L1-L403) (Theorems 1-25, 403줄, 132/132 변이 포착, nonlin: 3)
- [proofs/traces10_algebraic_combinatorial_engines.lean](proofs/traces10_algebraic_combinatorial_engines.lean#L1-L469) (Theorems 26-50, 469줄, 99/99 변이 포착, nonlin: 8)
- [proofs/traces10_analytic_operator_and_scope_audit.lean](proofs/traces10_analytic_operator_and_scope_audit.lean#L1-L465) (Theorems 51-75, 465줄, 115/115 변이 포착, nonlin: 8)
- [proofs/verify_symbolic_traces10.py](proofs/verify_symbolic_traces10.py#L1-L341) $\to$ [proofs/symbolic_verification_result.json](proofs/symbolic_verification_result.json)
- [proofs/problem_spec.md](proofs/problem_spec.md) & [manifest.json](manifest.json)
