---
name: opencode-28-cli-anything
description: >-
  安裝 CLI-Anything（HKUDS/CLI-Anything）— 讓 OpenCode 發現、安裝、使用 50+ 真實軟體的 Agent-native CLI
  harness。說「安裝 CLI-Anything」「搜尋 CLI 工具」「用 Blender 建模」「編輯圖片」「操控 Obsidian」
  「影片剪輯」「音訊處理」「找工具」時載入。
---

# CLI-Anything 懶人包

出處：https://github.com/HKUDS/CLI-Anything（⭐ 44.8K, Apache-2.0）
CLI-Hub：https://clianything.cc

## 安裝步驟

```bash
pipx install cli-anything-hub
```

驗證：執行 `cli-hub --version` 確認安裝成功。

## 使用方式

安裝後，OpenCode 會在遇到「用 Blender 建模」「編輯這張圖」「操控 Obsidian」等任務時自動觸發此 skill。

常用指令：

| 操作 | 指令 |
|------|------|
| 瀏覽全部工具 | `cli-hub list` |
| 搜尋工具 | `cli-hub search <keyword>` |
| 查看資訊 | `cli-hub info <name>` |
| 安裝工具 | `cli-hub install <name>` |
| 使用工具 | `cli-anything-<name>` 或 `cli-hub launch <name>` |
| 更新工具 | `cli-hub update <name>` |
| 解除安裝 | `cli-hub uninstall <name>` |

## 進階：產生新的 CLI Harness

對 OpenCode 說 `/cli-anything` 並提供目標軟體的源碼路徑或 GitHub URL，即可為任意 GUI 軟體產生 CLI harness。

## 更多資訊

詳細步驟與指令範例請見根目錄的 [28-安裝-CLI-Anything.md](../../28-安裝-CLI-Anything.md)。
