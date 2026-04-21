# Anthropic Quickstarts — Extracted Patterns

## Agent Patterns Found

### 1. Autonomous Coding Agent
- **Location:** `autonomous-coding/`
- **Pattern:** Self-directed code generation with feedback loop
- **Key Features:**
  - Task decomposition
  - Iterative improvement
  - Error recovery
  - Tool use (file operations, code execution)

### 2. Computer Use Demo
- **Location:** `computer-use-demo/`
- **Pattern:** GUI automation via screenshots + actions
- **Key Features:**
  - Visual perception
  - Mouse/keyboard control
  - Task planning
  - State tracking

### 3. Browser Use Demo
- **Location:** `browser-use-demo/`
- **Pattern:** Web automation with reasoning
- **Key Features:**
  - Navigation
  - Form filling
  - Data extraction
  - Multi-step workflows

### 4. Customer Support Agent
- **Location:** `customer-support-agent/`
- **Pattern:** RAG + conversation management
- **Key Features:**
  - Knowledge base retrieval
  - Context awareness
  - Escalation handling
  - Multi-turn conversations

## Integration Plan

1. **Extract core logic** from each pattern
2. **Create OpenClaw skills** that wrap these patterns
3. **Add to taskflow** for orchestration
4. **Document** in skills-index.md

---

*Studied from: https://github.com/anthropics/anthropic-quickstarts*
