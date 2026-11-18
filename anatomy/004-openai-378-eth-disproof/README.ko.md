# OpenAI #378 지수 시간 가설(ETH) 반증 감사

- 언어 선택: [English (README.md)](./README.md) | 한국어 | 상위 목차: [ultari-proof-anatomy](../../README.ko.md)

OpenAI #378(OAI.Algorithms.SubexponentialSAT, 상위 `openai/math` 커밋 `4eaee87` 기준 .lean 3,977개 파일 710,320줄 중 핵심 42개 `.lean` 모듈을 `proofs/oai_ref/`에 수록하고 3,935개 `.lean` 파일은 스냅샷 외부에 위치, .tex 4개 파일 포함)을 전수 감사한 결과입니다. 모든 결과는 56개 독립 Lean 4 정리(v4.29.0-rc8, 0 sorry, 가설 변이 454/454건 포착)로 검증했습니다.

## 핵심 해부 결과

1. 4세대 미임포트 이전 세대 모듈 지층 고고학: 최종 정리에 연결된 2,569개 파일과 미임포트 이전 세대 모듈 1,408개(35.4%, 226,053줄)를 분리해 1세대($2^{0.9n}$)부터 4세대까지의 진화 과정을 복원합니다.
2. 5대 형식 명세 경계 설계 감사 (Class A / Gate 5 대 Class B 격차, 비교기 명세 TIER F): 자체 고지된 Class A 설계 선택 및 Mathlib 4 표준 전술(Gate 5)과 실제 Class B 명세 격차를 명확히 분리합니다. (a) Class A 및 Gate 5: [lean/docs/378.md:9-11](proofs/oai_ref/lean/docs/378.md#L9-L11)은 정규 인코딩과 Engine I 범위를 직접 고지하며, [FiniteFallback.lean:276-277](proofs/oai_ref/lean/OAI/Algorithms/SubexponentialSAT/SqrtLogSpace/FiniteFallback.lean#L276-L277)은 고정 유한 전이표 설계를 주석으로 명시합니다(미임포트 1세대 `languageScanner` [FixedParameters.lean:568-808](proofs/oai_ref/lean/OAI/Algorithms/SubexponentialSAT/FixedParameters.lean#L568-L808) 대 활성 4세대 `FiniteFallback.Scanner` [FiniteFallback.lean:258-299](proofs/oai_ref/lean/OAI/Algorithms/SubexponentialSAT/SqrtLogSpace/FiniteFallback.lean#L258-L299)). 또한 `Filter.atTop`([NativeLargeEntry.lean:48-61](proofs/oai_ref/lean/OAI/Algorithms/SubexponentialSAT/SqrtLogSpace/NativeLargeEntry.lean#L48-L61), $n > 2^{65,535}$ 및 $n > 2^{209,951}$)과 `omega` 여유 상수는 Mathlib 4 표준 전술(Gate 5)에 해당합니다. (b) Class B 명세 격차: (i) 내부 [Final.lean:104-148](proofs/oai_ref/lean/OAI/Algorithms/SubexponentialSAT/SqrtLogSpace/Final.lean#L104-L148)(`exact_count_eth`, $n + F.\mathrm{card} + 1$)과 달리 `formulaBitLength F` 단독 상한을 적은 외부 [SubexponentialSAT.lean:216](proofs/oai_ref/lean/ComparatorChallenges/SubexponentialSAT.lean#L216)(단항 `encodeNat` $L \ge n$ 강제), (ii) $n < 2^{33,554,431}$ 구간의 비균일 유한 전이표로 분리됩니다. 점근적 ETH($n \to \infty$)는 보존되나 공개 비교기 명세는 개정이 필요합니다(비교기 명세 적합성 `TIER F`).
3. 부록 D 형식화, 고전 원저 감사 및 이전 세대 모듈 하이브리드 복원: 부록 D.4의 $2$-진 에르미트 감쇠($1/32$)를 형식화하고, 핵심 증명부 1,552줄(3~4절 409+774줄 및 부록 D.1–D.3 [quantitative-reduction.tex](proofs/oai_ref/tex/quantitative-reduction.tex#L1-L369) 369줄)의 고전 원저 귀속을 복원하며, 미임포트 2~3세대 이전 세대 모듈([SubexpParameters.lean](proofs/oai_ref/lean/OAI/Algorithms/SubexponentialSAT/SubexpParameters.lean#L51-L115), [IdempotentTernary.lean](proofs/oai_ref/lean/OAI/Algorithms/SubexponentialSAT/SqrtLog/IdempotentTernary.lean#L15-L67))을 결합해 지수 상수를 12,032,411,847 -> 70,023($171,835$배)으로 압축합니다.

## 4단계 독자 맞춤형 가이드

| 단계 | 대상 독자 | 문서 파일 | 핵심 내용 |
| :---: | :--- | :--- | :--- |
| 1단계 | 초보자 (일반 독자) | [01_초보자용_쉬운해설.md](ko/01_초보자용_쉬운해설.md) | 아지수 시간 SAT 알고리즘의 원리, 4세대 모듈 진화 과정, 6계층 수리 판정 해설. |
| 2단계 | 중급자 (이공계·개발자) | [02_중급자용_구조및수식가이드.md](ko/02_중급자용_구조및수식가이드.md) | 6단계 제1원리 재계산 수식과 56개 Lean 4 정리 1대1 줄 번호 색인표. |
| 3단계 | 전문가 (이론전산학·형식증명 연구자) | [03_전문가용_전산학및형식증명심사보고서.md](ko/03_전문가용_전산학및형식증명심사보고서.md) | 1,408개 미임포트 이전 세대 모듈, 5대 형식 명세 경계 설계, 부록 D 에르미트 보간, 갈루아 링 솔버 심층 보고서. |
| 4단계 | 자동 검증기 및 파서 | [04_자동검증및파서용_명세서.md](ko/04_자동검증및파서용_명세서.md) 및 [manifest.json](manifest.json) | SHA-256 해시 원장, 가설 돌연변이 시험 결과 및 1줄 재현 명령어. |

## 형식증명 코드 및 1줄 검증 명령어

- [eth_subexp_interpolation_and_hashes.lean](proofs/eth_subexp_interpolation_and_hashes.lean): 정리 1~16 (128/128 변이 포착).
- [eth_tensor_contraction_and_circuits.lean](proofs/eth_tensor_contraction_and_circuits.lean): 정리 17~32 (177/177 변이 포착).
- [eth_five_repairs_and_four_layer_verdict.lean](proofs/eth_five_repairs_and_four_layer_verdict.lean): 정리 33~56 (149/149 변이 포착).
- [verify_symbolic_eth.py](proofs/verify_symbolic_eth.py), [symbolic_verification_result.json](proofs/symbolic_verification_result.json), [problem_spec.md](proofs/problem_spec.md).

```bash
python3 ../../tools/verify_all.py --root .
lean proofs/eth_subexp_interpolation_and_hashes.lean && lean proofs/eth_tensor_contraction_and_circuits.lean && lean proofs/eth_five_repairs_and_four_layer_verdict.lean && (cd proofs && python3 verify_symbolic_eth.py)
```
