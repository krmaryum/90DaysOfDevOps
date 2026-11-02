# Day 05 — SSH Troubleshooting Runbook: Summary of Existing Records

**Target:** SSH service / sshd process. **Recorded environment:** Ubuntu 24.04.3 LTS on an AWS-kernel x86_64 host.

This new summary is derived from [the original detailed record](linux-troubleshooting-runbook-detailed.md). It does not record a newly executed drill. Outputs come from different times; do not treat them as one simultaneous snapshot.

## Health Snapshot and Logs

| Existing command | Observation in the supplied record |
|---|---|
| `uname -a` | Ubuntu AWS kernel and x86_64 architecture displayed |
| `cat /etc/os-release` | Ubuntu 24.04.3 LTS identified |
| `mkdir /tmp/runbook-demo` | Temporary-directory step documented |
| `cp /etc/hosts /tmp/runbook-demo/hosts-copy` and `ls -l /tmp/runbook-demo` | Copied file listed; output block also includes material from other commands |
| `top -b -n 1` (piped to head in source) | Low load, 95.2% idle and 4.8% wait in the displayed summary |
| `ps -o pid,pcpu,pmem,comm -C sshd` | sshd rows show 0.0% CPU and 0.7–1.1% memory |
| `free -h` | 566 MiB available; no swap configured in that snapshot |
| `df -h` | Root filesystem 27% used in that snapshot |
| `sudo du -sh /var/log` | 44 MiB log-directory size recorded |
| `vmstat 1 5` | Later interval rows show little CPU activity and zero recorded wait |
| `sudo ss -tulpn` (filtered for ssh in source) | SSH-related listeners on TCP 22 displayed |
| `journalctl -u ssh -n 20` | SSH starts/stops and a login recorded across boots |
| `tail -n 20 /var/log/auth.log` | Cron entries, connection resets, and an invalid-format banner recorded |

See the detailed record for original output snippets. The snapshots do not prove ongoing service health. The source also includes HTTP checks before/after Nginx installation; these are a separate web check, not an SSH endpoint test.

## Quick Findings and Limits

The baseline resource samples do not show sustained CPU pressure. SSH listeners and journal entries are documented. Authentication-log errors are present, so the source's broad “no suspicious activity” conclusion needs contextual review. A later CPU simulation has its own process and vmstat output and is separate from this SSH baseline.

## If This Worsens — Proposed Next Steps

1. Capture fresh status, listener and journal evidence for the actual SSH unit while retaining the current remote session; record the host, time and user impact.
2. Compare repeated resource samples and authentication events with the baseline; collect relevant diagnostic detail if symptoms persist.
3. Escalate with timestamps and captured evidence. Consider a service change only after assessing access impact and the recovery path; no restart or recovery is claimed here.

These three steps are proposed future actions, not activities already completed.
