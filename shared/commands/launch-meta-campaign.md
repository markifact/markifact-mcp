---
description: Launch a complete Meta Ads campaign — campaign, ad set, and ad(s) — built paused and ready to review. Use when the user wants a new Facebook/Instagram campaign.
disable-model-invocation: true
argument-hint: [optional brief, e.g. "ecom DTC, $80/day, US, conversions"]
---

## Goal

Stand up a production-ready Meta campaign with one ad set and one or more ad variants in one flow. Always start **paused**.

## Inputs to confirm (batch)

1. Ad account name (substring) — required.
2. **Campaign objective** — `OUTCOME_SALES`, `OUTCOME_LEADS`, `OUTCOME_TRAFFIC`, `OUTCOME_AWARENESS`, `OUTCOME_ENGAGEMENT`, `OUTCOME_APP_PROMOTION`. Required. **This cannot be changed later** — picking wrong forces a full rebuild.
3. Conversion location (for Sales/Leads): website + pixel + event, or lead form, or messaging.
4. **Budget structure** — campaign budget (CBO / Advantage Campaign Budget) or ad-set budget (ABO). Required. **CBO is default-on for new campaigns.** Pick before creating because switching later is messy.
5. Daily budget — required.
6. Targeting: location(s), age range, gender, languages, detailed interests/behaviors (or Advantage+ Audience).
7. Placements: Advantage+ Placements (recommended) or manual. If manual, which platforms (FB, IG, Messenger, Audience Network) and which positions (feeds, stories, reels, etc.).
8. Schedule: continuous or start/end dates.
9. Ad format: single image, single video, carousel, catalog (DPA), flexible / dynamic creative.
10. Creative inputs: image/video file IDs (if user attached) or URLs, primary text, headline, description, CTA, destination URL, Facebook Page ID, optional Instagram account ID.

## Workflow

1. **Discover** ops via `find_operations`:
   `meta_ads_select_accounts`, `meta_ads_create_campaign`, `meta_ads_create_adset`, `meta_ads_create_single_image_ad`, `meta_ads_create_single_video_ad`, `meta_ads_create_carousel_ad`, `meta_ads_create_catalog_ad`, `meta_ads_create_flexible_ad`, `meta_ads_search_targeting`, `meta_ads_list_account_pixels`, `meta_ads_list_custom_audiences`.
2. **Inspect** with `get_operation_inputs`.
3. **Resolve account**: `meta_ads_select_accounts` substring.
4. **Resolve targeting** if user gave interest/behavior names → `meta_ads_search_targeting` to get IDs.
5. **Resolve pixel** for conversions → `meta_ads_list_account_pixels`.
6. **Create campaign** (status=PAUSED) with chosen objective + CBO/ABO setting + budget if CBO.
7. **Create ad set** under that campaign with: optimization goal (matches objective), conversion event, audience, placements, schedule, budget if ABO. Status=PAUSED.
8. **Create ad(s)** — pick the right `meta_ads_create_*_ad` op for the format. Status=PAUSED.
9. **Confirm** to user with IDs + reminder to review and unpause.

Use `safe-write-operations` for every create call.

## Platform-specific rules the model MUST respect

- **Objective is permanent.** Cannot be changed after creation — confirm with the user before creating the campaign.
- **CBO vs ABO decision is locked at campaign creation** in practice. CBO (Advantage Campaign Budget) lets Meta distribute across ad sets — recommended when running 2+ ad sets in one campaign. ABO when each ad set has a distinct test variable (e.g. audience A vs B with controlled spend).
- **Don't run more than 2–4 ad sets in one campaign.** Beyond that, Meta over-concentrates spend on one and the others starve (auction overlap).
- **Learning phase**: each ad set needs **~50 conversions per week** to exit learning. Sub-$50/day campaigns with mid-funnel conversion events almost never exit learning — warn user.
- **Advantage+ Audience** is now the default for most objectives. Manual targeting still works but Meta will broaden it unless you check the "use these settings as audience controls" override.
- **Advantage+ Placements** is preferred unless there's a creative reason to restrict (e.g. vertical-video-only).
- **Catalog ad (DPA)** requires a configured product catalog + product set + pixel with `ViewContent` / `AddToCart` / `Purchase` events. Confirm catalog exists before picking this format.
- **Flexible / dynamic creative ads** let Meta mix multiple images, headlines, primary texts, descriptions, CTAs and find winning combos automatically — recommended for testing.
- **Page ID required for every ad.** Ask user which Page if account has multiple.
- **Always create PAUSED.** Unpause is a separate user action.

## Failure modes & recoveries

- "Pixel not active for selected event" → list available pixels + their active events; ask user to pick a different event or fix pixel implementation.
- "Audience too narrow / Audience too broad" → show estimated reach; suggest widening (drop interests, raise age range) or narrowing (add behavior layer).
- "Creative rejected" → most common: missing disclaimer for special category (housing/credit/employment/social issues). Ask user about category and re-create with declared category.
- "Targeting unavailable in this region" (housing/employment/credit special categories) → can't target by age/gender/zip; declare special category at campaign level.

## Output to user

| Item | Value |
|---|---|
| Account | <name> (id) |
| Campaign | <name> (id, PAUSED, objective=<x>, CBO/ABO=<y>) |
| Ad set | <name> (id) |
| Audience est. reach | <n> daily |
| Ad(s) | format, count |
| Daily budget | <amount> |

End with: *"Review in Ads Manager. Unpause from there or ask me to flip status. After 3–7 days, run `/markifact:diagnose-underperformer` if performance is off."*
