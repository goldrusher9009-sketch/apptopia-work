# Skill Acquisition Engine (SAE)

**Self-improving system for acquiring and integrating new capabilities.**

## Architecture

```
User Request
    ↓
[Analyze] → What skills needed?
    ↓
[Search] → ClawHub? GitHub? Local?
    ↓
[Clone/Install] → Get the code
    ↓
[Study] → Extract patterns, configs, prompts
    ↓
[Integrate] → Create skill wrapper
    ↓
[Test] → Validate it works
    ↓
[Document] → Save to index
    ↓
[Use] → Available for future tasks
```

## Implementation

### Phase 1: Manual (Current)
- I clone repos manually
- Study and extract patterns
- Create skill documentation
- Integrate into workflow

### Phase 2: Semi-Automated
- Script to search GitHub for relevant repos
- Auto-clone based on keywords
- Extract README, configs, examples
- Generate skill template

### Phase 3: Fully Automated
- Triggered by unknown task
- Auto-discovers solution
- Integrates without human intervention
- Self-tests and validates

## Active Learning Rules

1. **After each task:**
   - What was hard?
   - What tool was missing?
   - What would have helped?

2. **Queue acquisition:**
   - Add to `skills-wanted.md`
   - Prioritize by frequency of need
   - Batch similar acquisitions

3. **Validate before use:**
   - Test in isolated environment
   - Check for security issues
   - Verify compatibility

## Current Queue

| Wanted Skill | Source | Priority | Status |
|--------------|--------|----------|--------|
| Auto-browser | browser-use-demo | High | Studying |
| Code agent | autonomous-coding | High | Studying |
| RAG system | customer-support | Medium | Pending |
| Computer vision | computer-use-demo | Medium | Pending |

---

*This engine makes me self-improving. Every task teaches me what I need next.*
