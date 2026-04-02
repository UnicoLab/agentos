@echo off
REM ──────────────────────────────────────────────────────────────
REM  AgentOS — Windows Installer
REM
REM  Usage:
REM    install.bat              (installs PM flavour by default)
REM    install.bat --flavour freelancer
REM    install.bat --flavour retail
REM    install.bat --flavour office
REM
REM  Available flavours:
REM    pm         — Jean-Pierre, AI Project Management Copilot (default)
REM    freelancer — Yvette, Freelance Project Management Copilot
REM    retail     — Retail Operations Assistant
REM    office     — Office Productivity Assistant
REM ──────────────────────────────────────────────────────────────
setlocal enabledelayedexpansion

set "REPO=UnicoLab/agentos"
set "BINARY_NAME=agentos"
set "FLAVOUR=pm"

REM ─── Parse arguments ───
:parse_args
if "%~1"=="" goto :done_args
if /I "%~1"=="--flavour" (
    set "FLAVOUR=%~2"
    shift & shift
    goto :parse_args
)
if /I "%~1"=="--flavor" (
    set "FLAVOUR=%~2"
    shift & shift
    goto :parse_args
)
if /I "%~1"=="-f" (
    set "FLAVOUR=%~2"
    shift & shift
    goto :parse_args
)
if /I "%~1"=="--help" goto :show_help
if /I "%~1"=="-h" goto :show_help
shift
goto :parse_args
:done_args

REM ─── Map flavour to archive prefix ───
if /I "%FLAVOUR%"=="pm" (
    set "SOURCE_BINARY=agentos-pm"
    set "DISPLAY_NAME=Jean-Pierre — The PM"
) else if /I "%FLAVOUR%"=="aiflow-pm" (
    set "SOURCE_BINARY=agentos-pm"
    set "DISPLAY_NAME=Jean-Pierre — The PM"
) else if /I "%FLAVOUR%"=="freelancer" (
    set "SOURCE_BINARY=agentos-freelancer"
    set "DISPLAY_NAME=Yvette — Freelancer PM"
) else if /I "%FLAVOUR%"=="retail" (
    set "SOURCE_BINARY=agentos-retail"
    set "DISPLAY_NAME=Retail Ops"
) else if /I "%FLAVOUR%"=="retail-ops" (
    set "SOURCE_BINARY=agentos-retail"
    set "DISPLAY_NAME=Retail Ops"
) else if /I "%FLAVOUR%"=="office" (
    set "SOURCE_BINARY=agentos-office"
    set "DISPLAY_NAME=Office Assistant"
) else (
    echo.
    echo  ERROR: Unknown flavour "%FLAVOUR%"
    echo.
    echo  Available flavours:
    echo    pm         Jean-Pierre, AI Project Management Copilot ^(default^)
    echo    freelancer Yvette, Freelance Project Management Copilot
    echo    retail     Retail Operations Assistant
    echo    office     Office Productivity Assistant
    echo.
    exit /b 1
)

echo.
echo   ==================================
echo       AgentOS Windows Installer
echo   ==================================
echo.
echo   Flavour:  %DISPLAY_NAME%
echo   Binary:   %BINARY_NAME%.exe
echo.

REM ─── Check for curl ───
where curl >nul 2>&1
if errorlevel 1 (
    echo  ERROR: curl not found. Please install curl or download manually from:
    echo    https://github.com/%REPO%/releases/latest
    exit /b 1
)

REM ─── Get latest version ───
echo   Fetching latest release...
for /f "tokens=2 delims=:" %%a in ('curl -s https://api.github.com/repos/%REPO%/releases/latest ^| findstr "tag_name"') do (
    set "TAG=%%a"
)
set "TAG=%TAG:"=%"
set "TAG=%TAG:,=%"
set "TAG=%TAG: =%"

if "%TAG%"=="" (
    echo  ERROR: Could not determine latest version.
    echo    Check: https://github.com/%REPO%/releases
    exit /b 1
)

echo   Version:  %TAG%

REM ─── Build download URL ───
set "VERSION_NUM=%TAG:~1%"
set "ARCHIVE=%SOURCE_BINARY%_%VERSION_NUM%_windows_amd64.zip"
set "URL=https://github.com/%REPO%/releases/download/%TAG%/%ARCHIVE%"

REM ─── Download ───
echo   Downloading %ARCHIVE%...
set "WORK=%TEMP%\agentos_install"
if exist "%WORK%" rmdir /s /q "%WORK%"
mkdir "%WORK%"

curl -fsSL "%URL%" -o "%WORK%\%ARCHIVE%"
if errorlevel 1 (
    echo.
    echo  ERROR: Download failed.
    echo    URL: %URL%
    echo    Check your internet connection or download manually.
    exit /b 1
)
echo   Downloaded successfully.

REM ─── Extract ───
echo   Extracting...
powershell -Command "Expand-Archive -Path '%WORK%\%ARCHIVE%' -DestinationPath '%WORK%\extracted' -Force"
if errorlevel 1 (
    echo  ERROR: Extraction failed.
    exit /b 1
)
echo   Extracted successfully.

REM ─── Rename to agentos.exe ───
if exist "%WORK%\extracted\%SOURCE_BINARY%.exe" (
    move /y "%WORK%\extracted\%SOURCE_BINARY%.exe" "%WORK%\extracted\%BINARY_NAME%.exe" >nul
    echo   Renamed %SOURCE_BINARY%.exe to %BINARY_NAME%.exe
)

REM ─── Install ───
set "INSTALL_DIR=%LOCALAPPDATA%\AgentOS"
if not exist "%INSTALL_DIR%" mkdir "%INSTALL_DIR%"
move /y "%WORK%\extracted\%BINARY_NAME%.exe" "%INSTALL_DIR%\%BINARY_NAME%.exe" >nul

REM ─── Copy pack directory if present ───
if exist "%WORK%\extracted\packs" (
    xcopy /s /e /y /q "%WORK%\extracted\packs" "%INSTALL_DIR%\packs\" >nul
    echo   Pack files copied.
)

REM ─── Add to PATH ───
echo %PATH% | findstr /i "%INSTALL_DIR%" >nul 2>&1
if errorlevel 1 (
    echo   Adding %INSTALL_DIR% to user PATH...
    powershell -Command "[Environment]::SetEnvironmentVariable('PATH', [Environment]::GetEnvironmentVariable('PATH', 'User') + ';%INSTALL_DIR%', 'User')"
    set "PATH=%INSTALL_DIR%;%PATH%"
    echo   Added to PATH. You may need to restart your terminal.
)

REM ─── Cleanup ───
rmdir /s /q "%WORK%" >nul 2>&1

REM ─── Done ───
echo.
echo   ==================================
echo       Installation Complete!
echo   ==================================
echo.
echo   Flavour:       %DISPLAY_NAME%
echo   Installed to:  %INSTALL_DIR%\%BINARY_NAME%.exe
echo.
echo   Need a license?  Email info@unicolab.ai
echo   Documentation:   https://unicolab.github.io/agentos/
echo.
echo   Starting AgentOS... (press Ctrl+C to stop)
echo.

"%INSTALL_DIR%\%BINARY_NAME%.exe" serve
goto :eof

:show_help
echo.
echo  AgentOS Windows Installer
echo.
echo  Usage:
echo    install.bat                             Install PM flavour (default)
echo    install.bat --flavour freelancer        Install Freelancer flavour (Yvette)
echo    install.bat --flavour retail            Install Retail Ops flavour
echo    install.bat --flavour office            Install Office flavour
echo.
echo  Available flavours:
echo    pm         Jean-Pierre — AI Project Management Copilot (default)
echo    freelancer Yvette — Freelance Project Management Copilot
echo    retail     Retail Operations Assistant
echo    office     Office Productivity Assistant
echo.
goto :eof
