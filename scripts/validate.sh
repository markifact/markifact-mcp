#!/usr/bin/env bash
# validate.sh — JSON syntax + shape checks for all manifests.
# Run:  ./scripts/validate.sh

set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

ok=1

check_json() {
  local f="$1"
  if ! python3 -m json.tool "$f" > /dev/null 2>&1; then
    echo "✗ Invalid JSON: $f" >&2
    ok=0
  else
    echo "✓ $f"
  fi
}

check_json .claude-plugin/plugin.json
check_json .claude-plugin/marketplace.json
check_json .mcp.json
check_json server.json
check_json gemini-extension.json

# --- Cross-file version check ---
v_plugin=$(python3 -c 'import json; print(json.load(open(".claude-plugin/plugin.json"))["version"])')
v_server=$(python3 -c 'import json; print(json.load(open("server.json"))["version"])')
v_gemini=$(python3 -c 'import json; print(json.load(open("gemini-extension.json"))["version"])')

if [[ "$v_plugin" != "$v_server" || "$v_plugin" != "$v_gemini" ]]; then
  echo "✗ Version mismatch: plugin=$v_plugin server=$v_server gemini=$v_gemini" >&2
  ok=0
else
  echo "✓ Versions in sync: $v_plugin"
fi

# --- Skill frontmatter sanity check ---
for f in shared/skills/*/SKILL.md; do
  if ! grep -q '^description:' "$f"; then
    echo "✗ Missing description in $f" >&2
    ok=0
  fi
done

# --- Optional: claude plugin validate ---
if command -v claude > /dev/null 2>&1; then
  echo
  echo "Running: claude plugin validate ."
  claude plugin validate . || ok=0
else
  echo
  echo "ℹ Skipping 'claude plugin validate' (claude CLI not installed)"
fi

if [[ $ok -ne 1 ]]; then
  exit 1
fi
echo
echo "✓ All checks passed"
