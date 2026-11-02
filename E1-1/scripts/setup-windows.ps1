# Run this script as Administrator. It never restarts Windows automatically.
$ErrorActionPreference = 'Stop'
$identity = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = New-Object Security.Principal.WindowsPrincipal($identity)
if (-not $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    throw 'Administrator PowerShell is required. Reopen PowerShell as Administrator.'
}
winget install --id Microsoft.WSL --exact --source winget --silent
if ($LASTEXITCODE -notin @(0, 3010)) { throw 'WSL installation failed. Read the installer output.' }
wsl --install -d Ubuntu --no-launch
Write-Host 'If Windows requests a restart, save your files and restart manually.'
winget install --id Docker.DockerDesktop --exact --source winget --silent
Write-Host 'Open Docker Desktop yourself, review its terms, and finish Ubuntu user setup.'
Write-Host 'Then run bash E1-1/scripts/verify.sh in the Linux terminal.'
