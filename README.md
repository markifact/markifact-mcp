# Markifact, the universal marketing MCP server

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![MCP](https://img.shields.io/badge/MCP-compatible-blue.svg)](https://modelcontextprotocol.io)
[![MCP Registry](https://img.shields.io/badge/MCP%20Registry-listed-blue.svg)](https://modelcontextprotocol.io)
[![GitHub stars](https://img.shields.io/github/stars/markifact/markifact-mcp?style=social)](https://github.com/markifact/markifact-mcp/stargazers)
[![Last commit](https://img.shields.io/github/last-commit/markifact/markifact-mcp)](https://github.com/markifact/markifact-mcp/commits/main)

> Manage Google Ads, Meta Ads, TikTok Ads, LinkedIn Ads, Microsoft Ads, Reddit Ads, Pinterest Ads, Snapchat Ads, Amazon Ads, DV360, GA4, BigQuery, Google Search Console, Google Business Profile, Google Merchant Center, Facebook, Instagram, LinkedIn, Shopify, HubSpot, Klaviyo, WhatsApp, Slack and more from Claude, ChatGPT, Cursor, or any AI client. 1000+ operations. Human-in-the-loop on every write.

## What this does

Markifact turns any AI client into a senior performance marketer with live access to your ad accounts, analytics, storefronts, CRM, and messaging. Ask it to audit wasted spend, launch a PMax campaign, rotate fatigued creative, diagnose why a campaign stopped converting, query BigQuery, sync a Klaviyo audience, or DM a client on Slack. It does the work, shows you the change, and waits for approval before anything goes live.

One install, every account, behind a single OAuth flow.

## Supported platforms

1000+ live operations across every major platform.

| Category | Platforms |
|----------|-----------|
| **Paid media** | Google Ads, Meta Ads, TikTok Ads, LinkedIn Ads, Microsoft Ads, Reddit Ads, Pinterest Ads, Snapchat Ads, Amazon Ads, DV360 |
| **Analytics & data** | GA4, BigQuery, Google Search Console, Google Merchant Center |
| **Organic & social** | Facebook, Instagram, LinkedIn, Google Business Profile |
| **E-commerce, CRM & messaging** | Shopify, HubSpot, Klaviyo, WhatsApp, Slack |

### Google Ads MCP

Full read and write coverage of the Google Ads API: reporting across campaigns, ad groups, ads, keywords, search terms, assets, and conversions; campaign creation (Search, Performance Max, Display, Shopping, Demand Gen); budgets, bidding, and negative keyword management. No developer token, Google Cloud project, or local server required, unlike Google's official read-only MCP. Setup guide: [markifact.com/google-ads-mcp](https://www.markifact.com/google-ads-mcp)

### Meta Ads MCP (Facebook & Instagram)

Create campaigns, ad sets, and single image, video, carousel, and catalog creatives; pull performance with placement, device, and demographic breakdowns; manage custom and lookalike audiences; diagnose Pixel and Conversions API setup. Markifact is an approved Meta tech provider. Setup guide: [markifact.com/meta-ads-mcp](https://www.markifact.com/meta-ads-mcp)

## See it in action

Real prompts you can paste into Claude, ChatGPT, Cursor, or any connected client:

```
"Create a Google Search campaign for our spring sale. $150/day, US + Canada, target 'running shoes' and related keywords, paused so I can review"
```

```
"Launch a Meta Advantage+ campaign for our Black Friday creative. Budget $200/day, target US, paused so I can review"
```

```
"Audit my Google Ads account from the last 30 days and find wasted spend over $500"
```

```
"Pull the top 20 queries from Google Search Console for the last 28 days where impressions are up but CTR dropped, and suggest title tag rewrites"
```

```
"Rotate my top fatigued creative on the BFCM ad set, ship two variants paused"
```

## Install for your AI client

All clients connect to the same MCP server. Sign up at [www.markifact.com](https://www.markifact.com) first to get free credits, then install for the client you use.

| Client | One-line install |
|--------|------------------|
| **Claude Code** | `claude plugin marketplace add markifact/markifact-mcp` then `/plugin install markifact@markifact` |
| **ChatGPT** (Pro / Business / Enterprise) | Settings → Apps → enable Developer mode → Create app → paste `https://api.markifact.com/mcp` |
| **Claude Desktop & Web** | In any chat, click **+** → Add custom connector → URL: `https://api.markifact.com/mcp` |
| **Cursor** | `curl -fsSL https://raw.githubusercontent.com/markifact/markifact-mcp/main/plugins/cursor/markifact/install.sh \| bash` |
| **Codex CLI** | `curl -fsSL https://raw.githubusercontent.com/markifact/markifact-mcp/main/plugins/codex/markifact/install.sh \| bash` |
| **Windsurf** | See [docs/windsurf.md](docs/windsurf.md) |
| **Gemini CLI** | `gemini extensions install github.com/markifact/markifact-mcp` |
| **Antigravity** | See [docs/antigravity.md](docs/antigravity.md) |
| **Any MCP-compliant client** | Raw URL: `https://api.markifact.com/mcp` (OAuth 2.1) |

Per-client guides live in [`docs/`](docs/).

## Install skills via skills.sh

Markifact's skills are also available through [skills.sh](https://skills.sh), which works across 50+ AI agents including Cursor, Codex, Cline, Copilot, Gemini, Windsurf, and more.

```bash
npx skills add markifact/markifact-mcp
```

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

### 1000+ live operations across every major platform

See the [Supported platforms](#supported-platforms) table above for the full list. One install, every account.

## Why Markifact

### One MCP, every platform

Most ad MCP servers cover one platform. Markifact runs Google Ads, Meta Ads, TikTok Ads, LinkedIn Ads, Microsoft Ads, Reddit Ads, Pinterest Ads, Snapchat Ads, Amazon Ads, DV360, GA4, BigQuery, Google Search Console, Google Business Profile, Google Merchant Center, Facebook, Instagram, LinkedIn, Shopify, HubSpot, Klaviyo, WhatsApp, and Slack behind a single OAuth flow. One install, every account.

### Real writes, with safety rails

Read-only MCPs are useful for reports. Markifact creates campaigns, edits creative, adjusts budgets, and pauses underperformers. Every write operation requires explicit user approval before it executes. Nothing goes live without you saying yes.

### Built for AI clients, not for engineers

The 1000+ operations are exposed through a small meta-tool surface that AI clients can navigate at runtime. No hardcoded tool list to drift. No context bloat. Your AI finds the right operation, fetches its schema, and runs it cleanly.

## Trust and security

- OAuth 2.1 with PKCE on every connection. No API keys to copy or paste.
- Encrypted credential storage. Tokens never leave Markifact and are never sent to the AI client.
- We do not train on your customer data.
- Meta app-reviewed.
- Every write operation requires explicit user approval before execution.
- Trust center: [www.markifact.com/trust-center](https://www.markifact.com/trust-center)

## How it works

Markifact's MCP server exposes a small set of meta-tools that your AI client uses to navigate 1000+ operations at runtime. The pattern is always the same:

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

Free tier available. Paid plans start at the Starter tier. See [www.markifact.com/pricing](https://www.markifact.com/pricing) for the full breakdown.

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
- Reconnect platforms: <https://www.markifact.com/app/connections>

---

Markifact is the universal MCP server for performance marketing. It works with Claude Code, Claude Desktop, ChatGPT, Cursor, Codex, Windsurf, OpenClaw, Antigravity, and Gemini CLI. Use it as a Google Ads MCP, Meta Ads MCP, TikTok Ads MCP, LinkedIn Ads MCP, Microsoft Ads MCP, Reddit Ads MCP, Pinterest Ads MCP, Snapchat Ads MCP, Amazon Ads MCP, DV360 MCP, GA4 MCP, BigQuery MCP, Google Search Console MCP, Google Business Profile MCP, Google Merchant Center MCP, Facebook MCP, Instagram MCP, LinkedIn MCP, Shopify MCP, HubSpot MCP, Klaviyo MCP, WhatsApp MCP, or Slack MCP from any AI client.

## License

[MIT](LICENSE) © Markifact
