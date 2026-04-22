@echo off
REM ──────────────────────────────────────────────────────────────
REM  AgentOS — Windows Installer
REM
REM  Usage:
REM    install.bat              (installs PM flavour by default)
REM    install.bat --flavour michelle
REM    install.bat --flavour freelancer
REM    install.bat --flavour retail
REM    install.bat --flavour office
REM
REM  Available flavours:
REM    pm              — Jean-Pierre, AI Project Management Copilot (default)
REM    jean-pierre     — Alias for pm
REM    michelle        — Michelle, Analytics Intelligence Copilot
REM    freelancer      — Yvette, Freelance Project Management Copilot
REM    edith           — Édith, Sales Intelligence Copilot
REM    retail          — Retail Operations Assistant
REM    office          — Office Productivity Assistant
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
) else if /I "%FLAVOUR%"=="jean-pierre" (
    set "SOURCE_BINARY=agentos-pm"
    set "DISPLAY_NAME=Jean-Pierre — The PM"
) else if /I "%FLAVOUR%"=="michelle" (
    set "SOURCE_BINARY=agentos-michelle"
    set "DISPLAY_NAME=Michelle — Analytics Intelligence"
) else if /I "%FLAVOUR%"=="freelancer" (
    set "SOURCE_BINARY=agentos-freelancer"
    set "DISPLAY_NAME=Yvette — Freelancer PM"
) else if /I "%FLAVOUR%"=="edith" (
    set "SOURCE_BINARY=agentos-edith"
    set "DISPLAY_NAME=Edith — Sales Intelligence"
) else if /I "%FLAVOUR%"=="sales" (
    set "SOURCE_BINARY=agentos-edith"
    set "DISPLAY_NAME=Edith — Sales Intelligence"
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
    echo    pm              Jean-Pierre, AI Project Management Copilot ^(default^)
    echo    jean-pierre     Alias for pm
    echo    michelle        Michelle, Analytics Intelligence Copilot
    echo    freelancer      Yvette, Freelance Project Management Copilot
    echo    edith           Edith, Sales Intelligence Copilot
    echo    retail          Retail Operations Assistant
    echo    office          Office Productivity Assistant
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
    echo.
    echo  ERROR: curl not found.
    echo.
    echo  curl is required but was not found on your system.
    echo  Windows 10+ includes curl by default.
    echo.
    echo  Manual download:
    echo    https://github.com/%REPO%/releases/latest
    echo.
    exit /b 1
)

REM ─── Check for PowerShell ───
where powershell >nul 2>&1
if errorlevel 1 (
    echo  ERROR: PowerShell not found. Required for archive extraction.
    exit /b 1
)

REM ─── Network connectivity check ───
echo   [1] Checking network connectivity...
curl -fsS --max-time 10 "https://api.github.com/rate_limit" >nul 2>&1
if errorlevel 1 (
    echo.
    echo  ERROR: Cannot reach GitHub API.
    echo.
    echo  Possible causes:
    echo    - No internet connection
    echo    - Firewall or proxy blocking HTTPS to github.com
    echo    - GitHub is experiencing an outage
    echo.
    echo  Check: https://githubstatus.com
    echo  Test:  curl -I https://api.github.com
    echo.
    exit /b 1
)
echo   OK - GitHub API reachable

REM ─── Get latest version (flavour-aware, with retry) ───
echo   [2] Fetching latest release for %SOURCE_BINARY%...

REM Strategy 1: Search recent releases for one containing our flavour's archive
set "TAG="
set "RETRY=0"
:version_retry
for /f "usebackq delims=" %%t in (`powershell -NoProfile -Command ^
  "try { ^
    $releases = Invoke-RestMethod -Uri 'https://api.github.com/repos/%REPO%/releases?per_page=20' -ErrorAction Stop; ^
    foreach ($r in $releases) { ^
      foreach ($a in $r.assets) { ^
        if ($a.name -like '%SOURCE_BINARY%*') { ^
          Write-Output $r.tag_name; ^
          return; ^
        } ^
      } ^
    } ^
  } catch { }"`) do (
    set "TAG=%%t"
)

REM Strategy 2: Fallback to /releases/latest
if "%TAG%"=="" (
    for /f "usebackq delims=" %%t in (`powershell -NoProfile -Command ^
      "try { ^
        $r = Invoke-RestMethod -Uri 'https://api.github.com/repos/%REPO%/releases/latest' -ErrorAction Stop; ^
        Write-Output $r.tag_name ^
      } catch { }"`) do (
        set "TAG=%%t"
    )
)

REM Retry once if version resolution failed
if "%TAG%"=="" (
    if %RETRY% LSS 1 (
        set /a RETRY+=1
        echo   Retry %RETRY%/1 - version lookup failed, waiting 3s...
        timeout /t 3 /nobreak >nul
        goto :version_retry
    )
)

if "%TAG%"=="" (
    echo.
    echo  ERROR: Could not determine latest version for %SOURCE_BINARY%.
    echo.
    echo  Possible causes:
    echo    - GitHub API rate limit exceeded ^(60 req/hr unauthenticated^)
    echo    - No releases published yet for this flavour
    echo    - Network issue
    echo.
    echo  Manual fix:
    echo    1. Visit https://github.com/%REPO%/releases
    echo    2. Download the .zip for your platform
    echo    3. Extract and run: agentos.exe serve
    echo.
    exit /b 1
)

echo   OK - Version: %TAG%

REM ─── Build download URL ───
REM Strip flavour prefix from tag: "michelle/v1.4.1" → "v1.4.1", "v1.0.0" → "v1.0.0"
set "VERSION_CLEAN=%TAG%"
for /f "tokens=2 delims=/" %%v in ("%TAG%") do set "VERSION_CLEAN=%%v"
set "VERSION_NUM=%VERSION_CLEAN:~1%"
set "ARCHIVE=%SOURCE_BINARY%_%VERSION_NUM%_windows_amd64.zip"
set "URL=https://github.com/%REPO%/releases/download/%TAG%/%ARCHIVE%"

REM ─── Download (with retry) ───
echo   [3] Downloading %ARCHIVE%...
echo       URL: %URL%
set "WORK=%TEMP%\agentos_install"
if exist "%WORK%" rmdir /s /q "%WORK%"
mkdir "%WORK%"

set "DL_OK=0"
set "DL_ATTEMPT=0"
:download_retry
set /a DL_ATTEMPT+=1
curl -fsSL "%URL%" -o "%WORK%\%ARCHIVE%" 2>nul
if not errorlevel 1 set "DL_OK=1"

if "%DL_OK%"=="0" (
    if %DL_ATTEMPT% LSS 3 (
        set /a WAIT=DL_ATTEMPT*2
        echo   Attempt %DL_ATTEMPT%/3 failed. Retrying in %WAIT%s...
        timeout /t %WAIT% /nobreak >nul
        goto :download_retry
    )
    echo.
    echo  ERROR: Download failed after 3 attempts.
    echo.
    echo    URL: %URL%
    echo.
    echo  Possible causes:
    echo    - Archive does not exist for windows/amd64
    echo    - Release %TAG% may not include %SOURCE_BINARY%
    echo    - Network or firewall issue
    echo.
    echo  Try manually:
    echo    curl -fsSL "%URL%" -o %ARCHIVE%
    echo.
    echo  Or browse releases:
    echo    https://github.com/%REPO%/releases
    echo.
    exit /b 1
)

REM Validate file is not empty
for %%F in ("%WORK%\%ARCHIVE%") do set "FILESIZE=%%~zF"
if "%FILESIZE%"=="0" (
    echo.
    echo  ERROR: Downloaded file is empty ^(0 bytes^).
    echo    The asset may not exist in release %TAG%.
    echo    Browse: https://github.com/%REPO%/releases/tag/%TAG%
    echo.
    exit /b 1
)
echo   OK - Downloaded (%FILESIZE% bytes)

REM ─── Extract ───
echo   [4] Extracting...
powershell -Command "Expand-Archive -Path '%WORK%\%ARCHIVE%' -DestinationPath '%WORK%\extracted' -Force"
if errorlevel 1 (
    echo.
    echo  ERROR: Extraction failed. The archive may be corrupted.
    echo.
    echo  Archive: %ARCHIVE% (%FILESIZE% bytes)
    echo.
    echo  Try:
    echo    1. Download again: curl -fsSL "%URL%" -o %ARCHIVE%
    echo    2. Extract manually in Explorer
    echo.
    exit /b 1
)
echo   OK - Extracted

REM ─── Rename to agentos.exe ───
if exist "%WORK%\extracted\%SOURCE_BINARY%.exe" (
    move /y "%WORK%\extracted\%SOURCE_BINARY%.exe" "%WORK%\extracted\%BINARY_NAME%.exe" >nul
    echo   Renamed %SOURCE_BINARY%.exe to %BINARY_NAME%.exe
)

REM ─── Verify binary exists ───
if not exist "%WORK%\extracted\%BINARY_NAME%.exe" (
    echo.
    echo  ERROR: Binary %BINARY_NAME%.exe not found after extraction.
    echo.
    echo  Expected: %SOURCE_BINARY%.exe or %BINARY_NAME%.exe
    echo  Contents:
    dir /b "%WORK%\extracted\" 2>nul
    echo.
    exit /b 1
)

REM ─── Install ───
echo   [5] Installing...
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
echo   OK - Installed to %INSTALL_DIR%\%BINARY_NAME%.exe

REM ─── Cleanup ───
rmdir /s /q "%WORK%" >nul 2>&1

REM ─── Verify ───
echo   [6] Verifying...
"%INSTALL_DIR%\%BINARY_NAME%.exe" version 2>nul
if errorlevel 1 (
    echo   WARNING: Could not verify binary. It may still work.
)

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
echo    install.bat --flavour michelle          Install Michelle Analytics flavour
echo    install.bat --flavour freelancer        Install Freelancer flavour (Yvette)
echo    install.bat --flavour retail            Install Retail Ops flavour
echo    install.bat --flavour office            Install Office flavour
echo.
echo  Available flavours:
echo    pm              Jean-Pierre — AI Project Management Copilot (default)
echo    jean-pierre     Alias for pm
echo    michelle        Michelle — Analytics Intelligence Copilot
echo    freelancer      Yvette — Freelance Project Management Copilot
echo    edith           Edith — Sales Intelligence Copilot
echo    retail          Retail Operations Assistant
echo    office          Office Productivity Assistant
echo.
goto :eof
