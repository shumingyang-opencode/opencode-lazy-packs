# OpenCode 懶人包 #02：連接 GitHub

> 版本：v0.4
> 更新日期：2026-07-22

---

## 這個懶人包會幫你做什麼？

讓 OpenCode 可以 commit、push、建立 repo 並驗證連接：
- 檢查 Git / GitHub CLI
- 用網頁端登入 GitHub CLI
- 設定 Git 使用者資訊
- 建立測試 repo 驗證 commit / push

---

## 先備條件

- [ ] 已完成 **懶人包 #00：環境建置**（Node.js + OpenCode）
- [ ] Git 已安裝（若無則下方有安裝指引）
- [ ] GitHub CLI（gh）已安裝
- [ ] 已有 GitHub 帳號
- [ ] 電腦有網路

---

## 請 OpenCode 幫我執行以下步驟

### 步驟〇：查閱帳號資訊

先讀取 OpenCode 根目錄的 `個人帳號與服務清單.md`（若存在），取得 GitHub 帳號資訊：
- 若找到帳號資訊 → 直接套用，跳過詢問帳號
- 若檔案不存在或資訊不足 → 詢問使用者後寫回

> 此檔案位於 Obsidian vault 根目錄，OpenCode 可透過 Obsidian MCP 讀寫。

### 步驟一：檢查 Git 與 GitHub CLI

```bash
git --version
gh --version
```

如果 Git 未安裝，前往 https://git-scm.com/downloads 下載安裝，或透過套件管理員安裝（macOS: `brew install git`、Windows: `winget install Git.Git`）。

---

### 步驟二：登入 GitHub CLI

檢查登入狀態：
```bash
gh auth status
```

如果尚未登入：
```bash
gh auth login --web --git-protocol https
```

流程：
1. 終端機顯示一次性驗證碼
2. 瀏覽器開啟 https://github.com/login/device
3. 輸入驗證碼並授權
4. 回到終端機確認：`gh auth status`

成功時應看到：
```
Logged in to github.com account <你的帳號>
Git operations protocol: https
Token scopes: ... repo ...
```

---

### 步驟三：設定 Git 使用者資訊

檢查：
```bash
git config --global user.name
git config --global user.email
```

如果未設定，請輸入：
```bash
git config --global user.name "你的姓名"
git config --global user.email "你的email@example.com"
```

---

### 步驟四：建立測試 repo 驗證 commit / push

建立測試資料夾：
```bash
mkdir ~/Documents/opencode-github-test
cd ~/Documents/opencode-github-test
```

建立測試檔：
```bash
echo "# OpenCode GitHub 測試" > README.md
```

初始化並提交：
```bash
git init
git add README.md
git commit -m "建立 OpenCode GitHub 測試"
```

建立 GitHub repo 並 push：
```bash
gh repo create opencode-github-test --private --source=. --push
```

驗證：
```bash
gh repo view opencode-github-test --web
```

---

### 步驟五：測試 repo 要保留還是刪除

測試成功後，詢問使用者是否刪除。

若要刪除 GitHub repo：
```bash
gh repo delete opencode-github-test --yes
```

若要刪除本機測試資料夾：
```bash
test_dir="$HOME/Documents/opencode-github-test"
[ "$test_dir" = "$HOME/Documents/opencode-github-test" ] && rm -rf "$test_dir"
```

---

## 完成回報格式

```md
## GitHub 連接完成

- Git：已安裝 / 已補裝
- GitHub CLI：已安裝 / 已補裝
- gh 登入：成功 / 失敗
- Git 使用者資訊：已設定 / 待設定
- commit / push 測試：成功 / 未執行
- 測試 repo：保留 / 已刪除
```

---

## 常見問題

| 問題 | 解法 |
|------|------|
| `gh auth login` 等逾時 | 開啟可互動的 PowerShell 視窗手動執行 |
| `gh auth status` 未登入 | `gh auth login --web --git-protocol https` |
| Git 全域姓名未設定 | `git config --global user.name` / `user.email` 補上 |

---

## 解除安裝

本懶人包未安裝任何 CLI 工具，Git 與 GitHub CLI（`gh`）為系統既有或由其他懶人包管理。

### 移除 GitHub CLI（若不再需要）

```bash
brew uninstall gh     # macOS
winget uninstall GitHub.cli    # Windows
```

---

## Trae 對應操作

> 若你使用 **Trae IDE**，安裝方式與 OpenCode 完全相同。
> 所有 CLI 工具（git、gh 等）在 Trae 環境中可直接使用。

### 在 Trae 上安裝

與上方步驟完全相同，無需額外設定。

### 在 Trae 上更新

與 OpenCode 相同。

### 在 Trae 上移除

與 OpenCode 相同。

---

## 更新紀錄

| 日期 | 版本 | 更新內容 |
|------|------|---------|
| 2026-07-22 | v0.4 | 移除協作者設定步驟（已手動完成，不再自動化） |
| 2026-07-22 | v0.3 | 移除 GitHub Pages 步驟；協作者帳號改用 placeholder 去敏；修正解除安裝區塊格式 |
| 2026-06-18 | v0.2 | 加入建立 repo 後邀請協作者的步驟 |
| 2026-05-19 | v0.1 | 初版 |
