# Day 43 – Task 4: Conditionals in GitHub Actions

## Topic

GitHub Actions conditionals allow you to control **when a job or step should run**.

In this task, we created a workflow that demonstrates:

1. A step that runs only on the `main` branch
2. A step that fails intentionally
3. A step that runs only when a previous step failed
4. A job that runs only on `push` events
5. A step with `continue-on-error: true`

---

## Complete Workflow File

File path:

```text
.github/workflows/conditionals.yml
```

Workflow code:

```yaml
name: Conditionals Workflow

on:
  push:
    branches:
      - main

  pull_request:
    branches:
      - main

  workflow_dispatch:

jobs:
  conditional-steps:
    runs-on: ubuntu-latest

    steps:
      - name: Print branch information
        run: |
          echo "Branch ref is: ${{ github.ref }}"
          echo "Event name is: ${{ github.event_name }}"

      - name: Run only on main branch
        if: github.ref == 'refs/heads/main'
        run: echo "This step runs only on the main branch"

      - name: This step will fail but workflow continues
        continue-on-error: true
        run: |
          echo "This step is intentionally failing"
          exit 1

      - name: Run only if previous step failed
        if: failure()
        run: echo "A previous step failed, so this step is running"

      - name: Final step
        run: echo "Workflow continued after failure because continue-on-error was true"

  push-only-job:
    runs-on: ubuntu-latest
    if: github.event_name == 'push'

    steps:
      - name: This job runs only on push events
        run: |
          echo "This job runs only when event is push"
          echo "Current event is: ${{ github.event_name }}"
```

---

# Block-by-Block Explanation

## 1. Workflow Name

```yaml
name: Conditionals Workflow
```

This is the name of the workflow.

This name appears in the **GitHub Actions** tab.

You will see it as:

```text
Conditionals Workflow
```

---

## 2. Workflow Triggers

```yaml
on:
  push:
    branches:
      - main

  pull_request:
    branches:
      - main

  workflow_dispatch:
```

This block tells GitHub **when the workflow should run**.

This workflow has three triggers:

1. `push`
2. `pull_request`
3. `workflow_dispatch`

---

## 3. Push Trigger

```yaml
push:
  branches:
    - main
```

This means the workflow will run automatically when code is pushed to the `main` branch.

Example:

```bash
git push
```

If your current branch is `main`, this push will trigger the workflow.

---

## 4. Pull Request Trigger

```yaml
pull_request:
  branches:
    - main
```

This means the workflow will also run when a pull request targets the `main` branch.

Example:

```text
feature branch → pull request → main
```

This is useful because teams often run checks before merging code into the main branch.

---

## 5. Manual Trigger

```yaml
workflow_dispatch:
```

This allows you to run the workflow manually from GitHub.

Steps:

```text
GitHub repository → Actions tab → Select workflow → Run workflow
```

This is helpful when you want to test a workflow without pushing new code.

---

# Jobs Section

```yaml
jobs:
```

This section defines the work that GitHub Actions will perform.

In this workflow, there are two jobs:

```text
1. conditional-steps
2. push-only-job
```

---

# Job 1: conditional-steps

```yaml
conditional-steps:
```

This is the first job.

The purpose of this job is to demonstrate different **step-level conditions**.

---

## Runner for Job 1

```yaml
runs-on: ubuntu-latest
```

This tells GitHub to run the job on an Ubuntu Linux runner.

A runner is the temporary machine where GitHub Actions executes commands.

---

## Steps Section

```yaml
steps:
```

This starts the list of steps inside the job.

Steps run one by one from top to bottom.

---

# Step 1: Print Branch Information

```yaml
- name: Print branch information
  run: |
    echo "Branch ref is: ${{ github.ref }}"
    echo "Event name is: ${{ github.event_name }}"
```

This step prints two important GitHub Actions context values.

---

## What is `github.ref`?

```yaml
${{ github.ref }}
```

This shows the full Git reference that triggered the workflow.

If the workflow runs on the `main` branch, the output may look like:

```text
refs/heads/main
```

So this command:

```bash
echo "Branch ref is: ${{ github.ref }}"
```

may print:

```text
Branch ref is: refs/heads/main
```

---

## What is `github.event_name`?

```yaml
${{ github.event_name }}
```

This shows the event that triggered the workflow.

Possible values are:

```text
push
pull_request
workflow_dispatch
```

So this command:

```bash
echo "Event name is: ${{ github.event_name }}"
```

may print:

```text
Event name is: push
```

---

# Step 2: Run Only on Main Branch

```yaml
- name: Run only on main branch
  if: github.ref == 'refs/heads/main'
  run: echo "This step runs only on the main branch"
```

This step uses an `if` condition.

The condition is:

```yaml
if: github.ref == 'refs/heads/main'
```

Meaning:

```text
Run this step only if the current branch is main.
```

If the branch is `main`, the step runs.

If the branch is not `main`, the step is skipped.

Important point:

```text
refs/heads/main
```

is the full reference name for the `main` branch.

---

# Step 3: Fail Intentionally but Continue

```yaml
- name: This step will fail but workflow continues
  continue-on-error: true
  run: |
    echo "This step is intentionally failing"
    exit 1
```

This step is intentionally designed to fail.

---

## What does `continue-on-error: true` do?

```yaml
continue-on-error: true
```

This tells GitHub Actions:

```text
Even if this step fails, continue running the next steps.
```

Normally, if a step fails, the job stops.

But with `continue-on-error: true`, the workflow continues.

---

## What does `exit 1` mean?

```bash
exit 1
```

In Linux:

```text
exit 0 = success
exit 1 = failure
```

So this command forces the step to fail.

The workflow continues because the step has:

```yaml
continue-on-error: true
```

---

# Step 4: Run Only if Previous Step Failed

```yaml
- name: Run only if previous step failed
  if: failure()
  run: echo "A previous step failed, so this step is running"
```

This step uses the condition:

```yaml
if: failure()
```

Meaning:

```text
Run this step only if a previous step failed.
```

Because the previous step used:

```bash
exit 1
```

this step is meant to run after a failure.

Important note:

When `continue-on-error: true` is used, GitHub may allow the job to continue even though the step failed. This is useful for learning how workflows behave after failures.

---

# Step 5: Final Step

```yaml
- name: Final step
  run: echo "Workflow continued after failure because continue-on-error was true"
```

This is the final step of the first job.

It prints a message confirming that the workflow continued after the intentional failure.

This proves the effect of:

```yaml
continue-on-error: true
```

---

# Job 2: push-only-job

```yaml
push-only-job:
```

This is the second job.

The purpose of this job is to run only when the event is `push`.

---

## Runner for Job 2

```yaml
runs-on: ubuntu-latest
```

This job also runs on an Ubuntu Linux runner.

---

## Job-Level Condition

```yaml
if: github.event_name == 'push'
```

This is a **job-level condition**.

It means:

```text
Run this entire job only if the workflow event is push.
```

So this job will run for:

```text
push
```

It will be skipped for:

```text
pull_request
workflow_dispatch
```

---

## Difference Between Step-Level and Job-Level `if`

### Step-level `if`

```yaml
- name: Run only on main branch
  if: github.ref == 'refs/heads/main'
```

This controls only one step.

### Job-level `if`

```yaml
push-only-job:
  if: github.event_name == 'push'
```

This controls the entire job.

If the condition is false, the whole job is skipped.

---

# Step inside push-only-job

```yaml
steps:
  - name: This job runs only on push events
    run: |
      echo "This job runs only when event is push"
      echo "Current event is: ${{ github.event_name }}"
```

This step prints a message showing that the job is running because the event is `push`.

If the workflow was triggered by a push, output will be:

```text
This job runs only when event is push
Current event is: push
```

---

# Full Workflow Flow

```text
Workflow starts
        |
        v
Check trigger:
push / pull_request / workflow_dispatch
        |
        v
Job 1: conditional-steps
        |
        | Print branch and event information
        | Run step only if branch is main
        | Fail one step intentionally
        | Continue because continue-on-error is true
        | Run failure condition step if failure is detected
        | Run final step
        v
Job 2: push-only-job
        |
        | Runs only if event is push
        v
Workflow ends
```

---

# Commands to Create and Push the Workflow

## 1. Create the workflow file

```bash
mkdir -p .github/workflows
nano .github/workflows/conditionals.yml
```

Paste the workflow code into the file.

Save and exit:

```text
CTRL + O → Enter → CTRL + X
```

---

## 2. Check Git status

```bash
git status
```

You should see the new workflow file.

---

## 3. Add the file

```bash
git add .github/workflows/conditionals.yml
```

---

## 4. Commit the file

```bash
git commit -m "Add conditionals workflow"
```

---

## 5. Push to GitHub

```bash
git push
```

Because the workflow runs on push to `main`, pushing this file should trigger the workflow.

---

# How to Verify in GitHub

1. Open your GitHub repository
2. Click the **Actions** tab
3. Select **Conditionals Workflow**
4. Open the latest workflow run
5. Check the jobs and steps

You should see:

```text
conditional-steps
push-only-job
```

If the event was `push`, the `push-only-job` should run.

If the event was `pull_request` or `workflow_dispatch`, the `push-only-job` should be skipped.

---

# Important Lines to Remember

## Run step only on main branch

```yaml
if: github.ref == 'refs/heads/main'
```

## Continue workflow even after failure

```yaml
continue-on-error: true
```

## Force a step to fail

```bash
exit 1
```

## Run step only if a previous step failed

```yaml
if: failure()
```

## Run job only on push event

```yaml
if: github.event_name == 'push'
```

---

# Simple Summary

This workflow teaches how to control jobs and steps using conditions.

It runs on:

```text
push to main
pull request to main
manual workflow_dispatch
```

It demonstrates:

```text
1. Branch-based step condition
2. Failure handling
3. continue-on-error
4. failure() condition
5. Event-based job condition
```

---

# Final Notes

## Why use conditionals in GitHub Actions?

Conditionals are useful when you do not want every job or step to run all the time.

For example:

```text
Run deployment only on main branch
Run tests on pull requests
Run cleanup only if a previous step failed
Run production job only on push events
```

## What does `continue-on-error: true` do?

It allows the workflow to continue even if that step fails.

This is useful when a step is not critical, or when you want to test failure handling.

## What does `needs` do?

This workflow does not use `needs`, but in multi-job workflows, `needs` is used when one job depends on another job.

Example:

```yaml
needs: build
```

Meaning:

```text
Run this job only after the build job finishes.
```

---

# End of Notes

Alhamdulillah, Task 4 covers an important GitHub Actions concept: **conditionals**.

These are very useful in real CI/CD pipelines because they help control when jobs and steps should run.
