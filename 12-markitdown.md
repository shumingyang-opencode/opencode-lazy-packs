# OpenCode 懶人包 #12：MarkItDown 文件轉換技能

> 版本：v0.3
> 更新日期：2026-07-02

---

## 這個懶人包會幫你做什麼？

讓 OpenCode 可以自動將非 Markdown 文件（PDF、Word、Excel、PowerPoint、HTML、CSV、JSON、XML、圖片等）轉換為 Markdown 格式：

- 安裝 MarkItDown（Microsoft 官方文件轉換工具，含音訊轉錄支援）
- 安裝 ffmpeg（音訊解碼所需）
- 安裝 markitdown skill（SKILL.md + convert.py）
- 設定 opencode.json 權限
- 測試文件轉換
- 完成後遇到檔案自動先轉 MD 再處理

---

## 先備條件

- [ ] 已完成 **懶人包 #00：環境建置**
- [ ] Python 3.10+ 已安裝
- [ ] uv 已安裝

---

## 請 OpenCode 幫我執行以下步驟

### 步驟一：安裝 MarkItDown 工具

```bash
uv tool install 'markitdown[xls,audio-transcription]'
```

確認版本：
```bash
markitdown --version
```

### 步驟一-b：安裝 ffmpeg（音訊轉錄所需）

MarkItDown 的音訊轉換（.wav / .mp3）需要 ffmpeg 解碼音訊格式：

```bash
# macOS
brew install ffmpeg

# Ubuntu / Debian
sudo apt install ffmpeg

# Windows
winget install ffmpeg
```

驗證安裝：
```bash
ffmpeg -version
```

### 步驟二：安裝 markitdown skill 檔案

建立目錄：
```bash
mkdir -p ~/.config/opencode/skills/markitdown
```

從本 repo 複製 SKILL.md：
```bash
curl -o ~/.config/opencode/skills/markitdown/SKILL.md https://<COMPANY_GITLAB_URL>/<GITLAB_USERNAME>/agents-lazy-packs/-/raw/main/skills/12-markitdown/SKILL.md
```

複製 convert.py：
```bash
curl -o ~/.config/opencode/skills/markitdown/convert.py https://<COMPANY_GITLAB_URL>/<GITLAB_USERNAME>/agents-lazy-packs/-/raw/main/scripts/convert.py
```

### 步驟三：設定 opencode.json 權限

編輯 `~/.config/opencode/opencode.json`，在 `permission.skill` 加入：

```json
"markitdown": "allow"
```

### 步驟四：測試轉換

```bash
python ~/.config/opencode/skills/markitdown/convert.py <任意 PDF 或 DOCX 檔案路徑>
```

### 步驟五：驗證

重啟 OpenCode 後提供一個 PDF 檔案給它，說：
```
幫我解析這個檔案
```

---

## 支援的檔案格式

| 格式 | 副檔名 | 支援程度 |
|------|--------|---------|
| PDF | .pdf | ✅ 完整支援 |
| Word | .docx | ✅ 完整支援 |
| Excel | .xlsx, .xls | ✅ 完整支援（含舊版 .xls） |
| PowerPoint | .pptx | ✅ 完整支援 |
| 音訊 | .wav, .mp3 | ✅ 語音轉文字 |
| HTML | .html, .htm | ✅ 完整支援 |
| CSV | .csv | ✅ 完整支援 |
| JSON | .json | ✅ 完整支援 |
| XML | .xml | ✅ 完整支援 |
| 圖片 | .jpg, .png, .gif, .webp | ✅ OCR 文字提取 |
| EPUB | .epub | ✅ 完整支援 |
| ZIP | .zip | ✅ 壓縮包內文件 |
| Outlook 郵件 | .msg | ✅ 郵件轉換 |

---

## 完成回報格式

```md
## MarkItDown 技能安裝完成

- MarkItDown：v<版本> ✅ / ⚠️ 已補裝
- convert.py：✅ 已安裝 / ⚠️ 待下載
- opencode.json 權限：✅ markitdown: allow
- 測試轉換：✅ 成功 / ❌ 失敗
```

---

## 常見問題

| 問題 | 解法 |
|------|------|
| `markitdown` 指令找不到 | 確認 `uv tool list` 有列出 markitdown，並確認 `~/.local/bin` 在 PATH 中 |
| 轉換中文 PDF 亂碼 | 安裝中文字型：`brew install font-noto-sans-cjk` (macOS) 或 `apt install fonts-noto-cjk` (Linux) |
| 不支援的格式 | 確認檔案類型，或先用 `file` 指令檢查 |

---

## 解除安裝

### 移除 Skill

```bash
rm -rf ~/.config/opencode/skills/markitdown/
```

### 移除 Permission

編輯 `~/.config/opencode/opencode.json`，從 `"permission"` 的 `"skill"` 區塊移除 `"markitdown": "allow"`。

### 移除 CLI 工具

```bash
uv tool uninstall markitdown
```

---

## Trae 對應操作

> 若你使用 **Trae IDE**，以下為對應的安裝/更新/移除步驟。

### 在 Trae 上安裝

1. 將本技能放入 `.trae/skills/markitdown/` 目錄：
   ```bash
   mkdir -p .trae/skills/markitdown/
   ```
2. 從本 repo 的 `skills/12-markitdown/SKILL.md` 及 `scripts/convert.py` 複製到 `.trae/skills/markitdown/`
3. 重新載入 Trae（Cmd+R / Ctrl+R）
4. 對 Trae 說「幫我解析這個檔案」，確認可載入

> CLI 工具的安裝方式與 OpenCode 相同（npm/pipx/brew），無需額外步驟。

### 在 Trae 上更新

替換 `.trae/skills/markitdown/SKILL.md` 的內容即可。

### 在 Trae 上移除

```bash
rm -rf .trae/skills/markitdown/
```

---

## 更新紀錄

| 日期 | 版本 | 更新內容 |
|------|------|---------|
| 2026-06-21 | v0.1 | 初版 |
| 2026-07-02 | v0.2 | 新增音訊（.wav/.mp3）與舊版 Excel（.xls）支援 |
| 2026-07-02 | v0.3 | 新增 ffmpeg 安裝步驟（音訊轉解碼所需） |
