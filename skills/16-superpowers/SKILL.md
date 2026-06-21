---
name: superpowers
description: Install Superpowers (obra/superpowers v6.0.3) — 完整的 AI 軟體開發方法論。
              14 skills：brainstorming / TDD / subagent-driven-development / code review / git-worktrees。
              Say「安裝 superpowers」「superpowers 懶人包」時載入。235K GitHub Stars / 1.9M 總安裝。
---

# Superpowers — 完整的 AI 軟體開發方法論

> 作者：Jesse Vincent @ Prime Radiant
> 授權：MIT | Stars：235K | 安裝數：1.9M | 版本：6.0.3

讓 OpenCode 獲得完整的 SDLC（軟體開發生命週期）方法論。

## 安裝步驟

### 前置需求

- [ ] OpenCode 已安裝
- [ ] 網路連線（首次安裝需要）

### 步驟一：加入 Plugin

編輯 `~/.config/opencode/opencode.json`：

```json
{
  "plugin": ["superpowers@git+https://github.com/obra/superpowers.git"]
}
```

### 步驟二：設定 14 個 Skill 權限

在 `permission.skill` 中加入：

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

### 步驟三：啟用 general agent

確認 `agent.general.disable` 不是 `true`（Superpowers 需要它來 dispatch subagent）。

### 步驟四：重啟 OpenCode

Plugin 會自動下載並註冊所有 skills。

### 步驟五：驗證

```
> Tell me about your superpowers
→ 應觸發 using-superpowers skill，顯示 bootstrap context
```

## 完整的 SDLC 流程

```
brainstorming → writing-plans → subagent-driven-development (含 TDD)
                                     ↓
                             requesting-code-review
                                     ↓
                             finishing-a-development-branch
```

## 使用方式

正常向 OpenCode 提出開發需求，Superpowers 會自動觸發對應 skill：
- 「來做一個 CLI 工具」→ brainstorming
- 「幫我修這個 bug」→ systematic-debugging
- 「寫一個 React component」→ brainstorming → writing-plans → ...

## 完成回報格式

```
✅ #16 Superpowers 已安裝完成！
- 來源：obra/superpowers v6.0.3（235K stars）
- 安裝方式：opencode.json plugin
- 14 skills 已註冊
- 使用方式：正常問問題，Superpowers 自動觸發對應 skill
```
