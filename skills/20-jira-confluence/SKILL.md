---
name: opencode-jira-confluence
description: 安裝公司 JIRA & Confluence 整合 — 讓 OpenCode 操作公司內部 JIRA Issue 管理與 Confluence 頁面搜尋。說「安裝 JIRA」「安裝 Confluence」「安裝公司 JIRA」「公司 JIRA 設定」時載入。
---

# 安裝公司 JIRA & Confluence（OpenCode 版）

讓 OpenCode 透過 `mcp-atlassian` 操作公司內部 JIRA 與 Confluence（Server/Data Center），包含搜尋/建立/更新 Issue、搜尋/讀取/建立頁面等 72 個工具。

## 前置條件

- [ ] OpenCode 已安裝
- [ ] `uv` / `uvx` 已安裝
- [ ] 公司內網連線（或 VPN）
- [ ] 公司 JIRA / Confluence 帳號

## 步驟

### 1. 確認 uvx 環境

```bash
uv --version
```

若未安裝，執行：
```powershell
powershell -c "irm https://astral.sh/uv/install.ps1 | iex"
```

安裝後請使用者重開終端機，再次確認 `uv --version` 正常。

### 2. 引導使用者產生 PAT

向使用者說明：

> 請登入公司 JIRA `https://jira.ovt.com/` → 頭像 → Profile → Personal Access Tokens → Create token
> 同樣步驟登入 Confluence `https://confluence.ovt.com/` 產生 PAT
> 若為同一 SSO 帳號，共用同一個 PAT 即可
> **建立後請立即複製 Token 給我後面的步驟使用**

### 3. 編輯全域 opencode.json

讀取使用者當前的 `~/.config/opencode/opencode.json`，在 `mcp` 區塊加入：

```json
"mcp-atlassian": {
  "type": "local",
  "command": ["uvx", "mcp-atlassian"],
  "enabled": true,
  "environment": {
    "JIRA_URL": "https://jira.ovt.com",
    "JIRA_PERSONAL_TOKEN": "<YOUR_PAT>",
    "CONFLUENCE_URL": "https://confluence.ovt.com",
    "CONFLUENCE_PERSONAL_TOKEN": "<YOUR_PAT>",
    "JIRA_SSL_VERIFY": "false",
    "CONFLUENCE_SSL_VERIFY": "false"
  }
}
```

> 請使用者將 `<YOUR_PAT>` 改為實際的 PAT 值。（若雙 PAT，分別填入對應 Token）

SSL 說明：公司內部自簽憑證需設 `SSL_VERIFY=false`。

### 4. 重啟驗證

請使用者重啟 OpenCode，然後驗證工具是否載入：

```text
請列出你現在有哪些 MCP 工具可以使用？
```

確認出現 `jira_` 和 `confluence_` 開頭的工具。

### 5. JIRA 操作驗證

依序執行以下測試（請使用者逐行確認）：

**5.1 搜尋 Issue**：`請幫我搜尋 JIRA 上最近更新且指派給我的 Issue`

**5.2 查看詳情**：`請顯示其中一筆 Issue 的詳細資訊`

**5.3 建立 Issue**：`請查詢 JIRA 上可用的專案，然後在第一個專案建立一筆測試 Issue`

**5.4 轉移狀態**：`請將剛才建立的測試 Issue 轉移到下一個狀態`

### 6. Confluence 操作驗證

**6.1 搜尋頁面**：`請幫我搜尋 Confluence OTCAPP 空間底下的頁面`

**6.2 讀取頁面**：`請讀取其中一頁的完整內容`

**6.3 建立頁面**：`請在 OTCAPP 空間下建立一頁名為「OpenCode 測試頁面」的頁面`

**6.4 新增評論**：`請在剛才建立的測試頁面下方新增一則評論`

### 7. 若需雙 PAT

若 JIRA 與 Confluence 帳號不同，幫使用者將 opencode.json 改為兩組獨立的 PAT 環境變數：

```json
"JIRA_PERSONAL_TOKEN": "<YOUR_JIRA_PAT>",
"CONFLUENCE_PERSONAL_TOKEN": "<YOUR_CONFLUENCE_PAT>"
```

其餘步驟相同。

## 使用方式

安裝後對 OpenCode 說以下關鍵字即可觸發：

| 你要做什麼 | 對 OpenCode 說 |
|-----------|---------------|
| 搜尋 Issue | 「幫我查 JIRA 上指派給我的 Issue」 |
| 查看 Issue | 「顯示 PROJ-123 的詳細資訊」 |
| 建立 Issue | 「在 JIRA 上建立一個 Bug Issue」 |
| 轉移狀態 | 「把 PROJ-123 轉移到 In Progress」 |
| 搜尋頁面 | 「搜尋 Confluence OTCAPP 空間的開發文件」 |
| 讀取頁面 | 「讀取這頁 Confluence 的內容」 |
| 建立頁面 | 「在 APP 空間建立一個會議記錄頁面」 |
| 新增評論 | 「在這頁下方加一條評論」 |

## 多電腦同步設定

每台新電腦只需：① 安裝 uv ② 編輯 opencode.json 加入相同設定 ③ 放置 PAT ④ 重啟 OpenCode。

> 安全提醒：PAT 是敏感憑證，每台電腦**手動設定**，勿透過網路或 AI 傳輸。

## 解除安裝

從 `~/.config/opencode/opencode.json` 的 `mcp` 區塊移除 `mcp-atlassian` 段落即可。

## 常見問題

| 問題 | 解法 |
|------|------|
| PAT 過期 | 到 Profile → Personal Access Tokens 重新產生 |
| SSL 錯誤 | 確認 `SSL_VERIFY=false` 已設定 |
| uvx 找不到 | 確認 uv 已安裝 |
| 連線逾時 | 檢查內網或 VPN 連線 |
| 權限不足 | 向 IT 管理員申請權限 |

## 完成回報格式

```
✅ #20 公司 JIRA & Confluence 已安裝完成！
- 套件：sooperset/mcp-atlassian
- JIRA 網址：https://jira.ovt.com/
- Confluence 網址：https://confluence.ovt.com/
- PAT 設定：單 PAT / 雙 PAT
- SSL 驗證：已關閉
- 工具數量：72 個
- 使用方式：說「幫我查 JIRA Issue」「搜尋 Confluence 頁面」
```
