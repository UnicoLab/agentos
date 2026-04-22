#!/bin/sh
# ──────────────────────────────────────────────────────────────
#  AgentOS — Universal Installer
#
#  Default (PM flavor):
#    curl -fsSL https://unicolab.github.io/agentos/install.sh | sh
#
#  Choose a flavor:
#    curl -fsSL https://unicolab.github.io/agentos/install.sh | sh -s -- --flavour michelle
#    curl -fsSL https://unicolab.github.io/agentos/install.sh | sh -s -- --flavour freelancer
#    curl -fsSL https://unicolab.github.io/agentos/install.sh | sh -s -- --flavour retail
#    curl -fsSL https://unicolab.github.io/agentos/install.sh | sh -s -- --flavour office
#
#  Available flavours:
#    pm              — Jean-Pierre, AI Project Management Copilot (default)
#    jean-pierre     — Alias for pm
#    michelle        — Michelle, Analytics Intelligence Copilot
#    freelancer      — Yvette, Freelance Project Management Copilot
#    edith           — Édith, Sales Intelligence Copilot
#    retail          — Retail Operations Assistant
#    office          — Office Productivity Assistant
#
#  Features:
#    • Auto-detects OS (macOS/Linux) and architecture (arm64/amd64)
#    • Selects the correct per-flavour binary
#    • macOS: clears Gatekeeper quarantine + ad-hoc code signs
#    • Installs to /usr/local/bin (admin) or ~/.local/bin (no admin)
#    • Supports --install-dir for custom install location
#    • Automatically adds to PATH if needed
#    • Launches AgentOS after install
#    • Full error handling with actionable messages
# ──────────────────────────────────────────────────────────────
set -e

REPO="UnicoLab/agentos"
BINARY_NAME="agentos"

# ─── Flavour mapping ───
# Maps user-friendly names to binary archive prefixes
flavour_to_binary() {
  case "$1" in
    pm|aiflow-pm|jean-pierre) echo "agentos-pm" ;;
    michelle)                 echo "agentos-michelle" ;;
    freelancer)               echo "agentos-freelancer" ;;
    edith|sales)              echo "agentos-edith" ;;
    retail|retail-ops)        echo "agentos-retail" ;;
    office)                   echo "agentos-office" ;;
    *)
      fail "Unknown flavour: ${BOLD}$1${NC}\n\n    Available flavours:\n      ${CYAN}pm${NC}              — Jean-Pierre, AI Project Management Copilot (default)\n      ${CYAN}jean-pierre${NC}     — Alias for pm\n      ${CYAN}michelle${NC}        — Michelle, Analytics Intelligence Copilot\n      ${CYAN}freelancer${NC}      — Yvette, Freelance Project Management Copilot\n      ${CYAN}edith${NC}           — Édith, Sales Intelligence Copilot\n      ${CYAN}retail${NC}          — Retail Operations Assistant\n      ${CYAN}office${NC}          — Office Productivity Assistant\n\n    Usage: curl -fsSL https://unicolab.github.io/agentos/install.sh | sh -s -- --flavour michelle"
      ;;
  esac
}

flavour_display_name() {
  case "$1" in
    pm|aiflow-pm|jean-pierre) echo "Jean-Pierre — The PM 🎩" ;;
    michelle)                 echo "Michelle — Analytics Intelligence 📊" ;;
    freelancer)               echo "Yvette — Freelancer PM 💼" ;;
    edith|sales)              echo "Édith — Sales Intelligence 🥐" ;;
    retail|retail-ops)        echo "Retail Ops 🛒" ;;
    office)                   echo "Office Assistant 🏢" ;;
    *)                        echo "$1" ;;
  esac
}

# ─── Colors ───
ESC=$(printf '\033')
RED="${ESC}[0;31m"; GREEN="${ESC}[0;32m"; CYAN="${ESC}[0;36m"
YELLOW="${ESC}[1;33m"; BOLD="${ESC}[1m"; DIM="${ESC}[2m"; NC="${ESC}[0m"

# ─── Logging ───
STEP_NUM=0
info()    { printf "%s\n" "${CYAN}ℹ${NC}  $1"; }
step()    { STEP_NUM=$((STEP_NUM + 1)); printf "%s\n" "${CYAN}[${STEP_NUM}]${NC} $1"; }
success() { printf "%s\n" "${GREEN}✅${NC} $1"; }
warn()    { printf "%s\n" "${YELLOW}⚠️${NC}  $1"; }
fail()    { printf "\n%s\n" "${RED}❌ ERROR${NC}  $1"; printf "\n    ${DIM}Need help? Email info@unicolab.ai or visit https://unicolab.github.io/agentos/${NC}\n\n"; exit 1; }

header() {
  printf "\n"
  printf "%s\n" "${BOLD}${CYAN}  ╔══════════════════════════════════╗${NC}"
  printf "%s\n" "${BOLD}${CYAN}  ║   ⬡  AgentOS Installer          ║${NC}"
  printf "%s\n" "${BOLD}${CYAN}  ╚══════════════════════════════════╝${NC}"
  printf "\n"
}

# ─── Dependency Check ───
check_dependencies() {
  if ! command -v curl >/dev/null 2>&1 && ! command -v wget >/dev/null 2>&1; then
    fail "Neither ${BOLD}curl${NC} nor ${BOLD}wget${NC} found. Please install one:\n    macOS:  ${CYAN}brew install curl${NC}\n    Ubuntu: ${CYAN}sudo apt install curl${NC}\n    Fedora: ${CYAN}sudo dnf install curl${NC}"
  fi

  if ! command -v tar >/dev/null 2>&1; then
    fail "${BOLD}tar${NC} not found. Please install it:\n    Ubuntu: ${CYAN}sudo apt install tar${NC}\n    Fedora: ${CYAN}sudo dnf install tar${NC}"
  fi
}

# ─── Network connectivity pre-check ───
check_network() {
  if command -v curl >/dev/null 2>&1; then
    if ! curl -fsS --max-time 10 "https://api.github.com/rate_limit" >/dev/null 2>&1; then
      fail "Cannot reach GitHub API.\n\n    Possible causes:\n      • No internet connection\n      • Firewall or proxy blocking HTTPS to github.com\n      • GitHub is experiencing an outage (check ${CYAN}https://githubstatus.com${NC})\n\n    Try:  ${CYAN}curl -I https://api.github.com${NC}  to diagnose"
    fi
  elif command -v wget >/dev/null 2>&1; then
    if ! wget -q --timeout=10 --spider "https://api.github.com/rate_limit" 2>/dev/null; then
      fail "Cannot reach GitHub API.\n\n    Possible causes:\n      • No internet connection\n      • Firewall or proxy blocking HTTPS to github.com\n\n    Try:  ${CYAN}wget --spider https://api.github.com${NC}  to diagnose"
    fi
  fi
}

# ─── HTTP GET with retry (3 attempts, exponential backoff) ───
http_get() {
  URL="$1"
  OUTPUT="$2"
  MAX_RETRIES=3
  ATTEMPT=1

  while [ "$ATTEMPT" -le "$MAX_RETRIES" ]; do
    HTTP_ERR=""
    if command -v curl >/dev/null 2>&1; then
      if [ -n "$OUTPUT" ]; then
        HTTP_ERR=$(curl -fsSL "$URL" -o "$OUTPUT" 2>&1) && return 0
      else
        HTTP_ERR=$(curl -fsSL "$URL" 2>/dev/null) && return 0
      fi
    elif command -v wget >/dev/null 2>&1; then
      if [ -n "$OUTPUT" ]; then
        HTTP_ERR=$(wget -q "$URL" -O "$OUTPUT" 2>&1) && return 0
      else
        wget -qO- "$URL" 2>/dev/null && return 0
      fi
    fi

    if [ "$ATTEMPT" -lt "$MAX_RETRIES" ]; then
      WAIT=$((ATTEMPT * 2))
      warn "Attempt ${ATTEMPT}/${MAX_RETRIES} failed. Retrying in ${WAIT}s... ${DIM}(${HTTP_ERR})${NC}"
      sleep "$WAIT"
    fi
    ATTEMPT=$((ATTEMPT + 1))
  done

  # All retries exhausted — return failure
  return 1
}

# ─── HTTP GET for JSON (no output file, captures stdout, with retry) ───
http_get_json() {
  URL="$1"
  MAX_RETRIES=3
  ATTEMPT=1

  while [ "$ATTEMPT" -le "$MAX_RETRIES" ]; do
    RESULT=""
    if command -v curl >/dev/null 2>&1; then
      RESULT=$(curl -fsSL "$URL" 2>/dev/null) && { echo "$RESULT"; return 0; }
    elif command -v wget >/dev/null 2>&1; then
      RESULT=$(wget -qO- "$URL" 2>/dev/null) && { echo "$RESULT"; return 0; }
    fi

    if [ "$ATTEMPT" -lt "$MAX_RETRIES" ]; then
      WAIT=$((ATTEMPT * 2))
      warn "API request failed (attempt ${ATTEMPT}/${MAX_RETRIES}). Retrying in ${WAIT}s..."
      sleep "$WAIT"
    fi
    ATTEMPT=$((ATTEMPT + 1))
  done
  return 1
}

# ─── Detect OS ───
detect_os() {
  case "$(uname -s)" in
    Darwin*)
      echo "darwin"
      ;;
    Linux*)
      echo "linux"
      ;;
    MINGW*|MSYS*|CYGWIN*)
      fail "Windows detected. Please download the .zip manually:\n    ${CYAN}https://github.com/${REPO}/releases/latest${NC}\n\n    Then extract and run: ${BOLD}.\\agentos.exe serve${NC}"
      ;;
    *)
      fail "Unsupported operating system: ${BOLD}$(uname -s)${NC}\n    Supported: macOS, Linux, Windows (manual)"
      ;;
  esac
}

# ─── Detect Architecture ───
detect_arch() {
  case "$(uname -m)" in
    x86_64|amd64)
      echo "amd64"
      ;;
    arm64|aarch64)
      echo "arm64"
      ;;
    i386|i686)
      fail "32-bit systems are not supported. AgentOS requires a 64-bit OS.\n    Run ${CYAN}uname -m${NC} to check your architecture."
      ;;
    *)
      fail "Unsupported architecture: ${BOLD}$(uname -m)${NC}\n    Supported: x86_64 (amd64), arm64 (aarch64)"
      ;;
  esac
}

# ── Fetch latest version for a specific flavour ──
# Per-flavour releases use tags like "michelle/v1.4.1".
# We search recent releases for one whose assets match the requested binary.
get_latest_version() {
  WANTED_BINARY="$1"  # e.g. "agentos-michelle"
  TAG=""

  # Strategy 1: Search recent releases for one containing the requested flavour's archive
  ALL_RELEASES=$(http_get_json "https://api.github.com/repos/${REPO}/releases?per_page=20" 2>/dev/null || true)

  if [ -n "$ALL_RELEASES" ]; then
    # Check for API rate limiting
    if echo "$ALL_RELEASES" | grep -q '"rate limit"' 2>/dev/null; then
      warn "GitHub API rate limit reached. Trying fallback strategies..."
    else
      # Find the first release whose assets contain our binary name
      TAG=$(echo "$ALL_RELEASES" \
        | grep -E '"tag_name"|"name"' \
        | awk -v bin="${WANTED_BINARY}" '
          /"tag_name"/ { gsub(/.*"tag_name": *"|".*/, ""); current_tag = $0 }
          /"name"/ && index($0, bin) { print current_tag; exit }
        ')
    fi
  fi

  # Strategy 2: Fallback to /releases/latest (unified releases or first available)
  if [ -z "$TAG" ]; then
    info "Searching latest release..."
    LATEST=$(http_get_json "https://api.github.com/repos/${REPO}/releases/latest" 2>/dev/null || true)
    if [ -n "$LATEST" ]; then
      TAG=$(echo "$LATEST" | grep '"tag_name"' | head -1 | sed 's/.*"tag_name": *"//;s/".*//')
    fi
  fi

  # Strategy 3: Fallback to any release (pre-releases included)
  if [ -z "$TAG" ]; then
    info "Searching all releases (including pre-releases)..."
    ANY=$(http_get_json "https://api.github.com/repos/${REPO}/releases" 2>/dev/null || true)
    if [ -n "$ANY" ]; then
      TAG=$(echo "$ANY" | grep '"tag_name"' | head -1 | sed 's/.*"tag_name": *"//;s/".*//')
    fi
  fi

  if [ -z "$TAG" ]; then
    fail "Could not determine latest version for ${BOLD}${WANTED_BINARY}${NC}.\n\n    Possible causes:\n      • GitHub API rate limit exceeded (60 req/hr for unauthenticated users)\n      • No releases published yet for this flavour\n      • Network issue\n\n    Manual fix:\n      1. Visit ${CYAN}https://github.com/${REPO}/releases${NC}\n      2. Download the archive for your platform\n      3. Extract and run: ${CYAN}./agentos serve${NC}\n\n    Check rate limit: ${CYAN}curl -s https://api.github.com/rate_limit | grep remaining${NC}"
  fi

  echo "$TAG"
}

# ─── macOS Security Clearance ───
macos_security() {
  BINARY_PATH="$1"

  info "Clearing macOS Gatekeeper restrictions..."

  # Remove quarantine flag (no sudo needed on user-owned files)
  xattr -rd com.apple.quarantine "$BINARY_PATH" 2>/dev/null || true

  # Ad-hoc code sign
  if command -v codesign >/dev/null 2>&1; then
    codesign --force --sign - "$BINARY_PATH" 2>/dev/null || true
  fi

  success "macOS security cleared"
}

# ─── Smart Install (admin → user fallback) ───
install_binary() {
  SRC="$1"

  # If a custom install dir was specified, use it directly
  if [ -n "$INSTALL_DIR" ]; then
    TARGET_DIR=$(eval echo "$INSTALL_DIR")  # Expand ~ and $HOME
    mkdir -p "$TARGET_DIR"
    mv "$SRC" "${TARGET_DIR}/${BINARY_NAME}"
    chmod +x "${TARGET_DIR}/${BINARY_NAME}"
    FINAL_DIR="$TARGET_DIR"
    success "Installed to ${BOLD}${TARGET_DIR}/${BINARY_NAME}${NC}"
    ensure_path "$TARGET_DIR"
    return 0
  fi

  # Strategy 1: System-wide install (/usr/local/bin)
  SYSTEM_DIR="/usr/local/bin"
  if [ -w "$SYSTEM_DIR" ]; then
    mv "$SRC" "${SYSTEM_DIR}/${BINARY_NAME}"
    FINAL_DIR="$SYSTEM_DIR"
    success "Installed to ${BOLD}${SYSTEM_DIR}/${BINARY_NAME}${NC}"
    return 0
  fi

  # Strategy 2: System-wide with sudo (only if password-less sudo available)
  if command -v sudo >/dev/null 2>&1 && sudo -n true 2>/dev/null; then
    sudo mv "$SRC" "${SYSTEM_DIR}/${BINARY_NAME}"
    FINAL_DIR="$SYSTEM_DIR"
    success "Installed to ${BOLD}${SYSTEM_DIR}/${BINARY_NAME}${NC} (via sudo)"
    return 0
  fi

  # Strategy 3: Ask for sudo password
  if command -v sudo >/dev/null 2>&1; then
    info "Admin access recommended for system-wide install."
    printf "    ${DIM}Enter your password, or press Ctrl+C to skip (will install locally)${NC}\n"
    if sudo mv "$SRC" "${SYSTEM_DIR}/${BINARY_NAME}" 2>/dev/null; then
      FINAL_DIR="$SYSTEM_DIR"
      success "Installed to ${BOLD}${SYSTEM_DIR}/${BINARY_NAME}${NC}"
      return 0
    fi
  fi

  # Strategy 4: User-local install (no admin needed)
  USER_DIR="${HOME}/.local/bin"
  mkdir -p "$USER_DIR"
  mv "$SRC" "${USER_DIR}/${BINARY_NAME}"
  FINAL_DIR="$USER_DIR"
  success "Installed to ${BOLD}${USER_DIR}/${BINARY_NAME}${NC} (no admin required)"

  # Ensure ~/.local/bin is in PATH
  ensure_path "$USER_DIR"
  return 0
}

# ─── Add directory to PATH persistently ───
ensure_path() {
  DIR_TO_ADD="$1"

  # Already in PATH?
  case ":${PATH}:" in
    *":${DIR_TO_ADD}:"*)
      return 0
      ;;
  esac

  # Apply for current session
  export PATH="${DIR_TO_ADD}:${PATH}"

  # Detect shell config file
  SHELL_NAME=$(basename "${SHELL:-/bin/sh}")
  case "$SHELL_NAME" in
    zsh)   SHELL_RC="${HOME}/.zshrc" ;;
    bash)  SHELL_RC="${HOME}/.bashrc" ;;
    fish)  SHELL_RC="${HOME}/.config/fish/config.fish" ;;
    *)     SHELL_RC="${HOME}/.profile" ;;
  esac

  # Add to shell config if not already there
  EXPORT_LINE="export PATH=\"${DIR_TO_ADD}:\$PATH\""
  if [ -f "$SHELL_RC" ] && grep -qF "$DIR_TO_ADD" "$SHELL_RC" 2>/dev/null; then
    return 0
  fi

  printf "\n# Added by AgentOS installer\n%s\n" "$EXPORT_LINE" >> "$SHELL_RC"
  success "Added ${BOLD}${DIR_TO_ADD}${NC} to PATH in ${BOLD}$(basename "$SHELL_RC")${NC}"
}

# ─── Parse arguments ───
parse_args() {
  FLAVOUR="pm"
  INSTALL_DIR=""

  while [ $# -gt 0 ]; do
    case "$1" in
      --flavour|--flavor|-f)
        if [ -n "$2" ]; then
          FLAVOUR="$2"
          shift 2
        else
          fail "--flavour requires a value.\n    Usage: curl ... | sh -s -- --flavour pm\n    Options: pm, jean-pierre, michelle, freelancer, edith, retail, office"
        fi
        ;;
      --install-dir|--dir)
        if [ -n "$2" ]; then
          INSTALL_DIR="$2"
          shift 2
        else
          fail "--install-dir requires a path.\n    Usage: curl ... | sh -s -- --install-dir ~/my-tools"
        fi
        ;;
      --help|-h)
        printf "\n${BOLD}AgentOS Installer${NC}\n\n"
        printf "  ${CYAN}Usage:${NC}\n"
        printf "    curl -fsSL https://unicolab.github.io/agentos/install.sh | sh\n"
        printf "    curl -fsSL https://unicolab.github.io/agentos/install.sh | sh -s -- --flavour retail\n"
        printf "    curl -fsSL https://unicolab.github.io/agentos/install.sh | sh -s -- --install-dir ~/testing\n\n"
        printf "  ${CYAN}Options:${NC}\n"
        printf "    --flavour <name>   Select agent flavour (default: pm)\n"
        printf "    --install-dir <path>  Install to a specific directory (e.g., ~/testing)\n"
        printf "    --help             Show this help message\n\n"
        printf "  ${CYAN}Available flavours:${NC}\n"
        printf "    ${BOLD}pm${NC}              Jean-Pierre — AI Project Management Copilot ${GREEN}(default)${NC}\n"
        printf "    ${BOLD}jean-pierre${NC}     Alias for pm\n"
        printf "    ${BOLD}michelle${NC}        Michelle — Analytics Intelligence Copilot\n"
        printf "    ${BOLD}freelancer${NC}      Yvette — Freelance Project Management Copilot\n"
        printf "    ${BOLD}edith${NC}           Édith — Sales Intelligence Copilot\n"
        printf "    ${BOLD}retail${NC}          Retail Operations Assistant\n"
        printf "    ${BOLD}office${NC}          Office Productivity Assistant\n\n"
        exit 0
        ;;
      *)
        shift
        ;;
    esac
  done
}

# ─── Main ───
main() {
  parse_args "$@"
  header

  # Resolve flavour-specific archive name
  SOURCE_BINARY=$(flavour_to_binary "$FLAVOUR")
  DISPLAY_NAME=$(flavour_display_name "$FLAVOUR")
  info "Flavour:  ${BOLD}${DISPLAY_NAME}${NC} → archive ${CYAN}${SOURCE_BINARY}${NC}"
  info "Binary:   ${BOLD}${BINARY_NAME}${NC} (all flavours install as '${BINARY_NAME}')"
  printf "\n"

  step "Checking dependencies..."
  check_dependencies
  success "Dependencies OK"

  # Detect platform
  step "Detecting platform..."
  OS=$(detect_os)
  ARCH=$(detect_arch)
  success "Platform: ${BOLD}${OS}/${ARCH}${NC}"

  # Network connectivity check
  step "Checking network connectivity..."
  check_network
  success "GitHub API reachable"

  # Resolve version (flavour-aware: finds the release containing our binary)
  step "Fetching latest release for ${BOLD}${SOURCE_BINARY}${NC}..."
  VERSION=$(get_latest_version "$SOURCE_BINARY")
  success "Version: ${BOLD}${VERSION}${NC}"

  # Download — archive naming: agentos-pm_0.12.0_darwin_arm64.tar.gz
  # Strip flavour prefix from tag: "michelle/v1.4.1" → "v1.4.1", "v1.0.0" → "v1.0.0"
  VERSION_CLEAN="${VERSION##*/}"
  VERSION_NUM="${VERSION_CLEAN#v}"
  ARCHIVE="${SOURCE_BINARY}_${VERSION_NUM}_${OS}_${ARCH}.tar.gz"
  URL="https://github.com/${REPO}/releases/download/${VERSION}/${ARCHIVE}"

  WORK=$(mktemp -d)
  trap 'rm -rf "$WORK"' EXIT

  step "Downloading ${BOLD}${ARCHIVE}${NC}..."
  info "URL: ${DIM}${URL}${NC}"
  if ! http_get "$URL" "${WORK}/${ARCHIVE}"; then
    fail "Download failed after 3 attempts.\n\n    URL: ${CYAN}${URL}${NC}\n\n    Possible causes:\n      • Archive does not exist for this platform (${OS}/${ARCH})\n      • Release ${BOLD}${VERSION}${NC} may not include ${BOLD}${SOURCE_BINARY}${NC}\n      • Network or firewall issue\n\n    Try manually:\n      ${CYAN}curl -fsSL \"${URL}\" -o ${ARCHIVE}${NC}\n\n    Or browse releases:\n      ${CYAN}https://github.com/${REPO}/releases${NC}\n\n    💡 For the default PM flavour:\n       ${CYAN}curl -fsSL https://unicolab.github.io/agentos/install.sh | sh${NC}"
  fi

  # Validate downloaded file
  if [ ! -s "${WORK}/${ARCHIVE}" ]; then
    fail "Downloaded file is empty (0 bytes).\n\n    URL: ${CYAN}${URL}${NC}\n    This usually means the asset does not exist in the release.\n\n    Browse available downloads:\n      ${CYAN}https://github.com/${REPO}/releases/tag/${VERSION}${NC}"
  fi
  FILESIZE=$(wc -c < "${WORK}/${ARCHIVE}" 2>/dev/null | tr -d ' ')
  success "Downloaded (${FILESIZE} bytes)"

  # Extract
  step "Extracting archive..."
  if ! tar xzf "${WORK}/${ARCHIVE}" -C "${WORK}" 2>/dev/null; then
    fail "Extraction failed. The archive may be corrupted or incomplete.\n\n    Archive: ${BOLD}${ARCHIVE}${NC} (${FILESIZE} bytes)\n\n    Try:\n      1. Download again:  ${CYAN}curl -fsSL \"${URL}\" -o ${ARCHIVE}${NC}\n      2. Check integrity:  ${CYAN}file ${ARCHIVE}${NC}\n      3. Extract manually: ${CYAN}tar xzf ${ARCHIVE}${NC}"
  fi
  success "Extracted"

  # Rename flavour binary → agentos (so all commands stay compatible)
  if [ "${SOURCE_BINARY}" != "${BINARY_NAME}" ] && [ -f "${WORK}/${SOURCE_BINARY}" ]; then
    mv "${WORK}/${SOURCE_BINARY}" "${WORK}/${BINARY_NAME}"
    info "Renamed ${SOURCE_BINARY} → ${BINARY_NAME}"
  fi

  # Verify binary exists after extraction
  if [ ! -f "${WORK}/${BINARY_NAME}" ]; then
    # List what was extracted for debugging
    EXTRACTED=$(ls -1 "${WORK}" 2>/dev/null | grep -v '\.tar\.gz$' | head -10)
    fail "Binary ${BOLD}${BINARY_NAME}${NC} not found after extraction.\n\n    Expected: ${BOLD}${SOURCE_BINARY}${NC} or ${BOLD}${BINARY_NAME}${NC}\n    Found:    ${DIM}${EXTRACTED:-nothing}${NC}\n\n    The archive structure may have changed. Try extracting manually:\n      ${CYAN}tar xzf ${ARCHIVE} && ls -la${NC}"
  fi

  # macOS: Gatekeeper clearance
  if [ "$OS" = "darwin" ]; then
    step "Clearing macOS security restrictions..."
    macos_security "${WORK}/${BINARY_NAME}"
  fi

  # Make executable
  chmod +x "${WORK}/${BINARY_NAME}"

  # Install with smart fallback
  step "Installing binary..."
  FINAL_DIR=""
  install_binary "${WORK}/${BINARY_NAME}"

  # Verify installation
  printf "\n"
  step "Verifying installation..."
  if command -v "${BINARY_NAME}" >/dev/null 2>&1; then
    INSTALLED_VERSION=$("${BINARY_NAME}" version 2>/dev/null || echo "installed")
    success "${BOLD}AgentOS${NC} ${DISPLAY_NAME} ${INSTALLED_VERSION}"
  elif [ -x "${FINAL_DIR}/${BINARY_NAME}" ]; then
    INSTALLED_VERSION=$("${FINAL_DIR}/${BINARY_NAME}" version 2>/dev/null || echo "installed")
    success "${BOLD}AgentOS${NC} ${DISPLAY_NAME} ${INSTALLED_VERSION}"
  else
    warn "Binary installed but not in PATH. Run it directly:"
    printf "    ${CYAN}${FINAL_DIR}/${BINARY_NAME} serve${NC}\n"
    warn "Or restart your terminal to pick up PATH changes."
  fi

  # Summary
  printf "\n"
  printf "%s\n" "${BOLD}${GREEN}  ╔══════════════════════════════════╗${NC}"
  printf "%s\n" "${BOLD}${GREEN}  ║   🎉 Installation Complete!      ║${NC}"
  printf "%s\n" "${BOLD}${GREEN}  ╚══════════════════════════════════╝${NC}"
  printf "\n"
  printf "  ${YELLOW}Flavour:${NC}       ${BOLD}${DISPLAY_NAME}${NC}\n"
  printf "  ${YELLOW}Need a license?${NC} Email ${BOLD}info@unicolab.ai${NC}\n"
  printf "  ${CYAN}Documentation:${NC}  https://unicolab.github.io/agentos/\n"
  printf "\n"

  # Auto-launch
  info "Starting AgentOS... ${DIM}(Ctrl+C to stop)${NC}"
  printf "\n"
  if command -v "${BINARY_NAME}" >/dev/null 2>&1; then
    "${BINARY_NAME}" serve
  else
    "${FINAL_DIR}/${BINARY_NAME}" serve
  fi
}

main "$@"

