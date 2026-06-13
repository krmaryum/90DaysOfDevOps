# Understanding Git Commit Outputs

## First Commit Example

```bash
[main (root-commit) 68f5819] Commit A
 1 file changed, 1 insertion(+)
 create mode 100644 reset-practice.txt
```

### Explanation

#### `(root-commit)`
This indicates:
- It is the **first commit** in the repository
- No previous commit history exists

#### `1 file changed, 1 insertion(+)`
This means:
- One file was modified
- One new line was added

#### `create mode 100644 reset-practice.txt`
This means:
- A brand new file was added to Git tracking
- `100644` is the file permission mode for a normal non-executable file

---

## Subsequent Commit Example

```bash
[main 0732480] Commit B
 1 file changed, 1 insertion(+)
```

### Explanation

This is a normal commit after history already exists.

Notice:
- No `(root-commit)` appears
- No `create mode` appears

That usually means:
- The file already existed
- Git is recording additional changes

---

## Commit Hashes

Examples:
```bash
68f5819
0732480
```

These are shortened commit IDs (hashes) used to uniquely identify commits.

---

## File Permission Modes in Git

| Mode | Meaning |
|------|---------|
| `100644` | Normal non-executable file |
| `100755` | Executable file |

Example:
```bash
chmod +x deploy.sh
```

Git may then show:
```bash
create mode 100755 deploy.sh
```
