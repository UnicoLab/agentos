#!/bin/sh
# ─────────────────────────────────────────────────────
#  AgentOS — One-Line Installer
#  curl -fsSL https://unicolab.github.io/agentos/install.sh | sh
# ─────────────────────────────────────────────────────
set -e

REPO="UnicoLab/agentos"
INSTALL_DIR="/usr/local/bin"
BINARY_NAME="agentos"

# ─── Colors ───
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
BOLD='\033[1m'
NC='\033[0m' # No Color

info()    { printf "${CYAN}ℹ${NC}  %s\n" "$1"; }
success() { printf "${GREEN}✅${NC} %s\n" "$1"; }
warn()    { printf "${YELLOW}⚠️${NC}  %s\n" "$1"; }
error()   { printf "${RED}❌${NC} %s\n" "$1"; exit 1; }

# ─── Detect OS ───
detect_os() {
  case "$(uname -s)" in
    Darwin*)  echo "darwin" ;;
    Linux*)   echo "linux"  ;;
    MINGW*|MSYS*|CYGWIN*) error "Windows detected. Please download the .zip manually from GitHub Releases." ;;
    *)        error "Unsupported operating system: $(uname -s)" ;;
  esac
}

# ─── Detect Architecture ───
detect_arch() {
  case "$(uname -m)" in
    x86_64|amd64)   echo "amd64" ;;
    arm64|aarch64)   echo "arm64" ;;
    i386|i686)       error "32-bit systems are not supported. AgentOS requires a 64-bit OS." ;;
    *)               error "Unsupported architecture: $(uname -m)" ;;
  esac
}

# ─── Fetch latest version tag ───
get_latest_version() {
  if command -v curl >/dev/null 2>&1; then
    curl -fsSL -o /dev/null -w '%{redirect_url}' "https://github.com/${REPO}/releases/latest" | grep -oE 'v[0-9]+\.[0-9]+\.[0-9]+[^ ]*'
  elif command -v wget >/dev/null 2>&1; then
    wget -qO- --server-response "https://github.com/${REPO}/releases/latest" 2>&1 | grep -i location | grep -oE 'v[0-9]+\.[0-9]+\.[0-9]+[^ ]*'
  else
    error "Neither curl nor wget found. Please install one of them."
  fi
}

# ─── Main ───
main() {
  printf "\n${BOLD}${CYAN}"
  printf "  ⬡  AgentOS Installer\n"
  printf "  ─────────────────────\n"
  printf "${NC}\n"

  OS=$(detect_os)
  ARCH=$(detect_arch)
  info "Detected: ${BOLD}${OS}/${ARCH}${NC}"

  # Get latest version
  info "Fetching latest release..."
  VERSION=$(get_latest_version)
  if [ -z "$VERSION" ]; then
    error "Could not determine latest version. Check https://github.com/${REPO}/releases"
  fi
  info "Latest version: ${BOLD}${VERSION}${NC}"

  # Build download URL
  VERSION_NUM="${VERSION#v}"  # strip leading 'v'
  ARCHIVE="agentos_${VERSION_NUM}_${OS}_${ARCH}.tar.gz"
  URL="https://github.com/${REPO}/releases/download/${VERSION}/${ARCHIVE}"

  # Download
  TMPDIR=$(mktemp -d)
  info "Downloading ${BOLD}${ARCHIVE}${NC}..."
  if command -v curl >/dev/null 2>&1; then
    curl -fsSL "$URL" -o "${TMPDIR}/${ARCHIVE}" || error "Download failed. URL: ${URL}"
  else
    wget -q "$URL" -O "${TMPDIR}/${ARCHIVE}" || error "Download failed. URL: ${URL}"
  fi
  success "Downloaded successfully"

  # Extract
  info "Extracting..."
  tar xzf "${TMPDIR}/${ARCHIVE}" -C "${TMPDIR}"
  success "Extracted"

  # macOS: Remove quarantine and ad-hoc sign
  if [ "$OS" = "darwin" ]; then
    info "Clearing macOS quarantine flag..."
    xattr -rd com.apple.quarantine "${TMPDIR}/${BINARY_NAME}" 2>/dev/null || true

    info "Ad-hoc signing binary for Gatekeeper..."
    codesign --force --sign - "${TMPDIR}/${BINARY_NAME}" 2>/dev/null || true
    success "macOS security cleared"
  fi

  # Make executable
  chmod +x "${TMPDIR}/${BINARY_NAME}"

  # Install to PATH
  info "Installing to ${BOLD}${INSTALL_DIR}/${BINARY_NAME}${NC}..."
  if [ -w "${INSTALL_DIR}" ]; then
    mv "${TMPDIR}/${BINARY_NAME}" "${INSTALL_DIR}/${BINARY_NAME}"
  else
    warn "Elevated permissions required for ${INSTALL_DIR}"
    sudo mv "${TMPDIR}/${BINARY_NAME}" "${INSTALL_DIR}/${BINARY_NAME}"
  fi
  success "Installed to ${INSTALL_DIR}/${BINARY_NAME}"

  # Verify
  if command -v "${BINARY_NAME}" >/dev/null 2>&1; then
    INSTALLED_VERSION=$("${BINARY_NAME}" version 2>/dev/null || echo "unknown")
    success "AgentOS ${INSTALLED_VERSION} is ready!"
  else
    warn "${INSTALL_DIR} may not be in your PATH. Add it with:"
    echo "    export PATH=\"${INSTALL_DIR}:\$PATH\""
  fi

  # Cleanup
  rm -rf "${TMPDIR}"

  # Done!
  printf "\n${BOLD}${GREEN}"
  printf "  🎉 Installation complete!\n"
  printf "${NC}\n"
  printf "  ${BOLD}Next steps:${NC}\n"
  printf "    1. Run:  ${CYAN}agentos serve${NC}\n"
  printf "    2. Open: ${CYAN}http://localhost:18080${NC}\n"
  printf "    3. Configure everything in the ${BOLD}Web UI Settings${NC}\n"
  printf "\n"
  printf "  ${YELLOW}Need a license key?${NC} Email ${BOLD}info@unicolab.ai${NC}\n"
  printf "  ${CYAN}Docs:${NC} https://unicolab.github.io/agentos/\n"
  printf "\n"
}

main "$@"
