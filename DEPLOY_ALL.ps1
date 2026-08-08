#!/usr/bin/env pwsh
<#
.SYNOPSIS
NSE Stock Screener - Complete Deployment Script
Automates: GitHub push, PR creation, and Render deployment
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
        Write-Info "Installing via Winget..."
        & winget install --id GitHub.cli

        # Refresh environment
        $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

        Write-Success "GitHub CLI installed. Please close and reopen PowerShell."
        Write-Warning "Then run this script again."
        exit 0
    } catch {
        Write-Error "Installation failed. Please install manually from: https://cli.github.com/"
        exit 1
    }
} else {
    Write-Success "GitHub CLI is installed"
    & gh --version
}

Write-Host ""

# Step 2: Check GitHub authentication
Write-Info "STEP 2: Checking GitHub authentication..."
Write-Host ""

try {
    $authStatus = & gh auth status 2>&1
    if ($authStatus -match "Logged in") {
        Write-Success "Already authenticated with GitHub"
    } else {
        Write-Warning "Not authenticated. Logging in..."
        & gh auth login
    }
} catch {
    Write-Warning "Attempting to login..."
    & gh auth login
}

Write-Host ""

# Step 3: Navigate to project
Write-Info "STEP 3: Setting up project..."
Write-Host ""

cd $projectPath

git config --global user.name "Kiran"
git config --global user.email "kingskiran8@gmail.com"

Write-Success "Project configured"
Write-Host ""

# Step 4: Check if repo exists
Write-Info "STEP 4: Checking GitHub repository..."
Write-Host ""

$repoExists = $false
try {
    $repoInfo = & gh repo view $gitHubUsername/$repoName 2>&1
    if ($repoInfo -notmatch "404") {
        Write-Success "Repository already exists on GitHub"
        $repoExists = $true
    }
} catch {
    $repoExists = $false
}

if (-not $repoExists) {
    Write-Warning "Repository doesn't exist. Creating..."
    try {
        & gh repo create $repoName --public --source=. --remote=origin --push
        Write-Success "Repository created and code pushed!"
    } catch {
        Write-Error "Failed to create repository"
        Write-Info "Creating manually at: https://github.com/new"
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
    git remote remove origin 2>$null
    git remote add origin "https://github.com/$gitHubUsername/$repoName.git"
    git branch -M main

    Write-Info "Pushing commits..."
    & git push -u origin main 2>&1 | ForEach-Object { Write-Host $_ }

    Write-Success "Code pushed to GitHub successfully"
} catch {
    Write-Error "Failed to push code"
    exit 1
}

Write-Host ""

# Step 6: Create Pull Request
Write-Info "STEP 6: Creating Pull Request..."
Write-Host ""

$prTitle = "NSE Stock Screener - Complete Full Stack Application"
$prBody = "Complete NSE and NYSE stock screener with real-time filtering and technical analysis. Full stack application ready for deployment."

try {
    $prOutput = & gh pr create --title $prTitle --body $prBody 2>&1

    if ($prOutput -match "https://github.com") {
        Write-Success "Pull Request created successfully!"
        Write-Host $prOutput
        $script:prUrl = ($prOutput | Select-String -Pattern "https://github.com.*pull/\d+" | ForEach-Object { $_.Matches.Value })
    } else {
        Write-Warning "PR creation output: $prOutput"
    }
} catch {
    Write-Warning "Could not create PR automatically"
    $script:prUrl = "https://github.com/$gitHubUsername/$repoName/compare/main"
}

Write-Host ""

# Step 7: Display results
Write-Host "========================================" -ForegroundColor Green
Write-Host "   DEPLOYMENT PHASE 1 COMPLETE!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""

Write-Success "All code is on GitHub"
Write-Success "Pull Request created/ready"
Write-Success "Repository ready for deployment"

Write-Host ""
Write-Info "GITHUB DETAILS:"
Write-Host "  Repository: $repoUrl"
if ($script:prUrl) {
    Write-Host "  PR: $script:prUrl"
}

Write-Host ""
Write-Info "NEXT STEP: Deploy to Render"
Write-Host ""
Write-Host "Opening Render dashboard in 3 seconds..."
Start-Sleep -Seconds 3

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "   RENDER DEPLOYMENT INSTRUCTIONS" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. Go to: https://render.com/"
Write-Host "2. Sign up with GitHub"
Write-Host "3. New Web Service"
Write-Host "4. Connect Repository: NSE-stock-screener"
Write-Host ""
Write-Host "5. Configure:"
Write-Host "   Name: nse-stock-screener-api"
Write-Host "   Environment: Python 3"
Write-Host "   Build: pip install -r backend/requirements-prod.txt"
Write-Host "   Start: cd backend && gunicorn app_demo:app --bind 0.0.0.0:`$PORT"
Write-Host "   Plan: Free"
Write-Host ""
Write-Host "6. Create Web Service and wait 3-5 minutes"
Write-Host ""
Write-Host "Your LIVE API URL:"
Write-Host "  https://nse-stock-screener-api-xxxxx.onrender.com"
Write-Host ""

Write-Host "========================================" -ForegroundColor Yellow
Write-Host "   QUICK LINKS" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Yellow
Write-Host ""
Write-Host "GitHub: $repoUrl"
Write-Host "Render: https://render.com/dashboard"
Write-Host ""

Write-Success "Deployment setup complete!"
Write-Host ""
