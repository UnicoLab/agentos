#!/bin/sh
# ──────────────────────────────────────────────────────────────
#  AgentOS — Universal Installer
#
#  Default (Jean-Pierre PM flavor):
#    curl -fsSL https://unicolab.github.io/agentos/install.sh | sh
#
#  Choose a flavor:
#    curl -fsSL https://unicolab.github.io/agentos/install.sh | sh -s -- --flavour michelle
#    curl -fsSL https://unicolab.github.io/agentos/install.sh | sh -s -- --flavour brigitte
#
#  Install ALL agents at once:
#    curl -fsSL https://unicolab.github.io/agentos/install.sh | sh -s -- --flavour all
#
#  Available flavours:
#    pm              — Jean-Pierre, AI Project Management Copilot (default)
#    jean-pierre     — Alias for pm
#    michelle        — Michelle, Analytics Intelligence Copilot
#    brigitte        — Brigitte, Management Intelligence Copilot
#
#  Multi-agent coexistence:
#    Each flavour installs as 'agentos-<flavor>' by default so
#    multiple agents can run side-by-side with isolated databases.
#    A lightweight 'agentos' dispatcher is also created for
#    fleet management: agentos list, agentos start michelle, etc.
#
#  Features:
#    • Auto-detects OS (macOS/Linux) and architecture (arm64/amd64)
#    • Selects the correct per-flavour binary
#    • Per-flavour binary names for safe multi-agent coexistence
#    • Auto-increments HTTP port if the default is occupied
#    • Isolated data directory per agent (~/.agentos/<pack_name>/)
#    • Conflict detection when overwriting existing binaries
#    • macOS: clears Gatekeeper quarantine + ad-hoc code signs
#    • Installs to /usr/local/bin (admin) or ~/.local/bin (no admin)
#    • Supports --install-dir for custom install location
#    • Supports --binary-name for custom binary name (default: agentos-<flavour>)
#    • Automatically adds to PATH if needed
#    • Launches AgentOS after install
#    • Full error handling with actionable messages
# ──────────────────────────────────────────────────────────────
set -e

REPO="UnicoLab/agentos"
BINARY_NAME=""  # Set dynamically based on flavour (default: agentos-<flavor>)

# ─── Flavour mapping ───
# Maps user-friendly names to binary archive prefixes
flavour_to_binary() {
  case "$1" in
    pm|aiflow-pm|jean-pierre) echo "agentos-pm" ;;
    michelle)                 echo "agentos-michelle" ;;
    brigitte)                 echo "agentos-brigitte" ;;
    freelancer)               echo "agentos-freelancer" ;;
    edith|sales)              echo "agentos-edith" ;;
    retail|retail-ops)        echo "agentos-retail" ;;
    office)                   echo "agentos-office" ;;
    *)
      fail "Unknown flavour: ${BOLD}$1${NC}\n\n    Available flavours:\n      ${CYAN}pm${NC}              — Jean-Pierre, AI Project Management Copilot (default)\n      ${CYAN}jean-pierre${NC}     — Alias for pm\n      ${CYAN}michelle${NC}        — Michelle, Analytics Intelligence Copilot\n      ${CYAN}brigitte${NC}        — Brigitte, Management Intelligence Copilot\n      ${CYAN}all${NC}             — Install all three agents at once\n\n    Usage: curl -fsSL https://unicolab.github.io/agentos/install.sh | sh -s -- --flavour brigitte"
      ;;
  esac
}

flavour_display_name() {
  case "$1" in
    pm|aiflow-pm|jean-pierre) echo "Jean-Pierre — The PM 🎩" ;;
    michelle)                 echo "Michelle — Analytics Intelligence 📊" ;;
    brigitte)                 echo "Brigitte — Management Intelligence 🧠" ;;
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
      fail "Windows detected. Use the PowerShell installer instead:\n\n    ${CYAN}irm https://unicolab.github.io/agentos/install.ps1 | iex${NC}\n\n    Or with a specific flavour:\n    ${CYAN}irm https://unicolab.github.io/agentos/install.ps1 | iex; Install-AgentOS -Flavour michelle${NC}\n\n    Or download manually:\n    ${CYAN}https://github.com/${REPO}/releases/latest${NC}"
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

# ─── Interactive Install (binary goes to CWD first, then user chooses) ───
install_binary() {
  SRC="$1"
  CWD_PATH="$(pwd)/${BINARY_NAME}"

  # If a custom install dir was specified via CLI, use it directly (non-interactive)
  if [ -n "$INSTALL_DIR" ]; then
    TARGET_DIR=$(eval echo "$INSTALL_DIR")  # Expand ~ and $HOME
    mkdir -p "$TARGET_DIR"
    cp "$SRC" "${TARGET_DIR}/${BINARY_NAME}"
    chmod +x "${TARGET_DIR}/${BINARY_NAME}"
    FINAL_DIR="$TARGET_DIR"
    # Also keep a copy in CWD for visibility
    cp "$SRC" "$CWD_PATH" 2>/dev/null && chmod +x "$CWD_PATH" || true
    success "Installed to ${BOLD}${TARGET_DIR}/${BINARY_NAME}${NC}"
    ensure_path "$TARGET_DIR"
    return 0
  fi

  # ── Step 1: Place binary in current working directory ──
  cp "$SRC" "$CWD_PATH"
  chmod +x "$CWD_PATH"
  success "Binary placed in ${BOLD}${CWD_PATH}${NC}"

  # ── Step 2: Ask user where to install ──
  SYSTEM_DIR="/usr/local/bin"
  USER_DIR="${HOME}/.local/bin"

  # Detect if running in piped mode (stdin is not a terminal)
  if [ ! -t 0 ]; then
    # Non-interactive (piped curl | sh) — auto-install to best location
    info "Non-interactive mode detected. Auto-selecting install location..."
    if [ -w "$SYSTEM_DIR" ]; then
      cp "$CWD_PATH" "${SYSTEM_DIR}/${BINARY_NAME}"
      FINAL_DIR="$SYSTEM_DIR"
      success "Also installed system-wide to ${BOLD}${SYSTEM_DIR}/${BINARY_NAME}${NC}"
    elif command -v sudo >/dev/null 2>&1 && sudo -n true 2>/dev/null; then
      sudo cp "$CWD_PATH" "${SYSTEM_DIR}/${BINARY_NAME}"
      FINAL_DIR="$SYSTEM_DIR"
      success "Also installed system-wide to ${BOLD}${SYSTEM_DIR}/${BINARY_NAME}${NC} (via sudo)"
    else
      mkdir -p "$USER_DIR"
      cp "$CWD_PATH" "${USER_DIR}/${BINARY_NAME}"
      FINAL_DIR="$USER_DIR"
      success "Also installed to ${BOLD}${USER_DIR}/${BINARY_NAME}${NC}"
      ensure_path "$USER_DIR"
    fi
    printf "\n"
    info "Binary is available in your current directory: ${BOLD}./${BINARY_NAME}${NC}"
    info "And system-wide at: ${BOLD}${FINAL_DIR}/${BINARY_NAME}${NC}"
    return 0
  fi

  # ── Interactive mode — present choices ──
  printf "\n"
  printf "  ${BOLD}Where would you like to install ${CYAN}${BINARY_NAME}${NC}${BOLD}?${NC}\n\n"
  printf "    ${BOLD}1)${NC}  ${GREEN}Keep here${NC} — use from current directory ${DIM}(${CWD_PATH})${NC}\n"
  printf "    ${BOLD}2)${NC}  ${GREEN}System-wide${NC} — install to ${BOLD}${SYSTEM_DIR}${NC} ${DIM}(requires admin)${NC}\n"
  printf "    ${BOLD}3)${NC}  ${GREEN}User-local${NC} — install to ${BOLD}${USER_DIR}${NC} ${DIM}(no admin needed)${NC}\n"
  printf "\n"
  printf "  ${DIM}Choice [1/2/3, default=2]:${NC} "
  read -r CHOICE </dev/tty 2>/dev/null || CHOICE=""

  case "${CHOICE:-2}" in
    1)
      # Keep in CWD only
      FINAL_DIR="$(pwd)"
      success "Keeping binary in ${BOLD}${CWD_PATH}${NC}"
      info "Run with: ${CYAN}./${BINARY_NAME} serve${NC}"
      ensure_path "$(pwd)"
      ;;
    2)
      # System-wide install (copy, keep CWD copy too)
      if [ -w "$SYSTEM_DIR" ]; then
        cp "$CWD_PATH" "${SYSTEM_DIR}/${BINARY_NAME}"
        FINAL_DIR="$SYSTEM_DIR"
        success "Installed to ${BOLD}${SYSTEM_DIR}/${BINARY_NAME}${NC}"
      elif command -v sudo >/dev/null 2>&1; then
        info "Admin password required for system-wide install."
        if sudo cp "$CWD_PATH" "${SYSTEM_DIR}/${BINARY_NAME}" 2>/dev/null; then
          FINAL_DIR="$SYSTEM_DIR"
          success "Installed to ${BOLD}${SYSTEM_DIR}/${BINARY_NAME}${NC}"
        else
          warn "Admin install failed. Falling back to user-local install."
          mkdir -p "$USER_DIR"
          cp "$CWD_PATH" "${USER_DIR}/${BINARY_NAME}"
          FINAL_DIR="$USER_DIR"
          success "Installed to ${BOLD}${USER_DIR}/${BINARY_NAME}${NC}"
          ensure_path "$USER_DIR"
        fi
      else
        warn "No sudo available. Falling back to user-local install."
        mkdir -p "$USER_DIR"
        cp "$CWD_PATH" "${USER_DIR}/${BINARY_NAME}"
        FINAL_DIR="$USER_DIR"
        success "Installed to ${BOLD}${USER_DIR}/${BINARY_NAME}${NC}"
        ensure_path "$USER_DIR"
      fi
      ;;
    3)
      # User-local install
      mkdir -p "$USER_DIR"
      cp "$CWD_PATH" "${USER_DIR}/${BINARY_NAME}"
      FINAL_DIR="$USER_DIR"
      success "Installed to ${BOLD}${USER_DIR}/${BINARY_NAME}${NC}"
      ensure_path "$USER_DIR"
      ;;
    *)
      warn "Invalid choice '${CHOICE}'. Keeping binary in current directory."
      FINAL_DIR="$(pwd)"
      ;;
  esac

  info "Local copy: ${BOLD}${CWD_PATH}${NC}"
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

# ─── Derive default binary name from flavour ───
flavour_to_local_name() {
  case "$1" in
    pm|aiflow-pm|jean-pierre) echo "agentos-pm" ;;
    michelle)                 echo "agentos-michelle" ;;
    brigitte)                 echo "agentos-brigitte" ;;
    freelancer)               echo "agentos-freelancer" ;;
    edith|sales)              echo "agentos-edith" ;;
    retail|retail-ops)        echo "agentos-retail" ;;
    office)                   echo "agentos-office" ;;
    *)                        echo "agentos-$1" ;;
  esac
}

# ─── Parse arguments ───
parse_args() {
  FLAVOUR="pm"
  INSTALL_DIR=""
  DEMO_MODE="false"
  USER_BINARY_NAME=""  # Empty means auto-derive from flavour

  while [ $# -gt 0 ]; do
    case "$1" in
      --flavour|--flavor|-f)
        if [ -n "$2" ]; then
          FLAVOUR="$2"
          shift 2
        else
          fail "--flavour requires a value.\n    Usage: curl ... | sh -s -- --flavour pm\n    Options: pm, jean-pierre, michelle, brigitte, all"
        fi
        ;;
      --binary-name|--name)
        if [ -n "$2" ]; then
          USER_BINARY_NAME="$2"
          shift 2
        else
          fail "--binary-name requires a value.\n    Usage: curl ... | sh -s -- --flavour michelle --binary-name my-agent"
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
      --demo)
        DEMO_MODE="true"
        shift
        ;;
      --help|-h)
        printf "\n${BOLD}AgentOS Installer${NC}\n\n"
        printf "  ${CYAN}Usage:${NC}\n"
        printf "    curl -fsSL https://unicolab.github.io/agentos/install.sh | sh\n"
        printf "    curl -fsSL https://unicolab.github.io/agentos/install.sh | sh -s -- --flavour michelle\n"
        printf "    curl -fsSL https://unicolab.github.io/agentos/install.sh | sh -s -- --flavour michelle --demo\n"
        printf "    curl -fsSL https://unicolab.github.io/agentos/install.sh | sh -s -- --flavour brigitte --binary-name my-brigitte\n"
        printf "    curl -fsSL https://unicolab.github.io/agentos/install.sh | sh -s -- --flavour all\n\n"
        printf "  ${CYAN}Options:${NC}\n"
        printf "    --flavour <name>        Select agent flavour (default: pm)\n"
        printf "    --binary-name <name>    Custom binary name (default: agentos-<flavour>)\n"
        printf "    --demo                  Provision demo data after install (Michelle)\n"
        printf "    --install-dir <path>    Install to a specific directory\n"
        printf "    --help                  Show this help message\n\n"
        printf "  ${CYAN}Available flavours:${NC}\n"
        printf "    ${BOLD}pm${NC}              Jean-Pierre — AI Project Management Copilot ${GREEN}(default)${NC}\n"
        printf "    ${BOLD}jean-pierre${NC}     Alias for pm\n"
        printf "    ${BOLD}michelle${NC}        Michelle — Analytics Intelligence Copilot\n"
        printf "    ${BOLD}brigitte${NC}        Brigitte — Management Intelligence Copilot\n"
        printf "    ${BOLD}all${NC}             Install ${BOLD}all${NC} three agents at once\n\n"
        printf "  ${CYAN}Multi-agent:${NC}\n"
        printf "    Each flavour installs as ${BOLD}agentos-<flavour>${NC} by default.\n"
        printf "    Multiple agents run side-by-side with isolated databases.\n"
        printf "    Ports auto-increment if the default (:18080) is occupied.\n\n"
        printf "    ${DIM}After installing multiple agents, use the ${BOLD}agentos${NC}${DIM} wrapper:${NC}\n"
        printf "      ${CYAN}agentos list${NC}               — show installed agents\n"
        printf "      ${CYAN}agentos start michelle${NC}      — start a specific agent\n\n"
        exit 0
        ;;
      *)
        shift
        ;;
    esac
  done

  # Set BINARY_NAME from user override or derive from flavour
  if [ -n "$USER_BINARY_NAME" ]; then
    BINARY_NAME="$USER_BINARY_NAME"
  else
    BINARY_NAME=$(flavour_to_local_name "$FLAVOUR")
  fi
}

# ─── Install the 'agentos' dispatcher wrapper ───
install_dispatcher() {
  DISPATCHER_DIR="$1"
  DISPATCHER="${DISPATCHER_DIR}/agentos"

  # Don't overwrite if it's a real binary (not our wrapper)
  if [ -f "$DISPATCHER" ]; then
    if ! head -1 "$DISPATCHER" 2>/dev/null | grep -q '^#!/' 2>/dev/null; then
      # It's a binary, not a script — skip
      return 0
    fi
  fi

  cat > "$DISPATCHER" << 'DISPATCHER_EOF'
#!/bin/sh
# ══════════════════════════════════════════════════════════════
#  AgentOS Fleet Manager — manage all installed agent flavours
#  Auto-generated by the AgentOS installer.
# ══════════════════════════════════════════════════════════════
set -e

# ─── Colors ───
E=$(printf '\033')
R="${E}[0;31m"; G="${E}[0;32m"; C="${E}[0;36m"; Y="${E}[1;33m"
B="${E}[1m"; D="${E}[2m"; W="${E}[0;37m"; N="${E}[0m"
MAG="${E}[0;35m"

# ─── Agent Discovery ───
SELF_DIR=$(cd "$(dirname "$0")" && pwd)

find_agents() {
  for f in "$SELF_DIR"/agentos-*; do
    [ -x "$f" ] || continue
    basename "$f" | sed 's/^agentos-//'
  done
}

agent_display_name() {
  case "$1" in
    pm)       echo "Jean-Pierre — PM 🎩" ;;
    michelle) echo "Michelle — Analytics 📊" ;;
    brigitte) echo "Brigitte — Management 🧠" ;;
    *)        echo "$1" ;;
  esac
}

agent_version() {
  BIN="$SELF_DIR/agentos-$1"
  if [ -x "$BIN" ]; then
    "$BIN" version 2>/dev/null | head -1 || echo "unknown"
  else
    echo "not installed"
  fi
}

agent_status() {
  BIN="$SELF_DIR/agentos-$1"
  if ! [ -x "$BIN" ]; then
    printf "${R}not installed${N}"
    return
  fi
  # Check if a process is running for this agent
  if pgrep -f "agentos-$1" >/dev/null 2>&1; then
    printf "${G}● running${N}"
  else
    printf "${D}○ stopped${N}"
  fi
}

# ─── Header ───
show_header() {
  printf "\n"
  printf "  ${B}${C}╔═══════════════════════════════════════════╗${N}\n"
  printf "  ${B}${C}║   ⬡  AgentOS Fleet Manager                ║${N}\n"
  printf "  ${B}${C}╚═══════════════════════════════════════════╝${N}\n"
  printf "\n"
}

# ─── Commands ───
cmd_list() {
  show_header
  AGENTS=$(find_agents)
  if [ -z "$AGENTS" ]; then
    printf "  ${Y}No agents installed.${N}\n"
    printf "  ${D}Install one: curl -fsSL https://unicolab.github.io/agentos/install.sh | sh${N}\n\n"
    return
  fi

  printf "  ${B}Installed Agents${N}\n"
  printf "  ${D}────────────────────────────────────────────${N}\n"

  for agent in $AGENTS; do
    NAME=$(agent_display_name "$agent")
    VER=$(agent_version "$agent")
    STATUS=$(agent_status "$agent")
    printf "  ${B}%-12s${N} %-35s ${D}%s${N}  %s\n" "$agent" "$NAME" "$VER" "$STATUS"
  done

  printf "  ${D}────────────────────────────────────────────${N}\n"
  printf "\n"
  printf "  ${D}Start an agent:   ${B}agentos start <name>${N}\n"
  printf "  ${D}Check status:     ${B}agentos status${N}\n"
  printf "  ${D}Stop an agent:    ${B}agentos stop <name>${N}\n"
  printf "\n"
}

cmd_start() {
  FLAVOR="$1"; shift
  BIN="$SELF_DIR/agentos-$FLAVOR"
  if [ ! -x "$BIN" ]; then
    printf "\n  ${R}✗${N}  Agent ${B}$FLAVOR${N} not found.\n\n"
    printf "  ${D}Installed agents:${N}\n"
    for a in $(find_agents); do
      printf "    ${C}•${N} $a  —  $(agent_display_name "$a")\n"
    done
    printf "\n  ${D}Install it: curl -fsSL https://unicolab.github.io/agentos/install.sh | sh -s -- --flavour $FLAVOR${N}\n\n"
    exit 1
  fi

  NAME=$(agent_display_name "$FLAVOR")
  printf "\n  ${C}▸${N}  Starting ${B}$NAME${N}...\n\n"
  exec "$BIN" serve "$@"
}

cmd_stop() {
  FLAVOR="$1"
  if pgrep -f "agentos-$FLAVOR" >/dev/null 2>&1; then
    pkill -f "agentos-$FLAVOR" 2>/dev/null || true
    printf "\n  ${G}✓${N}  Stopped ${B}$(agent_display_name "$FLAVOR")${N}\n\n"
  else
    printf "\n  ${D}○${N}  ${B}$(agent_display_name "$FLAVOR")${N} is not running.\n\n"
  fi
}

cmd_restart() {
  FLAVOR="$1"; shift
  cmd_stop "$FLAVOR"
  sleep 1
  cmd_start "$FLAVOR" "$@"
}

cmd_status() {
  show_header
  AGENTS=$(find_agents)
  if [ -z "$AGENTS" ]; then
    printf "  ${Y}No agents installed.${N}\n\n"
    return
  fi

  printf "  ${B}Agent Status${N}\n"
  printf "  ${D}────────────────────────────────────────────${N}\n"
  for agent in $AGENTS; do
    STATUS=$(agent_status "$agent")
    NAME=$(agent_display_name "$agent")
    printf "  %-12s %-30s %s\n" "$agent" "$NAME" "$STATUS"
  done
  printf "  ${D}────────────────────────────────────────────${N}\n\n"
}

cmd_help() {
  show_header
  printf "  ${B}Commands${N}\n"
  printf "  ${D}────────────────────────────────────────────${N}\n"
  printf "  ${C}list${N}                 Show all installed agents with status\n"
  printf "  ${C}start${N} ${D}<agent>${N}       Start an agent  ${D}(e.g., agentos start michelle)${N}\n"
  printf "  ${C}stop${N}  ${D}<agent>${N}       Stop a running agent\n"
  printf "  ${C}restart${N} ${D}<agent>${N}     Restart an agent\n"
  printf "  ${C}status${N}               Show running/stopped status of all agents\n"
  printf "  ${C}help${N}                 Show this help message\n"
  printf "  ${D}────────────────────────────────────────────${N}\n"
  printf "\n"
  printf "  ${B}Examples${N}\n"
  printf "  ${D}────────────────────────────────────────────${N}\n"
  printf "  ${W}\$ ${C}agentos list${N}                     ${D}# see what's installed${N}\n"
  printf "  ${W}\$ ${C}agentos start michelle${N}            ${D}# launch Michelle${N}\n"
  printf "  ${W}\$ ${C}agentos start brigitte${N}            ${D}# launch Brigitte (auto port)${N}\n"
  printf "  ${W}\$ ${C}agentos stop michelle${N}             ${D}# stop Michelle${N}\n"
  printf "  ${W}\$ ${C}agentos-michelle serve${N}            ${D}# run directly${N}\n"
  printf "  ${D}────────────────────────────────────────────${N}\n"
  printf "\n"
  printf "  ${B}Install more agents${N}\n"
  printf "  ${D}────────────────────────────────────────────${N}\n"
  printf "  ${W}\$ ${C}curl -fsSL https://unicolab.github.io/agentos/install.sh | sh -s -- --flavour michelle${N}\n"
  printf "  ${W}\$ ${C}curl -fsSL https://unicolab.github.io/agentos/install.sh | sh -s -- --flavour all${N}\n"
  printf "  ${D}────────────────────────────────────────────${N}\n"
  printf "\n"
  printf "  ${D}Each agent uses isolated storage (~/.agentos/<name>/) and auto-selects${N}\n"
  printf "  ${D}a free port if the default (:18080) is occupied.${N}\n"
  printf "\n"
  printf "  ${MAG}Need help?${N}  ${D}info@unicolab.ai${N}  •  ${D}https://unicolab.github.io/agentos/${N}\n\n"
}

# ─── Dispatch ───
case "${1:-}" in
  list|ls)       cmd_list ;;
  start|run)
    if [ -z "${2:-}" ]; then
      printf "\n  ${R}✗${N}  Missing agent name.\n\n"
      printf "  ${D}Usage:${N}  ${C}agentos start <agent>${N}\n"
      printf "  ${D}List:${N}   ${C}agentos list${N}\n\n"
      exit 1
    fi
    AGENT_NAME="$2"; shift 2
    cmd_start "$AGENT_NAME" "$@"
    ;;
  stop)
    if [ -z "${2:-}" ]; then
      printf "\n  ${R}✗${N}  Missing agent name.\n"
      printf "  ${D}Usage:${N}  ${C}agentos stop <agent>${N}\n\n"
      exit 1
    fi
    cmd_stop "$2"
    ;;
  restart)
    if [ -z "${2:-}" ]; then
      printf "\n  ${R}✗${N}  Missing agent name.\n"
      printf "  ${D}Usage:${N}  ${C}agentos restart <agent>${N}\n\n"
      exit 1
    fi
    AGENT_NAME="$2"; shift 2
    cmd_restart "$AGENT_NAME" "$@"
    ;;
  status|st)     cmd_status ;;
  help|--help|-h) cmd_help ;;
  "")            cmd_help ;;
  *)
    printf "\n  ${R}✗${N}  Unknown command: ${B}$1${N}\n\n"
    printf "  ${D}Available commands:${N}\n"
    printf "    ${C}list${N}  ${C}start${N}  ${C}stop${N}  ${C}restart${N}  ${C}status${N}  ${C}help${N}\n\n"
    printf "  ${D}Try:${N}  ${C}agentos help${N}\n\n"
    exit 1
    ;;
esac
DISPATCHER_EOF

  chmod +x "$DISPATCHER"
  success "Installed ${BOLD}agentos${NC} fleet dispatcher to ${BOLD}${DISPATCHER_DIR}${NC}"
}

# ─── Install all flavours ───
ALL_FLAVOURS="pm michelle brigitte"

install_all_flavours() {
  header
  info "${BOLD}Installing ALL agent flavours${NC}: ${CYAN}${ALL_FLAVOURS}${NC}"
  printf "\n"

  SCRIPT_PATH="$0"
  EXTRA_ARGS=""
  if [ -n "$INSTALL_DIR" ]; then
    EXTRA_ARGS="$EXTRA_ARGS --install-dir $INSTALL_DIR"
  fi

  for FLAV in $ALL_FLAVOURS; do
    printf "\n"
    printf "%s\n" "${BOLD}${CYAN}  ── Installing ${FLAV} ──${NC}"
    # Re-invoke ourself for each flavour (avoids state leakage)
    sh "$SCRIPT_PATH" --flavour "$FLAV" $EXTRA_ARGS 2>&1 | grep -v "^$" | sed 's/^/    /' || true
  done

  printf "\n"
  printf "%s\n" "${BOLD}${GREEN}  ╔══════════════════════════════════════════╗${NC}"
  printf "%s\n" "${BOLD}${GREEN}  ║   🎉 All Agents Installed!               ║${NC}"
  printf "%s\n" "${BOLD}${GREEN}  ╚══════════════════════════════════════════╝${NC}"
  printf "\n"
  printf "  ${CYAN}Installed agents:${NC}\n"
  for FLAV in $ALL_FLAVOURS; do
    printf "    • ${BOLD}agentos-${FLAV}${NC}  —  $(flavour_display_name "$FLAV")\n"
  done
  printf "\n"
  printf "  ${DIM}Fleet manager: ${BOLD}agentos list${NC} | ${BOLD}agentos start <flavour>${NC}\n"
  printf "\n"
}

# ─── Main ───
main() {
  parse_args "$@"

  # Handle --flavour all
  if [ "$FLAVOUR" = "all" ]; then
    install_all_flavours
    exit 0
  fi

  header

  # Resolve flavour-specific archive name
  SOURCE_BINARY=$(flavour_to_binary "$FLAVOUR")
  DISPLAY_NAME=$(flavour_display_name "$FLAVOUR")
  info "Flavour:  ${BOLD}${DISPLAY_NAME}${NC} → archive ${CYAN}${SOURCE_BINARY}${NC}"
  info "Binary:   ${BOLD}${BINARY_NAME}${NC} (per-flavour isolated binary)"
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

  # Rename flavour binary → target name (agentos-<flavor> or user-specified)
  if [ -f "${WORK}/${SOURCE_BINARY}" ]; then
    mv "${WORK}/${SOURCE_BINARY}" "${WORK}/${BINARY_NAME}"
    if [ "${SOURCE_BINARY}" != "${BINARY_NAME}" ]; then
      info "Renamed ${SOURCE_BINARY} → ${BINARY_NAME}"
    fi
  fi

  # Verify binary exists after extraction
  if [ ! -f "${WORK}/${BINARY_NAME}" ]; then
    # List what was extracted for debugging
    EXTRACTED=$(ls -1 "${WORK}" 2>/dev/null | grep -v '\.tar\.gz$' | head -10)
    fail "Binary ${BOLD}${BINARY_NAME}${NC} not found after extraction.\n\n    Expected: ${BOLD}${SOURCE_BINARY}${NC} or ${BOLD}${BINARY_NAME}${NC}\n    Found:    ${DIM}${EXTRACTED:-nothing}${NC}\n\n    The archive structure may have changed. Try extracting manually:\n      ${CYAN}tar xzf ${ARCHIVE} && ls -la${NC}"
  fi

  # ── Conflict detection ──
  # Check if a binary with this name already exists in the target directory
  CHECK_DIRS="/usr/local/bin ${HOME}/.local/bin"
  if [ -n "$INSTALL_DIR" ]; then
    CHECK_DIRS=$(eval echo "$INSTALL_DIR")
  fi
  for CHECK_DIR in $CHECK_DIRS; do
    EXISTING="${CHECK_DIR}/${BINARY_NAME}"
    if [ -x "$EXISTING" ]; then
      EXISTING_VER=$("$EXISTING" version 2>/dev/null || echo "unknown")
      warn "Existing binary found: ${BOLD}${EXISTING}${NC} (${EXISTING_VER})"
      info "This will be ${BOLD}overwritten${NC} with the new version."
      info "If you want to keep both, re-run with: ${CYAN}--binary-name <custom-name>${NC}"
      printf "\n"
      break
    fi
  done

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
  CWD_BIN="$(pwd)/${BINARY_NAME}"
  if command -v "${BINARY_NAME}" >/dev/null 2>&1; then
    INSTALLED_VERSION=$("${BINARY_NAME}" version 2>/dev/null || echo "installed")
    success "${BOLD}AgentOS${NC} ${DISPLAY_NAME} ${INSTALLED_VERSION}"
  elif [ -x "${FINAL_DIR}/${BINARY_NAME}" ]; then
    INSTALLED_VERSION=$("${FINAL_DIR}/${BINARY_NAME}" version 2>/dev/null || echo "installed")
    success "${BOLD}AgentOS${NC} ${DISPLAY_NAME} ${INSTALLED_VERSION}"
  elif [ -x "$CWD_BIN" ]; then
    INSTALLED_VERSION=$("$CWD_BIN" version 2>/dev/null || echo "installed")
    success "${BOLD}AgentOS${NC} ${DISPLAY_NAME} ${INSTALLED_VERSION}"
  else
    warn "Binary installed but not in PATH. Run it directly:"
    printf "    ${CYAN}./${BINARY_NAME} serve${NC}\n"
    warn "Or restart your terminal to pick up PATH changes."
  fi

  # Install the fleet dispatcher wrapper (creates/updates 'agentos' command)
  if [ -n "$FINAL_DIR" ]; then
    install_dispatcher "$FINAL_DIR"
  fi

  # Summary
  printf "\n"
  printf "%s\n" "${BOLD}${GREEN}  ╔══════════════════════════════════╗${NC}"
  printf "%s\n" "${BOLD}${GREEN}  ║   🎉 Installation Complete!      ║${NC}"
  printf "%s\n" "${BOLD}${GREEN}  ╚══════════════════════════════════╝${NC}"
  printf "\n"
  printf "  ${YELLOW}Flavour:${NC}       ${BOLD}${DISPLAY_NAME}${NC}\n"
  printf "  ${YELLOW}Binary:${NC}        ${BOLD}${BINARY_NAME}${NC}\n"
  printf "  ${YELLOW}Data dir:${NC}      ${BOLD}~/.agentos/${FLAVOUR}/${NC} (isolated)\n"
  printf "  ${YELLOW}Need a license?${NC} Email ${BOLD}info@unicolab.ai${NC}\n"
  printf "  ${CYAN}Documentation:${NC}  https://unicolab.github.io/agentos/\n"
  printf "\n"
  printf "  ${DIM}Run directly:  ${BOLD}${BINARY_NAME} serve${NC}\n"
  printf "  ${DIM}Fleet manager: ${BOLD}agentos list${NC} | ${BOLD}agentos start ${FLAVOUR}${NC}\n"
  printf "\n"

  # Auto-launch (with optional demo provisioning for Michelle)
  # ── Resolve best binary path for launch ──
  LAUNCH_BIN=""
  if command -v "${BINARY_NAME}" >/dev/null 2>&1; then
    LAUNCH_BIN="${BINARY_NAME}"
  elif [ -n "$FINAL_DIR" ] && [ -x "${FINAL_DIR}/${BINARY_NAME}" ]; then
    LAUNCH_BIN="${FINAL_DIR}/${BINARY_NAME}"
  elif [ -x "$(pwd)/${BINARY_NAME}" ]; then
    LAUNCH_BIN="$(pwd)/${BINARY_NAME}"
  else
    warn "Cannot locate ${BINARY_NAME} to auto-launch."
    info "Run manually: ${CYAN}./${BINARY_NAME} serve${NC}"
    exit 0
  fi

  # Auto-launch (with optional demo provisioning for Michelle)
  if [ "$DEMO_MODE" = "true" ] && [ "$FLAVOUR" = "michelle" ]; then
    info "Starting AgentOS with demo mode... ${DIM}(Ctrl+C to stop)${NC}"
    printf "\n"

    "${LAUNCH_BIN}" serve &
    SERVER_PID=$!

    # Wait for server to be healthy (max 30s)
    step "Waiting for server to be ready..."
    RETRIES=0
    while [ $RETRIES -lt 30 ]; do
      if curl -s -o /dev/null http://localhost:18080/healthz 2>/dev/null; then
        break
      fi
      RETRIES=$((RETRIES + 1))
      sleep 1
    done

    if [ $RETRIES -ge 30 ]; then
      warn "Server didn't start in time. Demo provisioning skipped."
      warn "Run manually: ${BINARY_NAME} demo setup"
    else
      step "Provisioning Michelle demo data..."
      DEMO_RESULT=$(curl -s -X POST http://localhost:18080/v1/michelle/demo/demo-ecommerce 2>/dev/null || echo '{"status":"error"}')
      DEMO_STATUS=$(echo "$DEMO_RESULT" | python3 -c 'import sys,json; print(json.load(sys.stdin).get("status","error"))' 2>/dev/null || echo "error")
      if [ "$DEMO_STATUS" = "created" ]; then
        success "Demo mode provisioned! E-commerce database + full analytics context ready."
        printf "\n"
        printf "  ${CYAN}Try these questions in Michelle:${NC}\n"
        printf "    ${DIM}• \"What is the total revenue?\"${NC}\n"
        printf "    ${DIM}• \"Show me top 10 products by quantity sold\"${NC}\n"
        printf "    ${DIM}• \"Compare revenue by sales channel\"${NC}\n"
        printf "\n"
        printf "  ${DIM}Remove demo: ${BINARY_NAME} demo remove${NC}\n"
      else
        warn "Demo provisioning returned: $DEMO_STATUS"
        warn "Try manually: ${BINARY_NAME} demo setup"
      fi
    fi

    # Bring server to foreground
    printf "\n"
    info "AgentOS is running... ${DIM}(Ctrl+C to stop)${NC}"
    wait $SERVER_PID
  else
    info "Starting AgentOS... ${DIM}(Ctrl+C to stop)${NC}"
    printf "\n"
    "${LAUNCH_BIN}" serve
  fi
}

main "$@"

