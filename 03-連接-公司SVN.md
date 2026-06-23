# OpenCode 懶人包 #03：連接公司 SVN

> 版本：v0.2
> 更新日期：2026-06-18

---

## 這個懶人包會幫你做什麼？

讓你可以從本機連接到 OmniVision 內部 SVN 伺服器：
- 檢查 SVN（Subversion）是否已安裝
- 設定 SVN 使用者資訊
- 簽出（checkout）開發專案
- 日常操作：更新、提交、新增檔案
- 建立專用資料夾管理 SVN 專案

---

## 平台檢查

> 🖐️ **請 OpenCode 在開始前先詢問使用者：**
>
> 「你目前在公司內網或 VPN 中嗎？SVN 伺服器 `10.0.0.78` 需要內網連線。」
>
> - **個人 Mac（不在公司）** → 直接跳過，顯示「此懶人包需要公司內網連線，個人 Mac 不適用」
> - **公司 Mac（在公司內網/VPN）** → 執行下方 macOS 章節
> - **Windows** → 執行下方 Windows 章節

---

## SVN 伺服器資訊

| 項目 | 內容 |
|------|------|
| 伺服器網址 | `http://10.0.0.78/svn/development` |
| 帳號 | `ovt\steven.yang`（Windows）/ `steven.yang`（macOS） |
| 協定 | HTTP（ra_serf） |
| 本機工作目錄 | `D:\workspace\svn-projects`（Windows）/ `~/Documents/svn-projects`（macOS） |

> 密碼請於執行指令時手動輸入，**請勿**寫入任何檔案。

---

## 先備條件

- [ ] SVN（Subversion）已安裝
- [ ] 公司內網連線正常（依平台指令測試）
- [ ] 擁有 SVN 伺服器存取權限

---

## 請 OpenCode 幫我執行以下步驟

### 步驟〇：查閱帳號資訊

先讀取 OpenCode 根目錄的 `個人帳號與服務清單.md`（若存在），取得 SVN 伺服器資訊：
- 若找到 SVN URL 與帳號 → 直接套用，跳過平台檢查與伺服器詢問
- 若檔案不存在或資訊不足 → 詢問使用者後寫回

> 此檔案位於 Obsidian vault 根目錄，OpenCode 可透過 Obsidian MCP 讀寫。

### 步驟一：檢查 SVN 安裝

```bash
svn --version
```

預期看到：
```
svn, version 1.14.5 (r1922182)
```

---

## Windows

### 步驟二（Windows）：測試伺服器連線

```bash
ping -n 1 10.0.0.78
```

### 步驟三（Windows）：設定 SVN 使用者名稱

SVN 會記住第一次輸入的帳號密碼，但建議先設定使用者名稱：

```bash
svn info http://10.0.0.78/svn/development --username ovt\steven.yang
```

執行後會提示輸入密碼，第一次輸入後會被 **Windows Wincrypt** 快取，後續不需重複輸入。

### 步驟四（Windows）：建立專案資料夾並簽出

```bash
mkdir D:\workspace\svn-projects
cd D:\workspace\svn-projects
```

簽出整個 development 專案：
```bash
svn checkout http://10.0.0.78/svn/development/trunk ./development --username ovt\steven.yang
```

或只簽出特定子目錄：
```bash
svn checkout http://10.0.0.78/svn/development/trunk/your-project ./your-project --username ovt\steven.yang
```

### 步驟五（Windows）：日常操作

```bash
cd D:\workspace\svn-projects\development
svn status          # 查看狀態
svn update          # 更新
svn commit -m "訊息" # 提交
```

### 步驟六（Windows）：建立忽略規則

```bash
cd D:\workspace\svn-projects\development
svn propset svn:global-ignores "
*.pyc
__pycache__
.venv
*.db
node_modules
.vscode
.idea
*.log
" .
```

---

## macOS（需在公司內網）

### 步驟二（macOS）：測試伺服器連線

```bash
ping -c 1 10.0.0.78
```

### 步驟三（macOS）：設定 SVN 使用者名稱

SVN 會記住第一次輸入的帳號密碼，建議先設定使用者名稱：

```bash
svn info http://10.0.0.78/svn/development --username steven.yang
```

執行後會提示輸入密碼，第一次輸入後會被 **macOS Keychain** 快取，後續不需重複輸入。

### 步驟四（macOS）：建立專案資料夾並簽出

```bash
mkdir -p ~/Documents/svn-projects
cd ~/Documents/svn-projects
```

簽出整個 development 專案：
```bash
svn checkout http://10.0.0.78/svn/development/trunk ./development --username steven.yang
```

### 步驟五（macOS）：日常操作

```bash
cd ~/Documents/svn-projects/development
svn status          # 查看狀態
svn update          # 更新
svn commit -m "訊息" # 提交
```

### 步驟六（macOS）：建立忽略規則

```bash
cd ~/Documents/svn-projects/development
svn propset svn:global-ignores "
*.pyc
__pycache__
.venv
*.db
node_modules
.vscode
.idea
*.log
" .
```

---

## 跨平台：日常 SVN 操作（通用）

以下指令 Windows / macOS 通用：

#### 查看狀態
```bash
svn status
```

#### 更新到最新版本
```bash
svn update
```

#### 新增檔案
```bash
echo "# My new module" > my_module/README.md
svn add my_module/README.md
svn commit -m "feat: 新增 my_module README"
```

#### 提交變更
```bash
svn commit -m "類型(範圍): 描述"
```

提交類型參考：
| 類型 | 適用時機 |
|------|---------|
| feat | 新增功能 |
| fix | 修正錯誤 |
| docs | 文件異動 |
| refactor | 重構 |
| chore | 雜項（建置、工具等） |

#### 查看歷史紀錄
```bash
svn log --limit 10
svn log -r HEAD:1
svn blame my_module/main.py
```

#### 比較差異
```bash
svn diff                    # 未提交的變更
svn diff -r 100:110         # 比較兩個版本
svn diff -c 105             # 查看某個版本的變更
```

#### 解決衝突
```bash
svn status                               # 查看衝突檔案
svn resolve --accept mine-full file.py    # 接受我的版本
svn resolve --accept theirs-full file.py  # 接受伺服器版本
svn resolve --accept working file.py      # 手動編輯後標記已解決
```

---

## 完成回報格式

```md
## SVN 連接完成

- 平台：Windows / macOS / 跳過（個人 Mac）
- SVN 版本：1.14.5 / 其他
- 伺服器連線：成功 / 失敗
- 帳號驗證：成功 / 失敗
- 簽出測試：成功 / 未執行
- 本機工作目錄：（依平台）
```

---

## 常見問題

| 問題 | 平台 | 解法 |
|------|------|------|
| `svn: E170013: Unable to connect` | 通用 | 確認是否在公司內網，ping 10.0.0.78 |
| `svn: E175013: Access denied` | 通用 | 帳號密碼錯誤，或無此目錄權限 |
| `svn: E155004: Working copy locked` | 通用 | `svn cleanup` 解鎖 |
| 忘記快取的密碼 | Windows | 「控制台 → 認證管理員 → Windows 認證」刪除 SVN 記錄 |
| 忘記快取的密碼 | macOS | 「應用程式 → 工具程式 → 鑰匙圈存取」搜尋 svn 刪除記錄 |
| 換密碼後無法連線 | 通用 | 刪除快取後重新執行 `svn info` 輸入新密碼 |

---

## 快速參考卡

```bash
svn checkout <url> [目錄]    # 首次簽出
svn update                   # 更新
svn commit -m "訊息"         # 提交
svn add <檔案>               # 新增
svn delete <檔案>            # 刪除
svn move <來源> <目標>       # 搬移/重新命名
svn status                   # 查看狀態
svn diff                     # 查看差異
svn log                      # 查看歷史
svn cleanup                  # 解鎖工作副本
svn revert <檔案>            # 復原未提交的變更
svn info                     # 查看工作副本資訊
```

---

## 更新紀錄

| 日期 | 版本 | 更新內容 |
|------|------|---------|
| 2026-06-18 | v0.2 | 重構為 Windows/macOS 雙平台，加入平台檢查章節 |
| 2026-06-18 | v0.1 | 初版 |
