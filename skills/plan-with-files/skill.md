---
name: plan-with-files
description: Transforms workflow to use persistent markdown files for planning, progress tracking, and knowledge storage. Use when starting complex tasks, multi-step projects, research tasks, or when the user mentions planning, organizing work, tracking progress, or wants structured output.
---

# Planning with Files

Use persistent markdown files as your "working memory on disk." For any
non-trivial task, create `plan.md` to track progress and `notes.md` to store
findings — keep large content in files, not in context.

## Workflow

1. **Create `plan.md` first** at the working directory root (NEVER inside `.claude/` or `.git/`) — define the goal and phases as checkboxes.
2. **Re-read `plan.md`** before each major decision to refresh goals.
3. **Update `plan.md` after each phase** — mark `[x]`, update status, log errors.
4. **Store findings in `notes.md`** as you research; reference paths, don't paste.
5. **Write the deliverable** to its own file at completion.

## plan.md Template

```markdown
# Task Plan: [Brief Description]

## Goal
[One sentence describing the end state]

## Phases
- [ ] Phase 1: Plan and setup
- [ ] Phase 2: Research/gather information
- [ ] Phase 3: Execute/build
- [ ] Phase 4: Review and deliver

## Decisions Made
- [Decision]: [Rationale]

## Errors Encountered
- [Error]: [Resolution]

## Status
**Currently in Phase X** - [What I'm doing now]
```

## When to Use

**Use for:** multi-step tasks (3+ steps), research, building something, or work
spanning multiple tool calls.

**Skip for:** simple questions, single-file edits, quick lookups.

Prefer `plan.md` over TodoWrite when persistence across the task matters.
