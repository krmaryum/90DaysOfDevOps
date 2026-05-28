# Git Commands Reference

Author: Khalid Khan

---

https://git-scm.com/cheat-sheet

[Git Cheat Sheet](md/Git%20&%20GitHub%20Cheatsheet.pdf)

---

# Table of Contents

| Category | Summary | Quick Link |
|---|---|---|
| Setup & Config | Install Git and configure username/email settings | [Go to Setup & Config](#setup--config) |
| SSH & Authentication | Configure and test SSH authentication with GitHub | [Go to SSH & Authentication](#ssh--authentication) |
| Basic Workflow | Initialize repositories, stage changes, commit, and view history | [Go to Basic Workflow](#basic-workflow) |
| Viewing Changes | Inspect unstaged/staged changes and hidden repository files | [Go to Viewing Changes](#viewing-changes) |
| Branching & Navigation | Create, rename, and switch branches | [Go to Branching & Navigation](#branching--navigation) |
| Undo Changes | Restore files, unstage changes, and reset repository state | [Go to Undo Changes](#undo-changes) |
| Remote Repositories | Connect local repositories to GitHub and synchronize changes | [Go to Remote Repositories](#remote-repositories) |
| Advanced Git Workflows | Merge, rebase, stash, squash merge, cherry-pick, and history navigation | [Go to Advanced Git Workflows](#advanced-git-workflows) |

---

# Setup & Config

This section explains how to install and configure Git.

---

## git --version

### What it does
Checks whether Git is installed and shows the installed version.

### Example

```bash
git --version
```

---

## git config --global user.name

### What it does
Sets the global Git username used in commits.

### Example

```bash
git config --global user.name "Your Full Name"
```

---

## git config --global user.email

### What it does
Sets the global Git email used in commits.

### Example

```bash
git config --global user.email "your@email.com"
```

---

## git config --global --list

### What it does
Displays current global Git configuration settings.

### Example

```bash
git config --global --list
```

---

# SSH & Authentication

This section explains secure SSH authentication between the local machine and GitHub.

---

## ssh -T git@github.com

### What it does
Tests secure SSH authentication between the local machine and GitHub.

### Example

```bash
ssh -T git@github.com
```

---

# Basic Workflow

This section contains the core Git workflow commands used daily in development.

---

## git init

### What it does
Creates a new Git repository in the current directory.

### Example

```bash
git init
```

---

## git status

### What it does
Shows the current state of the repository.

### Example

```bash
git status
```

---

## git add

### What it does
Stages files for the next commit.

### Example

```bash
git add README.md
```

OR for all files:

```bash
git add .
```

---

## git commit

### What it does
Saves staged changes into Git history.

### Example

```bash
git commit -m "Initial commit"
```

---

## git log --oneline

### What it does
Displays compact commit history.

### Example

```bash
git log --oneline
```

Displays full commit history:

```bash
git log
```

---

# Viewing Changes

This section helps inspect repository changes and internal Git structure.

---

## git diff

### What it does
Shows unstaged changes.

### Example

```bash
git diff
```

---

## git diff --staged

### What it does
Shows staged changes.

### Example

```bash
git diff --staged
```

---

## ls -al

### What it does
Displays all files including hidden files.

### Example

```bash
ls -al
```

---

## tree .git/

### What it does
Displays the internal structure of the .git directory.

### Example

```bash
tree .git/
```

---

# Branching & Navigation

This section explains how to create, rename, switch, and delete branches.

---

## git branch

### What it does
Lists repository branches.

### Example

```bash
git branch
```

Note:
`*` means the current branch.

---

## git branch <branch-name>

### What it does
Creates a new branch.

### Example

```bash
git branch feature-login
```

---

## git branch -a

### What it does
Displays all local and remote branches.

### Example

```bash
git branch -a
```

---

## git branch -M main

### What it does
Renames the current branch to main.

### Example

```bash
git branch -M main
```

---

## git branch -d <branch-name>

### What it does
Deletes a local branch.

### Example

```bash
git branch -d feature-login
```

> ⚠ Important:
> Git does not allow deleting the currently active branch.
> Switch to another branch before deletion.

---

## git switch <branch-name>

### What it does
Switches to an existing branch.

### Example

```bash
git switch dev
```

---

## git switch -c <branch-name>

### What it does
Creates and switches to a new branch.

### Example

```bash
git switch -c feature-api
```

---

## git checkout <branch-name>

### What it does
Switches to an existing branch using older syntax.

### Example

```bash
git checkout main
```

---

## git checkout -b <branch-name>

### What it does
Creates and switches to a new branch using older syntax.

### Example

```bash
git checkout -b feature-dashboard
```

---

## git checkout <commit-hash>

### What it does
Switches to a specific commit in detached HEAD state.

### Example

```bash
git checkout 6abb00a
```

---


# Undo Changes

This section explains how to restore files and undo staged changes.

---

## git restore

### What it does
Restores tracked file changes.

### Example

```bash
git restore filename.txt
```

---

## git restore --staged

### What it does
Removes files from the staging area.

### Example

```bash
git restore --staged git-commands.md
```

---

## git reset

### What it does
Unstages files or resets repository state.

### Example

```bash
git reset git-commands.md
```

---

## git reset --hard <commit-hash>

### What it does
Resets the repository to a specific commit and permanently removes later changes.

### Example

```bash
git reset --hard 6abb00a
```

> ⚠ Warning:
> This command permanently removes uncommitted changes.

---

# Remote Repositories

This section explains how to connect repositories to GitHub and synchronize code.

---

## git remote -v

### What it does
Shows remote repositories.

### Example

```bash
git remote -v
```

---

## git remote add origin

### What it does
Connects a local repository to GitHub.

### Example

```bash
git remote add origin git@github.com:username/repository.git
```

---

---

## git remote add upstream

### What it does
Adds the original repository as an upstream remote.

### Example

```bash
git remote add upstream https://github.com/octocat/Hello-World.git
```

---

## git push

### What it does
Uploads commits to a remote repository.

### Example

```bash
git push origin main
```

---

---

## git merge

### What it does
Merges changes from another branch into the current branch.

### Example

```bash
git merge origin/main
```

OR

```bash
git merge upstream/master
```

---

## git push -u origin main

### What it does
Pushes the local `main` branch to GitHub and sets upstream tracking.

### Example

```bash
git push -u origin main
```

---

## git push -u origin <branch-name>

### What it does
Pushes a local branch to GitHub and creates upstream tracking.

### Example

```bash
git push -u origin feature-1
```

---

## git push --force

### What it does
Forcefully pushes local changes to the remote repository, overwriting remote history.

### Example

```bash
git push --force
```

> ⚠ Warning:
> This command overwrites remote history and should be used carefully.

---

## git pull

### What it does
Downloads and merges remote changes.

### Example

```bash
git pull origin main
```

---

## git clone

### What it does
Downloads a complete copy of a remote repository to the local machine.

### Example

```bash
git clone git@github.com:krmaryum/devops-git-practice.git
```

---

## git fetch origin

### What it does
Downloads remote changes without merging them into the current branch.

### Example

```bash
git fetch origin
```

---

## git remote remove origin

### What it does
Removes the remote repository connection named `origin`.

### Example

```bash
git remote remove origin
```

---

## git remote rename

### What it does
Renames an existing remote repository connection.

### Example

```bash
git remote rename origin github
```

---

## git mv

### What it does
Renames or moves a file or directory and tracks the change in Git.

### Example

```bash
git mv day-23 "Day 23-Git Branching & Working with GitHub"
```

---


# Advanced Git Workflows

This section contains advanced Git commands practiced on Day 24.

---

## git log --oneline --graph --all

### What it does
Displays compact commit history with branch and merge visualization.

### Example

```bash
git log --oneline --graph --all
```

---

## git merge --abort

### What it does
Cancels an in-progress merge and returns the repository to the state before the merge started.

### Example

```bash
git merge --abort
```

---

## git merge --squash <branch-name>

### What it does
Combines all commits from another branch into one staged change without creating a merge commit automatically.

### Example

```bash
git merge --squash feature-profile
git commit -m "feat: add profile feature"
```

---

## git rebase <branch-name>

### What it does
Replays commits from the current branch on top of another branch.

### Example

```bash
git rebase main
```

---

## git rebase --abort

### What it does
Cancels an in-progress rebase and returns the repository to the state before the rebase started.

### Example

```bash
git rebase --abort
```

---

## git rebase --continue

### What it does
Continues a rebase after resolving conflicts.

### Example

```bash
git add README.md
git rebase --continue
```

---

## git stash

### What it does
Temporarily saves uncommitted changes so you can switch branches or work on something else.

### Example

```bash
git stash
```

---

## git stash push -m

### What it does
Creates a stash with a descriptive message.

### Example

```bash
git stash push -m "dashboard work in progress"
```

---

## git stash push -u -m

### What it does
Creates a stash with a message and includes untracked files.

### Example

```bash
git stash push -u -m "dashboard work in progress"
```

---

## git stash list

### What it does
Displays all saved stashes.

### Example

```bash
git stash list
```

---

## git stash pop

### What it does
Applies the latest stash and removes it from the stash list.

### Example

```bash
git stash pop
```

---

## git stash apply

### What it does
Applies a stash but keeps it saved in the stash list.

### Example

```bash
git stash apply stash@{1}
```

---

## git cherry-pick <commit-hash>

### What it does
Applies one specific commit from another branch onto the current branch.

### Example

```bash
git cherry-pick 7109f3b
```

---

## git cherry-pick --continue

### What it does
Continues a cherry-pick after resolving conflicts.

### Example

```bash
git add hotfix.txt
git cherry-pick --continue
```

---

## git cherry-pick --abort

### What it does
Cancels an in-progress cherry-pick and returns the repository to the state before cherry-pick started.

### Example

```bash
git cherry-pick --abort
```

---

## git cherry-pick --skip

### What it does
Skips the current commit during a cherry-pick sequence.

### Example

```bash
git cherry-pick --skip
```

---

## git switch --detach <commit-hash>

### What it does
Switches to a specific commit in detached HEAD state using modern Git syntax.

### Example

```bash
git switch --detach 6abb00a
```

---

# Git Concepts Summary

| Concept | Meaning |
|---|---|
| HEAD | Pointer to current branch or commit |
| origin | Default remote repository |
| upstream | Original repository in fork workflows |
| fetch | Download remote changes only |
| pull | Download + merge remote changes |
| clone | Local repository copy |
| fork | GitHub account repository copy |
| branch | Isolated development line |
| merge conflict | Situation where Git cannot automatically combine changes |
| fast-forward merge | Merge where Git moves the branch pointer forward without a merge commit |
| merge commit | Commit created to join two diverged histories |
| rebase | Replays commits on top of another branch |
| squash merge | Combines multiple commits into one commit |
| stash | Temporary storage for uncommitted work |
| cherry-pick | Applies a specific commit onto another branch |
| detached HEAD | State where HEAD points directly to a commit instead of a branch |


---

# Day 25 Commands – Reset, Revert & Recovery

This section contains Git reset, revert, and recovery commands practiced on Day 25.

---

## git reset --soft HEAD~1

### What it does
Removes the latest commit but keeps changes staged.

### Example

```bash
git reset --soft HEAD~1
```

---

## git reset --mixed HEAD~1

### What it does
Removes the latest commit and unstages changes, but keeps file changes in the working directory.

### Example

```bash
git reset --mixed HEAD~1
```

---

## git reset --hard HEAD~1

### What it does
Removes the latest commit and permanently deletes related changes from the working directory.

### Example

```bash
git reset --hard HEAD~1
```

> ⚠ Warning:
> This command is destructive and may permanently remove changes.

---

## git revert <commit-hash>

### What it does
Creates a new commit that reverses changes from an earlier commit without deleting history.

### Example

```bash
git revert 706f056
```

---

## git revert --continue

### What it does
Continues the revert process after resolving merge conflicts.

### Example

```bash
git add revert-practice.txt
git revert --continue
```

---

## git revert --abort

### What it does
Cancels an in-progress revert operation and restores the repository to its previous state.

### Example

```bash
git revert --abort
```

---

## git reflog

### What it does
Displays a history of where HEAD has pointed. Useful for recovering commits after reset mistakes.

### Example

```bash
git reflog
```

---

# Branching Strategies Summary

| Strategy | Description | Best Used For |
|---|---|---|
| GitFlow | Uses main, develop, feature, release, and hotfix branches | Large teams with scheduled releases |
| GitHub Flow | Uses a single main branch with short-lived feature branches | Startups and fast deployments |
| Trunk-Based Development | Developers frequently merge small changes into main/trunk | CI/CD and rapid integration workflows |

---

# Reset vs Revert Comparison

| Feature | git reset | git revert |
|---|---|---|
| Removes commit from history? | Yes | No |
| Rewrites history? | Yes | No |
| Safe for shared branches? | Usually No | Yes |
| Creates a new commit? | No | Yes |
| Best use case | Local cleanup before push | Undoing pushed commits safely |

