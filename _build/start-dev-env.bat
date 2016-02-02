@echo off
call bundle update

REM Start Compass and Jekyll
start bundle exec compass watch
start bundle exec jekyll serve --drafts
