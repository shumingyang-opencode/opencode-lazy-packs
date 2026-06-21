---
name: oh-my-opencode-slim
description: oh-my-opencode-slim — OpenCode 多 Agent 編排插件。
             7 個專用 Agent（Orchestrator、Oracle、Explorer、Librarian、
             Designer、Fixer、Council）+ 背景任務、TUI、Companion App。
             說「omo」「oh-my-opencode」「安裝 omo」「多 agent」時載入。
---

# oh-my-opencode-slim — OpenCode 多 Agent 編排插件

> 由 Boring Dystopia Development 開發（MIT 授權）
> GitHub：https://github.com/alvinunreal/oh-my-opencode-slim

## 安裝步驟

### 前置需求

- [ ] Node.js 18+ 已安裝
- [ ] 網路連線
- [ ] 至少一個 LLM Provider API（OpenRouter / NVIDIA / OpenAI 等）

### 步驟一：安裝 bun

OMO 使用 `bunx` 安裝，需先安裝 bun：

```bash
curl -fsSL https://bun.sh/install | bash
```

安裝後重新開啟終端機，或執行：
```bash
source ~/.zshrc
```

驗證：
```bash
bun --version
```

### 步驟二：安裝 OMO Plugin

```bash
bunx oh-my-opencode-slim@latest install
```

安裝過程中會問：
- Install bundled skills? → **yes**
- Configure background subagents env? → **yes**
- Enable Companion? → 依個人喜好

### 步驟三：設定 opencode.json 權限

OMO 安裝器理論上會自動加入 plugin 到 `opencode.json`。
若未自動完成，編輯 `~/.config/opencode/opencode.json`：

```json
{
  "plugin": [
    ".opencode/plugins/oh-my-opencode-slim.js"
  ]
}
```

並在 `permission.skill` 加入：
```json
"oh-my-opencode-slim": "allow"
```

### 步驟四：設定 Model Preset（NVIDIA + OpenRouter）

OMO 預設產生 `openai` 和 `opencode-go` 兩個 preset，
但你可能沒有這兩個 provider。編輯 `~/.config/opencode/oh-my-opencode-slim.json`，
建立自訂 preset 使用你已註冊的 provider：

```jsonc
{
  "$schema": "https://unpkg.com/oh-my-opencode-slim@latest/oh-my-opencode-slim.schema.json",
  "preset": "nvidia-opencode",
  "presets": {
    "nvidia-opencode": {
      "orchestrator": {
        "model": "nvidia/deepseek-ai/deepseek-v4-pro",
        "variant": "medium",
        "skills": ["*"],
        "mcps": ["*", "!context7"]
      },
      "oracle": {
        "model": "nvidia/deepseek-ai/deepseek-v4-pro",
        "variant": "high",
        "skills": ["simplify"],
        "mcps": []
      },
      "council": {
        "model": "nvidia/deepseek-ai/deepseek-v4-pro",
        "variant": "high",
        "skills": [],
        "mcps": []
      },
      "librarian": {
        "model": "nvidia/deepseek-ai/deepseek-v4-flash",
        "variant": "low",
        "skills": [],
        "mcps": ["websearch", "context7", "gh_grep"]
      },
      "explorer": {
        "model": "nvidia/deepseek-ai/deepseek-v4-flash",
        "variant": "low",
        "skills": [],
        "mcps": []
      },
      "designer": {
        "model": "nvidia/deepseek-ai/deepseek-v4-flash",
        "variant": "medium",
        "skills": [],
        "mcps": []
      },
      "fixer": {
        "model": "nvidia/deepseek-ai/deepseek-v4-flash",
        "variant": "high",
        "skills": [],
        "mcps": []
      }
    }
  }
}
```

如果想混合 OpenRouter 模型，可以把 Designer 改為：
```json
"designer": {
  "model": "openrouter/~google/gemini-flash-latest",
  "variant": "medium"
}
```

### 步驟五：登入 Provider 並整理模型

```bash
opencode auth login
opencode models --refresh
```

### 步驟六：驗證安裝

啟動 OpenCode 後輸入：

```
ping all agents
```

預期看到所有 agent 回應正常。

## OMO 7 個 Agent 說明

| Agent | 角色 | 建議模型 |
|-------|------|---------|
| **Orchestrator** | 主調度員，任務規劃與分配 | DeepSeek V4 Pro（medium） |
| **Oracle** | 策略顧問、架構審查、疑難排解 | DeepSeek V4 Pro（high） |
| **Council** | 多模型共識系統，平行分析 | DeepSeek V4 Pro（high） |
| **Explorer** | 程式碼探索、專案盤點 | DeepSeek V4 Flash（low） |
| **Librarian** | 外部知識檢索、文件查詢 | DeepSeek V4 Flash（low） |
| **Designer** | UI/UX 設計與前端實作 | DeepSeek V4 Flash 或 Gemini Flash |
| **Fixer** | 快速實作與修正 | DeepSeek V4 Flash（high） |

## 使用方式

| 情境 | 指令 |
|------|------|
| 觸發 OMO 技能 | `omo` |
| 驗證 agent | `ping all agents` |
| 查詢程式碼庫 | `@explorer 分析這個專案的結構` |
| 策略建議 | `@oracle 這個架構有什麼風險？` |
| 設計 UI | `@designer 做一個登入頁面` |
| 多模型共識 | `@council 比較這兩種實作方式` |

## 完成的指令格式

```md
## oh-my-opencode-slim 安裝完成

- bun 安裝：✅ 已安裝（版本 x.x.x）
- OMO Plugin 安裝：✅ 成功
- opencode.json plugin 設定：✅ 已加入
- Model Preset：✅ nvidia-opencode 設定完成
- Provider 登入：✅ NVIDIA + OpenRouter
- ping all agents：✅ 全部回應正常
```
