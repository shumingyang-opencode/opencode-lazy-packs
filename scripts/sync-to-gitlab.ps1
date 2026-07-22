#!/usr/bin/env pwsh
<#
.SYNOPSIS
    Sync main branch to GitLab, removing items 01/08/11 (GitHub-only packs).
.DESCRIPTION
    Clones the repo locally, removes #01 NotebookLM / #08 Firebase / #11 Draw,
    commits the removal, and pushes to the GitLab remote.
    This keeps the GitHub version complete while GitLab gets a filtered version.
#>

$ErrorActionPreference = "Stop"
$repoRoot = Split-Path -Parent $PSScriptRoot
$tmpDir = "$env:TEMP\gitlab-sync-$(Get-Random)"

# Get GitLab remote URL from the original repo
$gitlabUrl = git -C $repoRoot remote get-url gitlab 2>$null
if (-not $gitlabUrl) {
    Write-Error "No 'gitlab' remote found in $repoRoot. Add it first: git remote add gitlab <url>"
    exit 1
}

Write-Host "=== Syncing to GitLab ===" -ForegroundColor Cyan
Write-Host "Source: $repoRoot"
Write-Host "Target: $gitlabUrl"

try {
    # Clone from local (GitHub state with restored files)
    Write-Host "Cloning from local repo..." -ForegroundColor Yellow
    git clone $repoRoot $tmpDir

    # Remove items 01/08/11
    Write-Host "Removing items 01/08/11..." -ForegroundColor Yellow

    # Delete actual skill files
    Remove-Item -Path (Join-Path $tmpDir "skills\01-notebooklm") -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path (Join-Path $tmpDir "skills\08-firebase") -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path (Join-Path $tmpDir "skills\11-draw") -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path (Join-Path $tmpDir "scripts\draw.py") -Force -ErrorAction SilentlyContinue
    Remove-Item -Path (Join-Path $tmpDir "01-*-NotebookLM.md") -Force -ErrorAction SilentlyContinue
    Remove-Item -Path (Join-Path $tmpDir "08-*-Firebase.md") -Force -ErrorAction SilentlyContinue
    Remove-Item -Path (Join-Path $tmpDir "11-*.md") -Force -ErrorAction SilentlyContinue

    # Patch index files to mark 01/08/11 as unavailable on GitLab
    Write-Host "Patching README/SKILL.md for GitLab..." -ForegroundColor Yellow

    # --- README.md ---
    $rm = Join-Path $tmpDir "README.md"
    $lines = Get-Content $rm -Encoding UTF8
    $lines = $lines -replace "^List all 29 packs$", "List all 26 packs"
    $lines = $lines -replace '^\| `01-notebooklm` \| Connect NotebookLM \|$', '| ~~01-notebooklm~~ | ~~Connect NotebookLM~~ |'
    $lines = $lines -replace '^\| `08-firebase` \| Connect Firebase \|$', '| ~~08-firebase~~ | ~~Connect Firebase~~ |'
    $lines = $lines -replace '^\| `11-draw` \| Draw Skill \(OpenAI gpt-image-2\) \|$', '| ~~11-draw~~ | ~~Draw Skill (OpenAI gpt-image-2)~~ |'
    # Pack list lines - match by line start and replace entire line
    $lines = $lines -replace '^\| 01 \| .+$', '| ~~01~~ | ~~Connect NotebookLM~~ | ~~MCP~~ | ~~v0.2~~ | ~~NotebookLM MCP - AI presentations, audio, reports~~ | ~~Removed~~ |'
    $lines = $lines -replace '^\| 08 \| .+$', '| ~~08~~ | ~~Connect Firebase~~ | ~~MCP~~ | ~~v0.1~~ | ~~Firebase MCP - project management, database, deploy~~ | ~~Removed~~ |'
    $lines = $lines -replace '^\| 11 \| .+$', '| ~~11~~ | ~~Draw Skill~~ | ~~Skill~~ | ~~v0.3~~ | ~~draw skill: OpenAI gpt-image-2 image generation~~ | ~~Removed~~ |'
    Set-Content $rm $lines -Encoding UTF8

    # --- SKILL.md ---
    $sm = Join-Path $tmpDir "SKILL.md"
    $lines = Get-Content $sm -Encoding UTF8
    $lines = $lines -replace "^29 個技能$", "26 個技能"
    $lines = $lines -notmatch '^\| 01 \| `01-notebooklm` '
    $lines = $lines -notmatch '^\| 08 \| `08-firebase` '
    $lines = $lines -notmatch '^\| 11 \| `11-draw` '
    Set-Content $sm $lines -Encoding UTF8

    # --- README.zh-TW.md ---
    $zt = Join-Path $tmpDir "README.zh-TW.md"
    $lines = Get-Content $zt -Encoding UTF8
    $lines = $lines -replace "^列出 29 個懶人包$", "列出 26 個懶人包"
    $lines = $lines -replace '^\| 01 \| .+$', '| ~~01~~ | ~~連接 NotebookLM~~ | ~~MCP~~ | ~~v0.2~~ | ~~NotebookLM MCP 安裝與連線：AI 生成簡報、圖表、音訊、報告~~ | ~~已移除~~ |'
    $lines = $lines -replace '^\| 08 \| .+$', '| ~~08~~ | ~~連接 Firebase~~ | ~~MCP~~ | ~~v0.1~~ | ~~Firebase MCP 安裝：專案管理、資料庫、部署~~ | ~~已移除~~ |'
    $lines = $lines -replace '^\| 11 \| .+$', '| ~~11~~ | ~~生圖技能~~ | ~~Skill~~ | ~~v0.3~~ | ~~draw skill：OpenAI gpt-image-2 生成示意圖與插畫~~ | ~~已移除~~ |'
    Set-Content $zt $lines -Encoding UTF8

    # --- README.zh-CN.md ---
    $zc = Join-Path $tmpDir "README.zh-CN.md"
    $lines = Get-Content $zc -Encoding UTF8
    $lines = $lines -replace "^列出 29 个懒人包$", "列出 26 个懒人包"
    $lines = $lines -replace '^\| 01 \| .+$', '| ~~01~~ | ~~连接 NotebookLM~~ | ~~MCP~~ | ~~v0.2~~ | ~~NotebookLM MCP 安装与连線：AI 生成简报、图表、音讯、报告~~ | ~~已移除~~ |'
    $lines = $lines -replace '^\| 08 \| .+$', '| ~~08~~ | ~~连接 Firebase~~ | ~~MCP~~ | ~~v0.1~~ | ~~Firebase MCP 安装：项目管理、数据库、部署~~ | ~~已移除~~ |'
    $lines = $lines -replace '^\| 11 \| .+$', '| ~~11~~ | ~~生图技能~~ | ~~Skill~~ | ~~v0.3~~ | ~~draw skill：OpenAI gpt-image-2 生成示意图与插画~~ | ~~已移除~~ |'
    Set-Content $zc $lines -Encoding UTF8

    # --- Replace install/usage URLs with actual GitLab URL (so users can copy-paste directly) ---
    Write-Host "Replacing install URLs with GitLab URL..." -ForegroundColor Yellow

    $allFiles = Get-ChildItem $tmpDir -File -Recurse -Include "*.md" |
        Where-Object { $_.FullName -notmatch '\\.git\\' -and $_.FullName -notmatch 'node_modules\\' }

    foreach ($file in $allFiles) {
        $content = Get-Content $file.FullName -Raw -Encoding UTF8
        $original = $content

        # Replace placeholders with actual GitLab URL for install/usage commands
        $content = $content -replace 'https://<COMPANY_GITLAB_URL>/<GITLAB_USERNAME>/agents-lazy-packs', 'https://gitlab.ovt.com:8081/steven.yang/agents-lazy-packs'

        if ($content -ne $original) {
            [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.UTF8Encoding]::new($true))
            Write-Host "  Patched: $($file.FullName.Substring($tmpDir.Length + 1))" -ForegroundColor DarkGray
        }
    }

    # Let git detect all changes
    git -C $tmpDir add --update .
    git -C $tmpDir commit -m "sync: remove #01 NotebookLM / #08 Firebase / #11 Draw for GitLab (GitHub-only packs)"

    # Push directly to GitLab main (force push to overwrite any direct pushes)
    Write-Host "Pushing to GitLab main..." -ForegroundColor Yellow
    git -C $tmpDir push --force $gitlabUrl HEAD:main

    Write-Host "=== Sync complete ===" -ForegroundColor Green
}
catch {
    Write-Error "Sync failed: $_"
    exit 1
}
finally {
    # Clean up
    if (Test-Path $tmpDir) {
        Remove-Item -Recurse -Force $tmpDir
        Write-Host "Temp directory cleaned up." -ForegroundColor DarkGray
    }
}
