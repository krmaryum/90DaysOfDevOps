# Terraform Init Command

## What is `terraform init`?

`terraform init` is the command used to initialize a Terraform project.

------------------------------------------------------------------------

## Simple Explanation

It answers the question:

> "Prepare my project so Terraform can run"

------------------------------------------------------------------------

## What it does

-   Downloads required providers (e.g., AWS, local)
-   Sets up backend (local or remote state)
-   Downloads modules (if used)
-   Creates `.terraform/` directory
-   Generates `.terraform.lock.hcl` file

------------------------------------------------------------------------

## Example

Running:

``` bash
terraform init
```

Example output:

    Initializing the backend...
    Initializing provider plugins...
    - Installing hashicorp/aws...
    - Installed successfully

------------------------------------------------------------------------

## What it does NOT do

-   Does not create resources\
-   Does not validate configuration\
-   Does not show execution plan

------------------------------------------------------------------------

## When to use

Run `terraform init`:

-   First time in a project\
-   After adding a provider\
-   After adding modules\
-   After changing backend

------------------------------------------------------------------------

## Workflow

``` bash
terraform init
terraform validate
terraform plan
terraform apply
```

------------------------------------------------------------------------

## Key Takeaway

-   `terraform init` = setup project\
-   Must be run before other Terraform commands
