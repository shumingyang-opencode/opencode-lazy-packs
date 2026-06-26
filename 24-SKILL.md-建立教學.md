# OpenCode 懶人包 #24：SKILL.md 建立教學

> 版本：v0.1
> 更新日期：2026-06-26

---

## 這個懶人包會幫你做什麼？

這不是安裝工具，而是**互動式教學**。我會一步步引導你從零建立一個 SKILL.md 技能檔案，過程中說明每個環節的原理與最佳做法。

---

## 先備條件

- [ ] 已完成 **懶人包 #00：環境建置**（OpenCode 已安裝）
- [ ] 已有一個想要建立技能的具體想法（例如：程式碼審查、部署腳本、文件生成）

---

## 請 OpenCode 幫我執行以下步驟

### 步驟一：理解 SKILL.md 是什麼

在開始之前，先回答我一個問題：

> 你希望 OpenCode 能自動幫你做什麼事？

舉例來說：
- 建立 Pull Request 時自動做程式碼審查
- 產生專案的 changelog 與版本號
- 依照品牌規範產生設計稿
- 自動化部署流程

請告訴我你的想法。

---

### 步驟二：決定技能名稱

SKILL.md 的名稱決定 AI 如何辨識與觸發它。請輸入一個技能名稱：

> 請輸入一個小寫英文名稱，用連字號分隔（例如：`code-review`、`deploy-flow`、`brand-design`）：

名稱必須符合以下規則：
- 長度 1-64 個字元
- 僅限小寫字母、數字、連字號（`-`）
- 不能以連字號開頭或結尾
- 不能有連續的 `--`
- 正則表達式：`^[a-z0-9]+(-[a-z0-9]+)*$`

我收到名稱後會幫你驗證。

---

### 步驟三：選擇技能存放位置

OpenCode 會從以下路徑掃描技能：

| 存放位置 | 生效範圍 | 適合場景 |
|---------|---------|---------|
| `~/.config/opencode/skills/<name>/SKILL.md` | **全域** — 所有專案 | 通用技能（你想在任何地方都能用） |
| `<專案>/.opencode/skills/<name>/SKILL.md` | **專案層級** — 單一專案 | 專屬技能（只在這專案中有用） |
| `<專案>/.claude/skills/<name>/SKILL.md` | **相容層級** — 跨 agent | 同時給 Claude Code 使用的技能 |
| `<專案>/.agents/skills/<name>/SKILL.md` | **相容層級** — 跨 agent | 同時給 Codex CLI 使用的技能 |

> 你希望這個技能放全域還是專案層級？

---

### 步驟四：撰寫 Frontmatter（逐步引導）

SKILL.md 必須以 YAML frontmatter 開頭。我們逐步建立：

**4a. 寫 description**

Description 是 OpenCode 判斷何時載入這個技能的關鍵。請用一句話描述：

> 當使用者說什麼話時應該觸發這個技能？
> 例如：「當使用者要求進行 Pull Request 程式碼審查時載入」
> 或：「當使用者提到要產生版本更新或 changelog 時載入」

描述越精準，OpenCode 就越能在正確時機使用你的技能。
字數限制：1-1024 個字元。

**4b. 需要 license 嗎？**

如果技能要發布開源，建議加入 `license` 欄位：
```yaml
license: MIT
```

**4c. 設定 compatibility**

如果技能只適用特定 agent，可以標註：
```yaml
compatibility: opencode
```

目前支援的 agent 類型：`opencode`、`claude`、`codex`、`cursor` 等。

**4d. 完整的 Frontmatter 範例**

根據你的回答，最終會產出類似這樣的 frontmatter：

```yaml
---
name: code-review
description: 當使用者要求進行 Pull Request 程式碼審查時載入。分析 diff、檢查程式碼品質、提供改善建議。
license: MIT
compatibility: opencode
---
```

---

### 步驟五：建立技能目錄結構

技能不只是一個 SKILL.md，還可以包含輔助資源。目錄結構如下：

```
<name>/
├── SKILL.md          ← (必要) 主要指令
├── scripts/          ← (選用) 可執行的 Python/Bash 腳本
├── references/       ← (選用) 參考文件（API 規格、Schema）
└── assets/           ← (選用) 輸出用的範本與素材
```

> 你的技能需要腳本、參考文件或範本嗎？

各類資源的用途說明：

**scripts/ — 腳本**
當任務需要可靠重複執行相同邏輯時使用。例如：
- PDF 旋轉腳本（每次寫同樣的 PyPDF2 程式碼很浪費）
- 資料庫查詢工具（固定的連線與查詢邏輯）
- 圖片處理腳本（resize、格式轉換）

優點：腳本可以直接執行而不佔用 AI 的 context window。

**references/ — 參考文件**
當技能需要查閱大量資訊時使用。例如：
- 公司 API 規格文件
- 資料庫 Table Schema
- 設計系統的設計規範
- 團隊的編碼慣例文件

優點：文件只有在需要時才載入，不會浪費 context。

**assets/ — 資產範本**
當技能需要產出包含範本的成品時使用。例如：
- HTML/React 專案樣板（`assets/hello-world/`）
- 品牌 Logo 與字型（`assets/logo.png`）
- 簡報範本（`assets/template.pptx`）

優點：檔案不需要載入到 context，直接複製或修改即可。

---

### 步驟六：建立 SKILL.md 技能內容

現在開始撰寫 SKILL.md 的主體內容。以下是一個完整的範本：

```markdown
---
name: <你的技能名稱>
description: <你的技能描述>
license: MIT
compatibility: opencode
---

## 這個技能做什麼

用一兩句話說明這個技能的核心功能。

## 何時觸發

說明使用者說什麼話時應該載入這個技能。

## 使用方式

逐步說明 AI 應該如何執行這個技能。
引用 `scripts/`、`references/`、`assets/` 中的資源。
```

寫作原則：
- 使用**祈使句**（「執行以下步驟」而非「你應該執行以下步驟」）
- 只放對 AI 有幫助的、非顯而易見的資訊
- 將細節放到 references/，保持 SKILL.md 精簡

---

### 步驟七：設定權限

編輯 opencode.json，決定誰可以使用這個技能：

```json
{
  "permission": {
    "skill": {
      "<名稱>": "allow"
    }
  }
}
```

三種權限：

| 權限 | 行為 |
|------|------|
| `allow` | 技能自動載入，AI 可以使用 |
| `deny` | 技能隱藏，AI 看不到也用不了 |
| `ask` | 使用前詢問使用者是否允許 |

> 你的技能要設為 allow、deny 還是 ask？

---

### 步驟八：驗證技能

建議安裝 agnix 來驗證 SKILL.md 格式是否正確：

```bash
# 安裝 agnix
npm install -g agnix

# 驗證技能目錄
agnix . --target opencode
```

agnix 會檢查：
- Frontmatter 格式是否正確
- 名稱是否符合命名規則
- Description 是否完整
- 目錄結構是否正確

> 請執行驗證，告訴我結果，如果有錯誤我幫你修正。

---

### 步驟九：發布與分享

要將技能發布給其他人使用嗎？有幾種方式：

**方式一：直接複製 SKILL.md**
最簡單的方式，直接將 SKILL.md 檔案分享給他人。

**方式二：上傳 GitHub**
將技能目錄上傳到 GitHub，其他人可以下載或 clone。

**方式三：註冊到 Skills Registry**
```bash
npx skills add <your-github-repo> --skill <skill-name>
```
這樣其他人就能用 `npx skills add` 一鍵安裝你的技能。

---

## 完成回報格式

```md
✅ SKILL.md 技能已建立！
- 技能名稱：<name>
- 存放位置：<全域/專案>
- 資源目錄：scripts/references/assets（依選擇）
- 權限設定：<allow/deny/ask>
- 驗證結果：✅ agnix 通過
- 使用方式：說「<觸發關鍵字>」
```

---

## 常見問題

| 問題 | 解法 |
|------|------|
| 技能沒有被載入？ | 確認 SKILL.md 是全部大寫，frontmatter 有 name 和 description |
| 名稱衝突怎麼辦？ | OpenCode 會在所有掃描路徑中比對名稱，同名技能會互相覆蓋 |
| description 要多長？ | 1-1024 字元，越精準越好，但不要塞無關資訊 |
| 技能跟 plugin 有什麼不同？ | Skill 是指令檔（告訴 AI 怎麼做），Plugin 是程式碼（擴充 OpenCode 本身功能） |
| 如何測試技能？ | 儲存後重啟 OpenCode，說觸發關鍵字看是否載入 |

---

## 更新紀錄

| 日期 | 版本 | 更新內容 |
|------|------|---------|
| 2026-06-26 | v0.1 | 初版 |
