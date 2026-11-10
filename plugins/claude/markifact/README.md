# Markifact - Ads & Analytics for Claude

Run Google Ads, Meta Ads, TikTok Ads, LinkedIn Ads, GA4, Shopify, HubSpot and 50+ more platforms from Claude. 1000+ operations through Markifact's hosted MCP server, with approval required before any write.

## Works with

- **Ads:** Google Ads, Meta Ads (Facebook and Instagram), Microsoft Ads (Bing), TikTok Ads, LinkedIn Ads, X Ads, Snapchat Ads, Reddit Ads, Pinterest Ads, Amazon Ads, Spotify Ads, OpenAI Ads, Apple Ads, DV360
- **Analytics and tracking:** GA4, Google Tag Manager, Google Search Console, Bing Webmaster Tools, Adjust, Google Data Manager
- **Ecommerce and local:** Google Merchant Center, Shopify, Google Business Profile, Google Maps
- **SEO:** Ahrefs, Semrush, DataForSEO, Google Trends
- **Organic social:** Facebook Pages, Instagram, LinkedIn, TikTok, YouTube
- **CRM, email and data:** HubSpot, Klaviyo, Google Sheets, BigQuery, Google Slides, Google Docs, SharePoint

This folder is the Claude plugin: `.claude-plugin/plugin.json`, `.mcp.json`, two reference skills, a performance-marketer agent and seven workflow commands. It ships no code and installs no dependencies.

## Install

In Claude Code:

```
/plugin marketplace add markifact/markifact-mcp
/plugin install markifact@markifact
```

On first use Claude opens Markifact's sign-in in your browser (OAuth with PKCE and dynamic client registration; no API keys). Sign in, then connect your ad accounts at <https://www.markifact.com/app/connections>.

## What it adds

| Component | Role |
|---|---|
| `performance-marketer` agent | The operating protocol: discover, inspect, resolve account, run, verify |
| `markifact-overview`, `safe-write-operations` skills | What the MCP server exposes, and the confirmation protocol for anything that changes an account |
| `/launch-google-search`, `/launch-pmax`, `/launch-meta-campaign` | Full campaign builds, created paused for review |
| `/edit-meta-creative`, `/rotate-creative` | Creative changes and rotation |
| `/negative-keyword-sweep` | Find wasted spend in search terms and add negatives |
| `/diagnose-underperformer` | Structured decision tree for a campaign that stopped converting |

## Disclosure

This plugin creates and edits real ad campaigns that spend real budgets. The MCP server separates read operations from write operations, and every write needs your confirmation first.

## Source of truth

The skills, agent and commands here are generated from [`shared/`](../../../shared/) by [`scripts/sync-skills.sh`](../../../scripts/sync-skills.sh). Do not edit them directly.

Privacy: <https://www.markifact.com/privacy-policy> · Terms: <https://www.markifact.com/terms-conditions> · Support: <contact@markifact.com>
