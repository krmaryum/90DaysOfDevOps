## Hosting Multiple Websites on a Single Server Using Domain Names (Nginx + Ansible)

### Overview

This guide explains how to host multiple websites on a single server using Nginx and Ansible, based on domain names instead of different ports. This is a real-world production scenario.

---

### Concept

Instead of using different ports, Nginx routes traffic based on the domain name:

- terraweek.local → Website 1
- devopsapp.local → Website 2

Both run on port 80.

---

### Architecture

| Website | Domain | Root Directory |
|--------|--------|---------------|
| terraweek | terraweek.local | /var/www/terraweek |
| devopsapp | devopsapp.local | /var/www/devopsapp |

---

### Role Variables (defaults/main.yml)

```yaml
---
websites:
  - app_name: terraweek
    server_name: terraweek.local
  - app_name: devopsapp
    server_name: devopsapp.local

http_port: 80
max_connections: 512
```

---

### Tasks (tasks/main.yml)

```yaml
- name: Create web roots
  file:
    path: "/var/www/{{ item.app_name }}"
    state: directory
    mode: '0755'
  loop: "{{ websites }}"

- name: Deploy index pages
  template:
    src: index.html.j2
    dest: "/var/www/{{ item.app_name }}/index.html"
    mode: '0644'
  loop: "{{ websites }}"

- name: Deploy vhost configs
  template:
    src: vhost.conf.j2
    dest: "/etc/nginx/conf.d/{{ item.app_name }}.conf"
    mode: '0644'
  loop: "{{ websites }}"
  notify: Restart Nginx
```

---

### Virtual Host Template (vhost.conf.j2)

```nginx
server {
    listen {{ http_port }};
    server_name {{ item.server_name }};

    root /var/www/{{ item.app_name }};
    index index.html;

    location / {
        try_files $uri $uri/ =404;
    }
}
```

---

### Index Template (index.html.j2)

```html
<h1>{{ item.app_name }}</h1>
<p>Domain: {{ item.server_name }}</p>
<p>Server: {{ ansible_facts['hostname'] }}</p>
<p>IP: {{ ansible_facts['default_ipv4']['address'] }}</p>
<p>Managed by Ansible</p>
```

---

### Local Testing (Important)

Edit your local hosts file:

```bash
sudo vim /etc/hosts
```

Add:

```text
<server-public-ip> terraweek.local
<server-public-ip> devopsapp.local
```

---

### Verification

```bash
curl http://terraweek.local
curl http://devopsapp.local
```

---

### Key Learning

- Nginx can host multiple apps on same port using domains
- Domain-based routing is production standard
- Ansible loops make scaling easy

---

### Conclusion

This setup is closer to real-world production systems where multiple applications run on the same server using domain-based routing instead of ports.
