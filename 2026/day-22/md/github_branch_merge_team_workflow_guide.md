
# Complete GitHub Branching and Merge Workflow Guide
## Real Team Workflow Using Git, GitHub, WSL, SSH, and Nginx

Author: Khalid Khan  
Repository: Git-GitHub-Practice

---

[feature branch merge to GitHun then merge un Main](screenshots/github_branch_merge_team_workflow_guide.png)


# Introduction

This guide documents a complete real-world GitHub workflow using:
- Git branches
- GitHub remote repository
- SSH authentication
- WSL/Linux
- Nginx web deployment
- Feature branch workflow
- Team-style merge process

---

# Project Repository

```text
git@github.com:krmaryum/Git-GitHub-Practice.git
```

---

# Goal

The objective was:

1. Create a separate development branch
2. Work safely without affecting main
3. Create and test an Nginx web page
4. Push branch to GitHub
5. Merge changes into main
6. Simulate professional team workflow

---

# Step 1 — Verify Current Branch

```bash
git branch
```

Output:

```text
* main
```

---

# Step 2 — Create Development Branch

```bash
git switch -c dev
```

Output:

```text
Switched to a new branch 'dev'
```

---

# Step 3 — Verify Branches

```bash
git branch
```

Output:

```text
* dev
  main
```

---

# Step 4 — Test Default Nginx Page

```bash
curl http://localhost:80
```
[Default Nginx .html](screenshots/default-nginx.png)

This displayed the default Debian Nginx page.

---

# Step 5 — Navigate to Nginx Web Directory

```bash
cd /var/www/html
```

List files:

```bash
ls
```

Output:

```text
index.nginx-debian.html
```

---

# Step 6 — Create Custom Web Page

Initially:

```bash
vim index.html
```
[index.html]

failed because:
- `/var/www/html`
- is owned by root

Correct command:

```bash
sudo vim index.html
```

The custom webpage was created successfully.

---

# Step 7 — Test Nginx Web Page

```bash
curl http://localhost:80
```

Result:
- custom webpage displayed correctly
- Nginx serving HTML successfully

---

# Step 8 — Copy Webpage into Git Repository

```bash
cd /mnt/c/Linux/Git-GitHub-Practice
```

Copy file:

```bash
cp /var/www/html/index.html .
```

List repository files:

```bash
ls
```

Output:

```text
README.md
git-branch.txt
index.html
install_nginx.sh
```

---

# Step 9 — Switch to dev Branch

```bash
git switch dev
```

---

# Step 10 — Stage Webpage

```bash
git add index.html
```

---

# Step 11 — Commit Changes

```bash
git commit -m "feat: Added Demo web page"
```

Output:

```text
[dev 0c07662] feat: Added Demo web page
```

---

# Step 12 — Initial Push Failed

Push attempt:

```bash
git push origin dev
```

Error:

```text
Permission denied (publickey)
```

Reason:
- WSL SSH key was not configured

---

# Step 13 — Create WSL SSH Key

```bash
ssh-keygen -t ed25519 -C "krmaryum-wsl"
```

Start SSH agent:

```bash
eval "$(ssh-agent -s)"
```

Add SSH key:

```bash
ssh-add ~/.ssh/id_ed25519
```

Display public key:

```bash
cat ~/.ssh/id_ed25519.pub
```

Add public key to GitHub SSH settings.

---

# Step 14 — Verify SSH Authentication

```bash
ssh -T git@github.com
```

Output:

```text
Hi krmaryum! You've successfully authenticated
```

---

# Step 15 — Push dev Branch Successfully

```bash
git push -u origin dev
```

Output:

```text
[new branch] dev -> dev
branch 'dev' set up to track 'origin/dev'
```

Meaning:
- remote branch created
- local dev tracks GitHub branch

---

# Team Workflow Concept

At this stage:

| Branch | Purpose |
|---|---|
| main | stable production code |
| dev | development branch |

This is how teams collaborate safely.

Developers:
- create branches
- work independently
- merge after testing

---

# Understanding origin/dev

Git log showed:

```text
(HEAD -> dev, origin/dev)
```

Meaning:

| Reference | Meaning |
|---|---|
| HEAD -> dev | local branch |
| origin/dev | remote GitHub branch |

---

# Why Teams Use Branches

Benefits:
- isolated development
- safer collaboration
- feature separation
- testing before production
- cleaner Git history

---

# Typical Professional Workflow

```text
main
  ↓
create feature branch
  ↓
develop feature
  ↓
commit changes
  ↓
push to GitHub
  ↓
Pull Request
  ↓
review
  ↓
merge into main
```

---

# Local Merge Workflow

Previously practiced merge:

```bash
git merge dev
```

Git performed:

```text
Fast-forward
```

Meaning:
- main had no new commits
- Git moved main pointer forward

---

# Fast-Forward Merge Visualization

Before merge:

```text
main → A
dev  → A → B → C
```

After merge:

```text
main → A → B → C
dev  → A → B → C
```

---

# Push Updated main Branch

```bash
git push
```

This updated GitHub main branch.

---

# Important Commands Learned

## Create branch

```bash
git switch -c dev
```

---

## Switch branch

```bash
git switch main
git switch dev
```

---

## Stage changes

```bash
git add index.html
```

---

## Commit changes

```bash
git commit -m "message"
```

---

## Push branch

```bash
git push -u origin dev
```

---

## Merge branch

```bash
git merge dev
```

---

## Verify SSH

```bash
ssh -T git@github.com
```

---

## Check status

```bash
git status
```

---

# Linux and WSL Skills Learned

You also practiced:
- Linux permissions
- sudo
- SSH keys
- SSH agent
- WSL Git
- Vim
- Nginx deployment
- curl testing

---

# Real Skills Practiced

This was not only local Git practice.

You practiced:
- GitHub remote branches
- SSH authentication
- remote tracking
- feature branch workflow
- merge workflow
- deployment workflow

---

# Final Result

Successfully completed:
- development branch workflow
- GitHub remote branch workflow
- SSH setup in WSL
- webpage deployment
- merge workflow
- GitHub synchronization

---

# Best Practice Recommendation

```bash
git pull

git switch -c feature-branch

# work on code

git add .

git commit -m "message"

git push -u origin feature-branch
```

Then:
- open Pull Request
- review code
- merge into main

---

# Repository

https://github.com/krmaryum/Git-GitHub-Practice

---

# Conclusion

This project demonstrated a real-world GitHub collaboration workflow using:
- Git
- GitHub
- WSL
- SSH
- Linux
- Nginx

The workflow closely matches professional team development practices.
