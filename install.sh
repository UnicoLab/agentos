#!/bin/sh
# ─────────────────────────────────────────────────────
#  AgentOS — One-Line Installer
#  curl -fsSL https://unicolab.github.io/agentos/install.sh | sh
# ─────────────────────────────────────────────────────
set -e

REPO="UnicoLab/agentos"
INSTALL_DIR="/usr/local/bin"
BINARY_NAME="agentos"

# ─── Colors (actual escape bytes, not literals) ───
ESC=$(printf '\033')
RED="${ESC}[0;31m"
GREEN="${ESC}[0;32m"
CYAN="${ESC}[0;36m"
YELLOW="${ESC}[1;33m"
BOLD="${ESC}[1m"
NC="${ESC}[0m"

info()    { printf "%s\n" "${CYAN}ℹ${NC}  $1"; }
success() { printf "%s\n" "${GREEN}✅${NC} $1"; }
warn()    { printf "%s\n" "${YELLOW}⚠️${NC}  $1"; }
error()   { printf "%s\n" "${RED}❌${NC} $1"; exit 1; }

# ─── Detect OS ───
detect_os() {
  case "$(uname -s)" in
    Darwin*)  echo "darwin" ;;
    Linux*)   echo "linux"  ;;
    MINGW*|MSYS*|CYGWIN*) error "Windows detected. Download the .zip from GitHub Releases." ;;
    *)        error "Unsupported OS: $(uname -s)" ;;
  esac
}

# ─── Detect Architecture ───
detect_arch() {
  case "$(uname -m)" in
    x86_64|amd64)   echo "amd64" ;;
    arm64|aarch64)   echo "arm64" ;;
    i386|i686)       error "32-bit systems are not supported." ;;
    *)               error "Unsupported architecture: $(uname -m)" ;;
  esac
}

# ─── Fetch latest version tag (handles pre-releases) ───
get_latest_version() {
  TAG=""

  # Try stable release first
  TAG=$(curl -fsSL "https://api.github.com/repos/${REPO}/releases/latest" 2>/dev/null \
    | grep '"tag_name"' | head -1 | sed 's/.*"tag_name": *"//;s/".*//' || true)

  # Fallback: most recent release including pre-releases
  if [ -z "$TAG" ]; then
    TAG=$(curl -fsSL "https://api.github.com/repos/${REPO}/releases" 2>/dev/null \
      | grep '"tag_name"' | head -1 | sed 's/.*"tag_name": *"//;s/".*//' || true)
  fi

  echo "$TAG"
}

# ─── Main ───
main() {
  printf "\n${BOLD}${CYAN}  ⬡  AgentOS Installer${NC}\n"
  printf "${CYAN}  ─────────────────────${NC}\n\n"

  OS=$(detect_os)
  ARCH=$(detect_arch)
  info "Detected: ${BOLD}${OS}/${ARCH}${NC}"

  info "Fetching latest release..."
  VERSION=$(get_latest_version)
  if [ -z "$VERSION" ]; then
    error "Could not determine latest version. Check https://github.com/${REPO}/releases"
  fi
  info "Latest version: ${BOLD}${VERSION}${NC}"

  # Build download URL
  VERSION_NUM="${VERSION#v}"
  ARCHIVE="agentos_${VERSION_NUM}_${OS}_${ARCH}.tar.gz"
  URL="https://github.com/${REPO}/releases/download/${VERSION}/${ARCHIVE}"

  # Download
  WORK=$(mktemp -d)
  info "Downloading ${BOLD}${ARCHIVE}${NC}..."
  curl -fsSL "$URL" -o "${WORK}/${ARCHIVE}" || error "Download failed. URL: ${URL}"
  success "Downloaded"

  # Extract
  info "Extracting..."
  tar xzf "${WORK}/${ARCHIVE}" -C "${WORK}"
  success "Extracted"

  # macOS: Remove quarantine and ad-hoc sign
  if [ "$OS" = "darwin" ]; then
    info "Clearing macOS Gatekeeper restrictions..."
    xattr -rd com.apple.quarantine "${WORK}/${BINARY_NAME}" 2>/dev/null || true
    codesign --force --sign - "${WORK}/${BINARY_NAME}" 2>/dev/null || true
    success "macOS security cleared"
  fi

  chmod +x "${WORK}/${BINARY_NAME}"

  # Install — try system dir, fallback to user dir (no admin needed)
  if [ -w "${INSTALL_DIR}" ]; then
    mv "${WORK}/${BINARY_NAME}" "${INSTALL_DIR}/${BINARY_NAME}"
    success "Installed to ${BOLD}${INSTALL_DIR}/${BINARY_NAME}${NC}"
  elif sudo -n true 2>/dev/null; then
    sudo mv "${WORK}/${BINARY_NAME}" "${INSTALL_DIR}/${BINARY_NAME}"
    success "Installed to ${BOLD}${INSTALL_DIR}/${BINARY_NAME}${NC}"
  else
    USER_BIN="${HOME}/.local/bin"
    mkdir -p "${USER_BIN}"
    mv "${WORK}/${BINARY_NAME}" "${USER_BIN}/${BINARY_NAME}"
    INSTALL_DIR="${USER_BIN}"
    success "Installed to ${BOLD}${USER_BIN}/${BINARY_NAME}${NC} (no admin required)"
    case ":${PATH}:" in
      *":${USER_BIN}:"*) ;;
      *)
        warn "Add to your shell profile:"
        printf "    export PATH=\"%s:\$PATH\"\n" "${USER_BIN}"
        export PATH="${USER_BIN}:${PATH}"
        ;;
    esac
  fi

  # Verify
  if command -v "${BINARY_NAME}" >/dev/null 2>&1; then
    INSTALLED_VERSION=$("${BINARY_NAME}" version 2>/dev/null || echo "installed")
    success "AgentOS ${INSTALLED_VERSION} is ready!"
  fi

  rm -rf "${WORK}"

  printf "\n${BOLD}${GREEN}  🎉 Installation complete!${NC}\n\n"
  printf "  ${YELLOW}Need a license?${NC} Email ${BOLD}info@unicolab.ai${NC}\n"
  printf "  ${CYAN}Docs:${NC} https://unicolab.github.io/agentos/\n\n"

  # Auto-launch AgentOS
  printf "  ${BOLD}Starting AgentOS...${NC}\n\n"
  "${INSTALL_DIR}/${BINARY_NAME}" serve
}

main "$@"
