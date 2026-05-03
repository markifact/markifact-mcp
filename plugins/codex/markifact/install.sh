#!/usr/bin/env bash
# Install Markifact for Codex CLI (OpenAI).
# Usage:  curl -fsSL https://raw.githubusercontent.com/markifact/markifact-mcp/main/plugins/codex/markifact/install.sh | bash

set -euo pipefail

CODEX_DIR="$HOME/.codex"
CONFIG="$CODEX_DIR/config.toml"
AGENTS="$CODEX_DIR/AGENTS.md"

mkdir -p "$CODEX_DIR"

# --- 1. MCP server in config.toml ---
SNIPPET='
[mcp_servers.markifact]
url = "https://api.markifact.com/mcp"
'

echo "→ Configuring Markifact MCP server in $CONFIG"
if [[ -f "$CONFIG" ]]; then
  if grep -q "^\[mcp_servers.markifact\]" "$CONFIG"; then
    echo "  (markifact already present, leaving as-is)"
  else
    printf '%s\n' "$SNIPPET" >> "$CONFIG"
    echo "✓ appended"
  fi
else
  printf '%s\n' "$SNIPPET" > "$CONFIG"
  echo "✓ created"
fi

# --- 2. AGENTS.md ---
echo "→ Installing AGENTS.md to $AGENTS"
if [[ -f "$AGENTS" ]]; then
  echo "  (existing AGENTS.md backed up to $AGENTS.bak)"
  cp "$AGENTS" "$AGENTS.bak"
fi
curl -fsSL https://raw.githubusercontent.com/markifact/markifact-mcp/main/plugins/codex/markifact/AGENTS.md \
  -o "$AGENTS"

echo
echo "✓ Markifact installed for Codex."
echo "  1. Restart your shell or any open Codex session."
echo "  2. Run 'codex' and authenticate Markifact when prompted."
echo "  3. Try: \"Audit my Google Ads account.\""
