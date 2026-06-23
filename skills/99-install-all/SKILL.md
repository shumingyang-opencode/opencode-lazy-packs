---
name: opencode-install-all
description: 一次安裝所有 OpenCode 懶人包技能（00-19 全部）。說「全部安裝」「裝完所有懶人包」時載入。
---

# 一次安裝全部技能

依序載入並執行所有 20 個懶人包技能：

1. **00-env-setup** — 安裝 Node.js、OpenCode、Git、gh、uv
2. **01-notebooklm** — 連接 NotebookLM MCP
3. **02-github** — 連接 GitHub CLI
4. **03-svn** — 連接公司 SVN
5. **04-gitlab-internal** — 連接公司 GitLab（SSH）
6. **05-gitlab-personal** — 連接個人 GitLab（HTTPS+PAT）
7. **06-obsidian** — 連接 Obsidian MCPVault
8. **07-second-brain** — 建立第二大腦三層結構
9. **08-firebase** — 連接 Firebase MCP
10. **09-browser** — 安裝 Playwright + open-computer-use
11. **10-workflow-skills** — 安裝 startup/shutdown/project-init
12. **11-draw** — 安裝 draw 生圖技能
13. **12-markitdown** — 安裝 MarkItDown 文件轉換技能
14. **13-graphify** — 安裝 Graphify 知識圖譜技能
15. **14-awesome-design-md** — 安裝 Awesome DESIGN.md 品牌設計技能
16. **15-ui-ux-pro-max** — 安裝 UI/UX Pro Max 設計智能
17. **16-superpowers** — 安裝 Superpowers 完整 SDLC 方法論
18. **17-find-skills** — 安裝 Find Skills 技能搜尋與安裝
19. **18-frontend-design** — 安裝 Frontend Design 前端設計
20. **19-feishu-lark** — 安裝飛書 Lark 文檔/訊息/群組/日曆整合

## 執行方式

依序載入每個子技能並執行。每完成一個報告進度。
跳過已安裝的工具（檢查版本確認）。
最終回報總表：20 項各別的成功/失敗/已跳過狀態。

> 💡 也可用 `npx skills add` 個別安裝：
> ```bash
> npx skills add shumingyang-opencode/opencode-lazy-packs --skill 01-notebooklm -g -y
> ```
