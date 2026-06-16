# Linux User Management Troubleshooting Lab

# Scenario: Deleted Home Directory but User Still Exists

This is a very common Linux Administration and RHCSA troubleshooting scenario.

---

# Objective

Understand the difference between:

```text
Deleting a user's home directory
```

and

```text
Deleting a user account
```

Many beginners think deleting `/home/username` removes the user.

It does not.

---

# Lab Environment

User:

```text
ali
```

Home Directory:

```text
/home/ali
```

Current User:

```text
root
```

Current Directory:

```bash
pwd
```

Output:

```text
/home
```

---

# Step 1: Create User

Create user:

```bash
useradd -m ali
```

Set password:

```bash
passwd ali
```

Verify:

```bash
id ali
```

Example Output:

```text
uid=1001(ali) gid=1001(ali) groups=1001(ali)
```

Verify home directory:

```bash
ls -ld /home/ali
```

Example:

```text
drwx------ 2 ali ali 4096 Jun 16 12:00 /home/ali
```

---

# Step 2: Simulate Mistake

Move to:

```bash
cd /home
```

Verify:

```bash
pwd
```

Output:

```text
/home
```

Now accidentally delete Ali's home directory:

```bash
rm -rf ali
```

or

```bash
rm -rf /home/ali
```

---

# Step 3: Verify What Happened

Check:

```bash
ls /home
```

Ali directory is gone.

Check:

```bash
ls -ld /home/ali
```

Output:

```text
ls: cannot access '/home/ali': No such file or directory
```

---

# Step 4: Check User Account

Run:

```bash
id ali
```

Output:

```text
uid=1001(ali) gid=1001(ali) groups=1001(ali)
```

Important:

```text
User still exists.
```

Only the home directory was deleted.

---

# Step 5: Attempt to Create User Again

Run:

```bash
useradd ali
```

Output:

```text
useradd: user 'ali' already exists
```

Why?

Because:

```text
The user account still exists in:
/etc/passwd
/etc/shadow
```

Only the home directory was removed.

---

# Understanding the Problem

Many Linux administrators confuse:

```text
Deleting a directory
```

with

```text
Deleting a user account
```

These are completely different operations.

---

# What rm -rf Actually Deletes

Command:

```bash
rm -rf /home/ali
```

Deletes:

```text
Files
Directories
Documents
Downloads
Scripts
```

Inside:

```text
/home/ali
```

But does NOT delete:

```text
User account
Password
UID
GID
Group membership
```

---

# Verify User Exists

Method 1:

```bash
id ali
```

Method 2:

```bash
getent passwd ali
```

Method 3:

```bash
grep '^ali:' /etc/passwd
```

Example:

```text
ali:x:1001:1001::/home/ali:/bin/bash
```

---

# Solution 1: Recreate Home Directory

If you want to keep the existing user account:

Create home directory:

```bash
mkdir /home/ali
```

Set ownership:

```bash
chown ali:ali /home/ali
```

Set permissions:

```bash
chmod 700 /home/ali
```

Verify:

```bash
ls -ld /home/ali
```

Output:

```text
drwx------ 2 ali ali
```

Problem solved.

---

# Solution 2: Remove User and Recreate

If you want a completely fresh user:

Delete user:

```bash
userdel ali
```

Verify:

```bash
id ali
```

Output:

```text
id: ali: no such user
```

Now recreate:

```bash
useradd -m ali
```

Set password:

```bash
passwd ali
```

Verify:

```bash
id ali
```

---

# Difference Between userdel and rm -rf

| Command | Removes Home Directory | Removes User Account |
|----------|----------|----------|
| `rm -rf /home/ali` | Yes | No |
| `userdel ali` | No | Yes |
| `userdel -r ali` | Yes | Yes |

---

# Important RHCSA Exam Point

Command:

```bash
userdel ali
```

Removes:

```text
User account
```

Keeps:

```text
/home/ali
```

Command:

```bash
userdel -r ali
```

Removes:

```text
User account
Home directory
Mail spool
```

---

# Troubleshooting Checklist

User says:

```text
I deleted the home directory.
Now useradd says user already exists.
```

Check:

```bash
id username
```

If user exists:

Option A:

```bash
mkdir /home/username
chown username:username /home/username
```

Option B:

```bash
userdel username
useradd -m username
```

---

# Interview Question

## Scenario

You accidentally ran:

```bash
rm -rf /home/ali
```

Now:

```bash
useradd ali
```

returns:

```text
user already exists
```

Why?

### Answer

```text
The home directory was deleted,
but the user account still exists in
/etc/passwd and /etc/shadow.
```

---

# Roman Urdu Summary

```text
Agar aap:

rm -rf /home/ali

chalate hain,

to sirf Ali ka home directory delete hota hai.

User account delete nahi hota.

Is liye:

useradd ali

error deta hai:

user already exists

Solution:

Ya to home directory dobara create karo:

mkdir /home/ali
chown ali:ali /home/ali

Ya user ko delete karke dobara banao:

userdel ali
useradd -m ali
```

---

# Quick Memory Trick

```text
rm -rf /home/ali

Deletes Files
NOT User
```

```text
userdel ali

Deletes User
NOT Home Directory
```

```text
userdel -r ali

Deletes User
AND Home Directory
```

---

# One-Line Exam Definition

Deleting a user's home directory with `rm -rf` removes the files but does not remove the user account from the system.

---

# Advanced User Decommissioning

## Does `userdel -r` Remove Everything?

Many administrators think:

```bash
sudo userdel -r ali
```

removes everything belonging to the user.

This is not always true.

Typically it removes:

```text
User account
Password entry
Home directory
Mail spool
```

Usually:

```text
/etc/passwd entry
/etc/shadow entry
/home/ali
/var/mail/ali
```

---

# Files That May Remain

If the user created files outside the home directory:

```text
/opt
/var/www
/data
/shared
/tmp
```

those files may still exist.

Example:

```bash
sudo find / -user ali 2>/dev/null
```

Output:

```text
/opt/project/script.sh
/data/report.txt
/var/www/html/index.html
```

These files are not automatically removed by `userdel -r`.

---

# Find Everything Owned by a User

Before deleting the user:

```bash
sudo find / -user ali 2>/dev/null
```

Save report:

```bash
sudo find / -user ali > ali-files.txt
```

This creates an audit report of all files owned by the user.

---

# Find Everything Owned by User Group

```bash
sudo find / -group ali 2>/dev/null
```

Useful when files belong to the user's primary group.

---

# Count Files and Directories Owned by a User

Count everything:

```bash
sudo find / -user ali 2>/dev/null | wc -l
```

Count directories only:

```bash
sudo find / -user ali -type d 2>/dev/null | wc -l
```

Count files only:

```bash
sudo find / -user ali -type f 2>/dev/null | wc -l
```

---

# Backup User Data Before Removal

Create backup:

```bash
sudo tar czf ali-backup.tar.gz /home/ali
```

Verify:

```bash
ls -lh ali-backup.tar.gz
```

This is recommended before deleting employee accounts.

---

# Delete User

```bash
sudo userdel -r ali
```

Removes:

```text
User account
Home directory
Mail spool
```

---

# Find Remaining Files After Deletion

First determine UID before deletion:

```bash
id ali
```

Example:

```text
uid=1001(ali)
```

After deletion:

```bash
sudo find / -uid 1001 2>/dev/null
```

Example:

```text
/opt/project/script.sh
/data/report.txt
```

These are orphaned files.

---

# Remove Remaining Files

Carefully review first:

```bash
sudo find / -uid 1001
```

Remove:

```bash
sudo find / -uid 1001 -delete
```

⚠️ Always verify before using `-delete`.

---

# Professional Linux Administrator Workflow

```bash
id ali

sudo find / -user ali > ali-files.txt

sudo tar czf ali-backup.tar.gz /home/ali

sudo userdel -r ali

sudo find / -uid 1001
```

This workflow ensures:

```text
Backup created
User removed
Home directory removed
Remaining files identified
```

---

# RHCSA Exam Notes

Remember:

```text
rm -rf /home/ali
```

Deletes:

```text
Files
Directories
```

Does NOT delete:

```text
User account
Password
UID
GID
```

---

```text
userdel ali
```

Deletes:

```text
User account
```

Keeps:

```text
Home directory
```

---

```text
userdel -r ali
```

Deletes:

```text
User account
Home directory
Mail spool
```

---

# One-Line Exam Definition

`userdel -r` removes the user account, home directory, and mail spool, but may not remove files owned by the user elsewhere on the filesystem.