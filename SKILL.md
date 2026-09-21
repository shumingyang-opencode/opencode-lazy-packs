---
name: agents-lazy-packs
description: Agents 懶人包全集 — 環境建置、MCP 串接、技能安裝，支援 OpenCode、Trae IDE、Codex 等多平台。說「安裝懶人包」「agents 懶人包」「trae 安裝」時載入
---

# Agents 懶人包 — AI Agent 自動安裝入口

當使用者給你這個 repo 網址並說要安裝時，請依以下流程執行：

## 步驟一：確認使用者平台

先問使用者用的是哪個平台：

```
你使用的是 OpenCode 還是 Trae IDE？
```

- **OpenCode** → 使用 `npx skills add` 一鍵安裝
- **Trae IDE** → 依照每個懶人包末尾的「Trae 對應操作」區塊手動設定

## 步驟二：認識可用懶人包

這個 repo 的 `skills/` 目錄下有 27 個技能。全部支援 `npx skills add` 一鍵安裝（OpenCode 用戶）。

| 編號 | Skill 名稱 | 說明 | 前置需求 |
|------|-----------|------|---------|
| 00 | `00-env-setup` | 安裝 Node.js、OpenCode、uv | 無 |
| 02 | `02-github` | 連接 GitHub CLI + 驗證 push | #00 |
| 03 | `03-svn` | 連接公司 SVN | 公司內網 |
| 04 | `04-gitlab-internal` | 連接公司 GitLab（SSH） | 公司內網 |
| 05 | `05-gitlab-personal` | 連接個人 GitLab（HTTPS+PAT） | GitLab 帳號 |
| 06 | `06-obsidian` | 連接 Obsidian MCPVault | 有 Obsidian vault |
| 07 | `07-second-brain` | 建立第二大腦三層結構 | Obsidian |
| 09 | `09-browser` | 安裝 Playwright + open-computer-use | #00 |
| 10 | `10-workflow-skills` | 安裝開工/收工/初始化技能 | Obsidian |
| 12 | `12-markitdown` | 安裝 MarkItDown 文件轉換技能 | #00 |
| 13 | `13-graphify` | 安裝 Graphify 知識圖譜技能 | #00 + uv |
| 14 | `14-awesome-design-md` | 安裝 Awesome DESIGN.md 品牌設計技能 | #00 |
| 15 | `15-ui-ux-pro-max` | 安裝 UI/UX Pro Max 設計智能（67 風格、161 規則） | #00 |
| 16 | `16-superpowers` | 安裝 Superpowers — obra/superpowers v6.0.3（14 skills、完整 SDLC 方法論） | 無 |
| 17 | `17-find-skills` | 安裝 Find Skills — 從 5000+ 開放技能中搜尋並安裝 | 無 |
| 18 | `18-frontend-design` | 安裝 Frontend Design — Anthropic 出品 572K 安裝前端設計 | 無 |
| 19 | `19-feishu-lark` | 安裝飛書 Lark — 文檔/訊息/群組/日曆/多維表格 | #00 + 飛書帳號 |
| 20 | `20-jira-confluence` | 安裝公司 JIRA & Confluence — Issue 管理、頁面搜尋、操作自動化 | 公司內網 + 帳號 |
| 21 | `21-trac` | 安裝公司 Trac — Ticket 管理、Wiki 查閱、搜尋自動化 | 公司內網 + 帳號 |
| 22 | `22-codebase-memory-mcp` | 安裝 Codebase Memory MCP — 程式碼知識圖譜（158 語言、Hybrid LSP、呼叫圖、Cypher）| 無 |
| 23 | `23-project-plan-feature` | 安裝功能規劃技能 — 10 步驟規劃 + init_plan.py | #22 |
| 24 | `24-skill-reference` | 互動式 SKILL.md 建立教學 — 從 frontmatter、目錄結構到發布 | 無 |
| 25 | `25-agents-reference` | 互動式 AGENTS.md 建立教學 — 依專案特性客製專案規範 | 無 |
| 26 | `26-mcp-reference` | 互動式 MCP 設定教學 — 連線模式、安全性、自訂 MCP Server | #00 |
| 27 | `27-gen-pptx` | 通用簡報產製 — 六引擎工作流：技術文件/Repo→可編輯 .pptx，專為 RD/FAE/AE 設計 | #00 |
| 28 | `28-cli-anything` | 安裝 CLI-Anything — HKUDS/CLI-Anything：50+ 軟體的 Agent-native CLI harness（Blender、GIMP、Obsidian 等），支援 cli-hub 發現與安裝 | 無 |
| 30 | `30-trae-opencode` | 安裝 TRAE & OpenCode 雙向驅動 — OpenCode↔TRAE 雙向 CLI 驅動（bytedance/trae-agent） | #00 |

## 步驟三：讓使用者選擇

列出上表給使用者看，然後問：

```
以上是這份懶人包的所有項目。

你可以：
- 輸入編號組合 → 例如「00, 01, 03」只裝這三個
- 若有已安裝的項目 → 告訴我跳過

你要安裝哪些？
```

## 步驟四：依序安裝（依平台執行對應步驟）

### OpenCode 用戶

對使用者選取的每個 skill，執行：

```bash
npx skills add https://github.com/shumingyang-opencode/opencode-lazy-packs --skill <skill名稱> -g -y
```

### Trae 用戶

對使用者選取的每個項目，讀取對應的 `.md` 檔末尾的「Trae 對應操作」區塊，依照該區塊的步驟執行。若該區塊說明 CLI 工具安裝方式與 OpenCode 相同，則直接執行對應的 CLI 指令。

> 若 `.md` 檔內無 Trae 區塊（如教學型 #07、#24~#26），則不需要安裝動作。

### Trae 安裝層級詢問（安裝前）

Trae 用戶在安裝每個技能/MCP 前，必須先詢問：

```
這個服務要安裝到哪裡？
- 全域（推薦，所有專案可用）
- 專案（僅當前專案）
```

依選擇決定路徑：

| 類型 | 全域路徑 | 專案路徑 |
|------|---------|---------|
| MCP | `%APPDATA%\Trae\User\mcp.json` 的 `"mcpServers"` | `.trae/mcp.json` 的 `"mcpServers"` |
| Skill | `~/.agents/skills/<技能目錄>/` | `.agents/skills/<技能目錄>/` |

> 各懶人包的「Trae 對應操作」區塊已內建此詢問與對應路徑。

## 步驟五：安裝後驗證

每安裝完一個，依照該 skill 內的「完成回報格式」回報結果。全部完成後列出總表。

### 平台設定路徑速查

| | OpenCode | Trae IDE |
|---|---|---|
| 專案 MCP | `opencode.json` 的 `"mcp"` | `.trae/mcp.json` 的 `"mcpServers"` |
| 全域 MCP | `~/.config/opencode/opencode.json` 的 `"mcp"` | `%APPDATA%\Trae\User\mcp.json` 的 `"mcpServers"` |
| 專案 Skills | `.agents/skills/` | `.agents/skills/` |
| 全域 Skills | `~/.agents/skills/` | `~/.agents/skills/` |
| 專案規則 | `AGENTS.md` | `AGENTS.md` / `.trae/rules/` |

## 補充說明

- `00-env-setup` 幾乎所有 pack 的前置，建議優先安裝
- 已安裝的工具（如 Node.js、Git 等）安裝時會自動跳過
- 全部 skill 內容都在 `skills/<名稱>/SKILL.md`，需要詳細步驟時直接讀取

## 帳號資訊管理

本 repo 提供 `個人帳號與服務清單.sample.md` 作為**中央帳號資訊範本**，可存放於 OpenCode 工作根目錄（兼 Obsidian vault），讓所有懶人包自動讀取你的 SVN、GitLab、GitHub、JIRA、Confluence、飛書等帳號資訊，不需重複詢問。

詳見 README.md 的「新功能：個人帳號與服務清單」一節。
