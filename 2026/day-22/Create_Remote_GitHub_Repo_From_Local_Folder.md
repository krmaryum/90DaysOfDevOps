# Create a Remote GitHub Repository from an Existing Local Folder

## Study Notes

## Goal

You already have a folder on your laptop and you want to upload it to a new GitHub repository.

Example local folder:

```text
C:\Linux\MyProject
```

Example GitHub repository:

```text
https://github.com/krmaryum/MyProject
```

---

## Important Concept

If the project already exists on your laptop, you do **not** need to clone it.

You only need to:

1. Create an empty repository on GitHub
2. Initialize Git in your local folder
3. Add and commit your files
4. Connect the local folder to the GitHub remote repository
5. Push your code to GitHub

---

# Step 1: Create a New Repository on GitHub

1. Go to GitHub.
2. Click the plus sign `+`.
3. Click **New repository**.
4. Enter the repository name.
5. Choose **Public** or **Private**.

## Important

Do **not** select these options if your local folder already has files:

```text
Add a README file
Add .gitignore
Choose a license
```

Keep the GitHub repository empty.

Then click:

```text
Create repository
```

---

# Step 2: Open Terminal in Your Local Folder

Using Git Bash:

```bash
cd /c/Linux/MyProject
```

Using PowerShell:

```powershell
cd C:\Linux\MyProject
```

---

# Step 3: Check if Git is Already Initialized

Run:

```bash
git status
```

If you see:

```text
fatal: not a git repository
```

then Git is not initialized yet.

Run:

```bash
git init
```

If `git status` works normally, then Git is already initialized and you can skip `git init`.

---

# Step 4: Add Files to Staging Area

Run:

```bash
git add .
```

This stages all files for the first commit.

Check status:

```bash
git status
```

You should see files under:

```text
Changes to be committed
```

---

# Step 5: Create the First Commit

Run:

```bash
git commit -m "Initial commit"
```

This creates the first snapshot of your project in Git history.

---

# Step 6: Rename Branch to Main

Run:

```bash
git branch -M main
```

This makes your local branch name:

```text
main
```

---

# Step 7: Add the Remote Repository

SSH format:

```bash
git remote add origin git@github.com:krmaryum/MyProject.git
```

HTTPS format:

```bash
git remote add origin https://github.com/krmaryum/MyProject.git
```

For your setup, SSH is usually better because you already use SSH keys.

---

# Step 8: Verify Remote URL

Run:

```bash
git remote -v
```

Expected output:

```text
origin  git@github.com:krmaryum/MyProject.git (fetch)
origin  git@github.com:krmaryum/MyProject.git (push)
```

---

# Step 9: Push Local Folder to GitHub

Run:

```bash
git push -u origin main
```

This uploads your local commits to GitHub.

The `-u` means Git will remember the upstream branch, so next time you can simply run:

```bash
git push
```

---

# Complete Command Summary

```bash
cd /c/Linux/MyProject
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin git@github.com:krmaryum/MyProject.git
git push -u origin main
```

---

# If Git is Already Initialized

If your folder already has Git initialized, use this shorter workflow:

```bash
cd /c/Linux/MyProject
git status
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin git@github.com:krmaryum/MyProject.git
git push -u origin main
```

---

# Common Errors and Fixes

## Error: src refspec main does not match any

This means there is no commit yet.

Fix:

```bash
git add .
git commit -m "Initial commit"
git push -u origin main
```

---

## Error: remote origin already exists

This means a remote is already added.

Check remote:

```bash
git remote -v
```

Change remote URL:

```bash
git remote set-url origin git@github.com:krmaryum/MyProject.git
```

---

## Error: Repository not found

Possible reasons:

- Repository name is wrong
- GitHub username is wrong
- You do not have access
- The repository was not created on GitHub

Check:

```bash
git remote -v
```

---

## Error: not a git repository

This means you are not inside a Git repository.

Fix:

```bash
cd /path/to/project
git init
```

---

# Git Workflow Diagram

```text
Local Folder
     |
     v
git init
     |
     v
git add .
     |
     v
git commit -m "Initial commit"
     |
     v
git remote add origin <GitHub URL>
     |
     v
git push -u origin main
     |
     v
GitHub Repository
```

---

# Important Notes

## Do not use git clone in this situation

Use `git clone` only when the repository already exists on GitHub and you want to download it to your laptop.

If the folder already exists on your laptop, use:

```bash
git init
git remote add origin
git push
```

---

# Quick Memory Trick

```text
Existing folder on laptop:
git init → git add → git commit → git remote add → git push

Existing repository on GitHub:
git clone
```

---

# Key Takeaways

- `git init` starts Git tracking in an existing local folder.
- `git add .` stages all files.
- `git commit` saves files in local Git history.
- `git remote add origin` connects your local repo to GitHub.
- `git push -u origin main` uploads the project to GitHub.
- Do not initialize with README on GitHub if your local folder already has files.
