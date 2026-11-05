# 네이토 사전평가 결과

- 저장소: https://github.com/Anyoungju/CODYSSEY-ALLINONE
- 브랜치: `main`
- 점수: **61% (11/18)**

## 항목별 결과

### #1 — PASS

- 근거: E1-1/scripts/verify.sh > 'touch empty.txt'
- 잘한 점: 터미널 생성/복사/이동/삭제 명령을 스크립트에 포함
- 부족한 점: 로그·스크린샷 원본을 README에 바로 연결하면 더 명확함
- 보완: verification.log 또는 관련 스크린샷을 README에 직접 링크하세요

### #2 — FAIL

- 근거: E1-1/scripts/verify.sh > 'chmod 600 original.txt'
- 잘한 점: 권한 변경 명령을 스크립트로 재현함
- 부족한 점: 실행 출력(ls -l 또는 chmod 출력) 원본 로그 미첨부
- 보완: ls -l 출력이나 verification.log의 해당 줄을 README에 연결하세요

### #3 — FAIL

- 근거: E1-1/scripts/verify.sh > 'docker --version'
- 잘한 점: docker --version과 docker info 호출을 스크립트에 포함함
- 부족한 점: 실제 docker --version·docker info 출력(데몬 상태) 로그 미제출
- 보완: docker --version 및 docker info 출력 캡처를 evidence에 추가하세요

### #4 — FAIL

- 근거: E1-1/scripts/verify.sh > 'docker run --rm hello-world'
- 잘한 점: hello-world 실행 명령을 스크립트에 포함
- 부족한 점: hello-world 실행 출력(컨테이너 로그 스냅샷) 미제출
- 보완: hello-world 실행 출력(터미널 로그 또는 스크린샷)을 첨부하세요

### #5 — FAIL

- 근거: E1-1/scripts/verify.sh > 'docker ps -a'
- 잘한 점: 컨테이너·이미지 목록 조회 명령을 포함함
- 부족한 점: docker ps -a 및 docker images 실제 출력 로그 미제출
- 보완: docker ps -a와 docker images 출력 로그를 evidence에 포함하세요

### #6 — PASS

- 근거: E1-1/scripts/verify.sh > 'docker build -t "$image" . '
- 잘한 점: Dockerfile 존재와 docker build 명령을 자동화 스크립트로 포함
- 부족한 점: 빌드 출력 로그(성공/이미지 해시)를 README에 직접 연결하면 재현성 향상
- 보완: verification.log의 docker build 성공 부분을 README에 링크하세요

### #7 — FAIL

- 근거: E1-1/README.md > 'curl --fail http://127.0.0.1:8080/'
- 잘한 점: 호스트 포트 접속 방법과 curl 예시를 문서화함
- 부족한 점: 브라우저 주소창 포함 캡처 및 curl 실제 응답 스냅샷 미첨부
- 보완: 브라우저 캡처(주소창 포함) 또는 curl 출력 스크린샷을 추가하세요

### #8 — FAIL

- 근거: E1-1/scripts/verify.sh > 'docker exec "$data" cat /data/proof.txt | grep E1-1-persistent'
- 잘한 점: 볼륨 생성·쓰기·삭제·재생성 과정을 스크립트로 재현함
- 부족한 점: 영속성 확인의 실제 출력 로그(verification.log 스니펫) 미첨부
- 보완: verification.log에서 영속성 검사 출력 줄을 README에 링크하세요

### #9 — PASS

- 근거: E1-1/evidence/STATUS.md > '- [Linux Docker 검증 성공](https://github.com/Anyoungju/CODYSSEY-ALLINONE/actions/runs/41403344676)'
- 잘한 점: GitHub Actions 링크로 원격 push·CI 증거를 제시함
- 부족한 점: 직접적인 'git remote -v' 출력 캡처는 없음
- 보완: git remote -v 출력 또는 push 시점의 commit 링크를 README에 명시하세요

### #10 — PASS

- 근거: E1-1/docs/learning.md > '1. 현재 위치와 폴더를 읽습니다. 절대 경로는 출발점부터 전체 주소, 상대 경로는 현재 위치 기준 주소입니다.'
- 잘한 점: 경로·디렉터리 개념을 문서로 정리함
- 부족한 점: 프로젝트 루트의 전체 디렉터리 트리 예시(목록)가 없음
- 보완: 저장소 루트의 디렉터리 트리 예시와 간단 설명을 추가하세요

### #11 — PASS

- 근거: E1-1/README.md > 'docker run -d --name allinone-e1-1 -p 127.0.0.1:8080:80 allinone-e1-1:local'
- 잘한 점: 포트·볼륨 설정 예시와 재현 명령을 제공함
- 부족한 점: 단계별 예상 출력과 체크포인트 스냅샷이 일부 부족
- 보완: step별 예상 출력과 체크포인트(성공/실패 조건)를 README에 추가하세요

### #12 — PASS

- 근거: E1-1/docs/learning.md > '이미지는 실행 틀이고 컨테이너는 그 틀로 만든 실행 공간입니다.'
- 잘한 점: 이미지·컨테이너 차이를 간결히 설명함
- 부족한 점: 런타임 변경과 이미지 재빌드 차이 예시가 없음
- 보완: 이미지 빌드→컨테이너 실행 흐름의 간단 예시를 덧붙이세요

### #13 — FAIL

- 근거: E1-1/README.md > '내부 포트는 NGINX의 80이며 호스트 포트 8080과 다릅니다.'
- 잘한 점: 포트 매핑 개념을 명시함
- 부족한 점: '네트워크 네임스페이스' 관련 용어·설명이 누락됨
- 보완: 네임스페이스와 포워딩 개념을 한두 문장으로 설명 추가하세요

### #14 — PASS

- 근거: E1-1/docs/windows-handoff.md > 'Linux 파일 권한 실습은 /mnt/c 대신 Linux 홈 디렉터리에서 수행합니다.'
- 잘한 점: 호스트 파일시스템과 재현성 고려사항을 명시함
- 부족한 점: 호스트와 컨테이너 경로 선택 기준을 더 명확히 기술하면 좋음
- 보완: 호스트 vs 컨테이너 경로 선택 기준과 반복 재현 팁을 추가하세요

### #15 — PASS

- 근거: E1-1/docs/learning.md > '2. r/w/x는 읽기/쓰기/실행입니다. 숫자는 r=4,w=2,x=1의 합입니다. 755는 소유자 rwx, 그룹/기타 r-x입니다.'
- 잘한 점: 숫자 권한 규칙을 명확히 설명함
- 부족한 점: 실습 예제의 ls -l 전후 예시가 있으면 더 이해하기 쉬움
- 보완: 예시 파일의 chmod 숫자 변경 전후 ls -l 예시를 추가하세요

### #16 — PASS

- 근거: E1-1/docs/troubleshooting.md > '확인: 두 번째 docker run이 실패하는지 검사하고 실제 오류 메시지를 로그에 남깁니다.'
- 잘한 점: 포트 충돌 가설·확인·해결 절차를 제시함
- 부족한 점: 구체적 프로세스 확인 명령(lsof/ss 등) 예시가 없음
- 보완: 포트 점유 프로세스 확인 예시 명령과 해제 절차를 추가하세요

### #17 — PASS

- 근거: E1-1/docs/learning.md > '6. 바인드 마운트는 호스트 폴더를 연결합니다. 볼륨은 Docker가 관리하며 컨테이너를 지워도 볼륨을 지우지 않으면 데이터가 유지됩니다.'
- 잘한 점: 바인드·볼륨 차이와 영속성 대안을 명확히 설명함
- 부족한 점: 볼륨 백업/복원 절차 같은 데이터 보호 구체안은 없음
- 보완: 볼륨 백업·복원 또는 호스트 백업 권장 절차를 간단히 추가하세요

### #18 — PASS

- 근거: E1-1/docs/troubleshooting.md > '- 가설: 파일 내용이 아니라 실행 비트가 없습니다.'
- 잘한 점: 트러블슈팅을 가설→확인→조치 흐름으로 문서화함
- 부족한 점: 각 사례의 실제 로그 스니펫 연결이 일부 부족
- 보완: 각 사례의 실제 CI 로그 스니펫이나 verification.log 링크를 문서에 포함하세요
