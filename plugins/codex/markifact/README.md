# Markifact for Codex CLI

Performance-marketing automation via Markifact's remote MCP server.

## Install (one line)

```bash
curl -fsSL https://raw.githubusercontent.com/markifact/markifact-mcp/main/plugins/codex/markifact/install.sh | bash
```

This:
1. Adds the `markifact` MCP server to `~/.codex/config.toml`.
2. Installs the bundled performance-marketer prompt at `~/.codex/AGENTS.md` (your existing file, if any, is backed up to `AGENTS.md.bak`).

## Manual install

Add to `~/.codex/config.toml`:

```toml
[mcp_servers.markifact]
url = "https://api.markifact.com/mcp"
```

Copy [`AGENTS.md`](./AGENTS.md) to `~/.codex/AGENTS.md`.
