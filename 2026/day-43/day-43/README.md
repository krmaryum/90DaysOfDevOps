Day 43 of my DevOps learning journey: Jobs, Steps, Environment Variables, Outputs, and Conditionals in GitHub Actions

Today I focused on controlling the flow of GitHub Actions workflows.

This was an important day because real CI/CD pipelines are not just a list of commands. They need proper structure, job dependencies, variables, outputs, conditions, and verification.

In today’s hands-on practice, I worked on:

1. Multi-job workflow

I created a workflow with three jobs:

build → test → deploy

I learned how to use `needs:` to control job order so that the test job runs only after build succeeds, and deploy runs only after test succeeds.

2. Environment variables

I practiced environment variables at three levels:

* Workflow level
* Job level
* Step level

I also printed GitHub context values such as commit SHA, actor, branch name, repository name, workflow name, event name, runner OS, and runner architecture.

3. Job outputs

I created one job that generated today’s date and passed it to another job using:

`$GITHUB_OUTPUT`

`outputs:`

`needs.<job-name>.outputs.<output-name>`

This helped me understand how jobs can share small values even when they run on separate runner environments.

4. Conditionals

I practiced conditional execution using `if:`.

I created:

* A step that runs only on the main branch
* A step that runs only when a previous step fails
* A job that runs only on push events
* A step using `continue-on-error: true`

This helped me understand how real pipelines control what should run and when.

5. Smart pipeline

Finally, I combined everything into one workflow.

I created a smart pipeline with:

* A lint job
* A test job
* A summary job

The lint and test jobs ran in parallel, and the summary job waited for both using:

`needs: [lint, test]`

The summary job printed whether the push was from the main branch or a feature branch and also printed the commit message.

Today’s key learning:

GitHub Actions workflows become powerful when we understand how jobs, steps, outputs, environment variables, and conditions work together.

Alhamdulillah, Day 43 completed successfully.

Let's learn together and grow

#90DaysOfDevOps
#DevOpsKaJosh
#TrainWithShubham

Happy Learning! TrainWithShubham
