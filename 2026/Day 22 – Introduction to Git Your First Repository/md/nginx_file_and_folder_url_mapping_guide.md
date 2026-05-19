
# Understanding Nginx File and Folder URL Mapping

## Introduction

Nginx serves files from a directory, usually:

```text
/var/www/html
```

Every file and folder inside this directory becomes accessible through browser URLs.

---

# Default Nginx Files

Inside:

```bash
/var/www/html
```

Example:

```text
index.html
index.nginx-debian.html
```

---

# Accessing Files in Browser

## Custom Page

File:

```text
/var/www/html/index.html
```

URL:

```text
http://localhost
```

---

## Default Debian Nginx Page

File:

```text
/var/www/html/index.nginx-debian.html
```

URL:

```text
http://localhost/index.nginx-debian.html
```

---

# Important Nginx Behavior

Nginx automatically looks for:

```text
index.html
```

inside folders.

That is why:

```text
http://localhost
```

loads:

```text
/var/www/html/index.html
```

---

# Using Folders

Suppose you create:

```text
/var/www/html/projects/nginx/index.html

/var/www/html/projects/docker/index.html
```

---

# Browser URLs

## Nginx Project

```text
http://localhost/projects/nginx/
```

---

## Docker Project

```text
http://localhost/projects/docker/
```

Nginx automatically loads:

```text
index.html
```

inside those folders.

---

# Another Example

Suppose:

```text
/var/www/html/devops/about.html
```

Browser URL:

```text
http://localhost/devops/about.html
```

---

# Folder Structure Example

```text
/var/www/html
│
├── index.html
│
├── projects
│   ├── nginx
│   │   └── index.html
│   │
│   └── docker
│       └── index.html
│
└── blog
    └── post.html
```

---

# URL Mapping Table

| Linux File Path | Browser URL |
|---|---|
| `/var/www/html/index.html` | `http://localhost/` |
| `/var/www/html/projects/nginx/index.html` | `http://localhost/projects/nginx/` |
| `/var/www/html/projects/docker/index.html` | `http://localhost/projects/docker/` |
| `/var/www/html/blog/post.html` | `http://localhost/blog/post.html` |

---

# Create Folder Example

Create folders:

```bash
sudo mkdir -p /var/www/html/projects/nginx
```

Copy webpage:

```bash
sudo cp index.html /var/www/html/projects/nginx/
```

Open browser:

```text
http://localhost/projects/nginx/
```

---

# Open Linux Folder in Windows Explorer

Inside WSL:

```bash
explorer.exe .
```

This opens the current Linux folder in Windows Explorer.

---

# Access Linux Files from Windows

Use this path in Windows Explorer:

```text
\\wsl$\Ubuntu\var\www\html
```

---

# How Nginx Chooses Default Page

Typical configuration:

```nginx
index index.html index.htm index.nginx-debian.html;
```

Order:
1. index.html
2. index.htm
3. index.nginx-debian.html

If `index.html` exists, Nginx serves it first.

---

# Optional Cleanup

Remove default Debian page:

```bash
sudo rm /var/www/html/index.nginx-debian.html
```

---

# Best Practice

Recommended structure:

```text
/var/www/html
│
├── projects
│   ├── nginx
│   ├── docker
│   ├── kubernetes
│   └── linux
```

Each project gets its own folder and webpage.

---

# Final Understanding

Nginx maps:

```text
/var/www/html
```

to:

```text
http://localhost/
```

Every file and folder inside becomes accessible through browser URLs.

This is the foundation of static website hosting with Nginx.
