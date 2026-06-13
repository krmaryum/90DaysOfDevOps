# Day 42 of My DevOps Learning Journey: Runners in GitHub Actions

Today I learned one of the most important concepts in GitHub Actions: **runners**.

A runner is the machine where a GitHub Actions job actually runs. Without a runner, a workflow has no environment to execute commands.

In today’s hands-on practice, I worked on both **GitHub-hosted** and **self-hosted** runners.

## GitHub-Hosted Runners

First, I created a workflow using GitHub-hosted runners and ran three jobs on different operating systems:

- Ubuntu
- Windows
- macOS

Each job printed the OS details, hostname, and current user.

This helped me understand how GitHub provides temporary machines for workflow jobs.

## Pre-installed Tools

Next, I explored what tools are already pre-installed on the `ubuntu-latest` runner.

I checked versions of:

- Docker
- Python
- Node.js
- Git

This showed me why pre-installed tools are useful in CI/CD pipelines because they save time and reduce extra installation steps.

## Self-Hosted Runner Setup

The main hands-on part was setting up my own self-hosted runner on an EC2 Linux machine.

I registered the runner with my GitHub repository, started it, and verified that it appeared as `Idle` with a green status in GitHub.

Then I created a workflow using:

```yaml
runs-on: self-hosted
```

The workflow successfully ran on my EC2 machine.

It printed:

- My VM hostname
- The working directory
- A test file created by the workflow
- Verification that the file existed on the runner machine

## Runner Labels

I also practiced runner labels by adding a custom label and targeting the runner using:

```yaml
runs-on: [self-hosted, my-linux-runner]
```

This helped me understand how labels are useful when multiple self-hosted runners are available.

Labels allow us to select the correct runner based on:

- Operating system
- Tools
- Environment
- Purpose

## Key Learnings from Day 42

- GitHub-hosted runners are managed by GitHub.
- Self-hosted runners are managed by us.
- Every job needs a runner.
- `runs-on` decides where the job will execute.
- Self-hosted runners provide more control but also require more responsibility.
- Labels help target the correct self-hosted runner.

## Final Reflection

This was a very practical day because I did not just read about runners; I actually connected my own EC2 machine with GitHub Actions and ran a workflow on it.

Step by step, I am building a stronger understanding of CI/CD and real DevOps workflows.
