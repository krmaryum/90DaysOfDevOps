# Day 41 of My DevOps Learning Journey: Triggers & Matrix Builds in GitHub Actions

Today I learned different ways to trigger GitHub Actions workflows and how to run jobs across multiple environments using matrix builds.

In this hands-on practice, I worked on:

## 1. Pull Request Trigger

I created a workflow that runs automatically when a pull request is opened, updated, or reopened against the `main` branch.

This helped me understand how teams use automated checks before merging code into the main branch.

## 2. Scheduled Trigger

I created a scheduled workflow using cron syntax.

I learned that GitHub Actions scheduled workflows use UTC time, not local machine time.

Cron expression for every day at midnight UTC:

0 0 * * *

Cron expression for every Monday at 9 AM UTC:

0 9 * * 1

## 3. Manual Trigger

I created a workflow using `workflow_dispatch`.

This allowed me to manually run the workflow from the GitHub Actions UI and select an environment input such as `staging` or `production`.

## 4. Matrix Builds

I created a matrix workflow to test multiple Python versions:

- Python 3.10
- Python 3.11
- Python 3.12

Then I extended the matrix with two operating systems:

- `ubuntu-latest`
- `windows-latest`

This created 6 total jobs:

3 Python versions × 2 operating systems = 6 jobs

## 5. Exclude and Fail-Fast

I learned how to exclude a specific matrix combination, such as Windows with Python 3.10.

I also tested `fail-fast: false` by intentionally failing one job and observing that the remaining matrix jobs continued running.

## Key Learning

`fail-fast: true` means GitHub Actions may cancel remaining matrix jobs when one job fails.

`fail-fast: false` means other matrix jobs continue running even if one job fails.

I also faced and fixed a small but important typo issue where I wrote:

3,11

instead of:

3.11

This caused `actions/setup-python` to fail because `3,11` is not a valid Python version.

This was a very practical day because I learned how real CI/CD pipelines handle pull requests, schedules, manual approvals, testing across multiple environments, and failure behavior.

GitHub Actions is becoming clearer day by day through hands-on practice.

Let's learn together and grow

#90DaysOfDevOps  
#DevOpsKaJosh  
#TrainWithShubham  

Happy Learning! TrainWithShubham