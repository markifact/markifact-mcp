---
name: getting-started
description: Learn how to use the Markifact plugin to discover and run marketing operations, select connections and accounts, and work with files. Use for onboarding or guidance on the plugin's workflow.
---

# Getting Started

Markifact provides 1,000+ operations across 50+ advertising, analytics, commerce, and productivity platforms, including Google Ads, Meta Ads, TikTok Ads, LinkedIn Ads, Google Analytics 4, Shopify, and Google Sheets. Use it to create campaigns and ads, refresh ad creatives, update budgets and bids, manage audiences, analyze performance, generate reports, and move data between connected platforms.

Never assume a requested action is unavailable without searching. These examples are not the full capability list; discover the operations available to the authenticated user for the task at hand.

## Find, inspect, run

Work from the user's task and ask only for missing inputs. Do not run operations just because the plugin is enabled.

1. **Find:** Call `find_operations` with a short platform-and-action query, such as `Google Ads create campaign`, `Meta Ads update ads`, or `GA4 report`. Use the returned operation ID. Try a clearer query or a higher `limit` if the expected operation is missing. If no dedicated operation fits, search for and inspect the platform's generic fallback, such as `gads_mutate`, before concluding the action is unsupported. Do not execute writes merely to test whether a capability exists.
2. **Inspect:** Call `get_operation_inputs` to get the operation's fields, types, and requirements. Reuse schemas already fetched in the conversation. Prefer a dedicated operation when available.
3. **Run:** Build `input_data` using only fields from the schema. For `requires_approval: false`, use `run_operation`. For `requires_approval: true`, explain the action, target, and key values, confirm with the user, then use `run_write_operation`. Present budgets and bids in the ad account's currency, such as "$100 daily", while following the schema's units in tool inputs.

Operation IDs are inputs to the execution tools, not standalone tools. This flow also applies to prerequisite operations such as account selection and report-field listing.

For reports, resolve account names through the platform's account-selection operation, using substring matches. Discover its report-field operation to check metric and dimension names; never guess them. Resolve the date range before execution. Prefer `gads_get_report` for Google Ads and use `gads_run_gaql_query` for advanced or unsupported reporting queries, after discovery and inspection.

## Connections and accounts

A **connection** is a saved, authenticated link between a Markifact workspace and an external platform, such as Google Ads or Meta Ads. It gives operations access through a particular platform login or set of credentials. Connecting Markifact to your AI assistant does not itself connect those external platforms.

Users create and manage connections on the [Connections page](https://www.markifact.com/app/connections): choose a platform, add a connection, and complete its sign-in and authorization flow or enter credentials there when required. Direct users to this page to update, reconnect, or remove connections. `list_connections` only lists saved connections; it does not create or edit them. Keep credential entry in Markifact's connection flow.

A connection is different from a platform account. For example, one Google Ads connection may provide access to several ad accounts. `connection_id` selects the saved login; account, customer, and property IDs are separate inputs selecting resources accessible through it.

Connections usually resolve automatically when `connection_id` is omitted. Use `list_connections` when the user wants a specific saved login or has multiple connections for the same platform; optionally filter by `connection_type`, such as `gads` or `meta_ads`. Results include `id`, `type`, and `display_name`. Pass the selected `id` as `connection_id` and reuse it throughout the task. Discover the platform's account-selection operation when the intended account ID is unknown.

If a connection is missing or expired, direct the user to the connections page. If the error identifies MCP connection restrictions, the user may need to update the server's allowed connections. Retry after access is restored.

## Files and uploads

Some operations return a `file_id` and a small `data_preview` when the full dataset is too large to include in the response. The preview is only a sample; the file holds the full result.

- **Inspect:** Call `read_file` directly with the returned `file_id`. It returns numbered text lines for JSON, CSV, logs, and similar files. Use `offset` and `limit` to inspect additional sections.
- **Reuse:** Pass the exact file ID inside double braces in another operation's input, for example `{"data": "{{file-xe3fw}}"}`. Markifact loads the full contents automatically: JSON becomes an object or list, CSV/XLSX becomes rows, other binary files become bytes, and in text fields such as `image_url` or `video_url` an image, video or audio file becomes its file URL. No manual copying or parsing is needed.
- **Open or share:** Call `get_file_url` with the full returned filename, including its extension when present. It provides a directly accessible signed link valid for one hour. Share the exact URL as a Markdown link or image, rather than a raw file ID or placeholder. Use the URL for operation fields that expect a URL. An operation's `file_url` may instead require Markifact login.
- **Upload media:** Call `upload_media` when the user needs to supply an image or video, such as ad creative. Pass the returned media URL to a later operation that accepts it. This tool supports images and videos only.

Summarize results and any failures. If a write's outcome is uncertain, check the resulting state before retrying to avoid duplicates.

## Report feedback

If you find a likely Markifact bug, missing capability, or product limitation after discovery, explain it and offer to report it. Do not report third-party platform errors, policies, rate limits, or user configuration as Markifact bugs.

Call `report_markifact_feedback` only when the user asks you to submit feedback or accepts your offer. Supply `category` (`bug`, `feature_request`, `improvement`, or `other`), a concise English `title` and `description`, `impact` (`low`, `medium`, or `high`), and relevant `operation_ids` when known. Describe expected versus actual behavior and user impact using minimal non-sensitive evidence. Exclude credentials, raw payloads, and unrelated customer data. Confirm submission after the tool reports success.
