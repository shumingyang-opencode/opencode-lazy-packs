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

## 安裝來源

本 repo 安裝指令使用公司 GitLab 來源：
`npx skills add gitlab.ovt.com:8081/steven.yang/agents-lazy-packs --skill <skill名> -g -y`

若已 fork 到自己的 namespace，請將 `steven.yang` 改為你自己的帳號。

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
