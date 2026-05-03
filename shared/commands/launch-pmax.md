---
description: Launch a Google Ads Performance Max campaign with a complete asset group, audience signals, and (for ecom) listing groups. Built paused for review. Use when the user wants a new PMax campaign.
disable-model-invocation: true
argument-hint: [optional brief, e.g. "ecom apparel, $100/day, US/CA, ROAS 3"]
---

## Goal

Stand up a complete PMax campaign with one fully-loaded asset group and (when applicable) Merchant Center listing scope. Always start **paused**.

## Inputs to confirm with the user (batch these)

1. Account name (substring) — required.
2. Goal: `Sales` (ROAS-driven, usually with Merchant Center) or `Leads` (CPA-driven). Required.
3. Daily budget. Required.
4. Bidding: `MAXIMIZE_CONVERSIONS` (default for leads/no history), `MAXIMIZE_CONVERSION_VALUE` (default for sales), or with target (`TARGET_CPA` / `TARGET_ROAS`). Required.
5. Geo + language. Required.
6. Final URL(s). Required.
7. Brand name + 1-line value prop. Required.
8. **Asset inventory the user can provide**: logos (1:1 + 4:1), images (landscape, square, portrait), videos (optional but Google will auto-generate if missing). Ask which they have; you'll generate text assets, but Google won't accept text-only PMax for most goals.
9. **For Sales**: Merchant Center ID + product scope (all products, by brand, by product type, by custom label). Required.
10. **Audience signals** (optional but recommended): existing customer lists, website visitors, custom segments by interest/intent. These are *hints*, not targeting.

## Workflow

1. **Discover** with `find_operations`. Look for:
   `gads_select_accounts`, `gads_create_campaign`, `gads_create_pmax_asset_group`, `gads_create_image_asset`, `gads_create_headline_asset`, `gads_create_description_asset`, `gads_update_audience_signals`, `gads_update_listing_groups`, `gads_pmax_channel_split`, `gads_search_geo_targets`.
2. **Inspect each** with `get_operation_inputs`.
3. **Resolve account**: `gads_select_accounts` with substring match.
4. **Resolve geo**: `gads_search_geo_targets`.
5. **Create campaign** (PAUSED). Set `advertising_channel_type=PERFORMANCE_MAX`, the bidding strategy + target, daily budget, geo + language. For Sales: link the Merchant Center ID.
6. **Create asset group** under the campaign → returns `asset_group_id`.
7. **Upload image assets** with `gads_create_image_asset` for each user-provided image and logo. Capture the returned asset IDs.
8. **Create text assets** with `gads_create_headline_asset` and `gads_create_description_asset` — generate the variety described in the rules below.
9. **Attach assets to the asset group** as the create-asset ops require (see each op's schema — some accept an `asset_group_id` directly).
10. **Audience signals** — `gads_update_audience_signals` with chosen segments. Skip if user has none, but explain that it slows ramp-up.
11. **Listing groups** (Sales only) — `gads_update_listing_groups` to scope which products PMax can advertise. Default: all products. Refine if the user wants brand/category exclusions.
12. **Confirm**: campaign id, asset group id, asset count by type, audience signal count, listing scope. Remind user it's paused.

Use the `safe-write-operations` skill from step 5 onward.

## Platform-specific rules the model MUST respect

- **PMax asset minimums** (Google enforces these):
  - Headlines: 3 minimum, 5+ recommended (30 chars each).
  - Long headlines: 1 minimum, 5 recommended (90 chars each).
  - Descriptions: 2 minimum, 5 recommended; first one short ≤ 60 chars, others 90 chars.
  - Long description: 1 (90 chars).
  - Business name: 1 (25 chars).
  - Logos: 1+ (1:1 required, 4:1 recommended).
  - Images: 1+ landscape (1.91:1, 1200×628), 1+ square (1:1, 1200×1200), portrait (4:5) recommended.
  - Videos: 0+ — if none provided, Google auto-generates from your images. Auto-generated video gets less reach; warn user.
- **Audience signals are hints, not targeting.** PMax will go beyond them. Don't over-promise audience exclusivity.
- **Listing groups for Sales** scope which products PMax serves — leaving it open ("all products") is the default and usually the right call for the first 2–4 weeks.
- **Channel mix is not directly controllable.** Use `gads_pmax_channel_split` after a week of data to see where spend went (Search, Display, YouTube, Discover, Maps).
- **Don't create multiple PMax campaigns in the same account targeting overlapping products.** They cannibalize each other in the same auction.
- **Bidding strategy switch resets learning** — pick the right one up front. Use `MAXIMIZE_CONVERSION_VALUE` (no target) for first 2 weeks of a Sales PMax, then add `TARGET_ROAS` once you have ≥ 30 conversions.
- **Always start PAUSED.**

## Failure modes & recoveries

- "Asset group missing required asset" → tell user exactly which type (e.g. "needs a 1:1 logo") and ask them to upload.
- "Merchant Center not linked" → tell user to link MC in Google Ads UI; can't be done via op.
- Bidding target unrealistic (e.g. TARGET_ROAS 10 with no history) → warn and suggest dropping the target for the first 2 weeks.
- After launch, if PMax goes 80%+ to Display/YouTube and conversions are weak, that's the most common PMax failure — tell user to add more text/image variety, refine audience signals, or switch to a Search campaign for that intent.

## Output to user

| Item | Value |
|---|---|
| Account | <name> (id) |
| Campaign | <name> (id, PAUSED) |
| Asset group | <name> (id) |
| Headlines / long / desc / long-desc | counts |
| Logos / images / videos | counts |
| Audience signals | <n> segments |
| Listing scope | all products / <filters> |
| Daily budget / bidding | <values> |

End with: *"Unpause when ready. Check `gads_pmax_channel_split` after 7 days to see where spend is going."*
