# Bash Shell Scripting Master Cheat Sheet

Practical Bash reference for Linux administration, DevOps work, interviews, labs, and classroom revision.

This improved edition merges the detailed explanations and compact tables from both supplied cheat sheets while removing duplication and correcting unsafe or incomplete patterns.

> Most examples assume Bash. Features such as `[[ ]]`, arrays, `=~`, and `(( ))` are not guaranteed to work in plain POSIX `sh`.

---

## Table of contents

1. [Ultra-quick reference](#1-ultra-quick-reference)
2. [Script setup and execution](#2-script-setup-and-execution)
3. [Comments, output, and variables](#3-comments-output-and-variables)
4. [Quoting and parameter expansion](#4-quoting-and-parameter-expansion)
5. [User input and positional arguments](#5-user-input-and-positional-arguments)
6. [Command substitution and arithmetic](#6-command-substitution-and-arithmetic)
7. [Operators and conditionals](#7-operators-and-conditionals)
8. [Loops](#8-loops)
9. [Functions](#9-functions)
10. [Arrays](#10-arrays)
11. [Redirection, pipelines, and input blocks](#11-redirection-pipelines-and-input-blocks)
12. [Text-processing commands](#12-text-processing-commands)
13. [Useful Linux and DevOps patterns](#13-useful-linux-and-devops-patterns)
14. [Error handling, debugging, and cleanup](#14-error-handling-debugging-and-cleanup)
15. [Common mistakes and safer alternatives](#15-common-mistakes-and-safer-alternatives)
16. [Script template](#16-script-template)
17. [Final revision checklist](#17-final-revision-checklist)

---

## 1. Ultra-quick reference

| Topic | Syntax | Example |
|---|---|---|
| Shebang | `#!/bin/bash` | First line of a Bash script |
| Syntax check | `bash -n FILE` | `bash -n backup.sh` |
| Run file | `bash FILE` | `bash backup.sh` |
| Run command text | `bash -c 'COMMANDS'` | `bash -c 'name="Ali"; echo "$name"'` |
| Debug execution | `bash -x FILE` | `bash -x backup.sh` |
| Variable | `name="value"` | `environment="testing"` |
| Read variable | `"$name"` | `echo "$environment"` |
| Default value | `${var:-default}` | `${APP_ENV:-development}` |
| User input | `read -r -p` | `read -r -p "Name: " name` |
| First argument | `$1` | `file="$1"` |
| Argument count | `$#` | `[[ "$#" -eq 2 ]]` |
| All arguments | `"$@"` | `for arg in "$@"; do ...` |
| Command output | `$(command)` | `today="$(date +%F)"` |
| Arithmetic | `$((expression))` | `total=$((a + b))` |
| Conditional | `if ...; then ... fi` | `if [[ -f "$file" ]]; then` |
| Loop | `for ...; do ... done` | `for file in *.log; do` |
| Function | `name() { ...; }` | `greet() { echo "Hello"; }` |
| Pipeline | `command1 \| command2` | `sort names.txt \| uniq` |
| Standard error | `>&2` | `echo "Error" >&2` |
| Exit status | `$?` | `status=$?` |
| Strict options | `set -Eeuo pipefail` | Use after understanding the caveats |
| Cleanup | `trap` | `trap 'rm -f "$temp_file"' EXIT` |

---

## 2. Script setup and execution

### Shebang

Common fixed path:

```bash
#!/bin/bash
```

Find Bash through the current `PATH`:

```bash
#!/usr/bin/env bash
```

Use `#!/bin/bash` when that path is known and required. Use `#!/usr/bin/env bash` when portability across systems with different Bash locations matters.

### Make a script executable

```bash
chmod u+x script.sh
./script.sh
```

### Run without execute permission

```bash
bash script.sh
```

`bash script.sh` starts Bash and asks it to read the file. `./script.sh` asks the operating system to execute the file using its shebang.

### Check syntax without execution

```bash
bash -n script.sh
echo "$?"
```

No output normally means the syntax is valid. `bash -n` does not verify runtime behavior or logic.

### Execute commands supplied as text

```bash
bash -c 'name="Ali"; echo "Hello, $name"'
```

Use single quotes so the new Bash process—not the current shell—expands `$name`.

Check command-string syntax without execution:

```bash
bash -n -c 'if [[ "$name" == "Ali" ]]; then echo "Hello"; fi'
```

### Arguments with `bash -c`

The first word after the command string becomes `$0`; later words become `$1`, `$2`, and so on:

```bash
bash -c 'echo "Name: $0"; echo "Fruit: $1"' Ali apple
```

Output:

```text
Name: Ali
Fruit: apple
```

### Trace execution

```bash
bash -x script.sh
```

Do not trace scripts while real passwords, tokens, or sensitive values may appear.

---

## 3. Comments, output, and variables

### Comments

```bash
# Full-line comment
echo "Hello"  # Inline comment
```

The shebang begins with `#!` but is not an ordinary comment to the operating system.

### Output with `echo`

```bash
echo "Hello"
echo "User: $USER"
echo
```

### Variable assignment

Correct:

```bash
name="Khalid"
city="Chicago"
count=5
```

Incorrect:

```bash
name = "Khalid"
```

There must be no spaces around `=`.

### Variable naming rules

Valid:

```bash
name="Ali"
student_name="Omar"
server2="web02"
APP_ENV="testing"
```

Invalid:

```bash
2server="web02"
student-name="Omar"
student name="Ali"
```

Guidelines:

- Use meaningful names.
- Use lowercase for ordinary script variables.
- Use uppercase for exported settings or constants.
- Avoid overwriting important names such as `PATH`, `HOME`, `SHELL`, `USER`, and `IFS`.

### Read a value

```bash
echo "$name"
```

Use braces when text follows immediately:

```bash
fruit="apple"
echo "${fruit}s"
```

### Read-only variables

```bash
readonly MAX_RETRIES=3
declare -r COMPANY="NIT"
```

### Remove a variable

```bash
unset temporary_value
```

### Shell versus environment variables

Shell variable:

```bash
course="Bash"
```

Exported environment variable:

```bash
export APP_ENV="testing"
```

Child processes inherit exported variables:

```bash
bash -c 'echo "$APP_ENV"'
```

Set a value for one command only:

```bash
APP_ENV="production" bash app.sh
```

Inspect environment variables:

```bash
env
printenv APP_ENV
export -p
```

---

## 4. Quoting and parameter expansion

### Quoting rules

| Form | Behavior | Example |
|---|---|---|
| Double quotes | Expand variables and command substitutions while preserving spaces | `echo "$name"` |
| Single quotes | Treat everything literally | `echo '$name'` |
| No quotes | Allow word splitting and pathname expansion | Avoid for most variable expansions |
| Backslash | Protect the next character | `echo "\$HOME"` |

Preferred habit:

```bash
cp -- "$source_file" "$destination_file"
```

### Default and required values

| Expansion | Meaning |
|---|---|
| `${var:-default}` | Use default when unset or empty |
| `${var:=default}` | Assign default when unset or empty |
| `${var:?message}` | Stop with an error when unset or empty |
| `${var:+alternate}` | Use alternate when set and non-empty |

Examples:

```bash
environment="${APP_ENV:-development}"
: "${CONFIG_FILE:?CONFIG_FILE is required}"
```

The colon in `:-`, `:=`, `:?`, and `:+` makes empty values count as missing. Without the colon, only an unset variable counts as missing.

### String length

```bash
username="khalid"
echo "${#username}"
```

### Substring

```bash
text="production-server"
echo "${text:0:10}"
```

### Remove matching prefixes and suffixes

| Expansion | Meaning |
|---|---|
| `${var#pattern}` | Remove shortest prefix match |
| `${var##pattern}` | Remove longest prefix match |
| `${var%pattern}` | Remove shortest suffix match |
| `${var%%pattern}` | Remove longest suffix match |

Filename example:

```bash
path="/var/log/app.log"
filename="${path##*/}"
base_name="${filename%.*}"
extension="${filename##*.}"
```

### Replace text

```bash
text="dev-server-dev"
echo "${text/dev/prod}"      # First match
echo "${text//dev/prod}"     # All matches
```

### Change letter case

```bash
environment="Production"
echo "${environment,,}"
echo "${environment^^}"
```

### Check whether a variable is set

```bash
if [[ -v APP_ENV ]]; then
    echo "APP_ENV is set."
fi
```

---

## 5. User input and positional arguments

### Read input safely

```bash
read -r -p "Enter your name: " name
echo "Hello, $name"
```

| Option | Meaning |
|---|---|
| `-r` | Preserve backslashes |
| `-p` | Display a prompt |
| `-s` | Do not display typed input |
| `-n 1` | Read one character |
| `-t 10` | Stop waiting after 10 seconds |

Hidden practice input:

```bash
read -r -s -p "Password: " password
echo
echo "Password received."
unset password
```

Do not print or hardcode real secrets.

### Positional parameters

| Parameter | Meaning |
|---|---|
| `$0` | Script name or invocation |
| `$1` to `$9` | First through ninth arguments |
| `${10}` | Tenth argument |
| `$#` | Number of arguments |
| `"$@"` | All arguments preserved separately |
| `"$*"` | All arguments joined as one string when quoted |

Example:

```bash
echo "Script: $0"
echo "First argument: $1"
echo "Argument count: $#"
```

### Validate argument count

```bash
if [[ "$#" -ne 2 ]]; then
    echo "Usage: $0 SOURCE DESTINATION" >&2
    exit 1
fi
```

### Process every argument safely

```bash
for argument in "$@"; do
    echo "$argument"
done
```

### Shift arguments

```bash
first="$1"
shift
echo "Removed: $first"
echo "Remaining: $*"
```

### Special Bash parameters

| Parameter | Meaning |
|---|---|
| `$?` | Exit status of the previous command |
| `$$` | Current shell process ID |
| `$!` | Process ID of the latest background command |
| `$-` | Current shell option flags |

Capture `$?` immediately:

```bash
some_command
status=$?
echo "Status: $status"
```

---

## 6. Command substitution and arithmetic

### Command substitution

```bash
current_user="$(whoami)"
today="$(date +%F)"
hostname_value="$(hostname)"
```

Prefer `$(command)` over legacy backticks because it is easier to read and nest.

### Arithmetic expansion

```bash
apples=5
bananas=3
total=$((apples + bananas))
echo "$total"
```

| Operator | Meaning |
|---|---|
| `+` | Addition |
| `-` | Subtraction |
| `*` | Multiplication |
| `/` | Integer division |
| `%` | Remainder |
| `**` | Exponentiation |

### Arithmetic command

```bash
count=0
((count += 1))
```

Be careful with `set -e`: arithmetic commands return status based on whether the expression evaluates to zero. Assignment expansion is sometimes clearer:

```bash
count=$((count + 1))
```

---

## 7. Operators and conditionals

### Basic structure

```bash
if [[ condition ]]; then
    command
elif [[ another_condition ]]; then
    another_command
else
    fallback_command
fi
```

Bash treats exit status `0` as true/success and non-zero as false/failure.

### String tests

| Test | Meaning |
|---|---|
| `[[ "$a" == "$b" ]]` | Equal |
| `[[ "$a" != "$b" ]]` | Not equal |
| `[[ -z "$a" ]]` | Empty |
| `[[ -n "$a" ]]` | Not empty |
| `[[ "$file" == *.log ]]` | Pattern match |
| `[[ "$value" =~ regex ]]` | Regular-expression match |

Pattern example:

```bash
if [[ "$filename" == *.log ]]; then
    echo "Log filename accepted."
fi
```

Regex example:

```bash
if [[ "$username" =~ ^[a-z][a-z0-9_-]*$ ]]; then
    echo "Username format accepted."
fi
```

Do not quote the entire regular expression on the right side of `=~`.

### Numeric tests

| Operator | Meaning |
|---|---|
| `-eq` | Equal |
| `-ne` | Not equal |
| `-gt` | Greater than |
| `-ge` | Greater than or equal |
| `-lt` | Less than |
| `-le` | Less than or equal |

```bash
if [[ "$count" -ge 10 ]]; then
    echo "Count is at least ten."
fi
```

Arithmetic form:

```bash
if (( count >= 10 )); then
    echo "Count is at least ten."
fi
```

Validate numeric input first:

```bash
if [[ "$age" =~ ^[0-9]+$ ]]; then
    echo "Numeric input accepted."
else
    echo "Error: enter digits only." >&2
    exit 1
fi
```

### File tests

| Test | Meaning |
|---|---|
| `-e` | Path exists |
| `-f` | Regular file |
| `-d` | Directory |
| `-s` | File exists and is not empty |
| `-r` | Readable |
| `-w` | Writable |
| `-x` | Executable |
| `-L` | Symbolic link |

```bash
if [[ -f "$config_file" && -r "$config_file" && -s "$config_file" ]]; then
    echo "Configuration is readable and non-empty."
else
    echo "Configuration validation failed." >&2
    exit 1
fi
```

### Logical operators

| Operator | Meaning |
|---|---|
| `&&` | Both conditions must be true |
| `\|\|` | At least one condition must be true |
| `!` | Reverse the result |

```bash
if [[ ( "$role" == "admin" || "$role" == "operator" ) &&
      "$active" == "yes" ]]; then
    echo "Access allowed."
fi
```

### Use a command directly as a condition

```bash
if grep -q "ERROR" app.log; then
    echo "Errors were found."
else
    echo "No errors were found."
fi
```

### Short-circuit command lists

```bash
mkdir -p "$directory" && echo "Directory is ready."
cd "$directory" || exit 1
```

Use a full `if` block when the logic needs multiple commands or clearer error handling.

### `case` statement

```bash
case "$1" in
    start)
        echo "Starting"
        ;;
    stop)
        echo "Stopping"
        ;;
    restart)
        echo "Restarting"
        ;;
    *)
        echo "Usage: $0 {start|stop|restart}" >&2
        exit 1
        ;;
esac
```

---

## 8. Loops

### Loop summary

| Loop | Best use |
|---|---|
| `for item in ...` | Known list of values |
| `for ((...))` | Numeric counter |
| `while condition` | Repeat while condition remains true |
| `until condition` | Repeat until condition becomes true |
| `while IFS= read -r` | Read a file safely line by line |

### List-based `for`

```bash
for fruit in apple banana cherry; do
    echo "$fruit"
done
```

### Brace expansion

```bash
for number in {1..5}; do
    echo "$number"
done
```

### C-style counter

```bash
for ((index = 0; index < 5; index++)); do
    echo "Index: $index"
done
```

### `while`

```bash
count=1

while (( count <= 3 )); do
    echo "Count: $count"
    count=$((count + 1))
done
```

### `until`

```bash
count=1

until (( count > 3 )); do
    echo "Count: $count"
    count=$((count + 1))
done
```

### `break` and `continue`

```bash
for number in {1..5}; do
    if [[ "$number" -eq 3 ]]; then
        continue
    fi

    if [[ "$number" -eq 5 ]]; then
        break
    fi

    echo "$number"
done
```

### Loop over matching files

```bash
shopt -s nullglob

for log_file in ./*.log; do
    echo "Processing: $log_file"
done
```

`nullglob` prevents an unmatched `*.log` pattern from being processed literally.

### Read a file line by line

```bash
while IFS= read -r line || [[ -n "$line" ]]; do
    echo "$line"
done < file.txt
```

The extra condition processes a final line that does not end with a newline.

### Pipeline subshell warning

In many Bash configurations, a loop fed by a pipeline runs in a subshell:

```bash
count=0

command | while IFS= read -r line; do
    count=$((count + 1))
done

echo "$count"
```

The final value may still be `0`. Prefer process substitution when the changed variable is needed afterward:

```bash
count=0

while IFS= read -r line; do
    count=$((count + 1))
done < <(command)

echo "$count"
```

---

## 9. Functions

### Define and call

```bash
greet() {
    echo "Hello"
}

greet
```

### Function arguments

```bash
show_file() {
    local file="${1:-}"
    echo "File: $file"
}

show_file "/etc/passwd"
```

Inside a function, `$1`, `$2`, `$#`, and `"$@"` refer to the function arguments.

### Local variables

```bash
check_environment() {
    local environment="${1:-development}"
    echo "$environment"
}
```

### Return status

```bash
check_file() {
    local file="${1:-}"

    if [[ -f "$file" ]]; then
        return 0
    fi

    return 1
}

if check_file "/etc/passwd"; then
    echo "File exists."
fi
```

`return` accepts a status from `0` through `255`. It does not return arbitrary text.

### Return data through output

```bash
multiply() {
    local first="$1"
    local second="$2"
    echo $((first * second))
}

result="$(multiply 4 5)"
echo "$result"
```

Keep diagnostic messages on `stderr` when a function's standard output is captured as data.

---

## 10. Arrays

### Indexed array

```bash
fruits=(apple banana cherry)
```

| Expansion | Meaning |
|---|---|
| `${fruits[0]}` | First element |
| `${fruits[@]}` | All elements |
| `${#fruits[@]}` | Number of elements |
| `${!fruits[@]}` | All indexes |

```bash
echo "${fruits[0]}"

for fruit in "${fruits[@]}"; do
    echo "$fruit"
done
```

Add and remove:

```bash
fruits+=(mango)
unset 'fruits[1]'
```

### Associative array

```bash
declare -A ports=(
    [http]=80
    [https]=443
    [ssh]=22
)

echo "${ports[https]}"
```

Iterate safely:

```bash
for service in "${!ports[@]}"; do
    echo "$service: ${ports[$service]}"
done
```

---

## 11. Redirection, pipelines, and input blocks

### Standard streams

| Stream | File descriptor |
|---|---|
| Standard input | `0` |
| Standard output | `1` |
| Standard error | `2` |

### Redirection table

| Syntax | Meaning |
|---|---|
| `> file` | Send stdout to file; overwrite |
| `>> file` | Append stdout |
| `2> file` | Send stderr to file; overwrite |
| `2>> file` | Append stderr |
| `> file 2>&1` | Send stdout and stderr to the same file |
| `&> file` | Bash shortcut for stdout and stderr |
| `< file` | Read stdin from file |
| `>/dev/null` | Discard stdout |
| `2>/dev/null` | Discard stderr |

Examples:

```bash
command > output.log
command 2> error.log
command > combined.log 2>&1
```

Order matters:

```bash
command > combined.log 2>&1
```

This redirects stdout first, then points stderr to the same destination.

### Send a message to stderr

```bash
echo "Error: configuration is missing." >&2
```

### Pipelines

```bash
grep "ERROR" app.log | sort | uniq -c
```

By default, a pipeline's status is usually the last command's status.

```bash
set -o pipefail
```

With `pipefail`, the pipeline fails if any component fails.

Inspect all pipeline statuses:

```bash
command1 | command2 | command3
echo "${PIPESTATUS[*]}"
```

### Here document

```bash
cat <<'EOF'
This is literal text.
$HOME is not expanded because EOF is quoted.
EOF
```

Expandable form:

```bash
name="Ali"

cat <<EOF
Hello, $name
EOF
```

### Here string

```bash
read -r first_word rest <<< "apple banana cherry"
echo "$first_word"
```

### Process substitution

```bash
diff <(sort file1.txt) <(sort file2.txt)
```

---

## 12. Text-processing commands

### Master table

| Command | Purpose | Example |
|---|---|---|
| `grep` | Search lines | `grep -n "ERROR" app.log` |
| `awk` | Process fields and records | `awk -F: '{print $1}' /etc/passwd` |
| `sed` | Transform text streams | `sed 's/dev/prod/g' config.txt` |
| `cut` | Extract fields or characters | `cut -d: -f1 /etc/passwd` |
| `sort` | Sort lines | `sort -u names.txt` |
| `uniq` | Process adjacent duplicates | `sort names.txt \| uniq -c` |
| `tr` | Translate or delete characters | `tr 'a-z' 'A-Z'` |
| `wc` | Count lines, words, or bytes | `wc -l app.log` |
| `head` | Show first lines | `head -n 20 file.txt` |
| `tail` | Show last lines or follow | `tail -f app.log` |
| `find` | Search filesystem entries | `find . -type f -name '*.log'` |
| `xargs` | Build command arguments | `xargs -0` with null-delimited input |
| `jq` | Process JSON | `jq -r '.name' file.json` |

### `grep`

```bash
grep "ERROR" app.log
grep -i "error" app.log
grep -n "ERROR" app.log
grep -c "ERROR" app.log
grep -v "DEBUG" app.log
grep -E "ERROR|FAIL" app.log
grep -r "TODO" .
```

Quiet condition:

```bash
if grep -q "ERROR" app.log; then
    echo "Error found."
fi
```

### `awk`

```bash
awk '{print $1}' file.txt
awk -F: '{print $1}' /etc/passwd
awk 'NR > 1 {print $1, $3}' data.csv
awk '$5 + 0 > 80 {print}' disk.txt
```

### `sed`

Preview replacement:

```bash
sed 's/localhost/127.0.0.1/g' config.txt
```

GNU `sed` in-place edit with backup:

```bash
sed -i.bak 's/localhost/127.0.0.1/g' config.txt
```

Review the backup and result before removing anything. In-place syntax can differ across operating systems.

### `cut`

```bash
cut -d: -f1 /etc/passwd
cut -d, -f2 data.csv
cut -c1-10 file.txt
```

### `sort` and `uniq`

```bash
sort names.txt
sort -n numbers.txt
sort -nr numbers.txt
sort -u names.txt
sort names.txt | uniq -c | sort -nr
```

`uniq` only combines adjacent duplicate lines, so sort first when duplicates may be separated.

### `tr`

```bash
echo "hello world" | tr 'a-z' 'A-Z'
tr -d '\r' < windows-file.txt
tr ' ' '_' < names.txt
```

### `wc`, `head`, and `tail`

```bash
wc -l app.log
wc -w notes.txt
head -n 20 notes.txt
tail -n 50 app.log
tail -f app.log
```

### Null-safe filenames

```bash
find . -type f -name '*.log' -print0 |
    while IFS= read -r -d '' file; do
        echo "$file"
    done
```

For commands that support it:

```bash
find . -type f -name '*.conf' -print0 |
    xargs -0 -r grep -l "localhost"
```

---

## 13. Useful Linux and DevOps patterns

### Check whether a command exists

```bash
if ! command -v docker >/dev/null 2>&1; then
    echo "Error: docker command is not installed." >&2
    exit 1
fi
```

### Check a process

```bash
if pgrep -x nginx >/dev/null; then
    echo "nginx process is running."
else
    echo "nginx process is not running."
fi
```

### Check a systemd service

```bash
if systemctl is-active --quiet nginx; then
    echo "nginx is active."
else
    echo "nginx is not active."
fi
```

### Disk-usage check

```bash
usage="$(df -P / | awk 'NR == 2 {gsub("%", "", $5); print $5}')"

if [[ "$usage" =~ ^[0-9]+$ ]] && (( usage >= 80 )); then
    echo "Warning: disk usage is ${usage}%." >&2
fi
```

### Inspect top memory-consuming processes

```bash
ps aux --sort=-%mem | head -n 11
```

The first line is the header.

### Find large files in a chosen directory

```bash
find /var/log -type f -size +100M -print 2>/dev/null
```

Avoid scanning `/` unless the broad scope is genuinely required.

### Preview old log files

Always preview first:

```bash
find ./logs -type f -name '*.log' -mtime +7 -print
```

Only after carefully reviewing the exact directory and matches:

```bash
find ./logs -type f -name '*.log' -mtime +7 -delete
```

### Count lines across matching logs

```bash
find ./logs -type f -name '*.log' -exec wc -l {} +
```

Total content lines:

```bash
find ./logs -type f -name '*.log' -exec cat {} + | wc -l
```

### Parse JSON

```bash
jq -r '.name' file.json
jq -r '.user.email' file.json
```

Check that `jq` exists before relying on it.

### Follow errors in a log

```bash
tail -f app.log | grep --line-buffered "ERROR"
```

Stop with `Ctrl+C`.

### Limited retry

```bash
attempt=1
max_attempts=5

until some_command; do
    if (( attempt >= max_attempts )); then
        echo "Error: command failed after $max_attempts attempts." >&2
        exit 1
    fi

    echo "Attempt $attempt failed; retrying..." >&2
    attempt=$((attempt + 1))
    sleep 2
done
```

Always set a limit; do not retry forever.

### Timestamped log name

```bash
application="inventory-api"
timestamp="$(date +%Y%m%d-%H%M%S)"
log_file="${application}-${timestamp}.log"
```

### Safe preflight flow

```text
Input → Validate → Check current state → Perform action → Verify result
```

Do not print success before the command has actually succeeded.

---

## 14. Error handling, debugging, and cleanup

### Exit statuses

| Status | General meaning |
|---|---|
| `0` | Success |
| `1` | General failure |
| `2` | Commonly used for incorrect usage or shell syntax errors |
| `126` | Found but cannot execute |
| `127` | Command not found |
| `128 + signal` | Process ended by a signal |

Use the meaning required by the command or project; not every program uses statuses identically.

```bash
if [[ ! -f "$config_file" ]]; then
    echo "Error: configuration is missing." >&2
    exit 1
fi
```

If a script reaches its end without an explicit `exit`, its status is normally the status of the last command executed.

### Strict options

```bash
set -Eeuo pipefail
```

| Option | Meaning |
|---|---|
| `-e` | Exit in many unhandled failure contexts |
| `-E` | Inherit `ERR` traps in more contexts |
| `-u` | Error on unset variables |
| `pipefail` | Pipeline fails when any component fails |

Strict mode helps expose mistakes but has important context-dependent behavior. It does not replace explicit validation and error messages.

Safe optional variable with `set -u`:

```bash
echo "${OPTIONAL_VALUE:-not-set}"
```

### Debug tracing

```bash
set -x
some_command
set +x
```

Never enable tracing around secrets.

### Syntax and static analysis

```bash
bash -n script.sh
```

When ShellCheck is installed:

```bash
shellcheck script.sh
```

### Temporary files

```bash
temp_file="$(mktemp)"
trap 'rm -f -- "$temp_file"' EXIT
```

Temporary directory:

```bash
temp_directory="$(mktemp -d)"
trap 'rm -rf -- "$temp_directory"' EXIT
```

Only delete a path created and stored by the same script. Never use an unvalidated or empty variable as a recursive deletion target.

### Signal handling

```bash
trap 'echo "Interrupted" >&2; exit 130' INT
trap 'echo "Termination requested" >&2; exit 143' TERM
```

### Error trap

```bash
trap 'echo "Error on line $LINENO" >&2' ERR
```

Test trap behavior carefully, especially with `set -e`, functions, subshells, and pipelines.

### Simple logging

```bash
log_file="./script.log"
timestamp="$(date +%Y-%m-%dT%H:%M:%S)"
echo "$timestamp | INFO | Script started" >> "$log_file"
```

---

## 15. Common mistakes and safer alternatives

| Risky or incorrect | Safer or correct |
|---|---|
| `name = "Ali"` | `name="Ali"` |
| `echo $name` | `echo "$name"` |
| `read -p "Name: " name` | `read -r -p "Name: " name` |
| `for arg in $@` | `for arg in "$@"` |
| `if [["$a" == "$b"]]; then` | `if [[ "$a" == "$b" ]]; then` |
| `[[ "$age" > 18 ]]` for numbers | `(( age > 18 ))` or `[[ "$age" -gt 18 ]]` |
| Regex right side fully quoted | Keep the `=~` regex unquoted |
| Check `$?` after another command | Capture it immediately |
| `for file in $(find ...)` | Use `find -print0` with null-safe reading |
| `cat file \| grep pattern` | `grep pattern file` |
| Blind `sed -i` | Preview first and create a backup |
| Immediate `find ... -delete` | Run the same command with `-print` first |
| Unlimited retry loop | Use a maximum-attempt counter |
| `source` an untrusted `.env` file | Parse and validate approved keys |
| Hardcode or print secrets | Use an appropriate secret system and avoid tracing |
| Print success before action | Check the command status first |
| Run every script with `sudo` | Use least privilege; elevate only the required command |
| Assume `bash -n` proves correctness | Test valid, invalid, empty, missing, and boundary cases |

### Unsafe variable deletion example

Do not do this with an unvalidated variable:

```bash
rm -rf "$target"
```

Validate that the target is non-empty, expected, specific, and within an approved directory before any destructive action. Prefer recoverable operations when possible.

---

## 16. Script template

```bash
#!/bin/bash

set -Eeuo pipefail

# Title: Safe local file report
# Purpose: Validate one file and display basic information
# Usage: ./file_report.sh FILE

if [[ "$#" -ne 1 ]]; then
    echo "Usage: $0 FILE" >&2
    exit 2
fi

file="$1"

if [[ ! -e "$file" ]]; then
    echo "Error: path does not exist: $file" >&2
    exit 1
elif [[ ! -f "$file" ]]; then
    echo "Error: path is not a regular file: $file" >&2
    exit 1
elif [[ ! -r "$file" ]]; then
    echo "Error: file is not readable: $file" >&2
    exit 1
fi

size="$(wc -c < "$file")"

echo "File: $file"
echo "Size: $size bytes"
echo "Status: validation passed"
```

Validate and test:

```bash
bash -n file_report.sh
shellcheck file_report.sh
bash file_report.sh /etc/passwd
bash file_report.sh missing.txt
echo "$?"
```

`shellcheck` is optional and must be installed separately.

---

## 17. Final revision checklist

### Before running

- [ ] Correct Bash shebang
- [ ] Comments explain purpose and usage
- [ ] No spaces around variable assignment
- [ ] Variable expansions are quoted
- [ ] Arguments are counted before use
- [ ] User input uses `read -r`
- [ ] Required commands and files are validated
- [ ] No real secrets are hardcoded
- [ ] `bash -n` passes
- [ ] ShellCheck findings are reviewed when available

### During execution

- [ ] Errors go to `stderr`
- [ ] Exit statuses are meaningful
- [ ] Pipelines use `pipefail` when appropriate
- [ ] Retries have a limit
- [ ] Temporary files have cleanup traps
- [ ] Debug mode does not reveal secrets
- [ ] Success is printed only after verification

### Testing

- [ ] Valid input
- [ ] Empty input
- [ ] Missing arguments
- [ ] Invalid values
- [ ] Boundary numbers
- [ ] Missing files
- [ ] Empty files
- [ ] Permission failures
- [ ] Failed commands
- [ ] Interrupted execution

---

Prepared as a merged and improved Bash Shell Scripting reference.
