# OpenCode 懶人包 #06：建立第二大腦 Obsidian

> 版本：v0.3
> 更新日期：2026-06-18

---

## 這個懶人包會幫你做什麼？

讓 OpenCode 可以讀寫你的 Obsidian 筆記本：
- 找到 Obsidian vault 位置
- 安裝 MCPVault（@bitbonsai/mcpvault）
- 寫入 opencode.json MCP 設定
- 驗證讀寫

---

## 先備條件

- [ ] Node.js 18+ 已安裝
- [ ] 已有 Obsidian vault

---

## 請 OpenCode 幫我執行以下步驟

### 步驟一：設定 Obsidian vault 根目錄

**建議將 vault 設為 OpenCode 工作根目錄**（例如 `D:\workspace\OpenCode\`），原因：
- OpenCode 的所有專案檔案同時也是 Obsidian 筆記，兩者統一管理
- OpenCode 的全域規則（AGENTS.md）會自動讀取 vault 內的 `個人帳號與服務清單.md`
- 不需維護兩套檔案路徑

若尚未有 vault：

```bash
# 在 OpenCode 根目錄建立 .obsidian 資料夾
mkdir <OpenCode_ROOT_DIR>/.obsidian
# 用 Obsidian 應用程式 → 開啟資料夾作為 vault
```

若已有 vault，有三種選擇：

| 選項 | 做法 | 適合時機 |
|------|------|---------|
| **A（推薦）** | 將既有 vault 搬到 OpenCode 根目錄 | 希望統一管理 |
| **B** | 直接指向既有 vault，不變動 | 既有 vault 內容龐大不想搬 |
| **C** | 用 OpenCode 根目錄開新 vault，保留舊 vault | 想分開管理 |

確認條件：
- 資料夾存在
- 裡面有 `.obsidian` 子資料夾（或準備建立）
- 使用者確認 vault 路徑

> vault 路徑設定好後，後續的懶人包（#02~#05、#20）會自動讀取 vault 內的 `個人帳號與服務清單.md` 取得服務資訊。

---

### 步驟二：安裝 mcpvault

```bash
npm install -g @bitbonsai/mcpvault
```

確認安裝位置：

**Windows：**
```bash
where.exe mcpvault
```

**macOS / Linux：**
```bash
which mcpvault
```

---

### 步驟三：寫入 OpenCode MCP 設定

編輯 `~/.config/opencode/opencode.json`，加入：

```json
{
  "mcp": {
    "obsidian": {
      "type": "local",
      "command": ["npx", "@bitbonsai/mcpvault", "<VAULT_PATH>"],
      "enabled": true
    }
  }
}
```

**Windows 範例：**
```json
{
  "mcp": {
    "obsidian": {
      "type": "local",
      "command": ["npx", "@bitbonsai/mcpvault", "C:\\Users\\mathr\\Documents\\Secondbrain"],
      "enabled": true
    }
  }
}
```

**macOS 範例：**
```json
{
  "mcp": {
    "obsidian": {
      "type": "local",
      "command": ["npx", "@bitbonsai/mcpvault", "/Users/mathr/Documents/Secondbrain"],
      "enabled": true
    }
  }
}
```

---

### 步驟四：驗證連線

重新開啟 OpenCode，然後問它：

```
請列出我的 Obsidian vault 根目錄的資料夾。
```

再測試寫入：

```
請在我的 Obsidian 建立一則測試筆記，內容寫「OpenCode 已成功連接 Obsidian」。
```

---

## 完成回報格式

```md
## Obsidian 連接完成

- Vault 路徑：<VAULT_PATH>
- mcpvault：已安裝 / 未安裝
- MCP 設定：已寫入 opencode.json
- 讀取測試：成功 / 失敗
- 寫入測試：成功 / 失敗
```

---

## 進階：CLI-Anything Obsidian CLI

若需要全文檢索、metadata 操作、tag 管理、筆記分析等進階功能，可安裝 CLI-Anything 的 Obsidian CLI：

### 前置需求
1. 在 Obsidian 內安裝 [Local REST API](https://github.com/coddingtonbear/obsidian-local-rest-api) 社群插件
2. 插件設定中啟用 HTTPS（非必要）並記下 API key

### 安裝
```bash
pip install cli-anything-hub
cli-hub install obsidian
```

### 使用範例
```bash
cli-anything-obsidian search "SKILL.md"
cli-anything-obsidian tag list
cli-anything-obsidian note get "專案工作流程.md"
```

> 💡 mcpvault（本懶人包預設方案）適合基本讀寫；Obsidian CLI 適合需要查詢、分析、批量操作的情境。兩者可並存。

---

## 常見問題

| 問題 | 平台 | 解法 |
|------|------|------|
| `npm install -g` 出現 EPERM | Windows | 以系統管理員身分執行 |
| `npm install -g` 出現 EACCES | macOS | 使用 `sudo npm install -g` 或設定 npm prefix |
| 找不到 vault | 通用 | 搜尋 `.obsidian` 資料夾位置（見步驟一） |
| opencode.json 格式錯誤 | 通用 | JSON 最後一項不能有逗號，路徑需加雙引號 |

---

## 更新紀錄

| 日期 | 版本 | 更新內容 |
|------|------|---------|
| 2026-06-18 | v0.3 | 拆分 Windows/macOS 章節，加入 macOS 專屬路徑與搜尋指令 |
| 2026-05-25 | v0.2 | 補充 CLI-Anything Obsidian CLI 進階方案 |
| 2026-05-19 | v0.1 | 初版 |
