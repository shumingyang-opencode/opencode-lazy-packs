# AGENTS.md — opencode-lazy-packs

## 這個資料夾是什麼

OpenCode 專用的懶人包倉庫，對應 repo：
**shumingyang-opencode/opencode-lazy-packs**

與 `claude-code-lazy-packs/`、`codex-lazy-packs/` 平行：
同一套教學流程，分別給三個 AI 編碼代理使用。

## 主要差異

| 項目 | opencode | claude-code | codex |
|------|----------|-------------|-------|
| 設定檔 | `opencode.json` | `settings.json` | `config.toml` |
| 專案檔 | `AGENTS.md` | `CLAUDE.md` | `AGENTS.md` |
| MCP | 編輯 JSON | `claude mcp add` | `codex mcp add` |
| Skills dir | `~/.config/opencode/skills/` | `~/.claude/skills/` | `~/.codex/skills/` |

## 雙倉同步規則

- **不要**把 Claude Code 或 Codex 版直接複製過來；MCP 指令、設定檔格式都不同
- 修改主流程時三邊都要更新
- Obsidian 閱讀版：`OpenCode 懶人包/`
- GitHub 版：`opencode-lazy-packs/`

## Obsidian 關聯資料

- Obsidian vault：`/Users/stevenyang/Documents/obsidian/obsidian`
- 每日筆記：`每日筆記/<日期>.md`
- 創作庫：`創作庫/`
- 知識庫：`知識庫/`

## 提醒

- 使用者說「更新 OpenCode 懶人包」→ 只動本資料夾
- 使用者說「三邊都更新」→ 三個資料夾都改

## graphify

This project has a knowledge graph at graphify-out/ with god nodes, community structure, and cross-file relationships.

When the user types `/graphify`, invoke the `skill` tool with `skill: "graphify"` before doing anything else.

Rules:
- For codebase questions, first run `graphify query "<question>"` when graphify-out/graph.json exists. Use `graphify path "<A>" "<B>"` for relationships and `graphify explain "<concept>"` for focused concepts. These return a scoped subgraph, usually much smaller than GRAPH_REPORT.md or raw grep output.
- Dirty graphify-out/ files are expected after hooks or incremental updates; dirty graph files are not a reason to skip graphify. Only skip graphify if the task is about stale or incorrect graph output, or the user explicitly says not to use it.
- If graphify-out/wiki/index.md exists, use it for broad navigation instead of raw source browsing.
- Read graphify-out/GRAPH_REPORT.md only for broad architecture review or when query/path/explain do not surface enough context.
- After modifying code, run `graphify update .` to keep the graph current (AST-only, no API cost).
