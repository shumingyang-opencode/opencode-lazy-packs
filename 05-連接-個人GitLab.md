# OpenCode 懶人包 #05：連接個人 GitLab

> 版本：v0.1
> 更新日期：2026-06-18

---

## 這個懶人包會幫你做什麼？

讓你可以從本機連接到 `gitlab.com` 上的個人帳號：
- 產生 GitLab Personal Access Token（PAT）
- 設定 Git credential helper 記住 PAT
- 設定 Git remote 使用 HTTPS
- clone 與推拉操作
- 處理防火牆限制（SSH 被封鎖，改走 HTTPS）

---

## GitLab 伺服器資訊

| 項目 | 內容 |
|------|------|
| 伺服器網址 | `https://gitlab.com` |
| 協定 | HTTPS（因防火牆封鎖 SSH 22 埠） |
| Git remote 格式 | `https://gitlab.com/<使用者>/<專案>.git` |
| 使用者名稱 | `Shuming-Yang` |

---

## 先備條件

- [ ] Git 已安裝（若無，先跑**懶人包 #00：環境建置**）
- [ ] 有 `gitlab.com` 帳號（使用者名稱 `Shuming-Yang`）
- [ ] 電腦有網路連線

---

## 請 OpenCode 幫我執行以下步驟

### 步驟一：檢查 Git 安裝

```bash
git --version
```

預期看到 `git version 2.x.x`。

---

### 步驟二：檢查是否已有 GitLab 設定

查看目前 Git 全域設定中的 credential helper：

**Windows：**
```bash
git config --global credential.helper
```
預設為 `manager`（Windows Credential Manager）。

**macOS：**
```bash
git config --global credential.helper
```
預設為 `osxkeychain`。

如果未設定，請設定：
```bash
git config --global credential.helper <helper>
```

---

### 步驟三：建立 Personal Access Token

請使用者手動操作（PAT 無法從 CLI 自動建立）：
1. 瀏覽器開啟 `https://gitlab.com/-/user_settings/personal_access_tokens`
2. 登入帳號 `Shuming-Yang`
3. 填寫：
   - **Token name**：`opencode-local`
   - **Expiration date**：自選（建議不留空，設 1 年後）
   - **Scopes**：勾選 `read_repository`、`write_repository`
4. 點 **Create personal access token**
5. **立即複製**產生的 token（離開頁面後無法再看到）

---

### 步驟四：設定 Git credential 儲存 PAT

將 PAT 存入 Git credential helper：

**Windows（PowerShell）：**
```powershell
git credential-manager reject https://gitlab.com
```

然後第一次 push/clone 時會跳出對話框，使用者名稱填 `Shuming-Yang`，密碼填 PAT。

或者直接寫入 credential store：

```powershell
Set-Content -Path "$env:USERPROFILE\.git-credentials-gitlab-com" -Value "https://Shuming-Yang:<PAT>@gitlab.com"
git config --global credential.helper "store --file ~/.git-credentials-gitlab-com"
```

> ⚠️ 確認將 `<PAT>` 替換為步驟三複製的 token。

**macOS：**
```bash
echo "https://Shuming-Yang:<PAT>@gitlab.com" > ~/.git-credentials-gitlab-com
git config --global credential.helper "store --file ~/.git-credentials-gitlab-com"
```

---

### 步驟五：驗證連線

```bash
git ls-remote https://gitlab.com/Shuming-Yang/opencode-lazy-packs.git
```

預期看到類似輸出（包含 commit hash 和 ref 列表）。

若看到：
```
remote: HTTP Basic: Access denied
```
表示 PAT 無效或權限不足，請回到步驟三重建 PAT。

---

### 步驟六：clone 測試專案

```bash
mkdir -p ~/Documents/gitlab-personal
cd ~/Documents/gitlab-personal
git clone https://gitlab.com/Shuming-Yang/opencode-lazy-packs.git
cd opencode-lazy-packs
```

---

### 步驟七：設定本機 Git 使用者（若尚未設定）

```bash
git config --global user.name "Shuming-Yang"
git config --global user.email "shumingyang.opencode@gmail.com"
```

---

## 日常操作

```bash
cd ~/Documents/gitlab-personal/opencode-lazy-packs
git pull
git status
git add <檔案>
git commit -m "feat: 訊息"
git push
```

> Git 會自動使用 credential helper 中的 PAT 進行驗證，不需每次輸入。

---

## 完成回報格式

```md
## 個人 GitLab 連接完成

- Git 版本：（版本號）
- credential helper：manager / osxkeychain / store
- PAT：已產生 / 未產生
- 遠端驗證（git ls-remote）：成功 / 失敗
- clone 測試：成功 / 未執行
- 本機目錄：（路徑）
```

---

## 常見問題

| 問題 | 平台 | 解法 |
|------|------|------|
| `fatal: Authentication failed` | 通用 | PAT 過期或無效，回步驟三重建 |
| `could not read Password for 'https://gitlab.com'` | 通用 | credential helper 未設定，或 store 檔案遺失 |
| `remote: HTTP Basic: Access denied` | 通用 | PAT scope 缺少 `write_repository` |
| `ssh: connect to host gitlab.com port 22: Connection timed out` | 通用 | 防火牆封鎖 SSH，請改用 HTTPS 協定 |
| `SSL certificate problem` | Windows | 確認 Git 使用 Windows 憑證儲存區：`git config --global http.sslbackend schannel` |

---

## 快速參考卡

```bash
# 設定 credential helper
git config --global credential.helper "store --file ~/.git-credentials-gitlab-com"

# 驗證
git ls-remote https://gitlab.com/Shuming-Yang/opencode-lazy-packs.git

# 日常
git clone https://gitlab.com/<使用者>/<專案>.git
git pull
git push
```

---

## 更新紀錄

| 日期 | 版本 | 更新內容 |
|------|------|---------|
| 2026-06-18 | v0.1 | 初版 |
