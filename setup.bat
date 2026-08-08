@echo off
REM Stock Screener Setup Script for Windows

echo.
echo ========================================
echo   Stock Screener - Automated Setup
echo ========================================
echo.

REM Check Python
echo Checking Python installation...
python --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Python not found. Please install Python 3.8+ from https://www.python.org/
    pause
    exit /b 1
)
echo ✓ Python found
echo.

REM Check Node.js
echo Checking Node.js installation...
node --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Node.js not found. Please install Node.js 14+ from https://nodejs.org/
    pause
    exit /b 1
)
echo ✓ Node.js found
echo.

REM Setup Backend
echo ========================================
echo Setting up Backend...
echo ========================================
cd backend

echo Creating virtual environment...
python -m venv venv
if errorlevel 1 (
    echo ERROR: Failed to create virtual environment
    pause
    exit /b 1
)

echo Activating virtual environment...
call venv\Scripts\activate.bat

echo Installing Python dependencies...
pip install -r requirements.txt
if errorlevel 1 (
    echo ERROR: Failed to install Python dependencies
    pause
    exit /b 1
)
echo ✓ Backend setup complete
echo.

cd ..

REM Setup Frontend
echo ========================================
echo Setting up Frontend...
echo ========================================
cd frontend

echo Installing Node.js dependencies...
call npm install
if errorlevel 1 (
    echo ERROR: Failed to install Node.js dependencies
    pause
    exit /b 1
)
echo ✓ Frontend setup complete
echo.

cd ..

REM Success message
echo ========================================
echo   Setup Complete! ✓
echo ========================================
echo.
echo Next steps:
echo.
echo 1. Open TWO terminals/command prompts
echo.
echo TERMINAL 1 - Run Backend:
echo   cd backend
echo   venv\Scripts\activate
echo   python app.py
echo.
echo TERMINAL 2 - Run Frontend:
echo   cd frontend
echo   npm start
echo.
echo Then open: http://localhost:3000
echo.
pause
