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
