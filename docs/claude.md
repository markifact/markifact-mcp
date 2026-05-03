# Claude (Web & Desktop)

Claude on the web and desktop apps supports remote MCP servers as **custom connectors** on Pro and Team plans. The flow is identical for both; only the fallback config-file option (Option 2) is desktop-only.

> For Claude Code (terminal), see [claude-code.md](claude-code.md).

## Option 1: Custom Connector (recommended)

1. In any Claude conversation, click the **+** button next to the search bar.
2. Select **Add custom connector**.
3. Name: `Markifact`
4. URL: `https://api.markifact.com/mcp`
5. Click **Add**. You're redirected to sign in with your Markifact account via OAuth.

## Option 2: Config file (Claude Desktop only)

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
- If a tool errors with auth, reconnect at <https://www.markifact.com/connections>.
