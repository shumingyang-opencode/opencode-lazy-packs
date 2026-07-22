#!/usr/bin/env pwsh
<#
.SYNOPSIS
    Sync main branch to GitHub (origin), removing company-sensitive info.
.DESCRIPTION
    Clones the repo locally, replaces company info with placeholders,
    removes internal tutorial video links, and force-pushes to GitHub.
    Keeps the full lazy pack including items 01/08/11.
#>

$ErrorActionPreference = "Stop"
$repoRoot = Split-Path -Parent $PSScriptRoot
$tmpDir = "$env:TEMP\github-sync-$(Get-Random)"

# Get GitHub remote URL
$githubUrl = git -C $repoRoot remote get-url origin 2>$null
if (-not $githubUrl) {
    Write-Error "No 'origin' remote found. Aborting."
    exit 1
}

Write-Host "=== Syncing to GitHub (sanitized) ===" -ForegroundColor Cyan
Write-Host "Source: $repoRoot"
Write-Host "Target: $githubUrl"

try {
    Write-Host "Cloning from local repo..." -ForegroundColor Yellow
    git clone $repoRoot $tmpDir

    # Files to patch (recursive)
    $allFiles = Get-ChildItem $tmpDir -File -Recurse -Include "*.md", "*.py", "*.ps1" |
        Where-Object { $_.FullName -notmatch '\\.git\\' -and $_.FullName -notmatch 'node_modules\\' -and $_.FullName -notmatch '\\Env\\' }

    Write-Host "Replacing company info..." -ForegroundColor Yellow

    foreach ($file in $allFiles) {
        $content = Get-Content $file.FullName -Raw -Encoding UTF8
        $original = $content

        # Step 1: Remove tutorial video sections (before replacement, uses URL as anchor)
        # NOTE: use section header anchor, not generic `---` to avoid deleting entire file content
        $content = $content -replace '(?s)## Tutorial Videos.*?---(\r?\n|$)', '---'
        $content = $content -replace '(?s)## 教學影片.*?---(\r?\n|$)', '---'
        $content = $content -replace '(?s)## 教学视频.*?---(\r?\n|$)', '---'

        # Step 2: Replace company info

        # Company name
        $content = $content -replace "<COMPANY_NAME>", "<COMPANY_NAME>"

        # SSH config host (must be before generic gitlab domain replacement)
        $content = $content -replace 'Host gitlab\.ovt\.com', 'Host <COMPANY_GITLAB_HOST>'
        $content = $content -replace 'HostName gitlab\.ovt\.com', 'HostName <COMPANY_GITLAB_HOST>'

        # Company domains (most specific first)
        $content = $content -replace 'gitlab\.ovt\.com:8081', '<COMPANY_GITLAB_URL>'
        $content = $content -replace 'gitlab\.ovt\.com', '<COMPANY_GITLAB_HOST>'
        $content = $content -replace 'jira\.ovt\.com', '<COMPANY_JIRA_URL>'
        $content = $content -replace 'confluence\.ovt\.com', '<COMPANY_CONFLUENCE_URL>'

        # Internal IP
        $content = $content -replace '10\.0\.0\.78', '<SVN_SERVER_IP>'

        # Personal email
        $content = $content -replace 'steven\.yang@ovt\.com', '<EMAIL>'

        # Personal username in repo URLs (steven.yang/<repo-name> patterns)
        $content = $content -replace 'steven\.yang/opencode-lazy-packs', '<GITLAB_USERNAME>/opencode-lazy-packs'
        $content = $content -replace 'steven\.yang/agents-lazy-packs', '<GITLAB_USERNAME>/agents-lazy-packs'
        $content = $content -replace 'steven\.yang/trac-mcp-server', '<GITLAB_USERNAME>/trac-mcp-server'
        $content = $content -replace 'steven\.yang/your-project', '<GITLAB_USERNAME>/your-project'

        # Fix Source link for GitHub (repo transferred to mathruffian-dot)
        $content = $content -replace '- \*\*.*?\*\*.*?shumingyang-opencode/opencode-lazy-packs.*', '- **Source**: https://github.com/mathruffian-dot/opencode-lazy-packs'

        # Step 3: Replace install/usage URLs with GitHub URL (so users can copy-paste directly)
        # Keep other company info (jira, confluence, svn, etc.) as placeholders
        # Use generic pattern to cover all repos (agents-lazy-packs, trac-mcp-server, opencode-lazy-packs, etc.)
        $content = $content -replace 'https://github.com/shumingyang-opencode/opencode-lazy-packs', 'https://github.com/shumingyang-opencode/opencode-lazy-packs'
        $content = $content -replace 'https://github.com/shumingyang-opencode/opencode-lazy-packs', 'https://github.com/shumingyang-opencode/opencode-lazy-packs'
        # Fix GitLab-style issues URL to GitHub-style (/issues -> /issues)
        # Must run AFTER the URL replacement above, and use a simple pattern that matches the already-replaced URL
        $content = $content -replace '/issues', '/issues'
        # trac-mcp-server is a GitLab-only internal fork (no GitHub mirror) — kept as placeholder
        # since #21 Trac is a company-internal pack and the dep URL would leak company info on public GitHub

        if ($content -ne $original) {
            [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.UTF8Encoding]::new($true))
            Write-Host "  Patched: $($file.FullName.Substring($tmpDir.Length + 1))" -ForegroundColor DarkGray
        }
    }

    # Stage all changes and commit
    git -C $tmpDir add -A
    git -C $tmpDir commit -m "sync: sanitize company info for GitHub"

    # Push to GitHub
    Write-Host "Pushing to GitHub (origin)..." -ForegroundColor Yellow
    git -C $tmpDir push --force $githubUrl HEAD:main

    Write-Host "=== GitHub sync complete ===" -ForegroundColor Green
}
catch {
    Write-Error "Sync failed: $_"
    exit 1
}
finally {
    if (Test-Path $tmpDir) {
        Remove-Item -Recurse -Force $tmpDir
        Write-Host "Temp directory cleaned up." -ForegroundColor DarkGray
    }
}
