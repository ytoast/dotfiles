---
name: prep-1on1
description: >-
  Prep for a 1:1 meeting. Pulls up the person's notes, scans daily logs
  for recent mentions, and drafts talking points. Usage: /prep-1on1 <name>
---

# 1:1 Meeting Prep

**Your job:** Prepare a concise 1:1 brief so the user walks into the meeting with context and talking points. The argument is the person's name (e.g., `harsh`, `heng`, `mikio`).

**IMPORTANT:** Output the final brief directly to the user. Do NOT create or modify any Obsidian notes — this is a read-only research task.

---

## Step 1: Find the person's 1:1 note

List files in `💻️ messari/one_on_one/` and find the file matching the name argument (case-insensitive, partial match is fine).

If multiple files match (e.g., two notes for the same person from different dates), read all of them — the most recently updated one is the primary note.

If no match is found, tell the user and ask for clarification.

## Step 2: Read the 1:1 note

Use `mcp__obsidian__obsidian_get_file_contents` to read the matched file(s). Extract:
- **Last discussed topics** — what was talked about in the most recent session
- **Open action items** — any unchecked `- [ ]` tasks
- **Recurring themes** — patterns across sessions (e.g., career goals, ongoing projects, feedback given)
- **Questions the user planned to ask** — any "to ask" or "next" sections

## Step 3: Scan daily logs for recent mentions

Read `💻️ messari/personal/2026 Messari Daily Logs.md` (adjust year if needed) and search for mentions of the person's name. Extract:
- What the user noted about this person recently
- Any tasks or blockers involving them
- Any feedback or observations

Also check `💻️ messari/personal/2025 Messari Daily Logs.md` if the 2026 logs don't have enough context.

## Step 4: Check project context (optional)

If the person is known to work on specific projects (from the 1:1 note or daily logs), quickly scan relevant project folders for context:
- `💻️ messari/projects/2026_Q1/` for current quarter work
- Look for notes that mention the person or their project area

## Step 5: Output the brief

Present a clean, actionable brief in this format:

```
## 1:1 Prep: <Name>
**Date:** <today>
**Last 1:1:** <date of last session from note>

### Follow-ups from Last Time
- <open action items or things discussed that need follow-up>

### What's Been Happening
- <recent mentions from daily logs — what they've been working on, any blockers>

### Suggested Talking Points
1. <follow up on X from last session>
2. <check in on Y project/task>
3. <any feedback to give or observations from daily logs>
4. <career/growth topic if relevant>

### Open Questions
- <any unresolved questions from previous notes>
```

---

## Guidelines
- Keep it concise — this is a prep doc, not a novel
- Prioritize actionable items over historical context
- If there are no open items or recent mentions, say so — don't fabricate content
- The brief should take <30 seconds to read before the meeting starts
