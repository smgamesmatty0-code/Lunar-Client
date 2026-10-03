@echo off
setlocal enabledelayedexpansion
title Minecraft 1.21.11 (Fabric) - Ultra Potato Direct Launcher
cd /d "%~dp0"

set "DIR=%~dp0"
if "%DIR:~-1%"=="\" set "DIR=%DIR:~0,-1%"

set "JAVA_EXE=%DIR%\jre\bin\java.exe"
if not exist "%JAVA_EXE%" set "JAVA_EXE=%DIR%\jre\bin\javaw.exe"

if not exist "%JAVA_EXE%" (
    echo [ERROR] Embedded Java not found at "%JAVA_EXE%"
    pause
    exit /b 1
)

:: -------------------------------------------------------------
:: 1. Read Offline Username & Compute Standard Offline UUID
:: -------------------------------------------------------------
set "USERNAME=DarkOreSmayan"
if exist "%DIR%\username.txt" (
    set /p USERNAME=<"%DIR%\username.txt"
) else (
    echo %USERNAME%>"%DIR%\username.txt"
)
set "USERNAME=%USERNAME: =%"

for /f "delims=" %%U in ('powershell -NoProfile -Command "$bytes=[System.Text.Encoding]::UTF8.GetBytes('OfflinePlayer:%USERNAME%'); $md5=[System.Security.Cryptography.MD5]::Create().ComputeHash($bytes); $md5[6]=($md5[6] -band 0x0f) -bor 0x30; $md5[8]=($md5[8] -band 0x3f) -bor 0x80; -join ($md5 | ForEach-Object { '{0:x2}' -f $_ })"') do set "UUID=%%U"

if exist "%DIR%\settings\sync-account.ps1" (
    powershell -NoProfile -ExecutionPolicy Bypass -File "%DIR%\settings\sync-account.ps1" "%USERNAME%" "%UUID%" >nul 2>&1
)

:: -------------------------------------------------------------
:: 2. Paths & Directories (100% Local)
:: -------------------------------------------------------------
set "GAME_DIR=%DIR%\profile"
set "MV_DIR=%DIR%\offline\multiver"
set "ASSETS_DIR=%DIR%\shared\assets"
set "TEXTURES_DIR=%DIR%\textures"
set "UI_DIR=%DIR%\ui\3ef46b89af39eaf41f4f5b7f3cbf1671c271d717"

if not exist "%GAME_DIR%\logs" mkdir "%GAME_DIR%\logs" >nul 2>&1

set "CP=%MV_DIR%\common-0.1.0-SNAPSHOT-all-nomappings.jar;%MV_DIR%\lunar-platform-mappings-v1_21_11.jar;%MV_DIR%\lunar-fabric-mixins-0.1.0-SNAPSHOT-all.jar;%MV_DIR%\lunar-entitytexturefeatures-mixins-0.1.0-SNAPSHOT-all.jar;%MV_DIR%\lunar-flashback-mixins-0.1.0-SNAPSHOT-all.jar;%MV_DIR%\lunar-modmenu-mixins-0.1.0-SNAPSHOT-all.jar;%MV_DIR%\lunar-replaymod-fabric-mixins-0.1.0-SNAPSHOT-all.jar;%MV_DIR%\lunar-skyhanni-mixins-0.1.0-SNAPSHOT-all.jar;%MV_DIR%\lunar-sodium-mixins-0.1.0-SNAPSHOT-all.jar;%MV_DIR%\genesis-0.1.0-SNAPSHOT-all.jar;%MV_DIR%\lunar-lang.jar;%MV_DIR%\lunar.jar;%MV_DIR%\modern-0.1.0-SNAPSHOT-all-nomappings.jar"

set "ICHOR_CP=common-0.1.0-SNAPSHOT-all-nomappings.jar,lunar-platform-mappings-v1_21_11.jar,lunar-fabric-mixins-0.1.0-SNAPSHOT-all.jar,lunar-entitytexturefeatures-mixins-0.1.0-SNAPSHOT-all.jar,lunar-flashback-mixins-0.1.0-SNAPSHOT-all.jar,lunar-modmenu-mixins-0.1.0-SNAPSHOT-all.jar,lunar-replaymod-fabric-mixins-0.1.0-SNAPSHOT-all.jar,lunar-skyhanni-mixins-0.1.0-SNAPSHOT-all.jar,lunar-sodium-mixins-0.1.0-SNAPSHOT-all.jar,genesis-0.1.0-SNAPSHOT-all.jar,lunar-lang.jar,lunar.jar,modern-0.1.0-SNAPSHOT-all-nomappings.jar"

set "ICHOR_FILES=kill-sound-chat-patterns.json,vanilla_capes.json,waypoint-patterns.json,user-message-patterns.json,tier-tagger.json,hypixel/teamview.json,hypixel/quickplay.json,hypixel/bedwars.json,hypixel/skyblock/max-levels.json,hypixel/skyblock/important-items.json,hypixel/skyblock/deployable-textures.json,hypixel/skyblock/metal-detector-locations.json,hypixel/skyblock/glacite-tunnels.json,hypixel/skyblock/tab-widgets.json,hypixel/skyblock/hoppity-eggs.json,hypixel/skyblock/item-shop-prices.json,hypixel/skyblock/kuudra-waypoints.json,hypixel/skyblock/commands.json,hypixel/skyblock/splits.json,hypixel/skyblock/chocolate-factory-prices.json,hypixel/skyblock/stacking-enchants.json,hypixel/skyblock/garden.json,hypixel/skyblock/sphinx-key.json,hypixel/skyblock/vendor-items.json,hypixel/skyblock/autocomplete-warps.json,hypixel/skyblock/minions.json,hypixel/skyblock/enchants.json,hypixel/skyblock/important-npc-locations.json,hypixel/skyblock/api-materials-override.json,hypixel/skyblock/adblock-websites.json,hypixel/skyblock/skill-xp.json,hypixel/skyblock/api-items-override.json,hypixel/skyblock/item-abilities.json,hypixel/skyblock/middle-click.json,hypixel/skyblock/modern-islands.json,hypixel/skyblock/mineshaft-corpse-waypoints.json,hypixel/skyblock/skyblock-vanilla-items.json,hypixel/skyblock/fairy-souls.json,hypixel/skyblock/dungeon/quiz-key.json,hypixel/skyblock/dungeon/rooms.json,hypixel/skyblock/dungeon/routes.json,hypixel/skyblock/dungeon/trash-items.json,hypixel/skyblock/dungeon/waterboard-solutions.json,hypixel/skyblock/fishing/sea-creatures.json,hypixel/skyblock/fishing/trophy-fish-fillet.json,hypixel/skyblock/fishing/baits.json,hypixel/skyblock/fishing/trophy-frog-fillet.json"

:: -------------------------------------------------------------
:: GPU Driver Multi-threading & Dedicated GPU Balancing
:: -------------------------------------------------------------
set "SHIM_MCCOMPAT=0x800000001"
set "__GL_THREADED_OPTIMIZATIONS=1"
set "mesa_glthread=true"
set "DRI_PRIME=1"

echo ============================================================
echo   Minecraft 1.21.11 (Fabric) Ultra Potato Launcher
echo   Mode: Standalone Offline (Server Compatible)
echo   Player: %USERNAME% (UUID: %UUID%)
echo   RAM  : 1536 MB (Ultra Potato Optimized Heap)
echo   HUD  : Press RIGHT SHIFT in-game to adjust mods
echo   Perf : CPU/GPU Balanced Multi-Threading Active
echo ============================================================
echo.
echo Launching...

cd /d "%GAME_DIR%"

"%JAVA_EXE%" ^
  --add-modules jdk.naming.dns ^
  --add-exports jdk.naming.dns/com.sun.jndi.dns=java.naming ^
  -Dlog4j2.formatMsgNoLookups=true ^
  --add-opens java.base/java.io=ALL-UNNAMED ^
  -XX:+UnlockExperimentalVMOptions ^
  -XX:+UseG1GC ^
  -XX:MaxGCPauseMillis=20 ^
  -XX:+UseStringDeduplication ^
  -XX:InitiatingHeapOccupancyPercent=45 ^
  -XX:G1ReservePercent=15 ^
  -XX:+ParallelRefProcEnabled ^
  -XX:+PerfDisableSharedMem ^
  -Dorg.lwjgl.opengl.Display.allowSoftwareOpenGL=false ^
  -Dsun.java2d.opengl=false ^
  -Xms256m ^
  -Xmx1536m ^
  "-Dlunar.webosr.url=file:index.html" ^
  "-Dlunar.dataDir=%DIR%" ^
  "-Dichor.fabric.localModPath=%GAME_DIR%\mods" ^
  "-Djava.library.path=%MV_DIR%\natives" ^
  "-Dlog4j.configurationFile=%GAME_DIR%\logs\config.xml" ^
  "-Dichor.logsFile=%GAME_DIR%\logs\ichor-boot.log" ^
  -Dichor.usingIsolatedProfiles=true ^
  -XX:-CreateCoredumpOnCrash ^
  -XX:-CreateMinidumpOnCrash ^
  -cp "%CP%" ^
  com.moonsworth.lunar.genesis.Genesis ^
  --version 1.21.11 ^
  --launcherVersion 3.7.21-ow ^
  --installationId f1a49a1b-d0c2-434d-847c-e87ac4647841 ^
  --overwolfMuid 65db43a1-d3ba-448c-ab5d-860b1bfaae96 ^
  --sentryTraceId b97a57a1b59ce5a2faf8f0fb876e07f6 ^
  --launchId a3be73cc-5df6-45a5-b911-150100a86115 ^
  --canaryToken no-canary ^
  --username "%USERNAME%" ^
  --uuid "%UUID%" ^
  --xuid 0 ^
  --accessToken 0 ^
  --userType legacy ^
  --userProperties "{}" ^
  --assetIndex 29 ^
  --gameDir "%GAME_DIR%" ^
  --assetsDir "%ASSETS_DIR%" ^
  --texturesDir "%TEXTURES_DIR%" ^
  --uiDir "%UI_DIR%" ^
  --webosrDir "%MV_DIR%\natives" ^
  --workingDirectory . ^
  --classpathDir "%MV_DIR%" ^
  --width 1024 ^
  --height 600 ^
  --ichorClassPath "%ICHOR_CP%" ^
  --ichorExternalFiles "%ICHOR_FILES%"

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo [ERROR] Game closed with exit code %ERRORLEVEL%.
    pause
)
