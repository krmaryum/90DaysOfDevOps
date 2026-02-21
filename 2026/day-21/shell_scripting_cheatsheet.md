# 📚 Table of Contents

- [Task 1: Basics](#task-1-basics)
- [Task 2: Operators and Conditionals](#task-2-operators-and-conditionals)
- [Task 3: Loops](#task-3-loops)
- [Task 4: Functions](#task-4-functions)
- [Task 5: Text Processing Commands](#task-5-text-processing-commands)
- [Task 6: Useful Patterns and One-Liners](#task-6-useful-patterns-and-one-liners)
- [Task 7: Error Handling and Debugging](#task-7-error-handling-and-debugging)

# Shell Scripting Quick Reference

| Topic      | Key Syntax | Example |
|------------|------------|---------|
| Variable   | `VAR="value"` | `NAME="DevOps"` |
| Argument   | `$1`, `$2` | `./script.sh arg1` |
| If         | `if [ condition ]; then` | `if [ -f file ]; then` |
| For loop   | `for i in list; do` | `for i in 1 2 3; do` |
| Function   | `name() { ... }` | `greet() { echo "Hi"; }` |
| Grep       | `grep pattern file` | `grep -i "error" log.txt` |
| Awk        | `awk '{print $1}' file` | `awk -F: '{print $1}' /etc/passwd` |
| Sed        | `sed 's/old/new/g' file` | `sed -i 's/foo/bar/g' config.txt` |
| While loop | `while condition; do` | `while read line; do` |
| Case       | `case $var in` | `case "$1" in start)` |
| Exit code  | `exit N` | `exit 1` |
| Debug      | `set -x` | `bash -x script.sh` |
| Strict mode| `set -euo pipefail` | `set -euo pipefail` |

---



## Task 1: Basics
### Basics — Quick Reference Table

| Topic | Key Syntax | Example |
|-------|------------|---------|
| Shebang | `#!/bin/bash` | `#!/bin/bash` |
| Make Executable | `chmod +x file.sh` | `chmod +x script.sh` |
| Run Script | `./script.sh` | `./script.sh` |
| Run with Bash | `bash script.sh` | `bash script.sh` |
| Comment | `# comment` | `# This is a comment` |
| Inline Comment | `command # comment` | `echo "Hi" # greeting` |
| Variable | `VAR="value"` | `name="bhai"` |
| Use Variable | `$VAR` | `echo "$name"` |
| Single Quotes | `'text'` | `echo '$name'` |
| Read Input | `read var` | `read username` |
| Read with Prompt | `read -p "msg" var` | `read -p "Name: " user` |
| Script Name | `$0` | `echo "$0"` |
| First Argument | `$1` | `./script.sh file.txt` |
| Argument Count | `$#` | `echo "$#"` |
| All Arguments | `"$@"` | `for arg in "$@"; do` |
| Exit Status | `$?` | `echo "$?"` |

---

### Shebang (#!/bin/bash)

Defines which interpreter should run the script.

```bash
#!/bin/bash
```
Without it, the script may run with the wrong shell.

---

### Running a Script

Make executable:
```bash
chmod +x script.sh
```
Run directly:
```bash
./script.sh
```
Run with bash explicitly:
```bash
bash script.sh
```

---

### Comments
Single-line comment:
```bash
# This is a comment
```
Inline comment:
```bash
echo "Hello"  # Print greeting
```
---

### Variables
Declare variable (no spaces):
```bash
name="khalid"
```
Use variable:
```bash
echo $name
```
Always prefer quoting:
```bash
echo "$name"
```
Single quotes prevent expansion:
```bash
echo '$name'   # Prints literally: $name
```
---

Reading User Input

Basic read:
```bash
read username
```
Prompt while reading:
```bash
read -p "Enter your name: " username
```
Read password silently:
```bash
read -sp "Password: " pass; echo
```

---

### Command-Line Arguments
```bash
echo "$0"   # Script name
echo "$1"   # First argument
echo "$#"   # Number of arguments
echo "$@"   # All arguments (safe for loops)
echo "$?"   # Exit status of last command
```
Examples:
```bash
./script.sh file.txt

echo "Script: $0"
echo "File: $1"
```
Loop through arguments safely:
```bash
for arg in "$@"; do
  echo "$arg"
done
```

## Task 2: Operators and Conditionals
### Operators and Conditionals — Quick Reference Table

| Topic | Key Syntax | Example |
|-------|------------|---------|
| String Equal | `[[ "$a" = "$b" ]]` | `[[ "$env" = "prod" ]]` |
| String Not Equal | `[[ "$a" != "$b" ]]` | `[[ "$user" != "root" ]]` |
| Empty String | `[[ -z "$var" ]]` | `[[ -z "$name" ]]` |
| Not Empty | `[[ -n "$var" ]]` | `[[ -n "$name" ]]` |
| Equal (int) | `-eq` | `[[ "$a" -eq 5 ]]` |
| Not Equal (int) | `-ne` | `[[ "$a" -ne 5 ]]` |
| Less Than | `-lt` | `[[ "$a" -lt 10 ]]` |
| Greater Than | `-gt` | `[[ "$a" -gt 10 ]]` |
| Less or Equal | `-le` | `[[ "$a" -le 10 ]]` |
| Greater or Equal | `-ge` | `[[ "$a" -ge 10 ]]` |
| File Exists | `-e` | `[[ -e file.txt ]]` |
| Regular File | `-f` | `[[ -f file.txt ]]` |
| Directory | `-d` | `[[ -d /etc ]]` |
| Readable | `-r` | `[[ -r file.txt ]]` |
| Writable | `-w` | `[[ -w file.txt ]]` |
| Executable | `-x` | `[[ -x script.sh ]]` |
| Not Empty File | `-s` | `[[ -s file.txt ]]` |
| If Statement | `if ...; then` | `if [[ -f file ]]; then` |
| Else If | `elif` | `elif [[ "$env" = "dev" ]]; then` |
| Else | `else` | `else echo "Unknown"` |
| Logical AND | `&&` | `[[ -f file ]] && echo "Exists"` |
| Logical OR | `||` | `[[ -f file ]] || echo "Missing"` |
| Logical NOT | `!` | `if ! [[ -f file ]]; then` |
| Case Statement | `case var in` | `case "$1" in start)` |

---

### String Comparisons

Use `[[ ... ]]` for safer Bash comparisons.

Equal / Not equal:

```bash
if [[ "$a" = "$b" ]]; then echo "Equal"; fi
if [[ "$a" != "$b" ]]; then echo "Not equal"; fi
```
Empty / Not empty:
```bash
[[ -z "$var" ]] && echo "Empty"
[[ -n "$var" ]] && echo "Not empty"
```
---

Integer Comparisons
```bash
[[ "$a" -eq "$b" ]]  # equal
[[ "$a" -ne "$b" ]]  # not equal
[[ "$a" -lt "$b" ]]  # less than
[[ "$a" -gt "$b" ]]  # greater than
[[ "$a" -le "$b" ]]  # less or equal
[[ "$a" -ge "$b" ]]  # greater or equal
```
Example:
```bash
if [[ "$count" -gt 10 ]]; then
  echo "Count is greater than 10"
fi
```
---

File Test Operators
```bash
[[ -f file.txt ]]   # regular file exists
[[ -d dir/ ]]       # directory exists
[[ -e path ]]       # file or directory exists
[[ -r file ]]       # readable
[[ -w file ]]       # writable
[[ -x file ]]       # executable
[[ -s file ]]       # not empty
```
Example:
```bash
if [[ -f "$config" && -s "$config" ]]; then
  echo "Config file exists and is not empty"
fi
```
---

if / elif / else Syntax
```bash
if [[ "$env" = "prod" ]]; then
  echo "Production"
elif [[ "$env" = "dev" ]]; then
  echo "Development"
else
  echo "Unknown environment"
fi
```
---

### Logical Operators

AND (&&) — run next if previous succeeds:
```bash
[[ -f file.txt ]] && echo "File exists"
```
OR (||) — run next if previous fails:
```bash
[[ -f file.txt ]] || echo "File missing"
```
NOT (!) — negate condition:
```bash
if ! [[ -f file.txt ]]; then
  echo "File not found"
fi
```
Combine conditions:
```bash
if [[ -f file.txt && -r file.txt ]]; then
  echo "File exists and is readable"
fi
```
---

### Case Statement
Clean alternative to multiple `if` statements.
```bash
case "$1" in
  start)
    echo "Starting service"
    ;;
  stop)
    echo "Stopping service"
    ;;
  restart)
    echo "Restarting service"
    ;;
  *)
    echo "Usage: $0 {start|stop|restart}"
    ;;
esac
```

---


## Task 3: Loops
### Loops — Quick Reference Table

| Topic | Key Syntax | Example |
|-------|------------|---------|
| For (List) | `for i in list; do` | `for i in 1 2 3; do` |
| For (Range) | `{1..5}` | `for i in {1..5}; do` |
| For (C-Style) | `for ((i=0; i<n; i++)); do` | `for ((i=0; i<5; i++)); do` |
| While Loop | `while condition; do` | `while [[ "$x" -lt 5 ]]; do` |
| Until Loop | `until condition; do` | `until [[ "$x" -gt 5 ]]; do` |
| Break | `break` | `[[ "$i" -eq 3 ]] && break` |
| Continue | `continue` | `[[ "$i" -eq 3 ]] && continue` |
| Loop Files | `for f in *.log; do` | `for f in *.log; do echo "$f"; done` |
| Read File Line-by-Line | `while read line; do` | `while read line; do echo "$line"; done < file.txt` |
| Loop Command Output | `command | while read` | `ps aux | while read line; do` |

---

### for Loop (List-Based)

Iterate over a list of values.

```bash
for item in apple banana mango; do
  echo "$item"
done
```
Using brace expansion:
```bash
for i in {1..5}; do
  echo "$i"
done
```
---

### for Loop (C-Style)
Useful for counters and numeric logic.
```bash
for ((i=0; i<5; i++)); do
  echo "Index: $i"
done
```
---

### while Loop
Runs while condition is true.
```bash
count=1
while [[ "$count" -le 3 ]]; do
  echo "Count: $count"
  ((count++))
done
```
---

### until Loop
Runs until condition becomes true (opposite of while).
```bash
count=1
until [[ "$count" -gt 3 ]]; do
  echo "Count: $count"
  ((count++))
done
```
Common real-world pattern (wait for service):
```bash
until ping -c1 8.8.8.8 &>/dev/null; do
  sleep 2
done
```
---
### Loop Control
break — exit loop early:
```bash
for i in {1..5}; do
  [[ "$i" -eq 3 ]] && break
  echo "$i"
done
```
continue — skip current iteration:
```bash
for i in {1..5}; do
  [[ "$i" -eq 3 ]] && continue
  echo "$i"
done
```
---

### Looping Over Files
Iterate over matching files:
```bash
for file in *.log; do
  echo "Processing $file"
done
```
Safer globbing (avoid literal *.log):
```bash
shopt -s nullglob
for file in *.log; do
  echo "$file"
done
```
---

### Looping Over Command Output
Preferred safe pattern:
```bash
while IFS= read -r line; do
  echo "Line: $line"
done < file.txt
```
From command output:
```bash
command | while IFS= read -r line; do
  echo "$line"
done
```
Example with ps:
```bash
ps aux | while IFS= read -r line; do
  echo "$line"
done
```
## Task 4: Functions
### Functions — Quick Reference Table

| Topic | Key Syntax | Example |
|-------|------------|---------|
| Define Function | `name() { ... }` | `greet() { echo "Hi"; }` |
| Call Function | `name` | `greet` |
| Function Argument | `$1`, `$2` | `add() { echo $(( $1 + $2 )); }` |
| Return Status | `return N` | `return 0` |
| Capture Exit Code | `$?` | `check_file; echo $?` |
| Return Data | `echo value` | `result=$(multiply 2 3)` |
| Local Variable | `local var="value"` | `local temp="inside"` |
| Multiple Args | `"$@"` | `for arg in "$@"; do` |

---

### Defining a Function

Basic syntax:

```bash
greet() {
  echo "Hello!"
}
```
Functions group reusable logic into blocks.
### Calling a Function
Just use its name:
```bash
greet
```
Example:
```bash
log() {
  echo "[INFO] $1"
}

log "Server started"
```
---

### Passing Arguments to Functions
Arguments are accessed using $1, $2, etc.
```bash
add() {
  echo $(( $1 + $2 ))
}

add 3 5
```
Example with multiple args:
```bash
deploy() {
  echo "Deploying to environment: $1"
}

deploy prod
```
---

### Return Values — return vs echo
`return` sets exit status (0–255 only):
```bash
check() {
  [[ -f "$1" ]] && return 0 || return 1
}

check file.txt
echo $?   # prints function exit status
```
`echo` returns actual data:
```bash
multiply() {
  echo $(( $1 * $2 ))
}

result="$(multiply 4 5)"
echo "$result"
```
Use `return` for status, `echo` for data.

---

### Local Variables
Use `local` to limit variable scope inside function.
```bash
example() {
  local temp="inside"
  echo "$temp"
}

example
```
Prevents variable conflicts with global scope.

---

## Task 5 Text Processing Commands
### Text Processing — Quick Reference Table

| Command | Key Syntax | Example |
|---------|------------|---------|
| grep | `grep pattern file` | `grep -i "error" app.log` |
| grep (recursive) | `grep -r pattern dir` | `grep -r "TODO" .` |
| grep (count) | `grep -c pattern file` | `grep -c "error" app.log` |
| awk | `awk '{print $1}' file` | `awk '{print $1,$3}' file.txt` |
| awk (delimiter) | `-F` | `awk -F: '{print $1}' /etc/passwd` |
| awk (pattern) | `/pattern/ {action}` | `awk '/error/ {print $1}' app.log` |
| sed (replace) | `sed 's/old/new/g' file` | `sed -i 's/foo/bar/g' config.txt` |
| sed (delete) | `sed '/pattern/d' file` | `sed '/error/d' app.log` |
| cut (delimiter) | `cut -d: -f1 file` | `cut -d, -f2 data.csv` |
| cut (chars) | `cut -c1-5 file` | `cut -c1-10 file.txt` |
| sort | `sort file` | `sort names.txt` |
| sort (numeric) | `sort -n file` | `sort -n numbers.txt` |
| sort (reverse) | `sort -r file` | `sort -nr numbers.txt` |
| uniq | `uniq file` | `sort file.txt | uniq` |
| uniq (count) | `uniq -c` | `sort file.txt | uniq -c` |
| tr | `tr 'a-z' 'A-Z'` | `tr ' ' '_' < file.txt` |
| wc | `wc -l file` | `wc -l app.log` |
| head | `head -n N file` | `head -n 20 file.txt` |
| tail | `tail -n N file` | `tail -n 50 app.log` |
| tail (follow) | `tail -f file` | `tail -f app.log` |

---

### grep — Search Patterns

Basic search:

```bash
grep "error" app.log
```
Common flags:

```bash
grep -i "error" file.txt     # case-insensitive
grep -r "TODO" .             # recursive search
grep -c "error" file.txt     # count matches
grep -n "error" file.txt     # show line numbers
grep -v "debug" file.txt     # invert match
grep -E "error|fail" file.txt # extended regex
```
---

### awk — Pattern Scanning & Columns
Print columns:
```bash
awk '{print $1}' file.txt
awk '{print $1, $3}' file.txt
```
Set field separator:
```bash
awk -F: '{print $1}' /etc/passwd
awk -F, '{print $2}' data.csv
```
Pattern matching:
```bash
awk '/error/ {print $1}' app.log
```
---

### sed — Stream Editor
Substitute text:
```bash
sed 's/old/new/' file.txt
sed 's/old/new/g' file.txt   # global replace
```
Delete lines:
```bash
sed '2d' file.txt            # delete line 2
sed '/error/d' file.txt      # delete lines matching pattern
```
In-place edit:
```bash
sed -i 's/old/new/g' file.txt
```
---
### cut — Extract Columns
By delimiter:
```bash
cut -d: -f1 /etc/passwd
cut -d, -f2 data.csv
```
By character position:
```bash
cut -c1-5 file.txt
```
---

### sort — Sort Lines
Alphabetical (default):
```bash
sort file.txt
```
Numerical:
```bash
sort -n numbers.txt
```
Reverse:
```bash
sort -r file.txt
```
Unique sort:
```bash
sort -u file.txt
```
---

### uniq — Remove Duplicates
Remove consecutive duplicates:
```bash
uniq file.txt
```
Count occurrences:
```bash
uniq -c file.txt
```
Common pattern:
```bash
sort file.txt | uniq -c | sort -nr
```
---

### tr — Translate / Delete Characters
Lowercase to uppercase:
```bash
tr 'a-z' 'A-Z' < file.txt
```
Delete characters:
```bash
tr -d '\r' < file.txt
```
Replace spaces with underscores:
```bash
echo "hello world" | tr ' ' '_'
```
---

### wc — Count Lines / Words / Characters
```bash
wc file.txt          # lines, words, bytes
wc -l file.txt       # lines only
wc -w file.txt       # words only
wc -c file.txt       # bytes/characters
```
---

### head / tail — View File Portions
First 10 lines (default):
```bash
head file.txt
```
First N lines:
```bash
head -n 20 file.txt
```
Last 10 lines:
```bash
tail file.txt
```
Follow log file (live):
```bash
tail -f app.log
```
Last N lines:
```bash
tail -n 50 app.log
```
## Task 6: Useful Patterns and One-Liners
### Useful Patterns & One-Liners — Quick Reference Table

| Task | Key Syntax | Example |
|------|------------|---------|
| Delete old files | `find -mtime +N -delete` | `find /var/log -name "*.log" -mtime +7 -delete` |
| Preview old files | `find -mtime +N -print` | `find . -mtime +30 -print` |
| Count lines in logs | `cat *.log \| wc -l` | `cat *.log \| wc -l` |
| Replace in many files | `sed -i 's/old/new/g'` | `sed -i 's/foo/bar/g' *.conf` |
| Recursive replace | `grep -rl pattern \| xargs sed -i` | `grep -rl "localhost" . \| xargs sed -i 's/localhost/127.0.0.1/g'` |
| Check service running | `pgrep name` | `pgrep -x nginx` |
| Check service (systemd) | `systemctl is-active` | `systemctl is-active nginx` |
| Disk usage alert | `df -h \| awk` | `df -h \| awk '$5+0 > 80 {print}'` |
| Parse CSV | `awk -F,` | `awk -F, '{print $2}' data.csv` |
| Parse JSON | `jq` | `jq '.name' file.json` |
| Tail & filter errors | `tail -f \| grep` | `tail -f app.log \| grep --line-buffered ERROR` |
| Retry command | `for loop + break` | `for i in {1..5}; do curl ... && break; done` |
| Check command exists | `command -v` | `command -v docker || exit 1` |
| Find large files | `find -size +N` | `find / -size +100M` |

---
---

### Find and Delete Files Older Than N Days

Delete `.log` files older than 7 days:

```bash
find /var/log -type f -name "*.log" -mtime +7 -delete
```
---
### Count Lines in All .log Files
Total lines across all `.log` files:
```bash
cat *.log | wc -l
```
Safer version (handles many files):
```bash
find . -name "*.log" -exec cat {} + | wc -l
```
---
### Replace a String Across Multiple Files
Replace `localhost` with `127.0.0.1` in all .conf files:
```bash
sed -i 's/localhost/127.0.0.1/g' *.conf
```
Recursive replace:
```bash
grep -rl "localhost" . | xargs sed -i 's/localhost/127.0.0.1/g'
```
---
### Check If a Service Is Running
Using `pgrep`:
```bash
pgrep -x nginx >/dev/null && echo "Running" || echo "Stopped"
```
Using systemctl:
```bash
systemctl is-active --quiet nginx && echo "Active"
```
---

### Monitor Disk Usage with Alert
Alert if disk usage > 80%:
```bash
df -h | awk '$5+0 > 80 {print "High usage:", $0}'
```
Script-style check:
```bash
usage=$(df / | awk 'NR==2 {print $5}' | tr -d '%')
[[ "$usage" -gt 80 ]] && echo "Disk usage critical: $usage%"
```
---

### Parse CSV from Command Line
Print second column from CSV:
```bash
awk -F, '{print $2}' data.csv
```
Skip header row:
```bash
awk -F, 'NR>1 {print $1, $3}' data.csv
```
---

### Parse JSON from Command Line (jq)
Extract field:
```bash
jq '.name' file.json
```
Extract nested value:
```bash
jq '.user.email' file.json
```
From API response:
```bash
curl -s https://api.example.com | jq '.status'
```
---

### Tail Log and Filter Errors in Real Time
Show only ERROR lines:
```bash
tail -f app.log | grep --line-buffered "ERROR"
```
Case-insensitive filter:
```bash
tail -f app.log | grep -i --line-buffered "fail"
```
---

### Retry Command Until Success
Retry up to 5 times:
```bash
for i in {1..5}; do
  curl -fsS https://example.com && break
  sleep 2
done
```
---

### Check If Command Exists
Ensure required tool is installed:
```bash
command -v docker >/dev/null || { echo "Docker not installed"; exit 1; }
```
---
### Top 10 Memory-Consuming Processes
```bash
ps aux --sort=-%mem | head -10
```
---
### Find Large Files (>100MB)
```bash
find / -type f -size +100M 2>/dev/null
```
---

## Task 7: Error Handling and Debugging
### Error Handling & Debugging — Quick Reference Table

| Topic | Key Syntax | Example |
|-------|------------|---------|
| Exit Success | `exit 0` | `exit 0` |
| Exit Failure | `exit 1` | `exit 1` |
| Last Exit Code | `$?` | `echo "$?"` |
| Exit on Error | `set -e` | `set -e` |
| Unset Variable Error | `set -u` | `set -u` |
| Pipe Failure Detection | `set -o pipefail` | `set -o pipefail` |
| Strict Mode | `set -euo pipefail` | `set -euo pipefail` |
| Debug Mode | `set -x` | `bash -x script.sh` |
| Disable Debug | `set +x` | `set +x` |
| Trap on Exit | `trap 'cmd' EXIT` | `trap 'cleanup' EXIT` |
| Trap Ctrl+C | `trap 'cmd' INT` | `trap 'echo "Stopped"' INT` |
| Cleanup Temp File | `trap 'rm -f "$tmp"' EXIT` | `tmp=$(mktemp)` |

---

### Exit Codes

Every command returns an exit status.

```bash
echo $?
```
`0`= success

Non-zero = failure

Manually exit:
```bash
exit 0   # success
exit 1   # generic error
```
Example:
```bash
if [[ ! -f config.txt ]]; then
  echo "Config missing"
  exit 1
fi
```
---
### set -e — Exit on Error
Exit immediately if a command fails.
```bash
set -e
```
Example:
```bash
set -e
cp file.txt /backup/
echo "Copy successful"
```
If `cp` fails, script stops immediately.
---

### set -u — Error on Unset Variables
Treat undefined variables as errors.
```bash
set -u
```
Example:
```bash
set -u
echo "$username"
```
If `username` is not defined, script exits.
---

### set -o pipefail — Catch Errors in Pipes
Fail if any command in a pipeline fails.

Without pipefail:
```bash
false | true   # exits with success
```
With pipefail:
```bash
set -o pipefail
false | true   # now fails
```
Recommended strict mode:
```bash
set -euo pipefail
```
---

### set -x — Debug Mode (Trace Execution)
Print each command before executing it.
```bash
set -x
```
Disable debug mode
```bash
set +x
```
Run script with debug:
```bash
bash -x script.sh
```
Useful for troubleshooting variable values and flow.
---

### trap — Cleanup on Exit or Signal
Run cleanup code when script exits.
```bash
cleanup() {
  rm -f /tmp/tempfile
}

trap cleanup EXIT
```
Handle Ctrl+C (SIGINT):
```bash
trap 'echo "Interrupted"; exit 130' INT
```

Example with temp file:
```bash
tmp=$(mktemp)
trap 'rm -f "$tmp"' EXIT
```
