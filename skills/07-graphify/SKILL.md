---
name: graphify
description: 知識圖譜技能 — 將專案程式碼、文件、圖片、影片轉為可查詢的知識圖譜。
            支援 /graphify 命令。說「/graphify」「知識圖譜」「knowledge graph」
            「分析專案結構」「程式碼架構圖」時載入。
---

# Graphify 知識圖譜技能

將整個專案（程式碼、文件、PDF、圖片、影片）轉為知識圖譜，用自然語言查詢取代 grep。

## 使用方式

### 建立圖譜

在 OpenCode 對話中輸入：

```
/graphify .
```

或指定資料夾：

```
/graphify ./src
```

產出 `graphify-out/` 目錄：
- `graph.html` — 互動式 HTML 圖譜
- `GRAPH_REPORT.md` — 架構摘要報告
- `graph.json` — 完整圖譜資料

### 查詢圖譜

```
/graphify query "認證流程是怎樣的？"
/graphify path "UserService" "DatabasePool"
/graphify explain "RateLimiter"
```

### 增量更新

```
/graphify ./docs --update
```

## 輸出檔案

| 檔案 | 說明 |
|------|------|
| `graphify-out/graph.html` | 瀏覽器打開即可互動探索 |
| `graphify-out/GRAPH_REPORT.md` | 架構重點：god nodes、surprising connections、suggested questions |
| `graphify-out/graph.json` | 完整圖譜，可被工具重複查詢 |

## AI 使用流程

1. 當使用者輸入 `/graphify` 開頭的指令時，自動載入本技能
2. 判斷是建立圖譜（`.`) 還是查詢（`query`/`path`/`explain`）
3. 建立圖譜時，程式碼由 tree-sitter 本機解析（免費），文件/圖片由 LLM 提取語義
4. 查詢時優先讀取 `graphify-out/graph.json` 加速回應
5. 若 `GRAPH_REPORT.md` 存在，架構類問題可先參考報告再決定是否細查

## 技術說明

- 程式碼：tree-sitter AST 解析，36 種語言，本機執行無 API 成本
- 文件/PDF/圖片：透過 AI 模型做語義提取（消耗 token）
- 影片/音訊：faster-whisper 本機轉逐字稿
- 叢集演算法：Leiden 社群偵測
- 支援 ignore：`.graphifyignore`（語法同 `.gitignore`）
