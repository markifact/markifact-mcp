# Changelog

All notable changes to this project will be documented here.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.4] - 2026-09-19

### Added
- Cursor plugin manifest (`.cursor-plugin/plugin.json`, `mcp.json`, `assets/icon.png`); Markifact installs as a native Cursor plugin and is listed on cursor.directory.
- `package.json` with package metadata for ClawHub.
- Links to the approved ChatGPT plugin and the Claude connector directory in the install docs; manual setup kept as a fallback.

### Changed
- Cursor rule split in two: the plugin ships a lean always-on rule (agent protocol only, 66 lines) since Cursor loads skills, commands and agents natively; the install script keeps the fully bundled rule.
- Operation count updated to 1000+ across docs and manifests.

## [1.0.0] - 2026-05-03

### Added
- Initial public release.
- Claude Code plugin manifest + marketplace catalog.
- MCP Registry `server.json` (`com.markifact/markifact`).
- Gemini CLI extension with namespaced commands.
- Cursor + Codex install scripts; Windsurf install docs.
- Performance-marketer agent.
- Slash commands: `launch-google-search`, `launch-pmax`, `launch-meta-campaign`, `edit-meta-creative`, `rotate-creative`, `negative-keyword-sweep`, `diagnose-underperformer`.
- Reference skills (preloaded into agent): `markifact-overview`, `safe-write-operations`.
- `sync-skills.sh` source-of-truth to per-client compile pipeline.
- `validate.sh` + `bump-version.sh` release scripts.
- CI workflow that fails when generated files are out of date.
