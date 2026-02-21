#  Table of Contents

- [Task 1: Basics](#task-1-basics)
- [Task 2: Operators and Conditionals](#task-2-operators-and-conditionals)
- [Task 3: Loops](#task-3-loops)
- [Task 4: Functions](#task-4-functions)
- [Task 5: Text Processing Commands](#task-5-text-processing-commands)
- [Task 6: Useful Patterns and One-Liners](#task-6-useful-patterns-and-one-liners)
- [Task 7: Error Handling and Debugging](#task-7-error-handling-and-debugging)

#  Shell Scripting Cheat Sheet (Bash)
## Practical Bash reference for DevOps work — fast lookup, real examples, production-safe patterns.

---

## Ultra Quick Reference (Master Table)

| Topic       | Key Syntax            | Example                            |
| ----------- | --------------------- | ---------------------------------- |
| Variable    | `VAR="value"`         | `NAME="DevOps"`                    |
| Argument    | `$1`, `$2`            | `./script.sh arg1`                 |
| If          | `if [[ cond ]]; then` | `if [[ -f file ]]; then`           |
| For         | `for i in list; do`   | `for i in 1 2 3; do`               |
| Function    | `name() { ... }`      | `greet() { echo "Hi"; }`           |
| Grep        | `grep pattern file`   | `grep -i "error" log.txt`          |
| Awk         | `awk '{print $1}'`    | `awk -F: '{print $1}' /etc/passwd` |
| Sed         | `sed 's/a/b/g'`       | `sed -i 's/foo/bar/g' file`        |
| Strict Mode | `set -euo pipefail`   | `set -euo pipefail`                |
| Debug       | `set -x`              | `bash -x script.sh`                |
| Cleanup     | `trap 'cmd' EXIT`     | `trap 'cleanup' EXIT`              |

---

## Task 1: Basics

| Topic           | Key Syntax         | Example                |
| --------------- | ------------------ | ---------------------- |
| Shebang         | `#!/bin/bash`      | `#!/bin/bash`          |
| Make Executable | `chmod +x file.sh` | `chmod +x script.sh`   |
| Run Script      | `./script.sh`      | `./script.sh`          |
| Comment         | `# comment`        | `echo "Hi" # greeting` |
| Variable        | `VAR="value"`      | `name="bhai"`          |
| Read Input      | `read var`         | `read username`        |
| Script Name     | `$0`               | `echo "$0"`            |
| First Argument  | `$1`               | `./script.sh file.txt` |
| All Args        | `"$@"`             | `for arg in "$@"; do`  |
| Exit Code       | `$?`               | `echo "$?"`            |

---

## Task 2: Operators and Conditionals

| Topic         | Key Syntax                  | Example                             |
|---------------|----------------------------|-------------------------------------|
| String Equal  | `[[ "$a" = "$b" ]]`        | `[[ "$env" = "prod" ]]`            |
| Empty         | `-z`                       | `[[ -z "$var" ]]`                  |
| Integer Equal | `-eq`                      | `[[ "$a" -eq 5 ]]`                 |
| Greater Than  | `-gt`                      | `[[ "$a" -gt 10 ]]`                |
| File Exists   | `-f`                       | `[[ -f file.txt ]]`                |
| Directory     | `-d`                       | `[[ -d /etc ]]`                    |
| AND           | `&&`                       | `[[ -f file ]] && echo OK`         |
| OR            | `\|\|`                     | `[[ -f file ]] \|\| echo Missing`  |
| NOT           | `!`                        | `if ! [[ -f file ]]; then`         |
| Case          | `case var in`              | `case "$1" in start)`              |

---

## Task 3: Loops

| Topic       | Key Syntax                | Example                      |
| ----------- | ------------------------- | ---------------------------- |
| For List    | `for i in list; do`       | `for i in 1 2 3; do`         |
| For C-Style | `for ((i=0;i<n;i++)); do` | `for ((i=0;i<5;i++)); do`    |
| While       | `while cond; do`          | `while [[ $x -lt 5 ]]; do`   |
| Until       | `until cond; do`          | `until [[ $x -gt 5 ]]; do`   |
| Break       | `break`                   | `[[ $i -eq 3 ]] && break`    |
| Continue    | `continue`                | `[[ $i -eq 3 ]] && continue` |
| Files       | `for f in *.log`          | `for f in *.log; do`         |
| Read File   | `while read line`         | `while read line; do ...`    |

---

## Task 4: Functions

| Topic         | Key Syntax   | Example                        |
| ------------- | ------------ | ------------------------------ |
| Define        | `name() {}`  | `greet() { echo Hi; }`         |
| Call          | `name`       | `greet`                        |
| Args          | `$1`, `$2`   | `add() { echo $(( $1+$2 )); }` |
| Return Status | `return N`   | `return 0`                     |
| Return Data   | `echo value` | `result=$(func)`               |
| Local Var     | `local var`  | `local temp="x"`               |

---

## Task 5: Text Processing Commands

| Command | Example |
|---------|---------|
| grep    | `grep -i "error" file` |
| awk     | `awk -F: '{print $1}' file` |
| sed     | `sed -i 's/a/b/g' file` |
| cut     | `cut -d, -f2 file.csv` |
| sort    | `sort -nr file` |
| uniq    | `sort file \| uniq -c` |
| tr      | `tr 'a-z' 'A-Z'` |
| wc      | `wc -l file` |
| head    | `head -n 20 file` |
| tail    | `tail -f app.log` |

---

## Task 6: Useful Patterns and One-Liners

| Task             | Example                                  |
| ---------------- | ---------------------------------------- |
| Delete old logs  | `find . -name "*.log" -mtime +7 -delete` |
| Count log lines  | `cat *.log \| wc -l`                     |
| Replace in files | `sed -i 's/foo/bar/g' *.conf`            |
| Check service    | `pgrep -x nginx`                         |
| Disk alert       | `df -h \| awk '$5+0>80{print}'`          |
| Parse JSON       | `jq '.name' file.json`                   |
| Tail errors live | `tail -f app.log \| grep ERROR`          |

---

## Task 7: Error Handling and Debugging

| Topic         | Syntax              | Example               |
| ------------- | ------------------- | --------------------- |
| Exit Success  | `exit 0`            | `exit 0`              |
| Exit Fail     | `exit 1`            | `exit 1`              |
| Last Status   | `$?`                | `echo $?`             |
| Exit on Error | `set -e`            | `set -e`              |
| Unset Error   | `set -u`            | `set -u`              |
| Pipe Fail     | `set -o pipefail`   | `set -o pipefail`     |
| Strict Mode   | `set -euo pipefail` | `set -euo pipefail`   |
| Debug         | `set -x`            | `bash -x script.sh`   |
| Trap Exit     | `trap 'cmd' EXIT`   | `trap 'cleanup' EXIT` |

---
