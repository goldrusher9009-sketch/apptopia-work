# Skill Acquisition Engine
# Auto-clones and integrates trending agent repos

param(
    [string]$SearchTerm = "",
    [int]$MaxRepos = 5
)

$workspace = "C:\Users\apptopia\.openclaw\workspace"
$registryPath = "$workspace\second-brain\registry.json"

Write-Host "🧠 Apptopia Skill Acquisition Engine" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan

function Search-GitHubRepos {
    param([string]$query, [int]$limit = 5)
    
    Write-Host "`n🔍 Searching GitHub for: $query" -ForegroundColor Yellow
    
    # Use gh CLI to search
    $results = gh search repos $query --sort stars --limit $limit --json name,owner,description,url,stargazersCount 2>$null | ConvertFrom-Json
    
    return $results
}

function Clone-Repo {
    param([string]$url, [string]$name)
    
    $targetPath = "$workspace\$name"
    
    if (Test-Path $targetPath) {
        Write-Host "⚠️  $name already exists, skipping..." -ForegroundColor Yellow
        return $false
    }
    
    Write-Host "📥 Cloning $name..." -ForegroundColor Cyan
    git clone $url $targetPath 2>&1 | Out-Null
    
    if (Test-Path $targetPath) {
        Write-Host "✅ $name cloned successfully" -ForegroundColor Green
        return $true
    } else {
        Write-Host "❌ Failed to clone $name" -ForegroundColor Red
        return $false
    }
}

function Update-Registry {
    param([string]$name, [string]$url, [string]$path, [array]$capabilities)
    
    $registry = Get-Content $registryPath | ConvertFrom-Json
    
    $newSkill = @{
        status = "cloned"
        source = "github:$url"
        path = $path
        capabilities = $capabilities
        lastUsed = $null
        integrationStatus = "pending"
    }
    
    $registry.skills.external | Add-Member -NotePropertyName $name -NotePropertyValue $newSkill
    $registry.lastUpdated = (Get-Date -Format "yyyy-MM-ddTHH:mm:ssZ")
    
    $registry | ConvertTo-Json -Depth 10 | Set-Content $registryPath
    
    Write-Host "📝 Registry updated with $name" -ForegroundColor Green
}

# Main execution
if ($SearchTerm) {
    $repos = Search-GitHubRepos -query $SearchTerm -limit $MaxRepos
    
    foreach ($repo in $repos) {
        $fullName = $repo.owner.login + "/" + $repo.name
        $url = $repo.url + ".git"
        
        Write-Host "`n📦 Found: $fullName ($($repo.stargazersCount) ⭐)" -ForegroundColor Cyan
        Write-Host "   $($repo.description)" -ForegroundColor Gray
        
        $cloned = Clone-Repo -url $url -name $repo.name
        
        if ($cloned) {
            # Extract capabilities from README
            $readmePath = "$workspace\$($repo.name)\README.md"
            $capabilities = @("auto-detected")
            
            if (Test-Path $readmePath) {
                $readme = Get-Content $readmePath -Raw
                # Simple capability extraction
                if ($readme -match "autonomous|agent|self-improving") { $capabilities += "autonomous" }
                if ($readme -match "browser|web|scraping") { $capabilities += "web-automation" }
                if ($readme -match "code|coding|programming") { $capabilities += "code-generation" }
                if ($readme -match "memory|learn|adapt") { $capabilities += "learning" }
            }
            
            Update-Registry -name $repo.name -url $url -path "$($repo.name)" -capabilities $capabilities
        }
    }
} else {
    Write-Host "`nUsage: .\acquire.ps1 -SearchTerm 'agent framework' -MaxRepos 5" -ForegroundColor Yellow
    Write-Host "`nOr use one of these preset searches:" -ForegroundColor Cyan
    Write-Host "  .\acquire.ps1 -SearchTerm 'autonomous agent'" -ForegroundColor White
    Write-Host "  .\acquire.ps1 -SearchTerm 'ai coding assistant'" -ForegroundColor White
    Write-Host "  .\acquire.ps1 -SearchTerm 'browser automation'" -ForegroundColor White
}

Write-Host "`n✨ Acquisition complete!" -ForegroundColor Green
