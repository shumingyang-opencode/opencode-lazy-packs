# OpenCode 懶人包

> 支援 **OpenCode CLI** 與 **Trae IDE** 雙平台。
> 每個懶人包內含各平台的安裝、更新、移除說明。

---

## 使用方式

### 方式一：直接叫 AI 幫你裝（最簡單）

把這行貼給你的 AI agent：

```
這是 OpenCode 懶人包全集 https://gitlab.ovt.com:8081/steven.yang/opencode-lazy-packs
請讀取 repo 內容，列出所有可用的懶人包，問我要裝哪些。
```

AI 會自動：
1. 讀取 repo 的 `SKILL.md`（安裝入口）
2. 列出 25 個懶人包
3. 問你要裝哪些（可以選「全部」或特定編號）
4. 自動安裝你選的項目

### 方式二：一行指令手動裝（OpenCode）

```bash
npx skills add https://gitlab.ovt.com:8081/steven.yang/opencode-lazy-packs --skill <skill名> -g -y
```

可用的 skill 名：

| Skill 名 | 對應懶人包 |
|----------|-----------|
| `00-env-setup` | 環境建置 |
| `02-github` | 連接 GitHub |
| `03-svn` | 連接公司 SVN |
| `04-gitlab-internal` | 連接公司 GitLab |
| `05-gitlab-personal` | 連接個人 GitLab |
| `06-obsidian` | 連接 Obsidian |
| `07-second-brain` | 第二大腦設定 |
| `09-browser` | 瀏覽器控制 |
| `10-workflow-skills` | 開工/收工技能 |
| `12-markitdown` | 文件轉換技能 |
| `13-graphify` | 知識圖譜技能 |
| `14-awesome-design-md` | 品牌設計套用技能 |
| `15-ui-ux-pro-max` | UI/UX Pro Max 設計智能 |
| `16-superpowers` | Superpowers — 完整的 AI 軟體開發方法論（14 skills, 1.9M 安裝） |
| `17-find-skills` | Find Skills — 技能搜尋與安裝 |
| `18-frontend-design` | Frontend Design — 辨識度優先的前端設計 |
| `19-feishu-lark` | 安裝飛書 Lark — 文檔/訊息/群組/日曆/多維表格 |
| `20-jira-confluence` | 安裝公司 JIRA & Confluence — Issue 管理、頁面搜尋、操作自動化 |
| `21-trac` | 安裝公司 Trac — Ticket 管理、Wiki 查閱、搜尋自動化 |
| `22-codebase-memory-mcp` | 安裝 Codebase Memory MCP — 程式碼知識圖譜（158 語言、Hybrid LSP、呼叫圖分析、Cypher 查詢） |
| `23-project-plan-feature` | 功能規劃技能 — 10 步驟規劃 + init_plan.py 自動建檔 |
| `24-skill-reference` | 互動式 SKILL.md 建立教學 — 引導從零建立技能 |
| `25-agents-reference` | 互動式 AGENTS.md 建立教學 — 依專案客製專案規範 |
| `26-mcp-reference` | 互動式 MCP 設定教學 — 連線模式、安全性、自訂 Server |
| `27-gen-pptx` | 通用簡報產製技能 — 六引擎工作流：技術文件/Repo/Spec→可編輯 .pptx |
| `28-cli-anything` | CLI-Anything — 50+ 軟體的 Agent-native CLI harness 發現與安裝（Blender、GIMP、Obsidian 等） |

安裝後對 OpenCode 說該技能對應的關鍵字即可啟動。

### 方式三：手動安裝（Trae IDE）

若你使用 **Trae IDE**，每個懶人包末尾都有 `## Trae 對應操作` 區塊，說明如何在 Trae 上安裝、更新、移除該服務。

```bash
# 以 Firebase 為例，開啟專案的 .trae/mcp.json，在 mcpServers 加入：
# {
#   "mcpServers": {
#     "firebase": {
#       "command": "npx",
#       "args": ["-y", "firebase-tools@latest", "mcp"]
#     }
#   }
# }
```

> 全域 MCP 設定請編輯 `~/.cursor/mcp.json`（與 Cursor 相容）。

### 方式四：手動下載 MD 檔

1. 下載對應的懶人包（MD 檔）
2. 開啟終端機，在專案目錄執行 `opencode`（或開啟 Trae IDE）
3. 把懶人包內容丟給 AI，它會自動執行

---

## 新功能：個人帳號與服務清單 🆕

本懶人包新增 **中央帳號資訊管理系統**，讓 AI agent 自動讀取你的服務帳號，不需每次重複詢問。

### 功能說明

- 建立 `.md` 檔案集中管理 SVN、GitLab、GitHub、JIRA、Confluence、飛書等服務資訊
- 所有 OpenCode 專案在初始化前，會先透過全域 AGENTS.md 規則讀取此檔案
- 資訊不足時才會詢問，問到的資料自動回寫永久留存

### 如何啟用

1. **複製範本**：將 `個人帳號與服務清單.sample.md` 複製為 `個人帳號與服務清單.md`
2. **填寫資訊**：將所有 `<...>` 佔位符改為你的實際帳號資訊
3. **放置位置**：將該檔案放在 **OpenCode 工作根目錄**（建議同時做為 Obsidian vault 根目錄）
4. **設定全域規則**：建立 `~/.config/opencode/AGENTS.md`（內容詳見範本底部說明）

### 懶人包內建支援

部分懶人包在步驟中已內建「查閱帳號資訊」的前置步驟，可直接利用此檔案跳過詢問：

| 懶人包 | 自動讀取項目 |
|--------|-------------|
| #02 連接 GitHub | GitHub 帳號名稱 |
| #03 連接公司 SVN | SVN URL、登入帳號 |
| #04 連接公司 GitLab | GitLab URL、SSH 設定 |
| #05 連接個人 GitLab | GitLab URL、認證方式 |
| #06 建立 Obsidian | vault 根目錄路徑 |
| #20 JIRA & Confluence | JIRA / Confluence URL |
| #21 Trac | Trac URL、登入帳號 |

### 安全提醒

PAT / Token **不要**寫入此檔案。它們應存放於 `opencode.json` 的 MCP 環境變數中。詳見範本中的「操作規範」與「安全規範」。

---

## Agents 設定對照表

| 項目 | OpenCode | Trae IDE |
|------|-------------|----------|
| 安裝 | `npm install -g opencode-ai` | 從 trae.ai 下載 |
| 全域設定 | `~/.config/opencode/opencode.json` | `~/.cursor/mcp.json` |
| 專案指令檔 | `AGENTS.md` | `AGENTS.md` / `.trae/rules/` |
| MCP 配置 | 編輯 opencode.json | 編輯 `.trae/mcp.json` |
| Skill 機制 | 原生支援（SKILL.md） | `.trae/skills/` |
| 命令 | 有 `/` 內建命令 | GUI 介面操作 |

---

## 最低先備條件

- [ ] **OpenCode 用戶**：Node.js 18+ 已安裝
- [ ] **Trae 用戶**：已安裝 Trae IDE（從 [trae.ai](https://www.trae.ai) 下載）
- [ ] 電腦有網路連線
- [ ] 各懶人包的詳細先備條件，請參閱 [SKILL.md](SKILL.md) 的「前置需求」欄位

---

## 懶人包清單

| 編號 | 名稱 | 類型 | 狀態 | 說明 | Trae |
|------|------|------|------|------|------|
| 00 | [環境建置](00-環境建置.md) | CLI | v0.3 | OpenCode CLI + Node.js + uv 基礎環境安裝 | ✅ |
| ~~01~~ | ~~連接 NotebookLM~~ | ~~MCP~~ | ~~v0.2~~ | ~~NotebookLM MCP 安裝與連線：AI 生成簡報、圖表、音訊、報告~~ | ~~已移除~~ |
| 02 | [連接 GitHub](02-連接-GitHub.md) | MCP | v0.2 | GitHub CLI 登入認證 + GitHub Pages 教材上線 | ✅ |
| 03 | [連接公司 SVN](03-連接-公司SVN.md) | MCP | v0.2 | OmniVision 內部 SVN 伺服器連線設定 | ✅ |
| 04 | [連接公司 GitLab](04-連接-公司GitLab.md) | MCP | v0.1 | 透過 SSH 金鑰連接內部 GitLab | ✅ |
| 05 | [連接個人 GitLab](05-連接-個人GitLab.md) | MCP | v0.2 | 透過 HTTPS + PAT 連接 GitLab.com 帳號 | ✅ |
| 06 | [建立第二大腦 Obsidian](06-建立第二大腦-Obsidian.md) | MCP | v0.3 | Obsidian MCP Vault 連接：筆記建立、搜尋、管理 | ✅ |
| 07 | [第二大腦設定指南](07-第二大腦設定指南.md) | 教學 | v0.2 | Obsidian 三層目錄結構 + AGENTS.md 規則 + 筆記模板 | — |
| ~~08~~ | ~~連接 Firebase~~ | ~~MCP~~ | ~~v0.1~~ | ~~Firebase MCP 安裝：專案管理、資料庫、部署~~ | ~~已移除~~ |
| 09 | [安裝瀏覽器控制](09-安裝瀏覽器控制.md) | MCP | v0.3 | Playwright MCP + macOS 桌面 UI 自動化操作 | ✅ |
| 10 | [開工/收工/初始化技能](10-開工收工初始化技能.md) | Skill | v0.1 | 全域三技能：startup（開工自動同步）、shutdown（收工備份）、project-init（新專案初始化） | ✅ |
| ~~11~~ | ~~生圖技能~~ | ~~Skill~~ | ~~v0.3~~ | ~~draw skill：OpenAI gpt-image-2 生成示意圖與插畫~~ | ~~已移除~~ |
| 12 | [MarkItDown 文件轉換](12-markitdown.md) | Skill | v0.3 | 各種文件自動轉 Markdown：PDF/Office/CSV/JSON/圖片/音訊/Email/EPUB | ✅ |
| 13 | [Graphify 知識圖譜](13-graphify.md) | Skill | v0.1 | 程式碼知識圖譜引擎：自然語言查詢取代 grep，跨檔案結構分析 | ✅ |
| 14 | [Awesome DESIGN.md 品牌設計](14-awesome-design-md.md) | Skill | v0.1 | 一鍵套用 73 個真實品牌 DESIGN.md（Stripe、Vercel、Apple 等） | ✅ |
| 15 | [UI/UX Pro Max 設計智能](15-ui-ux-pro-max.md) | Skill | v0.1 | 67 UI 風格 + 161 推理規則 + 57 字體搭配 + 99 UX 指南 | ✅ |
| 16 | [Superpowers 完整 AI 開發方法論](16-superpowers.md) | Skill | v6.0.3 | 14 skills 覆蓋 brainstorm→plan→TDD→review→merge 完整流程（1.9M+ 安裝） | ✅ |
| 17 | [Find Skills 技能搜尋與安裝](17-find-skills.md) | Skill | v0.1 | 從 5000+ 開放技能庫中搜尋並一鍵安裝 | ✅ |
| 18 | [Frontend Design 辨識度優先前端設計](18-frontend-design.md) | Skill | v0.1 | Anthropic 出品（572K 安裝）：拒絕 AI 模板化美學，建立品牌辨識度 | ✅ |
| 19 | [安裝飛書 Lark](19-安裝-飛書Lark.md) | Skill | v0.1 | 飛書文檔/訊息/群組/日曆/多維表格/OA 審批整合 | ✅ |
| 20 | [安裝公司 JIRA & Confluence](20-公司-jira-confluence.md) | MCP | v0.3 | mcp-atlassian：JIRA Issue 管理 + Confluence 頁面搜尋與操作 | ✅ |
| 21 | [安裝公司 Trac](21-公司-trac.md) | MCP | v0.2 | Trac Ticket 管理 + Wiki 查閱 + 全文搜尋自動化 | ✅ |
| 22 | [Codebase Memory MCP](22-codebase-memory-mcp.md) | MCP | v0.1 | 程式碼知識圖譜：158 語言、Hybrid LSP 型別解析、14 MCP 工具、零依賴 | ✅ |
| 23 | [功能規劃技能](23-功能規劃技能.md) | Skill | v0.1 | 10 步驟功能規劃流程 + init_plan.py 自動建檔 + codebase-memory 索引檢查 | ✅ |
| 24 | [SKILL.md 建立教學](24-SKILL.md-建立教學.md) | 教學 | v0.1 | 互動式教學：從 frontmatter、目錄結構到發布，引導建立第一個 OpenCode 技能 | — |
| 25 | [AGENTS.md 建立教學](25-AGENTS.md-建立教學.md) | 教學 | v0.1 | 互動式教學：依專案客製 AGENTS.md，涵蓋編碼慣例、測試規範、Git 流程 | — |
| 26 | [MCP 設定教學](26-MCP-設定教學.md) | 教學 | v0.1 | 互動式教學：MCP 概念、三種連線模式、安全性原則、自訂 MCP Server | — |
| 27 | [通用簡報產製](27-通用簡報產製.md) | Skill | v0.1 | 六引擎簡報工作流：將技術文件、datasheet、Spec、Repo 轉為可編輯 .pptx，專為 RD/FAE/AE 設計 | ✅ |
| 28 | [安裝 CLI-Anything](28-安裝-CLI-Anything.md) | Skill | v0.1 | CLI-Hub Meta-Skill：50+ 軟體的 Agent-native CLI harness 發現與安裝，支援 cli-hub 套件管理器（HKUDS/CLI-Anything, ⭐44.8K） | ✅ |

---

## 貢獻與回饋

- **問題回報 / 功能建議**：請至 [GitLab Issues](https://gitlab.ovt.com:8081/steven.yang/opencode-lazy-packs/-/issues) 提出
- **Pull Request**：歡迎 fork 本專案並提交 PR
- **討論**：請在 Issues 中發起討論

---

## 授權

[MIT License](LICENSE)，與 Claude Code / Codex 懶人包相同。
