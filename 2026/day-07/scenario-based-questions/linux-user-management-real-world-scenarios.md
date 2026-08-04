# Linux User Management - Real-World Scenario Based Practice

## Purpose
These scenarios help you practice troubleshooting real Linux user-management problems similar to those seen in production and RHCSA exams.

## Scenario 1 – Recovering a Deleted Home Directory
A Linux administrator accidentally deletes `/home/ali`:

```bash
sudo rm -rf /home/ali
```

Later:

```bash
sudo useradd -m ali
```

Output:

```text
useradd: user 'ali' already exists
```

### Tasks
1. Verify the user exists.
2. Recreate the home directory.
3. Restore default files from `/etc/skel`.
4. Fix ownership and permissions.
5. Test login.

[Solution](../md/User-and-Group-Management/linux-user-management-troubleshooting-and-user-decommissioning.md)


---

## Scenario 2 – User Cannot Login
Tasks:
- Check if the account exists.
- Verify password status.
- Check for a locked account.
- Verify login shell.
- Confirm home directory exists.

[Solution](../solutions/linux-user-cannot-login-isolation-method.md)

---

## Scenario 3 – Wrong Home Directory Ownership
`ls -ld /home/ali` shows:

```text
drwx------ root root
```

Tasks:
- Find the problem.
- Restore ownership.
- Verify login.

[Solution](../solutions/linux-wrong-home-ownership-isolation-method.md)

---

## Scenario 4 – Wrong Login Shell
`echo $SHELL` returns:

```text
/bin/sh
```

Tasks:
- Verify shell.
- Change to `/bin/bash`.
- Test login.


---

## Scenario 5 – Home Directory Missing
`/etc/passwd` references `/home/ali`, but it doesn't exist.

Tasks:
- Create it.
- Copy `/etc/skel`.
- Fix ownership.
- Verify login.

---

## Scenario 6 – User Already Exists
```bash
sudo useradd ali
```

Tasks:
- Locate the existing account.
- Display UID, GID, shell, and home directory.

---

## Scenario 7 – Forgot Password
Reset the password and optionally force a password change on next login.

---

## Scenario 8 – Locked Account
`passwd -S ali` returns `LK`.

Tasks:
- Explain `LK`.
- Unlock the account.
- Verify access.

---

## Scenario 9 – Password Expired
Use `chage -l ali`.

Tasks:
- Review password aging.
- Update the policy.

---

## Scenario 10 – Account Expired
Extend the account expiration and verify it.

---

## Scenario 11 – Deleted User but Home Directory Remains
Explain why the home directory still exists and decide whether to remove or preserve it.

---

## Scenario 12 – Wrong UID
Restore ownership of files after a UID change.

---

## Scenario 13 – Wrong Group Membership
Add the user to the correct group and verify membership.

---

## Scenario 14 – Forgot `-aG`
Recover missing secondary groups after using:

```bash
sudo usermod -G docker ali
```

---

## Scenario 15 – Home Directory Not Created
Create the missing home directory and populate it from `/etc/skel`.

---

## Scenario 16 – Missing Default Files
Investigate why new users do not receive `.bashrc` or `.profile`.

---

## Scenario 17 – Corrupted Password Database
Use:

```bash
sudo pwck
```

Repair any reported issues.

---

## Scenario 18 – Corrupted Group Database
Use:

```bash
sudo grpck
```

Repair any reported issues.

---

## Scenario 19 – User Cannot Use sudo
Grant the required administrative privileges and verify access.

---

## Scenario 20 – Shared Project Directory
Design a secure shared directory for multiple developers using groups and permissions.

---

# RHCSA Tip
Always understand **why** the problem occurred before choosing the command to fix it.

# Interview Tip
Employers value your troubleshooting process as much as the final solution.

# One-Line Summary
A great Linux administrator solves problems methodically rather than memorizing commands.
