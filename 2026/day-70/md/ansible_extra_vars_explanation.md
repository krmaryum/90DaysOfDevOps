# Ansible Command Explanation

## Command
`ansible-playbook playbooks/variables-demo.yml -e "app_name=my-custom-app app_port=9090"`

---

## Breakdown

### 1. ansible-playbook
This command runs an Ansible playbook.

### 2. playbooks/variables-demo.yml
This is the path to your playbook file.

It contains:
- hosts
- tasks
- variables (app_name, app_port, etc.)

### 3. -e (extra vars)
-e stands for extra variables\
The `-e` flag is used to pass variables at runtime.\
It lets you override variables at runtime without editing the playbook.\

### 4. 'app_name=my-custom-app app_port=9090'
These variables override the default values in your playbook.\
You are passing values dynamically:

| Variable   | Value           |
| ---------- | --------------- |
| `app_name` | `my-custom-app` |
| `app_port` | `9090`          |

---

## What Happens

If your playbook has:
```
app_name: terraweek_app
app_port: 8080
```

Running the command overrides them to:
```
app_name: my-custom-app
app_port: 9090
```

---

## Result in Playbook

This task:
```
msg: "Deploying {{ app_name }} on port {{ app_port }}"
```

Will output:
```
Deploying my-custom-app on port 9090
```

---

## Variable precedence (important)

`-e` variables have highest priority in Ansible.

Even if the same variable exists in:

- vars
- group_vars
- host_vars

`-e` will override all of them.

---

## Why Use -e?

- Reuse the same playbook for different environments
- Avoid editing files manually
- Quick testing

You can reuse the same playbook for different environments:

---

## Example Usage

```
# Dev
ansible-playbook play.yml -e "app_name=dev-app app_port=8081"

# Staging
ansible-playbook play.yml -e "app_name=staging-app app_port=8082"

# Production
ansible-playbook play.yml -e "app_name=prod-app app_port=80"
```

---

## Note

For complex values, use JSON format:
```
ansible-playbook play.yml -e '{"app_name":"my app","app_port":9090}'
```
