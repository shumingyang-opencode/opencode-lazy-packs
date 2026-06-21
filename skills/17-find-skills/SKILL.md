---
name: find-skills
description: OpenCode 技能搜尋與安裝 — 當使用者說「找一個能做 X 的技能」「有沒有技能可以⋯」
              「幫我找 xxx 的套件」「安裝 xxx 技能」時載入。從 skills.sh 生態系搜尋並安裝技能。
---

# Find Skills — 技能搜尋與安裝

讓 OpenCode 具備搜尋 open agent skills 生態系並一鍵安裝的能力。

## 安裝步驟

### 前置需求

- [ ] 網路連線（首次安裝需要）

### 步驟一：執行官方安裝器

```bash
npx skills add https://github.com/vercel-labs/skills --skill find-skills
```

此指令會安裝到 `~/.agents/skills/find-skills/`。

### 步驟二：設定權限

在 `~/.config/opencode/opencode.json` 的 `permission.skill` 中加入：

```json
"find-skills": "allow",
```

### 步驟三：驗證

啟動 OpenCode，輸入「找一個能幫我做 React 效能的技能」，確認 find-skills 被正確觸發。

## 使用方式

當你輸入以下關鍵字時自動觸發：
- 「找一個能⋯的技能」
- 「有沒有技能可以⋯」
- 「幫我裝 xxx」
- 「安裝 xxx」
- 「search for a skill to do X」
- 「find a skill for X」

完整的搜尋流程：
1. 先看 https://skills.sh/ 排行榜確認是否有知名技能
2. 若沒有，執行 `npx skills find [關鍵字]` 搜尋
3. 根據安裝數（1K+）、來源信譽、GitHub stars 評估品質
4. 向使用者推薦並協助安裝

## 完成回報格式

```
✅ #17 find-skills 已安裝完成！
- 來源：Vercel Labs（vercel-labs/skills）
- 安裝路徑：~/.agents/skills/find-skills/
- 功能：搜尋＆安裝 open agent skills
- 使用方式：說「找一個能做 X 的技能」
```
