# OpenCode 懶人包 #16：oh-my-opencode-slim 多 Agent 編排系統

> 版本：v0.1 | 更新日期：2026-06-21

---

## 這個懶人包會幫你做什麼？

OMO 是一套 OpenCode 多 Agent 編排插件，把單一 Agent 升級成 **7 個專用 Agent 的專家團隊**：

- **7 個 Agent**：Orchestrator（調度）、Oracle（策略）、Explorer（探索）、Librarian（知識）、Designer（設計）、Fixer（實作）、Council（共識）
- **背景任務**：Agent 可平行執行，Orchestrator 協調結果
- **TUI 監控**：即時查看各 Agent 活動狀態
- **Companion App**：桌面浮動視窗顯示 Agent 動態（選用）
- **7 個 Bundled Skills**：simplify、codemap、clonedeps、deepwork、reflect、worktrees、oh-my-opencode-slim

---

## 先備條件

- [ ] Node.js 18+ 已安裝
- [ ] 至少一個 LLM Provider 憑證（你已有 NVIDIA + OpenRouter）

---

## 安裝步驟

### 步驟一：安裝 bun

OMO 安裝器使用 `bunx`（類似 `npx` 但更快），需先安裝 bun：

```bash
curl -fsSL https://bun.sh/install | bash
```

安裝後重啟終端機或載入 shell：

```bash
source ~/.zshrc
```

驗證：

```bash
bun --version
```

預期看到類似 `1.2.x` 的版本號。

### 步驟二：安裝 OMO Plugin

執行官方安裝器：

```bash
bunx oh-my-opencode-slim@latest install
```

安裝過程中會問以下問題：

| 問題 | 建議回答 |
|------|---------|
| Install bundled skills? | `yes`（安裝 7 個技能） |
| Active preset | 選 `openai`（安裝後我們會手動改 config） |
| Configure background subagents env? | `yes`（啟用背景 Agent） |
| Enable Companion? | 依個人喜好 |
| Non-interactive mode? | 不需要 |

安裝器會自動：
1. 產生設定檔 `~/.config/opencode/oh-my-opencode-slim.json`
2. 在 `opencode.json` 加入 plugin 設定
3. 安裝 7 個 bundled skills 到 `~/.config/opencode/skills/`

### 步驟三：確認 opencode.json

檢查 `~/.config/opencode/opencode.json` 是否有以下內容：

```json
{
  "plugin": [
    ".opencode/plugins/oh-my-opencode-slim.js"
  ],
  "permission": {
    "skill": {
      "oh-my-opencode-slim": "allow",
      ...
    }
  }
}
```

如果缺少，手動加入。

### 步驟四：設定 Model Preset（NVIDIA + OpenRouter）

OMO 預設的 `openai` preset 使用 `openai/gpt-5.5` 等模型，但你沒有 OpenAI 憑證。
我們需要建立一個自訂 preset，使用你已有的 **NVIDIA** 和 **OpenRouter** 模型。

編輯 `~/.config/opencode/oh-my-opencode-slim.json`，取代為以下內容：

```json
{
  "$schema": "https://unpkg.com/oh-my-opencode-slim@latest/oh-my-opencode-slim.schema.json",
  "preset": "nvidia-opencode",
  "autoUpdate": true,
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
  },
  "disabled_agents": [],
  "disabled_mcps": [],
  "disabled_tools": [],
  "disabled_skills": [],
  "backgroundJobs": {
    "maxSessionsPerAgent": 2,
    "readContextMinLines": 10,
    "readContextMaxFiles": 8
  },
  "fallback": {
    "enabled": true,
    "timeoutMs": 15000,
    "retryDelayMs": 500,
    "retry_on_empty": true
  }
}
```

**如果你後續想改用 OpenRouter 的部分模型**，可將 Designer 改為：

```json
"designer": {
  "model": "openrouter/~google/gemini-flash-latest",
  "variant": "medium"
}
```

### 步驟五：登入 Provider + 重新整理模型

```bash
opencode auth login
```

不需要重新登入，確認已有憑證即可（你目前已有 NVIDIA + OpenRouter）。

然後重新整理模型清單：

```bash
opencode models --refresh
```

### 步驟六：驗證安裝

啟動 OpenCode：

```bash
opencode
```

然後在對話中輸入：

```
ping all agents
```

預期看到類似輸出：

| Agent | Status |
|-------|--------|
| Orchestrator | ✅ 正常回應 |
| Oracle | ✅ 正常回應 |
| Council | ✅ 正常回應 |
| Librarian | ✅ 正常回應 |
| Explorer | ✅ 正常回應 |
| Designer | ✅ 正常回應 |
| Fixer | ✅ 正常回應 |

---

## OMO 7 個 Agent 詳細說明

### 01. Orchestrator（調度者）
- **角色**：主規劃師與任務分配者，決定最佳路徑，平衡速度/品質/成本
- **模型建議**：最強的規劃與判斷模型 → `nvidia/deepseek-ai/deepseek-v4-pro (medium)`
- **觸發**：自動調度，或 `@orchestrator <任務>`

### 02. Oracle（預言者）
- **角色**：策略顧問、架構審查、疑難排解最終手段
- **模型建議**：最強的推理模型 → `nvidia/deepseek-ai/deepseek-v4-pro (high)`
- **觸發**：`@oracle review 這個架構`

### 03. Council（議會）
- **角色**：多模型平行分析，匯總最佳答案
- **模型建議**：強匯總模型 + 多樣化的 councillors
- **觸發**：`@council 比較這兩種方案`
- **注意**：最高成本的 Agent，預設不自動調用

### 04. Explorer（探險者）
- **角色**：程式碼庫盤點、檔案搜尋、結構分析
- **模型建議**：快速低成本模型 → `nvidia/deepseek-ai/deepseek-v4-flash (low)`
- **觸發**：`@explorer 分析這個專案的結構`

### 05. Librarian（圖書館員）
- **角色**：外部知識檢索、文件查詢、API 查找
- **模型建議**：快速低成本模型 → `nvidia/deepseek-ai/deepseek-v4-flash (low)`
- **觸發**：`@librarian 查 React 19 的新功能`

### 06. Designer（設計師）
- **角色**：UI/UX 設計與前端實作、視覺品質把關
- **模型建議**：UI/UX 判斷力強 + 前端能力 → `nvidia/deepseek-ai/deepseek-v4-flash`
- **觸發**：`@designer 做一個登入頁面`

### 07. Fixer（修復者）
- **角色**：快速實作與程式碼修正
- **模型建議**：可靠的編碼模型 → `nvidia/deepseek-ai/deepseek-v4-flash (high)`
- **觸發**：`@fixer 實作這個功能`

---

## OMO 7 個 Bundled Skills

| Skill | 用途 | 觸發 |
|-------|------|------|
| **simplify** | 保留行為的程式碼簡化 | `@oracle simplify` |
| **codemap** | 產生專案階層式架構圖 | `@orchestrator 產生 codemap` |
| **clonedeps** | Clone 依賴原始碼到本機 | `@orchestrator clone deps` |
| **deepwork** | 重大程式碼工作（多階段/高風險） | `/deepwork 重構認證系統` |
| **reflect** | 回顧工作模式，建議改進 | `/reflect` |
| **worktrees** | Git worktree 隔離開發通道 | `/worktrees` |
| **oh-my-opencode-slim** | 自我配置與調校 | `優化 OMO 設定` |

---

## 使用方式

| 情境 | 指令 |
|------|------|
| 觸發技能 | `omo` |
| 驗證全部 Agent | `ping all agents` |
| 探索程式碼 | `@explorer 分析這個專案的結構` |
| 策略建議 | `@oracle 這個架構有什麼風險？` |
| 設計 UI | `@designer 做一個登入頁面，用 glassmorphism` |
| 查資料 | `@librarian Next.js 15 的 Server Actions` |
| 修 Bug | `@fixer 修正這個 type error` |
| 切換預設 | `/preset nvidia-opencode` |
| 重大任務 | `/deepwork 實作付款流程` |
| 回顧改進 | `/reflect` |

---

## 與現有懶人包的整合

| 懶人包 | 與 OMO 關係 |
|--------|------------|
| #15 UI/UX Pro Max | Designer Agent 可使用 #15 的設計智能 |
| #14 Awesome DESIGN.md | Designer Agent 可套用品牌 DESIGN.md |
| #09 Playwright | 可透過 MCP 讓 Explorer 使用瀏覽器 |
| #08 Firebase | 可透過 MCP 讓 Fixer 操作 Firebase |

OMO 的 Agent 可以存取你已有的 skills、MCP 和 tools — 只需在 `oh-my-opencode-slim.json` 的 `mcps` 陣列中加入對應 MCP 名稱。

---

## 完成回報格式

```md
## oh-my-opencode-slim 安裝完成

- bun 安裝：✅ 已安裝（版本 x.x.x）
- OMO Plugin：✅ bunx install 成功
- opencode.json plugin：✅ 已設定
- opencode.json permission：✅ oh-my-opencode-slim: allow
- 自訂 Model Preset：✅ nvidia-opencode（NVIDIA + OpenRouter）
- Provider 認證：✅ NVIDIA / OpenRouter
- ping all agents：✅ 全部 7 個 Agent 正常回應
```

---

## 常見問題

| 問題 | 解法 |
|------|------|
| `bunx` 找不到 | 先安裝 bun：`curl -fsSL https://bun.sh/install \| bash` |
| Agent 回應失敗 | 確認 `oh-my-opencode-slim.json` 的 model 名稱正確，執行 `opencode models --refresh` |
| 想改模型 | 編輯 `~/.config/opencode/oh-my-opencode-slim.json` 的 `presets` |
| 想切換 preset | 在對話中輸入 `/preset nvidia-opencode` |
| 插件移除 | 刪除 `~/.config/opencode/oh-my-opencode-slim.json` + opencode.json 的 plugin 設定 |
| OMO 官網 | https://github.com/alvinunreal/oh-my-opencode-slim |
| 問題回報 | Telegram：https://t.me/boringdystopiadevelopment |

---

## 更新紀錄

| 日期 | 版本 | 更新內容 |
|------|------|---------|
| 2026-06-21 | v0.1 | 初版 — 取代 #16 ECC |
