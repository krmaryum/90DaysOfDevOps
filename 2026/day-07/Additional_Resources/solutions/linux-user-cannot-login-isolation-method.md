# Linux Troubleshooting Scenario

# Scenario 2 -- User Cannot Login (Isolation Method)

## Problem

A user reports:

``` text
Login incorrect
```

The administrator verifies that the account exists:

``` bash
id ali
```

Output:

``` text
uid=1002(ali)
```

Since the account exists, begin troubleshooting using the **Isolation
Method**.

------------------------------------------------------------------------

# Why Use the Isolation Method?

Professional Linux administrators do **not** guess.

Instead, they:

1.  Gather information
2.  Isolate one possible cause at a time
3.  Fix the root cause
4.  Verify the solution
5.  Document the result

------------------------------------------------------------------------

# Troubleshooting Flow

``` text
Problem
    │
    ▼
Gather Information
    │
    ▼
Isolate One Possible Cause
    │
    ▼
Fix the Root Cause
    │
    ▼
Verify
    │
    ▼
Document
```

------------------------------------------------------------------------

# Step 1 -- Gather Information

Ask:

-   Does the user exist?
-   Is the account locked?
-   Has the password expired?
-   Has the account expired?
-   Is the login shell valid?
-   Does the home directory exist?
-   Are permissions correct?

------------------------------------------------------------------------

# Step 2 -- Isolate the Problem

## Check 1 -- User Exists

``` bash
id ali
```

If the account exists:

✅ Continue troubleshooting.

------------------------------------------------------------------------

## Check 2 -- Is the Account Locked?

``` bash
passwd -S ali
```

Possible output:

  Status   Meaning
  -------- --------------
  PS       Password Set
  LK       Locked
  NP       No Password

If:

``` text
LK
```

Unlock it:

``` bash
sudo passwd -u ali
```

or

``` bash
sudo usermod -U ali
```

------------------------------------------------------------------------

## Check 3 -- Password Expired?

``` bash
sudo chage -l ali
```

If expired:

``` bash
sudo passwd ali
```

------------------------------------------------------------------------

## Check 4 -- Account Expired?

``` bash
sudo chage -l ali
```

If the account has expired:

``` bash
sudo chage -E -1 ali
```

------------------------------------------------------------------------

## Check 5 -- Valid Login Shell?

``` bash
grep "^ali" /etc/passwd
```

Good:

``` text
/bin/bash
```

Bad:

``` text
/usr/sbin/nologin
```

or

``` text
/bin/false
```

Fix:

``` bash
sudo chsh -s /bin/bash ali
```

------------------------------------------------------------------------

## Check 6 -- Home Directory Exists?

``` bash
ls -ld /home/ali
```

If missing:

``` bash
sudo mkdir /home/ali
sudo cp -a /etc/skel/. /home/ali/
sudo chown -R ali:ali /home/ali
sudo chmod 700 /home/ali
```

------------------------------------------------------------------------

## Check 7 -- Ownership Correct?

``` bash
ls -ld /home/ali
```

Correct:

``` text
drwx------ ali ali
```

Incorrect:

``` text
drwx------ root root
```

Fix:

``` bash
sudo chown -R ali:ali /home/ali
```

------------------------------------------------------------------------

## Check 8 -- Reset Password

If all previous checks pass, reset the password:

``` bash
sudo passwd ali
```

------------------------------------------------------------------------

# Step 3 -- Verify

Test login:

``` bash
su - ali
```

If successful:

✅ Problem resolved.

------------------------------------------------------------------------

# Step 4 -- Document

``` text
Problem:
User could not log in.

Root Cause:
(Account locked / Password expired / Missing home directory / Wrong shell)

Resolution:
(Command(s) used)

Verification:
User logged in successfully.

Administrator:
Date:
```

------------------------------------------------------------------------

# Decision Tree

``` text
User Cannot Login
        │
        ▼
User Exists?
        │
   No ──► Create User
        │
       Yes
        │
        ▼
Account Locked?
        │
   Yes ─► Unlock
        │
        ▼
Password Expired?
        │
   Yes ─► Reset Password
        │
        ▼
Account Expired?
        │
   Yes ─► Extend Account
        │
        ▼
Valid Login Shell?
        │
   No ─► Change Shell
        │
        ▼
Home Directory Exists?
        │
   No ─► Recreate Home
        │
        ▼
Ownership Correct?
        │
   No ─► Fix Ownership
        │
        ▼
Reset Password
        │
        ▼
Test Login
        │
        ▼
Document
```

------------------------------------------------------------------------

# RHCSA Tip

Never assume the first symptom is the real problem. Check one
possibility at a time until you identify the root cause.

------------------------------------------------------------------------

# Interview Tip

Explain your troubleshooting process before listing commands. Employers
value structured thinking.

------------------------------------------------------------------------

# One-Line Summary

A skilled Linux administrator solves login problems by isolating one
possible cause at a time, fixing the root cause, verifying the result,
and documenting the solution.
