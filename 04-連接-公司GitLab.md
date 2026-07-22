# OpenCode 懶人包 #04：連接公司 GitLab

> 版本：v0.2
> 更新日期：2026-07-22

---

## 這個懶人包會幫你做什麼？

讓你可以從本機連接到 <COMPANY_NAME> 內部 GitLab 伺服器：
- 檢查 Git 安裝
- 建立 Personal Access Token（PAT）
- 設定 Git credential helper 記住 PAT
- 設定 Git remote 使用 HTTPS
- 簽出（clone）開發專案
- 日常推拉操作

---

## GitLab 伺服器資訊

| 項目 | 內容 |
|------|------|
| 伺服器網址 | `https://<COMPANY_GITLAB_URL>` |
| 協定 | HTTPS（使用 PAT 認證） |
| Git remote 格式 | `https://<COMPANY_GITLAB_URL>/<GITLAB_USERNAME>/<專案>.git` |
| 使用者名稱 | `<GITLAB_USERNAME>` |
| Credential 檔案 | `~/.git-credentials-gitlab-ovt` |

---

## 先備條件

- [ ] 公司內網或 VPN 連線正常
- [ ] Git 已安裝（若無，先跑**懶人包 #00：環境建置**）
- [ ] 有 GitLab 帳號權限

---

## 平台檢查

> 🖐️ **請 OpenCode 在開始前先詢問使用者：**
>
> 「你目前在公司內網或 VPN 中嗎？GitLab 伺服器 `<COMPANY_GITLAB_URL>` 需要內網連線。」
>
> - **不在公司內網且未連 VPN** → 直接跳過，顯示「此懶人包需要公司內網連線，目前環境不適用」
> - **公司內網或已連 VPN** → 繼續執行下方步驟

---

## 請 OpenCode 幫我執行以下步驟

### 步驟〇：查閱帳號資訊

先讀取 OpenCode 根目錄的 `個人帳號與服務清單.md`（若存在），取得公司 GitLab 資訊：
- 若找到伺服器 URL、帳號、認證方式 → 直接套用，跳過詢問
- 若檔案不存在或資訊不足 → 詢問使用者後寫回

> 此檔案位於 Obsidian vault 根目錄，OpenCode 可透過 Obsidian MCP 讀寫。

### 步驟一：檢查 Git 安裝

```bash
git --version
```

預期看到 `git version 2.x.x`。

---

### 步驟二：建立 Personal Access Token

請使用者手動操作（PAT 無法從 CLI 自動建立）：
1. 瀏覽器開啟 `https://<COMPANY_GITLAB_URL>/-/user_settings/personal_access_tokens`
2. 登入帳號 `<GITLAB_USERNAME>`
3. 填寫：
   - **Token name**：`opencode-local`
   - **Expiration date**：自選（建議設 1 年後）
   - **Scopes**：勾選 `read_repository`、`write_repository`
4. 點 **Create personal access token**
5. **立即複製**產生的 token（離開頁面後無法再看到）

---

### 步驟三：設定 Git credential 儲存 PAT

將 PAT 存入獨立的 credential 檔案（與個人 GitLab.com 分開管理）：

**Windows（PowerShell）：**
```powershell
Set-Content -Path "$env:USERPROFILE\.git-credentials-gitlab-ovt" -Value "https://<GITLAB_USERNAME>:<PAT>@<COMPANY_GITLAB_URL>"
git config --global credential.helper "store --file ~/.git-credentials-gitlab-ovt"
```

**macOS：**
```bash
echo "https://<GITLAB_USERNAME>:<PAT>@<COMPANY_GITLAB_URL>" > ~/.git-credentials-gitlab-ovt
chmod 600 ~/.git-credentials-gitlab-ovt
git config --global credential.helper "store --file ~/.git-credentials-gitlab-ovt"
```

> ⚠️ 確認將 `<PAT>` 替換為步驟二複製的 token。
> ⚠️ 若公司 GitLab 使用自簽憑證，需額外設定：`git config --global http.sslVerify false`（或設定 CA 憑證路徑）。

---

### 步驟四：驗證連線

```bash
git ls-remote https://<COMPANY_GITLAB_URL>/<GITLAB_USERNAME>/your-project.git
```

預期看到類似輸出（包含 commit hash 和 ref 列表）。

若看到：
```
remote: HTTP Basic: Access denied
```
表示 PAT 無效或權限不足，請回到步驟二重建 PAT。

---

### 步驟五：建立專案資料夾並 clone 測試

```bash
mkdir -p ~/Documents/gitlab-projects
cd ~/Documents/gitlab-projects
```

clone 一個測試專案（請使用者提供專案 HTTPS URL，或使用已知專案）：
```bash
git clone https://<COMPANY_GITLAB_URL>/<GITLAB_USERNAME>/your-project.git
cd your-project
```

---

### 步驟六：設定本機 Git 使用者（若尚未設定）

```bash
git config --global user.name "<GITLAB_USERNAME>"
git config --global user.email "<EMAIL>"
```

---

## 日常操作

```bash
cd ~/Documents/gitlab-projects/your-project
git pull              # 拉取最新
git status            # 查看狀態
git add <檔案>        # 暫存
git commit -m "feat: 訊息"  # 提交
git push              # 推送
```

> Git 會自動使用 credential helper 中的 PAT 進行驗證，不需每次輸入。

---

## 完成回報格式

```md
## 公司 GitLab 連接完成

- 環境：公司內網 / VPN / 跳過（不在內網）
- Git 版本：（版本號）
- PAT：已產生 / 未產生
- credential helper：已設定 / 未設定
- 遠端驗證（git ls-remote）：成功 / 失敗
- clone 測試：成功 / 未執行
- 本機目錄：（路徑）
```

---

## 常見問題

| 問題 | 平台 | 解法 |
|------|------|------|
| `fatal: unable to access ... Connection refused` | 通用 | 確認在公司內網或 VPN 中 |
| `fatal: Authentication failed` | 通用 | PAT 過期或無效，回步驟二重建 |
| `remote: HTTP Basic: Access denied` | 通用 | PAT scope 缺少 `write_repository` |
| `could not read Password for ...` | 通用 | credential helper 未設定，或 store 檔案遺失 |
| `SSL certificate problem` | 通用 | 自簽憑證未信任，設定 `git config --global http.sslVerify false` 或匯入 CA 憑證 |
| `fatal: repository not found` | 通用 | 確認專案路徑正確，且你有存取權限 |

---

## 快速參考卡

```bash
# 設定 credential helper
git config --global credential.helper "store --file ~/.git-credentials-gitlab-ovt"

# 驗證連線
git ls-remote https://<COMPANY_GITLAB_URL>/<GITLAB_USERNAME>/your-project.git

# 日常
git clone https://<COMPANY_GITLAB_URL>/<群組>/<專案>.git
git pull
git push
git remote -v                           # 查看 remote URL
```

---

## 解除安裝

本懶人包未安裝專屬 CLI 工具，僅設定 Git credential helper 與 PAT。

### 還原設定

```bash
# 移除自訂的 credential helper
git config --global --unset credential.helper
rm -f ~/.git-credentials-gitlab-ovt
```

---

## Trae 對應操作

> 若你使用 **Trae IDE**，安裝方式與 OpenCode 完全相同。
> 所有 Git 工具在 Trae 終端機中可直接使用。

### 在 Trae 上安裝

與上方步驟完全相同。

### 在 Trae 上更新

與 OpenCode 相同。

### 在 Trae 上移除

與 OpenCode 相同。

---

## 更新紀錄

| 日期 | 版本 | 更新內容 |
|------|------|---------|
| 2026-07-22 | v0.2 | 改用 HTTPS + PAT 認證（移除 SSH 設定）；帳號去敏為 placeholder |
| 2026-06-18 | v0.1 | 初版 |
