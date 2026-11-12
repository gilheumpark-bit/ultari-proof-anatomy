# Case 012: OpenAI `#266` (`Mutually unbiased bases in dimension six`) : 포렌식 해부 및 형식 검증 패키지

> **English Guide**: [README.md](README.md) | **상위 저장소**: [`ultari-proof-anatomy`](../../README.md)

본 케이스(`012-openai-266-mub-six`)는 OpenAI의 양자정보이론 대표 난제군 **`#266` (`Mutually unbiased bases in dimension six`, 2026년 9월 24일)**의 두 프리프린트(`N(6) = 3` 컴퓨터 보조 원고 `12`개 `.tex` `5,945`줄 + `references.bib` `363`줄 + `8`개 `.cpp` `2,316`줄, 그리고 복소 아다마르 푸리에 인증서 원고 `8`개 `.tex` `1,997`줄 + `references.bib` `326`줄 + `verify.py` `576`줄)와 저장소 단일 최대 규모인 `OAI/Analysis/MutuallyUnbiased/`의 **`3,386`개 Lean 4 파일(`2,835,031`줄)** 및 `OAI/LinearAlgebra/Hadamard/`의 **`9`개 파일(`1,329`줄)** 전수를 해부하고, `75`개 독립 Lean 4 정리(`1,249`줄, `0 sorry`, `358/358` 가설 변이 100% 포착, `74/75` 대수·논리 정리, `14`개 비선형·귀납 증명, `RH31` 이중 증인 검증)로 재검증한 패키지입니다.

---

## 1. 4단계 문서 색인 (`en/` & `ko/`)

| 단계 | 영문 문서 (`en/`) | 국문 문서 (`ko/`) | 핵심 범위 |
| :---: | :--- | :--- | :--- |
| **Tier 1** | [`en/01_Executive_Summary_and_General_Guide.md`](en/01_Executive_Summary_and_General_Guide.md) | [`ko/01_일반인용_해설서.md`](ko/01_일반인용_해설서.md) | 5대 인과적 질문 (비소수 거듭제곱 $d=6$에서의 바일-유한체 붕괴, $z^6-e_3z^3+e_6$ 세제곱 섬유 및 `5`-순환 유일성, 바이너 $6\to 7$ 초연산자 보완 및 `6`개 슈어 블록 Positivstellensatz `N(6) <= 5`, `283.5만`줄 전개 인플레이션과 고아 `Attainable 3`, 미형식화 `binary64` `N(6) = 3` 간극) |
| **Tier 2** | [`en/02_Intermediate_Math_and_Code_Guide.md`](en/02_Intermediate_Math_and_Code_Guide.md) | [`ko/02_중급자용_수학및코드가이드.md`](ko/02_중급자용_수학및코드가이드.md) | 3대 기둥 수식 파이프라인, `75`개 정리 매핑(`thm_01`~`thm_75`), 기호 검증기 해설 |
| **Tier 3** | [`en/03_Expert_Forensic_and_Mathematical_Physics_Report.md`](en/03_Expert_Forensic_and_Mathematical_Physics_Report.md) | [`ko/03_전문가용_학술및수리물리보고서.md`](ko/03_전문가용_학술및수리물리보고서.md) | `3,386 + 9`개 파일 층서학(`2,835,031`줄 대 `576`줄 파이썬 = `4,921.9`배 팽창, `Main.lean` `15/16` 미사용 임포트, `62,767`개 공허 `_h*` 바인더, 고아 `Attainable 3` `342`줄), `69/69` `oai_ref/` 전수 `#L` 인용, 반사 정규화(`>201만`줄 절감) 및 바이너 차원 강성($36-5k=6 \iff k=6$), `binary64` 하드웨어 계약 및 `.bib` 인용 감사 |
| **Tier 4** | [`en/04_Automated_Verification_and_Parser_Spec.md`](en/04_Automated_Verification_and_Parser_Spec.md) | [`ko/04_자동검증및파서용_명세서.md`](ko/04_자동검증및파서용_명세서.md) | 암호학적 SHA-256 체크섬 대조표 및 원클릭 재현 명령 |

---

## 2. 검증 산출물 (`proofs/`)

- [`proofs/mub6_hadamard_fourier_and_cubic_fibers.lean`](proofs/mub6_hadamard_fourier_and_cubic_fibers.lean#L1-L429) (`Theorems 1-25`, `429`줄, `103/103` 변이 포착, `nonlin: 7`)
- [`proofs/mub6_weiner_completion_and_gram_sos.lean`](proofs/mub6_weiner_completion_and_gram_sos.lean#L1-L416) (`Theorems 26-50`, `416`줄, `113/113` 변이 포착, `nonlin: 4`)
- [`proofs/mub6_stratigraphy_and_binary64_audit.lean`](proofs/mub6_stratigraphy_and_binary64_audit.lean#L1-L404) (`Theorems 51-75`, `404`줄, `142/142` 변이 포착, `nonlin: 3`)
- [`proofs/verify_symbolic_mub266.py`](proofs/verify_symbolic_mub266.py#L1-L439) $\to$ [`proofs/symbolic_verification_result.json`](proofs/symbolic_verification_result.json#L1-L180)
- [`proofs/problem_spec.md`](proofs/problem_spec.md#L1-L20) & [`manifest.json`](manifest.json#L1-L530)
