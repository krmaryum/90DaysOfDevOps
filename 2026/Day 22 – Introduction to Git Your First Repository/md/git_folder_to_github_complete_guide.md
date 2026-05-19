
# From Local Folder to GitHub Repository (A to Z Guide)

## Scenario

You created only a local folder:

```text
C:\Linux\Git-GitHub-Practice
```

Now you want to upload it to GitHub and turn it into a real GitHub repository.

This guide explains the entire process step by step.

---

# Step 1 — Open PowerShell

Open:
- Windows PowerShell
- or VS Code Terminal

---

# Step 2 — Move Into the Folder

```powershell
cd C:\Linux\Git-GitHub-Practice
```

Check location:

```powershell
pwd
```

---

# Step 3 — Initialize Git

```powershell
git init
```

This creates the hidden `.git` folder and converts the folder into a Git repository.

---

# Step 4 — Create README File

```powershell
echo "# Git-GitHub-Practice" > README.md
```

Check files:

```powershell
ls
```

---

# Step 5 — Add Files to Git

```powershell
git add .
```

Stages files for commit.

---

# Step 6 — Create First Commit

```powershell
git commit -m "Initial commit"
```

Creates the first snapshot/history.

---

# Step 7 — Create GitHub Repository

Go to:

https://github.com/new

Repository name:

```text
Git-GitHub-Practice
```

IMPORTANT:
- Do NOT initialize with README
- Do NOT add .gitignore
- Do NOT add license

Because your local repository already contains commits.

---

# Step 8 — Connect GitHub Remote

```powershell
git remote add origin git@github.com:krmaryum/Git-GitHub-Practice.git
```

---

# Step 9 — Verify Remote

```powershell
git remote -v
```

Expected:

```text
origin  git@github.com:krmaryum/Git-GitHub-Practice.git (fetch)
origin  git@github.com:krmaryum/Git-GitHub-Practice.git (push)
```

---

# Step 10 — Push First Time

```powershell
git push -u origin master
```

---

# Step 11 — Rename master to main

Check current branch:

```powershell
git branch
```

Rename:

```powershell
git branch -M main
```

Push new branch:

```powershell
git push -u origin main
```

---

# Step 12 — Change Default Branch on GitHub

Go to:

Settings → Branches

Change:
- master → main

Save changes.

---

# Step 13 — Delete Old master Branch

```powershell
git push origin --delete master
```

---

# Step 14 — Verify Final Setup

```powershell
git branch
```

Expected:

```text
* main
```

Check remote:

```powershell
git remote -v
```

---

# Daily Workflow

```powershell
git pull
git add .
git commit -m "your message"
git push
```

---

# Important Commands Explained

## git init

Creates Git repository.

---

## git add .

Stages files.

---

## git commit

Creates snapshot/history.

---

## git push

Uploads code to GitHub.

---

## git branch -M main

Renames branch.

---

# Common Errors

## src refspec main does not match any

Reason:
- main branch does not exist yet.

Fix:

```powershell
git branch -M main
```

---

## refusing to delete the current branch

Reason:
- GitHub still uses master as default branch.

Fix:
- Change default branch to main first.

---

# HTTPS vs SSH

## HTTPS

```text
https://github.com/USERNAME/REPO.git
```

Requires tokens/passwords.

---

## SSH

```text
git@github.com:USERNAME/REPO.git
```

Recommended professional workflow.

---

# SSH Setup

## Generate SSH Key

```powershell
ssh-keygen -t ed25519 -C "your-email@example.com"
```

---

## Add SSH Key

```powershell
ssh-add $HOME\.ssh\id_ed25519
```

---

## Test SSH

```powershell
ssh -T git@github.com
```

Expected:

```text
You've successfully authenticated
```

---

# Final Result

You now have:
- Local Git repository
- GitHub repository
- SSH authentication
- Modern main branch
- Remote tracking
- Professional Git workflow

---

# Complete Workflow

```powershell
cd C:\Linux\Git-GitHub-Practice

git init

echo "# Git-GitHub-Practice" > README.md

git add .

git commit -m "Initial commit"

git remote add origin git@github.com:krmaryum/Git-GitHub-Practice.git

git push -u origin master

git branch -M main

git push -u origin main

git push origin --delete master
```

---

# Repository

https://github.com/krmaryum/Git-GitHub-Practice

---

# Congratulations 

You successfully:
- created local folder
- initialized Git
- connected GitHub
- configured SSH
- migrated to main branch
- pushed repository online
