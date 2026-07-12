# OpenCode 懶人包 #08：連接 Firebase

> 版本：v0.1
> 更新日期：2026-05-19

---

## 這個懶人包會幫你做什麼？

讓 OpenCode 可以管理 Firebase：
- 安裝 Firebase CLI
- 登入 Google 帳號
- 建立或選擇 Firebase 專案
- 寫入 opencode.json MCP 設定
- 驗證 CRUD

---

## 先備條件

- [ ] 已完成 **懶人包 #00：環境建置**（Node.js + OpenCode）
- [ ] 已有 Google 帳號

---

## 請 OpenCode 幫我執行以下步驟

### 步驟一：安裝 Firebase CLI

```bash
npm install -g firebase-tools
```

確認版本：
```bash
firebase --version
```

---

### 步驟二：登入 Firebase

```bash
firebase login
```

瀏覽器會開啟 Google 登入頁面。

登入後檢查可用專案：
```bash
firebase projects:list
```

---

### 步驟三：初始化 Firebase 專案

在專案目錄執行：
```bash
firebase init
```

選擇需要的服務（Firestore、Hosting 等）。

---

### 步驟四：寫入 OpenCode MCP 設定

編輯 `~/.config/opencode/opencode.json`，加入：

```json
{
  "mcp": {
    "firebase": {
      "type": "local",
      "command": ["npx", "-y", "firebase-tools@latest", "mcp"],
      "enabled": true
    }
  }
}
```

---

### 步驟五：驗證連線

重新開啟 OpenCode，然後問它：

```
請列出我的 Firebase 專案。
```

---

## 完成回報格式

```md
## Firebase 連接完成

- firebase-tools 版本：xxx
- 登入狀態：成功 / 失敗
- 可用專案：xxx 個
- MCP 設定：已寫入 opencode.json
- 工具測試：成功 / 失敗
```

---

## 常見問題

| 問題 | 解法 |
|------|------|
| `firebase login` 瀏覽器不開 | 手動執行，或檢查防火牆 |
| opencode.json 路徑錯誤 | 確認 `~/.config/opencode/opencode.json` 存在 |

---

## 解除安裝

### 移除 MCP 設定

編輯 `~/.config/opencode/opencode.json`，從 `"mcp"` 區塊移除 `firebase` 段落。

### 移除 CLI 工具

```bash
npm uninstall -g firebase-tools
```

---

## Trae 對應操作

> 若你使用 **Trae IDE**，以下為對應的安裝/更新/移除步驟。

### 在 Trae 上安裝（專案層級）

編輯 `.trae/mcp.json`（若無則建立），在 `"mcpServers"` 區塊加入：

```json
{
  "mcpServers": {
    "firebase": {
      "command": "npx",
      "args": ["-y", "firebase-tools@latest", "mcp"]
    }
  }
}
```

### 在 Trae 上安裝（全域）

編輯 `~/.cursor/mcp.json`，在 `"mcpServers"` 區塊加入相同設定。

### 在 Trae 上更新

重複安裝步驟，覆蓋原有設定即可。

### 在 Trae 上移除

- **專案**：從 `.trae/mcp.json` 的 `"mcpServers"` 移除 `firebase` 區塊
- **全域**：從 `~/.cursor/mcp.json` 的 `"mcpServers"` 移除 `firebase` 區塊

> CLI 工具的安裝/更新/移除方式與 OpenCode 相同，無需額外步驟。

---

## 更新紀錄

| 日期 | 版本 | 更新內容 |
|------|------|---------|
| 2026-05-19 | v0.1 | 初版 |
