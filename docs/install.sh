#!/bin/sh
# ──────────────────────────────────────────────────────────────
#  AgentOS — Universal Installer
#
#  Default (PM flavor):
#    curl -fsSL https://unicolab.github.io/agentos/install.sh | sh
#
#  Choose a flavor:
#    curl -fsSL https://unicolab.github.io/agentos/install.sh | sh -s -- --flavour retail
#    curl -fsSL https://unicolab.github.io/agentos/install.sh | sh -s -- --flavour office
#
#  Available flavours:
#    pm      — Jean-Pierre, AI Project Management Copilot (default)
#    retail  — Retail Operations Assistant
#    office  — Office Productivity Assistant
#
#  Features:
#    • Auto-detects OS (macOS/Linux) and architecture (arm64/amd64)
#    • Selects the correct per-flavour binary
#    • macOS: clears Gatekeeper quarantine + ad-hoc code signs
#    • Installs to /usr/local/bin (admin) or ~/.local/bin (no admin)
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
    pm|aiflow-pm)   echo "agentos-pm" ;;
    retail|retail-ops) echo "agentos-retail" ;;
    office)         echo "agentos-office" ;;
    *)
      fail "Unknown flavour: ${BOLD}$1${NC}\n\n    Available flavours:\n      ${CYAN}pm${NC}      — Jean-Pierre, AI Project Management Copilot (default)\n      ${CYAN}retail${NC}  — Retail Operations Assistant\n      ${CYAN}office${NC}  — Office Productivity Assistant\n\n    Usage: curl -fsSL https://unicolab.github.io/agentos/install.sh | sh -s -- --flavour pm"
      ;;
  esac
}

flavour_display_name() {
  case "$1" in
    pm|aiflow-pm)      echo "Jean-Pierre — The PM 🎩" ;;
    retail|retail-ops)  echo "Retail Ops 🛒" ;;
    office)            echo "Office Assistant 🏢" ;;
    *)                 echo "$1" ;;
  esac
}

# ─── Colors ───
ESC=$(printf '\033')
RED="${ESC}[0;31m"; GREEN="${ESC}[0;32m"; CYAN="${ESC}[0;36m"
YELLOW="${ESC}[1;33m"; BOLD="${ESC}[1m"; DIM="${ESC}[2m"; NC="${ESC}[0m"

# ─── Logging ───
info()    { printf "%s\n" "${CYAN}ℹ${NC}  $1"; }
success() { printf "%s\n" "${GREEN}✅${NC} $1"; }
warn()    { printf "%s\n" "${YELLOW}⚠️${NC}  $1"; }
fail()    { printf "%s\n" "${RED}❌${NC} $1"; exit 1; }

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
    fail "Neither ${BOLD}curl${NC} nor ${BOLD}wget${NC} found. Please install one:\n    macOS:  brew install curl\n    Linux:  sudo apt install curl"
  fi

  if ! command -v tar >/dev/null 2>&1; then
    fail "${BOLD}tar${NC} not found. Please install it:\n    Linux:  sudo apt install tar"
  fi
}

# ─── HTTP GET helper (works with curl or wget) ───
http_get() {
  URL="$1"
  OUTPUT="$2"
  if command -v curl >/dev/null 2>&1; then
    if [ -n "$OUTPUT" ]; then
      curl -fsSL "$URL" -o "$OUTPUT"
    else
      curl -fsSL "$URL"
    fi
  elif command -v wget >/dev/null 2>&1; then
    if [ -n "$OUTPUT" ]; then
      wget -q "$URL" -O "$OUTPUT"
    else
      wget -qO- "$URL"
    fi
  fi
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

# ─── Fetch latest version (handles pre-releases) ───
get_latest_version() {
  TAG=""

  # Try stable releases first
  TAG=$(http_get "https://api.github.com/repos/${REPO}/releases/latest" "" 2>/dev/null \
    | grep '"tag_name"' | head -1 | sed 's/.*"tag_name": *"//;s/".*//' || true)

  # Fallback: include pre-releases
  if [ -z "$TAG" ]; then
    TAG=$(http_get "https://api.github.com/repos/${REPO}/releases" "" 2>/dev/null \
      | grep '"tag_name"' | head -1 | sed 's/.*"tag_name": *"//;s/".*//' || true)
  fi

  if [ -z "$TAG" ]; then
    fail "Could not determine latest version.\n    Check: ${CYAN}https://github.com/${REPO}/releases${NC}\n    This may be a network issue or GitHub API rate limiting."
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

  while [ $# -gt 0 ]; do
    case "$1" in
      --flavour|--flavor|-f)
        if [ -n "$2" ]; then
          FLAVOUR="$2"
          shift 2
        else
          fail "--flavour requires a value.\n    Usage: curl ... | sh -s -- --flavour pm\n    Options: pm, retail, office"
        fi
        ;;
      --help|-h)
        printf "\n${BOLD}AgentOS Installer${NC}\n\n"
        printf "  ${CYAN}Usage:${NC}\n"
        printf "    curl -fsSL https://unicolab.github.io/agentos/install.sh | sh\n"
        printf "    curl -fsSL https://unicolab.github.io/agentos/install.sh | sh -s -- --flavour retail\n\n"
        printf "  ${CYAN}Options:${NC}\n"
        printf "    --flavour <name>   Select agent flavour (default: pm)\n"
        printf "    --help             Show this help message\n\n"
        printf "  ${CYAN}Available flavours:${NC}\n"
        printf "    ${BOLD}pm${NC}       Jean-Pierre — AI Project Management Copilot ${GREEN}(default)${NC}\n"
        printf "    ${BOLD}retail${NC}   Retail Operations Assistant\n"
        printf "    ${BOLD}office${NC}   Office Productivity Assistant\n\n"
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

  check_dependencies

  # Detect platform
  OS=$(detect_os)
  ARCH=$(detect_arch)
  info "Platform: ${BOLD}${OS}/${ARCH}${NC}"

  # Resolve version
  info "Fetching latest release..."
  VERSION=$(get_latest_version)
  info "Version:  ${BOLD}${VERSION}${NC}"

  # Download — archive naming: agentos-pm_v0.12.0_darwin_arm64.tar.gz
  VERSION_NUM="${VERSION#v}"
  ARCHIVE="${SOURCE_BINARY}_v${VERSION_NUM}_${OS}_${ARCH}.tar.gz"
  URL="https://github.com/${REPO}/releases/download/${VERSION}/${ARCHIVE}"

  WORK=$(mktemp -d)
  trap 'rm -rf "$WORK"' EXIT

  info "Downloading ${BOLD}${ARCHIVE}${NC}..."
  http_get "$URL" "${WORK}/${ARCHIVE}" || fail "Download failed.\n    URL: ${CYAN}${URL}${NC}\n    Check your internet connection or try downloading manually.\n\n    💡 If the flavour-specific archive is not found, try:\n       ${CYAN}curl -fsSL https://unicolab.github.io/agentos/install.sh | sh -s -- --flavour pm${NC}"
  success "Downloaded"

  # Extract
  info "Extracting..."
  tar xzf "${WORK}/${ARCHIVE}" -C "${WORK}" || fail "Extraction failed. The archive may be corrupted.\n    Try downloading again from: ${CYAN}https://github.com/${REPO}/releases${NC}"
  success "Extracted"

  # Rename flavour binary → agentos (so all commands stay compatible)
  if [ "${SOURCE_BINARY}" != "${BINARY_NAME}" ] && [ -f "${WORK}/${SOURCE_BINARY}" ]; then
    mv "${WORK}/${SOURCE_BINARY}" "${WORK}/${BINARY_NAME}"
    info "Renamed ${SOURCE_BINARY} → ${BINARY_NAME}"
  fi

  # macOS: Gatekeeper clearance
  if [ "$OS" = "darwin" ]; then
    macos_security "${WORK}/${BINARY_NAME}"
  fi

  # Make executable
  chmod +x "${WORK}/${BINARY_NAME}"

  # Install with smart fallback
  FINAL_DIR=""
  install_binary "${WORK}/${BINARY_NAME}"

  # Verify installation
  printf "\n"
  if command -v "${BINARY_NAME}" >/dev/null 2>&1; then
    INSTALLED_VERSION=$("${BINARY_NAME}" version 2>/dev/null || echo "installed")
    success "${BOLD}AgentOS${NC} ${DISPLAY_NAME} ${INSTALLED_VERSION}"
  elif [ -x "${FINAL_DIR}/${BINARY_NAME}" ]; then
    INSTALLED_VERSION=$("${FINAL_DIR}/${BINARY_NAME}" version 2>/dev/null || echo "installed")
    success "${BOLD}AgentOS${NC} ${DISPLAY_NAME} ${INSTALLED_VERSION}"
  else
    warn "Binary installed but not in PATH. Run it directly:"
    printf "    ${CYAN}${FINAL_DIR}/${BINARY_NAME} serve${NC}\n"
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
