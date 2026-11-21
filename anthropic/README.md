# Anthropic 형식증명 해부 및 단행본 아카이브 (`anthropic/`)

> **Language**: **한국어** · [**English Overview (`alpoge-rh-grh-2026/README.en.md`)**](./alpoge-rh-grh-2026/README.en.md)

본 폴더는 Anthropic 연구진이 공개한 대규모 `Lean 4` 형식증명 아카이브의 이종 커널 전수 검증 영수증, 역설계 수식 복원서, 선행 문헌 전수 사전 및 출판 조판 단행본을 수록합니다.

## 수록 목록

| 폴더 | 분석 대상 및 원본 규모 | 핵심 검증 및 복원 산출물 | 바로가기 |
| :--- | :--- | :--- | :--- |
| **[`alpoge-rh-grh-2026`](./alpoge-rh-grh-2026/README.md)** | **Levent Alpöge + Claude: 리만 가설(RH) 및 디리클레 GRH 형식증명**<br>`175,187`개 `.lean` 파일, `17,374,215`줄 (`leanprover/lean4:v4.33.1`, 주석 `0`줄 · `.bib` `0`건) | • **이중 CPU · 외부 독립 커널 기계 인증 (`PASS`, 동료심사 `ONGOING`)**: `x86_64` · `aarch64` 컴파일 및 `nanoda` · `con-leche` · `lean4lean` 교차 검증 에러 `0`건, 표준 3공리만 의존 ([`FINAL_FEDERATED_VERDICT.txt`](./alpoge-rh-grh-2026/data/FINAL_FEDERATED_VERDICT.txt))<br>• **한·영(`ko`/`en`) 전 6권 해설 및 출판 단행본(53쪽 · 55쪽)**: 무수식 손계산 비유(`01`), 단방향 란다우·장난감 모형(`02`), 바르그만-포크·`MasterIdentity`·양기안 RTT 행렬식, 지겔-베유 $-Cm^2L/k$ 약분식, 투영 푸앵카레·코시-슈바르츠 감쇠 $q^{-(k-2r-5)}$, `VWin`(`1,609만 줄`: 기출 `1,506만 줄` + 신작 패칭 `103만 줄`) 7분할 $\mathrm{GSp}_4 \cdot U(3)$ 패칭, 전역 아라켈로프 곱공식(`ProductFormula` · `DivIneqObj`) 폐루프 및 OpenAI `#003` 교차 심사(`05`) 완비<br>• **기출 `195 / 195`선(`100.0%`) 한·영 사전 + 독립 Lean 정리 `17`개**: `UnusedSlot` 9종(`True` 비활성 슬롯 2종 + 활성 네임스페이스 7종, `375`쌍) 포렌식 및 [`alpoge_spine_arithmetic_audit.lean`](./alpoge-rh-grh-2026/proofs/alpoge_spine_arithmetic_audit.lean) (`0 sorry`) | [**한국어 개요 (`README.md`)**](./alpoge-rh-grh-2026/README.md)<br>[**English (`README.en.md`)**](./alpoge-rh-grh-2026/README.en.md)<br>[**한국어 PDF (53쪽)**](./alpoge-rh-grh-2026/book/리만가설_1737만줄_완전풀이집.pdf)<br>[**English PDF (55p)**](./alpoge-rh-grh-2026/book/Alpoge_RH_17M_Complete_Decompilation_EN.pdf) |
