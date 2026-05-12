# Nginx Configuration Template Explained Block by Block

## Template File

```nginx
{% if ansible_facts['os_family'] == "Debian" %}
user www-data;
{% elif ansible_facts['os_family'] == "RedHat" %}
user nginx;
{% endif %}

worker_processes auto;
pid /run/nginx.pid;

events {
    worker_connections 1024;
}

http {
    sendfile on;
    tcp_nopush on;
    types_hash_max_size 2048;

    include /etc/nginx/mime.types;
    default_type application/octet-stream;

    access_log /var/log/nginx/access.log;
    error_log /var/log/nginx/error.log;

    gzip on;

{% if ansible_facts['os_family'] == "Debian" %}
    include /etc/nginx/sites-enabled/*;
{% elif ansible_facts['os_family'] == "RedHat" %}
    include /etc/nginx/conf.d/*.conf;
{% endif %}
}
```

---

# 1. OS-Specific Nginx User

```nginx
{% if ansible_facts['os_family'] == "Debian" %}
user www-data;
{% elif ansible_facts['os_family'] == "RedHat" %}
user nginx;
{% endif %}
```

This block selects the correct Nginx system user depending on the operating system.

Ubuntu and Debian use:

```text
www-data
```

RedHat and Amazon Linux use:

```text
nginx
```

The template automatically generates the correct value.

---

# 2. Worker Processes

```nginx
worker_processes auto;
```

This tells Nginx to automatically determine the number of worker processes based on CPU cores.

Benefits:
- better CPU utilization
- automatic scaling
- improved performance

---

# 3. PID File

```nginx
pid /run/nginx.pid;
```

Stores the Nginx process ID.

Systemd uses this PID file to:
- stop Nginx
- restart Nginx
- reload Nginx

---

# 4. Events Block

```nginx
events {
    worker_connections 1024;
}
```

This section controls connection handling.

Each worker process can handle up to 1024 simultaneous connections.

Example:
- 4 workers
- 1024 connections each

Possible total:

```text
4096 connections
```

---

# 5. HTTP Block

```nginx
http {
```

Starts the main HTTP configuration section.

Everything related to web traffic is configured here.

Examples:
- MIME types
- logging
- gzip
- reverse proxies
- virtual hosts

---

# 6. Sendfile

```nginx
sendfile on;
```

Improves static file serving performance.

Linux kernel sends files directly to clients without unnecessary copying.

Benefits:
- lower CPU usage
- faster responses

---

# 7. TCP Optimization

```nginx
tcp_nopush on;
```

Optimizes packet transmission.

Works together with:

```nginx
sendfile on;
```

Benefits:
- improved network efficiency
- better large file delivery

---

# 8. MIME Type Hash Size

```nginx
types_hash_max_size 2048;
```

Controls memory allocation for MIME type lookups.

Nginx maps file extensions to content types.

Examples:

| Extension | MIME Type |
|---|---|
| .html | text/html |
| .css | text/css |
| .js | application/javascript |

---

# 9. MIME Types File

```nginx
include /etc/nginx/mime.types;
```

Loads MIME type definitions.

Without this:
- browsers may misinterpret files
- CSS and JavaScript may not load correctly

---

# 10. Default Content Type

```nginx
default_type application/octet-stream;
```

If Nginx cannot determine a file type, it treats the file as binary data.

Safe default behavior.

---

# 11. Access Log

```nginx
access_log /var/log/nginx/access.log;
```

Stores request logs.

Useful for:
- monitoring traffic
- debugging
- analytics

Examples:
- visitor IP
- request URL
- response code

---

# 12. Error Log

```nginx
error_log /var/log/nginx/error.log;
```

Stores Nginx error messages.

Useful for troubleshooting:
- config errors
- upstream failures
- permission problems

---

# 13. Gzip Compression

```nginx
gzip on;
```

Enables response compression.

Benefits:
- faster page loads
- reduced bandwidth usage
- smaller responses

Especially useful for:
- HTML
- CSS
- JavaScript

---

# 14. OS-Specific Include Paths

```nginx
{% if ansible_facts['os_family'] == "Debian" %}
    include /etc/nginx/sites-enabled/*;
{% elif ansible_facts['os_family'] == "RedHat" %}
    include /etc/nginx/conf.d/*.conf;
{% endif %}
```

This loads additional configuration files based on the operating system.

Debian/Ubuntu typically use:

```text
/etc/nginx/sites-enabled/
```

RedHat/Amazon Linux typically use:

```text
/etc/nginx/conf.d/
```

This makes the same template work across multiple Linux distributions.

---

# 15. Closing HTTP Block

```nginx
}
```

Closes the HTTP configuration section.

---

# What Happens Internally?

When Ansible deploys this template:

## Step 1

Reads:

```text
nginx.conf.j2
```

## Step 2

Processes Jinja2 logic:

```jinja2
{% if %}
{% elif %}
{% endif %}
```

## Step 3

Generates the correct config depending on OS.

## Step 4

Creates the final Nginx config file.

## Step 5

Copies it to:

```text
/etc/nginx/nginx.conf
```

## Step 6

Nginx reloads and starts using the new configuration.

---

# Summary

This template:
- supports Debian and RedHat systems
- dynamically selects correct Nginx users
- loads OS-specific configuration paths
- configures worker processes
- enables gzip compression
- enables logging
- improves file-serving performance
- uses Jinja2 conditional logic for cross-platform automation

This is a common DevOps automation pattern.
