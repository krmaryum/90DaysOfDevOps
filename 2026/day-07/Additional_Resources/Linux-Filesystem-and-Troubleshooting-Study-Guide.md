# Day 07 – Linux File System Hierarchy and Scenario-Based Troubleshooting

> A practical, beginner-friendly Linux administration lab covering the filesystem hierarchy, safe navigation, disk and inode usage, permissions, logs, CPU troubleshooting, and common support scenarios.

---

## Table of Contents

1. [Learning Objectives](#1-learning-objectives)
2. [Linux File System Overview](#2-linux-file-system-overview)
3. [Important Linux Directories](#3-important-linux-directories)
4. [Paths: Absolute vs Relative](#4-paths-absolute-vs-relative)
5. [Safe Lab Setup](#5-safe-lab-setup)
6. [File System Navigation Lab](#6-file-system-navigation-lab)
7. [Scenario 1: Root File System Is Nearly Full](#7-scenario-1-root-file-system-is-nearly-full)
8. [Scenario 2: High CPU Usage](#8-scenario-2-high-cpu-usage)
9. [Scenario 3: Script Shows Permission Denied](#9-scenario-3-script-shows-permission-denied)
10. [Scenario 4: Configuration File Is Missing](#10-scenario-4-configuration-file-is-missing)
11. [Scenario 5: Investigating Application Logs](#11-scenario-5-investigating-application-logs)
12. [Scenario 6: Deleted File Still Uses Disk Space](#12-scenario-6-deleted-file-still-uses-disk-space)
13. [Scenario 7: Inodes Are Exhausted](#13-scenario-7-inodes-are-exhausted)
14. [Safe Troubleshooting Workflow](#14-safe-troubleshooting-workflow)
15. [Practice Tasks and Interview Questions](#15-practice-tasks-and-interview-questions)
16. [Quick Reference and Cleanup](#16-quick-reference-and-cleanup)

---

## 1. Learning Objectives

By the end of this lesson, you should be able to:

- Explain why Linux uses a single directory tree beginning at `/`.
- Describe the purpose of common Linux directories.
- Distinguish `/`, `/root`, and a normal user's home directory.
- Navigate safely with `pwd`, `ls`, and `cd`.
- Identify whether disk blocks or inodes are nearly exhausted.
- Locate large directories and files without crossing into other filesystems.
- Investigate high CPU usage and identify the responsible process.
- Diagnose permission, ownership, configuration, and log-related problems.
- Recognize deleted-but-open files.
- Follow a safe observe → verify → act → validate troubleshooting method.

---

## 2. Linux File System Overview

Linux follows a **single-rooted directory structure**. Everything begins at `/`, the **root directory**.

It is different from:

- `root` — the administrator account.
- `/root` — the home directory of the `root` user.

### Simplified hierarchy

```text
/
├── etc      System-wide configuration
├── home     Normal users' home directories
├── root     Root user's home directory
├── var      Variable data such as logs and caches
├── usr      Applications, libraries, and shared data
├── tmp      Temporary files
├── boot     Bootloader and kernel-related files
├── dev      Device files
├── proc     Process and kernel information
├── sys      Kernel and device information
├── run      Runtime state
├── opt      Optional third-party software
├── mnt      Temporary mount points
└── media    Removable media mount points
```

Unlike Windows, Linux does not normally use drive letters such as `C:` or `D:`. Separate disks and filesystems are attached to directories called **mount points**.

```bash
findmnt
findmnt /
```

---

## 3. Important Linux Directories

| Directory | Main purpose | Common examples |
|---|---|---|
| `/` | Top of the directory tree | `etc`, `home`, `var` |
| `/bin` | Essential user commands; often linked into `/usr/bin` | `ls`, `cp`, `cat` |
| `/boot` | Bootloader, kernel, and initial RAM filesystem | `vmlinuz`, `initramfs` |
| `/dev` | Device files managed by the system | `/dev/null`, `/dev/sda` |
| `/etc` | System-wide configuration | `/etc/hosts`, `/etc/ssh` |
| `/home` | Home directories for normal users | `/home/khalid` |
| `/lib`, `/lib64` | Essential shared libraries; often linked into `/usr` | loader and libraries |
| `/media` | Common mount point for removable media | USB or DVD mounts |
| `/mnt` | Temporary/manual mount point | test filesystem mount |
| `/opt` | Optional or third-party packages | `/opt/application` |
| `/proc` | Virtual process and kernel information | `/proc/cpuinfo` |
| `/root` | Home directory of the root user | root's configuration files |
| `/run` | Runtime state since boot | PID files, sockets |
| `/sbin` | Administration commands; often linked into `/usr/sbin` | `fsck`, `reboot` |
| `/srv` | Data served by system services | website or FTP data |
| `/sys` | Virtual kernel and device information | `/sys/class/net` |
| `/tmp` | Temporary files | application temporary data |
| `/usr` | Most installed commands, libraries, and shared content | `/usr/bin`, `/usr/lib` |
| `/var` | Frequently changing data | logs, cache, spool |

### 3.1 `/` — root directory

The root directory contains every other file and directory.

```bash
ls -la /
```

> Do not confuse `/` with `/root`.

### 3.2 `/home` — normal users' home directories

```bash
ls -la /home
echo "$HOME"
```

Normal users usually store personal files, projects, scripts, and shell configuration here.

### 3.3 `/root` — root user's home directory

```bash
sudo ls -la /root
```

`/root` is not the top of the filesystem. It is the administrator's home directory.

### 3.4 `/etc` — configuration

`/etc` stores system-wide configuration files.

```text
/etc/hosts
/etc/hostname
/etc/passwd
/etc/group
/etc/ssh/sshd_config
/etc/nginx/nginx.conf
```

Before editing production configuration:

1. Read the documentation.
2. Create a timestamped backup.
3. Validate syntax.
4. Reload the service when possible.
5. Verify the result and review logs.

```bash
sudo cp -a /etc/hosts \
  "/etc/hosts.backup-$(date '+%Y-%m-%d-%H-%M-%S')"
```

### 3.5 `/var` and `/var/log` — variable data and logs

`/var` contains data that changes while the system runs.

```bash
sudo du -xhd1 /var 2>/dev/null | sort -h
```

Important paths:

```text
/var/log     Logs
/var/cache   Application and package caches
/var/lib     Persistent application state
/var/spool   Queued work such as mail or print jobs
```

Log names differ by distribution. Ubuntu may use `/var/log/syslog` and `/var/log/auth.log`; Rocky/RHEL may use `/var/log/messages` and `/var/log/secure`. Systems using systemd also provide logs through `journalctl`.

### 3.6 `/tmp` — temporary data

```bash
ls -ld /tmp
```

Typical permissions:

```text
drwxrwxrwt
```

The final `t` is the **sticky bit**. Users may create files in `/tmp`, but normally cannot delete files owned by other users.

> `/tmp` may be cleaned at boot or according to an age-based policy, but this is distribution- and configuration-dependent. Never assume every file will disappear after reboot.

This lab uses `$HOME` instead of `/tmp` for practice data.

### 3.7 `/usr` — installed software and shared data

```text
/usr/bin     User commands
/usr/sbin    Administration commands
/usr/lib     Libraries
/usr/share   Shared data
/usr/local   Locally installed software
```

On many modern distributions, `/bin`, `/sbin`, and library directories are symbolic links into `/usr`.

```bash
ls -ld /bin /sbin /lib /lib64 2>/dev/null
```

### 3.8 `/proc` and `/sys` — virtual kernel interfaces

These are generated by the kernel rather than stored like ordinary disk directories.

```bash
cat /proc/cpuinfo | head
cat /proc/meminfo | head
cat /proc/uptime
ls /sys/class/net
```

`/proc/<PID>` exposes information about a running process.

```bash
ps -p 1 -f
sudo ls -l /proc/1/exe
```

### 3.9 `/dev` — devices represented as files

```text
/dev/null    Discards written data
/dev/zero    Produces zero bytes
/dev/random  Random data source
/dev/tty     Current terminal
```

```bash
echo "discard this text" > /dev/null
```

### 3.10 `/boot` — boot files

```bash
sudo ls -lh /boot
```

Avoid manually deleting files from `/boot`; use the package manager and approved cleanup procedures.

### 3.11 `/run` — runtime state

`/run` stores state for the current boot, such as sockets and PID files. It is normally recreated after reboot.

```bash
findmnt /run
ls -la /run | head
```

### 3.12 `/opt`, `/srv`, `/mnt`, and `/media`

- `/opt`: optional third-party applications.
- `/srv`: data provided by services.
- `/mnt`: temporary or administrator-created mounts.
- `/media`: removable media mounts, often managed automatically.

---

## 4. Paths: Absolute vs Relative

An **absolute path** starts at `/`:

```text
/home/khalid/day07-linux-fs-lab/report.txt
```

A **relative path** starts from the current working directory:

```text
day07-linux-fs-lab/report.txt
```

| Symbol | Meaning |
|---|---|
| `/` | Root directory |
| `.` | Current directory |
| `..` | Parent directory |
| `~` | Current user's home directory |
| `-` | Previous directory when used with `cd` |

```bash
pwd
cd ..
cd ~
cd -
```

---

## 5. Safe Lab Setup

Run the practice as your normal user, not as `root`.

```bash
lab_dir="$HOME/day07-linux-fs-lab"
mkdir -p "$lab_dir"/{logs,data,scripts,backups}
cd "$lab_dir"
pwd
```

Create sample files:

```bash
printf '%s\n' "alpha" "beta" "gamma" > data/items.txt
printf '%s\n' "INFO application started" > logs/application.log
printf '%s\n' '#!/usr/bin/env bash' 'echo "Backup simulation complete"' > scripts/backup.sh
```

Inspect the lab:

```bash
find "$lab_dir" -maxdepth 2 -printf '%M %u:%g %p\n' | sort
```

---

## 6. File System Navigation Lab

### Identify your current location

```bash
pwd
```

### List files

```bash
ls
ls -l
ls -la
ls -lh
```

| Option | Meaning |
|---|---|
| `-l` | Long listing |
| `-a` | Include hidden entries |
| `-h` | Human-readable sizes with `-l` |

### Inspect a file

```bash
file data/items.txt
stat data/items.txt
namei -l "$lab_dir/data/items.txt"
```

`file` identifies content type, `stat` displays metadata, and `namei -l` checks every component of a path.

### Inspect storage

```bash
df -hT
df -i
findmnt
lsblk -f
```

| Command | Answers which question? |
|---|---|
| `df -hT` | How many disk blocks are used, and what is the filesystem type? |
| `df -i` | How many inodes are used? |
| `findmnt` | What is mounted where? |
| `lsblk -f` | Which devices, filesystems, labels, and mount points exist? |

> WSL output may differ from a traditional VM because Windows drives are commonly exposed below `/mnt`.

---

## 7. Scenario 1: Root File System Is Nearly Full

### Situation

```text
Monitoring reports that / is 95% full. Applications may soon be unable
to write logs, temporary files, or application data.
```

### 1. Confirm blocks and inodes

```bash
df -hT /
df -i /
```

If `df -h` is 95% used while `df -i` is 12% used, **disk blocks** are nearly exhausted, not inodes.

### 2. Identify the device

```bash
findmnt /
lsblk -f
```

### 3. Find large directories

```bash
sudo du -xhd1 / 2>/dev/null | sort -h
sudo du -xhd1 /var 2>/dev/null | sort -h
sudo du -xhd1 /var/log 2>/dev/null | sort -h
```

- `-x`: stay on the same filesystem.
- `-h`: human-readable sizes.
- `-d1`: one level deep.
- `2>/dev/null`: hide permission errors from standard error.

### 4. Locate large files

```bash
sudo find / -xdev -type f -size +500M -printf '%10s %p\n' \
  2>/dev/null | sort -n
```

Do not delete a large file until you know its owner, purpose, active use, retention requirements, and whether it should be rotated, compressed, archived, or removed.

### 5. Check deleted-but-open files and journal usage

```bash
sudo lsof +L1
sudo journalctl --disk-usage
```

If approved policy permits journal cleanup:

```bash
sudo journalctl --vacuum-time=7d
```

or:

```bash
sudo journalctl --vacuum-size=500M
```

### 6. Verify recovery

```bash
df -hT /
df -i /
systemctl --failed
```

### Why `df` and `du` may differ

- `df` reports allocated filesystem blocks.
- `du` totals visible directory entries.
- A deleted-but-open file consumes space shown by `df` but not `du`.
- Mount points, permissions, sparse files, snapshots, and reserved blocks may also affect the comparison.

---

## 8. Scenario 2: High CPU Usage

### Situation

```text
Users report that an application server is slow. Determine whether CPU
pressure exists and identify the responsible process.
```

### 1. Confirm load and CPU count

```bash
uptime
nproc
```

Load average must be interpreted relative to logical CPU count.

### 2. Observe activity

```bash
top
```

Useful keys: `P` sorts by CPU, `M` by memory, `1` shows individual CPUs, and `q` quits.

| Field | Meaning |
|---|---|
| `us` | User-space CPU time |
| `sy` | Kernel/system CPU time |
| `id` | Idle time |
| `wa` | Waiting for I/O completion |
| `st` | CPU time taken by the hypervisor from a VM |

### 3. Take a snapshot

```bash
ps -eo pid,ppid,user,stat,etime,%cpu,%mem,cmd \
  --sort=-%cpu | head -15
```

### 4. Inspect the suspicious PID

Replace `1521` with the actual PID:

```bash
ps -fp 1521
top -p 1521
sudo readlink -f /proc/1521/exe
sudo tr '\0' ' ' < /proc/1521/cmdline; echo
sudo lsof -p 1521 | head
```

### 5. Correlate before acting

Check application logs, deployments, configuration changes, traffic, scheduled jobs, and whether the workload is expected.

Do not immediately use `kill -9`. Capture evidence and prefer the application's supported shutdown or a controlled service action. Use `kill -TERM PID` when appropriate; reserve `kill -KILL PID` for a process that cannot stop cleanly and when impact is understood.

### Safe optional simulation

Run only in your own lab:

```bash
yes > /dev/null &
test_pid=$!
printf 'Test PID: %s\n' "$test_pid"
top -p "$test_pid"
```

Stop only the recorded process:

```bash
kill "$test_pid"
wait "$test_pid" 2>/dev/null
```

`yes > /dev/null` normally consumes one logical CPU. On a 12-CPU system, that is about `1 / 12 × 100 = 8.33%` of total capacity.

---

## 9. Scenario 3: Script Shows Permission Denied

### Situation

```text
Running ./scripts/backup.sh returns: Permission denied
```

### 1. Inspect permissions

```bash
ls -l scripts/backup.sh
stat scripts/backup.sh
```

Initial pattern:

```text
-rw-r--r-- 1 khalid khalid ... scripts/backup.sh
```

### 2. Add execute permission for the owner

```bash
chmod u+x scripts/backup.sh
ls -l scripts/backup.sh
```

Expected pattern:

```text
-rwxr--r-- 1 khalid khalid ... scripts/backup.sh
```

`chmod u+x` is more precise than granting execute permission to everyone. If `chmod +x` is applied to a `644` file, the result is commonly `-rwxr-xr-x`.

### 3. Check the interpreter and run

```bash
head -1 scripts/backup.sh
./scripts/backup.sh
```

Expected output:

```text
Backup simulation complete
```

### If permission is still denied

```bash
namei -l "$lab_dir/scripts/backup.sh"
findmnt -no OPTIONS --target scripts/backup.sh
getfacl scripts/backup.sh
file scripts/backup.sh
getenforce 2>/dev/null || true
```

Investigate parent-directory permissions, `noexec`, ACLs, SELinux, ownership, and Windows line endings.

> `chmod 777` is not a proper fix. It grants unnecessary permissions and creates security risk.

---

## 10. Scenario 4: Configuration File Is Missing

### Situation

```text
A service fails because an expected configuration file cannot be found.
```

Replace `nginx` with the affected service:

```bash
systemctl status nginx --no-pager -l
sudo journalctl -u nginx -n 50 --no-pager
systemctl cat nginx
systemctl show nginx -p ExecStart -p FragmentPath
sudo ls -l /etc/nginx/nginx.conf
sudo namei -l /etc/nginx/nginx.conf
```

Ask the package manager which configuration files belong to the package.

Ubuntu/Debian:

```bash
dpkg -L nginx 2>/dev/null | grep '/etc/'
```

Rocky/RHEL:

```bash
rpm -ql nginx 2>/dev/null | grep '/etc/'
```

Validate NGINX configuration:

```bash
sudo nginx -t
```

If validation succeeds:

```bash
sudo systemctl reload nginx
systemctl is-active nginx
```

> A reload is usually less disruptive than a restart, but use it only when supported and after configuration validation succeeds.

---

## 11. Scenario 5: Investigating Application Logs

### Situation

```text
An application request failed. Identify when it failed, what error
occurred, and whether the problem continues.
```

```bash
sudo journalctl -u nginx -n 50 --no-pager
sudo journalctl -u nginx -f
sudo journalctl --since "30 minutes ago" -p warning --no-pager
sudo grep -iE 'error|failed|denied|timeout' \
  /var/log/nginx/error.log 2>/dev/null | tail -20
```

Press `Ctrl+C` to stop following logs.

| Status | General meaning | Common investigation area |
|---|---|---|
| `400` | Bad request | Client request format |
| `403` | Forbidden | Permissions, access rules, SELinux, index |
| `404` | Not found | URL, document root, missing file |
| `500` | Internal server error | Application or server configuration |
| `502` | Bad gateway | Reverse-proxy upstream unavailable |
| `503` | Service unavailable | Application unavailable or overloaded |
| `504` | Gateway timeout | Slow or unreachable upstream |

Record timestamp, timezone, hostname, service, PID, request ID, errors, recent changes, commands, and corrective actions.

---

## 12. Scenario 6: Deleted File Still Uses Disk Space

### Situation

```text
A large log was deleted, but df still reports the filesystem as full.
```

A process may still have the deleted file open. The directory entry is gone, but storage remains allocated until the final file descriptor closes.

```bash
sudo lsof +L1
```

Example pattern:

```text
COMMAND PID  USER FD  TYPE SIZE/OFF NLINK NAME
java    2456 app  10w REG  5G       0     /var/log/app.log (deleted)
```

Corrective approach:

1. Identify the process and service.
2. Confirm business impact and redundancy.
3. Capture evidence.
4. Use a controlled reload/restart if approved.
5. Verify with `df -h` and `lsof +L1`.

Do not blindly terminate a production process to reclaim space.

---

## 13. Scenario 7: Inodes Are Exhausted

### Situation

```text
An application reports "No space left on device," but df -h shows
free capacity.
```

Check inode usage:

```bash
df -i
```

If `IUse%` is near 100%, the filesystem cannot create more files even when data blocks remain.

Locate directories with many entries. This may take time on a large filesystem:

```bash
sudo find / -xdev -printf '%h\n' 2>/dev/null \
  | sort \
  | uniq -c \
  | sort -nr \
  | head -20
```

Possible causes include millions of session, cache, mail queue, temporary, or tiny log files.

Before cleanup, confirm application ownership, retention, expected use, available supported cleanup commands, and why files accumulated. Then verify again:

```bash
df -i
```

---

## 14. Safe Troubleshooting Workflow

### 1. Observe

- What is the exact symptom?
- When did it begin?
- Which systems and users are affected?
- Is it temporary or sustained?

### 2. Confirm

- Reproduce or verify the symptom.
- Check monitoring, status, resource usage, and logs.
- Record timestamps and commands.

### 3. Scope

- One user or everyone?
- One service or the whole host?
- One node or several?
- Application, OS, network, storage, or dependency?

### 4. Correlate

- Deployment or configuration change?
- Patch or reboot?
- Traffic increase or scheduled job?

### 5. Act safely

- Prefer the smallest reversible change.
- Back up configuration.
- Validate before reload/restart.
- Follow approval procedures.
- Avoid blind deletion and `kill -9` as first responses.

### 6. Verify

- Did the command succeed?
- Is the service healthy?
- Are logs clean?
- Did monitoring recover?

### 7. Document and prevent recurrence

- Root cause, impact, evidence, corrective action, and follow-up prevention.

---

## 15. Practice Tasks and Interview Questions

### Hands-on tasks

1. Create the Day 07 lab under your home directory.
2. Use `findmnt /` to identify the root filesystem.
3. Compare `df -hT` and `df -i`.
4. Calculate the size of each lab subdirectory with `du`.
5. Use `stat` to record the inode and permissions of `data/items.txt`.
6. Reproduce and fix the script execution error with `chmod u+x`.
7. Inspect the script path with `namei -l`.
8. Run the safe CPU simulation, observe it, and stop only its recorded PID.
9. Search the journal for warnings from the last 30 minutes.
10. Explain why a deleted-but-open file can make `df` and `du` disagree.

### Knowledge check

1. What is the difference between `/`, `/root`, and `/home`?
2. Which directory stores system-wide configuration?
3. Which command shows filesystem block utilization?
4. Which command shows inode utilization?
5. Why use `du -x` while investigating `/`?
6. What does the sticky bit on `/tmp` protect?
7. What is the difference between `chmod u+x` and `chmod +x`?
8. Why should `kill -9` not be the first response to high CPU?
9. What does `lsof +L1` reveal?
10. Why can `No space left on device` appear when `df -h` shows free space?

### Short answers

1. `/` is the filesystem top, `/root` is root's home, and `/home` normally contains regular users' homes.
2. `/etc`.
3. `df -hT`.
4. `df -i`.
5. It prevents crossing into other mounted filesystems.
6. It prevents users from deleting or renaming other users' files in the shared directory.
7. `u+x` adds execute for the owner; `+x` normally adds execute across permission classes.
8. It prevents graceful cleanup and may cause corruption or destroy evidence.
9. Unlinked files still open by processes.
10. The filesystem may have exhausted inodes.

### Interview answer: full root filesystem

> First, I would use `df -hT /` and `df -i /` to determine whether disk blocks or inodes are nearly exhausted. I would identify the backing device with `findmnt /`, then use `du -x` and `find -xdev` to locate large directories and files without crossing into other filesystems. I would also check journal usage and deleted-but-open files with `lsof +L1`. I would not delete files until I understood their owner, purpose, retention requirements, and application impact. After approved cleanup or capacity expansion, I would verify disk usage, service health, logs, and monitoring.

### Interview answer: high CPU

> I would confirm whether the condition is sustained by checking `uptime`, CPU count, `top`, and a sorted `ps` snapshot. I would identify the process, owner, command line, elapsed time, and whether CPU is consumed in user or system mode. I would correlate the result with logs, workload, scheduled jobs, and recent changes. Before stopping anything, I would capture evidence and assess impact. I would prefer the application's supported shutdown or a controlled service action, using `kill -9` only as a last resort.

### Interview answer: script permission denied

> I would inspect the file's permissions, owner, group, ACL, interpreter line, and each parent directory. I would also check whether the filesystem is mounted with `noexec` and, on SELinux systems, whether a denial occurred. I would apply only the minimum required permission, such as `chmod u+x`, rather than `chmod 777`, then rerun the script and verify the result.

---

## 16. Quick Reference and Cleanup

| Purpose | Command |
|---|---|
| Current directory | `pwd` |
| Detailed listing | `ls -lah` |
| File metadata | `stat FILE` |
| Inspect path components | `namei -l PATH` |
| Filesystem usage | `df -hT` |
| Inode usage | `df -i` |
| Directory size | `du -sh DIRECTORY` |
| Same-filesystem usage | `du -xhd1 DIRECTORY` |
| Mounted filesystems | `findmnt` |
| Block devices | `lsblk -f` |
| Real-time processes | `top` |
| CPU-sorted processes | `ps -eo pid,user,%cpu,%mem,cmd --sort=-%cpu` |
| Service status | `systemctl status SERVICE` |
| Service logs | `journalctl -u SERVICE` |
| Deleted-but-open files | `sudo lsof +L1` |
| ACL information | `getfacl FILE` |
| File type | `file FILE` |

### Lab cleanup

Confirm the exact target:

```bash
printf 'Lab directory: %s\n' "$lab_dir"
find "$lab_dir" -maxdepth 2 -print
```

When certain it is correct, remove only the lab:

```bash
rm -r -- "$lab_dir"
```

Verify:

```bash
test ! -e "$lab_dir" && echo "PASS: Day 07 lab removed"
```

---

## Final Takeaway

The filesystem hierarchy tells you where to look. Commands such as `df`, `du`, `findmnt`, `ps`, `journalctl`, and `lsof` provide evidence. A consistent **observe → confirm → act → verify** workflow helps solve problems without creating new ones.
