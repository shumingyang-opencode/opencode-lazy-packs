[**English**](README.md) | [**繁体中文**](README.zh-TW.md) | [**简体中文**]()

---

[[_TOC_]]

# Agents 懒人包

> 支持 **OpenCode**、**Trae IDE**、**Codex** 等多平台。
> 每个懒人包内含各平台的安装、更新、移除说明。

---

## 使用方式

### 方式一：直接让 AI 帮你装（最简单）

把这行贴给你的 AI agent：

```
这是 Agents 懒人包全集 https://github.com/shumingyang-opencode/opencode-lazy-packs
请读取 repo 内容，列出所有可用的懒人包，问我要装哪些。
```

AI 会自动：
1. 读取 repo 的 `SKILL.md`（安装入口）
2. 列出 30 个懒人包
3. 问你要装哪些（可以选择「全部」或特定编号）
4. 自动安装你选的项目

### 方式二：一行指令手动装（OpenCode）

```bash
npx skills add https://github.com/shumingyang-opencode/opencode-lazy-packs --skill <skill名> -g -y
```

可用的 skill 名：

| Skill 名 | 对应懒人包 |
|----------|-----------|
| `00-env-setup` | 环境建置 |
| `02-github` | 连接 GitHub |
| `03-svn` | 连接公司 SVN |
| `04-gitlab-internal` | 连接公司 GitLab |
| `05-gitlab-personal` | 连接个人 GitLab |
| `06-obsidian` | 连接 Obsidian |
| `07-second-brain` | 第二大脑设定 |
| `09-browser` | 浏览器控制 |
| `10-workflow-skills` | 开工/收工技能 |
| `12-markitdown` | 文件转换技能 |
| `13-graphify` | 知识图谱技能 |
| `14-awesome-design-md` | 品牌设计套用技能 |
| `15-ui-ux-pro-max` | UI/UX Pro Max 设计智能 |
| `16-superpowers` | Superpowers — 完整的 AI 软件开发方法论（14 skills, 1.9M 安装） |
| `18-frontend-design` | Frontend Design — 辨识度优先的前端设计 |
| `19-feishu-lark` | 安装飞书 Lark — 文档/消息/群组/日历/多维表格 |
| `20-jira-confluence` | 安装公司 JIRA & Confluence — Issue 管理、页面搜索、操作自动化 |
| `21-trac` | 安装公司 Trac — Ticket 管理、Wiki 查阅、搜索自动化 |
| `23-project-plan-feature` | 功能规划技能 — 10 步骤规划 + init_plan.py 自动建文件 |
| `24-skill-reference` | 互动式 SKILL.md 建立教学 — 引导从零建立技能 |
| `25-agents-reference` | 互动式 AGENTS.md 建立教学 — 依项目客制项目规范 |
| `26-mcp-reference` | 互动式 MCP 设定教学 — 联机模式、安全性、自订 Server |
| `27-gen-pptx` | 通用简报产制技能 — 六引擎工作流：技术文件/Repo/Spec→可编辑 .pptx |
| `30-trae-opencode` | TRAE & OpenCode 双向驱动 — OpenCode↔TRAE 双向 CLI 驱动（bytedance/trae-agent） |

安装后对 OpenCode 说该技能对应的关键字即可启动。

### 方式三：手动安装（Trae IDE）

若你使用 **Trae IDE**，每个懒人包末尾都有 `## Trae 对应操作` 区块，说明如何在 Trae 上安装、更新、移除该服务。

```bash
# 以 Obsidian 为例，开启项目的 .trae/mcp.json，在 mcpServers 加入：
# {
#   "mcpServers": {
#     "obsidian": {
#       "command": "npx",
#       "args": ["@bitbonsai/mcpvault", "<VAULT_PATH>"]
#     }
#   }
# }
```

> 全域 MCP 设定请编辑 `%APPDATA%\Trae\User\mcp.json`（与 Cursor 兼容）。

### 方式四：手动下载 MD 文件

1. 下载对应的懒人包（MD 文件）
2. 开启终端，在项目目录执行 `opencode`（或开启 Trae IDE）
3. 把懒人包内容丢给 AI，它会自动执行

---

## 个人账号与服务清单

本懒人包新增 **中央账号信息管理系统**，让 AI agent 自动读取你的服务账号，不需每次重复询问。

### 功能说明

- 建立 `.md` 文件集中管理 SVN、GitLab、GitHub、JIRA、Confluence、飞书等服务信息
- 所有 OpenCode 项目在初始化前，会先透过全域 AGENTS.md 规则读取此文件
- 信息不足时才会询问，问到数据自动回写永久留存

### 如何启用

1. **复制模板**：将 `个人账号与服务清单.sample.md` 复制为 `个人账号与服务清单.md`
2. **填写信息**：将所有 `<...>` 占位符改为你的实际账号信息
3. **放置位置**：将该文件放在 **OpenCode 工作根目录**（建议同时做为 Obsidian vault 根目录）
4. **设定全域规则**：建立 `~/.config/opencode/AGENTS.md`（内容详见模板底部说明）

### 懒人包内建支持

部分懒人包在步骤中已内建「查阅账号信息」的前置步骤，可直接利用此文件跳过询问：

| 懒人包 | 自动读取项目 |
|--------|-------------|
| #02 连接 GitHub | GitHub 账号名称 |
| #03 连接公司 SVN | SVN URL、登录账号 |
| #04 连接公司 GitLab | GitLab URL、SSH 设定 |
| #05 连接个人 GitLab | GitLab URL、认证方式 |
| #06 建立 Obsidian | vault 根目录路径 |
| #20 JIRA & Confluence | JIRA / Confluence URL |
| #21 Trac | Trac URL、登录账号 |

### 安全提醒

PAT / Token **不要**写入此文件。它们应存放于对应平台的配置文件中：

- **OpenCode**：`~/.config/opencode/opencode.json` 的 MCP 环境变量
- **Trae IDE**：`.trae/mcp.json` 或 `%APPDATA%\Trae\User\mcp.json` 的 env 区块

详见模板中的「操作规范」与「安全规范」。

---

## Agents 设定对照表

| 项目 | OpenCode | Trae IDE |
|------|----------|----------|
| 安装 | `npm install -g opencode-ai` | 从 trae.ai 下载 |
| 全域设定 | `~/.config/opencode/opencode.json` | `%APPDATA%\Trae\User\mcp.json` |
| 项目指令文件 | `AGENTS.md` | `AGENTS.md` / `.trae/rules/` |
| MCP 配置 | 编辑 opencode.json | 编辑 `.trae/mcp.json` |
| Skill 机制 | `.agents/skills/` 或 `~/.agents/skills/`（全局） | `.agents/skills/` 或 `~/.agents/skills/`（全局） |
| 命令 | 有 `/` 内置命令 | GUI 界面操作 |

---

## 最低先备条件

- [ ] **OpenCode 用户**：Node.js 18+ 已安装
- [ ] **Trae 用户**：已安装 Trae IDE（从 [trae.ai](https://www.trae.ai) 下载）
- [ ] 电脑有网络连線
- [ ] 各懒人包的详细先备条件，请参阅 [SKILL.md](SKILL.md) 的「前置需求」字段

---

## 懒人包清单（支持 OpenCode / Trae IDE / Codex 等）

| 编号 | 名称 | 类型 | 状态 | 说明 | 支持状态 |
|------|------|------|------|------|----------|
| 00 | [环境建置](00-環境建置.md) | CLI | v0.3 | OpenCode + Node.js + uv 基础环境安装 | ✅ |
| 01 | [连接 GitHub](01-連接-GitHub.md) | MCP | v0.4 | GitHub CLI 登入认证 + repo commit/push 验证 | ✅ |
| 02 | [连接个人 GitLab](02-連接-個人GitLab.md) | MCP | v0.4 | 通过 HTTPS + PAT 连接 GitLab.com 账号 | ✅ |
| 03 | [建立第二大腦 Obsidian](03-建立第二大腦-Obsidian.md) | MCP | v0.3 | Obsidian MCP Vault 连接：笔记建立、搜尋、管理 | ✅ |
| 04 | [安装浏览器控制](04-安裝瀏覽器控制.md) | MCP | v0.3 | Playwright MCP + macOS 桌面 UI 自动化操作 | ✅ |
| 05 | [开工/收工/初始化技能](05-開工收工初始化技能.md) | Skill | v0.1 | 全域三技能：startup（开工自动同步）、shutdown（收工备份）、project-init（新项目初始化） | ✅ |
| 06 | [MarkItDown 文件转换](06-markitdown.md) | Skill | v0.3 | 各种文件自动转 Markdown：PDF/Office/CSV/JSON/图片/音频/Email/EPUB | ✅ |
| 07 | [Graphify 知识图谱](07-graphify.md) | Skill | v0.1 | 程式码知识图谱引擎：自然语言查询取代 grep，跨档案结构分析 | ✅ |
| 08 | [通用簡報產製](08-通用簡報產製.md) | Skill | v0.1 | 六引擎簡報工作流：将技术文件、datasheet、Spec、Repo 转为可编辑 .pptx，專为 RD/FAE/AE 設计 | ✅ |


---

---
## 意见反馈

- **Source**: https://github.com/mathruffian-dot/opencode-lazy-packs

---

## 相关项目

- **Source**: https://github.com/mathruffian-dot/opencode-lazy-packs
- **OpenCode**：[anomalyco/opencode](https://github.com/anomalyco/opencode) — 本懒人包所服务的 AI Coding Agent
- **Trae IDE**：[trae.ai](https://www.trae.ai) — 支持的另一个平台
