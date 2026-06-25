# SELinux Context Explained

## Complete Study Notes

## Table of Contents

1. What is Context?
2. What is SELinux?
3. What is SELinux Context?
4. Why SELinux Context Matters
5. SELinux Context Structure
6. How to View SELinux Context
7. SELinux Context Example
8. Important SELinux Context Fields
9. Most Important Part: Type
10. Apache/Web Server Example
11. Common SELinux Context Commands
12. How to Restore Correct Context
13. How to Change SELinux Context Temporarily
14. How to Change SELinux Context Permanently
15. Troubleshooting SELinux Context Issues
16. Linux Permissions vs SELinux Context
17. Key Takeaways
18. Roman Urdu Summary

---

# 1. What is Context?

Context means extra background information about something.

In Linux security, context helps the system understand:

- What the object is
- Who owns it
- What type of access should be allowed
- Whether a process is allowed to use it

Simple definition:

> Context means identity plus background information.

---

# 2. What is SELinux?

SELinux stands for:

```text
Security-Enhanced Linux
```

SELinux is a Linux security feature that controls access using security policies.

It adds an extra security layer on top of normal Linux permissions.

Normal Linux permissions use:

```text
Owner
Group
Others
Read
Write
Execute
```

SELinux uses:

```text
Security Context
Policy Rules
Labels
Types
```

---

# 3. What is SELinux Context?

SELinux context is a security label assigned to:

- Files
- Directories
- Processes
- Ports

It tells SELinux what the object is and how it should be treated.

Example SELinux context:

```text
system_u:object_r:httpd_sys_content_t:s0
```

This label helps SELinux decide whether access should be allowed or denied.

---

# 4. Why SELinux Context Matters

Even if Linux permissions allow access, SELinux can still deny access if the context is wrong.

Example:

```bash
chmod 777 index.html
```

Normal permissions may allow access.

But if SELinux context is wrong, Apache may still be blocked.

That means:

```text
Linux permission allowed
SELinux context denied
Access blocked
```

This is why SELinux context is very important in Linux administration.

---

# 5. SELinux Context Structure

SELinux context has four main parts:

```text
user:role:type:level
```

Example:

```text
system_u:object_r:httpd_sys_content_t:s0
```

Breakdown:

| Part | Example | Meaning |
|------|---------|---------|
| User | system_u | SELinux user |
| Role | object_r | SELinux role |
| Type | httpd_sys_content_t | SELinux type |
| Level | s0 | Security level |

---

# 6. How to View SELinux Context

Use the `-Z` option.

View file context:

```bash
ls -Z
```

View context of a specific file:

```bash
ls -Z index.html
```

View directory context:

```bash
ls -Zd /var/www/html
```

View process context:

```bash
ps -eZ
```

View Apache/httpd process context:

```bash
ps -eZ | grep httpd
```

---

# 7. SELinux Context Example

Command:

```bash
ls -Z /var/www/html/index.html
```

Example output:

```text
-rw-r--r--. root root system_u:object_r:httpd_sys_content_t:s0 index.html
```

SELinux context:

```text
system_u:object_r:httpd_sys_content_t:s0
```

Meaning:

- `system_u` = SELinux user
- `object_r` = object role
- `httpd_sys_content_t` = web content type
- `s0` = security level

---

# 8. Important SELinux Context Fields

## SELinux User

Example:

```text
system_u
```

This represents the SELinux user identity.

## SELinux Role

Example:

```text
object_r
```

For files and directories, the role is usually `object_r`.

## SELinux Type

Example:

```text
httpd_sys_content_t
```

This is the most important part.

The type tells SELinux what kind of object it is.

## SELinux Level

Example:

```text
s0
```

This is used for security levels, especially in MLS/MCS environments.

---

# 9. Most Important Part: Type

In most daily Linux administration tasks, the most important SELinux context field is:

```text
type
```

Example:

```text
httpd_sys_content_t
```

This tells SELinux:

> This file is web server content.

If Apache is allowed to read `httpd_sys_content_t`, then Apache can serve that file.

If the file has the wrong type, Apache may be denied.

---

# 10. Apache/Web Server Example

Suppose you create a file:

```bash
touch /var/www/html/index.html
```

Correct SELinux context should be:

```text
httpd_sys_content_t
```

Check it:

```bash
ls -Z /var/www/html/index.html
```

Correct example:

```text
system_u:object_r:httpd_sys_content_t:s0
```

Apache can read this file.

Wrong example:

```text
unconfined_u:object_r:user_home_t:s0
```

Apache may not read this file because `user_home_t` is usually for user home directories, not web content.

---

# 11. Common SELinux Context Commands

Check SELinux status:

```bash
getenforce
```

Possible outputs:

```text
Enforcing
Permissive
Disabled
```

View detailed SELinux status:

```bash
sestatus
```

View file context:

```bash
ls -Z file_name
```

View directory context:

```bash
ls -Zd directory_name
```

View process context:

```bash
ps -eZ
```

View SELinux context rules:

```bash
semanage fcontext -l
```

---

# 12. How to Restore Correct Context

The safest command to restore default SELinux context is:

```bash
restorecon
```

Restore context for one file:

```bash
restorecon -v /var/www/html/index.html
```

Restore context recursively for a directory:

```bash
restorecon -Rv /var/www/html
```

Meaning:

- `-R` = recursive
- `-v` = verbose output

This restores the default context based on SELinux policy.

---

# 13. How to Change SELinux Context Temporarily

Use:

```bash
chcon
```

Example:

```bash
chcon -t httpd_sys_content_t /var/www/html/index.html
```

This changes the type to:

```text
httpd_sys_content_t
```

But this change is temporary.

If you run `restorecon`, the context may return to the default policy value.

---

# 14. How to Change SELinux Context Permanently

Use:

```bash
semanage fcontext
```

Then apply it with:

```bash
restorecon
```

Example:

```bash
semanage fcontext -a -t httpd_sys_content_t "/webdata(/.*)?"
restorecon -Rv /webdata
```

Explanation:

```text
/webdata(/.*)?
```

means:

- Apply context to `/webdata`
- Apply context to everything inside `/webdata`

This is the correct permanent method.

---

# 15. Troubleshooting SELinux Context Issues

If a service cannot access a file, check these steps.

## Step 1: Check normal permissions

```bash
ls -l file_name
```

## Step 2: Check SELinux context

```bash
ls -Z file_name
```

## Step 3: Check SELinux mode

```bash
getenforce
```

## Step 4: Restore default context

```bash
restorecon -Rv directory_name
```

## Step 5: Check logs

Common SELinux denial logs are found in:

```text
/var/log/audit/audit.log
```

Search AVC denials:

```bash
ausearch -m AVC -ts recent
```

---

# 16. Linux Permissions vs SELinux Context

| Feature | Linux Permissions | SELinux Context |
|--------|------------------|----------------|
| Controls access using | Owner, group, others | Security labels and policies |
| Command to view | `ls -l` | `ls -Z` |
| Example | `rwxr-xr-x` | `httpd_sys_content_t` |
| Main purpose | Basic file access | Advanced mandatory access control |
| Can deny even if chmod allows? | No | Yes |

Important point:

> Linux permissions and SELinux context both must allow access.

---

# 17. Key Takeaways

- SELinux context is a security label.
- It is used by SELinux to allow or deny access.
- Context has four parts: user, role, type, and level.
- The most important part is usually the type.
- Use `ls -Z` to view SELinux context.
- Use `restorecon` to restore default context.
- Use `chcon` for temporary context changes.
- Use `semanage fcontext` for permanent context changes.
- Wrong SELinux context can block access even if Linux permissions are correct.

---

# 18. Roman Urdu Summary

SELinux context ka simple matlab hai:

```text
File ya process ki security identity
```

Ya phir:

```text
SELinux label jo batata hai ke ye file/process kis type ka hai.
```

Example:

```text
system_u:object_r:httpd_sys_content_t:s0
```

Is context ke 4 parts hotay hain:

```text
user:role:type:level
```

Sab se important part hota hai:

```text
type
```

Example:

```text
httpd_sys_content_t
```

Iska matlab hai:

```text
Ye web server content hai.
```

Agar Apache ko koi file read karni hai to us file ka SELinux type usually correct hona chahiye.

Agar file ka context galat ho, jaise:

```text
user_home_t
```

to Apache access deny kar sakta hai, chahe file permission `777` hi kyon na ho.

Important commands:

```bash
ls -Z
```

SELinux context dekhne ke liye.

```bash
restorecon -Rv /path
```

Default correct context restore karne ke liye.

```bash
chcon -t type_name file
```

Temporary context change karne ke liye.

```bash
semanage fcontext -a -t type_name "/path(/.*)?"
restorecon -Rv /path
```

Permanent context change karne ke liye.

Simple yaad rakhne wali baat:

```text
Linux permissions batati hain kaun read/write/execute kar sakta hai.
SELinux context batata hai file/process ki security identity kya hai.
```

Final memory trick:

```text
Context = Identity + Background Information
```

SELinux context ka kaam hai system ko batana:

```text
Ye file kya hai?
Ye process kya hai?
Isko access allow karna hai ya deny?
```
