# CODYSSEY ALL-IN-ONE


| 미션 | 결과물 | 상태 |
|---|---|---|
| E1-1 | [개발자 작업실 구축](E1-1/README.md) | 로컬·CI 검증 완료, 네이토 1차 61% 피드백 로컬 보완·재평가 대기 |

[자동 로그인 빠른 실행](automation/README.md) — 비밀번호는 저장소에 포함하지 않습니다.

## 저장소 구조
```text
CODYSSEY-ALLINONE/
  E1-1/
    README.md                  # 실제 명령·출력과 재현 절차
    Dockerfile                 # NGINX 기반 직접 작성 이미지
    site/index.html            # 웹 서버 콘텐츠
    scripts/verify.sh           # Linux·로컬 실습 자동 검증
    scripts/attach_demo.py      # 실제 PTY 접속·분리 검증
    evidence/                  # 원본 로그와 Markdown 증거
    evaluation/                # 네이토 원본 및 구조화 결과
    docs/                      # 요구사항·개념·문제 해결·후속 검토
    learning/                  # 쉬운 설명 PPT
  automation/                  # 비밀정보 없는 로그인 코드
  .github/workflows/          # Docker·로그인 CI
```

[E1-1 실제 실행 명령과 출력](E1-1/README.md#실제-실행-증거--네이토-1차-피드백-보완), [전체 Markdown 증거](E1-1/evidence/VERIFIED_LOCAL_RESULTS.md), [18개 권고 추적](E1-1/docs/POST_EVALUATION_REVIEW.md).
