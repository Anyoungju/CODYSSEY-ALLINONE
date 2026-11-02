# 코디세이 자동 로그인 빠른 실행

Windows에서 `open_codyssey.cmd`를 실행합니다. Python 표준 라이브러리만 사용합니다.
Chrome CDP는 CHROME_CDP_PORT(기본 9222), 127.0.0.1에만 바인딩합니다. 브라우저 프로필을 재사용합니다.

프로젝트 `.env`는 `automation/.env`에 직접 작성합니다. 브라우저 저장 비밀번호를 추출하지 않습니다.
```dotenv
CODYSSEY_ACCOUNT=allinone
CODYSSEY_AUTO_LOGIN=true
CHROME_CDP_PORT=9222
CHROME_CDP_START_URL=https://ams.codyssey.kr/daejeon/loginForm
CODYSSEY_ALLINONE_EMAIL=
CODYSSEY_ALLINONE_PASSWORD=
CODYSSEY_NATIVE_EMAIL=
CODYSSEY_NATIVE_PASSWORD=
```
기본은 allinone입니다. 네이티브는 CODYSSEY_ACCOUNT=native로 선택합니다.
로그인 성공 후 계정 식별용 SHA-256 표식을 해당 탭 sessionStorage에 남깁니다. 이는 인증 증명이 아니라 이 도구가 어떤 계정으로 로그인했는지 구분하는 표식입니다. 표식이 없는 기존 세션은 메인에서 로그아웃 후 선택한 계정으로 다시 로그인합니다. 사람이 수동으로 계정을 변경한 경우 이 도구의 재로그인으로 확인하세요.
비밀번호·아이디·.env·실제 Chrome 프로필은 Git에 포함하지 않습니다. CAPTCHA/추가 인증이 발생하면 자동 우회를 하지 않습니다.

작업 공간 원본 실행기: scripts/open_codyssey.cmd. 여기에는 배포 가능한 코드 사본만 보존합니다.
