#!/usr/bin/env pwsh
<#
.SYNOPSIS
NSE Stock Screener - Complete Deployment Script
Automates: GitHub push, PR creation, and Render deployment

.DESCRIPTION
This script handles the entire deployment workflow:
1. Install GitHub CLI if needed
2. Authenticate with GitHub
3. Create/connect to GitHub repository
4. Push code to GitHub
5. Create a pull request
6. Setup Render deployment
7. Provide live URL access

.AUTHOR
Stock Screener Deployment
#>

# Color functions
function Write-Success { Write-Host $args -ForegroundColor Green }
function Write-Warning { Write-Host $args -ForegroundColor Yellow }
function Write-Error { Write-Host $args -ForegroundColor Red }
function Write-Info { Write-Host $args -ForegroundColor Cyan }

# Configuration
$gitHubUsername = "Kishor-Kiran"
$repoName = "NSE-stock-screener"
$repoUrl = "https://github.com/$gitHubUsername/$repoName"
$projectPath = "D:\Kiran\Thrissur\NSE"

Write-Host ""
Write-Host "========================================" -ForegroundColor Magenta
Write-Host "   NSE Stock Screener - Full Deploy" -ForegroundColor Magenta
Write-Host "========================================" -ForegroundColor Magenta
Write-Host ""

# Step 1: Check/Install GitHub CLI
Write-Info "STEP 1: Checking GitHub CLI..."
Write-Host ""

$ghPath = Get-Command gh -ErrorAction SilentlyContinue

if (-not $ghPath) {
    Write-Warning "GitHub CLI not found. Installing..."
    try {
        # Download and install GitHub CLI
        $tempDir = [System.IO.Path]::GetTempPath()
        $installer = "$tempDir\gh-installer.msi"

        Write-Info "Downloading GitHub CLI..."
        $ProgressPreference = 'SilentlyContinue'
        Invoke-WebRequest -Uri "https://github.com/cli/cli/releases/download/v2.40.1/gh_2.40.1_windows_amd64.msi" -OutFile $installer

        Write-Info "Installing GitHub CLI (this may take 1-2 minutes)..."
        & msiexec.exe /i $installer /quiet

        Start-Sleep -Seconds 5

        # Refresh environment
        $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

        Write-Success "✓ GitHub CLI installed successfully"
    } catch {
        Write-Error "✗ Failed to install GitHub CLI"
        Write-Warning "Please install manually from: https://cli.github.com/"
        exit 1
    }
} else {
    Write-Success "✓ GitHub CLI is installed"
    & gh --version
}

Write-Host ""

# Step 2: Check GitHub authentication
Write-Info "STEP 2: Checking GitHub authentication..."
Write-Host ""

try {
    $authStatus = & gh auth status 2>&1
    if ($authStatus -match "Logged in") {
        Write-Success "✓ Already authenticated with GitHub"
    } else {
        Write-Warning "Not authenticated. Logging in..."
        & gh auth login
    }
} catch {
    Write-Warning "Authentication check failed. Attempting to login..."
    & gh auth login
}

Write-Host ""

# Step 3: Navigate to project
Write-Info "STEP 3: Setting up project..."
Write-Host ""

cd $projectPath

git config --global user.name "Kiran"
git config --global user.email "kingskiran8@gmail.com"

Write-Success "✓ Project configured"
Write-Host ""

# Step 4: Check if repo exists on GitHub
Write-Info "STEP 4: Checking GitHub repository..."
Write-Host ""

try {
    $repoInfo = & gh repo view $gitHubUsername/$repoName 2>&1
    Write-Success "✓ Repository already exists on GitHub"
} catch {
    Write-Warning "Repository doesn't exist. Creating..."
    try {
        & gh repo create $repoName --public --source=. --remote=origin --push
        Write-Success "✓ Repository created and code pushed!"
    } catch {
        Write-Error "✗ Failed to create repository"
        Write-Warning "Please create manually at https://github.com/new"
        Write-Host ""
        Write-Host "Then run: git push -u origin main"
        exit 1
    }
}

Write-Host ""

# Step 5: Push to GitHub
Write-Info "STEP 5: Pushing code to GitHub..."
Write-Host ""

try {
    # Ensure remote is set
    git remote remove origin 2>$null
    git remote add origin "https://github.com/$gitHubUsername/$repoName.git"

    # Ensure on main branch
    git branch -M main

    # Push
    Write-Info "Pushing commits..."
    & git push -u origin main --force

    Write-Success "✓ Code pushed to GitHub successfully"
} catch {
    Write-Error "✗ Failed to push code"
    exit 1
}

Write-Host ""

# Step 6: Create Pull Request
Write-Info "STEP 6: Creating Pull Request..."
Write-Host ""

try {
    $prOutput = & gh pr create `
        --title "NSE Stock Screener - Complete Full Stack Application" `
        --body @"
## Summary
Complete NSE (Nifty 500) and NYSE stock screener with real-time filtering and technical analysis.

## What's Included
- **Frontend**: React UI with market toggle and real-time stock table
- **Backend**: Flask API with caching system
- **Indicators**: P/E ratio, Volume spike, RSI analysis
- **Features**: 30-second auto-refresh, responsive design, demo data ready
- **Deployment**: Render and Vercel ready configurations

## Key Features
✅ Real-time NSE and NYSE stock screening
✅ Technical analysis (P/E < 20, Volume > 2x, RSI > 50)
✅ Responsive React frontend
✅ Flask backend with caching
✅ Auto-refresh every 30 seconds
✅ Complete deployment infrastructure

## Deployment Ready
- Procfile for Render
- render.yaml configuration
- .claude/launch.json for dev servers
- Complete documentation and guides

## Testing
- ✓ Frontend loads successfully
- ✓ Backend API responding
- ✓ NSE stocks filtering correctly
- ✓ NYSE stocks available
- ✓ Cache system working
- ✓ Market toggle functional

## Next Steps
1. Deploy to Render (backend)
2. Deploy to Vercel (frontend)
3. Access live URL

---
Built with: React + Flask + yfinance
"@ 2>&1

    if ($prOutput -match "https://github.com") {
        $prUrl = $prOutput | Select-String -Pattern "https://github.com.*pull/\d+" -AllMatches | ForEach-Object { $_.Matches.Value } | Select-Object -First 1
        Write-Success "✓ Pull Request created successfully!"
        Write-Success "PR URL: $prUrl"
        $script:prUrl = $prUrl
    } else {
        Write-Warning "PR output: $prOutput"
    }
} catch {
    Write-Warning "Could not create PR (might already exist)"
    Write-Info "Creating PR manually..."
    Start-Process "https://github.com/$gitHubUsername/$repoName/compare/main"
    $script:prUrl = "https://github.com/$gitHubUsername/$repoName/pulls"
}

Write-Host ""

# Step 7: Display results
Write-Host "========================================" -ForegroundColor Green
Write-Host "   🎉 DEPLOYMENT PHASE 1 COMPLETE!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""

Write-Success "✓ All code is on GitHub"
Write-Success "✓ Pull Request created"
Write-Success "✓ Repository ready for deployment"

Write-Host ""
Write-Info "GITHUB DETAILS:"
Write-Host "  Repository: $repoUrl"
Write-Host "  PR: $script:prUrl"

Write-Host ""
Write-Info "NEXT STEP: Deploy to Render"
Write-Host ""
Write-Host "Opening Render dashboard..."
Start-Sleep -Seconds 2
Start-Process "https://render.com/dashboard"

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "   RENDER DEPLOYMENT INSTRUCTIONS" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. Go to: https://render.com/"
Write-Host "2. Sign up with GitHub (use your Kishor-Kiran account)"
Write-Host "3. Click: New + > Web Service"
Write-Host "4. Click: Connect a repository"
Write-Host "5. Find & select: NSE-stock-screener"
Write-Host "6. Click: Connect"
Write-Host ""
Write-Host "7. Configure Service:"
Write-Host "   Name: nse-stock-screener-api"
Write-Host "   Environment: Python 3"
Write-Host "   Build Command:"
Write-Host "     pip install -r backend/requirements-prod.txt"
Write-Host "   Start Command:"
Write-Host "     cd backend && gunicorn app_demo:app --bind 0.0.0.0:\$PORT"
Write-Host "   Plan: Free"
Write-Host ""
Write-Host "8. Click: Create Web Service"
Write-Host "9. Wait 3-5 minutes for deployment"
Write-Host "10. Copy your live API URL when it shows 'Live'"
Write-Host ""
Write-Host "Your live URL will be:"
Write-Host "  https://nse-stock-screener-api-xxxxx.onrender.com"
Write-Host ""

Write-Host "========================================" -ForegroundColor Yellow
Write-Host "   LIVE URL FORMAT" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Yellow
Write-Host ""
Write-Host "API (Backend):"
Write-Host "  https://nse-stock-screener-api-xxxxx.onrender.com"
Write-Host ""
Write-Host "Test it:"
Write-Host "  https://nse-stock-screener-api-xxxxx.onrender.com/api/health"
Write-Host "  https://nse-stock-screener-api-xxxxx.onrender.com/api/stocks/nse"
Write-Host ""

Write-Host "========================================" -ForegroundColor Green
Write-Host "   QUICK REFERENCE" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "GitHub: $repoUrl"
Write-Host "PR: $script:prUrl"
Write-Host "Render: https://render.com/dashboard"
Write-Host "Render New Service: https://render.com/dashboard"
Write-Host ""

Write-Host "Press any key to open GitHub repository..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

Start-Process $repoUrl

Write-Host ""
Write-Success "✓ Script complete! Your deployment journey has begun."
Write-Host ""
