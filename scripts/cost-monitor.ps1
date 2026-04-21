# Cost Monitor
# Tracks daily spending and alerts when thresholds are hit

$dailyLogPath = "$env:USERPROFILE\.openclaw\logs\daily-cost.json"
$routerPath = "$PSScriptRoot\..\model-router.json"
$router = Get-Content $routerPath | ConvertFrom-Json

# Ensure log directory exists
New-Item -ItemType Directory -Path (Split-Path $dailyLogPath) -Force | Out-Null

# Load or initialize daily log
if (Test-Path $dailyLogPath) {
    $dailyLog = Get-Content $dailyLogPath | ConvertFrom-Json
    
    # Reset if new day
    if ($dailyLog.date -ne (Get-Date -Format "yyyy-MM-dd")) {
        $dailyLog = @{
            date = (Get-Date -Format "yyyy-MM-dd")
            totalCost = 0
            requests = @()
        }
    }
}
else {
    $dailyLog = @{
        date = (Get-Date -Format "yyyy-MM-dd")
        totalCost = 0
        requests = @()
    }
}

# Check thresholds
$budget = $router.cost_limits.daily_budget
$alertThreshold = $router.cost_limits.alert_threshold
$emergencyThreshold = $router.cost_limits.emergency_threshold

Write-Host "💰 Daily Cost Monitor" -ForegroundColor Cyan
Write-Host "====================" -ForegroundColor Cyan
Write-Host "Today's spending: `$$($dailyLog.totalCost)" -ForegroundColor White
Write-Host "Budget: `$$budget" -ForegroundColor White
Write-Host "Alert at: `$$alertThreshold" -ForegroundColor Yellow
Write-Host "Emergency at: `$$emergencyThreshold" -ForegroundColor Red

if ($dailyLog.totalCost -ge $emergencyThreshold) {
    Write-Host "`n🚨 EMERGENCY: Switching to FREE models only!" -ForegroundColor Red
    # Force free tier
    $env:OPENROUTER_MODEL = "openrouter/meta-llama/llama-3.3-70b-instruct:free"
}
elseif ($dailyLog.totalCost -ge $alertThreshold) {
    Write-Host "`n⚠️  ALERT: Approaching budget limit!" -ForegroundColor Yellow
}
else {
    Write-Host "`n✅ Within budget" -ForegroundColor Green
}

# Save log
$dailyLog | ConvertTo-Json | Set-Content $dailyLogPath
