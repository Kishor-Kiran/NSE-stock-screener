@echo off
REM Easy GitHub Push Script for NSE Stock Screener
REM This script will help you push code to GitHub

cls
echo.
echo ========================================
echo NSE Stock Screener - GitHub Push
echo ========================================
echo.
echo Username: Kishor-Kiran
echo Repository: NSE-stock-screener
echo.
echo BEFORE RUNNING THIS:
echo 1. Create personal access token at: https://github.com/settings/tokens
echo 2. Create empty repository at: https://github.com/new
echo 3. Come back and run this script
echo.
pause
echo.

cd D:\Kiran\Thrissur\NSE

REM Configure git
echo Configuring git...
git config --global user.name "Kiran"
git config --global user.email "kingskiran8@gmail.com"

REM Remove old remote if exists
git remote remove origin >nul 2>&1

REM Add remote
echo Adding GitHub remote...
git remote add origin https://github.com/Kishor-Kiran/NSE-stock-screener.git

REM Rename branch
echo Setting up main branch...
git branch -M main

REM Push to GitHub
echo.
echo ========================================
echo ENTER YOUR CREDENTIALS WHEN PROMPTED
echo ========================================
echo.
echo Username: Kishor-Kiran
echo Password: Paste your Personal Access Token
echo.
echo To get a token:
echo 1. Go to https://github.com/settings/tokens
echo 2. Click "Generate new token (classic)"
echo 3. Name: NSE-stock-screener
echo 4. Check "repo" scope
echo 5. Generate and COPY the token
echo.
pause

echo.
echo Pushing to GitHub (this may take 30 seconds)...
echo.

git push -u origin main

if %ERRORLEVEL% equ 0 (
    echo.
    echo ========================================
    echo ✓ SUCCESS! Code pushed to GitHub
    echo ========================================
    echo.
    echo Repository: https://github.com/Kishor-Kiran/NSE-stock-screener
    echo.
    echo Next step: Deploy to Render
    echo 1. Go to https://render.com/
    echo 2. Sign up with GitHub
    echo 3. Create new Web Service
    echo 4. Connect NSE-stock-screener repo
    echo 5. Deploy (5 minutes)
    echo 6. Get live URL!
    echo.
    echo Press any key to close...
    pause
) else (
    echo.
    echo ✗ Push failed
    echo.
    echo Possible reasons:
    echo - Wrong credentials
    echo - Repository doesn't exist (create at https://github.com/new)
    echo - Invalid token
    echo.
    echo Try again or check your GitHub token.
    echo Press any key to close...
    pause
)
