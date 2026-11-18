# 감사 요약 리포트: OpenAI 공개 추론 로그 10편 전편 (reasoning_traces/*.pdf · #007~#362)

- 감사 대상: OpenAI openai/math 저장소 내 공개 추론 로그 PDF 10편 전편 (reasoning_traces/*.pdf, 202쪽 · 9,308추출줄, 전체 373개 문제 패밀리 중 10개 = 2.68%: #007, #017, #087, #102, #159, #197, #221, #271, #287, #362) + 패밀리 소속 프리프린트 22편 (추론 로그 대응 주원고 11편 · .bib 315개 키 + 추론 로그 미제공 자매 원고 11편) + 범위 문서 lean/docs/{007..362}.md 10종 (211줄) + 비교 챌린지 21종 (1,949줄) + OAI/ .lean 파일 9,929개 + 미삭제 LuaLaTeX 조판 소스 [mezard-parisi-formula.tex](../proofs/oai_ref/preprints_tex/mezard-parisi-formula.tex#L1-L211) (211줄)
- 검증 환경: Lean 4 v4.29.0-rc8 (감사 대상 v4.34.1 대조) / Python 3.14 (SymPy 기호 연산기 및 양방향 서지 파서)
- 산출물 해시 (SHA-256): [traces10_compiler_and_citation_drop.lean](../proofs/traces10_compiler_and_citation_drop.lean) (b5dfc6a6656a...) | [traces10_algebraic_combinatorial_engines.lean](../proofs/traces10_algebraic_combinatorial_engines.lean) (8375e84057d5...) | [traces10_analytic_operator_and_scope_audit.lean](../proofs/traces10_analytic_operator_and_scope_audit.lean) (d0e7dbd98a32...) | [verify_symbolic_traces10.py](../proofs/verify_symbolic_traces10.py) (d62cd7c19b3d...)
- 검증 방식: 독립 Lean 4 정리 75개 (1,337줄, 0 sorry, 0 axiom, 346 / 346 전칭 가설 변이 사살 = 100%) 및 보존 원문 51종(핵심 선언 29종) 실시간 파서 검증
- 5대 관문 판정: Gate 1: PASS · Gate 2: FAIL · Gate 3: FAIL · Gate 4: FAIL · Gate 5: PASS ⇒ TIER C (10대 수리 엔진 코어 유효 및 서지·생성 이력 규격 미충족)

## 0. 8대 핵심 지표 요약표

| 감사 축 | 원고(preprints/) 표방 내용 | 실제 저장소(reasoning_traces/ · Lean 4) 실측치 | 괴리율 / 상태 |
| :--- | :--- | :--- | :---: |
| 1. 추론-원고 인용 보존율 | 원고(.bib 315개 키)가 추론 로그(332회 인용) 반영 | 102건 보존(30.72%) 대 230 / 332건 탈락(69.28% = 115/166) + 213건 사후 신규 삽입(67.62%); 양방향 자카드 유사도 102 / 545 = 18.72% < 1/5 | 69.28% 탈락 / 자카드 18.72% (CP-08 · CP-09 FAIL) |
| 2. 자사 동반 원고 인용 | 완전한 서지 출처 보존 | 추론 로그에서 인용된 OpenAI 2026 동반 원고 3 / 3종(100%, #017에서 20회 이상 호출된 #005 Catalan 포함) 최종 .bib 전량 누락; #287은 49 / 54건(90.7%) 탈락 | 자사 인용 100% 삭제 (CP-08 · CP-10 FAIL) |
| 3. 사후 LuaLaTeX 일괄 조판 | 날것의 자율 추론 기록 (reasoning_traces/*.pdf) | 미삭제 [mezard-parisi-formula.tex](../proofs/oai_ref/preprints_tex/mezard-parisi-formula.tex#L47-L79) (211줄) 내 #102 복잡도 매크로 5종, 미사용 한자 "自由" 폴백(U+81EA, U+7531) 및 [Administrative details redacted.] 존재 | 사후 일괄 재조판 (CP-11 FAIL) |
| 4. 프롬프트 누락 및 다중 봉합 | 단일 실행 자율 추론 트랜스크립트 | 2 / 10편(#017, #287)에 프롬프트 블록 0개; 5 / 10편(#007, #017, #087, #159, #197)이 16개 하위 실행을 봉합; #087 Part 2는 Part 1 결과를 외부 전제로 주입받음 | 무프롬프트 2편 / 16개 봉합 (CP-11 FAIL) |
| 5. 바이트 보존 스페이스 마스킹 | 깨끗한 비교 챌린지 및 OAI/ 진입점 | [MinUncut.lean:5-13, 63-101](../proofs/oai_ref/challenges/MinUncut.lean#L5-L13)이 `L5-L7, L9-L13` 8줄과 `L63-L101` 6개 주석 블록 14줄(합계 22줄)을 순수 `0x20` ASCII 스페이스 1,401바이트로 치환; [BinaryCorrectedElliott.lean:6-32](../proofs/oai_ref/oai_modules/BinaryCorrectedElliott.lean#L6-L32)은 중복 `open` 27줄 포함 | 1,401바이트 공백 마스킹 (CP-03 · CP-12 FAIL) |
| 6. 22 -> 11 -> 10 -> 7 범위 깔때기 | 패밀리 전체 해결 및 Lean 4 형식화 | 자매 원고 11 / 22편(50%) 추론 로그 0편, #197·#271 표제 원고 4 / 8편 Lean 0줄, #017·#102·#159 챌린지 정량/표제 파트 제외 (결합 충실도 = 714/3320 = 21.51% < 1/4) | 결합 충실도 21.51% (CP-04 · CP-05 FAIL) |
| 7. 스텁 오탐(5/5) 대 미사용 바인더 | 챌린지 스텁 및 OAI/ 전제 위생 | 의심 챌린지 스텁 가설 5종(hNP, hK $\times 3$, hM)은 실제 증명에서 100% 소비 확인, 반면 OAI/ 9,929개 파일 내부 보조정리에 미사용 가설 2,170건 (#159에 1,537건 = 70.83%) 잔존 | 미사용 바인더 2,170건 (CP-01 · CP-06 WARN) |
| 8. 10대 분야 수리 엔진 코어 | 정수론·기하·대수·물리·PDE 10개 분야 증명 | 10대 핵심 수리 엔진 ($\mu(\pi)=2$ 베타 팩토리얼 상쇄, 하너 극체 쌍대성, 4차 공동 볼록성 SOS, 하이젠베르크 적외선 적분, 블라소프-맥스웰 부트스트랩) 전수 검증 (독립 정리 75개, 346/346 변이 사살) | Gate 1 & Gate 5 PASS |

## 1. 영역별 실측 물증 요약

### 1.1 양방향 추론-원고 서지 교체(자카드 유사도 18.72%) 및 자사 동반 원고 100% 삭제 (CP-08, CP-09, CP-10)
- 양방향 서지 교체 실측 (102 / 545 = 18.72% 자카드 유사도): 10편 추론 로그(202쪽, 9,308줄)가 인용한 332건과 대응 주원고 11편의 참고문헌 315건($102 + 230 = 332$, $102 + 213 = 315$, 합집합 $332 + 213 = 545$)을 전수 대조한 결과, 추론 로그 인용의 69.28%(230 / 332 = 115/166)가 탈락하고 원고 참고문헌의 67.62%(213 / 315)가 사후 신규 삽입되었습니다([thm_65_bidirectional_citation_conservation](../proofs/traces10_analytic_operator_and_scope_audit.lean#L264-L283)). 특히 #287(자유군 인자)은 추론 인용 54건 중 49건(90.7%)이 탈락했습니다.
- OpenAI 2026 자사 동반 원고 3 / 3종(100%) 전량 삭제: 추론 로그 본문에서 방법론적 주형으로 반복 인용된 자사 동반 프리프린트 3종(#017에서 20회 이상 호출된 #005 Catalan, #107 Dickman, #159 [46] (*Monochromatic finite sums and products in the naturals*))이 최종 원고 .bib에서는 3 / 3종(100%) 전량 누락되었습니다.

### 1.2 사후 LuaLaTeX 일괄 컴파일러 물증, 다중 실행 봉합 및 1,401바이트 공백 마스킹 (CP-03, CP-11, CP-12)
- 미삭제 LuaLaTeX 소스 [mezard-parisi-formula.tex](../proofs/oai_ref/preprints_tex/mezard-parisi-formula.tex#L1-L211): reasoning_traces/ 폴더에 유일하게 삭제되지 않고 남은 조판 소스 파일(211줄)에서 #102 전용 복잡도 매크로 5종(\UGC, \CSP, \NP, \OPT, \SDP, L47-56), 본문에 한 번도 쓰이지 않은 중국어 한자 "自由" 활성 문자 폴백(U+81EA, U+7531, FandolFang-Regular.otf, L62-79), 그리고 [Administrative details redacted.] (L154) 문구가 확인되었습니다.
- 프롬프트 누락 및 다중 실행 봉합: 10편 중 2편(#017, #287)은 Original prompt 블록이 0개이며, 5편(#007, #017, #087, #159, #197)은 총 16개의 하위 실행을 이어 붙인 다중 봉합 문서입니다(분량도 #221 5쪽/210줄부터 #087 45쪽/2,191줄까지 10배 이상 편차).
- [MinUncut.lean](../proofs/oai_ref/challenges/MinUncut.lean#L5-L101)의 1,401바이트 공백 마스킹: `L5-L7, L9-L13` 8줄과 `L63-L101` 6개 주석 블록 14줄(합계 22줄)이 바이트 길이를 유지한 채 순수 `0x20` ASCII 스페이스 1,401바이트로 치환되었으며, [BinaryCorrectedElliott.lean:6-32](../proofs/oai_ref/oai_modules/BinaryCorrectedElliott.lean#L6-L32)에는 중복 `open` 문 27줄이 연속 출력되어 있습니다.

### 1.3 범위 축소 깔때기(22 -> 18 -> 11 -> 10 -> 7) 및 표제 원고 미형식화·비교 챌린지 축소 (CP-04, CP-05, CP-07)
- 자매 원고 11 / 22편(50.0%) 추론 로그 미공개 및 #197·#271 표제 주원고 4편(11,895줄) Lean 4 형식화 0% (CP-04, CP-07):
  1. #197 (lean/docs/197.md:1-8) 표제-내용 역전: 문서 제목을 "A torsion-free group algebra that is not directly finite"로 내걸었으나 정작 October-4-2026 무비틀림 대표 원고(2,346줄)는 Lean 4 형식화 0줄 · 추론 로그 0편으로 제외하고 비틀림(torsion) 군 원고 3편만 형식화했습니다(제외된 무비틀림 원고는 Gardam 2021, Annals of Math. 인용이 0건으로 누락되어 있고 .bib 내 DykemaJuschenko2015 1건이 본문 미인용 0건임).
  2. #271 (lean/docs/271.md:1-6) 표제 3대 원고(9,549줄) 형식화 0%: 문서 제목을 "Bloch's law, its lattice correction, and the spherical magnetization law"로 내걸었으나 September-24 최근접 이웃 원고 1편(128개 파일)만 형식화하고, 정작 표제에 적힌 October-5-2026 3대 주원고(Bloch's Law 3,023줄, First lattice correction 2,976줄, Spherical magnetization law 3,550줄; 합계 9,549줄)는 Lean 4 형식화 0줄 · 추론 로그 0편입니다(또한 spherical-magnetization-law는 짝수 격자 변 길이 L even으로 제한되며 DiaconisSaloffCoste1993, DoyleSnell1984, Nash1958, SuzukiFisher1971, Timar2013 등 .bib 5건이 본문 미인용 0건으로 남아 4순위 코퍼스 전체 미인용 .bib의 12 / 13 = 92.3%가 #271에 집중됨).
- 비교 챌린지 표제·정량 파트 제외(3편) 및 암묵적 가설의 명시적 추가 (CP-04):
  1. #017 · #102 · #159 정량 파트 제외: [PiExponent.lean](../proofs/oai_ref/challenges/PiExponent.lean#L7-L18)은 Corollary 1.2(Flint-Hills 급수)를, [UniqueGamesTheorem.lean](../proofs/oai_ref/challenges/UniqueGamesTheorem.lean#L231-L238)은 추론 로그 표제인 BasicSDP 최적성(Corollary 7.1)을, [ErdosReciprocal.lean](../proofs/oai_ref/challenges/ErdosReciprocal.lean#L31-L35)은 2부 준다항식 상한을 비교 챌린지에서 제외했습니다.
  2. 비교 챌린지 명시적 정칙성 가설 추가: [GeneralMahler.lean:24-27](../proofs/oai_ref/challenges/GeneralMahler.lean#L24-L27)은 IsCompact K, Convex ℝ K, (interior K).Nonempty 3종을, [VlasovMaxwell.lean:47-53](../proofs/oai_ref/challenges/VlasovMaxwell.lean#L47-L53)은 BoundedSmooth, MemLp 2 및 가우스 발산 구속조건 2종을 명시적 가설로 추가했습니다.

### 1.4 10개 분야 수리 코어 유효성 확인 및 인간 · 고전 · AI 3층 기여도 분리
- 10개 분야 수리·해석 코어 유효성 확인 (Gate 1 & Gate 5: PASS): #007(3척도 엔트로피 망원 합), #017(투도세 3중 베타 적분 $m=2n$ 단체 팩토리얼 상쇄 및 $\mu(\pi)=2$), #087(하너 극체 쌍대성 및 리카티 여유분 $194 - 180 = 14$), #102(희소 튜플 사영 $\beta = k^{-2/3}$), #159(이진 조화 블록 비둘기집), #197(모서리 결손 멱등원 $e = 1 - ba$ 및 반 캄펜 오일러 결손 $1/2 > 0$), #221(4차 공동 볼록성 SOS 항등식 $(A-B)^2((A+B)^2+2B^2)$), #271(3D 스핀파 적외선 적분 $4s < 5s$), #287(호게루프 방사 감쇠 및 디케마-러둘레스쿠 압축), #362(글래시-스트라우스 상대론적 부트스트랩 여유분 $43/500 > 0$)의 핵심 수리 메커니즘은 모두 유효함을 독립 Lean 4 정리 75개(1,337줄, 346/346 변이 사살)로 검증했습니다.
- 3층 기여도 분리: (1) 선행 인간 분야별 고전 이론 및 자사 선행 파이프라인 뼈대 65%, (2) AI 시행착오 탐색(실패 경로 기각) 및 10대 분야 대수·해석 결합 코어 35% (Gate 1 & Gate 5 PASS), (3) 추론-원고 서지 탈락(69.28%, 자카드 18.72%), 자사 인용 100% 삭제, 사후 LuaLaTeX 일괄 조판 및 1,401바이트 공백 마스킹은 시정 대상입니다.

## 2. 예상 반론에 대한 사전 사실 확인 (FAQ)

- Q1. "추론 로그의 참고문헌과 최종 논문의 참고문헌이 다른 것은 초안을 다듬는 정상적인 편집 과정 아닌가?"
  - 사실 확인: 단순 다듬기 수준이 아니라 추론 로그 인용의 69.28%(230 / 332 = 115/166)가 탈락하고 원고 참고문헌의 67.62%(213 / 315)가 사후 신규 삽입되어 양방향 자카드 유사도가 18.72%(102 / 545)에 불과합니다(#287은 49 / 54 = 90.7% 탈락). 또한 추론 중 핵심 기법으로 호출한 OpenAI 2026 동반 원고 3종이 최종 .bib에서 100% 삭제되었습니다(CP-08, CP-09, CP-10).
- Q2. "추론 로그 PDF들이 공유 일괄 템플릿으로 사후 재조판되었다는 물리적 증거는 무엇인가?"
  - 사실 확인: #221에 실수로 삭제되지 않고 남은 211줄짜리 LuaLaTeX 소스 [mezard-parisi-formula.tex](../proofs/oai_ref/preprints_tex/mezard-parisi-formula.tex#L47-L154) 안에 #102(Unique Games) 전용 매크로 5종, 미사용 중국어 한자 "自由" 활성 문자 폴백, 그리고 [Administrative details redacted.] 문구가 그대로 들어 있기 때문입니다(CP-11).
- Q3. "비교 챌린지(ComparatorChallenges/*.lean)에서 지적되었던 5개 가설(hNP, hK, hM)은 공허한 스텁인가?"
  - 사실 확인: 아닙니다. 전수 추적 결과 해당 5개 챌린지 스텁 가설은 OAI/ 증명 본문에서 5 / 5건(100%) 실제로 소비됨을 확인하여 오탐을 바로잡았으며, 대신 9,929개 OAI/ 내부 보조정리에서 실제 미사용 가설 2,170건(#159에 1,537건 = 70.83%)을 새로 적발했습니다.
- Q4. "22 -> 18 -> 11 -> 10 -> 7 범위 깔때기는 무엇을 뜻하는가?"
  - 사실 확인: 10개 패밀리 소속 22편의 원고 중 18편만 Lean 4로 형식화되었고(#197·#271의 표제 주원고 4편 11,895줄은 Lean 0줄), 11편의 주원고만 10편의 추론 로그 PDF와 연결되며(자매 원고 11편은 추론 로그 0편), 최종 비교 챌린지에서 표제·정량 범위를 온전히 유지한 것은 7편(#017, #102, #159 축소, 결합 충실도 $714 / 3,320 = 21.51\%$)이라는 뜻입니다.
- Q5. "공개된 10편의 추론 로그(202쪽, 9,308줄) 자체는 학술적 가치가 있는가?"
  - 사실 확인: 매우 높습니다. #017에서 고정 매개변수 한계($\mu \le 62/25 = 2.48$)를 겪은 뒤 $m \to \infty$ 단체 상쇄로 전환하거나 #197에서 반 캄펜 곡률 장벽으로 선회하는 실제 발견 과정을 보여주므로 Gate 5: PASS로 분류했습니다.
- Q6. "TIER A로 승격되기 위한 수정 요건은 무엇인가?"
  - 사실 확인: (1) 미공개된 자매 원고 11편의 추론 로그를 공개하고 #197·#271의 누락된 표제 주원고 4편(11,895줄)을 형식화하며, (2) 탈락한 추론 로그 참고문헌 230건(자사 동반 원고 3종 포함)을 .bib에 복원하고, (3) MinUncut.lean의 1,401바이트 공백 마스킹을 복구하며 #017·#102·#159 비교 챌린지 범위를 원고 표제와 일치시키면 됩니다.

## 3. 10초 재현 명령어

```bash
# 1) 양방향 서지 자카드 유사도 18.72%(102/545), mezard-parisi-formula.tex 컴파일러 감사 및 22->18->11->10->7 깔때기 실측 확인
python3 -B proofs/verify_symbolic_traces10.py

# 2) 75개 독립 Lean 4 정리 커널 검증 (0 sorry, 0 axiom, 346/346 가설 변이 사살)
lean proofs/traces10_compiler_and_citation_drop.lean
lean proofs/traces10_algebraic_combinatorial_engines.lean
lean proofs/traces10_analytic_operator_and_scope_audit.lean
```
