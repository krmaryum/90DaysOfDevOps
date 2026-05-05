# Ansible Vault - Protecting Secrets

## What is Ansible Vault?

**Ansible Vault** is a feature that allows you to encrypt sensitive data such as passwords, API keys, and credentials.

It ensures that secrets are protected even if your code is shared.

---

## Why Use Ansible Vault?

- Protect sensitive data
- Avoid storing secrets in plain text
- Secure automation workflows

---

## What Can Be Encrypted?

- Entire files
- Individual variables

---

## Creating an Encrypted File

```bash
ansible-vault create secrets.yml
```

You will be prompted to set a password.

---

## Viewing Encrypted File

```bash
ansible-vault view secrets.yml
```

---

## Editing Encrypted File

```bash
ansible-vault edit secrets.yml
```

---

## Using Vault in a Playbook

```yaml
- hosts: all
  vars_files:
    - secrets.yml

  tasks:
    - name: Show password
      debug:
        msg: "{{ db_password }}"
```

Run with:

```bash
ansible-playbook playbook.yml --ask-vault-pass
```

---

## Encrypting an Existing File

```bash
ansible-vault encrypt vars.yml
```

---

## Encrypting a Single Variable

```bash
ansible-vault encrypt_string 'mypassword' --name 'db_password'
```

---

## Decrypting a File

```bash
ansible-vault decrypt secrets.yml
```

---

## Best Practices

- Never store plain-text secrets
- Use strong passwords
- Separate secrets from code
- Use different vaults for environments (dev, prod)

---

## Summary

Ansible Vault secures sensitive information by encrypting it while allowing Ansible to use it safely during execution.
