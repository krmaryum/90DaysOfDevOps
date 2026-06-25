# Linux `useradd` Scripts Study Notes

## Complete A to Z Guide for User Creation Scripts

These notes explain how to write shell scripts for creating Linux users using the `useradd` command.

The examples use username:

```text
ali
```

These notes are useful for:

- Linux Administration
- RHCSA Preparation
- DevOps Practice
- Cloud Server Management
- Shell Scripting Practice
- Interview Preparation

---

# Table of Contents

1. What is a User Creation Script?
2. Why Use Scripts for `useradd`?
3. Script Requirements
4. Basic Script Structure
5. Script 1: Create a Basic User
6. Script 2: Create User with Home Directory
7. Script 3: Create User Without Home Directory
8. Script 4: Create User with Bash Shell
9. Script 5: Create No-Login User
10. Script 6: Create User with Expiry Date
11. Script 7: Create User with No Expiry
12. Script 8: Force Password Change at First Login
13. Script 9: Create User with UID
14. Script 10: Create User with Primary Group
15. Script 11: Create User with Supplementary Groups
16. Script 12: Create Multiple Users
17. Script 13: Create Users from a File
18. Script 14: Complete RHCSA-Style User Creation Script
19. Ubuntu vs RHEL Script Differences
20. Verification Commands
21. Delete User Script
22. Script Safety Checks
23. Interview Questions
24. Roman Urdu Summary
25. Quick Memory Tricks

---

# 1. What is a User Creation Script?

A user creation script is a Bash script that automates the process of creating Linux users.

Instead of typing commands manually every time, we write commands inside a script and run it.

Example manual command:

```bash
sudo useradd -m ali
```

Script version:

```bash
#!/bin/bash

sudo useradd -m ali
echo "User ali created successfully."
```

---

# 2. Why Use Scripts for `useradd`?

Scripts help administrators:

- Save time
- Avoid typing mistakes
- Create users consistently
- Create multiple users quickly
- Automate server setup
- Follow company standards
- Prepare for RHCSA and DevOps tasks

---

# 3. Script Requirements

Before running user creation scripts, you need:

- Linux system: Ubuntu, RHEL, Rocky, CentOS, Amazon Linux
- Bash shell
- `sudo` privileges
- Basic knowledge of users and groups

Check current user:

```bash
whoami
```

Check if you have sudo access:

```bash
sudo whoami
```

Expected output:

```text
root
```

---

# 4. Basic Script Structure

A simple Bash script usually has:

```bash
#!/bin/bash

# Variables
USERNAME="ali"

# Commands
sudo useradd -m "$USERNAME"

# Output message
echo "User $USERNAME created successfully."
```

## Explanation

| Part | Meaning |
|------|---------|
| `#!/bin/bash` | Shebang, tells Linux to run script using Bash |
| `USERNAME="ali"` | Stores username in a variable |
| `sudo useradd` | Creates user with admin privileges |
| `echo` | Prints a message |

---

# 5. Script 1: Create a Basic User

## Script Name

```text
create-basic-user.sh
```

## Script

```bash
#!/bin/bash

USERNAME="ali"

sudo useradd "$USERNAME"

echo "User $USERNAME created successfully."
```

## Run Script

```bash
chmod +x create-basic-user.sh
./create-basic-user.sh
```

## Verify

```bash
id ali
grep ali /etc/passwd
```

---

# 6. Script 2: Create User with Home Directory

## Script Name

```text
create-user-with-home.sh
```

## Script

```bash
#!/bin/bash

USERNAME="ali"

sudo useradd -m "$USERNAME"

echo "User $USERNAME created with home directory."
```

## Explanation

`-m` means create the user's home directory.

Expected home directory:

```text
/home/ali
```

## Verify

```bash
ls -ld /home/ali
grep ali /etc/passwd
```

---

# 7. Script 3: Create User Without Home Directory

## Script Name

```text
create-user-without-home.sh
```

## Script

```bash
#!/bin/bash

USERNAME="ali"

sudo useradd -M "$USERNAME"

echo "User $USERNAME created without home directory."
```

## Explanation

`-M` means do not create home directory.

## Verify

```bash
ls -ld /home/ali
grep ali /etc/passwd
```

If `/home/ali` does not exist, the user was created without an actual home directory.

---

# 8. Script 4: Create User with Bash Shell

## Script Name

```text
create-user-bash-shell.sh
```

## Script

```bash
#!/bin/bash

USERNAME="ali"

sudo useradd -m -s /bin/bash "$USERNAME"

echo "User $USERNAME created with Bash shell."
```

## Explanation

| Option | Meaning |
|--------|---------|
| `-m` | Create home directory |
| `-s /bin/bash` | Set login shell to Bash |

## Verify

```bash
grep ali /etc/passwd
```

Expected:

```text
ali:x:1001:1001::/home/ali:/bin/bash
```

---

# 9. Script 5: Create No-Login User

A no-login user exists on the system but cannot log in interactively.

This is useful for service accounts.

---

## Ubuntu Version

## Script Name

```text
create-nologin-user-ubuntu.sh
```

## Script

```bash
#!/bin/bash

USERNAME="ali"

sudo useradd -m -s /usr/sbin/nologin "$USERNAME"

echo "No-login user $USERNAME created on Ubuntu."
```

---

## RHEL/Rocky Version

## Script Name

```text
create-nologin-user-rhel.sh
```

## Script

```bash
#!/bin/bash

USERNAME="ali"

sudo useradd -m -s /sbin/nologin "$USERNAME"

echo "No-login user $USERNAME created on RHEL/Rocky."
```

## Verify

```bash
grep ali /etc/passwd
```

## Test Login

```bash
su - ali
```

Expected output:

```text
This account is currently not available.
```

---

# 10. Script 6: Create User with Expiry Date

## Script Name

```text
create-user-expiry.sh
```

## Script

```bash
#!/bin/bash

USERNAME="ali"
EXPIRY_DATE="2026-12-31"

sudo useradd -m -e "$EXPIRY_DATE" "$USERNAME"

echo "User $USERNAME created with expiry date $EXPIRY_DATE."
```

## Explanation

`-e` sets the account expiry date.

## Verify

```bash
sudo chage -l ali
```

Look for:

```text
Account expires : Dec 31, 2026
```

---

# 11. Script 7: Create User with No Expiry

## Script Name

```text
create-user-no-expiry.sh
```

## Script

```bash
#!/bin/bash

USERNAME="ali"

sudo useradd -m "$USERNAME"
sudo chage -E -1 "$USERNAME"

echo "User $USERNAME created with account set to never expire."
```

## Explanation

`chage -E -1` removes account expiry.

## Verify

```bash
sudo chage -l ali
```

Expected:

```text
Account expires : never
```

---

# 12. Script 8: Force Password Change at First Login

## Script Name

```text
create-user-force-password-change.sh
```

## Script

```bash
#!/bin/bash

USERNAME="ali"

sudo useradd -m -s /bin/bash "$USERNAME"

echo "Set temporary password for $USERNAME:"
sudo passwd "$USERNAME"

sudo chage -d 0 "$USERNAME"

echo "User $USERNAME must change password at first login."
```

## Explanation

| Command | Meaning |
|---------|---------|
| `passwd ali` | Set temporary password |
| `chage -d 0 ali` | Force password change at first login |

## Verify

```bash
sudo chage -l ali
```

## Test

```bash
su - ali
```

The system should ask the user to change password.

---

# 13. Script 9: Create User with Specific UID

## Script Name

```text
create-user-with-uid.sh
```

## Script

```bash
#!/bin/bash

USERNAME="ali"
USER_UID="2001"

sudo useradd -m -u "$USER_UID" "$USERNAME"

echo "User $USERNAME created with UID $USER_UID."
id "$USERNAME"
```

## Verify

```bash
id ali
```

Expected:

```text
uid=2001(ali)
```

---

# 14. Script 10: Create User with Primary Group

## Script Name

```text
create-user-primary-group.sh
```

## Script

```bash
#!/bin/bash

USERNAME="ali"
GROUPNAME="developers"

sudo groupadd "$GROUPNAME"
sudo useradd -m -g "$GROUPNAME" "$USERNAME"

echo "User $USERNAME created with primary group $GROUPNAME."
id "$USERNAME"
```

## Explanation

| Option | Meaning |
|--------|---------|
| `-g developers` | Sets primary group |

---

# 15. Script 11: Create User with Supplementary Groups

Supplementary groups are additional groups.

---

## Ubuntu Version

Ubuntu admin group is usually:

```text
sudo
```

## Script

```bash
#!/bin/bash

USERNAME="ali"

sudo useradd -m -G sudo "$USERNAME"

echo "User $USERNAME created and added to sudo group."
id "$USERNAME"
```

---

## RHEL/Rocky Version

RHEL admin group is usually:

```text
wheel
```

## Script

```bash
#!/bin/bash

USERNAME="ali"

sudo useradd -m -G wheel "$USERNAME"

echo "User $USERNAME created and added to wheel group."
id "$USERNAME"
```

---

## Multiple Groups Example

```bash
#!/bin/bash

USERNAME="ali"

sudo groupadd developers
sudo groupadd docker

sudo useradd -m -G developers,docker "$USERNAME"

echo "User $USERNAME created with supplementary groups developers and docker."
id "$USERNAME"
```

---

# 16. Script 12: Create Multiple Users

## Script Name

```text
create-multiple-users.sh
```

## Script

```bash
#!/bin/bash

for USER in ali ahmed usman saad
do
    sudo useradd -m "$USER"
    echo "User $USER created successfully."
done
```

## Verify

```bash
id ali
id ahmed
id usman
id saad
```

---

# 17. Script 13: Create Users from a File

This is very useful in real companies.

---

## Step 1: Create `users.txt`

```bash
cat > users.txt <<EOF
ali
ahmed
usman
saad
EOF
```

## Step 2: Script

## Script Name

```text
create-users-from-file.sh
```

## Script

```bash
#!/bin/bash

USER_FILE="users.txt"

while read USER
do
    sudo useradd -m "$USER"
    echo "User $USER created successfully."
done < "$USER_FILE"
```

## Step 3: Run

```bash
chmod +x create-users-from-file.sh
./create-users-from-file.sh
```

## Verify

```bash
cat /etc/passwd | grep -E "ali|ahmed|usman|saad"
```

---

# 18. Script 14: Complete RHCSA-Style User Creation Script

This script combines many user management tasks.

## Script Name

```text
create-user-rhcsa-style.sh
```

## Script

```bash
#!/bin/bash

USERNAME="ali"
USER_UID="2001"
EXPIRY_DATE="2026-12-31"
SHELL="/bin/bash"

sudo useradd \
-m \
-s "$SHELL" \
-u "$USER_UID" \
-e "$EXPIRY_DATE" \
"$USERNAME"

echo "Set temporary password for $USERNAME:"
sudo passwd "$USERNAME"

sudo chage -d 0 "$USERNAME"

echo "================================"
echo "User Created Successfully"
echo "================================"

echo "User ID Information:"
id "$USERNAME"

echo "================================"
echo "User /etc/passwd Entry:"
grep "$USERNAME" /etc/passwd

echo "================================"
echo "Password Aging Information:"
sudo chage -l "$USERNAME"
```

## This Script Does

- Creates user `ali`
- Creates home directory
- Sets shell to `/bin/bash`
- Sets UID to `2001`
- Sets account expiry date
- Sets password
- Forces password change at first login
- Shows verification information

---

# 19. Ubuntu vs RHEL Script Differences

| Feature | Ubuntu | RHEL/Rocky |
|---------|--------|------------|
| No-login shell | `/usr/sbin/nologin` | `/sbin/nologin` |
| Admin group | `sudo` | `wheel` |
| Package manager | `apt` | `dnf` / `yum` |
| User command | `useradd` / `adduser` | `useradd` |
| Password aging | `chage` | `chage` |

---

# 20. Verification Commands

After creating a user, always verify.

## Check UID, GID, Groups

```bash
id ali
```

## Check User Entry

```bash
grep ali /etc/passwd
```

## Check Shadow File

```bash
sudo grep ali /etc/shadow
```

## Check Password Aging

```bash
sudo chage -l ali
```

## Check Home Directory

```bash
ls -ld /home/ali
```

## Check Shell

```bash
getent passwd ali
```

---

# 21. Delete User Script

## Script Name

```text
delete-user.sh
```

## Script

```bash
#!/bin/bash

USERNAME="ali"

sudo userdel -r "$USERNAME"

echo "User $USERNAME and home directory deleted."
```

## Verify

```bash
id ali
```

Expected:

```text
id: ‘ali’: no such user
```

---

# 22. Script Safety Checks

A good script should check if the user already exists.

## Safer Script Example

```bash
#!/bin/bash

USERNAME="ali"

if id "$USERNAME" &>/dev/null
then
    echo "User $USERNAME already exists."
    exit 1
fi

sudo useradd -m "$USERNAME"

echo "User $USERNAME created successfully."
```

## Explanation

| Command | Meaning |
|---------|---------|
| `id ali` | Checks if user exists |
| `&>/dev/null` | Hide output and errors |
| `exit 1` | Stop script with error status |

---

# 23. Interview Questions

## Q1: Why use scripts for user creation?

Scripts save time, reduce errors, and ensure consistent user creation.

---

## Q2: What does `-m` do in `useradd`?

It creates the user's home directory.

---

## Q3: What does `-M` do in `useradd`?

It creates the user without creating a home directory.

---

## Q4: How do you create a no-login user on Ubuntu?

```bash
sudo useradd -m -s /usr/sbin/nologin ali
```

---

## Q5: How do you create a no-login user on RHEL?

```bash
sudo useradd -m -s /sbin/nologin ali
```

---

## Q6: How do you force password change at first login?

```bash
sudo chage -d 0 ali
```

---

## Q7: How do you create multiple users from a file?

Use a `while read` loop:

```bash
while read USER
do
    sudo useradd -m "$USER"
done < users.txt
```

---

# 24. Roman Urdu Summary

`useradd` script ka matlab hai user creation ko automate karna.

Manual command likhne ke bajaye hum Bash script bana dete hain.

Example:

```bash
sudo useradd -m ali
```

Script mein:

```bash
USERNAME="ali"
sudo useradd -m "$USERNAME"
```

`-m` ka matlab home directory banana.

`-M` ka matlab home directory na banana.

`-s /bin/bash` ka matlab Bash shell dena.

`-s /usr/sbin/nologin` ya `/sbin/nologin` ka matlab user login nahi kar sakta.

`chage -d 0` ka matlab first login par password change force karna.

Scripts ka faida:

- Time save hota hai
- Mistakes kam hoti hain
- Multiple users quickly ban jate hain
- DevOps automation mein help milti hai

---

# 25. Quick Memory Tricks

```text
-m = Make home directory

-M = No home directory

-s = Set shell

-e = Expiry date

-u = UID

-g = Primary group

-G = Supplementary groups

chage -d 0 = Force password change

nologin = No interactive login
```

---

# 26. Recommended Practice Order

1. Create one basic user script
2. Create user with home directory
3. Create user without home directory
4. Create user with Bash shell
5. Create no-login user
6. Create user with expiry date
7. Create user and force password change
8. Create user with UID
9. Create user with groups
10. Create multiple users
11. Create users from file
12. Add safety checks
13. Delete users using script

---

# 27. Important Notes

## Always verify after running scripts

```bash
id ali
grep ali /etc/passwd
sudo chage -l ali
```

## Always test scripts in a lab first

Do not directly run new scripts on production servers.

## Use variables

Variables make scripts easier to modify:

```bash
USERNAME="ali"
```

## Use quotes

Always quote variables:

```bash
"$USERNAME"
```

This prevents problems if values contain spaces or special characters.

---

# Conclusion

User creation scripts are an important part of Linux administration and DevOps automation.

By practicing these scripts, you will understand:

- `useradd`
- `passwd`
- `chage`
- `usermod`
- `userdel`
- groups
- shells
- account expiry
- password policies
- automation basics

These skills are useful for RHCSA, Linux Admin jobs, DevOps roles, and cloud server management.
