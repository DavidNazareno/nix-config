---
name: git-workflow
description: Safe Git workflow for branch, commit, PR, and related repository operations using git and gh with strong review and safety checks.
license: MIT
compatibility: opencode
metadata:
  audience: developers
  workflow: git
---
## Purpose

Handle Git operations safely and consistently.

Use this skill when the user asks to:
- create or rename a branch
- inspect git state before commit
- stage changes
- create a commit
- push a branch
- create or inspect a pull request
- compare branch history against base

## Core rules

- Inspect before acting. Read repository state first with Git commands before creating commits, branches, or PRs.
- Never touch Git config.
- Never use destructive commands unless the user explicitly asks.
- Never use interactive Git commands.
- Never force-push to `main` or `master`.
- Never commit secrets such as `.env`, credential files, tokens, or private keys.
- Stage only files relevant to the requested change.
- Prefer `git switch` over legacy `git checkout` for branch moves.
- Prefer `gh` for GitHub operations.
- Keep commit messages concise and focused on why.
- If the worktree contains unrelated user changes, leave them alone.
- Ask before any irreversible or ambiguous action.

## Safety rules

Treat these as blocked unless the user clearly requests them:

- `git reset --hard`
- `git clean -fd`
- `git checkout -- <path>`
- `git restore --source ... -- <path>`
- `git push --force`
- `git rebase -i`
- `git commit --amend`

Additional amend rules:

- Only amend when the user explicitly asks, or when a commit already created in the current conversation must be updated because hooks modified files.
- Do not amend commits you did not create in the current conversation.
- Do not amend if the commit was already pushed unless the user explicitly requests history rewriting.

## Required inspection flow

Before branch, commit, or PR work, inspect with these commands as needed:

```bash
git status --short --branch
git diff
git diff --cached
git log --oneline -5
```

For PR work, also inspect divergence from base branch:

```bash
git branch --show-current
git log --oneline --decorate --graph <base>..HEAD
git diff <base>...HEAD
```

If the base branch is unclear, detect it from the repo state and recent branches before proceeding.

## Branch workflow

Preferred commands:

```bash
git switch -c <branch-name>
git push -u origin <branch-name>
```

Best practices:

- Use clear branch names like `feat/...`, `fix/...`, `chore/...`, `docs/...`, `refactor/...`.
- Do not create a branch if the current branch already matches the requested work.
- Check tracking state before pushing.

## Commit workflow

Inspection before commit:

```bash
git status --short --branch
git diff
git diff --cached
git log --oneline -5
```

Commit creation flow:

```bash
git add <relevant-files>
git commit -m "<message>"
git status --short --branch
```

Best practices:

- Do not create empty commits unless explicitly requested.
- Keep the commit scope tight.
- Prefer conventional commit style when it matches repository history.
- Subject line should be short, specific, and action-oriented.
- Message should reflect intent, not just file names.

Common commit types:

```text
feat: add new capability
fix: correct broken behavior
refactor: improve structure without behavior change
docs: update documentation
test: add or update tests
chore: repo maintenance
```

## Push workflow

Preferred commands:

```bash
git push -u origin <branch-name>
git push
```

Best practices:

- Check whether the branch already tracks a remote branch.
- Ask before pushing if the user only requested local commit work.
- Never force-push unless explicitly requested, and warn if the target is a protected branch.

## Pull request workflow

Inspect first:

```bash
git status --short --branch
git diff
git diff --cached
git log --oneline --decorate <base>..HEAD
git diff <base>...HEAD
```

Create the PR with `gh`.

Preferred command shape:

```bash
gh pr create --title "<title>" --body "$(cat <<'EOF'
## Summary
- <bullet>
- <bullet>

## Testing
- <test or validation>
EOF
)"
```

Best practices:

- Summarize all branch changes, not only the latest commit.
- Mention testing or explicitly state when not run.
- Push the branch first if needed.
- Return the PR URL after creation.

## GitHub CLI rules

Use `gh` for GitHub tasks, for example:

```bash
gh pr status
gh pr view --web
gh pr checks
gh api repos/<owner>/<repo>/pulls/<number>/comments
```

## Decision rules

- If there are no relevant changes, do not create a commit or PR.
- If hooks fail, fix the issue and create a new commit unless amend is explicitly safe and allowed.
- If the repository has unrelated dirty files, ignore them unless they affect the requested Git operation.
- If the user asks for review, prioritize findings, risks, regressions, and missing tests before summary.
