@echo off
REM Update all the gems and then start Compass and Jekyll
call bundle update
SET PROJECT_PATH=%~dp0
call %PROJECT_PATH%quick-start.bat
