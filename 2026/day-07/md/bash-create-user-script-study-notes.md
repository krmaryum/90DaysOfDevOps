# Bash Script Study Notes: Create a Linux User

## Topic

Create a Linux user using a Bash script.

---

## Script Goal

The goal of this script is to create a new Linux user account safely.

Before creating the user, the script first checks whether the username already exists on the system.

---

## Description

This Bash script creates a new Linux user account.

The script follows this workflow:

```text
Ask for username -> Check if user exists -> Create user if not found -> Show result
```

It uses the `id` command to check whether the user already exists.

If the user already exists, the script prints a message and stops.

If the user does not exist, the script creates the user using:

```bash
sudo useradd -m username
```

The `-m` option creates a home directory for the new user.

Example:

```bash
sudo useradd -m ali
```

This creates:

```text
User: ali
Home directory: /home/ali
```

---

## Disclaimer

This script makes real changes to the Linux system by creating a new user account.

Use this script carefully.

Important safety points:

- Run this script only if you understand what it does.
- You may need `sudo` or root privileges.
- Test this script first in a lab environment, virtual machine, WSL, or practice server.
- Do not run this script blindly on a production server.
- Always review scripts before executing them.

---

## Before Scripting: How to Think

Before writing the Bash script, think about the logic in plain English first.

```text
I need a script that creates a Linux user.

First, I will ask the user to enter a username.

Then I will check whether that username already exists using the id command.

If the user already exists, I will print a message and stop the script.

If the user does not exist, I will create the user using sudo useradd -m.

After that, I will print whether the user was created successfully or not.
```

This is the professional way to write scripts:

```text
Think logic first
Write steps in English
Convert steps into Bash commands
Test the script
Improve error handling
```

---

## Script Flow

```text
START
  |
  v
Ask for username
  |
  v
Check user with: id "$username"
  |
  v
Does user exist?
  |
  |--- YES ---> Print "User already exists"
  |              Exit script
  |
  |--- NO ----> Run sudo useradd -m "$username"
                  |
                  v
              Was user created?
                  |
                  |--- YES ---> Print "User created successfully"
                  |
                  |--- NO ----> Print "Failed to create user"
  |
  v
END
```

---

## Complete Script

```bash
#!/bin/bash

########################################################################
# Script Name: create-user.sh
#
# Description:
# This script creates a new Linux user account.
# It first asks the person running the script to enter a username.
# Then it checks whether that username already exists on the system
# using the `id` command.
#
# If the user already exists, the script prints a message and stops.
# If the user does not exist, the script creates the user using:
#
#   sudo useradd -m username
#
# The `-m` option creates a home directory for the new user.
#
# Disclaimer:
# This script makes changes to the Linux system by creating a new user.
# Run this script only if you understand what it does.
# You may need sudo/root privileges to create users.
# Always test scripts in a safe lab environment before using them
# on a production server.
########################################################################

create_user() {
    read -p "Enter the username to create: " username

    if id "$username" &>/dev/null; then
        echo "User '$username' already exists."
        exit 1
    fi

    if sudo useradd -m "$username"; then
        echo "User '$username' was created successfully."
    else
        echo "Failed to create user '$username'."
    fi
}

create_user
```

---

## Step-by-Step Explanation

### 1. Shebang

```bash
#!/bin/bash
```

This tells Linux to run the script using Bash.

---

### 2. Function Declaration

```bash
create_user() {
```

This creates a function named `create_user`.

A function is a reusable block of code.

The code inside this function will not run until the function is called.

---

### 3. Read Username from User

```bash
read -p "Enter the username to create: " username
```

This asks the person running the script to enter a username.

The entered value is stored in the variable named `username`.

Example:

```text
Enter the username to create: ali
```

Now:

```bash
username="ali"
```

---

### 4. Check If User Already Exists

```bash
if id "$username" &>/dev/null; then
```

The `id` command checks if the user exists.

Example:

```bash
id ali
```

If the user exists, the command succeeds.

If the user does not exist, the command fails.

---

### 5. Hide Command Output

```bash
&>/dev/null
```

This hides both normal output and error output.

Without this, the terminal may show extra messages.

With this, the script stays clean and only shows our custom messages.

---

### 6. If User Already Exists

```bash
echo "User '$username' already exists."
exit 1
```

If the user already exists, the script prints a message and stops.

`exit 1` means the script ended with an error or failure condition.

---

### 7. Create the User

```bash
sudo useradd -m "$username"
```

This command creates a new Linux user.

The `-m` option creates the user's home directory.

Example:

```bash
sudo useradd -m ali
```

This creates:

```text
/home/ali
```

---

### 8. Success Message

```bash
echo "User '$username' was created successfully."
```

If the `useradd` command works, this message is printed.

---

### 9. Failure Message

```bash
echo "Failed to create user '$username'."
```

If the `useradd` command fails, this message is printed.

Possible reasons for failure:

- The script was not run with sudo privileges.
- The username is invalid.
- The system has permission issues.
- The user already exists but the check failed for some reason.

---

### 10. Function Call

```bash
create_user
```

This line runs the function.

Without this line, the function is only defined but never executed.

---

## Important Commands Used

| Command | Purpose |
|---|---|
| `read -p` | Takes input from the user |
| `id "$username"` | Checks if the user exists |
| `&>/dev/null` | Hides output and errors |
| `exit 1` | Stops the script with failure status |
| `sudo useradd -m "$username"` | Creates a new user with home directory |
| `if command; then` | Runs logic based on command success or failure |

---

## Why We Quote Variables

In the script, we use:

```bash
"$username"
```

instead of:

```bash
$username
```

Quoting variables is safer.

It prevents problems if the value contains spaces or special characters.

Best practice:

```bash
id "$username"
sudo useradd -m "$username"
```

---

## How to Run the Script

### Step 1: Create the Script File

```bash
nano create-user.sh
```

Paste the script inside the file.

---

### Step 2: Give Execute Permission

```bash
chmod +x create-user.sh
```

---

### Step 3: Run the Script

```bash
./create-user.sh
```

If needed, run with sudo:

```bash
sudo ./create-user.sh
```

---

## How to Verify the User Was Created

Use the `id` command:

```bash
id username
```

Example:

```bash
id ali
```

You can also check the home directory:

```bash
ls -ld /home/ali
```

---

## Expected Output

### If User Does Not Exist

```text
Enter the username to create: ali
User 'ali' was created successfully.
```

### If User Already Exists

```text
Enter the username to create: ali
User 'ali' already exists.
```

### If User Creation Fails

```text
Enter the username to create: ali
Failed to create user 'ali'.
```

---

## Real Workflow

```text
Input -> Check -> Decision -> Action -> Result
```

### Input

Ask the user for username.

### Check

Use `id "$username"` to check if the user exists.

### Decision

If user exists, stop the script.

If user does not exist, continue.

### Action

Create user with `sudo useradd -m "$username"`.

### Result

Print success or failure message.

---

## Lab Task

Create a script named:

```bash
create-user.sh
```

Requirements:

1. Ask for a username.
2. Check if the user already exists.
3. If the user exists, print a message and stop.
4. If the user does not exist, create the user.
5. Print success or failure message.
6. Verify the user using the `id` command.

---

## Practice Questions

1. What is the purpose of `#!/bin/bash`?
2. Why do we use `read -p`?
3. What does the `id` command do?
4. Why do we use `&>/dev/null`?
5. What does `exit 1` mean?
6. What does `useradd -m` do?
7. Why should we quote variables like `"$username"`?
8. Why do we call the function at the end?
9. What happens if the user already exists?
10. How can we verify that a user was created?

---

## Final Summary

In this script, I learned how to create a Linux user using Bash scripting.

I learned how to take input from the user using `read -p`.

I learned how to check if a user already exists using the `id` command.

I learned how to hide command output using `&>/dev/null`.

I learned how to create a user with a home directory using `sudo useradd -m`.

I also learned how to organize script logic inside a function and call the function at the end.

The main workflow is:

```text
Ask username -> Check user -> Create user -> Show result
```
