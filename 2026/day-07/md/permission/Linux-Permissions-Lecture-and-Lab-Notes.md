# Linux File Permissions – Lecture & Hands-On Lab Notes

# Day Topic: Linux Permissions

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
- Perform hands-on permission labs

---

# Table of Contents

1. What are Linux Permissions?
2. Why are Permissions Important?
3. Permission Categories
4. Permission Types
5. Understanding `ls -l`
6. Numeric Permission Method
7. Symbolic Permission Method
8. chmod Command
9. chown Command
10. chgrp Command
11. Real World Examples
12. Hands-On Labs
13. Interview Questions
14. Roman Urdu Summary

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
Any user could read
Any user could modify
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

Example:

```text
HR files → HR team only

Application files → DevOps team

Logs → Read only
```

---

# 3. Permission Categories

Linux permissions are assigned to:

| Category | Meaning |
|-----------|----------|
| User (u) | Owner of the file |
| Group (g) | Members of file group |
| Others (o) | Everyone else |
| All (a) | User + Group + Others |

Example:

```text
-rw-r--r--
```

Breakdown:

```text
rw-   Owner
r--   Group
r--   Others
```

---

# 4. Permission Types

| Permission | Symbol | Value |
|------------|--------|--------|
| Read | r | 4 |
| Write | w | 2 |
| Execute | x | 1 |

---

## Read Permission (r)

Allows:

```text
View file contents
```

Example:

```bash
cat notes.txt
```

---

## Write Permission (w)

Allows:

```text
Modify file
Add content
Delete content
```

---

## Execute Permission (x)

Allows:

```text
Run file as a program/script
```

Example:

```bash
./script.sh
```

---

# 5. Understanding ls -l

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
-           = File type
rw-         = Owner permissions
r--         = Group permissions
r--         = Others permissions
```

Visual:

```text
-rw-r--r--

Owner = rw-
Group = r--
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

Examples:

| Permission | Value |
|------------|--------|
| rwx | 7 |
| rw- | 6 |
| r-x | 5 |
| r-- | 4 |
| --- | 0 |

---

## Common Numeric Permissions

| Value | Meaning |
|---------|----------|
| 777 | Full access to everyone |
| 755 | Owner full, others read/execute |
| 744 | Owner full, others read |
| 700 | Owner only |
| 644 | Common file permission |
| 600 | Private file |

---

# 7. Symbolic Permission Method

Examples:

Add execute:

```bash
chmod +x script.sh
```

Remove write:

```bash
chmod -w notes.txt
```

Add group write:

```bash
chmod g+w notes.txt
```

Remove others read:

```bash
chmod o-r notes.txt
```

---

# 8. chmod Command

## What?

Changes file permissions.

## Why?

To control access.

## How?

### Numeric Method

```bash
chmod 755 script.sh
```

```bash
chmod 644 notes.txt
```

### Symbolic Method

```bash
chmod u+x script.sh
```

```bash
chmod g+w project.txt
```

```bash
chmod o-r confidential.txt
```

---

# 9. chown Command

## What?

Changes file owner.

## Why?

Transfer ownership to another user.

## How?

```bash
sudo chown ali file.txt
```

Verify:

```bash
ls -l file.txt
```

---

Change owner and group:

```bash
sudo chown ali:developers file.txt
```

---

# 10. chgrp Command

## What?

Changes file group.

## Why?

Give group access to another team.

## How?

```bash
sudo chgrp developers file.txt
```

Verify:

```bash
ls -l file.txt
```

---

# 11. Real World Examples

## Example 1

Make script executable:

```bash
chmod +x deploy.sh
```

Run:

```bash
./deploy.sh
```

---

## Example 2

Protect private file:

```bash
chmod 600 secrets.txt
```

Only owner can read/write.

---

## Example 3

Shared project folder:

```bash
sudo chgrp developers project
chmod 770 project
```

---

# 12. Hands-On Labs

## Lab 1 – View Permissions

Create file:

```bash
touch notes.txt
```

Check:

```bash
ls -l notes.txt
```

---

## Lab 2 – Change Permissions

```bash
chmod 777 notes.txt
ls -l notes.txt
```

Then:

```bash
chmod 644 notes.txt
ls -l notes.txt
```

Observe difference.

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

Check:

```bash
ls -l script.sh
```

Add execute:

```bash
chmod +x script.sh
```

Run:

```bash
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

Assign group:

```bash
sudo chgrp developers project.txt
```

Verify:

```bash
ls -l project.txt
```

---

## Lab 6 – Numeric Permissions Practice

Apply:

```bash
chmod 700 private.txt
chmod 755 script.sh
chmod 644 notes.txt
```

Verify:

```bash
ls -l
```

Explain results.

---

## Lab 7 – Interview Practice

Create:

```bash
touch confidential.txt
```

Set:

```bash
chmod 600 confidential.txt
```

Question:

```text
Who can read this file?
```

Answer:

```text
Only owner
```

---

# 13. Interview Questions

## What is chmod?

Used to change file permissions.

---

## What is chown?

Used to change file ownership.

---

## What is chgrp?

Used to change group ownership.

---

## What does 755 mean?

```text
Owner = rwx
Group = r-x
Others = r-x
```

---

## What does 644 mean?

```text
Owner = rw-
Group = r--
Others = r--
```

---

## What does chmod +x do?

Adds execute permission.

---

# 14. Roman Urdu Summary

Linux permissions system ko secure banati hain.

Teen permission types:

```text
Read (r)
Write (w)
Execute (x)
```

Teen categories:

```text
User
Group
Others
```

Commands:

```bash
chmod
chown
chgrp
```

Common permissions:

```text
755 = Script

644 = File

700 = Private folder

600 = Secret file
```

---

# Quick Memory Trick

```text
r = Read = 4

w = Write = 2

x = Execute = 1
```

```text
755

Owner = 7 = rwx

Group = 5 = r-x

Others = 5 = r-x
```

---

# Conclusion

Linux permissions are one of the most important Linux Administration topics. Understanding permissions is essential for RHCSA, DevOps, System Administration, Security, and Cloud environments.
