# Cursor

## Install

In Cursor, open **Settings → Plugins**, search **Markifact**, and install it. The plugin adds the Markifact MCP server, the `getting-started` skill, the `performance-marketer` agent and the workflow commands.

Or add only the MCP server to `mcp.json` (global: `~/.cursor/mcp.json`, per-project: `.cursor/mcp.json`):

```json
{
  "mcpServers": {
    "markifact": {
      "url": "https://api.markifact.com/mcp"
    }
  }
}
```

Open the MCP panel and sign in to Markifact (browser OAuth).

## Try it

> "Audit my Google Ads account."
