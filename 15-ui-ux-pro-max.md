# OpenCode 懶人包 #15：UI/UX Pro Max 設計智能

> 版本：v0.1
> 更新日期：2026-06-21

---

## 這個懶人包會幫你做什麼？

讓 OpenCode 獲得專業級的 UI/UX 設計智能，包含 67 種 UI 風格、161 個設計推理規則、57 組字體搭配、99 條 UX 指南、25 種圖表類型，覆蓋 15+ 技術棧：

- 用官方安裝器一鍵安裝 UI/UX Pro Max 主技能 + 6 個子技能
- 設定 opencode.json 權限
- 直接在對話中獲得 AI 驅動的 UI/UX 設計建議與生成

安裝後你可以在 OpenCode 中輸入「設計一個玻璃擬態的登入頁面」或「用 neubrutalism 風格做儀表板」來啟用設計智能。

---

## 先備條件

- [ ] 已完成 **懶人包 #00：環境建置**（Node.js + OpenCode）
- [ ] 網路連線（首次安裝需要）

---

## 請 OpenCode 幫我執行以下步驟

### 步驟一：執行官方安裝器

```bash
npx uipr@latest --opencode
```

此指令會自動安裝到 `~/.config/opencode/skills/` 下：
- `ui-ux-pro-max/` — 主技能（設計智能核心）
- `ui-styling/` — UI 樣式（含 25 個 OFL 字體）
- `design/` — 設計生成（CIP 品牌識別、標誌、圖示）
- `design-system/` — 設計系統（令牌、投影片、元件）
- `brand/` — 品牌管理
- `banner-design/` — 橫幅設計
- `slides/` — 簡報製作

### 步驟二：設定 opencode.json 權限

編輯 `~/.config/opencode/opencode.json`，在 `permission.skill` 加入：

```json
"ui-ux-pro-max": "allow"
```

### 步驟三：驗證安裝

```bash
ls -la ~/.config/opencode/skills/ui-ux-pro-max/SKILL.md
```

預期看到 SKILL.md 存在。也可確認共 7 個相關技能目錄：

```bash
ls -d ~/.config/opencode/skills/ui-*/
```

### 步驟四：測試

在 OpenCode 中輸入以下任一句話測試：

```
幫我設計一個登入頁面，用 glassmorphism 風格
```

或

```
ui/ux pro max
```

---

## 提供的設計智能

| 領域 | 數量 | 說明 |
|------|------|------|
| UI 風格 | 67 種 | glassmorphism, neubrutalism, claymorphism 等 |
| 設計推理規則 | 161 條 | 排版、色彩、間距、響應式等決策規則 |
| 字體搭配 | 57 組 | Google Fonts 字體對（含 fallback） |
| 色板 | 161 組 | 依產品類型分類（SaaS, E-commerce, Fintech 等） |
| UX 指南 | 99 條 | 最佳實踐與反模式 |
| 圖表類型 | 25 種 | 附函式庫推薦（chart.js, recharts, d3 等） |
| 技術棧 | 15+ | React, Next.js, Vue, Svelte, Flutter, SwiftUI 等 |

---

## 使用方式

| 情境 | 在 OpenCode 中輸入 |
|------|-------------------|
| 觸發技能 | `ui/ux pro max` 或 `uipm` |
| 設計頁面 | `幫我設計一個登入頁面` |
| 指定風格 | `用 neubrutalism 風格做儀表板` |
| 深色模式 | `設計一個深色模式的設定頁面` |
| 字體建議 | `這個 SaaS 產品用什麼字體好？` |
| 配色方案 | `Fintech 產品推薦什麼色板？` |
| 圖表選擇 | `用來顯示季度營收的圖表推薦` |
| UX 審查 | `幫我 review 這個頁面的 UX` |
| 動畫效果 | `登入按鈕的過渡動畫怎麼做？` |
| 響應式 | `這個表格在小螢幕怎麼處理？` |

---

## 與 OMD/品牌設計整合

如果你也安裝了 #14 Awesome DESIGN.md 品牌設計技能，可以：

1. **下載品牌 DESIGN.md**（如 Stripe 的設計系統）
2. **讓 UI/UX Pro Max 按該品牌風格生成 UI**
3. 同時獲得品牌色彩/字體規範 + 設計智能建議

---

## 完成回報格式

```md
## UI/UX Pro Max 技能安裝完成

- npx uipr@latest --opencode：✅ 成功 / ❌ 失敗
- 主技能目錄：~/.config/opencode/skills/ui-ux-pro-max/ ✅
- 子技能：6 個全部安裝 / ⚠️ 部分安裝
- opencode.json 權限：✅ ui-ux-pro-max: allow
- 對話測試：✅ 成功 / ❌ 失敗
```

---

## 常見問題

| 問題 | 解法 |
|------|------|
| `npx uipr@latest` 找不到 | 確認 Node.js 18+ 已安裝，執行 `node --version` |
| 安裝後沒反應 | 確認 opencode.json 有加入 `"ui-ux-pro-max": "allow"` |
| 技能未載入 | 直接說「ui/ux pro max」強制觸發 |
| 想移除 | 刪除 `~/.config/opencode/skills/ui-ux-pro-max/` 目錄 |
| 更多資訊 | 官網 https://uupm.cc / GitHub: nextlevelbuilder/ui-ux-pro-max-skill |

---

## 解除安裝

### 移除 Skill

```bash
rm -rf ~/.config/opencode/skills/ui-ux-pro-max/
rm -rf ~/.config/opencode/skills/ui-styling/
rm -rf ~/.config/opencode/skills/design/
rm -rf ~/.config/opencode/skills/design-system/
rm -rf ~/.config/opencode/skills/brand/
rm -rf ~/.config/opencode/skills/banner-design/
rm -rf ~/.config/opencode/skills/slides/
```

### 移除 Permission

編輯 `~/.config/opencode/opencode.json`，從 `"permission"` 的 `"skill"` 區塊移除 `"ui-ux-pro-max": "allow"`。

---

## Trae 對應操作

> 若你使用 **Trae IDE**，以下為對應的安裝/更新/移除步驟。

### 在 Trae 上安裝

1. 執行官方安裝器以取得技能檔案：
   ```bash
   npx uipr@latest --opencode
   ```
2. 選擇安裝層級：
   - **全域（推薦，所有專案可用）**：`~/.agents/skills/ui-ux-pro-max/`
   - **專案（僅當前專案）**：`.trae/skills/ui-ux-pro-max/` 或 `.agents/skills/ui-ux-pro-max/`

   ```bash
   # 全域
   mkdir -p ~/.agents/skills/ui-ux-pro-max/
   cp -r ~/.config/opencode/skills/ui-ux-pro-max/* ~/.agents/skills/ui-ux-pro-max/
   # 或專案
   mkdir -p .trae/skills/ui-ux-pro-max/
   cp -r ~/.config/opencode/skills/ui-ux-pro-max/* .trae/skills/ui-ux-pro-max/
   ```
3. 重新載入 Trae（Cmd+R / Ctrl+R）
4. 對 Trae 說「幫我設計一個登入頁面」，確認可載入

### 在 Trae 上更新

重新執行 `npx uipr@latest --opencode`，再將更新的檔案複製到對應目錄：
- 全域：`~/.agents/skills/ui-ux-pro-max/`
- 專案：`.trae/skills/ui-ux-pro-max/` 或 `.agents/skills/ui-ux-pro-max/`

### 在 Trae 上移除

```bash
# 全域
rm -rf ~/.agents/skills/ui-ux-pro-max/
# 或專案
rm -rf .trae/skills/ui-ux-pro-max/
```

---

## 更新紀錄

| 日期 | 版本 | 更新內容 |
|------|------|---------|
| 2026-06-21 | v0.1 | 初版 |
