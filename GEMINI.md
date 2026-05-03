# Markifact

You have access to the **Markifact** MCP server at `https://api.markifact.com/mcp`. It exposes 8 meta-tools that let you run 300+ marketing operations across Google Ads, Meta Ads, GA4, DV360, Shopify, HubSpot, TikTok, LinkedIn, Pinterest, Snapchat, Microsoft, Amazon, Reddit Ads, Klaviyo, Slack, and more.

## The 8 tools

- `find_operations(query)` — search the operation registry. Always call this first. Each result includes a `requires_approval` flag.
- `get_operation_inputs(operation_id)` — get required + optional input fields.
- `run_operation(operation_id, inputs)` — execute an op with `requires_approval: false`. No confirmation needed.
- `run_write_operation(operation_id, inputs)` — execute an op with `requires_approval: true`. Always confirm with the user first.
- `list_connections()` — list authenticated platform logins. Connections auto-resolve to the user's default — only call this when the user has multiple logins on a platform or names a specific one.
- `get_file_url(file_id)` — signed URL for a Markifact-stored file. Always use this when sharing a file with the user; embed via Markdown.
- `read_file(file_id)` — read a file the user uploaded or an op produced.
- `upload_media(...)` — upload an image or video as a creative asset (no other file types).

## Discover → Inspect → Run

Never invent operation IDs. Never guess input field names. Always:

1. `find_operations("plain english intent")` — read the `requires_approval` flag on each result.
2. `get_operation_inputs(chosen_id)`.
3. Dispatch by the flag: `requires_approval: false` → `run_operation(...)`; `requires_approval: true` → `run_write_operation(...)` after the four-step safety protocol.

## Connection vs account

- A **connection** is an OAuth login (e.g. `user@example.com`). One connection can hold many ad accounts. Auto-resolved — do nothing about it by default.
- An **account** is a specific ad account (Google Ads CID, Meta ad account). Always resolve via the platform's `*_select_accounts` op (substring match on the account name).

## Reporting workflow

Reports are uniform across every platform:

1. `*_select_accounts` to resolve the account ID.
2. `*_list_report_fields` to get valid metric and dimension names — never guess.
3. `*_get_report` with the resolved IDs, validated fields, and date range.

## Write-operation safety

Before any `run_write_operation`:

1. State the change in plain English (platform, account, object, what changes).
2. State the blast radius ($ spend, traffic, audience affected).
3. Wait for an explicit yes from the user.
4. Execute, then verify by re-reading the object.

Never delete unless the user said "delete". Never batch more than 5 writes without re-confirming. Never change a budget by more than 50% in one shot.

## Slash commands

- `/markifact:launch-google-search` *(write)* — full Google Search campaign build, paused
- `/markifact:launch-pmax` *(write)* — full Performance Max build, paused
- `/markifact:launch-meta-campaign` *(write)* — full Meta campaign + ad set + ad(s), paused
- `/markifact:edit-meta-creative` *(write)* — change URL / copy / CTA via the get→create→replace flow
- `/markifact:rotate-creative` *(write)* — pause fatigued ads, ship variants paused
- `/markifact:negative-keyword-sweep` *(write)* — add negatives at the right scope
- `/markifact:diagnose-underperformer` *(read-only)* — structured decision-tree diagnosis

If an MCP call returns an auth error, tell the user to reconnect at <https://www.markifact.com/connections>.
