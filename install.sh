#!/bin/bash
set -euo pipefail

GREEN='\033[0;32m'; RED='\033[0;31m'; BOLD='\033[1m'; NC='\033[0m'

echo -e "${BOLD}Installing compress...${NC}"

# Check ffmpeg
if ! command -v ffmpeg &>/dev/null; then
  echo -e "${RED}ffmpeg not found.${NC}"
  if command -v brew &>/dev/null; then
    echo "Install with: brew install ffmpeg"
  else
    echo "Install with: sudo apt install ffmpeg"
  fi
  exit 1
fi

# Install
INSTALL_DIR="$HOME/.local/bin"
mkdir -p "$INSTALL_DIR"

curl -fsSL https://raw.githubusercontent.com/Mbeckero/compress/main/compress -o "$INSTALL_DIR/compress"
chmod +x "$INSTALL_DIR/compress"

# Add to PATH if needed
SHELL_RC="$HOME/.zshrc"
[ -f "$HOME/.bashrc" ] && [ ! -f "$HOME/.zshrc" ] && SHELL_RC="$HOME/.bashrc"

if ! grep -q '.local/bin' "$SHELL_RC" 2>/dev/null; then
  echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$SHELL_RC"
  echo -e "${GREEN}Added ~/.local/bin to PATH in $(basename $SHELL_RC)${NC}"
fi

echo -e "${GREEN}${BOLD}✓ compress installed!${NC}"
echo "  Restart terminal or run: source $SHELL_RC"
echo "  Then: compress --help"
