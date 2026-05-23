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