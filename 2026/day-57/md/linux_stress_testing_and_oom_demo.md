# Linux Stress Testing and OOM Simulation

## Install Stress Tool

```bash
sudo apt update
sudo apt install stress -y
```

---

## CPU Stress

Use all CPU cores:

```bash
stress --cpu $(nproc)
```

---

## Memory Stress (Safe)

```bash
stress --vm 1 --vm-bytes 90% --timeout 30s
```

- Uses 90% of RAM
- Runs for 30 seconds

---

## Memory Stress (Aggressive)

```bash
stress --vm 2 --vm-bytes 2G --vm-keep
```

- Allocates memory continuously
- May trigger OOM Killer

---

## CPU + Memory Stress

```bash
stress --cpu $(nproc) --vm 1 --vm-bytes 80% --timeout 30s
```

---

## OOM Simulation

- When memory is exhausted, Linux triggers the OOM Killer
- It terminates processes to free memory

### Check OOM Logs

```bash
dmesg | grep -i oom
```

or

```bash
dmesg | grep -i kill
```

---

## Monitoring Tools

### htop (Recommended)

```bash
sudo apt install htop -y
htop
```

### top

```bash
top
```

Useful shortcuts:
- Shift + P → sort by CPU
- Shift + M → sort by Memory

---

## Watch Memory Usage

```bash
watch -n 1 free -h
```

---

## Detailed Stats

```bash
vmstat 1
```

---

## Track Stress Process

```bash
ps aux | grep stress
```

---

## Stop Stress

```bash
pkill stress
```

---

## Demo Steps

### Terminal 1

```bash
htop
```

### Terminal 2

```bash
stress --cpu $(nproc) --vm 1 --vm-bytes 80% --timeout 30s
```

---

## Summary

- CPU stress → max CPU usage
- Memory stress → fills RAM
- OOM → system kills processes (SIGKILL / signal 9)
- Monitoring → htop, top, vmstat
- Always use timeout for safe testing

---

## Observed Behavior (Real Demo)

### Safe Run

```bash
stress --vm 1 --vm-bytes 430M --timeout 30s
```

- Completed successfully
- Stayed within available memory

### OOM Scenario

```bash
stress --vm 1 --vm-bytes 700M --vm-keep
```

Output:

```
worker got signal 9
```

- Signal 9 = SIGKILL
- Process killed by Linux OOM Killer

---

## Why OOM Happened

- Total RAM ≈ 911Mi
- Available ≈ 548Mi
- Swap = 0 (no backup memory)
- Requested memory > available → OOM triggered

---

## Forcing a Real Crash (Kernel Panic)

```bash
echo c | sudo tee /proc/sysrq-trigger
```

### Result

- Immediate kernel panic
- SSH connection dropped
- VM rebooted or stopped

---

## Key Difference

| Scenario       | Behavior |
|----------------|----------|
| OOM Kill       | Only process is killed (system survives) |
| Kernel Panic   | Entire system crashes |

---

## Verification After Reboot

```bash
last -x | head
```

```bash
journalctl -k -b -1
```

- Shows previous boot logs
- Confirms kernel panic event

