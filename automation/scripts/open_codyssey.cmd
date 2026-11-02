@echo off
setlocal

set "CODYSSEY_LAUNCHER=%~dp0open_chrome_cdp.py"

if defined CODYSSEY_PYTHON if exist "%CODYSSEY_PYTHON%" (
    "%CODYSSEY_PYTHON%" "%CODYSSEY_LAUNCHER%"
    exit /b %ERRORLEVEL%
)

if not defined USERPROFILE set "USERPROFILE=%HOMEDRIVE%%HOMEPATH%"
set "CODYSSEY_BUNDLED_PYTHON=%USERPROFILE%\.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe"
if exist "%CODYSSEY_BUNDLED_PYTHON%" (
    "%CODYSSEY_BUNDLED_PYTHON%" "%CODYSSEY_LAUNCHER%"
    exit /b %ERRORLEVEL%
)

where python >nul 2>nul
if errorlevel 1 (
    echo A working Python executable was not found for the Codyssey launcher. 1>&2
    exit /b 1
)

python "%CODYSSEY_LAUNCHER%"
exit /b %ERRORLEVEL%
