# cURL Command Guide – A to Z

## What is cURL?

cURL (Client URL) is a command-line tool used to transfer data between a client and a server using various protocols such as:

* HTTP
* HTTPS
* FTP
* SFTP
* SCP
* SMTP

It is commonly used by:

* Linux Administrators
* DevOps Engineers
* Cloud Engineers
* Developers

---

# Basic Syntax

```bash
curl [options] URL
```

Example:

```bash
curl https://khalidkhan.me
```

---

# Why Use cURL?

cURL helps you:

* Test websites
* Download files
* Check API responses
* Verify redirects
* Troubleshoot network issues
* Inspect HTTP headers

---

# 1. curl URL

## Command

```bash
curl https://khalidkhan.me
```

## Purpose

Downloads and displays the webpage content in the terminal.

## Example Output

```html
<html>
<head>
<title>My Website</title>
</head>
<body>
Hello World
</body>
</html>
```

---

# 2. curl -I

## Command

```bash
curl -I https://khalidkhan.me
```

## Purpose

Display only HTTP headers.

Do not download webpage content.

## Example Output

```text
HTTP/2 200
server: GitHub.com
content-type: text/html
content-length: 1234
```

## Use Cases

* Check website availability
* Verify HTTP status code
* Verify server information

## Memory Trick

```text
-I = Information (Headers)
```

---

# 3. curl -O

## Command

```bash
curl -O https://example.com/file.zip
```

## Purpose

Download a file and keep its original name.

## Result

```text
file.zip
```

## Memory Trick

```text
-O = Original Filename
```

---

# 4. curl -o

## Command

```bash
curl -o myfile.zip https://example.com/file.zip
```

## Purpose

Download a file and save it with a custom name.

## Result

```text
myfile.zip
```

## Memory Trick

```text
-o = Own Filename
```

---

# Difference Between -O and -o

| Option | Meaning                 |
| ------ | ----------------------- |
| -O     | Save with original name |
| -o     | Save with custom name   |

Example:

```bash
curl -O https://example.com/test.txt
```

Creates:

```text
test.txt
```

Example:

```bash
curl -o notes.txt https://example.com/test.txt
```

Creates:

```text
notes.txt
```

---

# 5. curl -L

## Command

```bash
curl -L http://khalidkhan.me
```

## Purpose

Follow redirects automatically.

## Example

```text
http://
      ↓
https://
```

Without `-L`, cURL may stop at the redirect.

## Memory Trick

```text
-L = Location Follow
```

---

# 6. curl -v

## Command

```bash
curl -v https://khalidkhan.me
```

## Purpose

Verbose mode.

Displays detailed connection information.

## Shows

* DNS lookup
* TCP connection
* SSL handshake
* HTTP request
* HTTP response

## Memory Trick

```text
-v = Verbose
```

---

# Real DevOps Examples

## Check Website Status

```bash
curl -I https://google.com
```

---

## Download File

```bash
curl -O https://example.com/file.zip
```

---

## Save With Custom Name

```bash
curl -o app.zip https://example.com/file.zip
```

---

## Follow Redirect

```bash
curl -L http://khalidkhan.me
```

---

## Troubleshoot Website

```bash
curl -v https://khalidkhan.me
```

---

# Common HTTP Status Codes

| Code | Meaning               |
| ---- | --------------------- |
| 200  | OK                    |
| 301  | Permanent Redirect    |
| 302  | Temporary Redirect    |
| 403  | Forbidden             |
| 404  | Not Found             |
| 500  | Internal Server Error |

---

# Quick Reference Table

| Command          | Purpose                     |
| ---------------- | --------------------------- |
| curl URL         | Display webpage content     |
| curl -I URL      | Show headers only           |
| curl -O URL      | Download with original name |
| curl -o file URL | Download with custom name   |
| curl -L URL      | Follow redirects            |
| curl -v URL      | Detailed troubleshooting    |

---

# Roman Urdu Summary

* `curl -I` → Sirf headers dekho
* `curl -O` → Original naam se download karo
* `curl -o` → Apna naam de kar download karo
* `curl -L` → Redirect follow karo
* `curl -v` → Detailed connection information dekho

---

# Interview Question

### What is the difference between curl -O and curl -o?

**Answer:**

* `curl -O` downloads a file using its original filename.
* `curl -o` downloads a file using a custom filename specified by the user.

---

# Conclusion

cURL is one of the most important Linux networking tools used by:

* Linux Administrators
* DevOps Engineers
* Cloud Engineers
* Site Reliability Engineers (SRE)

Learning `curl` is essential for troubleshooting websites, APIs, downloads, redirects, and network connectivity.
