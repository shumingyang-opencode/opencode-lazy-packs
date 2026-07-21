# OpenCode 懶人包 #30：TRAE 與 OpenCode 雙向驅動

> 版本：v0.1
> 更新日期：2026-07-21

---

## 這個懶人包會幫你做什麼？

讓 **OpenCode** 與 **TRAE（trae-agent）** 可以互相驅動——根據你的平台自動決定安裝方向：

| 你的平台 | 安裝目標 | 效果 |
|---------|---------|------|
| **OpenCode** 用戶 | 安裝 TRAE Agent CLI → 註冊為 MCP Server | 在 OpenCode 中用 `trae-cli` 執行任務 |
| **Trae IDE** 用戶 | 安裝 OpenCode CLI → 註冊為 MCP Server | 在 TRAE Agent 中用 `opencode` 執行任務 |

### 雙向架構

```
┌─────────────┐      MCP       ┌──────────────────┐
│  OpenCode   │◄──────────────►│  trae-cli MCP    │
│  (AI Agent) │    Server       │  (trae-agent)    │
└─────────────┘                └──────────────────┘

┌─────────────┐      MCP       ┌──────────────────┐
│  TRAE Agent │◄──────────────►│  opencode MCP    │
│  (trae-cli) │    Server       │  (opencode-ai)   │
└─────────────┘                └──────────────────┘
```

### TRAE Agent 是什麼？

> 出處：ByteDance — https://github.com/bytedance/trae-agent
> ⭐ 11.9K Stars | MIT License
>
> Trae Agent 是字節跳動推出的 LLM-based 軟體工程 Agent，支援多種 LLM Provider（OpenAI、Anthropic、Doubao、Gemini、Ollama），內建 MCP 支援，可透過 `trae-cli` 命令列執行軟體工程任務。

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
| **OpenCode** | 安裝 `trae-agent`，註冊 MCP Server 到 OpenCode 設定檔 |
| **Trae IDE** | 安裝 `opencode` CLI，註冊 MCP Server 到 TRAE 設定檔 |

---

### 步驟二：選擇安裝層級

```
你希望這個整合安裝在：

1. 【全域層級】— 所有專案都能使用（建議）
2. 【專案層級】— 僅當前專案可用
```

根據你的選擇與平台，設定會寫入不同的位置：

| 層級 | OpenCode 用戶（寫入位置） | Trae IDE 用戶（寫入位置） |
|------|--------------------------|--------------------------|
| **全域** | `~/.config/opencode/opencode.json` | `~/.cursor/mcp.json` |
| **專案** | `./opencode.json` | `.trae/mcp.json` |

回答後請記錄：後續步驟會根據你的選擇使用對應路徑。

---

### 步驟三：OpenCode 用戶專用 — 安裝 TRAE Agent 並註冊 MCP

#### 3a. 安裝 TRAE Agent

**方式一：pip 安裝（建議）**
```bash
pip install trae-agent
```

**方式二：原始碼安裝**
```bash
git clone https://github.com/bytedance/trae-agent.git
cd trae-agent
uv sync --all-extras
```

#### 3b. 驗證安裝

```bash
trae-cli --version
# 預期輸出：顯示版本資訊
```

#### 3c. 設定 TRAE Agent

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
  anthropic:
    api_key: your_anthropic_api_key
    provider: anthropic
  openai:
    api_key: your_openai_api_key
    provider: openai

models:
  my_model:
    model_provider: anthropic
    model: claude-sonnet-4-20250514
    max_tokens: 4096
    temperature: 0.5
```

> ⚠️ 請填入你的 LLM API Key（支援 Anthropic、OpenAI、Gemini、Doubao、Ollama 等）
> 可透過環境變數 `ANTHROPIC_API_KEY` / `OPENAI_API_KEY` 等方式設定

#### 3d. 在 OpenCode 中註冊 TRAE 為 MCP Server

根據步驟二選擇的層級，設定目標路徑：

- **全域層級**：`TARGET_FILE=~/.config/opencode/opencode.json`
- **專案層級**：`TARGET_FILE=./opencode.json`

**Step 1 — 備份原始設定檔**
```bash
if [ ! -f "$TARGET_FILE" ]; then
  echo "⚠️ $TARGET_FILE 不存在，將建立新檔案"
  echo "{}" > "$TARGET_FILE"
fi
BACKUP_FILE="$TARGET_FILE.bak.$(date +%Y%m%d%H%M%S)"
cp "$TARGET_FILE" "$BACKUP_FILE" && echo "✅ 已備份至 $BACKUP_FILE"
```

**Step 2 — 使用 `jq` 安全寫入 MCP 設定**
```bash
jq '.mcp.trae = {
  "command": "trae-cli",
  "args": ["run"],
  "env": {}
}' "$TARGET_FILE" > "$TARGET_FILE.tmp" && mv "$TARGET_FILE.tmp" "$TARGET_FILE"
```

> 若 `jq` 不可用，可直接編輯目標檔案，在 `mcp` 區塊加入：
> ```json
> "trae": {
>   "command": "trae-cli",
>   "args": ["run"],
>   "env": {}
> }
> ```

**Step 3 — 驗證 JSON 語法**
```bash
if jq . "$TARGET_FILE" > /dev/null 2>&1; then
  echo "✅ JSON 語法驗證通過"
else
  echo "❌ JSON 語法錯誤！正在還原備份..."
  cp "$BACKUP_FILE" "$TARGET_FILE"
  echo "已自動還原至備份版本。請檢查設定檔後重試。"
  exit 1
fi
```

**Step 4 — 驗證 MCP 已註冊**
```bash
opencode mcp list 2>/dev/null | grep -q "trae" && echo "✅ TRAE MCP Server 已成功註冊"
```

---

### 步驟四：Trae IDE 用戶專用 — 安裝 OpenCode CLI 並註冊 MCP

#### 4a. 安裝 OpenCode CLI

```bash
npm install -g opencode-ai
```

#### 4b. 驗證安裝

```bash
opencode --version
# 預期輸出：顯示版本資訊
```

#### 4c. 在 TRAE Agent 設定中註冊 OpenCode 為 MCP Server

編輯 TRAE Agent 的設定檔（預設為 `trae_config.yaml`，路徑取決於你的安裝方式），在 `mcp_servers` 區塊加入：

```yaml
mcp_servers:
  opencode:
    command: npx
    args:
      - opencode-ai
    env:
      OPENCODE_THEME: dark
```

若使用 JSON 格式的 TRAE 設定，編輯對應的設定檔：

```json
{
  "mcp_servers": {
    "opencode": {
      "command": "npx",
      "args": ["opencode-ai"],
      "env": {}
    }
  }
}
```

#### 4d. 驗證

```bash
trae-cli show-config 2>/dev/null | grep -q "opencode" && echo "✅ OpenCode MCP 已註冊至 TRAE Agent"
```

---

### 步驟五：使用範例

#### OpenCode 用戶 — 用 OpenCode 驅動 TRAE

在 OpenCode 對話中輸入：

```
用 TRAE 分析這個專案的結構，幫我找出需要重構的模組
```

OpenCode 會呼叫 `trae-cli run "..."` 來執行任務，並將結果回傳給你。

你也可以直接要求：

```
幫我用 trae-cli 執行：Fix the bug in main.py --provider openai --model gpt-4o
```

#### Trae IDE 用戶 — 用 TRAE 驅動 OpenCode

在 TRAE Agent 中使用 OpenCode 的執行環境來執行特定任務。TRAE Agent 會透過 MCP 呼叫 `opencode` CLI 來執行。

---

### 步驟六：驗證

1. **OpenCode 用戶**：
   - [ ] `trae-cli --version` 顯示版本號
   - [ ] `opencode mcp list` 顯示 `trae` MCP Server
   - [ ] 對 OpenCode 說「用 TRAE 幫我寫一個 Hello World」確認可運作

2. **Trae IDE 用戶**：
   - [ ] `opencode --version` 顯示版本號
   - [ ] TRAE Agent 設定檔中包含 `opencode` MCP 區塊
   - [ ] 在 TRAE Agent 中測試呼叫 OpenCode 功能

---

## 完成回報格式

```md
## TRAE ↔ OpenCode 雙向驅動安裝完成

- 平台：OpenCode / Trae IDE
- 安裝層級：全域 / 專案
- 安裝方向：OpenCode 驅動 TRAE / TRAE 驅動 OpenCode
- CLI 版本：<trae-cli --version / opencode --version 輸出>
- MCP 註冊：已啟用
- 備份檔案：<備份路徑>
```

---

## 解除安裝

### OpenCode 用戶 — 移除 TRAE 整合

```bash
# 1. 移除 MCP 設定（使用 jq）
TARGET_FILE=~/.config/opencode/opencode.json  # 或 ./opencode.json
jq 'del(.mcp.trae)' "$TARGET_FILE" > "$TARGET_FILE.tmp" && mv "$TARGET_FILE.tmp" "$TARGET_FILE"

# 2. 移除 TRAE Agent
pip uninstall trae-agent -y

# 3. 移除設定檔（選用）
rm -rf ~/.trae
```

### Trae IDE 用戶 — 移除 OpenCode 整合

```bash
# 1. 從 TRAE 設定檔移除 MCP 區塊
# 編輯 trae_config.yaml，移除 mcp_servers.opencode 段落

# 2. 移除 OpenCode CLI
npm uninstall -g opencode-ai
```

---

## 常見問題

| 問題 | 解法 |
|------|------|
| `trae-cli` 找不到 | 確認 `pip install trae-agent` 成功，檢查 PATH 是否有 Python Scripts 目錄 |
| `opencode` 找不到 | 確認 `npm install -g opencode-ai` 成功，檢查 PATH 是否有 npm global bin |
| MCP Server 無法啟動 | 檢查環境變數 PATH 是否包含 CLI 所在目錄，嘗試用完整路徑 |
| TRAE Agent 需要 API Key | 在 `trae_config.yaml` 中設定，或透過環境變數 `ANTHROPIC_API_KEY` 等 |
| 無法同時使用 OpenCode 與 TRAE | 支援同時安裝兩個方向，依步驟三與步驟四分別執行即可 |
| Windows 用戶注意事項 | `pip install trae-agent` 在 Windows 下需 Python 3.12+；`opencode` 需 Node.js 18+ |

---

## Trae 對應操作

### 在 Trae 上安裝（TRAE 驅動 OpenCode）

此懶人包已包含 Trae IDE 的完整安裝步驟（步驟四），直接從步驟一開始執行即可。

### 在 Trae 上更新

```bash
# 更新 OpenCode CLI
npm update -g opencode-ai
```

### 在 Trae 上移除

見上方「解除安裝 — Trae IDE 用戶」章節。

---

## 更新紀錄

| 日期 | 版本 | 更新內容 |
|------|------|---------|
| 2026-07-21 | v0.1 | 初版 |
