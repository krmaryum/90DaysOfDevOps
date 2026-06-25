# Linux `pwck` Command Study Notes

## What is `pwck`?

The `pwck` command is used to verify the integrity and consistency of user account information stored in:

```text
/etc/passwd
/etc/shadow
```

It checks whether user account records are valid and properly synchronized.

---

# Why Do We Use `pwck`?

System administrators use `pwck` to:

* Verify user account entries
* Detect incorrect account information
* Find missing fields
* Check consistency between `/etc/passwd` and `/etc/shadow`
* Identify missing home directories
* Detect duplicate usernames or UIDs

---

# Basic Syntax

```bash
sudo pwck
```

---

# Read-Only Check

```bash
sudo pwck -r
```

### Purpose

Checks files and reports problems without making changes.

---

# What Files Does `pwck` Check?

### `/etc/passwd`

Contains:

```text
Username
UID
GID
Home Directory
Login Shell
```

### `/etc/shadow`

Contains:

```text
Encrypted Password
Password Aging Information
Account Expiration Information
```

---

# Important Note

`pwck` does NOT accept a username.

### Incorrect

```bash
pwck ali
```

```bash
pwck username
```

These commands will fail.

---

# Checking a Specific User

Use these commands instead:

### Check User in passwd File

```bash
grep '^ali:' /etc/passwd
```

### Check User in shadow File

```bash
sudo grep '^ali:' /etc/shadow
```

### Display User Information

```bash
id ali
```

### Display User Entry

```bash
getent passwd ali
```

---

# Example

Run:

```bash
sudo pwck -r
```

Possible output:

```text
user 'ali': directory '/home/ali' does not exist
pwck: no changes
```

Meaning:

```text
User account exists
Home directory is missing
```

---

# Common Options

## Read-Only Mode

```bash
sudo pwck -r
```

Checks files without making corrections.

---

## Check Alternate Password File

```bash
sudo pwck /tmp/passwd
```

Checks an alternate passwd file.

---

# Related Commands

| Command                | Purpose                       |
| ---------------------- | ----------------------------- |
| `pwck`                 | Check passwd and shadow files |
| `grpck`                | Check group files             |
| `id ali`               | Display user identity         |
| `getent passwd ali`    | Show passwd entry             |
| `grep ali /etc/passwd` | Find user record              |
| `chage -l ali`         | Show password aging           |

---

# Hands-On Lab

## Lab 1: Verify User Database

Run:

```bash
sudo pwck -r
```

Observe:

* Any warnings
* Missing home directories
* Invalid entries

---

## Lab 2: Verify User Exists

```bash
id ali
```

or

```bash
getent passwd ali
```

---

## Lab 3: Verify Password Aging

```bash
sudo chage -l ali
```

Observe:

* Password expiration
* Account expiration
* Warning period

---

# Interview Questions

## What is `pwck`?

`pwck` verifies the integrity and consistency of user account information stored in `/etc/passwd` and `/etc/shadow`.

---

## Does `pwck` Check a Single User?

No.

`pwck` checks the entire user account database.

---

## What Does `pwck -r` Do?

Checks account files in read-only mode without making modifications.

---

## Which Files Are Checked by `pwck`?

```text
/etc/passwd
/etc/shadow
```

---

## What Command Checks Group File Integrity?

```bash
grpck
```

---

# Roman Urdu Summary

```text
pwck command user account files ko check karti hai.

Ye verify karti hai ke:

- /etc/passwd theek hai
- /etc/shadow theek hai
- User entries valid hain
- Home directories aur account information consistent hai

pwck kisi specific username ko check nahi karti.

Ye poori user database ko verify karti hai.
```

---

# Quick Memory Trick

```text
pwck  = Password File Check

grpck = Group File Check
```

---

# One-Line Exam Definition

```text
The pwck command verifies the integrity and consistency of user account information stored in /etc/passwd and /etc/shadow.
```

---

## Similar Commands

| Command | Stands For          | Purpose                       |
| ------- | ------------------- | ----------------------------- |
| `pwck`  | Password File Check | Check passwd and shadow files |
| `grpck` | Group File Check    | Check group files             |
| `vipw`  | Edit Password File  | Safely edit `/etc/passwd`     |
| `vigr`  | Edit Group File     | Safely edit `/etc/group`      |
