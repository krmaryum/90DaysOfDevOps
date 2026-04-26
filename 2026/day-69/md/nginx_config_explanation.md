# 📘 Nginx Configuration & Custom Config Explanation

## 🌐 What is an Nginx Configuration File?

The Nginx configuration file (`nginx.conf`) defines how the web server behaves. It controls:
- Server behavior
- Request handling
- Ports and domains
- File locations
- Performance settings

---

## 🧱 Structure of an Nginx Config

```
main (global)
 ├── events
 └── http
      └── server
           └── location
```

---

## 🔍 Configuration Breakdown

### 🔹 Global Section

```nginx
user nginx;
worker_processes auto;
```

- Defines which user runs Nginx
- Uses all CPU cores for performance

---

### 🔹 Events Block

```nginx
events {
    worker_connections 1024;
}
```

- Defines maximum connections per worker

---

### 🔹 HTTP Block

```nginx
http {
```

- Contains all web server configuration

---

### 🔹 Server Block

```nginx
server {
    listen 80;
    server_name _;
}
```

- Listens on HTTP port 80
- Handles all incoming requests

---

### 🔹 Location Block

```nginx
location / {
    root /usr/share/nginx/html;
    index index.html index.htm;
}
```

- Serves static files from directory
- Defines default page

---

## 🧠 What This Config Does

- Runs a basic web server
- Serves static content
- Handles all HTTP requests

---

## ⚙️ What is a Custom Config?

A custom config overrides default Nginx behavior, giving full control over:
- Routing
- Performance
- Security
- Reverse proxy rules

---

## 🚀 Real-World Use Cases

### Reverse Proxy

```nginx
location / {
    proxy_pass http://app:3000;
}
```

---

### Load Balancing

```nginx
upstream backend {
    server app1;
    server app2;
}
```

---

### HTTPS Setup

```nginx
listen 443 ssl;
```

---

### Docker Integration

```bash
docker run -v ./nginx.conf:/etc/nginx/nginx.conf nginx
```

---

## 💡 Summary

This configuration:
- Defines how Nginx runs
- Serves static files
- Acts as a foundation for advanced setups

Perfect for DevOps learning and production setups.
