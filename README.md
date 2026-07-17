[**English**]() | [**繁体中文**](README.zh-TW.md) | [**简体中文**](README.zh-CN.md)

---

[[_TOC_]]

# Agents Lazy Packs

> Supports **OpenCode**, **Trae IDE**, **Codex** and more.
> Each pack includes install, update and removal instructions for each platform.

---

## How to Use

### Method 1: Let AI Install for You (Easiest)

Paste this line to your AI agent:

```
This is the Agents Lazy Packs repo https://gitlab.ovt.com:8081/steven.yang/agents-lazy-packs
Please read the repo content, list all available packs, and ask me which ones to install.
```

The AI will:
1. Read the repo's `SKILL.md` (entry point)
2. List all 25 packs
3. Ask which ones you want to install (or "all")
4. Automatically install your selection

### Method 2: One-Line CLI Install (OpenCode)

```bash
npx skills add https://gitlab.ovt.com:8081/steven.yang/agents-lazy-packs --skill <skill-name> -g -y
```

Available skill names:

| Skill Name | Corresponding Pack |
|------------|-------------------|
| `00-env-setup` | Environment Setup |
| `02-github` | Connect GitHub |
| `03-svn` | Connect Company SVN |
| `04-gitlab-internal` | Connect Company GitLab |
| `05-gitlab-personal` | Connect Personal GitLab |
| `06-obsidian` | Connect Obsidian |
| `07-second-brain` | Second Brain Setup |
| `09-browser` | Browser Control |
| `10-workflow-skills` | Start/Shutdown Workflow Skills |
| `12-markitdown` | Document Conversion (MarkItDown) |
| `13-graphify` | Knowledge Graph (Graphify) |
| `14-awesome-design-md` | Brand Design (Awesome DESIGN.md) |
| `15-ui-ux-pro-max` | UI/UX Pro Max Design Intelligence |
| `16-superpowers` | Superpowers — Full AI SDLC (14 skills, 1.9M installs) |
| `17-find-skills` | Find Skills — Search & Install 5000+ Skills |
| `18-frontend-design` | Frontend Design — Distinctive UI by Anthropic |
| `19-feishu-lark` | Feishu/Lark Integration — Docs/Messages/Calendar/Base |
| `20-jira-confluence` | Company JIRA & Confluence — Issue & Page Management |
| `21-trac` | Company Trac — Ticket & Wiki Management |
| `22-codebase-memory-mcp` | Codebase Memory MCP — Code Knowledge Graph (158 langs, Cypher) |
| `23-project-plan-feature` | Feature Planning — 10-Step Plan + init_plan.py |
| `24-skill-reference` | Interactive SKILL.md Creation Tutorial |
| `25-agents-reference` | Interactive AGENTS.md Creation Tutorial |
| `26-mcp-reference` | Interactive MCP Setup Tutorial |
| `27-gen-pptx` | Presentation Generator — Spec/Repo → Editable .pptx |
| `28-cli-anything` | CLI-Anything — 50+ Agent-native CLI Harnesses (Blender, GIMP, Obsidian, etc.) |

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

> For global MCP settings, edit `~/.cursor/mcp.json` (compatible with Cursor).

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
| #04 Connect Company GitLab | GitLab URL, SSH settings |
| #05 Connect Personal GitLab | GitLab URL, auth method |
| #06 Connect Obsidian | Vault root path |
| #20 JIRA & Confluence | JIRA / Confluence URL |
| #21 Trac | Trac URL, login |

### Security Notice

PAT / Tokens should **NOT** be written to this file. Store them in your platform config:

- **OpenCode**: `~/.config/opencode/opencode.json` MCP environment variables
- **Trae IDE**: `.trae/mcp.json` or `~/.cursor/mcp.json` env block

See the template's "Operation Rules" and "Security Rules" for details.

---

## Agent Setup Reference

| Item | OpenCode | Trae IDE |
|------|----------|----------|
| Install | `npm install -g opencode-ai` | Download from trae.ai |
| Global Config | `~/.config/opencode/opencode.json` | `~/.cursor/mcp.json` |
| Project Instruction File | `AGENTS.md` | `AGENTS.md` / `.trae/rules/` |
| MCP Configuration | Edit opencode.json | Edit `.trae/mcp.json` |
| Skill Mechanism | Native (SKILL.md) | `.trae/skills/` |
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
| ~~01~~ | ~~Connect NotebookLM~~ | ~~MCP~~ | ~~v0.2~~ | ~~NotebookLM MCP - AI presentations, audio, reports~~ | ~~Removed~~ |
| 02 | [Connect GitHub](02-連接-GitHub.md) | MCP | v0.2 | GitHub CLI auth + GitHub Pages publishing | ✅ |
| 03 | [Connect Company SVN](03-連接-公司SVN.md) | MCP | v0.2 | OmniVision internal SVN server setup | ✅ |
| 04 | [Connect Company GitLab](04-連接-公司GitLab.md) | MCP | v0.1 | Connect via SSH key to internal GitLab | ✅ |
| 05 | [Connect Personal GitLab](05-連接-個人GitLab.md) | MCP | v0.2 | Connect via HTTPS + PAT to GitLab.com | ✅ |
| 06 | [Connect Obsidian](06-建立第二大腦-Obsidian.md) | MCP | v0.3 | Obsidian MCP Vault - notes, search, management | ✅ |
| 07 | [Second Brain Setup Guide](07-第二大腦設定指南.md) | Tutorial | v0.2 | Obsidian 3-layer dir structure + templates | — |
| ~~08~~ | ~~Connect Firebase~~ | ~~MCP~~ | ~~v0.1~~ | ~~Firebase MCP - project management, database, deploy~~ | ~~Removed~~ |
| 09 | [Install Browser Control](09-安裝瀏覽器控制.md) | MCP | v0.3 | Playwright MCP + macOS desktop UI automation | ✅ |
| 10 | [Start/Shutdown/Init Skills](10-開工收工初始化技能.md) | Skill | v0.3 | 3 global skills + weekly-report extension: startup (multi-session), shutdown (structured log), project-init, weekly-report | ✅ |
| ~~11~~ | ~~Draw Skill~~ | ~~Skill~~ | ~~v0.3~~ | ~~draw skill: OpenAI gpt-image-2 image generation~~ | ~~Removed~~ |
| 12 | [MarkItDown Document Convert](12-markitdown.md) | Skill | v0.3 | Auto-convert PDF/Office/CSV/JSON/Image/Audio to MD | ✅ |
| 13 | [Graphify Knowledge Graph](13-graphify.md) | Skill | v0.1 | Code knowledge graph engine - NL queries replace grep | ✅ |
| 14 | [Awesome DESIGN.md Brand Design](14-awesome-design-md.md) | Skill | v0.1 | One-click apply 73 real brand DESIGN.md files | ✅ |
| 15 | [UI/UX Pro Max Design Intelligence](15-ui-ux-pro-max.md) | Skill | v0.1 | 67 styles + 161 rules + 57 fonts + 99 UX guides | ✅ |
| 16 | [Superpowers Full AI SDLC](16-superpowers.md) | Skill | v6.0.3 | 14 skills: brainstorm→plan→TDD→review→merge (1.9M+) | ✅ |
| 17 | [Find Skills](17-find-skills.md) | Skill | v0.1 | Search & install from 5000+ open skills | ✅ |
| 18 | [Frontend Design](18-frontend-design.md) | Skill | v0.1 | By Anthropic (572K installs) - non-template UI design | ✅ |
| 19 | [Install Feishu/Lark](19-安裝-飛書Lark.md) | Skill | v0.1 | Feishu docs/messages/groups/calendar/Base/OA | ✅ |
| 20 | [Install JIRA & Confluence](20-公司-jira-confluence.md) | MCP | v0.3 | mcp-atlassian: Issue & page search/management | ✅ |
| 21 | [Install Trac](21-公司-trac.md) | MCP | v0.2 | Trac ticket & wiki management, full-text search | ✅ |
| 22 | [Codebase Memory MCP](22-codebase-memory-mcp.md) | MCP | v0.1 | Code knowledge graph: 158 langs, Hybrid LSP, Cypher | ✅ |
| 23 | [Feature Planning Skill](23-功能規劃技能.md) | Skill | v0.1 | 10-step planning + init_plan.py + codebase check | ✅ |
| 24 | [SKILL.md Creation Tutorial](24-SKILL.md-建立教學.md) | Tutorial | v0.1 | Interactive guide: create your first OpenCode skill | — |
| 25 | [AGENTS.md Creation Tutorial](25-AGENTS.md-建立教學.md) | Tutorial | v0.1 | Interactive guide: customize project AGENTS.md | — |
| 26 | [MCP Setup Tutorial](26-MCP-設定教學.md) | Tutorial | v0.1 | Interactive guide: MCP concepts, modes, security | — |
| 27 | [Presentation Generator](27-通用簡報產製.md) | Skill | v0.1 | 6-engine workflow: docs/repo/spec → editable .pptx | ✅ |
| 28 | [Install CLI-Anything](28-安裝-CLI-Anything.md) | Skill | v0.1 | 50+ agent-native CLI harnesses, cli-hub package mgr | ✅ |

---

## Tutorial Videos

Watch internal sharing tutorials at [AI Agent Tech Knowledge Base](https://steven.yang.pages.ovt.com/ai-agent-tech/)

| Topic | Description |
|-------|-------------|
| AI Fundamentals | Core AI concepts and principles |
| AI Agent Basics | Essential agent capabilities |
| Dev Tools Ecosystem | Practical AI development tools |
| CLI Tools | Command-line tool applications |
| MarkItDown | File conversion with MarkItDown |
| Dify LLM App Development | Build LLM applications with Dify |
| DuckDB Tutorials | Complete DuckDB database guide |
| Knowledge Graph | Graphify and knowledge graph tech |
| Loop Engineering | Large-scale structured engineering |
| MCP vs CLI | Comparing two tool paradigms |
| Token Optimization | Token optimization strategies |
| Agent Skills | AI Agent skill development |
| OpenCode Ecosystem | OpenCode tools and ecosystem |
| OpenCode Series | OpenCode hands-on tutorials |
| Karpathy Lectures | Deep learning series by Karpathy |
| AI Briefing Revolution | AI-powered presentation creation |

---

## Feedback

- **Issues / Feature Requests**: [GitLab Issues](https://gitlab.ovt.com:8081/steven.yang/agents-lazy-packs/-/issues)

---

## Related Projects

- **Source**: [shumingyang-opencode/opencode-lazy-packs](https://github.com/shumingyang-opencode/opencode-lazy-packs) — Original reference
- **OpenCode**: [anomalyco/opencode](https://github.com/anomalyco/opencode) — The AI Coding Agent this pack serves
- **Trae IDE**: [trae.ai](https://www.trae.ai) — Another supported platform
