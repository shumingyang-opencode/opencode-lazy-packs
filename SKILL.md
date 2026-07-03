---
name: opencode-lazy-packs
description: OpenCode 懶人包全集 — 環境建置、MCP 串接、技能安裝，說「安裝懶人包」「opencode 懶人包」時載入
---

# OpenCode 懶人包 — AI Agent 自動安裝入口

當使用者給你這個 repo 網址並說要安裝時，請依以下流程執行：

## 步驟一：認識可用懶人包

這個 repo 的 `skills/` 目錄下有 28 個技能。全部支援 `npx skills add` 一鍵安裝。

| 編號 | Skill 名稱 | 說明 | 前置需求 |
|------|-----------|------|---------|
| 00 | `00-env-setup` | 安裝 Node.js、OpenCode、uv | 無 |
| 01 | `01-notebooklm` | 連接 NotebookLM MCP | #00 |
| 02 | `02-github` | 連接 GitHub CLI + 驗證 push | #00 |
| 03 | `03-svn` | 連接公司 SVN | 公司內網 |
| 04 | `04-gitlab-internal` | 連接公司 GitLab（SSH） | 公司內網 |
| 05 | `05-gitlab-personal` | 連接個人 GitLab（HTTPS+PAT） | GitLab 帳號 |
| 06 | `06-obsidian` | 連接 Obsidian MCPVault | 有 Obsidian vault |
| 07 | `07-second-brain` | 建立第二大腦三層結構 | Obsidian |
| 08 | `08-firebase` | 連接 Firebase MCP | #00 |
| 09 | `09-browser` | 安裝 Playwright + open-computer-use | #00 |
| 10 | `10-workflow-skills` | 安裝開工/收工/初始化技能 | Obsidian |
| 11 | `11-draw` | 安裝 draw 生圖技能（gpt-image-2）| OpenAI API Key |
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

## 步驟二：讓使用者選擇

列出上表給使用者看，然後問：

```
以上是這份懶人包的所有項目。

你可以：
- 輸入編號組合 → 例如「00, 01, 03」只裝這三個
- 若有已安裝的項目 → 告訴我跳過

你要安裝哪些？
```

## 步驟三：依序安裝（使用 skill 機制）

對使用者選取的每個 skill，執行：

```bash
npx skills add shumingyang-opencode/opencode-lazy-packs --skill <skill名稱> -g -y
```

> ⚠️ 如果 `npx skills add` 無法使用（例如環境不支援），改為手動安裝：讀取 `skills/<名稱>/SKILL.md` 的內容，照裡面的步驟執行。

## 步驟四：安裝後驗證

每安裝完一個，依照該 skill 內的「完成回報格式」回報結果。全部完成後列出總表。

## 步驟五：詢問全局設定

每次安裝涉及 **MCP 伺服器**或**技能**的懶人包，安裝並驗證完成後，須詢問使用者：

```
這個服務已安裝完成。
要將它加入【全局設定】（~/.config/opencode/opencode.json）讓所有專案都能用嗎？
還是保持在【當前專案】就好？
```

- **使用者回答「是」** → 將該 MCP/skill 設定從專案 `opencode.json` 搬遷到 `~/.config/opencode/opencode.json` 的 `mcp` 區塊中；若專案 `opencode.json` 已無其他設定，可移除或精簡為僅 `$schema` 與空 `mcp: {}`
- **使用者回答「否」** → 保留在當前專案 `opencode.json`，並告知：
  ```
  設定已保留在【當前專案】。其他專案若要使用，請將以下設定複製到該專案
  的 opencode.json 或 ~/.config/opencode/opencode.json：
  
  <顯示對應的 MCP JSON 設定區塊>
  ```

### 全局 vs 專案設定速查

| | 全局 (`~/.config/opencode/`) | 專案 (`<project>/opencode.json`) |
|---|---|---|
| 生效範圍 | 所有專案 | 僅該專案 |
| 適合什麼 | 通用服務（GitLab、Firebase、Trac、codebase-memory 等） | 專案專屬設定 |
| 覆蓋規則 | 基礎層 | 專案層會與全局合併，同名 key 會覆蓋 |

## 補充說明

- `00-env-setup` 幾乎所有 pack 的前置，建議優先安裝
- 已安裝的工具（如 Node.js、Git 等）安裝時會自動跳過
- 全部 skill 內容都在 `skills/<名稱>/SKILL.md`，需要詳細步驟時直接讀取

## 帳號資訊管理

本 repo 提供 `個人帳號與服務清單.sample.md` 作為**中央帳號資訊範本**，可存放於 OpenCode 工作根目錄（兼 Obsidian vault），讓所有懶人包自動讀取你的 SVN、GitLab、GitHub、JIRA、Confluence、飛書等帳號資訊，不需重複詢問。

詳見 README.md 的「新功能：個人帳號與服務清單」一節。
