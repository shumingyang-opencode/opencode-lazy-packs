# Plan Writing Guide

## 01_需求分析.md
**Goal**: Clearly state WHY this feature exists.
- Who is the end user?
- What is the current pain point?
- What is the measure of success?

## 02_技術分析.md
**Goal**: Map the problem to specific code.
- Which classes and functions are affected?
- Reference specific files from analysis docs.

## 03_架構設計.md
**Goal**: Propose the high-level solution.
- Component diagram (ASCII or Mermaid)
- Data flow: JSON/CLI → Parser
- New files vs existing files

## 04_介面規格.md
**Goal**: Define the EXACT contract.
- JSON Schema or API spec
- CLI argument table (name, type, default, description)

## 05_實作與變更分析.md
**Goal**: List every file change.
- For each file: what changes, risk level
- Error handling strategy
- Backward compatibility strategy

## 06_方法評估.md
**Goal**: Show you considered alternatives.
- Compare 2-3 approaches
- Use a decision matrix

## 07_測試策略.md
**Goal**: Define how to verify correctness.
- Unit tests, integration tests
- Comparison tests (old vs new)

## 08_效果評估.md
**Goal**: Quantify the impact.
- Expected effort reduction
- Risk assessment
- Known unknowns

## 09_階段規劃.md
**Goal**: Make it achievable.
- Phase 1 (MVP)
- Phase 2 (Enhancement)
- Phase 3 (Advanced)

## 10_使用範例.md
**Goal**: Show it working.
- Minimal example
- Common mistakes
