# git checkout -b dev VS git branch dev

## Introduction

Both commands are related to creating Git branches, but they behave differently.

Understanding this difference is very important in daily Git workflows.

---

# 1. git branch dev

## Command

```bash
git branch dev
```

## What It Does

This command:

- Creates a new branch named `dev`
- Does NOT switch to the branch

You remain on your current branch.

---

## Example

Current branch:

```text
master
```

Run:

```bash
git branch dev
```

Now available branches:

```text
master
dev
```

But you are STILL on:

```text
master
```

---

## Check Current Branch

Run:

```bash
git branch
```

Example output:

```text
* master
  dev
```

The `*` means current branch.

---

# 2. git checkout -b dev

## Command

```bash
git checkout -b dev
```

## What It Does

This command performs TWO actions:

1. Creates branch `dev`
2. Immediately switches to `dev`

---

## Example

Current branch:

```text
master
```

Run:

```bash
git checkout -b dev
```

Now output becomes:

```text
  master
* dev
```

You are now working inside the `dev` branch.

---

# Main Difference

| Command | Creates Branch | Switches Branch |
|---|---|---|
| `git branch dev` | Yes | No |
| `git checkout -b dev` | Yes | Yes |

---

# Visual Explanation

## Using git branch dev

```text
master
   |
   +---- dev
```

You remain on:

```text
master
```

---

## Using git checkout -b dev

```text
master
   |
   +---- dev   ← YOU ARE HERE
```

Git creates the branch and moves you there immediately.

---

# If You Used git branch dev

You must manually switch:

```bash
git checkout dev
```

or modern Git:

```bash
git switch dev
```

---

# Modern Git Alternative

Instead of:

```bash
git checkout -b dev
```

Modern Git recommends:

```bash
git switch -c dev
```

Equivalent behavior:
- create branch
- switch branch

---

# Why Modern Git Introduced switch

The old `checkout` command had too many responsibilities:

- switching branches
- restoring files
- detached HEAD operations

So Git introduced:
- `git switch` → branch switching
- `git restore` → restoring files

Cleaner and easier for beginners.

---

# Recommended Modern Usage

## Create and switch

```bash
git switch -c dev
```

## Switch existing branch

```bash
git switch dev
```

---

# Typical Developer Workflow

Most developers use:

```bash
git switch -c feature-login
```

or older style:

```bash
git checkout -b feature-login
```

because it saves time.

---

# Important Git Concept

When switching branches, Git changes:

- HEAD pointer
- commit history context
- working directory files
- current timeline

Branches are essentially separate development timelines.

---

# Summary

## git branch dev

- Creates branch only
- Does not switch

---

## git checkout -b dev

- Creates branch
- Immediately switches to branch

---

# Quick Memory Trick

## branch = create only

```bash
git branch dev
```

---

## checkout -b = create + move

```bash
git checkout -b dev
```

---

# Recommended Today

Use modern Git commands:

```bash
git switch -c dev
```

because they are:
- cleaner
- beginner-friendly
- easier to understand
