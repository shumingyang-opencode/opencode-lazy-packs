---
name: gitlab-personal
description: 連接個人 GitLab.com 帳號。說「連接個人 GitLab」「設定 GitLab.com」時載入。
---

# 連接個人 GitLab

讓 OpenCode 幫你連接到 `gitlab.com`（個人帳號 `<GITLAB_PERSONAL_USERNAME>`，走 HTTPS + PAT）。

## 步驟

### 1. 手動建立 PAT
請使用者到 `https://gitlab.com/-/user_settings/personal_access_tokens` 建立 token，scope 勾 `read_repository` + `write_repository`。

### 2. 設定 credential helper
```bash
echo "https://<GITLAB_PERSONAL_USERNAME>:<PAT>@gitlab.com" > ~/.git-credentials-gitlab-com
git config --global credential.helper "store --file ~/.git-credentials-gitlab-com"
```

### 3. 驗證
```bash
git ls-remote https://gitlab.com/<GITLAB_PERSONAL_USERNAME>/agents-lazy-packs.git
```

### 4. Clone 測試
```bash
mkdir -p ~/Documents/gitlab-personal
cd ~/Documents/gitlab-personal
git clone https://gitlab.com/<GITLAB_PERSONAL_USERNAME>/agents-lazy-packs.git
```

## 日常操作

```bash
git pull
git push
```

回報格式：Git 版本、credential helper、PAT 驗證、clone 測試。
