---
name: opencode-trac
description: 安裝公司 Trac 整合 — 讓 OpenCode 操作公司內部 Trac Ticket 管理與 Wiki 查閱。說「安裝 Trac」「安裝公司 Trac」「公司 Trac 設定」「Trac 安裝」時載入。
---

# 安裝公司 Trac（OpenCode 版）

讓 OpenCode 透過 `trac-mcp-server` 操作公司內部的 Trac 1.2.6，包含查詢/建立/更新 ticket、讀取 wiki 頁面、全文搜尋等 8 個工具。

## 前置條件

- [ ] OpenCode 已安裝
- [ ] `uv` 已安裝（`uv --version` 確認）
- [ ] 公司內網連線（或 VPN）
- [ ] 公司 Trac 帳號密碼（注意 `app` 與 `app_asic` 可能不同）

## 步驟

### 0. 先讀取帳號資訊

先從使用者的 `個人帳號與服務清單.md` 讀取 Trac 區段的帳號資訊。

若該檔案尚無 Trac 區段，請引導使用者加入：

```markdown
## Trac

- **app URL**: `https://10.0.0.77/trac/app`
- **app username**: `<你的 app 登入帳號>`
- **app password**: 儲存於 `opencode.json` trac 的 `TRAC_APP_PASSWORD`
- **app_asic URL**: `https://10.0.0.77/trac/app_asic`
- **app_asic username**: `<你的 app_asic 登入帳號>`
- **app_asic password**: 儲存於 `opencode.json` trac 的 `TRAC_APP_ASIC_PASSWORD`
- **SSL**: 自簽憑證（`TRAC_SSL_VERIFY=false`）
- **操作方式**: 透過 trac-mcp-server MCP 伺服器（`trac_*` 工具）
```

> 帳號密碼由使用者手動填入 opencode.json，不寫入 Markdown 檔案。

### 1. 安裝 trac-mcp-server

```bash
uv tool install --from "git+https://gitlab.ovt.com:8081/steven.yang/trac-mcp-server.git" trac-mcp-server
```

安裝成功會顯示 `Installed 1 executable: trac-mcp`。

### 2. 編輯 opencode.json

讀取使用者當前的 `~/.config/opencode/opencode.json`，在 `mcp` 區塊加入。帳號資訊從 `個人帳號與服務清單.md` 取得：

```json
"trac": {
  "type": "local",
  "enabled": true,
  "command": ["trac-mcp"],
  "environment": {
    "TRAC_APP_URL": "https://10.0.0.77/trac/app",
    "TRAC_APP_USERNAME": "<個人帳號清單中的 app username>",
    "TRAC_APP_PASSWORD": "<你的 app 密碼>",
    "TRAC_APP_ASIC_URL": "https://10.0.0.77/trac/app_asic",
    "TRAC_APP_ASIC_USERNAME": "<個人帳號清單中的 app_asic username>",
    "TRAC_APP_ASIC_PASSWORD": "<你的 app_asic 密碼>",
    "TRAC_SSL_VERIFY": "false"
  }
}
```

> SSL 說明：公司內部自簽憑證需設 `TRAC_SSL_VERIFY=false`。
> 帳號來源：對應 `個人帳號與服務清單.md` 中 Trac 區段的帳號。
> 雙實例說明：`app` 與 `app_asic` 帳號可能不同（大小寫有區分）。

請使用者將帳號密碼改為實際的 Trac 登入資訊（參考 Step 0 的帳號清單）。

### 3. 重啟驗證

請使用者重啟 OpenCode，然後驗證工具是否載入：

```text
請列出你現在有哪些 MCP 工具可以使用？
```

確認出現 `trac_` 開頭的 8 個工具。

### 4. 操作驗證

依序執行以下測試（請使用者逐行確認）：

**4.1 列出專案**：`請列出所有可用的 Trac 專案`

**4.2 查詢 ticket**：`請查詢 app_asic 專案中 assign 給我的 open ticket`

**4.3 查看 ticket**：`請顯示其中一筆 ticket 的詳細資訊`

**4.4 讀取 wiki**：`請讀取 app 專案的 WikiStart 頁面內容`

### 5. 自訂查詢測試

**5.1**：`用 trac_query_tickets 查 app_asic 中 status!=canceled 的 ticket`

**5.2**：`用 trac_search 在 app 搜尋 test`

## 完成後的驗證

1. **連線測試**：`請列出所有可用的 Trac 專案`
2. **Ticket 查詢**：`請查 app_asic 中 assign 給我的 ticket`
3. **Wiki 讀取**：`請讀取 app 的 WikiStart 頁面`
4. **搜尋**：`請在 app_asic 搜尋 test`

## 安裝完成 — 輸出使用教學給使用者

**所有步驟完成後，請將以下操作速查表直接輸出給使用者（不要只說「完成了」，要印出完整教學）：**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  ✅ 公司 Trac 已安裝完成
  套件：trac-mcp-server（8 工具）
  實例：app + app_asic
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

【Ticket 管理】

  查詢
  ├─ 列出所有可用的 Trac 專案
  ├─ 列出 app 中 assign 給我的 open ticket
  ├─ 查 app_asic 中 priority 為 High 的 open ticket
  └─ 用 trac_query_tickets 查 status!=closed&component=OV495_develop

  檢視與操作
  ├─ 顯示 ticket #2804 的完整資訊
  ├─ 在 app 開一張 defect，標題為 I2C timeout，critical
  ├─ 把 ticket #2804 assign 給 john
  ├─ 把 ticket #2804 關閉，resolution fixed
  └─ 在 ticket #2804 留言：正在處理中

【Wiki 查閱】

  ├─ 列出 app_asic 的所有 wiki 頁面
  ├─ 讀取 app 的 WikiStart 頁面
  └─ 讀取 WikiStart 的 HTML 格式

【搜尋】

  ├─ 在 app 搜尋 I2C timeout
  └─ 在 app_asic 搜尋 safety mode

【進階】

  直接指定工具：
    用 trac_get_ticket 看 ticket #2804
    用 trac_search 在 app_asic 搜尋 I2C
    用 trac_query_tickets 查 status!=closed&priority=High

  查看所有工具：
    列出你現在所有 MCP 工具

   提示：Trac query 語法使用 key=value，!= 表示不等於
         帳號資訊存放於「個人帳號與服務清單.md」
         兩個實例：app / app_asic（帳號可能不同）
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

## 多電腦同步設定

每台新電腦只需：① 安裝 uv ② `uv tool install --from "git+https://gitlab.ovt.com:8081/steven.yang/trac-mcp-server.git" trac-mcp-server` ③ 編輯 opencode.json 加入 trac 設定 ④ 重啟 OpenCode。

> 安全提醒：Trac 密碼是敏感憑證，每台電腦**手動填入**。

## 解除安裝

```bash
uv tool uninstall trac-mcp-server
# 並從 opencode.json 移除 trac 段落
```

## 常見問題

| 問題 | 解法 |
|------|------|
| SSL 錯誤 | 確認 `TRAC_SSL_VERIFY=false` 已設定 |
| 登入失敗 | 檢查帳號密碼正確性，注意大小寫（查 `個人帳號與服務清單.md`） |
| 連線逾時 | 檢查內網或 VPN 連線 |
| uv tool install 失敗 | 確認 GitLab 連線及 git credential 設定 |
| trac-mcp 找不到 | 確認 `~/.local/bin` 在 PATH 中 |

## 完成回報格式

```
✅ #21 公司 Trac 已安裝完成！
- 套件：trac-mcp-server（自建，GitLab 安裝）
- Trac 實例：app + app_asic（共 2 個）
- SSL 驗證：已關閉
- 帳號來源：個人帳號與服務清單.md
- 工具數量：8 個
- 使用方式：說「查我的 ticket」「讀取 wiki 頁面」
```
