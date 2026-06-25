# Linux File Permissions – Lecture & Hands-On Lab Notes

# Day Topic: Linux Permissions, Ownership, and ACLs

## Learning Objectives

By the end of this session, students will be able to:

- Understand Linux file permissions
- Explain Read, Write, and Execute permissions
- Understand User, Group, and Others
- Use `ls -l` to view permissions
- Change permissions using `chmod`
- Change ownership using `chown`
- Change group ownership using `chgrp`
- Understand numeric and symbolic permissions
- Understand Linux ACLs
- Use `getfacl` and `setfacl`
- Apply ACLs to users and groups
- Remove ACLs
- Configure default ACLs on directories
- Perform hands-on permission and ACL labs

---

# Table of Contents

1. What are Linux Permissions?
2. Why are Permissions Important?
3. Permission Categories
4. Permission Types
5. Understanding `ls -l`
6. Numeric Permission Method
7. Symbolic Permission Method
8. `chmod` Command
9. `chown` Command
10. `chgrp` Command
11. What is ACL?
12. Why ACL is Needed
13. `getfacl` Command
14. `setfacl` Command
15. User ACL
16. Group ACL
17. Default ACL
18. Remove ACL
19. ACL Mask
20. Real World Examples
21. Hands-On Labs
22. Interview Questions
23. Roman Urdu Summary
24. Quick Memory Tricks

---

# 1. What are Linux Permissions?

Linux permissions determine:

```text
Who can access a file?
Who can modify a file?
Who can execute a file?
```

Permissions are part of Linux security.

Without permissions:

```text
Any user could read files
Any user could modify files
Any user could delete important files
```

---

# 2. Why are Permissions Important?

Permissions help:

- Protect sensitive files
- Secure servers
- Control access
- Prevent accidental changes
- Support multi-user environments
- Protect production systems

Example:

```text
HR files → HR team only
Application files → DevOps team
Logs → Read only
Secrets → Owner only
```

---

# 3. Permission Categories

Linux permissions are assigned to:

| Category | Symbol | Meaning |
|-----------|--------|----------|
| User | `u` | Owner of the file |
| Group | `g` | Members of the file group |
| Others | `o` | Everyone else |
| All | `a` | User + Group + Others |

Example:

```text
-rw-r--r--
```

Breakdown:

```text
rw-   Owner/User
r--   Group
r--   Others
```

---

# 4. Permission Types

| Permission | Symbol | Numeric Value |
|------------|--------|---------------|
| Read | `r` | 4 |
| Write | `w` | 2 |
| Execute | `x` | 1 |

---

## Read Permission

For files:

```text
Allows viewing file content
```

Example:

```bash
cat notes.txt
```

For directories:

```text
Allows listing directory names if execute permission is also present
```

---

## Write Permission

For files:

```text
Allows modifying file content
```

For directories:

```text
Allows creating, deleting, and renaming files inside the directory if execute permission is also present
```

---

## Execute Permission

For files:

```text
Allows running the file as a script or program
```

Example:

```bash
./script.sh
```

For directories:

```text
Allows entering/accessing the directory
```

Example:

```bash
cd project
```

---

# 5. Understanding `ls -l`

Command:

```bash
ls -l
```

Example:

```text
-rw-r--r-- 1 ali developers 250 Jun 13 notes.txt
```

Breakdown:

```text
-           File type
rw-         Owner permissions
r--         Group permissions
r--         Others permissions
ali         File owner
developers File group
250         File size
notes.txt   File name
```

Visual:

```text
-rw-r--r--

Owner  = rw-
Group  = r--
Others = r--
```

---

# 6. Numeric Permission Method

Permission values:

```text
Read    = 4
Write   = 2
Execute = 1
```

Add values to calculate permissions:

| Permission | Calculation | Value |
|------------|-------------|-------|
| rwx | 4+2+1 | 7 |
| rw- | 4+2 | 6 |
| r-x | 4+1 | 5 |
| r-- | 4 | 4 |
| --- | 0 | 0 |

---

## Common Numeric Permissions

| Permission | Meaning |
|------------|---------|
| `777` | Full access for everyone |
| `755` | Owner full, group/others read and execute |
| `744` | Owner full, group/others read only |
| `700` | Owner only |
| `644` | Common file permission |
| `600` | Private/secret file |
| `770` | Owner and group full access, others no access |
| `750` | Owner full, group read/execute, others no access |

---

# 7. Symbolic Permission Method

Symbolic method uses:

```text
u = user
g = group
o = others
a = all
```

Operators:

```text
+ = add permission
- = remove permission
= = set exact permission
```

Examples:

```bash
chmod u+x script.sh
chmod g+w notes.txt
chmod o-r confidential.txt
chmod a+r public.txt
```

---

# 8. `chmod` Command

## What?

`chmod` changes file or directory permissions.

## Why?

To control who can read, write, or execute files.

## How?

### Numeric Method

```bash
chmod 755 script.sh
chmod 644 notes.txt
chmod 600 secrets.txt
chmod 700 private-dir
```

### Symbolic Method

```bash
chmod u+x script.sh
chmod g+w project.txt
chmod o-r confidential.txt
chmod a+r readme.txt
```

---

# 9. `chown` Command

## What?

`chown` changes file owner.

## Why?

To transfer ownership to another user.

## How?

```bash
sudo chown ali file.txt
```

Verify:

```bash
ls -l file.txt
```

Change owner and group together:

```bash
sudo chown ali:developers file.txt
```

Recursive ownership change:

```bash
sudo chown -R ali:developers project/
```

---

# 10. `chgrp` Command

## What?

`chgrp` changes group ownership.

## Why?

To give group-level access to a team.

## How?

```bash
sudo chgrp developers file.txt
```

Verify:

```bash
ls -l file.txt
```

Recursive group change:

```bash
sudo chgrp -R developers project/
```

---

# 11. What is ACL?

ACL means:

```text
Access Control List
```

ACL provides advanced permissions beyond normal Linux permissions.

Normal Linux permissions allow access for only:

```text
Owner
Group
Others
```

ACL allows permissions for specific additional users and groups.

Example:

```text
File owner = ali
Group = developers
Others = no access

But we also want user sara to read the file.
```

This is where ACL is useful.

---

# 12. Why ACL is Needed

Normal permissions are limited.

Example:

```text
Owner: ali
Group: developers
Others: no access
```

Now requirement:

```text
Give user sara read permission
Give user ahmed write permission
Give group qa read permission
Do not change owner or main group
```

This is difficult with only `chmod`.

ACL solves this problem.

---

# 13. `getfacl` Command

## What?

`getfacl` displays ACL permissions of a file or directory.

## Command

```bash
getfacl file.txt
```

Example output:

```text
# file: file.txt
# owner: ali
# group: developers
user::rw-
group::r--
other::---
```

---

# 14. `setfacl` Command

## What?

`setfacl` sets or modifies ACL permissions.

Basic syntax:

```bash
setfacl -m u:username:permissions file
```

Example:

```bash
setfacl -m u:sara:r file.txt
```

Meaning:

```text
Give user sara read permission on file.txt
```

---

# 15. User ACL

## Give User Read Permission

```bash
setfacl -m u:sara:r file.txt
```

Verify:

```bash
getfacl file.txt
```

Expected:

```text
user:sara:r--
```

---

## Give User Read and Write Permission

```bash
setfacl -m u:sara:rw file.txt
```

---

## Give User Execute Permission

```bash
setfacl -m u:sara:x script.sh
```

---

## Give User Full Permission

```bash
setfacl -m u:sara:rwx file.txt
```

---

# 16. Group ACL

## Give Group Read Permission

```bash
setfacl -m g:qa:r file.txt
```

## Give Group Read and Write Permission

```bash
setfacl -m g:qa:rw file.txt
```

## Give Group Full Permission

```bash
setfacl -m g:qa:rwx project/
```

Verify:

```bash
getfacl file.txt
```

---

# 17. Default ACL

Default ACL is used on directories.

It makes new files and folders inside a directory inherit ACL permissions.

## Example

Create shared directory:

```bash
mkdir shared
```

Set default ACL for user sara:

```bash
setfacl -d -m u:sara:rwx shared/
```

Now any new file or directory created inside `shared/` will inherit ACL for sara.

Verify:

```bash
getfacl shared/
```

Expected:

```text
default:user:sara:rwx
```

---

# 18. Remove ACL

## Remove ACL for Specific User

```bash
setfacl -x u:sara file.txt
```

## Remove ACL for Specific Group

```bash
setfacl -x g:qa file.txt
```

## Remove All ACL Entries

```bash
setfacl -b file.txt
```

Verify:

```bash
getfacl file.txt
```

---

# 19. ACL Mask

ACL mask controls maximum effective permissions for named users and groups.

Example output:

```text
user:sara:rwx        #effective:rw-
mask::rw-
```

This means sara was given `rwx`, but effective permission is only `rw-` because the mask limits it.

Change mask:

```bash
setfacl -m m:rwx file.txt
```

Verify:

```bash
getfacl file.txt
```

---

# 20. Real World Examples

## Example 1: Give One Extra User Read Access

```bash
setfacl -m u:sara:r report.txt
```

---

## Example 2: Give DevOps Group Full Access

```bash
setfacl -m g:devops:rwx project/
```

---

## Example 3: Shared Directory with Default ACL

```bash
mkdir team-project
setfacl -m g:developers:rwx team-project/
setfacl -d -m g:developers:rwx team-project/
```

---

## Example 4: Remove All ACLs

```bash
setfacl -b file.txt
```

---

# 21. Hands-On Labs

## Lab 1 – View Basic Permissions

```bash
touch notes.txt
ls -l notes.txt
```

Explain:

```text
Owner permissions
Group permissions
Others permissions
```

---

## Lab 2 – Change Basic Permissions

```bash
chmod 777 notes.txt
ls -l notes.txt

chmod 644 notes.txt
ls -l notes.txt
```

Observe the difference.

---

## Lab 3 – Make Script Executable

Create script:

```bash
nano script.sh
```

Add:

```bash
#!/bin/bash
echo "Hello Linux"
```

Try running:

```bash
./script.sh
```

If permission denied, add execute permission:

```bash
chmod +x script.sh
./script.sh
```

---

## Lab 4 – Change Owner

Create user:

```bash
sudo useradd -m ali
```

Create file:

```bash
touch project.txt
```

Change owner:

```bash
sudo chown ali project.txt
```

Verify:

```bash
ls -l project.txt
```

---

## Lab 5 – Change Group

Create group:

```bash
sudo groupadd developers
```

Change group:

```bash
sudo chgrp developers project.txt
```

Verify:

```bash
ls -l project.txt
```

---

## Lab 6 – Numeric Permissions Practice

```bash
touch private.txt public.txt secret.txt
chmod 700 private.txt
chmod 644 public.txt
chmod 600 secret.txt
ls -l
```

Explain:

```text
700 = owner only
644 = owner write, everyone read
600 = owner read/write only
```

---

## Lab 7 – ACL Basic User Permission

Create users:

```bash
sudo useradd -m sara
sudo useradd -m ali
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

---

## Lab 8 – ACL User Read/Write Permission

```bash
setfacl -m u:sara:rw acl-file.txt
getfacl acl-file.txt
```

Expected:

```text
user:sara:rw-
```

---

## Lab 9 – ACL Group Permission

Create group:

```bash
sudo groupadd qa
```

Give group read permission:

```bash
setfacl -m g:qa:r acl-file.txt
```

Verify:

```bash
getfacl acl-file.txt
```

---

## Lab 10 – Default ACL on Directory

Create directory:

```bash
mkdir acl-shared
```

Set default ACL:

```bash
setfacl -d -m u:sara:rwx acl-shared/
```

Create a file inside:

```bash
touch acl-shared/test.txt
```

Check ACL:

```bash
getfacl acl-shared/test.txt
```

---

## Lab 11 – Remove Specific ACL

Remove sara ACL:

```bash
setfacl -x u:sara acl-file.txt
```

Verify:

```bash
getfacl acl-file.txt
```

---

## Lab 12 – Remove All ACLs

```bash
setfacl -b acl-file.txt
getfacl acl-file.txt
```

---

# 22. Interview Questions

## What is `chmod`?

`chmod` changes file or directory permissions.

---

## What is `chown`?

`chown` changes file owner.

---

## What is `chgrp`?

`chgrp` changes group ownership.

---

## What does `755` mean?

```text
Owner = rwx
Group = r-x
Others = r-x
```

---

## What does `644` mean?

```text
Owner = rw-
Group = r--
Others = r--
```

---

## What is ACL?

ACL stands for Access Control List. It allows advanced permissions for specific users and groups beyond normal owner, group, and others permissions.

---

## Which command shows ACL?

```bash
getfacl file.txt
```

---

## Which command sets ACL?

```bash
setfacl -m u:sara:r file.txt
```

---

## How do you remove ACL for one user?

```bash
setfacl -x u:sara file.txt
```

---

## How do you remove all ACLs?

```bash
setfacl -b file.txt
```

---

## What is default ACL?

Default ACL is applied on directories so that new files and folders inside inherit ACL permissions.

---

# 23. Roman Urdu Summary

Linux permissions system ko secure banati hain.

Teen permission types hoti hain:

```text
Read    = r = 4
Write   = w = 2
Execute = x = 1
```

Teen categories hoti hain:

```text
User
Group
Others
```

Basic commands:

```bash
chmod
chown
chgrp
```

ACL ka matlab hai:

```text
Access Control List
```

ACL normal permissions se advanced hoti hai.

Agar kisi specific user ko permission deni ho bina owner ya group change kiye, to ACL use hoti hai.

Example:

```bash
setfacl -m u:sara:r file.txt
```

Iska matlab:

```text
User sara ko file.txt par read permission do
```

ACL check karne ke liye:

```bash
getfacl file.txt
```

ACL remove karne ke liye:

```bash
setfacl -x u:sara file.txt
```

All ACL remove karne ke liye:

```bash
setfacl -b file.txt
```

---

# 24. Quick Memory Tricks

```text
r = Read = 4
w = Write = 2
x = Execute = 1
```

```text
755

Owner  = 7 = rwx
Group  = 5 = r-x
Others = 5 = r-x
```

```text
chmod  = Change permissions
chown  = Change owner
chgrp  = Change group
getfacl = Get ACL
setfacl = Set ACL
```

---

# 25. Recommended Lecture Flow

1. Start with file security concept
2. Explain user, group, others
3. Explain read, write, execute
4. Show `ls -l`
5. Explain numeric permissions
6. Explain symbolic permissions
7. Practice `chmod`
8. Practice `chown`
9. Practice `chgrp`
10. Introduce ACL
11. Explain why ACL is needed
12. Practice `getfacl`
13. Practice `setfacl`
14. Practice default ACL
15. Practice ACL removal
16. End with interview questions

---

# Conclusion

Linux permissions and ACLs are very important for Linux Administration, RHCSA, DevOps, Security, and Cloud environments.

Basic permissions control access for:

```text
User
Group
Others
```

ACLs provide advanced control for:

```text
Specific users
Specific groups
Default inherited permissions
```

Mastering `chmod`, `chown`, `chgrp`, `getfacl`, and `setfacl` gives strong control over Linux file security.
