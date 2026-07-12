# OpenCode 懶人包 #17：Find Skills — 技能搜尋與安裝

> 版本：v0.1
> 更新日期：2026-06-21

---

## 這個懶人包會幫你做什麼？

讓 OpenCode 能夠搜尋 open agent skills 生態系（skills.sh），找到並安裝各種專業技能：

- 從 5000+ 個開放技能中搜尋你需要的功能
- 一鍵安裝來自 Vercel、Anthropic、Microsoft 等官方來源的技能
- 自動評估品質（安裝數、GitHub stars、來源信譽）
- 無需離開對話，全部在 OpenCode 內完成

安裝後你可以在 OpenCode 中輸入「找一個能做 React 效能的技能」、「有沒有寫測試的技能可以裝」來啟動搜尋。

---

## 先備條件

- [ ] 網路連線（首次安裝需要）

---

## 請 OpenCode 幫我執行以下步驟

### 步驟一：執行官方安裝器

```bash
npx skills add https://github.com/vercel-labs/skills --skill find-skills
```

此指令會自動安裝到 `~/.agents/skills/find-skills/`。

### 步驟二：設定 opencode.json 權限

編輯 `~/.config/opencode/opencode.json`，在 `permission.skill` 中加入：

```json
"find-skills": "allow",
```

完成後權限區塊看起來像這樣：

```json
"skill": {
  "find-skills": "allow",
  "draw": "allow",
  "startup": "allow",
  // ... 其他技能
  "*": "ask"
}
```

### 步驟三：驗證

啟動 OpenCode（若已在執行中請重啟），輸入：

> 找一個能幫我寫測試的技能

確認 find-skills 被正確觸發並顯示搜尋結果。

---

## 使用方式

### 觸發關鍵字

| 中文 | English |
|------|---------|
| 找一個能⋯的技能 | find a skill to... |
| 有沒有技能可以⋯ | is there a skill for... |
| 幫我裝 xxx | install [skill] |
| 搜尋 xxx 技能 | search for [skill] |

### 完整搜尋流程

1. **排行榜優先**：先看 https://skills.sh/ 確認是否有知名技能
2. **CLI 搜尋**：若排行榜沒有，執行 `npx skills find [關鍵字]`
3. **品質把關**：檢查安裝數（1K+）、來源信譽、GitHub stars
4. **推薦安裝**：向使用者說明並協助安裝

---

## 常用搜尋範例

| 你要做什麼 | 搜尋關鍵字 |
|-----------|-----------|
| React 效能優化 | `npx skills find react performance` |
| 寫測試 | `npx skills find testing` |
| Code Review | `npx skills find pr review` |
| 產生 Changelog | `npx skills find changelog` |
| Docker 部署 | `npx skills find docker` |
| API 文件 | `npx skills find api-docs` |

---

## 解除安裝

```bash
rm -rf ~/.agents/skills/find-skills
```

並從 `opencode.json` 中移除 `"find-skills": "allow"`。

---

## 完成回報格式

```md
✅ #17 find-skills 已安裝完成！
- 來源：Vercel Labs（vercel-labs/skills）
- 安裝路徑：~/.agents/skills/find-skills/
- 功能：搜尋＆安裝 open agent skills
- 使用方式：說「找一個能做 X 的技能」
```

---

## 常見問題

| 問題 | 解法 |
|------|------|
| 搜尋不到技能？ | 確認網路連線正常，試試不同關鍵字 |
| 安裝的技能在哪？ | 安裝在 `~/.agents/skills/<name>/`，opencode.json 需加入對應權限 |

---

## Trae 對應操作

> 若你使用 **Trae IDE**，以下為對應的安裝/更新/移除步驟。

### 在 Trae 上安裝

1. 將本技能放入 `.trae/skills/find-skills/` 目錄：
   ```bash
   mkdir -p .trae/skills/find-skills/
   ```
2. 從本 repo 的 `skills/17-find-skills/SKILL.md` 複製內容到 `.trae/skills/find-skills/SKILL.md`
3. 重新載入 Trae（Cmd+R / Ctrl+R）
4. 對 Trae 說「找一個能幫我寫測試的技能」，確認可載入

### 在 Trae 上更新

替換 `.trae/skills/find-skills/SKILL.md` 的內容即可。

### 在 Trae 上移除

```bash
rm -rf .trae/skills/find-skills/
```

---

## 更新紀錄

| 日期 | 版本 | 更新內容 |
|------|------|---------|
| 2026-05-25 | v0.1 | 初版 |
