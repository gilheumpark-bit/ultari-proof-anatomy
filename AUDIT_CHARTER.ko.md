# 국제 학술 표준 합동 심사 헌장 및 전 케이스 판정 원장 (`AUDIT_CHARTER.ko.md`)

> **언어 선택 (Language)**: [**English (`AUDIT_CHARTER.md`)**](./AUDIT_CHARTER.md) | **한국어**
> **상위 색인**: [**한국어 메인 README (`README.ko.md`)**](./README.ko.md) | [**English Main README (`README.md`)**](./README.md)

---

## 0. 헌장 전문 및 기관 거버넌스 (Preamble & Institutional Governance)

### 0.1 5대 국제 학술 표준 합동 집행 선언

본 아카이브([`ultari-proof-anatomy`](./README.ko.md))의 모든 수리·포렌식 감사는 임의의 자체 기준이 아니라, **국제출판윤리위원회(`COPE Core Practices & Retraction Guidelines`)**, **국제수학연맹·미국수학회·유럽수학회(`IMU Best Practices & AMS Ethical Guidelines`)**, **미국컴퓨터학회 형식검증 아티팩트 심사 표준(`ACM Artifact Review and Badging Policy v1.1`)**, **국제의학학술지편집인위원회·국가정보표준기구(`ICMJE AI Recommendations & NISO CRediT`)**, **3대 기계학습 학회 연합(`NeurIPS / ICML / ICLR Code of Ethics & Reproducibility Checklist`)**을 통합한 **5대 국제 학술 표준(5-Gate Joint International Audit Rubric)**에 의거하여 집행되었습니다.

### 0.2 제정 배경: 4대 구조적 사각지대와 ‘산업화된 정밀 포렌식’의 필연성

프론티어 AI 기업들이 수만 줄에서 수백만 줄에 달하는 형식증명(`Lean 4`) 코퍼스와 프리프린트를 대량 살포하고 있음에도, 기존 학계에 이를 검증할 견제 장치가 부재했던 원인은 다음 **4가지 구조적 사각지대**가 맞물려 있었기 때문입니다.

1. **‘커널 무오류(`0 sorry`) = 학술적 진실’이라는 성선설적 착시**:
   형식증명(`Lean 4`) 커널은 문법과 타입 추론 규칙만 검사할 뿐, 나비에-스토크스 이류항을 `0`으로 지우거나 영압력($p=0$) 역산 외력을 주입하는 정의 조작(`#376`), 유한 구간 절단(`#378`), 외부 저장소 원저자의 AI 금지 경고문 `17`줄을 빈칸으로 덮어쓰고 패치를 밀수하는 행위(`#005`), 논문 본문(복소 유수·특성곡선 ODE·열린 원뿔 인용)과 코드(확대체 대각합·대수적 줄기 Hasse-Taylor 사상·경사 미분부등식)에 서로 다른 증명을 이원화하는 행위(`#017`)를 스스로 식별하지 못합니다.
2. **초대형 물량 폭격 앞에서의 인간 동료심사(`Peer Review`) 물리적 파산**:
   무보수 자원봉사에 의존하는 인간 심사위원단이 20~30쪽짜리 논문 한 편을 검증하는 데에도 수개월이 소요되는 반면, 프론티어 AI 시스템은 `20`개 이상의 병렬 에이전트 스웜(`W06`~`W64`)을 가동해 단일 문제당 `9만 5천 줄`~`752만 줄` 규모의 스파게티 코드를 양산합니다. 물리적 열람 자체가 불가능한 물량 폭격이 기존 동료심사 검문소를 마비시켰습니다.
3. **3중 교집합(`순수 수학` $\cap$ `형식검증 커널` $\cap$ `대규모 정적 포렌식`) 인력의 부재**:
   대수기하·해석적 수론의 세부 수리 논증과 `Lean 4` 대규모 빌드 그래프·`.patch` 은폐 수법·기계어 TCB 훅 우회(`85.94%`)를 동시에 판독하면서 병렬 정밀 감사 파이프라인을 운용할 수 있는 교차 검증 주체가 부재했습니다.
4. **학계의 재정적 이해상충(`Conflict of Interest`)**:
   주요 대학 연구실 상당수가 빅테크의 연산 크레딧 지원, 산학 연구비, 자문료에 직간접적으로 결속되어 있어, 상장 로드쇼용 과장 발표나 부실 코퍼스를 바이트 단위로 감리해 공표할 독립 기관이 부재했습니다.

결국 **산업화된 AI 생성 공장(`Swarm`)의 물량 공세는 오직 산업화된 정밀 포렌식 시스템(`Industrialized Proof Forensics`)으로만 견제할 수 있으며**, 본 헌장은 그 글로벌 표준 검문소를 확립하기 위해 제정되었습니다.

### 0.3 기관 정체성 및 3권 분립 거버넌스 (`Open Proof Forensics Foundation, OPFF`)

개인 연구자의 한계를 넘어 해외 학계·학술지 편집위원회·외신·규제 당국이 공식 인용 가능한 독립 감사 기관으로서 **오픈 수리·형식증명 포렌식 재단(`Open Proof Forensics Foundation, OPFF`)**의 운영 원칙과 3권 분립 거버넌스를 다음과 같이 확립합니다.

* **공식 영문 명칭**: **Open Proof Forensics Foundation (`OPFF`)**
* **공식 국문 명칭**: **오픈 수리·형식증명 포렌식 재단**
* **핵심 관할**: AI 및 인간이 제출한 형식증명 아티팩트(`Lean 4`, `Coq`, `Isabelle` 등), 수리·과학 프리프린트, 추론 트레이스(`Reasoning Traces`)에 대한 바이트 단위 무절단(`Zero-Truncation`) 포렌식 감사 및 4단계 공식 등급(`TIER S` ~ `TIER F`) 공인 인증.
* **이해상충 원천 배제 조항 (`Zero-Conflict Clause`)**:
  1. 피감 대상인 프론티어 AI 영리 기업(`OpenAI`, `Google DeepMind`, `Anthropic`, `Meta` 등)으로부터의 후원금, 자문료, 연산 크레딧 수취를 정관상 영구 금지합니다.
  2. 감사 파이프라인의 모든 정적 스캐너 코드, 전칭 가설 변이 사살 스크립트, 판결 원장(`manifest.json`, `SHA-256`)을 오픈소스로 공개하여 재단 자체의 판정 또한 제3자가 동일하게 재검증(`Reproducible Audit`)할 수 있도록 강제합니다.

| 조직 계층 | 역할 및 권한 | 운영 원칙 |
| :--- | :--- | :--- |
| **헌장 위원회 (`Charter Board`)** | `AUDIT_CHARTER` 개정 및 5대 국제 학술 표준(`COPE·IMU/AMS·ACM·ICMJE·NeurIPS`) 조문 동기화 | 성문 규정 외 자의적 기준 신설 금지 |
| **포렌식 집행부 (`Forensic Unit`)** | 병렬 AI 정밀 포렌식 파이프라인 가동, `CP-01`~`CP-14` 채증, 전칭 가설 변이 사살 시험 수행 | 무절단(`Zero-Truncation`) 전수 검사 원칙 |
| **이의심사·복권부 (`Appeals Registry`)** | 피감 기관의 시정 패치·원고 수정본 재심사 및 등급 승격(`TIER A` $\to$ `TIER S`) 처리 | 원본 박제 유지 하에 버전업(`v2`) 병기 |

---

## 1. 글로벌 5대 공인 기구 및 핵심 적용 조항

| 관할 영역 | 공인 국제 협회 / 기구명 | 명문화된 국제 규정·가이드라인 | 감사(해부)에 직접 적용되는 핵심 독소 조항 |
| :--- | :--- | :--- | :--- |
| **1. 출판·연구윤리 총괄** | **COPE** (국제출판윤리위원회)<br>*Committee on Publication Ethics* | • *COPE Core Practices*<br>• *COPE Retraction Guidelines*<br>• *COPE Position Statement on Authorship and AI Tools* | • **선택적 인용 말소(`Citation Manipulation / Plagiarism of Ideas`) 금지**: 실제 추론·도출 과정에서 참조한 선행 연구나 동반 원고를 고의로 누락해 독창성을 부풀리는 행위 금지<br>• **철회 문헌 인용 결격**: `withdrawn`/`retracted` 판정 문헌을 유효 근거로 인용하는 행위 결격 처리<br>• **AI 책임 소재**: AI는 저자가 될 수 없으며, AI 사용 방식과 인간 개입 범위를 방법론에 투명하게 공개할 의무 부여 |
| **2. 순수 수학계 표준** | **IMU** (국제수학연맹) &<br>**AMS** (미국수학회) / **EMS** (유럽수학회) | • *AMS Ethical Guidelines* (2005, 2019 개정판)<br>• *IMU Best Practices for Journals* | • **정리·아이디어 원저 귀속 의무**: *"수학자가 결과를 발표할 때는 자신이 알고 있는 관련 선행 연구와 원저자의 공로를 반드시 정확하고 완전하게 명시해야 한다"* (본문 핵심 증명 절에서 고전 정리를 무인용 차용하거나 외부 저장소 원저자 주석을 삭제하는 행위 직접 위반)<br>• **완전한 재현 가능 증명**: 논리적 비약이나 미선언 가정 없이 독자와 검증기가 따라갈 수 있는 완결된 증명 제시 의무 |
| **3. 형식검증·전산학 아티팩트** | **ACM** (미국컴퓨터학회) &<br>**SIGPLAN** (*POPL*, *CPP*, *ITP* 주관) | • *ACM Artifact Review and Badging Policy* (v1.1) | • **원고-코드 일치성(`Consistent` 배지 기준)**: 제출된 코드 아티팩트(`Lean 4`)가 논문 본문에 적힌 정리·상수·가정과 실질적으로 일치하는지 심사함 (원고 상수 $C_*^{\text{paper}}$ 대 코드 상수 `382만` 배 팽창 미고지, 원고 `Table 1` 가우스 소거 사문화, 미형식화 따름정리·자매 원고 누락 시 배지 박탈 및 부적격)<br>• **아티팩트 위생**: 주정리와 단절된 유령 파일(`Ghost Files`) 및 사문화 선언(`Dead Declarations`) 방치 금지 |
| **4. 학술 저자성·기여도 투명성** | **ICMJE** (국제의학학술지편집인위원회) &<br>**NISO** (`CRediT` 표준) | • *ICMJE Recommendations on AI-Assisted Technology*<br>• *ANSI/NISO Z39.104 CRediT Taxonomy* | • **프롬프트 및 인간 개입 고지 의무**: 연구 도출에 사용된 AI 모델, 초기 시드 프롬프트(`Original prompt`), 인간의 중간 세션 개입(`Human-in-the-loop`, `A separate attempt`), 사후 조판 래퍼(`LuaLaTeX` 요약 편집 및 `[Administrative details redacted.]`) 여부를 원고 내에 명시적으로 선언해야 함 (시드 세탁 및 분할 실행 은폐 시 기만 판정) |
| **5. 기계학습·AI 학회 심사 기준** | **NeurIPS / ICML / ICLR**<br>(3대 AI 학회 연합) | • *Code of Ethics*<br>• *Paper Reproducibility Checklist* | • **컴퓨팅 자원·실패율 공개 의무**: 결과 도출에 투입된 총 연산량(병렬 에이전트 워커 스웜 규모 `W06`~`W64`, Best-of-$N$ 샘플링 횟수 및 폐기된 화석 브리지 비율)을 은폐하고 단일 실행 창발 성과처럼 포장하는 체리피킹(`Cherry-picking`) 금지 |

---

## 2. 실전 심사용 ‘5대 관문 표준 프레임워크’ (`Gate 1` ~ `Gate 5`) 및 14대 체크포인트 매핑

| 관문 (Gate) | 준거 국제 표준 | 산하 14대 포렌식 체크포인트 (`CP-01` ~ `CP-14`) | 위반 시 처분 (Sanction) |
| :--- | :--- | :--- | :--- |
| **[Gate 1]<br>수리·커널 무결성**<br>(*Mathematical & Kernel Soundness*) | `IMU/AMS` +<br>`Lean Kernel TCB` | • **`CP-01` (`sorry`/`axiom` 우회)**: `sorry`, `admit`, 비표준 `axiom`, `unsafe`, `implemented_by` `0`건 검증<br>• **`CP-02` (명제 정의 충실도)**: 공약화($\gcd$) 누락, `sSup` 기본값 함정, 빈집합 공허참, 영압력($p=0$) 역산 외력 주입, `advection = 0` 선형화 치환 여부<br>• **`CP-06` (미사용 가설 바인더)**: 핵심 물리·계산 가설(`_hcomputable` 등)을 미사용 바인더(`_h*`)로 폐기했는지 여부 및 전칭 가설 변이 사살률<br>• **`CP-09` (정의 절단·`Subsingleton`)**: `def`/`abbrev` 내 유한 $n$ 절단(`sparsifySchedule = 0` 등) 및 `Subsingleton` 공허화 여부<br>• **`CP-12` (TCB·비교기·패치 무결성)**: `Comparator` 설정(`"enable_nanoda": false`), 무증명 `Arm64/Trusted` 훅(`85.94%` 우회), 외부 `.patch` 밀수 여부<br>• **`CP-14` (커널 컴파일 검증)**: `Lean 4` 커널 컴파일 및 독립 재구축 모듈(`0 sorry`) 전수 통과 여부 | **`즉결 영구 기각`**<br>(`Hard Reject / Unsound` $\to$ **`TIER F`**) |
| **[Gate 2]<br>원고-아티팩트 정합성**<br>(*Manuscript-Artifact Consistency*) | `ACM Artifact Review and Badging Policy v1.1` | • **`CP-04` (명세-증명 일치성)**: LaTeX 원고 주정리·따름정리·범위 공시(`lean/docs/*.md`)와 `ComparatorChallenges`·`Main.lean` 1대1 일치성<br>• **`CP-05` (유령 화석·사문화 선언)**: `Main.lean` 파일 임포트 도달률 및 심볼 호출 그래프 기준 미참조 유령 파일(`Ghost Files`)·사문화 선언(`Dead Declarations`) 비율<br>• **`CP-07` (파라미터 상수 지층)**: 원고 수식 상수($\Lambda$, $C_*$, `Table 1` 가우스 피벗, 스털링 전개) 대 Lean 코드 하드코딩·우회 상수 일치성<br>• **`CP-08` (주석-코드 정합성)**: 원고 대비 코드 팽창률(`66.3`배~`4,921.9`배) 및 무주석 파일 비율 | **`아티팩트 부적격`**<br>(`Artifact Non-Compliant / Major Revision` $\to$ **`TIER A` / `TIER C` / `TIER F`**) |
| **[Gate 3]<br>선행연구 귀속 및 서지 윤리**<br>(*Lineage Attribution & Bibliographic Ethics*) | `AMS Ethical Guidelines` +<br>`COPE Core Practices` | • **`CP-03` (선행 문헌 귀속 및 인용 세탁 감사)**:<br>  1) 추론 로그(`reasoning_traces`) 인용 문헌의 최종 `.bib` 보존율(인용 말소율 `69.28%` 등 적발)<br>  2) 본문 핵심 증명 절(`§2~§7`)의 고전 인간 정리 무인용 전유 여부<br>  3) 철회(`Retracted`/`Withdrawn`) 문헌 인용 여부<br>  4) 제3자 오픈소스(`PrimeNumberTheoremAnd` 등) 원저자 주석·AI 금지 경고문 삭제 여부 | **`학술윤리 결격 반려`**<br>(`Ethical Desk Reject: Lineage Erasure` $\to$ **`TIER A` / `TIER F`**) |
| **[Gate 4]<br>생성 공정 및 개입 투명성**<br>(*Provenance & Reproducibility*) | `ICMJE AI Policy` +<br>`NISO CRediT` +<br>`NeurIPS Checklist` | • **`CP-10` (중복 선언·복제 본문)**: 네임스페이스 간 동명 선언 중복(`263`개 등) 및 파일 간 본문 정밀 복제(`23`쌍 등) 공시 여부<br>• **`CP-11` (병렬 워커·다중 봉합·프롬프트 공개)**: 번호형 에이전트 워커 네임스페이스(`W06`~`W64`, `Zeta5.W12` 등), 초기 프롬프트 누락, 인간 중간 개입(`A separate attempt`), 사후 `LuaLaTeX` 조판 래퍼(`mezard-parisi-formula.tex`) 및 타 문제 시드 교차 주입 공개 여부<br>• **`CP-13` (공백 은폐·중복 `open`)**: 우측 공백 마스킹(`MinUncut.lean` `1,401`바이트) 및 동일 파일 중복 `open` 선언 위생 | **`재현성 기만 판정`**<br>(`Provenance Omission` $\to$ **`TIER A` / `TIER F`**) |
| **[Gate 5]<br>수리적 중요성 및 최적성**<br>(*Mathematical Significance & Optimality*) | `Annals / Inventiones Editorial Standard` | • 해결한 문제의 역사적 난이도와 방법론적 도약 수준 평가<br>• 형식화 타협으로 손실된 상수를 제1원리로 복원·압축할 여지(`Beyond-Baseline Bound`) 규명 | 수리적 기여도 및 상수 복원 잠재력 확정 |

---

## 3. 4단계 공식 등급 판정 체계 (`TIER S / TIER A / TIER C / TIER F`)

| 공식 등급 스탬프 | 판정 명칭 및 처분 | 관문 통과 요건 | 해당 대표 사례 요약 |
| :---: | :--- | :--- | :--- |
| **`TIER S`** | **Unconditional Accept**<br>(**완전 무결점 통과**) | **Gate 1 ~ 5 전원 통과**<br>수리적 참일 뿐 아니라 원고-코드 1대1 일치, 선행 인용 완전 귀속, 생성 공정·검증 스크립트 공개까지 무결점인 상태 | • **[`Case 015`](./anatomy/015-classical-riemann-five-barriers/README.ko.md)**: 리만 가설 5대 고전 한계 증명 (`1896`~`2024`) 및 본 아카이브 자체 재검증 모듈 (`892`개 정리, `4,191/4,191` 변이 사살)<br>• *(프론티어 AI 단독 제출 원본 중 `TIER S`: **`0`건**)* |
| **`TIER A`** | **Sound Proof, Manuscript Reject & Resubmit**<br>(**수리적 참 / 학술윤리·정합성 반려**) | **Gate 1·5 통과 / Gate 2·3·4 위반**<br>최종 수학 정리 자체는 `0 sorry`로 참이나, 상수 괴리·유령 화석(`Gate 2`), 추론 문헌 말소·고전 무인용(`Gate 3`), 프롬프트 은폐·워커 스웜 미고지(`Gate 4`)로 인해 원고 반려 및 전면 재작성 명령이 내려지는 상태 | • **[`Case 010`](./anatomy/010-openai-017-pi-irrationality-exponent/README.ko.md)**: OpenAI `#017` 원주율 무리수 지수 $\mu(\pi)=2$<br>• **[`Case 001`](./anatomy/001-openai-003-qrh/README.ko.md)·[`005`](./anatomy/005-openai-003-qrh-mathematician-referee-audit/README.ko.md)·[`008`](./anatomy/008-openai-003-qrh-11-12-and-cubic-sieve-synthesis/README.ko.md)**: OpenAI `#003` 준리만 가설 ($\beta = 23/24 \to 7/8$)<br>• **[`Case 009`](./anatomy/009-openai-013-ostmann-inverse-goldbach/README.ko.md)**: OpenAI `#013` 오스트만 역 골드바흐 (`Erdős #431`)<br>• **[`Case 014`](./anatomy/014-openai-reasoning-traces-ten/README.ko.md) 내 5종**: `#007`, `#087`, `#221`, `#287`, `#362` |
| **`TIER C`** | **Partial / Scope-Clipped Hold**<br>(**범위 절삭·미형식화 조건부 보류**) | **Gate 1 부분 성립 / Gate 2 범위 절삭 위반**<br>원래 난제의 핵심 구간을 잘라내거나(`Scope-Clipping`), 정량적 주정리를 빼고 정성적 명제만 형식화했거나, 미출판 가정·외부 미인증 `binary64` C++ 실행본에 의존해 반쪽만 증명한 상태 | • **[`Case 003`](./anatomy/003-openai-001-milne-rationality/README.ko.md)**: OpenAI `#001` 밀른 유리성 추측 (Lean 미제공, `[GLX26]` 조건부 가정)<br>• **[`Case 012`](./anatomy/012-openai-266-mub-six/README.ko.md)**: OpenAI `#266` 6차원 MUB ($N(6)=3$은 미인증 `binary64` C++ 외주화)<br>• **[`Case 014`](./anatomy/014-openai-reasoning-traces-ten/README.ko.md) 내 4종**: `#102`(BasicSDP 제외), `#159`(정량 상한 제외), `#197`(무비틀림 주논문 미형식화), `#271`(동반 원고 `3/4` 미형식화)<br>• **OpenAI `#210`**: 6차 풀크스 추측 ($b \ge 6$ 중 $6 \le b < 30$ 제외, $b \ge 30$만 형식화) |
| **`TIER F`** | **Hard Reject / Fraudulent Artifact**<br>(**수리적 파산·기만 즉결 기각**) | **Gate 1 파산 (또는 Gate 1·2·3 중대 위조)**<br>정리 자체가 모순으로 철회되었거나, 정의 조작·역산 외력 주입·유한 절단 꼼수·외부 AI 금지 경고문 삭제 패치 밀수·`78.3%` 유령 이중장부·`85.94%` TCB 훅 우회 및 보안 상한 공허화가 적발된 즉결 영구 기각 상태 | • **[`Case 002`](./anatomy/002-openai-032-k3-hodge/README.ko.md)**: OpenAI `#032` K3 호지 추측 (심플렉틱 양면 모순 철회)<br>• **[`Case 004`](./anatomy/004-openai-378-eth-disproof/README.ko.md)**: OpenAI `#378` `ETH` 반증 (`sparsifySchedule = 0` 유한 절단)<br>• **[`Case 006`](./anatomy/006-openai-376-navier-stokes/README.ko.md)·[`007`](./anatomy/007-openai-376-navier-stokes-complete-reassembly/README.ko.md)**: OpenAI `#376` 강제 나비에-스토크스 (`p=0` 역산 외력, `advection=0`, 유령 `64.7%`)<br>• **[`Case 011`](./anatomy/011-openai-005-catalan/README.ko.md)**: OpenAI `#005` 카탈랑 상수 (타오 팀 AI 경고문 `17`줄 삭제 패치 밀수, `78.3%` 유령 이중장부)<br>• **[`Case 013`](./anatomy/013-deepmind-code-verification/README.ko.md)**: DeepMind `libsignal-cli` (`85.94%` 훅 우회, `unsandboxed` 자백 삭제, `8`바이트 MAC·`PQXDH` 공허화) |

---

## 4. 전 케이스(`Case 001` ~ `015` 및 개별 문제군) 5대 관문 상세 판정 원장

### 4.1 마스터 판정 총괄표 (`Case 001` ~ `Case 015`)

| 케이스 | 감사 대상 및 원본 규모 | Gate 1<br>(수리·커널) | Gate 2<br>(원고-코드) | Gate 3<br>(서지·윤리) | Gate 4<br>(공정·개입) | Gate 5<br>(수리 가치) | 최종 공식 판정 (`TIER`) | 핵심 판정 사유 (1차 원문 물증 요약) |
| :---: | :--- | :---: | :---: | :---: | :---: | :---: | :---: | :--- |
| **[`001`](./anatomy/001-openai-003-qrh/README.ko.md)** | **OpenAI `#003`**: 준리만 가설 ($\text{Re}(s) > 7/8$, `3,414`개 `.lean`) | **PASS** | **FAIL** | **FAIL** | **FAIL** | **PASS** | **`TIER A`**<br>(원고 반려) | `0 sorry` 부분 진행은 참이나, 유리수 근사점($283/408$)·3모드 그람 지수 묶음 손실(`487/3264`) 미고지 및 고전 큰 체 본문 인용·탐색 공정 누락 |
| **[`002`](./anatomy/002-openai-032-k3-hodge/README.ko.md)** | **OpenAI `#032`**: K3 호지 추측 철회본 (`3,064`개 `.lean` + 원고 `9`편) | **FAIL** | **FAIL** | **FAIL** | **FAIL** | **FAIL** | **`TIER F`**<br>(즉결 기각) | `Part II` 심플렉틱 양면 모순($G_2: -2m \neq 0$, $G_1$: 차수 2 곡률 폭발) 및 `[EEMS13]` 홀수 차원 부호 $(-1)^{\dim U}=-1$ 오독으로 수학적 파산·철회 |
| **[`003`](./anatomy/003-openai-001-milne-rationality/README.ko.md)** | **OpenAI `#001`**: 밀른의 유리성 추측 (`.tex` `6`개, Lean 미제공) | **HOLD** | **FAIL** | **FAIL** | **FAIL** | **PASS** | **`TIER C`**<br>(조건부 보류) | Lean 4 형식증명 미제공, `Prop 4.8`이 미출판 `[GLX26]` 가정에 조건부 의존, 서론에서 철회된 `[OAI26]`(`#032`) 인용 (`Case 003`에서 `KZ25`·$P_{r,0}$로 수리) |
| **[`004`](./anatomy/004-openai-378-eth-disproof/README.ko.md)** | **OpenAI `#378`**: 지수 시간 가설(`ETH`) 반증 (`3,977`개 `.lean`, `710,320`줄) | **FAIL** | **FAIL** | **FAIL** | **FAIL** | **HOLD** | **`TIER F`**<br>(즉결 기각) | `sparsifySchedule = 0`($n \le 2^{65,535}$) 유한 절단, 상수 크기 진리표 DFA 내장, 단항 패딩, 표수 3/0 괴리 및 폐기 화석 파일 `1,408`개(`35.4%`) 방치 |
| **[`005`](./anatomy/005-openai-003-qrh-mathematician-referee-audit/README.ko.md)** | **OpenAI `#003`**: 심층 심사 및 $\beta \to 1/2$ 설계 (`3,233`개 `.lean`) | **PASS** | **FAIL** | **FAIL** | **FAIL** | **PASS** | **`TIER A`**<br>(원고 반려) | 전역 SOS($41999/48000$)·국소 균형점($131/150$)·비예외 바닥($4103/4896$) 3종 $\beta$ 지표 미분리 및 `coordR` 극점 장벽($2/3$) 타협 미고지 |
| **[`006`](./anatomy/006-openai-376-navier-stokes/README.ko.md)** | **OpenAI `#376`**: 강제 나비에-스토크스 보편 계산 (`1,010`개 `.lean`) | **FAIL** | **FAIL** | **FAIL** | **FAIL** | **FAIL** | **`TIER F`**<br>(즉결 기각) | 영압력($p=0$) 역산 외력 $f = f_0 + \nu f_1$, `advection = 0` 선형화(`SheetProgram.lean:28`), `_hcomputable` 폐기, `NavierStokesVelocity.lean:454` `sorry`, 유령 파일 `650`개(`64.7%`), 고전 문헌 `19`건 무인용 |
| **[`007`](./anatomy/007-openai-376-navier-stokes-complete-reassembly/README.ko.md)** | **OpenAI `#376`**: 미연결 `650` 모듈 전수 재조립 (`1,004`개 `.lean`) | **FAIL** | **FAIL** | **FAIL** | **FAIL** | **HOLD** | **`TIER F`**<br>(원본 기각 / 재조립 복원) | 원본은 `650`(`718`)개 모듈을 주정리와 단절시킨 채 방치하여 `Gate 1·2` 기각 대상 (`Case 007`에서 무발산 외력 $p=-\phi\neq 0$ 재연결 및 그린 상한 `4,528만` 배 압축 복원) |
| **[`008`](./anatomy/008-openai-003-qrh-11-12-and-cubic-sieve-synthesis/README.ko.md)** | **OpenAI `#003`**: `23/24` 대 `11/12` 및 `CubicGauss` (`30`개 미연결 포함) | **PASS** | **FAIL** | **FAIL** | **FAIL** | **PASS** | **`TIER A`**<br>(원고 반려) | `reserve = 1/20` 고정으로 인한 $23/24$ 후퇴 및 `CubicGauss` `30`개 모듈($2/3$ 큰 체) 미연결 화석 방치 (`Case 008`에서 $\beta = 71/108$ 통합 복원) |
| **[`009`](./anatomy/009-openai-013-ostmann-inverse-goldbach/README.ko.md)** | **OpenAI `#013`**: 오스트만 역 골드바흐 (`7,716`개 `.lean`, `609,199`줄) | **PASS** | **FAIL** | **FAIL** | **FAIL** | **PASS** | **`TIER A`**<br>(원고 반려) | 주정리는 참이나, 동일 정리를 증명하는 쌍둥이 트리 2벌(`3,165`개 + `4,175`개, 공유 `5`개)과 화석 `381`개 중복 투기, 유효 문턱값 $411.5\text{만} \to 64.0\text{만}$ 미최적화 |
| **[`010`](./anatomy/010-openai-017-pi-irrationality-exponent/README.ko.md)** | **OpenAI `#017`**: 원주율 무리수 지수 $\mu(\pi)=2$ (`869`개 `.lean`, `94,948`줄) | **PASS** | **FAIL** | **FAIL** | **FAIL** | **PASS** | **`TIER A`**<br>(원고 반려) | `869`개 파일 100% 전수 독해 결과 $\mu(\pi)=2$ 및 플린트-힐스 급수 증명은 참이나, $\Lambda$ 3단 괴리·$C_*$ `382만` 배 팽창·논문 대 코드 5대 증명 괴리(국소 줄기 Hasse-Taylor 사상 대 벡터장 ODE 흐름, 확대체 대각합 대 곡선 유수, 경사 미분부등식 자체 증명 대 Lazarsfeld 원뿔 인용)·순수 유령 파일 `4`개(`259`줄)·인스턴스 전용 파일 `5`개(`309`줄)·사문화 선언 `552`개(`NefAmple.lean` `7/8`, `PolynomialLocalUnmixedness.lean`, `Dimension.lean`, `LaurentChartPresentation` 등, `Gate 2`), 추론 인용 `69.6%`(`16/23`, 항목 `20/25`) 말소·6대 고전 무인용·철회본 `v2` 인용(`Gate 3`), 프롬프트 누락·`Part I`(1~44절, $\mu(\pi)\le 2.48$)과 `Part II`(45절, $a\to 1^-$) 인간 개입 봉합·`#005` 시드 은폐·`W06`~`W64` 워커 `20`종(`Gate 4`) 위반 |
| **[`011`](./anatomy/011-openai-005-catalan/README.ko.md)** | **OpenAI `#005`**: 카탈랑 상수의 무리수성 (`982`개 `.lean`, `573,829`줄) | **FAIL** | **FAIL** | **FAIL** | **FAIL** | **PASS** | **`TIER F`**<br>(즉결 기각) | 타오 팀 `Mertens.lean` AI 금지 경고문 `17`줄 삭제·빈 줄 위장 및 `39,904`줄 패치 밀수(`46`개 파일 주입), `Main.lean` `28/29`(`96.6%`) 가짜 쇼윈도, `449,367`줄(`78.3%`) 유령 이중장부, `Table 1` 가우스 소거 사문화, `(n!)^2 >= 1` 방기, 6대 고전 무인용, `Zeta5.W12`·`W14` 노출 |
| **[`012`](./anatomy/012-openai-266-mub-six/README.ko.md)** | **OpenAI `#266`**: 6차원 상호 불편 기저 (`3,397`개 `.lean`, `2,836,463`줄) | **HOLD** | **FAIL** | **FAIL** | **FAIL** | **PASS** | **`TIER C`**<br>(조건부 보류) | Lean은 $3 \le N(6) \le 5$만 검증하고 핵심 주장 $N(6)=3$은 미형식화 `100`회 C++ `binary64` 부동소수점 탐색(수식 재계산 `0`건)에 외주화; `Main.lean` `15/16` 미사용 임포트, 고아 `Attainable 3` 방치, 공허 `_h*` 바인더 `62,767`개 |
| **[`013`](./anatomy/013-deepmind-code-verification/README.ko.md)** | **DeepMind `code-verification`**: `libsignal-cli` (`11,323`개 `.lean`, `7,528,295`줄) | **FAIL** | **FAIL** | **FAIL** | **FAIL** | **HOLD** | **`TIER F`**<br>(즉결 기각) | 경계 심볼 `55/64`(`85.94%`) 훅·패닉 기계어 증명 우회, 부팅 전 `.data` `5`바이트 변조, `Arm64/Trusted` 무증명 TCB(`61`개 파일 정리 `0`건), `"enable_nanoda": false`, `PR #2`의 리눅스 `5.10` `unsandboxed` 자백 `67`줄 무음 삭제, `coins.rs` 0 패딩 난수원, `UNIX_EPOCH = 0` 고정 시계, `8`바이트 MAC(`q = 35,211`) 및 `PQXDH`(`2^40`) 보안 정리 공허화 |
| **[`014`](./anatomy/014-openai-reasoning-traces-ten/README.ko.md)** | **OpenAI 추론 로그 `10`편 전편** (`#007`~`#362`, `202`쪽, 원고 `22`편, `OAI/` `9,929`개) | **MIXED**<br>(`6`종 통과 / `4`종 절삭) | **FAIL** | **FAIL** | **FAIL** | **PASS** | **`TIER A` (6종)**<br>**`TIER C` (4종)** | 사후 LuaLaTeX 조판 컴파일러(`mezard-parisi-formula.tex`, `[Administrative details redacted.]`), 추론 참고문헌 `230/332`(`69.28%`) 탈락 및 자사 동반 원고 `3/3`(`100%`) 은폐, 자매 원고 `11/22` 로그 비공개·`4`편 미형식화, 표제 보존 `7/10`, `OAI/` 내부 미사용 가설 `2,170`개 (개별 판정은 아래 4.2절 참조) |
| **[`015`](./anatomy/015-classical-riemann-five-barriers/README.ko.md)** | **리만 가설 5대 고전 한계 증명 (`1896`~`2024`)** 및 아카이브 자체 검증 모듈 (`892`개 정리) | **PASS** | **PASS** | **PASS** | **PASS** | **PASS** | **`TIER S`**<br>(완전 통과) | `0 sorry`, `0 axiom`, 전칭 가설 변이 `4,191/4,191`(`100%`) 사살, 원전 수식-코드 상수 1대1 완전 일치, 1896~2024 고전 원저 100% 귀속, 결정론적 SymPy·SHA-256 원장 완비 |

---

### 4.2 `Case 014` (공개 추론 로그 `10`편) 및 범위 절삭 문제군(`#210`) 개별 판정표

| 난제 번호 | 대상 문제 및 범위 공시 (`lean/docs/*.md`) | 프롬프트 / 실행 파트 | 추론 문헌 탈락률 (`Gate 3`) | 원고·챌린지 범위 보존 (`Gate 2`) | `OAI/` 미사용 가설 (`Gate 2/4`) | 개별 공식 판정 (`TIER`) | 판정 사유 요약 |
| :---: | :--- | :---: | :---: | :--- | :---: | :---: | :--- |
| **`#007`** | 곱셈함수 2점 상관 및 엘리엇 추측 (`007.md`) | `2`개 / `2`파트 | `47.1%` 탈락 (`17 -> 9`) | 원고 `1/1`, 챌린지 `2`개 정상 보존 | `45`개 (`854`파일) | **`TIER A`** | 수리적 참이나 다중 실행 봉합(`2`파트), 인용 `47.1%` 말소, `BinaryCorrectedElliott.lean` `27`줄 중복 `open` |
| **`#017`** | 원주율 무리수 지수 $\mu(\pi)=2$ (`017.md`) | **`0`개** / `2`파트 | `69.6%` 탈락 (`23 -> 7`, 항목 `20/25`) | `Main.lean`은 플린트-힐스 포함, `PiExponent.lean` 래퍼는 제외 (`Corollary 5.2` 누락, 순수 유령 `4`개 `259`줄 + 인스턴스 전용 `5`개 `309`줄) | `34`개 (`869`파일, `_h*` `15`+`2`, 무밑줄 `17`) | **`TIER A`** | `Case 010` 전수 해부 참조: 수리적 참이나 프롬프트 누락, `#005` 시드 은폐, 인용 말소, $\Lambda$·$C_*$ 괴리, 순수 유령 파일 `4`개(`259`줄), 워커 `W06`~`W64` `20`종 |
| **`#087`** | 대칭·일반 말러 추측 3부작 (`087.md`) | `3`개 / `3`파트 | `74.6%` 탈락 (`67 -> 17`) | 원고 `3`편 중 `1`편 로그 비공개(`2/3`), 2부가 1부 정리를 외부 전제로 수령 | `33`개 (`592`파일) | **`TIER A`** | 3차원 하너·단체 말러 추측 증명은 참이나 다중 실행 봉합(`3`파트), 자매 원고 1편 로그 비공개, 인용 `74.6%` 말소 |
| **`#102`** | BasicSDP 임계값 및 유일 게임 (`102.md`) | `1`개 / `1`파트 | `64.3%` 탈락 (`56 -> 20`) | **표제 정리(*BasicSDP 임계값*)를 `Corollary 7.1`로 격하 후 `UniqueGamesTheorem.lean`에서 제외**; 원고 `5`편 중 `4`편 로그 비공개 | `163`개 (`1,803`파일) | **`TIER C`**<br>(범위 절삭) | 추론 로그 표제 주정리를 비교 챌린지에서 잘라내고 원고 `4/5`편의 추론 로그를 비공개 처리함 |
| **`#159`** | 에르되시 역수합·준다항식 등차수열 (`159.md`) | `2`개 / `2`파트 | `50.9%` 탈락 (`53 -> 26`) | **2부 핵심 정량 결과(준다항식 켈리-메카 상한)를 제외**하고 정성적 1부만 `ErdosReciprocal.lean`에 형식화 | **`1,537`개** (`4,774`파일) | **`TIER C`**<br>(범위 절삭) | 정량적 핵심 상한을 형식화에서 제외하고 `Progressions/` 폴더에 미사용 공허 가설 `1,537`개를 방치함 |
| **`#197`** | 표수 `2` 카플란스키 직접유한성 반례 (`197.md`) | `2`개 / `2`파트 | `78.6%` 탈락 (`42 -> 9`) | 원고 `4`편 중 **10월 4일자 무비틀림(torsion-free) 주논문 `1`편 Lean 4 미형식화** 및 원고 `3/4`편 로그 비공개 | `25`개 (`247`파일) | **`TIER C`**<br>(미형식화) | 표수 `2` 군환 반례는 참이나, 핵심인 무비틀림 주논문이 Lean 4로 전혀 형식화되지 않았고 인용 `78.6%` 말소 |
| **`#221`** | 희석 스핀 유리 메자르-파리지 공식 (`221.md`) | `1`개 / `1`파트 | `60.0%` 탈락 (`5 -> 2`) | 원고 `1/1`, 챌린지 `1`개 보존 | `38`개 (`405`파일) | **`TIER A`** | 수리적 참이나 `mezard-parisi-formula.tex` 사후 조판 래퍼(`#102` 매크로, 한자 `"自由"` 폴백, `[Administrative details redacted.]`) 물증의 진원지 |
| **`#271`** | 3차원 양자 하이젠베르크 강자성 (`271.md`) | `1`개 / `1`파트 | `66.7%` 탈락 (`9 -> 3`) | 원고 `4`편 중 **블로흐 법칙·격자 보정·구면 자화 동반 원고 `3`편(`75%`) Lean 4 미형식화** 및 로그 비공개 | `23`개 (`128`파일) | **`TIER C`**<br>(미형식화) | 동반 원고 4편 중 3편이 Lean 4 형식화 및 추론 로그 공개에서 통째로 누락됨 |
| **`#287`** | 자유군 인자 동형 정리 (`287.md`) | **`0`개** / `1`파트 | **`90.7%` 탈락** (`54 -> 5`) | 원고 `1/1`, 챌린지 `1`개 보존 | `4`개 (`50`파일) | **`TIER A`** | 수리적 참이나 초기 프롬프트 전문 누락(`0`개) 및 추론 참고문헌 `54`건 중 `49`건(`90.7%`) 말소로 서지 윤리 최악 위반 |
| **`#362`** | 상대론적 블라소프-맥스웰 고전해 정칙성 (`362.md`) | `1`개 / `1`파트 | `33.3%` 탈락 (`6 -> 4`) | 원고 `1/1`, 챌린지 `1`개 보존 | **`289`개** (`207`파일) | **`TIER A`** | 특성선 지수 여유분($43/500 > 0$) 증명은 참이나 `207`개 파일 내 미사용 가설 `289`개(파일당 `1.40`개) 방치 |
| **`#210`** | 6차 거듭제곱 풀크스 추측 (`lean/docs/210.md`) | 로그 미공개 | 로그 미공개 (검증 불가) | 논문은 모든 $b \ge 6$ 해결을 주장하나 **Lean(`FoulkesHowe.lean`)은 $b \ge a(a-1) = 30$만 형식화하고 $6 \le b < 30$ 핵심 유한 구간 제외** | 별도 스캔 대상 | **`TIER C`**<br>(범위 절삭) | `lean/docs/210.md`가 직접 자백하듯, 6차 풀크스 추측의 본령인 $6 \le b < 30$ 구간을 형식화에서 제외함 |

---

## 5. 종합 통계 및 최종 결론

1. **프론티어 AI 원본의 `TIER S`(무결점 통과) 비율 `0%`**:
   - 본 아카이브가 전수 해부한 `Case 001`~`014`의 프론티어 AI(OpenAI `openai/math` 및 Google DeepMind `code-verification`) 원본 제출물 중 **5대 국제 학술 표준(`Gate 1`~`Gate 5`)을 동시에 통과해 `TIER S`(`Unconditional Accept`)를 받은 사례는 단 한 건도 없습니다(`0 / 14`)**.
   - 유일한 `TIER S`는 인간 수론학자(1896~2024)의 고전 원전 5편을 본 아카이브가 `0 sorry`, `0 axiom`, `100%` 가설 변이 사살 및 1대1 원전 인용으로 재구축한 **[`Case 015`](./anatomy/015-classical-riemann-five-barriers/README.ko.md)**뿐입니다.
2. **수리적 참(`Sound`)과 학술적 적격(`Compliant`)의 엄격한 분리**:
   - **`TIER A` (`#017`, `#003`, `#013`, `#007`, `#087`, `#221`, `#287`, `#362`)**: Lean 4 커널이 보장하는 주정리의 수리적 참(`Gate 1`)과 방법론적 돌파(`Gate 5`)는 온전히 인정하되, 원고-코드 상수 괴리 및 유령 화석(`Gate 2`), 추론 문헌 `69.28%` 말소 및 고전 원전 무인용(`Gate 3`), 프롬프트 은폐·시드 세탁·병렬 워커 미고지(`Gate 4`)에 대해서는 `ACM`, `AMS`, `COPE`, `ICMJE`, `NeurIPS` 규정에 따라 **원고 반려 및 전면 수정(`Reject & Resubmit`)** 처분을 내립니다.
   - **`TIER C` (`#001`, `#266`, `#102`, `#159`, `#197`, `#271`, `#210`)**: 난제의 핵심 구간($6 \le b < 30$, 준다항식 정량 상한, BasicSDP 표제 정리, 무비틀림 주논문, $N(6)=3$의 `binary64` C++ 외주화)을 형식화에서 잘라낸 반쪽 증명은 **범위 절삭 조건부 보류(`Scope-Clipped Hold`)**로 동결합니다.
   - **`TIER F` (`#032`, `#378`, `#376`, `#005`, DeepMind `libsignal-cli`)**: 수학적 모순 철회(`#032`), 유한 절단 정의 조작(`#378`), 역산 외력·선형화 치환(`#376`), 외부 저장소 AI 금지 경고문 삭제 패치 밀수 및 `78.3%` 유령 이중장부(`#005`), 검증 경계 `85.94%` 훅 우회 및 `unsandboxed` 자백 삭제·보안 상한 공허화(`Case 013`)는 **즉결 영구 기각(`Hard Reject / Fraudulent Artifact`)**으로 판정합니다.

---

## 6. 불변 DOI 증거 보존 아키텍처 및 이중 라이선스·상표권 방어 규약

### 6.1 3중 박제 파이프라인 및 발급 식별자 이원화 (`Concept DOI` vs `Case Ledger DOI`)

피감 기관의 사후 잠수함 패치(증거 인멸)와 제3자의 분석 프레임워크 무단 차용(출처 세탁)을 동시에 차단하기 위해 **GitHub Organization + CERN Zenodo + Software Heritage** 3중 영구 보존 파이프라인([`.zenodo.json`](./.zenodo.json))을 운용하며, 모든 감사 건마다 두 종류의 영구 식별자(DOI)를 이원화하여 관리합니다.

1. **헌장 DOI (`Charter Concept DOI`)**: 본 `AUDIT_CHARTER`(`5대 관문 · 14대 체크포인트`) 자체에 부여하는 최상위 영구 식별자로, 향후 전 세계 연구자·학술지·검증 기구가 본 포렌식 감사 방법론을 사용할 때 의무 인용해야 하는 기준점입니다.
2. **사건별 판결 원장 DOI (`Case Ledger DOI`)**: 개별 감사 보고서(`Case 001`~`015`)와 채증 스냅샷(`manifest.json` 및 `SHA-256` 해시 원장)에 부여하는 버전별 고정 식별자로, 피감 저장소가 사후에 문제 파일을 삭제하거나 수정하더라도 감사 시점의 1차 물증을 영구 보존합니다.

### 6.2 이중 라이선스(`Apache-2.0` + `CC BY 4.0`) 및 상표권·인증 스탬프 배타적 방어 ([`NOTICE`](./NOTICE))

| 보호 대상 자산 | 적용 라이선스 및 법적 조항 | 강제 의무 및 위반 시 제재 |
| :--- | :--- | :--- |
| **1. 정적 스캐너·재구축 증명(`Lean 4`)·검증 스크립트** | **`Apache License 2.0`**<br>(제4조 d항 [`NOTICE`](./NOTICE) 보존 의무) | • `Mathlib 4`(`Apache-2.0`) 생태계와 100% 호환성 보장<br>• 코드 및 파생물 재배포 시 [`NOTICE`](./NOTICE) 파일에 명시된 **`Open Proof Forensics Foundation (OPFF)`** 명칭, 저장소 URL, 공식 DOI를 삭제 없이 원형 그대로 보존해야 함 |
| **2. 감사 헌장(`AUDIT_CHARTER`)·심사보고서·판결 원장** | **`Apache-2.0` / `CC BY 4.0` 이중 라이선스**<br>(`CC BY 4.0` 제3조 a항 출처 표시 의무) | • 5대 관문·14대 체크포인트 및 `Case 001`~`015` 포렌식 수치를 논문·프리프린트·언론 보도에 인용할 때 **`Open Proof Forensics Foundation (OPFF)`** 와 공식 DOI를 명시해야 함<br>• 무인용 차용 시 라이선스 침해 및 `COPE` 가이드라인 위반(아이디어 표절·인용 조작)으로 해당 학술지 편집장에게 즉시 철회(`Retraction`) 청구 공문 발송 |
| **3. 재단 명칭 및 공식 등급 배지 (`OPFF TIER S/A/C/F`)** | **`Apache-2.0` 제6조 (Trademarks)** &<br>**`CC BY 4.0` 제2조 b항 1호** | • 코드는 오픈소스로 개방하되, **`Open Proof Forensics Foundation`**, **`OPFF`**, **`오픈 수리·형식증명 포렌식 재단`** 명칭 및 공식 인증 스탬프(**`OPFF TIER S`**, **`OPFF TIER A`**, **`OPFF TIER C`**, **`OPFF TIER F`**)의 상표권과 발급 권한은 재단에 배타적으로 유보됨<br>• OPFF 공식 판결 원장에 등재되지 않은 외부 저장소나 논문이 임의로 `OPFF TIER S` 등의 인증 마크를 참칭하는 행위를 법적으로 금지함 |
