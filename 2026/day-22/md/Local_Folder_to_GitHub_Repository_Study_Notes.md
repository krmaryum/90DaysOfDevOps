# From Local Folder to GitHub Repository

## Complete Git Study Notes

## Goal

These notes explain how to take a project folder that already exists on your laptop and push it to a GitHub repository for the first time.

---

## Important Concept

| Situation | Command to Start |
|----------|------------------|
| Project already exists on GitHub and you want it on your laptop | `git clone` |
| Project already exists on your laptop and you want it on GitHub | `git init` + `git remote add origin` |

For this note:

```text
Local folder already exists
        ↓
Create GitHub repo
        ↓
Connect local folder to GitHub
        ↓
Push
```

---

# Step 1: Create a New Repository on GitHub

1. Go to GitHub.
2. Click the plus sign `+`.
3. Click **New repository**.
4. Enter repository name.

Example:

```text
linux-administration
```

5. Choose **Public** or **Private**.

## Important

If your local folder already has files, do not select:

```text
Add a README file
Add .gitignore
Choose a license
```

Keep the GitHub repository empty.

---

# Step 2: Open Terminal in Your Local Folder

Using Git Bash:

```bash
cd /c/Linux/linux-administration
```

Check location:

```bash
pwd
```

---

# Step 3: Check if Git is Already Initialized

```bash
git status
```

If you see:

```text
fatal: not a git repository
```

run:

```bash
git init
```

---

# Step 4: Rename Branch to Main

```bash
git branch -M main
```

Check branch:

```bash
git branch
```

Expected:

```text
* main
```

---

# Step 5: Stage Files

```bash
git add .
```

Check:

```bash
git status
```

Expected:

```text
Changes to be committed
```

---

# Step 6: Create First Commit

```bash
git commit -m "Initial commit"
```

Check:

```bash
git log --oneline
```

---

# Step 7: Add GitHub Remote

SSH example:

```bash
git remote add origin git@github.com:krmaryum/linux-administration.git
```

HTTPS example:

```bash
git remote add origin https://github.com/krmaryum/linux-administration.git
```

---

# Step 8: Verify Remote

```bash
git remote -v
```

Expected:

```text
origin  git@github.com:krmaryum/linux-administration.git (fetch)
origin  git@github.com:krmaryum/linux-administration.git (push)
```

---

# Step 9: Push to GitHub

```bash
git push -u origin main
```

After this, future pushes can use:

```bash
git push
```

---

# Complete Command Flow

```bash
cd /c/Linux/linux-administration
git init
git branch -M main
git add .
git commit -m "Initial commit"
git remote add origin git@github.com:krmaryum/linux-administration.git
git remote -v
git push -u origin main
```

---

# After First Push

```bash
git status
```

Expected:

```text
On branch main
Your branch is up to date with 'origin/main'.

nothing to commit, working tree clean
```

---

# Common Errors and Fixes

## fatal: not a git repository

Meaning:

```text
This folder does not have Git initialized.
```

Fix:

```bash
git init
```

---

## origin does not appear to be a git repository

Meaning:

```text
Remote origin is missing or incorrect.
```

Fix:

```bash
git remote add origin git@github.com:krmaryum/linux-administration.git
git push -u origin main
```

---

## remote origin already exists

Check:

```bash
git remote -v
```

Fix:

```bash
git remote set-url origin git@github.com:krmaryum/linux-administration.git
```

---

## src refspec main does not match any

Meaning:

```text
No commit exists yet.
```

Fix:

```bash
git add .
git commit -m "Initial commit"
git push -u origin main
```

---

## fetch first

Meaning:

```text
GitHub has changes that your local repo does not have.
```

Fix:

```bash
git pull --rebase origin main
git push
```

---

# Git Workflow Diagram

```text
Local Folder
     |
     v
git init
     |
     v
git add .
     |
     v
git commit -m "Initial commit"
     |
     v
git remote add origin <GitHub URL>
     |
     v
git push -u origin main
     |
     v
GitHub Repository
```

---

# Daily Workflow After Setup

```bash
git status
git add .
git commit -m "Meaningful commit message"
git push
```

---

# Useful Verification Commands

```bash
pwd
ls
git status
git remote -v
git branch
git log --oneline -5
```

---

# Best Practices

## Repository Names

Use lowercase with hyphens:

```text
linux-administration
shell-scripts
github-actions-practice
devops-cleanup-toolkit
```

## Folder Names

Use lowercase with hyphens:

```text
01-linux-fundamentals
02-users-and-groups
03-permissions-and-acl
04-selinux
```

## Large Files

Avoid pushing large videos directly to GitHub.

Add this to `.gitignore` before adding videos:

```text
*.mp4
```

---

# Clone vs Init

## Use git clone when:

```text
Repository already exists on GitHub
You want to download it to your laptop
```

```bash
git clone git@github.com:krmaryum/linux-administration.git
```

## Use git init when:

```text
Folder already exists on your laptop
You want to upload it to GitHub
```

```bash
git init
git add .
git commit -m "Initial commit"
git remote add origin <repo-url>
git push -u origin main
```

---

# Quick Memory Trick

```text
Local to GitHub:
git init → git add → git commit → git remote add → git push

GitHub to Local:
git clone
```

---

# Roman Urdu Summary

Agar folder pehle se laptop par hai aur GitHub par bhejna hai, to `git clone` use nahi karte.

Is case mein workflow hota hai:

```text
Local folder
git init
git add .
git commit
git remote add origin
git push
```

Agar GitHub repo pehle se hai aur laptop par lana hai, to:

```text
git clone
```

Yaad rakhne wali baat:

```text
Laptop se GitHub = git init
GitHub se laptop = git clone
```

Final command:

```bash
cd /c/Linux/linux-administration
git init
git branch -M main
git add .
git commit -m "Initial commit"
git remote add origin git@github.com:krmaryum/linux-administration.git
git push -u origin main
```
