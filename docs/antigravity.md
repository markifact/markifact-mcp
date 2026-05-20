# Antigravity

Antigravity 2 uses the Gemini MCP config file, so setup is manual.

## Install

1. Install the **Antigravity 2 desktop app**.
2. Locate the file `~/.gemini/config/mcp_config.json`.
3. Merge in this `markifact` entry under `mcpServers`:
   ```json
   {
     "mcpServers": {
       "markifact": {
         "command": "npx",
         "args": [
           "mcp-remote",
           "https://api.markifact.com/mcp",
           "--header",
           "Authorization: Bearer YOUR_MARKIFACT_TOKEN"
         ]
       }
     }
   }
   ```
4. If the file already contains other MCP servers, keep them and add only the `markifact` block.
5. Replace `YOUR_MARKIFACT_TOKEN` with your Markifact bearer token.
6. Restart Antigravity.

## Notes

- Antigravity currently expects the command-based config above rather than a direct `url` entry.
- On first run, `npx` may prompt to install `mcp-remote`.

## Try it

> "Audit my Google Ads account."