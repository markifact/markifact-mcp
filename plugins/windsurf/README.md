# Markifact for Windsurf

Windsurf supports remote MCP servers via its `mcp_config.json` file.

## Install

1. Open Windsurf → **Settings** → **Cascade** → **MCP Servers** → **Edit raw config**, or edit the file directly:
   - macOS / Linux: `~/.codeium/windsurf/mcp_config.json`
   - Windows: `%APPDATA%\Codeium\windsurf\mcp_config.json`
2. Merge in the snippet from [`mcp_config.snippet.json`](./mcp_config.snippet.json):
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
4. In Cascade, sign in to Markifact when prompted (OAuth, browser-based).

## Try it

> "Audit my Google Ads account."
