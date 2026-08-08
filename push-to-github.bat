@echo off
REM Push NSE Stock Screener to GitHub
REM GitHub Username: Kishor-Kiran

cd D:\Kiran\Thrissur\NSE

echo.
echo ========================================
echo NSE Stock Screener - Push to GitHub
echo ========================================
echo.
echo Username: Kishor-Kiran
echo Repository: NSE-stock-screener
echo.

REM Add remote if not already added
git remote remove origin >nul 2>&1
git remote add origin https://github.com/Kishor-Kiran/NSE-stock-screener.git

echo Adding remote: https://github.com/Kishor-Kiran/NSE-stock-screener.git
echo.

REM Rename branch to main
git branch -M main
echo ✓ Branch renamed to main
echo.

REM Push to GitHub
echo Pushing code to GitHub...
echo.
git push -u origin main

if %ERRORLEVEL% equ 0 (
    echo.
    echo ========================================
    echo ✓ SUCCESS! Code pushed to GitHub
    echo ========================================
    echo.
    echo Your repository: https://github.com/Kishor-Kiran/NSE-stock-screener
    echo.
    pause
) else (
    echo.
    echo ✗ Push failed. Check your credentials and try again.
    echo.
    pause
)
