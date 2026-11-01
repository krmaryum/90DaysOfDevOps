# Linux CPU Utilization Lab: `yes`, `top`, `nproc`, and `mpstat`

## Lab objective

This lab explains why a single `yes > /dev/null` process can show `100%` CPU while the complete system still shows approximately `91.7%` idle.

It also explains the difference between:

- Per-process CPU utilization
- Per-logical-CPU utilization
- Overall system CPU utilization
- User CPU time (`%usr`)
- System/kernel CPU time (`%sys`)

## Test environment

The system has 12 logical CPUs:

```bash
nproc
```

Output:

```text
12
```

## Generate a controlled CPU workload

Run this command in one terminal:

```bash
yes > /dev/null
```

The `yes` command continuously generates the character `y`. Redirection sends the output to `/dev/null`, which discards the data.

Even though no text is saved to disk, the command continuously performs `write()` system calls.

Stop the command with:

```text
Ctrl+C
```

Or stop all processes named exactly `yes` from another terminal:

```bash
pkill -x yes
```

## Observe the process with `top`

In another terminal, run:

```bash
top
```

Example process entry:

```text
PID   USER     S   %CPU   COMMAND
2637  khalid   R   100.0  yes
```

The `100%` shown for `yes` means it is consuming approximately the full capacity of **one logical CPU**. It does not mean that all 12 logical CPUs are busy.

On Linux, a single-threaded process generally reaches a maximum of approximately `100%` in the default `top` process view. A multithreaded process may exceed `100%` by using several logical CPUs.

## Understand the overall CPU line in `top`

Example:

```text
%Cpu(s): 1.1 us, 7.2 sy, 0.0 ni, 91.7 id, 0.0 wa
```

The CPU line at the top is an average across all 12 logical CPUs.

| Field | Meaning | Observed value |
|---|---|---:|
| `us` | CPU time used by user-space code | `1.1%` |
| `sy` | CPU time used by kernel code and system calls | `7.2%` |
| `ni` | CPU time used by niced processes | `0.0%` |
| `id` | Idle CPU capacity | `91.7%` |
| `wa` | CPU time waiting for I/O completion | `0.0%` |

Total system utilization is:

```text
1.1% user + 7.2% system = 8.3% busy
```

The remaining capacity is:

```text
100% - 8.3% = 91.7% idle
```

## Why one busy CPU equals approximately 8.33% overall

The machine has 12 logical CPUs, but `yes` is single-threaded and uses only one of them:

```text
1 busy logical CPU / 12 logical CPUs × 100 = 8.33%
```

Therefore, the following two observations are both correct:

```text
yes process CPU utilization       ≈ 100% of one logical CPU
Overall system CPU utilization    ≈ 8.33%
Overall system idle capacity      ≈ 91.67%
```

## Observe every logical CPU with `mpstat`

Run:

```bash
mpstat -P ALL 1
```

Command breakdown:

| Part | Meaning |
|---|---|
| `mpstat` | Reports processor utilization statistics |
| `-P ALL` | Displays the overall average and every logical CPU separately |
| `1` | Refreshes the report every one second |

Example overall row:

```text
CPU   %usr   %sys   %iowait   %idle
all   1.17   7.17      0.00    91.66
```

Example row for logical CPU 8:

```text
CPU   %usr   %sys   %iowait   %idle
8     14.00  86.00     0.00     0.00
```

Other CPUs were approximately:

```text
CPU   %usr   %sys   %idle
0-7   0.00   0.00   100.00
9-11  0.00   0.00   100.00
```

## Interpretation of the `mpstat` output

Logical CPU 8 is fully utilized:

```text
14% user + 86% system + 0% idle = 100%
```

The other 11 logical CPUs are mostly idle. Across all 12 CPUs, the average utilization is approximately:

```text
1.17% user + 7.17% system = 8.34% busy
```

This agrees with the expected value:

```text
1 / 12 × 100 = 8.33%
```

Minor differences are normal because CPU statistics are sampled over time and other processes may briefly run.

## Is this a user issue or a system issue?

The workload is **started by a user-space process**, but most of its measured CPU time appears under **system CPU**.

The flow is:

```text
User starts `yes`
        ↓
`yes` generates data in user space
        ↓
`yes` repeatedly requests `write()`
        ↓
Kernel handles those system calls
        ↓
CPU time is recorded mainly as `%sys`
```

Therefore, the correct conclusion is:

> A user-space command is creating a syscall-heavy workload, causing high system/kernel CPU time on one logical CPU.

High `%sys` in this controlled test does not mean that the Linux kernel is defective. The kernel is performing the work requested by the `yes` process.

## Why `%sys` is much higher than `%usr`

The test command is:

```bash
yes > /dev/null
```

The process performs two main activities:

1. It generates data in user space.
2. It repeatedly calls the kernel to write that data to `/dev/null`.

In this test, continuous `write()` system calls consume more CPU time than generating the data. Therefore, the output shows values such as:

```text
%usr = 14%
%sys = 86%
```

## Why `%iowait` remains zero

`/dev/null` discards data immediately. It does not write the data to a physical disk.

Therefore:

```text
%iowait = 0%
```

The workload is CPU and system-call intensive, but it is not waiting for disk I/O.

## Why the busy CPU number may change

In the sample output, logical CPU 8 was busy. The Linux scheduler can later migrate the `yes` process to another logical CPU.

Therefore, a later report may show CPU 3 or CPU 10 as busy instead. This is normal unless the process has been pinned to a specific CPU.

## View individual CPUs in `top`

While `top` is running, press:

```text
1
```

This toggles the per-logical-CPU view. You should see one logical CPU near `100%` utilization and the remaining CPUs mostly idle.

## Confirm the system calls

You can observe the system-call pattern for five seconds:

```bash
timeout 5 strace -c yes > /dev/null
```

The summary should show heavy use of the `write()` system call. Remember that `strace` adds monitoring overhead, so do not use its CPU percentages as an exact benchmark.

## Optional: use all logical CPUs for a short lab

To launch one `yes` process per available logical CPU:

```bash
for ((i=1; i<=12; i++)); do
    yes > /dev/null &
done
```

Then monitor:

```bash
mpstat -P ALL 1
```

The overall `%idle` value should fall close to `0%` because approximately 12 logical CPUs are now busy.

Stop the test immediately after observation:

```bash
pkill -x yes
```

Verify that no `yes` process remains:

```bash
pgrep -a -x yes
```

No output means that all matching test processes have stopped.

## Quick command reference

```bash
# Display the number of available logical CPUs
nproc

# Start a single-threaded CPU/system-call workload
yes > /dev/null

# Observe processes and overall CPU utilization
top

# Observe every logical CPU once per second
mpstat -P ALL 1

# Inspect system-call usage for five seconds
timeout 5 strace -c yes > /dev/null

# Stop all processes named exactly yes
pkill -x yes

# Confirm that no yes process remains
pgrep -a -x yes
```

## Final conclusion

In this 12-logical-CPU system:

- `yes` is single-threaded and uses approximately one logical CPU.
- `100%` beside the `yes` process means one logical CPU is fully utilized.
- One fully utilized CPU represents approximately `8.33%` of the complete system capacity.
- Overall CPU idle remains approximately `91.67%` because the other 11 logical CPUs are mostly idle.
- `%sys` is high because `yes` continuously makes `write()` system calls to `/dev/null`.
- `%iowait` remains zero because `/dev/null` does not perform physical disk I/O.
- The test is user-initiated, but its CPU time is recorded mainly as system/kernel time.
