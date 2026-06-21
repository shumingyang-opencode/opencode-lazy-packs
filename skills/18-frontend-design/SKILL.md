---
name: frontend-design
description: Anthropic 出品的 Frontend Design 技能 — 拒絕 AI 模板化美學，產生
              辨識度極高的前端設計。說「frontend design」「設計前端」「幫我設計頁面」
              「不要長得像 AI 做的」時載入。572K 安裝數、153K GitHub Stars。
---

# Frontend Design — 辨識度優先的前端設計技能

> 來源：Anthropic（anthropics/skills）
> 安裝數：572K | GitHub Stars：153K

拒絕 AI 模板化美學，透過有意的設計選擇產生辨識度極高的前端介面。

## 安裝步驟

### 前置需求

- [ ] 網路連線（首次安裝需要）

### 步驟一：執行官方安裝器

```bash
npx skills add https://github.com/anthropics/skills --skill frontend-design
```

此指令會安裝到 `~/.agents/skills/frontend-design/`。

### 步驟二：設定權限

在 `~/.config/opencode/opencode.json` 的 `permission.skill` 中加入：

```json
"frontend-design": "allow",
```

### 步驟三：驗證

啟動 OpenCode，輸入「幫我設計一個有辨識度的 landing page」，確認 frontend-design 被正確觸發。

## 使用方式

當你輸入以下關鍵字時自動觸發：
- 「設計前端」「幫我設計頁面」
- 「做一個 landing page」
- 「不要長得像 AI 做的」
- 「幫我設計一個有辨識度的 UI」
- 「frontend design」「design a page」

### 設計理念

1. **選定美學方向** — brutalist、maximalist、retro-futuristic、organic、luxury 等
2. **字體排版** — 刻意挑選 display + body 字型搭配
3. **色彩系統** — CSS variables 驅動的色票主題
4. **動態設計** — 有目的的 motion，非散亂動畫
5. **空間構成** — 留白與結構有意義

### 產出格式

- HTML/CSS/JS、React、Vue
- 生產級程式碼 + 完整的視覺系統

## 完成回報格式

```
✅ #18 frontend-design 已安裝完成！
- 來源：Anthropic（anthropics/skills）
- 安裝路徑：~/.agents/skills/frontend-design/
- 功能：辨識度優先的前端設計（拒絕 AI 模板化）
- 使用方式：說「幫我設計一個有辨識度的頁面」
```
