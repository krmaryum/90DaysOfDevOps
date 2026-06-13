
# Complete Git Branch Workflow Guide
## Creating a Development Branch, Working on It, and Merging into main

Author: Khalid Khan  
Repository: Git-GitHub-Practice

---

[Class-Board Notes](screenshots/git-merge.png)

# Introduction

This guide demonstrates a real professional Git workflow using an actual project.

Workflow covered:

- Create development branch (`dev`)
- Work safely on feature branch
- Commit changes
- Switch between branches
- Verify branch isolation
- Merge branch into `main`
- Push merged code to GitHub

---

# Initial Repository State

Check branch:

```bash
git branch
```

Output:

```text
* main
```

Check remote:

```bash
git remote -v
```

Output:

```text
origin  git@github.com:krmaryum/Git-GitHub-Practice.git (fetch)
origin  git@github.com:krmaryum/Git-GitHub-Practice.git (push)
```

---

# Existing Commit History

```bash
git log
```

Output:

```text
Initial commit
```

---

# Updating README on main Branch

```bash
echo "Now I created a 'dev' branch" >> README.md
```

Stage:

```bash
git add .
```

Commit:

```bash
git commit -m "Add One line in README"
```

Push:

```bash
git push
```

---

# Create a New Branch

```bash
git switch -c dev
```

Output:

```text
Switched to a new branch 'dev'
```

---

# Verify Current Branch

```bash
git branch
```

Output:

```text
* dev
  main
```

---

# Branch History

```bash
git log --oneline
```

Output:

```text
8807056 Add One line in README
81e502d Initial commit
```

---

# Create Script on dev Branch

```bash
vim install_nginx.sh
```

A new Nginx installation script was created.

---

# Add Script to Git

```bash
git add install_nginx.sh
```

Windows warning:

```text
LF will be replaced by CRLF
```

Normal behavior on Windows systems.

---

# First Commit on dev

```bash
git commit -m "feat: addded Nginx script"
```

---

# Modify Script Again

```bash
vim install_nginx.sh
```

Stage changes:

```bash
git add install_nginx.sh
```

Commit:

```bash
git commit -m "chore: minor changes to Nginx script"
```

---

# dev Branch History

```bash
git log
```

Output:

```text
7681874 chore: minor changes to Nginx script
1db6d29 feed addded Nginx script
8807056 Add One line in README
81e502d Initial commit
```

---

# Switch Back to main

```bash
git switch main
```

---

# Verify Branch Isolation

```bash
ls
```

Output on main:

```text
README.md
```

Notice:
- `install_nginx.sh` does NOT exist on `main`

This proves branch isolation works correctly.

---

# Switch Back to dev

```bash
git switch dev
```

Check files:

```bash
ls
```

Output:

```text
install_nginx.sh
README.md
```

Now the script exists again because `dev` contains additional commits.

---

# Merge dev into main

Switch to main:

```bash
git switch main
```

Merge:

```bash
git merge dev
```

Output:

```text
Fast-forward
```

---

# What is Fast-Forward Merge?

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

Git simply moved the `main` pointer forward.

---

# Verify Merged Files

```bash
ls
```

Output:

```text
install_nginx.sh
README.md
```

Now `main` contains the script.

---

# Push Merged Code to GitHub

```bash
git push
```

Output:

```text
main -> main
```

---

# Current Branch State

```bash
git branch
```

Output:

```text
  dev
* main
```

---

# Important Git Concepts Learned

## Branch Creation

```bash
git switch -c dev
```

Creates and switches branch.

---

## Branch Isolation

Changes inside `dev` do not affect `main` until merged.

---

## Switching Branches

```bash
git switch main
git switch dev
```

Git changes:
- files
- history context
- HEAD pointer

---

## Fast-Forward Merge

Git moved `main` forward without creating a merge commit.

---

# Complete Workflow Summary

```bash
git switch -c dev

vim install_nginx.sh

git add install_nginx.sh

git commit -m "feat: addded Nginx script"

git commit -m "chore: minor changes to Nginx script"

git switch main

git merge dev

git push
```

---

# Final Result

You successfully practiced:

- Git branching
- Isolated development
- Multiple commits
- Switching branches
- Merge workflow
- Fast-forward merge
- GitHub synchronization

---

# Professional Daily Workflow

```bash
git pull

git switch -c feature-branch

# work on code

git add .

git commit -m "message"

git switch main

git merge feature-branch

git push
```

---

# Repository

https://github.com/krmaryum/Git-GitHub-Practice

---

# Conclusion

This exercise demonstrated a real-world Git workflow used by developers and DevOps engineers.

You successfully:
- created a development branch
- worked safely in isolation
- committed multiple changes
- verified branch separation
- merged changes into main
- pushed final code to GitHub
