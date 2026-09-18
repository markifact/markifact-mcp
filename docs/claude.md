# Claude (Web & Desktop)

Markifact is listed in Claude's official connector directory, so most users can add it in two clicks.

> For Claude Code (terminal), see [claude-code.md](claude-code.md).

## Option 1: Connector directory (recommended)

1. Open the Markifact listing: <https://claude.ai/directory/markifact>
   (or in Claude, go to **Settings** → **Connectors** and search for **Markifact**).
2. Click **Connect**. You're redirected to sign in with your Markifact account via OAuth.
3. Link your ad platform accounts at <https://www.markifact.com/app/connections>.

On Team and Enterprise plans an Owner may need to enable the connector for the organization first. See [CONNECTING.md](../CONNECTING.md#add-markifact-as-an-organizational-custom-connector-claude-owners).

## Option 2: Custom connector

Use this if your plan or organization does not expose the directory listing.

1. In any Claude conversation, click the **+** button next to the search bar.
2. Select **Add custom connector**.
3. Name: `Markifact`
4. URL: `https://api.markifact.com/mcp`
5. Click **Add**. You're redirected to sign in with your Markifact account via OAuth.

## Option 3: Config file (Claude Desktop only)

If you don't see the **Add custom connector** option, edit `claude_desktop_config.json` directly. Generate a token at <https://www.markifact.com/app/mcp> first, then add:

```json
{
  "mcpServers": {
    "markifact": {
      "url": "https://api.markifact.com/mcp",
      "headers": {
        "Authorization": "Bearer YOUR_TOKEN"
      }
    }
  }
}
```

Restart Claude Desktop.

## Try it

> "Audit my Google Ads account."
>
> "Pull last week's spend, conversions and ROAS for every platform I've connected."

## Notes

- Claude Desktop / Web does **not** load skills, slash commands or sub-agents from this repo. Only the MCP server is consumed. Use Claude Code for the full experience.
- If a tool errors with auth, reconnect at <https://www.markifact.com/app/connections>.
