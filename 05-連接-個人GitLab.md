# OpenCode 懶人包 #05：連接個人 GitLab

> 版本：v0.2
> 更新日期：2026-06-18

---

## 這個懶人包會幫你做什麼？

讓你可以從本機連接到 `gitlab.com` 上的個人帳號：
- 產生 GitLab Personal Access Token（PAT）
- 設定 Git credential helper 記住 PAT
- 設定 Git remote 使用 HTTPS
- clone 與推拉操作
- 處理防火牆限制（SSH 被封鎖，改走 HTTPS）
- 建立 repo 後邀請協作者（Shuming-Yang、Steven-Yang）

---

## GitLab 伺服器資訊

| 項目 | 內容 |
|------|------|
| 伺服器網址 | `https://gitlab.com` |
| 協定 | HTTPS（因防火牆封鎖 SSH 22 埠） |
| Git remote 格式 | `https://gitlab.com/<使用者>/<專案>.git` |
| 使用者名稱 | `<GITLAB_PERSONAL_USERNAME>` |

---

## 先備條件

- [ ] Git 已安裝（若無，先跑**懶人包 #00：環境建置**）
- [ ] 有 `gitlab.com` 帳號（使用者名稱 `<GITLAB_PERSONAL_USERNAME>`）
- [ ] 電腦有網路連線

---

## 請 OpenCode 幫我執行以下步驟

### 步驟〇：查閱帳號資訊

先讀取 OpenCode 根目錄的 `個人帳號與服務清單.md`（若存在），取得個人 GitLab 資訊：
- 若找到伺服器 URL、帳號、認證方式 → 直接套用，跳過詢問
- 若檔案不存在或資訊不足 → 詢問使用者後寫回

> 此檔案位於 Obsidian vault 根目錄，OpenCode 可透過 Obsidian MCP 讀寫。

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
2. 登入帳號 `<GITLAB_PERSONAL_USERNAME>`
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

然後第一次 push/clone 時會跳出對話框，使用者名稱填 `<GITLAB_PERSONAL_USERNAME>`，密碼填 PAT。

或者直接寫入 credential store：

```powershell
Set-Content -Path "$env:USERPROFILE\.git-credentials-gitlab-com" -Value "https://<GITLAB_PERSONAL_USERNAME>:<PAT>@gitlab.com"
git config --global credential.helper "store --file ~/.git-credentials-gitlab-com"
```

> ⚠️ 確認將 `<PAT>` 替換為步驟三複製的 token。

**macOS：**
```bash
echo "https://<GITLAB_PERSONAL_USERNAME>:<PAT>@gitlab.com" > ~/.git-credentials-gitlab-com
git config --global credential.helper "store --file ~/.git-credentials-gitlab-com"
```

---

### 步驟五：驗證連線

```bash
git ls-remote https://gitlab.com/<GITLAB_PERSONAL_USERNAME>/opencode-lazy-packs.git
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
git clone https://gitlab.com/<GITLAB_PERSONAL_USERNAME>/opencode-lazy-packs.git
cd opencode-lazy-packs
```

---

### 步驟七：設定本機 Git 使用者（若尚未設定）

```bash
git config --global user.name "<GITLAB_PERSONAL_USERNAME>"
git config --global user.email "<YOUR_EMAIL>"
```

---

### 步驟八：將協作者加入新建立的 repo

每次用 OpenCode 在 GitLab.com 建立 repo 後，務必透過 GitLab API 加入協作者（最高權限）：

```bash
curl -s -X POST -H "PRIVATE-TOKEN: <PAT>" \
  "https://gitlab.com/api/v4/projects/<owner>%2F<repo>/members" \
  -d "user_id=<使用者ID>&access_level=50"
```

因 GitLab API 需要使用者 ID，請在 GitLab 網頁上操作：
1. 前往 repo → **Settings** → **Members**
2. 邀請 `<COLLABORATOR_1>`、`<COLLABORATOR_2>`，角色設 **Owner** 或 **Maintainer**

> 替代方案：使用 GitLab 網頁新增協作者最為直觀。

在完成回報中也應明確列出已加入的協作者清單。

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
- 協作者（<COLLABORATOR_1>、<COLLABORATOR_2>）：已加入 / 未加入
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
git ls-remote https://gitlab.com/<GITLAB_PERSONAL_USERNAME>/opencode-lazy-packs.git

# 日常
git clone https://gitlab.com/<使用者>/<專案>.git
git pull
git push
```

---

## 解除安裝

本懶人包未安裝專屬 CLI 工具，僅設定 Git credential helper 與 PAT。

### 還原設定

```bash
# 移除自訂的 credential helper
git config --global --unset credential.helper
rm -f ~/.git-credentials-gitlab-com
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
| 2026-06-18 | v0.2 | 加入建立 repo 後邀請協作者的步驟 |
| 2026-06-18 | v0.1 | 初版 |
