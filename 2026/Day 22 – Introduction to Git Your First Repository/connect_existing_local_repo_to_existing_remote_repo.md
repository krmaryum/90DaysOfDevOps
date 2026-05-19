# Connecting an Existing Local Git Repository to an Existing Remote GitHub Repository

Author: Khalid Khan

---

# Scenario

Sometimes both already exist:

## Existing Local Repository

Example:

```text
~/project-folder
```

with:

```text
.git
```

inside.

AND

## Existing Remote GitHub Repository

Example:

```text
git@github.com:krmaryum/project.git
```

The goal is to connect:

```text
Local Repository ↔ Existing GitHub Repository
```

and then push local commits to GitHub.

---

# Common Situation

This usually happens when:

- local project already exists
- GitHub repository was created separately
- old project needs GitHub backup
- connecting project for collaboration
- preparing CI/CD repositories

---

# Problem Faced

Running:

```bash
git push
```

may show:

```text
fatal: No configured push destination.
```

because the local repository is not connected to GitHub yet.

---

# Step 1 — Move Into Local Repository

Command:

```bash
cd project-folder
```

Example:

```bash
cd ~/shubham/day-22
```

---

# Step 2 — Verify Git Repository Exists

Command:

```bash
ls -al
```

Look for:

```text
.git
```

This confirms:
- local Git repository already exists

---

# Step 3 — Check Existing Remote Repository Configuration

Command:

```bash
git remote -v
```

If no output appears:

```text
(no output)
```

Meaning:
- no remote repository connected yet

---

# Understanding git remote -v

| Part | Meaning |
|---|---|
| git remote | manage remote repositories |
| -v | verbose output |

Purpose:
- displays connected remote repositories

---

# Step 4 — Copy Existing GitHub Repository URL

Example SSH URL:

```text
git@github.com:krmaryum/project.git
```

Example HTTPS URL:

```text
https://github.com/krmaryum/project.git
```

SSH is recommended because:
- more secure
- no repeated password prompts
- commonly used in DevOps

---

# Step 5 — Connect Local Repository to Existing GitHub Repository

Using SSH:

```bash
git remote add origin git@github.com:krmaryum/project.git
```

Using HTTPS:

```bash
git remote add origin https://github.com/krmaryum/project.git
```

---

# Understanding the Command

| Part | Meaning |
|---|---|
| git remote add | add remote repository |
| origin | remote nickname |
| repository URL | GitHub repository address |

---

# Understanding origin

```text
origin
```

is the default nickname Git uses for a remote repository.

Example:

```text
origin = GitHub repository
```

Instead of typing full GitHub URL every time, Git uses:

```text
origin
```

as a shortcut.

---

# Step 6 — Verify Remote Connection

Command:

```bash
git remote -v
```

Expected output:

```text
origin  git@github.com:krmaryum/project.git (fetch)
origin  git@github.com:krmaryum/project.git (push)
```

Meaning:
- local repository successfully connected to GitHub

---

# Step 7 — Check Current Branch

Command:

```bash
git branch
```

Example output:

```text
* main
```

or:

```text
* master
```

---

# Step 8 — Push Local Repository to GitHub

If branch is:

```text
main
```

use:

```bash
git push -u origin main
```

If branch is:

```text
master
```

use:

```bash
git push -u origin master
```

---

# Understanding -u

Option:

```bash
-u
```

means:

```text
set upstream tracking branch
```

After using `-u`, future pushes become easier:

Instead of:

```bash
git push origin main
```

you can simply use:

```bash
git push
```

---

# Important Problem That May Happen

Sometimes the remote GitHub repository already contains files.

Example:
- README.md
- LICENSE
- .gitignore

Then push may fail with:

```text
rejected because remote contains work that you do not have locally
```

---

# Why This Happens

Git protects repository history.

It sees:
- local history
- remote history

as different histories.

---

# Solution — Pull Remote Repository First

Command:

```bash
git pull origin main --allow-unrelated-histories
```

Purpose:
- combines local and remote histories

Then push again:

```bash
git push -u origin main
```

---

# Complete Workflow

```text
Existing Local Repository
            ↓
git remote add origin
            ↓
Connect to Existing GitHub Repository
            ↓
git push
            ↓
Code uploaded to GitHub
```

---

# Important Git Concepts Learned

## Local Repository

Git repository stored on local machine.

---

## Remote Repository

Git repository hosted online.

---

## origin

Default remote repository nickname.

---

## Push

Uploads local commits to GitHub.

---

## Upstream Tracking

Links local branch with remote branch.

---

# Useful Commands Practiced

## Check Remote Repository

```bash
git remote -v
```

---

## Add Remote Repository

```bash
git remote add origin git@github.com:username/repository.git
```

---

## Push to GitHub

```bash
git push -u origin main
```

---

## Pull Existing Remote Changes

```bash
git pull origin main --allow-unrelated-histories
```

---

# Real DevOps Importance

This workflow is extremely common in:

- GitHub collaboration
- DevOps repositories
- Infrastructure as Code
- CI/CD setup
- migrating projects
- team environments

Every professional Git workflow depends on:
- local repositories
- remote repositories
- push/pull synchronization

---

# Final Understanding

If:
- local repository already exists
AND
- GitHub repository already exists

they must be connected manually using:

```bash
git remote add origin <repository-url>
```

After that:
- Git knows where to push code
- Git knows where to pull updates from

---

# Final Conclusion

This task successfully demonstrated:

- connecting local Git repositories
- understanding remote repositories
- using SSH repository URLs
- understanding origin
- verifying remote connections
- pushing code to GitHub
- handling existing remote repository history

This is one of the most important GitHub workflow concepts used in real DevOps environments.
