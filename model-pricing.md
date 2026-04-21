# Model Pricing Comparison

**Date:** 2026-04-21  
**Source:** OpenRouter API

## Your Current Models

### Kimi K2.6 (Current - Moonshot)
- **Model ID:** `openrouter/moonshotai/kimi-k2.6`
- **Status:** ✅ Active
- **Pricing:** Not in this API dump (too new or different endpoint)
- **Context:** 200K tokens

### MiniMax M2.7 (Your Fallback)
- **Model ID:** `openrouter/minimax/minimax-m2.7`
- **Status:** ⚠️ Fallback configured
- **Pricing:** Not in this API dump
- **Context:** 200K+ tokens

## Comparable Models from API

### Budget Options (Cheaper)

| Model | Input | Output | Context |
|-------|-------|--------|---------|
| **Llama 3.1 8B** | $0.00002/M | $0.00005/M | 16K |
| **Llama 3.2 1B** | $0.000027/M | $0.0002/M | 60K |
| **Mistral Nemo 12B** | $0.00002/M | $0.00004/M | 128K |
| **Qwen2.5 7B** | $0.00004/M | $0.0001/M | 32K |
| **Nova Micro** | $0.000035/M | $0.00014/M | 128K |

### Mid-Range (Similar to Kimi)

| Model | Input | Output | Context |
|-------|-------|--------|---------|
| **GPT-4o-mini** | $0.00015/M | $0.0006/M | 128K |
| **Claude 3.5 Haiku** | $0.0008/M | $0.004/M | 200K |
| **Llama 3.1 70B** | $0.0004/M | $0.0004/M | 128K |
| **Hermes 3 70B** | $0.0003/M | $0.0003/M | 128K |
| **Qwen2.5 32B Coder** | $0.00066/M | $0.001/M | 32K |

### Premium (More Expensive)

| Model | Input | Output | Context |
|-------|-------|--------|---------|
| **GPT-4o** | $2.50/M | $10.00/M | 128K |
| **Claude 3 Opus** | $15.00/M | $75.00/M | 200K |
| **Mistral Large** | $2.00/M | $6.00/M | 128K |
| **o1** | $15.00/M | $60.00/M | 200K |

## Free Options

| Model | Cost | Context |
|-------|------|---------|
| **Llama 3.3 70B (free)** | $0 | 65K |
| **Llama 3.2 3B (free)** | $0 | 131K |
| **Hermes 3 405B (free)** | $0 | 131K |

## Recommendation

**If Kimi K2.6 is expensive, switch to:**
1. **Hermes 3 70B** — $0.30/M in/out, 128K context, great for agents
2. **Llama 3.1 70B** — $0.40/M in/out, 128K context, general purpose
3. **Qwen2.5 Coder 32B** — $0.66/M in, $1/M out, great for coding

**For cost savings:**
- Use **free models** for simple tasks
- Use **budget models** (8B-12B) for quick responses
- Reserve Kimi/MiniMax for complex reasoning only

---

*Check exact pricing at: https://openrouter.ai/models*
