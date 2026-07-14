# AGENTS.md — opencode-lazy-packs

## 這個資料夾是什麼

OpenCode 專用的懶人包倉庫，雙倉同步：

| 遠端 | URL |
|------|-----|
| GitHub (origin) | `shumingyang-opencode/opencode-lazy-packs` — 公開上游 |
| GitLab (gitlab) | `steven.yang/opencode-lazy-packs` — 公司內部獨立版本，供同事安裝 |

## 主要差異

| 項目 | opencode | claude-code | codex | Trae IDE |
|------|----------|-------------|-------|----------|
| 設定檔 | `opencode.json` | `settings.json` | `config.toml` | `.trae/mcp.json` |
| 專案檔 | `AGENTS.md` | `CLAUDE.md` | `AGENTS.md` | `AGENTS.md` / `.trae/rules/` |
| MCP | 編輯 JSON | `claude mcp add` | `codex mcp add` | 編輯 JSON / GUI |
| Skills dir | `~/.config/opencode/skills/` | `~/.claude/skills/` | `~/.codex/skills/` | `.trae/skills/` |

## 雙倉同步規則

- **不要**把 Claude Code 或 Codex 版直接複製過來；MCP 指令、設定檔格式都不同
- 修改主流程時三邊都要更新
- Obsidian 閱讀版：`OpenCode 懶人包/`
- GitHub 版：`opencode-lazy-packs/`

> **給同事**：若你 fork 此 repo，請自行修改 remote URL：
> ```bash
> git remote set-url gitlab https://gitlab.ovt.com:8081/<你的帳號>/opencode-lazy-packs.git
> ```


## Obsidian 關聯資料

- Obsidian vault：`<OBSIDIAN_VAULT_PATH>`
- 每日筆記：`每日筆記/<日期>.md`
- 創作庫：`創作庫/`
- 知識庫：`知識庫/`

## 提醒

- 使用者說「更新 OpenCode 懶人包」→ 只動本資料夾
- 使用者說「三邊都更新」→ 三個資料夾都改

## MCP / 技能安裝流程

安裝任何涉及 **MCP 伺服器**或**技能**的懶人包時，先確認使用者使用的平台（OpenCode CLI 或 Trae IDE），再遵循以下流程：

1. 依照對應平台的懶人包步驟安裝並驗證
2. 驗證完成後，**必須詢問使用者**是否要將該服務設為全局
3. 使用者回答「是」→ 搬遷到對應的全域設定路徑
4. 使用者回答「否」→ 保留在專案層級，並告知其他專案如何啟用
5. 詳見 `SKILL.md` 步驟五

### 平台設定路徑速查

| | OpenCode CLI | Trae IDE |
|---|---|---|
| 專案 MCP | `opencode.json` 的 `"mcp"` | `.trae/mcp.json` 的 `"mcpServers"` |
| 全域 MCP | `~/.config/opencode/opencode.json` 的 `"mcp"` | `~/.cursor/mcp.json` 的 `"mcpServers"` |
| 專案 Skills | `skills/` 目錄 | `.trae/skills/` 或 `.agents/skills/` |
| 全域 Skills | `~/.config/opencode/skills/` | 無（僅專案層級） |
| 專案規則 | `AGENTS.md` | `AGENTS.md` / `.trae/rules/` |

## 全局 MCP 列表（OpenCode CLI）

以下 MCP 伺服器已安裝在全局 `~/.config/opencode/opencode.json`（部分僅安裝於公司工作機）：

| MCP | 類型 | 用途 | 安裝位置 |
|-----|------|------|---------|
| obsidian | 筆記 | 讀寫 Obsidian vault | 所有機器 |
| playwright | 瀏覽器 | 瀏覽器自動化 | 所有機器 |
| open-computer-use | 桌面 | 桌面 UI 控制 | 所有機器 |
| docker | Docker | 容器操作 | 工作機 |
| gitlab | GitLab | GitLab API 雙實例 | 工作機 |
| mcp-atlassian | Atlassian | JIRA + Confluence | 工作機 |
| trac | Trac | Ticket/Wiki 管理 | 工作機 |
| codebase-memory-mcp | 程式碼 | 知識圖譜引擎 | 所有機器 |

## graphify

This project has a knowledge graph at graphify-out/ with god nodes, community structure, and cross-file relationships.

When the user types `/graphify`, invoke the `skill` tool with `skill: "graphify"` before doing anything else.

Rules:
- For codebase questions, first run `graphify query "<question>"` when graphify-out/graph.json exists. Use `graphify path "<A>" "<B>"` for relationships and `graphify explain "<concept>"` for focused concepts. These return a scoped subgraph, usually much smaller than GRAPH_REPORT.md or raw grep output.
- Dirty graphify-out/ files are expected after hooks or incremental updates; dirty graph files are not a reason to skip graphify. Only skip graphify if the task is about stale or incorrect graph output, or the user explicitly says not to use it.
- If graphify-out/wiki/index.md exists, use it for broad navigation instead of raw source browsing.
- Read graphify-out/GRAPH_REPORT.md only for broad architecture review or when query/path/explain do not surface enough context.
- After modifying code, run `graphify update .` to keep the graph current (AST-only, no API cost).
