# Linux Troubleshooting Scenario

# Scenario 3 – Wrong Home Directory Ownership

## Problem

A user reports:

```text
Permission denied
```

when trying to log in.

The administrator checks:

```bash
ls -ld /home/ali
```

Output:

```text
drwx------ root root
```

---

# Goal

Restore the correct ownership and verify that the user can log in successfully.

---

# Why Use the Isolation Method?

The error message:

```text
Permission denied
```

can have many causes.

A beginner may immediately run:

```bash
chown
```

But a professional Linux administrator does not guess.

Instead, they isolate the problem step by step.

Possible causes include:

- User account does not exist
- Home directory is missing
- Wrong home directory path
- Wrong ownership
- Wrong permissions
- Wrong login shell
- Account locked
- Password expired
- Account expired

---

# Step 1 – Gather Information

## Check 1 – Does the User Exist?

Run:

```bash
id ali
```

Expected output:

```text
uid=1002(ali) gid=1002(ali) groups=1002(ali)
```

If the user exists, continue troubleshooting.

If the user does not exist, create the user.

---

## Check 2 – Does the Home Directory Exist?

Run:

```bash
ls -ld /home/ali
```

Current output:

```text
drwx------ root root
```

This confirms:

```text
/home/ali exists
```

So the problem is not a missing home directory.

---

## Check 3 – Is the Home Directory Path Correct?

Run:

```bash
grep "^ali" /etc/passwd
```

Example output:

```text
ali:x:1002:1002::/home/ali:/bin/bash
```

Check the home directory field:

```text
/home/ali
```

Compare:

```text
Configured home directory: /home/ali
Actual home directory:     /home/ali
```

If both match, continue.

If the path is wrong, fix it with:

```bash
sudo usermod -d /home/ali ali
```

---

## Check 4 – Is the Login Shell Valid?

Check:

```bash
grep "^ali" /etc/passwd
```

Look at the last field.

Good shell:

```text
/bin/bash
```

Bad shells for normal login:

```text
/usr/sbin/nologin
/bin/false
```

If the shell is invalid, fix it:

```bash
sudo chsh -s /bin/bash ali
```

---

## Check 5 – Is the Account Locked?

Run:

```bash
passwd -S ali
```

Possible output:

| Status | Meaning |
|--------|---------|
| PS | Password Set |
| LK | Locked |
| NP | No Password |

If output shows:

```text
LK
```

unlock the account:

```bash
sudo passwd -u ali
```

or:

```bash
sudo usermod -U ali
```

---

## Check 6 – Is Ownership Correct?

Run:

```bash
ls -ld /home/ali
```

Current output:

```text
drwx------ root root
```

Expected output:

```text
drwx------ ali ali
```

This is the root cause.

The directory belongs to:

```text
root root
```

but it should belong to:

```text
ali ali
```

---

# Root Cause

The home directory `/home/ali` is owned by `root`.

Because permissions are:

```text
drwx------
```

only the owner can access the directory.

Since the owner is `root`, user `ali` cannot enter or write inside the directory.

That is why the user gets:

```text
Permission denied
```

---

# Why This Happens

This commonly happens when an administrator manually recreates or restores a home directory as root.

Example:

```bash
sudo mkdir /home/ali
sudo cp -a /etc/skel/. /home/ali/
```

If the administrator forgets to run:

```bash
sudo chown -R ali:ali /home/ali
```

then the directory and files may remain owned by `root`.

---

# Solution

## Step 1 – Fix Ownership

Run:

```bash
sudo chown -R ali:ali /home/ali
```

Explanation:

| Part | Meaning |
|------|---------|
| `sudo` | Run as administrator |
| `chown` | Change ownership |
| `-R` | Recursive, apply to all files and directories inside |
| `ali:ali` | Owner = ali, Group = ali |
| `/home/ali` | Target directory |

---

## Step 2 – Fix Permissions

Set secure home directory permissions:

```bash
sudo chmod 700 /home/ali
```

Explanation:

| Permission | Meaning |
|-----------|---------|
| `7` | Owner can read, write, execute |
| `0` | Group has no access |
| `0` | Others have no access |

For a normal private home directory, `700` is secure.

---

# Verification

## Verify Ownership

Run:

```bash
ls -ld /home/ali
```

Expected output:

```text
drwx------ ali ali
```

---

## Verify Detailed Status

Run:

```bash
stat /home/ali
```

Check:

```text
Uid: ali
Gid: ali
```

---

## Test Login

Run:

```bash
su - ali
```

Expected:

```text
ali@server:~$
```

If login succeeds without permission errors, the issue is resolved.

---

# Final Command Set

```bash
id ali
grep "^ali" /etc/passwd
passwd -S ali
ls -ld /home/ali

sudo chown -R ali:ali /home/ali
sudo chmod 700 /home/ali

ls -ld /home/ali
su - ali
```

---

# Troubleshooting Flow

```text
User gets Permission denied
        │
        ▼
Does the user exist?
        │
   No ─────► Create user
        │
       Yes
        │
        ▼
Does home directory exist?
        │
   No ─────► Recreate home directory
        │
       Yes
        │
        ▼
Is home path correct in /etc/passwd?
        │
   No ─────► Fix with usermod -d
        │
       Yes
        │
        ▼
Is login shell valid?
        │
   No ─────► Change shell with chsh
        │
       Yes
        │
        ▼
Is account locked?
        │
   Yes ────► Unlock account
        │
       No
        │
        ▼
Is ownership correct?
        │
   No ─────► chown -R ali:ali /home/ali
        │
       Yes
        │
        ▼
Are permissions correct?
        │
   No ─────► chmod 700 /home/ali
        │
       Yes
        │
        ▼
Test login
        │
        ▼
Document incident
```

---

# Incident Documentation Template

```text
Incident ID:
USR-003

Problem:
User could not log in and received "Permission denied."

Symptoms:
Login failed.
Home directory existed but was inaccessible.

Investigation:
User account existed.
Home directory existed.
Login shell was valid.
Account was not locked.
Home directory ownership was incorrect.

Root Cause:
/home/ali was owned by root:root instead of ali:ali.

Resolution:
sudo chown -R ali:ali /home/ali
sudo chmod 700 /home/ali

Verification:
User logged in successfully using su - ali.

Preventive Action:
Always verify ownership after manually creating or restoring a user home directory.
```

---

# Common Mistake

## Mistake

```bash
sudo mkdir /home/ali
sudo cp -a /etc/skel/. /home/ali/
```

Then forgetting:

```bash
sudo chown -R ali:ali /home/ali
```

## Result

The user receives:

```text
Permission denied
```

---

# Best Practice

Whenever restoring a home directory, always use this workflow:

```bash
sudo mkdir /home/ali
sudo cp -a /etc/skel/. /home/ali/
sudo chown -R ali:ali /home/ali
sudo chmod 700 /home/ali
su - ali
```

---

# RHCSA Tip

In RHCSA-style tasks, if a user cannot access their home directory, always verify:

```bash
ls -ld /home/username
```

Look for:

- Correct owner
- Correct group
- Correct permissions

---

# Interview Tip

If asked:

```text
A user gets Permission denied while logging in. How do you troubleshoot?
```

Do not answer only:

```bash
chown -R user:user /home/user
```

A better answer:

```text
I would verify whether the user exists, check account status, confirm the home directory path, verify login shell, inspect home directory ownership and permissions, then fix the root cause and test login.
```

---

# Roman Urdu Summary

Agar user login karte waqt:

```text
Permission denied
```

dekh raha hai, to zaroori nahi ke password problem ho.

Pehle check karo:

```bash
id ali
ls -ld /home/ali
grep "^ali" /etc/passwd
passwd -S ali
```

Agar output ho:

```text
drwx------ root root
```

to iska matlab hai home directory root ki ownership mein hai.

User `ali` us directory ko access nahi kar sakta.

Fix:

```bash
sudo chown -R ali:ali /home/ali
sudo chmod 700 /home/ali
```

Phir test karo:

```bash
su - ali
```

---

# Quick Memory Trick

```text
Permission denied in home directory
        ↓
Check ownership
        ↓
root root is wrong
        ↓
user user is correct
        ↓
chown -R user:user /home/user
```

---

# One-Line Summary

If a user's home directory exists but is owned by `root:root`, the user may receive `Permission denied`; fix it by restoring ownership with `chown -R username:username /home/username` and verifying login.
