# 🧠 Apptopia's Second Brain

**Self-improving skill acquisition and execution system.**

## Architecture

```
┌─────────────────────────────────────────┐
│           USER REQUEST                  │
└─────────────────┬───────────────────────┘
                  ↓
┌─────────────────────────────────────────┐
│      SKILL ORCHESTRATOR                 │
│  (Decides what capabilities needed)     │
└─────────────────┬───────────────────────┘
                  ↓
    ┌─────────────┼─────────────┐
    ↓             ↓             ↓
┌────────┐  ┌──────────┐  ┌──────────┐
│ LOCAL  │  │ CLAWHUB  │  │ GITHUB   │
│ SKILLS │  │ SKILLS   │  │ REPOS    │
└────────┘  └──────────┘  └──────────┘
    └─────────────┬─────────────┘
                  ↓
┌─────────────────────────────────────────┐
│      SKILL INTEGRATION ENGINE           │
│  (Clone, study, extract, integrate)     │
└─────────────────┬───────────────────────┘
                  ↓
┌─────────────────────────────────────────┐
│      EXECUTION + LEARNING LOOP          │
│  (Do task, save learnings, improve)     │
└─────────────────────────────────────────┘
```

## Components

### 1. Skill Registry (`registry.json`)
- All available skills (local + external)
- Metadata: source, status, capabilities, dependencies
- Auto-updated when new skills acquired

### 2. Acquisition Engine (`acquire.ps1`)
- Searches GitHub for trending agent repos
- Clones and studies code
- Extracts patterns, prompts, configs
- Creates skill wrapper

### 3. Memory System (`memory/`)
- Long-term: What works, what doesn't
- Short-term: Current task context
- Episodic: Specific execution traces

### 4. Execution Runtime
- Loads relevant skills for task
- Orchestrates multi-skill workflows
- Saves results and learnings

## Active Skills Inventory

| Skill | Source | Status | Capabilities |
|-------|--------|--------|--------------|
| healthcheck | OpenClaw | ✅ Ready | Security audits |
| taskflow | OpenClaw | ✅ Ready | Workflow orchestration |
| coding-agent | OpenClaw | ⚠️ Setup | Delegate coding |
| browser-use | Anthropic | 📥 Cloned | Web automation |
| computer-use | Anthropic | 📥 Cloned | GUI automation |
| autonomous-coding | Anthropic | 📥 Cloned | Self-directed coding |
| langchain | GitHub | 📥 Cloned | LLM chaining |
| promptflow | Microsoft | 📥 Cloned | Prompt engineering |

---

*This is my mind. It grows with every task.*
