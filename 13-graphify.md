# OpenCode 懶人包 #13：Graphify 知識圖譜技能

> 版本：v0.1
> 更新日期：2026-06-21

---

## 這個懶人包會幫你做什麼？

讓 OpenCode 可以將專案轉為知識圖譜 — 安裝 Graphify（AI coding assistant skill）：

- 安裝 graphifyy 套件（`uv tool install`）
- 註冊全域 OpenCode 技能（`graphify install --platform opencode`）
- 設定專案層級整合（AGENTS.md + OpenCode plugin）
- 設定 opencode.json 權限
- 建立第一個知識圖譜
- 完成後在任何專案輸入 `/graphify .` 就能產出圖譜

---

## 先備條件

- [ ] 已完成 **懶人包 #00：環境建置**
- [ ] Python 3.10+ 已安裝
- [ ] uv 已安裝

---

## 請 OpenCode 幫我執行以下步驟

### 步驟一：安裝 graphifyy 套件

```bash
uv tool install graphifyy
```

確認版本：
```bash
graphify --version
```

### 步驟二：註冊全域 OpenCode 技能

```bash
graphify install --platform opencode
```

這會建立以下檔案：
- `~/.config/opencode/skills/graphify/SKILL.md`
- `~/.config/opencode/skills/graphify/references/`（含 extraction-spec、query、hooks 等說明文件）

### 步驟三：註冊專案層級整合

在專案目錄下執行：

```bash
graphify install --project --platform opencode
```

這會建立以下檔案：
- `AGENTS.md`（含 graphify 章節，告訴 OpenCode 優先查圖譜）
- `.opencode/plugins/graphify.js`（每次 Bash 前提示用 query 取代 grep）
- `.opencode/opencode.json`（註冊 plugin）

### 步驟四：設定 opencode.json 權限

確認 `~/.config/opencode/opencode.json` 有 `"graphify": "allow"`（graphify 安裝時可能已自動設定，檢查即可）

### 步驟五：驗證安裝

```bash
graphify --help
ls ~/.config/opencode/skills/graphify/SKILL.md
ls .opencode/plugins/graphify.js
```

### 步驟六：建立知識圖譜

在專案目錄執行：

```bash
graphify extract .
```

或直接在 OpenCode 中輸入：
```
/graphify .
```

產出檔案：
```
graphify-out/
├── graph.html       瀏覽器打開即可互動
├── GRAPH_REPORT.md  架構重點摘要
└── graph.json       完整圖譜資料
```

---

## 使用方式

安裝後在 OpenCode 中輸入：

| 指令 | 用途 |
|------|------|
| `/graphify .` | 建立/更新整個專案的知識圖譜 |
| `/graphify query "認證流程是怎樣的？"` | 用自然語言查詢圖譜 |
| `/graphify path "UserService" "DatabasePool"` | 查詢兩個節點間的關聯路徑 |
| `/graphify explain "RateLimiter"` | 解釋特定概念的上下文 |
| `/graphify ./docs --update` | 只重新提取有變更的檔案 |

---

## 選用擴充套件

| 功能 | 指令 |
|------|------|
| PDF 提取 | `uv tool install "graphifyy[pdf]"` |
| Word/Excel 支援 | `uv tool install "graphifyy[office]"` |
| 影片逐字稿 | `uv tool install "graphifyy[video]"` |
| MCP server | `uv tool install "graphifyy[mcp]"` |
| SQL schema | `uv tool install "graphifyy[sql]"` |
| 全功能 | `uv tool install "graphifyy[all]"` |

---

## 完成回報格式

```md
## Graphify 技能安裝完成

- graphifyy：v<版本> ✅
- 全域 OpenCode 技能：✅ / ⚠️ 待補
- 專案層級整合：✅ AGENTS.md + plugin
- opencode.json 權限：✅ graphify: allow
- 知識圖譜建立：✅ 成功 / ⚠️ 略過
```

---

## 常見問題

| 問題 | 解法 |
|------|------|
| `graphify` 指令找不到 | 重新登入 shell，或確認 `~/.local/bin` 在 PATH 中。`uv tool install` 會自動處理 PATH |
| `ModuleNotFoundError: No module named 'graphify'` | 用 `uv tool install` 或 `pipx install` 取代 `pip install`，避免 Python 環境衝突 |
| 技能版本 mismatch 警告 | `uv tool upgrade graphifyy` 再 `graphify install` 更新 skill 檔 |
| 只想移除 OpenCode 整合 | `graphify opencode uninstall` |

---

## 更新紀錄

| 日期 | 版本 | 更新內容 |
|------|------|---------|
| 2026-06-21 | v0.1 | 初版 |
