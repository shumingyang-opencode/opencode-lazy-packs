# OpenCode 懶人包 #18：Frontend Design — 辨識度優先的前端設計

> 版本：v0.1
> 更新日期：2026-06-21

---

## 這個懶人包會幫你做什麼？

讓 OpenCode 獲得 Anthropic 官方出品的 Frontend Design 設計智能，拒絕 AI 模板化美學：

- 572K 安裝數、153K GitHub Stars 的頂級設計技能
- 從 brutalist、maximalist、retro-futuristic、organic 等風格中選定美學方向
- 刻意挑選字體搭配、色彩系統、動態設計與空間構成
- 產生生產級 HTML/CSS/JS、React、Vue 程式碼
- 每個設計都有一個讓人記住的 signature 元素

安裝後你可以在 OpenCode 中輸入「幫我設計一個有辨識度的 landing page」或「不要長得像 AI 做的儀表板」來啟用。

---

## 先備條件

- [ ] 網路連線（首次安裝需要）

---

## 請 OpenCode 幫我執行以下步驟

### 步驟一：執行官方安裝器

```bash
npx skills add https://github.com/anthropics/skills --skill frontend-design
```

此指令會自動安裝到 `~/.agents/skills/frontend-design/`。

### 步驟二：設定 opencode.json 權限

編輯 `~/.config/opencode/opencode.json`，在 `permission.skill` 中加入：

```json
"frontend-design": "allow",
```

完成後權限區塊看起來像這樣：

```json
"skill": {
  "frontend-design": "allow",
  "find-skills": "allow",
  // ... 其他技能
  "*": "ask"
}
```

### 步驟三：驗證

啟動 OpenCode（若已在執行中請重啟），輸入：

> 幫我設計一個有辨識度的 landing page

確認 frontend-design 被正確觸發並開始設計流程（先討論美學方向 → 建立設計計畫 → 再寫程式碼）。

---

## 使用方式

### 觸發關鍵字

| 中文 | English |
|------|---------|
| 幫我設計前端 | design a frontend |
| 設計一個頁面 | design a page |
| 不要長得像 AI 做的 | don't make it look AI-generated |
| 做一個 landing page | build a landing page |
| 設計一個有辨識度的 UI | design a distinctive UI |

### 設計流程

1. **理解需求** — 確定 purpose、audience、tone、constraints
2. **選定美學方向** — brutalist / maximalist / retro-futuristic / organic / luxury 等
3. **建立設計計畫** — 色票（4-6 hex）、字體（display + body + utility）、佈局、signature
4. **自我審查** — 檢查是否落入 AI 模板陷阱，修正後才開始寫 code
5. **實作** — 生產級程式碼，含 responsive、keyboard focus、reduced motion

### 會避開的 AI 模板

- ❌ 暖米色背景（#F4F1EA）+ 高對比襯線字 + 陶土色 accent
- ❌ 近乎黑色背景 + 螢光綠／朱紅 accent
- ❌ 報紙排版 + 零 border-radius + 密集欄位

---

## 解除安裝

```bash
rm -rf ~/.agents/skills/frontend-design
```

並從 `opencode.json` 中移除 `"frontend-design": "allow"`。

---

## 完成回報格式

```md
✅ #18 frontend-design 已安裝完成！
- 來源：Anthropic（anthropics/skills）
- 安裝路徑：~/.agents/skills/frontend-design/
- 功能：辨識度優先的前端設計（拒絕 AI 模板化）
- 使用方式：說「幫我設計一個有辨識度的頁面」
```

---

## 常見問題

| 問題 | 解法 |
|------|------|
| 設計風格不滿意？ | 嘗試不同的提示詞，或參考 frontend-design 的官方文件 |
| 安裝路徑在哪？ | `~/.agents/skills/frontend-design/` |

---

## Trae 對應操作

> 若你使用 **Trae IDE**，以下為對應的安裝/更新/移除步驟。

### 在 Trae 上安裝

1. 將本技能放入 `.trae/skills/frontend-design/` 目錄：
   ```bash
   mkdir -p .trae/skills/frontend-design/
   ```
2. 從本 repo 的 `skills/18-frontend-design/SKILL.md` 複製內容到 `.trae/skills/frontend-design/SKILL.md`
3. 重新載入 Trae（Cmd+R / Ctrl+R）
4. 對 Trae 說「幫我設計一個有辨識度的 landing page」，確認可載入

### 在 Trae 上更新

替換 `.trae/skills/frontend-design/SKILL.md` 的內容即可。

### 在 Trae 上移除

```bash
rm -rf .trae/skills/frontend-design/
```

---

## 更新紀錄

| 日期 | 版本 | 更新內容 |
|------|------|---------|
| 2026-05-25 | v0.1 | 初版 |
