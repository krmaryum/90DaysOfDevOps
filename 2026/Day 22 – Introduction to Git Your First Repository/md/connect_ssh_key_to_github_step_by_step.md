# Step-by-Step Guide: Connect SSH Key to GitHub

Author: Khalid Khan

---

# Overview

This guide explains how to connect an SSH key to GitHub step by step.

SSH authentication allows your local machine to securely communicate with GitHub without typing your username and password every time.

After SSH is configured, you can securely use:

```bash
git clone
git pull
git push
```

---

# Step 1 — Check Existing SSH Keys

Run:

```bash
ls -al ~/.ssh
```

Example output:

```text
id_ed25519
id_ed25519.pub
known_hosts
```

Meaning:

- `id_ed25519` is the private key
- `id_ed25519.pub` is the public key
- `known_hosts` stores trusted SSH hosts

---

# Step 2 — Generate New SSH Key

If you do not already have an SSH key, generate one:

```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
```

Example:

```bash
ssh-keygen -t ed25519 -C "krmaryum@yahoo.com"
```

---

# Step 3 — Save the SSH Key

Git asks:

```text
Enter file in which to save the key
```

Press:

```text
Enter
```

to save in the default location:

```text
~/.ssh/id_ed25519
```

---

# Step 4 — Set Passphrase

Git asks:

```text
Enter passphrase
```

You can:

- type a passphrase for extra security
- or press Enter to skip

---

# Step 5 — Start SSH Agent

Run:

```bash
eval "$(ssh-agent -s)"
```

Example output:

```text
Agent pid 1234
```

---

# Step 6 — Add SSH Key to SSH Agent

Run:

```bash
ssh-add ~/.ssh/id_ed25519
```

Example output:

```text
Identity added: /home/khalid/.ssh/id_ed25519
```

---

# Step 7 — Copy Public SSH Key

Run:

```bash
cat ~/.ssh/id_ed25519.pub
```

Example output:

```text
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAA... your_email@example.com
```

Copy the entire output.

Important:

- copy the public key only
- it starts with `ssh-ed25519`
- it usually ends with your email/comment

---

# Step 8 — Open GitHub SSH Settings

There are two ways to open GitHub SSH settings.

## Method 1 — Direct Link

Open:

```text
https://github.com/settings/keys
```

## Method 2 — Navigate Through GitHub

1. Open GitHub
2. Click your profile picture in the top-right corner
3. Click:

```text
Settings
```

4. In the left sidebar, click:

```text
SSH and GPG keys
```

5. Click:

```text
New SSH key
```

---

# GitHub Navigation Flow

```text
Profile Picture
        ↓
Settings
        ↓
SSH and GPG keys
        ↓
New SSH key
```

---

# Step 9 — Add New SSH Key

On the GitHub SSH key page:

## Title

Enter a meaningful title.

Example:

```text
Khalid WSL Laptop
```

## Key Type

Select:

```text
Authentication Key
```

## Key

Paste the public SSH key copied from:

```bash
cat ~/.ssh/id_ed25519.pub
```

---

# Step 10 — Save SSH Key

Click:

```text
Add SSH key
```

GitHub may ask for:

- GitHub password
- two-factor authentication code

---

# Step 11 — Test GitHub SSH Authentication

Run:

```bash
ssh -T git@github.com
```

Expected output:

```text
Hi username! You've successfully authenticated, but GitHub does not provide shell access.
```

Example:

```text
Hi krmaryum! You've successfully authenticated, but GitHub does not provide shell access.
```

---

# Meaning of the SSH Success Message

## Successfully Authenticated

This means:

- GitHub recognized your SSH key
- your local machine can authenticate with GitHub
- SSH setup is working

## GitHub Does Not Provide Shell Access

This means:

- GitHub allows Git authentication
- GitHub does not provide a Linux terminal session
- SSH is only used for Git operations

GitHub allows:

```bash
git clone
git pull
git push
```

GitHub does not allow:

- remote shell login
- server command execution
- Linux terminal access

---

# Step 12 — Verify Repository Uses SSH URL

Inside your Git repository, run:

```bash
git remote -v
```

Expected SSH format:

```text
origin  git@github.com:username/repository.git (fetch)
origin  git@github.com:username/repository.git (push)
```

SSH URLs usually start with:

```text
git@github.com:
```

---

# Step 13 — Change Remote from HTTPS to SSH

If your remote uses HTTPS:

```text
https://github.com/username/repository.git
```

change it to SSH:

```bash
git remote set-url origin git@github.com:username/repository.git
```

Verify:

```bash
git remote -v
```

---

# Step 14 — Test Git Push

Run:

```bash
git push
```

or:

```bash
git push origin main
```

If SSH is working correctly, Git will push without asking for GitHub username and password.

---

# Important Security Notes

## Safe to Share

Public key:

```text
id_ed25519.pub
```

SSH test command:

```bash
ssh -T git@github.com
```

## Never Share

Private key:

```text
id_ed25519
```

Also never share:

- passwords
- tokens
- API keys
- vault files
- secret environment variables

---

# Common Problem: Permission Denied Publickey

Error:

```text
Permission denied (publickey)
```

Possible causes:

- SSH key not added to GitHub
- SSH agent is not running
- wrong SSH key is being used
- remote URL is still HTTPS
- public key was copied incorrectly

Fix:

```bash
ssh-add ~/.ssh/id_ed25519
ssh -T git@github.com
git remote -v
```

---

# Complete Workflow Summary

```text
Check SSH Keys
        ↓
Generate SSH Key
        ↓
Start SSH Agent
        ↓
Add SSH Key to Agent
        ↓
Copy Public Key
        ↓
GitHub Profile Picture
        ↓
Settings
        ↓
SSH and GPG keys
        ↓
New SSH Key
        ↓
Paste Public Key
        ↓
Test SSH Connection
        ↓
Use GitHub with SSH
```

---

# Final Understanding

SSH creates a secure trusted connection between your local machine and GitHub.

After configuration:

- GitHub recognizes your machine
- Git push works securely
- Git pull works securely
- no repeated username/password prompts are needed
- DevOps automation becomes easier
