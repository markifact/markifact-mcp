# Markifact for Cursor

Performance-marketing automation via Markifact's remote MCP server.

## Install (one line)

```bash
curl -fsSL https://raw.githubusercontent.com/markifact/markifact-mcp/main/plugins/cursor/markifact/install.sh | bash
```

This:
1. Adds the `markifact` server to `~/.cursor/mcp.json`.
2. Installs the bundled rules file at `~/.cursor/rules/markifact.mdc` (loaded automatically by Cursor).

Restart Cursor, then open the MCP panel and sign in to Markifact (OAuth, browser-based).

## Uninstall

```bash
rm ~/.cursor/rules/markifact.mdc
# Then edit ~/.cursor/mcp.json and remove the "markifact" entry.
```
