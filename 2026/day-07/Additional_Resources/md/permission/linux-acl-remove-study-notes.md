# Linux ACL Removal Study Notes

## Complete Step-by-Step Guide

ACL stands for:

```text
Access Control List
```

ACLs provide advanced permissions beyond normal Linux permissions.

Normal Linux permissions control access for:

```text
Owner
Group
Others
```

ACLs allow permissions for specific users and groups.

Sometimes you add ACL permissions using `setfacl`, and later you need to remove them.

---

# Table of Contents

1. What is ACL?
2. Why Remove ACL?
3. View Existing ACL
4. Remove ACL for One User
5. Remove ACL for One Group
6. Remove All Extended ACLs
7. Remove Default ACLs
8. Remove ACLs Recursively
9. Practical Lab
10. Common ACL Removal Commands
11. Interview Questions
12. Roman Urdu Summary
13. Quick Memory Tricks

---

# 1. What is ACL?

ACL means:

```text
Access Control List
```

ACLs give advanced permissions to specific users and groups.

Example:

```bash
setfacl -m u:sara:rwx file.txt
```

Meaning:

```text
Give user sara read, write, and execute permission on file.txt.
```

---

# 2. Why Remove ACL?

You may need to remove ACLs when:

- User no longer needs access
- Group access should be removed
- File permissions need to be reset
- Troubleshooting permission issues
- Cleaning up old permissions
- Preparing files for production/security

---

# 3. View Existing ACL

Before removing ACLs, always check current ACLs.

```bash
getfacl file.txt
```

Example output:

```text
# file: file.txt
# owner: ali
# group: ali

user::rw-
user:sara:rwx
group::r--
mask::rwx
other::r--
```

The line below is an ACL entry:

```text
user:sara:rwx
```

---

# 4. Remove ACL for One User

```bash
setfacl -x u:sara file.txt
```

Meaning:

```text
Remove ACL entry for user sara from file.txt.
```

Verify:

```bash
getfacl file.txt
```

---

# 5. Remove ACL for One Group

```bash
setfacl -x g:developers file.txt
```

Meaning:

```text
Remove ACL entry for group developers from file.txt.
```

Verify:

```bash
getfacl file.txt
```

---

# 6. Remove All Extended ACLs

```bash
setfacl -b file.txt
```

The `-b` option means:

```text
Remove all extended ACL entries.
```

Before:

```text
user:sara:rwx
group:developers:r-x
```

After:

```text
Only standard owner, group, and other permissions remain.
```

Verify:

```bash
getfacl file.txt
```

---

# 7. Remove Default ACLs

Default ACLs are usually applied to directories.

They allow new files and directories inside that directory to inherit ACL permissions.

Check default ACL:

```bash
getfacl project
```

Example:

```text
default:user:sara:rwx
default:group:developers:rwx
```

Remove default ACLs:

```bash
setfacl -k project
```

The `-k` option means:

```text
Remove default ACLs.
```

Verify:

```bash
getfacl project
```

---

# 8. Remove ACLs Recursively

If you want to remove ACLs from a directory and everything inside it:

```bash
setfacl -Rb project
```

Breakdown:

| Option | Meaning |
|--------|---------|
| `-R` | Recursive |
| `-b` | Remove all extended ACL entries |

Meaning:

```text
Remove ACLs from project directory and all files/subdirectories inside it.
```

---

# 9. Practical Lab

## Step 1: Create Test File

```bash
touch test.txt
```

## Step 2: Create Test User

```bash
sudo useradd -m sara
```

## Step 3: Add ACL

```bash
setfacl -m u:sara:rwx test.txt
```

## Step 4: Verify ACL

```bash
getfacl test.txt
```

Expected line:

```text
user:sara:rwx
```

## Step 5: Remove Specific User ACL

```bash
setfacl -x u:sara test.txt
```

## Step 6: Verify Again

```bash
getfacl test.txt
```

The `user:sara:rwx` entry should be removed.

## Step 7: Add Multiple ACLs

```bash
sudo groupadd developers
setfacl -m u:sara:rw test.txt
setfacl -m g:developers:r test.txt
```

Verify:

```bash
getfacl test.txt
```

## Step 8: Remove All ACLs

```bash
setfacl -b test.txt
```

Verify:

```bash
getfacl test.txt
```

Only normal permissions should remain.

## Step 9: Default ACL Lab

Create directory:

```bash
mkdir project
```

Set default ACL:

```bash
setfacl -d -m u:sara:rwx project
```

Verify:

```bash
getfacl project
```

Expected:

```text
default:user:sara:rwx
```

Remove default ACL:

```bash
setfacl -k project
```

Verify:

```bash
getfacl project
```

Default ACL should be gone.

---

# 10. Common ACL Removal Commands

| Command | Purpose |
|--------|---------|
| `setfacl -x u:sara file.txt` | Remove ACL for user sara |
| `setfacl -x g:developers file.txt` | Remove ACL for group developers |
| `setfacl -b file.txt` | Remove all extended ACLs from file |
| `setfacl -k directory` | Remove default ACLs from directory |
| `setfacl -Rb directory` | Remove ACLs recursively |

---

# 11. Interview Questions

## Q1: How do you remove ACL for one user?

```bash
setfacl -x u:username file.txt
```

Example:

```bash
setfacl -x u:sara file.txt
```

## Q2: How do you remove ACL for one group?

```bash
setfacl -x g:groupname file.txt
```

Example:

```bash
setfacl -x g:developers file.txt
```

## Q3: How do you remove all ACL entries from a file?

```bash
setfacl -b file.txt
```

## Q4: How do you remove default ACLs?

```bash
setfacl -k directory
```

## Q5: How do you remove ACLs recursively?

```bash
setfacl -Rb directory
```

## Q6: Which command shows ACL permissions?

```bash
getfacl file.txt
```

---

# 12. Roman Urdu Summary

ACL remove karne ke liye `setfacl` command use hoti hai.

Agar ek user ki ACL remove karni ho:

```bash
setfacl -x u:sara file.txt
```

Agar ek group ki ACL remove karni ho:

```bash
setfacl -x g:developers file.txt
```

Agar sari ACL remove karni ho:

```bash
setfacl -b file.txt
```

Agar default ACL remove karni ho:

```bash
setfacl -k directory
```

Agar directory ke andar sab files aur subdirectories se ACL remove karni ho:

```bash
setfacl -Rb directory
```

---

# 13. Quick Memory Tricks

```text
-m = Modify/Add ACL
-x = Remove one ACL entry
-b = Remove all ACL entries
-k = Remove default ACL
-R = Recursive
```

---

# One-Line Exam Definition

```text
ACLs can be removed using setfacl: -x removes a specific ACL entry, -b removes all extended ACLs, and -k removes default ACLs.
```

---

# RHCSA Exam Tip

Always verify ACLs before and after changes:

```bash
getfacl file.txt
```

Remember:

```text
getfacl = Get ACL
setfacl = Set/Modify/Remove ACL
```
