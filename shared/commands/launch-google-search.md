---
description: Launch a complete Google Ads Search campaign — campaign, ad group, responsive search ads, keywords, sitelinks, callouts, and negatives — built paused and ready to review. Use when the user wants to spin up a new Search campaign on Google Ads.
disable-model-invocation: true
argument-hint: [optional brief, e.g. "B2B SaaS, $50/day, US, leads"]
---

## Goal

Stand up a production-ready Google Ads Search campaign in one workflow. Always start **paused** so the user reviews before spending.

## Inputs to confirm with the user (batch these in one question)

1. Account name (substring match) — required.
2. Campaign objective (Leads / Sales / Website traffic) and conversion action to optimize for — required if Smart Bidding is requested.
3. Daily budget — required.
4. Bidding strategy — `MAXIMIZE_CONVERSIONS`, `TARGET_CPA`, `TARGET_ROAS`, `MAXIMIZE_CLICKS`, or `MANUAL_CPC`. Default: `MAXIMIZE_CLICKS` if no conversion data exists yet, else `MAXIMIZE_CONVERSIONS`.
5. Geo + language — required.
6. Final URL — required for RSAs.
7. Keyword themes (3–10 tightly-grouped concepts) — required.
8. Brand name + 1-line offer — required for RSA generation.

If the user gave a brief in the slash argument, parse it first and only ask for what's missing.

## Workflow

1. **Discover required ops once** with `find_operations`. Look for IDs containing:
   `gads_select_accounts`, `gads_create_campaign`, `gads_create_ad_group`, `gads_create_responsive_search_ad`, `gads_add_keyword_to_ad_group`, `gads_create_sitelinks`, `gads_create_callouts`, `gads_create_structured_snippets`, `gads_add_negative_keywords_to_campaigns`, `gads_search_geo_targets`.
2. **Inspect each** with `get_operation_inputs` before first use — never guess Google Ads input shapes.
3. **Resolve account**: `gads_select_accounts` with the user-given name as substring; if multiple match, ask user to disambiguate.
4. **Resolve geo IDs**: `gads_search_geo_targets` for each location string the user provided.
5. **Create campaign** (PAUSED) → returns `campaign_id`. Set `advertising_channel_type=SEARCH`, the chosen bidding strategy, daily budget, geo + language targeting.
6. **Create ad group** under that `campaign_id` → returns `ad_group_id`.
7. **Generate RSA assets** following the rules below, then `gads_create_responsive_search_ad` with `ad_group_id` and the final URL.
8. **Add keywords** with `gads_add_keyword_to_ad_group`. Default match types: phrase + exact for the same theme; avoid pure broad unless the user is on Smart Bidding with sufficient conversion data.
9. **Add extensions** in order: sitelinks → callouts → structured snippets. All optional — skip silently if the user didn't ask for them, but suggest it once at the end.
10. **Add account-level brand-protection negatives** (competitor names if any) and obvious junk negatives (`free`, `jobs`, `careers`, `download`, `crack`, etc. — adjust to vertical) via `gads_add_negative_keywords_to_campaigns`.
11. **Confirm to user**: campaign ID, ad group ID, ad strength, keyword count, link to review in Google Ads UI. Remind they're paused.

Use the `safe-write-operations` skill for every step from #5 onward — each is a write. Batch into a single approval request when possible.

## Platform-specific rules the model MUST respect

- **Prefer dedicated ops over `gads_mutate`.** Only fall back to mutate if no dedicated op exists for the action.
- **RSA asset minimums and limits**: 3–15 headlines (30 chars each), 2–4 descriptions (90 chars each). Generate at least 8 headlines and 3 descriptions for healthy ad strength. Each asset must be unique — Google rejects duplicates.
- **No pinning unless requested.** Pinning headlines or descriptions tanks ad strength and limits Google's optimization. If the user demands pinning (legal disclaimer, brand-required), pin sparingly to position 1.
- **Smart Bidding requires conversions.** If the user picks `TARGET_CPA` or `TARGET_ROAS` and the account has < 30 conversions in the last 30 days, warn that the strategy will struggle and recommend `MAXIMIZE_CONVERSIONS` first.
- **Match types**: don't add the same keyword in multiple match types in the same ad group — phrase + exact is fine across ad groups; same ad group causes self-competition.
- **Geo targeting** uses Google's geo target IDs (numeric) — always resolve via `gads_search_geo_targets`, never pass a country/city name string.
- **Budget shared vs daily**: a campaign-level daily budget is what the user usually means. Don't auto-attach a portfolio budget unless asked.
- **Always start PAUSED** so the user inspects targeting and assets before spending.

## Failure modes & recoveries

- "Bidding strategy requires conversion tracking" → drop to `MAXIMIZE_CLICKS`, tell the user, and suggest enabling conversion import from GA4 first.
- "Ad strength: Poor" after creation → add more headline variety (different angles: benefit, feature, urgency, brand, question), re-create the RSA, leave the old paused.
- "Geo target not found" → ask the user for the more specific name (city + region) or a postcode.
- Account has multiple matching results → list them with IDs and ask user to pick one.

## Output to user

A short table:

| Item | Value |
|---|---|
| Account | <name> (id) |
| Campaign | <name> (id, PAUSED) |
| Ad group | <name> (id) |
| RSAs created | <n> |
| Keywords added | <n> (phrase=<a>, exact=<b>) |
| Extensions | sitelinks=<n>, callouts=<n>, snippets=<n> |
| Negatives added | <n> |

End with: *"Review in Google Ads, then unpause when ready. Ask me to `/markifact:diagnose-underperformer` after 7 days of data."*
