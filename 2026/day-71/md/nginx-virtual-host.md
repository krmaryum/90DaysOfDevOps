# Nginx Virtual Host (Server Block) Configuration

## Overview
An Nginx virtual host (also called a **server block**) is a configuration that defines how Nginx serves a specific website or application. It allows a single Nginx server to host multiple websites, each with its own settings.

---

## Simple Definition
A **server block** is a set of rules that tells Nginx:
- Which domain or IP to respond to
- Which port to listen on
- Where the website files are located
- How to handle requests

---

## Example Configuration

```nginx
server {
    listen 80;
    server_name example.com;

    root /var/www/example;
    index index.html;
}
```

---

## Key Components

### listen
Specifies the port Nginx listens on.
```
listen 80;
```

### server_name
Defines the domain name or IP address for the website.
```
server_name example.com;
```

### root
Specifies the directory where website files are stored.
```
root /var/www/example;
```

### index
Defines the default file to serve.
```
index index.html;
```

---

## How It Works

1. User enters a URL in the browser  
2. Request reaches the server  
3. Nginx checks all server blocks  
4. Matches the correct `server_name`  
5. Serves content from the defined `root`  

---

## Real Example (Your Setup)

```nginx
server {
    listen 80;
    server_name 18.188.187.22;

    root /var/www/terraweek;
}
```

When a user visits your IP:
- Nginx uses this configuration
- Serves files from `/var/www/terraweek`

---

## Why Virtual Hosts Are Important

- Host multiple websites on one server
- Separate configurations per application
- Better organization and scalability

---

## Analogy

Think of Nginx as an apartment building:
- Building = Nginx server
- Each apartment = server block
- Each tenant = website

---

## Conclusion

An Nginx virtual host (server block) is essential for hosting and managing multiple websites efficiently. It defines how requests are handled and where content is served from.
