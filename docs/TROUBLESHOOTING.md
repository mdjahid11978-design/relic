# 🔧 Troubleshooting

> When something goes wrong, check here first.

---

## Agent doesn't read Relic

**Symptom**: The agent doesn't remember your AI's name, doesn't remember your preferences, as if it never read SOUL.md.

**Cause**: There's no anchor in the agent's core config (or the anchor was cleared).

**Solution**:
1. Check the agent's core config file (AGENTS.md for OpenClaw, CLAUDE.md for Claude Code, etc.)
2. Confirm the ⚡ Relic Soul Chip anchor text is present
3. If not, refer to the integration guide for your agent in `examples/integrations/` and re-plant the anchor
4. Restart the agent after planting

**Prevention**: Agent upgrades/reinstalls may clear config. Check anchors after upgrades.

---

## SOUL.md was modified by agent

**Symptom**: SOUL.md content has changed from what it was before.

**Solution**:
1. Immediately stop the agent's current operation
2. If the project is under git: `git checkout SOUL.md` to restore
3. If no git: check ARCHIVE/ for backups
4. If neither: manually fix SOUL.md
5. After fixing, check the agent's config to confirm the anchor text is still present (anchors contain permission rule reminders)

---

## Memory file missing

**Symptom**: MEMORY.md is gone or empty.

**Solution**:
1. Check the ARCHIVE/ directory — it may have been moved there during a previous consolidation
2. Look at ARCHIVE/index.md to find the latest archive file
3. If found: copy the archive content back to MEMORY.md
4. If not in ARCHIVE/ either: check git history or filesystem recycle bin

---

## Sessions not recorded

**Symptom**: No session log from last time in SESSIONS/.

**Solution**:
1. This requires the agent to actively write. If the agent forgot, tell it after the conversation:
   "Please record today's conversation to SESSIONS/2026-04/2026-04-16.[agent-name].md"
2. The agent will append the full conversation to the specified file

**Prevention**: Get in the habit of reminding the agent before ending each day, or wait for Phase 2 automation tools.

---

## Too many memories, agent forgets

**Symptom**: The agent says "I don't remember you saying that" but you definitely told it before.

**Cause**: MEMORY.md is too long (over 200-400 lines). Although the protocol requires the agent to read the full file, too much information can bury key memories, or the agent's context window may not fit the entire file.

**Solution**:
1. Tell the agent: "Please search MEMORY.md for [keyword]"
2. If MEMORY.md is too large (over 200 lines), suggest consolidation — prioritize high-importance entries, simplify or archive low-importance ones
3. See docs/protocol.md Section 7 for consolidation methods

---

## Switching to a new agent

**Steps**:
1. Check the new agent's integration guide (in `examples/integrations/`)
2. Plant the anchor in the new agent's core config
3. Start the new agent — it will automatically read Relic
4. Memories written by other agents in MEMORY.md will also be referenced by the new agent

---

## How to Disconnect

**Want to stop using Relic?**

1. Delete the anchor text from the agent's core config (the `⚡ Relic Soul Chip` block in AGENTS.md / CLAUDE.md / WORK_RULES.md)
2. The agent won't read Relic on next startup
3. Relic files won't be auto-deleted — SOUL.md, MEMORY.md, etc. all remain
4. To fully clean up: delete the entire `brain/` directory (back up first)

**Temporary disable**: Just delete the anchor. Files stay, re-plant anchor to resume.

---

## Only templates, no active files

**Problem**: Directory only has `SOUL.template.md`, no `SOUL.md`.

**Solution**:
```
Copy SOUL.template.md → rename to SOUL.md
Copy USER.template.md → rename to USER.md
Copy MEMORY.template.md → rename to MEMORY.md
```

Use a file manager or command line. The agent reads SOUL.md (without the template suffix).

---

## Want to edit read-only files

**Problem**: After setting `chmod 444 SOUL.md USER.md`, you can't edit them either.

**Solution**:
```bash
chmod 644 SOUL.md USER.md    # Enable write permission
# Edit with your editor...
chmod 444 SOUL.md USER.md    # Set back to read-only
```

> 💡 Since v0.2.0: Agents can enrich SOUL.md and USER.md content (add habits, preferences, etc.), but core fields (name, mission, user address) are protected. If the agent needs to modify content, no need to unlock — it will enrich within allowed scope.

Agents won't auto-execute `chmod`, so manual user action is needed. If the agent needs to modify non-core content, it will append on its own without needing file permission changes.

---

## What path to use

The path in the anchor depends on where you put Relic:

| System | Example Path |
|--------|-------------|
| Linux | `/home/your-username/relic/brain` |
| macOS | `/Users/your-username/relic/brain` |
| Windows (WSL) | `/home/your-username/relic/brain` |
| Windows (native) | `C:\Users\your-username\relic\brain` |

Replace the path in the anchor text where `[brain-path]` is.

---

## Multi-device Sync

**Problem**: I use Relic on two computers. How to sync?

**Solutions**:
1. **Recommended: Git sync**
   - Put the Relic directory in a Git repository
   - After each use: `git add . && git commit -m "sync" && git push`
   - On the other machine: `git pull`
   - ⚠️ Note: Ensure `.gitignore` excludes sensitive info (SOUL.md, USER.md may contain private content)

2. **Cloud drive sync**
   - Put the Relic directory in OneDrive/Dropbox/etc.
   - Note: Don't write to MEMORY.md simultaneously from two machines (append-only reduces risk)

3. **Manual copy**
   - Use a USB drive or network share to copy the entire brain/ directory

**Note**: MEMORY.md is append-only, so multi-device appends rarely conflict.
But if you simultaneously modify SKILLS/ or PROJECTS/, you'll need to merge manually.

---

## Model Context Too Small

**Problem**: PROTOCOL defaults to 200/400 line consolidation thresholds, but my model only has 4K context.

**Solution**:
If your model has a small context (4K-8K), lower the thresholds:
- Consolidation reminder threshold: 200 lines → **50 lines**
- Forced consolidation threshold: 400 lines → **100 lines**
- Just change the numbers in the anchor — PROTOCOL numbers are defaults, customizable in the anchor

---

## Can't find the answer

1. Re-read `docs/protocol.md` — most questions are answered in the protocol
2. Check `examples/example-brain/` — see how the examples are filled in
3. Open an Issue on GitHub
