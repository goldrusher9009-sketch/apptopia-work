# Model Router — Cost-Optimized AI Model Selection
# Automatically picks cheapest capable model for each task

param(
    [string]$TaskType = "auto",
    [string]$UserMessage = "",
    [switch]$ShowStatus
)

$routerPath = "$PSScriptRoot\..\model-router.json"
$router = Get-Content $routerPath | ConvertFrom-Json

function Get-TaskType {
    param([string]$message)
    
    # Simple heuristic-based detection
    $message = $message.ToLower()
    
    # Free tier triggers
    if ($message -match "^(hi|hello|hey|status|check|what|how are)" -and $message.Length -lt 100) {
        return "free"
    }
    
    # Budget tier triggers
    if ($message -match "(git|file|folder|create|delete|move|copy|install|setup|config)" -and 
        $message -notmatch "(design|architecture|complex|debug|review)") {
        return "budget"
    }
    
    # Premium tier triggers
    if ($message -match "(security|critical|emergency|urgent|complex reasoning|creative|design architecture)") {
        return "premium"
    }
    
    # Default to standard
    return "standard"
}

function Get-ModelForTask {
    param([string]$tier)
    
    $tierConfig = $router.tiers.$tier
    if (-not $tierConfig) {
        $tier = "standard"
        $tierConfig = $router.tiers.standard
    }
    
    # Return first available model (could add health checks here)
    return $tierConfig.models[0]
}

function Show-RouterStatus {
    Write-Host "🧠 Model Router Status" -ForegroundColor Cyan
    Write-Host "=====================" -ForegroundColor Cyan
    
    foreach ($tier in $router.tiers.PSObject.Properties) {
        $tierName = $tier.Name
        $tierConfig = $tier.Value
        $modelCount = $tierConfig.models.Count
        $color = switch ($tierName) {
            "free" { "Green" }
            "budget" { "Yellow" }
            "standard" { "Cyan" }
            "premium" { "Magenta" }
            default { "White" }
        }
        
        Write-Host "`n[$tierName]" -ForegroundColor $color
        Write-Host "  Models: $modelCount"
        Write-Host "  Max tokens: $($tierConfig.max_tokens)"
        Write-Host "  Use cases: $($tierConfig.use_for -join ', ')"
        
        foreach ($model in $tierConfig.models) {
            Write-Host "  → $model" -ForegroundColor Gray
        }
    }
    
    Write-Host "`n💰 Cost Controls:" -ForegroundColor Cyan
    Write-Host "  Daily budget: `$($router.cost_limits.daily_budget)"
    Write-Host "  Alert at: `$($router.cost_limits.alert_threshold)"
    Write-Host "  Emergency at: `$($router.cost_limits.emergency_threshold)"
}

# Main execution
if ($ShowStatus) {
    Show-RouterStatus
    exit
}

if ($TaskType -eq "auto" -and $UserMessage) {
    $TaskType = Get-TaskType -message $UserMessage
}

$selectedModel = Get-ModelForTask -tier $TaskType

Write-Host "🎯 Task Type: $TaskType" -ForegroundColor Cyan
Write-Host "🤖 Selected Model: $selectedModel" -ForegroundColor Green
Write-Host "💡 Use: openclaw config set model $selectedModel" -ForegroundColor Yellow

# Output for scripting
return $selectedModel
