# Implement Tiered Model Routing in OpenClaw
# This script configures OpenClaw to automatically switch models based on task complexity

Write-Host "🚀 Implementing Tiered Model Routing..." -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Cyan

$workspace = "C:\Users\apptopia\.openclaw\workspace"
$routerConfig = "$workspace\model-router.json"

# 1. Create OpenClaw config override
$openclawConfigPath = "$env:USERPROFILE\.openclaw\openclaw.json"

if (Test-Path $openclawConfigPath) {
    $config = Get-Content $openclawConfigPath | ConvertFrom-Json
    
    # Add model routing configuration
    if (-not $config.PSObject.Properties["modelRouting"]) {
        $config | Add-Member -NotePropertyName "modelRouting" -NotePropertyValue @{
            enabled = $true
            strategy = "cost-optimized"
            defaultModel = "openrouter/moonshotai/kimi-k2.6"
            fallbackModel = "openrouter/minimax/minimax-m2.7"
            tiers = @{
                free = @{
                    models = @(
                        "openrouter/meta-llama/llama-3.3-70b-instruct:free",
                        "openrouter/nousresearch/hermes-3-llama-3.1-405b:free"
                    )
                    maxTokens = 4000
                }
                budget = @{
                    models = @(
                        "openrouter/nousresearch/hermes-3-llama-3.1-70b",
                        "openrouter/meta-llama/llama-3.1-70b-instruct"
                    )
                    maxTokens = 8000
                }
                standard = @{
                    models = @(
                        "openrouter/moonshotai/kimi-k2.6",
                        "openrouter/minimax/minimax-m2.7"
                    )
                    maxTokens = 16000
                }
                premium = @{
                    models = @(
                        "openrouter/anthropic/claude-3.7-sonnet",
                        "openrouter/openai/gpt-4o"
                    )
                    maxTokens = 32000
                }
            }
        }
        
        $config | ConvertTo-Json -Depth 10 | Set-Content $openclawConfigPath
        Write-Host "✅ Added model routing to OpenClaw config" -ForegroundColor Green
    }
    else {
        Write-Host "⚠️  Model routing already configured" -ForegroundColor Yellow
    }
}

# 2. Create wrapper script for automatic switching
$wrapperPath = "$workspace\scripts\smart-exec.ps1"
$wrapperContent = @'
# Smart Execution Wrapper
# Automatically selects model tier before executing tasks

param(
    [Parameter(Mandatory=$true)]
    [string]$TaskDescription,
    
    [Parameter(ValueFromRemainingArguments=$true)]
    [string[]]$Arguments
)

$routerPath = "$PSScriptRoot\..\model-router.json"
$router = Get-Content $routerPath | ConvertFrom-Json

# Detect complexity
$taskLower = $TaskDescription.ToLower()
$tier = "standard"  # default

if ($taskLower -match "^(hi|hello|hey|status|check|what|how are)") {
    $tier = "free"
}
elseif ($taskLower -match "(security|critical|emergency|urgent|architecture|design pattern)") {
    $tier = "premium"
}
elseif ($taskLower -match "(git|file|folder|create|delete|move|copy|install|setup)") {
    $tier = "budget"
}

$model = $router.tiers.$tier.models[0]

Write-Host "🎯 Task: $TaskDescription" -ForegroundColor Cyan
Write-Host "🧠 Tier: $tier" -ForegroundColor Cyan
Write-Host "🤖 Using: $model" -ForegroundColor Green

# Set environment variable for current session
$env:OPENROUTER_MODEL = $model

# Execute the actual command
& @Arguments
'@

$wrapperContent | Set-Content $wrapperPath
Write-Host "✅ Created smart execution wrapper" -ForegroundColor Green

# 3. Create heartbeat cost monitor
$monitorPath = "$workspace\scripts\cost-monitor.ps1"
$monitorContent = @'
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
'@

$monitorContent | Set-Content $monitorPath
Write-Host "✅ Created cost monitor" -ForegroundColor Green

# 4. Update HEARTBEAT.md to include cost checks
$heartbeatPath = "$workspace\HEARTBEAT.md"
$heartbeatContent = Get-Content $heartbeatPath -Raw

if ($heartbeatContent -notmatch "cost-monitor") {
    $heartbeatContent += "`n## Cost Monitoring`n`n- [ ] Check daily spending`n- [ ] Alert if approaching budget`n- [ ] Switch to free models if emergency threshold hit`n"
    $heartbeatContent | Set-Content $heartbeatPath
    Write-Host "✅ Updated HEARTBEAT.md with cost checks" -ForegroundColor Green
}

Write-Host "`n🎉 Tiered routing implementation complete!" -ForegroundColor Green
Write-Host "`nNext steps:" -ForegroundColor Cyan
Write-Host "1. Restart OpenClaw gateway to apply config changes" -ForegroundColor White
Write-Host "2. Use .\scripts\smart-exec.ps1 for automatic tier selection" -ForegroundColor White
Write-Host "3. Run .\scripts\cost-monitor.ps1 daily to track spending" -ForegroundColor White
