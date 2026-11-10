---
name: safe-write-operations
description: Reference — rules for safely executing write/destructive operations against ad accounts. Always loaded into the performance-marketer agent.
user-invocable: false
---

# Safe write operations

Calls to `run_write_operation` can **spend money, pause campaigns, change budgets, edit live creatives, send emails, or charge customers**. Treat every one as a production change.

## When this protocol applies

The trigger is the **`requires_approval: true`** flag on the operation in the `find_operations` response. If `requires_approval: true`, you **must** use `run_write_operation` and **must** follow the four-step protocol below. If `requires_approval: false`, use `run_operation` and skip this protocol — no confirmation needed.

## The four-step write protocol

**Always** follow this exact sequence before calling `run_write_operation`:

1. **State the change in plain English.** Include the platform, account, object name/ID, and what will change. Example:
   > "I'm about to **pause** the Google Ads campaign **'Brand — US Search'** (ID `1234567890`) in account **Acme US (MCC 999-888-7777)**. This will stop spend immediately."
2. **State the blast radius.** What spend, traffic, revenue, or audience is affected? Pull a quick number from `run_operation` if you don't know.
3. **Ask for explicit confirmation.** Wait for a yes. "Looks good", "go ahead", or "do it" all count. Anything ambiguous = ask again.
4. **Execute, then verify.** After the call returns, fetch the object's current state with `run_operation` and confirm the change landed.

## Hard rules

- **Never batch more than 5 write operations without re-confirming.** If a workflow needs 20 pauses, do the first 5, summarise, ask "continue with the next batch?".
- **Never delete** unless the user said "delete" (not "remove", not "pause"). Prefer pause/disable over delete every time.
- **Never change budgets by more than 50%** in a single call without an extra confirmation step. Big budget moves are easy to fat-finger.
- **Never run a write operation immediately after a model-invoked discovery.** The user must have asked for the change in their own words first.
- **Never assume a connection.** If the user has multiple Google Ads accounts and didn't specify, ask.

## Always check before executing

- **"Will this reset learning?"** On Meta, budget shifts > 20%, audience changes > 10%, placement changes, optimization-event changes, and major creative swaps reset the ad set's learning phase (~7 days of degraded performance). On Google Ads, switching bid strategies resets learning (~1–2 weeks). Warn the user explicitly when a planned change will trigger a reset.
- **"Does this change require fresh ID lookup?"** Structural changes (creating a new RSA, replacing a Meta creative, creating a new ad set) return new IDs. Don't reuse stale IDs from earlier in the conversation after a structural change — re-fetch.
- **"Is there a dedicated op for this?"** On Google Ads, `gads_mutate` is the last-resort generic. If a dedicated op exists (e.g. `gads_update_campaign_budget`), use it — clearer intent, better validation, fewer footguns.

## When `run_write_operation` errors

- Auth error → user must reconnect at <https://www.markifact.com/app/connections>. Stop, don't retry.
- Validation error → re-fetch the operation schema with `get_operation_inputs`, fix the payload, ask the user to confirm the corrected call before retrying.
- Rate limit / quota → back off, do not retry in a loop.
