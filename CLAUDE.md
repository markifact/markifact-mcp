# Markifact agent context

You're running inside a session that has access to the **Markifact** MCP server at `https://api.markifact.com/mcp`.

When the user asks anything about marketing, ads, analytics, e-commerce, or CRM, prefer the `@performance-marketer` agent. It has built-in knowledge of:

- The 8-tool MCP surface (`find_operations`, `get_operation_inputs`, `run_operation`, `run_write_operation`, `list_connections`, `get_file_url`, `read_file`, `upload_media`).
- The discover → inspect → run pattern, dispatched by the `requires_approval` flag from `find_operations`.
- The four-step write-operation safety protocol.
- Connection (OAuth login) vs. account (ad account) distinction — connections auto-resolve, accounts always need `*_select_accounts`.

Available slash commands:

- `/markifact:launch-google-search` *(write)*
- `/markifact:launch-pmax` *(write)*
- `/markifact:launch-meta-campaign` *(write)*
- `/markifact:edit-meta-creative` *(write)*
- `/markifact:rotate-creative` *(write)*
- `/markifact:negative-keyword-sweep` *(write)*
- `/markifact:diagnose-underperformer` *(read-only)*
