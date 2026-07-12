# OpenCode 懶人包 #25：AGENTS.md 建立教學

> 版本：v0.1
> 更新日期：2026-06-26

---

## 這個懶人包會幫你做什麼？

這不是安裝工具，而是**互動式教學**。我會依你的專案特性，引導你產出一份量身訂做的 AGENTS.md，讓 OpenCode 了解你的專案規範、編碼慣例與團隊流程。

---

## 先備條件

- [ ] 已完成 **懶人包 #00：環境建置**（OpenCode 已安裝）
- [ ] 已經有一個想要設定的專案目錄

---

## 請 OpenCode 幫我執行以下步驟

### 步驟一：什麼是 AGENTS.md？

當你在專案目錄執行 OpenCode 的 `/init` 指令，它會自動分析專案並產生一份 AGENTS.md。但自動產生的只是基本版。

一份良好的 AGENTS.md 可以：
- 讓 AI 了解你的專案結構與技術棧
- 確保 AI 遵循你的編碼慣例與命名規則
- 自動套用團隊規範，減少每次都要重複說明的時間
- 新成員加入時直接繼承專案知識

AGENTS.md 有三個層級：

| 層級 | 檔案位置 | 生效範圍 | 進 Git？ |
|------|---------|---------|---------|
| 全域 | `~/.config/opencode/AGENTS.md` | 你所有的專案 | 不進 Git（個人設定） |
| 專案 | `<專案>/AGENTS.md` | 該專案 | ✅ 進 Git（團隊共用） |
| 本機覆蓋 | `<專案>/AGENTS.local.md` | 該專案 | 不進 Git（個人覆蓋） |

> 你目前有執行過 `/init` 嗎？還是想從頭建立一份？

---

### 步驟二：專案基本資料

請告訴我你的專案資訊：

> - 專案名稱是什麼？
> - 主要使用的語言與框架？
> - 專案是做什麼用的？

根據你的回答，我會產生第一版 AGENTS.md 的標題與簡介。

---

### 步驟三：選擇要加入的章節

AGENTS.md 可以包含以下章節。請勾選你想加入的：

```
[ ] 專案目錄結構 — 讓 AI 了解檔案分布
[ ] 編碼慣例與命名規則 — 確保程式碼風格一致
[ ] 測試規範 — 用什麼框架、如何寫測試
[ ] 技術棧一覽 — 前端/後端/資料庫/第三方服務
[ ] Git 工作流程 — branch 策略、commit 訊息格式
[ ] 環境變數與設定檔 — 哪些 env 檔、如何設定
[ ] 部署流程 — CI/CD 步驟、上線檢查清單
[ ] 團隊架構 — 維護者、程式碼擁有者
```

每個章節選中後，我會詳細說明為什麼要加、實際填什麼內容、提供範例。

---

### 步驟四：逐章撰寫

以下以常見章節為例，說明撰寫方式：

**4a. 專案目錄結構**

這章讓 AI 第一次進入專案時就了解檔案分布，不用每次重新探索。

```
## 專案目錄結構

<project>/
├── src/              # 主要程式碼
│   ├── api/          # API 端點
│   ├── components/   # 共用元件
│   └── utils/        # 工具函式
├── tests/            # 測試
├── docs/             # 文件
└── scripts/          # 建置腳本
```

> 你的專案目錄長怎樣？你可以貼給我 `tree` 的輸出，我幫你整理。

**4b. 編碼慣例與命名規則**

這章確保 AI 產出的程式碼符合你的團隊風格，減少 code review 的修改量。

```
## 編碼慣例

- 語言：TypeScript (strict mode)
- 命名：變數/函式用 camelCase，元件用 PascalCase，檔案用 kebab-case
- 測試：每個元件需有對應的 .test.tsx
- 註解：public API 需有 JSDoc
- 最大行長：100 字元
```

> 你的專案使用什麼命名慣例？
> - 變數：camelCase / snake_case
> - 檔案：PascalCase / kebab-case
> - 資料庫：snake_case / 其他

**4c. 測試規範**

告訴 AI 測試放在哪裡、用什麼框架、命名慣例。

```
## 測試規範

- 框架：Vitest
- 位置：測試檔放在 src/ 旁邊，副檔名 .test.ts
- 命名：describe('ComponentName') / it('should ...')
- 覆蓋率目標：80%+
- 執行方式：npm test
```

**4d. Git 工作流程**

確保 AI 的 commit 訊息與 branch 命名符合團隊標準。

```
## Git 工作流程

- Branch 策略：feature/<name> → dev → main
- Commit 格式：type(scope): description
  例如：feat(api): add user login endpoint
- 主要類型：feat / fix / refactor / docs / test / chore
```

---

### 步驟五：撰寫全域 AGENTS.md（選用）

除了專案層級的 AGENTS.md，你也可以在 `~/.config/opencode/AGENTS.md` 放一份全域規則，適用在所有專案。

全域 AGENTS.md 適合放的內容：
- 你個人的編碼偏好（例如：我習慣用 tabs 還是 spaces）
- 常用的工具與快捷鍵
- 個人開發流程

> 要一併建立全域 AGENTS.md 嗎？

---

### 步驟六：驗證與測試

建立完成後，重新啟動 OpenCode，然後測試看看：

> 請描述這個專案的目錄結構。

如果 OpenCode 能正確回答，代表 AGENTS.md 已成功載入。

你也可以用 agnix 驗證格式：
```bash
npx agnix . --target opencode
```

---

### 步驟七：團隊共享

將 AGENTS.md 提交到 Git：
```bash
git add AGENTS.md
git commit -m "docs: 加入專案 AGENTS.md"
git push
```

團隊成員 pull 之後，他們的 OpenCode 就會自動讀取這份規範。

> 記得提醒團隊成員：
> - 如果他們有個人的覆蓋需求，使用 AGENTS.local.md（不進 Git）
> - 每次更新 AGENTS.md 後，重啟 OpenCode 才會生效

---

## 完成回報格式

```md
✅ AGENTS.md 已建立完成！
- 專案層級：<路徑>/AGENTS.md
- 全域層級：<有/無>
- 包含章節：<列表>
- 測試驗證：✅ OpenCode 正確讀取
```

---

## 常見問題

| 問題 | 解法 |
|------|------|
| AGENTS.md 跟 CLAUDE.md 有什麼不同？ | 功能相同，OpenCode 兩種都支援。Claude Code 只讀 CLAUDE.md |
| AGENTS.local.md 的優先順序？ | AGENTS.local.md > AGENTS.md，local 會覆蓋同名 key |
| 更新 AGENTS.md 後需要重啟嗎？ | 是的，修改後需重啟 OpenCode 才會重新載入 |
| 多個專案共用規範怎麼辦？ | 把通用規則放全域 AGENTS.md，專案 AGENTS.md 只放專案特有內容 |

## Trae 對應操作

本懶人包為教學性質，無需安裝任何工具，OpenCode 與 Trae 皆適用。

---

## 更新紀錄

| 日期 | 版本 | 更新內容 |
|------|------|---------|
| 2026-06-26 | v0.1 | 初版 |
