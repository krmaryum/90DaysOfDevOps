# Working Directory and Staging Area in Git

## Table of Contents

1. Introduction
2. What is the Working Directory?
3. What is the Staging Area?
4. What is a Commit?
5. How Git Tracks Changes
6. Real-Life Example
7. Step-by-Step Workflow
8. Visual Diagram
9. Common Git Commands
10. Working Directory vs Staging Area
11. Key Takeaways

---

# Introduction

Git uses three main areas to manage changes:

```text
Working Directory
       ↓
Staging Area
       ↓
Git Repository (Commit History)
```

Understanding these areas is essential for learning Git and GitHub.

---

# What is the Working Directory?

The Working Directory is the place where you create, edit, rename, and delete files.

Example:

```text
project/
├── README.md
├── notes.md
└── app.py
```

Any changes you make to files happen in the Working Directory first.

## Examples

Create a file:

```bash
touch notes.md
```

Edit a file:

```bash
vim notes.md
```

Check status:

```bash
git status
```

Output:

```text
Changes not staged for commit:
    modified: notes.md
```

This means the file exists only in the Working Directory and has not been staged yet.

---

# What is the Staging Area?

The Staging Area is a temporary holding area where you choose which changes should be included in the next commit.

Git calls this process "staging".

Stage a file:

```bash
git add notes.md
```

Check status:

```bash
git status
```

Output:

```text
Changes to be committed:
    modified: notes.md
```

Now Git knows that this file should be included in the next commit.

---

# What is a Commit?

A commit is a permanent snapshot of the staged changes.

Create a commit:

```bash
git commit -m "Add notes file"
```

The commit is stored in Git history and can be viewed later.

---

# How Git Tracks Changes

## Step 1: Modify File

```text
Working Directory
```

## Step 2: Stage File

```bash
git add filename
```

```text
Staging Area
```

## Step 3: Commit Changes

```bash
git commit -m "message"
```

```text
Git Repository
```

---

# Real-Life Example

Imagine writing a book.

## Working Directory

You are writing and editing pages.

```text
Draft on your desk
```

## Staging Area

You select pages that are ready.

```text
Pages placed in a submission folder
```

## Commit

You submit those pages permanently.

```text
Official version saved
```

---

# Step-by-Step Workflow

### Create a file

```bash
echo "Hello Git" > notes.md
```

### Check status

```bash
git status
```

Output:

```text
Untracked files:
    notes.md
```

### Stage file

```bash
git add notes.md
```

### Commit file

```bash
git commit -m "Add notes file"
```

---

# Visual Diagram

```text
┌─────────────────────┐
│  Working Directory  │
│                     │
│ Create Files        │
│ Edit Files          │
│ Delete Files        │
└──────────┬──────────┘
           │
           │ git add
           ▼
┌─────────────────────┐
│    Staging Area     │
│                     │
│ Ready to Commit     │
└──────────┬──────────┘
           │
           │ git commit
           ▼
┌─────────────────────┐
│   Git Repository    │
│                     │
│ Commit History      │
└─────────────────────┘
```

---

# Common Git Commands

| Command | Purpose |
|----------|----------|
| git status | Show repository status |
| git add file | Stage a specific file |
| git add . | Stage all changes |
| git restore --staged file | Remove file from staging area |
| git commit -m "message" | Create a commit |
| git log | View commit history |

---

# Working Directory vs Staging Area

| Working Directory | Staging Area |
|------------------|-------------|
| Where files are edited | Where files are prepared for commit |
| Changes are not yet selected | Changes are selected |
| Can contain many edits | Contains only chosen changes |
| First step in workflow | Second step in workflow |

---

# Key Takeaways

## Working Directory

The place where you create and modify files.

## Staging Area

A temporary area where you select changes for the next commit.

## Commit

A permanent snapshot stored in Git history.

## Git Workflow

```text
Working Directory
       ↓
git add
       ↓
Staging Area
       ↓
git commit
       ↓
Git Repository
```
