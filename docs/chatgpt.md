# ChatGPT

ChatGPT supports remote MCP servers as **custom apps** (Settings → Apps → Developer mode) on Pro, Business and Enterprise plans.

## Install

1. ChatGPT → **Settings** → **Apps** → enable **Developer mode**.
2. Click **Create app**.
3. Set the name to **Markifact**.
4. Paste the MCP Server URL: `https://api.markifact.com/mcp`
5. Keep **Authentication** set to **OAuth**.
6. Click **Create**. ChatGPT redirects you to sign in with your Markifact account via OAuth.

You can now enable the **Markifact** app in any chat.

## Try it

> "Audit my Google Ads account."

## Notes

- ChatGPT consumes **only** the MCP server. Skills, sub-agents and slash commands from this repo do not apply.
- For the richest experience (slash commands, agent persona, write-op safety enforcement), use Claude Code.
- For Codex (terminal/desktop), see [codex.md](codex.md).
- If a tool errors with auth, reconnect at <https://www.markifact.com/connections>.
