# Markifact, the universal marketing MCP server

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![MCP](https://img.shields.io/badge/MCP-compatible-blue.svg)](https://modelcontextprotocol.io)
[![MCP Registry](https://img.shields.io/badge/MCP%20Registry-listed-blue.svg)](https://modelcontextprotocol.io)
[![GitHub stars](https://img.shields.io/github/stars/markifact/markifact-mcp?style=social)](https://github.com/markifact/markifact-mcp/stargazers)
[![Last commit](https://img.shields.io/github/last-commit/markifact/markifact-mcp)](https://github.com/markifact/markifact-mcp/commits/main)

> Manage Google Ads, Meta Ads, GA4, Shopify, HubSpot and 20+ more platforms from Claude, ChatGPT, Cursor, or any AI client. 300+ operations. Human-in-the-loop on every write.

## What this does

Markifact turns any AI client into a senior performance marketer with live access to your ad accounts. Ask it to audit wasted spend, launch a PMax campaign, rotate fatigued creative, or diagnose why a campaign stopped converting. It does the work, shows you the change, and waits for approval before anything goes live.

One install gives you a Google Ads MCP server, a Meta Ads MCP server, a GA4 MCP server, a Shopify MCP, and a HubSpot MCP behind a single OAuth flow.

## See it in action

Real prompts you can paste into Claude, ChatGPT, Cursor, or any connected client:

```
"Audit my Google Ads account from the last 30 days and find wasted spend over $500"
```

```
"Launch a Meta Advantage+ campaign for our Black Friday creative. Budget $200/day, target US, paused so I can review"
```

```
"Why did campaign 'Brand-Search-US' stop converting last week? Walk me through it"
```

```
"Pull a week-over-week ROAS report across all my Meta ad accounts and flag anything in learning limited"
```

```
"Rotate my top fatigued creative on the BFCM ad set, ship two variants paused"
```

## Install for your AI client

All clients connect to the same MCP server. Sign up at [markifact.com](https://markifact.com) first to get free credits, then install for the client you use.

| Client | One-line install |
|--------|------------------|
| **Claude Code** | `claude plugin marketplace add markifact/markifact-mcp` then `/plugin install markifact@markifact` |
| **ChatGPT** (Pro / Business / Enterprise) | Settings → Apps → enable Developer mode → Create app → paste `https://api.markifact.com/mcp` |
| **Claude Desktop & Web** | In any chat, click **+** → Add custom connector → URL: `https://api.markifact.com/mcp` |
| **Cursor** | `curl -fsSL https://raw.githubusercontent.com/markifact/markifact-mcp/main/plugins/cursor/markifact/install.sh \| bash` |
| **Codex CLI** | `curl -fsSL https://raw.githubusercontent.com/markifact/markifact-mcp/main/plugins/codex/markifact/install.sh \| bash` |
| **Windsurf** | See [docs/windsurf.md](docs/windsurf.md) |
| **Gemini CLI** | `gemini extensions install github.com/markifact/markifact-mcp` |
| **Any MCP-compliant client** | Raw URL: `https://api.markifact.com/mcp` (OAuth 2.1) |

Per-client guides live in [`docs/`](docs/).

## What you get

### Pre-built workflows (slash commands)

- `/markifact:launch-google-search`: ship a paused Search campaign with ad groups, keywords, and ads in one approval **(write)**
- `/markifact:launch-pmax`: stand up a Performance Max campaign with asset group, paused for review **(write)**
- `/markifact:launch-meta-campaign`: build a Meta campaign, ad set, and ads end to end, paused **(write)**
- `/markifact:edit-meta-creative`: swap the URL, copy, or CTA on a live ad without breaking learning **(write)**
- `/markifact:rotate-creative`: pause fatigued ads and ship paused variants ready to launch **(write)**
- `/markifact:negative-keyword-sweep`: find search terms wasting your budget and block them with one approval **(write)**
- `/markifact:diagnose-underperformer`: walk through a structured decision tree to figure out why a campaign tanked **(read-only)**

### The performance-marketer agent

Available as `@performance-marketer` in Claude Code, the agent is a senior operator with full read and write access to every connected platform. It can audit accounts, build full-funnel campaigns, debug performance drops, rotate creative, and pull reports. Every write goes through a four-step safety protocol so nothing destructive happens without your explicit approval.

### 300+ live operations across every major platform

Google Ads, Meta Ads (Facebook + Instagram), GA4, DV360, Microsoft Ads, TikTok Ads, LinkedIn Ads, Pinterest Ads, Snapchat Ads, Reddit Ads, Amazon Ads, Shopify, HubSpot, Klaviyo, Slack, WhatsApp, Google Maps, and more. One install, every account.

## Why Markifact

### One MCP, every platform

Most ad MCP servers cover one platform. Markifact runs Google Ads, Meta Ads, GA4, DV360, Shopify, HubSpot, LinkedIn Ads, TikTok Ads, Google Maps, and 20+ more behind a single OAuth flow. One install, every account.

### Real writes, with safety rails

Read-only MCPs are useful for reports. Markifact creates campaigns, edits creative, adjusts budgets, and pauses underperformers. Every write operation requires explicit user approval before it executes. Nothing goes live without you saying yes.

### Built for AI clients, not for engineers

The 300+ operations are exposed through a small meta-tool surface that AI clients can navigate at runtime. No hardcoded tool list to drift. No context bloat. Your AI finds the right operation, fetches its schema, and runs it cleanly.

## Trust and security

- OAuth 2.1 with PKCE on every connection. No API keys to copy or paste.
- Encrypted credential storage. Tokens never leave Markifact and are never sent to the AI client.
- We do not train on your customer data.
- Meta app-reviewed.
- Every write operation requires explicit user approval before execution.
- Trust center: [markifact.com/trust-center](https://markifact.com/trust-center)

## How it works

Markifact's MCP server exposes a small set of meta-tools that your AI client uses to navigate 300+ operations at runtime. The pattern is always the same:

1. **Discover** the right operation by intent.
2. **Inspect** its input schema.
3. **Run** it, with explicit user approval on writes.

Engineers wanting the full design can read [`docs/architecture.md`](docs/architecture.md).

## Use cases

### For agencies and media buyers

Manage 50 clients without 50 tabs. Connect every client account once, switch between them in chat. Run audits, launch campaigns, and report in a fraction of the time.

### For solo founders running their own ads

You don't need a media buyer. Ask Markifact to launch your first PMax campaign or audit why ROAS dropped last week. Pro-level decisions without learning the platform UI.

### For in-house marketing teams

Your team already uses Claude or ChatGPT. Give them safe, controlled write access to ad platforms with audit trails on every change.

## Pricing

Free tier available. Paid plans start at the Starter tier. See [markifact.com/pricing](https://markifact.com/pricing) for the full breakdown.

## Contributing

The source-of-truth lives in [`shared/`](shared/) (`shared/commands/`, `shared/skills/`, `shared/agents/`). Per-client surfaces (`commands/`, `skills/`, `agents/`, `gemini/commands/`, `plugins/cursor/.cursor/rules/`, `plugins/codex/AGENTS.md`) are **generated**. Never edit them directly. Run:

```bash
./scripts/sync-skills.sh
./scripts/validate.sh
```

CI runs `sync-skills.sh --check` and rejects PRs that hand-edit generated files.

## Versioning

All four manifests (`plugin.json`, `marketplace.json`, `server.json`, `gemini-extension.json`) are kept in lockstep. Bump everything with:

```bash
./scripts/bump-version.sh 0.2.0
```

## Support

- Email: <contact@markifact.com>
- Issues: <https://github.com/markifact/markifact-mcp/issues>
- Reconnect platforms: <https://www.markifact.com/connections>

---

Markifact is the universal MCP server for performance marketing. It works with Claude Code, Claude Desktop, ChatGPT, Cursor, Codex, Windsurf, OpenClaw, and Gemini CLI. Use it as a Google Ads MCP server, Meta Ads MCP server, GA4 MCP server, Shopify MCP, or HubSpot MCP from any AI client.

## License

[MIT](LICENSE) © Markifact
