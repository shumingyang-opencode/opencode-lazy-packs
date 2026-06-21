---
name: ecc
description: ECC（Everything Claude Code）— 跨 harness AI Agent 作業系統。
             271 個技能、67 個子代理、92 個命令、17 個規則檔案，
             支援 Claude Code / Codex / Cursor / OpenCode / Gemini 等 8+ 平台。
             說「ecc」「安裝 ecc」「everything claude code」「ECC 工具」時載入。
---

# ECC — Everything Claude Code 跨平台 Agent 系統

> 開源 MIT、211K+ stars、230+ contributors
> 官網：https://ecc.tools | GitHub：https://github.com/affaan-m/ECC

## 安裝步驟

### 前置需求

- [ ] Node.js 18+ 已安裝
- [ ] npm / yarn 可用
- [ ] Git 已安裝

### 步驟一：Clone ECC 倉庫

```bash
git clone https://github.com/affaan-m/ECC.git ~/.ecc
cd ~/.ecc
npm install
```

### 步驟二：執行 OpenCode 專屬安裝

```bash
npx ecc-install --profile full --target opencode
```

或使用最小安裝：
```bash
npx ecc-install --profile minimal --target opencode
```

### 步驟三：設定 opencode.json 權限

ECC 安裝器會自動在 `~/.config/opencode/opencode.json` 加入設定。
若未自動完成，手動加入：

```json
"ecc": "allow"
```

### 步驟四：設定專案 AGENTS.md

ECC 提供 OpenCode 專用的 AGENTS.md（含 26 個子代理設定）：

```bash
cp ~/.ecc/AGENTS.md ./AGENTS.md
```

### 步驟五：驗證安裝

```bash
npx ecc status
```

或檢查技能目錄：
```bash
ls ~/.ecc/skills/ | head -10
```

## 提供的功能

| 類別 | 數量 | 說明 |
|------|------|------|
| Skills | 271 | 語言/框架/領域專用工作流程 |
| 子代理 | 67 | 規劃、架構、Review、安全、TDD 等 |
| 命令 | 92 | 斜線命令（legacy，可選） |
| 規則 | 17 | 永遠遵循的準則（安全、風格、測試） |
| Hooks | 27+ | Pre/Post tool use、Stop、Error 自動化 |
| MCP 配置 | 多個 | Chrome DevTools、資料庫等 |
| 支援平台 | 8+ | Claude Code, Codex, Cursor, OpenCode, Gemini, Zed, Copilot |

## 使用方式

安裝後在對話中說「ecc」觸發技能。

主要 ECC CLI 命令：

```bash
npx ecc status          # 查看安裝狀態
npx ecc doctor          # 診斷問題
npx ecc repair          # 修復損壞設定
npx ecc list-installed  # 列出已安裝元件
```

## 完成回報格式

```md
## ECC 安裝完成

- git clone + npm install：✅ 成功
- npx ecc-install --target opencode：✅ 成功
- opencode.json 權限：✅ ecc: allow
- AGENTS.md 導入：✅ 成功
- npx ecc status：✅ 正常
```

## 參考資源

- 官網：https://ecc.tools
- GitHub：https://github.com/affaan-m/ECC
- Discord：https://discord.gg/36yGMHGFbR
- NPM：`ecc-universal`、`ecc-agentshield`
- Pro 版：$19/seat/mo（私有 repo GitHub App）
