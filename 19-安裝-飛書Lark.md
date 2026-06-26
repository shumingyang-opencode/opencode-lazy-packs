# OpenCode 懶人包 #19：安裝飛書 Lark — 文檔、訊息、群組、日曆、多維表格

> 版本：v0.1
> 更新日期：2026-06-23

---

## 這個懶人包會幫你做什麼？

讓 OpenCode 獲得完整的飛書（Lark）操作能力，透過社群專案 `feishu-inout`：

- **文檔操作** — 搜尋、閱讀、建立、編輯（7 種編輯模式）、評論
- **訊息收發** — 發送/閱讀/回覆/搜尋訊息，支援 Markdown、@提及、表情
- **群組管理** — 建立群組、新增成員、列出群組
- **日曆會議** — 建立日程（自動生成飛書視頻會議）、查看今日行程
- **多維表格** — 讀取、建立、更新記錄

安裝後你可以在 OpenCode 中說「幫我操作飛書文檔」「發飛書訊息給 David」來啟用。

---

## 先備條件

- [ ] OpenCode 已安裝
- [ ] `open-computer-use` 已安裝（懶人包 #09）
- [ ] 電腦有網路連線
- [ ] 有飛書帳號（可用 Google 帳號）

---

## 請 OpenCode 幫我執行以下步驟

### 步驟一：安裝 feishu-inout skill

```bash
npx skills add joe960913/feishu-inout
```

> ⚠️ **路徑注意**：feishu-inout 的說明文件預設使用 `~/.claude/skills/`（Claude Code 路徑），OpenCode 會安裝在 `~/.config/opencode/skills/` 或 `~/.agents/skills/` 下。安裝後請用以下指令找到實際路徑：
>
> **Windows (PowerShell)：**
> ```powershell
> Get-ChildItem -Path $env:USERPROFILE -Filter "feishu_mcp.py" -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1 -ExpandProperty FullName
> ```
>
> **macOS / Linux：**
> ```bash
> find ~/.config/opencode/skills ~/.agents/skills ~/.claude/skills -name "feishu_mcp.py" 2>/dev/null | head -1
> ```

### 步驟二：透過瀏覽器建立飛書應用

請 OpenCode 用 open-computer-use 開啟瀏覽器協助你建立應用。流程如下：

1. OpenCode 開啟瀏覽器至 [飛書開放平台](https://open.feishu.cn/app)
2. **你手動輸入帳號密碼登入**（OpenCode 不會取得你的密碼）
3. OpenCode 點擊「建立自建應用」
4. 輸入應用名稱（如「OpenCode 助手」）與描述
5. 建立完成後，從 **Credentials & Basic Info** 頁面取得：
   - **App ID**（格式：`cli_xxxxxxxxxxxxxxxx`）
   - **App Secret**（請勿外洩）
6. OpenCode 記錄這兩個值

### 步驟三：批量匯入權限

OpenCode 導航至應用 → **權限管理** → **批量導入/導出權限**，貼入以下權限字串：

```
docx:document:readonly,search:docs:read,wiki:wiki:readonly,im:chat:read,task:task:read,docx:document,docx:document:create,docx:document:write_only,docs:document.media:upload,docs:document.media:download,wiki:node:read,wiki:node:create,docs:document.comment:read,docs:document.comment:create,contact:user:search,contact:contact.base:readonly,contact:user.base:readonly,board:whiteboard:node:read,drive:drive,im:message,im:message:send_as_bot,im:chat,search:message,im:message.send_as_user,im:message.p2p_msg:get_as_user,im:message.group_msg:get_as_user,calendar:calendar:readonly,calendar:calendar,bitable:app:readonly,bitable:app,im:chat:create
```

此字串涵蓋：文檔（讀+寫）、訊息（收+發+搜尋）、日曆、多維表格、群組管理，共 30+ 權限。

> 「User」類型權限顯示「與用戶範圍一致」為正常；「App」類型顯示「-」也正常。確認全部顯示 ✅ **已啟用**。

### 步驟四：設定重定向 URL

OpenCode 導航至應用 → **安全設置** → **重定向 URL** → **添加**：

```
http://localhost:9876/callback
```

這是 OAuth 登入取得 User Access Token (UAT) 的必要設定。

### 步驟五：啟用機器人能力

OpenCode 導航至應用 → **添加能力** → 開啟 **機器人** 開關。

> **關於 Bot 的說明（重要）**：
> - **發送/閱讀訊息**（私聊、群聊）：使用 **UAT（用戶身份）**，不需 Bot 能力，步驟五可跳過
> - **群組管理**（create-group, add-members, list-groups）：使用 **TAT（應用身份）**，需要 Bot 能力 + 應用版本發布審核 + 將 Bot 加入群組
> - 如果只需要文檔讀寫 + 以個人身份收發訊息，可以跳過此步驟

### 步驟六：設定環境變數

請 OpenCode 幫你設定環境變數（**自行操作，勿將 App Secret 傳給 AI**）：

**Windows (PowerShell)：**
```powershell
[System.Environment]::SetEnvironmentVariable('FEISHU_APP_ID', '你的AppID', 'User')
[System.Environment]::SetEnvironmentVariable('FEISHU_APP_SECRET', '你的AppSecret', 'User')
```

**macOS / Linux：**
```bash
echo 'export FEISHU_APP_ID="你的AppID"' >> ~/.zshrc
echo 'export FEISHU_APP_SECRET="你的AppSecret"' >> ~/.zshrc
source ~/.zshrc
```

驗證（只驗證 App ID，不輸出 App Secret）：
```powershell
# Windows
Write-Output "FEISHU_APP_ID = $env:FEISHU_APP_ID"
```
```bash
# macOS / Linux
echo $FEISHU_APP_ID
```

### 步驟七：OAuth 登入授權

請 OpenCode 執行登入指令（將 `$SCRIPT_PATH` 替換為步驟一找到的實際路徑）：

**Windows：**
```powershell
python $SCRIPT_PATH login
```

**macOS / Linux：**
```bash
python3 $SCRIPT_PATH login
```

流程：
1. 瀏覽器自動開啟飛書授權頁面
2. 你點擊「授權」
3. 瀏覽器顯示「Authorization successful! You can close this page.」
4. 終端機顯示「UAT saved!」

> Token 每 2 小時過期，腳本自動用 refresh_token 續約。若 refresh_token 也過期（30 天），重新執行 `login` 即可。

### 步驟八：寫入 opencode.json 權限

請 OpenCode 編輯 `~/.config/opencode/opencode.json`，在 `permission.skill` 區塊中加入：

```json
"feishu-inout": "allow",
```

完成後大致像這樣：

```json
"skill": {
  "feishu-inout": "allow",
  "startup": "allow",
  "shutdown": "allow",
  "*": "ask"
}
```

### 步驟九：最終驗證

重啟 OpenCode，依序測試：

1. **檢查狀態**：`請檢查我的飛書連線狀態`
2. **搜尋文檔**：`搜尋飛書文檔：測試`
3. **列出群組**：`列出我的飛書群組`
4. **發送測試**：`發送一則測試訊息到某個群組`

### 步驟十：讀寫測試（驗證完整流程）

請 OpenCode 幫你執行以下完整循環測試，確認建立、讀取、覆蓋清空都正常運作：

#### 10.1 建立文檔
```bash
請在我的飛書建立一個叫「測試文檔」的文檔，內容寫「這是我的第一份飛書文檔」
```

#### 10.2 讀取文檔
```bash
請讀取這個飛書文檔的內容
```
確認內容顯示為「這是我的第一份飛書文檔」。

#### 10.3 覆蓋清空
```bash
請將這個文檔的內容覆蓋清空
```

#### 10.4 確認清空
```bash
請重新讀取這個文檔的內容並顯示
```
確認內容為空白（length: 0）。

#### 10.5 群組測試
```bash
請建立一個叫「測試群組」的群組
```
確認回傳 chat_id 且狀態為 success。

#### 10.6 將自己加入群組
```bash
請查詢我的飛書使用者資訊，然後將我加入測試群組
```
確認回傳 `invalid_id_list: []`（無無效 ID）。

#### 10.7 發送群組訊息
```bash
請發送訊息到測試群組：大家好，這是 OpenCode 的第一條自動訊息
```
確認回傳 message_id 且 status 為 success。

#### 10.8 讀取群組訊息
```bash
請讀取測試群組的最新訊息
```
確認剛才發送的訊息內容正確顯示。

#### 10.9 清理
測試完成後，可保留或手動刪除這些測試文檔與群組。

---

## 使用方式

### 觸發關鍵字

| 你要做什麼 | 對 OpenCode 說 |
|-----------|---------------|
| 瀏覽文檔 | 「列出我飛書上的文檔」 |
| 搜尋文檔 | 「搜尋飛書文檔：週報」 |
| 讀取文檔 | 「讀這個飛書文檔：https://xxx.feishu.cn/docx/xxx」 |
| 建立文檔 | 「在我的飛書建立一個『會議紀錄』文檔」 |
| 編輯文檔 | 「在文檔末尾追加一段結論」 |
| 發送訊息 | 「給 David 發個飛書訊息：下午開會」 |
| 閱讀訊息 | 「產品群今天討論了什麼？」 |
| 搜尋訊息 | 「搜尋飛書關於部署的訊息」 |
| 建立群組 | 「建立一個『專案討論』群組，加 David 和 Sarah」 |
| 日曆會議 | 「明天下午 2-3 點安排一個會議，邀請 David」 |
| 查看日程 | 「我今天有什麼會議？」 |
| 多維表格 | 「看看這個多維表格的紀錄」 |

### 跨電腦共用

同一組 App ID / App Secret 可在多台電腦使用：

| 電腦 | 設定步驟 |
|------|---------|
| **電腦 A（已設定）** | 已可正常使用 |
| **新電腦 B** | ① `npx skills add joe960913/feishu-inout` ② 設定同一組環境變數 ③ `python feishu_mcp.py login` ④ 完成 |

每台電腦只需個別執行一次 `login` 授權，之後自動續約。所有電腦操作的是同一個飛書工作區。

> ⚠️ **安全提醒**：App Secret 是敏感資訊，每台電腦都要**手動設定**，不要透過網路、聊天或 AI 傳輸。

---

## 解除安裝

```bash
# 從 opencode.json 移除 "feishu-inout": "allow"
# 移除 skill 目錄
rm -rf ~/.config/opencode/skills/feishu-inout
# 或（視安裝路徑）
rm -rf ~/.agents/skills/feishu-inout
```

---

## 常見問題

| 問題 | 解法 |
|------|------|
| search-doc 報錯「search:docs:read」 | 需 UAT（用戶身份），執行 `python feishu_mcp.py login` |
| fetch-doc 報錯「permission denied」 | TAT 模式下應用需被添加為文檔協作者；用 UAT 登入可解決 |
| login 後瀏覽器沒反應 | 檢查重定向 URL `http://localhost:9876/callback` 是否正確添加 |
| Token 過期 | 腳本自動續約。若 refresh_token 也過期（30天），重新 `login` |
| 群組管理指令失敗 | 確認 Bot 能力已開啟且應用已發布審核通過、Bot 已加入目標群組 |
| npx skills add 失敗 | 手動安裝：從 `https://github.com/joe960913/feishu-inout` 下載，將 `scripts/feishu_mcp.py` 放到本機 |
| Windows 找不到 python3 | Windows 用 `python` 或 `py`，不要用 `python3` |

---

## 完成回報格式

```md
✅ #19 飛書 Lark 已安裝完成！
- 來源：joe960913/feishu-inout
- 飛書應用：OpenCode 助手（App ID: cli_xxx）
- 權限範圍：完整（文檔+訊息+群組+日曆+多維表格）
- Bot 能力：已啟用（群組管理需發布審核通過）
- 腳本路徑：{實際路徑}/feishu_mcp.py
- 使用方式：說「幫我操作飛書文檔」「發送飛書訊息」
```

---

## 附錄：飛書 CLI 指令速查表

以下為 `feishu_mcp.py` 的完整指令列表，供進階使用者快速參考。

> $S = 實際安裝路徑（替換為步驟一找到的路徑）

### 認證
| 指令 | 說明 |
|------|------|
| `python $S login` | OAuth 瀏覽器登入授權 |
| `python $S whoami` | 查看目前 token 狀態 |

### 文檔操作
| 指令 | 說明 |
|------|------|
| `python $S fetch-doc <docID>` | 讀取文檔 |
| `python $S fetch-doc <docID> 0 5000` | 分頁讀取（offset, limit） |
| `python $S search-doc <關鍵字>` | 搜尋文檔 |
| `python $S list-docs` | 列出我的文檔庫 |
| `python $S create-doc <標題> '<內容>'` | 建立文檔 |
| `python $S append <docID> '<內容>'` | 追加內容 |
| `python $S overwrite <docID> '<內容>'` | 覆蓋整份文檔 |
| `python $S replace <docID> '<舊>' '<新>'` | 定位替換 |
| `python $S insert-after <docID> '<錨點>' '<內容>'` | 後插入 |
| `python $S insert-before <docID> '<錨點>' '<內容>'` | 前插入 |
| `python $S delete-range <docID> '<內容>'` | 刪除範圍 |

### 評論與檔案
| 指令 | 說明 |
|------|------|
| `python $S get-comments <docID>` | 取得評論 |
| `python $S add-comments <docID> '<文字>'` | 新增評論 |
| `python $S fetch-file <token>` | 下載圖片/附件 |

### 訊息與對話
| 指令 | 說明 |
|------|------|
| `python $S send-msg <chat_id> '<文字>'` | 發送群組訊息 |
| `python $S send-msg <open_id> '<文字>' --user` | 發送私聊訊息 |
| `python $S send-card <id> '<json>'` | 發送互動卡片 |
| `python $S reply <message_id> '<文字>'` | 回覆訊息 |
| `python $S reply <message_id> '<文字>' --thread` | 話題中回覆 |
| `python $S get-msgs <chat_id> today` | 讀取今日群聊紀錄 |
| `python $S get-msgs-user <open_id> today` | 讀取私聊紀錄 |
| `python $S search-msgs <關鍵字>` | 跨群搜尋訊息 |
| `python $S get-thread <thread_id>` | 取得話題回覆 |

### 群組管理
| 指令 | 說明 |
|------|------|
| `python $S create-group <名稱>` | 建立群組 |
| `python $S create-group <名稱> '["open_id1"]'` | 建立群組並加成員 |
| `python $S add-members <chat_id> '["id1","id2"]'` | 加入成員 |
| `python $S list-groups` | 列出群組 |

### 使用者
| 指令 | 說明 |
|------|------|
| `python $S get-user` | 查詢自己資訊 |
| `python $S get-user <open_id>` | 查詢指定使用者 |
| `python $S search-user <關鍵字>` | 搜尋使用者 |

### 日曆與會議
| 指令 | 說明 |
|------|------|
| `python $S list-events` | 查看今日日程 |
| `python $S create-event <標題> <開始> <結束>` | 建立日程（自動含視訊會議） |
| `python $S create-event <標題> <開始> <結束> '["open_id"]'` | 建立日程並邀請 |

### 多維表格
| 指令 | 說明 |
|------|------|
| `python $S list-tables <app_token>` | 列出表格 |
| `python $S list-records <app_token> <table_id>` | 列出紀錄 |
| `python $S create-record <app_token> <table_id> '<json>'` | 新增紀錄 |
| `python $S update-record <app_token> <table_id> <record_id> '<json>'` | 更新紀錄 |

## 更新紀錄

| 日期 | 版本 | 更新內容 |
|------|------|---------|
| 2026-06-23 | v0.1 | 初版 |
