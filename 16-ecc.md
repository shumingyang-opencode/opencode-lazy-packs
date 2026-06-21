# OpenCode 懶人包 #16：ECC — Everything Claude Code 跨平台 Agent 系統

> 版本：v0.1
> 更新日期：2026-06-21

---

## 這個懶人包會幫你做什麼？

ECC 是一套跨 harness 的 AI Agent 作業系統，包含 **271 個技能、67 個子代理、92 個命令、17 個規則、27+ hooks**：

- 自動 clone 並安裝 ECC（211K+ stars 的開源專案）
- 為 OpenCode 進行完整配置（26 個子代理 + AGENTS.md）
- 設定 opencode.json 權限
- 驗證安裝狀態

安裝後你可以在 OpenCode 中使用 ECC 的 271 個技能來處理各種開發任務，
包括程式碼審查、安全掃描、TDD 引導、架構規劃、文件更新等。

---

## 先備條件

- [ ] Node.js 18+ 已安裝
- [ ] npm / yarn 可用
- [ ] Git 已安裝
- [ ] 網路連線（首次 clone + install 需要）

---

## 請 OpenCode 幫我執行以下步驟

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

### 步驟三：設定 opencode.json 權限

編輯 `~/.config/opencode/opencode.json`，在 `permission.skill` 加入：

```json
"ecc": "allow"
```

### 步驟四：導入 ECC 的 AGENTS.md

ECC 提供的 AGENTS.md 包含 26 個 OpenCode 子代理設定（規劃、架構、Review、安全、TDD 等）：

```bash
cp ~/.ecc/AGENTS.md ./AGENTS.md
```

### 步驟五：驗證安裝

```bash
npx ecc status
```

預期看到類似輸出（顯示安裝狀態與已安裝元件清單）。

---

## ECC 提供哪些功能？

### Skills（271 個工作流技能）

| 分類 | 技能舉例 |
|------|---------|
| 語言 | typescript, python, golang, rust, kotlin, java, swift, cpp, csharp, php, perl, dart-flutter, fsharp |
| 框架 | django, springboot, laravel, quarkus, react, vue, angular, nestjs, fastapi, nextjs |
| 領域 | backend-patterns, frontend-patterns, api-design, database-migrations, e2e-testing |
| AI/ML | mle-workflow, pytorch-build-resolver, foundation-models-on-device, cost-aware-llm-pipeline |
| 安全 | security-review, security-scan, hipaa-compliance, healthcare-phi-compliance |
| 商業 | article-writing, content-engine, market-research, investor-materials, brand-voice |
| 影片 | videodb, manim-video, remotion-video-creation, fal-ai-media |
| 加密 | defi-amm-security, evm-token-decimals, prediction-market |
| 學習 | continuous-learning, iterative-retrieval, skill-scout, prompt-optimizer |
| 基礎設施 | autonomous-loops, verification-loop, docker-patterns, terminal-ops, github-ops |

### 子代理（67 個）

planner, architect, tdd-guide, code-reviewer, security-reviewer, spec-miner,
build-error-resolver, e2e-runner, refactor-cleaner, doc-updater, 以及各語言的
reviewer 和 build-resolver（cpp, go, kotlin, python, django, java, rust, typescript 等）

### 規則與 Hooks

- 17 個規則檔案涵蓋 12 個語言生態系（安全、風格、測試強制）
- 27+ hooks：PreToolUse, PostToolUse, Stop, Error 等事件自動化

---

## 使用方式

| 情境 | 指令 |
|------|------|
| 查看安裝狀態 | `npx ecc status` |
| 診斷問題 | `npx ecc doctor` |
| 修復設定 | `npx ecc repair` |
| 列出已安裝元件 | `npx ecc list-installed` |
| 查看可用技能 | `ls ~/.ecc/skills/` |
| 觸發 ECC 技能 | 在對話中說 `ecc` |

---

## 完成回報格式

```md
## ECC 安裝完成

- git clone + npm install：✅ 成功 / ❌ 失敗
- npx ecc-install --target opencode：✅ 成功 / ❌ 失敗
- opencode.json 權限：✅ ecc: allow
- AGENTS.md 導入：✅ 已複製
- npx ecc status：✅ 正常 / ❌ 異常
```

---

## 常見問題

| 問題 | 解法 |
|------|------|
| `npx ecc-install` 找不到 | 先 `cd ~/.ecc && npm install` |
| `npx ecc status` 沒反應 | 確認 Node.js 18+ |
| 安裝太慢 | 使用 `--profile minimal` 只裝必要元件 |
| 不想裝全部技能 | `npx ecc consult "security" --target opencode` 選擇性安裝 |
| 想移除 | `cd ~/.ecc && node scripts/uninstall.js` |
| ECC 官網 | https://ecc.tools |
| 問題回報 | Discord：https://discord.gg/36yGMHGFbR |

---

## 更新紀錄

| 日期 | 版本 | 更新內容 |
|------|------|---------|
| 2026-06-21 | v0.1 | 初版 |
