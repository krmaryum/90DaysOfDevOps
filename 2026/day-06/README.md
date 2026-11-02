# Day 06 — Linux Fundamentals: Read and Write Text Files

[Previous: Day 05](../day-05/README.md) | [Teacher assignment](Original_Assignment/README.md) | [Original practice note](file-io-practice.md)

## Suggested Study Sequence

Read the teacher's task → review the recorded file operations → compare the output with the requirements → complete and capture missing work on the actual lab system.

## Study and Homework Status

| Item | Documented checkpoint |
|---|---|
| Teacher instructions | Preserved unchanged |
| file-io-practice.md | Original note and output snippets retained unchanged |
| File creation and redirection | touch, overwrite, append and cat outputs recorded |
| Partial reads | head and tail outputs recorded |
| Three-line notes.txt | Only two lines shown in the supplied record |
| Actual notes.txt deliverable | Not included in the uploaded ZIP |
| tee practice | Recorded as a separate privileged sudoers-file example |
| Git submission | Commit and push not verified by the ZIP |

## Original Homework and Objectives

Create `notes.txt`, write three lines using redirection, read it with cat, inspect parts with head and tail, and use tee to write and display text. Submit `file-io-practice.md` under `2026/day-06/`; the expected output also includes created files.

The teacher says both “write 3 lines” and “8–12 lines total in the file.” This is ambiguous. Preserve the wording and use the supplied three-line command flow as the concrete example, without inventing extra required text.

[Read the complete original assignment](Original_Assignment/README.md).

## My Submitted Work

[Open the original file I/O practice note](file-io-practice.md).

| Command recorded in the note | Documented role |
|---|---|
| `touch notes.txt` and `ls -l` | File created with zero-byte listing |
| `echo "This is line 1" > notes.txt` | First line written |
| `echo "This is line 2" >> notes.txt` | Second line appended |
| `cat notes.txt` | File contents displayed |
| `head -n 2 notes.txt` | First two lines displayed |
| `tail -n 2 notes.txt` | Last two lines displayed; same as head for this two-line file |
| `tee /etc/sudoers.d/khan` in a pipeline | Separate write-and-display example involving a privilege configuration file |

The last example grants broad passwordless sudo in its recorded rule. It changes system access and is unnecessary for basic file I/O. It remains preserved as historical source content; use the teacher's ordinary notes.txt example for this homework. The captured root prompt also differs from a general unprivileged shell context.

## Missing Work — Reference, Not Completed Output

The teacher's suggested third-line operation is:

```bash
echo "Line 3" | tee -a notes.txt
cat notes.txt
head -n 2 notes.txt
tail -n 2 notes.txt
```

This is a reference for a lab copy containing the first two lines. Run the append once when completing that exercise; repeating it appends additional copies. Record the actual output, retain the resulting notes.txt, and update the practice note only from real observations. No notes.txt or new output has been fabricated in this package.

## Review and Navigation

[Review notes](REVIEW_NOTES.md) | [File move map](FILE_MOVE_MAP.csv) | [Previous day](../day-05/README.md)

Day 07 will be linked after its actual coursework is reviewed.
