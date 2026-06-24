# Day 46 – Reusable Workflows and Composite Actions in GitHub Actions

Today I completed Day 46 of my DevOps learning journey.

The focus of today’s practice was on one very important real-world DevOps concept: avoiding repeated workflow code in GitHub Actions.

In earlier tasks, I created workflows from scratch. But in real projects, teams usually do not copy the same CI/CD logic again and again. Instead, they create reusable workflows and composite actions.

## What I learned today

I learned how reusable workflows work using:

```yaml
on:
  workflow_call:
```

A reusable workflow can be called by another workflow, almost like calling a function in programming.

I created a reusable build workflow that accepts inputs such as:

```yaml
app_name
environment
```

I also learned how to pass secrets safely from a caller workflow into a reusable workflow without printing the actual secret value in the logs.

Then I created a caller workflow that triggered on push to the main branch and called the reusable workflow using:

```yaml
uses: ./.github/workflows/reusable-build.yml
```

One of the most important parts of today was learning how outputs work in reusable workflows.

I generated a build version like:

```text
v1.0-<short-sha>
```

Then I passed that value from the reusable workflow back to the caller workflow using this flow:

```text
Step output → Job output → Workflow output → Caller workflow
```

After that, I created my first custom composite action.

The composite action was created inside:

```text
.github/actions/setup-and-greet/action.yml
```

It accepted inputs, printed a greeting, printed the current date and runner OS, and returned an output called:

```text
greeted
```

## Key difference I learned

```text
Reusable Workflow = reusable full workflow
Composite Action = reusable group of steps
```

Another simple way to remember it:

```text
Reusable Workflow = jobs level
Composite Action = steps level
```

Reusable workflows are best when we want to reuse a full CI/CD process.

Composite actions are best when we want to reuse repeated steps inside a job.

## What I practiced

* Created a reusable workflow
* Used `workflow_call`
* Added workflow inputs
* Passed secrets safely
* Created a caller workflow
* Added reusable workflow outputs
* Used `needs` to read outputs in another job
* Created a custom composite action
* Used a local composite action in a workflow
* Compared reusable workflows and composite actions
* Documented everything in markdown
* Created a 25-question MCQ practice test for revision

This was a very useful day because reusable workflows and composite actions are commonly used in real DevOps teams to make CI/CD pipelines cleaner, consistent, and easier to maintain.

Let's learn together and grow

#90DaysOfDevOps\
#DevOpsKaJosh\
#TrainWithShubham

Happy Learning! TrainWithShubham


