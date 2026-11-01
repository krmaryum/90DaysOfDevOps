# SSH — From Scratch to Advanced Study Notes (Roman Urdu)

## 1. SSH Kya Hai?

**SSH = Secure Shell**

SSH aik secure network protocol hai jo kisi doosray computer ya Linux server par remotely connect honay aur usay manage karne ke liye use hota hai.

```bash
ssh username@server_ip
```

Example:

```bash
ssh khalid@192.168.1.20
```

### Important Points

- Default SSH port: **TCP 22**
- SSH client command: `ssh`
- SSH server daemon: `sshd`
- SSH traffic encrypted hota hai.
- SSH password-based aur key-based authentication support karta hai.

---

## 2. SSH Kaise Kaam Karta Hai?

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

1. Client SSH server se contact karta hai.
2. TCP connection establish hoti hai.
3. Server ki identity verify hoti hai.
4. User authentication hoti hai.
5. Encrypted SSH session create hota hai.
6. User ko remote shell mil jata hai.

---

## 3. SSH Installation

### RHEL / CentOS / Rocky / AlmaLinux

```bash
sudo dnf install openssh-server
sudo systemctl enable --now sshd
systemctl status sshd
```

Client install karne ke liye:

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

Agar doosra port use ho raha ho:

```bash
ssh -p 2222 khalid@192.168.1.20
```

---

## 5. SSH Authentication Methods

### Password Authentication

```bash
ssh user@server
```

Server user ka account password maangta hai.

### SSH Key Authentication

SSH key authentication secure administration aur automation ke liye bohat useful hai.

Ed25519 key generate karne ke liye:

```bash
ssh-keygen -t ed25519
```

Typical files:

```text
~/.ssh/id_ed25519       -> Private key
~/.ssh/id_ed25519.pub   -> Public key
```

Public key remote server par yahan store hoti hai:

```text
~/.ssh/authorized_keys
```

### Golden Rule

**Apni private SSH key kabhi share na karein.**

---

## 6. Public Key Server Par Copy Karna

```bash
ssh-copy-id user@server
```

Example:

```bash
ssh-copy-id khalid@192.168.1.20
```

Phir connect karein:

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
known_hosts       Remote host keys store karta hai
config            Client SSH configuration
```

### Server Side

Main SSH configuration:

```text
/etc/ssh/sshd_config
```

User ki authorized public keys:

```text
~/.ssh/authorized_keys
```

Server host keys:

```text
/etc/ssh/ssh_host_*
```

---

## 8. SSH Permissions

SSH ownership aur permissions ke mamlay mein strict hota hai.

```bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
chmod 600 ~/.ssh/id_ed25519
chmod 644 ~/.ssh/id_ed25519.pub
```

Check karne ke liye:

```bash
ls -ld ~/.ssh
ls -l ~/.ssh
```

Ownership theek karne ke liye:

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

Configuration apply karne se pehle validate karein:

```bash
sudo sshd -t
```

Agar koi output na aaye to syntax aam tor par valid hoti hai.

Safe reload:

```bash
sudo systemctl reload sshd
```

---

## 10. SSH Service Commands

Status check:

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

Boot par enable:

```bash
sudo systemctl enable sshd
```

---

## 11. SSH Listening Check Karna

```bash
ss -lntp | grep :22
```

ya:

```bash
ss -lntp | grep ssh
```

Example output:

```text
LISTEN 0 128 0.0.0.0:22
```

Iska matlab hai ke TCP port 22 par service listen kar rahi hai.

---

## 12. Network Connectivity Tests

Reachability check:

```bash
ping server_ip
```

TCP port 22 check:

```bash
nc -vz server_ip 22
```

Example:

```bash
nc -vz 192.168.1.20 22
```

Routing check:

```bash
ip route
```

Network path trace:

```bash
traceroute server_ip
```

---

## 13. SSH Verbose Troubleshooting

Verbose mode SSH troubleshooting ka bohat important tool hai.

```bash
ssh -v user@server
```

Zyada detail:

```bash
ssh -vv user@server
```

Maximum detail:

```bash
ssh -vvv user@server
```

Is se pata lagta hai ke failure kis stage par ho rahi hai:

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

Live logs:

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

Ab aap simply likh sakte hain:

```bash
ssh prod
```

instead of:

```bash
ssh khalid@192.168.1.20
```

---

## 16. Specific SSH Key Use Karna

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

ya:

```bash
chmod 600 aws-key.pem
```

---

## 17. SSH Agent

Agent start karein:

```bash
eval "$(ssh-agent -s)"
```

Private key add karein:

```bash
ssh-add ~/.ssh/id_ed25519
```

Loaded keys list karein:

```bash
ssh-add -l
```

---

## 18. Remote Command Run Karna

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

Local file remote server par copy:

```bash
scp file.txt user@server:/tmp/
```

Remote file local system par copy:

```bash
scp user@server:/tmp/file.txt .
```

Directory copy:

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

Production environments mein private servers ko aksar direct access nahi diya jata.

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

Agar SSH session idle timeout ki wajah se disconnect hoti ho:

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

# SSH Failure Cases aur Solutions

## 24. Connection Refused

Error:

```text
ssh: connect to host server port 22: Connection refused
```

### Meaning

Host reachable hai, lekin SSH us port par connection accept nahi kar raha.

### Possible Causes

- `sshd` stopped hai
- wrong SSH port
- service listen nahi kar rahi
- firewall connection actively reject kar raha hai

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

### Possible Causes

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
= Host aam tor par reachable hai, lekin service/port connection reject kar raha hai.

Connection timed out
= Traffic shayad SSH service tak pohanch hi nahi rahi.
```

---

## 26. Permission Denied

Error:

```text
Permission denied (publickey,password).
```

### Meaning

Network aur SSH service aam tor par theek hoti hai, lekin authentication fail ho gayi.

### Possible Causes

- wrong username
- wrong password
- wrong private key
- public key missing
- permissions ghalat
- account restriction
- SSH policy restriction

### Troubleshoot

```bash
ssh -vvv user@server
```

Server side:

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

## 27. Ek User SSH Kar Sakta Hai, Doosra Nahi

Scenario:

```text
User A SSH kar sakta hai.
User B SSH nahi kar sakta.
```

Iska matlab aam tor par:

- network probably OK
- port 22 probably reachable
- `sshd` probably running
- firewall main problem probably nahi

Ab affected user par focus karein.

### User Check

```bash
id user
getent passwd user
passwd -S user
chage -l user
```

### Login Shell Check

```bash
getent passwd user
```

Problem shells:

```text
/sbin/nologin
/bin/false
```

Normal interactive shell example:

```text
/bin/bash
```

### Restrictions Check

```bash
grep -Ei 'AllowUsers|DenyUsers|AllowGroups|DenyGroups' /etc/ssh/sshd_config
```

### SSH Key Setup Check

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

User ko dobara try karwa kar logs monitor karein:

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

- server rebuild hua
- host key regenerate hui
- IP reuse hua
- possible security issue

Pehle verify karein ke server legitimately change hua hai.

Phir old stored key remove karein:

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

ya:

```bash
chmod 400 private_key
```

---

## 30. SSH Service Start Nahi Ho Rahi

Check:

```bash
systemctl status sshd
```

Configuration validate karein:

```bash
sshd -t
```

Agar configuration error ho to:

```text
/etc/ssh/sshd_config
```

ko correct karein.

Phir restart:

```bash
sudo systemctl restart sshd
```

---

## 31. Wrong SSH Port

Agar server use kar raha ho:

```text
Port 2222
```

to connect karein:

```bash
ssh -p 2222 user@server
```

Listening ports check:

```bash
ss -lntp | grep ssh
```

---

## 32. Firewall SSH Block Kar Raha Hai

Check:

```bash
firewall-cmd --list-all
```

Standard SSH allow:

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

## 33. SELinux aur SSH

SELinux status:

```bash
getenforce
```

SSH allowed ports:

```bash
semanage port -l | grep ssh
```

Agar non-standard SSH port use ho:

```bash
sudo semanage port -a -t ssh_port_t -p tcp 2222
```

SELinux ko first troubleshooting step mein disable na karein.

---

## 34. Account Locked

Check:

```bash
passwd -S user
```

Agar appropriate ho to unlock:

```bash
sudo passwd -u user
```

Failed-login lockout check:

```bash
faillock --user user
```

Reset jab appropriate ho:

```bash
sudo faillock --user user --reset
```

---

## 35. Password ya Account Expired

Check:

```bash
chage -l user
```

Review:

- Password expires
- Account expires
- Password inactive

Password reset:

```bash
sudo passwd user
```

---

## 36. User Ka Shell `nologin` Hai

Check:

```bash
getent passwd user
```

Problem example:

```text
user:x:1005:1005::/home/user:/sbin/nologin
```

Agar user ko interactive shell chahiye:

```bash
sudo usermod -s /bin/bash user
```

---

## 37. DNS Problem

Agar:

```bash
ssh appserver
```

fail ho raha hai, lekin:

```bash
ssh 192.168.1.20
```

work karta hai, to DNS investigate karein.

```bash
getent hosts appserver
nslookup appserver
dig appserver
```

---

## 38. SSH Connect Hone Ke Baad Hang Ho Jata Hai

Possible causes:

- reverse DNS
- PAM problem
- LDAP / Active Directory issue
- NFS-mounted home directory problem
- system overload
- `.bashrc` ya `.bash_profile` issue

Troubleshoot:

```bash
ssh -vvv user@server
journalctl -u sshd
top
```

Login files check:

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

Yeh tab ho sakta hai jab SSH agent mein bohat sari keys loaded hon.

Check:

```bash
ssh-add -l
```

Correct key specify karein:

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

## 42. Disk Full SSH Ko Affect Kar Sakta Hai

Check:

```bash
df -h
df -i
```

Agar filesystem full ho to authentication ya service problems aa sakti hain kyun ke system session files create ya logs write nahi kar pata.

Disk usage investigate:

```bash
du -xsh /* 2>/dev/null | sort -h
```

Deleted-but-open files:

```bash
lsof +L1
```

---

# Production Troubleshooting Flow

Jab koi kahe:

> Main server par SSH nahi kar pa raha.

To yeh sequence follow karein:

```text
1. Hostname / IP confirm karein
        |
        v
2. Network connectivity test karein
        |
        v
3. TCP port 22 test karein
        |
        v
4. SSH service check karein
        |
        v
5. Firewall / security rules check karein
        |
        v
6. Username aur account check karein
        |
        v
7. Authentication method check karein
        |
        v
8. Password / key check karein
        |
        v
9. Ownership aur permissions check karein
        |
        v
10. sshd_config check karein
        |
        v
11. Zarurat ho to SELinux / PAM / AD check karein
        |
        v
12. Logs review karein
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

| Error | Aam Tor Par Matlab |
|---|---|
| `Connection refused` | Host reachable hai, SSH connection accept nahi kar raha |
| `Connection timed out` | Network/firewall/routing path problem |
| `Permission denied` | Authentication, user, password, ya SSH key problem |
| `No route to host` | Routing/network path issue |
| `Host identification has changed` | Server SSH host key change hui |
| `Too many authentication failures` | Bohat sari SSH keys try hui |
| `Broken pipe` | Timeout ya network stability issue |
| `Could not resolve hostname` | DNS/name resolution issue |

---

# Commands Jo Yaad Hone Chahiye

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

**A user kehta hai SSH kaam nahi kar raha. Aap kaise troubleshoot karenge?**

## Answer

Main sab se pehle yeh determine karunga ke issue network-related hai, service-related hai, ya authentication-related.

Main hostname aur IP verify karunga, connectivity test karunga, aur `nc` se check karunga ke TCP port 22 reachable hai ya nahi.

Agar port reachable nahi hai, to routing, firewall rules, AWS Security Groups, Network ACLs, VPN connectivity, aur `sshd` listening status check karunga.

Agar connection server tak pohanch raha hai lekin authentication fail ho rahi hai, to username, account status, password ya SSH key, `.ssh` ownership aur permissions, login shell, account expiry, aur SSH access restrictions jaise `AllowUsers` ya `AllowGroups` check karunga.

Client side par:

```bash
ssh -vvv user@server
```

aur server side par:

```bash
journalctl -u sshd -f
```

use karke dono sides ki information correlate karunga.

Main bina root cause samjhay SSH restart ya configuration change nahi karunga.

---

# Golden Rule

SSH troubleshooting ko 4 layers mein sochain:

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

Agar **aap SSH kar sakte hain lekin doosra user nahi**, to network, firewall, port, aur `sshd` probably theek hain.

Sab se pehle affected user ki yeh cheezein check karein:

- account
- password
- SSH key
- shell
- lock/expiry
- `.ssh` ownership aur permissions
- SSH access policies
- authentication logs
