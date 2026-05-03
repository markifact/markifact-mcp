---
description: Pause fatigued ads and ship fresh creative variants in their place. Works on both Meta and Google Ads. Use when CTR is dropping, frequency is climbing, or the user says "creative is tired" / "let's refresh ads". Always starts new variants paused.
disable-model-invocation: true
argument-hint: [scope, e.g. "Meta campaign Spring Sale" or "Google ad group X"]
---

## Goal

Identify creative that's stopped performing, pause it, and ship variants. Preserve learning where possible. Always start new ads **paused** for review.

## Inputs to confirm (batch)

1. Account name (substring) — required.
2. Platform — Meta or Google Ads (or both, if user says "all my ads") — required.
3. Scope — campaign / ad set / ad group, or "all active" — required.
4. Lookback window — default 30 days.
5. Fatigue thresholds — defaults below; allow override:
   - **Meta**: frequency > 3.5 AND CTR has dropped > 25% vs the prior period of equal length.
   - **Google**: impressions stagnant or down > 20% WoW with CTR drop > 20%, OR RSA ad strength `Poor` / `Average`.
6. Minimum sample size before pausing — default ≥ 100 clicks AND ≥ 7 days of data. Refuse to pause anything below this.
7. Variant strategy — `tweak` (small copy/headline change), `angle` (new hook/benefit), or `format` (e.g. image → video). Default `angle`.
8. How many variants per fatigued ad — default 2.

## Workflow

### Meta path

1. **Discover** ops:
   `meta_ads_select_accounts`, `meta_ads_list_ads`, `meta_ads_get_report`, `meta_ads_list_report_fields`, `meta_ads_update_ad_status`, `meta_ads_duplicate_ad`, `meta_ads_get_ad_creative`, `meta_ads_create_ad_creative`, `meta_ads_replace_ad_creative`, `meta_ads_create_single_image_ad` / `_carousel_ad` / `_video_ad` / `_flexible_ad`.
2. **Inspect.**
3. **Resolve account** (substring).
4. **Pull ad-level report** for the scope, current period vs prior period of equal length. Required fields: spend, impressions, clicks, CTR, conversions, frequency, ad_id, ad_name, adset_id, campaign_id.
5. **Apply thresholds** → list of fatigued ads. Drop anything under the sample-size floor.
6. **For each fatigued ad, build a variant**:
   - `tweak` → `meta_ads_get_ad_creative` → modify primary text / headline → `meta_ads_create_ad_creative` → `meta_ads_duplicate_ad` (or create a fresh ad in the same ad set with the new creative) — start PAUSED.
   - `angle` → generate a new creative concept (different hook, benefit, or pain point) → use `meta_ads_create_single_image_ad` or `_video_ad` (etc.) with `status=PAUSED` in the same ad set.
   - `format` → call the matching format's create op with the new asset.
7. **Show user a preview**: each fatigued ad → its proposed variant(s), reasoning. Wait for approval.
8. **Execute**:
   a. Create the variants (PAUSED).
   b. Pause the originals via `meta_ads_update_ad_status`.
9. **Confirm** counts.

### Google path

1. **Discover**:
   `gads_select_accounts`, `gads_get_report`, `gads_list_report_fields`, `gads_update_ad_status`, `gads_update_asset_status`, `gads_create_responsive_search_ad`, `gads_edit_responsive_search_ad`, `gads_create_responsive_display_ad`, `gads_create_demand_gen_*_ad`.
2. **Inspect.**
3. **Resolve account.**
4. **Pull ad / asset report** at the right granularity. For Search, pull at the ad level + asset performance. For PMax, pull asset group asset performance.
5. **Apply thresholds** (drop low-sample). For Search RSAs, also flag any with ad strength `Poor` / `Average`.
6. **For each fatigued RSA**:
   - `tweak` → `gads_edit_responsive_search_ad` is allowed for asset additions; otherwise create a new RSA via `gads_create_responsive_search_ad` in the same ad group.
   - `angle` → create a new RSA with fresh headline/description angles (different benefit, different hook, different proof).
   - For PMax: `gads_update_asset_status` to pause low-performing individual assets, then add fresh ones via `gads_create_headline_asset` / `_description_asset` / `_image_asset`.
7. **Show user the proposed RSAs / assets** before creating.
8. **Execute**:
   a. Create new ads (PAUSED). For PMax assets, add as ENABLED but the asset group continues running.
   b. For old ads: pause via `gads_update_ad_status` once the new variant is live (don't pause until the replacement exists).
9. **Confirm.**

Use `safe-write-operations` for every status flip and every create. Batch into one approval where possible.

## Platform-specific rules the model MUST respect

- **Sample size floor.** Never pause an ad with < 100 clicks or < 7 days of data — too noisy.
- **Don't pause a winner because frequency is high if it's still converting.** Frequency > 3.5 only matters when paired with declining CTR or CPA creep.
- **Meta**: pausing inside an active ad set does NOT reset learning. Deleting or removing the ad set's only active ad can. Always create the variant first, then pause the original.
- **Meta carousels and dynamic creative** look "fatigued" wrongly — Meta is already auto-rotating cards. For carousel, look at card-level CTR before deciding.
- **Google Search RSAs**: `gads_edit_responsive_search_ad` is the right op for adding/swapping assets in place. Use create-new only when the change is structural (new URL, new ad group).
- **PMax assets** are paused individually with `gads_update_asset_status`. Don't pause the whole asset group — that kills the campaign.
- **Don't ship more than 3 active RSAs per ad group.** Beyond that, delivery dilutes and learning slows.
- **Always start new variants PAUSED on Meta** (so user reviews); Google PMax assets can be ENABLED since they live inside an active asset group.

## Failure modes & recoveries

- Variant creation fails (rejected creative, missing pixel, etc.) → don't pause the original. Report the failure and stop.
- All ads in scope below sample floor → tell user there's not enough data; suggest waiting or widening lookback window.
- User asks to "pause everything underperforming" without a concrete spend baseline → push back; require a primary KPI and threshold.

## Output to user

Preview before execute:

| Original ad | Performance | Proposed variant(s) | Reason |
|---|---|---|---|
| Spring Promo Img 1 (123) | freq 4.2, CTR -38% WoW | new image ad: new hook "..." | fatigue |

After execute:

| Status | Count |
|---|---|
| Variants created (PAUSED) | <n> |
| Originals paused | <n> |
| Skipped (low sample) | <n> |
| Failed | <n> |

End with: *"Review variants in Ads Manager / Google Ads, then unpause the new ones. Re-check in 7 days."*
