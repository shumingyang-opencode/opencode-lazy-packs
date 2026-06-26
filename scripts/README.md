# scripts/ — 懶人包輔助腳本

本目錄存放懶人包安裝時使用的輔助工具。

## `convert.py`

透過 Microsoft MarkItDown 將 PDF / Word / Excel / PowerPoint / HTML / CSV / 圖片 等檔案轉為 Markdown。

```bash
# 輸出到終端機
python scripts/convert.py 報告.docx

# 輸出到檔案
python scripts/convert.py 報告.docx -o 報告.md
```

**相依：** `markitdown`（`pip install markitdown`）

## `draw.py`

透過 OpenAI gpt-image-2 模型生圖，輸出至 `slides/generated/` 或 `generated/`。

```bash
python scripts/draw.py "一隻坐在筆電前的貓工程師"
python scripts/draw.py "城市夜景" --name city --size "1024x1024" --quality high
```

**相依：** `openai`（`pip install openai`）、`OPENAI_API_KEY`（存放於 `~/.openai.env`）

## `init_plan.py`

透過 10 步驟模板初始化功能規劃目錄，用於 project-plan-feature 技能：

```bash
# 自動偵測專案根目錄
python scripts/init_plan.py --name "My_Feature"

# 手動指定路徑
python scripts/init_plan.py --name "Web_Dashboard" --project-root ~/my-project
```

**相依：** 無（僅使用 Python 標準函式庫）
