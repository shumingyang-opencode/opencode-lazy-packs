---
name: project-plan-feature
description: Initialize and manage a feature planning document set using a standard 10-step planning convention. Use when starting a new feature, enhancement, or development initiative in any project.
---

# Project Plan Feature

Manage the full lifecycle of a feature planning document set: detect project root → init → write → post-check.

## When to Use

- Starting a new feature or enhancement
- User says "規劃新功能", "feature plan", "new feature", "功能規劃"

## Prerequisites

Before starting, verify the environment:

1. **codebase-memory-mcp** — required for index pre/post-check
   - Run `codebase-memory-mcp --version` to verify
   - If missing: tell user to install #22 first
2. **Python 3** — required for init_plan.py
   - Run `python3 --version` to verify

## Workflow

### Step 0: Confirm project root and plan directory

1. **Auto-detect project root**: Scan CWD and parents for `.git` or `AGENTS.md`
2. If found, show: `"Detected project root: /path/to/project. Correct? [Y/n]"`
   - `Y` → proceed
   - `n` → ask user to type the correct path
3. If not found, ask user to type the project root path
4. **Confirm plan directory**: `"Planning files go under <root>/docs/. Change? [y/N]"`
   - `N` or Enter → use `docs/`
   - `y` → ask user to type directory name

### Step 1: Pre-check — Index + Audit existing analysis docs

1. Run `codebase-memory-mcp index_repository` with `repo_path=project_root`, `mode="full"`, `persistence=true`
2. Use `get_architecture` + `search_graph` to discover current code structure
3. Cross-reference against existing analysis docs (e.g., `docs/00_Analysis/`)
4. If inconsistencies found: **stop** and request user to fix analysis docs first

### Step 2: Initialize the planning directory

Run the init script:

```bash
python ~/.config/opencode/skills/project-plan-feature/scripts/init_plan.py \
    --name "Short_Description" \
    --project-root /path/to/project \
    --plan-dir docs
```

This creates `<root>/<plan-dir>/<NN>_<name>-計劃中/` with 10 template `.md` files (01~10).

## Status Lifecycle

Advance the directory suffix with `git mv`:
```
-計劃中 → -分析中 → -實作中 → -驗證中 → -完成
                                      ↘ -已取消
```

### Step 3: Write the 10 planning documents

Write each file sequentially. For NA steps, append `_NA` to filename.

| # | File | Focus |
|---|------|-------|
| 01 | 需求分析 | Why: pain points, goals, users affected |
| 02 | 技術分析 | What: current code limitations, bottlenecks |
| 03 | 架構設計 | How: architecture diagram, component split |
| 04 | 介面規格 | Contract: JSON Schema, CLI params table, API |
| 05 | 實作與變更分析 | Change: modified files, error handling, compat |
| 06 | 方法評估 | Tradeoff: multi-option comparison pros/cons |
| 07 | 測試策略 | Verify: unit tests, comparison tests |
| 08 | 效果評估 | Impact: expected benefits, risks |
| 09 | 階段規劃 | When: MVP → enhanced milestones |
| 10 | 使用範例 | Example: complete end-to-end demo |

### Step 4: Post-check — Re-index + Audit analysis docs

1. Run `codebase-memory-mcp index_repository` again (mode=full, persistence=true)
2. Re-check analysis docs against the final codebase
3. If new modules or patterns were added that are not documented, request user to update analysis docs
4. Only consider done when analysis docs reflect the final code

## References

- `scripts/init_plan.py` — Script to generate the 10 template files
- `references/plan-writing-guide.md` — Writing tips for each document
- `references/pre-check-guide.md` — Cross-reference audit workflow
