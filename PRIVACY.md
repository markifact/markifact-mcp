# Markifact MCP Privacy Policy

**Effective Date:** May 3, 2026
**Last Updated:** May 3, 2026

## For Anthropic Reviewers

This privacy policy is specific to the Markifact MCP plugin and supplements Markifact's main [Privacy Policy](https://www.markifact.com/privacy-policy), [DPA](https://www.markifact.com/dpa), and [Trust Center](https://www.markifact.com/trust-center).

The plugin connects to Markifact's production MCP server at `https://api.markifact.com/mcp`, operated by OPTIMIZATION UP L.L.C-FZ (Meydan Free Zone, Dubai, UAE), trading as **Markifact**.

## Introduction

Markifact ("we," "our," "us") is a Model Context Protocol server that enables AI assistants (Claude, ChatGPT, Cursor, Codex, Windsurf, Gemini CLI, and any other MCP-compliant client) to manage advertising and marketing operations on your behalf across Google Ads, Meta Ads, GA4, DV360, LinkedIn Ads, TikTok Ads, Pinterest Ads, Snapchat Ads, Reddit Ads, Microsoft Ads, Amazon Ads, Shopify, HubSpot, Klaviyo, Slack, WhatsApp, and more.

This document explains the data the MCP plugin causes to be collected and processed. It supplements, and does not replace, Markifact's main privacy policy at <https://www.markifact.com/privacy-policy>.

## Scope of this repository

This GitHub repository (`markifact/markifact-mcp`) contains **no user data**. It is a distribution surface for plugin manifests, slash commands, agent prompts, and skills. Installing or downloading this repository alone does not transmit any data.

User data is processed only when you connect the Markifact MCP server through your AI client and execute tools. From that point on, the controls in Markifact's main privacy policy apply.

## Information We Collect

### Authentication Data

- **OAuth Tokens** (Markifact + per-platform): access and refresh tokens issued via OAuth 2.1 with PKCE for Markifact, and per-platform tokens for Google Ads, Meta Ads, LinkedIn Ads, TikTok Ads, Microsoft Ads, Snapchat, Pinterest, Reddit, Amazon Ads, Shopify, HubSpot, Klaviyo, Slack, WhatsApp, etc.
- **Account Identifiers**: ad account IDs (Google Ads CIDs, Meta ad account IDs, etc.) for the connections you authorize at <https://www.markifact.com/app/connections>.
- **Session tokens** for the AI client's MCP session.

### Operation Data

- **Operation parameters**: the inputs you (or the AI on your behalf) submit to MCP operations, including campaign settings, budgets, targeting, audiences, copy, headlines, descriptions, keywords, and bidding strategies.
- **Creative assets**: images and videos uploaded via `upload_media` for use as ad creative. The plugin only accepts images and videos via `upload_media`; no other file types.
- **Reporting parameters**: metrics, dimensions, date ranges, and filters you request from `*_get_report` operations.

### Performance and Account Data

- **Reports**: clicks, impressions, conversions, spend, ROAS, CPA, frequency, and other metrics returned from connected ad platforms when you request a report.
- **Account state**: campaign / ad set / ad / audience metadata returned from `*_select_accounts`, `*_get_*_settings`, and equivalent read operations.

### Usage Data

- **Tool invocations**: which MCP tool was called, the operation ID, timestamps, and a redacted parameter summary (sensitive content excluded).
- **Error logs**: technical errors for troubleshooting.
- **Workflow execution logs**: retained per your subscription plan (1 to 30 days), as described in the main privacy policy.

## What We Do NOT Collect

- **Conversation history with your AI client.** Your prompts to Claude, ChatGPT, Cursor, etc. stay in your AI client. The MCP server only sees the tool calls the client decides to make.
- **Cross-server data.** Other MCP servers your client may have configured.
- **Browsing activity** outside the MCP tool calls.
- **Customer data for AI training.** Markifact does not use customer data to develop, improve, or train generalized AI/ML models. See "AI Features" in the main privacy policy.

## How We Use Your Data

We use the data above only to:

- Authenticate you and your platform connections.
- Execute the MCP operations you (or your AI client on your behalf) request.
- Return reports and account state to your AI client.
- Diagnose and fix service issues.
- Maintain audit trails of write operations against your ad accounts.

## Data Sharing and Disclosure

We do not sell, rent, or trade your data. We share data only as follows:

### With ad platforms

To execute the operations you request, the MCP server transmits the necessary parameters to the underlying APIs of the platforms you connected (Google Ads, Meta Ads, LinkedIn Ads, TikTok Ads, etc.). Scope is limited to the OAuth permissions you granted at <https://www.markifact.com/app/connections>.

### With service providers

Markifact relies on a limited set of sub-processors:

- **Cloud infrastructure**: Google Cloud Platform and Vercel (EU regions).
- **Database**: Neon on AWS (EU region).
- **Payments**: Stripe.
- **Email delivery**: Amazon Web Services SES (EU region).
- **AI providers** (only when you explicitly use AI-powered operations).

All sub-processors are bound by confidentiality and data-protection obligations. The full list and the [DPA](https://www.markifact.com/dpa) apply automatically to all customers.

### Legal compliance

We may share data when required by law, court order, or to protect our or our users' legal rights, as described in the main privacy policy.

## Data Security

- **OAuth 2.1 + PKCE** on every connection.
- **Dynamic client registration** (RFC 7591) for CLI clients.
- **TLS / HTTPS** for all transmission. No unencrypted HTTP accepted.
- **Encrypted token storage** server-side. OAuth tokens never leave Markifact and are never sent to the AI client.
- **Least-privilege access** internally; restricted database access.
- **MCP `ToolAnnotations`** (`readOnlyHint`, `destructiveHint`) on every tool, plus a `requires_approval` flag on every operation. Writes are gated behind explicit user confirmation. See [SECURITY.md](SECURITY.md) and [skills/safe-write-operations/SKILL.md](skills/safe-write-operations/SKILL.md).

## Data Retention

- **OAuth tokens** (Markifact and per-platform): retained while the connection is active. Revoked immediately on disconnect.
- **Workflow execution logs**: 1 to 30 days, depending on your plan.
- **Account data**: retained while your account is active. Deleted on account closure per the schedule in the main policy (typically within 30 days of request).

## Your Rights

Depending on your jurisdiction, you may have the right to access, rectify, delete, port, or restrict processing of your personal data, and to object to certain processing. California (CCPA/CPRA) and EEA/UK residents have additional rights. See the "Your Rights" section of the [main privacy policy](https://www.markifact.com/privacy-policy).

To exercise any right, contact <contact@markifact.com>. We will respond within the timeframe required by applicable law (typically 30 to 45 days).

## Revoking Access

You can revoke the MCP plugin's ability to act on your accounts at any time:

- **Disconnect a platform** at <https://www.markifact.com/app/connections>. The corresponding OAuth tokens are revoked immediately.
- **Revoke at the platform** (also covered in [CONNECTING.md](CONNECTING.md)):
  - Google: <https://myaccount.google.com/permissions>
  - Meta (Facebook / Instagram / Threads): <https://www.facebook.com/settings?tab=business_tools>
  - TikTok: <https://www.tiktok.com/setting/security>
  - LinkedIn: <https://www.linkedin.com/psettings/permitted-services>
  - Microsoft: <https://account.live.com/consent/Manage>
- **Disconnect the MCP connector** in your AI client (Claude / ChatGPT / Cursor / Codex / Gemini CLI). Markifact's bearer token for that client is invalidated.

Existing campaigns continue running on the underlying platforms; revocation only stops Markifact's future access.

## International Data Transfers

Markifact's application servers and production database are hosted in EU regions. Some sub-processors (payments, email infrastructure, AI providers) may process limited data outside the EU under Standard Contractual Clauses or equivalent safeguards. See the [DPA](https://www.markifact.com/dpa).

## Third-Party Services

The MCP plugin causes calls to third-party APIs you have explicitly authorized:

- **Google APIs** (Ads, Analytics, Search Console, Merchant Center, Drive, BigQuery, DV360, Business Profile): subject to [Google's Privacy Policy](https://policies.google.com/privacy) and the [Google API Services User Data Policy](https://developers.google.com/terms/api-services-user-data-policy), including Limited Use.
- **Meta APIs** (Facebook / Instagram / Threads ads): subject to [Meta's Privacy Policy](https://www.facebook.com/privacy/policy/).
- **TikTok, LinkedIn, Microsoft, Pinterest, Snapchat, Reddit, Amazon, Shopify, HubSpot, Klaviyo, Slack, WhatsApp**: each subject to its own provider's terms.

Markifact is not responsible for the privacy practices of third-party services beyond its own use of their APIs.

## Children's Privacy

Markifact is not directed to children under 13 and we do not knowingly collect personal information from children. If you believe we have, contact <contact@markifact.com>.

## Changes to This Policy

We may update this MCP-specific policy to reflect changes in the plugin or the underlying service. The "Last Updated" date at the top will reflect the change. Material changes will also be reflected in updates to the [main privacy policy](https://www.markifact.com/privacy-policy).

## Contact

- **Email:** <contact@markifact.com>
- **Subject:** "Markifact MCP Privacy"
- **Response time:** Within 2 business days

**Company:**
OPTIMIZATION UP L.L.C-FZ (trading as Markifact)
Meydan Free Zone, Dubai, UAE
<https://www.markifact.com>

**Main Privacy Policy:** <https://www.markifact.com/privacy-policy>
**DPA:** <https://www.markifact.com/dpa>
**Terms:** [TERMS.md](TERMS.md) and <https://www.markifact.com/terms-conditions>
**Trust Center:** <https://www.markifact.com/trust-center>
