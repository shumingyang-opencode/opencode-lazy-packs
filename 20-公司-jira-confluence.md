# OpenCode 懶人包 #20：安裝公司 JIRA & Confluence — Issue 管理、頁面搜尋、操作自動化

> 版本：v0.3
> 更新日期：2026-06-23

---

## 這個懶人包會幫你什麼

讓 OpenCode 透過 `mcp-atlassian` 同時操作公司內部的 **JIRA** 與 **Confluence**（Server/Data Center 版本），包含：

- **JIRA 操作**：搜尋 Issue（JQL）、查看詳情、建立/更新 Issue、轉移狀態、指派負責人
- **Confluence 操作**：搜尋頁面（CQL）、讀取內容、建立/更新頁面、新增評論
- **跨空間支援**：支援 `OTCAPP` 與 `APP（Application）` 兩個 Confluence 空間

安裝後你可以在 OpenCode 中直接說「幫我查 JIRA 上指派給我的 Issue」、「搜尋 Confluence OTCAPP 空間的開發文件」。

---

## 前置條件

- [ ] OpenCode 已安裝（若無，先執行 `00-環境建置`）
- [ ] Python / uvx 已安裝（mcp-atlassian 基於 Python）
- [ ] 公司 JIRA 網址：`https://jira.ovt.com/`
- [ ] 公司 Confluence 網址：`https://confluence.ovt.com/`
- [ ] 公司內部網路連線（或 VPN）
- [ ] 公司帳號（請向 IT 確認 JIRA 與 Confluence 是否為同一個 SSO 帳號，或分開的兩組帳號）

---

## 讓 OpenCode 幫你一步一步做

### Step 1：確認 uvx 環境

```bash
uv --version
```

若未安裝，請執行：
```bash
powershell -c "irm https://astral.sh/uv/install.ps1 | iex"
```

安裝後重開終端機，再次執行 `uv --version` 確認。

### Step 2：取得 Personal Access Token (PAT)

登入公司 JIRA 並產生 PAT：

1. 開啟瀏覽器至 `https://jira.ovt.com/`
2. 右上角頭像 → **Profile** → **Personal Access Tokens** → **Create token**
3. 輸入名稱（如 `opencode-mcp`）、設定過期時間（建議 365 天）
4. 點擊 **Create**，**立即複製 Token**（關閉視窗後不再顯示）

登入公司 Confluence 並產生 PAT：

1. 開啟瀏覽器至 `https://confluence.ovt.com/`
2. 右上角頭像 → **Profile** → **Personal Access Tokens** → **Create token**
3. 同上步驟

> **關於 PAT 共用**：
> - 若 JIRA 與 Confluence 使用同一個 SSO 帳號，**可以先嘗試共用同一個 PAT**
> - 若各自獨立登入，則需分別取得兩個 PAT
> - Step 7 有雙 PAT 的相容設定說明

### Step 3：編輯全域 opencode.json

開啟 `~/.config/opencode/opencode.json`，在 `mcp` 區塊中加入：

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
    "CONFLUENCE_SSL_VERIFY": "false",
    "TOOLSETS": "all"
  }
}
```

> **SSL 說明**：`SSL_VERIFY=false` 是針對公司內部自簽憑證。若你的公司已使用公開信任的 CA 憑證則可省略。
> **TOOLSETS 說明**：mcp-atlassian v0.22.0+ 預設只載入 6 個核心工具；設為 `"all"` 會載入全部 72 個工具。

### Step 4：驗證 MCP 工具載入

儲存後重啟 OpenCode，然後進行驗證：

```
請列出你現在有哪些 MCP 工具可以使用？
```

你應該會看到以 `jira_` 和 `confluence_` 開頭的工具列表（共 72 個工具）。

### Step 5：JIRA 操作測試

依序測試以下功能：

```
請幫我搜尋 JIRA 上最近更新且指派給我的 Issue（用 JQL 語法）
```

```
請顯示其中一筆 Issue 的詳細資訊（包括摘要、狀態、優先級、描述）
```

```
請在 JIRA 上建立一筆測試 Issue，專案代號請先查詢可用的專案
```

```
請將剛才建立的測試 Issue 轉移狀態到下一個階段
```

### Step 6：Confluence 操作測試

依序測試以下功能：

```
請幫我搜尋 Confluence OTCAPP 空間底下的頁面
```

```
請讀取其中一頁的完整內容
```

```
請在 OTCAPP 空間下建立一頁測試頁面，標題為「OpenCode 測試頁面」
```

```
請在剛才建立的測試頁面下方新增一則評論：此頁面由 OpenCode 自動建立
```

### Step 7：若需要雙 PAT（兩套帳號）

若 JIRA 與 Confluence 帳號不同（SSO 未整合），請分別取得兩個 PAT，修改 opencode.json：

```json
"mcp-atlassian": {
  "type": "local",
  "command": ["uvx", "mcp-atlassian"],
  "enabled": true,
  "environment": {
    "JIRA_URL": "https://jira.ovt.com",
    "JIRA_PERSONAL_TOKEN": "<YOUR_JIRA_PAT>",
    "CONFLUENCE_URL": "https://confluence.ovt.com",
    "CONFLUENCE_PERSONAL_TOKEN": "<YOUR_CONFLUENCE_PAT>",
    "JIRA_SSL_VERIFY": "false",
    "CONFLUENCE_SSL_VERIFY": "false",
    "TOOLSETS": "all"
  }
}
```

其餘步驟與單 PAT 完全相同。

---

## 使用方式

安裝後你可以在 OpenCode 中「用說的」操作 JIRA 與 Confluence。mcp-atlassian 提供 72 個工具，OpenCode 會自動判斷你的意圖並選用正確的工具。

> 💡 安裝精靈完成後會自動印出本教學。你也可以隨時查閱 Obsidian vault 內的 `個人帳號與服務清單.md` 取得所有服務資訊。

### JIRA 操作

#### 搜尋與查詢

| 你要做什麼 | 對 OpenCode 說 | 幕後工具 |
|-----------|---------------|---------|
| 搜尋我的 Issue | 「幫我查 JIRA 上指派給我的 Issue」 | `jira_search` |
| 依專案搜尋 | 「查 EAG 專案最近新增的 Defect」 | `jira_search` |
| 自訂 JQL 查詢 | 「用 jira_search 查 project = EAG AND status = 'In Progress'」 | `jira_search` |
| 查看 Issue 詳情 | 「顯示 EAG-942 的詳細資訊」 | `jira_get_issue` |
| 查詢可轉移狀態 | 「EAG-942 目前可以轉到哪些狀態？」 | `jira_get_transitions` |
| 列出所有專案 | 「列出 JIRA 上所有專案」 | `jira_get_all_projects` |
| 搜尋使用者 | 「搜尋 JIRA 使用者 may」 | `jira_get_user_profile` |
| 查詢版號 | 「列出 EAG 專案的所有 Fix Version」 | `jira_get_project_versions` |
| 查詢元件 | 「列出 MCUP 專案的元件」 | `jira_get_project_components` |
| 查看工作日誌 | 「顯示 EAG-942 的工作日誌」 | `jira_get_worklog` |
| 查看留言 | 「顯示 EAG-942 的所有留言」 | `jira_get_issue`（含 comment） |
| 查看開發資訊 | 「顯示 EAG-942 關聯的 PR 與分支」 | `jira_get_issue_development_info` |

#### 建立與更新

| 你要做什麼 | 對 OpenCode 說 | 幕後工具 |
|-----------|---------------|---------|
| 建立 Issue | 「在 MCUP 專案建立一個 Bug，標題為 影像處理異常」 | `jira_create_issue` |
| 建立 Epic | 「在 EAG 專案建立一個 Epic，標題為 Q3 效能優化」 | `jira_create_issue` |
| 連結 Epic | 「把 EAG-942 連結到 EPIC-123」 | `jira_link_to_epic` |
| 更新優先級 | 「把 EAG-942 的優先級改為 High」 | `jira_update_issue` |
| 指派人員 | 「把 EAG-942 指派給 may.wang」 | `jira_update_issue` |
| 修改標題 | 「把 EAG-942 的標題改為 XXX」 | `jira_update_issue` |
| 批次建立 | 「在 MCUP 專案批次建立 3 個 Task」 | `jira_batch_create_issues` |

#### 狀態管理

| 你要做什麼 | 對 OpenCode 說 | 幕後工具 |
|-----------|---------------|---------|
| 轉移狀態 | 「把 EAG-942 轉到 In Progress」 | `jira_transition_issue` |
| 轉移並留言 | 「把 EAG-942 轉到 Done，留言：已修復完成」 | `jira_transition_issue` |
| 轉移並設定解決方案 | 「把 EAG-942 轉到 Closed，解決方案為 Fixed」 | `jira_transition_issue` |

#### 協作

| 你要做什麼 | 對 OpenCode 說 | 幕後工具 |
|-----------|---------------|---------|
| 新增留言 | 「在 EAG-942 下方留言：已修復，請驗證」 | `jira_add_comment` |
| 編輯留言 | 「把 EAG-942 的第 5 則留言改為：重新驗證中」 | `jira_edit_comment` |
| 新增工時 | 「在 EAG-942 登錄工時 2h，備註：程式碼審查」 | `jira_add_worklog` |
| 加入觀察者 | 「把 may.wang 加為 EAG-942 的觀察者」 | `jira_add_watcher` |
| 建立 Issue 關聯 | 「把 EAG-942 設為 EAG-943 的阻斷者」 | `jira_create_issue_link` |
| 上傳附件 | 「上傳 report.pdf 到 EAG-942」 | `jira_update_issue` |

---

### Confluence 操作

#### 搜尋與瀏覽

| 你要做什麼 | 對 OpenCode 說 | 幕後工具 |
|-----------|---------------|---------|
| 搜尋頁面 | 「搜尋 Confluence OTCAPP 空間的開發文件」 | `confluence_search` |
| 空間頁面樹 | 「列出 OTCAPP 空間的頁面結構」 | `confluence_get_space_page_tree` |
| 讀取頁面 | 「讀取 Confluence 頁面 ID 5144591 的內容」 | `confluence_get_page` |
| 列出子頁面 | 「列出這頁底下有哪些子頁面」 | `confluence_get_page_children` |
| 查看附件列表 | 「列出這頁的附件」 | `confluence_get_attachments` |
| 下載附件 | 「下載這頁的所有附件」 | `confluence_download_content_attachments` |
| 檢視圖片 | 「顯示這頁的所有圖片」 | `confluence_get_page_images` |
| 查閱版本歷史 | 「顯示這頁的版本歷史」 | `confluence_get_page_history` |
| 版本比對 | 「比對這頁第 3 版與第 5 版的差異」 | `confluence_get_page_diff` |

#### 建立與編輯

| 你要做什麼 | 對 OpenCode 說 | 幕後工具 |
|-----------|---------------|---------|
| 建立頁面 | 「在 APP 空間建立一頁會議記錄，標題為 2026-06-23 站會」 | `confluence_create_page` |
| 建立子頁面 | 「在頁面 5144591 底下建立一頁測試計畫」 | `confluence_create_page` |
| 更新內容 | 「更新這頁的內容，在結尾加上附錄」 | `confluence_update_page` |
| 更名頁面 | 「把這頁的標題改為 XXX」 | `confluence_update_page` |
| 搬移頁面 | 「把這頁搬到 OTCAPP 空間的首頁底下」 | `confluence_move_page` |
| 刪除頁面 | 「刪除這頁」 | `confluence_delete_page` |
| 上傳附件 | 「上傳 design.docx 到這頁」 | `confluence_upload_attachment` |
| 批次上傳 | 「上傳 images/ 資料夾的所有 PNG 到這頁」 | `confluence_upload_attachments` |

#### 協作與標籤

| 你要做什麼 | 對 OpenCode 說 | 幕後工具 |
|-----------|---------------|---------|
| 新增評論 | 「在這頁下方加一條評論：內容已更新」 | `confluence_add_comment` |
| 回覆評論 | 「回覆這則評論：好的，已修正」 | `confluence_reply_to_comment` |
| 查看評論 | 「顯示這頁的所有評論」 | `confluence_get_comments` |
| 加入標籤 | 「在這頁加上標籤：documentation」 | `confluence_add_label` |
| 查看標籤 | 「顯示這頁的所有標籤」 | `confluence_get_labels` |
| 查看瀏覽次數 | 「顯示這頁的瀏覽統計」 | `confluence_get_page_views` |

---

### 跨系統應用

OpenCode 可以串聯 JIRA 與 Confluence 完成跨系統任務：

| 任務 | 對 OpenCode 說 | 自動步驟 |
|-----|---------------|---------|
| Issue 彙整 | 「搜尋 EAG 專案的 Open Issues，整理成 Confluence 頁面」 | ① `jira_search` 查詢 ② `confluence_create_page` 建立彙整頁 |
| Bug 分析記錄 | 「把 EAG-942 的 Bug 分析貼到 Confluence OTCAPP 空間」 | ① `jira_get_issue` 讀取 ② `confluence_create_page` 寫入 |
| 站會報告 | 「查我這個 Sprint 完成的 Issue，在 APP 空間建立站會記錄」 | ① `jira_search` 查詢 ② `confluence_create_page` 建立 |

---

### 進階技巧

#### 1. 直接指定工具名稱

如果你已經知道要用哪個工具，可以直接指名，不必繞圈描述：

```
用 jira_search 查 project = EAG ORDER BY created DESC
用 confluence_get_page 讀取頁面 ID 5144591 的內容
```

這在需要特定 JQL/CQL 語法時特別有效率，也可避免 OpenCode 誤判意圖。

#### 2. 組合多步驟指令

OpenCode 可以一次理解並執行多步驟操作。例如：

> 「查詢 EAG 專案中狀態為 New 的 High 優先級 Bug，建立一個 Confluence 頁面來彙整這些 Issue」

OpenCode 會依序：
1. 用 `jira_search` 搜尋符合條件的 Issue
2. 用 `confluence_create_page` 建立彙整頁面
3. 將結果格式化寫入頁面內容

#### 3. 查看可用工具

隨時可以問：

> 「列出你現在所有 MCP 工具」

來查看目前有哪些 `jira_` / `confluence_` 開頭的工具可用。

#### 4. 使用提示

- **Issue Key 格式**：公司 JIRA 使用 `專案代號-數字`，如 `EAG-942`
- **Confluence 頁面 ID**：可從頁面網址取得（`pageId=5144591`），或用搜尋功能找到
- **JQL 語法**：`project = EAG AND status = 'In Progress' ORDER BY priority DESC`
- **CQL 語法**：`type = page AND space = OTCAPP AND title ~ "會議"`

---



## 多電腦同步設定

這組 mcp-atlassian 設定可以跨電腦使用：

| 電腦 | 設定步驟 |
|------|---------|
| **電腦 A（已設定）** | 已可使用 |
| **電腦 B（新電腦）** | ① 確認 uvx 已安裝 ② 在 JIRA/Confluence 產生 PAT ③ 在 opencode.json 加入 mcp-atlassian ④ 重啟 OpenCode ⑤ 完成 |

> **安全提醒**：PAT 相當於你的密碼，每台電腦都需手動產生或設定，**不要透過網路或 AI 傳輸 PAT 值**。

---

## 解除安裝

```bash
# 從 opencode.json 的 mcp 區塊移除 mcp-atlassian 段落
# （或將 "enabled": true 改為 false 即可暫停使用）
```

---

## 常見問題

| 問題 | 解法 |
|------|------|
| PAT 過期 | 到 JIRA/Confluence Profile → Personal Access Tokens → 重新產生並更新 opencode.json |
| SSL 錯誤 | 確認 `JIRA_SSL_VERIFY=false` 和 `CONFLUENCE_SSL_VERIFY=false` 已設定 |
| `uvx` 找不到 | 確認 uv 已安裝（`uv --version`），若無請執行安裝指令 |
| 工具未載入 | 檢查 opencode.json JSON 格式是否正確（缺少逗號等），重啟 OpenCode |
| Windows `python3` 找不到 | Windows 使用 `python` 或 `py`，但 mcp-atlassian 透過 uvx 啟動，無此問題 |
| 連線逾時 | 確認在公司內網或已連線 VPN |
| 權限不足 | PAT 可能缺少足夠權限，請向 JIRA/Confluence 管理員申請 |
| Confluence 特定空間找不到 | 搜尋時請加上空間名稱，如「搜尋 OTCAPP 空間的頁面」 |

---

## 附錄：mcp-atlassian 工具速查表

mcp-atlassian 提供 72 個工具，以下是常用工具分類：

### JIRA 工具

| 工具名稱 | 說明 |
|----------|------|
| `jira_search` | 使用 JQL 搜尋 Issue（支援多種條件篩選） |
| `jira_get_issue` | 取得 Issue 詳細資訊（摘要、描述、狀態、優先級、指派人等） |
| `jira_create_issue` | 建立新的 Issue（需指定專案代號、類型、摘要） |
| `jira_update_issue` | 更新 Issue 欄位（優先級、指派人、描述等） |
| `jira_transition_issue` | 轉移 Issue 狀態（如 To Do → In Progress → Done） |
| `jira_add_comment` | 在 Issue 下方新增評論 |
| `jira_get_transitions` | 查詢 Issue 可轉移的狀態列表 |
| `jira_get_projects` | 列出所有可用的專案 |
| `jira_get_users` | 搜尋使用者 |
| `jira_get_dashboard` | 查看儀表板 |

### Confluence 工具

| 工具名稱 | 說明 |
|----------|------|
| `confluence_search` | 使用 CQL 搜尋頁面（可指定空間、關鍵字） |
| `confluence_get_page` | 取得頁面完整內容 |
| `confluence_create_page` | 建立新頁面（需指定空間與父頁面） |
| `confluence_update_page` | 更新頁面內容 |
| `confluence_delete_page` | 刪除頁面 |
| `confluence_add_comment` | 在頁面下方新增評論 |
| `confluence_get_comments` | 讀取頁面的評論列表 |
| `confluence_get_spaces` | 列出所有空間 |
| `confluence_get_page_children` | 取得頁面子頁面列表 |
| `confluence_get_attachments` | 取得頁面附件列表 |

---

## 完成回報格式

```
✅ #20 公司 JIRA & Confluence 已安裝完成！
- 套件：sooperset/mcp-atlassian
- JIRA 網址：https://jira.ovt.com/
- Confluence 網址：https://confluence.ovt.com/
- PAT 設定：單 PAT / 雙 PAT（依實際情況）
- SSL 驗證：已關閉（公司內部憑證）
- 常用空間：OTCAPP、APP（Application）
- 工具數量：72 個（JIRA + Confluence）
- 使用方式：說「幫我查 JIRA Issue」「搜尋 Confluence 頁面」
```

---

## 版本記錄

| 日期 | 版本 | 更新內容 |
|------|------|---------|
| 2026-06-23 | v0.3 | 完整擴充使用方式：JIRA 16 項/Confluence 14 項操作教學 + 跨系統應用 + 進階技巧 |
| 2026-06-23 | v0.2 | 補上 `TOOLSETS=all`（mcp-atlassian v0.22.0+ 預設只載入 6 核心工具） |
| 2026-06-23 | v0.1 | 初版 |
