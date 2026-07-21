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
$repoRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
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
    # Clone from local
    Write-Host "Cloning..." -ForegroundColor Yellow
    git clone $repoRoot $tmpDir
    git -C $tmpDir remote add gitlab $gitlabUrl

    # Verify branch
    $branch = git -C $tmpDir rev-parse --abbrev-ref HEAD
    Write-Host "Branch: $branch"

    # Remove items 01/08/11
    Write-Host "Removing items 01/08/11..." -ForegroundColor Yellow
    $removals = @(
        "skills/01-notebooklm"
        "skills/08-firebase"
        "skills/11-draw"
        "01-連接-NotebookLM.md"
        "08-連接-Firebase.md"
        "11-生圖.md"
        "scripts/draw.py"
    )

    $anyRemoved = $false
    foreach ($item in $removals) {
        $fullPath = Join-Path $tmpDir $item
        if (Test-Path $fullPath) {
            if ((Get-Item $fullPath) -is [System.IO.DirectoryInfo]) {
                Remove-Item -Recurse -Force $fullPath
            } else {
                Remove-Item -Force $fullPath
            }
            Write-Host "  Removed: $item"
            $anyRemoved = $true
        } else {
            Write-Host "  Skipped (not found): $item" -ForegroundColor DarkYellow
        }
    }

    if (-not $anyRemoved) {
        Write-Host "Nothing to remove — already clean. Pushing as-is." -ForegroundColor Green
    } else {
        # Commit removal
        git -C $tmpDir add -A
        git -C $tmpDir commit -m "sync: remove #01 NotebookLM / #08 Firebase / #11 Draw for GitLab (GitHub-only packs)"
        Write-Host "Commit created." -ForegroundColor Green
    }

    # Push to GitLab
    Write-Host "Pushing to GitLab..." -ForegroundColor Yellow
    git -C $tmpDir push gitlab $branch

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
