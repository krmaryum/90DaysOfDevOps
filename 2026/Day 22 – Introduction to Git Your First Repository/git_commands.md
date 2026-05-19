# Git Commands Reference

Author: Khalid Khan

---

[https://git-scm.com/cheat-sheet](https://git-scm.com/cheat-sheet)

[Git Cheat Sheet](md/Git%20&%20GitHub%20Cheatsheet.pdf)

# Setup & Config

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

## ssh -T git@github.com

### What it does
Tests secure SSH authentication between the local machine and GitHub.

### Example

```bash
ssh -T git@github.com
```

---

# Basic Workflow

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

---

# Viewing Changes

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

## git branch

### What it does
Lists repository branches.

### Example

```bash
git branch
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

## git switch

### What it does
Switches to another existing branch.

### Example

```bash
git switch main
```

---

## git switch -c

### What it does
Creates and switches to a new branch.

### Example

```bash
git switch -c dev
```

---

## git checkout -b

### What it does
Creates and switches to a new branch using older syntax.

### Example

```bash
git checkout -b feature-branch
```

---

# Undo Changes

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
Removes files from staging area.

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

# Remote Repositories

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
Connects local repository to GitHub.

### Example

```bash
git remote add origin git@github.com:username/repository.git
```

---

## git push

### What it does
Uploads commits to remote repository.

### Example

```bash
git push origin main
```

---

## git pull

### What it does
Downloads and merges remote changes.

### Example

```bash
git pull origin main
```

## git remote rename

### What it does
Renames an existing remote repository connection.

### Example

```bash
git remote rename origin github
```
