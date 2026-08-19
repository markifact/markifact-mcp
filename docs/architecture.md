# Architecture

## One repo, many surfaces

```
shared/                          ← single source of truth
├── commands/                    ← user-invocable workflows  (slash commands)
├── skills/                      ← model-auto-invocable reference skills
└── agents/                      ← agent personas

scripts/sync-skills.sh           ← compiles shared/ into:

commands/                        ← Claude Code  (1:1 copy — /markifact:* slash commands)
skills/                          ← Claude Code  (1:1 copy — model-invocable)
agents/                          ← Claude Code  (1:1 copy — sub-agents)
gemini/commands/markifact/*.toml ← Gemini CLI   (commands rewritten as TOML)
plugins/cursor/.../markifact.mdc ← Cursor       (single bundled rules file: agent + skills + commands)
plugins/codex/.../AGENTS.md      ← Codex        (single concatenated prompt: agent + skills + commands)
```

CI runs `sync-skills.sh --check`. PRs that hand-edit generated files fail.

## The MCP server

The actual MCP endpoint is **not** in this repo — it's hosted at `https://api.markifact.com/mcp` (FastMCP, OAuth 2.1 + PKCE + RFC 7591 dynamic client registration).

Each AI client gets a manifest pointing at that URL:

| Client | Manifest |
|--------|----------|
| Claude Code | `.mcp.json` (referenced by `.claude-plugin/plugin.json`) |
| Gemini CLI | `gemini-extension.json` |
| Cursor | `plugins/cursor/markifact/.cursor/mcp.json` (created by install script) |
| Codex CLI | `~/.codex/config.toml` (merged by install script) |
| Windsurf | `~/.codeium/windsurf/mcp_config.json` (manual) |
| Claude Desktop / ChatGPT | UI-configured custom connector |
| MCP Registry | `server.json` |

## Meta-tool surface

Markifact exposes only **8 tools**, not one tool per platform operation:

| Tool | Purpose |
|------|---------|
| `find_operations` | Search the registry of 1000+ ops by intent. |
| `get_operation_inputs` | Schema for a chosen op. |
| `run_operation` | Execute a read-only op. |
| `run_write_operation` | Execute a destructive op. |
| `list_connections` | Authenticated platform accounts. |
| `get_file_url` | Signed URL for a Markifact-stored file. |
| `read_file` | Read an uploaded or generated file. |
| `upload_media` | Upload creative assets. |

Why? Models call `find_operations` first, so the catalogue can grow without manifest churn or context bloat in the model.

## Versioning

All four manifests (`plugin.json`, `marketplace.json`, `server.json`, `gemini-extension.json`) carry the same `version`. Bump them with `./scripts/bump-version.sh X.Y.Z`. CI checks they match.
