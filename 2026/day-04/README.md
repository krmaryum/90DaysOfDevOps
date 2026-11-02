# Day 04 — Linux Practice: Processes and Services

[Previous: Day 03](../day-03/README.md) | [Teacher assignment](Original_Assignment/README.md) | [Study guide](linux-practice.md)

## Suggested Study Sequence

Read the teacher task → review the original recorded log → work through the revised guide as needed → record actual results and mark only completed activities.

## Study and Homework Status

| Item | Documented checkpoint |
|---|---|
| Teacher task | Preserved without changes |
| Original practice log | Preserved separately with its recorded outputs |
| Revised linux-practice.md | Expanded study guide with instructions, examples, and an unchecked checklist |
| New lab execution | Not established by the revised guide |
| Original service inspection | Missing apache2 unit result and SSH journal entries recorded; no status output for the same existing service |
| Container example | Present in the original log; origin remains unconfirmed |

## Original Homework

Run and record at least six commands, including two process, two service, and two log commands. Inspect an existing service and capture a troubleshooting flow. Submit `linux-practice.md` under `2026/day-04/`.

[Read the full teacher assignment](Original_Assignment/README.md).

## Files and Their Purpose

- [Revised practice guide](linux-practice.md): system identity, processes, safe test jobs, top, priority, PID 1, service units, logs, troubleshooting, questions, and an unchecked checklist.
- [Original practice log](Original_Assignment/linux-practice-original.md): the earlier submitted document with recorded host and container outputs, retained unchanged.
- [Review notes](REVIEW_NOTES.md): scope, evidence limits, and source preservation.
- [File move map](FILE_MOVE_MAP.csv): original input paths and current destinations.

## Commands and Practical Exercises

The revised guide contains process inspection, sleep-based process-control practice, service checks, journal queries, and package-log examples. It describes what to run; sample and expected output are not personal execution evidence. The additional exercises supplement the original teacher task and do not imply completion.

The original log records ps, pgrep, top, systemctl list-unit-files, a missing apache2 unit check, SSH journal entries, and dpkg log output. Its later supervisord example comes from a separate environment. Neither that example nor the new guide establishes a successful status check of an installed service on the owner's host.

## Next Evidence to Add

On the actual lab system, identify one existing service, record its status and relevant logs, and label the environment and date. Keep reference examples separate from observed output. No new execution results were created during this reorganization.

The original log has heading inconsistencies: the SSH journal section predicts empty output despite containing entries, and dpkg package logs are labelled SSH history. These remain in the preserved original; the expanded guide uses clearer explanations.

[Previous day](../day-03/README.md). Day 05 will be linked after its actual coursework is reviewed.
