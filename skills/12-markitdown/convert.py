#!/usr/bin/env python3
"""Convert various file formats to Markdown using Microsoft MarkItDown."""

from __future__ import annotations

import argparse
import subprocess
import sys
from pathlib import Path


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Convert various file formats to Markdown using MarkItDown"
    )
    parser.add_argument("input", help="Path to the input file")
    parser.add_argument("-o", "--output", help="Output file path (default: stdout)")
    args = parser.parse_args()

    input_path = Path(args.input)

    if not input_path.exists():
        print(f"Error: File not found: {input_path}", file=sys.stderr)
        sys.exit(1)

    result = subprocess.run(
        ["markitdown", str(input_path)],
        capture_output=True,
        text=True,
    )

    if result.returncode != 0:
        print(f"Error converting file: {result.stderr}", file=sys.stderr)
        sys.exit(1)

    if args.output:
        output_path = Path(args.output)
        output_path.write_text(result.stdout, encoding="utf-8")
        print(f"Converted to: {output_path}")
    else:
        print(result.stdout)


if __name__ == "__main__":
    main()
