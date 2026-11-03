# 요구사항과 증거 대응표

| 필수 항목 | 구현/검증 | 증거 또는 남은 일 |
|---|---|---|
| 현재 경로·숨김 목록·이동·생성·복사·이름변경·삭제·내용확인·빈 파일 | verify.sh terminal 블록 | 실제 verification.log |
| 파일과 디렉터리 각각 권한 전후 | 600→644, 700→755 | ls -ld 출력 |
| Docker 버전·데몬 | docker --version, info | CI 로그. 로컬 실행 별도 |
| 이미지·실행·중지·목록·로그·자원 | images/run/stop/start/ps/logs/stats | CI 로그 |
| hello-world, Ubuntu 내부 ls/echo | run 및 exec | CI 로그 |
| attach/exec·종료/유지 관찰 | attach 도움말, sleep infinity, exec 후 Running 검사, stop 후 false | attach_demo.py의 실제 PTY 접속/분리/상태 검증 로그. 로컬 체험 별도 |
| 직접 작성한 Dockerfile | NGINX + COPY + HEALTHCHECK | Dockerfile, 실제 build 로그 |
| 포트 연결 | 두 컨테이너 각각 호스트 포트 자동 배정 → 내부 80 | docker port/curl, 주소창 캡처 추가 필요 |
| 바인드 마운트 전후 | 원본 페이지 → bind mount updated | curl 출력 비교 |
| 볼륨 영속성 | proof.txt 생성 → 컨테이너 삭제 → 재생성 → 동일 내용 | CI 로그 |
| Git 사용자/기본 브랜치/버전관리 | 격리된 로컬 config와 main 커밋 | CI 로그, 사용자 PC 설정 별도 |
| GitHub 저장소 | 실제 원격 저장소 생성 및 push | 저장소 커밋·Actions |
| VSCode GitHub 연동 | 자동으로 충족하지 않음 | 사용자 로그인/연동 화면 필요 |
| 문제 해결 2건 | 실행 권한 거부와 포트 중복 실험 | 실제 CI 출력 + troubleshooting.md |
| 보안 | .env 제외, 사용자 글로벌 설정 미출력 | .gitignore, 게시 전 검사 |

40시간 필수 개인 미션. Compose·멀티 컨테이너·환경변수·SSH는 선택이며 이 구현의 필수 완료 조건으로 섞지 않습니다.
