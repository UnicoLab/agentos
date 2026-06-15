#!/bin/sh
# ──────────────────────────────────────────────────────────────
#  AgentOS — macOS Security Fix
#
#  Clears Gatekeeper quarantine and makes the binary executable.
#  Run this if macOS blocks AgentOS after a manual download.
#
#  Usage:
#    curl -fsSL https://unicolab.github.io/agentos/fix-macos.sh | sh
#
#  Or if you have the binary in a specific location:
#    sh fix-macos.sh /path/to/agentos
#
# ──────────────────────────────────────────────────────────────
set -e

ESC=$(printf '\033')
GREEN="${ESC}[0;32m"; CYAN="${ESC}[0;36m"; YELLOW="${ESC}[1;33m"
RED="${ESC}[0;31m"; BOLD="${ESC}[1m"; DIM="${ESC}[2m"; NC="${ESC}[0m"

printf "\n"
printf "%s\n" "${BOLD}${CYAN}  ╔══════════════════════════════════╗${NC}"
printf "%s\n" "${BOLD}${CYAN}  ║   ⬡  AgentOS — macOS Fix        ║${NC}"
printf "%s\n" "${BOLD}${CYAN}  ╚══════════════════════════════════╝${NC}"
printf "\n"

# ─── Find the binary ───
BINARY=""

if [ -n "$1" ]; then
  # User specified a path
  BINARY="$1"
elif [ -f "./agentos" ]; then
  BINARY="./agentos"
elif [ -f "./agentos-pm" ]; then
  BINARY="./agentos-pm"
elif [ -f "./agentos-michelle" ]; then
  BINARY="./agentos-michelle"
elif [ -f "./agentos-brigitte" ]; then
  BINARY="./agentos-brigitte"
else
  # Search common install locations
  for dir in /usr/local/bin "$HOME/.local/bin" "$HOME/Downloads"; do
    for name in agentos agentos-pm agentos-michelle agentos-brigitte; do
      if [ -f "$dir/$name" ]; then
        BINARY="$dir/$name"
        break 2
      fi
    done
  done
fi

if [ -z "$BINARY" ] || [ ! -f "$BINARY" ]; then
  printf "  ${RED}❌ No AgentOS binary found.${NC}\n\n"
  printf "  ${DIM}Usage: sh fix-macos.sh /path/to/agentos${NC}\n"
  printf "  ${DIM}Or run this script from the folder containing the binary.${NC}\n\n"
  exit 1
fi

BINARY=$(cd "$(dirname "$BINARY")" && pwd)/$(basename "$BINARY")
printf "  ${CYAN}ℹ${NC}  Found binary: ${BOLD}%s${NC}\n" "$BINARY"

# ─── Step 1: Remove quarantine flag ───
printf "  ${CYAN}[1]${NC} Removing quarantine flag...\n"
xattr -rd com.apple.quarantine "$BINARY" 2>/dev/null || true

# Also fix launcher scripts if they exist in the same directory
DIR=$(dirname "$BINARY")
for f in "$DIR/Start AgentOS.command" "$DIR/start-agentos.sh"; do
  if [ -f "$f" ]; then
    xattr -rd com.apple.quarantine "$f" 2>/dev/null || true
    chmod +x "$f" 2>/dev/null || true
    printf "  ${GREEN}✅${NC} Fixed launcher: %s\n" "$(basename "$f")"
  fi
done

# ─── Step 2: Make executable ───
printf "  ${CYAN}[2]${NC} Setting executable permission...\n"
chmod +x "$BINARY"

# ─── Step 3: Ad-hoc code sign ───
printf "  ${CYAN}[3]${NC} Ad-hoc code signing...\n"
if command -v codesign >/dev/null 2>&1; then
  codesign --force --sign - "$BINARY" 2>/dev/null || true
  printf "  ${GREEN}✅${NC} Code signed\n"
else
  printf "  ${YELLOW}⚠️${NC}  codesign not available (Xcode CLT not installed)\n"
fi

# ─── Done ───
printf "\n"
printf "  ${GREEN}✅ All fixed!${NC} You can now run AgentOS:\n\n"
printf "     ${BOLD}%s serve${NC}\n\n" "$BINARY"
printf "  ${DIM}Or double-click 'Start AgentOS.command' if available.${NC}\n\n"
