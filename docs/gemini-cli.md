# Gemini CLI

## Install

```bash
gemini extensions install github.com/markifact/markifact-mcp
```

This installs:
- The remote MCP server `markifact` (from `gemini-extension.json`).
- The `GEMINI.md` context file with the performance-marketer prompt.
- Slash commands under `/markifact:*` (from `gemini/commands/markifact/`).

## Try it

```
/markifact:diagnose-underperformer
/markifact:negative-keyword-sweep
```

## Update

```bash
gemini extensions update markifact
```

## Uninstall

```bash
gemini extensions uninstall markifact
```
