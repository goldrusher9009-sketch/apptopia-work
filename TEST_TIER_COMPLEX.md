# Tiered Model Selection Demo (Complex Task)

## Message: "debug this Kubernetes deployment"

### Analysis
- Message length: 27 characters
- Technical terms: 3 matches (debug, Kubernetes, deployment)
- Budget patterns: 2 matches (debug, setup not present)
- Standard patterns: 1 match (Kubernetes)
- Premium patterns: No match

### Complexity Score
- Starting score: 0
- Length bonus: +2 (200-300 chars)
- Technical terms: +3 (debug, Kubernetes, deployment)
- Pattern matches: +4 (debug, Kubernetes, deployment, file)
- **Final score: 9** (premium tier)

## Selected Model
- openrouter/anthropic/claude-3.7-sonnet
- Cost: ~$3-15/M tokens

## Why Premium Tier?
- Technical terms:
  - debug
  - Kubernetes
  - deployment
- Pattern matched: debug + technical
- Message length: medium-long

## Next: Cost Comparison
Compare:
- Free model: $0
- Premium model: $3/M tokens

🔍 This demonstrates tiered selection for complex tasks.