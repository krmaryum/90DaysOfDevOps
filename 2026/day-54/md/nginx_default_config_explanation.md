# Nginx Configuration Explanation

A virtual server in Nginx is a configuration block that tells Nginx how to handle a specific type of incoming request, making one machine behave like many servers.

## 📄 Configuration File
```nginx
server {
    listen 80;

    location / {
        return 200 'Hello from Nginx';
    }

    location /health {
        return 200 'healthy';
    }
}
```

---

## 🧱 1. `server { ... }` block

This defines a **virtual server** in Nginx.

- It tells Nginx how to handle incoming requests.
- You can have multiple `server` blocks for different domains or ports.

---

## 🌐 2. `listen 80;`

- Tells Nginx to **listen on port 80** (default HTTP port).
- Any request like:

```
http://localhost
```

will be handled by this server block.

---

## 📍 3. `location / { ... }`

Handles requests to the **root path `/`**.

### Example request:
```
GET /
```

### Behavior:
```nginx
return 200 'Hello from Nginx';
```

- Returns:
  - HTTP status: **200 OK**
  - Response body: **Hello from Nginx**

### Result:
```
http://localhost/
```
➡️ Output:
```
Hello from Nginx
```

---

## ❤️ 4. `location /health { ... }`

This defines a **health check endpoint**.

### Example request:
```
GET /health
```

### Behavior:
```nginx
return 200 'healthy';
```

- Returns:
  - HTTP status: **200 OK**
  - Response body: **healthy**

### Result:
```
http://localhost/health
```
➡️ Output:
```
healthy
```

---

## 🚀 Why this is useful

### ✅ Kubernetes / DevOps

- `/health` is commonly used for:
  - **Liveness probes**
  - **Readiness probes**

- Helps systems determine:
  - If the application is running
  - If it is ready to receive traffic

### ✅ Quick Testing

- No backend required
- Useful for testing Nginx setups quickly

---

## 🧠 Key Concepts Summary

| Directive        | Meaning |
|------------------|--------|
| `server`         | Defines a virtual host |
| `listen 80`      | Accepts traffic on port 80 |
| `location /`     | Matches root URL |
| `location /health` | Matches `/health` endpoint |
| `return 200`     | Sends an immediate response |

---

## ⚡ Bonus Tip

In Kubernetes setups, this file is often:

- Stored in a **ConfigMap**
- Mounted into an Nginx container

This allows dynamic configuration without rebuilding images.

