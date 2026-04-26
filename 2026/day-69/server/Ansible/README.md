### Module Explanations
#### apt / yum

Used for package management.

- `apt` is used for Ubuntu/Debian systems
- `yum` is used for Red Hat and Amazon Linux
- `state: present` ensures packages are installed

---

### service

Used to manage system services.

- state: started ensures the service is running
- enabled: true ensures it starts on boot

---

### copy

Copies files from the control node to managed nodes.

- `src` → local file path
- `dest` → destination path on remote server

---

### When to Use

- Use **command** for simple and secure execution
- Use **shell** only when shell features are required

---

### debug

Used to print variables and outputs.

- Helps in debugging and verification

---

### lineinfile

Ensures a specific line exists in a file.

- Can create the file if it does not exist
- Prevents duplicate entries

---

## Difference Between command and shell
#### command module
- Executes commands directly without using a shell
- Does NOT support:
   - pipes (|)
   - redirects (>)
   - wildcards (*)
   - environment variables ($HOME)
   - More secure and predictable

Example:
```YAML
command: df -h
```

---

#### shell module
- Executes commands through a shell (/bin/bash)
- Supports:
   - pipes (|)
   - redirects (>)
   - chaining commands
   - environment variables

Example:
```YAML
shell: ps aux | wc -l
```

#### When to use each
- Use command by default (safer)
- Use shell only when shell features are required

### Important difference
#### Bad practice
```YAML
- name: Create directory (wrong)
  shell: mkdir /opt/myapp
```
#### Problems:

- Not idempotent
- Can fail if exists
- Not clean

#### Correct (what you did)
```YAML
- name: Create directory
  file:
    path: /opt/myapp
    state: directory
```
Best practice