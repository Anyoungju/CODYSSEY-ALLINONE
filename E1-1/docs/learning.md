# 이해하고 풀어가는 순서

1. 현재 위치와 폴더를 읽습니다. 절대 경로는 출발점부터 전체 주소, 상대 경로는 현재 위치 기준 주소입니다. `/tmp/practice`와 `./practice`를 비교합니다.
2. r/w/x는 읽기/쓰기/실행입니다. 숫자는 r=4,w=2,x=1의 합입니다. 755는 소유자 rwx, 그룹/기타 r-x입니다. 644는 소유자 rw-, 그룹/기타 r--입니다. 디렉터리 x는 내부 경로 접근 권한입니다.
3. 이미지는 실행 틀이고 컨테이너는 그 틀로 만든 실행 공간입니다. 주 프로세스가 끝나면 컨테이너도 종료됩니다.
4. `docker exec`는 실행 중인 컨테이너 안에 추가 프로세스를 만듭니다. `docker attach`는 기존 주 프로세스 입출력에 붙습니다. exec 셸 종료는 주 프로세스가 살아 있으면 컨테이너를 끝내지 않습니다. attach에서 Ctrl+C는 주 프로세스에 영향을 줄 수 있습니다. 대화형 detach 키 Ctrl+P, Ctrl+Q는 별도 실습합니다.
5. 호스트 8080을 컨테이너 80에 연결하면 브라우저는 8080으로 들어가고 NGINX는 80에서 받습니다. 호스트 포트 충돌은 컨테이너 내부 포트와 별개입니다.
6. 바인드 마운트는 호스트 폴더를 연결합니다. 볼륨은 Docker가 관리하며 컨테이너를 지워도 볼륨을 지우지 않으면 데이터가 유지됩니다.
7. Git은 로컬 변경 이력, GitHub는 원격 저장과 협업 공간입니다. 실제 실습 단위로 커밋하고 증거를 연결합니다.

첫 학습 범위: 미션 소개와 최종 결과물, 터미널 기본 실습까지. 작은 과제는 빈 파일을 생성하고 복사한 뒤 복사본만 이름을 바꾸는 것입니다. 확인 질문: 현재 위치가 바뀌면 상대 경로의 의미가 왜 달라질까요?

## 볼륨 데이터 보호: 백업·복원 절차 예시

아래 절차는 권장 예시이며 이번 필수 실습에서 실행 완료했다고 주장하지 않습니다. 실행 중인 앱이 있으면 쓰기를 먼저 중지해 일관된 데이터를 확보합니다. 실습 전용 e1-data 볼륨에만 적용합니다.
```bash
mkdir -p backup
docker run --rm -v e1-data:/data:ro -v "$PWD/backup:/backup" ubuntu:24.04 tar -czf /backup/e1-data.tgz -C /data .
docker volume create e1-restored
docker run --rm -v e1-restored:/data -v "$PWD/backup:/backup:ro" ubuntu:24.04 tar -xzf /backup/e1-data.tgz -C /data
```
복원 후 새 볼륨을 테스트 컨테이너에 연결하여 파일 내용과 개수를 비교합니다. 원본 볼륨을 삭제하거나 덮어쓰지 않고 별도 볼륨에 복원합니다. 백업은 작업 PC 외부에도 보관하고 민감정보가 있으면 적절히 보호합니다.
공식 설명: https://docs.docker.com/engine/storage/volumes/#back-up-restore-or-migrate-data-volumes
