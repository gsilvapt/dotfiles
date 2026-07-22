---
name: commiter
description: Generate concise, conceptual commit messages following conventional commits format (https://www.conventionalcommits.org). Use this skill when preparing to commit changes, when asked to "create a commit message", or when running git commit operations. Messages focus on the conceptual "what and why" without file names, line numbers, or implementation details.
---

# Commit Message Helper

## Overview

Generate commit messages using conventional commits format that are concise and conceptual, focusing on what changed and why, rather than implementation details.

## When to Use

Use this skill when:
- Preparing to create a git commit
- User asks to "create a commit message" or "commit these changes"
- Running git commit operations
- Reviewing changes before committing

## Message Format

Follow the [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/#specification) specification:

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

### Types
- **feat**: A new feature
- **fix**: A bug fix
- **docs**: Documentation only changes
- **style**: Changes that don't affect code meaning (formatting, etc)
- **refactor**: Code change that neither fixes a bug nor adds a feature
- **perf**: Performance improvements
- **test**: Adding or correcting tests
- **chore**: Changes to build process, dependencies, etc
- **ci**: CI/CD configuration changes

### Scope (Optional)
The scope indicates what area of the codebase is affected. Examine the project structure to determine appropriate scopes. Common patterns:
- Service/component names (e.g., `api`, `auth`, `worker`)
- Feature areas (e.g., `frontend`, `backend`, `cli`)
- Technology-specific (e.g., `database`, `redis`, `graphql`)
- Build/deployment (e.g., `infra`, `ci`, `docker`)
- Investigate the project's past scopes using `git log --oneline -20` to see existing patterns.

When unsure, examine the directory structure or omit the scope entirely.

### Breaking Changes
Add `!` after type/scope for breaking changes:
```
feat(api)!: change authentication response format
```

## Writing Style
- **Concise**: Keep messages brief, sacrifice grammar for concision if needed
- **Conceptual**: Focus on what functionality changed and why
- **No implementation details**: Avoid mentioning specific files, line numbers, or code details
- **Lowercase description**: Start description with lowercase (conventional commits style)
- **Imperative mood**: "add" not "adds" or "added"

## Good Examples

- feat(sources): add github audit log integration
- fix(rrq): resolve race condition in log processor
- refactor(detections): improve query validation logic
- docs: clarify local development setup instructions
- feat(api)!: change detection response format

## Bad Examples (Too detailed)

❌ Contains file path and line number
- fix: update api/server.go line 234 to add authentication middleware

❌ Past tense, missing type prefix
- Added user authentication feature

❌ Wrong type (should be "fix"), contains file path and implementation details
- feat: Fix bug in rrq/processor.go where goroutine channel wasn't properly closed

## Workflow

To create a commit message:

1. **Examine the changes** - Review `git diff` or `git status` output
2. **Identify the type** - Is this a feat, fix, refactor, etc?
3. **Determine scope** - Which part of the codebase? (optional)
4. **Identify the core change** - What is the main functional change?
5. **Determine the why** - Why was this change made?
6. **Draft concisely** - Write the description capturing the essence
7. **Remove details** - Strip out file names, line numbers, implementation specifics
8. **Add body if needed** - For complex changes, add brief context
9. **Mark breaking changes** - Add `!` and footer if applicable

## Anti-Patterns to Avoid

- ❌ File paths: "Update api/detections.go and api/server.go..."
- ❌ Line numbers: "Fix line 342 in processor.go..."
- ❌ Code snippets: "Change `if err != nil` to..."
- ❌ Verbose explanations: Long paragraphs about implementation
- ❌ Past tense: "Added" → use "add" instead
- ❌ Missing type: "add feature" → use "feat: add feature"
- ❌ Uppercase description: "feat: Add feature" → use "feat: add feature"
