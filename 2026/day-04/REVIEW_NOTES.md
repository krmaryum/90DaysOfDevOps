# Day 04 — Revised Guide and Original Evidence

## What Changed

The owner supplied a Git diff replacing the 247-line original practice log with an expanded 869-line study guide. The revised file supplies instructions, illustrative/expected output, revision questions, and an unchecked completion checklist. It is not a new execution log.

The original uploaded teacher README remains byte-for-byte unchanged under Original_Assignment/README.md. The original uploaded practice log is preserved byte-for-byte under Original_Assignment/linux-practice-original.md. The revised linux-practice.md is intentionally excluded from this documentation update; keep the owner's current working copy. The supplied diff header reports 869 lines, but this review does not rely on an exact line count.

## Evidence Boundaries

The original log contains recorded host output and a separate supervisord container example. That container example's provenance is not confirmed as the owner's lab. The original journal and dpkg headings conflict with the displayed outputs. The missing apache2 unit result does not establish that Apache is absent, and the log does not contain a status check for the same installed service whose journal is shown.

The revised guide improves organization and discusses those concepts, but replaces the original output with general instructions and examples. Its checklist remains unchecked. Added commands and model examples must not be treated as completed homework. Keep actual execution evidence and reference material distinguishable.

## Applying Before Commit

Keep your existing revised linux-practice.md. Copy README.md, REVIEW_NOTES.md, FILE_MOVE_MAP.csv and Original_Assignment/linux-practice-original.md from this package into the corresponding Day 04 paths. Keep the teacher README. Stage only Day 04 and inspect the final diff. The original log copy can alternatively be recovered from the pre-commit Git HEAD while Day 04 changes are still uncommitted.

This package does not change earlier days or the repository root. No commit or push was performed. New file links were checked; the previous-day link depends on Day 03 in the full repository. This is a structural review, not comprehensive technical validation of every exercise.
