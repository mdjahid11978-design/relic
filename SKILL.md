---
name: relic
description: "Relic Soul Chip — Persistent AI personality and memory across agents. Zero deps, pure Markdown files. Inspired by Cyberpunk 2077."
version: "0.1.0"
author: LucioLiu
license: GPL-3.0
homepage: "https://github.com/LucioLiu/relic"
platforms: [macos, linux, windows]
metadata:
  hermes:
    tags: [Personality, Memory, Persistence, Cross-Agent, Identity, AI-Soul, Agent-Memory, Markdown, User-Preferences]
    related_skills: []
    requires_toolsets: []

---

# ⚡ Relic Soul Chip

Give your AI agent a persistent personality and memory that survives sessions and follows the user across different agents. Zero dependencies. Pure Markdown. Human-readable.

## What Relic Does

Relic stores an AI's soul (personality + mission), user profile, and memories in plain Markdown files. Any agent that can read files can connect — OpenClaw, Hermes, Claude Code, Cursor, or any future agent.

**Switch agents. Keep the soul.**

## When to Trigger

- User mentions wanting persistent AI personality or memory
- User says "set up Relic" or "I want my AI to remember me"
- User switches agents and wants continuity
- Boot sequence (every session if Relic is set up)

## Verification

Check that:
1. SOUL.md and USER.md exist and are filled in
2. Agent can answer "What's my AI's name? What's my name?"
3. Agent reads Relic files at the start of every session

## Steps

### First-time Setup

1. Clone Relic: `git clone https://github.com/LucioLiu/relic.git ~/relic`
2. Read the full protocol: `~/relic/brain/PROTOCOL.md`
3. Copy templates to active files (SOUL.md, USER.md, MEMORY.md)
4. Help user fill in SOUL.md (AI name + core mission) and USER.md (user preferences)
5. Plant neural anchor in your config (see PROTOCOL.md Section 9)
6. Verify setup works

### Every Session (Boot Sequence)

1. Check SESSIONS/ for missed logs → backfill if needed
2. Read SOUL.md → load personality
3. Read USER.md → load user preferences
4. Read MEMORY.md → load recent events
5. Sync new memories from Relic to your own memory file
6. Work normally, appending new memories

### Memory Writing

```
## YYYY-MM-DD HH:MM [AgentName]
Content: [what happened]
Type: preference / decision / experience / event / correction
Importance: high / medium / low
```

### Switching to Another Agent

The user's soul lives in `~/relic/brain/`. The new agent reads the same files and follows PROTOCOL.md Scenario B (Inject).

## Rules

- 🔴 NEVER modify SOUL.md or USER.md
- 🟡 ONLY APPEND to MEMORY.md
- 🔴 NEVER delete SESSIONS/ or ARCHIVE/
- ⚠️ Ask before recording sensitive info

## Full Documentation

Read `~/relic/brain/PROTOCOL.md` for the complete protocol including:
- Three import scenarios (empty → full, full → empty, both have data)
- Memory consolidation when files get large
- Bidirectional sync between Relic and agent memories
- Session recording guidelines
