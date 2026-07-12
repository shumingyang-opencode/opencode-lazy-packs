# OpenCode 懶人包 #21：安裝公司 Trac — Ticket 管理、Wiki 查閱、搜尋自動化

> 版本：v0.2
> 更新日期：2026-06-23

---

## 這個懶人包會幫你做什麼？

讓 OpenCode 透過 `trac-mcp-server` 操作公司內部的 **Trac 1.2.6** 系統，包含：

- **Ticket 管理**：查詢（Trac query 語法）、查看詳情、建立、更新、指派、關閉
- **Wiki 查閱**：列出所有頁面、讀取頁面內容（原始 wiki 標記或 HTML）
- **全文搜尋**：跨 ticket / wiki 檢索
- **雙實例支援**：同時支援 `app` 與 `app_asic` 兩個 Trac 專案

安裝後你可以在 OpenCode 中直接說「列出 assign 給我的 ticket」、「讀取 WikiStart 頁面」、「搜尋 I2C timeout」。

---

## 先備條件

- [ ] OpenCode 已安裝（若無，先執行 `00-環境建置`）
- [ ] `uv` 已安裝（`uv --version` 確認）
- [ ] 公司 GitLab 可存取：`https://gitlab.ovt.com:8081/`
- [ ] `個人帳號與服務清單.md` 已建立（含 Trac 區段）
- [ ] Trac 帳號密碼（含 `app` 與 `app_asic` 各自的帳號）
- [ ] 公司內部網路連線（或 VPN）
- [ ] 公司 GitLab 的 git credential 已設定

---

## 請 OpenCode 幫我執行以下步驟

### 步驟零：先建立／更新個人帳號清單

執行安裝前，先確認你的 `個人帳號與服務清單.md` 中已有 **Trac** 區段。若無，請在該檔案中加入以下內容：

```yaml
## Trac

- **app URL**: `https://10.0.0.77/trac/app`
- **app username**: `<你的 app 登入帳號>`
- **app password**: 儲存於 `opencode.json` trac 的 `TRAC_APP_PASSWORD`
- **app_asic URL**: `https://10.0.0.77/trac/app_asic`
- **app_asic username**: `<你的 app_asic 登入帳號>`
- **app_asic password**: 儲存於 `opencode.json` trac 的 `TRAC_APP_ASIC_PASSWORD`
- **SSL**: 自簽憑證（`TRAC_SSL_VERIFY=false`）
- **操作方式**: 透過 trac-mcp-server MCP 伺服器（`trac_*` 工具）
- **雙實例說明**: `app` 與 `app_asic` 的登入帳號可能不同（大小寫有區分）
```

> **已初始化過的使用者**：可跳過，直接在後續 opencode.json 設定中填入帳號資訊即可。

### 步驟一：安裝 trac-mcp-server（一次安裝，永久離線使用）

```bash
uv tool install --from "git+https://gitlab.ovt.com:8081/steven.yang/trac-mcp-server.git" trac-mcp-server
```

安裝成功後會顯示：
```
Installed 38 packages in ...s
Installed 1 executable: trac-mcp
```

### 步驟二：編輯 opencode.json

開啟 `~/.config/opencode/opencode.json`，在 `mcp` 區塊中加入。帳號資訊從 `個人帳號與服務清單.md` 取得，**無須記憶**：

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

> **SSL 說明**：`TRAC_SSL_VERIFY=false` 是因為公司 Trac 使用自簽憑證。若後續換成公開 CA 憑證可改為 `true` 或刪除此行。
> **帳號來源**：`TRAC_APP_USERNAME` 和 `TRAC_APP_ASIC_USERNAME` 對應 `個人帳號與服務清單.md` 中 Trac 區段的帳號。
> **雙實例說明**：`app` 與 `app_asic` 為兩個獨立的 Trac 專案，帳號可能不同（大小寫有區分）。

### 步驟三：重啟並驗證工具載入

儲存後重啟 OpenCode，然後輸入：

```
請列出你現在有哪些 MCP 工具可以使用？
```

你應該會看到 8 個以 `trac_` 開頭的工具：
- `trac_list_projects` — 列出 Trac 實例
- `trac_query_tickets` — 查詢 ticket
- `trac_get_ticket` — 查看 ticket 詳情
- `trac_create_ticket` — 建立 ticket
- `trac_update_ticket` — 更新 ticket
- `trac_list_wiki_pages` — 列出 wiki 頁面
- `trac_get_wiki_page` — 讀取 wiki 頁面
- `trac_search` — 全文檢索

### 步驟四：操作測試

依序測試以下功能：

```
請列出所有可用的 Trac 專案
```

```
請查詢 app_asic 專案中 assign 給我的 open ticket
```

```
請顯示其中一筆 ticket 的詳細資訊
```

```
請讀取 app 專案的 WikiStart 頁面內容
```

---

## 使用方式

安裝後你可以在 OpenCode 中「用說的」操作 Trac。OpenCode 會自動判斷你的意圖並選用正確的工具。

### Ticket 管理

| 你要做什麼 | 對 OpenCode 說 | 幕後工具 |
|-----------|---------------|---------|
| 列出專案 | 「列出所有可用的 Trac 專案」 | `trac_list_projects` |
| 查我的 ticket | 「列出 app 中 assign 給我的 open ticket」 | `trac_query_tickets` |
| 依條件查詢 | 「查 app_asic 中 priority 為 High 的 open ticket」 | `trac_query_tickets` |
| 自訂查詢 | 「用 trac_query_tickets 查 status!=closed&component=OV495_develop」 | `trac_query_tickets` |
| 查看 ticket | 「顯示 ticket #2804 的完整資訊」 | `trac_get_ticket` |
| 建立 ticket | 「在 app 開一張 defect，標題為 I2C timeout，priority critical」 | `trac_create_ticket` |
| 指派 ticket | 「把 ticket #2804 assign 給 john」 | `trac_update_ticket` |
| 修改屬性 | 「把 ticket #2804 的 priority 改為 High」 | `trac_update_ticket` |
| 關閉 ticket | 「把 ticket #2804 關閉，resolution fixed，留言：已修復」 | `trac_update_ticket` |
| 留言 | 「在 ticket #2804 留言：正在處理中」 | `trac_update_ticket` |

### Wiki 查閱

| 你要做什麼 | 對 OpenCode 說 | 幕後工具 |
|-----------|---------------|---------|
| 列出頁面 | 「列出 app_asic 的所有 wiki 頁面」 | `trac_list_wiki_pages` |
| 讀取頁面 | 「讀取 app 的 WikiStart 頁面」 | `trac_get_wiki_page` |
| 讀取 HTML | 「讀取 WikiStart 的 HTML 格式」 | `trac_get_wiki_page`（as_html=true） |

### 搜尋

| 你要做什麼 | 對 OpenCode 說 | 幕後工具 |
|-----------|---------------|---------|
| 全文搜尋 | 「在 app 搜尋 I2C timeout 相關的 ticket」 | `trac_search` |
| 跨系統搜尋 | 「在 app_asic 搜尋 safety mode」 | `trac_search` |

---

### 進階 Trac Query 語法

Trac query 語法類似 URL query string，多個條件用 `&` 串接：

| 語法 | 說明 |
|------|------|
| `status!=closed` | 狀態不等於 closed |
| `status=closed&priority=major` | 等於 closed 且 priority 為 major |
| `owner=steven.yang@ovt.com` | 負責人為指定使用者 |
| `status!=closed&component=OV495_develop` | 非 closed 且元件為 OV495_develop |
| `status!=canceled&status!=closed` | 同時排除 canceled 與 closed |

### 進階技巧

#### 1. 直接指定工具名稱

如果你已經知道要用哪個工具，可以直接指名：

```
用 trac_get_ticket 看 ticket #2804
用 trac_search 在 app_asic 搜尋 I2C
用 trac_query_tickets 查 status!=closed&priority=High
```

#### 2. 組合多步驟指令

OpenCode 可以一次理解並執行多步驟操作。例如：

> 「查 app_asic 中 High priority 的 ticket，列出摘要和狀態」

OpenCode 會依序：
1. 用 `trac_query_tickets` 查詢符合條件的 ticket
2. 用 `trac_get_ticket` 逐一取得摘要和狀態
3. 格式化輸出結果

#### 3. 查看可用工具

隨時可以問：

> 「列出你現在所有 MCP 工具」

來查看目前有哪些 `trac_` 開頭的工具可用。

#### 4. 使用提示

- **雙實例**：大部分工具都需要指定 `instance` 參數（`app` 或 `app_asic`），如果不確定，先執行 `trac_list_projects`
- **帳號來源**：所有服務帳號集中存放於 `個人帳號與服務清單.md`，AI agent 會自動讀取，無須記憶
- **帳號區分大小寫**：`app` 與 `app_asic` 的登入帳號可能不同（大小寫有區分）
- **查詢語法**：Trac query 使用 `key=value` 格式，`!=` 表示不等於

---

## 多電腦同步設定

這組 trac-mcp-server 設定可以跨電腦使用：

| 電腦 | 設定步驟 |
|------|---------|
| **電腦 A（已設定）** | 已可使用 |
| **電腦 B（新電腦）** | ① 確認 uv 已安裝 ② `uv tool install --from "git+https://gitlab.ovt.com:8081/steven.yang/trac-mcp-server.git" trac-mcp-server` ③ 在 opencode.json 加入 trac 設定 ④ 重啟 OpenCode ⑤ 完成 |

> **安全提醒**：Trac 密碼相當於你的登入憑證，每台電腦都需手動填入，避免在多台電腦間明文傳遞。

---

## 解除安裝

```bash
# 1. 移除本機工具
uv tool uninstall trac-mcp-server

# 2. 從 opencode.json 的 mcp 區塊移除 trac 段落
# （或將 "enabled": true 改為 false 即可暫停使用）
```

---

## 常見問題

| 問題 | 解法 |
|------|------|
| `uv tool install` 失敗 | 確認 GitLab 連線正常（`git ls-remote https://gitlab.ovt.com:8081/steven.yang/trac-mcp-server.git`） |
| SSL 錯誤 | 確認 `TRAC_SSL_VERIFY=false` 已設定 |
| 登入失敗 | 確認帳號密碼正確，注意大小寫區分（app / app_asic 使用不同帳號） |
| 忘記帳號密碼 | 查閱 `個人帳號與服務清單.md` 中的 Trac 區段，或向 IT 申請重設 |
| 404 錯誤 | Trac 的 XML-RPC 端點未安裝外掛。此套件已改用 Web Scraping 方式，不需 XML-RPC |
| `uvx` 找不到 | 確認 uv 已安裝（`uv --version`），若無請執行安裝指令 |
| 工具未載入 | 檢查 opencode.json JSON 格式是否正確，重啟 OpenCode |
| Windows 路徑問題 | `command` 陣列只需 `["trac-mcp"]`，uv tool install 會自動處理路徑 |
| 連線逾時 | 確認在公司內網或已連線 VPN |
| trac-mcp 指令找不到 | 執行 `uv tool list` 確認是否已安裝，或檢查 `~/.local/bin` 是否在 PATH 中 |

---

## 完成回報格式

```md
✅ #21 公司 Trac 已安裝完成！
- 套件：trac-mcp-server（自建，已上架 GitLab）
- 安裝來源：git+https://gitlab.ovt.com:8081/steven.yang/trac-mcp-server.git
- Trac 實例：app + app_asic（共 2 個）
- SSL 驗證：已關閉（公司內部自簽憑證）
- 登入方式：Trac 表單登入（帳號儲存於 `個人帳號與服務清單.md`）
- 工具數量：8 個
- 使用方式：說「查我的 ticket」「讀取 wiki 頁面」
```

---


## Trae 對應操作

> 若你使用 **Trae IDE**，以下為對應的安裝/更新/移除步驟。

### 在 Trae 上安裝（專案層級）

編輯 `.trae/mcp.json`（若無則建立），在 `"mcpServers"` 區塊加入：

```json
{
  "mcpServers": {
    "trac": {
      "command": "trac-mcp",
      "env": {
        "TRAC_APP_URL": "https://10.0.0.77/trac/app",
        "TRAC_APP_USERNAME": "<個人帳號清單中的 app username>",
        "TRAC_APP_PASSWORD": "<你的 app 密碼>",
        "TRAC_APP_ASIC_URL": "https://10.0.0.77/trac/app_asic",
        "TRAC_APP_ASIC_USERNAME": "<個人帳號清單中的 app_asic username>",
        "TRAC_APP_ASIC_PASSWORD": "<你的 app_asic 密碼>",
        "TRAC_SSL_VERIFY": "false"
      }
    }
  }
}
```

### 在 Trae 上安裝（全域）

編輯 `~/.cursor/mcp.json`，在 `"mcpServers"` 區塊加入相同設定。

### 在 Trae 上更新

重複安裝步驟，覆蓋原有設定即可。

### 在 Trae 上移除

- **專案**：從 `.trae/mcp.json` 的 `"mcpServers"` 移除 `trac` 區塊
- **全域**：從 `~/.cursor/mcp.json` 的 `"mcpServers"` 移除 `trac` 區塊

> CLI 工具的安裝/更新/移除方式與 OpenCode 相同，無需額外步驟。

---

## 更新紀錄

| 日期 | 版本 | 更新內容 |
|------|------|---------|
| 2026-06-23 | v0.2 | 整合個人帳號與服務清單管理機制（README 同步） |
| 2026-06-23 | v0.1 | 初版 |
