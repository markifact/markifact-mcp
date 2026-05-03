# Adding a new client

To support a new AI client (or a new format from an existing client):

1. **Add a generator step** in [`scripts/sync-skills.sh`](../scripts/sync-skills.sh) that reads from `shared/` and writes the new client's required format. Never hand-author per-client surfaces.
2. **If the client supports remote MCP natively**, just point it at `https://api.markifact.com/mcp` in its manifest.
3. **If the client needs an install script**, add one under `plugins/<client>/markifact/install.sh`.
4. **Add a doc** at `docs/<client>.md`.
5. **Update [`README.md`](../README.md)** install table.
6. **Run** `./scripts/sync-skills.sh && ./scripts/validate.sh`.
7. **Open a PR.** CI will fail if generated files aren't in sync.

## Anti-patterns

- ✗ Hand-editing files under `commands/`, `skills/`, `agents/`, `gemini/commands/`, `plugins/cursor/.cursor/`, or `plugins/codex/AGENTS.md`. They are generated.
- ✗ Versions out of lockstep across `plugin.json`, `server.json`, `gemini-extension.json`. Use `./scripts/bump-version.sh`.
- ✗ Adding tool-specific knowledge (e.g. "the Google Ads `bid_strategy` field") to manifests. That belongs in skills, which are fed back to the model at runtime.
