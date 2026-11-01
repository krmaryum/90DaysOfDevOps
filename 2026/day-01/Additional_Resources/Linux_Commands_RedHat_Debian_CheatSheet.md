# RedHat VS Debain

# Common Package Managers

| Distribution      | Package Manager |
| ----------------- | --------------- |
| RHEL 8/9, Fedora  | `dnf`           |
| Older CentOS/RHEL | `yum`           |
| Debian/Ubuntu     | `apt`           |

# Common Package Managers

| Distribution      | Package Manager |
| ----------------- | --------------- |
| RHEL 8/9, Fedora  | `dnf`           |
| Older CentOS/RHEL | `yum`           |
| Debian/Ubuntu     | `apt`           |

# Useful Admin Commands

```bash
# Find files
find / -name nginx.conf

# Search inside files
grep -r "listen" /etc/nginx/

# Download file
wget https://example.com/file.tar.gz

# Extract tar.gz
tar -xvzf file.tar.gz

# SSH into server
ssh user@server-ip

# Copy files securely
scp file.txt user@server:/tmp/

# Monitor logs live
tail -f /var/log/messages
```

# Quick Service Management

```bash
systemctl start nginx
systemctl stop nginx
systemctl restart nginx
systemctl enable nginx
systemctl disable nginx
systemctl status nginx
```

# Networking Quick Checks

```bash
ping google.com
curl ifconfig.me
ip route
nmcli device status
```

# Permission Numbers

| Permission | Number |
| ---------- | ------ |
| `rwx`      | 7      |
| `rw-`      | 6      |
| `r-x`      | 5      |
| `r--`      | 4      |

### Example:
```bash
chmod 755 script.sh
```

# Important Config Paths

| Service        | Red Hat                           | Debian                    |
| -------------- | --------------------------------- | ------------------------- |
| Network config | `/etc/sysconfig/network-scripts/` | `/etc/network/interfaces` |
| Apache config  | `/etc/httpd/`                     | `/etc/apache2/`           |
| Nginx config   | `/etc/nginx/`                     | `/etc/nginx/`             |
| DNS config     | `/etc/resolv.conf`                | `/etc/resolv.conf`        |

# Package File Types

| Distribution   | Package Type |
| -------------- | ------------ |
| Red Hat family | `.rpm`       |
| Debian family  | `.deb`       |

### Install manually:
```bash
# RPM
rpm -ivh package.rpm

# DEB
dpkg -i package.deb
```



| Task                        | Red Hat / RHEL / CentOS / Fedora             | Debian / Ubuntu           |
| --------------------------- | -------------------------------------------- | ------------------------- |
| Update package list         | `dnf check-update`                           | `apt update`              |
| Upgrade packages            | `dnf upgrade -y`                             | `apt upgrade -y`          |
| Install package             | `dnf install nginx -y`                       | `apt install nginx -y`    |
| Remove package              | `dnf remove nginx -y`                        | `apt remove nginx -y`     |
| Search package              | `dnf search nginx`                           | `apt search nginx`        |
| Package info                | `dnf info nginx`                             | `apt show nginx`          |
| List installed packages     | `dnf list installed`                         | `apt list --installed`    |
| Clean package cache         | `dnf clean all`                              | `apt clean`               |
| Enable service              | `systemctl enable nginx`                     | `systemctl enable nginx`  |
| Start service               | `systemctl start nginx`                      | `systemctl start nginx`   |
| Stop service                | `systemctl stop nginx`                       | `systemctl stop nginx`    |
| Restart service             | `systemctl restart nginx`                    | `systemctl restart nginx` |
| Service status              | `systemctl status nginx`                     | `systemctl status nginx`  |
| View logs                   | `journalctl -xe`                             | `journalctl -xe`          |
| Firewall open port          | `firewall-cmd --add-port=80/tcp --permanent` | `ufw allow 80/tcp`        |
| Reload firewall             | `firewall-cmd --reload`                      | `ufw reload`              |
| Check firewall rules        | `firewall-cmd --list-all`                    | `ufw status`              |
| Network interfaces          | `ip addr`                                    | `ip addr`                 |
| Check listening ports       | `ss -tulpn`                                  | `ss -tulpn`               |
| Disk usage                  | `df -h`                                      | `df -h`                   |
| Memory usage                | `free -m`                                    | `free -m`                 |
| CPU processes               | `top` / `htop`                               | `top` / `htop`            |
| Create user                 | `useradd khalid`                             | `adduser khalid`          |
| Change password             | `passwd khalid`                              | `passwd khalid`           |
| Add sudo user               | `usermod -aG wheel khalid`                   | `usermod -aG sudo khalid` |
| File permissions            | `chmod 755 file.sh`                          | `chmod 755 file.sh`       |
| Change ownership            | `chown user:user file`                       | `chown user:user file`    |
| SELinux status              | `getenforce`                                 | N/A                       |
| Disable SELinux temporarily | `setenforce 0`                               | N/A                       |
| AppArmor status             | N/A                                          | `aa-status`               |
| Reboot system               | `reboot`                                     | `reboot`                  |
| Shutdown system             | `shutdown -h now`                            | `shutdown -h now`         |

