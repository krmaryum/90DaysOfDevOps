# Day 05 — SSH Troubleshooting Runbook

A production-minded, step-by-step runbook for diagnosing SSH connection, service, authentication, configuration, firewall, and resource problems on Linux.

This document is designed for:

- Linux administration labs
- Ubuntu and Rocky Linux systems
- AWS or other cloud virtual machines
- Incident troubleshooting
- RHCSA and interview revision

> **Critical safety rule:** If you are already connected remotely, keep that SSH session open. Do not restart SSH, change firewall rules, or edit authentication settings until you have validated the configuration and confirmed an alternate recovery path.

## Table of Contents

- [1. Runbook Goals](#1-runbook-goals)
- [2. Scope and Service Names](#2-scope-and-service-names)
- [3. SSH Troubleshooting Model](#3-ssh-troubleshooting-model)
- [4. Phase 1 — Confirm Impact and Preserve Access](#4-phase-1--confirm-impact-and-preserve-access)
- [5. Phase 2 — Capture a Time-Stamped Baseline](#5-phase-2--capture-a-time-stamped-baseline)
- [6. Phase 3 — Test from the Client](#6-phase-3--test-from-the-client)
- [7. Phase 4 — Verify the Server Listener](#7-phase-4--verify-the-server-listener)
- [8. Phase 5 — Check SSH Service State](#8-phase-5--check-ssh-service-state)
- [9. Phase 6 — Inspect Logs](#9-phase-6--inspect-logs)
- [10. Phase 7 — Validate SSH Configuration](#10-phase-7--validate-ssh-configuration)
- [11. Phase 8 — Check User and Key Authentication](#11-phase-8--check-user-and-key-authentication)
- [12. Phase 9 — Check Permissions and Ownership](#12-phase-9--check-permissions-and-ownership)
- [13. Phase 10 — Check Firewall and Network Path](#13-phase-10--check-firewall-and-network-path)
- [14. Phase 11 — Check Cloud Access Controls](#14-phase-11--check-cloud-access-controls)
- [15. Phase 12 — Check System Resources](#15-phase-12--check-system-resources)
- [16. Error-to-Cause Decision Table](#16-error-to-cause-decision-table)
- [17. Safe Recovery Actions](#17-safe-recovery-actions)
- [18. Post-Recovery Verification](#18-post-recovery-verification)
- [19. Escalation Package](#19-escalation-package)
- [20. Historical Snapshot from the Original Record](#20-historical-snapshot-from-the-original-record)
- [21. Common Mistakes](#21-common-mistakes)
- [22. Interview-Style Answer](#22-interview-style-answer)
- [23. Quick Command Reference](#23-quick-command-reference)
- [24. Completion Checklist](#24-completion-checklist)

---

## 1. Runbook Goals

Use this runbook to answer five questions:

1. **What is failing?** Network connection, service, protocol handshake, or authentication?
2. **Who is affected?** One user, one source network, or everyone?
3. **Where is the failure?** Client, network path, firewall, SSH daemon, account, or key?
4. **What evidence supports the conclusion?**
5. **What is the least disruptive safe recovery action?**

### Expected outcome

At the end of the investigation, you should have:

- A clearly defined symptom
- Time-stamped evidence
- A likely fault domain
- A safe corrective action or escalation path
- Verification that access is restored

---

## 2. Scope and Service Names

SSH has different common service names across Linux families.

| Distribution | Package | Common service unit | Common authentication log |
|---|---|---|---|
| Ubuntu/Debian | `openssh-server` | `ssh.service` | Journal and sometimes `/var/log/auth.log` |
| Rocky/RHEL/Fedora | `openssh-server` | `sshd.service` | Journal and often `/var/log/secure` |

The server daemon is normally named `sshd` on both families even when the Ubuntu service unit is named `ssh.service`.

### Set a shell variable for the unit name

Ubuntu:

```bash
ssh_unit=ssh
```

Rocky Linux or RHEL:

```bash
ssh_unit=sshd
```

Use `"$ssh_unit"` in later commands.

---

## 3. SSH Troubleshooting Model

SSH access depends on several layers.

```mermaid
flowchart LR
    A["SSH client"] --> B["DNS and route"]
    B --> C["Firewall or cloud controls"]
    C --> D["TCP listener"]
    D --> E["SSH handshake"]
    E --> F["User authentication"]
    F --> G["Session and shell"]
```

A failure at one layer can produce a different error:

- DNS failure: hostname does not resolve
- Route or firewall problem: timeout or no route
- No listener: connection refused
- SSH negotiation problem: key-exchange or algorithm error
- Authentication problem: permission denied
- Session problem: login succeeds but shell or command fails

### Investigation principle

Work from the client toward the server:

1. Name resolution
2. Network reachability
3. TCP port
4. Service and listener
5. Configuration and logs
6. User authentication
7. Session startup

---

## 4. Phase 1 — Confirm Impact and Preserve Access

Before running commands, document the problem.

### Ask these questions

- What exact error does the user see?
- When did it start?
- Did it ever work from this client?
- Is one user affected or all users?
- Is one source IP or network affected?
- Does the problem affect password login, key login, or both?
- Was there a recent deployment, patch, firewall change, key rotation, or configuration edit?
- Is the target a physical server, VM, cloud instance, container, or WSL environment?

### Preserve the current connection

If you are already logged in:

- Keep the current terminal open.
- Open a second terminal for testing.
- Confirm console, serial-console, bastion, or cloud-management access.
- Do not log out until a second login succeeds.

### Record the exact client error

Example:

```bash
ssh user@server
```

Copy the exact message rather than writing only “SSH is not working.”

---

## 5. Phase 2 — Capture a Time-Stamped Baseline

Run these read-only commands on the server if access is available:

```bash
date -Is
hostnamectl
cat /etc/os-release
uname -r
uptime
who
w
```

### Why this matters

| Command | Evidence collected |
|---|---|
| `date -Is` | Server timestamp and time-zone offset |
| `hostnamectl` | Hostname, OS, kernel, and virtualization |
| `cat /etc/os-release` | Distribution and release |
| `uname -r` | Running kernel |
| `uptime` | Uptime and load averages |
| `who` | Logged-in sessions |
| `w` | Sessions and current activity |

### Optional evidence directory

For a lab, create a directory in your home rather than using a shared temporary directory:

```bash
evidence_dir="$HOME/ssh-runbook-evidence-$(date '+%Y-%m-%d-%H-%M-%S')"
mkdir -p -- "$evidence_dir"
printf 'Evidence directory: %s\n' "$evidence_dir"
```

Do not store secrets, private keys, passwords, or unsanitized authentication logs in a public repository.

---

## 6. Phase 3 — Test from the Client

### Step 1: Verify name resolution

Linux:

```bash
getent hosts server.example.com
```

Windows PowerShell:

```powershell
Resolve-DnsName server.example.com
```

If DNS is not required for the test, connect directly to the known IP address.

### Step 2: Test the TCP port

Linux:

```bash
nc -vz server.example.com 22
```

Windows PowerShell:

```powershell
Test-NetConnection server.example.com -Port 22
```

### Step 3: Run SSH in verbose mode

```bash
ssh -vvv user@server.example.com
```

Verbose mode shows:

- Configuration files used
- Destination address
- Connection establishment
- Host-key negotiation
- Authentication methods attempted
- Keys offered by the client
- Point of failure

> Verbose output may reveal usernames, hostnames, addresses, and key paths. Sanitize it before sharing.

### Step 4: Force a specific identity when required

```bash
ssh -o IdentitiesOnly=yes -i "$HOME/.ssh/id_ed25519" user@server.example.com
```

This is useful when an SSH agent offers too many keys.

---

## 7. Phase 4 — Verify the Server Listener

On the server:

```bash
sudo ss -lntp | grep -E '(:22[[:space:]])'
```

Typical listener:

```text
LISTEN 0 128 0.0.0.0:22 0.0.0.0:* users:(("sshd",pid=1234,fd=3))
```

### Interpretation

| Listener | Meaning |
|---|---|
| `0.0.0.0:22` | Listening on all IPv4 interfaces |
| `[::]:22` | Listening on all IPv6 interfaces |
| `127.0.0.1:22` | Listening only on local IPv4 loopback |
| A specific IP | Listening only on that configured address |
| No output | No matching TCP listener was found |

### Confirm the configured port

```bash
sudo sshd -T | grep -E '^(port|listenaddress) '
```

If SSH uses a nonstandard port, test that port instead of 22:

```bash
ssh -p 2222 user@server.example.com
```

---

## 8. Phase 5 — Check SSH Service State

```bash
sudo systemctl status "$ssh_unit" --no-pager -l
sudo systemctl is-active "$ssh_unit"
sudo systemctl is-enabled "$ssh_unit"
```

### State meanings

| State | Meaning |
|---|---|
| `active` | Service is running now |
| `inactive` | Service is not running |
| `failed` | Service exited unsuccessfully |
| `activating` | Service is starting |
| `deactivating` | Service is stopping |
| `enabled` | Configured for activation through boot dependencies |
| `disabled` | Installed but not enabled |
| `masked` | Blocked from starting |

Active and enabled answer different questions:

- **Active:** Is it running now?
- **Enabled:** Is it configured for boot-time activation?

### Check the installed unit name

```bash
systemctl list-unit-files --type=service | grep -E '^(ssh|sshd)\.service'
```

If `systemctl` cannot connect to `systemd`, identify PID 1:

```bash
ps -p 1 -o pid,comm,args
```

---

## 9. Phase 6 — Inspect Logs

### Service journal

```bash
sudo journalctl -u "$ssh_unit" --since "-30 minutes" --no-pager
```

### Current-boot messages

```bash
sudo journalctl -b -p warning --no-pager
```

### Follow SSH logs during a controlled login test

```bash
sudo journalctl -u "$ssh_unit" -f
```

Press `Ctrl+C` when the test is complete.

### Distribution log files

Ubuntu or Debian:

```bash
sudo tail -n 50 /var/log/auth.log
```

Rocky Linux or RHEL:

```bash
sudo tail -n 50 /var/log/secure
```

Some systems store authentication events only in the journal, so a traditional file may not exist.

### Important log patterns

```bash
sudo journalctl -u "$ssh_unit" --since "-30 minutes" --no-pager |
    grep -iE 'failed|invalid|denied|error|closed|reset|accepted|maximum|refused'
```

Do not treat every connection reset or invalid protocol message as a confirmed attack. Internet-facing SSH services commonly receive automated scans and non-SSH probes. Correlate the event with:

- Source address
- Timestamp
- User impact
- Repeated frequency
- Firewall or intrusion-prevention records

---

## 10. Phase 7 — Validate SSH Configuration

### Test syntax before any reload or restart

```bash
sudo sshd -t
```

No output with exit status `0` normally means the syntax check passed:

```bash
echo $?
```

### Display effective configuration

```bash
sudo sshd -T | less
```

Search important settings:

```bash
sudo sshd -T |
    grep -E '^(port|listenaddress|permitrootlogin|passwordauthentication|pubkeyauthentication|authorizedkeysfile|maxauthtries|maxstartups|allowusers|allowgroups|denyusers|denygroups) '
```

### Identify configuration sources

```bash
sudo grep -RniE '^[[:space:]]*(Include|Port|ListenAddress|PermitRootLogin|PasswordAuthentication|PubkeyAuthentication|AllowUsers|AllowGroups|DenyUsers|DenyGroups)' +    /etc/ssh/sshd_config /etc/ssh/sshd_config.d 2>/dev/null
```

Later settings, included files, `Match` blocks, and command-line options can affect the effective result. Use `sshd -T` rather than trusting one line in one file.

### Test settings for a particular connection

```bash
sudo sshd -T -C user=exampleuser,host=server.example.com,addr=192.0.2.10 |
    grep -E '^(passwordauthentication|pubkeyauthentication|permitrootlogin|authorizedkeysfile) '
```

Replace the example values with the real user, host, and client address.

---

## 11. Phase 8 — Check User and Key Authentication

### Confirm the account

```bash
getent passwd exampleuser
id exampleuser
sudo passwd -S exampleuser
sudo chage -l exampleuser
```

Check for:

- Correct username
- Existing home directory
- Valid login shell
- Locked password
- Expired password or account
- Required group membership

### Inspect the configured login shell

```bash
getent passwd exampleuser | cut -d: -f7
```

Shells such as `/sbin/nologin` or `/usr/sbin/nologin` intentionally block interactive login.

### Check the client's public-key fingerprint

```bash
ssh-keygen -lf "$HOME/.ssh/id_ed25519.pub"
```

On the server, compare with the authorized key:

```bash
sudo ssh-keygen -lf /home/exampleuser/.ssh/authorized_keys
```

The second command can display fingerprints for keys stored in the file. Never copy or expose the private key.

### Client-side key test

```bash
ssh -o IdentitiesOnly=yes +    -i "$HOME/.ssh/id_ed25519" +    exampleuser@server.example.com
```

---

## 12. Phase 9 — Check Permissions and Ownership

OpenSSH can reject keys when ownership or permissions are unsafe.

### Inspect every path component

```bash
sudo namei -l /home/exampleuser/.ssh/authorized_keys
```

### Inspect exact metadata

```bash
sudo stat -c '%A %a %U:%G %n' +    /home/exampleuser +    /home/exampleuser/.ssh +    /home/exampleuser/.ssh/authorized_keys
```

Typical secure values:

| Path | Typical ownership | Typical permissions |
|---|---|---|
| `/home/exampleuser` | `exampleuser:exampleuser` | Not writable by other users |
| `.ssh` | `exampleuser:exampleuser` | `700` |
| `authorized_keys` | `exampleuser:exampleuser` | `600` |

### Correct only after confirming the target

```bash
sudo chown -R exampleuser:exampleuser /home/exampleuser/.ssh
sudo chmod 700 /home/exampleuser/.ssh
sudo chmod 600 /home/exampleuser/.ssh/authorized_keys
```

Do not apply recursive permission changes to an entire home directory without understanding the contents.

### SELinux systems

Check status:

```bash
getenforce
```

Restore expected labels:

```bash
sudo restorecon -RFv /home/exampleuser/.ssh
```

Inspect relevant denials:

```bash
sudo ausearch -m AVC -ts recent
```

Do not disable SELinux as a first troubleshooting step.

---

## 13. Phase 10 — Check Firewall and Network Path

### Server addresses and routes

```bash
ip -br addr
ip route
```

### Ubuntu with UFW

```bash
sudo ufw status verbose
```

### Rocky Linux or RHEL with firewalld

```bash
sudo firewall-cmd --get-active-zones
sudo firewall-cmd --list-all
```

### nftables

```bash
sudo nft list ruleset
```

### Capture connection attempts when necessary

```bash
sudo tcpdump -ni any 'tcp port 22'
```

Interpretation:

| Observation | Likely direction |
|---|---|
| No SYN reaches server | Upstream route, VPN, firewall, security group, or wrong address |
| SYN arrives but no response | Host firewall, stack, severe load, or capture limitation |
| SYN and RST | No listener or explicit rejection |
| TCP handshake completes | Investigate SSH handshake and authentication |

Packet capture may contain sensitive addresses and payload metadata. Follow organizational policy before saving or sharing it.

---

## 14. Phase 11 — Check Cloud Access Controls

For an AWS instance, verify:

- Correct public or private IP address
- Correct VPC and subnet
- Route table
- Internet gateway, NAT, VPN, or bastion path as applicable
- Security-group inbound rule for the actual SSH port
- Source CIDR matches the client's current public or private address
- Network ACL inbound and return-path rules
- Instance state and health checks

### Important distinction

| Control | Behavior |
|---|---|
| Security group | Stateful virtual firewall attached to resources |
| Network ACL | Stateless subnet-level filtering |
| Host firewall | Rules enforced inside the Linux instance |

A listener on port 22 does not prove that the port is reachable through every network layer.

### Recovery path

Before modifying SSH or firewall settings, confirm whether one of these is available:

- Cloud serial console
- AWS Systems Manager Session Manager
- Hypervisor or VM console
- Bastion host
- Existing second SSH session

---

## 15. Phase 12 — Check System Resources

SSH may fail or behave slowly when the system has resource pressure.

### CPU and load

```bash
uptime
top -b -n 1 | head -n 20
vmstat 1 5
```

### Memory and OOM events

```bash
free -h
sudo journalctl -k --since "-1 hour" |
    grep -iE 'oom|out of memory|killed process'
```

### Disk blocks and inodes

```bash
df -hT
df -i
```

### Log-directory size

```bash
sudo du -xsh /var/log
```

### Open-file and process limits

```bash
ulimit -n
systemctl show "$ssh_unit" -p LimitNOFILE -p TasksCurrent -p TasksMax
```

### Interpretation principles

- A single `top` or `vmstat` sample does not prove a sustained problem.
- High Linux cache usage alone is not a memory failure.
- Low available memory, active swapping, OOM events, full disks, or exhausted inodes require investigation.
- Compare multiple samples and correlate them with timestamps and user impact.

---

## 16. Error-to-Cause Decision Table

| Client error or symptom | Likely fault domain | First checks |
|---|---|---|
| `Could not resolve hostname` | DNS or typing error | `getent hosts`, `Resolve-DnsName` |
| `Connection timed out` | Route, VPN, firewall, security group, wrong IP | Port test, routes, cloud controls, packet capture |
| `No route to host` | Routing, host reachability, or firewall rejection | Client route, gateway, server state |
| `Connection refused` | No listener, wrong port, or explicit rejection | `ss -lntp`, service status, configured port |
| `Host key verification failed` | Stored host key differs from server | Verify server identity and host-key fingerprint |
| `Permission denied (publickey)` | Wrong key, user, permissions, or policy | `ssh -vvv`, account, effective config, permissions |
| `Permission denied (password)` | Wrong password, disabled method, locked or expired account | Logs, `sshd -T`, `passwd -S`, `chage -l` |
| `Too many authentication failures` | Client or agent offers too many keys | `IdentitiesOnly=yes`, select one identity |
| `kex_exchange_identification` | Pre-auth policy, `MaxStartups`, scanner, block, or reset | Logs, connection volume, firewall tools |
| `Connection reset by peer` | Server, firewall, security tool, or network reset | Logs on both sides, packet capture |
| Login succeeds, shell closes | Invalid shell, startup-file error, command restriction, PAM, or resource issue | Account shell, logs, authorized-key options |
| Login is slow | DNS, GSSAPI, PAM, overloaded system, or network latency | Verbose timing, logs, CPU/memory, name resolution |

### Host-key warning

Do not blindly remove a `known_hosts` entry. A changed host key can be legitimate after a rebuild, but it can also indicate that you reached the wrong host or a man-in-the-middle risk. Verify the new fingerprint through a trusted console or administrator first.

---

## 17. Safe Recovery Actions

Only take corrective action after identifying the likely cause and confirming impact.

### Back up configuration before editing

```bash
backup_stamp=$(date '+%Y-%m-%d-%H-%M-%S')
sudo cp -a /etc/ssh/sshd_config +    "/etc/ssh/sshd_config.backup-$backup_stamp"
```

If your system uses drop-in files, back up the relevant file under `/etc/ssh/sshd_config.d/` as well.

### Validate after editing

```bash
sudo sshd -t
```

Do not reload or restart if this command reports an error.

### Prefer reload when supported

Ubuntu:

```bash
sudo systemctl reload ssh
```

Rocky Linux or RHEL:

```bash
sudo systemctl reload sshd
```

A reload asks the service to re-read configuration while preserving established sessions when supported. A restart is more disruptive.

### Verify in a second terminal

```bash
ssh -o IdentitiesOnly=yes +    -i "$HOME/.ssh/id_ed25519" +    exampleuser@server.example.com
```

Keep the original session open until this succeeds.

### When a restart may be considered

Consider a controlled restart only when:

- The service is failed or unresponsive
- Configuration syntax is valid
- An alternate recovery path exists
- Impact and approvals are understood
- The restart is the least disruptive available action

### Avoid these shortcuts

- Disabling the firewall without evidence
- Disabling SELinux
- Setting `chmod 777` on `.ssh` or `authorized_keys`
- Enabling unrestricted root or password login
- Deleting `known_hosts` entries without verifying identity
- Restarting SSH from the only remote session without console access

---

## 18. Post-Recovery Verification

Recovery is not complete until it is verified.

### Service and listener

```bash
sudo systemctl is-active "$ssh_unit"
sudo ss -lntp | grep -E '(:22[[:space:]])'
```

Use the actual configured port if it is not 22.

### Configuration

```bash
sudo sshd -t
sudo sshd -T | grep -E '^(port|passwordauthentication|pubkeyauthentication|permitrootlogin) '
```

### Functional test

From a second client terminal:

```bash
ssh exampleuser@server.example.com 'hostname; id; uptime'
```

### Logs

```bash
sudo journalctl -u "$ssh_unit" --since "-10 minutes" --no-pager
```

### Verify the original symptom

Confirm:

- The affected user can log in
- The intended authentication method works
- Unintended methods remain disabled
- No new configuration or authentication errors appear
- Monitoring and alerts return to normal

---

## 19. Escalation Package

If the issue is not resolved, provide a concise evidence package.

### Include

- Incident start time and time zone
- Hostname and environment
- Affected users and source networks
- Exact client error
- Whether TCP port testing succeeds
- Service state
- Listener address and port
- Relevant sanitized log lines
- Configuration test result
- Recent changes
- Resource observations
- Actions already attempted
- Available recovery paths

### Do not include

- Private keys
- Passwords
- Full unrestricted configuration dumps containing sensitive data
- Unsanitized public IPs or fingerprints in a public repository
- Tokens or cloud credentials

### Short escalation template

```text
Impact:
Start time and time zone:
Affected users/sources:
Target host and environment:
Exact error:
TCP port result:
Service/listener state:
Relevant logs:
Configuration test:
Recent changes:
Resource state:
Actions attempted:
Recovery access available:
Assistance required:
```

---

## 20. Historical Snapshot from the Original Record

The original Day 05 record described an Ubuntu 24.04 AWS-kernel host and captured observations at different times.

> These are historical snapshots, not proof of current or continuous health.

| Original check | Recorded observation |
|---|---|
| `uname -a` | Ubuntu AWS kernel and x86_64 architecture |
| `cat /etc/os-release` | Ubuntu 24.04.3 LTS |
| `top -b -n 1` | Low load in the displayed sample; most CPU idle with some I/O wait |
| `ps -o pid,pcpu,pmem,comm -C sshd` | Displayed SSH processes had low CPU and memory use |
| `free -h` | Available memory remained; no swap was configured in that snapshot |
| `df -h` | Root file system had substantial free space |
| `du -sh /var/log` | Log directory was not unusually large in that sample |
| `vmstat 1 5` | Later interval rows showed little CPU activity and no sustained I/O wait |
| `ss -tulpn` | TCP SSH listeners were documented |
| `journalctl -u ssh` | SSH lifecycle and login events were present |
| Authentication log | Connection resets and an invalid-protocol event were present |

### Correct interpretation

- The resource samples did not demonstrate sustained CPU, memory, or disk pressure.
- A listener and historical login entries showed that SSH worked at those recorded times.
- Connection resets or invalid-format messages require context; they do not alone prove compromise.
- Output captured at different times must not be presented as one simultaneous system snapshot.
- HTTP or NGINX tests belong to a separate web-service investigation, not an SSH endpoint test.

---

## 21. Common Mistakes

### Restarting before collecting evidence

A restart can temporarily hide the root cause and erase useful runtime state.

### Testing only with `ping`

Ping tests ICMP, not SSH. ICMP may be blocked while TCP 22 works, or ping may work while SSH is blocked.

### Assuming a listening port proves end-to-end access

A local listener does not verify cloud security groups, VPN paths, network ACLs, or client-side firewalls.

### Assuming every `Permission denied` has the same cause

The message can result from a wrong user, wrong key, permissions, disabled method, account state, or policy.

### Publishing raw authentication logs

Logs may expose source addresses, usernames, fingerprints, and infrastructure details.

### Mixing timestamps

Commands run at different times cannot automatically be treated as one health snapshot.

### Using destructive permission fixes

`chmod 777` weakens security and usually causes OpenSSH to distrust key files rather than fixing them.

---

## 22. Interview-Style Answer

> First, I would define the impact and capture the exact SSH error, affected users, source network, and start time. If I already had a session open, I would keep it active and confirm an alternate recovery path. From the client, I would verify DNS, TCP reachability, and verbose SSH output. On the server, I would check the SSH listener, service state, journal entries, effective configuration, account status, key permissions, firewall rules, and system resources. In cloud environments, I would also verify security groups, network ACLs, routes, and the correct instance address. I would validate the SSH configuration with `sshd -t` before any reload, choose the least disruptive corrective action, test from a second session, and verify service health and logs before closing the incident.

---

## 23. Quick Command Reference

```bash
# Choose the correct service unit:
ssh_unit=ssh        # Ubuntu/Debian
# ssh_unit=sshd     # Rocky/RHEL/Fedora

# Baseline
date -Is
hostnamectl
uptime
who

# PID 1
ps -p 1 -o pid,comm,args

# Listener and service
sudo ss -lntp | grep -E '(:22[[:space:]])'
sudo systemctl status "$ssh_unit" --no-pager -l
sudo systemctl is-active "$ssh_unit"
sudo systemctl is-enabled "$ssh_unit"

# Logs
sudo journalctl -u "$ssh_unit" --since "-30 minutes" --no-pager
sudo journalctl -b -p warning --no-pager

# Configuration
sudo sshd -t
sudo sshd -T | less

# Account and key path
getent passwd exampleuser
id exampleuser
sudo passwd -S exampleuser
sudo namei -l /home/exampleuser/.ssh/authorized_keys

# Network and firewall
ip -br addr
ip route
sudo ufw status verbose
# sudo firewall-cmd --list-all

# Resources
uptime
free -h
vmstat 1 5
df -hT
df -i
```

Client tests:

```bash
getent hosts server.example.com
nc -vz server.example.com 22
ssh -vvv exampleuser@server.example.com
```

---

## 24. Completion Checklist

- [ ] Recorded exact error, time, impact, and affected scope
- [ ] Preserved the current session and identified a recovery path
- [ ] Verified DNS or used the known correct IP
- [ ] Tested the actual SSH TCP port
- [ ] Collected verbose client output
- [ ] Confirmed the server listener address and port
- [ ] Checked the correct service unit
- [ ] Reviewed service and authentication logs
- [ ] Validated configuration with `sshd -t`
- [ ] Checked effective configuration with `sshd -T`
- [ ] Verified account, shell, lock, and expiration state
- [ ] Verified key fingerprint, ownership, permissions, and security labels
- [ ] Checked host firewall and network path
- [ ] Checked cloud security controls when applicable
- [ ] Checked CPU, memory, disk blocks, inodes, and kernel events
- [ ] Applied only the least disruptive corrective action
- [ ] Tested a second SSH session
- [ ] Verified logs and monitoring after recovery
- [ ] Sanitized all evidence before sharing

## Final Takeaway

SSH troubleshooting should follow evidence, not guesswork:

1. Define the symptom and impact.
2. Preserve access.
3. Test from the client toward the server.
4. Confirm the listener and service.
5. Read logs and validate effective configuration.
6. Check the account, key, permissions, firewall, and cloud path.
7. Correct the verified cause with the least disruptive action.
8. Test again and document the result.
