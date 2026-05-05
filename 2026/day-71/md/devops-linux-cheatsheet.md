## Linux Commands Cheat Sheet for DevOps

### File & Directory Management

```bash
pwd            # Show current directory
ls -l          # List files with details
cd /path       # Change directory
mkdir dir      # Create directory
rm -rf dir     # Remove directory
cp src dest    # Copy files
mv src dest    # Move/rename files
```

---

### File Content

```bash
cat file.txt           # View file
less file.txt          # Scroll view
head -n 10 file.txt    # First 10 lines
tail -n 10 file.txt    # Last 10 lines
```

---

### Multi-line File Creation

```bash
cat <<EOF > file.txt
line 1
line 2
EOF
```

---

### Permissions

```bash
chmod 755 file     # Change permissions
chown user:group file  # Change ownership
```

---

### Networking

```bash
ip a               # Show IP
ping google.com    # Test connectivity
curl http://site   # HTTP request
```

---

### Process Management

```bash
ps aux             # List processes
top                # Live processes
kill -9 PID        # Kill process
```

---

### Package Management

#### Ubuntu (APT)

```bash
sudo apt update
sudo apt install nginx
```

#### RedHat (YUM/DNF)

```bash
sudo yum install nginx
```

---

### Services

```bash
systemctl start nginx
systemctl stop nginx
systemctl restart nginx
systemctl status nginx
```

---

### Logs

```bash
journalctl -u nginx
tail -f /var/log/nginx/access.log
```

---

### SSH & Remote

```bash
ssh user@host
scp file user@host:/path
```

---

### DevOps Useful

```bash
df -h              # Disk usage
free -m            # Memory
uptime             # System uptime
whoami             # Current user
```

---

### Key Learning

- These commands are used daily in DevOps workflows
- Help in debugging, deployment, and system management
- Essential for automation tools like Ansible

---

### Conclusion

Mastering these Linux commands helps you manage servers efficiently and build strong DevOps foundations.
