# Day 52 of my DevOps learning journey: Kubernetes Namespaces and Deployments

Today I continued learning Kubernetes and focused on two important concepts: **Namespaces** and **Deployments**.

Namespaces help organize Kubernetes resources inside a cluster. Instead of putting everything in the default namespace, we can separate workloads based on environment or purpose.

For example:

* `dev`
* `staging`
* `production`

This makes the cluster cleaner, easier to manage, and closer to how real-world teams organize applications.

I also learned about Kubernetes Deployments.

A Deployment is used to manage application pods in a reliable way. Instead of creating pods manually, a Deployment controls how many replicas should run and makes sure the desired state is maintained.

In today’s hands-on practice, I worked on:

* Checking existing namespaces
* Creating custom namespaces
* Deploying applications inside specific namespaces
* Understanding Deployments
* Scaling applications
* Performing rolling updates
* Testing rollback behavior
* Cleaning up Kubernetes resources

One of the most important lessons I learned today is that Kubernetes focuses on desired state.

We define what we want, and Kubernetes works to maintain that state.

For example, if a pod fails, the Deployment can automatically create a new one. This self-healing behavior is one of the reasons Kubernetes is so powerful.

Day 52 helped me understand how Kubernetes organizes applications and keeps them running reliably.

Step by step, Kubernetes concepts are becoming clearer.

Let's learn together and grow

#90DaysOfDevOps
#DevOpsKaJosh
#TrainWithShubham

Happy Learning! TrainWithShubham


