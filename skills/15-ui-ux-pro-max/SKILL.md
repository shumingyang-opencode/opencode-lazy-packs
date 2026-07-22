---
name: ui-ux-pro-max
description: UI/UX Pro Max 設計智能技能 — 67 種 UI 風格、161 個設計推理規則、57 組字體搭配、
             99 條 UX 指南、25 種圖表類型，覆蓋 15+ 技術棧。說「ui/ux pro max」「設計一下」
             「幫我設計 UI」「套用某風格」「uipm」時載入。
---

# UI/UX Pro Max 設計智能技能

> AI-powered design intelligence with 67 UI styles, 161 color palettes,
> 57 font pairings, 99 UX guidelines, and 25 chart types across 15+ tech stacks.

## 使用方式

當用戶提出 UI/UX 設計需求時（例如「幫我設計一個登入頁面」「用 neubrutalism 風格做儀表板」），
自動載入並使用此技能提供的設計智能來產生高品質的 UI 設計。

## 安裝步驟

### 前置需求

- [ ] Node.js 18+ 已安裝
- [ ] npm / npx 可用

### 步驟一：執行安裝

```bash
npx uipr@latest --opencode
```

此指令會自動：
1. 安裝主技能至 `~/.agents/skills/ui-ux-pro-max/`
2. 安裝 6 個子技能（ui-styling, design, design-system, brand, banner-design, slides）
3. 每個子技能包含 SKILL.md + 參考資料 + 腳本

### 步驟二：設定 opencode.json 權限

編輯 `~/.config/opencode/opencode.json`，在 `permission.skill` 加入：

```json
"ui-ux-pro-max": "allow"
```

### 步驟三：驗證安裝

```bash
ls -la ~/.agents/skills/ui-ux-pro-max/SKILL.md
ls ~/.agents/skills/  # 應看到 7 個 ui-ux-pro-max 相關目錄
```

### 步驟四：測試

在對話中輸入以下任一觸發詞測試技能是否成功載入：

- 「ui/ux pro max」
- 「幫我設計一個登入頁面，用 glassmorphism 風格」
- 「套用 neubrutalism 風格做儀表板」
- 「設計一個深色模式的設定頁面」

## 技能提供的功能

### 設計智能資料庫

| 領域 | 內容 |
|------|------|
| UI 風格 | 67 種風格（glassmorphism, neubrutalism, claymorphism 等） |
| 設計推理 | 161 個規則（排版、色彩、間距、響應式等） |
| 字體搭配 | 57 組 Google Fonts 字體對 |
| 色板 | 161 組色板（依產品類型分類） |
| UX 指南 | 99 條最佳實踐與反模式 |
| 圖表 | 25 種圖表類型 + 函式庫推薦 |
| 技術棧 | 15+ 棧（React, Next.js, Vue, Svelte, Flutter 等） |

### 6 個子技能

| 子技能 | 說明 |
|--------|------|
| `ui-styling` | 進階 UI 樣式（含 25 個 OFL 字體檔 + shadcn/Tailwind 參考） |
| `design` | 設計生成（CIP 品牌識別、標誌設計、圖示設計） |
| `design-system` | 設計系統（設計令牌、簡報投影片、元件規格） |
| `brand` | 品牌管理（品牌指南、色板管理、資產驗證） |
| `banner-design` | 橫幅設計（尺寸與風格參考） |
| `slides` | 簡報製作（文案公式、佈局模式、HTML 模板） |

## 完成回報格式

```md
## UI/UX Pro Max 技能安裝完成

- npx uipr@latest --opencode：✅ 成功 / ❌ 失敗
- 主技能目錄：~/.agents/skills/ui-ux-pro-max/ ✅
- 子技能：6 個全部安裝 / ⚠️ 部分安裝
- opencode.json 權限：✅ ui-ux-pro-max: allow
- 驗證測試：✅ 成功 / ❌ 失敗
```

## 參考資源

- 官網：https://uupm.cc
- GitHub：https://github.com/nextlevelbuilder/ui-ux-pro-max-skill
- 授權：MIT
