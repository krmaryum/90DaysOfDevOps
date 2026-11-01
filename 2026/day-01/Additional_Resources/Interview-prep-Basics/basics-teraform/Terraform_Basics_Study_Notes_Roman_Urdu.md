# Terraform Basics — Study Notes

## 1. Terraform kya hai?

**Terraform** HashiCorp ka ek **Infrastructure as Code (IaC)** tool hai.

Iski madad se hum AWS, Azure, GCP, Kubernetes aur doosre platforms ka infrastructure manually console se banane ke bajaye **code ke through create, modify aur manage** kar sakte hain.

### Simple definition

> Terraform aik IaC tool hai jo declarative configuration files use karke infrastructure ko provision aur manage karta hai.

---

## 2. Infrastructure as Code (IaC)

Infrastructure as Code ka matlab hai ke hum infrastructure ko manually create karne ke bajaye code mein define karte hain.

Example:

Manual method:

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

Terraform method:

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

## 3. Terraform ka basic flow

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

Example AWS ke liye:

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

## 4. Terraform configuration language

Terraform configuration files normally **`.tf`** extension use karti hain.

Terraform ki language ko **HCL — HashiCorp Configuration Language** kehte hain.

Example:

```hcl
resource "aws_instance" "web" {
  ami           = "ami-xxxxxxxx"
  instance_type = "t2.micro"
}
```

Yahan:

- `resource` = Terraform ko batata hai ke koi infrastructure object create/manage karna hai.
- `aws_instance` = AWS EC2 resource type.
- `web` = Terraform ke andar resource ka local naam.
- `ami` = EC2 image.
- `instance_type` = EC2 instance size.

---

## 5. Terraform declarative hai

Terraform **declarative** tool hai.

Iska matlab:

Hum Terraform ko batate hain:

> Mujhe final infrastructure kaisa chahiye.

Hum har manual step nahi batate.

Example:

```hcl
resource "aws_instance" "web" {
  instance_type = "t2.micro"
}
```

Terraform khud determine karta hai ke required infrastructure ko kis tarah create ya update karna hai.

---

# Important Terraform Commands

## 6. terraform init

```bash
terraform init
```

Purpose:

- Terraform project initialize karta hai.
- Required providers download karta hai.
- Modules download karta hai.
- Backend initialize karta hai.

Usually new Terraform project mein sab se pehla command:

```bash
terraform init
```

---

## 7. terraform fmt

```bash
terraform fmt
```

Terraform code ko proper formatting mein karta hai.

---

## 8. terraform validate

```bash
terraform validate
```

Terraform configuration ki syntax aur structure check karta hai.

---

## 9. terraform plan

```bash
terraform plan
```

Actual infrastructure change nahi karta.

Sirf preview deta hai ke Terraform:

- kya create karega
- kya modify karega
- kya delete karega

### Interview point

> `terraform plan` changes ko apply karne se pehle preview karta hai.

---

## 10. terraform apply

```bash
terraform apply
```

Terraform plan ke changes ko actual infrastructure par apply karta hai.

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

Terraform ke through managed infrastructure ko destroy/delete karta hai.

Production environment mein is command ko bohat carefully use karna chahiye.

---

# Terraform Workflow

## 12. Easy workflow

Yaad rakhein:

```text
WRITE
  ↓
PLAN
  ↓
APPLY
```

Commands:

```bash
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```

---

# Terraform Important Concepts

## 13. Provider

Provider Terraform aur kisi external platform ke darmiyan connection/interface hota hai.

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

Simple Roman Urdu:

> Provider Terraform ko batata hai ke kis platform ke API se baat karni hai.

---

## 14. Resource

Resource woh infrastructure object hota hai jo Terraform create ya manage karta hai.

Examples:

```text
EC2 instance
VPC
Subnet
S3 bucket
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

---

## 15. Variable

Variables values ko reusable aur dynamic banati hain.

Example:

```hcl
variable "instance_type" {
  default = "t2.micro"
}
```

Use:

```hcl
resource "aws_instance" "web" {
  instance_type = var.instance_type
}
```

Benefit:

Hard-coded values kam hoti hain.

---

## 16. Output

Output deployment ke baad useful information show karta hai.

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

---

## 17. Data Source

Data source existing infrastructure ya information ko read/fetch karta hai.

Simple difference:

```text
Resource    → Create / Manage
Data Source → Read existing information
```

---

## 18. Module

Module reusable Terraform code ka collection hota hai.

Example:

Agar har environment mein same VPC banana ho:

```text
Dev
QA
Prod
```

To same VPC code baar baar likhne ke bajaye module use kar sakte hain.

```text
Reusable Code
     ↓
   Module
     ↓
Dev / QA / Prod
```

---

# Terraform Project Structure

## 19. Common Terraform files

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

Normally resources define karta hai.

```hcl
resource "aws_instance" "web" {
  ami           = "ami-xxxxxxxx"
  instance_type = var.instance_type
}
```

### providers.tf

Provider configuration.

```hcl
provider "aws" {
  region = "us-east-1"
}
```

### variables.tf

Input variables.

```hcl
variable "instance_type" {
  default = "t2.micro"
}
```

### outputs.tf

Outputs.

```hcl
output "instance_id" {
  value = aws_instance.web.id
}
```

### terraform.tfvars

Variables ki actual values store kar sakta hai.

```hcl
instance_type = "t2.micro"
```

---

# Terraform State

## 20. terraform.tfstate

Terraform normally ek state file maintain karta hai:

```text
terraform.tfstate
```

State file Terraform ko track karne mein help karti hai ke Terraform code ka real infrastructure se kya relation hai.

Example:

```text
Terraform Code
      ↓
Terraform State
      ↓
AWS Real Resource
```

Terraform state compare karke determine karta hai ke next operation mein kya change karna hai.

---

## 21. State file ko manually edit kyun nahi karna chahiye?

State file Terraform ke infrastructure mapping ka important record hoti hai.

Manual edit se Terraform aur real infrastructure ke darmiyan mismatch ho sakta hai.

Isliye:

```text
terraform.tfstate
```

ko normally manually edit ya delete nahi karna chahiye.

---

## 22. Production mein remote state

Team environment mein local state ke bajaye **remote backend** use kiya jata hai.

AWS example:

```text
Terraform
   ↓
S3 Backend
   ↓
Shared State
```

Benefits:

- Central state
- Team collaboration
- Better backup
- State locking options
- Production safety

---

# Terraform vs Ansible

## 23. Simple difference

Easy interview understanding:

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
Configure App
Start Service
```

### Terraform

Usually:

- Infrastructure create karta hai
- Cloud resources manage karta hai
- IaC ke liye use hota hai

### Ansible

Usually:

- Servers configure karta hai
- Packages install karta hai
- Services configure/start karta hai
- Application configuration karta hai

Note:

Dono tools ki capabilities overlap kar sakti hain, lekin interview mein ye distinction samajhna useful hai.

---

# Terraform Basic AWS Example

## 24. Provider

```hcl
provider "aws" {
  region = "us-east-1"
}
```

## 25. Variable

```hcl
variable "instance_type" {
  default = "t2.micro"
}
```

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

## 27. Output

```hcl
output "instance_id" {
  value = aws_instance.web.id
}
```

---

# Terraform Lifecycle Example

Code likhein:

```text
main.tf
```

Initialize:

```bash
terraform init
```

Check formatting:

```bash
terraform fmt
```

Validate:

```bash
terraform validate
```

Preview:

```bash
terraform plan
```

Create infrastructure:

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

Roman Urdu:

> Terraform aik Infrastructure as Code tool hai jis se hum AWS, Azure ya doosre platforms ka infrastructure code ke through create aur manage karte hain.

---

## 29. What is a Terraform provider?

**Answer:**

A provider allows Terraform to communicate with the API of a platform such as AWS, Azure, GCP, or Kubernetes.

Roman Urdu:

> Provider Terraform aur cloud platform ke API ke darmiyan communication karta hai.

---

## 30. What is a Terraform resource?

**Answer:**

A resource is an infrastructure object managed by Terraform, such as an EC2 instance, VPC, subnet, or S3 bucket.

---

## 31. What does terraform plan do?

**Answer:**

`terraform plan` previews the changes Terraform intends to make without applying them.

---

## 32. What does terraform apply do?

**Answer:**

`terraform apply` creates or modifies the actual infrastructure according to the Terraform configuration.

---

## 33. What is Terraform state?

**Answer:**

Terraform state keeps track of the relationship between Terraform configuration and real infrastructure resources.

---

## 34. Why should we not manually edit terraform.tfstate?

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

Provider = Kis platform se baat karni hai

Resource = Kya create/manage karna hai

Variable = Dynamic/reusable value

Output = Deployment result show karna

Data Source = Existing information read karna

Module = Reusable Terraform code

State = Terraform ka infrastructure record

terraform init = Initialize

terraform plan = Preview

terraform apply = Execute

terraform destroy = Delete managed infrastructure
```

---

## Golden Rule

```text
WRITE → PLAN → APPLY
```

Aur production mein:

```text
PLAN ko carefully review karo
        ↓
APPLY karo
        ↓
STATE ko safely manage karo
```
