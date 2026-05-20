# Connecting to Markifact

Markifact connects AI assistants to your ad platforms and analytics across **Google Ads, Meta Ads, GA4, DV360, Microsoft Ads, TikTok Ads, LinkedIn Ads, Pinterest Ads, Snapchat Ads, Reddit Ads, Amazon Ads, Shopify, HubSpot, Klaviyo, Slack, WhatsApp, Google Maps, and 10+ more**: 500+ operations for campaign launches, creative edits, audience builds, negative sweeps, performance diagnosis, and reporting.

## Quick Links

- [Connecting to Claude (web + desktop)](#connecting-markifact-to-claude)
- [Connecting to Claude Code](#claude-code)
- [Add as Organization Connector (Claude Owners)](#add-markifact-as-an-organizational-custom-connector-claude-owners)
- [Connecting to ChatGPT](#chatgpt)
- [Connecting to Cursor](#cursor)
- [Connecting to OpenAI Codex](#openai-codex)
- [Connecting to Windsurf](#windsurf)
- [Connecting to Gemini CLI](#gemini-cli)
- [Connecting to Antigravity](#antigravity)
- [Recommended permission settings](#recommended-permission-settings)
- [FAQ](#faq)
- [Troubleshooting](#troubleshooting)

---

## MCP Remote Server URL

```
https://api.markifact.com/mcp
```

OAuth 2.1 with PKCE, dynamic client registration (RFC 7591). No API keys.

---

## Connecting Markifact to Claude

**Your Anthropic admin must add Markifact as an organization integration before you can connect it on Team or Enterprise plans.** If you don't see Markifact in your list of connectors, ask your admin to add it. [Admin instructions below.](#add-markifact-as-an-organizational-custom-connector-claude-owners)

### End user authentication

Once Markifact is added by your admin (or on Pro/Max plans where you can add it yourself):

1. **Start a new Claude chat** (https://claude.ai/new).
2. **Click "Connect apps"** at the bottom right of the input.
3. **Scroll down and click "Connect"** next to Markifact.
4. **Authorize via OAuth 2.1:**
   - You'll be redirected to Markifact's login page.
   - Sign in with Google or email.
   - Authorize Markifact for the AI client.
   - Link your platform accounts (Google Ads, Meta Ads, GA4, Shopify, HubSpot, etc.) at <https://www.markifact.com/app/connections>.
5. **You're done.** Claude redirects you back automatically.

If you're already logged into Markifact, the browser usually completes the redirect with no further interaction.

### Allowing tools

The first time Claude tries to use a Markifact tool, a permission popup appears. See [Recommended permission settings](#recommended-permission-settings) below.

All Markifact MCP tools include MCP safety annotations (`readOnlyHint`, `destructiveHint`) so Claude can route writes through approval.

---

## Add Markifact as an Organizational Custom Connector (Claude Owners)

### Enterprise and Team plans (Owners and Primary Owners)

**Note:** Only Primary Owners or Owners can enable connectors on Claude for Work plans. Once configured, users individually connect and authenticate.

1. Navigate to **Customize → Connectors**.
2. Toggle to **"Organization connectors"** at the top of the page.
3. Locate the **"Connectors"** section.
4. Click **"Add custom connector"** at the bottom.
5. Enter:
   - **Name:** Markifact
   - **URL:** `https://api.markifact.com/mcp`
   - **Authentication:** OAuth
6. Click **"Add"**.
7. Users can now individually connect to Markifact in their own settings.

### Pro and Max plans

1. Navigate to **Customize → Connectors**.
2. Locate the **"Connectors"** section.
3. Click **"Add custom connector"**.
4. Enter:
   - **Name:** Markifact
   - **URL:** `https://api.markifact.com/mcp`
   - **Authentication:** OAuth
5. Click **"Add"**.

---

## Connecting to other AI assistants

### Claude Code

**Option 1: Full plugin (recommended)**: includes the performance-marketer agent, slash commands, and preloaded skills.

1. Open Claude Code in your project folder.
2. Run `/plugin marketplace add markifact/markifact-mcp`.
3. Run `/plugin install markifact@markifact`.
4. Run `/mcp`, find **markifact**, and complete the OAuth flow.
5. Try `@performance-marketer list my connections` to confirm everything is wired up.

Available slash commands:
- `/markifact:launch-google-search` (write)
- `/markifact:launch-pmax` (write)
- `/markifact:launch-meta-campaign` (write)
- `/markifact:edit-meta-creative` (write)
- `/markifact:rotate-creative` (write)
- `/markifact:negative-keyword-sweep` (write)
- `/markifact:diagnose-underperformer` (read-only)

**Option 2: MCP-only**: just the raw tools, no agent or commands.

```bash
claude mcp add --transport http markifact https://api.markifact.com/mcp
```

> **Important: do not use both options.** Option 1 (plugin) and Option 2 (`claude mcp add`) register the same MCP server in different config files (`settings.json` vs `settings.local.json`). Using both creates a duplicate that causes connection errors. Pick one:
>
> - If Option 1 isn't working, remove any manual entry: `claude mcp remove markifact`
> - To switch from Option 2 to the full plugin, run `claude mcp remove markifact` first, then follow Option 1
> - Run `claude mcp list` to check; you should see only one `markifact` entry

### ChatGPT

Requires a **Pro, Business, or Enterprise plan**.

1. Open ChatGPT → **Settings** → **Apps** → enable **Developer mode**.
2. Click **Create app**.
3. Set the name to **Markifact** and paste the MCP Server URL: `https://api.markifact.com/mcp`
4. Keep **Authentication** set to **OAuth**, then click **Create**.
5. Sign in with your Markifact account when redirected.
6. Link your ad platform accounts at <https://www.markifact.com/app/connections>.

For Codex (terminal/desktop), see [docs/codex.md](docs/codex.md).

Reference: [OpenAI MCP Servers Guide](https://help.openai.com/en/articles/9883373-mcp-servers-with-chatgpt).

### Cursor

Easiest install:

```bash
curl -fsSL https://raw.githubusercontent.com/markifact/markifact-mcp/main/plugins/cursor/markifact/install.sh | bash
```

Or add manually to `mcp.json` (global: `~/.cursor/mcp.json`, per-project: `.cursor/mcp.json`):

```json
{
  "mcpServers": {
    "markifact": {
      "url": "https://api.markifact.com/mcp"
    }
  }
}
```

Reference: [Cursor MCP Docs](https://docs.cursor.com/advanced/mcp).

### OpenAI Codex

Easiest install:

```bash
curl -fsSL https://raw.githubusercontent.com/markifact/markifact-mcp/main/plugins/codex/markifact/install.sh | bash
```

Or add manually to `~/.codex/config.toml`:

```toml
[mcp_servers.markifact]
url = "https://api.markifact.com/mcp"
```

### Windsurf

See [docs/windsurf.md](docs/windsurf.md) for the per-version install steps.

### Gemini CLI

Install as a Gemini CLI extension:

```bash
gemini extensions install github.com/markifact/markifact-mcp
```

On first use, a browser window opens for OAuth. Complete sign-in and link your ad accounts at <https://www.markifact.com/app/connections>.

Available commands after install (same set as Claude Code):

- `/markifact:launch-google-search`
- `/markifact:launch-pmax`
- `/markifact:launch-meta-campaign`
- `/markifact:edit-meta-creative`
- `/markifact:rotate-creative`
- `/markifact:negative-keyword-sweep`
- `/markifact:diagnose-underperformer`

### Antigravity

See [docs/antigravity.md](docs/antigravity.md) for the full install steps.

Antigravity currently reads Gemini's MCP config file and uses a command-based `mcp-remote` entry with a Markifact bearer token.

---

## Recommended permission settings

When your AI client prompts you to allow a Markifact tool for the first time:

- **Read tools** (`find_operations`, `get_operation_inputs`, `list_connections`, `read_file`, `get_file_url`): **Always allow** is fine. These only fetch data.
- **Write tools** (`run_write_operation`, `upload_media`): choose **Allow once** for every call. This guarantees you explicitly approve any change to your ad accounts before it executes.
- `run_operation` is auto-discovery's default execute path for operations whose `requires_approval` is `false` (read-only or non-destructive ops). Allowing it is safe; the agent still routes destructive ops through `run_write_operation`.

**Tool safety categories:**

- **Read-only** (`find_operations`, `get_operation_inputs`, `list_connections`, `read_file`, `get_file_url`): no cost, no platform writes.
- **Asset upload** (`upload_media`): adds images/videos to your Markifact workspace; no campaign change.
- **Execution** (`run_operation`): runs ops where `requires_approval: false`; safe by design (reports, lookups, creative previews, etc.).
- **Approval-gated writes** (`run_write_operation`): the only path for ops that move money or change live campaigns. The agent walks the four-step protocol before calling this tool.

---

## FAQ

### Do I need a paid plan to use Markifact?

Yes, Markifact requires an account. Free tier available at <https://www.markifact.com>. Paid plans start at the Starter tier; see <https://www.markifact.com/pricing>.

### Do I need advertising accounts?

Yes, you need active accounts on the platforms you want to manage. You can connect any combination at <https://www.markifact.com/app/connections>:

- **Google Ads** account for Google Ads ops
- **Meta Business** account for Meta / Facebook / Instagram ops
- **GA4 / Search Console / Merchant Center** for Google Analytics ops
- **Shopify** store for Shopify ops
- **HubSpot, LinkedIn Ads, TikTok Ads, Pinterest Ads, Snapchat Ads, Reddit Ads, Microsoft Ads, Amazon Ads, Klaviyo, Slack, WhatsApp Business, DV360, Google Maps**, and more

Ad platforms must have billing enabled to create campaigns.

### Is Markifact in beta?

No. Markifact's MCP server is in **General Availability (GA)** and used by paying customers in production.

### What AI clients work with Markifact?

Any MCP-compatible client. Tested and supported:

- **Claude (web + desktop)**: full support with progress streaming
- **Claude Code**: full support, including agent + slash commands via the plugin
- **ChatGPT** (Plus / Pro / Business / Enterprise)
- **Cursor**
- **OpenAI Codex**
- **Windsurf**
- **Gemini CLI**: extension with namespaced commands
- **Antigravity**

### What tools and operations are available?

The MCP server exposes a small **8-tool meta-surface** that your AI client uses to navigate **500+ operations** at runtime:

| Tool | Purpose |
|------|---------|
| `find_operations` | Search 500+ ops by intent. Returns each op's `requires_approval` flag. |
| `get_operation_inputs` | Get the full input schema for an op. |
| `run_operation` | Execute an op where `requires_approval: false`. |
| `run_write_operation` | Execute an op where `requires_approval: true`, after explicit user approval. |
| `list_connections` | List the user's connected logins per platform. |
| `get_file_url` | Get a signed URL for a Markifact-stored file. |
| `read_file` | Read a file the user uploaded or that an op produced. |
| `upload_media` | Upload images or videos as creative assets (no other file types). |

Operations cover the full lifecycle on each platform: campaign / ad set / ad CRUD, audiences, creative, bidding, budget, scheduling, reporting, account history, and more.

### Sample prompts

**Diagnose performance:**
```
Why did campaign 'Brand-Search-US' stop converting last week? Walk me through it.
```

**Launch a campaign:**
```
Launch a Meta Advantage+ campaign for our Black Friday creative. Budget $200/day, target US, paused so I can review.
```

**Find waste:**
```
Audit my Google Ads account from the last 30 days and find wasted spend over $500.
```

**Rotate creative:**
```
Rotate my top fatigued creative on the BFCM ad set, ship two variants paused.
```

**Cross-platform reporting:**
```
Pull a week-over-week ROAS report across all my Meta ad accounts and flag anything in learning limited.
```

### Is my data secure?

Yes. Markifact uses:

- **OAuth 2.1** with PKCE for authentication
- **Dynamic client registration** (RFC 7591) for CLI tools
- **HTTPS / TLS** for all transmission
- **Encrypted token storage** server-side; tokens never leave Markifact and are never sent to the AI client
- **No training on customer data**
- **Meta app-reviewed**

See [PRIVACY.md](PRIVACY.md), [TERMS.md](TERMS.md), [SECURITY.md](SECURITY.md), and the [Markifact Trust Center](https://www.markifact.com/trust-center).

### Who pays for the advertising costs?

**You do.** Markifact creates campaigns and changes in your ad platform accounts, billed directly by Google, Meta, LinkedIn, TikTok, etc. Markifact subscription fees are separate from advertising costs. See the financial responsibility section in [TERMS.md](TERMS.md).

### What happens if I disconnect?

1. OAuth tokens are immediately revoked.
2. Markifact can no longer access your platforms or run operations.
3. Existing campaigns continue running normally on their respective platforms.
4. Workspace data is retained or deleted per the [Privacy Policy](https://www.markifact.com/privacy-policy).

Your ad accounts and campaigns are owned by you, not by Markifact.

### How do I get help?

- **Email:** <contact@markifact.com>
- **Issues:** <https://github.com/markifact/markifact-mcp/issues>
- **Reconnect platforms:** <https://www.markifact.com/app/connections>
- **Status / website:** <https://www.markifact.com>

---

## Troubleshooting

If **no tools work at all**, follow these steps in order:

### 1. Check tool permissions

Your AI client needs the right tool permission settings:

- **Read tools** (`find_operations`, `get_operation_inputs`, `list_connections`, `read_file`, `get_file_url`): set to **Always allow**.
- **Write tools** (`run_write_operation`, `upload_media`): set to **Ask each time / Allow once**.

If any of these are set to **Block / Never allow**, Markifact cannot execute.

### 2. Disconnect and reconnect the Markifact connector

- **Claude (web/desktop):** Customize → Connectors → disconnect Markifact → connect again → complete OAuth.
- **ChatGPT:** Settings → Apps → open the Markifact app → remove → Create app again with URL `https://api.markifact.com/mcp` → complete OAuth.
- **Claude Code:** `claude mcp remove markifact` → reinstall the plugin (`/plugin install markifact@markifact`) **or** `claude mcp add --transport http markifact https://api.markifact.com/mcp` → restart → `/mcp` to authenticate.
- **Cursor:** reconnect via MCP settings, or rerun the install script.
- **Codex:** reconnect via the entry in `~/.codex/config.toml`.
- **Gemini CLI:** `gemini extensions uninstall markifact` → `gemini extensions install github.com/markifact/markifact-mcp`.

> **Note:** Claude and ChatGPT web connectors may disconnect every 1 to 2 weeks. This is normal behavior for web-based AI clients. Just re-enable and re-authenticate.

### 3. Refresh your Markifact session

If reconnecting the connector doesn't fix it, your Markifact login session may have expired:

1. Go to <https://www.markifact.com>.
2. Sign out (avatar → Sign out).
3. Sign back in.
4. Return to your AI client and try again.

### When does this NOT apply?

These steps apply when **nothing** works. If some platforms work but one doesn't (e.g. Google Ads works but Meta returns auth errors), the MCP server is reachable. That's a platform-specific issue, so reconnect just that platform at <https://www.markifact.com/app/connections>.

### Operation not found

Always call `find_operations` first; never invent operation IDs. The registry is dynamic and the agent picks the right one for the task.

### Permission reset

- **Claude Code:** `/permissions` to review and reset per-tool decisions.
- **Claude Desktop / ChatGPT:** remove and re-add the connector.

---

## Additional resources

- [Privacy Policy](PRIVACY.md)
- [Terms of Service](TERMS.md)
- [Security](SECURITY.md)
- [Support](SUPPORT.md)
