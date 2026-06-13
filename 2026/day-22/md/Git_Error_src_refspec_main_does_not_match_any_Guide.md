# Git Error: src refspec main does not match any

## Complete Explanation and Solution (A to Z)

### Why This Error Happens

When you run:

```bash
git push -u origin main
```

and see:

```text
error: src refspec main does not match any
```

it usually means your repository has **no commits yet**.

Example:

```bash
git status
```

Output:

```text
On branch main
No commits yet
```

Git cannot push an empty branch.

---

## The Root Cause

Git branches point to commits.

Without a commit:

```text
main
  │
  ▼
nothing
```

With a commit:

```text
main
  │
  ▼
Initial Commit
```

Only after a commit exists can Git push the branch.

---

## Step-by-Step Fix

### Step 1: Create a File

# create a new repo in the GitHub by name "repo-name"

then in local macheine

mkdir "repo-name" && cd "repo-name"

```bash
echo '# github-actions-practice' > README.md
```

### Step 2: Stage the File

```bash
git add README.md
```

### Step 3: Create the First Commit

```bash
git commit -m 'Initial commit'
```

### Step 4: Verify Commit

```bash
git log --oneline
```

### Step 5: Push to GitHub

```bash
git push -u origin main
```

---

## Complete Workflow

```bash
git init
git branch -M main
echo '# github-actions-practice' > README.md
git add README.md
git commit -m 'Initial commit'
git remote add origin git@github.com:username/<repo-name>.git
git push -u origin main
```

---

## Troubleshooting

### Check Status

```bash
git status
```

### Check Commits

```bash
git log --oneline
```

### Check Remote

```bash
git remote -v
```

---

## Key Takeaways

- Git cannot push an empty branch.
- A branch must contain at least one commit.
- Create a file, stage it, commit it, then push.
- Always check `git status` when troubleshooting.
