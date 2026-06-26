#!/usr/bin/env python3
"""Initialize a feature planning directory with 10 template files."""

from __future__ import annotations

import argparse
import sys
from pathlib import Path

TEMPLATE = """# {num} — {title}

## TODO: Write the content for this document.

{memo}
"""

DOC_SPEC = [
    ("01_需求分析.md", "Why: 動機、目標、使用者痛點",
     "Describe the motivation, target users, and pain points this feature addresses."),
    ("02_技術分析.md", "What: 現有系統限制與瓶頸",
     "Analyze current code limitations. Reference specific files and classes from existing analysis docs."),
    ("03_架構設計.md", "How: 高階架構、元件劃分",
     "Draw architecture diagram (ASCII or Mermaid), define component boundaries and data flow."),
    ("04_介面規格.md", "Contract: JSON Schema、CLI 參數表、API",
     "Define input/output contracts. JSON Schema for config files, argparse table for CLI."),
    ("05_實作與變更分析.md", "Change: 異動檔案、錯誤處理、相容性",
     "List every file to be modified, added, or deleted. Include error handling and backward compat."),
    ("06_方法評估.md", "Tradeoff: 多方案優劣比較",
     "Compare at least 2-3 approaches. Pros/cons table."),
    ("07_測試策略.md", "Verify: 單元測試、比對測試",
     "Define test cases."),
    ("08_效果評估.md", "Impact: 預期效益、風險",
     "Estimate effort, risk level, compatibility impact."),
    ("09_階段規劃.md", "When: MVP → 強化里程碑",
     "Split into phases. MVP = minimal useful subset."),
    ("10_使用範例.md", "Example: 完整操作示範",
     "Show complete CLI commands, config file examples, and expected outputs."),
]


def detect_project_root(start: str | Path) -> Path | None:
    """Scan CWD and parents for .git or AGENTS.md."""
    current = Path(start).resolve()
    for parent in [current] + list(current.parents):
        if (parent / ".git").exists() or (parent / "AGENTS.md").exists():
            return parent
    return None


def get_next_number(plan_dir: Path) -> int:
    """Determine the next NN number based on existing plan directories."""
    max_n = 0
    if plan_dir.exists():
        for d in plan_dir.iterdir():
            if d.is_dir() and d.name[0].isdigit():
                base = d.name.split("-")[0]
                try:
                    n = int(base.split("_")[0])
                    max_n = max(max_n, n)
                except (ValueError, IndexError):
                    continue
    return max_n + 1


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Initialize a feature planning directory"
    )
    parser.add_argument("--name", required=True,
                        help="Short English keyword (e.g., CLI_JSON_Input)")
    parser.add_argument("--title", default="",
                        help="Display title (e.g., CLI + JSON 輸入系統)")
    parser.add_argument("--project-root", default=None,
                        help="Project root path. Auto-detected from CWD if omitted.")
    parser.add_argument("--plan-dir", default="docs",
                        help="Plan directory name under project root (default: docs)")
    args = parser.parse_args()

    if args.project_root:
        root = Path(args.project_root).resolve()
    else:
        detected = detect_project_root(Path.cwd())
        if detected:
            root = detected
            print(f"Detected project root: {root}")
        else:
            print("Error: Could not auto-detect project root.")
            print("Please specify with --project-root /path/to/project")
            sys.exit(1)

    plan_dir = root / args.plan_dir
    num = get_next_number(plan_dir)
    dir_name = f"{num:02d}_{args.name}-計劃中"
    target = plan_dir / dir_name

    if target.exists():
        print(f"Error: {target} already exists")
        sys.exit(1)

    target.mkdir(parents=True, exist_ok=True)
    print(f"Created: {target}")

    for filename, subtitle, memo in DOC_SPEC:
        content = TEMPLATE.format(
            num=filename.replace(".md", ""),
            title=subtitle,
            memo=memo,
        )
        fpath = target / filename
        fpath.write_text(content, encoding="utf-8")
        print(f"  + {filename}")

    print(f"\nDone. {len(DOC_SPEC)} files created in {target}")


if __name__ == "__main__":
    main()
