#!/usr/bin/env python3
"""
init_plan.py — Initialize a feature planning directory with 10 template files.

Usage:
    python init_plan.py --name "Short_Description" [--project-root /path] [--plan-dir docs]

This creates:
    <project-root>/<plan-dir>/<NN>_<Short_Description>-計劃中/
    ├── 01_需求分析.md
    ├── 02_技術分析.md
    ├── 03_架構設計.md
    ├── 04_介面規格.md
    ├── 05_實作與變更分析.md
    ├── 06_方法評估.md
    ├── 07_測試策略.md
    ├── 08_效果評估.md
    ├── 09_階段規劃.md
    └── 10_使用範例.md
"""

import argparse
import os
import sys
import subprocess
from pathlib import Path

TEMPLATES = {
    "01_需求分析": "# {name} — 需求分析\n\n## 目標\n\n<!-- Why does this feature exist? -->\n\n## 使用者\n\n<!-- Who is affected? -->\n\n## 痛點\n\n<!-- Current pain points -->\n\n## 成功標準\n\n<!-- How to measure success -->\n",
    "02_技術分析": "# {name} — 技術分析\n\n## 現狀\n\n<!-- Current code structure -->\n\n## 限制\n\n<!-- Bottlenecks, technical debt -->\n\n## 受影響的模組\n\n<!-- Classes, functions, files -->\n",
    "03_架構設計": "# {name} — 架構設計\n\n## 架構圖\n\n<!-- ASCII or Mermaid diagram -->\n\n## 元件說明\n\n| 元件 | 職責 |\n|------|------|\n|      |      |\n\n## 資料流\n\n<!-- Data flow description -->\n",
    "04_介面規格": "# {name} — 介面規格\n\n## API / CLI\n\n| 參數 | 型別 | 預設值 | 說明 |\n|------|------|--------|------|\n|      |      |        |      |\n\n## JSON Schema\n\n```json\n{\n}\n```\n",
    "05_實作與變更分析": "# {name} — 實作與變更分析\n\n## 變更檔案\n\n| 檔案 | 變更內容 | 風險 |\n|------|---------|------|\n|      |         |      |\n\n## 錯誤處理\n\n<!-- Error handling strategy -->\n\n## 相容性\n\n<!-- Backward compatibility -->\n",
    "06_方法評估": "# {name} — 方法評估\n\n## 方案比較\n\n| 方案 | 優點 | 缺點 |\n|------|------|------|\n| A    |      |      |\n| B    |      |      |\n\n## 決策矩陣\n\n<!-- Weighted decision matrix -->\n",
    "07_測試策略": "# {name} — 測試策略\n\n## 單元測試\n\n<!-- Unit test coverage -->\n\n## 整合測試\n\n<!-- Integration tests -->\n\n## 比對測試\n\n<!-- Old vs new comparison -->\n",
    "08_效果評估": "# {name} — 效果評估\n\n## 預期效益\n\n<!-- Expected improvements -->\n\n## 風險評估\n\n| 風險 | 影響 | 因應措施 |\n|------|------|---------|\n|      |      |         |\n\n## 未知項目\n\n<!-- Known unknowns -->\n",
    "09_階段規劃": "# {name} — 階段規劃\n\n## Phase 1 (MVP)\n\n<!-- Minimum viable deliverable -->\n\n## Phase 2 (Enhancement)\n\n<!-- Extended features -->\n\n## Phase 3 (Advanced)\n\n<!-- Future optimization -->\n",
    "10_使用範例": "# {name} — 使用範例\n\n## 基本範例\n\n```bash\n# Example command or code\n```\n\n## 常見錯誤\n\n<!-- Common mistakes and how to avoid them -->\n",
}

def detect_project_root() -> Path | None:
    cwd = Path.cwd()
    for parent in [cwd] + list(cwd.parents):
        if (parent / ".git").exists() or (parent / "AGENTS.md").exists():
            return parent
    return None

def find_next_number(plan_dir: Path) -> int:
    max_n = 0
    if plan_dir.exists():
        for entry in plan_dir.iterdir():
            if entry.is_dir():
                parts = entry.name.split("_", 1)
                if parts[0].isdigit():
                    max_n = max(max_n, int(parts[0]))
    return max_n + 1

def main() -> None:
    parser = argparse.ArgumentParser(description="Initialize a feature planning directory")
    parser.add_argument("--name", required=True, help="Short description (e.g. Web_Dashboard)")
    parser.add_argument("--project-root", help="Project root path (auto-detect if omitted)")
    parser.add_argument("--plan-dir", default="docs", help="Planning directory under project root (default: docs)")
    args = parser.parse_args()

    project_root = Path(args.project_root) if args.project_root else detect_project_root()
    if not project_root:
        print("❌ Cannot detect project root. Specify --project-root.")
        sys.exit(1)

    plan_base = project_root / args.plan_dir
    plan_base.mkdir(parents=True, exist_ok=True)

    nn = find_next_number(plan_base)
    dir_name = f"{nn:02d}_{args.name}-計劃中"
    target_dir = plan_base / dir_name
    target_dir.mkdir(parents=True, exist_ok=False)

    for filename, content in TEMPLATES.items():
        filepath = target_dir / f"{filename}.md"
        rendered = content.format(name=args.name)
        filepath.write_text(rendered, encoding="utf-8")
        print(f"  ✅ {filepath.name}")

    print(f"\n✅ Planning directory created: {target_dir}")
    print(f"   Run `git add {target_dir}` to track.")

if __name__ == "__main__":
    main()
