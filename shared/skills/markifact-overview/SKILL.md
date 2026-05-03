---
name: markifact-overview
description: Reference — what Markifact is, what the MCP server exposes, and the discover→inspect→run pattern. Always loaded into the performance-marketer agent.
user-invocable: false
---

# About Markifact

Markifact is a full performance-marketing **management + reporting** platform. Its remote MCP server at `https://api.markifact.com/mcp` exposes **300+ operations** that let you run accounts end-to-end: launch campaigns, edit creatives, manage audiences, rotate ads, sweep negatives, scale winners, diagnose underperformers, and pull reports across every connected platform. Reporting is a first-class capability — it's just not the only thing Markifact does.

## Platforms covered

- **Google Ads** — Search, PMax, Display, Demand Gen. Full lifecycle: create campaign / ad group / RSA / PMax asset group / sitelinks / callouts / structured snippets / negative lists / portfolio bidding strategies / audience signals / labels. Reporting via GAQL or `gads_get_report`.
- **Meta Ads** (Facebook + Instagram + Messenger) — campaign / ad set / ad lifecycle, custom + lookalike audiences, catalog (DPA), lead forms, CAPI health, ad previews, and the get→create→replace creative-edit workflow.
- **GA4, Google Search Console, Google Merchant Center, Google Sheets, Slides, Drive, BigQuery, Trends, Maps, Business Profile, DV360**.
- **TikTok Ads, LinkedIn Ads, Pinterest Ads, Snapchat Ads, Reddit Ads, Microsoft Ads, Amazon Ads**.
- **Shopify, Klaviyo, HubSpot, Slack, WhatsApp**, plus utilities (web fetch, charts, code, AI media gen, scheduling, lists).

## The 8 MCP tools

The server exposes a small **meta-tool surface** — you don't call 300 tools directly, you discover them at runtime:

| Tool | Purpose |
|------|---------|
| `find_operations` | Search the operation registry by intent. Always step 1. Each result includes `requires_approval: true|false`. |
| `get_operation_inputs` | Get the full input schema (required + optional, types, examples) for an operation. Always step 2. Never guess shapes. |
| `run_operation` | Execute an operation with `requires_approval: false`. No confirmation needed. |
| `run_write_operation` | Execute an operation with `requires_approval: true`. **Always** confirm with the user first (see `safe-write-operations` skill). |
| `list_connections` | List the user's authenticated logins per platform. Rarely needed — see Cross-cutting rules. |
| `get_file_url` | Get a signed URL for a file stored in Markifact. |
| `read_file` | Read the contents of a file the user uploaded or that an op produced. |
| `upload_media` | Upload an **image or video** as a creative asset (e.g. for a Meta ad image, Google Ads asset, etc.). Only images and videos — no documents or other file types. |

## The discover → inspect → run pattern

Every workflow follows the same three steps:

1. **Discover** — call `find_operations` with the user's intent in plain English (e.g. `"create google search campaign"`, `"replace meta ad creative"`). Returns matching operation IDs, descriptions, and a `requires_approval` flag.
2. **Inspect** — call `get_operation_inputs` with the operation ID to see exact required fields. **Reuse** the schema if you already inspected it earlier in the conversation.
3. **Run** — dispatch by the `requires_approval` flag from step 1: `false` → `run_operation` (no confirmation needed); `true` → `run_write_operation` (only after the four-step protocol in `safe-write-operations`). Connections (logins) are auto-resolved — only pass `connection_id` if you've already called `list_connections` because the user has multiple connections on the platform.

**Never** invent operation IDs. **Never** guess input field names. Always discover and inspect first.

## Operation naming conventions (use as discovery hints, not direct calls)

- `gads_*` — Google Ads
- `meta_ads_*` — Meta (Facebook / Instagram)
- `ga4_*` — Google Analytics 4
- `gsc_*` — Google Search Console
- `gmc_*` — Google Merchant Center
- `tiktok_ads_*`, `linkedin_ads_*`, `pinterest_ads_*`, `snapchat_ads_*`, `reddit_ads_*`, `microsoft_ads_*`, `amazon_ads_*`
- `shopify_*`, `klaviyo_*`, `hubspot_*`, `slack_*`

When you see a hint like "use `gads_create_campaign`" anywhere in instructions, that's a hint for what to discover — you still need to `find_operations` and `get_operation_inputs` before calling.

## Cross-cutting rules

- **Account selection**: every reporting and management op needs the platform's `*_select_accounts` first. Account names are matched as a **substring** ("contains"), not exact. If multiple match, ask the user to disambiguate.
- **Report fields**: never guess metric/dimension names. Call the platform's `*_list_report_fields` op first to get valid fields, then build the report.
- **Dedicated ops over generic mutate**: on Google Ads, prefer dedicated ops like `gads_create_campaign`, `gads_update_ad_status` over `gads_mutate`. Only fall back to `gads_mutate` when no dedicated op exists for the action.
- **Connection vs account** — these are two different things, do not confuse them:
  - A **connection** is an OAuth login (e.g. `user1@example.com` connected to Google). One connection can have access to many ad accounts under that login.
  - An **account** is the actual ad account inside the platform (e.g. one specific Google Ads CID, one Meta ad account). You pick it via the platform's `*_select_accounts` op.
- **Connections are auto-resolved.** Ops route to the user's default workspace connection automatically. **Do nothing** about connections in the normal case. Only call `list_connections` if (a) the user has multiple connections on the platform and didn't name one, (b) the user explicitly asks to use a specific connection / login, or (c) an op fails with a connection-not-found / auth error.
- **Accounts are not auto-resolved.** You always need to call the platform's `*_select_accounts` op (substring match on name) before any account-scoped op. If multiple accounts match, ask the user to disambiguate.

## Reporting workflow

Reporting is uniform across every platform (GA4, Google Ads, Meta Ads, GSC, GMC, TikTok, etc.) and always takes the same three steps:

1. **`*_select_accounts`** — resolve the account ID from the user's account name (substring match). Skip if the user already gave you an exact ID.
2. **`*_list_report_fields`** — fetch valid metric and dimension names. Never guess field names; they vary per platform and per report type.
3. **`*_get_report`** — run the report with the resolved account ID, validated fields, and the date range.

You can pull multiple accounts in one report — either aggregated, or split by account by adding the account dimension.

## Working with files

- **From an op output**: ops may return a `file_id` (often when a result is too large to inline). Use `get_file_url(file_id)` to get a shareable URL, then embed in your reply with Markdown: `![chart](url)` for images, `[name](url)` for other files. Use `read_file(file_id)` to inspect contents yourself.
- **Sharing files with the user**: never paste raw `file_id` values. Always go through `get_file_url` and embed via Markdown.
- **Uploading new media**: call `upload_media` to let the user upload an image or video for use as a creative asset (e.g. Meta ad image, Google Ads asset). Images and videos only — no documents.
- **Passing a file to another op**: if an op expects a file as input, pass the `file_id` it returned earlier. If an op expects a URL, pass the full URL from `get_file_url`, not the raw `file_id`.

## Errors

- Auth error → user must reconnect at <https://www.markifact.com/app/connections>. Stop, don't retry.
- "Operation requires approval" → see `safe-write-operations` skill; never bypass.
- Validation error → re-fetch schema with `get_operation_inputs`, fix payload, re-confirm with user before retrying.
