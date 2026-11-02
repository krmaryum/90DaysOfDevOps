# Linux Command Cheat Sheet

A beginner-friendly reference to **25 commonly used Linux commands** for process management, file-system operations, and network troubleshooting.

> **Safety note:** Before running commands that stop processes, delete files, or change system settings, confirm the target and understand the possible impact.

## Table of Contents

- [1. Process Management](#1-process-management)
  - [Viewing Processes](#viewing-processes)
  - [Controlling Processes](#controlling-processes)
  - [Managing Shell Jobs](#managing-shell-jobs)
  - [Priority and Monitoring](#priority-and-monitoring)
- [2. File-System Commands](#2-file-system-commands)
- [3. Network Troubleshooting](#3-network-troubleshooting)
- [4. Optional Package Installation](#4-optional-package-installation)
- [5. Quick Reference](#5-quick-reference)

---

## 1. Process Management

A **process** is a running instance of a program. Every process has a unique process ID called a **PID**.

### Viewing Processes

#### 1. `ps`

Displays processes associated with the current terminal and user session.

```bash
ps
```

#### 2. `ps aux`

Displays detailed information about processes running on the system.

```bash
ps aux
```

Useful columns include:

- `USER`: process owner
- `PID`: process ID
- `%CPU`: CPU utilization
- `%MEM`: memory utilization
- `COMMAND`: command that started the process

#### 3. `top`

Displays continuously updated system and process statistics.

```bash
top
```

Useful keys inside `top`:

- `P`: sort by CPU usage
- `M`: sort by memory usage
- `k`: send a signal to a process
- `q`: quit

#### 4. `htop`

Opens an interactive process viewer with easier navigation and process management. It might need to be installed separately.

```bash
htop
```

### Controlling Processes

#### 5. `kill <PID>`

Sends `SIGTERM` to a process, requesting that it terminate gracefully.

```bash
kill 2456
```

The process can perform cleanup before exiting, but it is not guaranteed to stop immediately.

#### 6. `kill -9 <PID>`

Sends `SIGKILL`, forcing the process to stop immediately.

```bash
kill -9 2456
```

> Use `kill -9` only when graceful termination fails because the process cannot save data or perform cleanup.

### Managing Shell Jobs

#### 7. `<command> &`

Starts a command as a background job in the current shell.

```bash
sleep 300 &
```

#### 8. `jobs`

Lists jobs started from the current shell.

```bash
jobs
```

#### 9. `fg`

Brings a background or stopped job into the foreground.

```bash
fg %1
```

Here, `%1` means job number 1 as reported by `jobs`.

### Priority and Monitoring

#### 10. `nice -n <value> <command>`

Starts a process with a specified niceness value.

```bash
nice -n 10 tar -czf backup.tar.gz documents/
```

Niceness normally ranges from `-20` to `19`:

- Lower value: higher scheduling priority
- Higher value: lower scheduling priority
- Regular users usually cannot assign negative values

#### 11. `watch <command>`

Runs a command repeatedly and refreshes its output, normally every two seconds.

```bash
watch df -h
```

Use `-n` to set a custom interval:

```bash
watch -n 5 free -h
```

#### 12. `uptime`

Displays the current time, system uptime, logged-in user count, and load averages.

```bash
uptime
```

---

## 2. File-System Commands

### Navigation

#### 13. `ls`

Lists files and directories.

```bash
ls
```

For a detailed, human-readable listing:

```bash
ls -lh
```

#### 14. `cd <directory>`

Changes the current working directory.

```bash
cd /var/log
```

Useful forms:

```bash
cd ..    # Move to the parent directory
cd       # Move to the user's home directory
cd -     # Return to the previous directory
```

### Creating Files and Directories

#### 15. `touch <file_name>`

Creates an empty file if it does not exist. If it exists, `touch` updates its access and modification timestamps.

```bash
touch notes.txt
```

#### 16. `mkdir <directory_name>`

Creates a new directory.

```bash
mkdir project
```

Create parent directories when necessary:

```bash
mkdir -p project/docs/notes
```

### Removing Files and Directories

#### 17. `rm <file_name>`

Removes a file.

```bash
rm old-notes.txt
```

Ask for confirmation before removal:

```bash
rm -i old-notes.txt
```

> Files removed with `rm` normally do not go to a recycle bin. Verify the path before pressing Enter.

#### 18. `rmdir <directory_name>`

Removes an empty directory.

```bash
rmdir old-project
```

It returns an error if the directory contains files or subdirectories.

### Viewing File Contents

#### 19. `cat <file>`

Displays a file's contents in the terminal. It is most useful for small text files.

```bash
cat /etc/os-release
```

#### 20. `head -n <number> <file>`

Displays the first specified number of lines from a file.

```bash
head -n 20 /etc/services
```

---

## 3. Network Troubleshooting

#### 21. `ip addr`

Displays network interfaces and their IPv4 and IPv6 addresses.

```bash
ip addr
```

A shorter display is available with:

```bash
ip -br addr
```

#### 22. `hostname -I`

Displays the IP addresses assigned to the system. It can return more than one address.

```bash
hostname -I
```

#### 23. `ping <hostname_or_ip>`

Tests basic network reachability and measures response time by sending ICMP echo requests.

```bash
ping -c 4 8.8.8.8
```

> A failed ping does not always mean the remote system is down. A firewall may be blocking ICMP traffic.

#### 24. `curl <URL>`

Transfers data to or from a URL and displays the response body by default.

```bash
curl https://example.com
```

Display response headers only:

```bash
curl -I https://example.com
```

Save a download using its remote filename:

```bash
curl -O https://example.com/file.zip
```

#### 25. `dig <domain>`

Performs a detailed DNS lookup for a domain name.

```bash
dig example.com
```

Display a shorter answer:

```bash
dig +short example.com
```

---

## 4. Optional Package Installation

Some commands, including `htop` and `dig`, might not be installed by default.

### Ubuntu or Debian

```bash
sudo apt update
sudo apt install htop dnsutils procps
```

### Rocky Linux, RHEL, or Fedora

```bash
sudo dnf install htop bind-utils procps-ng
```

---

## 5. Quick Reference

| No. | Command | Main purpose |
|---:|---|---|
| 1 | `ps` | View processes for the current terminal |
| 2 | `ps aux` | View detailed system-wide process information |
| 3 | `top` | Monitor processes and resource usage in real time |
| 4 | `htop` | Use an interactive process viewer |
| 5 | `kill <PID>` | Request graceful process termination |
| 6 | `kill -9 <PID>` | Force a process to stop |
| 7 | `<command> &` | Start a background job |
| 8 | `jobs` | List jobs in the current shell |
| 9 | `fg` | Bring a job to the foreground |
| 10 | `nice` | Start a process with a selected priority |
| 11 | `watch` | Run a command repeatedly |
| 12 | `uptime` | View uptime and load averages |
| 13 | `ls` | List directory contents |
| 14 | `cd` | Change the current directory |
| 15 | `touch` | Create a file or update timestamps |
| 16 | `mkdir` | Create a directory |
| 17 | `rm` | Remove a file |
| 18 | `rmdir` | Remove an empty directory |
| 19 | `cat` | Display file contents |
| 20 | `head` | Display the beginning of a file |
| 21 | `ip addr` | View network interfaces and addresses |
| 22 | `hostname -I` | Display assigned IP addresses |
| 23 | `ping` | Test basic network reachability |
| 24 | `curl` | Transfer data using a URL |
| 25 | `dig` | Perform a DNS lookup |

---

## Practice Reminder

Do not only memorize command names. Run each command in a safe lab, examine its output, and practice explaining:

1. What the command does
2. Why an administrator uses it
3. Which important options it supports
4. What risks or limitations it has
