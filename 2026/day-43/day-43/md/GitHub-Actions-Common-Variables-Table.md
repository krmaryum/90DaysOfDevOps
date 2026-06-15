# Easy Memory Trick

| Context           | Use When                                                   |
| ----------------- | ---------------------------------------------------------- |
| `${{ github.* }}` | GitHub information (repo, branch, commit, actor, workflow) |
| `${{ runner.* }}` | Runner information (OS, architecture, temp directory)      |
| `$GITHUB_*`       | Inside shell scripts (`run:` blocks)                       |
| `$RUNNER_*`       | Runner variables inside shell scripts                      |


Example:
```yml
steps:
  - name: Show workflow information
    run: |
      echo "Repository: $GITHUB_REPOSITORY"
      echo "Branch: $GITHUB_REF_NAME"
      echo "Commit: ${GITHUB_SHA::7}"
      echo "Runner OS: $RUNNER_OS"
```


| Purpose             | GitHub Actions Context Syntax    | Environment Variable Syntax | Example Output                     | Meaning                                                  |
| ------------------- | -------------------------------- | --------------------------- | ---------------------------------- | -------------------------------------------------------- |
| Branch or tag name  | `${{ github.ref_name }}`         | `$GITHUB_REF_NAME`          | `main`                             | Shows the branch or tag name that triggered the workflow |
| Full Git reference  | `${{ github.ref }}`              | `$GITHUB_REF`               | `refs/heads/main`                  | Shows the full Git ref path                              |
| Full commit ID      | `${{ github.sha }}`              | `$GITHUB_SHA`               | `3129f93abc...`                    | Shows the commit SHA that triggered the workflow         |
| Short commit ID     | Not directly available           | `${GITHUB_SHA::7}`          | `3129f93`                          | Shows first 7 characters of commit SHA using Bash        |
| Repository name     | `${{ github.repository }}`       | `$GITHUB_REPOSITORY`        | `krmaryum/github-actions-practice` | Shows owner and repository name                          |
| Repository owner    | `${{ github.repository_owner }}` | `$GITHUB_REPOSITORY_OWNER`  | `krmaryum`                         | Shows the owner of the repository                        |
| Workflow name       | `${{ github.workflow }}`         | `$GITHUB_WORKFLOW`          | `Hello Workflow`                   | Shows the workflow name                                  |
| Job name            | `${{ github.job }}`              | `$GITHUB_JOB`               | `greet`                            | Shows the current job ID                                 |
| Run ID              | `${{ github.run_id }}`           | `$GITHUB_RUN_ID`            | `1234567890`                       | Unique ID for the workflow run                           |
| Run number          | `${{ github.run_number }}`       | `$GITHUB_RUN_NUMBER`        | `6`                                | Number of workflow runs for this workflow                |
| Actor/user          | `${{ github.actor }}`            | `$GITHUB_ACTOR`             | `krmaryum`                         | Shows who triggered the workflow                         |
| Event name          | `${{ github.event_name }}`       | `$GITHUB_EVENT_NAME`        | `push`                             | Shows which event triggered the workflow                 |
| Workspace path      | `${{ github.workspace }}`        | `$GITHUB_WORKSPACE`         | `/home/runner/work/...`            | Shows working directory on runner                        |
| Runner OS           | `${{ runner.os }}`               | `$RUNNER_OS`                | `Linux`                            | Shows runner operating system                            |
| Runner name         | `${{ runner.name }}`             | `$RUNNER_NAME`              | `GitHub Actions ...`               | Shows the runner name                                    |
| Runner architecture | `${{ runner.arch }}`             | `$RUNNER_ARCH`              | `X64`                              | Shows CPU architecture                                   |
| Runner temp folder  | `${{ runner.temp }}`             | `$RUNNER_TEMP`              | `/home/runner/work/_temp`          | Temporary directory for runner                           |
| Runner tool cache   | `${{ runner.tool_cache }}`       | `$RUNNER_TOOL_CACHE`        | `/opt/hostedtoolcache`             | Directory where tools are cached                         |
