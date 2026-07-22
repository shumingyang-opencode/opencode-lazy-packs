---
name: workflow-skills
description: 安裝開工/收工/初始化三大技能。說「裝工作流程技能」「安裝 startup shutdown skills」時載入。
---

# 開工/收工/初始化技能

安裝三個全域 OpenCode 技能：startup、shutdown、project-init。

## 步驟

### 1. 建立技能目錄
```bash
mkdir -p ~/.config/opencode/skills/startup
mkdir -p ~/.config/opencode/skills/shutdown
mkdir -p ~/.config/opencode/skills/project-init
```

### 2. 建立三個 SKILL.md
- **startup**：說「開工」→ 判斷當前專案 + 讀 Obsidian session 紀錄 + 檢查 Git
- **shutdown**：說「收工」→ Git commit/push + 補結構化 session 區塊（討論/問題/解決/下一步）至 Obsidian
- **project-init**：說「初始化專案」→ AGENTS.md + Git + GitHub + Obsidian → 可選接續功能規劃

（完整內容見 [懶人包 #10：開工收工初始化技能](../../10-開工收工初始化技能.md) 步驟二至步驟四）

> **⚠️ 已知坑：** `project-init` 技能產生 `opencode.json` 時，key 必須用 `"command"` 而非 `"customCommands"`（OpenCode IDE 不支援後者）。詳見 `SKILL.md` 中的 JSON 範本與下方修正後的內容。**若你已手動建立此技能，請確認該 key 是 `command`。**

### 3. 設定 opencode.json 權限
```json
"permission": {
  "skill": {
    "startup": "allow",
    "shutdown": "allow",
    "project-init": "allow",
    "*": "ask"
  }
}
```

### 4. 驗證
重啟 OpenCode 後說「開工」。

回報格式：三個技能路徑、opencode.json 權限設定、驗證結果。
