---
name: opencode-lazy-packs
description: OpenCode 懶人包全集 — 環境建置、MCP 串接、技能安裝，說「安裝懶人包」「opencode 懶人包」時載入
---

# OpenCode 懶人包 — AI Agent 自動安裝入口

當使用者給你這個 repo 網址並說要安裝時，請依以下流程執行：

## 步驟一：認識可用懶人包

這個 repo 的 `skills/` 目錄下有 20 個技能。全部支援 `npx skills add` 一鍵安裝。

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
| 99 | `99-install-all` | 一次安裝全部（依序執行以上 21 個）| — |

## 步驟二：讓使用者選擇

列出上表給使用者看，然後問：

```
以上是這份懶人包的所有項目。

你可以：
- 輸入「全部」→ 一次安裝全部（用 12-install-all）
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

## 補充說明

- `00-env-setup` 幾乎所有 pack 的前置，建議優先安裝
- 已安裝的工具（如 Node.js、Git 等）安裝時會自動跳過
- 全部 skill 內容都在 `skills/<名稱>/SKILL.md`，需要詳細步驟時直接讀取

## 帳號資訊管理

本 repo 提供 `個人帳號與服務清單.sample.md` 作為**中央帳號資訊範本**，可存放於 OpenCode 工作根目錄（兼 Obsidian vault），讓所有懶人包自動讀取你的 SVN、GitLab、GitHub、JIRA、Confluence、飛書等帳號資訊，不需重複詢問。

詳見 README.md 的「新功能：個人帳號與服務清單」一節。
