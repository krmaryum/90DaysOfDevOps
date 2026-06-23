# Linux Special Permissions and ACL Study Notes

## SUID, SGID, Sticky Bit, and ACL

## What? Why? How? + Hands-On Labs

These notes explain important Linux advanced permission topics:

- SUID
- SGID
- Sticky Bit
- ACL

This guide is useful for Linux Administration, RHCSA Preparation, DevOps Practice, Security Fundamentals, File Permission Management, and Interview Preparation.

---

# Table of Contents

1. Quick Overview
2. Normal Linux Permissions Review
3. SUID
4. SGID
5. Sticky Bit
6. ACL
7. Comparison Table
8. Hands-On Labs
9. Security Notes
10. Interview Questions
11. Roman Urdu Summary
12. Quick Memory Tricks

---

# 1. Quick Overview

Linux has normal permissions:

```text
r = read
w = write
x = execute
```

For:

```text
User
Group
Others
```

Linux also has special permissions:

| Permission | Numeric Value | Symbol | Main Purpose |
|-----------|---------------|--------|--------------|
| SUID | 4 | `s` on user execute | Run as file owner |
| SGID | 2 | `s` on group execute | Inherit group / run as group |
| Sticky Bit | 1 | `t` on others execute | Protect deletion |
| ACL | N/A | `+` in `ls -l` | Advanced user/group permissions |

---

# 2. Normal Linux Permissions Review

Example:

```bash
ls -l file.txt
```

Output:

```text
-rw-r--r-- 1 ali developers 120 Jun 21 file.txt
```

Breakdown:

```text
-          = file type
rw-        = owner permissions
r--        = group permissions
r--        = others permissions
ali        = owner
developers = group
```

Normal permission categories:

```text
Owner
Group
Others
```

Normal permission values:

```text
r = 4
w = 2
x = 1
```

---

# 3. SUID

## What is SUID?

SUID stands for:

```text
Set User ID
```

SUID is a special permission used on executable files.

It allows a program to run with the permissions of the file owner instead of the user who runs it.

Simple definition:

```text
SUID = Run as file owner
```

Numeric value:

```text
4
```

---

## Why Do We Need SUID?

Some normal users need to run commands that require root-level access.

Example:

```bash
passwd
```

A normal user can change their password using `passwd`.

But password information is stored in:

```text
/etc/shadow
```

Only root can modify `/etc/shadow`.

So how can a normal user change password?

Because `/usr/bin/passwd` has SUID enabled.

Check:

```bash
ls -l /usr/bin/passwd
```

Example output:

```text
-rwsr-xr-x 1 root root /usr/bin/passwd
```

The `s` in the owner execute position means SUID is enabled.

---

## How SUID Works

Without SUID:

```text
User runs program
Program runs with user's permissions
```

With SUID:

```text
User runs program
Program runs with file owner's permissions
```

If file owner is root:

```text
Program runs with root privileges
```

---

## How to Set SUID

Symbolic method:

```bash
chmod u+s file
```

Numeric method:

```bash
chmod 4755 file
```

Breakdown:

```text
4 = SUID
755 = rwxr-xr-x
```

---

## How to Check SUID

```bash
ls -l file
```

Example:

```text
-rwsr-xr-x
```

Look for `s` in the owner execute position.

---

## Lowercase `s` vs Uppercase `S`

Lowercase:

```text
-rwsr-xr-x
```

Meaning:

```text
SUID enabled
Owner execute permission exists
```

Uppercase:

```text
-rwSr-xr-x
```

Meaning:

```text
SUID enabled
Owner execute permission missing
```

Uppercase `S` usually indicates a misconfiguration.

---

## Remove SUID

```bash
chmod u-s file
```

or:

```bash
chmod 0755 file
```

---

## Find SUID Files

```bash
find / -perm -4000 -type f 2>/dev/null
```

Common examples:

```text
/usr/bin/passwd
/usr/bin/sudo
/usr/bin/su
```

---

# 4. SGID

## What is SGID?

SGID stands for:

```text
Set Group ID
```

SGID can be used on files and directories.

Most commonly, SGID is used on directories.

When SGID is set on a directory, new files and directories created inside inherit the directory's group ownership.

Simple definition:

```text
SGID = New files inherit directory group
```

Numeric value:

```text
2
```

---

## Why Do We Need SGID?

Suppose there is a shared project directory:

```text
/project
```

Group:

```text
developers
```

Users:

```text
ali
sara
ahmed
```

Without SGID:

```text
Ali creates file -> group may be ali
Sara creates file -> group may be sara
Ahmed creates file -> group may be ahmed
```

This causes inconsistent group ownership.

With SGID:

```text
All files created inside /project inherit group developers.
```

This makes team collaboration easier.

---

## How SGID Works

Directory:

```text
/project
```

Group:

```text
developers
```

SGID enabled:

```bash
chmod 2775 /project
```

Ali creates:

```text
app.py
```

Result:

```text
Owner = ali
Group = developers
```

Sara creates:

```text
config.yml
```

Result:

```text
Owner = sara
Group = developers
```

---

## How to Set SGID

Symbolic method:

```bash
chmod g+s directory
```

Numeric method:

```bash
chmod 2775 directory
```

Breakdown:

```text
2 = SGID
775 = rwxrwxr-x
```

---

## How to Check SGID

```bash
ls -ld directory
```

Example:

```text
drwxrwsr-x
```

Look for `s` in the group execute position.

---

## Lowercase `s` vs Uppercase `S`

Lowercase:

```text
drwxrwsr-x
```

Meaning:

```text
SGID enabled
Group execute permission exists
```

Uppercase:

```text
drwxrwSr-x
```

Meaning:

```text
SGID enabled
Group execute permission missing
```

---

## Remove SGID

```bash
chmod g-s directory
```

or:

```bash
chmod 0775 directory
```

---

# 5. Sticky Bit

## What is Sticky Bit?

Sticky Bit is a special permission mostly used on directories.

It prevents users from deleting or renaming files owned by other users inside a shared directory.

Simple definition:

```text
Sticky Bit = Protect files from deletion by other users
```

Numeric value:

```text
1
```

---

## Why Do We Need Sticky Bit?

Suppose a shared directory has permission:

```text
777
```

Everyone can create files, delete files, and rename files.

Problem:

```text
Ali can delete Sara's files.
Sara can delete Ali's files.
```

Sticky Bit solves this.

With Sticky Bit enabled:

```text
Ali can delete only Ali's files.
Sara can delete only Sara's files.
Root can still delete everything.
```

---

## How Sticky Bit Works

When Sticky Bit is enabled on a directory, files inside can only be deleted by:

```text
File owner
Directory owner
Root user
```

---

## Famous Example: `/tmp`

Check:

```bash
ls -ld /tmp
```

Example:

```text
drwxrwxrwt
```

The last `t` means Sticky Bit is enabled.

Why?

Because many users can create files in `/tmp`, but users should not delete each other's files.

---

## How to Set Sticky Bit

Symbolic method:

```bash
chmod +t directory
```

Numeric method:

```bash
chmod 1777 directory
```

Breakdown:

```text
1 = Sticky Bit
777 = rwxrwxrwx
```

---

## How to Check Sticky Bit

```bash
ls -ld directory
```

Example:

```text
drwxrwxrwt
```

Look for `t` at the end of permissions.

---

## Lowercase `t` vs Uppercase `T`

Lowercase:

```text
drwxrwxrwt
```

Meaning:

```text
Sticky Bit enabled
Others execute permission exists
```

Uppercase:

```text
drwxrwxrwT
```

Meaning:

```text
Sticky Bit enabled
Others execute permission missing
```

---

## Remove Sticky Bit

```bash
chmod -t directory
```

or:

```bash
chmod 0777 directory
```

---

# 6. ACL

## What is ACL?

ACL stands for:

```text
Access Control List
```

ACL provides advanced permissions beyond normal Linux permissions.

Normal Linux permissions allow access control for:

```text
Owner
Group
Others
```

ACL allows access control for specific additional users and groups.

Simple definition:

```text
ACL = Advanced permissions for specific users/groups
```

---

## Why Do We Need ACL?

Suppose file owner is `ali`, group is `developers`, and others have no access.

Now requirement:

```text
Give sara read access.
Give ahmed write access.
Give qa group read access.
Do not change owner or main group.
```

Normal permissions cannot do this cleanly.

ACL solves this problem.

---

## How ACL Works

ACL allows entries like:

```text
user:sara:r--
user:ahmed:rw-
group:qa:r--
```

These permissions are added without changing the file owner or main group.

---

## View ACL

```bash
getfacl file.txt
```

Example:

```text
# file: file.txt
# owner: ali
# group: developers
user::rw-
user:sara:r--
group::r--
mask::r--
other::---
```

---

## Set ACL for User

```bash
setfacl -m u:sara:r file.txt
```

Give read/write:

```bash
setfacl -m u:sara:rw file.txt
```

Give full permission:

```bash
setfacl -m u:sara:rwx file.txt
```

---

## Set ACL for Group

```bash
setfacl -m g:qa:r file.txt
```

---

## Default ACL

Default ACL applies to directories.

It makes new files and directories inside inherit ACL permissions.

Example:

```bash
setfacl -d -m u:sara:rwx project/
```

Verify:

```bash
getfacl project/
```

Look for:

```text
default:user:sara:rwx
```

---

## Remove Specific ACL

Remove user ACL:

```bash
setfacl -x u:sara file.txt
```

Remove group ACL:

```bash
setfacl -x g:qa file.txt
```

---

## Remove All ACLs

```bash
setfacl -b file.txt
```

---

## Remove Default ACLs

```bash
setfacl -k project/
```

---

## Check ACL Indicator

Run:

```bash
ls -l file.txt
```

If ACL exists, you may see:

```text
-rw-r--r--+
```

The `+` means ACL is present.

---

# 7. Comparison Table

| Feature | SUID | SGID | Sticky Bit | ACL |
|--------|------|------|------------|-----|
| Main Purpose | Run as file owner | Inherit group ownership | Protect deletion | Advanced permissions |
| Numeric Value | 4 | 2 | 1 | N/A |
| Common Use | Executable files | Shared directories | Shared writable directories | Specific user/group permissions |
| Symbol | `s` in user execute | `s` in group execute | `t` in others execute | `+` after permissions |
| Example | `/usr/bin/passwd` | `/project` | `/tmp` | `setfacl` |
| Command | `chmod u+s` | `chmod g+s` | `chmod +t` | `setfacl` |

---

# 8. Hands-On Labs

## Lab 1: SUID

Check SUID on `passwd`:

```bash
ls -l /usr/bin/passwd
```

Expected:

```text
-rwsr-xr-x
```

Find SUID files:

```bash
find / -perm -4000 -type f 2>/dev/null
```

---

## Lab 2: SGID

Create group:

```bash
sudo groupadd developers
```

Create users:

```bash
sudo useradd -m ali
sudo useradd -m sara
```

Add users to group:

```bash
sudo usermod -aG developers ali
sudo usermod -aG developers sara
```

Create shared directory:

```bash
sudo mkdir /project
sudo chgrp developers /project
sudo chmod 2775 /project
```

Verify:

```bash
ls -ld /project
```

Expected:

```text
drwxrwsr-x
```

Create file as ali:

```bash
sudo su - ali
touch /project/ali-file.txt
exit
```

Check:

```bash
ls -l /project/ali-file.txt
```

Expected group:

```text
developers
```

---

## Lab 3: Sticky Bit

Create users:

```bash
sudo useradd -m ali
sudo useradd -m sara
```

Create shared directory:

```bash
sudo mkdir /shared
sudo chmod 777 /shared
```

Ali creates file:

```bash
sudo su - ali
touch /shared/ali.txt
exit
```

Sara deletes Ali's file:

```bash
sudo su - sara
rm /shared/ali.txt
exit
```

Now enable Sticky Bit:

```bash
sudo chmod 1777 /shared
```

Verify:

```bash
ls -ld /shared
```

Expected:

```text
drwxrwxrwt
```

Ali creates file again:

```bash
sudo su - ali
touch /shared/ali.txt
exit
```

Sara tries to delete:

```bash
sudo su - sara
rm /shared/ali.txt
```

Expected:

```text
Operation not permitted
```

---

## Lab 4: ACL

Create users:

```bash
sudo useradd -m ali
sudo useradd -m sara
```

Create file:

```bash
touch acl-file.txt
chmod 600 acl-file.txt
```

Give sara read permission:

```bash
setfacl -m u:sara:r acl-file.txt
```

Verify:

```bash
getfacl acl-file.txt
```

Expected:

```text
user:sara:r--
```

Remove ACL:

```bash
setfacl -x u:sara acl-file.txt
```

Remove all ACLs:

```bash
setfacl -b acl-file.txt
```

---

# 9. Security Notes

## SUID Security Risk

SUID can be dangerous if applied to the wrong executable.

A vulnerable SUID root binary may allow privilege escalation.

Find SUID files:

```bash
find / -perm -4000 -type f 2>/dev/null
```

Only trusted binaries should have SUID.

---

## SGID Security Note

SGID is useful for shared directories, but make sure only trusted users are in the group.

Check group members:

```bash
getent group developers
```

---

## Sticky Bit Security Note

Sticky Bit is useful for world-writable directories like `/tmp`.

Without Sticky Bit, users may delete each other's files.

---

## ACL Security Note

ACLs are powerful but can make permissions harder to audit.

Always verify:

```bash
getfacl file.txt
```

---

# 10. Interview Questions

## What is SUID?

SUID is a special permission that allows an executable to run with the permissions of the file owner.

## What is SGID?

SGID is a special permission that causes files created inside a directory to inherit the directory's group ownership.

## What is Sticky Bit?

Sticky Bit prevents users from deleting or renaming files owned by other users inside a shared directory.

## What is ACL?

ACL stands for Access Control List and provides advanced permissions for specific users and groups.

## Which command sets SUID?

```bash
chmod u+s file
chmod 4755 file
```

## Which command sets SGID?

```bash
chmod g+s directory
chmod 2775 directory
```

## Which command sets Sticky Bit?

```bash
chmod +t directory
chmod 1777 directory
```

## Which command shows ACL?

```bash
getfacl file.txt
```

## Which command sets ACL?

```bash
setfacl -m u:sara:r file.txt
```

---

# 11. Roman Urdu Summary

## SUID

SUID ka matlab hai Set User ID.

Agar file root ki hai aur SUID enabled hai, to normal user us program ko root permissions ke sath run kar sakta hai.

Example:

```text
/usr/bin/passwd
```

## SGID

SGID ka matlab hai Set Group ID.

Directory par SGID lagane se new files directory ka group inherit karti hain.

Example:

```bash
chmod 2775 /project
```

## Sticky Bit

Sticky Bit shared directories mein use hota hai.

Ye users ko doosre users ki files delete karne se rokta hai.

Example:

```bash
chmod 1777 /shared
```

## ACL

ACL ka matlab hai Access Control List.

ACL specific users aur groups ko extra permissions dene ke liye use hoti hai.

Example:

```bash
setfacl -m u:sara:r file.txt
```

---

# 12. Quick Memory Tricks

```text
4 = SUID
2 = SGID
1 = Sticky Bit
```

```text
SUID = Run as User Owner
SGID = Shared Group Inheritance
Sticky Bit = Stop Delete
ACL = Advanced Control List
```

```text
SUID symbol = s in user execute
SGID symbol = s in group execute
Sticky symbol = t in others execute
ACL symbol = +
```

---

# One-Line Exam Definitions

## SUID

```text
SUID allows an executable file to run with the permissions of its owner instead of the user executing it.
```

## SGID

```text
SGID on a directory causes newly created files and subdirectories to inherit the directory's group ownership automatically.
```

## Sticky Bit

```text
Sticky Bit on a directory allows users to create files in a shared directory but prevents them from deleting or renaming files owned by other users.
```

## ACL

```text
ACL provides advanced file permissions for specific users and groups beyond the standard owner, group, and others permissions.
```

---

# RHCSA Exam Tips

Remember these commands:

```bash
chmod 4755 file
chmod 2775 directory
chmod 1777 directory
getfacl file
setfacl -m u:user:r file
```

Remember these symbols:

```text
SUID   = -rwsr-xr-x
SGID   = drwxrwsr-x
Sticky = drwxrwxrwt
ACL    = -rw-r--r--+
```

Always verify after changes:

```bash
ls -l
ls -ld directory
getfacl file
```
