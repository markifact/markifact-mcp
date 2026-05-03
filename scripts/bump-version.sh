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
import json, pathlib
new = "$NEW"
for p in [".claude-plugin/plugin.json", "server.json", "gemini-extension.json"]:
    f = pathlib.Path(p)
    data = json.loads(f.read_text())
    data["version"] = new
    f.write_text(json.dumps(data, indent=2) + "\n")
    print(f"✓ {p} → {new}")
PY

echo
echo "Don't forget to:"
echo "  1. Update CHANGELOG.md"
echo "  2. git commit -am 'release: v$NEW'"
echo "  3. git tag v$NEW && git push --tags"
