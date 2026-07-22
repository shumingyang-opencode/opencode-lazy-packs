# AGENTS.md — agents-lazy-packs

## 這個資料夾是什麼

多平台 AI Agent 懶人包倉庫。

## 主要差異

| 項目 | OpenCode | Codex | Trae IDE |
|------|----------|-------|----------|
| 設定檔 | `opencode.json` | `config.toml` | `.trae/mcp.json` |
| 專案檔 | `AGENTS.md` | `AGENTS.md` | `AGENTS.md` / `.trae/rules/` |
| MCP | 編輯 JSON | `codex mcp add` | 編輯 JSON / GUI |
| Skills dir | `~/.config/opencode/skills/` | `~/.codex/skills/` | `~/.agents/skills/`（全域）或 `.trae/skills/`（專案） |

## Obsidian 關聯資料

- Obsidian vault：`<OBSIDIAN_VAULT_PATH>`
- 每日筆記：`每日筆記/<日期>.md`
- 創作庫：`創作庫/`
- 知識庫：`知識庫/`
- vault git remote：`<VAULT_GIT_REMOTE>`

## 提醒

- 使用者說「更新 Agents 懶人包」→ 只動本資料夾

## 雙倉同步流程

本 repo 使用兩個 sync script 管理 GitHub 與 GitLab 的差異：

| 指令 | 目標 | 特性 |
|------|------|------|
| `scripts/sync-to-gitlab.ps1` | GitLab | 完整公司資訊 + 不含 01/08/11 |
| `scripts/sync-to-github.ps1` | GitHub | 公司資訊去敏（→ `<PLACEHOLDER>`）+ 含 01/08/11 |

請勿直接 `git push origin main` — GitHub 版需要先去敏後再推送。

## MCP / 技能安裝流程

安裝任何涉及 **MCP 伺服器**或**技能**的懶人包時，先確認使用者使用的平台（OpenCode 或 Trae IDE），再遵循以下流程：

1. 依照對應平台的懶人包步驟安裝並驗證
2. 驗證完成後，**必須詢問使用者**是否要將該服務設為全局
3. [新增] **同步資料詢問** — 僅限「涉及跨機器檔案同步」的技能（如 startup/shutdown 的每日筆記）：
   - 初次安裝 → 詢問是否要同步資料
   - 升級時 → 讀取 `個人帳號與服務清單.md` 的跨機器同步設定區塊
     - 有該技能的 entry（狀態: 已設定）→ 直接沿用，不詢問
     - 無該技能 entry → 重新詢問
   - 若選「是」：
     - 詢問平台（GitHub / GitLab / 兩者都要）
     - 所有 repo **強制私有**
     - 協助建立私有 repo（`gh repo create --private` / `glab repo create`）
     - `git remote add`（支援多個 remote 鏡像）
     - 將 sync config 寫入 `個人帳號與服務清單.md`
   - 若選「否」→ 跳過，不寫 sync config
   - 若之後要新增 remote → 由使用者說「幫我加 sync remote」手動追加
4. 使用者回答「是」→ 搬遷到對應的全域設定路徑
5. 使用者回答「否」→ 保留在專案層級，並告知其他專案如何啟用
6. 詳見 `SKILL.md` 步驟五

### 平台設定路徑速查

| | OpenCode | Trae IDE |
|---|---|---|
| 專案 MCP | `opencode.json` 的 `"mcp"` | `.trae/mcp.json` 的 `"mcpServers"` |
| 全域 MCP | `~/.config/opencode/opencode.json` 的 `"mcp"` | `~/.cursor/mcp.json` 的 `"mcpServers"` |
| 專案 Skills | `skills/` 目錄 | `.trae/skills/` 或 `.agents/skills/` |
| 全域 Skills | `~/.config/opencode/skills/` | `~/.agents/skills/` |
| 專案規則 | `AGENTS.md` | `AGENTS.md` / `.trae/rules/` |

## 全局 MCP 列表（OpenCode）

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


