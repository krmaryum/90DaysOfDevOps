# Ansible Jinja2 Template: DB Config Explanation

## Template File: `templates/db-config.j2`

``` jinja2
# Database Configuration -- Managed by Ansible
DB_HOST={ ansible_facts['default_ipv4']['address'] }
DB_PORT={ db_port | default(3306) }
DB_PASSWORD={ vault_db_password }
DB_ROOT_PASSWORD={ vault_db_root_password }
```

------------------------------------------------------------------------

## Explanation

### DB_HOST

Uses Ansible facts to fetch the machine's **private IP address**.

-   Example: `192.168.1.10`
-   Not a public IP
-   Ideal for internal communication

------------------------------------------------------------------------

### DB_PORT

Uses a variable with a default fallback:

-   If `db_port` is defined → uses that
-   Otherwise defaults to `3306`

------------------------------------------------------------------------

### DB_PASSWORD

Pulled from a secure variable (typically stored using Ansible Vault).

------------------------------------------------------------------------

### DB_ROOT_PASSWORD

Same as above, but for the root database user.

------------------------------------------------------------------------

## How It's Used

This template is rendered using the Ansible `template` module:

``` yaml
- name: Create DB config file
  template:
    src: templates/db-config.j2
    dest: /etc/myapp/db.conf
```

------------------------------------------------------------------------

## Example Output

``` env
DB_HOST=10.0.0.5
DB_PORT=3306
DB_PASSWORD=******
DB_ROOT_PASSWORD=******
```

------------------------------------------------------------------------

## Notes

-   Uses private IP, not public IP
-   Secrets should be encrypted using Ansible Vault
-   Missing variables will cause playbook failure

------------------------------------------------------------------------

Generated on: 2026-05-05 02:32:19
