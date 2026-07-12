# OpenCode 懶人包 #28：安裝 CLI-Anything

> 版本：v0.1
> 更新日期：2026-07-06

---

## 這個懶人包會幫你做什麼？

安裝 **CLI-Hub Meta-Skill**，讓 OpenCode 能夠發現、安裝並使用 50+ 真實軟體的 Agent-native CLI harness。

### 什麼是 CLI-Anything？

> 出處：香港大學數據科學組（HKU Data Science Group）
> - GitHub：https://github.com/HKUDS/CLI-Anything
> - ⭐ 44.8K Stars | 845 Commits | Apache-2.0 License
> - CLI-Hub：https://clianything.cc
>
> 「Today's Software Serves Humans. Tomorrow's Users will be Agents.」
> CLI-Anything 讓 AI agent 透過命令列操作各種真實軟體——從 Blender 3D 建模、GIMP 圖片編輯，到 Obsidian 筆記管理、Kdenlive 影片剪輯，全部都能透過統一的 CLI harness 存取。

### 架構說明

```
使用者/OpenCode
    │
    ▼ 觸發 skill
cli-hub-meta-skill（元技能：發現與安裝框架）
    │
    ▼ cli-hub search / install
cli-anything-hub（pip 套件管理器）
    │
    ├── cli-anything-blender   → Blender 3D 建模
    ├── cli-anything-gimp      → GIMP 圖片編輯
    ├── cli-anything-obsidian  → Obsidian 筆記管理
    ├── cli-anything-kdenlive  → Kdenlive 影片剪輯
    ├── cli-anything-audacity  → Audacity 音訊處理
    ├── ... 50+ 更多 harness
```

**運作原理**：`cli-hub` 是輕量殼層，背後每個 harness 都是獨立的 pip 套件（`cli-anything-<name>`）。安裝時只裝 hub，需要特定工具時才按需安裝對應 harness。

---

## 先備條件

- [ ] 已完成 **懶人包 #00：環境建置**（OpenCode 已安裝）
- [ ] `pipx` 已安裝（可執行 `pipx --version` 確認）

---

## 請 OpenCode 幫我執行以下步驟

### 步驟一：安裝 CLI-Hub

```bash
pipx install cli-anything-hub
```

驗證安裝：

```bash
cli-hub --version
# 預期輸出：顯示版本號（如 0.4.0）
```

### 步驟二：探索可用 CLI

安裝完成後，你可以透過以下指令探索 CLI-Hub 上的所有工具：

```bash
# 瀏覽所有可用 CLI（依分類排列）
cli-hub list

# 依關鍵字搜尋
cli-hub search blender
cli-hub search image
cli-hub search "video editing"
cli-hub search "note taking"

# 查看特定 CLI 的詳細資訊
cli-hub info blender
cli-hub info gimp
cli-hub info obsidian
```

分類涵蓋範圍：

| 分類 | 代表工具 |
|------|---------|
| 3D 建模 | Blender、FreeCAD、3MF |
| 影像處理 | GIMP、Krita、Inkscape |
| 影片剪輯 | Kdenlive、Shotcut、Openscreen、VideoCaptioner |
| 音訊處理 | Audacity、MuseScore |
| 筆記管理 | Obsidian、Joplin、SiYuan |
| 辦公室 | LibreOffice |
| AI 平台 | Ollama、ComfyUI、Novita、MiniMax |
| 瀏覽器自動化 | Browser（CLIBrowser）、Safari |
| 開發工具 | n8n、Dify Workflow、WireMock、PM2 |
| 繪圖與設計 | Draw.io、Mermaid、EEZ Studio、Sketch |
| 遊戲開發 | Godot、RenderDoc、Slay the Spire II |
| 通訊協作 | Zoom、Mailchimp |
| 其他 | Calibre（電子書）、Rekordbox（DJ）、iTerm2 等 |

### 步驟三：安裝與使用特定 CLI

當你有一個具體任務時，OpenCode 會自動觸發 cli-hub-meta-skill 來完成。你也可以手動操作：

```bash
# 安裝工具
cli-hub install gimp
cli-hub install blender
cli-hub install kdenlive

# 使用工具（REPL 模式）
cli-anything-gimp

# 使用工具（單次指令 + JSON 輸出）
cli-anything-blender --json project create --name my-project

# 更新特定工具
cli-hub update gimp

# 解除安裝
cli-hub uninstall krita
```

**指令範例一覽：**

| 操作 | 指令 | 說明 |
|------|------|------|
| 瀏覽全部 | `cli-hub list` | 依分類列出所有可用 CLI |
| 搜尋工具 | `cli-hub search <keyword>` | 依關鍵字搜尋 |
| 查看資訊 | `cli-hub info <name>` | 顯示工具詳細資訊 |
| 安裝工具 | `cli-hub install <name>` | 安裝特定 CLI harness |
| 更新工具 | `cli-hub update <name>` | 更新到最新版 |
| 解除安裝 | `cli-hub uninstall <name>` | 移除特定 CLI |
| 啟動 REPL | `cli-anything-<name>` | 進入互動式命令列 |
| JSON 輸出 | `cli-anything-<name> --json <command>` | 機器可讀輸出 |
| 快速使用 | `cli-hub launch <name> [args]` | 啟動已安裝的 CLI |

### 步驟四：進階 — Matrix 工作流

CLI-Hub 支援 **Matrix**（多工具協作工作流），適合跨工具任務：

```bash
# 瀏覽所有 Matrix
cli-hub matrix list

# 搜尋能力（跨 Matrix）
cli-hub can "transcribe audio"

# 檢查環境準備狀態
cli-hub matrix preflight video-creation --json

# 安裝特定能力（避免一次裝太多）
cli-hub matrix install video-creation --capability text.transcribe
```

### 步驟五：CLI-Anything 作為 Harness 產生器

CLI-Anything 不僅能安裝現有工具，還能為**任何 GUI 軟體產生全新的 CLI harness**。

當你對 OpenCode 說「/cli-anything 幫我為 xxx 產生 CLI harness」，OpenCode 會執行 7 階段流程：

1. **源碼分析** — 分析目標軟體的程式碼結構
2. **架構設計** — 設計命令群組與狀態模型
3. **實作** — 用 Click 框架建立 CLI
4. **測試規劃** — 單元測試 + E2E 測試
5. **測試實作** — 完整測試覆蓋
6. **文件化** — TEST.md + README.md
7. **發布** — PyPI 套件打包（`cli-anything-<name>`）

> ⚠️ 需要提供目標軟體的源碼路徑或 GitHub URL

---

## 完成回報格式

```md
✅ CLI-Anything 已安裝完成！
- 套件版本：<cli-hub --version 輸出>
- 可用工具數量：<cli-hub list 統計數量>
- 元技能路徑：~/.config/opencode/skills/cli-hub-meta-skill/
- 使用方式：說「幫我找 xxx 工具」「用 Blender 建模」「搜尋影片編輯工具」
- 進階指令：/cli-anything 可產生新的 CLI harness
```

---

## 常見問題

| 問題 | 解法 |
|------|------|
| `cli-hub install` 失敗 | 確認網路連線，或改用 `pip install cli-anything-<name>` 直接安裝 |
| 找不到特定軟體的 CLI | 執行 `cli-hub search <keyword>`，或到 CLI-Hub 網頁瀏覽完整清單 |
| 如何貢獻新的 CLI Harness？ | 見官方 CONTRIBUTING.md，提交 PR 到 HKUDS/CLI-Anything |
| 安裝的 CLI 無法啟動 | 確認上游軟體已安裝（如 Blender、GIMP），某些 harness 需要實體軟體 |
| 需要 Token 或 API Key 嗎？ | 不需要。CLI-Anything 是本地工具框架，不需外部認證 |

---

## 解除安裝

### 移除 CLI-Hub

```bash
pipx uninstall cli-anything-hub
```

### 移除元技能

```bash
rm -rf ~/.config/opencode/skills/cli-hub-meta-skill/
```

---

## Trae 對應操作

> 若你使用 **Trae IDE**，以下為對應的安裝/更新/移除步驟。

### 在 Trae 上安裝

CLI-Hub 安裝方式與 OpenCode 相同：
```bash
pipx install cli-anything-hub
```

### 在 Trae 上更新

```bash
pipx upgrade cli-anything-hub
```

### 在 Trae 上移除

```bash
pipx uninstall cli-anything-hub
```

> 本懶人包的核心是 CLI-Hub 工具，元技能的安裝方式 Trae 與 OpenCode 一致。

---

## 更新紀錄

| 日期 | 版本 | 更新內容 |
|------|------|---------|
| 2026-07-06 | v0.1 | 初版 |
