# Case 009: OpenAI `#013` 오스트만 역 골드바흐 추측 해부 — `7,716`개 파일 쌍둥이 엔진(`Twin-Engine`) 층위학, `-11/125` 푸리에 공급 수축, `-7/20 log r` 이진 트리 순열 모순

이 디렉터리는 한스-하인리히 오스트만(Hans-Heinrich Ostmann, 1950)의 역 골드바흐 추측(`BloomErdosProblems` Problem 19, [`Erdős Problem #431`](https://www.erdosproblems.com/431))을 해결한 OpenAI `#013` 간판 증명(*The additive indecomposability of the primes*, 2026년 9월 24일)의 수리·형식 해부 패키지입니다. 원소 개수가 2개 이상인 임의의 두 부분집합 $A, B \subseteq \mathbb{N}$에 대하여 합집합 $A + B = \{a + b : a \in A, b \in B\}$는 유한 개의 예외를 제외하고 소수 집합 $\mathcal{P}$와 일치할 수 없습니다($((A + B) \mathbin{\triangle} \mathcal{P}).\text{Infinite}$).

## 4단계 문서 (영어 및 한국어)

- **영어 (`en/`)**:
  - [01_Beginner_Guide.md](en/01_Beginner_Guide.md)
  - [02_Intermediate_Guide.md](en/02_Intermediate_Guide.md)
  - [03_Advanced_Guide.md](en/03_Advanced_Guide.md)
  - [04_Expert_Verification.md](en/04_Expert_Verification.md)
- **한국어 (`ko/`)**:
  - [01_Beginner_Guide.md](ko/01_Beginner_Guide.md)
  - [02_Intermediate_Guide.md](ko/02_Intermediate_Guide.md)
  - [03_Advanced_Guide.md](ko/03_Advanced_Guide.md)
  - [04_Expert_Verification.md](ko/04_Expert_Verification.md)

## 형식 증명 및 검증 스크립트 (`proofs/`)

- [`ostmann_twin_engines_and_supply_contraction.lean`](proofs/ostmann_twin_engines_and_supply_contraction.lean#L1-L404): 정리 20개(`0 sorry`, 가설 변이 100% 격추). 기둥 1(`OAI/NumberTheory/Ostmann/` `7,716`개 파일·`609,199`줄의 쌍둥이 엔진 분할 `3165 + 4175 - 5 + 381 = 7716`, `Complete.lean`과 `Main.lean`의 3줄 논리 동치 다리, 유한 가산항 CRT + 디리클레 합성수 환원)과 기둥 2(이동 체 엘숄츠 창, 충돌 안정성 벌점 $(2\sigma_p - 1)^2/(\sigma_p(1 - \sigma_p)) \ge 1/2$, 5절 국소 푸리에 수축 $1 - \frac{8}{5}\cdot\frac{17}{25} = -\frac{11}{125} = -0.088 < 0$, 몽고메리 영점 밀도 $Q^2 T = Q^7$ / 꼬리 오차 $Q^{-8}$, `#003` QRH로부터의 완전 독립성)를 기계 검증합니다.
- [`ostmann_tree_transfers_and_permutation_contradiction.lean`](proofs/ostmann_tree_transfers_and_permutation_contradiction.lean#L1-L391): 정리 20개 + 재귀 정의 `def` 2개(`0 sorry`, 가설 변이 100% 격추). 모든 자연수 $k$에 대한 구조적 수학적 귀납법(`induction k`)으로 이진 트리 잎 합 $\sum_{j=0}^{k-1} 2^j = 2^k - 1`(`dyadicSum`)과 층위 가중 합 $\sum_{j=0}^{k-1} j 2^j = (k - 2)2^k + 2`(`weightedDyadicSum`)를 증명하고, 주파수 예산 성장률 $+\frac{2}{5}\log r$ 대 나쁜 순열 다항 감쇠율 $-\frac{3}{4}\log r$의 결합 모순율 $\frac{2}{5} - \frac{3}{4} = -\frac{7}{20} = -0.35 < 0$ 및 교차 저장소 구조를 검증합니다.
- [`verify_symbolic_ostmann.py`](proofs/verify_symbolic_ostmann.py): [`symbolic_verification_result.json`](proofs/symbolic_verification_result.json)을 재현하는 결정론적 SymPy 기호 검증기입니다.
