---
name: daily-planning
description: Use this skill when the user wants to plan their day, review today's tasks, or see what they should work on. Fetches tasks from Todoist (including overdue) and assigned Linear issues, presents a summary, helps select priorities, and creates Todoist tasks for any Linear issues that need tracking.
allowed-tools:
  - mcp__todoist__*
  - mcp__linear__*
  - AskUserQuestion
---

# Daily Planning Skill

This skill helps you plan your workday by gathering tasks from multiple sources and helping you decide what to focus on.

## Workflow

Follow these steps in order:

### 1. Fetch Today's Tasks from Todoist

Use `mcp__todoist__find-tasks-by-date` with:
- `startDate: "today"` (this includes overdue tasks)
- `daysCount: 1`
- Include all fields: id, content, description, priority, dueString, projectId, labels

### 2. Fetch Assigned Linear Issues

Use `mcp__linear__list_issues` with:
- `assignee: "me"`
- Filter for non-completed states (not "Done", "Canceled", "Duplicate")
- `limit: 50`
- Include: id, identifier, title, description, priority, dueDate, state, project, labels

### 3. Present Summary

Create a clear, organized summary showing:

**Todoist Tasks (Today + Overdue):**
- Group by priority (p1 → p4)
- Show: task name, project, due date, labels
- Mark overdue tasks clearly

**Linear Issues (Assigned to You):**
- Group by project/team
- Show: identifier (e.g., RUN-123), title, state, priority, due date, labels
- Highlight if not yet in Todoist

### 4. Ask User to Select Priorities

Use `AskUserQuestion` to let the user select which tasks/issues they want to work on today.
Present options grouped logically (by project or priority).

**Important**: For Linear issues, ask if they want to create corresponding Todoist tasks for any that aren't already tracked.

### 5. Create Todoist Tasks for Selected Linear Issues

For any Linear issues the user wants to track in Todoist:
- Use `mcp__todoist__add-tasks`
- Task content: "[{identifier}] {title}"
- Include description with link to Linear issue
- Set appropriate priority based on Linear priority
- Set due date if one exists
- Add relevant labels

### 6. Confirm and Summarize

Show the user:
- Total tasks selected for today
- New Todoist tasks created
- Quick reference list of what they're working on

## Best Practices

- Always fetch both sources (Todoist and Linear) to give complete picture
- Make summaries scannable with clear grouping and formatting
- Don't assume which tasks are important - let user decide
- Create descriptive Todoist tasks that link back to Linear
- Keep the interaction efficient - minimize back-and-forth

## Example Usage Patterns

User says:
- "What should I work on today?"
- "Show me my tasks for today"
- "Help me plan my day"
- "Daily planning"
- "What's on my plate?"

All of these should trigger this skill.
