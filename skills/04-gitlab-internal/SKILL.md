---
name: opencode-gitlab-internal
description: 連接公司內部 GitLab 伺服器。說「連接公司 GitLab」「設定內部 GitLab」時載入。
---

# 連接公司 GitLab

讓 OpenCode 幫你連接到 <COMPANY_NAME> 內部 GitLab（<COMPANY_GITLAB_URL>）。

## 平台檢查

執行前先問使用者：「你目前在公司內網或 VPN 中嗎？」

- **個人 Mac（不在公司）** → 跳過，不適用
- **公司環境（Windows/macOS）** → 繼續執行

## SSH 金鑰設定

### 1. 檢查/產生金鑰
```bash
ls -la ~/.ssh/id_ed25519_gitlab_ovt
```
若不存在：
```bash
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519_gitlab_ovt -C "<EMAIL>"  # 替換為你的 email
```

### 2. 設定 SSH config
確認 `~/.ssh/config` 包含：
```
Host <COMPANY_GITLAB_HOST>
    HostName <COMPANY_GITLAB_HOST>
    Port 22
    User git
    IdentityFile ~/.ssh/id_ed25519_gitlab_ovt
    StrictHostKeyChecking no
```

### 3. 手動上傳公鑰
請使用者到 `https://<COMPANY_GITLAB_URL>` → Preferences → SSH Keys 貼上 `cat ~/.ssh/id_ed25519_gitlab_ovt.pub`。

### 4. 驗證
```bash
ssh -T git@<COMPANY_GITLAB_HOST>
```

## 日常操作

```bash
git clone git@<COMPANY_GITLAB_HOST>:<群組>/<專案>.git
git pull
git push
```

回報格式：環境、Git 版本、SSH 連線驗證、clone 測試。
