# OpenCode 懶人包 #29：安裝 SOLO Agent — 全自動全棧開發模式

> 版本：v0.3
> 更新日期：2026-07-20

---

## 這個懶人包會幫你做什麼？

在 OpenCode 中建立一個全新的 **SOLO 模式 Primary Agent**，讓你可以：

- **一次高階需求**，AI 自動完成「規劃→建構→測試→交付」全流程
- **全開 / 批次確認 / 逐步驟確認** 三種運行模式可切換
- **自動測試閉環** — 錯誤自動修正並重測（最多 3 次）
- **支援安裝層級切換** — 可自由在全域與專案間搬遷設定

---

## SOLO vs Plan vs Build 模式分析

### 差異對照

| 比較維度 | Plan 模式 | Build 模式 | SOLO 模式 |
|---------|-----------|-----------|-----------|
| **主導者** | AI 規劃 → 人類審核後才執行 | 人類主導，AI 即時輔助 | **AI 全權執行**，人類只下需求與驗收 |
| **互動密度** | 高 — 多次確認計畫與設計 | 中 — 邊做邊問 | **低** — 一次性需求，完整交付 |
| **任務範圍** | 僅產出規劃文件 | 單點 / 區域修改 | **全專案跨檔案** |
| **測試驗證** | 無 | 依需求手動觸發 | **自動測試閉環 + 錯誤自癒** |
| **錯誤處理** | N/A | 人類讀 log 除錯 | AI 自動讀 log → 修正 → 重測（最多 3 次） |
| **需求明確度** | 低 → 中（適合模糊需求） | 中 → 高 | **高**（需求越明確效果越好） |
| **風險等級** | 低（人類層層把關） | 中 | **高**（需信任 AI） |
| **產出物** | `docs/plan.md` 等文件 | 局部程式碼修改 | 完整可運作功能 + 測試 + 交付摘要 |

### 使用時機建議

```
需求明確度 高 ───────── SOLO / Build
需求明確度 低 ───────── Plan → Build
跨檔案改動 大 ───────── SOLO
單檔案小改動 ───────── Build
需要先審核架構 ───── Plan
雛型快速驗證 ───────── SOLO
```

### 注意事項

1. **信任基礎**：SOLO 模式會自動執行 bash 指令與修改檔案，建議初次使用先選「逐步驟確認模式」觀察行為
2. **需求品質**：需求越模糊，結果越偏離預期。SOLO 模式適合「需求明確、成果可預期」的任務
3. **專案規則**：建議搭配專案 `AGENTS.md` 明確定義技術棧與規範，否則 SOLO 可能用錯套件或風格
4. **權限管理**：安裝後建議將 `permission.*` 設為 `ask` 作為安全邊界，僅允許 `solo` 使用全開權限

---

## 先備條件

- [ ] 已完成 **懶人包 #00：環境建置**（Node.js + OpenCode）

---

## 請 OpenCode 幫我執行以下步驟

### 步驟一：確認你的平台

你使用的是 **OpenCode** 還是 **Trae IDE**？

後續步驟會根據你的平台，將 SOLO Agent 設定寫入對應的設定檔位置。

---

### 步驟二：選擇安裝層級

```
你希望 SOLO Agent 安裝在：

1. 【全域層級】— 所有 OpenCode 專案都能使用（建議）
2. 【專案層級】— 僅當前專案可用
```

根據你的選擇，設定會寫入不同的位置：

| 層級 | OpenCode | Trae IDE |
|------|----------|----------|
| **全域** | `~/.config/opencode/opencode.json` | `~/.cursor/mcp.json`（不支援自訂 Agent） |
| **專案** | `./opencode.json` | 不支援 |

回答後請記錄：後續步驟會根據你的選擇使用對應路徑。
- 【全域】→ `~/.config/opencode/opencode.json`
- 【專案】→ `./opencode.json`

> Trae IDE 不支援自訂 Primary Agent，因此 SOLO 模式僅限 OpenCode 使用。

---

### 步驟三：寫入 Agent 設定（含備份與驗證）

#### 3a. 自動安裝（建議 — 使用 `opencode agent create`）
```bash
# 互動式建立基本 agent 結構
opencode agent create \
  --description "全自動全棧開發 — 一次需求，自動完成規劃→建構→測試→交付" \
  --mode primary \
  --permissions bash,read,edit,glob,grep,webfetch,task,todowrite,websearch,lsp,skill
```
建立後，需手動將下方 prompt 內容填入 `opencode.json` 中 `agent.solo.prompt` 欄位。

#### 3b. 手動寫入（附備份還原機制）
若 CLI 不可用，依以下步驟手動編輯：

**Step 1 — 設定 TARGET_FILE 與備份**
根據步驟 2 選擇的層級設定路徑：
- **全域層級**：`TARGET_FILE=~/.config/opencode/opencode.json`
- **專案層級**：`TARGET_FILE=./opencode.json`

```bash
# 請根據步驟 2 的選擇設定正確路徑
TARGET_FILE=~/.config/opencode/opencode.json  # 選全域用此行
# TARGET_FILE=./opencode.json                  # 選專案用此行（取消註解、註解掉上方那行）

if [ ! -f "$TARGET_FILE" ]; then
  echo "⚠️ $TARGET_FILE 不存在，將建立新檔案"
  echo "{}" > "$TARGET_FILE"
fi
BACKUP_FILE="$TARGET_FILE.bak.$(date +%Y%m%d%H%M%S)"
cp "$TARGET_FILE" "$BACKUP_FILE"
```
**Step 2 — 使用 `jq` 安全寫入**
```bash
cat > /tmp/solo-prompt.txt << 'PROMPT_EOF'
你是一個名為 SOLO 的高階全棧工程師 Agent。目標：將高階需求自動化轉為高品質程式碼並完成測試驗證。

## 運行前模式選擇
收到需求時先問使用者：「請選擇模式：
1. 全開 — 直接執行所有操作
2. 批次確認 — 每 3~5 步驟一組，一次性許可後整組執行
3. 逐步驟 — 每步 bash 先描述再等你確認」

批次確認：清單分批，依序請示「第 1 組（共 N 組）：[摘要] 是否允許？」
逐步驟：每次 bash 先說明「我要執行 XXX，目的是 YYY」，等回應後再執行。

## 執行流程
依序執行以下六個階段，不可跳過：

### Phase 0：環境偵測
找專案根目錄：cwd 為起點，向上找到有設定檔的目錄。monorepo 以子目錄為準。

讀取設定檔決定測試指令：
JS/TS→npm test, Python→pytest, Rust→cargo test,
Go→go test ./..., Makefile→make test, Ruby→bundle exec rspec
無測試框架 → 編譯/語法檢查取代，輸出提示。
記錄結果供 Phase 3 使用。

### Phase 0b：參考文件處理（無文件則跳過）
掃描對話中非 MD 檔案或 URL：

1. 確認所需技能已安裝：嘗試載入該 skill，若系統回報未安裝則提示使用者
   （未安裝 → 提示「請先裝懶人包 #12 或 #13」→ 暫停）

2. 少量(1~3份,<50頁) → markitdown 轉 MD 後讀取
   大量(4+份,或需交叉查詢) → graphify 建圖譜，用 `/graphify query` 查詢

輸出處理結果，無文件則跳過。

### Phase 1：Plan（需求拆解與計畫）
0. 需求釐清：若缺功能/技術棧/邊界/驗收標準，列出假設問使用者確認。
   仍不明確或跨多子系統 → 載入 brainstorming 技能做完整設計對話。
   明確則跳過。
1. 分析專案結構，產出 Task Checklist
2. 輸出：「計畫已完成，即將開始...」
3. 有 git → `git stash push -m "solo-before-build"` 保護使用者工作

### Phase 2：Build（程式碼撰寫）
1. 依 Task Checklist 分批實作，每批 3~5 個檔案
2. 遵循專案既有的 Coding Style 與命名規範
3. 不中斷詢問小問題，批次完成後自動進入 Phase 3

### Phase 3：測試與自動修正
1. 執行測試指令（優先 `timeout 120 <指令>`，無 timeout 則直接執行）
   （通過 = exit code 0，不依賴 output）
2. 失敗最多重試 3 次：
   a. 讀 error log，分析錯誤類型
   b. `git checkout -- .` 還原 SOLO 的修改
   c. 換不同策略修正 → 重測
   d. git diff 為空 → 立即停止
3. 有 git → `git stash pop` 還原使用者工作（有衝突則提示手動處理）
4. 3 次仍失敗 → 輸出錯誤摘要 + diff + 建議

### Phase 4：Deliver（總結與交付）
1. 條列本次所有的修改重點與新增功能
2. 說明如何啟動專案或驗證最終成果
3. **輸出後等待使用者反饋，不要自動執行下一步（如 commit、push 等）**
4. 使用者提出新需求時 → 回到 Phase 0 重新偵測環境並重複流程
   使用者要求調整現有成果 → 回到 Phase 2 修改檔案

## 安全規範
1. 切勿執行破壞性指令（rm -rf /、未經允許的 git push --force 等）
2. 切勿將敏感資訊（金鑰、Token）寫入程式碼或 Commit
PROMPT_EOF

jq --rawfile prompt /tmp/solo-prompt.txt \
  '.agent.solo = {
    "description": "全自動全棧開發 — 一次需求，自動完成規劃→建構→測試→交付",
    "mode": "primary",
    "permission": [
      { "permission": "*", "action": "allow", "pattern": "*" },
      { "permission": "doom_loop", "action": "ask", "pattern": "*" }
    ],
    "prompt": $prompt
  }' "$TARGET_FILE" > "$TARGET_FILE.tmp" && mv "$TARGET_FILE.tmp" "$TARGET_FILE"
```

#### 3c. 驗證 JSON 語法
```bash
if jq . "$TARGET_FILE" > /dev/null 2>&1; then
  echo "✅ JSON 語法驗證通過"
else
  echo "❌ JSON 語法錯誤！正在還原備份..."
  cp "$BACKUP_FILE" "$TARGET_FILE"
  echo "已自動還原至備份版本。請檢查後重試。"
  exit 1
fi
```

#### 3d. 驗證 Agent 已註冊
```bash
opencode agent list 2>/dev/null | grep -q "solo" && echo "✅ SOLO Agent 已成功註冊"
```

---

### 步驟四：設定權限保護

SOLO Agent 的權限已在步驟三寫入，採用 OpenCode 原生的陣列格式：

```json
"permission": [
  { "permission": "*", "action": "allow", "pattern": "*" },
  { "permission": "doom_loop", "action": "ask", "pattern": "*" }
]
```

- `"*": "allow"` — SOLO 可使用所有工具（bash、edit、read 等）
- `"doom_loop": "ask"` — 避免無限迴圈

若要限制其他 agent 的權限，請在各 agent 的 `permission` 區塊分別設定。

---

### 步驟五：建立 AGENTS.md 專案規則（選用）

若要 SOLO 模式寫出的程式碼符合專案規範，建議在專案根目錄建立 `AGENTS.md`，明確定義：

- 使用的技術棧（語言、框架、版本）
- Coding Style 偏好（命名規範、縮排、註解風格等）
- 測試框架與指令
- Git 流程規範

SOLO Agent 啟動時會自動讀取此檔案作為上下文。

---

### 步驟六：驗證

1. 重新啟動 OpenCode
2. 按 **Tab** 切換 agent，或輸入 `/agent solo` 切換到 SOLO 模式
3. 輸入以下測試需求：

```
幫我建立一個 Hello World CLI 工具，用 Python 寫，然後寫測試並執行。
```

4. 觀察 SOLO 是否依序：
   - [ ] 先詢問要使用哪種模式（全開 / 批次確認 / 逐步驟確認）
   - [ ] 自動偵測環境與測試框架（Phase 0）
   - [ ] 處理參考文件（Phase 0b），若無則跳過
   - [ ] 分析環境與需求（Phase 1 — Plan）
   - [ ] 建立檔案（Phase 2 — Build）
   - [ ] 自動執行測試並修正（Phase 3 — Test & Verify）
   - [ ] 輸出交付總結（Phase 4 — Deliver）

---

## 完成回報格式

```md
## SOLO Agent 安裝完成

- 安裝層級：全域 / 專案
- 平台：OpenCode
- SOLO Agent：已啟用
- 權限設定：全開（陣列格式，含 doom_loop 保護）
- 備份檔案：`~/.config/opencode/opencode.json.bak.20260720xxxxxx`
- 驗證測試：通過 / 失敗
```

---

## 運行模式切換

SOLO Agent 在每次收到需求時，會先詢問要使用哪種模式：

| 模式 | bash 行為 | 適用情境 |
|------|-----------|---------|
| **全開模式** | 直接執行，不詢問 | 已建立信任、緊急任務、批次任務 |
| **批次確認模式** | 每 3~5 步驟一組列出摘要，一次性許可後整組執行 | 一般日常開發 |
| **逐步驟確認模式** | 每次 bash 前先描述再執行，等你確認 | 初次使用、高風險操作、學習階段 |

---

## 層級切換

安裝後，你可以隨時要求 OpenCode 切換 SOLO Agent 的安裝層級：

| 指令 | 效果 |
|------|------|
| 「把 SOLO 從全域移到專案層級」 | 從 `~/.config/opencode/opencode.json` 搬到 `./opencode.json` |
| 「把 SOLO 從專案移到全域層級」 | 從 `./opencode.json` 搬到 `~/.config/opencode/opencode.json` |

---

## 解除安裝

### 移除 Agent 設定

編輯對應的 `opencode.json`，從 `"agent"` 區塊移除整個 `"solo"` 段落。

### 移除權限設定（選用）

若你曾手動編輯權限設定，可依需要一併移除 SOLO 的 permission 規則。

---

## 常見問題

| 問題 | 解法 |
|------|------|
| 找不到 `solo` agent | 確認 `opencode.json` 的 `agent` 區塊已正確寫入，重新啟動 OpenCode |
| SOLO 一直問我問題 | 這是逐步驟確認模式的正常行為。可以說「切換到全開模式」或「切換到批次確認模式」減少詢問 |
| SOLO 寫的程式碼風格不對 | 在專案 `AGENTS.md` 明確定義 coding style |
| SOLO 測試一直失敗 | 3 次重試後會輸出錯誤摘要。可說「回到 Phase 2 修改」讓 SOLO 修正，或手動修正後重下需求 |
| 想讓 SOLO 更積極 | 可以編輯 prompt 調整「最多重試 3 次」的數值 |

---

## Trae 對應操作

> Trae IDE **不支援**自訂 Primary Agent，因此 SOLO 模式無法在 Trae IDE 中使用。
> 若您同時使用 OpenCode 與 Trae IDE，SOLO 模式僅在 OpenCode 終端機中可用。

---

## 更新紀錄

| 日期 | 版本 | 更新內容 |
|------|------|---------|
| 2026-07-20 | v0.3 | prompt 濃縮 36%、Phase 0b 參考文件、Phase 1 stash 保護、Phase 4 STOP 訊號、timeout fallback、權限陣列格式修正 |
| 2026-07-20 | v0.2 | 加入備份還原機制、Phase 0 環境偵測、批次確認模式；強化 Phase 3 錯誤處理 |
| 2026-07-20 | v0.1 | 初版 |
