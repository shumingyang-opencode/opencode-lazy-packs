---
name: opencode-feishu-lark
description: 安裝飛書 Lark 整合 — 讓 OpenCode 讀寫飛書文檔、發送訊息、管理群組、操作日曆與多維表格。說「安裝飛書」「安裝 Lark」「連接飛書」時載入。
---

# 安裝飛書 Lark（OpenCode 版）

讓 OpenCode 透過 `feishu-inout` skill 操作飛書文檔、訊息、群組、日曆與多維表格。

## 前置條件

- [ ] OpenCode 已安裝
- [ ] `open-computer-use` 已安裝（用於瀏覽器操作飛書開放平台）
- [ ] 網路連線
- [ ] 飛書帳號（可用 Google 帳號 `shumingyang-opencode@gmail.com`）

## 步驟

### 1. 安裝 feishu-inout skill

```bash
npx skills add joe960913/feishu-inout
```

安裝後找到腳本實際路徑（依平台不同）：

```bash
# 檢查常見安裝路徑（依序）
if (Test-Path "$env:USERPROFILE\.config\opencode\skills\feishu-inout\scripts\feishu_mcp.py") {
  Write-Output "路徑 A"
} elseif (Test-Path "$env:USERPROFILE\.agents\skills\feishu-inout\scripts\feishu_mcp.py") {
  Write-Output "路徑 B"
} else {
  Write-Output "未找到，嘗試全域搜尋"
  Get-ChildItem -Path $env:USERPROFILE -Filter "feishu_mcp.py" -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1 -ExpandProperty FullName
}
```

> **路徑陷阱**：feishu-inout 的 SKILL.md 預設寫 `~/.claude/skills/`（Claude Code 路徑），但 OpenCode 會裝在 `~/.config/opencode/skills/` 或 `~/.agents/skills/`。務必用以上指令找到實際路徑。

### 2. 透過瀏覽器建立飛書應用

使用 open-computer-use 開啟瀏覽器至飛書開放平台，引導使用者建立自建應用。

操作流程：
1. 開啟瀏覽器至 `https://open.feishu.cn/app`
2. 使用者手動登入（帳號：`shumingyang-opencode@gmail.com`）
3. 點擊「建立自建應用」
4. 輸入應用名稱（如「OpenCode 助手」）、描述
5. 建立完成後，至 **Credentials & Basic Info** 頁面
6. 記錄 **App ID**（格式：`cli_xxxxxxxxxxxxxxxx`）與 **App Secret**

### 3. 批量匯入完整權限

至應用 → **權限管理** → **批量導入/導出權限**，貼入以下完整權限字串：

```
docx:document:readonly,search:docs:read,wiki:wiki:readonly,im:chat:read,task:task:read,docx:document,docx:document:create,docx:document:write_only,docs:document.media:upload,docs:document.media:download,wiki:node:read,wiki:node:create,docs:document.comment:read,docs:document.comment:create,contact:user:search,contact:contact.base:readonly,contact:user.base:readonly,board:whiteboard:node:read,drive:drive,im:message,im:message:send_as_bot,im:chat,search:message,im:message.send_as_user,im:message.p2p_msg:get_as_user,im:message.group_msg:get_as_user,calendar:calendar:readonly,calendar:calendar,bitable:app:readonly,bitable:app,im:chat:create
```

確認所有權限顯示 ✅ **已啟用**。

### 4. 設定重定向 URL

至應用 → **安全設置** → **重定向 URL** → 添加：

```
http://localhost:9876/callback
```

### 5. 啟用機器人能力

至應用 → **添加能力** → 開啟 **機器人** 開關。

> **關於 Bot 的說明**：
> - **發送/閱讀訊息**（send-msg, get-msgs）：使用 UAT（用戶身份），**不需** Bot 能力
> - **群組管理**（create-group, add-members, list-groups）：使用 TAT（應用身份），**需要** Bot 能力 + 應用發布審核通過
> - 單純文檔讀寫 + 訊息收發：步驟 5 可跳過

### 6. 設定環境變數

請使用者自行設定（**勿將 App Secret 傳給 AI**）：

```powershell
[System.Environment]::SetEnvironmentVariable('FEISHU_APP_ID', '貼上你的AppID', 'User')
[System.Environment]::SetEnvironmentVariable('FEISHU_APP_SECRET', '貼上你的AppSecret', 'User')
```

驗證（只驗證 App ID，不輸出 Secret）：
```powershell
Write-Output "FEISHU_APP_ID = $env:FEISHU_APP_ID"
```

### 7. OAuth 登入授權

執行登入指令（找到步驟 1 的實際腳本路徑，替換 `$SCRIPT_PATH`）：

```powershell
python $SCRIPT_PATH login
```

流程：
1. 瀏覽器開啟飛書授權頁面
2. 使用者點擊「授權」
3. 瀏覽器顯示「Authorization successful!」
4. 終端機顯示「UAT saved!」

### 8. 寫入 opencode.json 權限

編輯 `~/.config/opencode/opencode.json`，在 `permission.skill` 中加入：

```json
"feishu-inout": "allow",
```

完成後類似：

```json
"skill": {
  "feishu-inout": "allow",
  "startup": "allow",
  "shutdown": "allow",
  "*": "ask"
}
```

### 9. 最終驗證

重啟 OpenCode，依序測試：

1. **檢查認證狀態**：`請檢查我的飛書連線狀態`
2. **搜尋文檔**：`搜尋飛書文檔：測試`
3. **列出群組**：`列出我的飛書群組`
4. **發送測試訊息**：`發送一條測試訊息到我的某個群組`

## 多電腦同步設定

這組 App ID / App Secret 可以跨電腦使用：

| 電腦 | 設定步驟 |
|------|---------|
| **電腦 A（已設定）** | 已可使用 |
| **電腦 B（新電腦）** | ① `npx skills add joe960913/feishu-inout` ② 設同一組環境變數 ③ `python feishu_mcp.py login` ④ 完成 |

每台電腦只需各自授權一次（UAT token 30 天內自動續約），即可操作同一個飛書工作區。

> ⚠️ `FEISHU_APP_SECRET` 是敏感憑證，每台電腦都要手動設定，**不要透過網路傳輸**。

## 使用方式

安裝後對 OpenCode 說以下關鍵字即可觸發：

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

## 解除安裝

```bash
# 從 opencode.json 移除 feishu-inout 權限
# 移除 skill
rm -rf ~/.config/opencode/skills/feishu-inout
# 或（視安裝路徑而定）
rm -rf ~/.agents/skills/feishu-inout
```

## 常見問題

| 問題 | 解法 |
|------|------|
| search-doc 報錯「search:docs:read」 | 該權限需 UAT（用戶身份），執行 `login` 重新授權 |
| fetch-doc 報錯「permission denied」 | TAT 模式下應用需被加為文檔協作者；用 UAT 登入後可解決 |
| login 後瀏覽器沒反應 | 檢查重定向 URL `http://localhost:9876/callback` 是否已添加 |
| Token 過期 | 腳本自動用 refresh_token 續約。若 refresh_token 也過期（30天），重新執行 `login` |
| 群組管理指令失敗 | 確認 Bot 能力已開啟且應用已發布審核通過 |
| npx skills add 無法使用 | 手動下載：從 GitHub 下載 feishu-inout 專案，將 `scripts/feishu_mcp.py` 放到本機 |

## 完成回報格式

```
✅ #19 飛書 Lark 已安裝完成！
- 來源：joe960913/feishu-inout
- 飛書應用：OpenCode 助手（App ID: cli_xxx）
- 權限：完整（文件+訊息+群組+日曆+多維表格）
- Bot 能力：已啟用（如需群組管理需發布審核）
- 腳本路徑：{實際安裝路徑}/feishu_mcp.py
- 使用方式：說「幫我操作飛書文檔」「發送飛書訊息」
```
