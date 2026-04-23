# Git Commands Reference

Essential Git commands with explanations. Use `ruby-ref-search` to find what you need.

---

## Getting Started

### Initialize a Repository
```bash
git init
# Creates a new .git folder, starts tracking in current directory
```

### Clone a Repository
```bash
git clone <url>
# Downloads entire repo to your machine
# Example: git clone https://github.com/user/repo.git
```

---

## Branches

### See Current Branch
```bash
git branch
# Shows all local branches, * marks current branch
```

### Create a New Branch
```bash
git checkout -b feature/my-feature
# Creates and switches to new branch
# Naming: feature/*, bugfix/*, refactor/*
```

### Switch Branches
```bash
git checkout branch-name
# Switches to existing branch (old way)

git switch branch-name
# Switches to existing branch (newer way, clearer)
```

### List All Branches (Local and Remote)
```bash
git branch -a
# Shows all branches including remote-tracking branches
# Remote branches appear as: remotes/origin/branch-name
```

### Delete a Branch
```bash
git branch -d feature/my-feature
# Deletes local branch (safe - warns if not merged)

git branch -D feature/my-feature
# Force delete (use carefully)
```

---

## Staging and Committing

### Check Status
```bash
git status
# Shows: current branch, staged files, unstaged files, untracked files
# Most important command—use it often
```

### Stage Files for Commit
```bash
git add file.rb
# Stages specific file

git add .
# Stages ALL changes (use carefully, review with git status first)

git add -p
# Interactive: choose which changes to stage (great for breaking into commits)
```

### Commit with Message
```bash
git commit -m "Add CSV loading"
# First line < 50 chars, imperative mood ("Add" not "Added")

git commit -m "Add CSV loading

This uses headers: true for easier column access by name
instead of numeric index, improving readability."
# Multi-line: first line is summary, blank line, then details
```

### Amend Last Commit (Careful!)
```bash
git commit --amend
# Adds staged changes to previous commit
# ONLY if commit not yet pushed to remote
# If pushed, use git revert instead

git commit --amend --no-edit
# Amend without changing commit message
```

---

## Remote Repositories

### See Remote URLs
```bash
git remote -v
# Shows: fetch and push URLs for all remotes
# Usually: origin (your repo) and upstream (original repo if fork)
```

### Add a Remote
```bash
git remote add origin https://github.com/user/repo.git
# Connects local repo to remote (usually done after git init)
```

### Change Remote URL (Fix Wrong Origin)
```bash
git remote set-url origin https://github.com/user/new-repo.git
# Changes the URL for 'origin' remote

git remote set-url --push origin https://github.com/user/new-repo.git
# Changes only the push URL (if different from fetch)
```

### Push to Remote
```bash
git push origin feature/my-feature
# Pushes branch to remote

git push -u origin feature/my-feature
# Pushes AND sets upstream (so later: git push works without branch name)

git push
# Pushes to default remote (usually origin)
```

### Pull from Remote
```bash
git pull
# Fetch + merge in one command
# Usually: git pull origin main

git pull --rebase
# Fetch + rebase instead of merge (cleaner history)
```

### Fetch (Get Latest Without Merging)
```bash
git fetch
# Downloads all remote changes
# Doesn't merge into your branch (safe to see what's new)

git fetch origin
# Fetch from specific remote
```

---

## Viewing History

### See Commit History
```bash
git log
# Shows all commits (press q to quit)

git log --oneline
# Shows commits in one line (cleaner)

git log --oneline -10
# Shows last 10 commits

git log --graph --oneline --all
# Visual tree of all branches and commits (beautiful!)
```

### See Specific Commit Details
```bash
git show <commit-hash>
# Shows what changed in that commit
# Example: git show abc1234

git show HEAD
# Shows latest commit

git show HEAD~1
# Shows second-to-last commit (~ = previous, ~2 = two commits back)
```

### See Differences

```bash
git diff
# Shows unstaged changes (what's different from last commit)

git diff --staged
# Shows staged changes (what will be committed)

git diff <branch1> <branch2>
# Shows difference between two branches
# Example: git diff main feature/new-thing

git diff <commit1> <commit2>
# Shows difference between two commits
```

---

## Undoing Changes (Critical Section)

### Undo Unstaged Changes (Before Staging)
```bash
git restore file.rb
# Discards changes in file (reverts to last commit)
# WARNING: This deletes your local changes

git checkout file.rb
# Old way of doing same thing
```

### Unstage a File (After Staging, Before Commit)
```bash
git restore --staged file.rb
# Removes file from staging area (keeps changes in working directory)

git reset HEAD file.rb
# Old way of doing same thing
```

### Undo Last Commit (But Keep Changes)
```bash
git reset --soft HEAD~1
# Undoes last commit, keeps changes staged
# Use when: "I committed too early"

git reset --mixed HEAD~1
# Undoes last commit, keeps changes unstaged (default behavior)
# Use when: "I want to re-stage and recommit"
```

### Undo Last Commit (Discard Changes)
```bash
git reset --hard HEAD~1
# Undoes last commit AND discards all changes
# WARNING: Permanent! Only if absolutely sure

git reset --hard origin/main
# Discard all local changes, match remote exactly
# WARNING: Very destructive
```

### Create New Commit That Undoes Previous
```bash
git revert <commit-hash>
# Creates NEW commit that reverses the specified commit
# Safe for commits already pushed
# Example: git revert abc1234
```

### Recover Lost Commits (Reflog)
```bash
git reflog
# Shows history of where HEAD has been
# Use when: "I accidentally deleted a commit"

git reflog show
# More detailed reflog

git reset --hard <reflog-hash>
# Restore to a point in reflog history
# Great recovery tool!
```

---

## Stashing (Temporary Storage)

### Save Work Without Committing
```bash
git stash
# Saves all changes (staged and unstaged) temporarily
# Clears working directory
# Use when: switching branches but not ready to commit

git stash save "description"
# Stash with a helpful description
```

### List Stashes
```bash
git stash list
# Shows all stashed changes
# Format: stash@{0}: WIP on branch-name: abc1234 commit message
```

### Restore Stashed Changes
```bash
git stash pop
# Applies most recent stash and removes it

git stash apply
# Applies most recent stash but keeps it

git stash apply stash@{2}
# Applies specific stash (use git stash list to see number)
```

### Delete Stashes
```bash
git stash drop
# Deletes most recent stash

git stash drop stash@{2}
# Deletes specific stash

git stash clear
# Deletes all stashes (careful!)
```

---

## Merging and Rebasing

### Merge Another Branch
```bash
git merge feature/my-feature
# Merges feature branch into current branch
# Creates merge commit

git merge --no-ff feature/my-feature
# Merges with explicit merge commit (shows it was a merge)
```

### Rebase (Cleaner History)
```bash
git rebase main
# Replays your commits on top of main
# Results in linear history (no merge commits)
# WARNING: Don't rebase public/shared branches
```

### Resolve Merge Conflicts
```
# When merge fails, you'll see:
# CONFLICT (content): Merge conflict in file.rb

# Steps:
1. Open the conflicted file(s)
2. Find: <<<<<<< HEAD ... ======= ... >>>>>>> branch-name
3. Edit to keep what you want
4. Delete conflict markers
5. git add file.rb
6. git commit (or git merge --continue)
```

---

## Tagging (Releases)

### Create a Tag
```bash
git tag v1.0.0
# Creates tag for current commit (lightweight)

git tag -a v1.0.0 -m "Version 1.0.0 release"
# Creates annotated tag with message
```

### List Tags
```bash
git tag
# Shows all tags

git tag -l "v1.*"
# Shows tags matching pattern
```

### Push Tags
```bash
git push origin v1.0.0
# Pushes specific tag

git push origin --tags
# Pushes all tags
```

---

## Useful Workflows

### Update Feature Branch with Latest Main
```bash
git fetch origin          # Get latest remote changes
git rebase origin/main    # Rebase your commits on top
# or
git merge origin/main     # Merge if you prefer
```

### Clean Up Local Branches
```bash
git branch -d <branch>    # Delete local branch after merging
git push origin --delete <branch>  # Delete remote branch
```

### Squash Commits Before Pushing
```bash
git rebase -i HEAD~3      # Interactive rebase last 3 commits
# Then: squash (or s) commits you want to combine
# Clean history!
```

---

## .gitignore Templates

### Python Project (.gitignore)

```
# Python
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
*.egg-info/
.installed.cfg
*.egg

# Virtual environments
venv/
ENV/
env/
.venv

# IDE
.vscode/
.idea/
*.swp
*.swo
*~
.DS_Store

# Testing
.pytest_cache/
.coverage
htmlcov/

# Environment variables
.env
.env.local
```

### Ruby Project (.gitignore)

```
# Ruby
*.gem
*.rbc
/.config
/coverage/
/InstalledFiles
/pkg/
/spec/reports/
/spec/tmp/
/tmp/
/vendor/bundle/

# Gemfile
Gemfile.lock  # Only in projects, not gems

# IDE
.vscode/
.idea/
*.swp
*.swo
*~
.DS_Store

# Testing
.rspec_status
.rspec

# Bundler
.bundle/
vendor/bundle/

# Environment variables
.env
.env.local

# Ruby LSP
.ruby-lsp/

# System
.DS_Store
*.log
```

### Common (Both Languages)

```
# Version control
.git/
.gitignore

# Logs
*.log
logs/

# System
.DS_Store
Thumbs.db

# Editor temp files
*.swp
*.swo
*~
.#*
*#

# IDEs
.vscode/
.idea/
.sublime-project
.sublime-workspace

# Environment
.env
.env.local
.env.*.local

# OS
__MACOSX/
.AppleDouble
.LSOverride
```

---

## Git Cheat Sheet (Quick Reference)

| Task | Command |
|------|---------|
| Check status | `git status` |
| See history | `git log --oneline` |
| Create branch | `git checkout -b feature/name` |
| Switch branch | `git switch branch-name` |
| Stage changes | `git add file.rb` |
| Commit | `git commit -m "Message"` |
| Push | `git push origin branch-name` |
| Pull | `git pull` |
| Undo last commit | `git reset --soft HEAD~1` |
| Undo unpushed commits | `git reflog` then `git reset` |
| See what changed | `git diff` |
| Merge branch | `git merge branch-name` |
| Stash work | `git stash` |
| Restore stash | `git stash pop` |

---

## Remember

- **Always use `git status`** — Know your state before committing
- **Commit often** — Small commits are easier to understand and revert if needed
- **Write clear messages** — Future you (and teammates) will thank you
- **Never force push to shared branches** — `git push --force` can destroy team's work
- **When in doubt, stash** — `git stash` is safe, saves your work
- **Reflog is your safety net** — Most "lost" commits can be recovered with `git reflog`

---

**Last updated:** 2026-04-23
