# Day 05 — Linux Troubleshooting Drill: CPU, Memory, and Logs

[Previous: Day 04](../day-04/README.md) | [Teacher assignment](Original_Assignment/README.md) | [Runbook summary](linux-troubleshooting-runbook.md)

## Suggested Study Sequence

Read the original task → review the concise SSH summary → inspect the detailed source outputs → consult the supplementary Nginx and high-CPU runbooks.

## Study and Homework Status

| Item | Documented checkpoint |
|---|---|
| Teacher instructions | Preserved unchanged |
| Detailed SSH drill | Original file and output snippets retained unchanged |
| Required filename | New linux-troubleshooting-runbook.md summarizes existing source records |
| Additional runbooks | Original Nginx and high-CPU documents retained |
| CPU simulation | Process and vmstat outputs recorded; recovery output not captured |
| Evidence consistency | Several interpretation and output mismatches flagged in review notes |
| Git submission | Commit/push not verified by the ZIP |

## Original Homework

Choose one process or service, capture CPU/memory/disk/network health and relevant logs, and write a concise runbook with observations and three “If this worsens” steps. The teacher specifies at least eight commands, while also listing six categories with two commands each; the full category list is broader than the minimum count.

[Read the full assignment](Original_Assignment/README.md).

## Coursework and Supporting Files

- [Concise SSH runbook](linux-troubleshooting-runbook.md): newly assembled summary under the teacher's requested filename. Derived from existing records, not new execution evidence.
- [Original detailed troubleshooting drill](linux-troubleshooting-runbook-detailed.md): SSH baseline, health snapshots, logs, HTTP/Nginx checks and CPU simulation.
- [Supplementary runbooks](Additional_Resources/README.md): separate Nginx and high-CPU scenarios.

## Commands and Practical Work

The detailed source includes uname, os-release, temporary-file operations, top, ps, free, df, du, vmstat, ss, curl, journalctl and tail. Its later yes-based CPU simulation includes a process snapshot and interval vmstat output. Not every suggested step has captured output, and sample observations should not be treated as proof of completed recovery.

The new concise summary keeps SSH as the target and distinguishes the HTTP check and CPU simulation from that baseline. Additional diagnostic and recovery steps are proposals, not invented completed work.

## Review Before Showcase

The Nginx runbook's memory check contains disk output. Its backend check fails, but the supplied material does not establish a complete configured reverse-proxy incident or a successful recovery. The detailed SSH document's “no recent errors” wording should be read alongside the authentication-error entries. Originals remain unchanged; consult the [review notes](REVIEW_NOTES.md).

## Navigation

[File move map](FILE_MOVE_MAP.csv) | [Review notes](REVIEW_NOTES.md) | [Previous day](../day-04/README.md)

Day 06 will be linked after its actual coursework is reviewed.
