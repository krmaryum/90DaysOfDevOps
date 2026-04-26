# 📘 Ansible: inventory_hostname Explanation

## 🧠 What is inventory_hostname?

`inventory_hostname` is the name of the host as defined in the Ansible inventory file.

It represents the current host on which Ansible is executing a task.

---

## 📂 Example Inventory

```ini
[web]
server1
server2

[db]
db1
```

---

## 🔍 Values of inventory_hostname

| Host     | inventory_hostname |
|----------|--------------------|
| server1  | server1            |
| server2  | server2            |
| db1      | db1                |

---

## 🔧 Example Usage

```yaml
- name: Show current host
  debug:
    msg: "Running on {{ inventory_hostname }}"
```

---

## 💡 Practical Use Cases

### 1. Dynamic File Creation

```yaml
- name: Create file per host
  copy:
    content: "This is {{ inventory_hostname }}"
    dest: "/tmp/{{ inventory_hostname }}.txt"
```

---

### 2. Conditional Execution

```yaml
- name: Run only on server1
  debug:
    msg: "This runs only on server1"
  when: inventory_hostname == "server1"
```

---

### 3. Unique Resource Naming

```yaml
- name: Run container
  docker_container:
    name: "nginx_{{ inventory_hostname }}"
```

---

## ⚠️ inventory_hostname vs ansible_hostname

| Variable              | Description |
|----------------------|------------|
| inventory_hostname   | Name in inventory file |
| ansible_hostname     | Actual hostname of the machine |

---

## 🚀 Summary

- Identifies the current host in Ansible
- Used for dynamic configurations
- Helps in automation and scaling setups

---

## 🧠 One-Line Summary

`inventory_hostname` is the identifier of the current host from the inventory during Ansible execution.
