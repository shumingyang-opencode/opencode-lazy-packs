# OpenCode 懶人包 #04：連接公司 GitLab

> 版本：v0.1
> 更新日期：2026-06-18

---

## 這個懶人包會幫你做什麼？

讓你可以從本機連接到 OmniVision 內部 GitLab 伺服器：
- 檢查 SSH 金鑰與連線
- 設定 SSH config
- 設定 Git remote 使用 SSH
- 簽出（clone）開發專案
- 日常推拉操作

---

## GitLab 伺服器資訊

| 項目 | 內容 |
|------|------|
| 伺服器網址 | `https://gitlab.ovt.com:8081` |
| Git SSH 主機 | `gitlab.ovt.com` |
| SSH 埠號 | `22` |
| 使用者名稱 | `steven.yang` |
| SSH 金鑰檔案 | `~/.ssh/id_ed25519_gitlab_ovt` |
| SSH 使用者 | `git` |

---

## 先備條件

- [ ] 公司內網或 VPN 連線正常
- [ ] Git 已安裝（若無，先跑**懶人包 #00：環境建置**）
- [ ] 有 GitLab 帳號權限

---

## 平台檢查

> 🖐️ **請 OpenCode 在開始前先詢問使用者：**
>
> 「你目前在公司內網或 VPN 中嗎？GitLab 伺服器 `gitlab.ovt.com` 需要內網連線。」
>
> - **個人 Mac（不在公司）** → 直接跳過，顯示「此懶人包需要公司內網連線，個人 Mac 不適用」
> - **公司環境（Windows/macOS）** → 繼續執行下方步驟

---

## 請 OpenCode 幫我執行以下步驟

### 步驟〇：查閱帳號資訊

先讀取 OpenCode 根目錄的 `個人帳號與服務清單.md`（若存在），取得公司 GitLab 資訊：
- 若找到伺服器 URL、帳號、SSH 設定 → 直接套用，跳過詢問
- 若檔案不存在或資訊不足 → 詢問使用者後寫回

> 此檔案位於 Obsidian vault 根目錄，OpenCode 可透過 Obsidian MCP 讀寫。

### 步驟一：檢查 Git 安裝

```bash
git --version
```

預期看到 `git version 2.x.x`。

---

### 步驟二：確認 SSH 金鑰存在

檢查是否已有公司 GitLab 專用金鑰：

**Windows / macOS 通用：**
```bash
ls -la ~/.ssh/id_ed25519_gitlab_ovt
```

如果不存在，產生新金鑰（不要設 passphrase，或記住 passphrase）：
```bash
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519_gitlab_ovt -C "steven.yang@ovt.com"
```

---

### 步驟三：設定 SSH config

確認 `~/.ssh/config` 包含以下內容（若檔案不存在則建立）：

```
Host gitlab.ovt.com
    HostName gitlab.ovt.com
    Port 22
    User git
    IdentityFile ~/.ssh/id_ed25519_gitlab_ovt
    StrictHostKeyChecking no
```

> ⚠️ Windows 使用者注意：`~/.ssh/config` 路徑為 `C:\Users\<你>\.ssh\config`，無副檔名。

---

### 步驟四：將公鑰新增到 GitLab 網站

請使用者手動操作：
1. 瀏覽器開啟 `https://gitlab.ovt.com:8081`
2. 登入（帳號：`steven.yang`）
3. 右上角頭像 → **Preferences** → **SSH Keys**
4. 貼上公鑰內容：

```bash
cat ~/.ssh/id_ed25519_gitlab_ovt.pub
```

複製輸出內容，貼到 GitLab 的 Key 欄位，Title 可填 `My Laptop`，Expiration date 留空。

---

### 步驟五：驗證 SSH 連線

```bash
ssh -T git@gitlab.ovt.com
```

預期看到：
```
Welcome to GitLab, @steven.yang!
```

如果看到 `The authenticity of host...` 提示，輸入 `yes` 繼續。

---

### 步驟六：建立專案資料夾並 clone 測試

```bash
mkdir -p ~/Documents/gitlab-projects
cd ~/Documents/gitlab-projects
```

clone 一個測試專案（請使用者提供專案 SSH URL，或使用已知專案）：
```bash
git clone git@gitlab.ovt.com:steven.yang/your-project.git
cd your-project
```

---

### 步驟七：設定本機 Git 使用者（若尚未設定）

```bash
git config --global user.name "steven.yang"
git config --global user.email "steven.yang@ovt.com"
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

---

## 完成回報格式

```md
## 公司 GitLab 連接完成

- 環境：公司內網 / VPN / 跳過（個人 Mac）
- Git 版本：（版本號）
- SSH 金鑰：已存在 / 已產生
- SSH config：已設定 / 未設定
- SSH 連線驗證：成功 / 失敗
- clone 測試：成功 / 未執行
- 本機目錄：（路徑）
```

---

## 常見問題

| 問題 | 平台 | 解法 |
|------|------|------|
| `ssh: connect to host gitlab.ovt.com port 22: Connection timed out` | 通用 | 確認在公司內網或 VPN 中 |
| `Permission denied (publickey)` | 通用 | 公鑰未上傳到 GitLab 設定頁，或金鑰檔案不對 |
| `git@gitlab.ovt.com: Permission denied` | 通用 | 確認 SSH config 的 `User` 為 `git` |
| `StrictHostKeyChecking` 警告 | 通用 | config 中已加 `StrictHostKeyChecking no`，可安全忽略 |
| `fatal: repository not found` | 通用 | 確認專案路徑正確，且你有存取權限 |
| SSH config 不生效 | Windows | 確認檔案路徑為 `C:\Users\<你>\.ssh\config`，無 `.txt` 副檔名 |

---

## 快速參考卡

```bash
ssh -T git@gitlab.ovt.com              # 驗證連線
git clone git@gitlab.ovt.com:<群組>/<專案>.git  # clone 專案
git pull                                # 拉取
git push                                # 推送
git remote -v                           # 查看 remote URL
```

---

## 更新紀錄

| 日期 | 版本 | 更新內容 |
|------|------|---------|
| 2026-06-18 | v0.1 | 初版 |
