# OpenCode 懶人包 #30：TRAE 與 OpenCode 雙向驅動

> 版本：v0.2
> 更新日期：2026-07-21

---

## 這個懶人包會幫你做什麼？

讓 **OpenCode** 與 **TRAE（trae-agent）** 可以互相驅動——兩者都是 CLI 工具，透過命令列直接呼叫：

| 你的平台 | 安裝目標 | 效果 |
|---------|---------|------|
| **OpenCode** 用戶 | 安裝 TRAE Agent CLI | 在 OpenCode 中用 `trae-cli run` 執行任務 |
| **Trae IDE** 用戶 | 安裝 OpenCode CLI | 在 TRAE Agent 中用 `opencode` 執行任務 |

### TRAE Agent 是什麼？

> 出處：ByteDance — https://github.com/bytedance/trae-agent
> ⭐ 11.9K Stars | MIT License
>
> Trae Agent 是字節跳動推出的 LLM-based 軟體工程 Agent，支援多種 LLM Provider（OpenAI、Anthropic、Doubao、Gemini、Ollama），可透過 `trae-cli` 命令列執行軟體工程任務。

---

## 先備條件

- [ ] 已完成 **懶人包 #00：環境建置**
- [ ] **OpenCode 用戶**：已安裝 OpenCode
- [ ] **Trae IDE 用戶**：已安裝 Trae IDE + Python 3.12+

---

## 請 OpenCode/Trae 幫我執行以下步驟

### 步驟一：確認你的平台

> 你是 **OpenCode** 用戶還是 **Trae IDE** 用戶？

根據你的回答，後續步驟會自動對應：

| 你的回答 | 安裝動作 |
|---------|---------|
| **OpenCode** | 安裝 `trae-agent`，可透過 bash 呼叫 `trae-cli` 執行任務 |
| **Trae IDE** | 安裝 `opencode` CLI，可透過 bash 呼叫 `opencode` 執行任務 |

---

### 步驟二：OpenCode 用戶專用 — 安裝 TRAE Agent

#### 2a. 安裝 TRAE Agent

```bash
git clone https://github.com/bytedance/trae-agent.git
cd trae-agent
uv sync --all-extras
pip install -e .
```

#### 2b. 驗證安裝

```bash
trae-cli --version
# 預期輸出：trae-cli, version 0.1.0
```

#### 2c. 設定 TRAE Agent

建立設定檔 `~/.trae/trae_config.yaml`：

```yaml
agents:
  trae_agent:
    enable_lakeview: true
    model: my_model
    max_steps: 200
    tools:
      - bash
      - str_replace_based_edit_tool
      - sequentialthinking
      - task_done

model_providers:
  openai:
    api_key: ${OPENROUTER_API_KEY}
    provider: openai
    base_url: https://openrouter.ai/api/v1

models:
  my_model:
    model_provider: openai
    model: deepseek/deepseek-v4-flash-free
    max_tokens: 4096
    temperature: 0.5
```

> ⚠️ 支援多種 Provider（Anthropic、OpenAI、Gemini、Doubao、Ollama 等）
> 可透過環境變數設定 API Key，不需寫死在設定檔中

#### 2d. 驗證設定

```bash
trae-cli show-config
# 預期輸出：顯示當前設定內容
```

#### 2e. 安裝 SKILL 檔案

本懶人包已附帶 SKILL 檔案於 `skills/30-trae-opencode/SKILL.md`，安裝後 AI Agent 會自動讀取。當你說「用 TRAE 幫我...」時，SKILL 會引導 AI 使用正確的 `trae-cli run` 命令。

---

### 步驟三：Trae IDE 用戶專用 — 安裝 OpenCode CLI

#### 3a. 安裝 OpenCode CLI

```bash
npm install -g opencode-ai
```

#### 3b. 驗證安裝

```bash
opencode --version
# 預期輸出：顯示版本資訊
```

#### 3c. 安裝 SKILL 檔案

本懶人包已附帶 SKILL 檔案於 `skills/30-trae-opencode/SKILL.md`，安裝後 TRAE Agent 會自動讀取。當你說「用 OpenCode 幫我...」時，SKILL 會引導 AI 使用正確的 `opencode run` 命令。

---

### 補充：公司 TRAE 帳號 vs. 本懶人包

很多使用者會混淆兩個「TRAE」：

| | VS Code TRAE 套件 | 公司 TRAE IDE | trae-agent（本懶人包） |
|--|------------------|--------------|---------------------|
| 產品 | VS Code 擴充套件（公司 SSO） | ByteDance AI IDE（完整編輯器） | 開源 CLI 工具（GitHub MIT） |
| 認證 | 公司 SSO | 公司 SSO | API Key（OpenRouter 等） |
| 用途 | VS Code 內 AI 輔助開發 | 獨立 IDE 開發 | 命令列軟體工程 Agent |
| 你需要哪個 | 日常 VS Code 寫程式 | 用 Trae IDE 寫程式 | 從 OpenCode 呼叫 TRAE 執行任務 |

#### 你有公司 TRAE 帳號，如何搭配本懶人包？

1. **直接使用 Trae IDE** — 登入後即可使用內建 AI Agent，不需額外設定
2. **在 Trae IDE 中驅動 OpenCode** — 安裝 opencode CLI（見步驟三），並將本 SKILL 檔案放入 Trae IDE 的 skills 目錄，在 Trae IDE 中說「用 OpenCode 幫我...」即可觸發
3. **在 OpenCode 中驅動 TRAE** — 走 trae-cli（已安裝），不受公司帳號影響

#### 注意

公司 TRAE 帳號無法用在 trae-cli 上，兩者是獨立認證系統。trae-cli 需要自己的 API Key（如 OpenRouter、Anthropic 等）。

---

### 步驟四：使用範例

#### OpenCode 用戶 — 用 OpenCode 驅動 TRAE

在 OpenCode 對話中輸入：

```
用 TRAE 分析這個專案的結構，幫我找出需要重構的模組
```

OpenCode 會透過 bash 執行 `trae-cli run "..."` 來執行任務。

你也可以直接指定參數：

```
幫我用 trae-cli 執行：Fix the bug in main.py --provider openai --model gpt-4o
```

#### Trae IDE 用戶 — 用 TRAE 驅動 OpenCode

在 TRAE Agent 對話中輸入：

```
用 OpenCode 分析這個專案的結構
```

TRAE Agent 會透過 bash 執行 `opencode run "..."` 來執行任務。

---

## 指令速查

### `trae-cli` 命令

| 命令 | 用途 |
|------|------|
| `run "任務"` | 執行軟體工程任務 |
| `interactive` | 互動式對話模式 |
| `show-config` | 顯示當前設定 |
| `tools` | 列出可用工具 |

### `trae-cli run` 常用選項

| 選項 | 範例 | 用途 |
|------|------|------|
| `--provider` / `-p` | `openai` | 指定 LLM Provider |
| `--model` / `-m` | `anthropic/claude-3-5-sonnet` | 指定模型 |
| `--working-dir` / `-w` | `./src` | 工作目錄 |
| `--max-steps` | `200` | 最大執行步數 |
| `--file` / `-f` | `task.txt` | 從檔案讀取任務 |
| `--must-patch` | (flag) | 強制產生 patch |
| `--trajectory-file` / `-t` | `debug.json` | 記錄執行軌跡 |

### `opencode` 常用命令

| 命令 | 用途 |
|------|------|
| `opencode run "訊息"` | 執行任務 |
| `opencode "路徑"` | 在指定目錄啟動 TUI |
| `opencode serve` | 啟動無頭伺服器 |
| `opencode session` | 管理對話 Session |
| `opencode providers` | 管理 AI Provider |

---

### 步驟五：驗證

1. **OpenCode 用戶**：
   - [ ] `trae-cli --version` 顯示版本號
   - [ ] `trae-cli show-config` 設定正確
   - [ ] 對 OpenCode 說「用 TRAE 幫我寫一個 Hello World」確認可運作

2. **Trae IDE 用戶**：
   - [ ] `opencode --version` 顯示版本號
   - [ ] 在 TRAE Agent 中測試呼叫 OpenCode 功能

---

## 完成回報格式

```md
## TRAE ↔ OpenCode 雙向驅動安裝完成

- 平台：OpenCode / Trae IDE
- CLI 版本：<trae-cli --version / opencode --version 輸出>
- 設定檔：~/.trae/trae_config.yaml
```

---

## 解除安裝

### OpenCode 用戶 — 移除 TRAE

```bash
# 移除 TRAE Agent
pip uninstall trae-agent -y

# 移除設定檔（選用）
rm -rf ~/.trae

# 移除原始碼（選用）
rm -rf trae-agent
```

### Trae IDE 用戶 — 移除 OpenCode

```bash
npm uninstall -g opencode-ai
```

---

## 常見問題

| 問題 | 解法 |
|------|------|
| `trae-cli` 找不到 | 確認 `pip install -e .` 成功，檢查 PATH 是否有 Python Scripts 目錄 |
| `opencode` 找不到 | 確認 `npm install -g opencode-ai` 成功，檢查 PATH 是否有 npm global bin |
| TRAE Agent 需要 API Key | 在 `trae_config.yaml` 中設定，或透過環境變數設定 |
| `trae-cli` 報 `ModuleNotFoundError` | 執行 `pip install docker pexpect` 補安裝缺少的依賴 |
| trae-agent 能否搭配 OpenRouter / NVIDIA 使用？ | 有限支援 — 見「已知限制」 |
| Windows 用戶注意事項 | 需 Python 3.12+、Node.js 18+、uv |

---

## 已知限制

### trae-agent 底層 API 相容性

trae-agent 使用 OpenAI 新版 **Responses API**（`responses.create()`），而非傳統的 Chat Completions API。這導致以下限制：

| API 服務 | 相容性 | 原因 |
|----------|--------|------|
| OpenAI 直連 | ✅ 原生支援 | Responses API 原生支援 |
| Anthropic 直連 | ✅ 原生支援 | 走 Anthropic SDK |
| OpenRouter（`provider: openai`） | ⚠️ 有限支援 | 僅部分模型支援 Responses API |
| NVIDIA（`provider: openai`） | ❌ 不相容 | NVIDIA API 僅支援 Chat Completions |
| 其他 OpenAI 相容服務 | ⚠️ 需測試 | 需確認是否支援 Responses API |

### Windows 編碼問題

trae-agent 使用 `rich` 套件輸出終端訊息，在繁體中文 Windows（cp950）環境下會因 Unicode 字元（如 ✅）導致編碼錯誤。此問題不影響 macOS/Linux 用戶。解決方式：使用 `--console-type simple` 可部分緩解。

### 建議

若你的 LLM API 是透過 OpenRouter、NVIDIA 等第三方代理服務，建議直接在 **OpenCode** 中使用（OpenCode 已正確支援這些服務），不需透過 trae-agent 中間層。

---

## 更新紀錄

| 日期 | 版本 | 更新內容 |
|------|------|---------|
| 2026-07-21 | v0.2 | 移除 MCP 註冊，改為純 CLI 呼叫；新增指令速查表、已知限制 |
| 2026-07-21 | v0.1 | 初版 |
