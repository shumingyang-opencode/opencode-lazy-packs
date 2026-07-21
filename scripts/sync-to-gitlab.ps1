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
    # Clone from local
    Write-Host "Cloning..." -ForegroundColor Yellow
    git clone $repoRoot $tmpDir
    git -C $tmpDir remote add gitlab $gitlabUrl

    # Verify branch
    $branch = git -C $tmpDir rev-parse --abbrev-ref HEAD
    Write-Host "Branch: $branch"

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

    # Check if anything changed
    $status = git -C $tmpDir status --porcelain
    if (-not $status) {
        Write-Host "Nothing to remove - already clean. Pushing as-is." -ForegroundColor Green
    } else {
        git -C $tmpDir commit -m "sync: remove #01 NotebookLM / #08 Firebase / #11 Draw for GitLab (GitHub-only packs)"
        Write-Host "Commit created." -ForegroundColor Green
    }

    # Push to GitLab (force to match GitHub:main after restoration)
    Write-Host "Pushing to GitLab..." -ForegroundColor Yellow
    git -C $tmpDir push --force gitlab $branch

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
