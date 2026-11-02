# Day 02 — Linux Architecture, Processes, and systemd

[Previous: Day 01](../day-01/README.md) | [Original teacher assignment](Original_Assignment/README.md) | [Additional resources](Additional_Resources/README.md)

## Suggested Study Sequence

Read the original homework → review the architecture notes → revise processes and systemd → consult supplementary material as needed.

## Study and Homework Status

| Item | Documented checkpoint |
|---|---|
| Teacher assignment | Preserved in full |
| Required architecture notes | Existing submission available; original wording retained |
| Process states and five commands | Included in the submitted notes |
| Practical evidence | CPU study notes contain a described lab; no independent Day 02 terminal capture supplied |
| Commit and push | Not verified by the uploaded ZIP |

The owner reports completing the bootcamp. This status table describes the supplied Day 02 material only.

## Topic and Objectives

The teacher's task is to explain Linux kernel, user space, init/systemd, process creation and management, and why systemd matters for troubleshooting. The guidelines request process states, five daily commands, short headings and bullet points, and a practical note under one page.

## Original Homework

Create `linux-architecture-notes.md` under `2026/day-02/`, then commit and push to the fork. The teacher asks learners to use their own understanding and avoid copying AI-generated content.

[Read the complete original assignment](Original_Assignment/README.md).

## My Submitted Work

[Linux architecture — original beginner notes](linux-architecture-notes.md).

The file covers kernel, user space, init/systemd, processes, running/sleeping/zombie states, and five command examples. Its contents remain unchanged. It is approximately 200 Markdown lines, so the teacher's under-one-page target deserves review if preparing a shorter future submission; display length depends on rendering.

## Commands Already Included in My Notes

| Example | Purpose described in the submission |
|---|---|
| `ls` | List files and directories |
| `touch file.txt` | Create a file |
| `cat file.txt` | Display file content |
| `tail -f /var/log/syslog` | Follow a system log where that file exists |
| `ping trainwithshubham.com` | Check connectivity to the named host |

These are documented examples, not proof that they were executed. The original notes also include a process-filter example. This organization pass preserves the source text and does not certify every technical statement in the study collection.

## Practical Exercises and Supporting Study

The assigned deliverable is an explanatory note; no additional required lab has been invented.

- [CPU utilization notes](Additional_Resources/basics-Linux/Linux-CPU-Utilization-yes-top-mpstat-Study-Notes.md) describe a workload and observations.
- [Bash prompt guide](Additional_Resources/basics-Linux/colered-username-hostname/Bash_Prompt_Colors_Study_Notes.md) contains optional customization practice.
- User management, shell startup, streams, SSH, and disk troubleshooting are supplementary resources; their presence does not establish that they were required on Day 02.

## Review and Evidence

Before a future revision, check technical examples against the relevant system's manual pages and the teacher's expectations. Keep the original submission available. Additional process/systemd terminal output or a commit URL can be added when supplied; no new execution results are claimed here.

## Navigation

[Additional resources](Additional_Resources/README.md) | [File move map](FILE_MOVE_MAP.csv) | [Review notes](REVIEW_NOTES.md) | [Previous day](../day-01/README.md)

Day 03 will be linked after its original coursework is reviewed.
