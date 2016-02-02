@echo off
call bundle update

REM Use the Anaconda Python 2 environment for Jekyll
call activate py2

REM Start Compass and Jekyll
start bundle exec compass watch
start bundle exec jekyll serve --drafts
