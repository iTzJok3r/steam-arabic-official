@echo off
title تثبيت ثيم تعريب ستيم - Steam Arabic Theme Installer
echo ========================================================
echo        Steam Arabic Official Theme Installer
echo             مثبت ثيم تعريب ستيم الرسمي
echo ========================================================
echo.
echo جاري التثبيت عبر PowerShell...
echo Installing theme via PowerShell...
echo.

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0install-theme.ps1"

echo.
echo ========================================================
echo اضغط أي مفتاح للإغلاق...
echo Press any key to exit...
pause >nul
