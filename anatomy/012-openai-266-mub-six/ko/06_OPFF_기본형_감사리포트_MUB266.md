# 감사 요약 리포트: OpenAI #266 (Mutually Unbiased Bases in Dimension Six)

- 감사 대상: OpenAI openai/math Family #266 - 프리프린트 1 ($N(6) = 3$: .tex 12개 파일 · 5,945줄, [references_mub6.bib](../proofs/oai_ref/tex_mub/references_mub6.bib#L1-L363) 27개 키, \cite 호출 33회, .cpp 8개 파일 · 2,316줄, [check_records.py](../proofs/oai_ref/cpp/check_records.py#L1-L373) 373줄) 및 프리프린트 2 ($N(6) \le 5$: .tex 8개 파일 · 1,997줄, [references.bib](../proofs/oai_ref/tex_fourier/references.bib#L1-L326) 26개 키, \cite 명령 38회 / 인용 키 호출 41회, [verify.py](../proofs/oai_ref/tex_fourier/verify.py#L1-L576) 576줄); 3,397개 .lean 파일 · 2,836,463줄 (MutuallyUnbiased/ 3,386개 · 2,835,031줄 + Hadamard/ 9개 · 1,329줄 + 비교 챌린지 [MUBSix.lean](../proofs/oai_ref/challenges/MUBSix.lean#L1-L66) · [HadamardCubeFiber.lean](../proofs/oai_ref/challenges/HadamardCubeFiber.lean#L1-L37))
- 검증 환경: Lean 4 v4.29.0-rc8 (감사 대상 v4.34.1 대조) / Python 3.14 (SymPy 기호 연산기)
- 산출물 해시 (SHA-256): [mub6_hadamard_fourier_and_cubic_fibers.lean](../proofs/mub6_hadamard_fourier_and_cubic_fibers.lean) (d15df51beb42...) | [mub6_weiner_completion_and_gram_sos.lean](../proofs/mub6_weiner_completion_and_gram_sos.lean) (84fa18c465e5...) | [mub6_stratigraphy_and_binary64_audit.lean](../proofs/mub6_stratigraphy_and_binary64_audit.lean) (818cc8871bac...) | [verify_symbolic_mub266.py](../proofs/verify_symbolic_mub266.py) (96ec2c66ba17...)
- 검증 방식: 독립 Lean 4 정리 75개 + def 5개 (1,249줄, 0 sorry, 0 axiom, 358 / 358 전칭 가설 변이 사살 = 100%) 및 oai_ref/ 보존 원문 69개 파일 실시간 파서 검증
- OPFF 공식 판정: Gate 1: PASS · Gate 2: FAIL · Gate 3: FAIL · Gate 4: FAIL · Gate 5: PASS ⇒ OPFF TIER C (조건부 검증 인정 및 아티팩트·재현성 규격 미충족)

## 0. 8대 핵심 지표 요약표

| 감사 축 | 원고(PDF / 공시 문서) 표방 내용 | 실제 저장소(Lean 4 / C++ / Python) 실측치 | 괴리율 / 상태 |
| :--- | :--- | :--- | :---: |
| 1. 형식화 범위 ($N(6)=3$ 대 $N(6)\le 5$) | 6차원 상호 불편 기저 최대 개수 $N(6) = 3$ 해결 (#266) | Lean 4는 $N(6) \le 5$ (프리프린트 2)만 증명; 프리프린트 1의 $N(6) = 3$ ($n = 4, 5$ 배제)은 Lean 형식화 0줄이며 C++ binary64 탐색에 의존 | $N(6)=3$ 미형식화 (CP-04 FAIL) |
| 2. 코드 전개 팽창률 | MutuallyUnbiased/ 3,386개 파일 · 2,835,031줄 | 576줄짜리 [verify.py](../proofs/oai_ref/tex_fourier/verify.py#L1-L576) 대비 4,921.9배 줄 수 팽창; 커널 반사(Reflected Canonicalizer) 적용 시 2,015,523줄(71.1%) 감축 | 4,921.9배 팽창 (CP-05 WARN) |
| 3. 루트 진입점 (Main.lean) | [Main.lean](../proofs/oai_ref/lean/Main.lean#L1-L33) 내 16개 import 선언 (33줄) | 1 / 16개만 활성 (Bounds.lean) vs. 15 / 16개 (93.75%, 29,683줄) 미전파 루트 임포트; 완결된 Attainable 3 증명 (4개 파일, 342줄, 0 sorry) 미연결 방치 | 15/16 미전파 (CP-05 FAIL) |
| 4. check_records.py 검증 범위 | 100회 분할 C++ 탐색 인증서 (196개 파일) 검증 스크립트 | [check_records.py](../proofs/oai_ref/cpp/check_records.py#L2-L7)는 아다마르 잔차·특이값·클리크 배제의 수학적 재계산을 0건 수행하는 단순 포맷·경계 파서 | 수학적 재계산 0건 (CP-04 · CP-07 FAIL) |
| 5. binary64 하드웨어 계약 및 9월 7일 실행 | 엄밀한 IEEE-754 부동소수점 덮개 배제 | MXCSR 0x1f80, -ffp-contract=off 및 covrun 오프셋 6035 수동 역어셈블리에 조건부 의존; [covout.cpp](../proofs/oai_ref/cpp/covout.cpp#L100-L136)에 checkcpu() 누락; 9월 7일 미인증 실행본을 10월 4일 사후 교체 | 하드웨어·이력 결손 (CP-07 · CP-11 FAIL) |
| 6. 전제 위생 (_h* 미사용 바인더) | 629,541개 선언문 (0 sorry, 0 axiom) | 자동 생성된 푸비니 합 교환 샤드 전반에 미사용 _h* 가설 바인더 62,767건 잔존 (MixedSemantics 54,676건, PairSemantics 7,685건, [SmallPartitions.lean](../proofs/oai_ref/lean/SmallPartitions.lean#L77-L307) 40건) | 미사용 바인더 62,767건 (CP-01 · CP-06 WARN) |
| 7. 서지 편중 및 원저 누락 | 프리프린트 1: 33회; 프리프린트 2: \cite 명령 38회 (키 호출 41회) | 첫 파일에 각각 20/33회 (60.6%) 및 23/38개 명령 (24/41회 키 호출 = 58.5%) 집중 (refinement.tex 656줄 · execution.tex 400줄은 인용 0회); 본문 거명 5대 원저 .bib 누락 | 서두 편중 / 5종 누락 (CP-09 · CP-10 FAIL) |
| 8. 정밀 푸리에·그람 SOS 코어 | MRW 비-타오 소멸, $(3,3)$ 3차 섬유 5-순환, $N(6) \le 5$ | 6개 슈어 블록 (98개 피벗 $> 40,000$), 분모 가교 5,806,080, 바이너 차원 잠금 $d^2-k(d-1)=d \iff k=d$ 검증; OPFF 정리 75개(358/358 변이 사살)로 공인 | Gate 1 & Gate 5 PASS |

## 1. 영역별 실측 물증 요약

### 1.1 프리프린트 1($N(6)=3$, Lean 0줄)과 프리프린트 2($N(6)\le 5$, Lean 284만 줄)의 범위 괴리 (CP-04, CP-07)
- 프리프린트 1($N(6) = 3$)의 Lean 미형식화 및 포맷 전용 파서: 프리프린트 2의 대수적 상한 $N(6) \le 5$는 Lean 4에서 0 sorry로 증명되었으나([MUBSix.lean](../proofs/oai_ref/challenges/MUBSix.lean#L1-L66)), 프리프린트 1의 표제 결과인 $n \in \{4, 5\}$ 배제($N(6) = 3$)는 Lean 형식화가 0줄이며([266.md](../proofs/oai_ref/docs/266.md#L1-L23)) C++ binary64 부동소수점 탐색에 의존합니다. 동반 검증 스크립트 [check_records.py](../proofs/oai_ref/cpp/check_records.py#L2-L7)는 아다마르 잔차·특이값·클리크 배제의 수학적 재계산을 0건 수행하는 로그 포맷 파서이며, [introduction.tex:155-159](../proofs/oai_ref/tex_mub/introduction.tex#L155-L159)와 [execution.tex:4, 395-400](../proofs/oai_ref/tex_mub/execution.tex#L395-L400)([execution.tex:4](../proofs/oai_ref/tex_mub/execution.tex#L4))은 최초 2026년 9월 7일 실행본의 완전한 증거 패킷이 복구되지 않아 인증되지 않았으며("was not authenticated because its complete evidence packet was not recovered") 10월 4일 사후 재실행본으로 교체되었음을 스스로 인정하고 있습니다.
- 고립 방치된 Attainable 3 증명 및 15 / 16 미전파 루트 임포트 (CP-05): [Main.lean](../proofs/oai_ref/lean/Main.lean#L1-L33)의 16개 루트 import 중 1개(Bounds.lean)만 챌린지 정리로 연결되고 15 / 16개(93.75%, 29,683줄)는 전파되지 않으며, 0 sorry로 완성된 하한 증명 Attainable 3(4개 파일, 342줄)은 임포트조차 되지 않은 채 고립되어 있습니다.

### 1.2 4,921.9배 코드 전개 팽창(2,835,031줄) 및 미사용 _h* 바인더 62,767건 (CP-05, CP-06)
- 푸비니 합 교환 샤드의 기계적 전개: 단일 다형성 커널 반사 정규화기(Reflected Canonicalizer)를 쓰는 대신 56,427개 키에 대해 푸비니 합 교환 보조정리를 개별 파일로 찍어내어 576줄짜리 [verify.py](../proofs/oai_ref/tex_fourier/verify.py#L1-L576)를 3,386개 파일 · 2,835,031줄(4,921.9배)로 팽창시켰습니다(커널 반사 적용 시 2,015,523줄 = 71.1% 즉시 감축).
- 미사용 _h* 가설 바인더 62,767건: 전체 629,541개 선언문 전수 스캔 결과, MixedSemantics(54,676건), PairSemantics(7,685건), [SmallPartitions.lean](../proofs/oai_ref/lean/SmallPartitions.lean#L77-L307)(40건) 등에 걸쳐 증명 항에서 쓰이지 않는 _h* 바인더 62,767건이 확인되었습니다.

### 1.3 서두 인용 편중(60.6% · 58.5%) 및 5대 고전 원저 누락 (CP-09, CP-10)
- 서두 인용 편중 및 핵심 증명부 무인용: 프리프린트 1(33회 인용)은 20회(60.6%)가 서론에 몰려 있고 refinement.tex(656줄)와 execution.tex(400줄)는 인용이 0회입니다. 프리프린트 2(\cite 명령 38회 / 인용 키 호출 41회) 역시 23개 명령(24회 키 호출 = 58.5%)이 첫 파일 paper.tex에 집중되어 있으며 본문에서 이름을 거명한 5대 핵심 문헌이 참고문헌에서 누락되었습니다.

### 1.4 정밀 푸리에·그람 SOS 수리 코어 유효성 공인 ($3 \le N(6) \le 5$, Gate 1 & Gate 5: PASS)
- 유효 유리수·대수 인증서 코어: 본 감사단의 독립 Lean 4 정리 75개(1,249줄, 358/358 변이 사살)는 (i) $8,871 \times 909$ 쌍-모멘트 행렬($\operatorname{rank} = 897$)과 26항 증인 $L_H$를 통한 MRW 비-타오 푸리에 소멸 $3\langle|L_H|^2\rangle + \langle|g_H(\alpha)g_H(q)|^2\rangle = 0$, (ii) 뉴턴 거듭제곱합 상쇄 $z^6 - e_3 z^3 + e_6$ 아래 $(3,3)$ 3차 섬유의 연결 5-순환($C_5$) 유일성, (iii) 바이너의 $6 \to 7$ 크라우스 초연산자 완비화($d^2 - k(d-1) = d \iff k = d$) 및 6개 $S_5$ 영-슈어 블록(98개 피벗 $> 40,000$, 순 정수 여유분 $-2,517,408,343,748,053,647,360 < 0$)이 $N(6) \le 5$를 엄밀히 증명함을 공인합니다.
- 3층 기여도 분리: (1) 선행 인간 MUB·아다마르 분류·표현론 뼈대 65%, (2) AI 정밀 푸리에/슈어 SOS 인증서 합성 및 $N(6) \le 5$ Lean 4 형식화 코어 35% (Gate 1 & Gate 5 PASS), (3) 미형식화 $N(6)=3$ C++ 탐색, 재계산 없는 check_records.py, 9월 7일 미인증 실행 교체, 202만 줄 보일러플레이트 전개는 시정 대상입니다.

## 2. 예상 반론에 대한 사전 사실 확인 (FAQ)

- Q1. "284만 줄의 Lean 4 저장소가 6차원 MUB 최대 개수 $N(6) = 3$을 증명한 것 아닌가?"
  - 사실 확인: 아닙니다. 범위 문서 [266.md](../proofs/oai_ref/docs/266.md#L1-L23)가 명시하듯, Lean 4 코드베이스가 증명한 것은 프리프린트 2의 대수적 상한 $N(6) \le 5$([MUBSix.lean](../proofs/oai_ref/challenges/MUBSix.lean#L1-L66))와 $(3,3)$ 3차 섬유 정리([HadamardCubeFiber.lean](../proofs/oai_ref/challenges/HadamardCubeFiber.lean#L1-L37))뿐이며, 프리프린트 1의 $N(6) = 3$은 Lean 형식화가 0줄입니다.
- Q2. "check_records.py가 프리프린트 1의 C++ 컴퓨터 보조 증명을 독립 검증하지 않는가?"
  - 사실 확인: 검증하지 않습니다. [check_records.py](../proofs/oai_ref/cpp/check_records.py#L2-L7)를 줄 단위로 분석한 결과, 행렬 성분·특이값·구간 덮개 배제를 단 한 건도 다시 계산하지 않고 로그 파일에 적힌 사전 계산 수치가 임계값 이함과 포맷만 확인하는 파서임이 확인되었습니다(CP-04, CP-07).
- Q3. "프리프린트 2의 $N(6) \le 5$ 정밀 푸리에 및 그람 SOS 증명은 수학적으로 무결한가?"
  - 사실 확인: 예. 프리프린트 2의 두 비교 챌린지는 0 sorry, 0 커스텀 공리로 컴파일되며, 고립된 342줄짜리 Attainable 3 증명을 재연결하면 양방향 정리 $3 \le N(6) \le 5$가 완결됩니다(Gate 1 & Gate 5: PASS).
- Q4. "왜 MutuallyUnbiased/ 폴더가 3,386개 파일, 2,835,031줄로 폭증했는가?"
  - 사실 확인: 커널 반사 정규화기를 쓰지 않고 56,427개 키마다 푸비니 합 교환 보조정리를 개별 코드로 전개했기 때문이며, 이 과정에서 576줄짜리 파이썬 검증기 대비 4,921.9배 팽창과 62,767개의 미사용 _h* 바인더가 발생했습니다.
- Q5. "2026년 9월 7일 C++ 실행본이 Gate 4(생성 이력)에서 지적된 이유는 무엇인가?"
  - 사실 확인: [introduction.tex:155-159](../proofs/oai_ref/tex_mub/introduction.tex#L155-L159) 및 [execution.tex:4, 395-400](../proofs/oai_ref/tex_mub/execution.tex#L395-L400)([execution.tex:4](../proofs/oai_ref/tex_mub/execution.tex#L4)) 자체가 최초 9월 7일 실행본은 완전한 증거 패킷이 복구되지 않아 인증되지 않았으며("was not authenticated because its complete evidence packet was not recovered") 10월 4일 재실행본으로 사후 교체했음을 시인하고 있고, [covout.cpp](../proofs/oai_ref/cpp/covout.cpp#L100-L136)에는 CPU 반올림 모드를 검사하는 checkcpu() 호출이 빠져 있기 때문입니다.
- Q6. "#266이 OPFF TIER A로 승격되기 위한 수정 요건은 무엇인가?"
  - 사실 확인: (1) check_records.py를 실제 행렬 증인으로부터 구간 산술 재계산을 수행하는 독립 검증기(또는 Lean 4 형식화)로 교체하고, (2) 고립된 Attainable 3를 Main.lean에 연결하며 미전파 루트 임포트 15개를 정리하고, (3) 202만 줄의 푸비니 전개 샤드를 커널 반사로 압축하며, (4) 누락된 5대 원저 인용을 기술 장절에 복원하면 됩니다.

## 3. 10초 재현 명령어

```bash
# 1) 3,397개 파일(2,836,463줄) 층서학, 62,767개 미사용 _h* 바인더, 슈어 피벗 및 check_records.py 실측 확인
python3 -B proofs/verify_symbolic_mub266.py

# 2) 75개 독립 Lean 4 정리 커널 검증 (0 sorry, 0 axiom, 358/358 가설 변이 사살)
lean proofs/mub6_hadamard_fourier_and_cubic_fibers.lean
lean proofs/mub6_weiner_completion_and_gram_sos.lean
lean proofs/mub6_stratigraphy_and_binary64_audit.lean
```
