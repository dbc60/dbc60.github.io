@echo off
dot -Tsvg _doc/disruptor-pattern.dot -o img/disruptor-pattern.svg
REM asciidoctor is actually asciidoctor.bat, and it has a line "GOTO :EOF". Use 'call' here
REM so this batch file can clean up extraneous files and move the important ones
call asciidoctor --require asciidoctor-diagram _doc/disruptor.adoc
del _doc\disruptor.html _doc\disruptor.svg.cache
move /Y _doc\disruptor.svg img >nul
