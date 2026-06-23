# OpenCode 懶人包

> 每份 MD 檔丟給 OpenCode 就能自動完成設定。
> OpenAI Codex 或 Claude Code 的用戶請看對應的懶人包。

---

## 使用方式

### 方式一：直接叫 AI 幫你裝（最簡單）

把這行貼給你的 AI agent：

```
這是 OpenCode 懶人包全集 https://github.com/shumingyang-opencode/opencode-lazy-packs
請讀取 repo 內容，列出所有可用的懶人包，問我要裝哪些。
```

AI 會自動：
1. 讀取 repo 的 `SKILL.md`（安裝入口）
2. 列出 22 個懶人包
3. 問你要裝哪些（可以選「全部」或特定編號）
4. 自動安裝你選的項目

### 方式二：一行指令手動裝

```bash
npx skills add shumingyang-opencode/opencode-lazy-packs --skill <skill名> -g -y
```

可用的 skill 名：

| Skill 名 | 對應懶人包 |
|----------|-----------|
| `00-env-setup` | 環境建置 |
| `01-notebooklm` | 連接 NotebookLM |
| `02-github` | 連接 GitHub |
| `03-svn` | 連接公司 SVN |
| `04-gitlab-internal` | 連接公司 GitLab |
| `05-gitlab-personal` | 連接個人 GitLab |
| `06-obsidian` | 連接 Obsidian |
| `07-second-brain` | 第二大腦設定 |
| `08-firebase` | 連接 Firebase |
| `09-browser` | 瀏覽器控制 |
| `10-workflow-skills` | 開工/收工技能 |
| `11-draw` | 生圖技能 |
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
| `22-cbm` | 安裝 Codebase Memory MCP — 程式碼知識圖譜（158 語言、Hybrid LSP、呼叫圖分析、Cypher 查詢） |
| `99-install-all` | 一次全部安裝 |

安裝後對 OpenCode 說該技能對應的關鍵字即可啟動。

### 方式二：手動下載 MD 檔

1. 看影片了解原理
2. 下載對應的懶人包（MD 檔）
3. 開啟終端機，在專案目錄執行 `opencode`
4. 把懶人包內容丟給 OpenCode，它會自動執行

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

## 為什麼有這份？

原本的懶人包是給 Claude Code 和 OpenAI Codex 用的。OpenCode 是第三個 AI 編碼代理工具，設定方式與前兩者不同：

| 差異 | OpenCode | Claude Code | OpenAI Codex |
|------|----------|-------------|--------------|
| 安裝 | `npm install -g opencode-ai` | `npm install -g @anthropic-ai/claude-code` | `npm install -g @openai/codex` |
| 全域設定 | `~/.config/opencode/opencode.json` | `~/.claude/settings.json` | `~/.codex/config.toml` |
| 專案指令檔 | `AGENTS.md` | `CLAUDE.md` | `AGENTS.md` |
| MCP 配置 | 編輯 opencode.json | `claude mcp add` | `codex mcp add` |
| Skill 機制 | 原生支援（SKILL.md） | 原生支援 | Desktop 支援 |
| 命令 | 有 `/` 內建命令 | 有 `/` 內建命令 | ❌ 沒有 |

---

## 最低先備條件

- [ ] Node.js 18+ 已安裝
- [ ] 電腦有網路連線

---

## 懶人包清單

| 編號 | 名稱 | 對應影片 | 狀態 | 說明 |
|------|------|---------|------|------|
| 00 | [環境建置](00-環境建置.md) | — | v0.3 | 安裝 OpenCode、Node.js、uv |
| 01 | [連接 NotebookLM](01-連接-NotebookLM.md) | — | v0.2 | 安裝 NotebookLM MCP + 產生簡報與圖表 |
| 02 | [連接 GitHub](02-連接-GitHub.md) | — | v0.1 | GitHub CLI 登入 + Pages 教材上線 |
| 03 | [連接公司 SVN](03-連接-公司SVN.md) | — | v0.2 | 連接 OmniVision 內部 SVN 伺服器 |
| 04 | [連接公司 GitLab](04-連接-公司GitLab.md) | — | v0.1 | 透過 SSH 連接內部 GitLab |
| 05 | [連接個人 GitLab](05-連接-個人GitLab.md) | — | v0.1 | 透過 HTTPS + PAT 連接 GitLab.com |
| 06 | [建立第二大腦 Obsidian](06-建立第二大腦-Obsidian.md) | — | v0.3 | Obsidian MCPVault 連接 |
| 07 | [第二大腦設定指南](07-第二大腦設定指南.md) | — | v0.2 | 三層結構 + AGENTS.md + 模板 |
| 08 | [連接 Firebase](08-連接-Firebase.md) | — | v0.1 | Firebase MCP 安裝 |
| 09 | [安裝瀏覽器控制](09-安裝瀏覽器控制.md) | — | v0.3 | Playwright MCP + open-computer-use |
| 10 | [開工/收工/初始化技能](10-開工收工初始化技能.md) | — | v0.1 | 全域三技能：startup、shutdown、project-init |
| 11 | [生圖技能](11-生圖.md) | — | v0.3 | draw skill：OpenAI gpt-image-2 生圖 |
| 12 | [MarkItDown 文件轉換](12-markitdown.md) | — | v0.1 | markitdown skill：各種文件轉 Markdown 格式 |
| 13 | [Graphify 知識圖譜](13-graphify.md) | — | v0.1 | 將專案轉為知識圖譜，用自然語言查詢取代 grep |
| 14 | [Awesome DESIGN.md 品牌設計](14-awesome-design-md.md) | — | v0.1 | 一鍵套用 73 個真實品牌的 DESIGN.md |
| 15 | [UI/UX Pro Max 設計智能](15-ui-ux-pro-max.md) | — | v0.1 | 67 種 UI 風格、161 推理規則、57 字體搭配、99 UX 指南 |
| 16 | [Superpowers 完整 AI 開發方法論](16-superpowers.md) | — | v6.0.3 | 14 skills、brainstorm→plan→TDD→review→merge、1.9M 安裝 |
| 17 | [Find Skills 技能搜尋與安裝](17-find-skills.md) | — | v0.1 | 從 5000+ 開放技能中搜尋並一鍵安裝 |
| 18 | [Frontend Design 辨識度優先前端設計](18-frontend-design.md) | — | v0.1 | Anthropic 出品 572K 安裝：拒絕 AI 模板化美學 |
| 19 | [安裝飛書 Lark](19-安裝-飛書Lark.md) | — | v0.1 | 飛書文檔/訊息/群組/日曆/多維表格整合 |
| 20 | [安裝公司 JIRA & Confluence](20-公司-jira-confluence.md) | — | v0.1 | 公司內部 JIRA Issue 管理 + Confluence 頁面搜尋與操作 |
| 21 | [安裝公司 Trac](21-公司-trac.md) | — | v0.2 | 公司 Trac Ticket 管理、Wiki 查閱、全文搜尋自動化 |
| 22 | [Codebase Memory MCP](22-codebase-memory-mcp.md) | — | v0.1 | 程式碼知識圖譜引擎 — 純 C 單一二進位、158 語言、Hybrid LSP 型別解析、14 MCP 工具、零依賴 |

---

## 授權

MIT License，與 Claude Code / Codex 懶人包相同。
