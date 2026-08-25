# SSH — From Scratch to Advanced Study Notes

## 1. What is SSH?

**SSH = Secure Shell**

SSH is a secure network protocol used to remotely connect to and manage another computer or Linux server.

```bash
ssh username@server_ip
```

Example:

```bash
ssh khalid@192.168.1.20
```

### Important points

- Default SSH port: **TCP 22**
- SSH client command: `ssh`
- SSH server daemon: `sshd`
- Traffic is encrypted.
- SSH supports password-based and key-based authentication.

---

## 2. How SSH Works

```text
Client / Laptop
      |
      | TCP 22
      v
SSH Server (sshd)
      |
      v
Authentication
      |
      v
Remote Shell
```

Simple flow:

1. Client contacts the SSH server.
2. TCP connection is established.
3. Server identity is checked.
4. User authentication takes place.
5. An encrypted SSH session is created.
6. User gets a remote shell.

---

## 3. SSH Installation

### RHEL / CentOS / Rocky / AlmaLinux

```bash
sudo dnf install openssh-server
sudo systemctl enable --now sshd
systemctl status sshd
```

Install client:

```bash
sudo dnf install openssh-clients
```

### Ubuntu / Debian

```bash
sudo apt install openssh-server
sudo systemctl enable --now ssh
systemctl status ssh
```

---

## 4. Basic SSH Login

```bash
ssh user@server
```

Example:

```bash
ssh khalid@192.168.1.20
```

Using another port:

```bash
ssh -p 2222 khalid@192.168.1.20
```

---

## 5. SSH Authentication Methods

### Password Authentication

```bash
ssh user@server
```

The server asks for the user's account password.

### SSH Key Authentication

SSH key authentication is preferred for secure administration and automation.

Generate an Ed25519 key:

```bash
ssh-keygen -t ed25519
```

Typical files:

```text
~/.ssh/id_ed25519       -> Private key
~/.ssh/id_ed25519.pub   -> Public key
```

The public key is stored on the remote server in:

```text
~/.ssh/authorized_keys
```

### Golden Rule

**Never share your private SSH key.**

---

## 6. Copy Public Key to a Server

```bash
ssh-copy-id user@server
```

Example:

```bash
ssh-copy-id khalid@192.168.1.20
```

Then connect:

```bash
ssh khalid@192.168.1.20
```

---

## 7. Important SSH Files

### Client Side

```text
~/.ssh/
```

Important files:

```text
id_ed25519        Private key
id_ed25519.pub    Public key
known_hosts       Stores remote host keys
config            Client SSH configuration
```

### Server Side

Main SSH configuration:

```text
/etc/ssh/sshd_config
```

User authorized public keys:

```text
~/.ssh/authorized_keys
```

Server host keys:

```text
/etc/ssh/ssh_host_*
```

---

## 8. SSH Permissions

SSH is strict about ownership and permissions.

```bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
chmod 600 ~/.ssh/id_ed25519
chmod 644 ~/.ssh/id_ed25519.pub
```

Check:

```bash
ls -ld ~/.ssh
ls -l ~/.ssh
```

Correct ownership:

```bash
chown -R user:user ~/.ssh
```

---

## 9. Important sshd Configuration

File:

```text
/etc/ssh/sshd_config
```

Common options:

```text
Port 22
PermitRootLogin no
PasswordAuthentication yes
PubkeyAuthentication yes
```

Before applying configuration changes, validate:

```bash
sudo sshd -t
```

If there is no output, syntax is usually valid.

Reload safely:

```bash
sudo systemctl reload sshd
```

---

## 10. SSH Service Commands

Check status:

```bash
systemctl status sshd
```

Start:

```bash
sudo systemctl start sshd
```

Restart:

```bash
sudo systemctl restart sshd
```

Reload:

```bash
sudo systemctl reload sshd
```

Enable at boot:

```bash
sudo systemctl enable sshd
```

---

## 11. Check Whether SSH Is Listening

```bash
ss -lntp | grep :22
```

or:

```bash
ss -lntp | grep ssh
```

Example output:

```text
LISTEN 0 128 0.0.0.0:22
```

This means something is listening on TCP port 22.

---

## 12. Network Connectivity Tests

Test reachability:

```bash
ping server_ip
```

Test TCP port 22:

```bash
nc -vz server_ip 22
```

Example:

```bash
nc -vz 192.168.1.20 22
```

Check routing:

```bash
ip route
```

Trace network path:

```bash
traceroute server_ip
```

---

## 13. SSH Verbose Troubleshooting

Verbose mode is one of the most useful SSH troubleshooting tools.

```bash
ssh -v user@server
```

More detail:

```bash
ssh -vv user@server
```

Maximum detail:

```bash
ssh -vvv user@server
```

Use it to identify whether failure happens during:

- network connection
- host key checking
- key selection
- authentication
- session creation

---

## 14. Server-Side SSH Logs

### systemd journal

```bash
sudo journalctl -u sshd
```

Recent entries:

```bash
sudo journalctl -u sshd -n 100
```

Follow logs live:

```bash
sudo journalctl -u sshd -f
```

### RHEL-style authentication log

```bash
sudo tail -f /var/log/secure
```

### Ubuntu-style authentication log

```bash
sudo tail -f /var/log/auth.log
```

---

## 15. SSH Client Config

File:

```text
~/.ssh/config
```

Example:

```text
Host prod
    HostName 192.168.1.20
    User khalid
    Port 22
    IdentityFile ~/.ssh/id_ed25519
```

Now connect with:

```bash
ssh prod
```

instead of:

```bash
ssh khalid@192.168.1.20
```

---

## 16. Use a Specific SSH Key

```bash
ssh -i ~/.ssh/mykey user@server
```

AWS example:

```bash
ssh -i aws-key.pem ec2-user@server
```

Correct key permissions:

```bash
chmod 400 aws-key.pem
```

or:

```bash
chmod 600 aws-key.pem
```

---

## 17. SSH Agent

Start agent:

```bash
eval "$(ssh-agent -s)"
```

Add a private key:

```bash
ssh-add ~/.ssh/id_ed25519
```

List loaded keys:

```bash
ssh-add -l
```

---

## 18. Run Remote Commands

```bash
ssh user@server "hostname"
```

Example:

```bash
ssh khalid@server "df -h"
```

Multiple commands:

```bash
ssh khalid@server "hostname; uptime; df -h"
```

---

## 19. SCP

Copy local file to remote server:

```bash
scp file.txt user@server:/tmp/
```

Copy remote file to local system:

```bash
scp user@server:/tmp/file.txt .
```

Copy directory:

```bash
scp -r myfolder user@server:/tmp/
```

---

## 20. SFTP

Connect:

```bash
sftp user@server
```

Useful commands:

```text
ls
pwd
put file.txt
get file.txt
bye
```

---

## 21. Jump Host / Bastion Host

In many production environments, private servers cannot be accessed directly.

```text
Laptop
   |
   v
Bastion / Jump Host
   |
   v
Private Server
```

Command:

```bash
ssh -J jumpuser@jumpserver appuser@appserver
```

---

## 22. SSH Local Port Forwarding

Example:

```bash
ssh -L 3306:database.internal:3306 user@jump-server
```

Flow:

```text
Laptop:3306
    |
    v
SSH Tunnel
    |
    v
Jump Server
    |
    v
Database:3306
```

---

## 23. SSH Keepalive

If an SSH session disconnects because of idle timeout:

```bash
ssh -o ServerAliveInterval=60 user@server
```

Client config:

```text
Host *
    ServerAliveInterval 60
    ServerAliveCountMax 3
```

---

# SSH Failure Cases and Solutions

## 24. Connection Refused

Error:

```text
ssh: connect to host server port 22: Connection refused
```

### Meaning

The host is reachable, but SSH is not accepting connections on that port.

### Possible causes

- `sshd` stopped
- wrong SSH port
- service not listening
- firewall actively rejecting traffic

### Check

```bash
systemctl status sshd
ss -lntp | grep :22
grep -i '^Port' /etc/ssh/sshd_config
```

---

## 25. Connection Timed Out

Error:

```text
ssh: connect to host server port 22: Connection timed out
```

### Possible causes

- firewall
- AWS Security Group
- Network ACL
- routing
- VPN problem
- wrong IP
- server unavailable

### Check

```bash
ping server
nc -vz server 22
traceroute server
ip route
```

### Important Difference

```text
Connection refused
= Host usually reached, but service/port rejected connection.

Connection timed out
= Traffic is probably not reaching the SSH service.
```

---

## 26. Permission Denied

Error:

```text
Permission denied (publickey,password).
```

### Meaning

Network and SSH service are usually working, but authentication failed.

### Possible causes

- wrong username
- wrong password
- wrong private key
- public key missing
- bad permissions
- account restriction
- SSH policy restriction

### Troubleshoot

```bash
ssh -vvv user@server
```

Server:

```bash
journalctl -u sshd -f
```

Check:

```bash
cat ~/.ssh/authorized_keys
ls -ld ~/.ssh
ls -l ~/.ssh/authorized_keys
```

Fix:

```bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
chown -R user:user ~/.ssh
```

---

## 27. One User Can SSH but Another Cannot

Scenario:

```text
User A can SSH.
User B cannot SSH.
```

This suggests:

- network is probably OK
- port 22 is probably reachable
- `sshd` is probably running
- firewall is probably not the main problem

Focus on the affected user.

### Check the user

```bash
id user
getent passwd user
passwd -S user
chage -l user
```

### Check login shell

```bash
getent passwd user
```

Problem shells may include:

```text
/sbin/nologin
/bin/false
```

Normal interactive shell example:

```text
/bin/bash
```

### Check restrictions

```bash
grep -Ei 'AllowUsers|DenyUsers|AllowGroups|DenyGroups' /etc/ssh/sshd_config
```

### Check SSH key setup

```bash
ls -ld /home/user
ls -ld /home/user/.ssh
ls -l /home/user/.ssh/authorized_keys
```

Fix:

```bash
chown -R user:user /home/user/.ssh
chmod 700 /home/user/.ssh
chmod 600 /home/user/.ssh/authorized_keys
```

Monitor logs while the user retries:

```bash
journalctl -u sshd -f
```

---

## 28. Remote Host Identification Has Changed

Error:

```text
WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!
```

Possible reasons:

- server rebuilt
- host key regenerated
- IP address reused
- possible security issue

First verify that the server legitimately changed.

Then remove the old stored key:

```bash
ssh-keygen -R server
```

Example:

```bash
ssh-keygen -R 192.168.1.20
```

---

## 29. Unprotected Private Key

Error:

```text
WARNING: UNPROTECTED PRIVATE KEY FILE!
```

Fix:

```bash
chmod 600 private_key
```

or:

```bash
chmod 400 private_key
```

---

## 30. SSH Service Will Not Start

Check:

```bash
systemctl status sshd
```

Validate configuration:

```bash
sshd -t
```

If a configuration error exists, correct:

```text
/etc/ssh/sshd_config
```

Then restart:

```bash
sudo systemctl restart sshd
```

---

## 31. Wrong SSH Port

If server uses:

```text
Port 2222
```

Connect using:

```bash
ssh -p 2222 user@server
```

Check listening ports:

```bash
ss -lntp | grep ssh
```

---

## 32. Firewall Blocking SSH

Check:

```bash
firewall-cmd --list-all
```

Allow standard SSH:

```bash
sudo firewall-cmd --permanent --add-service=ssh
sudo firewall-cmd --reload
```

Custom port:

```bash
sudo firewall-cmd --permanent --add-port=2222/tcp
sudo firewall-cmd --reload
```

---

## 33. SELinux and SSH

Check SELinux:

```bash
getenforce
```

Check SSH allowed ports:

```bash
semanage port -l | grep ssh
```

If using a non-standard SSH port:

```bash
sudo semanage port -a -t ssh_port_t -p tcp 2222
```

Do not disable SELinux as the first troubleshooting step.

---

## 34. Account Locked

Check:

```bash
passwd -S user
```

Unlock if appropriate:

```bash
sudo passwd -u user
```

Check failed-login lockout:

```bash
faillock --user user
```

Reset when appropriate:

```bash
sudo faillock --user user --reset
```

---

## 35. Password or Account Expired

Check:

```bash
chage -l user
```

Review:

- Password expires
- Account expires
- Password inactive

Reset password when appropriate:

```bash
sudo passwd user
```

---

## 36. User Has nologin Shell

Check:

```bash
getent passwd user
```

Example problem:

```text
user:x:1005:1005::/home/user:/sbin/nologin
```

If the user should have an interactive shell:

```bash
sudo usermod -s /bin/bash user
```

---

## 37. DNS Problem

If:

```bash
ssh appserver
```

fails, but:

```bash
ssh 192.168.1.20
```

works, investigate DNS.

```bash
getent hosts appserver
nslookup appserver
dig appserver
```

---

## 38. SSH Hangs After Connecting

Possible causes:

- reverse DNS
- PAM problem
- LDAP / Active Directory issue
- NFS-mounted home directory problem
- system overload
- `.bashrc` or `.bash_profile` issue

Troubleshoot:

```bash
ssh -vvv user@server
journalctl -u sshd
top
```

Check login files:

```text
/etc/profile
/etc/bashrc
~/.bash_profile
~/.bashrc
```

---

## 39. Broken Pipe / Connection Reset

Possible causes:

- idle timeout
- unstable network
- firewall/NAT timeout
- VPN issue

Try:

```bash
ssh -o ServerAliveInterval=60 user@server
```

---

## 40. Too Many Authentication Failures

Error:

```text
Too many authentication failures
```

This can happen when the SSH agent has many keys loaded.

Check:

```bash
ssh-add -l
```

Specify correct key:

```bash
ssh -o IdentitiesOnly=yes -i ~/.ssh/correct_key user@server
```

---

## 41. No Route to Host

Error:

```text
No route to host
```

Possible causes:

- missing route
- wrong subnet
- gateway unavailable
- VPN issue
- firewall/network problem

Check:

```bash
ip route
ping gateway
traceroute server
```

---

## 42. Disk Full Can Affect SSH

Check:

```bash
df -h
df -i
```

A full filesystem can cause authentication or service problems because the system may be unable to create session files or write logs.

Investigate disk usage:

```bash
du -xsh /* 2>/dev/null | sort -h
```

Deleted-but-open files:

```bash
lsof +L1
```

---

# Production Troubleshooting Flow

When someone says:

> I cannot SSH to the server.

Use this sequence:

```text
1. Confirm hostname / IP
        |
        v
2. Test network connectivity
        |
        v
3. Test TCP port 22
        |
        v
4. Check SSH service
        |
        v
5. Check firewall / security rules
        |
        v
6. Check username and account
        |
        v
7. Check authentication method
        |
        v
8. Check password / key
        |
        v
9. Check ownership and permissions
        |
        v
10. Check sshd_config
        |
        v
11. Check SELinux / PAM / AD if applicable
        |
        v
12. Review logs
```

Useful commands:

```bash
ping server
nc -vz server 22
ssh -vvv user@server
systemctl status sshd
ss -lntp | grep :22
journalctl -u sshd -f
```

---

# Error Interpretation Cheat Sheet

| Error | Usually Means |
|---|---|
| `Connection refused` | Host reachable, SSH not accepting connection |
| `Connection timed out` | Network/firewall/routing path problem |
| `Permission denied` | Authentication, user, password, or SSH key problem |
| `No route to host` | Routing/network path issue |
| `Host identification has changed` | Server SSH host key changed |
| `Too many authentication failures` | Too many SSH keys attempted |
| `Broken pipe` | Timeout or network stability issue |
| `Could not resolve hostname` | DNS/name resolution issue |

---

# Commands to Memorize

## Client

```bash
ssh user@server
ssh -p 2222 user@server
ssh -i key.pem user@server
ssh -vvv user@server
ssh-keygen -t ed25519
ssh-copy-id user@server
ssh-keygen -R server
scp file.txt user@server:/tmp/
sftp user@server
```

## Server

```bash
systemctl status sshd
ss -lntp | grep :22
sshd -t
journalctl -u sshd
tail -f /var/log/secure
```

## User Troubleshooting

```bash
id user
getent passwd user
passwd -S user
chage -l user
faillock --user user
```

## Permissions

```bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
chown -R user:user ~/.ssh
```

## Network

```bash
ping server
nc -vz server 22
ip route
traceroute server
```

---

# Interview-Ready Answer

## Question

**A user says SSH is not working. How would you troubleshoot it?**

## Answer

I would first determine whether the problem is network-related, service-related, or authentication-related.

I would verify the hostname and IP address, test connectivity, and check whether TCP port 22 is reachable using `nc`.

If the port is not reachable, I would investigate routing, firewall rules, AWS Security Groups or Network ACLs, VPN connectivity, and whether `sshd` is listening.

If the connection reaches the server but authentication fails, I would check the username, account status, password or SSH key, `.ssh` ownership and permissions, shell, account expiry, and SSH access restrictions such as `AllowUsers` or `AllowGroups`.

I would use:

```bash
ssh -vvv user@server
```

on the client and:

```bash
journalctl -u sshd -f
```

on the server to correlate the failure.

I would avoid restarting SSH or changing configuration until I understand the root cause.

---

# Golden Rule

Think of SSH troubleshooting in four layers:

```text
NETWORK
   |
   v
SERVICE
   |
   v
AUTHENTICATION
   |
   v
USER / POLICY
```

**Troubleshoot SSH in layers: Network -> Service -> Authentication -> User.**

If **you can SSH but another user cannot**, network, firewall, port, and `sshd` are probably healthy. Focus first on that user's:

- account
- password
- SSH key
- shell
- lock/expiry
- `.ssh` ownership and permissions
- SSH access policies
- authentication logs
