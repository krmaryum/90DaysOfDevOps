# SDK (Software Development Kit)

## What is an SDK?

SDK stands for Software Development Kit.

An SDK is a collection of tools, libraries, APIs, documentation, and utilities that help developers build applications for a specific platform or technology.

Think of it as:

> Everything needed to develop software for a platform.

---

# Common SDK Examples

| SDK | Purpose |
|---|---|
| Android SDK | Build Android applications |
| AWS SDK | Interact with AWS services |
| Docker SDK | Manage Docker programmatically |
| Java SDK (JDK) | Build Java applications |

---

# What Does an SDK Include?

An SDK usually contains:

- APIs
- Libraries
- Command-line tools
- Documentation
- Debugging tools
- Sample code

---

# SDK vs API

| API | SDK |
|---|---|
| Interface for communication | Complete development toolkit |
| Smaller scope | Larger package |
| Defines interactions | Includes APIs plus tools and utilities |

Simple understanding:

```text
SDK = APIs + tools + documentation + utilities
```

---

# Docker SDK Example (Python)

Install Docker SDK for Python:

```bash
pip install docker
```

Python example:

```python
import docker

client = docker.from_env()
containers = client.containers.list()

for c in containers:
    print(c.name)
```

This allows Python programs to communicate with Docker Engine.

---

# SDKs in DevOps and Cloud

Common SDKs used in DevOps:

- AWS SDK
- Azure SDK
- Google Cloud SDK
- Kubernetes SDK
- Docker SDK
- Terraform SDK

These SDKs help automate infrastructure and cloud operations programmatically.

---

# Summary

An SDK is a complete toolkit used to build applications for a platform or technology.

It typically includes:
- APIs
- libraries
- tools
- documentation
- utilities

SDKs make software development and automation easier and faster.
