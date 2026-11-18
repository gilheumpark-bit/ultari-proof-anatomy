# OpenAI #376 강제 나비에-스토크스 유동의 보편 계산 감사

- 언어 선택: [English (README.md)](./README.md) | 한국어 | 상위 목차: [증명 해부 아카이브](../../README.ko.md)

이 감사는 OpenAI #376(1,010개 `.lean` 파일 142,131줄 및 75개 `.tex` 파일; `openai/math` 커밋 `4eaee87`; 동반 서지 보강 PR: `mathcommunity/oai-math-revised` `PR #76`)을 수리물리학 및 형식증명 관점에서 검증한 결과입니다. 본 패키지의 모든 결론은 **45개 독립 Lean 4 정리**(v4.29.0-rc8, 0 sorry, 가설 변이 184/184건 포착)로 검증했습니다.

## 핵심 해부 결과

1. 선행 유체 계산 문헌 및 공시된 강제 유동 기법 검증: 유체 컴퓨터 선행 문헌(Cardona–Miranda–Peralta-Salas–Presas 2021–2025; Tao 2016)과 나란히, #376은 정지 상태 $u(0)=0$에서 출발하며 영압력 외력·전단 시트 설정을 [docs/376.md:12,14,26](proofs/oai_ref/lean/docs/376.md#L12-L26)과 `analysis.tex:36-41, 263-267`(유클리드 공간 $p=0$과 $\mathbb{T}_L^3$ 사영 압력 $p=-\phi$의 구분)에서 명시적으로 공시합니다. 이 설정 안에서 부피 보존 아핀 컬 퍼텐셜 $U = \nabla\times(\chi\Psi)$([BoxTransport/Flow.lean](proofs/oai_ref/lean/OAI/Analysis/BoxTransport/Flow.lean#L114-L225)), 세린-그뢴발 $L^2$ 에너지 유일성([Comparison.lean](proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/BalancedTransport/Comparison.lean#L85-L132)), 2+1D 가우스 열핵 수동 스칼라 검출기([MildScalar.lean](proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/VelocityDetection/MildScalar.lean#L1-L120))를 확인합니다.
2. 동반 생성된 영압력·영이류 모델 축소 (`Class A` 공시 범위 / `Gate 5: FAIL`, `TIER F` 유지): 5개 상자·시트 챌린지의 영압력($p=0$) 역산 외력 항등식 $f := \partial_t U + (U\cdot\nabla)U - \nu\Delta U$([BoxCoding.lean:53-66](proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/BalancedTransport/BoxCoding.lean#L53-L66)) 및 단방향 전단 시트(`advection = 0`, [SolenoidalSheetPrograms.lean:188](proofs/oai_ref/lean/ComparatorChallenges/SolenoidalSheetPrograms.lean#L188)) 설정은 원고(`analysis.tex:36-41`, [docs/376.md:12,14,26](proofs/oai_ref/lean/docs/376.md#L12-L26))와 챌린지 명세 양쪽에 일치하게 적혀 있으므로 `Class A` 공시 범위로 분리하며 `Gate 1`·원고-코드 불일치로 잡지 않습니다. 다만 원고와 공개 비교 챌린지를 동반 생성하면서 비압축성 유체역학의 핵심인 압력과 비선형 이류항을 0으로 소거해 무제약 잔차 항등식과 선형 전단·열 방정식으로 낮춘 점은 **`Gate 5` 수리 모델링 범위 실격(`FAIL`)**으로 판정합니다(내부 3대 보조 기법의 수학적 유효성은 별도 인정).
3. 챌린지 패키징·도달성 및 보조 `def` `sorry` 스캐너 공백 (`Class B`, `Gate 2: FAIL`): 6개 챌린지가 1,004개 `OAI/` 파일 중 354개만 임포트하고 650개(64.7%, 비영 압력 `Solenoidal.lean` 및 `ForcedComputation/` 576개 포함)를 미연결 상태로 남겼으며, [ForcedNavierStokesComputation.lean](proofs/oai_ref/lean/ComparatorChallenges/ForcedNavierStokesComputation.lean#L1-L232)(232줄)은 [BalancedThreeStack.lean](proofs/oai_ref/lean/ComparatorChallenges/BalancedThreeStack.lean#L1-L239)(239줄)과 51개 선언 중 38개 정의(`def` 37개 + `inductive` 1개) 및 50개 보조 선언·주정리를 공유합니다(래퍼·주석 7줄 차이). 또한 [VelocityDetection/MainResult.lean:51](proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/VelocityDetection/MainResult.lean#L51)은 `_hcomputable`을 미사용 상태로 남겼고, 목표 정리 자리비움(`main_result`, `L1232`/`L1270`)과 별개로 [NavierStokesVelocity.lean:454](proofs/oai_ref/lean/ComparatorChallenges/NavierStokesVelocity.lean#L453-L454)는 48개 내부 네임스페이스 인라인 병합 속 보조 `def half`의 `Prop` 몫 증명 자리에 `by sorry`가 남아 있습니다. [TapeCodes.lean:32-33](proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/VelocityDetection/TapeCodes.lean#L32-L33) 및 [MainResult.lean:11-55](proofs/oai_ref/lean/OAI/MathematicalPhysics/NavierStokes/VelocityDetection/MainResult.lean#L11-L55)가 `0 sorry`여서 Lean 4 `Prop` 증명 무관성상 `isDefEq`가 보존되나, 공식 비교 챌린지 보조 `def` 안에 `by sorry`가 걸러지지 않은 점은 **심판기 `sorry` 스캐너의 보조 `def` 검사 공백(`Gate 2 / CP-04, CP-10`)**을 드러냅니다.
4. 고전 인간 수학자 원저 귀속 및 미인용 참고문헌(`references.bib`) 감사: 주 논문(`Incompressible-Box-Transport-and-Finite-Computation-October-6-2026/build/`, 16개 `.tex` 파일: `main.tex` 56줄 + 15개 `\input` 섹션 5,808줄 = 5,864줄)의 `references.bib` 등록 문헌 22개 중 9개(40.9%, `Moser1965`·`Nash1958`·`Aronson1968`·`Tao2016`·`EtnyreGhrist2000` 등)가 본문 `\cite` 누락으로 PDF 참고문헌에서 빠졌고, 15개 섹션 파일 중 11개(4,630 / 5,808줄, 79.7%)에 인간 문헌 인용이 0건임을 확인하고 누락된 핵심 고전 원저를 대조 복원했습니다([ko/03_전문가용_수리물리및형식증명심사보고서.md](ko/03_전문가용_수리물리및형식증명심사보고서.md) 1.7절).

## 6단계 독자 맞춤형 가이드

| 단계 | 대상 독자 | 문서 파일 | 핵심 내용 |
| :---: | :--- | :--- | :--- |
| 1단계 | 초보자 (일반 독자) | [ko/01_초보자용_쉬운해설.md](ko/01_초보자용_쉬운해설.md) | 자율 유체 동역학 계산과 공시된 역산 외력 상자 수송의 차이 및 핵심 요약. |
| 2단계 | 중급자 (이공계·개발자) | [ko/02_중급자용_구조및수식가이드.md](ko/02_중급자용_구조및수식가이드.md) | 10개 프리프린트 폴더·6대 챌린지 매핑 및 45개 Lean 4 정리 1대1 색인표. |
| 3단계 | 전문가 (수리물리·형식증명 연구자) | [ko/03_전문가용_수리물리및형식증명심사보고서.md](ko/03_전문가용_수리물리및형식증명심사보고서.md) | 4계층 심사 판정, 1,010개 파일 임포트 지층 분석, 르레이 투영 비국소성 및 5대 수리 규격. |
| 4단계 | 자동 검증기 및 파서 | [ko/04_자동검증및파서용_명세서.md](ko/04_자동검증및파서용_명세서.md)<br>[manifest.json](manifest.json) | SHA-256 해시 원장 및 45개 Lean 4 정리 줄 번호 매핑표. |
| 5단계 | 7부작 상세 포렌식 심사보고서 | [상세 심사보고서 05](ko/05_상세형_포렌식심사보고서_NS376.md)<br>[Referee 05 (영문)](en/05_Detailed_Forensic_Referee_Report_NS376.md) | 5대 관문(제0부~제7부) 전수 감사 및 TIER F 심사 판정서 (`proofs/` **45개 정리, 184/184 변이 포착**; 미연결 모듈 재조립 48개 정리·150/150 변이는 별도 동반 재조립 패키지에 수록). |
| 6단계 | 기본형 감사 요약 리포트 | [요약 리포트 06](ko/06_기본형_감사리포트_NS376.md)<br>[Summary 06 (영문)](en/06_Basic_Audit_Report_NS376.md) | 기본형 감사 요약: 8대 핵심 지표 스코어카드(TL;DR), 실측 물증 요약(**45개 정리, 184/184 변이 포착**), 6문 6답 Q&A 및 터미널 재현 명령어. |

## 형식증명 코드 및 1줄 검증 명령어

- [proofs/ns376_kinematic_routing_and_forensics.lean](proofs/ns376_kinematic_routing_and_forensics.lean): 정리 1~20 (106/106 변이 포착).
- [proofs/ns376_gronwall_uniqueness_and_repairs.lean](proofs/ns376_gronwall_uniqueness_and_repairs.lean): 정리 21~45 (78/78 변이 포착).
- [proofs/verify_symbolic_ns376.py](proofs/verify_symbolic_ns376.py), [proofs/symbolic_verification_result.json](proofs/symbolic_verification_result.json), [proofs/problem_spec.md](proofs/problem_spec.md).

```bash
python3 ../../tools/verify_all.py --root .
lean proofs/ns376_kinematic_routing_and_forensics.lean && lean proofs/ns376_gronwall_uniqueness_and_repairs.lean && (cd proofs && python3 verify_symbolic_ns376.py)
```
