# Day 45 of My DevOps Learning Journey

Today I worked on an important real-world DevOps topic: **Docker Build and Push using GitHub Actions**.

The main goal of today’s task was to create a complete CI/CD pipeline where code pushed to GitHub automatically builds a Docker image and pushes it to Docker Hub without manual steps.

In this hands-on practice, I worked on:

* Creating a simple Docker application using Nginx
* Writing a Dockerfile to serve an HTML page
* Testing the Docker image locally using browser and curl
* Creating a GitHub Actions workflow to build the Docker image in CI
* Logging in to Docker Hub securely using GitHub Secrets
* Tagging the Docker image with both `latest` and `sha-<short-commit-hash>`
* Pushing the image to Docker Hub automatically
* Adding a condition so Docker images are pushed only from the `main` branch
* Testing a feature branch to confirm the image builds but does not push
* Adding a GitHub Actions status badge to the README
* Pulling the image from Docker Hub and running it locally

The most important concept I learned today was the full CI/CD journey:

```text
git push
→ GitHub Actions workflow starts
→ Repository code is checked out
→ Docker image is built
→ Image is tagged
→ Docker Hub login happens using secrets
→ Image is pushed to Docker Hub
→ Image is pulled on a local machine or server
→ Container is started
→ Application runs successfully
```

This task helped me understand how real production pipelines work. Developers do not manually build and push images every time. Instead, CI/CD pipelines automate the process, reduce human error, and make deployments more consistent.

I also learned why it is important to build on all branches but push only from the `main` branch. This keeps the pipeline safe because feature branches can validate the Docker build without publishing incomplete images to Docker Hub.

Day 45 was a strong practical step in understanding Docker, GitHub Actions, Docker Hub, image tagging, secrets, and CI/CD automation.

Let's learn together and grow

#90DaysOfDevOps\
#DevOpsKaJosh\
#TrainWithShubham

Happy Learning! TrainWithShubham

