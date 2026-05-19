# Day 22 – Introduction to Git: Your First Repository

# Table of Contents

| Task | Topic | Summary | Quick Link |
|---|---|---|---|
| Task 1 | Install and Configure Git | Installed Git, configured username/email, verified SSH authentication with GitHub | [Go to Task 1](#task-1--install-and-configure-git) |
| Task 2 | Create Your Git Project | Created Git repository, explored `.git/` folder, checked repository status | [Go to Task 2](#task-2--create-your-git-project) |
| Task 3 | Create Git Commands Reference | Built `git-commands.md` with categorized Git commands and examples | [Go to Task 3](#task-3--create-your-git-commands-reference) |
| Task 4 | Stage and Commit | Learned staging area, commits, commit messages, and Git history | [Go to Task 4](#task-4--stage-and-commit) |
| Task 5 | Make More Changes and Build History | Updated files repeatedly, created multiple commits, viewed compact history | [Go to Task 5](#task-5--make-more-changes-and-build-history) |
| Task 6 | Understand the Git Workflow | Explained Git workflow, staging area, `.git/` folder, commit hashes, and repository structure | [Go to Task 6](#task-6--understand-the-git-workflow) |

---

# Day 22 Overview

Day 22 marks the beginning of the Git journey.

> Git stands for Global Information Tracker

Git is one of the most important tools in DevOps and software engineering because it helps developers:

- track changes
- collaborate with teams
- manage code history
- work safely using branches
- recover previous versions of files

Almost every modern DevOps workflow depends on Git.

Today focuses on understanding the foundations of Git by practicing basic commands and creating the first Git repository.

---

# Day 22 Objectives

The main objectives for Day 22 are:

- Understand what Git is
- Learn why version control is important
- Install and configure Git
- Create and manage a Git repository
- Learn essential Git commands
- Build a personal Git command reference
- Start maintaining clean commit history
- Practice GitHub workflow basics

---

# Expected Output

By the end of Day 22:

- A local Git repository should exist
- Multiple commits should appear in Git history
- `git-commands.md` should be created
- `day-22-notes.md` should be created
- Git should be connected and configured correctly

---

# Ongoing Task

A file named:

```text
git-commands.md
```

should be continuously updated during future Git learning.

This file becomes a personal Git reference guide.

Best practice:
- one update
- one clean commit
- clear commit messages

Example:

```bash
git commit -m "day-22: add git configuration notes"
```

---

# Task 1 – Install and Configure Git

## Task 1 Overview

The first task focuses on preparing Git for development work.

This includes:

- verifying Git installation
- configuring Git username
- configuring Git email
- verifying Git configuration
- testing GitHub SSH authentication

These steps are required before using Git professionally.

---

# Task 1 Objectives

After completing Task 1, the following should be understood:

- how to verify Git installation
- how Git identifies commit authors
- how to configure Git globally
- how SSH authentication works with GitHub
- how to securely connect Git with GitHub

---

# Verify Git Installation

Command:

```bash
git --version
```

Example output:

```text
git version 2.54.0
```

This confirms Git is installed successfully.

---

# Configure Git Username

Command:

```bash
git config --global user.name "user_name"
```

Purpose:
- sets Git username globally
- used as commit author name

---

# Configure Git Email

Command:

```bash
git config --global user.email "user@example.com"
```

Purpose:
- associates commits with GitHub account
- identifies commit author email

---

# Verify Git Configuration

Command:

```bash
git config --global --list
```

Example output:

```text
user.name=username
user.email=example.com
core.autocrlf=input
```

This confirms Git global configuration is working correctly.

---

# Additional Practice — GitHub SSH Authentication

## Verify SSH Connection

Command:

```bash
ssh -T git@github.com
```

Example output:

```text
Hi krmaryum! You've successfully authenticated, but GitHub does not provide shell access.
```

---

# Meaning of the SSH Message

The message contains two important parts:

## 1. Successfully Authenticated

This means:

- SSH key is valid
- GitHub recognized the account
- SSH connection works
- Git operations can now use SSH

---

## 2. GitHub Does Not Provide Shell Access

This means:

- GitHub is not a Linux server
- GitHub does not provide terminal login
- SSH is only used for Git authentication

GitHub allows:
- git push
- git pull
- git clone

GitHub does not allow:
- bash shell access
- server management
- running Linux commands remotely

---

# Why SSH Is Important

Benefits of SSH with GitHub:

- secure authentication
- encrypted communication
- passwordless Git operations
- automation friendly
- standard DevOps practice

---

# Commands Learned in Task 1

| Command | Purpose |
|---|---|
| `git --version` | Verify Git installation |
| `git config --global user.name` | Set Git username |
| `git config --global user.email` | Set Git email |
| `git config --global --list` | Verify Git configuration |
| `ssh -T git@github.com` | Test GitHub SSH authentication |

---

# Task 2: Create Your Git Project

Author: Khalid Khan

---

# Task 2 Overview

Task 2 focuses on creating the first real Git project repository.

This task introduces the foundation of Git version control by practicing:

- creating a project directory
- initializing a Git repository
- understanding `git status`
- exploring the hidden `.git` directory
- learning how Git internally stores repository data

Every Git project starts with:

```bash
git init
```

---

# Task 2 Objectives

After completing Task 2, the following concepts should be understood:

- how to create a Git repository
- what `git init` does
- how to check repository status
- how to view hidden files
- what the `.git` directory contains
- how Git internally tracks repositories

---

# Step 1 — Navigate to Day 22 Directory

Commands used:

```bash
cd shubham/

cd day-22
```

Verify contents:

```bash
ls
```

Output:

```text
devops-git-practice  task2.txt
```

This confirmed:
- Day 22 workspace exists
- project directory exists

---

# Step 2 — Enter the Git Project Folder

Command:

```bash
cd devops-git-practice/
```

Check files:

```bash
ls
```

Output:

```text
(no files yet)
```

At this stage:
- repository is empty
- no project files exist yet

---

# Step 3 — View Hidden Files

Command:

```bash
ls -al
```

Output:

```text
total 12
drwxr-xr-x 3 khalid khalid 4096 May 16 23:27 .
drwxr-xr-x 3 khalid khalid 4096 May 16 23:26 ..
drwxr-xr-x 6 khalid khalid 4096 May 16 23:27 .git
```

Important observation:

```text
.git
```

is visible.

This confirms:
- Git repository was initialized successfully
- hidden Git metadata directory exists

---

# Understanding Hidden Files

In Linux:

```text
.
```

means:
- current directory

```text
..
```

means:
- parent directory

Files or directories beginning with:

```text
.
```

are hidden files.

Example:

```text
.git
```

---

# Step 4 — Explore the .git Directory

Command:

```bash
tree .git/
```

Example structure:

```text
.git/
├── HEAD
├── config
├── description
├── hooks/
├── info/
├── objects/
└── refs/
```

---

# Understanding Important .git Components

## HEAD

Purpose:
- points to the current branch

---

## config

Purpose:
- stores repository configuration settings

---

## hooks/

Purpose:
- stores Git automation scripts

Examples:
- pre-commit hooks
- pre-push hooks

---

## objects/

Purpose:
- stores Git objects
- commits
- repository history

---

## refs/

Purpose:
- stores branch references
- stores tags

---

## info/

Purpose:
- stores additional repository information

---

# Important Understanding

The hidden directory:

```text
.git
```

IS the actual Git repository.

Git stores:
- commits
- branches
- history
- metadata

inside `.git`.

---

# Step 5 — Check Git Repository Status

Command:

```bash
git status
```

Output:

```text
On branch master

No commits yet

nothing to commit (create/copy files and use "git add" to track)
```

---

# Understanding git status

`git status` tells:
- current branch
- tracked files
- untracked files
- staged changes
- repository state

Think of it as:

```text
Git repository health report
```

---

# Understanding "No commits yet"

This means:
- Git repository exists
- Git tracking system is active
- no commits have been created yet

The repository is empty.

---

# Understanding Current Branch

Output showed:

```text
On branch master
```

Older Git versions use:

```text
master
```

Modern Git versions often use:

```text
main
```

Both are valid.

Later you can rename:

```bash
git branch -M main
```

after the first commit.

---

# Step 6 — Explore .git Again

Command:

```bash
ls -al .git
```

Output showed:

```text
HEAD
config
description
hooks
info
objects
refs
```

This confirmed the internal Git repository structure.

---

# Important Commands Practiced

## Move into project

```bash
cd devops-git-practice
```

---

## List files

```bash
ls
```

---

## View hidden files

```bash
ls -al
```

---

## Explore Git structure

```bash
tree .git/
```

---

## Check repository status

```bash
git status
```

---

## View .git contents

```bash
ls -al .git
```

---

# What Was Learned

Task 2 introduced:

- Git repository structure
- hidden Linux files
- Git metadata
- repository initialization
- repository status checking
- Git internal directories

---

# Key Concept Learned

Most important understanding:

```text
.git is the actual Git repository
```

Without `.git`:
- no commits exist
- no branches exist
- no Git tracking exists

Deleting:

```bash
rm -rf .git
```

removes the repository completely.

---

# Real DevOps Importance

Every Git project begins with:

```bash
git init
```

Understanding `.git` helps understand:
- commits
- branches
- merges
- remote repositories
- GitHub workflows

---

# Conclusion

Task 2 successfully demonstrated:

- creating a Git project
- understanding Git status
- exploring Git internals
- learning repository structure

This builds the foundation for:
- commits
- staging
- branching
- GitHub collaboration

---

# Task 3: Create Your Git Commands Reference

Author: Khalid Khan

---

# Task 3 Overview

Task 3 focuses on building a personal Git command reference file.

The goal of this task is to create a living document that will grow every day as new Git concepts and commands are learned.

This file becomes:
- a personal Git handbook
- DevOps revision notes
- Git practice documentation
- a quick command reference
- interview preparation material

The file created for this task:

```text
git-commands.md
```

---

# Task 3 Objectives

After completing this task, the following concepts should be understood:

- how to document Git commands
- how to organize commands by category
- how to explain Git commands clearly
- how to write examples for commands
- how to maintain personal technical documentation

---

# Step 1 — Navigate to Day 22 Directory

Commands used:

```bash
cd shubham/

cd day-22
```

---

# Step 2 — Create git-commands.md

Command:

```bash
touch git-commands.md
```

Purpose:
- creates an empty markdown file
- will store Git command notes

---

# Step 3 — Verify File Creation

Command:

```bash
ls
```

Output:

```text
devops-git-practice  git-commands.md  task2.txt  task3.txt
```

This confirmed:
- the markdown file was successfully created

---

# Step 4 — Open File in Vim

Command:

```bash
vim git-commands.md
```

Purpose:
- opens the markdown file in Vim editor
- allows writing Git documentation

---

# Step 5 — Add Main Title

Added:

```md
# Git Commands Reference
```

Purpose:
- creates the main document heading

---

# Step 6 — Organize Commands by Category

The file was organized into sections:

```md
# Setup & Config
# SSH & Authentication
# Basic Workflow
# Viewing Changes
# Branching & Navigation
# Undo Changes
# Remote Repositories
```

This improves:
- readability
- organization
- professional documentation structure

---

[git-commands.md](./git-commands.md)

# Important Concepts Learned

## Markdown Documentation

Learned how to:
- create markdown files
- organize technical notes
- format headings
- use code blocks

---

## Git Documentation Practice

Learned how to:
- explain commands
- categorize commands
- document examples
- create reusable notes

---

## SSH Authentication

Learned:
- GitHub SSH testing
- SSH authentication verification
- GitHub access understanding

---

## Git Workflow Commands

Practiced:
- repository setup
- staging
- commits
- branch management
- remote repository operations

---

# Why This Task Is Important

This task creates a reusable learning system.

Instead of memorizing commands, the learner builds:

```text
personal Git documentation
```

This is exactly how professional DevOps engineers:
- document workflows
- maintain references
- build knowledge bases

---

# Real DevOps Importance

In real DevOps environments:
- documentation is critical
- Git commands are used daily
- clean references improve productivity
- team collaboration depends on Git knowledge

This file becomes:
- personal reference
- future troubleshooting guide
- daily Git cheat sheet

---

# Final Understanding

Task 3 was not only about creating a file.

It taught:
- technical documentation
- Git command organization
- markdown formatting
- Git workflow understanding
- SSH authentication concepts
- professional note-taking

---

# Conclusion

Task 3 successfully demonstrated:

- creating markdown documentation
- documenting Git commands
- organizing technical knowledge
- understanding Git workflows
- building a personal Git handbook

This file should continue growing every day throughout the Git learning journey.

---

# Task 4: Stage and Commit in Git

---

# Task 4 Overview

Task 4 introduces the most important Git workflow used daily by developers and DevOps engineers.

This task focuses on:

- staging files
- checking staged changes
- creating commits
- viewing Git history

This is the core workflow behind:
- GitHub collaboration
- DevOps automation
- CI/CD pipelines
- infrastructure version control

---

# Task 4 Objectives

After completing this task, the following concepts should be understood:

- how Git staging works
- how to track changes before commit
- how commits create snapshots
- how Git stores project history
- how to inspect commit history

---

# Workflow Learned

```text
Working Directory
        ↓
git add
        ↓
Staging Area
        ↓
git commit
        ↓
Git History
```

---

# Step 1 — Navigate to Project Directory

Command used:

```bash
cd devops-git-practice/
```

Purpose:
- enters the Git project directory

---

# Step 2 — Check Repository Files

Command used:

```bash
ls
```

Purpose:
- displays project files

---

# Step 3 — Return to Day 22 Directory

Command used:

```bash
cd ..
```

Purpose:
- moves back one directory level

---

# Step 4 — Initialize Git Repository

Command used:

```bash
git init
```

Actual output:

```text
Initialized empty Git repository in /home/khalid/shubham/day-22/.git/
```

Purpose:
- creates a new Git repository
- creates hidden `.git` directory
- enables version control

---

# Important Git Hint Observed

Git displayed:

```text
Using 'master' as the name for the initial branch.
```

Git also explained:
- future default branch names may change
- modern repositories commonly use:
  - main
  - trunk
  - development

---

# Step 5 — Rename Branch to main

Command used:

```bash
git branch -m main
```

Purpose:
- renames default branch
- changes branch from `master` to `main`

---

# Step 6 — Check Git Repository Status

Command used:

```bash
git status
```

Actual output included:

```text
On branch main

No commits yet
```

Git also displayed untracked files:

```text
devops-git-practice/
git-commands.md
task2.txt
task3.txt
task4.txt
```

Meaning:
- files exist
- Git is not tracking them yet

---

# Step 7 — Verify Git Global Configuration

Command used:

```bash
git config --global --list
```

Actual output:

```text
user.name=username
user.email=example.com
core.autocrlf=input
```

Purpose:
- displays Git global configuration
- verifies username and email

---

# Step 8 — Verify GitHub SSH Authentication

Command used:

```bash
ssh -T git@github.com
```

Actual output:

```text
Hi krmaryum! You've successfully authenticated, but GitHub does not provide shell access.
```

Meaning:
- SSH authentication succeeded
- GitHub accepted SSH key
- Git operations are allowed

---

# Step 9 — Stage File for Commit

Command used:

```bash
git add git-commands.md
```

Purpose:
- moves file into staging area
- prepares file for commit

---

# Step 10 — Check Staged Changes

Command used:

```bash
git status
```

Actual output:

```text
Changes to be committed:
  new file: git-commands.md
```

Meaning:
- file is staged
- ready for commit

---

# Step 11 — View Staged Differences

Command used:

```bash
git diff --staged
```

Purpose:
- displays exactly what will be committed

This command is extremely useful before committing.

---

# Step 12 — Create Commit

Command used:

```bash
git commit -m "day-22: add git commands reference"
```

Actual output:

```text
[main (root-commit) 8b6e806] day-22: add git commands reference
```

Meaning:
- first commit created
- snapshot saved into Git history

---

# Step 13 — View Detailed Commit History

Command used:

```bash
git log
```

```text
commit 8b6e8063c2c081a85289aad0b9af5c3d077d293f (HEAD -> main)
Author: krmaryum <krmaryum@yahoo.com>
Date:   Mon May 18 21:40:07 2026 -0500

    day-22: add git commands reference
```

Purpose:
- displays detailed commit history
- shows author
- shows commit hash
- shows commit date

---

# Step 14 — View Compact Commit History

Command used:

```bash
git log --oneline
```

Actual output:

```text
8b6e806 (HEAD -> main) day-22: add git commands reference
```

Purpose:
- compact Git history
- easier to read

---

# Important Concepts Learned

## Working Directory

Where files are actively edited.

---

## Staging Area

Temporary area before commit.

---

## Commit

Saved snapshot of project state.

---

## Git History

Timeline of project changes.

---

# Commands Practiced

## Initialize Repository

```bash
git init
```

---

## Rename Branch

```bash
git branch -m main
```

---

## Check Repository Status

```bash
git status
```

---

## Verify Git Config

```bash
git config --global --list
```

---

## Test GitHub SSH Authentication

```bash
ssh -T git@github.com
```

---

## Stage File

```bash
git add git-commands.md
```

---

## View Staged Changes

```bash
git diff --staged
```

---

## Create Commit

```bash
git commit -m "day-22: add git commands reference"
```

---

## View Detailed History

```bash
git log
```

---

## View Compact History

```bash
git log --oneline
```

---

# Real DevOps Importance

These commands are used daily for:
- infrastructure repositories
- Kubernetes manifests
- CI/CD pipelines
- automation scripts
- collaboration workflows

Every professional DevOps workflow depends on:
- staging
- commits
- history tracking

---

# Key Understanding

Task 4 introduced the foundation of Git:

```text
Track → Stage → Commit → History
```

Everything in Git builds on top of this workflow:
- branching
- merging
- pull requests
- collaboration
- CI/CD automation

---

# Final Conclusion

Task 4 successfully demonstrated:

- creating a Git repository
- renaming branches
- staging files
- reviewing staged changes
- committing snapshots
- viewing Git history
- understanding Git workflow

This task forms the core foundation for all future Git and GitHub operations.

---

# Task 5: Make More Changes and Build Git History

Author: Khalid Khan

---

# Task 5 Overview

Task 5 focused on continuously updating a Git-tracked file and building commit history over time.

This task introduced the real power of Git:

- tracking project evolution
- saving multiple snapshots
- comparing changes
- creating meaningful commit history

---

# Task 5 Objectives

After completing this task, the following concepts were practiced:

- editing tracked files
- checking file modifications
- viewing differences between versions
- staging updated files
- creating multiple commits
- building Git history
- viewing compact commit history

---

# Workflow Practiced

```text
Edit File
    ↓
git status
    ↓
git diff
    ↓
git add
    ↓
git commit
    ↓
Repeat Process
```

---

# File Used in This Task

Main file updated:

```text
git-commands.md
```

---

# Step 1 — Verify Existing Files

Command used:

```bash
ls
```

Actual output included:

```text
devops-git-practice
git-commands.md
task2.txt
task3.txt
task4.txt
task5.txt
```

---

# Step 2 — Open git-commands.md

Command used:

```bash
vim git-commands.md
```

Purpose:
- edit Git command reference file
- add newly learned commands

---

# Step 3 — Add Docker Command

New command added:

```md
## docker ps

### What it does
Shows running Docker containers.

### Example

docker ps
```

---

# Step 4 — Check Repository Status

Command used:

```bash
git status
```

Actual output included:

```text
modified: git-commands.md
```

Meaning:
- tracked file was modified
- changes not yet staged

---

# Step 5 — View Exact Changes

Command used:

```bash
git diff
```

Purpose:
- displays line-by-line modifications
- compares working directory with last commit

---

# Step 6 — Stage Updated File

Command used:

```bash
git add git-commands.md
```

Purpose:
- moves modified file into staging area

---

# Step 7 — Verify Staged Changes

Command used:

```bash
git diff --staged
```

Purpose:
- displays exactly what will be committed

---

# Step 8 — Create Second Commit

Command used:

```bash
git commit -m "docs: add Docker commands"
```

Actual output:

```text
[main 5f644cf] docs: add Docker command
```

---

# Step 9 — Edit File Again

Command used:

```bash
vim git-commands.md
```

---

# Step 10 — Add Another Docker Command

New command added:

```md
## docker ps -a

### What it does
Shows all Docker containers, including running and stopped containers.

### Example

docker ps -a
```

---

# Step 11 — Check Status Again

Command used:

```bash
git status
```

Actual output:

```text
modified: git-commands.md
```

---

# Step 12 — Stage File Again

Command used:

```bash
git add git-commands.md
```

---

# Step 13 — Create Third Commit

Command used:

```bash
git commit -m "docs: add branching commands"
```

Actual output:

```text
[main 962ebee] docs: add branching commands
```

---

# Step 14 — Edit File One More Time

Command used:

```bash
vim git-commands.md
```

---

# Step 15 — Add Docker Run Command

New command added:

```md
## docker run

### What it does
Creates and starts a new Docker container from an image.

### Example

docker run nginx
```

---

# Step 16 — Stage Updated File Again

Command used:

```bash
git add git-commands.md
```

---

# Step 17 — Create Fourth Commit

Command used:

```bash
git commit -m "docs: new add branching commands"
```

Actual output:

```text
[main 6b27e5f] docs: new add branching commands
```

---

# Step 18 — View Compact Commit History

Command used:

```bash
git log --oneline
```

Actual output:

```text
6b27e5f (HEAD -> main) docs: new add branching commands
962ebee docs: add branching commands
5f644cf docs: add Docker command
8b6e806 day-22: add git commands reference
```

---

# Important Git Concepts Learned

## Modified File

A tracked file changed after previous commit.

---

## Staging Area

Temporary holding area before commit.

---

## Commit

Saved project snapshot.

---

## Commit History

Timeline of project changes.

---

# Commands Practiced

```bash
vim git-commands.md
git status
git diff
git add git-commands.md
git diff --staged
git commit -m "message"
git log --oneline
```
---

# Recommended Commit Message Styles
## docs

### Documentation updates:
```bash
docs: update Git notes
```

## feat

### New feature:
```bash
feat: add nginx install script
```

## fix

### Bug fix:
```bash
fix: correct Docker command typo
```

## chore

### Small maintenance changes:
```bash
chore: cleanup markdown formatting
```

---

# Final Conclusion

Task 5 successfully demonstrated:

- editing tracked files
- checking repository changes
- comparing file modifications
- staging updates
- creating multiple commits
- building Git history
- viewing compact commit logs

---

# Task 6: Understand the Git Workflow

## 1. What is the difference between git add and `git commit`?

### `git add`

`git add` moves changes from the working directory to the staging area.

It prepares files for commit but does not permanently save them yet.

Example:
```bash
git add git-commands.md
```

### `git commit`

`git commit` saves the staged changes into Git history as a snapshot.

It permanently records the changes in the repository.

Example:
```bash
git commit -m "docs: update git commands"
```

### Simple Understanding
```text
git add     = prepare changes
git commit  = save changes permanently
```

## 2. What does the staging area do? Why doesn't Git just commit directly?

The staging area is a temporary holding area where changes are prepared before committing.

It allows developers to:
- review changes
- choose specific files
- organize commits properly

Without the staging area:
- every file change would be committed immediately
- commits would become messy and unorganized

The staging area helps create:
- clean commit history
- meaningful commits
- better collaboration

## Workflow
```text
Working Directory
        ↓
git add
        ↓
Staging Area
        ↓
git commit
        ↓
Repository History
```

## 3. What information does git log show you?

`git log` shows the commit history of the repository.

It displays:
- commit hash
- author name
- author email
- commit date
- commit message

Example:
```bash
git log
```
Compact version:
```bash
git log --oneline
```
This shows:
- short commit hash
- short commit message

### Commit hash

A commit hash is a unique identifier automatically generated by Git for every commit. It is used to track and reference commits in repository history.

```text
6b27e5f docs: new add branching commands
962ebee docs: add branching commands
5f644cf docs: add Docker command
8b6e806 day-22: add git commands reference
```
Here:

| Commit Hash | Commit Message                   |
| ----------- | -------------------------------- |
| `6b27e5f`   | docs: new add branching commands |
| `962ebee`   | docs: add branching commands     |


## 4. What is the `.git/` folder and what happens if you delete it?

The `.git/` folder is the hidden directory that stores all Git repository data.

It contains:
- commit history
- branches
- configuration
- logs
- staging information
- repository metadata

It is the brain of Git.

### If You Delete `.git/`

If the `.git/` folder is deleted:

- Git history is lost
- commits disappear
- branches disappear
- repository stops being a Git repository

Your project files remain, but version control is completely removed.

## 5. What is the difference between a working directory, staging area, and repository?
### Working Directory

The working directory is where files are actively created and edited.

Example:
- modifying git-commands.md

### Staging Area

The staging area temporarily stores selected changes before commit.

Files enter staging using:
```bash
git add
```

### Repository

The repository stores permanently committed snapshots and Git history.

Commits are saved using:
```bash
git commit
```

## Simple Diagram
```text
Working Directory
    ↓
(Staged with git add)

Staging Area
    ↓
(Saved with git commit)

Repository
```

## 6. What is `origin`?

`origin` is the default variable/nickname Git gives to the remote GitHub repository.

When you connect your local repository to GitHub:
```bash
git remote add origin git@github.com:username/repository.git
```
Git saves:
```text
origin = GitHub repository address
```

## Example

Your repository:
```text
git@github.com:krmaryum/Git-GitHub-Practice.git
```
is stored internally as:
```text
origin
```
So instead of typing the full GitHub URL every time, Git lets you use:
```text
origin
```
as a shortcut.

### Simple Understanding
```text
origin = nickname for remote GitHub repository
```

## What `git pull origin main` Does

This command means:
```text
Pull latest changes from the main branch of the GitHub repository named origin
```
Git performs two operations:
```text
git fetch
+
git merge
```


## What does `git push` do?

`git push` uploads local commits from the local repository to the remote GitHub repository.

Example:
```bash
git push origin main
```

Meaning:
- local commits are uploaded to GitHub
- remote repository gets updated
- collaboration becomes possible

Workflow:
```text
Local Repository
        ↓
git push
        ↓
Remote GitHub Repository
```

## Workflow
```text
GitHub Repository (origin/main)
            ↓
      git pull
            ↓
Local main branch updated
```

## Verify Remote Repository

You can check remotes using:
```bash
git remote -v
```
### Example output:
```text
origin  git@github.com:krmaryum/Git-GitHub-Practice.git (fetch)
origin  git@github.com:krmaryum/Git-GitHub-Practice.git (push)
```
Meaning:
- origin points to GitHub repository

## Can We Rename origin?

Yes.

Example:
```bash
git remote rename origin github
```

Then commands become:
```bash
git pull github main
```
But almost everyone uses:
```text
origin
```
as the standard remote name.

## Important DevOps Understanding

In team environments:
```text
origin
```
usually means:
- your own fork
- central GitHub repository
- main remote server

Additional remotes may exist:

| Remote   | Purpose                     |
| -------- | --------------------------- |
| origin   | your repository             |
| upstream | original project repository |

### Example:
```bash
git pull upstream main
```
used in open-source collaboration.

## Final Understanding

Task 6 helped explain the core Git workflow:
```text
Edit → Stage → Commit → History
```
This workflow is the foundation of:
- GitHub
- DevOps
- CI/CD
- team collaboration
- infrastructure management
