# Git Commands Reference (Table Format)

Author: Khalid Khan

---

# Setup & Config

| Command | What it does | Example |
|---|---|---|
| `git --version` | Checks installed Git version | `git --version` |
| `git config --global user.name` | Sets global Git username | `git config --global user.name "Your Name"` |
| `git config --global user.email` | Sets global Git email | `git config --global user.email "your@email.com"` |
| `git config --global --list` | Displays Git configuration | `git config --global --list` |

---

# SSH & Authentication

| Command | What it does | Example |
|---|---|---|
| `ssh -T git@github.com` | Tests SSH authentication with GitHub | `ssh -T git@github.com` |

---

# Basic Workflow

| Command | What it does | Example |
|---|---|---|
| `git init` | Initializes a repository | `git init` |
| `git status` | Shows repository status | `git status` |
| `git add` | Stages files | `git add .` |
| `git commit` | Saves staged changes | `git commit -m "Initial commit"` |
| `git log --oneline` | Shows compact commit history | `git log --oneline` |
| `git diff` | Shows unstaged changes | `git diff` |
| `git diff --staged` | Shows staged changes | `git diff --staged` |

---

# Branching & Navigation

| Command | What it does | Example |
|---|---|---|
| `git branch` | Lists branches | `git branch` |
| `git branch <branch-name>` | Creates a branch | `git branch feature-login` |
| `git branch -a` | Shows all branches | `git branch -a` |
| `git branch -M main` | Renames branch to main | `git branch -M main` |
| `git branch -d <branch-name>` | Deletes local branch | `git branch -d feature-login` |
| `git switch <branch-name>` | Switches branches | `git switch dev` |
| `git switch -c <branch-name>` | Creates and switches branch | `git switch -c feature-api` |
| `git checkout <branch-name>` | Switches branch (old syntax) | `git checkout main` |
| `git checkout -b <branch-name>` | Creates + switches branch | `git checkout -b feature-dashboard` |
| `git checkout <commit-hash>` | Detached HEAD checkout | `git checkout 6abb00a` |

---

# Undo Changes

| Command | What it does | Example |
|---|---|---|
| `git restore` | Restores file changes | `git restore filename.txt` |
| `git restore --staged` | Removes staged files | `git restore --staged git-commands.md` |
| `git reset` | Unstages files or resets state | `git reset git-commands.md` |
| `git reset --soft HEAD~1` | Removes commit but keeps staged changes | `git reset --soft HEAD~1` |
| `git reset --mixed HEAD~1` | Removes commit and unstages changes | `git reset --mixed HEAD~1` |
| `git reset --hard HEAD~1` | Removes commit and deletes changes | `git reset --hard HEAD~1` |
| `git revert <commit-hash>` | Reverts commit safely | `git revert 706f056` |
| `git revert --continue` | Continues revert after conflict | `git revert --continue` |
| `git revert --abort` | Cancels revert operation | `git revert --abort` |
| `git reflog` | Shows HEAD history | `git reflog` |

---

# Remote Repositories

| Command | What it does | Example |
|---|---|---|
| `git remote -v` | Shows remotes | `git remote -v` |
| `git remote add origin` | Adds GitHub remote | `git remote add origin <repo-url>` |
| `git remote add upstream` | Adds upstream remote | `git remote add upstream <repo-url>` |
| `git push` | Pushes commits | `git push origin main` |
| `git push -u origin main` | Pushes and sets upstream | `git push -u origin main` |
| `git push --force` | Force pushes changes | `git push --force` |
| `git pull` | Pulls remote changes | `git pull origin main` |
| `git clone` | Clones repository | `git clone <repo-url>` |
| `git fetch origin` | Downloads remote changes only | `git fetch origin` |
| `git remote remove origin` | Removes remote | `git remote remove origin` |
| `git remote rename` | Renames remote | `git remote rename origin github` |
| `git mv` | Renames/moves tracked files | `git mv old new` |

---

# Advanced Git Workflows

| Command | What it does | Example |
|---|---|---|
| `git log --oneline --graph --all` | Graph view of history | `git log --oneline --graph --all` |
| `git merge --abort` | Cancels merge | `git merge --abort` |
| `git merge --squash` | Squashes commits into one | `git merge --squash feature-profile` |
| `git rebase` | Replays commits on top | `git rebase main` |
| `git rebase --abort` | Cancels rebase | `git rebase --abort` |
| `git rebase --continue` | Continues rebase | `git rebase --continue` |
| `git stash` | Temporarily saves changes | `git stash` |
| `git stash push -m` | Creates named stash | `git stash push -m "work"` |
| `git stash push -u -m` | Includes untracked files | `git stash push -u -m "work"` |
| `git stash list` | Lists stashes | `git stash list` |
| `git stash pop` | Applies and removes stash | `git stash pop` |
| `git stash apply` | Applies stash only | `git stash apply stash@{1}` |
| `git cherry-pick <commit-hash>` | Applies specific commit | `git cherry-pick 7109f3b` |
| `git cherry-pick --continue` | Continues cherry-pick | `git cherry-pick --continue` |
| `git cherry-pick --abort` | Cancels cherry-pick | `git cherry-pick --abort` |
| `git cherry-pick --skip` | Skips current commit | `git cherry-pick --skip` |
| `git switch --detach <commit-hash>` | Detached HEAD mode | `git switch --detach 6abb00a` |

---

# Reset vs Revert Comparison

| Feature | `git reset` | `git revert` |
|---|---|---|
| Removes history | Yes | No |
| Rewrites history | Yes | No |
| Safe for shared branches | Usually No | Yes |
| Creates new commit | No | Yes |
| Best use case | Local cleanup | Undoing pushed commits |

---

# Branching Strategies Summary

| Strategy | Description | Best Used For |
|---|---|---|
| GitFlow | Multiple long-lived branches | Large teams |
| GitHub Flow | Single main branch workflow | Startups |
| Trunk-Based Development | Frequent commits to main | CI/CD teams |

