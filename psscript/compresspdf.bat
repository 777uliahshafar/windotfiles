@echo off
setlocal
set GS_OUTPUT_DIR=compressed
mkdir %GS_OUTPUT_DIR%
for %%i in (*.pdf) do ps2pdf -dCompatibilityLevel#1.3 -dPDFSETTINGS#/ebook "%%i" "%GS_OUTPUT_DIR%\%%i"
