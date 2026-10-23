[**English**]() | [**繁体中文**](README.zh-TW.md) | [**简体中文**](README.zh-CN.md)

---

[[_TOC_]]

# Agents Lazy Packs

> Supports **OpenCode**, **Trae IDE**, **Codex** and more.
> Each pack includes install, update and removal instructions for each platform.

---

## 安裝教學摘要

本 Repo 提供 30+ 個「懶人包」（Lazy Packs），讓你在 OpenCode / Trae IDE / Codex 等 AI 編碼工具中快速安裝各種技能與 MCP 服務。以下是三步驟快速上手：

**Step 1：環境建置**
- 安裝 OpenCode：`npm install -g opencode-ai`（需 Node.js 18+）
- 或安裝 Trae IDE：從 [trae.ai](https://www.trae.ai) 下載

**Step 2：MCP 串接**
- 將所需的 Lazy Pack（MD 檔案）內容貼給 AI，它會自動編輯對應的 MCP 設定檔
- OpenCode 設定檔路徑：`~/.config/opencode/opencode.json`
- Trae IDE 設定檔路徑：`.trae/mcp.json`

**Step 3：技能安裝**
- 對 AI 說「幫我安裝位在 `https://github.com/...` 的技能」即可一鍵安裝
- 或使用 CLI：`npx skills add https://github.com/shumingyang-opencode/opencode-lazy-packs --skill <skill-name> -g -y`

> 詳細各 Pack 的前置需求與操作步驟，請見 [SKILL.md](SKILL.md) 或各 Pack 的 MD 檔案。

## How to Use

### Method 1: Let AI Install for You (Easiest)

Paste this line to your AI agent:

```
This is the Agents Lazy Packs repo https://github.com/shumingyang-opencode/opencode-lazy-packs
Please read the repo content, list all available packs, and ask me which ones to install.
```

The AI will:
1. Read the repo's `SKILL.md` (entry point)
  2. List all 30 packs
3. Ask which ones you want to install (or "all")
4. Automatically install your selection

### Method 2: One-Line CLI Install (OpenCode)

```bash
npx skills add https://github.com/shumingyang-opencode/opencode-lazy-packs --skill <skill-name> -g -y
```

Available skill names:

| Skill Name | Corresponding Pack |
|------------|-------------------|
| `00-env-setup` | Environment Setup |
| ~~01-notebooklm~~ | ~~Connect NotebookLM~~ |
| `02-github` | Connect GitHub |
| `03-svn` | Connect Company SVN |
| `04-gitlab-internal` | Connect Company GitLab |
| `05-gitlab-personal` | Connect Personal GitLab |
| `06-obsidian` | Connect Obsidian |
| `07-second-brain` | Second Brain Setup |
| ~~08-firebase~~ | ~~Connect Firebase~~ |
| `09-browser` | Browser Control |
| `10-workflow-skills` | Start/Shutdown Workflow Skills |
| ~~11-draw~~ | ~~Draw Skill (OpenAI gpt-image-2)~~ |
| `12-markitdown` | Document Conversion (MarkItDown) |
| `13-graphify` | Knowledge Graph (Graphify) |
| `14-awesome-design-md` | Brand Design (Awesome DESIGN.md) |
| `15-ui-ux-pro-max` | UI/UX Pro Max Design Intelligence |
| `16-superpowers` | Superpowers — Full AI SDLC (14 skills, 1.9M installs) |
| `18-frontend-design` | Frontend Design — Distinctive UI by Anthropic |
| `19-feishu-lark` | Feishu/Lark Integration — Docs/Messages/Calendar/Base |
| `20-jira-confluence` | Company JIRA & Confluence — Issue & Page Management |
| `21-trac` | Company Trac — Ticket & Wiki Management |
| `23-project-plan-feature` | Feature Planning — 10-Step Plan + init_plan.py |
| `24-skill-reference` | Interactive SKILL.md Creation Tutorial |
| `25-agents-reference` | Interactive AGENTS.md Creation Tutorial |
| `26-mcp-reference` | Interactive MCP Setup Tutorial |
| `27-gen-pptx` | Presentation Generator — Spec/Repo → Editable .pptx |
| `30-trae-opencode` | TRAE ↔ OpenCode Bridge — Bidirectional CLI integration (bytedance/trae-agent) |

Once installed, just say the corresponding keyword to OpenCode.

### Method 3: Manual Install (Trae IDE)

If you use **Trae IDE**, each pack has a `## Trae 對應操作` section at the end explaining how to install, update, and remove the service.

```bash
# Example: add Obsidian to .trae/mcp.json:
# {
#   "mcpServers": {
#     "obsidian": {
#       "command": "npx",
#       "args": ["@bitbonsai/mcpvault", "<VAULT_PATH>"]
#     }
#   }
# }
```

> For global MCP settings, edit `%APPDATA%\Trae\User\mcp.json` (compatible with Cursor).

### Method 4: Manual Download (MD Files)

1. Download the corresponding lazy pack (MD file)
2. Open terminal and run `opencode` in your project directory (or open Trae IDE)
3. Paste the pack content to the AI — it will execute automatically

---

## Account & Service Configuration

The lazy pack system includes a **Central Account Management System** that lets the AI agent automatically read your service credentials without asking repeatedly.

### Features

- Create a single `.md` file to manage SVN, GitLab, GitHub, JIRA, Confluence, Feishu, etc.
- All OpenCode projects read this file via the global AGENTS.md rule before initialization
- Only asks when information is missing; answers are automatically persisted

### How to Enable

1. **Copy the template**: `個人帳號與服務清單.sample.md` → `個人帳號與服務清單.md`
2. **Fill in the blanks**: Replace all `<...>` placeholders with your actual info
3. **Place the file**: Put it in your **OpenCode workspace root** (recommended to be the same as your Obsidian vault root)
4. **Set global rules**: Create `~/.config/opencode/AGENTS.md` (see template footer for details)

### Built-in Pack Support

Some packs have a built-in "read account info" step that can use this file:

| Pack | Auto-reads |
|------|------------|
| #02 Connect GitHub | GitHub username |
| #03 Connect Company SVN | SVN URL, login |
| #04 Connect Company GitLab | GitLab URL, PAT credential |
| #05 Connect Personal GitLab | GitLab URL, auth method |
| #06 Connect Obsidian | Vault root path |
| #20 JIRA & Confluence | JIRA / Confluence URL |
| #21 Trac | Trac URL, login |

### Security Notice

PAT / Tokens should **NOT** be written to this file. Store them in your platform config:

- **OpenCode**: `~/.config/opencode/opencode.json` MCP environment variables
- **Trae IDE**: `.trae/mcp.json` or `%APPDATA%\Trae\User\mcp.json` env block

See the template's "Operation Rules" and "Security Rules" for details.

---

## Agent Setup Reference

| Item | OpenCode | Trae IDE |
|------|----------|----------|
| Install | `npm install -g opencode-ai` | Download from trae.ai |
| Global Config | `~/.config/opencode/opencode.json` | `%APPDATA%\Trae\User\mcp.json` |
| Project Instruction File | `AGENTS.md` | `AGENTS.md` / `.trae/rules/` |
| MCP Configuration | Edit opencode.json | Edit `.trae/mcp.json` |
| Skill Mechanism | `.agents/skills/` or `~/.agents/skills/` (global) | `.agents/skills/` or `~/.agents/skills/` (global) |
| Commands | `/` built-in commands | GUI interface |

---

## Minimum Prerequisites

- [ ] **OpenCode users**: Node.js 18+ installed
- [ ] **Trae IDE users**: Trae IDE installed from [trae.ai](https://www.trae.ai)
- [ ] Internet connection
- [ ] See each pack's prerequisites in the "前置需求" column of [SKILL.md](SKILL.md)

---

## Pack List (Supports OpenCode / Trae IDE / Codex etc.)

| # | Name | Type | Version | Description | Support |
|---|------|------|---------|-------------|---------|
| 00 | [Environment Setup](00-環境建置.md) | CLI | v0.3 | OpenCode + Node.js + uv basic env setup | ✅ |
| 01 | [Connect GitHub](01-連接-GitHub.md) | MCP | v0.4 | GitHub CLI auth + repo commit/push verification | ✅ |
| 02 | [Connect Personal GitLab](02-連接-個人GitLab.md) | MCP | v0.4 | Connect via HTTPS + PAT to GitLab.com | ✅ |
| 03 | [Connect Obsidian](03-建立第二大腦-Obsidian.md) | MCP | v0.3 | Obsidian MCP Vault - notes, search, management | ✅ |
| 04 | [Install Browser Control](04-安裝瀏覽器控制.md) | MCP | v0.3 | Playwright MCP + macOS desktop UI automation | ✅ |
| 05 | [Start/Shutdown/Init Skills](05-開工收工初始化技能.md) | Skill | v0.3 | 3 global skills + weekly-report extension: startup, shutdown, project-init, weekly-report | ✅ |
| 06 | [MarkItDown Document Convert](06-markitdown.md) | Skill | v0.3 | Auto-convert PDF/Office/CSV/JSON/Image/Audio to MD | ✅ |
| 07 | [Graphify Knowledge Graph](07-graphify.md) | Skill | v0.1 | Code knowledge graph engine - NL queries replace grep | ✅ |
| 08 | [Presentation Generator](08-通用簡報產製.md) | Skill | v0.1 | 6-engine workflow: docs/repo/spec → editable .pptx | ✅ |

---
## Feedback

- **Source**: https://github.com/mathruffian-dot/opencode-lazy-packs

---

## Related Projects

- **Source**: https://github.com/mathruffian-dot/opencode-lazy-packs
- **OpenCode**: [anomalyco/opencode](https://github.com/anomalyco/opencode) — The AI Coding Agent this pack serves
- **Trae IDE**: [trae.ai](https://www.trae.ai) — Another supported platform
