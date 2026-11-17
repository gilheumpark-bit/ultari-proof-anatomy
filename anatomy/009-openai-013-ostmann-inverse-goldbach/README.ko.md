# OpenAI #013 오스트만 역 골드바흐 추측 (Erdős #431) 해부 및 형식증명

- 언어 선택: [English (README.md)](./README.md) | 한국어 | 상위 목차: [ultari-proof-anatomy](../../README.ko.md)

이 감사 보고서는 OpenAI #013(The additive indecomposability of the primes, `OAI/NumberTheory/Ostmann/`, 7,716개 `.lean` 파일 609,199줄 및 프리프린트 9개 절 6,072줄 / 전체 빌드 6,624줄)을 해부한 결과물입니다. 모든 결론은 `proofs/oai_ref/` 원본 파일(60개)과의 1대1 대조 및 75개 독립 Lean 4 정리(1,517줄, `v4.29.0-rc8`, `0 sorry`, `0 axiom`, 가설 변이 393/393건 포착)로 검증했습니다.

## 핵심 해부 결과

1. 쌍둥이 엔진(Twin-Engine) 7,716개 파일 중복 및 Erdos970 패치 감사: Ostmann/ 폴더가 동일한 정리를 증명하는 두 개의 독립 증명 트리(Complete.lean: 3,165개, Main.lean: 4,175개, 공유 파일 5개 372줄 = 0.065%)와 381개 화석 파일(39,517줄, All.lean·PaperMain.lean 포함)로 이루어져 있음을 밝히고(3165 + 4175 - 5 + 381 = 7716), +47,394줄 규모 Erdos970 패치 내 SiegelZeros/NOTICE.md 누락 및 2,253줄 주석 0x20 공백 치환을 실측합니다.
2. 5절 푸리에 공급 수축(-11/125), 제곱 커널 기울기 $2t_0$ 및 $+53\%$ 정밀화: 불균형 밀도 벌점 $\frac{(2\sigma_p-1)^2}{\sigma_p(1-\sigma_p)} \ge \frac{1}{2}$, 랭크-2 전달 커널 판별식 $(a-d)^2+4b^2 \ge 0$과 제곱 커널 $K^2$ 대각합을 통한 주 감쇠 기울기 배증($t_0 \mapsto 2t_0$), 국소 수축률 $1 - \frac{8}{5}\cdot\frac{17}{25} = -\frac{11}{125} < 0$, #003(QRH) 임포트 0건의 완전 독립성(대 엔진 B #021·#026 직접 18개·전이 183개 차용), 무손실 $\kappa = \frac{33}{20}, \frac{17}{10}$ 복원에 따른 소수 질량 확장($0.15L \to 0.23L$)을 검증합니다.
3. 전 구간 귀납법 트리 예산, 3·6·8절 핵심 대수 엔진 및 유효 문턱값 도출: $\sum_{j=0}^{k-1} j 2^j = (k-2)2^k+2$를 귀납법으로 증명해 순 모순율 $\frac{2}{5} - \frac{3}{4} = -\frac{7}{20} < 0$을 도출하고, 완전순열 슬롯 쌍($t_1 = 0$)으로 최소 트리 깊이 $k_{\min}$을 7,041에서 1,040으로 단축하며, 3절 공통 중심 합동 소거·보나미 4차 모멘트 모델, 6절 아핀 충돌 다항식 인수분해·반데르몽드 3중 충돌 금지, 8절 선형형식 산술 검증·통분된 $2\times 2$ 소행렬 비퇴화 및 슈바르츠-지펠 틀(독립 대수 $2\times 2$ 소행렬·행렬식 모델 병행), 그리고 타투자와 정리(384,002)를 통한 시겔 비효과성 제거 및 명시적 반례 문턱값 $L_{\mathrm{eff}}$ 단축(4,115,904 -> 640,722 -> 255,983, 16.08배 압축)을 증명합니다.

## 4단계 독자 맞춤형 가이드

| 단계 | 대상 독자 | 문서 파일 | 핵심 내용 |
| :---: | :--- | :--- | :--- |
| 1단계 | 초보자 (일반 독자) | [ko/01_Beginner_Guide.md](ko/01_Beginner_Guide.md) | 오스트만 역 골드바흐 문제, 쌍둥이 엔진 중복 구조, 3단계 증명 원리 쉬운 해설. |
| 2단계 | 중급자 (이공계·개발자) | [ko/02_Intermediate_Guide.md](ko/02_Intermediate_Guide.md) | `proofs/oai_ref/`(60개 파일) 선언별 대조표 및 75개 Lean 4 정리 1대1 줄 번호 색인표. |
| 3단계 | 전문가 (수론·형식증명 연구자) | [ko/03_Advanced_Guide.md](ko/03_Advanced_Guide.md) | 3세대 화석 트리, 3·5·6·8절 4대 대수 엔진 수식 유도, 유효 문턱값 및 9개 절 1:1 대조 보고서. |
| 4단계 | 자동 검증기 및 파서 | [ko/04_Expert_Verification.md](ko/04_Expert_Verification.md)<br>[manifest.json](manifest.json) | SHA-256 해시 원장, 가설 돌연변이 시험 결과(393/393) 및 1줄 재현 명령어. |
| OPFF 심사 (상세형) | 포렌식 심사위원단 및 학계 | [ko/05_OPFF_상세형_포렌식심사보고서_Ostmann013.md](ko/05_OPFF_상세형_포렌식심사보고서_Ostmann013.md)<br>[en/05_OPFF_Detailed_Forensic_Referee_Report_Ostmann013.md](en/05_OPFF_Detailed_Forensic_Referee_Report_Ostmann013.md) | 7부 구성 OPFF 학술 최종 포렌식 심사 보고서(OPFF TIER C: Gate 1·5 PASS / Gate 2·3·4 FAIL, 8대 지표 스코어카드, 3층위 기여 주체 분석, 6문 6답 FAQ 및 공식 판정문). |
| OPFF 심사 (기본형) | 핵심 요약 및 신속 검토 | [ko/06_OPFF_기본형_감사리포트_Ostmann013.md](ko/06_OPFF_기본형_감사리포트_Ostmann013.md)<br>[en/06_OPFF_Basic_Audit_Report_Ostmann013.md](en/06_OPFF_Basic_Audit_Report_Ostmann013.md) | 8대 핵심 지표 요약표, 영역별 실측 물증, 6문 6답 FAQ 및 10초 터미널 재현 명령어(OPFF TIER C). |

## 형식증명 코드 및 1줄 검증 명령어

- [ostmann_twin_engines_and_supply_contraction.lean](proofs/ostmann_twin_engines_and_supply_contraction.lean#L1): 정리 1~20 및 51~55 (188/188 변이 포착).
- [ostmann_tree_transfers_and_permutation_contradiction.lean](proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L1): 정리 21~50 + 재귀 `def` 2개 (181/181 변이 포착).
- [ostmann_algebraic_engines_and_cauchy_determinant.lean](proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L1): 정리 56~75 + 재귀 `def` 1개 + [OstmannContractionSystem](proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean#L28-L34) (24/24 변이 포착).
- [verify_symbolic_ostmann.py](proofs/verify_symbolic_ostmann.py) 및 [symbolic_verification_result.json](proofs/symbolic_verification_result.json).

```bash
python3 ../../tools/verify_all.py --root .
lean proofs/ostmann_twin_engines_and_supply_contraction.lean && lean proofs/ostmann_tree_transfers_and_permutation_contradiction.lean && lean proofs/ostmann_algebraic_engines_and_cauchy_determinant.lean && (cd proofs && python3 -B verify_symbolic_ostmann.py)
```
