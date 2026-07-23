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
      "command": ["npx", "@bitbonsai/mcpvault", "C:\\Users\\<USERNAME>\\Documents\\Secondbrain"],
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
      "command": ["npx", "@bitbonsai/mcpvault", "/Users/<USERNAME>/Documents/Secondbrain"],
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

### 步驟五：安裝 Obsidian 技能套件（kepano/obsidian-skills）

此套件由 Obsidian 創辦人 [kepano](https://github.com/kepano) 開發，提供 5 個強化 Obsidian 操作能力的技能（**39K stars**）：

| 技能 | 用途 |
|------|------|
| `obsidian-markdown` | 建立和編輯 Obsidian 格式 Markdown（wikilinks、callouts、properties） |
| `obsidian-bases` | 建立和編輯 Obsidian Bases（`.base` 檔案 — 資料庫檢視、篩選、公式） |
| `json-canvas` | 建立和編輯 JSON Canvas（`.canvas` 檔案 — 節點、連線、心智圖） |
| `obsidian-cli` | 透過 Obsidian CLI 讀寫筆記、管理插件與佈景主題 |
| `defuddle` | 從網頁提取純淨 Markdown，去除導覽雜訊節省 Token |

安裝方式：

```bash
# 複製到 OpenCode 技能目錄
git clone https://github.com/kepano/obsidian-skills.git ~/.opencode/skills/obsidian-skills
```

OpenCode 會自動掃描 `~/.opencode/skills/` 下的所有 SKILL.md，不需額外設定。

驗證安裝：

重啟 OpenCode 後問它：

```
你有哪些 Obsidian 相關的技能可以用？
```

預期看到 5 個技能：`obsidian-markdown`、`obsidian-bases`、`json-canvas`、`obsidian-cli`、`defuddle`。

> 💡 mcpvault（步驟二）提供基本的 vault 讀寫能力；kepano/obsidian-skills 則提供格式編輯、CLI 操作、網頁內容擷取等進階功能。兩者相輔相成。

---

## 完成回報格式

```md
## Obsidian 連接完成

- Vault 路徑：<VAULT_PATH>
- mcpvault：已安裝 / 未安裝
- MCP 設定：已寫入 opencode.json
- 讀取測試：成功 / 失敗
- 寫入測試：成功 / 失敗
- kepano/obsidian-skills：已安裝（5 項技能）

---

## 已安裝的 Obsidian 技能說明

安裝來源：kepano/obsidian-skills（39K stars，Obsidian 創辦人開發）
遵循 [Agent Skills 規格](https://agentskills.io/specification)，相容所有支援 SKILL.md 的 AI agent。

| 技能 | 說明 |
|------|------|
| `obsidian-markdown` | 建立和編輯 Obsidian Flavored Markdown（`.md`）— wikilinks、embeds、callouts、properties 等 Obsidian 特有語法 |
| `obsidian-bases` | 建立和編輯 Obsidian Bases（`.base`）— 資料庫檢視、篩選、公式、摘要 |
| `json-canvas` | 建立和編輯 JSON Canvas（`.canvas`）— 節點、連線、群組、心智圖 |
| `obsidian-cli` | 透過 Obsidian CLI 操作 vault — 讀寫筆記、管理插件與佈景主題開發 |
| `defuddle` | 從網頁提取純淨 Markdown — 去除導覽雜訊節省 Token，取代 WebFetch |
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

## 解除安裝

### 移除 MCP 設定

編輯 `~/.config/opencode/opencode.json`，從 `"mcp"` 區塊移除 `obsidian` 段落。

### 移除 CLI 工具

```bash
npm uninstall -g @bitbonsai/mcpvault
```

---

## Trae 對應操作

> 若你使用 **Trae IDE**，以下為對應的安裝/更新/移除步驟。

### 在 Trae 上安裝（專案層級）

編輯 `.trae/mcp.json`（若無則建立），在 `"mcpServers"` 區塊加入：

```json
{
  "mcpServers": {
    "obsidian": {
      "command": "npx",
      "args": ["@bitbonsai/mcpvault", "<VAULT_PATH>"]
    }
  }
}
```

### 在 Trae 上安裝（全域）

編輯 `%APPDATA%\Trae\User\mcp.json`，在 `"mcpServers"` 區塊加入相同設定。

### 在 Trae 上更新

重複安裝步驟，覆蓋原有設定即可。

### 在 Trae 上移除

- **專案**：從 `.trae/mcp.json` 的 `"mcpServers"` 移除 `obsidian` 區塊
- **全域**：從 `%APPDATA%\Trae\User\mcp.json` 的 `"mcpServers"` 移除 `obsidian` 區塊

> CLI 工具的安裝/更新/移除方式與 OpenCode 相同，無需額外步驟。

---

## 更新紀錄

| 日期 | 版本 | 更新內容 |
|------|------|---------|
| 2026-06-18 | v0.3 | 拆分 Windows/macOS 章節，加入 macOS 專屬路徑與搜尋指令 |
| 2026-05-25 | v0.2 | 補充 CLI-Anything Obsidian CLI 進階方案 |
| 2026-05-19 | v0.1 | 初版 |
