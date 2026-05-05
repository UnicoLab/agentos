# ══════════════════════════════════════════════════════════════
#  AgentOS — Windows Installer (PowerShell)
#
#  Default (Jean-Pierre PM flavor):
#    irm https://unicolab.github.io/agentos/install.ps1 | iex
#
#  Choose a flavor:
#    irm https://unicolab.github.io/agentos/install.ps1 | iex; Install-AgentOS -Flavour michelle
#    irm https://unicolab.github.io/agentos/install.ps1 | iex; Install-AgentOS -Flavour brigitte
#
#  Install ALL agents:
#    irm https://unicolab.github.io/agentos/install.ps1 | iex; Install-AgentOS -Flavour all
#
#  Available flavours:
#    pm / jean-pierre  — Jean-Pierre, AI Project Management Copilot (default)
#    michelle          — Michelle, Analytics Intelligence Copilot
#    brigitte          — Brigitte, Management Intelligence Copilot
#    all               — Install all three agents at once
#
#  Features:
#    • Auto-detects Windows architecture (x64/arm64)
#    • Downloads from GitHub Releases with retry (3 attempts)
#    • Per-flavour binary naming (agentos-michelle.exe)
#    • Interactive install location choice
#    • Fleet dispatcher (agentos.cmd) for multi-agent management
#    • Conflict detection for existing binaries
#    • Rich, colorized TUI output
# ══════════════════════════════════════════════════════════════

#Requires -Version 5.1
$ErrorActionPreference = 'Stop'

# ─── Configuration ───
$Script:Repo = 'UnicoLab/agentos'
$Script:AllFlavours = @('pm', 'michelle', 'brigitte')

# ─── Colors & Logging ───
function Write-Header {
    Write-Host ""
    Write-Host "  ╔══════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "  ║   ⬡  AgentOS Installer           ║" -ForegroundColor Cyan
    Write-Host "  ╚══════════════════════════════════╝" -ForegroundColor Cyan
    Write-Host ""
}

function Write-Step {
    param([string]$Message)
    $Script:StepNum++
    Write-Host "[$Script:StepNum] $Message" -ForegroundColor Cyan
}

function Write-Info {
    param([string]$Message)
    Write-Host "ℹ  $Message" -ForegroundColor Cyan
}

function Write-Ok {
    param([string]$Message)
    Write-Host "✅ $Message" -ForegroundColor Green
}

function Write-Warn {
    param([string]$Message)
    Write-Host "⚠  $Message" -ForegroundColor Yellow
}

function Write-Fail {
    param([string]$Message)
    Write-Host ""
    Write-Host "❌ ERROR  $Message" -ForegroundColor Red
    Write-Host ""
    Write-Host "    Need help? Email info@unicolab.ai or visit https://unicolab.github.io/agentos/" -ForegroundColor DarkGray
    Write-Host ""
    exit 1
}

# ─── Flavour Mapping ───
function Get-FlavourBinary {
    param([string]$Flavour)
    switch ($Flavour) {
        { $_ -in 'pm','aiflow-pm','jean-pierre' } { return 'agentos-pm' }
        'michelle'   { return 'agentos-michelle' }
        'brigitte'   { return 'agentos-brigitte' }
        default      { return "agentos-$Flavour" }
    }
}

function Get-FlavourDisplayName {
    param([string]$Flavour)
    switch ($Flavour) {
        { $_ -in 'pm','aiflow-pm','jean-pierre' } { return 'Jean-Pierre — The PM 🎩' }
        'michelle'   { return 'Michelle — Analytics Intelligence 📊' }
        'brigitte'   { return 'Brigitte — Management Intelligence 🧠' }
        default      { return $Flavour }
    }
}

function Get-FlavourLocalName {
    param([string]$Flavour)
    switch ($Flavour) {
        { $_ -in 'pm','aiflow-pm','jean-pierre' } { return 'agentos-pm' }
        'michelle'   { return 'agentos-michelle' }
        'brigitte'   { return 'agentos-brigitte' }
        default      { return "agentos-$Flavour" }
    }
}

# ─── Platform Detection ───
function Get-Arch {
    $arch = [System.Runtime.InteropServices.RuntimeInformation]::OSArchitecture
    switch ($arch) {
        'X64'   { return 'amd64' }
        'Arm64' { return 'arm64' }
        default {
            # Fallback for older PowerShell
            if ($env:PROCESSOR_ARCHITECTURE -eq 'AMD64') { return 'amd64' }
            if ($env:PROCESSOR_ARCHITECTURE -eq 'ARM64') { return 'arm64' }
            Write-Fail "Unsupported architecture: $arch`n    Supported: x64 (amd64), arm64"
        }
    }
}

# ─── HTTP with Retry ───
function Invoke-Download {
    param(
        [string]$Url,
        [string]$OutFile,
        [int]$MaxRetries = 3
    )
    for ($attempt = 1; $attempt -le $MaxRetries; $attempt++) {
        try {
            $ProgressPreference = 'SilentlyContinue'
            if ($OutFile) {
                Invoke-WebRequest -Uri $Url -OutFile $OutFile -UseBasicParsing -ErrorAction Stop
            } else {
                return (Invoke-RestMethod -Uri $Url -UseBasicParsing -ErrorAction Stop)
            }
            return
        } catch {
            if ($attempt -lt $MaxRetries) {
                $wait = $attempt * 2
                Write-Warn "Attempt $attempt/$MaxRetries failed. Retrying in ${wait}s... ($($_.Exception.Message))"
                Start-Sleep -Seconds $wait
            }
        }
    }
    Write-Fail "Download failed after $MaxRetries attempts.`n    URL: $Url`n`n    Possible causes:`n      • No internet connection`n      • Firewall blocking HTTPS to github.com`n      • GitHub is experiencing an outage (check https://githubstatus.com)"
}

# ─── Fetch Latest Version ───
function Get-LatestVersion {
    param([string]$WantedBinary)

    try {
        $releases = Invoke-Download -Url "https://api.github.com/repos/$Script:Repo/releases?per_page=20"
    } catch {
        Write-Fail "Cannot reach GitHub API.`n`n    Possible causes:`n      • No internet connection`n      • Firewall blocking HTTPS`n`n    Try: Invoke-WebRequest https://api.github.com"
    }

    foreach ($release in $releases) {
        if ($release.draft -or $release.prerelease) { continue }
        foreach ($asset in $release.assets) {
            if ($asset.name -match "^$([regex]::Escape($WantedBinary))_") {
                return $release.tag_name
            }
        }
    }

    Write-Fail "No release found containing '$WantedBinary'.`n`n    Available releases:`n      https://github.com/$Script:Repo/releases`n`n    Make sure the flavour is correct."
}

# ─── Install Fleet Dispatcher (agentos.cmd) ───
function Install-Dispatcher {
    param([string]$Dir)

    $dispatcherPath = Join-Path $Dir 'agentos.cmd'

    # Don't overwrite if it's an actual binary (not our script)
    if (Test-Path $dispatcherPath) {
        $firstLine = Get-Content $dispatcherPath -TotalCount 1 -ErrorAction SilentlyContinue
        if ($firstLine -and -not $firstLine.StartsWith('@')) {
            return  # It's a binary, skip
        }
    }

    $dispatcherContent = @'
@echo off
setlocal EnableDelayedExpansion

:: ══════════════════════════════════════════════════════════════
::  AgentOS Fleet Manager — manage all installed agent flavours
::  Auto-generated by the AgentOS installer.
:: ══════════════════════════════════════════════════════════════

set "SELF_DIR=%~dp0"
set "SELF_DIR=%SELF_DIR:~0,-1%"

if "%~1"=="" goto :help
if "%~1"=="list" goto :list
if "%~1"=="ls" goto :list
if "%~1"=="start" goto :start
if "%~1"=="run" goto :start
if "%~1"=="stop" goto :stop
if "%~1"=="status" goto :status
if "%~1"=="help" goto :help
if "%~1"=="--help" goto :help
if "%~1"=="-h" goto :help
echo.
echo   X  Unknown command: %~1
echo.
echo   Available: list  start  stop  status  help
echo   Try:       agentos help
echo.
exit /b 1

:list
echo.
echo   AgentOS Fleet Manager
echo   ─────────────────────────────────────────
set "FOUND=0"
for %%f in ("%SELF_DIR%\agentos-*.exe") do (
    set "FOUND=1"
    set "AGENT=%%~nf"
    set "AGENT=!AGENT:agentos-=!"
    echo   * !AGENT!
)
if "!FOUND!"=="0" echo   (no agents installed)
echo   ─────────────────────────────────────────
echo.
echo   Start:  agentos start ^<name^>
echo   Status: agentos status
echo.
exit /b 0

:start
if "%~2"=="" (
    echo.
    echo   X  Missing agent name.
    echo   Usage:  agentos start ^<agent^>
    echo   List:   agentos list
    echo.
    exit /b 1
)
set "BIN=%SELF_DIR%\agentos-%~2.exe"
if not exist "%BIN%" (
    echo.
    echo   X  Agent '%~2' not found.
    echo   Installed agents:
    for %%f in ("%SELF_DIR%\agentos-*.exe") do (
        set "A=%%~nf"
        set "A=!A:agentos-=!"
        echo     * !A!
    )
    echo.
    exit /b 1
)
echo.
echo   Starting %~2...
echo.
"%BIN%" serve %3 %4 %5 %6 %7 %8 %9
exit /b %ERRORLEVEL%

:stop
if "%~2"=="" (
    echo.
    echo   X  Missing agent name.
    echo   Usage:  agentos stop ^<agent^>
    echo.
    exit /b 1
)
taskkill /IM "agentos-%~2.exe" /F >nul 2>&1
if %ERRORLEVEL%==0 (
    echo   Stopped %~2
) else (
    echo   %~2 is not running.
)
exit /b 0

:status
echo.
echo   AgentOS Agent Status
echo   ─────────────────────────────────────────
for %%f in ("%SELF_DIR%\agentos-*.exe") do (
    set "AGENT=%%~nf"
    set "AGENT=!AGENT:agentos-=!"
    tasklist /FI "IMAGENAME eq %%~nxf" 2>nul | find "%%~nxf" >nul 2>&1
    if !ERRORLEVEL!==0 (
        echo   !AGENT!    running
    ) else (
        echo   !AGENT!    stopped
    )
)
echo   ─────────────────────────────────────────
echo.
exit /b 0

:help
echo.
echo   AgentOS Fleet Manager
echo   ─────────────────────────────────────────
echo.
echo   Commands:
echo     list               Show installed agents
echo     start ^<agent^>      Start an agent
echo     stop  ^<agent^>      Stop a running agent
echo     status             Show all agent status
echo     help               Show this message
echo.
echo   Examples:
echo     agentos list
echo     agentos start michelle
echo     agentos start brigitte
echo     agentos stop michelle
echo     agentos-michelle.exe serve
echo.
echo   Install more:
echo     irm https://unicolab.github.io/agentos/install.ps1 ^| iex
echo.
echo   Each agent uses isolated storage and auto-selects
echo   a free port if the default (:18080) is occupied.
echo.
echo   Need help?  info@unicolab.ai
echo   Docs:       https://unicolab.github.io/agentos/
echo.
exit /b 0
'@

    Set-Content -Path $dispatcherPath -Value $dispatcherContent -Encoding ASCII
    Write-Ok "Installed agentos.cmd fleet dispatcher to $Dir"
}

# ─── Add to PATH ───
function Add-ToPath {
    param([string]$Dir)

    $currentPath = [Environment]::GetEnvironmentVariable('Path', 'User')
    if ($currentPath -split ';' | Where-Object { $_ -eq $Dir }) {
        return  # Already in PATH
    }

    [Environment]::SetEnvironmentVariable('Path', "$currentPath;$Dir", 'User')
    $env:Path = "$env:Path;$Dir"
    Write-Ok "Added $Dir to user PATH"
    Write-Info "Restart your terminal for PATH changes to take effect."
}

# ─── Main Install Function ───
function Install-AgentOS {
    param(
        [string]$Flavour = 'pm',
        [string]$BinaryName = '',
        [string]$InstallDir = ''
    )

    $Script:StepNum = 0

    # Handle --flavour all
    if ($Flavour -eq 'all') {
        Write-Header
        Write-Info "Installing ALL agent flavours: $($Script:AllFlavours -join ', ')"
        Write-Host ""

        foreach ($flav in $Script:AllFlavours) {
            Write-Host ""
            Write-Host "  ── Installing $flav ──" -ForegroundColor Cyan
            Install-AgentOS -Flavour $flav -InstallDir $InstallDir
        }

        Write-Host ""
        Write-Host "  ╔══════════════════════════════════════════╗" -ForegroundColor Green
        Write-Host "  ║   🎉 All Agents Installed!               ║" -ForegroundColor Green
        Write-Host "  ╚══════════════════════════════════════════╝" -ForegroundColor Green
        Write-Host ""
        Write-Host "  Installed agents:" -ForegroundColor Cyan
        foreach ($flav in $Script:AllFlavours) {
            $name = Get-FlavourDisplayName $flav
            Write-Host "    • agentos-$flav  —  $name"
        }
        Write-Host ""
        Write-Host "  Fleet manager: " -NoNewline -ForegroundColor DarkGray
        Write-Host "agentos list" -NoNewline -ForegroundColor White
        Write-Host " | " -NoNewline -ForegroundColor DarkGray
        Write-Host "agentos start <flavour>" -ForegroundColor White
        Write-Host ""
        return
    }

    Write-Header

    # Resolve names
    $sourceBinary = Get-FlavourBinary $Flavour
    $displayName = Get-FlavourDisplayName $Flavour
    if (-not $BinaryName) { $BinaryName = Get-FlavourLocalName $Flavour }

    Write-Info "Flavour:  $displayName → archive $sourceBinary"
    Write-Info "Binary:   $BinaryName.exe (per-flavour isolated)"
    Write-Host ""

    # ── Step 1: Platform ──
    Write-Step "Detecting platform..."
    $arch = Get-Arch
    Write-Ok "Platform: windows/$arch"

    # ── Step 2: Network ──
    Write-Step "Checking network connectivity..."
    try {
        $null = Invoke-WebRequest -Uri 'https://api.github.com' -UseBasicParsing -TimeoutSec 10 -ErrorAction Stop
        Write-Ok "GitHub API reachable"
    } catch {
        Write-Fail "Cannot reach GitHub API.`n`n    Possible causes:`n      • No internet connection`n      • Firewall blocking HTTPS`n`n    Try: Invoke-WebRequest https://api.github.com"
    }

    # ── Step 3: Version ──
    Write-Step "Fetching latest release for $sourceBinary..."
    $version = Get-LatestVersion $sourceBinary
    Write-Ok "Version: $version"

    # ── Step 4: Download ──
    $versionClean = ($version -split '/')[-1]
    $versionNum = $versionClean -replace '^v', ''
    $archive = "${sourceBinary}_${versionNum}_windows_${arch}.zip"
    $url = "https://github.com/$Script:Repo/releases/download/$version/$archive"

    $tempDir = Join-Path $env:TEMP "agentos_install_$(Get-Random)"
    New-Item -ItemType Directory -Path $tempDir -Force | Out-Null

    try {
        Write-Step "Downloading $archive..."
        Write-Info "URL: $url"
        Invoke-Download -Url $url -OutFile (Join-Path $tempDir $archive)

        $fileSize = (Get-Item (Join-Path $tempDir $archive)).Length
        if ($fileSize -eq 0) {
            Write-Fail "Downloaded file is empty (0 bytes).`n    URL: $url`n    Browse: https://github.com/$Script:Repo/releases/tag/$version"
        }
        Write-Ok "Downloaded ($fileSize bytes)"

        # ── Step 5: Extract ──
        Write-Step "Extracting archive..."
        Expand-Archive -Path (Join-Path $tempDir $archive) -DestinationPath $tempDir -Force
        Write-Ok "Extracted"

        # Rename if needed
        $srcExe = Join-Path $tempDir "$sourceBinary.exe"
        $targetExe = Join-Path $tempDir "$BinaryName.exe"
        if ((Test-Path $srcExe) -and ($sourceBinary -ne $BinaryName)) {
            Move-Item $srcExe $targetExe -Force
            Write-Info "Renamed $sourceBinary.exe → $BinaryName.exe"
        } elseif (-not (Test-Path $targetExe)) {
            # Try to find any .exe in the archive
            $found = Get-ChildItem $tempDir -Filter '*.exe' | Select-Object -First 1
            if ($found) {
                Move-Item $found.FullName $targetExe -Force
                Write-Info "Found $($found.Name) → $BinaryName.exe"
            } else {
                Write-Fail "No .exe found after extraction.`n    Expected: $sourceBinary.exe`n    Archive may have changed structure."
            }
        }

        # ── Step 6: Unblock ──
        Write-Step "Clearing Windows security restrictions..."
        Unblock-File -Path $targetExe -ErrorAction SilentlyContinue
        Write-Ok "Security cleared"

        # ── Step 7: Place in CWD ──
        $cwdBin = Join-Path (Get-Location) "$BinaryName.exe"
        Copy-Item $targetExe $cwdBin -Force
        Write-Ok "Binary placed in $cwdBin"

        # ── Step 8: Install location ──
        Write-Step "Installing binary..."

        $systemDir = Join-Path $env:ProgramFiles 'AgentOS'
        $userDir = Join-Path $env:LOCALAPPDATA 'AgentOS'
        $finalDir = ''

        if ($InstallDir) {
            # Explicit install dir
            $finalDir = $InstallDir
            if (-not (Test-Path $finalDir)) { New-Item -ItemType Directory -Path $finalDir -Force | Out-Null }
            Copy-Item $cwdBin (Join-Path $finalDir "$BinaryName.exe") -Force
            Write-Ok "Installed to $finalDir\$BinaryName.exe"
            Add-ToPath $finalDir
        } else {
            # Interactive choice
            Write-Host ""
            Write-Host "  Where would you like to install " -NoNewline
            Write-Host "$BinaryName.exe" -NoNewline -ForegroundColor Cyan
            Write-Host "?"
            Write-Host ""
            Write-Host "    1)  " -NoNewline
            Write-Host "Keep here" -NoNewline -ForegroundColor Green
            Write-Host " — use from current directory ($((Get-Location).Path))" -ForegroundColor DarkGray
            Write-Host "    2)  " -NoNewline
            Write-Host "System-wide" -NoNewline -ForegroundColor Green
            Write-Host " — install to $systemDir" -NoNewline -ForegroundColor DarkGray
            Write-Host " (may require admin)" -ForegroundColor DarkGray
            Write-Host "    3)  " -NoNewline
            Write-Host "User-local" -NoNewline -ForegroundColor Green
            Write-Host " — install to $userDir" -ForegroundColor DarkGray
            Write-Host ""
            $choice = Read-Host "  Choice [1/2/3, default=3]"
            if (-not $choice) { $choice = '3' }

            switch ($choice) {
                '1' {
                    $finalDir = (Get-Location).Path
                    Write-Ok "Keeping binary in $cwdBin"
                    Add-ToPath $finalDir
                }
                '2' {
                    try {
                        if (-not (Test-Path $systemDir)) { New-Item -ItemType Directory -Path $systemDir -Force | Out-Null }
                        Copy-Item $cwdBin (Join-Path $systemDir "$BinaryName.exe") -Force
                        $finalDir = $systemDir
                        Write-Ok "Installed to $systemDir\$BinaryName.exe"
                        Add-ToPath $systemDir
                    } catch {
                        Write-Warn "System-wide install failed (admin required). Falling back to user-local."
                        if (-not (Test-Path $userDir)) { New-Item -ItemType Directory -Path $userDir -Force | Out-Null }
                        Copy-Item $cwdBin (Join-Path $userDir "$BinaryName.exe") -Force
                        $finalDir = $userDir
                        Write-Ok "Installed to $userDir\$BinaryName.exe"
                        Add-ToPath $userDir
                    }
                }
                '3' {
                    if (-not (Test-Path $userDir)) { New-Item -ItemType Directory -Path $userDir -Force | Out-Null }
                    Copy-Item $cwdBin (Join-Path $userDir "$BinaryName.exe") -Force
                    $finalDir = $userDir
                    Write-Ok "Installed to $userDir\$BinaryName.exe"
                    Add-ToPath $userDir
                }
                default {
                    Write-Warn "Invalid choice '$choice'. Keeping in current directory."
                    $finalDir = (Get-Location).Path
                }
            }
        }

        # ── Step 9: Verify ──
        Write-Host ""
        Write-Step "Verifying installation..."
        $verifyBin = if ($finalDir) { Join-Path $finalDir "$BinaryName.exe" } else { $cwdBin }
        if (Test-Path $verifyBin) {
            try {
                $ver = & $verifyBin version 2>&1 | Select-Object -First 1
                Write-Ok "AgentOS $displayName $ver"
            } catch {
                Write-Ok "AgentOS $displayName installed"
            }
        }

        # ── Step 10: Fleet Dispatcher ──
        if ($finalDir) {
            Install-Dispatcher $finalDir
        }

        # ── Conflict detection ──
        $existingPaths = @($systemDir, $userDir)
        foreach ($checkDir in $existingPaths) {
            if ($checkDir -eq $finalDir) { continue }
            $existing = Join-Path $checkDir "$BinaryName.exe"
            if (Test-Path $existing) {
                Write-Warn "Existing binary also found at: $existing"
                Write-Info "If you want both, re-run with: -BinaryName <custom-name>"
            }
        }

        # ── Summary ──
        Write-Host ""
        Write-Host "  ╔══════════════════════════════════╗" -ForegroundColor Green
        Write-Host "  ║   🎉 Installation Complete!      ║" -ForegroundColor Green
        Write-Host "  ╚══════════════════════════════════╝" -ForegroundColor Green
        Write-Host ""
        Write-Host "  Flavour:       " -NoNewline -ForegroundColor Yellow
        Write-Host "$displayName"
        Write-Host "  Binary:        " -NoNewline -ForegroundColor Yellow
        Write-Host "$BinaryName.exe"
        Write-Host "  Data dir:      " -NoNewline -ForegroundColor Yellow
        Write-Host "~\.agentos\$Flavour\ (isolated)"
        Write-Host "  Need a license?" -NoNewline -ForegroundColor Yellow
        Write-Host " Email info@unicolab.ai"
        Write-Host "  Documentation: " -NoNewline -ForegroundColor Cyan
        Write-Host "https://unicolab.github.io/agentos/"
        Write-Host ""
        Write-Host "  Run directly:  " -NoNewline -ForegroundColor DarkGray
        Write-Host "$BinaryName serve" -ForegroundColor White
        Write-Host "  Fleet manager: " -NoNewline -ForegroundColor DarkGray
        Write-Host "agentos list" -NoNewline -ForegroundColor White
        Write-Host " | " -NoNewline -ForegroundColor DarkGray
        Write-Host "agentos start $Flavour" -ForegroundColor White
        Write-Host ""

        # ── Auto-launch ──
        Write-Info "Starting AgentOS... (Ctrl+C to stop)"
        Write-Host ""
        if (Test-Path $verifyBin) {
            & $verifyBin serve
        } elseif (Test-Path $cwdBin) {
            & $cwdBin serve
        }

    } finally {
        # Cleanup temp dir
        if (Test-Path $tempDir) {
            Remove-Item $tempDir -Recurse -Force -ErrorAction SilentlyContinue
        }
    }
}

# ─── Auto-run when piped (irm | iex) ───
# Parse command-line-style arguments from $args
$installParams = @{}

for ($i = 0; $i -lt $args.Count; $i++) {
    switch ($args[$i]) {
        { $_ -in '--flavour','--flavor','-f' } {
            if ($i + 1 -lt $args.Count) { $installParams['Flavour'] = $args[++$i] }
        }
        { $_ -in '--binary-name','--name' } {
            if ($i + 1 -lt $args.Count) { $installParams['BinaryName'] = $args[++$i] }
        }
        { $_ -in '--install-dir' } {
            if ($i + 1 -lt $args.Count) { $installParams['InstallDir'] = $args[++$i] }
        }
        { $_ -in '--help','-h' } {
            Write-Host ""
            Write-Host "AgentOS Installer (PowerShell)" -ForegroundColor Cyan
            Write-Host ""
            Write-Host "  Usage:" -ForegroundColor Cyan
            Write-Host "    irm https://unicolab.github.io/agentos/install.ps1 | iex"
            Write-Host "    .\install.ps1 --flavour michelle"
            Write-Host "    .\install.ps1 --flavour all"
            Write-Host "    .\install.ps1 --flavour brigitte --binary-name my-brigitte"
            Write-Host ""
            Write-Host "  Options:" -ForegroundColor Cyan
            Write-Host "    --flavour <name>     Select agent flavour (default: pm)"
            Write-Host "    --binary-name <name> Custom binary name"
            Write-Host "    --install-dir <path> Install to a specific directory"
            Write-Host "    --help               Show this help message"
            Write-Host ""
            Write-Host "  Available flavours:" -ForegroundColor Cyan
            Write-Host "    pm              Jean-Pierre — AI Project Management Copilot (default)" -ForegroundColor White
            Write-Host "    jean-pierre     Alias for pm" -ForegroundColor DarkGray
            Write-Host "    michelle        Michelle — Analytics Intelligence Copilot" -ForegroundColor White
            Write-Host "    brigitte        Brigitte — Management Intelligence Copilot" -ForegroundColor White
            Write-Host "    all             Install all three agents at once" -ForegroundColor White
            Write-Host ""
            Write-Host "  Multi-agent:" -ForegroundColor Cyan
            Write-Host "    Each flavour installs as agentos-<flavour>.exe by default."
            Write-Host "    Multiple agents run side-by-side with isolated databases."
            Write-Host "    Ports auto-increment if the default (:18080) is occupied."
            Write-Host ""
            Write-Host "    After installing multiple agents, use the agentos wrapper:" -ForegroundColor DarkGray
            Write-Host "      agentos list               — show installed agents" -ForegroundColor Cyan
            Write-Host "      agentos start michelle      — start a specific agent" -ForegroundColor Cyan
            Write-Host ""
            return
        }
    }
}

Install-AgentOS @installParams
