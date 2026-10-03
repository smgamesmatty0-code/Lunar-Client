@echo off
cd /d "%~dp0"
call "%~dp0Launch.bat" %*
exit /b %errorlevel%
