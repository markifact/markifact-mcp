# Support

- **Email:** <contact@markifact.com>
- **Bug reports & feature requests:** <https://github.com/markifact/markifact-mcp/issues>
- **Reconnect a platform:** <https://www.markifact.com/connections>
- **Documentation:** [`docs/`](docs/) in this repo, plus <https://www.markifact.com>

## Common issues

| Symptom | Fix |
|---------|-----|
| `/mcp` doesn't list `markifact` | Restart your client. Verify `.mcp.json` (or per-client equivalent) contains the server entry. |
| Auth error from any tool | Re-authenticate at <https://www.markifact.com/connections>. |
| Operation not found | Use `find_operations` first; never invent operation IDs. |
| Slash command not appearing in Claude Code | Run `/reload-plugins`, then `/help`. |
