# Tiered Model Selection Demo

## Message: "hi how are you"

### Analysis
- Message length: 13 characters
- Technical terms: 0 matches
- Budget patterns (setup, install, etc.): No match
- Standard patterns (debug, complex): No match
- Premium patterns (security, critical): No match

### Complexity Score
- Starting score: 0
- Length bonus: +1 (short greeting)
- Pattern matches: 0
- **Final score: 1** (free tier)

## Selected Model
- openrouter/meta-llama/llama-3.3-70b-instruct:free
- Cost: $0

## Why Free Tier?
- Short messages (length < 50)
- No technical terms
- No complex reasoning needed
- Greeting pattern matched

## Next: Complex Task
Test with: "debug this Kubernetes deployment"

🎯 This demonstrates the tiered approach working for simple messages.