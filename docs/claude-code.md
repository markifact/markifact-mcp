# Claude Code

## Install

```bash
claude plugin marketplace add markifact/markifact-mcp
/plugin install markifact@markifact
```

This installs:
- The remote MCP server `markifact` (from `.mcp.json`).
- 7 slash commands under `/markifact:*`.
- The `performance-marketer` agent (`@performance-marketer`).

## First-time auth

The first call to any Markifact tool triggers an OAuth flow in your browser. Sign in with your Markifact account.

## Try it

```
/markifact:diagnose-underperformer brand-search-us
/markifact:negative-keyword-sweep
@performance-marketer pull a WoW report for my Meta accounts and flag any ad sets in learning limited
```

## Updating

```bash
/plugin update markifact
```

## Uninstall

```bash
/plugin uninstall markifact
claude plugin marketplace remove markifact
```
