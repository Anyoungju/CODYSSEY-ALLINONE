# CODYSSEY ALL-IN-ONE · 대전 올인원 과제

터미널·Docker·Git 실습의 소스 코드, 실행 방법, 실제 검증 증거와 학습 자료를 모은 저장소입니다.

## E1-1 · 내 컴퓨터에 개발자용 작업실 꾸미기

직접 만든 한국어 웹페이지를 NGINX 컨테이너로 실행하고, 파일 권한·포트 연결·바인드 마운트·볼륨 데이터 유지·Git 이력을 실습했습니다.

**[E1-1 과제 README 열기 →](E1-1/README.md)**

| 확인할 내용 | 바로가기 |
|---|---|
| 준비부터 실행·종료까지 | [빠른 실행](E1-1/README.md#빠른-실행) |
| 과제 요구사항별 구현·증거 | [요구사항과 증거](E1-1/README.md#요구사항과-증거) |
| 실제 명령과 출력 | [핵심 실행 기록](E1-1/docs/EXECUTION_EVIDENCE.md), [전체 로컬 기록](E1-1/evidence/VERIFIED_LOCAL_RESULTS.md) |
| Dockerfile·웹페이지 | [Dockerfile](E1-1/Dockerfile), [index.html](E1-1/site/index.html) |
| 쉬운 학습 자료 | [설명 PPT 18장](E1-1/learning/E1-1_개발자작업실_아주쉬운설명.pptx) |
| 네이토 의견별 보완 | [18개 항목 검토표](E1-1/docs/POST_EVALUATION_REVIEW.md) |

## 현재 상태

- Windows Docker Desktop·Ubuntu WSL2 로컬 실습과 Linux CI 검증을 통과한 기록을 제공합니다.
- 네이토 1차 결과는 **61% (11/18)**입니다. 이후 보완은 GitHub main의 `476c33b`까지 반영했습니다. 재평가 점수는 아직 없습니다.
- 주소창·포트가 함께 보이는 Docker 서버 접속 캡처는 미수집입니다. 동료평가는 사용자가 진행합니다.
- 자세한 실행 날짜와 완료 범위는 [검증 현황](E1-1/evidence/STATUS.md)에 기록합니다.

## 저장소 구조

```text
CODYSSEY-ALLINONE/
├── E1-1/                  # 과제 소스·실행 증거·평가·학습 PPT
├── automation/            # 계정별 로그인 자동화 코드와 안내
└── .github/workflows/     # Docker 검증과 로그인 테스트
```

[자동 로그인 사용 안내](automation/README.md). 계정 비밀번호·GitHub 토큰·개인 `.env`는 저장소에 포함하지 않습니다.
