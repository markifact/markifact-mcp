#!/usr/bin/env bash
# bump-version.sh — bump the version in every manifest in lockstep.
# Usage:  ./scripts/bump-version.sh 0.2.0

set -euo pipefail
NEW="${1:-}"
if [[ -z "$NEW" ]]; then
  echo "Usage: $0 <new-version>  (e.g. 0.2.0)" >&2
  exit 1
fi
if ! [[ "$NEW" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "✗ Version must be semver MAJOR.MINOR.PATCH" >&2
  exit 1
fi

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

python3 - <<PY
import json, pathlib, re
new = "$NEW"
# Every manifest carries the plugin version as "version": "X.Y.Z", either at the
# top level or inside a marketplace "plugins" entry. Replace the text in place so
# the files keep their existing formatting instead of being re-serialised.
pattern = re.compile(r'("version"\s*:\s*")\d+\.\d+\.\d+(")')
for p in [
    ".claude-plugin/plugin.json",
    ".claude-plugin/marketplace.json",
    ".cursor-plugin/plugin.json",
    ".openclaw-plugin/plugin.json",
    ".openclaw-plugin/marketplace.json",
    "openclaw.plugin.json",
    "package.json",
    "server.json",
    "gemini-extension.json",
]:
    f = pathlib.Path(p)
    text, count = pattern.subn(rf'\g<1>{new}\g<2>', f.read_text())
    if count == 0:
        raise SystemExit(f"✗ {p}: no version field found")
    json.loads(text)  # refuse to write anything that is no longer valid JSON
    f.write_text(text)
    print(f"✓ {p} → {new}")
PY

echo
echo "Don't forget to:"
echo "  1. Update CHANGELOG.md"
echo "  2. git commit -am 'release: v$NEW'"
echo "  3. git tag v$NEW && git push --tags"
