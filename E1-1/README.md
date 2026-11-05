# E1-1 — 내 컴퓨터에 개발자용 작업실 꾸미기

## 목표와 완료 범위
터미널·리눅스 권한·Docker·Git을 사용해 재현 가능한 웹 실행 환경을 구성합니다.
이 저장소는 직접 작성한 Dockerfile, 웹페이지, 검증 스크립트 및 실제 실행 증거를 제공합니다.
Windows의 Docker Desktop과 Ubuntu WSL2에서 로컬 전체 검증을 통과했습니다. GitHub Actions의 Linux 검증 로그도 함께 제공합니다.

## 요구사항 분석
[요구사항과 증거 대응표](docs/requirements.md), [개념 및 풀이 순서](docs/learning.md), [문제 해결](docs/troubleshooting.md), [검증 현황](evidence/STATUS.md).
원문은 대전 올인원 입학 연수 E1-1 화면에서 2026-11-02 확인했습니다. 제출은 GitHub 링크이며 모든 근거는 이 문서에서 접근 가능해야 합니다.

## 실행 환경
- 실제 검증 환경: GitHub Actions ubuntu-latest, bash, Docker Engine. 정확한 OS/도구 버전은 실행 로그 참조.
- 사용자 PC 실측: Windows + Ubuntu WSL2, bash 5.3.9, Docker 29.9.2, Git 2.53.0. Linux 파일시스템에서 권한 실습을 실행했습니다.
- 외부 Python 패키지 없이 NGINX 기반 이미지와 Bash/Docker CLI를 사용합니다.
- 베이스 이미지: `nginx:stable-alpine`. 직접 만든 HTML과 HTTP healthcheck를 추가했습니다. 태그는 갱신되므로 재현 당시 이미지 digest는 빌드 로그를 확인합니다.

## 실행 방법
Docker 사용 가능한 Linux bash에서 저장소를 clone한 뒤:
```bash
cd E1-1
docker build -t allinone-e1-1:local .
docker run -d --name allinone-e1-1 -p 127.0.0.1:8080:80 allinone-e1-1:local
curl --fail http://127.0.0.1:8080/
```
브라우저에서 `http://localhost:8080/`을 열어 확인합니다. 내부 포트는 NGINX의 80이며 호스트 포트 8080과 다릅니다.
컨테이너를 종료하려면 `docker stop allinone-e1-1`, 실습 컨테이너를 정리하려면 `docker rm allinone-e1-1`을 실행합니다.

## 전체 검증
```bash
bash E1-1/scripts/verify.sh
```
작업 디렉터리와 컨테이너/볼륨은 실행별 이름으로 분리합니다. 스크립트 종료 시 해당 실행이 생성한 컨테이너와 볼륨만 정리합니다. 임시 실습 폴더는 검토를 위해 남깁니다. 실패 시 0이 아닌 종료 코드를 반환하며 실제 명령과 출력은 `E1-1/evidence/verification.log`에 저장됩니다.

## 수행 체크리스트
- [x] 실제 CI 결과와 로그: [검증 현황](evidence/STATUS.md)
- [x] 로컬 PC에서 Docker 실행 및 버전 증거: [실제 로컬 로그](evidence/verification-local-fixed-2026-11-03.log)
- [ ] 주소창과 포트가 함께 보이는 실제 브라우저 캡처
- [x] 사용자 VSCode GitHub 로그인 및 소스 제어 활성화: [계정](evidence/vscode-github-account.png), [원격 연결](evidence/vscode-source-control-linked.png)

## 증거 확인
[실제 명령과 출력 — Markdown](evidence/VERIFIED_LOCAL_RESULTS.md)에서 실행 결과를 바로 읽을 수 있습니다. 네이토가 이미지·PPT를 읽지 않는 경우에도 텍스트 증거를 확인할 수 있도록 원본 로그와 연결했습니다.

GitHub Actions의 **E1-1 Linux Docker verification** 실행과 `e1-1-evidence` 아티팩트에서 전체 로그를 확인합니다. 다운로드하여 이 폴더에 보존한 로그가 있으면 [verification.log](evidence/verification.log)를 확인합니다. 실행되지 않은 결과를 성공으로 기록하지 않습니다.

[정적 페이지 미리보기](evidence/static-preview.png)는 Chrome에서 HTML 파일을 렌더링한 화면이며 Docker 접속 캡처와 구분합니다.

## 제출 전 확인
README 링크만으로 소스, Dockerfile, 명령과 출력, 문제 해결, 마운트 전후, 볼륨 재생성 전후를 확인할 수 있어야 합니다. 비밀번호·토큰·`.env`·개인키는 업로드하지 않습니다. 과정 평가 요청은 별도이며 이 저장소 생성으로 제출 완료를 의미하지 않습니다.

## 쉽게 배우기
[설명 PPT 18장](learning/E1-1_개발자작업실_아주쉬운설명.pptx)을 순서대로 읽습니다. 처음에는 1~6장까지만 보고 터미널의 위치·경로·권한 개념을 익힌 뒤 17장의 작은 실습을 진행하세요. 상세 설명과 공식 출처는 각 슬라이드의 발표자 노트에 있습니다.

[Windows 관리자 설치와 남은 증거 안내](docs/windows-handoff.md). Docker Desktop과 Ubuntu 설치 및 WSL 통합을 완료했고 로컬 검증이 통과했습니다. VSCode 소스 제어도 활성화했습니다. 주소창 포함 접속 캡처와 평가 요청은 아직 남아 있습니다.

## 로컬 최종 점검 (2026-11-03)
- Ubuntu WSL2 / bash 5.3.9 / Git 2.53.0 / Docker 29.9.2에서 전체 실습 통과.
- [VSCode GitHub 계정 화면](evidence/vscode-github-account.png): Anyoungju 계정 로그인 확인. 계정 화면은 이전 제한 모드 시점의 기록이며, [최신 소스 제어 화면](evidence/vscode-source-control-linked.png)에서 제한 모드 해제 및 main/origin 연결을 확인했습니다.
- 로컬 Docker Desktop에서는 동일 포트 요청을 거절하지 않는 동작을 관찰했습니다. 충돌 실험을 detached 실행으로 바꾸고 생성 컨테이너를 즉시 정리해 무한 대기를 수정했습니다. CI의 Linux 포트 충돌 증거와 구분합니다.

## 실제 실행 증거 — 네이토 1차 피드백 보완

2026-11-03 실제 로컬 실행 원본에서 발췌했습니다. `+ 줄번호: 명령` 아래에 실제 출력이 이어집니다. 나머지 출력은 [원본 Markdown](evidence/VERIFIED_LOCAL_RESULTS.md)에서 확인합니다.

### 터미널 및 파일·폴더 권한 변경 전후

```text
+ 29: pwd
/tmp/tmp.E9E1Swdudn
+ 30: mkdir practice
+ 31: ls -la
total 0
drwx------  3 root root  60 Nov  3 16:16 .
drwxrwxrwt 11 root root 220 Nov  3 16:16 ..
drwxr-xr-x  2 root root  40 Nov  3 16:16 practice
+ 32: cd practice
+ 33: touch empty.txt
+ 34: printf 'terminal practice\n'
+ 35: cat original.txt
terminal practice
+ 36: cp original.txt copied.txt
+ 37: mv copied.txt renamed.txt
+ 38: rm renamed.txt
+ 39: mkdir permissions
+ 40: chmod 600 original.txt
+ 41: chmod 700 permissions
+ 42: ls -ld original.txt permissions
-rw------- 1 root root 18 Nov  3 16:16 original.txt
drwx------ 2 root root 40 Nov  3 16:16 permissions
+ 43: chmod 644 original.txt
+ 44: chmod 755 permissions
+ 45: ls -ld original.txt permissions
-rw-r--r-- 1 root root 18 Nov  3 16:16 original.txt
drwxr-xr-x 2 root root 40 Nov  3 16:16 permissions
```

### Docker 버전과 데몬

```text
+ 13: docker --version
Docker version 29.9.2, build a82e528
+ 14: docker info
Client:
 Version:    29.9.2
 Context:    default
 Debug Mode: false
 Plugins:
  agent: Docker AI Agent Runner (Docker Inc.)
    Version:  v1.152.0
    Path:     /usr/local/lib/docker/cli-plugins/docker-agent
  ai: Docker AI Agent - Ask Gordon (Docker Inc.)
    Version:  v1.33.0
    Path:     /usr/local/lib/docker/cli-plugins/docker-ai
  buildx: Docker Buildx (Docker Inc.)
    Version:  v0.38.1
    Path:     /usr/local/lib/docker/cli-plugins/docker-buildx
  compose: Docker Compose (Docker Inc.)
    Version:  v5.6.1
    Path:     /usr/local/lib/docker/cli-plugins/docker-compose
  debug: Get a shell into any image or container (Docker Inc.)
    Version:  0.49.0
    Path:     /usr/local/lib/docker/cli-plugins/docker-debug
  desktop: Docker Desktop commands (Docker Inc.)
    Version:  4.97.0
    Path:     /usr/local/lib/docker/cli-plugins/docker-desktop
  dhi: CLI for managing Docker Hardened Images (Docker Inc.)
    Version:  v0.0.9
    Path:     /usr/local/lib/docker/cli-plugins/docker-dhi
  extension: Manages Docker extensions (Docker Inc.)
    Version:  v0.2.32
    Path:     /usr/local/lib/docker/cli-plugins/docker-extension
  init: Creates Docker-related starter files for your project (Docker Inc.)
    Version:  v1.4.1
    Path:     /usr/local/lib/docker/cli-plugins/docker-init
  mcp: Docker MCP Plugin (Docker Inc.)
    Version:  v0.44.2
    Path:     /usr/local/lib/docker/cli-plugins/docker-mcp
  model: Docker Model Runner (Docker Inc.)
    Version:  v1.2.9
    Path:     /usr/local/lib/docker/cli-plugins/docker-model
  offload: Docker Offload (Docker Inc.)
    Version:  v0.7.21
    Path:     /usr/local/lib/docker/cli-plugins/docker-offload
  pass: Docker Pass Secrets Manager Plugin (beta) (Docker Inc.)
    Version:  v0.3.2
    Path:     /usr/local/lib/docker/cli-plugins/docker-pass
  sandbox: "docker sandbox" is deprecated, use Docker Sandboxes instead (Docker Inc.)
    Version:  v0.13.0
    Path:     /usr/local/lib/docker/cli-plugins/docker-sandbox
  scout: Docker Scout (Docker Inc.)
    Version:  v1.27.0
    Path:     /usr/local/lib/docker/cli-plugins/docker-scout

Server:
 Containers: 0
  Running: 0
  Paused: 0
  Stopped: 0
 Images: 3
 Server Version: 29.9.2
 Storage Driver: overlayfs
  driver-type: io.containerd.snapshotter.v1
 Logging Driver: local
 Cgroup Driver: cgroupfs
 Cgroup Version: 2
 Plugins:
  Volume: local
  Network: bridge host ipvlan macvlan null overlay
  Log: awslogs fluentd gcplogs gelf journald json-file local splunk syslog
 CDI spec directories:
  /etc/cdi
  /var/run/cdi
 Discovered Devices:
  cdi: docker.com/gpu=webgpu
 Swarm: inactive
 Runtimes: io.containerd.runc.v2 nvidia runc
 Default Runtime: runc
 Init Binary: docker-init
 containerd version: b7a25261e029d68978bbf290df0a62fc819b3c51
 runc version: v1.5.2-0-g29dd3dc2
 init version: de40ad0
 Security Options:
  seccomp
   Profile: builtin
  cgroupns
 Kernel Version: 6.18.54.1-microsoft-standard-WSL2
 Operating System: Docker Desktop
 OSType: linux
 Architecture: x86_64
 CPUs: 16
 Total Memory: 7.568GiB
 Name: docker-desktop
 ID: 7d205717-1fe1-4e66-b983-999840656e9e
 Docker Root Dir: /var/lib/docker
 Debug Mode: false
 HTTP Proxy: http.docker.internal:3128
 HTTPS Proxy: http.docker.internal:3128
 No Proxy: hubproxy.docker.internal
 Labels:
  com.docker.desktop.address=unix:///var/run/docker-cli.sock
 Experimental: false
 Insecure Registries:
  hubproxy.docker.internal:5555
  127.0.0.0/8
  ::1/128
 Live Restore Enabled: false
 Firewall Backend: iptables

```

### hello-world 실제 실행

```text
+ 53: docker run --rm hello-world

Hello from Docker!
This message shows that your installation appears to be working correctly.

```

### 이미지 빌드 성공과 목록

```text
+ 63: docker build -t e11-1494:local .
#0 building with "default" instance using docker driver

#1 [internal] load build definition from Dockerfile
#1 transferring dockerfile: 279B done
#1 DONE 0.0s

#2 [internal] load metadata for docker.io/library/nginx:stable-alpine
#2 DONE 1.3s

#3 [internal] load .dockerignore
#3 transferring context: 74B done
#3 DONE 0.0s

#4 [internal] load build context
#4 transferring context: 953B done
#4 DONE 0.0s

#5 [1/2] FROM docker.io/library/nginx:stable-alpine@sha256:0e52bd054126cdc040b1276c0af347aeb02a41b9cfe305d6094767ac30e97949
#5 resolve docker.io/library/nginx:stable-alpine@sha256:0e52bd054126cdc040b1276c0af347aeb02a41b9cfe305d6094767ac30e97949 0.0s done
#5 DONE 0.0s

#6 [2/2] COPY site/ /usr/share/nginx/html/
#6 CACHED

#7 exporting to image
#7 exporting layers done
#7 exporting manifest sha256:8a9fcab3b657326a5e94581733cc8b352da66fe030a4ea570f8266216e7f8d09 done
#7 exporting config sha256:9c2870ce1169db078943e0aba8b86fed632126ccab0aa19c0702119157986d10
#7 exporting config sha256:9c2870ce1169db078943e0aba8b86fed632126ccab0aa19c0702119157986d10 done
#7 exporting attestation manifest sha256:f608f17b874da7140a21abaf5c93b0586b8fc6a80e498a81f60ca14e7dcb1916 0.0s done
#7 exporting manifest list sha256:7cb7ef0dd12efd676589a0b7d30d8cee4371c01e38653906477a37e752f13ebd 0.0s done
#7 naming to docker.io/library/e11-1494:local done
#7 unpacking to docker.io/library/e11-1494:local 0.0s done
#7 DONE 0.1s
+ 64: docker images e11-1494:local
IMAGE            ID             DISK USAGE   CONTENT SIZE   EXTRA
e11-1494:local   7cb7ef0dd12e       92.7MB         26.1MB        
```

### 포트 매핑과 실제 curl 응답

```text
+ 65: docker run -d -p 127.0.0.1::80 --name e11-1494-web e11-1494:local
0576735d902a4f05ef03864bc79624535165a5a87f8ba692093f3bece66ac61e
++ 66: docker port e11-1494-web 80/tcp
++ 66: awk -F: '{print $NF}'
+ 66: port=55363
++ 67: seq 1 30
+ 67: for attempt in $(seq 1 30)
+ 68: curl --fail -s http://127.0.0.1:55363/
+ 68: break
+ 71: grep E1-1 /tmp/tmp.E9E1Swdudn/response.html
<title>E1-1 개발자 작업실</title><style>body{font-family:system-ui;max-width:760px;margin:10vh auto;padding:24px;background:#102137;color:#eef7ff}article{padding:32px;border:1px solid #6ecfc0;border-radius:20px}h1{color:#6ecfc0}li{margin:14px 0}</style>
<article><p>CODYSSEY · ALL-IN-ONE · E1-1</p><h1>나의 첫 개발자 작업실</h1><p>터미널에서 만들고, Docker로 실행하고, Git으로 기록합니다.</p><ul><li>이미지: 실행에 필요한 파일을 담은 틀</li><li>컨테이너: 이미지로 실행한 독립된 작업 공간</li><li>포트: 브라우저가 서버에 접속하는 통로</li><li>볼륨: 컨테이너와 별도로 유지하는 데이터 공간</li></ul><p id="version">실습 버전 1</p></article></html>
+ 72: cat /tmp/tmp.E9E1Swdudn/response.html
<!doctype html>
<html lang="ko"><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<title>E1-1 개발자 작업실</title><style>body{font-family:system-ui;max-width:760px;margin:10vh auto;padding:24px;background:#102137;color:#eef7ff}article{padding:32px;border:1px solid #6ecfc0;border-radius:20px}h1{color:#6ecfc0}li{margin:14px 0}</style>
<article><p>CODYSSEY · ALL-IN-ONE · E1-1</p><h1>나의 첫 개발자 작업실</h1><p>터미널에서 만들고, Docker로 실행하고, Git으로 기록합니다.</p><ul><li>이미지: 실행에 필요한 파일을 담은 틀</li><li>컨테이너: 이미지로 실행한 독립된 작업 공간</li><li>포트: 브라우저가 서버에 접속하는 통로</li><li>볼륨: 컨테이너와 별도로 유지하는 데이터 공간</li></ul><p id="version">실습 버전 1</p></article></html>
```

### 바인드 마운트 반영과 볼륨 재생성 전후

```text
+ 81: cp -r site /tmp/tmp.E9E1Swdudn/site
+ 82: docker run -d -p 127.0.0.1::80 --name e11-1494-bind --mount type=bind,src=/tmp/tmp.E9E1Swdudn/site,dst=/usr/share/nginx/html,readonly e11-1494:local
c7e5954a9d406e4195816f9abdd6d5620409a759ff41bd54756f5781086e667d
++ 83: docker port e11-1494-bind 80/tcp
++ 83: awk -F: '{print $NF}'
+ 83: bind_port=59431
+ 84: curl --fail --retry 10 --retry-all-errors --retry-connrefused --retry-delay 1 http://127.0.0.1:59431/
  % Total    % Received % Xferd  Average Speed  Time    Time    Time   Current
                                 Dload  Upload  Total   Spent   Left   Speed

  0      0   0      0   0      0      0      0                              0
100    881 100    881   0      0 191.3k      0                              0
100    881 100    881   0      0 186.9k      0                              0
100    881 100    881   0      0 185.1k      0                              0
<!doctype html>
<html lang="ko"><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<title>E1-1 개발자 작업실</title><style>body{font-family:system-ui;max-width:760px;margin:10vh auto;padding:24px;background:#102137;color:#eef7ff}article{padding:32px;border:1px solid #6ecfc0;border-radius:20px}h1{color:#6ecfc0}li{margin:14px 0}</style>
<article><p>CODYSSEY · ALL-IN-ONE · E1-1</p><h1>나의 첫 개발자 작업실</h1><p>터미널에서 만들고, Docker로 실행하고, Git으로 기록합니다.</p><ul><li>이미지: 실행에 필요한 파일을 담은 틀</li><li>컨테이너: 이미지로 실행한 독립된 작업 공간</li><li>포트: 브라우저가 서버에 접속하는 통로</li><li>볼륨: 컨테이너와 별도로 유지하는 데이터 공간</li></ul><p id="version">실습 버전 1</p></article></html>
+ 85: printf '<h1>E1-1 bind mount updated</h1>\n'
+ 86: curl --fail http://127.0.0.1:59431/
+ 86: grep 'bind mount updated'
  % Total    % Received % Xferd  Average Speed  Time    Time    Time   Current
                                 Dload  Upload  Total   Spent   Left   Speed

  0      0   0      0   0      0      0      0                              0
100     33 100     33   0      0   8564      0                              0
100     33 100     33   0      0   8204      0                              0
100     33 100     33   0      0   8102      0                              0
<h1>E1-1 bind mount updated</h1>
+ 87: docker volume create e11-1494-data
e11-1494-data
+ 88: docker run -d --name e11-1494-data --mount type=volume,src=e11-1494-data,dst=/data ubuntu:24.04 sleep infinity
167ff72ab25ab41c63f9f541ace1c803b1c6e893c4d81ccded1c1a567f9d12b8
+ 89: docker exec e11-1494-data sh -c 'echo E1-1-persistent > /data/proof.txt; cat /data/proof.txt'
E1-1-persistent
+ 90: docker rm -f e11-1494-data
e11-1494-data
+ 91: docker run -d --name e11-1494-data --mount type=volume,src=e11-1494-data,dst=/data ubuntu:24.04 sleep infinity
d929b9031f8a28145d2595af9f0da85d0c7a49923d34d318264e2f3ed0ed3a4c
+ 92: grep E1-1-persistent
+ 92: docker exec e11-1494-data cat /data/proof.txt
E1-1-persistent
```

### 컨테이너 목록

```text
+ 93: docker ps -a
CONTAINER ID   IMAGE            COMMAND                  CREATED          STATUS                            PORTS                     NAMES
d929b9031f8a   ubuntu:24.04     "sleep infinity"         1 second ago     Up Less than a second                                       e11-1494-data
c7e5954a9d40   e11-1494:local   "/docker-entrypoint.…"   4 seconds ago    Up 3 seconds (health: starting)   127.0.0.1:59431->80/tcp   e11-1494-bind
0576735d902a   e11-1494:local   "/docker-entrypoint.…"   10 seconds ago   Up 9 seconds (healthy)            127.0.0.1:55363->80/tcp   e11-1494-web
bf8e76123af6   ubuntu:24.04     "sleep infinity"         24 seconds ago   Up 20 seconds                                               e11-1494-ubuntu
```

### Git 설정·기본 브랜치·커밋

```text
+ 104: git -C /tmp/tmp.E9E1Swdudn init -b main
Initialized empty Git repository in /tmp/tmp.E9E1Swdudn/.git/
+ 105: git -C /tmp/tmp.E9E1Swdudn config user.name 'E1-1 CI Learner'
+ 106: git -C /tmp/tmp.E9E1Swdudn config user.email learner@example.invalid
+ 107: git -C /tmp/tmp.E9E1Swdudn config init.defaultBranch main
+ 108: git -C /tmp/tmp.E9E1Swdudn config --local --list
core.repositoryformatversion=0
core.filemode=true
core.bare=false
core.logallrefupdates=true
user.name=E1-1 CI Learner
user.email=learner@example.invalid
init.defaultbranch=main
+ 109: git -C /tmp/tmp.E9E1Swdudn add practice
+ 110: git -C /tmp/tmp.E9E1Swdudn commit -m 'Practice terminal and permissions'
[main (root-commit) 3bc2929] Practice terminal and permissions
 3 files changed, 3 insertions(+)
 create mode 100644 practice/empty.txt
 create mode 100755 practice/execute.sh
 create mode 100644 practice/original.txt
+ 111: git -C /tmp/tmp.E9E1Swdudn log -1 --oneline
3bc2929 Practice terminal and permissions
```

## 네트워크 네임스페이스와 포워딩

컨테이너는 기본적으로 별도 네트워크 네임스페이스를 사용하여 인터페이스·IP·포트 자원을 호스트와 구분합니다. 포트 매핑은 호스트 포트로 들어온 트래픽을 컨테이너의 서비스 포트로 포워딩합니다. `127.0.0.1:8080:80`의 호스트 8080과 NGINX 내부 80은 서로 다른 공간의 포트입니다.
공식 설명: https://docs.docker.com/engine/network/

## 이미지 재빌드와 실행 중 수정

COPY는 빌드 당시 파일을 이미지에 포함합니다. 호스트 site/를 수정해도 기존 이미지가 자동 갱신되지는 않습니다. 다시 빌드하고 새 컨테이너로 실행해야 합니다. 바인드 마운트에서는 컨테이너가 호스트 폴더를 읽으므로 호스트 수정이 즉시 반영됩니다. 컨테이너 내부만 수정한 것은 새 컨테이너의 원본 이미지에 반영되지 않습니다.

## 경로 선택과 반복 재현

호스트 경로는 내 파일이 존재하는 위치이며 --mount의 src에 넣습니다. 컨테이너 경로는 프로세스가 읽는 위치이며 NGINX는 /usr/share/nginx/html입니다. 권한 실습은 WSL의 Linux 홈이나 /tmp에서 수행하여 /mnt/c 권한과 섞지 않습니다. verify.sh는 실행별 임시 폴더·컨테이너명·볼륨명을 사용합니다.

## 단계별 성공 체크포인트

| 단계 | 실제 성공 기준 | 실패 점검 |
|---|---|---|
| 데몬 | docker info Server 출력 | Desktop 엔진, WSL 통합 |
| 권한 | 파일 600→644, 폴더 700→755 | Linux 파일시스템 여부 |
| 빌드 | exporting/naming 완료 | Dockerfile, COPY 경로 |
| HTTP | curl --fail 종료 코드 0, E1-1 페이지 반환 | 포트·서버 준비 |
| 바인드 | bind mount updated 출력 | 호스트 경로 |
| 볼륨 | 재생성 후 E1-1-persistent 출력 | 같은 볼륨 연결 |
| 전체 | VERIFICATION_PASS | 단계별 로그 |

주소창 포함 브라우저 캡처는 아직 미수집입니다. HTTP 응답 로그를 주소창 이미지로 주장하지 않습니다.

## 실제 GitHub 원격 연결

2026-11-05 `git remote -v` 출력:

```text
origin	https://github.com/Anyoungju/CODYSSEY-ALLINONE.git (fetch)
origin	https://github.com/Anyoungju/CODYSSEY-ALLINONE.git (push)
```

1차 평가 소스: [72b3700](https://github.com/Anyoungju/CODYSSEY-ALLINONE/commit/72b3700).
