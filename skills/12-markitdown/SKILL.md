---
name: markitdown
description: 文件轉 Markdown 技能 — 處理任何任務時，若遇到 PDF/Word/Excel/PowerPoint/HTML/CSV/JSON/XML/圖片 等非 MD 檔案，自動用 MarkItDown 轉換為 Markdown 格式再處理。說「解析這個檔案」「幫我讀這份文件」「轉換這個檔案」時載入。
---

# MarkItDown 文件轉換技能

自動將各種文件格式轉換為 Markdown，讓 AI 可以閱讀和處理。

## 核心原則

**在任何任務中，只要遇到非 Markdown 的文件資源，一律先轉 MD 再處理。**

適用場景：
- 使用者直接丟入 PDF/DOCX/XLSX 等檔案
- 任務分析過程中下載或發現的資源包含這些格式
- 程式碼仓库內的 `.pdf`、`.docx`、`.pptx` 等檔案
- 網頁抓取下來的 HTML 內容
- CSV/JSON/XML 等資料檔案

## 支援格式

| 格式 | 副檔名 |
|------|--------|
| PDF | .pdf |
| Word | .docx |
| Excel | .xlsx |
| PowerPoint | .pptx |
| HTML | .html, .htm |
| CSV | .csv |
| JSON | .json |
| XML | .xml |
| 圖片 | .jpg, .png, .gif, .webp |
| EPUB | .epub |
| ZIP | .zip |
| Outlook 郵件 | .msg |

## 使用方式

### CLI 直接轉換（由 AI 自動呼叫）

```bash
python ~/.config/opencode/skills/markitdown/convert.py <檔案路徑>
```

### 轉換並存檔

```bash
python ~/.config/opencode/skills/markitdown/convert.py <檔案路徑> -o <輸出.md>
```

## AI 使用流程

1. 在任何任務中發現非 MD 檔案（使用者提供或分析過程中遇到）
2. AI 自動呼叫 `convert.py <檔案路徑>` 取得 stdout 的 Markdown 內容
3. AI 讀取內容後繼續原本的任務處理流程
4. 若該檔案是使用者主動提供的，詢問：「要不要存成 .md 檔案？」
5. 若使用者同意，用 `-o` 參數存檔

## 安裝與權限

技能檔案位置：`~/.config/opencode/skills/markitdown/`
- `SKILL.md` — 本檔案
- `convert.py` — 轉換腳本

`opencode.json` 需加入：
```json
"markitdown": "allow"
```
