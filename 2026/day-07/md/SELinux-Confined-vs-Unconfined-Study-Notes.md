# SELinux Confined vs Unconfined

## Complete Study Notes

# What Does Confined Mean?

In SELinux:

Confined means restricted by security policies.

A confined user, process, or service can only perform actions that SELinux explicitly allows.

Everything else is denied.

---

# Simple Definition

Confined = Restricted

Unconfined = Not Restricted

---

# Why Is Confined Important?

Without confinement:

Application Compromised
        ↓
Can Access Entire System

With confinement:

Application Compromised
        ↓
Limited By SELinux Policy
        ↓
Damage Reduced

SELinux follows the Principle of Least Privilege.

Only necessary permissions are granted.

---

# Real-Life Example

Imagine a school student.

The student can enter:

- Classroom
- Library
- Playground

The student cannot enter:

- Principal Office
- Server Room
- Staff Records Room

The student is confined because access is restricted.

---

# Confined Process

Example:

Apache Web Server (httpd)

Can access:

- Website files
- Web content

Cannot access:

- /etc/shadow
- User home directories
- Random system files

Even if Apache is hacked, SELinux limits what it can do.

---

# Confined User

Examples:

- user_u
- staff_u

These users are limited by SELinux policies.

---

# Unconfined

Opposite of confined.

Example:

unconfined_u

This user has very few SELinux restrictions.

---

# Check SELinux Context

Check current user:

```bash
id -Z
```

Example:

```text
unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
```

---

Check processes:

```bash
ps -eZ
```

---

Check SELinux mode:

```bash
getenforce
```

Example:

```text
Enforcing
```

---

# RHCSA Example

Check Apache:

```bash
ps -eZ | grep httpd
```

Example output:

```text
system_u:system_r:httpd_t:s0
```

Meaning:

Apache is running in the confined httpd_t domain.

---

# Benefits of Confinement

- Better Security
- Reduced Attack Surface
- Prevents Unauthorized Access
- Protects Sensitive Files
- Limits Damage After Compromise
- Enforces Least Privilege

---

# Interview Questions

## What does confined mean in SELinux?

A confined user or process is restricted by SELinux policies and can only perform actions explicitly allowed by its security context.

---

## What is the opposite of confined?

Unconfined

---

## Give an example of a confined process.

Apache HTTP Server (httpd_t)

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

# Roman Urdu Summary

Confined ka matlab hai kisi user ya process ko security rules ke andar rakhna.

Wo sirf wohi kaam kar sakta hai jo usko allow kiya gaya ho.

Misal ke taur par Apache web server website files access kar sakta hai lekin /etc/shadow ya user home directories access nahi kar sakta.

Yani Apache confined hai.

---

# Quick Memory Trick

Confined = Restricted

Unconfined = Less Restricted

SELinux Goal:

Allow What Is Needed

Block Everything Else

---

# One-Line Exam Definition

Confined means a user, process, or service is restricted by SELinux policies and can perform only explicitly permitted actions.
