# Git Folder Rename Guide

## Overview

This guide explains the proper and professional way to rename folders in Git repositories using PowerShell, Linux, WSL, and Git commands.

---

# Recommended Method

Use `git mv` for clean Git tracking.

---

# Windows PowerShell Method

## Rename Folder

```powershell
Rename-Item "old-folder-name" "new-folder-name"
```

## Example

```powershell
Rename-Item "day-01" "Day 01 – Introduction to DevOps and Cloud"
```

---

# Verify Changes

```powershell
git status
```

Expected:

```text
renamed: old-folder -> new-folder
```

---

# Commit Changes

```powershell
git add .
git commit -m "rename folder"
git push
```

---

# Professional Git Method

## Rename Folder Using Git

```powershell
git mv "old-folder-name" "new-folder-name"
```

## Example

```powershell
git mv "day-01" "Day 01 – Introduction to DevOps and Cloud"
```

---

# Linux / WSL Method

```bash
mv old-folder-name new-folder-name
```

Recommended:

```bash
git mv old-folder-name new-folder-name
```

---

# Full Workflow

```powershell
git mv "day-01" "Day 01 – Introduction to DevOps and Cloud"

git status

git commit -m "rename day-01 folder"

git push
```

---

# Why Use git mv?

| Benefit | Description |
|---|---|
| Clean history | Git tracks rename properly |
| Avoid duplicates | Prevents duplicate folders |
| Better commits | Cleaner repository history |
| Professional workflow | Industry standard practice |

---

# Common Problems

## Duplicate folders

Cause:
- Manual rename outside Git

Solution:
- Use `git mv`

---

## Deleted + New Folder Appears

Cause:
- Git sees delete and create separately

Solution:
- Use `git mv`

---

# Verify Repository

```powershell
git status
```

Expected:

```text
nothing to commit, working tree clean
```

---

# Best Practices

- Use `git mv`
- Verify with `git status`
- Push changes immediately
- Use readable folder names

---

# Recommended Naming

Good:

```text
Day 01 – Introduction to DevOps and Cloud
```

Avoid:

```text
day01
d1
testfolder
```

---

# Conclusion

Using `git mv` is the safest and most professional method for renaming folders in Git repositories.

---

# Author

Khalid Khan

GitHub:
https://github.com/krmaryum
