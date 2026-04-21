# 💰 Cost Optimization Guide

**Strategy:** Tiered model routing — use cheapest capable model for each task.

## How It Works

```
Your Request → Auto-Detect Complexity → Pick Cheapest Model → Execute
```

## Tiers

### 🆓 FREE ($0)
**Models:** Llama 3.3 70B, Hermes 3 405B  
**Use for:** Greetings, simple questions, status checks, short responses

### 💵 BUDGET (~$0.30-0.66/M tokens)
**Models:** Hermes 3 70B, Llama 3.1 70B, Qwen 2.5 32B  
**Use for:** File operations, git commands, simple coding, documentation

### ⚡ STANDARD (~$1-2/M tokens)
**Models:** Kimi K2.6, MiniMax M2.7  
**Use for:** Complex coding, debugging, architecture, code review

### 💎 PREMIUM ($3-15/M tokens)
**Models:** Claude 3.7 Sonnet, GPT-4o  
**Use for:** Security, critical decisions, creative tasks, emergencies

## Usage

### Check what model will be used:
```powershell
.\scripts\model-router.ps1 -UserMessage "your task here"
```

### Force a tier:
```powershell
.\scripts\model-router.ps1 -TaskType free
.\scripts\model-router.ps1 -TaskType budget
.\scripts\model-router.ps1 -TaskType standard
.\scripts\model-router.ps1 -TaskType premium
```

### View router status:
```powershell
.\scripts\model-router.ps1 -ShowStatus
```

## Cost Controls

- **Daily budget:** $10
- **Alert at:** $5 (warning)
- **Emergency at:** $8 (switch to free models only)

## Examples

| Your Request | Detected Tier | Model Used | Est. Cost |
|-------------|---------------|------------|-----------|
| "hi" | Free | Llama 3.3 70B | $0 |
| "create a file" | Budget | Hermes 3 70B | ~$0.001 |
| "debug this code" | Standard | Kimi K2.6 | ~$0.01 |
| "security audit" | Premium | Claude 3.7 | ~$0.05 |

---

*Saving money without sacrificing capability.*
