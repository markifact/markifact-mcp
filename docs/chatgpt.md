# ChatGPT

Markifact is an approved ChatGPT plugin, so there is nothing to configure by hand.

## Install

1. Open the Markifact plugin: <https://chatgpt.com/plugins/plugin_asdk_app_69e795096e888191b3908a4dd48a323d>
   (or open ChatGPT → **Settings** → **Apps** and search for **Markifact**).
2. Click **Connect**. ChatGPT redirects you to sign in with your Markifact account via OAuth.
3. Link your ad platform accounts at <https://www.markifact.com/app/connections>.

You can now enable the **Markifact** plugin in any chat.

## Try it

> "Audit my Google Ads account."

## Manual install (fallback)

Only needed if the plugin is unavailable on your plan. Requires Pro, Business or Enterprise.

1. ChatGPT → **Settings** → **Apps** → enable **Developer mode**.
2. Click **Create app**.
3. Set the name to **Markifact**.
4. Paste the MCP Server URL: `https://api.markifact.com/mcp`
5. Keep **Authentication** set to **OAuth**.
6. Click **Create**, then sign in when redirected.

## Notes

- ChatGPT consumes **only** the MCP server. Skills, sub-agents and slash commands from this repo do not apply.
- For the richest experience (slash commands, agent persona, write-op safety enforcement), use Claude Code.
- For Codex (terminal/desktop), see [codex.md](codex.md).
- If a tool errors with auth, reconnect at <https://www.markifact.com/app/connections>.
