# Markifact - Ads & Analytics for Antigravity

Run Google Ads, Meta Ads, TikTok Ads, LinkedIn Ads, GA4, Shopify, HubSpot and 50+ more platforms from [Antigravity](https://antigravity.google). 1000+ operations through Markifact's hosted MCP server, with approval required before any write.

This folder is an Antigravity plugin: `plugin.json`, `mcp_config.json`, ten skills and a logo. It ships no code and installs no dependencies.

## Install

From the Antigravity Marketplace: open **Customizations**, select **Marketplace**, find **Markifact - Ads & Analytics** and click **+**.

On first use Antigravity opens Markifact's sign-in in your browser (OAuth with PKCE and dynamic client registration; no API keys). Sign in, then connect your ad accounts at <https://www.markifact.com/app/connections>.

## What it adds

| Skill | Role |
|---|---|
| `/markifact-agent` | The performance-marketer operating protocol: discover, inspect, resolve account, run, verify |
| `/markifact-overview` | What the MCP server exposes and how to navigate its 1000+ operations |
| `/safe-write-operations` | The confirmation protocol for anything that changes an account |
| `/launch-google-search`, `/launch-pmax`, `/launch-meta-campaign` | Full campaign builds, created paused for review |
| `/edit-meta-creative`, `/rotate-creative` | Creative changes and rotation |
| `/negative-keyword-sweep` | Find wasted spend in search terms and add negatives |
| `/diagnose-underperformer` | Structured decision tree for a campaign that stopped converting |

## Disclosure

This plugin creates and edits real ad campaigns that spend real budgets. The MCP server separates read operations from write operations, and the skills instruct the agent to confirm every write with you first.

## Network and credentials

- Endpoint: `https://api.markifact.com/mcp` only. All platform API calls happen server-side.
- Credentials: your Markifact account via OAuth. Platform connections (Google Ads, Meta, and so on) are authorised inside Markifact and never pass through Antigravity.

## Source of truth

The skills here are generated from [`shared/`](../../../shared/) by [`scripts/sync-skills.sh`](../../../scripts/sync-skills.sh). Do not edit them directly.

Privacy: <https://www.markifact.com/privacy-policy> · Terms: <https://www.markifact.com/terms-conditions> · Support: <contact@markifact.com>
