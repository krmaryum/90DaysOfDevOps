## Topic

**Checking Required Commands in a Shell Script**

This note explains the main testing block used in a shell script for GitHub Actions CI.

The goal of this block is to check whether important Linux commands are available on the runner machine. If any required command is missing, the script exits with a non-zero exit code, and the GitHub Actions pipeline fails.

---

## Code Block

```bash
 echo "Checking required commands..."

required_commands=("bash" "git" "hostname" "df")

for command in "${required_commands[@]}"
do
  if command -v "$command" >/dev/null 2>&1; then
    echo "$command is installed"
  else
    echo "Error: $command is not installed" >&2
    exit 1
  fi
done

echo
echo "All required commands are available"
echo "System health check completed successfully"
```

---

## Step 1: Print Starting Message

```bash
echo "Checking required commands..."
```

This line prints a message on the screen.

### Output

```text
Checking required commands...
```

### Meaning

The script is telling the user or GitHub Actions log that it is now checking required commands.

---

## Step 2: Create an Array of Required Commands

```bash
required_commands=("bash" "git" "hostname" "df")
```

This creates a Bash array named:

```bash
required_commands
```

The array contains these command names:

```text
bash
git
hostname
df
```

### Simple Meaning

These are the commands that the script needs. The script will check if all of them are installed.

---

## Important: Bash Array Syntax

In Bash arrays, we use **spaces**, not commas.

### Correct

```bash
required_commands=("bash" "git" "hostname" "df")
```

### Incorrect

```bash
required_commands=("bash", "git", "hostname", "df")
```

In Bash, commas become part of the value. So `"bash",` is not the same as `"bash"`.

---

## Step 3: Start the Loop

```bash
for command in "${required_commands[@]}"
do
```

This loop goes through each item in the array one by one.

This part:

```bash
"${required_commands[@]}"
```

means:

```text
All items inside the required_commands array
```

### Loop Example

The loop runs like this:

```text
First round  : command=bash
Second round : command=git
Third round  : command=hostname
Fourth round : command=df
```

The variable `command` temporarily stores one command name at a time.

---

## Step 4: Check If a Command Exists

```bash
if command -v "$command" >/dev/null 2>&1; then
```

This line checks whether the command exists on the system.

---

## What Does `command -v` Mean?

```bash
command -v git
```

This checks whether `git` is installed and available in the system path.

If the command exists, it may return something like:

```text
/usr/bin/git
```

If the command does not exist, the check fails.

---

## Why Use `"$command"`?

```bash
"$command"
```

This uses the current value stored in the `command` variable.

For example, when the loop is checking `git`, this line becomes:

```bash
command -v "git"
```

When the loop is checking `df`, it becomes:

```bash
command -v "df"
```

Quotes are a good habit in Bash because they protect values from spacing issues.

---

## Step 5: Hide Command Output

```bash
>/dev/null 2>&1
```

This part hides the output of `command -v`.

Normally, `command -v git` may print:

```text
/usr/bin/git
```

But in this script, we do not need to show the path. We only need to know whether the command exists or not.

---

## Meaning of `>/dev/null`

```bash
>/dev/null
```

This hides normal output.

`/dev/null` is like a black hole in Linux. Anything sent there disappears.

---

## Meaning of `2>&1`

```bash
2>&1
```

This sends error output to the same place as normal output.

Since normal output is already going to `/dev/null`, error output also gets hidden.

### Simple Meaning

```text
Check silently. Do not print output from command -v.
```

---

## Step 6: If Command Is Installed

```bash
then
  echo "$command is installed"
```

If the command exists, this message prints.

### Example Output

```text
bash is installed
git is installed
hostname is installed
df is installed
```

---

## Step 7: If Command Is Not Installed

```bash
else
  echo "Error: $command is not installed" >&2
  exit 1
fi
```

This block runs if the command is missing.

### Example Output

```text
Error: git is not installed
```

---

## Meaning of `>&2`

```bash
>&2
```

This sends the message to standard error.

Error messages should go to `stderr`, not normal output.

### Simple Meaning

```text
Print this as an error message.
```

---

## Step 8: Exit With Failure

```bash
exit 1
```

This stops the script immediately and marks it as failed.

This is very important in GitHub Actions.

### Exit Code Meaning

| Exit Code | Meaning | CI Result |
|---|---|---|
| `exit 0` | Success | Pipeline green |
| `exit 1` | Failure | Pipeline red |

If any required command is missing, the script exits with `1`, and GitHub Actions marks the job as failed.

---

## Step 9: End the Loop

```bash
done
```

This ends the `for` loop.

The loop continues until all commands are checked or until one command is missing.

---

## Step 10: Print Success Messages

```bash
echo
echo "All required commands are available"
echo "System health check completed successfully"
```

The first `echo` prints a blank line.

Then the script prints success messages.

These messages only appear if all required commands are installed.

### Output

```text
All required commands are available
System health check completed successfully
```

---

## Full Flow

```text
1. Print checking message.
2. Store required commands in a Bash array.
3. Loop through each command one by one.
4. Use command -v to check if the command exists.
5. If the command exists, print installed message.
6. If the command is missing, print error and exit with code 1.
7. If all commands exist, print success message.
```

---

## Successful Example

```text
Checking required commands...
bash is installed
git is installed
hostname is installed
df is installed

All required commands are available
System health check completed successfully
```

This means the script completed successfully.

In GitHub Actions, the pipeline will be green.

---

## Failure Example

If you intentionally break the script like this:

```bash
required_commands=("bash" "git" "hostname" "df" "fakecommand123")
```

Then the output may look like this:

```text
Checking required commands...
bash is installed
git is installed
hostname is installed
df is installed
Error: fakecommand123 is not installed
```

The script will stop because of:

```bash
exit 1
```

In GitHub Actions, the pipeline will become red.

---

## Why This Is Useful in CI

This block is useful because it proves that the runner has the required tools before continuing.

In a real DevOps pipeline, this type of test can help confirm that required tools are installed before build, test, or deployment steps run.

---

## Key Concepts Learned

| Concept | Meaning |
|---|---|
| Bash array | Stores multiple values in one variable |
| `for` loop | Repeats commands for each item |
| `command -v` | Checks whether a command exists |
| `/dev/null` | Hides output |
| `2>&1` | Sends errors to the same place as normal output |
| `>&2` | Prints message as an error |
| `exit 1` | Stops script with failure |
| CI pipeline red | Script failed |
| CI pipeline green | Script passed |

---

## Final Summary

This script block checks required Linux commands before continuing. If all commands exist, the script prints a success message. If any command is missing, the script prints an error and exits with `exit 1`.

This is exactly how GitHub Actions understands whether a script passed or failed.

```text
Script exits with 0      = success
Script exits with non-zero = failure
```
