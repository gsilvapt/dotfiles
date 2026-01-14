---
name: end-of-day-review
description: Use this skill at the end of the workday when the user wants to review their progress, update task statuses, add comments to Linear issues, complete Todoist tasks, or wrap up their day. Triggers on phrases like "end of day review", "review my progress", "update my tasks", "wrap up for today", or "what did I accomplish today".
allowed-tools:
  - mcp__todoist__*
  - mcp__linear__*
  - AskUserQuestion
---

# End of Day Review Skill

This skill helps you review your workday progress, update task statuses, and prepare for tomorrow.

## Workflow

Follow these steps in order:

### 1. Gather Context About Today's Work

First, try to understand what the user was working on today:

**Option A - If user provides specific tasks/issues:**
- Use the task/issue identifiers they mention

**Option B - If no specific context:**
- Fetch today's completed Todoist tasks: `mcp__todoist__find-completed-tasks` with `since` and `until` set to today's date
- Fetch recent Linear activity: `mcp__linear__find_activity` with `initiatorId: "me"` to see what they worked on
- Fetch in-progress Linear issues: `mcp__linear__list_issues` with `assignee: "me"` and `state` filter for "In Progress" or "In Review"

### 2. Present Summary of Today's Activity

Create a clear summary showing:

**Linear Activity:**
- Issues updated today
- Comments added
- State changes made

**Todoist Activity:**
- Tasks completed today
- Tasks still open

**In Progress Work:**
- Linear issues currently "In Progress" or "In Review"
- Open Todoist tasks

### 3. Review Each Task/Issue

For each task or issue the user was working on today, ask:

Use `AskUserQuestion` to gather:
- What did you accomplish on this task?
- Do you want to update the status? (for Linear: offer state transitions; for Todoist: offer to complete/update due date)
- Do you want to add a comment/note?

**IMPORTANT:** Present options based on current state:
- For Linear issues in "In Progress": offer "Keep In Progress", "Move to In Review", "Move to Done", "Move to Blocked"
- For Linear issues in "In Review": offer "Keep In Review", "Move to Done", "Move back to In Progress"
- For Todoist tasks: offer "Complete", "Reschedule for tomorrow", "Keep as-is", "Update priority"

### 4. Apply Updates

Based on user responses:

**For Linear issues:**
- Add comments using `mcp__linear__create_comment` with the user's notes about what they accomplished
- Update issue state using `mcp__linear__update_issue` if state change requested
- Update other fields (priority, due date) if needed

**For Todoist tasks:**
- Complete tasks using `mcp__todoist__complete-tasks` if done
- Update tasks using `mcp__todoist__update-tasks` for rescheduling/priority changes
- Add comments using `mcp__todoist__add-comments` if the user wants to add notes

### 5. Create Tomorrow's Tasks (Optional)

Ask if the user wants to:
- Create Todoist tasks for any Linear issues still in progress
- Add any new tasks for tomorrow
- Set priorities for tomorrow's work

### 6. Final Summary

Provide a clear wrap-up showing:

**Completed Today:**
- Linear issues moved to "Done" or "In Review"
- Todoist tasks completed
- Comments added

**Carrying Over:**
- Linear issues still in progress
- Todoist tasks rescheduled or still open

**Ready for Tomorrow:**
- New tasks created
- Priorities set

## Best Practices

- Be concise with summaries - focus on actionable items
- Always add meaningful comments to Linear when updating status
- Don't assume task completion - always ask the user
- Respect the user's assessment of progress (partial completion, blocked, etc.)
- When adding comments to Linear, format them professionally (the user's words, but cleaned up)
- For Todoist, prefer completing tasks over leaving them open when user confirms they're done

## Example Interactions

**User:** "End of day review"
- Fetch today's activity
- Present summary
- Ask about each task
- Apply updates
- Show final summary

**User:** "I worked on RUN-1289 today, let's update it"
- Fetch RUN-1289 details
- Ask what was accomplished
- Ask about status change
- Apply updates
- Confirm changes

**User:** "Wrap up for today and plan tomorrow"
- Run full end-of-day review
- After updates, ask about tomorrow's priorities
- Create new tasks as needed
- Confirm tomorrow's plan

## Important Notes

- Always use `initiatorId: "me"` when filtering Linear activity to show only the user's actions
- When creating Linear comments, use professional language but keep the user's voice
- Date format for Todoist: use ISO format (YYYY-MM-DD)
- When rescheduling Todoist tasks, offer "tomorrow" as a natural language option
- Don't mark Linear issues as "Done" unless user explicitly confirms completion
