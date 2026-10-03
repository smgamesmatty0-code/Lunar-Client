@echo off
setlocal enabledelayedexpansion
title Minecraft - Change Offline Username
cd /d "%~dp0"

echo ============================================================
echo   Change Offline Username
echo ============================================================
echo.

set "CURRENT_USER=DarkOreSmayan"
if exist "%~dp0username.txt" (
    set /p CURRENT_USER=<"%~dp0username.txt"
)

echo Current Username: %CURRENT_USER%
echo.
set /p "NEW_USER=Enter new Minecraft username: "
if "%NEW_USER%"=="" (
    echo [!] No username entered. Keeping: %CURRENT_USER%
    timeout /t 3 >nul
    exit /b 0
)

set "NAME=%NEW_USER: =%"
echo %NAME%>"%~dp0username.txt"

powershell -NoProfile -Command ^
  "$name = '%NAME%'.Trim();" ^
  "$bytes = [System.Text.Encoding]::UTF8.GetBytes('OfflinePlayer:' + $name);" ^
  "$md5 = [System.Security.Cryptography.MD5]::Create().ComputeHash($bytes);" ^
  "$md5[6] = ($md5[6] -band 0x0f) -bor 0x30;" ^
  "$md5[8] = ($md5[8] -band 0x3f) -bor 0x80;" ^
  "$uuidHex = -join ($md5 | ForEach-Object { '{0:x2}' -f $_ });" ^
  "$obj = @{ accounts = @{ ('offline_' + $name) = @{ accessToken = '0'; accessTokenExpiresAt = '2099-01-01T00:00:00.000Z'; localId = ('offline_' + $name); refreshToken = 'offline_token'; minecraftProfile = @{ id = $uuidHex; name = $name }; remoteId = '0'; type = 'Xbox'; username = $name; eligibleForMigration = $false; hasMultipleProfiles = $false; legacy = $false; persistent = $true; userProperties = @() } }; activeAccountLocalId = ('offline_' + $name) };" ^
  "$json = $obj | ConvertTo-Json -Depth 5;" ^
  "$target = Join-Path '%~dp0' 'settings\game\accounts.json';" ^
  "$dir = Split-Path $target; if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null };" ^
  "[System.IO.File]::WriteAllText($target, $json, [System.Text.Encoding]::UTF8);" ^
  "Write-Host '[+] Successfully set username to: ' $name ' (UUID: ' $uuidHex ')' -ForegroundColor Green;"

echo.
echo [*] Next time you launch Minecraft, you will play as %NAME%.
echo.
timeout /t 3 >nul
exit /b 0
