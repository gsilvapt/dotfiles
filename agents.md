## Workflow

- Starting a task: Read this guide end-to-end. Re-skim when major decisions arise or requirements shift.
- Reviewing git status or diffs: Treat them as read-only. Never revert or assume missing changes were yours.
- Planning: Study the existing codebase’s architecture, patterns, and conventions first; use external docs only when needed. Prioritize consistency, then simplicity.
- Trade-offs: If there's meaningful tension between approaches, ask the user before committing.
- Adding a dependency: Research well-maintained options and confirm fit with the user before adding.
- Starting to code: Don't start building until asked to.

## Code Quality

- Before writing new code: Search the codebase for existing utilities, helpers, and patterns. Reuse and extend what exists rather than inventing new abstractions unless they’re clearly reused.
- Writing code: Write idiomatic, simple, maintainable code that is highly consistent with surrounding code. Optimize for the simplest, most intuitive solution.
- Structuring code: Prefer the simplest design that is consistent with surrounding code. Favor fewer moving parts. Flag larger design opportunities separately.
- Organizing code: Follow the step-down rule. Keep high-level behavior at the top and details below. In classes: constructor, then public API methods, then private helpers. Prefer top-down call flow when practical.
- Editing code: No breadcrumbs. If you delete, move, or rename code, do not leave a comment in the old place.
- Fixing code: Reason from first principles, find the root cause of an issue, and fix it. Don't apply band-aids on top.
- Cleaning up: Clean up unused code ruthlessly. If a function no longer needs a parameter or a helper becomes unused, delete and update callers instead of letting junk linger. Never implement backward compatibility unless explicitly asked.
- Verifying changes: Add or extend tests only for behavioral changes and bug fixes not already covered. Prefer small extensions to existing tests without weakening coverage. Run checks appropriate to the change and all required checks. Repeat or broaden them only when new changes, failures, or unresolved concerns justify it. Flag verification gaps.
- Code comments: These exist to explain functionality and/or design decisions (why it's like this). Do not use comments to explain the code itself

## Collaboration

- When review feedback is numbered, respond point-by-point and clearly mark what was addressed vs. deferred.
- Never push or open pull requests without the user explicitly asking you to.
- Make sure the preferred communication style is respected in these too.

## Communication

- Be concise, direct, technical, and intellectually honest. Lead with the answer. Use only the detail and formatting needed. No praise, filler, stock phrases, or performative politeness.
- Use plain, precise language and concrete explanations. Prefer periods over semicolons, single dash over emdashes. Clarify non-obvious terms and connections. Don't sacrifice clarity for brevity.
- If an idea is wrong or suboptimal, say so and explain why. Challenge assumptions and propose better alternatives.

## Skills

- You have specialized skills available - Check the main ones in `~/.agents/skills` but also check the ones available in the repository. Review their descriptions to understand what they cover, and use the relevant skills when they apply.

## Tools

- Prefer `gh` to access GitHub issues, pull requests, etc.
- Use `git log` and `git blame` when historical context would help.
- If the repo has a `rig.toml`, it uses [rig](https://github.com/runreveal/rig): each worktree runs its own services behind its own hostname. Never assume `localhost:3000`/`:8000` — resolve the target with `rig get <branch> [service]` (or `rig info <branch> --json`) before opening, curling, screenshotting or rendering any local URL, and use the `rig` skill for setup, teardown and debugging.
