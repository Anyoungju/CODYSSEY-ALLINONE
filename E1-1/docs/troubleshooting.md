# 재현 가능한 문제 해결 실험

아래는 실습 스크립트가 의도적으로 발생시키는 오류입니다. 우연히 발생한 장애로 꾸미지 않습니다. 실제 발생 여부와 출력은 CI 로그로 확인합니다.

## 1. 실행 권한 없는 셸 파일
- 문제: 644 권한의 `execute.sh`를 직접 실행하면 실패해야 합니다.
- 가설: 파일 내용이 아니라 실행 비트가 없습니다.
- 확인: chmod 644 후 직접 실행하고 0이 아닌 종료 코드를 검사합니다.
- 해결: chmod 755 후 실행하여 `permission-fixed` 출력을 확인합니다.

## 2. 호스트 포트 충돌
- 문제: 웹 컨테이너가 사용 중인 동일 호스트 포트로 두 번째 컨테이너 실행을 시도합니다.
- 가설: 하나의 호스트 IP/포트를 동시에 중복 사용할 수 없습니다.
- 확인: 두 번째 docker run이 실패하는지 검사하고 실제 오류 메시지를 로그에 남깁니다.
- 해결: 다음 컨테이너는 Docker가 배정하는 별도 호스트 포트로 실행하고 curl 응답을 확인합니다.

## 로컬 환경 제약 (관측됨)
2026-11-02 사용자 Windows PC에서 docker 명령을 찾지 못했고 wsl --list는 WSL 미설치 안내를 반환했습니다. 이에 Linux CI에서 검증하도록 구성했습니다. 이 대안은 로컬 구축 증거를 대신하지 않으므로 Docker/WSL 준비 후 로컬 재검증이 남습니다.

## 3. 실제 첫 CI 실패: 웹 서버 준비 전 접속
- 관측: 최초 Actions 실행 41403155225에서 바인드 마운트 컨테이너 생성 직후 curl이 `Recv failure: Connection reset by peer`(56)로 실패했습니다.
- 원인 가설: 컨테이너 생성 성공은 NGINX의 HTTP 준비 완료를 보장하지 않습니다.
- 확인: 같은 실행에서 앞선 일반 웹 컨테이너는 응답했고, 새 컨테이너는 생성 직후 즉시 접속했습니다.
- 수정: 연결 거부뿐 아니라 초기 연결 재설정도 제한된 횟수로 재시도하도록 `--retry-all-errors`를 추가했습니다. 재실행 결과는 검증 현황 문서에서 확인합니다.

## 4. 로컬 Docker Desktop 포트 실험 대기
- 문제: Linux CI와 달리 동일 호스트 포트 요청을 Docker Desktop이 받아들이면서 foreground docker run이 계속 실행되었습니다.
- 확인: 실제 컨테이너와 요청 PortBindings를 조사하고 실험 컨테이너만 중지했습니다. 첫 로컬 실패 로그를 보존했습니다.
- 해결: 충돌 실험을 -d 및 고유 이름으로 실행해 즉시 반환시키고 성공/실패를 모두 기록한 뒤 해당 컨테이너를 정리합니다. 요청 수락을 충돌 거절 성공으로 기록하지 않습니다.
- 재검증: 수정 후 로컬 로그에서 PORT_CONFLICT_PLATFORM_VARIATION 및 최종 VERIFICATION_PASS를 확인했습니다.

## 포트 점유 확인과 안전한 해제 절차

아래는 진단용 실행 예시이며 실제 실행 출력으로 제시한 것은 아닙니다.
```bash
ss -ltnp 'sport = :8080'
docker ps --filter publish=8080
```
먼저 점유 주체를 확인한 후 본인이 만든 실습 컨테이너만 `docker stop <실습컨테이너명>`으로 중지합니다. 다른 작업의 프로세스를 강제 종료하지 않습니다. 기존 컨테이너를 유지해야 하면 호스트 포트를 8081 등으로 바꿉니다. Docker Desktop에서는 호스트 포트 프록시와 WSL 네임스페이스가 달라 ss 출력만으로 단정하지 말고 Docker 포트 설정도 함께 확인합니다.

## 각 사례 실제 로그 위치

- 권한 거부 → 실행 비트 추가: [실제 로컬 로그 Markdown](../evidence/VERIFIED_LOCAL_RESULTS.md)의 chmod 644, Permission denied, chmod 755, permission-fixed 부분.
- Linux CI 포트 충돌: [CI 원본](../evidence/verification.log)의 port is already allocated 부분.
- Docker Desktop 차이와 무한 대기 수정: [로컬 Markdown](../evidence/VERIFIED_LOCAL_RESULTS.md)의 PORT_CONFLICT_PLATFORM_VARIATION 및 NetworkSettings.Ports 부분.
- 서버 초기 준비 오류: [첫 CI 실행](https://github.com/Anyoungju/CODYSSEY-ALLINONE/actions/runs/41403155225), 수정 후 실행은 README에 연결되어 있습니다.
