## Writing Multiple Lines in a File Using `cat`

### Overview

This guide explains how to create and write multiple lines into a file using the `cat` command in Linux. This technique is widely used in DevOps for creating configuration files quickly.

---

### Method 1: Using `cat` with EOF

The most common way to write multiple lines is:

```bash
cat <<EOF > filename.txt
line 1
line 2
line 3
EOF
```

This creates a new file and writes multiple lines into it.

---

### Example

```bash
cat <<EOF > index.html
<h1>My App</h1>
<p>Hello World</p>
EOF
```

This will create an HTML file with the given content.

---

### Append Instead of Overwrite

To add content without replacing the file:

```bash
cat <<EOF >> filename.txt
new line 1
new line 2
EOF
```

- `>`  = overwrite file  
- `>>` = append to file  

---

### What is EOF?

EOF stands for "End Of File". It is just a marker to tell the shell where the input ends.

You can use any word:

```bash
cat <<MYTEXT > file.txt
hello
world
MYTEXT
```

---

### Important Rules

1. The ending marker must match exactly:

```bash
EOF   ✔ correct
EOF   ❌ incorrect (extra space)
```

2. Do not add spaces before the closing marker:

```bash
    EOF ❌
EOF     ✔
```

---

### Real DevOps Example

Creating a config file:

```bash
cat <<EOF > nginx.conf
server {
    listen 80;
    root /var/www/app;
}
EOF
```

---

### Alternative Method (Less Recommended)

```bash
echo -e "line1\nline2\nline3" > file.txt
```

This works but is harder to read for long content.

---

### Key Learning

- `cat <<EOF` is the easiest way to write multi-line content  
- It is widely used for scripting and automation  
- Ideal for creating config files quickly  

---

### Conclusion

Using `cat` with EOF is a simple and powerful way to create multi-line files in Linux, especially useful in DevOps workflows and automation scripts.
