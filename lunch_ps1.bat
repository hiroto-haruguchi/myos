@echo off
powershell -NoProfile -ExecutionPolicy Unrestricted .\checkfile.ps1
taskkill /im cmd.exe
pause > nul
exit