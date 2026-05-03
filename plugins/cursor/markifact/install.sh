#!/usr/bin/env bash
# Install Markifact for Cursor.
# Usage:  curl -fsSL https://raw.githubusercontent.com/markifact/markifact-mcp/main/plugins/cursor/markifact/install.sh | bash

set -euo pipefail

CURSOR_DIR="$HOME/.cursor"
RULES_DIR="$CURSOR_DIR/rules"
MCP_FILE="$CURSOR_DIR/mcp.json"

mkdir -p "$RULES_DIR"

# --- 1. MCP server ---
echo "→ Configuring Markifact MCP server in $MCP_FILE"
if [[ -f "$MCP_FILE" ]]; then
  python3 - "$MCP_FILE" <<'PY'
import json, sys
p = sys.argv[1]
with open(p) as f:
    cfg = json.load(f)
cfg.setdefault("mcpServers", {})
cfg["mcpServers"]["markifact"] = {"url": "https://api.markifact.com/mcp"}
with open(p, "w") as f:
    json.dump(cfg, f, indent=2)
    f.write("\n")
print("✓ merged")
PY
else
  cat > "$MCP_FILE" <<'JSON'
{
  "mcpServers": {
    "markifact": {
      "url": "https://api.markifact.com/mcp"
    }
  }
}
JSON
  echo "✓ created"
fi

# --- 2. Rules file ---
echo "→ Installing performance-marketer rules into $RULES_DIR/markifact.mdc"
curl -fsSL https://raw.githubusercontent.com/markifact/markifact-mcp/main/plugins/cursor/markifact/.cursor/rules/markifact.mdc \
  -o "$RULES_DIR/markifact.mdc"

echo
echo "✓ Markifact installed for Cursor."
echo "  1. Restart Cursor."
echo "  2. Open the MCP panel and authenticate Markifact (browser flow)."
echo "  3. Try: \"Audit my Google Ads account.\""
