# Git Bash + GitHub SSH Setup Guide (A to Z)

# Step 1: Download Git Bash

Go to:

https://git-scm.com/download/win

Download the Windows installer.

---

# Step 2: Run Installer

Open the downloaded `.exe` file.

Click:

- Next
- Next
- Next

through setup.

---

# Step 3: Important Installation Options

## PATH Option

Select:

Git from command line and also from 3rd-party software

## HTTPS Backend

Select:

Use the OpenSSL library

## Line Ending Option

Select:

Checkout Windows-style, commit Unix-style line endings

---

# Step 4: Finish Installation

Click:

Install

Then:

Finish

---

# Step 5: Open Git Bash

Open from:

Start Menu → Git Bash

---

# Step 6: Verify Git Installation

Run:

```bash
git --version
```

Example output:

```text
git version 2.54.0.windows.1
```

---

# Step 7: Configure Git Username

Run:

```bash
git config --global user.name "Your Name"
```

Example:

```bash
git config --global user.name "Khalid Khan"
```

---

# Step 8: Configure Git Email

Run:

```bash
git config --global user.email "your@email.com"
```

Example:

```bash
git config --global user.email "krmaryum@yahoo.com"
```

---

# Step 9: Verify Git Configuration

Run:

```bash
git config --global --list
```

---

# Step 10: Generate SSH Key

Run:

```bash
ssh-keygen -t ed25519 -C "krmaryum@yahoo.com"
```

---

# Step 11: Save SSH Key

When prompted:

```text
Enter file in which to save the key
(/c/Users/PC/.ssh/id_ed25519):
```

Press Enter.

---

# Step 12: Set Passphrase

When prompted:

```text
Enter passphrase (empty for no passphrase):
```

Press Enter for learning/demo setup.

---

# Step 13: SSH Key Generated

Two files are created:

| File | Purpose |
|---|---|
| id_ed25519 | Private key (KEEP SECRET) |
| id_ed25519.pub | Public key (share with GitHub) |

---

# Step 14: Display Public Key

Run:

```bash
cat ~/.ssh/id_ed25519.pub
```

Copy the entire output.

---

# Step 15: Open GitHub

Go to:

https://github.com

---

# Step 16: Open Settings

Profile picture → Settings

---

# Step 17: Open SSH and GPG Keys

Left sidebar → SSH and GPG keys

---

# Step 18: Add SSH Key

Click:

New SSH key

---

# Step 19: Fill Details

## Title

Example:

My Laptop

## Key Type

Keep:

Authentication Key

## Key

Paste copied public key.

---

# Step 20: Save

Click:

Add SSH key

---

# Step 21: Test Connection

Run:

```bash
ssh -T git@github.com
```

If prompted:

```text
Are you sure you want to continue connecting?
```

Type:

```text
yes
```

---

# Step 22: Success Message

You should see:

```text
Hi <username>! You've successfully authenticated
```

GitHub SSH setup is complete.

---

# Useful Commands

## Check Git Version

```bash
git --version
```

## Check Git Config

```bash
git config --global --list
```

## Show Public Key

```bash
cat ~/.ssh/id_ed25519.pub
```

## Test GitHub SSH

```bash
ssh -T git@github.com
```
