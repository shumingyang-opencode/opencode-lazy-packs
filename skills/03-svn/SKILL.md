---
name: opencode-svn
description: 連接公司內部 SVN 伺服器。說「連接 SVN」「設定 SVN」時載入。
---

# 連接公司 SVN

讓 OpenCode 幫你連接到 OmniVision 內部 SVN 伺服器。

## 平台檢查

執行前先問使用者：「你目前在公司內網或 VPN 中嗎？SVN 伺服器需要內網連線。」

- **個人 Mac（不在公司）** → 跳過，不適用
- **公司 Mac（在公司內網/VPN）** → 執行 macOS 章節
- **Windows** → 執行 Windows 章節

## SVN 伺服器資訊

| 項目 | 內容 |
|------|------|
| 網址 | `http://10.0.0.78/svn/development` |
| 帳號 | `ovt\steven.yang`（Windows）／ `steven.yang`（macOS） |
| 本機目錄 | `D:\workspace\svn-projects`（Windows）／ `~/Documents/svn-projects`（macOS） |

## Windows

### 1. 測試連線
```bash
ping -n 1 10.0.0.78
```

### 2. 設定使用者
```bash
svn info http://10.0.0.78/svn/development --username ovt\steven.yang
```
密碼第一次輸入後會被 Wincrypt 快取。

### 3. 簽出
```bash
mkdir D:\workspace\svn-projects
cd D:\workspace\svn-projects
svn checkout http://10.0.0.78/svn/development/trunk ./development --username ovt\steven.yang
```

### 4. 日常操作
```bash
cd D:\workspace\svn-projects\development
svn status
svn update
svn commit -m "類型(範圍): 描述"
```

## macOS（需在公司內網）

### 1. 測試連線
```bash
ping -c 1 10.0.0.78
```

### 2. 設定使用者
```bash
svn info http://10.0.0.78/svn/development --username steven.yang
```
密碼第一次輸入後會被 Keychain 快取。

### 3. 簽出
```bash
mkdir -p ~/Documents/svn-projects
cd ~/Documents/svn-projects
svn checkout http://10.0.0.78/svn/development/trunk ./development --username steven.yang
```

### 4. 日常操作
```bash
cd ~/Documents/svn-projects/development
svn status
svn update
svn commit -m "類型(範圍): 描述"
```

## 常見問題

| 問題 | 平台 | 解法 |
|------|------|------|
| `E170013: Unable to connect` | 通用 | 確認公司內網 |
| 忘記密碼 | Windows | 控制台→認證管理員→Windows 認證 |
| 忘記密碼 | macOS | 應用程式→工具程式→鑰匙圈存取 |

回報格式：平台、SVN 版本、伺服器連線、簽出測試結果。
