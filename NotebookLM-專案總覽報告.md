# OpenCode Lazy Packs: Technical Briefing and Implementation Guide

The OpenCode Lazy Packs repository (`steven.yang/agents-lazy-packs`) serves as a comprehensive automation and configuration hub for the OpenCode AI coding agent. It provides a structured environment for installing "skills" (automated tasks) and Model Context Protocol (MCP) servers, enabling a streamlined development workflow that integrates with diverse tools such as GitHub, GitLab, Obsidian, JIRA, and specialized knowledge graph engines.

## Executive Summary

The OpenCode Lazy Pack system is designed to automate the environment setup and tool integration for the OpenCode AI agent. It operates alongside similar repositories for Claude Code and OpenAI Codex, sharing a common instructional flow but utilizing OpenCode-specific configurations (JSON-based settings and `AGENTS.md` instruction files). The repository currently contains 28 distinct "lazy packs" ranging from basic environment setup to advanced AI development methodologies like "Superpowers." A central feature of the ecosystem is the transition between project-level and global configurations, ensuring that common services like version control and note-taking repositories are accessible across all development projects.

## Key Themes and Architectural Analysis

### 1. Cross-Platform Agent Parity
While OpenCode shares a common goal with other AI coding agents, its implementation requires specific file structures and commands. The repository emphasizes that modifications to the main workflow must be synchronized across all three platforms (OpenCode, Claude Code, and Codex) to maintain consistency, despite technical differences in configuration.

| Feature | OpenCode | Claude Code | OpenAI Codex |
| :--- | :--- | :--- | :--- |
| **Global Config** | `~/.config/opencode/opencode.json` | `~/.claude/settings.json` | `~/.codex/config.toml` |
| **Project File** | `AGENTS.md` | `CLAUDE.md` | `AGENTS.md` |
| **MCP Management** | Manual JSON Editing | `claude mcp add` | `codex mcp add` |
| **Skills Directory** | `~/.config/opencode/skills/` | `~/.claude/skills/` | `~/.codex/skills/` |
| **Command Support** | Native `/` commands | Native `/` commands | Not supported |

### 2. The Skill Ecosystem
The "Lazy Packs" are categorized into 28 functional skills. These are designed to be installed either automatically by the AI agent or manually via `npx skills add`.

**Core Skill Categories:**
*   **Infrastructure:** Environment setup (#00), GitHub/SVN/GitLab connectivity (#02-#05), and Firebase (#08).
*   **Knowledge Management:** Obsidian "Second Brain" integration (#06, #07) and NotebookLM (#01).
*   **Advanced Development:** The "Superpowers" methodology (#16), Functional Planning (#23), and Codebase Memory MCP (#22).
*   **Specialized Automation:** Browser control via Playwright (#09), Document conversion via MarkItDown (#12), and Presentation generation (#27).
*   **Design & UI:** Awesome DESIGN.md (#14), UI/UX Pro Max (#15), and Frontend Design (#18).

### 3. Configuration Hierarchy: Global vs. Project
A critical component of the OpenCode architecture is the distinction between global and project-specific settings. 

*   **Global Level (`~/.config/opencode/`):** Reserved for universal services that apply across all projects, such as company GitLab instances, Trac, Firebase, or the Codebase Memory MCP.
*   **Project Level (`<project>/opencode.json`):** Used for project-specific overrides or unique settings. 
*   **Conflict Resolution:** Project-level settings merge with global settings, with the project-level keys taking precedence in the event of a naming conflict.

### 4. Knowledge Graph Integration (Graphify)
The system incorporates `graphify`, a tool that generates a knowledge graph of the codebase to replace traditional `grep` searches with natural language queries.
*   **Workflow:** Before performing tasks, the agent invokes `skill: "graphify"` if a `graphify-out/` directory is present.
*   **Capabilities:** It supports scoped subgraphs (via `graphify query`), relationship analysis (via `graphify path`), and conceptual explanations (via `graphify explain`).
*   **Maintenance:** The system enforces an `update` command after code modifications to keep the AST (Abstract Syntax Tree) current without incurring API costs.

## Centralized Account Management

To reduce repetitive prompts, the system utilizes a **Central Account Information Management System**. Users maintain a `个人账号与服务清单.md` (Personal Account and Service List) file at the root of their OpenCode workspace.

*   **Supported Services:** Automatically populates credentials for GitHub, SVN, GitLab, Obsidian vaults, JIRA, Confluence, and Trac.
*   **Security Protocol:** Personal Access Tokens (PAT) and sensitive secrets must **not** be stored in the Markdown file. Instead, they must be placed within the `opencode.json` environment variables for MCP servers.
*   **Persistence:** If information is missing, the agent will prompt the user once and then write the response back to the central file for future use.

## Installation and Validation Workflow

The repository mandates a five-step process for installing any new MCP server or skill:

1.  **Installation:** Execute the installation steps and verify the service.
2.  **User Confirmation:** The agent **must** ask the user if the service should be made "Global" (`~/.config/opencode/`).
3.  **Relocation:** If confirmed, the configuration is moved to the global `opencode.json`.
4.  **Cleanup:** The local `opencode.json` is streamlined or removed if it no longer contains project-specific data.
5.  **Documentation:** If the user declines global status, the agent must explain how other projects can manually enable the skill.

## Important Quotes and Context

> "Do **not** simply copy the Claude Code or Codex versions; MCP commands and configuration formats are different."

**Context:** This warning in `AGENTS.md` highlights the technical nuances between AI agents, stressing that while the logic may be similar, the syntax (JSON vs. TOML vs. specific CLI commands) is incompatible.

> "Dirty graphify-out/ files are expected... dirty graph files are not a reason to skip graphify."

**Context:** This rule ensures that the agent prioritizes the knowledge graph for navigation even if the data is slightly out of sync, as it provides a more efficient context than raw source browsing.

> "Information will only be requested when insufficient, and the retrieved data will be automatically written back for permanent storage."

**Context:** This describes the behavior of the central account management system, emphasizing a "write-once, use-many" approach to user configuration.

## Actionable Insights for Implementation

*   **Prioritize Environment Setup:** Skill `00-env-setup` is a prerequisite for almost all other packs. It handles the installation of Node.js, the OpenCode, and `uv`.
*   **Standardize Account Templates:** Before deploying multiple skills, ensure `个人账号与服务清单.sample.md` is converted to a live `.md` file at the root level to prevent the agent from repeatedly asking for SVN or GitLab URLs.
*   **Utilize Native MCPs for Corporate Tools:** For users in corporate environments, the global installation of JIRA, Confluence, and Trac MCPs (Skills #20 and #21) is recommended to integrate ticket management directly into the coding workflow.
*   **Knowledge Graph Maintenance:** When modifying code, the agent must execute `graphify update .` to ensure the internal knowledge graph accurately reflects the new structure, facilitating better future queries.