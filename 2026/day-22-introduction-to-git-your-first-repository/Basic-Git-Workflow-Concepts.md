# Basic Git Workflow Concepts

## Table of Contents

* [git status](#git-status)
* [git add](#git-add)
* [git commit](#git-commit)
* [git push](#git-push)
* [Git Workflow Summary](#git-workflow-summary)

---

# git status

## Purpose

Shows the current state of the working directory and staging area.

## What It Tells Us

* Modified files
* Staged files
* Untracked files
* Current branch information
* Whether the branch is ahead or behind the remote repository

## Example

```bash
git status
```

---

# git add

## Purpose

Stages a file for the next commit.

It tells Git:

> Include this file in the next commit.

## Example

Stage a single file:

```bash
git add README.md
```

Stage all files:

```bash
git add .
```

---

# git commit

## Purpose

Creates a snapshot of the staged changes and stores it in Git history.

A commit represents a saved point in the project's history.

## Example

```bash
git commit -m "Add Docker notes"
```

## Result

* Creates a new Git history entry
* Saves staged changes locally
* Prepares the changes to be pushed to a remote repository

---

# git push

## Purpose

Uploads local commits to a remote repository such as GitHub.

## Example

```bash
git push origin main
```

## Result

* Sends local commits to GitHub
* Makes changes available to other team members
* Stores commits safely on the remote repository

---

# Git Workflow Summary

```text
Working Directory
        │
        ▼
     git add
        │
        ▼
   Staging Area
        │
        ▼
 git commit -m
        │
        ▼
   Local Git History
        │
        ▼
     git push
        │
        ▼
 Remote Repository (GitHub)
```

---

# Quick Reference

| Command                   | Purpose                             |
| ------------------------- | ----------------------------------- |
| `git status`              | Show repository status              |
| `git add <file>`          | Stage a file for commit             |
| `git add .`               | Stage all changes                   |
| `git commit -m "message"` | Create a Git history snapshot       |
| `git push`                | Upload commits to remote repository |

---

# Key Takeaway

Git follows a simple workflow:

1. Modify files in the Working Directory
2. Stage changes using `git add`
3. Save changes to Git history using `git commit`
4. Upload commits to GitHub using `git push`

```
```
