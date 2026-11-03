# `/etc/login.defs` Complete Study Notes

## What is `/etc/login.defs`?

`/etc/login.defs` is a Linux configuration file that defines default login and user account settings.

Simple meaning:

```text
/etc/login.defs = Login defaults configuration file
```

It is used for default values related to:

- User accounts
- Password aging
- UID ranges
- GID ranges
- Home directory behavior
- UMASK
- Mail directory
- Login-related policies

---

## Why is `/etc/login.defs` Important?

This file helps Linux administrators keep user account settings consistent.

It defines defaults such as:

```text
How long passwords are valid
When users get password expiry warnings
Which UID range is used for normal users
Which GID range is used for normal groups
Default permissions for new files and directories
```

It is important for:

- Linux Administration
- RHCSA preparation
- DevOps practice
- Security
- Compliance
- User management

---

## View the File

```bash
cat /etc/login.defs
```

Better way:

```bash
less /etc/login.defs
```

Search password settings:

```bash
grep PASS /etc/login.defs
```

Search UID settings:

```bash
grep UID /etc/login.defs
```

Search GID settings:

```bash
grep GID /etc/login.defs
```

Search UMASK:

```bash
grep UMASK /etc/login.defs
```

---

## Common Settings in `/etc/login.defs`

| Setting | Purpose |
|--------|---------|
| `PASS_MAX_DAYS` | Maximum password age |
| `PASS_MIN_DAYS` | Minimum days before password can be changed |
| `PASS_WARN_AGE` | Warning days before password expires |
| `UID_MIN` | First UID for regular users |
| `UID_MAX` | Maximum UID for regular users |
| `GID_MIN` | First GID for regular groups |
| `GID_MAX` | Maximum GID for regular groups |
| `CREATE_HOME` | Controls home directory creation |
| `UMASK` | Default permission mask |
| `MAIL_DIR` | Mail spool directory |

---

## PASS_MAX_DAYS

Example:

```text
PASS_MAX_DAYS   99999
```

Meaning:

```text
Maximum number of days a password can be used.
```

Example:

```text
PASS_MAX_DAYS   90
```

This means the password expires after 90 days for new users.

---

## PASS_MIN_DAYS

Example:

```text
PASS_MIN_DAYS   0
```

Meaning:

```text
Minimum number of days before a user can change password again.
```

Example:

```text
PASS_MIN_DAYS   7
```

This means user must wait 7 days before changing password again.

---

## PASS_WARN_AGE

Example:

```text
PASS_WARN_AGE   7
```

Meaning:

```text
User gets warning 7 days before password expires.
```

---

## UID_MIN and UID_MAX

Example:

```text
UID_MIN   1000
UID_MAX   60000
```

Meaning:

```text
Regular users will usually get UIDs between 1000 and 60000.
```

Example:

```text
ali   -> UID 1000
sara  -> UID 1001
john  -> UID 1002
```

---

## GID_MIN and GID_MAX

Example:

```text
GID_MIN   1000
GID_MAX   60000
```

Meaning:

```text
Regular groups will usually get GIDs between 1000 and 60000.
```

---

## CREATE_HOME

Example:

```text
CREATE_HOME yes
```

Meaning:

```text
Create home directory automatically for new users.
```

However, many admins still explicitly use:

```bash
sudo useradd -m ali
```

because `-m` clearly tells Linux to create `/home/ali`.

---

## UMASK

Example:

```text
UMASK   022
```

UMASK controls default permissions for newly created files and directories.

With UMASK `022`, common defaults are:

```text
New file       = 644
New directory  = 755
```

Meaning:

```text
Files       = rw-r--r--
Directories = rwxr-xr-x
```

---

## MAIL_DIR

Example:

```text
MAIL_DIR /var/mail
```

or:

```text
MAIL_DIR /var/spool/mail
```

Meaning:

```text
Location where local user mail files are stored.
```

---

## How `/etc/login.defs` Works with `useradd`

When you create a new user:

```bash
sudo useradd ali
```

Linux may read default account values from:

```text
/etc/login.defs
/etc/default/useradd
```

These files help decide:

- UID range
- GID range
- Password aging defaults
- Home directory behavior
- UMASK

---

## Important Note About Existing Users

Changing `/etc/login.defs` mostly affects:

```text
Future users
```

It usually does not automatically modify existing users.

For existing users, use:

```bash
sudo chage -M 90 ali
```

Check:

```bash
sudo chage -l ali
```

---

## Practical Lab

### Lab 1: View `/etc/login.defs`

```bash
less /etc/login.defs
```

### Lab 2: Check Password Defaults

```bash
grep PASS /etc/login.defs
```

### Lab 3: Check UID and GID Ranges

```bash
grep UID /etc/login.defs
grep GID /etc/login.defs
```

### Lab 4: Check UMASK

```bash
grep UMASK /etc/login.defs
```

### Lab 5: Create User and Check Aging

```bash
sudo useradd -m ali
sudo passwd ali
sudo chage -l ali
```

### Lab 6: Modify Existing User Password Policy

```bash
sudo chage -M 90 ali
sudo chage -W 7 ali
sudo chage -l ali
```

---

## Verification Commands

| Command | Purpose |
|--------|---------|
| `cat /etc/login.defs` | Display full file |
| `less /etc/login.defs` | View file page by page |
| `grep PASS /etc/login.defs` | Show password aging defaults |
| `grep UID /etc/login.defs` | Show UID range |
| `grep GID /etc/login.defs` | Show GID range |
| `grep UMASK /etc/login.defs` | Show UMASK |
| `chage -l ali` | Show password aging for user |
| `id ali` | Show UID, GID, and groups |

---

## Interview Questions

### What is `/etc/login.defs`?

`/etc/login.defs` is a configuration file that defines default settings for user accounts, password aging, UID/GID ranges, home directory behavior, UMASK, and login-related parameters.

### Does `/etc/login.defs` affect existing users?

Usually no. It mostly affects future users. For existing users, use `chage`.

### Which setting controls maximum password age?

```text
PASS_MAX_DAYS
```

### Which setting controls minimum password age?

```text
PASS_MIN_DAYS
```

### Which setting controls password warning days?

```text
PASS_WARN_AGE
```

### Which setting defines the first regular user UID?

```text
UID_MIN
```

### Which command checks password aging for a user?

```bash
sudo chage -l ali
```

---

## Roman Urdu Summary

`/etc/login.defs` Linux ki login default settings file hai.

Jab naya user create hota hai, system is file se kuch default values leta hai.

Is file mein ye cheezen define hoti hain:

```text
Password expiry
Password warning days
UID range
GID range
Home directory settings
UMASK
Mail directory
```

Yaad rakhein:

```text
/etc/login.defs mostly future users ko affect karti hai.
Existing users ke liye chage command use hoti hai.
```

Example:

```bash
sudo chage -M 90 ali
```

Iska matlab:

```text
User ali ka password 90 days ke baad expire hoga.
```

---

## Quick Memory Tricks

```text
/etc/login.defs = Login Defaults
```

```text
PASS_MAX_DAYS = Password maximum age
PASS_MIN_DAYS = Minimum days before password change
PASS_WARN_AGE = Warning before expiry
UID_MIN       = First normal user UID
GID_MIN       = First normal group GID
UMASK         = Default permissions
```

---

## One-Line Exam Definition

```text
/etc/login.defs defines default login and user account settings such as password aging, UID/GID ranges, UMASK, and home directory behavior.
```

---

## Conclusion

`/etc/login.defs` is a key Linux configuration file for user management defaults.

For RHCSA and Linux administration, remember:

```text
/etc/login.defs = default rules for new users
chage = modify password aging for existing users
```
