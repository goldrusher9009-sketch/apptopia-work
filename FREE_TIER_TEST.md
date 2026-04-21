# Free Tier Test

**Status:** 🟡 Testing

## Message: "hi"

### Expected Route
- Tier: Free
- Model: Llama 3.3 70B (free)

### Actual Route
- Tier: Free
- Model: openrouter/meta-llama/llama-3.3-70b-instruct:free

## Test Results

| Model | Valid | Use Case |
|-------|--------|----------|
| openrouter/meta-llama/llama-3.3-70b-instruct:free | ✅ | Greeting, simple questions
| openrouter/moonshotai/kimi-k2.6 | ❌ | Complex reasoning only
| openrouter/anthropic/claude-3.7-sonnet | ❌ | Critical tasks (needs explicit use)

## Recommendation

Use Llama 3.3 70B for free tier — $0 cost, 65K context, general purpose

## Action

Current model set in openclaw.json:
```powershell
openclaw config set model openrouter/meta-llama/llama-3.3-70b-instruct:free
```

Run this command to set free tier now.