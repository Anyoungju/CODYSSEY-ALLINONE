# E1-1 — 내 컴퓨터에 개발자용 작업실 꾸미기

## 목표와 완료 범위
터미널·리눅스 권한·Docker·Git을 사용해 재현 가능한 웹 실행 환경을 구성합니다.
이 저장소는 직접 작성한 Dockerfile, 웹페이지, 검증 스크립트 및 실제 실행 증거를 제공합니다.
**GitHub Actions Linux 검증과 학습자의 로컬 PC 구축은 구분합니다.** 로컬 PC에는 Docker/WSL이 없어 로컬 구축 완료로 주장하지 않습니다.

## 요구사항 분석
[요구사항과 증거 대응표](docs/requirements.md), [개념 및 풀이 순서](docs/learning.md), [문제 해결](docs/troubleshooting.md), [검증 현황](evidence/STATUS.md).
원문은 대전 올인원 입학 연수 E1-1 화면에서 2026-11-02 확인했습니다. 제출은 GitHub 링크이며 모든 근거는 이 문서에서 접근 가능해야 합니다.

## 실행 환경
- 실제 검증 환경: GitHub Actions ubuntu-latest, bash, Docker Engine. 정확한 OS/도구 버전은 실행 로그 참조.
- 사용자 PC: Windows, Docker 명령 없음, WSL 배포판 미설치. Linux CLI/권한 실습은 준비된 Linux 환경에서 수행합니다.
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
- [ ] 로컬 PC에서 Docker 실행 및 버전 증거
- [ ] 주소창과 포트가 함께 보이는 실제 브라우저 캡처
- [ ] 사용자 VSCode GitHub 로그인·원격 저장소 연동 화면

## 증거 확인
GitHub Actions의 **E1-1 Linux Docker verification** 실행과 `e1-1-evidence` 아티팩트에서 전체 로그를 확인합니다. 다운로드하여 이 폴더에 보존한 로그가 있으면 [verification.log](evidence/verification.log)를 확인합니다. 실행되지 않은 결과를 성공으로 기록하지 않습니다.

[정적 페이지 미리보기](evidence/static-preview.png)는 Chrome에서 HTML 파일을 렌더링한 화면이며 Docker 접속 캡처와 구분합니다.

## 제출 전 확인
README 링크만으로 소스, Dockerfile, 명령과 출력, 문제 해결, 마운트 전후, 볼륨 재생성 전후를 확인할 수 있어야 합니다. 비밀번호·토큰·`.env`·개인키는 업로드하지 않습니다. 과정 평가 요청은 별도이며 이 저장소 생성으로 제출 완료를 의미하지 않습니다.

## 쉽게 배우기
[설명 PPT 18장](learning/E1-1_개발자작업실_아주쉬운설명.pptx)을 순서대로 읽습니다. 처음에는 1~6장까지만 보고 터미널의 위치·경로·권한 개념을 익힌 뒤 17장의 작은 실습을 진행하세요. 상세 설명과 공식 출처는 각 슬라이드의 발표자 노트에 있습니다.

[Windows 관리자 설치와 남은 증거 안내](docs/windows-handoff.md). 현재 관리자 권한 부족으로 로컬 설치가 막혀 있으며, 평가 요청은 아직 하지 않았습니다.
