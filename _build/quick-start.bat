@echo off
REM Start Compass and Jekyll without updating gems
REM start bundle exec compass watch

REM Wait 5 seconds for compass to start (in case it has to generate files)
REM timeout /T 5 /NOBREAK >nul

REM start bundle exec jekyll s --port 4004
REM Hawkins does not appear to work with the --incremental option
REM start bundle exec jekyll liveserve --incremental --port 4004
REM liveserve will listen on reload-port 35729. That port can be changed
REM with the '--reload-port [PORT]' option.
start bundle exec jekyll liveserve --drafts
