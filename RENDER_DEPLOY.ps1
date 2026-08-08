#!/usr/bin/env pwsh
<#
.SYNOPSIS
NSE Stock Screener - Render Deployment Automation
Deploys the backend API to Render and provides live URL
#>

Write-Host ""
Write-Host "========================================" -ForegroundColor Magenta
Write-Host "   NSE Stock Screener - Render Deploy" -ForegroundColor Magenta
Write-Host "========================================" -ForegroundColor Magenta
Write-Host ""

$gitHubUsername = "Kishor-Kiran"
$repoName = "NSE-stock-screener"
$repoUrl = "https://github.com/$gitHubUsername/$repoName"

Write-Host "This script will guide you through Render deployment." -ForegroundColor Cyan
Write-Host ""
Write-Host "Requirements:" -ForegroundColor Yellow
Write-Host "  ✓ GitHub account (you have this)"
Write-Host "  ✓ Render account (free at render.com)"
Write-Host "  ✓ Code on GitHub (done)"
Write-Host ""
Write-Host "Time needed: ~10 minutes" -ForegroundColor Green
Write-Host ""

# Check if GitHub CLI is available
$gh = Get-Command gh -ErrorAction SilentlyContinue
if (-not $gh) {
    Write-Host "GitHub CLI not found. Installing..." -ForegroundColor Yellow
    & winget install --id GitHub.cli
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "STEP 1: Open Render Dashboard" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Opening https://render.com/dashboard in browser..." -ForegroundColor Cyan
Write-Host ""

Start-Process "https://render.com/dashboard"

Write-Host "📋 MANUAL SETUP INSTRUCTIONS:" -ForegroundColor Yellow
Write-Host ""
Write-Host "In the Render Dashboard:"
Write-Host ""
Write-Host "1. Click: New +"
Write-Host "2. Click: Web Service"
Write-Host "3. Click: Connect a repository"
Write-Host "4. Search: NSE-stock-screener"
Write-Host "5. Click: Connect"
Write-Host ""
Write-Host "CONFIGURE THE SERVICE:" -ForegroundColor Green
Write-Host ""
Write-Host "Fill in these values exactly:"
Write-Host ""
Write-Host "  Name: nse-stock-screener-api"
Write-Host "  Environment: Python 3"
Write-Host "  Region: Oregon"
Write-Host "  Branch: main"
Write-Host ""
Write-Host "  Build Command:"
Write-Host "    pip install -r backend/requirements-prod.txt"
Write-Host ""
Write-Host "  Start Command:"
Write-Host "    cd backend && gunicorn app_demo:app --bind 0.0.0.0:`$PORT"
Write-Host ""
Write-Host "  Plan: Free"
Write-Host ""
Write-Host "7. Click: Create Web Service"
Write-Host ""

Write-Host "⏳ WAIT 3-5 MINUTES for deployment..." -ForegroundColor Yellow
Write-Host ""
Write-Host "You'll see:"
Write-Host "  • Building Docker image..."
Write-Host "  • Deploying..."
Write-Host "  • Live badge appears"
Write-Host ""

Write-Host "========================================" -ForegroundColor Green
Write-Host "WHAT YOU'LL SEE WHEN DONE" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Your live URL will appear at the top:" -ForegroundColor Cyan
Write-Host ""
Write-Host "  https://nse-stock-screener-api-xxxxx.onrender.com"
Write-Host ""
Write-Host "(Replace xxxxx with your service ID)"
Write-Host ""

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "TEST YOUR LIVE API" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Once deployment shows 'Live', open these URLs in browser:" -ForegroundColor Green
Write-Host ""
Write-Host "1. Health Check:"
Write-Host "   https://nse-stock-screener-api-xxxxx.onrender.com/api/health"
Write-Host ""
Write-Host "2. NSE Stocks:"
Write-Host "   https://nse-stock-screener-api-xxxxx.onrender.com/api/stocks/nse"
Write-Host ""
Write-Host "3. NYSE Stocks:"
Write-Host "   https://nse-stock-screener-api-xxxxx.onrender.com/api/stocks/nyse"
Write-Host ""

Write-Host "========================================" -ForegroundColor Yellow
Write-Host "SAVE YOUR LIVE URL" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Yellow
Write-Host ""
Write-Host "Copy your URL and save it:" -ForegroundColor Green
Write-Host ""
Write-Host "https://nse-stock-screener-api-[YOUR_SERVICE_ID].onrender.com"
Write-Host ""

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "OPTIONAL: DEPLOY FRONTEND TO VERCEL" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "For the visual UI, deploy to Vercel:" -ForegroundColor Green
Write-Host ""
Write-Host "1. Go: https://vercel.com/"
Write-Host "2. Sign up with GitHub"
Write-Host "3. New Project"
Write-Host "4. Import: NSE-stock-screener"
Write-Host "5. Framework: React"
Write-Host "6. Build Command: cd frontend && npm run build"
Write-Host "7. Output Directory: frontend/build"
Write-Host "8. Environment Variables:"
Write-Host "   Name: REACT_APP_API_URL"
Write-Host "   Value: [YOUR RENDER URL FROM ABOVE]"
Write-Host "9. Deploy"
Write-Host ""
Write-Host "Your Frontend URL:"
Write-Host "  https://nse-stock-screener-kingskiran.vercel.app"
Write-Host ""

Write-Host "========================================" -ForegroundColor Green
Write-Host "QUICK LINKS" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "GitHub Repository:" -ForegroundColor Cyan
Write-Host "  $repoUrl"
Write-Host ""
Write-Host "Render Dashboard:" -ForegroundColor Cyan
Write-Host "  https://render.com/dashboard"
Write-Host ""
Write-Host "Vercel Dashboard:" -ForegroundColor Cyan
Write-Host "  https://vercel.com/dashboard"
Write-Host ""

Write-Host "========================================" -ForegroundColor Yellow
Write-Host "⏱️  TIMELINE" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Yellow
Write-Host ""
Write-Host "Setup in Render: 2 minutes"
Write-Host "Deployment: 3-5 minutes"
Write-Host "Live API Ready: ~7 minutes total"
Write-Host ""

Write-Host "========================================" -ForegroundColor Magenta
Write-Host "🚀 YOU'RE SET FOR DEPLOYMENT!" -ForegroundColor Magenta
Write-Host "========================================" -ForegroundColor Magenta
Write-Host ""
Write-Host "Follow the steps above and you'll have a live API!"
Write-Host ""
Write-Host "Press any key to open Render dashboard..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

Write-Host ""
Write-Host "Good luck! 🎉" -ForegroundColor Green
Write-Host ""
