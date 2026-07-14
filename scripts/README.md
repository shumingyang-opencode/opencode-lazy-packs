# scripts/ — 懶人包輔助腳本

本目錄存放懶人包安裝時使用的輔助工具。

## `convert.py`

透過 Microsoft MarkItDown 將 PDF / Word / Excel / PowerPoint / HTML / CSV / JSON / 圖片 / 音訊 等檔案轉為 Markdown。

```bash
# 輸出到終端機
python scripts/convert.py 報告.docx

# 輸出到檔案
python scripts/convert.py 報告.docx -o 報告.md
```

**相依：** `markitdown`（`pip install 'markitdown[xls,audio-transcription]'`）

## `init_plan.py`

透過 10 步驟模板初始化功能規劃目錄，用於 project-plan-feature 技能：

```bash
# 自動偵測專案根目錄
python scripts/init_plan.py --name "My_Feature"

# 手動指定路徑
python scripts/init_plan.py --name "Web_Dashboard" --project-root ~/my-project
```

**相依：** 無（僅使用 Python 標準函式庫）
