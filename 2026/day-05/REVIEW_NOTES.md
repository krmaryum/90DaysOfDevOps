# Day 05 — Organization and Evidence Review

## Preservation and Required Filename

All four uploaded files remain byte-for-byte unchanged. The teacher README is under Original_Assignment; two supplementary runbooks moved together under Additional_Resources. The detailed SSH file stays at Day 05 root. No identical file duplicates were found in the input.

The exact requested filename, linux-troubleshooting-runbook.md, was absent. A new concise SSH summary was added from the existing detailed record, with provenance and limits explicit. Its three future steps are proposed actions, not completed assignments or recorded recovery. Original source content has not been rewritten.

## Evidence and Interpretation Issues

- The detailed record combines baseline SSH checks, an HTTP check with Nginx installation, and a CPU simulation. These are separate activities, with outputs recorded at different times.
- sshd memory entries include 1.1%, despite the source saying all usage is below 1%.
- The journal explanation says n=20 but later describes 50 entries. The command is retained unchanged.
- Authentication output includes connection resets and an invalid-format banner; it does not justify an unqualified claim of no suspicious activity. No compromise is established either.
- Nginx's free -h section contains df-style disk output. Do not use it as memory evidence.
- The Nginx temporary-directory output names runbook-demo rather than the command's runbook-nginx, and includes extra content. Copying one file under /tmp does not establish every relevant filesystem is writable.
- Nginx listener output shows port 80, not proof of a 443 listener. The localhost:8080 probe fails; supplied config/log outputs do not establish that this is the configured upstream or prove a complete 502/504 root cause.
- Nginx's production-host label is a source scenario label, not independently established provenance.
- The detailed CPU simulation contains process/vmstat snippets, while several later steps list only expected observations. Successful mitigation and final recovery lack captured output. Broad pkill/killall examples and force-kill instructions remain original text; no commands were executed during packaging.
- The high-CPU file is a general procedure with myapp/PID placeholders and blank post-incident fields. It is not a completed incident report. Its threshold interpretations are simplified and have not been comprehensively technically audited here.

## Applying This Package

Extract outside the repository. Back up the existing Day 05 outside the repo, compare any newer local work, then place this package's day-05 folder under the repository's 2026 directory. Do not create day-05/day-05. Keep the move map and review notes inside Day 05, leaving earlier days untouched. Review the staged diff before committing; expect two unchanged supplementary-file moves, the detailed file unchanged, a new summary and new documentation.

No GitHub commit or push was performed. New local navigation links were checked; the previous-day link depends on Day 04 in the full repository. No new command outputs or evidence were generated.
