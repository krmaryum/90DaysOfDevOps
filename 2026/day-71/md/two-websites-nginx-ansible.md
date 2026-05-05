## Deploying Two Websites on a Single Server using Ansible and Nginx

### Overview

This guide demonstrates how to deploy multiple websites on a single server using Nginx and Ansible roles. This is a common real-world DevOps scenario and frequently asked in interviews.

---

### Concept

You can run multiple websites on one server by:

- Using the same Nginx instance
- Creating separate virtual host (vhost) configurations
- Assigning different ports or domains
- Using separate web root directories

---

### Architecture

Website 1:
- Config: /etc/nginx/conf.d/terraweek.conf
- Root: /var/www/terraweek
- Port: 80

Website 2:
- Config: /etc/nginx/conf.d/devopsapp.conf
- Root: /var/www/devopsapp
- Port: 8080

---

### Role Variables (defaults/main.yml)

```yaml
---
websites:
  - app_name: terraweek
    http_port: 80
  - app_name: devopsapp
    http_port: 8080

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
    listen {{ item.http_port }};
    server_name _;

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
<p>Server: {{ ansible_facts['hostname'] }}</p>
<p>IP: {{ ansible_facts['default_ipv4']['address'] }}</p>
<p>Managed by Ansible</p>
```

---

### Verification

Run playbook:

```bash
ansible-playbook site.yml
```

Test both websites:

```bash
curl http://<server-ip>:80
curl http://<server-ip>:8080
```

---

### Important Notes

- Make sure port 8080 is allowed in your firewall or AWS Security Group
- Each website must have a unique port or domain
- Nginx must be restarted after configuration changes

---

### Key Learning

- One Nginx server can host multiple applications
- Use loops in Ansible roles for scalability
- Virtual hosts separate applications cleanly

---

### Conclusion

This setup allows you to efficiently host multiple applications on a single server using automation. It demonstrates real-world configuration management and scalable infrastructure design.
