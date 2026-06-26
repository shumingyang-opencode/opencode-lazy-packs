---
name: opencode-codebase-memory-mcp
description: 安裝 Codebase Memory MCP — 程式碼知識圖譜引擎。
             支援 158 語言、Hybrid LSP 型別解析（11 語言）、14 個 MCP 工具（search_graph/trace_path/get_architecture/Cypher）。
             單一靜態二進位、零依賴、全本機執行、無需 API Key。
             說「安裝 CBM」「安裝 codebase-memory-mcp」「程式碼知識圖譜MCP」「安裝記憶MCP」
             「記憶MCP」「knowledge graph MCP」「codebase memory」時載入。
---

# 安裝 Codebase Memory MCP（OpenCode 版）

讓 OpenCode 擁有程式碼知識圖譜引擎 — 索引後可用自然語言搜尋函式、
追蹤呼叫鏈、分析架構、查詢死碼，所有處理都在本機完成。

## 前置條件

- [ ] OpenCode 已安裝
- [ ] `curl` 已安裝（`curl --version` 確認）

## 步驟

### 1. 一鍵安裝

```bash
curl -fsSL https://raw.githubusercontent.com/DeusData/codebase-memory-mcp/main/install.sh | bash
```

安裝腳本會自動：
- 下載對應平台的最新二進位檔
- 放置到 `~/.local/bin/`
- 自動偵測 OpenCode 並寫入 `opencode.json` 的 MCP 設定
- 自動寫入 `AGENTS.md` 指令

若需圖形化 UI 版本（3D 知識圖譜瀏覽器）：

```bash
curl -fsSL https://raw.githubusercontent.com/DeusData/codebase-memory-mcp/main/install.sh | bash -s -- --ui
```

### 2. 驗證安裝

```bash
codebase-memory-mcp --version
```

確認顯示版本號。

### 3. 重啟 OpenCode

請使用者重啟 OpenCode，然後驗證工具是否載入：

```text
請列出你現在有哪些 MCP 工具可以使用？
```

確認出現 `codebase-memory-mcp` 的 14 個工具（search_graph、trace_path、get_architecture 等）。

### 4. 索引你的第一個專案

進入一個專案目錄，對 OpenCode 說：

```
幫我索引這個專案
```

或直接啟用自動索引：

```bash
codebase-memory-mcp config set auto_index true
```

## 安裝完成 — 輸出使用教學給使用者

**所有步驟完成後，請將以下操作速查表直接輸出給使用者（不要只說「完成了」，要印出完整教學）：**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  ✅ codebase-memory-mcp 已安裝完成！
  14 個 MCP 工具 | 支援 158 語言 | Hybrid LSP 型別解析 | 全本機執行
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

【第一步：索引專案】

  進入專案目錄，對 OpenCode 說：
  「幫我索引這個專案」
  or
  「Index this project」

  或啟用自動索引（不必手動觸發）：
  codebase-memory-mcp config set auto_index true

  之前索引過的專案會自動同步變更。

【搜尋程式碼】

  ├─ 搜尋函式：「搜尋所有叫用 handleOrder 的地方」
  ├─ 正規表達式：「找名字有 Handler 的函式」
  ├─ 語意搜尋：「跟支付相關的程式碼在哪？」
  └─ 全文搜尋：「幫我找 PaymentService 這個類別」

【追蹤呼叫鏈】

  ├─ 誰叫我：「誰呼叫了 processPayment？」
  ├─ 我呼叫誰：「processPayment 裡呼叫了哪些函式？」
  └─ 雙向追蹤：「幫我追蹤 validateOrder 的完整呼叫鏈」

【架構分析】

  ├─ 總覽：「這個專案的架構長怎樣？」
  ├─ 影響分析：「我剛改了哪些檔案？會影響到誰？」
  └─ 查死碼：「哪些函式沒人用？」

【Cypher 查詢（進階）】

  ├─ MATCH (f:Function)-[:CALLS]->(g) WHERE f.name='main' RETURN g.name
  ├─ MATCH (c:Class)-[:DEFINES]->(m:Method) RETURN c.name, m.name
  └─ 查死碼：MATCH (f:Function) WHERE NOT EXISTS { (f)<-[:CALLS]-() } RETURN f.name

【Visual Graph（UI 版本）】

  如果你安裝的是 --ui 版本：
  codebase-memory-mcp --ui=true --port=9749
  然後打開 http://localhost:9749

【常用指令】

  ├─ 列出已索引專案：codebase-memory-mcp cli list_projects
  ├─ CLI 搜尋：      codebase-memory-mcp cli search_graph '{"label":"Function"}'
  ├─ 檢查設定：      codebase-memory-mcp config list
  └─ 更新版本：      codebase-memory-mcp update

【解除安裝】

  codebase-memory-mcp uninstall
  （清除所有 agent 設定，保留 cache 資料）
```

## 解除安裝

```bash
codebase-memory-mcp uninstall
```

這會從 `opencode.json` 和 `AGENTS.md` 移除所有相關設定。cache 資料保留在 `~/.cache/codebase-memory-mcp/`。

若要完全清除（含 cache）：

```bash
codebase-memory-mcp uninstall
rm -rf ~/.cache/codebase-memory-mcp/
```

## 常見問題

| 問題 | 解法 |
|------|------|
| `/mcp` 沒看到伺服器 | 檢查 `opencode.json` 的 command 路徑是否正確。重啟 OpenCode。 |
| `codebase-memory-mcp` 找不到 | 確認 `~/.local/bin` 在 PATH 中 |
| 索引失敗 | 給絕對路徑：對 OpenCode 說 "index_repository(repo_path='/絕對/路徑')" |
| trace_path 回傳 0 筆 | 先用 search_graph 確認函式名稱完全正確 |
| 查詢結果不對 | 用 list_projects 確認專案名稱，查詢時加上 project="name" |

## 完成回報格式

```
✅ #22 Codebase Memory MCP 已安裝完成！
- 安裝方式：curl 一鍵安裝
- 二進位路徑：~/.local/bin/codebase-memory-mcp
- MCP 工具數量：14 個
- 支援語言：158 種（含 Hybrid LSP：TS/JS/Python/Go/Rust/Java/Kotlin/C/C++/C#/PHP）
- 零依賴、全本機、無 API Key
- 使用方式：對 OpenCode 說「幫我索引這個專案」
```
