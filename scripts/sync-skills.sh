#!/usr/bin/env bash
# sync-skills.sh — compile shared/ source-of-truth into per-client surfaces.
#
# Inputs:
#   shared/commands/<name>.md          User-invocable workflows (slash commands)
#   shared/skills/<name>/SKILL.md      Model-auto-invocable reference skills
#   shared/agents/<name>.md            Sub-agent personas
#
# Outputs:
#   commands/<name>.md                 (Claude Code  — slash commands)
#   skills/<name>/SKILL.md             (Claude Code  — model-invocable skills)
#   agents/<name>.md                   (Claude Code  — sub-agents)
#   gemini/commands/markifact/*.toml   (Gemini CLI   — slash commands as TOML)
#   plugins/cursor/markifact/.cursor/rules/markifact.mdc  (Cursor — single bundled rules file)
#   plugins/codex/markifact/AGENTS.md  (Codex CLI    — single concatenated prompt)
#
# Run from repo root:  ./scripts/sync-skills.sh
# Check mode (CI):     ./scripts/sync-skills.sh --check

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

CHECK_MODE=0
if [[ "${1:-}" == "--check" ]]; then
  CHECK_MODE=1
fi

OUT_PATHS=(commands skills agents gemini/commands/markifact plugins/cursor/markifact/.cursor/rules plugins/codex/markifact/AGENTS.md)

# Capture pre-state for --check
if [[ $CHECK_MODE -eq 1 ]]; then
  PRE_HASH=$(find "${OUT_PATHS[@]}" -type f 2>/dev/null | sort | xargs -I {} sha256sum {} 2>/dev/null | sha256sum)
fi

# --- Clean output dirs (don't touch the input shared/ tree) -----------------
rm -rf commands skills agents gemini/commands/markifact \
       plugins/cursor/markifact/.cursor/rules \
       plugins/codex/markifact/AGENTS.md
mkdir -p commands skills agents gemini/commands/markifact \
         plugins/cursor/markifact/.cursor/rules

# --- 1. Claude Code slash commands (identity copy) -------------------------
for src in shared/commands/*.md; do
  cp "$src" "commands/$(basename "$src")"
done
echo "✓ Claude Code commands → commands/"

# --- 2. Claude Code skills (identity copy) ---------------------------------
for src in shared/skills/*/SKILL.md; do
  name=$(basename "$(dirname "$src")")
  mkdir -p "skills/$name"
  cp "$src" "skills/$name/SKILL.md"
done
echo "✓ Claude Code skills   → skills/"

# --- 3. Claude Code agent (identity copy) ----------------------------------
for src in shared/agents/*.md; do
  cp "$src" "agents/$(basename "$src")"
done
echo "✓ Claude Code agent    → agents/"

# --- 4. Gemini CLI commands (TOML, from shared/commands/) ------------------
for src in shared/commands/*.md; do
  name=$(basename "$src" .md)
  desc=$(awk '/^description:/{sub(/^description:[[:space:]]*/,""); print; exit}' "$src")
  body=$(awk 'BEGIN{f=0} /^---$/{f++; next} f>=2{print}' "$src")
  out="gemini/commands/markifact/${name}.toml"
  {
    printf 'description = %s\n\n' "$(printf '%s' "$desc" | python3 -c 'import json,sys; print(json.dumps(sys.stdin.read().strip()))')"
    printf 'prompt = """\n%s\n"""\n' "$body"
  } > "$out"
done
echo "✓ Gemini commands      → gemini/commands/markifact/"

# --- 5. Cursor bundled rules (.mdc) ----------------------------------------
{
  cat <<'EOF'
---
description: Markifact performance-marketing agent + skills + commands. Auto-loaded by Cursor whenever you ask about ads, GA4, Shopify, HubSpot or other marketing platforms.
alwaysApply: true
---

EOF
  awk 'BEGIN{f=0} /^---$/{f++; next} f>=2{print}' shared/agents/performance-marketer.md
  echo
  echo "---"
  echo "## Reference skills (always loaded)"
  echo
  for src in shared/skills/*/SKILL.md; do
    name=$(basename "$(dirname "$src")")
    echo "### $name"
    echo
    awk 'BEGIN{f=0} /^---$/{f++; next} f>=2{print}' "$src"
    echo
  done
  echo "---"
  echo "## Workflows (user-invokable)"
  echo
  for src in shared/commands/*.md; do
    name=$(basename "$src" .md)
    echo "### $name"
    echo
    awk 'BEGIN{f=0} /^---$/{f++; next} f>=2{print}' "$src"
    echo
  done
} > plugins/cursor/markifact/.cursor/rules/markifact.mdc
echo "✓ Cursor rules         → plugins/cursor/markifact/.cursor/rules/markifact.mdc"

# --- 6. Codex AGENTS.md (concatenated prompt) ------------------------------
{
  echo "# Markifact"
  echo
  echo "_Auto-generated. Edit \`shared/\` then run \`./scripts/sync-skills.sh\`._"
  echo
  awk 'BEGIN{f=0} /^---$/{f++; next} f>=2{print}' shared/agents/performance-marketer.md
  echo
  echo "---"
  echo "## Reference skills"
  echo
  for src in shared/skills/*/SKILL.md; do
    name=$(basename "$(dirname "$src")")
    echo "### $name"
    echo
    awk 'BEGIN{f=0} /^---$/{f++; next} f>=2{print}' "$src"
    echo
  done
  echo "---"
  echo "## Workflows"
  echo
  for src in shared/commands/*.md; do
    name=$(basename "$src" .md)
    echo "### $name"
    echo
    awk 'BEGIN{f=0} /^---$/{f++; next} f>=2{print}' "$src"
    echo
  done
} > plugins/codex/markifact/AGENTS.md
echo "✓ Codex AGENTS.md      → plugins/codex/markifact/AGENTS.md"

# --- Check mode: fail if any output changed --------------------------------
if [[ $CHECK_MODE -eq 1 ]]; then
  POST_HASH=$(find "${OUT_PATHS[@]}" -type f 2>/dev/null | sort | xargs -I {} sha256sum {} 2>/dev/null | sha256sum)
  if [[ "$PRE_HASH" != "$POST_HASH" ]]; then
    echo
    echo "✗ Generated files are out of date. Run ./scripts/sync-skills.sh and commit." >&2
    exit 1
  fi
  echo
  echo "✓ Generated files are up to date."
fi
