
# Complete GitHub Branching, Pull Request, Merge, and Sync Workflow Guide
## Real Team Workflow Using Git, GitHub, WSL, SSH, Nginx, and main/dev Branches

Author: Khalid Khan  
Repository: Git-GitHub-Practice

---

# Introduction

This guide documents a complete real-world GitHub team workflow.

It covers:

- Creating a `dev` branch from `main`
- Working safely on `dev`
- Creating a demo Nginx webpage
- Committing work on `dev`
- Pushing `dev` to GitHub
- Merging changes into `main`
- Syncing local `main` after GitHub merge
- Understanding `origin/main`, `origin/dev`, and branch tracking

This is the same style of workflow used by software and DevOps teams.

---

# Project Repository

```text
git@github.com:krmaryum/Git-GitHub-Practice.git
```

---

# Main Idea

In a team workflow:

```text
main = stable branch
dev  = development branch
```

You do not work directly on `main` for new changes.

Instead:

```text
main → create dev → work → commit → push dev → merge into main → pull latest main
```

---

# Step 1 — Check Current Branch

```bash
git branch
```

Example output:

```text
* main
```

This means the current branch is `main`.

---

# Step 2 — Check Remote Repository

```bash
git remote -v
```

Output:

```text
origin  git@github.com:krmaryum/Git-GitHub-Practice.git (fetch)
origin  git@github.com:krmaryum/Git-GitHub-Practice.git (push)
```

This confirms the repository is connected to GitHub using SSH.

---

# Step 3 — Create dev Branch from main

```bash
git switch -c dev
```

Output:

```text
Switched to a new branch 'dev'
```

This command does two things:

1. Creates a new branch named `dev`
2. Switches to the `dev` branch

---

# Step 4 — Verify dev Branch

```bash
git branch
```

Output:

```text
* dev
  main
```

The `*` means you are currently on `dev`.

---

# Step 5 — Create Demo Nginx Web Page

You tested the default Nginx page first:

```bash
curl http://localhost:80
```

Then you moved into the Nginx web root:

```bash
cd /var/www/html
```

Listed files:

```bash
ls
```

Output:

```text
index.nginx-debian.html
```

---

# Step 6 — Create index.html

First attempt:

```bash
vim index.html
```

This failed because `/var/www/html` is owned by root.

Correct command:

```bash
sudo vim index.html
```

You created a custom Nginx demo page.

---

# Step 7 — Test the New Web Page

```bash
curl http://localhost:80
```

This returned your custom HTML page.

That confirmed:

- Nginx was running
- `index.html` was served correctly
- localhost testing worked

---

# Step 8 — Copy index.html into Git Repository

Move back to your Git project:

```bash
cd /mnt/c/Linux/Git-GitHub-Practice
```

Copy the Nginx webpage:

```bash
cp /var/www/html/index.html .
```

Check files:

```bash
ls
```

Output:

```text
README.md  git-branch.txt  index.html  install_nginx.sh
```

---

# Step 9 — Stage index.html

```bash
git add index.html
```

This stages the new webpage for commit.

---

# Step 10 — Commit index.html on dev

```bash
git commit -m "feat: Added Demo web page"
```

Output:

```text
[dev 0c07662] feat: Added Demo web page
 1 file changed, 73 insertions(+)
 create mode 100644 index.html
```

This commit exists on the `dev` branch.

---

# Step 11 — Push dev Branch to GitHub

First attempt failed because WSL SSH was not fully configured:

```bash
git push origin dev
```

Error:

```text
Permission denied (publickey)
```

---

# Step 12 — Fix WSL SSH Authentication

You checked WSL SSH files:

```bash
ls -l ~/.ssh/
```

Then tested SSH:

```bash
ssh -T git@github.com
```

Success output:

```text
Hi krmaryum! You've successfully authenticated, but GitHub does not provide shell access.
```

---

# Step 13 — Push dev Successfully

```bash
git push -u origin dev
```

Output:

```text
[new branch] dev -> dev
branch 'dev' set up to track 'origin/dev'
```

This means:

- local `dev` was pushed to GitHub
- remote `origin/dev` was created
- local `dev` now tracks `origin/dev`

---

# Step 14 — Check dev Status

```bash
git status
```

Output:

```text
On branch dev
Your branch is up to date with 'origin/dev'.

nothing to commit, working tree clean
```

Meaning:

- you are on `dev`
- local `dev` and GitHub `origin/dev` are synchronized
- no pending changes

---

# Step 15 — Merge dev into main on GitHub

In a team workflow, instead of merging locally, you can merge on GitHub using a Pull Request.

Typical flow:

```text
GitHub → Pull requests → New pull request
base: main
compare: dev
Create pull request
Merge pull request
```

After merging on GitHub:

- `main` is updated on GitHub
- local `main` may still be behind
- you must pull the latest `main`

---

# Step 16 — Switch Back to main Locally

```bash
git switch main
```

Output:

```text
Switched to branch 'main'
Your branch is up to date with 'origin/main'.
```

At that moment Git still believed local `main` was synced, but GitHub had newer changes after the merge.

---

# Step 17 — Check main Status

```bash
git status
```

Output:

```text
On branch main
Your branch is up to date with 'origin/main'.

nothing to commit, working tree clean
```

This means the local working tree is clean.

However, after a GitHub merge, you should still pull to make sure local `main` has the newest remote updates.

---

# Step 18 — Check Files Before Pull

```bash
ll
```

Output before pulling:

```text
README.md
install_nginx.sh
```

Notice:

```text
index.html
```

was not present yet on local `main`.

That means local `main` did not yet have the GitHub-merged webpage.

---

# Step 19 — Pull Latest main from GitHub

```bash
git pull origin main --rebase
```

Output:

```text
From github.com:krmaryum/Git-GitHub-Practice
 * branch            main       -> FETCH_HEAD
   7681874..f6f4103  main       -> origin/main
Updating 7681874..f6f4103
Fast-forward
 index.html | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 index.html
```

This pulled the GitHub merge result into local `main`.

---

# Important Note About --rebase

The command used was:

```bash
git pull origin main --rebase
```

In this case, Git performed a fast-forward update because local `main` had no new commits.

So even though `--rebase` was used, the result was:

```text
Fast-forward
```

This is normal.

---

# Step 20 — Check Files After Pull

```bash
ll
```

Output after pulling:

```text
README.md
index.html
install_nginx.sh
```

Now `index.html` exists on local `main`.

This confirms:

- GitHub merge completed
- local `main` synced with `origin/main`
- webpage file is now available on `main`

---

# Final Branch Understanding

After this workflow:

```text
dev          contains feature work
origin/dev   GitHub copy of dev
main         local stable branch after pull
origin/main  GitHub stable branch after merge
```

---

# Visual Workflow

```text
main
 |
 | create dev
 v
dev → add index.html → commit → push origin dev
                         |
                         v
                   GitHub Pull Request
                         |
                         v
                    merge into main
                         |
                         v
             git pull origin main --rebase
                         |
                         v
                 local main updated
```

---

# Why This Is a Team Workflow

In teams, developers usually do not directly change `main`.

Instead:

1. Create a branch
2. Work on that branch
3. Push branch to GitHub
4. Open Pull Request
5. Team reviews
6. Merge into `main`
7. Everyone pulls latest `main`

This keeps the project safe and organized.

---

# Commands Practiced

## Check branch

```bash
git branch
```

---

## Create dev branch

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

## Add file

```bash
git add index.html
```

---

## Commit file

```bash
git commit -m "feat: Added Demo web page"
```

---

## Push dev to GitHub

```bash
git push -u origin dev
```

---

## Check status

```bash
git status
```

---

## Pull latest main after GitHub merge

```bash
git pull origin main --rebase
```

---

## Check files

```bash
ll
```

---

# Common Issues Practiced

## 1. Permission denied publickey

Problem:

```text
Permission denied (publickey)
```

Cause:
- SSH key not configured in WSL

Fix:
- create or copy SSH key
- add public key to GitHub
- test with:

```bash
ssh -T git@github.com
```

---

## 2. Untracked git-branch.txt

Status showed:

```text
Untracked files:
  git-branch.txt
```

This file was created by the `script` command.

Because it was untracked, this failed:

```bash
git restore git-branch.txt
```

Reason:

```text
git restore only works on tracked files
```

To remove untracked files safely:

```bash
git clean -n
git clean -f
```

---

# Final Result

You successfully practiced:

- creating a branch
- working on a feature branch
- pushing branch to GitHub
- GitHub-style team workflow
- syncing local main after GitHub merge
- using WSL SSH
- testing Nginx page
- understanding branch tracking

---

# Final Clean Workflow for Teams

```bash
git switch main
git pull origin main --rebase

git switch -c feature-branch

# work on files

git add .
git commit -m "feat: add new feature"

git push -u origin feature-branch
```

Then on GitHub:

```text
Open Pull Request
Review
Merge into main
```

Then locally:

```bash
git switch main
git pull origin main --rebase
```

---

# Conclusion

This workflow shows the complete cycle used in real team projects:

```text
branch → work → commit → push → pull request → merge → sync main
```

You practiced both local Git and GitHub remote teamwork.
