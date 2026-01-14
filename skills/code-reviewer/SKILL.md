---
name: code-reviewer
description: Use this skill before committing code when the user says "review my changes", "check my code before commit", "pre-commit review", mentions wanting to commit changes, or when they want a senior engineer review of their uncommitted work. This skill reviews local uncommitted changes for scalability, performance, maintainability, and best practices before creating commits.
allowed-tools:
  - Bash
  - Read
  - Grep
  - Glob
  - AskUserQuestion
version: 1.0.0
---

# Code Reviewer Skill

This skill acts as a senior software engineer reviewing your uncommitted code changes before they are committed. It focuses on scalability, performance, maintainability, and adherence to best practices.

## When to Use

Trigger this skill when the user:
- Says "review my changes before committing"
- Mentions wanting to commit but wanting review first
- Says "check my code", "review this", "pre-commit review"
- Asks for senior engineer feedback on uncommitted changes
- Wants to ensure code quality before committing

## Workflow

Follow these steps precisely:

### 1. Gather Context About Changes

**Check git status:**
```bash
git status --porcelain
```

**Get staged and unstaged diffs:**
```bash
# Staged changes
git diff --cached

# Unstaged changes
git diff

# Both together for full picture
git diff HEAD
```

**Identify modified files:**
```bash
git diff --name-only HEAD
```

### 2. Read Project Guidelines

**CRITICAL**: Always read the project's CLAUDE.md files first to understand:
- Code style requirements
- Testing requirements
- Security guidelines
- Project-specific patterns

**Read relevant CLAUDE.md files:**
- Root `/path/to/project/CLAUDE.md`
- Any CLAUDE.md files in directories being modified
- Global user guidelines at `~/.claude/CLAUDE.md`

Use `Read` tool for each CLAUDE.md file found.

### 3. Review Changes from Multiple Perspectives

For each modified file, analyze the changes for:

#### A. Scalability Issues
- Algorithm complexity (O(n²) or worse)
- Database query patterns (N+1 queries, missing indexes)
- Unbounded loops or recursion
- Memory leaks or unbounded growth
- Missing pagination or limiting
- Resource exhaustion risks

#### B. Performance Problems
- Inefficient data structures
- Redundant operations
- Blocking operations on critical paths
- Missing caching where beneficial
- Unnecessary database round-trips
- Large payload transfers

#### C. Maintainability Concerns
- Code duplication
- Unclear variable/function names
- Missing or misleading comments
- Complex logic without explanation
- Inconsistent patterns
- Hard-coded values that should be configurable
- Missing error messages or context

#### D. Best Practices & Patterns
- **Error handling**: Missing error checks, swallowed errors, insufficient context
- **Security**: Input validation, SQL injection, XSS, secrets in code, unsafe operations
- **Testing**: Untested edge cases, missing test coverage for new functionality
- **Context handling**: Missing context.Context usage (Go), request cancellation
- **Resource cleanup**: Missing defer/finally, unclosed resources
- **Type safety**: Use of `any`/`interface{}` when specific types exist
- **Logging**: Using appropriate logging levels, structured logging
- **Dependencies**: Unnecessary dependencies, version conflicts

#### E. Project-Specific Requirements
- Check against CLAUDE.md guidelines
- Verify adherence to established patterns
- Check commit message requirements
- Verify required documentation updates

### 4. Categorize Issues by Severity

**CRITICAL (Must fix before commit):**
- Security vulnerabilities
- Data corruption risks
- Memory leaks
- Obvious bugs that will crash or fail
- CLAUDE.md violations that break CI/CD

**HIGH (Should fix before commit):**
- Performance problems that will impact users
- Scalability issues that will cause problems at scale
- Missing essential error handling
- Violations of project patterns

**MEDIUM (Consider fixing):**
- Code maintainability issues
- Minor performance improvements
- Refactoring opportunities
- Documentation gaps

**LOW (Nice to have):**
- Style inconsistencies
- Minor optimizations
- Pedantic nitpicks

### 5. Present Findings to User

Use `AskUserQuestion` to present the findings. Format your review as:

```markdown
## Code Review Summary

Reviewed X files with Y lines changed.

### Critical Issues (Must fix)
[List each with file:line reference and explanation]

### High Priority Issues (Should fix)
[List each with file:line reference and explanation]

### Medium Priority Issues (Consider)
[List each with file:line reference and explanation]

### Low Priority Issues (Optional)
[List each with file:line reference and explanation]

### Positive Observations
[Call out good patterns, improvements, or well-written code]
```

Then ask:
```
Would you like to:
1. Fix the issues before committing
2. Commit anyway (not recommended for Critical issues)
3. Fix only Critical/High issues and commit
4. Cancel and review manually
```

### 6. Act on User Decision

Based on user response:

**If "Fix issues first":**
- Offer to help fix the issues
- Guide through each fix
- Re-run review after fixes
- Proceed to commit when clean

**If "Commit anyway" or "Fix Critical/High only":**
- Proceed to step 7

**If "Cancel":**
- End the skill execution
- Let user handle manually

### 7. Proceed to Commit

Once issues are resolved or user approves:

**Do NOT commit yourself.** Instead, remind the user of commit best practices:

```
Ready to commit. Remember to:
- Use conventional commits format (feat:, fix:, docs:, etc.)
- Write a clear, concise commit message
- Reference any Linear issues if applicable
- Run any pre-commit hooks

Would you like me to help you create a commit and PR?
```

If user says yes, guide them through:
1. Creating the commit with proper message format
2. Pushing to remote
3. Creating PR with descriptive title and body

You can suggest using `/commit` command if available, or guide through manual process.

## Best Practices

### For the Reviewer (You)

- **Be specific**: Always include file:line references
- **Explain why**: Don't just say "this is bad", explain the impact
- **Consider context**: A quick fix might have different standards than new features
- **Prioritize correctly**: Don't treat style issues as Critical
- **Be constructive**: Suggest solutions, not just problems
- **Respect urgency**: If user says it's urgent, focus on Critical issues only
- **Check twice**: Re-read CLAUDE.md to ensure you're not inventing requirements
- **No false positives**: Only flag real issues with evidence
- **Trust the user**: They know the context better than you

### For the User

- **Run before every commit**: Make this part of your workflow
- **Fix Critical issues**: Don't commit security vulnerabilities or bugs
- **Consider High issues**: They'll cause problems later
- **Balance speed vs quality**: Use judgment on Medium/Low issues
- **Update CLAUDE.md**: If you disagree with a review pattern, update guidelines

## Example Interactions

### Example 1: Clean Code
```
User: "Review my changes before I commit"
Claude: [Reviews changes]
Claude: "Code looks good! Found 0 critical issues, 0 high priority issues.
        Minor suggestion: Consider adding error context in user_service.go:45.
        Ready to commit?"
User: "Yes"
Claude: "Great! Remember to use conventional commits format..."
```

### Example 2: Issues Found
```
User: "Check my code before committing"
Claude: [Reviews changes]
Claude: "Found issues:

CRITICAL:
- SQL injection vulnerability in query.go:23 (using string concatenation)
- Missing error check for DB connection in main.go:56

HIGH:
- N+1 query pattern in user_handler.go:89 (fetching in loop)

MEDIUM:
- Duplicate logic in services/auth.go:45 and services/user.go:67

Would you like to:
1. Fix the issues before committing
2. Commit anyway (not recommended for Critical issues)
3. Fix only Critical/High issues and commit
4. Cancel and review manually"

User: "Fix Critical and High"
Claude: "Let me help you fix these issues..."
[Guides through fixes]
Claude: [Re-reviews]
Claude: "All Critical and High issues resolved. Ready to commit?"
```

### Example 3: Urgent Hotfix
```
User: "Need to commit this hotfix ASAP, quick review"
Claude: [Reviews changes]
Claude: "Quick review for hotfix:

CRITICAL: None
HIGH: None
MEDIUM: 2 minor issues (can address later)

This is safe to commit for a hotfix. The Medium issues won't cause
immediate problems but should be addressed in a follow-up."
User: "Thanks, committing now"
```

## Important Notes

### Security Review
Always check for:
- Hardcoded secrets, API keys, passwords
- SQL injection (string concatenation in queries)
- XSS vulnerabilities (unescaped user input in HTML)
- Path traversal (unsanitized file paths)
- Command injection (unsanitized shell commands)
- Missing authentication/authorization checks
- Insecure random number generation
- Weak cryptography

### Go-Specific (for RunReveal)
- Always use `context.Context` parameters
- Use `db.QueryContext()` not `db.Query()`
- Use `slog` for logging, not `log.Print()`
- Check error returns, don't ignore with `_`
- Use `defer` for resource cleanup
- Follow Google Go style guide
- Max line length: 128 characters
- Eschew mocking in tests unless explicitly requested

### TypeScript/React-Specific (for RunReveal frontend)
- Avoid `any` type, use proper types
- Use strict type checking
- Handle loading and error states
- Check for accessibility issues
- Validate props with TypeScript types
- Use proper React hooks dependencies

### Database-Specific
- Always use context-aware DB methods
- Check for N+1 queries
- Verify indexes exist for WHERE clauses
- Use parameterized queries (never string concatenation)
- Check transaction handling
- Verify connection cleanup

## Edge Cases

### Large Changes
If reviewing >20 files or >1000 lines:
- Focus on Critical and High issues only
- Suggest breaking into smaller commits
- Review critical files in detail, others at high level

### Trivial Changes
If changes are documentation-only or trivial (typo fixes):
- Quick review
- Focus on documentation accuracy
- Skip detailed performance/scalability review

### Reverted Code
If user is reverting previous changes:
- Check that revert is complete
- Verify no half-reverted state
- Confirm reason for revert

### Emergency Hotfixes
If user indicates urgency:
- Focus only on Critical issues
- Skip Medium/Low issues
- Allow commit of safe code quickly
- Note issues for follow-up

## Technical Details

### File Reading Strategy
- Use `git diff HEAD` to get all changes (staged + unstaged)
- Read full file content for context using `Read` tool
- Use `Grep` to find related patterns in codebase
- Check git blame for historical context if needed

### Review Depth
- **Quick review**: Scan for Critical issues only (< 2 minutes)
- **Standard review**: Check Critical + High issues (2-5 minutes)
- **Thorough review**: All severity levels (5-10 minutes)
- **Deep review**: Include architecture analysis (10+ minutes)

Default to Standard review unless user specifies otherwise.

### Integration with Other Skills
- After successful review, can suggest using `/commit` command
- Can integrate with PR creation workflows
- Complements `/code-review` which reviews PRs after creation
- Works with Linear integration for ticket references

## Confidence in Issues

Rate your confidence for each issue:
- **Certain**: Definite bug or violation, clear evidence
- **Very likely**: Strong evidence, probably real
- **Possible**: Might be an issue, needs user confirmation
- **Uncertain**: Could be intentional, ask user

Only present issues you're Certain or Very Likely about. Flag Possible issues as questions, not statements.

## Version

1.0.0 - Initial release
