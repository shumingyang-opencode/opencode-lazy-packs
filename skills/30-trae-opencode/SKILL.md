---
name: opencode-30-trae-opencode
description: >-
  安裝 TRAE & OpenCode 雙向驅動 — 讓 OpenCode 可透過 MCP 呼叫 TRAE Agent（trae-cli），
  或讓 TRAE Agent 可透過 MCP 呼叫 OpenCode CLI。說「安裝 TRAE 雙向驅動」
  「安裝 OpenCode TRAE 整合」「trae opencode 互通」時載入。
---

# TRAE ↔ OpenCode 雙向驅動安裝

讓 **OpenCode** 與 **TRAE（trae-agent）** 互相驅動 — 根據你的平台自動決定安裝方向。

出處：https://github.com/bytedance/trae-agent（⭐ 11.9K, MIT License）

## 安裝步驟

### 1. 確認使用者平台

先問使用者用的是 **OpenCode** 還是 **Trae IDE**。

- **OpenCode 用戶** → 安裝 `trae-agent`，註冊 MCP Server 到 OpenCode
- **Trae IDE 用戶** → 安裝 `opencode-ai`，註冊 MCP Server 到 TRAE Agent

### 2. 選擇安裝層級

問使用者：
```
你希望安裝在【全域層級】還是【專案層級】？
```

根據回答與平台決定路徑。

### 3. 執行安裝

**OpenCode 用戶：**

```bash
pip install trae-agent
```

**Trae IDE 用戶：**

```bash
npm install -g opencode-ai
```

### 4. 註冊 MCP Server

依照目標平台的設定格式，將對應的 CLI 註冊為 MCP Server。

詳細步驟請見根目錄的 [30-TRAE-OpenCode-雙向驅動.md](../../30-TRAE-OpenCode-雙向驅動.md)。

## 使用方式

安裝後，在相對應的 AI Agent 中即可呼叫對方的 CLI 執行任務。
