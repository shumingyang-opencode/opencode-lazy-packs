---
name: awesome-design-md
description: 品牌設計套用技能 — 從 73 個真實品牌（Stripe、Vercel、Apple、Figma 等）的
            DESIGN.md 中挑選並下載到專案使用。說「用 Stripe 的設計」「套用 Vercel 風格」
            「有哪些品牌設計」「推薦一個品牌」「awesome design」時載入。
---

# Awesome DESIGN.md 品牌設計套用技能

從 73 個真實品牌的設計系統中挑選，下載 DESIGN.md 到你的專案。

## 品牌目錄

73 個品牌分為 10 大類。以下是完整清單：

### AI & LLM Platforms
claude, cohere, elevenlabs, minimax, mistral.ai, ollama, opencode.ai, replicate, runwayml, together.ai, voltagent, x.ai

### Developer Tools & IDEs
cursor, expo, lovable, raycast, superhuman, vercel, warp

### Backend, Database & DevOps
clickhouse, composio, hashicorp, mongodb, posthog, sanity, sentry, supabase

### Productivity & SaaS
cal.com, intercom, linear.app, mintlify, notion, resend, slack, zapier

### Design & Creative Tools
airtable, clay, figma, framer, miro, webflow

### Fintech & Crypto
binance, coinbase, kraken, mastercard, revolut, stripe, wise

### E-commerce & Retail
airbnb, meta, nike, shopify, starbucks

### Media & Consumer Tech
apple, hp, ibm, nvidia, pinterest, playstation, spacex, spotify, theverge, uber, vodafone, wired

### Automotive
bmw, bmw-m, bugatti, ferrari, lamborghini, renault, tesla

### Retro Web
dell-1996, nintendo-2001

## 使用方式

### 瀏覽品牌

用戶說「有哪些品牌設計？」時，列出上述目錄（分類瀏覽）。

### 套用品牌設計

1. 用戶指定品牌名稱（如 `stripe`、`vercel`、`apple`）
2. 從 GitHub clone 取得 DESIGN.md：
   ```bash
   git clone --depth 1 https://github.com/VoltAgent/awesome-design-md.git /tmp/awesome-design-md && cp /tmp/awesome-design-md/design-md/<品牌名稱>/DESIGN.md ./
   ```
3. 寫入專案根目錄 `DESIGN.md`
4. 若專案已有 DESIGN.md，備份為 `DESIGN.md.bak`

### 查詢品牌

指定品牌如「Stripe 的配色是什麼？」時，從 DESIGN.md 的 Color Palette 章節提取資訊回答。

### 推薦品牌

用戶說「推薦一個品牌」時，根據專案類型推薦對應分類的品牌。

## 與 OMD 整合

- 若偵測到 `omd:init` 已安裝 → 提供「用 omd:init 客製化此設計」
- 若偵測到 `omd:apply` 已安裝 → 提示用戶後續可直接進行 UI 設計
- 單純下載 DESIGN.md 也可獨立使用

## 技術說明

- 每個 DESIGN.md 包含 9 個章節：視覺主題、色板、字體、元件、佈局、深度、注意事項、響應式、提示
- 檔案格式：標準 Markdown，遵循 Google Stitch DESIGN.md 規範
- 來源：https://github.com/VoltAgent/awesome-design-md（MIT 授權）
