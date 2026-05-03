# Codex CLI

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/markifact/markifact-mcp/main/plugins/codex/markifact/install.sh | bash
```

The script:
1. Adds `[mcp_servers.markifact]` to `~/.codex/config.toml`.
2. Installs `~/.codex/AGENTS.md` (existing file backed up to `AGENTS.md.bak`).

Restart your shell. Run `codex` and authenticate Markifact when prompted.

## Try it

> "Audit my Google Ads account."

## Manual install

See [`plugins/codex/markifact/README.md`](../plugins/codex/markifact/README.md).
