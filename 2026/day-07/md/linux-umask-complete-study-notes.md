# Linux `umask` Study Notes

## Complete Step-by-Step Guide

`umask` is an important Linux concept used to control the default permissions of newly created files and directories.

These notes are useful for:

- Linux Administration
- RHCSA Preparation
- DevOps Practice
- Shell Scripting
- Server Security
- Interview Preparation

---

# Table of Contents

1. What is `umask`?
2. What Does `umask` Stand For?
3. Why Do We Need `umask`?
4. How to Check Current `umask`
5. Default Permissions Before `umask`
6. Important Rule: `umask` Removes Permissions
7. Example: `umask 022`
8. Example: `umask 027`
9. Example: `umask 077`
10. Example: `umask 002`
11. Change `umask` Temporarily
12. Change `umask` Permanently
13. `umask` and `/etc/login.defs`
14. Practical Lab
15. Common `umask` Values
16. Interview Questions
17. Roman Urdu Summary
18. Quick Memory Tricks
19. RHCSA Exam Tips

---

# 1. What is `umask`?

`umask` controls the default permissions for newly created files and directories.

When a new file or directory is created, Linux gives it default permissions first, then `umask` removes some permissions.

Simple definition:

```text
umask controls default permissions for new files and directories.
```

---

# 2. What Does `umask` Stand For?

`umask` stands for:

```text
User File Creation Mask
```

You can remember it as:

```text
umask = permission removal mask
```

---

# 3. Why Do We Need `umask`?

Without `umask`, new files and directories may be created with too much access.

Default maximum permissions are:

```text
Files       = 666
Directories = 777
```

That means:

```text
File default       = rw-rw-rw-
Directory default  = rwxrwxrwx
```

This can be insecure.

`umask` removes unnecessary permissions and makes the system more secure.

---

# 4. How to Check Current `umask`

Run:

```bash
umask
```

Example output:

```text
0022
```

You can also view it in symbolic format:

```bash
umask -S
```

Example output:

```text
u=rwx,g=rx,o=rx
```

---

# 5. Default Permissions Before `umask`

Linux starts with these base permissions:

## Files

```text
666
```

Meaning:

```text
rw-rw-rw-
```

Files do not get execute permission by default for security reasons.

## Directories

```text
777
```

Meaning:

```text
rwxrwxrwx
```

Directories need execute permission so users can enter them.

---

# 6. Important Rule: `umask` Removes Permissions

Very important:

```text
umask does not add permissions.
```

It only removes permissions from the default permissions.

Memory rule:

```text
umask = permissions to remove
```

---

# 7. Example: `umask 022`

Check current `umask`:

```bash
umask
```

Example:

```text
0022
```

The first zero is special permission placeholder. Usually we focus on:

```text
022
```

---

## File Calculation

Base file permission:

```text
666
```

Subtract `umask`:

```text
666
-022
----
644
```

Result:

```text
rw-r--r--
```

So new files become:

```text
644
```

---

## Directory Calculation

Base directory permission:

```text
777
```

Subtract `umask`:

```text
777
-022
----
755
```

Result:

```text
rwxr-xr-x
```

So new directories become:

```text
755
```

---

# 8. Example: `umask 027`

`umask 027` is more secure than `022`.

---

## File Calculation

```text
666
-027
----
640
```

Result:

```text
rw-r-----
```

Meaning:

```text
Owner  = read/write
Group  = read only
Others = no access
```

---

## Directory Calculation

```text
777
-027
----
750
```

Result:

```text
rwxr-x---
```

Meaning:

```text
Owner  = full access
Group  = read and execute
Others = no access
```

---

# 9. Example: `umask 077`

`umask 077` is very restrictive.

---

## File Calculation

```text
666
-077
----
600
```

Result:

```text
rw-------
```

Meaning:

```text
Only owner can read/write.
```

---

## Directory Calculation

```text
777
-077
----
700
```

Result:

```text
rwx------
```

Meaning:

```text
Only owner can access the directory.
```

This is useful for private or sensitive accounts.

---

# 10. Example: `umask 002`

`umask 002` is common in shared group environments.

---

## File Calculation

```text
666
-002
----
664
```

Result:

```text
rw-rw-r--
```

---

## Directory Calculation

```text
777
-002
----
775
```

Result:

```text
rwxrwxr-x
```

This allows group members to collaborate.

---

# 11. Change `umask` Temporarily

Temporary change means it applies only to the current shell session.

Command:

```bash
umask 027
```

Verify:

```bash
umask
```

Create a test file:

```bash
touch testfile
ls -l testfile
```

Expected permission:

```text
-rw-r----- 
```

Create a test directory:

```bash
mkdir testdir
ls -ld testdir
```

Expected permission:

```text
drwxr-x---
```

When you close the terminal or log out, the temporary `umask` change is lost.

---

# 12. Change `umask` Permanently

To make `umask` permanent for one user, add it to the user's shell startup file.

For Bash user:

```bash
nano ~/.bashrc
```

Add:

```bash
umask 027
```

Reload:

```bash
source ~/.bashrc
```

Verify:

```bash
umask
```

---

## System-Wide `umask`

For all users, administrators can configure system-wide files such as:

```text
/etc/profile
/etc/bashrc
/etc/login.defs
```

On RHEL/Rocky Linux, `/etc/bashrc` is commonly used for interactive shells.

On Ubuntu, `/etc/profile` and PAM-related settings may also affect login sessions.

---

# 13. `umask` and `/etc/login.defs`

Check `UMASK` setting:

```bash
grep UMASK /etc/login.defs
```

Example:

```text
UMASK 022
```

This value provides default permission behavior for new users/login sessions depending on the system configuration.

Important:

```text
/etc/login.defs mostly affects future/default user settings.
```

For current shell testing, use:

```bash
umask
```

---

# 14. Practical Lab

## Lab 1: Check Current `umask`

```bash
umask
```

Also check symbolic format:

```bash
umask -S
```

---

## Lab 2: Create File and Directory with Current `umask`

```bash
touch file1
mkdir dir1
ls -l file1
ls -ld dir1
```

Observe the permissions.

---

## Lab 3: Change `umask` to 077

```bash
umask 077
```

Create new file and directory:

```bash
touch file2
mkdir dir2
ls -l file2
ls -ld dir2
```

Expected:

```text
file2 = 600
dir2  = 700
```

---

## Lab 4: Change `umask` to 027

```bash
umask 027
```

Create:

```bash
touch file3
mkdir dir3
ls -l file3
ls -ld dir3
```

Expected:

```text
file3 = 640
dir3  = 750
```

---

## Lab 5: Change `umask` to 002

```bash
umask 002
```

Create:

```bash
touch file4
mkdir dir4
ls -l file4
ls -ld dir4
```

Expected:

```text
file4 = 664
dir4  = 775
```

---

## Lab 6: Compare All Files

```bash
ls -l file1 file2 file3 file4
ls -ld dir1 dir2 dir3 dir4
```

Write in your notes:

```text
How did changing umask affect files?
How did changing umask affect directories?
```

---

# 15. Common `umask` Values

| UMASK | New File Permission | New Directory Permission | Meaning |
|------|----------------------|--------------------------|---------|
| `022` | `644` | `755` | Most common default |
| `027` | `640` | `750` | More secure |
| `077` | `600` | `700` | Private access only |
| `002` | `664` | `775` | Shared group environment |

---

# 16. Interview Questions

## Q1: What is `umask`?

`umask` is a permission mask that determines default permissions for newly created files and directories.

---

## Q2: Does `umask` add permissions?

No.

`umask` removes permissions from the default permissions.

---

## Q3: What are the default permissions before applying `umask`?

Files:

```text
666
```

Directories:

```text
777
```

---

## Q4: What permissions result from `umask 022`?

Files:

```text
644
```

Directories:

```text
755
```

---

## Q5: What permissions result from `umask 077`?

Files:

```text
600
```

Directories:

```text
700
```

---

## Q6: Why do files start from `666`, not `777`?

Because Linux does not give execute permission to files by default for security reasons.

Scripts and programs need execute permission added manually:

```bash
chmod +x script.sh
```

---

## Q7: Which command checks current `umask`?

```bash
umask
```

---

## Q8: Which command shows symbolic `umask`?

```bash
umask -S
```

---

# 17. Roman Urdu Summary

`umask` newly created files aur directories ki default permissions control karti hai.

Files ka base permission hota hai:

```text
666
```

Directories ka base permission hota hai:

```text
777
```

`umask` in permissions mein se kuch permissions remove karti hai.

Important point:

```text
umask permissions add nahi karti.
umask permissions remove karti hai.
```

Example:

```text
umask 022
```

File:

```text
666 - 022 = 644
```

Directory:

```text
777 - 022 = 755
```

Yani:

```text
New file = rw-r--r--
New directory = rwxr-xr-x
```

---

# 18. Quick Memory Tricks

```text
umask = remove permissions
```

```text
Files start from 666
Directories start from 777
```

```text
022 = common default
027 = secure
077 = private
002 = group sharing
```

---

# 19. RHCSA Exam Tips

Remember these strongly:

```text
File base permission      = 666
Directory base permission = 777
```

```text
umask 022:
File      = 644
Directory = 755
```

```text
umask 077:
File      = 600
Directory = 700
```

```text
umask 027:
File      = 640
Directory = 750
```

For practical exam/lab:

1. Run `umask`
2. Change `umask`
3. Create file and directory
4. Verify using `ls -l`
5. Explain the result

---

# Conclusion

`umask` is a key Linux security concept.

It controls default permissions for newly created files and directories.

Understanding `umask` is important for:

- RHCSA
- Linux Administration
- DevOps
- Shell Scripting
- Security
- Multi-user systems

One final rule:

```text
umask does not add permissions.
umask removes permissions.
```
