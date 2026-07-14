# OpenCode 懶人包 #14：Awesome DESIGN.md 品牌設計套用

> 版本：v0.1
> 更新日期：2026-06-21

---

## 這個懶人包會幫你做什麼？

讓 OpenCode 可以一鍵套用 73 個真實品牌的 DESIGN.md 到你的專案中，無需從頭分析品牌：

- 安裝 awesome-design-md 技能（品牌目錄 + 自動下載）
- 設定 opencode.json 權限
- 從 73 個品牌中挑選喜歡的設計風格
- 自動下載並套用 DESIGN.md 到專案根目錄
- 與現有的 OMD 設計體系（omd:init / omd:apply）無縫整合

---

## 先備條件

- [ ] 已完成 **懶人包 #00：環境建置**
- [ ] 網路連線（首次下載品牌 DESIGN.md 需要）

---

## 請 OpenCode 幫我執行以下步驟

### 步驟一：建立快取目錄

```bash
mkdir -p ~/.config/opencode/skills/awesome-design-md/brands
```

### 步驟二：安裝 skill 檔案

從本 repo 複製 SKILL.md：
```bash
curl -o ~/.config/opencode/skills/awesome-design-md/SKILL.md \
  https://gitlab.ovt.com:8081/steven.yang/agents-lazy-packs/-/raw/main/skills/14-awesome-design-md/SKILL.md
```

### 步驟三：設定 opencode.json 權限

編輯 `~/.config/opencode/opencode.json`，在 `permission.skill` 加入：

```json
"awesome-design-md": "allow"
```

### 步驟四：測試下載一個品牌

直接在 OpenCode 中輸入（會自動載入 skill）：
```
用 Stripe 的設計風格
```

或手動測試下載：
```bash
git clone --depth 1 https://github.com/VoltAgent/awesome-design-md.git /tmp/awesome-design-md && cp /tmp/awesome-design-md/design-md/stripe/DESIGN.md ./
```

檢查 DESIGN.md 內容：
```bash
head -30 DESIGN.md
```

### 步驟五：驗證

確認 DESIGN.md 已存在且包含完整的設計系統定義。

---

## 使用方式

| 情境 | 在 OpenCode 中輸入 |
|------|-------------------|
| 想用某個品牌的設計 | `用 Stripe 的設計` / `套用 Vercel 的風格` |
| 瀏覽可用品牌 | `有哪些品牌設計可以用？` / `列出所有品牌` |
| 下載特定品牌 | `下載 Stripe 的 DESIGN.md` |
| 不確定選哪個 | `推薦一個品牌設計`（會根據你的專案類型推薦） |

### 73 個品牌分類

| 分類 | 品牌 |
|------|------|
| AI & LLM | claude, cohere, elevenlabs, mistral.ai, ollama, opencode.ai, replicate, runwayml, together.ai, x.ai |
| 開發工具 | cursor, expo, raycast, superhuman, vercel, warp |
| 資料庫/DevOps | clickhouse, hashicorp, mongodb, posthog, sentry, supabase |
| SaaS | cal.com, intercom, linear.app, mintlify, notion, resend, zapier |
| 設計工具 | airtable, figma, framer, miro, webflow |
| Fintech | binance, coinbase, kraken, mastercard, revolut, stripe, wise |
| 電商/零售 | airbnb, meta, nike, shopify, starbucks |
| 消費科技 | apple, hp, ibm, nvidia, pinterest, playstation, spacex, spotify, theverge, uber, wired |
| 汽車 | bmw, bmw-m, bugatti, ferrari, lamborghini, renault, tesla |
| 復古網頁 | dell-1996, nintendo-2001 |

---

## 與 OMD 設計體系整合

如果你已經安裝了 OMD 設計技能（omd:init / omd:apply），下載 DESIGN.md 後：

1. **直接套用** → `omd:apply` 會自動讀取 DESIGN.md 並應用到 UI 產生
2. **客製化** → 執行 `omd:init` 選擇你的品牌作為參考基底，調整成自己的風格
3. **比較多個** → 下載多個品牌的 DESIGN.md，用 `omd:apply` 快速切換比較

---

## 完成回報格式

```md
## Awesome DESIGN.md 技能安裝完成

- 快取目錄：~/.config/opencode/skills/awesome-design-md/brands/ ✅
- SKILL.md：✅ 已安裝 / ⚠️ 待下載
- opencode.json 權限：✅ awesome-design-md: allow
- 測試下載：✅ 成功 / ❌ 失敗
```

---

## 常見問題

| 問題 | 解法 |
|------|------|
| 下載 DESIGN.md 失敗 | 確認網路連線，或手動用瀏覽器打開 raw URL 測試 |
| 品牌名稱找不到 | 使用全小寫，如 `stripe` 而非 `Stripe` |
| 想要更多品牌 | 到 https://github.com/VoltAgent/awesome-design-md 查看最新清單 |
| DESIGN.md 如何套用到 UI？ | 安裝 OMD 技能（omd:apply），會自動讀取 DESIGN.md 產生對應的 UI |

---

## 解除安裝

### 移除 Skill

```bash
rm -rf ~/.config/opencode/skills/awesome-design-md/
```

### 移除 Permission

編輯 `~/.config/opencode/opencode.json`，從 `"permission"` 的 `"skill"` 區塊移除 `"awesome-design-md": "allow"`。

---

## Trae 對應操作

> 若你使用 **Trae IDE**，以下為對應的安裝/更新/移除步驟。

### 在 Trae 上安裝

1. 將本技能放入 `.trae/skills/awesome-design-md/` 目錄：
   ```bash
   mkdir -p .trae/skills/awesome-design-md/
   ```
2. 從本 repo 的 `skills/14-awesome-design-md/SKILL.md` 複製內容到 `.trae/skills/awesome-design-md/SKILL.md`
3. 重新載入 Trae（Cmd+R / Ctrl+R）
4. 對 Trae 說「用 Stripe 的設計」，確認可載入

### 在 Trae 上更新

替換 `.trae/skills/awesome-design-md/SKILL.md` 的內容即可。

### 在 Trae 上移除

```bash
rm -rf .trae/skills/awesome-design-md/
```

---

## 更新紀錄

| 日期 | 版本 | 更新內容 |
|------|------|---------|
| 2026-06-21 | v0.1 | 初版 |
