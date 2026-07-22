---
name: trae-opencode
description: >-
  雙向 TRAE ↔ OpenCode CLI 驅動。
  OpenCode → TRAE：用 trae-cli 執行任務；
  TRAE → OpenCode：用 opencode 執行任務。
  說「用 TRAE 幫我」「用 OpenCode 幫我」「trae 分析/除錯/重構/測試」
  「opencode run」時載入。
---

# TRAE ↔ OpenCode 雙向 CLI 驅動

## Part 1：OpenCode → TRAE（呼叫 trae-cli）

### Provider / Model 對照表

| Provider | `--provider` | 常用 `--model` |
|----------|-------------|----------------|
| OpenRouter | `openai` | `deepseek/deepseek-v4-flash-free`（預設免費）、`anthropic/claude-3.5-sonnet` |
| Anthropic | `anthropic` | `claude-sonnet-4-20250514` |
| OpenAI | `openai` | `gpt-4o` |
| Gemini | `google` | `gemini-2.5-flash` |
| Doubao | `doubao` | `doubao-seed-1.6` |
| Ollama | `ollama` | `qwen3` |

### 命令結構

```bash
trae-cli run "任務描述" [-p openai] [-m deepseek/deepseek-v4-flash-free] [-w 路徑]
```

### 四大情境範本

#### 1. 分析
```
trae-cli run "分析這個專案的目錄結構與模組依賴關係，列出各模組的耦合度與技術債"
```

#### 2. 除錯
```
trae-cli run "debug the issue in main.py，找出 crash 原因並修復" -w ./src
```

#### 3. 重構
```
trae-cli run "重構 utils/ 目錄下的程式碼，提取共用邏輯，改善可讀性與維護性" -w ./src
```

#### 4. 測試
```
trae-cli run "為 services/ 目錄補上單元測試，覆蓋率達到 80%" --max-steps 200
```

### trae-cli 指令速查

| 命令 | 用途 |
|------|------|
| `run "任務"` | 執行軟體工程任務 |
| `interactive` | 互動式對話模式 |
| `show-config` | 顯示當前設定 |
| `tools` | 列出可用工具 |

### trae-cli run 常用選項

| 選項 | 範例 | 用途 |
|------|------|------|
| `-p, --provider` | `openai` | 指定 LLM Provider |
| `-m, --model` | `deepseek/deepseek-v4-flash-free` | 指定模型 |
| `-w, --working-dir` | `./src` | 工作目錄 |
| `--max-steps` | `200` | 最大執行步數 |
| `-f, --file` | `task.txt` | 從檔案讀取任務 |
| `--must-patch` | (flag) | 強制產生 patch |
| `-t, --trajectory-file` | `debug.json` | 記錄執行軌跡 |

---

## Part 2：TRAE → OpenCode（呼叫 opencode）

### 命令結構

```bash
opencode run "任務描述" [-m provider/model] [-w 路徑]
```

### 情境範例

| 用途 | 命令 |
|------|------|
| 分析專案 | `opencode run "分析這個專案的目錄結構與技術債"` |
| 執行程式碼變更 | `opencode run "在 login 模組加上 JWT 驗證" -w ./src` |
| 查詢 Session | `opencode session list` |
| 啟動交互模式 | `opencode ./project` |

### opencode 指令速查

| 命令 | 用途 |
|------|------|
| `run "訊息"` | 執行任務 |
| `"路徑"` | 在指定目錄啟動 TUI |
| `serve` | 啟動無頭伺服器 |
| `session` | 管理對話 Session |
| `providers` | 管理 AI Provider |
| `models` | 列出可用模型 |
| `mcp list` | 列出 MCP 伺服器 |

### opencode run 常用選項

| 選項 | 範例 | 用途 |
|------|------|------|
| `-m, --model` | `deepseek/deepseek-v4-flash` | 指定模型 |
| `-w, --working-dir` | `./project` | 工作目錄 |
| `--auto` | (flag) | 自動核准權限 |
| `--agent` | `solo` | 指定 Agent 類型 |

---

## 注意事項

- `trae-cli run` 和 `opencode run` 都是同步命令，等待任務完成後返回結果
- API Key 建議透過環境變數設定，不需寫死在命令中
- 大型任務可適度調高 `--max-steps` 避免過早結束
