---
name: pr-builder
description: Gather comprehensive context when reviewing or creating pull requests. Use this skill when asked to review a PR, create a PR, or get context about changes. Automatically collects related information including git history, linked issues, test status, and relevant code context to provide a complete picture.
---

# PR Builder

## Overview

Gather comprehensive context for pull requests by collecting git history, related issues, tests, and code changes to provide a complete understanding for review or creation.

## When to Use

Use this skill when:
- Creating a new pull request
- Asked to "get context on PR #123"
- Preparing to write a PR description

## Creating a PR

When creating a PR, follow these steps:

### 1. Ensure Branch is Ready

```bash
# Make sure you're on the feature branch
git status

# Ensure branch is up to date with main
git fetch origin
git rebase origin/main  # or git merge origin/main

# Push to remote
git push -u origin username-RUN-123-feature-name
```

### 2. Gather Context for PR Description

Use the context gathering workflow in the references to understand:
- What changed and why
- Related issues/tickets
- Where the noise is -- code generators, re-renders, vendored files, mechanical
  renames, formatting, lockfile churn. Necessary, but not where review effort should go.
- Test coverage
- Breaking changes or migrations

#### Identifying the Noise

The goal is not to hide generated changes -- they still need to be present and
correct -- but to point the reviewer at the **source of truth** instead of its
output. For every generated or mechanical artifact there is a hand-written input
that actually deserves review; the artifact itself only needs a skim to confirm
it regenerated cleanly.

Common categories, and what to review instead of the artifact:

| Noise in the diff | Skim it -- review this instead |
|-------------------|--------------------------------|
| Generated code (`go:generate`, codegen, `*.gen.*`, "DO NOT EDIT" headers) | the generator directive/template and its input |
| Rendered output from a template | the template and the data feeding it |
| Lockfiles (`go.sum`, `pnpm-lock.yaml`, `package-lock.json`) | the manifest that moved (`go.mod`, `package.json`) |
| Vendored / copied dependencies | the version bump or upstream reference |
| Formatting-only and mechanical renames | nothing -- confirm it's purely mechanical and move on |

Two reviewer reflexes worth calling out:
- If a rendered output changed but its template did **not**, treat the output as
  suspect -- it should never drift on its own.
- Lockfile churn with no matching manifest change usually means a stale or
  hand-edited lockfile.

Note: build output that is git-ignored never reaches a diff, so it is not review
noise -- if you see it, something is misconfigured.

### 3. Create the PR

```bash
# Create PR with gh CLI
gh pr create --title "feat(scope): brief description" --body "$(cat <<'EOF'
## Summary
- Bullet point 1
- Bullet point 2

## Review Focus

This section contains the file names, functions and line ranges that hold the real logic changes.

## Commits
- Commit 1 headline (hyperlink to hash)
- COmmit 2 headline (hyperlink to hash)

## Related Issues
Fixes RUN-123
Fixes SENTRY-123

## Breaking Changes
- If any

## Deployment Notes
Any special deployment considerations
EOF
)"
```

**PR Title Format:**
Follow conventional commits format:
```
<type>(<scope>): <description>

Examples:
feat(api): add bulk detection endpoint
fix(rrq): resolve memory leak in source poller
refactor(frontend): simplify authentication flow
```


## Quick Reference

### Context Gathering Commands
```bash
# PR overview
gh pr view 123

# Commit history
git log main..HEAD

# Full diff
git diff main...HEAD

# Changed files
git diff --name-only main...HEAD

# CI status
gh pr checks 123

# Search commits for issues
git log main..HEAD --grep="RUN-"
```

### PR Creation Commands
```bash
# Create PR
gh pr create --title "feat: description" --body "..."

# Create draft PR
gh pr create --draft

# View created PR
gh pr view
```

### PR Review Commands
```bash
# Checkout PR
gh pr checkout 123

# Review and approve
gh pr review 123 --approve

# Request changes
gh pr review 123 --request-changes

# Add comments
gh pr review 123 --comment
```

### Using GitHub CLI Effectively

```bash
# List open PRs
gh pr list

# List your PRs
gh pr list --author @me

# View PR in browser
gh pr view 123 --web

# Check specific PR checks
gh pr checks 123

# Merge a PR
gh pr merge 123 --squash  # or --merge or --rebase
```
