# Day 61 --- Terraform Introduction

## Table of Contents

| Task | Title                                                                                        | Summary                                                                                                                                                                  |
| ---- | -------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| 1    | [Infrastructure as Code (IaC)](#task-1-----infrastructure-as-code-iac)                       | Introduces IaC concepts, importance in DevOps, problems with manual setup, and comparison of Terraform with other tools. Covers declarative and cloud-agnostic concepts. |
| 2    | [Install Terraform and Configure AWS](#task-2-----install-terraform-and-configure-aws)       | Installation of Terraform and AWS CLI, configuring credentials, and verifying access to AWS services.                                                                    |
| 3    | [Your First Terraform Config (S3 Bucket)](#task-3-----your-first-terraform-config-s3-bucket) | Creation of an S3 bucket using Terraform. Introduces provider configuration and Terraform lifecycle commands.                                                            |
| 4    | [Add an EC2 Instance](#task-4-----add-an-ec2-instance)                                       | Extends Terraform config to provision an EC2 instance and demonstrates incremental infrastructure updates using state.                                                   |
| 5    | [Understand the State File](#task-5-----understand-the-state-file)                           | Explains Terraform state, how it tracks resources, and commands to inspect state. Covers best practices for handling state files.                                        |
| 6    | [Modify, Plan, and Destroy](#task-6-----modify-plan-and-destroy)                             | Demonstrates modifying infrastructure, understanding plan symbols, applying updates, and destroying resources safely.                                                    |

## Final Summary

| Section        | Details                                                                       |
| -------------- | ----------------------------------------------------------------------------- |
| Topic          | Terraform & Infrastructure as Code                                            |
| Key Concepts   | Providers, State, Lifecycle (init → plan → apply → destroy)                   |
| Practical Work | Created S3 bucket, EC2 instance, modified resources, destroyed infrastructure |
| Outcome        | Built a strong foundation in Terraform and real-world DevOps practices        |


In Day 60, you focused on deploying applications on Kubernetes and managing workloads inside a cluster .

Day 61 takes you one level deeper: instead of deploying applications, you now learn how to create the infrastructure itself.

This is where Terraform and Infrastructure as Code (IaC) come in.

## What This Day Is About

Up to now, you have worked with:

- Containers (Docker)
- CI/CD pipelines
- Kubernetes orchestration

Now the focus shifts to:

- Creating servers (EC2)
- Creating storage (S3)
- Defining infrastructure using code instead of manual setup

You will use Terraform to define and manage these resources.

## Objectives of Day 61

By the end of this day, you will:

- Understand Infrastructure as Code (IaC)
- Install Terraform
- Configure AWS CLI with credentials
- Create infrastructure using a .tf file
- Provision:
  - An S3 bucket
  - An EC2 instance
- Destroy infrastructure safely

### Conceptual Shift

| Previous (Day 60)         | Now (Day 61)               |
| ------------------------- | -------------------------- |
| Deploy apps on Kubernetes | Create infrastructure      |
| Use kubectl and YAML      | Use Terraform (.tf files)  |
| Manage pods and services  | Manage EC2, S3, networking |

This is a transition from:

Application layer → Infrastructure layer

## Task 1 --- Infrastructure as Code (IaC)

## Overview
Before using Terraform, you first build conceptual understanding.

## Objectives

1. What is Infrastructure as Code (IaC)?
2. Why IaC matters in DevOps
3. Problems with manual AWS console setup
4. Differences:
   - Terraform vs AWS CloudFormation
   - Terraform vs Ansible
   - Terraform vs Pulumi
5. Meaning of:
   - Declarative
   - Cloud-agnostic

### What is Infrastructure as Code (IaC)?

Infrastructure as Code (IaC) means managing infrastructure using
configuration files instead of manually setting things up through a
cloud console. Instead of clicking in AWS, we write code that defines
resources like servers, storage, and networks, and tools like Terraform
create them automatically.

IaC allows infrastructure to be created in a safe, consistent, and
repeatable way. It also enables version control, reuse, and
collaboration across teams.

------------------------------------------------------------------------

### Why IaC Matters in DevOps

In traditional setups:
- infrastructure creation is manual and slow
- involves multiple teams (admins, engineers)
- Delays and inconsistencies 

IaC improves this by:
- Automating infrastructure creation
- Reducing human errors 
- Making deployments faster 
- Allowing version control using Git 
- Ensuring consistency across environments

IaC aligns infrastructure management with DevOps practices like
automation and continuous delivery.

------------------------------------------------------------------------

### Problems with Manual AWS Console

Manually creating resources in AWS has several issues:

-   Slow and time-consuming
-   High chance of human error
-   Difficult to reproduce environments
-   No version control
-   Hard to track changes
-   Not scalable

IaC solves these problems by making infrastructure automated,
repeatable, and trackable.

------------------------------------------------------------------------

### Terraform vs Other Tools

#### Terraform vs AWS CloudFormation

-   Terraform supports multiple cloud providers
-   CloudFormation is limited to AWS

#### Terraform vs Ansible

-   Terraform is used for provisioning infrastructure
-   Ansible is used for configuration management

So:

- Terraform → creates resources
- Ansible → configures them

#### Terraform vs Pulumi

-   Terraform uses HCL (HashiCorp Configuration Language)
-   Pulumi uses programming languages like Python and JavaScript
-   Terraform is simpler and widely adopted

------------------------------------------------------------------------

### Declarative and Cloud-Agnostic

#### Declarative

Terraform is declarative, meaning:

You define the final desired state, not the steps.

Example:

- You write: “Create an EC2 instance”
- Terraform figures out:
   - API calls
   - dependencies
   - order of execution

Terraform follows an execution flow: init → plan → apply, where it initializes the project, creates an execution plan, and then applies the changes.

#### Cloud-Agnostic

Terraform is cloud-agnostic because:

- It works with AWS, Azure, GCP, etc.
- Same tool, different providers

This is possible because of providers, which act as plugins to connect Terraform to different platforms .

------------------------------------------------------------------------

### Key Concept: Terraform State

Terraform uses a state file to keep track of infrastructure. The state
acts like a mapping between the code and real-world resources. It helps
Terraform understand what already exists and what needs to be created,
updated, or deleted.

State is important for performance, dependency management, and
maintaining consistency.

Without state, Terraform would not know which resources it manages.

Overall, Infrastructure as Code transforms infrastructure management from a manual process into an automated, reliable, and scalable system.

---

## Task 2 --- Install Terraform and Configure AWS

### Overview

In this task, Terraform and AWS CLI were installed and configured to
enable provisioning infrastructure on AWS using code. This ensures that
the local environment can communicate with AWS services securely.

------------------------------------------------------------------------

### Objectives

-   Install Terraform on the system
-   Verify Terraform installation
-   Install AWS CLI
-   Configure AWS credentials using IAM user
-   Verify AWS access using CLI

------------------------------------------------------------------------

### Install Terraform (WSL Ubuntu)

Run these commands one by one:
```bash
sudo apt update
sudo apt install -y gnupg software-properties-common wget
```

```bash
wget -O - https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
```

```bash
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list
```

```bash
sudo apt update
sudo apt install terraform
```


Terraform was installed using the HashiCorp APT repository.

Verification command:

``` bash
terraform -version
```

Output:

``` bash
Terraform v1.14.8
on linux_arm64
```

This confirms Terraform is installed and working correctly.

[Terraform installation on Windows](md/terraform_installation_windows.md)


------------------------------------------------------------------------

### Install AWS CLI

AWS CLI was installed and verified using:

``` bash
aws --version
```
If NOT installed:
```bash
sudo apt install awscli -y
```
### Configure AWS CLI

Run:
```bash
aws configure
```
You’ll be prompted for:
```text
AWS Access Key ID:     <your-key>
AWS Secret Access Key: <your-secret>
Default region name:   ap-south-1   (or your region)
Default output format: json
```

These keys come from:

AWS IAM user (Programmatic access)

Output:

``` bash
aws-cli/2.34.19 Python/3.14.3 Linux/WSL2
```

------------------------------------------------------------------------

### Verify AWS Access

To confirm successful authentication, the following command was
executed:

``` bash
aws sts get-caller-identity
```

Output:

``` json
{
    "UserId": "***************",
    "Account": "************",
    "Arn": "arn:aws:iam::************:user/khalid"
}
```

This confirms that AWS CLI is correctly configured and can access the
AWS account.

------------------------------------------------------------------------

### Key Learning

-   Terraform requires valid AWS credentials to provision resources\
-   AWS CLI acts as a bridge between local system and AWS\
-   IAM users with programmatic access are required for Terraform\
-   Verifying access before provisioning prevents deployment errors

------------------------------------------------------------------------

### Conclusion

Task 2 was completed successfully. Terraform and AWS CLI are installed,
configured, and verified. The system is now ready to provision AWS
infrastructure using Terraform.

---

## Task 3 --- Your First Terraform Config (S3 Bucket)

### Overview

In this task, a basic Terraform configuration was created to provision
an AWS S3 bucket. This was the first practical step in using
Infrastructure as Code (IaC) to create real cloud resources.

------------------------------------------------------------------------

### Objectives

-   Create a Terraform project directory\
-   Write a Terraform configuration file\
-   Configure AWS provider\
-   Create an S3 bucket resource\
-   Run Terraform lifecycle commands\
-   Verify resource creation in AWS

------------------------------------------------------------------------

### Project Setup

``` bash
mkdir terraform-basics
cd terraform-basics
```

Created a Terraform configuration file:

``` bash
main.tf
```

------------------------------------------------------------------------

### Terraform Configuration

``` hcl

provider "aws" {
  region = "us-east-2"
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-buck-task-3"
}
```

------------------------------------------------------------------------

### Terraform Commands Used

``` bash
terraform init      # Download provider plugins and initialize project
terraform fmt       # Format Terraform code
terraform validate  # Check configuration syntax
terraform plan      # Preview infrastructure changes
terraform apply     # Create resources on AWS
```

[terraform init Explained](md/terraform_init.md)\
[terraform fmt Explained](md/terraform-fmt.md)\
[terraform validate Explained](md/terraform_validate.md)\
[terraform plan Explained](md/terraform_plan.md)\
[terraform apply Explained](md/terraform_apply.md)

------------------------------------------------------------------------

### Terraform Init Output

-   Downloaded AWS provider (`hashicorp/aws`)
-   Created `.terraform/` directory
-   Created `.terraform.lock.hcl`

------------------------------------------------------------------------

### Terraform Plan Result

``` bash
Plan: 1 to add, 0 to change, 0 to destroy.
```

------------------------------------------------------------------------

### Terraform Apply Result

``` bash
Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

This confirms that the S3 bucket was successfully created.

------------------------------------------------------------------------

### Verification

The S3 bucket was verified in the AWS S3 console, confirming that Terraform successfully created the resource.

------------------------------------------------------------------------

### Key Learning

-   Terraform uses providers to interact with cloud services
-   S3 bucket names must be globally unique and follow naming rules
-   Terraform workflow: init → plan → apply
-   `.terraform/` directory stores provider plugins and dependencies

------------------------------------------------------------------------

### What did terraform init download?

`terraform init` downloaded the AWS provider plugin (`hashicorp/aws`).
This plugin allows Terraform to communicate with AWS APIs and manage
resources.

------------------------------------------------------------------------

### What does the .terraform/ directory contain?

The `.terraform/` directory contains:

-   Provider plugins
-   Dependency files
-   Metadata required for Terraform execution

It acts as the working directory for Terraform.

------------------------------------------------------------------------

### Conclusion

Task 3 was completed successfully. A Terraform configuration was
written, executed, and verified by creating an S3 bucket on AWS using
Infrastructure as Code.

---

## Task 4 --- Add an EC2 Instance

### Overview

In this task, the existing Terraform configuration was extended to
provision an AWS EC2 instance. This demonstrates how Terraform can add
new resources while managing infrastructure as code.

------------------------------------------------------------------------

### Objectives

-   Add an EC2 instance resource to the configuration
-   Use a valid AMI for the selected region
-   Set instance type to `t2.micro` (as per task)
-   Add a Name tag
-   Run Terraform lifecycle commands
-   Verify the instance in AWS

Note: In actual execution, t3.micro was used instead of t2.micro.
------------------------------------------------------------------------

### Terraform Configuration (Simplified for Task)

[Detailed one](tf/ec2.tf)

``` hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-buck-task-3"
}

resource "aws_instance" "my_instance" {
  ami           = "ami-07062e2a343acc423"
  instance_type = "t2.micro"

  tags = {
    Name = "TerraWeek-Day1"
  }
}
```

------------------------------------------------------------------------

### Commands Used

``` bash
terraform fmt       # Format code
terraform validate  # Validate syntax
terraform plan      # Preview changes
terraform apply     # Create EC2 instance
```

------------------------------------------------------------------------

### Terraform Plan Result

``` bash
Plan: 1 to add, 0 to change, 0 to destroy.
```

------------------------------------------------------------------------

### Terraform Apply Result

``` bash
Apply complete! Resources: 1 added
```

------------------------------------------------------------------------

### Verification

The EC2 instance was verified in the AWS EC2 console:

-   Instance state: running
-   Instance type: t2.micro
-   Name tag: TerraWeek-Day1

SSH access was also successfully tested using the generated key pair.

------------------------------------------------------------------------

### Key Learning

-   Terraform allows incremental infrastructure updates
-   EC2 instances can be provisioned using simple configuration
-   Tags help identify resources in AWS
-   Terraform workflow remains consistent (init → plan → apply)

------------------------------------------------------------------------

### How Terraform Knows What to Create

Terraform uses a **state file (`terraform.tfstate`)** to track resources
it manages.

-   The state file records previously created resources (like the S3
    bucket)
-   During `terraform plan`, Terraform compares:
    -   configuration files
    -   state file
    -   actual AWS resources

If a resource already exists in the state and matches the configuration,
Terraform does not recreate it. Only new resources (like the EC2
instance) are added.

------------------------------------------------------------------------

### Important Note

If Terraform is run in a new directory, it will not have access to the
previous state file. In that case, Terraform will treat all resources as
new and attempt to create them again.

------------------------------------------------------------------------

### Conclusion

Task 4 was completed successfully. An EC2 instance was created using
Terraform, verified in AWS, and accessed via SSH.

---

## Task 5 --- Understand the State File

### Overview

In this task, the Terraform state file was explored to understand how
Terraform tracks and manages infrastructure. The state file acts as the
source of truth for all resources created by Terraform.

------------------------------------------------------------------------

### Objectives

-   Inspect the Terraform state file
-   Use Terraform state commands
-   Understand how Terraform tracks resources
-   Learn best practices for handling the state file

------------------------------------------------------------------------

### Commands Used

#### terraform show

``` bash
terraform show
```

Displays the current Terraform state in a human-readable format. It
shows all resources managed by Terraform along with their attributes
such as IDs, IP addresses, and configuration details.

------------------------------------------------------------------------

#### terraform state list

``` bash
terraform state list
```

Lists all resources that Terraform is currently managing.

Example:

``` bash
aws_default_vpc.default
aws_instance.my_instance
aws_key_pair.my_key_pair
aws_security_group.my_security_group
aws_vpc_security_group_egress_rule.allow_all_traffic
aws_vpc_security_group_ingress_rule.allow_http
aws_vpc_security_group_ingress_rule.allow_ssh
```

------------------------------------------------------------------------

#### terraform state show `<resource>`{=html}

``` bash
terraform state show aws_instance.my_instance
terraform state show aws_security_group.my_security_group
```

Displays detailed information about a specific resource stored in the
Terraform state, including IDs, configuration, and metadata.

------------------------------------------------------------------------

### What the State File Contains

The Terraform state file (`terraform.tfstate`) stores detailed
information about each resource, including:

-   Resource type and name
-   Resource IDs (e.g., instance ID, VPC ID)
-   Attributes (IP addresses, ARNs, configuration values)
-   Dependencies between resources
-   Metadata required for Terraform operations

It acts as a mapping between Terraform configuration and real
infrastructure.

------------------------------------------------------------------------

### Why You Should Never Manually Edit the State File

The state file should not be edited manually because:

-   It can easily become corrupted
-   It may cause Terraform to lose track of resources
-   Incorrect changes can lead to duplicate resources or accidental
    deletion
-   It may break future Terraform operations

------------------------------------------------------------------------

### Why the State File Should Not Be Committed to Git

The state file should not be committed to Git because:

-   It may contain sensitive information (IP addresses, resource IDs,
    metadata)
-   It can create conflicts when multiple users modify infrastructure
-   It is environment-specific and not reusable

In real-world scenarios, a remote backend (such as AWS S3) should be
used to store state securely.

### And add this to .gitignore:
```bash
echo "terra-automate-key" >> .gitignore
echo "*.tfstate" >> .gitignore
echo "*.tfstate.backup" >> ..gitignore
```

------------------------------------------------------------------------

### Key Learning

-   Terraform is state-driven
-   The state file is the source of truth
-   All Terraform operations depend on the state file
-   Proper handling of the state file is critical for reliable
    infrastructure management

------------------------------------------------------------------------

### Conclusion

Task 5 was completed successfully. The Terraform state file was explored
using various commands, and its role in tracking infrastructure was
clearly understood.

---

## Task 6 --- Modify, Plan, and Destroy

### Overview

In this task, an existing Terraform-managed EC2 instance was modified by
updating its tag. The Terraform plan was analyzed to understand change
symbols, the update was applied, and finally all infrastructure was
destroyed and verified.

------------------------------------------------------------------------

### Objectives

-   Modify an existing Terraform resource
-   Understand Terraform plan symbols (`+`, `-`, `~`)
-   Apply changes to infrastructure
-   Destroy all resources
-   Verify cleanup in AWS

These symbols help quickly understand what Terraform will do before applying changes.
------------------------------------------------------------------------

### Step 1 --- Modify EC2 Tag

The EC2 instance tag was changed from:

``` hcl
Name = "TerraWeek-Day1"
```

to:

``` hcl
Name = "TerraWeek-Modified"
```

------------------------------------------------------------------------

### Step 2 --- Terraform Plan

``` bash
terraform plan
```

Output:

    ~ update in-place

    ~ tags = {
        "Name" = "TerraWeek-Day1" -> "TerraWeek-Modified"
    }

    Plan: 0 to add, 1 to change, 0 to destroy.

------------------------------------------------------------------------

### Understanding Plan Symbols

-   `+` → Resource will be created
-   `-` → Resource will be destroyed
-   `~` → Resource will be updated in place

------------------------------------------------------------------------

### In-place Update

This was an in-place update because only the tag changed and Terraform
did not need to recreate the EC2 instance.

------------------------------------------------------------------------

### Step 3 --- Apply Changes

``` bash
terraform apply
```

Output:

    Apply complete! Resources: 0 added, 1 changed, 0 destroyed.

------------------------------------------------------------------------

### Step 4 --- Destroy Infrastructure (Task 4)

``` bash
terraform destroy
```

Output:

    Plan: 0 to add, 0 to change, 7 to destroy.
    Destroy complete! Resources: 7 destroyed.

------------------------------------------------------------------------

### Step 5 --- Destroy S3 Bucket (Task 3)

``` bash
cd ../task-3
terraform destroy
```

Output:

    Destroy complete! Resources: 1 destroyed.

<img src="./screenshots/Screenshot 2026-04-16 191316.png" width="400">

------------------------------------------------------------------------

### Verification

-   EC2 instance removed from AWS console\
-   S3 bucket removed from AWS console\
-   No remaining resources

------------------------------------------------------------------------

### Key Learning

-   Terraform detects changes using the state file
-   Tag updates result in in-place changes
-   `terraform plan` helps preview changes
-   State is tracked per directory
-   All resources must be destroyed to avoid costs

------------------------------------------------------------------------

### Conclusion

Task 6 was completed successfully. Infrastructure was modified, applied,
and destroyed using Terraform, demonstrating the full lifecycle of
infrastructure management.

---

## Final Summary

In Day 61, I learned how to use Terraform to provision, manage, modify, and destroy infrastructure on AWS using Infrastructure as Code. I gained hands-on experience with Terraform lifecycle commands, state management, and resource tracking, building a strong foundation for real-world DevOps practices.