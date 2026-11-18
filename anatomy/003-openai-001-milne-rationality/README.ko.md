# OpenAI #001 밀른의 유리성 추측 포렌식 감사 및 5대 수리

- 언어 선택: [English (README.md)](./README.md) | 한국어 | 상위 목차: [ultari-proof-anatomy](../../README.ko.md)

이 포렌식 감사는 OpenAI #001(아벨 다양체의 밀른 유리성 추측)의 LaTeX 6개 절 원고 및 부속 파일(`main.tex`, `references.tex`, `figures/two-transports.tex`)을 감사하고, 5건의 국소화·정규화·정밀도 보완을 36개 독립 Lean 4 정리(v4.29.0-rc8, 0 sorry, 가설 변이 232/232건 포착)로 검증합니다. `proofs/oai_ref/repaired_build/`는 10월 7일 미패치 원본이 아니라, 원저장소 `openai/math` 커밋 `4eaee87` 원고에 [proofs/oai_001_milne_repair.patch](./proofs/oai_001_milne_repair.patch)를 적용한 **패치 적용 후 원고 스냅샷**입니다.

## 핵심 해부 결과

1. `[OAI26]` 의존 경계 규명: `Theorem 1.1`과 `Corollary 6.3`은 `[OAI26]`에 전혀 의존하지 않으며, 6절의 `Corollary 6.4` (`05_reduction.tex:370, 412`)만 철회되지 않은 CM 아벨 다양체 동반 논문 `[OAI26, Theorem 1.1]` (*The rational Hodge conjecture for CM abelian varieties*, 2026년 10월 6일; `#032`에서는 K3 원고만 철회됨)을 호출함을 확인합니다.
2. 점별 `[KZ25b]` 적분 리프트 국소화 (`[Medium-1]`): `Proposition 3.1`·`Lemma 3.3` (`02_transport.tex:474-487, 520-540`)에서 전역 형식 스킴 표현 가능성 가설 `(U_x)`를 제공하는 2026년 정식 출판 논문 `[GLX26, Corollary 6.3]`(Gleason–Lim–Xu, *Inventiones Mathematicae* 243 (2026), 805–861, `doi:10.1007/s00222-025-01386-1`) 의존성을 제거하고, 점별 브뢰유-키신(`[PR24]`) 및 키신-저우(`[KZ25b]`, `arXiv:2505.02165v1`, 2025년 프리프린트) 적분 리프트로 단순화·국소화합니다.
3. 정규 보빌 사영자 도입 (`[Medium-2]`) 및 정밀도·명세 경계 보완 3건 (`[Low-1]`~`[Low-3]`): `05_reduction.tex:469-470`은 유리 동치 법에서의 사이클 유일성을 명시적으로 주장하지 않았으나, 가중치-0 보빌 사영자 $P_{r,0}$로 모든 $N \ge 1$에서 불변인 표준 사이클을 정의하며, 분기 DVR(둘째 문장에 이미 `[Tat67]` 일반 올 경로가 기재된 `Lemma 2.4`의 서술 명확화)·크로네커·로사티 정밀도 보완 3건을 검증합니다.

## 4단계 독자 맞춤형 가이드

| 단계 | 대상 독자 | 문서 파일 | 핵심 내용 |
| :---: | :--- | :--- | :--- |
| 1단계 | 초보자 (일반 독자) | [01_초보자용_쉬운해설.md](./ko/01_초보자용_쉬운해설.md) | 밀른의 유리성 추측 개념, 4단계 증명 다리, 5건의 수리 내역 쉬운 해설. |
| 2단계 | 중급자 (이공계·개발자) | [02_중급자용_구조및수식가이드.md](./ko/02_중급자용_구조및수식가이드.md) | 6개 절 수식 매핑과 36개 Lean 4 정리 1대1 줄 번호 색인표. |
| 3단계 | 전문가 (산술기하·형식증명 연구자) | [03_전문가용_산술기하및형식증명보고서.md](./ko/03_전문가용_산술기하및형식증명보고서.md) | `[OAI26]` 경계, 키신-저우 점별 리프트, 보빌 사영자 및 5대 수리 기술 보고서. |
| 4단계 | 자동 검증기 및 파서 | [04_자동검증및파서용_명세서.md](./ko/04_자동검증및파서용_명세서.md)<br>[manifest.json](./manifest.json) | 1줄 재현 명령어, SHA-256 해시 원장 및 36개 정리 매니페스트. |

## 형식증명 코드 및 1줄 검증 명령어

- [proofs/milne_transport_and_filtration.lean](./proofs/milne_transport_and_filtration.lean): 정리 1~16 (101/101 변이 포착).
- [proofs/milne_weil_reduction_and_repairs.lean](./proofs/milne_weil_reduction_and_repairs.lean): 정리 17~36 (131/131 변이 포착).
- [proofs/verify_symbolic_milne.py](./proofs/verify_symbolic_milne.py) 및 [proofs/oai_001_milne_repair.patch](./proofs/oai_001_milne_repair.patch).

```bash
python3 ../../tools/verify_all.py --root .
lean ./proofs/milne_transport_and_filtration.lean && lean ./proofs/milne_weil_reduction_and_repairs.lean && (cd ./proofs && python3 verify_symbolic_milne.py)
```
