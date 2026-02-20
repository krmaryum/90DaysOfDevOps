
## Task 1: Basics

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

## Task 3 LOOPS:
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
## Task 4 