---
name: gitlab-internal
description: 連接公司內部 GitLab 伺服器。說「連接公司 GitLab」「設定內部 GitLab」時載入。
---

# 連接公司 GitLab

讓 OpenCode 幫你連接到 <COMPANY_NAME> 內部 GitLab（<COMPANY_GITLAB_URL>），走 HTTPS + PAT。

## 平台檢查

執行前先問使用者：「你目前在公司內網或 VPN 中嗎？」

- **不在公司內網且未連 VPN** → 跳過，不適用
- **公司內網或已連 VPN** → 繼續執行

## PAT 與 Credential 設定

### 1. 建立 PAT
請使用者到 `https://<COMPANY_GITLAB_URL>/-/user_settings/personal_access_tokens` 建立 token，scope 勾 `read_repository` + `write_repository`。

### 2. 設定 credential helper
```bash
echo "https://<GITLAB_USERNAME>:<PAT>@<COMPANY_GITLAB_URL>" > ~/.git-credentials-gitlab-ovt
chmod 600 ~/.git-credentials-gitlab-ovt
git config --global credential.helper "store --file ~/.git-credentials-gitlab-ovt"
```

### 3. 驗證
```bash
git ls-remote https://<COMPANY_GITLAB_URL>/<GITLAB_USERNAME>/your-project.git
```

## 日常操作

```bash
git clone https://<COMPANY_GITLAB_URL>/<群組>/<專案>.git
git pull
git push
```

回報格式：環境、Git 版本、PAT、credential helper、遠端驗證、clone 測試。
