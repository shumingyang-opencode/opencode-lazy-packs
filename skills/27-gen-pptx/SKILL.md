---
name: gen-pptx
description: 工程導向可編輯簡報產製技能。將技術主題、datasheet、spec 文件、FW/SW 架構筆記、SDK 文件、或另一個 repo 的 README/docs/code 轉為結構清楚的可編輯 .pptx 簡報。專為軟韌體工程師、半導體工程師、FAE/AE 團隊設計。說「做簡報」「產出簡報」「做成投影片」「generate presentation」「turn this into slides」時載入。
---

# opencode-gen-pptx Workflow

將任意技術主題、datasheet、spec、SDK 文件、SoC block diagram、FW/SW 架構或 repo 內容，轉成一份有清楚脈絡、可編輯、可驗證的 `.pptx` 簡報。預設不使用 AI 生圖或任何 API 金鑰；視覺以 PowerPoint 原生元件、PptxGenJS、表格、色塊、圖示、流程圖、程式碼區塊與簡潔版面完成。

## 安裝

前置需求：Python 3.8+、Node.js 18+

```bash
# 安裝 PptxGenJS（本機至技能目錄，讓 generate.js 可執行）
cd ~/.agents/skills/gen-pptx
npm init -y
npm install pptxgenjs
```

SKILL.md 與 generate.js 已安裝至 `~/.agents/skills/gen-pptx/`。

## 先判斷工作模式

| 使用者狀況 | 工作模式 | 流程 |
| --- | --- | --- |
| 有技術主題或素材 | 全流程產製 | 引擎 1 -> 2 -> 3 -> 4 -> 5 -> 6 |
| 給一個 repo (SDK/BSP/FW) | repo-to-deck | 先盤點 repo，再跑全流程 |
| 有既有 `.pptx` | 診斷修改 | 引擎 4 + 5，必要時補引擎 3 |
| 想定義團隊簡報模板 | 風格定義 | 引擎 5 |

若缺少受眾（RD/FAE/AE/客戶）、用途、時間或頁數，先補問最影響結果的一題。

## Repo-to-Deck 規則

當使用者給另一個 repo、資料夾或 GitHub URL（特別是 SDK / BSP / FW / 晶片 driver repo）：

1. 先讀 `README`、`AGENTS.md` / `CONTRIBUTING.md`、`docs/`、`examples/`、API 入口檔、`Kconfig` / `CMakeLists.txt` 等建置設定，以及近期 commit log。
2. 判斷簡報目的：晶片導入評估、SDK 整合說明、FW 架構設計、BSP porting 指引、FAE 除錯流程、API 使用教學、或跨團隊 Design Review。
3. 不把 repo 檔案清單直接變成投影片；先萃取「工程師需要理解的主線」：系統架構、初始化流程、關鍵 API、配置選項、常見踩坑。
4. 每頁保留可追溯來源：在講稿備註或工作筆記中記錄對應檔案、函數名、行號範圍與段落。
5. 避免曝光密鑰、個資、內部 token、`.env`、NDA 資訊、private 設定。

## 引擎一：概念定位

目標：回答「這份簡報要讓觀眾帶走什麼」。

輸出：

```markdown
## 概念定位稿
### 總概念
[一句話：這顆晶片解決什麼問題 / 這個 FW 架構的設計哲學]
### 三個子概念
1. [核心技術：為什麼這樣做]
2. [關鍵規格：效能/功耗/面積]
3. [應用場景：誰在用、怎麼用]
### 工程師常見誤解或盲點
1. [盲點：例如「這個 register 在 standby 下仍會 retain」] -> [正確理解：實際行為與條件]
2. [盲點：例如「這組 API 是 thread-safe」] -> [正確理解：實際限制]
### 帶走一句話
[工程師離開會議必須記得的一句話]
### 最小事實包
- [必要規格表、流程圖、程式碼片段、scope capture]
### 投影片 vs 講稿分配
| 內容 | 建議位置 | 原因 |
```

## 引擎二：脈絡定位

目標：安排理解節奏，而不是只排章節。

通用三段：

| 段落 | 功能 | 佔比 |
| --- | --- | --- |
| 引起動機 | 讓觀眾知道為什麼要聽 | 15-20% |
| 建立理解 | 展開概念、證據、流程或案例 | 60-70% |
| 促成行動 | 收斂重點、決策、練習或下一步 | 15-20% |

每段輸出技術溝通目的、放入內容、觀眾（RD/FAE/AE/客戶）任務、建議頁數、入口、出口與常見設計錯誤。

## 引擎三：頁面架構

目標：每頁只有一個任務。

可用頁面角色（適用於工程簡報情境）：

| 角色 | 用途 |
| --- | --- |
| 封面頁 | 標題、副標、部門、NDA 等級 |
| 問題引入頁 | 用技術痛點、bug、客戶反饋建立動機 |
| 核心概念頁 | 定義主概念與一句話主張 |
| Spec 對照頁 | 晶片規格、電氣特性、package pin map、時序參數對照 |
| 比較頁 / 比較矩陣頁 | Chip A vs Chip B、solution trade-off、架構方案比較 |
| 流程頁 | 初始化流程、資料流、通訊協議、狀態機 |
| 架構圖頁 | SoC block diagram、FW/SW 分層、通訊拓樸、class hierarchy |
| 案例頁 | 具體應用場景、量測波形、before/after 優化 |
| 實驗數據頁 | 量測結果、performance benchmark、scope capture、throughput 曲線 |
| Debug Flow 頁 | 問題再現步驟、log 分析、root cause 鏈、workaround |
| 操作頁 | Register 設定步驟、CLI 指令、API 呼叫流程 |
| 風險頁 | 已知 issue、limitation、errata、注意事項 |
| 總結頁 | 收攏重點與帶走一句話 |
| 行動頁 | 決策、任務分配、下一版規劃 |
| 過渡頁 | 章節銜接，例如「從架構看實作」 |

## 通用 Visual 版型

| visual | 用途 | PptxGenJS 作法 |
| --- | --- | --- |
| `comparison_table` | 晶片規格對照、solution trade-off | `addTable`，強調關鍵欄或列 |
| `spec_table` | Pin map、電氣特性、register table | `addTable`，標題灰底 + 數值色標 |
| `process_steps` | 初始化流程、FW boot sequence、狀態機 | 橫向卡片 + 箭頭，節點可標註 register 值 |
| `timeline` | 專案里程碑、晶片開發階段、roadmap | 線段 + 節點 + 日期 |
| `architecture_map` | SoC block diagram、FW/SW 分層、通訊拓樸 | 方塊、群組、連線，註明介面類型 (I2C/SPI/MIPI) |
| `data_flow` | DMA path、pipeline、sensor data chain | 箭頭流向 + 中間資料格式標籤 |
| `evidence_card` | 量測數據、benchmark 數字、scope capture | 大字關鍵數字 + 說明與條件（VDD=3.3V, 25°C） |
| `before_after` | Performance 優化前後、bug fix 效果 | 雙欄對照 + 差異百分比 |
| `checklist` | 驗證項目、bring-up 狀態、交付項 | 勾選列 + 狀態色 (pass/fail/block) |
| `quote_focus` | 關鍵 spec 引述、architect 決策原則 | 大字句 + 來源文件小字 |
| `icon_grid` | 3-6 個並列技術重點 | 圖示/emoji + 標題 + 一行說明 |
| `code_or_command` | Register setting、CLI 指令、code snippet | Consolas 等寬字型區塊 + 語言註解標籤 |
| `timing_diagram` | 時序圖、protocol waveform、critical path | 水平線段 + 標註 setup/hold time |

## 引擎四：認知編修

用六個認知詞檢查每頁：

| 認知詞 | 做什麼 |
| --- | --- |
| 降雜訊 | 移除不幫助理解的元素 |
| 區塊化 | 同類資訊成組 |
| 增資訊 | 補上理解橋梁、標籤、例子 |
| 結構化 | 讓主從、因果、對照可見 |
| 順脈絡 | 排出合理閱讀順序 |
| 步驟化 | 把複雜任務拆成可跟上的步驟 |

## 引擎五：風格建構

預設規則（工程簡報風格）：

- 16:9 寬螢幕。
- 每頁至少有一個視覺結構：表格、卡片、流程、圖示、色塊、示意架構、程式碼區塊。
- 不做純文字堆疊頁。
- 字級使用 44/28/18/14 比例作為起點（工程資訊密度高）。
- 中文字型：`Microsoft JhengHei`；等寬字型：`Consolas` / `Cascadia Code`。
- 預設色系：**主色 #1E3A5F**（深藍）、**輔色 #4A90D9**（技術藍）、**強調色 #E67E22**（橙）、**警示色 #E74C3C**（紅）。
- 程式碼區塊：等寬字型 + 灰底圓角框 + 語言標籤。
- 表格風格：灰底標題列、數值靠右對齊、色標高亮關鍵欄。

輸出：

```markdown
## 風格設定摘要
- 視覺氣質：
- 主色 / 輔色 / 強調色：
- 字型：
- 版面規則：
- 不做事項：
```

## 引擎六：簡報總導演

目標：整合前五顆引擎，生成 `.pptx`。

技術執行：

1. 依頁面角色表寫 PptxGenJS 腳本，或使用 `generate.js` 快速產生標準版型。
2. 使用 PowerPoint 原生文字、表格、形狀、線條與圖示。
3. 程式碼區塊使用 `Consolas` / `Cascadia Code` 等寬字型，灰底圓角矩形背景，左上角標註語言別。
4. 產出 `.pptx` 後，渲染縮圖逐頁檢查：對齊、重疊、可讀性、文字是否溢出、程式碼區塊斷行是否合理。
5. 回報產出位置與需要人工確認的頁面。

使用內建 `generate.js` 快速產出：

```bash
node ~/.agents/skills/gen-pptx/generate.js plan.json output.pptx
```

## 完成前檢查

- [ ] 總概念清楚，且每頁只有一個主重點
- [ ] 觀眾（RD / FAE / AE / 客戶）、用途、時間、頁數與交付格式明確
- [ ] 每頁有頁面角色與 visual 規劃
- [ ] 字級、邊距、對齊、色系一致
- [ ] 程式碼與 register 值使用等寬字型，沒有亂碼或斷行錯誤
- [ ] 表格中數值靠右對齊、單位統一、關鍵欄有 highlight
- [ ] 沒有洩漏密鑰、NDA 內容、private token 或 repo 私密設定
- [ ] `.pptx` 已生成並完成縮圖檢查
- [ ] 已告知檔案位置與需要人工確認的頁面

## 完成回報格式

```
## opencode-gen-pptx 安裝完成

- pptxgenjs (npm)：✅ / ⚠️ 已補裝
- generate.js：✅ 已安裝
- 測試產出：✅ 成功 / ❌ 失敗
```

## 給 Agent 的核心提醒

1. 不要把 spec / code 清單直接塞進投影片；先抽出工程師需要理解的主線與決策邏輯。
2. 預設零金鑰、可編輯、PowerPoint 原生元件優先。
3. 產出前必做縮圖檢查，特別是複雜表格斷頁與程式碼區塊溢出的問題。
4. 涉及本機檔案或 NDA 資料時，用清楚路徑回報，但不要顯示檔案內容。
5. 預設使用工程色系（深藍主色 + 技術藍 + 橙色強調），除非使用者指定不同配色。
