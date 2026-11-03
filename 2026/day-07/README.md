# Day 07 — Linux File System Hierarchy and Scenario-Based Practice

[Previous: Day 06](../day-06/README.md) | [Teacher assignment](Original_Assignment/README.md) | [Original submission](day-07-linux-fs-and-scenarios.md)

## Suggested Study Sequence

Read the original assignment → review the filesystem notes → check teacher-scenario coverage → consult supporting notes and scenarios → use optional quizzes for revision.

## Study and Homework Status

| Item | Documented checkpoint |
|---|---|
| Original teacher task | Preserved unchanged |
| Required submission | Original file preserved at its required path |
| Core directories | /, /home, /etc, /var/log and /tmp discussed; /root missing |
| Additional directories | /bin, /usr/bin and /opt absent from main submission |
| Directory observations | Sample contents given; full terminal listings not supplied |
| Teacher Scenario 2: high CPU | Commands and process-output snippets included |
| Teacher Scenario 4: permissions | Answer present but labelled Scenario 3 in the submission |
| Teacher Scenarios 1 and 3 | myapp startup and Docker-log answers absent from main submission |
| Additional learning | Notes, quizzes, 20 user-management scenarios, and solution guides available |
| Git submission | Commit and push not verified by the ZIP |

## Original Homework and Objectives

Explain Linux directory purposes, inspect contents and state when each directory is useful. Complete the filesystem checks and four troubleshooting scenarios: service startup, high CPU, service logs, and script permissions. Submit `day-07-linux-fs-and-scenarios.md` in this folder.

[Read the complete teacher assignment](Original_Assignment/README.md), including commands, hints and the solved example.

## My Submitted Work

[Open the original filesystem and scenario notes](day-07-linux-fs-and-scenarios.md).

The file contains five directory descriptions, high-CPU investigation examples and a permissions scenario. Its original wording, numbering and output snippets are unchanged. Sample directory contents are not represented as independently captured terminal evidence.

## Commands and Practical Examples

The main submission includes directory-listing examples, top, a CPU-sorted ps command, ps -fp 1521, top -p 1521, ls -l and chmod. The recorded CPU example identifies a yes process; it is not evidence of a production application incident. The permissions section includes hypothetical before/after output, rather than proof of actual recovery.

## Supporting Materials

[Browse all additional resources](Additional_Resources/README.md): streams and redirection; permissions, ACL and umask; SELinux; user/group management; quizzes; scenario questions and solutions.

Supporting files remain together under Additional_Resources so existing relative links among md/, scenario-based-questions/ and solutions/ keep their relationship. The 20 user-management scenarios are supplementary and distinct from the teacher's four scenarios.

## Remaining Homework Review

Add only actual work when addressing /root, the optional directory sections, the teacher's filesystem drill, and missing scenario answers. The teacher's Docker-log scenario shows ssh commands in its hint; adapt the service name to the actual question rather than copying the hint unchanged. Existing numbering and command/output inconsistencies are listed in the review notes.

## Navigation

[Review notes](REVIEW_NOTES.md) | [File move map](FILE_MOVE_MAP.csv) | [Previous day](../day-06/README.md)

Day 08 will be linked after its actual coursework is reviewed.
