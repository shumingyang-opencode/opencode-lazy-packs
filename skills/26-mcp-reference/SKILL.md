---
name: mcp-reference
description: 互動式 MCP 設定教學 — 從概念到實作，引導選擇連線模式（local/stdio/http）、設定 opencode.json、安全性原則，以及自行撰寫 MCP Server。說「MCP 教學」「MCP 設定」「連接外部工具」時載入。
---

# MCP 設定教學

互動式教學，引導使用者設定或建立 MCP 伺服器。

## 步驟

1. **詢問**要連接什麼服務（瀏覽器 / 資料庫 / API / 自訂工具）
2. **說明**三種 MCP type（local / stdio / http）的原理與適用場景
3. **逐步**引導編輯 opencode.json 設定檔
4. **強調**環境變數安全性（Token 放 env 區塊，不寫死在 command）
5. **驗證**重啟 OpenCode 確認 MCP 工具已載入
6. **進階**提供最簡 Python MCP Server 範例並逐行解釋
7. **詢問**是否要註冊到 MCP Registry

詳細內容見根目錄的 [26-MCP-設定教學.md](../../26-MCP-設定教學.md)。
