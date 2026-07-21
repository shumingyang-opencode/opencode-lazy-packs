# 範本變數對照表

本檔案列出 repo 中使用到的範本變數，fork 後請根據你的環境替換。

| 變數 | 範例值 | 說明 |
|------|--------|------|
| `<GITLAB_PERSONAL_USERNAME>` | `your-gitlab-username` | 個人 GitLab.com 帳號名稱 |
| `<YOUR_EMAIL>` | `your.name@company.com` | 用於 Git config user.email |
| `<FEISHU_EMAIL>` | `your.name@company.com` | 飛書帳號 Email |
| `<COLLEAGUE_ACCOUNT>` | `colleague.name` | JIRA 範例中的同事帳號 |
| `<EXAMPLE_REPO>` | `owner/example-repo` | 教學範例中的 repo 路徑 |
| `<OBSIDIAN_VAULT_PATH>` | `C:\Users\YourName\Documents\Obsidian` | Obsidian Vault 根目錄路徑 |
| `<VAULT_GIT_REMOTE>` | `origin → github.com/yourname/work-notes` | 跨機器同步的 vault Git remote |
| `<COMPANY_NAME>` | `YourCompany` | 公司名稱（GitHub 版去敏用）|
| `<COMPANY_GITLAB_URL>` | `gitlab.example.com:8081` | 公司 GitLab 伺服器 |
| `<COMPANY_GITLAB_HOST>` | `gitlab.example.com` | 公司 GitLab SSH 主機 |
| `<COMPANY_JIRA_URL>` | `jira.example.com` | 公司 JIRA 網址 |
| `<COMPANY_CONFLUENCE_URL>` | `confluence.example.com` | 公司 Confluence 網址 |
| `<SVN_SERVER_IP>` | `192.168.0.1` | SVN 伺服器 IP |
| `<GITLAB_USERNAME>` | `your-gitlab-username` | GitLab 上的 namespace 名稱 |
| `<EMAIL>` | `your.name@company.com` | 公司 Email |

## 安裝來源

本地與 GitLab 版使用真實安裝來源，GitHub 版會自動去敏。

## 中國鏡像設定

若身處中國大陸，npm 和 pip 等註冊表可能連線緩慢，建議設定鏡像：

```bash
# npm 鏡像（npmmirror.com）
npm config set registry https://registry.npmmirror.com

# pip 鏡像（清華 TUNA）
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

# 設定後驗證
npm config get registry
pip config list
```
