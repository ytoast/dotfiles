---
name: triage-inbox
description: >-
  Triage Obsidian inbox notes into their proper vault folders.
  Reads each note in the inbox, classifies it, proposes a move plan,
  then executes after confirmation.
---

# Obsidian Inbox Triage

**Your job:** Move notes from the Obsidian inbox (`✍️ areas/📥 inbox/`) to their proper folders. Every note should leave the inbox — nothing lives there permanently.

---

## Step 1: List inbox contents

Use `mcp__obsidian__obsidian_list_files_in_dir` to list everything in `✍️ areas/📥 inbox/`. Ignore the `archive/` subfolder.

## Step 2: Read each note

Use `mcp__obsidian__obsidian_get_file_contents` to read every file. Understand the topic, context, and type of each note.

## Step 3: Classify and propose destinations

Map each note to one of these destinations based on content:

| Destination | What goes here |
|---|---|
| `💻️ messari/one_on_one/` | 1:1 meeting notes with specific people |
| `💻️ messari/projects/2026_Q1/` | Current quarter work projects, meeting notes, feature work (adjust quarter as needed) |
| `💻️ messari/projects/<prior_quarter>/` | Older project work — pick the right quarter folder |
| `💻️ messari/personal/` | Daily logs, reviews, personal reflections, films, writing |
| `💻️ messari/techtalk/` | Internal tech talks and knowledge shares |
| `💻️ messari/` | Standalone messari reference notes |
| `✍️ areas/job_search/` | Interview notes, job descriptions, recruiter calls |
| `✍️ areas/people/` | General people notes (non-messari) |
| `✍️ areas/admin/` | Expenses, admin tasks |
| `📚 learning/software/` | Programming languages, frameworks, tools, setup guides |
| `📚 learning/ai/mcp/` | AI tools, MCP configs, Claude/LLM setup |
| `📚 learning/blockchain/` | Protocol deep dives, blockchain concepts |
| `📚 learning/trading/` | Trading strategies, market analysis |
| `📚 learning/books/` | Book notes and summaries |
| `archive/` | Stale/outdated notes from >6 months ago with no ongoing relevance |
| **DELETE** | Empty notes, duplicate content, untitled .base files with no content |

**Classification rules:**
- If a note mentions a specific person's name as the primary subject and contains 1:1 style content → `one_on_one/`
- If a note is about a messari work project → pick the right quarter under `projects/`
- If a note is a vendor/external call about messari work → same quarter as the work it relates to
- If a note is purely learning/reference material → `📚 learning/<subtopic>/`
- If a note is empty or has only frontmatter → DELETE
- When in doubt about quarter, use the note's `updated` timestamp from frontmatter

## Step 4: Present the plan

Show the user a table with: **File → Destination → Reason (brief)**

Wait for user approval before proceeding.

## Step 5: Execute moves

For each file:
1. **Create** the file at the destination using `mcp__obsidian__obsidian_append_content` with the full original content
2. **Delete** the original using `mcp__obsidian__obsidian_delete_file` with `confirm: true`

Do creates first in batches, then deletes in batches. This prevents data loss if something fails mid-way.

## Step 6: Verify

List the inbox again to confirm it's clean. Report what's left (if anything) and why.

---

## Notes
- Files with special characters (like `?`) in filenames may fail to read/delete — flag these for manual handling
- The `archive/` subfolder inside inbox should be left alone
- Preserve the full file content including frontmatter when moving
- If a note contains embedded images (`![[Pasted image ...]]`), warn the user that image references may break after moving
