# OpenCode 懶人包 #16：Superpowers — 完整的 AI 軟體開發方法論

> 版本：v6.0.3
> 更新日期：2026-06-21
> 作者：Jesse Vincent @ Prime Radiant
> GitHub Stars：235K | 總安裝數：1.9M | 技能數：14

---

## 這個懶人包會幫你做什麼？

讓 OpenCode 獲得 **完整的 SDLC（軟體開發生命週期）方法論**，不再是跳進去寫 code，而是：

1. **Brainstorming** — 先理解需求、探索方案、寫 design doc
2. **Writing Plans** — 把設計拆成 2-5 分鐘的小任務
3. **Subagent-Driven Development** — 每 task 派一個專注的 subagent，含 spec 審查 + code review
4. **Test-Driven Development** — RED-GREEN-REFACTOR 循環
5. **Code Review** — 自動程式碼審查
6. **Finishing Branches** — merge/PR 決策

安裝後你只需正常問問題，Superpowers 會自動觸發對應的 skill。

---

## 先備條件

- [ ] OpenCode 已安裝
- [ ] 網路連線（首次安裝需要）

---

## 請 OpenCode 幫我執行以下步驟

### 步驟一：加入 Superpowers Plugin

編輯 `~/.config/opencode/opencode.json`，在 `plugin` 陣列中加入：

```json
"superpowers@git+https://github.com/obra/superpowers.git"
```

完成後 plugin 區塊看起來像這樣：

```json
"plugin": [
  "superpowers@git+https://github.com/obra/superpowers.git"
]
```

### 步驟二：設定 14 個 Skill 權限

在 `opencode.json` 的 `permission.skill` 中加入：

```json
"using-superpowers": "allow",
"brainstorming": "allow",
"systematic-debugging": "allow",
"writing-plans": "allow",
"subagent-driven-development": "allow",
"executing-plans": "allow",
"test-driven-development": "allow",
"requesting-code-review": "allow",
"receiving-code-review": "allow",
"using-git-worktrees": "allow",
"finishing-a-development-branch": "allow",
"dispatching-parallel-agents": "allow",
"verification-before-completion": "allow",
"writing-skills": "allow",
```

### 步驟三：啟用 general agent（重要）

Superpowers 使用 `task` tool + `subagent_type: "general"` 來派發 subagent。如果你之前關閉了 `general` agent，必須移除或設為 `false`：

```json
"agent": {
  "general": {
    "disable": false
  }
}
```

或直接移除整個 `agent` 區塊。

### 步驟四：重啟 OpenCode

關閉並重新啟動 OpenCode。首次啟動時 Plugin 會自動：
1. 從 GitHub 下載 Superpowers 套件
2. 註冊 14 個 skills 到 skills 路徑
3. 注入 bootstrap context 到每個新 session

### 步驟五：驗證

啟動後輸入：

> Tell me about your superpowers

確認 `using-superpowers` skill 被正確觸發，並且 session 開頭出現 `<EXTREMELY_IMPORTANT>` bootstrap context。

然後測試完整流程：

> Let's build a simple hello world CLI tool

應觸發 `brainstorming` skill，開始問你需求問題。

---

## 14 個技能完整列表

| 技能 | 用途 | 觸發時機 |
|------|------|---------|
| `using-superpowers` | 系統引導入口（bootstrap） | 每次 session 自動注入 |
| `brainstorming` | Socratic 設計反覆討論，產生 design doc | 任何創造性工作前 |
| `writing-plans` | 將設計拆成 2-5 分鐘的實作任務 | design doc 完成後 |
| `subagent-driven-development` | 每 task 派 subagent + spec/code 雙審查 | 有實作計畫、任務獨立 |
| `executing-plans` | 批次執行 + 人工 checkpoint | 沒有 subagent 時 |
| `test-driven-development` | RED-GREEN-REFACTOR 循環 | 實作過程自動觸發 |
| `systematic-debugging` | 4 階段根因分析流程 | 除錯時 |
| `requesting-code-review` | 依 plan 審查程式碼品質 | task 完成後 |
| `receiving-code-review` | 回應 review feedback | 收到 review 時 |
| `using-git-worktrees` | 隔離開發分支 | feature work 開始時 |
| `finishing-a-development-branch` | merge/PR 決策流程 | 所有 task 完成後 |
| `dispatching-parallel-agents` | 並行 subagent 工作流 | 多個獨立問題 |
| `verification-before-completion` | 確保修復真的完成 | debug 修復後 |
| `writing-skills` | 依最佳實踐建立新技能 | 想自訂 skill 時 |

---

## 完整工作流程圖解

```
User 說「做一個 X 功能」
        │
        ▼
┌─────────────────┐
│   brainstorming  │  ← 問需求、探索方案、寫 design doc
│   (強制，不可跳過) │
└────────┬────────┘
         │ 設計 approved
         ▼
┌─────────────────┐
│  writing-plans  │  ← 拆成 2-5 分鐘小任務
│                 │     每 task 含：檔案路徑、完整程式碼、驗證方式
└────────┬────────┘
         │ 計畫 ready
         ▼
┌─────────────────────────────┐
│ subagent-driven-development │  ← (有 subagent 時)
│ 或                          │
│ executing-plans             │  ← (無 subagent 時)
└────────┬────────────────────┘
         │ 每個 task 循環：
         │   1. Task Brief → dispatch implementer
         │   2. TDD: RED → GREEN → REFACTOR
         │   3. Self-review + commit
         │   4. Task reviewer (spec + code quality)
         │   5. Fix if needed → re-review
         ▼
┌─────────────────────┐
│ requesting-code-review│  ← 最終全分支審查
└────────┬────────────┘
         │
         ▼
┌──────────────────────────┐
│ finishing-a-development- │
│ branch                   │  ← merge/PR/keep/discard 決策
└──────────────────────────┘
```

---

## 與之前 OMO 的差異

| 項目 | OMO（已移除） | Superpowers（現在） |
|------|--------------|-------------------|
| 定位 | 多 Agent 模型路由 / 編排 | 完整 SDLC 方法論 |
| Subagent | `@oracle` `@designer` 內建 agent | `task` tool dispatch general subagent |
| Workflow | 無強制流程 | 強制 brainstorm → plan → build → review |
| 技能數量 | 7 bundled | 14 skills |
| 原始碼 | 閉源 npm package | 開源 MIT（235K stars） |
| 作者 | Community | Jesse Vincent / Prime Radiant |

---

## 解除安裝

```bash
# 從 opencode.json 移除 plugin 行
# 從 opencode.json 移除 14 個 skill permissions
# 清除 plugin cache（需要時）
rm -rf ~/.config/opencode/node_modules/superpowers
```

## 更新

Superpowers 透過 git-backed plugin spec 安裝。更新通常自動生效，若不更新，清除 OpenCode 的 plugin cache 或重裝 plugin。

要鎖定特定版本：

```json
"superpowers@git+https://github.com/obra/superpowers.git#v5.0.3"
```

## 常見問題

### Plugin 沒載入

```bash
opencode run --print-logs "hello" 2>&1 | grep -i superpowers
```

### Skills 沒發現

使用 OpenCode 的 `skill` tool 列出可用技能，確認 14 個都在。

### Subagent 無法 dispatch

確認 `agent.general.disable` 沒有被設為 `true`。

---

## 完成回報

```
✅ #16 Superpowers 已安裝完成！
- 來源：obra/superpowers v6.0.3（235K stars）
- 安裝方式：opencode.json plugin
- 14 skills 已註冊
- 使用方式：正常問問題，Superpowers 自動觸發對應 skill
- 首次驗證：說「Tell me about your superpowers」
```
