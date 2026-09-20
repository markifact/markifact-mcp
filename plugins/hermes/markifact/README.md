# Markifact - Ads & Analytics for Hermes Agent

Run Google Ads, Meta Ads, TikTok Ads, LinkedIn Ads, GA4, Shopify, HubSpot and 50+ more platforms from [Hermes Agent](https://hermes-agent.nousresearch.com). 1000+ operations through Markifact's hosted MCP server, with approval required before any write.

This directory is a portable [Agent Plugins v1](https://agent-plugins.org) package: `plugin.json`, `mcp.json`, and ten skills. It ships no code and installs no dependencies.

## Install

From the Hermes plugin catalog:

```bash
hermes plugins install markifact
hermes plugins enable markifact
hermes gateway restart
```

Or straight from this repository:

```bash
hermes plugins install markifact/markifact-mcp#plugins/hermes/markifact
```

On first use Hermes opens Markifact's OAuth sign-in in your browser (OAuth 2.1 with PKCE and dynamic client registration; no API keys). Sign in, then connect your ad accounts at <https://www.markifact.com/app/connections>.

## What it adds

| Skill | Role |
|---|---|
| `markifact-agent` | The performance-marketer operating protocol: discover, inspect, resolve account, run, verify |
| `markifact-overview` | What the MCP server exposes and how to navigate its 1000+ operations |
| `safe-write-operations` | The four-step confirmation protocol for anything that changes an account |
| `launch-google-search`, `launch-pmax`, `launch-meta-campaign` | Full campaign builds, created paused for review |
| `edit-meta-creative`, `rotate-creative` | Creative changes and rotation |
| `negative-keyword-sweep` | Find wasted spend in search terms and add negatives |
| `diagnose-underperformer` | Structured decision tree for a campaign that stopped converting |

Load any of them with `skill_view("markifact:<skill>")`.

## Disclosure

This plugin creates and edits real ad campaigns that spend real budgets. The MCP server separates read operations from write operations and the skills instruct the agent to confirm every write with you first, but that confirmation is enforced by skill instructions and the operation's `requires_approval` flag, not by Hermes itself.

## Network and credentials

- Endpoint: `https://api.markifact.com/mcp` only. All platform API calls happen server-side.
- Credentials: your Markifact account via OAuth. Platform connections (Google Ads, Meta, and so on) are authorised inside Markifact and never pass through Hermes.

## Source of truth

The skills here are generated from [`shared/`](../../../shared/) by [`scripts/sync-skills.sh`](../../../scripts/sync-skills.sh). Do not edit them directly.

Privacy: <https://www.markifact.com/privacy-policy> · Terms: <https://www.markifact.com/terms-conditions> · Support: <contact@markifact.com>
