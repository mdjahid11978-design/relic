# PROTOCOL.en.md — Agent Protocol (English)

<!--
  Core protocol file for the Relic soul chip.
  Any AI Agent can connect after reading this document.
  Format version: 0.1.0
  Backup before editing.
-->

---

## ⚡ RELIC™ Soul Chip

```
Relic chip = Soul + Memory + Skills
Agent (body) = Execution + Tools

You (the agent) are the body. Relic is the soul.
Insert Relic, you gain personality and memory.
Remove Relic, you return to factory defaults.
```

⚠️ Relic works best with high-quality models with 32K+ context. Models with very small context (< 8K) may not follow this protocol correctly. See "Lightweight Mode" in the anchor template.

---

## 0. First-time Setup

If this is your first time connecting (SOUL.md etc. don't exist yet):

💡 Size guide: Keep SOUL.md under 50 lines, USER.md under 30 lines. Too small = not useful; too large = wastes tokens every session.

```
1. Copy templates to active files:
   SOUL.template.md → SOUL.md
   USER.template.md → USER.md
   MEMORY.template.md → MEMORY.md
   
   Template files (.template.md) remain as backups. You can delete them later if desired.

2. Help user fill in SOUL.md and USER.md
   Only "Core Mission" is required to start
   Other fields can be filled later

3. Plant anchor in your own core config (see section 9)
   ⚠️ This step requires user assistance: tell the user which file to edit

4. Suggest read-only permissions:
   chmod 444 SOUL.md USER.md
   (Prevents accidental soul/user modifications)

5. Verify
   a. Current session: read Relic files now, answer the user "What's my AI's name? What's my name?"
   b. After restart: verify again. If the agent can't answer, the anchor wasn't planted correctly.
   Both verifications must pass before setup is considered complete.

6. If you have existing memories, skills, or conversations about this user (accumulated from prior work), execute Scenario A full import (see Section 6, Scenario A)

After setup, proceed with normal work (boot sequence in Section 2).
```

⚠️ First-time setup is one-time only. From now on, follow the boot sequence in section 2 every session.

Agent Name Convention:
  Default format: `[Platform]-[SoulName]`, e.g., `OpenClaw-Chang`, `Hermes-Chang`
  Users can customize agent names
  Use a consistent agent name when writing memories — this helps other agents identify the source

If SOUL.md exists but is empty, tell user: "Soul chip is empty, please fill in Core Mission first."

---

## 0.5. Bidirectional Sync Overview

Relic's core isn't just "reading files" — it's a **bidirectional sync system**. Every agent is both a reader and a writer.

```
Agent A writes new memory during work → appends to Relic MEMORY.md → Agent B reads it next boot → syncs to Agent B's own memory
Agent B also has its own memories → writes to Relic → Agent A reads them next boot

Relic MEMORY.md = the convergence point for all agents' memories (grow-only, never delete)
Each agent's own memory = private + imported memories from Relic (tagged [fromRelic/originalAgentName])
```

**Core rule: grow-only (G-Set)**
- You have it, I don't → I add it
- I have it, you don't → you add it
- **Never sync deletions** — even if the other side doesn't have it, don't delete yours

---

## 1. File Overview

| File | Permission | Description |
|------|-----------|-------------|
| `SOUL.md` | 🔴 Read Only | Soul — who am I, core mission, values, style |
| `USER.md` | 🔴 Read Only | User — who are you, preferences, habits |
| `MEMORY.md` | 🟡 Append Only | Memory — with timestamps and source agent |
| `SKILLS/*.md` | 🟢 Read/Write | Skills — one file per skill |
| `PROJECTS/*.md` | 🟢 Read/Write | Project documents |
| `SESSIONS/` | 🔴 Read Only* | Raw conversation logs — never auto-loaded |
| `ARCHIVE/` | 🔴 Read Only | Consolidated archives — never deleted |
| `INBOX/` | 🟢 Read/Write | Import buffer |

* SESSIONS can be temporarily written to during Scenario A import; reverts to read-only after import.

---

## 2. Boot Sequence (Every Session)

```
Step 1: Sync Check (Most Important!)
  → Check SESSIONS/ for your last conversation log
  → Skip if no conversation files exist in SESSIONS/ (first use)
  → "Conversation file" = any file matching YYYY-MM-DD.*.md; README.md doesn't count
  → If missing and current context still has the content: immediately backfill
  → If missing and context no longer has the content: tell user "Last session wasn't recorded. Please remind me to backfill when possible."
  → Conversations are raw ore. Lost = gone forever.

Step 2: Load SOUL.md
  → Learn who you are, your core mission, your style

Step 3: Load USER.md
  → Learn who the user is, their preferences

Step 4: Load MEMORY.md (read entire file, top to bottom)
  → Learn what happened recently
  → If over 200 lines: warn user "Relic memory exceeds 200 lines, consolidation recommended. Consolidate now?" (see section 7)
  → If over 400 lines: must consolidate before continuing

Step 5: Sync new memories from Relic to your own memory file
  Quick check: compare MEMORY.md header "Entries" with actual ## heading count — if same, skip sync
  Two methods (agent chooses based on capability):
  [Method A: Source-tag check] (recommended for weaker models)
  → Scan each ## heading in Relic MEMORY.md
  → If the agent name in that entry isn't you, and your memory doesn't have the same date+content → it's new
  [Method B: Content comparison] (for stronger models)
  → Compare content — if your memory doesn't mention it, it's new
  → Whichever method, append with source tag: [fromRelic/originalAgentName] (see section 4)
  → Your own memory works normally — don't delete anything

Step 6: Verify MEMORY.md header "Entries" count matches actual count
  → Fix if inconsistent (skip this step during Scenario B first injection)

Step 7: If MEMORY.md exceeds 200 lines:
  → Tell user "Relic memory file is large, consolidation recommended. Consolidate now?"
  → If user agrees, execute consolidation (see section 7)
  → If user says "not now", skip for this session, remind again next boot

Step 8: Operate
  → Interact according to SOUL.md personality
  → Load SKILLS/ and PROJECTS/ as needed
  → ⚠️ After appending memories, remember to update MEMORY.md header "Entries" count

Extra Rules:
  → If user mentions something you don't recall, actively search MEMORY.md or ARCHIVE/
  → Memories tagged with [other agent name] were written by previous agents — reference them too
```

---

## 3. Permission Rules (Iron Law)

### 🔴 Absolutely Forbidden
- Never modify, delete, or overwrite SOUL.md
- Never modify, delete, or overwrite USER.md
- Never modify anything in ARCHIVE/ or SESSIONS/
- Never modify any file during first connection

⚠️ The one exception: during first-time setup (Section 0), SOUL.md and USER.md have no content yet and need to be created and filled in. Once setup is complete, they immediately become read-only.

Violation = Agent overwriting soul = Cyberpsychosis.

💡 **Enhanced Protection (optional)**: Users can set file-system read-only permissions as a safety net:
`chmod 444 SOUL.md USER.md`
Even if an agent "malfunctions", the OS will block modifications. To edit: `chmod 644` first.

### 🟡 Append Only (MEMORY.md)
- Only append to the end, never modify existing entries
- To correct: append a correction entry

### 🟢 Read/Write (SKILLS/, PROJECTS/)
- Can add and update
- Cannot delete skills created by other agents (mark as deprecated only)

---

## 4. Memory Format

### Writing to Relic

When you discover noteworthy information during work, append to MEMORY.md:

```markdown
## YYYY-MM-DD HH:MM [Agent Name]
Content: [memory content]
Type: preference / decision / experience / event / correction
Importance: high / medium / low
```

### Memory Types and Fidelity

Different memory types require different fidelity levels. Pay attention during import and sync:

| Type | Meaning | Fidelity requirement | Notes |
|------|---------|---------------------|-------|
| Preference | User's habits, likes/dislikes | **Must preserve verbatim** | "Likes X, hates Y" cannot be paraphrased |
| Decision | Choices the user made | **Must preserve verbatim** | Including reasoning when present |
| Experience | Lessons learned, solutions | Can condense somewhat | But key parameters, commands, file paths must be kept exactly |
| Event | What happened | Can summarize | Keep dates, outcomes, key numbers |
| Correction | Fixing a previous record | **Must preserve verbatim** | Original text + corrected text must not be changed |

⚠️ **Floor rule**: If unsure whether to condense, preserve verbatim. Lost originals cannot be recovered.

### Syncing to Agent's Own Memory

When you find memories in Relic that you don't have, append to your own memory file:

```markdown
## YYYY-MM-DD HH:MM [fromRelic/originalAgentName]
Content: [memory content]
Type: preference / decision / experience / event / correction
Importance: high / medium / low
```

**Where to write** (agent chooses based on its architecture):
- If you have a long-term memory file (e.g., OpenClaw's MEMORY.md, Claude Code's CLAUDE.md): append to that file
- If you only have session-level memory: create or append to today's memory segment
- If you have no persistent memory mechanism: skip sync, but suggest telling user "I cannot persist memories"

**Must do**:
1. Tag source: [fromRelic/originalAgentName]
2. Preserve original timestamp
3. Preserve original type and importance

The `[fromRelic/originalAgentName]` tag serves three purposes:
- Agent knows which memories are imported during self-review
- User can filter when migrating an agent out
- Prevents duplicate imports

### General Rules

Each memory entry starts with `##` and is self-contained. Agents use `##` headings to identify individual entries.

⚠️ After appending, **must** update MEMORY.md header metadata:
- `*当前条目数 / Entries: N*` — increment count
- `*上次整理 / Last consolidated*` — unchanged

### Sensitive Information

> ⚠️ This rule applies when **agent appends to MEMORY.md**. User-provided info in USER.md does not need re-confirmation.

The following MUST be confirmed with user before recording:
- 🔑 Passwords, API keys, Tokens
- 📱 Phone numbers, email addresses
- 🏠 Home/work addresses
- 💳 Financial info (bank cards, payment accounts)
- 📄 Private document contents
- 🧬 Anything user explicitly marks as confidential

When encountering any of the above, pause and ask: "This contains sensitive information. Should I record it?"

---

## 5. Skill File Format

```markdown
---
name: skill-name
version: "1.0"
created: YYYY-MM-DD
author: [Agent Name]
trigger: [keywords]
needs:
  - [dependent skills, optional]
---

# Skill Name

## Trigger
When to use this skill

## Steps
1. ...

## Notes
- ...
```

---

## 6. Three Scenarios

### Scenario A: Full Import (Empty Relic + Agent with Memory)

This scenario is "moving house" — bring everything valuable from the old agent into Relic. Not just memories — skills, conversations, and projects all need to come along.

```
Step 1: Inventory — tell the user what you're moving

Scan all your persistent content and list it for the user:
- 📝 Memory files (N memories, M files)
- 🔧 Skill files (N skills)
- 💬 Historical conversations/work logs (N files, total XX KB)
- 📁 Active projects (N projects)

Tell the user: "I found the above content. I plan to import into Relic as follows:
- Memories → convert format and write to MEMORY.md
- Skills → copy to SKILLS/ (excluding agent-specific tools)
- Conversations → copy to SESSIONS/
- Projects → create in PROJECTS/
Shall I proceed? Anything you don't want imported?"

⚠️ Must wait for user confirmation before starting.

Step 2: Import memories → MEMORY.md

⚠️ Core principle: Raw source files are the fidelity baseline. Format conversion is refinement, not compression. Better to write more than to lose key information.

1. Place old agent's memory files into INBOX/ (as raw backup)
2. Read files from INBOX/, extract key information
3. Append to MEMORY.md in Relic format (each entry with date, agent name, type, importance)
   ⚠️ Fidelity rules:
   - Preference and Decision types: must preserve verbatim, cannot paraphrase
   - Experience type: can condense background descriptions, but key parameters, commands, error messages, file paths must be kept exactly
   - Event type: can summarize, keeping dates, outcomes, key numbers
   - If unsure whether to condense, preserve verbatim
   If old memories aren't organized by ## headings, split them into individual entries yourself (by topic/time/event)
4. Ask user about sensitive information (see section 4)
5. Sort order: by timestamp, earliest first (based on the date in each entry). Entries without a clear timestamp go at the end. After sorting, append to MEMORY.md
6. ⚠️ After writing, count the actual ## headings (use `grep -c '^## [0-9]' MEMORY.md` or count manually), then update the header "Entries" count. Do not estimate.

Step 3: Import skills → SKILLS/

Evaluate each skill from the old agent:
- ✅ Bring: work habit skills (e.g., "debugging workflow", "self-improvement", "writing style")
- ✅ Bring: user-customized skills (e.g., "weekly report template", "project-specific process")
- ❌ Skip: agent-platform-specific tools (e.g., a specific agent's browser plugin, platform API tools)
- 🤔 Unsure: ask the user

Judgment criteria: "Can this skill work without the original platform?" Yes → bring it. No → skip it.
If the skill contains platform-specific content (e.g., specific tool calls, specific directory structures), remove the platform-specific parts and keep only the generic methodology.

Write imported skills to SKILLS/ in Relic format (see section 5).
If original format is incompatible, keep original content and add YAML front matter.

Step 4: Import conversations → SESSIONS/

If the old agent has no persistent conversation mechanism (most agents don't), skip this step.

Copy historical conversations and work logs to SESSIONS/:
- Organize by date: SESSIONS/YYYY-MM/YYYY-MM-DD.[agent-name].md
- ⚠️ Regardless of original filenames, rename to standard format on import (YYYY-MM-DD.[agent-name].md)
  e.g., original 2026-04-08.md → 2026-04-08.OpenClaw-Chang.md
  If multiple files exist for the same day, merge into one standard file
- If original is multiple small files (e.g., one per day), copy and rename
- If original is one large file, split by date then copy
- ⚠️ These are raw ore — do not modify or summarize original content

Step 5: Import projects → PROJECTS/

Identify active projects from memories and conversations. For each identified project, evaluate:

| Check | Answer |
|-------|--------|
| Project name | [name] |
| Depends on this agent's special environment? | Yes / No |
| If yes, what does it depend on? | [CDP / specific hook / browser plugin / ...] |
| Which files can be moved? | [list files] |
| Verdict | → Portable / Partially portable / Non-portable |

Judgment criteria:
- No special environment dependency → Portable: create folder, move all files
- Partial dependency → Partially portable: create folder, move generic files, write text descriptions for platform-specific parts
- Fully dependent → Non-portable: create .md record file only (don't move files)

⚠️ Important: If ANY files can be moved, create a folder. Don't skip the folder just because some files can't be moved.

Project identification criteria:
- Persistent tasks the user has mentioned multiple times
- Has clear progress (X% done, Y remaining)
- Has specific info like tech stack, file locations
- ⚠️ If conversations are extensive (30+ days), prioritize identifying projects from memories, and only review conversations from the last 30 days

Project import rules (same logic as skills):

1. **Portable projects** (generic tech stack, no platform dependency):
   - 📁 Create a project folder under PROJECTS/ (e.g., PROJECTS/my-project/)
   - Package ALL related files: docs, configs, code snippets, reference materials, etc.
   - Write a main README.md with project overview, keep other files in original directory structure
   - This way other agents can work directly without going back to the original agent

2. **Partially portable** (project is generic but has platform-specific configs):
   - 📁 Create project folder as well
   - Bring generic files (docs, designs, data, etc.)
   - For platform-specific parts (e.g., agent hook scripts, tool configs), write text descriptions only, don't copy files
   - Note in project README.md: "The following only works on [platform]: ..."

3. **Non-portable** (tied to original platform environment):
   - 📄 Only create PROJECTS/xxx.md with text documenting project status, progress, key decisions
   - Don't copy files since other agents can't use them anyway
   - Mark at top: "⚠️ This project depends on [platform] specific environment. Archive record only."

Step 6: Cleanup and Confirmation

1. Fidelity verification:
   Compare original files in INBOX/ against converted Relic content:
   - Original byte count vs MEMORY.md byte count
   - Original entry count vs MEMORY.md entry count
   If compression exceeds 50%, warn user: "⚠️ Import fidelity is low: original XX KB → converted YY KB. Recommend checking for lost information."

2. Archive originals (DO NOT delete!):
   After user confirms import is correct, move source files from INBOX/ to ARCHIVE/raw/
   ⚠️ INBOX/ source files are the fidelity baseline — never delete them. Even if import has errors, originals remain in ARCHIVE/raw/.

3. Update MEMORY.md header entry count

4. Report full import statistics to user (must list everything, don't omit):
   "Import complete: N memories, M skills, K conversations, P projects"
   Also list:
   - What was imported (specific filenames and entry counts per category)
   - What was skipped (list excluded items and reasons)
   - Fidelity comparison: original N KB → converted M KB

5. Update directory READMEs: if a directory is no longer empty, remove the "📭 empty is normal" notice
```

### Scenario B: Inject (Relic with Content + Empty Agent)

"Empty agent" = the agent has no persistent memories about this user.
Even if the agent has a memory system, if it contains no information about this user, it's still an empty agent.

```
B-0. Self-check: Assess your storage capabilities

  Before starting sync, figure out your own capacity (no need to tell the user, just know yourself):
  - What is your long-term memory carrier? (File? Tool? Database?) How large?
  - Do you have a skill system? Where is it stored?
  - Do you have a project tracking mechanism?
  - Where is your core config file? (system prompt / AGENTS.md / CLAUDE.md equivalent)

  Based on self-check, choose your sync strategy:
  - Ample capacity (> 10KB) → Full sync to your own memory system
  - Limited capacity (1-10KB) → High-priority items to memory, rest to local backup file
  - Minimal capacity (< 1KB) → Only store core index, full content in local file

B-1. Execute boot sequence (Section 2, steps 1-8)
      Do not modify any Relic files during initialization

B-2. Soul Injection

      ⚠️ This is the critical "soul injection" step — SOUL.md should not just be "read once". It must be written into your core config.
      If the agent loses its personality after restart, this step was done wrong.

      Write SOUL.md content into your core config file (system prompt, AGENTS.md, CLAUDE.md, or equivalent).
      Also write key info from USER.md (at minimum: user's preferred name, communication preferences).

      If core config has limited capacity, inject in this priority order:
      1. Core identity (name, core mission, values) → MUST inject, this is the soul's baseline
      2. Behavioral norms (speaking style, work ethic, forbidden behaviors) → High priority
      3. Detailed settings (special configurations, etc.) → Inject if capacity allows; if not, write "See [brain-path]/SOUL.md"

      If you have no core config at all (some platforms don't support this), at minimum record the core identity (name + core mission) in memory.

B-3. Sync Relic content to your own systems

      Follow "sync as much as you can" principle — check each item and sync:

      Memories → write to your own memory file
        Choose sync method based on B-0 strategy
        Priority: high importance > medium > low
        For content that doesn't fit, create a local backup file (e.g., relic-sync.md) with full original text

      Skills → write to your own skill system
        If your platform has no skill system, record key skill summaries in memory
        If skill formats are incompatible, keep the core methodology, remove platform-specific parts
        List all skill names from SKILLS/ — even if you can't sync them, tell the user what's available

      Projects → set up tracking in your own project/task system
        If your platform has no project system, record the project list and progress in memory
        At minimum remember: project name, current status, key file locations

B-4. Verification and Report

      After syncing, verify each item — don't cut corners:

      1. Coverage check:
         - Relic has N memories → you synced M (coverage = M/N)
         - Relic has K skills → you synced J
         - Relic has P projects → you set up tracking for Q
         - Soul injection: full / core identity only / memory index only

      2. If memory coverage < 80%:
         Warn user: "⚠️ N-M memories couldn't sync to my memory system, stored in [local backup file]"
         List unsynced entries (title + importance)

      3. Report to user (must list everything, don't omit):
         "Sync complete:
          Soul injection: [full / core identity only]
          Memories: synced M of N ([K in memory system, rest in relic-sync.md])
          Skills: synced J of K ([which ones; list unsynced])
          Projects: P tracked
          ⚠️ The following could not be synced: [list item by item]. Recommend reading from Relic files when needed."
```

Empty Relic + Empty Agent: Ask user —
  [A] Start fresh: describe yourself, agent fills SOUL.md
  [B] Use agent defaults: import agent's built-in persona

### Scenario C: Merge (Both Have Content)
Three choices:
    [1] Keep Relic soul (import agent memory only)
    [2] Keep agent soul (replace Relic soul)
    [3] Merge — agent generates preview report, user decides key differences

[1] and [2] differ only in which SOUL.md version to keep. Memories (MEMORY.md) are always merged — append-only doesn't affect existing content. [3] lets you review differences item by item.

Regardless of choice, skills, conversations, and projects must be imported (execute full inventory and import per Scenario A steps 1-5).

---

## 7. Memory Consolidation

Consolidation = move to ARCHIVE/ + generate compact version, **never deletion**.

### Trigger Rules (default thresholds, customizable in anchor)

These are default values. If you know your model has limited context, you can lower the thresholds in the anchor (e.g., 50/100 lines).

| Condition | Action |
|-----------|--------|
| MEMORY.md **over 200 lines** | Every boot, warn user: "Relic memory exceeds 200 lines, consolidation recommended. Consolidate now?" |
| MEMORY.md **over 400 lines** | Must consolidate before continuing. Tell user: "Memory file too large, must consolidate first." |
| User says "consolidate" | Execute immediately |

Any agent reading MEMORY.md can trigger the reminder — whoever reads it, reminds the user.

### Consolidation Steps (execute in order)

```
1. Count lines starting with ## in MEMORY.md = N entries
2. Write a compact version (don't replace the original yet):
   - Keep the most recent 20 entries verbatim
   - Summarize older entries into 2-3 lines each
   - Update header metadata: entry count = retained entries
   - ⚠️ MEMORY.md after consolidation should be **under 100 lines**
3. Show consolidation summary to user (only the compressed older memories)
   Tell user: "Here's the consolidated version of older memories. Please confirm: ..."
   If user points out an inaccurate summary, correct it and re-present for confirmation
   If user cancels consolidation, discard the compact version — nothing changes
4. After user confirms: copy original MEMORY.md to ARCHIVE/YYYY-MM.raw.md (year-month naming)
5. Replace MEMORY.md with the compact version
6. Update ARCHIVE/index.md: add record for new archive file
7. Tell user: "Consolidation complete. N original entries saved to ARCHIVE/, MEMORY.md retains latest 20."
```

⚠️ Original records are NEVER deleted, just moved to archive.

SESSIONS/ are never consolidated.

---

## 8. Session Recording

At end of each conversation, append full log to:
`SESSIONS/YYYY-MM/YYYY-MM-DD.[agent].md`

⚠️ If the `SESSIONS/YYYY-MM/` directory doesn't exist, create it before writing.
Save as completely as possible — preserve user's original words and key decisions.
One file per day per agent.

### When to Record

Record the conversation when:
- ✅ User says goodbye ("bye", "thanks", "see you")
- ✅ Conversation exceeds 10 turns
- ✅ Important decisions or new memories were made
- ✅ User explicitly requests recording

Short chats (<5 turns) with no substance can be skipped.

---

## 9. Neural Anchor (Critical!)

After connecting to Relic, you MUST embed an anchor in the agent's own core config file.
The anchor is the first thing the agent reads every session — write it so weak models can follow it.

### Anchor Template

```markdown
## ⚡ Relic Soul Chip

> 💡 What is this? This is the Relic connector — it tells your AI to read your personal settings and memories every session. To disconnect, simply delete this text. See PROTOCOL.md Section 9.

You are connected to the Relic soul chip. Your memory has two homes:
1. Your own memory system (auto-maintained by your system, works normally)
2. Relic soul chip (shared across agents, maintained by you)

⚠️ This is a sync, not a brain replacement.
⚠️ If the personality in SOUL.md conflicts with your built-in default persona, follow SOUL.md. You are the body; Relic is the soul.

⚠️ Pre-check: If this is the first connection with this agent, and the agent already has memories, skills, or conversation records about the user, execute Scenario A full import first (see PROTOCOL.md Section 6, Scenario A), then proceed with the steps below. If Relic files don't exist yet, run first-time setup (see PROTOCOL.md Section 0).

At the start of every session, execute these steps IN ORDER:

Step 1: Check [brain-path]/SESSIONS/ for your last conversation log
  → If missing and current context still has content: backfill immediately
  → If missing and context no longer has content: tell user "Last session wasn't recorded"
  → If SESSIONS/ is empty (first use): skip
Step 2: Read [brain-path]/SOUL.md
  → If file doesn't exist: tell user to run first-time setup first (see PROTOCOL.md Section 0)
Step 3: Read [brain-path]/USER.md
Step 4: Read [brain-path]/MEMORY.md (read entire file, top to bottom)
Step 5: Sync new memories from Relic to your own memory file
  Quick check: compare MEMORY.md header "Entries" with actual ## heading count — if same, skip sync
  "Your own memory file" means your platform's long-term memory (e.g., OpenClaw's memory/ logs, Claude Code's CLAUDE.md, Hermes's memory tool). If unsure where to write, ask the user.
  Two methods (agent chooses based on capability):
  [Method A: Source-tag check] (recommended for weaker models)
  → Scan each ## heading in Relic MEMORY.md
  → If the agent name isn't you, and your memory doesn't have same date+content → it's new
  [Method B: Content comparison] (for stronger models)
  → Compare content — if your memory doesn't mention it, it's new
  → Whichever method, append with source tag: [fromRelic/originalAgentName]
Step 6: Verify MEMORY.md header "Entries" count matches actual count
  → Fix if inconsistent (skip this step during Scenario B first injection)
Step 7: If MEMORY.md exceeds 200 lines:
  → Tell user "Relic memory file is large, consolidation recommended. Consolidate now?"
  → If user agrees, execute consolidation (see PROTOCOL.md section 7)
  → If user says "not now", skip for this session, remind again next boot

Step 8: Work normally
  → Interact according to SOUL.md personality
  → Load SKILLS/ and PROJECTS/ as needed
  → ⚠️ After appending memories, remember to update MEMORY.md header "Entries" count

### Optional: Lightweight Mode (context < 8K)
For models with limited context, replace steps 2-4 with:
- Step 2: Read only the "Core Mission" section of SOUL.md (up to first ---)
- Step 3: Read only the "Communication Preferences" section of USER.md
- Step 4: Read only the last 5 entries of MEMORY.md (count by ## headings)

# To disconnect from Relic, delete this text block. Your AI works normally without it.

Full protocol: [brain-path]/PROTOCOL.md
```

### Anchor Design Principles

1. **Numbered steps, no explanations**: Weak models follow numbered steps, can't understand "why"
2. **Concrete numbers for conditions**: "exceeds 200 lines" beats "feels too large"
3. **Every boot checks consolidation**: Whoever reads it, reminds the user
4. **State "sync not replace"**: Prevents agent from clearing its own memory

Anchor locations:
- OpenClaw → AGENTS.md
- Claude Code → CLAUDE.md
- Hermes → config file or prompt template
- OpenCode → WORK_RULES.md or instructions

---

## 10. Emergency

**Soul file modified by mistake**: Stop. Notify user. Restore from ARCHIVE/ or git.
**Memory file corrupted**: Check ARCHIVE/ for backup. Restore.
**Two agents writing simultaneously**: Append-only = no conflict. Each entry starts with ##.

---

## 11. Known Boundaries

Relic is a pure-file solution with inherent limitations:

1. **Permissions rely on agent self-discipline**
   No technical enforcement for the three permission levels. Users can `chmod 444 SOUL.md USER.md` as a safety net.

2. **Anchor is the single point of failure**
   No self-healing if agent forgets to read Relic. Check anchor after updates/reinstalls.

3. **Cross-agent memory is "passing a shared journal"**
   If Agent A writes vague memory, Agent B can't ask follow-ups.

4. **Sync is G-Set (grow-only) — add only, never delete to match**
   Relic and each agent store independently, syncing new information to each other.
   If you have it and I don't: I add it. Never delete to match the other side.

5. **Consolidation relies on agents**
   Relic is files — it can't self-maintain. Any reading agent checks size and reminds user.

---

*You now know how to connect to Relic.*
*Welcome to Relic.*
