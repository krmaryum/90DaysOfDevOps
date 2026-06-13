Today I completed **Day 40 of my 90 Days of DevOps journey**.

## Topic

**Your First GitHub Actions Workflow**

Today was an important milestone because CI/CD started becoming more practical for me. Instead of only reading about pipelines, I created my first GitHub Actions workflow and watched it run in the cloud.

## What I Practiced Today

I created a new GitHub repository called:

```text
github-actions-practice
```

Then I created the required GitHub Actions folder structure:

```text
.github/workflows/
```

After that, I created my first workflow file:

```text
.github/workflows/hello.yml
```

My workflow was triggered on every push, had one job called `greet`, ran on `ubuntu-latest`, checked out the repository code using `actions/checkout@v4`, and printed:

```text
Hello from GitHub Actions!
```

## GitHub Actions Keys I Learned

I also learned the meaning of important GitHub Actions keys:

```text
on:
jobs:
runs-on:
steps:
uses:
run:
name:
```

## More Steps Added

Then I added more useful steps to print:

```text
Current date and time
Branch name
Full commit ID
Short commit ID
Repository files
Runner operating system
```

## Breaking the Pipeline on Purpose

The most useful part was intentionally breaking the pipeline using:

```bash
exit 1
```

This helped me understand what a failed pipeline looks like, how GitHub Actions shows errors, and how to read the logs inside a failed job.

The error showed:

```text
Process completed with exit code 1.
```

After understanding the failure, I fixed the workflow, pushed again, and the pipeline turned green.

## Key Learning

A green pipeline means the workflow completed successfully.

A red pipeline means something failed, and the best place to investigate is inside the failed job logs.

Today I learned that GitHub Actions is not just YAML. It is a practical automation system that helps developers test, build, and deploy code with confidence.

Day 40 completed successfully.

Detailed scripts and notes are documented in my GitHub repository.



Let's learn together and grow

#90DaysOfDevOps
#DevOpsKaJosh
#TrainWithShubham

Happy Learning! TrainWithShubham


