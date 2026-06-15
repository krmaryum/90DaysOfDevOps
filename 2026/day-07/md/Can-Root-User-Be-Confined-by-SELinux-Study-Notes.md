# Can Root User Be Confined by SELinux?

## Complete Study Notes

---

# One-Line Answer

```text
Yes. SELinux can restrict even the root user or root-owned processes.
```

If SELinux policy denies an action, the action is blocked regardless of traditional Linux permissions.

---

# Table of Contents

1. What is Root User?
2. What is SELinux?
3. Can Root Be Confined?
4. Root Without SELinux
5. Root With SELinux
6. DAC vs SELinux
7. Real Examples
8. Check SELinux Context
9. RHCSA Perspective
10. Interview Questions
11. Roman Urdu Summary
12. Quick Memory Tricks

---

# 1. What is Root User?

Root is the Linux superuser.

UID:

```bash
0
```

Root normally has full administrative privileges.

Root can:

- Read files
- Modify files
- Delete files
- Create users
- Install software
- Start and stop services

---

# 2. What is SELinux?

SELinux stands for:

```text
Security-Enhanced Linux
```

SELinux provides an additional security layer on top of normal Linux permissions.

It uses security policies to determine:

```text
Who can access what
Which process can do what
Which files can be accessed
```

---

# 3. Can Root Be Confined?

Yes.

One of the most important SELinux concepts is:

```text
SELinux can restrict even root.
```

Normal Linux permissions may allow access.

SELinux can still deny it.

---

# 4. Root Without SELinux

Without SELinux:

```text
root = almost unlimited access
```

Example:

```bash
cat /etc/shadow
```

Root can normally read this file.

Root can bypass most file permission restrictions.

---

# 5. Root With SELinux

With SELinux enabled:

```text
Root may still be denied.
```

Example:

Apache service:

```text
httpd
```

may run as a root-owned service.

Even then SELinux can prevent access to:

```text
/etc/shadow
User home directories
Sensitive files
```

because SELinux policy restricts the process.

---

# 6. DAC vs SELinux

DAC means:

```text
Discretionary Access Control
```

DAC refers to traditional Linux permissions:

```text
Owner
Group
Others
```

Example:

```text
File permissions allow access
```

DAC says:

```text
YES
```

But SELinux policy says:

```text
NO
```

Final result:

```text
NO
```

---

# Important Rule

```text
DAC says YES
SELinux says NO

Final Answer = NO
```

SELinux policy wins.

---

# 7. Real Examples

## Example 1

Normal Linux:

```text
Root can read almost everything.
```

SELinux:

```text
Root-owned process may still be blocked.
```

---

## Example 2

Apache Process

SELinux domain:

```text
httpd_t
```

Allowed:

```text
Website files
```

Denied:

```text
/etc/shadow
/home directories
```

Even if the service is running as root.

---

# 8. Check SELinux Context

Check current user:

```bash
id -Z
```

Example:

```text
unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
```

---

Check process context:

```bash
ps -eZ
```

---

Check Apache:

```bash
ps -eZ | grep httpd
```

Example:

```text
system_u:system_r:httpd_t:s0
```

Meaning:

```text
Apache is running in a confined SELinux domain.
```

---

# 9. RHCSA Perspective

For RHCSA remember:

## Linux Permissions

```text
Root usually bypasses file permissions.
```

---

## SELinux

```text
SELinux can restrict even root.
```

This is one of the primary purposes of SELinux.

---

# 10. Interview Questions

## Can root be confined by SELinux?

Answer:

```text
Yes. SELinux can restrict even the root user or root-owned processes. If SELinux policy denies an action, the action is blocked regardless of traditional Linux permissions.
```

---

## What happens if DAC allows access but SELinux denies it?

Answer:

```text
Access is denied.
```

SELinux policy wins.

---

## Which command shows SELinux context?

```bash
id -Z
```

or

```bash
ps -eZ
```

---

## Which command shows SELinux mode?

```bash
getenforce
```

---

# 11. Roman Urdu Summary

```text
Normal Linux mein root sab kuch kar sakta hai.

Lekin SELinux ke saath root bhi restricted ho sakta hai.

Agar SELinux policy kisi kaam ki ijazat na de,
to root bhi woh kaam nahi kar sakta.

Yani:

Root > Linux Permissions

Lekin

SELinux Policy > Root
```

---

# 12. Quick Memory Tricks

```text
Linux Permissions:

Root Wins
```

---

```text
SELinux:

Policy Wins
```

---

```text
DAC says YES
SELinux says NO

Final Answer = NO
```

---

# Exam Tip

Remember:

```text
Linux permissions control access to files.

SELinux confinement controls what a process is allowed to do even if normal Linux permissions allow access.
```

This is one of the most important RHCSA and Linux Administration security concepts.
