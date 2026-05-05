# Nginx Main Configuration (nginx.conf.j2)

## Overview
The `nginx.conf.j2` file is a Jinja2 template used to generate the main Nginx configuration file. It defines global settings that control how the Nginx server operates.

---

## Purpose
This file configures the core behavior of Nginx, including:
- Worker processes
- Connection handling
- HTTP settings
- Inclusion of virtual host configurations

---

## Example Configuration

```nginx
user www-data;
worker_processes auto;

events {
    worker_connections {{ max_connections }};
}

http {
    include /etc/nginx/mime.types;
    default_type application/octet-stream;

    sendfile on;
    keepalive_timeout 65;

    include /etc/nginx/conf.d/*.conf;
}
```

---

## Key Sections

### user
Defines the system user that runs Nginx.
```
user www-data;
```

---

### worker_processes
Specifies how many worker processes Nginx should use.
```
worker_processes auto;
```

---

### events block
Controls connection settings.
```
events {
    worker_connections {{ max_connections }};
}
```
- `max_connections` is dynamically set using Ansible variables.

---

### http block
Main configuration for handling web traffic.

Includes:
- MIME types
- Default file type
- Performance settings
- Virtual host configurations

---

### include directive
```
include /etc/nginx/conf.d/*.conf;
```

This loads all virtual host (server block) configurations.

---

## How It Works

1. Nginx starts
2. Reads `nginx.conf`
3. Loads all server block files from `conf.d/`
4. Uses those configurations to serve websites

---

## Relationship with vhost.conf

| File | Purpose |
|------|--------|
| nginx.conf | Global Nginx settings |
| vhost.conf | Individual website configuration |

---

## Why It Is Important

- Controls overall server performance
- Enables dynamic configuration via templates
- Connects global settings with website configurations

---

## Conclusion

The `nginx.conf.j2` template is essential for defining how Nginx operates at a global level. It ensures efficient performance and integrates virtual host configurations for serving applications.
