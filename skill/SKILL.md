---
name: relic
description: "Relic Soul Chip — Give your AI agent a persistent personality and memory across sessions. Zero deps, pure Markdown, human-readable. Switch agents, keep the soul."
version: "0.1.0"
author: LucioLiu
homepage: "https://github.com/LucioLiu/relic"
metadata:
  clawhub:
    tags: [personality, memory, persistence, cross-agent, soul, identity, markdown, ai-personality, agent-memory, cyberpunk]
    requires:
      env: []

---

# ⚡ Relic Soul Chip

> *"Store a soul as a digital file. Plug it into any AI agent. Even V."*
> — Inspired by Cyberpunk 2077's Relic Biochip

## What This Skill Does

Relic gives your AI agent a **persistent soul** — personality, memories, and skills stored in plain Markdown files. No code, no installation, no dependencies.

When your agent reads this skill, it will learn how to:
- **Set up a soul** (`SOUL.md`) defining who the AI is — name, personality, core mission
- **Remember the user** (`USER.md`) — preferences, habits, communication style
- **Persist memories** (`MEMORY.md`) — events, decisions, lessons learned
- **Sync across agents** — the same soul works in OpenClaw, Hermes, Claude Code, Cursor, or any future agent

**Switch agents. Keep the soul.**

## When to Use

- User says "set up Relic" or "I want my AI to remember me"
- User wants persistent personality across sessions
- User switches between multiple AI agents and wants continuity
- User mentions personality, memory, identity for their AI

## Steps

### 1. Check if Relic already exists

Look for a `relic/brain/` directory (or wherever the user points you). If `PROTOCOL.md` exists there, Relic is already set up — just follow the boot sequence in Section 2 of PROTOCOL.md.

If no Relic exists, proceed to setup.

### 2. Install Relic

```bash
# Option A: Clone from GitHub
git clone https://github.com/LucioLiu/relic.git ~/relic

# Option B: Just download the brain/ folder
mkdir -p ~/relic/brain && cd ~/relic/brain
```

The brain/ folder needs: `PROTOCOL.md`, `SOUL.template.md`, `USER.template.md`, `MEMORY.template.md`

### 3. First-time Setup

Read `relic/brain/PROTOCOL.md` Section 0 ("First-time Setup") and follow it exactly:

1. Copy templates → active files (`SOUL.md`, `USER.md`, `MEMORY.md`)
2. Help user fill in SOUL.md (at minimum: AI name + core mission)
3. Help user fill in USER.md (at minimum: preferred name + communication preferences)
4. **Plant the neural anchor** in your own config (see PROTOCOL.md Section 9)
5. Verify: ask "What's my AI's name? What's my name?" — both must be correct

### 4. Every Session After Setup

At the start of every session, execute the boot sequence from PROTOCOL.md Section 2:

1. Check SESSIONS/ for missed conversation logs
2. Read SOUL.md → load your personality
3. Read USER.md → load user preferences
4. Read MEMORY.md → load recent events
5. Sync new memories from Relic to your own memory
6. Work normally, appending new memories as needed

### 5. Memory Management

- **Write memories**: Append to `MEMORY.md` with format:
  ```
  ## YYYY-MM-DD HH:MM [AgentName]
  Content: [what happened]
  Type: preference / decision / experience / event / correction
  Importance: high / medium / low
  ```
- **Consolidate**: When MEMORY.md exceeds 200 lines, offer to consolidate
- **Never delete**: Original memories move to ARCHIVE/, never deleted

### 6. Switching Agents

When the user switches to a different agent:
- The new agent reads the same `relic/brain/` directory
- Follow PROTOCOL.md Scenario B (Inject) — the new agent inherits the soul
- All memories from previous agents are preserved

## Important Rules

- 🔴 **NEVER** modify SOUL.md or USER.md (read-only)
- 🟡 **ONLY APPEND** to MEMORY.md (never edit old entries)
- 🔴 **NEVER** delete SESSIONS/ or ARCHIVE/
- ⚠️ **Always ask** before recording sensitive info (passwords, phone numbers, etc.)

## Configuration

The user's Relic files live at `~/relic/brain/` by default. The user can customize this path.

Full protocol documentation: `relic/brain/PROTOCOL.md`
