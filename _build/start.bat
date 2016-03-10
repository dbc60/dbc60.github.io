@echo off
call bundle update

REM Start Compass and Jekyll
start bundle exec compass watch

REM Give compass a few seconds to start before launching jekyll
@ping 192.0.2.2 -n 1 -w 5000 > nul

start bundle exec jekyll serve --drafts
