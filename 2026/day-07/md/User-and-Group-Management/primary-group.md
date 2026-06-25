# Linux Primary Group Study Notes

## Complete Step-by-Step Guide

Primary Group is one of the most important Linux user management concepts.

These notes are useful for:

- Linux Administration
- RHCSA Preparation
- DevOps Practice
- User Management
- Permissions Management
- Interview Preparation

---

# Table of Contents

1. What is a Primary Group?
2. Why Do We Need a Primary Group?
3. How Does a Primary Group Work?
4. Primary Group vs Secondary Group
5. Check Primary Group
6. Change Primary Group
7. Real-World Examples
8. Practical Labs
9. Verification Commands
10. Interview Questions
11. Roman Urdu Summary
12. Quick Memory Tricks

---

# 1. What is a Primary Group?

A Primary Group is the default group assigned to a user account.

Every Linux user has:

```text
User Account
     +
Primary Group
```

When a user creates a new file or directory, Linux normally assigns that file to the user's primary group.

Example:

```bash
id ali
```

Output:

```text
uid=1001(ali) gid=1001(ali) groups=1001(ali)
```

Here:

```text
User = ali
UID  = 1001

Primary Group = ali
GID = 1001
```

The GID shown after UID represents the user's primary group.

---

# 2. Why Do We Need a Primary Group?

Primary groups help Linux:

- Organize users
- Manage permissions efficiently
- Simplify access control
- Support team collaboration
- Manage shared files

Without groups:

```text
Permissions would have to be assigned user by user.
```

With groups:

```text
Assign permissions once to the group.
```

This makes administration easier.

---

# 3. How Does a Primary Group Work?

## Step 1: Create a User

```bash
sudo useradd -m ali
```

Linux creates:

```text
User: ali
Primary Group: ali
```

---

## Step 2: Verify User Information

```bash
id ali
```

Example:

```text
uid=1001(ali) gid=1001(ali) groups=1001(ali)
```

Notice:

```text
gid=1001(ali)
```

This is the primary group.

---

## Step 3: Login as User

```bash
su - ali
```

Create a file:

```bash
touch file1
```

Check:

```bash
ls -l file1
```

Output:

```text
-rw-r--r-- 1 ali ali 0 Jun 15 file1
```

Notice:

```text
Owner = ali
Group = ali
```

The file automatically gets the user's primary group.

---

# 4. Primary Group vs Secondary Group

Create a group:

```bash
sudo groupadd developers
```

Add user:

```bash
sudo usermod -aG developers ali
```

Check:

```bash
id ali
```

Output:

```text
uid=1001(ali)
gid=1001(ali)
groups=1001(ali),1002(developers)
```

---

## Primary Group

```text
ali
```

---

## Secondary Group

```text
developers
```

Difference:

| Primary Group | Secondary Group |
|--------------|----------------|
| Default group | Additional group |
| Files normally inherit this group | Used for additional access |
| One primary group | Multiple secondary groups possible |

---

# 5. Check Primary Group

Using:

```bash
id ali
```

or

```bash
groups ali
```

or

```bash
grep '^ali:' /etc/passwd
```

Example:

```text
ali:x:1001:1001::/home/ali:/bin/bash
```

Breakdown:

```text
Username = ali
UID      = 1001
GID      = 1001
```

The GID field represents the primary group.

---

# 6. Change Primary Group

Create new group:

```bash
sudo groupadd devops
```

Assign it as primary group:

```bash
sudo usermod -g devops ali
```

Verify:

```bash
id ali
```

Output:

```text
uid=1001(ali)
gid=1002(devops)
```

Now:

```text
Primary Group = devops
```

---

# 7. Real-World Example

Company structure:

```text
Developers
Admins
QA
DevOps
```

User:

```text
Ali
```

Primary Group:

```text
Developers
```

Files created by Ali:

```text
app.py
README.md
config.yml
```

Automatically belong to:

```text
developers
```

This makes collaboration easier.

---

# 8. Practical Labs

## Lab 1: Create User

```bash
sudo useradd -m ali
```

Verify:

```bash
id ali
```

---

## Lab 2: Create Group

```bash
sudo groupadd developers
```

Verify:

```bash
getent group developers
```

---

## Lab 3: Add Secondary Group

```bash
sudo usermod -aG developers ali
```

Verify:

```bash
id ali
```

---

## Lab 4: Change Primary Group

Create:

```bash
sudo groupadd devops
```

Change:

```bash
sudo usermod -g devops ali
```

Verify:

```bash
id ali
```

---

## Lab 5: Create File

Login:

```bash
su - ali
```

Create:

```bash
touch project.txt
```

Check:

```bash
ls -l project.txt
```

Observe:

```text
File group = Primary Group
```

---

# 9. Verification Commands

| Command | Purpose |
|----------|----------|
| `id ali` | Show UID, GID, and groups |
| `groups ali` | Show group membership |
| `getent group devops` | Show group entry |
| `grep '^ali:' /etc/passwd` | Show user entry |
| `ls -l file` | Check file ownership and group |

---

# 10. Interview Questions

## What is a Primary Group?

A primary group is the default group assigned to a user account.

---

## Why is it used?

To simplify permission management and group-based access control.

---

## How do you check a user's primary group?

```bash
id username
```

---

## How do you change a primary group?

```bash
usermod -g groupname username
```

Example:

```bash
sudo usermod -g devops ali
```

---

## Can a user have multiple groups?

Yes.

A user can have:

```text
1 Primary Group
Multiple Secondary Groups
```

---

# 11. Roman Urdu Summary

Primary group user ka default ya main group hota hai.

Jab user koi nayi file create karta hai:

```text
File automatically primary group ko assign ho jati hai.
```

Primary group permissions aur collaboration manage karne ke liye use hota hai.

Check:

```bash
id ali
```

Change:

```bash
sudo usermod -g devops ali
```

---

# 12. Quick Memory Tricks

```text
Primary Group = Default Group
```

```text
New File → Gets Primary Group
```

```text
-g = Change Primary Group
```

```text
-aG = Add Secondary Group
```

---

# One-Line Exam Definition

A Primary Group is the default group assigned to a user account, and newly created files normally inherit this group.

---

# RHCSA Exam Tip

Remember:

```text
id username
```

Shows:

```text
UID
Primary Group (GID)
Secondary Groups
```

And:

```bash
usermod -g groupname username
```

Changes the Primary Group.