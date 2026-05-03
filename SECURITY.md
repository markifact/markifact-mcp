# Security Policy

## Reporting Vulnerabilities

**Email:** <security@markifact.com>
**Response Time:** Within 2 business days

Please include:

- Description of the vulnerability
- Steps to reproduce
- Potential impact
- Suggested fix (if any)

Do **not** open a public GitHub issue for security reports.

## Scope

In scope:

- The Markifact MCP server (`https://api.markifact.com/mcp`)
- The OAuth 2.1 authorization flow at `https://api.markifact.com`
- The plugin manifests, skills, and agent prompts in this repository
- The install scripts in `plugins/`

Out of scope: third-party platforms (Google Ads, Meta, etc.). Report those to the vendor.

## Security Measures

### Authentication and authorization

- **OAuth 2.1** with PKCE on every connection. No API keys are issued or stored in this repository.
- **Dynamic client registration** (RFC 7591) for CLI clients (Claude Code, Cursor, Codex, Gemini CLI).
- **Bearer tokens validated per request** at the MCP server.
- **Least-privilege scopes** applied per platform connection.
- **Refresh token rotation** enforced.
- **Per-platform OAuth** to Google, Meta, LinkedIn, TikTok, Shopify, HubSpot, etc. is brokered server-side. Tokens never leave Markifact and are never sent to the AI client.

### MCP tool safety

- Every tool exposed by the MCP server carries MCP `ToolAnnotations` (`readOnlyHint`, `destructiveHint`) so AI clients can route writes through approval.
- Operations whose `requires_approval` flag is `true` are only callable through `run_write_operation`, which the agent gates behind explicit user confirmation (see [skills/safe-write-operations/SKILL.md](skills/safe-write-operations/SKILL.md)).
- A four-step write protocol (state change, state blast radius, ask confirmation, verify after execution) is enforced by the agent prompt.

### URL and media fetching

- HTTPS required for all public endpoints.
- Private, loopback, and link-local addresses are blocked.
- Redirects capped (≤5).
- Per-URL and overall timeouts enforced.
- Size limits enforced on uploads.

### Content validation

- `upload_media` accepts only images and videos. Other MIME types are rejected.
- Content-Type headers are validated.
- Uploaded images are validated server-side before storage.
- Other inputs are validated against the registered operation schema.

### Logging

- Logs exclude secrets, OAuth tokens, and ad account credentials.
- Correlation identifiers used for tracing.
- Tool invocation, duration, and result-size metrics logged for operational telemetry.

### Data handling

- Customer data is **not used for AI training**.
- Encrypted credential storage server-side.
- Data retention follows the [Markifact Privacy Policy](https://www.markifact.com/privacy-policy).
- Meta app-reviewed.

See the [Markifact Trust Center](https://www.markifact.com/trust-center) for the full controls catalog.

## Supported Versions

| Version | Supported |
|---------|-----------|
| 0.1.x   | ✅        |

## Disclosure Policy

We follow responsible disclosure:

1. Report received and acknowledged within 2 business days.
2. Investigation and fix development.
3. Coordinated disclosure after fix deployment.
4. Credit to the reporter (unless anonymity is requested).
