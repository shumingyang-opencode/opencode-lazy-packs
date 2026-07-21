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

    # Use filesystem wildcards (reliable for Unicode filenames on Windows)
    Remove-Item -Path (Join-Path $tmpDir "skills\01-notebooklm") -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path (Join-Path $tmpDir "skills\08-firebase") -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path (Join-Path $tmpDir "skills\11-draw") -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path (Join-Path $tmpDir "scripts\draw.py") -Force -ErrorAction SilentlyContinue

    # Root MD files - use wildcards to avoid Chinese character encoding issues
    Remove-Item -Path (Join-Path $tmpDir "01-*-NotebookLM.md") -Force -ErrorAction SilentlyContinue
    Remove-Item -Path (Join-Path $tmpDir "08-*-Firebase.md") -Force -ErrorAction SilentlyContinue
    Remove-Item -Path (Join-Path $tmpDir "11-*.md") -Force -ErrorAction SilentlyContinue

    # Let git detect all removals
    git -C $tmpDir add --update .
    git -C $tmpDir commit -m "sync: remove #01 NotebookLM / #08 Firebase / #11 Draw for GitLab (GitHub-only packs)"

    # Push to GitLab via temp branch (avoids protected branch / non-fast-forward issues)
    Write-Host "Pushing to GitLab via temp branch..." -ForegroundColor Yellow
    $syncBranch = "sync/remove-01-08-11-$(Get-Date -Format 'yyyyMMdd')"
    git -C $tmpDir push $gitlabUrl HEAD:$syncBranch

    Write-Host "=== Sync pushed to branch: $syncBranch ===" -ForegroundColor Green
    Write-Host "To complete sync, create a merge request on GitLab:" -ForegroundColor Cyan
    Write-Host "  From: $syncBranch → To: main"
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
