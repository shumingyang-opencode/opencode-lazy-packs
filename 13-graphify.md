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

## 解除安裝

### 移除 Skill

```bash
rm -rf ~/.config/opencode/skills/graphify/
```

### 移除 Permission

編輯 `~/.config/opencode/opencode.json`，從 `"permission"` 的 `"skill"` 區塊移除 `"graphify": "allow"`。

### 移除 CLI 工具

```bash
uv tool uninstall graphifyy
```

---

## Trae 對應操作

> 若你使用 **Trae IDE**，以下為對應的安裝/更新/移除步驟。

### 在 Trae 上安裝

1. 選擇安裝層級：
   - **全域（推薦，所有專案可用）**：`~/.agents/skills/graphify/`
   - **專案（僅當前專案）**：`.trae/skills/graphify/` 或 `.agents/skills/graphify/`

   ```bash
   # 全域
   mkdir -p ~/.agents/skills/graphify/
   # 或專案
   mkdir -p .trae/skills/graphify/
   ```
2. 從本 repo 的 `skills/13-graphify/SKILL.md` 複製內容到對應目錄的 `SKILL.md`
3. 重新載入 Trae（Cmd+R / Ctrl+R）
4. 對 Trae 說「/graphify .」，確認可載入

> CLI 工具的安裝方式與 OpenCode 相同（npm/pipx/brew），無需額外步驟。

### 在 Trae 上更新

替換對應目錄中的 `SKILL.md` 內容即可：
- 全域：`~/.agents/skills/graphify/SKILL.md`
- 專案：`.trae/skills/graphify/SKILL.md` 或 `.agents/skills/graphify/SKILL.md`

### 在 Trae 上移除

```bash
# 全域
rm -rf ~/.agents/skills/graphify/
# 或專案
rm -rf .trae/skills/graphify/
```

---

## 更新紀錄

| 日期 | 版本 | 更新內容 |
|------|------|---------|
| 2026-06-21 | v0.1 | 初版 |
