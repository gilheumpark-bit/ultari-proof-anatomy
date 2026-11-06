> **언어 선택 (Language)**: [**English (`README.md`)**](./README.md) | **한국어**

# 사례 005: OpenAI `#003` 수론 심사위원 감사 및 조건부 $\beta \to 1/2$ 전달 설계도

이 패키지는 OpenAI `#003`(`3,233`개 원본 `.lean` 파일 및 [`proofs/oai_ref/`](proofs/oai_ref/Endpoint.lean) 참조 모듈 `26`개)을 학술지 심사위원 관점에서 정밀 감사한 결과물입니다. 모든 결과는 `48`개 독립 Lean 4 정리와 `3`개 `def`(`v4.29.0-rc8`, `0 sorry`, 가설 변이 `441/441`건 포착, `영역 A` 분모 소거 산술)로 검증했습니다.

## 핵심 해부 결과

1. **혼재된 3종 $\beta$ 지표 분리**: 20개 모듈 전역 SOS 안장점($\beta_{\mathrm{SOS}}(0) = \frac{6843 - 7\sqrt{921}}{7578} \approx 0.874975 < \frac{7}{8}$, 유리수 증인 $\frac{41999}{48000}$), 국소 $\delta=0$ 단면 균형점($\frac{131}{150}$, $\frac{209}{240}$), 비예외 꼬리 바닥($\frac{4103}{4896} \approx 0.8380$)을 엄밀히 구분합니다.
2. **$\beta = 2/3$ 극점 장벽 돌파**: 슈티켈베르거-아이젠슈타인 소멸($k_\infty = -6 \neq 0$)과 $(1 - R_p)$ 약분을 결합해 `coordR` 수렴 경계를 $\frac{401}{600}(\to \frac{2}{3})$에서 $\frac{117}{200}(\to \frac{7}{12})$ 및 $\frac{301}{600}(\to \frac{1}{2})$로 낮춥니다.
3. **임계선($\beta = 1/2$) 조건부 전달 법칙**: 그람 이득에 따른 선형 전달 법칙 $\beta(\Delta_{\mathrm{gram}})$을 유도하고, `[Path A + Path B]` 결합 경로에서 $\beta = \frac{1}{2}$에 도달하기 위한 조건부 하이브리드 임계치 $\Delta_{\mathrm{hybrid}} = \frac{14}{33}$을 역산합니다([`thm_35`](proofs/qrh_mathematician_referee_audit.lean#L454-L461), [`thm_46`](proofs/qrh_eight_tasks_critical_upgrade.lean#L156-L171)).

## 4단계 독자 맞춤형 가이드

| 단계 | 대상 독자 | 문서 파일 | 핵심 내용 |
| :---: | :--- | :--- | :--- |
| **1단계** | **초보자 (일반 독자)** | [`01_초보자용_쉬운해설.md`](ko/01_초보자용_쉬운해설.md) | 심사위원이 던지는 5대 핵심 질문과 $\beta = 1/2$ 조건부 전달 경로의 직관적 해설. |
| **2단계** | **중급자 (이공계·개발자)** | [`02_중급자용_구조및수식가이드.md`](ko/02_중급자용_구조및수식가이드.md) | 매직 넘버 역산 수식, 전역 SOS 안장점, 48개 Lean 4 정리 1대1 줄 번호 색인표. |
| **3단계** | **전문가 (수론·형식증명 연구자)** | [`03_전문가용_수론학자심층심사보고서.md`](ko/03_전문가용_수론학자심층심사보고서.md) | 3단계 지수 손실, 베주-지겔 소거 사슬, 조건부 마스터 전달 방정식 심층 보고서. |
| **4단계** | **자동 검증기 및 파서** | [`04_자동검증및파서용_명세서.md`](ko/04_자동검증및파서용_명세서.md)<br>[`manifest.json`](manifest.json) | SHA-256 해시 원장, 가설 돌연변이 시험 규격 및 1줄 재현 명령어. |

## 형식증명 코드 및 1줄 검증 명령어

- [`qrh_mathematician_referee_audit.lean`](proofs/qrh_mathematician_referee_audit.lean): 정리 1~38 (`286/286` 변이 포착).
- [`qrh_eight_tasks_critical_upgrade.lean`](proofs/qrh_eight_tasks_critical_upgrade.lean): 정리 39~46 + `def` 3개 (`155/155` 변이 포착).
- [`verify_qrh_mathematician_audit.py`](proofs/verify_qrh_mathematician_audit.py), [`symbolic_verification_result.json`](proofs/symbolic_verification_result.json), [`problem_spec.md`](proofs/problem_spec.md).

```bash
lean proofs/qrh_mathematician_referee_audit.lean && lean proofs/qrh_eight_tasks_critical_upgrade.lean && (cd proofs && python3 verify_qrh_mathematician_audit.py)
```
