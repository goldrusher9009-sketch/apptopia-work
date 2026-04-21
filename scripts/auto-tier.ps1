# Auto-Tier Switcher
# Automatically switches model based on message complexity

param([string]$Message = "")

$routerPath = "$PSScriptRoot\..\model-router.json"
$router = Get-Content $routerPath | ConvertFrom-Json

function Get-TaskTier {
    param([string]$msg)
    
    $msg = $msg.ToLower()
    $score = 0
    
    # Complexity indicators
    $complexityPatterns = @{
        "premium" = @("security", "critical", "emergency", "urgent", "architecture", "design pattern", "vulnerability", "exploit", "hack", "breach")
        "standard" = @("debug", "complex", "refactor", "optimize", "performance", "memory leak", "race condition", "deadlock")
        "budget" = @("create", "delete", "move", "copy", "install", "setup", "configure", "git", "file", "folder", "build", "run")
        "free" = @("hi", "hello", "hey", "status", "check", "what", "how", "who", "when", "where", "thanks", "ok", "yes", "no")
    }
    
    foreach ($tier in $complexityPatterns.Keys) {
        foreach ($pattern in $complexityPatterns[$tier]) {
            if ($msg -match $pattern) {
                switch ($tier) {
                    "premium" { return "premium" }
                    "standard" { $score = [Math]::Max($score, 3) }
                    "budget" { $score = [Math]::Max($score, 2) }
                    "free" { $score = [Math]::Max($score, 1) }
                }
            }
        }
    }
    
    # Length-based scoring
    if ($msg.Length -gt 500) { $score = [Math]::Max($score, 3) }
    elseif ($msg.Length -gt 200) { $score = [Math]::Max($score, 2) }
    elseif ($msg.Length -lt 50) { $score = [Math]::Max($score, 1) }
    
    switch ($score) {
        4 { return "premium" }
        3 { return "standard" }
        2 { return "budget" }
        default { return "free" }
    }
}

function Switch-Model {
    param([string]$tier)
    
    $model = $router.tiers.$tier.models[0]
    
    Write-Host "🔄 Switching to $tier tier..." -ForegroundColor Cyan
    Write-Host "🤖 Model: $model" -ForegroundColor Green
    
    # Use openclaw CLI to switch
    $env:Path = [Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [Environment]::GetEnvironmentVariable("Path", "User")
    
    try {
        # Note: This requires openclaw CLI support for model switching
        # For now, we'll output the command to run
        Write-Host "`n⚡ Run this command to switch:" -ForegroundColor Yellow
        Write-Host "openclaw config set model $model" -ForegroundColor White
        
        # Also save to a temp file for auto-loading
        $model | Set-Content "$env:TEMP\apptopia-current-model.txt"
        
        return $model
    }
    catch {
        Write-Host "❌ Error switching model: $_" -ForegroundColor Red
        return $null
    }
}

# Main
if ($Message) {
    $tier = Get-TaskTier -msg $Message
    $model = Switch-Model -tier $tier
    
    Write-Host "`n✅ Tier: $tier" -ForegroundColor Cyan
    Write-Host "✅ Model: $model" -ForegroundColor Green
    
    # Return for piping
    return @{
        tier = $tier
        model = $model
        message = $Message
    } | ConvertTo-Json
}
else {
    Write-Host "Usage: .\auto-tier.ps1 -Message 'your task here'" -ForegroundColor Yellow
}
