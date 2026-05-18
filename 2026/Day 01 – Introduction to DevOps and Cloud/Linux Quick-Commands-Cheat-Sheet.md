RedHat VS Debain

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
