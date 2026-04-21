# GitHub Setup Script for Apptopia
# Run this after setting up GitHub token with proper scopes

Write-Host "🐙 Setting up GitHub for Apptopia..." -ForegroundColor Cyan

$env:Path = [Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [Environment]::GetEnvironmentVariable("Path", "User")

# Check if gh is installed
$gh = Get-Command gh -ErrorAction SilentlyContinue
if (-not $gh) {
    Write-Host "❌ GitHub CLI not found. Installing..." -ForegroundColor Red
    winget install --id GitHub.cli -e --source winget
}

# The token needs 'repo', 'read:org', 'workflow' scopes
# Hash needs to create a new token at: https://github.com/settings/tokens

Write-Host "`n⚠️  IMPORTANT:" -ForegroundColor Yellow
Write-Host "The current token is missing 'read:org' scope." -ForegroundColor Yellow
Write-Host "Please create a new token at: https://github.com/settings/tokens" -ForegroundColor Yellow
Write-Host "Required scopes: repo, read:org, workflow, gist" -ForegroundColor Yellow
Write-Host "`nThen run: gh auth login --with-token" -ForegroundColor Cyan
