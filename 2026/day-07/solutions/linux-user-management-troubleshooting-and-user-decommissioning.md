# Linux User Management -- Home Directory Recovery & Best Practices

## Purpose

These notes improve the user management troubleshooting lab by covering
the correct way to recover a deleted home directory and common mistakes.



------------------------------------------------------------------------

# Scenario

An administrator accidentally runs:

``` bash
sudo rm -rf /home/ali
```

The home directory is deleted, but the user account still exists.

Checking the account:

``` bash
id ali
```

Trying to recreate the user:

``` bash
sudo useradd -m ali
```

Results in:

``` text
useradd: user 'ali' already exists
```

Because the account still exists in `/etc/passwd`, `/etc/shadow`, and
`/etc/group`.

------------------------------------------------------------------------

## About user ali information
## We need these back


```text
root@Khalid-laptop:/home# id ali
uid=1003(ali) gid=1003(ali) groups=1003(ali),27(sudo),100(users)

root@Khalid-laptop:/home# ll ali
total 20
drwxr-x--- 2 ali  ali  4096 May 17 13:13 ./
drwxr-xr-x 7 root root 4096 Jun 24 21:38 ../
-rw-r--r-- 1 ali  ali   220 May 17 13:13 .bash_logout
-rw-r--r-- 1 ali  ali  3771 May 17 13:13 .bashrc
-rw-r--r-- 1 ali  ali   807 May 17 13:13 .profile
```

---

# Correct Recovery Procedure

## 1. Recreate the Home Directory

``` bash
sudo mkdir /home/ali
```

## 2. Restore Default Files

``` bash
sudo cp -a /etc/skel/. /home/ali/
```

This restores:

-   `.bashrc`
-   `.profile`
-   `.bash_logout`

## 3. Fix Ownership

``` bash
sudo chown -R ali:ali /home/ali
```

## 4. Fix Permissions

``` bash
sudo chmod 700 /home/ali
```

## 5. Verify

``` bash
ls -ld /home/ali
ls -la /home/ali
su - ali
```

------------------------------------------------------------------------

# What is `/etc/skel`?

`/etc/skel` stores the default template files copied into a user's home
directory when the account is created.

------------------------------------------------------------------------

# Common Login Errors

``` text
Unable to setup logging
Permission denied
touch: cannot touch '/home/ali/.motd_shown'
```

Cause:

The directory or files are owned by `root`.

Fix:

``` bash
sudo chown -R ali:ali /home/ali
sudo chmod 700 /home/ali
```

---

# Command Comparison

| Command | Removes Home Directory | Removes User Account | Removes Mail Spool | Removes Files Outside Home |
|---------|:----------------------:|:--------------------:|:------------------:|:--------------------------:|
| `rm -rf /home/ali` | ✅ Yes | ❌ No | ❌ No | ❌ No |
| `userdel ali` | ❌ No* | ✅ Yes | ❌ Usually No | ❌ No |
| `userdel -r ali` | ✅ Yes | ✅ Yes | ✅ Yes | ❌ No |

> **Note:**
>
> - `rm -rf /home/ali` deletes only the home directory and its contents. The user account still exists.
> - `userdel ali` removes the user account but normally leaves the home directory and mail spool intact.
> - `userdel -r ali` removes the user account, home directory, and mail spool, **but it does not remove files owned by the user elsewhere on the system.**
> - To locate remaining files after deleting a user, use:
>
> ```bash
> find / -uid <UID> 2>/dev/null
> ```
>
> or, before deleting the user:
>
> ```bash
> find / -user ali 2>/dev/null
> ```

---

# Professional Recovery Workflow

``` bash
sudo mkdir /home/ali
sudo cp -a /etc/skel/. /home/ali/
sudo chown -R ali:ali /home/ali
sudo chmod 700 /home/ali
ls -la /home/ali
su - ali
```

------------------------------------------------------------------------

# Best Practices

-   Always back up important data.
-   Copy `/etc/skel` after manually recreating a home directory.
-   Always run `chown -R` after copying files as root.
-   Verify with `su - username`.

------------------------------------------------------------------------

# RHCSA Exam Tip

If a user's home directory is deleted but the account still exists,
recreate the directory, copy `/etc/skel`, fix ownership and permissions,
and verify the login.

------------------------------------------------------------------------

# Real Lab Scenario -- Recovering User `ali`

## Scenario

The user `ali` already existed, but its home directory was accidentally
deleted.

Attempting to recreate the user:

``` bash
sudo useradd -m ali
```

Result:

``` text
useradd: user 'ali' already exists
```

The home directory was recreated manually and the default files were
copied:

``` bash
sudo mkdir /home/ali
sudo cp -a /etc/skel/. /home/ali/
```

However, after logging in:

``` bash
su - ali
```

Ubuntu displayed:

``` text
Unable to setup logging.
Permission denied: '/home/ali/.landscape'

touch: cannot touch '/home/ali/.motd_shown'
Permission denied
```

## Root Cause

The files copied from `/etc/skel` were owned by **root**, not by
**ali**.

Verify ownership:

``` bash
ls -ld /home/ali
ls -la /home/ali
```

## Solution

Change the ownership of the entire home directory:

``` bash
sudo chown -R ali:ali /home/ali
```

(Optional but recommended)

``` bash
sudo chmod 700 /home/ali
```

Log in again:

``` bash
su - ali
```

The login now succeeds without any permission errors.

## Remaining Message

After the fix, Ubuntu may still display:

``` text
This message is shown once a day.
To disable it please create the /home/ali/.hushlogin file.
```

This is **not an error**. It is only Ubuntu's daily Message of the Day
(MOTD).

To suppress it for that user:

``` bash
touch ~/.hushlogin
```



---

## Additional Check: Shell Changed to `/bin/sh` Instead of Bash

After fixing ownership, login may succeed, but you may notice the prompt looks like this:

```text
$
```

This often means the user's default login shell may be `/bin/sh` instead of `/bin/bash`.

### Check Current Shell

Log in as the user:

```bash
su - ali
```

Then check:

```bash
echo $SHELL
```

Possible output:

```text
/bin/sh
```

If the output is `/bin/sh`, the user is using the basic shell.

### Change Default Shell to Bash

Exit back to your main user or root:

```bash
exit
```

Then run:

```bash
sudo chsh -s /bin/bash ali
```

### Log Out and Log Back In

```bash
su - ali
```

Now check again:

```bash
echo $SHELL
```

Expected output:

```text
/bin/bash
```

The prompt should look more like:

```text
ali@Khalid-laptop:~$
```

### Important Note

Changing the shell does not fix ownership problems.

Ownership problems are fixed with:

```bash
sudo chown -R ali:ali /home/ali
```

Shell problems are fixed with:

```bash
sudo chsh -s /bin/bash ali
```

### Quick Memory

```text
Permission denied in home directory
        ↓
Fix ownership with chown

Prompt only shows $
        ↓
Check shell with echo $SHELL

Shell is /bin/sh
        ↓
Change to Bash with chsh
```


## Lesson Learned

When recreating a user's home directory manually:

1.  Create the directory.
2.  Copy the default files from `/etc/skel`.
3.  Fix ownership using `chown -R`.
4.  Verify permissions.
5.  Test the login with `su - username`.

Missing the `chown -R` step commonly causes login errors such as:

-   `Permission denied`
-   `Unable to setup logging`
-   `cannot touch '.motd_shown'`

------------------------------------------------------------------------

# Quick Recovery Checklist

``` bash
sudo mkdir /home/USERNAME
sudo cp -a /etc/skel/. /home/USERNAME/
sudo chown -R USERNAME:USERNAME /home/USERNAME
sudo chmod 700 /home/USERNAME
su - USERNAME
```
