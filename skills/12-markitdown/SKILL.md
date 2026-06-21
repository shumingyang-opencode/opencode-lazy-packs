---
name: markitdown
description: 文件轉 Markdown 技能 — 遇到 PDF/Word/Excel/PowerPoint/HTML/CSV/JSON/XML/圖片 等非 MD 檔案時，自動用 MarkItDown 轉換為 Markdown 格式再處理。說「解析這個檔案」「幫我讀這份文件」「轉換這個檔案」時載入。
---

# MarkItDown 文件轉換技能

自動將各種文件格式轉換為 Markdown，讓 AI 可以閱讀和處理。

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

1. 使用者丟入一個非 Markdown 檔案（PDF/DOCX/XLSX 等）
2. AI 呼叫 `convert.py <檔案路徑>` 取得 stdout 的 Markdown 內容
3. AI 讀取內容後向使用者摘要
4. AI 詢問使用者：「要不要存成 .md 檔案？」
5. 若使用者同意，用 `-o` 參數存檔

## 安裝與權限

技能檔案位置：`~/.config/opencode/skills/markitdown/`
- `SKILL.md` — 本檔案
- `convert.py` — 轉換腳本

`opencode.json` 需加入：
```json
"markitdown": "allow"
```
