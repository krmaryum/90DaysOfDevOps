# Terraform Basics — Study Notes

## 1. What is Terraform?

**Terraform** is an **Infrastructure as Code (IaC)** tool developed by HashiCorp.

It allows you to create, modify, and manage infrastructure on platforms such as AWS, Azure, GCP, Kubernetes, and others by using code instead of manually creating resources through a console.

### Simple Definition

> Terraform is an Infrastructure as Code tool used to provision and manage infrastructure using declarative configuration files.

---

## 2. What is Infrastructure as Code (IaC)?

Infrastructure as Code means defining and managing infrastructure using code rather than creating servers, networks, storage, and cloud resources manually.

### Manual Method

```text
AWS Console
   ↓
EC2
   ↓
Launch Instance
   ↓
Settings
   ↓
Create
```

### Terraform Method

```text
Terraform Code (.tf)
   ↓
terraform plan
   ↓
terraform apply
   ↓
AWS EC2 Created
```

---

## 3. Basic Terraform Flow

```text
Terraform Code (.tf)
        ↓
Terraform
        ↓
Provider
        ↓
Cloud API
        ↓
Infrastructure
```

AWS example:

```text
Terraform
   ↓
AWS Provider
   ↓
AWS API
   ↓
EC2 / VPC / S3
```

---

## 4. Terraform Configuration Language

Terraform configuration files usually use the **`.tf`** extension.

Terraform uses **HCL — HashiCorp Configuration Language**.

Example:

```hcl
resource "aws_instance" "web" {
  ami           = "ami-xxxxxxxx"
  instance_type = "t2.micro"
}
```

Explanation:

- `resource` = tells Terraform that an infrastructure object should be created or managed.
- `aws_instance` = AWS EC2 resource type.
- `web` = local Terraform name for the resource.
- `ami` = Amazon Machine Image.
- `instance_type` = EC2 instance size/type.

---

## 5. Terraform is Declarative

Terraform is a **declarative** tool.

This means:

> You tell Terraform what the final infrastructure should look like.

You do not have to define every manual step required to create it.

Example:

```hcl
resource "aws_instance" "web" {
  instance_type = "t2.micro"
}
```

Terraform determines how to create or update the required infrastructure.

---

# Important Terraform Commands

## 6. terraform init

```bash
terraform init
```

This command:

- Initializes the Terraform project.
- Downloads required providers.
- Downloads modules.
- Initializes the backend.

It is normally the first command you run in a new Terraform project.

---

## 7. terraform fmt

```bash
terraform fmt
```

Formats Terraform code into a clean and consistent style.

---

## 8. terraform validate

```bash
terraform validate
```

Checks whether the Terraform configuration is syntactically and structurally valid.

---

## 9. terraform plan

```bash
terraform plan
```

This command does not make actual infrastructure changes.

It shows a preview of what Terraform intends to:

- Create
- Modify
- Delete

### Interview Point

> `terraform plan` previews proposed infrastructure changes before they are applied.

---

## 10. terraform apply

```bash
terraform apply
```

Applies the Terraform configuration to the real infrastructure.

Example:

```text
Terraform Code
   ↓
terraform apply
   ↓
AWS API
   ↓
EC2 Created
```

---

## 11. terraform destroy

```bash
terraform destroy
```

Deletes infrastructure managed by Terraform.

This command should be used very carefully in production environments.

---

# Terraform Workflow

## 12. Easy Workflow to Remember

```text
WRITE
  ↓
PLAN
  ↓
APPLY
```

Common command flow:

```bash
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```

---

# Important Terraform Concepts

## 13. Provider

A provider allows Terraform to communicate with an external platform or API.

Examples:

```text
AWS Provider
Azure Provider
Google Cloud Provider
Kubernetes Provider
```

AWS example:

```hcl
provider "aws" {
  region = "us-east-1"
}
```

Simple meaning:

> A provider tells Terraform which platform or API it needs to communicate with.

---

## 14. Resource

A resource is an infrastructure object that Terraform creates or manages.

Examples:

```text
EC2 Instance
VPC
Subnet
S3 Bucket
Security Group
Load Balancer
```

Example:

```hcl
resource "aws_instance" "web" {
  ami           = "ami-xxxxxxxx"
  instance_type = "t2.micro"
}
```

Simple meaning:

> A resource is the infrastructure object Terraform creates or manages.

---

## 15. Variable

Variables make Terraform values reusable and dynamic.

Example:

```hcl
variable "instance_type" {
  default = "t2.micro"
}
```

Usage:

```hcl
resource "aws_instance" "web" {
  instance_type = var.instance_type
}
```

Benefit:

> You do not need to hard-code the same values repeatedly.

---

## 16. Output

Outputs display useful information after deployment.

Example:

```hcl
output "instance_id" {
  value = aws_instance.web.id
}
```

Possible output:

```text
instance_id = "i-0123456789abcdef"
```

Simple meaning:

> An output displays useful information after Terraform creates or modifies infrastructure.

---

## 17. Data Source

A data source reads information about existing infrastructure.

Simple difference:

```text
Resource    → Create / Manage
Data Source → Read existing information
```

---

## 18. Module

A module is a reusable collection of Terraform code.

Example:

If you need the same VPC configuration in:

```text
Dev
QA
Prod
```

you can create a module instead of writing the same code repeatedly.

```text
Reusable Code
     ↓
   Module
     ↓
Dev / QA / Prod
```

---

# Terraform Project Structure

## 19. Common Terraform Files

```text
terraform-project/
│
├── main.tf
├── providers.tf
├── variables.tf
├── outputs.tf
└── terraform.tfvars
```

### main.tf

Usually contains resource definitions.

```hcl
resource "aws_instance" "web" {
  ami           = "ami-xxxxxxxx"
  instance_type = var.instance_type
}
```

### providers.tf

Contains provider configuration.

```hcl
provider "aws" {
  region = "us-east-1"
}
```

### variables.tf

Contains input variable definitions.

```hcl
variable "instance_type" {
  default = "t2.micro"
}
```

### outputs.tf

Contains output definitions.

```hcl
output "instance_id" {
  value = aws_instance.web.id
}
```

### terraform.tfvars

Can store actual values for variables.

```hcl
instance_type = "t2.micro"
```

---

# Terraform State

## 20. What is terraform.tfstate?

Terraform normally maintains a state file called:

```text
terraform.tfstate
```

The state file helps Terraform track the relationship between Terraform configuration and real infrastructure.

Flow:

```text
Terraform Code
      ↓
Terraform State
      ↓
Real Infrastructure
```

Terraform uses state to determine what changes are required during the next operation.

---

## 21. Why Should You Not Manually Edit the State File?

The state file contains important mappings between Terraform resources and real infrastructure.

Incorrect manual changes can cause Terraform to lose track of actual infrastructure.

Therefore:

```text
terraform.tfstate
```

should generally not be manually edited or deleted.

---

## 22. Remote State in Production

In team and production environments, remote state is often preferred over local state.

AWS example:

```text
Terraform
   ↓
S3 Backend
   ↓
Shared State
```

Benefits:

- Centralized state
- Team collaboration
- Better backup
- State locking options
- Safer infrastructure management

---

# Terraform vs Ansible

## 23. Simple Difference

For interview purposes:

```text
Terraform = Infrastructure Provisioning
Ansible   = Configuration Management
```

Example:

```text
Terraform
   ↓
Create EC2
Create VPC
Create Subnet
Create Security Group
   ↓
Ansible
   ↓
Install Apache
Configure Application
Start Services
```

### Terraform is commonly used for:

- Creating infrastructure
- Managing cloud resources
- Infrastructure as Code

### Ansible is commonly used for:

- Configuring servers
- Installing packages
- Managing services
- Configuring applications

Note:

> Terraform and Ansible can overlap in some areas, but this distinction is useful for learning and interviews.

---

# Basic AWS Terraform Example

## 24. Provider

```hcl
provider "aws" {
  region = "us-east-1"
}
```

Meaning:

> Terraform will work with AWS in the `us-east-1` region.

---

## 25. Variable

```hcl
variable "instance_type" {
  default = "t2.micro"
}
```

Meaning:

> The default EC2 instance type is `t2.micro`.

---

## 26. EC2 Resource

```hcl
resource "aws_instance" "web" {
  ami           = "ami-xxxxxxxx"
  instance_type = var.instance_type

  tags = {
    Name = "terraform-demo"
  }
}
```

---

## 27. Output

```hcl
output "instance_id" {
  value = aws_instance.web.id
}
```

---

# Terraform Lifecycle Example

Write the Terraform code:

```text
main.tf
```

Initialize:

```bash
terraform init
```

Format:

```bash
terraform fmt
```

Validate:

```bash
terraform validate
```

Preview changes:

```bash
terraform plan
```

Create or modify infrastructure:

```bash
terraform apply
```

Delete lab infrastructure:

```bash
terraform destroy
```

---

# Important Interview Questions

## 28. What is Terraform?

**Answer:**

Terraform is an Infrastructure as Code tool used to provision and manage infrastructure using declarative configuration files.

---

## 29. What is a Terraform Provider?

**Answer:**

A provider allows Terraform to communicate with the API of a platform such as AWS, Azure, GCP, or Kubernetes.

---

## 30. What is a Terraform Resource?

**Answer:**

A resource is an infrastructure object managed by Terraform, such as an EC2 instance, VPC, subnet, or S3 bucket.

---

## 31. What Does terraform plan Do?

**Answer:**

`terraform plan` previews the changes Terraform intends to make without applying them.

---

## 32. What Does terraform apply Do?

**Answer:**

`terraform apply` creates or modifies the actual infrastructure according to the Terraform configuration.

---

## 33. What is Terraform State?

**Answer:**

Terraform state keeps track of the relationship between Terraform configuration and real infrastructure resources.

---

## 34. Why Should We Not Manually Edit terraform.tfstate?

Because incorrect manual changes can break the mapping between Terraform code and real infrastructure.

---

# Quick Revision

```text
Terraform
   ↓
Infrastructure as Code
   ↓
.tf Files / HCL
   ↓
Provider
   ↓
Resource
   ↓
terraform init
   ↓
terraform plan
   ↓
terraform apply
   ↓
State
```

---

# One-Line Memory Notes

```text
Terraform = Infrastructure as Code

Provider = Which platform Terraform communicates with

Resource = What Terraform creates or manages

Variable = Reusable/dynamic value

Output = Displays deployment information

Data Source = Reads existing information

Module = Reusable Terraform code

State = Terraform's infrastructure record

terraform init = Initialize

terraform plan = Preview

terraform apply = Execute changes

terraform destroy = Delete managed infrastructure
```

---

## Golden Rule

```text
WRITE → PLAN → APPLY
```

For production:

```text
Review PLAN carefully
        ↓
Run APPLY
        ↓
Manage STATE safely
```
