# Cost Comparison — Tiered vs Single Model

## Scenario: 100 Daily Requests

### Fixed Model (Kimi K2.6)
- **Model:** openrouter/moonshotai/kimi-k2.6
- **Input cost:** $1.50/M tokens
- **Output cost:** $3.00/M tokens
- **Avg tokens per request:** 1000
- **Total daily cost:** ~$450

### Tiered Model Approach
- **Model distribution:**
  - 70% free (~70 requests)
  - 20% budget (~20 requests)
  - 8% standard (~8 requests)
  - 2% premium (~2 requests)
- **Avg token costs:**
  - free: $0
  - budget: ~$0.40/M
  - standard: ~$1.50/M
  - premium: ~$5.00/M
- **Total daily cost:** ~$45

## Savings: $405 per day

### Details
- Free tier: greetings, simple questions ($0)
- Budget tier: file ops, git, setup (~$0.30-0.66/M)
- Standard tier: complex coding (~$1-2/M)
- Premium tier: security, critical tasks (~$3-15/M)

### Comparison Table

| Tier | Requests | Input Tokens | Output Tokens | Est. Cost |
|------|----------|--------------|---------------|-----------|
| Free | 70 | 70k | 70k | ~$0 |
| Budget | 20 | 20k | 200k | ~$0.16 |
| Standard | 8 | 80k | 800k | ~$6.00 |
| Premium | 2 | 20k | 200k | ~$10.00 |
| Total | 100 | 180k | 1870k | **~$45** |

### Current Model Setup

- ✅ Free: openrouter/meta-llama/llama-3.3-70b-instruct:free
- ✅ Budget: openrouter/nousresearch/hermes-3-llama-3.1-70b
- ✅ Standard: openrouter/moonshotai/kimi-k2.6
- ✅ Premium: openrouter/anthropic/claude-3.7-sonnet

🎯 This tiered approach cuts costs by ~90% for simple tasks while keeping high-quality models available when needed.