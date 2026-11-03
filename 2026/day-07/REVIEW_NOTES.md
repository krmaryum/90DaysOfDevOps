# Day 07 — Organization Review

## Preservation and Scope

All 40 uploaded files are retained byte-for-byte. The original teacher README is under Original_Assignment; the required submission stays at Day 07 root. All other source folders move together under Additional_Resources, preserving their relative relationships and original filenames. The empty md/Shell directory is retained in the ZIP; Git does not track empty directories.

## Homework Coverage

The teacher names six core directories and three optional directories. The submission covers five core directories, omitting /root, and does not include /bin, /usr/bin or /opt sections. Its directory contents are labelled samples, not full command-output captures. The largest-log/config/home drill has no recorded results in the main submission.

The high-CPU scenario is present. The script-permission answer is labelled Scenario 3 in the submission but corresponds to teacher Scenario 4. Answers for myapp service startup (four ordered commands) and Docker service logs are absent from the main submission. The separate 20 user-management scenarios should not be mistaken for those four assigned scenarios.

## Source Consistency Issues

- The high-CPU ps command places cmd before the percentage columns, while the displayed output places COMMAND last. Preserve the snippet but verify it before citing it as an exact output of that command.
- The permissions example uses chmod +x yet shows only the owner's execute bit changing. The resulting mode depends on the requested classes and umask; the displayed mode is not universally guaranteed. No actual execution was performed during this organization pass.
- The teacher's service-log question asks about Docker, while its commands use ssh. Treat the service name as task-specific. Original teacher instructions are preserved as written.
- Scenario and solution files mix hypothetical examples, expected results, and narrated lab records. Their presence is not evidence that all 20 scenarios or all quiz activities were completed.
- Existing account repair, recursive ownership, permission, deletion and SELinux commands are reference content; none were run by the packaging workflow. This is a structural and assignment-alignment review, not a comprehensive technical audit.

## Exact Duplicate Groups — All Retained

- `Additional_Resources/md/MCQS/SELinux/README.md`; `Additional_Resources/md/SELinux/MCQS/README.md`
- `Additional_Resources/md/MCQS/SELinux/selinux-context-confined-25-mcqs-timer.html`; `Additional_Resources/md/SELinux/MCQS/selinux-context-confined-25-mcqs-timer.html`
- `Additional_Resources/md/User-and-Group-Management/linux-user-management-troubleshooting-and-user-decommissioning.md`; `Additional_Resources/solutions/linux-user-management-troubleshooting-and-user-decommissioning.md`

A future consolidation could keep one canonical copy and link from the other location, after approval. Both current copies remain. English and Roman Urdu companions are not duplicates merely because they address the same subject.

## Applying This Package

Extract outside the repository. Back up the current Day 07 outside the repo and compare any newer local work. Put the extracted day-07 under the repository's 2026 directory, without a nested day-07/day-07. Keep the move map and review notes inside Day 07. Review staged moves before committing, leaving previous days and root documentation intact.

New navigation links were checked locally; the previous-day link depends on Day 06 in the full repository. Original relative links retain their folder relationships, but pre-existing internal/external links and quiz scripts were not comprehensively validated. No GitHub commit or push was performed.
