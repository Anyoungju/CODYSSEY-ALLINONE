# 검증 상태 (2026-11-02)

## 실제 통과한 검증
- [Linux Docker 검증 성공](https://github.com/Anyoungju/CODYSSEY-ALLINONE/actions/runs/41403344676)
- 검증 대상 소스 커밋: `2976332`.
- 환경: Linux 7.0.0-1017-azure x86_64, bash 5.2.21, Git 2.56.0, Docker 28.0.4.
- [원본 명령·출력 로그](verification.log) 마지막에 `VERIFICATION_PASS` 확인.
- 파일/폴더 권한 변경, hello-world, Ubuntu exec/stop/start, Dockerfile 빌드, 두 호스트 포트 HTTP 응답, 바인드 마운트 변경, 컨테이너 삭제·재생성 후 데이터 유지, Git 설정·커밋을 실제 수행했습니다.
- 의도한 실행 권한 거부와 포트 충돌도 실제 발생한 로그가 있습니다. 예기치 않은 HTTP 초기 접속 오류는 수정 후 재검증했습니다.
- HEALTHCHECK 정의는 포함되었으나 수집 시 health 상태는 `starting`이었습니다. healthy 전환까지 검증했다고 주장하지 않습니다.
- [로그인 테스트 CI 성공](https://github.com/Anyoungju/CODYSSEY-ALLINONE/actions/runs/41403344651): 7개 테스트, Python 컴파일, Bash 구문 검사.
- 로컬 원본 프로젝트 테스트 15개 통과. 올인원 실제 자동 로그인 및 다음 실행 세션 재사용 확인.

## 남은 로컬 학습·증거
- Windows 로컬 Docker/WSL 구축 및 동일 절차 실행: 미완료.
- 주소창과 포트가 함께 보이는 Docker 서버 브라우저 화면: 미수집. CI curl 성공과 구분합니다.
- 사용자 VSCode GitHub 로그인·연동 화면: 미수집.
- attach 대화형 분리 키 조작: 설명 및 도움말만 제공, 실제 대화형 체험 필요.
- 코디세이 평가 요청/최종 제출: 수행하지 않음.

## 정적 페이지 시각 검수
[Chrome 렌더링 미리보기](static-preview.png)는 실제 HTML 파일을 열어 확인한 화면입니다. Docker 접속 증거가 아닙니다.
