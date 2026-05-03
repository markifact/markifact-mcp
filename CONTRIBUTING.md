# Contributing to the Markifact plugin

Thanks for taking the time to improve the Markifact plugin. This repo packages the agent, slash commands, skills, and per-client install scripts that ship to Claude Code, Claude Desktop, ChatGPT, Cursor, Codex, Gemini CLI, and Windsurf. The MCP server itself is hosted at `https://api.markifact.com/mcp` and is not part of this repo.

## What lives where

| Path | Purpose |
|---|---|
| `.claude-plugin/` | Claude Code plugin manifest, marketplace catalog, icon |
| `agents/` | Subagent definition (`performance-marketer`) |
| `commands/` | User-facing slash commands |
| `skills/` | Reference skills loaded by the agent |
| `shared/` | Source-of-truth content compiled into per-client surfaces by `scripts/sync-skills.sh` |
| `plugins/` | Per-client install scripts (Cursor, Codex, Windsurf) |
| `gemini/` | Gemini CLI command surface |
| `docs/` | Per-client install walkthroughs (linked from README + CONNECTING) |
| `server.json` | MCP Registry entry |

Top-level legal/security docs (`PRIVACY.md`, `TERMS.md`, `SECURITY.md`, `SUPPORT.md`, `CONNECTING.md`) are hand-maintained and not generated.

## Workflow

1. Fork the repo and create a feature branch off `main`.
2. Edit content in `shared/` when changing skills or commands so every client surface stays in sync.
3. Run `./scripts/sync-skills.sh` to regenerate per-client files.
4. Run `./scripts/validate.sh` to verify JSON syntax, version match, and `claude plugin validate .`.
5. If you bumped the plugin version, also update [`CHANGELOG.md`](CHANGELOG.md) and use `./scripts/bump-version.sh` so all four manifests move together.
6. Open a pull request describing the user-visible change.

## House style

- No em or en dashes (`—` or `–`). Use a hyphen or rephrase. Quick check: `grep -nE '—|–' file.md`.
- Skill bodies are instructions FOR Claude, not documentation FOR the user. Use imperative voice.
- Commands describe explicit user actions. Skills describe domain knowledge.
- Keep the `displayName` and `description` fields in `plugin.json` and `marketplace.json` consistent.

## Reporting issues

Bugs and feature requests: <https://github.com/markifact/markifact-mcp/issues>

Security reports: see [`SECURITY.md`](SECURITY.md).

Product questions: contact@markifact.com.
