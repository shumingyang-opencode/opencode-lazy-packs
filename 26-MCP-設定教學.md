# OpenCode 懶人包 #26：MCP 設定教學

> 版本：v0.1
> 更新日期：2026-06-26

---

## 這個懶人包會幫你做什麼？

這不是安裝工具，而是**互動式教學**。我會引導你了解 MCP（Model Context Protocol）的原理，並依你的需求逐步設定或建立 MCP 伺服器，讓 OpenCode 能連接外部工具與服務。

---

## 先備條件

- [ ] 已完成 **懶人包 #00：環境建置**（OpenCode 已安裝）
- [ ] 有一個想要連接的外部服務（資料庫、API、瀏覽器等）

---

## 請 OpenCode 幫我執行以下步驟

### 步驟一：理解 MCP

MCP（Model Context Protocol）是 AI agent 與外部工具之間的通訊協定。你可以把它想像成 AI 版本的 USB——統一介面，讓不同工具都能即插即用。

**為什麼需要 MCP？**

OpenCode 本身只能操作文字與檔案。當你需要它：
- 操作瀏覽器 → 需要 Playwright MCP
- 讀寫資料庫 → 需要 Firebase / PostgreSQL MCP
- 操作 JIRA → 需要 mcp-atlassian
- 發送訊息 → 需要飛書 MCP

這些全部透過 MCP 協定連接，你可以在 opencode.json 中統一設定。

**已經安裝在本 repo 的 MCP：**

| 懶人包 | MCP 服務 | 用途 |
|--------|---------|------|
| #01 | NotebookLM | 操作 Google NotebookLM |
| #08 | Firebase | Firebase 專案管理 |
| #09 | Playwright | 瀏覽器自動化 |
| #09 | open-computer-use | 桌面 UI 控制 |
| #10 | obsidian | 讀寫 Obsidian vault |
| #20 | mcp-atlassian | JIRA + Confluence |
| #21 | trac-mcp-server | Trac Ticket/Wiki |
| #22 | codebase-memory-mcp | 程式碼知識圖譜 |

> 你想連接什麼類型的服務？
> 1. 瀏覽器控制（像 Playwright）
> 2. 資料庫（Firebase、PostgreSQL）
> 3. 專案管理工具（JIRA、Trac）
> 4. 第三方 API（天氣、翻譯、地圖）
> 5. 自訂工具（我有一個特殊需求）
> 6. 還不確定，先了解有什麼選項

---

### 步驟二：MCP 的三種連線模式

OpenCode 支援三種 MCP type，你需要根據服務類型選擇：

**① local — 本機執行**

適合安裝在本機的命令列工具。OpenCode 直接執行一個指令來啟動 MCP server。

```json
{
  "mcp": {
    "playwright": {
      "type": "local",
      "command": ["npx", "-y", "@playwright/mcp"],
      "enabled": true
    }
  }
}
```

使用時機：工具已安裝在本機、有 CLI 指令可以直接執行。

**② stdio — 標準輸入輸出**

適合 Python、Node.js 或其他語言寫的 MCP server 程式。透過標準輸入輸出與 MCP server 通訊。

```json
{
  "mcp": {
    "trac-mcp": {
      "type": "stdio",
      "command": ["trac-mcp"],
      "args": ["--app", "myapp"],
      "enabled": true
    }
  }
}
```

使用時機：你有一個自行開發或從網路下載的 MCP server 程式。

**③ http — 遠端 API**

適合雲端服務或公司內網的 API。透過 HTTP 請求與遠端 MCP server 通訊。

```json
{
  "mcp": {
    "weather-api": {
      "type": "http",
      "url": "https://api.weather.com/mcp",
      "headers": {
        "Authorization": "Bearer <token>"
      },
      "enabled": true
    }
  }
}
```

使用時機：服務在遠端伺服器上，透過 HTTP 連接。

> 你的服務適合哪一種 type？如果不確定，告訴我你的服務是：
> - 本機安裝的工具 → local
> - 自己寫的程式 → stdio
> - 雲端 API → http

---

### 步驟三：了解 opencode.json 的 MCP 設定結構

MCP 設定寫在 `~/.config/opencode/opencode.json`（全域）或 `<專案>/opencode.json`（專案層級）。

完整的設定欄位說明：

```json
{
  "mcp": {
    "<服務名稱>": {
      "type": "local|stdio|http",
      "command": ["指令", "參數"],
      "args": ["額外參數"],
      "url": "https://...",
      "headers": { "Authorization": "Bearer ..." },
      "env": { "API_KEY": "xxx" },
      "enabled": true
    }
  }
}
```

各欄位用途：

| 欄位 | 適用 type | 說明 | 必填 |
|------|----------|------|------|
| `type` | 全部 | 連線模式（local / stdio / http） | ✅ |
| `command` | local, stdio | 啟動 MCP server 的指令陣列 | local/stdio 必填 |
| `args` | local, stdio | 傳遞給 command 的額外參數 | 選填 |
| `url` | http | MCP server 的 URL | http 必填 |
| `headers` | http | HTTP 請求標頭 | 選填 |
| `env` | local, stdio | 環境變數設定 | 選填 |
| `enabled` | 全部 | 是否啟用（false 可暫時關閉） | 選填，預設 true |

> 注意：`command` 和 `args` 用陣列格式，不要寫成字串。
> 正確：`["npx", "-y", "@playwright/mcp"]`
> 錯誤：`"npx -y @playwright/mcp"`

---

### 步驟四：動手設定 — 以你的需求為例

現在根據你的實際需求來設定。以下用三種常見場景示範：

**場景 A：連接 Playwright（瀏覽器控制）**

```json
{
  "mcp": {
    "playwright": {
      "type": "local",
      "command": ["npx", "-y", "@playwright/mcp"],
      "enabled": true
    }
  }
}
```
安裝後 OpenCode 就能操作瀏覽器。

**場景 B：連接 Firebase（資料庫管理）**

```json
{
  "mcp": {
    "firebase": {
      "type": "stdio",
      "command": ["npx", "-y", "firebase-mcp"],
      "env": {
        "FIREBASE_PROJECT_ID": "your-project-id",
        "FIREBASE_CLIENT_EMAIL": "your-client-email",
        "FIREBASE_PRIVATE_KEY": "your-private-key"
      },
      "enabled": true
    }
  }
}
```
注意：敏感資訊（API Key、Token）放在 `env` 區塊，不要寫死在 `command` 或 `args` 中。

**場景 C：連接一個自訂 HTTP API**

```json
{
  "mcp": {
    "my-api": {
      "type": "http",
      "url": "https://api.my-service.com/mcp",
      "headers": {
        "Authorization": "Bearer <your-token>"
      },
      "enabled": true
    }
  }
}
```

> 以上哪個場景最接近你的需求？或者告訴我你的具體服務是什麼，我幫你產生對應的設定。

---

### 步驟五：環境變數的安全性

設定 MCP 時，你可能需要提供 API Key、Token 或密碼。請遵循以下安全原則：

**不安全（不要這樣做）：**
```json
{
  "command": ["my-tool", "--api-key=sk-123456789"]
}
```

**安全（這樣做）：**
```json
{
  "command": ["my-tool"],
  "env": {
    "API_KEY": "sk-123456789"
  }
}
```

**更安全（從環境變數讀取）：**
```json
{
  "command": ["my-tool"],
  "env": {
    "API_KEY": "${MY_API_KEY}"
  }
}
```
然後在 shell profile（`.zshrc`、`.bashrc`）中設定 `export MY_API_KEY=sk-xxx`。

建議事項：
- Token / PAT 僅存放在 `~/.config/opencode/opencode.json` 的 MCP 環境變數中
- 不要將含有 Token 的 opencode.json 提交到 Git
- 優先使用 `${VAR}` 語法從系統環境變數讀取

---

### 步驟六：驗證 MCP 是否正常運作

編輯完成後，重啟 OpenCode，然後問它：

> 你現在有哪些 MCP 工具可以用？

如果設定正確，OpenCode 會列出所有可用的 MCP 工具。

**常見問題排查：**

| 問題 | 可能原因 | 解法 |
|------|---------|------|
| MCP 工具沒出現 | JSON 格式錯誤 | 檢查 opencode.json 最後一項是否有多餘逗號 |
| `command not found` | 指令不在 PATH | 使用完整路徑，或用 `npx` 執行 |
| 連線逾時 | 網路問題或服務未啟動 | 確認服務端正常運作 |
| 權限錯誤 | API Key 過期或不正確 | 重新產生並更新 env 設定 |
| type 設定錯誤 | local/stdio/http 選錯 | 檢查你的服務類型 |

---

### 步驟七：自行撰寫一個 MCP Server（進階）

如果市面上沒有現成的 MCP server 符合你的需求，可以自己寫一個。以下是最簡的 Python MCP server 範例：

```python
#!/usr/bin/env python3
"""最簡 MCP Server 範例 — 提供一個 hello 工具"""

import sys
import json

def handle_request(request):
    """處理 MCP 請求"""
    method = request.get("method")
    params = request.get("params", {})

    if method == "initialize":
        return {
            "protocolVersion": "2024-11-05",
            "capabilities": {
                "tools": {
                    "hello": {
                        "description": "打招呼",
                        "inputSchema": {
                            "type": "object",
                            "properties": {
                                "name": {
                                    "type": "string",
                                    "description": "你的名字"
                                }
                            },
                            "required": ["name"]
                        }
                    }
                }
            }
        }
    elif method == "tools/call":
        tool_name = params.get("name")
        if tool_name == "hello":
            name = params.get("arguments", {}).get("name", "World")
            return {
                "content": [
                    {"type": "text", "text": f"哈囉，{name}！這是你的第一個 MCP Server。"}
                ]
            }
    return {"error": {"code": -32601, "message": "Method not found"}}

def main():
    """透過標準輸入輸出與 OpenCode 通訊"""
    for line in sys.stdin:
        try:
            request = json.loads(line)
            response = handle_request(request)
            print(json.dumps(response), flush=True)
        except json.JSONDecodeError:
            continue

if __name__ == "__main__":
    main()
```

將這個檔案存為 `hello_mcp.py`，然後在 opencode.json 中加入：

```json
{
  "mcp": {
    "hello-mcp": {
      "type": "stdio",
      "command": ["python3", "/path/to/hello_mcp.py"],
      "enabled": true
    }
  }
}
```

重啟 OpenCode 後，問它「用 hello-mcp 跟小明打招呼」，就能看到效果。

---

## 完成回報格式

```md
✅ MCP 伺服器已設定完成！
- 服務名稱：<name>
- 連線類型：<local/stdio/http>
- 設定位置：<全域/專案>
- 工具數量：<N> 個
- 驗證結果：✅ OpenCode 正確讀取
- 使用方式：說「幫我<操作>」
```

---

## 常見問題

| 問題 | 解法 |
|------|------|
| MCP Server 跟 Plugin 有什麼不同？ | MCP 是跨 agent 通訊協定，Plugin 是 OpenCode 專屬的擴充機制 |
| 可以同時設定多個 MCP Server 嗎？ | 可以，opencode.json 的 `mcp` 區塊可以包含多個服務 |
| 如何暫時停用某個 MCP？ | 將 `enabled` 設為 `false`，保留設定但不啟用 |
| MCP 工具太多會不會影響效能？ | 不會，OpenCode 只在需要時才呼叫對應的 MCP server |
| 如何查看 MCP 的日誌？ | 執行 `opencode --verbose` 啟動，可以看到 MCP 的連線狀態 |
| 環境變數可以在 opencode.json 中直接寫嗎？ | 可以，但建議用 `${VAR}` 從系統環境變數讀取，避免洩漏 |

## Trae 對應操作

本懶人包為教學性質，無需安裝任何工具，OpenCode 與 Trae 皆適用。

---

## 更新紀錄

| 日期 | 版本 | 更新內容 |
|------|------|---------|
| 2026-06-26 | v0.1 | 初版 |
