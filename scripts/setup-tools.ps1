# Apptopia Tool Setup Script
# Run this to configure all tools with API keys

Write-Host "🚀 Setting up Apptopia Superagent Tools..." -ForegroundColor Cyan

# Load environment variables
$envFile = "$PSScriptRoot\..\.env.local"
if (Test-Path $envFile) {
    Get-Content $envFile | ForEach-Object {
        if ($_ -match '^([^#][^=]*)=(.*)$') {
            [Environment]::SetEnvironmentVariable($matches[1], $matches[2], "User")
        }
    }
    Write-Host "✅ Environment variables loaded" -ForegroundColor Green
}

# Verify tools
$tools = @(
    @{Name="git"; Desc="Version control"},
    @{Name="gh"; Desc="GitHub CLI"},
    @{Name="node"; Desc="Node.js runtime"},
    @{Name="npm"; Desc="Node package manager"}
)

foreach ($tool in $tools) {
    $cmd = Get-Command $tool.Name -ErrorAction SilentlyContinue
    if ($cmd) {
        Write-Host "✅ $($tool.Name) found — $($tool.Desc)" -ForegroundColor Green
    } else {
        Write-Host "❌ $($tool.Name) missing — $($tool.Desc)" -ForegroundColor Red
    }
}

Write-Host "`n🎯 Setup complete! Ready to build." -ForegroundColor Cyan
