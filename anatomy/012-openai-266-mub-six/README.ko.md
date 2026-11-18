# OpenAI #266 (Mutually unbiased bases in dimension six): 포렌식 해부 및 형식 검증

- 언어 선택: [English (README.md)](./README.md) | 한국어 | 상위 목차: [전체 저장소 목차](../../README.ko.md)

이 자료는 OpenAI의 양자정보이론 대표 난제군 #266 (Mutually unbiased bases in dimension six, 2026년 9월 24일)의 두 프리프린트(N(6) = 3 컴퓨터 보조 원고: `openai/math` 커밋 `4eaee87` 기준 전체 12개 `.tex` 5,945줄 중 `9/12`개 절 파일 5,807줄을 `proofs/oai_ref/tex_mub/`에 수록 + `references_mub6.bib` 363줄 + 8개 `.cpp` 2,316줄, 그리고 복소 아다마르 푸리에 인증서 원고: 커밋 `4eaee87` 기준 전체 8개 `.tex` 1,997줄 중 `7/8`개 파일 1,934줄을 `proofs/oai_ref/tex_fourier/`에 수록 + `references.bib` 326줄 + `verify.py` 576줄)와 저장소 단일 최대 규모인 OAI/Analysis/MutuallyUnbiased/의 3,386개 Lean 4 파일(2,835,031줄) 및 OAI/LinearAlgebra/Hadamard/의 9개 파일(1,329줄) 전수를 해부하고, 75개 독립 Lean 4 정리(1,249줄, 0 sorry, 358/358 가설 변이 100% 포착, 74/75 대수·논리 정리, 14개 비선형·귀납 증명, 이중 증인 비공허성 검증)로 재검증한 아카이브입니다.

## 1. 6단계 문서 색인 (en/ & ko/)

| 단계 | 영문 문서 (en/) | 국문 문서 (ko/) | 핵심 범위 |
| :---: | :--- | :--- | :--- |
| Tier 1 | [Tier 1 Executive Summary (en/01_)](en/01_Executive_Summary_and_General_Guide.md) | [Tier 1 일반인용 해설서 (ko/01_)](ko/01_일반인용_해설서.md) | 5대 인과적 질문 (비소수 거듭제곱 $d=6$에서의 바일-유한체 붕괴, $z^6-e_3z^3+e_6$ 세제곱 섬유 및 5-순환 유일성, 바이너 $6\to 7$ 초연산자 보완 및 6개 슈어 블록 Positivstellensatz N(6) <= 5, 283.5만줄 전개 인플레이션과 고아 Attainable 3, Class A 공시 binary64 N(6) = 3 범위 분리) |
| Tier 2 | [Tier 2 Intermediate Math & Code Guide (en/02_)](en/02_Intermediate_Math_and_Code_Guide.md) | [Tier 2 중급자용 수학·코드 가이드 (ko/02_)](ko/02_중급자용_수학및코드가이드.md) | 3대 기둥 수식 파이프라인, 75개 정리 매핑(thm_01~thm_75), 기호 검증기 해설 |
| Tier 3 | [Tier 3 Expert Forensic Report (en/03_)](en/03_Expert_Forensic_and_Mathematical_Physics_Report.md) | [Tier 3 전문가용 학술·수리물리 보고서 (ko/03_)](ko/03_전문가용_학술및수리물리보고서.md) | 3,386 + 9개 파일 층서학(2,835,031줄 대 576줄 파이썬 = 4,921.9배 팽창, Main.lean 15/16 미사용 임포트, 62,767개 공허 `_h*` 바인더, 고아 Attainable 3 342줄), 69/69 oai_ref/ 전수 #L 인용, 반사 정규화(>201만줄 절감) 및 바이너 차원 강성($36-5k=6 \iff k=6$), binary64 하드웨어 계약 및 .bib 인용 감사 |
| Tier 4 | [Tier 4 Automated Verification Spec (en/04_)](en/04_Automated_Verification_and_Parser_Spec.md) | [Tier 4 자동검증·파서용 명세서 (ko/04_)](ko/04_자동검증및파서용_명세서.md) | 암호학적 SHA-256 체크섬 대조표 및 원클릭 재현 명령 |
| Tier 5 (상세 심사) | [Tier 5 Detailed Forensic Referee Report (en/05_)](en/05_Detailed_Forensic_Referee_Report_MUB266.md) | [Tier 5 상세형 포렌식 심사보고서 (ko/05_)](ko/05_상세형_포렌식심사보고서_MUB266.md) | 7부 구성 상세 포렌식 심사 보고서(8대 지표 스코어카드, 3층위 기여 주체 분석, 6문 6답 FAQ 및 TIER C 심사 판정문) |
| Tier 6 (핵심 요약) | [Tier 6 Basic Audit Report (en/06_)](en/06_Basic_Audit_Report_MUB266.md) | [Tier 6 기본형 감사 리포트 (ko/06_)](ko/06_기본형_감사리포트_MUB266.md) | 요약형 기본 감사 리포트(TL;DR 8대 지표 스코어카드, 실측 물증 요약, 6문 6답 FAQ 및 10초 재현 명령어) |

## 2. 검증 산출물 (proofs/)

- [proofs/mub6_hadamard_fourier_and_cubic_fibers.lean](proofs/mub6_hadamard_fourier_and_cubic_fibers.lean#L1-L429) (Theorems 1-25, 429줄, 103/103 변이 포착, nonlin: 7)
- [proofs/mub6_weiner_completion_and_gram_sos.lean](proofs/mub6_weiner_completion_and_gram_sos.lean#L1-L416) (Theorems 26-50, 416줄, 113/113 변이 포착, nonlin: 4)
- [proofs/mub6_stratigraphy_and_binary64_audit.lean](proofs/mub6_stratigraphy_and_binary64_audit.lean#L1-L404) (Theorems 51-75, 404줄, 142/142 변이 포착, nonlin: 3)
- [proofs/verify_symbolic_mub266.py](proofs/verify_symbolic_mub266.py#L1-L439) $\to$ [proofs/symbolic_verification_result.json](proofs/symbolic_verification_result.json#L1-L180)
- [proofs/problem_spec.md](proofs/problem_spec.md#L1-L24) & [manifest.json](manifest.json#L1-L574)

## 3. 1줄 검증 명령어

이 사례 폴더에서 아래 명령어를 실행하면 SHA-256 해시, Lean 4 커널, SymPy 재현, `#L` 링크 및 전칭 가설 돌연변이 시험을 일괄 검증합니다.

```bash
python3 ../../tools/verify_all.py --root .
```
