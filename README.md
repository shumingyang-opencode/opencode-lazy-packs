# OpenCode 懶人包

> 每份 MD 檔丟給 OpenCode 就能自動完成設定。
> OpenAI Codex 或 Claude Code 的用戶請看對應的懶人包。

---

## 使用方式

### 方式一：直接叫 AI 幫你裝（最簡單）

把這行貼給你的 AI agent：

```
這是 OpenCode 懶人包全集 https://github.com/mathruffian-dot/opencode-lazy-packs
請讀取 repo 內容，列出所有可用的懶人包，問我要裝哪些。
```

AI 會自動：
1. 讀取 repo 的 `SKILL.md`（安裝入口）
2. 列出 17 個懶人包
3. 問你要裝哪些（可以選「全部」或特定編號）
4. 自動安裝你選的項目

### 方式二：一行指令手動裝

```bash
npx skills add mathruffian-dot/opencode-lazy-packs --skill <skill名> -g -y
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
| `16-oh-my-opencode-slim` | oh-my-opencode-slim 多 Agent 編排 |
| `17-find-skills` | Find Skills — 技能搜尋與安裝 |
| `18-frontend-design` | Frontend Design — 辨識度優先的前端設計 |
| `99-install-all` | 一次全部安裝 |

安裝後對 OpenCode 說該技能對應的關鍵字即可啟動。

### 方式二：手動下載 MD 檔

1. 看影片了解原理
2. 下載對應的懶人包（MD 檔）
3. 開啟終端機，在專案目錄執行 `opencode`
4. 把懶人包內容丟給 OpenCode，它會自動執行

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
| 16 | [oh-my-opencode-slim 多 Agent 編排](16-oh-my-opencode-slim.md) | — | v0.1 | 7 專用 Agent、背景任務、TUI、Companion、7 Bundled Skills |
| 17 | [Find Skills 技能搜尋與安裝](17-find-skills.md) | — | v0.1 | 從 5000+ 開放技能中搜尋並一鍵安裝 |
| 18 | [Frontend Design 辨識度優先前端設計](18-frontend-design.md) | — | v0.1 | Anthropic 出品 572K 安裝：拒絕 AI 模板化美學 |

---

## 授權

MIT License，與 Claude Code / Codex 懶人包相同。
