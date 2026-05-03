# Windsurf

Windsurf does not yet support a one-line installer for remote MCP servers, so installation is manual.

## Install

1. Open `~/.codeium/windsurf/mcp_config.json` (Windows: `%APPDATA%\Codeium\windsurf\mcp_config.json`).
2. Merge:
   ```json
   {
     "mcpServers": {
       "markifact": {
         "serverUrl": "https://api.markifact.com/mcp"
       }
     }
   }
   ```
3. Restart Windsurf.
4. In Cascade, sign in to Markifact when prompted (browser OAuth).

## Try it

> "Audit my Google Ads account."

See also [`plugins/windsurf/README.md`](../plugins/windsurf/README.md).
