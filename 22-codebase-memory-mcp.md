# OpenCode 懶人包 #22：Codebase Memory MCP

> 版本：v0.1
> 更新日期：2026-06-23

---

## 這個懶人包會幫你做什麼？

安裝 [codebase-memory-mcp](https://github.com/DeusData/codebase-memory-mcp) — 程式碼知識圖譜引擎，讓 OpenCode 擁有：

- **158 種語言**的程式碼解析（tree-sitter AST）
- **Hybrid LSP** 型別解析（TS/JS/Python/Go/Rust/Java/Kotlin/C/C++/C#/PHP）
- **14 個 MCP 工具**：搜尋、呼叫鏈追蹤、架構分析、Cypher 查詢、死碼偵測等
- **快**：一般 repo 毫秒級索引，查詢 <1ms
- **全本機**：零 API Key、零網路需求、零依賴

---

## 先備條件

- [ ] 已完成 **懶人包 #00：環境建置**
- [ ] `curl` 已安裝

---

## 請 OpenCode 幫我執行以下步驟

### 步驟一：一鍵安裝

```bash
curl -fsSL https://raw.githubusercontent.com/DeusData/codebase-memory-mcp/main/install.sh | bash
```

安裝腳本會自動：
- 下載對應平台的最新二進位檔到 `~/.local/bin/`
- 自動偵測 OpenCode 並寫入 `opencode.json` 的 MCP 設定
- 自動寫入 `AGENTS.md` 指令

若需圖形化 UI（3D 知識圖譜瀏覽器）：

```bash
curl -fsSL https://raw.githubusercontent.com/DeusData/codebase-memory-mcp/main/install.sh | bash -s -- --ui
```

### 步驟二：驗證安裝

```bash
codebase-memory-mcp --version
```

確認顯示版本號。

### 步驟三：重啟 OpenCode

關閉並重新開啟 OpenCode，然後確認工具已載入：

```
請列出你現在有哪些 MCP 工具可以使用？
```

預期看到 `codebase-memory-mcp` 的 14 個工具。

### 步驟四：索引你的第一個專案

對 OpenCode 說：

```
幫我索引這個專案
```

或啟用自動索引，以後新專案會自動索引：

```bash
codebase-memory-mcp config set auto_index true
```

### 步驟五：開始使用 — 操作範例

索引完成後，試試以下查詢：

| 你想做的事 | 對 OpenCode 說 |
|-----------|---------------|
| 搜尋函式 | 「搜尋所有叫用 handleOrder 的地方」 |
| 找特定名稱 | 「找名字有 Handler 的函式」 |
| 語意搜尋 | 「跟支付相關的程式碼在哪？」 |
| 誰呼叫我 | 「誰呼叫了 processPayment？」 |
| 我呼叫誰 | 「processPayment 裡呼叫了哪些函式？」 |
| 架構總覽 | 「這個專案的架構長怎樣？」 |
| 影響分析 | 「我剛改了哪些檔案？會影響到誰？」 |
| 查死碼 | 「哪些函式沒人用？」 |

---

## 解除安裝

```bash
codebase-memory-mcp uninstall
```

會清除所有 agent 設定，但保留 cache 資料。若要完全清除：

```bash
codebase-memory-mcp uninstall
rm -rf ~/.cache/codebase-memory-mcp/
```

---

## 常見問題

| 問題 | 解法 |
|------|------|
| 支援哪些語言？ | 158 種語言（tree-sitter AST），Hybrid LSP 型別解析支援 11 種：TS/JS/Python/Go/Rust/Java/Kotlin/C/C++/C#/PHP |
| 需要 API Key 嗎？ | 不需要，全本機執行，零網路需求 |
| 索引速度？ | 一般 repo 毫秒級索引，查詢 <1ms |
| 如何更新？ | 重新執行安裝指令即可：`curl -fsSL https://raw.githubusercontent.com/DeusData/codebase-memory-mcp/main/install.sh \| bash` |
| 解除安裝後如何重裝？ | 同上，安裝腳本會自動覆蓋舊版 |
| cache 資料在哪？ | `~/.cache/codebase-memory-mcp/`，刪除後下次索引會重新建立 |
| 支援 OpenCode 以外的工具嗎？ | 支援 Claude Code、Codex CLI、Gemini CLI、Zed、Antigravity、Aider、KiloCode、VS Code、OpenClaw、Kiro |
| 3D 圖形化 UI 是什麼？ | 安裝時加上 `--ui` 參數即可啟動 3D 知識圖譜瀏覽器（Electron 視窗） |

---

## 更新紀錄

| 日期 | 版本 | 更新內容 |
|------|------|---------|
| 2026-06-26 | v0.1 | 初版 |

---

## 參考資料

- [GitHub Repo](https://github.com/DeusData/codebase-memory-mcp)
- [arXiv Paper](https://arxiv.org/abs/2603.27277)
- 支援的 AI agent：Claude Code、Codex CLI、Gemini CLI、Zed、**OpenCode**、Antigravity、Aider、KiloCode、VS Code、OpenClaw、Kiro
