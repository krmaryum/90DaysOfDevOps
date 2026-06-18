Day 44 of my DevOps learning journey: Secrets, Artifacts, Real Tests, and Caching in GitHub Actions

Today I worked on some very important real-world CI/CD concepts in GitHub Actions.

Until now, many workflows were focused on learning the basics: jobs, steps, variables, conditions, and workflow structure. Day 44 was different because the pipeline started doing more practical DevOps work.

I learned how to use GitHub Secrets to store sensitive values securely. I created repository secrets and used them inside workflows without exposing the real values in logs. I also verified that GitHub masks secrets automatically when they are printed, but the best practice is still to never print secrets intentionally.

I practiced passing secrets as environment variables using the `env:` block. This helped me understand how CI/CD pipelines safely use credentials for tools like DockerHub, AWS, Terraform, Ansible, and Kubernetes.

I also learned about artifacts in GitHub Actions. I created a report file during a workflow run and uploaded it using:

```yaml
uses: actions/upload-artifact@v4
```

After the workflow completed, I downloaded the artifact from the GitHub Actions Summary page and verified the file content.

Then I practiced downloading artifacts between jobs. Job 1 generated and uploaded a report file, and Job 2 downloaded that artifact and printed its contents. This helped me understand that each GitHub Actions job runs on a separate runner, so files do not automatically move from one job to another. Artifacts solve that problem.

Another important part of the day was running real tests in CI. I added a shell script to the repository and created a workflow to run it automatically. The script checked Linux system information and required commands. I intentionally broke the script by adding a fake command, verified that the pipeline turned red, then fixed it and confirmed that the pipeline turned green again.

This helped me understand how CI uses exit codes:

```text
0 = success
non-zero = failure
```

Finally, I learned how to use caching with:

```yaml
uses: actions/cache@v4
```

I cached Python pip dependencies from:

```text
~/.cache/pip
```

The first run did not find a cache, and later runs restored the cache successfully. I also learned that small projects may not show a big time difference, but cache is very useful in larger projects with many dependencies.

Key things I practiced today:

- GitHub Secrets
- Secret masking in workflow logs
- Secrets as environment variables
- Uploading artifacts
- Downloading artifacts between jobs
- Running real shell scripts in CI
- Understanding exit codes
- Breaking and fixing pipelines
- Caching dependencies with GitHub Actions

Day 44 helped me understand how GitHub Actions is used in real CI/CD pipelines, not just for printing messages but for handling secrets, saving build outputs, sharing files between jobs, running tests, and improving workflow performance.

Step by step, CI/CD is becoming much clearer.
Let's learn together and grow

#90DaysOfDevOps
#DevOpsKaJosh
#TrainWithShubham

Happy Learning! TrainWithShubham


