# 네이토 1차 평가 후속 검토

2026-11-05 1차: 61% (11/18). 코드 실행 절차와 실제 실행 증거를 구분하고, PASS 11개를 포함한 모든 권고를 검토했습니다.

| 항목 | 1차 | 권고 | 보완 위치 |
|---|---|---|---|
| 1 | PASS | verification.log 또는 관련 스크린샷을 README에 직접 링크하세요 | README 실제 실행 증거 / evidence/VERIFIED_LOCAL_RESULTS.md |
| 2 | FAIL | ls -l 출력이나 verification.log의 해당 줄을 README에 연결하세요 | README 실제 실행 증거 / evidence/VERIFIED_LOCAL_RESULTS.md |
| 3 | FAIL | docker --version 및 docker info 출력 캡처를 evidence에 추가하세요 | README 실제 실행 증거 / evidence/VERIFIED_LOCAL_RESULTS.md |
| 4 | FAIL | hello-world 실행 출력(터미널 로그 또는 스크린샷)을 첨부하세요 | README 실제 실행 증거 / evidence/VERIFIED_LOCAL_RESULTS.md |
| 5 | FAIL | docker ps -a와 docker images 출력 로그를 evidence에 포함하세요 | README 실제 실행 증거 / evidence/VERIFIED_LOCAL_RESULTS.md |
| 6 | PASS | verification.log의 docker build 성공 부분을 README에 링크하세요 | README 실제 실행 증거 / evidence/VERIFIED_LOCAL_RESULTS.md |
| 7 | FAIL | 브라우저 캡처(주소창 포함) 또는 curl 출력 스크린샷을 추가하세요 | README 실제 실행 증거 / evidence/VERIFIED_LOCAL_RESULTS.md |
| 8 | FAIL | verification.log에서 영속성 검사 출력 줄을 README에 링크하세요 | README 실제 실행 증거 / evidence/VERIFIED_LOCAL_RESULTS.md |
| 9 | PASS | git remote -v 출력 또는 push 시점의 commit 링크를 README에 명시하세요 | README 실제 실행 증거 / evidence/VERIFIED_LOCAL_RESULTS.md |
| 10 | PASS | 저장소 루트의 디렉터리 트리 예시와 간단 설명을 추가하세요 | 저장소 루트 README 디렉터리 트리 |
| 11 | PASS | step별 예상 출력과 체크포인트(성공/실패 조건)를 README에 추가하세요 | README 단계별 성공 체크포인트 |
| 12 | PASS | 이미지 빌드→컨테이너 실행 흐름의 간단 예시를 덧붙이세요 | README 이미지 재빌드와 실행 중 수정 |
| 13 | FAIL | 네임스페이스와 포워딩 개념을 한두 문장으로 설명 추가하세요 | README 네트워크 네임스페이스와 포워딩 |
| 14 | PASS | 호스트 vs 컨테이너 경로 선택 기준과 반복 재현 팁을 추가하세요 | README 경로 선택과 반복 재현 |
| 15 | PASS | 예시 파일의 chmod 숫자 변경 전후 ls -l 예시를 추가하세요 | README 실제 실행 증거 / evidence/VERIFIED_LOCAL_RESULTS.md |
| 16 | PASS | 포트 점유 프로세스 확인 예시 명령과 해제 절차를 추가하세요 | docs/troubleshooting.md 실제 로그 및 포트 진단 |
| 17 | PASS | 볼륨 백업·복원 또는 호스트 백업 권장 절차를 간단히 추가하세요 | docs/learning.md 백업·복원 예시 (미실행 표시) |
| 18 | PASS | 각 사례의 실제 CI 로그 스니펫이나 verification.log 링크를 문서에 포함하세요 | docs/troubleshooting.md 실제 로그 및 포트 진단 |

주소창 캡처 미수집은 그대로 남겨두었습니다. curl 실제 출력은 추가했으며 네이토 재평가 결과와 실제 동료평가 완료를 혼동하지 않습니다. 동료평가는 사용자가 진행합니다.
