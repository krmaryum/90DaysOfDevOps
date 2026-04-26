# 📘 Nginx Configuration Explanation

## 🖥️ Bash Setup

```bash
mkdir -p files
vim files/nginx.conf
```

Creates a directory and opens a new Nginx configuration file.

---

## 🌐 Nginx Configuration

```nginx
user nginx;
worker_processes auto;

events {
    worker_connections 1024;
}

http {
    server {
        listen 80;
        server_name _;

        location / {
            root /usr/share/nginx/html;
            index index.html index.htm;
        }
    }
}
```

---

## 🔍 Explanation

### Global Settings
- **user nginx;** → Runs Nginx as the nginx user (use `www-data` on Ubuntu)
- **worker_processes auto;** → Uses all CPU cores

### Events Block
- **worker_connections 1024;** → Max connections per worker

### Server Block
- **listen 80;** → HTTP port
- **server_name _;** → Default catch-all server

### Location Block
- **root** → Directory serving website files
- **index** → Default file served

---

## ⚠️ OS Note
- Ubuntu/Debian → use `www-data`
- RedHat/Amazon → use `nginx`

---

## 🧠 Summary

This config:
- Sets up a basic web server
- Serves static files
- Handles all incoming HTTP requests

Perfect for:
- Learning Nginx
- Docker setups
- DevOps labs
