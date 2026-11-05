# 로컬 완료를 위한 관리자 단계

현재 Docker Desktop과 Ubuntu WSL2 설치, Docker 통합, 로컬 실습은 완료했습니다. 아래 설치 절차는 새로운 PC에서 재현할 때만 사용합니다. 기존 설치를 다시 할 필요는 없습니다. 초기 0x80073d28 오류는 해결되었습니다.

1. 관리자 PowerShell에서 `E1-1/scripts/setup-windows.ps1`을 실행합니다. 스크립트는 자동 재부팅하지 않습니다.
2. 재부팅 요구가 있으면 작업을 저장한 후 직접 재부팅합니다. Ubuntu의 최초 사용자 생성과 Docker Desktop 약관/첫 실행은 직접 완료합니다.
3. Docker Desktop의 Ubuntu WSL 통합을 사용하고 Linux 터미널에서 저장소를 clone합니다. Linux 파일 권한 실습은 `/mnt/c` 대신 Linux 홈 디렉터리에서 수행합니다.
4. `bash E1-1/scripts/verify.sh`로 검증합니다.
5. README의 고정 포트 8080 명령으로 서버를 열고 주소창 포함 화면을 캡처합니다.
6. VSCode에서 이 저장소를 열고 GitHub 로그인/소스 제어 및 원격 저장소를 확인합니다. 비밀번호/토큰을 캡처하지 않습니다.
7. 증거를 README에 연결하고 평가자의 비공개 저장소 접근권한을 확인한 후 제출합니다.

현재 확인된 로컬 검증과 남은 제출 증거는 ../evidence/STATUS.md에서 확인합니다.
